Return-Path: <linux-kernel+bounces-434097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B47EE9E6197
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 01:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B82F168536
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 00:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B64F23A9;
	Fri,  6 Dec 2024 00:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="A5fVe0fF"
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949A2819
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733443470; cv=none; b=B45i5+JtNYHgYgJH8B3cZ+exoIyvOsE+Z5+R3qb9cErEaFa0vnRAp9+tS5RJcO8g/BF5dIUcG3y89MqZXRSIXlQJ5MYKrucqiWEyFRT/uH8t+6S/XwXVxKxlQAq6ZdwHrtIVpBsuDwuP4yO5lrSTuYxlC6dXPZ4Ohf2jWxsWYps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733443470; c=relaxed/simple;
	bh=zRvtSc5/ce4hxl6/ZsAoCNHhptr59b1tfvlYN4KdCgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lcm7ptdvuD645wu2mEDAKTb1EZC5DSxvND3dFsH7nzTF807rjMXdWOtC0Gneehauh67Y03Yar6jAEJcdKx0rnHPmaGLPuSjW7U5lL6GYO0jSFJWYdr1EP3Kc6YhnC7BBi5NIavxInuLUnXpdQDyZxP8OXirDoexDhPJ7sXwhW34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=A5fVe0fF; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1EEA03F29E
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 00:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733443464;
	bh=mIiIum7pPdFGasU9OOkaWNga8UaMofa334rqkxQw19A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=A5fVe0fFhCdvRY0xyq6Pu4vSdHkunX6sJLW1orNyv6VPVFyoAsVtTZjv/ik0fGAfj
	 oWaE8enJ07Sa5ZU3HbJnsQsVWStPMD9wv0nyK1OB+eaZJke1SD7+QFX/LqO8/LV4Kd
	 z+Dl/wP7D0nvKqOK04Oyu6oc+uZPb2QIMljxhai4DSJR1+xHBfzFetwNQZIpa9+iQ3
	 VJa2cnGN8tR+h66VUeguzBSBGI4I4rn5BTm1XOL1MMt3Lr9wbfXfp8BXJAB2s8TIuT
	 U3Dku1tAbdFYcuEjP5vyQro7FZVknZMD35tW5Bev/cfkMbaVyrdCmaEoIul4gr99vB
	 MYOC5bCiUfX/A==
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-46720a5dde3so46544151cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 16:04:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733443459; x=1734048259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mIiIum7pPdFGasU9OOkaWNga8UaMofa334rqkxQw19A=;
        b=DtMjAznpA9cuEHI5pRET1TxK7TN2y+aUhQ4VQbhlIHhQJeiqLrwDPZdr6CqYsfSEs0
         ol9mgzqZFQcrdZemOmoV+rTSrgYlb1LRU0wbt59eZuz0uDXX3SISqxRA7tH91I2PtUTf
         T0zVOLqGS/mb2HIBhqM75uhtC7qLR1AK6p4BUpSM2iyV6dY0ezLwf3SbVlbCCldJOISA
         xhSI2odGVF0XCfIXxo1xeDeo4zKk3CSiBuSSl9amXQzPVxflW+54pwmDgYsQG78dADPx
         l50HnbOFQTF3bH18IGO3svxMMV4dpssoyZ5tFuW9MMl2R0yx0DH+y6eywEKcj/pnckMC
         f4Fg==
X-Forwarded-Encrypted: i=1; AJvYcCWSQ/YeQOfNR7+5TS3d/ELxDm9ujeauSABwHKA4fjI4R4tZmSDF+gPmoUVsj/Xp1KVdLvi1Oe6RK3ctTWA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Q0eqxaIb4LqTHxPAejl7VWQb7Sevono1+IE/kPCltqeos+38
	5TVTM+9zU1/KYr6/9ookYxK20IhKA+ZxPBqLI4TdHLrXxV8pLbYX/pkahL8qE17I3ySkWn5N3pA
	63Q8V6zgJUwv1gRYtwhnf7+XaqID3LUO57SvJYmTTmdABtAeu7vlt2qWcZytVqcE3MwoZuoliwt
	oV1plXou5cwQ==
X-Gm-Gg: ASbGncv8zN4XcfWOotDIHgpbIVUjSCSf5LIBdItrYu4TBFTrnIJ5llCNBkhnhB4i8Cn
	IMLkq+TuAI4qvXOv6ZOJQxLbJxc1lgIKJZykRdPkh8q+gKlLYQ3nvwy3E1o9qpttShnOKj6FAbb
	xMDBT+urxGwc2QEcu0CPSQQFo/WpenM+R4Xw1fT4KtFdz7snaP+2jMNRZ4mxSPHKMyEmfXTgsTu
	0IL3gSS5zJttQiVBzijsbYKCAonGLdag7NaBbrCbhcM92dGjxWvIXD1C/P+ZfsOdonY0GZCcQ==
X-Received: by 2002:a05:6214:1d04:b0:6d8:8667:c6c2 with SMTP id 6a1803df08f44-6d8e7114d40mr20190606d6.18.1733443459632;
        Thu, 05 Dec 2024 16:04:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHG1DvOFWRMwAjXMaAXd+NNAPJkHm1GvcnsdEKgct3OO0pnxOyiMiLQB4iA99PxpPs7sDJPoQ==
X-Received: by 2002:a05:6214:1d04:b0:6d8:8667:c6c2 with SMTP id 6a1803df08f44-6d8e7114d40mr20190286d6.18.1733443459313;
        Thu, 05 Dec 2024 16:04:19 -0800 (PST)
Received: from localhost (sub55115.htc.net. [65.87.55.115])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d8da696e7csm12161576d6.47.2024.12.05.16.04.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Dec 2024 16:04:18 -0800 (PST)
From: Mitchell Augustin <mitchell.augustin@canonical.com>
To: bhelgaas@google.com,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: mitchell.augustin@canonical.com,
	alex.williamson@redhat.com
Subject: [PATCH 0/1] PCI: Add decode disable/enable to device level and separate BAR info logging into separate function
Date: Thu,  5 Dec 2024 18:03:50 -0600
Message-ID: <20241206000351.884656-1-mitchell.augustin@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a virtualized environment with PCI devices passed-through,
disabling and enabling decoding is not trivial, and in some
configurations can take up to 2 seconds of wall clock time to
complete. Since this operation could be done once around each
device for devices with multiple BARs (reducing redundancy),
add an additional decode disable/enable mask at the device
level to prevent redundant disable/enables from occurring
during each BAR sizing operation, when pci_read_bases() is
the originator.

Since __pci_read_base() can also be called independently,
keep the current disable/enable mask in that function as-is.

Since printk cannot be used while decoding is disabled,
move the debug prints in __pci_read_base() to
a separate function, __pci_print_bar_status().
To enable this, add pointers to the signature for
__pci_read_base() through which the caller can access
necessary data from __pci_read_base() and pass it to
__pci_print_bar_status().

This has been tested on an SR670v2 host and guest VM,
a DGX H100 host and guest VM, and a DGX A100 host and guest
VM. I confirmed that BAR info logged to dmesg was consistent
on each between unmodified 6.12.1 and with this patch, that
BAR mappings in /proc/iomem were consistent between
versions, and that lspci -vv results were consistent
between versions. On the A100/H100, I also confirmed that the
Nvidia driver loads as expected with the patch, and that
VM boot time with cold-plugged, passed-through GPUs is about
2x faster. No regressions were observed.

Originally developed/tested against upstream 6.12.1, but
I also confirmed that this applies cleanly to the pci tree
@ v6.13-rc1 and that it results in the same boot speed
decrease there when tested in an H100 guest VM.

Link: https://lore.kernel.org/all/CAHTA-uYp07FgM6T1OZQKqAdSA5JrZo0ReNEyZgQZub4mDRrV5w@mail.gmail.com/
Reported-by: "Mitchell Augustin" <mitchell.augustin@canonical.com>
Closes: https://lore.kernel.org/all/CAHTA-uYp07FgM6T1OZQKqAdSA5JrZo0ReNEyZgQZub4mDRrV5w@mail.gmail.com/

Mitchell Augustin (1):
  PCI: Add decode disable/enable to device level and separate BAR info
    logging into separate function

 drivers/pci/iov.c   |  16 ++++-
 drivers/pci/pci.h   |   7 ++-
 drivers/pci/probe.c | 149 +++++++++++++++++++++++++++++++++++++++++---
 3 files changed, 158 insertions(+), 14 deletions(-)
---
base-commit: d390303b28dabbb91b2d32016a4f72da478733b9 

--
2.43.0


