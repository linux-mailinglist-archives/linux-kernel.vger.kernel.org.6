Return-Path: <linux-kernel+bounces-449593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EC05A9F512E
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 17:37:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37E71188B595
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 16:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65BA21F7558;
	Tue, 17 Dec 2024 16:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="YkvrTB0a"
Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F245014AD29
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 16:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734453442; cv=none; b=Z4FkSGtiq69jFT/+ItZvTuyIS9/Ro8nuScAJkR5WXqXqg6s0tVS5/n6KnFLi9y4c/D7PR3qZyij2jaB+6Mam8xMb4vjkxxvWeJ52aC6ZTY8j4gY/h8muM7hiCsk+cTNBKxX7HTPvB6CTmMxak5u4YCSaw7kD2vokVnAfpMwduwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734453442; c=relaxed/simple;
	bh=1ATu9wgaYAQKhmswVhuoVZ2QLTUdUkiXPcR6R4v8PvA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=L/FPcXf4knjcMMq/TTVy+J3/QmWAqMPPNHn7Y72uGYIcJ9obVXIj/t6rc3qLUgti7bK3oMSD3kOW8QxLCS0SN5Uu1dQGn9frkvW1EzcrA/on0WRVKZxU4pGPh9NnpOzp62hNualFG9WXFT9G2LeDDk9R8EYmLaPLAb9Cr9UiGpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=YkvrTB0a; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3a8aed87a0dso18953495ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 08:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1734453440; x=1735058240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLXAYiyU1iqMID7+HfNyBZxwgcF9EMYHiTYuuHxkZvc=;
        b=YkvrTB0aNwKvR4xRlDpztlOMbeGYbo4Ym1ToMR0mUwdkDj9J59eG6lLIA1luzDT1tB
         Z5GvUBO1asaMNLI0vh6XMq1oB4V3MfCWBl/JHIYoclfd+hNwEc42Rdgt3mXOMwUuCX8p
         tcBlcLxeNkR/iMJHOTsg1OMzMJoXJwFVVKKstenMMcC9lnXvKFNoN9VgWtXaemj0AF+a
         vTx/aA/pm+I4h7s9Rbw8T0mbO47cPcDl162FZsDTchFamGnzW2OWUeMtxLq32eb0xIa+
         7i58HBGU0nE0yB0+R7qBns6wt3VAQldTcQL2mJ7HitNLPcK65E5mSmkcazdPuJtJUjB6
         FN5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734453440; x=1735058240;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLXAYiyU1iqMID7+HfNyBZxwgcF9EMYHiTYuuHxkZvc=;
        b=p0khNC1Blqto39Kjtj6AistV5nlv3G2m9jdk4YNMRVTAI6y8vNno1DS8VwwrrKDhdq
         D2Qtvt7OleDdwWHCPJfyDy06Rl7ZClA11x2vH4UjrQjChLuIQZ/zDGiPVslc7Q4J0+TH
         PFMZyX5ITvwlLBgiyTzBlt+1PhnoApsgVSdfx1O9606ciq2hVDcBBByGLE4qZp/suCuE
         bnsQqSilSC0afR4cbcfqA+4Wz6HwH8w/w3SjzXKcJ7PH5RjYa68h8u3M9qXYsbS0hVpI
         cbY2xi85jjMhVgrnqcK4ctlkoSvUezEnnm6/Ol6d8b1qP9/AyuOIkuI1M6wjpnfvvVkx
         3S+A==
X-Forwarded-Encrypted: i=1; AJvYcCXOSkr/ppZBgd363TrZpJJiwMVvAMkxce0aBluQX/MtZRtvt00jlcgkYg3UEthMVpyhMu6fcLFdlxK4Wjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzDB849QysBTG3CHoYc9OmIblHMwexWvUvvZ+lUfGDLeEicMj2U
	91+juvS2vl8/JOlEHJfhsjSVS7Q/t5MEMbhXopV/jbhSkx30w2Ah62V/behwaJo=
X-Gm-Gg: ASbGncsQJeQ/r5RrW1485gFnU0RKW0TslR4Ti6Ukkjy+QZOtn58tD+749Paetmj1Sc8
	0N5gH6gBzkTArSSbE2OIKH3lfbabFaWKb1+L96BTFe5jMiekuJPhLkRkaGsJH2QW+vSRgikyDVH
	4Z1TQBVbDJX0hQ+zb7IQV0OCbLYclw7OsTAZeJKysSzjoD0Kg8yeNCJmLEFFcTTUZQXjscIT1u4
	y/GJlBjBWGn87WtQE3dBtlnp0greuo1CuO8w4J8h1/J/Y0=
X-Google-Smtp-Source: AGHT+IE/HVlmxcalHVFA9B+15PGcwD/7VUAayQaHnmJ8VTv9HsAtDcrPfDzLFsYJKWRCm33fWsrd4w==
X-Received: by 2002:a05:6e02:1d11:b0:3a7:708b:da28 with SMTP id e9e14a558f8ab-3bd8b195aa9mr912455ab.21.1734453440010;
        Tue, 17 Dec 2024 08:37:20 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-4e5e0a3de5esm1774339173.51.2024.12.17.08.37.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Dec 2024 08:37:19 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, John Garry <john.g.garry@oracle.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>, 
 Daniel Wagner <wagi@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, 
 storagedev@microchip.com, linux-nvme@lists.infradead.org
In-Reply-To: <20241202-refactor-blk-affinity-helpers-v6-0-27211e9c2cd5@kernel.org>
References: <20241202-refactor-blk-affinity-helpers-v6-0-27211e9c2cd5@kernel.org>
Subject: Re: [PATCH v6 0/8] blk: refactor queue affinity helpers
Message-Id: <173445343855.487134.18283101203931240403.b4-ty@kernel.dk>
Date: Tue, 17 Dec 2024 09:37:18 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3-dev-86319


On Mon, 02 Dec 2024 15:00:08 +0100, Daniel Wagner wrote:
> I've rebased and retested the series on top of for-6.14/block and updated
> the docummentation as requested by John.
> 
> Original cover letter:
> 
> These patches were part of 'honor isolcpus configuration' [1] series. To
> simplify the review process I decided to send this as separate series
> because I think it's a nice cleanup independent of the isolcpus feature.
> 
> [...]

Applied, thanks!

[1/8] driver core: bus: add irq_get_affinity callback to bus_type
      commit: ccddd556cfba3db6cb4d45d9f7d30c075e34808b
[2/8] PCI: hookup irq_get_affinity callback
      commit: 86ae920136e7c6352e7239a459544b0eae57613a
[3/8] virtio: hookup irq_get_affinity callback
      commit: df0e932e866b5cfad8cedafa0123ab0072a665ce
[4/8] blk-mq: introduce blk_mq_map_hw_queues
      commit: 2b30fab613e2ef54ae4b3fbb238245a29ba2a285
[5/8] scsi: replace blk_mq_pci_map_queues with blk_mq_map_hw_queues
      commit: 7c72e20573d0d350c7c087289e7b7b605100651f
[6/8] nvme: replace blk_mq_pci_map_queues with blk_mq_map_hw_queues
      commit: f0d672680e0b383b14add766b57db60c4c4acf92
[7/8] virtio: blk/scsi: replace blk_mq_virtio_map_queues with blk_mq_map_hw_queues
      commit: 5a1c50296039ca32a22015bbb9696d6a96514947
[8/8] blk-mq: remove unused queue mapping helpers
      commit: 737371e839a368007758be329413b3f5ec9e7976

Best regards,
-- 
Jens Axboe




