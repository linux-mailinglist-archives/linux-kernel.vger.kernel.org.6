Return-Path: <linux-kernel+bounces-264561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 382C593E519
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 14:42:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B8AFB21526
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 12:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4EF3D96D;
	Sun, 28 Jul 2024 12:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="GvLNZsTJ"
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BF72F30
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 12:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722170536; cv=none; b=oHN8uRA7K/Gw9qZ62qikyVGyhAKM+JFUHM1qjSttFR9rym0AvrweRWF+wTvcyVHQEWtor19pGPkX0rk+5Z3dcCDy1rxVe4rywRdAA1PJMkugkReRN0zl66ELQNAA2sU5IP+kvJPGcAUUM7AcLzuCmWah6nUyN15P6TSgR1uXDh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722170536; c=relaxed/simple;
	bh=SidrVGYKHpC978EUeJKgZWSuRev+UYQ71gdky32vYkg=;
	h=Message-ID:Content-Type:Mime-Version:Subject:From:In-Reply-To:
	 Date:Cc:References:To; b=fvOhXfJp4Cmd/sS24GDNNMu5aK1lBuxqaZXXrXWBZZIxgIi1zrCkWCE5NmAme2Pk37VnwkHQKDxFyPP4YfGq1YEcnqvqGS/b2GcJiux9peMep+dFIlNNRQ3avFWMJn8BO82+T+8eKHqFGB3NxAa4FkgpOAHPcSHz/c4uMMhpKnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=none smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=GvLNZsTJ; arc=none smtp.client-ip=43.163.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cyyself.name
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722170525; bh=SidrVGYKHpC978EUeJKgZWSuRev+UYQ71gdky32vYkg=;
	h=Subject:From:In-Reply-To:Date:Cc:References:To;
	b=GvLNZsTJnTfILCHWlLx9RHKUNZ3ZJYI1Tewor9TB0YdmxQ8n7uq1TpmmbZzNagAW4
	 KIGKhwt6oo95sx5178qGZllpdCX3eqETzVVlN7qnr0Q14HrOMa/JnmUYRHple20sUJ
	 LPhz3ia5HndaTq4A+SYgPYT/0IstLxTjVjfIXpN4=
Received: from smtpclient.apple ([2408:8207:18a4:5580:d941:3a80:b9d0:b3e8])
	by newxmesmtplogicsvrsza29-0.qq.com (NewEsmtp) with SMTP
	id 4ECA6652; Sun, 28 Jul 2024 20:19:44 +0800
X-QQ-mid: xmsmtpt1722169184tua4rv5o8
Message-ID: <tencent_4EB8343AF079090E68933A46E362C740850A@qq.com>
X-QQ-XMAILINFO: M5WvXNp9ZPrQx8VdMOd2WQP5s20NKSGBlUvTE94OjMinKrwZfvZRAilFaeD4X9
	 UmKHm4/XpcahgGiccaQfJHxQXbujJWfoHMWbIa5fj7jDEtmTklLEzZIQvyf3s5OBQ6MwnW/4aCAD
	 Xui8Q03DZSyurBcd5ZplcAmqm9TjjnET5qNpAH1AJX6jS/Bk+wSqL9RAQBFeXMjXIBesIbqyyaTE
	 En+DFHKEnFSUWaPpXyl5r2m44TewSqOKkG4hUzdoMkPFml7VRbIijKy63jwLG3u+Nzn1d9novxIx
	 LXb6TbLwe930xHq8wM/5S8QvX9vHcJB1gwwUByvJ2J5trXuqDI+habMtST9cDQdAJ/DNpu86v2ko
	 aBkVhQ82KM2Mf/5qGIa7CEq+EvSgdfPnwyxjN0M6yM0vZFuSLKA3TViEfy+fi0iFJ/oTvFlXyq9t
	 RgPFNoIJyBXyWPS/5sZkVmh1rIUIkyuD9W7fGqEbEu0auMrtduWFy3tZPzZM9MternTNzVQ4cDyW
	 50TgftmNFTI3hrfPMcUu1bfEXL6sy0PCyTvfWQ8dtOk8774xBgeoiJ/4hbExHDbtfZRqU4vqRiWo
	 aMbRv+bpG1ETzqprZWjhp4qabr40sC146FTZNZBmypZlQlTzknBbmbY49VdW/3uCUXtiTDY1nicS
	 dYvamFIc0Dlw2VRMWc5InVjVdiCWJsbbxOGYPgbZbBm8/yWwhvoLKhNfHz4hj6j1rwxnzVew3C2n
	 7AsIX5gdLVMSU2xPkOnOK6IP2VzsAPlZOsqB9iDMROaBTWMbq5zH5ERN10uugYNB3chIwhld05Br
	 DF1WTsGbGJ3UtY7RYNl7tEUOG4RHjJbCwmqHJYIDR0CSZY9UjCX+NIJGdH3pWR/kNMl7/6Xd3aG7
	 +sc1BiNXO8zTA8MihBDkI8FBt0HTERZkxHPmR7DPgHj4QWBUnQyxxOZvNmTu7Ngm5NlLoKM4L4Do
	 /hgM2hUKfn+jqXRVoKTqXMC0tNscCInlFQL+pS1dp5yvCOzfr3wDJ+7k2i4+7U
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3774.600.62\))
Subject: Re: [PATCH v1] drivers/perf: apple_m1: add known PMU events
From: Yangyu Chen <cyy@cyyself.name>
In-Reply-To: <3cd6bf37-f335-470b-9b3f-25628067e0f1@marcan.st>
Date: Sun, 28 Jul 2024 20:19:34 +0800
Cc: Marc Zyngier <maz@kernel.org>,
 linux-arm-kernel@lists.infradead.org,
 Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Janne Grunau <j@jannau.net>,
 Asahi Lina <lina@asahilina.net>,
 asahi@lists.linux.dev,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
X-OQ-MSGID: <5B6B1F56-C104-4054-A008-1075271D2121@cyyself.name>
References: <tencent_D6474BDCDD18AA90A0C656BE704136ED2807@qq.com>
 <86bk3yjqkn.wl-maz@kernel.org>
 <tencent_B732B857317E21CB8D887CBF8228DAA78E08@qq.com>
 <86a5jijign.wl-maz@kernel.org>
 <3cd6bf37-f335-470b-9b3f-25628067e0f1@marcan.st>
To: Hector Martin <marcan@marcan.st>
X-Mailer: Apple Mail (2.3774.600.62)



> On Jul 28, 2024, at 19:00, Hector Martin <marcan@marcan.st> wrote:
>=20
>=20
> On 2024/06/19 1:58, Marc Zyngier wrote:
>> On Tue, 18 Jun 2024 16:56:48 +0100,
>> Yangyu Chen <cyy@cyyself.name> wrote:
>>>=20
>>>=20
>>>=20
>>>> On Jun 18, 2024, at 22:03, Marc Zyngier <maz@kernel.org> wrote:
>>>>=20
>>>> On Tue, 18 Jun 2024 14:49:48 +0100,
>>>> Yangyu Chen <cyy@cyyself.name> wrote:
>>>>>=20
>>>>> This patch adds known PMU events that can be found on =
/usr/share/kpep in
>>>>> macOS. The m1_pmu_events and m1_pmu_event_affinity are generated =
from
>>>>> the script [1], which consumes the plist file from Apple. And then =
added
>>>>> these events to m1_pmu_perf_map and m1_pmu_event_attrs with =
Apple's
>>>>> documentation [2].
>>>>>=20
>>>>> Link: https://github.com/cyyself/m1-pmu-gen [1]
>>>>> Link: =
https://developer.apple.com/download/apple-silicon-cpu-optimization-guide/=
 [2]
>>>>=20
>>>> This needs registration, and is thus impossible to freely visit.
>>>>=20
>>>>> Signed-off-by: Yangyu Chen <cyy@cyyself.name>
>>>>=20
>>>> What is the licence applicable to the original source file? Does it
>>>> explicitly allow redistribution in any form?
>>>>=20
>>>=20
>>> Oh. It's my fault. Sorry for the trouble caused.
>>=20
>> No trouble on my side. I'm just painfully aware that this is a legal
>> landmine, and that what is perfectly allowed in one country may be a
>> punishable offence in another. And since I'm not a lawyer, I want to
>> see crystal clear things in writing.
>>=20
>>>=20
>>>>=20
>>>> Other than the licensing concern, why should we bloat the kernel =
with
>>>> more of this stuff when everything is moving towards a bunch of =
JSON
>>>> files (tools/perf/pmu-events/arch/arm64).
>>>>=20
>>>=20
>>> Thanks for this hint. So, the thing to do might be to provide a
>>> generator that consumes Apple files and then generates a kernel
>>> patch for Linux perf tools to use rather than provide such details
>>> directly in the source code as you said from [1].
>>>=20
>>> Link: https://lore.kernel.org/lkml/87czn18zev.wl-maz@kernel.org/ [1]
>>=20
>> Even better: teach the perf tool to directly consume the plist file,
>> but don't distribute the file or its content. People owning such a
>> machine can fish the file from the machine itself (or the installer
>> can extract it from the OS image as if it was firmware data).
>=20
> Maz,
>=20
> That would be a waste of time. Facts about hardware are not
> copyrightable. I see absolutely nothing objectionable in this patch. =
It
> doesn't matter where the information was sourced as long as it was
> legitimately available to the person (which it was, as long as they =
were
> running macOS on one of these machines).
>=20
> Let's look at the license for the ARMv8-A ARM:
>=20
>> Proprietary Notice
>> This document is protected by copyright and other related rights and =
the practice or implementation of the information contained
>> in this document may be protected by one or more patents or pending =
patent applications. No part of this document may be
>> reproduced in any form by any means without the express prior written =
permission of Arm. No license, express or implied, by
>> estoppel or otherwise to any intellectual property rights is granted =
by this document unless specifically stated.
>=20
> There is absolutely nothing in there granting a license to use the
> information in the document and things like register names in Linux or
> any other OS. And yet we can do that, because those things aren't
> copyrightable. It would defeat the entire point of the documentation =
if
> you could not use it, even though there is in fact no explicit =
copyright
> grant to allow you to use it. It is not needed.
>=20
> The same exact logic applies here. The macOS license does not grant us
> the right to reproduce portions of macOS, but that is completely
> irrelevant because the portion "reproduced" in the form of this patch =
is
> not, at all, copyrightable. If it were we would have much bigger =
issues
> and all kinds of code in Linux would be a copyvio. The fact that there
> was some automation involved in generating the patch contents is
> entirely irrelevant, as long as the output does not keep a copyright
> interest from the author of the input.
>=20
> I also have an actual lawyer's opinion that register names are not
> copyrightable, which further corroborates this interpretation.
>=20
> As far as I'm concerned this can be merged as is.

Even if there are no copyright concerns, as you said from [1], I
think I should remove the lines in m1_pmu_event_attrs and then patch
userspace Linux-perf tools with the definitions in the JSON file.

Since I haven't received any other advice on copyright concerns, I
am still waiting for other suggestions before submitting the patch
revision.

Thanks,
Yangyu Chen

[1] =
https://lore.kernel.org/lkml/dbf17fa6-1af6-467b-8b3d-dca8476dc785@marcan.s=
t/

>=20
> Acked-by: Hector Martin <marcan@marcan.st>
>=20
> - Hector


