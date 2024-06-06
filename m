Return-Path: <linux-kernel+bounces-203915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C45E58FE1F7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:03:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C376D1C257E0
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:03:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E4213E3F6;
	Thu,  6 Jun 2024 08:57:27 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CAA13E04F
	for <linux-kernel@vger.kernel.org>; Thu,  6 Jun 2024 08:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664246; cv=none; b=grzfZNtEdcA3CL+OuQ+fFyxHxGIv17qqO0Wcwpprua8kS3Hp/Y/BpTD0/zVquvLbMzKaq/OunntcI9U/dZE5bwTat5g4bG7Xk1sxqfPUuMehoGX5NOLo2GuybhGo5AwNxRMP7YOSvFqbZJy0c1En+0UM7tHlk2LJTwYGf4hdp4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664246; c=relaxed/simple;
	bh=zwNZwNj49yJIvJf65cLY49SODLGZDo/4Wj1rSccPRDM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jC0SNqhn2q5DoGN6e7dmGal3v+WQn6Oz4e6mVR0TKav/qwpSDj60i1iwQboo0nAbGfnlUPJzt3W8EUvTqiAvd1AfGw5/RONllOKOt2S2DnUjO0R+eNS1NUgnECsYwg/oItksxXEf4MoKHXANexlr9XO7dfolU5BSdGrUYrir+nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7e69c0762b8so88469239f.1
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jun 2024 01:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717664244; x=1718269044;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zwNZwNj49yJIvJf65cLY49SODLGZDo/4Wj1rSccPRDM=;
        b=wb1KRZ1apDDcusqHhhtjIjsjgxA5bWVn0TTyWyFt2e+sUMJCdq5RotkHwv4dl1p9Fx
         WpI0b47rymMpNDzuJWTEMqc/lvSxz10HYQDESDL/cSBFzmSPTDatucwKkebeJKVNDkjp
         YM+28b41ze7yQFgG+RahbEa/Gx3MxT9QvM8XKJrPXow2aGTHGRxQAuSD8bn37WZOodSW
         F+F15AZCfEuHNZjUCVEGugWwxCuGRLTHvP98PEGWnvjEfWB8SvDcfRV99KR1TBhxXSWE
         XeIJYYf3n5lqs/4Ha27eO0zkjX9PbYBBX4sa5lao/OrquxEjLe2jqtURuLUrjLayuLl2
         1CHQ==
X-Gm-Message-State: AOJu0YxTOJUTkcMt8HjyaaqkPR+9PzsOUE5tc81PxwfZi42TgzITphCX
	z3yFv5NpTdVeYSKDvC0paD9Yo19sSu2o1/VvP0lwkjr4tVRAX+KsUDsCYJUAyyH1M8TNJdr+CUY
	kxiWHHpNSY5cWNUGcblvLE4JZXuc3sNYM142NMh1uwZfz65icW7qbywY=
X-Google-Smtp-Source: AGHT+IHQFT29DDICj6HmHq9v6UyCWqko5su9/c8HnafKiv6YfnJ836HZoccspA9w8SMyNlJXAR9W3xJm8JJqUA4UMHtZf4KsE+a+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:1602:b0:7de:e182:ddf1 with SMTP id
 ca18e2360f4ac-7eb3c005602mr16414239f.0.1717664244360; Thu, 06 Jun 2024
 01:57:24 -0700 (PDT)
Date: Thu, 06 Jun 2024 01:57:24 -0700
In-Reply-To: <000000000000adb08b061413919e@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020f7d6061a34dfb8@google.com>
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
IGJwZl9yYXdfdHBfbGluayAqbGluaywgdTY0ICphcmdzKQ0KIOKAguKAguKAguKAguKAgmNhbnRf
c2xlZXAoKTsNCg0KIOKAguKAguKAguKAguKAgi8vIHJldHVybiBpZiBpbnN0cnVtZW50YXRpb24g
ZGlzYWJsZWQsIHNlZTogYnBmX2Rpc2FibGVfaW5zdHJ1bWVudGF0aW9uDQot4oCC4oCC4oCC4oCC
4oCCaWYgKHVubGlrZWx5KF9fdGhpc19jcHVfcmVhZChicGZfcHJvZ19hY3RpdmUpKSkgew0KK+KA
guKAguKAguKAguKAgmludCBpbnN0cnVtZW50YXRpb24gPSB1bmxpa2VseShfX3RoaXNfY3B1X3Jl
YWQoYnBmX3Byb2dfYWN0aXZlKSk7DQor4oCC4oCC4oCC4oCC4oCCaWYgKGluc3RydW1lbnRhdGlv
bikgew0KK+KAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgnByaW50aygiU0tJUCBGT1Ig
SU5TVFJVTUVOVEFUSU9OOiAlcyA+ICVzID4gJXAgLyVpID09PT09PT09PT09PT09XG4iLA0KK+KA
guKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKA
guKAguKAguKAgnByb2ctPmF1eC0+bmFtZSwNCivigILigILigILigILigILigILigILigILigILi
gILigILigILigILigILigILigILigILigILigILigILigILigILigIJsaW5rLT5idHAtPnRwLT5u
YW1lLCBwcm9nLCBpbnN0cnVtZW50YXRpb24pOw0KIOKAguKAguKAguKAguKAguKAguKAguKAguKA
guKAguKAgmJwZl9wcm9nX2luY19taXNzZXNfY291bnRlcihwcm9nKTsNCiDigILigILigILigILi
gILigILigILigILigILigILigIJyZXR1cm47DQog4oCC4oCC4oCC4oCC4oCCfQ0KDQot4oCC4oCC
4oCC4oCC4oCCaWYgKHVubGlrZWx5KHRoaXNfY3B1X2luY19yZXR1cm4oKihwcm9nLT5hY3RpdmUp
KSAhPSAxKSkgew0KK+KAguKAguKAguKAguKAgmludCBhY3RpdmUgPSB0aGlzX2NwdV9pbmNfcmV0
dXJuKCoocHJvZy0+YWN0aXZlKSk7DQor4oCC4oCC4oCC4oCC4oCCLy8gcHJpbnRrKCIlcyA+ICVz
ID4gJXAgLyVpXG4iLCBwcm9nLT5hdXgtPm5hbWUsIGxpbmstPmJ0cC0+dHAtPm5hbWUsIHByb2cs
IGFjdGl2ZSk7DQor4oCC4oCC4oCC4oCC4oCCaWYgKGFjdGl2ZSAhPSAxKSB7DQor4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCcHJpbnRrKCJTS0lQIEZPUiBBQ1RJVkU6ICVzID4gJXMg
PiAlcCAvJWkgPT09PT09PT09PT09PT09PT09PT09PT1cbiIsDQor4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCcHJvZy0+
YXV4LT5uYW1lLA0KK+KAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKA
guKAguKAguKAguKAguKAguKAguKAguKAgmxpbmstPmJ0cC0+dHAtPm5hbWUsIHByb2csIGFjdGl2
ZSk7DQog4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCYnBmX3Byb2dfaW5jX21pc3Nl
c19jb3VudGVyKHByb2cpOw0KIOKAguKAguKAguKAguKAguKAguKAguKAguKAguKAguKAgmdvdG8g
b3V0Ow0KIOKAguKAguKAguKAguKAgn0NCi0tLSBhL2tlcm5lbC90cmFjZXBvaW50LmMNCisrKyBi
L2tlcm5lbC90cmFjZXBvaW50LmMNCkBAIC02Nyw3ICs2Nyw3IEBAIHN0YXRpYyB2b2lkIHRwX3Jj
dV9jb25kX3N5bmMoZW51bSB0cF90cmFuc2l0aW9uX3N5bmMgc3luYykNCiB9DQoNCiAvKiBTZXQg
dG8gMSB0byBlbmFibGUgdHJhY2Vwb2ludCBkZWJ1ZyBvdXRwdXQgKi8NCi1zdGF0aWMgY29uc3Qg
aW50IHRyYWNlcG9pbnRfZGVidWc7DQorc3RhdGljIGNvbnN0IGludCB0cmFjZXBvaW50X2RlYnVn
PTE7DQoNCiAjaWZkZWYgQ09ORklHX01PRFVMRVMNCiAvKg0KQEAgLTI5OCw2ICsyOTgsOCBAQCBz
dGF0aWMgZW51bSB0cF9mdW5jX3N0YXRlIG5yX2Z1bmNfc3RhdGUoY29uc3Qgc3RydWN0IHRyYWNl
cG9pbnRfZnVuYyAqdHBfZnVuY3MpDQogew0KIOKAguKAguKAguKAguKAgmlmICghdHBfZnVuY3Mp
DQog4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCcmV0dXJuIFRQX0ZVTkNfMDsNCivi
gILigILigILigILigIJpZiAoIXRwX2Z1bmNzWzBdLmZ1bmMpDQor4oCC4oCC4oCC4oCC4oCC4oCC
4oCC4oCC4oCC4oCC4oCCcmV0dXJuIFRQX0ZVTkNfMDsNCiDigILigILigILigILigIJpZiAoIXRw
X2Z1bmNzWzFdLmZ1bmMpDQog4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCcmV0dXJu
IFRQX0ZVTkNfMTsNCiDigILigILigILigILigIJpZiAoIXRwX2Z1bmNzWzJdLmZ1bmMpDQoNClRo
ZSBpbmZvcm1hdGlvbiBpbiB0aGlzIGVtYWlsIGlzIGNvbmZpZGVudGlhbCBhbmQgbWF5IGJlIGxl
Z2FsbHkgcHJpdmlsZWdlZC4gSXQgaXMgaW50ZW5kZWQgc29sZWx5IGZvciB0aGUgYWRkcmVzc2Vl
IGFuZCBhY2Nlc3MgdG8gaXQgYnkgYW55b25lIGVsc2UgaXMgdW5hdXRob3JpemVkLiBJZiB5b3Ug
YXJlIG5vdCB0aGUgaW50ZW5kZWQgcmVjaXBpZW50LCBhbnkgZGlzY2xvc3VyZSwgY29weWluZywg
ZGlzdHJpYnV0aW9uIG9yIGFueSBhY3Rpb24gdGFrZW4gb3Igb21pdHRlZCB0byBiZSB0YWtlbiBi
YXNlZCBvbiBpdCwgaXMgc3RyaWN0bHkgcHJvaGliaXRlZCBhbmQgbWF5IGJlIHVubGF3ZnVsLg0K

