Return-Path: <linux-kernel+bounces-168771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A87CB8BBD7E
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 19:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D223B1C20C01
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 17:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FF95FDD3;
	Sat,  4 May 2024 17:42:44 +0000 (UTC)
Received: from sxb1plsmtpa01-03.prod.sxb1.secureserver.net (sxb1plsmtpa01-03.prod.sxb1.secureserver.net [188.121.53.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F2E4500E
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 17:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.121.53.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714844564; cv=none; b=vBUI2neL5AWLWSU9pL+b8iqM+ejxzMZBDLMzCgsVCZJ/ZTdI0GZ4MUWf4121Gya5J4F77PNBJfafT4ASTda5W2AllVkhnepypoBAp69d/n3KRn3Wj+cbbdxK4s80SxaCgGjQ736dHs8oRocWbYv14DuwwoFus8ZvwSTwK+2c6ec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714844564; c=relaxed/simple;
	bh=Gh536ipTsa3kSRdp4xPrYVoj6w/+qTJK/5whOeeBdfU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bo3MpjlcK1IYjuX1/VQx1VDUx/mOUXTwduu/wtmC5kFFCCrKPxWmH4qmxND+SxDrS9vhySzy8VZp+r6OjGVQAXufLQvQJjjf/AOOzKDhzd/TAj0IfvfLhAQxbPZyjnEbvZQ20AAjSb8vwaLTX4rJaUgt2cDMWZOkjJWYkUoq1nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exordes.com; spf=pass smtp.mailfrom=exordes.com; arc=none smtp.client-ip=188.121.53.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=exordes.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=exordes.com
Received: from exordes.com ([87.92.66.153])
	by :SMTPAUTH: with ESMTPSA
	id 3GrzshGfI169Z3Gs2sJEKg; Sat, 04 May 2024 08:00:15 -0700
X-CMAE-Analysis: v=2.4 cv=R+jIGsRX c=1 sm=1 tr=0 ts=66364d80
 a=13ZijDARommhillvnyM9pA==:117 a=13ZijDARommhillvnyM9pA==:17 a=eCYXQZmkAAAA:8
 a=C8WjyCjYx6-4fln_c68A:9 a=77AlN4CNbnqoG63BkLSu:22
X-SECURESERVER-ACCT: dai.lu@exordes.com
From: Lu Dai <dai.lu@exordes.com>
To: shuah@kernel.org
Cc: Lu Dai <dai.lu@exordes.com>,
	javier.carrasco.cruz@gmail.com,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] selftests: kselftest_deps: fix l5_test() empty variable
Date: Sat,  4 May 2024 18:01:06 +0300
Message-Id: <20240504150106.265481-1-dai.lu@exordes.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfKNzjYfLitl7aiLQuyIPRXt3TG++PfnQYp46/ZUycYkdDdafQqAxrYU5sMiaxukYtGuSvBEstHJekNDmJ8QHE4LkPwviwLSsVc5SkJiy3DJ0oJcQxp0j
 PkL7qoRCYzlSC7jIvDC9tdDUCraZXZ8MEtgP0ndjHhAkhJ44/QVOI8uQ21FN0SFJCBAVKGJOU/gAKhX1/UuRKjisSJ+Jh1fZmylVFg2up2/CGQSuUjVBuIIX
 SqRMHm4mCeF7DiHAxu9vrTLG+eYeODXMr7QkzokvgTY27jWBNCJfKePyBoO3UD0lY2XYZPcece9bB3feWBsC//Y0pvHACyg+8uH01vmHarQ=

In the function l5_test(), variable $tests is empty when there is no .mk
file in the subsystem to be tested. It causes the following grep operation
stuck.

This fix check the variable $tests, return when it is empty.

Signed-off-by: Lu Dai <dai.lu@exordes.com>
---
 tools/testing/selftests/kselftest_deps.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/kselftest_deps.sh b/tools/testing/selftests/kselftest_deps.sh
index de59cc8f03c3..487e49fdf2a6 100755
--- a/tools/testing/selftests/kselftest_deps.sh
+++ b/tools/testing/selftests/kselftest_deps.sh
@@ -244,6 +244,7 @@ l4_test()
 l5_test()
 {
 	tests=$(find $(dirname "$test") -type f -name "*.mk")
+	[[ -z "${tests// }" ]] && return
 	test_libs=$(grep "^IOURING_EXTRA_LIBS +\?=" $tests | \
 			cut -d "=" -f 2)
 
-- 
2.39.2


