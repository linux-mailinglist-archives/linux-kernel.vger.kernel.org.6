Return-Path: <linux-kernel+bounces-401915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A93439C20FE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:49:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D2EC1F25301
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D216C21A71E;
	Fri,  8 Nov 2024 15:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="q3iA9Ead"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1DB321A71B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 15:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731080942; cv=none; b=rASct0orR+Rg2CHehALEdr4giYHL95p9nnm0SxoabysF8QTYYVKTalBmx6VLaJptkocha3tJOCN+DChP8NOd9XnlLg1xitco6ecrDF8L6hm7MS8fztYFCS37wD4TiPsgPM11yRDCcUbyABu9CC2ECr+0wxc7a20VHTHrBMT5GG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731080942; c=relaxed/simple;
	bh=MLMZ4Qbm132WMpNRKYFC+f34b+Ke2+QAK8M6qn5aECE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=rmeMS3K8M4PDPZnzMh5cL3bhvjOnJDf2+Ucqgbe+1riOlU4gaN3QPQ5p4wPQKc8gSt8VzE2N12RgCyyifj+p9kAr3qIf73mMHqFptzdypfT/3Xgkyhx75/ciwlSWL55VA+IN4coLW3KTr3lLyOJJhzslieLRvdofEkld0IEuueQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=q3iA9Ead; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([90.224.241.145])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4A8FmOh41657183
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 8 Nov 2024 07:48:27 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4A8FmOh41657183
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1731080909;
	bh=MLMZ4Qbm132WMpNRKYFC+f34b+Ke2+QAK8M6qn5aECE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=q3iA9EadZdyh/oFOsm2zhku4TPLecF7JXFhTBYy9ulJdJwr//RO1WCaKQoLfVV9q4
	 rB4P8xujWHSoJrufYU2ExMOYWVT1JfI2rUaPJdBPVDPYmhJ9dFWCFHpuDFyzltMk3a
	 V+qppx/bNaV6XW5Qsjye1ygboyD5bHKqgoDDKC9UQqTZq3ieLl3HwSnIXNYweNloY6
	 wWosFqRYVY9q6iH6VjkxR15CV7Q8w8bO4U7eno8Mt0fDClDcTHlQzNA8K3Rsmymrbv
	 7pyy8LRS0lL8JixzZvKTZPI4YKgaZirQr3RjMEaTkdT0hv8JUYG4MTvzyAS3ud4EgZ
	 dhKXTb8Ps8pYQ==
Date: Fri, 08 Nov 2024 16:48:16 +0100
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
In-Reply-To: <Zy4xHC3MCtAqlSxy@smile.fi.intel.com>
References: <20241108153105.1578186-1-andriy.shevchenko@linux.intel.com> <732CB428-EE83-455F-A5AF-C008B7541401@zytor.com> <Zy4xHC3MCtAqlSxy@smile.fi.intel.com>
Message-ID: <4A528893-A428-4A6F-8672-1D14CC57F696@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 8, 2024 4:41:16 PM GMT+01:00, Andy Shevchenko <andriy=2Eshevche=
nko@linux=2Eintel=2Ecom> wrote:
>On Fri, Nov 08, 2024 at 04:35:17PM +0100, H=2E Peter Anvin wrote:
>> On November 8, 2024 4:30:10 PM GMT+01:00, Andy Shevchenko <andriy=2Eshe=
vchenko@linux=2Eintel=2Ecom> wrote:
>
>> >See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused stat=
ic
>> >inline functions for W=3D1 build")=2E
>
>^^^ (1)
>
>> Looks good to me:
>>=20
>> Reviewed-by: H=2E Peter Anvin (Intel) <hpa@zytor=2Ecom>
>
>Thank you!
>
>> But another question: why the hell does clang complain about an unused =
static inline function?!
>
>Does (1) shed a bit of light to this?
>

How on earth is that supposed to work?! We have static inline functions in=
 headers all over the place that are only used in certain circumstances=2E=
=20

Is this a good thing, really? Or is it noise?

