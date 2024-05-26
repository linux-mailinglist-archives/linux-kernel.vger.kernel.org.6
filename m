Return-Path: <linux-kernel+bounces-189589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE5C8CF28D
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 06:55:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31A2228151B
	for <lists+linux-kernel@lfdr.de>; Sun, 26 May 2024 04:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D78A1FA5;
	Sun, 26 May 2024 04:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ExO/CHVD"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2084.outbound.protection.outlook.com [40.107.244.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D361C17D2;
	Sun, 26 May 2024 04:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716699309; cv=fail; b=gOgIpckxTte2c+SU1AwdU1hJUw8Zvtc58Uf/FHBdKXbSTRNsAlI8xtj1TRXL27ZigR+wG/Azjekd69+47lr0PCC2lv6haPtNbXVOd/nKL1ZLkkJ8uz7fOqWg2QtaWIzm+JtmgO8l6xVoBxVuwDjos1jCSN5a7zt0sN9zVAqIkzM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716699309; c=relaxed/simple;
	bh=n8cT7xlcVYcOBr2hsVu+5WRwaFejyKSvtRQt0hqC8/A=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ue/KQYcUPHwUY01ZkkG+oLzr3yxST8GKY1cJy70a/3vB0DjTtcmPtVLVTmzUriKVjAdR0lgFRaG0Voq5//YSFBw8syrgkz3Qxq/uSR9UaEL3F1bnIj5g89D9jYZDspT8FvDaiAL2FydewQTz4CbQuM49dm4AruTaPwkbeMbhYIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ExO/CHVD; arc=fail smtp.client-ip=40.107.244.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E9zVfTGtaHxY7pmH6qI9ue8B6lFKuEBVR4G+an9F4U4CqoLeFhQ6Ah7bQG2lDDcgulNkXHoail9DIgDqjvGy6zthEChEpERpQibo6Kc+LaihtmYVqQgnXYXMR/J+GVHYxasv7eDjJ8wAo3s4ahs1uoIQCCR5Gwak3kj8QXUldCRIHkjOZ2sLrRGeg61OKzaaoEJ/MgQ3Qg3a3wUSyMZ/JEQ0vuZO+cWPRsfppVgmDTFHeLleYah7PuG5psr8IwgQiF68mmvKIOd85A7//I2tUrvYzIFEHQgZnVChI+RIgPqED+f+bchcioTEj07vpGDKGWBN5xiPMXOLB1TtcBhZ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qZX8+3yFbdiKMLlpJaQ55amxLlOBdXQ81Bd2qdBsB+A=;
 b=btxzpY37MjPi3T3pDr5V9GnZEaaGtXF+Wf6MoB1rQfhGsaXNyoxGeJ4pSZY3mAEfeK6dG5C4z55ljjJUIkFkgNziNX46qndMOkW3qRd4sgWDBNfM6VUVF0E4GztglNIYGGyMUt3yZESI/36Tcm7OdYP4eOYYgLEQPU6uPjgR2ICGQjG+cEoyxxS6KWqAME5IeJDMU3dxZkBX88xXdNGIbtnI7fa2Qn9q7AEZhb5dYu+WEQn+25NF5P4l9pBpGl/sI4BpIna/Kj90cjm3j8+7hl6fL9a38HU+VQcNOkvjdn2Jh/IVr40YjEofK5O4uJUgOHDuyWXBP6ZeImyqGI+HFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qZX8+3yFbdiKMLlpJaQ55amxLlOBdXQ81Bd2qdBsB+A=;
 b=ExO/CHVDrFapFwZIpj6AMI2qbK1GoGsJH2x8HWCFOtSKMzRouKZjLitC/0WZZO7Lq2d0sAGGDVDNLRrKTCdrau3JTSDwplLtSEAa7XDEkyOs+wuQJs3CIypiWK/+vwF+1bvic/zVU0VBa7A94S0dvGItyICGiXluaSVeSDUBrMI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ1PR12MB6124.namprd12.prod.outlook.com (2603:10b6:a03:459::15)
 by SA1PR12MB7411.namprd12.prod.outlook.com (2603:10b6:806:2b1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.28; Sun, 26 May
 2024 04:55:03 +0000
Received: from SJ1PR12MB6124.namprd12.prod.outlook.com
 ([fe80::c15b:b99d:8d9e:fb25]) by SJ1PR12MB6124.namprd12.prod.outlook.com
 ([fe80::c15b:b99d:8d9e:fb25%6]) with mapi id 15.20.7611.025; Sun, 26 May 2024
 04:55:02 +0000
Message-ID: <664e101b-3689-4876-825b-a5aa12b7978f@amd.com>
Date: Sun, 26 May 2024 10:24:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] x86/elf: Add a new .note section containing
 Xfeatures information to x86 core files
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>,
 "Balasubrmanian, Vignesh" <Vignesh.Balasubrmanian@amd.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-toolchains@vger.kernel.org" <linux-toolchains@vger.kernel.org>,
 "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
 "npiggin@gmail.com" <npiggin@gmail.com>,
 "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
 "aneesh.kumar@kernel.org" <aneesh.kumar@kernel.org>,
 "naveen.n.rao@linux.ibm.com" <naveen.n.rao@linux.ibm.com>,
 "ebiederm@xmission.com" <ebiederm@xmission.com>,
 "keescook@chromium.org" <keescook@chromium.org>,
 "x86@kernel.org" <x86@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "George, Jini Susan" <JiniSusan.George@amd.com>, "matz@suse.de"
 <matz@suse.de>, "binutils@sourceware.org" <binutils@sourceware.org>,
 "jhb@FreeBSD.org" <jhb@freebsd.org>,
 "felix.willgerodt@intel.com" <felix.willgerodt@intel.com>
References: <87wmo4o3r4.ffs@tglx>
 <4a090901-9705-40aa-ac3d-d67c52660f22@amd.com>
 <20240522153433.GCZk4QiX4Hf0OuI48E@fat_crate.local>
 <902b1bf0-15e6-42df-8f86-21387deef437@amd.com>
 <20240523144543.GDZk9WlwKpCKx8I3RE@fat_crate.local>
From: "Balasubrmanian, Vignesh" <vigbalas@amd.com>
In-Reply-To: <20240523144543.GDZk9WlwKpCKx8I3RE@fat_crate.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0067.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::7) To SJ1PR12MB6124.namprd12.prod.outlook.com
 (2603:10b6:a03:459::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6124:EE_|SA1PR12MB7411:EE_
X-MS-Office365-Filtering-Correlation-Id: bcf36095-be1a-457e-d7ce-08dc7d400088
X-LD-Processed: 3dd8961f-e488-4e60-8e11-a82d994e183d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|7416005|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEE0ZThENWJHRkpjR3M2SVJjc2drVUJJK2s2NXdUZXpLQ2lZVkV2MmFjNkpt?=
 =?utf-8?B?ZlF5NkdKRmd5RWN3cEJNdVBQanE5djFkdENseklrVzdubmVrT21kZzFBUlY2?=
 =?utf-8?B?Nk1hYWdGdnpwTHBxRVhYY0IzNVcveDJOTDZBajljeUQxZFRsdzBKMkhYYVph?=
 =?utf-8?B?QTc2bW52VFFYVlhUb2lLNVkxTFJhS2Y1WlFidDhtZktaVVQzMWhiV0gzVFR6?=
 =?utf-8?B?VzcwNEVsRWhqSS9wMzhKSHhhNWdQK2loNWRwVVdFdTB4T1hhRmVkNHVTZGln?=
 =?utf-8?B?N2RNRWlRSE55dC9OdGFPTU9vTUV3cUxta3IrNEFxUU5jalFqa3k4L09nYmIz?=
 =?utf-8?B?b0hhMEN6ZnBzMllaQWlMUHNIODREVHltZTJjRzVtVHJ0cHVNdTM0UFlvYWhl?=
 =?utf-8?B?dUlZU0FONTMyRDN2bGRVcWNqWUFxT2Y0clJwUy80NkU4MlRuKzRKOEFEWTdV?=
 =?utf-8?B?MEhxMjJJS3J2RzFtNlYrYnZSUTFPdldaZnBwYmM4aDFPMjliYXFJR0JzNzJm?=
 =?utf-8?B?bVBQR0d5and5RUZ6dlhFWm9xVmtaalBNT05MWjZES0JlelQvemNMcXh1QXFx?=
 =?utf-8?B?TkNvWGFjSUpLQTFJKzZrU2ZnUVdjZzVRTjRnbGhDVG1PMjkxRmsrYnZJSG9Y?=
 =?utf-8?B?bjZ6Sjd1amt5bm5reEx2TTVScTZtU0pIcnRoVkhNeVVTa2pzZWhiMktIa1NS?=
 =?utf-8?B?RnZnMVFGM3ZIL3A5bzVwdU1mK0l5cjM3ZUtHNHRkTW16SHN5ajlhNzJVS29z?=
 =?utf-8?B?eURGcUJiSHUyU29HK1RtZE9maVlOQUJxS2wvNUZKUFJyWTZKMDZnZlZGRXBX?=
 =?utf-8?B?bllvems2djQrUVQ5N0dlNm1jdTB6TW80UCtzSTUyeDRWenNnUWlic1JhazVC?=
 =?utf-8?B?WTdlaVBXdnFzN2FnYVJMSDJBcGJBRWdQdldFUEVrYkFzRStsaXc4T1ltQ0JH?=
 =?utf-8?B?TnovQVluZjZNTm5yWENYVUs0VjZ4LzhJdFlweXRabE9ncXVDcDQyT2x1S0pP?=
 =?utf-8?B?dVRHa2NlOEVFK281RUY3U0NDRHBhZXhpcHFVaEU5OHNLdlJKUWhLVGhrL21p?=
 =?utf-8?B?U2tyRmZrdnkvd29BSE1JMzlpd3FBUzl3akNpYVhhOCtCNkRUMXdPdFhOUlpa?=
 =?utf-8?B?cnErNzRZR0hyVmNuUE1vNmJTaURvalZ3cEFtQWJxYkdkLzlERnFVK2ZZbHRP?=
 =?utf-8?B?bllqdkdDZTR5d2FLdDdKajRPL1pRRjhSL2VKeXRZOU10dEx5a1hEU2tUUzho?=
 =?utf-8?B?cGZRMXZIT1lHS2Q1RUZKVXE0MlpEVjVyalA1aTVQeUNpQXhlU1d2TGVQSks4?=
 =?utf-8?B?azN0YmcyZU9WYVFBUkxjVXBKRlFwSEljYzU5SElnR1JjSDRNUzhyc3djNFZv?=
 =?utf-8?B?WnMvVi9FSnNWWVdpa2VrUWFRWE5qQ0FFanZoVWRpZGlZTndNdWhNM3IvYlJ4?=
 =?utf-8?B?eHNSR2RPaW5LQ3hQZ0FqQzRGajY2eGF6WUp1MnN0RVJkZkFZVlVTOXpqWEEr?=
 =?utf-8?B?TlNZWVNSSFMzM1dyclE4TmJwdFJsSVRxbG9WZVJJdUVZOVhVYVVYMGhvSm1F?=
 =?utf-8?B?S2E1b2tSRGRSTk9icyt2QkYvcEpGdkhUd1NwNUZBd2dQajZVR1EzK0N3ZWZr?=
 =?utf-8?Q?v1YB320vBE1SZc3nID+AWQsPB0l6YzTpsiPB4pPDaaRI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6124.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?S2QvTWtOdFpXbzNWaHZpNEJvUlEzcWI1aUNvMzg0UHV1dWR2ZmRuY090NndD?=
 =?utf-8?B?Y0dwaDFpMEhndXFlMGlDbnQ1YXNaLzF5aHEveDgrUXZvbDlyMmg3cWhaRjVw?=
 =?utf-8?B?bXcyS1l6VG9uQkx0MjJySE9sRlovVGZBYmwxY0M0d3hiVzcxbFVadFYxMHd0?=
 =?utf-8?B?d2N4WURnQzhpdHNjSkZvL0RCc0g2dCtKMDQ0dDE4TmtiS1JoYmlWTnE4V1RT?=
 =?utf-8?B?MkZUK29mM3lRRU8xVnpLeXhLTDN4MTJ1Znc0NnlBMGpGdUlxME1ja1paT243?=
 =?utf-8?B?Sm1GZVdiY3g2dk9IdklIalVEOFZXbHFiUWdNY0ZlRE5YY2hwTVZuWXlzd25B?=
 =?utf-8?B?UHNiOGlzR2VqbkhBSCt4QkFrV0N2eEQxTzRwZ3hUclJEZlkzYjRTaVprVGtD?=
 =?utf-8?B?RkVKZkFnVmIya3V3TFVHZ1N2VjR6dFJTUEZwOE5vcXhoRWY5TS9QN09lT21m?=
 =?utf-8?B?d3ZlT3BwVFgybmg1RXk5eDVHOEprZk5ISVFXWUY4STVaSXc3U0tNTHM3SHhk?=
 =?utf-8?B?M2pOTjNBUVNXa0RBTmxyZ2NZTTFYdFFrZGJIbUkvbGZwUlpDK0QrVjUxeThV?=
 =?utf-8?B?UUNkakN2NWUrQkJKczdZMzNhYWhzTys0aTRvQjBEaGtlcXdEWkVwcGFIZ2ow?=
 =?utf-8?B?Q2VoNUd6OE5MZzZiZ2tJSlhzSk1zL0RZRGNoZk8wN3hrSEp1bEljV3kycW1u?=
 =?utf-8?B?T0c4Ui9abFV3TEVXa2krcmtPYnhYT1l2QWtPWlR6b1FJYUhNTURmdDNuNjVi?=
 =?utf-8?B?RFB6ZTZtUnVaRG9nZitBb0Q2V1ZIUEhUdW1yejJoQmZ2bHM5Q0h3RHRRNmRp?=
 =?utf-8?B?RzV0QlpBSExKWWp3S3p0aTFaWnRLdWduZjVZdklOcWJJVGovY2xMRCtkMXlC?=
 =?utf-8?B?L3kwbVpWREl1TUVkTk8yeGRkajlJRUg1UFN2cDlEbXpIREw4bU1mTDA0VG1i?=
 =?utf-8?B?WWNqQ1FLUjIwTzl2blRWNDFCU0UxbnlMTHZrWndwYzZ0ZWZnem9RcDBUYnh4?=
 =?utf-8?B?Qmpmbk5QNXZrYkZTZ2hEbTQwYXdUSEpKU0Q1WnUzNkVrY1VxRE5ZcW5BU1k0?=
 =?utf-8?B?akp2bFpBci9rWlNLZFhQaktLR3pjakRwckxSMllWTW91RlFvQU15ck84YUdj?=
 =?utf-8?B?aUhTNWR2L3ZVRGZSUW1JRVo0NlA1Q0llV0RMYk1PYXZQQlAzY3Noa0xBOFBj?=
 =?utf-8?B?eUVubWFiN3R0RE9LVGRaZ3piRlhWNXJNRTJwL2hyZ0phc0lxdW9DRUthQkJs?=
 =?utf-8?B?YUxSRllvOE0wNTlpeUN5SUxVMVNCcyt2L2l1RERubWUvNkZkSmMwdE5mMGh2?=
 =?utf-8?B?cmhZbUZ1bHc5cjdOWlowb2J1NzFIQWNWdnNCOENCMUFVZ1Z3dk8rQ0h0UnFT?=
 =?utf-8?B?QTBrME1SQmRoWmcwMkFzcW1BMjJUZk0xZDdITEFrVVhkWUNENFpIY003NXpz?=
 =?utf-8?B?L0x2L2FWZ0w0dkRibTdUS2pBMGxjbnZWU0NjS3l1RWVDMFdtVFJ0Tkc1ZHJ2?=
 =?utf-8?B?MU45TzArYjlEaWJMSnRuVXMrbGNGOU1OYnlNOHhIaWF3K3hDTUZHMnJvaG55?=
 =?utf-8?B?TnJJaXRleWJGbmhSMDJXdjZtRGhmMVpud3ViSDBDZk1GeXEyTXZBU04yWmRw?=
 =?utf-8?B?L2ZmdUlXTnZ4QW43S0JYYXI1MklQSTZGWWprT2lEQ1U2SnRlQmpOdkJicisv?=
 =?utf-8?B?OWpxdmlvM3lrTEh6Y3F0S1RwN1BHTFBMRWZVclpkT2g0ajF0U0lJcExZZnAr?=
 =?utf-8?B?MnVHTFk3R3A0YlNRV1kxc1hHUldnZFFrTndPSk1wc3BuKy9LcG1YZVRhSktD?=
 =?utf-8?B?OS9JendKb0hlUEhIajRzMDJaQnE5Sll1dm1wUmwyQjlnRkpwN2JvS3o4QXEx?=
 =?utf-8?B?Q3dHdlRpbzJ6ellrTmh3VW05MTNLWjMxRWFyUFJ0RU5pc0xxRlNlaEpCejh2?=
 =?utf-8?B?K2Qxak8vbjFwRmtIS1Ivd0FXVmZzV1U2bzVoT1VjcWFBRmF4ZEhEeWlRaCto?=
 =?utf-8?B?Qk5TUmh5K1hsVk1HM2t1Z1cwZS91d0Q2a09WbndNYW9nQ0taMytqWGcydDJX?=
 =?utf-8?B?UWFXNlRhUkVHZ25RVDMzM3BlZGhoNXk1S1ZyVlNZQ01jSTA5enRlcWJZOVBR?=
 =?utf-8?Q?VhFZawi4V7AtTSijl3rB6f9kq?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bcf36095-be1a-457e-d7ce-08dc7d400088
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6124.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2024 04:55:02.3741
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +z5/G3jBIEbDDl6NVnChv7J1/uYCVQx9l6z6DGv5+qbuPVIHuLDwCbra4ZZk70xxZyQeplLQ+mFowc2n2wQDow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7411


On 5/23/2024 8:15 PM, Borislav Petkov wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On Thu, May 23, 2024 at 11:57:00AM +0530, Balasubrmanian, Vignesh wrote:
>> Currently, this enum is the same as XSAVE, but when we add other features, this
>> enum might have a different value of the XSAVE features and can be modified
>> without disturbing the existing kernel code.
> We will do that when we cross that bridge, right?

I am struggling to interpret.
If we can add a new enum only when we extend, then as Thomas suggested 
can we use other kernel variables as in the first version of the patch 
until we extend for other/new features?

thanks,
vigneshbalu.

>
> --
> Regards/Gruss,
>      Boris.
>
> https://people.kernel.org/tglx/notes-about-netiquette

