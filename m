Return-Path: <linux-kernel+bounces-374584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF66C9A6C73
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22D06B211E7
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63731F9EAD;
	Mon, 21 Oct 2024 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNT2ffQ3"
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EADE1D2718
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729521851; cv=none; b=Xt9VvhQh3y1mH3rzDogHeGozaEsTNLfRrOuLcJto+92JuvtWjlMPTqTlGyZYyctQSuXaY/Y9wywMKRi3M194CQgz2BQGpzL/5nlSl7+9dMEYss9UL0fj6O7FHb1XhpIz6EBPmYuSQ2s3LfkF3JY9+V6m/TBvEieaDEy99UWdXCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729521851; c=relaxed/simple;
	bh=hL59XMYFMBwLng2ORwpEUT88NybFHcgMdq6UG2WRKvc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N229i6TuoYbidtYVF01jV02i/OnGwmq6inT8q706wh7H1y/xBakxh38EloCh7Bs7pTPOiTxfVfoqi02lJT4xdrsgwAJLBhtmTEexyfIcCgfuSOdKbqgyozJOHm6Dj0b+kJomP9mj/9tpuMFJLul58QLLbLt1ece21ExMlIDtIT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNT2ffQ3; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7ea68af2f62so3543830a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729521849; x=1730126649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=reV47rYAjrNyFoF36Jo4UW9f7ZYQ6WAZwmYx78Gwlrw=;
        b=eNT2ffQ3TsFmvdYYtwqzE3Wo/GpG63oVkoPm8a/hVHWz9yYXJpAbBFGKQ0fe55MAPq
         Wj0TtiiyIfu3q/tZMdgoDkOIrE8/DDWhdvjQugJa7z+lmnbMgrzJsrOJ88Rv3E/Bb30R
         Qkwso07hqv9051yZblmXmhzWk5EFNxrSVvwcIyDlaES0STeoN0CtG1HTgFDGKjpgeS1B
         nqV7JFc4ErngUqrp1jZQKeVifRjq4niSgTvWU9/nwsfb3ha3fLRBwu+v/4L4+GH/TNfp
         qhtASYVmw8N5p3UeEYIZa39WGfWa48a/g9tNDvLVApQ1SrwYakR3SobXL3M2atlPrnux
         RmgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729521849; x=1730126649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=reV47rYAjrNyFoF36Jo4UW9f7ZYQ6WAZwmYx78Gwlrw=;
        b=mNIqjHnsn29cKuyDjhA9ap1nGS/oiRaVCODMl5yJ84QM3DlIJZOU4XaFAX747n+L2G
         0ciIDakaTNAkqduERAXYo7Y0XRbGrgn43lOGJs77NpUNUEjAHp2NGO0SpRWESEzlop39
         qYvHxwfTq8DNCpW1+4esYV5rctJTEH4b+Rp3z7g8o93jzeroJjtOl8owO2P3zeL2Y73d
         dFQpfd5OFgqkk7wPCxMhJF+zKmnMPukQwiVc19+oFiOv22KS3MuJW7mHyiLRfvc29C/F
         LgOjfaiDWdABOzkNxlglagj7TU6/gtxAmpeVdteNXdoC/zi0SIbKXhp55EDvmcepFrhG
         4ZZg==
X-Forwarded-Encrypted: i=1; AJvYcCX7MA/Mz4u+aAHXTqeoYAQqMkUFCYCOWKJpye2DPjtpLhi5y1wWWrQM+eH14VZRFrJpHrNwElHIiLUcx+4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlMqrUgEsWO71YuQ8HktwnST/OUa3FBQXRucQ2HyURCa0XCAot
	ZmhU9ZT/5tem5O42xupzwRqYPurIlcEN4ws6EvRwGMRzDfhBmtNB
X-Google-Smtp-Source: AGHT+IFoaZNDK2MzY/VD04GfIRSMBfYKAt6NZct3Izdn2L8iegNDZRJUFr80fLeQu6aKBOvr613lRw==
X-Received: by 2002:a05:6a21:6e41:b0:1d9:2954:5817 with SMTP id adf61e73a8af0-1d92c50fef3mr18520413637.23.1729521848597;
        Mon, 21 Oct 2024 07:44:08 -0700 (PDT)
Received: from fedora.flets-east.jp ([2400:4050:a0e1:7d00:529e:8ad4:796c:105b])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7eaeab583d9sm3162960a12.49.2024.10.21.07.44.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 07:44:08 -0700 (PDT)
From: Ryo Takakura <ryotkkr98@gmail.com>
To: john.ogness@linutronix.de
Cc: christophe.leroy@csgroup.eu,
	hbathini@linux.ibm.com,
	leobras.c@gmail.com,
	linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	naveen@kernel.org,
	npiggin@gmail.com,
	pmladek@suse.com,
	ryotkkr98@gmail.com,
	sourabhjain@linux.ibm.com
Subject: Re: [PATCH] powerpc/crash: Allow direct printing on kexec
Date: Mon, 21 Oct 2024 14:44:03 +0000
Message-ID: <20241021144403.8429-1-ryotkkr98@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <847ca1fxod.fsf@jogness.linutronix.de>
References: <847ca1fxod.fsf@jogness.linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 2024-10-21, John Ogness <john.ogness@linutronix.de> wrote:
>On 2024-10-21, Ryo Takakura <ryotkkr98@gmail.com> wrote:
>>> Rather than removing the deferring, it would be better to convert the
>>> console you are using to the new NBCON API. Then it would be able to
>>> print direct and safe during panic. (printk_deferred does not affect
>>> NBCON consoles.) What console driver are you using that you want to
>>> see the messages on?
>>
>> I was working on qemu ppc64 this time but I am usually working on 
>> Raspberry Pi 4 (mostly for fun and study) which uses either of 
>> bcm2835-aux-uart or amba-pl011. It would be really nice to see them 
>> working as nbcon!
>> I am thinking of taking a look at [0] but If there were any other 
>> references, I would really like to look into as well.
>>
>> [0] https://lore.kernel.org/lkml/87wn3zsz5x.fsf@jogness.linutronix.de/
>
>The lastest version of the series is here [1]. The series is still
>undergoing revisions, however the changes are 8250-specific. The API for
>nbcon consoles is already available since 6.12-rc1. You are certainly
>welcome to try to convert one of those Raspi 4 drivers to the nbcon
>interface. I would be happy to review it.

Thanks for sharing!
I will take a look at it and definitley give a try!

>John Ogness

Sincerely,
Ryo Takakura

