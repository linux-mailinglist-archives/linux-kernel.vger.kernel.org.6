Return-Path: <linux-kernel+bounces-383121-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A85849B1788
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 13:43:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53D541F23638
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Oct 2024 11:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B521D4175;
	Sat, 26 Oct 2024 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b="bB9J5bow"
Received: from sonic310-57.consmr.mail.ir2.yahoo.com (sonic310-57.consmr.mail.ir2.yahoo.com [77.238.177.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8F41CACDB
	for <linux-kernel@vger.kernel.org>; Sat, 26 Oct 2024 11:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.238.177.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729943012; cv=none; b=MJovaO1JEe1h4FSyJfaKwDT845mueJkzqFNnGR2oR8JRBmXBxQQW5u2xL53jC+56OZnsLzqH3d5JzOL6lXP1aiSNRxQOVhygucHFYiwdSEIsdKijKpQoSSe4EJ8h8jK8Pxk0PVJD04wfpRCIYQ3DrGMVMcrxiekZGvUPDgMFtlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729943012; c=relaxed/simple;
	bh=jzjqCwjIAn6SOKZQuKOVn4p0WJlb1canFhY/ix5Ne2g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gdF4dXhgYhfAYTY+/OrWU9vU41p1/+OCIb6xI1ugTtlj5raBVcVPYuVEUPRdpTK1TK4oaeAseR+e+cDyp40SAyn+BYvmM6mIG/LZSNV7gYTSLdek2CVk5WbMinA/8ZO4zBIJ9Tn85yyA7mURNc9moIM2xClwbztkdG9rVro0or8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com; spf=pass smtp.mailfrom=rocketmail.com; dkim=pass (2048-bit key) header.d=rocketmail.com header.i=@rocketmail.com header.b=bB9J5bow; arc=none smtp.client-ip=77.238.177.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=rocketmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rocketmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1729943008; bh=jzjqCwjIAn6SOKZQuKOVn4p0WJlb1canFhY/ix5Ne2g=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=bB9J5bowZ3cfANv5VIlfkJOd5ojpFNte0Iw/+JtHNkKdIbKUwcExuoYfjsfxIQJ878w86Kz13YPHh4OrKFpjC+VUJb1FbSsq7LQbT2F1p+QHS24cD7hpDwv2xED731VZ7PcYRQ2BFdvwfMsCFapZRgH9w6Xb762nYECM3fdpk8jr1KUfaipLWxtTzGq0EYuqElxUX7sPwbyb2hk7tdXTAE2jQSXc9JYG7LpXQUp20usXnn9K5J5jlFgg7eMxG2caeSWdmbx9B0vcrWMxZHosSXv1QcEg6njq/CLZMvG1P+6HE0c9mtfuKGjvzfVJk7lXi4xn4T3Ak/PLbfQmIB55BQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1729943008; bh=UbdYrxJeHYIZypKUupixSlM/rU3cn3C+/5Fu6bSVp0I=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=R9V53oaPLeG9ZeSP8wS9xTKdHaCjOV0QUohNdcJ4HskQQq1/D3J+3pfCRq2bssNyrkDynFQxA8rElv0pf5GndrxvtJodKODTYYHKLgnkeALin6cMt2mrSlB3sY8ds2hN60tgIbEz3aoaRsy+yDvlLYSjNbtZDXWMXjdIbyv9Z1zklUgr2kZuKbjBiBdgKFmYXDy/1Tn3M2RM5uFv2jjbwY8TohY/wbFNoox4R8Avg5NgzYy6SqLGtsCABcF4t/ysnWxp2UQ+2Nag5yo5WWqK+46D53ZDt/AIvY5raaoySIFK0SZ9zKQlwkUfXgGWBhGs2QfYfyURXFM6TUrpIEAETg==
X-YMail-OSG: 71ws99IVM1m7x0WCxX73k2X.ldWfFQbqgPdbmZr34lD9LYd5.FrJKSgnMAgLkmE
 f4c_Q6KgOqqbuj.fAXXCB3H8Olv464Upo4OwHKWLFzJr5HPY6RwQKzKzEbfTSm79_PzKPT90yFyJ
 YvVYWQAJP5FQQTM2ndLWxm958JyQpdlrlI0_pFH5TblJRBVXZ2A6qgN.QOVRPXaxM.fibb5HBr_E
 UTJ9RI2JgyvR0wiYaG3V9yQ0WMPajeaoO9Wj3x1SokpMIzdljNVhewjb9KqDxTX63QAE7gAWDBOT
 iSqrRO1.sQQAAYPpV.Qx6C.P.R8QeAS5Lqu.W61C3FsHitGR5Ymqh832kVSWzfdXq62ITCAiHmfs
 XjZJOF845WN20zKRsFK.vNqv1mUE_qCnjZf8gCfvTXcw1q3cvoN8ELG0yrL_ZsIgUBvaf4Vo4ln.
 4dwDiDZ85UL6ATUDQfoI0lK2.If5H7vyQ_s4cyqoxkgvCq_.MI1vn.78nh0TotXqvXRcfAif.Qan
 2TxkUY8B5cZ2NcroPgUJsI_D7Z7cHUCZESGe06DAovfMUxLEnDnwfQt0sY8aN9uw.9F1PCWzLbT1
 UypAGBK8vIsKtVDxteKZlwXLPynvQ.jQpcklFIh2kjVzTUga5F4AWwuOa4E832JX_ptrrV5kg_2E
 wMBTE8nnbux5dyN9372nB3lC21kGKo2iLRzCFSZZkxO8rkUmTJOFVW2MVkxQmXUeBcU2LeU.Nz8T
 .q8WsXH3xuQQbOl5wyvqtzVApP.VrNaE286_uAO1b44rqLIEjCmXydrhPacJHdeCtNtJPv8Nsgno
 0_PmT5KpDyU0g8CTl3_gz1.vUIYD_jHd68qvMaIHFKl7Zkdt9xjsvaRRVXn3SFxl25a9wBFCpLtX
 vhpmvv94fXf9f6USIsqCYkZ4Dy1gY1JjQsjHgYcun_2wDlwjm7dOX1LsYhNCQAtxIRuNmcEYosxL
 6CF29P_82rT6zsM.yI9w4h.tbe4RRhtuupvLfFrlIOlFc12GEgjLkfhCDzMsRqYVnsP56DTm9qM4
 2teamAEj1BKAHzVh7JTZ3E_RPTRRCPmCxmm_PyTvlvr6hCRwr8R75IjG0ZZ8jWlJfRljjDSvqmtk
 2u_Dti8qq1M_N9trVe_0qOOdkWu.xIYX_1bVW1Dt9ylduI7Ul9EwUY14qQdFH32kz.akNoBy7uYV
 Z_nzkwWiHgplHZUZT_qMd.ECQwP8aG84Bf3UIPBL1IgXYQCJvdHEdma8zv.eScxf61Ls_v3zBo.b
 8OwHYH29sB8EDM2u8V2WertRXnYiHM_JFwnax4bXGc69aDbon2lmUc4kOgROMKs9afP2OphMgyIk
 _kt2.JeqWlpoBNZ33txKCjOFUXc63T1w0C5aOM7o81U67qgyUgD50jAdatoGLFEmKqh_3VIcgLLr
 RcxvQo3.yR7IZ3kt6gAqlxjqxaxgrPXv1_MsifoSYBRhxWGyZe6Z5dUq.PrGjoqNb6HQC1rtrbUZ
 4yD09eHaXHAx1m7XLgbGb1.Qf6pgwgj01I6jQ4mH5ZFOgsWAiMxyeLyZc.axRWAJ0xro77UxUruW
 TnYo2jmbnP3wlVat8t2YTPnnQ_wbJjyiKzl.C8N.mR_qwamdpJPsSa55xXHNCnD6GBdH_SG1XCMV
 UHmzaroUJIXg3h0VR5UeqpKi6NY46_936t1lGMsCyVM5RwZBVZK7Ablvg0o7QYXe9XUgRYKbYeOE
 W7i2OPoPsIj6yjQQxkqjxa0_8AQXo49s47CxSxSYmTgGKY1I7BCtIGVxjp9JNK3ieJuLK.PEpEJt
 CJLC7XwRYAgTrDQBhtZEjDWiSzq6ZHNuJxAPET018cB7Ag.ilWX.fmFpfaXMfty.O3mzpqpB6pqT
 mStQomZqMYxuW0a2TUbLJdMXEi8DrHr5Ak8TWvxXu.N2QK1Wa9G9vey17mGwa_AkIN7eTiDoDU.0
 H6Isrsetqk8BVz8iCv_NuJfR7YsvA6BRN9x3mAbqFIla9863FUC7wK4SXBXSL4OPCYhD93FWVTTF
 giJR7GhIyDGWiPjcvOZpmLribhBRaiNsb1JAZk9VTRknYg0le0ewORm_Mrrh6L3xrdtybCh4jB6W
 T0tk8zn6dC6IJTgnnclXOK1XFqPs3RqDkP4IbZTAfkIox6NJAAH5O2zG_Wqbitn4.fXsipGwkfzS
 m4arAnDtUuU9d2HfUn_8p0YYhDXdsGKUCjM2w.KpnHxD5_PqBFMBNnWXE68YdYd9r1gNjESmVvRX
 wwtH1GOVQ71g7R0YZdp8k2KGwQd09T8cbvcA8ksEYTPCCKimH96alKd6j0SHqFY18yAX3_lOMlvq
 YuTvIekhqh2TVN17D1SRKI3A7NMFx8TKXHnZVFU0-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 22a6f5cd-7af9-4326-b65e-8d6e4bc02132
Received: from sonic.gate.mail.ne1.yahoo.com by sonic310.consmr.mail.ir2.yahoo.com with HTTP; Sat, 26 Oct 2024 11:43:28 +0000
Received: by hermes--production-ir2-c694d79d9-h5tj6 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 5bb438183100cab3b9878666a457b459;
          Sat, 26 Oct 2024 11:13:03 +0000 (UTC)
Message-ID: <c2c08d39-0be5-42fb-b888-0d4e8db3f85d@rocketmail.com>
Date: Sat, 26 Oct 2024 13:13:01 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] drm/panel: samsung-s6e88a0-ams427ap24: Add flip
 option
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <quic_jesszhan@quicinc.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1729738189.git.jahau@rocketmail.com>
 <886ce1a2443dfb58496f47734d1ceffd3325fb4b.1729738189.git.jahau@rocketmail.com>
 <CACRpkdYp+3sqbZPZt78wKaJPUxh7yq1+WS6jnZ9fFSTROJAqmA@mail.gmail.com>
Content-Language: en-US
From: Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <CACRpkdYp+3sqbZPZt78wKaJPUxh7yq1+WS6jnZ9fFSTROJAqmA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64
X-Mailer: WebService/1.1.22806 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo

SGkgTGludXMsDQoNCk9uIDI1LjEwLjI0IDIxOjMyLCBMaW51cyBXYWxsZWlqIHdyb3RlOg0K
Li4uDQo+IE9uIFRodSwgT2N0IDI0LCAyMDI0IGF0IDU6MTjigK9BTSBKYWtvYiBIYXVzZXIg
PGphaGF1QHJvY2tldG1haWwuY29tPiB3cm90ZToNCj4gDQo+PiBUaGUgd2F5IG9mIGltcGxl
bWVudGluZyBhIGZsaXAgb3B0aW9uIGZvbGxvd3MgdGhlIGV4aXN0aW5nDQo+PiBwYW5lbC1z
YW1zdW5nLXM2ZThhYTAuYyBbMV1bMl1bM10uDQo+IA0KPiBUaGF0IGRyaXZlciBpcyBub3Rv
cmlvdXNseSBoYXJkIHRvIHJlYWQgYmVjYXVzZSBpdCB1c2VzIHNvIG11Y2gNCj4gbWFnaWMg
bnVtYmVycyBzbyBwbGVhc2UgZG9uJ3QgY29weSB0aGF0IGFzcGVjdCBvZiB0aGUgZHJpdmVy
Lg0KDQpBY3R1YWxseSBJIHVzZWQgdGhhdCBzYW1lIGFwcHJvYWNoIGZvciB0aGUgZmxpcCBv
cHRpb24uIFRoZSANCmltcGxlbWVudGF0aW9uIG9mIGZsaXAgbG9va2VkIHZlcnkgd2VsbCB0
byBtZS4gSSB3YW50ZWQgdG8gc3RhdGUgaXQgYXMgDQpzb3VyY2UgaW4gdGhlIGNvbW1pdCBt
ZXNzYWdlLiBJIGRvbid0IGZlZWwgY29tZm9ydGFibGUgd2l0aG91dCBkZWNsYXJpbmcgaXQu
DQoNCj4gKC4uLikNCj4gDQo+PiArICAgICAgIGlmIChjdHgtPmZsaXBfaG9yaXpvbnRhbCkN
Cj4+ICsgICAgICAgICAgICAgICBtaXBpX2RzaV9kY3Nfd3JpdGVfc2VxX211bHRpKCZkc2lf
Y3R4LCAweGNiLCAweDBlKTsNCj4gDQo+ICNkZWZpbmUgUzZFODhBMF9TRVRfRkxJUCAweGNi
DQo+IG9yIHNvbWV0aGluZyBsaWtlIHRoaXMuDQoNClRoZSAweGNiIGNvbW1hbmQgcmVnaXN0
ZXIgbWlnaHQgYmUgbW9yZSBhIGdlbmVyYWwgcGFuZWwgY29udHJvbCwgbm90IA0Kb25seSBz
ZXJ2aW5nIHBhbmVsIGZsaXAuIEJ1dCBJIGNhbid0IHNheSBmb3Igc3VyZS4gVHJhbnNsYXRp
bmcgc2luZ2xlIA0KY29tbWFuZHMgdG8gY29tbWFuZCByZWdpc3RlciBuYW1lcyBiZWNvbWVz
IHRvbyBhcmJpdHJhcnkuDQoNCi4uLg0KDQpLaW5kIHJlZ2FyZHMsDQpKYWtvYg0K

