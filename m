Return-Path: <linux-kernel+bounces-395414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C1779BBDA1
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 20:04:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBA3D1F22E13
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 19:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8741CB9E7;
	Mon,  4 Nov 2024 19:04:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kzes0nh1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B65E552
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 19:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730747092; cv=none; b=nIIELn+3aIRUf6Vvope3aU05BuO0zzrefTTnTUBrbfbOsaaz1BBr64e41/ifBa02rbS7xnSQUZjdxSeEiVD9CFygaN+yPi+2do+bohUDdtwnIBud5HAZfQplqb9JezSwaezstkSySdV8/pLYPazFHbxIA8m6Bg10B8t+5rAbWfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730747092; c=relaxed/simple;
	bh=N1h4pq/anbSJQs15YAagthuhywhHq4LEP8j9pRo8gNs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=itkK69bYLup9mwzW0u+djs1R4scD9j7nCWWRa3eG4SX8ZdZkSF65fs4B0NlWhL1ESfQ6uLCjcpv3VhkSOhkH1dkRjAEZIRED3XTgHb9uGkcxZ/gRL1tqSiSKclft12ifLaIR8vKGBS0PFcwlqZgc6ko+Ect5SYeFuRtAuXJmfEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kzes0nh1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D148C4CECE;
	Mon,  4 Nov 2024 19:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730747091;
	bh=N1h4pq/anbSJQs15YAagthuhywhHq4LEP8j9pRo8gNs=;
	h=From:To:Cc:Subject:Date:From;
	b=kzes0nh1s69LcBfcmyJMRz0zGQIKQAX0seWC1TwMa1rW0H9ShQTgeyzWC9POUrzsi
	 CcOut4sd5FdQ8GCtO5z6w7SRuhqxCShie/2RCcX26M3cVQK15nvYpybTzJKSIa0u13
	 WlCuGoRqF0Izj1uLfW17+0yqq/FyoLwCyVsDOcIlBIgyT+Rbity3bgFzeeG2fR2sEC
	 H9zRkOAFdDLg46xEwvML3cDTeLz0auaGvcaH+/qK92JVkVs3CWkz4T5lrrvmnNziw5
	 2HnuX05g7jtgY8ybYYm3XiF6gDFqcM3iCjEclrnjq652xB1Mh1704hMXBKAHOSvmUL
	 RiY83KXV+9liQ==
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] cacheinfo: Use of_property_present() for non-boolean properties
Date: Mon,  4 Nov 2024 13:03:42 -0600
Message-ID: <20241104190342.270883-1-robh@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of of_property_read_bool() for non-boolean properties is
deprecated in favor of of_property_present() when testing for property
presence.

Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
---
 drivers/base/cacheinfo.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/base/cacheinfo.c b/drivers/base/cacheinfo.c
index 7a7609298e18..05755523cfdc 100644
--- a/drivers/base/cacheinfo.c
+++ b/drivers/base/cacheinfo.c
@@ -254,11 +254,11 @@ static int of_count_cache_leaves(struct device_node *np)
 {
 	unsigned int leaves = 0;
 
-	if (of_property_read_bool(np, "cache-size"))
+	if (of_property_present(np, "cache-size"))
 		++leaves;
-	if (of_property_read_bool(np, "i-cache-size"))
+	if (of_property_present(np, "i-cache-size"))
 		++leaves;
-	if (of_property_read_bool(np, "d-cache-size"))
+	if (of_property_present(np, "d-cache-size"))
 		++leaves;
 
 	if (!leaves) {
-- 
2.45.2


