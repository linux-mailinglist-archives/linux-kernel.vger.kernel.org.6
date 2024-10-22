Return-Path: <linux-kernel+bounces-377061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C2B69AB960
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 00:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DC0428453D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 22:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A011CDFC3;
	Tue, 22 Oct 2024 22:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ibrR793P"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CE581CDA2D
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 22:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729635126; cv=none; b=QZZwwCurqei56PLh0ygNQTIccjDU0f5B3pzAOZQp3NpEyeMwNboC7E8X51H59SU295A9mHKRZgqF8DGTcrSoSKJjZkjb/q5R3TQKQeGT8S93rS4gvEnAEyrc4x/K41LiF6ORN+no0gLoxUtEPp/9KIJGufD+X/6p4Yqj3J5pXJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729635126; c=relaxed/simple;
	bh=zFAqEKIjGdSp/RsFNTEtcsbni2vZO7sqUUkb4Hv2dC8=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:References:
	 From:In-Reply-To; b=NinAZ84IyJfh+Ze2pomWkQAAnRfUMLsTF+7K2MsJBeM08RifSB0+ZZLQ7ZTFdTUIkaq9u0GpcI8cZJkFgW/mhi30tDJaKRyZABYV52voBQ2aebiZ+Hq5jCGr13E8lmml6x+x30Ks4eB1D0lm0JTR5rTtvexOmddpW/1HofubYoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ibrR793P; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42f6bec84b5so67787115e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 15:12:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729635123; x=1730239923; darn=vger.kernel.org;
        h=in-reply-to:content-language:from:references:to:subject:user-agent
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zFAqEKIjGdSp/RsFNTEtcsbni2vZO7sqUUkb4Hv2dC8=;
        b=ibrR793P/NL5VZlXiPsGNfPLTj3e89bLYKW7stbn112S+drMnDbhhP13v5fu3uyRzN
         BHBwNnzMXGQRSf/rFFJY0u793Bbt9JfJja8t85pN30Sg6FLf23SKpDSW4ArU3t8QRh7N
         FWcjFjIIurWabW6QQAIChYXBlwSiECxjuhW3l1Bt6FvibP7l0fg6mTcTgwVrZ4rZEXhQ
         W9gpEEDUnaqnNUSYg63lZ4pEfICE2VTy1JJCZ5IWGriYsxt8hytNSSeRSMe27r1FY85U
         Yn41gOO42nHPRtf9mkhEDuVcriBFtkrWBYyKMiyOVmlf53OoCmdwqzO3AP3h5lqmfXWK
         c67Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729635123; x=1730239923;
        h=in-reply-to:content-language:from:references:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zFAqEKIjGdSp/RsFNTEtcsbni2vZO7sqUUkb4Hv2dC8=;
        b=FVlpRPc8JUYvN7CiidEQo0HFYS37JlmtAbm/Payzcwa+oRhANuQwiETZsTzpNxhGAj
         VP0OOD+NTVStK0zXbddsWL0gFT6c9b7AYBtahq44mJXTCuPPrzobCtDqnJbF/x9zQoeK
         QNL+hBfZuopbbBIQbDzcy0JpY0T8u5JCMXLGFZGe0daZ7MT0lv7w/F08hp8hBP6HzQ/A
         QFTYvA7hmh8N7Z7jtlhqo4c9CMqZ3LPqc8i717iGNkfJUpL6zNRNruaJehse1BRp4x/7
         g/vSr4CQ6pEK/OHqTzSFnSC+MRDxw9f77Tucy3FfFCzlFokBAtsKc7YmiNVFVsNLlyf/
         66LQ==
X-Forwarded-Encrypted: i=1; AJvYcCXkMG+tN3+PqNACTOJI5w+V9zd/oNtqcx9YUKe2UbVvFs+5o5sOxDjW+EjFLKmdoTrUpX4cO64XmxIlucc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDdnd+nju+4nFX1+2eN6R4TGGViRQsvZKRu9dmRasQVl3/QB4j
	W/tNDUyERHMuxSo2b9vj6iGebP5frLBIeR6kEcERtTy2ffuoVhlz
X-Google-Smtp-Source: AGHT+IGoU2UbHNXgPDTHjVUEyrb5NL0gil8DCQlTyMb/oZKVB8kCMY/HqFduFQgUkQ3iO3YCOdeGFg==
X-Received: by 2002:adf:f052:0:b0:37e:d92f:c14a with SMTP id ffacd0b85a97d-37efcf7e9fcmr211177f8f.42.1729635123187;
        Tue, 22 Oct 2024 15:12:03 -0700 (PDT)
Received: from ?IPV6:2a01:e11:5400:7400:5516:dcfb:6202:e47b? ([2a01:e11:5400:7400:5516:dcfb:6202:e47b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ee0a64dc1sm7466443f8f.65.2024.10.22.15.11.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Oct 2024 15:12:02 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------ndh39QUX0NGJUZbDeos057kN"
Message-ID: <49b1ba71-1c1e-43e9-a012-42c17f0aad85@gmail.com>
Date: Wed, 23 Oct 2024 00:11:55 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [hfs?] KMSAN: uninit-value in hfs_free_fork
To: syzbot <syzbot+2e6fb1f89ce5e13cd02d@syzkaller.appspotmail.com>,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <67182206.050a0220.1e4b4d.007b.GAE@google.com>
From: Gianfranco Trad <gianf.trad@gmail.com>
Content-Language: en-US, it
In-Reply-To: <67182206.050a0220.1e4b4d.007b.GAE@google.com>

This is a multi-part message in MIME format.
--------------ndh39QUX0NGJUZbDeos057kN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

#syz test
--------------ndh39QUX0NGJUZbDeos057kN
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-hfs-use-kzalloc-in-hfs_find_init.patch"
Content-Disposition: attachment;
 filename="0001-hfs-use-kzalloc-in-hfs_find_init.patch"
Content-Transfer-Encoding: base64

RnJvbSAwZmI5ZGJkOGEwZTg4ZTZlNDAxMWM5Yzk3NzAxZjQwYjhkODQ1ODMxIE1vbiBTZXAg
MTcgMDA6MDA6MDAgMjAwMQpGcm9tOiBHaWFuZnJhbmNvIFRyYWQgPGdpYW5mLnRyYWRAZ21h
aWwuY29tPgpEYXRlOiBXZWQsIDIzIE9jdCAyMDI0IDAwOjEwOjA0ICswMjAwClN1YmplY3Q6
IFtQQVRDSF0gaGZzOiB1c2Uga3phbGxvYyBpbiBoZnNfZmluZF9pbml0KCkKClNpZ25lZC1v
ZmYtYnk6IEdpYW5mcmFuY28gVHJhZCA8Z2lhbmYudHJhZEBnbWFpbC5jb20+Ci0tLQogZnMv
aGZzL2JmaW5kLmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEg
ZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9mcy9oZnMvYmZpbmQuYyBiL2ZzL2hmcy9iZmlu
ZC5jCmluZGV4IGVmOTQ5OGE2ZTg4YS4uYzc0ZDg2NGJjMjllIDEwMDY0NAotLS0gYS9mcy9o
ZnMvYmZpbmQuYworKysgYi9mcy9oZnMvYmZpbmQuYwpAQCAtMTgsNyArMTgsNyBAQCBpbnQg
aGZzX2ZpbmRfaW5pdChzdHJ1Y3QgaGZzX2J0cmVlICp0cmVlLCBzdHJ1Y3QgaGZzX2ZpbmRf
ZGF0YSAqZmQpCiAKIAlmZC0+dHJlZSA9IHRyZWU7CiAJZmQtPmJub2RlID0gTlVMTDsKLQlw
dHIgPSBrbWFsbG9jKHRyZWUtPm1heF9rZXlfbGVuICogMiArIDQsIEdGUF9LRVJORUwpOwor
CXB0ciA9IGt6YWxsb2ModHJlZS0+bWF4X2tleV9sZW4gKiAyICsgNCwgR0ZQX0tFUk5FTCk7
CiAJaWYgKCFwdHIpCiAJCXJldHVybiAtRU5PTUVNOwogCWZkLT5zZWFyY2hfa2V5ID0gcHRy
OwotLSAKMi40My4wCgo=

--------------ndh39QUX0NGJUZbDeos057kN--

