Return-Path: <linux-kernel+bounces-171012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F8C18BDEC5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 11:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 537DC1C21822
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 09:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9FD4152E0A;
	Tue,  7 May 2024 09:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="US+ui/hp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rlv0RbfG"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D48F15253E
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 09:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074822; cv=fail; b=iZGzCdo4dCHwrHm98aRLJ+4t+5Zd/VlcQctH72A8Ya+PM8D8+awugiOt0cQy6607JC092NyqEAVj6nfqAy5rM7slfZeVC2/yoODk30TlvwwnOcp2wn+r62BjEgpgsGRyUSu59ZzJyaNBulx6KNqXITrPrpp7bJLWY/NIg6UHO40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074822; c=relaxed/simple;
	bh=HcbhM5xYmZw7w+jPRb7dXIjVe9noI0M6ndGALqIcty0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cw7wj82mNd8Z9SvKOJfESTRaDGY4JX5z771ukULRzaOOdpMhmZMfSb+5wCF6LtSm5IYepwkys52Q8lxAb2o4TUjfmR8FwgJTPouPe6L6QTkx1h2vkW6DfmRDSkO1fXOGjvH/puSu6jah/W7Z58ORQRGccXFwf3LJRo33Nv01C68=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=US+ui/hp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rlv0RbfG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44793vW3020797;
	Tue, 7 May 2024 09:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Ixm5i+kgq/tc9tKZRLOENMzbsCkyctw432QrgDDHpGU=;
 b=US+ui/hpzYe1Q6KpJwkHAuC+F2EMK5eCqnwjNJchMYqG4wOd5HyGRphbKBQKiFHWyLQC
 +FX0fKBgpt8wyB9Vvb05rFvJtd6ryVkp1Ggk+AVm+f9A6Htj66RR60JUH3GMOwYPWG3f
 khuqSm1DWr/dTXWknbFY09svCuvhxc2h66kYsksp9+vMfefN5jaDfZ8WClxrsWG3YaeO
 6aIkbNfchbuiop1nMZ1EAQvxbcji+pne4MGHgFFZbtvULkja0AwAadMruONpD5GfFDXQ
 EDWJzUUx0mBe1YYY5Zn8KwUpuKJH2yyV9P/slX49O9i2PK8fo9uwWe9VoO14I9Y1tGZZ qQ== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwcmvcj1r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 09:40:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4478aVBp039539;
	Tue, 7 May 2024 09:40:13 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf6rsyh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 07 May 2024 09:40:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=It4Mx/4CIW9Z2W68d1pyUbLypoerQ6n7b6Ti4rkxreABJSSCJ3w37vQ3FmPPaB1lKKfSu+bO6G7lDYl1nFIVPnHe/KvmFHwOHaTv/iwYUCoA7gR43Rz25+NuwU3+XnpqQXonKAeLA/QsncRHxz51XNvBMm8GtCLXNl/7jOY0cSCovb3IRtCqBPLvIc0U0zHmPRrt5+N99wiNE3qfcMQC9ztgtJlxeh0x5rWF3VT6I0ywubm59PbYmB8F/ZzV/kFp6B/ZanAWqUDxLs8GTyjuzsDhQv/g2IVw5g0aZWBT02Xg6RIHbfToo8NqE52wp5/hS8f0Q24q8O/qT1j5jeH2aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ixm5i+kgq/tc9tKZRLOENMzbsCkyctw432QrgDDHpGU=;
 b=D+I28cF0/0V51+G6zTtZjo3MC1JQROGEUqusDE9lGm8vTR42OkAR0QsjhawqoW6nuhcU6F9f46SV04V6t9Lym2IsBU2bzKS+p+P8q+c8XqmEaGcNF4Rrn4gsM8GlBMuPg2P6OmDVXLadWtcLC+kEebxf2QS+oqcbSyoB7viamZNRz5aci1BpFK+2I1LOP2mQoQGTy/fE1A5/pCPpJdiY6mhOshV7I/Sfnu87lX3a01s+QapJovmJHllwhcKoGzrvi5Ey1HH5nZBWbSTBcLpa0xZuZc1U6ZVgIOxQJOgozmge6YmOeE7RO57t5dmZ4Wr3wEZcuVyDF4SJY6clqraASw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ixm5i+kgq/tc9tKZRLOENMzbsCkyctw432QrgDDHpGU=;
 b=rlv0RbfGBv0E431luXOw5RnZOf+mlHZBvyjUC7klDNGwFd8YjTjV4a943gCg2qQ/XI2JXYfhSbL2TILZwfZyR4Ezlk2AQLXaa6wcPaGgA7egciL8daU+tApWIIxjo0Mif7KL0rtrziGElP7l5GiBKC7ilaUAR9kum5mVUhXQDlE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB4638.namprd10.prod.outlook.com (2603:10b6:a03:2d8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Tue, 7 May
 2024 09:40:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 09:40:11 +0000
Message-ID: <17aad327-ffdc-4cee-8b7d-174409327a7f@oracle.com>
Date: Tue, 7 May 2024 10:40:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] firmware_loader: Use init_utsname()->release
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mcgrof@kernel.org, russ.weight@linux.dev, rafael@kernel.org,
        linux-kernel@vger.kernel.org, masahiroy@kernel.org
References: <20240223153121.440763-1-john.g.garry@oracle.com>
 <2024030757-trickily-tuesday-bfcc@gregkh>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <2024030757-trickily-tuesday-bfcc@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P123CA0013.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::25) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB4638:EE_
X-MS-Office365-Filtering-Correlation-Id: add788e7-a7d0-4b86-ab91-08dc6e79b0ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|366007|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?R0Jza0ZpY0JocUUrcitlVGorcGw0Y2tOR0YxR1NETzc5NnkxSVBQeUJ1OVQy?=
 =?utf-8?B?ZnV5U1BXRWpmaVFZY2xORHhBU0hmbkVZK1hqanVpMkRKYTNJQ1Q2WDlKZFZy?=
 =?utf-8?B?R0hhT0NHNllPZW5nNCt4Q2FEN1Y3Z0RwbHk5b0U5RUtZWW45bzR2aExkSXEy?=
 =?utf-8?B?dlA1ZFpuL2s0dDY1RlNNUVdrZTVTWHZleHRHNFYrYzFzMTF6SHNoN1hLY0ph?=
 =?utf-8?B?RmpMUzBBU0I1cmcyejhJNWhsS2ZZR0NPT1B5TVJNcGVtQlllTkNSaytZQ2RW?=
 =?utf-8?B?WUdib0I3UkFrZXBWcVFGZ2tHWHVwKzRHYXB2a2krM1dUYUdacnFVOVhzQUw2?=
 =?utf-8?B?MWNVQmQ3NWFSMmxaVThUZHpKa04zUE5JaDZTcEdLMTdoTk5UYzlEV04zdXp2?=
 =?utf-8?B?eit3SmYvNXExaldyam03TEJld1p0SzVidEdObjRIWlRYM0JobVNhWnpJclBG?=
 =?utf-8?B?WGorZTBiOFBxZXI1MlRuallTOHNQK2JVMzdBYmIyRkw2QitMS00xRGVobUFO?=
 =?utf-8?B?cjlQbW5tamIxbDRETFNjdDdyZ20xU3cxV3RmamZVYVJxM2h4aEYza25ydGhw?=
 =?utf-8?B?eGo1MHFZeTR6Z0tJYXY0b0JWT0RwK1d5dTRrWWJhT0trVGdHU2pQMllmMVlL?=
 =?utf-8?B?SHRLLzNCTzB2ZmF5dE40ZnlSVzN3djFyaEk3dHMwdGJaVUVDUUFkRFhaU0hO?=
 =?utf-8?B?dFRnMm9Jc3NWSlB5ZnRHSDllWkRNdllxdXpiOTlvNlRFNDJCTCsydkN6azgw?=
 =?utf-8?B?TkJGR21kblhjMUNyalpBcnR0a3NWRG9iZmYzODNWS2l3Y28zREdhT3F0VS9T?=
 =?utf-8?B?Unhna1Z5NVIvTmcrNDExaThDV0kvZCtvMTBjcWFvVG8wTm9vb0RiMlVGMlF0?=
 =?utf-8?B?Z1l1K1RYMFJUNW5abSs4eGl3bHNTdUlwd0l6V2wwK0RLOWNYRFFsMEtBY24w?=
 =?utf-8?B?bktTRXFwNEdxWkNoOHVodVBDbmtpNmNabnBFd0s4K2xMaU42NTNHZnZ0ckdH?=
 =?utf-8?B?ZzFkTTBxOUJsTnAyVmJZK1lJL0RHdTIyZWJyYlJ0TElUTjBsejg1U0UvRXhw?=
 =?utf-8?B?ZjZGVjFJYmZNM25uejdyUlFsMjJYVmJXQjlkaytlaE9EU213ZU5rVTZ3S1dC?=
 =?utf-8?B?bTNSSzEwRmYrUzdzR2wzc3FNR2FmcytzVXNIRkczZFZDS3pKbTZWa3Z3ZnZY?=
 =?utf-8?B?M25sbjFmcVpiemFVZ1ZiSVp2dTI1Y0k1Q0hTSHR4QjloRE1vVkovdFFvbUFs?=
 =?utf-8?B?NVFxNzg5aXpYZHVMOHhUSmZNc0RxVjlibHV1ZVNWeVFCL2R3cjlQOEZxRDdu?=
 =?utf-8?B?Z2hEN0JtUGtEK0JFNWNiYWZSNWZpbHVUdTdWMWRla3MwYk9ObFZNKzBrRnhq?=
 =?utf-8?B?d3hvdDFZc002Vys2WlVSZWVzMGRMTEQ2MlZ1eWZZdkZVWVZKcDErT1J6RWxI?=
 =?utf-8?B?b2RwcStvOHRQcnVVNGhMUzErMENReTlSaENOUTVKRlFua2Q2S1Myd3hRU2E1?=
 =?utf-8?B?dGxoRVVpMmU2ZU9TL3JnSmJ2OXA5c1REd09oZllpV3NiTGF4S2prWGZ4V0FU?=
 =?utf-8?B?dloyUmtqbFlOT1gza2VpL1AxWTJHOXlUbGt5MWtwZ2pXSHpKNHovSDRnbHJF?=
 =?utf-8?B?U3NHUDhkdGY3MWRTY21WeGpWZUVwSUE9PQ==?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L1RqTDRaZjNEUzRObXBvK0tCak9qWWllbFdoY29YblJFTzRSWHpFUW9XS0tR?=
 =?utf-8?B?QXdEVnpBSDlzVmllSXREekhjWDZFbThIdjMvZUl5YUZyNFVZMWN6WU9kZjc0?=
 =?utf-8?B?NGFZOFFtZS8yNWU5cWcwd2VTZ0twb1UvVnR1a09sSnFNWi96d0lFWkhCajVO?=
 =?utf-8?B?c2hPOG0wV0Q5M1RaRHN5M2RGZ1Q3dlVaYXc1TmloN2VLRUppcnl2VmJEakJs?=
 =?utf-8?B?cU53UVNEUDM1OHhYaFZ4MlRLYzBzbGVJdU5aTlEyRm1LQlhXTWlPQlVPOW4w?=
 =?utf-8?B?WVozWWt6dDV1Qy9scndHRGFJdkFsb1BDYmN2TDd1bFVKL0dNaG52ejFnY1Fs?=
 =?utf-8?B?RE1lcVM4NzFDQnNkUU9TNTUwRzdDWnpFVy9SUDhZRE1uZUdBektnVVc2WXln?=
 =?utf-8?B?b0U1bE9ORElnL05vRHZFMjB0bE1GOXhVTU5GaE1ndEoyMU15ZysveHFlYXEw?=
 =?utf-8?B?MFBtcmlOREgzVk16RGtwT3BLcTZmbUJFd0tmVHpkekNveExwODlnQllxQjlj?=
 =?utf-8?B?d3hhczRSRmg2UVZ5K0wwZisyWm41VUJhbUtVS1lmandocUVqTzdYOFViS3ZO?=
 =?utf-8?B?YlpoZEhPTEIyN2NCRDFrTjBndERSQlpJZWRtQW1xcmZueXh4elFrbkxqYll1?=
 =?utf-8?B?OE9PbFVxK3phNmtlZ2c2STRUbDlzQ1FOU0IvZ2plTWM1MGxuOUtQSUVnbStx?=
 =?utf-8?B?MWxMVDZKemNueG1rQjVaMUF2alBVakY0cXpTSytHLzJtcU14bXhsc3hOTUNq?=
 =?utf-8?B?VTBYbXVFNUJ5NU5DRmhjd2YyZzVSNFZITWYra1RlMUk0VnFibHh4ak1EVzNj?=
 =?utf-8?B?azNncjR6b3JEQmhXVmRrUWo2UDNYbkhMNmpNdjZCM2MzT0Ywci8yYWVSaVd2?=
 =?utf-8?B?TC9ud0ZQZllBOFVxK2MvRkQ0WnYrbGxoVnhVT3VVQUhaL3I4ZG1sVkdrVGxq?=
 =?utf-8?B?Ny96OENZQ2ZyLzNVRG9aMFFmWjJYZ05sV09OckJMZE9teUFJS1dwbFg4K1M4?=
 =?utf-8?B?R1ErS2FjNm1mQ2FhWkUyNXU5b3ZWeFJyc1FsVVI5UitJMXFjcHJ0di9nZUF2?=
 =?utf-8?B?L3RJVDEyNFdjeHlyVGs1U3gvWFp3azZMbDhNaEREYnZKeDFzOWlRSnFtaXFF?=
 =?utf-8?B?RE42UkxvcWdpNE5MSDRXSWlNa2RkV1BRN1ZmWkdSWGh6dGFTSzlua1hFaUlM?=
 =?utf-8?B?MEhPandDT0w4cWd3NHB3Q3BYa1pJdUFMbkZhOE1CalhqS0REYWwxTFpsUGhp?=
 =?utf-8?B?K1o3TkE1YlZYSzVHMDF2V1JqVnJ1K3UrbWd3ZTh4elc1VDN4RHN0Y2F0UXJh?=
 =?utf-8?B?MkpGb3U4U3hJUTJXeHVXVFFiTEZIWnF2K25UcnhiL0RUbTNpN3ZpMy90L1F1?=
 =?utf-8?B?VWZBUXJaaFlJMlYxb2REWEhFaEMvdlhOQWtWWVd2a3NYQUxRR3lPOWpQMlZK?=
 =?utf-8?B?S0dyR1h4QkVVd2xmbWl3N3JzL2NPL293L0dPaFNKUlIycWxLdm45aHRJWnhT?=
 =?utf-8?B?TGo2M0xlTnZJVWx4QUdUd3JmdDFXcktOK2UwRTJWdzRHNlowaU5aNlJsUzdB?=
 =?utf-8?B?YTNOeEJoTGlXVVUva3VlclRUdDVwOWwwNFAwZy9WSVZiWGpvczBmRWJCSXla?=
 =?utf-8?B?UStuMUVRcUlwd2dxbW5kT2t3enZMOUFBY2xneFg0cm9wR3ZZT2QxeDkxU1pz?=
 =?utf-8?B?eWlqY3FJTmJIdEc5MFhqWXFvSThpelJHbnZ3SEZhU1hjeHdGWXk1YzcyYnI5?=
 =?utf-8?B?WGxoTXhkaTIwelk3UEg3aWl4VGJrcTlMQVovZHl6b3NrOWRySGl5dGt0RDd5?=
 =?utf-8?B?R2FWYXl2Tll1WXlGczUvaGs2T01ac092RzNZTDhwRDVvT2FYcStOckFKOHdh?=
 =?utf-8?B?RUN5WWY0S0RISXNWQmR4ZzY4djUxS1ZuNUNtdy9sNU5YSU9vVUNCb2Zacm5r?=
 =?utf-8?B?VkNQRzdwOGFVRTk5clFwRDVvREtNZEpBWE4wWWJ5UEJoN3JCb0E0MnJ4eFk3?=
 =?utf-8?B?QXBTTENqalRrZUdTTll6d2l5UHFLMnliOEUxT2c2NGkvZDZnUEllNXFFSVEy?=
 =?utf-8?B?d0M5U0RNYm1TclBhSUxqV3Y4RVBySUhWRWVyREhsUXljY3l6ekZIelFVVjNw?=
 =?utf-8?B?V1g4ZmVGVTY3TjVwS2hrazh1SklHRFFRT3RDcFRaTzNIQUdGazZaUDRNeFhR?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	BxQg42IYJ6E1h+l0J1wMLjwRf35lRASC6CuvJBt9vZXCyui953DGxXRmM08deiVE4N7Qc0mdzGa35cWqqHkOhQ6duCIqUqEu7Pq4CMBHQ1hDUecCXDimY7NOMn6Quo59XXtgrN9LQsK0kxthIWwDMeyfwCbsoLEKAiNRv0IDyzwU4EAW3ml/AOTZSohlECxBqfNQx1LDZljxNtVLk6WqU5eQOOcaDVlDKFh2YWRQDZ6uzlm3HdQM+/d9FpQwmxdjP3NTh8oSHCRX4+diLLOAfQKo397++EBcNv0odFJf0q+ZyVX1oaU6DFQzkkH5yPdoZJ4CcoH3xqgDhE+ipNUavCSZVnVLnnMQnaxuI0o+vWOXzB57E8WEjoZsWGf+P9DcguPQyDc9tpSGqmDM4Wr8FAKcQ1bm751AgUeoytLcNjk0+1vzjndmUKDpeTql7jOPESaKzWnEQUbPzAk/F/nhiXQhumm2AKRR8ARJTimtTXL7i1+klpc5cgLpgm6hCIa4F5RC73cjwHxdkexsqBvet6C90I+CaekZYeP2wzxi5q27C24LIeiHxsflefMuufnbmc3dwwSBDkyAXJRgWtiY7qdI90N6+w6nmaHTgrrnRwU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: add788e7-a7d0-4b86-ab91-08dc6e79b0ca
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 09:40:11.7822
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kcp8VSu2IAleluChFThPPwHc6zYXLVsk71d1UWPXnR/3vZzKNK4eb0EDm9LAbyOcJB7B3ux1+jQGSbzvrOeX1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4638
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-07_04,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405070065
X-Proofpoint-GUID: Ns4Imhk8ZrMmntR9IEIn9TpdCNeDbKWU
X-Proofpoint-ORIG-GUID: Ns4Imhk8ZrMmntR9IEIn9TpdCNeDbKWU

On 07/03/2024 22:01, Greg KH wrote:
> On Fri, Feb 23, 2024 at 03:31:21PM +0000, John Garry wrote:
>> Instead of using UTS_RELEASE, use init_utsname()->release, which means
>> that we don't need to rebuild the code just for the git head commit
>> changing.
> 
> But you are now exchanging build "convience" with code complexity and
> runtime checking.  Which is better, and which is "provable"?
> 

Hi Greg,

Do you think that the change below is more acceptable?

Now firmware_loader is the only module in drivers/ which needs to be 
rebuilt for git head commit changing under a x86_64 or arm64 defconfig - 
I didn't test other architectures. It would be nice to improve that 
situation.

Thanks,
John

---- 8< -----


diff --git a/drivers/base/firmware_loader/main.c 
b/drivers/base/firmware_loader/main.c
index da8ca01d011c..162fe0c4fd51 100644
--- a/drivers/base/firmware_loader/main.c
+++ b/drivers/base/firmware_loader/main.c
@@ -38,7 +38,7 @@
  #include <linux/zstd.h>
  #include <linux/xz.h>

-#include <generated/utsrelease.h>
+#include <linux/utsname.h>

  #include "../base.h"
  #include "firmware.h"
@@ -469,12 +469,16 @@ static int fw_decompress_xz(struct device *dev, 
struct fw_priv *fw_priv,

  /* direct firmware loading support */
  static char fw_path_para[256];
-static const char * const fw_path[] = {
-	fw_path_para,
-	"/lib/firmware/updates/" UTS_RELEASE,
-	"/lib/firmware/updates",
-	"/lib/firmware/" UTS_RELEASE,
-	"/lib/firmware"
+
+static const struct fw_path_s {
+	const char *path;
+	bool append; /* Append UTS_RELEASE, path must end in '/' */
+} fw_paths[] = {
+	{ fw_path_para, false},
+	{ "/lib/firmware/updates/", true},
+	{ "/lib/firmware/updates", false},
+	{ "/lib/firmware/", true},
+	{ "/lib/firmware", false},
  };

  /*
@@ -496,7 +500,7 @@ fw_get_filesystem_firmware(struct device *device, 
struct fw_priv *fw_priv,
  	size_t size;
  	int i, len, maxlen = 0;
  	int rc = -ENOENT;
-	char *path, *nt = NULL;
+	char *path, *fw_path_string, *nt = NULL;
  	size_t msize = INT_MAX;
  	void *buffer = NULL;

@@ -510,25 +514,40 @@ fw_get_filesystem_firmware(struct device *device, 
struct fw_priv *fw_priv,
  	if (!path)
  		return -ENOMEM;

+	fw_path_string = __getname();
+	if (!fw_path_string) {
+		__putname(path);
+		return -ENOMEM;
+	}
+
  	wait_for_initramfs();
-	for (i = 0; i < ARRAY_SIZE(fw_path); i++) {
+	for (i = 0; i < ARRAY_SIZE(fw_paths); i++) {
+		const struct fw_path_s *fw_path = &fw_paths[i];
  		size_t file_size = 0;
  		size_t *file_size_ptr = NULL;

  		/* skip the unset customized path */
-		if (!fw_path[i][0])
+		if (!fw_path->path[0])
  			continue;

+		len = snprintf(fw_path_string, PATH_MAX, "%s%s",
+			fw_path->path, fw_path->append ?
+			init_utsname()->release : "");
+		if (len >= PATH_MAX) {
+			rc = -ENAMETOOLONG;
+			break;
+		}
+
  		/* strip off \n from customized path */
-		maxlen = strlen(fw_path[i]);
+		maxlen = strlen(fw_path_string);
  		if (i == 0) {
-			nt = strchr(fw_path[i], '\n');
+			nt = strchr(fw_path_string, '\n');
  			if (nt)
-				maxlen = nt - fw_path[i];
+				maxlen = nt - fw_path_string;
  		}

  		len = snprintf(path, PATH_MAX, "%.*s/%s%s",
-			       maxlen, fw_path[i],
+			       maxlen, fw_path_string,
  			       fw_priv->fw_name, suffix);
  		if (len >= PATH_MAX) {
  			rc = -ENAMETOOLONG;
@@ -589,6 +608,7 @@ fw_get_filesystem_firmware(struct device *device, 
struct fw_priv *fw_priv,
  		break;
  	}
  	__putname(path);
+	__putname(fw_path_string);

  	return rc;
  }
-- 
2.34.1

---- 8< -------


>> Note: As mentioned by Masahiro in [0], when CONFIG_MODVERSIONS=y it
>> could be possible for a driver to be built as a module with a different
>> kernel baseline and so use a different UTS_RELEASE from that baseline. So
>> now using init_utsname()->release could lead to a change in behaviour
>> in this driver. However, considering the nature of this driver and how it
>> would not make sense to build it as an external module against a different
>> tree, this change should not have any effect on users.
> 
> This is not a "driver", it's the firmware core so this does not make
> sense.
> 
> 
> 
>>
>> [0] https://urldefense.com/v3/__https://lore.kernel.org/lkml/CAK7LNAQ_r5yUjNpOppLkDBQ12sDxBYQTvRZGn1ng8D1POfZr_A@mail.gmail.com/__;!!ACWV5N9M2RV99hQ!I5-MVUh-jmCxwUFtX_eLsjXZpF9BBk6KeBWJ-6mlrfjJjomRDUWQ0_nXpixUddcj_Gz6H_FiBu8lUys6u5kzcqsAyg$
>>
>> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>> Changes in v2:
>> - moved note into commit log and tweaked slightly
>> - add Luis' RB tags, thanks
>>
>> Also verified against fw loader selftest - it seems to show no regression
>> from baseline, however the baeline sometimes hangs (and also does with
>> this patch).
>>
>> diff --git a/drivers/base/firmware_loader/main.c b/drivers/base/firmware_loader/main.c
>> index 3c67f24785fc..9a3671659134 100644
>> --- a/drivers/base/firmware_loader/main.c
>> +++ b/drivers/base/firmware_loader/main.c
>> @@ -38,7 +38,7 @@
>>   #include <linux/zstd.h>
>>   #include <linux/xz.h>
>>   
>> -#include <generated/utsrelease.h>
>> +#include <linux/utsname.h>
>>   
>>   #include "../base.h"
>>   #include "firmware.h"
>> @@ -471,9 +471,9 @@ static int fw_decompress_xz(struct device *dev, struct fw_priv *fw_priv,
>>   static char fw_path_para[256];
>>   static const char * const fw_path[] = {
>>   	fw_path_para,
>> -	"/lib/firmware/updates/" UTS_RELEASE,
>> +	"/lib/firmware/updates/", /* UTS_RELEASE is appended later */
>>   	"/lib/firmware/updates",
>> -	"/lib/firmware/" UTS_RELEASE,
>> +	"/lib/firmware/", /* UTS_RELEASE is appended later */
>>   	"/lib/firmware"
>>   };
>>   
>> @@ -496,7 +496,7 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
>>   	size_t size;
>>   	int i, len, maxlen = 0;
>>   	int rc = -ENOENT;
>> -	char *path, *nt = NULL;
>> +	char *path, *fw_path_string, *nt = NULL;
>>   	size_t msize = INT_MAX;
>>   	void *buffer = NULL;
>>   	dev_err(device, "%s suffix=%s\n", __func__, suffix);
>> @@ -511,6 +511,12 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
>>   	if (!path)
>>   		return -ENOMEM;
>>   
>> +	fw_path_string = __getname();
>> +	if (!fw_path_string) {
>> +		__putname(path);
>> +		return -ENOMEM;
>> +	}
>> +
>>   	wait_for_initramfs();
>>   	for (i = 0; i < ARRAY_SIZE(fw_path); i++) {
>>   		size_t file_size = 0;
>> @@ -521,16 +527,32 @@ fw_get_filesystem_firmware(struct device *device, struct fw_priv *fw_priv,
>>   		if (!fw_path[i][0])
>>   			continue;
>>   
>> +		len = snprintf(fw_path_string, PATH_MAX, "%s", fw_path[i]);
>> +		if (len >= PATH_MAX) {
>> +			rc = -ENAMETOOLONG;
>> +			break;
>> +		}
>> +
>> +		/* Special handling to append UTS_RELEASE */
> 
> You don't really document why you want to do that here, and ick:
> 
>> +		if ((fw_path[i] != fw_path_para) && (fw_path[i][len - 1] == '/')) {
>> +			len = snprintf(fw_path_string, PATH_MAX, "%s%s",
>> +					fw_path[i], init_utsname()->release);
> 
> You now have a "rule" where a trailing / means we add the UTS_RELEASE to
> it, how is anyone going to remember that if they want to add a new path
> to the array above?
> 
> this is going to be a maintenance nightmare, sorry.
> 
> greg k-h


