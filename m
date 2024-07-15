Return-Path: <linux-kernel+bounces-252041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EF72A930D6F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 07:15:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704321F212A9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 05:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C95D013A89C;
	Mon, 15 Jul 2024 05:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="MG/EnAIX"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9A023A9;
	Mon, 15 Jul 2024 05:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721020538; cv=fail; b=R87ZDkPxR9F6JDymj0EWLOmQWjaYyReYnEJHYCqm9aRHYPy6Ibh1W5cFkVeju70Qjpe9dnY2ampe0uCb5i21Mf8g+NPok2RBe6jUJUhyQdS7JFpleFtJJvrK0gNPbHKLjTdY8ddk6CkGtNSqyuil7gu8lfXg+SkV6Vvt/fmQRtA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721020538; c=relaxed/simple;
	bh=bFcfmZd4FBiLy4hOt822cE7yoMDYSf/Wpx/YEMnpXeg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=mWPqbAsr4MqmVFHmLkezbTxgfrbxhWxgeAJGoddugkyfVpU+yvMTA1cCDbHRpT6ONMsWCbRwPVhJpVi4LljWMKfgy/BjvFxxg6+FOBkro18/l9ixTqgGcXPBRC/2XLz/UwpFr1PyFEs8VF8gu/qtB738C4JHqo9A92/yRgR4res=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=MG/EnAIX; arc=fail smtp.client-ip=40.107.244.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HBo8lInaaOCGI4fiyyveuYM1RlP2sEUno6A2CTl1wLtu68pvQq0I288SMZi8GyRHf+9TrXRt5Y+MVoz9Jtgh6L/7a5kFxWgOdW3lQlyiFrd7pi82SY+Xbodk5tv5COxaYftCMtt2WBX4Cr00Gi/MN50n62WEURksnFNTnF+y8puOw+ykf5zP2jfzzEm4uGCJOF4D7RXLgwYzLwNzi+3YG+okheJIk/TQybFGST8ufdF3mLHn4u+NF9ybIXrg5gDyifhywz0OUFXrsh1LkIrISqmNNJUqzuRW9dHtkS3plV48H8tGwaRiJ/EFjtz0BKTOhuZJKP3BpYR90MFKUjKzuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vxpnj4gO5okFkmkxUbYW8J4+5H9IiWymseKvzq3C5Vo=;
 b=YXN/GqTkFEKg/RnPVGS+GvcWfIuVA+Oh4RxEw6wgNqqd8ihzwagrZjIj78u2ELC6vCNFW2NId8/DekhwM5sk+JL6pxifUEE92AvPLTlCnOoHY2aais90d0Q1M1GB0DbXMt5QsR46wJ2lH3WTUK09Bd42y9xfrviMB0KwHvY+79vOp6Cda/3mQBfJWBVkOOB7oZUAgi4n4E5D5d2V3f4PxOs6gdind2SWj61URj4YtYYII16DaesKdh8op/ZUwTG1MR24EHCqtPG8dTtwbZGwO8zs889EjKOEuRbKBh06m8FreMoGKUwY9nKzmXeYnBXCfPoabg1d77l9wOJiaZo4Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vxpnj4gO5okFkmkxUbYW8J4+5H9IiWymseKvzq3C5Vo=;
 b=MG/EnAIXwoqCRAI5Y18n/Op/Ml1yZYNQLdW9fjau0mqxlVWNnEPZ75tA8dapdQkH6X/rBEma4v9ATf8nMdbMnW2NfSubn+waZsV2VcKfw7/JQRgOccwmYhZj3tcx7AXa8o+X0apBl9xPXmZbW9SMQZsHfzkwr0cR7WWT7ApUBHI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8403.namprd12.prod.outlook.com (2603:10b6:610:133::14)
 by SJ2PR12MB8956.namprd12.prod.outlook.com (2603:10b6:a03:53a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29; Mon, 15 Jul
 2024 05:15:32 +0000
Received: from CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::bdb:41da:3604:a469]) by CH3PR12MB8403.namprd12.prod.outlook.com
 ([fe80::bdb:41da:3604:a469%7]) with mapi id 15.20.7762.025; Mon, 15 Jul 2024
 05:15:32 +0000
Message-ID: <5e9be210-0182-45d5-b62f-55c335806455@amd.com>
Date: Mon, 15 Jul 2024 00:15:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] docs: scheduler: Start documenting the EEVDF
 scheduler
Content-Language: en-US
To: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>, corbet@lwn.net,
 sergio.collado@gmail.com, peterz@infradead.org, rdunlap@infradead.org
Cc: bilbao@vt.edu, jembid@ucm.es, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20240713140455.4072847-1-carlos.bilbao.osdev@gmail.com>
 <20240713140455.4072847-2-carlos.bilbao.osdev@gmail.com>
From: "Naik, Avadhut" <avadnaik@amd.com>
In-Reply-To: <20240713140455.4072847-2-carlos.bilbao.osdev@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0035.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::10) To CH3PR12MB8403.namprd12.prod.outlook.com
 (2603:10b6:610:133::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8403:EE_|SJ2PR12MB8956:EE_
X-MS-Office365-Filtering-Correlation-Id: 449ca2fb-0a43-4afd-0aa2-08dca48d2641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2c4M0RFYVVSdUtYS3ZJM1lYR2k4ZnMveEpnazMveU4rcWUwdHNrYmtJbGU3?=
 =?utf-8?B?dVRPektmZXJKaWIrWEkxK3Q2SUV1MmgxdUNqWWhTaFFtRG9vV3hjcEhvSnNa?=
 =?utf-8?B?M01TcEgwemxSclNMUTNnaWVYc1NMQjM2UDVkazlSS1ZGMFZBVlZYNzlRaWFS?=
 =?utf-8?B?d2xaSEF5ZzNibCsweCtER0Zzbms4ZCswNnZ0MERQWVlTUGFTaW9LOWFyMDVv?=
 =?utf-8?B?dkVVeUtDbW81c2REODkzSXJIWmN5djNzZWVURmZPVE84cHpKUC9SZlliT1dO?=
 =?utf-8?B?NFRwT2lMaENGL21zY09wVFZsaXRyMmtDOUM5UGlHZ0hMb0dLTE1zQThPTHo0?=
 =?utf-8?B?WlFuT3I5RFRNY3B0Tm1GVUdPY2x5RzZoY1NIdS9oMGxNSklsRTdMOWhaSWta?=
 =?utf-8?B?RVNTWnJpRU0vSFRTQ1lYSE8zQXJVbE94VVR0QUU2RDVhbDhnUmIyaFZCTGxn?=
 =?utf-8?B?cWthejlKVU1IK1IwSTlCU3JIRHhveHBpWkhvdTZhRFJxeWRDNnZEQmtmVFM3?=
 =?utf-8?B?M28yQ3FzSTJVL1ZESVI4UEJ4bFdlNENOdElvS3lBdlpjVWNPdCtSbmhaNkZi?=
 =?utf-8?B?YThZdzc0L2xrb21wdmRoK1pWN2tMNE1DY1o2TmxFeFoyQUozdUFpejNGZlNL?=
 =?utf-8?B?Zmd1VXRSYVo4T2svWFVWdU9sNDArVDVSUnRMcmVhcHFVUmZ3L0ROVTB2SUJR?=
 =?utf-8?B?emtObStqR3d6NUkwcEtlVmNsYm1BeEh5dzV2cC85bm9KTUZoakRZK2d6NHdO?=
 =?utf-8?B?RklEMkRZaWUxVytxcldtSXhScUlmZlZHbmw2N1dudTdJeWNUMUlyOVpZelAy?=
 =?utf-8?B?N2JHVzZUMjVuN1JQbUNSVFc3elplT1pQOHdPVlJLUStZbnFDdUxJTXp4ZnhQ?=
 =?utf-8?B?LzZ5Mmp1SVZPelVuYStwMitzb2VGOTZaMzI0VWVkTXBBZ2Fvd0JkY3REL3Fk?=
 =?utf-8?B?eWhidWVLdjhxbW9zNHRYQ0gvcW9Ic0hSeXFac05lSVErOGc2QTdHSldGeFl0?=
 =?utf-8?B?V0xsQ3pFRE8wVVN3MXd5bnBKNGZ1N2l5QWgwSDJMQnVlemlCdFMyY3BaYkpW?=
 =?utf-8?B?dzNOaVFkeTFrVW5OdFN4UXFiRkhWcXRXZ3hjenNKUVFBOTh1YWtIdC9mcFZV?=
 =?utf-8?B?TXJnN3owemdCM0k2MkZUVldlS3BaS1U1YUpHdXBiWjkyUlNDTCtqN053YW9N?=
 =?utf-8?B?VnRWRWV4SEZyTDE0YjZodnE2Z1pKUEZJWXZ4ejZ5ZW1aRHJncG9MMlhBbjYr?=
 =?utf-8?B?VTBtUkRoeW1FejZnV0owVzJ6RlVlaXJ5UnlkK3ZyOE9JbU1EK2FzdVRieUpC?=
 =?utf-8?B?RW5ic0NxRlFGSUlmQlh0UmMweDdIMyt0SDc2QWo3LzVqNGY5ZUxKMzkxc1pz?=
 =?utf-8?B?YmxCL3hWcG0xYWtWMTBkZVJIUFZaUlE3Q0VMcFdaMXFGSXJhZkMwQmJmMjE2?=
 =?utf-8?B?dGNGOVl0Q1pFd1YvOEtoUHhZRGZZeE5tY1ZQWkFGTkEzbnREK0lXZ01zUnlq?=
 =?utf-8?B?U3IzUXp3NjFTb3Y1TkhpYlZhaU9qSE5XbTMvRjlzQjVnRDJoSnNIRENNRGR0?=
 =?utf-8?B?WTk1Um5ZZTdNaFdUZHdKbWNqbUpJVEk4b25aQXROLzdzTUErSDM5Z2pNSHpD?=
 =?utf-8?B?bG9NSFBmdmtBdlh6UDA1aWZLYmY2WHBkUjFpTE5lWkVqZjd0M1lIWHc5cHpG?=
 =?utf-8?B?VFVzTG0wbzh5TVBKMFZWSUVyVHBDYThkZTJQOXhJaWt6RHhubDVuNEMxTlpO?=
 =?utf-8?Q?7lW1qPfdBJ8HX2hIOY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8403.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WDFOWnpneTkvWVVRN0gwcDlBRnBBVXM2VGtHMFh2Zm5GVnFvYTdsMFJHVGhv?=
 =?utf-8?B?cjNQcEZLbVI0cE8zZGV1Z3ZGT3FzeSsvVGt5YXcycVQzNVcwZlh2MnVYT21z?=
 =?utf-8?B?blU5TGxGckM3MlJFUmZDS3QyUnJobDJqeVF6NzVPTElleE1OVTBacWVrUUhT?=
 =?utf-8?B?VjJ5NGtvUTdncTF4NG9ZNGQ4Nnd1MU1VRlZOdmxteWJibWREbGxuNVQ0UDB4?=
 =?utf-8?B?dlFQZllOdkJZZG56OWRSTGVuMUZYWGcrYnF3ZUNwRndpQkNYbXNuQWZFeERz?=
 =?utf-8?B?UVRWTkVQT09mWkhUbXdJSkFDRDJuSGY2SFhPNUxBd3lia3ZiQlYwU0lNQU84?=
 =?utf-8?B?Y0ZXTUZpL0VWRjhFeGMyTW9qZ1VOVnk0ekxIOXd5aVdGQTFpdjJIWkMvdlc0?=
 =?utf-8?B?emp4QjJQVEVEUnUxMmZrNm9MeHlIeWtkYS9tMG5hSTNoUlZ0Z2VwbjV2dWlJ?=
 =?utf-8?B?b2tSNjcyTVVRdXdhbm45dkhWM09uREFIeVpETEpZcXNrNmFwRDNxaHluN2ZX?=
 =?utf-8?B?UUg1dklnaXpDMk8zak96R0R6Y1FITlY2bmg5ZTI4elBaTG5CRDRTL2NSamhW?=
 =?utf-8?B?QU4yVlJOakZTLzFaN2t6TUVuVWk3dXJUMGhKZldEdGVJcTB3b0V2d1B0dXI2?=
 =?utf-8?B?VUY0TlFGZ2RMdnJpbUU5dkVReHpOcUMyTHovNUh4M0UrQS95b1FMTFYySkln?=
 =?utf-8?B?MTlTMitOT1NJSEtDaTZsVWdMc3VxdTFLNTUwYWVvUlU3dGFlZ2VLbUg3eGE4?=
 =?utf-8?B?NUlDeGN2M2FMNjhHSWpvbzRydjBIRXIxTzdwNEVPSHJrUVQxa2kvMUlFL3RT?=
 =?utf-8?B?LzREazl3Qng5eTEzRGpTOWMrUlNVc3hra01MMllta1FiR3ltUmhwTHNkQ2xs?=
 =?utf-8?B?bXF2Vm8xK1lMR3o0a3p4WFRjU2YveUh1RmhoN2VnNE80TTBRSGFBT2tGZTFN?=
 =?utf-8?B?Q1phczJ3Nzc1VllucldPeVI5TjhMWkFaeHNNRzJNRWZHSVRHVmZmeFJ6Vjl6?=
 =?utf-8?B?QU5HZXJGQ2VOZHRTdmQ4c2p4Vmx3eURQS3F3NVdmaUxKbnBGR21CM2FWQlF0?=
 =?utf-8?B?WHorQTU2QkJPVHY1Q1ZKWEFqNXl1aXhxOHU5V1pFRVlKUGk3bWIyajV3dUY3?=
 =?utf-8?B?ZkdnSG82UGRmYzdUcE1zKyttOFZuSTkyc2NNSTRBTFV0ZnBmcTlra2pUOFVT?=
 =?utf-8?B?NFZUbFRxeHRwbk83RFFTcEpGTkROV3pNYjlkUWlpRWRPMkpGczhBYzVaSVR2?=
 =?utf-8?B?TmpiamxRa3BXSHdZNDIyVHZxYVJTY08yaUEwMW1YajIrbFFNZzdFeWpiNlY0?=
 =?utf-8?B?K2RSOVpwTEc5bjJYeXp1d2l4TjZDWTl0RGo0aWxOMXRNMXprOXAvUE1uN3BX?=
 =?utf-8?B?WmlDUkwzTGE1NVh2dlNYbUVORHNZcjFGQlN1TG4wWUxON1k0Z000WjB6L2Ex?=
 =?utf-8?B?aThLbERaZldmdmswRlBOQmFaTHpYdXZiVEsvWlRTanl1R2NrQ1lNK0J5d0sy?=
 =?utf-8?B?dEdKZjBEWFExeFRRWjc5WG9Ha1VRYXdJNVNNZHBvdVhVbXErc2E3eVpJN085?=
 =?utf-8?B?aE9LTWIwdlVtd0pNMG90MTlZdzhhSmM3dm1lM3pyd245bXBpYjg0d2pscVJF?=
 =?utf-8?B?UnU3bCtkck5BWVo1WXgwWXdwNE5hTHN1MlNYcElFTk1ENTVhVm5WU0U1VVcy?=
 =?utf-8?B?eTZlUThTUDhSMU80TEIwbk9zeHFhWnJVanpIWVB5SE1vUmt0QWV6dVNHRFpw?=
 =?utf-8?B?d1FpUGpMemwwdHVqK3RVNXBsazBuM3NURHRId3NrNU8wdEwrenhzYW1INDFq?=
 =?utf-8?B?aU1WaERkRDhUbHNpTVE3bmtIZWRVNWE0L2ZNLzQvQXNod2huMnZ2MGFNa3lC?=
 =?utf-8?B?dXVrMG5iUlh2anhCanIxUkJpYi9xTWFFMlozZ1lFd0cvU3NoVDI3RmJESVFK?=
 =?utf-8?B?YXZSU3FTQUZESENidlV2ZmdKemp3NDJNTWU0NjNtUmNmbHlrS3dvWkgzMit6?=
 =?utf-8?B?eTkvb3VrSTZoZitUVnZQT01UejE2a21EL3Q3b3gzZU9lT3YrSDBIZzYxalZZ?=
 =?utf-8?B?THU2enZGYVVva0QxcnpENkdXM3BORkhVWXorVUZFc0dIdDFpemlpTzdmQ3JP?=
 =?utf-8?Q?MHtG/skPEbk4RREf0vu57L0nO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 449ca2fb-0a43-4afd-0aa2-08dca48d2641
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8403.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 05:15:32.1191
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bquzv/A0RJPdQadJy5Kixw76Tz1Ujbw+0CCOtqLxv6QWUWKOmQOsIcXB8Qk/UIKiS2AO92HiYA6G1ABFOVIcfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8956

On 7/13/2024 09:04, Carlos Bilbao wrote:
> Add some documentation regarding the newly introduced scheduler EEVDF.
> 
> Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Carlos Bilbao <carlos.bilbao.osdev@gmail.com>
> ---
>  Documentation/scheduler/index.rst            |  1 +
>  Documentation/scheduler/sched-design-CFS.rst | 10 +++--
>  Documentation/scheduler/sched-eevdf.rst      | 44 ++++++++++++++++++++
>  3 files changed, 51 insertions(+), 4 deletions(-)
>  create mode 100644 Documentation/scheduler/sched-eevdf.rst
> 
> diff --git a/Documentation/scheduler/index.rst b/Documentation/scheduler/index.rst
> index 43bd8a145b7a..1f2942c4d14b 100644
> --- a/Documentation/scheduler/index.rst
> +++ b/Documentation/scheduler/index.rst
> @@ -12,6 +12,7 @@ Scheduler
>      sched-bwc
>      sched-deadline
>      sched-design-CFS
> +    sched-eevdf
>      sched-domains
>      sched-capacity
>      sched-energy
> diff --git a/Documentation/scheduler/sched-design-CFS.rst b/Documentation/scheduler/sched-design-CFS.rst
> index bc1e507269c6..b703c6dcb3cd 100644
> --- a/Documentation/scheduler/sched-design-CFS.rst
> +++ b/Documentation/scheduler/sched-design-CFS.rst
> @@ -8,10 +8,12 @@ CFS Scheduler
>  1.  OVERVIEW
>  ============
>  
> -CFS stands for "Completely Fair Scheduler," and is the new "desktop" process
> -scheduler implemented by Ingo Molnar and merged in Linux 2.6.23.  It is the
> -replacement for the previous vanilla scheduler's SCHED_OTHER interactivity
> -code.
> +CFS stands for "Completely Fair Scheduler," and is the "desktop" process
> +scheduler implemented by Ingo Molnar and merged in Linux 2.6.23. When
> +originally merged, it was the replacement for the previous vanilla
> +scheduler's SCHED_OTHER interactivity code. Nowadays, CFS is making room
> +for EEVDF, for which documentation can be found in
> +:ref:`sched_design_EEVDF`.
>  
>  80% of CFS's design can be summed up in a single sentence: CFS basically models
>  an "ideal, precise multi-tasking CPU" on real hardware.
> diff --git a/Documentation/scheduler/sched-eevdf.rst b/Documentation/scheduler/sched-eevdf.rst
> new file mode 100644
> index 000000000000..019327da333a
> --- /dev/null
> +++ b/Documentation/scheduler/sched-eevdf.rst
> @@ -0,0 +1,44 @@
> +.. _sched_design_EEVDF:
> +
> +===============
> +EEVDF Scheduler
> +===============
> +
> +The "Earliest Eligible Virtual Deadline First" (EEVDF) was first introduced
> +in a scientific publication in 1995 [1]. The Linux kernel began
> +transitioning to EEVDF in version 6.6 (as a new option in 2024), moving
> +away from the earlier Completely Fair Scheduler (CFS) in favor of a version
> +of EEVDF proposed by Peter Zijlstra in 2023 [2-4]. More information
> +regarding CFS can be found in :ref:`sched_design_CFS`.
> +
> +Similarly to CFS, EEVDF aims to distribute CPU time equally among all
> +runnable tasks with the same priority. To do so, it assigns a virtual run
> +time to each task, creating a "lag" value that can be used to determine
> +whether a task has received its fair share of CPU time. In this way, a task
> +with a positive lag is owed CPU time, while a negative lag means the task
> +has exceeded its portion. EEVDF picks tasks with lag greater or equal to
> +zero and calculates a virtual deadline (VD) for each, selecting the task
> +with the earliest VD to execute next. It's important to note that this
> +allows latency-sensitive tasks with shorter time slices to be prioritized,
> +which helps with their responsiveness.
> +
> +There are ongoing discussions on how to manage lag, especially for sleeping
> +tasks; but at the time of writing EEVDF uses a "decaying" mechanism based
> +on virtual run time (VRT). This prevents tasks from exploiting the system
> +by sleeping briefly to reset their negative lag: when a task sleeps, it
> +remains on the run queue but marked for "deferred dequeue," allowing its
> +lag to decay over VRT. Hence, long-sleeping tasks eventually have their lag
> +reset. Finally, tasks can preempt others if their VD is earlier, and tasks
> +can request specific time slices using the new sched_setattr() system call,
> +which further facilitates the job of latency-sensitive applications.
> +
> +REFERENCES
> +==========
> +
> +[1] https://citeseerx.ist.psu.edu/document?repid=rep1&type=pdf&doi=805acf7726282721504c8f00575d91ebfd750564
> +
> +[2] https://lore.kernel.org/lkml/a79014e6-ea83-b316-1e12-2ae056bda6fa@linux.vnet.ibm.com/
> +
> +[3] https://lwn.net/Articles/969062/
> +
> +[4] https://lwn.net/Articles/925371/

LGTM.

Reviewed-by: Avadhut Naik <avadhut.naik@amd.com>

-- 
Thanks,
Avadhut Naik


