Return-Path: <linux-kernel+bounces-320342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B6E970910
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 19:37:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD78F281EEC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Sep 2024 17:37:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD7B176249;
	Sun,  8 Sep 2024 17:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kze4xufZ"
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B054716D332
	for <linux-kernel@vger.kernel.org>; Sun,  8 Sep 2024 17:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725817065; cv=none; b=fEDhCqjINETWAfbhOjx2c2eZT9ITY5sR+DyfOU4veU5Um3U/emIh4mm0gJXzZQFKFtpnaDLIm/J3aI7Cvniftl6Npr2B/bEzJDvKIIq//67bdSaD/B17VhlqqwZ0mHVUDHowyV4eTzJ2VvquACF0OcBYAhCOF73/JGb2J+jJpb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725817065; c=relaxed/simple;
	bh=QRJ5E+Qg4kZZbzNjiMkCcdN+eaVzGuah8k/OUmE9WXs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=S47zApquem6bDrLmkTzQQVcOY/7qnUiQT6Tv/OyDL54LTGwBP3DR7TlgjJCDkDcKzMTc+1Vwk5puKOcdny7jOgCUI0w4QUkUe75b0RQ4iQCvxMsgSza3/G6WcvVs3cnlCy3nrKqQMEk2KJV7XLs5l6aPvvUdUUGzYUGlpU+CdXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.de; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kze4xufZ; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1725817064; x=1757353064;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=QRJ5E+Qg4kZZbzNjiMkCcdN+eaVzGuah8k/OUmE9WXs=;
  b=kze4xufZ0rOEuKR/oBck4S1Uq3JenGVplIOna8m9HBZgTDJNQ46N3Hu7
   AkhwsQcf73puFY1ZgNI1cDBTBd23S5I/jkG86epVx0QRc3mMc0WweI7PF
   UJ3r4+1VHMnHIgu7NaMQZx/Xlsbhp4v/AatZMDvc5/uI2OSuUagOp9BeO
   Y=;
X-IronPort-AV: E=Sophos;i="6.10,212,1719878400"; 
   d="scan'208";a="451813482"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2024 17:37:39 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:37989]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.90:2525] with esmtp (Farcaster)
 id a470615d-1bd8-4989-a246-8faaa25fc188; Sun, 8 Sep 2024 17:37:38 +0000 (UTC)
X-Farcaster-Flow-ID: a470615d-1bd8-4989-a246-8faaa25fc188
Received: from EX19D020UWC004.ant.amazon.com (10.13.138.149) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Sun, 8 Sep 2024 17:37:37 +0000
Received: from [0.0.0.0] (10.253.83.51) by EX19D020UWC004.ant.amazon.com
 (10.13.138.149) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34; Sun, 8 Sep 2024
 17:37:35 +0000
Message-ID: <10ffa4f1-e3f9-4b7d-9a6f-e4dd843f6d44@amazon.com>
Date: Sun, 8 Sep 2024 19:37:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/3] tsm: Unified Measurement Register ABI for TVMs
To: Cedric Xing <cedric.xing@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Samuel Ortiz <sameo@rivosinc.com>, "James
 Bottomley" <James.Bottomley@HansenPartnership.com>, Lukas Wunner
	<lukas@wunner.de>, Dionna Amalie Glaze <dionnaglaze@google.com>, Qinkun Bao
	<qinkun@google.com>, Mikko Ylinen <mikko.ylinen@linux.intel.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>
CC: <linux-kernel@vger.kernel.org>, <linux-coco@lists.linux.dev>
References: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
Content-Language: en-US
From: Alexander Graf <graf@amazon.com>
In-Reply-To: <20240907-tsm-rtmr-v1-0-12fc4d43d4e7@intel.com>
X-ClientProxiedBy: EX19D040UWB004.ant.amazon.com (10.13.138.91) To
 EX19D020UWC004.ant.amazon.com (10.13.138.149)
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: base64

SGV5IENlZHJpYywKCk9uIDA4LjA5LjI0IDA2OjU2LCBDZWRyaWMgWGluZyB3cm90ZToKPiBOT1RF
OiBUaGlzIHBhdGNoIHNlcmllcyBpbnRyb2R1Y2VzIHRoZSBNZWFzdXJlbWVudCBSZWdpc3RlciAo
TVIpIEFCSSwgYW5kIGlzCj4gbGFyZ2VseSBhIGNvbnRpbnVhdGlvbiBvZiBTYW11ZWwgT3J0aXri
gJlzIHByZXZpb3VzIHdvcmsgb24gdGhlIFJUTVIgQUJJIFsxXS4KPgo+IFRoaXMgcGF0Y2ggc2Vy
aWVzIGFkZHMgYSB1bmlmaWVkIGludGVyZmFjZSB0byBUU00gY29yZSBmb3IgY29uZmlkZW50aWFs
Cj4gY29tcHV0aW5nIChDQykgZ3Vlc3QgZHJpdmVycyB0byBwcm92aWRlIGFjY2VzcyB0byBtZWFz
dXJlbWVudCByZWdpc3RlcnMgKE1ScyksCj4gd2hpY2ggYXJlIGVzc2VudGlhbCBmb3IgcmVseWlu
ZyBwYXJ0aWVzIChSUHMpIHRvIHZlcmlmeSB0aGUgaW50ZWdyaXR5IG9mIHRoZQo+IGNvbXB1dGlu
ZyBlbnZpcm9ubWVudC4gVGhlIGludGVyZmFjZSBpcyBzdHJ1Y3R1cmVkIGFyb3VuZAo+IGBzdHJ1
Y3QgdHNtX21lYXN1cmVtZW50X3Byb3ZpZGVyYCwgd2hpY2ggaG9sZHMgYW4gYXJyYXkgb2YKPiBg
c3RydWN0IHRzbV9tZWFzdXJlbWVudF9yZWdpc3RlcmAgYW5kIGluY2x1ZGVzIG9wZXJhdGlvbnMg
Zm9yIHJlYWRpbmcgYW5kCj4gdXBkYXRpbmcgTVJzLgo+Cj4gVGhlIE1ScyBjb21lIGluIHR3byB2
YXJpZXRpZXM6IHN0YXRpYyBhbmQgcnVudGltZS4gU3RhdGljIE1ScyBhcmUgZGV0ZXJtaW5lZCBh
dAo+IHRoZSBURUUgVk0gKFRWTSkgYnVpbGQgdGltZSBhbmQgY2FwdHVyZSB0aGUgaW5pdGlhbCBt
ZW1vcnkgaW1hZ2Ugb3IgdGhlCj4gY29uZmlndXJhdGlvbi9wb2xpY3kgc3BlY2lmaWVkIGJ5IHRo
ZSBUVk0ncyBvd25lci4gSW4gY29udHJhc3QsIFJ1bnRpbWUgTVJzCj4gKFJUTVJzKSBzdGFydCB3
aXRoIGtub3duIHZhbHVlcywgc3VjaCBhcyBhbGwgemVyb3MsIGF0IFRWTSBidWlsZCB0aW1lIGFu
ZCBhcmUKPiBleHRlbmRlZCB3aXRoIG1lYXN1cmVtZW50cyBvZiBsb2FkZWQgY29kZSwgZGF0YSwg
Y29uZmlndXJhdGlvbiwgb3IgZXhlY3V0ZWQKPiBhY3Rpb25zIGJ5IHRoZSBUVk0gZ3Vlc3QgZHVy
aW5nIHJ1bnRpbWUuCgoKSXMgdGhlcmUgYSBwYXJ0aWN1bGFyIHJlYXNvbiB0byB0cmVhdCBydW50
aW1lIGFuZCBzdGF0aWMgbWVhc3VyZW1lbnRzIApzZXBhcmF0ZWx5PyBJbiBOaXRybyBFbmNsYXZl
cyAod2hpY2ggSSBzdGlsbCBuZWVkIHRvIGFkZCB0c20gaW50ZWdyYXRpb24gCmZvciksIGJvdGgg
YXJlIHNpbXBseSBOU00gUENScy4gIlN0YXRpYyIgbWVhc3VyZW1lbnRzIGdldCBsb2NrZWQgYnkg
dGhlIAppbml0aWFsIGJvb3QgY29kZS4gIlJ1bnRpbWUiIG1lYXN1cmVtZW50cyBjYW4gZ2V0IGxv
Y2tlZCBieSBndWVzdCBjb2RlIApsYXRlciBpbiB0aGUgYm9vdCBwcm9jZXNzLiBCdXQgdGVjaG5p
Y2FsbHksIGJvdGggYXJlIHRoZSBzYW1lIHR5cGUgb2YgCm1lYXN1cmVtZW50LgoKSW4gZmFjdCwg
b3RoZXIgYXR0cmlidXRlcyBsaWtlIGFuIGFkZGl0aW9uYWwgImhhc2hfYWxnbyIgdG8gdGhlIApt
ZWFzdXJlbWVudCBpdHNlbGYgY2FuIGJlIHVzZWZ1bCBpbiBnZW5lcmFsLiBJZiB0aGUgdW5kZXJs
eWluZyAKaW5mcmFzdHJ1Y3R1cmUgYWxsb3dzIGZvciBhIGdlbmVyaWMgZXZlbnQgbG9nIG1lY2hh
bmlzbSwgaGF2aW5nIHRoYXQgCmVhc2lseSBhdmFpbGFibGUgaGVyZSBpcyB1c2VmdWwgdG9vLgoK
U28gSSBkb24ndCByZWFsbHkgdW5kZXJzdGFuZCB3aHkgd2Ugd291bGQgdHJlYXQgc3RhdGljIGFu
ZCBydW50aW1lIAptZWFzdXJlbWVudHMgZGlmZmVyZW50bHkuIENhbid0IHdlIGp1c3QgbWFrZSBh
bGwgb2YgdGhlbSBkaXJlY3RvcmllcyBhbmQgCmluZGljYXRlIHdoZXRoZXIgdGhleSBhcmUgKGlt
LSltdXRhYmxlIHZpYSBhIGZpbGU/CgoKQWxleAoKCgoKQW1hem9uIFdlYiBTZXJ2aWNlcyBEZXZl
bG9wbWVudCBDZW50ZXIgR2VybWFueSBHbWJICktyYXVzZW5zdHIuIDM4CjEwMTE3IEJlcmxpbgpH
ZXNjaGFlZnRzZnVlaHJ1bmc6IENocmlzdGlhbiBTY2hsYWVnZXIsIEpvbmF0aGFuIFdlaXNzCkVp
bmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVudGVyIEhSQiAyNTc3NjQg
QgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAzNjUgNTM4IDU5Nwo=


