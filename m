Return-Path: <linux-kernel+bounces-425256-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7B49DBF75
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 07:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048CB164570
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 06:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A84156872;
	Fri, 29 Nov 2024 06:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NsIUu5tD"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2055.outbound.protection.outlook.com [40.107.101.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6408133C5
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 06:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732861333; cv=fail; b=sfbizd+ITqaWVCslhS4yjsbYdIdesoCCcGh4yT0tt/7oG5c/vLSQ8NqFPPWfAt3l9Ik6EbPQD0ut2aOFLPwJ0V9lm8MwvyYNsb6KnVJFmZbrpUvuNf507QAnoFXeo4ug97jXEmkaGpQg/6k8yZSW6eesBeug4uqshGWl2blxg/U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732861333; c=relaxed/simple;
	bh=KgYvZobdbiHnRpN42Q2qsMhw9Zsnbumswcdd/EjxWPk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EZo8VdptPeVKcCLG2Zi7uPrsYRPLg0yUWj/INl+XQEf8PypBYqUDrC3uasfBm7QYTs1zdlCjRUG+9u48km3locORgjxLI2lqyyEkLjv3hjfQNQbfciDk++Kh17nvY4sKsuFliuRLP352U/upCff0JJ+xemEc0lirzXvEXoz8Fx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NsIUu5tD; arc=fail smtp.client-ip=40.107.101.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cAAmwt8DOPY0t3K6fZsEnsiWoUGH1T1CKwiyI9zu19Kb6rixCPJ9xSaYnoWKGz8+icy9sNt9f4io96/XwsUXovC61yw76HhlYWonYJzj3punMIgZM4uBXM99hgJWtuLufsf5cEKq5sSg71gsmyZROs/jdzevcyUMn0u7ZlZa+5yD7ROacN8I8cx5W2znPDZVcfWvAiVLS2NSXpBV0x6RtN4HSz71gUkO1+wj4MjYRuXKTrL0lq9G0f+IJmbT3HASnId1QorrVIY3uVuhHMkcKhZXMOulYXRcTIym/oNt6o1S2zEai5CYBO7a+T53DY1HUKn0jEXEiDeY4pByRZ76BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FeFBFUeJULu9cIm+Lal3KFvllc11nsVGrtv6FB2q6c0=;
 b=hprlaR2w1r8q5DMC1sWmpcvtRb8oU5yEbd5ClWSeVps3rx9FUUVZ2AwPy66WamwS6FDzqqkicqYzL0x/L2MpZIIcSMNI9Tm2hB/v+NdHkGd/fZuHFDLm7OIVVhULqp/XCU69ATg+SRH6A+dmpXkgRneDGiIyj0zo1WOZ1FO2plkBeLtVBGAsdqcEE/rZnBLNokECc6PT/+Ch1zIy6fovmz4G2P3m4tnuuCfJGka2hWiI3j2i9WjmgtHn73JN1KNypP6cr6+t2ksdcIxBOXRNemCXkOm79Yel/T1+1IaEMJ2mm1B6tR0oi0bfECe7QGIp8+4xL/llRV3l78oIIJQKnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FeFBFUeJULu9cIm+Lal3KFvllc11nsVGrtv6FB2q6c0=;
 b=NsIUu5tD9D+f8SuyB4F0fTsWmIYbcjlQJkNKArynbssE9B1ZGEPiq9nQo9mAi3NOxRkTLBG+9gCH91hRrpwuBR/fc0bWw+dmfh4P7zo7loK4oujQojEVwyupOiFtXNiOfmApMoQJLxWcILTqNfknhFO1iNL8DQsB37egvKLqvyE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5805.namprd12.prod.outlook.com (2603:10b6:510:1d1::13)
 by SA1PR12MB6824.namprd12.prod.outlook.com (2603:10b6:806:25f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Fri, 29 Nov
 2024 06:22:07 +0000
Received: from PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3]) by PH7PR12MB5805.namprd12.prod.outlook.com
 ([fe80::11c7:4914:62f4:f4a3%4]) with mapi id 15.20.8207.010; Fri, 29 Nov 2024
 06:22:07 +0000
Message-ID: <3dea52d7-cdac-426a-a47c-cebfc09fbbf6@amd.com>
Date: Fri, 29 Nov 2024 11:51:57 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] migrate: Allow migrate_misplaced_folio APIs without a
 VMA
To: Gregory Price <gourry@gourry.net>, linux-mm@kvack.org
Cc: linux-kernel@vger.kernel.org, nehagholkar@meta.com, abhishekd@meta.com,
 kernel-team@meta.com, david@redhat.com, ying.huang@intel.com,
 nphamcs@gmail.com, akpm@linux-foundation.org, hannes@cmpxchg.org,
 feng.tang@intel.com, kbusch@meta.com
References: <20241127082201.1276-1-gourry@gourry.net>
 <20241127082201.1276-2-gourry@gourry.net>
Content-Language: en-US
From: Raghavendra K T <raghavendra.kt@amd.com>
In-Reply-To: <20241127082201.1276-2-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN0PR01CA0042.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:49::13) To PH7PR12MB5805.namprd12.prod.outlook.com
 (2603:10b6:510:1d1::13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5805:EE_|SA1PR12MB6824:EE_
X-MS-Office365-Filtering-Correlation-Id: e908e21e-3421-4e62-357b-08dd103e25f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VTFHOXJES3UwUjJsY0hjTHZCVk81Mlp1VkpEU0I2ZDRzUUZIbFNDVHRBRVEy?=
 =?utf-8?B?MlArb25SeGsweFZ1alFIQVJwQXdiYjRFQkhMVEVUTWpRWXlSRDJXYVNmTGlT?=
 =?utf-8?B?S2tRNmJNMGZWbHQ5R3MzcnNkREN3YTFUQ2NGdmFYei92d3FZOHVPOWJxUmo4?=
 =?utf-8?B?ai82QWhTYkxRVnJoRXlWOUsrR2UzR2RIUXZSOFlyR0pkankxVUppaHR6b3JF?=
 =?utf-8?B?VzNPY3dCaEU1VFZ0Uk5WbVg0WXBPcjN3SnVHSlpCUGRnQXVWNVVNTUlqYWM0?=
 =?utf-8?B?b2ptRmN2N1ZFcE5acGpadmtlZllPQUhtTnptVGhsMERGamNqbEtUeXhyTkVE?=
 =?utf-8?B?YlVCYUJsQ0NGSzIyWnVjWWxLcjhXWVFGOUsrbjVNQmd0Vkc0bWFFY1FUeUZV?=
 =?utf-8?B?YVRBaWdxVVRnY3VnRmZSWjBVUzhQczlYMHVpbTFrL3hiSVpGclkzTWJvbUdB?=
 =?utf-8?B?R3JxSHZGLzYwUENhTTlYTmY4UXhjeDF1dnF2MGRTanVyRS9pRlQ4SVFIeFZF?=
 =?utf-8?B?OG9UREdsYldyMjFTUk5zQ0Q5bTRudy91Y2o5a1U1ZHZTVm9PL01WYno4SlJR?=
 =?utf-8?B?dndnWnMrODNaLzZhK1F1NzlXdFZTeFVkU1R5QXBPOHFQSmlDbklsVm5DTkcw?=
 =?utf-8?B?SkRJSmJMS0dGVWZBZGJZdUtKSkhORjdZbUlhVkpLdlFCbW56NHFxUGNTdUZp?=
 =?utf-8?B?YVlqOWtaZ1ljRlhGUzZ5NjlleSs4amVkaHZod2ZFcnlEV25adHlzUWU2Mm9V?=
 =?utf-8?B?YlQxV1dJNzVHVGFGZzlyUmNYaDBmOHhackF2ak90bVZvN0dVN1RwR1diS3Rp?=
 =?utf-8?B?OHBhTExZN1NBekdaUDNxQzZFNFpCRWFic1pSbXpQYmhLK0JsS0c2T1FUUjRT?=
 =?utf-8?B?N0lZTVVlSVdYRWpsRCtJWmI3VkdrVjZaK3piK0dhNnR6Ui9OdlRDajRpR1Fr?=
 =?utf-8?B?YnpRVjNtVFZSOEptYm1lWTByVmZVOWJ1bFFTN1E1V1l2a1ZyeFE4a3FranJV?=
 =?utf-8?B?THdKTHFNMElWY2xaK3hKV2h4d1RtdmdCQXd4dWdOWUgwazA4aHNWTmhYeDI5?=
 =?utf-8?B?QUVtbmtXUWVIUEJCakxmcEhTZjJBVnBqL2EvS1BaV1RLQmI3MllUanJRcVZn?=
 =?utf-8?B?M3R5RVJiNjFpdnpjTllodDNkWWlKVzQ5cnp1SmUzWHYwbjVZeFpDZ3ZmMGRG?=
 =?utf-8?B?NXhMbklVT1BqbW5Bc3ErdHBvZCtUTzZJQVpLUW5lNTRyWnhwekp6K25pN2xL?=
 =?utf-8?B?S0RSNlNvWm9UdGNreDhYd0lQcGNSQ2NycWpiM0VGYWFhdlFwYWJwbmJKZVBs?=
 =?utf-8?B?a2Vndm8yaHhpc3RBaEZvcWVTN1BEQ0t2RHVjVWdEWXViY0tKQmNGNlViRXlu?=
 =?utf-8?B?L25LSWtIaTZaeWVuMHkwbmd3anB2R3NJNmgwRS9IQkhsTGdGZU9Rb25aY3JF?=
 =?utf-8?B?Z3lmY1E4MXRnVCtLZUt0NmR5WWpVRFU5am13QmRuSE5EcW5Ud1AxUWhxS3RS?=
 =?utf-8?B?SnVnYTRrenNhTGZjNEVhK0NKTVVSdjMzdk9LaG1xVXd0Zm10MzBxOFdHamRV?=
 =?utf-8?B?dCtFZEtuRWNpNkhsM1RKamZ2a3N1cGl0WkNCWEY0TlRmWUlnTm5xSUVaOGhL?=
 =?utf-8?B?aVRsbUZqaVAyMTZJUEU4M3ZYVGE4NDNOMW5mOVluTXNWbkpLb3ErczE4WitM?=
 =?utf-8?B?c0svS2Y0Z3F1NmhhYXh2ZFRiVVNUNUw2MmJOQjRIMkxGRXFZODJVUWJEUmly?=
 =?utf-8?B?dCtWNGRjL3JRSDVGOVVBUFFoQzNwUUpKSWwyMjZmUHNnUmV1OXhjd2Nsc3JM?=
 =?utf-8?B?eWd3OGt2UENPOGUwcEZHQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR12MB5805.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?T0F1VlBSZHVqSzRjakhIVjdGTkVaMUpOdS9wdVpDSlRyTXNYZjNjTXZBcVpG?=
 =?utf-8?B?NTh2a1ltc0QwQ3Q2V2tJaE1KRmJsZWpDN1g4TVljMlFOV1dpRVlyY2ZoVnFO?=
 =?utf-8?B?QWdURkxmRVpmbGVUVWRTcGFVcEd1VmgzZmxKeDFwR29EMUJuVVo3N1FJa1Vk?=
 =?utf-8?B?aGdLSkFWRE5yMFVJVHVrQ2w0RDRiblNUMWREc093Q0pnZUhxTXIzOGZ3eDdG?=
 =?utf-8?B?RmplZlhTdU9idDkzZWJEbHlFUXlTTG9HQ1hWRWw4YzZOcytiWVZEaW1CRW9K?=
 =?utf-8?B?UTc0UytqeEcvVjBIdldBT0lCWGVvOW9CKzFzQllENjVBSWxma1JaM0U5Y2Rs?=
 =?utf-8?B?TmNSc1FYTldVN0NlSFVqV1pqTEY3QmZkRXdwMGlHTytTMWtGb3NISVhwWU43?=
 =?utf-8?B?YkhlUVhxKzNtVmoxakEvSVVZOEMvWHQrWk1UejVCbUlCZWFnK0c4MWx2Vy9v?=
 =?utf-8?B?WTFvU1haZzc2V3BvVGlNeGRiWlpuMlhBS25TanR5cENFRkFMY3c1eE4zZTgx?=
 =?utf-8?B?NTlZYzdiTFdXdzFVL3J5L2tJRUx4Y0M5bXQxV0RUZjdmaXM1VThHYzg4YjVS?=
 =?utf-8?B?QkNZdDFlM2VSbHVhV3hlQzdabW56U3ExdDFUTGxOV3JYM3pDWDNnbDBIL2lu?=
 =?utf-8?B?OFBvRzVlSEV3WkpLUXg1WUNmWGgzUkFZYkZpT2w3RGpkcysyWGFVLzNxa1JC?=
 =?utf-8?B?R3FGRmd6Vm5jeVNYR1JFY2NheDU0M3VkWnlKQm5mQTI5eWQxZDlzVUhWeWJp?=
 =?utf-8?B?Zms1NXpNMEZtT1ZvK1VNRHMxd0NyTlR3SWJYbHVjdVZML0pOTnhnVzNLNnZ0?=
 =?utf-8?B?cFIyR0VZaFVzZzY1czJ6V29yeldET3R1bDVWUlZXbVJNMXR4OGlDZy9IQ1FE?=
 =?utf-8?B?Q0kxSmd6aVRvSW5DWngvMDBCNlNHT05yaHk3ZlJ5SzVHLzJFTldGMDNncUdO?=
 =?utf-8?B?aVpTanBvMDZrZmUxcnlid1JkY2FYNkJod2dRQ1ZMOStPNjBHZEJtWkJtWkti?=
 =?utf-8?B?Yk5iU3lwRVZDTGtNMFhzbjEyWHRra3BreUh1RGFSV3VGOWhmbmVYNTBVcjNE?=
 =?utf-8?B?Z0JjMG9nYnFiMENqWDJPTnpXaWpEaEptcmlpYXM0ajVSRVIyekF3ZFBDbHdB?=
 =?utf-8?B?empQeGgvbXVkOVEvRE12TjZJZTVGNjhQd0tKbFpid3FNVE9sQlNKS1BhRS9n?=
 =?utf-8?B?UGxVUXdDeEFmcWg2Q2R3d0p4eDNkTyttdzdhTUxsYzQ4aE15MGNyWXJvTmc0?=
 =?utf-8?B?OWVKUDN5TEo2aWVEbjFPWlI1RVpkUm5OM2dUK25SZlZoWUdDSm5pSEFjU3NC?=
 =?utf-8?B?czUrWE9MUHcrTE9acWVBYWkzM0IyWG1YZnA0U0w5SXFRbDNDRjFBN2NDbmpi?=
 =?utf-8?B?ZkF6dDFOdEIwR3lVMkt4ZVlnOTlqSjd5KzFVcXNOeW5jUEJWZVJqb0h3N0F0?=
 =?utf-8?B?eXNtTmZiTWVWT0lCVjdBdVJkTmM5eklnSWl0NXBUcTlLZTUyaDY1MWNKQTJC?=
 =?utf-8?B?RkEyWDQ1OXlwc2grVlZxWm02NWFVbXVtSU5SZlczOFNKRGo3WkxzZFpkSHNw?=
 =?utf-8?B?bG54L3FmSG9vNnE0dGtFbXM2NlRJQW1LaXJSWUVNQ2trbE5UZ3dvQzZWbTIy?=
 =?utf-8?B?d0dxKzBsMlRSck5aUUMwUXRPZFppcDN0d1JmeFl3M2RqVjRhRVVpMmlXUDM1?=
 =?utf-8?B?aWNGOEVRNDZhbitYWjN4SnVBZUtuUmdoY2NsL1daSkhPRW9CWnUySEJFOFpx?=
 =?utf-8?B?dmM1OElhNng3Z1d5QWRTMjRtZUFqVys2NGJEdyt6OWRieUs4RFNzSEo3WGJB?=
 =?utf-8?B?dkJ4SXNtQy8xbmhjYjgwdFlaV3pCNWoyZis5Q0JDVFlKUXVVdGZucjJQMmsy?=
 =?utf-8?B?amg2U1FoQXJmQS82Rm10dTVuMUgybDFwYlVIZ2gzSjlUU3U4YWpxZ3JFOEo3?=
 =?utf-8?B?OXU1ZllVd3RGbFh0YW8wU0hWMCtheUVzTDVHS0RZWDJhRVdBZ0pvMFp3MEl4?=
 =?utf-8?B?R0RUSFF4ZHdCSTJab1pwTGpNQ01DWm0wa29KRWFqeExjeDVKUHJwTWhaaldC?=
 =?utf-8?B?eDc0MkNtVjVzM1NZSE53QWdZZ2YzY0tRcTFVMzE5cGdaZER3THVxUCtSUHF1?=
 =?utf-8?Q?9PVYv094lW9myGkQR+jvrsvOt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e908e21e-3421-4e62-357b-08dd103e25f0
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5805.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2024 06:22:07.1234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aAovp32ASRzZZeWp4J4HJEbss2M4aajGAEWUbwzEuVW+2FYiup5v205GaK4ZiXKlXDSAqrkzbhsgrdGYdJnnTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6824

On 11/27/2024 1:51 PM, Gregory Price wrote:
> To migrate unmapped pagecache folios, migrate_misplaced_folio and
> migrate_misplaced_folio_prepare must handle folios without VMAs.
> 
> migrate_misplaced_folio_prepare checks VMA for exec bits, so allow
> a NULL VMA when it does not have a mapping.
> 
> migrate_misplaced_folio must call migrate_pages with MIGRATE_SYNC
> when in the pagecache path because it is a synchronous context.
> 
> Suggested-by: Johannes Weiner <hannes@cmpxchg.org>
> Signed-off-by: Gregory Price <gourry@gourry.net>
> ---
>   mm/migrate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index dfb5eba3c522..3b0bd3f21ac3 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2632,7 +2632,7 @@ int migrate_misplaced_folio_prepare(struct folio *folio,
>   		 * See folio_likely_mapped_shared() on possible imprecision
>   		 * when we cannot easily detect if a folio is shared.
>   		 */
> -		if ((vma->vm_flags & VM_EXEC) &&
> +		if (vma && (vma->vm_flags & VM_EXEC) &&
>   		    folio_likely_mapped_shared(folio))
>   			return -EACCES;
>   

Thanks for this patch.

This would be helpful in the cases of independent page scanning
algorithms where we do not have a VMA associated with that.

Hopefully it can be taken to tree independently.
Feel free to add.

Reviewed-by: Raghavendra K T <raghavendra.kt@amd.com>


