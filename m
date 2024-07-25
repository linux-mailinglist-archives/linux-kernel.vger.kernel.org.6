Return-Path: <linux-kernel+bounces-261732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F235893BB6A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 06:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B41242841B3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 04:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2F3C1CD29;
	Thu, 25 Jul 2024 04:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b="qDPEp1JD"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2101.outbound.protection.outlook.com [40.107.20.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7472118C3B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 04:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721880781; cv=fail; b=J+wGVnXAdgAAHnxJ+WG8bUysvUQK2tvOJKWZ5gNeStvSnMLtxtu7H2Yb3hZjMgb7t+kS+sPF652gzMNev+cFLr4ULvlDOu2g8VblwuDqoCZu5oF6AJbxIINHFj3sKXH6NPIHQycyLMZ4l7HcE7vpNneBnpmTV5oJHnVJvOHL3Bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721880781; c=relaxed/simple;
	bh=1ccXhxr45YPT9zvbQ/7hJCz5Hsgfy9YgFZTYZkQ6aXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LlIWVu31UYDJ27fGedItTWCz4uiYlD4NrjVpWEbtYL9tU3aec/X5bMpYgnqbYMUuqc29p6LK+9wmzwie//5XLrOn1TaBDH3H2ub2ukLnZNlXLaWkA0Hf6nqIen0bpu7YGCMPGbMkvvWIzl0cKR/iEzIHL6clOgwuGmIg1dJJiN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com; spf=pass smtp.mailfrom=virtuozzo.com; dkim=pass (2048-bit key) header.d=virtuozzo.com header.i=@virtuozzo.com header.b=qDPEp1JD; arc=fail smtp.client-ip=40.107.20.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=virtuozzo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=virtuozzo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWeAX2kNmshj3RCAq171tmuHWdWVcuHKAB/z4cjAyxKpKIgobmEjPj7OBmfSYAZpyxDW5r+J/65BI3umEcy2CdPdFikF4U1EeBMIETpGtX/N39ubIg8WdXUtokeUCU5nDgryjulgF0lHDvbErLrGBhOu0c3zInIFVYCTJ0yfu0LwNQltdWrW2l3bvQSdVJQTV3FglPrJN1n2Ump5QcD0kKsSEdU211yoITD/4Kodw9gxiCb4+vH7imWlVI7/rq9D6P6VobbRUYfGXcQMtbtZXEKCZFl1Pz7Vju4o7OsG23+xfLHDU2nrGVsdWq8z6s44XZMl1oyoDVS1noBa81BK5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2AeXbBCxj90LaZ2HeuIwseUzMSII6/1xQ89cs3jkL5Y=;
 b=C+jf1VwjYE3AxPGfSMUpF3CJ+LyevocZTGVtoZyWt25HVi5w7julmZXIvUZErplnJnKrHYia8iIOHywggmbaEDlh4dBfa8bGXgzIkJL4ZjAxF7WahcyYUQf3nDIPbXo2a++G5BmEcbuiegioushMKKi25KjsuUGg/H0gYZQ5RJxqRjGPrP8KHZa2cPMZ4R2iekpYgW3EcjiT+WCQEvxG668VuFyPypdwuaxDkfZmwo7Brxvzv5UGkd9wZTw1RzFpb6pY0NSrGLkrYmLMmqUWp497ioXXN04/T7Azp3xSv8KVDytoK28ZUosHxL4+cDvokbEQhAlUoudbrhslum3KSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=virtuozzo.com; dmarc=pass action=none
 header.from=virtuozzo.com; dkim=pass header.d=virtuozzo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=virtuozzo.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2AeXbBCxj90LaZ2HeuIwseUzMSII6/1xQ89cs3jkL5Y=;
 b=qDPEp1JDVHX0mhFKI0qItgoeiqYJiCKA7h7nFcdkzDnE/0VLbpMGxXwydhQ5FU6E4yXXHiU3MOVkqQfSUyYZtHsNo+vzDlFXMoDjV2YgQ23VwQscXEeGoYjTphsIR+NbkFs9MlkcoxMpPsZzOLg/FxDAQqw9KtaYIw/+s7KrU0TBmuqkkdK2Nl7RYgn+yqR6a2Ve9PVmBoo9QY99tphmez4vdixcaTri2lHQT39R6sT1vwkYPd/5rlv7aiuEkShVj4dzswX/8FfeTd5x1dzcifaHw+IPyIsY7Ph09qXuPjVRJyjnd6rU3oQ4E8IPdM6ScnF3WuTOF7ccmzE95hOg6w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=virtuozzo.com;
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com (2603:10a6:10:471::13)
 by DU0PR08MB8788.eurprd08.prod.outlook.com (2603:10a6:10:477::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.16; Thu, 25 Jul
 2024 04:12:54 +0000
Received: from DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce]) by DU0PR08MB9003.eurprd08.prod.outlook.com
 ([fe80::7261:fca8:8c2e:29ce%5]) with mapi id 15.20.7762.027; Thu, 25 Jul 2024
 04:12:54 +0000
From: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Wei Yongjun <weiyongjun1@huawei.com>,
	Chen Jun <chenjun102@huawei.com>,
	Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
	Pavel Tikhomirov <ptikhomirov@virtuozzo.com>,
	kernel@openvz.org
Subject: [PATCH 2/2] kmemleak-test: add percpu leak
Date: Thu, 25 Jul 2024 12:12:16 +0800
Message-ID: <20240725041223.872472-3-ptikhomirov@virtuozzo.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725041223.872472-1-ptikhomirov@virtuozzo.com>
References: <20240725041223.872472-1-ptikhomirov@virtuozzo.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: KL1PR0401CA0003.apcprd04.prod.outlook.com
 (2603:1096:820:f::8) To DU0PR08MB9003.eurprd08.prod.outlook.com
 (2603:10a6:10:471::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9003:EE_|DU0PR08MB8788:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ff66e0e-d3f9-427a-7dd7-08dcac600eeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|52116014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oWrM6umRGuX+BNJPoRfBGg0RpFNefsUVq6MTPYQtj4SvkZynSgkaOqh5Ens1?=
 =?us-ascii?Q?7OdmhBaGap3aYY/Gqw3U1zjJO9gH4Sh7WBJq4tOBXAKcXR1dmgVz1ek+knhy?=
 =?us-ascii?Q?sCcsd8sfkQcbdX6c3KBBsk/rO8wNq/U8xBF860zr0QFNdNEWZplV+i3TFOiU?=
 =?us-ascii?Q?ZsxjUyNrHxjOGKhr1k3WoimrOawvm/EAvZbomcXKuNUyib7WaF3gzP52Bjd6?=
 =?us-ascii?Q?le3ai2nE4uFhP5bXJJ6YloXP7e/Zl/o/EoTiiYsLtxcP3K7PsM/o6Efx7ZPO?=
 =?us-ascii?Q?EwUjZ4mqwxscghSRHJKLUpW27tA+k4QkqCDypDmrBqjTAMBLwSKXwajj3TBY?=
 =?us-ascii?Q?e9Y1IAMSSDkKXZapI6twzmyhHxwkpvzx8PlGx3tNYv/yWcJkMOlhH50Ru0dO?=
 =?us-ascii?Q?GP07z7hAzQx+CXEwo43GQZlNBGQhfFRJ8CcX3OnDDRY29Xk7Hdqj2WQglc4T?=
 =?us-ascii?Q?uBMUNzwLemOLPQps8nU/vARaPrFlatEe2F3iG9P5e3A7ZRHkXXlK8cJJhY6e?=
 =?us-ascii?Q?Ipx+eEG9t9J9O2x1ZmojhKJWQBCE2SYEuJVsnjWwgs21uCruMdqOtdElaQAa?=
 =?us-ascii?Q?LrOpAfY5T3wdKO4fdysL2hTljixBEu1Ym6RV6vQTviH9p6f2W1CfxMeA/lm+?=
 =?us-ascii?Q?fsEOT7jYXwaP9+ukPDPhmFOBiC0CBKI43g/DsVZG7wamtmX8EzxxhzIRq1Rw?=
 =?us-ascii?Q?gdbHtSy/OnZ9Cp7N1FNmrgg49gJlliYMNcCK9UfFmgtXjBRmsSnDBf37BcxJ?=
 =?us-ascii?Q?yhSdpoHacpHqbiWq1/TqJxgRHdS1ormEdP1CxOcJuSxbr8NsfS+P0YobWkhD?=
 =?us-ascii?Q?0zikNgRd1yZ6R7+ZJdMI3jBTsvcK9bo9jCBCYF3GNubCcZcY7rvMWxRHH9Qu?=
 =?us-ascii?Q?rc28iY5jPCD2TVigH8tRmQ9ZsrXIqTrJz1+qygJB2JxhiTJLgA4/H+owJ4zL?=
 =?us-ascii?Q?AzuV0QS4L3Fh52C7BzhHqAfFjHLY+s5G3hOITAxNA5chz+RY8VBd4v6JLIeC?=
 =?us-ascii?Q?vqdVunTxj8MoCesY4eknI838nR+XOu2315KmD14fePqbKERBiLrzyAw3Qyjn?=
 =?us-ascii?Q?Ba+F8/jhmEPTvfBSQSs8Kz+/OXJRXoSlgPI/wGgcw7X6OBJmdsFPXoLt2Tuc?=
 =?us-ascii?Q?+KP+g9pPjU01fmdbfVXOroRTu1GyfO+WosO+wjKu76Eiw/tDzxfucWFOltwb?=
 =?us-ascii?Q?0/UKgkB72Um5T11Zr+BhgaCsxjrYV/hTRAgoh+fIMBlPDUrX8jw5OJMbOt0j?=
 =?us-ascii?Q?9wN19TfTUcFg2/iu5tmFQrcadlCEafgqk1/0P4VvJohM9CW3djAIDix3ssTT?=
 =?us-ascii?Q?C2gCAwCcOWTjK/dp4ucebGNYbx+V3UK85IdP8ctP0CCIwQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9003.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(366016)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Z4wWr+metem0glRNrypD47wn5W+PSn1fg0ZWe5Id+KjTAElgCFbjX/spkfqr?=
 =?us-ascii?Q?qD9fljtXHecvG3cvEAhq3eMq5ilCbwmuxp2SFkmOrGFDM6qdlyge0wBfRnfw?=
 =?us-ascii?Q?5FORB2KY0Y+4/pd37e4asD4ZGMfldHq+CSrxPQJR18PCTKhYP8yHXewH+1pe?=
 =?us-ascii?Q?EmaTG/vAUW0q4ZzCRfSyweGbRY2glgUVYq4K2K7CQ4ewm/Aj0gIfbNJjknJa?=
 =?us-ascii?Q?kqp7vw2uZYeHfoEDPz7PBefUMYLn2BGXuA0Jc3Fxbb0g8fMdpANI1+eNpzOh?=
 =?us-ascii?Q?YMzjhS+6OcZZOmSzJUdWZqEF6VNPWTRal76BkitY7lio/cPFRo4I793n9cfn?=
 =?us-ascii?Q?/nQM65mdJihGzsgg5W3UigFY8Oi9UbKiZ+lEA8jG0QyR5kdcjoAh+3U/QjYn?=
 =?us-ascii?Q?TZBw9dBRyaYKeHHUrUC85TfZN7U75nUhx98RGxMBGwiNqxQ0CvbtA5np7+8r?=
 =?us-ascii?Q?yQftvENsbM7AdXIYTDQirRBht0kJNSWH2Ni7qWAaD7o/jOFgf/ukXs21Ohbg?=
 =?us-ascii?Q?z8LS7axFgM8bAYhZHM2h2EympqN/hFLVmZJD3DIALxd6xI6Nuvorv69CzWXc?=
 =?us-ascii?Q?5egkYR+A+I2jat2nFTTFzMnbYdDZGE1/meNiNNvW/21SFth/wbWa8M+LhJIb?=
 =?us-ascii?Q?NW3tfGN/IcfIyzNrMWhLomirZzKZyLqS9Fjb+YEhWhlEAQW1MwGstXb/xDGX?=
 =?us-ascii?Q?7ByK9LSAfJrM4SGdI+zrNDHAdKTkEFmTWwq2zIYlEnLr6LM9JyttD+Amt0V6?=
 =?us-ascii?Q?lpRd/CLfNWtFCWi+O6+LfkRyFqxbOvjhhn+SpLongepTkfz2McA4kOp5XJgU?=
 =?us-ascii?Q?c4QasuSOUIqNfDJZLu+TPtcWCOYCCtjy0E5XBQpyDpybx9BpjvImGqZJoZBQ?=
 =?us-ascii?Q?5Zqdv9w5VcPIWdFOp9XAcbiv9nr57WaVNUmAdk5kATT8k6ApsVgJQs1n59gl?=
 =?us-ascii?Q?IQ0mN588d4SS7Pd5GTMF6I+WLvh3ZlLSdt+6CJ8G8fqhSJFB8n0EaEqpjks0?=
 =?us-ascii?Q?NBa5jsMiRMGD6UUy9pEybkZw4oitwjjIFFBv8QkuL/yjPrWSE8OAfFVVdbfh?=
 =?us-ascii?Q?8vNR4bRheon9H+RWf/Z8Pz384qyKHGavT+r17X3a4vWo+CNsG8rwe0chjZk6?=
 =?us-ascii?Q?L7O366FCFCbD//tlwHO1Lk9pZ/7NqyLseMJMU8QbWqJRO76SeQOoLODi5x8a?=
 =?us-ascii?Q?h6nrlSW4ZEDNIHrDKdhiUFIqYM6uO8pu7zSQei5OMpqA7IzI7BfRz2JxSznd?=
 =?us-ascii?Q?AA1a9rZuzbYwIAYLp77KiCbF0TbKKfieZ9/9r7q5fPebNbYxpd+NALKPVsw0?=
 =?us-ascii?Q?8NoAti4UC3v4acMj3XwR1J6b3i69v+9Rx9buJW4b0rAiLtTtbUuEG5Va3/Ta?=
 =?us-ascii?Q?gJSZP2B5Qa2WwnKGm8Js41nOPQiEhh/VdHwKI4QxDzVa2DSDysuG8Y5YVUSU?=
 =?us-ascii?Q?CQlr0KXi2NSmi6/XD2IfyemE30RlhTVqd8f/8Yl66L8BG5r8TjnHhL++NhAe?=
 =?us-ascii?Q?J1F5dmAbleWEYeFfY5xyZunq97kyJYUHv3rxxU9MhBTWVBN0TO+Wr5rcCZWD?=
 =?us-ascii?Q?XZCmYX/HQMwKiLhvuZ3g7tO7VKvwi3IhY3+YU/tL1r1YpZRe/WoCuv+wjmys?=
 =?us-ascii?Q?OZVLeh70xjV55C2hZw0JsvAMBi4uZdyNEGFe+dnDk92Ua1SB3erJC2IExRtY?=
 =?us-ascii?Q?Mqthzg=3D=3D?=
X-OriginatorOrg: virtuozzo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ff66e0e-d3f9-427a-7dd7-08dcac600eeb
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9003.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2024 04:12:54.7955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 0bc7f26d-0264-416e-a6fc-8352af79c58f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8tU6St0EYov7MYFNFwvAP+s/moCDzSBKBTFWg43mD00zNiEMWL1OjHTa9mE40uUyn+tjroSyw+xNB21M7UNuOfQe2IsS4cTuwQyjR0k0BI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8788

Add a per-CPU memory leak, which will be reported like:

unreferenced object 0x3efa840195f8 (size 64):
  comm "modprobe", pid 4667, jiffies 4294688677
  hex dump (first 32 bytes on cpu 0):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 0):
    [<ffffffffa7fa87af>] pcpu_alloc+0x3df/0x840
    [<ffffffffc11642d9>] kmemleak_test_init+0x2c9/0x2f0 [kmemleak_test]
    [<ffffffffa7c02264>] do_one_initcall+0x44/0x300
    [<ffffffffa7de9e10>] do_init_module+0x60/0x240
    [<ffffffffa7deb946>] init_module_from_file+0x86/0xc0
    [<ffffffffa7deba99>] idempotent_init_module+0x109/0x2a0
    [<ffffffffa7debd2a>] __x64_sys_finit_module+0x5a/0xb0
    [<ffffffffa88f4f3a>] do_syscall_64+0x7a/0x160
    [<ffffffffa8a0012b>] entry_SYSCALL_64_after_hwframe+0x76/0x7e

CC: Wei Yongjun <weiyongjun1@huawei.com>
CC: Chen Jun <chenjun102@huawei.com>
Signed-off-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
---
 samples/kmemleak/kmemleak-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/samples/kmemleak/kmemleak-test.c b/samples/kmemleak/kmemleak-test.c
index 6ced5ddd99d43..a165a4d13137a 100644
--- a/samples/kmemleak/kmemleak-test.c
+++ b/samples/kmemleak/kmemleak-test.c
@@ -79,6 +79,8 @@ static int kmemleak_test_init(void)
 			per_cpu(kmemleak_test_pointer, i));
 	}
 
+	pr_info("__alloc_percpu(64, 4) = %p\n", __alloc_percpu(64, 4));
+
 	return 0;
 }
 module_init(kmemleak_test_init);
-- 
2.45.2


