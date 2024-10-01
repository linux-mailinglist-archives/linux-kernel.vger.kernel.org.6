Return-Path: <linux-kernel+bounces-345060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF7C98B187
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 02:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE5FB1C219CC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 00:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203444A15;
	Tue,  1 Oct 2024 00:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Gtm6+k01"
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DF8A5F
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 00:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727743199; cv=none; b=s4/LmGQxqsG8r8e/igYnTgdfocjI2XmTqkkYpSU22m6+MfzzU1OppaWKtnqXyzIqjVMDTgvsZBOHh28a4o3W9zLICepc/6E2TG08WeFXNabED21WkHKYJ1ZW8HdhgdA+MNP3niNHM3HzlAKNuKF48bRWoJtydTr5H3XqgEl1n1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727743199; c=relaxed/simple;
	bh=vlezRcrXaSrGCIETKeo6A0+BoSNIAKThiHjFRmqAJvo=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=YKdXNfy+lrFCexLP+0LLmEGMmp7/TgvKk3FyDoa6ykSSVmUq/reBK5527F1RX25POJKIjkqJJ1gDIEBQ5iLyIl1YOfNTHgGFH6122IS8E7t5EHbcvfTMFH7jdhu2fxNB354NNWKaUM2OJRxcSuW1G+1XUTpfqj5Ze8p5CZobEDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Gtm6+k01; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727743198; x=1759279198;
  h=message-id:date:mime-version:to:cc:references:subject:
   from:in-reply-to:content-transfer-encoding;
  bh=vlezRcrXaSrGCIETKeo6A0+BoSNIAKThiHjFRmqAJvo=;
  b=Gtm6+k015RjhixToBBnsNhtf9St9+1t/jgrGKJbSGolGEffu9PtSdy7x
   mSUJ9noBzbHXfpy0SY9KsJ0P7nzI7W6k7jKMRLzDsVNQ2gLBTRjUxp2dv
   bXiQXSrUULxju9cm3J5GW/7heeFjvqnqGgywW+cJobTwD09ZSDMJtMbXy
   w=;
X-IronPort-AV: E=Sophos;i="6.11,166,1725321600"; 
   d="scan'208";a="132714498"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 00:39:57 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:1292]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.199:2525] with esmtp (Farcaster)
 id a3a05c75-bebd-434a-84d1-971a80553568; Tue, 1 Oct 2024 00:39:57 +0000 (UTC)
X-Farcaster-Flow-ID: a3a05c75-bebd-434a-84d1-971a80553568
Received: from EX19D003UWC002.ant.amazon.com (10.13.138.169) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 1 Oct 2024 00:39:57 +0000
Received: from [192.168.21.242] (10.187.170.9) by
 EX19D003UWC002.ant.amazon.com (10.13.138.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 1 Oct 2024 00:39:56 +0000
Message-ID: <9de4f491-eb64-4a1e-a375-7bc2d382fe5e@amazon.com>
Date: Mon, 30 Sep 2024 17:39:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <david.kaplan@amd.com>
CC: <bp@alien8.de>, <dave.hansen@intel.com>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <jpoimboe@kernel.org>, <linux-kernel@vger.kernel.org>,
	<mingo@redhat.com>, <pawan.kumar.gupta@linux.intel.com>,
	<peterz@infradead.org>, <tglx@linutronix.de>, <x86@kernel.org>
References: <LV3PR12MB926575E4BB94AE51EA662A3694642@LV3PR12MB9265.namprd12.prod.outlook.com>
Subject: RE: [RFC PATCH 27/34] x86/bugs: Add attack vector controls for
 spectre_v1
Content-Language: en-US
From: "Manwaring, Derek" <derekmn@amazon.com>
In-Reply-To: <LV3PR12MB926575E4BB94AE51EA662A3694642@LV3PR12MB9265.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D037UWB003.ant.amazon.com (10.13.138.115) To
 EX19D003UWC002.ant.amazon.com (10.13.138.169)

On 2024-09-12 21:15+0000 David Kaplan wrote:
> On 2024-09-12 13:16-0700 Dave Hansen wrote:
> > On 9/12/24 12:57, Kaplan, David wrote:
> > > And to be clear, I was trying to continue to support both.  But the
> > > attack-vector style is also more future-proof because when new issues
> > > arise, they would get added to the appropriate vectors and users
> > > wouldn't have to do anything ideally.
> >
> > That's a good point.  Do you have any inkling about how static folks'
> > vector selection would have been over time?
> >
> > For instance, if someone cared about CPU_MITIGATE_GUEST_HOST at the
> > original spectre_v2 time, did that carry forward to L1TF and all the way into
> > 2024?
> >
> > Or would they have had to shift their vector selection over time?
>
> In my view, the attack vector selection is a function of how the system
> is being used.  A system that runs untrusted guests and cared about
> spectre_v2 I would think also cares about L1TF, Retbleed, etc. They're
> all attacks that can leak the same kind of data, although the mechanisms
> of exploit are different.  In what I've personally seen, if you care
> about one attack along a certain attack vector, you tend to care about
> all of them.

This makes sense, but I'm not sure it is a meaningful simplification for
users. I think it'd be helpful if we had a few samples of how users
normally configure their systems. My hunch would be there are three main
camps:
  1) default for everything
  2) mitigations=off
  3) specify at least one mitigation individually.

I think you're saying group (3) is helped most because now they don't
have to understand each individual mitigation. But (3) is perhaps
already a very small group of users? Maybe it would help (1) as well
because they would get performance gains, but I'm skeptical of how many
would feel safe switching from defaults to a vector specification. If
they do feel comfortable doing that, they're probably closer to (3). Is
that fair?

Derek

