Return-Path: <linux-kernel+bounces-379595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2159C9AE0D3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 11:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 992A81F223D5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 09:32:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FEE51B3954;
	Thu, 24 Oct 2024 09:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="H/HPsUBe"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2062.outbound.protection.outlook.com [40.107.117.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F83D1B3947
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 09:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729762213; cv=fail; b=ASgHUiNmYiKVHCCf+tkaaseAuWMB7/R3Ufl2zuCGhB8y+VcHKZPWBQ2llDCDCLnIuGxO5Tm7oWB4LvZaDUzQd59RskdfNDrUE0vc/ar4/RMtBgOlwFWUVYPujVJiyUaY5eNVB+yg59xIPxzIsc3TYmjPiq5nqOb/PGM4zTs+Z2E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729762213; c=relaxed/simple;
	bh=j3ZcXu0suybdrDWfjRJHpzFSSLCAYK05L1+Bwx26vUA=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=GTTFPmGZsb4W5qEOeOJXGfNuUE/+/DsUnXwQMOUjV4Q0oePYp88F/a7zamJMPbJqgbQa2SOaEXDT4SE58XBCUQGMRPouI/1m3RaEIs7ITK5MsNZFk/vWndpBWvaelsBL/iT4f5A219XAG8qnjU+1zb13Bwoaq45ZXBIRKohdKQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=H/HPsUBe; arc=fail smtp.client-ip=40.107.117.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxWDMsaVOmDVINFdCfUtHcoyu9ol9RSKPeQjJZgmC4xNUZG4xFIW93PZx1smf5OXDH6gKpUIs97RYJnZ2e1ocmILOqzW7r2oG+z/o92TH0DILc4jJzyW2DBXZZxuAEpxLY8G/d1M3flIO2Y8MyY4ltxgbx0pOyjte27Zw4zCjexhXgpnpI3vHVWkB9XN+CtFuVi0Dh0nr8wOxKWeR4rCctouSO63ZRhzLp5rmmiCCBhc5PTlZLbXQBRPZvLvFQonp4QBn53ZMeLgMG9bNzB09LX6gjHCW59meYIHR9Z1D2BoeqM/WbNgwp0Q9cY4UlxUmDg+XzK8U4WDX6Nd5lv0KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IRTzJUlnMAX1my/a0MDGPKx0wJGki4HmSkYALzvC+sU=;
 b=Fb2hpJirOmiUyHsuvFOmyGgiEkm23piG8knOQ5VmXksR5Tq81Msx0RM38HB+HleM1SyGfu7MyLPFvcIkhhBoEONMpLhPF551lD5yz+/otUX1J08OZk8kcPPzwiHd98DvTKf4aBRrGPgwpiKQvT41V92Qp+I/Kw2lvw6IlQVpNbyNvLwnOHq18+5ubcuKM9ZVnBNlNjcOyFwBV/K6hNybFsEw9eR7aStXcNSB3ct8RAgrf5gBlSih2/sYze22bnJP/mn0KZ6RNI06g7xZAKO9imow0E75OdeJE4stGFc+C82dVg/6Gn2OlNFwDTyrZkW2nv57Kcp9aAdBymEj9uAunw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IRTzJUlnMAX1my/a0MDGPKx0wJGki4HmSkYALzvC+sU=;
 b=H/HPsUBexfbTWnaDtBcnCMCMv903b/4KonpNz4r+tseMwNEI0mGGa1FlygQIOFkndTePkD4MfuRWooSu326trNI/+mbraGzkp9AUyGHCn0pcCf8Hjh40Um5K9uxXerKSJDQAF9Y7u20ICCVR+Mkyo2SVBpJN0FGOn7jjC1Hoc07KZ8Y2oxByt3AWb5u3xMP7qMroyxomAHwwEmvsUnjGz3pXuCiCvZVXpsiUCi4crSeQfD5e/+X1HKqR78+YUKQxfBUlS7HaVyjN77pKQRdWrrJdJA/BhJvgYmIdxWyPK6xEkekMGuYGJ92KLH2tZyEAo90x0mLzdxjigo7YvHPF+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEYPR06MB6154.apcprd06.prod.outlook.com (2603:1096:101:dc::7)
 by PUZPR06MB6007.apcprd06.prod.outlook.com (2603:1096:301:107::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.15; Thu, 24 Oct
 2024 09:30:08 +0000
Received: from SEYPR06MB6154.apcprd06.prod.outlook.com
 ([fe80::2d08:e538:2283:ad7c]) by SEYPR06MB6154.apcprd06.prod.outlook.com
 ([fe80::2d08:e538:2283:ad7c%5]) with mapi id 15.20.8093.014; Thu, 24 Oct 2024
 09:30:07 +0000
From: Yang Chenzhi <yangchenzhi@vivo.com>
To: Christian Brauner <brauner@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	Yang Chenzhi <yangchenzhi@vivo.com>,
	linux-kernel@vger.kernel.org
Cc: opensource.kernel@vivo.com
Subject: [PATCH] fs/minix: Add missing curly braces in minix_empty for clarity
Date: Thu, 24 Oct 2024 17:29:55 +0800
Message-Id: <20241024092957.55401-1-yangchenzhi@vivo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG3P274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:be::22)
 To SEYPR06MB6154.apcprd06.prod.outlook.com (2603:1096:101:dc::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6154:EE_|PUZPR06MB6007:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb22cbf-3025-4af0-d5a8-08dcf40e72fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?23wGqhW+4qXLlYGx47Sn0Pjmxi6HUueT+GqzPmisY9slrdzkOLPOHtJd2pkQ?=
 =?us-ascii?Q?wv9q0g6j5NdpyzujG3+/mJC7+gOv3fudITOoUhYzVV+euDKrElqYwEFK6xFl?=
 =?us-ascii?Q?oeHGpyN4Jv0OUI+mfdR3yLAmfrTqyQsVCZRZVfWSNQnx4FMpxqE8tfvfkdvv?=
 =?us-ascii?Q?ubKUY1l/ljexYypMq68pwxJkzqcXDMI/oSbLEoF8rZK9AuxqRKcIhL9WB94R?=
 =?us-ascii?Q?kmUGUeFmzotI36Iy2pBeQoNWZh6yGS1xv8lzj8VkSEq+PPYcyVQTydU2cp+y?=
 =?us-ascii?Q?l9I/xbTPqZ/yfTK1Umlt6QqhDeDfVo5c81nToseTLDkAdxkNkvGBJPUrdxv9?=
 =?us-ascii?Q?cnrTvbZ3mfBfQ0W6ZEJ7uuMGuXsAXXVFNvVpAp6BPFLPt/RevXqCSLs73kJ7?=
 =?us-ascii?Q?yOOS2qXb5/QU0VoiYK91NMb/J63ICE9WgeweSS5CWIywpOTSGmq2J9sQZkRj?=
 =?us-ascii?Q?oin+G366HLe2HlbQTdzk+7VMEZ+sADU2mZkxQ3IeFw0V/3vPRCqyspXuFHJ9?=
 =?us-ascii?Q?BVEho8J7THu8pgfqI6viRUU94tKEbXC+7DYUZ8+swD3LZ/BIqrYNRCGSbQxV?=
 =?us-ascii?Q?R6ud/Dniw3g4ri1zrFShvkry0JrpZ0jDsQVpZH4RVOVBC/sVTc466JTOfU76?=
 =?us-ascii?Q?//wfo8unYkrn3AfL7wwTqA6oJY20LisQDW54DSWxZz4jc4P7kWU+aCBCHQJf?=
 =?us-ascii?Q?VMnQ5nwmK19IQPaChI+F2OVqjVyOXga1hKXmI5ZVDwRrhOg8EeJ/vVQpOQ82?=
 =?us-ascii?Q?396udzpqJfgK8prqR4uNqug6rnvHi84zXcpXlgooeM7wgVLETPKHt0bWkGIo?=
 =?us-ascii?Q?asavezAL//kDdkNUWLlyzsTQ0ZKjLIbHzidYHjGs6sq5JQ/Z4PqHAGOaJHDS?=
 =?us-ascii?Q?EQIEwk4mBlJHawy6jjl0etRkwBQpuLNdeLLDb5KF5oiXl3OuMYbuz0GvFo9x?=
 =?us-ascii?Q?GPnveDsNz0pG1Ol33oKwgj3PBB5EP8KHJlf0RtAGlaLNXyD2Edmlb6Xd81oA?=
 =?us-ascii?Q?i+Dz+SUNBJMRVaYA1uIMCZo6WF2vHrI0ZkecBSm1VA2xe3guTodj67WP88ks?=
 =?us-ascii?Q?tq9NjFytkVk+mBVdRi0h59keJuGbVlcF6uFlcyn79q7ABwh7XaBIdbInNkfx?=
 =?us-ascii?Q?JBWVpMqL4EpJ7hQbLJy7CD/sLuj/dAiYZkyWEHpfckVREk/onDuV1S/+h50L?=
 =?us-ascii?Q?ttlVbfxI/RIunm8rimjrIVQ3za5K/P9FnAoKvijbLF2sWASs8Cx0x3P4MneC?=
 =?us-ascii?Q?ZXIfcvzIthaR1lGaafQO8Vk4xWbO2hI00AK+z+TRqT/1U8D4gK/IUsEcnSan?=
 =?us-ascii?Q?raMk49YVvXN0aG1SaQngc1yIqVlvM/2bp47s6dVOG+aA42OxDCcN8wNC9K0W?=
 =?us-ascii?Q?n4LIK04=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6154.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?MPtzetp9KPyoMyQHdA38ZrLFPQKxH4Hc9M17jMf0J4O8qt3S7FUOInWNnqHi?=
 =?us-ascii?Q?mqbUq54J9pxaZa0s6F5G+u8UdhiwFLbwRAQo7aVY8FDFHWS/nTv8hSjXsZRr?=
 =?us-ascii?Q?WhEYJTAqHtmKNBDaEkS96D6fpT3aUFgipX9ymviIcD/LhmED5x9pAd4i2h0o?=
 =?us-ascii?Q?InpvuRIGx43vqQiN34muknjMz0BZN7xBj3PqcndkfkmielmXhtjdtcdt0PKp?=
 =?us-ascii?Q?haexBldgNkJEWgYUmUP2lTykwbjjYd/0hdEwrsWZor/uZUZ1CpSzHMUHTF1l?=
 =?us-ascii?Q?zTighirmwNowbM8L6N6EjzY7jjYY1HClR89DbjVSA1iL/c5fhRyoAvrwGe8B?=
 =?us-ascii?Q?BspLcgRRY5MLUSZmt5O5AD8uEwhjXzxbGthVq8DsDvSDfHcKyANXkQhcxNpT?=
 =?us-ascii?Q?FI3LrsnQGEyIKL/bWIO+BWvjlQ/6/Czs5ObwLVtMtlnGAotlg61f6ld7JRsU?=
 =?us-ascii?Q?zPDFrAtY4N4c68vAZ+r767rb84cWuKDvTz17FZmfjSyZ/SnLEz9Uj8dZuIXs?=
 =?us-ascii?Q?84ytRYo2VkkpqzgDSicyF4bdynDiOHkJskqmIyJ4T+5YHz7S14l2kBSg2M8s?=
 =?us-ascii?Q?Ba9UPaoctzX4fxbhUfOsE6VLRCKUYhy0FaSeOio56hihmUrLZQkWJTL+/gJg?=
 =?us-ascii?Q?0FUWY1HacseGMeAHZTm0NjyI/TnfKvxkqBxeUR3wpXNpyN8UcT5SAa/6IJ7H?=
 =?us-ascii?Q?saDxEN1zAcrUAaaHEZmRD3rrNbULPBYvfnbN3GMVwex0m8cblCs43ALbciF7?=
 =?us-ascii?Q?Ir2civ6J5IvxB/7BCHd24dDeR82GuDyYiPIXb+UfQY08M1NU0c8na9jQdxg8?=
 =?us-ascii?Q?W02xltCslxky7imL6Unpz3tKYZ/VpqGpuVt7gPqUHJX4aAF03CnGRodB77kS?=
 =?us-ascii?Q?SzcsD590CQ+b0SEDRHF8oykYJZgDKLbN0x4n5SG88LyBXOSyyLnjOE+k9u09?=
 =?us-ascii?Q?d2UX0qYdcxA/pI0dJf8eIRWFAkpv780WNWFZyjrdNrhGvJ6piy1IVc5vlSnS?=
 =?us-ascii?Q?k9eCRv5i2qWsFa+pO78Q03nxyqoAXCR/8DMLXK/2ZcJF4Y4uB4d6ErZtaz8h?=
 =?us-ascii?Q?145Oa3dHEgmHm9Ey2VssM8zSPIKbegR4wXzGyI78AzzrqfHio0Cco/YTRx/F?=
 =?us-ascii?Q?fEe55dXCDiYz9TT/71Cly0nb9VeqLE9Nan60vHDPpq17PreY1/Vm6k32fSlB?=
 =?us-ascii?Q?MTh8LMdQL5UEIzq0BhJ6CHiEeb1fgo443Xz9QgUZ4eEFqG574I+S4ZKj2Eqe?=
 =?us-ascii?Q?vNGGWm0gcKzrEWs5Eq4OjLmSH3mID5EVf6uBghO/YYTd4HNEFy2hO6+OjEi2?=
 =?us-ascii?Q?/ierO/HzEr4B9eMegiUMiRUsk3IB3cCH0m42YJ2Bu//aWRUnj+1N+v9/FIgw?=
 =?us-ascii?Q?Lxan/7Sa2VQmcS2d7XAy1n2FJ64gU9ZYLnny6ZdmIYyxRDQhmEiAyPwPT326?=
 =?us-ascii?Q?viQ7iRTxsU8gxg5o3mk1EU9h5VNvZFal9Lk6Ftv0Z3deAsaPgZEUAkKiRpFI?=
 =?us-ascii?Q?wqPLMFi1s0snpHmbco3T3mRN6Fi4vbquROpRsBQUU9VDb1ZdvLOorm+wgXvS?=
 =?us-ascii?Q?RUspQjzCkvWZu+i1QNhMvZyAzx9xejQ/IDNpMQTF?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb22cbf-3025-4af0-d5a8-08dcf40e72fe
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6154.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 09:30:07.7838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5o6+Mj0T/QGAS0ThwTXK+WTWqIcYALoIe9FMh2Ml3CgrIxCdkc24EABK5gMJpoxXzE4eQxRRnRxl+ZF2wOg8nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6007

The if-else chain in the function minix_empty_dir() lacks curly braces,
which makes it harder to read and could lead to confusion. This patch
adds curly braces to the affected if-else statements to clarify the
control flow and improve code readability.

This change does not modify the functionality of the code, just ensures
that the structure is clearer.

Signed-off-by: Yang Chenzhi <yangchenzhi@vivo.com>
---
 fs/minix/dir.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/minix/dir.c b/fs/minix/dir.c
index dd2a425b41f0..42e1c46ae729 100644
--- a/fs/minix/dir.c
+++ b/fs/minix/dir.c
@@ -388,10 +388,11 @@ int minix_empty_dir(struct inode * inode)
 				if (!name[1]) {
 					if (inumber != inode->i_ino)
 						goto not_empty;
-				} else if (name[1] != '.')
+				} else if (name[1] != '.') {
 					goto not_empty;
-				else if (name[2])
+				} else if (name[2]) {
 					goto not_empty;
+				}
 			}
 		}
 		folio_release_kmap(folio, kaddr);
-- 
2.34.1


