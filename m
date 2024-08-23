Return-Path: <linux-kernel+bounces-298093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED90795C201
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 02:09:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 981E41F2421C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 00:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C49F68469;
	Fri, 23 Aug 2024 00:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjQwJABN"
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87E94687
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 00:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724371767; cv=none; b=UGZYBCMiZ2y+bX16Xym9DTfPe9YYGL0wXH4G5Ffqv/TXGBzEq2w1I0fzG0eCQH6U+E8mc7WLsp37LXgwGb0PoXWP22Q8RELKSdqV0i6/bCVlSwbsGqPYQnXY9iX6T9A3SP+Rhiwi7S6IMDn5ZmAc9+AXfyB0vEhjtBIVyGK6ir0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724371767; c=relaxed/simple;
	bh=dN3nffBm/hBLpyVwnZSRJcqVI+KkswlXdU5KaorlImA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pA1H0Ywq8TCPCEot1UKvweYL2KvaebHmJdCCTjP4eCzl5IG8jkOapKPD4NqrKlgM1SOnFfW4KIuORrWaxxGeMq3MwUDo8dRVCZjvKc8NqFbR0b0NPwL1+rC+zLu0JAnjS/IpNZJvgcfIaBApOXrGkjRnMwpmd3DQkVzdIRQDJnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjQwJABN; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-7b8884631c4so626635a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 17:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724371765; x=1724976565; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mNja2/ozWCmydptxs77W9+XMG2tb/ebDVa2ly4AGNiY=;
        b=PjQwJABN2ObyfcH46IocAdmOijqtcU8JVTSDW+LajbUgnlBJ3/78zigyPKltHU2FO8
         bRRQjxJXRbJKSV8XeWZHQIUl8z7Yq/SsTkIohNkfZWnsGLOUJVcia41ntTsrRoJMEROx
         7IV2Jrszkt2dQpBSCJntqylCYVoIp0H7ZItSWsXxBrwWmrVC7VLZF2ABccmMU+S6RiiZ
         1QLRR/z/VAqM6hUc7uB6BS9+FNMObS/4rnEvST+s2GPO9jpmYmT1IWcG/GyycreQ3EF8
         Whl2+u+LMOa2DSKVeBRfftrAQ5X9s/GZ+FonRq2sodKmZ71DTyCe3zpmBj2M0M69LxC+
         cPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724371765; x=1724976565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mNja2/ozWCmydptxs77W9+XMG2tb/ebDVa2ly4AGNiY=;
        b=WHyaZ/sUiw2HCT5jQMdF5VeoEKypUhQgUm/OdUSdAEusIj7gnXMWBoIYjpKcxBv2AC
         gYJJ5YV3ibPjSe0H2zZVX1vih8N543HsuIXeETpAULxVauxIOvWOhz7aTtxAvlb5NsPU
         WEIaA5N+CgUM76ao0mOl+Ryuj2sw8g4bDomzn+t/asDpvbcXi228qdGQYH6+uRAUQujA
         dYwF7AaInpRX6fnQjR2Nv7alVJ6sl+ia6QPiqrJ9IFZmLRj6uLlF2yL4jBD4zgG6Uv+d
         I+H5D0HpT6vyQD149UDNUynG1DQwLS+xu8u+QI7lahBe6g4Zs9IY5UYYtSH+B2HcFnSb
         Ol+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUpxYtHj71nLLz86FE2iTOMba192i+1QRF12zjXF4nOpLPfHOcsLvNRt2UbjqrfZeXWTVsDWta1Ovpo65c=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9dEDLg2tN6FWqg0rXnD397iKOjx0VnA/cSkY5HzCGlu3ChGvT
	PBLYnKOpnE/uz1Eqs9H/ocpPMCo5oZBguG0d2s8nmGL9YG1wWs6u
X-Google-Smtp-Source: AGHT+IGKWKjSWYgDm6yIXSf6/K0YSgfrE5p8+Ncc86a1SVKlp2BKaq8MC1YyKcz5qitvJmBQmaVbVw==
X-Received: by 2002:a05:6300:4c:b0:1c4:c160:2859 with SMTP id adf61e73a8af0-1cc89dcf828mr849786637.31.1724371764849;
        Thu, 22 Aug 2024 17:09:24 -0700 (PDT)
Received: from localhost.localdomain (dhcp11819.ime.unicamp.br. [143.106.118.19])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385608eb5sm17929185ad.188.2024.08.22.17.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 17:09:24 -0700 (PDT)
From: Gabriel Maciel Raad <ffunctor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	~lkcamp/patches@lists.sr.ht
Subject: [PATCH v2 2/2] Staging: rtl8192e: Remove unnecessary blank line
Date: Thu, 22 Aug 2024 21:08:38 -0300
Message-ID: <20240823000838.8207-3-ffunctor@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240823000838.8207-1-ffunctor@gmail.com>
References: <20240823000838.8207-1-ffunctor@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unneeded blank line in rtl92e_leisure_ps_enter to silence the
folowing checkpatch.pl warning:

CHECK: Blank lines aren't necessary after an open brace '{'

Signed-off-by: Gabriel Maciel Raad <ffunctor@gmail.com>
---
Changes in v2:
- Split the changes in two patches
---
 drivers/staging/rtl8192e/rtl8192e/rtl_ps.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
index 1f881c27d4b4..7b6247acf6f4 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_ps.c
@@ -209,7 +209,6 @@ void rtl92e_leisure_ps_enter(struct net_device *dev)
 
 	if (psc->bLeisurePs) {
 		if (psc->lps_idle_count >= RT_CHECK_FOR_HANG_PERIOD) {
-
 			if (priv->rtllib->ps == RTLLIB_PS_DISABLED)
 				_rtl92e_ps_set_mode(dev, RTLLIB_PS_MBCAST | RTLLIB_PS_UNICAST);
 		} else {
-- 
2.46.0


