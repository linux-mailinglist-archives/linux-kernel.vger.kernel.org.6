Return-Path: <linux-kernel+bounces-418620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D7E09D6385
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 18:46:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EEC5160E93
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Nov 2024 17:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65735158848;
	Fri, 22 Nov 2024 17:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FMcYbVBm"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8043184D13
	for <linux-kernel@vger.kernel.org>; Fri, 22 Nov 2024 17:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732297605; cv=none; b=WZjGU5D1TOrV6PpHVRKhDIWDUatfUhRpgS/MlIQNgPjahV6nxT4r1ewjKOuJT4buoGj5aci4z4wGEbluvdHV168w/uT63f1CDRBKT/SCv78o7kOk9ncJZ123AHhEGVSMy6EbNtLS2L0bure6A+kvc/+0gCLuvJwqbLx5Uz25ZHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732297605; c=relaxed/simple;
	bh=se3akZ4n0E5uTfufUU0Q238bduY6fpmm4qJsO1cE9e4=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=fFxGVCZP+KKaq1zmKpL56lJYtbrFPxQGWA/LdJqdvnm+MI6+ljqvxv2gxK2BZaCO+GnzIB5T2tWtp1z4LvVz+d/I2EoY/3FpYdlpeSrPzmpCfuS2P9Jyve6sWjeo1ojgpzj6NoPbilLhXchHJK6Gi6sG15T3uQmJT2WlllhVhUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FMcYbVBm; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1732297603; x=1763833603;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=se3akZ4n0E5uTfufUU0Q238bduY6fpmm4qJsO1cE9e4=;
  b=FMcYbVBmi5BBj3xVSPqA3S5vuAM6Xlt2QSDK8X/h1b5vziHfQ0ipeEiY
   rg4GiR/sCGiB/tUTx+78Vp29DEOwnSR4G1fbbQuyBl5Fil7aTYJQ2ttV1
   hRcNMmVPHSFg6NpJbkas+shhW99JOOqTUGfFYIzObQEv4xVfwWP0tFWqX
   QFC0lvDlMziIsaHTJ7kbJl6KcB0ad3ASqn26Tj+NS96AG/GjlUNNIhHyz
   f7iWDp68G8RNjKrSQpJvqWelbMkSAbdGu7Pe8VhAgOnMTC4DGO9tQyye/
   wTli2/SiYwpN/mPXCVHimUwrOE8wfgR/J8ngZSUkUYZqdvyOYC0UqghCD
   w==;
X-CSE-ConnectionGUID: V9sjzV0+QNy9gF7yMdEv4w==
X-CSE-MsgGUID: eKFMTxn1TKaBeY6OHgj6Kg==
X-IronPort-AV: E=McAfee;i="6700,10204,11264"; a="42975304"
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="42975304"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 09:46:42 -0800
X-CSE-ConnectionGUID: 2qIrx0brSJaYXPpEXz6YuA==
X-CSE-MsgGUID: t0uVNsKuSFmsvllS3Uwx6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,176,1728975600"; 
   d="scan'208";a="113913734"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO [10.124.220.110]) ([10.124.220.110])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2024 09:46:42 -0800
Content-Type: multipart/mixed; boundary="------------31DaaGTZcHgscu02RE6el0q7"
Message-ID: <bb937b3f-e595-4aa8-a6e5-08bdbd4702bf@intel.com>
Date: Fri, 22 Nov 2024 09:46:41 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/11] x86/fpu: Remove unnecessary CPUID level check
To: Sean Christopherson <seanjc@google.com>,
 Dave Hansen <dave.hansen@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
 bp@alien8.de, rafael@kernel.org, lenb@kernel.org, dave.jiang@intel.com,
 irenic.rajneesh@gmail.com, david.e.box@intel.com
References: <20241120195327.26E06A69@davehans-spike.ostc.intel.com>
 <20241120195340.047C9ABE@davehans-spike.ostc.intel.com>
 <Zz9VjVKbzMehRTjA@google.com>
Content-Language: en-US
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <Zz9VjVKbzMehRTjA@google.com>

This is a multi-part message in MIME format.
--------------31DaaGTZcHgscu02RE6el0q7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/21/24 07:45, Sean Christopherson wrote:
> On Wed, Nov 20, 2024, Dave Hansen wrote:
>> The CPUID level dependency table will entirely zap X86_FEATURE_XSAVE
> 
> What table is that?  XSAVE depends on FXSR, but I can't find anything that clears
> X86_FEATURE_XSAVE if cpuid_level < XSTATE_CPUID.  Even if it did, dropping a
> sanity check in a one-time path adds risk for almost no reward.

arch/x86/kernel/cpu/common.c::cpuid_dependent_features[]

It's hard to find because it hard-codes the leaf number:

        { X86_FEATURE_XSAVE,            0x0000000d },

Fixing that was my initial motivation for this series.

As for removing the checks, I'd much rather have a super generic check
in the CPUID helpers that have all the callers code something.
Something like the attached patch?
--------------31DaaGTZcHgscu02RE6el0q7
Content-Type: text/x-patch; charset=UTF-8; name="cpuid_count-warn.patch"
Content-Disposition: attachment; filename="cpuid_count-warn.patch"
Content-Transfer-Encoding: base64

CgotLS0KCiBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NwdWlkLmggfCAgICA2ICsrKysrKwog
Yi9hcmNoL3g4Ni9rZXJuZWwvY3B1L2NvbW1vbi5jIHwgICAzOCArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCA0NCBpbnNlcnRpb25z
KCspCgpkaWZmIC1wdU4gYXJjaC94ODYvaW5jbHVkZS9hc20vY3B1aWQuaH5jcHVpZF9jb3Vu
dC13YXJuIGFyY2gveDg2L2luY2x1ZGUvYXNtL2NwdWlkLmgKLS0tIGEvYXJjaC94ODYvaW5j
bHVkZS9hc20vY3B1aWQuaH5jcHVpZF9jb3VudC13YXJuCTIwMjQtMTEtMjIgMDg6NTA6MTIu
NjE4MTg2NjEwIC0wODAwCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL2NwdWlkLmgJMjAy
NC0xMS0yMiAwOToxMDoxMi4xMTIyMTc5NDIgLTA4MDAKQEAgLTY0LDYgKzY0LDggQEAgbmF0
aXZlX2NwdWlkX3JlZyhlZHgpCiAjZGVmaW5lIF9fY3B1aWQJCQluYXRpdmVfY3B1aWQKICNl
bmRpZgogCitleHRlcm4gdm9pZCBjaGVja19jcHVpZF9sZXZlbCh1bnNpZ25lZCBpbnQgbGV2
ZWwpOworCiAvKgogICogR2VuZXJpYyBDUFVJRCBmdW5jdGlvbgogICogY2xlYXIgJWVjeCBz
aW5jZSBzb21lIGNwdXMgKEN5cml4IE1JSSkgZG8gbm90IHNldCBvciBjbGVhciAlZWN4CkBA
IC03Myw2ICs3NSw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBjcHVpZCh1bnNpZ25lZCBpbnQg
b3AKIAkJCSB1bnNpZ25lZCBpbnQgKmVheCwgdW5zaWduZWQgaW50ICplYngsCiAJCQkgdW5z
aWduZWQgaW50ICplY3gsIHVuc2lnbmVkIGludCAqZWR4KQogeworCWNoZWNrX2NwdWlkX2xl
dmVsKG9wKTsKKwogCSplYXggPSBvcDsKIAkqZWN4ID0gMDsKIAlfX2NwdWlkKGVheCwgZWJ4
LCBlY3gsIGVkeCk7CkBAIC04Myw2ICs4Nyw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBjcHVp
ZF9jb3VudCh1bnNpZ25lZAogCQkJICAgICAgIHVuc2lnbmVkIGludCAqZWF4LCB1bnNpZ25l
ZCBpbnQgKmVieCwKIAkJCSAgICAgICB1bnNpZ25lZCBpbnQgKmVjeCwgdW5zaWduZWQgaW50
ICplZHgpCiB7CisJY2hlY2tfY3B1aWRfbGV2ZWwob3ApOworCiAJKmVheCA9IG9wOwogCSpl
Y3ggPSBjb3VudDsKIAlfX2NwdWlkKGVheCwgZWJ4LCBlY3gsIGVkeCk7CmRpZmYgLXB1TiBh
cmNoL3g4Ni9rZXJuZWwvY3B1L2NvbW1vbi5jfmNwdWlkX2NvdW50LXdhcm4gYXJjaC94ODYv
a2VybmVsL2NwdS9jb21tb24uYwotLS0gYS9hcmNoL3g4Ni9rZXJuZWwvY3B1L2NvbW1vbi5j
fmNwdWlkX2NvdW50LXdhcm4JMjAyNC0xMS0yMiAwOTowNzo0My45MjI1OTE3MjAgLTA4MDAK
KysrIGIvYXJjaC94ODYva2VybmVsL2NwdS9jb21tb24uYwkyMDI0LTExLTIyIDA5OjQyOjQ4
Ljk1MDk1MjUzOCAtMDgwMApAQCAtMjQyNSwzICsyNDI1LDQxIEBAIHZvaWQgX19pbml0IGFy
Y2hfY3B1X2ZpbmFsaXplX2luaXQodm9pZCkKIAkgKi8KIAltZW1fZW5jcnlwdF9pbml0KCk7
CiB9CisKK3ZvaWQgY2hlY2tfY3B1aWRfbGV2ZWwodW5zaWduZWQgaW50IGxlYWYpCit7CisJ
dW5zaWduZWQgaW50IHJlZ2lvbiA9IGxlYWYgPj4gNDsKKwlpbnQgbWF4X2xlYWY7CisKKwkv
KgorCSAqIFRoZSBtYXggbGVhZiBpbiBhIHJlZ2lvbiBpcyBkaXNjb3ZlcmVkIGZyb20gdGhl
IGZpcnN0CisJICogbGVhZi4gQWxsb3cgdGhpcyBraW5kIG9mIGRpc2NvdmVyeSB3aXRob3V0
IGNoZWNrczoKKwkgKi8KKwlpZiAoIShsZWFmICYgR0VOTUFTSygzLCAwKSkpCisJCXJldHVy
bjsKKworCXN3aXRjaCAocmVnaW9uKSB7CisJCWNhc2UgMHgwMDAwOgorCQkJbWF4X2xlYWYg
PSBib290X2NwdV9kYXRhLmNwdWlkX2xldmVsOworCQkJYnJlYWs7CisJCWNhc2UgMHg4MDAw
OgorCQkJbWF4X2xlYWYgPSBib290X2NwdV9kYXRhLmV4dGVuZGVkX2NwdWlkX2xldmVsOwor
CQkJYnJlYWs7CisJCWRlZmF1bHQ6CisJCQkvKiBPbmx5IGNoZWNrIHRoZSBiYXNpYyBhbmQg
ZXh0ZW5kZWQgcmVnaW9uczogKi8KKwkJCXJldHVybjsKKwl9CisKKwkvKgorCSAqIFNraXAg
Y2hlY2tzIGJlZm9yZSAtPmNwdWlkX2xldmVsIGlzIHBvcHVsYXRlZAorCSAqIGFuZCBvbiBD
UFVzIHdpdGhvdXQgQ1BVSUQgc3VwcG9ydDoKKwkgKi8KKwlpZiAoIW1heF9sZWFmKQorCQly
ZXR1cm47CisKKwlpZiAobGVhZiA8PSBtYXhfbGVhZikKKwkJcmV0dXJuOworCisJV0FSTl9P
TkNFKDEsICJDUFVJRCByZWFkIGxlYWYgMHgleCBhYm92ZSBtYXggc3VwcG9ydGVkIGxlYWY6
IDB4JXgiLAorCQlsZWFmLCBtYXhfbGVhZik7Cit9Cl8K

--------------31DaaGTZcHgscu02RE6el0q7--

