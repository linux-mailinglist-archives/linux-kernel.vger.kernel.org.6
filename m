Return-Path: <linux-kernel+bounces-428785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E81469E1368
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:36:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADC952827B6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 06:36:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AB4418991E;
	Tue,  3 Dec 2024 06:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDttP+NQ"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2165178383
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 06:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733207768; cv=none; b=N1xSev+1fPRh0MBhL4MLbCNvANK5QUCxvE8irCleRenI/RNDXcQedRfbBK20Sojget75g2iVmaeHTOzpu3+FhvOCPga9rBxMBiVBNXL4BCIcYO7R/WPKjUhlvB1NYNEAUFl/pButnwLOLSF9LvSLVnuhob1Tf5qac0s1wYzmhKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733207768; c=relaxed/simple;
	bh=l8QoH+a17zrHGXf4IsTwc7lrGbYIj1ShZi4HgdIkmQg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o9dHoE0reWoTuG3uN0aC6rZRdIsndJlzMMJf6Qu9IybQPGBfaxozVd9wIzcFTXv6VqkLmw9L+usB1IXBbAfbGUR4K4qn9J1oJg76+fQ7YeFt8B1n6QISaLuemxyFDSmucvUMyRoZMFXFR1mSV2gDmBO549sCCnFzJn7Gfo/7l2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDttP+NQ; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-724e1b08fc7so4534164b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 22:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733207766; x=1733812566; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vp1UNmbJ/gu5FWAqocW3BGhGtpvA+GttFtsV2Ad3r8k=;
        b=cDttP+NQoempUVdTzA3CG8B6fwKrrFC/Pm6i+y3jV3PXWl1yFuINtP5pDioCtlWbsN
         S8Z7e1FkyiEuo4wbDSgtaaPOiOdzXceGijJEX+asa3Oq7fkurtj+gW97ABA5xMEKd+0b
         RywCnb2jBepbcOGfQLKEkTlyT0JxkSL4tDLTrFbetEMEGrZa4Oe+8buiwENQrPnYgf/U
         k/E0+jZPEwcd1tmbBwjJlJII5JJ4CE5dxr7zWI5dDvyChsK4Is3y2sDzo8Rtm52pIuvl
         w1UrmegM0mGRxRFXoUAuhhc7ingkZwy99crSz1zzre+JWBrgijDrCLyUqNKDJ4kPgJ5Z
         q7Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733207766; x=1733812566;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vp1UNmbJ/gu5FWAqocW3BGhGtpvA+GttFtsV2Ad3r8k=;
        b=fFfcWOw6/ODzIhFJkULrFma50W95Ix8CjDCXqt1AEJ48JXsK+n8wW4YfQWd/lBYnlT
         IYYBEoRubQp15Cys6HYnn5w0qsoRfrun4I7Yj/bmsgEhIcZiQAd/pMk2qNUqZ0HDRLg8
         DWeYiJB4sMptht1YseJ7nEgdNqNLO63sXfTBghHGSWrh7fpLYRroG9uRcOKnbi8YpaQf
         oxwFthk3YoddB0yzl6IS3z+5IqPkiJMGq7Vr6pEusfsSbBfF4BObjhVPqMQ8pIga9YcO
         6gxTadQRug0agACbSawCp01248GCtMHtr6311aprTX9fKpdUKLFC/RjqZDVU9gxA7gh8
         0J0w==
X-Forwarded-Encrypted: i=1; AJvYcCWM4zznYPWPF+bozXAvSSuf+UCZbnroCCgwbCcCflKOsJSjxnlG1r0q+bFeydUaGdAYD4iyU7tx2AX5e90=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuaT8MUem4AqyUg8DzP2P9EV8rFqKYDkNUDMp8Dc/ZlHEnz/Yb
	jK58Tcx+HRH3DGe1iHJQqVj9QIUGY/bgkoNxbczuUYpEQxVHg+xb
X-Gm-Gg: ASbGncttih3rSf5SvOl4oasoYourKC1xT4JSat7wF3z5qeXFgHdZ+d5uMvjGe2fgtcG
	nnFMKuRXQABoY4uV/RfoDhma4gtg8F6zSggU0CiNr40bQ8Vcxm+UqsRURXwaxSMnSOpEljwhhx9
	9b59IDSeZwydnRLk6xDNMsDfGyM3fVztQ+42P0OGoiIcIC9XHT8ARXp9D5gQvTKo4aFrTKoz+4/
	Jjzx2+7iFe74Mh1ZeiNYdASeiMP0Vp1U8x3PD+D2qCa2G+KeBPVZWGF7YhAJFKjYc8=
X-Google-Smtp-Source: AGHT+IFeMkWFu0DLtPLfp6ry7W5fCkDg6YGc2xwNYJOb+LdVLcWlKvBuWP97+YidvHil+KRvX+sEDw==
X-Received: by 2002:a17:90b:3142:b0:2ee:5bc9:75b5 with SMTP id 98e67ed59e1d1-2ef011dee0amr1980363a91.4.1733207765852;
        Mon, 02 Dec 2024 22:36:05 -0800 (PST)
Received: from vaxr-BM6660-BM6360 ([2001:288:7001:2703:3e54:ee47:354b:12ba])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2ee4b1b2c1csm7891610a91.9.2024.12.02.22.36.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 22:36:04 -0800 (PST)
Date: Tue, 3 Dec 2024 14:35:59 +0800
From: I Hsin Cheng <richard120310@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, vschneid@redhat.com, linux-kernel@vger.kernel.org,
	jserv@ccns.ncku.edu.tw
Subject: Re: [RFC PATCH] sched: Fix integer overflow issue of cpu weight delta
Message-ID: <Z06mz0GwBu2UP2bt@vaxr-BM6660-BM6360>
References: <20241202101344.97081-1-richard120310@gmail.com>
 <20241202104103.GN24400@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202104103.GN24400@noisy.programming.kicks-ass.net>

On Mon, Dec 02, 2024 at 11:41:03AM +0100, Peter Zijlstra wrote:
> On Mon, Dec 02, 2024 at 06:13:44PM +0800, I Hsin Cheng wrote:
> 
> > I think there's one point to concern, do we have a fixed range of
> > "tg_weight()" ? 
> 
> kernel/sched/fair.c:__sched_group_set_shares()
> 
>   shares = clamp(shares, scale_load(MIN_SHARES), scale_load(MAX_SHARES));
> 
>   if (tg->shares == shares)
>   	return 0;
> 
>   tg->shares = shares;


Thanks for clarify this ! So tg->shares should be clamped between (1 <<
1) and (1 << 18), No overflow issue should happen as long as we're sure
the value of "shares" won't exceed the range.

Then why don't we make the type of "tg->shares" to "int" or "unsigned"?
so the size of this member can be shrink. Is there any specific reason
to make "tg->shares" as "unsigned long" ? at the same time I want to ask
does "tg->shares" basically means the same as the task group's weight?

I didn't see any explanation about it in the documentation, or I
might've missed it.

Best regards,
Richard Cheng.



