Return-Path: <linux-kernel+bounces-192138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A47448D18F9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 12:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01682B2634B
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 10:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B78116C6A5;
	Tue, 28 May 2024 10:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b="h6k5Ovz8"
Received: from PAUP264CU001.outbound.protection.outlook.com (mail-francecentralazon11021010.outbound.protection.outlook.com [52.101.167.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F174C16C458
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 10:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.167.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716893643; cv=fail; b=UeoG4Z+MjVhLpt3pY0Q1awmynw16zqkCa/BvY4j5SHh7Yb600LvHvuYtMm+kSlcHXhFeJ7UTpHyevlYvc6s8zfgKyebFfTNJsgdYalG1X+7CbC/KTax0PJttDS3Pdku4ujAzW6dc8ItclPrj6GiirtXk1sB84DRQto7Z8bq5loM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716893643; c=relaxed/simple;
	bh=ylxHS6ciaFgqhAsosnWa3cuu7yzdCDGDvown4dyhVe4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aqOf1t6oMRwKDggekqH3gHSFf0bSnj7eoemd0ungl7UZ+beS57CmkMpZhUUnHMF9lBF/q9cHgV78/GRIAjQXNHuuekWMsS/BK7sUG/usbzg5fG7HAkUbZf659xVVIuH/7l1rFWNHTrxzlheBvKcZdU8N4HW9bciOwNYaeet/w4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu; spf=pass smtp.mailfrom=csgroup.eu; dkim=pass (2048-bit key) header.d=csgroup.eu header.i=@csgroup.eu header.b=h6k5Ovz8; arc=fail smtp.client-ip=52.101.167.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=csgroup.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csgroup.eu
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U6W04IVYu+k4PcP2XGUdrgTqfI7WxeCGyE9d8d1iwnUaRAEUqnLy61uxhpDN6QY14+G+gdOyhL2VOHQrsgU2tioyVoi9j2yKuvyclM1iCEmjeMh7Lb4PpKyqUCQvHIHT66CkhsDQbyE+aIvFmIxMZzahEKralzDjWM3M5SMHBGf4m3ewJ+/Ogl5H71ipzAK8YgH7ZwDr99yDzgST1LU/BXDGG7RlRu/FbpLOvmz1ayF91jcRnIrQHyC5w4PBZsx+/xJg8gzN+ikXXK+sOvXvmahTChx7NKeJZM5F4+7r6PGaRQAjDzGuVbeGsNleFf7RZ8KNKxDj5+1l/mt4bmvSPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ylxHS6ciaFgqhAsosnWa3cuu7yzdCDGDvown4dyhVe4=;
 b=HmBOq0IadBcqVGuBaMg/DOjQ41A3lxkYmt/abd7OUOh8Ux7ARmYUWIEiJi+EpN0zMYX2FI0gSURDl51MKN6s8CUvjsb+YHBfilBfUzWhtP23tIMAVqp/A5vT+WGm2xPHeFBxz18e1CXLKjlRhhrcxFeiCAlZ8qslprrtZ1Bq3fVybrcpCigtnme4spaVURvS7/JDYcjpsVmbdHUO8P4OUnsvgWZ6Pqp7UjebKRIEGPehaDXwpSoKFgub82H5izDR+3zgQcRV3Xfcc0KHeXvAzBTv7BX6ItloteQW4rU2yv5zkuJARrMEWltnxgyHGs/56Ax02idTC2BvVsdw/IyV1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=csgroup.eu; dmarc=pass action=none header.from=csgroup.eu;
 dkim=pass header.d=csgroup.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=csgroup.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ylxHS6ciaFgqhAsosnWa3cuu7yzdCDGDvown4dyhVe4=;
 b=h6k5Ovz86XQ/vhUXhfCylSyAphqPBBQhyfSqsZMAVr5ANzDZzTPzxLL9VF0mCr3KvyQPasMFyGeH+6Ku478K+OI6aqTnydGkFbZB7ctLlVufP8L412Ig5y03DlWA6PjfIk4xG1ZWYo00m8Z/qnq1J94LyZxemWSVxfFrJctaUuWCbmO1CfqfifLU+qHhd/UoUd/tzsEIhS3ZIdmduV5m+Q08hoIDTPrZ9ZSisVxaDY+ozdX4A8Q+SAAyJ7Gxv8RmlQxQlIv5zrdhHXw7JTZT4JL1VgEAjiobCkHJ/GB3FixgAegKnJUn5df9gh5c7CGNOhKsYX3g6Xx1jMCk/aiN7Q==
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501:31::15)
 by PATP264MB5206.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:3fc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Tue, 28 May
 2024 10:53:58 +0000
Received: from MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::96ff:7284:1fa1:b02a]) by MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
 ([fe80::96ff:7284:1fa1:b02a%4]) with mapi id 15.20.7611.030; Tue, 28 May 2024
 10:53:57 +0000
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Oscar Salvador <osalvador@suse.de>
CC: Andrew Morton <akpm@linux-foundation.org>, Jason Gunthorpe
	<jgg@nvidia.com>, Peter Xu <peterx@redhat.com>, Michael Ellerman
	<mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-mm@kvack.org" <linux-mm@kvack.org>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>
Subject: Re: [RFC PATCH v3 08/16] powerpc/8xx: Rework support for 8M pages
 using contiguous PTE entries
Thread-Topic: [RFC PATCH v3 08/16] powerpc/8xx: Rework support for 8M pages
 using contiguous PTE entries
Thread-Index: AQHar05AM30rI2VnaESQKxxitYFmj7Gq/xeAgAF8+AA=
Date: Tue, 28 May 2024 10:53:57 +0000
Message-ID: <5c80be56-e02a-433e-b330-653c712b1a57@csgroup.eu>
References: <cover.1716714720.git.christophe.leroy@csgroup.eu>
 <09f4ae803da751de7741f3d6bc5d94b8acf18829.1716714720.git.christophe.leroy@csgroup.eu>
 <ZlR4L9g9uQ6j7J3Y@localhost.localdomain>
In-Reply-To: <ZlR4L9g9uQ6j7J3Y@localhost.localdomain>
Accept-Language: fr-FR, en-US
Content-Language: fr-FR
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=csgroup.eu;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MRZP264MB2988:EE_|PATP264MB5206:EE_
x-ms-office365-filtering-correlation-id: 3dd6e4eb-4c87-4106-1259-08dc7f0479be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|1800799015|366007|376005|38070700009;
x-microsoft-antispam-message-info:
 =?utf-8?B?T2VHdnowR0tyZFRzN2JUWGE2UGZHTjhuR3NWMW93RFFJSjhuTnlXNmt0YmJh?=
 =?utf-8?B?QkFTQmZ6NXNkQmQ1NkUwNkF3YkRZL21ocHVkajFyTFpReUYwcTNaeFBEZUZr?=
 =?utf-8?B?TWFBYTdyaEtpNVlBN1J6WmZLOWR0VGkrQVd2djh1enRCREgyam1nWEFQcWdV?=
 =?utf-8?B?STlwa0NnYlFPMmVmZ0l5YVhtODZTcXlNcmNWL0tOWmJSU2JOS0RvWTV2cDdu?=
 =?utf-8?B?cXozZVVEMHNRS3VqRHdhRHZvZHQyRnRXZS8rd1pWdzR3dDNLSldKYzBBRzRB?=
 =?utf-8?B?SDFDeVRRcFVaU2p5c0QySDVvcEcxK21ldVYrbnFxSk8zdnc5Q2VUd0lWeUsr?=
 =?utf-8?B?QUthY3hERGg1NncyQ00yU3RRNHF4eXM5MzM5RmVSbU9WZ3h0TzR4amlheUVo?=
 =?utf-8?B?NGFlU1BIdzZNVzVEVjZaU29tVVVWeTBEVS81WlZLU3dSWlduQWZwV0lsMkZl?=
 =?utf-8?B?SG5ZRFJXdFdac0E2Z1MxaVp2ZjZjekxMSjVWMHcwaW9XUkxrLzUzZVJScVRq?=
 =?utf-8?B?ZFFVZUhSSHN0Y0lHdERQZlhLYmxlZk80RDRMdkVXbHJqV2pnaUxBeEFLTFNH?=
 =?utf-8?B?QzM0THhDMGJRY202QTVTWFNkVzBQMUlVYVM4b2N2R3ViQWwrNEFtQVgybVIr?=
 =?utf-8?B?bU5oSmhrdDZGaHVmSDZQSWNmazFYL1JWOUxGd013eWU3Z1NLb3Z1NmE5dWQ5?=
 =?utf-8?B?T1Yva0dsNnV3bHE3aERmb0VMaEdxV3QvWHVxUHNqMTA1WE1qRWd1aFBUdFpy?=
 =?utf-8?B?blNVMXlYckxjZXJqZmdVeEp0TjB1alNBS0oxaGN6cERDMVhnZzl6Wlp1anJm?=
 =?utf-8?B?OGN5WTNQU1dwTXBNMUxCamN4b2UvOEJGWkxCa3NVS1hJbVN0RHlTY3hJcHlo?=
 =?utf-8?B?UGhTQkJDNGdCa0xWcWJ4ejBPc3BOamFwZ2s5bGhPbXVmODV5K0hXOFVuZ3hs?=
 =?utf-8?B?VkdGT2R4aUN4R3lveXl3K240amlTVXJ5N3BXZFRYckExWUdIK0gvdU1HSE96?=
 =?utf-8?B?UTA2U0dKQlZ1Yk1IK043b0VGV3NEYWk1L3NzT3lMMklrNk1vWmdDZVkvZ1BH?=
 =?utf-8?B?c1ZzTXAwemtDSjk1aVNHakhObEJqNis4b1NpV2R0bXhHd0xhcUpsamZldzln?=
 =?utf-8?B?R1JiT3FHRXRuNHhpYWJDVWZjNDF4aHhKNStPbnU2cHYyM291UWRQa1UyQ1c3?=
 =?utf-8?B?NGhBVm50RGFsVVlJa0E0YVlVMnNBZnRuN2czNTdHZFRtazhDcHFyZlA4N2h1?=
 =?utf-8?B?MkI2SHpFZ3RUVWhFODlxYnZzN25lejdOMlZsZDhUM1pMQVRFcTFwMEtuQmJw?=
 =?utf-8?B?bFErTUlpYzg1eTM0U3B0ZHBubSt0MTI2anJSQnNuRFZHakZnVHhoTndWVUd2?=
 =?utf-8?B?QVR2VmY0TXB0UHh3N0tTWStHYzRuenBXTkVmRjZ2YnltTStFNUJmMUJJdjNM?=
 =?utf-8?B?dUx2ZDRvV3YrQldDRHo1Zzk0MHh2RTFUdjFBdXg4NmVRV1pVN2Y2MHhKcWNp?=
 =?utf-8?B?QXpjb0l4WjZjRVZLU3prbVB1RHJUWXJRbGU2MmFoelFQMDNrRFhVVEVmZVM1?=
 =?utf-8?B?eUppajBML1N0RVQ1V0dYNnFEeEFxUEJib0NrUldsM1Yxa0dJK1VBaHVrSGRH?=
 =?utf-8?B?TGN2M3F4aG1ZODQxMXZWbjVhSkcydE5lM3ZzVTRSK1dsNVpPcXFXcWg2QVpT?=
 =?utf-8?B?ZS9UNEsvOTI3MjgrVWpZWkxVWThxZVBsZVVLY3VSVmZCYlhvRHFXc1VlR0xW?=
 =?utf-8?B?ZVEvemlHUTREZFJsZDRPQi9TYXdsZmIzYmVuMTBwNEtOZjdKTHp4QmNQZTdY?=
 =?utf-8?B?OStrZTdwWE5XdElla295UT09?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?R0d1Y2Z3Mk9lUVFtclRXYno4S3NYVEZlNXdtL21RZmt6M2xDTVFtcmxyQnQ3?=
 =?utf-8?B?VGZlbHpKTnZNV3IwNVZkZklWc3hUNWtTUzAyd05ISmNrRitFNzFNS0VNL1di?=
 =?utf-8?B?THlQcHJ1bVFWWk1HK09BemdwYTRKcEUzbHNHcHU1elM5cE03WC9UL24zQkF0?=
 =?utf-8?B?Sk9rZ1F2QzZzdUtFc3VOVmJPUHFOS01SUGVuSys2VTdUaEIxNW1HUUE3TVFz?=
 =?utf-8?B?cUlsa05PRkJ6MjZmRCtTbThiazVRTDdNVnYrTElENmRYUHBPTGdva2FoeTg1?=
 =?utf-8?B?Y3QrT1BUYUZNMUVvUlpZcllEWmxGc2NDcVNkRlJaM2xSMGVHNTFmbEdRWVpX?=
 =?utf-8?B?UDhYL212ZjBmanVLdGJGakdwZ3M2bUlRQlVIbHF6K3lSZWcvL2orTVVDK1hO?=
 =?utf-8?B?MEFGZ0o1TnFNVVVycHZXeGg1VW5pZVluODlQZ3hNdm85MDFzWFZnbnlVR29z?=
 =?utf-8?B?UmNMRGxaY3BkRTI0c0lDRzQ1Q0paNFlwaU5mVmN1M2poeDdyMG0yVGlVU3g2?=
 =?utf-8?B?WUJWbC9MK0RwbEpEMWFBMllFUnB0TmtvTjJuTUk0SGFyZHpGbndMcTVFUEVn?=
 =?utf-8?B?bVNnL21FcXY0eUVVOVBjVE91M05TVmhUZUlZdzhuY1dxYStSK0IwTlNDVHNp?=
 =?utf-8?B?aUw2RmRXa1IwRE9YRC9HK0FRY1F0UDJxYTFvQ0VieXlXcmpFdUxKKytOZmhu?=
 =?utf-8?B?RHlYem52R0k1TjhvNXFVaTJYL0NFYVNmMDlCYlBnSm1SQ3NPQ3JHNFY3akVE?=
 =?utf-8?B?M2ZXTUtIdzB1OFMvYS9RTmxkUmc1T3FDWE9kVkpKQlpvZytVTUIyRHFGT2Q3?=
 =?utf-8?B?RkpIM2UvVDBoOHBKL0JJMmk2WUd6dGlTajk1UVIwR05rRjJwczRCQUwxMkJP?=
 =?utf-8?B?NDQ2UDFOUHVGUlQxNHpubCtTckdROUFBVEoycXJVQnhrZ1l1WmN6d1FWbkFx?=
 =?utf-8?B?VVlxdGQyV0hJcDB1d1BBbUtsWHJ0bm9jQWNLMStmSzNKOEpaclk5dWVza05E?=
 =?utf-8?B?K05SRHJRMUt6MWltRDBjNEVGVUpPV2NVdGI0VFA5dGN6bS9SME9ubktSYWcz?=
 =?utf-8?B?YnExUUJNdnpGMjJITUtvN0xHRXFXd2VTL3BlN3dsN0VlYzRMdzZrRm5lZkdF?=
 =?utf-8?B?UWRDdFZLanlrZ1Rja1dlZlNKRjcwRy9CSWEvNmVXR0FnQWZjZ0NQVFAzd3U4?=
 =?utf-8?B?NFlBejFYZTRlNmJ3OUYvK0dZd2gxYlRNdGpTZFJXOEhPSGdtc3R5SWJ1L3p4?=
 =?utf-8?B?bysvQUtmdm8zVURLMDVzeWllc1RBeDlYenJzMzZWbWhaWHVubW0rZFNKUDhq?=
 =?utf-8?B?elpLTzZzSkhhdWVFdDBhcUx3NjdZbWJ1WXcwY2IxUjJRLzlnRTdySDhoRWVm?=
 =?utf-8?B?QnN1ZC92Q3VMakZJVmVhRWlqb2lIa3M0Q3hadmRFbmRZcDgvN2QrclFJTmJ0?=
 =?utf-8?B?bW4xN3dmK2s2SnBHYllFem9oTEtEZFQ2VHJhZ0ZOU0hvTmR6cEZJYmNoUFFQ?=
 =?utf-8?B?bWVqOUVlQ1U0c0NFaHlYQ01YeXlKZVJ3dWxHU3dYbmFXNDFsb3l3UzZOakJH?=
 =?utf-8?B?STk0aU1SbGdGQTIwSm9FNGdyeDlsYzVWYzlkczhLdG50bVJKMUROdkNjZEhl?=
 =?utf-8?B?dWZWcHFlb2xCdXVwSTRydTYwdEV2TC94N3F5ZDEyZGo5UEI2WW53U1R6R0hK?=
 =?utf-8?B?VkFMbm9wR3VEbjN2MFRTdjR1NXRSaGt5UWl3OWF3Q20vZGhYeDJyQnZkNWZh?=
 =?utf-8?B?cnM4ZGRxaUQyeVJiNGRKVTlzNTJJT2ZBU0VuNE9wUUpRT3Y2cklNSmViN2tS?=
 =?utf-8?B?U1BaS2xlaFpVN0dGeUJTTUZsRnRhclRvNWM4RXlZeSt3c3V3Y2FGL201WFdt?=
 =?utf-8?B?aGdnZE4vcTNQZnE2YkVzbU85THlXclFHNFo4Z3IrUVB4ZngyYWMxOHNTUVha?=
 =?utf-8?B?eS9NUWRXdlJ2bnQzL3ovRm1Na21TR3FCbmZkb01COEkrTlB5WTBYcUw1MXJM?=
 =?utf-8?B?UUFRd2FHdGhCc2FLV3p0OHNPNUt2dE9pMWJiOXd0ZlBQYkdHTXFlUzVkWkZ0?=
 =?utf-8?B?cTRuVUcyMVdmekRGRmJHeFI4d3hCVGd4VHZCWVNSMm81Y3NhSTdPeDVVa1B1?=
 =?utf-8?Q?fABgVlpSamvzIcX2YbiDR7hNY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9B2CFFC8A13E845AA83855602DA5F6D@FRAP264.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: csgroup.eu
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MRZP264MB2988.FRAP264.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd6e4eb-4c87-4106-1259-08dc7f0479be
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 May 2024 10:53:57.8657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9914def7-b676-4fda-8815-5d49fb3b45c8
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4DYl2Vv/Gs4a68WnqH3dQH8IKQx2LlXUsw3i86kNSAG+Qhqragb2zPwZbsiPQsM0n3QVF9gJS1omR5pNjvcPSsqIu9tsOg3uDTlZ3U8gMGY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PATP264MB5206

DQoNCkxlIDI3LzA1LzIwMjQgw6AgMTQ6MTAsIE9zY2FyIFNhbHZhZG9yIGEgw6ljcml0wqA6DQo+
IE9uIFN1biwgTWF5IDI2LCAyMDI0IGF0IDExOjIyOjI4QU0gKzAyMDAsIENocmlzdG9waGUgTGVy
b3kgd3JvdGU6DQo+PiBJbiBvcmRlciB0byBmaXQgYmV0dGVyIHdpdGggc3RhbmRhcmQgTGludXgg
cGFnZSB0YWJsZXMgbGF5b3V0LCBhZGQNCj4+IHN1cHBvcnQgZm9yIDhNIHBhZ2VzIHVzaW5nIGNv
bnRpZ3VvdXMgUFRFIGVudHJpZXMgaW4gYSBzdGFuZGFyZA0KPj4gcGFnZSB0YWJsZS4gUGFnZSB0
YWJsZXMgd2lsbCB0aGVuIGJlIHBvcHVsYXRlZCB3aXRoIDEwMjQgc2ltaWxhcg0KPj4gZW50cmll
cyBhbmQgdHdvIFBNRCBlbnRyaWVzIHdpbGwgcG9pbnQgdG8gdGhhdCBwYWdlIHRhYmxlLg0KPj4N
Cj4+IFRoZSBQTUQgZW50cmllcyBhbHNvIGdldCBhIGZsYWcgdG8gdGVsbCBpdCBpcyBhZGRyZXNz
aW5nIGFuIDhNIHBhZ2UsDQo+PiB0aGlzIGlzIHJlcXVpcmVkIGZvciB0aGUgSFcgdGFibGV3YWxr
IGFzc2lzdGFuY2UuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoZSBMZXJveSA8Y2hy
aXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1Pg0KPiANCj4gSSBkaWQgbm90IGxvb2sgY2xvc2UgaW50
byBLU0FOIGJpdHMsIGFuZCBJIHRydXN0IHlvdSB3aXRoIHRoZSBhc3NlbWJseSBwYXJ0LA0KPiBi
dXQgb3RoZXIgdGhhbiB0aGF0IGxvb2tzIGdvb2QgdG8gbWUsIHNvIEZXSVc6DQo+IA0KPiBSZXZp
ZXdlZC1ieTogT3NjYXIgU2FsdmFkb3IgPG9zYWx2YWRvckBzdXNlLmRlPg0KPiANCj4gSnVzdCBh
IG5pdCBiZWxvdzoNCj4gDQo+PiArI2RlZmluZSBfX0hBVkVfQVJDSF9IVUdFX1BURVBfR0VUDQo+
PiArc3RhdGljIGlubGluZSBwdGVfdCBodWdlX3B0ZXBfZ2V0KHN0cnVjdCBtbV9zdHJ1Y3QgKm1t
LCB1bnNpZ25lZCBsb25nIGFkZHIsIHB0ZV90ICpwdGVwKQ0KPj4gK3sNCj4+ICsJaWYgKHB0ZXBf
aXNfOG1fcG1kcChtbSwgYWRkciwgcHRlcCkpDQo+PiArCQlwdGVwID0gcHRlX29mZnNldF9rZXJu
ZWwoKHBtZF90ICopcHRlcCwgMCk7DQo+IA0KPiBXb3VsZCBpdCBub3QgYmUgbW9yZSBjbGVhciB0
byB1c2UgcG1kX3BhZ2VfdmFkZHIgZGlyZWN0bHkgdGhlcmU/DQo+IA0KPiANCg0KV2VsbCwgdGhl
IGNvcnJlY3Qgd2F5IHNob3VsZCBoYXZlIGJlZW46DQoNCglwdGVwID0gcHRlX29mZnNldF9rZXJu
ZWwoKHBtZF90ICopcHRlcCwgQUxJR05fRE9XTihhZGRyLCBTWl84TSkpOw0KDQpOb3csIGlzIGl0
IG1vcmUgY2xlYXIgd2l0aDoNCg0KCXB0ZXAgPSAocHRlX3QgKilwbWRfcGFnZV92YWRkcigqKHBt
ZF90ICopcHRlcCk7DQoNCkkgZG9uJ3Qga25vdy4NCg==

