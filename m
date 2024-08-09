Return-Path: <linux-kernel+bounces-280442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA0F194CAB7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 08:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82E9D283763
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 06:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC7F316D322;
	Fri,  9 Aug 2024 06:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="aKqe3Y/B"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2042.outbound.protection.outlook.com [40.107.244.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD39B33CD1;
	Fri,  9 Aug 2024 06:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723185547; cv=fail; b=UMQPz/YYSJVnaL2j+pfVcFeVuE3+vKrOlVDHfjonJXyuZi9+Njh9/wOPWqcV+OnCHN4KLPrOwyowIxinoX3nNIb9zPXFTwCTf6c7PAVkcz0zg6jdyoUctsN5b/ro9OjEO5zgFGd5asimMImoHswimj8O/eQuDTf3q0OsNKbr6us=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723185547; c=relaxed/simple;
	bh=lmcxH4+p87sGxGAunoNQE6wV4Mn6dA1E+SkMuF6YRQ0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=VApWWVj9YePdc1WQwz9/yqW9GwRr4+/c7PJChSwJKEUNZXOQ4+5N4+neWkjvjVRmfB40vhFAazidpESHEdBhrJbgUgKXrOnoC/d3wxpyilQdDPr51ntqiF+NqcZvdtofO7o2craxmyC29JrDsn6iLo4aZ4fQ2A//O7ZjIOqSqAA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=aKqe3Y/B; arc=fail smtp.client-ip=40.107.244.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsZv9ax7NAt0zyv+w0MbMSScaRNxiqZy79rGtDBRp5rRBXhVBIaR/4GIvLK/fPen/H9ALNKxZueWiLsuaBI4qlpnrg2qx54ACEsW4KsvRaDOLd02fK4gm7gxGXOFoi6ZjHrxzeccTLksDXAEtL/6V4njUmRwS7+0SNenFxQSGjwqH8S03saoZxj9v7XV5RhpjSw+A04Dc6mZWyGSwtGn9RfhjXB7ATTTg1zDLtKlDDwUlHyRWJz9QZlGd7xhn5Td3HignpU7BpPPYWM0ckSk4ql5LkF43mQL3RrCHzJSE3jLs7beVZfSFZU5V9tcGg2XVjCmKhBNQxGv4Gl9sEyymA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v0dwTV41ykVVBgY4VZ0gQiaBm2yXo10RRqW/9zlVtO0=;
 b=CqzrMyo2fssioygLgPgqLtrN8DaTq03kMYqbNEh5AkS3bbVXk7Y990tui8NVb5XRiM40AWJefZbEjexnlt76+KBn1uNtB+TYb4c71CYSOfW7DVs9xWSIRHxEwWITfGRMSUYVxkoHjCKHKKOE5SwRNm6oWiiLBjOpMvtmCYWr68xMEskkx9f/4m+3J11YFoJhtZ+y0CEyqaQA5hnQU0sExk8s9KhuEbW+rbWOLaOmCnzKBU+9CEVo5cPJA699F1bvyMUdeaf/yVllhZigDN7uFsvfGTC+5pcYdqWT4lAoBgL5zfg3ydykEvkomuU15dNtVvSwkqdwL1kAPktpYrXLbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v0dwTV41ykVVBgY4VZ0gQiaBm2yXo10RRqW/9zlVtO0=;
 b=aKqe3Y/B+iFIQKoWS9siPEhVQ5BOIOhj4XwjrC0KmQ18hx9H/F8y8c2ZQsggCpZRTq/R6qTz16vmipvupIl/rMjy5KO4myOtF/nEDVb7CjnJgREls17lwg+aAqg0zNDMGGzta+usvJmlgfqNYHy/L60dAX5Z/p132krQ8goKWFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com (2603:10b6:a03:4f5::8)
 by CY8PR12MB8066.namprd12.prod.outlook.com (2603:10b6:930:70::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13; Fri, 9 Aug
 2024 06:39:02 +0000
Received: from SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30]) by SJ2PR12MB8109.namprd12.prod.outlook.com
 ([fe80::7f35:efe7:5e82:5e30%5]) with mapi id 15.20.7828.021; Fri, 9 Aug 2024
 06:39:02 +0000
Message-ID: <18da4d46-68f2-4419-ab60-8df09c0cc7f4@amd.com>
Date: Fri, 9 Aug 2024 08:38:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: nvmem: Use soc-nvmem node name instead of
 nvmem
To: Conor Dooley <conor@kernel.org>
Cc: linux-kernel@vger.kernel.org, monstr@monstr.eu, michal.simek@xilinx.com,
 git@xilinx.com, robh@kernel.org,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kalyani Akula <kalyani.akula@amd.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Praveen Teja Kundanala <praveen.teja.kundanala@amd.com>,
 "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
 <devicetree@vger.kernel.org>,
 "moderated list:ARM/ZYNQ ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>
References: <1184b2799ecdeef04128f4bab3db7460fd8edb10.1723114978.git.michal.simek@amd.com>
 <20240808-imply-backroom-b5a9aaf44db8@spud>
Content-Language: en-US
From: Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20240808-imply-backroom-b5a9aaf44db8@spud>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: VI1PR09CA0108.eurprd09.prod.outlook.com
 (2603:10a6:803:78::31) To SJ2PR12MB8109.namprd12.prod.outlook.com
 (2603:10b6:a03:4f5::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8109:EE_|CY8PR12MB8066:EE_
X-MS-Office365-Filtering-Correlation-Id: a5abceb5-1ec6-4448-0d9f-08dcb83df4ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ajlWemxEUlQwZHVVZVdTT2RMdXM4Q04yb0txOGkxQnJNRU9wQk50bElUQW1O?=
 =?utf-8?B?REpNUFpDS2dLVGV6NGhSMmRtUENXZkdOSEtJSGcwbktsOXlKU2RsOTlYekFL?=
 =?utf-8?B?NW1SM1NnNGM1TEwwQzE0MityVUFoaFRSNlNDZExNT053WUxVUUd2WllwTmQ0?=
 =?utf-8?B?R1hYaGExUTZSOUZiTzBHU3F2NytVQjBQUEV3ZlVaKzZDcEI2U3FMN3doOTN4?=
 =?utf-8?B?dUFhQ0FaMW9SSG1nRnhOdzdhSTlESW50K1p1S21PMEttdHo3K0RkT3dES1BY?=
 =?utf-8?B?UjBRMHdMWXB6SUZBaTNnd1ZNL0h0ekU2cnVWNkFlTWpUanc1aHVuK3hDVHZq?=
 =?utf-8?B?bGtUYko0SXVyUHExUm50Y1ZHa212b1NjR25KVmJYVnMvZ3N6M0FpSzdSZVFj?=
 =?utf-8?B?d0RBNUNhV2prak04ZytZMHNVTnd2RXZnaTdwQzNNMXBxSWs2bDVqUGpZNVVk?=
 =?utf-8?B?aCtEczlEc2g3Mk5oNUM1dnNvcDJMV1RqNkhnZ01jc0xWRmpkSko2RllHa1hh?=
 =?utf-8?B?bnZJT0ZNZ2FXSS9HZTVrQUNsSHRwcFRmQXB1U3NRMEFMSXdlTXBGQWFVNDF0?=
 =?utf-8?B?Ky90OTJrVTBodjMyQ3ZWYVR4aCs2SWtuUWxPSjR0Qk15OUphbEtxeEszRHI3?=
 =?utf-8?B?Wkc1eDRNQ1g4eVBJZkZ6MGt2Z0U2bVh4TURPT1o1VHkwQWRhVWtYMUZIYXF0?=
 =?utf-8?B?emkvc3loTkJaa2JKTWpyZGJ1b1RXbnd5VEhLVjdTOUlad1ZPZjl6czdFaHA2?=
 =?utf-8?B?VGZyc3RmaEJOTEdzMTdMem9tZ1cyL2NoRnNMRk9LcCt0UUM4Y2pUekI3YWtF?=
 =?utf-8?B?YzhqQUFML0xIai8xZTNYd2R1cWFJYVhRMGtYYzR4WG5TWDBpaEhGZWpnMHBN?=
 =?utf-8?B?TnNsbnBZZ0RTM0R2dFBmVEtlOENnaS9OMnY5SW5RVmpGU05pSzNOTDh3S0x5?=
 =?utf-8?B?TE9FVU5COFhHcmZucEN3eWxxMk5sZXBpNEVOWmR1L2w0K24zTkV1REhleFFM?=
 =?utf-8?B?VXBMV1NLYmZsamFOenEvb3d2eGhlV3Bkd01Xckxndi9BOElLQzk4ZW5qUU9T?=
 =?utf-8?B?cnlFeFh2bkFub2YxbWhQUk94QWhteGtoalYycTZYMzNKMTR1bHM1S3VaM2NZ?=
 =?utf-8?B?anB6WHhIakllR3VibHo2dEtDN2FXR2xmYmRyR0Zzci9wRmordW00UGIxRWVC?=
 =?utf-8?B?WDlOdkdUREFRVmlMZmh0YUovaEJTTHlaeTY5TVE5UG1XMmREQWZEWmV4SkUy?=
 =?utf-8?B?WEc3WFVlTTdnZGREVlpybXM2VXRwWUplMnlGUGUwU0pOdGFLNWlUYUdqd2hE?=
 =?utf-8?B?MUJnRElHa21nQWxTQzVjZTNMa3JVdGcweU5pQmtndHNrNUttQjFLVlZpSmlP?=
 =?utf-8?B?L2ZybG54d3VNOFJ2OTdvcUZMVUFXcDJGS2htUWdudUp3YXVGdk51SllsWnpH?=
 =?utf-8?B?aklWUXFKNmRlL1dGSGZoSFRHSFlna2c0bUNkbmpwQlk2ZGdTREhBSzBmS3FW?=
 =?utf-8?B?azQ4U3NMdlhtSkNMQ2JGb3RGTTJBZGZWYzRSL1g0a0F5TkJxbllFYmphNnFz?=
 =?utf-8?B?RzhsL3FUQWhEZ1JMazhSUVNCRHlseThRYWZQellMdm5vR2JwdDh2NnlqTFQ5?=
 =?utf-8?B?Q2JtUDFHa2gzSjZBVWhhQWZrUTFVNXdWMnhjYmhFaG45UGJlUUJ4NGNlVnRh?=
 =?utf-8?B?d0pnaXpNUThRZXVZeTA2a1ZJUUdLSk5Nb0JJQnBRMUVaR1hpSWZxcTM1dTR4?=
 =?utf-8?Q?3bQ0CUCBHvX8xfnCiiT0zrmqU5wFD3L0AW57u9Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8109.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZFpMbnR6N2U0aER5S1lIVHl6Y3ljTmZxYnJQb3diZXNhZ0lPV2QzVFQrOU8y?=
 =?utf-8?B?N04zYXI3NFlxMldEUmtqa1VidlJVMUxzcXdrcnQ2bVhHV2hYdDlFQkVVajBv?=
 =?utf-8?B?MEZEUjZXdFBaTE5QNFZKU00vOGV6bS9iVVNmYXRXU1RrU2V4ck1iQXpUbWJS?=
 =?utf-8?B?MjR6OGVoWm9MdzFlc2VUUm5IS1NKeVZna1BGaW1rVXZ2dTVKbklzQVBFQm8r?=
 =?utf-8?B?dXQ5ODAyZWhaUEQ4R2pZYTVPMHBHZEcrUExyMVhOVkdxWFcyT2FPTHZsbWdO?=
 =?utf-8?B?dkxqMVVIc0o0clE2UVFYYjlFUVVOUkc1dWx4cCtIOGdsdmVNYTkrMXFmYzQ4?=
 =?utf-8?B?TUdHcStKQm5UWERlVUxwZE9INXI5bmRJTnBONmsrVXZyWnQ5S2w4MmxRSCtj?=
 =?utf-8?B?anhTT0pXY2o5aHdML3BTYlBMcDFlek5FaEN5enBXM09oMk5iSytDNGtYN1NB?=
 =?utf-8?B?cjdIRkNMVDFMUnVoZmtZTEYxeEorcW1kYUlZM1c0bldUdS9hbzVoTVNxempu?=
 =?utf-8?B?QlFzaUJSeWloUUROVm1PMEpQOFhtVDI0MmtWczE4Sy9JbFNtbGcvaTF5T1hO?=
 =?utf-8?B?a0tZcHZoSVhwZ2ZKT0J3VDhXdHpyOXRyOEZhYlZpV2JJUzlQNmovTHY1bDgw?=
 =?utf-8?B?cnVrM3hDc0kvTHp5RnZCdVhuQUdWNi93REI5WWZKRjA4d2Z6YjZodU1POStW?=
 =?utf-8?B?ZUpKRStNQlJMTzlHamIwM1NaSFpZNVVMUVJPckNIeGxvRFNhN0srdGJhS05U?=
 =?utf-8?B?OWc4V0tkRm1LeTZ6dXFzNVhNOC9EZitMMGoza3Y3SGx5SDA5MWZWdTcybCtp?=
 =?utf-8?B?OTZXeFFzR042Q3ZmeC96WGFJL1FsYmpIdXlOMmFjWTlOblg1YVVsZEFxdGdX?=
 =?utf-8?B?NVRMSExVM05wL25NZUNnN2krTEhMbHRnZDVFQjZsQTdGZ3B3SWJxdkJvendN?=
 =?utf-8?B?aXpmTE0wb3d2THdtRFp0U3NsUTVWcDl2TlpiUXYyMldMWm44azdUUzM2UWQy?=
 =?utf-8?B?QTNHR0dJWUlVNU8yaVZ6d0V0K0pjWGdYM2FXZzhUYndCYXdYOWhkbC8va0NQ?=
 =?utf-8?B?NXdMRTlJR0FHN2VkNUMxQm50S0tYUHM2UjY0Sk1ER0N4NGFTYVg3OFVOQjFI?=
 =?utf-8?B?NTN4S3RLT2NDa0E4SGdSUmMrLzZxdmtCeDdrSmFJTFpPRklSTEd5TmQ1UnNV?=
 =?utf-8?B?dlRhd3c3TTRvYkJxMU5NQWZjUDFHZGNmaFROZXhBZjZ1eEFtWEwwM3dxZW92?=
 =?utf-8?B?RW9oemU0MSs1WmJzSUd1MDFPMFdSVXNPd2Q4RWFLWFUwczdQd2FCZmZPVnEz?=
 =?utf-8?B?cHJpMWx5OUFPTkJ6aWRFZGc4MUJGWGxqQmp1TGYvRkdneC9HOTBPaExUNVdz?=
 =?utf-8?B?amVHaDlxYk5LbFY2VWFydU9WV0hyWkpUQk15QktBT0VCZHE4ejJ3U3o4VFJ4?=
 =?utf-8?B?Skt2V3FkQy9KWmVqY3lsWGFEMWRwTEVoWTR2dy8xdHphNmxqSUE2aUtwekty?=
 =?utf-8?B?TFdHNVZ5Zlh1czhDSG0rWnd4MG1Odm5DMjZCYUFFZXVHNEFjYzBwUWhoVEV2?=
 =?utf-8?B?QkRVdmRIKzRpV3lTZUpIc3VPWDR5V3VqVnlvQXlueUo2TW5ZajdOM1NVUit5?=
 =?utf-8?B?U3NnSTFIS1d1KzNzMFlwY0Z0dFBraGJLbEZwbkwyVk5LUlJtYnlaMjBINTdr?=
 =?utf-8?B?anJUa2ZYeVMzclJhVnhtU1lua3hkMHk4SDB0cEp5RC83MTlSTnQ1NjB2VHc0?=
 =?utf-8?B?MmFVMVZQZTV0RDN2Wkl4NitNOUE2eitpODdkQUZGNTVSNTBtVm9KSXl2M3Zj?=
 =?utf-8?B?a3lGWU1ZcFpNMFNyemNLbXRrQWh6MHllYlFOT25mVEFha1paMXJuZFlSWmhm?=
 =?utf-8?B?Nm9OeHVDSDg0dDcvOU5RZDBkdnFGaGZ1eEt5SGphOEZaM1NRMUtGOEVZTWFi?=
 =?utf-8?B?cDl5V0NVUG9JMUc1OEcvbkRnbHVwemJrS1NheEY5Ui9YNHY1ak9HNFJBWWV6?=
 =?utf-8?B?dXFOUXdoZFVwRDFaUEhpblVTRlBmMGlmMjQ4MEJpNkZwVlVNR1gwbk9DL2to?=
 =?utf-8?B?MFpIbXRQRWFoejlLZlVLdnI0UW5raXAwUDBzV0w3RXM2LzJYNk9BdEJqeVVU?=
 =?utf-8?Q?vbjf9qb92JDH3r6TCycLWeb7W?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5abceb5-1ec6-4448-0d9f-08dcb83df4ba
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8109.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2024 06:39:02.0554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TyKOl8QRQw4p5J3badKXMJREjI5saig/S2MBOBuIso7jnKEP40vN4MEoTkZ4I8CB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8066



On 8/8/24 17:51, Conor Dooley wrote:
> On Thu, Aug 08, 2024 at 01:02:59PM +0200, Michal Simek wrote:
>> Based on commit d8764d347bd7 ("dt-bindings: firmware: xilinx: Describe
>> soc-nvmem subnode") soc-nvmem should be used instead of simple nvmem that's
>> why also update example to have it described correctly everywhere.
>>
>> Fixes: c7f99cd8fb6b ("dt-bindings: nvmem: Convert xlnx,zynqmp-nvmem.txt to yaml")
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> Acked-by: Rob Herring (Arm) <robh@kernel.org>
>> ---
>>
>> Changes in v2:
>> - Fix sha1 in Fixes tag - reported by Stephen
>>
>> Adding comments from origin version
>> https://lore.kernel.org/r/42c21f3bcd75f821061d047730dbbcd40233e256.1716800023.git.michal.simek@amd.com
>>
>> Rob:
>>   This doesn't seem like an improvement. Is there another nvmem node at
>>   this level? I would fix the binding instead if not.
>>
>> Michal:
>> That name came from discussion with Conor.
> 
> Did it? I don't recall that, only discussion about adding a "real"
> example to the binding and noting a typo in the commit message.

Definitely you ack it and description was saying the reason for soc-nvmem name
https://lore.kernel.org/all/20240131-portal-glazing-16fa36efb3cb@spud/

And I found and sorry it wasn't you. It was Krzysztof over IRC who suggested it.
I can c&p paste our discussion if he agrees.

Thanks,
Michal




