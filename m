Return-Path: <linux-kernel+bounces-524080-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCDC2A3DEE9
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 16:41:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A169174311
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 15:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E2D1F5849;
	Thu, 20 Feb 2025 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kyU9MhqX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uUC/hRAh"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 970B31D6DC8
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 15:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740066002; cv=fail; b=mZPCswk+06wyBJ6uYU0vTy3BOUHJ7wjVFcAWXVloIlpcuQ5dnFffdbbQOlkJo/o+fdjuNhriSqyKHsLOpXHW+7FgwGjp0TUGCHk9CSU8AfYyHYwJjFUpJfTl7Hulc+6JG02wolAEVXY27ofpN6zZ5UD9QBQ8WIwGeQcqKNWJyDE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740066002; c=relaxed/simple;
	bh=UcsCAMEygND7uXj04YbmbnhvDWCkbMDBRRj650y2La0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JR+ACSxg/M7zO/qnkm8MVPcZYqPiiDPCPnGlLXBrPVRBmIhh2sADY1v1hNff2kO4OwFwCHpjYvwelJbQgcAnabnUVI0OPiWR0AaJ+PW5p4cblchp2eiVvy2eLKSdfJpe8SfCi4RUJ++/e5e15lL7HVlEvLyS/DJeQIun0GwrwCc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kyU9MhqX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uUC/hRAh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51KFMt07013754;
	Thu, 20 Feb 2025 15:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=fyKOWuO1kLkZn/Q5XpQTy80xAFomnnbjRC1YAO35+no=; b=
	kyU9MhqXndSsWdzcouF4vyAXmbjzHtBz9AflMZagi+UNlELCfPYTFwj4gpy4OtOK
	gFg9+nYct0+sUWKhd12qnNDIVkpiTKwlG9A24D/p2zyktsvxEthJ+V/YVEIor0Jt
	PjGmEK7pEYBADDB1lNYfaIiE/Lqt9d9UMCEbDRGNeg0Yxe9xKsTqGg7CXPS0Buy7
	ysN5DTKKT+JlNsxSgFCZwuS2bXN3+plqBh3E6C5WeJqLOTcneX7AeGHCRtLutHKC
	Bce/kbC7J5V7Uxrx9/fP1JqBn7emhFXiFPoeOlGyyt8cNQPH+zIs+IGIzHmTUCXk
	xQ76K6NpPQYSWVng4O0vlQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44w00kme5d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 15:39:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51KEqBYY010447;
	Thu, 20 Feb 2025 15:39:49 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44w07f3qee-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Feb 2025 15:39:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oH5dw5wrdKUFi+cj+vRcEWfaSOwu0oLK8TdOp11N8EhDm81iUF84n9NpyuOBBrS6J0FrW4YkmYBZolQ6Zud8RslHpzlLlKXTCAo4Am+XWOjy4KvvFLl7BgKBqIfYdx/MoF0d9IGPuyG80uk6zl2O/05lQqmuKWe1I660qcftQdJbRM/LRfZfZKo6mQ8uICtOCOGpB8s8QosnhLFwQd/bVS1CxjCY//vNpNpItTX+s4hSUi2YGNnFoK7YNpb+dscpSiLb1sXNYlA0X+G3YYDTPIsIIoBEA1tQENDkRPOoE6ts+PafxcFyOfLPE905r9bQC3Da71UwK3MHqeEEVIgvAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyKOWuO1kLkZn/Q5XpQTy80xAFomnnbjRC1YAO35+no=;
 b=yZpHa3vhzOBgoBRgNeCFJy0L8UtltzQJVjKt+i0p6kYPGOzWuI4a7a4DUvTDubnI1/PTUT43scUsfemdX4fsbMjZmA86G1Gl6i7f1/UV3iPkSaeyG878Mau/9C5DqZrNEboMp44g9hWWRIgFps2ulr6x0yCfTV06HBf3o9X36RIZWYb8lf5+6lyx6dVI9Vz+EQFepAI1ABNcL9B1XupdUY7dSTMmhxUBXbRTpc2aOi+DSIC5hDsfPITI83YLN5idX/gzp2mc+KDWROehcejrqXF+BeW9/Io9X3Kyh/ZxbJ/Vj0Z/IxXy5rW2tKLPWRlWBOBLT0bYjpHB0ERnt0j3Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyKOWuO1kLkZn/Q5XpQTy80xAFomnnbjRC1YAO35+no=;
 b=uUC/hRAhzhTiLzIXz7NUT1Ty62GeZIzebvQ0OGQDlFbKhhv7nCqDyIfFKJF9qzYrCU8BmFWyP/u3Cm3mefd0ynXaH+xzylVRRe7eXCtjwwufMCYeXVg49knMdaSA2bbRTlQ/QwvewxKAY/GShwqUaNBY9733W5LwKVwhd/FHoVY=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by CO1PR10MB4596.namprd10.prod.outlook.com (2603:10b6:303:6f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 15:39:48 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb%6]) with mapi id 15.20.8445.020; Thu, 20 Feb 2025
 15:39:48 +0000
Message-ID: <d4a19c65-683a-4ae0-89a6-8c4c1590f51e@oracle.com>
Date: Thu, 20 Feb 2025 09:39:46 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/jfs: Prevent integer overflow in AG size calculation
To: Rand Deeb <rand.sec96@gmail.com>, jfs-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Cc: deeb.rand@confident.ru, lvc-project@linuxtesting.org,
        voskresenski.stanislav@confident.ru
References: <20250220095231.1686611-1-rand.sec96@gmail.com>
From: Dave Kleikamp <dave.kleikamp@oracle.com>
Content-Language: en-US
In-Reply-To: <20250220095231.1686611-1-rand.sec96@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR07CA0054.namprd07.prod.outlook.com
 (2603:10b6:610:5b::28) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|CO1PR10MB4596:EE_
X-MS-Office365-Filtering-Correlation-Id: 198b7614-9314-4e49-3c43-08dd51c4cea5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YkRGN0xMZTVIWDQzKzAxTlllVVY4T3h1ZDJqUkQvV0ZMUFVVODBsN1kzWHRG?=
 =?utf-8?B?b2d0K3F1Yk1ZM21uWWduVno3Z2huYk9HNGhTeUpRbEtxWUk4RkNDVzdJTXcv?=
 =?utf-8?B?cTZVRk85eUxoV2RVZ3EwMURxWXE2T3RVS2d6UW9acDlEaE8yczB2VitUZkV1?=
 =?utf-8?B?cDZtSWNBZ2JqZHI1Tk1PYVo2clFUdnZ2c2xodmI0R1VSc3Z1SldRZWVYbmR4?=
 =?utf-8?B?SGJncUFFaStPSzZiNEh3KzNEbFdVQm1tTUsrUlZ2aXNyUHF5anFRc0x6dGUx?=
 =?utf-8?B?enZhNDRsTUVmVDhGTkxEZFkzL3pPcVdRUlc5OEcyQjMvVVAwa3IvNmZ5Nm5z?=
 =?utf-8?B?NzVxNit2QjFtSTB5cXJMSityNmNpWG5ycTd4WGt1UGIwL2xRaEhZT20vZlBS?=
 =?utf-8?B?ZExvOXRoUWc0b2d3cXM4dTN0QjFDYWpST3ZDVFdZUHF1UXdZTWdOcjUyck9S?=
 =?utf-8?B?NmF6NHNuNlVVMit3bDhPbDBGMzFYeFBwV2lCek9ud3IvNmVaaFVCNGo3c2NC?=
 =?utf-8?B?aHpqVkhxKzdiL1BUZ25tQVg4ZEd3TlF2alpqaHd3UFgwZXVvSGNlZXRtdDZ5?=
 =?utf-8?B?TmFOUW5JTnJjdU40TDVaN1lNQnlHbHlLVmVta1lTNWRzaks5VFdZVEVpOXBU?=
 =?utf-8?B?RHdNSHJaWWdkdWlQWFg5QWFkc1M1cXo5L3lveDdhZ0FDMlR4VDlpV0l0S1gw?=
 =?utf-8?B?ekhna0NzTHg4RXErQlJCYWkrTlRwQUgzNk1zOExycmEyUkU4R2lMWXRneXZ4?=
 =?utf-8?B?bjBqK3llM0YzUUY5bkF6ejlzTHBFaDFSOWxTS1BVY2pWaGZLV25zUWw4M3RZ?=
 =?utf-8?B?MkNHOTNtRGtHQnNKMzUzN1Y4OUE3VGQ0R1ZDWmw5YnZ2MmwrSkQwMDlreFFo?=
 =?utf-8?B?ZkJJZ1d1QUdSSCtzZy9wYkNlRmZuTzAwSkRaYTdrSVhScWNRSXJ2Zk9KQnhQ?=
 =?utf-8?B?a09QcFhCaXEyeGh1a0xVK2JIbUhDWU1mYnpEaGV3a3BqQ082RWVsSnZLeWFv?=
 =?utf-8?B?NWlMWWRZNGNHRjhBS1M3KzhzTDBscUdyUU9FOGpjbkZjS2VXc1lDUU5vbUw3?=
 =?utf-8?B?QXhHU1Q4TFBKVEdwZWtGSlRzS3ZvdG1EK0QwVG5rQXQyTmJzZVN5aFNRQVVS?=
 =?utf-8?B?bXI0eG5yaW5ibys1QXNiQ09FcXRWRDRpV0wzSDkwV0g0andmQlE4OFM0Tmtv?=
 =?utf-8?B?MnNGRFU1TUoyU2tiaytFbGxnQ1l6MEJXVVIzblhGNGlPQ0c2aStaRytuQnhZ?=
 =?utf-8?B?TmpucnJBRmR1QWp6VTZRZXZHZ2N6dEdXWXg3SGozbkw4ekUzV1B1QUVUVnli?=
 =?utf-8?B?NUdoNUVSYk5pcnduYXoxblUyNzFxV0ZJb0dqUmJTMUhyNGJ1OVhIUEp2NUp5?=
 =?utf-8?B?S1BRT09CeXpqblo5N1A2RHM1YnJicDRHQjRqQ1BzUFprTGF0dGZ6YU90dmhR?=
 =?utf-8?B?YnkzZVNZZGRJa2FJWHpyOWpBak8wd3FwcnN3Ylc4a1VaS2ltT1Q3SGFvMkor?=
 =?utf-8?B?b0dscFBNVllHd0UrYlBCTkpsaDVNdldhcHhSQ3R2WnFVNTVPNTdyOXZ5YzZy?=
 =?utf-8?B?ODhZNzlUNmp0MGpoQm02Vmh1V0NEMngzcXZySVdPbGZxb25sU2tHUTB6NlZn?=
 =?utf-8?B?cjBSWTc1WGFCbmN6N3lrM2d2NDdSdXYraDlZLzhpdmN4OVE3cy91dGtIQUsy?=
 =?utf-8?B?djFKaytuVDZHUGlwNWlVYVZ2bDM3NXc2azFRaU1NQkNnMURxQkk4cXpIcmtM?=
 =?utf-8?B?N0VvaFNnQ1VOaEdPbWxsaldFZEpuT0grSU1qbTg3RjIvZjVYNlhnK1JWTTl5?=
 =?utf-8?B?NjQrT2Uvd3Y0dEJJSXpucURSVkc5WmVaMFZEMDhhS0RFOXhtNXIySDBqT1F3?=
 =?utf-8?Q?/OmuGpwuh1AIh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aVVuVlM4YUdQU2xPcnVRUkJ6VWo0My9FdytrdzZQc0s0UDl5VEhMMGJlRTF0?=
 =?utf-8?B?R2JZaktBYUI3MGpwdmJvRzZvdzBHWXpsK0Q5M2JGc1dlbUN3WWV4L3pqd2xE?=
 =?utf-8?B?R09laXZFR0RPU1V4ZUQvaGd3c09GTTZMVW1OMlczUGRTbGI3WE4rME5jVWY4?=
 =?utf-8?B?MGZuN1NESlhhSjhwTmpYS3YyN1U0Z0hsTi9XazFNQUNQTXBGR29xU2Q2MFNz?=
 =?utf-8?B?cThtVHhHTFNrUVByZ1g4aGhxMjVMTXFmcjJWWW8wVzJFTklMMm5odVRpV3pZ?=
 =?utf-8?B?blBRWWJBLzYzUjR3TUFmOFhQVlRrcWFnZGYwejhhd0gyZ0taQkYrcU5UV1N0?=
 =?utf-8?B?L1Bub3pYQVovSXppelhFNEk0Smd4MUVtZldjRC9LbUdwOWhudjJ5NmpNSGFj?=
 =?utf-8?B?RmNtS3NXaDgvY05rQnMreklqVjNwcGxZTzdsdU0vT2pDSGdsWGx4cW1DZi9R?=
 =?utf-8?B?WHdIRGp1ZWRoNEpZTktPSXFoQllKV01QRlZVemJ5b2xCYXNHTVd0SVkxalN3?=
 =?utf-8?B?SVYxUFFOVlJqMk9BcE13QmR1Y0dMM0xEYjZnMlNMNElybmhYSkVma1BKRDc4?=
 =?utf-8?B?aFpMZTVWcDlXZEE0dTgyZ2VNUXkrYXcweVk4VURNZmpMTENOVGl5MHExL0dE?=
 =?utf-8?B?QzVhWGFacGdOaEgxdUcwRHhUa1owSDJGaUloV2E0OFZ2NzlPMVhPVjlSRjNz?=
 =?utf-8?B?UzhOSVY1WmZpeGQ5UUFVdmRzVlNvalZyRGpmaWsreUdDeUxoRWh1dThqTHY2?=
 =?utf-8?B?cHJVb0ZnT2toaXBjdld2amFza0VoQVpUUlpzWHVJeEU5M201Mjlxc1VRbUZS?=
 =?utf-8?B?a1phcG5PSmJaZ0Y4QUxuNmxUelU1UytVeGlUaTFnbCtFZGI2VzNEakNMeTgz?=
 =?utf-8?B?RHFmbGpEVWl6S05hbFNFeGt4dE9zYjQ4aG1VTzM1UmxJV3lHQkVrNERxeDF4?=
 =?utf-8?B?dUp3Z0lqa2NTZFNrZmVUTlNpYzVzUDhRVUt3aGRsVGdFbTA0eTkzUHgrMWxS?=
 =?utf-8?B?dzFBdXVEWmFZL29aNTg1c2x5aUdFcmR2bjBCMGZITzhvdEFjYVFBanZVb2VF?=
 =?utf-8?B?d0daRGE1S1J5ZUR2TEJoai9NWHZpdXVHYW03NHRqVXFiTi9RbFhvY1V1Vmhr?=
 =?utf-8?B?VWRkbVQ1S0dSWk5RY003VXdiWm1UZExwTEZtU2FKNlFJNDhNdnhaMTFKL0hV?=
 =?utf-8?B?SCs5NkcyRU9POVUzaVlZeWp3djVFMUFDcW9yWnhEeXQvWitYUVdJWFFQOERH?=
 =?utf-8?B?NElSZEdRYTBBZWxMN1V4dy9BR3RaSHN0dGxSN0NjcVZIWW5sbXdEMXVBaHA3?=
 =?utf-8?B?WXo5VVp0ZjRRVlZxSFA5TTVqelZlT2NwK0ZySnRCMEtqQWhxUDNFY2NCMEg2?=
 =?utf-8?B?alR6c0xXdDIrNUpLNU4xRlFuajZwZmxiZlVSZElVOUR1QTI0NGVsR2pBQklG?=
 =?utf-8?B?cmE4RG9kUGc4SWRhT3ZTcit1VDhBNFB1ellQMndBdEZCNGtMN0hQeXM3dnpU?=
 =?utf-8?B?QmFWenRIUi9rTDdDbFd4YVlZbWFlbVFoRFFtL2tXQ1FWbVRhVWZ3VFB6angw?=
 =?utf-8?B?MUVrbW1OanQ1WlczNkdUZGN0eUxMcGZXNHFWUU50Wk1kMVBOSGhZREJVYU1U?=
 =?utf-8?B?NmZPTnNvSGsvaWhTa1VybEF2Q3k5cHg5VVhkZmxidG9aL05MaDVmSEErVmI4?=
 =?utf-8?B?c2MvZS9sR2lCNmU2c1grUmdBbFFRL1dJTVJDUjlkWVF1em5pbGdlcHJ5alF3?=
 =?utf-8?B?OVpIcGFOQ3RpSFNKUGtGd2lvTzl6d0VrS0NyanVNdU5uRCt3R3NFcm9iSjBp?=
 =?utf-8?B?bld6UnBTeGxDZ2FBZjBFWGtTR0FWQ0tieHJWRTAydUlLamJlSnh5MTR1enRY?=
 =?utf-8?B?S0NUaytzenJiS2ZlWXp1SUtSN3ZoR3N0WVVQT3N6T2I2NDFLR0ZmTFg2VFB3?=
 =?utf-8?B?c1lsS0FCNFlFWmdIV0d5R1FPZTQwbHR1RjNDV0JvUFNWb2xXemsxRThSaTJF?=
 =?utf-8?B?aFRrd1cwajBseGpiMVNDSmFYcFk1di9IMzhZblNXZDRVT2pXL0FkTUJPZHMv?=
 =?utf-8?B?R0ZiMEVOTU1FOGNvcFp2NGlLaDBLNk4vcDJ6eTkrNmxzVXRKTVAwZy9zMjI0?=
 =?utf-8?B?eWQ4RUJTbWxJSDY5YkFFVEtMQmN2bEt1VU5ianNScEw1M1dKZTNOalFqRlAz?=
 =?utf-8?B?Q3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pVLItCKvE4mnlEtH7QysBZjIKD4D7odiPsEkR00L7TtiAUiQwIHFEFgB6SIRGLywqBWK/tLfeUiPoTObGZG6CaPvMUYoHk6b9zq5cbhmbY6nSkuPNnMeRV85CMXkuU5dDr89YkHbgVPVDiQMPTSZEKcTDJ8f9SGbJJDBR4H4lYGK9BO34kl3hIW5nRoxu0uBfj/YrIvNoiRqWqNOtC67GyyNUxk/yH+cJMK7875FCXa2SaCRDOKcnh2A0dulLNYHpGIFqefhXlZ3aEYC+v7ghU09mbzqINA8W6wvE14RMLiVYFFv9qu/iAeQgLEOFpO7d4VYKeulEqqmQFB6b6N3wznsY0zP8gC4vTveNRg4Wg0tdhsRpKlN3ZmzUjBryfL55q9xvfqr1r67ID0dwxRoEab1teYpBY0Bo/ce6Lb1kjcW8XlJGCsVltgOkg1XwdeDhGD0jWqq6FuFW9vRTDXmn7xdSa2g4V9fwjpg/CaZonpbnReF6RCj5sIZV/UK7jGUhPRip6Teasdppe1ylQ+YKhMDFVoQMhIN8hwWOJjNavGA3nxw6gxDRQOvPIxNPn7APCxUruWlLwinJzTPFIMPygN/ZsUY9cYV4Adq9oePGSA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 198b7614-9314-4e49-3c43-08dd51c4cea5
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 15:39:48.0298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: szTRrNxI2vOa8XS2nEPPXt2XefdoH3Em6ZPBEcSiRTVENfHPxNjaTYHG5uw14DnThQDzXY4Bh6RLIL1wQZpOawixEibmaJ7YT2qdfqxVj6E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4596
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-20_06,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502200111
X-Proofpoint-ORIG-GUID: FYuvQ6cFSDCMKxoa1XTc0RWmaOCYVDvq
X-Proofpoint-GUID: FYuvQ6cFSDCMKxoa1XTc0RWmaOCYVDvq

On 2/20/25 3:52AM, Rand Deeb wrote:
> The JFS filesystem calculates allocation group (AG) size using 1 <<
> l2agsize in dbExtendFS(). When l2agsize exceeds 31 (possible with >2TB
> aggregates on 32-bit systems), this 32-bit shift operation causes undefined
> behavior and improper AG sizing.
> 
> On 32-bit architectures:
> - Left-shifting 1 by 32+ bits results in 0 due to integer overflow
> - This creates invalid AG sizes (0 or garbage values) in
> sbi->bmap->db_agsize
> - Subsequent block allocations would reference invalid AG structures
> - Could lead to:
>    - Filesystem corruption during extend operations
>    - Kernel crashes due to invalid memory accesses
>    - Security vulnerabilities via malformed on-disk structures
> 
> Fix by casting to s64 before shifting:
> bmp->db_agsize = (s64)1 << l2agsize;
> 
> This ensures 64-bit arithmetic even on 32-bit architectures. The cast
> matches the data type of db_agsize (s64) and follows similar patterns in
> JFS block calculation code.

Adding this to jfs-next.

Thanks,
Shaggy

> 
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
> ---
>   fs/jfs/jfs_dmap.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index f9009e4f9ffd..edb22cf9521a 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -3403,7 +3403,7 @@ int dbExtendFS(struct inode *ipbmap, s64 blkno,	s64 nblocks)
>   	oldl2agsize = bmp->db_agl2size;
>   
>   	bmp->db_agl2size = l2agsize;
> -	bmp->db_agsize = 1 << l2agsize;
> +	bmp->db_agsize = (s64)1 << l2agsize;
>   
>   	/* compute new number of AG */
>   	agno = bmp->db_numag;


