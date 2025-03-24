Return-Path: <linux-kernel+bounces-574109-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 46031A6E0B0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:16:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3CEA716CB4F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:15:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00632638AD;
	Mon, 24 Mar 2025 17:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="arzZx/Eg"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8A8263C82
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742836533; cv=none; b=oOE17PcA1+cL4k171XTu+JnNJYY2unMX7uQZVVK6yOFxU6zdXiTurHj7tkf0epOuJLj/9yA794E8R8kM1ctnDYJbG6K3tHDyg0tGKdGVdHYglAZgCogTE6iuFxLjzc0SZcT38Tcx+ZzbyTeEZS0rN1+f5BaN2zhopijpD50wZFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742836533; c=relaxed/simple;
	bh=wM3AqIwstheJIlegkNjpP5/v8Nzg/omlh6gT8lYkPbk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=snMEnNFHvIBD5NjwJp6aJkxNezdnx0i3Leg0Ipjmg9rjV9lXIVJMejmxemchBOcPIJdlacDa9wUz/CElwAtoM+go8WMtJQb1biYG7lTRpCN7j30Trr/hBu2Z9p46Kk7jbZ/umbla769Lh0gxKihS2xhbSu2EWgKk4Dl3BMZ02yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=arzZx/Eg; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-227c7e57da2so21014375ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 10:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742836531; x=1743441331; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xyzocSsBstsJ+B6/3xGzJ/IZjtGnAgF69dzjwtUqQoQ=;
        b=arzZx/Eg5f0FHWkI/r6rPRLaotYGgq6H4hJB4x+JOOp2D+uyJEVeHB0D/TFdjyh6gO
         2r6IpTbGeoeMGtb675OWATYuGXPvq0j0iU6sL7mLH6C7BbVKsyRLOxFoYCh51NcQ6l05
         fOu/yj31GrFRAbTTG7KxeRrIu9z04BephEJYe1ogefGGSZ16d/wd1IEJ5l5HYoEDliW9
         ow8toCJ2uOZ7haUcE3a9bJxSXfSid+7GBwyQ4ZJXAB9JlxSugp7zvIJeQh/5nfl98R5Y
         BAnUWvIYRGmoOZA6M8gEw8A4kxEASbKJXmJkVKJTsRO7/QNrJaYEMUgoE8vIkJyFRYp1
         6CZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742836531; x=1743441331;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xyzocSsBstsJ+B6/3xGzJ/IZjtGnAgF69dzjwtUqQoQ=;
        b=W0QFPXYePhJV1T31YXkVVOH9bdfQfnZxAAs7EJeIPrAPK4ChiW61pnD+8E5WT33fCW
         c7dFIgNTlf3F1dgxuXiS3cWDh9foH5UgcP5qF+zi3hWR0Pb0+SJtYNbBsj7xiErfI1bx
         KNPunlK7KFjSNY9t8zq6Oa00Ixdlbtj0xQ3bRyO9UOSDni/l09knkhVKrqYfb+L9sK++
         A+NBFo+K/FSyBeNXX4HF2q7I+5mZsKbki23i0xm0oRtHhEFSvWKThniN/YlbDKyjKmI9
         yHLdcfYSZttaVNIrGAYWI/l6qcMF1qoumG5fPpXH4RRA4f5owPXQMkBLU45zkbISgXBK
         YEDg==
X-Forwarded-Encrypted: i=1; AJvYcCWbI4hvjpkkHAuN8k7xtgl9kdCnOxQbkIj7knR9Qxi9CmhlSSFbC3gtnQEWGaTaX87W0aRcyoc1LYcYnlY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPyEFu4BPLmMbEA6qcwLwa13TJUNP/mal9i0cETEn+KKvgVJYX
	m8KLhXmKAmjCUDwTxMWkBJaYlSabR/7MpGQtDutBzHM2OnbBVbFw
X-Gm-Gg: ASbGncsklpKsYBj3eusmUxYR4QGyJKASKh650IOeND9afSon+wuyhLH++ss+hKT1bTP
	UNwp0wAd+eN5hVa0R/7iGXwseaZEPbnh3uAZomQ/+q6EGtzajY/JvJ6UjXVQ/xpSESPzCFODkOn
	NMLiXRfRa/b89rlTgQK0jGjoPteaYWN/kDMhkkOSZZOooMxvmndTPIkJNNwBPVaDV9EtTcePCMq
	aSaqK+giq4X5D9Z6xOinoTt/1a4UqLp9hx1PgiFaeCIj84f3y5MaD1U065CqqGE7eXRSf0msjid
	ORV4SoWUqlulagSMyO+brE/cVQx138wBWYCYBdvBJr9ed2iC8c7ysiyuMnoCe8GOe5fF
X-Google-Smtp-Source: AGHT+IEYQom4bP5cFMVWPZ5GXiaOh8cn9FkNRHLuvtFYBAYvFYHKjewDgpcZtz8ypJ/T6r9SY00L3w==
X-Received: by 2002:a17:902:fc43:b0:216:794f:6d7d with SMTP id d9443c01a7336-22780e60ad9mr264905345ad.48.1742836530633;
        Mon, 24 Mar 2025 10:15:30 -0700 (PDT)
Received: from localhost (maglev-oncall.nvidia.com. [216.228.125.128])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3030f60994dsm8450390a91.26.2025.03.24.10.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 10:15:29 -0700 (PDT)
Date: Mon, 24 Mar 2025 13:15:27 -0400
From: Yury Norov <yury.norov@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org
Cc: Yury Norov <yury.norov@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tamir Duberstein <tamird@gmail.com>,
	I Hsin Cheng <richard120310@gmail.com>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Ignacio Encinas <ignacio@iencinas.com>,
	Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
	Joel Savitz <jsavitz@redhat.com>
Subject: [GIT PULL] bitmap changes for v6.15-rc1
Message-ID: <Z-GTL4MMWuQ_dw9W@thinkpad>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

Please pull bitmap changes for 6.15. They all spent for over 2 weeks
in -next with no issues.

Regarding rust bindings, LKP is now running my branch with CONFIG_RUST
and bitmap tests enabled. Thanks to Miguel for that.

Thanks,
Yury

The following changes since commit 2408a807bfc3f738850ef5ad5e3fd59d66168996:

  Merge tag 'vfs-6.14-rc4.fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs (2025-02-17 10:38:25 -0800)

are available in the Git repository at:

  https://github.com/norov/linux.git tags/bitmap-for-6.15

for you to fetch changes up to 1cf8e152e8c909c2d6c610b35278a7480af7a156:

  cpumask: align text in comment (2025-03-20 17:33:31 -0400)

----------------------------------------------------------------
bitmap changes for 6.15

This includes:
 - cpumask_next_wrap() rework from me;
 - GENMASK() simplification from I Hsin;
 - rust bindings for cpumasks from Viresh and me;
 - scattered cleanups from Andy, Tamir, Vincent, Ignacio and Joel.

----------------------------------------------------------------
Andy Shevchenko (1):
      bitmap: Align documentation between bitmap_gather() and bitmap_scatter()

I Hsin Cheng (1):
      uapi: Revert "bitops: avoid integer overflow in GENMASK(_ULL)"

Ignacio Encinas (1):
      riscv: fix test_and_{set,clear}_bit ordering documentation

Joel Savitz (1):
      cpumask: align text in comment

Tamir Duberstein (1):
      bitmap: remove _check_eq_u32_array

Vincent Mailhol (1):
      treewide: fix typo 'unsigned __init128' -> 'unsigned __int128'

Viresh Kumar (1):
      rust: Add cpumask helpers

Yury Norov (14):
      cpumask: add for_each_{possible,online}_cpu_wrap
      objpool: rework objpool_pop()
      virtio_net: simplify virtnet_set_affinity()
      ibmvnic: simplify ibmvnic_set_queue_affinity()
      powerpc/xmon: simplify xmon_batch_next_cpu()
      cpumask: deprecate cpumask_next_wrap()
      cpumask: re-introduce cpumask_next{,_and}_wrap()
      cpumask: use cpumask_next_wrap() where appropriate
      padata: switch padata_find_next() to using cpumask_next_wrap()
      s390: switch stop_machine_yield() to using cpumask_next_wrap()
      scsi: lpfc: switch lpfc_irq_rebalance() to using cpumask_next_wrap()
      scsi: lpfc: rework lpfc_next_{online,present}_cpu()
      PCI: hv: Switch hv_compose_multi_msi_req_get_cpu() to using cpumask_next_wrap()
      cpumask: drop cpumask_next_wrap_old()

Yury Norov [NVIDIA] (1):
      MAINTAINERS: add rust bindings entry for bitmap API

 MAINTAINERS                         |  5 +++
 arch/powerpc/xmon/xmon.c            |  6 +---
 arch/riscv/include/asm/bitops.h     |  4 +--
 arch/s390/kernel/processor.c        |  2 +-
 drivers/net/ethernet/ibm/ibmvnic.c  | 18 ++++++----
 drivers/net/virtio_net.c            | 12 ++++---
 drivers/pci/controller/pci-hyperv.c |  3 +-
 drivers/scsi/lpfc/lpfc.h            | 23 +++---------
 drivers/scsi/lpfc/lpfc_init.c       |  2 +-
 include/linux/bitmap.h              |  8 +++--
 include/linux/bits.h                |  2 +-
 include/linux/cpumask.h             | 71 +++++++++++++++++++++++++------------
 include/linux/objpool.h             |  7 ++--
 include/uapi/linux/bits.h           |  8 ++---
 include/uapi/linux/const.h          |  2 +-
 kernel/padata.c                     |  2 +-
 lib/cpumask.c                       | 37 ++-----------------
 lib/test_bitmap.c                   | 28 ---------------
 rust/bindings/bindings_helper.h     |  1 +
 rust/helpers/cpumask.c              | 45 +++++++++++++++++++++++
 rust/helpers/helpers.c              |  1 +
 tools/include/linux/bits.h          |  2 +-
 tools/include/uapi/linux/const.h    |  2 +-
 23 files changed, 147 insertions(+), 144 deletions(-)
 create mode 100644 rust/helpers/cpumask.c

