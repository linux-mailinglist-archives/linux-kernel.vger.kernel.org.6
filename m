Return-Path: <linux-kernel+bounces-377045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D7E9AB921
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:55:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 384F51C233E8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 21:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6F681CF5F3;
	Tue, 22 Oct 2024 21:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b="dpKju/cB"
Received: from sonic312-26.consmr.mail.ir2.yahoo.com (sonic312-26.consmr.mail.ir2.yahoo.com [77.238.178.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242F11BD03C
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 21:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.178.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729634044; cv=none; b=itBGlPnhEHW5ZVfXyQFrr1s8vCUFOM3tS29MM5/8a4cviglZjVQ/+Z7ox/Gw0kHWjyC4ljhtlWhSuxWsctjJhqASI7LWPm7x7i9DJCzuly9bGiWfsN7wbpP6DwkRYG8LDguEq2ET2+aPgqmIR2F7LLc0mIWX7H3gqj6C/K9rQSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729634044; c=relaxed/simple;
	bh=vbrJ1XBIVyHDNv2Zv1kgFYq3t1Amn2hNz73l0cqqJxc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:References; b=hTQGrFAVjxDE8ZMCifvtQ0xESwMDM0M4pnlNbvjkmXwxSAUik2hkZKZkIgy3xHDWPFTrR3qSHTYnkC47pU/KO+AHT+FreAicap/sHQoe/xrOS0dTq/gI+XaG1HOV3EEmPcBWLNnkuDSfC3D9X0xSfAB5x77TIWxo+XIUXjrIGYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com; spf=pass smtp.mailfrom=rocketmail.com; dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b=dpKju/cB; arc=none smtp.client-ip=77.238.178.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rocketmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1729634040; bh=JMNlRzCgDYxTAmHWxKRK/+FCIfeMeIE1yrfGOvvhnxA=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=dpKju/cB+JEb0RfBwoLoizpMErWRreXE0A2vG/8FHdhtHygKxPJu7UfR/+qu37DGBhbryQMYOAxRdYBANBF0IhnwVW5IaDLEWnKuasm8BxFiTyXRhNIwrhFxeTd8l02xCmAdOCja1Uljj6P1pqbcYv++2+9VSUaPTqSYhwRYsniKVJ9LrGC3+3kHHI5tvrpqnHhwwnEGul7h6zOWyRkVCQ/yTFAx/aQpzYh7vfD2Ze1mWHYutdU084ddTqIQUweeMcnpP2heKAeGncZwnTOqvZ21VY8Il8bf707sGYIHhjimby3LSQ/vySvpwSROoW4juW9R3K8S6jhYh/4i0wLA8A==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1729634040; bh=GniLp8OJhPlTDoPJpGVkJ5VLgHupEsjqBaHhkxBscpH=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=DcUoDBADlGWlFVEcnqX7MZVDMdsy9TwgpD6aAUGHD1MRlpBZliyFEwEJY+9+sY01NCdvNcONb8ojkf+V3Gzwg9vXcAx+rccXbMRdqkI4sqHoXzd0Vv/ieKh4lyKeAh3brNNMSiQ03be005OqkMfrrn4/L63l26BzQo64bC3L20KVYM6JphqP8PTvmmsZPa70TLP2Dm8+Ss5UYqykukf1v1gpdnTWdLdL38p/ZhGGhPm9V5uB+KRba5VnOR7PA+cfW7w4fyUWbuN5PlfQEYyvVvCiJMLXQgpDnN8NF450R8p84l2tTmXD91Ae4iVWSug/KFGTURcAdMpPDxfdQTZTYQ==
X-YMail-OSG: hy3ZTRYVM1mSWALI_hUBZ0zxLJ_.HkO.LqazF0TP1YBbHlhW.rVY3uE9K42xfUX
 2g4kn5e4pXIUl9Ly.EdfHqPWUw5l1GuMnUvpinawkc2wCGDvrkCYYdl8MTw4loyITyjyb0DTWEkH
 YW378V1SL1oh8FXJBaNSVUrZvC5UZz8GXLVQEjteq89K8werRYFlJ_i3SWpPb6eOiOODRMUchNCw
 NTSzMiGRQoph00AQ6OhtuZvleYnTluDu_6y.lCH3IfC4MfSW7YzM3ZgO1zHeq8Fjb20i9Rmrq9TA
 NbMRkYFmkud49Xj4gOWXa7m_rPEa4WJk8F5BPyoEJ62mUcsMBqqQ6j01oB0HgwAd8tFvVEp99JIL
 ngJRqX79s0Dsi5ea5cZs_KH_Ke_Sow2isq8kHIVnEf4ZzGMtpM5JPTP.8wL4egXKfYh3nSdcdtko
 JiqxGCXURCsWE7am5LgjjsZsL6xEe1FnG5hwDBFYifyC6XDp9uxyNer1MTiXqObhZk0RpkSo0VBX
 72XEjjH8u8U16LKishfojSJrR7AubDNzq6YIeVrrIIffuY8Rnm7zcOrs1oqreROrqlJpp_ctg8g.
 4_BNpg7mN6z.pVFsHWI_g0QzbhW3uCFK08PtEaau.tYt7QVCmEf8UXD7peb0iSgJsGBaEsV5.YuR
 _DE860VcFr8uDhTrHbu7f0oU0h4STPYA_BOYhDxuSfB.v2qxPTMmcrgd_EdORpsXvln023Gxmakt
 hvzycT13Fs6YJZCx6TbFJf8O5eG16MNm5ywb8z3l2pRXciM8lmCTST6DKwtnRtEeKptqusLCffvR
 i.xEA36BFASJzxaUzD_TVyKE.85AIPMMud.ZZis.E1AIWS5emOu57iK41ms8sXbjxlWJu_OyCk7d
 Xfz1lb2meno3M62mCgjc0fzgpNd6oPE_2mm1QwCdLfNKBcuiKNukStBNLYHXqmvR8uHWSrJnx_bw
 fCrVbvmjFPP7D22N2LQmNl3_ZEDzwJDv.abcQuG0lLnecqi6sRoR_6722Fg13HM3I0qAy47RfAVn
 6iN9dy19cIjYF.rhIl5utOrRW1noyhpOKpBIBF2LIkhzfCcLqL3yaBT64jAhx1MehY_nAu5iEBhL
 o9dU4Rk2MX9Xtaew2C0I7d0LfuE6ZvsitRHdhXDemlqq6iRiHG3xm6lUoO.QnE49A51lur5QTzLf
 9vhJGTx3c7OJ6meH02Tk0dyOiW8nElJBiGxvjsKLZvkxFHEBh0fQUtRcPS_bteI8KoVZXUiWoaZ5
 _6mszcJit1QVS7P5zKt557ml1T84i.1tGdrCbDopvDy_tkWgAlQKGtVxcjK0rwXtnEc8UzXURECw
 yqD6i_vpLdW699E_KuiFjjXVcT2rn7miZdz23k3B8.peQBKxvLNkpxlsBIQXAZUqyE27u.8qzMGG
 Ed1wo8CjkBhJJvl.9nbLxpT8p9bKHfcEsMtR7goQkKoeE28vCDA0.JN0bXKma5eX2pJvzZTwc1rA
 Ngo5I1f_o60rhdBQ8TkDEDlO_lWDuMGdx1_Zf2wizN8I_xUe4YgOONdeTXn7li_xcutifJBZWhUq
 IeQCy3_SYdAYgfSWR5VS13WGpD5tzeP3dC2f2U_m5Sdw.K9ZDMDnQlWamR87La2sBopZGQxMqRp7
 fmEicC0ULssYMKsIugx5HU6NJuy8K8SppsA3cG9G.nkCrorz.hmSqiGrg2kyjJErBdC09qFL0Ebp
 twlRFk_110_mUDqpEEOLwJAMecsXgm2bsxR_N3b4VXOZ3_j9biH.X5gErMpDpikt8xm41YY2xR9n
 cfswIX4hcNATSGud7fKlp7l4Zzf9L690VKd2OJnxxjacYT4SC63mfMSuLBU1uTYdQO6An4NYdDiB
 9y4W8d3X0faQbM7AkdPSVvUvNUOlyd4pDRR7UNlRuVXWdxbGFbpiJsXjlOMa8Wt2nw.apysPONZX
 B1g1zaqcx_o9fgMnm2mefAimiOVano272X8MvNqliKmwfmoxwbD0vDeu4NmAX5jEiPQzW2lwWjZE
 _p2YYXDdfRzziO69qwi928YpTgDw83n4qr76dw.w2..NR_VpXXyzW1aSAC10Yo3Nyc.OpA6JyvXv
 fGEfTUw63JrtNrIuw1O5X95uhZlM6kV_Hgzogc2CW1A1hCBkNu6iegp20O2Zkj2eV_MszKxNU0Qk
 iiUvJ7bke4YLmQX60W1j7LzQTmbbpC4sEBu7WTEVi1gie3KExmUOyUUtUyESUJgfn0rWkuAUbRZE
 oGxhGolO2TUNLO_DF5575r0R9QabEHvbGQaLsQcdRyq5Sg9ln.nlaLxw4XAMNDPZAP3cwl.sr2aH
 zPik1dVOvujlFSTXPbVBKrAL5VnIn7oHaYbL5zS7wBC4-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: e7b7f317-ac75-45cd-b523-e90f89216074
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Tue, 22 Oct 2024 21:54:00 +0000
Received: by hermes--production-ir2-c694d79d9-qjs6q (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 00a5d0a4af66107c7c1614b6d685cac8;
          Tue, 22 Oct 2024 21:33:43 +0000 (UTC)
From: Jakob Hauser <jahau@rocketmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>,
	Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
	Andrzej Hajda <andrzej.hajda@intel.com>,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Jakob Hauser <jahau@rocketmail.com>
Subject: [PATCH v2 0/5] Add new panel driver Samsung S6E88A0-AMS427AP24
Date: Tue, 22 Oct 2024 23:33:34 +0200
Message-Id: <cover.1729630039.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <cover.1729630039.git.jahau.ref@rocketmail.com>

The patchset adds a new driver for Samsung AMS427AP24 panel with S6E88A0
controller. Patches are based on current branch drm-misc-next.

Changes in v2:
 - Patch 1: New patch to move the bt-bindings properties "flip-horizontal"
   and "flip-vertical" to "panel-common.yaml". File "samsung,s6e8aa0.yaml"
   needs to be changed accordingly.
 - Patch 2: Adapted property "flip-horizontal" to being moved to
   "panel-common.yaml".
 - Patch 3: Removed bool "prepared" from struct s6e88a0_ams427ap24 and instead
   used framework-provided "panel->prepared" in functions
   s6e88a0_ams427ap24_prepare() and s6e88a0_ams427ap24_unprepare(). Mentioned
   this in the commit message.
 - Patch 3: In commit message removed comment "Coulnd't read out RAW EDID..."
   and put it below the '---' line.
 - Patch 4: In the table "s6e88a0_ams427ap24_aid" in comment of the second-last
   line changed the format of "40,00 %" to "40.0%" like all others.

v1: https://lore.kernel.org/dri-devel/cover.1728582727.git.jahau@rocketmail.com/T/#t

Jakob Hauser (5):
  dt-bindings: display: panel: Move flip properties to panel-common
  dt-bindings: display: panel: Add Samsung S6E88A0-AMS427AP24 bindings
  drm/panel: samsung-s6e88a0-ams427ap24: Add initial driver
  drm/panel: samsung-s6e88a0-ams427ap24: Add brightness control
  drm/panel: samsung-s6e88a0-ams427ap24: Add flip option

 .../bindings/display/panel/panel-common.yaml  |   8 +
 .../panel/samsung,s6e88a0-ams427ap24.yaml     |  65 ++
 .../display/panel/samsung,s6e8aa0.yaml        |  10 +-
 drivers/gpu/drm/panel/Kconfig                 |  10 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../panel/panel-samsung-s6e88a0-ams427ap24.c  | 771 ++++++++++++++++++
 6 files changed, 857 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/samsung,s6e88a0-ams427ap24.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-samsung-s6e88a0-ams427ap24.c

-- 
2.39.5


