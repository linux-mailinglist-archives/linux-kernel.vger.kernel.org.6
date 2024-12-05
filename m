Return-Path: <linux-kernel+bounces-432640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E259C9E4E0F
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 08:18:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F814188178B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Dec 2024 07:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B128B19342E;
	Thu,  5 Dec 2024 07:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="YGbYOF56"
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868081B0F07
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 07:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733383066; cv=none; b=QrjGgPk3EzmzZh1vwHZ3gilbTzVmIKZGUfcDBo5nn26oN+y0XxjW7LA2E5mKOBQilNxrNiIep/psgT/YgZQKQuS3kF0mjculv5cgQm4LkBkJXBAh/flBE6w2Hsw2AycfgH5JewL4TJ0/EdWSYpfa+Uy8yLrGjALAe90w276EgLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733383066; c=relaxed/simple;
	bh=9huMapLYdP4ATt33V2+e5WuMOrvdBacuNolBNR08zgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ce1W/49GVzkFqVyMRWQcLs/2V2WyRCtwPxM8pXFeZbJhfVnHkqC9dzudG8Sw60R8J3Q89LmB2SbMYKIwr6+xwKi+ByRT1GmngUphS1CL29Fmz+7y0seEkbCP8NRhOH2wTeoF2rryoPO2kVnZctlvMT0AzRr/G7RWowcoMJsXePU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=YGbYOF56; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 9F3AE3F857
	for <linux-kernel@vger.kernel.org>; Thu,  5 Dec 2024 07:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1733383054;
	bh=/RIS0nHnkl4g4MTcoFHMie3N4MZuSB1tDmETrtj2Fj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=YGbYOF56k13LZLAe52Awd6a2qxTc3MP18K8Ie13sjaLnbfLopA5JkZlXyzCJMbRvP
	 5XvsgfR0xc+e4wYxw21+RRgLBH59Bbo4uWDJAL0EPQum6XnNbu4ysOwuRAbx5DA1aq
	 wRGy4CTzlE0DdNfwSfJGF5EUxTqmmhr7kff1+JxOlDR1Ww657FweTji8uxvhSN2XYG
	 jpeWVtK6Dwnc557FestOsF//fGtvh8vFHXbg65uJpOTYVf5wF3k2l6/bb0yVLxxi/m
	 Ca6tmkSqddeET3uoVuWufoYdY61Ekm7HVrKXucFitDq9mpDMJeXI9vpdeEMIFhB+3U
	 hesndba5ntNsA==
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-7c6b192a39bso464483a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 23:17:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733383053; x=1733987853;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/RIS0nHnkl4g4MTcoFHMie3N4MZuSB1tDmETrtj2Fj8=;
        b=nYR094N2GsPTNzBI35JOHZKemxirQI/himS1mSvNyVfV3izusX3CGpAIjcYTq3RpFr
         T8E7RFSitlHu2PWU2dJgH3u2xD4fqyE0pDGZm/zo1zeNBbEwilVMB65Na8260rhGl/UZ
         kMBL5SgRGzC8NmdTWXDcOYRpAF5vqatMjfvQ5IOP54LQjYWVLRtH+hbr7BDxoz09UO52
         dE2+d2PgzsS6gPgHJ+Jtpj+IwQLonMZiNUAinxWerYjCZRHX0Ik0ETpJ49i2dPRIKWu0
         m5i7Yqfelw3fIrzwftXKDNopNjYikuiFx61KtaQQs1nP9o9irM5D3Y8OxRMrmz25Baxx
         WATQ==
X-Forwarded-Encrypted: i=1; AJvYcCVRjVOFqsUgAyHtj1LK+fLVb1qOpEy4gHWwtqaNS78LZstZ0jmdxK/SRlkLqx5UupGqZH9n5TRljlKYHbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFWnIh6gpsiYMIFQGpbkw5sLdDA4nvI7GL/Sy97osTLD1Nvb/Z
	tzX4lnPYVp53tC1yr5ujzN8ORMBb8VFieNqTxXDj1Limoam32QLNqNmrBGrNgEeI0QyNvkIE56x
	mUFws0i5lx8Pj5YO767Xd6RG6zkH+QMhzTT/Pd+pKKEm7GJCb8QMDHfJ1CVsqcyey8QqIMnL5hb
	Jj8A==
X-Gm-Gg: ASbGncuHY01zgseH4Pb8WOOu+h0i6YFKCBYdoLdpIJnrvBalkm54e4myk3Uc5EXhU8Y
	wIZRVZE6zbMb4k9YwzyqZnylFe4zcRyHMu06Xyz/qqdO6M8dP2FqgEAoZQe3IQ8MyaxS+54ExTO
	nBxeXZOeAYX/gmUWP5quAoq7+BJx1KQIZyktecv/KlyOUEuBOUxfI8yGPXSzL3ECuRm7CNvvfyR
	VXilpMc6QIx/jzAhUOwvs0vYOUpbPvWdHFNnoD7XqRWLW3iD2pMuruEgkPK516OtoekfuyfRC8+
	SO6Fc8/0YX40K1hIv9Af4VaVotP/1hKjeiIIZwBNiCRkcNzd7Fjc
X-Received: by 2002:a05:6a21:118e:b0:1e0:d380:fe71 with SMTP id adf61e73a8af0-1e16533435fmr15688804637.0.1733383053251;
        Wed, 04 Dec 2024 23:17:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEGjhvekHo3vTsU0CH7fUBu54sWUP62KnHSZbe471psELyNS6NOWZGRPH6aKI4mwGvu/37iTQ==
X-Received: by 2002:a05:6a21:118e:b0:1e0:d380:fe71 with SMTP id adf61e73a8af0-1e16533435fmr15688780637.0.1733383052937;
        Wed, 04 Dec 2024 23:17:32 -0800 (PST)
Received: from rickywu0421-ThinkPad-X1-Carbon-Gen-11.. (118-163-61-247.hinet-ip.hinet.net. [118.163.61.247])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fd156fb8fcsm573909a12.40.2024.12.04.23.17.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 23:17:32 -0800 (PST)
From: En-Wei Wu <en-wei.wu@canonical.com>
To: marcel@holtmann.org,
	luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pmenzel@molgen.mpg.de
Cc: quic_tjiang@quicinc.com,
	kuan-ying.lee@canonical.com,
	anthony.wong@canonical.com
Subject: [PATCH v3 0/2] Bluetooth: btusb: Fix QCA dump packet handling and improve SKB safety
Date: Thu,  5 Dec 2024 15:17:25 +0800
Message-ID: <20241205071727.36710-1-en-wei.wu@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series fixes a NULL pointer dereference in the QCA firmware dump
handling and improves the safety of SKB buffer handling. The problem occurs
when processing firmware crash dumps from WCN7851/WCN6855 Bluetooth
controllers, where incorrect return value handling leads to premature SKB
freeing and subsequent NULL pointer dereference.

The series is split into two parts:
- Patch 1 fixes the NULL pointer dereference by correcting return value
  handling and splits dump packet detection into separate ACL and event
  functions
- Patch 2 improves SKB safety by using proper buffer access methods and
  adding state restoration on error paths

Changes in v3:
- Use skb_pull_data() for safe packet header access
- Split dump packet detection into separate ACL and event helpers

Changes in v2:
- Fixed typo in the title
- Re-flowed commit message line to fit 72 characters
- Added blank line before btusb_recv_acl_qca()

En-Wei Wu (2):
  Bluetooth: btusb: avoid NULL pointer dereference in skb_dequeue()
  Bluetooth: btusb: Improve SKB safety in QCA dump packet handling

 drivers/bluetooth/btusb.c | 120 +++++++++++++++++++++++---------------
 1 file changed, 74 insertions(+), 46 deletions(-)

-- 
2.43.0


