Return-Path: <linux-kernel+bounces-251127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6BF9300F8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 21:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D716AB224FF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 19:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9E64383B1;
	Fri, 12 Jul 2024 19:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t485Ih32"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50C52556E
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 19:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720812613; cv=none; b=pyuCd1K6Rvl/ZyiwgiQ1fJ5CiW186BQM0IzoTolMPW0L1xkHRlxq5Oree6XLX6qaJHJ/KToFA3PeG7xgJwmleWncldXrECr+WhZzriucqtSaguHr/A3vvM9rhHm9wIGOhCUPHX4769M6bslMaxRvIYLbBZdWqgPfGzECnsLet1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720812613; c=relaxed/simple;
	bh=J1S9Co/gsUdc+1Ynd0QU/qO2abhM1ZoN3G8Rcdw3+Yc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=JTVWrY4DTeFWjjzJSxBaeN8f5zRnpjNfZSONf1grTvOppUqx4u5sTa9C+2LiUg/D0dHFJBjtg6Q9sPK/XsN7ZkDvgdoZg0aA6PjjJp9jLUFyBxOIt6lFCrhVFKlO/FwejSns9M2+5nf9w8eYIq4pt5wshNfRpLo2RqQ0LbIMzxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t485Ih32; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-65ef46e8451so10622137b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 12:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720812611; x=1721417411; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jSam3OFYUTe13VOqHa17qoJuTdcVQF9rMQXxc9I3He4=;
        b=t485Ih32RA0LWmsHUxeRNy7ExFkrZDYEeaewkl/7DCdFuG6occGvzO4BVrWYtjsZE/
         prV+To05bCR7pkosC+zYi5EVpB/SY/B4rU+ykZrokfihdgpveNdspklpO9ScWlGUkAbf
         oRs8k3cTBd8wUOBUAL8r9ejxnxwVQd9cdCqfI4LTLdkVRjSAejW2jszlduc2x2ipmSlv
         ItnNI7lgu/D+ihPSEdwzY0U6LDSLUhQIpIujgm2Xwt15WQWUMCXXlgnFo1T1hbpMhvRS
         TpDtnJ7Z7MAxZIYKGzPYyTEAlQXcxD5PT+K9iKluvN6pzoh0uPj93ncfR4seGkDdcmB6
         jwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720812611; x=1721417411;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jSam3OFYUTe13VOqHa17qoJuTdcVQF9rMQXxc9I3He4=;
        b=ReN8QaGr+ZavbKzjjq7YZqGv96IMw6EVmpx4MB3L5Ndsvgm1vm7tih99ZKQLZ5l9qC
         5CCFs+qnzI9dSn8s083dxK/i/Rfg5rgEJgaHeM3imoYDSafWmF6iQ6g/Y1PikaqbQ56y
         G6gOXy75iY4dArMQlfx/2rhTI98SV4fFJqrStnJGudnUpwqQYgJKjDRNpl9ZBqY1LklZ
         5pQ3XYOjSyaDtTFC0SYHdZLivpAyycLgIYNrXZKCLjVQsNbJCDl5wdNozNxf1cMPa14i
         ScYXwKfTe33Z3/wlXYJ9xe8heDeekVbd9r4MfCdddcF+eRODLVTtNTHduPjvSF50oUU7
         lYeg==
X-Gm-Message-State: AOJu0YzAga8W1Kq4uuUvDSvi2otjDf6DED2hdgGh+SjmZM6zvcNggoeq
	7vzhuo/ch0AkbfE82BKjJTk2I3UPa55dlypz3PkQNT40eFYziUFySGqpywcbpu44tUkm1Z7yCVB
	rxA==
X-Google-Smtp-Source: AGHT+IHDX6aq/IiCOt698IqpZ4MrQ2IJcf1EwlXXpiuV+/DiG8Es8j3Np/1XnI0oCcG1Eu1pGoFCApjvBVw=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:6381:b0:64b:7f7e:910f with SMTP id
 00721157ae682-658f07d5705mr557917b3.7.1720812610774; Fri, 12 Jul 2024
 12:30:10 -0700 (PDT)
Date: Fri, 12 Jul 2024 12:30:09 -0700
In-Reply-To: <SA1PR11MB67349D5D7B0E26A49B8A1112A8A62@SA1PR11MB6734.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240207172646.3981-1-xin3.li@intel.com> <20240207172646.3981-10-xin3.li@intel.com>
 <ZmoYvcbFBPJ5ARma@google.com> <SA1PR11MB67348BD07CCCF8D52FCAC8FEA8A42@SA1PR11MB6734.namprd11.prod.outlook.com>
 <ZpFH86n_YY5ModwK@google.com> <SA1PR11MB67341A4D3E4D11DAE8AF6D2EA8A62@SA1PR11MB6734.namprd11.prod.outlook.com>
 <ZpFZg-9MTveHfn_4@google.com> <SA1PR11MB67349D5D7B0E26A49B8A1112A8A62@SA1PR11MB6734.namprd11.prod.outlook.com>
Message-ID: <ZpGEQRJppKfp1tF8@google.com>
Subject: Re: [PATCH v2 09/25] KVM: VMX: Switch FRED RSP0 between host and guest
From: Sean Christopherson <seanjc@google.com>
To: Xin3 Li <xin3.li@intel.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, 
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, 
	"linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>, 
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "corbet@lwn.net" <corbet@lwn.net>, 
	"tglx@linutronix.de" <tglx@linutronix.de>, "mingo@redhat.com" <mingo@redhat.com>, "bp@alien8.de" <bp@alien8.de>, 
	"dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>, 
	"hpa@zytor.com" <hpa@zytor.com>, "shuah@kernel.org" <shuah@kernel.org>, 
	"vkuznets@redhat.com" <vkuznets@redhat.com>, "peterz@infradead.org" <peterz@infradead.org>, 
	Ravi V Shankar <ravi.v.shankar@intel.com>, "xin@zytor.com" <xin@zytor.com>
Content-Type: text/plain; charset="us-ascii"

On Fri, Jul 12, 2024, Xin3 Li wrote:
> > > > E.g. if it's somewhere in task_struct, then kvm_on_user_return()
> > > > would restore the current task's desired RSP0.
> > >
> > > So you're suggesting to extend the framework to allow per task constants?
> > 
> > Yeah, or more likely, special case MSR_IA32_FRED_RSP0.  If KVM didn't already
> > have the user return framework, I wouldn't suggest this as I doubt avoiding
> > WRMSR when switching between vCPU tasks will be very meaningful, but it's
> > easy to handle FRED_RSP0, so why not.
> 
> Great, I will take the patch.
> 
> It looks to me that this also works for KERNEL GS BASE MSR, no?

I don't think so, because the kernel expects MSR_KERNEL_GS_BASE to be accurate
when querying GS.base for the current task:

  unsigned long x86_gsbase_read_task(struct task_struct *task)
  {
	unsigned long gsbase;

	if (task == current)
		gsbase = x86_gsbase_read_cpu_inactive();
	else if (boot_cpu_has(X86_FEATURE_FSGSBASE) ||
		 (task->thread.gsindex == 0))
		gsbase = task->thread.gsbase;
	else
		gsbase = x86_fsgsbase_read_task(task, task->thread.gsindex);

	return gsbase;
  }

