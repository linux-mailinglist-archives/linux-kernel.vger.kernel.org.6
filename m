Return-Path: <linux-kernel+bounces-244822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 940D892A9ED
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 21:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95501C20ECC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 19:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7976214E2E2;
	Mon,  8 Jul 2024 19:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGC8324E"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74AB814D719
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 19:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720467575; cv=none; b=e4Ft6hb7d+y7HKwXt4lxZ8F2aMGNdMqmKxJZ+VY+f6ps3KM3R/yOt2ytkDde5OytTdkzBxadIDntPC6HGIkTtmabu9LTgIVu3si664WaINmASICdJiQdyQopzl6ooNAbELaplWTJpZPZ1Div7aRQpOBAjNeDNQRaPZLXl1HY/Iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720467575; c=relaxed/simple;
	bh=9Yy57+0NY4iP1+UohLUcRRUUpE/3CexE7PCSmAjcM3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NDdHkNVFgtVYfoBWjEFTr8h18oE4JVIonwDRlQxzpPxr0k7b0grKwiBs5SQiIe8jnRkfn74WkO+CVAqbJLVLl6o4Cc54pKJsoIfF+mVd32tuG33kVp65wCX45O1Nea/cgu41NcAKedHhZoQ3T/3kzUpD+rLisydmQbTG7JGjh2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGC8324E; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1fb457b53c8so27181495ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jul 2024 12:39:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720467574; x=1721072374; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hwwh/fc0XM5V4Y8PffsSWcUFKuffPF5E1IjqiiU2ULM=;
        b=fGC8324EwLoN/zJ5DXLNlzjHofGWRZBxpeSdUE/MYjHWgzIXKQmXHJxf7HqaK9YICQ
         IlvIErmxMM0b+F0f8tVpOrjTwmcQFKyhdCYrdvgOwI4f53btdnWck/k2WkuacC5uG7f5
         usvu+DxYm4lmPeBzQDCIMcG405STzh95W+grrtw+QgKBoua9ECRCIS/bt+sWPqcoaLiu
         cFSotmyM0OCtT2lu0HJbOvCKQLoM6gDTd82819nC1HJBR0byisg6XyoFn1I+JEo8SwZT
         zifoUAiaZTBovHdhDNR8/A7rqQHEtcitfZyEgCgWy2xxCU31E2R0Exzh9wt3CqsyP8SO
         FjxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720467574; x=1721072374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hwwh/fc0XM5V4Y8PffsSWcUFKuffPF5E1IjqiiU2ULM=;
        b=CI6kqaBMRWf4vNt06YdPPNZcE4waYkWIyTC5NyKh1VKN5qzEVF9owQ2CvIJCGaeW62
         BRCPRzAFSk0SbBKzwLg9Fzyw1e2il3EdC7lx+3DUD0Ns9gQPDgGCROOAx8Yaa8zQZSoq
         SbeWUYCtB2QJWgtK/WpQSO+3OfpPMzn/+8JoJv9VgeTmzAvro41EXx5vpqasJeGzV3yU
         5LZv/UvJThEyYqym8G6RMUJXYUro7fgTAvmq3WKczSyr7dCbdplvhKK6oeyNAFwG0JPb
         NtBvU3Bs2kqS+7oCnQ3Z0HXjP8RSShCI2xpS3jDBqY/C/lD/EOAQANQ7v32XHZSi32Vt
         QFbg==
X-Forwarded-Encrypted: i=1; AJvYcCUDEAiQaOyRIc/6/ohkzE7h2aBZaGTW7gcNIsjUTW9tExmYng6SIaIvcSsthN1Ej0vlNL/ORirUuL/dczFLjkoOCEVLeY6eDVCNGT8W
X-Gm-Message-State: AOJu0Yx/4tW59EEjVCj1pJqrScVO1BhVk9s5HC2pSlYxmw8iG/nnHfT5
	wdlmtR9E6W5y8tO6Oh5NmXG2AoVwq/4rfn4yOtOWci+cnxT8oE2x
X-Google-Smtp-Source: AGHT+IEk3lQqomzRUoGWE1Ep7uEPxlZs/q3xfyAnm8klVZB9Mc4TadVsFzGrX61qtVXFp9XxxJY6tQ==
X-Received: by 2002:a17:902:e745:b0:1fb:7b01:7980 with SMTP id d9443c01a7336-1fbb6c2498fmr5348335ad.0.1720467573595;
        Mon, 08 Jul 2024 12:39:33 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fbb6ad0387sm2249065ad.274.2024.07.08.12.39.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jul 2024 12:39:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Mon, 8 Jul 2024 09:39:32 -1000
From: Tejun Heo <tj@kernel.org>
To: torvalds@linux-foundation.org
Cc: void@manifault.com, mingo@redhat.com, peterz@infradead.org,
	tglx@linutronix.de, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCHSET sched_ext/for-6.11] sched_ext: Clean up
 kernel/sched/ext.h
Message-ID: <ZoxAdMLsfMJYVtj8@slm.duckdns.org>
References: <20240623015057.3383223-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240623015057.3383223-1-tj@kernel.org>

On Sat, Jun 22, 2024 at 03:50:19PM -1000, Tejun Heo wrote:
> Hello,
> 
> While sched_ext was out of tree, kernel/sched/ext.h contained declarations
> and definitions which aren't ideal but are helpful for forward porting. This
> patchset cleans them up.
> 
> - for_balance_class_range() is removed and instead open coded in
>   put_prev_task_balance().
> 
> - Some declarations and definitions in kernel/sched/ext.h are moved to
>   kernel/sched/sched.h.
> 
> This patchset contains the following three patches:
> 
>   0001-sched_ext-Minor-cleanups-in-kernel-sched-ext.h.patch
>   0002-sched-sched_ext-Open-code-for_balance_class_range.patch
>   0003-sched-sched_ext-Move-some-declarations-from-kernel-s.patch

Applied to sched_ext/for-6.11.

Thanks.

-- 
tejun

