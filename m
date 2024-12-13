Return-Path: <linux-kernel+bounces-445342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BEE9F14D9
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 19:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0130716A8C1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 18:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 214411E882F;
	Fri, 13 Dec 2024 18:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="VyUn/nkK"
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079FB18A6D5;
	Fri, 13 Dec 2024 18:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734114090; cv=none; b=L4IAFNLbM3cKh2ZQGF6Ajl1dis2HqNCm1oypx0bosXJj7QnrQ21/xY/WA+OOlsKP7twZsb2qpEZH5mGn5LIPm0T4ICJOQpACPFMpwocns2JDqWGKXnRlf64XW1SyaITzl5RBCbhbpXrFwh2f0Rul5NJhUZUvzb743jYHMBhYmCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734114090; c=relaxed/simple;
	bh=P0PrWDL3CG+647eom8x1NzoVJppZe2tsxKJaG5QN0iM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ff8Wr7Y6rCRQ66KHbYcZg1nrV6uSVNVGl6tGg7W0VmOfkIo0lbXaPtXwu0DAyfr+n1dPyRyix5k7qgL8cN5u1NlN5qDYI5VjM8z1bm8z/LlV6th3TODUjruBnRoQoc6FCdwfal6Gtoi3rstWKhYlGQ1vVk9ERDyv6cVPXpYJNW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=VyUn/nkK; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 36BD9403FD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1734114088; bh=QXEu0v0T33DDpelHsiC6ROVGofv4AqOE4HtQlF7GJzE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VyUn/nkKs1nVzPnAY8U1r5u3I4UaBtmNC6qhCRkia2IdXbdgFOo/IQpPm2OFffuR+
	 A0ybZmi6gS6+zRCMlw9G4XfBHmkTHFCGKCukd3QqNO6BM6U/T8RCACAZnFz4n5fJj4
	 xdxNnW7QkOaGfM/zq0XrVPUilftGliWZ7dH8lfmkI+0JtAMLBXdK5+b+8tHP/BnuFA
	 rmjJuo6WAlPYzbZ38ssR6DPmFK2adQnm0VNrGoN3KSVdIHyXAHiMHR4a+CUTri7ehA
	 fl6GTMahRc70emKDCKVr6FBlWPIh6WJmFen/aSPvrrxKB3s9Qcet47l4kkF2R+mX0k
	 O6abUkIcEiQow==
Received: from trenco.lwn.net (unknown [IPv6:2601:280:5e00:625::1fe])
	by ms.lwn.net (Postfix) with ESMTPA id 36BD9403FD;
	Fri, 13 Dec 2024 18:21:28 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH 1/3] docs: admin-guide: join the sysfs information in one place
Date: Fri, 13 Dec 2024 11:20:52 -0700
Message-ID: <20241213182057.343527-2-corbet@lwn.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241213182057.343527-1-corbet@lwn.net>
References: <20241213182057.343527-1-corbet@lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The documents describing sysfs are spread out in the admin guide; bring
them together in one place.

Signed-off-by: Jonathan Corbet <corbet@lwn.net>
---
 Documentation/admin-guide/index.rst | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/index.rst b/Documentation/admin-guide/index.rst
index 15a522a96e76..94b70bb203cc 100644
--- a/Documentation/admin-guide/index.rst
+++ b/Documentation/admin-guide/index.rst
@@ -19,7 +19,6 @@ etc.
    devices
    sysctl/index
 
-   abi
    features
 
 This section describes CPU vulnerabilities and their mitigations.
@@ -49,14 +48,14 @@ problems and bugs in particular.
    perf/index
    pstore-blk
 
-This is the beginning of a section with information of interest to
-application developers.  Documents covering various aspects of the kernel
-ABI will be found here.
+A big part of the kernel's administrative interface is the sysfs virtual
+filesystem; these documents describe how to interact with sysfs.
 
 .. toctree::
    :maxdepth: 1
 
    sysfs-rules
+   abi
 
 This is the beginning of a section with information of interest to
 application developers and system integrators doing analysis of the
-- 
2.47.1


