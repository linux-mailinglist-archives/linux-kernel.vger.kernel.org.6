Return-Path: <linux-kernel+bounces-371865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D849A4171
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 16:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A23B1C24565
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 14:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632C64C69;
	Fri, 18 Oct 2024 14:42:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vYQkMIRX"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B3D42A97
	for <linux-kernel@vger.kernel.org>; Fri, 18 Oct 2024 14:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729262574; cv=fail; b=UELOtjeYhYieolcdkdMDh3MI4a4KoYjuPORtlc57u9wHzC0VAlzBtHt0f8zxizQfqMyDk43JiNKd96eft8B2My+qf/dKzgk2eiq057tt6/lOHHWQ6sQbXGTjPZbeJdr3igh9xHOVZoi3eS92RNh2LO0ZtH5dfav4dTpZ927ITc4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729262574; c=relaxed/simple;
	bh=NbIS/o/3QsEseK7EHZCdU3ISpXxdUP8tmU0uFNE0YI0=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yz8LvczWdmd5UKqmutj1GKhfFcbrIb5RKOvbHjPd8n6lOf42dZAsWhjwlcEeBHT2weNWUIvsv4atNHD4DU9GFnQdsdGW48H0uCOBpsZ16kfK5l/wexHP5WrYbKTmmNnL4bMiCbD+lpEru/c3XGvkd7Ji2rtJ3ddXc1lkxH5d6yc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vYQkMIRX; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k+WtoT+G+MWGyoTuD2Ks4rO/X9SlCB4V1NeKdoa9VLq+a3+jqAGHRPfM3UugsWTJLmKfaFLQxIfCe6L7+WNMe8etVwGshhiD10jcL5iQsoej0wt710LL4+FSsSYxQgX/c4C36OEw7ekY4XH7hvQejfEk/VX+wQQ3gEsZk77wWHw+ANQErlZIsrj2JGjQUtoNmYSdkk/YuhZGuHzA2Qv9qpOtgq6BBRUz2ds7FAY4LzaJ2yeLPLw9zMjL9UrYDHcTrBTtANEh7wWhcK4/K7v0X7pwafcT9eY7uIH+eDYs0QBjFPmduXnR8R4Ups/4y3Mb5aWhvCEuDw4rPWZMFvpPBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CkO5llrty+T1mOHJQDq592SQAM+N0rvMGb/sDoFkt90=;
 b=ejunDcZ6VB0VeR+LMlO78NX8SgT09fDNbXH3swVLl3hnq+Pk4/Gz99VCoVdezl2O/VAakh+p9x0XfDNBfk2klehWBjY+CJwdT9Si4kaaQWWLHhJt9T1RzH/Ssw4yDsWabDeQdo8/GDKZehg7CYYO7DHDJEzmTlYXblEpJUBTxJLi+tIwXcq4Zp9xzoUVISDvTd+jstPNWppudQu2VokpV8T8tXys7d2lc05R6hBvdERkpm+icogUuKg7uNf1XaLvo0S8jAaG1caVQpF1znA1YpiQxBb+Cdfd1XX9UjPW2biRZLURJhMn0jqanM4jZxnqL1uOe/3b2RkrTDf2VrVbVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CkO5llrty+T1mOHJQDq592SQAM+N0rvMGb/sDoFkt90=;
 b=vYQkMIRXd57u0aLviKw0IKbUxFsuwzNguXxta+0DT1XS/0y4VTuSlUwOGdpxnnhp7w0HLT3iuYDsOp7NgACaqFrYhxIF/N35N5kCIhYhUwxTI2EDvh7t6rEp8h6Byy78lKeQv1ltS+Xo1yv/Be5nNzaI3HkrBsZuzo/JMhGURJs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5070.namprd12.prod.outlook.com (2603:10b6:5:389::22)
 by SN7PR12MB7449.namprd12.prod.outlook.com (2603:10b6:806:299::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.26; Fri, 18 Oct
 2024 14:42:48 +0000
Received: from DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e]) by DM4PR12MB5070.namprd12.prod.outlook.com
 ([fe80::20a9:919e:fd6b:5a6e%5]) with mapi id 15.20.8069.024; Fri, 18 Oct 2024
 14:42:48 +0000
Message-ID: <02dc6915-d82c-eed2-af93-bc22ba72567e@amd.com>
Date: Fri, 18 Oct 2024 09:42:45 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v3 6/8] x86/sev: Treat the contiguous RMP table as a
 single RMP segment
Content-Language: en-US
From: Tom Lendacky <thomas.lendacky@amd.com>
To: Neeraj Upadhyay <Neeraj.Upadhyay@amd.com>, linux-kernel@vger.kernel.org,
 x86@kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 Michael Roth <michael.roth@amd.com>, Ashish Kalra <ashish.kalra@amd.com>
References: <cover.1727709735.git.thomas.lendacky@amd.com>
 <3a9a4f94fefe3b4ebb23a7dd3d33d9fd7a344ce1.1727709735.git.thomas.lendacky@amd.com>
 <4692a0c7-3eef-45c1-ba06-fa01b4f01d74@amd.com>
 <650dcde5-4644-b790-60e9-ab66d7ca5b0b@amd.com>
In-Reply-To: <650dcde5-4644-b790-60e9-ab66d7ca5b0b@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0076.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::21) To DM4PR12MB5070.namprd12.prod.outlook.com
 (2603:10b6:5:389::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5070:EE_|SN7PR12MB7449:EE_
X-MS-Office365-Filtering-Correlation-Id: 017939bc-5781-421a-5967-08dcef8322c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YnVld0lOSDdqNnVHSE91aW12SVhXYVlJYUV5UVMxOHJWK2xKd2RXbFE4SnpZ?=
 =?utf-8?B?RjZVUDhaM1A0Z3VhWXFaMDVURnk3S0hhR1VXendydHYxWnhJaGYxeEhIKzdj?=
 =?utf-8?B?OURac09RZlFzS2g0bmdRZmI3Tkdta252STVhU0NpV04wWEZKSjhWMjFCcjdo?=
 =?utf-8?B?cGszbWhONjZPcWhZanFaSm5pQmszYmd1dTV6SFVpdXRnM3R1WU9UUTlsbHZw?=
 =?utf-8?B?cWRpQXgzRXhNY1Z4Y01SaUpLNmVOM2NBR3BoQ093dnpBRldmSXhDUkswOEsr?=
 =?utf-8?B?L3VQU1U2RUNpa1ZRZThSbDI5UnREU0FZZU9jSXYzSloyQVZra2hVMDY2Snlh?=
 =?utf-8?B?emx1VFdTei9HaFNXTlhEbjBUditxNE5acEFDT3V5NldTWGF4MXlDNU9mUTFh?=
 =?utf-8?B?aUdnSjUySXMveW9sU21TZGFDTzZkQ24xNUd2OEdKL0YwUldsWXVOUmRXblhN?=
 =?utf-8?B?WkpMeDVMSFVtQTUzQWtsQldPNnFqKzYwZlFCUmplTmtVZU9JdkJ3M3czbEls?=
 =?utf-8?B?S0VYOVh1WUZqV3hReStwd0FiTkZJMlFOdHI3Y21hWXR4VEhzQXczUEF1cFNS?=
 =?utf-8?B?QWMvQzJPQm1PQ2craGpCcDhKc2VtV2xXZTZkNUl5MDVRRWNIYzBXVUJQbVB0?=
 =?utf-8?B?NkNFc0xxZWJiWG9nVjk4U1IrUHBXRmJpNmwvVUxXY3kwak4wV081UWw2Wll6?=
 =?utf-8?B?M1VQVWw1MTd2RTFuV05yVCtIUkl5elN4eGNVWXJmb0tmZzk1em9vV3U2Uk9U?=
 =?utf-8?B?R0Z4L1k0Q282ODB6ZG5VVThzczREbExzeCtzVEc1aE9sVXV2ZjR0ZFBTT2dn?=
 =?utf-8?B?L3hxOHpwMUJqNkxYcm14YjRZRzRUTDdRTzBHeitObU03QXdhbUp4cXN1K3FV?=
 =?utf-8?B?RUtBcHY4WFlxUFNMai81T1Y4MXFHMHBrdXh3R09MbFdBODdiZnBBR1pyMGor?=
 =?utf-8?B?VzFDdXoxL3ZZdU5panlvWmVDRm5XZjNiVHlINnJEVVdQMnhrUklKT3E5OGNX?=
 =?utf-8?B?ZlM4RXJmbEtLaFM2UjFxLzB0TllnYnVMRjl2VHI2QU1BWXVHVjU2cEJEY1RH?=
 =?utf-8?B?RjZOR1dONnZkcmFNcDhGM1JUY3NZTkdDYjR0c01RZnRGYVZLUlp5bk9mZDJs?=
 =?utf-8?B?WFlpQmNPalJGQnhWbTZzOCtkUkFjNjlLSVIzVHJXMDgxT2lSNytLV0FEWnVW?=
 =?utf-8?B?ZW4yL1FnWEo3eGd2ekpzNVIrdzdaWFpiR2p2YmRoeXBXTmxOeXlRaWRNamI4?=
 =?utf-8?B?S1RWRVgvYm5rSHhMY3VoOWtTekJXUEVlRWgzT08xVE51c0ZNdXdWZWZpNkJE?=
 =?utf-8?B?ZEp3RXJNUTZvNXNwVkdjNzdPZ2R4L05QRWhJUzJuKzhwaGdXbWxRQXBSMml6?=
 =?utf-8?B?SnZ5UGU5azkrc2ZOYW1jUnpjY3JHKytLbGZuNCtxRmZmcDZUQjdkUW9CYWtZ?=
 =?utf-8?B?OFdoemRVYmlPeDZQZ1VZUWl4RHFlUUtaYmdjYzhQdS9kd2dxcnlxU0xvRWQ0?=
 =?utf-8?B?TTRkajgyWnZhZE1aSWNxV250Y1VicDNLVTdLNVFhUWU0ckZacTlnUUg4ZlAy?=
 =?utf-8?B?ajMxSUU3YjBZb2tTeDNYSHJZUWs0Tnovak9tT1FDajEyVFp0KzBNM1VJRlV3?=
 =?utf-8?B?azJlSEZIZXlTK1Q5emhad1hUVmZBSktFSWJCRS9MZkJSU3NZQ09pM2phUmFX?=
 =?utf-8?B?ZE9YY0xjeDN4L0ZmTTk4dW1rUDJ1dG84SzdYVVorNVdMS3lzSmxUTGJHLzJR?=
 =?utf-8?Q?hUH2QSRxwdsRgPQ10R9lOvBLZQJPFZjLWnLsCwx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB5070.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUpFTGFFcEFrV1M3WTdzdGxLcVhTNnVCblNwZk9zNUhGVUcvbzNFdUg1WSth?=
 =?utf-8?B?SHJGS3VKOUlWRGo3UGNwRHlocC9pNVpSc0prVGU2T29BSnVLdkc0TVVEU3do?=
 =?utf-8?B?cnREMUFhVHpvcmhpTUZXTTNuZSt2MW5DSkw5d2FwTnoxc0lxS2FETzZkVkh1?=
 =?utf-8?B?dFRsOWFsR3pMNzVPT2Z3eWx4aUpIQjBvTmE0dWFRaWlUbXhTRVgrZ0xsdGxU?=
 =?utf-8?B?eUhhVnUvRXQ1RTVKWUFaeFQ0MWI5eERRSzlBelpNQTkvR0hjZWxtV01RZmFl?=
 =?utf-8?B?U0Q0QTFFY05ZWG1aWk9HNUNZZzJuNGRHQi94R3ZRa2I0UUpwbXhsdDdKYkF1?=
 =?utf-8?B?Rk5CQWtBOHJEMzE2QkltbThqbXhvUlJFYlZzNHRkQVdrM0xkdDhZRHNtaHgy?=
 =?utf-8?B?STIrQUt2d3VGbHNJOE1NZFpoRDhXcEZhS1ZzVlJxREhSSU5KSU0xMERZMDMz?=
 =?utf-8?B?M0lsRDFqSWpWMUxjUGNYNUZWUjBnZEd3eTVaMTdFaVVPcXZHdWQrSWRwbEN6?=
 =?utf-8?B?Ymd6OER2dmk0OU5IbHR3S1VOWllEa0dTdWVCS2dJZW1JdStiZENWNDd2a0ts?=
 =?utf-8?B?MUFJZENCdWc5enBFZzU3NFdIMjZoSVEzeWx2LzkxV1pXYm5BTHJFd1Nhd1Ry?=
 =?utf-8?B?ZFE2M1N6cXo5UUcveVRQSlUyNzVsYTgzSzNIem84NUl2cHFRL0J5SVFDQ29G?=
 =?utf-8?B?ZmpocHlEdGR5UzJLNDFkby8yZ2lpQ0doYWRKbEFyZ0U3OE5YVmMwckl4S2pU?=
 =?utf-8?B?YW04OWNKUEoyMVdaeEhYZ2tCUFlhckFZcjBKWkN6ZmJhK1FkM0E1ZFpLK2kx?=
 =?utf-8?B?RlVEbG45YUdhVHdiRTBwMzRONk96OUVpcmdNU29OUDE2QnNLbDFobWQrQ3RL?=
 =?utf-8?B?VjBvRU81WWhGL3ZWVm9GQS9FN2prYkd0ZWZSUml5d2syTVJmaUtkMW9tdmdL?=
 =?utf-8?B?cVFyck54WVpwSkJKWTVuQk5QaHVOWVlUZTJvMDRNSlIwNHZaTmhQMzYzeTcy?=
 =?utf-8?B?TDZuclZlSkpPak5xVFBYam5HNk96YVlkeXpUYnVqODRUUXZEekw3OExuTGh4?=
 =?utf-8?B?U3BwMEppNHRSaDd2ZE5CcEd1aDBpQkVDbUZITVN2U1diaVZ0NUNLRkh5b0F1?=
 =?utf-8?B?WEpWbG9NR1hiQmI5NTNnc0JqWW9jdzBRWk5wRW9wNHV1UWNDdHVyWWhoeGpj?=
 =?utf-8?B?RWtyN08wOGFIczJBYnRtLzN6RFhEcHkyaUFXRlBOOGhHc0l2RXQrSjRTenh5?=
 =?utf-8?B?NFVhWlB2WjYzOVptdS9hblFiSDNyQjJjSllxeTVyQTgycURVcEpBMHN4b1pv?=
 =?utf-8?B?a3c5TGJzVktEd01FcEZwa3lYOXhXSzF3UTl2S083eHlvbkJrZHlrYUhldnBi?=
 =?utf-8?B?aTFXRFp6RG5mbEFPb2QwWHZqUkRwTEdUYXhhbC9UVEowUnhFYnZFZUN6bWVW?=
 =?utf-8?B?cnpibkV3ajdBeGZ6dVRoeGM1ckFxdnNybDg1bkN4YkgwLy9qdXUxeEtLVGZE?=
 =?utf-8?B?bk5PUTExZGJTQmJjUXptMEtZQXhpTjZ6eURNTlhKck9CS0F3d0tEVWsrZE9J?=
 =?utf-8?B?RXRSSjdVbzdYVTE2RmVRZTVqb051WmhsejZROXRURHlFdlJwY2I1Z0ROajdt?=
 =?utf-8?B?aFErb3hMUGUrU1dGaEVHSlFqVHRzV2h0S21sZ2twMldZdDFSK1AvT2s1US9Q?=
 =?utf-8?B?VWRhbC9QWEZGOTlHa2FhaFN2ZXhrSkFDTFpab0Rkd1ljS1phK0JpV28wNU1r?=
 =?utf-8?B?aGN1Z212TisrMFhQZm1MSUpyOFF2YTFMT1RaK1cyNTZPZGtRejNVR1dicW9s?=
 =?utf-8?B?SytkT0VxZHMxN2NxWlB5MUQzYzZ3MTRJdUVaMFR4U2xlLzdyZEFwNXRGR0Vr?=
 =?utf-8?B?MGxaQjhEaVJEUm1UUDhVRG90VTBEWnhEbUg1RFA1Rjk5anhiTjBxdmh1RTZY?=
 =?utf-8?B?ZFpqd2h2U2I2UWxaQ0JBVGNtQzk2aU1ZSlVtL0c1dUJZSEdrNFlnbTBpdkh3?=
 =?utf-8?B?U0lqUjhDRjc1R2FoY3M4WG5yZGJhSnV1akRuU256UXNrdjUwdExUZ3ZUaE4r?=
 =?utf-8?B?clJzcHJwb0tzMDEzQlJnRzBTVnhSU0psVmJ5S3VTbExIbGhWYWZuajRFS3Fu?=
 =?utf-8?Q?ydUsmVDpAB0epqOkStrGeDAFY?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 017939bc-5781-421a-5967-08dcef8322c2
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5070.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 14:42:48.4391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zcubpBoYU8+s2FTBjMFWx7Czycba7Yigkm6wxqlaH3PgaI5AnLoXdCe/Sxp5a0xy9stUrPpfWXv6BnMfH79Z5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7449

On 10/18/24 08:56, Tom Lendacky wrote:
> On 10/18/24 00:59, Neeraj Upadhyay wrote:
>> On 9/30/2024 8:52 PM, Tom Lendacky wrote:
>>> In preparation for support of a segmented RMP table, treat the contiguous
>>> RMP table as a segmented RMP table with a single segment covering all
>>> of memory. By treating a contiguous RMP table as a single segment, much
>>> of the code that initializes and accesses the RMP can be re-used.
>>>
>>> Segmented RMP tables can have up to 512 segment entries. Each segment
>>> will have metadata associated with it to identify the segment location,
>>> the segment size, etc. The segment data and the physical address are used
>>> to determine the index of the segment within the table and then the RMP
>>> entry within the segment. For an actual segmented RMP table environment,
>>> much of the segment information will come from a configuration MSR. For
>>> the contiguous RMP, though, much of the information will be statically
>>> defined.
>>>
>>> Signed-off-by: Tom Lendacky <thomas.lendacky@amd.com>
>>> ---
>>>  arch/x86/virt/svm/sev.c | 195 ++++++++++++++++++++++++++++++++++++----
>>>  1 file changed, 176 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/arch/x86/virt/svm/sev.c b/arch/x86/virt/svm/sev.c
>>> index 81e21d833cf0..ebfb924652f8 100644
>>> --- a/arch/x86/virt/svm/sev.c
>>> +++ b/arch/x86/virt/svm/sev.c
>>> @@ -18,6 +18,7 @@
>>>  #include <linux/cpumask.h>
>>>  #include <linux/iommu.h>
>>>  #include <linux/amd-iommu.h>
>>> +#include <linux/nospec.h>
>>>  
>>>  #include <asm/sev.h>
>>>  #include <asm/processor.h>
>>> @@ -74,12 +75,42 @@ struct rmpentry_raw {
>>>   */
>>>  #define RMPTABLE_CPU_BOOKKEEPING_SZ	0x4000
>>>  
>>> +/*
>>> + * For a non-segmented RMP table, use the maximum physical addressing as the
>>> + * segment size in order to always arrive at index 0 in the table.
>>> + */
>>> +#define RMPTABLE_NON_SEGMENTED_SHIFT	52
>>> +
>>> +struct rmp_segment_desc {
>>> +	struct rmpentry_raw *rmp_entry;
>>> +	u64 max_index;
>>> +	u64 size;
>>> +};
>>> +
>>> +/*
>>> + * Segmented RMP Table support.
>>> + *   - The segment size is used for two purposes:
>>> + *     - Identify the amount of memory covered by an RMP segment
>>> + *     - Quickly locate an RMP segment table entry for a physical address
>>> + *
>>> + *   - The RMP segment table contains pointers to an RMP table that covers
>>> + *     a specific portion of memory. There can be up to 512 8-byte entries,
>>> + *     one pages worth.
>>> + */
>>> +static struct rmp_segment_desc **rmp_segment_table __ro_after_init;
>>> +static unsigned int rst_max_index __ro_after_init = 512;
>>> +
>>> +static u64 rmp_segment_size_max;
>>> +static unsigned int rmp_segment_coverage_shift;
>>> +static unsigned long rmp_segment_coverage_size;
>>> +static unsigned long rmp_segment_coverage_mask;
>>
>> rmp_segment_size_max is of type u64 and rmp_segment_coverage_size is 1 << 52
>> for single RMP segment. So, maybe use u64 for rmp_segment_coverage_size
>> and rmp_segment_coverage_mask also?
> 
> This is 64-bit only code where unsigned long is the same size as u64 and
> is typically preferred when dealing with numbers like this, which is why I
> use that here. It does get a bit confusing because of the use of u64 and
> unsigned long but I tried to keep things in sync between usages of the
> same type as much as possible.

But let me see what everything looks like if I unify all the fields to u64...

Thanks,
Tom

> 
> Thanks,
> Tom
> 
>>
>>
>> - Neeraj

