Return-Path: <linux-kernel+bounces-326934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8856976EB2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 407071F24F71
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 16:31:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29F6B14B976;
	Thu, 12 Sep 2024 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="pRkYPHm0"
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 809FD57CB4;
	Thu, 12 Sep 2024 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726158659; cv=none; b=hg2eKvVEa6ySmVGn8WU3drlKihHtLeU2/lMMk9OVDpeDpapByJMqB+nk4zZi1y9gbLkXLlyE2ZLa3pginynSvU2QCYvwEVo2fLSCFkFR71XCf9FPDdhw+l9F0YnefHjQ76H2L0H9V+k+uK+rhg7SqrVpeXjKHWbDwsI5SSk8UG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726158659; c=relaxed/simple;
	bh=pIAvUz7AdR7Cd4/p7TKjjsRTaWtGb38TbvttvobxCt0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=AyrAt/8rR3c0FS2rY2GwPDylR6VbCgeKk8X3P9uHrMNFgL2q6ChQrJTfAP7TFygNvkObntnbFqQ8h10OXDRK1xsYZNmQkI01P73apDoAd6T3sPDrk6hetGqOZN0I5gNE0U/FCEzs4DHj1xCUOg49IuJoLnb1NYWcTKJQFmbe94s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn; spf=pass smtp.mailfrom=m.fudan.edu.cn; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=pRkYPHm0 reason="signature verification failed"; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=m.fudan.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=m.fudan.edu.cn
X-QQ-mid: bizesmtp87t1726158613tg3c3bqc
X-QQ-Originating-IP: ivnHupChGXKxz0+qNd23PfVkuiwQxwfKgQiTgP/OwLo=
Received: from m16.mail.163.com ( [220.197.31.5])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 13 Sep 2024 00:30:11 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18047817215908464017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=KN/BuQSTcSNJl+7Nu1E4ko/CumlClB1S2fh3meVE1rE=; b=p
	RkYPHm0vahx7yzaj6TgqxGr1asPuZK9UauK8HTEMLF1JGki2ouE+sPlPodWw6CXT
	FcEM9pEx2iOn9YJ5L2mCZkQrJz5azIacB7m5txFuRg1iQh7ctxnnrZOUEroPZPpS
	8YHWEoQJfe7tGk5WpyOuxiNPkwwvvSuOemxP1/jke4=
Received: from kxwang23$m.fudan.edu.cn ( [104.238.222.239] ) by
 ajax-webmail-wmsvr-40-136 (Coremail) ; Fri, 13 Sep 2024 00:29:33 +0800
 (CST)
Date: Fri, 13 Sep 2024 00:29:33 +0800 (CST)
From: "Kaixin Wang" <kxwang23@m.fudan.edu.cn>
To: "Helge Deller" <deller@gmx.de>
Cc: 21210240012@m.fudan.edu.cn, 21302010073@m.fudan.edu.cn, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, kuninori.morimoto.gx@renesas.com, 
	laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH] fbdev: pxafb: Fix use after free vulnerability in
 pxafb_driver Driver Due to Race Condition
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <7baab3f7-1185-473d-83a7-07ad49a4130a@gmx.de>
References: <20240911142952.833223-1-kxwang23@m.fudan.edu.cn>
 <7baab3f7-1185-473d-83a7-07ad49a4130a@gmx.de>
X-NTES-SC: AL_Qu2ZBP2et00s5SGbYOkXn0kbjug3WcW0u/0k3oJUNps0sSbJxCIce1FGAHTrzv+TMyOvnjaRQClvyeFHTa9cY5isaIJncdeUlrTj9gzSNVvL
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <1C2E4AB314A69BCF+750f4f16.c216.191e7118e58.Coremail.kxwang23@m.fudan.edu.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wDnr8juFuNmG1IHAA--.2650W
X-CM-SenderInfo: zprtkiiuqyikitw6il2tof0z/1tbiwh5Y2GWXw6aYUAADsA
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:m.fudan.edu.cn:qybglogicsvrsz:qybglogicsvrsz4a-0

CgpBdCAyMDI0LTA5LTEyIDAxOjM4OjI2LCAiSGVsZ2UgRGVsbGVyIiA8ZGVsbGVyQGdteC5kZT4g
d3JvdGU6Cj5PbiA5LzExLzI0IDE2OjI5LCBLYWl4aW4gV2FuZyB3cm90ZToKPj4gSW4gdGhlIHB4
YWZiX3Byb2JlIGZ1bmN0aW9uLCBpdCBjYWxscyB0aGUgcHhhZmJfaW5pdF9mYmluZm8gZnVuY3Rp
b24sCj4+IGFmdGVyIHdoaWNoICZmYmktPnRhc2sgaXMgYXNzb2NpYXRlZCB3aXRoIHB4YWZiX3Rh
c2suIE1vcmVvdmVyLAo+PiB3aXRoaW4gdGhpcyBweGFmYl9pbml0X2ZiaW5mbyBmdW5jdGlvbiwg
dGhlIHB4YWZiX2JsYW5rIGZ1bmN0aW9uCj4+IHdpdGhpbiB0aGUgJnB4YWZiX29wcyBzdHJ1Y3Qg
aXMgY2FwYWJsZSBvZiBzY2hlZHVsaW5nIHdvcmsuCj4+Cj4+IElmIHdlIHJlbW92ZSB0aGUgbW9k
dWxlIHdoaWNoIHdpbGwgY2FsbCBweGFmYl9yZW1vdmUgdG8gbWFrZSBjbGVhbnVwLAo+PiBpdCB3
aWxsIGNhbGwgdW5yZWdpc3Rlcl9mcmFtZWJ1ZmZlciBmdW5jdGlvbiB3aGljaCBjYW4gY2FsbAo+
PiBkb191bnJlZ2lzdGVyX2ZyYW1lYnVmZmVyIHRvIGZyZWUgZmJpLT5mYiB0aHJvdWdoCj4+IHB1
dF9mYl9pbmZvKGZiX2luZm8pLCB3aGlsZSB0aGUgd29yayBtZW50aW9uZWQgYWJvdmUgd2lsbCBi
ZSB1c2VkLgo+PiBUaGUgc2VxdWVuY2Ugb2Ygb3BlcmF0aW9ucyB0aGF0IG1heSBsZWFkIHRvIGEg
VUFGIGJ1ZyBpcyBhcyBmb2xsb3dzOgo+Pgo+PiBDUFUwICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgQ1BVMQo+Pgo+PiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB8IHB4YWZiX3Rhc2sKPj4gcHhhZmJfcmVtb3ZlICAgICAgICAgICAgICAg
ICAgICAgICB8Cj4+IHVucmVnaXN0ZXJfZnJhbWVidWZmZXIoaW5mbykgICAgICAgfAo+PiBkb191
bnJlZ2lzdGVyX2ZyYW1lYnVmZmVyKGZiX2luZm8pIHwKPj4gcHV0X2ZiX2luZm8oZmJfaW5mbykg
ICAgICAgICAgICAgICB8Cj4+IC8vIGZyZWUgZmJpLT5mYiAgICAgICAgICAgICAgICAgICAgfCBz
ZXRfY3RybHJfc3RhdGUoZmJpLCBzdGF0ZSkKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgfCBfX3B4YWZiX2xjZF9wb3dlcihmYmksIDApCj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHwgZmJpLT5sY2RfcG93ZXIob24sICZmYmktPmZiLnZhcikKPj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAvL3VzZSBmYmktPmZiCj4+Cj4+
IEZpeCBpdCBieSBlbnN1cmluZyB0aGF0IHRoZSB3b3JrIGlzIGNhbmNlbGVkIGJlZm9yZSBwcm9j
ZWVkaW5nCj4+IHdpdGggdGhlIGNsZWFudXAgaW4gcHhhZmJfcmVtb3ZlLgo+Pgo+PiBOb3RlIHRo
YXQgb25seSByb290IHVzZXIgY2FuIHJlbW92ZSB0aGUgZHJpdmVyIGF0IHJ1bnRpbWUuCj4+Cj4+
IFNpZ25lZC1vZmYtYnk6IEthaXhpbiBXYW5nIDxreHdhbmcyM0BtLmZ1ZGFuLmVkdS5jbj4KPj4g
LS0tCj4+ICAgZHJpdmVycy92aWRlby9mYmRldi9weGFmYi5jIHwgMSArCj4+ICAgMSBmaWxlIGNo
YW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4KPkkndmUgYWRkZWQgdGhlIHBhdGNoIHRvIHRoZSBmYmRl
diBnaXQgdHJlZSwgYnV0IGNoYW5nZWQgdGhlIHRpdGxlIHRvOgo+ImZiZGV2OiBweGFmYjogRml4
IHBvc3NpYmxlIHVzZSBhZnRlciBmcmVlIGluIHB4YWZiX3Rhc2soKSIKPgo+VGhhbmtzIQo+SGVs
Z2UKPgo+CgoKVGhhbmtzIGZvciB0aGUgcmV2aWV3ISBJIGFwcHJlY2lhdGUgdGhlIGFkanVzdG1l
bnQgdG8gdGhlIHBhdGNoIHRpdGxlIHRvIG1ha2UgaXQgbW9yZSBwcmVjaXNlLgoKQmVzdCByZWdh
cmRzLApLYWl4aW4gV2FuZwo=

