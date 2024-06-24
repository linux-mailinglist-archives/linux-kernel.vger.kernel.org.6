Return-Path: <linux-kernel+bounces-226556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DD691404C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 04:04:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E263F1F22BA1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 02:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCB54C96;
	Mon, 24 Jun 2024 02:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maticrobots.com header.i=@maticrobots.com header.b="MclAWsTW"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7947B33F7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 02:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719194648; cv=none; b=i5+9Hj5K4CPBN7e02ZzExFi6sSKBsO4ossFYxpMpz4jqmg0yCSABZYeqXGM0dHCh5aS9Cfq8hxT1aZXZQzBSP81Hyv6oIEcgN4LCQL4TWCyp/KGXE/V50hHC5k0kC11hYOtDYNrbLFDvvKmov2LTn/feXX69IJKd7vDV+dLBmuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719194648; c=relaxed/simple;
	bh=bhQexe9HQ1tYTBwABIpEVcllLrmE4nxu3yrfIRNM1Ew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oxlNwlvuNx3GL0XFj1zLogWpqpaNe8P6lSaxxgzI15GDMuKgPSlJfApG/4dD6P8HMKxOX2ON5oprvwHBg3glpwoH/SJRtZHkRYS3Al1dGunLl+B8d5uWmoMGmIN9AoQKfmRdFjI/QlHdXjhr0T4beSQhAZtOSg6lcyOUa7Q74p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maticrobots.com; spf=pass smtp.mailfrom=matician.com; dkim=pass (2048-bit key) header.d=maticrobots.com header.i=@maticrobots.com header.b=MclAWsTW; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=maticrobots.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matician.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e02a6d4bdbeso3447310276.2
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jun 2024 19:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maticrobots.com; s=google; t=1719194646; x=1719799446; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bhQexe9HQ1tYTBwABIpEVcllLrmE4nxu3yrfIRNM1Ew=;
        b=MclAWsTWLxxRjy4u7Qnhmcb5XTtcxvCYugrTJpZ7S5jmO8sq1FAWWACt5vlVqGmqHi
         yfiit4dWBJWYGxNY5ANxSaqN+qqPMFjz2mQ5Ws1m5CFG8Ux6SgTeev55D4bjfl66i/Sp
         +l7GoJdc38Q+xB1qCkgFqa7L8H3mGB6PNHIu4fmHb8VwUSNw2JHHfZ692CsBlLXVvk4X
         V/ltm7e/3kE3veFKA9DLmQtq+D5KIewF2mMnV4VoXvJgm3DnP1fnpsRLNtrpxc05vhfZ
         S/VJ/GkdMluwPO+IpMrstFKRZ5cukq+IBRDAMB1ZaYr5/NDwGyDamGkZ1zSmNNcFpMJk
         Stwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719194646; x=1719799446;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bhQexe9HQ1tYTBwABIpEVcllLrmE4nxu3yrfIRNM1Ew=;
        b=raHcjH1apaOrR3f0AJOINROR++3lkyryEJ5wJFnR72McIXV/irvwpo7qhQjLgZc/fY
         7SpL0awG2a6esZ/KTfQKdvw0q44az92AWp5MfiTrnW8KRZv5P+Urh1og3LYvTruq9bVm
         AJ2aQZ9+Ja/jM1vtVnmI5j5XY4CEj6iB3KubAvSSKGUi3c+/WN51DDXqYzM4isBo55HM
         giyYwxVcHGKm4s9uCeqfgtFBNWMQEoTQYjORsHYY3k+A4E+6KJeVT53v/h6/FmRbEOWC
         7rmQ2928zrogrqDGwfXaV3MMrDyw3mvvWeIEItYVcZnYBUa3xmnEZ6uYHAUqmS5YI60f
         8hsw==
X-Forwarded-Encrypted: i=1; AJvYcCWHjbtDuFJK6YXLjcu9NFyX7AIB9YLMGY1MxOxDicciMf/1xIvw1fMKm9lDxvFnzMh9CYvO9NJdSL0HuMpCsqMAo3V/QALxitTfBTpv
X-Gm-Message-State: AOJu0YxCqdB+LyZhmagapngamaS8A83Hz1nB4z7NN1tggWW7eadrfW6o
	JA4tzx6Htp2XJBoowhnrjnJiLQoSIAfKYuOWUEVzxOzWvryOsQShAcH3L6FefuPlkivNEsJeb+M
	G5YMDwgMfYwQAuqzDUpXfr5jwxeTbbFRiPtiSXg==
X-Google-Smtp-Source: AGHT+IH3CEbJTidGwTmSSlYlGVYozH8HrS+6fLtHzmJm4NAvVkbYSn8L1T+U/0kg28tt9koMI9Aght+HlGvoarFeN7k=
X-Received: by 2002:a5b:d4d:0:b0:df4:a607:2429 with SMTP id
 3f1490d57ef6-e02fc350b15mr3955751276.45.1719194646368; Sun, 23 Jun 2024
 19:04:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+hUFcuGs04JHZ_WzA1zGN57+ehL2qmHOt5a7RMpo+rv6Vyxtw@mail.gmail.com>
In-Reply-To: <CA+hUFcuGs04JHZ_WzA1zGN57+ehL2qmHOt5a7RMpo+rv6Vyxtw@mail.gmail.com>
From: Alexander Coffin <alex.coffin@maticrobots.com>
Date: Sun, 23 Jun 2024 19:03:50 -0700
Message-ID: <CA+hUFctSB1wT+du3FROhF0cG+9gWTBn6L_odWjYDbsYQsk5mCA@mail.gmail.com>
Subject: Re: PROBLEM: ext4 resize2fs on-line resizing panic
To: "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello again,

Sorry about the quick follow up email.

I realized that I alluded to the following in my initial email, but I
realized that I forgot to directly address this issue. If the
partition is resized when not currently mounted it seems to works
fine.

```
root@debian11-vm-acoffin:~/tmp# gunzip ./foo.iso.gz
root@debian11-vm-acoffin:~/tmp# resize2fs ./foo.iso
resize2fs 1.46.2 (28-Feb-2021)
Please run 'e2fsck -f ./foo.iso' first.

root@debian11-vm-acoffin:~/tmp# e2fsck -f ./foo.iso
e2fsck 1.46.2 (28-Feb-2021)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 3A: Optimizing directories
Pass 4: Checking reference counts
Pass 5: Checking group summary information

./foo.iso: ***** FILE SYSTEM WAS MODIFIED *****
./foo.iso: 2321/7904 files (0.2% non-contiguous), 18945/32769 blocks
root@debian11-vm-acoffin:~/tmp# resize2fs ./foo.iso
resize2fs 1.46.2 (28-Feb-2021)
Resizing the filesystem on ./foo.iso to 524288 (1k) blocks.
The filesystem on ./foo.iso is now 524288 (1k) blocks long.
```

Regards,
Alex Coffin

