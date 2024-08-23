Return-Path: <linux-kernel+bounces-298395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DD195C6AF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 09:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB0851C21626
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 07:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60E0713C827;
	Fri, 23 Aug 2024 07:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYvKz/xc"
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEBB26AC1
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 07:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724398644; cv=none; b=Y0z6nPj8kehwEMLzQ2zqT/Y18uekb2TOPjNIOFB58bjDnKk4O41aA7AWyIRe4rprxkq6yl7bX4Abj9gARmd5X/mCPezqGLjS8LjsZ1Fr7UIVXqJepw4Y1cJyyDiiQA2ADUpFTE27THGd0rf6RRG/bfbYXJ3Vi5ka547KP9XNS8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724398644; c=relaxed/simple;
	bh=G+V4EEePfeLVgzmqyuUsKexrHd+H4A4sfrV318W5QD0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=uuXRP22gMzcdQun+Vln92aSo5l9bkN3fp4JufJrb05XHEn4SWnNIVGM7pUdUueBMEBRwleBpebFTmwhz2ftJjPsTlw79v86aSrLq9T/ZAZ4AYYQPRbpBDM4IKdukEMSBQ3Pxbr92G7Gdzq6Y2iWObKP74C9B7mvnzqxnNVUi2gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYvKz/xc; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-20227ba378eso15074465ad.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 00:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724398642; x=1725003442; darn=vger.kernel.org;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IwdGusPFdheswVn42reak48rV6CoMS6cSkMLL55sAus=;
        b=gYvKz/xcSFVFNkyg/KIt3/0XbhxdtJ7FUmFzfb/YvGb+Yvs+KyEhVGC+GPrDbqOV/y
         Ct31GW8ogkdlgwXlcbfzWOQj0zTMyBgEO6YB1v5RhoN7+6/OwM7SRWEK4e9x9I/1/TwG
         LugXrKTBGohRYRf4nzlTl31s97zTJf+BKZXLoYOH2PTw5Xl7onLu9OQCEpsG1RMrwPFz
         2FPEF8GNM+983Vm22BXe8SwustHNyHzJt+SSjfNWGVUtGoGSQP1o+YDHryZxAoT2/9lw
         F2vmzzh4H+RvafYZ7FbQKNv/VtNvYfcwUT+iHb7DMWOWMA+QhvhSlRNKndB/9PEDtREW
         WuZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724398642; x=1725003442;
        h=user-agent:content-disposition:mime-version:message-id:subject:cc
         :to:from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IwdGusPFdheswVn42reak48rV6CoMS6cSkMLL55sAus=;
        b=nHuSnqoCwuiW3yzZeDA4CSq5RSSBOQ65pmnOZlkdB4QexpDIS6VyarThZzqOdE7cI7
         82/SIbjriW8OoJ9AdVbro9YlwDGffTzkrfiv/ktfJjIp4QYGXF1/Y4OvdN+c5djIJ8hD
         4c3sIfrAPGunzcHs6A/gDgqm2difvNSoWw4hXLkM9QHGjNDfIJ16PTKc17NgJVy9AmrZ
         iyxaaauzNEIHgsB80AeoDW2NSQ3YV9uLmxQPW822fl4+6DHIRDD59w9F50aAX3rL3UNf
         HJlfumSAZKmUfTINwYLFt5VcSVyCxTdpa7dVMWXBq+RsNhFvvOoKz97ZSWS4WrOVqZ6C
         4M4w==
X-Forwarded-Encrypted: i=1; AJvYcCWmmCNcesuXqBNS44upuVaFpgPSxQO9M44tprLU/BMn3nyA4ZdbtfefI37uQX4drk4dckgoqiGRKl/ejOw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw12XaCTe7iKA/UiFvFIZcdYIDph2yRJsFkoizOKrUxWRHQm6Qu
	kID86niyco4Kcz6hzvYAcFpEVFcDqr5U2kkr75ghDLG6q3ztIVyp
X-Google-Smtp-Source: AGHT+IFPmO8ObNG7L/0IxjwHyS1ESRZJe1yyTGzbcnUCkT8bWbcp1Qww/ORuUHG1xrFv7pJzmQjVRg==
X-Received: by 2002:a17:902:e804:b0:202:3432:230c with SMTP id d9443c01a7336-2039e46a37fmr11633475ad.18.1724398642421;
        Fri, 23 Aug 2024 00:37:22 -0700 (PDT)
Received: from systemsresearch.io ([2a01:7e03::f03c:91ff:fe02:b162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385ae4f62sm22979485ad.256.2024.08.23.00.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 00:37:21 -0700 (PDT)
Date: Fri, 23 Aug 2024 07:37:19 +0000
From: Hao Li <haoli.tcs@gmail.com>
To: Liam.Howlett@oracle.com
Cc: akpm@linux-foundation.org, maple-tree@lists.infradead.org,
	haoli.tcs@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] maple_tree: simplify mas_wr_node_walk for improved
 readability
Message-ID: <20240823073719.GA18274@systemsresearch.io>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)

Refactor mas_wr_node_walk to make the code more clear and easier to
understand. The main changes are:

1. Replace the forward-iterating loop with a backward-iterating loop.
   This simplifies the logic for determining the correct range
   containing mas->index.

2. Eliminate the ternary operator.

The new implementation maintains the same functionality as before, but
with improved readability. The performance characteristics remain
essentially the same, as we cannot predict which interval mas->index
will fall into.

Signed-off-by: Hao Li <haoli.tcs@gmail.com>
---
 lib/maple_tree.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index fe1b01b29..a180f54f5 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -2213,16 +2213,14 @@ static inline void mas_wr_node_walk(struct ma_wr_state *wr_mas)
 
 	wr_mas->node = mas_mn(wr_mas->mas);
 	wr_mas->pivots = ma_pivots(wr_mas->node, wr_mas->type);
-	count = mas->end = ma_data_end(wr_mas->node, wr_mas->type,
+	mas->end = ma_data_end(wr_mas->node, wr_mas->type,
 				       wr_mas->pivots, mas->max);
-	offset = mas->offset;
-
-	while (offset < count && mas->index > wr_mas->pivots[offset])
-		offset++;
-
-	wr_mas->r_max = offset < count ? wr_mas->pivots[offset] : mas->max;
-	wr_mas->r_min = mas_safe_min(mas, wr_mas->pivots, offset);
-	wr_mas->offset_end = mas->offset = offset;
+	wr_mas->r_max = mas->max;
+	idx = mas->end - 1;
+	while (idx >= mas->offset && wr_mas->pivots[idx] >= mas->index)
+		wr_mas->r_max = wr_mas->pivots[idx--];
+	wr_mas->offset_end = mas->offset = idx + 1;
+	wr_mas->r_min = mas_safe_min(mas, wr_mas->pivots, mas->offset);
 }
 
 /*
-- 
2.21.0


