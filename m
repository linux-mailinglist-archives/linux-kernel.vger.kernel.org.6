Return-Path: <linux-kernel+bounces-551815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1850A5714F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 20:16:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC30C3B695F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 19:16:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF142561A0;
	Fri,  7 Mar 2025 19:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S5M/BiAs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A38C2512DF
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 19:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741374898; cv=none; b=q+CSBddRjFZHtGm9Xir9LoFzwIk0VaLiNHmgq3gxkXQCDefcoPvCOm+gKruVCBI49kFioej+qLgWBLKq36Gra+J4IFGXk1L260VzHFrZ2x82JhPMUuC+OrlEZuB4QFCCDHtVZs/+0U0IwdEm6V9TU1zTcHZ5pcQ0Fz0vlhI/R/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741374898; c=relaxed/simple;
	bh=AJ4q+ksNB/S+00rtzYs71awF+2iIilrq6aaRwUt1Pzg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fYLHFdEiI6joNsIHHn1lEKwhhY0jb5nDtSawdTjBqFBmpQF8Q0e7KvBFyYEY4mOzYJ6poioJcSu4Z7UH5GQc6PhwuegQODVT0WMqvvahiOmyUE2MnJkBPz8jp5r0ZdhSI79xDRuDVdG6fDFP5SOFQ4aUDG/uNu8hcTpYVqK+16I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S5M/BiAs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C754AC4CEF0;
	Fri,  7 Mar 2025 19:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741374897;
	bh=AJ4q+ksNB/S+00rtzYs71awF+2iIilrq6aaRwUt1Pzg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S5M/BiAsKnzREVeCWrCdJDADY7iq1bCovnPnakVUuBQguNKzCDkcAwvwfzjUhC0S8
	 xGW90W2lvOjR0XFO4YhlTKB00Pe2QG4BgD/L0JOOe7S+1Z8pMBHWpLvC2C3b7x7Xkn
	 R6jdkef0x0rmDUwn/xLrmyp1a76hlmbnXt4ZXTLAs0kL41q5d5KiSoqS6IXjTAbm3B
	 pV7bBvwcg2AUGkU99UMbX1UMSonzfx++ZUFRvJAPitO2m9igNbG+115JeSMLXNdfh8
	 128zFpOPown4igGulbo9z6IpokKv3JevS1l9z3GsQN7bo1MuiW+VRl2qKTJBA9TPll
	 6eGWOgU8MV+Sg==
Received: from mchehab by mail.kernel.org with local (Exim 4.98.1)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tqd9r-0000000BQmJ-2qyw;
	Fri, 07 Mar 2025 20:14:55 +0100
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
Subject: [PATCH v8 02/20] tests/qtest/bios-tables-test: extend to also check HEST table
Date: Fri,  7 Mar 2025 20:14:31 +0100
Message-ID: <48dfa6e0c11faae34e63d6cbeb834fd9b6e9b095.1741374594.git.mchehab+huawei@kernel.org>
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

Currently, aarch64 can generate a HEST table when loaded with
-machine ras=on. Add support for it.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 tests/qtest/bios-tables-test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index 0a333ec43536..8d41601cc9e9 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -2122,7 +2122,7 @@ static void test_acpi_aarch64_virt_tcg(void)
 
     data.smbios_cpu_max_speed = 2900;
     data.smbios_cpu_curr_speed = 2700;
-    test_acpi_one("-cpu cortex-a57 "
+    test_acpi_one("-cpu cortex-a57 -machine ras=on "
                   "-smbios type=4,max-speed=2900,current-speed=2700", &data);
     free_test_data(&data);
 }
-- 
2.48.1


