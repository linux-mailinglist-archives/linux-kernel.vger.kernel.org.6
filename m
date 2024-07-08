Return-Path: <linux-kernel+bounces-244745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 530EA92A8DC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 20:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52B53B214FE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 18:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0853C14A4E0;
	Mon,  8 Jul 2024 18:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WNQTQbyU"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E905A14900B
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 18:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462581; cv=none; b=GuMPHgi3Qt7KHQ2U79ua0LnpjwQUsqJWSWNaw9NKWVsWPfTIPBninnnBFT6qhbamY/JMX5YoDSFAG9REDOIRtE/1ExHT1rhOattIYm417BPwSHtkMbDSSb1DwecOrwYoj+ccQp9QYdMpX/p7I+X2DMFZYlxXh1eKf2+gxaAi6WM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462581; c=relaxed/simple;
	bh=qoLJV0rGpO0BHOuUAFSnzNgl5JvCe/xXeB+FpY36BdM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h7TKwE8sdgVVAPqwVCI4f7hiZv9gSMJHQS5idvI/tM3QsNe0Fo8N3fsPP7wKe+life/SAACdVR8yAHw/wHiyPe29+v65LM2TxNhjEQg04dZ2UPMZnH1UG7t0XIfNIc7Q1lQ7owZT+jfKYpkLEtghcePhwJ1uvqkWp+mHh13GT2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WNQTQbyU; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1faad2f1967so35859065ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 11:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720462579; x=1721067379; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hVOu8tOcGRmgNUX6aW9mF78kuOpZ6BcRrm5ppPmrGAs=;
        b=WNQTQbyU7xz+1tZFA0wdiuBxWMZ7+k/LijSUuNkrMsL02wKuCKwuRwHkL/i2aFbAr0
         YS1o+VA5qUQr8JQzqCQExOcZ1tlruwHid373AcYpo36tAwvEOuYHqt+Mp618LWcHvrFC
         tgrsZNWF/ulvwdMq3BvRZeTIYl3HUCJxwLb/LWmQDNTk+VrZSb7DCxVdeXY0rd2H1BaB
         pJFJf6lcPk1A+EydZyeVsxJ9WkWYdlYtJcZJJwD7UbYW5mDxSEzyL+hsxzEKNLccTlsI
         FgmpRvj63Hu+Mz2adB1kEtc2SKZhw1jHjbJES0GrwduAQVdbQFRl3MGE21kznmCHtmRA
         g4Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720462579; x=1721067379;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hVOu8tOcGRmgNUX6aW9mF78kuOpZ6BcRrm5ppPmrGAs=;
        b=JD4hpErk+9OMMvz1MBwwX0nTdlGV82oFh+PmAgk2yYgfYyi55V2U+5Dvpc/xDzPXb1
         8whDfHHkDptD2bto59Ch8ca8+2KYYBbmL2wk7sv7jEOD9BvCXGNI2E/hcWhhwmyJi5wt
         E1d6WmFAp6Wz/S9E37cD19N9fKCa2utlx+RoV+RpIqHZYsre1KGfR6ga2cj2nXKFe9ke
         4vhrxCVVa1yj9oElUe5HNMZ3Ik9pWPXnOuHUYDo6jZ4rguR/tOihk1EfBIN0Y+J6FHtE
         Vgp+NlZF/C7Y3SwI+2oLvBO9UrQTVfCu/bkg8pl76bv4PH/MPzc1P+XAV1Kni0RkZzCp
         ggJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVG3h9KT9QvW/yIo+xJqdSedFd+eYyBHbBiIg/4GFSzdtEnpRmlxrgxhkeinTGoFiqGD1xQ71PFdU2kiS9Y1A0/SVtJEs1yn0s0gie1
X-Gm-Message-State: AOJu0Ywskl1yM6o3m7kOpzjYaMocKpZeBEtoNI7Jo+Y3w5hwz57X59jt
	+RbqupME6b22HJA5SjU6v1ha4RnhLZAqUdo8G3v593qL3kdw2c98oY5Rsw==
X-Google-Smtp-Source: AGHT+IGMbQAkkxgOLq1mfit424A5G1iUHBGxH8n+wcYI7QkWWHfqOnbzyWShboUMZbN5cc1DpV4kbQ==
X-Received: by 2002:a17:902:bd94:b0:1fb:3263:2e60 with SMTP id d9443c01a7336-1fbb7fc83c0mr327625ad.13.1720462579121;
        Mon, 08 Jul 2024 11:16:19 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-77d682b3909sm129760a12.88.2024.07.08.11.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 11:16:18 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 8 Jul 2024 08:16:17 -1000
From: Tejun Heo <tj@kernel.org>
To: kernel test robot <oliver.sang@intel.com>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>, oe-lkp@lists.linux.dev,
	lkp@intel.com, linux-kernel@vger.kernel.org,
	Lai Jiangshan <jiangshan.ljs@antgroup.com>
Subject: Re: [PATCH V2 4/5] workqueue: Put PWQ allocation and WQ enlistment
 in the same lock C.S.
Message-ID: <Zows8czlE6ji5Ezw@slm.duckdns.org>
References: <20240704034915.2164-5-jiangshanlai@gmail.com>
 <202407081521.83b627c1-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202407081521.83b627c1-lkp@intel.com>

Hello,

On Mon, Jul 08, 2024 at 03:54:19PM +0800, kernel test robot wrote:
...
> [ 2.269463][ T1] cpus_read_lock (include/linux/percpu-rwsem.h:53 kernel/cpu.c:488) 
> [ 2.273463][ T1] alloc_workqueue (kernel/workqueue.c:5152 kernel/workqueue.c:5730) 
> [ 2.273463][ T1] padata_alloc (kernel/padata.c:1007 (discriminator 1)) 
> [ 2.273463][ T1] pcrypt_init_padata (crypto/pcrypt.c:327 (discriminator 1)) 
> [ 2.277463][ T1] pcrypt_init (crypto/pcrypt.c:353) 
> [ 2.277463][ T1] do_one_initcall (init/main.c:1267) 
> [ 2.281464][ T1] do_initcalls (init/main.c:1328 (discriminator 1) init/main.c:1345 (discriminator 1)) 
> [ 2.281464][ T1] kernel_init_freeable (init/main.c:1364) 
> [ 2.285464][ T1] kernel_init (init/main.c:1469) 
> [ 2.285464][ T1] ret_from_fork (arch/x86/kernel/process.c:153) 
> [ 2.289466][ T1] ret_from_fork_asm (arch/x86/entry/entry_32.S:737) 
> [ 2.289466][ T1] entry_INT80_32 (arch/x86/entry/entry_32.S:944) 

Ah, this is unfortunate, so pcrypt is allocating a workqueue while holding
cpus_read_lock(), so workqueue code can't do it again as that can lead to
deadlocks if down_write starts after the first down_read. Lai, it looks like
we'd need to switch to workqueue specific locking so that we don't depend on
cpus_read_lock from alloc path.

Thanks.

-- 
tejun

