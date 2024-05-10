Return-Path: <linux-kernel+bounces-175812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 559458C256D
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 15:13:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3619BB23D43
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 13:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25874129E92;
	Fri, 10 May 2024 13:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FkihGSH4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="guWAAAbx"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B44612839E;
	Fri, 10 May 2024 13:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715346782; cv=fail; b=YG+azBhdDFkuiHlUV0CiQjmjlQvp1ucq0as8yjs907ZbRPXkUTPyEDkySWigQVuqE4XUMfXyUuJegz7fObrPalKZXq5MpgzktcpR0SFMiPYZ9GHOrldD6wmV+L6NUoly7xZqqIrZe8KJX3mzkmwFqbS7o61pR/UCrnOI5frh688=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715346782; c=relaxed/simple;
	bh=oXVE5Cm0ZiELjqtJ2Nn6wCk6nzA2qcEzKydeYOqImDs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=giAcqmxpwqXgLxvhZWTrUlO1iU6zTniYcqabumZbMyvXi5smiJIwMiXLQHTFJN7zfkBUHXZ7KjcFLUx4Za7NwUPWFGEcoQGAvm+2tMkW2AUsQL0Tz9b6s7z9OI7XIocZxTrcnfvTCH6Xk4dKz472lsTD3NJ5R6hbZn86BfarHaE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FkihGSH4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=guWAAAbx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44AChsuo023833;
	Fri, 10 May 2024 13:12:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : content-type : mime-version;
 s=corp-2023-11-20; bh=oXVE5Cm0ZiELjqtJ2Nn6wCk6nzA2qcEzKydeYOqImDs=;
 b=FkihGSH4SKzp7HzwUNAAi7y6pdqPkTr1bjhHz7G/fgbbq4GkQh8i4yiF3u3me6mZZbjL
 iBuSWUDg+FCDevJuoGlWkF7+1zV1WKVTTL3rO24bsH4akDHgCLbQAJCXntQ1qNs2DSsl
 Y0WTJkP9F9mWNyTfdVrLTNtVqUtCw7D18qYZGY6J47Yd2AHzerzoAdMlYdoh/MH8Twt3
 EMjCz6hFHXlIjqjneJM26HmfdFVaYEL0BP9fAfYrr5D9WYf7mKiQQWa8oOjrKJEtw0u6
 hRMKjibkUEYk1RxLGKOLfuMzqEkAEVvm2wkdA3CoxV8UnQvMyrdx6BWAiFGOCJO6Uv+s cA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y1jd307na-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 13:12:55 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44ACXlGC020172;
	Fri, 10 May 2024 13:12:54 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2041.outbound.protection.outlook.com [104.47.56.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfpv0pt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 13:12:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hqCGQ+aDTKheHG4STYmDg9hZEeyWODMqXTEENGwX+xq53pUI01P1ubyUa7NEA30bEr1NXSp9fGjKWddbdZMReCqYhXvKwdH71StVxlNydbtLd46KSVi1V139gPx35UUj5dXqMGgzP1zODRm0InGMwpoTeQOTS9/iiYINsuXl3FhkkoQmv/8XpS/vpxdRvCIe8TM6Pd4cXIpmF5nKLwWizWEo1xma/KqvM5BFGiOZs8pFZ7+Z70b+CIRym4Zo2IxRUYjkZn2Sn22pzxYAAaroVXNBFY5w/bRrEMCmrHxNMzAuStIO0zt8yrsdinkvdmuR1K8dBJUqHgLnZcGOr7xtIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oXVE5Cm0ZiELjqtJ2Nn6wCk6nzA2qcEzKydeYOqImDs=;
 b=RQP5/NasAaZV6qthqdXtvz18P1uhce3MI3IGcJKAA6tWOaJnUas2HGbQfqxCHeL3c2CYfUkWLg5pj6Uzi/adEhLk14BoX4ARmTORJNd7xAnBlduoVsvmDwzimvLPeJm45MiRGX+9U7L9vKl+ilOjox7PIi7E0f3TkpwCC1txcuRXyQya91CV3xj0fvjwyWEd6SVNZ9OD13wwEoAoil5G95yrD8sbh9ncQhvxl5tA95PIAGFROjWfnnjjLxfxogFtrkueVcKV3PpK9IkWjfWW/vAOqvd2HRAWjmzyCyxlUuLXTG4thI+cZ5KVPHQmG0v993d4tjGuHlsop31MOTnp/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oXVE5Cm0ZiELjqtJ2Nn6wCk6nzA2qcEzKydeYOqImDs=;
 b=guWAAAbxpreaeaO2Qdp+iEAFiR414/wuzvIk9bGYGRabaVuo6eTOYX7wHcB/dYtCYeXXvb2SUBcgBFWC/POubYupQPP4lmSDGursx/g9DyNeF7/w+CUY6bi9ASNAG6CMOFFHyYuROK+FqkpbrGRnFQrLvzNPLefvBtiMaSkG3v4=
Received: from PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
 by CY5PR10MB6214.namprd10.prod.outlook.com (2603:10b6:930:31::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.47; Fri, 10 May
 2024 13:12:51 +0000
Received: from PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240]) by PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240%6]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 13:12:51 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "cve@kernel.org" <cve@kernel.org>,
        "linux-cve-announce@vger.kernel.org"
	<linux-cve-announce@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: CVE-2024-26898: aoe: fix the potential use-after-free problem in
 aoecmd_cfg_pkts
Thread-Topic: CVE-2024-26898: aoe: fix the potential use-after-free problem in
 aoecmd_cfg_pkts
Thread-Index: AQHaotvCQyckG31yD0ysWPEF4GWZ/A==
Date: Fri, 10 May 2024 13:12:50 +0000
Message-ID: <8237dfa9a5f408a76ccf0c5767104383ba55f347.camel@oracle.com>
In-Reply-To: <2024041744-CVE-2024-26898-d199@gregkh>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5563:EE_|CY5PR10MB6214:EE_
x-ms-office365-filtering-correlation-id: 596395a8-a865-4652-aa76-08dc70f2e534
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|1800799015|366007|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?UCtLb0NaczFQczFQSmRLNzIxVGhkVDlZNXJXOGUwVXdxMHJaVUx3MUw2RmVC?=
 =?utf-8?B?TGljcU1OcFV0QjA2WmhudldlMzdwYVpWOEdMNXBzVXh2M0NzK2UrVVF5dFJw?=
 =?utf-8?B?TytDbUFOb1BUWWlIcEdvdTVwLzh6YTN2M2dpckNHSVo5dEllazVGaUNWblM1?=
 =?utf-8?B?azFDQ1dmanpPUmttREkwS0RzRW1ObnBtZm1rOS9BMFBrN0NKd1ErQ1RLbmFY?=
 =?utf-8?B?eisyekJ2M1VzRVp2bHBoeUNkQWZGZXpiaW10ODV5VmE1TVlUUTBOcTBWNXJT?=
 =?utf-8?B?eE55REVpK0syTjN2VXl4ZDRwT0gxdER0eGhXUlhxeVNLZmw3TG1UdG5ibWpx?=
 =?utf-8?B?ZG54bm1FeXQyczFMYUd4cEdCSHFiWmo3NEV1VkVxNkVrQVZxQzl1U0JnOTdG?=
 =?utf-8?B?M1lXNFQ1L2FiNGJCaSt1c3hOa09yM043YTAzK0E0ZEpoUTFGcjZ3K1dUMWM5?=
 =?utf-8?B?bGx1blI4REdlcWxnWFZTVXBOR3crWW85eUZjQWFtUmtHN2xOcExEbGFCRnZq?=
 =?utf-8?B?UjF0YkNJbXVJV2lXeWNhN0tNZGl3anFNMm9HK055L3hNNi93OHdLSUxRdDEr?=
 =?utf-8?B?YUpnT3VuYTdvTXBrMEh0eW1VU3N1SEJ3UFlMSTYwQjFML082eUVwRzdLRGVl?=
 =?utf-8?B?UFJxTWhSTzBDK0hneXNlVk9zQkZzYzV0ZmpGQ2xnMnVOVnRyOXczWWlrZEl1?=
 =?utf-8?B?aUFMUHdtdjZuZlhEcmVoYnJtWFI3MkhjV0xmTHhxV05UVkpicG44U09IakFx?=
 =?utf-8?B?Z3JoV214bW50QVdVU05OaVcxcGtucWRmUkVQV2JDWitrbUFERkxlbXNvcVkr?=
 =?utf-8?B?R0QyU0dLL0ZhcWhQaGhsMEJCMDk4K01vdm5ZWUtNSzlsWTBDOTZ3ZWVxZWph?=
 =?utf-8?B?dk1KNUpwU1lJeERncDIrbFNJdGZLbmI1NThTNW4vNkJLMGZkZ3luTU5BaXQ2?=
 =?utf-8?B?eG5Cek4xd2t0ejhQSVlRZWVMVm5ueXAyZzk2T2N5eHFzQzZIcW42VmM4UDRa?=
 =?utf-8?B?cU5jVkMrQXBKVGhpMHZFbTBhYTNVRHJTRnpwVW1VSlE3SCtSWHN3WER3WFpm?=
 =?utf-8?B?TzdQblVnV05neTlBWDEvaTJYcGY2OFNPclliYUlKZGs3dzdkN081S0RUWkNu?=
 =?utf-8?B?TXk1OFFNdmJNRUV0ZXJaY0Y0dzd0VjAxdEcyWFRFZm1DeXpCMkN1S0wvSUE5?=
 =?utf-8?B?bXlpSWtrS3plOCs3VXVST21pUzIxMnNDaVowVi9kajIzS1FKMUVLYkNkVEN6?=
 =?utf-8?B?K0lvbmxOQmFsVGVZOU1XQldPR2QwNk1EcjVJbnRudXhMZjdyTE9NWHBZUXNX?=
 =?utf-8?B?T1VyRzB4VmhrNG9BUHFjM3hjd1djNDdtWFhkMDByZDJRSWxvMDVzQlV2QXd0?=
 =?utf-8?B?NGJmdFIzM2VXVGp6N3pURlVMZkhabHBkSnc3bmFXZEplRGJtU3pRSUdrWHQz?=
 =?utf-8?B?SFF2amJFa0ZWSWN2clcxVW5FLzNNUk9HclZjdEdOZEJLcVNHc3RrSGNzbE1m?=
 =?utf-8?B?a2RxSTRKNmhwWExSbksrOXpyazNLTlc4YXdJQzMzbTdWTFFqdHRIRkEvbUYz?=
 =?utf-8?B?MFArM2NKbFRKMzhBZHA2dm1kZTRwUEV3QjdlRnVPTDE4WU8zNnVQd1c5UzZt?=
 =?utf-8?B?ZkJRSXJTRVVob0tXK05kTUhyb2krRitxdGUxZGMzUTRhZVlqb3lpaE9EU3k2?=
 =?utf-8?B?aEM3UmpEUjVrMEFha0drVGsvOXNCMzhJR2I0YlpNM0FTMzZFTklsN0xVbzZL?=
 =?utf-8?B?Mk1MSU5Ra0FGN0VBZGFmOENrQlM4UzNBRk5JNG00cjMwMHlNQWJKT0VzV3V2?=
 =?utf-8?B?UFp2dnNOemVsOW9BOENyZz09?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?SmxRMFdQdit6YVF3R1lwOGFGOE1UOVRzdlowZHA2OWx6Skx5UDhpazVQSTVM?=
 =?utf-8?B?NnFhWm93STFLRjlpbEFtMEdwM0hYZlZweWh1eW1IVmZZeUt0TDZpUXJBLzFm?=
 =?utf-8?B?V0R1Ykk4M3dFbEpWUi9yYnpmTDJ3NVFxVmZRZXlYTlY4bEZaSWZoNUdPRVhi?=
 =?utf-8?B?QWRhTC9hRTJuOUNVZGhDWmlVMi9PSHlIbW9Pem9uL3pBN29QTlZiaTZCUHZI?=
 =?utf-8?B?Q0ViNVgyWlNUM00weE1kZkJvdThJcytmeDZORkJ6M2NSaWo5QXJ0K3lIZjBN?=
 =?utf-8?B?QURIazM5aVppQXc1dThtU2g3TWsyNXUxbnNJUk5ZWFExVGwyT3dVeTlNb3F5?=
 =?utf-8?B?S0NCS2toNTcyYXplUXVybXVlWkN6Q1BkRXA2YWl1T0J6N0NPci9DRVh3RURC?=
 =?utf-8?B?cXpYYkE4V010Sy9GdTVRaFB1VFNNWXlmWE40WGZIcnh0aGVZZ0RCenhZc3dL?=
 =?utf-8?B?NTBOOGUwUHNxdndwcitsdElCUXBjd2dxNWJiVS9jR1c5ckhhRGNmWGNJc21H?=
 =?utf-8?B?T2J2SUg4V2NCMnJhZEE2K3BjeHhUSmFNc0toTWExMGNGMUREdjM0YXlBdXo4?=
 =?utf-8?B?YzBQa1JjWjRDbFlyd1d6UGZtUVQ1U0JuaENRNHZlV2xJTXNhVHRtWVdqNnZW?=
 =?utf-8?B?WUJwdVRrSFpjZ2lYUTRRVWZpVXl0amhTZ3I4WVhvdFkySDJYL2FZOXgzeTRB?=
 =?utf-8?B?WWtSNFNkQ3JmbllYNVRSdUxuL1ptVGJDUUtteTdtaTZuajAxZ3lNOWlzMXJn?=
 =?utf-8?B?RUU1R2kxcitUZkY3RUJHREpidzkwbmptLzhpTWFhK1o0eDhjMGZqSmFYOEcw?=
 =?utf-8?B?RTM0MkVYYi9va2VVWUpZUzgyaitoOHJOcGlhZlg2R01qaVlJbWlrRGFpMHlw?=
 =?utf-8?B?MmNzNEFvYUtYOTZ6WlBGMVVTSHVlNkxSMitGOEtGQjh3M1RoQzMvVFE1amdQ?=
 =?utf-8?B?bGlibmZlQVBnek1yS0lsdTU1ek9va0pHTTFxMkQwbHlScXRDTWJpZ3phWThu?=
 =?utf-8?B?bDdXUkFLQlorVFFNSS90SFd0RjFrSFVhVXMrRFJlRXd5d3MrNVA5andnOE0v?=
 =?utf-8?B?c0hleG1TQlg5THdwUjdFZ3hZVTBpOWc1TVIveFdyQUJ1WDBRZkp1dTVzUTNs?=
 =?utf-8?B?K0MrbmZHUGJZTVVjWDRRTlVpYzFtOEtHbDVKSStLdjdNd2w1NHhwMHAwRjF4?=
 =?utf-8?B?ZExoeGR5SllJdTVrVUdpOWFqSkVlSjl6YUhDYVVGOUx0TkNDd2xSd2VCQ1l5?=
 =?utf-8?B?YTFtSHdrMXF6Tldjd29VRm5qWHpqMC9rYW01ZDFqWGVvSVI4ek5tb084V25y?=
 =?utf-8?B?WFY5K0x2T2tjMWEyWHRnRE9zTVNtb2ZDUnFqajlZRlM3aGJSdEtIb0Q4eDQr?=
 =?utf-8?B?Yy9pUGk5clI0RUQvUUkvS1M1N1JJUEJUU09kengwY0NMclR1WUEvVVZCb1o4?=
 =?utf-8?B?KzhmWVhBdFp1TEMvWXVIZ1d4Z01McS9PSGhQK1VkeVBjUHB0dnNaWCthUk15?=
 =?utf-8?B?dmdtY0NncFVuVzZBQmhJZnVhUXVSeUpwbEpOSnJHd1RNTG5haDAxbkU0dnUx?=
 =?utf-8?B?QUZBUEVaUkIrYkdVUzhtL3FBejBwVGpaZ0dNTWJHUEVVUWhXN0xXalFjNkdX?=
 =?utf-8?B?M2pMaGlsekswemVPWVBiZDFEUndPT2VlaURzK3RnUDZid1h3N0xkU3ZFWTlR?=
 =?utf-8?B?bEt2R01obkFRS3BJdzlzTG9SMUl3VjM4bHdWZGVEZGJ3UWVGRkh2dW5sbGtv?=
 =?utf-8?B?a0FubDRzVDRGaWE2YVBGcVpvbWZXKzg5TnlBUkNqTDliZDBVY2VJcWdENVp2?=
 =?utf-8?B?SVBQNDRBeFJKMTRRMmpySGRJMkgvL1hkVVNMajZWYzdsOEw2R2NKRXVYNEFO?=
 =?utf-8?B?TXhjRGNlQWhSenRNL015SVl5dDlzYVREby8yUmZhYm0zMlE0Ri9NN2JPRkI4?=
 =?utf-8?B?YllFY3NCb3ZJbGhkbmFtazVLc0xzcXNVZmQ2Z1Bia2toK1lmMWNOd1JzSWFp?=
 =?utf-8?B?QTJoemV5WTAxSzMxODhyMmJjNEkybk9LWkZMbGNpOWlYQVh3Qmw3VVp6a0c5?=
 =?utf-8?B?c3o2OFgwcmwxVDBZOXNscXFJYXEvK1ZNNkgwNFdodHV6WThXTjVZbVB4VTdC?=
 =?utf-8?B?QTRPbTArQlZDb1l2MngybC9hazBBNURzSWZIZkljYzZ0NTlWMVU2Q3RPamUx?=
 =?utf-8?Q?scabeq4bN4rHgW/kNOPMi6U/BbN+Vu7RxPN95/3fKZh5?=
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-3T+5udiHJe8nu8CiURKw"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	pWBLpJuPHI7nRHG4hBRu5IvVKyyCBzmvYUNwnwNTwQBrJH690jJqMkKYILOQJjQ3lKTgXylm8K9rmSu5m0XNhw6/RS3OVj4YwVG/pxwAFRCkX7uQfPTmEHlb1lUvgMPnb6AI5hb1kvNEczHHS6OlXtMxOg8kDBQbnJXvR5FpMWqUL03snVdMbJUKhVi4g7LEu+LmpvAm8zgb3QLzAGitxkh+OxXKbYza2UM9B0Ao/O/oxlD5AGFMeh0jR+o1pxndavtCEcl5wZwHrLSNDcxbg8+b3r523lYcgPdA7ZiyR6hdVfvz6re/c4Mvpy8yDqUY+jfHVzjQ/RMAXQTyEJgc0W11GcL1+hFpGOK6piEwBvH5xzgtCt6+0T7NsZvjCV8J76ptLAk+52fPZ27RFmCrPthRwVjgFx0frurMw1L9y8Z8L6B9T4o6BhrcbMbTStbiuXSelnVcO/d+9OPWWmPszHPGc3ixWvHMEyvEUeSIlNQh+HPvWU16837KI8noj78K9ozQq1apDF20LPYQbmjJqaR7JgypDyiS5S/MGXlYugDiYrZdE5jqrfy0gmZSkm3HJSX+KPDw6V6BgmsaiHJre/xAt1AE/LgVw16jc65qqAo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 596395a8-a865-4652-aa76-08dc70f2e534
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 May 2024 13:12:50.9400
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1nm7OYih0f3lFgAnwA0q+Qrq29BpmcTIGWmIOK8ho76W9cjNwnNmcBQr2vprd+KmPcH2CJonIva1WdyRwtwF0XtFpX1/caOhtm8JM2uNPak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6214
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_09,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxlogscore=798 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405100094
X-Proofpoint-GUID: WHbrARYcSVoUgG7scaFj8sIt4cj8iU-H
X-Proofpoint-ORIG-GUID: WHbrARYcSVoUgG7scaFj8sIt4cj8iU-H

--=-3T+5udiHJe8nu8CiURKw
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> In the Linux kernel, the following vulnerability has been resolved:
>=20
> aoe: fix the potential use-after-free problem in aoecmd_cfg_pkts
>=20
> This patch is against CVE-2023-6270. The description of cve is:
>=20
> [...]
>=20
> The Linux kernel CVE team has assigned CVE-2024-26898 to this issue.

Isn't the new CVE a duplicate?

Thanks,
Siddh

--=-3T+5udiHJe8nu8CiURKw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmY+HUgACgkQBwq/MEwk
8ioDahAAjmEBdhmFHytfWFqDJVKj49Dtm/DY8sr9ATMi4RtV0g0OtxE2MsbPM3n0
MhncaCXact3KfbDrzmdw/vTmx6MyqPYFaRSdR5zHaVUUAROOnjGEta+l8iBfjZ28
8mLB8Tf9Z6WYX+FbO+qHA9l9amqdfaEd9s9eqmiUk01qPBKJFhOWPq0wv8ywDNrR
4EqbfuBPrbN5uBl63KFMos8BJjRj37JYmIApkJK790Vj6Yqcig/1pL0K4dd4kFv1
UXBzSJOznnEHHqJSoiQRhLI/vgqzYBBqaSRhggNkLEbRfLyzDpXIlz4Y0RMYHmea
qxYk0Ef/w8TiljLNfdmgHChBXCkl78D4+DhFWMhRMoPtt0rIA4xOZrHbdazLuKLd
GJA9S85tGTuolDDSQLZxvGOV+lNGFPkNA6ob/fGr+VTFOcfFIfWhJQHIJGIrEXZP
BkNFrM2KYukt2yRXWLUU/zJ9KB/sPBh4tNcJHbBWzOLV+TFcQw1VVYMRmA5znsIo
FISIJHmJAV2QHvJBi/wFMckJZsyYHeeMihaePTJao4kMZcqSc7vDggO6KtErocV0
sXgwBzqxTZDhccso8aZXbUJUmFgxSFR8VpRF/N6ekPEhqv9IxNeA+5pU3B5ELw8d
Y8+wElX2QJ/SS+8vd1URlHQJQE800lga97aCmylA/L8B9HimuZ8=
=Ng/z
-----END PGP SIGNATURE-----

--=-3T+5udiHJe8nu8CiURKw--

