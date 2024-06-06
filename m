Return-Path: <linux-kernel+bounces-204258-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 907DD8FE648
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22FFD28832F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F1E7195B3E;
	Thu,  6 Jun 2024 12:14:19 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05FC195988
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717676059; cv=none; b=SYYB7PyUZOe8cMMpDRg+M+WfxC3Nef7NIFD+sZexgQxfZ6iiz830rPBf7NUzoDjAtidtX+h8H76fkYW2LxEkvlm9ICBbmDbCJX/FVYFLU+tuUZrQ/6yf2/2xpzcKprjA3H7vwKu0aofW+dO0nvKQcX0BXicxA0i69GXWruk3l6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717676059; c=relaxed/simple;
	bh=w3tUB9Z8s9p6lHhxqs1STK1Yqtj1XVLB1rOrlR5FVeU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=hu4l3dyeTb9p6YxbcGxdeG8o3tFxlcynFmJDH9p2K0LUdY1UKPdL80baSZ+RZ/Wq+eBfJqQo296W4S7kaJKeBl0w1+2NpoTT79ZLGvXZcgiVIVRYHd13dasW3sBAVhcMBk8lfIG7UjR9/DdEd0MfOSW7ICzRgXkvtmipKeb+qzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7e20341b122so94620139f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 05:14:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717676057; x=1718280857;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3tUB9Z8s9p6lHhxqs1STK1Yqtj1XVLB1rOrlR5FVeU=;
        b=dPqCN2E9jfxatjDH1wa7PnuONzZCYMs7hoyjmFejiUbqTaoAjAeM8vdcFHaYL2+ArW
         G1WIH3NnWimDEaWD0yT9rYRSrA1EnsghNVY0hnNvv1yYWLVpWcdnSZ/EHhW9bNpau9Lk
         gLdMYfyUbehrbfEfopT76JJrAI0i/GtLb7ygjz+aTn7emm3sgqfqjju9EnYiC8JLfS58
         SIQqHBo4I8tEytzZ/ZT1fIj0gpInBIxLl3QhcTQEl685XKHGuAmVe1McPjiS5Q/PFfc7
         x3ilbAu8QaUlHp2SsOpEeg20c0mpCBdRmmhmA33m+AVzQz6c8LykU5AjxoU93Rl42tiI
         fppg==
X-Gm-Message-State: AOJu0YzuqDt7O7eatFjhOqjJuYEBjuv5rBq+SgC7SaVV7++cQLV4BnNu
	EpTauJRi3JDzaZcJePNZ0Us+Kdfgk0G0jWjcixvb3tvSr6Orrfq8Bn5eH7/8XWMnvSolC1FDr+4
	rVF2MVYWPw4qMFQudk6eGLJ4EmsS3vcF9SwcGZkswNgn8SaOENRGZa6g=
X-Google-Smtp-Source: AGHT+IEL+oo5A7XAzzKE0qN7bXYGrGgroelBkJRfF6U3BlEilOaBrAyadF0XGxh9UnAnGkjEclIzR4TygYUlPGPO98jTkwwMTh3m
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8419:b0:4b5:ed14:3807 with SMTP id
 8926c6da1cb9f-4b63a740afdmr140474173.1.1717676056607; Thu, 06 Jun 2024
 05:14:16 -0700 (PDT)
Date: Thu, 06 Jun 2024 05:14:16 -0700
In-Reply-To: <000000000000adb08b061413919e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000318b15061a379fe1@google.com>
Subject: Re: [syzbot] Re: 000000000000fcfa6406141cc8ac@google.com
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

Rm9yIGFyY2hpdmFsIHB1cnBvc2VzLCBmb3J3YXJkaW5nIGFuIGluY29taW5nIGNvbW1hbmQgZW1h
aWwgdG8KbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZywgc3l6a2FsbGVyLWJ1Z3NAZ29vZ2xl
Z3JvdXBzLmNvbS4KCioqKgoKU3ViamVjdDogUmU6IDAwMDAwMDAwMDAwMGZjZmE2NDA2MTQxY2M4
YWNAZ29vZ2xlLmNvbQpBdXRob3I6IHdvamNpZWNoLmdsYWR5c3pAaW5mb2dhaW4uY29tCgoNCiNz
eXogdGVzdCBodHRwczovL2xpbnV4Lmdvb2dsZXNvdXJjZS5jb20vbGludXgva2VybmVsL2dpdC90
b3J2YWxkcy9saW51eCBlMzc3ZDgwM2I2NWVlNDEzMDIxM2IzYzA0MWZjMjVmZGZlYzFiZDkwDQoN
Ci0tLSBhL2tlcm5lbC90cmFjZS9icGZfdHJhY2UuYw0KKysrIGIva2VybmVsL3RyYWNlL2JwZl90
cmFjZS5jDQog4oCC4oCC4oCC4oCC4oCCY2FudF9zbGVlcCgpOw0KDQog4oCC4oCC4oCC4oCC4oCC
Ly8gcmV0dXJuIGlmIGluc3RydW1lbnRhdGlvbiBkaXNhYmxlZCwgc2VlOiBicGZfZGlzYWJsZV9p
bnN0cnVtZW50YXRpb24NCi3igILigILigILigILigIJpZiAodW5saWtlbHkoX190aGlzX2NwdV9y
ZWFkKGJwZl9wcm9nX2FjdGl2ZSkpKSB7DQor4oCC4oCC4oCC4oCC4oCCaW50IGluc3RydW1lbnRh
dGlvbiA9IHVubGlrZWx5KF9fdGhpc19jcHVfcmVhZChicGZfcHJvZ19hY3RpdmUpKTsNCivigILi
gILigILigILigIJpZiAoaW5zdHJ1bWVudGF0aW9uKSB7DQor4oCC4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCCcHJpbnRrKCJTS0lQIEZPUiBJTlNUUlVNRU5UQVRJT046ICVzID4gJXMgPiAl
cCAvJWkgPT09PT09PT09PT09PT1cbiIsDQor4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCcHJvZy0+YXV4LT5uYW1lLA0K
K+KAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKA
guKAguKAguKAguKAgmxpbmstPmJ0cC0+dHAtPm5hbWUsIHByb2csIGluc3RydW1lbnRhdGlvbik7
DQog4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCYnBmX3Byb2dfaW5jX21pc3Nlc19j
b3VudGVyKHByb2cpOw0KIOKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgnJldHVybjsN
CiDigILigILigILigILigIJ9DQoNCi3igILigILigILigILigIJpZiAodW5saWtlbHkodGhpc19j
cHVfaW5jX3JldHVybigqKHByb2ctPmFjdGl2ZSkpICE9IDEpKSB7DQor4oCC4oCC4oCC4oCC4oCC
aW50IGFjdGl2ZSA9IHRoaXNfY3B1X2luY19yZXR1cm4oKihwcm9nLT5hY3RpdmUpKTsNCivigILi
gILigILigILigIIvLyBwcmludGsoIiVzID4gJXMgPiAlcCAvJWlcbiIsIHByb2ctPmF1eC0+bmFt
ZSwgbGluay0+YnRwLT50cC0+bmFtZSwgcHJvZywgYWN0aXZlKTsNCivigILigILigILigILigIJp
ZiAoYWN0aXZlICE9IDEpIHsNCivigILigILigILigILigILigILigILigILigILigILigIJwcmlu
dGsoIlNLSVAgRk9SIEFDVElWRTogJXMgPiAlcyA+ICVwIC8laSA9PT09PT09PT09PT09PT09PT09
PT09PVxuIiwNCivigILigILigILigILigILigILigILigILigILigILigILigILigILigILigILi
gILigILigILigILigILigILigILigIJwcm9nLT5hdXgtPm5hbWUsDQor4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCbGlu
ay0+YnRwLT50cC0+bmFtZSwgcHJvZywgYWN0aXZlKTsNCiDigILigILigILigILigILigILigILi
gILigILigILigIJicGZfcHJvZ19pbmNfbWlzc2VzX2NvdW50ZXIocHJvZyk7DQog4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCZ290byBvdXQ7DQog4oCC4oCC4oCC4oCC4oCCfQ0KLS0t
IGEva2VybmVsL3RyYWNlcG9pbnQuYw0KKysrIGIva2VybmVsL3RyYWNlcG9pbnQuYw0KIHsNCiDi
gILigILigILigILigIJpZiAoIXRwX2Z1bmNzKQ0KIOKAguKAguKAguKAguKAguKAguKAguKAguKA
guKAguKAgnJldHVybiBUUF9GVU5DXzA7DQor4oCC4oCC4oCC4oCC4oCCaWYgKCF0cF9mdW5jc1sw
XS5mdW5jKQ0KK+KAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgnJldHVybiBUUF9GVU5D
XzA7DQog4oCC4oCC4oCC4oCC4oCCaWYgKCF0cF9mdW5jc1sxXS5mdW5jKQ0KIOKAguKAguKAguKA
guKAguKAguKAguKAguKAguKAguKAgnJldHVybiBUUF9GVU5DXzE7DQog4oCC4oCC4oCC4oCC4oCC
aWYgKCF0cF9mdW5jc1syXS5mdW5jKQ0KLS0NCg0KVGhlIGluZm9ybWF0aW9uIGluIHRoaXMgZW1h
aWwgaXMgY29uZmlkZW50aWFsIGFuZCBtYXkgYmUgbGVnYWxseSBwcml2aWxlZ2VkLiBJdCBpcyBp
bnRlbmRlZCBzb2xlbHkgZm9yIHRoZSBhZGRyZXNzZWUgYW5kIGFjY2VzcyB0byBpdCBieSBhbnlv
bmUgZWxzZSBpcyB1bmF1dGhvcml6ZWQuIElmIHlvdSBhcmUgbm90IHRoZSBpbnRlbmRlZCByZWNp
cGllbnQsIGFueSBkaXNjbG9zdXJlLCBjb3B5aW5nLCBkaXN0cmlidXRpb24gb3IgYW55IGFjdGlv
biB0YWtlbiBvciBvbWl0dGVkIHRvIGJlIHRha2VuIGJhc2VkIG9uIGl0LCBpcyBzdHJpY3RseSBw
cm9oaWJpdGVkIGFuZCBtYXkgYmUgdW5sYXdmdWwuDQo=

