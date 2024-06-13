Return-Path: <linux-kernel+bounces-213945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 712AE907CDC
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 21:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D23AFB26FF0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 19:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D664714D29A;
	Thu, 13 Jun 2024 19:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="boTdIyIZ"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9287012D203
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 19:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718307820; cv=none; b=R9KWCjFgjRYhGGYHTl+qFqdsEujw3EJvB0PCUwtxz3JMpkYOX2jwHzaCxsuo8DCDIOUq7EljqZfxhtnBzgS4YlX4OUMM18MPsI2SIdtz8GivvOLoKPq1U4xn8JiH+mcOMunQak+1aQy1/9TaBJZQLKibGWmDbQq2BmBeNTaJ8ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718307820; c=relaxed/simple;
	bh=8dFQhw2iBf1+ECAzpAAhDmTydk1lHcyWnc65mf+v6e0=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=OdRTjX26DBJAtXq379wuFXsiWUCuIU5+TrTyP8yXJffZfNWIG3UZp09XbFpUyUxR3frwVq+97CqHRXHR1iAG1eyAXU0ZIF7c5b9/ljiORUuebHWyBHfI/7Tj8BIoNTimOJPQcSD7FLf/YmpKAQy2C2GsHBtbJrNX3b0k+l2o/HM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=boTdIyIZ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718307818; x=1749843818;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=8dFQhw2iBf1+ECAzpAAhDmTydk1lHcyWnc65mf+v6e0=;
  b=boTdIyIZFbSujAnDS5BcJptcqvc/eMXx3Y1Q3kqT+QlTj2nRxyfMm7v/
   fu75wD9BdygljTzSLbQNElMJUQXzq9vDZj/FvVHdNG/G1WExJdujdAuQ6
   ZN+8bjHy7ZXBoMKENlko88wYeUVuRRGImY1OJOQn3HJoMRMnXnhjQrtRS
   lxH/K97QFvYUFVhR1J0sgRnZgLy54rzoAgHz5wbh3DnR9H2FqgTexY/r4
   8vyj6K2qJDmNbGuCX71JCUTiwkQagWu7g9Ccpo498lxRVI5bfuRRNHH0q
   /FVm3ZM3fvkhz1eAY7qb5cxBOYFGYcIG6I4MJ/T2Vmlm/QgzEkqRfCQZ4
   Q==;
X-CSE-ConnectionGUID: tKMBY4NGRFuXYCAL9PLmFw==
X-CSE-MsgGUID: pHqqt9sjTf2NZL922OxFWw==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15134030"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="15134030"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 12:43:37 -0700
X-CSE-ConnectionGUID: kaGzS6yyTcKEAHY4c9lrUA==
X-CSE-MsgGUID: MufK2c8YSW6IsLxobItBgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="71462450"
Received: from unknown (HELO [10.125.111.40]) ([10.125.111.40])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 12:43:36 -0700
Content-Type: multipart/mixed; boundary="------------RB4Wqh0yzjHDZf1GwiJJ3kNW"
Message-ID: <a984d174-0842-407f-8af9-ed1c506e442b@intel.com>
Date: Thu, 13 Jun 2024 12:43:35 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Bad FPU state detected at restore_fpregs_from_fpstate,
 reinitializing FPU registers. WARNING: at arch/x86/mm/extable.c:127
 fixup_exception
To: Naresh Kamboju <naresh.kamboju@linaro.org>, X86 ML <x86@kernel.org>,
 open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
 Linux Regressions <regressions@lists.linux.dev>
Cc: Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>,
 Dan Carpenter <dan.carpenter@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>
References: <CA+G9fYv57AhE8CX+T_-OP_yi8tzNXpzS_OGZvjyKKgMDKUN4UA@mail.gmail.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <CA+G9fYv57AhE8CX+T_-OP_yi8tzNXpzS_OGZvjyKKgMDKUN4UA@mail.gmail.com>

This is a multi-part message in MIME format.
--------------RB4Wqh0yzjHDZf1GwiJJ3kNW
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Does this fix it?

I think moving the explicit 'struct fpu' out of task_struct took the
knowledge away from the compiler on how to keep the XSAVE buffer
aligned.  Once that happened, we ended up with unaligned XSAVE
operations and bad things happened.

Also, open-coding "task + sizeof(*task)" in three different places seems
suboptimal.

--------------RB4Wqh0yzjHDZf1GwiJJ3kNW
Content-Type: text/x-patch; charset=UTF-8; name="debug-32bit-fpregs.patch"
Content-Disposition: attachment; filename="debug-32bit-fpregs.patch"
Content-Transfer-Encoding: base64

CgotLS0KCiBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3Byb2Nlc3Nvci5oIHwgICAgNyArKysr
KystCiBiL2FyY2gveDg2L2tlcm5lbC9mcHUvY29yZS5jICAgICAgIHwgICAxMSArKystLS0t
LS0tLQogYi9hcmNoL3g4Ni9rZXJuZWwvZnB1L2luaXQuYyAgICAgICB8ICAgIDIgKy0KIDMg
ZmlsZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pCgpkaWZm
IC1wdU4gYXJjaC94ODYva2VybmVsL2ZwdS9jb3JlLmN+ZGVidWctMzJiaXQtZnByZWdzIGFy
Y2gveDg2L2tlcm5lbC9mcHUvY29yZS5jCi0tLSBhL2FyY2gveDg2L2tlcm5lbC9mcHUvY29y
ZS5jfmRlYnVnLTMyYml0LWZwcmVncwkyMDI0LTA2LTEzIDEwOjM5OjMwLjgxOTU4OTc5NCAt
MDcwMAorKysgYi9hcmNoL3g4Ni9rZXJuZWwvZnB1L2NvcmUuYwkyMDI0LTA2LTEzIDEyOjM3
OjQ2LjE2NjQ1MDU3NSAtMDcwMApAQCAtNTcsNyArNTcsNyBAQCBzdHJ1Y3QgZnB1ICp4ODZf
dGFza19mcHUoc3RydWN0IHRhc2tfc3RyCiAJaWYgKFdBUk5fT05fT05DRSh0YXNrLT5mbGFn
cyAmIFBGX0tUSFJFQUQpKQogCQlyZXR1cm4gTlVMTDsKIAotCXJldHVybiAodm9pZCAqKXRh
c2sgKyBzaXplb2YoKnRhc2spOworCXJldHVybiBfX3g4Nl90YXNrX2ZwdSh0YXNrKTsKIH0K
ICNlbmRpZgogCkBAIC01OTQsMTMgKzU5NCw4IEBAIHN0YXRpYyBpbnQgdXBkYXRlX2ZwdV9z
aHN0ayhzdHJ1Y3QgdGFza18KIGludCBmcHVfY2xvbmUoc3RydWN0IHRhc2tfc3RydWN0ICpk
c3QsIHVuc2lnbmVkIGxvbmcgY2xvbmVfZmxhZ3MsIGJvb2wgbWluaW1hbCwKIAkgICAgICB1
bnNpZ25lZCBsb25nIHNzcCkKIHsKLQkvKgotCSAqIFdlIGFsbG9jYXRlIHRoZSBuZXcgRlBV
IHN0cnVjdHVyZSByaWdodCBhZnRlciB0aGUgZW5kIG9mIHRoZSB0YXNrIHN0cnVjdC4KLQkg
KiB0YXNrIGFsbG9jYXRpb24gc2l6ZSBhbHJlYWR5IHRvb2sgdGhpcyBpbnRvIGFjY291bnQu
Ci0JICoKLQkgKiBUaGlzIGlzIHNhZmUgYmVjYXVzZSB0YXNrX3N0cnVjdCBzaXplIGlzIGEg
bXVsdGlwbGUgb2YgY2FjaGVsaW5lIHNpemUuCi0JICovCi0Jc3RydWN0IGZwdSAqZHN0X2Zw
dSA9ICh2b2lkICopZHN0ICsgc2l6ZW9mKCpkc3QpOworCS8qICdkc3QnIGlzIHBhcnRpYWxs
eSBidWlsdCwgZGlzYWJsZSBkZWJ1Z2dpbmc6ICAqLworCXN0cnVjdCBmcHUgKmRzdF9mcHUg
PSBfX3g4Nl90YXNrX2ZwdShkc3QpOwogCiAJQlVJTERfQlVHX09OKHNpemVvZigqZHN0KSAl
IFNNUF9DQUNIRV9CWVRFUyAhPSAwKTsKIApkaWZmIC1wdU4gYXJjaC94ODYvaW5jbHVkZS9h
c20vcHJvY2Vzc29yLmh+ZGVidWctMzJiaXQtZnByZWdzIGFyY2gveDg2L2luY2x1ZGUvYXNt
L3Byb2Nlc3Nvci5oCi0tLSBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3Byb2Nlc3Nvci5ofmRl
YnVnLTMyYml0LWZwcmVncwkyMDI0LTA2LTEzIDExOjA5OjE5LjUwODE4MTAxMyAtMDcwMAor
KysgYi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9wcm9jZXNzb3IuaAkyMDI0LTA2LTEzIDEyOjM2
OjI0LjQ4MDA4Njk2NSAtMDcwMApAQCAtNTA0LDEwICs1MDQsMTUgQEAgc3RydWN0IHRocmVh
ZF9zdHJ1Y3QgewogI2VuZGlmCiB9OwogCisvKiBYU0FWRSByZXF1cmlyZXMgNjQtYnl0ZSBh
bGlnbm1lbnQ6ICovCisjZGVmaW5lIGZwdV9hbGlnbih4KSBBTElHTih4LCA2NCkKKworI2Rl
ZmluZSBfX3g4Nl90YXNrX2ZwdSh0YXNrKQkoKHN0cnVjdCBmcHUgKikoKHZvaWQgKikodGFz
aykgKyBmcHVfYWxpZ24oc2l6ZW9mKCoodGFzaykpKSkpCisKICNpZmRlZiBDT05GSUdfWDg2
X0RFQlVHX0ZQVQogZXh0ZXJuIHN0cnVjdCBmcHUgKng4Nl90YXNrX2ZwdShzdHJ1Y3QgdGFz
a19zdHJ1Y3QgKnRhc2spOwogI2Vsc2UKLSMgZGVmaW5lIHg4Nl90YXNrX2ZwdSh0YXNrKQko
KHN0cnVjdCBmcHUgKikoKHZvaWQgKikodGFzaykgKyBzaXplb2YoKih0YXNrKSkpKQorI2Rl
ZmluZSB4ODZfdGFza19mcHUodGFzaykJX194ODZfdGFza19mcHUodGFzaykKICNlbmRpZgog
CiAvKgpkaWZmIC1wdU4gYXJjaC94ODYva2VybmVsL2ZwdS9pbml0LmN+ZGVidWctMzJiaXQt
ZnByZWdzIGFyY2gveDg2L2tlcm5lbC9mcHUvaW5pdC5jCi0tLSBhL2FyY2gveDg2L2tlcm5l
bC9mcHUvaW5pdC5jfmRlYnVnLTMyYml0LWZwcmVncwkyMDI0LTA2LTEzIDExOjU1OjIyLjU5
NzExNDQ1NCAtMDcwMAorKysgYi9hcmNoL3g4Ni9rZXJuZWwvZnB1L2luaXQuYwkyMDI0LTA2
LTEzIDEyOjM5OjE1LjkyNDQ5MjU2MCAtMDcwMApAQCAtMTU4LDcgKzE1OCw3IEBAIHN0YXRp
YyB2b2lkIF9faW5pdCBmcHVfX2luaXRfdGFza19zdHJ1Y3QKIHsKIAlpbnQgdGFza19zaXpl
ID0gc2l6ZW9mKHN0cnVjdCB0YXNrX3N0cnVjdCk7CiAKLQl0YXNrX3NpemUgKz0gc2l6ZW9m
KHN0cnVjdCBmcHUpOworCXRhc2tfc2l6ZSArPSBmcHVfYWxpZ24oc2l6ZW9mKHN0cnVjdCBm
cHUpKTsKIAogCS8qCiAJICogU3VidHJhY3Qgb2ZmIHRoZSBzdGF0aWMgc2l6ZSBvZiB0aGUg
cmVnaXN0ZXIgc3RhdGUuCl8K

--------------RB4Wqh0yzjHDZf1GwiJJ3kNW--

