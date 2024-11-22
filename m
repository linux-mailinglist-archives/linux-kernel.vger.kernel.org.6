Return-Path: <linux-kernel+bounces-418455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 363959D61D4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:15:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB09F160830
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 16:15:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10DE1DF75E;
	Fri, 22 Nov 2024 16:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="cADUQG7g"
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA9F1D9598
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732292119; cv=none; b=NZBnajKvGIPjFueBN9DglVgRN1WawdTjUzgLAN33eUI0cHeIwdEwcWlIWej/z0Dfw9Tiu/xZEZb51Z8g3arZnVzqhwKOGOY9T5zQ2GS2tIR05VVDTgXE3vvUyPhxRQEKXbNR59WKv+k/7zDZCLTzz+ooygw5wp5oe4wxspAH3M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732292119; c=relaxed/simple;
	bh=Gu0n2ULPyKWMJ8niorrKnik/nENpGrAT+3JB8wMdbuQ=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=C2V1YZOPKarYT+PjQLf3ejoM+deIM5eQD9u/JW5Oq9xmJS6Fo30DLLOC8rcHaw5hjoW1rsPlM4w1DkFVtEZhaAqxPijITr1wmPULnQrQi5iBV+or6REbuYhIXFSUfSs+FdOrdsxFQKEdZeAeKParI7sjGGla4UcrlimqZ9Yo/3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=cADUQG7g; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732292118; x=1763828118;
  h=message-id:date:mime-version:to:cc:references:subject:
   from:in-reply-to:content-transfer-encoding;
  bh=Gu0n2ULPyKWMJ8niorrKnik/nENpGrAT+3JB8wMdbuQ=;
  b=cADUQG7gOKQl1OvUUtsa/to7NRuIgnxBBcodyGFTGK4ot8FKOKW3ksbg
   XJDi2NHSeGDwg6UpgxzIebwDi9KCMffRUmqsI+hWrqyfDQQv7q4reYkcL
   gwJHivd3S68L9XXsS+ZtNFkbo+6unyZGRk1+/ObmU2juXcAsEFXdcI7sD
   0=;
X-IronPort-AV: E=Sophos;i="6.12,176,1728950400"; 
   d="scan'208";a="472481980"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 16:15:17 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:17337]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.181:2525] with esmtp (Farcaster)
 id 1cad881e-4a18-4d14-ade3-488f6eb63fec; Fri, 22 Nov 2024 16:15:16 +0000 (UTC)
X-Farcaster-Flow-ID: 1cad881e-4a18-4d14-ade3-488f6eb63fec
Received: from EX19D003UWC002.ant.amazon.com (10.13.138.169) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 22 Nov 2024 16:15:16 +0000
Received: from [192.168.2.77] (10.106.100.9) by EX19D003UWC002.ant.amazon.com
 (10.13.138.169) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35; Fri, 22 Nov 2024
 16:15:15 +0000
Message-ID: <3676f073-028e-4855-aa87-107e0607be24@amazon.com>
Date: Fri, 22 Nov 2024 09:15:11 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <jackmanb@google.com>
CC: <David.Kaplan@amd.com>, <bp@alien8.de>, <canellac@amazon.at>,
	<dave.hansen@linux.intel.com>, <derekmn@amazon.com>, <hpa@zytor.com>,
	<jpoimboe@kernel.org>, <linux-kernel@vger.kernel.org>, <mingo@redhat.com>,
	<mlipp@amazon.at>, <pawan.kumar.gupta@linux.intel.com>,
	<peterz@infradead.org>, <tglx@linutronix.de>, <x86@kernel.org>
References: <CA+i-1C3R=56CAMiDwuzrtxmQN+CN14hUeMfbv4k4WqyQfexZ1g@mail.gmail.com>
Subject: Re: [PATCH v2 19/35] Documentation/x86: Document the new attack
 vector controls
Content-Language: en-US
From: "Manwaring, Derek" <derekmn@amazon.com>
In-Reply-To: <CA+i-1C3R=56CAMiDwuzrtxmQN+CN14hUeMfbv4k4WqyQfexZ1g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D003UWC002.ant.amazon.com (10.13.138.169)

On 2024-11-14 at 9:32+0000, Brendan Jackman wrote:
> On Wed, 13 Nov 2024 at 17:19, Brendan Jackman <jackmanb@google.com> wrote:
> >
> > On Wed, 13 Nov 2024 at 17:00, Kaplan, David <David.Kaplan@amd.com> wrote:
> > > I wonder what would happen if there was a mitigation that was required
> > > when switching to another guest, but not to the broader host address
> > > space.
> >
> > This is already the case for the mitigations that "go the other way":
> > IBPB protects the incoming domain from the outgoing one, but L1D flush
> > protects the outgoing from the incoming. So when you exit to the
> > unrestricted address space it never makes sense to flush L1D (everyone
> > trusts the kernel) but e.g. guest->guest still needs one.
>
> I'm straying quite far from the actual topic now but to avoid
> confusion for anyone reading later:
>
> A discussion off-list led me to realise that the specifics of this
> comment are nonsensical, I had L1TF in mind but I don't think you can
> exploit L1TF in a direct guest->guest attack (I'm probably still
> missing some nuance there). We wouldn't need to flush L1D there unless
> there's a new vuln.

With Foreshadow-VMM/CVE-2018-3646 I thought you can do guest->guest?
Since guest completely controls the physical address which ends up
probing L1D (as if it were a host physical address).

And agree with the flushes between different restricted address spaces
(e.g. context switch between guests, right?).

Derek

