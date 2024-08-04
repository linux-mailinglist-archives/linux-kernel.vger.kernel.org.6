Return-Path: <linux-kernel+bounces-274007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 560209470B9
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 23:36:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5117EB20C67
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Aug 2024 21:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893D3139590;
	Sun,  4 Aug 2024 21:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U2WFCUrO"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460AE1D530
	for <linux-kernel@vger.kernel.org>; Sun,  4 Aug 2024 21:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722807400; cv=none; b=khR9rnsrpjaaNB6FLsGZx3QLJbxy7IU9Fx6NaMqlUlwZqTxXzhFrg/lgGUZCREWL8SFcM9VdY7UBNW0d/dZkNB2vYW9BXs5oEZF1Q72ORh5rLQGmDG4VOUDZGSbeAmCJDGn9tkBNXVxJGMVcZHmTbvcrgGURlz077wCFhl9Dzv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722807400; c=relaxed/simple;
	bh=ZPEVfY3/nEAfvW+8VXAP7RTU+XtAjUToYEsl0tMMP4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jHVS6fH+UNdr+vB1VWmiX7kwD79X5oBmnR/0ParyXPZP2YSapFABaugKa4yT0Qzxj6sZtFvcP5ez4AFuyJZsCcmfrZ6IVPlhynzCvRVYCARVtl/zlN4uxGgP5CR96AHfBnX6Z5XjF7lqIEGLlJ5u9Bj3qOV2x9kmGzX2YpTFRAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U2WFCUrO; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44fdc70e695so1873431cf.0
        for <linux-kernel@vger.kernel.org>; Sun, 04 Aug 2024 14:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722807398; x=1723412198; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pm0EQe6cqyEwEGwUeusTWSiaU01FEzLSnQnEeovsSh4=;
        b=U2WFCUrOvgQ0a2aZTQU4VjqZ4GLz51a7/e+7gk9X5NQeQzpamYWwe3NVz3EWWsqBy4
         F6snc3yiTTi2rhYl4j/F54g47Va+f6WW5fPbiyzu2xNNJi3bSoyNdDfd/WwQJ3Po5lzV
         z0H0veXFjjUlHfyi3ntneSLPSK/ZHdAS2ynLiZ21cnm9wp03FcEDIW7BSaBtSPDDIX2d
         TRbdOJxsgAAfghxrH0PFowF7R0jvPPCdJlPIjkF6pCW6tOjbFL9QLDUB2OuPLQ1uxazI
         4JlPeWCq4yoLmGJhQ6O43uD2fbwNzQX88uN5AV1Uxcj4KxSd45S+sAmGAopkrrZIlMPg
         UCew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722807398; x=1723412198;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pm0EQe6cqyEwEGwUeusTWSiaU01FEzLSnQnEeovsSh4=;
        b=K82+7IHMwu/hQIztd/HVADc7hb4bO6ZWTx6W/+DFhmiUtBRXiKhfh1uVHTZ2zTYZLf
         dHf+GQdzhs4gQl3zmBIbdxGK6UQk59a8HkdEZFtfSLpMNbQ9vR2hZtzk6Om9fL+KH/+I
         EWFQvVS4Ly/jpSTsPAFtZZHvcD6o/avEBSU3Q4YRejX8ZNHQp3uIClQyX1eeMp+0s47h
         XNsksNDYbUgSZ9n3+lcElNPU9HmVg2AdGPPUPP/eDp96W1k3ZO3/DTo4Yf/ljcMIenlb
         20P+5nGvd4JaIogtkC32JT+72AG5phbLHLSacunuYTgrC/y6BFvi5JzDaAVBqea+s/GL
         Dqgw==
X-Forwarded-Encrypted: i=1; AJvYcCWziYGr/lJSzZKBDGKgJQzINPpDN5OvjMdYtwRElziNgZtmeuif1R7+lRhx/PsBRlrGwMzQZ+d08mVU8SpK4iIQC03EZ0MXMqCM5Y62
X-Gm-Message-State: AOJu0YypJ2fQ477d2kk+BIgkFxpInPKPF3rbw7JRk5SHKS1BKp3egnEo
	X4iGkHYPuSFFSGSW4AfcD1F2B5DXuLKEoIesMMfdv13qYr4udpli/wlsEnW+FQ==
X-Google-Smtp-Source: AGHT+IHF4cYuR9nH/fmhJovpmdm1W3c1Oo8PRMo0vGC1+crL4As5vBcywNlgSK3EOIFJcthYcEefQQ==
X-Received: by 2002:a05:622a:198a:b0:444:ccc5:f4c0 with SMTP id d75a77b69052e-4519b45531emr2747161cf.15.1722807397872;
        Sun, 04 Aug 2024 14:36:37 -0700 (PDT)
Received: from google.com ([2a00:79e0:2e28:6:3617:5ec9:bfc:ae3f])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4c8d6a4b04asm1430115173.154.2024.08.04.14.36.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Aug 2024 14:36:37 -0700 (PDT)
Date: Sun, 4 Aug 2024 15:36:31 -0600
From: Yu Zhao <yuzhao@google.com>
To: Hugh Dickins <hughd@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Barry Song <21cnbao@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH mm-unstable v1 5/5] mm/swap: remove boilerplate
Message-ID: <Zq_0X04WsqgUnz30@google.com>
References: <20240711021317.596178-1-yuzhao@google.com>
 <20240711021317.596178-6-yuzhao@google.com>
 <714e77d3-f629-bc06-4808-f7f33ac6872d@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <714e77d3-f629-bc06-4808-f7f33ac6872d@google.com>

On Sat, Aug 03, 2024 at 11:55:51PM -0700, Hugh Dickins wrote:
> On Wed, 10 Jul 2024, Yu Zhao wrote:
> 
> > Remove boilerplate by using a macro to choose the corresponding lock
> > and handler for each folio_batch in cpu_fbatches.
> > 
> > Signed-off-by: Yu Zhao <yuzhao@google.com>
> 
> Andrew, please revert this "remove boilerplate" patch (and of course its
> followup fix) from mm-unstable. From the title I presume it was intended
> to make no functional change, but that's far from so.
> 
> Under tmpfs swapping load, on different runs I see various badnesses:
> "Bad page" in __free_one_page(), Oops in __run_timer_base(),
> WARNING at kernel/workqueue.c:790 in set_work_data(), PageBuddy BUG
> at page-flags.h:1009 from __del_page_from_freelist(), something (I'd
> given up taking better notes by this time) in __queue_work(), others.
> 
> All those were including the fix to Barry's report: without that fix,
> the boot is drowned in warnings scrolling past too fast to be read.
> 
> (All the above were on the HP workstation, swapping to SSD; whereas on
> this ThinkPad, swapping to NVMe, no problem seen at all - I mention the
> swapping medium, but have no idea whether that's a relevant difference.
> In each case, MGLRU compiled in but not enabled. THPs and 64kTHPs active.)
> 
> Sorry, but I've put no effort whatsoever into debugging this: "remove
> boilerplate" didn't seem worth the effort, and my personal preference
> is for readable boilerplate over hiding in a macro.  If you prefer the
> macro, I expect Yu can soon come up with a fix (which I could test here):
> but for now please revert "remove boilerplate", since its issues get in
> the way of further mm testing.

Sorry for getting in your way, Hugh.

Apparently I didn't expect local_lock_t to be zero length, i.e., when
CONFIG_DEBUG_LOCK_ALLOC is not set. So that might explain why you only
had problems with one of the two machines, where it failed to disable
IRQ when rotating clean pages after writeback.

The following should fix it, in case you want to verify the above:

diff --git a/mm/swap.c b/mm/swap.c
index 4bc08352ad87..67a246772811 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -254,7 +254,7 @@ static void __folio_batch_add_and_move(struct folio_batch __percpu *fbatch,
 		folio,										\
 		op,										\
 		on_lru,										\
-		offsetof(struct cpu_fbatches, op) > offsetof(struct cpu_fbatches, lock_irq)	\
+		offsetof(struct cpu_fbatches, op) >= offsetof(struct cpu_fbatches, lock_irq)	\
 	)
 
 static void lru_move_tail(struct lruvec *lruvec, struct folio *folio)

