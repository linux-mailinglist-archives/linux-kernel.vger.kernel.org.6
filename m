Return-Path: <linux-kernel+bounces-231520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76392919970
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 22:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED3F61F2135F
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jun 2024 20:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106D0186E38;
	Wed, 26 Jun 2024 20:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="D44TiDP9"
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2136.outbound.protection.outlook.com [40.107.223.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534DB8F47
	for <linux-kernel@vger.kernel.org>; Wed, 26 Jun 2024 20:50:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719435053; cv=fail; b=qOjFPiMSV5ybLaNKbtNKutnfbWS84bP4ita0y/ms6r8JWe61A6lo4C7n2D+DU3BYTZm63KhEhM9zzSKEAUBmiY41s9kPmVlqDGgvWGEfC/DtJAN15N+pnQvD7rLDRd/jhuasXYB/wj8P/e75xSKQTZuqZAhDC2D4nDXbfNvQUFo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719435053; c=relaxed/simple;
	bh=11sQb1IeAGV6OZtMgbuVgqX2dnPvizdMWuE5c91CKmg=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=npEWq1OAPlPBS0RKfhE/IYaez+13pIvepVrEk7Bc/Fmn+gfbjG3uEw0ncD97r1aO53oto9wMt0TyFDMeRy9xSgU+dKvPFV4ZY0QUIwAcMbac2Qbnwr2+23tNoAimjmOjTgMQJNVPJdsJEMdJZuCKV0PNVw38VKFlVg62YuyfeOg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=D44TiDP9; arc=fail smtp.client-ip=40.107.223.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yo/WOIja7eknJBOLfHNA7nN3qO+zZL0Gk4biun4+OTu/bzNDv7F9RKW0y/27a0TwLPI4atuxz+6j8+E3YORRosRN9SQOJTpDo19pifybbRrEM85N31pbf+7A3G5DNMDEEAfxZm0y1l+cKwJT0bppRvWVHu3DQYjB0tpCOz4xws5o9cXqo5aJyiLTGma8qG4NEF35Sri8NURjzoC5Ghs2HF+vISO4t+LtgJIf5m06TTwD6E/dQxhTqWtoA6lOWnRLgVW/hyToSJLa5rXT69HWYxbgL7mtNbv7HmznkanYD/nRcDaQ9Hm2lZZ6HegjIm1jARgxrQHcYfCRYlUlu4CB/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GHe711pTtCcChc6yuczzkBTfrM5zzebWzxwH54NrthU=;
 b=lHKrC7hgaVNb/Epb6IswPHcmoKLfxzDwm1D/pgukMNhkPPxhFvR6DZ1HorX9cX+DrBIsKKoufDrDh14SWVqWzQVuLr1cE7RagSloytBG5OXlvBuPCjFBuhrMzcyUuQmLu3VUmq0TYSn9wsLReRAn6DblsOrkRtJd3mvr4RBXjHxiDc3bjRq/JeSGuaTNeGaFvRnUpJMzyd+ukZTLSet8Fce/3kKHTNUbKiJ+HkaDNRIcrPd022BSc4PGIZ21cRLfpHI4UIPOdwqk63hZmsIoEzPYoIUyyOIw6GDG0XALMFm/bhHBHZo/ZA1LwSarrOIfGQnklDeR7iT0KERYmzcawA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GHe711pTtCcChc6yuczzkBTfrM5zzebWzxwH54NrthU=;
 b=D44TiDP9QrsPxAlRk2Qlul848rmnqsKOJVwPvlhaMQXe2sjeOAL7hPNNIORDGAVMMTYrFKWiEsCSztCGdkR2yV4a0FAhut+WjJa0a7mtucpWp4A2uKW5YjFGQaYjP3k0VDUs+Rv+jEp+y78iUeCxCqt0HUfJ4Ze8A96bFnSLYoc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 BL1PR01MB7697.prod.exchangelabs.com (2603:10b6:208:394::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7698.32; Wed, 26 Jun 2024 20:50:48 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%3]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 20:50:47 +0000
Message-ID: <48da90f3-0136-4d28-be6a-659726c3a2c2@os.amperecomputing.com>
Date: Wed, 26 Jun 2024 13:50:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [v4 PATCH] arm64: mm: force write fault for atomic RMW
 instructions
From: Yang Shi <yang@os.amperecomputing.com>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: will@kernel.org, anshuman.khandual@arm.com, scott@os.amperecomputing.com,
 cl@gentwo.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240605203723.643329-1-yang@os.amperecomputing.com>
 <Zmw1jltdkMrTrT_l@arm.com>
 <3cd0e716-73bb-4ccd-a47c-753f6141a16e@os.amperecomputing.com>
Content-Language: en-US
In-Reply-To: <3cd0e716-73bb-4ccd-a47c-753f6141a16e@os.amperecomputing.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR15CA0006.namprd15.prod.outlook.com
 (2603:10b6:610:51::16) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|BL1PR01MB7697:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a6d07c3-799a-475f-a370-08dc9621a80b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230038|366014|376012|1800799022;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Z1hqMERISmM4am9NVjZINVlVWmZXTHIxVWFUVjMvTUdXZThnVGp1RHlNS1Z5?=
 =?utf-8?B?bGlyZHdDSTNjbGhhb1lkT21ZQ2lOYUllOERvQU1rWWNET3VvaWNkYy9MbmRL?=
 =?utf-8?B?L0lyVDNSTEwvZUdrL3BkQzRORFpySGJGVjVTSFdrWVJEQ2NUemY1YjBNbW1B?=
 =?utf-8?B?WCtnM2pRY28rTklObVJxallvN3BTcGNZRjllOXVsMXRqWGdsZ1J3NmtsenN0?=
 =?utf-8?B?M2kxbCtLVi9FVTFYcmk3NkR5d05zVmNxU0VqWXZpT3dhQ0RINXpPNjF3KytZ?=
 =?utf-8?B?Z0d1amlYM0t6cWUzMnRXYjh4OER1emk0KzRYcWc3ZkhTdXJWTmNNRGtOZ1lV?=
 =?utf-8?B?M3N1eklUazlPZ1JXOFpHNnJhamxEbjlTWW83RXZxbjBUbTNZcHFqS2p0MDBj?=
 =?utf-8?B?Sk5yMXE4MnpEaVlDeEJySmpPVUhuRytMRUMwbmJQNXhpb3hOaVRrVjQxN3NH?=
 =?utf-8?B?OEJBbXBVY2lCc3cyRmNvRFJXbG5QWkVDRmJ5eS9kTzJlcUtrM1NvN003UEpw?=
 =?utf-8?B?ZnBOWE0wTG9Yb1lNWVFyRk9NRlZiRTRvdGFiRGxGK0E2MHBQQWlwenl3ejc5?=
 =?utf-8?B?eDBEc1FIYi9INEZ6aUlId1NzR21OSURFbzRsZXNTWWtIZ2ttQTkrWGQ1bDc1?=
 =?utf-8?B?Snl1ejRJZWNaYTdoR0xIVGpjSlVheHpkSVRuTTB1MGNhNUZBY0tESlRYRGlK?=
 =?utf-8?B?dEhEd3BvWVJxTUc3NzNXZGxabXdmelBIemtkZ1BIRXhLMnQvbzU5ZlJCazBX?=
 =?utf-8?B?RmZIUlcwY0ZCT1FEQnFhd3k2enJUT0lZWTJVMnZrRm5xVzByRE1XdHNOaXpa?=
 =?utf-8?B?VTVBNGRGQ20rV3d6UXcvRERNa0RJVUQrK1NpaUhZL1grWXRYeFVjS3NLQklu?=
 =?utf-8?B?T21DbDVaOTJLUnNDbG9lTGp1OUJkdVMrR3E4Y1lJU20vSjlaR29MbElUZG0x?=
 =?utf-8?B?UGhVMDBvNFBEaXhmMVJzcm9xTkhLemJaeWtYNStiOWUzK3owbjdQdW1VYStm?=
 =?utf-8?B?eGN6Tk5vWEVBZWsrN1MxZWhyOFdzWklTWHoyTnVibjhpSExXRXJZWFdZTGcz?=
 =?utf-8?B?QnpvNTRrcmhaOXRpSEFsZEZSU2R0M3FMSTVBUnk2cWJFdVdNUTgrS1pnWHN3?=
 =?utf-8?B?T3JmemY4ZGNsOXY0QUdSMmxRQkVXRi90dmo4aSs2dWp2RTh4dFpydUVSTTds?=
 =?utf-8?B?QTduOSt5cS9yMEozTDhtbTJDTzRMRFVwMXBXVVB2TkN0NVFuU3o4YWZLWVhz?=
 =?utf-8?B?R29KNThKUTJWY1JKZnpXUWoyV2Fkb2xPN1kxTXpvM0RyNkRRZDhiVUU1WEU0?=
 =?utf-8?B?c0kyMmREZVBMbXNrdE54aE9PUUNvQzdERmk3eDRNNjNtbEFVWUFJM2RiUGFJ?=
 =?utf-8?B?enNMNmlaQnlPNDZzSUpiamY0N3BLanBzOGVwbnZ3Zkg0NmExTDhuNHIyWE8z?=
 =?utf-8?B?ZFNONjJyaUR0NTBqQ0NRbzBQR1J4Y0w2VkhveHl0cGJwM2pKR3g2alEvMW1U?=
 =?utf-8?B?OEloblg5bFNNVnRWa0FhNkZkL0RBa2tlM2xNRUpvVGxGSS8xT2NGQzJ1TXNF?=
 =?utf-8?B?czhaRXMvV29QR0dwdmluVENUL214SC8zSU04Qm1SRWdiaXRqUmdBZlhQM1dY?=
 =?utf-8?B?eUhWU0Rua0JRUWt5dkxJdHc1cWxDQmRGL2lSSTJzS21wZTNiVGljOUNmRlpX?=
 =?utf-8?Q?WJx0jjyqDyezr6JWb1vn?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230038)(366014)(376012)(1800799022);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UjZ0WGpiMUhZWVI0KzBKZmNiZ2FjbkQrbWtEaW5YTG9xZzVFY0hkYlNhY0pk?=
 =?utf-8?B?TENYcFpIeTU1R3E1Q2lwdVUrb3hNSG9sU3N1WHZjNlNlaSs1ZUFDSnRmTTdJ?=
 =?utf-8?B?SGdaU2J6SjcxYUNnM0JvY3BLNXB5cHpiRy9DTGVtb2dBd1V0VWw1TG9BaHJN?=
 =?utf-8?B?dlBIcHBVcHJyOTk5ckRUcEdHZGZsUzJGS0h2OVA3QXRYMXppMXd6OTZZN3Ir?=
 =?utf-8?B?ZWxQSVNUUzhXc1dVV2tzUjBOVkJhdUxrSDRoNlY0RTEydjlqVHZjR2FXbi9X?=
 =?utf-8?B?N2dwTnR1Q1lJWkExeHNvWjlZSnB1bFg4RmVqTjJIZkFWZjJYUnVieUQzTm5w?=
 =?utf-8?B?TkNrdE9BcTRBbUpsVjhwU0UwbzlBblJPbkx6Vm5ET2lHak5VcEpldjJBcU9K?=
 =?utf-8?B?ZzhyV3BLUHI0YTAxcy8xWER3VEZOSVVuTXhtZ0FmeVpndWtybk9OQ3FZRGNy?=
 =?utf-8?B?dlJ0SG9vbldxQXc4akljV1h5WmtVait1NnZPUTZ1NDRaVmFFNWhnRS94SlBu?=
 =?utf-8?B?YjgvVVBnZzhCZXdvM3dzMHlqZ2hiVExwbEZiTFBKd3dNM3FoUTdOZHhYRlRs?=
 =?utf-8?B?cnd3cmhFcUpKcGEwcm9pU3FjSFQ1dm5XWFZ1amNKdEhLUjFKV0REaHdNS1Vv?=
 =?utf-8?B?dXFoL3pRSVduZml5VVJiTE9tRmxnMU41MnU1WlhHMkpuV1IvNmZETUxwQmdp?=
 =?utf-8?B?VWx1cXk3eWJHZXk3c0cyZFVOMUc1Y0cvZDZLdFkva2tseXdTZDBoMXl2TGlu?=
 =?utf-8?B?WVdJaFF3WUw3RFZ2UFoxb1dlcUx0ejNzeUNOa2lFZW1KSHVvNU4wd1dvdXJ6?=
 =?utf-8?B?eGRRclFMR2xvbVhaR1JNT3VaamxPTGxFOU8weC9IcjQraHMzSVNOWEZ2WklS?=
 =?utf-8?B?UWJYbkR6eGZPc0V5V1N3dUNqRnRPK1VvQnZYaVFlQlhST3pFWHR5a09iK1I1?=
 =?utf-8?B?SnhLNkFRWjBya3lSeWdXd3FTUlZUeC9uTENjQ1VtbVhXSXNPanFTU1BoOEVv?=
 =?utf-8?B?aUFFM1BLcWZGSTBPazVTSURGWEJsY09PUlc5TnZnUVpJdzN0SkYvTmV6d3Vh?=
 =?utf-8?B?N2IzUFdEZmdsZ2lGdkwybUNpazZybGV2dEFzb1cyRGdmYkU1VEVLajBFVTJQ?=
 =?utf-8?B?ZzVJVEVkOVNBS1NCTzRLVlptZHFGckVMK3VLcUV3NUJpQUNjbWFPSnhUV0ph?=
 =?utf-8?B?THZVZEhma3pRNGw2Ull4K3d3cWc1VHRGYnd1NXpDREVYMEJwU1N3cUUvb0pO?=
 =?utf-8?B?RmhPVEJDcEg1UWNldzViU1hCNGlMV1A3R1pOSXZGYWxyWEt0ZjAyV2hrVDh3?=
 =?utf-8?B?aTluc1dsZ3g5czhQQ3I0Z3BZdktaMnZrUDZ6RmVSeXZVZjZEQ2krbFZOYUtH?=
 =?utf-8?B?K1dyZ0VzRDQrbDA0c1h3ZVc1UmVLTStsRGZNV0J4SHh2Sms1aS96WkpGMG9i?=
 =?utf-8?B?cU9lVW9ieHgveEdndEJtOFdyLzg5ZHhkQVNMbVJKdUVHdDFiQ3B0QnBTOFJT?=
 =?utf-8?B?SVQrZXFSK0VaMDJlUE9KSVRITjRvWWhtRWtadG5kSVlld01QaHNmcEo5aVhu?=
 =?utf-8?B?K1l3R3RmMlVDNlVZMm5XYklCS0NTRndMRmdXbndLMGFPdHY0OExLZUdYa1JJ?=
 =?utf-8?B?TmxGUlhQNTlzNzlYS2tNbUNuY1BMWXRvSWcyTkhXRnBva213MlUySVg0RlpK?=
 =?utf-8?B?V2VJd0VYakQ1VW9EeWZ0NHhEVnJEallnZ1BTcGlCUzlYWVAzZ3FEa2VWRmlT?=
 =?utf-8?B?TWcvOUtZN2lwVXRQYnJadFhmTEo2VDd4N0ZWbldsb1RtSFhWaFd6RzUyVWtn?=
 =?utf-8?B?WGViRGk0d3A4K21sQVl6TFduVkZFZ1B4VTBybWd4OEVzU3gzR3UxcENkUEVr?=
 =?utf-8?B?M1FQVnZkeVVJenhuZ1kxYWJhSkw1c0FqQzVUbUROSGFoSzVLNU9QRU1vK2Mw?=
 =?utf-8?B?citBVU9mVlNzWWo1WkFEbEJUbzc0VElEWnI0cEJXdDNaaXczZXRGcFZLZWUv?=
 =?utf-8?B?TC90ejAycGJkbmdzdjR2dWg4bzFJQnZjcUMvQTE2VVVqU1ZZTVNZOFUvTTFu?=
 =?utf-8?B?b2ZtMW1SL0p3bXRwRHA2OEk1dDQyaUh0MnBuUDl3YTUrbllTTGVFelNCNHg0?=
 =?utf-8?B?R0dlb3RLdytORTI5TnlnNWtjVzRWa3A0ejQ4OVBRUmdaMFNOSWVZUHlFRHZh?=
 =?utf-8?Q?CHzpQ/0R946+kTeRKfpL82Q=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6d07c3-799a-475f-a370-08dc9621a80b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2024 20:50:47.8043
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nF2A16GhEASnkrSxMe3UVUNWow6RTg4a0K04VJpKm9gO9WLaMsv7+Qnp4KJ8He2bzQmZxMbCbcxtgiIWkq9RdTJqa1uVa5K501Hywg8bRRU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR01MB7697



On 6/26/24 11:45 AM, Yang Shi wrote:
>
>
> On 6/14/24 5:20 AM, Catalin Marinas wrote:
>> On Wed, Jun 05, 2024 at 01:37:23PM -0700, Yang Shi wrote:
>>> +static __always_inline bool aarch64_insn_is_class_cas(u32 insn)
>>> +{
>>> +    return aarch64_insn_is_cas(insn) ||
>>> +           aarch64_insn_is_casp(insn);
>>> +}
>>> +
>>> +/*
>>> + * Exclude unallocated atomic instructions and LD64B/LDAPR.
>>> + * The masks and values were generated by using Python sympy module.
>>> + */
>>> +static __always_inline bool aarch64_atomic_insn_has_wr_perm(u32 insn)
>>> +{
>>> +    return ((insn & 0x3f207c00) == 0x38200000) ||
>>> +           ((insn & 0x3f208c00) == 0x38200000) ||
>>> +           ((insn & 0x7fe06c00) == 0x78202000) ||
>>> +           ((insn & 0xbf204c00) == 0x38200000);
>>> +}
>> This is still pretty opaque if we want to modify it in the future. I
>> guess we could add more tests on top but it would be nice to have a way
>> to re-generate these masks. I'll think about, for now these tests would
>> do.
>
> Sorry for the late reply, just came back from vacation and tried to 
> catch up all the emails and TODOs. We should be able to share the tool 
> used by us to generate the tests. But it may take some time.

D Scott made the tool available publicly. Please refer to 
https://gitlab.com/scott-ph/arm64-insn-group-minimizer

We can re-generate the tests with this tool in the future.

>
>>
>>> @@ -511,6 +539,7 @@ static int __kprobes do_page_fault(unsigned long 
>>> far, unsigned long esr,
>>>       unsigned long addr = untagged_addr(far);
>>>       struct vm_area_struct *vma;
>>>       int si_code;
>>> +    bool may_force_write = false;
>>>         if (kprobe_page_fault(regs, esr))
>>>           return 0;
>>> @@ -547,6 +576,7 @@ static int __kprobes do_page_fault(unsigned long 
>>> far, unsigned long esr,
>>>           /* If EPAN is absent then exec implies read */
>>>           if (!alternative_has_cap_unlikely(ARM64_HAS_EPAN))
>>>               vm_flags |= VM_EXEC;
>>> +        may_force_write = true;
>>>       }
>>>         if (is_ttbr0_addr(addr) && is_el1_permission_fault(addr, 
>>> esr, regs)) {
>>> @@ -568,6 +598,12 @@ static int __kprobes do_page_fault(unsigned 
>>> long far, unsigned long esr,
>>>       if (!vma)
>>>           goto lock_mmap;
>>>   +    if (may_force_write && (vma->vm_flags & VM_WRITE) &&
>>> +        is_el0_atomic_instr(regs)) {
>>> +        vm_flags = VM_WRITE;
>>> +        mm_flags |= FAULT_FLAG_WRITE;
>>> +    }
>> I think we can get rid of may_force_write and just test (vm_flags &
>> VM_READ).
>
> Yes, will fix it in v5.
>>
>


