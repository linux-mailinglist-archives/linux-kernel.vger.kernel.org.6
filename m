Return-Path: <linux-kernel+bounces-213077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B94906AC5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 13:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 78DB21C21B76
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 11:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C0A142E87;
	Thu, 13 Jun 2024 11:12:53 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C6D1420A6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 11:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718277172; cv=none; b=ULoVxUMUrfgKpakA/xsprh/WDJh9rr7Np4IMqTms24yubOCC3RsvZYfJzEYHHAlOOW0mNqD3Jne/5gErZPOJ4S2830eydaV2rcJPFQf4NQmooxR326oKmQsuPNn5Fn+GbNP7oDlwPvaxjK4FfnVYeLORZO/d7rsbPfc88F1O8sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718277172; c=relaxed/simple;
	bh=t5CQpQc7Vv2ve+vpnotE9QVeEItBGO9LCcMOJVX6L8A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=a6pN7h5pLdswPGzxFeLd7kCVjMzAVTPpz//a+INzWBaJu6prBt501uSS2weupJ0GjrCOsm9OhXupTzBDGapA5rjkOwYDT8wE1LNawDVBHUSBm/9p3w0H57l93dBgUw1M0GmFMCsuL3VkRaCJiZP7WB+GgYXevJVh3nBrB46qNRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7eb7c3b8cf8so84644339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 04:12:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718277171; x=1718881971;
        h=content-transfer-encoding:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t5CQpQc7Vv2ve+vpnotE9QVeEItBGO9LCcMOJVX6L8A=;
        b=IB3kd+/K7uzfBNuaXrRquGkucZoyKAbMEPRj26fTlx5XOOWocYqkJVyXDo5wBxz5gh
         JpkRy2yCbSp1u/5dMBbB5+AcnhVDNUmvWl0QTcYjmn1pOm3zkxEDDJVnoY3VwF8tzZWx
         yek+27RJZwOmorrNjDCcDKl8bZdywLnXGbFMfLkJsgRsxYi/hPBcDD9zJzpAuJ0TPM0b
         kOWaPD/97cMt8vRcEmBKqQWaMMspF+UNgEWN70Mb4hCTTAv0ma8XJeeQHudtNdOwjUVF
         LXy+jQkntwO8j5Ado3/hHi01LH7cCCgDZnhJjJMrcQDfm7h9KDDkMmmWzygU3xpUECeO
         9RpA==
X-Gm-Message-State: AOJu0Yyd8+2keeGIpU12hjzwevrkq2iC9W0P76Qz4AekWRNJKg6lt/b2
	7NIt3x4ub9845mv4N2HnfXp49GrgNIDyfgsqFpGwv4g3GvDJV7/x7ZZBYHg6FQL1514jBIbKTXV
	7zGsrliuD2C7nQA/wEE2WH/c5hIIlS5wUNn2y7vZ490f5NB42ZetTMuo=
X-Google-Smtp-Source: AGHT+IHA1wP0bcOZKgHaW1Ng0VkfpCgVCHZNMBnrnH3A6cEx7ofUUZ8FL03+bLh3QmQneQYeJecSAdh5AvPOC7RouGPtQVEciBPO
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:378d:b0:4b7:ba1f:5449 with SMTP id
 8926c6da1cb9f-4b93ee41fa9mr441481173.4.1718277170752; Thu, 13 Jun 2024
 04:12:50 -0700 (PDT)
Date: Thu, 13 Jun 2024 04:12:50 -0700
In-Reply-To: <0000000000008312ad06163b7225@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000637bab061ac39493@google.com>
Subject: Re: [syzbot] Re: [syzbot] [bpf?] KMSAN: uninit-value in htab_lru_percpu_map_lookup_percpu_elem
From: syzbot <syzbot+1971e47e5210c718db3c@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [bpf?] KMSAN: uninit-value in htab_lru_percpu_map_loo=
kup_percpu_elem
Author: wojciech.gladysz@infogain.com

#syz test: https://linux.googlesource.com/linux/kernel/git/torvalds/linux 7=
8161c936167954351de8125d5e52c9034fd86c8
The information in this email is confidential and may be legally privileged=
. It is intended solely for the addressee and access to it by anyone else i=
s unauthorized. If you are not the intended recipient, any disclosure, copy=
ing, distribution or any action taken or omitted to be taken based on it, i=
s strictly prohibited and may be unlawful.

