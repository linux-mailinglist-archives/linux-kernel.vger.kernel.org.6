Return-Path: <linux-kernel+bounces-393029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA9A9B9B25
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Nov 2024 00:26:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6424F282644
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 23:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CC31E7C2C;
	Fri,  1 Nov 2024 23:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KOWO7TTM"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77B0374D1;
	Fri,  1 Nov 2024 23:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730503605; cv=none; b=a6j05Lth/MkIIyba7u4IPUQy+dGb27ztTaz4Zq7l977SEY6EF0E5spkiYtBJk4Oc23srSTzR9Gjzaf4VuMiJZYsJA2bZtsvrjeXTCZ+I5z/EjGtEga10XFyTWuXwQcAVvky+GnwpKEeCkZ7svOtNuW7rIhCn+76yUaryy60lMI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730503605; c=relaxed/simple;
	bh=uzDZHVRrkFWGstCPmb3jv5jbwWQSG8gPdKX6QPumpLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K4BEIf7vQRcOw4v5v3yb9fKFGm4ginKhs7mp+whQr8y6YEsEQbOLFJdcqQaPe5O4fRLscbp7cod/aYdm9jDQu8s6CJcwT9WCH3COPUAqB6IdkQJtfUTY6YflWH4/2f+XVNY2k5haBLVAZ5tQdONvKtlAWRs9pskrO9XzmidW9jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KOWO7TTM; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37d6ff1cbe1so1682593f8f.3;
        Fri, 01 Nov 2024 16:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730503602; x=1731108402; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XqnoxXLT1ga6lGQKF3OyNTREEZujJ+HEVe2LdD+Pf20=;
        b=KOWO7TTMyitnnQBxdA610SdQAzZRhvj5SlQd93Fpmprhvj/qPGBcHXkrnLre+ZoLy/
         t7NnxLI6plD6garCaqTQD7H65ELZbi4RpNfK3qFB+odtjVzjLVOI4wincnXunGKRmR/H
         Ak4i/cA99mF3sq1/46xP8nQ3jSCNMcMpUW/A9xQ3LQLPzmPcQdywnQSjGTuJcu6iOVDN
         owrKCIj7uXDlYvsHIFzRHvAHwBHMtGSZYseBdHi3tmnkZ6aguK4QNfQDJI8txI4uteGq
         0z6ijZK66uw101SH7xwN7WIo7c9uDct6RGR7VWxVCDl/Iyul0UdlXWN7+SqqtY3EG6UJ
         oKrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730503602; x=1731108402;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XqnoxXLT1ga6lGQKF3OyNTREEZujJ+HEVe2LdD+Pf20=;
        b=MlHRlfHUND2FDkVBunNCWayasawbVTRe5/K80yAYjkuqElW1QjkhaWNCrXPoyc8kuD
         DPl3yuJc638n4YqevRIOOffPP17g5lPXdPahUfpGK/QqduC/PvbOQhtEnXXruUZ+XP/B
         EcZADVt9s21VZGcmjXEIH4esMEu83NRb0v6IKysYcIG+IHBQopZMqDoYJAxiwHCMJS8M
         Cm3zFgjFpKPtaSf8MzHyOH9YYAL86qbcLP7KHuNgRZpIKeWCWNc5rxTmeyR2Bdz6eeFV
         +vmMQH41vDI9rknf1k9xosLk4TvnATYePxvhRNeRvNlvfygdlCqtah1xzH8z97+iOak3
         8xlA==
X-Forwarded-Encrypted: i=1; AJvYcCWbf6c+q3G5/MksCtzVQkOBoz52CuakOoGZQQxisu7PbC6dNG0jIhOWb+eQUAVUkgMYuoUBLKFN+P7E@vger.kernel.org, AJvYcCXdnPcfr2HDRzti5SJywv+Ups4wSTJaLi7ImwI0OiBYMlSk9F6KBxK73eEbWhQmBbwhwFhfMht+pWOYe60=@vger.kernel.org
X-Gm-Message-State: AOJu0YynCm6ZKdHR8NP4+3NnBWsfVCm6PrcUYyvjX0CYlNJuTY4nzlJM
	TVoctON0atsxWcPucvWOLOhyx2qdqOOfOy26r2ho732cyyI+flJBze4mOzJolfZb7Eg81x1XAjh
	KpMCNUutJNmfglG31R308CyfhCKI=
X-Google-Smtp-Source: AGHT+IHcViwzGlvSMKY3G8fN0houyipe7YVAj8ZqIlQhyvWu1oO33QCqwB8TawPi3jp43A+7JmW+zyeAOCo070XtKcg=
X-Received: by 2002:a05:6000:1867:b0:37d:4d80:34ae with SMTP id
 ffacd0b85a97d-381be7adff4mr7457667f8f.4.1730503601924; Fri, 01 Nov 2024
 16:26:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <0000000000003c68f3061fd2c285@google.com> <000000000000e82e420622326e3f@google.com>
In-Reply-To: <000000000000e82e420622326e3f@google.com>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Sat, 2 Nov 2024 00:26:30 +0100
Message-ID: <CA+fCnZd2b70N6nXTyWO2UYivh_U7Wey==XWURpFy7B_x8xEFHQ@mail.gmail.com>
Subject: Re: [syzbot] [usb?] KASAN: invalid-free in dev_free
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	syzbot <syzbot+3e563d99e70973c0755c@syzkaller.appspotmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 16, 2024 at 3:24=E2=80=AFAM syzbot
<syzbot+3e563d99e70973c0755c@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    68d4209158f4 sub: cdns3: Use predefined PCI vendor ID con=
s..
> git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/us=
b.git usb-testing
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D10a9620058000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dcb61872d4d8c5=
df9
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D3e563d99e70973c=
0755c
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for D=
ebian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1297cc07980=
000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D1217c8a998000=
0

Hi Chang,

I saw your patch testing request for this bug [1] (thank you for
looking into it!), but your patch doesn't appear correct to me, even
though it did satisfy syzbot. One issue that I see with the patch is
calling spin_unlock_irqrestore(&dev->lock) after
kref_put(&dev->count): kref_put() might free the device struct and
spin_unlock_irqrestore() will then do a UAF.

I'm not sure what the correct patch would be though, as I don't
understand what the issue is. It seems that dev_free() indeed gets
called twice, but since it's guarded by kref_put(), this shouldn't
happen AFAIU. Or at least we should get a bad refcount report.

Thanks!

[1] https://lore.kernel.org/all/6721d497.050a0220.35b515.0001.GAE@google.co=
m/T/#mca35ec73d63ff30d7219b6739ed0801688f15f35

