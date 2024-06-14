Return-Path: <linux-kernel+bounces-214575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3EC9086A1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E32C51F217A6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A959188CB9;
	Fri, 14 Jun 2024 08:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bn8KKnC4"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A02E186E4B
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 08:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718354576; cv=none; b=a/PwoMPRpK2jYh53VF9pS4ldOWrAfGos0Mi2weD4aT9kZorfLD7mNzV/KnChKhXFPLPr30UZkNll1uTewsuGHHja/GKamhz48rDA7rMd/70lWqsojf7zzKE1+R9kgD0aHh3z84LsN2GujCjR7txepS/L48wAEwblHiro02DEcXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718354576; c=relaxed/simple;
	bh=2Ew18NymzmdJQN3U14Dy7i8Z/ff5SEMLscQSlABeY9M=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:In-Reply-To; b=TPfovb3FDsCFX0qmwJWW1tD17NV3FrcRhM6/iSc70U7zISg9LVAL05OJc/fZtHX/7gtWjDSuGz4TVf071/EjcGsshj2xfFPXu82e/LwtJZMajTCMqEyZwwMCWWSX/m++DTHjB244sG34AusG9wl70T4p96lS+Yo9b1y5cqBXJKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bn8KKnC4; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ebdfe26242so21495081fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 01:42:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718354572; x=1718959372; darn=vger.kernel.org;
        h=in-reply-to:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VZGeAmi+REL650B4KJzKo6toIZLz/gk4gW4xMJ3cXkA=;
        b=Bn8KKnC4ObOjtk3ZpACFZSydMGGyFc04oZ/N9sF30qmOn3Sko0JZdp3qGVaoLixhVU
         QwIimuVYTtfIqs3yJJ33/+Evs+Rv1dzeKynjtd58UQUpYOsdB6jmMIiRBa4R8GoSgbO1
         X6/RygXmHqI7hEVIipXkKJjAPxzwKhPqgJx+X4eSUtntjnD7ErYb8wXsQxWbN4zIPnG2
         oJuA8dhTEc/GgI6Mz64nm3iHKIplIOOBrrf0beSgEtXf31rG+zJsyWHMyY0byZcPL7As
         uXnerl8KDmGEmasROZ7l+I3yB0DV/H2iWOYD8c3MqX8/tjTzRyfrzFO5msfI86Ms6DxA
         UVSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718354572; x=1718959372;
        h=in-reply-to:from:content-language:references:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=VZGeAmi+REL650B4KJzKo6toIZLz/gk4gW4xMJ3cXkA=;
        b=FCMoibdgR31xTjQkovsEd9U6w/aSf3sgQTHv2sJpEYK9PVY6zvOLtEbLA+0XNdowhB
         Ur7L/BOvrbswvQgK3EgngykCs2hsm+qfnFMoAJnsNBZOQKfihBLPiwyqVodf7YLzunJk
         w3QPW20gRS19J5enWiJ99vC8SOQjySoLU8+LbzB0G/6sBXXeETsojjAWz/fdH5hkRpsI
         qEoUintmiNGIesAJjd9QEnXNBfp+BnE/eWjwFcEs2i98EcErLKesWgu8gYXsRXjmrix8
         LamzY4KjhlYWhIRozu5BGYv0hB/ukVoq+X5X40m0+AoxEGnqcDezdFuI9DMC8akj45q1
         g4Dw==
X-Forwarded-Encrypted: i=1; AJvYcCW8dTQp8NqWBT4/XDKrtsLhh9+z0yvyWDRgq0FqiOopiKnN8AzoobRJVvNjygDvjD8oF2EgO/ypXDOOriZb3hl1P/BTRV80t86X2c/z
X-Gm-Message-State: AOJu0YxblMSaSrz9ws96X2j9ApbDAbaoiw6Ne2ABD2oAVQVH351mFjwG
	ekuroUYVyqTM8/uyI1p3cXxVrjiPP6SEslbbIz8/7G/ngYsof8KN
X-Google-Smtp-Source: AGHT+IHeAZ1lUekIWS9dv0wBBAQVLTb8Bmg8XsPJwSjwEdGZk/T7WidVapKkOnftPaxaZ6820z2YKw==
X-Received: by 2002:a2e:9015:0:b0:2eb:f9d6:1bf9 with SMTP id 38308e7fff4ca-2ec0e47a176mr14780881fa.23.1718354572312;
        Fri, 14 Jun 2024 01:42:52 -0700 (PDT)
Received: from ?IPV6:2a00:1370:8180:9f8c:610c:ea5a:e832:8757? ([2a00:1370:8180:9f8c:610c:ea5a:e832:8757])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ec161bb2d0sm1308741fa.131.2024.06.14.01.42.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jun 2024 01:42:51 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------Jo5tkfkyH4XEg0fgT5ia4Nde"
Message-ID: <0d900a20-0e9a-4b61-844e-df38b10bc4f2@gmail.com>
Date: Fri, 14 Jun 2024 11:42:49 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [bluetooth?] WARNING in hci_conn_del
To: syzbot <syzbot+b2545b087a01a7319474@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000396d68061acddd90@google.com>
Content-Language: en-US
From: Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <000000000000396d68061acddd90@google.com>

This is a multi-part message in MIME format.
--------------Jo5tkfkyH4XEg0fgT5ia4Nde
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/14/24 2:29 AM, syzbot wrote:
> Hello,
> 
> syzbot has tested the proposed patch but the reproducer is still triggering an issue:
> SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed
> 
> 2024/06/13 23:28:26 ignoring optional flag "sandboxArg"="0"
> 2024/06/13 23:28:27 parsed 1 programs
> 2024/06/13 23:28:27 [FATAL] failed to run ["./syz-executor" "setup" "fault" "binfmt_misc" "usb" "802154" "swap"]: exit status 67
> mkdir(/syzcgroup) failed: 17
> mount(binfmt_misc) failed: 16
> SYZFAIL: NL802154_CMD_SET_SHORT_ADDR failed
>   (errno 16: Device or resource busy)
> 
> 

smells unrelated. let's try again

#syz test
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git maste

-- 
With regards,
Pavel Skripkin
--------------Jo5tkfkyH4XEg0fgT5ia4Nde
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

--------------Jo5tkfkyH4XEg0fgT5ia4Nde--

