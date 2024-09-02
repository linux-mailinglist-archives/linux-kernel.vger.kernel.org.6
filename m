Return-Path: <linux-kernel+bounces-311309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 71476968768
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 14:23:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB196B25B93
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Sep 2024 12:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB44C19E989;
	Mon,  2 Sep 2024 12:23:01 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0333619E96A
	for <linux-kernel@vger.kernel.org>; Mon,  2 Sep 2024 12:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725279781; cv=none; b=OXBYGlh3C81blLkv1ERtq8LYeXSUzGxyYBXXP5i3ohdrlfiWdK3VCttFYGuXVxFpABpNlEVLLeW/6DB2a/DAUD3jLTh4vhpjN4c7oZnVYkRmw1rS9tw2M8fo6Zl1IFry+uNATTXcyKl9YJQZBDzi2skiSB2wRhkEuzKn0YYQL5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725279781; c=relaxed/simple;
	bh=vKfepV5JiNrtb0eXNfv6Iph0aQ36MuKv4ReA9fhmGtA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=uMspMvw12oqCCO/5wv5txLTeMeINw0iO6veoAFeuhOFuXPIGDqS2n6KRD16/FtTd0pYw91pSAQBRRlyWW7Fgr66p5oYUsG0BCXU30dg+GNXRbpiGEtKoduY0a8oGseB24f69f5vnLQCcXpHhUX3Yr1dtFIYOpy2+qsjWb7Czss8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82a4f65fa5aso88486639f.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Sep 2024 05:22:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725279779; x=1725884579;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vKfepV5JiNrtb0eXNfv6Iph0aQ36MuKv4ReA9fhmGtA=;
        b=YaJXb6985OlIjbVXknYd8TQ63wfIK9I2YIrerpjuV0y4Sn7Qc/zJ0IBZaP7EEcfBrV
         CriDXHFWmHMPqRf0L4i6Tew41QMFOdeLmgd2d4KWsJMBWUoAhHkj4TtJgt/bveOp+0+S
         gXNF7yhWrXQwfA6+JNfWARDZo/DzZsO1nYcP0BbmPbhLxrlKO8rpBFOXA9w/6EYPZYhA
         RJuI+0w1ZqXu1FKJgHSuTXn3B4fCkgd35B53qsu+vKmBGly12rgkxB1fJrIo5TL9VBl6
         WHIy/ZuTILqoiXAuuFahFKPRbrcI0RcWzCmlsRs3Lz2jXi3Oq0NPJiSBmKmtyPKenBX3
         8vIw==
X-Forwarded-Encrypted: i=1; AJvYcCX38ers4Jil4iLNDnksyr0U6zysCWwRYX3BgeC6E5PAr0xKk9v4q9T8E+RofQlL+2Wc2pXjbfj0hGsIZB0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiQoqSZcmSb4umt1mmLLdl67jvWxCBKguhcNNMXd4NGUw9XokC
	E8J8sz4CPLDXg1ayudnL4s8DUcRjN3Ty79cCR5Uyz/q9Zxml8eVe9tK7r5rHVYOQTFhSg9dqXrC
	M2fJDyMxK9qBVsFtUIy80pHfdVzz0Mnju6NO3AbvhrKe/fE2DS4G0BgM=
X-Google-Smtp-Source: AGHT+IFlj4PxSqtORLG+0fop5MGDjkscuYTNbgy9hUnOPkIMq3aIuQWS3xYUraMKf7qB/cdyQcSyOplMLFlVCYS6mcGs6YTb66S+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3494:b0:4ce:928f:ad9a with SMTP id
 8926c6da1cb9f-4d017a1e518mr437269173.1.1725279779077; Mon, 02 Sep 2024
 05:22:59 -0700 (PDT)
Date: Mon, 02 Sep 2024 05:22:59 -0700
In-Reply-To: <b9136b92-fdeb-4a51-887d-4648560756ba@paragon-software.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005ed0360621220006@google.com>
Subject: Re: possible fix (linux-ntfs3)
From: syzbot <syzbot+4d2aaeff9eb5a2cfec70@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com
Cc: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64

PiAjc3l6IHRlc3Q6aHR0cHM6Ly9naXRodWIuY29tL1BhcmFnb24tU29mdHdhcmUtR3JvdXAvbGlu
dXgtbnRmczMuZ2l0IG1hc3RlcgoKdW5rbm93biBjb21tYW5kICJ0ZXN0Omh0dHBzOi8vZ2l0aHVi
LmNvbS9QYXJhZ29uLVNvZnR3YXJlLUdyb3VwL2xpbnV4LW50ZnMzLmdpdCIKCj4KPiBkaWZmIC0t
Z2l0IGEvZnMvbnRmczMvc3VwZXIuYyBiL2ZzL250ZnMzL3N1cGVyLmMKPiBpbmRleCAxMjhkNDk1
MTJmNWQuLmMwOGJiYWNjMDAzMCAxMDA2NDQKPiAtLS0gYS9mcy9udGZzMy9zdXBlci5jCj4gKysr
IGIvZnMvbnRmczMvc3VwZXIuYwo+IEBAIC0xMjUsOCArMTI1LDkgQEAgdm9pZCBudGZzX2lub2Rl
X3ByaW50ayhzdHJ1Y3QgaW5vZGUgKmlub2RlLCBjb25zdCAKPiBjaGFyICpmbXQsIC4uLikKPgo+
ICDCoMKgwqDCoMKgwqDCoMKgIGlmIChkZSkgewo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
c3Bpbl9sb2NrKCZkZS0+ZF9sb2NrKTsKPiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzbnByaW50
ZihuYW1lLCBzaXplb2Yoc19uYW1lX2J1ZiksICIgXCIlc1wiIiwKPiAtwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgZGUtPmRfbmFtZS5uYW1lKTsKPiArwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpZiAoc25wcmludGYobmFtZSwgc2l6ZW9mKHNfbmFtZV9idWYpLCAiIFwiJXNcIiIsCj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGUtPmRfbmFtZS5uYW1l
KSA+PSBzaXplb2Yoc19uYW1lX2J1ZikpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCBuYW1lW3NpemVvZihzX25hbWVfYnVmKSAtIDFdID0gMDsKPiAgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIHNwaW5fdW5sb2NrKCZkZS0+ZF9sb2NrKTsKPiAgwqDCoMKgwqDCoMKgwqDCoCB9IGVs
c2Ugewo+ICDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbmFtZVswXSA9IDA7Cj4K

