Return-Path: <linux-kernel+bounces-378444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8279AD041
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 18:26:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E073284E03
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 16:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC9791CDA31;
	Wed, 23 Oct 2024 16:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="UeHl3464";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UDSRgzmP"
Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 189441CB530
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729700719; cv=none; b=UqQLZZbKJBeG/LiXM7LsIqkdA5GqwrLl7l+R/Kc3TnDVdYn/zscwl0dzLF5ZbPV9JspiqWO4cIIMlKr0lNVkFhNmF+eh4myxWg3Dw7pL+McyioD793dzA1LW4f2/OQFr+E03ZG8cPEL18kvFSILsjbroVTsZwTEjHTHGpWbKwDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729700719; c=relaxed/simple;
	bh=TPEkFtK0CFaFnwhxDZso+FHpRSBe8QIgtFvTQ/jnoDE=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=ovHWKfF5+2aWWykdXKVngKsZD6zgEtItFwR2MwYNyVtN6F2zlh7M+lYGmPIaggbSSW1Iij0TiqIzd8ZgcLDfmTnb3yNPRLJJwe+ib4HXYz+yB+4jYP2OXtfp4Akj4qSQMCX3yPbp6FBH4sN1ibJocxD0CbYbOqm4NImjaWVhp7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=UeHl3464; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UDSRgzmP; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 397861380258;
	Wed, 23 Oct 2024 12:25:17 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-10.internal (MEProxy); Wed, 23 Oct 2024 12:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1729700717;
	 x=1729787117; bh=ezYfh8vGbBGoL35ugyvD9i4flPvQdh7bUpgBPSQRYk4=; b=
	UeHl3464JEn+yoSzXIvaxeQh6e0hcSBe5ww0Ds4gygXos/Ojhd05WqBiyYSXNIdg
	XGu5wEktHYRy5weGkqVd1IeDtTFwKXtDDtgAPLDtMq9xCJdW8skfzQSW2fZCWzkX
	uwBurbAo1qfO/hpPWUVzwutGqon5+6knnv0imhktmq7qmBuVP5q0RhLLIqY8ZwFX
	Mgdaat5xTd/umnkoJdg/p9qsYUFcuSTcL9TUXHB56/2FfwbqE5lqIHMbIdXACGrc
	v1o3lq3sJ9ivreuS4c5T37FnYcaFXit+Dm1K8EcfmLsyDkqlkeDToh8RQlMjrMm/
	fxkW6G7+sX3o/VqoQ2sZxA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1729700717; x=
	1729787117; bh=ezYfh8vGbBGoL35ugyvD9i4flPvQdh7bUpgBPSQRYk4=; b=U
	DSRgzmPXC0B22rx5tQfEA4tfrW3UPXPh07ArM8jXCUiEXFaQ4KBDMpA2l7or30Z6
	z1SQK0RGWUN6SWPhM2auj7xvPr/+FpwG1urmkZETRx56g4jWaG9lr3+S74yZYGb/
	wGnsMO8qwA6/UC4aqd+rRavmk86V2sW2VZcaqUEOmKbeArUKcEQWQoZVr+U/Q0q6
	TDGq2LdauNNmSRUAnSvWbgF1CbGsK/2nd0T0HL9eIWv1tooJpgKgXuhxv11W+yV3
	jXLXeNJ2FBnKg9PSZMGtEzYTMO6+wSO6LTqmKxL7o/ka1pitetlyDtGnf0n1gBVk
	e4we+9lB0lV//8284X2ZQ==
X-ME-Sender: <xms:bCMZZ6cgN86NZjlQ77gb_-7EQEj3WV3bermbUqFqBsR16TaydfTDgg>
    <xme:bCMZZ0MNuYjpr2z43CfpbdMNe8-EgoUTHaEotzF_-D5CmZdsEtfQ0E1pYbej7qWV2
    RjrBupl19GXR4MaRjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeijedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudeh
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegrihhshhifrghrhigrrdhttghvse
    grrhhmrdgtohhmpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdr
    tghomhdprhgtphhtthhopehvihhntggvnhiiohdrfhhrrghstghinhhosegrrhhmrdgtoh
    hmpdhrtghpthhtohepsghrohhonhhivgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    rghlvgigrdgsvghnnhgvvgeslhhinhgrrhhordhorhhgpdhrtghpthhtoheprghnuggvrh
    hsrdhrohigvghllheslhhinhgrrhhordhorhhgpdhrtghpthhtohepnhgrrhgvshhhrdhk
    rghmsghojhhusehlihhnrghrohdrohhrghdprhgtphhtthhopehpvghtvghrrdhmrgihug
    gvlhhlsehlihhnrghrohdrohhrghdprhgtphhtthhopehtghhlgieslhhinhhuthhrohhn
    ihigrdguvg
X-ME-Proxy: <xmx:bCMZZ7gv2cOAzGtQ6izYwfARe9dQFEgcHUsD9NZzPHJ3PkK404tgAQ>
    <xmx:bCMZZ38N3FZ4uEiq60yrwuxzICelSSESBSVHgH7gMObr6zjJ96fdQA>
    <xmx:bCMZZ2udKX8GScfWKbHpPMRjTXUwjEReO1paH-uLugCkgT7vO5Rx2A>
    <xmx:bCMZZ-HEsPGfk_cPUCvItTIBB2VdGuF8SQ6CnOQMI6fsGw-fW72mPg>
    <xmx:bSMZZ2HyXyBrpdGtVf8NbxzkdUkyA2fOSW33YlwBMcMSwqQau3-neLsV>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4FF162220072; Wed, 23 Oct 2024 12:25:16 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 23 Oct 2024 16:24:43 +0000
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Naresh Kamboju" <naresh.kamboju@linaro.org>,
 "open list" <linux-kernel@vger.kernel.org>,
 "Linux ARM" <linux-arm-kernel@lists.infradead.org>,
 lkft-triage@lists.linaro.org,
 "Linux Regressions" <regressions@lists.linux.dev>, qemu-devel@nongnu.org
Cc: "Mark Brown" <broonie@kernel.org>,
 "Catalin Marinas" <catalin.marinas@arm.com>,
 "Aishwarya TCV" <Aishwarya.TCV@arm.com>,
 "Peter Maydell" <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Anders Roxell" <anders.roxell@linaro.org>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Geert Uytterhoeven" <geert@linux-m68k.org>
Message-Id: <4730e562-7d14-4f12-897a-e23783d094af@app.fastmail.com>
In-Reply-To: 
 <CA+G9fYsMg0fA-jraEvC==0a-22J97o-uBmbLJt16_ZKBpOT8EQ@mail.gmail.com>
References: 
 <CA+G9fYt86bUAu_v5dXPWnDUwQNVipj+Wq3Djir1KUSKdr9QLNg@mail.gmail.com>
 <CA+G9fYsMg0fA-jraEvC==0a-22J97o-uBmbLJt16_ZKBpOT8EQ@mail.gmail.com>
Subject: Re: Qemu v9.0.2: Boot failed qemu-arm with Linux next-20241017 tag.
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sun, Oct 20, 2024, at 17:39, Naresh Kamboju wrote:
> On Fri, 18 Oct 2024 at 12:35, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>
>> The QEMU-ARMv7 boot has failed with the Linux next-20241017 tag.
>> The boot log is incomplete, and no kernel crash was detected.
>> However, the system did not proceed far enough to reach the login prompt.
>>

> Anders bisected this boot regressions and found,
> # first bad commit:
>   [efe8419ae78d65e83edc31aad74b605c12e7d60c]
>     vdso: Introduce vdso/page.h
>
> We are investigating the reason for boot failure due to this commit.

Anders and I did the analysis on this, the problem turned out
to be the early_init_dt_add_memory_arch() function in
drivers/of/fdt.c, which does bitwise operations on PAGE_MASK
with a 'u64' instead of phys_addr_t:

void __init __weak early_init_dt_add_memory_arch(u64 base, u64 size)
{
        const u64 phys_offset = MIN_MEMBLOCK_ADDR;
 
        if (size < PAGE_SIZE - (base & ~PAGE_MASK)) {
                pr_warn("Ignoring memory block 0x%llx - 0x%llx\n",
                        base, base + size);
                return;
        }

        if (!PAGE_ALIGNED(base)) {
                size -= PAGE_SIZE - (base & ~PAGE_MASK);
                base = PAGE_ALIGN(base);
        }

On non-LPAE arm32, this broke the existing behavior for
large 32-bit memory sizes. The obvious fix is to change
back the PAGE_MASK definition for 32-bit arm to a signed
number.

mips32, ppc32 and hexagon had the same definition as
well, so I think we should change at least those in order
to restore the previous behavior in case they are affected
by the same bug (or a different one).

x86-32 and arc git flipped the other way by the patch,
from unsigned to signed, when CONFIG_ARC_HAS_PAE40
or CONFIG_X86_PAE are set. I think we should keep
the 'signed' behavior as this was a bugfix by itself,
but we may want to change arc and x86-32 with short
phys_addr_t the same way for consistency.

On csky, m68k, microblaze, nios2, openrisc, parisc32,
riscv32, sh, sparc32, um and xtensa, we've always used
the 'unsigned' PAGE_MASK, and there is no 64-bit
phys_addr_t, so I would lean towards staying with
'unsigned' in order to not introduce a regression.
Alternatively we could choose to go with the 'signed'
version on all 32-bit architectures unconditionally
for consistency. Any preferences?

      Arnd

