Return-Path: <linux-kernel+bounces-302537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D5C195FFEB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 05:41:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA250283604
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 03:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA729219FF;
	Tue, 27 Aug 2024 03:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b="PWsH8E/O"
Received: from outbound-ip24a.ess.barracuda.com (outbound-ip24a.ess.barracuda.com [209.222.82.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DF846425
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 03:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.206
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724730097; cv=fail; b=rSXjwUnhhgSpYEUomBrNiNZnHfFvAVLCrr2MYXPEelJFMgdh1q5d2cESLRXDR35e8MJZqh8MBhI8XLFVKwpZo1qdn+Oi+kJAh7Zpl++zVPR5jAcve8ZfJrigH7UIdDwCQQNox0rOSsUjx92bgB71XdidykRaSJia4vk5Oisk+uA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724730097; c=relaxed/simple;
	bh=WjKRf/DvwCN9PFlk+248NXdkEGkMZxiI0cpFPakNdC0=;
	h=Date:From:To:cc:Subject:Message-ID:Content-Type:MIME-Version; b=tVvyp2BbwTW2k/Rw1k4Qy7kqvvj89HHfTTpTnhLWdbSJ9jbBJi0Bw2iBVU1dUVYCUuq2Xmo1A+ML9bewbqpAWxcKN2KAoVdLC+AK0lnXB0WJNi1bX/vpXOrsqUnfyn4/8I9NPFnmTv/UyooseCNYXd7YVf+LOszLuF4FTdmk7lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com; spf=pass smtp.mailfrom=digi.com; dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b=PWsH8E/O; arc=fail smtp.client-ip=209.222.82.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171]) by mx-outbound10-118.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Tue, 27 Aug 2024 03:41:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sfLWvXb2wFFKIfP0VmHAaLKHOEBTEZEe77VldNveZHzPWFTvTv39goP4wpQaDc2PK7D0KP1WsoKQ1xy9+gTmNb/vls6+9+NiAwo+7J68laqq0Z9zNlG93jWLVAQeZv3muAA71XKkA+cq3wqGoejjNgR6SMEG2/H5Sk3s6lW9Bd/T+ecjMqakH0SZHm/Ji177fIqZ8FRN4nu+UWxFksgrbOAVvjymfdtJBy2i0iWty8cZ+/JIuNOxac0+Qh9F6+AYJ0OgDWqaHhqvMuo4PATHlMrJd5nYJFMPD6ueXBPxov7cXxxIUTtDxXE5T1B0OY8c7e0vw2/3QKuhCu67ESIlbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p15iNT2jIN0JR4e7Fvu4faxG9g0C9L3GM6KhxggCAHw=;
 b=lrh4F0cZJP0LnXUlXxzI0I/uEV6y2K0jxkZ49zEkSiMuVjjoT9gZnaeNx8W/ueT/7SoDUMLVqXMDilFwIAmG5sQZunfP797sa0bd3xHt2HX9poCeSU8+2Hw2iIGCNeBXNMlUNnLULuHDqYHus0LwTWIJtm7ljzLwimeGTlxVc/1AdVUGHqRWny1MVYFP07IK2AJhyZY1uc/Pk/6bvrMeivhX5W3bEHfqQm7L3b5ke24cW6TggnwNaL8FoEZRr08yWjdCgoOLvFWjLLWZJYYlhieQQlyPHgtIoMOGZiHNiZxa7mzW6Q0kkVOCdT1hUUo1AY/WjwtJA+/WhfZh20nNZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p15iNT2jIN0JR4e7Fvu4faxG9g0C9L3GM6KhxggCAHw=;
 b=PWsH8E/OJdPdiXEzrxpg3NJNSurbB1jthpk5UsMrAOyqDbRAXGlEtb8oFb2ivaNhAvyTGhhf7tzQX7IT/t5l8rOhg8P1K72Bb4fMRA35Mcwjt53j76z4F5E/mbn/qgxjA+5u82hSSRSI4PagPq/1TWBKXsOe5psZbwT3KAWeBXVpqdX0oZqH1rjQT2NHV/X9cEviPbx+XlDxMdP06A1leofTYKibQJCS7JBMVP01dwFYniTteiuJS4rBFQkP6hLN3qJAQN4+fEcGOMnllplEoX4XqXOY1AVAyMNPWHfVTECJdbZm0vpWJaa2P4t/K4O+UwZtQ1GfN15iga9x4o6J2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from DS0PR10MB6918.namprd10.prod.outlook.com (2603:10b6:8:136::8) by
 DS0PR10MB7432.namprd10.prod.outlook.com (2603:10b6:8:155::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.14; Tue, 27 Aug 2024 02:07:39 +0000
Received: from DS0PR10MB6918.namprd10.prod.outlook.com
 ([fe80::3697:c0ef:caee:24ae]) by DS0PR10MB6918.namprd10.prod.outlook.com
 ([fe80::3697:c0ef:caee:24ae%5]) with mapi id 15.20.7918.006; Tue, 27 Aug 2024
 02:07:39 +0000
Date: Tue, 27 Aug 2024 12:07:34 +1000 (AEST)
From: David Leonard <David.Leonard@digi.com>
To: linux-arm-kernel@lists.infradead.org
cc: Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh@kernel.org>, 
    Krzysztof Kozlowski <krzk+dt@kernel.org>, 
    Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org, 
    devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/6] arm64: dts: ls1012a: add pinctrl node
Message-ID: <d9d48d8a-8dcc-8b46-eb0b-954e5db78736@digi.com>
Organization: Opengear Digi
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: SY5P282CA0143.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:205::15) To DS0PR10MB6918.namprd10.prod.outlook.com
 (2603:10b6:8:136::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6918:EE_|DS0PR10MB7432:EE_
X-MS-Office365-Filtering-Correlation-Id: df8677b7-e145-4c38-bc29-08dcc63d06fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SNcPLz3iyY6wT7h1xiblFaFUVn9E8vSngR08G/eR97jlnYFKEy7o+ZtFnIFL?=
 =?us-ascii?Q?241+WoNLWohxzu+nzOB1qWn72VeWchytX3ZJuS5DV8SYblZJYLpn5cm7Ivuy?=
 =?us-ascii?Q?CTXZU1RGA1+NKRl+r7dAL5rR//Vx/AG7eBdFp8Ad3QHbGOF84jrISokqvR6W?=
 =?us-ascii?Q?wE068CyxXiRWosts+zI8QlNzfDhyoyAh6c3R0StZt6fsLIRqK1D0tdZabhAV?=
 =?us-ascii?Q?iCHpF3ljamLWiwtgJk0SJ87q+615q0YtNuJClirz8U7W1bSy9ds0Gw0xCoeF?=
 =?us-ascii?Q?Vq9CKQaQZDX+6tHlJDOdnLV9RLz6Jj8bccDe8eb4bwze3fVe6UuwyKcBhq+Y?=
 =?us-ascii?Q?870BASN0Mc0AZCCVDloZ9GUC6O7/UoKI4qtNEFReVvVIl2JTgqnxhShWwtx4?=
 =?us-ascii?Q?SSzEe/9u6VAUxnA4JABzndkDPzzDp5/VX8LhwO5mL7z3w1OiqozSjuybffGm?=
 =?us-ascii?Q?PR59or1Cx7eqZkVHrvc/MB9k3RLICm8PDTgMCOKDtNnf08GkVN21XAiaFpPC?=
 =?us-ascii?Q?jau+Y3g4GCDxiD03HC9sRbNhKZv7QJAjTmGJBxKCFyuM9VtBFmH1nVtRer2o?=
 =?us-ascii?Q?FWe/UwFU/3jqKstTbE5KO1K6/W+mbFGFMXJFrejv7jNQYZbrR4rIRMkLUGci?=
 =?us-ascii?Q?0ne9o8JQhfYHMa0SSTtxDMwfepCC5XalyfC11RV3QEzpNVVWIjt4u+F8IcFS?=
 =?us-ascii?Q?ZH0dvVSMrQwUncYs8rkNcri07YiyGVyoy8QIQLuL3p3rwLbQLG7PlFb5NxL3?=
 =?us-ascii?Q?3lIkir+5110yWz0s8nLFBQeraj9JJ6Bm98bDYrMhYp6Xlhvh1foLKmkh5JtT?=
 =?us-ascii?Q?dFoWMl7rQvlH88v9QSHG6w8XAK6+q54gFON1wDmSq6UeW/H3+Ib8PxHjDFmr?=
 =?us-ascii?Q?XU0NwhUSRRHBeG4XAwkN0noRrPQSW3QJ63Khd87g67fIlDkiTwPxVCPjUwTf?=
 =?us-ascii?Q?DA7eYwoNP603+xQl1fLiLysGb0rIm5r2jW+8WLIV5BMDdCIYysKtA3EcLZsx?=
 =?us-ascii?Q?NWw8zbzLpju9b0ehWz/A929AP72VharvxUkcbqKeCtRbfCKLmLMVoF32NEO9?=
 =?us-ascii?Q?OplgPNc5UljhuTzorrtQLY5063zVFOC1AYaY8Q8I5XHsy5RI0cnPFdDysSHU?=
 =?us-ascii?Q?/3B+ePjjYpp95YeAbGtAnLkU5hxdthejT3RyruyEUz8jyjvJV+9riyPe1CmP?=
 =?us-ascii?Q?L4Ajq9IWOshGrmTleb2WY4GXCxA0907y/h6Dq8yuxD+Mpsh727f0VW3XTJ+j?=
 =?us-ascii?Q?sVWSYq+0aR3Moqe6QC98gMmGF1aj3StKskxbP5FoW3/DfgUhYJKbn9a/Bds6?=
 =?us-ascii?Q?rnDNcY2MbXdbgxFifVCg+Pu+DWVeC8myJQM3xJ5lRFMIDw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6918.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wGScf4/gxNDB7j6g9y3UAuiEOCTrZgFIleEqklEcP4cGiD4nmExm7hbh4uxV?=
 =?us-ascii?Q?TcuRavz74RiS1O3CpQau+ulBw/sL6klgO1ZUa/3ppatRk0jEe817sOnCodtc?=
 =?us-ascii?Q?1jcrU9CCZ3oejNgHj5SqIwrI98RM2GIQyAHJqmh56ak9hLW4o3Mb/1QJ+yhX?=
 =?us-ascii?Q?sNPSHvkFTJ9ZER019oZg2Yy4O2q61U9SIO0tJ/BkfHIbQRUPXPcl9zNHhKwv?=
 =?us-ascii?Q?HrrtDj/kwgWH4Si7/yapPCsz85mMFeHEjDWxXzWN8TcPz/68/WCa7xUxJ1yI?=
 =?us-ascii?Q?dHRCMUF9TYDG1C8TH9w34mAQ8DMQ1sVNmCKd+OiklGX2uAK+6fJ4+LX7dLiY?=
 =?us-ascii?Q?heGdqIWfxfmqrv6dQFBcogSxuGNLPQmkA0ga8sD9kAUOGqCY3Arrmc6mJ9sY?=
 =?us-ascii?Q?9kba9w66D/c9G3iV2iXeL3yuDZI8NSCRrtnNZzvsUIJToLQcxnWo8/4NrB/S?=
 =?us-ascii?Q?L4Ed2ElshtTUfWoELlXDAz95mwjR4ZDn+sFUk53OyPhlIfbuEmjzFUZFtsQ3?=
 =?us-ascii?Q?610U82Pcq6uOjF6G58XwTnkR1y1D/YWYVHqowywx7tbBtfFhA7ZVZm1h3uG3?=
 =?us-ascii?Q?M3m9jmzlqmm4zv9oB7L3JvCGC2zDvA/mUoJWO+ZYDQAV7V2h37nWoI4VQA3E?=
 =?us-ascii?Q?hnYFkORHNlOrnQQF0zfIX+uNHWIHVPKUJ5AwDlls6Sj+IjmwN1jv1A8lKyUl?=
 =?us-ascii?Q?jRNIcZHmS96VVouNRciE8DFICH4g224JdIqhH5Me4NIxlktJ8TDVBHh5fwiv?=
 =?us-ascii?Q?bT/zTK1Ie3tKOKnFhS71ZbwXFT49M1xj792At/Yj3d+omfDAtserXH2kO4Hm?=
 =?us-ascii?Q?C64h34hTF8uBoGvc6mo5lAwdSk1pSSsncaHDJofea4uZrDIM/JanS8EYJp8S?=
 =?us-ascii?Q?yX2nftGgBBoYnjbvdsuPe9eqYLY+zxG/KCrL0tO8Gkp3QiKoZcyRaqVI/laC?=
 =?us-ascii?Q?8uHvmDX4NTtzczZaNNkg2kNTxqlAQaMxnxJuo5KBeGUDC7XD2FdM8OApd2Vi?=
 =?us-ascii?Q?CZYP3FcWUCauPAgz21Ldv9zdtoNdB4Xaw1EfaGHZz3EU76RsWzbvnFxYMJv2?=
 =?us-ascii?Q?7xd8h2Cir+uGVbYPhAzEQj+Q54SXD0ZYazyHmG76RIs6yaBWbCZKmLa8Y+jy?=
 =?us-ascii?Q?+hpSVrT1NWFd8Uu+BqVDAt8UW+W1BLohkvFh3iQW8CTtwlQeGAgNLCuBw8gW?=
 =?us-ascii?Q?zf4KWNL20Y7zBLuZtX27o2Y2NG9+7n+/FwqWBltnlTwnlrVa4zZEps4N0Gu+?=
 =?us-ascii?Q?RUNw1PoDgWZssLK+f9BzTd8EgNGjIA7mtj5aevBLDoFvDNCJkxIz87laJ1mf?=
 =?us-ascii?Q?zOBQc4YuOmIL/eHDQOWisT42L9ZpVZ+CUrElNuo0vHFxclzMDi0RbucwMgJm?=
 =?us-ascii?Q?czMR1vTvGnzvbZodLwjYirEePvVoKc2cYTa63HpfQbWyQnGLzptylkEL/nAg?=
 =?us-ascii?Q?EMfjEoOfIcMUIzUMTwdLhtwYhUkipFZz9RqUN55rRy0LZnh3qkaSGaU8Eodl?=
 =?us-ascii?Q?ESiMZh9TlTNAibArmbRRqGhwOVHQqF/7Oc85ru23RZjbAzi7FRVDGFF5ldpb?=
 =?us-ascii?Q?3ZXVZnG3sMNGb66jFsME3ymxBueck9ZCtUxozPitwPGxag+nlxYgpgbrhLzh?=
 =?us-ascii?Q?O95LHQFZ3aGyMHPJ0pCyLEruABqxNec+wekjrDJKW7sP?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df8677b7-e145-4c38-bc29-08dcc63d06fc
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6918.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 02:07:39.3142
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Esa5DLsWAsvZVYm3HhVtFIso9UZZ8MqsBa7f71SbKLFRm5VURFeW3jPHtzrBp0+V96mNr8cEt9VBXyezlQqoSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7432
X-OriginatorOrg: digi.com
X-BESS-ID: 1724730094-102678-4843-1214-1
X-BESS-VER: 2019.1_20240823.2008
X-BESS-Apparent-Source-IP: 104.47.57.171
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkbGhkZAVgZQ0CI1OSUl2dDAOM
	0wLdnC2Mw4zdLEKCkpxSjRwtQs0dJUqTYWAPBjqllBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.258621 [from 
	cloudscan11-42.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
	0.50 BSF_RULE7568M          META: Custom Rule 7568M 
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_SC0_MISMATCH_TO, BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1


Add a node for the LS1012A's pinmux controller along with related
pinctrl properties for the nodes using related GPIO and I2C functions.

Signed-off-by: David Leonard <David.Leonard@digi.com>
---
  .../arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 48 +++++++++++++++++++
  1 file changed, 48 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index e61ea7e0737e..d28416849b0f 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -175,6 +175,44 @@ scfg: scfg@1570000 {
  			big-endian;
  		};

+		pinctrl: pinctrl@1570430 {
+			compatible = "fsl,ls1012a-pinctrl";
+			reg = <0x0 0x1570430 0x0 0x4>; /* SCFG PMUXCR0 */
+			big-endian;
+
+			dcfg-regmap = <&dcfg>;
+
+			pinctrl_qspi_1: pinctrl-qspi-1 {
+				groups = "qspi_1_grp";
+				function = "spi";
+			};
+			pinctrl_qspi_2: pinctrl-qspi-2 {
+				groups = "qspi_1_grp", "qspi_2_grp";
+				function = "spi";
+			};
+			pinctrl_qspi_4: pinctrl-qspi-4 {
+				groups = "qspi_1_grp", "qspi_2_grp", "qspi_3_grp";
+				function = "spi";
+			};
+
+			pinctrl_gpio4_5_11: pinctrl-gpio4_5_11 {
+				groups = "qspi_1_grp";
+				function = "gpio";
+			};
+			pinctrl_gpio12: pinctrl-gpio12 {
+				groups = "qspi_2_grp";
+				function = "gpio";
+			};
+			pinctrl_gpio1314: pinctrl-gpio1314 {
+				groups = "qspi_3_grp";
+				function = "gpio";
+			};
+			pinctrl_i2c1: pinctrl-i2c1 {
+				groups = "qspi_3_grp";
+				function = "i2c";
+			};
+		};
+
  		esdhc1: mmc@1580000 {
  			compatible = "fsl,ls1012a-esdhc", "fsl,esdhc";
  			reg = <0x0 0x1580000 0x0 0x10000>;
@@ -371,6 +409,10 @@ i2c1: i2c@2190000 {
  			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
  					    QORIQ_CLK_PLL_DIV(4)>;
  			scl-gpios = <&gpio0 13 0>;
+			sda-gpios = <&gpio0 14 0>;
+			pinctrl-names = "default", "gpio";
+			pinctrl-0 = <&pinctrl_i2c1>;
+			pinctrl-1 = <&pinctrl_gpio1314>;
  			status = "disabled";
  		};

@@ -414,6 +456,12 @@ gpio0: gpio@2300000 {
  			#gpio-cells = <2>;
  			interrupt-controller;
  			#interrupt-cells = <2>;
+			gpio-ranges = <&pinctrl 4 62 1>,
+					<&pinctrl 5 124 1>,
+					<&pinctrl 11 123 1>,
+					<&pinctrl 12 61 1>,
+					<&pinctrl 13 122 1>,
+					<&pinctrl 14 60 1>;
  		};

  		gpio1: gpio@2310000 {
-- 
2.43.0


