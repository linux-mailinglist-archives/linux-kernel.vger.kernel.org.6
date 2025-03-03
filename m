Return-Path: <linux-kernel+bounces-542562-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B93A4CB1F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5A4D3AC0F1
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 18:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3DF216E39;
	Mon,  3 Mar 2025 18:41:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LtWzZOVr"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ADF20F09D
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 18:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741027293; cv=none; b=LRj9i8Q6IBN7SbtXmBu/uFKxOQFI9LqbogJWXYGs6/4Km0O6j2Vak7fjXhDy+Ia0kKuTt4ISuCoTgVkzCdgMlTe1vCuXabIFbeGfZ5g0NIz5GghI5ftm3d3x0OjJF/YFuC+fb4AvxK0vb7zCblL7ziIdDjQDcBfzF4kdw8cEMyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741027293; c=relaxed/simple;
	bh=DfezaikIbpffUCQ8toUww0i1aCv5MEBhXcVU/Ph9PuU=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=eihXJ7t8zDMowBZ+Uh4gBOIr7lHJRhB9ZiZ8fcgfkZnhRlpRNbMdkQMOds0tfJkRIf+eQxnr1ub4wi4Wl/6pXsmfArsNTCPqyVy50eisOVsV2P7rENS55OunghWgemz819rE4YRXtz1OFiNPfmaLewu4mg87zI3Ir5emdllVKJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LtWzZOVr; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741027290; x=1772563290;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=DfezaikIbpffUCQ8toUww0i1aCv5MEBhXcVU/Ph9PuU=;
  b=LtWzZOVrZOtjR6AgDvGQRozvO6EVj0T3l53pLbuk773IgLZYy8ppc3q4
   4Oit/9pXOj//fV3fyOJZdxhELzq16juFvof02kjE7ZH7YSbfMLiZ2mREM
   so2kvGSwv4bt8vb4eqG1HTbbvYN3h2wO6RNL2A6vlbBt5E/o16Ehx/8Fk
   mm+C5ZYBUY+3DxGK1A+itMGY1nyuVs4BoRbqQuminy3OjyWX6XaqyeV2c
   RgqUOrBO7+tP/B+dpP9InmX03axpuBZlbqiAo1WVy/myUQ+6dXC8JaIeN
   U/g8dfnf/rQ0SyoGvGvX3KetmsrlYsKcov+rJL9GPfl3Xe/I2E/GdRjFi
   Q==;
X-CSE-ConnectionGUID: UOrRB7EgRxWF7/UTbb+11w==
X-CSE-MsgGUID: EXJIFnryQIum7XZgYQaCOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="45568610"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="45568610"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 10:41:29 -0800
X-CSE-ConnectionGUID: G49fbFoBSMS+DXxwoTmwfA==
X-CSE-MsgGUID: 3zitSSg0QuOhW4I9KyQWVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="117916427"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.109.13]) ([10.125.109.13])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 10:41:27 -0800
Content-Type: multipart/mixed; boundary="------------uN8jXvp4vvy0mjcYW4E3DSkl"
Message-ID: <30c721e0-338d-4172-989c-5226d584bcbc@intel.com>
Date: Mon, 3 Mar 2025 10:41:44 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 03/13] x86/mm: add INVLPGB support code
To: Borislav Petkov <bp@alien8.de>, Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, peterz@infradead.org,
 dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com,
 nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com,
 linux-mm@kvack.org, akpm@linux-foundation.org, jackmanb@google.com,
 jannh@google.com, mhklinux@outlook.com, andrew.cooper3@citrix.com,
 Manali.Shukla@amd.com, mingo@kernel.org
References: <20250226030129.530345-1-riel@surriel.com>
 <20250226030129.530345-4-riel@surriel.com>
 <20250228194734.GGZ8IS1iFVpPzmEyYl@fat_crate.local>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20250228194734.GGZ8IS1iFVpPzmEyYl@fat_crate.local>

This is a multi-part message in MIME format.
--------------uN8jXvp4vvy0mjcYW4E3DSkl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/28/25 11:47, Borislav Petkov wrote:
> @@ -157,11 +140,14 @@ index 77f52bc1578a..91c9a4da3ace 100644
>  +/* Flush all mappings for all PCIDs except globals. */
>  +static inline void invlpgb_flush_all_nonglobals(void)
>  +{
> ++	/*
> ++	 * @addr=0 means both rax[1] (valid PCID) and rax[2] (valid ASID) are clear
> ++	 * so flush *any* PCID and ASID.
> ++	 */
>  +	__invlpgb(0, 0, 0, 1, 0, 0);
>  +	__tlbsync();
>  +}

I had a bit of an allergic reaction to all of the magic numbers.

Could we do something like the attached where we give a _few_ of the
magic numbers some symbolic names?

For instance, instead of passing around a bool for pmd_stride, this uses
an enum. It also explicitly separates things that are setting
pmd_stride=0 but are really saying "this is a 4k stride" from things
that set pmd_stride=0 but are for operations that don't _have_ a stride.
--------------uN8jXvp4vvy0mjcYW4E3DSkl
Content-Type: text/x-patch; charset=UTF-8; name="supportcode.patch"
Content-Disposition: attachment; filename="supportcode.patch"
Content-Transfer-Encoding: base64

LS0tIGM4MzQ0OTY4MDE3MDE3MGY1NWEwYWIyZWI0OThiOTJjZTk3YzA2MjQucGF0Y2gJMjAy
NS0wMy0wMyAxMDozNTo0Ny40MjIyNzczMzUgLTA4MDAKKysrIDExY2U0YjIyNjQzYmUucGF0
Y2gJMjAyNS0wMy0wMyAxMDozODowNS42OTI1MDk5OTMgLTA4MDAKQEAgLTEsOCArMSw4IEBA
Ci1jb21taXQgYzgzNDQ5NjgwMTcwMTcwZjU1YTBhYjJlYjQ5OGI5MmNlOTdjMDYyNAorY29t
bWl0IDExY2U0YjIyNjQzYmU1NGIyYzcwY2Y2YjQ3NDNlNmI3M2I0NjE4MTQKIEF1dGhvcjog
UmlrIHZhbiBSaWVsIDxyaWVsQHN1cnJpZWwuY29tPgogRGF0ZTogICBGcmkgRmViIDI4IDIw
OjMyOjMwIDIwMjUgKzAxMDAKIAotICAgICB4ODYvbW06IEFkZCBJTlZMUEdCIHN1cHBvcnQg
Y29kZQorICAgIHg4Ni9tbTogQWRkIElOVkxQR0Igc3VwcG9ydCBjb2RlCiAgICAgCiAgICAg
QWRkIGhlbHBlciBmdW5jdGlvbnMgYW5kIGRlZmluaXRpb25zIG5lZWRlZCB0byB1c2UgYnJv
YWRjYXN0IFRMQgogICAgIGludmFsaWRhdGlvbiBvbiBBTUQgQ1BVcy4KQEAgLTE3LDcgKzE3
LDcgQEAKICAgICBMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9yLzIwMjUwMjI2MDMw
MTI5LjUzMDM0NS00LXJpZWxAc3VycmllbC5jb20KIAogZGlmZiAtLWdpdCBhL2FyY2gveDg2
L2luY2x1ZGUvYXNtL3RsYi5oIGIvYXJjaC94ODYvaW5jbHVkZS9hc20vdGxiLmgKLWluZGV4
IDc3ZjUyYmMxNTc4YTcuLjUzNzUxNDVlYjk1OTYgMTAwNjQ0CitpbmRleCA3N2Y1MmJjMTU3
OGE3Li4zYmQ2MTdjMjA0MzQ2IDEwMDY0NAogLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20v
dGxiLmgKICsrKyBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RsYi5oCiBAQCAtNiw2ICs2LDkg
QEAKQEAgLTMwLDEwICszMCwxNSBAQAogIAogIHN0YXRpYyBpbmxpbmUgdm9pZCB0bGJfZmx1
c2goc3RydWN0IG1tdV9nYXRoZXIgKnRsYikKICB7Ci1AQCAtMjUsNCArMjgsMTEwIEBAIHN0
YXRpYyBpbmxpbmUgdm9pZCBpbnZscGcodW5zaWduZWQgbG9uZyBhZGRyKQorQEAgLTI1LDQg
KzI4LDExOSBAQCBzdGF0aWMgaW5saW5lIHZvaWQgaW52bHBnKHVuc2lnbmVkIGxvbmcgYWRk
cikKICAJYXNtIHZvbGF0aWxlKCJpbnZscGcgKCUwKSIgOjoiciIgKGFkZHIpIDogIm1lbW9y
eSIpOwogIH0KICAKKytlbnVtIGludmxwZ2Jfc3RyaWRlIHsKKysJTk9fU1RSSURFICA9IDAs
CisrCVBURV9TVFJJREUgPSAwLAorKwlQTURfU1RSSURFID0gMQorK307CiArCiArLyoKICsg
KiBJTlZMUEdCIGRvZXMgYnJvYWRjYXN0IFRMQiBpbnZhbGlkYXRpb24gYWNyb3NzIGFsbCB0
aGUgQ1BVcyBpbiB0aGUgc3lzdGVtLgpAQCAtNTQsMTAgKzU5LDEwIEBACiArICovCiArc3Rh
dGljIGlubGluZSB2b2lkIF9faW52bHBnYih1bnNpZ25lZCBsb25nIGFzaWQsIHVuc2lnbmVk
IGxvbmcgcGNpZCwKICsJCQkgICAgIHVuc2lnbmVkIGxvbmcgYWRkciwgdTE2IG5yX3BhZ2Vz
LAotKwkJCSAgICAgYm9vbCBwbWRfc3RyaWRlLCB1OCBmbGFncykKKysJCQkgICAgIGVudW0g
aW52bHBnYl9zdHJpZGUgc3RyaWRlLCB1OCBmbGFncykKICt7CiArCXUzMiBlZHggPSAocGNp
ZCA8PCAxNikgfCBhc2lkOwotKwl1MzIgZWN4ID0gKHBtZF9zdHJpZGUgPDwgMzEpIHwgKG5y
X3BhZ2VzIC0gMSk7CisrCXUzMiBlY3ggPSAoc3RyaWRlIDw8IDMxKSB8IChucl9wYWdlcyAt
IDEpOwogKwl1NjQgcmF4ID0gYWRkciB8IGZsYWdzOwogKwogKwkvKiBUaGUgbG93IGJpdHMg
aW4gcmF4IGFyZSBmb3IgZmxhZ3MuIFZlcmlmeSBhZGRyIGlzIGNsZWFuLiAqLwpAQCAtODQs
MzMgKzg5LDM3IEBACiArLyoKICsgKiBJTlZMUEdCIGNhbiBiZSB0YXJnZXRlZCBieSB2aXJ0
dWFsIGFkZHJlc3MsIFBDSUQsIEFTSUQsIG9yIGFueSBjb21iaW5hdGlvbgogKyAqIG9mIHRo
ZSB0aHJlZS4gRm9yIGV4YW1wbGU6Ci0rICogLSBJTlZMUEdCX1ZBIHwgSU5WTFBHQl9JTkNM
VURFX0dMT0JBTDogaW52YWxpZGF0ZSBhbGwgVExCIGVudHJpZXMgYXQgdGhlIGFkZHJlc3MK
LSsgKiAtIElOVkxQR0JfUENJRDoJCQkgIGludmFsaWRhdGUgYWxsIFRMQiBlbnRyaWVzIG1h
dGNoaW5nIHRoZSBQQ0lECisrICogLSBGTEFHX1ZBIHwgRkxBR19JTkNMVURFX0dMT0JBTDog
aW52YWxpZGF0ZSBhbGwgVExCIGVudHJpZXMgYXQgdGhlIGFkZHJlc3MKKysgKiAtIEZMQUdf
UENJRDoJCQkgICAgaW52YWxpZGF0ZSBhbGwgVExCIGVudHJpZXMgbWF0Y2hpbmcgdGhlIFBD
SUQKICsgKgotKyAqIFRoZSBmaXJzdCBjYW4gYmUgdXNlZCB0byBpbnZhbGlkYXRlIChrZXJu
ZWwpIG1hcHBpbmdzIGF0IGEgcGFydGljdWxhcgorKyAqIFRoZSBmaXJzdCBpcyB1c2VkIHRv
IGludmFsaWRhdGUgKGtlcm5lbCkgbWFwcGluZ3MgYXQgYSBwYXJ0aWN1bGFyCiArICogYWRk
cmVzcyBhY3Jvc3MgYWxsIHByb2Nlc3Nlcy4KICsgKgogKyAqIFRoZSBsYXR0ZXIgaW52YWxp
ZGF0ZXMgYWxsIFRMQiBlbnRyaWVzIG1hdGNoaW5nIGEgUENJRC4KICsgKi8KLSsjZGVmaW5l
IElOVkxQR0JfVkEJCQlCSVQoMCkKLSsjZGVmaW5lIElOVkxQR0JfUENJRAkJCUJJVCgxKQot
KyNkZWZpbmUgSU5WTFBHQl9BU0lECQkJQklUKDIpCi0rI2RlZmluZSBJTlZMUEdCX0lOQ0xV
REVfR0xPQkFMCQlCSVQoMykKLSsjZGVmaW5lIElOVkxQR0JfRklOQUxfT05MWQkJQklUKDQp
Ci0rI2RlZmluZSBJTlZMUEdCX0lOQ0xVREVfTkVTVEVECQlCSVQoNSkKKysjZGVmaW5lIElO
VkxQR0JfRkxBR19WQQkJCUJJVCgwKQorKyNkZWZpbmUgSU5WTFBHQl9GTEFHX1BDSUQJCUJJ
VCgxKQorKyNkZWZpbmUgSU5WTFBHQl9GTEFHX0FTSUQJCUJJVCgyKQorKyNkZWZpbmUgSU5W
TFBHQl9GTEFHX0lOQ0xVREVfR0xPQkFMCUJJVCgzKQorKyNkZWZpbmUgSU5WTFBHQl9GTEFH
X0ZJTkFMX09OTFkJCUJJVCg0KQorKyNkZWZpbmUgSU5WTFBHQl9GTEFHX0lOQ0xVREVfTkVT
VEVECUJJVCg1KQorKworKy8qIFRoZSBpbXBsaWVkIG1vZGUgd2hlbiBhbGwgYml0cyBhcmUg
Y2xlYXI6ICovCisrI2RlZmluZSBJTlZMUEdCX01PREVfQUxMX05PTkdMT0JBTFMJMFVMCiAr
CiArc3RhdGljIGlubGluZSB2b2lkIGludmxwZ2JfZmx1c2hfdXNlcl9ucl9ub3N5bmModW5z
aWduZWQgbG9uZyBwY2lkLAogKwkJCQkJCXVuc2lnbmVkIGxvbmcgYWRkciwKICsJCQkJCQl1
MTYgbnIsCiArCQkJCQkJYm9vbCBwbWRfc3RyaWRlKQogK3sKLSsJX19pbnZscGdiKDAsIHBj
aWQsIGFkZHIsIG5yLCBwbWRfc3RyaWRlLCBJTlZMUEdCX1BDSUQgfCBJTlZMUEdCX1ZBKTsK
KysJX19pbnZscGdiKDAsIHBjaWQsIGFkZHIsIG5yLCBwbWRfc3RyaWRlLCBJTlZMUEdCX0ZM
QUdfUENJRCB8CisrCQkgIAkJCQkgSU5WTFBHQl9GTEFHX1ZBKTsKICt9CiArCiArLyogRmx1
c2ggYWxsIG1hcHBpbmdzIGZvciBhIGdpdmVuIFBDSUQsIG5vdCBpbmNsdWRpbmcgZ2xvYmFs
cy4gKi8KICtzdGF0aWMgaW5saW5lIHZvaWQgaW52bHBnYl9mbHVzaF9zaW5nbGVfcGNpZF9u
b3N5bmModW5zaWduZWQgbG9uZyBwY2lkKQogK3sKLSsJX19pbnZscGdiKDAsIHBjaWQsIDAs
IDEsIDAsIElOVkxQR0JfUENJRCk7CisrCV9faW52bHBnYigwLCBwY2lkLCAwLCAxLCBOT19T
VFJJREUsIElOVkxQR0JfRkxBR19QQ0lEKTsKICt9CiArCiArLyogRmx1c2ggYWxsIG1hcHBp
bmdzLCBpbmNsdWRpbmcgZ2xvYmFscywgZm9yIGFsbCBQQ0lEcy4gKi8KQEAgLTEyMywyMSAr
MTMyLDIxIEBACiArCSAqIGFzIGl0IGlzIGNoZWFwZXIuCiArCSAqLwogKwlndWFyZChwcmVl
bXB0KSgpOwotKwlfX2ludmxwZ2IoMCwgMCwgMCwgMSwgMCwgSU5WTFBHQl9JTkNMVURFX0dM
T0JBTCk7CisrCV9faW52bHBnYigwLCAwLCAwLCAxLCBOT19TVFJJREUsIElOVkxQR0JfRkxB
R19JTkNMVURFX0dMT0JBTCk7CiArCV9fdGxic3luYygpOwogK30KICsKICsvKiBGbHVzaCBh
ZGRyLCBpbmNsdWRpbmcgZ2xvYmFscywgZm9yIGFsbCBQQ0lEcy4gKi8KICtzdGF0aWMgaW5s
aW5lIHZvaWQgaW52bHBnYl9mbHVzaF9hZGRyX25vc3luYyh1bnNpZ25lZCBsb25nIGFkZHIs
IHUxNiBucikKICt7Ci0rCV9faW52bHBnYigwLCAwLCBhZGRyLCBuciwgMCwgSU5WTFBHQl9J
TkNMVURFX0dMT0JBTCk7CisrCV9faW52bHBnYigwLCAwLCBhZGRyLCBuciwgUFRFX1NUUklE
RSwgSU5WTFBHQl9GTEFHX0lOQ0xVREVfR0xPQkFMKTsKICt9CiArCiArLyogRmx1c2ggYWxs
IG1hcHBpbmdzIGZvciBhbGwgUENJRHMgZXhjZXB0IGdsb2JhbHMuICovCiArc3RhdGljIGlu
bGluZSB2b2lkIGludmxwZ2JfZmx1c2hfYWxsX25vbmdsb2JhbHModm9pZCkKICt7CiArCWd1
YXJkKHByZWVtcHQpKCk7Ci0rCV9faW52bHBnYigwLCAwLCAwLCAxLCAwLCAwKTsKKysJX19p
bnZscGdiKDAsIDAsIDAsIDEsIE5PX1NUUklERSwgSU5WTFBHQl9NT0RFX0FMTF9OT05HTE9C
QUxTKTsKICsJX190bGJzeW5jKCk7CiArfQogICNlbmRpZiAvKiBfQVNNX1g4Nl9UTEJfSCAq
Lwo=

--------------uN8jXvp4vvy0mjcYW4E3DSkl--

