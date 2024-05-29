Return-Path: <linux-kernel+bounces-193426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378688D2BCF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 06:46:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6695E1C21EA4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 04:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF49C15B13C;
	Wed, 29 May 2024 04:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b="p72pb5ei"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DDF910A35
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 04:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716957961; cv=none; b=YBNIiCg5KJpk7FVSSDRdoTMxh6tDiYy2sqgLIJeA1y+dLlHHy59vWzxvDhKookg+yd9rzAbnqn30yTDsxW/Ic2BE6xKqgj7vLJb/iIwh/121lYKbeKFRs7/su+cy1Y4ZpEnQf3WNVSMZFcUzyaLMbmBr2783ZsquHn9skasrnWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716957961; c=relaxed/simple;
	bh=IhGPpAFwr9pA9nbZF5l0LlG/5ijkIfQOA+hf2vYOh5I=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=JNUSp/8F2FwtZrEAdSm+ulLv0pwXYWYXMZchlBridXRkcLDU/kRoJvg82by2mLkmlE3ZagdYfTH4jhDtX451hwFRfAG2G7jKJ2FJtI3YNNpkY57TkwbVgZhkrM/E+EsWsnZyCYz6oC4PNn1y4Sf04EEbh+B2Zq6Z5kVshKnbrpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca; spf=none smtp.mailfrom=draconx.ca; dkim=pass (2048-bit key) header.d=draconx-ca.20230601.gappssmtp.com header.i=@draconx-ca.20230601.gappssmtp.com header.b=p72pb5ei; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=draconx.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=draconx.ca
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-43fdf8a6437so4307411cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 21:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=draconx-ca.20230601.gappssmtp.com; s=20230601; t=1716957958; x=1717562758; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zmpWYn0uCMbm3fxqDNBcySeG4f+66JRUG6mgZL8L6is=;
        b=p72pb5ein95EcIQB6LNJe6Xk/+NA9B97mMs7mf8fDlATWvdN/RMDEZpFLww6X7oZqd
         qJJhvxyzxKxJORFUD9KYjKP50ISnNeTw+4+lSpjBNomZx7zHcnRuV2THhwYBc5WENmsF
         i0l3Wuk3oRTbaPAoHy0IOnGbNp09ZQeJKInlsCZPZwOYB5CG2mfQ9OhlOnKvjTMeDMdw
         KpcymkSjhiK4sFjXBeGeSjtm/spTu12meXEg8j8f10TTVzOnNAWw7ofTDKihPoY++DU0
         +T2FKfYE/MNl114g2Emk39qXpbWpLn696ahp20SxevII4Sb1fbPjMlM5CvrU6Je6N0Kf
         Qu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716957958; x=1717562758;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zmpWYn0uCMbm3fxqDNBcySeG4f+66JRUG6mgZL8L6is=;
        b=BR4sQU5uIm8slKR3XUauFiODhijvWDZwzTtb4UJTQ6dBraYNTcQUuZ7vFXladmqMBC
         Aei6rcHkjwOMzObt5Unbu07Im9FznqEzjdau8uMgBUCKOW9yaDPM4jn/WMNOvhES/IAh
         u2rPZJPkKUsim6mVPyKcaWeaZ8Dl6fjUb4gxdRCXxJAS36cXioquzcmFJke3+9QSXPoB
         fgxgzTQ/bsJ5N8pkQokXDAg9kqnQvIzphxGxtsFf/8GtR/OM+0kRS4PBoziY+RORkXS4
         Qw6H5QocVeyOALG0qUIehR6ok7L+YWpiaGsg5UFvy+ITNAFAKCAoffPpRvXk4bMRkunJ
         NnzA==
X-Gm-Message-State: AOJu0Yxwd5upwdU2t1l2X9Q5Bpb/2N1wOlQKCbwYJm+5k/xKUviAr1Iv
	1xvNI/2/WpXaMak6QhYqW530IEbya9XBErjEAwtaL0cjScR75Ek+g92tKrq73eVrVKGdNAjTG3C
	X
X-Google-Smtp-Source: AGHT+IEEf4vTlM5wsCU/rnICErZFc3oLKNreJcyTI3aQmp7FVT3q5CR5E3rKudVnwFa/8XLsFiyulQ==
X-Received: by 2002:a05:622a:48e:b0:43d:9d93:f5e0 with SMTP id d75a77b69052e-43fb0dbfd06mr144358131cf.4.1716957957873;
        Tue, 28 May 2024 21:45:57 -0700 (PDT)
Received: from [192.168.0.50] (dhcp-24-53-241-2.cable.user.start.ca. [24.53.241.2])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43fb16b6a79sm50044001cf.13.2024.05.28.21.45.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 May 2024 21:45:57 -0700 (PDT)
Message-ID: <ad4e561c-1d49-4f25-882c-7a36c6b1b5c0@draconx.ca>
Date: Wed, 29 May 2024 00:45:56 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-kernel@vger.kernel.org,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Alexey Gladkov <legion@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
From: Nick Bowler <nbowler@draconx.ca>
Subject: PROBLEM: kbd busted in linux 6.10-rc1 (regression)
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

It seems kbd utilities are all broken on linux 6.10-rc1.  For example:

   # loadkeys en-latin9
   Couldn't get a file descriptor referring to the console.
   [and it did not change the console keymap]

This is a regression from linux 6.9.  If I run strace on a working
kernel, at the point of the first difference we see:

   openat(AT_FDCWD, "/dev/tty0", O_RDWR)   = 3
   ioctl(3, TCGETS, {c_iflag=BRKINT|ICRNL|IXON|IMAXBEL|IUTF8, c_oflag=NL0|CR0|TAB0|BS0|VT0|FF0|OPOST|ONLCR, c_cflag=B38400|CS8|CREAD|HUPCL, c_lflag=, ...}) = 0
   ioctl(3, KDGKBTYPE, [KB_101])           = 0
   ...

On a busted kernel, we get:

   openat(AT_FDCWD, "/dev/tty0", O_RDWR)   = 3
   ioctl(3, TCGETS, {c_iflag=IUTF8, c_oflag=NL0|CR0|TAB0|BS0|VT0|FF0|OPOST|ONLCR, c_cflag=B38400|CS8|CREAD|HUPCL, c_lflag=, ...}) = 0
   ioctl(3, KDGKBTYPE, 0xffceaebb)         = -1 ENOTTY (Inappropriate ioctl for device)
   close(3)                                = 0
   ...

A very similar problem occurs with kbd_mode, chvt, etc.

Bisection implicates the following:

   8c467f3300591a206fa8dcc6988d768910799872 is the first bad commit
   commit 8c467f3300591a206fa8dcc6988d768910799872
   Author: Alexey Gladkov <legion@kernel.org>
   Date:   Wed Apr 17 19:37:35 2024 +0200
   
       VT: Use macros to define ioctls
   
       All other headers use _IOC() macros to describe ioctls for a long time
       now. This header is stuck in the last century.
   
       Simply use the _IO() macro. No other changes.
   
       Signed-off-by: Alexey Gladkov <legion@kernel.org>
       Link: https://lore.kernel.org/r/e4229fe2933a003341e338b558ab1ea8b63a51f6.1713375378.git.legion@kernel.org
       Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reverting this commit corrects the issue.

This testing was done on my sparc system in case it matters.

Let me know if you need any more info!

Thanks,
  Nick

