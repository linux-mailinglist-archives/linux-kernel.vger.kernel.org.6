Return-Path: <linux-kernel+bounces-401876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17CCF9C2078
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 16:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C262C1F2178D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 15:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 929A1208964;
	Fri,  8 Nov 2024 15:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="SuX/yON2"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C3420820B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 15:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731079910; cv=none; b=ngXFUTQLfx9qCBkV3i2lbHegT5DUPMuSiUhW3hM2mhiwK5xUzIFyLCH0aU6avU63/m6WzqoSJ6hxZOPUazRAgxSpqITcv8vN/4rWJ+DRW/mwZgp7xrRM3NkP9HL4K/zJDOnLJsCYlI4ft2shgagN1t26oSjmWYYw9raOSpQInnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731079910; c=relaxed/simple;
	bh=/HfZ774YdbmA8oA9touOU49tVLFqmqng5zTwT4XwXbM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=Ahm488XmUHrRTb2hBX9x81oAHdbDJvDcxlze28S/hQFJDQREybdF4Ntb81r5uMROsTVFc5Ot3ehrMMjm3Y92PNYSr0RFABrFE/vANFdso3wqk+FS78kHhtFeVk5z/zgy9HISfhNxJo1S9l8KZmub+kFIIxSjldrqCMfLsPoq+6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=SuX/yON2; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([90.224.241.145])
	(authenticated bits=0)
	by mail.zytor.com (8.18.1/8.17.1) with ESMTPSA id 4A8FVJMw1650349
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 8 Nov 2024 07:31:21 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4A8FVJMw1650349
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024101701; t=1731079882;
	bh=GubQTU25zZjYbO7xL8u0rWFRxgg33v6ftcsqsnmXFt0=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=SuX/yON22r8K97IOobl5wjLd2XFGQ6jsGM3teiuNLHaEKtwWDxat4sNiAd7L6D6Ow
	 QBtrzWxIW9A5V3RfQmYKzmFfxEe+KeXny0XzWw8lLgqwWXtjAFcnUV+6IWEwLBkXL1
	 coeE0eetyNi/1MktwGyuTnqO9ZgjIEaRvnBvZvQkMnjjSCgeo0o+GIpQhTZzJ2QF5J
	 coqr8P/XhJ2hB8/eEm3VmB4OMg4EQ8Q59hFE9A58ADYhwrgqFmoEfq/rNhoQEro7b6
	 spgNfoYf58Va9NlvRFFiC4HlbzCsL99tAz4+DH2UO+Qwpz+A5iF37y8cBHDeIhgmbQ
	 /oewF/3g5JeBw==
Date: Fri, 08 Nov 2024 16:31:11 +0100
From: "H. Peter Anvin" <hpa@zytor.com>
To: Sohil Mehta <sohil.mehta@intel.com>, Dave Hansen <dave.hansen@intel.com>,
        x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/cpufeatures: Free up unused feature bits
User-Agent: K-9 Mail for Android
In-Reply-To: <c6da4742-4c08-4375-a9ce-f7dc6308cb71@intel.com>
References: <20241107233000.2742619-1-sohil.mehta@intel.com> <7ff32a10-1950-434b-8820-bb7c3b408544@intel.com> <3492e85d-4aaa-4dd7-9e6a-c8fdc2aa2178@intel.com> <74338393-4F39-4A04-83B1-BA64CE2D2FDA@zytor.com> <4c01a30a-67d9-4918-8781-240b78944c42@intel.com> <c6da4742-4c08-4375-a9ce-f7dc6308cb71@intel.com>
Message-ID: <69E94BB8-256A-49BB-AEDF-E2B034496A40@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On November 8, 2024 3:17:24 AM GMT+01:00, Sohil Mehta <sohil=2Emehta@intel=
=2Ecom> wrote:
>On 11/7/2024 5:12 PM, Dave Hansen wrote:
>> Sohil, go look at:
>>=20
>> # cat /sys/devices/system/cpu/modalias
>> cpu:type:x86,ven0000fam0006mod008C:feature:,0000,0001,0002,0003,0004,00=
05,0006,=2E=2E=2E
>>=20
>
>Thanks for the explanation=2E Peter's comment makes sense to me now=2E
>
>>=20
>> I sure hope we haven't been using too many of these synthetic features
>> in MODULE_DEVICE_TABLE()s, because we tend to move them around, but I
>> guess it's possible=2E
>
>I found at least one recent usage that matches this pattern=2E
>Look at commit cbcddaa33d7e ("perf/x86/rapl: Use CPUID bit on AMD and
>Hygon parts")=2E It defines a synthetic feature bit X86_FEATURE_RAPL and
>adds it to the rapl_model_match[] table=2E
>
>	MODULE_DEVICE_TABLE(x86cpu, rapl_model_match);
>
>It almost seems like some of these bits are now ABI=2E We probably need t=
o
>mark them and keep these mappings pinned to avoid future issues=2E
>Recycling these bits seems to be very common=2E

It was a really unfortunate choice of ABI design, especially since there a=
lready were name strings available=2E=2E=2E

