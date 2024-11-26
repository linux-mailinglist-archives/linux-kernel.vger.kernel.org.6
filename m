Return-Path: <linux-kernel+bounces-421767-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E57F9D8FB5
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 02:15:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D0C316A17F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Nov 2024 01:15:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13847462;
	Tue, 26 Nov 2024 01:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="YV+FjsIW"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABB7366
	for <linux-kernel@vger.kernel.org>; Tue, 26 Nov 2024 01:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732583708; cv=none; b=COB1ti6XffBWcbSZ9KP3T2MktkF4IKKQisxfQRRCZ49YU96Sww6SRxJbglDP2r61JUwgZJjWvJPgS6kP9TKJe2MZSk+8GXqmmTqDI0pPvR9CVHpjuMkn7kH5P7ZIYCney4yyDuQF6mdHI4QqUiR6QUv7cihQs7IFjR2f6yJ+N9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732583708; c=relaxed/simple;
	bh=2yuysnV02a4CzIOOVXofXYfXtfARaO94j3uteMW9WFU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=S8J6yPa+LLk5OV4pJbu6qZlSQb/lmgRyiSP+eXbkxvCnsq2bE/jAobw2eticMFQN1WAJDnBtV0CFHXwJAjJicxyyQSnND0IxF2FU+7cxEe6HQMXSlmmf534IcB+EZPOpHLnBHEuorrzAx7ACl769TJH2Ee6CAyOB066oJagON+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=YV+FjsIW reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=ry8fBf6FGCzsakWdDXXWiUm/M0LoMji6G/q4p0tzlp8=; b=Y
	V+FjsIW7EXRef7LA0okBKVT8+SbsO/GuaEhMgdtfzorA08g5AHs5cVz1p7rRJJR1
	McFepmiCY4c0VbxFl0wvl6lhIA/rqE0ucCIJ2zGz9NTHFS6N0IkoxZ4UFpPrVsZN
	Cv7y3Zz1ICwigpiGyBEnzQgpxTFvYSUJ9UTslBRy2U=
Received: from 00107082$163.com ( [111.35.191.191] ) by
 ajax-webmail-wmsvr-40-142 (Coremail) ; Tue, 26 Nov 2024 09:14:50 +0800
 (CST)
Date: Tue, 26 Nov 2024 09:14:50 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Suren Baghdasaryan" <surenb@google.com>
Cc: kent.overstreet@linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Abnormal values show up in /proc/allocinfo
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <CAJuCfpEP-xMzHonsE3uV1uYahXehR007B5QX9KjdZdHBWyrXwQ@mail.gmail.com>
References: <20241124074318.399027-1-00107082@163.com>
 <CAJuCfpHviS-pw=2=BNTxp1TnphjuiqWGgZnq84EHvbz08iQ6eg@mail.gmail.com>
 <70bad55f.b656.19362cca6ee.Coremail.00107082@163.com>
 <CAJuCfpHho8se-f4cnvk0g1YLNzhvG3q8QTYmvMmweUnGAhtA=g@mail.gmail.com>
 <CAJuCfpEP-xMzHonsE3uV1uYahXehR007B5QX9KjdZdHBWyrXwQ@mail.gmail.com>
X-NTES-SC: AL_Qu2YAPmTvE4i5imRZukXn0oTju85XMCzuv8j3YJeN500uCbc4yoqcnBcEH374sOXLyCSvxeaWQFCz+FBfaRjYaMOKRQeBQ55hIiLtGgzIMvY
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <51c19b31.eaf.193660912f7.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:jigvCgD3f6wMIUVn14AvAA--.59668W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMxWjqmdFF+DfvQACsa
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpLCAKCgoKQXQgMjAyNC0xMS0yNiAwNDozMTozOSwgIlN1cmVuIEJhZ2hkYXNhcnlhbiIgPHN1
cmVuYkBnb29nbGUuY29tPiB3cm90ZToKPgo+SGkgRGF2aWQsCj5Db3VsZCB5b3UgcGxlYXNlIGNo
ZWNrIGlmIHlvdSBoYXZlIHRoaXMgZml4Ogo+Cj5lZDI2NTUyOWQzOWEgIm1tL2NvZGV0YWc6IGZp
eCBhcmcgaW4gcGdhbGxvY190YWdfY29weSBhbGxvY190YWdfc3ViIgo+Cj5JdCB3YXMgbWVyZ2Vk
IGFmdGVyIHY2LjEyLXJjNiBhbmQgaXQgZml4ZXMgYW4gYWNjb3VudGluZyBidWcgaW5zaWRlCj5w
Z2FsbG9jX3RhZ19jb3B5KCksIHdoaWNoIGlzIHVzZWQgZHVyaW5nIGNvbXBhY3Rpb24uCj5UaGFu
a3MsCj5TdXJlbi4KPgo+Cj5odHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAyNDA5MDYwNDIx
MDguMTE1MDUyNi0zLXl1emhhb0Bnb29nbGUuY29tLwo+aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YWxsLzIwMjQxMDIyMjMyNDQwLjMzNDgyMC0xLXNvdXJhdnBhbmRhQGdvb2dsZS5jb20vCgoKTm8s
IGVkMjY1NTI5ZDM5YSBpcyBub3QgaW4gNi4xMi4wOyBJdCBpcyBub3cgaW4gTGludXMnIHRyZWUu
Ckkgd2lsbCBwdWxsIHRoZSBjb2RlIGFuZCBtYWtlIHNvbWUgdGVzdHMuCgpXaWxsIHVwZGF0ZSBs
YXRlci4KClRoYW5rc34KRGF2aWQKCj4KPj4gPiA+VGhhbmtzLAo+PiA+ID5TdXJlbi4KPj4gPiA+
Cj4+ID4gPj4KPj4gPiA+Pgo+PiA+ID4+IFRoYW5rcwo+PiA+ID4+IERhdmlkCj4+ID4gPj4KPj4g
PiA+Pgo+PiA+ID4+Cj4+ID4gPj4K

