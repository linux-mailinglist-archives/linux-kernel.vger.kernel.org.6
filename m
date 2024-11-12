Return-Path: <linux-kernel+bounces-405044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0057B9C4C52
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 03:14:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B95A428A562
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 02:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271F3205132;
	Tue, 12 Nov 2024 02:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="m0apb0Y7"
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAF8D20493F
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 02:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731377659; cv=none; b=KIyRVfFKjA1wuX6UvMQl7FsDP8EFPXN5mGh2sbsmLFprfHaNZC2ooQGnCpS3646sRw0KAFdw/QcWUXFVreCMobLSZLgnqdCzHObNo1VLemGo1ICdknZuFSrcfYI/2PUaeBvfAHMpuyLindJ/KW9wQMqibGy+H6K7sxmXbFBsJ88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731377659; c=relaxed/simple;
	bh=YZtWTu/zKddH1thW2fycyh7s6Px0dUPMUAY0bA+VDds=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eAJccjauPza6As6AGvhE3eey6sitq8Fp0TJvpUabrkef+r78rWjQmDt3tq8shA8rT0J/YGV/OSQMaRJQ84N7S5XecAOlWzV6YG8rXnRmE6HbE5Al0/T6pfPX0JN46Qi2uBV8xSRBEkBLMNLrmnZcgKCSFYZChaIXrHpl1ITCJu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=m0apb0Y7; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=V08AQ
	xCCDv8oQUiPYDMmFjoKFMM9mpRrXxMWxLM/XBU=; b=m0apb0Y7FrkGVkghybzhz
	/wlzTqOXI+kThlgQLTOCUpI9ZQwgNLjVgZ4HQQ6M2ariqlZ0+3xzum/WCGc8yNUR
	o9LGUBVyLrVB1RELaI/bRaiTqsM0GeSZGyeIah7pPPmjjXIU4iPtzB1M+bCHOw6A
	L9vrvQaPop5QY6ZCxi26Fc=
Received: from localhost.localdomain (unknown [111.48.58.13])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3_4hwuTJnfZjdGw--.189S2;
	Tue, 12 Nov 2024 10:12:02 +0800 (CST)
From: 412574090@163.com
To: sudipm.mukherjee@gmail.com,
	mpe@ellerman.id.au,
	davem@davemloft.net,
	andreas@gaisler.com,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	dlemoal@kernel.org,
	cassel@kernel.org,
	ojeda@kernel.org,
	edumazet@google.com,
	martin.petersen@oracle.co,
	perex@perex.cz,
	t.sailer@alumni.ethz.ch,
	andrew+netdev@lunn.ch
Cc: linux-kernel@vger.kernel.org,
	xiongxin@kylinos.cn,
	weiyufeng <weiyufeng@kylinos.cn>
Subject: [PATCH v2 0/4] add new iomem type for parport devcie
Date: Tue, 12 Nov 2024 10:11:49 +0800
Message-Id: <20241112021153.18146-1-412574090@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3_4hwuTJnfZjdGw--.189S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7CFyfAr13GFyDtrWxtw4ruFg_yoW8ur4Dpa
	y8Xr97u3yDtFW7CF1UAw4fuFWYqa1xZry0ga47K3s09a1akFWUJw4UAF4qkF98tF1UtFy3
	tr1UtF1xCF17ZrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jTVbkUUUUU=
X-CM-SenderInfo: yursklauqziqqrwthudrp/xtbBXwmUAGcxnjyANgABsB

From: weiyufeng <weiyufeng@kylinos.cn>

For parallel port devices, the device type may be based on iomem, while
existing parallel port drivers only support the ioport type. This series
provides support for the iomem type of parallel port devices.

In order to have this feature available, a number of changes are needed:
  - Patch 1: Modify the kernel print function to a standard format.

  - Patch 2: change struct parport member base to iobase for ioport
    type. because in Patch 4,mapbase member will be added to struct
    parport.

  - Patch 3: struct parport_data added for simplify data initialization.

  - Patch 4: iomem type for parport added.

Best regards,
weiyufeng

Changes v1 -> v2:
  - Patch1
    No changes

  - Patch2
    fix compilation error issues

  - Patch3
    No changes

  - Patch4
    add iounmap and release_mem_region for mapbase_hi

weiyufeng (4):
  parport: use standard kernel printing functions
  parport: change struct parport member to iobase
  parport: add parport_data struct
  parport: add iomem type for parport

 arch/powerpc/include/asm/parport.h      |   5 +-
 arch/sparc/include/asm/parport_64.h     |  13 +-
 drivers/ata/pata_parport/bpck6.c        |   2 +-
 drivers/ata/pata_parport/pata_parport.c |   2 +-
 drivers/auxdisplay/ks0108.c             |   4 +-
 drivers/net/hamradio/baycom_epp.c       |  12 +-
 drivers/net/hamradio/baycom_par.c       |   6 +-
 drivers/net/plip/plip.c                 |   2 +-
 drivers/parisc/superio.c                |   9 +-
 drivers/parport/daisy.c                 |   2 +-
 drivers/parport/parport_cs.c            |  73 +--
 drivers/parport/parport_gsc.c           |   8 +-
 drivers/parport/parport_ip32.c          |   8 +-
 drivers/parport/parport_mfc3.c          |   2 +-
 drivers/parport/parport_pc.c            | 699 ++++++++++++++----------
 drivers/parport/parport_serial.c        |   7 +-
 drivers/parport/parport_sunbpp.c        |  24 +-
 drivers/parport/procfs.c                |   2 +-
 drivers/parport/share.c                 |   6 +-
 drivers/scsi/imm.c                      |   8 +-
 drivers/scsi/ppa.c                      |  10 +-
 include/linux/parport.h                 |  30 +-
 include/linux/parport_pc.h              | 109 +++-
 sound/drivers/mts64.c                   |   6 +-
 sound/drivers/portman2x4.c              |   6 +-
 25 files changed, 642 insertions(+), 413 deletions(-)

-- 
2.25.1


