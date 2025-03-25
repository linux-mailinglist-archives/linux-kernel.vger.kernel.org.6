Return-Path: <linux-kernel+bounces-575555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C2365A70415
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49E4A3A6DCE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 14:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3CFF257AF2;
	Tue, 25 Mar 2025 14:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GcMuv1n0"
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3BE1A841E
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 14:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742913769; cv=none; b=BFN1uVUmM5WN/rxFXHGMuVPQKiXZgSuS6O0mWvQdR0g4XiSYQ5rs4s00mm+j2gSVvEZovnqAW975xkNEmvpKrTSOLxRPr8ZbrfgfKfQ/yiIBkS1EwIOy9KDM2d9o2FxyPdOT1HKXpgoPmYC0mtn70qdmshu2/OfindR3z2p1gTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742913769; c=relaxed/simple;
	bh=Vk7lu+k/LxGfSIe4a8nBRYhg0IP1gdWBVQeXlEMh/Wg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Yzi+APaBJzXN/8R5O5d+kFj5RbRjd6PGN88vPTkog8P/ceXffixlwmE9P/07WJpBoCZowtwIzZSEVK72y9LV8ednN64OP9s5KwsIt91IkMdsd3QpVgQFdXeEsbjH556jfTL8yzMnCHEPT2cpYPdHy5JJce2RTOTpeQcu9bqjNv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GcMuv1n0; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e60cfef9cfso8579894a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 07:42:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742913766; x=1743518566; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ifjnDb3LR3+EXG2gLg9Iuod7C3gy4u+/OHVZr6cmIUY=;
        b=GcMuv1n0jBmx8/yiWriAONJZqLwjhLo7ZAqA4X5CkCn3Em23BWVKSsMrmOeQUrHqsg
         hK98fcaM1KJImkmmL1eI6hFHQDdaRnBpJS+Z59Lu1/tC96ZW2sCKX1ArzdrhQdQd9U1W
         fMYZUWy33gTDtmZxT3C1Z9cdD2vkEgDEJPYvooNDYEqk4KAYC+z5o2EURrQezHjQF0Fm
         GYBdipKAmcTRgtDMSvxzbCffAQzaJP/4iyiDvPacIAhKaR50Tq0hD2suZH32FDXKpBZ4
         m3NNieHupFYo59DDq3l9Z12vVXWw/ELbcTXObct1+st9n3JZ9KPaXHs/7bNDifdE6F9m
         CQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742913766; x=1743518566;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifjnDb3LR3+EXG2gLg9Iuod7C3gy4u+/OHVZr6cmIUY=;
        b=i2vs/6F0Oamn631k5Q4LtJF1uw5bLa4SIF7oNdvu2z3P8Oxy87wF0x/fNwh5EqurPo
         DDSausB15s9BYzWlD1tNFNfTEPfh8OYS+QZHgobPnVg60GzsH+g/pbfKa1bp+Xf3t+V9
         cQ2L+7Oo+gJ80Lyz9/stW1DaL5j7AykZqHgArqN/twtDLxSo4z2IslA8WJ3c4o894hUF
         /iQmL57uGMkw4uGUsWz3cNpHgMeDFUwzVbbPvBBPZf8+5b9iqlB3Y0I8hUAEUKdcXqPc
         KqcStyFtkpTIcluGxEOHV4XvqC0Vc5zyXTbaCrt1zUrQUCy3KTmSwY2aRkp78FLwyLS3
         FJjA==
X-Forwarded-Encrypted: i=1; AJvYcCUpWXmn1JL8luVHsngQ97yML0lcUN1/WpeXpoRlTR4EnmJ76IqL8QcLTTph4bsFlOo0uz4ucUPJ8hIw5Tc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwB6JNDp+XmYxLuGs+AlQUbMtOGOq1TNW2/DRv6cdLZhLH9ahx
	t0uiMLgNtL3UydWmjim24y52Zh9XrqQ+l/HMjK0O7HGcIV8nbxNtMcDxI04C
X-Gm-Gg: ASbGncu2f4gIsd1jbr8u4paB1Z7zJA6wswrGpcj5jSNKQEQJlFvcZwZyGDkl4VH8f4y
	pnfkXZW0T/kKg8aYAO6bt5AQeg/sRscGa15JbwZi3UxpS0wpM4CeKsJlXg0yh3XpjznNETvCREj
	HzCNs2ZGjgdi1v8O2fJvr1B3UWLjdJ/axNsoRRKi/u6QPCTRPpjV8z8RS2Wi6CPIXkrOwOkGhYH
	KRgz1ZQeQ5xqkzy6hVk0M1bwXLGp6OgOwebWpGniwO9SAQRYvb4rzxiYJ6MN8shvHu00T5GL/T4
	0bT5o27ethDznPTtGhPRIiy/GNhFKSo+wL0iHp1Wgd5xcx30OQ==
X-Google-Smtp-Source: AGHT+IGC8+tqW/1yJe1dg4+8ZsCRTfU/nKmyirtXygvgBHP4Qtsc3PrlbHnyd/E1spsS8y/6s0kKqQ==
X-Received: by 2002:a17:907:94cb:b0:abf:7776:7e0c with SMTP id a640c23a62f3a-ac3f23e00e9mr1451400966b.33.1742913765279;
        Tue, 25 Mar 2025 07:42:45 -0700 (PDT)
Received: from HP-650 ([105.112.117.141])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac6964189f1sm421150366b.33.2025.03.25.07.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 07:42:44 -0700 (PDT)
Date: Tue, 25 Mar 2025 15:42:33 +0100
From: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Julia Lawall <julia.lawall@inria.fr>, outreachy@lists.linux.dev
Cc: linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: rtl8723bs: remove unnecessary else block after
 return
Message-ID: <Z+LA2eeFRL+K0KCy@HP-650>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The else block after the return statement is unnecessary since
execution does not continue past the return statement.

Remove the else block while preserving logic making the code cleaner
and more readable.

reported by checkpatch:

WARNING: else is not generally useful after a break or return

Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
---
 drivers/staging/rtl8723bs/core/rtw_mlme.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/rtl8723bs/core/rtw_mlme.c b/drivers/staging/rtl8723bs/core/rtw_mlme.c
index 5ded183aa08c..91c6a962f7e8 100644
--- a/drivers/staging/rtl8723bs/core/rtw_mlme.c
+++ b/drivers/staging/rtl8723bs/core/rtw_mlme.c
@@ -2022,12 +2022,12 @@ signed int rtw_restruct_sec_ie(struct adapter *adapter, u8 *in_ie, u8 *out_ie, u
 	}

 	iEntry = SecIsInPMKIDList(adapter, pmlmepriv->assoc_bssid);
-	if (iEntry < 0) {
+	if (iEntry < 0)
 		return ielength;
-	} else {
-		if (authmode == WLAN_EID_RSN)
-			ielength = rtw_append_pmkid(adapter, iEntry, out_ie, ielength);
-	}
+
+	if (authmode == WLAN_EID_RSN)
+		ielength = rtw_append_pmkid(adapter, iEntry, out_ie, ielength);
+
 	return ielength;
 }

--
2.34.1


