Return-Path: <linux-kernel+bounces-423145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AB09DA36E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 09:01:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 537E6282DCC
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Nov 2024 08:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF29156236;
	Wed, 27 Nov 2024 08:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wB1sAJQZ"
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADBF12C499
	for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 08:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732694473; cv=none; b=MbWiB1C6sx3s6b/O/k3IXKmGLqF5WJ2J/n6+1RJLyVkAB7A85Xx6cdx/Fir9xGSdUv0YzeKGsPBOtf7saZigpemH8XyMTbQgQkAJ6P4QL/bQBldmsrvggys9ZtZnkJ33LVq2CixQl7Ww1qiwP06uBObWxpS/zISlduGXgyjGfKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732694473; c=relaxed/simple;
	bh=AbkDYsis4owsrh1UCJvHba4T0vyQ/Nv1EmYIBX04NUM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=fqSAPvkmDg98x88WtBrcI8bplW/1KgdKRcmna47AUe78x1C4JiqIA0cgRZQHYb9EfHPK7gAvKUFnv6ffITyWUgzg4uhkBBwIi4X/MUdIJvSqVtMGpe0f8En7qBoAamiAxqR2AXgjzFisMt5P5FMGzqD8IOBFtU3RNJppFkEArYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wB1sAJQZ; arc=none smtp.client-ip=209.85.167.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-3ea55e95d0fso1139465b6e.2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Nov 2024 00:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732694471; x=1733299271; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=hYdfHihuwL6Ju6kDqZ75VBX+k7CPPQhvCWcMy8zyxAs=;
        b=wB1sAJQZ6e4uxEDuxGEXz4TQPcUWDWrOrQ/uE00NM11y22nxmWe+XCuQSbmgGwtNhu
         1pS9J2eefqlZhh1X+b4WGUw+HJiGeH/oQq/CdKF8IIq1nyQKi0nZ3G+SZqf1RvEPQdt0
         uXDrsUnSsdxkJHsQwk4ZBL/rnAiF5bfb576R2O4LHSEgBwKQo2bcD3CGGPorJuoJq35/
         AeCLdW5UCtFyIpdkVoxb6RZEdznp9J7wloWUA16oRQxGhinEQ/EARzaiVSsOUKi563Q0
         90Mb0QZCIULuXfYYYE4fIZrjclYLPD5oMiMcchI80Evf/xlYm8S0wuMo3AXuXh+AZtrw
         P1fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732694471; x=1733299271;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hYdfHihuwL6Ju6kDqZ75VBX+k7CPPQhvCWcMy8zyxAs=;
        b=dR7yQJv/8adgB7cEqXF9IqUS/MgnMdy8oRBi8JYKl0EaHo4M+EKPMqERhCzDDuKAii
         vg8d9j0LB35Cfj763n6r3Pj5rTdAQXlJXqUkuEKCqeLmLE8T8BXumScSskLHQxys4wf8
         NBIWPXDMtXWV7v5V36M5akca9tHT/bjHeakBMneaY1lmh9xfl6SO6sTBTvKGbs5phwI0
         hM9viLXNZXnko6gOt33LAS5T2hWx+jOkUiEENf+0hfhmDHgJw+mTr867zME4p7hqQQGZ
         yJJImdBrIQhUlk0gACwC+CTaNeo/8GojGzsuxPzsqUXBB0BQcbUp4bTJMGsw38CjnQOC
         ZbrA==
X-Forwarded-Encrypted: i=1; AJvYcCXu0GugnC+Kij47HdEPtsUeAxz4N+GVaBgGzygXL0GQvH9xrCrxZ8PLHrfW0vlmztRi0QStMcNRAeOn9TY=@vger.kernel.org
X-Gm-Message-State: AOJu0YylEG9tpA9JGqpN8GEy28T8/Xu86cs9cpkRTILOiWaV7aNHDOSa
	tXAJZXgov0nZ1J561U/WzOT6ZZq+8FznRwlXAc5XewXLH1Oq3cPbQLaN7MocyFUzFpYiVaehUNK
	WY2riH3Xf4uLctgowt7/jEfV02O4X8QCMABJYL4aeYY25Qcemv1o=
X-Gm-Gg: ASbGncuMHcPmk39oOoJM567nopEMOVLvAg0onmpnng633GKMKW3z8uLR86/VY3x+ERE
	5odI8iM/8ZWzXmWygU0r6xiVQ2i/jj309
X-Google-Smtp-Source: AGHT+IEkxgFBqTgSvpO8yYB0IKDotz+aNBc7IBovLs4xngUKDxA0NRMInMSF3uQ1HnkNvQWdMO6Y8oP8iwyFQF4i8lk=
X-Received: by 2002:a05:6808:18a5:b0:3ea:5e04:23ef with SMTP id
 5614622812f47-3ea6dda02edmr1747674b6e.37.1732694471292; Wed, 27 Nov 2024
 00:01:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Wed, 27 Nov 2024 13:30:59 +0530
Message-ID: <CA+G9fYsF3x+ZXURQmgA1yQj-eiobr378HbodpJf4ncng7QYXmg@mail.gmail.com>
Subject: drivers/virtio/virtio_ring.c:1162:11: error: 'struct vring_virtqueue'
 has no member named 'premapped'
To: virtualization@lists.linux.dev, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, eperezma@redhat.com, 
	Sasha Levin <sashal@kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Anders Roxell <anders.roxell@linaro.org>, Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"

The following build errors were noticed for arm64, arm, x86_64 and riscv.

First seen on Sasha Linus-next 441d2975754ad94f3ce2e29f672824bc2dc5120c.
  Good: 07e98e730a08081b6d0b5c3a173b0487c36ed27f
  Bad:  441d2975754ad94f3ce2e29f672824bc2dc5120c

arm64, arm, riscv and x86_64:
  build:
    * clang-19-defconfig
    * gcc-13-defconfig
    * clang-19-lkftconfig
    * gcc-13-lkftconfig

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

Build error:
---------
drivers/virtio/virtio_ring.c: In function '__vring_new_virtqueue_split':
drivers/virtio/virtio_ring.c:1162:11: error: 'struct vring_virtqueue'
has no member named 'premapped'
 1162 |         vq->premapped = false;
      |           ^~
drivers/virtio/virtio_ring.c:1163:11: error: 'struct vring_virtqueue'
has no member named 'do_unmap'
 1163 |         vq->do_unmap = vq->use_dma_api;
      |           ^~
make[5]: *** [scripts/Makefile.build:229: drivers/virtio/virtio_ring.o] Error 1

Build image:
-----------
- https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-25212-gbe03d2e1a06f/testrun/26081256/suite/build/test/gcc-13-lkftconfig-rcutorture/log
- https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-25212-gbe03d2e1a06f/testrun/26081256/suite/build/test/gcc-13-lkftconfig-rcutorture/history/
- https://qa-reports.linaro.org/lkft/sashal-linus-next/build/v6.11-25212-gbe03d2e1a06f/testrun/26081256/suite/build/test/gcc-13-defconfig/history/
- https://storage.tuxsuite.com/public/linaro/lkft/builds/2pPghaTDWgXtaR5FXfFS4Ay3d4C/

$ git log --oneline
07e98e730a08081b6d0b5c3a173b0487c36ed27f..441d2975754ad94f3ce2e29f672824bc2dc5120c
 -- drivers/virtio/virtio_ring.c
   441d2975754ad Merge tag 'for_linus' of
https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost into
linus-next
   a49c26f761d2b virtio: Make vring_new_virtqueue support packed vring

Steps to reproduce:
------------
- tuxsuite build \
    --git-repo https://git.kernel.org/pub/scm/linux/kernel/git/sashal/linus-next.git
\
    --git-sha be03d2e1a06f7bd4be131c48f1c5555e83470a4d \
    --target-arch arm64 \
    --toolchain gcc-13 \
    --kconfig https://storage.tuxsuite.com/public/linaro/lkft/builds/2pPghaTDWgXtaR5FXfFS4Ay3d4C/config

metadata:
----
  git repo: https://git.kernel.org/pub/scm/linux/kernel/git/sashal/linus-next.git
  git sha: ed9a4ad6e5bd3a443e81446476718abebee47e82
  kernel config:
https://storage.tuxsuite.com/public/linaro/lkft/builds/2pPghaTDWgXtaR5FXfFS4Ay3d4C/config
  build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2pPghaTDWgXtaR5FXfFS4Ay3d4C/
  toolchain: gcc-13, clang-19 and clang-nightly
  config: defconfig, lkftconfig
  arch: arm64, arm, x86_64 and riscv

--
Linaro LKFT
https://lkft.linaro.org

