Return-Path: <linux-kernel+bounces-343517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 603E8989BEF
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 09:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E62DD1F22085
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 07:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD4E8161320;
	Mon, 30 Sep 2024 07:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y5iDAJBn"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03812A1DC
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 07:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727682773; cv=none; b=T7TTCTg9gm4c7llYoKjoZ54mQE+Cgiq6vc8MP9XZMUeiL98ySIeWSFmGmitzqsJBeSNsgUrbs7iKfxzXnZ0xRAvVBOAj3VNDl5Esff6jU++gvoDUG1h/fINdnm8Phq7f1n8mq+etHIOyOlZdRGIOc0W3FHoED53t/doPb7QtH8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727682773; c=relaxed/simple;
	bh=jD6S1l+X0XQ1ENG6gWBldBWf529TGH+PvvmguFE7F/M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=gfUdAhf54Z7PZ5SVN9TTo1Pex78DUQPYcF23drF9aUl31Wm4ofu4OyK2X2AkN9Iyc1VMPwqSPq9wq2ZVOUTIiHSdZdVz2hoz7vU/3OatWfC2M3R7FPkwr/PFHFAzPQpgmjjjl3T0xzZH539+W3zptAR7GrCwPQmS3g2iZ21eYGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y5iDAJBn; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-71b0d9535c0so2783107b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 00:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727682771; x=1728287571; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5fkh1NkuIR3qY9EFfLe6DXd0R7g4InRGM0vLr327Cts=;
        b=Y5iDAJBn6IVsSplQP+tku0/+RPBbcIGEN6RzOGgkDMUi0kd+6h25GSBXeqhSdzCpum
         w2sMuz2hfyiQ+K0JVbLadw/QBNkIwkjVle2gxbO5zmd9MQovYl6xlM+RIYAsv53Gysrh
         +0Sy4KTjDqqIJQ4L8DsgMcKPmQ21RRiU16QSVqjZmcCdnZ6vAzYjMn8/rbLlOJ4rdNzv
         s9SsBB2571xv/KM/EGmvVki0qcW2+z92y3+V9R+WN1YU+RgIms5NbBMu/2mK7IjUTGqh
         5xF8f3tByb9U4wpjriFH2dAviGp8WaSimEQlhUz2E9tjqJM+PX5egq/cxtVjeKPc2uuy
         NUVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727682771; x=1728287571;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5fkh1NkuIR3qY9EFfLe6DXd0R7g4InRGM0vLr327Cts=;
        b=t1ZZPRwTyW7ZSVdOhhbAEQV7ai0GUBLlporB80Rx+Rof0bVu5G4BKHvroxQ5jCLRQs
         Vn0xkirJxz8PcLmqqlDCDN0by8Dm1qxsa41OgouPq5xvOxMNUwLO3T8xBGi94sgCc2oO
         xzgPzUnoUv17Ze0j2YvGZyNXKcN2JTZZDSyaNg6VejCHTX/GC3mX1uBbVb9JRVULu+T/
         97u2/1I7Mg7IKz79j1ITLYX3vraUCMJnQC1Pzmwlo6mk/RRaYfdR1+4FytKlqoh2SzEq
         c3+ktxH44QS4T1ZuqLNPh61bE2TFUhn8xCd6Ca11yUqgk3/mdnz8atr7l4ZqO86YuOI5
         ShIQ==
X-Gm-Message-State: AOJu0YzdASDJHfaPmyNxVaQDOZj4fORqb6G4Npc8UUi9mGOl0RIbXpFu
	Kal70kCs9jfxof7PcdVIyLmzAR18mV6lTuveTkcIWxGeIRGZH4vxaNVW2iCzKKjTkZfVkfpLIjm
	69LCBO5wJpiLwYLCcLlDhMmCRDtaRR7v7Uus=
X-Google-Smtp-Source: AGHT+IGZna5/fpmTHYRgCm6VX19GXpewb/7tU7thbMCOp3y3uKIrEkYkqU4k3dDVfVbVU5JIA5uF1uITdGrmtHBJ/cw=
X-Received: by 2002:a05:6a21:501:b0:1d1:21a8:ee8d with SMTP id
 adf61e73a8af0-1d4fa6c8369mr16998354637.22.1727682770975; Mon, 30 Sep 2024
 00:52:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Ghanshyam Agrawal <ghanshyam1898@gmail.com>
Date: Mon, 30 Sep 2024 13:22:14 +0530
Message-ID: <CAG-BmofkSGc2Zq1GtJjoCgYwMrVhBP29Ohyhw1YfRH9pJWL3+w@mail.gmail.com>
Subject: UBSAN: shift-out-of-bounds in dbSplit (2)
To: syzbot+b5ca8a249162c4b9a7d0@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: multipart/mixed; boundary="000000000000d9bee50623517d0b"

--000000000000d9bee50623517d0b
Content-Type: text/plain; charset="UTF-8"

#syz test

--000000000000d9bee50623517d0b
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-jfs-fix-shift-out-of-bounds-in-dbSplit.patch"
Content-Disposition: attachment; 
	filename="0001-jfs-fix-shift-out-of-bounds-in-dbSplit.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_m1opo6g10>
X-Attachment-Id: f_m1opo6g10

RnJvbSA4MTM0MGFjZjAxN2ViYTY4M2EwMGJjY2VhMTg3MjQyZDkyYzI5NjBhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBHaGFuc2h5YW0gQWdyYXdhbCA8Z2hhbnNoeWFtMTg5OEBnbWFp
bC5jb20+CkRhdGU6IE1vbiwgMzAgU2VwIDIwMjQgMTM6MTY6NDYgKzA1MzAKU3ViamVjdDogW1BB
VENIXSBqZnM6IGZpeCBzaGlmdC1vdXQtb2YtYm91bmRzIGluIGRiU3BsaXQKVG86IHNoYWdneUBr
ZXJuZWwub3JnLAogICAgZ2hhbmRhdG1hbmFzQGdtYWlsLmNvbSwKICAgIGp1bnRvbmcuZGVuZ0Bv
dXRsb29rLmNvbSwKICAgIGFoYTMxMDUxMEBnbWFpbC5jb20sCiAgICBwZWlsaS5kZXZAZ21haWwu
Y29tLAogICAgZ2hhbnNoeWFtMTg5OEBnbWFpbC5jb20sCiAgICBlYWRhdmlzQHFxLmNvbQpDYzog
amZzLWRpc2N1c3Npb25AbGlzdHMuc291cmNlZm9yZ2UubmV0LAogICAgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZwoKV2hlbiBkbXRfYnVkbWluIGlzIGxlc3MgdGhhbiB6ZXJvLCBpdCBjYXVz
ZXMgZXJyb3JzCmluIHRoZSBsYXRlciBzdGFnZXMuIEFkZGVkIGEgY2hlY2sgdG8gcmV0dXJuIGFu
IGVycm9yIGJlZm9yZWhhbmQKaW4gZGJBbGxvY0N0bCBpdHNlbGYuCgpSZXBvcnRlZC1ieTogc3l6
Ym90K2I1Y2E4YTI0OTE2MmM0YjlhN2QwQHN5emthbGxlci5hcHBzcG90bWFpbC5jb20KQ2xvc2Vz
OiBodHRwczovL3N5emthbGxlci5hcHBzcG90LmNvbS9idWc/ZXh0aWQ9YjVjYThhMjQ5MTYyYzRi
OWE3ZDAKU2lnbmVkLW9mZi1ieTogR2hhbnNoeWFtIEFncmF3YWwgPGdoYW5zaHlhbTE4OThAZ21h
aWwuY29tPgotLS0KIGZzL2pmcy9qZnNfZG1hcC5jIHwgNSArKysrKwogMSBmaWxlIGNoYW5nZWQs
IDUgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2ZzL2pmcy9qZnNfZG1hcC5jIGIvZnMvamZz
L2pmc19kbWFwLmMKaW5kZXggOTc0ZWNmNWUwZDk1Li5mNjVhMDcyNTJjMjIgMTAwNjQ0Ci0tLSBh
L2ZzL2pmcy9qZnNfZG1hcC5jCisrKyBiL2ZzL2pmcy9qZnNfZG1hcC5jCkBAIC0xODA4LDYgKzE4
MDgsNyBAQCBkYkFsbG9jQ3RsKHN0cnVjdCBibWFwICogYm1wLCBzNjQgbmJsb2NrcywgaW50IGwy
bmIsIHM2NCBibGtubywgczY0ICogcmVzdWx0cykKIAlzNjQgYiwgbGJsa25vLCBuOwogCXN0cnVj
dCBtZXRhcGFnZSAqbXA7CiAJc3RydWN0IGRtYXAgKmRwOworCWRtdHJlZV90ICp0cDsKIAogCS8q
IGNoZWNrIGlmIHRoZSBhbGxvY2F0aW9uIHJlcXVlc3QgaXMgY29uZmluZWQgdG8gYSBzaW5nbGUg
ZG1hcC4KIAkgKi8KQEAgLTE4MTksNiArMTgyMCwxMCBAQCBkYkFsbG9jQ3RsKHN0cnVjdCBibWFw
ICogYm1wLCBzNjQgbmJsb2NrcywgaW50IGwybmIsIHM2NCBibGtubywgczY0ICogcmVzdWx0cykK
IAkJaWYgKG1wID09IE5VTEwpCiAJCQlyZXR1cm4gLUVJTzsKIAkJZHAgPSAoc3RydWN0IGRtYXAg
KikgbXAtPmRhdGE7CisJCXRwID0gKGRtdHJlZV90ICopICZkcC0+dHJlZTsKKworCQlpZiAodHAt
PmRtdF9idWRtaW4gPCAwKQorCQkJcmV0dXJuIC1FSU87CiAKIAkJLyogdHJ5IHRvIGFsbG9jYXRl
IHRoZSBibG9ja3MuCiAJCSAqLwotLSAKMi4zNC4xCgo=
--000000000000d9bee50623517d0b--

