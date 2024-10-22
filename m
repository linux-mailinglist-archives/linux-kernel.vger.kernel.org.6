Return-Path: <linux-kernel+bounces-377124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 353D19ABA20
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 01:36:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C58D42848FF
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 23:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4BA1CDA2F;
	Tue, 22 Oct 2024 23:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b="q5GDxAjn"
Received: from gentwo.org (gentwo.org [62.72.0.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEBB18DF6B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 23:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.72.0.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729640179; cv=none; b=plLUS9X5UG90N/QaPUo5t8jwhPHIS6O9JJNGnGgvI0NOjqxqQk0bxklWoHqdMqYj9iNtz3/N21xpyygpy+iGdGRwUVhjt94VldxvkNxL5ARpBcNaTCgIftO7svwhoBL07JIoaZOU0OK1wasDh0X/VAPArB5SYLmakQ1lrBKgoWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729640179; c=relaxed/simple;
	bh=78Khv5juGgQH/Jy7dvVkLWEo852D6IKfW/q7DCFoFl8=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=qIfXHWMvZDMgEmo3OF8UOiRO/I0u3BPLMkh44DmpduPeQ8VyYXxt8NKfgOtPz/yvX0YqWHOyJ4mD3ESt5nCrMqA9ol5P3Z8Q1anfIrODAG/JZAtwHe4bEIzxXzu5kuMGI2ZLWhBZnmF5vUyGoCU1ev8TADYjPLarPCNCOuzPPAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org; spf=pass smtp.mailfrom=gentwo.org; dkim=pass (1024-bit key) header.d=gentwo.org header.i=@gentwo.org header.b=q5GDxAjn; arc=none smtp.client-ip=62.72.0.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gentwo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentwo.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gentwo.org;
	s=default; t=1729639462;
	bh=78Khv5juGgQH/Jy7dvVkLWEo852D6IKfW/q7DCFoFl8=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=q5GDxAjna6FBWfQDmtaBFPTjIwOoyueGOlWbgv86R29LmQubM2AP4+7+9WskTctIf
	 gSh/GdV8I/FRAFKtZ2a/LYngiohwXo04TadoHEz7pWSTnC63do+KpCcTleCwkrXtiB
	 NKEk2GIQGj3PP/d1xl8fm9RGvsH9PPG0YBiSBGiE=
Received: by gentwo.org (Postfix, from userid 1003)
	id 0452040350; Tue, 22 Oct 2024 16:24:22 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by gentwo.org (Postfix) with ESMTP id 0112B4022C;
	Tue, 22 Oct 2024 16:24:21 -0700 (PDT)
Date: Tue, 22 Oct 2024 16:24:21 -0700 (PDT)
From: "Christoph Lameter (Ampere)" <cl@gentwo.org>
To: Dave Hansen <dave.hansen@intel.com>
cc: Peter Zijlstra <peterz@infradead.org>, 
    Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
    Ingo Molnar <mingo@kernel.org>, Uros Bizjak <ubizjak@gmail.com>, 
    linux-mm@kvack.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
    Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, 
    Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
    Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
    x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
    Nathan Chancellor <nathan@kernel.org>, 
    Nick Desaulniers <ndesaulniers@google.com>, 
    Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] x86/percpu: Cast -1 to argument type when comparing
 in percpu_add_op()
In-Reply-To: <c22fd9c5-6727-46c2-a811-784315edf7cb@intel.com>
Message-ID: <4b1a26b2-cccb-75d8-ee2f-f30ae211e598@gentwo.org>
References: <20240905170356.260300-1-andriy.shevchenko@linux.intel.com> <f02e0624-ad4f-473c-b172-6dadea37f600@intel.com> <20241016192011.GY17263@noisy.programming.kicks-ass.net> <de705cdf-ccce-460f-846e-dfc63c63af1a@intel.com> <20241017181859.GB17263@noisy.programming.kicks-ass.net>
 <c22fd9c5-6727-46c2-a811-784315edf7cb@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY=------------j7icfEkLOSMelbrpKGR8X0pv
Content-ID: <03be023f-9e1d-18f8-9dd3-0eb3ab270b65@gentwo.org>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--------------j7icfEkLOSMelbrpKGR8X0pv
Content-Type: text/plain; CHARSET=US-ASCII
Content-ID: <5f92f215-6566-b2a4-c30c-23ba1b1cb31e@gentwo.org>

On Tue, 22 Oct 2024, Dave Hansen wrote:

> So I think Peter's version was the best.  It shuts up clang and also
> preserves the existing (good) gcc 'sub' behavior.  I'll send it out for
> real in a bit, but I'm thinking of something like the attached patch.

The desired behavior is a "dec". "sub" has a longer op code AFAICT.

--------------j7icfEkLOSMelbrpKGR8X0pv
Content-Type: text/x-patch; CHARSET=UTF-8; NAME=0001-x86-percpu-Avoid-comparing-unsigned-types-to-1.patch
Content-Transfer-Encoding: BASE64
Content-ID: <dbb55d79-d275-7170-487f-23f4a62f5905@gentwo.org>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME*0=0001-x86-percpu-Avoid-comparing-unsigned-types-to-1.patch

RnJvbSBkNjNiY2QzNTBlMWEzYmE2MTk2ZGFkYjI2Y2IyZjM2ZjBiYTFlMTgyIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXgu
aW50ZWwuY29tPgpEYXRlOiBGcmksIDE4IE9jdCAyMDI0IDExOjA3OjQ3IC0wNzAwClN1Ympl
Y3Q6IFtQQVRDSF0geDg2L3BlcmNwdTogQXZvaWQgY29tcGFyaW5nIHVuc2lnbmVkIHR5cGVz
IHRvIC0xCgpjbGFuZyB3YXJucyB3aGVuIGNvbXBhcmluZyBhbiB1bnNpbmdlZCB0eXBlIHRv
IC0xIHNpbmNlIHRoZSBjb21wYXJpc29uCmlzIGFsd2F5cyBmYWxzZS4KClRoaXMgY2FuIGJl
IHF1aWNrbHkgcmVwcm9kdWNlZCBieSBzZXR0aW5nIENPTkZJR19XRVJST1I9eSBhbmQgcnVu
bmluZzoKCgltYWtlIFc9MSBDQz1jbGFuZy0xNCBuZXQvaXB2NC90Y3Bfb3V0cHV0Lm8KCm5l
dC9pcHY0L3RjcF9vdXRwdXQuYzoxODc6MzogZXJyb3I6IHJlc3VsdCBvZiBjb21wYXJpc29u
IG9mIGNvbnN0YW50IC0xIHdpdGggZXhwcmVzc2lvbiBvZiB0eXBlICd1OCcgKGFrYSAndW5z
aWduZWQgY2hhcicpIGlzIGFsd2F5cyBmYWxzZSBbLVdlcnJvciwtV3RhdXRvbG9naWNhbC1j
b25zdGFudC1vdXQtb2YtcmFuZ2UtY29tcGFyZV0KICAxODcgfCAgICAgICAgICAgICAgICAg
TkVUX0FERF9TVEFUUyhzb2NrX25ldChzayksIExJTlVYX01JQl9UQ1BBQ0tDT01QUkVTU0VE
LAogICAgICB8ICAgICAgICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CiAgMTg4IHwgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgdHAtPmNvbXByZXNzZWRfYWNrKTsKICAgICAgfCAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB+fn5+fn5+fn5+fn5+fn5+fn5+Ci4uLgphcmNoL3g4Ni9pbmNs
dWRlL2FzbS9wZXJjcHUuaDoyMzg6MzE6IG5vdGU6IGV4cGFuZGVkIGZyb20gbWFjcm8gJ3Bl
cmNwdV9hZGRfb3AnCiAgMjM4IHwgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKCh2
YWwpID09IDEgfHwgKHZhbCkgPT0gLTEpKSA/ICAgICAgICAgICAgXAogICAgICB8ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH5+fn5+IF4gIH5+CgpG
aXggdGhpcyBieSBhdm9pZGluZyBhIGNvbXBhcmlzb24gb2YgYW4gdW5jYXN0IC0xIHRvICd2
YWwnLgoKRG9pbmcgdGhpcyBpbiBhZGRpdGlvbiB0byB0aGUgZXhpc3RpbmcgJ3Bhb19JRF9f
JyBjYWxjdWxhdGlvbiB3b3VsZCBtYWtlIGl0CmV2ZW4gbW9yZSB1bnJlYWRhYmxlLiBSZW1v
dmUgJ3Bhb19JRF9fJyBhbmQgcmVwbGFjZSBpdCB3aXRoIHRoZSB0aHJlZQpjb21wb25lbnRz
IG9mIGl0cyBjYWxjdWxhdGlvbi4KClRoaXMgcHJlc2VydmVzIHNvbWUgdW5pbnR1aXRpdmUg
YnV0IHVzZWZ1bCBiZWhhdmlvci4gIEZvciBpbnN0YW5jZSwgZ2NjIHNlZXM6CgoJcGVyY3B1
X2FkZF9vcCguLi4sIHZhciwgKHU4KS0xKTsKCmFuZCBjYW4gdHJhbnNmb3JtIHRoYXQgaW50
byBhICJkZWMiLiAgQ2xhbmcsIG9uIHRoZSBvdGhlciBoYW5kLCBzZWVzIHRoZSAndTgnCnR5
cGUgYW5kIGFzc3VtZXMgdGhhdCAiKHZhbCkgPT0gLTEiIGlzIGZhbHNlLCB3aGljaCB3YXMg
dGhlIHJvb3Qgb2YgdGhlCndhcm5pbmcuCgpUaGlzIGlzIHVzZWZ1bCBnY2MgYmVoYXZpb3Ig
YmVjYXVzZToKCgkjZGVmaW5lIHRoaXNfY3B1X3N1YihwY3AsIHZhbCkgIHRoaXNfY3B1X2Fk
ZChwY3AsIC0odHlwZW9mKHBjcCkpKHZhbCkpCgpzbyBhbnkgY29kZSB0aGF0IGRvZXM6CgoJ
dGhpc19jcHVfc3ViKEEsIDEpCgp3aGVyZSAnQScgaXMgYW4gdW5zaWduZWQgdHlwZSBnZW5l
cmF0ZXMgYSAiZGVjIi4gIENsYW5nLCBvbiB0aGUgb3RoZXIKaGFuZCBnZW5lcmF0ZXMgYSBs
ZXNzLWVmZmljaWVudCAiYWRkIi4KClJlcG9ydGVkLWJ5OiBBbmR5IFNoZXZjaGVua28gPGFu
ZHJpeS5zaGV2Y2hlbmtvQGxpbnV4LmludGVsLmNvbT4KU2lnbmVkLW9mZi1ieTogRGF2ZSBI
YW5zZW4gPGRhdmUuaGFuc2VuQGxpbnV4LmludGVsLmNvbT4KLS0tCiBhcmNoL3g4Ni9pbmNs
dWRlL2FzbS9wZXJjcHUuaCB8IDExICsrKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNiBp
bnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL3BlcmNwdS5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vcGVyY3B1LmgKaW5k
ZXggYzU1YTc5ZDVmZWFlLi41N2Q5NzU5YzY5MmUgMTAwNjQ0Ci0tLSBhL2FyY2gveDg2L2lu
Y2x1ZGUvYXNtL3BlcmNwdS5oCisrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3BlcmNwdS5o
CkBAIC0yMzQsMTggKzIzNCwxOSBAQCBkbyB7CQkJCQkJCQkJXAogICovCiAjZGVmaW5lIHBl
cmNwdV9hZGRfb3Aoc2l6ZSwgcXVhbCwgdmFyLCB2YWwpCQkJCVwKIGRvIHsJCQkJCQkJCQlc
Ci0JY29uc3QgaW50IHBhb19JRF9fID0gKF9fYnVpbHRpbl9jb25zdGFudF9wKHZhbCkgJiYJ
CVwKLQkJCSAgICAgICgodmFsKSA9PSAxIHx8ICh2YWwpID09IC0xKSkgPwkJXAotCQkJCShp
bnQpKHZhbCkgOiAwOwkJCQlcCisJY29uc3QgaW50IHBhb19jb25zdF9fID0gX19idWlsdGlu
X2NvbnN0YW50X3AodmFsKTsJCVwKKwljb25zdCBpbnQgcGFvX2luY19fICAgPSAodmFsKSA9
PSAxOwkJCQlcCisJY29uc3QgaW50IHBhb19kZWNfXyAgID0gKHR5cGVvZih2YXIpKSh2YWwp
ID09CQkJXAorCQkJCSh0eXBlb2YodmFyKSktMTsJCQlcCiAJCQkJCQkJCQlcCiAJaWYgKDAp
IHsJCQkJCQkJXAogCQl0eXBlb2YodmFyKSBwYW9fdG1wX187CQkJCQlcCiAJCXBhb190bXBf
XyA9ICh2YWwpOwkJCQkJXAogCQkodm9pZClwYW9fdG1wX187CQkJCQlcCiAJfQkJCQkJCQkJ
XAotCWlmIChwYW9fSURfXyA9PSAxKQkJCQkJCVwKKwlpZiAocGFvX2NvbnN0X18gJiYgcGFv
X2luY19fKQkJCQkJXAogCQlwZXJjcHVfdW5hcnlfb3Aoc2l6ZSwgcXVhbCwgImluYyIsIHZh
cik7CQlcCi0JZWxzZSBpZiAocGFvX0lEX18gPT0gLTEpCQkJCQlcCisJZWxzZSBpZiAocGFv
X2NvbnN0X18gJiYgcGFvX2RlY19fKQkJCQlcCiAJCXBlcmNwdV91bmFyeV9vcChzaXplLCBx
dWFsLCAiZGVjIiwgdmFyKTsJCVwKIAllbHNlCQkJCQkJCQlcCiAJCXBlcmNwdV9iaW5hcnlf
b3Aoc2l6ZSwgcXVhbCwgImFkZCIsIHZhciwgdmFsKTsJCVwKLS0gCjIuMzQuMQoK

--------------j7icfEkLOSMelbrpKGR8X0pv--

