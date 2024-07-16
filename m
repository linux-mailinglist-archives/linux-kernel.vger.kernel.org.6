Return-Path: <linux-kernel+bounces-254490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ACD79333C8
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 23:45:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCBD02893BB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jul 2024 21:45:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0551143C6F;
	Tue, 16 Jul 2024 21:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TMYa20oc"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8625F143C61
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 21:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721166295; cv=none; b=CHY2kuisjPaq7sPCgDhxNo2gd/1O3snGfiPMCB8lM9cIf76GCqa/pGkLbe5fltThxjMVNkeO5V+XYk8oDyEJOJYur+uhfLGW9Il8UPJfL5dvRLqSRhwIXzRG1bbqS4c+VYxFLHngxBOAegju2/dqCv1hQRjV6Y50g6m9yCi3EeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721166295; c=relaxed/simple;
	bh=8nBhiEzFN+f08jm8+W3J1C0juGTqCvjqvu5vrAdIElE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tm+ID2zDGFBK944OLkSWkmQ81VybkqGxYDOUZ88R7BUnxcW4rfrh9h9GB8L60CcJpiEnu722qrNxRxOr/cO4SzWHvzyTWQIWnhcHJLy3+yRslF9NoeTcqr7BWR3k9c855LWnjQtLtwjuseRgU8bDsyklGuXdDeOPy7lCTdeivSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TMYa20oc; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1fb1c69e936so34013755ad.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jul 2024 14:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721166293; x=1721771093; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MkfvNf6ZVlqBUNjUxPsNez75zfekPIaFAtHPpadvNSo=;
        b=TMYa20ocm5hbFxIHSU0FHFseNkMcC0YiRM3rPG4Lni4K/HJKlhmFW2gETRwErXfWP2
         1DM49IB/6cynAGaFvshDuZFST9E0LaZ46DuHK4L12eWlR+qv8avD9DVm3x9eJeYxhVMY
         CFL4EidF2VHlS1Cux6dQ5zrM3Q4w9FjVHhSNQJAEK/8Ci2HU8MRqopG6dLbl0InVD68g
         kPQaLTihMi2RdHiZ3B2LCE+4E7zFjSpRAryW8qig+0MLnXX1bIcOk9m9GTYE+6ycgtqZ
         T14Rkrb2A2uceYSuASRoGakiSXB63hFG2SAobIgy/wRVV4WwSgscYA7Z4YYDCYI1r74U
         RX/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721166293; x=1721771093;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MkfvNf6ZVlqBUNjUxPsNez75zfekPIaFAtHPpadvNSo=;
        b=IFgNRzHC6+madTWnoenuNgm4Pw+7lVL3XFrO/TC4R7WL1Cb5bOkBeXLijf5+Vr4Bcw
         K5g7xTusp9twJTlC+uc/iQXR7/atVdhkWVahSfkBU+9eTGLKDB2tMHVr9X5uHPhtLxDK
         XZl0pzXuUyMTnRlW0UKp5VesR+icE4ivvl7/gzWevMtyfb/6h861vP8lDXkmzYgPzFy4
         F/2tSr9GqSWrOvUownPN1ZHWiBV65CgWtkTBWcS+le9wA5QtreK7XJONgOEuRronmPmO
         wd1pbLMw42Vs36OIsuQcGk3TYf4RxUk4hezbXRvTFXPrk6qRsqD0mlc6QRlFveBUALws
         LaMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVc4yQGpZ1OkMeRmY1SW74Vh3bCTdH2OXJvkIslGap/1j++/AG9RKw75HDILbAEr7XT6QYGRZWV9orVwZJL2LPbKLn2wjj6uE0tStw1
X-Gm-Message-State: AOJu0Yy+l9BFM5/fuGC9x7G0Jb0ihDGmTVRuPNsZnPhn1MtEM9rBO9WH
	I95CV4Kf8kp7TqyvdhMNp1Oa4e81NLiyEdzrbGR28hOAsA3xyN5wmkE0Jg==
X-Google-Smtp-Source: AGHT+IH3PquItZhoz4iKrFAbEuM/5Ekl6rDedD0/z8vEw2k4CdpNORDey7hLxAuKWNQkJZf+m/zYcw==
X-Received: by 2002:a17:903:41cd:b0:1fb:a1c6:db75 with SMTP id d9443c01a7336-1fc3d931b81mr30178995ad.6.1721166292730;
        Tue, 16 Jul 2024 14:44:52 -0700 (PDT)
Received: from localhost (dhcp-141-239-149-160.hawaiiantel.net. [141.239.149.160])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fc0bc45107sm63330685ad.249.2024.07.16.14.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jul 2024 14:44:52 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Tue, 16 Jul 2024 11:44:51 -1000
From: Tejun Heo <tj@kernel.org>
To: Vishal Chourasia <vishalc@linux.ibm.com>
Cc: David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org
Subject: Re: sched_ext/for-6.11: cpu validity check in ops_cpu_valid
Message-ID: <Zpbp02N6bAE8mNXb@slm.duckdns.org>
References: <ZpLSEHskvXXv4EoR@linux.ibm.com>
 <ZpSw7PvW1Teh6tNV@slm.duckdns.org>
 <ZpYX7BgiirBmwLa3@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZpYX7BgiirBmwLa3@linux.ibm.com>

Hello, Vishal.

On Tue, Jul 16, 2024 at 12:19:16PM +0530, Vishal Chourasia wrote:
...
> However, the case of the BPF scheduler is different; we shouldn't need
> to handle corner cases but instead immediately flag such cases.

I'm not convinced of this. There's a tension here and I don't think either
end of the spectrum is the right solution. Please see below.

> Consider this: if a BPF scheduler is returning a non-present CPU in
> select_cpu, the corresponding task will get scheduled on a CPU (using
> the fallback mechanism) that may not be the best placement, causing
> inconsistent behavior. And there will be no red flags reported making it
> difficult to catch. My point is that sched_ext should be much stricter
> towards the BPF scheduler.

While flagging any deviation as failure and aborting sounds simple and clean
on the surface, I don't think it's that clear cut. There already are edge
conditions where ext or core scheduler code overrides sched_class decisions
and it's not straightforward to get synchronization against e.g. CPU hotplug
watertight from the BPF scheduler. So, we can end up with aborting a
scheduler once in a blue moon for a condition which can only occur during
hotplug and be easily worked around without any noticeable impact. I don't
think that's what we want.

That's not to say that the current situation is great because, as you
pointed out, it's possible to be systematically buggy and fly under the
radar, although I have to say that I've never seen this particular part
being a problem but YMMV.

Currently, error handling is binary. Either it's all okay or the scheduler
dies, but I think things like select_cpu() returning an offline CPU likely
needs a bit more nuance. ie. If it happens once around CPU hotplug, who
cares? But if a scheduler is consistently returning an invalid CPU, that
certainly is a problem and it may not be easy to notice. One way to go about
it could be collecting stats for these events and let the BPF scheduler
decide what to do about them.

Thanks.

-- 
tejun

