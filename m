Return-Path: <linux-kernel+bounces-565616-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7795A66BFD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 08:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E7FE19A234B
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 07:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F4A31F8748;
	Tue, 18 Mar 2025 07:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="r6Rq1oRA"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2067.outbound.protection.outlook.com [40.107.237.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965E21E8356;
	Tue, 18 Mar 2025 07:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742283394; cv=fail; b=PTevebt2ui79DU0TLzCPZwWptisPzxT7wRI++8K3faKqFAAVbWAhStuhpfnwccOawXYpxIkEaHTyFroDTLE8O/yFuk4Re7DXtQ9pt79FxtSqxe1Zp6jiDwZB4Y5Jj6fW7/FxoF2vxCOruM8uon4dxhPzcL56/KuF7s1vxdAoqSg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742283394; c=relaxed/simple;
	bh=HnKSQuvL41bcPZTe/VHgsAn/o26pB4zGzgBdXkt48XI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H8fOFJw+Q93HMMidc7bBXMTkWYVZjVJUWT8JvVvIQ/y/HhaYGqJQcXi8BCjJbVK2ObguzGBRhZzj2BYtWzGnHQxrYLu7LQlvZ/vFLwEjTo4qF6NXMP+QEn1pxegNF/BJy3FzexYDF09XWsknzCGdD+kLgmMs8vR2znkNjcPXPIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=r6Rq1oRA; arc=fail smtp.client-ip=40.107.237.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOZfnbHZSPtrcX6XvjRqUiuyExFrQ5O+hIdnmU7zidoThXhdlG66m4xPxBEb4ufa7m9/t3y+RcJOHKpbHNH9VMWAaKpVYNwLPPpuWTUPnzxin/+m6sNqcrniobkP0M5/FGkm+8bmRHjXO6AFI0/LnRORwjLaqko99ykdb2YKC0qhbUlt1sgkimrv+39ZnYPgKcEgQdEwe66EJZK7UhdsNfn14QENHXGS9bUQyGYNubUN1N9cPs4kK1WBws1q2jWhx81vfH91Buk4E8LZUtjn5sZn0hzhw+xn/iydZPZBWGlBj08QZLQb386hUkl/h56p7Ed1LQG6NKGF/CH5H/hrrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/Fk30w6hevCaQmWOf0nLP7kQt8i2CFwmfOzM674etY=;
 b=LrN5mpcHTBn/rxfEIlP1HX1luZNIL5DJIbp6q1eQrZnkwwIIGvUjU4b5HVi63REXtNUI9NXbC+pVOCWRiF1mlYnXrBDLhAjyDL6jK2i73WMk6jLz7fMT/4blPtSAS9tUg9mi3ZSgG+DIaGsFZ1aJ/jk7gl10oGvACV7YfaQk9u8RKoItwv3PYnsx9iFf17xc2aUX2ZDQwO/jsSjH2IabzpGn5ldSSIac8VB9DWMDfNiAn6NLwC5N+u0qTn6t7APAS2PQIsQMA5YrvJuBtu4kHuT6BD225lbiwdJQRuEV8sda/Inur/BfbTOmuk9cR/zgDdkuzP5l/wIm1lFz4dOe9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/Fk30w6hevCaQmWOf0nLP7kQt8i2CFwmfOzM674etY=;
 b=r6Rq1oRAoyqYYqxxaK1WPBSVrs3zQklNNnpcf+QwA6BDs8bo3fOuW008ltkUB76hTFTxFvwm7J4lP1UNb6Vtc6mJYACzBwNuRevjXcCopDHcPKp18ZGzYH5YnJtQyB53t53D4EYDHSu6oF6ZgQKC6S9C4eITAvTq6SjPJKi20eM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 by IA1PR12MB6186.namprd12.prod.outlook.com (2603:10b6:208:3e6::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Tue, 18 Mar
 2025 07:36:28 +0000
Received: from SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899]) by SN7PR12MB8101.namprd12.prod.outlook.com
 ([fe80::fdb:e120:f99c:c899%4]) with mapi id 15.20.8534.031; Tue, 18 Mar 2025
 07:36:27 +0000
Message-ID: <a8be82ee-b6c8-4308-bf3a-d18050dd043a@amd.com>
Date: Tue, 18 Mar 2025 08:36:22 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usb: dwc3: xilinx: Prevent spike in reset signal
To: Mike Looijmans <mike.looijmans@topic.nl>,
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.323aeebd-1577-4c21-85a6-ff9262fb6cb7@emailsignatures365.codetwo.com>
 <20250314155706.31058-1-mike.looijmans@topic.nl>
 <20250314211411.l5taj5nysvcalfyz@synopsys.com>
 <8ee2ce74-dc6b-463a-ba95-ad25669a1179@topic.nl>
 <20250318001211.tnjwfckt5j4fbvjf@synopsys.com>
 <a9812897-2c79-4a1c-9431-c6f184233a57@topic.nl>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <a9812897-2c79-4a1c-9431-c6f184233a57@topic.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DM6PR03CA0039.namprd03.prod.outlook.com
 (2603:10b6:5:100::16) To SN7PR12MB8101.namprd12.prod.outlook.com
 (2603:10b6:806:321::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8101:EE_|IA1PR12MB6186:EE_
X-MS-Office365-Filtering-Correlation-Id: edcc5b58-0c9a-4ca6-20aa-08dd65ef97db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXNQQTYxZ1JRVk1QRTBkY2JGSHNqU0hXTWFTV0g2VGNRWVN1OFZ3OGVLVDln?=
 =?utf-8?B?VFBheUsrTzllK2V1WXJreVVrMklRcHprVTJzb0Iyd2JFTEx0Mk9YVHM2SU8v?=
 =?utf-8?B?dmNKd25MWjRlNXg4ZVdVd3JSSFNsM3VlT3ptZTNvelF1R25sWkZiZ0FDQWFZ?=
 =?utf-8?B?SVkzTkxXUFI4b3pyaUxqYituUXo2VFJ5d0pSWFFLeXRRanBXcVVxWHBGbk5R?=
 =?utf-8?B?NjlYS0JCRlk1YjBVYzkwNFk0NjRKUVNMRGhCME51dHFFSlpieG5zM3gxSGQ3?=
 =?utf-8?B?dWpmTVFGV1ptcGpOUnZaUGtUZnZqSDlyMXg0OVRVRlptazJENFdzM2lYTi96?=
 =?utf-8?B?U2FiS0hHMHpPNXF4a0JjNDRSQ2RQN3lEaGNSWEE4K1RFRFhhc213S05vZGdQ?=
 =?utf-8?B?QSs2RkZGMnllMlFQa210YnhNVjgyYnB5cmtnV3FOQ0xYUWNJWVkwRjh5UjNG?=
 =?utf-8?B?cWtmc0lrR043YU9iT0Q3ZHE3WFR5MkEyS2J2dWU2U3Q2WTk3UDVpWHRPWlBu?=
 =?utf-8?B?aHp5c0JTRWNBWHM3ZnpvM3J3ekFiV25yd01OTlRnSVBXdnFvUmYzeFpnRnFx?=
 =?utf-8?B?bWxnTERXZXlvTDJLTjFmTU8ramI3c1pvaEtxNS9FRXkya3M3TFZLRkJBeGZ2?=
 =?utf-8?B?REpUQmdsamhWVG9yclpscGhCOWZRTmY5b3NaNnNyUFVJY05hb1BYS090MjYr?=
 =?utf-8?B?R2k3RDFNNSticW5IRnhWVndxUm1scDB6NmVwa1RLRFBPODdoUGkrNjhKUEFw?=
 =?utf-8?B?VkhBdmVoc055K2ZLYjB6Z0R0S2JtaVNlSWxNa0hqT2Uva0lGbThUZWNjMVZR?=
 =?utf-8?B?WkxITjFTWHI1NXZaZVAyMkNJKzFDN292N3o2a0Z5cEJTZy9rS3dNVnRnOVZo?=
 =?utf-8?B?Ym90OHJmNkVRYnJxTnZ0c2hoRjJNQVBDbEh1ejdaZkowd1JFLytKMkxhajdH?=
 =?utf-8?B?RERVOXNGS2xqUlNTbmxFd3F1ditkaVRweVJMZSs0ZytrTDU3UjgxT2JWWGty?=
 =?utf-8?B?UnFtaUplaW5taml3c0F1SlZMUzIvUldtUzQ3Q3RidlVnenRmUnNCOEVMeVI4?=
 =?utf-8?B?N2NDc3NtVFVuRXAzaXFxK3kxUnI3SUpYZk1tMEtwZ2ZaQWNyUUJESHRCaWVv?=
 =?utf-8?B?K3lZNG9Vc3NSL0Z3ZzBOYWR6VE1XRnVUYXZrL2FtSkJ1U0IwRnpqQmhZNTNN?=
 =?utf-8?B?UkFqMW9RVHdmYlJKZDkxdm5WN0Yvc1loUGNjWEpoNmZvR0VSTnVRaVpjbEl4?=
 =?utf-8?B?a25ZRXAxL3hnMEhqYVpTUjRzdGJKRnNoV3JaenNUbFlLOGVlRWZnZmhsd0wv?=
 =?utf-8?B?Y3RCNmRtSm9EWHZvSzNVM3FsSFFzNVFMSmZqSVJRMnpKRC9MdThjbTR4S3Fo?=
 =?utf-8?B?Zy9EaCtjYUwzTmpNanBsbGkyU2VSenZNbGYyVDVHNTcwT3F6N0llTFhTdTdQ?=
 =?utf-8?B?ZzROQmR5MmZCZEpBamVlTk5PS1Brc0IySWloSk5qYm1TOTZpUThWakc1WlZo?=
 =?utf-8?B?Znh4YzVIdE5hdWVEVTF0WDBFb3o5UWZzNTM3TGp6ZCt1NmFqeTJYa1NVdmFM?=
 =?utf-8?B?bVIvZGlXbEhmczdwd2FSUzBPUStjUmFNT05VeklSdEZlc1FGdWZyN2JqYUJW?=
 =?utf-8?B?Yys3SUZRT2NzMXh1cndvWjVkZm43UWlzYnQ5cEFzQjZYOXhjUnFteG1UTVVt?=
 =?utf-8?B?TXVBY3NSUGZXZWQrMUFyR1BjMHYzZFFrTHBlYUhhSWs0TEk0bFkvVUNmWVBp?=
 =?utf-8?B?aEZMZ2VnNDE5QnVWVDE1d2JPejMwUVdSZWxvblBFR2g3aXBiak9tMUlxWFRs?=
 =?utf-8?B?VU5GdkFkQ2lOYlN0ZHJhM1Y2d3hSZjBHQ1VWUGtaajB5TWMwbmRYZ3E2bGs4?=
 =?utf-8?Q?5FL3BcrN+yRCj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Y1g2cWZ3bUtRUnVONnRCOU5rUmlyZHlwVHRmcjVQT2gybUZPYVVTYWk5RHZm?=
 =?utf-8?B?My9YMjNjZzJlcmJ0YkxTWHNmUkp1cW5MZTVZSTZReUxFMXFacitGemwwVi82?=
 =?utf-8?B?RFNJR0tjWUVkM3FUMVF3Z2U3b0RxYkNQTVpwVWgveVg4MHdGTFlHd1gvZFlW?=
 =?utf-8?B?WnRwZmZWM2xScEhrM3pMSDA5b3JEZStIK1FTK1pKTEJnWFRCbm5OcEVwd0o3?=
 =?utf-8?B?eWFRdS8zdFF4TDRVVmU1M0xXQ281c1hMcDd0SG1VcW41RDhYK3RlNmZUTnpT?=
 =?utf-8?B?VXE1TnNnMGUwWUY3RXVrTkJ2SFlWM1hLRkEyZUZ0M3FwaXFaUVFQcWsvT3pI?=
 =?utf-8?B?cnJ4cDdJQjhCNmZOQ3BSUEg5YVJ5ZzliTTU4SFRzWVpCMEZwS3Y1ZmhSQ0RH?=
 =?utf-8?B?a0p5c0JQQVZUOERxbmRlenBpRFZKejdtdnozc0lZbEh0WC9heWNBaXgwTjl5?=
 =?utf-8?B?NFloRTdRdTZTYUFEVnhJY0kwWWFTOHJOc2trS2pGY2VOa1lKU1BSM1NoRmt3?=
 =?utf-8?B?VGJxMkI3UG5nQkVZMnJIVzR5dzZHUHp4YXVienNCRXNWeC9LamZwQ3dDdVNP?=
 =?utf-8?B?SmhWWmRjRCs4Q3ZvR2xkQXcvVDAxbXBoajQvdEZOZWlkcGpGRlJPVGU2ckJr?=
 =?utf-8?B?ZWxyL3VCdmpFYWEzajloTmN5MXpjcW82OW8wZVVZWnR3UGtUZFNVQ2ZMS2Iz?=
 =?utf-8?B?TDM4N1c4QXZjZ2dCYkt4OWx5Znp3bE9ETWkwNktwSzF6U3M1blQ0NWVRY0pZ?=
 =?utf-8?B?VVVLR1NmVCs0d0dGUkh0VkxMU2VoZWVSeW8wZnE1VU1PRG1XL1VQamM3Zkoy?=
 =?utf-8?B?YkRQUFVPTFZJaVlteTBkZEhRem1Nd2hlYkVkcHYzYUxPV2pDUzgzc1I0eFhm?=
 =?utf-8?B?U0o2UmNEK2RVZ3Y2bDdqZ0hzU0xneG85cjNSK1Vyc3Z4QkRGdDhsZ0IwcUY0?=
 =?utf-8?B?UWVTZSt1TThseWRMNXZQempneFdmZVRYdjR5WEN3UWd2b0lRZGZ0aC96YW1L?=
 =?utf-8?B?d2ZVTm9hbDk4b3piaUtDeUUwTzE5NDgrWFpaaEF6SVQvZG95N0dZWjI3MXQy?=
 =?utf-8?B?Snp1RGFwZ2pEN2EyWFpDaHg5YkVjMytFTzF2VE1zcGdwWXZ3MnVoSmNDUUt6?=
 =?utf-8?B?MjgrOElWLzJ1U2JGRm9FREpnak9Ydk96L2ZIbEp0K0JoQ2dxZ1VHNFluZkRy?=
 =?utf-8?B?RUNnV0JqTWkwdDhGdU5UNjZ0TjRDWjhuQlFKRkNWSUlic3lIUXdyZ3QwSHRQ?=
 =?utf-8?B?bVc1WTBUdFdJSWRqMkY2d0E4VlNTRksrSG85aW0vSjN2VDBqSzQ2WDFCc3lE?=
 =?utf-8?B?SFZhK3ZjdmlXd1loRTUxQTdLN2RZUHRDMHVlU1JBU0gvMU45UVNsemhFdW03?=
 =?utf-8?B?YkNzWUk1bzFsZXBXVUtwNUhKMXEveGJaK0Z4bXhJTEw5YlZnN0xFZHF2b3Jv?=
 =?utf-8?B?dTJjbnFjU1VDYis1T3Zsdm1jWjMrMzdwc2paVzlwNmptRkFZYm5DVEdLcDF3?=
 =?utf-8?B?Smx0M3g1NGgwWDZ5eHFUS0ZpNWhKRi82WHhQRWNKUjN0WGx5bjZhQnZMcFVo?=
 =?utf-8?B?RXF5TEpGTjg2S0NPSXNjdGZVbmhGWk84N08wS2l5ditweHdiSTVOMlQvQWdu?=
 =?utf-8?B?dC94OUxXeHNxbldvZjlsay9ycUpYaU8wYnNGYkFndHk3MEIyS1ZlMmMrK25i?=
 =?utf-8?B?YjkyL2tnRFJEb1pJOGNIdzVObTNHQkZRQlpTMll3bEpVVk1RTGpseXduRUxl?=
 =?utf-8?B?L1l0NWZVVHRmWXhiTVp4Y1NmVnRDZXlEOW9kRGFhdldpd2xJQVlNUEc3ZXZY?=
 =?utf-8?B?S2piYmZES2JTM0RsUE9mZjB2bEZieTl3dy9lMW5hd0ppTnFmcDNJN3BwdFcx?=
 =?utf-8?B?M3ZCa3dFMjhldERmSGZCS3BsK3h2aHY0WkliS1hkRkdLWStDYWZRYVFFSEVI?=
 =?utf-8?B?aE5xTjEvQ2l5SVg1KytCbHQxMnNFcG1vLzY1V3dqQTMyN3J5Y0ZmcE9XMGda?=
 =?utf-8?B?OEY4NDYrMG9FS3hYTDJLeDM2T3lZeHhPelhQd01IaDVWNk1VTmQvS0UrbVAr?=
 =?utf-8?B?d0t5TTd0eGJUUm5YWlQ4eWlYeFBsRVgrUXc1TVAwUXNiM2NKd2lzcjgweXVY?=
 =?utf-8?Q?urCbowjVJAJzBh5FY5PQ/nvwZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: edcc5b58-0c9a-4ca6-20aa-08dd65ef97db
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2025 07:36:27.6947
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F4NjamplJjKtUnpQg7z0tyMoF/emDzp/VXrdgOTq8DkJeyCilCIWjFuNJS0q8FTY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6186

+Radhey

On 3/18/25 07:21, Mike Looijmans wrote:
> On 18-03-2025 01:12, Thinh Nguyen wrote:
>> On Mon, Mar 17, 2025, Mike Looijmans wrote:
>>> On 14-03-2025 22:14, Thinh Nguyen wrote:
>>>> On Fri, Mar 14, 2025, Mike Looijmans wrote:
>>>>> Set the gpio to "high" on acquisition, instead of acquiring it in low
>>>>> state and then immediately setting it high again. This prevents a
>>>>> short "spike" on the reset signal.
>>>> How does this affect the current programming flow beside preventing a
>>>> spike to the reset signal?
>>> I don't understand your question. What "programming flow" are you referring
>>> to?
>> It's not obvious to me if this is an error in Xilinx documentation, the
>> driver issue, or whether this is found through experiment. Since I don't
>> have the info of this platform, it would help to know where the source
>> of error is so we can document this in the code or change-log.
> 
> It's a bug in the driver, found through code inspection.
> 
> The reset GPIO here is to control the reset signal to an external, usually ULPI 
> PHY, chip. This external chip is not part of the Xilinx hardware.
> 
>>> The reset sequence was just plain wrong, the issue is almost the same as the
>> Do we need a fix tag and add to stable then?
> 
> That would be appropriate I think.
> 
> 
>>
>>> one described in this commit:
>>> e0183b974d30 "net: mdiobus: Prevent spike on MDIO bus reset signal"
>>>
>>> Note that I see this high-low-high-low double reset toggle in many Xilinx
>>> software drivers, they seem to teach that at the Xilinx academy or so.
>>>
>>>
>>>>> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
>>>>> ---
>>>>>
>>>>>    drivers/usb/dwc3/dwc3-xilinx.c | 3 +--
>>>>>    1 file changed, 1 insertion(+), 2 deletions(-)
>>>>>
>>>>> diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
>>>>> index a33a42ba0249..a159a511483b 100644
>>>>> --- a/drivers/usb/dwc3/dwc3-xilinx.c
>>>>> +++ b/drivers/usb/dwc3/dwc3-xilinx.c
>>>>> @@ -207,7 +207,7 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx 
>>>>> *priv_data)
>>>>>    skip_usb3_phy:
>>>>>        /* ulpi reset via gpio-modepin or gpio-framework driver */
>>>>> -    reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
>>>>> +    reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>>>>>        if (IS_ERR(reset_gpio)) {
>>>>>            return dev_err_probe(dev, PTR_ERR(reset_gpio),
>>>>>                         "Failed to request reset GPIO\n");
>>>>> @@ -215,7 +215,6 @@ static int dwc3_xlnx_init_zynqmp(struct dwc3_xlnx 
>>>>> *priv_data)
>>>>>        if (reset_gpio) {
>>>>>            /* Toggle ulpi to reset the phy. */
>>>> Does the comment above still apply?
>>> Now you mention it, the comment never made any sense anyway.
>>>
>> Then can we remove it?
> 
> Removing would be better, yes. I'll make a v2 patch.
> 
> 
>>>>> -        gpiod_set_value_cansleep(reset_gpio, 1);
>>>>>            usleep_range(5000, 10000);
>>>> Do we still need this usleep_range here?
>>> Yes, this is the "reset active" time.
>>>
>> But why do we need 2 calls to usleep_range? From just looking at this
>> here, it appears that the first was intended for the removed
>> gpiod_set_value_cansleep(reset_gpio, 1). If this "reset active" time is
>> needed irrespective of the existent reset_gpio, then shouldn't it be set
>> outside of this if statement?
> 
> It helps to see the whole thing instead of just the patch.
> 
> If I omit error handling and comments then the original code reads:
> 
>          reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
>          if (reset_gpio) {
>                  gpiod_set_value_cansleep(reset_gpio, 1);
>                  usleep_range(5000, 10000);
>                  gpiod_set_value_cansleep(reset_gpio, 0);
>                  usleep_range(5000, 10000);
>          }
> 
> So the gpio is acquired in a LOW state and then, without delay, is set to a high 
> state again. This causes the "spike" I'm mentioning here. The correct procedure 
> is to acquire it in the HIGH state immediately, so the sequence becomes:
> 
>          reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
>          if (reset_gpio) {
>                  usleep_range(5000, 10000);
>                  gpiod_set_value_cansleep(reset_gpio, 0);
>                  usleep_range(5000, 10000);
>          }
> 
> This patch does exactly that.

Please keep Radhey in loop. He will take a look at it from our side.

Thanks,
Michal

