Return-Path: <linux-kernel+bounces-208694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7E18902833
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 20:03:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5A3C1C230C7
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:03:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 868A31482F6;
	Mon, 10 Jun 2024 18:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dV4Md0EM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4591C1DFFB
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 18:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718042609; cv=none; b=kMBdmcBPcJ3XcBcton+to3zDlH/wDGjmWZwYkIbxMdWKejPHJmJTvRbbT2FemI6euEPGBYUot496RtJqmAt631xphDXB4smMgyhZFep249cy6Mx+YZuDYUxWvZyVb7B4HdRHgZ8qebc/Gb97aYePF1unJN30l/9Lf/30Fpb2eDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718042609; c=relaxed/simple;
	bh=BUjM1t3PIXAC6Ytd/MmTqu6Vsv+XYZQHt79/aOU6bkk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jChUSaUZGDsvwkFET2aJZp5mZBzjIYR5txnWWmXXksDAiAvnn3szNoDoPSS3qLcWA5nU+Dab5f1OHrtwooC5hBdMXa0jEc/jiba6AbzABpRDEDIVyzhHDL7BFOGpoS5lYNYcOJnUTsoGzeew3rPJPqk11pfzuP95Z0iTsr2zu3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dV4Md0EM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718042607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=lBAdoXrWxfngAOXeETgZ/9eMi7EOVwujj0O8BRZDoD0=;
	b=dV4Md0EMh7UMKPFw1kvJgS2TKQjmyOTk7t5jzI8j+C2l8HSmCzWjbL0uEPBhqfCU07E8Qy
	/N4vzyySp23Sx0G7vdQ/Q5z/eeOc22W1ZtkcWf5lT334DFSvYvfs0l6POH4y3JoruwJPak
	wP6cgD3s0lFLzXgEVThw5jsOBZ2YSnM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-O30dpRvnNhyxaEtaTo97TA-1; Mon, 10 Jun 2024 14:03:25 -0400
X-MC-Unique: O30dpRvnNhyxaEtaTo97TA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-35f1f958b7dso168260f8f.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 11:03:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718042604; x=1718647404;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lBAdoXrWxfngAOXeETgZ/9eMi7EOVwujj0O8BRZDoD0=;
        b=ALcs8IGXgQnn9+Q2vEKDDwX4p2MInn3OL+2npaLhG+4xkCrJJ6uzd2ADyU+EI1aU0/
         3afiKorfAPRpOwCnZUAYaH/SPu/EWZBvbOjw+uVM0VCYyJ0pcVHNUMGna+xh2gR2hL9Z
         DgMpMQ1hYnJ7nKEU+itDol9diXnrr17K91wTQQXvM85Egt7p2cV62pEAbKI9AdC6upUe
         08NeHKhvjRA56iIgxTSNSp4q2Sbc0YHHju+8q+pf7abjtYZBd0wmR2hNAbzzrqtG4DVd
         b7ZweP3Qq/siOvprdXdqlIUpsCMf9rvAdVMOajOFBUy6shbtLT2fWUkLYaNyEjq1CAA8
         GAHw==
X-Forwarded-Encrypted: i=1; AJvYcCXLxZ/21C9xTUoNUYTFRFt8yPn9e1a4MoSQb0O6VZgarvSMhRGBD15XDge4nF1EzLTHh5MAft+s+9/fgudHjlDzK9JceO6a6JCfZ0S6
X-Gm-Message-State: AOJu0Yw3EvDqoJ2AuESQaaJoGofw/U+492ZN3Nx6rO+KiSnQQc7W4/Hn
	GxkfusfObS76aUOzNBrkjrnWgDaIsjS9nnULLqZVgYbI5cCatCLNhP+vCUDsQn9oQbnSThCNW5R
	e9Bo/TAn5/vC3/SXAk/MTKL6Mw/qz0bDJ/JEq6Cp0nH+PpDAMBxbSi+tlkg7Ycg==
X-Received: by 2002:a5d:6305:0:b0:35f:1c26:b68d with SMTP id ffacd0b85a97d-35f1c26b7d4mr4334326f8f.60.1718042604301;
        Mon, 10 Jun 2024 11:03:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6fttIySqaLlAtrmoTpFqX0+ZaGQTLMt4MDrm2NDweITHX9K6XyLSqHw5pHedfj/9Hbj+mrA==
X-Received: by 2002:a5d:6305:0:b0:35f:1c26:b68d with SMTP id ffacd0b85a97d-35f1c26b7d4mr4334305f8f.60.1718042603941;
        Mon, 10 Jun 2024 11:03:23 -0700 (PDT)
Received: from cassiopeiae.. ([2a02:810d:4b3f:ee94:642:1aff:fe31:a19f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-35f0ccc5f03sm8384464f8f.88.2024.06.10.11.03.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jun 2024 11:03:22 -0700 (PDT)
From: Danilo Krummrich <dakr@redhat.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	mcgrof@kernel.org,
	russell.h.weight@intel.com,
	ojeda@kernel.org,
	alex.gaynor@gmail.com,
	wedsonaf@gmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	benno.lossin@proton.me,
	a.hindborg@samsung.com,
	aliceryhl@google.com,
	airlied@gmail.com,
	fujita.tomonori@gmail.com,
	pstanner@redhat.com,
	ajanulgu@redhat.com,
	lyude@redhat.com
Cc: rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danilo Krummrich <dakr@redhat.com>
Subject: [PATCH v2 0/2] Rust abstractions for Device & Firmware
Date: Mon, 10 Jun 2024 20:02:26 +0200
Message-ID: <20240610180318.72152-1-dakr@redhat.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

as agreed in [1] this is the separate series for the device and firmware
abstractions to unblock the inclusion of Fujita's PHY driver.

Originally, those patches were part of the patch series [2][3].

Changes in v2
=============
- use the 'srctree/' notation
- expand the existing documentation and make it more unambiguous
- use `NonNull` in `Firmware`
- generalize the `Firmware` request functions
- add missing safety comments to `Firmware`

[1] https://lore.kernel.org/rust-for-linux/2024060745-palatable-dragging-32d1@gregkh/
[2] https://lore.kernel.org/rust-for-linux/20240520172554.182094-1-dakr@redhat.com/
[3] https://lore.kernel.org/rust-for-linux/20240520172059.181256-1-dakr@redhat.com/

Danilo Krummrich (2):
  rust: add abstraction for struct device
  rust: add firmware abstractions

 rust/bindings/bindings_helper.h |   1 +
 rust/helpers.c                  |   1 +
 rust/kernel/device.rs           |  97 +++++++++++++++++++++++++++++
 rust/kernel/firmware.rs         | 107 ++++++++++++++++++++++++++++++++
 rust/kernel/lib.rs              |   2 +
 5 files changed, 208 insertions(+)
 create mode 100644 rust/kernel/device.rs
 create mode 100644 rust/kernel/firmware.rs


base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
-- 
2.45.1


