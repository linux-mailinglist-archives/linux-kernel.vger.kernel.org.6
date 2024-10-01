Return-Path: <linux-kernel+bounces-346392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB19498C435
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 19:09:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF6F91C21587
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 17:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5BD1CC15D;
	Tue,  1 Oct 2024 17:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U6bBRUJ/"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2088.outbound.protection.outlook.com [40.107.247.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360421CBEAA
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 17:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727802540; cv=fail; b=LVDJ2DNZ57vOJewnPAxoGAHaKSubNE1oqvEEkjkk+vPWOWylQUmaU8QW29Dxjoa5zCW+r3dmTM9XN3bByvmk3wdQoFaFoN3AzxwCD1X/c0dO3mGZRqMENoA41BMDKW1Gk1ZB+KSAg4c+3DgA0lcCmuKH/Un9dojVS1um+P+I3dk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727802540; c=relaxed/simple;
	bh=/mHi0IGhvDETCcr1sx1Tpq46kysDKfA0S20VyM9YTjA=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=h61GdUEpqNzHCnNv1xJj/WzKV5ZQ09JSBtgR0SBllRHz2SHbh9ffUjVkxjAXEkwFUB1n6X5F6g0EWSNpcJ6HmKovJ2g1X8Ya5wiRZlEznL1BJJ1THlKcSiME6sS4h1UROdWNIgFd25IEfKSXf/EE3tyLmIe+WBL5r48lT648jHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U6bBRUJ/; arc=fail smtp.client-ip=40.107.247.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbyPYjllrQn0tzoZNPdd2YZyJvZhgIc4r2D+hgkKhjDl48CCvVV1RMwG0SGOTbNTthJoNifXgYwkjvvH2XME8tA7T0nAXJVk9b/txNJTy3uAiz7jRXTEf+FbGGAQe32ZxkDYsZliF95xCxfhHuO3Cygzm6j7Hcc4Kqg4Zb2aDiix72pkJ1m4ARMS6gHcWDlainIm1aJ2etWFn9hrJiOAxS5Y8doptneeB9HIC+QL9ZLy4MlfYQ2rRncMDQ3ASkWpkpd680yRJLy7M0HbmW0VP7iWuFcSFOibgwTrGIt7dp3VWiswUenqJSavd1rlKtJyuoKSV6FuttHZGSl3zphqKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r63hJtAXg34VgEEJLPki9brRwE37eXOv9n6xTXTxe6Q=;
 b=zNO8b6vIIYQOOaCVdx7OMt9vmdeEH08GAF7eKbAgXtwbpJbOLowyrwHm9I6MjyIMqmR8ecNe8kIJ2EWi/6HRfSI9av5F4MgZ3ysmDt77M0Y42P8xhx+eFvKsfd8AckAdf8ASBVziolyBckojzqi9JZHxlzHbitEBqh+8VpwYY8n6fIHHrVxuAinDT3kh5Qv8N9b6CMjHSHF4G5U5PvQ1xKSAAS9EmD4OZ4qmKS6EXAryk02UOm2nOmMZMIKk3JRaozbL4Nm6QKIyzF1bNu6i7QoBjiXR/Ctudj0aU6Z5JN4FEsq62m9EjlwojB8o9M8YvtCe1utQwKlBdweOxL3jiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r63hJtAXg34VgEEJLPki9brRwE37eXOv9n6xTXTxe6Q=;
 b=U6bBRUJ/h0ZhoIGWUs36JPMAXRkNQXKYU5G4blOmo2mSM0RMHSImtmSRZN2TV6CoX/Af0mgD7e/iksF4c/MON8SMsW7nM4rDK9o9/1j47KDTAFNW8fqMCIxxbl9a00vmxHZPG3J+0Ar45nao6wcHvEy4r8Rjzy/9/3i+ecGjfuOhbQOTaB2VgB+7Vh1SVudapstK+bZ/h/9XCsB0SyTPHuMFkAJd3dEd3r+nRXSPr0duT925QQtEP66U1g5uojkC/ay/kZ8yiFbUwXCSU3ycgg3lMUCsS9LUCYhbq9xyh6T+o5cNnNRNMro9aswuGrCS82wFMj6m68TdqyIqPIw+zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB9710.eurprd04.prod.outlook.com (2603:10a6:102:268::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 17:08:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 17:08:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 01 Oct 2024 13:08:21 -0400
Subject: [PATCH 2/3] i3c: master: Extend address status bit to 4 and add
 I3C_ADDR_SLOT_EXT_INIT
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241001-i3c_dts_assign-v1-2-6ba83dc15eb8@nxp.com>
References: <20241001-i3c_dts_assign-v1-0-6ba83dc15eb8@nxp.com>
In-Reply-To: <20241001-i3c_dts_assign-v1-0-6ba83dc15eb8@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 arnd@arndb.de, bbrezillon@kernel.org, boris.brezillon@collabora.com, 
 conor.culhane@silvaco.com, gregkh@linuxfoundation.org, imx@lists.linux.dev, 
 miquel.raynal@bootlin.com, pthombar@cadence.com, 
 ravindra.yashvant.shinde@nxp.com, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727802526; l=9456;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=/mHi0IGhvDETCcr1sx1Tpq46kysDKfA0S20VyM9YTjA=;
 b=y90JXxQcloUIJ5ejLwIdojh+Jt7Upysp0mxEU+izogT4hkQ3H9XOiSCFxEazT4oFCSs9C0Qt6
 e8HHIApOAsLDR5/fCL+B7eo+zH60AuGAqFD4u7R0WfRm6Hs9b4P5YOK
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::12) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB9710:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c01a988-db29-4a5f-3f1a-08dce23bbbd4
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|52116014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?NUpSQldBb09zcGxGQnNOdWMyQ0ROcDhnLzFSOXhRSDk0RHZOY0hsaEswdkpO?=
 =?utf-8?B?NnErdG1UYmpaV0FyTmdIQ2hXeS9zOUtHVzNJMFRCamEwb1Q0RW5qaHVDTnB0?=
 =?utf-8?B?WFNZVm9Lakczd204MngzS3lBWDRtb05PNDZmMWVheG00N2hGZ2JFWUVoandn?=
 =?utf-8?B?VU5aalI2UGFSQ0lUTkpmYXh0SnZORUtZeERJRDY0ZllHSUNiZ2hCL2NYZXRi?=
 =?utf-8?B?c0hicWtETXlrSXdhMUt2Y2c3czVRQkp6Y2ova0E3VU90M1N2THJ5eGxIaTht?=
 =?utf-8?B?T1A0QjNMOGM1SDJUREtoTnc5bXdVMmZidVRneUVpTllyUFVEWGlrK1FMSzUz?=
 =?utf-8?B?dkNxNm1YYytlRzNUbkJEK1plbnJnMUJYRklQTG9pVDdqTVMwMzNpWjlsbXI3?=
 =?utf-8?B?cDlKa1puQzlTVm1zYzlUMUZjRmJpN1VwYVlNdVMrL3dGUDJaTXZ4RFYxNFd0?=
 =?utf-8?B?RFJKQ1d2VHVNWlYwOVBKbDM4T3dxMDVxSlJxeGhGc0kxQXBlOVFENjhzclht?=
 =?utf-8?B?bjNoZms5YmdQMXgzbUF1eGhQZGovZ0ZKZlRpTmRnd2hJenFsc2taYUlpSWJH?=
 =?utf-8?B?K0dGRVhrclcvTTUydytuZnVjd2d2dWVobVZUVlM2ZVFUdEpsYVJ2WGVKUnR5?=
 =?utf-8?B?N2VqcVJZSnc4U0pTV2d3SU1pR1VvbzQyYWRCZGZKT1V5bVc3dm9ZR1Y3Smc5?=
 =?utf-8?B?dVpJZlppR3A2cldUZ2VqalloSVhldU50cWdhbTB2OFQ3cU51QzM5UDFRQXNm?=
 =?utf-8?B?bjk3cEtWUFBhdG9PSWJvcTFuOVZrQ0pPMHBJNnBRTlRVSmdvVXVDNGF5SVZ3?=
 =?utf-8?B?a0gxMFVUb09RMzRoaXV2QURhb1BMZU5iL1NIY1I4aWFXcklLY1pzWGdjRVUw?=
 =?utf-8?B?b085d3lJOTlXbjc2alJQbHdMa1piM1h1dVZFb29EWEo5a2czdy96QVR4YUVp?=
 =?utf-8?B?NTNuYzg5VVgxT3dhSk1IWkNMNk9pYlUyekJqYjlQNGlETWJHZnNMb1RaVzgx?=
 =?utf-8?B?ZDg3QzFhSkU5WkRlYld1L1l2ei9tRmNVT04vSnA4Rk4zQkFEaU1OZENTQ2NM?=
 =?utf-8?B?VXZIME55Q0VLcTBCbGlLV0hFSHpwSjIxaXFVcnFvYk11NmpMbDViZUtUUWVN?=
 =?utf-8?B?MVF0UUxtc2tUU1lCTDZtMEdhTzJlaTlEcE9EWTgxMThmSnRJajdGLzVXNGJR?=
 =?utf-8?B?QzduOE4wTktsWWdISmlBUUZQWkp3WGdONzQ0MVF5S1BKVE1WVEpQY1BzUVF1?=
 =?utf-8?B?NnZtd2FWdXFjNXBkZktSeTJKbVRHK09LaEdNVUFndCtna2VNeENvSWRDUERO?=
 =?utf-8?B?WGVleDZMYWhzQm51K3B3OHZ6a3ZZcENweXdLWGtWbDlaOTcxejM4ZW9iVU5B?=
 =?utf-8?B?eDYreDRwT1hXVmRzcVVPajNuSU00c1VwWjNueU1FcG1jblRTNVAyUXVmZnhh?=
 =?utf-8?B?M2F1RG0wUG9mYVJsb1h6NHNWV1lZTUxZdGwvSlJoSDNBVlFsSXo0Nk9mWm1Q?=
 =?utf-8?B?cHBBT0cwYU5ZeXNEZFNDcnRmb3hRR1JDYVYyczZzZUtMQk1hYlBnV3Byc2RX?=
 =?utf-8?B?Ykg5dDV2V3ZURXVjSTVRdE9ZNFR0dTh5SG1vWlUrZklIUWNKVmtIbnlKeDAy?=
 =?utf-8?B?eGFzZkVtSVd4ZUhVKzNpUG0xMVdjcWNqNDBieElGSnNPTm1UN1lZR1ErSGI2?=
 =?utf-8?B?RDFTVnA0RnJHZjNVZ3BSS2hKbld4RzhxUVM2ZGxMOGpTVXZVR0o1UXJ0czQ4?=
 =?utf-8?B?UUk2VytkOUNOKzBNanNMRW1kSzN1ZzJNc3BsczdvY1BoQmt2ek8yZklNcXhz?=
 =?utf-8?B?UmFRMXNZcUtXTG9VK3dmQnEyNXFkcXdhSHdib3ZxeTNzcis3VmY2T1BpbEtp?=
 =?utf-8?B?aEwxTDZhSzF0YldUU2MxTUp1OHZuVzhCaGhwSzdJNFFER1E9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(52116014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aTlRczAvdC9PaE50cjU2bG9raHJxVklHaTdYNDFXUVNKWlRmNExWSkt5VVBp?=
 =?utf-8?B?cFZqN0x5c2xMS3ZqQm5mTk1oV3BXYzNycVlSWFg5MzdSTC9tblpuY2gvUXFE?=
 =?utf-8?B?Y05YRWZSdmZma2IyVVFnM3hGZlFVdnpMNDV6SGhvYzYvNk1kTHhsVjN4eVo2?=
 =?utf-8?B?b2c3OWNHUzV1dWREaVl2dUc5elorbFZxd0pkUmNNMTVkTnpobVllOGNBeDkz?=
 =?utf-8?B?SVdhVEVVOWZoRGhrSFpLS0dJVjFmSXBMM2hRc1Z1N0RFb3Q5WjZ0WUxEb2tU?=
 =?utf-8?B?OUNob2xJOTdKdDFkeHlkYVBWbUU5bFVxNC90SXVnV2gwQVozM2NTSnVDT05o?=
 =?utf-8?B?Yy9rSHkyZmpydS9aMkZQOUJCZzFmMEZRdWVFRWx0eEdmb21BK0kwbUFQVEFJ?=
 =?utf-8?B?VHp3OURPcFd1Y3pMUHFHWGlUNjNZQ1hobGM5MmpoSEFBK0tiUEZ2SHVEcXd2?=
 =?utf-8?B?b1pabnhsUDMzdWhoOXAyVWdiVlM5VlAxakJsT2ZaWUJzR2ExRGxJOFdNTXVM?=
 =?utf-8?B?V1k2ejB2SnUwVGNVVzl6RDY4UFkvR3BuSENudkhTRjd3L2dPd2ZhV1FNcDNT?=
 =?utf-8?B?c0pJVGxOd1dYRlJhZ3BsTFR0MWtLSWM2cC9rWWM0WXZWcHZTMEcvR1E2b1lj?=
 =?utf-8?B?dzhZOGJkNHpHcWplZUV5cHlXNGZtbzcvTEY2MEVIVGl0ck9scG80N211N2xK?=
 =?utf-8?B?blE3a3JHT0hwMnhZNytRQ241eTRib3JiZHFFeWlMbGlaQVlnd3hSUHR4Mmt0?=
 =?utf-8?B?bGJmQy80NzV2T0QwdWhPQ3dRVW5laFYvNzJEOFdKTWtxV2xMYXlSZ3RQVXJz?=
 =?utf-8?B?Z2dmcjJ6RERHeVY1ZTV4a1N5UmNHR1RLcGRDWjlQQWNSL2RtMkR0d2w5Qmdr?=
 =?utf-8?B?b0wyS0Y5T1dhOHRRbWlGSXpIOHZRRkEwSTlSOHU4QjZBZjVhOWNSV0syRVVT?=
 =?utf-8?B?UTY4eTRRVEFraldNRzJnOGdLZURxRVFDZWpicXA5NnhrSlJFVDBXbDJRMTlJ?=
 =?utf-8?B?ZVVzcXNLU29WczZQeHptcGNrMkd1UXdTSHpCd1B5dkUrQUpnaXlSbk5VRGFC?=
 =?utf-8?B?eVY1a3IwakgzdWVoTk9JZ2tOSEgyNXZHd0ljV0JxeFI0QVpyaVYyMFQ4Wkdw?=
 =?utf-8?B?eTh1UXRYbmNQMUtrV21ETXpHaUdkVmVlQTVMVTJjUGJDYWErR2g4RGVGcm42?=
 =?utf-8?B?b2gvOXVTUFNNcjRuaEhybXBHTmdTUEw0cTMxUHAvdXkxT0t4cksvN0k1NEQ5?=
 =?utf-8?B?aG9mMjZVSkwrVnNxY3JjYk5aaTBtMnNNWTZlVy9VTEtjNTUza3paZ2hQS0Vn?=
 =?utf-8?B?bGlYMDlvbE9hNEw5S25yWFRlNkFXYit2TlBhZjNBN0RrSUg4V1JIMVhuZmF3?=
 =?utf-8?B?cXlqY0F1ZWFtK3U4WGtzdU5KNFEzckFEQlZWdjVPK09oUzdSTzh5ZmpXckJq?=
 =?utf-8?B?anFUYXQ3eUZzaUpLbW9uU0dNK09VcDdob1NQd25DbmFrL2xvWERuVCtRRWxH?=
 =?utf-8?B?Mjl2U3hyOWhpOXVnckFxckdkS001VW5VQWVtQ0xRMXVKZnZLV2s4QjlWZ0RL?=
 =?utf-8?B?aVYyTzhyMFJtajk2TmNnK0pZWHlhaXpoN0Uvdlh4UmpWRHRGSEcyZG9ESmdk?=
 =?utf-8?B?ODBmWWdlSzU2c0s1MUJlUXNvY2cxWUZQamNVRmdVQTNkbmhZZVpTNzFWVUlS?=
 =?utf-8?B?TDBGWXRudDJwd3JqaFVKMHFKaE1CclhvaDJaaC9wcG8rY1pMV2RjZC9kQkcr?=
 =?utf-8?B?VnFiQUNJN2FnV1J1bE1sY2N0cVZ6QnhTY0dCdTJOVCsrVnI1cEo1SHRYL3VR?=
 =?utf-8?B?bGdiZkllRU1XK2k2cmRBN1RPRmxxYU8rVWhiVVphM05kNTl3eTdrL2R6cFdC?=
 =?utf-8?B?K25mcVJrdTgzZnJTcHB1NGZ0Ym0vbEhpYmxUQlJBaUpIcUtFaFpzNzIyWGJ4?=
 =?utf-8?B?c0FmOGZJR3ViVWw1am1VTDNsSVY2RWpQODVyOVBqSlo1OXNSWkthZXNXdUhV?=
 =?utf-8?B?cGx1QTgwbVZtY1NZa2drdTZCUW1hYkFQemtBTHFpQ05rNUNKR3Qrdi9iZ1cx?=
 =?utf-8?B?TktEQURuMEp4OVlxU2pFQm1qd2VyMENIUEdQa1BLamJqeFYvaGh0SGNjRUdw?=
 =?utf-8?Q?8p+/wyhtYX7KPQDogTg5suBk0?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c01a988-db29-4a5f-3f1a-08dce23bbbd4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 17:08:56.2788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8LAI+V/8CMcsQSf61t+tPEBvjB5P0ArLon33mQnlruYUV+rGjS88dWKfaWI49OPVRup6g6RPjZdX+gaKj1S4Cg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9710

Extend the address status bit to 4 and introduce the I3C_ADDR_SLOT_EXT_INIT
macro to indicate that a device prefers a specific address. This is
generally set by the 'assigned-address' in the device tree source (dts)
file.

 ┌────┬─────────────┬───┬─────────┬───┐
 │S/Sr│ 7'h7E RnW=0 │ACK│ ENTDAA  │ T ├────┐
 └────┴─────────────┴───┴─────────┴───┘    │
 ┌─────────────────────────────────────────┘
 │  ┌──┬─────────────┬───┬─────────────────┬────────────────┬───┬─────────┐
 └─►│Sr│7'h7E RnW=1  │ACK│48bit UID BCR DCR│Assign 7bit Addr│PAR│ ACK/NACK│
    └──┴─────────────┴───┴─────────────────┴────────────────┴───┴─────────┘

Some master controllers (such as HCI) need to prepare the entire above
transaction before sending it out to the I3C bus. This means that a 7-bit
dynamic address needs to be allocated before knowing the target device's
UID information.

However, some I3C targets want a specific address (called as
"init_dyn_addr"), which is typically specified by the DT's assigned-address
property. (Lower addresses have higher IBI priority, and the target can
adjust this by using the assigned-address property if using DT). The
function i3c_master_add_i3c_dev_locked() will switch to this
"init_dyn_addr" if it is not in use.

Therefore, i3c_bus_get_free_addr() should return a free address that has
not been claimed by any target devices as "init_dyn_addr" (indicated by
I3C_ADDR_SLOT_EXT_INIT). This allows the device with the "init_dyn_addr"
to switch to its "init_dyn_addr" when it hot-joins the I3C bus. Otherwise,
if the "init_dyn_addr" is already in use by another I3C device, the target
device will not be able to switch to its desired address.

If all of above address are already used, i3c_bus_get_free_addr() return
one from the claimed as init_dyn_addr and free address slot. This ensures
support devices as much as possible.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v3 to v4
- rewrite commit message and comment for i3c_bus_get_free_addr()
---
 drivers/i3c/master.c       | 68 ++++++++++++++++++++++++++++++++++++++++------
 include/linux/i3c/master.h |  7 +++--
 2 files changed, 64 insertions(+), 11 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index dcf8d23c5941a..a56cb281e6b6d 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -345,7 +345,7 @@ const struct bus_type i3c_bus_type = {
 EXPORT_SYMBOL_GPL(i3c_bus_type);
 
 static enum i3c_addr_slot_status
-i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
+i3c_bus_get_addr_slot_status_ext(struct i3c_bus *bus, u16 addr)
 {
 	unsigned long status;
 	int bitpos = addr * I3C_ADDR_SLOT_STATUS_BITS;
@@ -356,11 +356,17 @@ i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
 	status = bus->addrslots[bitpos / BITS_PER_LONG];
 	status >>= bitpos % BITS_PER_LONG;
 
-	return status & I3C_ADDR_SLOT_STATUS_MASK;
+	return status & I3C_ADDR_SLOT_EXT_STATUS_MASK;
 }
 
-static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
-					 enum i3c_addr_slot_status status)
+static enum i3c_addr_slot_status
+i3c_bus_get_addr_slot_status(struct i3c_bus *bus, u16 addr)
+{
+	return i3c_bus_get_addr_slot_status_ext(bus, addr) & I3C_ADDR_SLOT_STATUS_MASK;
+}
+
+static void i3c_bus_set_addr_slot_status_mask(struct i3c_bus *bus, u16 addr,
+					      enum i3c_addr_slot_status status, int mask)
 {
 	int bitpos = addr * I3C_ADDR_SLOT_STATUS_BITS;
 	unsigned long *ptr;
@@ -369,11 +375,22 @@ static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
 		return;
 
 	ptr = bus->addrslots + (bitpos / BITS_PER_LONG);
-	*ptr &= ~((unsigned long)I3C_ADDR_SLOT_STATUS_MASK <<
-						(bitpos % BITS_PER_LONG));
+	*ptr &= ~((unsigned long)mask << (bitpos % BITS_PER_LONG));
 	*ptr |= (unsigned long)status << (bitpos % BITS_PER_LONG);
 }
 
+static void i3c_bus_set_addr_slot_status(struct i3c_bus *bus, u16 addr,
+					 enum i3c_addr_slot_status status)
+{
+	i3c_bus_set_addr_slot_status_mask(bus, addr, status, I3C_ADDR_SLOT_STATUS_MASK);
+}
+
+static void i3c_bus_set_addr_slot_status_ext(struct i3c_bus *bus, u16 addr,
+					     enum i3c_addr_slot_status status)
+{
+	i3c_bus_set_addr_slot_status_mask(bus, addr, status, I3C_ADDR_SLOT_EXT_STATUS_MASK);
+}
+
 static bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr)
 {
 	enum i3c_addr_slot_status status;
@@ -383,11 +400,44 @@ static bool i3c_bus_dev_addr_is_avail(struct i3c_bus *bus, u8 addr)
 	return status == I3C_ADDR_SLOT_FREE;
 }
 
+/*
+ * ┌────┬─────────────┬───┬─────────┬───┐
+ * │S/Sr│ 7'h7E RnW=0 │ACK│ ENTDAA  │ T ├────┐
+ * └────┴─────────────┴───┴─────────┴───┘    │
+ * ┌─────────────────────────────────────────┘
+ * │  ┌──┬─────────────┬───┬─────────────────┬────────────────┬───┬─────────┐
+ * └─►│Sr│7'h7E RnW=1  │ACK│48bit UID BCR DCR│Assign 7bit Addr│PAR│ ACK/NACK│
+ *    └──┴─────────────┴───┴─────────────────┴────────────────┴───┴─────────┘
+ * Some master controllers (such as HCI) need to prepare the entire above transaction before
+ * sending it out to the I3C bus. This means that a 7-bit dynamic address needs to be allocated
+ * before knowing the target device's UID information.
+ *
+ * However, some I3C targets want a specific address (called as "init_dyn_addr"), which is
+ * typically specified by the DT's assigned-address property. (Lower addresses have higher IBI
+ * priority, and the target can adjust this by using the assigned-address property if using DT).
+ * The function i3c_master_add_i3c_dev_locked() will switch to this "init_dyn_addr" if it is not
+ * in use.
+ *
+ * Therefore, i3c_bus_get_free_addr() should return a free address that has not been claimed by any
+ * target devices as "init_dyn_addr". This allows the device with the "init_dyn_addr" to switch to
+ * its "init_dyn_addr" when it hot-joins the I3C bus. Otherwise, if the "init_dyn_addr" is already
+ * in use by another I3C device, the target device will not be able to switch to its desired
+ * address.
+ *
+ * If all of above address are already used, i3c_bus_get_free_addr() return one from the claimed as
+ * init_dyn_addr and free address slot. This ensures support devices as much as possible.
+ */
 static int i3c_bus_get_free_addr(struct i3c_bus *bus, u8 start_addr)
 {
 	enum i3c_addr_slot_status status;
 	u8 addr;
 
+	for (addr = start_addr; addr < I3C_MAX_ADDR; addr++) {
+		status = i3c_bus_get_addr_slot_status_ext(bus, addr);
+		if (status == I3C_ADDR_SLOT_FREE)
+			return addr;
+	}
+
 	for (addr = start_addr; addr < I3C_MAX_ADDR; addr++) {
 		status = i3c_bus_get_addr_slot_status(bus, addr);
 		if (status == I3C_ADDR_SLOT_FREE)
@@ -1918,9 +1968,9 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
 			goto err_rstdaa;
 		}
 
-		i3c_bus_set_addr_slot_status(&master->bus,
-					     i3cboardinfo->init_dyn_addr,
-					     I3C_ADDR_SLOT_I3C_DEV);
+		i3c_bus_set_addr_slot_status_ext(&master->bus,
+						 i3cboardinfo->init_dyn_addr,
+						 I3C_ADDR_SLOT_I3C_DEV | I3C_ADDR_SLOT_EXT_INIT);
 
 		/*
 		 * Only try to create/attach devices that have a static
diff --git a/include/linux/i3c/master.h b/include/linux/i3c/master.h
index 2100547b2d8d2..57ad6044ac856 100644
--- a/include/linux/i3c/master.h
+++ b/include/linux/i3c/master.h
@@ -298,7 +298,8 @@ enum i3c_open_drain_speed {
  * @I3C_ADDR_SLOT_I2C_DEV: address is assigned to an I2C device
  * @I3C_ADDR_SLOT_I3C_DEV: address is assigned to an I3C device
  * @I3C_ADDR_SLOT_STATUS_MASK: address slot mask
- *
+ * @I3C_ADDR_SLOT_EXT_INIT: the bitmask represents addresses that are preferred by some devices,
+ *			    such as the "assigned-address" property in a device tree source (DTS).
  * On an I3C bus, addresses are assigned dynamically, and we need to know which
  * addresses are free to use and which ones are already assigned.
  *
@@ -311,9 +312,11 @@ enum i3c_addr_slot_status {
 	I3C_ADDR_SLOT_I2C_DEV,
 	I3C_ADDR_SLOT_I3C_DEV,
 	I3C_ADDR_SLOT_STATUS_MASK = 3,
+	I3C_ADDR_SLOT_EXT_STATUS_MASK = 7,
+	I3C_ADDR_SLOT_EXT_INIT = BIT(2),
 };
 
-#define I3C_ADDR_SLOT_STATUS_BITS 2
+#define I3C_ADDR_SLOT_STATUS_BITS 4
 
 /**
  * struct i3c_bus - I3C bus object

-- 
2.34.1


