Return-Path: <linux-kernel+bounces-392652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E0D4C9B96BB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 18:47:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6403D1F224F8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 17:47:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5913D1CC17C;
	Fri,  1 Nov 2024 17:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PbUbj4Iv"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26FE51AA7BF
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730483263; cv=none; b=bcj+YEOFh8d4hXvV2IvlDsTD+4F0Y8S8vDk4xnRtyTNCR0iP5B4ngWQ6p5qT/6lIoEfdiJi7NIvVkBRsbGpgLkGkGqWFoM6t7wqOCUcq9PlYzqiyc4/uxcJZHGrXwwDoPYmwl9+UwzzRqXiNHsJAAYrHkx0FX6TgzWQc93fm/Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730483263; c=relaxed/simple;
	bh=ogpYD5K8PsKO5i6G7GPGCXK3XdYDIzkpQox1GZRQeIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oME4qJZfF6x2Wb5JOA0AOUQ6a5XHn4O99oPrZCe1qKIVX7Sn5fWHfdc0Mhs83OpKEQEmNCIMb0tNTSsSZuYqGL9FVYViz+ffi6GC5c018DzeXHqjJ7KuzK+/qvOXHw/SSlqocmZ1dnRd8XyRioKuUQmNu8gQKlw3Ks0Qcg7p58k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PbUbj4Iv; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-37d5aedd177so1426557f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 10:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730483260; x=1731088060; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nqpqdAAsMY6Ea0B+Ms2g/Gdx1auCnnxqq5QczXj8Kic=;
        b=PbUbj4IvIAbAyG2ZtGCg07pwRIgO0fkyWbDX0jOQ1CkA6DM3gFI4P6INH9MGSRCuJZ
         WelngRzhH+wLyP2vwY6Wz6ihFfAfWV7T6zwWa2g9RBojZ1e8Tvl8jc0gLAUpHAhdneTG
         ijgbWZGLS+9IJv0zIAJGzpBH5PKUqwhBCbMHCsoZ5uZg/7/93MW0MXFWQRd4tVUYfAYS
         rcfSogd4tr7PMtpB/w8/sWPhLfwz1ocR9xhdufLBw+x9oBRy+ZNWqzLV2H2vi4fEixs6
         TwUmjuEDV1FSQnxlsu/5G2l0FTC0nRH/aTTJgtxbfCuRwx4mZ+3yt2FP9a6z0BSbVwdg
         xyqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730483260; x=1731088060;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nqpqdAAsMY6Ea0B+Ms2g/Gdx1auCnnxqq5QczXj8Kic=;
        b=IVB9daJL4OGQxp1OKYj1tpUCBXDQTtZ35ECvETaiIRrB+oe0OaEsO3Kfhsod3QanDA
         /NxEiBOa67rrQ+RsIhuJLccv+N0z+/y0H+qmI75Rw+grkY3tFtVc15ux+O49UqentrTN
         dB6ck4tIfLLqirX05r8m4BP4JTYfcesPwwdbd0vchHrwSHQZpClUS6Cn6yPs23yLoUsS
         uNP6NbdJGCPYDjhQTewhhrfGWIpW2z4XrTswDBKFf54GB1uVn5v5Nt2AbzT35lM+a4A7
         RXWHEklPtUKyqBZNfO4jKXjukLHcVMvJzHr4tc0+Rev8z3VSSHXaCWdXJMx6EMiisHcZ
         rezQ==
X-Forwarded-Encrypted: i=1; AJvYcCX0OYT0q/LFX3ZA9tzOOgJLhH8wW7UCxsvnRN3JC8bna+oRIz6g/ID4UhM/QAYwwQgcrIvRkhb3c+fDr/M=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZ7mBel/cLU4LP7NKNXq7Qs0NAc9+gDWBO9xsVg7962aqykGO3
	Ya7dktAFHSmI4vpEG8XzIxx3yICNW9/Qtw4P2vhyR/XBu2ElF96/
X-Google-Smtp-Source: AGHT+IGp6X2WRuG/2IzNPwJBQ5Vh8dtKSjI+JhJj/VcI7oAH6vhoDk+vbcGcTGmMYJC72h25Bs9yAA==
X-Received: by 2002:a05:6000:1863:b0:37d:43e5:a013 with SMTP id ffacd0b85a97d-381be765147mr6422778f8f.8.1730483260238;
        Fri, 01 Nov 2024 10:47:40 -0700 (PDT)
Received: from localhost.localdomain (82-64-73-52.subs.proxad.net. [82.64.73.52])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c1185b4bsm5732933f8f.112.2024.11.01.10.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 10:47:39 -0700 (PDT)
From: Dave Penkler <dpenkler@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	arnd@arndb.de,
	Dave Penkler <dpenkler@gmail.com>
Subject: [PATCH 0/9] Patch set for gpib staging drivers
Date: Fri,  1 Nov 2024 18:46:56 +0100
Message-ID: <20241101174705.12682-1-dpenkler@gmail.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patch 1 is a bug fix
Patches 2-6 replace custom debug with dev_dbg as well as
            using dev_xxx for pr_xxx where feasible.
Patch 7 Corrects some errors in Kconfig
Patch 8 is a code cleanup
Patch 9 corrects GPIB behaviour

Dave Penkler (9):
  Fix buffer overflow in ni_usb_init
  Replace custom debug with dev_dbg
  Update messaging and usb_device refs in ni_usb
  Update messaging and usb_device refs in agilent_usb
  Remove GPIB_DEBUG reference and update messaging
  Use dev_xxx for messaging
  Fix Kconfig
  Rationalize lookup tables
  Correct check for max secondary address

 drivers/staging/gpib/Kconfig                  |  14 +-
 drivers/staging/gpib/Makefile                 |   1 -
 .../gpib/agilent_82350b/agilent_82350b.c      |  70 ++--
 .../gpib/agilent_82357a/agilent_82357a.c      | 266 +++++++-----
 drivers/staging/gpib/cb7210/cb7210.c          |   2 +-
 drivers/staging/gpib/common/gpib_os.c         | 139 ++++---
 drivers/staging/gpib/common/iblib.c           |  20 +-
 drivers/staging/gpib/common/ibsys.h           |   4 +-
 drivers/staging/gpib/eastwood/fluke_gpib.c    |   2 +-
 drivers/staging/gpib/fmh_gpib/fmh_gpib.c      |   4 +-
 drivers/staging/gpib/gpio/gpib_bitbang.c      |  85 ++--
 drivers/staging/gpib/include/gpibP.h          |   8 +-
 drivers/staging/gpib/ines/ines_gpib.c         |   2 +-
 .../gpib/lpvo_usb_gpib/lpvo_usb_gpib.c        |  69 ++--
 drivers/staging/gpib/nec7210/nec7210.c        |  34 +-
 drivers/staging/gpib/ni_usb/ni_usb_gpib.c     | 379 ++++++++++--------
 drivers/staging/gpib/tms9914/tms9914.c        |   8 +-
 drivers/staging/gpib/tnt4882/tnt4882_gpib.c   |   7 +-
 18 files changed, 579 insertions(+), 535 deletions(-)

-- 
2.46.2


