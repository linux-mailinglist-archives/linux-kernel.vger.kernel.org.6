Return-Path: <linux-kernel+bounces-179424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD6F8C5FE8
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 06:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DED11C23068
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2024 04:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCDE60263;
	Wed, 15 May 2024 04:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b="OYa/f22f"
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D099C5A0FD
	for <linux-kernel@vger.kernel.org>; Wed, 15 May 2024 04:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715748770; cv=none; b=ADV1w9Y41JU1lxwOwY90nSOMOowgSQIshaprjnG3rUcVTpecvmVq12NQ3teyEUW0U5fXpgQMpWKu3CjimdhK1iVTxK/kmXP10J07YT8waWvPAXJH4b0dEe8HD+4+9VpXKK01XUoWME6D/CIHZb60ReWL228Rz4z7jjDFyN+CSw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715748770; c=relaxed/simple;
	bh=TeaeQ2JMBXMEzm1Q8X46tzEmnkViYGm+ie4q5eQCeJk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Vjf5gpPpz3IpUiKXNXDP1mM5S6uRtg0Kq74agSk7ogXCxbPzOGF8MFTpyATe2sNAywx1CrV6oM5hqhPBaNZamkPq7ksa8RKJ7zUbLfymqzGHlwnWS7OXWiAvTRc7N4qIa7b8ytKPJZL4stTotqVCurgXyHZfiGuf1xiM5AhBPAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net; spf=pass smtp.mailfrom=darkphysics.net; dkim=pass (2048-bit key) header.d=darkphysics.net header.i=@darkphysics.net header.b=OYa/f22f; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=darkphysics.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkphysics.net
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-23d477a1a4fso4050636fac.3
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2024 21:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=darkphysics.net; s=google; t=1715748768; x=1716353568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r4y6QZitAeyvzhHgT1YfCyDaEWg7ZCeKCXSVd34YhUs=;
        b=OYa/f22f1/frA2ztkomKx24l9r0UTdJd8ocTVoIYU34M784LuX0J0AkAz+NLc2lv5U
         eQWEGFrTT05azBU8Om3H/MqmOXAu6cSZxAxpTzq6jQTeXvkHbfGdJWGYkIqYxirPizMg
         QJGnCOGQYqLyPKHETse9hrFerBaJm+aSPaAqC4NZ0l2foJcMqCiERLWf1Fuw7Z0ezFm5
         RnSei9ABrbwaEJBSulTFllzMdort8+kgqtzxixd/bEhFrOeLv1IUZZtNDHCYsfKyqvT4
         RyagEsQ8v0LYdOjpzKr4eKlMW6oygR0/0sWoAfzD3qtpCEDXiVsGpuqUfs5jTSJ9dV5Y
         6blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715748768; x=1716353568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r4y6QZitAeyvzhHgT1YfCyDaEWg7ZCeKCXSVd34YhUs=;
        b=HIMKAjCWtATqEXY6Du4j9mWLRUZUx4pKustSQQfdaCV6u0N6QL7pfV5a3quFZYrfHA
         THn02fvpFmHQiLdcuIgVfyQ1bnNONSNdfPKsWTXKuuGHbS+JOU4PPuVNHd8uDPwkMHLR
         XYyiN5S4Uz4DO4KxTJVNrjpXAOioBRJuZ6FUKHJmEqaAclOE7toHyETAk6mOf7CcPL9g
         PbShHTyMUrRqJzgXAHxbxsoavVWqjodyIRpdZ9fE7wgS2kziZvJxw7fCwml0y7pQCFMu
         ToEJEtCMStCAbZHs9u9LaIt/DXuGHWZQgTuvJ9JgSGov2bGHiJxWmOQp/bpVZ1sUlS/X
         cN1A==
X-Forwarded-Encrypted: i=1; AJvYcCXW33txI05eshk4gMTzlPeeBQ/3H6/GXetteC6xKlXWo3yIKBmmsbt8Pdxc/dAsUVzRyjV/OTSmeipEiexkuKzECQJsjutlG6O8OEdP
X-Gm-Message-State: AOJu0YwDPg5MOtZyN5LSRDgnyA5VNx4E9to7FIufY00LWQmopuWc3Mx1
	Pw+vhnsXgl8C/3lLmDu757qPnHHgqsPUY9bUtRCmSIyyZc5sE0rIhOPIgiVc3KA=
X-Google-Smtp-Source: AGHT+IHwI3T9Ka/ogTdJIsEKZasEKHJCBAT9lgmF8R2aLZoeD3n2CGajodQ34tSMagASSiTKm8+B5A==
X-Received: by 2002:a05:6870:8dc9:b0:23b:ed9:1f53 with SMTP id 586e51a60fabf-24172fd265fmr20986165fac.53.1715748767884;
        Tue, 14 May 2024 21:52:47 -0700 (PDT)
Received: from lunchbox.darkphysics (c-76-146-178-2.hsd1.wa.comcast.net. [76.146.178.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-6f4d2a827fdsm10135035b3a.60.2024.05.14.21.52.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 May 2024 21:52:47 -0700 (PDT)
From: Tree Davies <tdavies@darkphysics.net>
To: gregkh@linuxfoundation.org,
	philipp.g.hortmann@gmail.com,
	anjan@momi.ca
Cc: linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Tree Davies <tdavies@darkphysics.net>
Subject: [PATCH 19/31] Staging: rtl8192e: Rename variable ChkLength
Date: Tue, 14 May 2024 21:52:16 -0700
Message-Id: <20240515045228.35928-20-tdavies@darkphysics.net>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240515045228.35928-1-tdavies@darkphysics.net>
References: <20240515045228.35928-1-tdavies@darkphysics.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rename variable ChkLength to chk_length
to fix checkpatch warning Avoid CamelCase.

Signed-off-by: Tree Davies <tdavies@darkphysics.net>
---
 drivers/staging/rtl8192e/rtllib_rx.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_rx.c b/drivers/staging/rtl8192e/rtllib_rx.c
index 3223619f8cd9..ca1c748ac40c 100644
--- a/drivers/staging/rtl8192e/rtllib_rx.c
+++ b/drivers/staging/rtl8192e/rtllib_rx.c
@@ -729,7 +729,7 @@ static u8 parse_subframe(struct rtllib_device *ieee, struct sk_buff *skb,
 	u16		fc = le16_to_cpu(hdr->frame_control);
 
 	u16		llc_offset = sizeof(struct ieee80211_hdr_3addr);
-	u16		ChkLength;
+	u16		chk_length;
 	bool		is_aggregate_frame = false;
 	u16		nSubframe_Length;
 	u8		npadding_length = 0;
@@ -746,9 +746,9 @@ static u8 parse_subframe(struct rtllib_device *ieee, struct sk_buff *skb,
 	if (rx_stats->contain_htc)
 		llc_offset += sHTCLng;
 
-	ChkLength = llc_offset;
+	chk_length = llc_offset;
 
-	if (skb->len <= ChkLength)
+	if (skb->len <= chk_length)
 		return 0;
 
 	skb_pull(skb, llc_offset);
-- 
2.30.2


