Return-Path: <linux-kernel+bounces-209464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DE89035EF
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 10:22:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDECB289F46
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 08:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F8AF17334E;
	Tue, 11 Jun 2024 08:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="d9aSv+c4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="obbB9zjw"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F0843F8C7;
	Tue, 11 Jun 2024 08:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718094145; cv=fail; b=TazgxOJq7U90wbDi0HZCb46o3n3R/80+aSdOBFgT6U1xjztqtbS6mItQ3Nm1TN3XECcSsG/k1AWLkHkMRT50kpwGNX2zL9ZYbpkA4v7rAEelH4IVEmx32dsI46/PRDxH1jEdEVaY9rp/dXC2xiL8Q21FGZgS7Dy4IpfE3vkVgE0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718094145; c=relaxed/simple;
	bh=qVUP1ekIFO35yKugf5zn08nocaCvbQt6Jj5CuED+XYY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=clfnTMV3Z+fltd2pqhPRO5jZB3KgO4Oi2cYVsCGmn0sQHaheD8x7eDPa0P4fy1MzlEJGvG8YEZ4wAt7oRQtdy8N6NUoZwDVuzg+5e2bKHhJRTA1/bK+mviRuDDSolRrFXMydDWYowU6zZdpMC7r7/aKKj/mnpAR/X72zsI0skdg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=d9aSv+c4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=obbB9zjw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45B7fNxC028034;
	Tue, 11 Jun 2024 08:22:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=NEJ6xwoNM+7edVFYCzO6jGM6fhEGR8PwtNKnvbmqFBs=; b=
	d9aSv+c45jcSIVM/q/48l6ScEFCM0a6nFkvqKV6J4FuhrRbkkMqFBa5/PNLqjz6X
	xSsyfoDpmPuNJhhaEBPsRyhs5FboaP/mf1KDscEU3Q417mtogeqruo6whxbAi4YK
	3BTQgFFIsFbjhmcTrKfv7YcOeQt2PnHLubPtKiKqmL84i4Dv4XNtBT6zvwz9MvyG
	NREuhFYZAafipqkBjHkZMbZPVmgSkUiF87Or5x9N5LGFBfm0YE3lNjyT/3rcGAKw
	tXT9MhS3FqIqcl526BEaSP3J8Y26ldxLMCcMZnu2CiRWRGYAmxOydpkjs5nFx+su
	V2NmGnKqK8KObCO3M9sEvw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh1mcaqf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 08:22:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45B7t4P9027048;
	Tue, 11 Jun 2024 08:22:05 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncdswff5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 08:22:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D2u6VR8gxxPEa+tWsagDX51uwSauTRTFwSnzb7J976Pp8X98jg2NnYAv6/QLnWlUN/4UWqzSXhx3yLkjzIfq3T5Qtxr/hUnudktCwcYCHmHjY56PU3pojwFiz1clOyvsFtJ8WTbLvgA4MwvXvHpWdMDeFX3nzO3oWwpubQ781UNqFfoPZiyb3q1xH2s4c44JHmqrZFKYJvbUy3S1N2sM7Yb+rL0Pr3y2+39oaV1kRDVzKSC6mLjPuzIblzppvWVeS0dkU0eOXCCLHAgo+92TOm44ucE0/Fj+ctndDSS2GOjHOqRF4uPn3hqylipXyrHH+z8oXQg/7tTJm3PPJ5VbKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NEJ6xwoNM+7edVFYCzO6jGM6fhEGR8PwtNKnvbmqFBs=;
 b=FqQvlLsAtpUp5h64KYPp91QlwrlygSrXO3Ez7TpsLwXq0y0l0+kLl0CYRMXHDsOxEQFofLYmXQN89Ymx6wegoQPtYGZ+barP6h2lp0o16rC6K+76U+0M04dKtvyzzXsKoLW4/JZ7QxiZGC46y7ueOfGN3/JFa2y1lG/3LX8u+FkoZzeBElEwkTVlz7p222RAokMR3mlX/HfvzFXqbnKeNS+HkcN5Pdxvlp4fJzwnDutQuQqV8Jt+If7/hdw+inHBrVf8xkmJ6gXR5kFFIJgZP5wjwjM633Hbu5ORHo/sGdsKt8amRf+nxiY9Vmtg/k5fLvftpmrvgBM1kbo9MECp8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NEJ6xwoNM+7edVFYCzO6jGM6fhEGR8PwtNKnvbmqFBs=;
 b=obbB9zjwYsJOYT+YYdsniRW0htT1uoQ5rKZzdnTNr/quGE4TPI7nY9eoROq/ZKjKw/LsynbAEsPlhJgpQvGYrhwAX/vZiWU9LESKm7IAA65Zxdaol0+jLR5c34jtVM2mcgMo2QetVGaO2krqh9RJI/DaRKsSAmUp/Ykk++aVsG8=
Received: from PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
 by CH4PR10MB8025.namprd10.prod.outlook.com (2603:10b6:610:247::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 08:22:02 +0000
Received: from PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80]) by PH0PR10MB5433.namprd10.prod.outlook.com
 ([fe80::47be:ad6e:e3be:ba80%4]) with mapi id 15.20.7633.037; Tue, 11 Jun 2024
 08:22:02 +0000
Message-ID: <97629d4e-1f3d-441c-b92a-2e8b74b9846a@oracle.com>
Date: Tue, 11 Jun 2024 10:21:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: CVE-2024-26831: net/handshake: Fix handshake_req_destroy_test1
To: cve@kernel.org, linux-kernel@vger.kernel.org,
        linux-cve-announce@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Chuck Lever <chuck.lever@oracle.com>, Hannes Reinecke <hare@suse.de>,
        Jakub Kicinski <kuba@kernel.org>,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
References: <2024041704-CVE-2024-26831-2e6e@gregkh>
Content-Language: en-US
From: Vegard Nossum <vegard.nossum@oracle.com>
Autocrypt: addr=vegard.nossum@oracle.com; keydata=
 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 8A==
In-Reply-To: <2024041704-CVE-2024-26831-2e6e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PR2P264CA0019.FRAP264.PROD.OUTLOOK.COM (2603:10a6:101::31)
 To PH0PR10MB5433.namprd10.prod.outlook.com (2603:10b6:510:e0::9)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5433:EE_|CH4PR10MB8025:EE_
X-MS-Office365-Filtering-Correlation-Id: d9327999-83c6-4b8e-a5ec-08dc89ef9250
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?c3RQMndmOWZKRmNna0dJMERpNjVyYXlNbWdoRXhmM3E2eUZ0UHJ5SFRXRnM1?=
 =?utf-8?B?OVFmWnpXZENTWlNNSFNrWXkyZGNCNzZDNy9DQUs4a0lMVlYva2ZVUmZZemdo?=
 =?utf-8?B?MXVkUUFQT0p0Z0xidkF1M003ZEZRQ00yRkNDWmdGNlZPS1ZiTlVueTc3MjBO?=
 =?utf-8?B?a1lnRUZZS2p4YzRXb1FibnJoSGtDTmQrM1NqMlpGdWlnazBaMkQwNi81QlVp?=
 =?utf-8?B?U2FJeldnanpKOUVhUnNBaEMzblV3QkIxR3BzKzUyalJPL0lqSGpqT24rRXM0?=
 =?utf-8?B?dTgvSmJMT0lUQ1RJZWNVNjJEZk1QSDRhRUw2T2ZVMTVGVVZRSEQySGxMRGsw?=
 =?utf-8?B?a0JxK0xsbDIwazMzMDBqQnY2b0MyRmZKOTFMTEp5UGludUZPRkxTaHpaZHhi?=
 =?utf-8?B?UW1UblVyRVNNWEN5VzhNSXBDdlBncS9OUGNaalE4K01HVXZkd1dJakNKUWxG?=
 =?utf-8?B?aHdKNStsQnlDT3FGaXV6c1N6VGZIY05BQU01SnFWbjhXSlN6VWtOVy9wRDVh?=
 =?utf-8?B?SVpjc1l0QS9qU2k5RWxyNGNZSjZ5akZRaHRHNlBBY1lTTFBLVDVFd3FSUWhQ?=
 =?utf-8?B?YnBGQ2VxN0RQR3FuYTRSU3d5eldvMzAyNkUzVzZPVW1yOU5seVo1ck83UWRW?=
 =?utf-8?B?ZGltSmtTNTh0SFVmVVFFS0Z0dWVyOS8xbFhNSEY5VEdTM0ROQ2lOQTFpNjF2?=
 =?utf-8?B?b1VnUmxQdjVRZ0hndjZRQXRLc0JrdHI5eW83ZGlVTmFTVklCdm5udWJ2ZTMv?=
 =?utf-8?B?anpkbzU0Y0VqT0x5Y1luSjFJTGJYR2libVN1ZkIzMEV6SkI0NG9JeW04bXBp?=
 =?utf-8?B?UTF1SU1LMUNDSnB5YjV1MXhWMzBwK1JtZmZQeiswV2VmQ0svU1RmQmFOMlJT?=
 =?utf-8?B?TVdza0hEY3RIQzB2Z203eDMrYTRPenFGSGVOeGxRUUV6TkZQdVI0NWIyRXVG?=
 =?utf-8?B?dXJIVmM4aU9vbjJVU3FsRFZJbFMveU1EWHA5V09wQmtEaFM5WEd4MUVEMDdO?=
 =?utf-8?B?d21nWExla1dnRlk0NldRNCtrdFJEaTJSbW5BYWlSZVF3QTcxa1pEb09kNUsr?=
 =?utf-8?B?UWdSVm45OXliNk41MFkvWXE5cmVXN1NjYWk2bkw5QzRuNEpPeHdtdm1KSmFL?=
 =?utf-8?B?QktRZ2NPalllVHJoQ25jWUlOaGVTaThZbE9sTzlZbXFOWlh5SGdKY2tlVytn?=
 =?utf-8?B?WDFjdUd2NjRWQmJSVjhrTkJUSFR2V3Q0OUN6M2plRVBNcXB0YXpPRmRrM0pI?=
 =?utf-8?B?ZlBTS3dMb1JEWUpyZ0llOWh5aFY2TUt2QzkwMlpsdm9FWDloQ01sWUxJMDRM?=
 =?utf-8?B?SkdCaThVb3BUa0sydXh2OStFUVI3dVMvM0xxSnZ0V05OS0hadHFnM3RCN2NS?=
 =?utf-8?B?bmZTdllpYU0va083WGtkV1pTN0x1aW9XeWJiTHVLQmdsMmljOThON3hoNUFJ?=
 =?utf-8?B?TDVhMFk0aXBNdnk1RDUwZzNEeTJNWkZUenpzVGJ6YU5FdVB0M3J1aXRHcVpV?=
 =?utf-8?B?SXA0TkQ2UllXOUNSUUprZk5CZTF1N0g2cEsxZ1RST0xiL3hWUktnQkdmV1dh?=
 =?utf-8?B?ZW1INWxiS0VlMVRpZGx4eW5RWHYxbUo4RERJcGNLY0JiZ0xZelNGNW1kdzBR?=
 =?utf-8?B?OVgybCtKYnNhRnEwMkE4SjRaaFJuUytHalM0d1dyNm9wQVNXa1VDU3N3eEdC?=
 =?utf-8?B?RjhRR2o5RkRZMW5BNDBCeGZjN3F0M200T2V0bEtldFVPTUJNeGtUM3AyeXRP?=
 =?utf-8?Q?ziC+HTpWTrTCh56ML4W37S8TIgU94twRWQBrsvj?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5433.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TjJhUkUwQUJXeVJkbWJYQjRjSDdWWVZxUy82VVYvNDhwbFFuU3p2b0lCMUUv?=
 =?utf-8?B?OERFT2I5N0dsYXlUTyt3SHdIUVVxc3pIOVR0eURyMkhGM0lKZzVJaitnRVlh?=
 =?utf-8?B?TG9udTlEOUVBRmUzemU2WVZyckI5bWhEWlVrekJkc2hVVXRqREdkQmc2QWgr?=
 =?utf-8?B?QXpNV3EwVzA5Q3J2bFVpNHFRZ09UZ1FTN09PNVllS0RpdGZRc2lLTmlOUVdx?=
 =?utf-8?B?RWtCejhvRWFaNmk1YXRHd1lITG94cUlxdi9VTHgzd3RKZFBqVzIvalhpS3cz?=
 =?utf-8?B?VUNvU1hhMTEybXc3WnFXc2Rhc0VTemNGT2l1MUtWQjhyOWF3YkVsemVoNHNz?=
 =?utf-8?B?RkFRUXp3QzliMzJIMCtnd3IvamZHM09EVHR3Ymd3Vkg4UXJ5cmM1aEJZNXJE?=
 =?utf-8?B?eml5MWxsZXRFRFRSLzhwYzRzQmVON3BJWVErVzBUV0lyRUU0QzNiSHVIaUpy?=
 =?utf-8?B?Mm0zR0MzSmNIdmlaUzhoVHEzNFE3UEFNcG5VcFAxcXZQSGpYRUtqMUVzQytL?=
 =?utf-8?B?S3hxeW9TdG1MOWZjRDJta2R5SnVrdytQZnJJTkZSeXhrKzRLR1U5L1hBZlY0?=
 =?utf-8?B?ZnljVGZIU29FamdrWk5iWEpHZ2VUN0Z3TmJSK0xxYldNYjNTN0VKQVRYWm5y?=
 =?utf-8?B?YjkyL2VrNU5rampsWFFLYlF3b0lkODV4WHliS2RGN1YwMlgvUWtXcEdMditG?=
 =?utf-8?B?eWNqWHpDUTdLUm5wdFd3TnZKT0xORm93WllMcm13citGUm8wL3N2b3Rtaktv?=
 =?utf-8?B?R3lUV0Vua084Y2tXcDROL1pUZktKeTNsS1RlR1ZFWm4rU1lXajB6enhkdkhr?=
 =?utf-8?B?dmR0U1loa1BHcVdRZCtUbEtKZzJhb1pueUd2ZVgycm9PUG5EWFVTZkV5aDRG?=
 =?utf-8?B?WjEyOG9uTklXdjBNcmxaempuRHNwbTlBb2QwdGhhOWtsdnN5SmtkZE0raXV2?=
 =?utf-8?B?aEF1dTVGY01VajM5ZlVubUMxUFpjcFFGVGZ5dUgyVTlCdktFYnVXNDM0T3Z5?=
 =?utf-8?B?QzlCOC8zYTNFMWtvZ0NGNW54YkxwMW13Rm1HaW5EZ09IZjJNelZWai9hSkh1?=
 =?utf-8?B?RFExUmluSVJwSDNqYk9UQWNtcUs1d1BjVHhMcUcvV0ppRFdGTjgrQUNTcW40?=
 =?utf-8?B?Ty96dVJEUWk0bUNzdnFKU1RsR1Q1akFLNFpOZVFvUlVZZjBKN0tuY1lydG5x?=
 =?utf-8?B?blRZaHc4b3JuamFkTjVhaitkbjYxZDNYWlNtY01VSTNiMVVFVEhGL1Bzemgw?=
 =?utf-8?B?aEE5VTUvQ0hxZ1RYeEJwM01GdjBGd0hldzBCSTZXUVh2MUJUOS8xVytiR3hr?=
 =?utf-8?B?VWFuV29rRnU1bi9RNFZPOUw4a0FBY1VrUkxvZS80U28ydGt3ODBiazBoNy81?=
 =?utf-8?B?cXltMWp6SERnMEllYW9BNHNSODhkSXRNN3lnN2ppRHdrSU1GWURDcERONy9I?=
 =?utf-8?B?L25XVXRTYWcyeGJmempuM2lMR25sN21BV1NrS3VwYk15ZFVsZGp2Y2NuSnJV?=
 =?utf-8?B?RlgzSzdQcmhnYmR2S1Y5RGxSa3ljS25Yck1IK0NnU0ZCbHYwdmJRYTZodWZM?=
 =?utf-8?B?eUZyc0Rnc2xHR2FUSDlqUTFwWUpvZE9rTHlvM1NicCtVSEloT3pMTlVuYitx?=
 =?utf-8?B?M1NiS3pRQTFGaks2N3hZSEVLNjhDU3FFck1oL2Q4T1U4eEpxbXZRb0xQcTdq?=
 =?utf-8?B?TDY0MExwdzNCS2ZqU015bHUvYVJVWjJNVEV1NXJIeEt4bFkwVkU4OWVEZE4w?=
 =?utf-8?B?UEhwcE1Sc0xOeVhHTVdMc2ljUE9VYnE5RnBkejh6UjZMd2hZdXRWVm5MSlN3?=
 =?utf-8?B?eTV0TkxoM2tZNnJDUjRjZTJyTUdjMm9iQXJtZVdjbkRNRDdjZmdNUjZkYnFD?=
 =?utf-8?B?RDQrcVNSMjE1d283RWQ3T1pWSGkzK2RjaVVsdGQ0Y0xyejJTaC9nSFBzYURr?=
 =?utf-8?B?YlNYa0J3bVg1YjFJZDlNTVB5NDdzWWJ2K0toUUFJOXhCUXR6TWZGbXJBbGRN?=
 =?utf-8?B?TER5ZFpyd08vTlZTVDZkZDVIUyt4bXdQVk5uUWY1K2M5OEdoTCt5M3Ayc21a?=
 =?utf-8?B?N3dDdGhtOWh3cEJKbzRadDhxL0kxNGFwSlcvOTcyMlUzVjJpakVaUC9XNko3?=
 =?utf-8?B?YTR4enorb2YvR1B2SlQ1VUZKQ0UveFZ1YkFjTWl0amlqOGIvdldhVmFWaTZs?=
 =?utf-8?B?WVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ooMUiASZW1vARLlA+SsCUpN9bZMyCGclksDKZFO2w/W1RZx9hg1QUn00pz6p3nRuhlwV996VQPMAJuQlYg6YOGoI1VvucjcZLp5XXaglxhGwOfix6mNCuowGu27oDifUjMt80zyp4pKQSL61Z0qonUzrhwhvrqD6BJTcayqAWJNAijkDweZxGugSWAtf2RRBNdVPLZAbDqdbh5V6ZsXrXVoGzOLIR7LAI8Qa6U4uQt2yk00WnkHXIeehc9HHFcx33dDlTltVVPDHTQrc3IV+fJfGyZc8Hq0av++Zv4fJB/o9WkgD75T38k9LmHXyKVS6IBc/iwFkL8V4a4Nq+nUsq3QxnFdPqfuN9Z4gEC7q9cud6ale0bOGovBKN7Ieb3MZnTXQsQW3nyJZkIcrrttbUiddwjmiOuPYNDA/S97R9TmLzgZTcyKfVm1P2mto54hyPOTugtQYOewttYp13nivA+NvAjUG+0YUp4nBiWMYhDj175evqgsb6f1rioLQM2fp+MZb2yaKIDGdKEPtGJIWzjnQJ1dvb7VvMx9pAtn9OanuZPbi3hV0Wv/c8Twqm+WVAsUPQXl6SLK5pJIvzl4VFfwIzN85hO1wa09Terc9OfE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d9327999-83c6-4b8e-a5ec-08dc89ef9250
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5433.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 08:22:02.7175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Ck/ptcn6k/ns+/C6EsXUMOHc28BnUn0sHPwnqRqCAR0Z7D2fSypAqqwUnrLZ6GZ8x5Sbs1qkmbxYNLab6vch7cyhFmbJyhuDzhDAxTO4KE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8025
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_04,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=914 bulkscore=0 suspectscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406110062
X-Proofpoint-ORIG-GUID: j01CHfC18EwxYPPtkjWm038tzjMRrrEY
X-Proofpoint-GUID: j01CHfC18EwxYPPtkjWm038tzjMRrrEY


On 17/04/2024 11:44, Greg Kroah-Hartman wrote:
> Description
> ===========
> 
> In the Linux kernel, the following vulnerability has been resolved:
> 
> net/handshake: Fix handshake_req_destroy_test1
> 
> Recently, handshake_req_destroy_test1 started failing:

[...]

> Affected files
> ==============
> 
> The file(s) affected by this issue are:
> 	net/handshake/handshake-test.c

Hi,

This patch 
(https://git.kernel.org/torvalds/c/4e1d71cabb19ec2586827adfc60d68689c68c194) 
fixes a kunit test; we therefore believe this is not a vulnerability.

Thanks,


Vegard

