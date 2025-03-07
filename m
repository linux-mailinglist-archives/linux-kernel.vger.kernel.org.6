Return-Path: <linux-kernel+bounces-551814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D63B0A57152
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE61189995F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB21255E3A;
	Fri,  7 Mar 2025 19:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqY+jjLJ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98D352512DB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741374898; cv=none; b=BieGgVk/dkV4Wiy2YtrO7GaBQvw8Y8Efl69besQF/UBGyRx/PkoK8M6JV+8DJxnLOQz069YdsuZJopQ4OyMFi2a0yITkGmhyyjCjgaJ/YFuHqfYspd8f9qa37y4bK9llOD836rxEj8iyyKoDIIV1+gBAqqTy4KjPlwGy0mxI/dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741374898; c=relaxed/simple;
	bh=Oy1d1NtjIuq8rVPzyJSOrQ/KFfdLC18cbst4NO1Tvbg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ED+iWh4NM+JOtJiQHAXtJdZW001RhMNOryQw/OH5Y75+DZSZDNXt5pYMLjTZApBerxfyVwAvr0nYj35CNNWk4ZVoZoBSvBlWkubP5V5vXtkYkZMxAK8n6CeAE8523LJvGLS1Nb5suxaIpIgWTDkyT0yCjwiYRxvJpUYh6JTDCn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqY+jjLJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDEC7C4CEEF;
	Fri,  7 Mar 2025 19:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741374897;
	bh=Oy1d1NtjIuq8rVPzyJSOrQ/KFfdLC18cbst4NO1Tvbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JqY+jjLJBVi0eF1lChMfI/A8VGCYCoH6b68xFCSmP3HdMHo3foCHbkIzo4WMFKZtd
	 H1R7o9LxX79Iwq5eptjv+/HY6ausbt4pKiQIrFXfYA4eQqakhMFL6fyxW8fB55se+L
	 iSBvpYN18Yxu2dCxmp2RA5OpyoPKmFAcfGGFp4iw/ncXqKB77OfFeP+WK4+R1mhB7k
	 nL+I4rKLVnAsJ/r8I1MxZwWrf8U4YKMGnpxEhGLBMWmoMeFzDUI7S1X8W5eqyTYbIB
	 QL0bGomwKrFFgJzVNB5kHfAD9JzNY8MBEp/t8r0uejFvR4Wla8cdSsfAJV7udRGfnU
	 VmyZSMUJ/uMtw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tqd9r-0000000BQnB-4ApZ;
	Fri, 07 Mar 2025 20:14:56 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Gavin Shan" <gshan@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Ani Sinha <anisinha@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v8 14/20] tests/acpi: virt: allow acpi table changes at DSDT and HEST tables
Date: Fri,  7 Mar 2025 20:14:43 +0100
Message-ID: <c6076e020bc6ee896ea5451583b8b63d9bbaaf24.1741374594.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741374594.git.mchehab+huawei@kernel.org>
References: <cover.1741374594.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

We'll be adding a new GED device for HEST GPIO notification and
increasing the number of entries at the HEST table.

Blocklist testing HEST and DSDT tables until such changes
are completed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Acked-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index dfb8523c8bf4..0a1a26543ba2 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1 +1,7 @@
 /* List of comma-separated changed AML files to ignore */
+"tests/data/acpi/aarch64/virt/HEST",
+"tests/data/acpi/aarch64/virt/DSDT",
+"tests/data/acpi/aarch64/virt/DSDT.acpihmatvirt",
+"tests/data/acpi/aarch64/virt/DSDT.memhp",
+"tests/data/acpi/aarch64/virt/DSDT.pxb",
+"tests/data/acpi/aarch64/virt/DSDT.topology",
-- 
2.48.1


