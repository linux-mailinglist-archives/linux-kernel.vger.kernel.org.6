Return-Path: <linux-kernel+bounces-228004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC46491599E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 00:12:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A9BC1F21783
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 22:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D6201A0B09;
	Mon, 24 Jun 2024 22:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3okE+k5H"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401611A01B4
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 22:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719267149; cv=none; b=bDTWD+hKK2RVScnMZzGGYNmh1wQUUfhBvbcyWOOHkvDQzwfdeGweKG/tc68R+phD7OZxQ3bfpxGBlK+6v8OlkGON7P/QCVZX+Gla8Wmy66iUQ8zNAHJg8nH+kjAH1ZMKQQtsoKiQHVsnfE1Fu0Eks1SLJ/Y2bdqAapLHzOWc+rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719267149; c=relaxed/simple;
	bh=V88kbQYMmksLo0hGgVvNJpR1yEr6VGpMad/TuUmx0Gk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=QNoTLb1I1DnubclQJyKsnv4JP85bcbUJ71euG4owW+Euiq9Jw6xZW4TvOPY9hfKevT1GZU5L+1AhjR8nLuQhZ88NOVz1MKJ/BlLiIfp5O+GxS+FYPGRR7waV86Wts2mep0ZNlAyuA6oKNuJgUeEWIlJtAFX9gc1EB7Yp0Y9E53c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3okE+k5H; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ipylypiv.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-631b498f981so85450117b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719267147; x=1719871947; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=TL/yt1aeykxZxZD2zlQYwkIf/JVQR0dKRLPmP/BJTrE=;
        b=3okE+k5HpseRB3Jn204qhQCa9l+4Uw8/ZQiGIWCRTvH6KwdYxyKZYDlkcrqxd/2ICn
         GsYfGURVoRbTcNxMdHglZuegXGsna64SAMYlc8PFphZucKYzG/iqMEfev8hC1hlGy/oz
         0WstlA42fT4iKDQl8DnvDVxBw852/kdd5RZKpdMju6Hfp5Ac57+NhglqQvBxVvRjebGF
         RqYD8ZFNAdbxM+Ii20YqUGmI74e38A4H7fA46oU2TCd4Z4BPllaCAbFG0pltGvP0Md/b
         NWIWsAMsNl0ZBiAldwohS/6wKPI6c6UVEd76P4DiaX9DFVClZgz2gxfJRiyzEpdK7nL9
         ODHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719267147; x=1719871947;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TL/yt1aeykxZxZD2zlQYwkIf/JVQR0dKRLPmP/BJTrE=;
        b=qS+3hAxOpoUdX8ku0suCj4juIuwXnIu23xZgfDOJOwmBScXpTmZ5M4j5uPYCebRhVk
         8dmBIOeI1sinl3XJV+Vetu+9PDvGG0HluKlNXtpVlR+Vb4w0SG0SrdgTspb1vDYKL0HS
         WJJ4TXDqvzxtKHhRrPBbt6eO796D2gq6XY2GvmQOeLZgMtNFb6jqVpR91L0dFAGp95Qw
         61R+8S+HkTOHGnrc40rfw4hvabuI1pAJHMH9qu7Ptdr5+rN7b8Smw+tssW6MpIpgldVy
         WZ1lvb8YmiL6IAYch0BGCWC6EHsOlYb2TbdRI/nmhFSfkxMhqBl/SXEUei8eNOYBMHBw
         nL7A==
X-Forwarded-Encrypted: i=1; AJvYcCWhyh0BmmPIM9eZyLqNjtiu1CImHqw86ZahbjUv/KqAAOh1h3p9En0Pvi+r+EyDRH8J3qztolGfFxsPazKBzoJMIrX4hf6Rw2oj1T7F
X-Gm-Message-State: AOJu0YyOmjL/k/xxpfcr19xaZK+hXs80VRU8HGfMy/hAYrNsB6MVZ+n6
	dq71yajmuhnhj/XSP2pFrTpc5TSpZTioYpuEDnR4qnS/XIQfP+nyD8a/99ompuOcbAFP7gFgDO4
	lWJB2XTvTCQ==
X-Google-Smtp-Source: AGHT+IGlHRclBh4I8qdw95Zucf/j3km06XZvKd5bHZ5qYEohmfuPkKF/QDVdh2oto2O1iYTdnDAvlgr3u83Ixw==
X-Received: from ip.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:57f3])
 (user=ipylypiv job=sendgmr) by 2002:a05:6902:1242:b0:df4:920f:3192 with SMTP
 id 3f1490d57ef6-e0301031c99mr14887276.8.1719267147153; Mon, 24 Jun 2024
 15:12:27 -0700 (PDT)
Date: Mon, 24 Jun 2024 22:12:04 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.741.gdbec12cfda-goog
Message-ID: <20240624221211.2593736-1-ipylypiv@google.com>
Subject: [PATCH v2 0/6] ATA PASS-THROUGH sense data fixes
From: Igor Pylypiv <ipylypiv@google.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Tejun Heo <tj@kernel.org>, Hannes Reinecke <hare@suse.de>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Jason Yan <yanaijie@huawei.com>, 
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Igor Pylypiv <ipylypiv@google.com>
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

Igor Pylypiv (6):
  ata: libata-scsi: Do not overwrite valid sense data when CK_COND=1
  ata: libata-scsi: Fix offsets for the fixed format sense data
  ata: libata-scsi: Remove redundant sense_buffer memsets
  ata: libata-scsi: Do not pass ATA device id to ata_to_sense_error()
  ata: libata: Set ATA_QCFLAG_RTF_FILLED in fill_result_tf()
  ata: libata-scsi: Check ATA_QCFLAG_RTF_FILLED before using result_tf

 drivers/ata/libahci.c     |  10 ---
 drivers/ata/libata-core.c |   8 ++
 drivers/ata/libata-scsi.c | 179 +++++++++++++++++++++-----------------
 3 files changed, 107 insertions(+), 90 deletions(-)

-- 
2.45.2.741.gdbec12cfda-goog


