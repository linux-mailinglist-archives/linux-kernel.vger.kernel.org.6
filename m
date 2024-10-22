Return-Path: <linux-kernel+bounces-376671-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A13B99AB4AC
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 19:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A711C22795
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 17:06:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEF11BCA02;
	Tue, 22 Oct 2024 17:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cwjN2oOp"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3C2A1BC9F5
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 17:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729616747; cv=none; b=K9XLcdRTTkAL8Oy9fC7qjU+s+31Usy/3HvLT1NFKjccpKUbrQwKZ5N11lxZ6adeaaJT2XE/UUf1iWaAAZYrwbL24NDl1adaU18z5Z6vFWUY3GeNcoVysfU2/6PcmzM8F8l5h1iisBP//dQ+RItXN9YBtRpGHQFsMFT6DdFAJr1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729616747; c=relaxed/simple;
	bh=5WoM5/pSE8ONTKM5zYv9A5mpFJxmxMy6tOkTcchpoBs=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:In-Reply-To; b=Pmi7J/PNDBNdiPBcNN811J9qxMKpzgQ8LIrMj6pgj8WfmoaVj3/vAlLleoyvpzrC10lMz6Xff0UpfQ1s3wG4D8hwVDBrtsYxrZTkTV6RSUtKPsrCRgtPjJls3VBwQX3fGEK9Qs8RLgCrmSNsGa9GdbaovOK8aPxzwRkOiB7vnN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cwjN2oOp; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5c9362c26d8so37266a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 10:05:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729616743; x=1730221543; darn=vger.kernel.org;
        h=in-reply-to:content-language:from:references:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5WoM5/pSE8ONTKM5zYv9A5mpFJxmxMy6tOkTcchpoBs=;
        b=cwjN2oOpnJV8Vd7QxJNKvzfvE2GEW0PNKh5Bj7AHScFV77z71wMax0ph9NYjM9iF1G
         NNGVmaBXVZchY7XD82WuZ/wbl2kSHCJvAnI79k9fh29hKXWRCIajUDmnFsfghHcrC5oW
         qrb7TPsZOCnPBoDlkq9NYFt0oEeeTcXI4xCQzuRwbq0EsSqt/NU9L1Rj2yttIaAGkoWI
         79regxmKGqmkuKj9XPZTwe68k4+zat5PcI8STlUupZh7IXn+z8lll8wuXHC7bHK7qApZ
         XFsKOVLAzs4fkplVzCuOrGg9zjzg8gKfqC/ppw7XptT8M4IME3vIuJUHQ5vrKdr0CknN
         oNSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729616743; x=1730221543;
        h=in-reply-to:content-language:from:references:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5WoM5/pSE8ONTKM5zYv9A5mpFJxmxMy6tOkTcchpoBs=;
        b=nd77veCQr4bpoZ+94irDSWUiUUme8ChfUGQOCXpqDg9wxZ9MYKxBrSGwfg31cS6hpU
         e5etkKYyNNzmjm7ngpZZzmbSWAYt+XAifF6Ll6c3PIxz8YKkR7LRPCheO2MyL0+iCrGg
         vexjCrrfBUoxiMAUi/LYTb/J0FxiKVe7eiqCW6AEk1nvOfZWXJxW3xO/cXt6ZMwAHwu7
         d3TnikOUgSF4B3+Txmc86WvrdvrbGkQCdv3RL6v7jHPKF9K4+19PDZIavv2dzTQLjdcV
         4v5LHBxeGn0VnC1ik6nFCptfaBzLWJYLm71Eq78ljrvVbhsT06mZxIMYm5sv7/6O+b6/
         or7w==
X-Forwarded-Encrypted: i=1; AJvYcCXBHezc2qKMoZj1ynO9WQsvsZYUGbbDf8uDPuWQ4BgeCsvnv/aVsuNu+MxNjRYyskM6ZzdtRcew9P7KpHg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzsu5xZiT9ewLwYRnJvFF3+dGerRX0DGAxEPyXMPRXaFp4KaiRr
	AEReWFBGxM+02S0inT4ULciVl3AP0dGMJbNs8iS/+5kba4GkuF2D
X-Google-Smtp-Source: AGHT+IErIpuj0lxss73OnR3MZ24fkROJv559XUCpyzqz1ktDkY03q5IvU3GVKHSZIftghgn6p3RWqA==
X-Received: by 2002:a05:6402:4410:b0:5c8:d9b8:9325 with SMTP id 4fb4d7f45d1cf-5cb7945cebdmr4512893a12.5.1729616742975;
        Tue, 22 Oct 2024 10:05:42 -0700 (PDT)
Received: from ?IPV6:2a01:e11:5400:7400:850c:5867:abe5:b8c9? ([2a01:e11:5400:7400:850c:5867:abe5:b8c9])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb6696b530sm3364306a12.2.2024.10.22.10.05.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 10:05:41 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------wOqDG0apWDVPMEj0aUcjt0Tb"
Message-ID: <aa391b1b-ab60-443e-80b2-06698707f8d8@gmail.com>
Date: Tue, 22 Oct 2024 19:05:39 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in __hfs_ext_cache_extent (2)
To: syzbot <syzbot+d395b0c369e492a17530@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <6717ca24.050a0220.10f4f4.0150.GAE@google.com>
From: Gianfranco Trad <gianf.trad@gmail.com>
Content-Language: en-US, it
In-Reply-To: <6717ca24.050a0220.10f4f4.0150.GAE@google.com>

This is a multi-part message in MIME format.
--------------wOqDG0apWDVPMEj0aUcjt0Tb
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test

// test if KMSAN bug was truly fixed and only BUG() happens now
--------------wOqDG0apWDVPMEj0aUcjt0Tb
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-hfs-zero-initialize-ptr-handle-no-root-and-comment-B.patch"
Content-Disposition: attachment;
 filename*0="0001-hfs-zero-initialize-ptr-handle-no-root-and-comment-B.pa";
 filename*1="tch"
Content-Transfer-Encoding: base64

RnJvbSAwMDYwOTJlODUwMDEwN2U0MTcwNGNjNGMxMzI2OGE4ZDNhOTFkZWI2IE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBHaWFuZnJhbmNvIFRyYWQgPGdpYW5mLnRyYWRAZ21h
aWwuY29tPgpEYXRlOiBUdWUsIDIyIE9jdCAyMDI0IDE5OjAxOjU1ICswMjAwClN1YmplY3Q6
IFtQQVRDSF0gaGZzOiB6ZXJvLWluaXRpYWxpemUgcHRyLCBoYW5kbGUgbm8gcm9vdCBhbmQg
Y29tbWVudCBCVUcoKQoKU2lnbmVkLW9mZi1ieTogR2lhbmZyYW5jbyBUcmFkIDxnaWFuZi50
cmFkQGdtYWlsLmNvbT4KLS0tCiBmcy9oZnMvYmZpbmQuYyAgfCAyICstCiBmcy9oZnMvZXh0
ZW50LmMgfCAyICsrCiBmcy9oZnMvaW5vZGUuYyAgfCAyICstCiAzIGZpbGVzIGNoYW5nZWQs
IDQgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9oZnMv
YmZpbmQuYyBiL2ZzL2hmcy9iZmluZC5jCmluZGV4IGVmOTQ5OGE2ZTg4YS4uYzc0ZDg2NGJj
MjllIDEwMDY0NAotLS0gYS9mcy9oZnMvYmZpbmQuYworKysgYi9mcy9oZnMvYmZpbmQuYwpA
QCAtMTgsNyArMTgsNyBAQCBpbnQgaGZzX2ZpbmRfaW5pdChzdHJ1Y3QgaGZzX2J0cmVlICp0
cmVlLCBzdHJ1Y3QgaGZzX2ZpbmRfZGF0YSAqZmQpCiAKIAlmZC0+dHJlZSA9IHRyZWU7CiAJ
ZmQtPmJub2RlID0gTlVMTDsKLQlwdHIgPSBrbWFsbG9jKHRyZWUtPm1heF9rZXlfbGVuICog
MiArIDQsIEdGUF9LRVJORUwpOworCXB0ciA9IGt6YWxsb2ModHJlZS0+bWF4X2tleV9sZW4g
KiAyICsgNCwgR0ZQX0tFUk5FTCk7CiAJaWYgKCFwdHIpCiAJCXJldHVybiAtRU5PTUVNOwog
CWZkLT5zZWFyY2hfa2V5ID0gcHRyOwpkaWZmIC0tZ2l0IGEvZnMvaGZzL2V4dGVudC5jIGIv
ZnMvaGZzL2V4dGVudC5jCmluZGV4IDRhMGNlMTMxZTIzMy4uMTRmZDBhN2JjYTE0IDEwMDY0
NAotLS0gYS9mcy9oZnMvZXh0ZW50LmMKKysrIGIvZnMvaGZzL2V4dGVudC5jCkBAIC0xNjAs
NiArMTYwLDggQEAgc3RhdGljIGlubGluZSBpbnQgX19oZnNfZXh0X3JlYWRfZXh0ZW50KHN0
cnVjdCBoZnNfZmluZF9kYXRhICpmZCwgc3RydWN0IGhmc19leHQKIAlpZiAoZmQtPmtleS0+
ZXh0LkZOdW0gIT0gZmQtPnNlYXJjaF9rZXktPmV4dC5GTnVtIHx8CiAJICAgIGZkLT5rZXkt
PmV4dC5Ga1R5cGUgIT0gZmQtPnNlYXJjaF9rZXktPmV4dC5Ga1R5cGUpCiAJCXJldHVybiAt
RU5PRU5UOworCWlmICghZmQtPnRyZWUtPnJvb3QgJiYgcmVzID09IC1FTk9FTlQpCisJCXJl
dHVybiAtRU5PRU5UOwogCWlmIChmZC0+ZW50cnlsZW5ndGggIT0gc2l6ZW9mKGhmc19leHRl
bnRfcmVjKSkKIAkJcmV0dXJuIC1FSU87CiAJaGZzX2Jub2RlX3JlYWQoZmQtPmJub2RlLCBl
eHRlbnQsIGZkLT5lbnRyeW9mZnNldCwgc2l6ZW9mKGhmc19leHRlbnRfcmVjKSk7CmRpZmYg
LS1naXQgYS9mcy9oZnMvaW5vZGUuYyBiL2ZzL2hmcy9pbm9kZS5jCmluZGV4IGE4MWNlN2E3
NDBiOS4uYTNiYzQzZGJiZTE0IDEwMDY0NAotLS0gYS9mcy9oZnMvaW5vZGUuYworKysgYi9m
cy9oZnMvaW5vZGUuYwpAQCAtNDQxLDcgKzQ0MSw3IEBAIGludCBoZnNfd3JpdGVfaW5vZGUo
c3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IHdyaXRlYmFja19jb250cm9sICp3YmMpCiAJ
CQloZnNfYnRyZWVfd3JpdGUoSEZTX1NCKGlub2RlLT5pX3NiKS0+Y2F0X3RyZWUpOwogCQkJ
cmV0dXJuIDA7CiAJCWRlZmF1bHQ6Ci0JCQlCVUcoKTsKKwkJCS8vQlVHKCk7CiAJCQlyZXR1
cm4gLUVJTzsKIAkJfQogCX0KLS0gCjIuNDMuMAoK

--------------wOqDG0apWDVPMEj0aUcjt0Tb--

