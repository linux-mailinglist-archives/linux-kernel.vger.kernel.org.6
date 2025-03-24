Return-Path: <linux-kernel+bounces-573183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0471A6D3F6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 07:03:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9628C7A5999
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 06:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DEC61993B7;
	Mon, 24 Mar 2025 06:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v2Y6RCIL"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2074.outbound.protection.outlook.com [40.107.244.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BBC194C75
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 06:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742796120; cv=fail; b=SrJg0mt4Ltpqixq8amuzCtPuvYmiAxN48vwZftOPwD3hiC4h+My1BaFLJ8bEhtI2bUhf20stXTDDfWYCakpffEVFA1qyUt3h/KjnyWVMKkGJFaohKtH4xQ/gj7aLe2wFT1tUW4Zfeo3ddzrwQ30jQ1jDrBOrLdBxe3g1GMsvEKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742796120; c=relaxed/simple;
	bh=7o5nTalAcS8OHNkzU4pTBAxyAZHavqEh4/UYh7cD+14=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rh395Auyp0Uwtji86pxoSX+WYRo4xHxSA5w0+7cs81rhrvvrfxKNw+GwnOu+ViTN761GmaV8h2JFCTafpkW6NI6cwuerRLaXd+T4gj/eTlAMAE/jrI2KTXzOmnA8hZ1cW/g9swuI+LKOZxhRkhxvk2HES2CdhfV/drK49pI58po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v2Y6RCIL; arc=fail smtp.client-ip=40.107.244.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUr140qAGa4TgLecgvEWcBrKI/WkWmTghxMS/luQSBJHa01eeC4GSjwqrRetvig1YlMQTXomm1HAIQoOk+ZGEkf1Hd2hh8vRZ3P0q8ccGMxB6NTzg43bZIB7AwTFlYAVH4VluTsEXLdxinDCDxLRfwQp16cPBwgsIF6kk/3LNwP4WcAF/0KolNwWpoJzbHDHr4tqGXnBh6klKvLBi02cOZNT4QVC0kda2s2YYhO41eTWguugV6d0D5v2fcMNXNJa7el2301l38Bi2wZdJhpn4R7V3Bd74oVw1uMXFOrst8LFU/9ONHasSsLGzgIMb/cSWP7oXET96DcoKNF3N9ntKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iCwFttyLgOMinoE0UnSYl+cWQ048KSF903N2XKJwlO8=;
 b=FsdbMu3KlvD4sRokpl49Nx2RQ+B42Vi6Tld+H7X9BWInq39mwyR3GCEdHxdsq1WsRvi44YclxaZFKZRxArRFfbgFXscZmygOVENrOf57MkKftLWcQelehtLKTqIDzwFc+uaSeTPo7pxmP4wBJIVJhPiLVQ1R1W9+9JhbO6x1RJuXcwci0e+qh8ccRZ9XPzNzzcm3iSeJyx6KnuTGCpjAN5xZbsTp1J1UnWZBZjIP1uybO79kXvx69NHJL9lrsdnWG3PUnuPm2DYGnEVC2GaSfuTyYlrs3S24USp5B+Z5j49SGXZ2Ibb1SGcnl2tuXf8J1tKpGPuUJ431M1KHlXaZCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iCwFttyLgOMinoE0UnSYl+cWQ048KSF903N2XKJwlO8=;
 b=v2Y6RCIL8FFlmzk469VoSogVdrIKwLcbsOGWBs2iPQxjYcCsmrPwXMXo9AQqy9qWBGekaOiPJwRytLFKNDHginLmfW+SGdpkGd7qKdtuLiFlFciMIfQJrxeBUML5v4EQlzbdkK1lu2wTkIALylhTokKiXymlaLj16ndwfbmpUSc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH2PR12MB4262.namprd12.prod.outlook.com (2603:10b6:610:af::8)
 by BL4PR12MB9478.namprd12.prod.outlook.com (2603:10b6:208:58e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 06:01:54 +0000
Received: from CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870]) by CH2PR12MB4262.namprd12.prod.outlook.com
 ([fe80::3bdb:bf3d:8bde:7870%5]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 06:01:48 +0000
Message-ID: <0f9e697e-d01c-4559-9c1c-7dd2ce76045b@amd.com>
Date: Mon, 24 Mar 2025 11:31:36 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] Enhancements to Page Migration with
 Multi-threading and Batch Offloading to DMA
To: akpm@linux-foundation.org, lsf-pc@lists.linux-foundation.org,
 linux-mm@kvack.org, ziy@nvidia.com
Cc: AneeshKumar.KizhakeVeetil@arm.com, baolin.wang@linux.alibaba.com,
 bharata@amd.com, david@redhat.com, gregory.price@memverge.com,
 honggyu.kim@sk.com, jane.chu@oracle.com, jhubbard@nvidia.com,
 jon.grimm@amd.com, k.shutemov@gmail.com, leesuyeon0506@gmail.com,
 leillc@google.com, liam.howlett@oracle.com, linux-kernel@vger.kernel.org,
 mel.gorman@gmail.com, Michael.Day@amd.com,
 Raghavendra.KodsaraThimmappa@amd.com, riel@surriel.com, rientjes@google.com,
 santosh.shukla@amd.com, shy828301@gmail.com, sj@kernel.org,
 wangkefeng.wang@huawei.com, weixugc@google.com, willy@infradead.org,
 ying.huang@linux.alibaba.com, wei.huang2@amd.com,
 Jonathan.Cameron@huawei.com, byungchul@sk.com
References: <cf6fc05d-c0b0-4de3-985e-5403977aa3aa@amd.com>
Content-Language: en-US
From: Shivank Garg <shivankg@amd.com>
In-Reply-To: <cf6fc05d-c0b0-4de3-985e-5403977aa3aa@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0147.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:c8::12) To CH2PR12MB4262.namprd12.prod.outlook.com
 (2603:10b6:610:af::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB4262:EE_|BL4PR12MB9478:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ea9cbc2-737a-45cf-173e-08dd6a995d03
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THJtOVVNTkFudUtVWk9iWVdFL3NDbDJ5TXVnRWVhL1V5UWd0WFVYY3hTdXor?=
 =?utf-8?B?eEkxSkRzM04vbVp3WmlVbEttZHdJK1hNbno4VmRHZjRqQkRHcE5KWENEOU1u?=
 =?utf-8?B?RXhCYzBlMStnTWN6YU9EamRoQlREOFd4ZURDSWtTR1RodVlrY1BDcnZ2OXd0?=
 =?utf-8?B?T3ZmY0hHWFJqM0Vrb3V0dkI2aTlDM1M5dmVVR0lzdkRYNDhTQmM5VTc4RUdM?=
 =?utf-8?B?ek8zbWl3NXNUQ05LaXZNM21zWjljdnc1TU1aWk5jRE9lTVBqRkZyY1MwbWlI?=
 =?utf-8?B?ZzduZnNaazlRODRwM203SWdCbk9uTlFxOEI1OWh1Yjd2ZHV4VWdpTDdoalkw?=
 =?utf-8?B?amZoNXZ2b1I5RVJWU3g4QWJZTkpaRGJzTC83dm1Wdkw5NWFrTjNzSWdDUVRL?=
 =?utf-8?B?UGR1N2Y0aXVtcXg2VGNCbndzbU9Fb0htME0vREppOTZSUGRJS0V3NXp3N1Bl?=
 =?utf-8?B?ZWZsZWRhTUNSNXRDK1VMbjdVSUJLSmNUekVkbFVwSkdDenRxZTd0dXhkRlJ5?=
 =?utf-8?B?WlQ4ODQyM1pxdTdsT09kTG1RSGFRSHlvZzlweDVVdVpzcnQyTlYyaWFQTVJO?=
 =?utf-8?B?ZW1UL3ZVSGRLSlJnRU5hYWhLcXI5enBaaTMrb3EwWGVCS2pFR2VHbldRYVVx?=
 =?utf-8?B?NlAvaVpyUERrejdQRkJGSmpOQUJwNEhvdW5iWFJLQVA4QjNDQ001R3lwYitm?=
 =?utf-8?B?cVhUT2t1UEVIcnYxTTFsRWoxRmNISGpidnlkRGFWYVRmVXg5RC9Pc0dxYXVZ?=
 =?utf-8?B?UVJCK1A3eWpoOC8yY3VaVktOVytiUlJDclRMZEFqZ1p1Z0I3VjAxK2VwTkNR?=
 =?utf-8?B?TjRUbHBxN2RkSDFjdzNTSit5d1p4UEJCTkdmYStIaEZMcXVSMXJuZURTbHhO?=
 =?utf-8?B?eXVLTGREcUNHM3VlWjBKbER1SzgzMzlvZlZjbFErRkZBQkxNS0FEZWRxeEFt?=
 =?utf-8?B?M1J4VS8vc3EvOTlYK3l2ZXJqeGtQYVpONlZyRThseldRTXJhcVkrZWJzL1g1?=
 =?utf-8?B?YWhoeEE1Q0FjNWFNcVV0MFlkbzM2K2VlMFd1a2xoNmFySmNWMFRrVCs3RGgr?=
 =?utf-8?B?VmtmOFBnZE9Zd2MrN3ptVVFFVWlxd1U0VWx6N3ErWlpieW04b3NCeUJLalhm?=
 =?utf-8?B?K0hNZzJ3bVVhN05qZ2N2MHBrTElWd1FXTStYeGR3NGdXT0hhczc5MytobWo0?=
 =?utf-8?B?T1F2WERwL2dlanJjRnhFYnVBazl2b3hGKzgyVmxXRlF3UmhWWmZNdk56R2U5?=
 =?utf-8?B?M053ZUpsdE9BSnVRVzByWUtVQzh2RUM0UGFrRnY4SXk1ME53WmVjaTl4NjRs?=
 =?utf-8?B?eURWa3pXTEh2M25CYXE4clhFcW91VlQ0dkQ2ekIzOTFEVEcveGpqeUJBL21k?=
 =?utf-8?B?dXV2dzM0ckdmSm9STE1JK0xlaVdqRHZiTGR3eVBwbU1iVGZMc1N0VDNJQjNJ?=
 =?utf-8?B?RUR5VEFUb1JJMVRSRXFmcFp0amZXNjR0b2hyRmc0M2pWbUZwSUZSK3RmU2pQ?=
 =?utf-8?B?WjNlcWtqVWhBRUZFanZ5M3ZpWXJ6SVF6SC82R2VEQ29oMGR3NXhkZzRjRU4z?=
 =?utf-8?B?d3MzUE54cnQvYUUrcm9kY3NUZUdBQ0NMUDlROWJqRzRETEdQVG9NclNqcDB2?=
 =?utf-8?B?S0Z6LzFueHZ0YUdnUWlqY2tPU1BvckJnUzNQOXAyNWsxNUYrUXB4MHQyWjlR?=
 =?utf-8?B?OFNvcGJGb3ZFbHVNbUthejdCM0N6QzErTTI5d0E5VXlXUFdOWXZHcDdPT2RM?=
 =?utf-8?B?c3N6OUt0YW1VRmNHWFQ3Q3dYRGNvaUlqOUZzNGtrKytDQkx0b1AyZlozTDcy?=
 =?utf-8?B?KzlOS3JBa2xSUXJQVEtaeGhCTHFUM0JHbk9rdjV1TFZFUFYxOHp5YnNMZ3Vw?=
 =?utf-8?B?cXFDYzBqV2lCQ1BXa2x1RTFqUnBYMEl3NU1WU052cjRCNFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR12MB4262.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SHpoVE5FQnpHaUQvVlRxWkZPNldZMUMrOXYrZXNEV3paWDBoWVh0V3FoeFQx?=
 =?utf-8?B?WGtOdy9FaTVOT2doSWhLdmJGWVhJQXlxQmhRTVYwU2REK0QwQlYwRWhyRFY1?=
 =?utf-8?B?djBaVVBrWEd2MVA5UGdHWnJicndYbGptT3l1c1NQT2FTWm1xNHlPQkFwQXcr?=
 =?utf-8?B?OFNCakQzTWtXZUJtbVFCcjdGVGFNeXpOS0loWnZsWVYyb3hVNWo5TXZpb21U?=
 =?utf-8?B?ZUJ3YmUyS053YWJNTUpJbVNnOVBObmhMaEdDQ1hudkU1Zmw1UEt6N0hya3Yr?=
 =?utf-8?B?Tkp5Z0NXOEZ6cVJ2ekYyK2VHdzlLNTBOa0NGd2ZIbGFOSXN4ODNVaDdtdzh3?=
 =?utf-8?B?ZzR4OXd1bHdwRlJPd21EVUVpdUdKcHdZUWJORWxxTWVJS3VkOUp4cHBjeTBz?=
 =?utf-8?B?MEZNaHNGc2JUUEdSM0tzSkd2WEhRTXZGVWd2RGFhSStvdWJqSDRrV05uQldQ?=
 =?utf-8?B?bUxpa0ttc2Q4dUh0eFdjMUo5N2dYKzlrOEsxTElFWEVDMHBucks1TFRuZmh5?=
 =?utf-8?B?VzNrWm5URWpwOG9ML0NLTXhoRlUrSmwrWVFDbzZXMVRlbHg1MzMvb2JpSFFy?=
 =?utf-8?B?eW5JeEZIdzRreE1BbUtqMmVZTThRUis1Q0YyRWFBWVJ3Y2ZkbTJWTE1USTdD?=
 =?utf-8?B?NTVDV3BseG1BU1dvL2lSNkxVSXlpVXZrYlhMcVhCWi9naDd4RlRUdWdHbDhr?=
 =?utf-8?B?YWhRRHEwRU5OWURheC9mS2wrZXVMNDkwRFpxeWRSTEZEUnJTcVdiUzdGcmxO?=
 =?utf-8?B?ZS9NNzNBSVFGSmtzSDFmcEhMOTBuRFdMd1pTMTNRUkcvNTZHblk1Ynhybi94?=
 =?utf-8?B?QlFFb1lvSHZYdnBha01FZE5ycjJtaG1zc05ndUIvSnZnUUwzTGxBR3JSb3Bw?=
 =?utf-8?B?a25TUlpaeE9IZ0NuOUR3S3p4OWtHcWd5ZlYxWkprUVlub05KTUp5Y0ZNbE5j?=
 =?utf-8?B?VzkrQ0ZHUkNGa0NzenM4Q0k1QjVZajM4QjdFa0hXL2lIMHNTY091R1h4eHA3?=
 =?utf-8?B?cXdxdlNyaHBRZ0FuL2lFVW01RE5oWHVhYit6Q093dDIwTElPNnJmREtkOE5Y?=
 =?utf-8?B?eWVtbWk0WlltWlkxK29JdUQ3R0IvQzRHV0EveFFXUkw4d3NyYVhrMTRYRGZR?=
 =?utf-8?B?N0VWMmZieEN4VUFMcHBkSXJVTWZ4SEFGY3NOOGd4TmtXRDRyS3Bwd1NsRUNL?=
 =?utf-8?B?bnNvaXBSVERBNWJkblh0T2hyUWVBWndDOHRxZDBYTUtyRlVXajVmQ0FYUU9m?=
 =?utf-8?B?RFNXNHQ1Q1NqQ0owTG5xRTVvOUNQWVM1dGE4Vi9sck9jODFZMXRYTVRIajJk?=
 =?utf-8?B?SlBVeVUxdkpMSVBPd0R5Snh2UC9SY09JSlgyR1BuN3RRNGE2V000VCtSdlUz?=
 =?utf-8?B?cFZKcUMrVGlreXZQdEdaU0tDYm5UTHQ0cnBqYThoUjdDZWlvYXJpblo2OTMy?=
 =?utf-8?B?QnY1bFVJaDYxakJwUjFUbmNQSzFScy9ndDFHeHA3K1Zub1d1MThlZGJ1d3BP?=
 =?utf-8?B?TU1PNXI5RHRMTnRuaWVSOGZ3VmRIZko4VnNiemkvKytuUXNnMjdhYU1VN1cz?=
 =?utf-8?B?Q3RGK0dOd1owWUw3T0UweExWVWJSbEZvRXVXTjlwSk1QejAyNE1pbXZIaUlL?=
 =?utf-8?B?VGdpclJKMzVNdEVXYkhtQmU1aTREclA4NHBOR09xQnNreTNCQnU5S0o0OEls?=
 =?utf-8?B?UXFmZys2cVJocHk0alRWaDBGbkYvSTNmRlVkYVlYNlNrT3NRWjB4ZnBmRG9X?=
 =?utf-8?B?YXZxa3NsbjZsVTZoRUNQWlBEdTdJYmJyR0k3VVZrdzUwN2c1cENueGhrYTAw?=
 =?utf-8?B?TWVzRHpNblFKbjc3NlV1TzFFeitlb0hQYmgxdzZDalN1MGZsZUVtcmQ5VmpE?=
 =?utf-8?B?SU1EcU1LS2ZkemRCVnI3ZUZzQWNLSXEyOE5uanN1VFViQmJTQ3A0UEI0VHJ4?=
 =?utf-8?B?NG1iL2lYYUV6alU5eDlROWhGelp0RUl4aFhrZjliNkZIclZqRlBJZmZxZDNu?=
 =?utf-8?B?anBycFFGN3FBQlpGTU1YMlRjNHR5M3M1a2pabEM4MURraHFCbXZzWjZtdi9n?=
 =?utf-8?B?eE9XMDRoWlJEbjZHeGQzMDFDeTRQa0lvbTdTNjM0RmtZSmpZQjZCVmRNZ0Fq?=
 =?utf-8?Q?lpitEVOXI6wLLanOMQhDkk9Dq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ea9cbc2-737a-45cf-173e-08dd6a995d03
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB4262.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 06:01:48.3671
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 715WZ68elh/eUbkA+zAxkQ/5IxfDzjHIEXe9LOSY6UnVR7u8dHr2TLnuB6o75OdihE5Bf+Jrh2Ofc0qlhJW3iQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9478



On 1/23/2025 11:25 AM, Shivank Garg wrote:
> Hi all,
> 
> Zi Yan and I would like to propose the topic: Enhancements to Page
> Migration with Multi-threading and Batch Offloading to DMA.
> 
> Page migration is a critical operation in NUMA systems that can incur
> significant overheads, affecting memory management performance across
> various workloads. For example, copying folios between DRAM NUMA nodes
> can take ~25% of the total migration cost for migrating 256MB of data.
> 
> Modern systems are equipped with powerful DMA engines for bulk data
> copying, GPUs, and high CPU core counts. Leveraging these hardware
> capabilities becomes essential for systems where frequent page promotion
> and demotion occur - from large-scale tiered-memory systems with CXL nodes
> to CPU-GPU coherent system with GPU memory exposed as NUMA nodes.
> 
> Existing page migration performs sequential page copying, underutilizing
> modern CPU architectures and high-bandwidth memory subsystems.
> 
> We have proposed and posted RFCs to enhance page migration through three
> key techniques:
> 1. Batching migration operations for bulk copying data [1]
> 2. Multi-threaded folio copying [2]
> 3. DMA offloading to hardware accelerators [1]
> 
> By employing batching and multi-threaded folio copying, we are able to
> achieve significant improvements in page migration throughput for large
> pages.
> 
> Discussion points:
> 1. Performance:
>    a. Policy decision for DMA and CPU selection
>    b. Platform-specific scheduling of folio-copy worker threads for better
>       bandwidth utilization
>    c. Using Non-temporal instructions for CPU-based memcpy
>    d. Upscaling/downscaling worker threads based on migration size, CPU
>       availability (system load), bandwidth saturation, etc.
> 2. Interface requirements with DMA hardware:
>    a. Standardizing APIs for DMA drivers and support for different DMA
>       drivers
>    b. Enhancing DMA drivers for bulk copying (e.g., SDXi Engine)
> 3. Resources Accounting:
>    a. CPU cgroups accounting and fairness [3]
>    b. Who bears migration cost? - (Migration cost attribution)
> 

Hi all,

For reference, here is the link to the latest RFC v2:

https://lore.kernel.org/linux-mm/20250319192211.10092-1-shivankg@amd.com

This version combines the ideas discussed in [1] and [2] and includes details
on performance improvements and experimental findings to provide more context
for discussion.

> References:
> [1] https://lore.kernel.org/all/20240614221525.19170-1-shivankg@amd.com
> [2] https://lore.kernel.org/all/20250103172419.4148674-1-ziy@nvidia.com
> [3] https://lore.kernel.org/all/CAHbLzkpoKP0fVZP5b10wdzAMDLWysDy7oH0qaUssiUXj80R6bw@mail.gmail.com

Looking forward to your feedback!

Thanks,
Shivank
 

