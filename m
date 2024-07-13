Return-Path: <linux-kernel+bounces-251328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D56DF930397
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 05:38:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC3321C212CC
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 03:38:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B6DB175BF;
	Sat, 13 Jul 2024 03:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="SrAjue6k"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C1723DE
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 03:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720841896; cv=none; b=K8ZBry0i19JSLoNxtYzLp5WbDudS0Q94cHRl/Z+fMBO3K8qcm4T3SHmRqNSB50M7riFZlnhmm3keF1RO5ZsOiNU0Gme1nqBxMeXzBtmnVBCQU9tjkjpj+G63TT6Ujt40Vee9ymgNux0JP/mF5gzzfPZBryETGw77+GcLDWWg5WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720841896; c=relaxed/simple;
	bh=kb0nblp8fXsVUi0ddRynguPkLG60RLpS7H8MAz9cjKM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=sle6uOZO3ZcBy7jjnimJFOaghVeOClO7J7rkooY41OzhwkJmJK2rzLeWf4qDA0dR2YWIoqr0iNQWfxPOQaNIAdEugpeKGW9skvTQjyvqlBVCBepEVmq8+5gjGoxqy8MdgoMRbRDQdIjHTG6MDBtX0U4ilPS+TgIxi5/fOBVkGMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=SrAjue6k reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=2FE2xnvxR/iLNMTwXXlYBVpW8aPIqjyFYqmSmT3PNEI=; b=S
	rAjue6kZt/XSs734WkTE1A9mp0kv7jB5MBIfQ7MsJ2QJ2MnMLyoptJAQwBmVuhLJ
	qWqc4uONISiSOpHfw9sKTMEuVrzElhY6UwhnI22W7Asfp1/Lqnt/1Karpe4L2dzL
	SM2tc+xacJuIejal4XmN2Vv0UdRYg8jTHB8GuAjuv4=
Received: from 00107082$163.com ( [111.35.186.71] ) by
 ajax-webmail-wmsvr-40-143 (Coremail) ; Sat, 13 Jul 2024 11:36:33 +0800
 (CST)
Date: Sat, 13 Jul 2024 11:36:33 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Peter Xu" <peterx@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	"Andrew Morton" <akpm@linux-foundation.org>, 
	"Alex Williamson" <alex.williamson@redhat.com>, 
	"Jason Gunthorpe" <jgg@nvidia.com>, 
	"Al Viro" <viro@zeniv.linux.org.uk>, 
	"Dave Hansen" <dave.hansen@linux.intel.com>, 
	"Andy Lutomirski" <luto@kernel.org>, 
	"Peter Zijlstra" <peterz@infradead.org>, 
	"Thomas Gleixner" <tglx@linutronix.de>, 
	"Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>, 
	"Kirill A . Shutemov" <kirill@shutemov.name>, x86@kernel.org, 
	"Yan Zhao" <yan.y.zhao@intel.com>, 
	"Kevin Tian" <kevin.tian@intel.com>, "Pei Li" <peili.dev@gmail.com>, 
	"David Hildenbrand" <david@redhat.com>, 
	"Bert Karwatzki" <spasswolf@web.de>, 
	"Sergey Senozhatsky" <senozhatsky@chromium.org>
Subject: Re:[PATCH] mm/x86/pat: Only untrack the pfn range if unmap region
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <20240712144244.3090089-1-peterx@redhat.com>
References: <20240712144244.3090089-1-peterx@redhat.com>
X-NTES-SC: AL_Qu2ZAvSfvk8i5SGebOkXn0oTju85XMCzuv8j3YJeN500tybIyDshVFZ+JEPX18K2Gy2CmTGwahRl2tZTVLVAZKJI9hgEUWQCWE8//0DZVPH6
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <52fcc0ec.10f1.190aa29ee98.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:_____wDXvwBC9pFmqvouAA--.37160W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbB0gkbqmWXy+UlmwADsL
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkhpLAoKQXQgMjAyNC0wNy0xMiAyMjo0Mjo0NCwgIlBldGVyIFh1IiA8cGV0ZXJ4QHJlZGhhdC5j
b20+IHdyb3RlOgo+Cj5OT1RFOiBJIG1hc3NhZ2VkIHRoZSBjb21taXQgbWVzc2FnZSBjb21wYXJp
bmcgdG8gdGhlIHJmYyBwb3N0IFsxXSwgdGhlCj5wYXRjaCBpdHNlbGYgaXMgdW50b3VjaGVkLiAg
QWxzbyByZW1vdmVkIHJmYyB0YWcsIGFuZCBhZGRlZCBtb3JlIHBlb3BsZQo+aW50byB0aGUgbG9v
cC4gUGxlYXNlIGtpbmRseSBoZWxwIHRlc3QgdGhpcyBwYXRjaCBpZiB5b3UgaGF2ZSBhIHJlcHJv
ZHVjZXIsCj5hcyBJIGNhbid0IHJlcHJvZHVjZSBpdCBteXNlbGYgZXZlbiB3aXRoIHRoZSBzeXpi
b3QgcmVwcm9kdWNlciBvbiB0b3Agb2YKPm1tLXVuc3RhYmxlLiAgSW5zdGVhZCBvZiBmdXJ0aGVy
IGNoZWNrIG9uIHRoZSByZXByb2R1Y2VyLCBJIGRlY2lkZWQgdG8gc2VuZAo+dGhpcyBvdXQgZmly
c3QgYXMgd2UgaGF2ZSBhIGJ1bmNoIG9mIHJlcHJvZHVjZXJzIG9uIHRoZSBsaXN0IG5vdy4uCj4t
LS0KPiBtbS9tZW1vcnkuYyB8IDUgKystLS0KPiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQo+Cj5kaWZmIC0tZ2l0IGEvbW0vbWVtb3J5LmMgYi9tbS9tZW1v
cnkuYwo+aW5kZXggNGJjZDc5NjE5NTc0Li5mNTdjYzMwNGIzMTggMTAwNjQ0Cj4tLS0gYS9tbS9t
ZW1vcnkuYwo+KysrIGIvbW0vbWVtb3J5LmMKPkBAIC0xODI3LDkgKzE4MjcsNiBAQCBzdGF0aWMg
dm9pZCB1bm1hcF9zaW5nbGVfdm1hKHN0cnVjdCBtbXVfZ2F0aGVyICp0bGIsCj4gCWlmICh2bWEt
PnZtX2ZpbGUpCj4gCQl1cHJvYmVfbXVubWFwKHZtYSwgc3RhcnQsIGVuZCk7Cj4gCj4tCWlmICh1
bmxpa2VseSh2bWEtPnZtX2ZsYWdzICYgVk1fUEZOTUFQKSkKPi0JCXVudHJhY2tfcGZuKHZtYSwg
MCwgMCwgbW1fd3JfbG9ja2VkKTsKPi0KPiAJaWYgKHN0YXJ0ICE9IGVuZCkgewo+IAkJaWYgKHVu
bGlrZWx5KGlzX3ZtX2h1Z2V0bGJfcGFnZSh2bWEpKSkgewo+IAkJCS8qCj5AQCAtMTg5NCw2ICsx
ODkxLDggQEAgdm9pZCB1bm1hcF92bWFzKHN0cnVjdCBtbXVfZ2F0aGVyICp0bGIsIHN0cnVjdCBt
YV9zdGF0ZSAqbWFzLAo+IAkJdW5zaWduZWQgbG9uZyBzdGFydCA9IHN0YXJ0X2FkZHI7Cj4gCQl1
bnNpZ25lZCBsb25nIGVuZCA9IGVuZF9hZGRyOwo+IAkJaHVnZXRsYl96YXBfYmVnaW4odm1hLCAm
c3RhcnQsICZlbmQpOwo+KwkJaWYgKHVubGlrZWx5KHZtYS0+dm1fZmxhZ3MgJiBWTV9QRk5NQVAp
KQo+KwkJCXVudHJhY2tfcGZuKHZtYSwgMCwgMCwgbW1fd3JfbG9ja2VkKTsKPiAJCXVubWFwX3Np
bmdsZV92bWEodGxiLCB2bWEsIHN0YXJ0LCBlbmQsICZkZXRhaWxzLAo+IAkJCQkgbW1fd3JfbG9j
a2VkKTsKPiAJCWh1Z2V0bGJfemFwX2VuZCh2bWEsICZkZXRhaWxzKTsKPi0tIAo+Mi40NS4wCgpJ
IGFwcGx5IHRoaXMgcGF0Y2ggb24gNi4xMC4wLXJjNywgYW5kIGNvbmZpcm1lZCB0aGF0IG5vIGtl
cm5lbCB3YXJuaW5nIHNob3dzIHVwIHdoZW4gSSBzdXNwZW5kIG15IHN5c3RlbSh3aXRoIG52aWRp
YSBHUFUpLApBZnRlciBzZXZlcmFsIHJvdW5kIG9mIHN1c3BlbmQvcmVzdW1lIGN5Y2xlLCBubyBl
cnJvci93YXJuaW5nIG9ic2VydmVkIGluIGtlcm5lbCBsb2cuCgpUaGFua3MKRGF2aWQK

