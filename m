Return-Path: <linux-kernel+bounces-186064-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA608CBF5B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:40:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07AF91F2350C
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 10:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A5182482;
	Wed, 22 May 2024 10:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b="TnlWbJpe"
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB4A405CC
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716374449; cv=none; b=MKUiP47X6i6ngzCXgEAQaVCs86j8AxqgMnaiw2KTYC3cBgnqaJX3CPKsJmwh2/jJXKmU6pKJ1LKnxU7yRi9Y6RhrdhK6JVL3SVc8w7NfrVm24Pd4g2NbXfXez5x8Y+cWnZoBVy+6p6zJUMRElH5aT841tKTobeqebqh+IIrISoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716374449; c=relaxed/simple;
	bh=uX4+J3uUcRNkmNptKAAtEgtyDstamJlPig+t2ovpjig=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=aCNnr8+yZUsNgWa+/b5xXZIi6WA9H/2TLeguIclYXOns5kQTqfDwSXfCseM9VRzeYRrxpgbEx1hA+e/3ZWZmqKoMK3USRV0VRTiAO7BWXIU7jrH7NvKjimX+tkK881QDzi9ynHzhU6dPzppz9MnyOBhI7HezIi/XDclIbSV8hVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu; spf=none smtp.mailfrom=monstr.eu; dkim=pass (2048-bit key) header.d=monstr-eu.20230601.gappssmtp.com header.i=@monstr-eu.20230601.gappssmtp.com header.b=TnlWbJpe; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=monstr.eu
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=monstr.eu
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-df4e1f0f315so567732276.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 03:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20230601.gappssmtp.com; s=20230601; t=1716374444; x=1716979244; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QF6Qtl+FDdU1JQjEZdECTWNBkzbNoZxUpBzWTpiOiU8=;
        b=TnlWbJpeiohyiQqYTUn1Tx9//ydzkObu60ZosSyQmxVWGUEIFux8tSQOb2FrzuUqps
         ShS3NA8j5uL3mT/I/m/dFdOUk/OQrp6R3CiRq+0kz9dTmw28J4ZipJxT+bfKs3oOO4gE
         e9L37DcSPG0PiiRo1481XPJxnolDMGu5IdqgGfrinRGx8lRJS0d/HokSftMi072n6Gbh
         IntUtuqogX9EfSD3+EGV9SOs5LP1HVSMDV82KVngOVV1V5P5n07STYySUeQivXQs9pSB
         lHa533JJkh61XQsah0VJvDn8s0p0rD4uZaO8tSgpL3mbV/WKj6Cw/atOh7RtZwinE8Uh
         w50A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716374444; x=1716979244;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QF6Qtl+FDdU1JQjEZdECTWNBkzbNoZxUpBzWTpiOiU8=;
        b=Udj1gZ/Wm/47YBT9g089vlkVGASXoK+g/TakVADUyoKROaahciQIKYWkMePfNKeI9a
         dwZSdt/I+P2iRvupAbvdT8zAcT/DkM+wj6ZcJPxeNsHDziJ0uExtkxMAoxFlonNYxyGR
         szmHZyZmT5pk/QfqK1jrA5CQBtQ6Io2k+nPr76TRILNhuGS4tXrI3t4+ESoCplXj/64y
         x2MJ8mFGuVtUT1I8f/Mj2RaeN1VG3XLB3J1pAnGFltFOYkLVnACH2T/ghEuVmiiYkJRh
         JWrA5+CtvqODi+RNg0aKCYcZzMIu9TP3pRqFCC/CBOHiRshHyUKPUgN85g6uojlSQW8X
         QFWw==
X-Gm-Message-State: AOJu0YzYVtMzvCDIjpC2sNVw+t7lgoiag9jg2kciKTuhRtUPQ6nYisE0
	S6Uq9PbdZR1kfP0fBbU61/BiKEdr1NTpDPXHuRiwg/6cWlhJgsPqTB7sY0AdPPqb0UXRAu34Ejk
	13GebeXUqhKerfYeqFY2CRs9WjfpvySC/VUpqJnYYBqTcymnjccyb
X-Google-Smtp-Source: AGHT+IF6C/SwIvqlbLxucTJYUAL2q8HkGrSMqR+5EetOG0QkPzGgAwWEWEPq1SwZlbWcXn50bAgww/+pBy3uBpg7Pls=
X-Received: by 2002:a5b:c03:0:b0:de5:4c3a:5ab6 with SMTP id
 3f1490d57ef6-df4e0a6e888mr1686719276.3.1716374444532; Wed, 22 May 2024
 03:40:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Michal Simek <monstr@monstr.eu>
Date: Wed, 22 May 2024 12:40:33 +0200
Message-ID: <CAHTX3dJaBOjpy6bkasrezjzydyMWAGEjqOcfhY18XWg=XDjHgw@mail.gmail.com>
Subject: [GIT PULL] arch/microblaze patches for 6.10-rc1
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

please, pull these two patches to your tree. It is cleaning up code
around early_printk support
which was removed a long time ago.

Thanks,
Michal

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.monstr.eu/linux-2.6-microblaze.git tags/microblaze-v6.10

for you to fetch changes up to 58d647506c92ccd3cfa0c453c68ddd14f40bf06f:

  microblaze: Remove early printk call from cpuinfo-static.c
(2024-04-24 10:27:31 +0200)

----------------------------------------------------------------
Microblaze patches for 6.10-rc1

- Cleanup code around removed early_printk

----------------------------------------------------------------
Michal Simek (2):
      microblaze: Remove gcc flag for non existing early_printk.c file
      microblaze: Remove early printk call from cpuinfo-static.c

 arch/microblaze/kernel/Makefile             | 1 -
 arch/microblaze/kernel/cpu/cpuinfo-static.c | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)


-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal SoCs

