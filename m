Return-Path: <linux-kernel+bounces-368306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3969A0E13
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 17:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C611C222B7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:24:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12CF920E034;
	Wed, 16 Oct 2024 15:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="107p6FVO"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83C120E01C
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 15:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729092261; cv=none; b=T2simnl5rd5I+1pbiV51WMjNin+YUghoisYDLw3BLDhZqm/D9/q7Z65e4CSvrJpkRBwfG0QZ4PpG8Q+iweIgiNXbj2G7VuGgxuzeKgHOv2Nt1b92lFRwSIRP9LenHrW5jkAFeFHqjnMNZ+b5OafpgXi1AbvyANe8o8/Ni0K7JF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729092261; c=relaxed/simple;
	bh=GbXGjdX1Dr2Oee9k84WvyAAoh1Efv0lViBIMCmGYb1E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=YZsZdmoBTvr9xCmUZOAjhL9/6NyKFKMUcT87xoypGqZpTDYTZAmeTle4QAKFLHZoVx0yFf4yI3nSNx2PLSih3qTbeQCk9JyHHVAWnJRZndkI5hAK+E2sEl6NY8oFHuFiqOVM+mL3z+1PA6WK35oecRV2RkWU3K88dpRKNiZvi5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=107p6FVO; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-5c947c00f26so464a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 08:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729092256; x=1729697056; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vrc8esy1mHVI7WP06NeyO5yMa6lXp8Ynnils2Flmbkw=;
        b=107p6FVO53BFjrRMdR9hz9+uwqX5rCFh8yPVm5oIDNWYSU2z6nk1qojj7swS9e0TBZ
         x80HEaKUeJYANLpz4MWGusYNrj9+oiJC9Vm0pvZQJfjn8q5s5L4ATcxKwGdm+o+vX9Dc
         /mXWQruo/fwlW13jNIa1iSQyl40pzTJmsABnslEbV7NM+bCIKXxT8UUON4akZsoazMmr
         P4J3WFxGArGslSaVIJ/zm0squTUP2cva5VObKveDzMzEfShCX3OKN1jdGkEgc97B1Wcj
         aI4SXaRk4HAY84CDPHJrxUL+eaC3DnVaoB3CuqXdJYio1IHZLGxnnU7/nvTFxlqAzFuF
         VwXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729092256; x=1729697056;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vrc8esy1mHVI7WP06NeyO5yMa6lXp8Ynnils2Flmbkw=;
        b=EeJmHl05RohG3A0QvPP504JV8X4kT7XGYFa6D0FiIuIJdXOHUEhjz5am6oQMNbYjVy
         XpN5rlvVkV+AdMesxwDTxj6ANeCx0oibT0TSQHoq8V4VqvpobohDSs/WEQXTBsdEt1IQ
         F3/PaF7AlXNagVVWCzHYMtRVVRnWu7Pal4Agk8Ir7OxZhYRLyjYzZZddIZ4nYO3OpMRw
         tcMU1HJfBuDIDwniTgT9539kdHvnIs+BqW5cETIZkLuhxMvGzWE9AraRmRI3FlgfrDNd
         iRw3+cofXJJ/OS4xf97Vp15dz24yvhfJOaFAKO9qOiLZShGfsx947RuS38O1zW8OiIdQ
         QCEA==
X-Forwarded-Encrypted: i=1; AJvYcCVlYAMC6tiYIEfs0bSMpnltYHZGApf48SzmXw7B0sNdk49J/jtNVztafmDjkT4ZuQWrq/DKa76KrloZ14Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2vQZ7BFV2VeqZzpT+P8ftNsCEivO6f2sbCA47TtpE9QRCIlov
	l3e6ite2U/kWYg38inKdBllBYG2Atq9eQPuhhy/B0Ib4xAwqbyPk0mtvkKwdKA==
X-Google-Smtp-Source: AGHT+IG9mnB9BW6igr+s13cFGwzxtIMxDk9GIrI1fxeuwrcx6CG2Po3qh9GMewyeUtDTuWm/xFWh2Q==
X-Received: by 2002:a05:6402:2681:b0:5c8:a0b1:9c4 with SMTP id 4fb4d7f45d1cf-5c997a74be2mr4379a12.6.1729092248774;
        Wed, 16 Oct 2024 08:24:08 -0700 (PDT)
Received: from localhost ([2a00:79e0:9d:4:a496:e3cd:3667:2787])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fc45577sm4566610f8f.116.2024.10.16.08.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 08:24:07 -0700 (PDT)
From: Jann Horn <jannh@google.com>
Date: Wed, 16 Oct 2024 17:24:06 +0200
Subject: [PATCH] usb: require FMODE_WRITE for usbdev_mmap()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241016-usbdev-mmap-require-write-v1-1-6f8256414d5c@google.com>
X-B4-Tracking: v=1; b=H4sIAJXaD2cC/x3MOw6DMBBF0a2gqRnJtoJBbAVRkPglmYLfGEMkx
 N6xUp7i3pMiVBCpLU5S7BJlnjJsWdDrO0wfsIRscsY9rLGeU3wG7DyOw8KKNYmCD5UNXKPyoXJ
 NMN5R7hfFW37/d9df1w2vudcGawAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729092246; l=1198;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=GbXGjdX1Dr2Oee9k84WvyAAoh1Efv0lViBIMCmGYb1E=;
 b=rTm4b5cSTKEzv+kO7L3v9JQSbzp2tND5lbDhmES12Hqi2sgOEy8MAyq8H+0O7V6EwU8LsFzjN
 hVJHDiFkOiNAkflM9EYu406TTKHhC5TvdCN+sw+tJmCJP+jXoujwmn+
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

usbdev_mmap() creates VMAs which can only be used through
usbdev_do_ioctl(), which requires FMODE_WRITE; so usbdev_mmap() is only
useful with FMODE_WRITE.

On typical Linux systems, files at /dev/bus/usb/*/* are mode 0664, so
UIDs without any special privileges can't use usbdev_do_ioctl(), but
they can still execute the usbdev_mmap() codepath.

Check for FMODE_WRITE in usbdev_mmap() to reduce attack surface a little
bit.

Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/usb/core/devio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/core/devio.c b/drivers/usb/core/devio.c
index 3beb6a862e80..5363468a282f 100644
--- a/drivers/usb/core/devio.c
+++ b/drivers/usb/core/devio.c
@@ -238,6 +238,9 @@ static int usbdev_mmap(struct file *file, struct vm_area_struct *vma)
 	dma_addr_t dma_handle = DMA_MAPPING_ERROR;
 	int ret;
 
+	if (!(file->f_mode & FMODE_WRITE))
+		return -EPERM;
+
 	ret = usbfs_increase_memory_usage(size + sizeof(struct usb_memory));
 	if (ret)
 		goto error;

---
base-commit: eca631b8fe808748d7585059c4307005ca5c5820
change-id: 20241016-usbdev-mmap-require-write-7e56d528d062
-- 
Jann Horn <jannh@google.com>


