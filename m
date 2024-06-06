Return-Path: <linux-kernel+bounces-204910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E0E88FF4E7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 20:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EE1C282C94
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 18:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8E14E1D6;
	Thu,  6 Jun 2024 18:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="EPkZeTTo"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2075.outbound.protection.outlook.com [40.107.21.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13C7554FAF;
	Thu,  6 Jun 2024 18:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717699647; cv=fail; b=gz2cNbZoL3RaDJDSpfkEYVwPWQIqskbfuv6M3npOckl6ui5Mipu5EG1z19f27Bgr1yF/YnFgGLrrhq7sjOBQR1nqv1z4SXIceAB5PIX7wqOe+/wf2J7H1X2UVwordHgyN0SFVNWiE4mKnEPUWZUkE3QXgHDc6zwsFLp9wTTlZ4A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717699647; c=relaxed/simple;
	bh=woZl32LsPM90+cbZ0hBx3TO93OcOsNDJO7ghpq27th4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=IWYMJolwLuKe/qNOSd3+cVRIP/Cr5CpvHEC6xjVzEetjvjfQJkSDAn7jAbaWQ/GYIRWMQNSeN69ecaXFBWUrYyEo27pl39pdxWTeAWHBu1Kh2YghQzVxPtTh7Fg6xIagADs2heR4pwY/644mO58Dw/Qm17A2E9YE7Nkfbss7D8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=EPkZeTTo; arc=fail smtp.client-ip=40.107.21.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NdUlTx3WtNbhUfPJyIjz9+boZRnOPATMpRtV0i3B6Ca1b2ZCi9WeMl7oX8F6ByIbzZGVR4HJ/t4SKI0Qw6xhX94oycMUcJb7i5Qmbt2jLzZy7bnw8kYefpjgfU/wlULhnZFHirNpL3CTiFTWKghvPe8IQwLSbR+hqEF9V9j6vgP+yGEfac/gq+y9yZjd3b9rR7qcZ5zLmwDQdy7sn+IdxT2Mq/HOoGy0x078aVBr7iWEg+060Piga7ETc5fFRm8JargShUQ2TFn5N8nCeIvLRdYoPIgY/HEfAL5xNg7kNKmqKDHiVT7qkVu0RS8H2pDNQEj0Ck6jzZsX4gJ5UvRhlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BBOyMsKcgfnqOIXjklRaVSAY4hGLqCd/Nto0kUlHcmg=;
 b=RP9TRDP1zqu/MVlqc2jNpXk0POpu7OUBnQVNAgy9tkQpVa5/HSlu6ZSpK5dqriQUOkhRG55fKEZBdAuzxp+2xT6d+hgCVyy2MmWbOVo00O0qMjuEZQ4ZvhCrxEDIYBDcgpjm9qzlzDZzFeh0gHAO4sxciR+5rDVOU5Gj99NSOPhzz5Vd81LhUoWo4oDwKy4eMqMPZAI9Sig/TqQQiDO+TfUtPzUiuy6eF3dHmK5pOCtyhYl4NutTZpyXohW6gPyZKJ3t8AATeuz4WMk8P92ALx7ZDDbHMjZS38dRR3AzgoC14A+1WRIN1zw1cj6r3XRP30WWYvx88Zv2qw9AzRi8gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BBOyMsKcgfnqOIXjklRaVSAY4hGLqCd/Nto0kUlHcmg=;
 b=EPkZeTToWS8Y4XqUk7rFzu5/KdNqCUeZQ/D5REM6yLRAoX45fMGV5rpbITFCHfWO0Kuuht6GzVArhM/IjWnB7NEouNBTFILAj5VqQWIFZqR9RYqO14osEq74ewPpZM6lOULwQBfTO4uNhu5pohSd7le6fpy53UrBqJLovon8JyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB11069.eurprd04.prod.outlook.com (2603:10a6:800:266::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Thu, 6 Jun
 2024 18:47:22 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 18:47:22 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Thu, 06 Jun 2024 14:46:56 -0400
Subject: [PATCH 2/7] arm64: dts: imx8qm: add mipi subsystem
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-imx8qm-dts-usb-v1-2-565721b64f25@nxp.com>
References: <20240606-imx8qm-dts-usb-v1-0-565721b64f25@nxp.com>
In-Reply-To: <20240606-imx8qm-dts-usb-v1-0-565721b64f25@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717699632; l=10395;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=woZl32LsPM90+cbZ0hBx3TO93OcOsNDJO7ghpq27th4=;
 b=9hW1H4XQ0wXcsWiegOEfaPoa+mGlJcihGnx91YHyRTwszK/ojZ2xmlh/WBezHByQ68NazDUp9
 BBMUQzyxPAjBxK8lZU6hvF8ZDZ9rDK7Yh+tgNk5XfRxTbU/6fr5Aasi
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0178.namprd05.prod.outlook.com
 (2603:10b6:a03:339::33) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB11069:EE_
X-MS-Office365-Filtering-Correlation-Id: a5c63fec-5518-4263-8101-08dc865919bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|52116005|376005|1800799015|7416005|366007|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NHJERjJETUJlenZDOEtJQW4zYnhuNjFRaUtaNkpIWTkwQzZaNlpTVzZLTGsw?=
 =?utf-8?B?bnc5bFpLS3Rhc0ZLRWlzUUx5bmE5RGFHZlRzZUR4b3FwNUxmTUhWcnVFVHhi?=
 =?utf-8?B?dFlmVzFJbG1WQlh4UEtCSzJ1eHR1S3Z0T2xOUG9NNmtOck12cTJac3k3UTFU?=
 =?utf-8?B?cGJpN3dVVVQvRjliWTJmUHN5Z25YclV4QVZxdUp0b0dvcU9sMW5pRDNHekE2?=
 =?utf-8?B?QkUrTFdNb1YzTFA3dkIyK1ZyVE1NY1ZaaERMZy84d2hUSmJFT0tpNnlxMUpp?=
 =?utf-8?B?WWo2UFo1QUR2ZlAxdXlweTZjMWd1WWxlV1JVVEhDN05UMWZja3pja3o4OHFj?=
 =?utf-8?B?Y1BIa0QzWVRqN1VGWjQzV25CenhKTWhOWGRJNU9lUmNLaENQUmNCekV2bCt6?=
 =?utf-8?B?Z0tCaHdXN0JqUWFUb05oNVg3c0xSNTJGd2JZZnVKVWFObmtrWTVPZkZOR05v?=
 =?utf-8?B?RERrZnJ3ZlpJWDR4M0t3Qjl6c01iS0VyRVVlZW1DVXozY2NjSnRjUkpHVHpw?=
 =?utf-8?B?M3B3alFQSDZDT3FHVnQ2OUQ4MTF3TEFNT1ZLaFU3aStNNG1jeEVPaW9wMUxS?=
 =?utf-8?B?MWNxMTNTSHlqZkxxMHZyUDl3WkVhaDZFWktqa01DekxuVzVXOFRmdDgzMTY1?=
 =?utf-8?B?eHJnSlVjbHZ3NEVxYTRNY0dnTDY1TlpSN2dMc1RRcDFiT3ZwaVZBMkdsQWNZ?=
 =?utf-8?B?aHNyMGdGSlUrMFdRaGwvWGdCeEJMZGxlcGNpVzcvY2J2NEFqZXVndWozMGhU?=
 =?utf-8?B?enpKZ0JMSFVMNy81d0FDcklTYVhHdWFBQ1N1eC9zdllKdlg3TDFCNzlnb0RJ?=
 =?utf-8?B?aUFFdDJjZ2JaNWI0V3V0SDV5RDJiTnViSVRsc0cvYTc2QytvRjV2OEkzdDA1?=
 =?utf-8?B?Q1ZvdWZveDNxaDBpSys3aWcvUzVXNTFWOUZ6d0lwWlZNLzVaSFF3Mi82WXpu?=
 =?utf-8?B?cm5aZFUzaEFhVXRidVphQ2lyV3FZNkdtRFlFbW1iQjUvSC9RTEhzWU0rcDhU?=
 =?utf-8?B?SVcvS3h3VFNlYUVqZUNvSVd2S09NOGpGc2dmR2NRVERDbVU0ZFkra1RaSmpw?=
 =?utf-8?B?WE5OTHVDVHJGbXpEdGd6TkQyQkFSQXpuZFFMZEhCV01zM29aYmYrYnQyRnR5?=
 =?utf-8?B?OHZyWVdmNk1sVGtpNkFGMi9FRDQreThFeEIxREVwblZKSUtNTFkzVENZRHEv?=
 =?utf-8?B?ekY2c081MktNb28yZHNIK2FPalFVNlpuNFMrZVBiQ3M1ckJ4Qkxxbjl2T211?=
 =?utf-8?B?b2Q5dDd5Y2MrWnpKQW81YmFSUkVDYTlMdUsvblZQUi9sSTdCTC9tZVV4UUpq?=
 =?utf-8?B?OVFPK3JGYW96dk1sUU1RQU16YnkycjBrTXh1ekFPWlBLMys0UlFnQ2V5Q3I2?=
 =?utf-8?B?dHRrMG9HMzVvLzl6S25ZN1ptN2lNWkhJeDRzOGV0bWJZZUNIQ1F5WWoxRmh4?=
 =?utf-8?B?U0g5OVo4d3gzcFMyMjBFM0p0dExqeEErZUhNSjJMc0pwSHVBT0JJd0pDVlZz?=
 =?utf-8?B?bkxQcnVObEYrVlM3bWZKQWJ4NHdtRUtwcXNGTXRvYVlvMXBTMWdIYlBObXFX?=
 =?utf-8?B?UnRpVFlHQjJXUXNhUW1WTmRmdnZsQTN6blZSUk9iUWtJUUkwS3c0eXgwTVNN?=
 =?utf-8?B?cUJTU3laRk5jT20wUkM5Nlc0UWtiK1kzTEZaTmdJNnZMNktiWTFXMmFxU3JU?=
 =?utf-8?B?WEhRZmY1blVzVXRHMGNhdHYwM1FJUXRIbE5QWVBsempjS3RYNEpBZSttODUz?=
 =?utf-8?B?VEIyS3pNb3BSVVdsM1FHN1JmNDB1RkR5WG1iM01uMHNtUXNjTG1pTW96YVk5?=
 =?utf-8?Q?284YhclWhlaULR/nR//buUBVBCet+Sg1zu0LE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(1800799015)(7416005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bURHWHcyNmNoWWxiMHFsSzB1T1BSZGpSK3haWmcxTXpKSmdiMVpNM0dHQUYr?=
 =?utf-8?B?YWJMb1I3NkNiUXZFQ3BzaFRraGlFTTJ1endtQ1dlV3hES2FVVlR3ZGpyOVNY?=
 =?utf-8?B?dWRpa01ldmpXRGRNVWJRTm4xT0ZzTHl5TlV1eVFjSWJ2MHRkeFBNNEhoOXVL?=
 =?utf-8?B?UlRidUJFMDJDcWZqSTZxRXJjYk9yZk1IVUVtOEUydnpJS01FWXJMcEkzWTdJ?=
 =?utf-8?B?N2NjUFcxMS9Vem9jR2VhYTMwWk5XdldxRytLRkJmQ0RQQjFMUUNaaElwMFhj?=
 =?utf-8?B?bUNJOERMeHN6bXFwRkV6eHZkUG5xbDVOelNtbGxQb2tKdWZBSWhlaE0xcGVs?=
 =?utf-8?B?NzkxV1NpVkxzOFhaTXdBN2sveXRUM1JxOWNPT0pvVjZFQ0RFMkR3ZlQySnE0?=
 =?utf-8?B?WGttejdabThIdlpCSFRqRVNjSXlMT24rcjdLVFhUaEhKekEvRGI4b2Y0bDBJ?=
 =?utf-8?B?K3hnOHdpYU1UK0Z2TFFoQlNQdFd3Lyt2NE4vQ0wvUTFzSGliNFQ0ZVU1RzRa?=
 =?utf-8?B?ZUMrUmd6a1UxMkdhaGM0NElsYlpwRHljL3dnMXZNQk5tRlFCVTF4am0zUjg4?=
 =?utf-8?B?QXZ4cHp2Nng5RWplRW1KZlFzT3JNQ3piT0YyYVJYZE81QzIrL093bkhuYlRw?=
 =?utf-8?B?VFhGREV1Z0JGNFFVc29RdkZTKzU0MVZEV096TXhNdXhubEp6MkN2eDJZWkpi?=
 =?utf-8?B?dHY0VnY1Wmw1N0VSTTlvOXJqMFlqZVJ4WWpGRkp0UUVuRUwyamwyZTYxdWpR?=
 =?utf-8?B?dm94TGFFMVR4bDFiNzJOY2RSbWJLK0xzd1I1byt4OFJqOFpFdnR3c2FxWW1r?=
 =?utf-8?B?UzJQVjdqWW1tNTh0TFJKV2ZZQUZkM0lPVDE3b0FNSS9iaHBjSk9BZzBHbkNX?=
 =?utf-8?B?WUl3NjFpY2JrNm1zWS92bWcybkhIZ2ZlUVNWTHV5WmlOSnlhejBpNy8veG5C?=
 =?utf-8?B?VERmbkpsVXo4NHpvTWtMcHAvNVNrMkwzckNmbjlOQkdKN1ZBYklkdExQMVFq?=
 =?utf-8?B?MDN5dVh1dVZOT1IwMUtOREdueGFHcCt4aUxNRU9hYUhIQUxIWWVTYkw1QmhS?=
 =?utf-8?B?NnhuS2lwZFBXQUN2N0RPem5sN1EvbUJvMkQ1Umx1N1NrUlZCLzRYY2xsZVFY?=
 =?utf-8?B?K2lBaDRlL2VmWUtXMkNBc0pPdDgrR0hrdFA0UjFFaUpYVG9QLzZSckRkK2lS?=
 =?utf-8?B?TnFrQU1oZWZTajByRnRxMmpGaUVndFFLQ0ZNcXc2aGpSYTdiV2c0WHNaZmNj?=
 =?utf-8?B?OEFxQ3BOLzlKaVpWWGRWeXZuODNlZGV6MGxWVlVqS3R4Z0k3MFVKb3FkdDRH?=
 =?utf-8?B?RjZ3ZnJkSGdtaTRLN0lvb0dDVEx0bEx0Y3NCRUhYZVFyMWd6VTBIOHlxWEVO?=
 =?utf-8?B?TVhqOHd1Yk4vR1FyWk12OFZaamdFTXhnWEt1bURGVnBhcUtuSmhlVkhPeXNW?=
 =?utf-8?B?dkpRemJpeC9rQ3N5amtmbWhZSG1tb01WWlNDK1FiY0JHZXB5QUZ4TUVRVGRN?=
 =?utf-8?B?STMwbmdKVnNWcGhCMEQwKzQ3SFhRWk11SmJpYzhRTmM1M0JLdndtejBESUFp?=
 =?utf-8?B?WVltdE9GK1AwQytCaVFzSVNmZEd0bmtXV2hGeU9vVkpTVjFwc3NQZ3RMRTRs?=
 =?utf-8?B?NkNZcUdvZHJLRXJnZVJXZjBaVHc0dGNhZE5YekxwK1pTcVdSdTEzMjhQS0hE?=
 =?utf-8?B?ajByL3BhdTllMUxySjJVUFhFZ1FZUHkremFvcFhiMkxycjVHelZ2ZjY4UXB6?=
 =?utf-8?B?OElhSC9Wcm9OWFlrbjJSMXJuN2Raa0NIenJVY3ByMzdidjBmbksrazdDNmdu?=
 =?utf-8?B?emdoMkcxSGtIOWR4bWJkSWJSUHhiK2k4WUlybzBvZERoQVV4ZzR3Z1VHOStV?=
 =?utf-8?B?Rit2WnpPck1teXp1UEJ6aW4zUVNCMDNvYlZOTmZUdkpUQUVBeXBDa2E2T3Zv?=
 =?utf-8?B?c0Jpd3REMHNnTUx0NTZaQTNqNkZ1aHB3YXI0RDNrS1kyeGlyOVdTNnNHdjFq?=
 =?utf-8?B?bnFodWtma1lQYVBiVXNxQXNtUDRoR0p6WWliRHdxMG93Rkd4YWxJRzVaTFJn?=
 =?utf-8?B?cUlkbnVMd0xmdVBZUGlTN0NmQndXVFZMd2JZYUVlZDJLUXFNV2Jwak5PVWNL?=
 =?utf-8?Q?pbxaKbyr1+pc9nILCXRsPZuGc?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c63fec-5518-4263-8101-08dc865919bb
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 18:47:22.2357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NyY9cxsZhS40fKAlEcQsVp9ZA13Cp1Cq2sGNWBSjIPOV7DNsx/bumcfFhRQiMWaghZkH5hraxrmS40GcmSDvwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11069

Add irqstear, pwm and i2c in mipi subsystem.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-ss-mipi.dtsi | 286 ++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx8qm.dtsi         |   1 +
 2 files changed, 287 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-ss-mipi.dtsi b/arch/arm64/boot/dts/freescale/imx8qm-ss-mipi.dtsi
new file mode 100644
index 0000000000000..bd18468923e52
--- /dev/null
+++ b/arch/arm64/boot/dts/freescale/imx8qm-ss-mipi.dtsi
@@ -0,0 +1,286 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+/*
+ * Copyright 2024 NXP
+ */
+
+/ {
+	dsi_ipg_clk: clock-dsi-ipg {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <120000000>;
+		clock-output-names = "dsi_ipg_clk";
+	};
+
+	mipi_pll_div2_clk: clock-mipi-div2-pll {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <432000000>;
+		clock-output-names = "mipi_pll_div2_clk";
+	};
+
+	mipi0_subsys: bus@56220000 {
+		compatible = "simple-bus";
+		interrupt-parent = <&irqsteer_mipi0>;
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x56220000 0x0 0x56220000 0x10000>;
+
+		irqsteer_mipi0: interrupt-controller@56220000 {
+			compatible = "fsl,imx-irqsteer";
+			reg = <0x56220000 0x1000>;
+			interrupts = <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			interrupt-parent = <&gic>;
+			#interrupt-cells = <1>;
+			clocks = <&mipi0_lis_lpcg IMX_LPCG_CLK_0>;
+			clock-names = "ipg";
+			power-domains = <&pd IMX_SC_R_MIPI_0>;
+			fsl,channel = <0>;
+			fsl,num-irqs = <32>;
+		};
+
+		mipi0_lis_lpcg: clock-controller@56223000 {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x56223000 0x4>;
+			#clock-cells = <1>;
+			clocks = <&dsi_ipg_clk>;
+			clock-indices = <IMX_LPCG_CLK_0>;
+			clock-output-names = "mipi0_lis_lpcg_ipg_clk";
+			power-domains = <&pd IMX_SC_R_MIPI_0>;
+		};
+
+		mipi0_pwm_lpcg: clock-controller@5622300c {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x5622300c 0x4>;
+			#clock-cells = <1>;
+			clocks = <&clk IMX_SC_R_MIPI_0_PWM_0 IMX_SC_PM_CLK_PER>,
+				 <&dsi_ipg_clk>;
+			clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+			clock-output-names = "mipi0_pwm_lpcg_clk",
+					     "mipi0_pwm_lpcg_ipg_clk";
+			power-domains = <&pd IMX_SC_R_MIPI_0_PWM_0>;
+		};
+
+		mipi0_i2c0_lpcg_ipg_clk: clock-controller@56223014 {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x56223014 0x4>;
+			#clock-cells = <1>;
+			clocks = <&mipi0_i2c0_lpcg_ipg_s_clk IMX_LPCG_CLK_0>;
+			clock-indices = <IMX_LPCG_CLK_0>;
+			clock-output-names = "mipi0_i2c0_lpcg_ipg_clk";
+			power-domains = <&pd IMX_SC_R_MIPI_0_I2C_0>;
+		};
+
+		mipi0_i2c0_lpcg_ipg_s_clk: clock-controller@56223018 {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x56223018 0x4>;
+			#clock-cells = <1>;
+			clocks = <&dsi_ipg_clk>;
+			clock-indices = <IMX_LPCG_CLK_0>;
+			clock-output-names = "mipi0_i2c0_lpcg_ipg_s_clk";
+			power-domains = <&pd IMX_SC_R_MIPI_0_I2C_0>;
+		};
+
+		mipi0_i2c0_lpcg_clk: clock-controller@5622301c {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x5622301c 0x4>;
+			#clock-cells = <1>;
+			clocks = <&clk IMX_SC_R_MIPI_0_I2C_0 IMX_SC_PM_CLK_MISC2>;
+			clock-indices = <IMX_LPCG_CLK_0>;
+			clock-output-names = "mipi0_i2c0_lpcg_clk";
+			power-domains = <&pd IMX_SC_R_MIPI_0_I2C_0>;
+		};
+
+		mipi0_i2c1_lpcg_ipg_clk: clock-controller@56223024 {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x56223024 0x4>;
+			#clock-cells = <1>;
+			clocks = <&mipi0_i2c1_lpcg_ipg_s_clk IMX_LPCG_CLK_0>;
+			clock-indices = <IMX_LPCG_CLK_0>;
+			clock-output-names = "mipi0_i2c1_lpcg_ipg_clk";
+			power-domains = <&pd IMX_SC_R_MIPI_0_I2C_1>;
+		};
+
+		mipi0_i2c1_lpcg_clk: clock-controller@5622302c {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x5622302c 0x4>;
+			#clock-cells = <1>;
+			clocks = <&clk IMX_SC_R_MIPI_0_I2C_1 IMX_SC_PM_CLK_MISC2>;
+			clock-indices = <IMX_LPCG_CLK_0>;
+			clock-output-names = "mipi0_i2c1_lpcg_clk";
+			power-domains = <&pd IMX_SC_R_MIPI_0_I2C_1>;
+		};
+
+		mipi0_i2c1_lpcg_ipg_s_clk: clock-controller@56223028 {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x56223028 0x4>;
+			#clock-cells = <1>;
+			clocks = <&dsi_ipg_clk>;
+			clock-indices = <IMX_LPCG_CLK_0>;
+			clock-output-names = "mipi0_i2c1_lpcg_ipg_s_clk";
+			power-domains = <&pd IMX_SC_R_MIPI_0_I2C_1>;
+		};
+
+		pwm_mipi0: pwm@56224000 {
+			compatible = "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
+			reg = <0x56224000 0x1000>;
+			clocks = <&mipi0_pwm_lpcg IMX_LPCG_CLK_4>,
+				 <&mipi0_pwm_lpcg IMX_LPCG_CLK_0>;
+			clock-names = "ipg", "per";
+			assigned-clocks = <&clk IMX_SC_R_MIPI_0_PWM_0 IMX_SC_PM_CLK_PER>;
+			assigned-clock-rates = <24000000>;
+			#pwm-cells = <3>;
+			power-domains = <&pd IMX_SC_R_MIPI_0_PWM_0>;
+			status = "disabled";
+		};
+
+		i2c0_mipi0: i2c@56226000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
+			reg = <0x56226000 0x1000>;
+			interrupts = <8>;
+			clocks = <&mipi0_i2c0_lpcg_clk IMX_LPCG_CLK_0>,
+				 <&mipi0_i2c0_lpcg_ipg_clk IMX_LPCG_CLK_0>;
+			clock-names = "per", "ipg";
+			assigned-clocks = <&mipi0_i2c0_lpcg_clk IMX_LPCG_CLK_0>;
+			assigned-clock-rates = <24000000>;
+			power-domains = <&pd IMX_SC_R_MIPI_0_I2C_0>;
+			status = "disabled";
+		};
+	};
+
+	mipi1_subsys: bus@57220000 {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x57220000 0x0 0x57220000 0x10000>;
+
+		irqsteer_mipi1: interrupt-controller@57220000 {
+			compatible = "fsl,imx-irqsteer";
+			reg = <0x57220000 0x1000>;
+			interrupts = <GIC_SPI 60 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			interrupt-parent = <&gic>;
+			#interrupt-cells = <1>;
+			clocks = <&mipi1_lis_lpcg IMX_LPCG_CLK_0>;
+			clock-names = "ipg";
+			power-domains = <&pd IMX_SC_R_MIPI_1>;
+			fsl,channel = <0>;
+			fsl,num-irqs = <32>;
+		};
+
+		mipi1_lis_lpcg: clock-controller@57223000 {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x57223000 0x4>;
+			#clock-cells = <1>;
+			clocks = <&dsi_ipg_clk>;
+			clock-indices = <IMX_LPCG_CLK_0>;
+			clock-output-names = "mipi1_lis_lpcg_ipg_clk";
+			power-domains = <&pd IMX_SC_R_MIPI_1>;
+		};
+
+		mipi1_pwm_lpcg: clock-controller@5722300c {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x5722300c 0x4>;
+			#clock-cells = <1>;
+			clocks = <&clk IMX_SC_R_MIPI_1_PWM_0 IMX_SC_PM_CLK_PER>,
+				 <&dsi_ipg_clk>;
+			clock-indices = <IMX_LPCG_CLK_0>, <IMX_LPCG_CLK_4>;
+			clock-output-names = "mipi1_pwm_lpcg_clk",
+					     "mipi1_pwm_lpcg_ipg_clk";
+			power-domains = <&pd IMX_SC_R_MIPI_1_PWM_0>;
+		};
+
+		mipi1_i2c0_lpcg_clk: clock-controller@5722301c {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x5722301c 0x4>;
+			#clock-cells = <1>;
+			clocks = <&clk IMX_SC_R_MIPI_1_I2C_0 IMX_SC_PM_CLK_MISC2>;
+			clock-indices = <IMX_LPCG_CLK_0>;
+			clock-output-names = "mipi1_i2c0_lpcg_clk";
+			power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
+		};
+
+		mipi1_i2c0_lpcg_ipg_clk: clock-controller@57223014 {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x57223014 0x4>;
+			#clock-cells = <1>;
+			clocks = <&mipi1_i2c0_lpcg_ipg_s_clk IMX_LPCG_CLK_0>;
+			clock-indices = <IMX_LPCG_CLK_0>;
+			clock-output-names = "mipi1_i2c0_lpcg_ipg_clk";
+			power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
+		};
+
+		mipi1_i2c0_lpcg_ipg_s_clk: clock-controller@57223018 {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x57223018 0x4>;
+			#clock-cells = <1>;
+			clocks = <&dsi_ipg_clk>;
+			clock-indices = <IMX_LPCG_CLK_0>;
+			clock-output-names = "mipi1_i2c0_lpcg_ipg_s_clk";
+			power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
+		};
+
+		mipi1_i2c1_lpcg_ipg_clk: clock-controller@57223024 {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x57223024 0x4>;
+			#clock-cells = <1>;
+			clocks = <&mipi1_i2c1_lpcg_ipg_s_clk IMX_LPCG_CLK_0>;
+			clock-indices = <IMX_LPCG_CLK_0>;
+			clock-output-names = "mipi1_i2c1_lpcg_ipg_clk";
+			power-domains = <&pd IMX_SC_R_MIPI_1_I2C_1>;
+		};
+
+		mipi1_i2c1_lpcg_ipg_s_clk: clock-controller@57223028 {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x57223028 0x4>;
+			#clock-cells = <1>;
+			clocks = <&dsi_ipg_clk>;
+			clock-indices = <IMX_LPCG_CLK_0>;
+			clock-output-names = "mipi1_i2c1_lpcg_ipg_s_clk";
+			power-domains = <&pd IMX_SC_R_MIPI_1_I2C_1>;
+		};
+
+		mipi1_i2c1_lpcg_clk: clock-controller@5722302c {
+			compatible = "fsl,imx8qxp-lpcg";
+			reg = <0x5722302c 0x4>;
+			#clock-cells = <1>;
+			clocks = <&clk IMX_SC_R_MIPI_1_I2C_1 IMX_SC_PM_CLK_MISC2>;
+			clock-indices = <IMX_LPCG_CLK_0>;
+			clock-output-names = "mipi1_i2c1_lpcg_clk";
+			power-domains = <&pd IMX_SC_R_MIPI_1_I2C_1>;
+		};
+
+		pwm_mipi1: pwm@57224000 {
+			compatible = "fsl,imx8qxp-pwm", "fsl,imx27-pwm";
+			reg = <0x57224000 0x1000>;
+			clocks = <&mipi1_pwm_lpcg IMX_LPCG_CLK_4>,
+				 <&mipi1_pwm_lpcg IMX_LPCG_CLK_0>;
+			clock-names = "ipg", "per";
+			assigned-clocks = <&clk IMX_SC_R_MIPI_1_PWM_0 IMX_SC_PM_CLK_PER>;
+			assigned-clock-rates = <24000000>;
+			#pwm-cells = <3>;
+			power-domains = <&pd IMX_SC_R_MIPI_1_PWM_0>;
+			status = "disabled";
+		};
+
+		i2c0_mipi1: i2c@57226000 {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			compatible = "fsl,imx8qm-lpi2c", "fsl,imx7ulp-lpi2c";
+			reg = <0x57226000 0x1000>;
+			interrupts = <8>;
+			interrupt-parent = <&irqsteer_mipi1>;
+			clocks = <&mipi1_i2c0_lpcg_clk IMX_LPCG_CLK_0>,
+				 <&mipi1_i2c0_lpcg_ipg_clk IMX_LPCG_CLK_0>;
+			clock-names = "per", "ipg";
+			assigned-clocks = <&mipi1_i2c0_lpcg_clk IMX_LPCG_CLK_0>;
+			assigned-clock-rates = <24000000>;
+			power-domains = <&pd IMX_SC_R_MIPI_1_I2C_0>;
+			status = "disabled";
+		};
+	};
+};
+
diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 9f29fe4589668..846b95be22bbe 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -577,3 +577,4 @@ clk_spdif1_rx: clock-spdif1-rx {
 #include "imx8qm-ss-lsio.dtsi"
 #include "imx8qm-ss-audio.dtsi"
 #include "imx8qm-ss-lvds.dtsi"
+#include "imx8qm-ss-mipi.dtsi"

-- 
2.34.1


