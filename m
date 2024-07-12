Return-Path: <linux-kernel+bounces-250573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CE6592F93B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 13:03:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8ED1C221B5
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jul 2024 11:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0BF15B122;
	Fri, 12 Jul 2024 11:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFKCaOb6"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3CB13D52C
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 11:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720782224; cv=none; b=MaK+Qa4ckX7eJfPnt/OyknvqamCilG8ievRob/RgNikeU+eaUMXXxqrHWbSXBF3eWp4KfNsQMO89W9q9ODUHXKu46Jhp7rMO5F73RWeyazQtx0ZJVLy80bizyt2c+ECKuVSoG+KcSnUZcOeln6eihieCB3xqipFcIqL4wYDr048=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720782224; c=relaxed/simple;
	bh=jUFzN99UWeSNj/5MosN+5qznAKMKEz//NePA30M+fHg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Epv5Op2Gf4W8fDXWExolWWiJbtF5XC4g/tCH4+yNfBA8Sje9TfS0mbMDS2SH6Qdr+GzT2RyHM8z40yfSBKyWiO5FSDlaTWnxDSqBnWXlL4BUYpAMz4HKLp+jYoInyxJdM2vt1jSlfxo6lxpBl9YYkhjBkuLRrwcTEWtB1wIPNUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CFKCaOb6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720782221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1qQ7l0GWU5+sbaI9jPARmVRN2+U8L5NQD4xZcBL2aSc=;
	b=CFKCaOb6aXDKrgScPogruvrp9fijrq4MzsI9Pfc7E/mUJ4btfrY7AFWl9mTy3NYC/z9txi
	Z9sNiYdm2KwoZCTXVAVOwWm0tfNGyFSkasJcWMaxujYVVNzLQd6l0ZPZkDMoZ4PvoPfo1T
	p8/EC/lTF3qRwZsUX6yX0OpaKIMfNEY=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-rODjqOHXOcWBvFe3D10DMg-1; Fri, 12 Jul 2024 07:03:40 -0400
X-MC-Unique: rODjqOHXOcWBvFe3D10DMg-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-79f00fbac96so275079985a.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jul 2024 04:03:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720782219; x=1721387019;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1qQ7l0GWU5+sbaI9jPARmVRN2+U8L5NQD4xZcBL2aSc=;
        b=tu3j5UdBLSbAtNjeaApfIZmwtPtpvPaj/m4xDN6cPypfoDFYTvG/VnOHdJMvockHkT
         VeG1wWJW0xdnMqeVV9VCu3WJfpkiLQjLZWWQaENOpMBteUG6FsE0L9zgseQOe18iuIsx
         cOMrXG2e5R9NwfMY4EJMvaWuXwwhnqop3WO7hkCgjNmI11Vr1vOaUjKiMlfFQ//As7HL
         NLwmW5An3AsTPdB92TyFx38zX1V88zXUFR3DpqSty/LBbdaLmUB+9FClhIgG25fTWDLI
         fzqqzkAdBsK+uMTlH1fsX6KkjAFUh3HZZKL1Ceh6JxqiPTQzjuVicCbc6+oLMBpMW8NC
         /Mew==
X-Forwarded-Encrypted: i=1; AJvYcCWILMHy/LQaU/KMDtT4Hjp3KQ4uBw7t13WCF2Qwtzyp6xTIpbasRh2/7pjlg2UNYHSkjEIAjaDjlA/6AYR4QLrbwrllF/+EOj0BvXW6
X-Gm-Message-State: AOJu0Yy72bhs+El4+QC6IQF6+Klch1C8zLaIO9rpx9K/FVt+oIGKjv9F
	VMoZesVpvPu78XauZDDI7lbkPKrEbphMYqJADZC66eigppNmSL28toFvWni+G4CTFDTPwei8RRa
	KD1Tsx0hUJdJnGGn4x0UUzXSJluIoxy1eFimt2PbXX5Q3c6pRYQE5ZxBPwW/OBw==
X-Received: by 2002:ae9:e702:0:b0:79d:5a5a:61f0 with SMTP id af79cd13be357-79f19a7fba1mr1120360885a.34.1720782219452;
        Fri, 12 Jul 2024 04:03:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF49CeTtgwI6pw84NFDsgZPcLaXJC9eRYBAhVwf5iFp0zhdiGyDc2Go8V8cwq39LwXuNxN/xw==
X-Received: by 2002:ae9:e702:0:b0:79d:5a5a:61f0 with SMTP id af79cd13be357-79f19a7fba1mr1120357785a.34.1720782219139;
        Fri, 12 Jul 2024 04:03:39 -0700 (PDT)
Received: from rh.redhat.com (p200300c93f45e50062e5f8c654844c9a.dip0.t-ipconnect.de. [2003:c9:3f45:e500:62e5:f8c6:5484:4c9a])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f18ff834csm390498685a.5.2024.07.12.04.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 04:03:38 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Marc Zyngier <maz@kernel.org>,
	Oliver Upton <oliver.upton@linux.dev>,
	James Morse <james.morse@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Zenghui Yu <yuzenghui@huawei.com>
Subject: [PATCH 0/3] KVM: arm64: fix warnings in W=1 build
Date: Fri, 12 Jul 2024 13:03:29 +0200
Message-ID: <20240712110332.10970-1-sebott@redhat.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Building arch/arm64/kvm/ with W=1 spills out a lot of warnings. When
changing stuff I try to use as much tooling as possible to make sure
that I don't screw up - having a clean baseline imho helps with that.

With the first 2 patches applied make W=1 arch/arm64/kvm/ runs without
warnings for me (fedora userspace, kvm-arm/next). Patch 3 gets rid
of sparse lock warnings in arch/arm64/kvm/vgic/.

Sebastian Ott (3):
  KVM: arm64: fix override-init warnings in W=1 builds
  KVM: arm64: fix kdoc warnings in W=1 builds
  KVM: arm64: vgic: fix unexpected unlock sparse warnings

 arch/arm64/kvm/arm.c             |  1 +
 arch/arm64/kvm/handle_exit.c     |  5 +++++
 arch/arm64/kvm/hyp/nvhe/switch.c |  6 ++----
 arch/arm64/kvm/hyp/vhe/switch.c  |  3 +--
 arch/arm64/kvm/sys_regs.c        |  5 +++++
 arch/arm64/kvm/vgic/vgic-irqfd.c |  7 ++++---
 arch/arm64/kvm/vgic/vgic-its.c   | 18 +++++++++++-------
 arch/arm64/kvm/vgic/vgic-v3.c    |  2 +-
 arch/arm64/kvm/vgic/vgic.c       |  2 +-
 arch/arm64/kvm/vgic/vgic.h       |  2 +-
 10 files changed, 32 insertions(+), 19 deletions(-)

-- 
2.42.0


