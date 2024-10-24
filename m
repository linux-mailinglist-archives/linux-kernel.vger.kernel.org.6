Return-Path: <linux-kernel+bounces-379139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE4709ADA86
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 05:39:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 34E3F1F225D8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 03:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092CB1684A1;
	Thu, 24 Oct 2024 03:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b="WEXpLQSz"
Received: from sonic308-19.consmr.mail.ir2.yahoo.com (sonic308-19.consmr.mail.ir2.yahoo.com [77.238.178.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3F014D2B9
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 03:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.178.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729741138; cv=none; b=urGyMyrVPb8uu8INM0rm3LFU45ulhkMJlIZmTMZMnUXoMtOCrb8h3AeK9XNfs8DN7ojY3vU6OGDl6BvxUGXOxFCtKoWpFlsxcCbP8sT6Tp8SQ8sRb1+AbTi72f99/T9AuKsjERJfLgCUjI0RxAzOsViXP6DyeA/BRANBfAyzLh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729741138; c=relaxed/simple;
	bh=5VThlEH6Su4/w14IXL3HhRD/3lqeJnmSpnf3WYubb6U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tihbXMx1gytA7vankiDH4R6TxrNQq0WJsvsHGntCC/nnYRWb6C+SHFKUTSxUIfy2hTq6jPAfggmdIPN3Rm3vTIN9tQfCLX2v8wYXNhjaCXd4TD02NgSvF73h0wq49kEOlneYgSSP2NfY20za0/shcErnq6+7dfXud9A/GaP9qWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com; spf=pass smtp.mailfrom=rocketmail.com; dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b=WEXpLQSz; arc=none smtp.client-ip=77.238.178.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rocketmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1729741134; bh=blNveK3/qTop4tO3NKwtrpZ40Njgq9iaYrZB8t0ZO5k=; h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Subject:Reply-To; b=WEXpLQSzo77RXzLDLpPDTZAkN20149Yityr0XgzeKtInyR9WsfGd3CW3TrwO37ENLH0rcT0eDa7wm1OezKUZA1LKA+3EUSbG7E2T0A6V95ghkclDpwOgphsohKEJGN158SIBjHLQB8x/kP4eBWEHJ07HtkgxAQV7/lwpz+AEahMB8hXKBf1JzNx5S3eDlYoWcO0iZT6Ncn2omh/FZtPRc+6wiPONYMDge+tdf+eWDTnrm/bUTBv7m5Y+Xzb7QLg971dmQM1UNYuHeq4nE+t2YhvaS8hzn7imQ/xySVyNiJsG00yN2js69SJ0CNd+xoE7QrjOP5jKkYx9fXqrw83Wbw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1729741134; bh=CE7zG5UEWLSI/G3hlXbgTMpVRSZhc7z+JlASTmqXody=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=FsDeGnH7dLnJkrE+8yg6Pm8S+AkPZNjNHhG3aJg+Nlnwos9Tt5rz/KjRmIcqGGJZBmtY26S3IkQOit979t+OZEplG7DLD+hmalHo7c8DfSpExkivz+pcaaRuwXbc7q0/kkzIms3z9zpf1eCdYWNxiEP3/x5KjNKj02K31LqCLM2Hob613Nuqk1irqI3A3/4+q2YAujbAWF1iD0HOjQAukWBpDTeqp7vDiltsG3h3upVGExyqifPhHupZitRe/hrV8ok7TockbmRXMQKemJ4zlPp1bzPz7M+rGVgSxNvzpWxOQ0NeSw8nDKjDG9KTqpIwVZFMRSUtWlQc57i9cWsOxQ==
X-YMail-OSG: Fwoh5.AVM1kyqmD473fMZFb_GhGkEqiC2XlEEWDAj3TmKxo59whHirWdV06Kdej
 BoJopSgxKD_BhFuWhmgqpA8CGA6Kx.jgHBftTzm7PKcmQkZxkjdRIkEeTtOu6GTogTBfVnVkZmcX
 L.DTBOnIwpPASBLtk6Ulf6sV7IfwVHkwL6IiF4_fmdmCY9cAXxYPI5qnFclRUtOlNoz8S0_gHWMs
 EQr5GR6hh80pqg3j1to9j3cXyxnfosh5VhkcKlH4MgoU7qOGXIxGo_oNhPk2stI4tS5ZIQTxwE6y
 aWto3IVe9_QVcAfHpHt_U_WJuduDD2N0ztxSf0S_yHLWiPwF8FhuxrdqRKW6h_oVLAIfuzAEdvxS
 w_7EZqXQYNJT_pbQnUwQ4NkTH83_poK3sqADWVTlIfP16rWuQLbIAv9fiYU9HGQbdCOdMxi6DIGv
 g1wcKn7gGfuTChJa76h1ifDEfWhqUMT7tOX2pUqeQrRnJfdOcHNIEzIoLaV7vEr01_Th.rB0is23
 a4maDIHsqcbG_.J6aIrPlwLQ8petCrdbLlvuOZ9go69TSEOQTZPTly8kzkTfAX4LfnYDklq7Z2I.
 2._4EMrAYESqBjv_0F_mB4Yse_gZtcLppDkY_JLJPytdD5JvLF9rEQTzfb1KPUQTVh8wenpjiYz0
 m4CNn_ZY9J.B54tWobSNSelragO9ZlOhaho0pXrAkXKI0Ee0_MZjEvHTbRmYMn5RPpTeyGvtOeCW
 gx_qMSQFSCSXnxFxFKarha5a66NhIVB_sMgBpI6FXkGwOwBcTZSpOPRomxCLObO6AzfOnkUr0m5Q
 DGLwtQE0fdBeU8NpAVu85oVPjMhF1tEUNdWURfiZDRa9e.uKgcLWrZDPdMuXQA76DS0PIs1U6O_h
 J9p8NoYksWU8CGlaTd3Vap5zisVkcqFIymvgS0Se0Rz3Toa3G0NaGmP6SDUW3gXvR6WVM2_KUMq0
 cy_XwdE6EcdnnNAnJXj11A22PKjUw2eleass5RVLLxcAsKwWGOEv9Sl4qUFpMK3WMq6mIG5Us4LY
 xsmg92TyUkg2V9mybmYU9YrNechDpFHlD3.gxgp4A6J7AGMY3AMGlmdVmDpTloM_qUfXHPpLzZjS
 RjNQPGPqfn2pRK0QcLjoCIzlR7ab4HjODps.kCz9kpkTnswuFNgQch20bQJ.B9WBVLmeZNAvVmD1
 Xjgi1HGdm_Oz4nAHLi25QThImTwDR6TD9EBHiSKKRS_isvK_YqLCAT6wMaZ29HNfRtM9mjijyPre
 Gea08r9DPLgd6.RQM9pwKBV.lsiiFoeq2CenpDQnR1Jidks2TXmcnmL8q4ABzddOjCkeg.QVdtL.
 l8_U5K5RmiJ4dkSW04mIl.lFpdmsjxdO0.07y6lyzbYT4s2KP8W_tNDQ3P6n4n4fgBaDW0YZ.Ej7
 7.loL4U1L8HdwQ04ybfZHr8IIKXgKuqzb6PeI6lT_tTXgGApGkJI7i7S09nds8pci1fOybgZ2cgD
 6laRM_Dy94oD6FVjCgD7yUnBGKrmS1USbrvcVVH9Q11nzecLyz3e4QJVZvrdaAEvzxHCZzDmK_V2
 qX8qzrCT_sOpYavf336QXNoMyUDuWocFaGjf6pAeptjaKjdrb8CRnLm8hT4DKQf_hzOrEIzHBHAx
 jNFaMmnd_Htsk_eSfoAbIWmsgAxAybrKifE7sQMxbQnxLS783Ci9ltacQQfcwZxQLUpST5aELdjr
 wM77bFxFcUnU2yRBAJ5RlqiyzBXOpfD44KPfCxIEDZJOKimJ56lc3Vday13cwfainLvirkwrpVCv
 wnofvq5ZYgm1zncy_N.p4Zu0WWFfyRCvQ8NnIzYlFlTYN4N_PUJ5y4q_mfW_aofg3G3Ho4nZVugd
 tPVLzY3ivqcRzBebcZxCOLfU8AOhGgrexmeFITMslbZoSqW4xQj8yYKMby9N18j7RU.qtdYbVIml
 Hy0eClL037bS0y8waQ3Jo3cFSl4HhTyp6t4sbuYrb7Ot8vfHpt4c6ON.mAg5uNpd3R.7Lsun.awm
 GqlgEl4y7T7uydfAAetGvqpO1kxzBWFPtd.4udHRCZaI11JUlkYWOaZfKs7yidGiigoLLGO9Gokm
 yUuP8xqyRhwyQbqBTHDRRUQwjnI_xgY4EmvO7vde5OVGZ7FrPzc2V.E7Ml0WV.wECg3DvcKRiMX5
 R616QJdl8CTW0Np_UwSC4zC85h6GrqmQK7SZsZAxKFRIoTqzS.qVEkwGtk_kP_BD0R1T3ZgZAh0E
 m5GCC7s9EkvotuCerv2dIABys.LJq18zW1OiaXC3JQiInSQ35Qf7hO2ksnNm1kIGdYQ2In6C1T4N
 wV2s1qVUHdRvBM72Pu7ZzABkS7X.i1PUB.qvV9.tv.pSDM7jX.KmvYw--
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: a4d9475d-7c35-4bad-9cf4-39867f92fed6
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Thu, 24 Oct 2024 03:38:54 +0000
Received: by hermes--production-ir2-c694d79d9-2zgj2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 26d1652bc1703d2ade3e89c3cd33808b;
          Thu, 24 Oct 2024 03:18:38 +0000 (UTC)
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
	Jakob Hauser <jahau@rocketmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v3 1/5] dt-bindings: display: panel: Move flip properties to panel-common
Date: Thu, 24 Oct 2024 05:18:23 +0200
Message-Id: <a899d5f0525a76efeab6f734b75e1eb95d9a2ca3.1729738189.git.jahau@rocketmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <cover.1729738189.git.jahau@rocketmail.com>
References: <cover.1729738189.git.jahau@rocketmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The flip properties were used by "samsung,s6e8aa0.yaml" only so far. By
introducing "samsung,s6e88a0-ams427ap24.yaml" they become more common.

Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Patch is based on current branch drm-misc-next.
---
 .../bindings/display/panel/panel-common.yaml           |  8 ++++++++
 .../bindings/display/panel/samsung,s6e8aa0.yaml        | 10 ++--------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-common.yaml b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
index 0a57a31f4f3d..087415753d60 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-common.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-common.yaml
@@ -51,6 +51,14 @@ properties:
     $ref: /schemas/types.yaml#/definitions/uint32
     enum: [0, 90, 180, 270]
 
+  flip-horizontal:
+    description: boolean to flip image horizontally
+    type: boolean
+
+  flip-vertical:
+    description: boolean to flip image vertically
+    type: boolean
+
   # Display Timings
   panel-timing:
     description:
diff --git a/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa0.yaml b/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa0.yaml
index 4601fa460680..19c8cc83db97 100644
--- a/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa0.yaml
+++ b/Documentation/devicetree/bindings/display/panel/samsung,s6e8aa0.yaml
@@ -21,6 +21,8 @@ properties:
 
   reset-gpios: true
   display-timings: true
+  flip-horizontal: true
+  flip-vertical: true
 
   vdd3-supply:
     description: core voltage supply
@@ -46,14 +48,6 @@ properties:
   panel-height-mm:
     description: physical panel height [mm]
 
-  flip-horizontal:
-    description: boolean to flip image horizontally
-    type: boolean
-
-  flip-vertical:
-    description: boolean to flip image vertically
-    type: boolean
-
 required:
   - compatible
   - reg
-- 
2.39.5


