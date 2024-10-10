Return-Path: <linux-kernel+bounces-359850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 324E299917C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 21:00:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C91BB282B5C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 19:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941091F4FDB;
	Thu, 10 Oct 2024 18:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AP70HdO2"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0E51F4FB7
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 18:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728585361; cv=none; b=JgB54VP5J6EBXWTkGkzkxFRBBuq8m7M4+LMOv8XCtMpqvJOobd7MQOD2R8YywZfAhWdmqKxLF8V8Aa3S//uVqH7DEhGBZe/gCq3NOmAmARqisgwZeMAB5C+I2HaH8auPlFjS+2l3FUZOse5JWjnh/z9oAabbg7H5CMvQP7zNo/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728585361; c=relaxed/simple;
	bh=Bh4cvu1KBjW7YtQl14oFIxFTSqYuZw+pwe4eb5TK9RQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CulFBpxmv0qVMYxwTVzbLTJPNTJMAs1q8lW6Cddhz+gVD2NMuuNIQwv1d0eZrSbUhqune30aI2/pa/RQbxw8Pn/Jx+pyhxh/Z9IFG/sLwfV+NRmD5vFmsPKulrQ+aCeMeGME2BZ21GEnUT6ttoXVpSLBDcINtplJXTMnDAIYXm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AP70HdO2; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4311ac1994dso5243395e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 11:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728585358; x=1729190158; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YA/CbfE7oxW6xiw64WZhXy0TMYqF8Jc951OtJehnsTQ=;
        b=AP70HdO2WgYs4mtiY47qMoh4ExyATqxZtJ1xM7PHWMIc6ej/IQWK5+rLFooYxYJG4U
         qx1/zGiZIF51nSNfWlHA3xqBhyF09ps4jnT3ebNgcOMy8fRz96s+tfGhfZN61IhxLszc
         MowzFggilWe+kKnBmm5RnArwc8dvUinyM0/JvKAXjL2LyL21NebDf3+t5kXjYWnUWzv0
         MtIYbiNERdGeV7VfUaef3Ug7mK6H2CE35M427o8RlfJj/SQKhANuWi6BQAkZcwtiJ23/
         C71nsXmjrt8uHY8HK6GBXwyu3reacq13t6i6hXYqFI2uiwUiL4M3UUx3SudJwew2xwDQ
         ilTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728585358; x=1729190158;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YA/CbfE7oxW6xiw64WZhXy0TMYqF8Jc951OtJehnsTQ=;
        b=vXgRVWLsl/Mi2jotPbmxCelTH79hlOCPlh+2jNYas9HG7/7bd9I6SukCamahhGGRVX
         zBQq516HN5WofLOoYTeOnMos2JL5pv+Nb7HebG3AXdmOAgqMKFfbPGOWLQeeWMil9PRt
         RFiMANiWpwYcNQfNm2oR7AWn1oUwKJmrzGlzl79FFDWnfEmrz/16JKqnA97Ic46UiT11
         6hlzqfnVx8amhLHrZC/6DCO0LqJ09qVD2CQiZTmoWWtleIpHFOjVjTaJHXL/4XRqPlEB
         dyV9kMsYY2x3mjx1ylLECp8MgdC3C76nuDd7D3l8jEFvjSbcGYToYUgz6bohycRE14GJ
         wvbA==
X-Forwarded-Encrypted: i=1; AJvYcCXhchpu+OhB9OsgDhLr4j5L7qxHHf3j3WmtChnkalJX3QUDS17md4lXQ3qlNCd7X6lEBNwrUjaqatvIpMI=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywy077GXfvzoYpbektNwjodI0ruAhpNzKS0W1SCrZJRIjc6cN01
	Vd1IHPiVl+Ar+V+EHps3w9iMZWOddZJSvq7OdHAtUyTkvLXf9nElKGPVapvccmM=
X-Google-Smtp-Source: AGHT+IFG8EfIChDBnUNVC980rwXGS/R5Il/K4CbHJ0vE0tN5ohD5eVdklojXnnH8sToLawmLAcUlog==
X-Received: by 2002:a05:600c:511b:b0:42f:8515:e47d with SMTP id 5b1f17b1804b1-4311ce5dae9mr3567145e9.11.1728585357623;
        Thu, 10 Oct 2024 11:35:57 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431183567c8sm22744465e9.38.2024.10.10.11.35.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 11:35:57 -0700 (PDT)
Date: Thu, 10 Oct 2024 21:35:53 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH next] bcachefs: Fix bitwise math on 32 bit systems
Message-ID: <78e06425-2c26-4977-97eb-577ce8268d2a@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The ~0UL needs to be ~0ULL for this mask and shift to work correctly on
32 bit systems.

Fixes: bad8626ae088 ("bcachefs: CONFIG_BCACHEFS_INJECT_TRANSACTION_RESTARTS")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/bcachefs/btree_iter.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/btree_iter.h b/fs/bcachefs/btree_iter.h
index 6c9bc09c0597..f5f19340654a 100644
--- a/fs/bcachefs/btree_iter.h
+++ b/fs/bcachefs/btree_iter.h
@@ -362,7 +362,7 @@ static int btree_trans_restart(struct btree_trans *trans, int err)
 static inline int trans_maybe_inject_restart(struct btree_trans *trans, unsigned long ip)
 {
 #ifdef CONFIG_BCACHEFS_INJECT_TRANSACTION_RESTARTS
-	if (!(ktime_get_ns() & ~(~0UL << min(63, (10 + trans->restart_count_this_trans))))) {
+	if (!(ktime_get_ns() & ~(~0ULL << min(63, (10 + trans->restart_count_this_trans))))) {
 		trace_and_count(trans->c, trans_restart_injected, trans, ip);
 		return btree_trans_restart_ip(trans,
 					BCH_ERR_transaction_restart_fault_inject, ip);
-- 
2.45.2


