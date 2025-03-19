Return-Path: <linux-kernel+bounces-568139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20FA9A68EA4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 15:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22594885792
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 14:10:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DD01ADC97;
	Wed, 19 Mar 2025 14:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T2+TvJYS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D14A14A09E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 14:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742393439; cv=none; b=BoBKcRBq/adTqS1dU8WWnePENyMarOXwgXw+1wIPHJw44CAeJi5/ip/eDfJf4fPkiuKEMg6CC+mIMGu118CV0HRQGkHNsJJkxmACjGFPZ9if9r9GjfajC6sBS5o0DVMQ8U2MEA15P36Q+vrtYIEAYamklopPTCCFvKizQm/+xlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742393439; c=relaxed/simple;
	bh=HMNchjGaT/4aKnvwk1N2lv1hHxalOBT0JxFl+SwRSTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jTzahL9akm2bIc+iPPLO1pR1m3OKtihgDp6iFxN1SQTXykmXS1fla3Czr+4C4Mv/srCXC9lrg2B7YZTXWY54AJhjdrIh+ASnYW1mXbZKrn7IRDPN11TYAHxn8ZuIoBp00cDndGlHZigPuPWsrcraV6lvq8WBAcLsPmq67rrfKFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T2+TvJYS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742393436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5YfaaTsjeKp9QHHjLoM74t1Q+e1rTjBGJL9IkIlUuyA=;
	b=T2+TvJYSJh4OYMW/6Bq7BUStoE11iolV+zDav2Kd2PrbvUiRpsiyqkyOW3OvzdAZI9+0xN
	do3ls3ifBhDJuPYbdAkE83cT6EEaKHLxrxfSdkhOWJiWle5VEAlweqr6T7/ng/y/aBcvY0
	CO2LnukaGcLi6E26gVgUTdTtU4F8qsc=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-kAwXc0-fP6qkOp6OTfw9PA-1; Wed, 19 Mar 2025 10:10:35 -0400
X-MC-Unique: kAwXc0-fP6qkOp6OTfw9PA-1
X-Mimecast-MFC-AGG-ID: kAwXc0-fP6qkOp6OTfw9PA_1742393432
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7c57f80d258so1398228485a.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 07:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742393432; x=1742998232;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5YfaaTsjeKp9QHHjLoM74t1Q+e1rTjBGJL9IkIlUuyA=;
        b=bY4JVeAcNrtqt85bUVgPoNu2vwUwwNPeg2WVZGw2wipF7942wNvKP2slPjG0f5Lcfm
         l6hLVUjOh95hMijN3Hq0h5utsmbrSoWTIorCO26fgQT+ucQtzrAyozRMOwqj4F8FijFn
         tAje2pXKrSTOLaO+Ct+RZ1MqlzOflc5MmlqP0UjQEQmsxYgzktQc1YrCfhPUDvpWAEcg
         KHIXIYfDk7K+WfLfFxAzP5ObuzBZlccFWsOg9VaUuLB/asmp7cPUfNTev+x9t2WVndBB
         6BJF3afLcgI4ng3lc1JPLaczPwiwtXJE9+1hc3fs7+eeiQydvSaDNlwLpx8on7DLF5ho
         NvfA==
X-Forwarded-Encrypted: i=1; AJvYcCUHj4UjI03MvWzhYlv4gcuX7YiFD8wkISKHjocYogBu9uXXbBz+REGAf5TbWVZIBetq1IJvlHoY14oufkU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzFKwy7jvnwdL0Rv0Gls5E5vEPKeVLlSninIAWV3t/3HPUjwr5I
	J3V02WkdFKrObQxckcmm1QbyeZ/a+MazEhtYYQXB0Wk5xpelhgfFxbRMlDW2XwVNgliJFHCR6MA
	A50JrK7XxT2xMCuUBP44Pguu1KlvPOnoKuGiUuLcwur1OAMQKeflfNj5GYx+P2A==
X-Gm-Gg: ASbGncuhyPaButV9/A+1GrG3Iet/4LkA1Xsco0zgHNbmnnU0Dtnb5cd+oPKHP4b4pcl
	ywPuN3Elang2E7Rp0urdJ1oCtYw0NNSYda4hXxVpMGy1Qwgu76MXRx/xmi1Tg2ESYxrrOhRlXvA
	4yt5yoc/y967lfeR6nzf7tax/E/PufuUlPWeenh+5QEzRKXjNdOiqg9fxSdNywlcNknCkXa6Rmw
	qymGFuaAOvM3XPiEitSakVYOCTAe+TItXswHJXYeFWrfAeJIiIAxgcV6t7oKIbpC12alZzoIxa6
	+BrRdZk=
X-Received: by 2002:a05:620a:4115:b0:7c5:53ab:a722 with SMTP id af79cd13be357-7c5a828877amr363484685a.5.1742393432578;
        Wed, 19 Mar 2025 07:10:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEbv4DWuFiCjEaFXWxjsrrFoQIua6dHvV3yMHaR1gXg9WWkb+lQDG9W8w2LdUSWNz1T7niCsQ==
X-Received: by 2002:a05:620a:4115:b0:7c5:53ab:a722 with SMTP id af79cd13be357-7c5a828877amr363481985a.5.1742393432300;
        Wed, 19 Mar 2025 07:10:32 -0700 (PDT)
Received: from x1.local ([85.131.185.92])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d89815sm865870985a.91.2025.03.19.07.10.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 07:10:30 -0700 (PDT)
Date: Wed, 19 Mar 2025 10:10:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Marty Kareem <MartyKareem@outlook.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org, shuah@kernel.org
Subject: Re: [PATCH v2] [PATCH RESEND] mm/selftest: Replace static
 BASE_PMD_ADDR with dynamic address allocation
Message-ID: <Z9rQU64AAnrGlATV@x1.local>
References: <LV3P220MB18150CCCE6ADB3973208C245BAD22@LV3P220MB1815.NAMP220.PROD.OUTLOOK.COM>
 <Z9hycm5JEAcGFrd2@x1.local>
 <LV3P220MB1815A1451D408BB789C4387BBAD92@LV3P220MB1815.NAMP220.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <LV3P220MB1815A1451D408BB789C4387BBAD92@LV3P220MB1815.NAMP220.PROD.OUTLOOK.COM>

On Tue, Mar 18, 2025 at 10:35:33PM -0400, Marty Kareem wrote:
> Hi Peter,

Marty,

> 
> Thank you for your detailed review and suggestions.
> 
> I've updated the patch to address the race condition you highlighted. In this v2 patch, the following changes have been made:
> 
> 1. The PROT_NONE reservation is maintained until it can be atomically replaced.
> 
> 2. I now use MAP_FIXED to atomically replace the reservation with the intended mapping.
> 
> 3. The MAP_FIXED_NOREPLACE conditionals have been removed, as the atomic replacement works reliably across all kernel versions.
> 
> 4. The overall implementation has been simplified while ensuring robustness.

All look good here, thanks.

> 
> These modifications ensure that the memory region remains reserved until it is atomically replaced, effectively eliminating the race window and improving test reliability—especially in parallel test environments. Benchmark results show only a minimal performance impact (approximately 1.3x overhead vs. static addressing), and all tests pass successfully.
> 
> One note: I'm currently having some issues with git send-email and my Outlook account, so I'm sending this patch through Thunderbird as a plain text attachment. I’m working on resolving the git send-email setup for future submissions.

If your intention is to try working on something on Linux, let's try to fix
this.  Using attachment is not the normal workflow, so you'll need it
sooner or later.

I bet now with all the AI stuff recently, it shouldn't be hard to ask and
get something to try even without asking on the list, AI should be able to
look at your specific issue.

Then please send your v2 formally with git send-email.  You can start
testing that with sending to yourself of course.

Good luck,

-- 
Peter Xu


