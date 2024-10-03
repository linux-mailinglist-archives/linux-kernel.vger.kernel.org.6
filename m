Return-Path: <linux-kernel+bounces-349525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28CB898F7D8
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 22:05:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4C401F228B0
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 20:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93A347711F;
	Thu,  3 Oct 2024 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="EnnBKYkx"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2057.outbound.protection.outlook.com [40.107.20.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0D853373
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 20:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727985918; cv=fail; b=GKDPxUG4q5pLlGX34AtckZhscl7mjSTzuZzdyyv5dCDeWKG+m/hbLFpNuSiGN4pwMYC+NkIclH6Eo1BcxZgV4AxGfDZ3kLrI4dyYymiS2L8WOJEx0g5A0SX149yqmPmF4voVkVshB9ZLhyFWNr8nLlmKpjktqz81dx17mlyee3c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727985918; c=relaxed/simple;
	bh=AR/kopWAUpgqizf1KNyCsqNn3T8tO/hEsHfytUNj86E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Fwyrf2pxdkVH5hy3YJNewMCPGqnEFv1GG2jjiNPAxu+E/U9z49tA+qzmFgbSZdAcO+3ZKZPlbViDL2MiZzwKpjDu5nK6WR1gfy2dVVU8a9Wml1kTiGrLjh/x12YsResS1EqKHdQDPo5+EhQ0+oAxGwjBJFLdpdKJFefhNyKmLhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=EnnBKYkx; arc=fail smtp.client-ip=40.107.20.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cMPdwN2ama1M209fV7qSVMD4NvACRa0wHFVJwkWaJ0vpqiiSub6wxoZDYrZ0fRgetmAfQG8WKsFBPKlFF2yzFfuoHk9yfnLzha3T8wgxy/Yi43IQ2DobElygnnEzmtiVFpoiUQPlGFVLfyTmvVgdEYSss/D6JZX3oNwR15X6eyTK0Pof+2GxwCjfyN8r0cX3rkye8J3jeAi64PWGloOQatNes0GHH1YmpE/zutgQ3XURvQgLe7kmrmcRsSeFDTn/r/NvShrpNJJqbYhXwdrJgDIjS6gYZ75xjjftex7ksizTfpd/7yPNdrMWLzO10WeGo/CMt6vpQlm1qSBpSCFttw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4mfhkZzOHOqkgoj8au8T+Lz5ETZyQfDDeQOwUu8YEWc=;
 b=WUkpQGSThVAfMYhrD/j+JTsNu6B3zH89j3d9kZgUtKdBT9v1TUj9NTlSAm0blHxDGVAukiGNU8wn3AHYKhQ0jurtqb9Dl3bZdDpXsokjSsWuxwjvbKPmazMis6TR53oTyVYM4zPMaPq/DUm5BZ/KUahmanlDb2z1PBbVU45dSB9ANRNv20b0rRZqD/5jYQj+TBuIX3fMyT8+PbMXAz67DPEBB2WpQd90fANgw8Zo1J3jE5binF26iMY7v6OgxBe8yGRz/f8M8Bi4ctOckmijV4ZpMcL+b3rILTM+EdCUEaiU4t59AKIAyqq/9RMSH4FULZRSUVYNUYjxQlvT8E9BMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4mfhkZzOHOqkgoj8au8T+Lz5ETZyQfDDeQOwUu8YEWc=;
 b=EnnBKYkxQQUjdXqNZrm3idLYelChzUPDoXmIK7HxoXTJgWVJTUwEh80JNDMPzcPd8rsE0Vj543XaaAo+hm+JT2qNX4F9zWsJzN2AGvu2kT7sWG/ALFLJ9VW3x9hi6ZAoXkelhTiLO7jB+oWtR+P/00HPNsSsa/7mMYwb1GC4gTgIR5mqGmlrihBuGoXhXgaQRsS4cBHQ9UzDHTngo+vPbefF5To00wZnbsv0OpJLicZ5P2Y3XGUddBozTZwdLXuXs0+rclvh48KOyCh9TlsZpNHYaJWvrEU7mY5blqU9M69h2mgm+dfvWk0rXA89FWm76ONqCDgWO25cMBhMsaE3Ng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com (2603:10a6:150:22::11)
 by DB8PR04MB7065.eurprd04.prod.outlook.com (2603:10a6:10:127::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Thu, 3 Oct
 2024 20:05:14 +0000
Received: from GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58]) by GV1PR04MB9071.eurprd04.prod.outlook.com
 ([fe80::b7f2:1d0:6b6a:ba58%7]) with mapi id 15.20.8026.016; Thu, 3 Oct 2024
 20:05:13 +0000
Date: Thu, 3 Oct 2024 15:05:08 -0500
From: Han Xu <han.xu@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>, imx@lists.linux.dev,
	linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] mtd: nand: raw: gpmi: improve power management
 handling
Message-ID: <20241003200508.x7tbf2lpbg6ngm7q@cozumel>
References: <20241002153944.69733-1-han.xu@nxp.com>
 <20241002153944.69733-2-han.xu@nxp.com>
 <20241003093840.2965be20@xps-13>
 <20241003150500.uz2efay7kadu47if@cozumel>
 <20241003172820.50324192@xps-13>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241003172820.50324192@xps-13>
X-ClientProxiedBy: BY5PR04CA0020.namprd04.prod.outlook.com
 (2603:10b6:a03:1d0::30) To GV1PR04MB9071.eurprd04.prod.outlook.com
 (2603:10a6:150:22::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: GV1PR04MB9071:EE_|DB8PR04MB7065:EE_
X-MS-Office365-Filtering-Correlation-Id: ef1fab8f-26df-469a-0c45-08dce3e6b154
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXAxdW1rNWkrWVNOU0NVSVlIOHZoT0dMQTVTWG5hakhkWFFCNEJPMEtSU2p3?=
 =?utf-8?B?S1ptNkw5cWJZQyt2OVE2eFdPSk4zUmZXTURiR0pKcmpUVnRHTkFvdUd1MGYx?=
 =?utf-8?B?Sm1sNnQ0WVNSOUc3RlFFUkFDVmFWQUprUzAyeEhMaHI2WjV1WUxlWVBSS1lM?=
 =?utf-8?B?Q25VZU9zWkhDMzErTXE3YUxvaXVPUUZadTEzZjgrMUw3WkpLSWFBMWxyaTBL?=
 =?utf-8?B?Um1xR0IrZmhVOHRHU3lZOFlJdmR4c1E1c1NwYndxSVZJN05LbUFzR1RuMEUy?=
 =?utf-8?B?dUxJTEYydUdzTUxMeVlBUGloRFhzMklXQlVvb1FWQnQ5VXRSdk5sMnBrZTRT?=
 =?utf-8?B?SnJXYnIvU2FhSm1aSzNaWThzRkJxNmcraml1clJyWmY1dlpsZUt6M2ZTNGlk?=
 =?utf-8?B?dWF6Z1BNVHFmUHhKZ2JrTWxoRStURWRlQkd6cU9hNVhMQ2FmZUU5S3F6NTNj?=
 =?utf-8?B?Rjh5eiswNldaSXc4dGtRTGJEZXA4ckF2TWEyckdIZ05tcGR5emJpM2s5M25y?=
 =?utf-8?B?MUpHYVJ5K2hpVmltenpWODY0MkVkUk1NTUNDQis1MnFKd1dicTU5cWZDV09w?=
 =?utf-8?B?UzEvWW50YktpMWRIV0xyTityRkRXMEtueGNWNmRzSjZEVG0zOFRDUGJQUmho?=
 =?utf-8?B?S2FMUzdhMHowZTN3aW9rUURiTXU0WVNFcWdVc3hoNnFId2diajdaT2RuN3Nj?=
 =?utf-8?B?dDhzelVmQzRBVTJKcUpZc2F1VUwxR2NuamhHMWh5NjhmQmZlTGVSVkh2ZmpR?=
 =?utf-8?B?bDdqZWxabTgvOW1MZkxIaG1rL0lJZ3UrZEJuUUo1SUxvK00yeG1nOG5HaXdQ?=
 =?utf-8?B?S3RkV01oNkxuVkpYZE5PdmZXSVQzemJrMFIwZnlxN1RzNDFBNklYRTBadElp?=
 =?utf-8?B?NnlZaHRHeG9CeFBNYjY2cFBVQkxaTHdNN1pvMmNkbGYrVlAwVEphS2VONFBt?=
 =?utf-8?B?bVVJcnpqU0NvRXFzcERXYi85RzlLYXJyRE0rRXFJbmh5d3RLUi9YQU4wRDFz?=
 =?utf-8?B?aTE4d09SRkdXaWxYalB4Ni8yaExjNEpZSUZQQkY5RGs0Z29ORlBVVFQ4WmVm?=
 =?utf-8?B?WEQxclRSb1B4OFQ0dUE1QXJJbWpWOFp4bTV1SXhZM0lzVVBNN3FTS2JBSS9r?=
 =?utf-8?B?WlB2UjZJelpzWitxVHc4WHJsTWFJaXo4UnQ2V2poazlKQlp6K2hCZlNMY1Fi?=
 =?utf-8?B?UDJpQ1d6ZmR3d2pBMkROcEY0SGZGMStMWkphM3ltVCtDbnNpOEZRNmlUanZz?=
 =?utf-8?B?WG01cXU4cmhDaXIyRzhBeWpvRkhJcjNhUjlGOXNlSUcyWlJKZy9ONTV0Q1ZY?=
 =?utf-8?B?Z1Y3RlJzeFVCMHUzZlo4bk0ydVU5UjJGQllxNGJrTzBXbTNSdzNZSGgvcW4r?=
 =?utf-8?B?ZkdDbk9xTzcvK3lRaDIrY0ZQQ1lFdXVDOUY2WEczeXpGdm9Ydm1mZzBPb1Ns?=
 =?utf-8?B?RUVYUUMwRThDV2NEdkdkMjRGUTNhYjdvT21yeFFzUmxmZ1htcTM3M1hPR2lS?=
 =?utf-8?B?b3hhUEpJRDF0ZWlHSGtaN090Q2NTd1VpMHQ3Q2JEREp0bVNxTU9qZVh2QitK?=
 =?utf-8?B?c0RBU1J6bnpsOWl0K25NWGllcXNPa2JtQ0pWeDNzay9zQ3krQlFCU2xiZ1h0?=
 =?utf-8?B?WStkZjJOL3VxclR1Qm8rYjRGQnB6RTg4bU5pMFJ4elVHblh0aURUUWpkT3hI?=
 =?utf-8?B?NjFMN3NzL1VpSjFnOWZNNmc4Nm9EWVM5SERuNi9aSG0wWW9UaE5kSU83OThZ?=
 =?utf-8?B?MnVWenhzVHFsc1h5OCs3UW9wWXoxd3Fkanl3QmNXWXQ4SkZPaEh0M20vaEJq?=
 =?utf-8?B?RWozdnovOG5JU3E3aVJPQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR04MB9071.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkZUYkxUNGhkTjJuT3ZqWC9WSFJZRXJzY091ZTZEV2lQekx1cy9KK2twckJY?=
 =?utf-8?B?R0JaZU9OMUFMMWVscHVzUXY3SGtOa2hZRkZncExmc3d3RTFFZVRwWEZIVEtK?=
 =?utf-8?B?Zm9sVTljeHJjTFoyUWVOUE5RQkZNZ0RNVFExd0tSdklHbDF3ck9xL25XWTBB?=
 =?utf-8?B?RDZObUl6T0pWYW8rTHY2UXYrTEVFejlGNTFxNDJEVi8zWFR0TmRUN29aU0Ny?=
 =?utf-8?B?MFFpWGJDOGVYS1c5ek5FN2xvckRlSWR6ekVzV2t5b21nNzdBUEtlN09Xc1Vn?=
 =?utf-8?B?OFZ1LzBJVWhsVDZMcVpPazAwMXliWU9sNjE3WXdTc0pISUg5cUpBSnZpLzIz?=
 =?utf-8?B?RGhXNkp3NE1RWGc5aVVsS1owTWtrb1BaNG5hc1FMeEduQ3Bqc1ZnRHFabkxW?=
 =?utf-8?B?L3RZNW1kTTBrMGdnZXpXWVpaZmsvaysrS2FBQWxJN1JJLzA3dUVEVHJ0Wlg0?=
 =?utf-8?B?NjE3Vm5FRWxUMEhhQzhJMDM0cStoQUpnV3hiTjlORWhYOHBsTEdTWm02aFVp?=
 =?utf-8?B?b0UzKzVjZ1BVQTZTMHd3MnpoZERhZnkvVjBCUFpXVnhVTFFnWUw5S25EVkF5?=
 =?utf-8?B?QmRPMXVtWUZNRHd2QU5CYWhMdFB6UFNmWnMxUy9mV1ZMNXJRZ1VYMFdNYzJw?=
 =?utf-8?B?blI5dHhtdFdheXdSc21qdkZuOHEwdkRBcGR6MS9PcHdJYXpQRjRJUm1KeTZw?=
 =?utf-8?B?ZFhIaTFNYlBGUXQrWWZZWXlaWk1ZemdJa0kzR2pLNmU2U3FScmJhbFozWUFJ?=
 =?utf-8?B?WlhFYTgxRWp3VzI0RzJCbzU2dW5OamV3YUhQdTlCWDNDbGpIcVdmZjNQVUVa?=
 =?utf-8?B?N3JoRUl2TytVN3N2d3FMR21pckNBL3dzZjhXT0cydlNEUG4wME1tNk0yUHNr?=
 =?utf-8?B?dDRDV2ROeks0Q2xtQkI2NklBbUVXa0xMYXZxbHprcmxLMWxFRlN6WG0rd0RC?=
 =?utf-8?B?Qzh6MkJrR3JBSm9PNXdWbXBsYnpDckd5ZUdrVFpzZVFEZW1waFJpZFlhNWFw?=
 =?utf-8?B?dENqRUg4K0dZaXRTTlRuUHV0WHpLdW9zdndLc2xoV2pCd2VRdkFETm8wZWpl?=
 =?utf-8?B?TFB4bksxR1FVSVhZN0RuTUFxZUpyQWcxQ0EzT1RYQUxJNEc1QjhYV1dFUExB?=
 =?utf-8?B?WnVsU2tqNlBGUitQZkR2TEFpQm05aWtNUnMrb2pnL2o4dk4rZGRDTFJtVDBl?=
 =?utf-8?B?ZGsvR0VTRmM1b1FaaEJsWmFCT1FqOWt0ZlgyZ3k1QnFiRXFaMksrZ1V2cGlK?=
 =?utf-8?B?WXAyWnhCcG5nVDUrUUJ0RmNjNmFFVlJkU0I3VlBPWjN2WG5Ja1JJOUdzMXo1?=
 =?utf-8?B?VU5lbmhDa0N0S1pHOHJjNXZTWm9nYzUvRE13WWVSWXJpdWMxZlNrclBTU285?=
 =?utf-8?B?TmdJQmpnSHZ5akR4WklTL0syYTRvTTFXZlFwSWhmVmZIb29KdEgxTVFNTDlM?=
 =?utf-8?B?UGxTRzN5QXZBYmUrWTZCQU1TZ1UvdVpURlhXZWpBcnIwbS95ampiTm1wd0lx?=
 =?utf-8?B?ZURLKy9qUHFwWXN0QXhpcldIY3pIemRZTThVRWkvZTZkRGlBNjcrS2VvbVR6?=
 =?utf-8?B?ckpMVCtyNlBqVnE1UEJGdVM3Ykp4L3BUMXZzN1krQzc2SUhwU3dqNU1xcTNi?=
 =?utf-8?B?NnQxZ0duUEZjTS8yMlRKcWRQbWxZVk9JSzloWlVDWkFXZlNPejVTWGx6WnVQ?=
 =?utf-8?B?SU9wNW9aS012OHpVby8zTTFmTGdJRHpXbE4xbmhmelhoeXlIZmtLc3E5NlNj?=
 =?utf-8?B?RjdEN3lTSHRtZnIvcWFNdENCRFc2b21UK2s1RW9lN2E5UnFKdzRoRTd1Ujk2?=
 =?utf-8?B?NWV6Z1dOL2VtQm1RNmNwcmJCQldBbVZmbEo2blpZRWxRcW9FQmV5K080ZUZX?=
 =?utf-8?B?dWxWVjkwdGxnaHl0NXZKOFYzaHBvdEtFMS9qbnhDRlRjWXlBNGMzVTBsUTVC?=
 =?utf-8?B?SnF2allIRWZPdWlFVUs0bHB2SDVoVDZ2WGw4QUs2S1BmWXBBMkIxVTltdGVY?=
 =?utf-8?B?TkF2cFR6dVpOR090UTUwV1Z6NDEvYzdlZi95WTh4Z0d2SE9UQXpQdkF5OCty?=
 =?utf-8?B?SnBxSGtNbzdnNUZ5aFREKzI2ZmMxY1lIdlRIaUNzVk5Ga1Q4L1lJalpPVCti?=
 =?utf-8?Q?SRME=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef1fab8f-26df-469a-0c45-08dce3e6b154
X-MS-Exchange-CrossTenant-AuthSource: GV1PR04MB9071.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 20:05:13.8556
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pEdjenI/1p/Q05gVLmn5g8WVy6e9LdKzETz4UsHz/Uus/S/udEqisWkj31KxFdsi
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7065

On 24/10/03 05:28PM, Miquel Raynal wrote:
> Hi Han,
> 
> han.xu@nxp.com wrote on Thu, 3 Oct 2024 10:05:16 -0500:
> 
> > On 24/10/03 09:38AM, Miquel Raynal wrote:
> > > Hi Han,
> > > 
> > > han.xu@nxp.com wrote on Wed,  2 Oct 2024 10:39:44 -0500:
> > >   
> > > > The commit refactors the power management handling in the gpmi nand
> > > > driver. It removes redundant pm_runtime calls in the probe function,
> > > > handles the pad control in suspend and resume, and moves the calls to
> > > > acquire and release DMA channels to the runtime suspend and resume
> > > > functions.  
> > > 
> > > May I know the motivation to acquire and release the DMA channels
> > > during suspend? In general it seems like a different change which I'd
> > > prefer to see in its own commit with a justification. The rest looks
> > > ok otherwise.  
> > 
> > Hi Miquel,
> > 
> > Thanks for your comments. IMHO there is no much logic changes indeed, just move
> > the dma channel acquire and release from system pm to the runtime pm, releasing
> > the unused resources as early as possible. If you think it's necessary I will
> > split the patch into two parts.
> 
> Actually I don't understand why these channels are released and
> acquired again. Does it make sense to do that in the (runtime)
> suspend/resume path? I'd be in favor of avoiding this extra
> configuration which as a first sight does not seem required here.

Our local mxs-dma driver (will upstream the changes later) implemented the runtime
resume/suspend in channel alloc/release functions, so I did this in the gpmi
nand driver suspend/resume path.

> 
> Thanks,
> Miquèl

