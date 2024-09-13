Return-Path: <linux-kernel+bounces-328989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 203F8978BC7
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 01:20:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE9A21F215BE
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 23:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89C3A14B061;
	Fri, 13 Sep 2024 23:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="NdW3Hzi9"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEAFBA2D
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 23:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726269644; cv=none; b=klDOxc+/p/KM4TgzfvAANEHqpfxsTuq3w5bz5oQjI6ql9ODFMIO3vGogCP8o5Ybs7B8f5Pmv1zu47FBSk5EBwnY6dwq2FySD1F3pMEj0uFXFDjRSzo110Hb2LG0ATZSAZ8A1d6vgGkN1k3etK6QGzKCcYJvEpYym4qkcDGpXcAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726269644; c=relaxed/simple;
	bh=EeRsW3l/bgx27sZwHgaQEJ/xtECgJGIfPbW9uZwGdhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gD97eeL8+Gj4wjiOo3YuVCNFh5j6p8lhlDQ8fxARQlWRfmNDpyfZ0Bey1DIbvDeOfmbPwn3dfLin19CuAr3AJlkvCpNzTFhZn76LgTF7+CNOEFf4hdSPmmbXvBVtbTaTJK0Sp0WAkc6vXqJ7R5IK9wFJWfjGxKlNcTNFV547WSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=NdW3Hzi9; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-458311b338eso22644501cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1726269641; x=1726874441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=B65GRKe+0vYbGgtddhBHaAOt9Gcud5s/LIbVtVdrK6I=;
        b=NdW3Hzi9U+VLC37W1aPoD7Z+hbbDhksb3JIQnupe1Th47C3DPk6rtxjpGcp5DYPUzG
         vgO5RMNw+QOJ9rdlpemugjq8RnDI1pyyzUmzjnHgs6uAQRwAjGm1ltEgmVqhN3hx1J27
         vwVyJe3ACjSjRp2MjaOc5dve9XYhy5AarM/em/wWUqI1SSYmzXh5PV3WlF0w7L/qeTi6
         XCBxBu9fHW92+Vz47DAz57SApn47CHwObin4ZiN/04etXEEBTMXisyXIL6mkAeP8MC4j
         RSNvq6zfGHcUimZaWSgN/to67BN6BGKeq/yz9FUcL8DW23i7kSxcUbkvIJKJb+mjRft6
         3K+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726269641; x=1726874441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B65GRKe+0vYbGgtddhBHaAOt9Gcud5s/LIbVtVdrK6I=;
        b=tgAnEeGVf5A5j1Jm0esIb72wTJOd6dVcFw+tf0yV0/E2sB289EJ8ISHVN6jOF8AEaD
         QyXAWhJYcqMAI1LOqYUXKurmuKy5d1IL/Y8CZhgLZS5EJ+G1QhaxO+BySq5Eif4Kpm+z
         HiSLyvH9pL83k5W5kVheuYGdC+IOJyo8w2oZimqVg40kbZh5CkSohmYeo0pLQY7qkkSH
         35O6vhilNjUFCm5EY1RkcKuhflpf47Pqjv7n9b3KbnolO02EGqfVAIR+twxBvHCNrhyP
         hqe5jNELHw8eWaWSQs2Se77csxjtkvCXo1zIlTYSh4gB0k8DTks81JRG1hNBiZkbTSX4
         DdNw==
X-Gm-Message-State: AOJu0YxivBV/jEB9cnFt+Ry+PkblINd54iUrNpKqbMlmFKw93FTdDqHc
	7fCNEJdL0Se767gr7qVFWLkuKXk8rVvUdpGw15dca6tFs9YZucwwpeGvbFjkW3s=
X-Google-Smtp-Source: AGHT+IGZD12EPsM+AeHsInOOfJN7c9Oivml4pbnxnU151SvSbzhTNPTq8CdnsdUkSxgiO2o/WcbX9Q==
X-Received: by 2002:a05:622a:48a:b0:458:3353:9a11 with SMTP id d75a77b69052e-458602d9969mr156446301cf.21.1726269641040;
        Fri, 13 Sep 2024 16:20:41 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-459aac7fb7bsm1245801cf.21.2024.09.13.16.20.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 16:20:40 -0700 (PDT)
From: Gregory Price <gourry@gourry.net>
To: linux-efi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	ardb@kernel.org,
	leitao@debian.org,
	usamaarif642@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	ilias.apalodimas@linaro.org
Subject: [PATCH v2 0/4] libstub,tpm: fix small bugs and improve error reporting
Date: Fri, 13 Sep 2024 19:19:50 -0400
Message-ID: <20240913231954.20081-1-gourry@gourry.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The efi/tpm code has a number of small signed/unsigned bugs and
inaccuracies are prone to cause further bugs in a difficult to
debug manner.  For example, there is a signed/unsigned mismatch
in efi/tpm.c that can lead to calling memblock_reserve on a range
with an effectively negative length.

Additionally, there are silently ignored error conditions may
result in undefined behavior.  Address these.

Signed-off-by: Gregory Price <gourry@gourry.net>

Gregory Price (4):
  tpm: fix signed/unsigned bug when checking event logs
  tpm: do not ignore memblock_reserve return value
  tpm: fix unsigned/signed mismatch errors related to
    __calc_tpm2_event_size
  libstub,tpm: do not ignore failure case when reading final event log

 drivers/firmware/efi/libstub/tpm.c |  9 ++++++---
 drivers/firmware/efi/tpm.c         | 26 ++++++++++++++++----------
 include/linux/tpm_eventlog.h       |  2 +-
 3 files changed, 23 insertions(+), 14 deletions(-)

-- 
2.43.0


