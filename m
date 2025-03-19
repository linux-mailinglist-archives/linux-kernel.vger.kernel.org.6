Return-Path: <linux-kernel+bounces-568723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A495FA699B7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:48:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD3B8A43B0
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAE921421E;
	Wed, 19 Mar 2025 19:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b="ml95u2be"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C7420C48E
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742413575; cv=none; b=oLMZrgolHh5dqaltl8Jb7mWjZqtmHwAku5OmrPd+2VyD6AlrXWr3ohk3bnZDIwQtmNn+a957BVSLB7BFKWiQaWWDNlay+f25ojc0kia7LrCfH2AcQ15/ewyj70f1O3F10qklAsCV1IYq7RKbecO+C7ZHqaYFTYKmIaCAZ5A70Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742413575; c=relaxed/simple;
	bh=qlvN6iAULWo5vrmeRzfDI9VaAi52aMTIKGtEDdG7464=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fCy87LJ9pFZHTHQsLfoA80PcWt1KF945CpaUUwKdPTONnPSdT//Seha6etJeVEDFljosqqEJ0uKuR5miPU/EkXSBEMDMGX/6ws/h7ON76pohdtqp+Zf60uqMneKl+3+PBrVz0f99blUm93dnYrt18BiCw/4fuVES6WSe/Gq9sps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg-org.20230601.gappssmtp.com header.i=@cmpxchg-org.20230601.gappssmtp.com header.b=ml95u2be; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e8f8657f29so7486d6.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:46:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1742413572; x=1743018372; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EMGdQd+1GtsqkZyrmcturm7A0b+BWeuqV9nKfwmQHB8=;
        b=ml95u2benNxrgrQJ3ZM0L+z97sokjxIn2GBTzPM7FPsatCO7sQvBQb2a93eO5770Gc
         H+iK3fxOtHu+CpKdTCY5TbO6+TBe0b1gP6yjIDDMbzV4Rew7mHKN8/i4t1VfW65fgmlI
         NyZIotrseobBq4wt3CFOsi48GnDazeG4oEVExeESnHOvfVwhWkskjO7Db3NRWVF4B102
         rBJd/trhR/cz4lCf/XUAgU/VPp+86ePtnjfL3rDqXs400ARkfXw/mvZWqCfZhseWokNO
         xZcRnBxNeLc3dlbhymWa8m59zzdEnpJFPWBMwhEpTWJD4UrdgizCU5Dsf6XYmEKQBgK/
         F0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742413572; x=1743018372;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EMGdQd+1GtsqkZyrmcturm7A0b+BWeuqV9nKfwmQHB8=;
        b=g3M0byrDcE6d/CTSkx2A2VdhhXqVGNTVETcl+UlJEQbJqt+NLXKkBNGESS2yFCXeOH
         eZIKH8AlVniPXPv7y9EdT7oPrkXh72MPpPTp2RcPq205F8GFwO4JN+bt9RRx86vexJ5I
         UycYVFmvRLk53A+qtg3R6v/o1k3Toa4eOD83QScX2uyKW0WYzj1+Vj4NwUr/MibFT3oO
         D1qa8vBthMj4Qe4r3zkqasIWZqnTcFqG1V8JgUx9qHfHCS9aA2Wxuk1drqwEkk37/kg9
         osS4I8hr2XyiiRZ6BQJJryp6VM/pO6FbgnRTXXLILLsL/DB+E9usGumG9tiOpcrJ1jw/
         dBLw==
X-Forwarded-Encrypted: i=1; AJvYcCUTS729qvyf8IErQUzrc2/yXLUMJV4EWWJed1KGKyaEZVsabQAGCH8muFH5xtoNBVGii/c1zvKdqs6Axjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YytroEnQA5LyYQXKJPkwQtEpe48Zd4EsoWiQf09ZFp6vutEwzC/
	E7UN+7SwjRzffQNAdQ04zAmzoxkHXqW8y4XhX8Rwoi697I3vl1bS1lKTXAWvNCg=
X-Gm-Gg: ASbGncvRcvvvhcI2N8Em/PFQmdwQep2v8BIzIdA38cAP4Zzww7FMV9JcD/MQtL5LAP9
	u31x/aj4pyU3bxhEXBReCpVk6+t1oNIzEeDNYrc7/lJ5xKi1RojZkGrgGf3pGGnPMCeH5zffyfR
	8aqQrQdms/WsQAG3PFdhYi4TdykXvQz8QkbvVarKLjn/MGXke3YReubg5RBf+kZQ2WO1uiWPXc0
	VgffwUXRuARK33721OweuiLQR268nowpf2SOLfFNcXgDWXp+OBABzOQ7xBq8tsyVMLrGwu7r8OE
	fklWAnwPWopafOSGn6zAgaTGhT+MqDv/NickZXO5piA=
X-Google-Smtp-Source: AGHT+IGBPtC/y//GuXQrmvUuvNI+AJ1VTUL//CIpJG88EeiQgsUx/MStOJniyzmiXVM1kRKKRMEnkw==
X-Received: by 2002:ad4:4eae:0:b0:6e8:9dc9:1c03 with SMTP id 6a1803df08f44-6eb293a3360mr70586226d6.21.1742413572115;
        Wed, 19 Mar 2025 12:46:12 -0700 (PDT)
Received: from localhost ([2603:7000:c01:2716:da5e:d3ff:fee7:26e7])
        by smtp.gmail.com with UTF8SMTPSA id 6a1803df08f44-6eb036e8b00sm49213526d6.17.2025.03.19.12.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 12:46:11 -0700 (PDT)
Date: Wed, 19 Mar 2025 15:46:10 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Yosry Ahmed <yosry.ahmed@linux.dev>
Cc: Greg Thelen <gthelen@google.com>, Tejun Heo <tj@kernel.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH] cgroup/rstat: avoid disabling irqs for O(num_cpu)
Message-ID: <20250319194610.GF1876369@cmpxchg.org>
References: <20250319071330.898763-1-gthelen@google.com>
 <Z9r70jKJLPdHyihM@google.com>
 <20250319180643.GC1876369@cmpxchg.org>
 <Z9sOVsMtaZ9n02MZ@google.com>
 <20250319191638.GD1876369@cmpxchg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250319191638.GD1876369@cmpxchg.org>

On Wed, Mar 19, 2025 at 03:16:42PM -0400, Johannes Weiner wrote:
> On Wed, Mar 19, 2025 at 06:35:02PM +0000, Yosry Ahmed wrote:
> > On Wed, Mar 19, 2025 at 02:06:43PM -0400, Johannes Weiner wrote:
> > > (btw, why do we not have any locking around the root stats in
> > > cgroup_base_stat_cputime_show()? There isn't anything preventing a
> > > reader from seeing all zeroes if another reader runs the memset() on
> > > cgrp->bstat, is there? Or double times...)
> > 
> > (I think root_cgroup_cputime() operates on a stack allocated bstat, not
> > cgrp->bstat)
> 
> That was the case until:
> 
> commit b824766504e49f3fdcbb8c722e70996a78c3636e
> Author: Chen Ridong <chenridong@huawei.com>
> Date:   Thu Jul 4 14:01:19 2024 +0000

Nevermind, Tejun pointed me to the follow-up fix he's got already
queued up:

https://web.git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git/commit/?id=c4af66a95aa3bc1d4f607ebd4eea524fb58946e3

That brings it all back on the stack.

