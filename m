Return-Path: <linux-kernel+bounces-216022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EE48D909A07
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 23:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2BB31C21235
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jun 2024 21:37:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1FE61FE5;
	Sat, 15 Jun 2024 21:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ce+WR7cI"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12E61CA94
	for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 21:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718487458; cv=none; b=TZNENDWa5qbIyQScWVoust8t8dvSWiw/M0fGQbexx8wF6Drnx9avwzkEQeY53VvEMsDcvdHkr6zt69IFFNf4BcGccw1aNrBs9rG9pMnhKQ02pwhiWR9tctiP7ssis+0wRXAvNr8aawsvmvUfaF0CC0h8FmjIkCRhqaJztB6+G74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718487458; c=relaxed/simple;
	bh=JZcwWOykDIxtFC3B+rDuKisQByVfs3wR1jwX4KkHyVA=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:In-Reply-To; b=YEWX5gVdcZ0JcQnB2NZEd9KVXpFKCqKqYwiXjYUuJEqt6dR6nOiraaWgvb17PEW2HfZpn4RKCO9flkOIhedQrh5uzUF7nxh9cgrGY9X4GVFmGco9ouueLTFwvUoOKHysgQMtq0yH6hZiOiTGuZJI89F2j9wCfV35omRIRAhFLHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ce+WR7cI; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-52bbdb15dd5so3788286e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 15 Jun 2024 14:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718487455; x=1719092255; darn=vger.kernel.org;
        h=in-reply-to:content-language:references:to:from:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1QIrxFLTXK4GDIfDMv/uDfwbH6lgMn34DC8Ib+1ZiY8=;
        b=ce+WR7cIFbKcSpMZam6EoHorE5LV1q4lwYFi3h4A+Dfd56ImiPeiZAGQgrnY4Th1Us
         QAvUSWhMGC2DoqngHey6MIAKYw10jtbs9pGhPxJgoPTBl1RJQXlhIb3vVpRkjjMaKujl
         wza5ciw+dS8gj0Rl9mVeVOrFjfksT/ntAXv9ArWhI5oag4SllR2zvRgRJNmDvbQniP9C
         Zc8N3Cb+lxtQGrefgZfU6Zc5RsrgcI8ZNC+R4n6LxafwZ5uuwe0oVwKBrYpivMPAX4kk
         YhZOLDvTerJ+AxNZdRBazNBC+0dIaJJ/mIsPlEyxgC5a1hMwKxt+TONrVCtLdGjqMFHa
         qIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718487455; x=1719092255;
        h=in-reply-to:content-language:references:to:from:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1QIrxFLTXK4GDIfDMv/uDfwbH6lgMn34DC8Ib+1ZiY8=;
        b=JH8GMiI0GVVRUSlHiBNi8oRwBm7uLzHCm6R1RUuXtLfjFOvHDR89/NvnzOndNbqXxv
         Dfu4x4ML0oF1a6waaU/nmS86K+LjxC+WBTCivopwm41/UN1Ye/uUgcyEL7Qcq8vc3LB6
         vMlHTdxHz6ER06BQwora3G4FyEUSznsPCzVOxaZVA35VfopfzEvIm6aQYQhzmwAFBSOM
         Y60FQdIOVW202OWirSholSmn/QxUXjpBKYpyp85Qx+n6ZyD+ubPKQ6zg+jOTZoep5cNk
         aqZXr2oIqYnDs3pCoMNmmAb9kPl2Ux1ohaAx0NwZAIai5zO8YxUrY+4gCthhuq8udeK5
         tsjQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+caS/d8C17pYKYQGvPgRXdtPd6YMfbmM9lwffl4+hknOp0pnU30bnqI8ah5fJgs4uIwoX9jHJqo8hBrnOG7JisLzz/w1WE96W6M04
X-Gm-Message-State: AOJu0YzjtPd9VSaAD/AG3asQp863lSLbwCFTyp14MBHYDGue2qR7BKRM
	xKEWxOLvwYO4VDo7soAKI+VKN8sQjscULQrYdO7W/UwJv71fro5z
X-Google-Smtp-Source: AGHT+IGywJkcDRHHfPsC6fUVK/T62I/6lU2eMcIwp6QyCtXQ17iEz3HwQhZe1yAgLM1ySIr8eNxfHA==
X-Received: by 2002:a05:6512:2395:b0:52c:8979:9627 with SMTP id 2adb3069b0e04-52cb3de92d3mr2144414e87.3.1718487454657;
        Sat, 15 Jun 2024 14:37:34 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8180:9f8c:610c:ea5a:e832:8757? ([2a00:1370:8180:9f8c:610c:ea5a:e832:8757])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca28723dcsm839982e87.151.2024.06.15.14.37.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Jun 2024 14:37:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------QpeH4aDJgNhqrF1J3qRQP0ql"
Message-ID: <31ac448d-2a21-4e93-8a00-5c7090970452@gmail.com>
Date: Sun, 16 Jun 2024 00:37:32 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [bluetooth?] WARNING in hci_conn_del
From: Pavel Skripkin <paskripkin@gmail.com>
To: syzbot <syzbot+b2545b087a01a7319474@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000396d68061acddd90@google.com>
 <0d900a20-0e9a-4b61-844e-df38b10bc4f2@gmail.com>
Content-Language: en-US
In-Reply-To: <0d900a20-0e9a-4b61-844e-df38b10bc4f2@gmail.com>

This is a multi-part message in MIME format.
--------------QpeH4aDJgNhqrF1J3qRQP0ql
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/14/24 11:42 AM, Pavel Skripkin wrote:
> 
> 
> On 6/14/24 2:29 AM, syzbot wrote:
>> Hello,
>> 
>> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
>> SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed
>> 
>> 2024/06/13 23:28:26 ignoring optional flag "sandboxArg"="0"
>> 2024/06/13 23:28:27 parsed 1 programs
>> 2024/06/13 23:28:27 [FATAL] failed to run ["./syz-executor" "setup" "fault" "binfmt_misc" "usb" "802154" "swap"]: exit status 67
>> mkdir(/syzcgroup) failed: 17
>> mount(binfmt_misc) failed: 16
>> SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed
>>   (errno 16: Device or resource busy)
>> 
>> 

#syz test
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master


-- 
With regards,
Pavel Skripkin
--------------QpeH4aDJgNhqrF1J3qRQP0ql
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-bluetooth-hci-disallow-setting-handle-bigger-than-HC.patch"
Content-Disposition: attachment;
 filename*0="0001-bluetooth-hci-disallow-setting-handle-bigger-than-HC.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSBjZDc1YzQzNzk2NDUxYWYwZTNjNWU2YjQyYWE3Mjc2NjAzYzRiYjFiIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBQYXZlbCBTa3JpcGtpbiA8cGFza3JpcGtpbkBnbWFp
bC5jb20+CkRhdGU6IEZyaSwgMTQgSnVuIDIwMjQgMDA6MDI6NTEgKzAzMDAKU3ViamVjdDog
W1BBVENIXSBibHVldG9vdGgvaGNpOiBkaXNhbGxvdyBzZXR0aW5nIGhhbmRsZSBiaWdnZXIg
dGhhbgogSENJX0NPTk5fSEFORExFX01BWAoKU3l6Ym90IGhpdCB3YXJuaW5nIGluIGhjaV9j
b25uX2RlbCgpIGNhdXNlZCBieSBmcmVlaW5nIGhhbmRsZSB0aGF0IHdhcwpub3QgYWxsb2Nh
dGVkIHVzaW5nIGlkYSBhbGxvY2F0b3IuCgpUaGlzIGlzIGNhdXNlZCBieSBoYW5kbGUgYmln
Z2VyIHRoYW4gSENJX0NPTk5fSEFORExFX01BWCBwYXNzZWQgYnkKaGNpX2xlX2JpZ19zeW5j
X2VzdGFibGlzaGVkX2V2dCgpLCB3aGljaCBtYWtlcyBjb2RlIHRoaW5rIGl0J3MgdW5zZXQK
Y29ubmVjdGlvbi4KCkFkZCBzYW1lIGNoZWNrIGZvciBoYW5kbGUgdXBwZXIgYm91bmQgYXMg
aW4gaGNpX2Nvbm5fc2V0X2hhbmRsZSgpIHRvCnByZXZlbnQgd2FybmluZy4KCkZpeGVzOiBo
dHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS9idWc/ZXh0aWQ9YjI1NDViMDg3YTAxYTcz
MTk0NzQKUmVwb3J0ZWQtYnk6IHN5emJvdCtiMjU0NWIwODdhMDFhNzMxOTQ3NEBzeXprYWxs
ZXIuYXBwc3BvdG1haWwuY29tCkZpeGVzOiAxODFhNDJlZGRkZjUgKCJCbHVldG9vdGg6IE1h
a2UgaGFuZGxlIG9mIGhjaV9jb25uIGJlIHVuaXF1ZSIpClNpZ25lZC1vZmYtYnk6IFBhdmVs
IFNrcmlwa2luIDxwYXNrcmlwa2luQGdtYWlsLmNvbT4KLS0tCiBuZXQvYmx1ZXRvb3RoL2hj
aV9jb25uLmMgfCAxMyArKysrKysrKysrKy0tCiAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9uZXQvYmx1ZXRvb3RoL2hj
aV9jb25uLmMgYi9uZXQvYmx1ZXRvb3RoL2hjaV9jb25uLmMKaW5kZXggMGM3NmRjZGU1MzYx
Li5kZDIxZmVlMWQ3YzYgMTAwNjQ0Ci0tLSBhL25ldC9ibHVldG9vdGgvaGNpX2Nvbm4uYwor
KysgYi9uZXQvYmx1ZXRvb3RoL2hjaV9jb25uLmMKQEAgLTg5OSw4ICs4OTksOCBAQCBzdGF0
aWMgaW50IGhjaV9jb25uX2hhc2hfYWxsb2NfdW5zZXQoc3RydWN0IGhjaV9kZXYgKmhkZXYp
CiAJCQkgICAgICAgVTE2X01BWCwgR0ZQX0FUT01JQyk7CiB9CiAKLXN0cnVjdCBoY2lfY29u
biAqaGNpX2Nvbm5fYWRkKHN0cnVjdCBoY2lfZGV2ICpoZGV2LCBpbnQgdHlwZSwgYmRhZGRy
X3QgKmRzdCwKLQkJCSAgICAgIHU4IHJvbGUsIHUxNiBoYW5kbGUpCitzdGF0aWMgc3RydWN0
IGhjaV9jb25uICpfX2hjaV9jb25uX2FkZChzdHJ1Y3QgaGNpX2RldiAqaGRldiwgaW50IHR5
cGUsIGJkYWRkcl90ICpkc3QsCisJCQkJICAgICAgIHU4IHJvbGUsIHUxNiBoYW5kbGUpCiB7
CiAJc3RydWN0IGhjaV9jb25uICpjb25uOwogCkBAIC0xMDQ0LDYgKzEwNDQsMTUgQEAgc3Ry
dWN0IGhjaV9jb25uICpoY2lfY29ubl9hZGRfdW5zZXQoc3RydWN0IGhjaV9kZXYgKmhkZXYs
IGludCB0eXBlLAogCXJldHVybiBoY2lfY29ubl9hZGQoaGRldiwgdHlwZSwgZHN0LCByb2xl
LCBoYW5kbGUpOwogfQogCitzdHJ1Y3QgaGNpX2Nvbm4gKmhjaV9jb25uX2FkZChzdHJ1Y3Qg
aGNpX2RldiAqaGRldiwgaW50IHR5cGUsIGJkYWRkcl90ICpkc3QsCisJCQkgICAgICB1OCBy
b2xlLCB1MTYgaGFuZGxlKQoreworCWlmIChoYW5kbGUgPiBIQ0lfQ09OTl9IQU5ETEVfTUFY
KQorCQlyZXR1cm4gRVJSX1BUUigtRUlOVkFMKTsKKworCXJldHVybiBfX2hjaV9jb25uX2Fk
ZChoZGV2LCB0eXBlLCBkc3QsIHJvbGUsIGhhbmRsZSk7Cit9CisKIHN0YXRpYyB2b2lkIGhj
aV9jb25uX2NsZWFudXBfY2hpbGQoc3RydWN0IGhjaV9jb25uICpjb25uLCB1OCByZWFzb24p
CiB7CiAJaWYgKCFyZWFzb24pCi0tIAoyLjQ1LjIKCg==

--------------QpeH4aDJgNhqrF1J3qRQP0ql--

