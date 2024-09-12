Return-Path: <linux-kernel+bounces-325963-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE2B1976047
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 07:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5EF1F2320B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 05:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F4D188907;
	Thu, 12 Sep 2024 05:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="u6VhnOZd"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2054.outbound.protection.outlook.com [40.107.117.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18B9846D
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 05:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726118173; cv=fail; b=ANTkt/JOfCoEfxGLkPff+RR/ZJ51ZdBYRBPIbO+bzXLXZRDFVif9kS95G6m1RbpSCqbQMdDZxE4j22gidca1NJCDx5bpHmT8abXrK3aTD3jd2CdDINap2xS0Ju5MyI83Z08KrNMIJrgZTpTqDBDGFoL+Aaotyr5BrhrgVyIbRpc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726118173; c=relaxed/simple;
	bh=NG2ruL8/7mkG+hcRqrQaj/iss233vNo+UVamracYEKQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ahbXSb2Ufp8r2LgZCIDsnUEdt1kKOmqnucJS5j6MCPvjA2YeZ8EO9DGN3t9dt4nEwGU7/qmPBKcZ6+yzRojknWvMsu9Z7++hVl5ADMseGOH0Giu4w7DvjulBPTjANR77wuekCup4tnMiO0Kc1Shzo99fJwMGQZ5wUpCMUADRbUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=u6VhnOZd; arc=fail smtp.client-ip=40.107.117.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tViSS4whZhMx8BACMxZP+YHVWPySZbns4EnYgaSpyNW31kBWm3UbSQFHD7CMhtpl2JKWhbSHEQmmeUaesLPTo9NHx0+hiNc83g+iVEJzRw2QuLNWfPLITzYxHOplNndMMcfIVJv5EN9fRX5REqxc8oqdzKWxbhfZLdkOt5Ku66Z6jzW9jZYN422L6IRdB83sSiCSFWW+ms2DJa/qVWGHmrd0LYSYIB16n+3QqCYe7WPDLTi+INlODpG2W72l51RAtYPSI8br+Mr+xB1y8arwBjrP17jBGabJSmE9Pj9ZIzJG5zHcZj+sKS/LyRO5SjpUVd4WP4b40IbHwwAMPNDOwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b+v2V68K/15FU050IXb5UwMSKK1JZGtmFoZS7JL+r7M=;
 b=RmSoksxUrcasWva0FQ2bVzFu4mFi35QGe4D11cDeJS0nvgvcYEuGCU/fAkgWNERHn4BpBN46HU8JL6/3VmF9DJo8FbunVJIQJ2GCuQO7/Em21X4VlEqC72Aw4PDyi7JaV6ITqymYy5TG+npB5TP5MAD1oWfG6cskheeeigCljNAAEC0quywWtpdvgpU9kfiQPPJPnVV1MJgommbT63PZHHXM/CXQ+SF+/lZFmLQ/XrYiufuiFbJ84/o+d97zyFEzhpFCp5X2a/0CjVzoYa3Crs5juvrhDd6bttdkOVTq6XJ7nHdclgYgTDy1mR/B1Z23T6UKMoB5vN+L25viShoSfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b+v2V68K/15FU050IXb5UwMSKK1JZGtmFoZS7JL+r7M=;
 b=u6VhnOZdYcn49RkvkkkvG4miTQ1iJAhB+WLiumfywLXog4VIvneJ4HqkJzhJn/afffDs6Rs5CbQBwsbINh9iSxVK8jGZs2dPqcxTiKG5IYFC2Ob2chOksa6Uo9zNQpF8RWYDJSUP/Jt/Vgr/pR6pq74a9K8gEfan7i3/fWBmZig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from KL1PR02MB6662.apcprd02.prod.outlook.com (2603:1096:820:105::10)
 by KL1PR02MB7360.apcprd02.prod.outlook.com (2603:1096:820:11e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24; Thu, 12 Sep
 2024 05:16:06 +0000
Received: from KL1PR02MB6662.apcprd02.prod.outlook.com
 ([fe80::6e0b:23b9:808d:ccf5]) by KL1PR02MB6662.apcprd02.prod.outlook.com
 ([fe80::6e0b:23b9:808d:ccf5%5]) with mapi id 15.20.7939.022; Thu, 12 Sep 2024
 05:16:05 +0000
Message-ID: <028d6892-f26f-479a-b27e-544d366d27f1@oppo.com>
Date: Thu, 12 Sep 2024 13:16:07 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] f2fs: introduce get_section_mtime
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
References: <1726022421-58677-1-git-send-email-liuderong@oppo.com>
 <1726022421-58677-3-git-send-email-liuderong@oppo.com>
 <56e4e969-12d3-45c7-bb6a-27207ae4bf4c@kernel.org>
From: liuderong <liuderong@oppo.com>
In-Reply-To: <56e4e969-12d3-45c7-bb6a-27207ae4bf4c@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0037.apcprd02.prod.outlook.com
 (2603:1096:3:18::25) To KL1PR02MB6662.apcprd02.prod.outlook.com
 (2603:1096:820:105::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR02MB6662:EE_|KL1PR02MB7360:EE_
X-MS-Office365-Filtering-Correlation-Id: a857c149-79e7-4b8f-6f4d-08dcd2ea00ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVEwOXphTWowZk01a0RDcVYwenJuMDZqYitJbG5UV0hvbHpnRWNEYUtoRU1R?=
 =?utf-8?B?S2JtRFA5NDlqaHhGRG9SMnJRK0MyRjI1Z3pxMFcyNENhcHdqdDBOanZYUXFH?=
 =?utf-8?B?eTVCQkh5R2p6blNRVzlUYTRLSk1OeHVEL3JWTWVuR0gxZTJ0OE1OOTd6M3hW?=
 =?utf-8?B?UmFXZ09qNUNiMitHbjNtdmxlS0szR3haY0R5RndkeVE1MkNHVHBVOEZMek9W?=
 =?utf-8?B?ZkNoaHN2eUFwRm5tdjc1YThjZDhmbGRuQ1hNM1RwRjVVdnpYOWVPNWxSMkp4?=
 =?utf-8?B?OW9ydDJjM1ZWTGNDYjJVQmREN1hBSndzek8xdVgrUlQzeFRZWWpIUnBjTkpr?=
 =?utf-8?B?c0hhajdpelFBUEgrY3BweXdGZTUyUEwvamFzSjNxVnRqZy9Bc1dvWlVFMXc0?=
 =?utf-8?B?Zk5DWW9iNC9JVEdoVXd3WHZXUCs4TmNtbmNkVVlVaU8rMzdIQy8xcUM1Tzdy?=
 =?utf-8?B?Um9qY1RJSXpMWFNXWG5URnh6dTBHQlUxWURnbStNbVJZQUk1dnBhYWppOFdU?=
 =?utf-8?B?TTlKNVFGNStvV0lld3NyV1VKN3VLQ2E0NG1Oc0pkSjRFbGNLakNtYzV6azFl?=
 =?utf-8?B?dU9ncDN3WGlJK3QxZVpROHNJSzYzK0dNdERmTG9Pb2hpVk5XRXU4K0h6TlRO?=
 =?utf-8?B?d0tQRnRmUmN6R24zbzlvcWJYL2JTbEtoM05UM1pPbnI3cFkvdGhQbWZ3VFYz?=
 =?utf-8?B?UWtEOS9iWnlncDNwSFlUSDZvRXJoVytBVnVXOUxBWXM2YVlUTXkrcXBJak56?=
 =?utf-8?B?ZXh2UXJNZ3MySDVsdDI3TUlHZDVZK2Z6d3FYT0h5TGVtV1lwd3I5amZCSEwx?=
 =?utf-8?B?SmIycktrYzlJQklmcEE3aEUzUWh4Y3Zqb0RQblBxRU0xME5ZL25HSm9vNVVX?=
 =?utf-8?B?RStpcGcyRzIycFZicXNzU2EvTVlaK0RDZWZSZzdqek5MZWNISmtXRGRmbjVs?=
 =?utf-8?B?R014NHZEeHlIMjR6Nmp3RU16eHpjK3JadVdkK01uUmRjN2hLdlMwWloxVllV?=
 =?utf-8?B?b2pacG9XNktabkQ4RnduRDZ5Z0NsWXNhd1BMSGdrTjZ6ci94MFcrSDZpcVUy?=
 =?utf-8?B?SERUM1dzbGh5M251OURzUEUvVkdpWVJDZnQ0bFZRZGgvSzRhWnM1ZEZDQTl4?=
 =?utf-8?B?Y3c4ZUFuZ2hHeHZNdXZackRDMjU0Mmp2eHhlTkhJWVdEbnB5d3o2TXhuYkZn?=
 =?utf-8?B?MEEvZXBXemhBdzBDNE1mejJ2dEszZFNkeUpoUVhuUkc5WjZLQTF1aTk5N2R0?=
 =?utf-8?B?WkNlNUszQTRGajF2dXRaZ3hwbUw1Y3dXbFoxdmRjZGRRTWUwcUloWDVTK2Ji?=
 =?utf-8?B?dEtwaTBlV01tZHRXK2lVR0V5clJjWVdHODRxMEsyd1M1bldnMkx1UmZ2V2NL?=
 =?utf-8?B?MnZGcUhWMEpKSFI3S1lWM0NObHVyWGNmV2s0VVdmSlNUN3piOUgrWXlNU3d5?=
 =?utf-8?B?SkVXVjk1Yzh2eVVJZHZpSkVPWHo5VjdQcmp4ampJZXVxQ3BxNkh2NFErbVRE?=
 =?utf-8?B?YmVpY3h5OExRUkZMbE9OeXVHNkZJZkdlTk1aRHN5YVVCQWNySStCNGFBTWhU?=
 =?utf-8?B?bElnNGZXcDNtNXhTWTVNdWNxSEFjWUZndmtqa1MyNmluZXpQTUpkL1RBVG9J?=
 =?utf-8?B?UnBDamQ2VzVvSmVYSHQzcnhYSFY2Q2lHODlla0VGOGw1YzFOODd5L2RpK21t?=
 =?utf-8?B?cm1iR1FtdDRVbnNDYWZVSDczclVoenRON0VyS3FydWNDM3NLVkdxbFREQ1FN?=
 =?utf-8?B?a0xUQjZoRUE4UXVkMEJLa1dYOE5nN285SUcvMCtsVzlNUDIzRENTQ1JOb2lw?=
 =?utf-8?B?NFV0Yzh1OU9xQ1hjYzlzdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:KL1PR02MB6662.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Vi96TWxXWUtmS3FGZmlKYzJrMXFpVVNuZFYzM0pYemR1dEl4anpKWXoyeTBR?=
 =?utf-8?B?Szg5K3RYRU1HM0hzdkJKcVBucmV1VzJ2OVhqdm5rVlRZRDBjSzV4V3dIeU8y?=
 =?utf-8?B?OXlYMnlpMTNLNVBkV3QxRnlQNWtYSTRMTEE4Zm9MRWk1V2lJa3R5YW51YlhK?=
 =?utf-8?B?VFRxc0ZXNXpZVkMwZTZIS3dPTnJMRGNPdFBFRDhiT0RmSFdoN0NUVitRZzIy?=
 =?utf-8?B?VnNLVUdTMnNWTFVLVE9DRitJeWNOQTVBOFZ2TC9vNktjeU5od2MvMXNRcGlu?=
 =?utf-8?B?c1A5SUw2ckNvbXl3YzJxcnpQQ3pGYlZzaUE4MHRycml6N1hiVzhZY1UrMnRm?=
 =?utf-8?B?Q0xET2R2aFlpQXk2blJBVENUbDIwTnRnOTFpZ1JWSU5Qa3Q5YTFqV0tMbjdP?=
 =?utf-8?B?bDliMGlMWW5VaE02SnFONU1sdGQvVFpObUo2Y3FUZ2pPYS9zdWdvUDZDSlRm?=
 =?utf-8?B?bnRQWjZ3VFRWUmptZ2NiRlZFSDJhZ2I0Tkp1UitneVMzaWc0WmUyMWphbi9y?=
 =?utf-8?B?ZGZzZG0zMzArNVQ0Z2Y5WUJrRHNiQThxZjkyQzZMaGhmZk5GMENna2pjZ1Vu?=
 =?utf-8?B?bU5SRmZBcHNORmJwMmJBRmRWR2tQZmg3OGg2YzhDeHl2MlQ2Q3EwUUoya1lG?=
 =?utf-8?B?RzRjZDYweWpnd1FwQVd0Sm92bFlnWncyZmt2dkNNbnJVdGN2TnQyQW1ncW5l?=
 =?utf-8?B?OXF4aEk3c2plODl6bXZvbUVEVTJLeFo2ajNrMkYyR2MybjVvdDd4cGtaWWIz?=
 =?utf-8?B?b29EOHdnb0JSREVnd3dzZzVoQlFYVlY2bXF6STRidDhKV0ZYdzhYTmowa2hB?=
 =?utf-8?B?NEFQbDNoam96UEFaak9KdWMwTWRMckR5MDBLRFVtaTN6Vm1LNUtiS0FmZ1J0?=
 =?utf-8?B?U2JuMy9oRlRsRUh2OEEzVmpkRUd5bTBHeG5iVTVoY1ZDckNnUG1nYXN3dWVF?=
 =?utf-8?B?MjBrdFZ3U3hQMktQbW1BbENBN0ZLaVRIanR6SHZUYmhkWExrSm1TN1NhUldY?=
 =?utf-8?B?THAxMS9rbFZGeUFlY3ExZ0lHL0R5LzA2ZG9KWHdReFZTNGdMYVRRNXdHNFEz?=
 =?utf-8?B?Mm9wSTEvUmp2UTN2WFZaQ05aRWhzZUt0L0l5TjJBZkhLN0tocUdLamExb2JR?=
 =?utf-8?B?M0Fvb1lrczVqODNhVnd5U3VHRnBJZTBpd2tKWWlPZklOQ1BpMDhFM21VbnE1?=
 =?utf-8?B?dGZHQTJ5VmFxQVpmdkVDOTl5cVlDRkFjcXhydHJXdHBFajhObmhEVDErZFRZ?=
 =?utf-8?B?S1FTNVJXbFRlTTA5KzRVVkVZbCsyNkRibGxnK3Y5cFBvejA3cHVOdkFIU3Fz?=
 =?utf-8?B?NWNHV0JJVFZ3aGs2L2lZZEFRRGpvemhJa1RrdVFIQUtEM0xxSmtMTnVEK1FM?=
 =?utf-8?B?SXdqaUZtZWtoYmVvWnNFUmc1bmtsd2ZRbHFQMElGUStrakY1Zk50bVhFakQ0?=
 =?utf-8?B?V3NhWmtlWmN4N24xbmdnZXVrcXVxWVI3SEk2WWN3eUlVS0UxRkpsMVlFK05V?=
 =?utf-8?B?Zjdwc2FyQW1MVHBDbnZ2eFdjTVpOcXR5SHM3aW5Wcy9jcjBSYjk5K3JtV2My?=
 =?utf-8?B?RXdhRDh6bmYrbU1PZGhKYVhjVnlMSDVtWTBFSEYwbU9CNXJQNzdhTExxdzho?=
 =?utf-8?B?QkZ5Wnd2ekd2Z1M5V3AzNVovdEpHcnJiTGlzZXROVUVNR1pQM0NCcXU2VGhD?=
 =?utf-8?B?TkNUVGVBWHBacExBOS8wMXcrczgwMlZnbzIxcEQ3WktjSEdDKzFRSlFjVFMr?=
 =?utf-8?B?alM3QXFlUjNJcXpGcEU2STNXazB2NlFVelJteUdMSHkwaHhNVGkxNS9CSEhT?=
 =?utf-8?B?aElMOGNmNWgvMXc3Wk5VSVRYZzlYTldNeWRnWXYvV05iQmlyeEtXNG41SEpX?=
 =?utf-8?B?ZGdjTlVodTFFemF0cTcvK2pPSG9nVzVyMzN2d1diUXA3eFBzejF4eUlPdldv?=
 =?utf-8?B?anUyQ0EvemI4VVVMcUhlNHRnaHo1K2grNUR3UXErZXVJNUlFUysvNzFsVWYy?=
 =?utf-8?B?cnBOWm02bFBNWStSOXVtY1Z4Uko1YTQ2TEFFUXJnUTdMcURYbS9IbGRYaHV5?=
 =?utf-8?B?Q1JxZGp1NENpQmtLaWRjRDR1d2NqUmNEMXhkOEVOcmNJeHphVHBzVkZMbU1D?=
 =?utf-8?Q?ntuHwtgvSkXxF7YQOpTOTHkFH?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a857c149-79e7-4b8f-6f4d-08dcd2ea00ca
X-MS-Exchange-CrossTenant-AuthSource: KL1PR02MB6662.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2024 05:16:05.8365
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: er8Az23j7O9Ykvr9UqnH6/i0/2k9bpiRycsWc96oOpZ1x3dWk1VnjkzGLKsWMfIkh9cMEeumCnXMf0OtLmWFMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR02MB7360

On 2024/9/11 18:22, Chao Yu wrote:
> On 2024/9/11 10:40, liuderong@oppo.com wrote:
>> From: liuderong <liuderong@oppo.com>
>>
>> When segs_per_sec is larger than 1, section may contain free segments,
>> mtime should be the mean value of each valid segments,
>> so introduce get_section_mtime to exclude free segments in a section.
>>
>> Signed-off-by: liuderong <liuderong@oppo.com>
>> ---
>>   fs/f2fs/f2fs.h    |  2 ++
>>   fs/f2fs/gc.c      | 15 ++-------------
>>   fs/f2fs/segment.c | 49 
>> ++++++++++++++++++++++++++++++++++++++++++++-----
>>   3 files changed, 48 insertions(+), 18 deletions(-)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 4dcdcdd..d6adf0f 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -3762,6 +3762,8 @@ enum rw_hint f2fs_io_type_to_rw_hint(struct 
>> f2fs_sb_info *sbi,
>>   unsigned int f2fs_usable_segs_in_sec(struct f2fs_sb_info *sbi);
>>   unsigned int f2fs_usable_blks_in_seg(struct f2fs_sb_info *sbi,
>>                          unsigned int segno);
>> +unsigned long long get_section_mtime(struct f2fs_sb_info *sbi,
>> +                       unsigned int segno);
>>
>>   #define DEF_FRAGMENT_SIZE      4
>>   #define MIN_FRAGMENT_SIZE      1
>> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
>> index 6299639..03c6117 100644
>> --- a/fs/f2fs/gc.c
>> +++ b/fs/f2fs/gc.c
>> @@ -332,20 +332,14 @@ static unsigned int check_bg_victims(struct 
>> f2fs_sb_info *sbi)
>>   static unsigned int get_cb_cost(struct f2fs_sb_info *sbi, unsigned 
>> int segno)
>>   {
>>          struct sit_info *sit_i = SIT_I(sbi);
>> -       unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
>> -       unsigned int start = GET_SEG_FROM_SEC(sbi, secno);
>>          unsigned long long mtime = 0;
>>          unsigned int vblocks;
>>          unsigned char age = 0;
>>          unsigned char u;
>> -       unsigned int i;
>>          unsigned int usable_segs_per_sec = 
>> f2fs_usable_segs_in_sec(sbi);
>>
>> -       for (i = 0; i < usable_segs_per_sec; i++)
>> -               mtime += get_seg_entry(sbi, start + i)->mtime;
>> +       mtime = get_section_mtime(sbi, segno);
>>          vblocks = get_valid_blocks(sbi, segno, true);
>> -
>> -       mtime = div_u64(mtime, usable_segs_per_sec);
>>          vblocks = div_u64(vblocks, usable_segs_per_sec);
>>
>>          u = BLKS_TO_SEGS(sbi, vblocks * 100);
>> @@ -485,10 +479,7 @@ static void add_victim_entry(struct f2fs_sb_info 
>> *sbi,
>>                                  struct victim_sel_policy *p, 
>> unsigned int segno)
>>   {
>>          struct sit_info *sit_i = SIT_I(sbi);
>> -       unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
>> -       unsigned int start = GET_SEG_FROM_SEC(sbi, secno);
>>          unsigned long long mtime = 0;
>> -       unsigned int i;
>>
>>          if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
>>                  if (p->gc_mode == GC_AT &&
>> @@ -496,9 +487,7 @@ static void add_victim_entry(struct f2fs_sb_info 
>> *sbi,
>>                          return;
>>          }
>>
>> -       for (i = 0; i < SEGS_PER_SEC(sbi); i++)
>> -               mtime += get_seg_entry(sbi, start + i)->mtime;
>> -       mtime = div_u64(mtime, SEGS_PER_SEC(sbi));
>> +       mtime = get_section_mtime(sbi, segno);
>>
>>          /* Handle if the system time has changed by the user */
>>          if (mtime < sit_i->min_mtime)
>> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
>> index 6627394..b63f35fa 100644
>> --- a/fs/f2fs/segment.c
>> +++ b/fs/f2fs/segment.c
>> @@ -5389,6 +5389,49 @@ unsigned int f2fs_usable_segs_in_sec(struct 
>> f2fs_sb_info *sbi)
>>          return SEGS_PER_SEC(sbi);
>>   }
>>
>> +unsigned long long get_section_mtime(struct f2fs_sb_info *sbi,
>> +       unsigned int segno)
>> +{
>> +       unsigned int usable_segs_per_sec = f2fs_usable_segs_in_sec(sbi);
>> +       unsigned int secno = 0, start = 0;
>> +       struct free_segmap_info *free_i = FREE_I(sbi);
>> +       unsigned int valid_seg_count = 0;
>> +       unsigned long long mtime = 0;
>> +       unsigned int i;
>> +
>> +       if (segno == NULL_SEGNO)
>> +               return 0;
>> +
>> +       secno = GET_SEC_FROM_SEG(sbi, segno);
>> +       start = GET_SEG_FROM_SEC(sbi, secno);
>> +
>> +       for (i = 0; i < usable_segs_per_sec; i++) {
>> +               /* for large section, only check the mtime of valid 
>> segments */
>> +               if (__is_large_section(sbi)) {
>> +                       spin_lock(&free_i->segmap_lock);
>> +                       if (test_bit(start + i, free_i->free_segmap)) {
>> +                               mtime += get_seg_entry(sbi, start + 
>> i)->mtime;
>> +                               valid_seg_count++;
>> +                       }
>> + spin_unlock(&free_i->segmap_lock);
>> +               } else {
>> +                       mtime += get_seg_entry(sbi, start + i)->mtime;
>> +               }
>> +       }
>> +
>> +       if (__is_large_section(sbi)) {
>> +               if (!valid_seg_count)
>> +                       goto out;
>> +               mtime = div_u64(mtime, valid_seg_count);
>> +       } else {
>> +               mtime = div_u64(mtime, usable_segs_per_sec);
>> +       }
>
> What about:
>
> if (!__is_large_section(sbi))
>        return get_seg_entry(sbi, start + i)->mtime;
>
> for (i = 0; i < usable_segs_per_sec; i++) {
>        /* for large section, only check the mtime of valid segments */
>        ...
> }
>
> return div_u64(mtime, usable_segs_per_sec);
>
> Thanks,
>
OK, I will modify the code.

Thanks,

Derong

>> +
>> +out:
>> +       return mtime;
>> +}
>> +
>>   /*
>>    * Update min, max modified time for cost-benefit GC algorithm
>>    */
>> @@ -5402,13 +5445,9 @@ static void init_min_max_mtime(struct 
>> f2fs_sb_info *sbi)
>>          sit_i->min_mtime = ULLONG_MAX;
>>
>>          for (segno = 0; segno < MAIN_SEGS(sbi); segno += 
>> SEGS_PER_SEC(sbi)) {
>> -               unsigned int i;
>>                  unsigned long long mtime = 0;
>>
>> -               for (i = 0; i < SEGS_PER_SEC(sbi); i++)
>> -                       mtime += get_seg_entry(sbi, segno + i)->mtime;
>> -
>> -               mtime = div_u64(mtime, SEGS_PER_SEC(sbi));
>> +               mtime = get_section_mtime(sbi, segno);
>>
>>                  if (sit_i->min_mtime > mtime)
>>                          sit_i->min_mtime = mtime;
>> -- 
>> 2.7.4
>

