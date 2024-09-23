Return-Path: <linux-kernel+bounces-336173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 42B0E97F01B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 20:06:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FF8FB218EF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD3919F129;
	Mon, 23 Sep 2024 18:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="gC9JK1PS"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8DF16419;
	Mon, 23 Sep 2024 18:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727114753; cv=fail; b=Tp+4iTGuUT2uYwtSta9OTvZg2vcF4COogpJkhwC/29Gm45DSZ6awOIbPrJiFlnFu/bMkK8prU5yF2QVrXwlKeJLCB5DtqkCfpKxNR71N7Kvn4Ra0ZjmC9n6ibfxqv88r072LjBTOczKCHZ9nQwIo+rbHr16Lq9ASWB+lLC6mXCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727114753; c=relaxed/simple;
	bh=PvcTBsrjZ2VM6n5qP8KrqchPG/o0LRR9yOeVgOr3KNk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U1F6OWt6m1BrlYalPD5+fnbyDJ0fvDOOMWaG7+7lzsOh6zWacBdmw3x2wmyJ9KAKY+zUF+XiTOwG4ZraQBSBvQC7hAU3uTKMlwTgkPOwXIkm+0yxjg4ZSpoewowOUZFK22EbPtsApS+ziCQZNhFad2Tut7JSrrpRbFdTKOFRi84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=gC9JK1PS; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48NC2joI017355;
	Mon, 23 Sep 2024 11:05:21 -0700
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41sugp1399-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 23 Sep 2024 11:05:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ID/1xM3RJvLf98StzHYJyAk8tcE2XmFuTwtcDXToE5UZQSEJiuFzzdYkO3EhnghyjS1dlx2DB6orMhYCRukoafXSsda5WvjhRkoVCYLMaHmSF97wGV6rN8mojBlslRG0ud0DUo0OZToXL9IvviT+ZOlCWRRZPzq/PQ0KeMyLn5+h5oCK/AfrUg/sf/Lpa2ZIhI4PsrK7sgxi33K++neoigX7+AqCC40llIr8lEpkCqQW+x67Zbl1u5YcAXxrSMQIHpCyW5f9FY1AfxhhWHRWommZlNI/FURU6QQ9HlZkeQs9DYE0gIrgyaaz+ClNnyg0CKJRsMdBAlHmYLRGPOCbmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xKkLhel8KYraCHZsDSLTlkbQxpIHByuiysQ4fzm/N/8=;
 b=NA+gAI9qDdzJKHeOAYPOCRqj6bFh+R1ZA35cyHA9vITv2xoB4/cUhUTkcjEqgiXLmkXNQjMqNIERe0feNVOCs9m4j/gpRNRjdYyvCk4j/5T/L+4llIY7IxaIzh3a2y4gIvxo5Rq7iya/eTXVm72c9uOtzLq4W6KCFQkoGI2sNXuXmbXBgxjshQZZ0ff5blf4kub9psqJd+sCeogZZXEtyIH7bNEllkU4FTEB5vbIdZP/VbdIBNKs5Y/fYjjknfwTRw7H0o8288/mVaOecMuDkIMvj8iAtUnHpof/9MXROgfhGT2oAlAd9QCCajWOOmB+g+HEr+LqgES8lfFZPL9+Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xKkLhel8KYraCHZsDSLTlkbQxpIHByuiysQ4fzm/N/8=;
 b=gC9JK1PSM7PCjafyJsLdwgsyRr3x/WuySYl6NjLlRghlLFXah2sxMwhblU4iCxc6T7fcwd5CnD/j26KzcrbjUJwggs38KrVGxC2H3om9qe/NXOakU2g+rrQnIOuR7dZZkWJwMzlC3zIn1PmX+BzQGhEyT7QZsFqkN8l/aoCJ3To=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by LV8PR18MB6004.namprd18.prod.outlook.com (2603:10b6:408:232::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.25; Mon, 23 Sep
 2024 18:05:17 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905%5]) with mapi id 15.20.7982.022; Mon, 23 Sep 2024
 18:05:17 +0000
Message-ID: <fad03af4-5dff-4a02-8fc2-926275feb386@marvell.com>
Date: Mon, 23 Sep 2024 23:35:22 +0530
User-Agent: Mozilla Thunderbird
Subject: [PATCH v5 2/2] mtd: rawnand: nuvoton: add new driver for the Nuvoton
 MA35 SoC
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Hui-Ping Chen <hpchen0nvt@gmail.com>, miquel.raynal@bootlin.com,
        richard@nod.at, vigneshr@ti.com, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, esben@geanix.com,
        linux-arm-kernel@lists.infradead.org, linux-mtd@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240920063749.475604-1-hpchen0nvt@gmail.com>
 <20240920063749.475604-3-hpchen0nvt@gmail.com>
 <9245120b-9901-45c3-9a6e-600653f94bba@marvell.com>
 <ZvERI9fscLBC09_F@pengutronix.de>
Content-Language: en-US
From: Amit Singh Tomar <amitsinght@marvell.com>
In-Reply-To: <ZvERI9fscLBC09_F@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0123.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:96::13) To MW4PR18MB5084.namprd18.prod.outlook.com
 (2603:10b6:303:1a7::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR18MB5084:EE_|LV8PR18MB6004:EE_
X-MS-Office365-Filtering-Correlation-Id: 876fd759-3509-420b-381c-08dcdbfa47a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QjlGbUhjZTJMNTZiTDZWMVZwV3dSUWpEY04wZ2pOckVtc2Rsd3FqczFQTXcv?=
 =?utf-8?B?aUdBTGlYS2hLcHdBNFZXSzNEUTllMmZyQXhVd2N6TmxwODd5R0xJa2lqbEhx?=
 =?utf-8?B?RGdVNUErVHNXT1djRU9QTWlOZnhyRC9YcjdwY2p4YzNHczFzcy9SOTlNbGV4?=
 =?utf-8?B?Nkt2Vm1UMWVmelROOVU4QVN0MjBxR3NkbFgrYzQ1aU1mQXpyTVhZbzJXMWtT?=
 =?utf-8?B?UG9vdUtIbkNGM0M4djhJcmFINi95eGpQdzU0L2MyekJFdCtDbzJmV2lQWVJi?=
 =?utf-8?B?eFV5aHBQRVdwSzFHNktjRkI5eUxxaVJuR1VDdWdncVlwa0QyNFlTRjc2QnpN?=
 =?utf-8?B?WXRGNDdNUVM2WEVWcVdnb3MzaURJazRBM0RpOGxwcVVEdU5nWVpSdm1pWUtr?=
 =?utf-8?B?RW8vWFZ0cU8yeWtYNTFFdDhCQytpOWhVZTdYL01wVXV5c2V0WmpnVEpZb1FU?=
 =?utf-8?B?djNYKzAzUHJqbnFkRlhzWEYxRFEvQTNocmZaNStlZUM0R01BQkhmdTE3Mkxs?=
 =?utf-8?B?SXFHSUlkeENtMVBuMHlMSDVSTUdjMnRBaGlCTHlVUEFLVC9rZElOaXFzY1JK?=
 =?utf-8?B?RVNKRENxa1BrQ2ZzejVUWTFmcGUxU0JGTUtQS1lmNGpKWG9MMG5reEtBa0Ns?=
 =?utf-8?B?eTQ4WktqdGpneE82aEs5VlZzZHd0UThUa0QvQlRjQmUvRWVkRDlyajNEaHQ1?=
 =?utf-8?B?M2dVYk9wRjQycnJOUktwdFNSam42ZW5ScUxJelY5My9yemliNDVzWG5BdWVn?=
 =?utf-8?B?Um1GV2lqaGVGWnFWaTZYN0NGZ0VzTTU1bjVpQmhTNG5aY0pITWt6aVUzWnFU?=
 =?utf-8?B?TmJ0SENpYnNwVVgyOXJUcWIwWjU2NkcyN3JrQXpmSDNRSVU3QVJmWHFEYTBn?=
 =?utf-8?B?aVlaQUN6amUweXNnSTA5V0ZmVytSYXQvdXZHWGE2WDZsa25TdHZzN0NVVkRn?=
 =?utf-8?B?Z3hHZU9TVjA3eWFBZVB6QlJwaWo1dlV3d29jSVFkWHBPS2VUSDd3UmZSamtZ?=
 =?utf-8?B?WmJZUkMvR3N2S1JSMHhOeWFaWTgwZ0h3ZlI5VVJQdTdmelZQOTZSSkx6TnJG?=
 =?utf-8?B?c2p2eUlNVlVMSDVmbkdQdGlrRkFsTExKUzF1RndZdHN3S2dGZDlGZzYrelQx?=
 =?utf-8?B?UmY1VnkvOTVOcWJQQ290NDMvSVVkS3Bta2lSaDdNcU83RENzQUFqTVRDa3JE?=
 =?utf-8?B?em42Ykw4NmFNVEkza3JNL0Z5Q2toN3FIZEpRRTNWSlNXcVkxRDZCME1aMm1r?=
 =?utf-8?B?ZGdBSHJ1eEpzZmpkM3p1TXYxTHBLT2FPM0psRHczL0RDdEFQcHNrc0JwRENq?=
 =?utf-8?B?QkFvZGZOdU9HZGRuQU1QSmtBVDMvSWlVeWRDWTIrSlAyV1dkcEordDAvcUxx?=
 =?utf-8?B?TURZM3QvTS9Yakd0aXlycFBlVEJNVWVTZHdqeGVnSFBRQ2lhWGZicU9JUjkr?=
 =?utf-8?B?aXcwVEExcnlXNC9jM1owMWtVN1ZyUk5lcmgvSEdzSEZTc3BuS0RiNVVkVVY3?=
 =?utf-8?B?OTd5TVZoSHhaNnhPejhkR3Z1ODdZc0xRT2N6TmhsMW8yNWRIRUNHMnhkOTZW?=
 =?utf-8?B?MHErYWhJUjBVR0N5TU5Cb085L3FFRmg4amVPR3YrM01LMWZZd1p0SXkzQnFL?=
 =?utf-8?B?cGpGd0l1cUFqWE5zaGo3M3VuTms1Q0tpdzNPbWZ3SzY0djRiTXlmZWtJN2tN?=
 =?utf-8?B?aVRCeFRhK1NSbi96emg1MmJYNWIvVkpsaUZYWnBNQmNPa09LWmM5Z2hxeG9O?=
 =?utf-8?B?VjFyN2NRTHJPSkpOZjlWWUNHMFdGZmN1djJtVmVpVUllYmI5WHI5VmxyQTBK?=
 =?utf-8?B?cVFNZHdmSVEvOW9RWFJOZz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0lmZjJ6VFhCZWMvK2NpbUNONldSajdhTThqR2hZMVRNWXZlTmRSK1I2WDM4?=
 =?utf-8?B?aFRDOUI3Y1VBekJrbGNuSkY4VVRGYk45eHczK1NlMUNldld6dGZvbWJqNTlG?=
 =?utf-8?B?Y1R3OCs3WXg3ZENrbTZBZzB0T0tRc3F4alRka1lBSk1XSTdmQnlONW9ZUDBX?=
 =?utf-8?B?ZkdZVzQzQW5RbVFHYWVid3AvNnkwYkl6SXFJNW1LOGR1VTVzSDNwWlNrREkw?=
 =?utf-8?B?NnM5aDFWM2FHMkFOTmRhY2pyb1pqcm1iZGl6WDNJL05OYk1TMFRQclBaSFov?=
 =?utf-8?B?L0RNMDJYQUJBQnFUMTJ6SDU2U0REcXR0Vkc2Ulh6cWs3OGlFNUJRYXk5c0tF?=
 =?utf-8?B?aGYxQ3JYRUZjZFJDVDY4dFltRytTWTNDU3RvQWZwV2hHajdROUJLaThsL3NT?=
 =?utf-8?B?L05WQVNMcDV2SUVwRnhYR1ZrbUtuaW1QTjU2VDdQV2ZrVTF4RW1SWDhleU5h?=
 =?utf-8?B?VGFzWXZ6Zm43cFpiVDJmN25VYUdzSkxjN2pmdXZuMnk3MFFxQTZxWS9nM0ZQ?=
 =?utf-8?B?Zy9VRzNWdnB6QkY4dzVtUWU3YzVSbU85TzRjN0pFV0dsZTdhZVMvZmF6N1E4?=
 =?utf-8?B?Y1gweWZmQXQvOXJlcXFuWmV1eGM2NDhNZENCejFkWDNtSVJWTWk4SS9ZUEJj?=
 =?utf-8?B?WGlhWGs2UFhvNGJrUlg5UXJJVXM2T2NZR25MeWY4OXlKbFZtK1c4dUZnZ25V?=
 =?utf-8?B?ZFBuTTNuTWV0RmJBbk4xbVFZMUs1R0Y1Zmp5MWVQUjJnUmN1M0VjVHNVWWp4?=
 =?utf-8?B?WHdvVi9YdDFWTk13d2xjMmxVQ1VCdHVDaStVczdoUFZBMytNNnVzT254UFVk?=
 =?utf-8?B?bDEyaE80RHpVdGNUV0pQSDRrdkVPRGFJdzBURzdFblhMVys5Rnp6M2VqVWRV?=
 =?utf-8?B?dDdXTjY2ODhVZ0pjZDU5U20wbmk5UHBnbzRFYktMZndaR01wMTF2aFEzRThF?=
 =?utf-8?B?Yno5QTNEUWpSMlJKZTRrWkRzVHYyMm16Rk1nM0QzZ3V6ZmM5WDNpelRGZzly?=
 =?utf-8?B?RWdkUysvVDMzVEc0ckxCWUIwbDRIZFdZYmxxNjhiN1pXVnArZmN1S0NtWkQw?=
 =?utf-8?B?c0VCV3oxNmRNM3pJNkpaS3owNXRkU084alZSOFlJUE5lOCt6YzlIWkJIWDdm?=
 =?utf-8?B?WjQ5RzJWZVdXcEhIMk5FTWhRaVJoRC9mTW1ubFJmZzRiNDVGNXhQL3hTdXdn?=
 =?utf-8?B?TkJPWUthYk1sWk4xdktnbGJkOFhwRjNCMlhkS25tUUxqVTBQS004MGJXSEsz?=
 =?utf-8?B?dzVROVBONWEyREJlRjJTTVRuOHlTbkRvY09iWEo5L1hrY0VUTjlqZEtZaW5E?=
 =?utf-8?B?ZW55MnE3dVpmcnA0YnIrYitkcHZMcjl6eG4rM3QrRWI0YnpKUnZZSlZudTVT?=
 =?utf-8?B?a256Zk05S25KU0R6NnRmSThkcWVSa21nUUlVRWtWMVdYNDNhSzE0eW5LN2Rj?=
 =?utf-8?B?WnJZbTBXdHFnZzNiTU1yUjdyMUNXNXJHa0Zwc2dlVXlud3NRREFTNzh5TDRm?=
 =?utf-8?B?elVZUjk4YzVOU1lWdlJycURLMXkySlBLd3RoWjlZelNKdTc1OC9QWEpzOXh2?=
 =?utf-8?B?Zm9uaW9yc1VKWENDRGZ0UG13Uzg4cWdaRzRVVFkrVEVBVE9SSDBDZ2VsUm5n?=
 =?utf-8?B?ZFlOR2VqQnZsNDhCWnJ4N1AzUTRBL2hRc2tZalZLN1ZaRWhDVnd5RTlONXox?=
 =?utf-8?B?QUI0VHVrZDFHMTdsZzlKLzMrTlZnV1FqL3BhK2tvSkw4dlgzZStjc2RyVW1L?=
 =?utf-8?B?SjBvNmFtZ3BsRGh6ODh4S2xuVjhjR2dGZDQxdUxjanNJZWo1bFliQWdtSmlB?=
 =?utf-8?B?NCt2UGJEbzhLZUhEMVN1MHlSY0FZL3BneGRlc0QzaHhYdFYvd01YT3dYcWRq?=
 =?utf-8?B?V0tvVkJPVk1OaXA3YjA0Rm9hZEZueTIveDBnZzNHTXJnVy90U2pPSW1oVG5I?=
 =?utf-8?B?VlQ2SnpDbjJaRVdSbFRBS3prUGlNYWtqSWZ5TEhHdXRYQmozNWo2dVdvUUox?=
 =?utf-8?B?QVZjZkVUWGZNSElERGc3VjBPUmlZaU9NRW02T21GV0dWbitLMlgydExXSFJT?=
 =?utf-8?B?Nm9lMmJvd0lOVTlNN1p0d0ZHTVE4WDRlRW1LYVkvb3hqeGt0RFljM3RqcWlj?=
 =?utf-8?Q?nVUOa+Q/dH1LXu0z/H++uC0Rr?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876fd759-3509-420b-381c-08dcdbfa47a0
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Sep 2024 18:05:17.3539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tKfnPgIYiXxNxHxfe6O5UXnxBQSnuBY0eSBFeFJ/QF7M9ENHoZOFA7PKTvy/LffO2d2gMv8C1O57u5euV/bD9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR18MB6004
X-Proofpoint-ORIG-GUID: dCcyDSQNOI9dKwZON7oYaiqKEN5LVHbR
X-Proofpoint-GUID: dCcyDSQNOI9dKwZON7oYaiqKEN5LVHbR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01


> Hi Amit,
> 
> On Mon, Sep 23, 2024 at 01:19:03AM +0530, Amit Singh Tomar wrote:
>> Hi,
>> 
>> > +static int ma35_nand_do_write(struct nand_chip *chip, const u8 *addr, u32 len)
>> > +{
>> > +	struct ma35_nand_info *nand = nand_get_controller_data(chip);
>> > +	struct mtd_info *mtd = nand_to_mtd(chip);
>> > +	dma_addr_t dma_addr;
>> > +	int ret = 0, i;
>> > +	u32 reg;
>> > +
>> > +	if (len != mtd->writesize) {
>> > +		for (i = 0; i < len; i++)
>> > +			writel(addr[i], nand->regs + MA35_NFI_REG_NANDDATA);
>> > +		return 0;
>> > +	}
>> > +
>> > +	ma35_nand_dmac_init(nand);
>> > +
>> > +	writel(mtd->oobsize, nand->regs + MA35_NFI_REG_NANDRACTL);
>> > +
>> > +	writel(INT_DMA, nand->regs + MA35_NFI_REG_NANDINTEN);
>> > +	/* To mark this page as dirty. */
>> > +	reg = readl(nand->regs + MA35_NFI_REG_NANDRA0);
>> > +	if (reg & 0xffff0000)
>> > +		writel(reg & 0xffff, nand->regs + MA35_NFI_REG_NANDRA0);
>> > +
>> > +	dma_addr = dma_map_single(nand->dev, (void *)addr, len, DMA_TO_DEVICE);
>> > +	ret = dma_mapping_error(nand->dev, dma_addr);
>> > +	if (ret) {
>> > +		dev_err(nand->dev, "dma mapping error\n");
>> > +		return -EINVAL;
>> Shouldn't this return -ENOMEM or simply ret when there's an error? Also,
>> should we consider unmapping the page with dma_unmap_single in that case?
> 
> When dma_map_single() returns an error the pages are not mapped, no
> need to unmap then.
> 
Thanks for the clarification.
-Amit


