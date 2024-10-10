Return-Path: <linux-kernel+bounces-358631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A60F9981C3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 11:15:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C944E1F277DC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 09:15:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F131BDA80;
	Thu, 10 Oct 2024 09:12:05 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B461A0AF5
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 09:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728551524; cv=none; b=IHuUEx8k14nJQ7WIuWQu0Q1TxtC/1yWYcFeLz+rGDqTvQRHyF8AYqcMeYidmuerB787dkgmk6UlUE/Obp1Okfa8HqDUwlKGogTgHsJHZtPSKHQQveBRjRBdIlYWoHMCV1jSCGaLnFtnwKspwE6HiDOxmNmMvWM8++empxvQXDz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728551524; c=relaxed/simple;
	bh=Baa1CNuR+wNXGnAjKzqW4Zh2XNIJUVFwC7+X15892H0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=W3L55K7PajU21QdRcbHQha5YZE+bwhXvNJZnDf1qvZzm4um0fk8J3Jcw4qETfhfqq2b8ksALUY8a1c8dZeIdclQ0uQBD33r4sBBN9a7W8eoeTa8socVwTsfwaBLS09b2gQ0yBWIjC5jSY/nuV2AG0FGiyC33ItuuY59TzYd2o0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a363981933so10069485ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 02:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728551522; x=1729156322;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Baa1CNuR+wNXGnAjKzqW4Zh2XNIJUVFwC7+X15892H0=;
        b=SgjU5EDoNfpR6jWECmFutRZe5jPe2Mk1hEdevA4ZbS0givYDSjTQWGexjtJojI2nfn
         t4F1dFSyySV3m23ppkM2zuYRLA00wW1p92pi/qTV/6rb9ZtODeHpT2KE+jVh/auPsVz0
         B6xOje4Ls9IEjPNs5MWVlRCj3B7gjq5o4qGi3UBsb8eEV86iQ1A1XGlF+sktCsxaZGN2
         mVDY7ctnRbzeo7hSs7MNx4aJHi6B2W2qvBSrIfTgo16ko3X2NjSe2BWuFC3pika0UwLE
         ubSmANeuyRqj/njIxHCUaXE+Xvd7od2fAApnxOVpn2ngXtIN/dgkShOjccnQHQviOGJY
         Mt0Q==
X-Gm-Message-State: AOJu0YygbKH93lCulbpKt1ItPFoNewTihVIwxQvMhG16OgeM8RJH/IDa
	ZUW3/hk70zpsqPnQSsOCoI6zG6eSpqByo1LQookDW4LJWGGD0A1Hgg0CzDIqtAw7z6cIqAVowEM
	yZ9Jwu7HVGzWuR/3OC+4yotcAadfNwa1xEIpkQ/beYaJ7ees1/A4e4Lc=
X-Google-Smtp-Source: AGHT+IFaKdWQgTqybtJvEbjsXxg98EIrKZW7ymE33gr5JNDcKswveOXhFq3BEQXWUhzZelJTtEy4rqmn0G6LlOIapydxGgjXbrNe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c05:b0:3a0:a4ac:ee36 with SMTP id
 e9e14a558f8ab-3a397ced8bfmr59276825ab.5.1728551522480; Thu, 10 Oct 2024
 02:12:02 -0700 (PDT)
Date: Thu, 10 Oct 2024 02:12:02 -0700
In-Reply-To: <000000000000657ecd0614456af8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67079a62.050a0220.8109b.0004.GAE@google.com>
Subject: Re: [syzbot] Re: [syzbot] [net?] KASAN: slab-use-after-free Read in __ethtool_get_link_ksettings
From: syzbot <syzbot+5fe14f2ff4ccbace9a26@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

Rm9yIGFyY2hpdmFsIHB1cnBvc2VzLCBmb3J3YXJkaW5nIGFuIGluY29taW5nIGNvbW1hbmQgZW1h
aWwgdG8KbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZywgc3l6a2FsbGVyLWJ1Z3NAZ29vZ2xl
Z3JvdXBzLmNvbS4KCioqKgoKU3ViamVjdDogUmU6IFtzeXpib3RdIFtuZXQ/XSBLQVNBTjogc2xh
Yi11c2UtYWZ0ZXItZnJlZSBSZWFkIGluIF9fZXRodG9vbF9nZXRfbGlua19rc2V0dGluZ3MKQXV0
aG9yOiBjbWVpb2hhc0BudmlkaWEuY29tCgojc3l6IHRlc3Q6IGh0dHBzOi8vZ2l0Lmtlcm5lbC5v
cmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3JkbWEvcmRtYS5naXQgZm9yLW5leHQNCg0KZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvaW5maW5pYmFuZC9jb3JlL2RldmljZS5jIGIvZHJpdmVycy9pbmZp
bmliYW5kL2NvcmUvZGV2aWNlLmMNCmluZGV4IDkzYzZkMjdiNWQ4Zi4uZWFmZGYxNzQxNTgyIDEw
MDY0NA0KLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL2NvcmUvZGV2aWNlLmMNCisrKyBiL2RyaXZl
cnMvaW5maW5pYmFuZC9jb3JlL2RldmljZS5jDQpAQCAtMjA2MiwxOSArMjA2MiwxNCBAQCB2b2lk
IGliX2Rpc3BhdGNoX2V2ZW50X2NsaWVudHMoc3RydWN0IGliX2V2ZW50ICpldmVudCkNCsKgwqDC
oMKgIHVwX3JlYWQoJmV2ZW50LT5kZXZpY2UtPmV2ZW50X2hhbmRsZXJfcndzZW0pOw0KwqB9DQoN
Ci1zdGF0aWMgaW50IGl3X3F1ZXJ5X3BvcnQoc3RydWN0IGliX2RldmljZSAqZGV2aWNlLA0KLcKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgdTMyIHBvcnRfbnVtLA0KLcKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqAgc3RydWN0IGliX3BvcnRfYXR0ciAqcG9ydF9hdHRyKQ0KK3N0YXRpYyBp
bnQgaXdfcXVlcnlfcG9ydChzdHJ1Y3QgaWJfZGV2aWNlICpkZXZpY2UsIHUzMiBwb3J0X251bSwN
CivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBp
Yl9wb3J0X2F0dHIgKnBvcnRfYXR0ciwNCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIHN0cnVjdCBuZXRfZGV2aWNlICpuZXRkZXYpDQrCoHsNCsKgwqDCoMKg
IHN0cnVjdCBpbl9kZXZpY2UgKmluZXRkZXY7DQotwqDCoMKgIHN0cnVjdCBuZXRfZGV2aWNlICpu
ZXRkZXY7DQoNCsKgwqDCoMKgIG1lbXNldChwb3J0X2F0dHIsIDAsIHNpemVvZigqcG9ydF9hdHRy
KSk7DQoNCi3CoMKgwqAgbmV0ZGV2ID0gaWJfZGV2aWNlX2dldF9uZXRkZXYoZGV2aWNlLCBwb3J0
X251bSk7DQotwqDCoMKgIGlmICghbmV0ZGV2KQ0KLcKgwqDCoMKgwqDCoMKgIHJldHVybiAtRU5P
REVWOw0KLQ0KwqDCoMKgwqAgcG9ydF9hdHRyLT5tYXhfbXR1ID0gSUJfTVRVXzQwOTY7DQrCoMKg
wqDCoCBwb3J0X2F0dHItPmFjdGl2ZV9tdHUgPSBpYl9tdHVfaW50X3RvX2VudW0obmV0ZGV2LT5t
dHUpOw0KDQpAQCAtMjA5Nyw3ICsyMDkyLDYgQEAgc3RhdGljIGludCBpd19xdWVyeV9wb3J0KHN0
cnVjdCBpYl9kZXZpY2UgKmRldmljZSwNCsKgwqDCoMKgwqDCoMKgwqAgcmN1X3JlYWRfdW5sb2Nr
KCk7DQrCoMKgwqDCoCB9DQoNCi3CoMKgwqAgZGV2X3B1dChuZXRkZXYpOw0KwqDCoMKgwqAgcmV0
dXJuIGRldmljZS0+b3BzLnF1ZXJ5X3BvcnQoZGV2aWNlLCBwb3J0X251bSwgcG9ydF9hdHRyKTsN
CsKgfQ0KDQpAQCAtMjEzNSwxMyArMjEyOSwyNyBAQCBpbnQgaWJfcXVlcnlfcG9ydChzdHJ1Y3Qg
aWJfZGV2aWNlICpkZXZpY2UsDQrCoMKgwqDCoMKgwqDCoMKgwqDCoCB1MzIgcG9ydF9udW0sDQrC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgaWJfcG9ydF9hdHRyICpwb3J0X2F0dHIpDQrCoHsN
CivCoMKgwqDCoMKgwqAgc3RydWN0IG5ldF9kZXZpY2UgKm5ldGRldiA9IE5VTEw7DQorwqDCoMKg
wqDCoMKgIGludCByZXQ7DQorDQrCoMKgwqDCoCBpZiAoIXJkbWFfaXNfcG9ydF92YWxpZChkZXZp
Y2UsIHBvcnRfbnVtKSkNCsKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7DQoNCivCoMKg
wqDCoMKgwqAgaWYgKHJkbWFfcHJvdG9jb2xfaXdhcnAoZGV2aWNlLCBwb3J0X251bSkgfHwNCivC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZG1hX3Byb3RvY29sX3JvY2UoZGV2aWNlLCBwb3J0X251bSkp
IHsNCivCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIG5ldGRldiA9IGliX2RldmljZV9nZXRf
bmV0ZGV2KGRldmljZSwgcG9ydF9udW0pOw0KK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
aWYgKCFuZXRkZXYpDQorwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgcmV0dXJuIC1FTk9ERVY7DQorwqDCoMKgwqDCoMKgIH0NCisNCsKgwqDCoMKgIGlmIChyZG1h
X3Byb3RvY29sX2l3YXJwKGRldmljZSwgcG9ydF9udW0pKQ0KLcKgwqDCoMKgwqDCoMKgIHJldHVy
biBpd19xdWVyeV9wb3J0KGRldmljZSwgcG9ydF9udW0sIHBvcnRfYXR0cik7DQorwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBpd19xdWVyeV9wb3J0KGRldmljZSwgcG9ydF9udW0s
IHBvcnRfYXR0ciwgbmV0ZGV2KTsNCsKgwqDCoMKgIGVsc2UNCi3CoMKgwqDCoMKgwqDCoCByZXR1
cm4gX19pYl9xdWVyeV9wb3J0KGRldmljZSwgcG9ydF9udW0sIHBvcnRfYXR0cik7DQorwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByZXQgPSBfX2liX3F1ZXJ5X3BvcnQoZGV2aWNlLCBwb3J0
X251bSwgcG9ydF9hdHRyKTsNCivCoMKgwqDCoMKgwqAgaWYgKG5ldGRldikNCivCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGRldl9wdXQobmV0ZGV2KTsNCivCoMKgwqDCoMKgwqAgcmV0dXJu
IHJldDsNCisNCsKgfQ0KwqBFWFBPUlRfU1lNQk9MKGliX3F1ZXJ5X3BvcnQpOw0KDQpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbmV0LmMgYi9kcml2ZXJzL2luZmlu
aWJhbmQvc3cvcnhlL3J4ZV9uZXQuYw0KaW5kZXggNzVkMTQwN2RiNTJkLi5jNWQ0MzliZWJjMjQg
MTAwNjQ0DQotLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcnhlL3J4ZV9uZXQuYw0KKysrIGIv
ZHJpdmVycy9pbmZpbmliYW5kL3N3L3J4ZS9yeGVfbmV0LmMNCkBAIC02MDUsNiArNjA1LDcgQEAg
c3RhdGljIGludCByeGVfbm90aWZ5KHN0cnVjdCBub3RpZmllcl9ibG9jayAqbm90X2JsaywNCg0K
wqDCoMKgwqAgc3dpdGNoIChldmVudCkgew0KwqDCoMKgwqAgY2FzZSBORVRERVZfVU5SRUdJU1RF
UjoNCivCoMKgwqDCoMKgwqDCoCBpYl9kZXZpY2Vfc2V0X25ldGRldigmcnhlLT5pYl9kZXYsIE5V
TEwsIDEpOw0KwqDCoMKgwqDCoMKgwqDCoCBpYl91bnJlZ2lzdGVyX2RldmljZV9xdWV1ZWQoJnJ4
ZS0+aWJfZGV2KTsNCsKgwqDCoMKgwqDCoMKgwqAgYnJlYWs7DQrCoMKgwqDCoCBjYXNlIE5FVERF
Vl9VUDoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tYWluLmMg
Yi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tYWluLmMNCmluZGV4IDE3YWJlZjQ4YWJj
ZC4uMWI3ZDM0Nzk4NzgzIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pbmZpbmliYW5kL3N3L3Npdy9z
aXdfbWFpbi5jDQorKysgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvc2l3L3Npd19tYWluLmMNCkBA
IC00MDAsNiArNDAwLDcgQEAgc3RhdGljIGludCBzaXdfbmV0ZGV2X2V2ZW50KHN0cnVjdCBub3Rp
Zmllcl9ibG9jayAqbmIsIHVuc2lnbmVkIGxvbmcgZXZlbnQsDQrCoMKgwqDCoMKgwqDCoMKgIGJy
ZWFrOw0KDQrCoMKgwqDCoCBjYXNlIE5FVERFVl9VTlJFR0lTVEVSOg0KK8KgwqDCoMKgwqDCoMKg
IGliX2RldmljZV9zZXRfbmV0ZGV2KCZzZGV2LT5iYXNlX2RldiwgTlVMTCwgMSk7DQrCoMKgwqDC
oMKgwqDCoMKgIGliX3VucmVnaXN0ZXJfZGV2aWNlX3F1ZXVlZCgmc2Rldi0+YmFzZV9kZXYpOw0K
wqDCoMKgwqDCoMKgwqDCoCBicmVhazsNCg0K

