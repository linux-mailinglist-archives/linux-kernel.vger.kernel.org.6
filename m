Return-Path: <linux-kernel+bounces-444347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2869F0521
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 08:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07081281F47
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 07:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C1317CA0B;
	Fri, 13 Dec 2024 07:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FOhxFC9A"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA8691372
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 07:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734073318; cv=none; b=Qvk3PdVkFlQRj7z2qbg9ukEG8JDFjc++zs6FHQAjokAiv7CT+EJlwI0u7e7MVxN9/lX2cymCFnYyH9HvMRbbDqjRyp+227M/Ycr5KQB5J0hKz5RyHf3AFHCDPRmNw9TzbD/zKemf3ysVp/tWGdJY2CMuMTJJ5JySAHnd/Rz67HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734073318; c=relaxed/simple;
	bh=EsD+OaRfYxo4XdvH3wCFgLOpIqR8LP2p7B6sMwwrDbw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=slOvfmCr0JIeXxk01hSctuScttNAAbE5MLAL/OkvYPc9LCtbfNZFZrlxzvsMlfAQnfda0xilq9ijCbmACvw3tQ9RRsMZnVONsAl+mqgMX9EXvPHEBPxEN07tCuE82I2MeXSCPm4dKZP/Ga6G9V32vd/5Jlvh6XE7UPOhSLMr6oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=desiato.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=FOhxFC9A; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=desiato.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:MIME-Version:Message-ID:References:In-Reply-To:Subject:CC:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=EsD+OaRfYxo4XdvH3wCFgLOpIqR8LP2p7B6sMwwrDbw=; b=FOhxFC9Ant8X9Ng/U7dnLYbgS1
	rYAF+WzVpmvJqFpVxvLDj2/dMdaXyZtaIhCKP1FHMUZ+ouLrfHnYk+Votsvhi3EIWwDHY8L5+j3c0
	3aHYF5HH4Rq51B0pd4ljDHoKOyDqPcHcV8KVp+NAdySY45VdwmjRw2cfNQPscsppMsHIOMYrz70G9
	oMKlplOT8erpubEF9hU/2C9RTfs/azkx7wea/Zy6AXPQSuLix8KrBXXewZ3rLvQWiGQpgg9ySiASc
	e5v5vrEduF5AYaW5+kvkLtXT+nIXTRAN/VZ0RgXcsnp+A/oAmlKXttqmSLF8egknDpzbmfkilOH38
	0o7/1BIg==;
Received: from [172.31.31.140] (helo=[127.0.0.1])
	by desiato.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tLzgF-00000004Dxc-44VF;
	Fri, 13 Dec 2024 07:01:44 +0000
Date: Fri, 13 Dec 2024 07:01:44 +0000
From: David Woodhouse <dwmw2@infradead.org>
To: "Ning, Hongyu" <hongyu.ning@linux.intel.com>, kexec@lists.infradead.org
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Dave Young <dyoung@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 jpoimboe@kernel.org, bsz@amazon.de
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_13/20=5D_x86/kexec=3A_Mark_re?=
 =?US-ASCII?Q?locate=5Fkernel_page_as_ROX_instead_of_RWX?=
User-Agent: K-9 Mail for Android
In-Reply-To: <56fdfffc-9a5e-4f9e-ae5b-57dd27d647cc@linux.intel.com>
References: <20241205153343.3275139-1-dwmw2@infradead.org> <20241205153343.3275139-14-dwmw2@infradead.org> <5bb26488-f5fb-4186-92c3-de6a07631f91@linux.intel.com> <b4104c271b461dc1958ffac299d6741746a0728a.camel@infradead.org> <56fdfffc-9a5e-4f9e-ae5b-57dd27d647cc@linux.intel.com>
Message-ID: <E03AA833-B883-4249-90A8-3CD1EFC9390A@infradead.org>
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

On 13 December 2024 06:45:18 GMT, "Ning, Hongyu" <hongyu=2Ening@linux=2Eint=
el=2Ecom> wrote:
>
>
>On 2024/12/12 18:13, David Woodhouse wrote:
>> On Thu, 2024-12-12 at 11:03 +0800, Ning, Hongyu wrote:
>>>=20
>>> Hi David,
>>>=20
>>> I've hit some kdump/kexec regression issue for guest kernel in KVM/QEM=
U
>>> based VM and reported in https://bugzilla=2Ekernel=2Eorg/show_bug=2Ecg=
i?id=3D219592=2E
>>>=20
>>> based on further git bisect, it seems to be related with this commit,
>>> would you help to take a look?
>>=20
>> Thanks for the report; I'll take a look=2E Please could you share your
>> kernel =2Econfig?
>>=20
>
>kernel config updated in the bugzilla https://bugzilla=2Ekernel=2Eorg/sho=
w_bug=2Ecgi?id=3D219592
>
>> Also, you say that this is in QEMU running on an IA64 host=2E Is that
>> true, or did you mean x86_64 host? Are you using OVMF or SeaBIOS as the
>> QEMU firmware?
>>=20
>
>You're right, it's x86_64 host, I miss-selected it in bugzilla=2E
>I'm using OVMF as the QEMU firmware=2E
>
>> In the short term, I think that just reverting the 'offending' commit
>> should be OK=2E I'd *prefer* not to leave the page RWX for the whole ti=
me
>> period that the image is loaded, but that's how it's been on i386 for
>> ever anyway=2E
>
>And your latest patch https://lore=2Ekernel=2Eorg/kexec/9c68688625f409104=
b16164da30aa6d3eb494e5d=2Ecamel@infradead=2Eorg/ could fix this issue now=
=2E

Thanks=2E Does the newer patch at <https://lore=2Ekernel=2Eorg/kexec/ed7dd=
45f89e8f286478791137447a21d53735dbd=2Ecamel@infradead=2Eorg/> work too? Tha=
t's the cleaner option, I think=2E

