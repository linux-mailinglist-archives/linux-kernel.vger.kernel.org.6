Return-Path: <linux-kernel+bounces-171692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88FB88BE763
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:27:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FD05283892
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 15:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 839A11635D5;
	Tue,  7 May 2024 15:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="BqaEkK5V"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2052.outbound.protection.outlook.com [40.107.7.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674D815E1E2;
	Tue,  7 May 2024 15:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715095628; cv=fail; b=QSGf7kIq5jPpQ6z69LZl9nB2pGqv5iEQiJOuwGx1rJFgIlgltLVq4jUS55AHzHGGtiYDT7VYvc6qcqy7qjeFeR++0upvYqMJpd9RZ8u1BG+bYzIcP/5s6QGUMG4QBmVpgErMaiqB/q00DV4VCh8t7hZuTXvz3YjZXx6MYO7yVyc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715095628; c=relaxed/simple;
	bh=yMr0bAWjFCE4wk+fIyPqGnKcpvsZIiRNHinbpigIDaE=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=tSX+CH7DLOshOHguKoiJA3U4k71/oTMAl4t+CqaxbDFVv4ZjX/K+OhzTfNxq5j6/OBw80G/gEKLWaw5KkfGgsMeiE83dHRAw6AEYBxWkklsqvyaP2pH2dNeNrDq7OnHHUnw3gMGC3z4tWgGxHUr9uhtM+2V//2H0LdXH8UFT3+k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=BqaEkK5V; arc=fail smtp.client-ip=40.107.7.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NIU3cWahhHf/XuLjr/bDtXYDC5zW7a820F2XJC04+H5HfkVEH63nQtcKsV+ItC0ot4n2P6Bp+dlY9qZzigzdgInb2CP0/pDOmDWmg4Y93tR5ZqHmbKiaTCmmEajUuMKiJ5vTU1l80i5dvq/ClcNVEOXuDY70e7m1qZtsZsWSe1UyRcJJFlxy1nxu8zxP79ENOXIzu3DglinunW1+Vza6BCLkItN9iBV/unxhk7NBwJPYlmeh46V0ihQLYrfM6zM/AFnOG1RlFbyVQULfsz+WI63GRyF7QkexvnGwzidlt7rqf+xIKjxkmwL+VU1gp4M3P4Qn/mttLKhDA6gKh0eC0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gyylEIS9MRSFYX3Mx2JxcdzFYXpvAzaNX8cSqQgGbJQ=;
 b=bu8HhQH/J5TAA+Hq1RtrfEqSlO6fhStGRzSyxzQdiBb9HqR44+JZPc4xbSciYIsSVwlwUPoi0ZP8c41i8O0YzWwgCWNW8lk6xpdp3+DX1EZZfOJEAZQtFUachHvflbGJxnCYmIxPSL79gvMxu2UiT/GjPi1yEQeUvo9ab7O6IVTx5ZeLNYcYUSGBqOWtZ1qSjfMhusE7Nud/ytzJIzeezqbQ2e5ZETKU8TBsRd623Akh05VqUhDxEbSccww4YdP920PZFWB0FN9Qj5yOjIThzVN2CGhppDGaLhEId6Dz7K9okOX+Hyx2fG8kqqBsxD1Q9phP7SzJp4hZS+/xikgxlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gyylEIS9MRSFYX3Mx2JxcdzFYXpvAzaNX8cSqQgGbJQ=;
 b=BqaEkK5VSPt7iwfrMqD8F1AKfUnFSqsMG8aFL7F2N+92zNefYwiBgpqmkGpdOD27YhXbnj7kWlpOzyZpZ8DFXFrEuGm5x9LBSgDOa8XWLUq07RuTHvX61TUjkDqhg3pLQboVRQmAnyhLTReT/yqjVpeahBX4PR//wmqK1+OoqNo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB9014.eurprd04.prod.outlook.com (2603:10a6:20b:430::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 15:27:01 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 15:27:01 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/2] firmware: arm_scmi: add notification completion
 channel
Date: Tue, 07 May 2024 23:34:59 +0800
Message-Id: <20240507-scmi-notify-v1-0-1fdefc984d53@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACNKOmYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUwNz3eLk3EzdvPySzLRKXQPzVAvzRIsky0QjYyWgjoKi1LTMCrBp0bG
 1tQCPyGMrXQAAAA==
To: Sudeep Holla <sudeep.holla@arm.com>, 
 Cristian Marussi <cristian.marussi@arm.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1715096110; l=1405;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=yMr0bAWjFCE4wk+fIyPqGnKcpvsZIiRNHinbpigIDaE=;
 b=YPRSXgt1kPCgWcWEHVH+zRHVLA1KOOw8C7XZuMike5JJdRYmgu0XW94QRc0IbzDSF9oZ8mV5V
 i8cHxr7JtHWCXrHCXVcp8ijVtZhx4pzXWN38eOFxk5ZnGupiB5byOa2
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2P153CA0018.APCP153.PROD.OUTLOOK.COM (2603:1096:4:140::9)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM9PR04MB9014:EE_
X-MS-Office365-Filtering-Correlation-Id: 48b1c2a8-392d-456b-0daa-08dc6eaa2466
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|1800799015|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aW9STm14U01FR1Ryd21zYSt4UFd0QkFrWUUvVlJNRlVwMitDVkpxZHFIMTRi?=
 =?utf-8?B?djFsSUdnQ0NlNERDbm9ON2RQUjQrWHdpby9TMU5PSW9TR2R5a1F4RW9MTUFY?=
 =?utf-8?B?UFpKcU5iNFpZa1BkR3JSS1ZMbW1SSnRZeVpKOVUrRTNuTFFMZ0lIV1Rxdncr?=
 =?utf-8?B?dzFUMkZTVmFPWEZIditnRWR5dEduL3YyeWN3RFozL2dwODBpbjJFbFRWVk9X?=
 =?utf-8?B?dEVac1doVmI4TjF6V1ptWjN3L3Q5VFNBWjBoSTdic21EYldRcDZKWFNsVnNN?=
 =?utf-8?B?K3dhdENzQ25WbEE2NW1aYjlua0l2NDNOWkZxcWdEcmUxUjA2aGQ2VDY0bkxT?=
 =?utf-8?B?RXU5RFdJUXJ6MDFpNTU0UGIwMkF0bW1SK1RtTGZxcDFGMHlWdkZMWGhMTlBR?=
 =?utf-8?B?dVM3SnRJbXU3Vi9OeFZKL3JnNlFYZ2RYVnMwbEx3T2wzYlVCbC9rWGhZelMx?=
 =?utf-8?B?VE51UXRXZ2twWHRWYzRNTVVBUTlEcTR6NnQzZmROWFdqc2NRd2hNYjV6WnlT?=
 =?utf-8?B?K0ZpUTFteGJ3MXhWTm5valZERVp4OXEwUWxZVmJiSjRqbnh2elVHV3VsaEJa?=
 =?utf-8?B?aXV1Y0FlWXgvbzZOUFFnRTdMbU5iVEVvMjh2T1lVT3VwaXpWZzcrVk1yL016?=
 =?utf-8?B?aGEzcEsvNUhLV2g1TVlhVlNwRlltNmJiSmluVFdpbTYrUytKVG1LdlRQMHYr?=
 =?utf-8?B?RHlPaWZ4ZHFCOWV5NXBVOXNnYkU5MzYzSEIvK01ENDdlQlE0MmUwdEpiVlhT?=
 =?utf-8?B?V3FiQUlWUWw1S3FiVUpuVWZROXdtRWREQy9HQlpVTDNDYzN3SHkwcHZqWE1o?=
 =?utf-8?B?WVVLa1VTLy9VVkFoVmlZekJaYk52NHFJVXlodU5BZTR5cElUZ0JQOWtEa21H?=
 =?utf-8?B?YVVORWhpNmVHcTVRWUJ1bithcEVqd1dxdmQ4Qy9pVml2dU9WdmI3NVR1Yk9J?=
 =?utf-8?B?aTBISC8wNytVR0hrMGxjZDRqU1VxaGdBYkorMWlWV1pzM3hFeUtKNFp5NnN4?=
 =?utf-8?B?WGt6enMzbUxRaXY0SjVPMG1rS2MyYktJUWJIMXlVeFBGWjlmTzIwZWRNdmVI?=
 =?utf-8?B?bkJBSHJvSzVXUEo2S1c3UTFSZjRoNGRhbm95VTN4VHRaVHh3Q1N3SmZ1eHZ5?=
 =?utf-8?B?YysrUHJZblJjaHo0TS9LOEhISFF0TFVoU2F6Ti9zU1RQemNJRnB1RDR3b2VV?=
 =?utf-8?B?My85d1N4WXNGRFgwMDFkLzVHNjZ4blBJTTI0NElXeEgrM1NqNllka2xKZU5z?=
 =?utf-8?B?Y1ZBNU9iY1lOcU1vc0ZvWWFGeGttdDYzakc3bG5OOG03NWhZeDB2Sk1oT3VK?=
 =?utf-8?B?aTlGZ1k0TXFXSFFmYkpKL1M3SDN5VzVYRlNYcUh4WjRrbHhHck44b1BnMFJ2?=
 =?utf-8?B?cFZLMTE2ZkJYbmlwc0p0TjNTc1VJaUlRdGdnbUd6V0ZidGRzc0hMUkFmcWF4?=
 =?utf-8?B?ZlhkRjFxM1dvM3FjOFpydmJKRGVQMVJtR09aR0loeFQ0TWlxRmY0SGNoSHVK?=
 =?utf-8?B?cmFwOXB2a0pjYkRhaEhpTVg2THlRS0g1ZmZRTDFUT21ac1F1TEtIa0hvZ1lp?=
 =?utf-8?B?Y3ZsZ0haeHJMYW9veVNwbncwdFRpenRTd00rK3doVjlqQzFRZUdZdHVwNDdF?=
 =?utf-8?B?S3Zmelk4MDNtWk5zaG0vaFNGVGRTVWJXSU0ycWVpNFJKcUlVZmw0SmVoMHVS?=
 =?utf-8?B?andFNXhYK1pRSEpVa2N2a3hGQXE4SnFYc0p4OUVRbG9vOFNmNURUUkI5eE41?=
 =?utf-8?B?VVlvVTBYRzJKSnRlNkMzTzhjRlhmVmUzK2E3Q0VRQ29XajRwMm9mU3Iva3dC?=
 =?utf-8?B?aFdkN3RoTXJaQVRySFB1QT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzEzcFA3VUtkMXp0RDBmYWoyRG1qb0FqY1U4QW1yTjlOaWJIV1hSQVJ0OC9r?=
 =?utf-8?B?M0VpbkJmazZCaWRGTy9PUjRHSUZWUVFNUk41eGJSNDk1aWNVTGVuTHZVanhP?=
 =?utf-8?B?bTdWU0FINjh3Wkdsbi9tSkJkS0R2SnU1UHBlL1l0L0tGWGpJNW5nZkUxSmNO?=
 =?utf-8?B?dnRXZlZGNTF5bkgrYWlEeEtaaEIvTzdLeWFqRlZDNC9IL0ZoQysrODNkUzEv?=
 =?utf-8?B?SzFHVUF1S0lZOFRNU1QvVVhoQ0o2Ymw1Tzc3TzRWZmhIYnh4dCtlWEJKWVJk?=
 =?utf-8?B?ZUlWYURkeGI5YVMrQm82MGZ6NmZ5K0ZjZXVibXpKODFBWjRRQUpEMmU3cVFM?=
 =?utf-8?B?cUI5eHlnZ001L2VkaUpZL3dITUxRR01hSU9VMyt1U3RiUS82R2xpdkxhaC82?=
 =?utf-8?B?SVc0TVZldDY0aWQ1aTZuOXpuOCtuL0tzckF6UkVGRkJzZ1U3YmtDZ25PTk85?=
 =?utf-8?B?VXVveG5VSDVIaCtJb3ZCUHkyQjIwcGdWeUhCY3NhckFKM3dDR21ITjFBdEJG?=
 =?utf-8?B?dW9tWGQ0RWI0MWlwYlVvYmV3b1hKZ09PV3Mvbm0ydkZIYnd2Y012MGhnMmp2?=
 =?utf-8?B?b290eHVzVEJCTGVRa1hYR1ZYSmIrS01selMrZVNlRExHanRrRU90azV4RHJH?=
 =?utf-8?B?d3lDbUp4NjBZam1vVkpRTG5YVUg2cjhIRzVOOEtyVnIvTnBKelNmbjRETnZE?=
 =?utf-8?B?MFg4R2lvWUFyUTBrc0NLcUhLamZLRjNJZlZOQkZRdkZVVFRudWZZcmVaRGM1?=
 =?utf-8?B?WXMvcnpLQ3RqdU9yRlgxaHMvcWlmVXkwQWhZWnBYK3k1LzlEOFJIR2FTOUwz?=
 =?utf-8?B?Z2duVHFqTzgvMlhibmYzcXQwazJ5TkF3VUZhbkFxalNtZTFkWDhDOHhiVU9Q?=
 =?utf-8?B?MXZqanFDOTcwaVNNc1k5R2lCNlU3bFR3dkhhTHpZcE9neE84WndkWHNuemFY?=
 =?utf-8?B?V2t3TUJieTNUYXk5T1c3anhqRFNiQVBSanVpMFFraTZIMlJ6Rzg4d3JHS2pC?=
 =?utf-8?B?RUZISkFBMS9Od3hMWWppTlE1YmxTeW83SVJ4OWQ0cjN4TkVUWEtQc0xDUDdC?=
 =?utf-8?B?ZWNQdkFoWVZ0V3g0aWFiYnV3ME1ETDNrNUtQcDhScnJnY29pVFJpbTBPTFlh?=
 =?utf-8?B?Q1NtdHdVbFpBQ004K1FnRUdJV2Y4dkNLWXdFQ0laMXo4ek9XTXZLL1J2dVFL?=
 =?utf-8?B?TTllMkxOaWpZTVNnRHJ5Vk11RG53bEp6eVQvcGZaZU1qNDdVcnJOQ2RGcXh6?=
 =?utf-8?B?QzdaOGxUVzdZSDdsV3BsdCt0bzY2ZFRhTXE0eUlaL3pJVUZmUmwvc0d1STFZ?=
 =?utf-8?B?WnVDeXFEMEtySyt2UExxMU9tajhtaFdiQm85b2YveG00R1FYT1FsNDFCbDhV?=
 =?utf-8?B?eUIwMU5CSE9ITldGMTM0U1NTWWJzTUs2YUp3SDFHRmN4L214eFZoNzFHTXlh?=
 =?utf-8?B?UHloUVdkMWp5Rk1mVDcxV2hUUklaelczU3h5L3B2ODhqUG1CSUNkOHlUOUpn?=
 =?utf-8?B?YXdzTWxJVW5BeEh1bVNDdlY1ZTVFTjZ0Z0Z3R096RVRncHJNQ2Q1b0lqcU9v?=
 =?utf-8?B?NHpwSmVtWmpoNG5BamhIaW1XZHZPZHVkMjBUdHo1bEhWQ24rL2dLalFPa1VJ?=
 =?utf-8?B?SHZobUpieVdWMEo0b1UySitZSVZ6NzVUUWxzeFduK0EyL1REN0JrODIzTmFV?=
 =?utf-8?B?VEV5L1BOQUNXUkR4b2U0MnFPc2ZxUXgxb2FYc1liUWpDYUJ5NkxQVXFvampS?=
 =?utf-8?B?OXRuejlGcEwxWWErcnZMU0NWZzNtcDhMWXh5OUJkTWhRTmY0UDlvTXFZamdu?=
 =?utf-8?B?VitneVR1UFNJaVVCbXhMaERwT1BuNUxWWk9PZVg0UGtRVnlXZ2NhL1dIVjJ3?=
 =?utf-8?B?enM2YzMrNklkNFJqMFh2ZlJrelpTaEdrcXd0cXk0ZTdYUmpEMkJaN1FJa2Qy?=
 =?utf-8?B?Y2ZnTzJTZDVwU2hYZXFlWVF3cXNISmNwSzdpSU9SQ1A2bDhlZDNPMk84Z01l?=
 =?utf-8?B?WE9LemFvWVF6aHRKbVZtQ0VlNlplOVNVby8rRlFJc2xGbUtkN1VUaWV1VnY4?=
 =?utf-8?B?YXlmcUZyTkk5MUNQTC92ZDN3Q3hTUUw2SmdjcG80azB0K3RGeVhMc2NmTFhU?=
 =?utf-8?Q?IL7IZsyNKZ9hu+jR4RadcvY7G?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48b1c2a8-392d-456b-0daa-08dc6eaa2466
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 15:27:01.5450
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e1vyqR9rANaij6Q8909GJff4oQ1PNslIkR/3kZp0udA1MkjJxC3QFKFqv8Ul2H3cMLpQLcUpH08fO+pW7ADcAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB9014

Per spec:
Completion interrupts This transport supports polling or interrupt driven
modes of communication. In interrupt mode, when the callee completes
processing a message, it raises an interrupt to the caller. Hardware
support for completion interrupts is optional.

i.MX95 SCMI firmware is fully interrupt driven, so Platform expects
completion interrupt for Platform to Agent(P2A) notifictions.

Add another optional mailbox channel for Agent to notify Platform that
notification message has been accepted

After notification channel status become freed, Agent will use the
new mailbox channel to send completion interrupt to Platform.

Add shmem_channel_intr_enabled to check channel flags.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (2):
      dt-bindings: firmware: arm,scmi: Support notification completion channel
      firmware: arm_scmi: mailbox: support P2A channel completion

 .../devicetree/bindings/firmware/arm,scmi.yaml     | 12 +++--
 drivers/firmware/arm_scmi/common.h                 |  1 +
 drivers/firmware/arm_scmi/mailbox.c                | 51 +++++++++++++++++++---
 drivers/firmware/arm_scmi/shmem.c                  |  5 +++
 4 files changed, 59 insertions(+), 10 deletions(-)
---
base-commit: 9221b2819b8a4196eecf5476d66201be60fbcf29
change-id: 20240507-scmi-notify-07e87a8b9a23

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


