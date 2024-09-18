Return-Path: <linux-kernel+bounces-332787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBE197BECF
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 17:44:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4C1B1C21448
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 15:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C5B1C8FD6;
	Wed, 18 Sep 2024 15:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KTmRavRu"
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2050.outbound.protection.outlook.com [40.107.96.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E21E2AEEE;
	Wed, 18 Sep 2024 15:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726674287; cv=fail; b=Y+Qh9ALiewgFgIhI3AVY+IAZF0iYuPoMcC24VLNRGeiubP7fI9/FQ7t3rqQrd88b9ID3APzqFLJaomUC4jpIAuosbDIf1vZllNoAzQ/xHjJzoWJHyzAj/upd/I5T2l3vIpzlH5zkwzZNGo0cZ9lGcUWa2afHpSgDDDTJtVvbxi8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726674287; c=relaxed/simple;
	bh=zX5bYisLAfo3gp9pqtx84FHzsLmIFaqjkxkte3AX9Jw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=E0rWmGEwBtezTEREPI2SoA/97OR80368dGGXw0Eh94ySPIGfQFmd49sVugnBvke3MG3uoLgQDMcr7skIQT2yJ/3qBGkeNW9j/iNIa2jzkY6tjFnVyofjz9l0mzDezy6X5olPyr39tdC6eAbUaKhfgNER1fZojd9QA5zy01FJ4hE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KTmRavRu; arc=fail smtp.client-ip=40.107.96.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qjQf3SHngOsRj8dLfrWp5j3zsuejW9H4m9J9IAuLbkTabyFs9xF3cCFoJpGS5IsZFZhCGFARogaQGCTSdVO7cRGnqpSjQrN6LBCyOYCvD9hAFlhTcFwJpSOjwHe3tcdjljMWB0HGiiNP7D3ZLWLorAjNnW2E3K1LvZ/nXg/5CWVHmyzKQ0TsqxabDswUmi5GAwpg6aEG4tKGmRGxUlwVVt8qJqzP4JZP0TGngP9ftMnejHvzbVZP5B8tlbLyHwCwzxk1NM0wBZ5OYcoVv5CYEQ5KsOGtJfPttXf3lK+vtoHooUZUUT69MiyK7eP73QpTOIgSN3W1903uLZAKGrwJKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePrS6XzVVdDgWW3YmLGjLYgUzMaOSrOIMU/2qx02LDM=;
 b=Xo6k3r1hbPmUk92WG6bS3MaVC/XL5k4Vq7UnQRKKUG18ac2eoln3B5IFI4uH75qMjndRqn8BuVyW4Vs/1z+pB90tsNZY09k3iC5MJzh4+P7L7smff6P0iWJpmWB85IMQZtGfQml8E7rwOOITVhoCN94f9tKfFYAxt4nYI/m7U4kYQ0HiGliDxYhEzgtGlGeddgXvRyqdcWA9qsz3Hhy3tGQdj/PW3ehIDnYBOcWPFJf0Nf0R7vy1aKP+M3EC2po4a1E+B+AKvaVCS/017JtRp9E55alWKX8XHRWnIcekay0ujbeRL37C6rzabUsP+D0pZvUilXnylkMfXOHCCkOG4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePrS6XzVVdDgWW3YmLGjLYgUzMaOSrOIMU/2qx02LDM=;
 b=KTmRavRuVa/3EzTVBGap3kjaYnBYcEP+3FkEVFAv+5lk1ajpBpnTMFHb4YPJQsXrl0uJbVRnmwN84W+8pQkvQrn/nRXiIQR3LM6h7UpTl5/yZJgwVmQgtgzdDfbNN7e7tLXd11woucNbhBm6sBxoyuzdsGLGx0iavI6c6eN4AwA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by DM6PR12MB4091.namprd12.prod.outlook.com (2603:10b6:5:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 15:44:43 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%6]) with mapi id 15.20.7982.016; Wed, 18 Sep 2024
 15:44:42 +0000
Message-ID: <aaee2e99-d19b-466b-92fb-837093e574b0@amd.com>
Date: Wed, 18 Sep 2024 10:44:40 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/5] platform/x86: asus-armoury: add apu-mem control
 support
To: "Luke D. Jones" <luke@ljones.dev>, platform-driver-x86@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, hdegoede@redhat.com,
 ilpo.jarvinen@linux.intel.com, corentin.chary@gmail.com
References: <20240918094250.82430-1-luke@ljones.dev>
 <20240918094250.82430-4-luke@ljones.dev>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240918094250.82430-4-luke@ljones.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA0PR11CA0008.namprd11.prod.outlook.com
 (2603:10b6:806:d3::13) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|DM6PR12MB4091:EE_
X-MS-Office365-Filtering-Correlation-Id: d7b0712c-437e-41da-a32d-08dcd7f8d05a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eHVhb0xjZmREenU5Ym5UY3FXR2liV1IwZW01WmxoV0M5QjR2K205MXFkZWlP?=
 =?utf-8?B?Ryt3RTRNM2dWekxwOTdNUERGSlFseCs5N2REOUFvZFliT291aEkrNHJEZjJM?=
 =?utf-8?B?eVRSdnRUUWlwVnE3VnMxeUpBK2lHamxhUm9waG5qWEdtY2RkcVp6SDMyZEVu?=
 =?utf-8?B?dlFwWU5ZMGRXelMrNTRlbkJnY2I3N0VncjVwemVmbFNYTDdJajI3MW9OcWM4?=
 =?utf-8?B?RHFTRmZFT0RnVG53aU8zaUU4ank5MVNxSXZuUERBTURpSEZBOCtDNE9lUXZ4?=
 =?utf-8?B?WVdoQWtTekhxdFh6MmluMVBiNGdoZ0RqZXJpSkdVMFFDeW5wV1F6ZTF4RnlC?=
 =?utf-8?B?YmNJTHloR0VyRVkrbWJSc0hWTWNQRDZMUTRSYkhabFNXdVJ5SklJdzNPWFZF?=
 =?utf-8?B?VU00QkNRY0xONG4xZ2NuVlVWWnNGMEJKcURXQzU2R3lpYmpNMnRtdUxCVzVT?=
 =?utf-8?B?Q0xsdFpBbjlEMWZ4bk84S2tXVm5SZWI2VW9uSm91Ry8wYlBHNHA5aUZtcEhR?=
 =?utf-8?B?TjExcElJbDg4b0ZKa0dhRzNxVkMvcHBtMUVxbTllaXpKbms2VTlEazl5bnp4?=
 =?utf-8?B?Ris4YW40VWNRSndOdmxKYlB6QXp6dTRjT1ZKNDUzV2JGWVhYajdUY25JaFB3?=
 =?utf-8?B?NFRKeGM3RjlMMHc5Yko4czgzcTU4YXZDbUFVaEN5T042VFF4NjliSm0wamp5?=
 =?utf-8?B?U0RDZzdHaUNSQ0hGNDlpc3ZIYzJHaXhHcUd1ZGNncjJWQ1dhOU13bENyY2NG?=
 =?utf-8?B?d25rUEdGaHpRRFZwUDdIWTJqYm41VUNlTWxDU1orZ3V3MWRKd1ZYOTJvK2Zn?=
 =?utf-8?B?UWptTktRRlBKbmZTTkFVRmdReHBtOHVrZEJjYkRsVW0zdWU1eUVGWEh1VGNF?=
 =?utf-8?B?Tk9uK0Z4cTRLVTBVOXpBcjNsSXN5d3NOM00yUmRHR0RvWm1ZT3l1NXJkbngx?=
 =?utf-8?B?SS9ENUhrdmZmS29XbkR4WGpNTUU4RjlaSFN1Z0dKbCtFOENWdmNWOVV5SHlH?=
 =?utf-8?B?b0p3cURjNDBEWWtIVjNtSDVTRE9qVU4zM0U4TjZ0dFdoRVVrVHFpUnJINHJL?=
 =?utf-8?B?dXdQV0dZbk1zakNKeklza0RwcE9GNm9LMTVqWWhqelovem9GWndBSi95SGFw?=
 =?utf-8?B?b2F1K2ZMYWtaU1pOZjRYRkxNeFRXZkx2UE9STzZMWkZXSXdaUVl1emVrNnlU?=
 =?utf-8?B?NkxnRkVHVStUczY2anhyTVBkcFdUTUFRR1p1SGs1Si9RcmhFQmZ1cklOY0J6?=
 =?utf-8?B?OEdkUlBMYiswQkRnMDQxZDl2OFUrL3Q2MENmdGt0ODNxdnlYQUhVM0oyNnRP?=
 =?utf-8?B?SkUxclpmdktVQ1EyK0doVFlaOFBjZU5lUjBBL0xsWDhuZUpseXlKOFBLNjh2?=
 =?utf-8?B?N3FIMEZ4Tk45U1pWMWRNTS9LQk9rS0RWblVQQ0NMSzFnQ253b1c3dnl1d1BW?=
 =?utf-8?B?WTRJWHdyL0E3UjFKYUh0NDloTFdoTTFMaWszdHVYVENBa3NuRVVCd1Fwc1BQ?=
 =?utf-8?B?bVJzR08ra1Zsc2xzQmFaUFhNOTF4dWROcXJpS0pzaGJiTE9tRWdkVnlpY1pR?=
 =?utf-8?B?TVVRbDdHTko4RWVLTm1tU0RSaERwRFlYYmsvMXBmK3hSeDVUYzBudENyQnpW?=
 =?utf-8?B?ZTRiWXVOV2RFVTlRZ1A2QmFQem0rNUFPS1l2b2hWM2ZPQ3JnZEs0cEhVMWFW?=
 =?utf-8?B?Y1JyWVZkSWNkT0tSdWFFVXV2SmZwSXZSdjgvVTdKMEE0NFE1Nk5rMXcxalJw?=
 =?utf-8?B?ZXk3cnlEOW1WaVRzV0dFOTd6RkUydVN2ZS9UV3VWcEFjNk5wamRINHJUSmZP?=
 =?utf-8?B?YTd2LzN6Z2tsT3dJSE16dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dndkNlRGaE1acVpWRFdXTk9VU3lDdHFhcE9nM2svcUlKL0JUM3h5elc4UkVr?=
 =?utf-8?B?V1hqWGdBR2dMTnp2TlhJd3dZS2tqWDRlVWJXNEJPNlJJY1N5Z0dkWkk2MzA1?=
 =?utf-8?B?SW5CZjNhRzVxQnMyQ29VUndpWVBGVDhuSXJIaXlMOEhnZ1ovcjlQaVNlVmt4?=
 =?utf-8?B?OHpUYzZtMEdqYWlIaXA1N0p1RTBIMWhtaC9mVENzTDFTVEJGRG1YdWJDSU0x?=
 =?utf-8?B?eUNteWM2WmI4RHVySnRrcmxqM1N4QmhCMzF5RFNrZUFDMjh0LzByUmpxQ1lJ?=
 =?utf-8?B?N0hEYjBSR3FvRkkraDU4dlB0UjNPQjlRdVQrckV1SXBtRzI3WTFPMXExalZY?=
 =?utf-8?B?RUJFZFgzVkQ3aUJ3a09BMGhCbnRPT0pES25vN0NpekJLenRGSUtGMXdnSnQw?=
 =?utf-8?B?MmNXOWpCMjFCN1o0Y1BWcGlDT1NmRFV4eWJQeTVFQ09VUm15SlpINXdWTXpr?=
 =?utf-8?B?ZzZxZVJvNmFiS2lsb1JJQzBIOUFLTFhUQmZRUGFSTDZJbXAyalVlZm5lWmNX?=
 =?utf-8?B?MnVhcUNUY01GYkxmQzhWTUlEUytDWGtaZ0dQSDVJUlE4NHpPUURkMnJZRWtJ?=
 =?utf-8?B?VWRlVXd0QUdDYSt2Z0x2eGdxUGtmMkFlcnR1bVZIaE1Nd0hjc2xxK2ZxRG9o?=
 =?utf-8?B?TCs1OXo4bDdDa2NYQWtXQTVCS2tQWjlNV2tNS2c0dnBIM2tSMHNRTGk4Y3Jp?=
 =?utf-8?B?dmxGYzV0bXAzaDROVVJYc093WjNERVJLdTdKcUZ1ZzVRTTJNUm5yNjBsbjlB?=
 =?utf-8?B?NVRPRTdoSHRmVXVJYjF3RkVMcjFiOGtzRWZoSDZyL3ZQOFFuMlNFbVZBR2Zp?=
 =?utf-8?B?RmlNbDIwTCtKRXJPNC9GOVVmNEZGWktKTkNBbmRrOUZySnArOTU1U0RjY3lh?=
 =?utf-8?B?N3RrRGVsN2pFYWplYzJqTXcwdHhCZ0hDNno3SnY2cWlORjZkL2dMMTNDbDIx?=
 =?utf-8?B?VGRHNGdJZlkvUW1aaVI1UzNhOHJ5eThlNkZrWXhhcnBGVGJlYTZ6c3RJdDNH?=
 =?utf-8?B?blhpQ09JTlRpSHMveDdVWnRLZGFNeTlsZXdZUzRvZlJ2dXhwWkpDcHRLZmk3?=
 =?utf-8?B?V0k0YmRZUnY0QUUrejg3UHFhaDh0SHlYY25BdEdTYjF2UmhnL0J2c2sraGxP?=
 =?utf-8?B?YzZRclY5K0ljSGV2TlQ2MjF4elkrNXEraUJ1ekZyY3V4L0xmM1B0ODNHSWNG?=
 =?utf-8?B?QWNCMWFXd3pOQ2tIa3BRMnZIMkF4NTVJNll5eDl1OVJNVUxGeWdqSU1vL0da?=
 =?utf-8?B?MEpCSXVhVDBKZTRneFB3WWt1dlFsQ1lJdm1ZTXFuYys4NzNpTHc5cEVGMVpK?=
 =?utf-8?B?c0ZyZXhyVlpsZGpzM0FHckEwZTlLbFYrLy9RVllMUXZmYm9yUUFrSGRlWnlh?=
 =?utf-8?B?NWE4OHJjU1hKeHVxTDliTTA4OVJLUVROeG5EOG5PQXhlbGMrTFF6R0MwZzVF?=
 =?utf-8?B?SHA3WXNEMUt6blVlci9Rdno1RGo3NkVrMTY1RWRVeTdldnBwTTJpaGo2TGVx?=
 =?utf-8?B?NjJ0eHFvaWl0K2JWbnpGRVZnYjVSejhBMmorb0EwTTZyWEZIM0ZHQU53eDR6?=
 =?utf-8?B?UTMveVlxeXZJbEVWcVNFRmpvamY1SVRYcTZyTUYyV0ZiaUpYMkwyUXhtNVNr?=
 =?utf-8?B?alFqN1o5bGQza2t5dUU5cjVITmpLT01DUWNFU0RhSGFpbjV5ZW1LNndaTUYy?=
 =?utf-8?B?ZVZEOXZaeXJSTUFyWlZmZjBrTFFzKzNscXcrcllLYnUyVzhTM2xzZUg2Tlcr?=
 =?utf-8?B?S1U0cXBzTWpUVGtHcHRqN2hxemJTdUpLblh2Y3ljaStTVGd0QjRwb2s2Mnlj?=
 =?utf-8?B?eWlhcnMramFmbjV6VDJGS1REVmZrS2ZST2FaNm1BNUtwNTU3dEpnM216WFdh?=
 =?utf-8?B?K0tmNGRNZGlmSmQ3OGNiL2JRSVpPaWl3bVdxKzVPSXhsZXVQS2t6OFJrY1Vp?=
 =?utf-8?B?bEw3YWJZbFNML3Y5VTU5dVJQbm5hY1JmVFlpdlVoYlkxTHorWHhrdnJpMjBu?=
 =?utf-8?B?L3JSU05OdUR5c1RxaTcvYTRDeU1DVEpHZ3ZqOVRLb0NhK2prUDNaRWlPVHlv?=
 =?utf-8?B?S0JRME40MUhqN3EyNGZCQUlMeDR2N2FtcXlWNEhrQStiM2JKd2ZqN3p4S1Bt?=
 =?utf-8?Q?cmAfBOQIJgPYWImzcsrZiRjhc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7b0712c-437e-41da-a32d-08dcd7f8d05a
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 15:44:42.8652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rt8aIthFoYX5f8ae1/QpqmClDKP8tuqfzL98MrL8vSlLFxGMRYolM18/f93fJ4i2dN5c3UuzuhRKwejgzFiqEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4091

On 9/18/2024 04:42, Luke D. Jones wrote:
> Implement the APU memory size control under the asus-armoury module using
> the fw_attributes class.
> 
> This allows the APU allocated memory size to be adjusted depending on
> the users priority. A reboot is required after change.
> 
> Signed-off-by: Luke D. Jones <luke@ljones.dev>
> ---
>   drivers/platform/x86/asus-armoury.c        | 114 +++++++++++++++++++++
>   include/linux/platform_data/x86/asus-wmi.h |   1 +
>   2 files changed, 115 insertions(+)
> 
> diff --git a/drivers/platform/x86/asus-armoury.c b/drivers/platform/x86/asus-armoury.c
> index 176ab5f105dd..b276c42f98d8 100644
> --- a/drivers/platform/x86/asus-armoury.c
> +++ b/drivers/platform/x86/asus-armoury.c
> @@ -456,6 +456,119 @@ static ssize_t egpu_enable_current_value_store(struct kobject *kobj, struct kobj
>   WMI_SHOW_INT(egpu_enable_current_value, "%d\n", ASUS_WMI_DEVID_EGPU);
>   ATTR_GROUP_BOOL_CUSTOM(egpu_enable, "egpu_enable", "Enable the eGPU (also disables dGPU)");
>   
> +/* Device memory available to APU */
> +
> +static ssize_t apu_mem_current_value_show(struct kobject *kobj, struct kobj_attribute *attr,
> +					  char *buf)
> +{
> +	int err;
> +	u32 mem;
> +
> +	err = asus_wmi_get_devstate_dsts(ASUS_WMI_DEVID_APU_MEM, &mem);
> +	if (err)
> +		return err;
> +
> +	switch (mem) {
> +	case 256:
> +		mem = 0;
> +		break;
> +	case 258:
> +		mem = 1;
> +		break;
> +	case 259:
> +		mem = 2;
> +		break;
> +	case 260:
> +		mem = 3;
> +		break;
> +	case 261:
> +		mem = 4;
> +		break;
> +	case 262:
> +		/* This is out of order and looks wrong but is correct */
> +		mem = 8;
> +		break;
> +	case 263:
> +		mem = 5;
> +		break;
> +	case 264:
> +		mem = 6;
> +		break;
> +	case 265:
> +		mem = 7;
> +		break;
> +	default:
> +		mem = 4;
> +		break;
> +	}
> +
> +	return sysfs_emit(buf, "%u\n", mem);
> +}
> +
> +static ssize_t apu_mem_current_value_store(struct kobject *kobj, struct kobj_attribute *attr,
> +					   const char *buf, size_t count)
> +{
> +	int result, err;
> +	u32 requested, mem;
> +
> +	result = kstrtou32(buf, 10, &requested);
> +	if (result)
> +		return result;
> +
> +	switch (requested) {
> +	case 0:
> +		mem = 0;
> +		break;
> +	case 1:
> +		mem = 258;
> +		break;
> +	case 2:
> +		mem = 259;
> +		break;
> +	case 3:
> +		mem = 260;
> +		break;
> +	case 4:
> +		mem = 261;
> +		break;
> +	case 5:
> +		mem = 263;
> +		break;
> +	case 6:
> +		mem = 264;
> +		break;
> +	case 7:
> +		mem = 265;
> +		break;
> +	case 8:
> +		/* This is out of order and looks wrong but is correct */
> +		mem = 262;
> +		break;
> +	default:
> +		return -EIO;
> +	}
> +
> +	err = asus_wmi_set_devstate(ASUS_WMI_DEVID_APU_MEM, mem, &result);
> +	if (err) {
> +		pr_warn("Failed to set apu_mem: %d\n", err);
> +		return err;
> +	}
> +
> +	pr_info("APU memory changed to %uGB, reboot required\n", requested);

This doesn't seem right.  If you requested "0", you just set APU memory 
to 0GB?

> +	sysfs_notify(kobj, NULL, attr->attr.name);
> +
> +	asus_set_reboot_and_signal_event();
> +
> +	return count;
> +}
> +
> +static ssize_t apu_mem_possible_values_show(struct kobject *kobj, struct kobj_attribute *attr,
> +					    char *buf)
> +{
> +	return sysfs_emit(buf, "0;1;2;3;4;5;6;7;8\n");

What exactly is the unit for 0-8?  It's obviously not a a multiple of 
base memory, is it a multiple of an adder?

Is this changing the VRAM allocation?  Like does 0 mean 256MB, 1 is 512 etc?

> +}
> +ATTR_GROUP_ENUM_CUSTOM(apu_mem, "apu_mem", "Set the available system memory for the APU to use");
> +
>   /* Simple attribute creation */
>   ATTR_GROUP_ROG_TUNABLE(ppt_pl1_spl, "ppt_pl1_spl", ASUS_WMI_DEVID_PPT_PL1_SPL, cpu_default,
>   		       cpu_min, cpu_max, 1, "Set the CPU slow package limit");
> @@ -511,6 +624,7 @@ static const struct asus_attr_group armoury_attr_groups[] = {
>   	{ &nv_temp_target_attr_group, ASUS_WMI_DEVID_NV_THERM_TARGET },
>   	{ &dgpu_base_tgp_attr_group, ASUS_WMI_DEVID_DGPU_BASE_TGP },
>   	{ &dgpu_tgp_attr_group, ASUS_WMI_DEVID_DGPU_SET_TGP },
> +	{ &apu_mem_attr_group, ASUS_WMI_DEVID_APU_MEM },
>   
>   	{ &charge_mode_attr_group, ASUS_WMI_DEVID_CHARGE_MODE },
>   	{ &boot_sound_attr_group, ASUS_WMI_DEVID_BOOT_SOUND },
> diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> index 86629e621c61..e1aeafdf05d5 100644
> --- a/include/linux/platform_data/x86/asus-wmi.h
> +++ b/include/linux/platform_data/x86/asus-wmi.h
> @@ -136,6 +136,7 @@
>   
>   #define ASUS_WMI_DEVID_DGPU_BASE_TGP	0x00120099
>   #define ASUS_WMI_DEVID_DGPU_SET_TGP	0x00120098
> +#define ASUS_WMI_DEVID_APU_MEM		0x000600C1
>   
>   /* gpu mux switch, 0 = dGPU, 1 = Optimus */
>   #define ASUS_WMI_DEVID_GPU_MUX		0x00090016


