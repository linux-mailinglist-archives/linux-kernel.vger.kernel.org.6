Return-Path: <linux-kernel+bounces-329532-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE43979296
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 19:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14D001F22204
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 17:13:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC2531D131C;
	Sat, 14 Sep 2024 17:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="IOdqLu8h"
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.58.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA971D094B
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 17:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.58.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726333923; cv=none; b=iAoItvlDsKK6EyxqIfwV7vB7vxAFSQgpCz3JjV44OmqvYNAdI4rrpI+cy0Qj3aFVlOVWLUpADLqcbWFQJG8HlmPlGr/vihcALCyNnemQg0IQD9YQD52hbDNtcIiAdgu2zC5Dk9wKsytHY7QgUgPRPud4B09/+gAESpMrOCFrdxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726333923; c=relaxed/simple;
	bh=aviUO7AGxg7hPOOxog4OAOdl+WvOmX42K4k0TWim2n8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=I+AUaHv2+J6TEoN0clg6Ka+NOT9fIfMJyjqNR9xDGbg5H9Qb0lJRC0/M1FD8DBJkfovrD9a3wVxQKgaaAkTPJsYaEifj4ZdGFYEwkrc7+0MX6LVdWXHOkBAHeHpM8OveM/RRvy7AqSZxplr+FKk9kKDJ5dArFtevu11FFVOHZNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=IOdqLu8h reason="signature verification failed"; arc=none smtp.client-ip=114.132.58.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
X-QQ-mid: bizesmtpsz12t1726333866teig97
X-QQ-Originating-IP: aiotfPO3QdsW8MtzguVG97jufJQVoSU7OgsNgRYWU8U=
Received: from m16.mail.163.com ( [117.135.210.2])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 15 Sep 2024 01:11:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9909071646809058390
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=gPhLcFXkCILt+ppTvKVhAy/3QVyloIq/mEbEDHNI884=; b=I
	OdqLu8hiaj2Fe9hTab9FPfJG997v/26M4Z5Ph2KAMV7FssdBOr9Jzbo2FK69KwoH
	6yof61GZQW2M70ZRI5YIKSYIS1j0WIDwI34WEgFoYu8LS/E2F/JDMHfMIXfgzHFX
	zT+D4hUK9/HxDCU37gzET6DzSneKYHHBUsZlzc14mU=
Received: from kxwang23$m.fudan.edu.cn ( [104.238.222.239] ) by
 ajax-webmail-wmsvr-40-103 (Coremail) ; Sun, 15 Sep 2024 01:10:26 +0800
 (CST)
Date: Sun, 15 Sep 2024 01:10:26 +0800 (CST)
From: "Kaixin Wang" <kxwang23@m.fudan.edu.cn>
To: "Sebastian Reichel" <sre@kernel.org>
Cc: andriy.shevchenko@linux.intel.com, rdunlap@infradead.org, 
	linux-kernel@vger.kernel.org, 21210240012@m.fudan.edu.cn, 
	21302010073@m.fudan.edu.cn
Subject: Re: [PATCH] HSI: ssi_protocol: Fix use after free vulnerability in
 ssi_protocol Driver Due to Race Condition
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <wcynr6qrl72i5gsibxvj2aldh6ohea6x2wbqwwf2dfuszipvhp@nzz45sllypav>
References: <20240911151915.844957-1-kxwang23@m.fudan.edu.cn>
 <wcynr6qrl72i5gsibxvj2aldh6ohea6x2wbqwwf2dfuszipvhp@nzz45sllypav>
X-NTES-SC: AL_Qu2ZBP+YvEAp4CCfZekXn0kbjug3WcW0u/0k3oJUNps0tSTHxB8hWmVxLH348/muKTCiqgK5VQpF2v5rbYR8VJgC5ookcnpJiYdT4Xi6ltEP
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <C3AD95D8ADEB0624+7db2db3f.acd7.191f183b41f.Coremail.kxwang23@m.fudan.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3f6aCw+VmdWANAA--.23214W
X-CM-SenderInfo: zprtkiiuqyikitw6il2tof0z/1tbiZQJa2GXAocecxQAAs-
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:m.fudan.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0

CgpBdCAyMDI0LTA5LTE0IDE1OjIwOjA3LCAiU2ViYXN0aWFuIFJlaWNoZWwiIDxzcmVAa2VybmVs
Lm9yZz4gd3JvdGU6Cj5IaSwKPgo+T24gV2VkLCBTZXAgMTEsIDIwMjQgYXQgMTE6MTk6MTVQTSBH
TVQsIEthaXhpbiBXYW5nIHdyb3RlOgo+PiBJbiB0aGUgc3NpX3Byb3RvY29sX3Byb2JlIGZ1bmN0
aW9uLCAmc3NpLT53b3JrIGlzIGJvdW5kIHdpdGgKPj4gc3NpcF94bWl0X3dvcmssIEluIHNzaXBf
cG5fc2V0dXAsIHRoZSBzc2lwX3BuX3htaXQgZnVuY3Rpb24KPj4gd2l0aGluIHRoZSBzc2lwX3Bu
X29wcyBzdHJ1Y3R1cmUgaXMgY2FwYWJsZSBvZiBzdGFydGluZyB0aGUKPj4gd29yay4KPj4gCj4+
IElmIHdlIHJlbW92ZSB0aGUgbW9kdWxlIHdoaWNoIHdpbGwgY2FsbCBzc2lfcHJvdG9jb2xfcmVt
b3ZlCj4+IHRvIG1ha2UgYSBjbGVhbnVwLCBpdCB3aWxsIGZyZWUgc3NpIHRocm91Z2gga2ZyZWUo
c3NpKSwKPj4gd2hpbGUgdGhlIHdvcmsgbWVudGlvbmVkIGFib3ZlIHdpbGwgYmUgdXNlZC4gVGhl
IHNlcXVlbmNlCj4+IG9mIG9wZXJhdGlvbnMgdGhhdCBtYXkgbGVhZCB0byBhIFVBRiBidWcgaXMg
YXMgZm9sbG93czoKPj4gCj4+IENQVTAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBDUFUxCj4+IAo+PiAgICAgICAgICAgICAgICAgICAgICAgICB8IHNzaXBfeG1pdF93b3JrCj4+
IHNzaV9wcm90b2NvbF9yZW1vdmUgICAgIHwKPj4ga2ZyZWUoc3NpKTsgICAgICAgICAgICAgfAo+
PiAgICAgICAgICAgICAgICAgICAgICAgICB8IHN0cnVjdCBoc2lfY2xpZW50ICpjbCA9IHNzaS0+
Y2w7Cj4+ICAgICAgICAgICAgICAgICAgICAgICAgIHwgLy8gdXNlIHNzaQo+PiAKPj4gRml4IGl0
IGJ5IGVuc3VyaW5nIHRoYXQgdGhlIHdvcmsgaXMgY2FuY2VsZWQgYmVmb3JlIHByb2NlZWRpbmcK
Pj4gd2l0aCB0aGUgY2xlYW51cCBpbiBzc2lfcHJvdG9jb2xfcmVtb3ZlCj4+IAo+PiBTaWduZWQt
b2ZmLWJ5OiBLYWl4aW4gV2FuZyA8a3h3YW5nMjNAbS5mdWRhbi5lZHUuY24+Cj4+IC0tLQo+Cj5U
aGlzIGRvZXMgbm90IGV2ZW4gY29tcGlsZSA6KAo+CgpTb3JyeSBmb3IgbXkgbWlzdGFrZS4KCj5E
dXJpbmcgbW9kdWxlIHJlbW92YWwgdGhlIG5ldHdvcmsgZGV2aWNlIGlzIHVucmVnaXN0ZXJlZCAo
YW5kIHRodXMKPnN0b3BwZWQpLCB3aGljaCBjYWxscyBzc2lwX3Jlc2V0KCksIHdoaWNoIHNob3Vs
ZCBzdG9wIGFueSBhY3Rpdml0eQo+cmVnYXJkaW5nIHRyYWZmaWMgZXhjaGFuZ2UuIFRoYXQncyB0
aGUgcmlnaHQgcGxhY2UgdG8gY2FuY2VsIHRoZQo+d29yay4KPgo+R3JlZXRpbmdzLAo+Cj4tLSBT
ZWJhc3RpYW4KPgoKVGhhbmtzLiBJIHdpbGwgZml4IGl0IGluIHRoZSBuZXh0IHZlcnNpb24uCgpC
ZXN0IHJlZ2FyZHMsCkthaXhpbiBXYW5nCgo+PiAgZHJpdmVycy9oc2kvY2xpZW50cy9zc2lfcHJv
dG9jb2wuYyB8IDEgKwo+PiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4+IAo+PiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9oc2kvY2xpZW50cy9zc2lfcHJvdG9jb2wuYyBiL2RyaXZlcnMv
aHNpL2NsaWVudHMvc3NpX3Byb3RvY29sLmMKPj4gaW5kZXggYWZlNDcwZjM2NjFjLi4zNTA2Yzcw
ZTM1MDUgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvaHNpL2NsaWVudHMvc3NpX3Byb3RvY29sLmMK
Pj4gKysrIGIvZHJpdmVycy9oc2kvY2xpZW50cy9zc2lfcHJvdG9jb2wuYwo+PiBAQCAtMTE1NSw2
ICsxMTU1LDcgQEAgc3RhdGljIGludCBzc2lfcHJvdG9jb2xfcmVtb3ZlKHN0cnVjdCBkZXZpY2Ug
KmRldikKPj4gIAl1bnJlZ2lzdGVyX25ldGRldihzc2ktPm5ldGRldik7Cj4+ICAJc3NpcF9mcmVl
X2NtZHMoc3NpKTsKPj4gIAloc2lfY2xpZW50X3NldF9kcnZkYXRhKGNsLCBOVUxMKTsKPj4gKwlj
YW5jZWxfd29ya19zeW5jKCZzc2ktPndvcmspCj4+ICAJa2ZyZWUoc3NpKTsKPj4gIAo+PiAgCXJl
dHVybiAwOwo+PiAtLSAKPj4gMi4yNS4xCj4+IAo+PiAK

