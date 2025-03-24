Return-Path: <linux-kernel+bounces-573516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86D1A6D888
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 11:47:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE7933A3EAC
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 10:46:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E1BB25DCE2;
	Mon, 24 Mar 2025 10:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L/bP3aXG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14039205E26
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 10:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742813223; cv=none; b=KQqkOH5EAQ9bJqL4g6p1HsEhqnAb4+l3g3YqccT2OllPVgQnbAVep3Rxb81DMDfG6OKSotIQikcRe2rZBLY0bnQYnrdoA3ozJxqgxT2RumH/a0XrM7nwS9JbuUb4zd8sGro3lFmO1AXA5PBzWDIb4xn9rmyAsPuA7rBuo59gg1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742813223; c=relaxed/simple;
	bh=4Mqx6j1jEgu3ftEu9pNFMxQ/rycz0f5ou4C4LnYwews=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=noqNw7cFf4rW8eFuotVTGZ9zRpJv0aEfujZqa9Hdl9ig6kN4F8qiiR7QKlnG1uMn63uAaYZ9aoIySLZ2ugZq+XrkgPnzrfap0MHEOW3v+fT3X9Pk5O/AiVZM/D2T1M3BHASf79r6XNxRgYx9rH4nVexfsGVkXEqT3Khm7EpeHG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L/bP3aXG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742813221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=gu+IHy3eWsxqSL7KQBKuMTqUX8nLvgcOBpryY3nmz5I=;
	b=L/bP3aXGDJmfW6mGsHSwdQbZr/KXlCUMMzKGm4MiN4wTzn7Q4iuW7MZ12eSmnpP3zZr1iZ
	F7VPZSMAYtvPAIKuJZLH2wvxPgFsvSESaQK5BjuT453dYoyKhdkbqB+d+GFW2Kd1JhygIn
	nCC0dlEloB24HQab50Slw8jWGVXgQTQ=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-HvVdvrJbP4Wgm50xXzPqVQ-1; Mon, 24 Mar 2025 06:46:59 -0400
X-MC-Unique: HvVdvrJbP4Wgm50xXzPqVQ-1
X-Mimecast-MFC-AGG-ID: HvVdvrJbP4Wgm50xXzPqVQ_1742813218
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-43935e09897so27010785e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 03:46:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742813218; x=1743418018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gu+IHy3eWsxqSL7KQBKuMTqUX8nLvgcOBpryY3nmz5I=;
        b=FChIBNHVtZHUeeJG+ThkU+MacL6gJ/w203tLTeNgF2Aykx6wrdj5ydy/Xjvf2TfYyG
         jVfmUdCwe7J7o8euBq2MI5x4A6w9LzKlvO+z7l05igEB8dybi+UoUM5MYO++tFOg8pdC
         3naQEtGj2/FXFQbSXXrM7oe7Dv94Kz4ApLX+HPENGYIlZpxoXZEg6hLm4dWPuEBHZ+Ti
         xXxQgRo9H8jTS48JyEiB14iXgdAvuaen61QIA5L3rwsu5OPRjUZDTMSc4f284qWhycaf
         sMngXek1Se3Kq2B0jmJXkXXE1w2LDW1ISTbXZPM4ql2Nq0fPuMfUJNKNWBpIqMZJQ7gV
         OUXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXzBQTCVjFR7geUSeNYGfzxl4vUVOzghcRgrzpLqJxPKsTGwWxWpE8MqnIDGkNdayrCalKFWnwTg62br2I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5thQ8d84bP/f+puxH5XBMSwOP91da2+rWkHDDBdq9SfVm3Lyz
	9LXgScvPv3M/12FFCfHu40dnYBXwS1WNPq3tSxQ7Lq2HoLNYLmUYBa+Se1SMiUn3b40+2KP6E/8
	cIW4bYf4ixLsJ8p/GlbiT37I87zXIzf39o1SiRwLxxv78DMe3HoieNdoWeKBAjw==
X-Gm-Gg: ASbGnctWHURYED3UUPC19OpabMnNdzX4Wb2xwJjWcvEfNCTy33f1RPtKgMe/HElloV6
	lluVFLs91A60Z9h1WZpyuXrRuVRezCJVYeWzM+aWbyWbAGZBDI5Sct+rB/rmf/DKs6qCZGa2AE6
	9w0dHRNH/vKN4Rx3A35v9zzh4HjlJlxUdhW2nqUHpnupiW3j4BRt+R8w7wyiEka75fxUtyGu6JB
	l37+BSkAzpgRWlem0Fc7B42GxxhFl5y6HZu62WVRF4nca2sP5OVDMIrkjPbs1xegcjcACElxgKX
	FpUWT1/705vaz9GuooPFQRKpFG9JYc8KWi3suvkSZOyh8fAe9EUAR3S2QH+aEqlm8g==
X-Received: by 2002:a05:600c:3c82:b0:43d:45a:8fbb with SMTP id 5b1f17b1804b1-43d50a1d1ebmr93437535e9.22.1742813218240;
        Mon, 24 Mar 2025 03:46:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGANQB3rvIgZOSWD0gaPpOgHDkFySb04GZTBXL6jb8c8aJd3br4jmx1zWOwoz7jHrhpRHPjag==
X-Received: by 2002:a05:600c:3c82:b0:43d:45a:8fbb with SMTP id 5b1f17b1804b1-43d50a1d1ebmr93437075e9.22.1742813217491;
        Mon, 24 Mar 2025 03:46:57 -0700 (PDT)
Received: from stex1.redhat.com (host-87-12-25-55.business.telecomitalia.it. [87.12.25.55])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3997f9e645bsm10678195f8f.67.2025.03.24.03.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Mar 2025 03:46:56 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Joerg Roedel <jroedel@suse.de>,
	Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Peter Huewe <peterhuewe@gmx.de>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	x86@kernel.org,
	James Bottomley <James.Bottomley@HansenPartnership.com>,
	linux-kernel@vger.kernel.org,
	Borislav Petkov <bp@alien8.de>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-coco@lists.linux.dev,
	Claudio Carvalho <cclaudio@linux.ibm.com>,
	Dov Murik <dovmurik@linux.ibm.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	linux-integrity@vger.kernel.org,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v4 0/4] Enlightened vTPM support for SVSM on SEV-SNP
Date: Mon, 24 Mar 2025 11:46:45 +0100
Message-ID: <20250324104653.138663-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.49.0
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AMD SEV-SNP defined a new mechanism for adding privileged levels (VMPLs)
in the context of a Confidential VM. These levels can be used to run the
guest OS at a lower privilege level than a Secure VM Service Module (SVSM).
In this way SVSM can be used to emulate those devices (such as TPM) that
cannot be delegated to an untrusted host.

The guest OS can talk to SVSM using a specific calling convention and
instructions (a kind of system call/hyper call) and request services such
as TPM emulation.

The main goal of this series is to add a driver for the vTPM defined by
the AMD SVSM spec [3]. The specification defines a protocol that a
SEV-SNP guest OS (running on VMPL >= 1) can use to discover and talk to
a vTPM emulated by the SVSM in the guest context, but at a more
privileged level (VMPL0).

This series is based on the RFC sent by James last year [1].
In the meantime, the patches have been maintained and tested in the
Coconut Linux fork [2] along with the work to support the vTPM
emulation in Coconut SVSM.

The first patch adds public APIs to use AMD SVSM vTPM. They use
SVSM_VTPM_QUERY call to probe for the vTPM device and SVSM_VTPM_CMD call
to execute vTPM operations as defined in the AMD SVSM spec [3].
The second patch adds an interface with helpers for the SVSM_VTPM_CMD calls
used by the vTPM protocol defined by the AMD SVSM spec and then used by the
third patch to implement the SVSM vTPM driver. The fourth patch simply
registers the platform device.

Since all SEV-SNP dependencies are now upstream, this series can be
applied directly to the Linus' tree.

These patches were tested in an AMD SEV-SNP guest running:
- a recent version of Coconut SVSM [4] containing an ephemeral vTPM
- a PoC [5] containing a stateful vTPM used for sealing/unsealing a LUKS key

Changelog:

v3 -> v4
- Added more documentation around public API [Jarkko]
- Simplified TPM_SEND_COMMAND check [Tom/Jarkko]
- Renamed header in tpm_svsm.h so it will fall under TPM DEVICE DRIVER
  section [Borislav, Jarkko]
- Fixed several comments to improve svsm_vtpm_ helpers and structures [Jarkko]
- Moved "asm" includes after the "linux" includes [Tom]
- Allocated buffer used in the driver separately [Tom/Jarkko/Jason]
- Explained better why we register tpm-svsm device anyway in the commit message

v2 RFC -> v3: https://lore.kernel.org/linux-integrity/20250311094225.35129-1-sgarzare@redhat.com/
- Removed send_recv() ops and followed the ftpm driver implementing .status,
  .req_complete_mask, .req_complete_val, etc. [Jarkko]
  As we agreed, I will send another series with that patch to continue the
  discussion along with the changes in this driver and ftpm driver.
- Renamed fill/parse functions [Tom]
- Renamed helpers header and prefix to make clear it's related to the
  SVSM vTPM protocol and not to the TCG TPM Simulator
- Slimmed down snp_svsm_vtpm_probe() [Borislav]
- Removed link to the spec because those URLs are unstable [Borislav]
- Removed features check and any print related [Tom]
- Squashed "x86/sev: add SVSM call macros for the vTPM protocol" patch
  with the next one [Borislav]

v1 -> v2 RFC: https://lore.kernel.org/linux-integrity/20250228170720.144739-1-sgarzare@redhat.com/
- Added send_recv() tpm_class_ops callback
- Removed the intermediate tpm_platform.ko driver
- Renamed tpm_platform.h to tpm_tcgsim.h and included some API to fill
  TPM_SEND_COMMAND requests and parse responses from a device emulated using
  the TCG Simulatore reference implementation
- Added public API in x86/sev usable to discover and talk with the SVSM vTPM
- Added the tpm-svsm platform driver in driver/char/tpm/
- Fixed some SVSM TPM related issues (resp_size as u32, don't fail on
  features !=0, s/VTPM/vTPM)

v0 RFC -> v1: https://lore.kernel.org/linux-integrity/20241210143423.101774-1-sgarzare@redhat.com/
- Used SVSM_VTPM_QUERY to probe the TPM as Tom Lendacky suggested
- Changed references/links to TCG TPM repo since in the last year MS
  donated the reference TPM implementation to the TCG.
- Addressed Dov Murik's comments:
  https://lore.kernel.org/all/f7d0bd07-ba1b-894e-5e39-15fb1817bc8b@linux.ibm.com/
- Added a new patch with SVSM call macros for the vTPM protocol, following
  what we already have for SVSM_CORE and SVSM_ATTEST
- Rebased on v6.13-rc2

Thanks,
Stefano

[1] https://lore.kernel.org/all/acb06bc7f329dfee21afa1b2ff080fe29b799021.camel@linux.ibm.com/
[2] https://github.com/coconut-svsm/linux/tree/svsm
[3] "Secure VM Service Module for SEV-SNP Guests"
    Publication # 58019 Revision: 1.00
    https://www.amd.com/content/dam/amd/en/documents/epyc-technical-docs/specifications/58019.pdf
[4] https://github.com/coconut-svsm/svsm/commit/6522c67e1e414f192a6f014b122ca8a1066e3bf5
[5] https://github.com/stefano-garzarella/snp-svsm-vtpm

Stefano Garzarella (4):
  x86/sev: add SVSM vTPM probe/send_command functions
  svsm: add header with SVSM_VTPM_CMD helpers
  tpm: add SNP SVSM vTPM driver
  x86/sev: register tpm-svsm platform device

 arch/x86/include/asm/sev.h  |   7 ++
 include/linux/tpm_svsm.h    | 149 ++++++++++++++++++++++++++++++++++
 arch/x86/coco/sev/core.c    |  67 ++++++++++++++++
 drivers/char/tpm/tpm_svsm.c | 155 ++++++++++++++++++++++++++++++++++++
 drivers/char/tpm/Kconfig    |  10 +++
 drivers/char/tpm/Makefile   |   1 +
 6 files changed, 389 insertions(+)
 create mode 100644 include/linux/tpm_svsm.h
 create mode 100644 drivers/char/tpm/tpm_svsm.c

-- 
2.49.0


