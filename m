Return-Path: <linux-kernel+bounces-207926-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8924A901DF3
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 11:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FFA928537F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A8B574056;
	Mon, 10 Jun 2024 09:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PbaNp1j0"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2653518C31
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 09:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011090; cv=none; b=m0VJcGvjRE2QdRnM2xxxGCjLJuH9Mh4y+bJSdZgQUavLtlFFMRui70rI+ieNvajGFsX5KQp6TUgYXQyyIYGQao2HH3/ECW/CW7tc32+xvP4fj/uF2oFUrQAtHFNSUfMeW3aLLlB443PUZ8srvi0Ran0s0VSAt3yIzAC6BC1N858=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011090; c=relaxed/simple;
	bh=gtteO0LSPQdQ3RdVgHLeMls4+WyFe2f9ktPoUGUolqo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JLPgFRMxGgon42zSCp3xaTeeoZFlybgkW+j53J0P5qFtCD9s3RnYiOX+OvPGP/YozKXQo55LDFJDz5Q3WyUaAtnnJWkIEedMlUCKUDmapNJk0UPdto89z4UoByOQirCgJNo30+5iE89um5kEInFtPSoW0SzZhoGLGuri+lsBQjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PbaNp1j0; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-35f1bc63981so878696f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 02:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718011087; x=1718615887; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6YXzyCsoRRHEYsnsz7snbNd/OFh2QNBazYlwAYKoZCA=;
        b=PbaNp1j07oK26owcoytYGJnocpgNpuJkt2VhB6NAdRYXh50rSJhlWCmRYcInF/cMfg
         3vr0blbkjx7yQRt914mZrcB48X9dFwUdssOS5Ir0uXXZokeOViCLh8UeYq2aKoKY9hQU
         iwDBxRyqnPIGvi6peqXp8peHHhH36DY4RYZBx/FXz/zQAyeNk3ZsI5iLUIqyi1Talu1i
         Rydeld2aeZ/DYS3p5bOyfdGwJi86lhY1bUoUVt9uyLdS3QS+uVxG0qjQW85KzYa2TOvx
         Raa0c5JKDMpwhavNIsy2k0tPSnaV3W3Bkwss1PfiPU/MyOMA8xGA1/EZM5VZ2OD45s8H
         blWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718011087; x=1718615887;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6YXzyCsoRRHEYsnsz7snbNd/OFh2QNBazYlwAYKoZCA=;
        b=w08mf/rSs9i/R8PDoh2ETnpbSOeMvqjEUsAMi6QqEizrurN6nGX8BdQW6AtSDRBuHx
         fDgY/l4ze4aKYlqFhuhLZsyOARxelxWTL+RY/YgpEbVA6PjRaXWZKlbXisa8DJVRrpLx
         c+rAlJDUU9emgoLOVA58zFFpHdSAh3BrKHEK58NLO7Yaz06OvSzvm9wj35ciyCKbuowz
         j6kRRHpx97VLkIepKNH0tma0rPmx6zAIelZ3AAooyyglpvSW5dWiWi0kOB7SpfOimC3c
         jRZCZqi0ZvISsOykdXP4+aVtIv3WaMm6e/iKihNGFn37bSVbIe9G6OKV/XNzSO/jg7oF
         Uu7Q==
X-Forwarded-Encrypted: i=1; AJvYcCV+SA5aqt2DJANw1Hc+puBBMPfgpjfQH+kLpvqg0uhE2LKdhyVrH/x2LY2qe+Q20CqEMZW/hMlaGevQ/AiiaOWGremAcu6lX23Cdudy
X-Gm-Message-State: AOJu0YyA0ASPB2QpSsIOTZRM4O75PDqsUOKE7gxHWdWIzRRFyE2o7e8R
	e1/MUC3lpeqpZSPHyhsUUAQ9UJ18f1BrnmYH1/+cSj+8oxxHV/bS3OTSjjwT2SbTU1KfFacmoDy
	D
X-Google-Smtp-Source: AGHT+IHMDyQqSuX8HIbrPi/FKnWIfUPZcRutT/SG9+8F+eYMPM18qeInUwLJ6ML/sEIBjJRLwQ2/SQ==
X-Received: by 2002:a5d:458c:0:b0:35f:ddb:70e2 with SMTP id ffacd0b85a97d-35f0ddb72f9mr6126276f8f.1.1718011087265;
        Mon, 10 Jun 2024 02:18:07 -0700 (PDT)
Received: from localhost ([102.222.70.76])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f048dddddsm7859065f8f.111.2024.06.10.02.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 02:18:06 -0700 (PDT)
Date: Mon, 10 Jun 2024 12:18:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH] bitops: Add a comment explaining the double underscore macros
Message-ID: <0ffbc9c3-7a7c-4cbe-bdb7-1041df44ce53@kili.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

Linus Walleij pointed out that a new comer might be confused about the
difference between set_bit() and __set_bit().  Add a comment explaining
the difference.

Link: https://lore.kernel.org/all/CACRpkdZFPG_YLici-BmYfk9HZ36f4WavCN3JNotkk8cPgCODCg@mail.gmail.com/
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 include/linux/bitops.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/bitops.h b/include/linux/bitops.h
index 46d4bdc634c0..b35a5c3783f6 100644
--- a/include/linux/bitops.h
+++ b/include/linux/bitops.h
@@ -29,6 +29,9 @@ extern unsigned long __sw_hweight64(__u64 w);
 #include <asm-generic/bitops/generic-non-atomic.h>
 
 /*
+ * These double underscore __set_bit(), __clear_bit() macros are non-atomic
+ * versions of set_bit(), clear_bit() and so on.
+ *
  * Many architecture-specific non-atomic bitops contain inline asm code and due
  * to that the compiler can't optimize them to compile-time expressions or
  * constants. In contrary, generic_*() helpers are defined in pure C and
-- 
2.39.2


