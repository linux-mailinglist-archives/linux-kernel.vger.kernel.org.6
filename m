Return-Path: <linux-kernel+bounces-536079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADDBAA47B3C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CA823B3BE0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:06:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 522ED22FF44;
	Thu, 27 Feb 2025 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFaRHEdp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71B922B5B8
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654238; cv=none; b=LLI/tSnZHV3Svy5iqeA8dmkTwscJ+KfH5Gsdm9r8Uzvv+zDLJ8cowVPuoxS+6vPN/KK1jnCdM275PKUokvRjE5+EkXCx0TMT6dGzJq7IBLJiw88jTagwkp2two/KFMIQ2c5PiErnfirvbiQXy+Abmy0GJ3Gy77Zo93Cb8iVfMtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654238; c=relaxed/simple;
	bh=IzD7ej6+MnEhTQSr1xYZdmpq2RxnkugunFxTJOIMeHU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mOir2NHxW7ZjUTeryUwofbEZZu9QXlbDzrCuc2IrME7DYGCDfqN5cD/fDiYs8F1LISgmLEpUXB5+/mjTOAaOTAKF50CDzpzKXTvqp+JRAltZJgVlUNfRa4htAhe3TUZPHv84FjAP8Q2+jclPxKigunpArniPhKwamzqqNKqfx1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFaRHEdp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28656C4AF0C;
	Thu, 27 Feb 2025 11:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740654238;
	bh=IzD7ej6+MnEhTQSr1xYZdmpq2RxnkugunFxTJOIMeHU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kFaRHEdp7iJdv8YpnN1KKmuln6cq14aVqrlrccAm5jSIeUyf3zMYM54ALHen26Ox6
	 iVxe9orcWsLRt6h655KtSiIZ2OYwhHqpK3XJIS6mqAtX1tNalyuCb4QpPU2GYzB2td
	 bc67ody9D8UlbsAWh2l+rsNHYevjns6NKh/Xi+1qrdmV8a+Awq0is2w0fgXEOTJ0vO
	 0BZJoWrgOekqNO2auHjgcZYW35Biso8JqU1x6vI3RWxVVH2EYdHS8uCB4hqr0olojV
	 Ghdx8VYahw/0O65P0kwlCiw2t9ESTZrvjsV6QrjZvME7vQbLV7pcpTJmvzKw1csJTE
	 nm+/QcTPy6Fxw==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tnbgK-00000001mRQ-1Zg5;
	Thu, 27 Feb 2025 12:03:56 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Ani Sinha <anisinha@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 14/21] tests/acpi: virt: allow acpi table changes at DSDT and HEST tables
Date: Thu, 27 Feb 2025 12:03:44 +0100
Message-ID: <11f37e677592494c7e73b2ff5fad700e8726205f.1740653898.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1740653898.git.mchehab+huawei@kernel.org>
References: <cover.1740653898.git.mchehab+huawei@kernel.org>
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


