Return-Path: <linux-kernel+bounces-176040-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 611448C2924
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 19:13:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1427B284F28
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 17:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAC318039;
	Fri, 10 May 2024 17:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="ITMXj7Sb"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2102.outbound.protection.outlook.com [40.107.220.102])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B67C17C7F
	for <linux-kernel@vger.kernel.org>; Fri, 10 May 2024 17:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.102
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715361193; cv=fail; b=Hxarjn55jj07fIu4AMwwwM0xvKqeK6sffR/qnfAYgqE7OrqEBKG0+kj7Ny+7+34BPvnoNKf3MBOBgovkFYhdN0B/isOLPOcF01PwpaK5+Vz/azcvMTbAgH4Glt1+lByFj15+NUX2C4KH5p5XgXLp/oPVc+c08fuV2syHwbb20go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715361193; c=relaxed/simple;
	bh=2qeweUc/SBeY/mJF1LBiEC0XJEO4fpG/BcE1TJyjVfQ=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dO9eyz22UvMk8u5Lf/SfjDHPpgLtQ3XleeAqDtrEXkZOjOrlPcn8LKXJRtVRmud2YSB+8uaa/gggByeQgxZewfggKo0SQ8ahcU2oHLuAYvCc0qUjPMLQmzOJuK1zYA2pkwfvaidOAHh4n+4APJ+LMJriG//4DjD1FgsG5iPSMuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=ITMXj7Sb; arc=fail smtp.client-ip=40.107.220.102
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L4nBjwsM1twf6zWv7mDSuBhOkUg8li7C3LbBqYxtvcDolXJVMKTruw7yAUh25PLOWRlxtMrYBhLX5jPalLkNXeSzt5bCtMlZws5bJOx9TOc1pBNRotTKsNhH0YQJR33wZW5WCxsr//sKGRANcBwrrOzLx2R5P94HwDnAStBPH9BqtKPgJWNrSCmsuBlJ1OtoJZYLY78j8Vn6sHzYv1t6Dc8W/o2sJpFegv/MmeGtgs3bzPz/0apKl1QiLKJlOZ8BATGD40epXO7IxhuLzH/RjzfPGnz/vsUm52c2aXwn6qiXe+u0SmB8RTYTscuhve/rbltx75bLWMXiT1zme2fgdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l2LuaXrlNBHEZdXI0joW99iWrjjjpXUDwJoEUqwutxw=;
 b=AyAWlhSecimRVTxX16N8w4wRkFhauvpQtTZSMdLwjNH/hMw8uyMx6yVAUUJpiSFMwIan70KCgPVzaJ4APCus9Q4p6tuCJjrEQfG2Cx+VjL4eynVQoKYwdCIkg0pAeGeWVh06kehH9X3Fj6GhgevaQ0Ig1dIQDU+1UrvMCffkJUrdv6Lk+U9+jidxSse+TsHwbwN6vuEDRAVSdOK8ljmS3imMIQ8YI5mszFCdgJopj8b5TI/TZ95v0ffmXXQsKsoAAmC/ACHWZvHSCy5KZ5RK24lvzHDzdo0kuMrtTGYdjdAhgWo7zxsi5Z0TtIZtPnV3trLP1ps/6Y08bQ848XKKeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l2LuaXrlNBHEZdXI0joW99iWrjjjpXUDwJoEUqwutxw=;
 b=ITMXj7SbQC16Km1b071yjEg9/koXNbWOBZjYEeZiYQpcOB1hqqy4d+vSIuE4khWW/yJ6CACLmqCxSwRA6H2kVwG4N9yBseHv5vdUSa5TJGYffCblUlVb+7hbyrHri5XmI7ZMW8eCqW0vGQUiDUdUQFkvKZcyCk4fWj9ypyU5L+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BYAPR01MB5463.prod.exchangelabs.com (2603:10b6:a03:11b::20) by
 LV8PR01MB8653.prod.exchangelabs.com (2603:10b6:408:1e7::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.49; Fri, 10 May 2024 17:13:07 +0000
Received: from BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955]) by BYAPR01MB5463.prod.exchangelabs.com
 ([fe80::4984:7039:100:6955%4]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 17:13:07 +0000
Message-ID: <6066e0da-f00a-40fd-a5e2-d4d78786c227@os.amperecomputing.com>
Date: Fri, 10 May 2024 10:13:02 -0700
User-Agent: Mozilla Thunderbird
From: Yang Shi <yang@os.amperecomputing.com>
Subject: Re: [PATCH] arm64: mm: force write fault for atomic RMW instructions
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: will@kernel.org, scott@os.amperecomputing.com, cl@gentwo.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240507223558.3039562-1-yang@os.amperecomputing.com>
 <Zj4O8q9-bliXE435@arm.com>
Content-Language: en-US
In-Reply-To: <Zj4O8q9-bliXE435@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR13CA0057.namprd13.prod.outlook.com
 (2603:10b6:610:b2::32) To BYAPR01MB5463.prod.exchangelabs.com
 (2603:10b6:a03:11b::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR01MB5463:EE_|LV8PR01MB8653:EE_
X-MS-Office365-Filtering-Correlation-Id: 645205f5-7bf2-4027-81ae-08dc71147604
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEx5YnpkdmNrRXdkc2YwY1F2MkQvT0dBWm1XbGZsMGM2ZklTTWpiTDF6ZUQ3?=
 =?utf-8?B?SzN1bnB4cTdLUjRLcDArUi9KNHZZTTZMWVpCSXhkdGFuS1RFSzJPTlJVbDdh?=
 =?utf-8?B?TVhEYlJBdmZ6MDN6QlpzcWZncXM1M1dYRGhCUm1CWldlaWZ3cG5FY09KVFdF?=
 =?utf-8?B?MkxKNTA3TlZuSTBTc3lQellLNm1OOFBrZVlCM2V0Z1dhOUU0cUZqVG9rVzM0?=
 =?utf-8?B?NkpCbE9EWGRhNHVEZHc3b2lXbVZBcGN4WHAxTEloOGkrRStsckEyVUhIM2ND?=
 =?utf-8?B?QldwcWdnRktDL1JtNlZaaUFQSGt2QUl0NzB4OGh4Ui9vSGJ4WkEvVGRCU080?=
 =?utf-8?B?WEJ0RThHWnlSdWFiL2lTYlpJbnNoRXU5a0p0RkxWOEV2c0dWa2NXWitKcnRh?=
 =?utf-8?B?aENrdnNnUTkySDYzV25LbzJyTDRtWkRTZ3JQckV6YjdOMk42UVFvVzR6M21Q?=
 =?utf-8?B?K283ZnhzL0lVaDRRNVBsQUMycjBtbm91amkxQjJOMW9xdFJYcTFmZTBSZUJY?=
 =?utf-8?B?VFNzUHQwMzhMSkZ3L0s2VzM1OFB5a3BMMkIrZDduRlBseU5ZVzFxSiszRjV4?=
 =?utf-8?B?UWJUTldkc0NpTUptZGQ2NjA1RVdCenRIa1AyTWUxdFhKclJ5N2ZJU3VpQnlT?=
 =?utf-8?B?a1doRkc4OHZDNWk4V0xJb2haV01hNERvV1AzZysxSzBYOEVzYkJIMHJlNFBh?=
 =?utf-8?B?TDFuejNYaCtwT3RxNEtEdFZPVXIzZ2RVT1RjcWJyWmc3N2wxeXgya3VKMWlo?=
 =?utf-8?B?ZStjemxaYVNITlpxNm5wQ01UREYrTEN3M0xnbWwrTWtsVDYzd2ZDeGo1MHdz?=
 =?utf-8?B?clpQTFZLMGd3WnN6a1FwbmFieG1YSmFONlhMZXN4aUdGKzRkeTVnL1N6VWlw?=
 =?utf-8?B?ay80Qm9Jdk4vb2xvQnYxSUtubkxHSVRhTFdpcTlUVjY2cU02bm9yV0dCMlNo?=
 =?utf-8?B?L3ZiZEx5djM3T3hwa3ZUTGZCZkMxaXAvV1IrY1NqaFJ0Yzc0VlJZZGZVWjRF?=
 =?utf-8?B?U3BxMkc3Y1V0Tk5zdmdyUTZwdEZUcGN0RHExMjg3VElJenBxdERXQnEzN0RM?=
 =?utf-8?B?cDNtM0lxQ3ZrWC84Wlhad1pxME1kcXZ0QUhHQ1dqZExVQU9meW1wZERHajFY?=
 =?utf-8?B?NGIrZ2RGck1kRUl6OWxjblJaakNDQThFM2pWSi85cXBEaHB6eHRtTUFWdEtM?=
 =?utf-8?B?bS9DeFF3K2doaDkrK3psNFRGS2hmbWxVTlpsOW1Wa1loNThEN1NualRuRlBN?=
 =?utf-8?B?VjdUUWdqK2JNUktDU2gyZEhuSGI2WXd5aUwrc2NmcUFHb0JwZWtXY0Z5RVc0?=
 =?utf-8?B?SUNrdGJIeTdDcUhFK3k1VkgwZFZSRzArV1l3bWptTFVZTkdiWVFUZEptdHFE?=
 =?utf-8?B?dTI1UDlxbUNnQUlzSHd3L0FLaTdTOWl6NnZKMlZtTGlXZXVQZjB2UzBjOFJI?=
 =?utf-8?B?S1NRdUZwMjF6NW92dTZyRU9Uak9vSzZlWDVKSHp3L3JYeGF3Q1RnS2VJUVEy?=
 =?utf-8?B?NDhRY3lWbE0yQ252SUhzUzlIUFlHeW9RK0NIaWIvZDdEb25pWHQrR0VUT0xY?=
 =?utf-8?B?VlVWNDcycWlUUzdRSUk4bmV6TDRCeGh0R1pEUFA5N3RxMDdHcmQzMFI1akdM?=
 =?utf-8?B?RWtobThVeDBoeDhES1REMXp0ZkdPWkVXOE1zYzYrQWMzMXFiaFJuNktSajJw?=
 =?utf-8?B?V2RYcVVGbkVGalZzZE5xTnBVdEExVjNVRTE1L0ZJVzNIZEZtc1hEYkhRPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB5463.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZTk1encvMUZ0ZVRpYjFFTTdkUmRDbGNQV0ZlTjE4YjZya09qQWh4L0twdjBG?=
 =?utf-8?B?MHZ6ZVp0QnZNU1U4UlIxSlNKU1JrY2hIbW1rUi8rQWtEOUdYcXk4V3NUQnhz?=
 =?utf-8?B?b2EwdUNCaXFiL1BJR2twTnUzZGhKMSswRWlJVVgyLzVKblZTUktiVk9IM0Vk?=
 =?utf-8?B?bFBnNmlxc0htUEhEbE9WWWplei9heWRyVDRhdG12a2pQdTJUamhBbHA5bllV?=
 =?utf-8?B?aG9Jay9wUzRPTmExdnJIbWFiOFhydDUxN1N2VHA2NldNZFdCdEpJazVETEkw?=
 =?utf-8?B?Yld0Q2pKSnY3ZjRCWnJrQk1SaHBCNE9CN3JsczF5NXRaN3RIQlVtR3dqWTFI?=
 =?utf-8?B?WEtCb3MzajQvUVJlTFV0YzNZSFRXMnBUZ3A5b1U5WHhNR0svMWY1bS8rTGR0?=
 =?utf-8?B?VGUrVGhNSzAzeml6RnRXMGFDRndZYmhMM1RFMUE0bzVEM1IvcGoxTitzcU43?=
 =?utf-8?B?c0VsZUxrdVJYUGsyVzdzQUZPS081bWx1cXllTVdhenZQMDNVc0VJK2F6K0FB?=
 =?utf-8?B?T0VhVXAyT3RkZC9YOVN4MG16UzVEbW9PeDAxTUdTay96cXBobHBUY2V3ei9k?=
 =?utf-8?B?SG9ndGY2RDVDV2M5OGhuVi9nSzlrTk5KbE41eXlNYnQzTS9oVGh4UjUwdDl0?=
 =?utf-8?B?TTJyeWpkYkhIc2RWS1ZKT2N3RWRnaEt1Zi9VOFllYkhHeGtiVTBYZ1ZJK3lC?=
 =?utf-8?B?eDFuN3Qxd1pPRFJlekVoUisyeHpMQUM0cGdZK2dBbjRrZ3UvV1ptMU02Sy94?=
 =?utf-8?B?U1RVc2FZZktUVEJwWnV2T29wTDhQSHBkbDhqVGdCNHlWdTlycnhwUE9DTEtE?=
 =?utf-8?B?VjhpSkMyL0FmUlJQOGhsaFZRSmhDUlpMQzhyUWg3dk1TMFhqQWJKQUZ6SHNt?=
 =?utf-8?B?Y0VvYUZMc2lHQ1l5N3IxcTZ0b3Bpa0krY3BMMitvZXdQK1JpU1lsaTJCZTBZ?=
 =?utf-8?B?R0ZteTVhTEJRNEUxK2MvajBGSWZERE5KWk56eHNkVkpReXREVVpla3ZBaTU5?=
 =?utf-8?B?ckVWWjNLMmpvTlZDSVBMMGE0VDE5SndGanFJQ0JETXBxMU56MTNiZFkzdWJh?=
 =?utf-8?B?ODlZZG4xUTZkSjA5WUtZQTVYY1RLOXJ2K1hpL3JvazB1Z3JpUTRYT2FoalZk?=
 =?utf-8?B?YTg2MzlLM0hYSHRSeUZ6Yyt6bWd4YmVVcUtxWHVXdXpNREFlSmNHWFptRjl6?=
 =?utf-8?B?VDZSaVAxZ0dDMVR5VWNnSnVxclM1NDhmOXJsOTU1aUtlNStQb01scUxVZ1V6?=
 =?utf-8?B?UFhmeDIveXdmTzNSWm9xdzB4WXpiSVNGeWQxTEV4TGJJb0NSa1lEcWJUZU5E?=
 =?utf-8?B?L0VyVUdqcTlBZDBkSkhzYTVvVGxiNERXTzU1cnFyYnJ1bmdFMmppWUxWaFU0?=
 =?utf-8?B?VHBWVFZxdDRRYlhaOVRiR1FURitRbWl6TzNFWjIyOUUvTGFnT2FpVlJ6elJ2?=
 =?utf-8?B?VDN1SkNuU0diZldNYy8rSFFpYnQreDZCR01rU0M0S2FGTUZxUEMraFZLVU9s?=
 =?utf-8?B?dDNLZTBYczNRTzZjMFVWOGM5VDNldWp5NXRBeXlDamlRNHlKOUdhYVI1SWgx?=
 =?utf-8?B?bjdqdStZRHlBWGw1ZW9GbWtRdDNyV0E4ZWdlMjRERmd5dk52RXd5amU5MjQr?=
 =?utf-8?B?cDYwSHBGRjdOa3ZHV1hZcEsyK1c5K1lJS2lvN3czN1lKNllvbkx4NWhta3FT?=
 =?utf-8?B?ZE81dWRLalp4ejArR1R1dlJrR2FleHFXUVpBOFBlMDBjYlVqV1JmbWNVRFYx?=
 =?utf-8?B?SVdzOVcwaGdNLzFNZUZib0Y2M0RTSGNkYm11Z2Z4Y1pJTlVHd2Z3RnVxUEQ2?=
 =?utf-8?B?aTQwSzRrT2RGZnZFWFUzYnlwWFEvdk5NUWc2S0NJbmIzMXFMb01nME8rNEla?=
 =?utf-8?B?YitvQjZHVVA1QnQxdmxXcklyd0dRTTJvcnF2UnJMbGgzMy9KSDM2WEM2ZHVq?=
 =?utf-8?B?OWNGeHFPNTVvQWZ6bTN5a24wZmJJNXpFck5OQmlJVVVYMVZ5VmdoM0FZUDhO?=
 =?utf-8?B?ZCttbUNmZEpQaGFFM0J4VjBJOVh6V0I5YlNWdFlTdkU1MjdwckNnenFDUHIv?=
 =?utf-8?B?L0JTNEFoK3MvZzFNM3RNMDJ5Nk1ReHdCOXVhMGxYRUtuQVNmQmkvc29kSThu?=
 =?utf-8?B?Z01kYjlYZjNtKzRldFdyTmxWdlEvT1J6em9LUGoyNGh4WlEwbUV5VUk3MitF?=
 =?utf-8?Q?PgxPRa6q8UYLjglk54WigAk=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 645205f5-7bf2-4027-81ae-08dc71147604
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB5463.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 17:13:07.3884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uCiayhmoof6E8RLBQojglastLxTVhjMGA0ogRDYJrOkYVJs3eYIAYB+eWtojAc5hRUFhEqI1EoiEikRMAh1hNemS6jDNhbjqFahWSn6K2NI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR01MB8653



On 5/10/24 5:11 AM, Catalin Marinas wrote:
> On Tue, May 07, 2024 at 03:35:58PM -0700, Yang Shi wrote:
>> The atomic RMW instructions, for example, ldadd, actually does load +
>> add + store in one instruction, it may trigger two page faults, the
>> first fault is a read fault, the second fault is a write fault.
>>
>> Some applications use atomic RMW instructions to populate memory, for
>> example, openjdk uses atomic-add-0 to do pretouch (populate heap memory
>> at launch time) between v18 and v22.
> I'd also argue that this should be optimised in openjdk. Is an LDADD
> more efficient on your hardware than a plain STR? I hope it only does
> one operation per page rather than per long. There's also MAP_POPULATE
> that openjdk can use to pre-fault the pages with no additional fault.
> This would be even more efficient than any store or atomic operation.

It is not about whether atomic is more efficient than plain store on our 
hardware or not. It is arch-independent solution used by openjdk.

I agree the applications can use other ways to populate memory, but it 
depends on the usecase of the applications. And openjdk is just one of 
the examples, I can't scan all applications, but it seems like using 
atomic-add-0 to populate memory is a valid usecase.

> Not sure the reason for the architecture to report a read fault only on
> atomics. Looking at the pseudocode, it checks for both but the read
> permission takes priority. Also in case of a translation fault (which is
> what we get on the first fault), I think the syndrome write bit is
> populated as (!read && write), so 0 since 'read' is 1 for atomics.

Yeah, I'm confused too. Triggering write fault in the first place should 
be fine, right? Can we update the spec?

>> But the double page fault has some problems:
>>
>> 1. Noticeable TLB overhead.  The kernel actually installs zero page with
>>     readonly PTE for the read fault.  The write fault will trigger a
>>     write-protection fault (CoW).  The CoW will allocate a new page and
>>     make the PTE point to the new page, this needs TLB invalidations.  The
>>     tlb invalidation and the mandatory memory barriers may incur
>>     significant overhead, particularly on the machines with many cores.
> I can see why the current behaviour is not ideal but I can't tell why
> openjdk does it this way either.
>
> A bigger hammer would be to implement mm_forbids_zeropage() but this may
> affect some workloads that rely on sparsely populated large arrays.

But we still needs to decode the insn, right? Or you mean forbid zero 
page for all read fault? IMHO, this may incur noticeable overhead for 
read fault since the fault handler has to allocate real page every time.

>> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
>> index db1aeacd4cd9..5d5a3fbeecc0 100644
>> --- a/arch/arm64/include/asm/insn.h
>> +++ b/arch/arm64/include/asm/insn.h
>> @@ -319,6 +319,7 @@ static __always_inline u32 aarch64_insn_get_##abbr##_value(void)	\
>>    * "-" means "don't care"
>>    */
>>   __AARCH64_INSN_FUNCS(class_branch_sys,	0x1c000000, 0x14000000)
>> +__AARCH64_INSN_FUNCS(class_atomic,	0x3b200c00, 0x38200000)
> This looks correct, it covers the LDADD and SWP instructions. However,
> one concern is whether future architecture versions will add some
> instructions in this space that are allowed to do a read only operation
> (e.g. skip writing if the value is the same or fails some comparison).

I think we can know the instruction by decoding it, right? Then we can 
decide whether force write fault or not by further decoding.

>> diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
>> index 8251e2fea9c7..f7bceedf5ef3 100644
>> --- a/arch/arm64/mm/fault.c
>> +++ b/arch/arm64/mm/fault.c
>> @@ -529,6 +529,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>>   	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
>>   	unsigned long addr = untagged_addr(far);
>>   	struct vm_area_struct *vma;
>> +	unsigned int insn;
>>   
>>   	if (kprobe_page_fault(regs, esr))
>>   		return 0;
>> @@ -586,6 +587,24 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
>>   	if (!vma)
>>   		goto lock_mmap;
>>   
>> +	if (mm_flags & (FAULT_FLAG_WRITE | FAULT_FLAG_INSTRUCTION))
>> +		goto continue_fault;
> I'd avoid the goto if possible. Even better, move this higher up into
> the block of if/else statements building the vm_flags and mm_flags.
> Factor out the checks into a different function - is_el0_atomic_instr()
> or something.

Yeah, sure. I can hide all the details in is_el0_atomic_instr().

>> +
>> +	pagefault_disable();
> This prevents recursively entering do_page_fault() but it may be worth
> testing it with an execute-only permission.

You mean the text section permission of the test is executive only?

>> +
>> +	if (get_user(insn, (unsigned int __user *) instruction_pointer(regs))) {
>> +		pagefault_enable();
>> +		goto continue_fault;
>> +	}
>> +
>> +	if (aarch64_insn_is_class_atomic(insn)) {
>> +		vm_flags = VM_WRITE;
>> +		mm_flags |= FAULT_FLAG_WRITE;
>> +	}
> The above would need to check if the fault is coming from a 64-bit user
> mode, otherwise the decoding wouldn't make sense:
>
> 	if (!user_mode(regs) || compat_user_mode(regs))
> 		return false;
>
> (assuming a separate function that checks the above and returns a bool;
> you'd need to re-enable the page faults)

Thanks for catching this. Will fix in v2.

> You also need to take care of endianness since the instructions are
> always little-endian. We use a similar pattern in user_insn_read():
>
> 	u32 instr;
> 	__le32 instr_le;
> 	if (get_user(instr_le, (__le32 __user *)instruction_pointer(regs)))
> 		return false;
> 	instr = le32_to_cpu(inst_le);

Sure, will take care of the endianness in v2.

> That said, I'm not keen on this kernel workaround. If openjdk decides to
> improve some security and goes for PROT_EXEC-only mappings of its text
> sections, the above trick will no longer work.

I agree the optimization/workaround does have limitation. The best way 
is still to have the spec changed to trigger write fault in the first 
place. But it may take time to have spec updated then have real hardware 
available.

Though the old hardware still get benefit from this optimization.


