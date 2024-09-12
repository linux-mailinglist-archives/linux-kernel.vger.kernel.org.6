Return-Path: <linux-kernel+bounces-326967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D634D976F34
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:56:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14C751C23CFB
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0943A1BE84B;
	Thu, 12 Sep 2024 16:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="Iai0yfON"
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 736FF1AD256
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 16:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.243.244.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726160160; cv=none; b=JcUFBVdCH4K916f7WJzui4lMoelex5bkSvp4B4Y3aRPOYL86zNyAd/vMB45eGvLW3Mvr4Q3SyQP+wciIlSQofGXraWipHGlkWzYG716DFg/0NAWJM7Z+z6CDWAsOTg8FWiDfbwbGaDcHufJXkOIgBNGrn8Urhjv2zDYWmtlb5D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726160160; c=relaxed/simple;
	bh=FcJUnCFiVsoXjpSCDVRftd/aEVh1GoBnNeIOkB+Htt8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=gk6Uzs6VxpBtriLHnBzzLKvijRHjJ0xxBwTGfIbNbjlqbDyLiNEIQSilRhghwFdcrQAYEDhN71qRo0zxxD99fT+T3Cp8FUSffgTUfeggVfImXBLdcrR4ImsrX6BqRzIGoOvMKGKpUyM6Klon2Ze0EIFkggV1NHP4K6drpdTZR7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=Iai0yfON reason="signature verification failed"; arc=none smtp.client-ip=54.243.244.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
X-QQ-mid: bizesmtpsz5t1726160119t7d8kh6
X-QQ-Originating-IP: Zx7oaLjVt1vFN6j3A7H9ICZ/KuQQ0JHOm7wpnlbAoUA=
Received: from m16.mail.163.com ( [117.135.210.5])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 13 Sep 2024 00:55:17 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16381243121260492792
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=H/YC5ZRJVMFIwIEo1fHTYKgGKi1Vxrzsf5zIKLg/VCg=; b=I
	ai0yfONFjkRdTmt3gRnQgp0Lq3WeP/sjKenDPywK4HNzy3eMECAZH4ELOfpR0U0n
	0ukxgfL63ZvkGRxTp5VBXDLp9HoCQ5UwyANYi0snTyviMzDVQEDjkb8BaoimDNnh
	LBWYgGrU4XwKRqbSSfxIZKxbBQHgyrdWbh5nTOBIC4=
Received: from kxwang23$m.fudan.edu.cn ( [104.238.222.239] ) by
 ajax-webmail-wmsvr-40-136 (Coremail) ; Fri, 13 Sep 2024 00:54:39 +0800
 (CST)
Date: Fri, 13 Sep 2024 00:54:39 +0800 (CST)
From: "Kaixin Wang" <kxwang23@m.fudan.edu.cn>
To: "Miquel Raynal" <miquel.raynal@bootlin.com>
Cc: "Frank Li" <Frank.li@nxp.com>, 21210240012@m.fudan.edu.cn, 
	21302010073@m.fudan.edu.cn, conor.culhane@silvaco.com, 
	alexandre.belloni@bootlin.com, linux-i3c@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i3c: master: svc: Fix use after free vulnerability in
 svc_i3c_master Driver Due to Race Condition
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <20240912085709.6ec0a289@xps-13>
References: <20240911150135.839946-1-kxwang23@m.fudan.edu.cn>
 <ZuG2SbsHEU5BU9mX@lizhi-Precision-Tower-5810>
 <20240912085709.6ec0a289@xps-13>
X-NTES-SC: AL_Qu2ZBP2dv0gs7ySeZOkXn0kbjug3WcW0u/0k3oJUNps0sSbJxCIce1FGAHTrzv+TMyOvnjaRQClvyeFHTa9cY5gZc/65IYnnfpHCxo0OHY+7
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <C05F548F941D5F36+47d9e505.c28c.191e7288a6e.Coremail.kxwang23@m.fudan.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wD3H_vPHONmxpAFAA--.2860W
X-CM-SenderInfo: zprtkiiuqyikitw6il2tof0z/1tbiwh5Y2GWXw6aYUAAJsK
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:m.fudan.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0

CgrlnKggMjAyNC0wOS0xMiAxNDo1NzowOe+8jCJNaXF1ZWwgUmF5bmFsIiA8bWlxdWVsLnJheW5h
bEBib290bGluLmNvbT4g5YaZ6YGT77yaCj5IaSwKPgo+RnJhbmsubGlAbnhwLmNvbSB3cm90ZSBv
biBXZWQsIDExIFNlcCAyMDI0IDExOjI0OjU3IC0wNDAwOgo+Cj4+IE9uIFdlZCwgU2VwIDExLCAy
MDI0IGF0IDExOjAxOjM1UE0gKzA4MDAsIEthaXhpbiBXYW5nIHdyb3RlOgo+PiA+IEluIHRoZSBz
dmNfaTNjX21hc3Rlcl9wcm9iZSBmdW5jdGlvbiwgJm1hc3Rlci0+aGpfd29yayBpcyBib3VuZCB3
aXRoCj4+ID4gc3ZjX2kzY19tYXN0ZXJfaGpfd29yaywgJm1hc3Rlci0+aWJpX3dvcmsgaXMgYm91
bmQgd2l0aAo+PiA+IHN2Y19pM2NfbWFzdGVyX2liaV93b3JrLiBBbmQgc3ZjX2kzY19tYXN0ZXJf
aWJpX3dvcmsgwqBjYW4gc3RhcnQgdGhlCj4+ID4gaGpfd29yaywgc3ZjX2kzY19tYXN0ZXJfaXJx
X2hhbmRsZXIgY2FuIHN0YXJ0IHRoZSBpYmlfd29yay4KPj4gPgo+PiA+IElmIHdlIHJlbW92ZSB0
aGUgbW9kdWxlIHdoaWNoIHdpbGwgY2FsbCBzdmNfaTNjX21hc3Rlcl9yZW1vdmUgdG8KPj4gPiBt
YWtlIGNsZWFudXAsIGl0IHdpbGwgZnJlZSBtYXN0ZXItPmJhc2UgdGhyb3VnaCBpM2NfbWFzdGVy
X3VucmVnaXN0ZXIKPj4gPiB3aGlsZSB0aGUgd29yayBtZW50aW9uZWQgYWJvdmUgd2lsbCBiZSB1
c2VkLiBUaGUgc2VxdWVuY2Ugb2Ygb3BlcmF0aW9ucwo+PiA+IHRoYXQgbWF5IGxlYWQgdG8gYSBV
QUYgYnVnIGlzIGFzIGZvbGxvd3M6Cj4+ID4KPj4gPiBDUFUwICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBDUFUxCj4+ID4KPj4gPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8IHN2Y19pM2NfbWFzdGVyX2hqX3dvcmsKPj4gPiBzdmNfaTNjX21hc3Rl
cl9yZW1vdmUgICAgICAgICAgICAgICB8Cj4+ID4gaTNjX21hc3Rlcl91bnJlZ2lzdGVyKCZtYXN0
ZXItPmJhc2UpfAo+PiA+IGRldmljZV91bnJlZ2lzdGVyKCZtYXN0ZXItPmRldikgICAgIHwKPj4g
PiBkZXZpY2VfcmVsZWFzZSAgICAgICAgICAgICAgICAgICAgICB8Cj4+ID4gLy9mcmVlIG1hc3Rl
ci0+YmFzZSAgICAgICAgICAgICAgICAgfAo+PiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgaTNjX21hc3Rlcl9kb19kYWEoJm1hc3Rlci0+YmFzZSkKPj4gPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8IC8vdXNlIG1hc3Rlci0+YmFzZQo+PiA+Cj4+
ID4gRml4IGl0IGJ5IGVuc3VyaW5nIHRoYXQgdGhlIHdvcmsgaXMgY2FuY2VsZWQgYmVmb3JlIHBy
b2NlZWRpbmcgd2l0aCB0aGUKPj4gPiBjbGVhbnVwIGluIHN2Y19pM2NfbWFzdGVyX3JlbW92ZS4K
Pj4gPgo+PiA+IFNpZ25lZC1vZmYtYnk6IEthaXhpbiBXYW5nIDxreHdhbmcyM0BtLmZ1ZGFuLmVk
dS5jbj4KPj4gPiAtLS0gIAo+PiAKPj4gUGxlYXNlIGFkZCBmaXhlcyB0YWcgYW5kIGNjIHN0YWJs
ZS4KPgo+WWVzIGluZGVlZC4gT3RoZXJ3aXNlIGxvb2tzIGdvb2QgdG8gbWUgb25jZSB0aGlzIGZp
eGVkLgo+Cj5SZXZpZXdlZC1ieTogTWlxdWVsIFJheW5hbCA8bWlxdWVsLnJheW5hbEBib290bGlu
LmNvbT4KPgo+VGhhbmtzLAo+TWlxdcOobAo+CgpUaGFua3MgZm9yIHRoZSByZXZpZXchCgpCZXN0
IHJlZ2FyZHMsCkthaXhpbiBXYW5nCg==

