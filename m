Return-Path: <linux-kernel+bounces-236840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3340391E7B3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 20:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48ED284A73
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 18:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD7B216EB67;
	Mon,  1 Jul 2024 18:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WFk5+wn3"
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABEFF381CC
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 18:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719858913; cv=none; b=f+EeOUNPXQfTzCYYEpj3b9eG1gY/s9pjptPVVd/ygEL0AR7IWwGffS8KWNN3YqRb8f4Wl5pzceU0OuEK0xNF8XNmDIGH0/XVlWUOwB1KMxD9HNNPTSF8jFGicEg8oCZpLyUVmRqO+BLr29tWMaix5uYIa38sUo63ixb2GXvHW4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719858913; c=relaxed/simple;
	bh=XRD9+5Hp/AxmKvP/dHR9thQkxU3IsZa+pNzAr0D2acw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjseilE/9QU6jB/ApWPSM32Z3fHDMyZ22GjZRogy9zawozT9YdC+dT1YBt0nSqjXJz2FhctU0PwlP5IYoc80sPWCv0Yqdt/QLLZeQ27jWtA4oP4v2Elu25+TqO8t42ATiBuEUCRSNHbfg4WeaODac+ZBXeoLGmjpiqz3jTtF5yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WFk5+wn3; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-656d8b346d2so1864126a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 11:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719858911; x=1720463711; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date:message-id:reply-to;
        bh=u5fDYwHqagylc/gG2b6UzkgSO9G/V5kt1qLdPCrfUHU=;
        b=WFk5+wn3jeQStcMFmpAAp1vCWuWz+1lgHW76TYSEUgb/v7rLfIEAiAOob4jY/iFs00
         uWwdXgrahFpY4PiEQAkwfgPf5+zdnWKInH7253dZ/Sq+bfY7NYtG80F3rvmWBexIvSTt
         VLX+3sBe9dY+fhUPFXl0jcX1OZznk42BPQYvvW5KHeAVZWwKaGVy0DFkhC5kgY9YhJVe
         ZZv2AGXcji9btXE+uTxszhK4ZCGa5TEgOggowCK9EZ6p66IR+pzNzjCMwzXs+g/58WU1
         yYLRgVegv7fvhW/MECN/naR5KPp3EMJCcIxOjSvjm2Edw1h0jqgJ93hl0oR7gpRR+cVE
         rF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719858911; x=1720463711;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u5fDYwHqagylc/gG2b6UzkgSO9G/V5kt1qLdPCrfUHU=;
        b=GSJftqmq8ucPOw+bWAymGW3Iu5U+/hkQtPN5tHBialQQSQUjkSDyS1CLd1RSnJeEsY
         CR8Ohsd14VMAAhs87OUBCr1pUP4Fa20BsArGb35rL9URf3USSY0ebMpZHw2SmBf+fOXr
         TqIpVToAESxcbQp+7dNuG04oELCK5oq/kHlkzhFY/VBClqIkMQmu7Qca+2TsERWB4J0B
         mm1b/ARnSDRnv3v90yswTsq+Cvzn6s6AKV8uJQagdOlpM1YnOriTg6GPNEQ8Oyd77l4/
         TINOHdtGv+7vWvfuSCFXiPeL/OTCVv+WYcNppH+TsmaZP/SgZpiiQNQdiS9ldNFUo8XU
         peUw==
X-Forwarded-Encrypted: i=1; AJvYcCV9COK0f393kKR+tTyjSjhyYFFlXUKiUmlXiTzUsXQp9xTHWHq8tAG8RJAbZRNttk3FIRuW0UWB5em0HIhqM7WKqG/u+D+5aGY5O3eE
X-Gm-Message-State: AOJu0YxdKwc1BDezfZIkIRMTx4QlqczDQcSObyR3VDvl+ZCNej5GOzo6
	NvGpAJFq4UsdjvP2T8lZHc+vOL3wJXNV7TZ0o4A5Al1iuc/L58F98c3fvQ==
X-Google-Smtp-Source: AGHT+IF9TtNI4i4BF5Ba60WFG/q6KzZTWmuEiGb9mjbhO5m7EH4+eFvigCwt1/L2uKnvFL4VFabvJA==
X-Received: by 2002:a05:6a20:8425:b0:1bd:24e5:81f4 with SMTP id adf61e73a8af0-1bef61e7c36mr6371779637.45.1719858910699;
        Mon, 01 Jul 2024 11:35:10 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac1535cc8sm67904915ad.122.2024.07.01.11.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 11:35:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 1 Jul 2024 08:35:08 -1000
From: Tejun Heo <tj@kernel.org>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: [PATCH sched_ext/for-6.11] sched_ext: Swap argument positions in
 kcalloc() call to avoid compiler warning
Message-ID: <ZoL23Bq0hmeJ0F8a@slm.duckdns.org>
References: <ZoG6zreEtQhAUr_2@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZoG6zreEtQhAUr_2@linux.ibm.com>

From b651d7c39289850b5a0a2c67231dd36117340a2e Mon Sep 17 00:00:00 2001
From: Tejun Heo <tj@kernel.org>
Date: Mon, 1 Jul 2024 08:30:02 -1000
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

alloc_exit_info() calls kcalloc() but puts in the size of the element as the
first argument which triggers the following gcc warning:

  kernel/sched/ext.c:3815:32: warning: ‘kmalloc_array_noprof’ sizes
  specified with ‘sizeof’ in the earlier argument and not in the later
  argument [-Wcalloc-transposed-args]

Fix it by swapping the positions of the first two arguments. No functional
changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
Reported-by: Vishal Chourasia <vishalc@linux.ibm.com>
Link: http://lkml.kernel.org/r/ZoG6zreEtQhAUr_2@linux.ibm.com
---
Applied to sched_ext/for-6.11.

Thanks.

 kernel/sched/ext.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index f6e25545bfc0..ae9ec8f542f2 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -3812,7 +3812,7 @@ static struct scx_exit_info *alloc_exit_info(size_t exit_dump_len)
 	if (!ei)
 		return NULL;
 
-	ei->bt = kcalloc(sizeof(ei->bt[0]), SCX_EXIT_BT_LEN, GFP_KERNEL);
+	ei->bt = kcalloc(SCX_EXIT_BT_LEN, sizeof(ei->bt[0]), GFP_KERNEL);
 	ei->msg = kzalloc(SCX_EXIT_MSG_LEN, GFP_KERNEL);
 	ei->dump = kzalloc(exit_dump_len, GFP_KERNEL);
 
-- 
2.45.2


