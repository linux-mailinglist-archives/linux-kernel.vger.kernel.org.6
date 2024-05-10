Return-Path: <linux-kernel+bounces-176086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADBE8C29B9
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 20:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7B6EB22A39
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 18:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783BC17C98;
	Fri, 10 May 2024 18:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aq0aCjRF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DE01758D
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 18:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715364703; cv=none; b=TurLZ9omPe5G82LUachrsSCrbLxqOzBQN+ny+XSKitwLDD6v2Qkhb0OkESXgD34cu5PJVTjjJvI7MRzEz08z+DNaiNColMbOx5ArIpErMCZN4jBDcel3K4Z8aMMjzqMPpayZ9OQLRxGWc70hHlNq4pZjBGcPusBUuXCCVd7JksY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715364703; c=relaxed/simple;
	bh=Q5MhOeWzkKDVHI9xQ3mo+PeGPEJxI20edmH+SVw6WvM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e8Hxiz9sB8zpWv+MWv8Bd00hg2ZdANjMp94KcOg/0qmL7BFy/jYlXiIg1afzRDlEFVY6fNrWV+a8SCn/eGNJnD8PA7n0ZmM0qgMLT7gBlGsmHQ/qNmLygY5+9AFPP++Sw+qo+5pImas5X7T1IQGSq+5EIVuNd6JMpcBY1P0RZas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aq0aCjRF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715364701;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=iZAj8p2ZBBdchUgkHruzN7zSlWFG0wuGu3gOCA7sEg4=;
	b=aq0aCjRF0equ5uLJKKLH4ZwE1No2l78wCVSTs/t4kYaJ1FF8KoQXWNRS4ewzWNZsgv+Lyy
	e6NEPomeam89e+H1biTTlf+WlHNGYqUrm8CChBm6Yh4KLXi2Hs1/5YNflvWCgllaRZj2oY
	vG0nxiQv+OS7JuVwSq29bAFSizsGn9E=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-4OogqhwsMYC63SXDo7JjLg-1; Fri, 10 May 2024 14:11:40 -0400
X-MC-Unique: 4OogqhwsMYC63SXDo7JjLg-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3c9987974a6so797765b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 11:11:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715364699; x=1715969499;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZAj8p2ZBBdchUgkHruzN7zSlWFG0wuGu3gOCA7sEg4=;
        b=lvoU7DHBaIxyShK1UFLZtKs/vxucqEymac/1hUFxajWHiPh2RazlR1XGaYccG85A/y
         70Sc7+YXvbkYr429RHO5h2c/4zTuag32Y8iPQvZoVH8E1gr/01hGRH7qErbYFyDu74Wi
         hZGw742wCvS87UlpPjF/6drOAZu0kquiE/pAG2dDr2616eF5w3E5MKnXgUgqFSpUp1XF
         V3CToAubqB7+XA0PNUkgcnoKFS9TLvYNJsM6FPN+Uc+ksCvpLGKXktNMJWUzAL2ORm20
         Ji3FQofMSHX0geQXez7t4LtoephzP4Igru/zKHCapQvvxbLtrdWSKxKSfbsUMKlWqP/r
         g81g==
X-Forwarded-Encrypted: i=1; AJvYcCXlEo3SVe/fyRrYJ0xJ4YXg84Tdky9ujS9+qU8r4b2/s80GoqM/XNZuGoOMJNcwMwLDZJUxYL/sa9NS+hWQX3p5mYNXsEU43yTAKVu3
X-Gm-Message-State: AOJu0YytFt5yJVM7nDLiIB11o202HYmjAmKm13StsFIWY4EMDTg2Ztwb
	6vzQhNeNXl/xJ+5lqol/iC+TN3JstqLwLQ/RxDIOYqt80Wfa4rpOrCB5dM/HfQPlVo3FNBrKNB/
	tiAQGDTAtrXgZ22lP61rdrcXvxt+6d58ZaeRcBTwuzZAPKZDLVCYxP5A/COI8m7WKVVn2VA==
X-Received: by 2002:aca:2806:0:b0:3c9:6db0:bb86 with SMTP id 5614622812f47-3c997067d5fmr4017868b6e.28.1715364697580;
        Fri, 10 May 2024 11:11:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHKbPdG7xXrJvkXOHTiaKXszT9+rvpH4qg2EXL4pH8xR0FiBibejsqd2RX2rebLwBs+rr6XIA==
X-Received: by 2002:aca:2806:0:b0:3c9:6db0:bb86 with SMTP id 5614622812f47-3c997067d5fmr4017817b6e.28.1715364696328;
        Fri, 10 May 2024 11:11:36 -0700 (PDT)
Received: from hatbackup ([71.217.38.228])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6a15f1d73c8sm19389176d6.118.2024.05.10.11.11.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 May 2024 11:11:35 -0700 (PDT)
Date: Fri, 10 May 2024 14:11:34 -0400
From: "John B. Wyatt IV" <jwyatt@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>, linux-rt-users@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [ANNOUNCE] v6.9-rc6-rt3
Message-ID: <Zj5jVqzDMXGZtp7y@hatbackup>
References: <20240430110347.LCK9LAJr@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240430110347.LCK9LAJr@linutronix.de>

On Tue, Apr 30, 2024 at 01:03:47PM +0200, Sebastian Andrzej Siewior wrote:
> 
>   - The selftest with the cxgb4 networking driver raised a warnings.
>     Reported by John B. Wyatt IV.

Thank you for your work on the patch Sebastian.

QE said it fully resolved the issue in RHEL9.

-- 
Sincerely,
John Wyatt
Software Engineer, Core Kernel
Red Hat


