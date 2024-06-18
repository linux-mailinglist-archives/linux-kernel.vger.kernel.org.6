Return-Path: <linux-kernel+bounces-219633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8954E90D5E0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 16:46:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A12131C23347
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 14:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3051E139D0A;
	Tue, 18 Jun 2024 14:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ugFny4E1"
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F081E2139A4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 14:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718721259; cv=none; b=IYsPd3IsgapEZ1nbaNvhCKMViWYAuS1awX5e0ePcPADwd4H3zrWCCOxV7cA3RfXDnsgqFASk5m39258g1uj0oqzHvjJRgcdQGUF62nYB2OQotChUTKEcVFtc6WxkcdiwMkd4XWRFQY1wUx4X3sNJIg1DEHHmf1bQ2A80g21RBZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718721259; c=relaxed/simple;
	bh=yqIFQcKxXGEMDkvNg3xeGa5fyRgqgp+DUsjUnWY1/Gw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YIbqWFNlvsZ0NATs9uxIRmm+AnbJwnd7IJhbimzD/rD6KtzxSGb0ZSCUKLlxYQpvnFn+AlXKndifskpR+1bo9vOGetOsyM0zw/2q0HHKikrIhEuK9VDFnnzhfsv8+CNwX31LCXiNVeAbPct+BfBgZYMDUG+ZJ48ibVnNxwzgOEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ugFny4E1; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-705ddabb4deso3346891b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 07:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718721257; x=1719326057; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yqIFQcKxXGEMDkvNg3xeGa5fyRgqgp+DUsjUnWY1/Gw=;
        b=ugFny4E1ZpmxeXR9M5fq1Cq3EOKLFTRBJYLZqPBCARM9VEHm83FrLYdfyXBtn1AHBN
         hJBrTCQeEnvyueXvP8AtYbFasqvWrXQvlgHDR1ZAeLjP1pb3/932n5oJ6JPivbBQM5pw
         fjgSXMzxnF9SlubA8i69Cgjy7tv1YZ8s2BYu0aANQMoVQE1uuEd/tAalGoSJOM2Xyny4
         cUsLmmxayIgmA6QEr+VjvFWbyQWSlh61sK/goCDtxmimbiATMaxJWdwmyGRX4sYDMiAb
         f/rJTilVu9gEarjCdBofWx2GdElcZBrahu8UByJUKgwL0YvrggJVyr1XcDO2yClVfetY
         jx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718721257; x=1719326057;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yqIFQcKxXGEMDkvNg3xeGa5fyRgqgp+DUsjUnWY1/Gw=;
        b=SeYTw46B7oHE597xizsq+qqS17IwfO0M2oWwepIaD8No/qvet1eV3ulgo0HiEKCS2E
         R87WrmvWkQ19FSOrzn6Vw/en62g9XLuCvhxb6854PTIZwLk+4GWMG1G6mQhPgqlwDL2R
         +s2BFah5Ku0xCO4X2qpXUwGmt1NBp6AijbmqS6mkfafN4X+i9DtRs4Q0N01Q+pJXuKJ4
         xWiX95F29VYcl3RlvxKDS25g1bge8+NmCOz5mioSAFKlGxtb5LKmOlnFpZLM03SdZ5X3
         jwmTV6/WhmuDBzOJhXDR9OvZbhdaC7xLMGJEZ4PUzWptlVenxCEA/e4kOmbJhay2Im7a
         2kIA==
X-Forwarded-Encrypted: i=1; AJvYcCUwBoLkQMTWuWoMtCMdtKjIQu/56AShlzOvTcw1UMxG7sK75v2A+J4Btmp2ZDMR12onDDwZlJpx4h8VlTE1QG5bWdtKQbWV4ni24zBd
X-Gm-Message-State: AOJu0YzCupBqpMdI1qGUeX5sagyVtQdCIhQFLHfguJzyT3Xm8QBgiEDi
	OtUDwkB23FBjNu55ZkXtSjvywJPxtWTNsWKEG4kVPOZBTC4q8HK3oX74hK9RzCpQ0odwK9vjPwJ
	JnQ==
X-Google-Smtp-Source: AGHT+IG3JGOL9bs1zaJKnhpZD+RqiN+/G8Oc/GvkAyT1mttqJo9peSaQvwcPj9sY5qwVXrpoxbz2Dn+7FCQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:3695:b0:706:1ae4:b49d with SMTP id
 d2e1a72fcca58-70628f80c1cmr94b3a.1.1718721257089; Tue, 18 Jun 2024 07:34:17
 -0700 (PDT)
Date: Tue, 18 Jun 2024 07:34:15 -0700
In-Reply-To: <ZnAMsuQsR97mMb4a@yzhao56-desk.sh.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240613060708.11761-1-yan.y.zhao@intel.com> <aa43556ea7b98000dc7bc4495e6fe2b61cf59c21.camel@intel.com>
 <ZnAMsuQsR97mMb4a@yzhao56-desk.sh.intel.com>
Message-ID: <ZnGa550k46ow2N3L@google.com>
Subject: Re: [PATCH 0/5] Introduce a quirk to control memslot zap behavior
From: Sean Christopherson <seanjc@google.com>
To: Yan Zhao <yan.y.zhao@intel.com>
Cc: Rick P Edgecombe <rick.p.edgecombe@intel.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>, "sagis@google.com" <sagis@google.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dmatlack@google.com" <dmatlack@google.com>, 
	Kai Huang <kai.huang@intel.com>, Isaku Yamahata <isaku.yamahata@intel.com>, 
	Erdem Aktas <erdemaktas@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

T24gTW9uLCBKdW4gMTcsIDIwMjQsIFlhbiBaaGFvIHdyb3RlOgo+IE9uIEZyaSwgSnVuIDE0LCAy
MDI0IGF0IDA0OjAxOjA3QU0gKzA4MDAsIEVkZ2Vjb21iZSwgUmljayBQIHdyb3RlOgo+ID4gT24g
VGh1LCAyMDI0LTA2LTEzIGF0IDE0OjA2ICswODAwLCBZYW4gWmhhbyB3cm90ZToKPiA+ID4gwqDC
oMKgwqDCoCBhKSBBZGQgYSBjb25kaXRpb24gZm9yIFREWCBWTSB0eXBlIGluIGt2bV9hcmNoX2Zs
dXNoX3NoYWRvd19tZW1zbG90KCkKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoCBiZXNpZGVzIHRoZSB0
ZXN0aW5nIG9mIGt2bV9jaGVja19oYXNfcXVpcmsoKS4gSXQgaXMgc2ltaWxhciB0bwo+ID4gPiDC
oMKgwqDCoMKgwqDCoMKgICJhbGwgbmV3IFZNIHR5cGVzIGhhdmUgdGhlIHF1aXJrIGRpc2FibGVk
Ii4gZS5nLgo+ID4gPiAKPiA+ID4gwqDCoMKgwqDCoMKgwqDCoCBzdGF0aWMgaW5saW5lIGJvb2wg
a3ZtX21lbXNsb3RfZmx1c2hfemFwX2FsbChzdHJ1Y3Qga3ZtCj4gPiA+ICprdm0pwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqAKPiA+
ID4ge8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAKPiA+ID4gwqDCoCAK
PiA+ID4gwqDCoMKgwqDCoMKgwqDCoCDCoMKgwqDCoCByZXR1cm4ga3ZtLT5hcmNoLnZtX3R5cGUg
IT0gS1ZNX1g4Nl9URFhfVk0KPiA+ID4gJibCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAga3ZtX2NoZWNrX2hhc19xdWlyayhrdm0sCj4gPiA+IEtWTV9Y
ODZfUVVJUktfU0xPVF9aQVBfQUxMKTvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgCj4g
PiA+IMKgwqDCoMKgwqDCoMKgwqAgfQo+ID4gPiDCoMKgwqDCoMKgwqDCoMKgIAo+ID4gPiDCoMKg
wqDCoMKgIGIpIEluaXQgdGhlIGRpc2FibGVkX3F1aXJrcyBiYXNlZCBvbiBWTSB0eXBlIGluIGtl
cm5lbCwgZXh0ZW5kCj4gPiA+IMKgwqDCoMKgwqDCoMKgwqAgZGlzYWJsZWRfcXVpcmsgcXVlcnlp
bmcvc2V0dGluZyBpbnRlcmZhY2UgdG8gZW5mb3JjZSB0aGUgcXVpcmsgdG8KPiA+ID4gwqDCoMKg
wqDCoMKgwqDCoCBiZSBkaXNhYmxlZCBmb3IgVERYLgoKVGhlcmUncyBhbHNvIG9wdGlvbjoKCiAg
ICAgICAgICAgIGMpIEluaXQgZGlzYWJsZWRfcXVpcmtzIGJhc2VkIG9uIFZNIHR5cGUuCgpJLmUu
IGxldCB1c2Vyc3BhY2UgZW5hYmxlIHRoZSBxdWlyay4gIElmIHRoZSBWTU0gd2FudHMgdG8gc2hv
b3QgaXRzIFREWCBWTSBndWVzdHMsCnRoZW4gc28gYmUgaXQuICBUaGF0IHNhaWQsIEkgZG9uJ3Qg
bGlrZSB0aGlzIG9wdGlvbiBiZWNhdXNlIGl0IHdvdWxkIGNyZWF0ZSBhIHZlcnkKYml6YXJyZSBB
QkkuCgo+ID4gCj4gPiBJJ2QgcHJlZmVyIHRvIGdvIHdpdGggb3B0aW9uIChhKSBoZXJlLiBCZWNh
dXNlIHdlIGRvbid0IGhhdmUgYW55IGJlaGF2aW9yCj4gPiBkZWZpbmVkIHlldCBmb3IgS1ZNX1g4
Nl9URFhfVk0sIHdlIGRvbid0IHJlYWxseSBuZWVkIHRvICJkaXNhYmxlIGEgcXVpcmsiIG9mIGl0
LgoKSSB2b3RlIGZvciAoYSkgYXMgd2VsbC4KCj4gPiBJbnN0ZWFkIHdlIGNvdWxkIGp1c3QgZGVm
aW5lIEtWTV9YODZfUVVJUktfU0xPVF9aQVBfQUxMIHRvIGJlIGFib3V0IHRoZSBiZWhhdmlvcgo+
ID4gb2YgdGhlIGV4aXN0aW5nIHZtX3R5cGVzLiBJdCB3b3VsZCBiZSBhIGZldyBsaW5lcyBvZiBk
b2N1bWVudGF0aW9uIHRvIHNhdmUKPiA+IGltcGxlbWVudGluZyBhbmQgbWFpbnRhaW5pbmcgYSB3
aG9sZSBpbnRlcmZhY2Ugd2l0aCBzcGVjaWFsIGxvZ2ljIGZvciBURFguIFNvIHRvCj4gPiBtZSBp
dCBkb2Vzbid0IHNlZW0gd29ydGggaXQsIHVubGVzcyB0aGVyZSBpcyBzb21lIG90aGVyIHVzZXIg
Zm9yIGEgbmV3IG1vcmUKPiA+IGNvbXBsZXggcXVpcmsgaW50ZXJmYWNlLgo+IFdoYXQgYWJvdXQg
aW50cm9kdWNpbmcgYSBmb3JjZWQgZGlzYWJsZWRfcXVpcmsgZmllbGQ/CgpOYWgsIGl0J2QgcmVx
dWlyZSBtYW51YWwgb3B0LWluIGZvciBldmVyeSBWTSB0eXBlIGZvciBhbG1vc3Qgbm8gYmVuZWZp
dC4gIEluIGZhY3QsCklNTyB0aGUgY29kZSBpdHNlbGYgd291bGQgYmUgYSBuZXQgbmVnYXRpdmUg
dmVyc3VzOgoKCQlyZXR1cm4ga3ZtLT5hcmNoLnZtX3R5cGUgPT0gS1ZNX1g4Nl9ERUZBVUxUX1ZN
ICYmCgkJICAgICAgIGt2bV9jaGVja19oYXNfcXVpcmsoa3ZtLCBLVk1fWDg2X1FVSVJLX1NMT1Rf
WkFQX0FMTCk7CgpiZWNhdXNlIGV4cGxpY2l0bHkgY2hlY2tpbmcgZm9yIEtWTV9YODZfREVGQVVM
VF9WTSB3b3VsZCBkaXJlY3RseSBtYXRjaCB0aGUKZG9jdW1lbnRhdGlvbiAod2hpY2ggd291bGQg
c3RhdGUgdGhhdCB0aGUgcXVpcmsgb25seSBhcHBsaWVzIHRvIERFRkFVTFRfVk0pLgo=

