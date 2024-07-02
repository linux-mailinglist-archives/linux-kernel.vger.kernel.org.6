Return-Path: <linux-kernel+bounces-237173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFD9091ED0C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 04:47:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70087284141
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 02:47:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9B31758E;
	Tue,  2 Jul 2024 02:47:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fYnrvcGB"
Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7293764D
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 02:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719888461; cv=none; b=eK8DgRNFLQqnZ+njIddoX86UGvwmeeARhKxFHK2V/bNqtCpAv/FlaPwlIUJEyW/5npiFjsobZng16n+HCcLExSYDZA+Ncksi5BbayqcG4dh5vWzNXTBUNo9iLB4lHokUudyyPVHsQ0VAyZlzRWskjoi7y3QOnAxRYKrTxKPP7g4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719888461; c=relaxed/simple;
	bh=k9pupan21Drc/e6jgEWT1G9ZEMIGQVh7LEPKoAd7n2A=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=CtCo9GcGYd12hZiCE5a1/Ez+ImslrT2BDB3FhWwKOyPBjzMeo0Ns1fnsk66vjxps7KVwzjMRQqmLaqYQJWgcB60rp0A0mMOenmKf8pneI5sQBR/n5O9mJ9JKg29hl8vV6mNt7rm7rQGaTXXTsAXBa6T7A84XgfQvRgz/3lFAUh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fYnrvcGB; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-70ab3bc4a69so2418510a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 19:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719888460; x=1720493260; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=YEaY1ZnCNnC7h9zQIpxFUoesJp0R+GOwbf2vIhB2fmc=;
        b=fYnrvcGB//JD/hFkP/rNdaPFJndffAztknwOhb4Yq3smwUDU2K60hfduRH9y75S5lB
         nU9j2Hwa2L2T6YbuQrQdqg6eYZCrp+nVfufTskdwDA6SmL/riE74HU0gXn8Rh7VAcI0k
         d8EpNkP4ABRhc+GEwF0BNr+QMeEdCoYVQ9TXt5quJGvY2o98+n46wYp5XiaA97txwIia
         cTCtaw+DWYTO367n0PJ/OZUE/F7lzyL3EO49t0+YREzaowsCdhc94Jt6bB/1IIXgxCMb
         j+S7KVrhF7kee1/Gh3BAPSg1pEdEhs/f0bP7AdXVneg1myLBOHnOVY3JdQ2alRney6rG
         MpXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719888460; x=1720493260;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YEaY1ZnCNnC7h9zQIpxFUoesJp0R+GOwbf2vIhB2fmc=;
        b=wcJaiMkFdw4vxJy4B6cKEwayCWAkqWm8BARFZKQBDWQlVFNcKT6tDNHEYSjCQHwofS
         qK6bEfhR0PN7YlqeMqrjvI8YNlqj/lbyR7CIyCQlSBc9Ga0QqW8cUnvfD0aOk2uwTH3u
         80tlY5kZ1xB6H37qnoPxKEB/9CAGwEz4fJe9IVHi4U568XuyPphAyUCCR9eE5IJ4Z9dX
         G6Rny9hhTfTqtr9D/sYd7/e2Pd7Xc+kipa2LN9uJ9cp9E9C/LY8wau/bqa/vvLcM+0tU
         2ThvYe18m+xtRTUIjs1Awxkb53BMxRhZK6WMQVkA+mDiNFXqGFlQGztbMqvtidhGlaEG
         Nz6w==
X-Forwarded-Encrypted: i=1; AJvYcCURb26oYiSYbxVoRwSUHt3Kmenc4z9D/kpjFfXI9na3i8TMg2b3eB+km1zzor+67mZjuaGX8BtwhTxhIvkgEXyDtfJAEPqUa5seAEyz
X-Gm-Message-State: AOJu0Yz1vbsgV05RxXyQNT24Oybx1PC9W284BNFcDTN93/+/Wx4TnVba
	DvdeVEX11hSzL1KUD/RG0dBusgzrjW7b+NrmwW0UZFa2xiawOc/mjhun9JRJAzS1ZSwxxfJPGq1
	O9jfhQ3mC+A==
X-Google-Smtp-Source: AGHT+IFDdXGdPHoTE2h1ApM7Y6u9hPK8eCu25r+Hv9Q2Sc5IVTFNykQuJYWzhZEv2kTZ22mTuA0CWyxmC4NSWA==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:6a02:fda:b0:6e6:e207:1d14 with SMTP
 id 41be03b00d2f7-73cff859cf6mr15652a12.12.1719888459582; Mon, 01 Jul 2024
 19:47:39 -0700 (PDT)
Date: Tue,  2 Jul 2024 02:47:28 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240702024735.1152293-1-ipylypiv@google.com>
Subject: [PATCH v5 0/7] ATA PASS-THROUGH sense data fixes
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Igor Pylypiv <ipylypiv@google.com>
Content-Type: text/plain; charset="UTF-8"

This patch series is fixing a few ATA PASS-THROUGH issues:
1. Not reporting "ATA Status Return sense data descriptor" / "Fixed format
   sense data" when ATA_QCFLAG_SENSE_VALID is set.
2. Generating "fake" sk/asc/ascq based on ATA status/error registers when
   ATA_QCFLAG_SENSE_VALID is set and CK_COND=1.
3. Fixed format sense data was using incorrect field offsets for ATA
   PASS-THROUGH commands.
4. Using qc->result_tf in ATA sense data generation functions without
   checking if qc->result_tf contains a valid data.

Changes since v1:
Thanks Damien and Niklas for the reviews!

- Squashed two v1 patches 2/4 and 3/4 into one patch with a different
  implementation.
- Added 'Cc: stable@vger.kernel.org' tags to patches that are fixing bugs.
- Reordered patches with the 'Cc: stable@vger.kernel.org' tag to be applied
  first in order to simplify backports to stable releases.
- Restored the buffer memset in atapi_eh_request_sense().
- Updated declaration order in v1 patch 4/4.
- Added a patch to cleanup unused ATA device id in ata_to_sense_error().
- Updated fill_result_tf() to set ATA_QCFLAG_RTF_FILLED after populating
  the result taskfile. Removed now redundant flag sets/checks from ahci.
- Updated ATA sense data generation functions to return early if result_tf
  is not filled. Added WARN_ON_ONCE checks to generate a warning when
  ATA_QCFLAG_RTF_FILLED is not set and libata needs to generate sense data.

Changes since v2:
- Moved v2 2/6 patch (fixed ATA PT offsets) to be the first one in v3.
- Removed unused variable 'sb' from ata_gen_passthru_sense().
- Removed WARN_ON_ONCE checks and added ata_dev_dbg() logs instead.
- Removed the Fixes tag from v2 4/6 patch because the patch is doing
  a cleanup and is not fixing any bugs.

Changes since v3:
- Changed "RTF" to "result TF" in the log messages to make it more clear.
  Removed capitalization and punctuation to be consistent with existing logs.
- Marked the stable tag of the v3 2/6 patch with the 4.19+ LTS version.
- Added a patch to honour the D_SENSE bit for CK_COND=1 and no error commands.
- Fixed a bug in the v3 5/6 patch which caused the qc->result_tf.flags field
  assignment to be skipped if ahci_qc_ncq_fill_rtf() was executed.
- Added a patch proposed by Niklas to improve the readability of the complex
  ATA PASS-THROUGH handling in ata_scsi_qc_complete().

Changes since v4:
- Squashed v4 2/8 and 8/8 patches into one. Both patches modified the same
  function. Combining these related patches makes it easier to backport
  the changes to stable releases.
- Reworded the commit message in v4 3/8 to make it more clear.

Igor Pylypiv (7):
  ata: libata-scsi: Fix offsets for the fixed format sense data
  ata: libata-scsi: Do not overwrite valid sense data when CK_COND=1
  ata: libata-scsi: Honor the D_SENSE bit for CK_COND=1 and no error
  ata: libata-scsi: Remove redundant sense_buffer memsets
  ata: libata-scsi: Do not pass ATA device id to ata_to_sense_error()
  ata: libata-core: Set ATA_QCFLAG_RTF_FILLED in fill_result_tf()
  ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED before using result_tf

 drivers/ata/libahci.c     |  12 +--
 drivers/ata/libata-core.c |   8 ++
 drivers/ata/libata-scsi.c | 209 +++++++++++++++++++++-----------------
 3 files changed, 128 insertions(+), 101 deletions(-)

-- 
2.45.2.803.g4e1b14247a-goog


