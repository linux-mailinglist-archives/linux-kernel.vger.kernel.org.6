Return-Path: <linux-kernel+bounces-431829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A07B9E41D9
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:38:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3131286D9C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:38:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4951B1F03E7;
	Wed,  4 Dec 2024 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YThcI1Pn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4903D0D5
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332246; cv=none; b=dCIsJvbpfin6rpaqalC08X2AAUeesUXQrbMyQlT8ldoajoqxFtnHwY3oH5okUAEd0vAqNjt+RO+jLYP5xJExDiaRxnL+NYUHMoTxzUDSBfK9PiwTFiOb5Xpoc6PkGY8M8XK6mj/iWIhClwOgT3Yez92r6yLksTx2CAf7FqpiC9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332246; c=relaxed/simple;
	bh=gkEnIFPyAj18HlI4xFlGO+AhQTxO1FXBH3LxNu22s8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CaD30slMoBC/38WHvp4JzYw8yR2Je0VekfuygFMAm6WUZcNV02pZR8BTmaTILeO8Do/geSk4HrWlGi4lMOAg41Be37VpXfEnJio1ygypyhwekrUAhtRxv4WnT6HIs/g1gyyCJz3wYit+cuEC/KIMNTKGX1m6EWBEVc0LSGx4JAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YThcI1Pn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733332244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=k5/CqBabOzgKP5OCgCUiJ8LP1w3MtwNU5aNtjpSlwCo=;
	b=YThcI1PnlLcK5vqOXLvcYhWBFcGZSZiArDRbd0Yw0y38J1MrKBiew7Sc7lVIUCTBxyiTWN
	2IigU9UBHKJYXfEk4msjbboYekWVu3l4ajZ05Tuudl4OwoGLN3j4DHgkNrh4Nw3jyeJizL
	Q13jK8YzDIm8QbkfLWn+1wG7VHDIBGg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-687-l7asswtlPhKrD7lv1qP1jg-1; Wed, 04 Dec 2024 12:10:42 -0500
X-MC-Unique: l7asswtlPhKrD7lv1qP1jg-1
X-Mimecast-MFC-AGG-ID: l7asswtlPhKrD7lv1qP1jg
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385d52591d6so20533f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 09:10:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733332241; x=1733937041;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k5/CqBabOzgKP5OCgCUiJ8LP1w3MtwNU5aNtjpSlwCo=;
        b=JbhradtKG1aXNBqBzusSxTDphb4kuMslljdSzWtct4NB0pdj42wdd3cjINZe5vDXF5
         Q5LMPXmx0qsDcCRhWpHzKmwakVB2wxzpYVi/AaCoyfB6GelbN901kVZHN2aAdhhhMvdx
         qERy3HoVfVXpd03x0ehK5hskdz/L/3nBTHPI0OJbJ2z03jkWoMCjXBX1xUpHXv+VuB37
         fbQn72WNm6MADjDDgi1SelsevOmk0M9TC4xJ3ibWrkCT/F+TgUt/nyojefShyIZy/C+P
         uIpdhwoO+xrIeU+NDqG+ksqb1YMmqpGtiFjOj4hp+S9VJEEkBV3Kjpq+lu7SKxiYpgio
         YFkA==
X-Forwarded-Encrypted: i=1; AJvYcCUAAd7uIl2QK44nw6mW5ETUTZg2XPQLMKTrYQO/Ybb6J2CJ3QYLrh86NnX3LLBaBN+eOADOnmiTaT+H6Ko=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGn6Yl7lzbcn7Ddeg5LVHocA2meLO8n9g/AVTaAZGvCZlbEyRZ
	9lQeWOwvkTg8YPjbIU/zfh/XcHmP3aoPfkCnhSr3nOEHaHP/7/CqxuOxHKLgnK74LVVRLz3rq+T
	Dfwy3iMhhvA/3xkpLSC6yFXhWjeK4CoO8b/UdaExWjqOOd7Y+qbrkL6LvCjVwXQ==
X-Gm-Gg: ASbGncsElNe6HB+q480D0EQ71nW0rD1w2a4T0E3/zn0CAobrknJqQITBiXObCZryLoe
	WQ/bf+Ny+cbapNQy/HqQGHuPd0GzSQpA4nqMeug46icS6GNl2TncAFkkckBbPbZ7Vw3FKUL/IJL
	RWu9iSaRy0xzdvjXVHnHoruHagXsb4B5f86GDVadEi82jBma7vTNhC7qjjK2wf+cgYVUqftlcBt
	66iCFwPdrKv1VYV18oSyUE26vGYOmOuXv78wnxIuBS2hboQhJO5vDS9oGlPO8O6kB+Qg4B89SFN
	HWHi3E3q
X-Received: by 2002:a5d:47a1:0:b0:385:eeb9:a5d9 with SMTP id ffacd0b85a97d-3861bb4c757mr130352f8f.2.1733332241585;
        Wed, 04 Dec 2024 09:10:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE8h5IdGp8jQgne0vlx5CXDQ/AWZbEN4VvTpEdLEDpVWoj+5ul8SKKwg6TIXjbXydGxkFUvZA==
X-Received: by 2002:a5d:47a1:0:b0:385:eeb9:a5d9 with SMTP id ffacd0b85a97d-3861bb4c757mr130334f8f.2.1733332241215;
        Wed, 04 Dec 2024 09:10:41 -0800 (PST)
Received: from eisenberg.redhat.com (nat-pool-muc-u.redhat.com. [149.14.88.27])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3860bbba038sm2179511f8f.24.2024.12.04.09.10.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 09:10:40 -0800 (PST)
From: Philipp Stanner <pstanner@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Mikael Pettersson <mikpelinux@gmail.com>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [RFC PATCH 0/3] ATA: Replace deprecated PCI functions
Date: Wed,  4 Dec 2024 18:10:31 +0100
Message-ID: <20241204171033.86804-2-pstanner@redhat.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

many of you probably know that I'm trying to remove pcim_iomap_regions()
from the kernel. One of the more difficult users is ATA, because it's
the only subsystem I've seen so far that accesses that table
pcim_iomap_table() administrates.

This series only builds as a whole because of patch 1. That's why I
submit it as an RFC.

I want to know whether you agree with the basic idea, and whether your
subsystem wants this series to be squashed into a single commit that
builds.

Another solution would be to provide a struct ata_host.iomap2 or
something like that, phase out the pcim_iomap_regions() users, and then
remove iomap2 again.

Please tell me your preferred way.

(This is the revived version of an old series from August. In case
someone is wondering)

Thx,
P.

Philipp Stanner (3):
  ata: Allocate PCI iomap table statically
  ata: Replace deprecated PCI functions
  libata-sff: Simplify request of PCI resources

 drivers/ata/ata_piix.c      |   7 +-
 drivers/ata/libata-sff.c    | 130 +++++++++++++++++++++++-------------
 drivers/ata/pata_atp867x.c  |  13 ++--
 drivers/ata/pata_hpt3x3.c   |  10 +--
 drivers/ata/pata_ninja32.c  |  11 +--
 drivers/ata/pata_pdc2027x.c |  11 ++-
 drivers/ata/pata_sil680.c   |  12 ++--
 drivers/ata/pdc_adma.c      |   9 ++-
 drivers/ata/sata_inic162x.c |  10 ++-
 drivers/ata/sata_mv.c       |   9 +--
 drivers/ata/sata_nv.c       |   8 +--
 drivers/ata/sata_promise.c  |   8 ++-
 drivers/ata/sata_qstor.c    |   7 +-
 drivers/ata/sata_sil.c      |   8 ++-
 drivers/ata/sata_sil24.c    |  20 +++---
 drivers/ata/sata_sis.c      |   8 +--
 drivers/ata/sata_svw.c      |  10 +--
 drivers/ata/sata_sx4.c      |  19 +++++-
 drivers/ata/sata_via.c      |  31 +++++----
 drivers/ata/sata_vsc.c      |   8 ++-
 include/linux/libata.h      |   7 +-
 21 files changed, 216 insertions(+), 140 deletions(-)

-- 
2.47.0


