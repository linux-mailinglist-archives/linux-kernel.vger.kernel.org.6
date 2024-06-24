Return-Path: <linux-kernel+bounces-227484-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D6D9151DD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:18:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9511B24011
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 15:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598D41EB35;
	Mon, 24 Jun 2024 15:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FA6lJK+o"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20931DFC7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 15:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242306; cv=fail; b=mKweBRs6zzBq7E72+MT9ybPRW2jsvSNEKm+HzA7RatTuvZ4i9FZNY1BMViomWy/93UfG6+5tBvNbnKkFCMXYH2JeEGCHiM/PBdAax5Wnt5GjEET3CwIzYbAWCWIHlfmLD5BPDsCwNfKBGJjVFZLTccntxZXCPu3iB/7XUi/NNO8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242306; c=relaxed/simple;
	bh=58yjxN2C3+9LEYVh7KgF92aRhJRjT6y9pkKaSkpripE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Uj6VhcYXKY6SJjjmsbWX7j77KWJUZ+LNBGk0h18nnu/LWWqOseLJe2z7g1dMQ9MyMqDnEvIgOXz3eDezBiR+gEz0C7FWifGUDqHpJuZsEMPMkfMDcHZ3KXx1T7B0hVttu/ULF/07x4cEwAo7gubx/k+dma5k7bOH6Pug+EpmjvA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FA6lJK+o; arc=fail smtp.client-ip=40.107.243.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PmW23RgSHlEP6DhRgBZNqz6DB9hKbMnKC609TFI6owhlFoa1aLdbHAG9neUNN3zcU9vDcq8GFRtvESynXME+/GJ9VxcllXBQd+ZRTJEw/95WOyJjlzP1ywQ1zlZYT8VazwS3XCuQ8gEuaweD6jpoy2sG0joPEmNv85mqvLEkEZG2ScNVxaHGP2/2T41Ol0hlCs3RWCkuIfFUJofmnLRsgtVRvMW2W++J5qAtqqogtk0URgbMzG3r50UW4q4u93VVUI/KCNKw7cnQ/ER3hePzOTDeYBvTbFrhh5ff0v1VaUbrdrDLuUozJqrWE/HeLmh5lJmhzbJcanLDV+qREi4gCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=efa2O5VfA05iFih1hS3apgcS8qSH161ZBN+/ELn5094=;
 b=j3rdwSU/2ujs8IkXBObrbksF0R1hgjhbMw1XK/CJ0bPUt7njq7/jzP5EixsEiQzpDk3oSX+lV7bs1i+DxkYHxi6f8wI8EcdkzVOVNgQcMKzYELUWnJvx/Q7Xu2JQHKRD1ermOHdK1rPvQ7JQ5Y0dRKCCGlZ6OWlA/R9Pq64Wre230b7VJYuWXVQlcCrXT3V0384UXpvKAd29V5oLI8/DEc1Ev1PghvZTRP8InhBZnreV7l2Kqw0yTBq7YKomtj0qGvudrGrxELCtOnA93ubQyWGoZm5VSNFxC2D6O/kG8KUhnWw6h3y0cBsR5iihPqWA+P8LOfxEjcH/tu+GXUCd1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efa2O5VfA05iFih1hS3apgcS8qSH161ZBN+/ELn5094=;
 b=FA6lJK+ow5yCHwXci1RaSmO1UidmIXZ4gOmPVTdvBpBbJFprYTpMljwFwNCIp7P2moDMqnS5VrTVKtfatVwOdvMl+UgFgvcBawJAYlfL27g3U3PrF5Tg1uuTJ+2YYfiyJ92hJelu1oDG/tuPhyVHYCo+4vkahVfOzojM5Afxm3c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by MN0PR12MB5881.namprd12.prod.outlook.com (2603:10b6:208:379::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 15:18:21 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::bf0:d462:345b:dc52%7]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 15:18:21 +0000
Message-ID: <02db0978-2972-ea84-536a-6aa018480c01@amd.com>
Date: Mon, 24 Jun 2024 10:18:18 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v9 3/3] x86/snp: Convert shared memory back to private on
 kexec
Content-Language: en-US
To: Ashish Kalra <Ashish.Kalra@amd.com>, tglx@linutronix.de,
 mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org
Cc: rafael@kernel.org, hpa@zytor.com, peterz@infradead.org,
 adrian.hunter@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 jun.nakajima@intel.com, rick.p.edgecombe@intel.com, michael.roth@amd.com,
 seanjc@google.com, kai.huang@intel.com, bhe@redhat.com,
 kirill.shutemov@linux.intel.com, bdas@redhat.com, vkuznets@redhat.com,
 dionnaglaze@google.com, anisinha@redhat.com, jroedel@suse.de,
 ardb@kernel.org, dyoung@redhat.com, kexec@lists.infradead.org,
 linux-coco@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
 <cover.1718920799.git.ashish.kalra@amd.com>
 <f6c0ddfd15579674bc234d6e1b84e92768531050.1718920799.git.ashish.kalra@amd.com>
From: Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <f6c0ddfd15579674bc234d6e1b84e92768531050.1718920799.git.ashish.kalra@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9PR11CA0024.namprd11.prod.outlook.com
 (2603:10b6:806:6e::29) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|MN0PR12MB5881:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c1422b-7647-4772-3d23-08dc9460e24d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|7416011|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b2lkUFhweWlsS3V5YjhibmlZeFZDWUtTOXJEcFFIdjJ1c2U1dHJsMUhqWDN6?=
 =?utf-8?B?blNtbjF3Ykx4ajh1dFNFTzg4bk84ZzV6dUo2WmFwdG9jbTZlSU5FYWd1OFpI?=
 =?utf-8?B?RG9tendjaEtsL2puZTJlNzdBUzY2M0lDV0hFZEYrNksvZTZYYzVVYlh4a2JT?=
 =?utf-8?B?MzhTNThqc1Vjb0l0aUJEVU9SN3luM21lN004cXhyelZRNGVJK1I2UVptQnV2?=
 =?utf-8?B?bVVpTG5ybXhoWEZNNklwSFdvQ3FUT2w1VHA4M0k4N0d0WitLUDBvdGJrUkFj?=
 =?utf-8?B?N3dzem5VNXRid3F2UWVRTFluWEh2UzhqR2RHRkplOXNnS3N2ZjBwam5ubmRy?=
 =?utf-8?B?MUJEL2pkQ3p5RDU1a1BkMFNtVFJZN3N3REdQUjRrdXFET2RYK3BlNWlwQlZ0?=
 =?utf-8?B?QWpXanJZNG8vRHV2WEhvMElJR3JudFBjbWFadzY0SW1CY2F4Q3VCRFJRczUx?=
 =?utf-8?B?YVQ2ejB4VzhWdUdoZkZ2REhSem01cGgvVkFWc0tLZjhPanZnNWdveVJvbDZT?=
 =?utf-8?B?UER3c2NlcnAxUk1QTUU1V3hEME5XM2FqckFoRkVla2kwd214UGthZzdTZTky?=
 =?utf-8?B?RlB4dVBRZkdsNlpTb1hDQ0wxNDBDdE9XMUlKeUtxWmp1RDh5WXM5ZFNtVS95?=
 =?utf-8?B?OEI0QUJEbGx3dy94aWN2YXRERVAyWjhzT1hNMWxmQ1Nxd0d6R0JNUlFzbXcz?=
 =?utf-8?B?NHdvSWJMZjc2UnBrR2lqVkx1OHpHT3luUWsraEFDNWJpb2d5dmdMWXU2eVIz?=
 =?utf-8?B?bmpkRnFFSjdEaFdFeC9nQ2xnVWR0ZnhSZzZ6aGNEMnA0Rm9ETE1JckNWaXFk?=
 =?utf-8?B?SU9MSGw3cTU3d2FhTVp6a1AxWnlrdEtNSjFMaDVKbVJxRlVINWd4Q05wYmhD?=
 =?utf-8?B?dlJjUnl5TnlUclc5bDBHL3FzcmJnQVFIWWo4b1JhNzRvd3QwWWlPVTNTdHow?=
 =?utf-8?B?M1hzUVlOZTVJbnZmYUR6MHcvcVlJNzBJaG5Eb2FTcDR4emIzb1NJdnhXMEpD?=
 =?utf-8?B?Z1hkRWJsNEZwUUpEcjAxMEtjSTVpUDRjZ1VKMEZpK0F4R0JLcWdHQnlrK3Fu?=
 =?utf-8?B?RHFSS3ZNaWd1OFBqd2s5eWlLVHVRczZGU0szbjNUbTBrUVA5YWdOMTQ5bi8w?=
 =?utf-8?B?bXpKdUt3dXZMd2NORmlCNVl2OXlWb2JOdXdPM3pTekJGNHVzK3dXa296OURu?=
 =?utf-8?B?U2oyOHNwV01tNW5ManFBYllRVkp0ZnJ0VXBHMVlFNlFCUGd1YndtclRqajhZ?=
 =?utf-8?B?akoxbXd1ZDBSRngreTlZbSt1VEdiTFowUnpQWWN1bUFNemdVL0RCQnhjMWIv?=
 =?utf-8?B?NDIyK2FkdEl4SXFrZ0Uwb3VpSkdaQ25ESlBsd1IzcTAzT3RpVk9yOTFzVThL?=
 =?utf-8?B?S1QrNzd1THNsZmtGTzcyUmk3WFVmMEp1L3lPK2tUTkwwYmhwTE5sUUg4S1Rr?=
 =?utf-8?B?MzhHTThMZXFLNDQrd0FaMWJOVWdWa29BM1JLVkd3Z3RqblNmZEVVK3d6TG5Y?=
 =?utf-8?B?NXQ3cnR2cmhrQzNDblg4UzJuVllTY0NNNEttdjIyQkZXUzlQemkvbHVXK0F3?=
 =?utf-8?B?ZTB5Wkt6c3ZsL3YvL0NoeGRiVy9SaXpZZWFjVW5pYWtnV2w0TFFVNHFpSVh6?=
 =?utf-8?B?dHk4NmVnNWRGTmhpa0dLajhVbXFTUjBnTGZwRUtYMnJYWElXNW9CVmJnZFZY?=
 =?utf-8?B?dWJYYnBPZ1JuWVdpTEFMTERDejUzSzRTaG0zakNma3Q1YjFlbkxEUTJ4VkRT?=
 =?utf-8?Q?wUD7EJgJiqsC1u+0z1gvgMwZkwxKM0mBXy5dwk6?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(7416011)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RDBCV3pkL0I2SHB0ZlNHYlVSTGpka3k4N1J4S2Fqa2VSVVArSDN4UU5hdFh0?=
 =?utf-8?B?cloxbXd0UXJ2TmJDTXZSaEZ0ZG1rYnU2bXJuUHNZdVdNcUpkTTRtaHBNdDY5?=
 =?utf-8?B?R3g1T05LNDhPZHYxRzdCcnlKdXQ5WVo5YkJpdHpabUlqUFFjSmx0aUNuSWJv?=
 =?utf-8?B?R0VSTUtDbVlDKzVIV1JFMk1rRlBFU0l5RlR3WnFpUlpDRS91RjZBTVJJY3Ro?=
 =?utf-8?B?d2VNNm5BVkV6NnBmT3N2LzZyMlh2OWowV29ERUExVmhSRVZnSUEwK3BzM0hU?=
 =?utf-8?B?c0xoVnlrbTBHVEdpYXVLdnorK1NSbk9jd2hlSXZJRHlBdG5ub09odXdKemF3?=
 =?utf-8?B?aEJSLy9wSDhPTUUxcURONnEvVmpKdFJTSzhOUFlUY2ZST05yY2JvTlFBejlw?=
 =?utf-8?B?WW9QSUlNQ2F0ZlRZTC9OMGZ1bGJudHhoR1RHdWNQS1I0NFRqK3VYVWtIcVA2?=
 =?utf-8?B?UnpLQXlnOGRZMWRCMU1kZUZwbjJscUVkUVV5aUlWN0hLWGN6eWU1KzRVcktS?=
 =?utf-8?B?MmJ3TjgzUjFuRnE4Y3IycUlnWTcyNG9pbXA0REhDTUw1bDh5SXB0VUw4Mjc1?=
 =?utf-8?B?VWdST3FnVEJad2lCY1Rkdk50N2JVdmk1YVhEQjdLWENvaTZ1Zk0zQXJTTFg0?=
 =?utf-8?B?YmduY0FtdlArYTVCVXl6UEZQemcxODVaTzczWTBPcEx5a2hVcEVmZUtYZDlK?=
 =?utf-8?B?ZDlqRk9TZlUwK3dRL0p3ZklkTS9qQ20yN1BHYlU3V3hrNm1BUTZFZTUxOG41?=
 =?utf-8?B?ZGcwTWR4bVhJcUlaRElvUXB6MzcyZnU5d3VkbmhDanJ2N3BVR1NKeHljVEJH?=
 =?utf-8?B?cUhTaGtuQVpReU5yaEdlMWxFTm5ja09mbGJKK1dmVnUyZGd6cXhuclNJSGNX?=
 =?utf-8?B?K3EzVCtya1ZCMlRUT3Z4MFducC9YSHdFSzJsQmJNTVoxeEEvdWlTUHIzRklH?=
 =?utf-8?B?TUxqd2RUYUxtbW5hdFFnazgxeTZlMjVxVEpocjZxOGFnd3NVQXNjSXN2Zk9t?=
 =?utf-8?B?MDI5cFNjbW5MbGhQSFNjNTJoMWhQU3RiZWpSdTliLytmU1o1ZXF4VSt6dkQr?=
 =?utf-8?B?cTdzMG5pTURsaUxvR1pIQnFLNEV6OWlxK25Yd2x6M0pmOVE5MWs1enJxaEV0?=
 =?utf-8?B?Y0xCZExLbzFKU0hIU01FSTN5eWVVYXVSNmMrdnB5d1c4NU5icFc5UGdMaDQ1?=
 =?utf-8?B?MUdYdFJhL05mb254Q0hxd0JCb0NkODZ4akYrSEZseW1KWU0zRDFxcjJOVnhE?=
 =?utf-8?B?Y0psTzZVQlVsNG8xN05NenhVUXozY3ljb0d1MVRBWUdlZ29WbnVXWmFabHpR?=
 =?utf-8?B?TlNrbnZoNWl3bGJISW9UMEFmQ3htYWpodVVGY0plaGdpTVVFUUkxVmp5ekk2?=
 =?utf-8?B?NWd1V29BUU9vN2FFNzJ2ZTR2N011V2MzZlFlMjAveFIzNXMzWS84MlZ1dVJz?=
 =?utf-8?B?U3VoWVRWRENIV1FLcVNINjhpb0RIc2crRWc3bFgvWE5jWjMyNVozK0d2ZzJX?=
 =?utf-8?B?eTNPajRxUSt1TEhRODR0UXNydVp0M0wrelNGTFJKekVlZmkwNmxjSm5oMlpq?=
 =?utf-8?B?dnN6L0F1OEU3TnNrZ2poSXdmV3VIaWY3MGF1QUFjWUNFZlI3bWZVdVVrRm5v?=
 =?utf-8?B?VE9wbzlzR21DV1QzYWlIckdxMFlxQTNwWHMrWGVtTnpSRVpmbkY0YlcrMi9h?=
 =?utf-8?B?K3hScUpaci9CTXhQSlhrR2o2Z2ZpQThnSysyZDdISVh6cXpZbXRFSGN6Ym5M?=
 =?utf-8?B?d0VCRlExQUd3UEJ2ZTlKOEVRS29ETlZBQ0lPdGwvckxRazBmc3UrTEJPbjVF?=
 =?utf-8?B?Z2Znc015aGwzeXpPODRMdk80Zm1hMFd2NVFsUnRTQW9NTlhXU0VpclNJdDlP?=
 =?utf-8?B?VmhzWnF5dXUrVzNHQXF4eFRBSExGVTdua3BuNUlPcDRzczNNcVVJdFk2Tzlw?=
 =?utf-8?B?L2tSU0thZjdzR2k1bFUyYTdhV1hyVDhGSGVMWkUvQWlGall1RFMwTWljSjZG?=
 =?utf-8?B?MHkwcWFVeTRsUVR6N2tLaVNCejlIbkkvOTQxejdMQjhhV1JxRjNocS9PMlJB?=
 =?utf-8?B?U2IvRjZESFVsd3BZSCs5ZXhrSzRvVm0vMmNtRm14UEdrMnVSSTFmQkd2MjZk?=
 =?utf-8?Q?kvnPBaLfDO1Ogf92ZOJs8z+q6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c1422b-7647-4772-3d23-08dc9460e24d
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 15:18:21.5752
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fQaDXA9C881rC/pdHgIykn66wkpb0242+dw4i8m+nFMeXgicApBa1bmWqH+ipf4Gr8hqHcyfWpXePnvooWIxYQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5881

On 6/20/24 17:23, Ashish Kalra wrote:
> From: Ashish Kalra <ashish.kalra@amd.com>
> 
> SNP guests allocate shared buffers to perform I/O. It is done by
> allocating pages normally from the buddy allocator and converting them
> to shared with set_memory_decrypted().
> 
> The second kernel has no idea what memory is converted this way. It only
> sees E820_TYPE_RAM.
> 
> Accessing shared memory via private mapping will cause unrecoverable RMP
> page-faults.
> 
> On kexec walk direct mapping and convert all shared memory back to
> private. It makes all RAM private again and second kernel may use it
> normally. Additionally for SNP guests convert all bss decrypted section
> pages back to private.
> 
> The conversion occurs in two steps: stopping new conversions and
> unsharing all memory. In the case of normal kexec, the stopping of
> conversions takes place while scheduling is still functioning. This
> allows for waiting until any ongoing conversions are finished. The
> second step is carried out when all CPUs except one are inactive and
> interrupts are disabled. This prevents any conflicts with code that may
> access shared memory.
> 
> Signed-off-by: Ashish Kalra <ashish.kalra@amd.com>

The pr_debug() calls don't make a lot of sense (and one appears to be in
the wrong location given what it says vs what is done) and should
probably be removed.

Otherwise:

Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>

...

> +	/* Check for GHCB for being part of a PMD range. */
> +	if ((unsigned long)ghcb >= addr &&
> +	    (unsigned long)ghcb <= (addr + (pages * PAGE_SIZE))) {
> +		/*
> +		 * Ensure that the current cpu's GHCB is made private
> +		 * at the end of unshared loop so that we continue to use the
> +		 * optimized GHCB protocol and not force the switch to
> +		 * MSR protocol till the very end.
> +		 */
> +		pr_debug("setting boot_ghcb to NULL for this cpu ghcb\n");
> +		kexec_last_addr_to_make_private = addr;
> +		return true;
> +	}

...

> +		/*
> +		 * Switch to using the MSR protocol to change this cpu's
> +		 * GHCB to private.
> +		 * All the per-cpu GHCBs have been switched back to private,
> +		 * so can't do any more GHCB calls to the hypervisor beyond
> +		 * this point till the kexec kernel starts running.
> +		 */
> +		boot_ghcb = NULL;
> +		sev_cfg.ghcbs_initialized = false;
> +
> +		pr_debug("boot ghcb 0x%lx\n", kexec_last_addr_to_make_private);
> +		pte = lookup_address(kexec_last_addr_to_make_private, &level);
> +		size = page_level_size(level);
> +		set_pte_enc(pte, level, (void *)kexec_last_addr_to_make_private);
> +		snp_set_memory_private(kexec_last_addr_to_make_private, (size / PAGE_SIZE));
> +	}
> +}

