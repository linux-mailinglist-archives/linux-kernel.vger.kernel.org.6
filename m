Return-Path: <linux-kernel+bounces-191728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C4E18D132D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 06:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D2A81C2129F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 04:03:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60AD17BD6;
	Tue, 28 May 2024 04:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QATxRP8r"
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EC151B806
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 04:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716869031; cv=none; b=S/PqNleGaOq15SMuKe5nloQwZkLFhRpzTYWC5uod1TZiiYz2FpjjtYYYfjW28TAW1mCxDSJdxZRyERF4kiEaic5+MKbTCb0RC3oZscq0JNmxw3uZ84X4QNOnAPhi/zkh9rfkce0Zh2IcCZRLe0yx1i4FeQmNuf6I26wDgd816Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716869031; c=relaxed/simple;
	bh=nvmQbMSy/xDnp4t59qze6qqL8MOKPZ+l9BJVovTrLUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qHT6WvAxlAl9HXrPUv/PEjrlpuPqTMsORturQmNdDwU21HtcauE5M548Sti8PKUqjJ8jAxQ/WCPZ7eCnDAGLIw4HcbUMU4N55+GD+bQjhbKJOsS/8pu/rGaa14jwOyqAy/q17xyCefUffuRcq8qe6REVWfl6jb0I1634jI0YrFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QATxRP8r; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-6819b3c92bbso324247a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 21:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716869029; x=1717473829; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M6CEMW9a4/PMVNxLukMbKPAVKxBTND9bevwPFka9vvQ=;
        b=QATxRP8rav7dsoxqPX844UZj2X1ixRZLe12Pq4RMltsaSeQnsoRSURAuJXhC/TbsBs
         s60BPjRCNBTYwiT+9RAHf0zjaih/qkJ73clUF9ErD8GjpkmTeeVC9+XG1V/0qUT4CpFU
         QpAv9K0roMUHRlYEDqCKCzzjKp5y5ZyPniU4B8EsZn+5U92T6mymgNVdi5hZ0KAteVIs
         60NDBk8gwVryxpzWQlOGSRKm6eibiPou8wX+k5lkdnCHqx49HBuHGuGA9ZxOCG6eHr9X
         zseTyvDrZTRlXvL5npgbahGp3KVB1PDdMLA9QLEeQnl/LG8/nUZ+4YMbkrA/gf62Hggk
         zapg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716869029; x=1717473829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M6CEMW9a4/PMVNxLukMbKPAVKxBTND9bevwPFka9vvQ=;
        b=jAhSL39++9hX/Gu33o5EcacSVMw+moxM0kASbyZenHSqpy6ndRpC6zIc+xv43xl06A
         /OiAtIhcVyYrHyTP8CcwCaq4Wj6shUYaQ6gcWIUmBnZfco5JiD0aI5wZV4tuKkTn71Bc
         iDou9YPpPfBxARp2nujDYj3fgJ2m8YkbGsiRy1X6vFqEU8AUJzxI2R/98UrhbiczjFI0
         28j5J1bNL7iehb5uKCK6PvB8BvUnl7iliE5lPH/U5QSGlRvA8cQlnHoztFBLfLr46OT+
         PH2e8yCR/kz1UPFBSeJajOaa78+a9LDy1iew1cZ56DqCbKveDj9Q1nH6EJt+q4EPkP/f
         eA+A==
X-Forwarded-Encrypted: i=1; AJvYcCVBWDkJM3f/+hfBpRnIsLIWt2AsorVuedBqrSRIJavA6De2g+//3sIR7bGEetkRYJidaScLrKvWonEUR0vAAAqEnb0Its+jVg0uJR02
X-Gm-Message-State: AOJu0YzM29Se4w8eBme6HM6mfGBUuEHhC6u1jwIXQxlm4K2zpF5UOu4e
	IS7p14K9brmDqu2ZKzUZB0QVdViP9VXh7u33lIhBF2r8DBQ72kHqv1G0U+k/b3Ma7gWiklbaFBO
	b
X-Google-Smtp-Source: AGHT+IGSS9psSLsvm6XTl81wgOYtz9x1Dc2PBuLQ0h/YskIif/iqhFMW0znjZ5di3n0CeT8e3P9Paw==
X-Received: by 2002:a05:6a20:431e:b0:1a3:b642:5fc3 with SMTP id adf61e73a8af0-1b212df06f3mr17629902637.41.1716869028413;
        Mon, 27 May 2024 21:03:48 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-682273c4503sm6645718a12.83.2024.05.27.21.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 21:03:47 -0700 (PDT)
Date: Tue, 28 May 2024 09:33:45 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Jagadeesh Kona <quic_jkona@quicinc.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Cristian Marussi <cristian.marussi@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, Taniya Das <quic_tdas@quicinc.com>,
	Ajit Pandey <quic_ajipan@quicinc.com>,
	Imran Shaik <quic_imrashai@quicinc.com>,
	Vivek Aknurwar <quic_viveka@quicinc.com>,
	Mike Tipton <quic_mdtipton@quicinc.com>
Subject: Re: [PATCH V2] cpufreq: scmi: Avoid overflow of target_freq in fast
 switch
Message-ID: <20240528040345.ghw6qkha3cka2pe5@vireshk-i7>
References: <20240520063732.11220-1-quic_jkona@quicinc.com>
 <20240520084744.sb2rk7l2pjf4whyd@vireshk-i7>
 <e3a7c295-28e8-465c-824f-6f14c5977726@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3a7c295-28e8-465c-824f-6f14c5977726@quicinc.com>

On 27-05-24, 15:26, Jagadeesh Kona wrote:
> 
> 
> On 5/20/2024 2:17 PM, Viresh Kumar wrote:
> > On 20-05-24, 12:07, Jagadeesh Kona wrote:
> > > Conversion of target_freq to HZ in scmi_cpufreq_fast_switch()
> > > can lead to overflow if the multiplied result is greater than
> > > UINT_MAX, since type of target_freq is unsigned int. Avoid this
> > > overflow by assigning target_freq to unsigned long variable for
> > > converting it to HZ.
> > > 
> > > Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> > > ---
> > > Changes in V2:
> > >    - Updated freq variable from u64 to unsigned long to keep it
> > >      consistent with the rate parameter in scmi .freq_set() callback
> > >    - Link to v1: https://lore.kernel.org/all/20240517070157.19553-1-quic_jkona@quicinc.com/
> > > ---
> > >   drivers/cpufreq/scmi-cpufreq.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > Applied. Thanks.
> > 
> 
> Thanks Viresh for the offline update on applying this patch to cpufreq arm
> tree. Please help share the git tree details of the same, since we need them
> to pick this change in Google ACK and downstream tree.

git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/arm/linux-next

I have pushed it out now, it will be there in linux-next soon. My
branch is not fixed, I may end up rebasing it. Ideally, you shouldn't
backport anything to android unless it end ups in Linus's tree, only
then the sha id will be fixed and guaranteed not to change.

-- 
viresh

