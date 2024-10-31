Return-Path: <linux-kernel+bounces-391003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A8D9B810D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 18:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C35261C22EE9
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2701BDA9A;
	Thu, 31 Oct 2024 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WTRwBQsi"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4C71B140D
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 17:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730395182; cv=none; b=WAisD+fpmqoQVzwnGd/7K7tf7HcjDDluIHz54u1mtO6zLnGAQxsFxk9iKC9caW/YteeYnwMctjpiLzrSaVAvHORg6OSoYj3gUdWatCwT93cV5betGDykRwcIV6POTw6kG16BdV+8+x3p0iiEPAiIMXWrxhGZl8W4nzy0e0MW6IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730395182; c=relaxed/simple;
	bh=SATOlhjXAD0UWcD77yheOERGFx293ESqTUgEsVi2oFE=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=tpl9Az+E0zTjCX/PVlxLoMvrWhqMS7vD1k0JA4HXOlvASNHWrwX0UNIC+8g7Vmp8OILscFCV2R5YJ3MNtSxzO49ipSWKlcZjh8iIOG4lMF7HpE0AdNB0+SSr6wNusKKUz31TJDlq1nqpkctzV4foEbjKmm7gEMSBZ5sKqxjbIkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WTRwBQsi; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1730395180; x=1761931180;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=SATOlhjXAD0UWcD77yheOERGFx293ESqTUgEsVi2oFE=;
  b=WTRwBQsi8Zcf2uBonr5On2HH7/9x63EVJJLPm9ZJ/kwtwi5PmZkH40Zt
   pwbRhKKkz5HdwaV4DthqFwVKRToUD0gYC5DzA5NwrnajGsnSA/BILcS14
   b7PxA6Wy4VbMdlFuwwhXSSur0UyVpF0yNysS09FrovIf0qxg4sZ/xzAw0
   XKYD3w/Es3grV1Nvk97knZhjIYtw/O3f5L1EJpfcZotfIZbEmfRNu1TUH
   hZHSRDW7AybyTJws1+HeKZbsgWDwsrg5buVxY8vblmtQVL3ARSSrWo88Y
   nq9VQT6lRsbWivGDMUC3/wRsnvsbObnRO0xlyTveyrziJGewBX7/PKcir
   g==;
X-CSE-ConnectionGUID: 8BW+U7lDQmS96RAp5XLFLA==
X-CSE-MsgGUID: Rj91vAH7ShCzLr3LJEsvdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11242"; a="40727841"
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="40727841"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 10:19:38 -0700
X-CSE-ConnectionGUID: 60HWjv43TXKqeprBWd5OHQ==
X-CSE-MsgGUID: IzIzxF4VTHGuhzv0v6577A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,247,1725346800"; 
   d="scan'208";a="113474512"
Received: from msangele-mobl.amr.corp.intel.com (HELO [10.124.220.39]) ([10.124.220.39])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Oct 2024 10:19:38 -0700
Content-Type: multipart/mixed; boundary="------------29wdsN1UIlcYDRTjohlXVOCI"
Message-ID: <4d606240-a8c8-40e5-80da-57c9b4d48179@intel.com>
Date: Thu, 31 Oct 2024 10:19:37 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/11] x86/cpu: Make all all CPUID leaf names consistent
To: Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
 rafael@kernel.org, lenb@kernel.org
References: <20241030213310.C4861EC0@davehans-spike.ostc.intel.com>
 <20241030213329.3253F5F3@davehans-spike.ostc.intel.com>
 <20241031101834.GGZyNZejzr5A9bNL8J@fat_crate.local>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20241031101834.GGZyNZejzr5A9bNL8J@fat_crate.local>

This is a multi-part message in MIME format.
--------------29wdsN1UIlcYDRTjohlXVOCI
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/31/24 03:18, Borislav Petkov wrote:
> On Wed, Oct 30, 2024 at 02:33:29PM -0700, Dave Hansen wrote:
>> diff -puN arch/x86/include/asm/cpuid.h~xsave-leaf-checks-3 arch/x86/include/asm/cpuid.h
>> --- a/arch/x86/include/asm/cpuid.h~xsave-leaf-checks-3	2024-10-30 12:26:59.222216332 -0700
>> +++ b/arch/x86/include/asm/cpuid.h	2024-10-30 12:26:59.238216364 -0700
>> @@ -19,12 +19,12 @@ enum cpuid_regs_idx {
>>  	CPUID_EDX,
>>  };
>>  
>> -#define CPUID_MWAIT_LEAF	0x5
>> -#define CPUID_DCA_LEAF		0x9
>> -#define XSTATE_CPUID		0x0d
>> -#define CPUID_TSC_LEAF		0x15
>> -#define CPUID_FREQ_LEAF		0x16
>> -#define TILE_CPUID		0x1d
>> +#define CPUID_LEAF_MWAIT	0x5
>> +#define CPUID_LEAF_DCA		0x9
>> +#define CPUID_LEAF_XSTATE	0x0d
>> +#define CPUID_LEAF_TSC		0x15
>> +#define CPUID_LEAF_FREQ		0x16
>> +#define CPUID_LEAF_TILE		0x1d
> 
> ... and just to confuse things even more, there's enum cpuid_leafs too which
> start with the "CPUID_" prefix too.
> 
> Pfff.

Yeah, lovely.  'enum cpuid_leafs' does appear misnamed though.  It is a
list of *words*, not actual leaf numbers.  There's also very little
overlap between those leafs and the newly-renamed ones in this series.
I think that's because most of the leaves we dump into the CPU caps have
random feature bits that aren't logically grouped and resist naming.

The one exception to that is the CPUID_D_1_EAX aka. CPUID_LEAF_XSTATE.
We could do something like the attached patch, but I don't think it
really helps much.

> I'd like to unify them and I *think* kvm_cpu_cap_mask() should be able to
> stomach that (or fixed if not)...

Do you mean we could unify the CPUID_8000_0001_EDX enum values and the
CPUID_LEAF_* defines from this series?

I'm not quite sure how that would look.  I think we'd end up doing
something like:

#define CPUID_LEAF_C000_0001 	0xC0000001

and we'd still need some macro magic to munge the word "number" into
there, like:

#define FOO(x,reg) ((x)<<2 | CPUID_##reg)

that could be used this way:

enum cpuid_leafs
{
	...
        FOO(CPUID_LEAF_C000_0001, EDX),

It would let us do stuff like this:

-        case 0xC0000001:
+        case CPUID_LEAF_C000_0001:
                cpuid_entry_override(entry, CPUID_C000_0001_EDX);
                break;

But I'm not sure that makes things all that much more readable or greppable.

--------------29wdsN1UIlcYDRTjohlXVOCI
Content-Type: text/x-patch; charset=UTF-8; name="leafd.patch"
Content-Disposition: attachment; filename="leafd.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9jcHUvY29tbW9uLmMgYi9hcmNoL3g4Ni9r
ZXJuZWwvY3B1L2NvbW1vbi5jCmluZGV4IGE1ZjIyMWVhNTY4OC4uYjQ0ZGJiOTUyZDhjIDEw
MDY0NAotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L2NvbW1vbi5jCisrKyBiL2FyY2gveDg2
L2tlcm5lbC9jcHUvY29tbW9uLmMKQEAgLTEwMDEsOCArMTAwMSw4IEBAIHZvaWQgZ2V0X2Nw
dV9jYXAoc3RydWN0IGNwdWluZm9feDg2ICpjKQogCX0KIAogCS8qIEV4dGVuZGVkIHN0YXRl
IGZlYXR1cmVzOiBsZXZlbCAweDAwMDAwMDBkICovCi0JaWYgKGMtPmNwdWlkX2xldmVsID49
IDB4MDAwMDAwMGQpIHsKLQkJY3B1aWRfY291bnQoMHgwMDAwMDAwZCwgMSwgJmVheCwgJmVi
eCwgJmVjeCwgJmVkeCk7CisJaWYgKGMtPmNwdWlkX2xldmVsID49IENQVUlEX0xFQUZfWFNU
QVRFKSB7CisJCWNwdWlkX2NvdW50KENQVUlEX0xFQUZfWFNUQVRFLCAxLCAmZWF4LCAmZWJ4
LCAmZWN4LCAmZWR4KTsKIAogCQljLT54ODZfY2FwYWJpbGl0eVtDUFVJRF9EXzFfRUFYXSA9
IGVheDsKIAl9Cg==

--------------29wdsN1UIlcYDRTjohlXVOCI--

