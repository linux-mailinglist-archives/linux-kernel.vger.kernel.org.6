Return-Path: <linux-kernel+bounces-237785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 804AD923E10
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40C6C2818D6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25022167DB8;
	Tue,  2 Jul 2024 12:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="hNc8MvVg"
Received: from out203-205-221-190.mail.qq.com (out203-205-221-190.mail.qq.com [203.205.221.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8050115B133
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 12:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719924218; cv=none; b=TzT0jZ7zlryTKuGLtn9KqomFIZTBYHrqbUaQ5pONurnIHo0BEhFwTaIMMt8VlVqKEWGisy29WL6iEik/euhPOR9hPx63oX0fcQOPZBR/vGEgDLBy5MNkR5kmBsSYiy/QHIqLB5U5h+L4CqlUCCuMMetNifsXk3Qkd86+XnnTfSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719924218; c=relaxed/simple;
	bh=ucNQTfjmvBjyz/KHBM6TptraxFu5C2dRm7z1yhf6WbE=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=EwyXLUn7f8AAXMrDxT/abukPPIQ1Ogu/UwIuPNCdQd5stcSsETlkVkDrnrucyvakBHWGP6pXBOwmJHBYpGcrjQ8BE9bHkneHI8KNPNR7APhgmYIU3kkGH/t3K93MK02Ix3hENW2zddKoyQ6SVtqL+Ftf+z7dAGNH7bQpOLtcBxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=hNc8MvVg; arc=none smtp.client-ip=203.205.221.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1719924210; bh=ZRPp8dKEItyDHCpqVd9zL+53a0tYUZt1IfOdGrtXWPw=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=hNc8MvVgGZVMCinqsg2zoXkBYYFy+op3bhM6W+q1EqDmTcSNBzA6+rb5GZ1cx4/Vw
	 RUqJUGmWyhyidLQyyDCd0wLdN4NCQhALGRxyMALgpPOy0XyefrMKqxqxieOP9hXyqB
	 BQjAJ4iN/6YCYDu/FhwCKjOAJ4lDhtvsafNMbAvc=
Received: from smtpclient.apple ([2408:8207:18a1:c8b0:d94f:d56c:82f1:40db])
	by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
	id ADA8E457; Tue, 02 Jul 2024 20:43:26 +0800
X-QQ-mid: xmsmtpt1719924206t21455jn1
Message-ID: <tencent_A6F18ECEB80131BA21638D187C6782F6DA08@qq.com>
X-QQ-XMAILINFO: MR/iVh5QLeie4AIX3n0T6n2xfv3bNhMVzS0YvYjIW5sNeB3CoBvcf4zqKG2mDr
	 JpcgJVFniYRVyY8okQnNsyFMqFE8c10WVDOS6ovC9Yv6s5uSNkLXA/tqkKIGMkGlh6mLKNWdRQ4r
	 BdTv+w4zy5WqOx/j1hNeeSG90O2/CDlFDOXC2aUzyXwXu0/FAbck8vbZGRqmAK2E6wF/VkkQQBMZ
	 YBveTJCUFwX9gvF3OpV887vODjDeHhSTM0mFYL7Y9X1y7MjHikWGLT1oRqysrSnhpQ+kEYsIVpkE
	 a+0RLDsUZwrsipslpd1p7yiG6FH/Ji6jNFytihfwovoA9ZUuLxaozoZ+C1sEC0xwNt7o0GnzPNdj
	 PzvS/SGBtQr7Xkt2PI1H/p10caBf9SlhHHP0fchhfqguHwrEW1oMarZOcV1/Ty1RRmeRG69XeGeM
	 qTcCVUtHXEiFSMF7rlAxsTe16jetMlBfcTAW9R1cSuKysEBve6ht/BreycSjMOxooEzVf1VpqjVz
	 rxvwqURlnkuBWHVnSRG88VzULEumM7+VCpp2pJ56QT4BPfvO1cWfrGsFRYPjqFbcYtco3gN3cFC5
	 tAoZALae/7S2hpNBQgAwv/vEI6fM+smz8Hs2UmCbsY1rTd1oodyQ0iCuH7KXtoH4G7MmBZPRgfSj
	 bqmMSaurtrSHhjKFinHGYzZn25/Jh533uny3gKP1mhR1/ElZwCoUved/cbxQMeCRTTlcDUqdQB49
	 YH4P/0Eo2/M+k0ThmgWeJezSeOIIz2wAu7SfWRx1/auVvYzGaUqswfQCYOYplB5ApzUjpGSv3WBL
	 +8Yw6q/OObE8k72jEfxpFHR6+DyVvp42jiz94ZKGIfV2icfBBbV1MZ/E0YGXrUETwOoXUkOnJvt2
	 EFX0LrkjXbV8capv6pDgdblHM+cd8WlDJBrTttNroFWuELRpf+EJk50d4ysd6g7MWpeLavDXWrqB
	 /PElS66q9bJxAA1HHnSprXRTWL9TRlzrexNJmTBoQ4Thbs5t7uL6BGJCgNMxn8blMm/bXuKLriNp
	 FDB+Z39hL3WHiPNhe96pAZkJLQpDXfO5gv4YAhl0b5BlStwjLV
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v1] drivers/perf: apple_m1: fix affinity table for event
 0x96 and 0x9b
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <20240702121340.GB3542@willie-the-truck>
Date: Tue, 2 Jul 2024 20:43:16 +0800
Cc: Marc Zyngier <maz@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Mark Rutland <mark.rutland@arm.com>,
 Janne Grunau <j@jannau.net>,
 Hector Martin <marcan@marcan.st>,
 Asahi Lina <lina@asahilina.net>,
 asahi@lists.linux.dev,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: 7bit
X-OQ-MSGID: <8D1767DE-D45B-40AD-A57F-5711A8AF9B3D@cyyself.name>
References: <tencent_7B71486CE305DF8AE084B6BB6313EE550C06@qq.com>
 <20240701140148.GE2250@willie-the-truck> <87cynxp52o.wl-maz@kernel.org>
 <87bk3hp3z7.wl-maz@kernel.org>
 <tencent_371517268623E4A61194EF4C70497BDC5105@qq.com>
 <8634oshxhj.wl-maz@kernel.org> <20240702121340.GB3542@willie-the-truck>
To: Will Deacon <will@kernel.org>
X-Mailer: Apple Mail (2.3774.600.62)



> On Jul 2, 2024, at 20:13, Will Deacon <will@kernel.org> wrote:
> 
> On Tue, Jul 02, 2024 at 11:58:00AM +0100, Marc Zyngier wrote:
>> On Tue, 02 Jul 2024 11:22:21 +0100,
>> Yangyu Chen <cyy@cyyself.name> wrote:
>>> 
>>>> Yangyu, can you please clarify how you came to the conclusion that
>>>> these events didn't count anywhere other than counter 7?
>>>> 
>>> 
>>> IIRC, I came across some web page that says events 0x96 and 0x9b
>>> can only be installed on counter 7 to count Apple AMX, but I can't
>>> find the page now. Since AMX is not usable in Linux, I don't know
>>> if this will affect some other instructions that are usable in
>>> Linux.
>> 
>> As you said, AMX cannot be used with Linux, and that's unlikely to
>> ever change. But when it comes to the standard ARM ISA, we can only
>> witness counters 5,6 and 7 being incremented with at the exact same
>> rate.
>> 
>> So reading between the lines, what I understand is that AMX
>> instructions would only have their effects counted in counter 7 for
>> these events, while other instructions would be counted in all 3
>> counters.
>> 
>> By extension, such behaviour could be applied to SME on HW that
>> supports it (wild guess).
>> 
>>> There are some other reasons, but I can't say in public.
>> 
>> Fair enough, I'm not asking for the disclosure of anything that isn't
>> public (the least I know, the better).
>> 
>>> Even though I can't find the actual usage, I think using count 7
>>> only for these 2 events is safer. If this reason is insufficient,
>>> we can ignore this patch until we find other evidence that this
>>> affinity affects some instructions usable in Linux.
>> 
>> I honestly don't mind.
>> 
>> The whole thing is a black box, and is more useful as an interrupt
>> generator than an actual PMU, due to the lack of freely available
>> documentation. If the PMU maintainers want to merge this, I won't
>> oppose it.
> 
> I'd rather leave the code as-is than tweak specific counters based on
> a combination of guesswork and partial information.
> 
> Of course, if somebody who knows better wants to fix up all of the
> mappings (because this surely isn't the only corner-case), then we can
> take that. But at least what we have today has _some_ sort of consistent
> rationale behind it.

Actually, anyone who has macOS software can learn the whole affinity
table of PMU. The detailed information can be extracted from a plist
file stored in the macOS root filesystem. I also provide that script
[1] to extract this information.

However, I can't directly use this information for legal concerns.
Would this be acceptable if the information I provide matches Apple's
information? I can't say whether it matches or not in public. I can
only say we can easily find someone who uploaded this file to the
internet.

[1] https://github.com/cyyself/m1-pmu-gen

> 
> Will



