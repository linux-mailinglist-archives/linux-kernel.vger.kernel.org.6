Return-Path: <linux-kernel+bounces-308453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BC81965D20
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 11:39:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B78A9280C32
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 09:39:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C191B813;
	Fri, 30 Aug 2024 09:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="Y2FSoJj0"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2113.outbound.protection.outlook.com [40.107.249.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDA51428E2;
	Fri, 30 Aug 2024 09:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725010775; cv=fail; b=mTwb5IOtXzwNZ39msNg7aruQf567TWj+NSSm3f6OKpkigP7Peq3O34TkJkx5YvrttAsOvK0axzXw1tX6FCFwIU0PNaB7dw3zmfFpL7jBVx6oLs81zcunXkt57yunFs2wtoDjI8qfYiydGm9zmOu76hwsXB6SRMrefbs27wYhvrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725010775; c=relaxed/simple;
	bh=HS+GdxSPCEKQL5eSMzN0vj1jWuXz0T8nqTCihcvPc6w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QLvXOkEnhxiT6Ku7/msEfkZko/A8YPIRCNFsjdKeuHmPGWbVWQcGCsNIZNGgfTF67MljBISgDFHGfRM1Truvj0QQpbNod74ih0IjnH+MdmHFDspGtrC1BYVljadRA0W3je1E7LDBYCOtHj46Xy+1fVoS5AGseGBphokRH4NcYj4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=Y2FSoJj0; arc=fail smtp.client-ip=40.107.249.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZrEjleWTEmyLLTpBB5GdWMbI+4CfOHxd/EThl/gvghMMZYigJw1udYp/IvebpVyxXdkOsl0iN4n+GY7vF0RKmXpLlz4UsLGNJTFx1MrX+bJYtdhdlLwzlkdJxLyW3J5TXlVYNVzJ6reJIt23S+uGZ1xWHS2EDoDKLykPHM15ya2Gd2SF1+zth4x6+TQh38xeLoGswvfZFur22k6PsbxlyJxSkmLG5Th6gQGfi1fuvLCFY3ZgIxkoUX6TIkGXJTMiW/WaXG55tMPDk/tEGLWChjsp6MMyFc9IzQNPEaWMp9zZUhFv5dEZtbJ0qnWfqbVt19d0tlaVCvB7twiDRdAp6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlH+NsHeGXIQTxh73XIDu+f8RxfX/wasP9eM2kNrYkQ=;
 b=KkMFHYpmZc+5qS6h7qj4NDU15GQNvK0y/IdTJUFqc1FjdliWt3KFIbOl/omn3O3hVb5q3emy6jxVYVeN6hbY6OJvT+UzOzWkZA7Vtpc8ynvZKCtF2NokkI8/UzQmJuVn8CigCg0F1BwQz1l+115vnirBj9QWmnkyCRkB/w6UrO9q/ufIjiTfLyGlGrB4quaRUCjdUoE2tuDETfaOIppmWQLrjr3CB9OehW2wPeUQm5RPGAXAw56umuSVCtJihTtMukSH440u+a/oAeQ4xfC+IzFcAYxk5HGwOuAacM+BncM4Xp7hj4g5okPrYWfSd9eckk9oS45/cb09Jd0pIvg67Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlH+NsHeGXIQTxh73XIDu+f8RxfX/wasP9eM2kNrYkQ=;
 b=Y2FSoJj0F0kjvDssWiIaYyq+lLvm91syX7FWEx7EDlrw52Ow7rfvm2omd2joLmyFIYJQDpar8obC1zrOtB90CNbeqajgTbyv6dmg8/1Xg4Fseoqkn+fMbMpshbEVfSV2+Ey9Hbys+jJDfeDzoIvSJP+8w8NJYST/1uiowBUg9uI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by AS8PR08MB7717.eurprd08.prod.outlook.com (2603:10a6:20b:525::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Fri, 30 Aug
 2024 09:39:29 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::4e72:c5d4:488e:f16d]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::4e72:c5d4:488e:f16d%4]) with mapi id 15.20.7918.018; Fri, 30 Aug 2024
 09:39:26 +0000
Message-ID: <f04577c1-13f5-4141-99ad-3f39156082c3@wolfvision.net>
Date: Fri, 30 Aug 2024 11:39:17 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] usb: gadget: uvc: Add H264 frame format support
To: AKASH KUMAR <quic_akakum@quicinc.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Daniel Scally <dan.scally@ideasonboard.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Felipe Balbi
 <balbi@kernel.org>, Jack Pham <quic_jackp@quicinc.com>, kernel@quicinc.com,
 Wesley Cheng <quic_wcheng@quicinc.com>,
 Vijayavardhan Vennapusa <quic_vvreddy@quicinc.com>,
 Krishna Kurapati <quic_kriskura@quicinc.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240711082304.1363-1-quic_akakum@quicinc.com>
 <2024071126-napped-cobbler-4693@gregkh>
 <0f3fe4b4-5451-480e-a9e4-11ee921521b9@quicinc.com>
 <07d9e1f4-201f-47dc-b692-b1aa14511420@quicinc.com>
 <acb0bcba-82de-4d67-9000-7c50a8456ff1@wolfvision.net>
 <6ec972b0-a971-4d35-9d8f-4a0fe3660514@quicinc.com>
Content-Language: en-US
From: Michael Riesch <michael.riesch@wolfvision.net>
Organization: WolfVision GmbH
In-Reply-To: <6ec972b0-a971-4d35-9d8f-4a0fe3660514@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VE1PR03CA0010.eurprd03.prod.outlook.com
 (2603:10a6:802:a0::22) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|AS8PR08MB7717:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b79e16e-5fa5-47f5-19ff-08dcc8d7a37f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXQvOHgyWUdzNjkyd3V0MTd4WGxIdWUwY2tObzBRN1hJWFN3OU0wNEVSUTMx?=
 =?utf-8?B?L1Jyc0piL05vUENGRXRXVlRrY2l0Z3E3dFFaeHJsMGJ6Q1VjYU9HN1NleXZw?=
 =?utf-8?B?S01walFsb25QVjcrbU9vMTZJQWp4Um9ic0R2TzVaQUhtVHA5MU84dzVmaHhJ?=
 =?utf-8?B?Y0Z2SU9KNGNwOWxIcTRoTUwvVHpncWxEd0VMMTZEL1ZYK1dSK29RN2FmQWNE?=
 =?utf-8?B?UGJKRGZPQVZmeTZHZC9iQ3JGZnpYRjV1R3Nrb3NTTzIvdFpqVXF1c0ZKZ0hK?=
 =?utf-8?B?QnJnTkxoaXhhV3VrQ2NWY3kwbTVtY3IzZXFKQ3BZM1NuWERkWEkveHBGK3By?=
 =?utf-8?B?NXpKeVhGcEpDUEdVRlJTNi9rdVhjdXJ0RTZMbXFrSHNHdTJDbUJETnVHTW9o?=
 =?utf-8?B?aVVIL1V0MGt6L1Y5M240RWdoNHRSVFFmYjhqTnk4Y0Q3WVZmS3Q2RitURWhS?=
 =?utf-8?B?WStWaHpBN25oY2N3QTZoKy9mbmhJdXRlMjBvZEE0cE9GcnlaR3pSRkNUZjBV?=
 =?utf-8?B?VGRGM1Y2dWJRMUMrWUJFSktHY3JNcVJIWDExbXduVVA0SHdBRHZ0azBBOERa?=
 =?utf-8?B?K09GOEppM1dVczBUa1ZMcFVOWlJQWDBwTTE5M0lsNU93R1ZSVTZvdHFZbkdB?=
 =?utf-8?B?cDRHamNYUmFsZzBLZ3gyMWhQZmZER2FQUzEyVG15S01sODlSOVdsTDkzbzFo?=
 =?utf-8?B?NWpHc1hhd1hwdGcxNHROcWE3RWorbmVoNGJhUU1nYkdsSEdpOVFVbEE2aS92?=
 =?utf-8?B?NG04K2RzaGJscmxkZGF1OFRJZGNlZUpldCtJM0RybGxOTzUwUzU2NzlJNXVL?=
 =?utf-8?B?NWJTWXlRY1FldFJoeW0raUE3bzBWZHNwZTRmQW1xS2hVNkYyWUY2UnVoZWJR?=
 =?utf-8?B?VDYwbHJHMDBPaHJ1eWVXbUJ5RWFQNnpQenhYc1kvTnZzV0tDRk4wZWVQRWln?=
 =?utf-8?B?VlRPN2diNlY1RUtYblpVNUxYRkFBa01qZVUyaHE0M2FVSyswekZjeitYeC9j?=
 =?utf-8?B?UklMQ0I1WldXSHpmY1dRbmQ0Ykp6UElVQzZXQnM5WHdHaXFnbVBDUkJjaWd0?=
 =?utf-8?B?YWY0WHVqN3FsTHZONks5bnZhb3czOTFkaG1zZzdzdytKMnRLbnFKWjZsTTVC?=
 =?utf-8?B?ZHZHRFcrZEFFcXJ3NEc2WlRHa0YzNTVma3V0OXd5OVZTOUhWZlh5SUpvUGQ1?=
 =?utf-8?B?UHdmY1JGQzl3NldFM3hmNmUxRzlvYVo1a2FnSGlLQS9Ca3R3M3NxeWlQUmdK?=
 =?utf-8?B?SUxIYnJDN0lSR09RYWFYSDZzbG5jWnErK2JZSFhyY3lST3ZseG1VdWlDdmpI?=
 =?utf-8?B?QU4wOVBCNmdwMHJtbE9vdVh6bXRjcERnUkJqbkdTUHZuM05UeTRqdXFLanIy?=
 =?utf-8?B?OFd5WGg3a0NmVG0ySzZkd3d3WXhJbnpxcm1WNlFwdmRWVEg1MzlwSEU1d3dL?=
 =?utf-8?B?NG4zdlR2SE5ldkkvakNxeHZSaDFEM1N2azc0czdERTZuUnNJMHJyNU1OaDdZ?=
 =?utf-8?B?YzRERzFWQUJjb0dCWXRiNDMxMlN5a1RJaUJLek5ueUdxMWhORThTVU1USzNi?=
 =?utf-8?B?UCtMZTllWnVXL3BlT2Y3bGEzZHlmWTRPOVcvNzFxSTc2cFp1QTczMHRQMGRU?=
 =?utf-8?B?aERBT00xWjRFZmpYQ3o4RzJGSU9QY1JNMCtvN1RRNy9xMWRXakVCbUpCcExP?=
 =?utf-8?B?NmFEVXp3Q3ZaUDF1eFFoallnUk9DRVpvTUR0UUY4aS9TVlNBMDRXNHRNTnNL?=
 =?utf-8?B?YWhtcFYzZWRjdUlLUXlaVjZYRVBTMEhkbjRUMTVPV3M4MXk1bFoxMUV2Rnhl?=
 =?utf-8?B?dFhucG11VVZ3WURITExCUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dENnZk5wSVJkcWFPZDIyRnZDcld6SDllaWtrenBsai94bzhIK1p1YW56WlBq?=
 =?utf-8?B?K0wxTWRsSlpjSEYrcDY5MS9zQXlZSUFLZFcyYmg2c3JOWkFST0xQSk5WUVQv?=
 =?utf-8?B?Vk1WLzdueE5NbFZkMWRpUUtoQit6L0ZRUGNHYTRCTXFGY280emNJY0ZxN1ph?=
 =?utf-8?B?K3IxSm5wNnIvS3hXZy9odWk4SFJhYzJMd1dUZ2poSG1oMTRFdUNlc2dKaVhR?=
 =?utf-8?B?aVpuQXpjdjhOZXZQZHdOLzVkVTBta2JVVnVuTFc5MjQwRFRubGJwUzhxMTd4?=
 =?utf-8?B?OTIzcEs3QXY5Z1duYUhhR0pJRXBTbFVkdXN6TWc5ODFEQzZSbWwzZExXSzkv?=
 =?utf-8?B?bzA1b1hvZE9VRXVVWUJrZUtqQlVBbmJVNWsvVmhCN0J3WGhOQWhacTRwZysx?=
 =?utf-8?B?K1FTWlkzaUVMMFZjMnFUMC9RVi93Q3NHVEdPelNaVFA2VTNrSXpZR0xKZEUw?=
 =?utf-8?B?NTBPVktHcHpDUDMvbkI2QmNPR0xnSkhwa21qM1FOS2w3NkdWK2ZvZS9PYXRy?=
 =?utf-8?B?Y2psQjR5Zmt0OXIyTXFLUGlUbjhWNFFsbXBoNDZoRGxPSjZlYlNmdlRvRUtx?=
 =?utf-8?B?V0IyNXArUG1OVmx1ODhocFo1a3JEdDkvclhwcXZ4cy9OZFh0V055MzB5WDYr?=
 =?utf-8?B?ZlEvaHNiVEE3ZllGVkp5WjlEekwra24rem56dEJtRFg4cjN3U25HcE5NOFpJ?=
 =?utf-8?B?M1Y4WGJYMTRwd0RwWHdMbG1tT1lRdE9JSVQ2eGRZbXIzV1dWWHVYcDdadEFm?=
 =?utf-8?B?b2NFeGJHaDl3VnNJTG1jZ21RM25sSWpTTkdMZVFxU1ZUaFFYR2JrellyZk9X?=
 =?utf-8?B?aXh4QzhFY2lSazVtK0JoU2htL0tPVXY3b2pUNmFwQ3RER0d2N3h3OCtJRFFy?=
 =?utf-8?B?Z1pnV0tyNEVYZWNGWlM2UGFFaFhackY3WCtrTGJjY0NqNlI1STlCemUzZnk1?=
 =?utf-8?B?MUFFb01wT04zeGVvc0psejRqVjIwTDZjV2NSSjdVeTJuOC9xQnoyOWlHTjBY?=
 =?utf-8?B?Z2ZZa3RqZHBPNGhDaE1JcjVFOFR5d2ZQQnZlclFVNU1pSmRCKzM0Z1RNOUw0?=
 =?utf-8?B?N3pWcWozOEhwMVpzMHJGdXBrSXVmRVhFMXg5TFRNSWpDNWVYZ2haV09xWFZB?=
 =?utf-8?B?ejJJVVAwNFV1KzRyR01hL1hzTkx2bTBXanJyR3RSUUxGTGpnejMvY1VIVVJ5?=
 =?utf-8?B?a04yUU9tM2QzUHEwVFI0Q3NuSW5Yb3R2dm5QVDBlTVdLWTVCMWRSRkhmZlJ6?=
 =?utf-8?B?eWFSNzA4d05VZXdoRDlieW5QOGxudGJteTBnQWFTb0plcldGb1lCNmtPL3BH?=
 =?utf-8?B?NnlpWnhyYTF1eS9JRXRUdmJCT2dJNVVNYWxwOUtVSkh4aFRQVzc2Yk9nVjhv?=
 =?utf-8?B?SkhBZmJITDc2SkNzREtIWUwza0FRUDhINHBTSzVGN0U1bFNhd25ObnhSOTlj?=
 =?utf-8?B?N0tLeTRkOTh6dXF2RUhOcVBKakdiOGJteGliYUIzV3RMREZneS9BZ2hvQjZr?=
 =?utf-8?B?S0tEZ1VSSHlLaDh5NjFNTFBOMVYvYlVnK01PV0pnSHQ3dW1RZVZWeTBZSm9k?=
 =?utf-8?B?VGZ2Rlh1L0paZDhocjBWY1JuTW94bDAweTVBS1VnOTFESHV4TVc2cmowcUNk?=
 =?utf-8?B?bzVIT3dsc01jWFhJTXRkRHFid2NuS0ppTWpXa1ZybDBzajB5Ym1GbHhUWlZV?=
 =?utf-8?B?Q0wwMTlkWENNeW5jeER3dFNlc091NnVQUXZnMGhDRmJlN21EMEJFLzFIbG42?=
 =?utf-8?B?aWxjVGJ1UnNVRktHVng4d2FIVlZoZ1VMTC80MFdPRVNMcFlQMFNqVlRsUzh1?=
 =?utf-8?B?eHY5RWR3S1o3ckRPbXVuSlNNL1d3NEtPYjZzNjZSZEVLSFBBUmxOV2VuWVVt?=
 =?utf-8?B?OUZIeEtSeG4vZ2RKMkZzTXh2VHMwR2lTWU8vYmhuT0lNKzNpZjBEYSt5aHlh?=
 =?utf-8?B?dzFCTHZRa2wwRHQwdXlZL2hwRmRldVAyM09JSDhCSzN3VjhXTGw3VWNFU09H?=
 =?utf-8?B?MDFiWVB5OWd1WFU4bWllN1JUaUxna2xzRFhRTldCYk5veHJBUHdoWUVDYmlE?=
 =?utf-8?B?U2lzV3duejNGRDRjcU9lSFRYUUE3M2JZb3YxRG1CNzlQOWoveEFvQW1LdW9U?=
 =?utf-8?B?dEpXWCtEZU81V0p1WFNSdWZBYU5kL3ZJcEZWd0tDVlNQbTlJZzMydkNUcUE1?=
 =?utf-8?B?U3c9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b79e16e-5fa5-47f5-19ff-08dcc8d7a37f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2024 09:39:26.7363
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MMuBC0j/nM92zB1wghbEH2dqFdfY34CIBW0G0JQJrfCshMY9cc5CLxcVbro+uR9H7tl2OBKHriq2HEyYhaaT3WsQhV628ipf/VegIjZSq2I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB7717

Hi Akash,

On 8/26/24 17:30, AKASH KUMAR wrote:
> Hi Michael,
> 
> On 8/26/2024 3:06 PM, Michael Riesch wrote:
>> Hi Akash,
>>
>> Thanks for your patches. Very interesting to see H.264 UVC gadget
>> support coming to life. May I ask how you tested your patches? What does
>> the user space stack on the gadget side look like? And what is the USB
>> host in your setup (OS, application, ...)?
> We have added support in our application code which opens uvc node
> during enumeration,
> e2e application POTPLAYER can be used to test which has h264 decoder
> support, with my changes
> you can see in device setting option along with mjpeg,uncompressed ,
> h264 and all frames and fps
> which we can be added in any init service, which can create and populate
> uvc properties.
> You need to create sysfs entries as shared in Documentation,
> With format names, driver creates parameters and we need to populate all
> paramters which are writable.
> we have validated in linux, android and ubuntu OS.

Nice!

>> On 8/1/24 08:15, AKASH KUMAR wrote:
>>> Hi Greg,Daniel,Laurent,
>>>
>>> On 7/11/2024 3:13 PM, AKASH KUMAR wrote:
>>>> On 7/11/2024 2:37 PM, Greg Kroah-Hartman wrote:
>>>>> On Thu, Jul 11, 2024 at 01:53:04PM +0530, Akash Kumar wrote:
>>>>>> Add support for framebased frame format which can be used to
>>>>>> support>>>> multiple formats like H264 or H265 other than mjpeg
>>>>>> and YUV frames.
>>>>>>
>>>>>> Framebased format is set to H264 by default, which can be updated to
>>>>>> other formats by updating the GUID through guid configfs attribute.
>>>>>> Using Different structures for all 3 formats as H264 has different
>>>>>> structure than mjpeg and uncompressed which will be paased to
>>>>>> frame make func based on active format instead of common frame
>>>>>> structure, have updated all apis in driver accordingly.
>>>>>> h264 is not recognized by hosts machine during enumeration
>>>>>> with common frame structure, so we need to pass h264 frame
>>>>>> structure separately.
>>>>>>
>>>>>> Signed-off-by: Akash Kumar <quic_akakum@quicinc.com>
>>>>>> ---
>>>>>>    .../ABI/testing/configfs-usb-gadget-uvc       |  88 ++-
>>>>>>    drivers/usb/gadget/function/uvc_configfs.c    | 570
>>>>>> +++++++++++++++---
>>>>>>    drivers/usb/gadget/function/uvc_configfs.h    |  34 +-
>>>>>>    drivers/usb/gadget/function/uvc_v4l2.c        |  80 ++-
>>>>>>    include/uapi/linux/usb/video.h                |  62 ++
>>>>>>    5 files changed, 714 insertions(+), 120 deletions(-)
>>>>>>
>>>>>> Changes for v2:
>>>>>> - Added H264 frame format Details in Documentation/ABI/
>>>>>>     and new configsfs attribute path for mjpeg and
>>>>>>     uncompresseed formats.
>>>>>>
>>>>>> diff --git a/Documentation/ABI/testing/configfs-usb-gadget-uvc
>>>>>> b/Documentation/ABI/testing/configfs-usb-gadget-uvc
>>>>>> index 4feb692c4c1d..2580083cdcc5 100644
>>>>>> --- a/Documentation/ABI/testing/configfs-usb-gadget-uvc
>>>>>> +++ b/Documentation/ABI/testing/configfs-usb-gadget-uvc
>>>>>> @@ -224,13 +224,13 @@ Description:    Additional color matching
>>>>>> descriptors
>>>>>>                          white
>>>>>>            ========================
>>>>>> ======================================
>>>>>>    -What:
>>>>>> /config/usb-gadget/gadget/functions/uvc.name/streaming/mjpeg
>>>>>> -Date:        Dec 2014
>>>>>> +What:
>>>>>> /config/usb-gadget/gadget/functions/uvc.name/streaming/mjpeg/name
>>>>> You are changing an existing api, how will all existing code handle
>>>>> this? Will it not break? What is ensuring that this will work as-is
>>>>> ok?
>>>>> I have modified all existing apis in kernel and have handled it and
>>>>> all existing formats
>>>> are working along with H264 in this change. Only user needs to change
>>>> configfs parameter
>>>> path according to updated path in documentation in Userspace.Currently
>>>> H264 doesn't work with same
>>>> structure and we need add it differently as a result these configfs
>>>> paths are getting updated.
>>>> Daniel and Laurent can you suggest if it ok?
>>>>>> -#define UVCG_FRAME_ATTR(cname, aname, bits) \
>>>>>> -static ssize_t uvcg_frame_##cname##_show(struct config_item *item,
>>>>>> char *page)\
>>>>>> +#define UVCG_FRAME_ATTR(cname, fname, bits) \
>>>>>> +static ssize_t uvcg_frame_##fname##_##cname##_show(struct
>>>>>> config_item *item, char *page)\
>>>>>>    {                                    \
>>>>>>        struct uvcg_frame *f = to_uvcg_frame(item);            \
>>>>>>        struct f_uvc_opts *opts;                    \
>>>>>> @@ -1936,14 +1941,14 @@ static ssize_t
>>>>>> uvcg_frame_##cname##_show(struct config_item *item, char *page)\
>>>>>>        opts = to_f_uvc_opts(opts_item);                \
>>>>>>                                        \
>>>>>>        mutex_lock(&opts->lock);                    \
>>>>>> -    result = sprintf(page, "%u\n", f->frame.cname);            \
>>>>>> +    result = scnprintf(page, PAGE_SIZE, "%u\n",
>>>>>> f->frame.fname.cname);\
>>>>> sysfs_emit() is made for this.
>>>> Sure, will change.
>>>>
>>>>
>>> can you suggest how to support H264 format without changing userspace
>>> nodes,
>>> as H264 format structure is different from mjpeg and uncompressed format
>>> and
>>> using same structure show issue as host is not able to recognize H264
>>> format frames.
>>>
>>> Thanks,
>>> Akash
>>>
>> After only a quick look at the USB Video Payload H264 1.5 document, I
>> think there should be a folder
>>    /config/usb-gadget/gadget/functions/uvc.name/streaming/h264/
>> with the formats
>>    /config/usb-gadget/gadget/functions/uvc.name/streaming/h264/name
>> and the frames
>>    /config/usb-gadget/gadget/functions/uvc.name/streaming/h264/name/name
>> in analogy to the other payloads, namely mjpeg and uncompressed.
>> Naturally, the attributes will be different to the existing formats.
>>
>> What exactly does not work with this approach?
> We need to add additional name for mjpeg and uncompressed due to
> different structure
> as we cannot support all 3 formats with same frame struct type.
> This name can be any dummy word and formats are added inside this dummy
> name instead
> of mjpeg and uncompressed.

OK, but this sounds like that the structs and/or the code behind the
configfs API need to be adjusted to handle different parameters. The API
itself (for existing formats) must not change as it is used in this form
by several user space libraries, tools, etc.

Please start by designing the API so that it makes sense to user space
and adjust the code behind it, not the other way around.

Thanks and best regards,
Michael

