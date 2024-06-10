Return-Path: <linux-kernel+bounces-208014-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 241B0901F55
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 12:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C00D11F2153A
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 10:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9CC78C6D;
	Mon, 10 Jun 2024 10:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b="hVn0UGjo"
Received: from mout01.posteo.de (mout01.posteo.de [185.67.36.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B231478C68
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718015045; cv=none; b=SR4WmdETsSn7V4RBmbjvfAGaNW4uupnvVq9jOOJopUyA7F1QmN6qnQMkux7qWjcUPwo5VRiXy4ty0CWePI17ePUFBoZKbr+ljMl+lSuyPGY44LuOf/yI3tcHVR+8PasD8uTvHed0DuINC8Lh1CNSem1pg1naU1WX387IuIPGJqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718015045; c=relaxed/simple;
	bh=/dvlPaDX7JS7HUc0xymxE8GPZRJ/dZ9lSf050PDmGgg=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ppnKQnJZdrdmjiuB7qQW0bwbLmx8ecvpmvPp//YgMS99zuBIH1uVy9gPT8ixbR0kMyEPDeJs3lF7isEAHTe918Malg3R63kxbpFh+HsJ7hr/A4gc/rf7fLe9zEtRyVHkfQYPOFdcaqnJP0YKnsMYvIaGbbWIqytgLVyaBwB9P0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de; spf=pass smtp.mailfrom=posteo.de; dkim=pass (2048-bit key) header.d=posteo.de header.i=@posteo.de header.b=hVn0UGjo; arc=none smtp.client-ip=185.67.36.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.de
Received: from submission (posteo.de [185.67.36.169]) 
	by mout01.posteo.de (Postfix) with ESMTPS id 7ED4D240028
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 12:17:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
	t=1718014679; bh=/dvlPaDX7JS7HUc0xymxE8GPZRJ/dZ9lSf050PDmGgg=;
	h=Message-ID:Subject:From:To:Date:Content-Type:
	 Content-Transfer-Encoding:MIME-Version:From;
	b=hVn0UGjoEIWpc28KZUIuvmIHaQbdQaEf3UKUxFL+kKAtBKX0YufCaSqfPQW38hMc7
	 E+g3jfDEKiWm2aMQUGqxcAbNSwO3UNe+y3qMYmx2IGwpJrS+EAEHId9ptYHW6ny4tb
	 9fLSMosWMplnFr8b8EGb97nKQPL184qNrgRBHIhTMhnwWJ1cJykCFkl5HUW+uKvm2G
	 d+cIUN6ms9YrBeEs/l0VJxypPTcnpINuU/jJNm8uhy4Tn0VG0863uWyAbKxb6YDalk
	 4Q5BorAp1mpG7Co5wlLlWgS58BPptqWFZ8YjlxOc7dB4uF6X2uCrdkW/IPksgtYYXh
	 jW70aQ438k0xg==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4VySRl4VHgz6tvp;
	Mon, 10 Jun 2024 12:17:55 +0200 (CEST)
Message-ID: <6cc32fceb4d74833e045e0acbc51515b5ef3065b.camel@posteo.de>
Subject: Re: [PATCH] dts: imx8mq-librem5: Don't wake up on volume key press
From: Martin Kepplinger <martink@posteo.de>
To: Guido =?ISO-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer
 <s.hauer@pengutronix.de>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, devicetree@vger.kernel.org,
 imx@lists.linux.dev,  linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,  phone-devel@vger.kernel.org, kernel@puri.sm
Date: Mon, 10 Jun 2024 10:17:55 +0000
In-Reply-To: <fa416916049e85ca159805e8602fa8361d5e6d83.1716202515.git.agx@sigxcpu.org>
References: 
	<fa416916049e85ca159805e8602fa8361d5e6d83.1716202515.git.agx@sigxcpu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

QW0gTW9udGFnLCBkZW0gMjAuMDUuMjAyNCB1bSAxMjo1NyArMDIwMCBzY2hyaWViIEd1aWRvIEfD
vG50aGVyOgo+IFRoZSBvbmx5IGtleSB0aGF0IHNob3VsZCB3YWtlIHVwIHRoZSBwaG9uZSBpcyBw
b3dlciBidXR0b24gcHJlc3MuCj4gVGhpcwo+IHByZXZlbnRzIGFjY2lkZW50YWwgd2FrZXVwIGR1
ZSB0byBlLmcuIHByZXNzaW5nIHRoZSBidXR0b25zIGluIHRoZQo+IHBvY2tldCBvciBiYWNrcGFj
ayBhbmQgaXMgaW4gbGluZSB3aGF0IHVzZXJzcGFjZSB1c2VzIHRvIHVuYmxhbmsgdGhlCj4gZGV2
aWNlLgo+IAo+IFNpZ25lZC1vZmYtYnk6IEd1aWRvIEfDvG50aGVyIDxhZ3hAc2lneGNwdS5vcmc+
CgpSZXZpZXdlZC1ieTogTWFydGluIEtlcHBsaW5nZXIgPG1hcnRpbmtAcG9zdGVvLmRlPgoKdGhh
bmsgeW91LAoKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWFydGluCgo+IC0tLQo+IMKg
YXJjaC9hcm02NC9ib290L2R0cy9mcmVlc2NhbGUvaW14OG1xLWxpYnJlbTUuZHRzaSB8IDIgLS0K
PiDCoDEgZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9hcmNo
L2FybTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEtbGlicmVtNS5kdHNpCj4gYi9hcmNoL2Fy
bTY0L2Jvb3QvZHRzL2ZyZWVzY2FsZS9pbXg4bXEtbGlicmVtNS5kdHNpCj4gaW5kZXggZmZiNWZl
NjE2MzBkLi4xYjM5NTE0ZDVjMTIgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9hcm02NC9ib290L2R0cy9m
cmVlc2NhbGUvaW14OG1xLWxpYnJlbTUuZHRzaQo+ICsrKyBiL2FyY2gvYXJtNjQvYm9vdC9kdHMv
ZnJlZXNjYWxlL2lteDhtcS1saWJyZW01LmR0c2kKPiBAQCAtNDUsNyArNDUsNiBAQCBrZXktdm9s
LWRvd24gewo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oGdwaW9zID0gPCZncGlvMSAxNyBHUElPX0FDVElWRV9MT1c+Owo+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGxpbnV4LGNvZGUgPSA8S0VZX1ZPTFVNRURP
V04+Owo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGRl
Ym91bmNlLWludGVydmFsID0gPDUwPjsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHdha2V1cC1zb3VyY2U7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqB9Owo+IMKgCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBrZXktdm9s
LXVwIHsKPiBAQCAtNTMsNyArNTIsNiBAQCBrZXktdm9sLXVwIHsKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBncGlvcyA9IDwmZ3BpbzEgMTYgR1BJT19B
Q1RJVkVfTE9XPjsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBsaW51eCxjb2RlID0gPEtFWV9WT0xVTUVVUD47Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgZGVib3VuY2UtaW50ZXJ2YWwgPSA8NTA+Owo+IC3C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgd2FrZXVwLXNvdXJj
ZTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoH07Cj4gwqDCoMKgwqDCoMKgwqDC
oH07Cj4gwqAKCg==


