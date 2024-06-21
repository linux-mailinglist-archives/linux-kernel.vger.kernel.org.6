Return-Path: <linux-kernel+bounces-223900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB47911A39
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 07:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C938B239B4
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 05:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B653C12CDA5;
	Fri, 21 Jun 2024 05:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="R1kZq2nt"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F239A47
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 05:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718947076; cv=fail; b=Rig3KaIEsPa/1DcMAPGV1+yJKT1711FVPJW6LHgzkbuvLBc9F/NPz2wnt6QCqfKJ4BjVhNZ6YqASPucOK2cmGHhYTnOLwQyHi74C0aPX6zpJGGsu7X8E+nXqGm7M+shij6/5kvsNM5+vuSRY20JoGodojMOdnDNdWCn/aHcMjhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718947076; c=relaxed/simple;
	bh=KFDpOADfrb4SQcPERVUJo3gP7dttIcFW/dfWmDr2fEQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=pgxnXhWjejPU2ueeI+xBi8Jwvv9Mz5WBVKVgYOKuuFXQmZrp3s+rSshdYuQRlB9ncdZRWz++8Jg7gkn+8cLEZPTEHONixR175AHkw1qp0ZPrkLqTA/9QhNeSUCNMrzqvAZs39ZcAflQAdC1FeuxNZbZ8T40aNnQz7VYt2q/aElQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=R1kZq2nt; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HheH8ktdeDnY3cq+MOyL191gNsurfGzrQTXjkN552NV9RVCTFtwEnt2V35ddDlSGDVYTF0S31XpYgtaW4vtcb9utCOZeIz7imWzP50LOIg/fariZCVKbZJ7zk2Kg2mL8g4T73fYaC5tHEvFM6wvxVcScizW3O8gtq/gVuWfZdDw9NAonkMxzSlvgsBXU/n1fAgTXs1viCM632jAFU9fBQx1afPQjzwWwzGY9hiQVOn8LQnFHKwX2PzT/yMD5Py1m/77EusUdMoBgTDIQuJQ20k/0A2NN2lV3sK1J8VWGzd645fN0MpWSuYM41nWoRNeKN7YX+7Tkj+jS6zZpfe+l/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzQKJxdTosBrCZP+AfYUwPPD/stv5EtF0rJC1etWf2M=;
 b=AXiJLngQmnk2iAB4E+cT0O1xaW6+1+TlbpDSJh/7Iiloj1dDNDT1YgoDVtLzbbo2c4Bs4QMi0ODPdW+JGwPAccVONYYUdeoULQuc6DAdNituzXU/TW5XXnCCPD71YadUxgIQKxbqYSXMhdMWsPAeHxP7qtFkRpEFoJJaIi0/pWLaW+BQqCHH/CdMCTp7fuxMITlyT00utaxQY7er+TFGya6IrGfeeIeGFvUS9BNvtVjV6Z+/wZUwjmqZHQQ0lpK53bbUQ7zyu6WX6nHcr/Fb+JC7guV5qDZy2RKQdsP3K/+dW5WCsCh8NF1ZKt35S4ttQLwFlwNDQhvChBEG8pPPUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzQKJxdTosBrCZP+AfYUwPPD/stv5EtF0rJC1etWf2M=;
 b=R1kZq2ntJIUwaRF6bkPAtj5b0e7Th9dAX77DLw12NAvsdJrWybGymGK/6AtFL4UMCxWIiklVgIV6ZV37sj+jQpaAeHIqPe+QBdxuTXO59hYEB2nIhUmM0XLZKpQsJrqEd6wtY4rcCD6gopMd1SrM96g/dFaSB+qnasKfTHGWvCA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB9193.namprd12.prod.outlook.com (2603:10b6:610:195::14)
 by MN0PR12MB6272.namprd12.prod.outlook.com (2603:10b6:208:3c0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.33; Fri, 21 Jun
 2024 05:17:52 +0000
Received: from CH3PR12MB9193.namprd12.prod.outlook.com
 ([fe80::7818:d337:2640:e6c7]) by CH3PR12MB9193.namprd12.prod.outlook.com
 ([fe80::7818:d337:2640:e6c7%3]) with mapi id 15.20.7698.020; Fri, 21 Jun 2024
 05:17:52 +0000
Message-ID: <01c9b471-705c-40f9-bb82-90a6cb651ff7@amd.com>
Date: Fri, 21 Jun 2024 10:47:43 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cdx: remove unused struct 'cdx_mcdi_copy_buffer'
To: linux@treblig.org, nikhil.agarwal@amd.com
Cc: abhijit.gangurde@amd.com, linux-kernel@vger.kernel.org
References: <20240530233436.224461-1-linux@treblig.org>
Content-Language: en-US
From: "Gupta, Nipun" <nipun.gupta@amd.com>
In-Reply-To: <20240530233436.224461-1-linux@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0084.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::18) To CH3PR12MB9193.namprd12.prod.outlook.com
 (2603:10b6:610:195::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB9193:EE_|MN0PR12MB6272:EE_
X-MS-Office365-Filtering-Correlation-Id: cb4edcf0-d381-4b17-17ff-08dc91b17fa0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|1800799021|366013|376011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWZwU04wN0MvM0NCM3NrU1hSLzFrVTZkYVRYLzJwM2xBOFJIWnl2UXFyb2Ji?=
 =?utf-8?B?enZkMVpBMk9jTURpdmUvZzZ2U3BwUXF2ZzFaRFVqdjNQTCtaQ0R6dlhtTEE0?=
 =?utf-8?B?K2xpMmt6V1FlRnZGNEhVQXY5b3pURWp6ekxMcGgwam9VN2MxY0Q4UDFpNXpN?=
 =?utf-8?B?YzhCQ3BqQS9YYmtBQUg2dzRobUNKWHlXb045UGh1TkVCeDE5WXovYnlKV29l?=
 =?utf-8?B?Q1RiV2hMam8rR0pGNUFFZEpPK0lwUG1IR2k0OGM5b0ZuNmN2RWhxRzhSanRY?=
 =?utf-8?B?K25TYkhEVExTNS95RDEvbUtpcVlCS2NaYWdvTVJXZlZHcGZJaGJYd3NGZXpX?=
 =?utf-8?B?dUlhU21rRk9UL0lZZjBEcm1pcWZxQmI3Um1TbHZ2ZllRZ3c5L2FRU3AzdEY5?=
 =?utf-8?B?ZFVrMzQxQVdrSmR6VkNFMjM1cDF4STZ4elQyUzZzbVo1TnRuWHJIc2h2enhi?=
 =?utf-8?B?VkdoSm9QZjJGcW9tSkFIZ0RBR2gyYWluanhFeW42SFg4WEJOQ0M4RWdFMVQv?=
 =?utf-8?B?c3llcDNYbWFjUWJ1eXBGN3hZejA3VSs2SFA4cUMvTHpLS0wvbVpheVlvWldn?=
 =?utf-8?B?MHVBMlpQMG9Cb3N3NGdLNHc5WEJqeUwyV2I2TXBnQXdEcmU4WFcyTmxMTU5h?=
 =?utf-8?B?VHBrcVZsSkkvbENvVVhuWkJYa0hjRTdtU2NKUVlqRWdxdFVBSk8wUzlFQzNV?=
 =?utf-8?B?a280eUh5ZktJTksxOTVDNGlhcTVBUjFnaVRxZHQyYVdKeDZtbm5oNGNPMGMz?=
 =?utf-8?B?SjFwdm1xS1NJU0ZmS3J4MTFGVmcrZEJadG5IUDFGcisweHVZZmU2R0x0K3hk?=
 =?utf-8?B?NXdKQkNVRzByL1RoWFk0YzBhT1ZiajVhbDczNmxtZ0dxZ2N5aUJDSHVYeXRM?=
 =?utf-8?B?MUFidEpaTkxoeGFKdWtZN29SeW83NEw0TmZzV3ZQbmRMazh0eXY3R3FkaUtn?=
 =?utf-8?B?Zk1lVHBjdVRRL1RhQXdYbXhtd0YvRlc0OW9rSlVtckk4RXNtWmg2MEtsT3VM?=
 =?utf-8?B?ZnJ0c0pTZGczVUpVbzFWa0Vva28vd0pRc05IOXRVQmhLM0JsL0Q4MmdjMUdp?=
 =?utf-8?B?Tzl1a3NPWHdrakozV2JJK3pTY3ZiUXNCMmlVMGRJLzhYeXJPQmlFeGE2K3h5?=
 =?utf-8?B?YW5iMW9MNk5zc3h6Qm8zekJGcCttWUtLcVZORGo1VU9NclNMRGxSTUFUdHl4?=
 =?utf-8?B?azgxZlR3cnVydHZsejhsRG8xUmE5MFZ4VG96NGQyRWtlS3d2NENiVkZ6YUdH?=
 =?utf-8?B?YWcyOFk1VVpORjJHWFZNZThqOG1CVnphK1VmblNQWHQ0YzJBRUpZYm5FTUM3?=
 =?utf-8?B?QzRSS2RmVDFDN3NSdDk1bHlKY010RzFkbitjbS9vMlFMUmhwSEszUU5yRFJZ?=
 =?utf-8?B?UWZFZDRGWkUrRmZROENSRUxYSlNpaUVXUDFzaGs2VWxBQVQwOVFpeU14NElz?=
 =?utf-8?B?RkcyUERvRzRhWUlUdlBkc2I2VEtnY0MwN25hTmZYdjh0VnQ2Q1VVcGlTeVhj?=
 =?utf-8?B?aHE0SnhXWUM3bEhRVG1YV0dxeWFURlZuci9sYWsvbUR3cVc5M2xrbkMxMjYv?=
 =?utf-8?B?c0R5dTE2eDQyelE2S1FGRER5QUVOSENpa1NkN3hzWFArT3BxZkJsbGJld3Ex?=
 =?utf-8?B?SGt6UHBNb3V5WlVmUFdMNk9Bc0NxV0dscVJCSkpsdFlOQkRhMXRIelloWi9u?=
 =?utf-8?B?MDA3czZzdE5yZjdCRFZDaE9sWjBEVEtSUGlJclFFUzFzK2pQYndUcExHdS9s?=
 =?utf-8?Q?cJ1U6/yCDvidOKhyH87EjPieQuHAM1zh2zHgw29?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB9193.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(366013)(376011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cngvMU84UTl4UGZVNVN5SFVwaXNRdTUySEJyRDB2bW94Ym1GbGlQWEtSbERC?=
 =?utf-8?B?SjYvSzBTZ0xMZ1RvL0tuWFlKcHZ1VEY2cnMzNzYxRGNzRmRJME1SR3hzOHU0?=
 =?utf-8?B?cVNJM0tuMi83SVJ3Z2FKd2gzNCsvTUJSMEpjN3VjcFd5dVcxR21MMG1CZmdO?=
 =?utf-8?B?SFRxem9GaVF5dnVvZUhndHEvSXUveDUveEpUbTZqa3ZhcExzM2p3N2ZjYmkw?=
 =?utf-8?B?bFFGcVo5SEZGekdaNm1uK2NndytLODljeVNFSGhZS0hVRFc5WjdxdWZjWHFP?=
 =?utf-8?B?cUt4a1ZBZTZGNWpzSHZJUHNQVm4vMGFRUjh2TVQ2Y1lWUy9pb2VIbmc0eHpR?=
 =?utf-8?B?d3dJbmpIbHBhT2dVM2xONnhTS08zZ2ViZWR1VjExS2Qrc1M0UmUwTVFCYUtS?=
 =?utf-8?B?R0lYd242aVlqeTlLMmFpMFZOR2tlY0gyeWFydTR6OGIvY1gwL3NESGhqYnhw?=
 =?utf-8?B?Z2o0ZmxlbS9tb0cybUl4OTZRTEcwRVRTNEJiWFMzRXhVQS9kVzJ6NEJrVXBO?=
 =?utf-8?B?UFdaRVo2WFZ4b1ZQZWxMM2dhWnpoUTk4dDB2c0p0MDNsd0VTWUNMWlg2RDVl?=
 =?utf-8?B?eGpnVW10clhiWk5PeDhNMVB2OHJBUUg4VzRwbUJFMDVyWkx3aTAwbS9RenhQ?=
 =?utf-8?B?VzhnRGNCZFRobW91ZzIxYmo4aUl4MXdKYU9oRjJ3dXBTNm55SUhKMElCSXl6?=
 =?utf-8?B?SlovTVZSL096aUp0empOVTZyZzlzVzFvYnk4cXB6VGthTEJ0cTFWNldRNVp0?=
 =?utf-8?B?SlYvYWdDRVh1QW9obTdra1VXRUMrd1J6Nit1U3hGb1YvV0pEanBzZmkzcGxI?=
 =?utf-8?B?TVhjbXplZ2xyVkVPK3BxVHBWRnN4Y3RTZWh6Wjl2VFFzY1JHbGhvbjJwV1Jq?=
 =?utf-8?B?SEFIUDk3Skl3SDZQb3hia2pNVGljTlRoVzVsNU91WExleUVIQlc1QXdCS2dX?=
 =?utf-8?B?elJUSDIxZ2tYZmQxcEkzUmxibG5pVkE4b1hrZzRqY2dxN3cvTzFzU094MjJJ?=
 =?utf-8?B?NWtmWnVUL1VwK1pGUldrS3FkbEJnM1RKUGhJMXFmRUpSc0dZREZmb3I3TnJu?=
 =?utf-8?B?eGN6ajVLd05VbWIydDVQL1RxM3RQYnZrbDFBUEkxSFE1WDFTcFROWXNNc0lZ?=
 =?utf-8?B?ZUJOdS9sek9OTk5zY2N4dUdhWk1jZ3FTWm8xTlBjTnh4N0prS0t1TGhpdVpK?=
 =?utf-8?B?UmVMd0lFbzVTMm1EQ2tRdnd0RVEyYkZZYW5mODd0UHZCV0I0ZXM5akdZbWE3?=
 =?utf-8?B?dlNOeDc5OFZVaFgwRjE5WmRRNjZXSER5VC9zSzdYU3R1RGRKeXpMVWt3d0xW?=
 =?utf-8?B?ZjNSeHlpY2Y2NHpLczdVMk5seFN3L1hkTjZhNUo1WVpJeUFNN2s5cDZDRXBX?=
 =?utf-8?B?bGZSdUN5SFNrTERIOVRFMDl0b2x4WS9EbHBsMUNVWXZKVjFza0VWQ2RpRzk3?=
 =?utf-8?B?aUcyb0NKZSsxMXJhSlcvc2xaVHBndDI2L21vMWlTa1ZWOG5yN2FxOTl5MUhD?=
 =?utf-8?B?cVU0OWJxUDViNGg1dkNsckQ5dk9xMWhQNnhVWXVDSGdzUXlrbkM1NC9heTNs?=
 =?utf-8?B?Zk42TGRpSkxyNDlJTXNmM2gzVHRNK2xSZWl5Z21LSFBpWlJCb2YrZWp3Mlhz?=
 =?utf-8?B?WVk4aC9aM2tSSzFJWG81dEh5c0hDR0JZVjlqRk9hTzMwV3E4SHRxWTh4SFdU?=
 =?utf-8?B?TlNUQ0diNEtKcFRjZnd4a2FMbHMzdXY3am5IdU9BWnVFNVJJTUJJc01EUTV4?=
 =?utf-8?B?NFVRT2paM0ZEWVRsemxycFdwVXNRQ0ZJU3MzS1lXVzRMRnRvZVZXQk42SVlT?=
 =?utf-8?B?ZkR3L0hHSUxiRmdEY1lHTUM2eWJqbVRsQ2puMkxleFkxZll1M2hvQ1BacUFV?=
 =?utf-8?B?MllWVVlrb0RlYjhTdzFod0ZFZWpxY005dzFiTFFPWUZtQzc3OXlOakFwMWpj?=
 =?utf-8?B?aUhUSS9zMVFUYVNOQ21MZktvL2hJYUdDVTYra1F3SWx3VnFOenZrMVJTK3dB?=
 =?utf-8?B?ckJCdUFXSDJGRklBa2ZZMnBsVnMvalVyMlk0YzBESHVLT2JYR3krYVlJYnJG?=
 =?utf-8?B?RFA2M0dIZGJkZVlRVDJRRFErQXVCUUN3T2hROWp2QmlMVHY4NFpNZkdMYWVw?=
 =?utf-8?Q?8gTi1TvDvYc7uhxFVCsTvNh38?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb4edcf0-d381-4b17-17ff-08dc91b17fa0
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB9193.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 05:17:52.0343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJGnVal8/iV2TKYbhNINLJsKDSj87p03h+ipxHsqFMN/Hy6n2iNbQ6gCRmRronnd
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6272



On 5/31/2024 5:04 AM, linux@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
> 
> 'cdx_mcdi_copy_buffer' has been unused since the original
> commit eb96b740192b ("cdx: add MCDI protocol interface for firmware
> interaction").
> 
> Looking at lkml,  it was used in the V1 posting but was removed
> somewhere before V6.
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Acked-by: Nipun Gupta <nipun.gupta@amd.com>


