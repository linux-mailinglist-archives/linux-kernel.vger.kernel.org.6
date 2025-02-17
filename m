Return-Path: <linux-kernel+bounces-517366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 362EDA37FD5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 11:20:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 849D71884AE5
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 10:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5988721772C;
	Mon, 17 Feb 2025 10:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="viPX+Pkp"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383071DE2CC
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 10:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739787470; cv=none; b=olzVUupHUlB5KX5usVpAZDcOkXJ+PcOK9HrifxOXzf8pPIzCrmio6emDK+IJS4I3HnQYTbeUBoX69+s2Zn/7NXhpXWrQVTqk2K78Rp03hn1fOCalWtdbXhkggc8/M7cucVhGIWsp7R2Up6kp/e8amvMu3auB+9vbjyPgvIAPFrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739787470; c=relaxed/simple;
	bh=7r+4EPkQi0khwl3pIMV3sEMCc4jpZs7gCnWySQtmFhk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TB/te81PQ/2SdLELwoZpe1uLgvDIiLy/0ZCBnVhnIRB32fQfWU88nhz7W0hkrJdx0HxtbkigtHIad2Fa4Y0lSeWZGwcA7dhnXT2MP1acAxJUSLWwwcpwP7R17YmCbnWZu5h4Y94Dzcv/Qk4h7WZVg17WhtKNjsWoBW4sVCfci30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=viPX+Pkp; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aaec111762bso960094966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 02:17:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739787465; x=1740392265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dLhLqEj5CnQGR3HAISzr8o6znCJqNhfLLG9jh4rRpzQ=;
        b=viPX+PkpF32PixuYkVDABqydvgOAyGmPhijKrDpDJbYaxWzgdJddJ32jLeZG4eqgCS
         EFlpwZaPqaqCu5vnMHpZ37lCLT4qxXPOL/qbvkrtqvERWnizOjLxfPJ2OE2N1ksBrb20
         styW8xEsW+pTBAsfX2n4ptvU42ZVmhbbELcIPZBSkd2H6kOJPaZPsV5Mv+ikp0HsrOjj
         ZYxkRMuHv+yGuVyMCeYR24PxXYXrGeSZJ0qQCEZvHDxWJgu6+h3wRbnVXEwF5UQ4q3Y0
         OIVC1iQLa4MqbaWdIlNJNQ6LCkrW344sDv5h+mFSYrBiQPfx/OGNy1vg8+9GV/MJ4AJ8
         tSZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739787465; x=1740392265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dLhLqEj5CnQGR3HAISzr8o6znCJqNhfLLG9jh4rRpzQ=;
        b=VkAGBLHEhLmDW5iTR0JxIr08eM3uRqc9yhqalUp0Npg618gp1dpWB3Yfw+ymo/75HH
         ZAhUIcqmxbux5PiVAjz/NorZPcKn328GD47/pgOZMHy28yUAo3pRYpdj697MtYrFBfMK
         QSCVlFf/UmCCjUqB0o69ERyOBW/OiWu/i3PfDY4tLu7sVwT5Z9yc4FXcM9amplKLr2lJ
         cnBLY1DWBlcFPA8jdeyTYaASFGV0wGFlNBm88N0cFMmsx359/WOU3PEOLk3oymX5lICA
         2bVzMBOCyczfAsNBKEMymntK5aQXZkQhEEtTU9qBXy/Gk/NlEUsgC1MOgOXf5bsL7YMw
         vSsg==
X-Gm-Message-State: AOJu0Yy8ovDYJxGiSO9nneoZnaa67fqrSxserb9OpNP1btg4ZV9iOemP
	xILZdqD2NyR/EtItS8qKDiQ93tgfQfgxVBFRtppXQYrzJnpxKJPKq1f+OWzE+/17LM4in+48G63
	kdHg=
X-Gm-Gg: ASbGncsOjur3KhAboPh0owUwXGdsbRlLWN2av7pc5aXcJfLXYasR1AtxSOTi/g1D/lu
	bLvS9SPP3jLt2sinaq7CTGvUY8WRN7tW6+LP/HWH1q9NifeuYlqV2tkfVBwOBDh/jbudB4HYj7c
	5wbVwD2PGXkDkl2lkOeo7ekgsNp10R0Fo+TwBeEMO/lP6BcMu3QK9HQiO3DggarGZqw1ALAyztt
	VF7/iqPq0Ewu0CaiSu2uCVmoHHF2nu2EPb1nPraGHu/VuPR7cMlU1V/Q8YROVcxOUbQbGh2yZ3H
	8IfW0O6+uAyH55rKVF8Hfaqv
X-Google-Smtp-Source: AGHT+IGhAefa1tvvBaYve+g3pCx7CrvFHmDaSY+YPBz5y8cOdMoT47LHpy0cyxq3ytVFBIUJ3pcdAg==
X-Received: by 2002:a17:907:2da0:b0:ab7:83c2:bdbf with SMTP id a640c23a62f3a-abb710dc6cbmr892362566b.41.1739787465317;
        Mon, 17 Feb 2025 02:17:45 -0800 (PST)
Received: from eugen-station.. ([82.76.24.202])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abb8b1767e8sm308583266b.174.2025.02.17.02.17.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 02:17:44 -0800 (PST)
From: Eugen Hristev <eugen.hristev@linaro.org>
To: linux-arm-msm@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	kees@kernel.org
Cc: linux-kernel@vger.kernel.org,
	johannes@sipsolutions.net,
	gregkh@linuxfoundation.org,
	rafael@kernel.org,
	dakr@kernel.org,
	andersson@kernel.org,
	konradybcio@kernel.org,
	tony.luck@intel.com,
	gpiccoli@igalia.com,
	pmladek@suse.com,
	rostedt@goodmis.org,
	john.ogness@linutronix.de,
	senozhatsky@chromium.org,
	quic_mojha@quicinc.com,
	linux-arm-kernel@lists.infradead.org,
	kernel@quicinc.com,
	Eugen Hristev <eugen.hristev@linaro.org>
Subject: [RFC][PATCH 00/10] pstore: directly mapped regions
Date: Mon, 17 Feb 2025 12:16:56 +0200
Message-ID: <20250217101706.2104498-1-eugen.hristev@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This series comes as an RFC proposed solution to enhance pstore and
devcoredump with the following functionality:
It is interesting to mark specific memory regions in the kernel
as core areas, such that in the even of a cataclysmic event like
panic, deadlock, hardware fault, those areas can be retrieved by
an external agent, that can be JTAG, firmware, additional debug
processor, etc.
Even though pstore panic handlers attempt to copy data into the
persistent storage, this is not always working, because the kernel
could be in a deadlock, have irqs disabled, panic handler could
crash itself, or even some memory areas could be corrupted badly
enough that the recovery mechanism doesn't work.
This patch series attempts to solve this by reusing existing
infrastructure in pstore and devcoredump, and provide a copy-free
possibility to have core kernel data exposed for creating debug
information like a coredump or list of binary elements with data.

How this works:
Drivers and key kernel infrastructure, like for example the dmesg
buffer (ftrace buffer is still work in progress and not in the series),
would register themselves into pstore, with a simple function
call taking a name, a pointer to the area and size.
That would be all, and the patch labeled "EXAMPLE" shows a driver
doing exactly that, registering it's own dev struct with string markers
that can help identifying the data later once it's being retrieved.
Further, pstore and pstore/zone would keep track of all registered
areas inside the intermediary back-end. There would not be any copy of
the data.
Pstore would require a new type of back-end, named directly mapped
(because there is no copy, and each zone directly maps the incoming
buffer). If this back-end is available, then pstore further calls
the back-end to register the area.
The back-end itself is then free to do whatever it wishes with the
received area. It can (possibly) do a copy to store data, it can
have a timer to check the area every x time periods, or store the
pointers inside a table of contents (which is what the qcom smem is
doing).
The qcom smem driver registers itself into pstore as a new type of
back-end called shared memory. It's very similar with the pstore/blk
but much simplified, to cope with just a shared memory storage.
The areas metadata are stored in a shared memory that is being managed
by the qcom_smem driver. It's called shared memory because it's being
shared between the main processor running the kernel and additional
secondary remote processors running firmware.
In this qcom smem backend case, the firmware runs when there is a
panic event, of watchdog timeout, and uses the table of contents to
retrieve useful kernel debug data.

The advantages of this proposed idea are: no kernel panic handler
intervention. Everything is being marked and prepared ahead of time,
before there is an actual crash. There is no overhead associated,
simply the areas are being marked and metadata created, no buffers
associated, no memory areas reserved for it. Memory areas being marked,
there is no possibility of getting older useless data, that was copied
before the actual events leading to a crash would occur, so the data
would be the real actual data the kernel was working on.
Of course, this would not work if there is no external agent to parse
the areas and get the useful data. However as the hardware becomes
more and more advanced, in the cases where this is available, kernel
debugging had no way of using this advantage. As the hardware evolves,
so is the kernel.

There is another aspect to underline: the directly mapped zones
change the semantics of pstore using them. Pstore relies on user being
able to read the data from a previous kernel run once the system
has rebooted. This is not valid with the directly mapped zones unless
the JTAG/firmware would copy this data into a persistent area and make
it available upon reboot (which is not impossible).

I would like to thank everyone reviewing and chiping in on the series.

The back-end implementation for qcom_smem is based on the minidump
patch series and driver written by Mukesh Ojha, thanks:
https://lore.kernel.org/lkml/20240131110837.14218-1-quic_mojha@quicinc.com/

Eugen

Eugen Hristev (10):
  pstore/zone: move pstore_device_info into zone header
  pstore/smem: add new pstore/smem type of pstore
  pstore/zone: introduce directly mapped zones
  qcom: smem: add pstore smem backend
  pstore: implement core area registration
  qcom: smem: enable smem pstore backend
  printk: export symbols for buffer address and length functions
  pstore: register kmsg into directly mapped zones if available
  devcoredump: add devcd_{un}register_core_area API
  rng: qcom_rng: EXAMPLE: registering dev structure

 drivers/base/devcoredump.c     |  13 ++
 drivers/crypto/qcom-rng.c      |  11 ++
 drivers/soc/qcom/Kconfig       |   9 +
 drivers/soc/qcom/Makefile      |   6 +-
 drivers/soc/qcom/smem.c        |  10 ++
 drivers/soc/qcom/smem_md.c     | 306 +++++++++++++++++++++++++++++++++
 drivers/soc/qcom/smem_pstore.c | 112 ++++++++++++
 fs/pstore/Kconfig              |  13 ++
 fs/pstore/Makefile             |   3 +
 fs/pstore/platform.c           |  84 +++++++++
 fs/pstore/smem.c               | 115 +++++++++++++
 fs/pstore/zone.c               | 122 +++++++++++--
 include/linux/devcoredump.h    |   3 +
 include/linux/pstore.h         |  20 +++
 include/linux/pstore_blk.h     |  14 --
 include/linux/pstore_smem.h    |   9 +
 include/linux/pstore_zone.h    |  17 ++
 include/linux/soc/qcom/smem.h  |  43 +++++
 kernel/printk/printk.c         |   2 +
 19 files changed, 885 insertions(+), 27 deletions(-)
 create mode 100644 drivers/soc/qcom/smem_md.c
 create mode 100644 drivers/soc/qcom/smem_pstore.c
 create mode 100644 fs/pstore/smem.c
 create mode 100644 include/linux/pstore_smem.h

-- 
2.43.0


