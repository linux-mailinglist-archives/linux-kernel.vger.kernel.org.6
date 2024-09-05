Return-Path: <linux-kernel+bounces-316627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF5D96D21C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155B2286D08
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273D9194139;
	Thu,  5 Sep 2024 08:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b="VGeZ11fa"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11020138.outbound.protection.outlook.com [52.101.69.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBD515B541
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524949; cv=fail; b=L2FmMu1WjbrbEjdTRfCrXtEdGnJWOtCdrIlpHJJXGBLko9ZhWuR5p3xhS+vqA9ddJprxdo14Vb5wwzN5Hqi5jG643vO3yz5fOH1mZK82a6Azz25Jd583u0Ujc/BMWrE5Jb1fol8DYfvAXXRO2H7Wawx9I5W+lAGZMcODkJxVtlY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524949; c=relaxed/simple;
	bh=d1cgch25kxJtQbSgQNyvoeP4GXEtLiXY9ufbXr+vl48=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=c9o5hNXoZErDfEbP3SUMSm2fb7zh5l+XsZXEaEqess94ZCUyYJQW6o/KdEK2CoFxMd7FNr5HdOnzbs5roK2Lu2mfSfaYMIFhzNUOmY7A37dRlx/LQY15RIymYiXYMy/vph6GSRvE8xhW0wu8XHqSa6dgpblXuJ8dck4H3BRSPsY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se; spf=pass smtp.mailfrom=axentia.se; dkim=pass (1024-bit key) header.d=axentia.se header.i=@axentia.se header.b=VGeZ11fa; arc=fail smtp.client-ip=52.101.69.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=axentia.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axentia.se
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KmzJK9MKQ+WyfPyObOG+sygqZdOn9jMIS+CMNV2/jLfdV6Edf8sKApbgax+gAYtbeAVqoY687O/woOqtZDwLrka2bcU8aN/ptRrYHtMNAnZlQUZHxGuyi7PJdISoEIZxH2Fml6Fqd/aMNbr/9VHulRV7dsKy8EumTR72ZkFt/HzHzTPbxdkrzHZoIy3ye0TbZQi/cGCCLTMp6kXtqPDtzEzuh84RSna84X6c9kuUO6GDqrNOKmccCe2lP3S9UMdLV0yujjdfK+9PQWksJqQlg5c0ur+SED0oUeGyHN3o2WoMYbOHb59k/18FL/yXXokKUzkHVyJrx3idYUwSheFITQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RzaHFUgw9H6TYpfWLH3Nx0ehZxHYqXdBN830PSADJiM=;
 b=E3qNx0bylZz3vS9zST4stB3GWq3Efx0aAZ5LPp0PlBNZT496XxST0RaeQHD5qr+fB54mH/0082K70eRkG9hc+sHrJDDzSk2nWiFvSqWZ8K20T7vPB+P1XxE9kUWWthttPA16dVPaY8SAl5Ee41lnToREusxbmOYWHoiB9Uf6LWtfNFOII9noZozTYWrhuCB5u4NXdW7alitEu78bZHJJgbm287uM/aptN09SSwW39MbzDTgoLQXL+dljO28b8i1tgzJLIICex602t0VFVudWaJR7OSHYopqXq434/wRkEiXcLza09WjKXOs4RbV+ynjrH/wWLAjJqHJ9GVA+nslY/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axentia.se; dmarc=pass action=none header.from=axentia.se;
 dkim=pass header.d=axentia.se; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axentia.se;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RzaHFUgw9H6TYpfWLH3Nx0ehZxHYqXdBN830PSADJiM=;
 b=VGeZ11faK1miQ9TpzQvlOp7x5UW4N4epJS9bnCPMF8VPbNgqUnUWLrosuc+cS9gXaWiBKGVGkC4KoRWUKJ4WDuAeTYkQOPi+Ta4V7WZu2r5r/wWkdvFYaVkCklHriWVQi89mV2QBUPtQnqpHfhkrroz1S6OumGftfTxRgCdVpGU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axentia.se;
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com (2603:10a6:10:3e3::8)
 by AM7PR02MB6145.eurprd02.prod.outlook.com (2603:10a6:20b:1a2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Thu, 5 Sep
 2024 08:28:58 +0000
Received: from DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::aff4:cbc7:ff18:b827]) by DU0PR02MB8500.eurprd02.prod.outlook.com
 ([fe80::aff4:cbc7:ff18:b827%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 08:28:58 +0000
Message-ID: <df9c448b-5f74-c0be-3a06-198e46a5de62@axentia.se>
Date: Thu, 5 Sep 2024 10:28:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] mux: add mux_chip_resume() function
Content-Language: sv-SE
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: linux-kernel@vger.kernel.org, gregory.clement@bootlin.com,
 theo.lebrun@bootlin.com, thomas.petazzoni@bootlin.com, u-kumar1@ti.com,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240613-mux-mmio-resume-support-v1-0-4525bf56024a@bootlin.com>
 <20240613-mux-mmio-resume-support-v1-1-4525bf56024a@bootlin.com>
 <94069d56-0981-2d69-65c2-901a05758806@axentia.se>
 <f5067055-1470-4386-8839-b4ec2527872e@bootlin.com>
 <4cf89e3d-7164-67b5-0a3c-9e8e4df274eb@axentia.se>
 <c8a82583-5570-4286-9f1b-00a2717bae4b@bootlin.com>
 <6267cf2b-1c05-ec72-9ac8-e715561d5bac@axentia.se>
 <10f29bcc-b627-4bd6-89f9-b8c48fa6fd3a@bootlin.com>
From: Peter Rosin <peda@axentia.se>
In-Reply-To: <10f29bcc-b627-4bd6-89f9-b8c48fa6fd3a@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: GV2PEPF00003851.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:9:0:19) To DU0PR02MB8500.eurprd02.prod.outlook.com
 (2603:10a6:10:3e3::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR02MB8500:EE_|AM7PR02MB6145:EE_
X-MS-Office365-Filtering-Correlation-Id: e18eb715-a593-49a2-ee07-08dccd84c9a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UitlbWF5TlRsZmovRlpOdE1zK1pDZzZIdjh5cWR4cDQ0cHlyOTh3RWdPZkgx?=
 =?utf-8?B?bnVockR6QkRLZGVtWjEzQWR6Qk1pa0ZDWnVsVDVoeEZBSURESjRDRlRrSVIw?=
 =?utf-8?B?dVoxaFlYTldyR1lMbGFEM3drWlYveGUyZjBmZ2tvY3BGYjluK0lCa25FNnk2?=
 =?utf-8?B?c0ZZeXBmcTJlWXViYXZBRUdEMm5sN1RtQVQ4a2pTNW93YituRCtvOGRyWHZk?=
 =?utf-8?B?NmE5bkp2WDB6VHV4TWFjd0lLZkQrSUxla2s3dmlHTGwwWTkwV1dLdW8yaExh?=
 =?utf-8?B?UzJmSzAzY25JNjRmOTNKeHY1WEhuY3F2MHJUZmM1QjVZQ0JsZ0VBUnhjbnVv?=
 =?utf-8?B?eHVOcjRGVUFQQzNaTzVhaXFkNlFyNlU3RzM4WmdXL0M5SkxaUlp4OXRPYUc2?=
 =?utf-8?B?azROTVRUOXVBeE1kUUFDRFRsWGdSUk9MeENrcmtzejl1QWZTQjVnd0F5M3ly?=
 =?utf-8?B?MFpjNkpXNW92aUVGTk9mUXNrZy9ickFLVUxZTjcxUFYzNTJWNzRiZmd5aUlz?=
 =?utf-8?B?eVhxYUhWZzYwZksvbEFSajdFRFlLVlU5Ky9PWlZUZWUyYlMvMmVPdmVONEN5?=
 =?utf-8?B?eDFaUXRyeWtieVJ3UnJ4a04reTVwUlgrTkFMbHFhK0VaWnB0NFZKNnNXZjBW?=
 =?utf-8?B?Qkxya1ZlamlONjE2U2RCSE4yVzZzVnNoQ2dTOGZ3dTFPRWZsZ0dwT21PQXV1?=
 =?utf-8?B?SFpTVGJySnlLN0Y2OUs2RFFMOVQ5QmVzV3p5VW1NbmFiN0Q2S1dURzZ4MjMy?=
 =?utf-8?B?M2YzWG9HQnpsVGRhTkFpRFJBWXV6NGZaSThMaklQSURLaVJlRC9Jb0Y2cFpi?=
 =?utf-8?B?aGY4V0hNZmtlS3JJV2VQZVB1WkdNYzNQZlkzLzBGWnkwc0p2ZnlxMS9JL085?=
 =?utf-8?B?aEdHMU5LRlZ5SFg0UVZHTmFoMHRtbFlMYnhaU0UyWlB3d0JCWWVKYmhPaGdm?=
 =?utf-8?B?ejNVdUVTQ3NJVEY0dEphVlRSZW45My9WaWtoQ25PelRWb21maE9HN3FiRWh4?=
 =?utf-8?B?T0J6OFRKTUJKb1RiWGlDaGZZK1FmVVBmRE15VzZReVc0ZE5YWFhZYVV6R1ZW?=
 =?utf-8?B?dEtXZGQxeTB1dFBSWmVwT21jNzkwbENJaFN3Z3NEZTFTM29VTWxTaVFRYWdj?=
 =?utf-8?B?eTRrREwxYVR5OGZ2aUZXSHdLWTZiKzhLbWRhK1diRnVlZjVWUmZCOTBOS3Bq?=
 =?utf-8?B?RlEvcGZkWnVZNlJsdUx3Yk1HcGRraTllWjN0dkYxcmpWaDh1bTBMU0V3NFNv?=
 =?utf-8?B?QUVpVjByOVFvKzlZYXZnUzIrOE9TNUFYcWJmY3NwMFFtRDhMWWdOK1oxUDdj?=
 =?utf-8?B?WlFnaE40YzVLN21jSHhSL2UzN0UvekRqNFdOYmtFM2xaRVdrRDRyL0tJUDZq?=
 =?utf-8?B?TklKWDcrQ2poMFdFK1ZqTDl3Z0lEOGUyWFo5S1A1azZoYnFwTFA5YmtjRTUr?=
 =?utf-8?B?TGZhbFdTdVByalJqT2xLWmRmWEcvT3NJRXljcjVUWkpLdVRPRG1yamErelBo?=
 =?utf-8?B?Wm5JZW94Mm1scXRHbUQyMitIT2RGRkVOMllkcjRNR3R4L1YzWG9vbEVJa2Rj?=
 =?utf-8?B?Sngvc04wZkNiQ1IrWGpqRnNub0U0SEU3T1ZLZzFNNkJmeVQ2SzJMaThpWnI5?=
 =?utf-8?B?cDdJc0plOVpaTnB4cFJhL1k1M05FaDJORzhPMWk2NXo2a3ZnZWZHWjhPTjlJ?=
 =?utf-8?B?NVZPWFhIV2haWGgvVXoyZEU3dkRIdEJURmtXclNjUE51eFJyYXl0d0taYy9l?=
 =?utf-8?Q?UfGUS6CsCrybTfqu0g=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR02MB8500.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WEZWNUZJZnphOHpLdmNBQ1l3UVo2eXZNZFdBeDhvMEZpNEMwSzlVaVpBdmsy?=
 =?utf-8?B?ekQrTmk2TmhHajBycTRaSVA0OU1LVUlTVEQ1NGNUQVVGUjNmT1lESDBWRkdP?=
 =?utf-8?B?eDRHdGhhdHJWSmV2T3Nib205UjBzdUNQSHRSbDRna0JqcDQvZzZ6R3I3TXRh?=
 =?utf-8?B?Zkt2RS85L2Z1UE9zT0tTM2pzWnA5WXR6TVlhZkVRUTlPY1ovbzNvaWJuNGJB?=
 =?utf-8?B?YnNZdTdDdVpmSnlIUC9ZdGlHVFIxamFNOVJneUE1c2hmT3JzK2w1WmtQUnlr?=
 =?utf-8?B?TEZReTkrQmdHVk9VMm5McmRkU216dElFaEpuUWRnKzBFM2U2blVDeFdsaXps?=
 =?utf-8?B?b3Y1cDAveGFHcXlwb3RsUWxqQ0lnQTkvVWZ3dEg1dzVHaVVRV2dBN3BxdnR3?=
 =?utf-8?B?MDZDUmQzemxxbUFVd2x3aEI5ZGRWZnNpR3RnU2pwWjA0QVZyRzVhZW00ZERU?=
 =?utf-8?B?RFIrbldxenRMUnIrbDJsSGZPazZMQitnU04zVW5VVUtlS1NGVlpsUndHRHVp?=
 =?utf-8?B?b1VTdVMwTGRnSzJRTWpxMUk0NVI3ZVZrLzNaSGV1aDRJSmFhQmx2WE9OQ2hK?=
 =?utf-8?B?dkd3eDJIUVdnUzVMNzFab09HYzNxcXZ6N1BaRkhHZkI3NXRldkZia3Yyellp?=
 =?utf-8?B?NmNyMTZqb0VvSnh2UlRaQUVBK09qV1ZKVk1PWGJLWXRMMTJ0ZDBMR0lZM0dt?=
 =?utf-8?B?MDZWeVcxVWM2Q1F1MFpGeWdWd1lvTDJnMzY3cFQwMVArb2tuaFp5eGZLb1JM?=
 =?utf-8?B?c0wrR2EwU3FPWHpickhYWDY2amNqQU9rSU1qN3pPa3NxVDZ4WER4S1ZmTFhY?=
 =?utf-8?B?RXhqcGtxVWtxd3pvcUlTeDJTNlJXc3FyZWZxL2U3ajFTdjVxTGRiQmVYaXBK?=
 =?utf-8?B?cGpxeFhLU0p2ZWdVeUl4RGc5UDdOa0hTV2RHeHVDeS9qTnNRUWVyK3BMOURv?=
 =?utf-8?B?K1JlZkZ3U3dWREhPWDZBVGVOeVFXR1dVcXdrOTR5YThzMHFZd3FuSnBxMmFs?=
 =?utf-8?B?MzBQbWttMHpzV3dWQ3l3bnZUSmZ1TW96ektMMjlrVW90V2dhbkVtTUpxckJx?=
 =?utf-8?B?WXJwanpGSXBJcE92bEFBYzMrazhyWWhXREJzNEY5cHIyMytsQlY1SGo1T2cz?=
 =?utf-8?B?RFUrUG93YXo1Tzd1N21ORTM1REJta3I1MytpRnJKTXA3c0lBRzZ6L0hhQjFs?=
 =?utf-8?B?VlU2Y1RUUnJFSk9YUENUdUk3UmRob1RtU1BrUEV5cEVadnZjd21adzdOUmti?=
 =?utf-8?B?eG9sa29CNExBa1FVRS9ucXF6a2pLQ0tTUEJWS3NET0tlaHhweEFOYmdnaTBO?=
 =?utf-8?B?Q1ZkTjlVRGFOTnR4bldlamZ1WVhESjJ1S3JmcEtSSFp0OFl5bGYwMzlMV0Zs?=
 =?utf-8?B?c2JwdG8vSFhVaDRaVzI5aHZPRFkyd2tXN1RSbEp0OW5QRCtORVM3cWg2MGhO?=
 =?utf-8?B?RnFEdnJ2NjRSZkRIWlhxN1h4NFNLRWN6cEJjUUYzSTRra2lCVVMrU2hpWFll?=
 =?utf-8?B?Wno5TGRYd09qa1lkd0xmQWNCK2RZdTBMQ293b1J2dGdHZGV5QXhCVVpkanU4?=
 =?utf-8?B?Zlh4TzRDbG5xYTVwVjAxalU3UUhYdE1tSldIL1VuaXNvQXhZYU9UYmM2YUll?=
 =?utf-8?B?WXRtTVdlbWdZQi9VbE81VGU2RWMyRWVYWlFRclhyOC9adVpsRmVvb3NBdXlx?=
 =?utf-8?B?aWNkZWthaUp6Z3lRem1lMU9CWnhyK2x1MU9pMUJURCtndCtnajkwbUpqODYx?=
 =?utf-8?B?d3BDeU5lRDhFcTE2YU1Ed0FqU3R0eklEL2Q1RGtBRU85YklMTDRMZDkzSXlQ?=
 =?utf-8?B?blJYUnhjaThvbFRJZU5sbzNUS202amZYOXU0WFpDbkxJb3VPMzlqTm05K3hS?=
 =?utf-8?B?N2gzYjdwS3hQWVpZUVNyeGNTSUsvRWFTUlN1Tnh6UGNLWGUvbGxNUFJ4K01J?=
 =?utf-8?B?bkt5V09VUzdSRi9YSnBDNzMxY2trQXhWdFJiR0RYcmxjRFJSN3pvcmk2RGFy?=
 =?utf-8?B?OFFkVS9WRXVxeGkxRzdSc3NnYTRMaXlOcFI3YW5lVjFjdGVvM3JTSkJIVWVT?=
 =?utf-8?B?ZHRVQWk3WVV1WGlkdE5vVjRMN2RDU1g0N0ZQSUxQc1MzWGVHMUxFQnA4RGww?=
 =?utf-8?Q?gYp8rFBDat1MPiHGgzj/iSSi6?=
X-OriginatorOrg: axentia.se
X-MS-Exchange-CrossTenant-Network-Message-Id: e18eb715-a593-49a2-ee07-08dccd84c9a1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR02MB8500.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 08:28:58.3915
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4ee68585-03e1-4785-942a-df9c1871a234
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VZksdN2YV3K2EiYoi4s31gN8ujO3jF9rtcei2GepKRbVUpiAeDlC+OHY2UegLKxl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6145

Hi!

2024-09-04 at 18:07, Thomas Richard wrote:
> On 9/4/24 14:52, Peter Rosin wrote:
>> Hi!
>>
>> 2024-09-04 at 13:29, Thomas Richard wrote:
>>> On 9/4/24 11:32, Peter Rosin wrote:
>>>> Hi!
>>>>
>>>> 2024-09-04 at 11:18, Thomas Richard wrote:
>>>>> On 9/3/24 15:22, Peter Rosin wrote:
>>>>>> Hi!
>>>>>>
>>>>>> Sorry for being unresponsive. And for first writing this in the older v4
>>>>>> thread instead of here.
>>>>>>
>>>>>> 2024-06-13 at 15:07, Thomas Richard wrote:
>>>>>>> The mux_chip_resume() function restores a mux_chip using the cached state
>>>>>>> of each mux.
>>>>>>>
>>>>>>> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
>>>>>>> ---
>>>>>>>  drivers/mux/core.c         | 29 +++++++++++++++++++++++++++++
>>>>>>>  include/linux/mux/driver.h |  1 +
>>>>>>>  2 files changed, 30 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/mux/core.c b/drivers/mux/core.c
>>>>>>> index 78c0022697ec..0858cacae845 100644
>>>>>>> --- a/drivers/mux/core.c
>>>>>>> +++ b/drivers/mux/core.c
>>>>>>> @@ -215,6 +215,35 @@ void mux_chip_free(struct mux_chip *mux_chip)
>>>>>>>  }
>>>>>>>  EXPORT_SYMBOL_GPL(mux_chip_free);
>>>>>>>  
>>>>>>> +/**
>>>>>>> + * mux_chip_resume() - restores the mux-chip state
>>>>>>> + * @mux_chip: The mux-chip to resume.
>>>>>>> + *
>>>>>>> + * Restores the mux-chip state.
>>>>>>> + *
>>>>>>> + * Return: Zero on success or a negative errno on error.
>>>>>>> + */
>>>>>>> +int mux_chip_resume(struct mux_chip *mux_chip)
>>>>>>> +{
>>>>>>> +	int ret, i;
>>>>>>> +
>>>>>>> +	for (i = 0; i < mux_chip->controllers; ++i) {
>>>>>>> +		struct mux_control *mux = &mux_chip->mux[i];
>>>>>>> +
>>>>>>> +		if (mux->cached_state == MUX_CACHE_UNKNOWN)
>>>>>>> +			continue;
>>>>>>> +
>>>>>>> +		ret = mux_control_set(mux, mux->cached_state);
>>>>>>
>>>>>> mux_control_set() is an internal helper. It is called from
>>>>>> __mux_control_select() and mux_control_deselect() (and on init...)
>>>>>>
>>>>>> In all those cases, there is no race to reach the mux_control_set()
>>>>>> function, by means of the mux->lock semaphore (or the mux not being
>>>>>> "published" yet).
>>>>>>
>>>>>> I fail to see how resume is safe when mux->lock is ignored?
>>>>>
>>>>> I think I should use mux_control_select() to use the lock.
>>>>> If I ignore the lock, I could have a cache coherence issue.
>>>>>
>>>>> I'll send a new version which use mux_control_select().
>>>>> But if I use mux_control_select(), I have to clean the cache before to
>>>>> call it, if not nothing happen [1].
>>>>>
>>>>> [1]
>>>>> https://elixir.bootlin.com/linux/v6.11-rc6/source/drivers/mux/core.c#L319
>>>>
>>>> No, calling mux_control_select() in resume context is not an
>>>> option IIUC. That would dead-lock if there is a long-time client
>>>> who has locked the mux in some desired state.
>>>
>>> Yes, I didn't thought about it.
>>>
>>>>
>>>> I see no trivial solution to integrate suspend/resume, and do
>>>> not have enough time to think about what a working solutions
>>>> would look like. Sorry.
>>>>
>>>
>>> We maybe have a solution.
>>> Please let me know if it's relevant or not for you:
>>>
>>> - Add a get operation in struct mux_control_ops.
>>>
>>> - Implement mux_chip_suspend() which reads the state of each mux using
>>> the get operation, and store it in a hardware_state variable (stored in
>>> the mux_control struct).
>>>
>>> - The mux_chip_resume uses the hardware_state value to restore all muxes
>>> using mux_control_set().
>>> So if a mux is locked with a long delay, there is no dead-lock.
>>>
>>> - If the get operation is not defined, mux_chip_suspend() and
>>> mux_chip_resume() do nothing (maybe a warning or info message could be
>>> useful).
>>
>> What if a mux control is used to mux e.g. an SPI bus, and on that bus
>> sits some device that needs to be accessed during suspend/resume. What
>> part of the system ensures that the mux is supended late and resumed
>> early? Other things probably also want to be suspended late and resumed
>> early. But everything can be latest/earliest, there has to be some kind
>> of order, and I'm not sure that ordering is guaranteed to "fit".
> 
> I experimented that it's ordered correctly for each stage, using
> dependencies defined in the DT (I guess).
> Of course if we suspend at suspend stage and resume at resume stage
> whereas an SPI access is done at suspend_late (for example), it doesn't
> work.
> We could suspend/resume at noirq stages. It's the last suspend stage,
> and the first resume stage, so we are sure to save and restore the right
> states.

And what if the mux in turn sits on I2C? Is the ordering still guaranteed
to be correct? I.e. I'm not really intrested in just one case, but in the
general problem. I am resisting the attempt to add generic support for
something that, AFAICT, has no clear general solution.

Maybe you should simply implement resume locally in the driver itself and
have it reprogram the register, perhaps still based on mux->cached_state,
but "behind the back" of the mux core?

Cheers,
Peter

