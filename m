Return-Path: <linux-kernel+bounces-229387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDA9916F28
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 19:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E05EC1C22D54
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 17:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4BDD176FAE;
	Tue, 25 Jun 2024 17:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BsuK0+tr"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C4B5176AD5
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 17:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719336327; cv=none; b=sPJxBCqC64z0xJ47eodU/RC4le9IvFchl0nzNIIPpwBKxlZ6Cj7YGOup+XWmhLuCWDoPXr2YyW5e2NQhUHa/gqfeWB2OHiaADi335isLQFlMObCRmdV3zgTGcTjURsPLwtiPGNIwJw15QlKEjKzJ5Hy7H6Oxsy6oNdCUNusA3+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719336327; c=relaxed/simple;
	bh=rhhMPZpUsdGm0L9HEvb97nmJQmpVovoT+TufZ0Lx1Ns=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=geIihAOiLlkAt0Axj+iRFyPcD5ggqemC0qpTCVklOjfWYczRAbRrok0XspzAy5zyI/RBW8V6r/K0V23Dp5qmZHd1yt8TlCo0w6sEGSp/ycZqlhPMbbVZJ96gACN3ioEIVbKjdw6GUoINLHy5QqfTOaQOBP33oo3RmV5ljWZ6l6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=BsuK0+tr; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 45PHOt1H1705610
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 25 Jun 2024 10:24:55 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 45PHOt1H1705610
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024061501; t=1719336296;
	bh=4EI8JTR7ZDlO8DnflUjmPqqVyFTPwX3sqUU5lFlbH7U=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=BsuK0+tr+kcolF90yCtsNWkY6/8Tfde+d0BmnZFrA4tWUHtBemLv67l+nsDl1GiEz
	 Tap+p/p4oZiPxM8+5iEBookz+jJUaxRH06V238v1QYJe5mMHbRUrqsRVS9StUy9b8B
	 PvXnFiBRtFFEfkMtldlGVgBATWJw9xDZlFcKFm4JZNOGwkIdB/3b8fXGYLY6w220uW
	 USBOGjQ2Nk6hCbsV8guekQEKoLagnBl9mLRFc5HGk6SiPrZMjs2dWrI9GTFYU2ShMC
	 auidBakSMBsuCIlVd1znMJaKl8uedg2cTaw9UyqDGpIVJ25gcWXR7evuujvYlBj2X3
	 6y9EHzSSFJv/Q==
Date: Tue, 25 Jun 2024 10:24:53 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Xin Li <xin@zytor.com>, Hou Wenlong <houwenlong.hwl@antgroup.com>
CC: linux-kernel@vger.kernel.org, Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Xin Li <xin3.li@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_0/2=5D_x86/fred=3A_Fix_two_pr?=
 =?US-ASCII?Q?oblems_during_the_FRED_initialization?=
User-Agent: K-9 Mail for Android
In-Reply-To: <f8ab27ff-d6cf-41c7-a033-9e578b1e51fb@zytor.com>
References: <cover.1718972598.git.houwenlong.hwl@antgroup.com> <58ec98bf-b66c-4249-8a10-ff254cd405c2@zytor.com> <20240624062143.GA59245@k08j02272.eu95sqa> <f8ab27ff-d6cf-41c7-a033-9e578b1e51fb@zytor.com>
Message-ID: <6D3EF8F0-9D70-438B-9B9C-9BC1A64E17E3@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On June 25, 2024 2:09:29 AM PDT, Xin Li <xin@zytor=2Ecom> wrote:
>On 6/23/2024 11:21 PM, Hou Wenlong wrote:
>> On Sat, Jun 22, 2024 at 08:31:26AM +0800, Xin Li wrote:
>>> On 6/21/2024 6:12 AM, Hou Wenlong wrote:
>>>> One issue is that FRED can be disabled in trap_init(), but
>>>> sysvec_install() can be called before trap_init(), thus the system
>>>> interrupt handler is not installed into the IDT if FRED is disabled
>>>> later=2E Initially, I attempted to parse the cmdline and decide wheth=
er to
>>>> enable or disable FRED after parse_early_param()=2E However, I ultima=
tely
>>>> chose to always install the system handler into the IDT in
>>>> sysvec_install(), which is simple and should be sufficient=2E
>>>=20
>>> Which module with a system vector gets initialized before trap_init() =
is
>>> called?
>>>=20
>> Sorry, I didn't mention the case here=2E I see sysvec_install() is used
>> only in the guest part (KVM, HYPERV) currently=2E For example, the KVM
>> guest will register the HYPERVISOR_CALLBACK_VECTOR APF handler in
>> kvm_guest_init(), which is called before trap_init()=2E So if only the =
FRED
>> handler is registered and FRED is disabled in trap_init() later, then t=
he
>> IDT handler of the APF handler is missing=2E
>
>This is a bug!  Your fix looks good to me=2E
>
>>>> Another problem is that the page fault handler (exc_page_fault()) is
>>>> installed into the IDT before FRED is enabled=2E Consequently, if a #=
PF is
>>>> triggered in this gap, the handler would receive the wrong CR2 from t=
he
>>>> stack if FRED feature is present=2E To address this, I added a page f=
ault
>>>> entry stub for FRED similar to the debug entry=2E However, I'm uncert=
ain
>>>> whether this is enough reason to add a new entry=2E Perhaps a static =
key
>>>> may suffice to indicate whether FRED setup is completed and the handl=
er
>>>> can use it=2E
>>>=20
>>> How could a #PF get triggered during that gap?
>>>=20
>>> Initialization time funnies are really unpleasant=2E
>>>=20
>> I'm not sure if there will be a #PF during that gap; I just received th=
e
>> wrong fault address when I made a mistake in that gap and a #PF
>> occurred=2E Before idt_setup_early_pf(), the registered page fault hand=
ler
>> is do_early_exception(), which uses native_read_cr2()=2E However, after
>> that, the page fault handler had been changed to exc_page_fault(), so i=
f
>> something bad happened and an unexpected #PF occurred, the fault addres=
s
>> in the error output will be wrong, although the CR2 in __show_regs() is
>> correct=2E I'm not sure if this matters or not since the kernel will pa=
nic
>> at that time=2E
>
>So this doesn't sound a real problem, right?
>
>We could simply do:
>
>diff --git a/arch/x86/mm/fault=2Ec b/arch/x86/mm/fault=2Ec
>index e6c469b323cc=2E=2Ee500777ed2b4 100644
>--- a/arch/x86/mm/fault=2Ec
>+++ b/arch/x86/mm/fault=2Ec
>@@ -1495,7 +1495,7 @@ DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
>           irqentry_state_t state;
>           unsigned long address;
>
>-       address =3D cpu_feature_enabled(X86_FEATURE_FRED) ? fred_event_da=
ta(regs) : read_cr2();
>+       address =3D native_read_cr4() & X86_CR4_FRED ? fred_event_data(re=
gs) : read_cr2();
>
>           prefetchw(&current->mm->mmap_lock);
>
>
>But the page fault handler is an extreme hot path, it's not worth it=2E
>
>Thanks!
>       Xin
>
>
>
>

Reading CR4 is insane from a performance perspective=2E Also, there is pre=
tty much never a reason to, since CR4 is programmed by the OS=2E

But this is basically insane=2E We should enable FRED from the point we cu=
t over from the early exception vector=2E That is:=20

Early IDT =E2=86=92 Final IDT
or
Early IDT =E2=86=92 FRED

But not

Early IDT =E2=86=92 Final IDT =E2=86=92 FRED

Eventually we should enable FRED for early exceptions too (which ought to =
be quite trivial, but makes the whole CLI enable/disable a bit of a mess=2E=
)

