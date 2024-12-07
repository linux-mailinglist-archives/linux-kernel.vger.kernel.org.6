Return-Path: <linux-kernel+bounces-435961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9539E7F25
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 09:57:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD978163DA6
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 08:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0567B14EC62;
	Sat,  7 Dec 2024 08:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iVI+/1et"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8429B13C690
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 08:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733561805; cv=none; b=t+TL+nRGxen0ZHlhGqFXa02JWqHzXJwZsnnA+I161fLAxXq2Jpzwq28B2gRM4l29US/7b68sal9SXOYx214kOvTgxHLNwA5WdGiF+Xyx7AUgWX2xrPOKfK7HtQV8jE0Q+2VGpu9ANeDyUzMJKIvXILQKpEwxuWk5Exv+5PXiPAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733561805; c=relaxed/simple;
	bh=xKr5K1TW0pYorJXNz1Ksgf7p26nCCQVwbb66JoUnk8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hyH6yAWGNmHuzpjBhDc/CH+pFKWpTA2cur0mR3+p9V5bhOLYCzRUUzVMaVYVrnFqkueQMN4dIvjEYp4qVSDymy77imqNY2qGW3CUcDuE5VOaMnNUsihOS+lrT2tIGu+u+Ox3Jcy6ik46368Mcc+RCBq+puXUOcZPeTorZ/4VwKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iVI+/1et; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23907C4CEEB;
	Sat,  7 Dec 2024 08:56:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733561805;
	bh=xKr5K1TW0pYorJXNz1Ksgf7p26nCCQVwbb66JoUnk8M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iVI+/1etFqitLEhuGmplhAnFlNYz85ZNWwIpP+DYGKrnpt7xIsQSKT9LzSDDmZpXb
	 py5oOw7Xru2mLfi+NKEr1MQbSglG1IFksJQiQqjPCkTL1I9AveRV1Da2gds1d8yrJX
	 cUsP4jEFpin36wp9U9U2MUkMBc15MzycMtDNmXqEGIv1LALAQ729MjX5xUUlk73PtG
	 juCHNtqKIg9CsGA9iBaomNgB538azbG05Ijcctpk+1qwj9oL15PycW8yqPHk5znpba
	 Nz3p2rSPvnXPrZ1FH28l8vgCVOUxo3r3VS9k56oXouSju4proJZsmliZcsiKoRbf+G
	 lv7Zb1zBoq9mg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tJqcF-00000005j50-0WsY;
	Sat, 07 Dec 2024 09:56:43 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	Igor Mammedov <imammedo@redhat.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v6 08/16] acpi/ghes: don't check if physical_address is not zero
Date: Sat,  7 Dec 2024 09:54:14 +0100
Message-ID: <95c0fa3fc2969daf3b6bc1f007733f11b715a465.1733561462.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733561462.git.mchehab+huawei@kernel.org>
References: <cover.1733561462.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

The 'physical_address' value is a faulty page. As such, 0 is
as valid as any other value.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/acpi/ghes.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index edc74c38bf8a..a3dffd78b012 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -400,10 +400,6 @@ int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
 
     start_addr = le64_to_cpu(ags->ghes_addr_le);
 
-    if (!physical_address) {
-        return -1;
-    }
-
     start_addr += source_id * sizeof(uint64_t);
 
     cpu_physical_memory_read(start_addr, &error_block_addr,
-- 
2.47.1


