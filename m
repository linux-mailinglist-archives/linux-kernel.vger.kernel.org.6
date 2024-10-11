Return-Path: <linux-kernel+bounces-361067-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3122599A2FA
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 13:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C6551C2209A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 11:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8BD819CD19;
	Fri, 11 Oct 2024 11:49:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=163.com header.i=@163.com header.b="cKLEi+TV"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC12117D2
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728647397; cv=none; b=TSWoX2+Q8jX4FXrOcIC41n9sdKVFBjx34KIkWmff7E+6Wwi+ChtVFgSLRJfz32GdSIT5P/UqyoyANPC39rUroZn2PPUEnCv2e0ANj/tF2qD/RTktaUJDEnNmDgdzLSt3Umdk3jttg6avI7eeIBwv4ljGvWtfIneJTwHSiKp99FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728647397; c=relaxed/simple;
	bh=7e5/duJT+NlUbtdAqGoquSV6AZtX7Yu7D1uJR0e/ik0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=P/wo6+OC3BdchmV4nzzqj4eYrvNY/56bxDc7aLS/pNVlpDpoa81JDAvXJmXkI1swmb2DBUfs8YH32bFZhqv+FwRij5bw66J5Zjx8tWatY0xwfw8TbPGiGXUnbeVGQseCcThsgnoZ6iKajuI7VZYXYkl7riusc5orwULJi8n2dG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=fail (1024-bit key) header.d=163.com header.i=@163.com header.b=cKLEi+TV reason="signature verification failed"; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
	Message-ID; bh=DQxPvXWSbRTSgtMJ+wSHGcXv/fs3765WiaQG5XrWgcg=; b=c
	KLEi+TVVT4XedAGW9NlD4RcSttrZROYDZHwSNkq7dscT8UG6WrE7d5xIkpPju/Nu
	aX5i3G0nQZPemQzZf4o4z/oqJdvlh8XkfS6isqr0tnoJ9+zf5HmR8Lf2N5vDG9Ys
	KTzauhbhcgMs80bETfkmktaxcp3TsBC8mt9Xz0KmRs=
Received: from xavier_qy$163.com ( [2401:b180:3:2:8665:eaa:8665:eaa] ) by
 ajax-webmail-wmsvr-40-112 (Coremail) ; Fri, 11 Oct 2024 19:48:48 +0800
 (CST)
Date: Fri, 11 Oct 2024 19:48:48 +0800 (CST)
From: Xavier  <xavier_qy@163.com>
To: "Peter Zijlstra" <peterz@infradead.org>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org, 
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com, 
	mgorman@suse.de, vschneid@redhat.com, yu.c.chen@intel.com, 
	linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH v2] sched/eevdf: Reduce the computation frequency of
 avg_vruntime
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20240801(9da12a7b)
 Copyright (c) 2002-2024 www.mailtech.cn 163com
In-Reply-To: <20241011085201.GM17263@noisy.programming.kicks-ass.net>
References: <20240912091454.801033-1-xavier_qy@163.com>
 <20241011062449.998696-1-xavier_qy@163.com>
 <20241011085201.GM17263@noisy.programming.kicks-ass.net>
X-NTES-SC: AL_Qu2ZCvqfuEsp7iSRbOkfmk4aj+k+XsG0vfUj34FWOp9wjDnp0Qk9Um9TL33NwMiDKwKLnQiHaBZu7+dHbZtUQ5o711qc0EKI1sYZB/zrcQ1hXw==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <4fb53053.b004.1927b68f2f8.Coremail.xavier_qy@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID:cCgvCgD3nz6gEAlnRmoLAA--.38784W
X-CM-SenderInfo: 50dyxvpubt5qqrwthudrp/1tbiwh91EGcI5KQ6iwAEsi
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==

CgoKCkF0IDIwMjQtMTAtMTEgMTY6NTI6MDEsICJQZXRlciBaaWpsc3RyYSIgPHBldGVyekBpbmZy
YWRlYWQub3JnPiB3cm90ZToKPk9uIEZyaSwgT2N0IDExLCAyMDI0IGF0IDAyOjI0OjQ5UE0gKzA4
MDAsIFhhdmllciB3cm90ZToKPj4gVGhlIGN1cnJlbnQgY29kZSBzdWJ0cmFjdHMgdGhlIHZhbHVl
IG9mIGN1cnIgZnJvbSBhdmdfdnJ1bnRpbWUgYW5kIGF2Z19sb2FkCj4+IGR1cmluZyBydW50aW1l
LiBUaGVuLCBldmVyeSB0aW1lIGF2Z192cnVudGltZSgpIGlzIGNhbGxlZCwgaXQgYWRkcyB0aGUK
Pj4gdmFsdWUgb2YgY3VyciB0byB0aGUgYXZnX3ZydW50aW1lIGFuZCBhdmdfbG9hZC4gQWZ0ZXJ3
YXJkLCBpdCBkaXZpZGVzIHRoZXNlCj4+IGFuZCBhZGRzIG1pbl92cnVudGltZSB0byBvYnRhaW4g
dGhlIGFjdHVhbCBhdmdfdnJ1bnRpbWUuCj4+IAo+PiBBbmFseXNpcyBvZiB0aGUgY29kZSBpbmRp
Y2F0ZXMgdGhhdCBhdmdfdnJ1bnRpbWUgb25seSBjaGFuZ2VzIHNpZ25pZmljYW50bHkKPj4gZHVy
aW5nIHVwZGF0ZV9jdXJyKCksIHVwZGF0ZV9taW5fdnJ1bnRpbWUoKSwgYW5kIHdoZW4gdGFza3Mg
YXJlIGVucXVldWVkIG9yCj4+IGRlcXVldWVkLiBUaGVyZWZvcmUsIGl0IGlzIHN1ZmZpY2llbnQg
dG8gcmVjYWxjdWxhdGUgYW5kIHN0b3JlIGF2Z192cnVudGltZQo+PiBvbmx5IGluIHRoZXNlIHNw
ZWNpZmljIHNjZW5hcmlvcy4gVGhpcyBvcHRpbWl6YXRpb24gZW5zdXJlcyB0aGF0IGFjY2Vzc2lu
Zwo+PiBhdmdfdnJ1bnRpbWUoKSBkb2VzIG5vdCBuZWNlc3NpdGF0ZSBhIHJlY2FsY3VsYXRpb24g
ZWFjaCB0aW1lLCB0aGVyZWJ5Cj4+IGVuaGFuY2luZyB0aGUgZWZmaWNpZW5jeSBvZiB0aGUgY29k
ZS4KPj4gCj4+IFRoZXJlIGlzIG5vIG5lZWQgdG8gc3VidHJhY3QgY3VycqGvcyBsb2FkIGZyb20g
YXZnX2xvYWQgZHVyaW5nIHJ1bnRpbWUuCj4+IEluc3RlYWQsIHdlIG9ubHkgbmVlZCB0byBjYWxj
dWxhdGUgdGhlIGluY3JlbWVudGFsIGNoYW5nZSBhbmQgdXBkYXRlCj4+IGF2Z192cnVudGltZSB3
aGVuZXZlciBjdXJyoa9zIHRpbWUgaXMgdXBkYXRlZC4KPj4gCj4+IFRvIGJldHRlciByZXByZXNl
bnQgdGhlaXIgZnVuY3Rpb25zLCByZW5hbWUgdGhlIG9yaWdpbmFsIGF2Z192cnVudGltZSBhbmQK
Pj4gYXZnX2xvYWQgdG8gdG90X3ZydW50aW1lIGFuZCB0b3RfbG9hZCwgcmVzcGVjdGl2ZWx5LCB3
aGljaCBtb3JlIGFjY3VyYXRlbHkKPj4gZGVzY3JpYmVzIHRoZWlyIHJvbGVzIGluIHRoZSBjb21w
dXRhdGlvbi4KPj4gCj4+IFNpZ25lZC1vZmYtYnk6IFhhdmllciA8eGF2aWVyX3F5QDE2My5jb20+
Cj4KCj5UaGlzIG1ha2VzIHRoZSBjb2RlIG1vcmUgY29tcGxpY2F0ZWQgZm9yIG5vIHNob3duIGJl
bmVmaXQuCgoKCgpIaSBQZXRlciwKClRoYW5rIHlvdSBmb3IgcmV2aWV3aW5nIHRoaXMgcGF0Y2gu
IEkgd291bGQgbGlrZSB0byBhZGRyZXNzIHlvdXIgcXVlc3Rpb25zIGFzIGZvbGxvd3M6CgpDb2Rl
IENvbXBsZXhpdHkgdnMuIFVuZGVyc3RhbmRhYmlsaXR5OiBJIGFncmVlIHRoYXQgdGhpcyBtb2Rp
ZmljYXRpb24gYWRkcyBzb21lCiBjb21wbGV4aXR5IHRvIHRoZSBjb2RlLCBidXQgdGhlIG1ldGhv
ZCBvZiBjYWxjdWxhdGlvbiBpcyBtb3JlIHN0cmFpZ2h0Zm9yd2FyZC4KIFRoaXMgcGF0Y2ggbWFp
bnRhaW5zIGNvbnNpc3RlbmN5IGluIGhvdyBhdmdfdnJ1bnRpbWUgaXMgYWRkZWQgb3Igc3VidHJh
Y3RlZAogcmVsYXRpdmUgdG8gbG9hZC4gU3BlY2lmaWNhbGx5LCB0aGUgZW5xdWV1ZSBhbmQgZGVx
dWV1ZSBvcGVyYXRpb25zIG9mIHRhc2tzIGRpcmVjdGx5CiBpbXBhY3QgdGhlIGF2Z192cnVudGlt
ZSBvZiBjZnNfcnEsIHdoaWNoIHNlZW1zIGxvZ2ljYWwuCgpFZmZpY2llbmN5IEltcHJvdmVtZW50
czogVGhpcyBhcHByb2FjaCBtaW5pbWl6ZXMgdW5uZWNlc3NhcnkgY2FsY3VsYXRpb25zLAogdGhl
cmVieSBlbmhhbmNpbmcgZXhlY3V0aW9uIGVmZmljaWVuY3kuIEkgdW5kZXJzdGFuZCB0aGF0IGVu
dGl0eV9lbGlnaWJsZSgpIGFuZAogdnJ1bnRpbWVfZWxpZ2libGUoKSBhcmUgaGlnaC1mcmVxdWVu
Y3kgb3BlcmF0aW9ucy4gVGhlIGV4aXN0aW5nIGNvZGUgcmVjYWxjdWxhdGVzCiBjdXJyLT52cnVu
dGltZSBhZGRlZCB0byBjZnNfcnEtPmF2Z192cnVudGltZSBmb3IgZWFjaCBlbGlnaWJpbGl0eSBj
aGVjay4KIElmIG1hbnkgdGFza3MgaW4gdGhlIGNmc19ycSBkbyBub3QgbWVldCB0aGUgY29uZGl0
aW9ucywgaXQgbGVhZHMgdG8gbXVsdGlwbGUKIHJlZHVuZGFudCBjYWxjdWxhdGlvbnMgd2l0aGlu
IHBpY2tfZWV2ZGYoKS4gVGhpcyBwYXRjaCByZXNvbHZlcyB0aGlzIGlzc3VlIGJ5CiBjb21wdXRp
bmcgY2ZzX3JxLT50b3RfdnJ1bnRpbWUgb25seSB3aGVuIGFuIHVwZGF0ZSBpcyBuZWNlc3Nhcnks
IGFsbG93aW5nCiB2cnVudGltZV9lbGlnaWJsZSgpIHRvIHV0aWxpemUgdGhlIHByZWNvbXB1dGVk
IHZhbHVlIGRpcmVjdGx5LgoKUmVkdWNpbmcgYXZnX3ZydW50aW1lIENhbGN1bGF0aW9uczogVGhp
cyBwYXRjaCBhbHNvIHJlZHVjZXMgdGhlIGZyZXF1ZW5jeSBvZgogYXZnX3ZydW50aW1lIGV2YWx1
YXRpb25zLiBUaGUgb3JpZ2luYWwgY29kZSBjYWxscyBhdmdfdnJ1bnRpbWUoKSBldmVyeSB0aW1l
IGl0J3MKIG5lZWRlZCwgZGVzcGl0ZSBtYW55IG9mIHRob3NlIGNhbGxzIGJlaW5nIHJlZHVuZGFu
dCB3aGVuIGN1cnItPnZydW50aW1lCiBoYXNuJ3QgY2hhbmdlZC4gVGhpcyBwYXRjaCBlbnN1cmVz
IHRoYXQgY2ZzX3JxLT5hdmdfdnJ1bnRpbWUgaXMgdXBkYXRlZCBvbmx5CiB3aGVuIGN1cnItPnZy
dW50aW1lIG9yIGNmc19ycS0+dG90X3ZydW50aW1lIGNoYW5nZXMsIGFsbG93aW5nIHN1YnNlcXVl
bnQKIGNhbGxzIHRvIGRpcmVjdGx5IGFjY2VzcyB0aGUgY3VycmVudCB2YWx1ZS4gVGhpcyBncmVh
dGx5IGRlY3JlYXNlcyB0aGUgZnJlcXVlbmN5CiBvZiBhdmdfdnJ1bnRpbWUgY2FsY3VsYXRpb25z
LgoKSSBob3BlIHRoaXMgZXhwbGFuYXRpb24gY2xhcmlmaWVzIHRoZSBiZW5lZml0cyBvZiB0aGUg
cGF0Y2guCiBJIHdlbGNvbWUgYW55IGNvbW1lbnRzIG9yIHN1Z2dlc3Rpb25zLiBUaGFuayB5b3Uh
Cg==

