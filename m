Return-Path: <linux-kernel+bounces-443994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 878DB9EFEDF
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 22:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F19E16A5D8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:59:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B8051D9353;
	Thu, 12 Dec 2024 21:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="b5eswKZG"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0369F19E971
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 21:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734040755; cv=none; b=hdA8FSc0ahpVE4z5HCWfKFWfVq/iEbfUAqWc7akmSvxNm9bH7eL+T22JCA15W8rU6W/IB8Tg9OLBuX6QTRX8bJgd4sUHI1TFw6kaXNCpKD9ORamehobsa8sA6AEFB8eLRrz/FOWAQCwriz57YExSphrQOaD2949Xa1S5O9hybgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734040755; c=relaxed/simple;
	bh=AIRbs0nHA+63xxKe9qa0dYo6lKLKDLTvh2ProTbRsU8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=INRXssKfMg2d3ktrNf4jLU/9D6eAGOuvnG1HMzYKGF0tLCYtvDHXy6I60Sgmqzn4rtSc8XORsmL6DgKFrt+KQ7diwi202NouZqLqTbPVTXtI/AC+VENjFsyCKCszga2PRa/hK7h1J7gFRKodTGZG2yZ9CJ9YZYTazfKShe3415Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=b5eswKZG; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=AIRbs0nHA+63xxKe9qa0dYo6lKLKDLTvh2ProTbRsU8=; b=b5eswKZGrYzlVU7X16HC9ZAND6
	cDUFA06Uiyrh/E4ibpIEN08FzG5HKJxlS4lkacFwbRSpSNY1ttgBgmBz2B3SYQXGzEy2JeAtpkKa1
	4vebzywCPvZzMnnCwh2hPq4JKVJM0LFYN40roRanifGuoEVSHTjmfF9wA2F/kxq20yE+jprbBSvnE
	UaTGjvQZSMu1WY5fFrePxhJ850wyxkgDgeWsnIZ0i/HZjvlyTMH3E6MqVwDlqblPYeLpDv8BtuFQP
	4+JQoalDMi5F55pPl0/DEDp1odtSLhLbpeh3VNxqm/LoKSsE7xp/TtA6tNcEI1QUzFKln76iCNpxZ
	Nt7l4jZQ==;
Received: from [2001:8b0:10b:5:fc92:5b26:d347:4188] (helo=[IPv6:::1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tLrD4-000000048Pg-2d3W;
	Thu, 12 Dec 2024 21:59:03 +0000
Date: Thu, 12 Dec 2024 21:59:02 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: Dave Hansen <dave.hansen@intel.com>, Nathan Chancellor <nathan@kernel.org>
CC: "Ning, Hongyu" <hongyu.ning@linux.intel.com>, kexec@lists.infradead.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Dave Young <dyoung@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 jpoimboe@kernel.org, bsz@amazon.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_x86/kexec=3A_Only_write_thr?=
 =?US-ASCII?Q?ough_identity_mapping_of_control_page?=
User-Agent: K-9 Mail for Android
In-Reply-To: <a14ff894-9268-4a62-87bd-3b2553e0bc01@intel.com>
References: <20241205153343.3275139-1-dwmw2@infradead.org> <20241205153343.3275139-14-dwmw2@infradead.org> <20241212014418.GA532802@ax162> <10a4058d9a667ca7aef7e1862375c2da84ef53a3.camel@infradead.org> <20241212150408.GA542727@ax162> <38aaf87162d10c79b3d3ecae38df99e89ad16fce.camel@infradead.org> <20241212174243.GA2149156@ax162> <9c68688625f409104b16164da30aa6d3eb494e5d.camel@infradead.org> <4517cb69-3c5c-4e75-8a14-dab136b29c19@intel.com> <212CBB8E-CC94-4A56-8399-1419D8F2FA5C@infradead.org> <a14ff894-9268-4a62-87bd-3b2553e0bc01@intel.com>
Message-ID: <6CCE1B41-1865-4B09-8CEF-B83932775C3D@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by desiato.infradead.org. See http://www.infradead.org/rpr.html

On 12 December 2024 21:43:57 GMT, Dave Hansen <dave=2Ehansen@intel=2Ecom> w=
rote:
>On 12/12/24 13:32, David Woodhouse wrote:
>> On 12 December 2024 21:18:10 GMT, Dave Hansen <dave=2Ehansen@intel=2Eco=
m> wrote:
>>> On 12/12/24 12:11, David Woodhouse wrote:
>>>> From: David Woodhouse <dwmw@amazon=2Eco=2Euk>
>>>>
>>>> The virtual mapping of the control page may have been _PAGE_GLOBAL an=
d
>>>> thus its PTE might not have been flushed on the %cr3 switch and
>>>> it might effectively still be read-only=2E Move the writes to it
>>>> down into the identity_mapped() function where the same
>>>> %rip-relative addressing will get the new mapping=2E
>>>>=20
>>>> The stack is fine, as that's using the identity mapped address
>>>> anyway=2E
>>>=20
>>> Shouldn't we also ensure that Global entries don't bite anyone
>>> else? Something like the completely untested attached patch?
>> Doesn't hurt, but this is an identity mapping so absolutely
>> everything other than this one page is going to be in the low
>> (positive) part of the canonical address space, so won't have had
>> global pages in the first place will they?
>
>Right, it's generally _not_ a problem=2E But it _can_ be a surprising
>problem which is why we're all looking at it today=2E ;)
>
>> Probably a kind thing to do for whatever we're passing control to
>> though :)
>>=20
>> I'll round it up into the tree and send it out with the next batch of
>> debug support=2E Care to give me a SoB for it? You can
>> s/CR0_PGE/CR4_PGE/ too if you like but I can do that myself as well=2E
>Here's a fixed one with a changelog and a SoB=2E Still 100% gloriously
>untested though=2E
Ta=2E I'll play with it in the morning=2E May actually shift it earlier an=
d use it instead of my other fix, so we can actually write to the virtual a=
ddress=2E

