Return-Path: <linux-kernel+bounces-542649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1071A4CBEE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 20:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0114E172B31
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Mar 2025 19:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BDBE22CBED;
	Mon,  3 Mar 2025 19:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RdeT9Gdz"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8697D1F8733
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 19:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741029824; cv=none; b=QFq36DzZ40fytMBpAe7DIsxP0fmJABLksvc4s+ejtoI/E85GyG5hG4jhwGoctngsSid7FMvkj69gnTf3zmSvtUBMlcjtDOxm3spkCVUSBNX5Mq3eK4uVuEkLD1OBfjYkZf9Wf3qFwKIDygTTDDfzLG0s/AHRPdUqiCe7RH88vVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741029824; c=relaxed/simple;
	bh=+3ETVaP7Ziw9MiCfawdA12hn1tLMPFQWi6T27otKOVA=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=SPXrX9iXreXGuzNmdjwwrZ3nwoXhblg9nlSdFyFTKt2RlrEQEKre3w7WApQLB1dOsJz++nOEqpyDTsJhdSwsyNFRXKFOFopuw0j0qLKg3JjZKJDVPWZj2DjpQxv8AfYelO3tj0TivMHpg3gdlL9Rq5zLF0hwnqtNNDts7i/dPUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RdeT9Gdz; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741029822; x=1772565822;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=+3ETVaP7Ziw9MiCfawdA12hn1tLMPFQWi6T27otKOVA=;
  b=RdeT9Gdz4njyJDtyA/3HUsmsTGxilyqcEW38Zt10cqxcxLelCZQwfU98
   29No02oVcEkk86kh+VrZ53B0tFWGxMQGMih2EXLLZn1cRpk3KqJaymtuR
   dqj+SdWJvaWGpnjPSk8GsYJqy29WXt/OS7xDIAXzmxJ49+Hy438mbznDS
   b2inAErqoVVLHh10AmLePb98BaTXaHpW2SsWTTkDYZc1COxXZp26zBDsf
   9MjYjgAhVRaaB2ASOpvDX/nnPj5cpTH9sJeQ0Xp23rFMgQcflY0+IF+/W
   SVaUFK96vjLJXCQ8bgvTPQupoe5VQUqwIZIn/wRPxlaDSq+dWTekEgH8p
   w==;
X-CSE-ConnectionGUID: 5iooL0oDR/uP02GaClSbrg==
X-CSE-MsgGUID: pvbSff2yTdaYqnSSeMxR8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="44732483"
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="44732483"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 11:23:41 -0800
X-CSE-ConnectionGUID: 12rFD35PSQyfFXeMIaVjsQ==
X-CSE-MsgGUID: TKPES/jkTCahfY4xAestHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,330,1732608000"; 
   d="scan'208";a="117927532"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.109.13]) ([10.125.109.13])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 11:23:41 -0800
Content-Type: multipart/mixed; boundary="------------PITrAFPU5JooYva0CxdEV0cg"
Message-ID: <34b80474-a309-493b-81e9-3a7d4de8a369@intel.com>
Date: Mon, 3 Mar 2025 11:23:58 -0800
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
 <30c721e0-338d-4172-989c-5226d584bcbc@intel.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <30c721e0-338d-4172-989c-5226d584bcbc@intel.com>

This is a multi-part message in MIME format.
--------------PITrAFPU5JooYva0CxdEV0cg
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Here's a plain diff if you just want to squish it in.
--------------PITrAFPU5JooYva0CxdEV0cg
Content-Type: text/x-patch; charset=UTF-8; name="supportcode1.patch"
Content-Disposition: attachment; filename="supportcode1.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2luY2x1ZGUvYXNtL3RsYi5oIGIvYXJjaC94ODYvaW5j
bHVkZS9hc20vdGxiLmgKaW5kZXggNTM3NTE0NWViOTU5Ni4uM2JkNjE3YzIwNDM0NiAxMDA2
NDQKLS0tIGEvYXJjaC94ODYvaW5jbHVkZS9hc20vdGxiLmgKKysrIGIvYXJjaC94ODYvaW5j
bHVkZS9hc20vdGxiLmgKQEAgLTI4LDYgKzI4LDExIEBAIHN0YXRpYyBpbmxpbmUgdm9pZCBp
bnZscGcodW5zaWduZWQgbG9uZyBhZGRyKQogCWFzbSB2b2xhdGlsZSgiaW52bHBnICglMCki
IDo6InIiIChhZGRyKSA6ICJtZW1vcnkiKTsKIH0KIAorZW51bSBpbnZscGdiX3N0cmlkZSB7
CisJTk9fU1RSSURFICA9IDAsCisJUFRFX1NUUklERSA9IDAsCisJUE1EX1NUUklERSA9IDEK
K307CiAKIC8qCiAgKiBJTlZMUEdCIGRvZXMgYnJvYWRjYXN0IFRMQiBpbnZhbGlkYXRpb24g
YWNyb3NzIGFsbCB0aGUgQ1BVcyBpbiB0aGUgc3lzdGVtLgpAQCAtNDgsMTAgKzUzLDEwIEBA
IHN0YXRpYyBpbmxpbmUgdm9pZCBpbnZscGcodW5zaWduZWQgbG9uZyBhZGRyKQogICovCiBz
dGF0aWMgaW5saW5lIHZvaWQgX19pbnZscGdiKHVuc2lnbmVkIGxvbmcgYXNpZCwgdW5zaWdu
ZWQgbG9uZyBwY2lkLAogCQkJICAgICB1bnNpZ25lZCBsb25nIGFkZHIsIHUxNiBucl9wYWdl
cywKLQkJCSAgICAgYm9vbCBwbWRfc3RyaWRlLCB1OCBmbGFncykKKwkJCSAgICAgZW51bSBp
bnZscGdiX3N0cmlkZSBzdHJpZGUsIHU4IGZsYWdzKQogewogCXUzMiBlZHggPSAocGNpZCA8
PCAxNikgfCBhc2lkOwotCXUzMiBlY3ggPSAocG1kX3N0cmlkZSA8PCAzMSkgfCAobnJfcGFn
ZXMgLSAxKTsKKwl1MzIgZWN4ID0gKHN0cmlkZSA8PCAzMSkgfCAobnJfcGFnZXMgLSAxKTsK
IAl1NjQgcmF4ID0gYWRkciB8IGZsYWdzOwogCiAJLyogVGhlIGxvdyBiaXRzIGluIHJheCBh
cmUgZm9yIGZsYWdzLiBWZXJpZnkgYWRkciBpcyBjbGVhbi4gKi8KQEAgLTc4LDMzICs4Mywz
NyBAQCBzdGF0aWMgaW5saW5lIHZvaWQgX190bGJzeW5jKHZvaWQpCiAvKgogICogSU5WTFBH
QiBjYW4gYmUgdGFyZ2V0ZWQgYnkgdmlydHVhbCBhZGRyZXNzLCBQQ0lELCBBU0lELCBvciBh
bnkgY29tYmluYXRpb24KICAqIG9mIHRoZSB0aHJlZS4gRm9yIGV4YW1wbGU6Ci0gKiAtIElO
VkxQR0JfVkEgfCBJTlZMUEdCX0lOQ0xVREVfR0xPQkFMOiBpbnZhbGlkYXRlIGFsbCBUTEIg
ZW50cmllcyBhdCB0aGUgYWRkcmVzcwotICogLSBJTlZMUEdCX1BDSUQ6CQkJICBpbnZhbGlk
YXRlIGFsbCBUTEIgZW50cmllcyBtYXRjaGluZyB0aGUgUENJRAorICogLSBGTEFHX1ZBIHwg
RkxBR19JTkNMVURFX0dMT0JBTDogaW52YWxpZGF0ZSBhbGwgVExCIGVudHJpZXMgYXQgdGhl
IGFkZHJlc3MKKyAqIC0gRkxBR19QQ0lEOgkJCSAgICBpbnZhbGlkYXRlIGFsbCBUTEIgZW50
cmllcyBtYXRjaGluZyB0aGUgUENJRAogICoKLSAqIFRoZSBmaXJzdCBjYW4gYmUgdXNlZCB0
byBpbnZhbGlkYXRlIChrZXJuZWwpIG1hcHBpbmdzIGF0IGEgcGFydGljdWxhcgorICogVGhl
IGZpcnN0IGlzIHVzZWQgdG8gaW52YWxpZGF0ZSAoa2VybmVsKSBtYXBwaW5ncyBhdCBhIHBh
cnRpY3VsYXIKICAqIGFkZHJlc3MgYWNyb3NzIGFsbCBwcm9jZXNzZXMuCiAgKgogICogVGhl
IGxhdHRlciBpbnZhbGlkYXRlcyBhbGwgVExCIGVudHJpZXMgbWF0Y2hpbmcgYSBQQ0lELgog
ICovCi0jZGVmaW5lIElOVkxQR0JfVkEJCQlCSVQoMCkKLSNkZWZpbmUgSU5WTFBHQl9QQ0lE
CQkJQklUKDEpCi0jZGVmaW5lIElOVkxQR0JfQVNJRAkJCUJJVCgyKQotI2RlZmluZSBJTlZM
UEdCX0lOQ0xVREVfR0xPQkFMCQlCSVQoMykKLSNkZWZpbmUgSU5WTFBHQl9GSU5BTF9PTkxZ
CQlCSVQoNCkKLSNkZWZpbmUgSU5WTFBHQl9JTkNMVURFX05FU1RFRAkJQklUKDUpCisjZGVm
aW5lIElOVkxQR0JfRkxBR19WQQkJCUJJVCgwKQorI2RlZmluZSBJTlZMUEdCX0ZMQUdfUENJ
RAkJQklUKDEpCisjZGVmaW5lIElOVkxQR0JfRkxBR19BU0lECQlCSVQoMikKKyNkZWZpbmUg
SU5WTFBHQl9GTEFHX0lOQ0xVREVfR0xPQkFMCUJJVCgzKQorI2RlZmluZSBJTlZMUEdCX0ZM
QUdfRklOQUxfT05MWQkJQklUKDQpCisjZGVmaW5lIElOVkxQR0JfRkxBR19JTkNMVURFX05F
U1RFRAlCSVQoNSkKKworLyogVGhlIGltcGxpZWQgbW9kZSB3aGVuIGFsbCBiaXRzIGFyZSBj
bGVhcjogKi8KKyNkZWZpbmUgSU5WTFBHQl9NT0RFX0FMTF9OT05HTE9CQUxTCTBVTAogCiBz
dGF0aWMgaW5saW5lIHZvaWQgaW52bHBnYl9mbHVzaF91c2VyX25yX25vc3luYyh1bnNpZ25l
ZCBsb25nIHBjaWQsCiAJCQkJCQl1bnNpZ25lZCBsb25nIGFkZHIsCiAJCQkJCQl1MTYgbnIs
CiAJCQkJCQlib29sIHBtZF9zdHJpZGUpCiB7Ci0JX19pbnZscGdiKDAsIHBjaWQsIGFkZHIs
IG5yLCBwbWRfc3RyaWRlLCBJTlZMUEdCX1BDSUQgfCBJTlZMUEdCX1ZBKTsKKwlfX2ludmxw
Z2IoMCwgcGNpZCwgYWRkciwgbnIsIHBtZF9zdHJpZGUsIElOVkxQR0JfRkxBR19QQ0lEIHwK
KwkJICAJCQkJIElOVkxQR0JfRkxBR19WQSk7CiB9CiAKIC8qIEZsdXNoIGFsbCBtYXBwaW5n
cyBmb3IgYSBnaXZlbiBQQ0lELCBub3QgaW5jbHVkaW5nIGdsb2JhbHMuICovCiBzdGF0aWMg
aW5saW5lIHZvaWQgaW52bHBnYl9mbHVzaF9zaW5nbGVfcGNpZF9ub3N5bmModW5zaWduZWQg
bG9uZyBwY2lkKQogewotCV9faW52bHBnYigwLCBwY2lkLCAwLCAxLCAwLCBJTlZMUEdCX1BD
SUQpOworCV9faW52bHBnYigwLCBwY2lkLCAwLCAxLCBOT19TVFJJREUsIElOVkxQR0JfRkxB
R19QQ0lEKTsKIH0KIAogLyogRmx1c2ggYWxsIG1hcHBpbmdzLCBpbmNsdWRpbmcgZ2xvYmFs
cywgZm9yIGFsbCBQQ0lEcy4gKi8KQEAgLTExNywyMSArMTI2LDIxIEBAIHN0YXRpYyBpbmxp
bmUgdm9pZCBpbnZscGdiX2ZsdXNoX2FsbCh2b2lkKQogCSAqIGFzIGl0IGlzIGNoZWFwZXIu
CiAJICovCiAJZ3VhcmQocHJlZW1wdCkoKTsKLQlfX2ludmxwZ2IoMCwgMCwgMCwgMSwgMCwg
SU5WTFBHQl9JTkNMVURFX0dMT0JBTCk7CisJX19pbnZscGdiKDAsIDAsIDAsIDEsIE5PX1NU
UklERSwgSU5WTFBHQl9GTEFHX0lOQ0xVREVfR0xPQkFMKTsKIAlfX3RsYnN5bmMoKTsKIH0K
IAogLyogRmx1c2ggYWRkciwgaW5jbHVkaW5nIGdsb2JhbHMsIGZvciBhbGwgUENJRHMuICov
CiBzdGF0aWMgaW5saW5lIHZvaWQgaW52bHBnYl9mbHVzaF9hZGRyX25vc3luYyh1bnNpZ25l
ZCBsb25nIGFkZHIsIHUxNiBucikKIHsKLQlfX2ludmxwZ2IoMCwgMCwgYWRkciwgbnIsIDAs
IElOVkxQR0JfSU5DTFVERV9HTE9CQUwpOworCV9faW52bHBnYigwLCAwLCBhZGRyLCBuciwg
UFRFX1NUUklERSwgSU5WTFBHQl9GTEFHX0lOQ0xVREVfR0xPQkFMKTsKIH0KIAogLyogRmx1
c2ggYWxsIG1hcHBpbmdzIGZvciBhbGwgUENJRHMgZXhjZXB0IGdsb2JhbHMuICovCiBzdGF0
aWMgaW5saW5lIHZvaWQgaW52bHBnYl9mbHVzaF9hbGxfbm9uZ2xvYmFscyh2b2lkKQogewog
CWd1YXJkKHByZWVtcHQpKCk7Ci0JX19pbnZscGdiKDAsIDAsIDAsIDEsIDAsIDApOworCV9f
aW52bHBnYigwLCAwLCAwLCAxLCBOT19TVFJJREUsIElOVkxQR0JfTU9ERV9BTExfTk9OR0xP
QkFMUyk7CiAJX190bGJzeW5jKCk7CiB9CiAjZW5kaWYgLyogX0FTTV9YODZfVExCX0ggKi8K


--------------PITrAFPU5JooYva0CxdEV0cg--

