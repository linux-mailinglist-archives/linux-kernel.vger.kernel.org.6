Return-Path: <linux-kernel+bounces-311322-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63156968785
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:29:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 212A5284000
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43EDC19E96A;
	Mon,  2 Sep 2024 12:27:54 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690A019C554
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 12:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725280073; cv=none; b=K8POI5gsddlm/IfYO4NnWN3DsCMBw0C0IXj7OPHloukyByNaORESHgEfApR5ZnIZgHufKPkXsA/WLUDBkil2Mp19kctUpCkJnCZpDl4oM2EHVTLqoviKk9WqQGhIQb5EKNnbb6Z1Lxo3ZsL7QWhGwnTPH5Qwy2YcKApYLMjT5Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725280073; c=relaxed/simple;
	bh=SR1KS3N9YaYuvzSuWb1PS6WfnS9eHlaKUIy65FRD9/M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=n42YP8el7ZxvQM46BWI8Ucv7oPKvzKiLvMA2nANYARF1Jy9beY+fiyAbQq605s+4KQFBv7bm9dGD9SQ1rIRBU4M9IIuROdfggzfMvNsUO7P69dt+CSRn0Tk6O7ft21CJJvfMzgpi4s9NiVblkam9lGVglNTRph5BZsDC+1e97WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82a3fa4ecd3so216288139f.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 05:27:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725280071; x=1725884871;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SR1KS3N9YaYuvzSuWb1PS6WfnS9eHlaKUIy65FRD9/M=;
        b=QJ4pCT3AW4scOsEeExYstNTGnYlvKAkdBCyBe49KJiWUvMlEDcUgGODG4cPTyywMKu
         TGlNgnpXLJQFZqyU0keosibDez9DVdduv0ynMJSYeYCeY3K5NaEdnLFIDrMEvv35kXRe
         mHYi4Wdptss5kUAGJ5cJ7UAJ9DVnnskCJkRhpgh0sVNplCrLinlN/ekbZpJE6Ws1Vyxw
         Ts1I8OPmgUDngcs2fiUk3MxfrB79lh8opj/QAFarEr9QaLwfm6GPE8pqSYvr7JESgFAZ
         uFqRwsFK/wKbUKMg93I9vU+yaPGE5+SO9O3hQjUj9g40hP/F6DPMb26tNJMRwsQsukyu
         wdAA==
X-Gm-Message-State: AOJu0YxYy+CcGsmYrkTPKFH3WrShOMeLjKIcOgu72YAoUdKIy5oYDmVH
	aS7ojKl+6USylaq8SCo2M2blklPyuiJddkDhy2bR5hm/RZLEtuTtN++JSEHS9+ntkWAmyxT4EH9
	vHsPrbgKl6lhOGRayMCXNUxBEb8ydBDVsaKClrU0GLLTPMXXRlh93nJM=
X-Google-Smtp-Source: AGHT+IEAPZHbdGubIyeCOCliEXQmuHfh3+1kjmz34mLl1DvWjSC6ZC+bTHMSTQMunwK5fIhMRAVRDjEeUZ6feVxO3sbDLMT4O8/w
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12e5:b0:397:35d4:3811 with SMTP id
 e9e14a558f8ab-39f41085d90mr8156185ab.3.1725280071574; Mon, 02 Sep 2024
 05:27:51 -0700 (PDT)
Date: Mon, 02 Sep 2024 05:27:51 -0700
In-Reply-To: <000000000000acfa76061fcca330@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cdf5240621221146@google.com>
Subject: Re: [syzbot] possible fix (linux-ntfs3)
From: syzbot <syzbot+4d2aaeff9eb5a2cfec70@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

Rm9yIGFyY2hpdmFsIHB1cnBvc2VzLCBmb3J3YXJkaW5nIGFuIGluY29taW5nIGNvbW1hbmQgZW1h
aWwgdG8KbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZywgc3l6a2FsbGVyLWJ1Z3NAZ29vZ2xl
Z3JvdXBzLmNvbS4KCioqKgoKU3ViamVjdDogcG9zc2libGUgZml4IChsaW51eC1udGZzMykKQXV0
aG9yOiBhbG1hei5hbGV4YW5kcm92aWNoQHBhcmFnb24tc29mdHdhcmUuY29tCgojc3l6IHRlc3Q6
IGh0dHBzOi8vZ2l0aHViLmNvbS9QYXJhZ29uLVNvZnR3YXJlLUdyb3VwL2xpbnV4LW50ZnMzLmdp
dCBtYXN0ZXINCg0KZGlmZiAtLWdpdCBhL2ZzL250ZnMzL3N1cGVyLmMgYi9mcy9udGZzMy9zdXBl
ci5jDQppbmRleCAxMjhkNDk1MTJmNWQuLmMwOGJiYWNjMDAzMCAxMDA2NDQNCi0tLSBhL2ZzL250
ZnMzL3N1cGVyLmMNCisrKyBiL2ZzL250ZnMzL3N1cGVyLmMNCkBAIC0xMjUsOCArMTI1LDkgQEAg
dm9pZCBudGZzX2lub2RlX3ByaW50ayhzdHJ1Y3QgaW5vZGUgKmlub2RlLCBjb25zdCANCmNoYXIg
KmZtdCwgLi4uKQ0KDQogwqDCoMKgwqDCoMKgwqDCoCBpZiAoZGUpIHsNCiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgc3Bpbl9sb2NrKCZkZS0+ZF9sb2NrKTsNCi3CoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHNucHJpbnRmKG5hbWUsIHNpemVvZihzX25hbWVfYnVmKSwgIiBcIiVzXCIiLA0KLcKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRlLT5kX25hbWUubmFtZSk7DQorwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBpZiAoc25wcmludGYobmFtZSwgc2l6ZW9mKHNfbmFtZV9idWYpLCAiIFwi
JXNcIiIsDQorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZS0+ZF9u
YW1lLm5hbWUpID49IHNpemVvZihzX25hbWVfYnVmKSkNCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgbmFtZVtzaXplb2Yoc19uYW1lX2J1ZikgLSAxXSA9IDA7DQogwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIHNwaW5fdW5sb2NrKCZkZS0+ZF9sb2NrKTsNCiDCoMKgwqDCoMKgwqDCoMKg
IH0gZWxzZSB7DQogwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5hbWVbMF0gPSAwOw0KDQoNCg==

