Return-Path: <linux-kernel+bounces-435411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84BDA9E7713
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 18:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36B8D2878DE
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 17:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E431321E9B0;
	Fri,  6 Dec 2024 17:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m6EmjH7h"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCD420459C
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 17:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733505688; cv=none; b=YJUaSU4+BhAe1hjm4Ub2RMsHe+M7sBA7bbpvwqxrJ+3SpDn5w2zDoSeE56/pu4VQyF1E4SEdJkLo/NH/UoBe+qcYja4tkG9OkYysYNxzyNMdAqmN/7/8fyc6UepBBjebmh3du9eVIBnTgXxYvM0cscKxZZuTXSYG895G6cGmj+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733505688; c=relaxed/simple;
	bh=zxKfkNm+pSVnAEPcR6JZVOzcfRxvG1fLSm0I+c3SdBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FxQkYbWLf98IEU6gA+YGwA0KsbfNrvihuCdSzd1yEg1N/3/VqXagLHeiAUUIzkBGPAcxhANDvlEIyoBrcby7XGPrvQSqSS+IvhqjUfs27jNIj5BWJLg3642oFlAA7YbBINW83TTZZP/X0KJhN2FN0CNc5AeXQMS702rHd3LdKpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m6EmjH7h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10107C116D0;
	Fri,  6 Dec 2024 17:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733505688;
	bh=zxKfkNm+pSVnAEPcR6JZVOzcfRxvG1fLSm0I+c3SdBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m6EmjH7hdesUTYtwkieXwyndcBWI6xVvNKwqhUzmwbIWrGouOSzzxNCSVvvrrFZhz
	 qI+OQA9NjACU1kv9SfAtYtUxsdMKYAvNTPgpSOwzKgeP4eJlPzpjtPQcQIbwrEeB2n
	 sQRvctKw9GRFOLW56rszrx2/lgJxTekexq7GkCzVWjLwKHV/ROgYNapgILtLqj1bUs
	 AiuEhcb1yaDVbgwRO85FdqcSLxe4HkI0oAq4eacLblzXEs37m5iY+at434OWnGMJ1s
	 YIjrUjdkIGQn1OsOACYPO2hqCjw1bmBsdZiaRckv11thmBxCuQqSDXDbGIIwtElTn3
	 qxJAHN1Mto09g==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tJc18-00000005RLO-18Wv;
	Fri, 06 Dec 2024 18:21:26 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Ani Sinha <anisinha@redhat.com>,
	Igor Mammedov <imammedo@redhat.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Shannon Zhao <shannon.zhaosl@gmail.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 29/31] HACK: use GPIO as source ID for virt-9.1 machines
Date: Fri,  6 Dec 2024 18:12:51 +0100
Message-ID: <bfc2a2537a301761115bd960e0c363a437ad65bb.1733504943.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <cover.1733504943.git.mchehab+huawei@kernel.org>
References: <cover.1733504943.git.mchehab+huawei@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>

This reverts commit 692373fc8838a6450ff5b5a8708646a673b693dd.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 hw/arm/virt-acpi-build.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 31f2db01458d..55d12562e83e 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -896,7 +896,7 @@ static const AcpiNotificationSourceId hest_ghes_notify[] = {
 };
 
 static const AcpiNotificationSourceId hest_ghes_notify_9_1[] = {
-    { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
+    { ACPI_HEST_SRC_ID_QMP, ACPI_GHES_NOTIFY_GPIO },
 };
 
 static
-- 
2.47.1


