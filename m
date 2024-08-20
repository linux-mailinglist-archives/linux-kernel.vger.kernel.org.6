Return-Path: <linux-kernel+bounces-294625-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D95959053
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 00:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4BC27B20F8D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Aug 2024 22:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62451C8FBB;
	Tue, 20 Aug 2024 22:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="gQrvV7B0"
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11020105.outbound.protection.outlook.com [52.101.61.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6176E1C8FA5
	for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 22:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.105
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724191982; cv=fail; b=P49DCl9ErpYC+gOX2mWxXkCZWWltluOmuljdGcLQTohChpa8NbIWOEq0UeaM+FCOhEg8WhvA5MAS2SplqEBwQ8TPX1pEM8z4aYDIsQhvbZ/p+4GGpU6dz98GAwvvbK6AWsx55h0cKGES4fRPXuoLNnZUYYNKmFbaN1j4LVN1EVw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724191982; c=relaxed/simple;
	bh=QH+RTTpTHM1fTnugD/1qBt0rrldW2RA7B0L8IlkE0+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jultFvLU3jb4wHE31NzrOmwB5TuR34mh2hhkiIudIucZm1Ev0G/wcbsrP4M9Ruvz05OqHymI6Lr92SxC3tPrqH2YQ+JUFlfE0DlNVRm02xZP3E7SAz7tJXdQu/obm2x9AVzyp5asPk28Th6QUDzoKfznoWWv2bcPtR29GSoln2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=gQrvV7B0; arc=fail smtp.client-ip=52.101.61.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=b0PjG56kfVz7+jl+3PumSRtesBZVZ1JCHxkMN3CXOVHtJGtzrBleyfeTFW1yagokpaVq9ALdqoJcXn/oGaxbUHDnVJajSbjK2LeHB12c28yuFK0fyfFi0KpJArvSonTrHi6tEv9y1kTiCMrwglgGkbVlSrDBXb79XE/PPuDXmVrVCOtS6ZZuaP8PCERwyuA92SkGBPCPb+vrABxgjpl3JAwWN6eMaHJlLFlJ5odpY/fFkPa9qmaHojCzGmhl3NF77P0RvnE7PNEKlhZCtqGZW6so171EPOEDcqNtMWeXyIxF7aDVxpO7l4p+AvkxOO//bhrMFmGewPcyJVtEoUPC7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Up8oYOdUqUbJ8V5PhSx7H4xBdKnUqIlNEUAaNoMj85o=;
 b=vlz8sSoKxuSKvkoNf00eqbZ7nZ5RflK9uc4u7Ms2nEf2tyf+fa/UncR7UzhgBOoILV1G+ur6uYc/56uEwaPnsjXscbCc0PKzqrnVFZhG/cYd1HXqhB8s4iKkpoeGEHI1lahGe96TzkRWrW98YrOjQ8GooVzRnxKybVYDI9J3zdFEYUSPdoYovXgSUiG8OYj45j0UxcjuELGN08KDfmxdeTzxet+KVLGUZB4TvXsJBH1FTI/PfTGURuHeOkp5QHv6HBNJ45GXV2hlMYR4j3mH6yINkvITRDAS9JcAFwJi5ZXhAAVlVQB+7nN4kECedsZ6qi3nURwBoML9z8JGHcmWdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Up8oYOdUqUbJ8V5PhSx7H4xBdKnUqIlNEUAaNoMj85o=;
 b=gQrvV7B0SqlGkiyksOTHgUvy2XR+0Tr+/Ix42zCmVA7TtDjtVqOfLT5gijltIvzUFxTrfuPQA5xN2jJMwalTv8BeNaYN8hBFdlh5oZjakJuPOgwLt9+/0PpAd1r46G8BPMR54NLreauL1m53o8OHZUYKXZS5QVEdUPN6KfKc9ns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH7PR01MB8146.prod.exchangelabs.com (2603:10b6:510:2bd::18) by
 CYYPR01MB8601.prod.exchangelabs.com (2603:10b6:930:c5::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7875.21; Tue, 20 Aug 2024 22:12:59 +0000
Received: from PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4]) by PH7PR01MB8146.prod.exchangelabs.com
 ([fe80::2972:642:93d1:e9d4%6]) with mapi id 15.20.7897.014; Tue, 20 Aug 2024
 22:12:59 +0000
From: Steve Clevenger <scclevenger@os.amperecomputing.com>
To: james.clark@arm.com,
	mike.leach@linaro.org
Cc: suzuki.poulose@arm.com,
	leo.yan@linaro.org,
	ilkka@os.ampercomputing.com,
	coresight@lists.linaro.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	"steve.c.clevenger.ampere" <scclevenger@os.amperecomputing.com>
Subject: [PATCH 0/5] arm-cs-trace-disasm.py/perf must accommodate non-zero DSO text offset
Date: Tue, 20 Aug 2024 16:11:36 -0600
Message-Id: <cover.1724104248.git.scclevenger@os.amperecomputing.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1724104248.git.scclevenger@os.amperecomputing.com>
References: <cover.1724104248.git.scclevenger@os.amperecomputing.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YQXP288CA0033.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c00:41::30) To PH7PR01MB8146.prod.exchangelabs.com
 (2603:10b6:510:2bd::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR01MB8146:EE_|CYYPR01MB8601:EE_
X-MS-Office365-Filtering-Correlation-Id: 6598503f-a6db-44cf-d452-08dcc1654019
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TLyw0X5rA56z4Ixe+SrNGduNdQ5KBn36SNxx2wLwgLc6wLvq7yAW7pKe+1LD?=
 =?us-ascii?Q?tAVNZBtaGXYTSNRZDPZp6R/s57pVXW+jhfWDD8vE2IdXICQYjERUs2sDqe9J?=
 =?us-ascii?Q?TIvbhx55AjpwN98r+LnTKMQWI9DqlWjg1T58ZfC+terKXu62l2MSSIGuFogf?=
 =?us-ascii?Q?zxdNiS0KibEObePuePanQagtdu2BHzEjDc9lzxk/yGgHKx0oQXdf/Vm6PZ65?=
 =?us-ascii?Q?mIBAPhpKzbH0nMMz+tZBZF9GYP+QZR9Nq+qxbrfQwzb7Zf6QlwfQ0WaIO/uR?=
 =?us-ascii?Q?kwYlQcW6dOerFfQRcquXayqKiA+rHBHBngEXaXofzp+oDZwYK9RuiYf4BNbz?=
 =?us-ascii?Q?D4NiWjweon4nKSBxJS9bxywFrtXPwS7zM6zJmJVgJCqkfYYS+4Id2s8YRe3i?=
 =?us-ascii?Q?raKSL07nR4aV9mz9eOpSCswhWkNU/JE5eScVwYGLTSuMN7qCZ1Tayx2lNtP1?=
 =?us-ascii?Q?9GP0qVQkFoGVyTWRcopnMtuPzXcmY8XlSRgymr5itroyRB6Sws66IP0L1vR4?=
 =?us-ascii?Q?9pZLv8rk5/KT2/kcauo7edHNpUUCd80BOKDF7pE+O9zauH67qWGcK09qUpG2?=
 =?us-ascii?Q?Mf9Ezl1pjQ/WJZ6IbG0GvMPTEChloKPCsHYMyG2nqz3uKzYBvIUK3VoxzDU7?=
 =?us-ascii?Q?gjHDacO9F/l7Ism0B7nyqIvgInkS+NQfjtN8xEPZaCFELOToDBaeUzQBKD3F?=
 =?us-ascii?Q?zvWH4sGtHWuXDSMh89B4/UMyQCKR4pTbvu7LQmFJiFFpal6kVMOYerlTkeUA?=
 =?us-ascii?Q?Re6mF6lHveQooltt6STgnUZlcA+f+/HoimHfyNtX4NVGyAmQBuyxUcvhSPLJ?=
 =?us-ascii?Q?JJWhJDs2cgeoaL38sJnJfvXourDIiJODskAshPR7qlJq7nJnbVLsmuxZb9Zp?=
 =?us-ascii?Q?7uHwhbK3O6ll7iFJGtxdwCdQZO1jDJOxeheJttGgZ/6lzK/POxFdd/+gwB16?=
 =?us-ascii?Q?8LzbMQ4VY2/7qSsl4dZN4E2p0DIA21UkOYoSj9FI9/qJhSe27FwwNiheneMs?=
 =?us-ascii?Q?tV6Eb4//RU9ytO+Y2e8jEloC4rVyTv7+AVW7rEFPTLLkUYGRpKJkE5uZJBvp?=
 =?us-ascii?Q?vSrDG9bHKAkcYYKXKscmO9DlQ0WfLocB5Rkqwpr5ov3fW9FQ35UMr2j+yVf9?=
 =?us-ascii?Q?voiSdKCJoDesnP7eRfqxD0YpITYn6hOj0RVTloSHYKkDRUJWDxYDN8+BbYvA?=
 =?us-ascii?Q?7ag3UdBX89QRq+L7ouEVQNJn0n9XfCgM0FokH2ZiP7HgX8bf0MsTSOEq00sO?=
 =?us-ascii?Q?gA6Mt7sx0Z5R2oUADmH/O34wJR+g9Ka/iu1NW67V2/MD1lyJksAHDP572jtD?=
 =?us-ascii?Q?SvReKQMWv2UXZ2DVzxjkOrclpcLTZG3uRC3ehkhISEhw6A66LDsbSdGpLrdD?=
 =?us-ascii?Q?ZVBXouw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR01MB8146.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aD9A66WHBXj/fz0a5hCFs6WgNH4MaxnH8KA/rU7tf7L5Ab/owXg2C6yoFOfQ?=
 =?us-ascii?Q?+TVZEMgV4PVVZl3/bGEKNMVQZINxzg3rE67BNjKOWA72s7U+AGuUlzY0rTwR?=
 =?us-ascii?Q?S5PiSwOEVMPilOM2OT1s8BEMFJv83JQ9it+bc2dBm+ey2vplaZXlk6DvJdhS?=
 =?us-ascii?Q?Dfl9Zm7TkxxmB8mRHqgXNSlZedj1nXCQL6UX9xCXs02hrGU2ApdNr/aipu5V?=
 =?us-ascii?Q?L7ppoRn7HXwtnPTP9keCjigPfbbKgqKGlfQtuufxmTX1UJBPNMQkoHzS3Svp?=
 =?us-ascii?Q?kTlhW3aUGtVrpX6HixjPGTpdRhhm3TAzpx8jiA+vVvEmCFO1jlZIN/z2yvSI?=
 =?us-ascii?Q?SyzQNufX7NbRTHQV8nbxLXoJwlHijAWWSrgp7SoKlPQagZ05QteP8yVNXSjY?=
 =?us-ascii?Q?FzWJCEY6Trdvbp4HkZeYPAUvsAflHkV4NBpD6na/F27Ps/1ymLZJQWYz8erh?=
 =?us-ascii?Q?j+BtrFEXzxsPaUE/KKnvxjpqEUHqKgDQYA4siLPMnothWqqLwxbD3IEyhpGO?=
 =?us-ascii?Q?dvrsciRt4c6mYSItGQZ4hf4/DEfMRQoKIGc/KIM3coJz0pVBp0Q3XNuSLp0F?=
 =?us-ascii?Q?Hy5UjWd9fNKVFf9LeFITdMrfVrKMrI5/9gHew9Iw+qVfztaXP3x0I5tDEalj?=
 =?us-ascii?Q?qA8IvnSglOkXQHg5EbobiHsggZYcRY/SdIQkXpJGIAugq9u3hlsfmAaOYILh?=
 =?us-ascii?Q?iScmmtvI5lgL2PtC5Xuys7Ms2ha10jSxZlwEtpSw41YmI0sii92Yqfad+gmx?=
 =?us-ascii?Q?qS+30j5FPK3rTeg1TqkOFwpoC5ZJPahKDcn1iA7patEWjxvNApzHfcjSSDjh?=
 =?us-ascii?Q?sPVEeoTP/Q4prsFthaxqha3Ohjta7SrU0xQZjKYgCDpuT7pqRDWL5tou0C0f?=
 =?us-ascii?Q?LZFbcDSSKcP8X3jTy9MxMWEoNHvG/fWZ19B/dMfigk8iNh9RR8XlE1syzUKO?=
 =?us-ascii?Q?WArGOwxYiE6DGErHci21QwAYnZivfPLJE37aokBacf8E+ZBg7YsRI6Jc5q3H?=
 =?us-ascii?Q?naozPEN4Z/QlP91/IhRJ+DR1jX97f3GZMRyH/CAllxLzPa8hD5BojIVvavnq?=
 =?us-ascii?Q?Ekdj/Apr4ZV/6rLjKGiRVQPwZgpUWuWQhKyncqMr+ZXq5ibhOHwwU8Xu/Ul4?=
 =?us-ascii?Q?hkZXkJV+lr5Db8YCxcuy7UHVKujLq12xhIke/hbCfGC4KluN4IhOq+reZOYX?=
 =?us-ascii?Q?6rPAkfjconI6g5rmPfV0SF2YMOxk3tsvJyT/xX9K4gedGpkzINhiaWclnBRw?=
 =?us-ascii?Q?pCJ3r7ZNI5L6bSM44fmevlICUAOEmnxsH/f58FZ5I0/OOYHSS0wtYZ/Gc4tG?=
 =?us-ascii?Q?vcVtShup0AU3SwbGfyCII9nJ71s/JmR0hc6oWcIEW0GCOduzA7xBjXgN9oEE?=
 =?us-ascii?Q?t9tBmVW2KGkQFXfCQ2i7wrKR3h0KPDeoU2pfILgOnasp2+zWA2LY7EsUr3Ul?=
 =?us-ascii?Q?0HYo4O5rD9yCWuhxRnYdRCUpKgRT+nzS3ft38GLOxCpjL+sbH3eHwNc6fWUN?=
 =?us-ascii?Q?xsmcLxD459HTRc35lRqXe7A7ROpZZU+pEpVCHcyryp4VEmbX8zujvVz2/Sqd?=
 =?us-ascii?Q?/xIu8LOfS+7MRaorRn69PbY14rVyCgbHJzrxE4bG8q6FqDlEm1aVx/L4MdtP?=
 =?us-ascii?Q?Pd+yvQZsJUa28S7Bliv1wVBKhAAt+lT8XWrYrOMUFwSk?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6598503f-a6db-44cf-d452-08dcc1654019
X-MS-Exchange-CrossTenant-AuthSource: PH7PR01MB8146.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2024 22:12:59.3126
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sr/4ljJRY5Fi02Grc327I6+FFB1qcaui2gYBTzdbABy53yLmKB2aor1mtQxfFisXjmOTW/pULYVxBt7botlwAyeZqNtYuUC1i+NGXy1bXUPiB+2Z5m59A4KcYB+EV4L6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR01MB8601

From: "steve.c.clevenger.ampere" <scclevenger@os.amperecomputing.com>

Fedora 37 distributed shared binary and executable mapped files show a
zero text section offset. Starting with the Fedora 38 distribution, the
shared binary and executable mapped files show a non-zero text section
offset for some binaries. The text offset parameter is never passed into
the arm-cs-trace-disasm.py script to allow the script to adjust the
start/end address range passed to objdump. This adjustment is required
to correctly offset into the dso text section. Not doing so results in
an incorrect user instruction trace display for Fedora 38 (and later)
user trace output.

steve.c.clevenger.ampere (5):
  Add dso__is_pie call to identify ELF PIE
  Add dso__is_pie prototype
  Force MAPPING_TYPE__IDENTIY for PIE
  Add map pgoff to python dictionary based on MAPPING_TYPE
  Adjust objdump start/end range per map pgoff parameter

 .../scripts/python/arm-cs-trace-disasm.py     | 17 +++++-
 tools/perf/util/map.c                         |  5 +-
 .../scripting-engines/trace-event-python.c    | 13 ++++-
 tools/perf/util/symbol-elf.c                  | 55 +++++++++++++++++++
 tools/perf/util/symbol.h                      |  1 +
 5 files changed, 85 insertions(+), 6 deletions(-)

-- 
2.25.1


