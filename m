Return-Path: <linux-kernel+bounces-241147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F04A92778D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 15:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FB63281851
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 13:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B67941AED57;
	Thu,  4 Jul 2024 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="d7CWr7p1"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2CF41ABC25;
	Thu,  4 Jul 2024 13:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101468; cv=fail; b=VWk0hQzNmsIYncTdHHUkCtjR5wXcn7tLbMHGXqk9xtX1I6PsznGIRLz3RwiXRmT7wtiPbIphmzzgBBNyYppYXUIMYVuZj4d+7TSdwpI8ax04MS83vZSmCe1qDoy6t2AOrLmBHY9Mf4na+IoiHk3bmUlCaX/dIzHhvqqNZ0WeaPE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101468; c=relaxed/simple;
	bh=e+5F4kLIhorRt+gSWrtHZjkeWlZNJW98FrGE7NUujCA=;
	h=Subject:To:Cc:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=bK2lOFnJmtVPMidlydGSJdAsntZFRr5dMXzUqH6DZfb4+alagM6G2r0ZZtuVxL6JYYOXA8X2ZD3zeMwB1TlsLHfupih71JM943lhTQfw/ES3m0LJ80CmAxW3VT8Tp5RBXmgZA0wUBogWOpfxpNS6QZK34dtAafWCgXNg9J8Bnv8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=d7CWr7p1; arc=fail smtp.client-ip=40.107.212.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iSiyokQEWmZznW0Yxx7ebguA/I3JmnXFhZlpRZoF2OCObwOEdUOjJw3HP5D7A71Ql+5rcgIHJBmX8iabUAyrb6EKa/RUcex5SWq9hF+9WnweSzgQ4DYV30lSClObEpsp5zmGKeLObcc7YklGPAw81qkhQw4bhELWEmEw4GzJqg9tl3FLtywIvaa+3Tiu7RTATlHHjKhbdR+iMIoPkZYj4q4Wgxu9rX4Jj7XQnGXHd7LA69DtIbSsIPcFrCDiagpJlN+6n7cLdEEmWx5C10to2OgQJvHxugRAbfJdSvotqga3TtU9aqKruVCeIxHB5gBCKaLt6sqaxMFoUleknotxiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K5VytEqd2OA7NqT3ktQ76VHl7gHofZw4BzgMDAu7nys=;
 b=GprqxbzucNqlmv5Y8z5niI9yq/vWmNYWbRyM+v2805g8cPZT7P7rSrlZYGLnosTeAaUGeEjPW7pjDaj2oGL5hk4JXCDh4Lhe2461+ZIwd7AFsy64cWxeEipXBQ4xDLeJSkUws7AE4ucT/vCqTfN5qzvXhxt8hBXhfMDuqcsEmaQe7MZxhvxdvFnFzmAtXN2m/WeYrdMylsgu3jAlCPyQHOWdYlMiAHdlmFa5VrhtnUtH8DTbO8XYJkmuYu/yyf0akOATMCo55FBwI6M2v619hJrZfC+rlk8IyaK8OVHeYsHaTpjywLXLAZCisjzBpv5Wy7DwKYImFGi2N6weOjPA4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K5VytEqd2OA7NqT3ktQ76VHl7gHofZw4BzgMDAu7nys=;
 b=d7CWr7p180pODGVfyhyhMMeg3ulryS+LBsG6+UlYEaL6RIxECS6/udOuynTrmpEiTHQ5lKvTlrIqMCwDtHJVFPZMd2jLCq4ur+fyJyTbCsM9GCYluL+Izz0+nBP/LW10RiebbH1ytxJj75oKQaxubPeAtnXSh+PyVCHhaZ7onu8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CH3PR12MB8909.namprd12.prod.outlook.com (2603:10b6:610:179::10)
 by SN7PR12MB7297.namprd12.prod.outlook.com (2603:10b6:806:2ad::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.23; Thu, 4 Jul
 2024 13:57:43 +0000
Received: from CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753]) by CH3PR12MB8909.namprd12.prod.outlook.com
 ([fe80::b55b:2420:83e9:9753%7]) with mapi id 15.20.7741.017; Thu, 4 Jul 2024
 13:57:43 +0000
Subject: Re: [PATCH 1/6] hwmon/misc sbrmi: Move core sbrmi from hwmon to misc
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux@roeck-us.net, arnd@arndb.de, naveenkrishna.chatradhi@amd.com
References: <20240704111624.1583460-1-akshay.gupta@amd.com>
 <20240704111624.1583460-2-akshay.gupta@amd.com>
 <2024070448-spectacle-pungent-38ba@gregkh>
From: "Gupta, Akshay" <Akshay.Gupta@amd.com>
Message-ID: <e64dc60b-b4df-c24d-2f73-6d64b0f618c2@amd.com>
Date: Thu, 4 Jul 2024 19:27:35 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <2024070448-spectacle-pungent-38ba@gregkh>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: PN3PR01CA0053.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:98::14) To CH3PR12MB8909.namprd12.prod.outlook.com
 (2603:10b6:610:179::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB8909:EE_|SN7PR12MB7297:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ce268bc-074f-4dc2-aaef-08dc9c314672
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SHh0YjNpbWFRRllmTjJSMjFHUzBQNmMwaFE0MkZOY0NXZFNYOXVQVytCSTRZ?=
 =?utf-8?B?UlR2SmR0eGlML1ZUU2M1T3U3TUE0L2NIR2QyKzF1SW1pdmdvcWo5NzNURlVl?=
 =?utf-8?B?eGpIUzN0ZW9hcWw5a3NoaTBNUXdKZ0h1NmQ0WFpWaWRuTlprelZsZ1M5bTFn?=
 =?utf-8?B?aFVpeTdXMjJHUThpWHgrYVlUbFJvMW5wbmliOUNXcVRKaTQxMFh1VmMyU0Fh?=
 =?utf-8?B?YkU1aTZpdkptZHFGNW84VEt4SUhTVU5BRWVmRGl5U3VRaVQwNW1paEI4ajVw?=
 =?utf-8?B?bGJTd2h2TVdSc25OWEE1dUVTUVZLZVF2cWhUYWNHSUd3SXMvOXVhVXp1ODFP?=
 =?utf-8?B?Q3hCUUpzZ1lkSTl4RmthM1lQdTBCRk5pNkxzOEUzSXpxSkVOR0I1dWJYMkxm?=
 =?utf-8?B?NWVpYi9yQis1dGYzRFpSVDZSdlQyeWlCUzRSMnlUYUxnOE1razgzSlhJVlRB?=
 =?utf-8?B?T25VTkx3M0hUem1jZERvZVJZYkkxbjRxenowMEU0RFNZVzN0M282c0txaVJY?=
 =?utf-8?B?bkczU2lia1ZQakt4VXpqNlloeDlZSnoreDR5aFlNVm13SHlFRUZ5cXdlSmV1?=
 =?utf-8?B?NVc1Q1NFUGR4ZVhzeWYxMkxVZUdzODRqOGM5b0hIcWsyakorYVJvWFBiN3Y5?=
 =?utf-8?B?VmZDZzNKRjZTczAzdkdtLzdqVVIrdENNREpGMlVmemFnQnkrNlNSQ1o2RXpX?=
 =?utf-8?B?NXJnOTlpSnpNVXJ1ck9mK2F4b2p1eHVySk5GRmhqRUpOSkpJeWlGN3lubHF0?=
 =?utf-8?B?Rm9EZFNIbURKek4zSUkzc3BzWmQvbGxJTmx5d3puTGhPLzFaeS9uTnhTZmdh?=
 =?utf-8?B?ZmhvWi9zWkRiZlFSM1UwS2pQQmFnMmhQQnNCV1ovRE5MME5CTVh3bWJFdzh0?=
 =?utf-8?B?TzcwcEswOGxjZjVJQjdKN05VNVRoRnZMd25seVJQTndoUW93empmUVl2MS84?=
 =?utf-8?B?c2VpVTNWK054QzRDL3VBNGhhUXArQ1RDajZtU2VvNGptdVJUa0xvWnkyN1o0?=
 =?utf-8?B?RlFIUE1zcVQweUVhck1wclZKR2tBZ1lnWTJSSC9LN3ZZWk1rTWQ0bTl3ZWRu?=
 =?utf-8?B?NFQvOGtpL0tON3cwNFlGd29laVNmWUErZkUvN3VrMWFwMzZkN1dmTFdPcHJY?=
 =?utf-8?B?NjZSMkM1UEJwaEloVlovQUpIT1lrVHRUcjVTRk1HWUtyTTFsbnd5dndBT09R?=
 =?utf-8?B?Z3lEeGcrSTJ6T21ZVS96T3E1Nm9GcFVxWDlQNXFEMXUwbzNXR2loKzZtUXpR?=
 =?utf-8?B?azJOMVZtRzdqRjJsUU1OMVc2Ri9mNWd1aFlyS1NjRTNmbS92ZHBCS0JSU2s3?=
 =?utf-8?B?M21jaVJBei9yOHNsRTQ3MXA2UVNCVlFRWmp1TGlmZ0NqbGNTK005OUZlZko2?=
 =?utf-8?B?TXpzZGI3UXFYVXcvVXZnK1JZREh1d3FRSUZLNlQ4VFFaWWJHUlRNYSt5VFo0?=
 =?utf-8?B?d0FPTmlNV3phSlNYRXE0S2xKb2pkayt6cWcrQVo2S2swd1RNZDFtcnF4b0tp?=
 =?utf-8?B?emdBbUFMTHVzU00zT0lLNytIL2FEeUZZOUQ4K3p4TWNwMXlDSTZ6R0gxcmdE?=
 =?utf-8?B?ME13aitsL3NZRHVUenFyV2NPMnF2eE1ZQUFMZUtSUXdGZ2ZYVStRbE0yTU02?=
 =?utf-8?B?eWl3aWdMS1R2TU9jeDIwb0NVV0lrZ1pNenNpenRoY3Vhblh0ZnpUZk1ONkVO?=
 =?utf-8?B?L1RiZmdLeUZxMDNmeTFHMlJncUlkVTFRZ1ppeUhUczk1cXo1eXdaKzFvYnVN?=
 =?utf-8?B?WnVZaWYrQXdEYlV4cWN3WllHZTRzSmJ6cEFnSlg0Y2hhZStzQ3BZbGZIenhx?=
 =?utf-8?B?cmhMcmVwdFo0ZDRFOUhPZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB8909.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dlVTZ3hteUxXZEhmcmlEbUNoQlhHWUpUUHI3VUUxUGdBbytyZDV0aVo1dldZ?=
 =?utf-8?B?dVNqa0liYlZ4R1FpSFlvc1dtM3d4UkdCTlQ0L0ZMMW9BSHhVYUE4eDFBRDNt?=
 =?utf-8?B?VGRKTHNEdzVMdHYxak1mODRxeGt2dlJIWXRNV3FkM2pWRXBQM250Qnl4YUNQ?=
 =?utf-8?B?VzdTSGRSeGtNdjdNMjV1NnNNSlB2MW41K2JUVCtCeFlKQWtlSHQzOThPRXE0?=
 =?utf-8?B?NGJxU29sdDdzdXBPMW9BM3IrRkVPenV5N3BvakJwRm5SZ2lVaHFLc3dtcFo2?=
 =?utf-8?B?VmZJbDZXcmVLK2thbkJuV2Z2TGRRRnRUNEV5d0pEdmZsVDVySGRBaWJZRWRS?=
 =?utf-8?B?T0tCa3ZpdUpzS3JSN2tMYzM3cTZMQWxYa2ZhQWhISllpRXY0TVFsZTFhdTN3?=
 =?utf-8?B?aUliTUxTdjFWdU9CdmVDL2dkZVdUbnhoRnZHSXBHUFQxbTFCRUgwdVluRVhQ?=
 =?utf-8?B?V2w5dUhSeUU2Q3k2SEk1QUxxTnNtbldCYWxtSVZMVnN0bkhTTmprUHB4N1c1?=
 =?utf-8?B?RkdSUmV2Ym9LZEJFNEVGVHFpMVQzTURwelFmTG5lZ29VbFpoc3pIeThJVHNi?=
 =?utf-8?B?T0RtdmZzOER0Z1R2aUU0VENVeFdmMkYvQzZnbHNkTU1DYmRyS2FKN2FoTVN6?=
 =?utf-8?B?Q3JYY1NRSUM4aVlTM1Bsc2RVaUhSUXQ5bmU0MFh5NmIzRis5MlBWQ2lTY3hY?=
 =?utf-8?B?bHV4empFR0pHYWFhdnFmcGlSVkQzaGp3eFpyWFZDV0djdU1kZmIrTkQrbytZ?=
 =?utf-8?B?TmtOb213RFcxLzg2VncyS01kUWFzenFaLzY0NS9PcktZcWVKVmFXc2lNNU4r?=
 =?utf-8?B?c3hySGs1WEovaDZ1OVc3bE5KTHI4MTQvWmg2RTlNQnlSNy92OFBMNnUzWTlH?=
 =?utf-8?B?TEdZVGZoT0NmSnFuQllwZ0FHU0pLOXpHVHEyTzUyd285dTlVb3FZNkM4SzJC?=
 =?utf-8?B?cG14THh4eHkwVjdCZlVxSFNJYnVJN1FEZC93TDZpTEZWR1RxWmgveDEwcGhi?=
 =?utf-8?B?U2MyQ05acGhKSlA1K3FzK00zNWlFWEd2ZGZxdUNWdFhNY1Z4Q21hYkFXQjVP?=
 =?utf-8?B?QnJ0NVBCT2VzSWVROTlodDUrUW9UTmt0a1lXeTQzNVFBZzAvWEZjZVIxYUdu?=
 =?utf-8?B?UUhVK1ZJcEJ3ZVRFbVBiK2IxaWdmU001b2YzYmFsUHF5NnF2RVNvUXV1VXVo?=
 =?utf-8?B?NXVuMFZKSTFkVHNBMUVCZFlqTVpSaTNESVY4UU5pdWxDcUJueXAxWElHUWE2?=
 =?utf-8?B?NEhjcnN4UldjOUxXb3puKzRVSWJVaGZmVHpUNS9VYk5LWWp6Uy96M0pZVlBq?=
 =?utf-8?B?SDlBd2xvdEJQNC80QXBJa0RiS0dnWlc4VVVQaUxxaXFVdldoYjlGRmZyUG1z?=
 =?utf-8?B?NysxZ3ZKQ2Z1V1lmUDA3Y0ZOYTFHaWM1bTNYeVJic0pNM3pGNStod1J3Rm5a?=
 =?utf-8?B?a3dJdVpIaGN5WmRqUGtYNk8wa25vZjgrcENzeGhDMzFZeUJKRXVHbkVGaWw5?=
 =?utf-8?B?ZVdnK1M4UkN2Rkg5dmk5VEgzSStraFVOSGZsaHNyNHBvejFURFh2TEEweXE5?=
 =?utf-8?B?STI5YkJzditLdEhOU25lV3hMWDI2OERPN1MvWnJHbm5jOEx6OGM3THhBa0tk?=
 =?utf-8?B?WCtTWTRIclBJNWtkQWlGY3VuZFZtZnVWNHh5cFk0L1U4TUVkbG5NVFZvUXVm?=
 =?utf-8?B?RHlhUUlkZEtkbGRyRTdBU0I1WUxFa0tTN1lZUUhWUTBndlR0NEdLSEpNYjIz?=
 =?utf-8?B?Sk04eVVtUGZhcEJCMHNmQ3BTNzhaOTRPTkFmUjYvaVZ5aVZnaXc4RitkWExz?=
 =?utf-8?B?RlNpZlg0YjhqWW9QS0JPUGFGZ0RJd1poRXBPZCtuUEpncWZmM2ZCSjE1S2RD?=
 =?utf-8?B?ZDcwWUJnNkdJUExFcFJGTU42SkFZYlZ6d1JPb01YWlNPZktWTk9QMFQ4c2FQ?=
 =?utf-8?B?TkZscU1yR3h3TkIxbUJ6bDB6OU55bFdQYzYraEhvRUJUam5HUEZqR2YyelZx?=
 =?utf-8?B?OHZKd1pCQ1ZlN2dRWDJiYUxYeHZ0R3hXU3RHdG9zcGlyeVQzM3RXTGdlVk45?=
 =?utf-8?B?UnQ3TkgwaDVIS0V3aUJHQ3BhS0dzLzNVWEI1dDFyRjltZitKaExrSUxrUjNn?=
 =?utf-8?Q?/53AP0xA/wGCGGCMxwhn2k7kp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ce268bc-074f-4dc2-aaef-08dc9c314672
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB8909.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 13:57:43.2165
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xKWCAeRO5XjRwa+qFS82VXEt/WHsvl1F7H6POnCSU7JnbhBoVzkrJ6SNYManlzTxGDSP4IZ3qGU5eL8lu/JHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7297


On 7/4/2024 5:17 PM, Greg KH wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On Thu, Jul 04, 2024 at 11:16:19AM +0000, Akshay Gupta wrote:
>> --- a/drivers/hwmon/sbrmi.c
>> +++ b/drivers/hwmon/sbrmi.c
>> @@ -3,190 +3,18 @@
>>    * sbrmi.c - hwmon driver for a SB-RMI mailbox
>>    *           compliant AMD SoC device.
>>    *
>> - * Copyright (C) 2020-2021 Advanced Micro Devices, Inc.
>> + * Copyright (C) 2020-2024 Advanced Micro Devices, Inc.
> Are you sure this shouldn't be "2020-2021,2024"?
>
> thanks,
>
> greg k-h

Thanks, I will check and update.

Regards,

Akshay


