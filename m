Return-Path: <linux-kernel+bounces-536081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 708D9A47B40
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 12:07:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A43A18926FB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 11:07:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 951C023027C;
	Thu, 27 Feb 2025 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txMUeTzx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F7822B8A6
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 11:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740654238; cv=none; b=ZgDtL0ghqOn197mecRqkQFYGh1cnXiyfvBcDoyh/34W/WXmcdKqj8LCBR6ViSAfvwI5ii2s/hGiDaWfOdDAotvXOGVhjPZo23P+9XQATjaXVOtFYkRwzk2TtUw8U4aT/4mjcDDv/tKxGuJWXSUq+MCYagayeH+x+d98mYUDBShU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740654238; c=relaxed/simple;
	bh=Al4AdoIOAFP/tQuO9hNkATwo+NFCoCFaFs1W3IlU+a8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTeGhE1ATspIeig0L/BWibQW8DuGdlqAA7xmv826lTI4H4k+yJOtmn8p/1sWJVVRPsMwbAiNSfFk7bpXLuOkJBpwTKkJzJVllY8P8nu1ObH29ehKmEAvP7aJ8qCivlrBFwPMcUYwYSY0SmbRaGsn/+BtZaxIpCJToO3V56UGDaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txMUeTzx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 484E0C4CEFB;
	Thu, 27 Feb 2025 11:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740654238;
	bh=Al4AdoIOAFP/tQuO9hNkATwo+NFCoCFaFs1W3IlU+a8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=txMUeTzxnpdVEOFl4/GII3ffChRPOrMs1sz3YttLbs2s0x7ibVenfpykLCWfJpG90
	 rM7Wn4x+jtUErqzfhLtgJE0RjXKUboq1BrjcFZqFuNS0Le7udqQBXztEObx+SSVU2X
	 0645mHlcYyXNWi2orB9X8+OeqFHCquDK0J0Ljy7n0bNscIULYuOtdZfeFqMBsjjKXA
	 PAZIeVKZo3FldINwIldM4fdxFDVRRKJAwPd5kY89TRRFekQgohvSUzHs5q/LwPZuSB
	 DXFfHtVgLw01bHzUW0BPbJtBELvvF7nOJ+RShlb/NMFoyYiEbTO3RnK8xDyRM5XJ3N
	 ahcy9k2GIRZxQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab+huawei@kernel.org>)
	id 1tnbgK-00000001mRe-1utA;
	Thu, 27 Feb 2025 12:03:56 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>,
	"Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 17/21] tests/acpi: virt: update HEST table to accept two sources
Date: Thu, 27 Feb 2025 12:03:47 +0100
Message-ID: <9d57e2a6ec3f523eb7691347403f05ad40782b94.1740653898.git.mchehab+huawei@kernel.org>
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

--- /tmp/asl-38PE22.dsl	2025-02-26 16:25:32.362148388 +0100
+++ /tmp/asl-HSPE22.dsl	2025-02-26 16:25:32.361148402 +0100
@@ -1,39 +1,39 @@
 /*
  * Intel ACPI Component Architecture
  * AML/ASL+ Disassembler version 20240322 (64-bit version)
  * Copyright (c) 2000 - 2023 Intel Corporation
  *
- * Disassembly of tests/data/acpi/aarch64/virt/HEST
+ * Disassembly of /tmp/aml-DMPE22
  *
  * ACPI Data Table [HEST]
  *
  * Format: [HexOffset DecimalOffset ByteLength]  FieldName : FieldValue (in hex)
  */

 [000h 0000 004h]                   Signature : "HEST"    [Hardware Error Source Table]
-[004h 0004 004h]                Table Length : 00000084
+[004h 0004 004h]                Table Length : 000000E0
 [008h 0008 001h]                    Revision : 01
-[009h 0009 001h]                    Checksum : E2
+[009h 0009 001h]                    Checksum : 6C
 [00Ah 0010 006h]                      Oem ID : "BOCHS "
 [010h 0016 008h]                Oem Table ID : "BXPC    "
 [018h 0024 004h]                Oem Revision : 00000001
 [01Ch 0028 004h]             Asl Compiler ID : "BXPC"
 [020h 0032 004h]       Asl Compiler Revision : 00000001

-[024h 0036 004h]          Error Source Count : 00000001
+[024h 0036 004h]          Error Source Count : 00000002

 [028h 0040 002h]               Subtable Type : 000A [Generic Hardware Error Source V2]
 [02Ah 0042 002h]                   Source Id : 0000
 [02Ch 0044 002h]           Related Source Id : FFFF
 [02Eh 0046 001h]                    Reserved : 00
 [02Fh 0047 001h]                     Enabled : 01
 [030h 0048 004h]      Records To Preallocate : 00000001
 [034h 0052 004h]     Max Sections Per Record : 00000001
 [038h 0056 004h]         Max Raw Data Length : 00000400

 [03Ch 0060 00Ch]        Error Status Address : [Generic Address Structure]
 [03Ch 0060 001h]                    Space ID : 00 [SystemMemory]
 [03Dh 0061 001h]                   Bit Width : 40
 [03Eh 0062 001h]                  Bit Offset : 00
 [03Fh 0063 001h]        Encoded Access Width : 04 [QWord Access:64]
 [040h 0064 008h]                     Address : 0000000043DA0000
@@ -42,32 +42,75 @@
 [048h 0072 001h]                 Notify Type : 08 [SEA]
 [049h 0073 001h]               Notify Length : 1C
 [04Ah 0074 002h]  Configuration Write Enable : 0000
 [04Ch 0076 004h]                PollInterval : 00000000
 [050h 0080 004h]                      Vector : 00000000
 [054h 0084 004h]     Polling Threshold Value : 00000000
 [058h 0088 004h]    Polling Threshold Window : 00000000
 [05Ch 0092 004h]       Error Threshold Value : 00000000
 [060h 0096 004h]      Error Threshold Window : 00000000

 [064h 0100 004h]   Error Status Block Length : 00000400
 [068h 0104 00Ch]           Read Ack Register : [Generic Address Structure]
 [068h 0104 001h]                    Space ID : 00 [SystemMemory]
 [069h 0105 001h]                   Bit Width : 40
 [06Ah 0106 001h]                  Bit Offset : 00
 [06Bh 0107 001h]        Encoded Access Width : 04 [QWord Access:64]
-[06Ch 0108 008h]                     Address : 0000000043DA0008
+[06Ch 0108 008h]                     Address : 0000000043DA0010

 [074h 0116 008h]           Read Ack Preserve : FFFFFFFFFFFFFFFE
 [07Ch 0124 008h]              Read Ack Write : 0000000000000001

-Raw Table Data: Length 132 (0x84)
+[084h 0132 002h]               Subtable Type : 000A [Generic Hardware Error Source V2]
+[086h 0134 002h]                   Source Id : 0001
+[088h 0136 002h]           Related Source Id : FFFF
+[08Ah 0138 001h]                    Reserved : 00
+[08Bh 0139 001h]                     Enabled : 01
+[08Ch 0140 004h]      Records To Preallocate : 00000001
+[090h 0144 004h]     Max Sections Per Record : 00000001
+[094h 0148 004h]         Max Raw Data Length : 00000400
+
+[098h 0152 00Ch]        Error Status Address : [Generic Address Structure]
+[098h 0152 001h]                    Space ID : 00 [SystemMemory]
+[099h 0153 001h]                   Bit Width : 40
+[09Ah 0154 001h]                  Bit Offset : 00
+[09Bh 0155 001h]        Encoded Access Width : 04 [QWord Access:64]
+[09Ch 0156 008h]                     Address : 0000000043DA0008
+
+[0A4h 0164 01Ch]                      Notify : [Hardware Error Notification Structure]
+[0A4h 0164 001h]                 Notify Type : 07 [GPIO]
+[0A5h 0165 001h]               Notify Length : 1C
+[0A6h 0166 002h]  Configuration Write Enable : 0000
+[0A8h 0168 004h]                PollInterval : 00000000
+[0ACh 0172 004h]                      Vector : 00000000
+[0B0h 0176 004h]     Polling Threshold Value : 00000000
+[0B4h 0180 004h]    Polling Threshold Window : 00000000
+[0B8h 0184 004h]       Error Threshold Value : 00000000
+[0BCh 0188 004h]      Error Threshold Window : 00000000
+
+[0C0h 0192 004h]   Error Status Block Length : 00000400
+[0C4h 0196 00Ch]           Read Ack Register : [Generic Address Structure]
+[0C4h 0196 001h]                    Space ID : 00 [SystemMemory]
+[0C5h 0197 001h]                   Bit Width : 40
+[0C6h 0198 001h]                  Bit Offset : 00
+[0C7h 0199 001h]        Encoded Access Width : 04 [QWord Access:64]
+[0C8h 0200 008h]                     Address : 0000000043DA0018

-    0000: 48 45 53 54 84 00 00 00 01 E2 42 4F 43 48 53 20  // HEST......BOCHS
+[0D0h 0208 008h]           Read Ack Preserve : FFFFFFFFFFFFFFFE
+[0D8h 0216 008h]              Read Ack Write : 0000000000000001
+
+Raw Table Data: Length 224 (0xE0)
+

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 tests/data/acpi/aarch64/virt/HEST | Bin 132 -> 224 bytes
 1 file changed, 0 insertions(+), 0 deletions(-)

diff --git a/tests/data/acpi/aarch64/virt/HEST b/tests/data/acpi/aarch64/virt/HEST
index 4c5d8c5b5da5b3241f93cd0839e94272bf6b1486..674272922db7d48f7821aa7c83ec76bb3b556d2a 100644
GIT binary patch
delta 68
zcmZo+e89-%;TjzBfPsO5F=rx|6eH6_Rd+^#iMisuTnvm1|Nk>EGJ@nLCJHmL%S;Ru
WnV7)J#lXPAz`)?Zz#=g*R~!HcF%5eF

delta 29
lcmaFB*uu!=;Tjy$!oa}5_-G=R6eHtARriT=I3|_|004Ge2nqlI

-- 
2.48.1


