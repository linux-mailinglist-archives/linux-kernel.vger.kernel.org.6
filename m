Return-Path: <linux-kernel+bounces-420803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D989D8325
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 11:13:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35AEB16111E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 10:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F92192D6B;
	Mon, 25 Nov 2024 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="m+aW+aXr"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6ECF190661
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732529421; cv=none; b=k8ILtlysMUOqE3FCpf1WcM9UEuE57yAnw+Lb50kbTNLOxSodh7vcxwfBsjiL/t3ZiOcIiT1Erf2dAJcKIITIjg71bKxZYojKX/cmm6jUBpAZ4/gFuy10xGBrcycxjm5CDcz4G0s/Spvk4b/vWQJ6dkt3dnanO/nRiRn/fLwXQoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732529421; c=relaxed/simple;
	bh=TjSj/kKF1bcZ/VIdvLtzcp0rSCBswlketXqsoTKyGIA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=QKAqQ8MAzdwpPOxOGGJJJJfm0ncRn7s7iKNyk2JW0Dikc0MU/H9qMIICMaOZOS7XjSlJgjPNgwcki+G9wH7BsO2Z5wbY3emiLH2s2DdtwIn6zGJQlire9gfsbecoYZaQqzswIXEYWdXFdLQaNWvYICUmok7Jg68/c0ZCtadUNBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=m+aW+aXr reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=CB4sPQelFVjL65o2uK0oiz/2yyN2W1jTx046ybm5vlQ=; b=m
	+aW+aXrIBDaliW0SbmPj30X2Ij8bE1G35C29+ttP+EF+iIjzpDRPa15rp79HsjaD
	wB/BOrmv4jajfcmijHJr8jqn6cFUAAv8AukHp9dw54m7W0wnlZSp1W22nSCh9OdO
	aESFd2ERF7nsNj1cWx5YaXViQpdXxmwV7toKOLwbUA=
Received: from 00107082$163.com ( [111.35.191.191] ) by
 ajax-webmail-wmsvr-40-138 (Coremail) ; Mon, 25 Nov 2024 18:09:59 +0800
 (CST)
Date: Mon, 25 Nov 2024 18:09:59 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Suren Baghdasaryan" <surenb@google.com>
Cc: kent.overstreet@linux.dev, linux-kernel@vger.kernel.org
Subject: Re: Abnormal values show up in /proc/allocinfo
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <CAJuCfpHviS-pw=2=BNTxp1TnphjuiqWGgZnq84EHvbz08iQ6eg@mail.gmail.com>
References: <20241124074318.399027-1-00107082@163.com>
 <CAJuCfpHviS-pw=2=BNTxp1TnphjuiqWGgZnq84EHvbz08iQ6eg@mail.gmail.com>
X-NTES-SC: AL_Qu2YAPmZtksi7yWaYukXn0oTju85XMCzuv8j3YJeN500iCXrxzEqcnBENGTa4sOVJDuSvxePUSlnzdxZea1yWrCozCs2KgE5ElzpvvE8wIG/
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <70bad55f.b656.19362cca6ee.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:iigvCgDXH8z4TERn1JEvAA--.7096W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiMxuiqmdEQO3sMwADsy
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpLCAKClNvbWUgdXBkYXRlCgpJIHJlcHJvZHVjZSB0aGUgYWJub3JtYWwgdmFsdWVzIG9mICJm
dW5jOmNvbXBhY3Rpb25fYWxsb2MiIHRvZGF5LCBqdXN0IG9uY2UuIEJ1dCBJIGhhdmUgbm90IGZv
dW5kIGEgZGV0ZXJtaW5pc3RpYyBwcm9jZWR1cmUgeWV0LgpTZWVtcyB0byBtZSwgaXQgaGFwcGVu
cyB3aGVuIGtjb21wYWN0ZCBzdGFydHMgdG8gd29yawoKICAgIHJldF9mcm9tX2ZvcmsoMTAwLjAw
MCUgNTcvNTcpCiAgICAgICAga3RocmVhZCgxMDAuMDAwJSA1Ny81NykKICAgICAgICAgICAga2Nv
bXBhY3RkKDEwMC4wMDAlIDU3LzU3KQogICAgICAgICAgICAgICAgY29tcGFjdF9ub2RlKDEwMC4w
MDAlIDU3LzU3KQogICAgICAgICAgICAgICAgICAgIGNvbXBhY3Rfem9uZSgxMDAuMDAwJSA1Ny81
NykKICAgICAgICAgICAgICAgICAgICAgICAgbWlncmF0ZV9wYWdlcygxMDAuMDAwJSA1Ny81NykK
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1pZ3JhdGVfcGFnZXNfYmF0Y2goMTAwLjAwMCUg
NTcvNTcpCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29tcGFjdGlvbl9hbGxvYygx
MDAuMDAwJSA1Ny81NykKCgpNYXliZSwga2NvbXBhY3RkIG1lc3MgdXAgaW5mb3JtYXRpb24gbmVl
ZGVkIGJ5IG1lbW9yeSB0cmFja2luZz8gSnVzdCBhIHdpbGQgZ3Vlc3MuCkFuZCB0aG9zZSBuZWdh
dGl2ZSBzaWduZWQgdmFsdWVzLCBhbmQgdW5kZXJmbG93ZWQgdW5zaWduZWQgdmFsdWVzIGNvdWxk
IGFsc28gYmUgdGhlIHNpZGUtZWZmZWN0IG9mIG1lbW9yeSBjb21wYWN0aW9uLgpBIHdpbGRlciBn
dWVzcy4uLi4KCgoKRllJCkRhdmlkCgoKCgpBdCAyMDI0LTExLTI1IDA4OjM1OjU0LCAiU3VyZW4g
QmFnaGRhc2FyeWFuIiA8c3VyZW5iQGdvb2dsZS5jb20+IHdyb3RlOgo+T24gU2F0LCBOb3YgMjMs
IDIwMjQgYXQgMTE6NDPigK9QTSBEYXZpZCBXYW5nIDwwMDEwNzA4MkAxNjMuY29tPiB3cm90ZToK
Pj4KPj4gSGksCj4+Cj4+IEkgYW0gcnVubmluZyA2LjEyLjAgZm9yIGEgd2VlaywgYW5kIHRvZGF5
IEkgbm90aWNlIHNldmVyYWwgc3RyYW5nZQo+PiBpdGVtcyBpbiAvcHJvYy9hbGxvY2luZm86Cj4+
Cj4+ICAgICAgICAtNDA5NiAxODQ0Njc0NDA3MzcwOTU1MTYxNSBtbS9maWxlbWFwLmM6Mzc4NyBm
dW5jOmRvX3JlYWRfY2FjaGVfZm9saW8KPj4gIC0xOTQ2NzMwNDk2IDE4NDQ2NzQ0MDczNzA5MDc2
MzQwIG1tL2ZpbGVtYXAuYzoxOTUyIGZ1bmM6X19maWxlbWFwX2dldF9mb2xpbwo+PiAgIC05MDMy
OTQ5NzYgMTg0NDY3NDQwNzM3MDkzMzEwODUgbW0vcmVhZGFoZWFkLmM6MjYzIGZ1bmM6cGFnZV9j
YWNoZV9yYV91bmJvdW5kZWQKPj4gICAtMzUzMDU0NzIwIDE4NDQ2NzQ0MDczNzA5NDY1NDIxIG1t
L3NobWVtLmM6MTc2OSBmdW5jOnNobWVtX2FsbG9jX2ZvbGlvCj4+ICAxMDU0NzU2NTIxMCAgICAg
ICAgMCBtbS9jb21wYWN0aW9uLmM6MTg4MCBmdW5jOmNvbXBhY3Rpb25fYWxsb2MKPj4gICAtMTU2
NDg3NjgwIDE4NDQ2NzQ0MDczNzA5NTEzNDExIG1tL21lbW9yeS5jOjEwNjQgZnVuYzpmb2xpb19w
cmVhbGxvYwo+PiAgLTI0MjI2ODU2OTYgMTg0NDY3NDQwNzM3MDg5NjAxNDAgbW0vbWVtb3J5LmM6
MTA2MiBmdW5jOmZvbGlvX3ByZWFsbG9jCj4+ICAtMjMzMjQ3OTQ4OCAxODQ0Njc0NDA3MzcwODk4
MjE2MyBmcy9idHJmcy9leHRlbnRfaW8uYzo2MzUgW2J0cmZzXSBmdW5jOmJ0cmZzX2FsbG9jX3Bh
Z2VfYXJyYXkKPj4KPj4gc29tZSB2YWx1ZXMgYXJlIHdheSB0b28gbGFyZ2UsIHNlZW1zIGxpa2Ug
Y29ycnVwdGVkL3VuaW5pdGlhbGl6ZWQsIGFuZCB2YWx1ZXMgZm9yIGNvbXBhY3Rpb25fYWxsb2MK
Pj4gYXJlIGluY29uc2lzdGVudDogbm9uLXplcm8gc2l6ZSB3aXRoIHplcm8gY291bnQuCj4+Cj4+
IEkgZG8gbm90IGtub3cgd2hlbiB0aG9zZSBkYXRhIGJlY2FtZSB0aGlzIHN0cmFuZ2UsIGFuZCBJ
IGhhdmUgbm90IHJlYm9vdCBteSBzeXN0ZW0geWV0Lgo+PiBEbyB5b3UgZ3V5cyBuZWVkIGV4dHJh
IGluZm9ybWF0aW9uIGJlZm9yZSBJIHJlYm9vdCBteSBzeXN0ZW0gYW5kIHN0YXJ0ZWQgdG8gdHJ5
IHJlcHJvZHVjaW5nPwo+Cj5IaSBEYXZpZCwKPlRoYW5rcyBmb3IgcmVwb3J0aW5nLiBDYW4geW91
IHNoYXJlIHlvdXIgLmNvbmZpZyBmaWxlPyBBbHNvLCBkbyB5b3UKPnNlZSB0aGVzZSBhYm5vcm1h
bCB2YWx1ZXMgc2hvcnRseSBhZnRlciBib290IG9yIGRvZXMgaXQgdGFrZSB0aW1lIGZvcgo+dGhl
bSB0byBnZXQgaW50byBhYm5vcm1hbCBzdGF0ZT8KPkknbGwgdGFrZSBhIGxvb2sgb24gTW9uZGF5
IGFuZCBzZWUgaWYgdGhlcmUgaXMgYW4gb2J2aW91cyBpc3N1ZSBhbmQgaWYKPkkgY2FuIHJlcHJv
ZHVjZSB0aGlzLgo+VGhhbmtzLAo+U3VyZW4uCj4KPj4KPj4KPj4gVGhhbmtzCj4+IERhdmlkCj4+
Cj4+Cj4+Cj4+Cg==

