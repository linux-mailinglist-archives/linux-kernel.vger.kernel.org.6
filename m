Return-Path: <linux-kernel+bounces-330702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0140297A2E7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 15:26:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C88842829DC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2024 13:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFCD7155741;
	Mon, 16 Sep 2024 13:26:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crLBi+ze"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC88AA95E
	for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 13:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726493194; cv=none; b=SsaCn307o3iVtPXZztQJWzQrsedPnE678XaxJ1FuBoRK4Zc6kvvJzxSqS7lVzuOWO408x08cSWXscIyCoE9i+dLyPxmbIutOeSVFej5WHuVHZzAktwI2fIRd/Vtg4QK2UXe0QtzrlaSnSBCp7vqb0+lJFeAHVk+I+UMpZsptJ74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726493194; c=relaxed/simple;
	bh=RWSKthHXcgYgDTHbLg+omrUCQ0QGAZ0RfFAwB5QyQ3w=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=gYtbXxU4jS0E54+AA7hTmjCU9iPZx9J8C7Iwkz8LjB2k1CVnkMOQSFyE5IXjCq2873jQXFSnmi9zNXZKAJsz0WZrN15UW3qbBJDX9bQzrOExfpaLLUTdY+42zxEi64P0l793ECPbF0Lcn1s7LwBRB/n2LtPDc1k4des37H6PNj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crLBi+ze; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c275491c61so5954082a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2024 06:26:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726493191; x=1727097991; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nAjp2XTl4oA3d7pN0FBG+hHNIEDrI8wcf5PIp4RC68w=;
        b=crLBi+zejNfwWbuN0ifoY6rZaSh01/k0Xi/DvEpuSsTEcLb0XRuDS4tgr1IU5WeA3x
         xo11yHghswyMIWWfgxKInwQ/KWtec613VNHSwS+M41dMFtSK+VyUEOGKQK396rlsKcG9
         YznB/ojTIwIxYQKrM9Ly+c2YsVH365fP0di5tre6ngTVgUFwlreRoBshlvo2T6GTCx/Q
         Z4Vqf6EdDAXGp0X0y0tZCRYq4lj9NWPsJFPpS9s7nNfweRKV3nI3Dh27tzdF9SggkzfO
         I9tP6DesrfFA/ZLhYPapWktIArGQRDbxq+40yw11Nl18N6IAj+llqLm4pI88wfCHWDiI
         74fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726493191; x=1727097991;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nAjp2XTl4oA3d7pN0FBG+hHNIEDrI8wcf5PIp4RC68w=;
        b=emZOgegkDs4BGDdnkPgjcKONc7Z+0OLsUsHg0AZltPftMYaoRzaErBD3OZtEELXXyD
         jIr8j6L6Vy1k8WU1fKWsPZvM/M97zsBzHsxhYJ4aMopiy3EYchtAJ6j/1Zlw7PeIB9kz
         N3zTSFyLQ7cs9CpoQzzfZDb2ha8X6bQXQJNiXvNLsSXbNTrcBIPVKMKzeKxSl2/1uhRR
         icFzkhHI1Qpum/PRaNhY+g9SVZRfb0pUEe1YNC8QiNjc+i+i4OwRGS8O6wCzmrFXkG5+
         a1QR/axBeyfuoO85z4xOrW/VLp6nvKn2Zle1+t4XrcMqk8jtNI7W7RljyEMSpEf+MWAH
         eEpg==
X-Gm-Message-State: AOJu0YzbpbVMHUaSLHPE8QSy/7udA01Xqe44ESkZqyWhh058T6hhpKx0
	A0IgdhtEbZ6nss6qJCHvHhTFsp72TnMAy/XkH53PX1Gyv7z7Jt+Hfmib8fcktcNoEZ8228mO5uh
	NCOBYkX56ckjP/JUZeffpRCGRh+T7THAF
X-Google-Smtp-Source: AGHT+IHdEsrRqGjAzgftNpSGnqwTywQU8GapY7QmzjEjE7vlFiVzc6nFMXPCrxQo+btATVSDsTv3Db+6FPof1G3Heqc=
X-Received: by 2002:a05:6402:2707:b0:5c2:467a:185b with SMTP id
 4fb4d7f45d1cf-5c413e1220emr14504388a12.9.1726493190582; Mon, 16 Sep 2024
 06:26:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Vimal Agrawal <avimalin@gmail.com>
Date: Mon, 16 Sep 2024 18:56:18 +0530
Message-ID: <CALkUMdT_Q9o-NDKhAk=v_ARSe541y6yeg8hacYJ2iZ5PGjjRVw@mail.gmail.com>
Subject: misc_deregister() throwing warning in ida_free()
To: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	D Scott Phillips <scott@os.amperecomputing.com>, Vimal Agrawal <vimal.agrawal@sophos.com>
Content-Type: text/plain; charset="UTF-8"

Hi Scott/ Greg and all,

We recently upgraded kernel from 6.1 to 6.6.49 and started seeing
following WARNING during misc_deregister():

------------[ cut here ]------------

WARNING: CPU: 0 PID: 159 at lib/idr.c:525 ida_free+0x3e0/0x41f
ida_free called for id=127 which is not allocated.
<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<
Modules linked in: ust(O-) [last unloaded: fastpath_dummy(O)]
CPU: 0 PID: 159 Comm: modprobe Tainted: G        W  O     N 6.6.49+ #11
Stack:
818bfb70 6093f8d3 0000020d 61381660
61381630 60c1ee6a 00000001 60068c0f
818bfbb0 60983ee6 60983e5c 61381680
Call Trace:
[<60973831>] ? _printk+0x0/0xc2
[<6004b2e6>] show_stack+0x35c/0x382
[<6093f8d3>] ? dump_stack_print_info+0x1af/0x1ec
[<60068c0f>] ? um_set_signals+0x0/0x43
[<60983ee6>] dump_stack_lvl+0x8a/0xa9
[<60983e5c>] ? dump_stack_lvl+0x0/0xa9
[<60068c0f>] ? um_set_signals+0x0/0x43
[<60983f32>] dump_stack+0x2d/0x35
[<60983f05>] ? dump_stack+0x0/0x35
[<6007aad8>] __warn+0x20c/0x294
[<60068c0f>] ? um_set_signals+0x0/0x43
[<60971d98>] warn_slowpath_fmt+0x164/0x189
[<60222128>] ? __update_cpu_freelist_fast+0x96/0xbc
[<60971c34>] ? warn_slowpath_fmt+0x0/0x189
[<6022d2fe>] ? __kmem_cache_free+0x16a/0x1be
[<60068c4a>] ? um_set_signals+0x3b/0x43
[<60941eb4>] ida_free+0x3e0/0x41f
[<605ac993>] misc_minor_free+0x3e/0xbc
[<605acb82>] misc_deregister+0x171/0x1b3
[<81aa7af2>] ustdev_exit+0xa8/0xc1 [ust]

basic code of calling misc_register()/misc_register() is following:

static struct miscdevice ust_dev = {
        0,
        "ustdev",
        &ustdev_ops,
};

int ustdev_init(void)
{
        misc_register(&ust_dev);
        return 0;
}

void ustdev_exit(void)
{
        misc_deregister(&ust_dev);
}

Note that this was working fine without any warning earlier on kernel 6.1.

I suspect it is due to
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?h=v6.6.51&id=ab760791c0cfbb1d7a668f46a135264f56c8f018.
It seems misc_register() is not calling any ida_allocxxx() api for
static minor value of 0 but misc_deregister() for the same is calling
ida_free() and hence ida_free() is warning in our case.

Please let me know if I am missing something or some of our
assumptions are not valid anymore in newer kernel versions.

Thanks,

Vimal Agrawal

