Return-Path: <linux-kernel+bounces-237678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85A7F923C91
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 13:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 135811F22C2F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 11:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623A215B964;
	Tue,  2 Jul 2024 11:38:47 +0000 (UTC)
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45EC15B141
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 11:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719920326; cv=none; b=jjbSAhMLbH3B3a6gVf/06P66A8JuMj+CLDwj1/jmGytXBwoOJSiAQP336j1Ow2j0JIhF8+BwjZOmfg48mfqL+yd5xcl7gMk2ImotQW/z5Z4hK4eFpnqJKOgvGyHnpcLYsHQEG2ZkKrVqYTnDjhTwAPKeIGl9eNyOkVb62OwEPDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719920326; c=relaxed/simple;
	bh=w91PtldaYqwlZMpVaIgX86Ekf+PI8ibaWz+UOBY/lrQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:Content-Type:
	 MIME-Version:Message-ID; b=SI5uV4yWv/nzjKjVD81zzc9pYE9S17gbOA+xYjsDb2ZpQDW2rVWGO7hK+08VqJYYjKM2N2y8+XeBEHkEIJQ4r3907bvcnU5nkshBqcSPCFCiJ3SkjO5MHqqfkIHakJhe29AjsFarGa+Vxtc9R9sDTjpZx4mknXzP8Ym4WwCaSHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WD1BW3pwVz4f3jMh
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 19:38:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B0DD41A0170
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 19:38:38 +0800 (CST)
Received: by ajax-webmail-APP4 (Coremail) ; Tue, 2 Jul 2024 19:38:37 +0800
 (GMT+08:00)
Date: Tue, 2 Jul 2024 19:38:37 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From: yangyingliang@huaweicloud.com
To: "Peter Zijlstra" <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, mingo@redhat.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, 
	rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de, 
	bristot@redhat.com, vschneid@redhat.com, tglx@linutronix.de, 
	yu.c.chen@intel.com, tim.c.chen@linux.intel.com, 
	yangyingliang@huawei.com, liwei391@huawei.com
Subject: Re: [PATCH resend] sched/smt: fix unbalance sched_smt_present
 dec/inc
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.13 build 20240430(4a1815f4)
 Copyright (c) 2002-2024 www.mailtech.cn
 mispb-afc14d85-da06-4a9c-b40d-9d3adbbd040a-huawei.com
In-Reply-To: <20240702084418.GB11386@noisy.programming.kicks-ass.net>
References: <20240702081128.4008011-1-yangyingliang@huaweicloud.com>
 <20240702084418.GB11386@noisy.programming.kicks-ass.net>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <5fce12a8.c23.190733d53e9.Coremail.yangyingliang@huaweicloud.com>
X-Coremail-Locale: en_US
X-CM-TRANSID:gCh0CgBHTfa+5oNmMuTLAw--.3796W
X-CM-SenderInfo: 51dqw5xlqjzxhdqjqx5xdzvxpfor3voofrz/1tbiAQAMEF1jkIFIF
	gAAss
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3GIAIbVAYFVCjjxCrMI
	AIbVAFxVCF77xC64kEw24lV2xY67C26IkvcIIF6IxKo4kEV4DvcSsGvfC2KfnxnUU==

CgoKJmd0OyAtLS0tLU9yaWdpbmFsIE1lc3NhZ2VzLS0tLS0KJmd0OyBGcm9tOiAiUGV0ZXIgWmlq
bHN0cmEiIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4KJmd0OyBTZW50IFRpbWU6IDIwMjQtMDctMDIg
MTY6NDQ6MTggKFR1ZXNkYXkpCiZndDsgVG86ICJZYW5nIFlpbmdsaWFuZyIgPHlhbmd5aW5nbGlh
bmdAaHVhd2VpY2xvdWQuY29tPgomZ3Q7IENjOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3Jn
LCBtaW5nb0ByZWRoYXQuY29tLCBqdXJpLmxlbGxpQHJlZGhhdC5jb20sIHZpbmNlbnQuZ3VpdHRv
dEBsaW5hcm8ub3JnLCBkaWV0bWFyLmVnZ2VtYW5uQGFybS5jb20sIHJvc3RlZHRAZ29vZG1pcy5v
cmcsIGJzZWdhbGxAZ29vZ2xlLmNvbSwgbWdvcm1hbkBzdXNlLmRlLCBicmlzdG90QHJlZGhhdC5j
b20sIHZzY2huZWlkQHJlZGhhdC5jb20sIHRnbHhAbGludXRyb25peC5kZSwgeXUuYy5jaGVuQGlu
dGVsLmNvbSwgdGltLmMuY2hlbkBsaW51eC5pbnRlbC5jb20sIHlhbmd5aW5nbGlhbmdAaHVhd2Vp
LmNvbSwgbGl3ZWkzOTFAaHVhd2VpLmNvbQomZ3Q7IFN1YmplY3Q6IFJlOiBbUEFUQ0ggcmVzZW5k
XSBzY2hlZC9zbXQ6IGZpeCB1bmJhbGFuY2Ugc2NoZWRfc210X3ByZXNlbnQgZGVjL2luYwomZ3Q7
IAomZ3Q7IE9uIFR1ZSwgSnVsIDAyLCAyMDI0IGF0IDA0OjExOjI4UE0gKzA4MDAsIFlhbmcgWWlu
Z2xpYW5nIHdyb3RlOgomZ3Q7ICZndDsgRnJvbTogWWFuZyBZaW5nbGlhbmcgPHlhbmd5aW5nbGlh
bmdAaHVhd2VpLmNvbT4KJmd0OyAmZ3Q7IAomZ3Q7ICZndDsgSSBnb3QgdGhlIGZvbGxvd2luZyB3
YXJuIHJlcG9ydCB3aGlsZSBkb2luZyBzdHJlc3MgdGVzdDoKJmd0OyAmZ3Q7IAomZ3Q7ICZndDsg
anVtcCBsYWJlbDogbmVnYXRpdmUgY291bnQhCiZndDsgJmd0OyBXQVJOSU5HOiBDUFU6IDMgUElE
OiAzOCBhdCBrZXJuZWwvanVtcF9sYWJlbC5jOjI2MyBzdGF0aWNfa2V5X3Nsb3dfdHJ5X2RlYysw
eDlkLzB4YjAKJmd0OyAmZ3Q7IENhbGwgVHJhY2U6CiZndDsgJmd0OyAgPHRhc2s+CiZndDsgJmd0
OyAgX19zdGF0aWNfa2V5X3Nsb3dfZGVjX2NwdXNsb2NrZWQrMHgxNi8weDcwCiZndDsgJmd0OyAg
c2NoZWRfY3B1X2RlYWN0aXZhdGUrMHgyNmUvMHgyYTAKJmd0OyAmZ3Q7ICBjcHVocF9pbnZva2Vf
Y2FsbGJhY2srMHgzYWQvMHgxMGQwCiZndDsgJmd0OyAgY3B1aHBfdGhyZWFkX2Z1bisweDNmNS8w
eDY4MAomZ3Q7ICZndDsgIHNtcGJvb3RfdGhyZWFkX2ZuKzB4NTZkLzB4OGQwCiZndDsgJmd0OyAg
a3RocmVhZCsweDMwOS8weDQwMAomZ3Q7ICZndDsgIHJldF9mcm9tX2ZvcmsrMHg0MS8weDcwCiZn
dDsgJmd0OyAgcmV0X2Zyb21fZm9ya19hc20rMHgxYi8weDMwCiZndDsgJmd0OyAgPC90YXNrPgom
Z3Q7ICZndDsgCiZndDsgJmd0OyBCZWNhdXNlIHdoZW4gY3B1c2V0X2NwdV9pbmFjdGl2ZSgpIGZh
aWxzIGluIHNjaGVkX2NwdV9kZWFjdGl2YXRlKCksCiZndDsgJmd0OyB0aGUgY3B1IG9mZmxpbmUg
ZmFpbGVkLCBidXQgc2NoZWRfc210X3ByZXNlbnQgaXMgZGVjcmVtZW50ZWQgYmVmb3JlCiZndDsg
Jmd0OyBjYWxsaW5nIHNjaGVkX2NwdV9kZWFjdGl2YXRlKCksIGl0IGxlYWRzIHRvIHVuYmFsYW5j
ZWQgZGVjL2luYywgc28KJmd0OyAmZ3Q7IGZpeCBpdCBieSBpbmNyZW1lbnRpbmcgc2NoZWRfc210
X3ByZXNlbnQgaW4gdGhlIGVycm9yIHBhdGguCiZndDsgJmd0OyAKJmd0OyAmZ3Q7IEZpeGVzOiBj
NTUxMWQwM2VjMDkgKCJzY2hlZC9zbXQ6IE1ha2Ugc2NoZWRfc210X3ByZXNlbnQgdHJhY2sgdG9w
b2xvZ3kiKQomZ3Q7ICZndDsgUmV2aWV3ZWQtYnk6IENoZW4gWXUgPHl1LmMuY2hlbkBpbnRlbC5j
b20+CiZndDsgJmd0OyBSZXZpZXdlZC1ieTogVGltIENoZW4gPHRpbS5jLmNoZW5AbGludXguaW50
ZWwuY29tPgomZ3Q7ICZndDsgU2lnbmVkLW9mZi1ieTogWWFuZyBZaW5nbGlhbmcgPHlhbmd5aW5n
bGlhbmdAaHVhd2VpLmNvbT4KJmd0OyAmZ3Q7IC0tLQomZ3Q7ICZndDsgIGtlcm5lbC9zY2hlZC9j
b3JlLmMgfCA0ICsrKysKJmd0OyAmZ3Q7ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCsp
CiZndDsgJmd0OyAKJmd0OyAmZ3Q7IGRpZmYgLS1naXQgYS9rZXJuZWwvc2NoZWQvY29yZS5jIGIv
a2VybmVsL3NjaGVkL2NvcmUuYwomZ3Q7ICZndDsgaW5kZXggYmNmMmM0Y2MwNTIyLi41YWI2NzE3
YjU3ZTAgMTAwNjQ0CiZndDsgJmd0OyAtLS0gYS9rZXJuZWwvc2NoZWQvY29yZS5jCiZndDsgJmd0
OyArKysgYi9rZXJuZWwvc2NoZWQvY29yZS5jCiZndDsgJmd0OyBAQCAtOTc1Niw2ICs5NzU2LDEw
IEBAIGludCBzY2hlZF9jcHVfZGVhY3RpdmF0ZSh1bnNpZ25lZCBpbnQgY3B1KQomZ3Q7ICZndDsg
IAlzY2hlZF91cGRhdGVfbnVtYShjcHUsIGZhbHNlKTsKJmd0OyAmZ3Q7ICAJcmV0ID0gY3B1c2V0
X2NwdV9pbmFjdGl2ZShjcHUpOwomZ3Q7ICZndDsgIAlpZiAocmV0KSB7CiZndDsgJmd0OyArI2lm
ZGVmIENPTkZJR19TQ0hFRF9TTVQKJmd0OyAmZ3Q7ICsJCWlmIChjcHVtYXNrX3dlaWdodChjcHVf
c210X21hc2soY3B1KSkgPT0gMikKJmd0OyAmZ3Q7ICsJCQlzdGF0aWNfYnJhbmNoX2luY19jcHVz
bG9ja2VkKCZhbXA7c2NoZWRfc210X3ByZXNlbnQpOwomZ3Q7ICZndDsgKyNlbmRpZgomZ3Q7ICZn
dDsgIAkJYmFsYW5jZV9wdXNoX3NldChjcHUsIGZhbHNlKTsKJmd0OyAmZ3Q7ICAJCXNldF9jcHVf
YWN0aXZlKGNwdSwgdHJ1ZSk7CiZndDsgJmd0OyAgCQlzY2hlZF91cGRhdGVfbnVtYShjcHUsIHRy
dWUpOwomZ3Q7IAomZ3Q7IFllcywgZG9lcyBpbmRlZWQgYXBwZWFyIG5lZWRlZCwgaG93ZXZlciEs
IHdoZW4gSSBsb29rIGF0CiZndDsgd2hhdCBlbHNlIGdvZXMgYmVmb3JlIHRoaXMgZmFpbHVyZSwg
c2hvdWxkIHdlIG5vdCBhbHNvIGNhbGwKJmd0OyBzZXRfcnFfb25saW5lKCkgYW5kIHRoaW5ncyBs
aWtlIHRoYXQ/Clllcywgc2V0X3JxX29ubGluZSgpIGlzIG5lZWRlZCBpbiB0aGUgZXJyb3IgcGF0
aC4gSSB3aWxsIHNlbmQgYSBuZXcgcGF0Y2ggdG8gYWRkIHRoaXMuCgomZ3Q7IAomZ3Q7IFRoYXQg
aXMsIGNhbiB3ZSByZXdvcmsgdGhpbmdzIHRvIGJlIGxlc3MgZnJhZ2lsZSBieSBzaGFyaW5nIGNv
ZGUgYmV0d2VlbgomZ3Q7IHRoaXMgZXJyb3IgcGF0aCBhbmQgc2NoZWRfY3B1X2FjdGl2YXRlKCkg
Pwo8L3lhbmd5aW5nbGlhbmdAaHVhd2VpLmNvbT48L3RpbS5jLmNoZW5AbGludXguaW50ZWwuY29t
PjwveXUuYy5jaGVuQGludGVsLmNvbT48L3lhbmd5aW5nbGlhbmdAaHVhd2VpLmNvbT48L3lhbmd5
aW5nbGlhbmdAaHVhd2VpY2xvdWQuY29tPjwvcGV0ZXJ6QGluZnJhZGVhZC5vcmc+

