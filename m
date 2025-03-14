Return-Path: <linux-kernel+bounces-561365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD16A6107C
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 12:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB1B46286F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366FA1FE449;
	Fri, 14 Mar 2025 11:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L6n6Iu/T"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAFA1FECBA;
	Fri, 14 Mar 2025 11:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741953461; cv=none; b=Avrhn3vfhmmajenPqPBVFc0gSVYhEdczzcvBhdJHTTzZ5auaGQpiq3M1kipncxp3T0NGlqnvfs+R00LAYNiwz+CTUHdOOoq1Pl4J6bS8JFEr7iqcURelDT36fL40fyE5Go1ChJu2GHzMGx0n3jc0I7VzyNg/GA9P6FJew6DfVMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741953461; c=relaxed/simple;
	bh=h9R5v8KHjf73KOzZC4dBCiwt0HBHwsI7o5SeTDlR0lg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NVHxrcllaMeTNUy18ucV14C3EFMkjDaW+5g9AuDrkmS30ibyKOclTkgQjwQO+8qvwrevHAFCsuazkfaVP9hyqQcc0yMkh45aMqUbDCoT0mCkGodsZiW8pulClL8w+R+FntOkOeYNQi+c9P1JmKPmsxUsyaw+syz8BptSYwb9jBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L6n6Iu/T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81A03C4CEF1;
	Fri, 14 Mar 2025 11:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741953461;
	bh=h9R5v8KHjf73KOzZC4dBCiwt0HBHwsI7o5SeTDlR0lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L6n6Iu/T2FVs4V4AqCqmYWvXoki5xhpHCAGGGOeLTGAVa7VWe4WKdZzsNFlPt8pYz
	 dhvDJHdZNqLemX1eQ4adk+vKXEHogIhp6pvk/ny4XCRS80Dl1qdhrN986gaaWK82gn
	 d7hAzO+jp47CGgDOl1wYI7+JonubTojPlJ0C81ASChdp7x0thmpkFSDf+czcmv9KWK
	 7afjQdUOB4GCjlxi2YPKuX6+pGVkZWSOCIItW1oqj4LaIL1Ygz3NQOpi0J08A4CHCZ
	 zrJGwhK4m5U9mdGwbeYEWpE1vmoKUDvIEtVe40U38x3qwW4nariAflWwaOF68pN0rS
	 uPm+FQUxRsLwQ==
From: Alexey Gladkov <legion@kernel.org>
To: x86@kernel.org
Cc: "Alexey Gladkov (Intel)" <legion@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	Alexey Gladkov <alexey.gladkov@intel.com>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Joerg Roedel <jroedel@suse.de>,
	Juergen Gross <jgross@suse.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Larry.Dewey@amd.com,
	Nikunj A Dadhania <nikunj@amd.com>,
	Tom Lendacky <thomas.lendacky@amd.com>
Subject: [RFC PATCH v1 3/3] docs: ABI: testing: Add documentation about TDX
Date: Fri, 14 Mar 2025 12:56:28 +0100
Message-ID: <9e3c8a309ea558e8783c2bd346f536ce8417f406.1741952958.git.legion@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1741952958.git.legion@kernel.org>
References: <cover.1741952958.git.legion@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Alexey Gladkov (Intel)" <legion@kernel.org>

Document the new testing ABI of TDX module. Currently, there is no
reliable user interface within the guest as well as on the host system.

Signed-off-by: Alexey Gladkov (Intel) <legion@kernel.org>
---
 .../ABI/testing/sysfs-hypervisor-tdx          | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-hypervisor-tdx

diff --git a/Documentation/ABI/testing/sysfs-hypervisor-tdx b/Documentation/ABI/testing/sysfs-hypervisor-tdx
new file mode 100644
index 000000000000..5ee33cdc59ef
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-hypervisor-tdx
@@ -0,0 +1,50 @@
+What:		/sys/hypervisor/tdx/version/major
+Date:		March 2025
+KernelVersion:	v6.15
+Contact:	linux-coco@lists.linux.dev
+Description:	(RO) Report the major version of the loaded TDX module.
+
+What:		/sys/hypervisor/tdx/version/minor
+Date:		March 2025
+KernelVersion:	v6.15
+Contact:	linux-coco@lists.linux.dev
+Description:	(RO) Report the major version of the loaded TDX module.
+
+What:		/sys/hypervisor/tdx/version/update
+Date:		March 2025
+KernelVersion:	v6.15
+Contact:	linux-coco@lists.linux.dev
+Description:	(RO) Report the update version of the loaded TDX module.
+		Not available on the guest side.
+
+What:		/sys/hypervisor/tdx/properties/build_num
+Date:		March 2025
+KernelVersion:	v6.15
+Contact:	linux-coco@lists.linux.dev
+Description:	(RO) Reports the build number of the loaded TDX module.
+		Not available on the guest side.
+
+What:		/sys/hypervisor/tdx/properties/build_date
+Date:		March 2025
+KernelVersion:	v6.15
+Contact:	linux-coco@lists.linux.dev
+Description:	(RO) Reports the build data of loaded TDX module in yyyymmdd
+		BCD format (each digit occupies 4 bits).
+		Not available on the guest side.
+
+What:		/sys/hypervisor/tdx/properties/features0
+Date:		March 2025
+KernelVersion:	v6.15
+Contact:	linux-coco@lists.linux.dev
+Description:	(RO) Reports the features supported by the loaded TDX module in
+		hex format. Enumerates TDX features:
+
+			=========   ===================================
+			Bit 0       TD Migration
+			Bit 1       TD Preserving
+			Bit 2       Service TD
+			Bit 3       TDG.VP.RD/WR
+			Bit 4       Relaxed mem management concurrency
+			Bits 63:5   Reserved, set to 0
+			=========   ===================================
+
-- 
2.48.1


