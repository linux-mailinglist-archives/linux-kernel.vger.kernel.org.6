Return-Path: <linux-kernel+bounces-316975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C47E696D7C0
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 13:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78D251F22536
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:58:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8541719A2AE;
	Thu,  5 Sep 2024 11:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="IXy7wIWH"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE5219A29A
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 11:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725537507; cv=none; b=IGMQ7I60nO3MqPcnDIrtl5jMOZ0RXKjpncwnNByZ2HBRHww99SzOPBKT5UROO/+yG7rONHUQ8m8BbYt9JKVuqRFo8BY4QRyC4qqm6Cr9GV5xTboBFX62x18BJo7Zzx5a2whhRUf43dtYSPq8STGoADz4x9iLzLaqYhKfkwQCIsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725537507; c=relaxed/simple;
	bh=kmr5yy9YSuUtuLhcf9OBcpncEHbeAkDasfnmS6ddvbQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QQ03Wi8aWJqGlOuWfuKG2x1wqhyhBPOI37L1ziN+rSDqY8SfGmr/XJBXyjhjH7TYZ219SLxmyRiRHbBglEmDYCC5nY7KU7KHxMWeYNhDa65VN5E82WLNtd7AIVQ/WDzwKF1YPd8p57+POnVLCd1dm3ZFEs2wE/Pf3iqlB1hS/Bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=IXy7wIWH; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xry111.site;
	s=default; t=1725537500;
	bh=kmr5yy9YSuUtuLhcf9OBcpncEHbeAkDasfnmS6ddvbQ=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=IXy7wIWH9zZbJrxhNebrTcFJs2SAYE676n1Vm66hIXGyyuI4lP4KzTGgAtUBovi5O
	 e5c5iDJlADDp15FRzf3+ZTT2R9BmFMoxQ4YJcJwQBu3J4r7Aas8twHEPReXu9g+pSH
	 /b5YLXwb+kYR+zoi/SQRzCw13tdv0W4zue0c3/kE=
Received: from [192.168.124.11] (unknown [113.200.174.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (secp384r1) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 945F56762D;
	Thu,  5 Sep 2024 07:58:18 -0400 (EDT)
Message-ID: <c6c7ddb2730611e5877240de033f5af3263fae0b.camel@xry111.site>
Subject: Re: [PATCH v3] LoongArch/percpu: Simplify _percpu_read() and
 _percpu_write()
From: Xi Ruoyao <xry111@xry111.site>
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
 linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>, Thomas
 Gleixner <tglx@linutronix.de>
Date: Thu, 05 Sep 2024 19:58:15 +0800
In-Reply-To: <CAAhV-H7LtPja5K6ZoEbNTgjwjEL_uj-V11Y6Vq9HqTu1+2YMHw@mail.gmail.com>
References: <20240905065438.802898-1-ubizjak@gmail.com>
	 <CAAhV-H7LtPja5K6ZoEbNTgjwjEL_uj-V11Y6Vq9HqTu1+2YMHw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.52.3 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gVGh1LCAyMDI0LTA5LTA1IGF0IDE5OjQ3ICswODAwLCBIdWFjYWkgQ2hlbiB3cm90ZToKPiA+
ICsjZGVmaW5lIF9wZXJjcHVfd3JpdGUoc2l6ZSwgX3BjcCwgX3ZhbCnCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgXAo+ID4gK2RvIHvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+ID4gK8KgwqDCoMKgwqDCoCB1
bnNpZ25lZCBsb25nIF9fcGNwX3ZhbCA9IF9fcGNwdV9jYXN0XyMjc2l6ZShfdmFsKTvCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgXAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIFwKPiA+
ICvCoMKgwqDCoMKgwqAgaWYgKDApIHvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB0
eXBlb2YoX3BjcCkgcHRvX3RtcF9fO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+ID4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgcHRvX3RtcF9fID0gKF92YWwpO8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBcCj4gPiArwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAodm9pZClwdG9fdG1wX187wqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIFwKPiA+ICvCoMKgwqDCoMKgwqAgfcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgXAo+IEVtbW0sIGluIFYyIEkganVz
dCBjb25maXJtIHRoYXQgd2hldGhlciBpdCBpcyB3b3J0aCB0byB1c2UgbWFjcm8KPiBpbnN0ZWFk
IG9mIGlubGluZSBmdW5jdGlvbnMsIEkgdGhpbmsgd2UgZG9uJ3QgcmVhbGx5IG5lZWQgc3VjaCBh
Cj4gY2hlY2tpbmcgaGVyZS4gOikKCkl0J3Mgc3RpbGwgKHNsaWdobHkpIGJldHRlciAoanVzdCBm
cm9tIGFlc3RoZXRpY3MgdmlldykgdG8gdXNlIGlubGluZQpmdW5jdGlvbiBpbnN0ZWFkIG9mIG1h
Y3JvLiAgSXMgaXQgcG9zc2libGUgdG8gY2xlYXIgdGhlIGhlYWRlcgpkZXBlbmRlbmN5IGFuZCBi
cmVhayB0aGUgY2lyY2xlIHNvIHdlIGNhbiBzdGlsbCB1c2UgX19wZXJjcHUgaW4gYXJjaApwZXJj
cHUuaCBpbnN0ZWFkPwoKKFNpbXBseSByZW1vdmluZyBfX3BlcmNwdSBmcm9tIHRoZSBmdW5jdGlv
biBwYXJhbWV0ZXIgbGlzdCBjYXVzZXMgbWFueQp3YXJuaW5ncyB3aXRoIG1ha2UgQz0xLikKCi0t
IApYaSBSdW95YW8gPHhyeTExMUB4cnkxMTEuc2l0ZT4KU2Nob29sIG9mIEFlcm9zcGFjZSBTY2ll
bmNlIGFuZCBUZWNobm9sb2d5LCBYaWRpYW4gVW5pdmVyc2l0eQo=


