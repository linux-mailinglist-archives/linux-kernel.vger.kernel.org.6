Return-Path: <linux-kernel+bounces-199693-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B82928D8AEF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 22:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F59B280DCF
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 20:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E24813B588;
	Mon,  3 Jun 2024 20:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="poBqRGcg"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2138.outbound.protection.outlook.com [40.107.101.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD23720ED
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 20:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717446890; cv=fail; b=RoPScRnjwDkfXOvwUhgVug55IoyQBWBeAfxthGaCNWYbw4/oyPs2WXBcbRiRIpDSMWplBl0T8En8K1+VmhSQiPL5y7Ms7TqDt5pV9iIqLubJpfz0a7rzUT5cYLq0twcqVeZEFMTD3lBkvnngRtwjyeFPmT5Dpr02vpp1k2m11tI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717446890; c=relaxed/simple;
	bh=fF9NKl8oWG3ex4lVft7G6X031gXMyuNPNAYSj0JNvDk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gOcJss3fLvfbeucoyERR881AauGNa6qWjhuOeNxa3LgrFoJXbb8CzMwJ7s7B/9H6JB5g907UsXzjyesPBzBHfbIBq4jcuG1VkivPn/O4EF/Sg+KJbASr0lyjYI0QC41pfA4P9vdBng0M+5fi3x+2kuYI3Lhugq0dZUSH2iw0yy8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=poBqRGcg; arc=fail smtp.client-ip=40.107.101.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CxhfnZXC8GBGqJsiSl2d9YAcnN1O15AfakFeNep4e6wPk74sfoOOkT1BgZq1MoWA074JLIj/T5omA6coz7AcOfF+4/eACRAReyQdEUtRVjx+JOh5lhhn/ZgNHUXFqoILifxetxN/bvSWrBEfwzaJ9I80d9E+PlM+//EYDVtjlkM9Ad/45pULeoiSDkKJkGoHwYpAC1/MNGFnggLiZ978cUn9BQebrA6fr+UHguk4ib1ABgzP4uhAjG5opRWca+uKw0+Ha8vxX8YNovEL725hdanB9pg6jaw+wymL0vfWg3l8A3i4P42egByVfWCGM3CeYPGvs4n90mwtozdHH9Zljw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJyWY+PLOrAlVxzPnLXqpn7rn3Jx/Uv4Nsc8leJ8u8g=;
 b=SgBUISlaXgimyUj3AB7pA+qs49L2eYQVyBBvmEZyle9GZflCUCV9hoUYw2/mOIidGWZyhXkNXQT3+3XKvFjiW/m8Owyr0dtVcJHPNe7oTzb+lf4OOXzQjbMyPrcPTsiMkFjNhe1n/fCipVOVLRB/HaJ7moyaIU+6jmGLiiRB9q4uCeSFiezD7bdVlJdzkccCh1HUJV210QSrihS7yUza6M4EP0hTrgKKKJotRIIEuISs8Jm7a5m2T96MOYkvHUbEEC4W0V+n85ItXQiJqAAXkGQWetKYqxzDIqd3R/yEYtuwKd6tLz+CFd93bExMvbHPTH+a6JJ6y4UzaUdflgMvtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJyWY+PLOrAlVxzPnLXqpn7rn3Jx/Uv4Nsc8leJ8u8g=;
 b=poBqRGcgVGnGH8RJRg46VmDSaqEk2vd3XmxR20YwfphW978L23IgND7y6gO+OwSkRp9Fn8mXxlaFdBqFF70vRjughZXIA+R48d4lxy3QZEQ2ZucVt/U6BifRUcgwf6FbRKIxByMXBAh6dvDxxZrOiIArW+3SysAo/T3F1SVTh5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 SN4PR01MB7504.prod.exchangelabs.com (2603:10b6:806:207::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.25; Mon, 3 Jun 2024 20:34:45 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%6]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 20:34:45 +0000
Message-ID: <0c89a5e6-ab77-4028-9779-d8db77525b0c@os.amperecomputing.com>
Date: Mon, 3 Jun 2024 13:34:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v2 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Christoph Lameter (Ampere)" <cl@linux.com>, will@kernel.org,
 anshuman.khandual@arm.com, scott@os.amperecomputing.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240520165636.802268-1-yang@os.amperecomputing.com>
 <Zk93vBqAD3LgmbGb@arm.com> <640f8606-2757-4e82-721f-9625d48ded65@gentwo.org>
 <Zk-SNVyEHT1UsxqD@arm.com> <ad87bb77-a9a5-2c0d-b4b2-13db09615d7c@linux.com>
 <Zk-2a7s2pvkVsm2C@arm.com>
 <d18611c7-9108-46f7-a5a5-6c8e0069de9b@os.amperecomputing.com>
 <Zl3qCajhEbC9pNAm@arm.com>
Content-Language: en-US
From: Yang Shi <yang@os.amperecomputing.com>
In-Reply-To: <Zl3qCajhEbC9pNAm@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR07CA0036.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::49) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|SN4PR01MB7504:EE_
X-MS-Office365-Filtering-Correlation-Id: 095912bd-4fb4-4616-4a3b-08dc840c9ad6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bldXRWtyYWZqaEtzZmw3RlhkOHN0N28wTjQvN3ljVnRxblhhZTR2R0VHcUwx?=
 =?utf-8?B?NE5jaGNNUEU4NkZ2ZGxhbHZiTFRaWnJ0YktHeUJ1cVYzR3ZSajdMN2Z6cnFt?=
 =?utf-8?B?czhSSU9wMkFPR3Vzby9WK0lsNjNKMjQ5WFk1dUlYYUdwc05KR0ZYY3Rvd3Bq?=
 =?utf-8?B?Z0NZWWVJY3Vkd3lxQkVndS9jcWN1ekx2V29pZWc3ZWRwYnd1UTgrNlg3OE1l?=
 =?utf-8?B?bjhyU3IwQitCUURIOHlQaDlvczVEWnc4UFEyaXpTeDM0anFXeXY1NmZueWs5?=
 =?utf-8?B?eTRlei9WVS9JTnJSeW5PeUlYMW1USzhZUU8vVmV6YWhpK2N6czV5b3QrNGxj?=
 =?utf-8?B?SkJZZWFCak11NzNJR3lGQUVxMUY4YnFpTFp4aHFsZ1ZHM3NDRS9OVFNhUXEy?=
 =?utf-8?B?ZCtJRkdmV1EwSUgxRnVjU2FhSEloWmwzc2ZKU0VQNU9lcXdnUlBYWjM5TnBU?=
 =?utf-8?B?Rjl0UVVSenRVNzkvTVU4ZHMyekkyTTJhSHZLWDdacGZTdWZWSk9SdjRqcXJh?=
 =?utf-8?B?SEhoMTNwMDh2U0VWdENYcXlMeWc2UWYvVkVoMkIvOTU4SmRWUjBNV2cvL2Z6?=
 =?utf-8?B?ZVZlZnpLT1h2dlFSN2FpbW5NNFNJTDR0UmZJS0ZIZ09jSFdMdmt5aU0ydzlq?=
 =?utf-8?B?MzJJTWFjK25xUjRiTU13d3UyUEtPMHNWYjJtNzlPalNIM2I2cEJweElOQzRF?=
 =?utf-8?B?dVZSdlhEWG5SSys5dnF2dUx6QkZpRHowRno4L09oRnRJQjUrMHNsMktkWVJa?=
 =?utf-8?B?N2luZHFzSEppMk50M1Frait5b3lYbFFXbURlMStWTlliN1hpQUo2c2ZJTnZt?=
 =?utf-8?B?eVlCb2dqSTd3M2tTOHFhc3cxWHR6b1lHeEpseTM0d21mT2hpZmwvdDdPT1VH?=
 =?utf-8?B?emxVZ05ZZ0M2K2ZNb0I2THJ1a3dHczRZZGtTT3ZUUTA2MGNHRFo3U2tLYTk1?=
 =?utf-8?B?bjBaNGtibWEzSjRubkFPZm1CRHBweXVPL0VxUUc1ZnZGSFZ1YUMvSTdnM2lu?=
 =?utf-8?B?Y0d1RlNjek9ueWlXa2o5MkpldlViRklNS2x6WUFIWVF5c2VPNDlCZTVtRDVZ?=
 =?utf-8?B?L25SZkpidUx1SlNKMDI0dEVVUDE5OFJSOVBOem9hY3Fabnh6V0sza3RkVUVv?=
 =?utf-8?B?aUpselNjTGRadlZtdVZ6ZkhiYWRIa25sRmxqS0dDODVTa1BuUlRPb0RvTDZO?=
 =?utf-8?B?UWpGeGhyMEhOTFpwQnd4cmtLM1hMSzJoRCtnaFdEaUV0VTFxRmFTSVlSUWlN?=
 =?utf-8?B?anJVRnZMd3YrWEhtWWZpTkZOY2FhZkJCYSszTEh3YTFxbDVTTDFaWkk3di8z?=
 =?utf-8?B?OHJLUDJmTGs5MWwydmxOTkRDbEpocGNKMUFUYmc0QzBLRW9TUXd4TTRLUlNr?=
 =?utf-8?B?Y3d4OVNtNHNVVDBnTXRISDZtaEkrc2dpalR3N0NnOUR4VnZZNU5RRlQrRTBl?=
 =?utf-8?B?Q3JLTEZXeVVaSkV4MkwwTEZ0anVYVEszL0N3ejdpRTUrKzNSWjEzVlhsQlds?=
 =?utf-8?B?WCt4OFk2RlpLTjlGVHY3NTJJQlB3Ti8zUjNpc1o1THFWR2ZuY2lZL2lpNjU0?=
 =?utf-8?B?OXkyVnorbjFySTRoVHhDNFpxNHJLVDBQV09xY2kyeDdFUjVJbEZkTHRwUFFz?=
 =?utf-8?B?eUp2cXUzaW5pR1R3QmpuVGRpVlJDOE5KUEs0aVBmMW93dm5tTmFRbTRJUFp3?=
 =?utf-8?B?UDRwenRDRnN4cjBaRHlNM2hCNDhjMjJEUk5qdHFVRG4yU04zM0FOVlBnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bm1aMHlSREw4OERIVThWcjlKUGtmK0xJQ094SXhOTWw4YWEzem9GWkNwOWQw?=
 =?utf-8?B?dmF1RTFhb0RUWVBHM3VYSG9QNjYwVXlabHFFalp0TWYwOGt2NWlSc2F0S05Q?=
 =?utf-8?B?L0tuMXhFRy8xd3hNblZHR0xaYmdHYUs5S1M2dDl1ek92eStoSm0vaFNsMEw4?=
 =?utf-8?B?aUhsL1JhT0t4cHVkbEp0dFJJTStoWndYR1BxanM3dFpmTnN3ODFacmFzUTVS?=
 =?utf-8?B?TEtEWjk3Ym9pT1EvZnhDOGIzUEl1N05WMHhsK0xTNkE0dlZZendNbk0xQzlL?=
 =?utf-8?B?V3phdFBQd3B0UllNL0ppK3lTQVJpVFgzZWRZQ2VHUEpLRDZPN1JZOWdoVTNa?=
 =?utf-8?B?ODBsWDRxWU9XZE82REhpaDRXcFlhYlp2RkgzbFNiRllCS0JuUXRJaENLczI4?=
 =?utf-8?B?Q1ExSlFZLytwT3BrUFV1Ny9YZ2RaQ1dtdThYZCs2WUxtVVJoSENBeENqQkc4?=
 =?utf-8?B?dlJ5eGQ2UWJuTVFDbW00Qnc1TG5YMytIR0FWSG40dXJGaVlVOXNyS29sUzdh?=
 =?utf-8?B?VThPb2R1L3hSMlI3a1gxNk05bzJocWFZdkdYUzViWGVyMExkZXVHbjd0VnJU?=
 =?utf-8?B?NmhXdTJHZXVGNEI2U0xFMHRvYlBBc0U1ZVkzS3NvN3NJK3g3SmxyYngydCs4?=
 =?utf-8?B?QWY2OUZPdUZHWG9pTHdvZWJFalBwVVgrajJSRjEzYXRMVlI2dFBxZUxmZkZT?=
 =?utf-8?B?RVBYQUVhMDVIWnpMQUNzMlFVNm1IUCtzN3dhdWMvYmJDb2QweGR5SDJBQ3p1?=
 =?utf-8?B?UkMyM29QNWxNd1BYcFI0TzNpWFJ5N00rb1p0UWtqTkFSQzBJVGVrNjVHTkdN?=
 =?utf-8?B?OURkbk05OGQwd3NwZ05pUnhTUjQwVjUvbmlBVXNzWWNGNzJvQ3JTVTc0TSt0?=
 =?utf-8?B?L01WSDdzbTg2Qk1Ob09tTXVaQXVhTlRXQmUybWRWVkhhbGVWM3RlMk9PL3BO?=
 =?utf-8?B?cDgrMDViUDczVW9tVmV2VFR5NmdtZkhMdmtmOHlkZUpta3dpYk9sUTVBcmhM?=
 =?utf-8?B?KzErOXUrLzFRY0JIUW95WWViOGRpODZGcU81SjdaTUQ4NExYSnU2TDJRUnlR?=
 =?utf-8?B?bjNBbWovVFhiekp5T08yTVFiSWZlNE5IMWw0Zkh0NjQ4WWpiU25qbi9MOHAw?=
 =?utf-8?B?UVBKeHAwQ1JOVzZqaFlneVJzUi9YRUk2VXlxb0FNb1BuRFRKODRHNEZMNkw1?=
 =?utf-8?B?YWc0cENjc3VKa0pEWDV0VStjb3p3RmY5dTRaTkpzSXl3bEJNVDVjVHpTWElm?=
 =?utf-8?B?b1FKc2dwMytSdktGd2NSMFlRYTIzK0k4aGJsRUp0QVNaTDRlSWpJdjk1MWF0?=
 =?utf-8?B?TStXSm5rYVcyallIdnpOckpqZkFkV2hUTGRCazBINW94R0tHaEEwRmRrYnEz?=
 =?utf-8?B?ejVWL2VBSVFSK0JGNDlGTUJJRjdMSFZ4Q3VMNmZzbFEyMGRyRTNRS09zeHFw?=
 =?utf-8?B?allXZFhPcXRqNENVczFDUzgxdFpodDJyRnNuZUxBNFA1ZVVTbVd4QlRmVk9F?=
 =?utf-8?B?cUtkWXluV1R3RzhmbVViK2w4VWZOS1VoNlYvZ3FEMnMyZGw3NWx4RU5NTjhS?=
 =?utf-8?B?MkJzUnVkRjUxbVRKODlFU1hMZWlCVjFzNWlSdURRWldrVktCckhFSmpEMm9L?=
 =?utf-8?B?VWZ1Zmc3L0FCdjVQVmZlTThDMzJLRnY3UlJJQ1o1YlRnV2pwRk1haXZoOVZj?=
 =?utf-8?B?dHF3ZlVGTDJONFhjdndQbXpqQ2NjSCt2MVNHZExrWG1SdHNBVEFFeWdEOUh0?=
 =?utf-8?B?eDF5Qmx5V1NISmRXSUdqREgrenVPNEhEUFVJVEVKZTlJU3R6ZHhDRjAzOTdr?=
 =?utf-8?B?aVMzQ0JwL1BrbjNlZmZNdlM3M2ZEM0s0bTVvOU9Gc0owajQ1TXNPQ2RML0Ji?=
 =?utf-8?B?WUxnZDV1N1ZPQS9QbU15eTVSMEdaYWxFN2dFK3paUFA0RmZkdmZXMWl4U2c3?=
 =?utf-8?B?ZWRHK3VGL3RMS29uUWUyZkJueTRNenFBUUJjYlkvcnhMTmU5Sk1vbDRUSmVk?=
 =?utf-8?B?RWFJSXBPV2hDdVJyUUdTNEtaYWYzMnJqTWNrTzM5R3E1TjVuaGFQSmZIZUpx?=
 =?utf-8?B?VVdPekRaR1ZQUHVPUktJZThyMXFhL1lhNVhrUllya0N5VXNEWnBBaGlUcG1h?=
 =?utf-8?B?Z3VOazc0MnpkaDJpd1p1M3NINjRQem4xWGU5a1J1SDFrUjFKSndXYkNCMW10?=
 =?utf-8?Q?4oX40T3v1n+O4VTKfXvtprA=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095912bd-4fb4-4616-4a3b-08dc840c9ad6
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 20:34:45.4485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wwJY1gR6QwhZHPn7efYC0IjtGtkw+iOYd/hK0xAWWVI4T7eUMgwJPZI3UcG/WZdPkoLLOwlt7ymt5FYDtzTvag7No6EddksjZ2QarpNTQuc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR01MB7504



On 6/3/24 9:06 AM, Catalin Marinas wrote:
> On Thu, May 23, 2024 at 03:13:23PM -0700, Yang Shi wrote:
>> On 5/23/24 2:34 PM, Catalin Marinas wrote:
>>> On Thu, May 23, 2024 at 12:43:34PM -0700, Christoph Lameter (Ampere) wrote:
>>>> On Thu, 23 May 2024, Catalin Marinas wrote:
>>>>>>> While this class includes all atomics that currently require write
>>>>>>> permission, there's some unallocated space in this range and we don't
>>>>>>> know what future architecture versions may introduce. Unfortunately we
>>>>>>> need to check each individual atomic op in this class (not sure what the
>>>>>>> overhead will be).
>>>>>> Can you tell us which bits or pattern is not allocated? Maybe we can exclude
>>>>>> that from the pattern.
>>>>> Yes, it may be easier to exclude those patterns. See the Arm ARM K.a
>>>>> section C4.1.94.29 (page 791).
>>>> Hmmm. We could consult an exception table once the pattern matches to reduce
>>>> the overhead.
>>> Yeah, check the atomic class first and then go into the finer-grained
>>> details. I think this would reduce the overhead for non-atomic
>>> instructions.
>> If I read the instruction encoding correctly, the unallocated instructions
>> are decided by the below fields:
>>
>>    - size
>>    - VAR
>>    - o3
>>    - opc
>>
>> To exclude them I think we can do something like:
>>
>> if atomic instructions {
>>      if V == 1
>>          return false;
>>      if o3 opc == 111x
>>          return false;
>>      switch VAR {
>>          000
>>              check o3 and opc
>>          001
>>              check 03 and opc
>>          010
>>              check o3 and opc
>>          011
>>              check o3 and opc
>>          default
>>              if size != 11
>>                  check o3 and opc
>>      }
>> }
>>
>> So it may take 4 + the possible unallocated combos of o3 and opc branches
>> for the worst case. I saw 5 different combos for o3 and opc, so 9 branches
>> for worst cases.
> Or we have a sorted table of exclusions and do a binary search. Not sure
> which one is faster.
>
>> But if they will be allocated to non-atomic instructions, we have to do
>> fine-grained decoding, but it may be easier since we can just filter out
>> those non-atomic instructions? Anyway it depends on how they will be used.
>> Hopefully this won't happen.
> Actually, the atomics table has LD64B and LDAPR already which are load
> instructions, no write permission needed. So we need to exclude these
> and all the unallocated space in this range.

OK. Excluding LD64B and LDAPR actually makes the check much simpler if 
we return true for supported instructions instead of checking 
unallocated instructions. It looks like:

((val & 0x3f207c00) == 0x38200000) |
((val & 0x3f208c00) == 0x38200000) |
((val & 0x7fe06c00) == 0x78202000) |
((val & 0xbf204c00) == 0x38200000)

Thanks D Scott help figure this out.

>


