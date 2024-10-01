Return-Path: <linux-kernel+bounces-346751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6EF98C84E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 00:37:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502C51C22314
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 22:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D963B1CEE9A;
	Tue,  1 Oct 2024 22:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="H2/r1RxE"
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE1B19CC39
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 22:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727822237; cv=none; b=oTwyi7oYpgKx0KeOPMHTsOVCTMg5/0+8a7kMBzS5/CuCOrkJONvSp1BrnnAN9wgsyS9dEqU4k8DID7yrP4lV6AuCequ9zvgdBcuLuAKgBU/110t2uXI7EN7OT3v7/6KSFqc3Rfqy4MVqCopG0YoeJY++755IGRKh5vycE831zUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727822237; c=relaxed/simple;
	bh=1Iaurm3UmJxfpd8sjAwYFlUH7QMOL4pSGQuEfg6kmBw=;
	h=Message-ID:Date:MIME-Version:To:CC:References:Subject:From:
	 In-Reply-To:Content-Type; b=SrCEWPmCTmCYi9Pr3HbV33+FlEDrQfSU8xlec9mjw1SbaQS/GXH0UYjf2kROFMiyH+ABFbvE32Dd4YH3eWMkU9MFFdeDHTexi+Zp5JEiHyblht1T8Nag7CPucg5Mg9V8mJGYsaGsspkj3B9/9cpMOHMx/JwSBW1CDLLcs1vi/c4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=H2/r1RxE; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1727822236; x=1759358236;
  h=message-id:date:mime-version:to:cc:references:subject:
   from:in-reply-to:content-transfer-encoding;
  bh=1Iaurm3UmJxfpd8sjAwYFlUH7QMOL4pSGQuEfg6kmBw=;
  b=H2/r1RxEoBhxV0lzXpMCWylkXnSCKqUJa/lN1l1YhEjLDwQCxd/GiB49
   m/Ze1K5sBV7sfnENtRLHFtU8uyRLf8aN2aD8iZ/MlYK6pyJEPI0GeUocr
   C02aJy8MUBJfaFkNuhmU4mr1mlHK64bN8RJsVDG3z/xsxXE9qrqXxwcGw
   o=;
X-IronPort-AV: E=Sophos;i="6.11,169,1725321600"; 
   d="scan'208";a="338337150"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2024 22:37:16 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:32989]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.53.199:2525] with esmtp (Farcaster)
 id 16ff47af-d8f8-4b88-b5f4-54824ceb13c4; Tue, 1 Oct 2024 22:37:15 +0000 (UTC)
X-Farcaster-Flow-ID: 16ff47af-d8f8-4b88-b5f4-54824ceb13c4
Received: from EX19D003UWC002.ant.amazon.com (10.13.138.169) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 1 Oct 2024 22:37:15 +0000
Received: from [192.168.12.162] (10.187.170.38) by
 EX19D003UWC002.ant.amazon.com (10.13.138.169) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 1 Oct 2024 22:37:14 +0000
Message-ID: <1c27be68-8365-4ddb-9368-e8e740feaf13@amazon.com>
Date: Tue, 1 Oct 2024 15:37:13 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: <david.kaplan@amd.com>
CC: <bp@alien8.de>, <dave.hansen@linux.intel.com>, <derekmn@amazon.com>,
	<hpa@zytor.com>, <jpoimboe@kernel.org>, <linux-kernel@vger.kernel.org>,
	<mingo@redhat.com>, <pawan.kumar.gupta@linux.intel.com>,
	<peterz@infradead.org>, <tglx@linutronix.de>, <x86@kernel.org>
References: <LV3PR12MB9265292F9654D9FF76D6B63494772@LV3PR12MB9265.namprd12.prod.outlook.com>
Subject: RE: [RFC PATCH 21/34] x86/bugs: Add attack vector controls for mds
Content-Language: en-US
From: "Manwaring, Derek" <derekmn@amazon.com>
In-Reply-To: <LV3PR12MB9265292F9654D9FF76D6B63494772@LV3PR12MB9265.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D003UWC002.ant.amazon.com (10.13.138.169)

On 2024-10-01 01:56+0000 David Kaplan wrote:
> On 2024-09-30 17:50-0700 Derek Manwaring wrote:
> > Maybe I'm missing something here - if you care about user/user, why would
> > you not care about cross-thread? It seems to me SMT should be turned off
> > for all of the vectors.
>
> I broke out cross-thread separately to maintain the existing kernel
> defaults, which does not disable SMT by default even if full mitigation
> requires it.

Ok that makes a lot of sense. My bias would be to use the vector
parameters as an opportunity to make the SMT stance more obvious. So
kernel's position becomes more of "I disabled SMT because you asked for
protection with mitigate_user_user" (or any other vector). If no vector
parameters are specified, SMT default would be maintained. What are your
thoughts on disabling SMT if a vector parameter is explicitly supplied?

> In theory, cross-thread protection is only required if there is a risk
> that untrusted workloads might run as siblings.  If techniques like core
> scheduling are used, this might be able to be prevented I suppose.

True, though I think it's worth making clear that doing core scheduling
correctly is the user's responsibility, and the vector protection they
asked for may be incomplete if there are mistakes in how they manage
process cookies. Just an idea, but what if users had to ask for SMT to
remain enabled if they had also asked for protection from one of these
vectors?

Derek

