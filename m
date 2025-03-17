Return-Path: <linux-kernel+bounces-564828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D467A65B7C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 18:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE8B6176E79
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 17:50:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC4131AD403;
	Mon, 17 Mar 2025 17:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="UFjW44hP"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2115.outbound.protection.outlook.com [40.107.102.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904F017B425
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 17:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233831; cv=fail; b=UsIgQ99DhEsrzsYJLnBUcvDm8Yopn0xteM90Er98RDNV91WXIaOhFXOI/twIc1e47WVuR18x4v/M+65+w5eHtvWlwZ/MwAZsbie0yin5ALyPk/BOXbYc5Yimk6cmBfUF0sWS4CRkcnMTnYsiQ8vS8ek16ZquOaH0DZnGFD+NTr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233831; c=relaxed/simple;
	bh=a4H/s2OVFtBblx9Asnuj/8Kykisfp84C4HbmjXx2r4Y=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OJ8TUvv08pkmyyZCj7qZaReTXZhq9GCFNMW7jNxwB8LdZONtI3sZyLuqtfcxQmqDJ9o3+1XbzR486HO8Wq+xEm2Gjp/cohmnkkV5WDJ1iu8CFFHLeMST1p7aWhDnZXL7rS2MheQPqVzF96RJ9nLtn44Cbekb8MM0pwVC84XiCjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=UFjW44hP; arc=fail smtp.client-ip=40.107.102.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xs8muXRL7pAMsp1EJ2kts0gwU9u7IrjxZW0Fikov3QnhUhPL0PGhGy6TB2D/0DmKrXFag4BU9h+HsOoCg0ynxV5UXCD/+GjFoTCRad6ejv9PlHThBxNnmw/mehh1JzRgDylXPffYDy43HYWt95sKN84yl1PuzAeYBvC/Y61TM5/JijKuQMFGunOEl8mOkvyeumO9rBjZe5CadUt0LS7r5CDS101469nI0zq6RWGMSwPG8ZvjPZJTEP13wB/FfHC9lcbW/1C6A//O6oJ772gxDCuks8ADkdL7abGxf8Tzb/79OigZ0LpHFvrnWALBGocSJFO2rWps2dt3M01zW/zVQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dKaDaiGUJKGEeQvvWsBav6bu72msUQH9nkdGDTA3ug=;
 b=D3bkxhwJ4TZca088DBZfbM8kiIFk2huVclPK3mpSKRunjGzpO8+OJ5u5Lqs3s8jAQDmCQgYt6nU395SW7B4zc7vnp0R62ZUmRDOZVxBv7PwSP/2AFbXJXd+f912BHA1YPJU5jYhv0qdfwDc1IGFjiDh+HHvlo+kRplJhKrURNMN9KqZTkjN+kAZR53q7eHOrS8g6Zk7FKAFEAIlzURb6swdGfLNw5SN/N2Ao7UAlG2HajcCdsNaSngp2jme94nhn5+S7kNPFELa1EdNsxT47oZkLl38s38PWz9lwIoprXAm933ijBN/28XWDLWfWE5FUb4IwRm/1cfdpBh5dVbewnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dKaDaiGUJKGEeQvvWsBav6bu72msUQH9nkdGDTA3ug=;
 b=UFjW44hPp5im13NaMUSJDF0QsW/xNabwURjzJNvoQ+APSsdqr9r3mr+z1nPRgLY1yN37H7mtEFick0Nh/1Ixr2O0A7tZiUZ1f5lCAJ/3kuz09JrypktpYYuJcGR1VrkE5SqXQUTTALhHra04zLjHEIOLqiOlu1yx6HGu8zllVuA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from CH0PR01MB6873.prod.exchangelabs.com (2603:10b6:610:112::22) by
 CH7PR01MB9001.prod.exchangelabs.com (2603:10b6:610:24f::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.33; Mon, 17 Mar 2025 17:50:26 +0000
Received: from CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460]) by CH0PR01MB6873.prod.exchangelabs.com
 ([fe80::3850:9112:f3bf:6460%4]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 17:50:25 +0000
Message-ID: <242e70de-869f-4d00-ad5a-a8fe6721be1f@os.amperecomputing.com>
Date: Mon, 17 Mar 2025 10:50:22 -0700
User-Agent: Mozilla Thunderbird
From: Yang Shi <yang@os.amperecomputing.com>
Subject: Re: [v3 PATCH 2/6] arm64: cpufeature: add AmpereOne to BBML2 allow
 list
To: Ryan Roberts <ryan.roberts@arm.com>, will@kernel.org,
 catalin.marinas@arm.com, Miko.Lenczewski@arm.com,
 scott@os.amperecomputing.com, cl@gentwo.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20250304222018.615808-1-yang@os.amperecomputing.com>
 <20250304222018.615808-3-yang@os.amperecomputing.com>
 <36c70203-5203-44a1-bc08-479334b730c7@arm.com>
Content-Language: en-US
In-Reply-To: <36c70203-5203-44a1-bc08-479334b730c7@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CY5P221CA0041.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:930:4::22) To CH0PR01MB6873.prod.exchangelabs.com
 (2603:10b6:610:112::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR01MB6873:EE_|CH7PR01MB9001:EE_
X-MS-Office365-Filtering-Correlation-Id: 9715c1a6-d0aa-4c9a-fb10-08dd657c3288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SVhCYjRCend3U0NYVWFscXM3UEtxcllYbDdHc1JWRmFocFpVQ2lVcG1nUGZB?=
 =?utf-8?B?ZTdjdFh5MVlabmJ4eEtqN21zT3FtSHRHSC9sU3F3dVJ4MW95eTJWQzYrZUR2?=
 =?utf-8?B?a2YzNi94d253RjQ1bmZxaWlqK0JzclFPQlZkTksxbEdvK0hteWV0VUpiZGR3?=
 =?utf-8?B?Nk82VUhkYys1TWlOVjJqeUM0NFRaVEMybzdvcC9BMGFnd0ZyU2hSdHFhQmp1?=
 =?utf-8?B?MzZTTFFtbVV0R3FkRHZMSE1ZYXRrcnU0emxXZmNnQWRHTzVPVGRPVE5TbGE4?=
 =?utf-8?B?dGhmUUtCWmVFSEtwalFSbFBtS0N1RGRpT3BQQytlQ1huenJJcW1oRXF5a0RS?=
 =?utf-8?B?U2NuSkx6TUhYbFNEZ3pEeWZkNUNMdDNFRndMeXpyeVVYbUVuZDFtRmVKOGZu?=
 =?utf-8?B?TlBZbWI5bnZYaGhEY05laDliMFdBaEY0QWxiZWVLRlM0NnpOcFlsa3VROXdt?=
 =?utf-8?B?K0IwMFR0ME5hMGlsNTNFSHplVW0wUkJVdnJLV1JKblpMamk0NUdMdnFuRHZG?=
 =?utf-8?B?WUg2SzRkaDhadkx0Vjk2dFgyWG4raTFQU2pnVExjdGFXcE80T3ZGV3BUc0ZP?=
 =?utf-8?B?dVFQT0JvWlU2NzQvMTVOdGlWV3V0Q0NlOVdWUzcrSTVmUXEvVFpucnF5STB5?=
 =?utf-8?B?S2xKMXBNaTlGS25QZGFGQVQ1bU0wMXN2M29zclVQYURQSFp3Z25QK05aL1FX?=
 =?utf-8?B?T2pwb2p0UTZVL1RVbzd5WnorcFk4dVFSd1ZnTUt4MEg3VTNTbnFqR0VRNkdI?=
 =?utf-8?B?dzVPdVh5bWYxelpWblo3Q0Q0NXRPVCswcFZDYm5nMFd6QVpnRHdidWNpeWU0?=
 =?utf-8?B?QU5LYjRqOW9GdCtWUGpaalYwaWVTbkN2YWp4MnJEWW1tTVVZSEtlRmo3TEsy?=
 =?utf-8?B?bUhlU3huRXJIZzYyRlNXRmRucXlwbXV1RWtMbVlhNk45K1A3SjdCaTdzWW56?=
 =?utf-8?B?TG1SQ1lKdk9nZG1QOWI2S3JVL0xKWXA5ZjRzeFFnclUxc1JXMC9yVDBVZGVo?=
 =?utf-8?B?U2ZYWU9yRlFKQndPdDVUc0ZJYmtWV3dmT2dCSC9xR2MzREV5dGN2K09IZXZL?=
 =?utf-8?B?bFZOTW9XSmdLdjZaVngzTGtIb3N2ZExERllOdWYxSS9hOE12RUZ6S1cwK0c2?=
 =?utf-8?B?ZGZ4cW9LTmpmNUZmWXVvclQwVWJ2cy9QbnVyWVF5a1Rsb093WmxxODVuckxW?=
 =?utf-8?B?VHZIWllqTXJURElaQVQ1cG1yY0dKWGprd3g0eW9iQ3dMQk5sdjNiM0dWcTNw?=
 =?utf-8?B?SE1YanBjK1ZqZ1drZ1lDMU1Wd0pSQnA5WVVBVDkrdEcvNzJnSmlZdHovNGdD?=
 =?utf-8?B?TUpyMVNaVGNrY25MS3hnWTZTbzVQMkR0N2RGcmtmczZ3U2U5WFdXVXJLMXZt?=
 =?utf-8?B?cmttZFIzcGFvMi84Z2NTM3ZaTXZqdCtldjJOV2tvc29XeWVFRDBpZDliVGdi?=
 =?utf-8?B?KzF6K2pJUk9GQ3ZrQXhtY1ptdXFMMkVFZldJN1d6YUM1azgycWJnWHVwa2U3?=
 =?utf-8?B?NkJjZEtUYWY4ZC93enBmSXNWWUk4eXdLek4yd3ZaWFFMSjh2MDVDNHN3ckJU?=
 =?utf-8?B?dmFlUWQzdHY3NW5yOExvd1JOUkJjUUZzUm5tNUlzUERwOTZhZHM0Y0M3U2hm?=
 =?utf-8?B?QkxHQUdzd0VCY3IyanBsUUdDNFFhU0p0bjBwWDFMNXBVN214NnQ1Q3BSME5r?=
 =?utf-8?B?M1c1ZzVKbkl1U21ZYXByckFDeUdzdlp1V0Z2SnF0dkNpTmNueHJTOVkwL25w?=
 =?utf-8?B?V2laMVpFamxSZlZ0WjN1dGo5Q3Radmc5eEtvNTQxdlorWTdHTGV6VXpYQVd0?=
 =?utf-8?B?TytpWjlkRjVYSzRJMWRhY2pGRTBpOVVEb0k3QkRjTXhGMkxMcExGSGNqTEt4?=
 =?utf-8?Q?vkoF4N+AWmdSs?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR01MB6873.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmtBN2x4RDdJdG8wZXNsRDZqa0dHRkNVL2N0Zyt0N2FZcnVIK1N4d1hLb0pH?=
 =?utf-8?B?ZFF4QnBDWGo0VE9UY1ovVzI5RENzckhQMXpRZXorT3VmczF1aTAzamRrSDJs?=
 =?utf-8?B?T2ZTU2JSdTlnbitYWkFFNjk4WmthU0hqK0FtRk4yalpmR3VVRUNva29peElL?=
 =?utf-8?B?bWRoaUNSSTVkdU9aTnhRQnNtSkZQemNXUG43aDI3UFVacHNkSi9IVDdkTE5z?=
 =?utf-8?B?TmFuWU11WS9OQndJUzM4RlROakJGTVJkTzNxYXRrRysxYUNTR1NNNW5mTzBQ?=
 =?utf-8?B?ZVd0ay9oVEVBWXdzNm9sMUluci9yeDBFTDQ5dUpwdEprb0VWUHVQVU5Da0JT?=
 =?utf-8?B?NWY3S1FSZkg5MHNkbmk3eTVnUEkvdkRCVGFUZTY1aU55ZVZYWlJ6V0J1Ylpi?=
 =?utf-8?B?T3BlcW5NQ2drUEREL1c0dUJHUG1qMjVxY0crUXlYSHNCMTVwS3RtWWNDYTJp?=
 =?utf-8?B?RGFkZjZWUHZYZkRSZXY1elhta0NuYzFSWVgvL0FrdkVTTHRVakdCM1hRTHY2?=
 =?utf-8?B?aWtKbmV4dnRGbmp1NFgxem9XVzE4RkU4OVVJR1pBMTdhbTcza0ZCWXFaKzZ4?=
 =?utf-8?B?SWR1UWx2aW90L3lpd2xmdUZFS0Rwa1lpUlFRSTliTnVuK0tiWE04eFkvS3l1?=
 =?utf-8?B?SlBxRFZvMWcxSzg1WU8rb3BRZ3ErUDhYS0FuMUlKTTZKQTRBVzBVcks0SEht?=
 =?utf-8?B?TjZHZGwrVHhwVlZRbjUvMWZxSVJ5UlBDSHc4NUFVSzJtZnhMTnhJbU1sT2F6?=
 =?utf-8?B?d3loQmQveFBBTFRXa1NOcVk3ZytJZ2NrZE53ckMzMXN0c052RzQyWHBNUCs2?=
 =?utf-8?B?UEwzaUp1MjBVOFVHTG0yZ2JidU1KY1R0cnZvb29LbDhlZDcxbE1JVWx0dGRE?=
 =?utf-8?B?TU5zU1l4dTJCU1VsOGUrajByeDNpZURobThTRW85OTVnQ3hncFZYZHJlTktj?=
 =?utf-8?B?RVcxOFFVL1VDMlp3bWY4aTJhclBCUkRSMnNveUlKZER4V2hkT2JMamlXOFgv?=
 =?utf-8?B?NTI5ZE9lQVFsYzdoMkRHbHhHb2wyeEcwMmJXcDgzNWQvLzRwMVFhUUtwZEls?=
 =?utf-8?B?NjdxcmEyUXpLQmh4ckFKNDR3UlNPZkZRdTRlUmR2WTBSSFZDbkFxOC9wMDNM?=
 =?utf-8?B?MDhQbkZEVU9vbHlBWmpGZEwySVBRUlNpV0VhQmtMdWJrUGd4SUFCa0VyRVh0?=
 =?utf-8?B?UXFJYy9aNUl3SEYveEF4VjY3dW5vMXBmMFBobVovWGErRTZKeGVYSUlYMEw3?=
 =?utf-8?B?RFFFeGRyTXEzYTI0dlA1clZaNFlHMGdvU0tmTWVXTlRZdEZtSUdqQWpOOStP?=
 =?utf-8?B?b202NytYZEx0WlpKRVhmb3YrNWVnNWpoL084NHBteWxHNHN1ZnEvSWxCaXRG?=
 =?utf-8?B?ZFpqSHBzVWZFaXZTeng3R0lweHkyRkdJTGpRVE5tOVd1dy9HYXR3bTdzU0Z4?=
 =?utf-8?B?U2Z1RnNyeU9yNFdNTzROOHFpYURldkRIb25kVzltZE93YjZvNHFOZGt5Qk5a?=
 =?utf-8?B?aCtYbmQ5NXNyNSsxenFiMzRTMWdMVU93OUlTb0pSbzNYQmxvNVlRV1luSXRs?=
 =?utf-8?B?S0R4Y3VMQjdQNVdPckdvZnNQeG5VRUZxQzUrSU54U0hJdk43WkVkTWhaYnVz?=
 =?utf-8?B?aEdFSFI4VUpWNU41MGl6QjBlOXNQb1paVm9ZVkVaa0s3ZWE3dzFIOG9BdklV?=
 =?utf-8?B?MGRqeTZhY0NVeUpLb1ptamQ1K3gxSkVIVWRHNTl1Mmt1a0FUcHNOejVvcG1C?=
 =?utf-8?B?bTJyQVNsZ3BIVVZuOGN4Z2R6VXptenptY3pYVzNwMmdwRjhxVytnUlA2Tlg3?=
 =?utf-8?B?Yk01R3k0dU8zTVRWdTAwWTNnblN5S096ZFdLcll5bm5pdG4vS0pmZUxyZFcr?=
 =?utf-8?B?bDJvZXhBWTlLdmlIVGoxVWR0Q0xXbGJZZmRldXlxS2ZUbGY2SW1Ua0VCOWhL?=
 =?utf-8?B?VXJnakVZY0lBWE1iSWFJeGQyRmJwTVBNVEtSY3VMZWc3MlVIRlRRUUw4UnlD?=
 =?utf-8?B?OXZ0anlHZ0dwNXBwKzNYeStVQTRTNXdDRzVuUi9pZ2JwUG55amdqR3c1SXdQ?=
 =?utf-8?B?SlRGenZGMEExNlpNcWJ6MytzWGFUT1pCUVY2ZTIwdUZDZGx2MFpwSEMxbnZH?=
 =?utf-8?B?OFNybWIyeGFqYW8yWHp4TnYwQlhkSUExUWtqV09kSVlTa2Q0VzVia2dHZkdk?=
 =?utf-8?Q?UzPP028I6hA4mATpKqAB7yU=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9715c1a6-d0aa-4c9a-fb10-08dd657c3288
X-MS-Exchange-CrossTenant-AuthSource: CH0PR01MB6873.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2025 17:50:25.7000
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PqoCvGgx85CP/W2BrRgkgKJNYLH2SAC3n524imv5gXdgRRMmFwb7BvWbc9/KrirXHbmPQETv8Fk43LNfI109rmSP0x/FIcIiucsWRKVWJHY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH7PR01MB9001



On 3/14/25 3:58 AM, Ryan Roberts wrote:
> On 04/03/2025 22:19, Yang Shi wrote:
>> AmpereOne supports BBML2 without conflict abort, add to the allow list.
>>
>> Signed-off-by: Yang Shi<yang@os.amperecomputing.com>
>> ---
>>   arch/arm64/kernel/cpufeature.c | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
>> index 7934c6dd493e..bf3df8407ca3 100644
>> --- a/arch/arm64/kernel/cpufeature.c
>> +++ b/arch/arm64/kernel/cpufeature.c
>> @@ -2192,6 +2192,8 @@ static bool cpu_has_bbml2_noabort(unsigned int cpu_midr)
>>   	static const struct midr_range supports_bbml2_noabort_list[] = {
>>   		MIDR_REV_RANGE(MIDR_CORTEX_X4, 0, 3, 0xf),
>>   		MIDR_REV_RANGE(MIDR_NEOVERSE_V3, 0, 2, 0xf),
>> +		MIDR_ALL_VERSIONS(MIDR_AMPERE1),
>> +		MIDR_ALL_VERSIONS(MIDR_AMPERE1A),
>>   		{}
>>   	};
>>   
> Miko's series will move back to additionally checking MMFR2.BBM, so you will
> need to add an erratum workaround for these CPUs to set MMFR2.BBM=2 in the
> per-cpu "sanitised" feature register. See:
>
> https://lore.kernel.org/linux-arm-kernel/86ecyzorb7.wl-maz@kernel.org/

Thank you. I will talk to our architect to see how we should handle 
this. This should not block the page table split work.

Yang

> Thanks,
> Ryan
>


