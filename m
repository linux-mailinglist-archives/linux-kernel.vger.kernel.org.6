Return-Path: <linux-kernel+bounces-429400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EBE359E1B96
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 13:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52768167321
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 12:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07EA1E048B;
	Tue,  3 Dec 2024 12:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="Dcx9VSaq"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4291E47C5
	for <linux-kernel@vger.kernel.org>; Tue,  3 Dec 2024 12:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733227301; cv=none; b=jHmhP5jF5SgDFAwIy0D/qkzjp//D3wk9cMBOM4g0iDgtKB/gLWZrvtmHz5OYOMJlCzWBX2xHQOyExx3S/ax5braYS+juei/5417RtYF8XXro6vWbE37RLfkaoxspIFB0ThrGuE68nubAdt+yq6ctZER15v8BPqrzmmSvd2RuwzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733227301; c=relaxed/simple;
	bh=iJxc42LLEnsp7NC1P05klesob4+kVJ9rCRAzyVa43co=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=O/J8o96rgo5EhaU+rRCCt7a1EOanyMNZu2ZkL/0qqXQz9rG8elQNlkb91Q/4cSJ653iCR8Il6fJ6/0TLwb0g9VmOwImJ2rgp0zhV1wbTCDGdqo67yyPz7JT6+ectGNad0abDktLmlTNi2BChx4HUUXmgPBrOEi2HIlL1fSol/m4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=Dcx9VSaq reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=H0bu45Mc6gc8+B92g5iU4Bt7ygTtewBOm0ghqDP/8uw=; b=D
	cx9VSaqYlVOIt+B3XHjY871Y3A9m5SkuD2p9pK2Ab4DnI/Y5ecdNPx3sifVzjxI5
	hMsv8zdxKvW6eLRNwoqq+s6XzlnzfvYddRVHXCT4v1R1CgYFs5o0Kk01131lL1o9
	/ZA1MrxvN7MDjwE3Juxz+Oe3x8rhKcCblrAXS9ko/0=
Received: from 00107082$163.com ( [111.35.188.140] ) by
 ajax-webmail-wmsvr-40-132 (Coremail) ; Tue, 3 Dec 2024 20:00:58 +0800 (CST)
Date: Tue, 3 Dec 2024 20:00:58 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Thomas Gleixner" <tglx@linutronix.de>
Cc: kees@kernel.org, linux-kernel@vger.kernel.org, geert@linux-m68k.org
Subject: Re: [PATCH 2/3] irqchip: Fix a potential abuse of seq_printf()
 format string
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <87ttblt3i1.ffs@tglx>
References: <505e5950dd2d76e6c3a8af57bc0cd1e0fbf2b637.1732093745.git.00107082@163.com>
 <762e88c3e940bd6087c35b599f2c88baff775c6b.1732093745.git.00107082@163.com>
 <87ttblt3i1.ffs@tglx>
X-NTES-SC: AL_Qu2YAf6ZuEou7imeZOkZnEYQheY4XMKyuPkg1YJXOp80myXs8SwnbG5KN3/M/PmkKTmmoQm1bQl8zP94WK5JTbn4A4z4GB3+1bma/oMT8RnK
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <731ed569.b3e4.1938c652457.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:hCgvCgD3_6D78k5nYnE4AA--.24909W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqQaqqmdO58c11gADsG
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjQtMTItMDMgMTk6MjI6NDYsICJUaG9tYXMgR2xlaXhuZXIiIDx0Z2x4QGxpbnV0cm9u
aXguZGU+IHdyb3RlOgo+T24gV2VkLCBOb3YgMjAgMjAyNCBhdCAxNzoxNywgRGF2aWQgV2FuZyB3
cm90ZToKPj4gVXNpbmcgZGV2aWNlIG5hbWUgYXMgZm9ybWF0IHN0cmluZyBvZiBzZXFfcHJpbnRm
KCkgaXMgcHJvbmUgdG8KPj4gIkZvcm1hdCBzdHJpbmcgYXR0YWNrIiwgb3BlbnMgcG9zc2liaWxp
dHkgZm9yIGV4cGxvaXRhdGlvbi4KPj4gU2VxX3B1dHMoKSBpcyBzYWZlciBhbmQgbW9yZSBlZmZp
Y2llbnQuCj4KPkkgYWdyZWUgdGhhdCBzZXFfcHV0cygpIGlzIG1vcmUgZWZmaWNpZW50LCBidXQg
dGhpcyB3aG9sZSBoYW5kd2F2aW5nCj5hYm91dCBmb3JtYXQgc3RyaW5nIGF0dGFja3MgaXMgZmFy
IGZldGNoZWQuCj4KPlRoZXNlIHN0cmluZ3Mgb3JpZ2luYXRlIGZyb20gZGV2aWNlIHRyZWUgb3Ig
Z2VuZXJhdGVkIGRldmljZS9kb21haW4KPm5hbWVzLiBJZiB0aGV5IGNvbnRhaW4gZm9ybWF0IHN0
cmluZ3MsIHRoZW4gdGhhdCdzIGVpdGhlciBhIHBsYWluIGJ1ZyBpbgo+dGhlIGtlcm5lbCBvciB0
aGUgZGV2aWNlIHRyZWUsIGJ1dCBmYXIgZnJvbSBhICdmb3JtYXQgc3RyaW5nIGF0dGFjaycuCgpJ
c24ndCBpdCBwb3NzaWJsZSB0byBjaGFuZ2UgZGV2aWNlIG5hbWU/ICBUaGUgd2F5IEkgaW1hZ2Ug
aXQsICBpZiAgc29tZSBsb3ctcHJpdmlsZWdlZCBpbnRlcmZhY2UgY2FuCmJlIHVzZWQgdG8gY2hh
bmdlIGRldmljZSBuYW1lLCAgKG1heWJlIHNvbWUgYmFja2Rvb3IgaW4gdGhlIGRldmljZSBmaXJt
d2FyZSkKdGhlbiByZWFkaW5nIC9wcm9jLy4uLiBjb3VsZCBiZSB1c2VkIGJ5IGxvdy1wcml2aWxl
Z2VkIHVzZXIgdG8gZ2FpbiBtb3JlIGluZm9ybWF0aW9uLiAKCkFuZCB5ZXMsIEl0IGlzIGFsbCB0
aGVvcmV0aWNhbC4KCgoKVGhhbmtzCkRhdmlkCg==

