Return-Path: <linux-kernel+bounces-228905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA3D916877
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 14:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD7F11C223CE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jun 2024 12:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE55D15F3E8;
	Tue, 25 Jun 2024 12:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="FJPC5nkK"
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD0015AD8B
	for <linux-kernel@vger.kernel.org>; Tue, 25 Jun 2024 12:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719320307; cv=none; b=cQXy4wdENKHFzXqEfXcEUEowLSeUD9RqpsMfSoePLO9TrgjbLVLFqJm+ifDQ/MFXyvYQv2FO3dZS8WRLufIP4vNbeKqTK4kSH5j/oPGq0SlTogsygxtEqwB3bAR49XbA0PB4qduZK3GWzyyftrqwoW3jJG+ajoLS74r/3TsXpeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719320307; c=relaxed/simple;
	bh=4WNNOZ1PBF66p8DHjDwxj6Y68GUxyJtWNwbC3thPxlg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ixZFP4VF57PEQbAYzfYllddvQtAKq/h6gkxFRWfiobdzzH+RTkaAoJs58ge1pTOmmBuwcW5A2/qAy3St1MgJsJis0tNgWWDQrjzxQuQBfQlcISdlWLY7+5WLHzRH6sHMuITz8+F3DFDN2htkEYFnLRmHRCAuy+ut7jGczdCgfIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=FJPC5nkK; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rCw/f2WreuFLhN721myDy+YkLeZoRUij06skazpEo+Y=; b=FJPC5nkK+Ifqc4zRavopnnbJn+
	eScvPYOBnvnASKdHTYEE8QbZSWv62nc7QqRQsw5t7tVIVknCMP2qVhGZjHPK6Juvf3qYmpzJTNU+n
	hxstIrap+5ErXqvXMxpD2jjn+oXNA2kvcTbpgD3ztuVuOHSGPXiSqsKx9BIfoDsJkLntTYBHKJA7N
	lWcIQP1eKBT4DocVhVDBs6LEGmA48Xv8wMAjSIRuGw9UtKibQctQj+n1GTXlB/YYAJfg2jJ5Uox/Z
	N8BSD/ItkoJMZLV1hoDl3rD8ADY4z0jIvz57Upg5naYSkxMr9EZ1lMr5Y8XIr3vRU33qlxX4Uwogb
	P2617/xg==;
Received: from [84.69.19.168] (helo=localhost)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sM5kU-007J4W-Vj; Tue, 25 Jun 2024 14:58:15 +0200
From: Tvrtko Ursulin <tursulin@igalia.com>
To: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	kernel-dev@igalia.com,
	Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 0/2] NUMA emulation for arm64
Date: Tue, 25 Jun 2024 13:58:01 +0100
Message-ID: <20240625125803.38038-1-tursulin@igalia.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

This series adds a very simple NUMA emulation implementation and enables
selecting it on arm64 platforms.

Obvious question is why? Short answer - it can bring a significant performance
uplift on Raspberry Pi 5.

Longer answer is that splitting the physical RAM into chunks, and utilising an
allocation policy such as interleaving, can enable the BCM2721 memory controller
to better utilise parallelism in physical memory chip organisation.

In more conrete numbers, testing with Geekbench 6 shows that splitting into four
emulated NUMA nodes can uplift the single core score of the benchmark by around
6%, and the multi-core by around 18%.

Code is quite simple and new functionality can be enabled using the new
NUMA_EMULATION Kconfig option and then at runtime using the existing (shared
with other platforms) numa=fake=<N> kernel boot argument.

Note however that the default allocation policy is not interleaving and further
steps are required to "unlock" the performance uplift.

Simplest method is probably to launch test programs via the
"numactl --interleave=all COMMAND" wrapper, but it is also possible to change
the system wide policy via systemd configuration.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: “Rafael J. Wysocki" <rafael@kernel.org>

Maíra Canal (2):
  numa: Add simple generic NUMA emulation
  arm64/numa: Add NUMA emulation for ARM64

 arch/arm64/Kconfig            | 10 ++++++
 drivers/base/Kconfig          |  7 ++++
 drivers/base/Makefile         |  1 +
 drivers/base/arch_numa.c      |  6 ++++
 drivers/base/numa_emulation.c | 67 +++++++++++++++++++++++++++++++++++
 drivers/base/numa_emulation.h | 21 +++++++++++
 6 files changed, 112 insertions(+)
 create mode 100644 drivers/base/numa_emulation.c
 create mode 100644 drivers/base/numa_emulation.h

-- 
2.44.0


