Return-Path: <linux-kernel+bounces-378748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B87D9AD4E7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:34:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4EDAA1C228FE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 19:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD081D89E3;
	Wed, 23 Oct 2024 19:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kHIDX+Qd"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9AA1D0483;
	Wed, 23 Oct 2024 19:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729712079; cv=none; b=fVQI3y+N//tKTyfnhxV5u4g+RjnC7K8g4ndh0NHXxQAcI6Yu8nK+iGm7ayEW88D0RIvE+Q3OJkM2yHWTQRk+oph0iF/AigVl9m5USCIVLJx22urcGibubW3Rekn2DgJRdvABLFpJjVOQGphPCNvlR1tBZNWYxyqla6rOfqlYR7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729712079; c=relaxed/simple;
	bh=GClJXAgBnpVKH/Gkk5AdaepN7ZOE8YyDYYSIN8ZktAM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=c8H2OQDdHJhe2oKevMJzIJLnvFHbW3Np/fXoGXmIF20ynh9BcAF0K3ztZ+uZGZCN4/N0hyciaf7OIM8kfJVCZof3BItzuFltmZ6ajnvy2B53TzpaTK5dJGmg9rbl6EoAp7DyTA27r74nM3JYzxvIpH4WhQvIK1MefVTbcdZM2EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kHIDX+Qd; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729712077; x=1761248077;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=GClJXAgBnpVKH/Gkk5AdaepN7ZOE8YyDYYSIN8ZktAM=;
  b=kHIDX+QdQ/ZzWLUsV+BjFzCLo+e9KGEMVoVeSTUU2NoEHTEsu7JRUOkP
   bH54pxA2cUpVJ+4D4FQSVUS4JFUq3ih+m8ulx0y+J+ZovZBjjo8OW8VXc
   LvWYJc0PWVS8QH4UIaQVt9UYPZpujVASt3w+2HKGXzRWu/7Mg3NVzv8Qy
   lBoY7XkyxF9PizbP+Ij4m1af33hwO4tyknenqGkayGL2B4qP8zboc5WAB
   clWF41v6x0pGkTXaIdSsX52bOPrxydMIpIs9kzEvQ4B83vb4TrS5uuWrH
   CRXaSuCy2KLVZP2hOHAdSilYK4wfCukBFpf/dMeEVoS7FVEdH6dPmja4A
   A==;
X-CSE-ConnectionGUID: JA5l0bTCTRynQXcy7DTkNA==
X-CSE-MsgGUID: XN1HmlgQTieT/aZVxE/2Jg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="29254573"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="29254573"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 12:34:36 -0700
X-CSE-ConnectionGUID: X4qqVj9sTRqOw6pbF+5bWA==
X-CSE-MsgGUID: s4g8n3qTRMWpeMlxUIAHDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,227,1725346800"; 
   d="scan'208";a="80279078"
Received: from spandruv-desk.jf.intel.com ([10.54.75.21])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2024 12:34:37 -0700
Message-ID: <0ab42f9b72b035451535623a9c9b880d10f2d72f.camel@linux.intel.com>
Subject: Re: [PATCH] platform/x86: asus-wmi: Support setting AIPT modes
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: Luke Jones <luke@ljones.dev>, Armin Wolf <W_Armin@gmx.de>, 
	corentin.chary@gmail.com, Hans de Goede <hdegoede@redhat.com>, Ilpo
	=?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Michael Larabel <Michael@phoronix.com>, Casey Bowman
 <casey.g.bowman@intel.com>
Date: Wed, 23 Oct 2024 12:34:24 -0700
In-Reply-To: <e5016c07-05e1-4b05-9f1a-bf664135dbdf@app.fastmail.com>
References: <20241020065051.1724435-1-srinivas.pandruvada@linux.intel.com>
	 <911ce141-8f20-48fb-bc43-e6d4262dbc81@gmx.de>
	 <e5016c07-05e1-4b05-9f1a-bf664135dbdf@app.fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCAyMDI0LTEwLTIzIGF0IDEwOjE1ICswMjAwLCBMdWtlIEpvbmVzIHdyb3RlOgo+IE9u
IFN1biwgMjAgT2N0IDIwMjQsIGF0IDk6MDUgUE0sIEFybWluIFdvbGYgd3JvdGU6Cj4gPiBBbSAy
MC4xMC4yNCB1bSAwODo1MCBzY2hyaWViIFNyaW5pdmFzIFBhbmRydXZhZGE6Cj4gPiA+IAoKWy4u
Ll0KCkhpIEx1a2UsCgo+ID4gPiArwqDCoMKgwqDCoMKgwqAgKi8KPiA+ID4gK8KgwqDCoMKgwqDC
oMKgYWRldiA9IGFjcGlfZGV2X2dldF9maXJzdF9tYXRjaF9kZXYoIlBOUDBDMTQiLCAiQVRLIiwg
LQo+ID4gPiAxKTsKPiA+IAo+ID4gSXMgdGhlcmUgcmVhbGx5IG5vIHdheSBvZiBjaGFuZ2luZyB0
aGUgQUlQVCBtb2RlIHRocm91Z2ggdGhlIFdNSQo+ID4gaW50ZXJmYWNlPwo+ID4gSSB3b3VsZCBw
cmVmZXIgdXNpbmcgdGhlIFdNSSBpbnRlcmZhY2UgaWYgYXZhaWxhYmxlLCBzaW5jZSB0aGUKPiA+
IGZpcm13YXJlIG1pZ2h0Cj4gPiBhc3N1bWUgdGhhdCBGQU5MIGlzIG9ubHkgY2FsbGVkIHRocm91
Z2ggdGhlIFdNSSBpbnRlcmZhY2UuCj4gPiAKPiA+IERvIHlvdSBoYXZlIGEgYWNwaWR1bXAgZnJv
bSBhIGFmZmVjdGVkIGRldmljZT8KPiA+IAo+ID4gVGhhbmtzLAo+ID4gQXJtaW4gV29sZgo+ID4g
Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoGlmIChhZGV2KSB7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqBhY3BpX2hhbmRsZSBoYW5kbGUgPSBhY3BpX2RldmljZV9oYW5kbGUoYWRl
dik7Cj4gPiA+ICsKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGFjcGlfZGV2
X3B1dChhZGV2KTsKPiA+ID4gKwo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
aWYgKCFhY3BpX2hhc19tZXRob2QoaGFuZGxlLCAiRkFOTCIpKQo+ID4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldHVybiAwOwo+IAo+IFF1aXRlIGEg
ZmV3IGxhcHRvcHMgaGF2ZSB0aGlzIG1ldGhvZCBhdmFpbGFibGUsIGJ1dCBtYXkgbm90IGFjdHVh
bGx5Cj4gZG8gYW55dGhpbmcuIFN1Y2ggYXMgdGhlIGZvbGxvd2luZzoKPiAKPiBGWDUxN1pNLWRz
ZHQuZHNsCj4gOTI4ODU6wqDCoMKgwqDCoMKgwqAgTWV0aG9kIChGQU5MLCAxLCBTZXJpYWxpemVk
KQo+IDkyODg2LcKgwqDCoMKgwqDCoMKgIHsKPiA5Mjg4Ny3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IFJldHVybiAoT25lKQo+IDkyODg4LcKgwqDCoMKgwqDCoMKgIH0KCkNvcnJlY3QuIE9uIHRoaXMg
bGFwdG9wIG15IGNoYW5nZXMgd2lsbCBodXJ0LiBTbyB3ZSBtdXN0IHVzZSBXTUkuCgo+IAo+IAoK
PiBXaGlsZSB0aGlzIG9uZSBkb2VzICh6ZW5ib29rIGR1byk6Cj4gCj4gVVg4NDAyLmRzbAo+IDg4
ODM3OsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBNZXRob2QgKEZBTkwsIDEsIFNlcmlh
bGl6ZWQpCj4gODg4MzgtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHsKPiA4ODgzOS3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBPRFYwID0gQXJnMAoKVGhpcyB3
aWxsIHRyaWdnZXIgdG8gbG9hZCBhIG5ldyB0aGVybWFsIGFuZCBwb3dlciB0YWJsZSBiYXNlZCBv
biB0aGUKY29uZGl0aW9uIHNldC4KCj4gODg4NDAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgSWYgKCheXlBDMDAuUEVHMS5QWFAuX1NUQSA9PSBPbmUpKQo+IC0tCj4gODkw
NDE6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgUmV0dXJuIChGQU5MIChJ
SUEwKSkKPiA4OTA0Mi3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfQo+IDg5MDQzLQo+
IDg5MDQ0LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBJZiAoKExvY2FsMCA9PSAweDQ2
NDc1NzREKSkKPiAtLQo+IDg5NjA0OsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgRkFOTCAoSUlBMSkKPiA4OTYwNS3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJldHVybiAoT25lKQo+IDg5NjA2LcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH0KPiA4OTYwNy0KPiAKPiBJJ3ZlIGRpc2NvdmVyZWQg
dGhlIG1ham9yaXR5IG9mIFdNSSBtZXRob2RzLCB5b3UgY2FuIHNlZSB0aGVtIGhlcmU6Cj4gaHR0
cHM6Ly9naXRsYWIuY29tL2FzdXMtbGludXgvcmV2ZXJzZS1lbmdpbmVlcmluZy8tL2Jsb2IvbWFz
dGVyL1dNSV9TUEVDLm1kP3JlZl90eXBlPWhlYWRzCj4gCj4gVGhlcmUgaXMgYSAid2hpc3BlciBt
b2RlIiBXTUnCoCBtZXRob2QsIGJ1dCBJJ3ZlIG5vdCBkb25lIG11Y2ggYXJvdW5kCj4gaXQuCj4g
Cj4gSSBhbHNvIGhhdmUgYSBsYXJnZSBjb2xsZWN0aW9uIG9mIERTTCBpZiB0aGF0IGlzIGhlbHBm
dWwKPiBodHRwczovL2dpdGxhYi5jb20vYXN1cy1saW51eC9yZXZlcnNlLWVuZ2luZWVyaW5nLy0v
dHJlZS9tYXN0ZXIvZHNsLWNvbGxlY3Rpb24/cmVmX3R5cGU9aGVhZHMKPiAKPiBJdCBzZWVtcyB0
aGF0IGJlY2F1c2UgSSBoYXZlIGFjY2VzcyBvbmx5IHRvIHRoZSBST0cgZGxscyBhdCB0aGlzIHRp
bWUKPiBJIG1heSBoYXZlIG1pc3NlZCB0aGUgV01JIG1ldGhvZDogMHgwMDExMDAxOSwgdGhpcyBp
cyBsaWtlbHkgd2hhdCB5b3UKPiBuZWVkIGFzIGl0IGdldHMgRkFORiwgYW5kIHNldHMgRkFOTAo+
IAo+IOKdryByZyAweDAwMTEwMDE5IC1CMyAtQTMgVVg4NDAyLmRzbCAKPiA4OTI4MS3CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFJldHVybiAoMHgwMDAxMDAw
MCkKPiA4OTI4Mi3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Cj4gODky
ODMtCj4gODkyODQ6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgSWYgKChJ
SUEwID09IDB4MDAxMTAwMTkpKQo+IDg5Mjg1LcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHsKPiA4OTI4Ni3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIExvY2FsMCA9IEZBTkYgLyogXF9TQl8uRkFORiAqLwo+IDg5Mjg3LcKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTG9jYWwxID0gMHgwMDA3MDAw
MAo+IC0tCj4gODk1OTktwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBSZXR1cm4gKE9uZSkKPiA4OTYwMC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB9Cj4gODk2MDEtCj4gODk2MDI6wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgSWYgKChJSUEwID09IDB4MDAxMTAwMTkpKQo+IDg5NjAzLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHsKPiA4OTYwNC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIEZBTkwgKElJQTEpCj4gODk2MDUtwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBSZXR1cm4gKE9uZSkKPiAKPiBIb3Bl
ZnVsbHkgdGhpcyBpcyBoZWxwZnVsLAoKCllvdSBoYXZlIGJlZW4gdmVyeSBoZWxwZnVsLiBUaGFu
a3MgZm9yIHRoYXQuIEkgY2FuIG1ha2Ugd29yayB3aXRoIFdNSQptZXRob2RzLiBXYWl0aW5nIGZv
ciBBc3VzIHRvIGdpdmUgZmVlZGJhY2suCgpDdXJyZW50bHkgb24gdmFjYXRpb24gZm9yIHR3byB3
ZWVrcy4gSG9wZSB0aGluZ3MgZ2V0cyBzb3J0ZWQgb3V0ZWQgb3V0CmJlZm9yZSBJIHJldHVybi4K
ClRoYW5rcywKU3Jpbml2YXMKCgoKPiAKPiBSZWdhcmRzLAo+IEx1a2UuCj4gCj4gUC5TOiBJZiBh
bnkgaW5mbyBpcyBkaXNjb3ZlcmVkIHRoYXQgSSBhbSBsYWNraW5nIGluIG15IHJlcG8gaXQgd291
bGQKPiBiZSBoaWdobHkgYXBwcmVjaWF0ZWQgaWYgYSBQUiBhZGRlZCBpdC4KPiAKPiA+ID4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGFzdXMtPmFjcGlfbWdtdF9oYW5kbGUgPSBoYW5k
bGU7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBhc3VzLT5hc3VzX2FpcHRf
cHJlc2VudCA9IHRydWU7Cj4gPiA+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBkZXZf
aW5mbyhkZXYsICJBU1VTIEludGVsbGlnZW50IFBlcmZvcm1hbmNlCj4gPiA+IFRlY2hub2xvZ3kg
KEFJUFQpIGlzIHByZXNlbnRcbiIpOwo+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgLyoKPiA+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIFNldCB0aGUgbW9k
ZSBjb3JyZXNwb25kaW5nIHRvIGRlZmF1bHQgTGludXgKPiA+ID4gcGxhdGZvcm0gcG93ZXIKPiA+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIHByb2ZpbGUgQmFsYW5jZWQKPiA+
ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqLwo+ID4gPiArwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgYXN1c193bWlfd3JpdGVfYWlwdF9tb2RlKGFzdXMsIEFJUFRfU1RB
TkRBUkQpOwo+ID4gPiArwqDCoMKgwqDCoMKgwqB9Cj4gPiA+ICsKPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoHJldHVybiAwOwo+ID4gPiDCoCB9Cj4gPiA+IAoK


