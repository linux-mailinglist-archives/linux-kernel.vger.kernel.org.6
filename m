Return-Path: <linux-kernel+bounces-346726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F15CF98C805
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 00:19:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A209C285C4A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:19:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 259DE1CB32B;
	Tue,  1 Oct 2024 22:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Obn4DVEj"
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 119ED199FCF
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 22:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727821141; cv=none; b=Bl11VgeCdrjqTruE5h7RTSRWNb8WCOm6fZLBSLNy4JIn3HfUiGdlqXtqIlSAFEfGx3Rl2S1UDInzU1WJcSiTCV5YVbvfOeWP8fKO5iIbwLQQFtlhjFU+e7dz37zqhYwYXC9BYqDTRjTBO01epHGkgbEu+PQ5XGNH3JRlZOagdaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727821141; c=relaxed/simple;
	bh=aTyIBE7VObwDbhSM0v69AgMy0/ueq6ZyBFCJKV46X60=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=Bg06nPVxL7exdaJ0OcGKQ4JxnoF+D+TXSnPth4NvEl68QNjHoXMe9UACQ+xR80HMhcY+cJ6OtrFzuzCVadguAYMSc7K9XyAFPOWrg4Yyk7YpvCq+Mry0ihHt4vSLQQlOdiT/YYNTE3wTOFjQUXtqmla9FE8jmy+TSvFBhEg7yqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Obn4DVEj; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727821141; x=1759357141;
  h=message-id:date:mime-version:to:cc:references:subject:
   from:in-reply-to:content-transfer-encoding;
  bh=aTyIBE7VObwDbhSM0v69AgMy0/ueq6ZyBFCJKV46X60=;
  b=Obn4DVEjZP/hGyYHWnpyWg14IUru5lk8teJ8pghvmea4wQu3fgn5NjN/
   M6PRQIHURHYRwtMSE5THHjIQueBJ1tEeJnCCIzy98dFAFiNhRONf10YCB
   tBQWo1rNqFCfLlXyocVkJNUyxXhq26R1gn7IU8HYn4hbVkWlEER1DhQNr
   U=;
X-IronPort-AV: E=Sophos;i="6.11,169,1725321600"; 
   d="scan'208";a="431826276"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 22:18:59 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:4043]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.57.100:2525] with esmtp (Farcaster)
 id 181aac30-157c-48ae-b571-10ac90363603; Tue, 1 Oct 2024 22:18:57 +0000 (UTC)
X-Farcaster-Flow-ID: 181aac30-157c-48ae-b571-10ac90363603
Received: from EX19D003UWC002.ant.amazon.com (10.13.138.169) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 1 Oct 2024 22:18:57 +0000
Received: from [192.168.12.162] (10.187.170.38) by
 EX19D003UWC002.ant.amazon.com (10.13.138.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 1 Oct 2024 22:18:56 +0000
Message-ID: <5793efb7-358f-4796-bdf4-985c41f80ae5@amazon.com>
Date: Tue, 1 Oct 2024 15:18:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <david.kaplan@amd.com>
CC: <bp@alien8.de>, <dave.hansen@intel.com>, <dave.hansen@linux.intel.com>,
	<derekmn@amazon.com>, <hpa@zytor.com>, <jpoimboe@kernel.org>,
	<linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
	<pawan.kumar.gupta@linux.intel.com>, <peterz@infradead.org>,
	<tglx@linutronix.de>, <x86@kernel.org>
References: <LV3PR12MB926589C779479C836DA4E51D94772@LV3PR12MB9265.namprd12.prod.outlook.com>
Subject: RE: [RFC PATCH 27/34] x86/bugs: Add attack vector controls for
 spectre_v1
Content-Language: en-US
From: "Manwaring, Derek" <derekmn@amazon.com>
In-Reply-To: <LV3PR12MB926589C779479C836DA4E51D94772@LV3PR12MB9265.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D042UWA004.ant.amazon.com (10.13.139.16) To
 EX19D003UWC002.ant.amazon.com (10.13.138.169)

On 2024-10-01 01:45+0000 David Kaplan wrote:
> On 2024-09-30 17:39-0700 Derek Manwaring wrote:
> > On 2024-09-12 21:15+0000 David Kaplan wrote:
> > > On 2024-09-12 13:16-0700 Dave Hansen wrote:
> > > > On 9/12/24 12:57, Kaplan, David wrote:
> > > > > And to be clear, I was trying to continue to support both.  But
> > > > > the attack-vector style is also more future-proof because when new
> > > > > issues arise, they would get added to the appropriate vectors and
> > > > > users wouldn't have to do anything ideally.
> > > >
> > > > That's a good point.  Do you have any inkling about how static folks'
> > > > vector selection would have been over time?
> > > >
> > > > For instance, if someone cared about CPU_MITIGATE_GUEST_HOST at the
> > > > original spectre_v2 time, did that carry forward to L1TF and all the
> > > > way into 2024?
> > > >
> > > > Or would they have had to shift their vector selection over time?
> > >
> > > In my view, the attack vector selection is a function of how the
> > > system is being used.  A system that runs untrusted guests and cared
> > > about
> > > spectre_v2 I would think also cares about L1TF, Retbleed, etc. They're
> > > all attacks that can leak the same kind of data, although the
> > > mechanisms of exploit are different.  In what I've personally seen, if
> > > you care about one attack along a certain attack vector, you tend to
> > > care about all of them.
> >
> > This makes sense, but I'm not sure it is a meaningful simplification for users. I
> > think it'd be helpful if we had a few samples of how users normally configure
> > their systems. My hunch would be there are three main
> > camps:
> >   1) default for everything
> >   2) mitigations=off
> >   3) specify at least one mitigation individually.
> >
> > I think you're saying group (3) is helped most because now they don't have to
> > understand each individual mitigation. But (3) is perhaps already a very small
> > group of users? Maybe it would help (1) as well because they would get
> > performance gains, but I'm skeptical of how many would feel safe switching
> > from defaults to a vector specification. If they do feel comfortable doing that,
> > they're probably closer to (3). Is that fair?
>
> I think these attack vector controls make it easier to configure say a
> system where userspace is trusted by VMs are not (such as with a cloud
> node).  Or a shared system where userspace is untrusted but only trusted
> users are allowed to run VMs, so the VMs are trusted.  I see those as
> potentially being more likely vs specifying mitigations individually
> (which I suspect very few people do).

Ok I see the potential for those cases. I still wonder whether the extra
complexity for everyone is worth the benefits to those users.

> If it was helpful, I could perhaps include these as examples in the
> documentation file.

I think the examples would help, yeah.

Derek

