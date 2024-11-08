Return-Path: <linux-kernel+bounces-402066-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FB99C22F2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 18:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4672E282905
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 17:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34241EE02B;
	Fri,  8 Nov 2024 17:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="U8W+VK2B"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F631E3772
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731086981; cv=none; b=jtv4RtVIa99lqL0sw99g2qppFIUUKynHBms6ZDU1XRBsrpTxcYlM7Hkz++pxiUbX2vHLCNH4oUF8Er6FRQOyYyMsiujNTwJDGS5PnZHYj1PHRKidhpjZ9PjP5WKv5FaRX/Z744UTt0CL1bisdGTsHsaplctnKVYgNX+CshRSbwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731086981; c=relaxed/simple;
	bh=5j6bbISWUu04oQ5uvPb4GsIqHBzgISkT+6K0PVrEChM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=cdpICngVK8MfbawFGc6sPDEih4+x2niNRSf7giUQb55AfFb83KfILgoN/nlrXbysp27CA102suCn+FP7vjQh1aJVudoRTq97BNxu94RzEhZZjnSD+cHuoeAVvEmbSjrsSPeRn2IhCxqrF+GNDu99JRPMBCP3d2UPECAj7sZr89A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=U8W+VK2B; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([92.33.209.142])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4A8HT2JS1689254
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 8 Nov 2024 09:29:05 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4A8HT2JS1689254
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1731086946;
	bh=5j6bbISWUu04oQ5uvPb4GsIqHBzgISkT+6K0PVrEChM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=U8W+VK2BHMw0cnYc/UWtQTHxH802SvAmozWkDPIq580CceuV5GoQkwjcq5QovEF2B
	 7hfV6V+NSyJF3XlhR/MeQfLWrLDgfTj+YJ5raieg390jWnNUlqpAO4bhJUMYl1tvS/
	 UFCVEk+uNA0gt/NTrbmDGao2EaKaaurdaCeIfq2J8fmMABExs9TWMuWh1FXtBm8dYh
	 LJLXFaRF6kUxEJGGE6X8F5E5ARFD6if1paqZ/qwd2KC4KYN2W4jjDQIA6K9PJzXHTh
	 WEEyOczBkdjztI6d5w/McahC79+ghGVB/+M3tbsAgNodpl9yC3WNXK8ZWubuIudbqb
	 iwkaA3i393ZIg==
Date: Fri, 08 Nov 2024 18:28:54 +0100
From: "H. Peter Anvin" <hpa@zytor.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>,
        Dave Hansen <dave.hansen@intel.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v5_1/1=5D_x86/cpu=3A_Make_sure_fl?=
 =?US-ASCII?Q?ag=5Fis=5Fchangeable=5Fp=28=29_is_always_being_used?=
User-Agent: K-9 Mail for Android
In-Reply-To: <Zy48gBu81i9bY0Qp@smile.fi.intel.com>
References: <20241108153105.1578186-1-andriy.shevchenko@linux.intel.com> <732CB428-EE83-455F-A5AF-C008B7541401@zytor.com> <Zy4xHC3MCtAqlSxy@smile.fi.intel.com> <4A528893-A428-4A6F-8672-1D14CC57F696@zytor.com> <Zy48gBu81i9bY0Qp@smile.fi.intel.com>
Message-ID: <0EF5D1F5-6D70-4BEA-B5E9-458836B80221@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 8, 2024 5:29:52 PM GMT+01:00, Andy Shevchenko <andriy=2Eshevche=
nko@linux=2Eintel=2Ecom> wrote:
>On Fri, Nov 08, 2024 at 04:48:16PM +0100, H=2E Peter Anvin wrote:
>> On November 8, 2024 4:41:16 PM GMT+01:00, Andy Shevchenko <andriy=2Eshe=
vchenko@linux=2Eintel=2Ecom> wrote:
>> >On Fri, Nov 08, 2024 at 04:35:17PM +0100, H=2E Peter Anvin wrote:
>> >> On November 8, 2024 4:30:10 PM GMT+01:00, Andy Shevchenko <andriy=2E=
shevchenko@linux=2Eintel=2Ecom> wrote:
>
>=2E=2E=2E
>
>> >> >See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused s=
tatic
>> >> >inline functions for W=3D1 build")=2E
>
>^^^ (1)
>
>=2E=2E=2E
>
>> >> But another question: why the hell does clang complain about an unus=
ed static inline function?!
>> >
>> >Does (1) shed a bit of light to this?
>>=20
>> How on earth is that supposed to work?! We have static inline functions=
 in
>> headers all over the place that are only used in certain circumstances=
=2E
>>=20
>> Is this a good thing, really? Or is it noise?
>
>This is a good question and IIRC somebody else already asked something si=
milar=2E
>
>Clang people are Cc'ed here, I leave this to them to comment on,
>I am not an expert here=2E
>

So there are two questions:

1=2E How? How does this work, technically?=20
2=2E Why? Is this really the right thing to do, or will it result in a bun=
ch of unnecessary #ifdeffery instead?

