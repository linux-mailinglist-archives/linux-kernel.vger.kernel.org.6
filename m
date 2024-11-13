Return-Path: <linux-kernel+bounces-407055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 259FA9C67F0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 04:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F405B24D21
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 03:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF3716EC0E;
	Wed, 13 Nov 2024 03:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="RfelrYEg"
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A860E13635C
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 03:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731470314; cv=none; b=rtGlqxP91Ibup0QscNPvU8HFMudBLs1ogn9II5iXTXZWXMsdVSomArL5YuxVF4KvRjGgfGIKRCvuVkXUgvfRkQCg7aR+ZOaMnOvX59eA16RC6UtwvktcNV89RgUoN0L79gdA9yR9bOYY0RBygTBK6FalZuykc/Jl4URqqOZyYyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731470314; c=relaxed/simple;
	bh=qZSDRAstD6+LsD8bKwWMmd9nPmhGvEemaim3gzfrhik=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=nkTtSMhI2lbePtgXqhTkftFXNr8E1AeERrkB+lC0PTDyYncZT6217vrp04NS7+jXxgEW4anGbpHSomR9ZE2pwcKnZIFsMwXbWHwFKrv3wjSC4Qia/WctIK9AdJyUDxMW03ZF9GSnQ6MuX7f0kM/nezMtcblhrkKGUGB0rVqY+Kg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=RfelrYEg; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1731470312; x=1763006312;
  h=message-id:date:mime-version:to:cc:references:subject:
   from:in-reply-to:content-transfer-encoding;
  bh=qZSDRAstD6+LsD8bKwWMmd9nPmhGvEemaim3gzfrhik=;
  b=RfelrYEgUUrn+HFbavT6ZjjMhGoATkIpAWaTlK5PVuxpzLdXwtCER7dz
   de/TL2i3XBtL3XiqTroTzzcGqX0yzodPPFk8IAVJomdP2CVnZXihGM+yJ
   nQSfufbKM+oYxEjzt8EygdgNVD5HEPmrx40H7zBWEP+X0ToWa8dM7aqr+
   c=;
X-IronPort-AV: E=Sophos;i="6.12,150,1728950400"; 
   d="scan'208";a="146900756"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2024 03:58:32 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:64871]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.163:2525] with esmtp (Farcaster)
 id 41a465a8-86dd-49a9-9826-05806a4949e4; Wed, 13 Nov 2024 03:58:32 +0000 (UTC)
X-Farcaster-Flow-ID: 41a465a8-86dd-49a9-9826-05806a4949e4
Received: from EX19D003UWC002.ant.amazon.com (10.13.138.169) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.204) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Wed, 13 Nov 2024 03:58:31 +0000
Received: from [192.168.205.1] (10.106.101.35) by
 EX19D003UWC002.ant.amazon.com (10.13.138.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Wed, 13 Nov 2024 03:58:30 +0000
Message-ID: <f3ddabdc-39fa-45fa-97fd-d8508c2229c9@amazon.com>
Date: Tue, 12 Nov 2024 20:58:29 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <david.kaplan@amd.com>, <jackmanb@google.com>
CC: <bp@alien8.de>, <dave.hansen@linux.intel.com>, <hpa@zytor.com>,
	<jpoimboe@kernel.org>, <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
	<pawan.kumar.gupta@linux.intel.com>, <peterz@infradead.org>,
	<tglx@linutronix.de>, <x86@kernel.org>, <mlipp@amazon.at>,
	<canellac@amazon.at>
References: <LV3PR12MB92658EA6CCF18F90DAAA168394532@LV3PR12MB9265.namprd12.prod.outlook.com>
Subject: RE: [PATCH v2 19/35] Documentation/x86: Document the new attack
 vector controls
Content-Language: en-US
From: "Manwaring, Derek" <derekmn@amazon.com>
In-Reply-To: <LV3PR12MB92658EA6CCF18F90DAAA168394532@LV3PR12MB9265.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D046UWA001.ant.amazon.com (10.13.139.112) To
 EX19D003UWC002.ant.amazon.com (10.13.138.169)

+Brendan

On 2024-11-06 at 14:49+0000, David Kaplan wrote:
> On 2024-11-06 at 10:39+0000, Borislav Petkov wrote:
> > One of the arguments against those getting merged is, those are not going to be
> > *vector* controls anymore but something else:
> >
> > mitigate_user - that will mitigate everything that has to do with executing user
> > processes
> >
> > mitigate_guest - same but when running guests
> >
> > The third one will be the SMT off: mitigate_cross_thread.
>
> Right, so the way I think of this is that there is a cognitive process
> that administrators must go through:
>
> 1. Determine how the system will be used (e.g., am I running untrusted
>    VMs?)
> 2. Determine the attack vectors relevant for that configuration (e.g., I
>    need guest->host and guest->guest protection)
> 3. Determine which mitigations are required to enable the desired level
>    of security (e.g., enable vulnerability X mitigation but not Y)
>
> Today, the administrator must do all 3 of these, which requires in-depth
> knowledge of all these bugs, and isn't forward compatible.  The proposed
> patch series has the kernel take care of step 3, but still requires the
> administrator to do steps 1 and 2.  The provided documentation helps
> with step 2, but ultimately the admin must decide which attack vectors
> they want to turn on/off.  But the attack vectors are also forward
> compatible in case new bugs show up in the future.
>
> What you've proposed is up-leveling things a bit further and trying to
> have the kernel do both steps 2 and 3 in the above flow.  That is, the
> admin decides for example they have untrusted userspace, and the kernel
> then determines they need user->kernel and user->user protection, and
> then which bug fixes to enable.
>
> I'm not necessarily opposed to that, and welcome feedback on this.  But
> as you said, that is not an attack-vector control anymore, it is more of
> an end-use control.  It is possible to do both...we could also create
> end-use options like the ones you mention, and just map those in a
> pretty trivial way to the attack vector controls.

I think the further simplification makes sense (merge to mitigate_user
or mitigate_guest). I would say definitely don't do both (ending up with
end-use, vector controls, *and* existing parameters). Both just seems
like more confusion rather than simplification overall.

For me the major dissonance in all of this remains cross_thread. Based
on either approach (end-use or vector), SMT should be disabled unless
the admin explicitly asks to keep it (presumably because they are
running with core scheduling correctly configured).

What if mitigate_user_user defaulted to 'defaults' instead of 'on'? I'm
thinking 'defaults' meaning "do the things the kernel normally did
before thinking in these attack-vector terms." That way we could
differentiate between "admin didn't specify anything" and "admin said
they cared about mitigating this vector (or case)." That should make it
reasonable to disable SMT when mitigate_user_user=on is supplied, yeah?

> I'm nervous about only doing the end-use controls and not the attack
> vector controls because of the reasons outlined above.  For example, I'm
> thinking about some proposed technologies such as KVM Address Space
> Isolation which may go a long way to reducing the risk of guest->host
> attacks but may not be fully secure yet (where the kernel would feel
> comfortable disabling a bunch of guest->host protections automatically).
> With attack vector-level controls, it would be easier to turn off
> guest->host protection if the admin is comfortable with this technology,
> but still leaving the (almost certainly needed) guest->guest protections
> in place.

Personally I wouldn't put too much weight on the possibility of
disabling kernel mitigations with these future approaches. For what
we're looking at with direct map removal, I would still keep kernel
mitigations on unless we really needed one off. Brendan, I know you were
looking at this differently though for ASI. What are your thoughts?

Derek

