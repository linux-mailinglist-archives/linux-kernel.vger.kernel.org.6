Return-Path: <linux-kernel+bounces-401575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E979C1C71
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 12:51:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6EE91C22CE7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 11:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949271E3DCE;
	Fri,  8 Nov 2024 11:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="BHVZVMhd"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7869E1E0E10
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 11:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731066691; cv=none; b=E7uGHzOVlosA6ZeiQzlMMdqXKLdY2WWkS6gWU26YJ/u3TeqTEn63C9uEXIZ3ZP9fG04HkMmfvO0Qw4WKjK2Vxs8v2wknEJPHjuN33gmSQTQDPu2/Lvl8acjSBwMxuuhEUY1X4IezDFLopsbCP0f8qoAe4o41w0PcCQi+nMhNBUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731066691; c=relaxed/simple;
	bh=p+SEOJF42n/7xCSKD/yGr63wTiAxWW12wAHMIbVethY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=B8hAIFBGcO/AvVJMJfpOOgQkRS4HCciYppmVwzsXc28aNbEu21nYpkk1nMDDjVACEJtmy11mybCghdahGVmIO6axUUyyYLzSEzPOH8Fx6tHh9fnLc5fgQ9A++t4kXwfvZdIcjA0ApmKGBMz7+XbIdfJU5dI0lx+gloNpf2ZoXBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=BHVZVMhd; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([172.58.142.188])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4A8BovPD1579194
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 8 Nov 2024 03:51:00 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4A8BovPD1579194
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1731066661;
	bh=bl4d8eOiYumn5v1PCbU3Zv/ucJgBjpYSbVD/0qR+qRI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=BHVZVMhdHTq7MtzIScgPIgAj1grUC85oacZxWKepzCDJ79rj/DTGivc4d0z0zjTph
	 5ewL917gz2oiavDZEIxm+/OUN01UPDGptMBkPsOTc6c/WtQn94KumtO4d+dv92JNJF
	 DLsqbW7p0w4SPVk3hdeqUxTpKR8JaRG6xjODaVqyHDPZjLUFXTdYLd5oT1e+6gvasz
	 V1Cq4YnFOKBA3+JGulaWRxgUYHqZVuqjLEaAXtIakL7jMXTHDmoBwyt71XdOQ002mg
	 rUnxPJWihKbCAGhPXcwFPaD5+1kJZudwle51/ooW59c4MSaqAU1b4o1FHwzqSNU7jN
	 sbF+2sp20jCMg==
Date: Fri, 08 Nov 2024 12:50:49 +0100
From: "H. Peter Anvin" <hpa@zytor.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
CC: Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_1/1=5D_x86/cpu=3A_Make_sure_fl?=
 =?US-ASCII?Q?ag=5Fis=5Fchangeable=5Fp=28=29_is_always_being_used?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Zy3Z3kYOOV3PzG8M@smile.fi.intel.com>
References: <20240910084356.1518209-1-andriy.shevchenko@linux.intel.com> <Zy3Z3kYOOV3PzG8M@smile.fi.intel.com>
Message-ID: <52362D81-CE7E-4F06-AA1E-B8C55933B4B4@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 8, 2024 10:29:02 AM GMT+01:00, Andy Shevchenko <andriy=2Eshevch=
enko@linux=2Eintel=2Ecom> wrote:
>On Tue, Sep 10, 2024 at 11:42:42AM +0300, Andy Shevchenko wrote:
>> When flag_is_changeable_p() is unused, it prevents kernel builds
>> with clang, `make W=3D1` and CONFIG_WERROR=3Dy:
>>=20
>> arch/x86/kernel/cpu/common=2Ec:351:19: error: unused function 'flag_is_=
changeable_p' [-Werror,-Wunused-function]
>>   351 | static inline int flag_is_changeable_p(u32 flag)
>>       |                   ^~~~~~~~~~~~~~~~~~~~
>>=20
>> Fix this by moving core around to make sure flag_is_changeable_p() is
>> always being used=2E
>>=20
>> See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused stati=
c
>> inline functions for W=3D1 build")=2E
>
>Any comments on this? Can it be applied?
>

Incidentally, this really should be "unsigned long" rather than u32, altho=
ugh I believe it is only used on 32 bits=2E

