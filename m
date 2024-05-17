Return-Path: <linux-kernel+bounces-182224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEFD8C8846
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 16:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F321C2198A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 May 2024 14:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C884644E;
	Fri, 17 May 2024 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cmzCyulC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TfbJyHYY"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1944883D;
	Fri, 17 May 2024 14:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715957111; cv=fail; b=BRTzXsJbxmEOoHUFKtlQB6DYDuVMNIgCw7LoO8k6GdwlzDyeXnupdYeTZ9QcCm8xZBDUe++7djjLNtCR8stGPZlTIWOq9e8eiKYhuU5FYcE6mqfZ0nYJtWLB9YCWnGhpOX/ZAFw/iBuqqxUh1y01Z2SHYSqtjVhRVflnsFHvDGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715957111; c=relaxed/simple;
	bh=kzwJiukXHcPFI1lXgHQ6+m1bRSNtcPxkonJ+QRUHTpg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CVpS6mZAtwDa62Emzu5uI1rWm54AdeG+xfCAA8GsZB0WY41lZKXWJZtmYhhuXOj6lt8h9PYigBZC8qotFQMoiLDiB07X1kB77Ad4siG8hEdeK1f0kY8vdsOQzjessRuiqLiCTJAX5G8yhkLxcQ+GDGABebY3QbFs5UOEWYAtGaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cmzCyulC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TfbJyHYY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44HEeAvh012255;
	Fri, 17 May 2024 14:45:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=lzu1EaQvyqrHT4wuQnLnexIzKTcSkyfNp5g5aqTujN8=;
 b=cmzCyulC+X6TbKj+Q9oKqbiewfmYRcDj9il9fp+RxVtboRZ6O9Gt8bo40wW239ys09XR
 CAxxX6CQEu+n8tHm3sboBxMVgGewBShkd40zR8Qo2fgRQPcCg48T/fAEnWZXgWJIcxm3
 QTkl0ekiHhf86DMFyqm2kDBs0htqLnHlcbr3J6YJNHeogucm/962xpPWuPMfc/IeA0iU
 +0ld39mJSCIRorSSLubQZ//G+qpMqzQRdDIIfTBRJMnY7WKUoQeTAE24KeyuwYhaLaC5
 Pz8RS9zMc++UWQAtGedb6jpwRL7rAaA6ncz5Q4ZXlL78OeYPgySAYRvo5D+WhYyqeR8U dw== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y3rh7j31a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 14:44:59 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44HDD7Xb005786;
	Fri, 17 May 2024 14:44:59 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y1y4bpekc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 May 2024 14:44:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APjqyIZWM9TryNpCULyjkcqGyx09fuONM4//I55S2CFgqOR0F4qZnXe9tDngMqXDXCnSjEXp2DQwXOnu9vZe0Pp6d8dIRsCOIY15F9XJVkdBXnqEQjq5wRyZXRrefmuhbeOsBV6Uzml5+Xsvsr+HvmniS3udLCkvumUfwv144y/tfEDP9B/eAANrtmfpmGWzBDmzxLsd/kIYFZ9RGfQ7N/yDQwEoRDr7JgpGBrafmrSbUatK4RsEpYtq+lUoav4yOKRgeztkoLvb+l8jKXEItxlgXzZguU2VuRFlkV8BPjekv4Cuty0vU/1ZZXPPrHR5RNDvfbsBHu2cQw5VOLJEsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lzu1EaQvyqrHT4wuQnLnexIzKTcSkyfNp5g5aqTujN8=;
 b=A3hCmZx0ZeH5d3L/gpJlfPL7tbU0abZijClhrKzT+o3STfc+d0nCptHRG9T1f9wO8LnYMx5SPfAQB4rCdUxIwOpl0HxwBOGzAmSIYmjjlhuwnId8z/ggFCA2ft4gvdoBwLmW96+V01Q/KUsMFKx9Ct1yH6GXTTYoaconEXkLHKCnLzB/AhHgfGKxqkWwHEvgXC7nH/OR3RkX3xPZ/BJG2OWmH/apPcbqvwiJW/1Y2kj307QFI62RwxZF4IqN48wE9POH6lweulI5cAuJe2dRO1egj0DoH8YWAeE0xwYd0qt1OLoF0t+k3SFA/KmRQK3wrQcdMv59pF9NNIJGRw0t/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lzu1EaQvyqrHT4wuQnLnexIzKTcSkyfNp5g5aqTujN8=;
 b=TfbJyHYYhDLAQLy9kfj4nf5DBkXv60JFLA8guvHiWcypqequois6jQEyaOhuW1SlrJEDc2y1gVRWi0kxyfs5/p6Lmq1U8/9r8ImbTY+383nWZGLpPMnx3Z0tt2vbTu9UQD4ENR0IlCsInXmXC7Wv0RTjx2oHibBZBr/d8V+YjHk=
Received: from PH8PR10MB6290.namprd10.prod.outlook.com (2603:10b6:510:1c1::7)
 by MW4PR10MB5749.namprd10.prod.outlook.com (2603:10b6:303:184::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7587.27; Fri, 17 May
 2024 14:44:56 +0000
Received: from PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76]) by PH8PR10MB6290.namprd10.prod.outlook.com
 ([fe80::309b:26bb:11d5:cc76%7]) with mapi id 15.20.7587.026; Fri, 17 May 2024
 14:44:56 +0000
Message-ID: <09d934d5-b5a3-4a6d-a565-e3f70e7a9d55@oracle.com>
Date: Fri, 17 May 2024 20:14:46 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] platform/x86: ISST: fix use-after-free in
 tpmi_sst_dev_remove()
To: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Zhang Rui <rui.zhang@intel.com>, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
References: <20240514092656.3462832-1-harshit.m.mogalapalli@oracle.com>
 <48377484a8a9e479b301e9a9772653a3bc6ccf81.camel@linux.intel.com>
 <e2b386431754d70c6772abee099dce4acc1d4023.camel@linux.intel.com>
Content-Language: en-US
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
In-Reply-To: <e2b386431754d70c6772abee099dce4acc1d4023.camel@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To PH8PR10MB6290.namprd10.prod.outlook.com
 (2603:10b6:510:1c1::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6290:EE_|MW4PR10MB5749:EE_
X-MS-Office365-Filtering-Correlation-Id: 513f38e7-b95a-4750-fb96-08dc767feb1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dDdDVHVqY2FXREtwWEhYWDkrUTdBY2k5Ym1JOUY0bURYL3pWRlJmTC9KVjNk?=
 =?utf-8?B?WEZJeXJnbDc3eHZxcDh5M2JyVmRtZ0JNRUVwOWRvT0QwSXNycE1CU2txQXRn?=
 =?utf-8?B?S1d0TkJlZGIrTDA4bm1UK3IycGRZaHlGZXRtTjlaRVFoUnUrK3YxemdpVVB4?=
 =?utf-8?B?L1VhVmN6MGNwVDQvL2lOVFV6SEp3Rm45VjZoYzNmb3ZTeSt5M1pZUG5ieTJm?=
 =?utf-8?B?WWZEVThCRUZyWXdOOHNNYVJYSlBGTUtPay82U0s5L3lkWXlWY2pUZkQzOEk0?=
 =?utf-8?B?Vmw3NXNTQ2R2ZSt6RXU1NVNDaklRU3BWM0NDN21NV1ZEa2x1UURCNzBuVVB0?=
 =?utf-8?B?NlFXNkFpRzVRMzA0MnRqeWFzdVdCMThVaVNVVytWOGplRnR5a2lyTDl6UXBW?=
 =?utf-8?B?RW5PSXdCVXo5Qk8yeDRacTJNbThzOUFnbzZFSGxHV2hUWHp0Skh2Y0U3L2pD?=
 =?utf-8?B?UmVZcmNkaGtENnB0VmRRK21JSGw2Zm41N2Q4Y2x5S1hzT3dEa0l4STZrMDd2?=
 =?utf-8?B?RTl6b0I0RDRWcVdISk5iYkVOMzZQbGlncjBMZFRwZUQ4eGxjc2s1SVhId3VS?=
 =?utf-8?B?SmNGUnA1cVZHTStHVTMreFA5QmlZTXZ3OSs3Z3hBdUlnSVVhN1hWUDEyNmpV?=
 =?utf-8?B?dVhaN0ZQRVNTaW5yYmNqdDdiWkZ2amZWeDdRRjJlcEJGZ2FqN2hiNmJ6Q0o3?=
 =?utf-8?B?OHZNUXp5OHZUMENQejI4Zm9ReG1hbSt0dlBYUGZxOGZYUzE2ZEgvMEZ4OU51?=
 =?utf-8?B?dGE0WmRWOTZ4SFA4bTI4NkhLbDdjSDQ5aGRRcmsvVWR5ZzAzM2pRelNueU5Z?=
 =?utf-8?B?ZS92ZHFEMkNYM0lGQk4wZ09qR0txU3hvSUNoWGJiV3N4RWhlL2crOVFQeW16?=
 =?utf-8?B?M3FDWUVBSUtudHNOWmFVS2xReVdNdWx0dDdlYUJqOXEyV0haWEF1c1lkaE5I?=
 =?utf-8?B?VGxLdGtNd0licTRCWU8xUDBvdDZYUVluMFBYcWRDUjd5Qk5xaW9FOG0vT2Jo?=
 =?utf-8?B?bzE5MUdSOEEvQlgvSm5BQUJJL0dFZjdZcTFQTnZuY0ZCN3NCVE56UzZFdmwx?=
 =?utf-8?B?a0JLWUFFSHMyeHVwUjR1aHM4Ujh3REtYMmJFS0IzUFlvUVd4Nkp6cFREdzBt?=
 =?utf-8?B?Z09uNlFNZTl1UjdyOXM2UVNuNFI0T2NpRS94QVFReHA3dGw4aTVyNGhQNHNX?=
 =?utf-8?B?RHBYZWxBYmpROWMrclc5eU5BcExYVTdLSW5yWC8yemQ3OHpzL0lEcTF0QnJ6?=
 =?utf-8?B?K016K29JdnFvcUF1MXphVzB1dHFzQjBVQUhoODdvT0dGODRvd2p3MWQwMTBQ?=
 =?utf-8?B?MHQ1YWFnMkdvd1RVeXp2MVBKeDdRTHJWMTk4TktheTN4U202WkhxK0h1aU10?=
 =?utf-8?B?K3ZXRUhpb0M1NlUxUzlJcFVFVWMyRnFCVHI5RXR6OGs0c2pLeTIwRU1yaEJn?=
 =?utf-8?B?VU5QMy9xRUNVRU1aTGhtVVNJdDFKOUY2ZXR0N1hROTBkRS81VHlLYlk5ODVX?=
 =?utf-8?B?R1hhSThHQkFUMnVVaWpxc2V5ZVZLQnBGQUJFM3Q1M3M0RmhSeGVETG9lTWd5?=
 =?utf-8?B?b0ZHT1BxK3NJek1pUzRNeEVCV21qeDFsN3hsWUp3RXkyRFo0MGltRFMxdlFT?=
 =?utf-8?B?eW5xTVNuaHkwdU5PMS9KcS9ldDV4OWVpejk1cE5jaVR3YUNLdWN3RmQ1M0Rl?=
 =?utf-8?B?MWVNNXRlZStkTTVZTmJyUWZSODg1RnhrM3FadHhzYTBndG5mV3A2S2ZRPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6290.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TnFEeWFGaUJPT2FxRHRrR2JHdzFkbVIzWU1NYmo1YmhFd25ib3JsYjk1QnlF?=
 =?utf-8?B?Z2NtYkMyMVhSNlUwWlpIQXVLRHNLcE5uTFhiQXZmdm5zc3B2UVAyZUllOXUw?=
 =?utf-8?B?YXh3emRYdXNET0hBVWNPZTNlTzduS3NObUFmb3ZhdTVTbXd1WnJxSGphSVpY?=
 =?utf-8?B?ck1ha09BeUYxTGtpQ0FUS2RrQjZHcEVTSG9rYmU0VHhEdDB4bFdQbmhZY0hE?=
 =?utf-8?B?NlkvNWMvUG90WS9ySGd5dHZTQ3RRWlBrMi81aFRkaXpNSlorR1hnSTFXOFR2?=
 =?utf-8?B?WVZGN1R1d0NTd3dqS2Z0SEdVVHNlNEtXbGMvL25BeEFJeVFkZ1JvaWJYZzY0?=
 =?utf-8?B?Rm1ldlpRZ01oRzhUN0JXalBIMUZacUxTc1kzTHJMbXdpSVF3RFhTMWFZbE5F?=
 =?utf-8?B?dS9FT3QxUlhZRGc0eXQxTFI0T0hudW9vSml0cUJ3UFR6bTZ4eStUQUxyT3l5?=
 =?utf-8?B?YzVpLzFkNFVvNGkvSFd3K2p1eXhIVjZQNS95STN2Y2h0NEx3TWtpRlNwTEVR?=
 =?utf-8?B?N3V0NjNvVElDaG5ObHNzTXRtcWM1U1ZEVVZpNnF0YjJnR2pmN0FEQmdwckY4?=
 =?utf-8?B?RStJUjVwajh4RFpEb0NhOWF6b3pQUUFyRHRiMlJDdzlzdUppU0Y0VEdpSWNu?=
 =?utf-8?B?ZDJsL2E0Z1FpZUJOT2NnTTZmTmM2eVpYR280bCtGbGg4aDJTZjJuaDl0ejJD?=
 =?utf-8?B?a05iNTg4U2Z2WUFRYXAyWGYrUnU5eHFZVG4rVVZGdDhtWEZEUkdCZnUzYTRv?=
 =?utf-8?B?NnpGTUhSUTZZREZMV1B3RHQ3TXMzKytHRXBqQjRXWEFPQS9PR0tDaXJZbXRS?=
 =?utf-8?B?ZG5GUWZGVGtSclpZa2VjRFgwWFBxSjJsSjlYekJIc1pwbXpxSnNvcHI0SjF5?=
 =?utf-8?B?OHFERTNtQ20zby9ueUVUQm9nKytoM3puN2JoWUJ0cVpQa2VxczdzYnduUWNw?=
 =?utf-8?B?MlltRUNxbXRsTGU4QVBNdVVsZUFPK0thOFVoNFNoN2N2Tjh1Sm5pTUo3cFZB?=
 =?utf-8?B?cjd3Rkd2cUtiVTFIQXJGOUpzeUdobk5hZHM0cGo1eGkwV3NMbW9uUlMvZnZX?=
 =?utf-8?B?SHY4M3R5R2kwdE5PL3R4MVNxT3FlVGJQNDR4eW52aGRSSVN6WVJ5OGFvZita?=
 =?utf-8?B?bVJHTjJVTTFBRzIzeU5sWGRuNklGNDhhYU5VRTUrNUN2dnhvOGd5UmtNTndE?=
 =?utf-8?B?cEo5QkZ5NXMyTHplT3RKUzBXUWZnaXo4anQ2WXZualVPNkxOY3NkWWY3VWIx?=
 =?utf-8?B?ODhIMDc1VkxUL2MyUmtaMDhUd2VLYjNhNVlXT0N4MDA2VHU4b0s1dXZwL1Qz?=
 =?utf-8?B?MllqY08ybGxjN2NYR1dSRFZKSWZIZ2dXMUR6ekx4S0MraDFyRTVNMHRma1Mv?=
 =?utf-8?B?T2Rkc1AxQ1NEeFBtR21xc2ZjZThtWVhJekltZkhWVFF4VWV1cGhhTU9SRU1L?=
 =?utf-8?B?ejNVZUh4dkNXeWUxY20wa1kzcmtCc2J5TlhrWDk5SXZKSG11QXNETC9OL2cz?=
 =?utf-8?B?T1JBb2doMDNUQVZvTHBVbGt0dFdVZS9HWjZ6b1JnYi92aSt0UnRmVVJDT3h5?=
 =?utf-8?B?ajJXbHJLRklCaUJ1RklsUXpjczFqTTEzeVVKdy9nTkpjN0hsKzVWS1FSY3I4?=
 =?utf-8?B?QTZKcjVBVC91eEpHQldQUUI1TUpqT0VTOU1DdnVod1BFV09MVjhEV1VZbmhy?=
 =?utf-8?B?cHk1Z0kxanVNRzVCUW56SVNvZUZDdlVVdWIxeHcxVzBmb1ErWU9idERRaWgy?=
 =?utf-8?B?a2s0RTJKRWkvOXNnSzFVenFHNEhnVkZFUlhCc1NTajR6aTZFOGRXZUdpWEZo?=
 =?utf-8?B?anV0Q2pRR3VDWGwxbnR0ODhSbVVUTDZVWEp5QmJrNnc1bEI3TlpBRU10MUp1?=
 =?utf-8?B?aytsYURROXVkZEFialFvVkwzK1pWNEVVRHdUblA1OGxrNTlIeVRGNy8yUjNM?=
 =?utf-8?B?ejZoeWFxTkhhRXpOY0N4ZGFlYVRZblNsYUVHQjhRVkhCbUFmNTZRekZkTE0w?=
 =?utf-8?B?V3hZdk9iUDZZSG9QVjcwOTFYYkZpR3YrQzNjcVVXRnRSdkI0NHhkeEloclpa?=
 =?utf-8?B?YmNPTXBlQkltWFBtNkRvZUdpYjNJa2FzNmVaSko3UVFzMUt1cy9zQ2N2YitJ?=
 =?utf-8?B?NFFxbmViZ1l4ZXVOM1ROcUpXaTNpc0hSeHNrbk9CbThXMVU2WEJDbFFEbEdC?=
 =?utf-8?Q?Fjr9MNv3oamDgEwlEntxSdw=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	vHlwasTEXPtHoh72zdnyLevaDPNEjZrx6UbGmUvoU6Mg+W1ll6ypvfpg8St+CvflekEfUvi/EVrMNPoLvprpdUKLUCNEpanL1miK6Fc6vIW76upK3IgS/lW9p7Yj28AoRfXadf2yy9wD797QdM7I0S/bzbMInW7JtWRR7DivDhOidi0aEhjRYoNEtxsyoQklruqm+RKcQCYJbJYeLtQoVuNzTlLcCoMVAknabRLPLoX4Ugn+gDpfZDh1oxtgGGEAd5jDjsI0tBo2asGql8k+kvNlUkleYRtCnto4tpmnvmPCk0in9J/9+XrXC+2wdsuTXQCIBDuP8NJPwOurdPtkz6+NxvfQ+Pytgjgam6+EKa8xTPEolQrvzyqAjFBFSfJgyJBCFwOALkRdaDite4LmUQOFU4Y3GtoQ1lGOqS36Jguz4bsEqfnV6KqondZrlwqWyvuyA8vyDxVK1ruXzAFh45MUQh4MbA4RK8kGo6FOybkC4uoMEsh9OUw45RWrtViX44tqyEV4YYD7k51C8SC58AdhpDm5fe+rNM50pPjQd2d5ugZgxtb9TXYn9FPWIo/Hj7PQ5/He7THv2kJhdSvF1lVXa5rQlWa/ydpceFBZ8ho=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 513f38e7-b95a-4750-fb96-08dc767feb1f
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6290.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2024 14:44:56.0514
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5+roGuAWMzpnR6+6lnossWL02+l67bFZzDdrDaflQmVqJObVz5WhgVVjAsYGjfPDtB2HvxRa2vF7Mu6ZidVhsZgnTs0p/4YR3MDsvRg/NOMnKyDmzCX183PnJAa3J9bV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5749
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-17_06,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405170116
X-Proofpoint-ORIG-GUID: MDuLQW2-q1EkUOvYX2BzOPrDslNPScNb
X-Proofpoint-GUID: MDuLQW2-q1EkUOvYX2BzOPrDslNPScNb

On 17/05/24 20:03, srinivas pandruvada wrote:
> On Fri, 2024-05-17 at 07:31 -0700, srinivas pandruvada wrote:
>> On Tue, 2024-05-14 at 02:26 -0700, Harshit Mogalapalli wrote:
>>> In tpmi_sst_dev_remove(), tpmi_sst is dereferenced after being
>>> freed.
>>> Fix this by reordering the kfree() post the dereference.
>>>
>>> Fixes: 9d1d36268f3d ("platform/x86: ISST: Support partitioned
>>> systems")
>>> Signed-off-by: Harshit Mogalapalli
>>> <harshit.m.mogalapalli@oracle.com>
>> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>>
> I realized the line length is 127 chars in commit description.
> Please fix that and run checkpatch.pl before posting again.
> 

Thanks for the ACK.

Sorry I usually run checkpatch.pl, but somehow missed noticing the 
error. Will send it with the commit message fixup.

Thanks,
Harshit
> Thanks,
> Srinivas
> 
>>> ---
>>> This is found by smatch and only compile tested.
>>> ---
>>>   drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git
>>> a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
>>> b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
>>> index 7bac7841ff0a..7fa360073f6e 100644
>>> --- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
>>> +++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
>>> @@ -1610,8 +1610,8 @@ void tpmi_sst_dev_remove(struct
>>> auxiliary_device *auxdev)
>>>          tpmi_sst->partition_mask_current &= ~BIT(plat_info-
>>>> partition);
>>>          /* Free the package instance when the all partitions are
>>> removed */
>>>          if (!tpmi_sst->partition_mask_current) {
>>> -               kfree(tpmi_sst);
>>>                  isst_common.sst_inst[tpmi_sst->package_id] = NULL;
>>> +               kfree(tpmi_sst);
>>>          }
>>>          mutex_unlock(&isst_tpmi_dev_lock);
>>>   }
>>
> 


