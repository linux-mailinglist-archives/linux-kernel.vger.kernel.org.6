Return-Path: <linux-kernel+bounces-426000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075BD9DEDA1
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Nov 2024 00:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD960281A32
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 23:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55F3B19924E;
	Fri, 29 Nov 2024 23:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="a5ZOZy5Y"
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AAF215530F
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 23:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732923978; cv=none; b=eKd38s7jDc8CsYfF6mPCS7PJu0nwiDyIWBzhcEOWCWYO21Y9idiSug5qShDfvyWO5e73b+Fa5/wiT/JgdkIW29DX2ybW1h7uqGBjf6VZgfBGYY5dZHJX6Ou1TLrz+V6Y/GZxCM6JYfjxearSJ91SrjwNP521khdIVPNenoP+kv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732923978; c=relaxed/simple;
	bh=vu5slV3Dzqv2bDCcUQLGvQ9NsueK3d19aT2Nsr0peE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=sDID2cXe+svhju0Oq9qmJKJMtYNOxZHwFO7xt1aHrjIjexXE775gst91WSej+MDbdMqwoCztAfuoTAWJ8TeTFVTaJ5yokfYOjLYO+Fops85TRHWdmMSLqLyXJMBlu6qlw0SaBMtE8MSmBXrPNfQLVP1J/l4OxlqJNilglqrymGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=a5ZOZy5Y reason="signature verification failed"; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=ltMLdp7Z9cqa4Onv8tqtPk31HdHX0E+pzClJs46FE3U=; b=a
	5ZOZy5YncPpsOHFr8ZnxASYn7mDAJ1TLZlcPVJJOfl+uwRhrb75TdwvhvQ6DrO4v
	zns9HyMbBtTGx8HC0VlcUN0jAenU1X74w5HcHP3D+NI7afB9xnrmNnMRm1nAm3MD
	BEmM7WqFyh5WrlHT9PV1DwofLG2HmAEM46wgXi5srQ=
Received: from 00107082$163.com ( [111.35.188.140] ) by
 ajax-webmail-wmsvr-40-122 (Coremail) ; Sat, 30 Nov 2024 07:43:38 +0800
 (CST)
Date: Sat, 30 Nov 2024 07:43:38 +0800 (CST)
From: "David Wang" <00107082@163.com>
To: "Suren Baghdasaryan" <surenb@google.com>
Cc: yuzhao@google.com, kent.overstreet@linux.dev, akpm@linux-foundation.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/codetag: swap tags when migrate pages
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <CAJuCfpGxU8u4X0x1n3Sen206Xpi1ubBK2gyCgYinPV_NFFJNPw@mail.gmail.com>
References: <20241128102619.707071-1-00107082@163.com>
 <20241129025213.34836-1-00107082@163.com>
 <CAJuCfpGxU8u4X0x1n3Sen206Xpi1ubBK2gyCgYinPV_NFFJNPw@mail.gmail.com>
X-NTES-SC: AL_Qu2YAPWZvEAq7iWZZ+kXn0oTju85XMCzuv8j3YJeN500qSTc3B8KbG5oJ1bH/PmJOz+moQm3eTJJ1dZWeKp+dKIEcVw6WUBERC050YkuxBjB
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <3a513838.11a.1937a4f0215.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:eigvCgDXn0OrUUpnxokzAA--.4871W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiqROmqmdKQ6I7EwAEsW
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CkF0IDIwMjQtMTEtMzAgMDY6NTk6MjYsICJTdXJlbiBCYWdoZGFzYXJ5YW4iIDxzdXJlbmJAZ29v
Z2xlLmNvbT4gd3JvdGU6Cj5PbiBUaHUsIE5vdiAyOCwgMjAyNCBhdCA2OjUy4oCvUE0gRGF2aWQg
V2FuZyA8MDAxMDcwODJAMTYzLmNvbT4gd3JvdGU6Cj4+Cj4+IEN1cnJlbnQgc29sdXRpb24gdG8g
YWRqdXN0IGNvZGV0YWcgcmVmZXJlbmNlcyBkdXJpbmcgcGFnZSBtaWdyYXRpb24gaXMKPj4gZG9u
ZSBpbiAzIHN0ZXBzOgo+PiAxLiBzZXRzIHRoZSBjb2RldGFnIHJlZmVyZW5jZSBvZiB0aGUgb2xk
IHBhZ2UgYXMgZW1wdHkgKG5vdCBwb2ludGluZwo+PiB0byBhbnkgY29kZXRhZyk7Cj4+IDIuIHN1
YnRyYWN0cyBjb3VudGVycyBvZiB0aGUgbmV3IHBhZ2UgdG8gY29tcGVuc2F0ZSBmb3IgaXRzIG93
biBhbGxvY2F0aW9uOwo+PiAzLiBzZXRzIGNvZGV0YWcgcmVmZXJlbmNlIG9mIHRoZSBuZXcgcGFn
ZSB0byBwb2ludCB0byB0aGUgY29kZXRhZyBvZgo+PiB0aGUgb2xkIHBhZ2UuCj4+IFRoaXMgZG9l
cyBub3Qgd29yayBpZiBDT05GSUdfTUVNX0FMTE9DX1BST0ZJTElOR19ERUJVRz1uIGJlY2F1c2UK
Pj4gc2V0X2NvZGV0YWdfZW1wdHkoKSBiZWNvbWVzIE5PT1AuIEluc3RlYWQsIGxldCdzIHNpbXBs
eSBzd2FwIGNvZGV0YWcKPj4gcmVmZXJlbmNlcyBzbyB0aGF0IHRoZSBuZXcgcGFnZSBpcyByZWZl
cmVuY2luZyB0aGUgb2xkIGNvZGV0YWcgYW5kIHRoZQo+PiBvbGQgcGFnZSBpcyByZWZlcmVuY2lu
ZyB0aGUgbmV3IGNvZGV0YWcuIFRoaXMgd2F5IGFjY291bnRpbmcgc3RheXMKPj4gdmFsaWQgYW5k
IHRoZSBsb2dpYyBtYWtlcyBtb3JlIHNlbnNlLgo+Pgo+PiBGaXhlczogZTBhOTU1YmY3ZjYxICgi
bW0vY29kZXRhZzogYWRkIHBnYWxsb2NfdGFnX2NvcHkoKSIpCj4+IFNpZ25lZC1vZmYtYnk6IERh
dmlkIFdhbmcgPDAwMTA3MDgyQDE2My5jb20+Cj4+IENsb3NlczogaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGttbC8yMDI0MTEyNDA3NDMxOC4zOTkwMjctMS0wMDEwNzA4MkAxNjMuY29tLwo+PiBB
Y2tlZC1ieTogU3VyZW4gQmFnaGRhc2FyeWFuIDxzdXJlbmJAZ29vZ2xlLmNvbT4KPj4gU3VnZ2Vz
dGVkLWJ5OiBTdXJlbiBCYWdoZGFzYXJ5YW4gPHN1cmVuYkBnb29nbGUuY29tPgo+Cj5UaGFua3Mh
IFRoaXMgbG9va3MgZmluZSB0byBtZSBidXQgSUlSQyBJIGRpZCBub3QgQWNrIHRoaXMgcGF0Y2gK
ClNvcnJ5LCBJIGFtIGtpbmQgb2YgbmV3IHRvIHRoZSBrZXJuZWwgZGV2ZWxvcG1lbnQgcHJvY2Vz
cywgc3RpbGwgY2F0Y2hpbmcgdXAuIAoKPmJlZm9yZS4gSW4gdGhlIGZ1dHVyZSBwbGVhc2UgZG8g
bm90IGFkZCBBY2tlZC1ieSB1bnRpbCB5b3UgZ2V0IGFuCj5leHBsaWNpdCBBY2suIFRoYXQgc2Fp
ZCwKClJvZ2VyIHRoYXR+Ckkgd2FzIHdvbmRlcmluZyB3aGVuICJBY2tlZC1ieX4gb3IgIlJyZXZp
ZXdkLWJ5IiB3ZXJlIGFkZGVkIGluIG90aGVyIGNvbW1pdHMuIE5vdyBJIHVuZGVyc3RhbmQsCkkg
YW0gbm90IHN1cHBvc2VkIHRvIGRvIHRoYXQuIAoKClRoYW5rcwpEYXZpZAoKPgoK

