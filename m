Return-Path: <linux-kernel+bounces-443982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E6939EFE96
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 22:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A31E9286517
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Dec 2024 21:44:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87C91D8DFB;
	Thu, 12 Dec 2024 21:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CsbZyY2S"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133EA13BC26
	for <linux-kernel@vger.kernel.org>; Thu, 12 Dec 2024 21:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734039849; cv=none; b=ryxOReFDQosuMSKDmk19TA0X6GzuR/QlotavuwnYUk9ofd1FfP4YfRqImE5g2fkrmwIUe++/tt8fQVv8viIC6O8my5WXXrRgaef6OoMD8vVdKId9o8mmmtHpEDGntq8aVYGSW5oAGci0t35uLt4454S8iXu2YzSCBu0tUQpi+xE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734039849; c=relaxed/simple;
	bh=vSFJjdZ2iIZMJSO8NHcvIklSqwqjaGbzMW6eQNdzG0o=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=sgpjxxU6ne+P6EtFmTgj0SLb9OWE/k9Az4lZU12GgawRKdlFi04XTTRMv6598ccuNVSvWI46x2Ppa4OC02NOb8Tv5IeOXpt/ZCc2GLZ3cu64f2oG7xlEVQQrWxx6x184WLOjkoazS0Kxds5BMwwWJSNglafhx+nTGU5a3bMA2PQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CsbZyY2S; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1734039847; x=1765575847;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=vSFJjdZ2iIZMJSO8NHcvIklSqwqjaGbzMW6eQNdzG0o=;
  b=CsbZyY2Sg5lCnX9dQ5BjDV8lhblR99PeuLiSG4SMZuLmNTo1hZfaGtg7
   zG7ffe+QZvZbh3JyT74SI9Su4K0EvM2IeLvrZUaI+gmyVXV4+6Xz+GICo
   IiKpjr/zy9ro7wOvYoOqlhzOIza9c0BYn8HLQSeW2plfFU+W7/lh+uv/T
   VI5ZRwAEZr/3vf5pX3WY+MvJYj2sHrlejDS8RIswi3ed9ZI5fBd+Y+ov+
   BXCX0BF40IKpwg0o7Td+vPZIF1cR/TqRRtgZV5SkXWS5JVcpagnkIkdfD
   onGdS6ue9KkS47nRpxkO1gkzKl/6bVjhnkkksIk2SsMBmNVUal2VmxjRo
   g==;
X-CSE-ConnectionGUID: PTl0HH0ZRW+AKrxl1BZEHA==
X-CSE-MsgGUID: MU3baKdAT8yKXULyjA8BBg==
X-IronPort-AV: E=McAfee;i="6700,10204,11284"; a="34207925"
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208,223";a="34207925"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 13:44:06 -0800
X-CSE-ConnectionGUID: csrvbFPRTCiUYjAiSIkDcQ==
X-CSE-MsgGUID: 1zS4MC9GRiWTtD+FTKEVGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,229,1728975600"; 
   d="scan'208,223";a="96229053"
Received: from ccbilbre-mobl3.amr.corp.intel.com (HELO [10.124.223.26]) ([10.124.223.26])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Dec 2024 13:44:06 -0800
Content-Type: multipart/mixed; boundary="------------hPpt08yWuuWdpta0eh1zmCfu"
Message-ID: <a14ff894-9268-4a62-87bd-3b2553e0bc01@intel.com>
Date: Thu, 12 Dec 2024 13:43:57 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/kexec: Only write through identity mapping of control
 page
To: David Woodhouse <dwmw2@infradead.org>,
 Nathan Chancellor <nathan@kernel.org>
Cc: "Ning, Hongyu" <hongyu.ning@linux.intel.com>, kexec@lists.infradead.org,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 linux-kernel@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Dave Young <dyoung@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 jpoimboe@kernel.org, bsz@amazon.de
References: <20241205153343.3275139-1-dwmw2@infradead.org>
 <20241205153343.3275139-14-dwmw2@infradead.org>
 <20241212014418.GA532802@ax162>
 <10a4058d9a667ca7aef7e1862375c2da84ef53a3.camel@infradead.org>
 <20241212150408.GA542727@ax162>
 <38aaf87162d10c79b3d3ecae38df99e89ad16fce.camel@infradead.org>
 <20241212174243.GA2149156@ax162>
 <9c68688625f409104b16164da30aa6d3eb494e5d.camel@infradead.org>
 <4517cb69-3c5c-4e75-8a14-dab136b29c19@intel.com>
 <212CBB8E-CC94-4A56-8399-1419D8F2FA5C@infradead.org>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <212CBB8E-CC94-4A56-8399-1419D8F2FA5C@infradead.org>

This is a multi-part message in MIME format.
--------------hPpt08yWuuWdpta0eh1zmCfu
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/12/24 13:32, David Woodhouse wrote:
> On 12 December 2024 21:18:10 GMT, Dave Hansen <dave.hansen@intel.com> wrote:
>> On 12/12/24 12:11, David Woodhouse wrote:
>>> From: David Woodhouse <dwmw@amazon.co.uk>
>>>
>>> The virtual mapping of the control page may have been _PAGE_GLOBAL and
>>> thus its PTE might not have been flushed on the %cr3 switch and
>>> it might effectively still be read-only. Move the writes to it
>>> down into the identity_mapped() function where the same
>>> %rip-relative addressing will get the new mapping.
>>> 
>>> The stack is fine, as that's using the identity mapped address
>>> anyway.
>> 
>> Shouldn't we also ensure that Global entries don't bite anyone
>> else? Something like the completely untested attached patch?
> Doesn't hurt, but this is an identity mapping so absolutely
> everything other than this one page is going to be in the low
> (positive) part of the canonical address space, so won't have had
> global pages in the first place will they?

Right, it's generally _not_ a problem. But it _can_ be a surprising
problem which is why we're all looking at it today. ;)

> Probably a kind thing to do for whatever we're passing control to
> though :)
> 
> I'll round it up into the tree and send it out with the next batch of
> debug support. Care to give me a SoB for it? You can
> s/CR0_PGE/CR4_PGE/ too if you like but I can do that myself as well.
Here's a fixed one with a changelog and a SoB. Still 100% gloriously
untested though.
--------------hPpt08yWuuWdpta0eh1zmCfu
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-x86-mm-Ensure-Global-mappings-are-zapped-during-kexe.patch"
Content-Disposition: attachment;
 filename*0="0001-x86-mm-Ensure-Global-mappings-are-zapped-during-kexe.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAzNTEzYzA4OWU0ZDI4MWZhOTMyZDJiMzI0NTQ0MzY0NWMxYzQ0YzUzIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBEYXZlIEhhbnNlbiA8ZGF2ZS5oYW5zZW5AbGludXgu
aW50ZWwuY29tPgpEYXRlOiBUaHUsIDEyIERlYyAyMDI0IDEzOjM1OjE0IC0wODAwClN1Ympl
Y3Q6IFtQQVRDSF0geDg2L21tOiBFbnN1cmUgR2xvYmFsIG1hcHBpbmdzIGFyZSB6YXBwZWQg
ZHVyaW5nIGtleGVjCgpUaGUga2VybmVsIHN3aXRjaGVzIHRvIGEgbmV3IHNldCBvZiBwYWdl
IHRhYmxlcyBkdXJpbmcga2V4ZWMuIFRoZQpnbG9iYWwgbWFwcGluZ3MgKF9QQUdFX0dMT0JB
TD09MSkgY2FuIHJlbWFpbiBpbiB0aGUgVExCIGFmdGVyIHRoaXMKc3dpdGNoLiBUaGlzIGlz
IGdlbmVyYWxseSBub3QgYSBwcm9ibGVtIGJlY2F1c2UgdGhlIG5ldyBwYWdlIHRhYmxlcwp1
c2UgYSBkaWZmZXJlbnQgcG9ydGlvbiBvZiB0aGUgdmlydHVhbCBhZGRyZXNzIHNwYWNlIHRo
YW4gdGhlIG5vcm1hbAprZXJuZWwgbWFwcGluZ3MuCgpCdXQgdGhlcmUncyBubyBnb29kIHJl
YXNvbiB0byBsZWF2ZSB0aGUgb2xkIFRMQiBlbnRyaWVzIGFyb3VuZC4gVGhleQpjYW4gY2F1
c2Ugbm90aGluZyBidXQgdHJvdWJsZS4gQ2xlYXIgIlBhZ2UgR2xvYmFsIEVuYWJsZSIKKFg4
Nl9DUjRfUEdFKS4gVGhpcywgYWxvbmcgd2l0aCB0aGUgQ1IzIHdyaXRlIGVuc3VyZXMgdGhh
dCB0aGVyZSBpcwpubyB0cmFjZSBvZiB0aGUgb2xkIHBhZ2UgdGFibGVzIGluIHRoZSBUTEIs
IGV2ZW4gZ2xvYmFsIGVudHJpZXMuCgpTaWduZWQtb2ZmLWJ5OiBEYXZlIEhhbnNlbiA8ZGF2
ZS5oYW5zZW5AbGludXguaW50ZWwuY29tPgotLS0KIGFyY2gveDg2L2tlcm5lbC9yZWxvY2F0
ZV9rZXJuZWxfNjQuUyB8IDIgKysKIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKykK
CmRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvcmVsb2NhdGVfa2VybmVsXzY0LlMgYi9h
cmNoL3g4Ni9rZXJuZWwvcmVsb2NhdGVfa2VybmVsXzY0LlMKaW5kZXggZTllODhjMzQyZjc1
Mi4uODdmYzc4OGZhNjdiMiAxMDA2NDQKLS0tIGEvYXJjaC94ODYva2VybmVsL3JlbG9jYXRl
X2tlcm5lbF82NC5TCisrKyBiL2FyY2gveDg2L2tlcm5lbC9yZWxvY2F0ZV9rZXJuZWxfNjQu
UwpAQCAtMTU1LDYgKzE1NSw4IEBAIFNZTV9DT0RFX1NUQVJUX0xPQ0FMX05PQUxJR04oaWRl
bnRpdHlfbWFwcGVkKQogCSAqLwogCWFuZGwJJChYODZfQ1I0X1BBRSB8IFg4Nl9DUjRfTEE1
NyksICVyMTNkCiAJQUxURVJOQVRJVkUgIiIsIF9fc3RyaW5naWZ5KG9ybCAkWDg2X0NSNF9N
Q0UsICVyMTNkKSwgWDg2X0ZFQVRVUkVfVERYX0dVRVNUCisJLyogSW52YWxpZGF0ZSBHbG9i
YWwgZW50cmllcyBmcm9tIHRoZSBUTEI6ICovCisJYW5kcQkkfihYODZfQ1I0X1BHRSksICVy
MTNkCiAJbW92cQklcjEzLCAlY3I0CiAKIAkvKiBGbHVzaCB0aGUgVExCIChuZWVkZWQ/KSAq
LwotLSAKMi4zNC4xCgo=

--------------hPpt08yWuuWdpta0eh1zmCfu--

