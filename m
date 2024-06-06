Return-Path: <linux-kernel+bounces-204226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6188FE606
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 14:04:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31F571F20FE7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 12:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A8719597F;
	Thu,  6 Jun 2024 12:03:44 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDCE195973
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 12:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717675423; cv=none; b=L1aydwczJqdGywL9dOsqLi+PSymN7dw9E5OSy3lUsLOZPKmb6h/kA+ExWlp8OOKkMEQZgSv6O6LJ3ivPpsk5gc866Mdcx5mM8PIwP2gn5vRr6UYJSBxYBea57GCjOhJjfgxzow7pyFsIxU1UhPxqR4yEhGeb3FWXd5FlemayeG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717675423; c=relaxed/simple;
	bh=mcOHG0deKrGCvqyg3BnPUTpeGth5ZBz1TLGdKS7y3UA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=rBKWvXIUJPC4xGG1ZREOSxkbP8IJoB9azkyXpu72JHMmlecXOHpbfZDY7uvCtsxGs+6WuHp+mVvf/vR7pv3nwTEKKV5WuzSlhIO1Q59Xl8b+V7uOvGxT8rylhyQAg7WJO7ERBn3gO58sLD27lU6Cqsshm67Cu6fPR1fmwj50Aeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7eb520773e3so27888039f.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 05:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717675420; x=1718280220;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcOHG0deKrGCvqyg3BnPUTpeGth5ZBz1TLGdKS7y3UA=;
        b=bRGplADKpytMg2/mYmou24DifqPfxuLOVOmOUVUv1tUOfswBqa5CyxHVWGcaePmPH3
         uPKyFnVfYfCb71/4tMBbeGqO0hynmX5p+DQ20EhwyWM3oeyYuO9CpNutJMg4QE5YMp2K
         WRUT22rsatlwysOIe+pCr+lXMZhRJaQ6RLHYWu/o4In5aVx5u4SvrNM35j0nDdUQD6uT
         y4lPSgTCa+k7YZ9Y3Ltjv38it1V7hj8dOdgV7u0pPAuPfuiRxi5Pp8GJnMVYF8KO1TqH
         +Brjf3QbiPA4nSj/P64S1zVsFmGci3sZ+RIjf4RGNRcwMR/gafK1fEjGxZgfT5q6lj7z
         fgrw==
X-Gm-Message-State: AOJu0YzDVyszERaZQy5hVoid1iPGtM5AMy4QQEb4e8gLByNzmtMrqjM1
	dIWBr2Xem85pjvxJljSSMxNUPpEDUAQVj8L3cs5aqgCgHrkH6u1IPHG507xgSuu/EUm7Ags4va7
	UVNRNXMxYzIxJVlKxquUr4qSesGoeOb07IlKq2HeK4G4dnmftqy78vZg=
X-Google-Smtp-Source: AGHT+IHxb06aCGlAm0uw+1WnUOga2CKxsiLI2OyzkBGYGHAJcSQQ3Iyl21lQ+UxolSNTf1HobEoUre3NFnm73BYnGr6pG9xTtW4i
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2cd2:b0:7da:19cb:1c7f with SMTP id
 ca18e2360f4ac-7eb3c28b4f2mr22450339f.0.1717675420392; Thu, 06 Jun 2024
 05:03:40 -0700 (PDT)
Date: Thu, 06 Jun 2024 05:03:40 -0700
In-Reply-To: <000000000000adb08b061413919e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000045babb061a377958@google.com>
Subject: Re: [syzbot] Re: 000000000000fcfa6406141cc8ac@google.com
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

Rm9yIGFyY2hpdmFsIHB1cnBvc2VzLCBmb3J3YXJkaW5nIGFuIGluY29taW5nIGNvbW1hbmQgZW1h
aWwgdG8KbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZywgc3l6a2FsbGVyLWJ1Z3NAZ29vZ2xl
Z3JvdXBzLmNvbS4KCioqKgoKU3ViamVjdDogUmU6IDAwMDAwMDAwMDAwMGZjZmE2NDA2MTQxY2M4
YWNAZ29vZ2xlLmNvbQpBdXRob3I6IHdvamNpZWNoLmdsYWR5c3pAaW5mb2dhaW4uY29tCgojc3l6
IHRlc3QgaHR0cHM6Ly9saW51eC5nb29nbGVzb3VyY2UuY29tL2xpbnV4L2tlcm5lbC9naXQvdG9y
dmFsZHMvbGludXggZTM3N2Q4MDNiNjVlZTQxMzAyMTNiM2MwNDFmYzI1ZmRmZWMxYmQ5MA0KDQot
LS0gYS9rZXJuZWwvdHJhY2UvYnBmX3RyYWNlLmMNCisrKyBiL2tlcm5lbC90cmFjZS9icGZfdHJh
Y2UuYw0KQEAgLTIzOTMsMTIgKzIzOTMsMjEgQEAgdm9pZCBfX2JwZl90cmFjZV9ydW4oc3RydWN0
DQog4oCC4oCC4oCC4oCC4oCCY2FudF9zbGVlcCgpOw0KDQog4oCC4oCC4oCC4oCC4oCCLy8gcmV0
dXJuIGlmIGluc3RydW1lbnRhdGlvbiBkaXNhYmxlZCwgc2VlOiBicGZfZGlzYWJsZV9pbnN0cnVt
ZW50YXRpb24NCi3igILigILigILigILigIJpZiAodW5saWtlbHkoX190aGlzX2NwdV9yZWFkKGJw
Zl9wcm9nX2FjdGl2ZSkpKSB7DQor4oCC4oCC4oCC4oCC4oCCaW50IGluc3RydW1lbnRhdGlvbiA9
IHVubGlrZWx5KF9fdGhpc19jcHVfcmVhZChicGZfcHJvZ19hY3RpdmUpKTsNCivigILigILigILi
gILigIJpZiAoaW5zdHJ1bWVudGF0aW9uKSB7DQor4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCCcHJpbnRrKCJTS0lQIEZPUiBJTlNUUlVNRU5UQVRJT046ICVzID4gJXMgPiAlcCAvJWkg
PT09PT09PT09PT09PT1cbiIsDQor4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCcHJvZy0+YXV4LT5uYW1lLA0KK+KAguKA
guKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKA
guKAguKAgmxpbmstPmJ0cC0+dHAtPm5hbWUsIHByb2csIGluc3RydW1lbnRhdGlvbik7DQog4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCYnBmX3Byb2dfaW5jX21pc3Nlc19jb3VudGVy
KHByb2cpOw0KIOKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgnJldHVybjsNCiDigILi
gILigILigILigIJ9DQoNCi3igILigILigILigILigIJpZiAodW5saWtlbHkodGhpc19jcHVfaW5j
X3JldHVybigqKHByb2ctPmFjdGl2ZSkpICE9IDEpKSB7DQor4oCC4oCC4oCC4oCC4oCCaW50IGFj
dGl2ZSA9IHRoaXNfY3B1X2luY19yZXR1cm4oKihwcm9nLT5hY3RpdmUpKTsNCivigILigILigILi
gILigIIvLyBwcmludGsoIiVzID4gJXMgPiAlcCAvJWlcbiIsIHByb2ctPmF1eC0+bmFtZSwgbGlu
ay0+YnRwLT50cC0+bmFtZSwgcHJvZywgYWN0aXZlKTsNCivigILigILigILigILigIJpZiAoYWN0
aXZlICE9IDEpIHsNCivigILigILigILigILigILigILigILigILigILigILigIJwcmludGsoIlNL
SVAgRk9SIEFDVElWRTogJXMgPiAlcyA+ICVwIC8laSA9PT09PT09PT09PT09PT09PT09PT09PVxu
IiwNCivigILigILigILigILigILigILigILigILigILigILigILigILigILigILigILigILigILi
gILigILigILigILigILigIJwcm9nLT5hdXgtPm5hbWUsDQor4oCC4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCbGluay0+YnRw
LT50cC0+bmFtZSwgcHJvZywgYWN0aXZlKTsNCiDigILigILigILigILigILigILigILigILigILi
gILigIJicGZfcHJvZ19pbmNfbWlzc2VzX2NvdW50ZXIocHJvZyk7DQog4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCCZ290byBvdXQ7DQog4oCC4oCC4oCC4oCC4oCCfQ0KLS0tIGEva2Vy
bmVsL3RyYWNlcG9pbnQuYw0KKysrIGIva2VybmVsL3RyYWNlcG9pbnQuYw0KQEAgLTI5OCw2ICsz
MDgsOCBAQCBzdGF0aWMgZW51bSB0cF9mdW5jX3N0YXRlIG5yX2Z1bmNfc3RhdGUoY29uc3QNCiB7
DQog4oCC4oCC4oCC4oCC4oCCaWYgKCF0cF9mdW5jcykNCiDigILigILigILigILigILigILigILi
gILigILigILigIJyZXR1cm4gVFBfRlVOQ18wOw0KK+KAguKAguKAguKAguKAgmlmICghdHBfZnVu
Y3NbMF0uZnVuYykNCivigILigILigILigILigILigILigILigILigILigILigIJyZXR1cm4gVFBf
RlVOQ18wOw0KIOKAguKAguKAguKAguKAgmlmICghdHBfZnVuY3NbMV0uZnVuYykNCiDigILigILi
gILigILigILigILigILigILigILigILigIJyZXR1cm4gVFBfRlVOQ18xOw0KIOKAguKAguKAguKA
guKAgmlmICghdHBfZnVuY3NbMl0uZnVuYykNCi0tDQoNClRoZSBpbmZvcm1hdGlvbiBpbiB0aGlz
IGVtYWlsIGlzIGNvbmZpZGVudGlhbCBhbmQgbWF5IGJlIGxlZ2FsbHkgcHJpdmlsZWdlZC4gSXQg
aXMgaW50ZW5kZWQgc29sZWx5IGZvciB0aGUgYWRkcmVzc2VlIGFuZCBhY2Nlc3MgdG8gaXQgYnkg
YW55b25lIGVsc2UgaXMgdW5hdXRob3JpemVkLiBJZiB5b3UgYXJlIG5vdCB0aGUgaW50ZW5kZWQg
cmVjaXBpZW50LCBhbnkgZGlzY2xvc3VyZSwgY29weWluZywgZGlzdHJpYnV0aW9uIG9yIGFueSBh
Y3Rpb24gdGFrZW4gb3Igb21pdHRlZCB0byBiZSB0YWtlbiBiYXNlZCBvbiBpdCwgaXMgc3RyaWN0
bHkgcHJvaGliaXRlZCBhbmQgbWF5IGJlIHVubGF3ZnVsLg0K

