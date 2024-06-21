Return-Path: <linux-kernel+bounces-224639-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 50218912538
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 14:27:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 024ED282C6D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 12:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B58152516;
	Fri, 21 Jun 2024 12:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="MHs0Hrjc"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2074.outbound.protection.outlook.com [40.107.6.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D361514F3;
	Fri, 21 Jun 2024 12:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718972859; cv=fail; b=txh0YcNSL+N2ZLpbqGuu4uw3JXB+GtGv1reiuEAt0Lv/ODRg1R8DRmejZ6V5VZALYXWCCnpG53THvVnSz3w4zyEX7NNtsI2CSZo4OlUdLc7VFBEQLV6M74tx+hW3jibTS7sm89CzE/6scaqjezwa+72cfuBjaV5HGn1hw7ax/os=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718972859; c=relaxed/simple;
	bh=y2Pfv9Y0lu+txvQqL0tfEi/kVrVDkIHnABl+JdrGyDk=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=aSj0VDdw2kkTD++Od2dbdfKBz/VEku46XwFb8i18oGEP7vApjGmyxgT7Vk5KUX/0Ul/g3EzLY724zAK2RqNIOtUYffrHRw+O/jHfvAELZ1NgElF8TIut8rCXy/VwMs6cK5rpXp0zXhoyaaxqG2WwkGbY5XKKiT6+JPUXitiaKdw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=MHs0Hrjc; arc=fail smtp.client-ip=40.107.6.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G/wx6HV5DsvvO+9V26YUVGs/zh3CHqb2cBYCTWuKZpj2eWnPoqUN9ijjiakv8oYD855DzSKhR1DvweqxfjNIOCPkWXT3NTtUPwjbullqw4CpKCzjtBZA22x2jpASN0PfWcN/YUYgqqyav5RXcNaS8wjRUYFolldR8Ss0lx/CZzW8pgfg6ZdbzXE3iLq8PtxkpIWs69EAJxij/BukXsxR8ZPJ36bHkL447EEd1CH46sWV2VdcpT61W3sJT/HgTQp4hS/wknO7HNy2XR0BMM18svR9JrtZb8hnbjSEll00Ahgpo+cipRhw4F8dBbDv9C4vLeLUPV3Qn01VzJ/3vEQ5vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jXIJIPrncLPAKxWYAXekgGAwOrmiayuQ6ab4HQ9cPI=;
 b=gNxfO0mD9dT4WeR0mpih0f/zgPfHDEp3VdKOC3MBIEL3XbCasRlR1EtD0wrNVM+sDaIkAfJifuaE4E4Vw1RSOMXyWhkqBpYnLfYfMihxAJuCVcFSL/Uba/gCW/70l2vYnqNdJkfhW203L0Vz7vmEPhTS9VYdqkzTYwolT+DtdP4xmd1MD05jQvJpAuZGe4V/f9Z16wbEPozeNgKshTju9ZaP2Zw8gqGArkdT6GToGPXm4XwXcIU0GeEBg8tX3UwX2v+SB04BrZ0LGdNAL/yt3t7H8uoGzFANXcD5gHCKOVdctV27bssV6WH4eQgA+tT14Hi7Gj/9QKkAB9t00526xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0jXIJIPrncLPAKxWYAXekgGAwOrmiayuQ6ab4HQ9cPI=;
 b=MHs0HrjcTAj+ztrdw4yMENatGLYa2QFFS7btp6IVRImhciwj93mzVIMD8COBgYwzUnzCcAWwhVo38tZogQExtvgQ6uLDRmMY2rNqrLsU1mK1EcKnvZ83V91faDxIt/WWvnNpLcrsd2pUUuDn0UTTdmL1UxYe98l6/xtzYdipvl4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com (2603:10a6:20b:9e::16)
 by DB8PR04MB6795.eurprd04.prod.outlook.com (2603:10a6:10:fa::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 12:27:34 +0000
Received: from AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256]) by AM6PR04MB5941.eurprd04.prod.outlook.com
 ([fe80::9f4e:b695:f5f0:5256%4]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 12:27:34 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/2] clk: add assigned-clock-rates-u64
Date: Fri, 21 Jun 2024 20:36:38 +0800
Message-Id: <20240621-clk-u64-v1-0-d28a611b2621@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANZzdWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMyND3eScbN1SMxNdc4NkE2Nj4zSDNAsDJaDqgqLUtMwKsEnRsbW1AID
 TppxZAAAA
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-clk@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718973409; l=974;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=y2Pfv9Y0lu+txvQqL0tfEi/kVrVDkIHnABl+JdrGyDk=;
 b=w1kkoqfCyzq+LLc4uWjRslx8Kyxn2dqmpXi2h4rqCzj8FxZvbHElqMUc/eDUgxc9eQvldSapk
 wgHbcUM5XPbAWpdU24W6/o4zqnSsUpRmYw7VTla9bLNT8X8DkWM6fHE
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SG2PR02CA0124.apcprd02.prod.outlook.com
 (2603:1096:4:188::9) To AM6PR04MB5941.eurprd04.prod.outlook.com
 (2603:10a6:20b:9e::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB5941:EE_|DB8PR04MB6795:EE_
X-MS-Office365-Filtering-Correlation-Id: 2581154f-3d54-47a7-1c23-08dc91ed871e
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|366013|52116011|376011|1800799021|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVF0a2VNZUtYNWR6a2xCM1VEODhSTFBZSGtoVnFya0RmL3pFbnNzaXlzZUY0?=
 =?utf-8?B?YzEza0VObHpoMnBXYUJMakw5SVBUUFkyczRmenJkVmlZNEVRTittVzlSbVhl?=
 =?utf-8?B?WlV0M3A0QU9sZmMrek9SbWZIMmVVMzBkUFMva0FZRm5jWWJNaW9Lb0pVVjNZ?=
 =?utf-8?B?dVI5aUJSSUlqZzNGNGV5SytneUZrN09VT3hsNEFZZDI1MWJ0elQ1ZTJzYkJL?=
 =?utf-8?B?K0dXMUFzQkV3aGdPdVFmUEpXU3Qyb1dTTUhWcWdLaFNFT3NGOERrdGptdlgz?=
 =?utf-8?B?bWtaTmRnRUZLSXJyN1VBL0VKU0lwcXFHREFYckF1enJ2WjM3eXdZc0dGUlNk?=
 =?utf-8?B?S1JUNCtmTDBybTVWYnNneVk2SXdSS20yR2NDa054QkxDQ3R0U0lvMmhVMTBi?=
 =?utf-8?B?T3JRZ3VjWEgzMW5xem1RcGg1NWpsMFJuamhuRXBkQXM0QXZxbkxZYnBORlJI?=
 =?utf-8?B?M2tUeFRUVDh4cUp5QUZWeXlUai9BQytYZUQ3ZGlOSEZjeU5tc3kxVkxGK3c1?=
 =?utf-8?B?RWt1WEg0YXNWZFlDQlQvc0lPOHoxN0crZENSYWFqRHpONmlVRnFnUUZ5ZEFI?=
 =?utf-8?B?Tm45cjJRakFDWW9lMFR4Tk1ISWN2djNNY09IcXJsYXVGTlUyMS80OFpRVEx1?=
 =?utf-8?B?Yjg2UUNmZjFEZWZpY0pWK0EydDBvNmd4RWROdEJLak9KUUI4dTk0MklhY2Iw?=
 =?utf-8?B?Rzk0VHBzbWs4TXZUS2JCRFRaWEVoSWtRWkV5TkV3VDN3c0Y4Z0szREtGQ1Zj?=
 =?utf-8?B?cmY0SmY1UmtmVjdvbEVxSUhENnlEMitWL0hqT3BxTFdRc2RjSGNlNGtBQzcz?=
 =?utf-8?B?YURLdXFGWmczRDhuNzhoUk9pZzJtWktQaER2Y1BlMEs0ei91dElmRktLb29s?=
 =?utf-8?B?b0FCbGpwNkJ0V2xwRDBKd3B3dHlPY0pCSXlBWlBaem1KaHliNHk4Rk0vLzBs?=
 =?utf-8?B?NktYV0pJY0tXRHgzK2NER29KZVV2T0tOZTcyVUhJNFFYNUUxQXdrMUUxamJx?=
 =?utf-8?B?R2FXQmg5WFFhK29BWjJWMGZmYlNOaUJCMi9PNkliMzMvWnNqcGc3WlpkQTJN?=
 =?utf-8?B?RTc5UmI5bldLanhtcUkzWHF6cWZRQ1dQVnFTNW4xMjN2U2VrNGs1d2JaWjZI?=
 =?utf-8?B?SGphbGxRandaWGpwYng5TWx5ZVNFb3haK1p4ZVE2a0ZmL0E1UGFMT211ckNK?=
 =?utf-8?B?Snh3bTF2SUp2UXNxQlJhVDJuQ29qdFIzVlVZZmhtUUlpOW9KV1BYZ3B5T2Vp?=
 =?utf-8?B?UlI2VlJFRVlXc2paZ2ZiRU9kcmVNc3h3dEk5TU1VZFV5dktHZ1Q1b2c5eGwy?=
 =?utf-8?B?Kzgya2ZEY2VRaWFCbFAvc1Zrc29CZnBrdUtpVzlOQ0pKR1o4YXVxOEIvY1RM?=
 =?utf-8?B?bkFhdTFkbEVuUkdBQ29wUHhQREhVYzF5Zm4wTWxKay8waXl4V2ZLNFRNejJr?=
 =?utf-8?B?L09iUlpheW5FUTZ1R3gxOUNyeDR2VDRxWlB2eTd0czdEdjUzaExrT1BHcjRE?=
 =?utf-8?B?aFVKZ1FzRXd2Z2g5NmY4dG9QNGJnT0VPWDVXK2hFUmxmcjBsUmJFa29DZUk3?=
 =?utf-8?B?R0dXNHYrYVRFK0dWN3NSTUtEa2o0VlRlZVhra3ZXM1lFckN3SzQ5Q3ExUy9X?=
 =?utf-8?B?MWVkc1VlYi9zSk40Q2JYYkVhb2kzYnlaOUhKNk9sK1hvbG51UGxCV2tYbEtk?=
 =?utf-8?B?RGVnWS9JWFVMRzZCd3JpcVJ4dW1LZ0NNcUwybW9FbFNYZDV5dHNTS3VCZFBZ?=
 =?utf-8?Q?2VRZq4oqNHXCLT02jNIXl8NtTGbFGQyGNRvyPdk?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5941.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(52116011)(376011)(1800799021)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2l1OHBwdXJFUmdGckZybllkeExYRE4zRytEOENGb0NndXBPYmV6L21wUDhY?=
 =?utf-8?B?Rmw4REtTb0czOHE4SDJKZVNLekZPQXppcjVjKzQvVjNveEdOWTZzd1QxWFNS?=
 =?utf-8?B?cG1MdWxXVlhDcXg2ZHdTVzh3L0dQVWNmWk1qQ0dmdWlscjhpT2lQaWxQQUFT?=
 =?utf-8?B?bWtpQmhBMThSRFphTUdvcTQ4MHVYb01vcTFFQm5pSFhjRUJ3UmpoVzdtZU5X?=
 =?utf-8?B?V2kxK2o4aDJJa2J5cEVPcTRzY2Z0N2FFYkd3STdWd0dHYWgyQ01jL2JLWGs5?=
 =?utf-8?B?WkR6ajA5MXhUbHhITFJWdTRxSlpndXNyVmtRREw1cXNQSVU5WXcvZmNaOWE2?=
 =?utf-8?B?QTY1U1QrRE1YSWt3bkc2Znl5WVgvM3RhbUF4K3BpcnN5ZFhSQWdBS3lzZ0g1?=
 =?utf-8?B?UjhFaS85ZUVTWXBJVnBMTVlOYUxBVVdST1R5NHlKYmRDYkp4ZGg1U2lCNEh6?=
 =?utf-8?B?OEhLTE8rc2RIYWZWL2tBYWU3TXZ0dko1RzkwR2Ewa2FqUWdtcnR0UnZqNlR0?=
 =?utf-8?B?NWphUlVxYnZ2SFI2UmxYTnhkN1hIeWxwaUlTT1dML2hwN050WlNZZWltMzF0?=
 =?utf-8?B?QkNqYW15RXZVTTgxS3ZycThBT3ZMblo4QnJoaUVNWlZyZnhFSnJITm9vOWFP?=
 =?utf-8?B?MlFhVEFwK1B4RzN1V1RyUkY3cUlKN0ZkQVhpeUc2bk9Cd0p4RksvckJNbk0r?=
 =?utf-8?B?eUNEbk9mY1hwV2JHd3dFNzZ2MFRTazhNRFJpemJac1pkMGcwYTQ4U2xtT0tr?=
 =?utf-8?B?UGw0UzlHRlZuUnVXNzNaVXJpanVCcVgwMUdnRnkveVR2RVBlUGJVbFNWYmxn?=
 =?utf-8?B?NHRVNlp0ZmNncWVCem1wYnBjc1R5dDZUQk9DanVOdWJmb0F4WFllM2VBcDhl?=
 =?utf-8?B?ZHVpcVVGUVVUNjJJcHFGY0RaUmVxb3hReEkyWStUQ0cwbC9vUGdGRS8rSDdE?=
 =?utf-8?B?RHlNM1ovZlJ1TUZFNEgvY0U3L00wZTQ4bUNGZGxBSVp2QUhWcG45eFB3OTJZ?=
 =?utf-8?B?c2c5MjJKdXBPVytBZnM1TGtRUHIrbEd5RGdqaFZsdmphSnZsZGtPTzhUT3c5?=
 =?utf-8?B?VXllTG94VzdOOVpmWjhzUEhXdU1EbnpIa2llcnpLbW9pQ1dGNW1GT1FHeENu?=
 =?utf-8?B?NTc2emxVMHFUUERZNitzOEQ1WDRTbll4ODlLMFNYaENINWU3SGkvV0pEaWJ3?=
 =?utf-8?B?OEJ5cHZVYmxmWUEwWjZxRFNBbnA4b1hXZWN1Mm5XcFVjTTJ0bEx2S0wwZnFT?=
 =?utf-8?B?RGRyNlZkN2V4SEFtNkY4cDc2aWRsWmF0VEhCbzFyaS9HeGl6UmZIZG1KNTk4?=
 =?utf-8?B?TzlOMUg4a0lYVFplM0M1N3ppQXA1NWhLcUJTR0VUTVlMdXhwZzVRUDlWWXRv?=
 =?utf-8?B?MWVqNU9DcnFnb3pYNXB0cUw1djNuY1ViekVuZzNuNEJhV0RhNlRaemRyMjZQ?=
 =?utf-8?B?S0lxeEprMVBhdHNnd1BtTFdPV3BOMHZnM2pJL2JxVFc1YVpTUHB0OWJ3VnNy?=
 =?utf-8?B?VitJazJLTU4vVUlvcGRMd1NuRDBOOVJHWHZyeDdCcndxL3FZcGRORm1RMEJr?=
 =?utf-8?B?bjQybTU5SitHUG1UOCt6b0RTU2NFRmpVSTdHQUdwRXg4dlFmZWorT2p6MGJ1?=
 =?utf-8?B?TE5IdEQzWk5vdUVBZGp1T0UzdUIyT2srRTI3emNGUGhiQ04yRWtDSlBScVRm?=
 =?utf-8?B?SG0zRUVyRTUrQklJVmxHQVRYQ2VPa2JFd0RrVWVtYThoSm1jeEZWaFlYTzF6?=
 =?utf-8?B?emhUSE5ueGZWL0hNVFp6WXplT3owbUVsU2JaeTZTK1ZVZFpHeGYzMWZWQWN1?=
 =?utf-8?B?YUhPbitHL1JMa3k5Q3dTZDNLU09ta1NkN0pTeWoxRk8xL3EzQTFCZlFmUlB1?=
 =?utf-8?B?M0VxVTRxVCtWdmJML1ptQ1NSNldFOERkRWJnYm5xWTVycHo0Tm1LMjBrWVpB?=
 =?utf-8?B?SlVqTHBPa1N4cFdNMlhlQ3E5b2FRRWc1ckEzRVJtbkdiZlB3djgxNUk0NCtG?=
 =?utf-8?B?WE1renZrbGtKY2kvTktzdElQc0pXQVdxeitvOHdleXdaOW93TkEzb1hNY2Y3?=
 =?utf-8?B?YjNaN0VjbjBoRkhUazltcWRtdnBHTlJ3MEgxYmZSWjNxcEFTNjlta1hnYWw4?=
 =?utf-8?Q?5w60Xj0fEPLnUfzZY988xrp1C?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2581154f-3d54-47a7-1c23-08dc91ed871e
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5941.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 12:27:34.1636
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ymdmLs84I/cGTcyHZW2Y0iPM91CrBgM8+D2Vv1Ldwipe6u5QTSynmgm+Vq1AaBtYyNV5eQSYddPA7wSke+wdXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6795

i.MX95 PLL VCO supports rates that exceeds UINT32_MAX, and the
i.MX95 System Controller Management Firmware(SCMI) server exports
PLL VCO for SCMI Agents to configure. So introduce
assigned-clock-rates-u64 to support rates that exceeds UINT32_MAX.
And introduce of_property_for_each_u64 to iterate each u64 rate.

The PR to add assigned-clock-rates-u64 to dt-schema:
https://github.com/devicetree-org/dt-schema/pull/140

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (2):
      of: property: add of_property_for_each_u64
      clk: clk-conf: support assigned-clock-rates-u64

 drivers/clk/clk-conf.c | 106 ++++++++++++++++++++++++++++++++++---------------
 drivers/of/property.c  |  23 +++++++++++
 include/linux/of.h     |  24 +++++++++++
 3 files changed, 121 insertions(+), 32 deletions(-)
---
base-commit: 76db4c64526c5e8ba0f56ad3d890dce8f9b00bbc
change-id: 20240621-clk-u64-70c4333f0f80

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


