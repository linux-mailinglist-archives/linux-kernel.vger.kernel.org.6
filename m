Return-Path: <linux-kernel+bounces-396490-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B4399BCDE4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 14:33:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11CD8B21545
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 13:33:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BA2F1D6DD1;
	Tue,  5 Nov 2024 13:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SW06AOB5"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4751D5AD1
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 13:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730813605; cv=none; b=NVvVBd3Eh+FbOLo0VDrZvS0gxCrb8PoYiTnKMEfPLozUeFX2M8T5ZEZgC04gCQNxZzT/5na8Lynun5qT14+nB5qlw+DbmbiWA6UjcqPJknW0O3Vlrp33q7GbfSJcJpdFp3lRsFUfQfP2bYplDwhEHGEcyeclhkqrBKwDnEi5BNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730813605; c=relaxed/simple;
	bh=9ZAx6RKaBW+uvUociEEJSd5QvXMe5bO1C9hKjyvTVA4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qVR+qk5Iz38HZMTAsSqA0/p1QHa/U/o+F0OAQ+zECa4NtOXKSOPeM09lz59awHozlsT1VOSmT3bZ/AS3PVzUQBLWhxOBoru6D/asZSbzk3+s0W1RBgQUkghNnXOX4UZkPveWwAbTRSAtIqCVKeYNL2WEbVXyFxD4jxDIsz04Mmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SW06AOB5; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a9eb3794a04so118385866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Nov 2024 05:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730813602; x=1731418402; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yS9CKAxFi0w3PfJVeVucDDV+ikZ58S92XwVj8QxMmsU=;
        b=SW06AOB5bnipjbVWAmmBa0V4by/+KrxK2cGb8hmXeS55tfbBbaEPWeaQD55s/oFxg1
         qEFTs3SFFo3fuPq8N4JaPJICAGxyQxrnxwiA9GdxQFaLfv9E1wET78igrPhsuJLbrQ2g
         6Xqlu7rj+n8j+mIjRqEDvRHsPV5hLT0tixbAHmbhU5e6fa5G//jQJlmZxlOkf2SFuTGG
         nqnmH49btvWeFWQj/yVt53SKul26ttvvtk2N6C6j6pmv1mXQxS8JjqcyON2B0McqHXI3
         wYNbykJiCM9KFYgEJYgDbXTngwwqr4HO9eq5v/gvD1ihXSBo3OKJntHQfb3iQBuPII3q
         qWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730813602; x=1731418402;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yS9CKAxFi0w3PfJVeVucDDV+ikZ58S92XwVj8QxMmsU=;
        b=CwUiQ6jkUH1daTme6/EkxE3CECuB39l7euNEj+YrqDLQC3N6Hm7eDtf/VYk3ZF4ZLW
         KEP15oMUDM6aJGo9Z7z9DXSbu69oc32/XqgX6tcsdv4GFtsDqgnp5ldNMBYUVq+nMk1D
         2ggszCvX5UjVYnfeRSjUQNZWZCJM0Uzfun/rZwgS2GpVrS7PCBSMvTfvqgA7fT621Orm
         7iiy7VWUQjnFr3bdNVCfnPYea32TPMWCs3NtihiZZMGlMJucLwlox5W6yLTzRIAtAX0l
         lPLe97ZF6tIwgfK3iBy0/p4IOCOJCRTACYmyPnzNOF7WyPcNkaMadqKDqE/6zzwiE7AS
         tMHA==
X-Forwarded-Encrypted: i=1; AJvYcCVoAm4Dal7IJj210UdKanYqbQQaKoMShCMj4Ic0z68DUUaHlSb1plCnmmsPphxNPQ3iGxPFx+kyekJFYd0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJvL2+4iD7NiHZm61RLdkv/LOH9bUSHJf2xePYN4XQLTsigMlY
	grjSTEmprtjZipa8WXjy+l/zdfQ6sgAFvOwHh2fSISIfmBWrDTNUykQivGyHsj3KTKCd38PKelc
	Dy7TwVHQ5J6fAm1/cDmSQydL0fMFxFUaI
X-Google-Smtp-Source: AGHT+IHfsSIqPF7PiOPvT9G7Wi8FihaVtoBUq+ZGPZ2ODUjk4jlQSHdewmXqsuHPGkpNKc2mn3efvHTksCsfKtltyKA=
X-Received: by 2002:a17:907:e2a7:b0:a9e:b14e:f912 with SMTP id
 a640c23a62f3a-a9eb14ef9eamr274701866b.23.1730813601957; Tue, 05 Nov 2024
 05:33:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Suraj Sonawane <surajsonawane0215@gmail.com>
Date: Tue, 5 Nov 2024 19:02:45 +0530
Message-ID: <CAHiZj8jogtw4qmoY2gBGfX2gwjBqro=XbZJU=sJzOu-e3gQiRA@mail.gmail.com>
Subject: Re: [syzbot] [ntfs3?] KMSAN: uninit-value in ntfs_read_bh
To: syzbot+7a2ba6b7b66340cff225@syzkaller.appspotmail.com
Cc: syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000eaebf206262a710d"

--000000000000eaebf206262a710d
Content-Type: multipart/alternative; boundary="000000000000eaebf106262a710b"

--000000000000eaebf106262a710b
Content-Type: text/plain; charset="UTF-8"

#syz test

--000000000000eaebf106262a710b
Content-Type: text/html; charset="UTF-8"

<div dir="ltr"><div>#syz test</div></div>

--000000000000eaebf106262a710b--
--000000000000eaebf206262a710d
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-fs-ntfs3-fix-uninit-value-in-ntfs_read_bh.patch"
Content-Disposition: attachment; 
	filename="0001-fs-ntfs3-fix-uninit-value-in-ntfs_read_bh.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m34hovvn0>
X-Attachment-Id: f_m34hovvn0

RnJvbSA5ZmIwMjZjYjMzZmJhODA5ZmUyM2ViMThmOTk3MTQwMDIxZjFiZDg0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdXJhaiBTb25hd2FuZSA8c3VyYWpzb25hd2FuZTAyMTVAZ21h
aWwuY29tPgpEYXRlOiBUdWUsIDUgTm92IDIwMjQgMTg6NDY6NTcgKzA1MzAKU3ViamVjdDogW1BB
VENIXSBmczogbnRmczM6IGZpeCB1bmluaXQtdmFsdWUgaW4gbnRmc19yZWFkX2JoCgpzeXogdGVz
dAoKU2lnbmVkLW9mZi1ieTogU3VyYWogU29uYXdhbmUgPHN1cmFqc29uYXdhbmUwMjE1QGdtYWls
LmNvbT4KLS0tCiBmcy9udGZzMy9mc250ZnMuYyB8IDQgKysrLQogMSBmaWxlIGNoYW5nZWQsIDMg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2ZzL250ZnMzL2ZzbnRm
cy5jIGIvZnMvbnRmczMvZnNudGZzLmMKaW5kZXggMGZhNjM2MDM4Li5hZjViYTczNzggMTAwNjQ0
Ci0tLSBhL2ZzL250ZnMzL2ZzbnRmcy5jCisrKyBiL2ZzL250ZnMzL2ZzbnRmcy5jCkBAIC0xMzEy
LDggKzEzMTIsMTAgQEAgaW50IG50ZnNfcmVhZF9iaChzdHJ1Y3QgbnRmc19zYl9pbmZvICpzYmks
IGNvbnN0IHN0cnVjdCBydW5zX3RyZWUgKnJ1biwgdTY0IHZibywKIHsKIAlpbnQgZXJyID0gbnRm
c19yZWFkX3J1bl9uYihzYmksIHJ1biwgdmJvLCByaGRyLCBieXRlcywgbmIpOwogCi0JaWYgKGVy
cikKKwlpZiAoZXJyKSB7CisJCW1lbXNldChyaGRyLCAwLCBzaXplb2YoKnJoZHIpKTsKIAkJcmV0
dXJuIGVycjsKKwl9CiAJcmV0dXJuIG50ZnNfZml4X3Bvc3RfcmVhZChyaGRyLCBuYi0+Ynl0ZXMs
IHRydWUpOwogfQogCi0tIAoyLjM0LjEKCg==
--000000000000eaebf206262a710d--

