Return-Path: <linux-kernel+bounces-345210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 567DE98B32C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 06:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CDD4CB23008
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 04:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B621BBBEB;
	Tue,  1 Oct 2024 04:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UkYUCVs3"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CA961BBBCA
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 04:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727758622; cv=none; b=ZIf7LeoX7bYkGrDdZOB8NxHwy2uh8RUUYSVDWQYIBtLeVRFa/onuIaqonFlINQuNdY5VU9EjZTEFgQLdjYhX0iJyHFhRP34bDqOVAL7HFnMHbcYTAR2V2Stt8jbh4rsmP0iLJicoFza8EQis71XMKpV7/Px906KviLil+IeDaxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727758622; c=relaxed/simple;
	bh=Zm7C6dMiYNNnanXzkEXKkwfGPxgUDNRUZ7ELKS32VR4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qsvYCe4ASf2Sr5X6hmRCnEzhft9D4haKMW3MTqDF4eQVe4NgSuaIrKmow69y2FLIVPwH60/kmmCSK/bPpmx1d5mZF1tS/NDbE3ydFyDzwZj6ozsjfnftqqd4tS+UpEA66wKJnMOoaHd1StFRSUJDOFzO3eZ4q4gqCBdVhLKMuTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UkYUCVs3; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2e0b0142bbfso3172813a91.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 21:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727758620; x=1728363420; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZSKvzjzgHE5WCbyYr/BVpggywu/cSDLKxkMrFa+++Dw=;
        b=UkYUCVs3eZH1zNemfZmRA2TaWuF/qp+o6R0hXoBziORGLpL/szVh1OpKKAi1GBcXqY
         rcFKluO7f3Kb0ja1mgix71NWVjM0Gro7Biwz2BfAGe02K0QPtWL8mg6Q/rQgb27fqw93
         /8cDU1p+oecRCZ72iOQs0d+SPboknvZXxS3HKiXbqF/bPOgympT5KGeKEzuOTrXtrnLt
         sy/R96j+TgGJrF9mGfklPId8TxpP56nBnVmP32Y3Hw0itYIz728QF0n8mv2aPwII++jU
         JLL1SixWqCq2LxrPI1/7ZEfJ9nlfIB8vujTffFUlZc2XHcn2BaEF+zD+9J+eeR846AQh
         BCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727758620; x=1728363420;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZSKvzjzgHE5WCbyYr/BVpggywu/cSDLKxkMrFa+++Dw=;
        b=OulIFHuEzRB2ZFGaGi6Kku9uX1wrC6SYytd9HUNk2ZMnYSrY6TWEMplHgpAJYZOikB
         Zre8kKkK5QS2VSuyOKeO/nFTNyYV1xIc3cXtLlu88mr24A7Kh4ELoo19H4Co5JT/zf2g
         5GdPbhQQlFDYH8GhpGHTIioyrMw1dVL0q9n/aWp/lxlSPKFc6gNp4g0MRWxewcTtPcBq
         TawXAA5/LFtNAIvvY5tUj2h4MPRzOJ02YuFuAzQECKx4Mmkohgkng6gHor702G9KbKDc
         1tPNuOUwx0pZXKCypkhdtwErJB8TZxbOSBV0UPf5evOlsWJXscTY737Vgb5x/S7W21Tq
         vQ5g==
X-Gm-Message-State: AOJu0YxUa9/kuNawWlfwESRk4SibTxwi9ic3Ae6ebhkC8Jky7vqQQ4w2
	8dj1zKoI9s/KPfewSv8WJTPeaW3f7j1hwBA9H19dB6ncfO3S1zUnczHv0mEBT9L509SBDECcvRc
	4pDrvnun+cpxWrM9PySIEqW6CwDQ=
X-Google-Smtp-Source: AGHT+IHbO5xJh+6jSawjx2DDLP5JeOqkeZu6nIAl9tAHEcs8q01y8BhNjk0nN+seDHDsMcJiEJioVGa6sbeYJBvCPvg=
X-Received: by 2002:a17:90b:3445:b0:2d8:89ff:db1a with SMTP id
 98e67ed59e1d1-2e15a258d92mr2948322a91.8.1727758619809; Mon, 30 Sep 2024
 21:56:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Date: Tue, 1 Oct 2024 10:26:21 +0530
Message-ID: <CAG-Bmoev_1nJTr0hVwCf16ebHekbaXo0Mnt9V7JsZeYxWtxxRw@mail.gmail.com>
Subject: UBSAN: array-index-out-of-bounds in jfs_readdir
To: syzbot+0315f8fe99120601ba88@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="000000000000cabdbb0623632686"

--000000000000cabdbb0623632686
Content-Type: text/plain; charset="UTF-8"

#syz test

--000000000000cabdbb0623632686
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-jfs-fix-array-index-out-of-bounds-in-jfs_readdir.patch"
Content-Disposition: attachment; 
	filename="0001-jfs-fix-array-index-out-of-bounds-in-jfs_readdir.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m1pytgvj0>
X-Attachment-Id: f_m1pytgvj0

RnJvbSAwNWU0ZDkyNWM5ZGVjOGVmZWQxZWEyOWIyNjE3ZDJhMDVlMThlNmZkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHaGFuc2h5YW0gQWdyYXdhbCA8Z2hhbnNoeWFtMTg5OEBnbWFp
bC5jb20+CkRhdGU6IFR1ZSwgMSBPY3QgMjAyNCAxMDoyMToxMSArMDUzMApTdWJqZWN0OiBbUEFU
Q0hdIGpmczogZml4IGFycmF5LWluZGV4LW91dC1vZi1ib3VuZHMgaW4gamZzX3JlYWRkaXIKVG86
IHNoYWdneUBrZXJuZWwub3JnLAogICAgZWFkYXZpc0BxcS5jb20sCiAgICBvc210ZW5kZXZAZ21h
aWwuY29tLAogICAgZ2hhbmRhdG1hbmFzQGdtYWlsLmNvbQpDYzogamZzLWRpc2N1c3Npb25AbGlz
dHMuc291cmNlZm9yZ2UubmV0LAogICAgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZwoKVGhl
IHN0YmwgbWlnaHQgY29udGFpbiBzb21lIGludmFsaWQgdmFsdWVzLiBBZGRlZCBhIGNoZWNrIHRv
CnJldHVybiBlcnJvciBjb2RlIGluIHRoYXQgY2FzZS4KClJlcG9ydGVkLWJ5OiBzeXpib3QrMDMx
NWY4ZmU5OTEyMDYwMWJhODhAc3l6a2FsbGVyLmFwcHNwb3RtYWlsLmNvbQpDbG9zZXM6IGh0dHBz
Oi8vc3l6a2FsbGVyLmFwcHNwb3QuY29tL2J1Zz9leHRpZD0wMzE1ZjhmZTk5MTIwNjAxYmE4OApT
aWduZWQtb2ZmLWJ5OiBHaGFuc2h5YW0gQWdyYXdhbCA8Z2hhbnNoeWFtMTg5OEBnbWFpbC5jb20+
Ci0tLQogZnMvamZzL2pmc19kdHJlZS5jIHwgOCArKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDgg
aW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2ZzL2pmcy9qZnNfZHRyZWUuYyBiL2ZzL2pmcy9q
ZnNfZHRyZWUuYwppbmRleCA1ZDMxMjdjYTY4YTQuLmM4ZjZlNTFhYzA0NyAxMDA2NDQKLS0tIGEv
ZnMvamZzL2pmc19kdHJlZS5jCisrKyBiL2ZzL2pmcy9qZnNfZHRyZWUuYwpAQCAtMjg5MSw2ICsy
ODkxLDE0IEBAIGludCBqZnNfcmVhZGRpcihzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IGRpcl9j
b250ZXh0ICpjdHgpCiAJCXN0YmwgPSBEVF9HRVRTVEJMKHApOwogCiAJCWZvciAoaSA9IGluZGV4
OyBpIDwgcC0+aGVhZGVyLm5leHRpbmRleDsgaSsrKSB7CisJCQlpZiAoc3RibFtpXSA8IDAgfHwg
c3RibFtpXSA+IDEyNykgeworCQkJCURUX1BVVFBBR0UobXApOworCQkJCWZyZWVfcGFnZShkaXJl
bnRfYnVmKTsKKwkJCQlqZnNfZXJyKCJKRlM6IEludmFsaWQgc3RibFslZF0gPSAlZCBmb3IgaW5v
ZGUgJWxkLCBibG9jayA9ICVsbGQiLAorCQkJCWksIHN0YmxbaV0sIChsb25nKWlwLT5pX2lubywg
KGxvbmcgbG9uZylibik7CisJCQkJcmV0dXJuIC1FSU87CisJCQl9CisKIAkJCWQgPSAoc3RydWN0
IGxkdGVudHJ5ICopICYgcC0+c2xvdFtzdGJsW2ldXTsKIAogCQkJaWYgKCgobG9uZykgamZzX2Rp
cmVudCArIGQtPm5hbWxlbiArIDEpID4KLS0gCjIuMzQuMQoK
--000000000000cabdbb0623632686--

