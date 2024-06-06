Return-Path: <linux-kernel+bounces-203911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B2B98FE1EA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73AA51C256C8
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 422E214D2BF;
	Thu,  6 Jun 2024 08:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A13X19Zi"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B54F714D2AA
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664120; cv=none; b=YWBfo4IcWVV3/uJW919HdzrQxJZ6I7IX+uagC2O2PZgQs97CJzeCuIIgSDh1TJ0JpYa8SM45RSUZM9Kvh858VBAY5mf8S3BEzT1UrjMp1E89B7lY9YSoc7PN0/mZDlbbVj5UXbaUI4UIY1StzWd26CA3FnKVhkWh6tifLuSdysc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664120; c=relaxed/simple;
	bh=6KSEalqE21ArngKn9LVLlMftoFw59V3KJcO9fzXuW2o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZpNJPXgxa518F3xo80pg0K+LXTZeZJmCB4cE+hbTtNJ/v9cNiVwJ/fO3QAg75Clw8/i5bKGX0j56s5XoLVvc5Kwnv+E2pe552UjkoiR110KklxoUlhcPMghFqtVZyv7hSr8w8xOuWGdY2YWdsgXqGRQxPITEKLFQ7+g3dxOKSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A13X19Zi; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-70245b22365so556341b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717664118; x=1718268918; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=dk9BWKp9OYanKkL2Tvug+GGaXtEJQkSbsvBhVywEESU=;
        b=A13X19Zi1l95Qnq46j1jB0DbsCPhDMz2AvzVmTbN2XrU7Fg87NuGfjh5y1oZq/FAkT
         xHtWoel/9MoK00TAORoXHsjKwM3El6LMs6UkE7Shehyg0+cUn0FwiIJNSFkNyk5qI5FD
         3BrMHt30JDtC0g7DdurOBaziOnHYGLpkA2EdrJGGelaYjaUp+MOnP6Mxgyr/d6ymc4cb
         XUxhuvvdBN4vBsnmPEftXPzZnAO9VnmGWPxpr3mm2qZybNN14J8SGH37PL1CCLnQdmzo
         NpGApV7I0wdh5E/6w/1e1DbuMvNb6gN1Zv6x/op+gD+mAQAKd+OGPBu9Scmgh8kdX0JW
         8Bqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717664118; x=1718268918;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dk9BWKp9OYanKkL2Tvug+GGaXtEJQkSbsvBhVywEESU=;
        b=WyOFCLP429RWzmg9trxzhA9bB/BfDfrWrK6FQsJ8oPS7evKXQw4vFe811wQotyo5ah
         9O6XJxxs5+DNO0SfiljK3ugWrQVRSSxjCn7Jm3KHR3bcp2x6R8MVcgXj8xnCMCTQAXNq
         YLevf6XiRuiwTVXqSL92h7JLlm9HAYaCYdCV1Qtz107DHi8mDs7cd7ZTWlOonmbtTgbS
         4IwVPugQirU4mL/0fAR8Z4W+FugYcnnLr/9Ea2AB6UjaiX1SNG/YNuQU2C7oax13OT2I
         htJMV+xEIkRB6qAzdmsudXHA0wruGQIBMVapyPxYJmL5CYt3yy7fWx/xn/wNkcuNI+0o
         EaTQ==
X-Forwarded-Encrypted: i=1; AJvYcCWROaAwgXgFY+kPxs/OlCweFXPHdjnwO0GJGC77Y15xHMb4AFC3suBJUqssdH9uZjiO3d2weI3W3909gjP1SnKK98IngHPAdRAi2Vk4
X-Gm-Message-State: AOJu0Yw8QtkITfJ/5NWOq15PRenekwWkK6dOBSn2VxW66YYo+O87PQMu
	BxL7x2S8d5canRow92Aaugq1xASvwA9WQtFndGh9Jjp/+F8IR+G4m72WN7Zyl84=
X-Google-Smtp-Source: AGHT+IG9eLM1ZognviqtOg2/2n4CszKiPvgmkMnPj0BxOHDg6SxsW1TJbW5owPsBXzz4fBocMjS0cA==
X-Received: by 2002:a05:6a00:2307:b0:6ee:1b6e:662a with SMTP id d2e1a72fcca58-703e5aa047emr5587253b3a.32.1717664117811;
        Thu, 06 Jun 2024 01:55:17 -0700 (PDT)
Received: from localhost ([122.172.82.13])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd395458sm704148b3a.60.2024.06.06.01.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 01:55:15 -0700 (PDT)
Date: Thu, 6 Jun 2024 14:25:13 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Beata Michalska <beata.michalska@arm.com>, linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org, len.brown@intel.com,
	ionela.voinescu@arm.com, vanshikonda@os.amperecomputing.com,
	sumitg@nvidia.com, vincent.guittot@linaro.org
Subject: Re: [PATCH 1/1] cpufreq: Rewire arch specific feedback for
 cpuinfo/scaling_cur_freq
Message-ID: <20240606085513.pptx5dtjcvvg3zo4@vireshk-i7>
References: <20240603081331.3829278-1-beata.michalska@arm.com>
 <20240603081331.3829278-2-beata.michalska@arm.com>
 <20240603114811.oio3uemniib5uaa2@vireshk-i7>
 <CAJZ5v0j1bqhmKrJirw+WgEVDdszZ9xQSgmfazVKMVa8H6_5TSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0j1bqhmKrJirw+WgEVDdszZ9xQSgmfazVKMVa8H6_5TSw@mail.gmail.com>

On 03-06-24, 15:43, Rafael J. Wysocki wrote:
> On Mon, Jun 3, 2024 at 1:48 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> > Rafael,
> >
> > We probably need to decide on a policy for these two files, it is
> > getting a bit confusing.
> >
> > cpuinfo_cur_freq:
> >
> > The purpose of this file is abundantly clear. This returns the best
> > possible guess of the current hardware frequency. It should rely on
> > arch_freq_get_on_cpu() or ->get() to get the value.
> 
> Let me quote the documentation:
> 
> "This is expected to be the frequency the hardware actually runs at.
> If that frequency cannot be determined, this attribute should not be
> present."
> 
> In my reading, this has nothing to do with arch_freq_get_on_cpu(), at
> least on x86.
> 
> > Perhaps we can
> > make this available all the time, instead of conditionally on ->get()
> > callback (which isn't present for intel-pstate for example).
> 
> We could, but then on x86 there is no expectation that this file will
> be present and changing this may introduce significant confusion
> because of the way it is documented (which would need to be changed,
> but people might be forgiven for failing to notice the change of
> interpretation of this file).
 
> > scaling_cur_freq:
> >
> > This should better reflect the last requested frequency, but since a
> > significant time now it is trying to show what cpuinfo_cur_freq shows.
> 
> Well, not really.
> 
> > commit c034b02e213d ("cpufreq: expose scaling_cur_freq sysfs file for set_policy() drivers")
> > commit f8475cef9008 ("x86: use common aperfmperf_khz_on_cpu() to calculate KHz using APERF/MPERF")
> 
> "In the majority of cases, this is the frequency of the last P-state
> requested by the scaling driver from the hardware using the scaling
> interface provided by it, which may or may not reflect the frequency
> the CPU is actually running at (due to hardware design and other
> limitations).
> 
> Some architectures (e.g. x86) may attempt to provide information more
> precisely reflecting the current CPU frequency through this attribute,
> but that still may not be the exact current CPU frequency as seen by
> the hardware at the moment."

Right, with time the documentation is updated and now it has mixed
the purpose of both these files IMO.

> So the problem is that on Intel x86 with HWP and intel_pstate in the
> active mode, say, "the frequency of the last P-state requested by the
> scaling driver from the hardware" is actually never known, so exposing
> it via scaling_cur_freq is not possible.
> 
> Moreover, because cpuinfo_cur_freq is not present at all in that case,
> scaling_cur_freq is the only way to allow user space to get an idea
> about the CPU current frequency.  I don't think it can be changed now
> without confusing users.

Yes, this is a valid concern. The changes in documentation have been
there for many years and changing the behavior now is not going to be
an easy / right thing to do.

> > What should we do ? I wonder if we will break some userspace tools
> > (which may have started relying on these changes).
> 
> We will.
> 
> IIUC, it is desirable to expose "the frequency of the last P-state
> requested by the scaling driver from the hardware" via
> scaling_cur_freq on ARM, but it is also desirable to expose an
> approximation of the actual current CPU frequency, so the only way to
> do that without confusing the heck out of everybody downstream would
> be to introduce a new attribute for this purpose and document it
> precisely.

Hmm, having 3 files would confuse people even more I guess. I wanted
to get this sorted to have the same behavior for all platforms, but it
seems somewhat difficult to achieve now.

What about this, hopefully this doesn't break any existing platforms
and fix the problems for ARM (and others):

- scaling_cur_freq:

  Returns the frequency of the last P-state requested by the scaling
  driver from the hardware. For set_policy() drivers, use the ->get()
  callback to get a value that can provide the best estimate to user.

  To make this work, we can add get() callback to intel and amd pstate
  drivers, and use arch_freq_get_on_cpu().

  This will keep the current behavior intact for such drivers.

- cpuinfo_cur_freq:

  Currently this file is available only if the get() callback is
  available. Maybe we can keep this behavior as is, and expose this
  now for both the pstate drivers (once above change is added). We
  will be left with only one driver that doesn't provide the get()
  callback: pasemi-cpufreq.c

  Coming back to the implementation of the file read operation, I
  think the whole purpose of arch_freq_get_on_cpu() was to get a
  better estimate (which may not be perfect) of the frequency the
  hardware is really running at (in the last window) and if a platform
  provides this, then it can be given priority over the ->get()
  callback in order to show the value to userspace.

  And so, if the platform provides, we can use arch_freq_get_on_cpu()
  first and then the get() callback.

That would leave us to this change for the core, and yes a get()
callback for intel-pstate and amd-pstate:

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 7c6879efe9ef..e265f8450160 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -756,12 +756,8 @@ __weak unsigned int arch_freq_get_on_cpu(int cpu)
 static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
 {
        ssize_t ret;
-       unsigned int freq;

-       freq = arch_freq_get_on_cpu(policy->cpu);
-       if (freq)
-               ret = sprintf(buf, "%u\n", freq);
-       else if (cpufreq_driver->setpolicy && cpufreq_driver->get)
+       if (cpufreq_driver->setpolicy && cpufreq_driver->get)
                ret = sprintf(buf, "%u\n", cpufreq_driver->get(policy->cpu));
        else
                ret = sprintf(buf, "%u\n", policy->cur);
@@ -795,7 +791,10 @@ store_one(scaling_max_freq, max);
 static ssize_t show_cpuinfo_cur_freq(struct cpufreq_policy *policy,
                                        char *buf)
 {
-       unsigned int cur_freq = __cpufreq_get(policy);
+       unsigned int cur_freq = arch_freq_get_on_cpu(policy->cpu);
+
+       if (!cur_freq)
+               cur_freq = __cpufreq_get(policy);

        if (cur_freq)
                return sprintf(buf, "%u\n", cur_freq);


I think this will also make more sense from documentation's
perspective, which says that:

"In the majority of cases, this is the frequency of the last P-state
requested by the scaling driver from the hardware using the scaling
interface provided by it, which may or may not reflect the frequency
the CPU is actually running at (due to hardware design and other
limitations)."

-- we do this at the core level.

"Some architectures (e.g. x86) may attempt to provide information more
precisely reflecting the current CPU frequency through this attribute,
but that still may not be the exact current CPU frequency as seen by
the hardware at the moment."

-- and this at driver level, as a special case.

-- 
viresh

