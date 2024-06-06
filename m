Return-Path: <linux-kernel+bounces-203861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE9F8FE15D
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 10:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F80C1C20B1B
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 08:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1332B13D242;
	Thu,  6 Jun 2024 08:45:01 +0000 (UTC)
Received: from mx2.zhaoxin.com (mx2.zhaoxin.com [203.110.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF48713AD06
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.110.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717663500; cv=none; b=NGfDVD9qLwZmo0HaFJXy3qzgTlkuH+W0i4sygX80s/bb4lT/3dqiJFf6Wcz/vR/2nLwd6gOVjcewERvKUm7HEL3/m6Is9vy3qiwDcaKX8UA6cibgn6ahdCixdKqkXZyr49W79hZSJbkVPxjuGRD8e7dpvFe2lxop9PLn/MKPjnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717663500; c=relaxed/simple;
	bh=cXuF/BWQZ89YFbsWT4c4SuCikNyWWk9/fkG6XTn4U90=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LVx9vDMq23fNyvvUYb96vt0cRBA9nf/jJjQtSRvF6WMjvAMTDT0+W6eiyyLDqoY/6JiTThKO+4liLqJ2h564gNtoD6/+WWKeMSpvYqvWnjaTxPaVuqv2BZBnX/90qH6xTgSgLaT7sEIBKebGVv0iuFv3jrIBVpbgLpix/Hg3blc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com; spf=pass smtp.mailfrom=zhaoxin.com; arc=none smtp.client-ip=203.110.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zhaoxin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zhaoxin.com
X-ASG-Debug-ID: 1717663487-1eb14e15751a540001-xx1T2L
Received: from ZXSHMBX1.zhaoxin.com (ZXSHMBX1.zhaoxin.com [10.28.252.163]) by mx2.zhaoxin.com with ESMTP id ZMf1DOmNJyk7ZEa1 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO); Thu, 06 Jun 2024 16:44:47 +0800 (CST)
X-Barracuda-Envelope-From: TonyWWang-oc@zhaoxin.com
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Received: from ZXBJMBX03.zhaoxin.com (10.29.252.7) by ZXSHMBX1.zhaoxin.com
 (10.28.252.163) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.27; Thu, 6 Jun
 2024 16:44:46 +0800
Received: from [10.32.65.162] (10.32.65.162) by ZXBJMBX03.zhaoxin.com
 (10.29.252.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.27; Thu, 6 Jun
 2024 16:44:44 +0800
X-Barracuda-RBL-Trusted-Forwarder: 10.28.252.163
Message-ID: <d4079e9f-07cf-4893-9fc5-5d319b592aa5@zhaoxin.com>
X-Barracuda-RBL-Trusted-Forwarder: 10.32.65.162
Date: Thu, 6 Jun 2024 16:44:38 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/hpet: Read HPET directly if panic in progress
To: "Luck, Tony" <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
X-ASG-Orig-Subj: Re: [PATCH] x86/hpet: Read HPET directly if panic in progress
CC: Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds
	<torvalds@linux-foundation.org>, "Hansen, Dave" <dave.hansen@intel.com>,
	"mingo@redhat.com" <mingo@redhat.com>, "dave.hansen@linux.intel.com"
	<dave.hansen@linux.intel.com>, "x86@kernel.org" <x86@kernel.org>,
	"hpa@zytor.com" <hpa@zytor.com>, "keescook@chromium.org"
	<keescook@chromium.org>, "gpiccoli@igalia.com" <gpiccoli@igalia.com>,
	"mat.jonczyk@o2.pl" <mat.jonczyk@o2.pl>, "rdunlap@infradead.org"
	<rdunlap@infradead.org>, "alexandre.belloni@bootlin.com"
	<alexandre.belloni@bootlin.com>, "mario.limonciello@amd.com"
	<mario.limonciello@amd.com>, "yaolu@kylinos.cn" <yaolu@kylinos.cn>,
	"bhelgaas@google.com" <bhelgaas@google.com>, "justinstitt@google.com"
	<justinstitt@google.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>, "CobeChen@zhaoxin.com"
	<CobeChen@zhaoxin.com>, "TimGuo@zhaoxin.com" <TimGuo@zhaoxin.com>,
	"LeoLiu-oc@zhaoxin.com" <LeoLiu-oc@zhaoxin.com>
References: <20240528063836.5248-1-TonyWWang-oc@zhaoxin.com>
 <50fc1bd3-909e-41c4-a991-9d81e32ef92c@intel.com> <87wmnda8mc.ffs@tglx>
 <CAHk-=wgMoeOTL1V3wTO=o=U1OXn7xF8OWv2hB9NF9Z=G4KotfQ@mail.gmail.com>
 <87le3t9i8c.ffs@tglx> <0aff3f62-a8a5-4358-ae3f-2ded339aface@zhaoxin.com>
 <20240605093609.GCZmAxidNIBP5bkDcX@fat_crate.local>
 <e4f307dd-3264-45f6-82eb-0102f7fb99d7@zhaoxin.com>
 <20240605113323.GFZmBNA7ec2s191_2w@fat_crate.local>
 <46741fad-425c-4ed2-97be-3f2679da63eb@zhaoxin.com>
 <SJ1PR11MB60833ACD1E6C946F72C58736FCF92@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Language: en-US
From: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
In-Reply-To: <SJ1PR11MB60833ACD1E6C946F72C58736FCF92@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: ZXSHCAS2.zhaoxin.com (10.28.252.162) To
 ZXBJMBX03.zhaoxin.com (10.29.252.7)
X-Barracuda-Connect: ZXSHMBX1.zhaoxin.com[10.28.252.163]
X-Barracuda-Start-Time: 1717663487
X-Barracuda-Encrypted: ECDHE-RSA-AES128-GCM-SHA256
X-Barracuda-URL: https://10.28.252.36:4443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at zhaoxin.com
X-Barracuda-Scan-Msg-Size: 1311
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=9.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.125870
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------



On 2024/6/5 23:51, Luck, Tony wrote:
> 
> 
> [这封邮件来自外部发件人 谨防风险]
> 
>>> Which types exactly do you mean when you're looking at the severities[]
>>> array in severity.c?
>>>
>>> And what scenario are you talking about?
>>>
>>> To get an #MC exception and detect only UCNA/SRAO errors? Can that even
>>> happen on any hardware?
>>>
>>
>> Yes, I mean an #MC exception happened and detect only like SRAO errors
>> like below:
>>
>>           MCESEV(
>>                   AO, "Action optional: memory scrubbing error",
>>                   SER, MASK(MCI_UC_AR|MCACOD_SCRUBMSK,
>> MCI_STATUS_UC|MCACOD_SCRUB)
>>                   ),
>>           MCESEV(
>>                   AO, "Action optional: last level cache writeback error",
>>                   SER, MASK(MCI_UC_AR|MCACOD, MCI_STATUS_UC|MCACOD_L3WB)
>>                   ),
>>
>> I think these errors are actually encountered on some platforms that
>> support these type of errors report to the #MC.
> 
> Intel servers from Nehalem through Cascade Lake reported memory controller
> patrol scrub uncorrected error with #MC and SRAO signature.
> 
> Icelake and newer use CMCI with a UCNA signature.
> 

I have a question, does Intel use #MC to report UCNA errors?

Sincerely
TonyWWang-oc

