Return-Path: <linux-kernel+bounces-187950-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D42F48CDB2E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 22:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32409B21E56
	for <lists+linux-kernel@lfdr.de>; Thu, 23 May 2024 20:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEAC483CC9;
	Thu, 23 May 2024 20:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AS3LxvcA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SqsKWv36"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B43147CF30
	for <linux-kernel@vger.kernel.org>; Thu, 23 May 2024 20:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716494535; cv=fail; b=LBDwOFunwzpA/rceLN4UFbRgG3xDrBizFemDNBTb2qrTAui24D3q2caXxtP18vT86+HE+zsfAuzR3PbclqLeK6yX2a+jsYOueDb+gqqA4XwYMMeL5v+8yCaYAzz2YAMq4qk23xejl2Tynj3VzGl9NK8B7Wc2I0YZ/tfmzlpNm7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716494535; c=relaxed/simple;
	bh=JhEAYB/GbNr7nst4tMuS16bBT0Z1koBVvU2taECQbUw=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NMMG2HDYmDmda+BcXxFWWpetu+/TKwTJ0Q2HBFCwxT6/ROxfgE18D2FQlAlhKFfA+r8nD3yPI8JDMxW+ZuhCyRa1u1wAz9jvuDrIqGYrsox5GyDDdHGFd3AYlyukCUhI6DuQTcfKN9q57BCULsCYveYo8Xervoo9MLXAFLTxbJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AS3LxvcA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SqsKWv36; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44NJ1QR4021934;
	Thu, 23 May 2024 20:02:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=xzfvSPl3BAVzHCVnuOS3c920oV5qu20aTVx+5Glh9rQ=;
 b=AS3LxvcAHPpSsP1udYFVMsas0ZCxpr+SHea8xYdLc3Gzw9/ZXZj62hqnDzI8kv3gRAT0
 u8tAjG/3R9JWpMYBiLEiOWMUyiKgZxxmL59OKAZIGfFXnilqg7WGNOumfI0hGLPtYF6i
 d89DmAqyc8MqkhSw9yO6ewXxSHhBN0W+5Y29QQkNi9/fIHsbcnCX4LxZ4uUaqTVhXUcT
 reTmGWmvjmrayKOiojlC62M/AyD6uQnWoJqHECz30mrK1d1KJO/9/qTrDmUP6LwVIc7o
 Vt/XR5+J7bb3DmTiizpngC+vonE6v7eL08ax2iM03FmfEr2+Y2kzV9DGGksKC3rMKAQ1 QQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6mvvb1gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2024 20:01:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44NIO704038031;
	Thu, 23 May 2024 20:01:58 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6jsh2pum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 May 2024 20:01:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NX5oYIboYuR1nHoYNrxDlOHGFFgDhAMEWxxzR/boCkuRDLeV4u+hWoQDNq+i9ATHMAzNPr1DUqmh7Y38OWt+3YE/YJsaGj4TEYtz1Hr/ZH151ibu0NZ0qJOscEP/ILNIk9Dna8DRXguR2UeJpVciJDBv06+SwHLZCJliDVoLVTkRQFvivFiElh9G2on25PrdlEMx1UW9zDJjqIgp37vpReHF6/AQITBk/wDa5HXzFjfjRQUKH/JKgaPOsoY2HxUPZPg3dqADJk1Ki4yiao9qdDlmnotLuWVurpiS7ppLAIrmXvXy7xxiG6BDJ9Ii4F/hNUexilsAQRxDhk53zAjMNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xzfvSPl3BAVzHCVnuOS3c920oV5qu20aTVx+5Glh9rQ=;
 b=KwCS5IEcDzReMIbSUBUcMP+DyuK61Vdcl12dV/Ia8T/KLF0LwL4DcOuW8DTKedIjNJDWbWvBljj5U7FiKrNPZLADPKeSldDx0KBQdAksZUgzdmben9zQ8hCZHP3Ypq2DjUHl+OpsMM3q77qBBTUfLgx1ogux5XL+mb9ahMd+wcA6EjsHLaDKM+k6VaR6gb5U72GCONPS7mAwS9/GooKn0sjpmICCKu0jC0CPc3k+OtK9cOZNEagogXP3C8z/mTJvao4M8u/ZTEsozKaWsWS3WlGxW5WPOcNBhVOW+W68rtmiKyAlwZ2KKyVC+yUiNjADLbdIA+RHe2hpNkfYCEyTLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xzfvSPl3BAVzHCVnuOS3c920oV5qu20aTVx+5Glh9rQ=;
 b=SqsKWv36Ij6hjzTPVnHTlnUoAJruPAThLqI/Rw4os5ZrU9BLloupvsJNSF0aAtEsX7Tmq8Gk5HPU1FHY0FgNbFxNYQnW2Dhke53EtgReAD9jKy1RpkQ1Acx3FN0aN/XgYlYtbf48dMhtMegNp3zWlZIjAL3Ym1FRhbz9Wz2aR3E=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by DS0PR10MB6149.namprd10.prod.outlook.com (2603:10b6:8:c7::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.22; Thu, 23 May
 2024 20:01:55 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::3db0:ec21:1957:f1b3]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::3db0:ec21:1957:f1b3%6]) with mapi id 15.20.7611.016; Thu, 23 May 2024
 20:01:54 +0000
Message-ID: <9d217b1a-c11f-4fd7-ae81-c704268da2ab@oracle.com>
Date: Thu, 23 May 2024 13:01:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/5] mm/memory-failure: send SIGBUS in the event of thp
 split fail
To: Miaohe Lin <linmiaohe@huawei.com>, nao.horiguchi@gmail.com,
        akpm@linux-foundation.org, osalvador@suse.de, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20240521235429.2368017-1-jane.chu@oracle.com>
 <20240521235429.2368017-6-jane.chu@oracle.com>
 <c95a0336-6755-03a4-5c09-273d538e139e@huawei.com>
Content-Language: en-US
From: Jane Chu <jane.chu@oracle.com>
In-Reply-To: <c95a0336-6755-03a4-5c09-273d538e139e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR08CA0006.namprd08.prod.outlook.com
 (2603:10b6:208:239::11) To SJ0PR10MB4429.namprd10.prod.outlook.com
 (2603:10b6:a03:2d1::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4429:EE_|DS0PR10MB6149:EE_
X-MS-Office365-Filtering-Correlation-Id: fda850dd-b24a-4563-4eb6-08dc7b633195
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?OUhGejhLT1VndC8raVhadFpGVzQ5c1JPUjFaelJaZCt3YktNQy9VRXc3OUQw?=
 =?utf-8?B?N0xvMDVHbnhPVW1oTzYydGZMZko0aVRqZUduVDNLSjJRK1B6L2g2UXU5WDVw?=
 =?utf-8?B?ZzVtNkZiYml2VHo2ZTA0UEpGcmN1enhwbERXN0lWN1VFM2ZheEQ0cVo0dnl6?=
 =?utf-8?B?TVNQeDVmcVBxMzhBRDhNcjc4RTNOalUzR1lkVC8wYy8yaHFVdXNPWGJ3RDZv?=
 =?utf-8?B?K3FVOUlSeEFCTXNPSmg2V1gyK29ZSksyeXBMWW1JanBMTDIzNVRSU2hKT0xp?=
 =?utf-8?B?RzV6SlB2b0NjNWpCOG5HVnlNbkhoaXRMTDhhNW9IRDQvRFdJL2QxTjFVcGNt?=
 =?utf-8?B?Nmw5czV6cFFTSTRmbjhPak8rdTNOV0l0a1RQc0xYYlg4ZlJma2t0dG0vTFUr?=
 =?utf-8?B?ZjVIZG5ZbzJpNXlraWpkVFJGSElZUEtlNmxLakJXaG1aS2RZVlNVYkhoc21F?=
 =?utf-8?B?NjNRRVRaY2pnbEFhZlduSnZCQ2xnckkzWVZaSzcwbkcweGJ1cG1nbUVjRmFw?=
 =?utf-8?B?T3lMWTVrRnk2STRUclg3ZFBsTzJVWWpjajhQVDlBMUNjRnpId0l1Y0ZqN0RE?=
 =?utf-8?B?bXk5R1hkaDNPUzkvdHVaZTdSRHZHNWRxb0hwcW54R3VwaTVCVmtxMGdORCs0?=
 =?utf-8?B?M3ZTNTlVZlo5UFNPNXdCTVhPb2xFc0kyMHh1Z3Ezc0k0cU5SWHk1eTBwMzZ1?=
 =?utf-8?B?THY4U1FTSkVneWVZeHhGWitpTDY4TnNtZHJZNUh2U0hZT1NWbHZQRk9rbk9o?=
 =?utf-8?B?V0FZeGpjME1HazV3aU9JSEFpZHhFN1FyeEVWMmowam80NGwxRUlUdHhOcFdQ?=
 =?utf-8?B?dDFBOEVxNFNDVEc1ZlVyN1p2UzBxWVVHZ1czdlZzUzBqdmwrc3djYUFYOWdr?=
 =?utf-8?B?RGlYSWJ3aU1WY0JETTBSMWZ0a3QwakwwbVI1Y2huS0M5Um53N3EybEdjcllC?=
 =?utf-8?B?dDVQYUgzK3hIMjU1cENrRzhRQjlmb0luTnRoUXh3YUlVR25JRE1aaGFFZW1h?=
 =?utf-8?B?VVZHSnVlMCs5ek5GdFRhVi9CbWtPK2R2VmlyV2tIT2dVZ0JlMy9YVTh4Ukpj?=
 =?utf-8?B?TzdTc0pPaWUvVDJHQndYeGpqSFJza1NwemZEeDJxbmk2M3dTWHNvZ1I0TlF6?=
 =?utf-8?B?YWZHZVBUR1RYZFkyRndnUDFwemNlZ0ZtSnYwVVpzWmYzc0dqUjJlc2hwbWw0?=
 =?utf-8?B?eXhtTEZzR2ROcHR0Y1lpWUQySWRoZFNCTzh2SjNqUm9zREtUMjJxdFhmN2lI?=
 =?utf-8?B?dGszeTJ1Mm5WbUt5TmozQlJOenF4V2EzQzA0TlR2SkVPRXJwd3dFTENsbVho?=
 =?utf-8?B?QjJjb0FrWlNPSy8waU04U3V1K2tYTVoyN3QyK3N6MlNCNjVLUjAyOUlUVHkr?=
 =?utf-8?B?b1p5cGFsYTFoVXRldEtMQURycXlFMGprcjhRZmN3U0JNbEkxOFcwSjhuWEYy?=
 =?utf-8?B?ajVNWlZoM1E4WUVRMjFjam03dHVSYW9RVjlZRVVkaTVGYTJUUHhyRGF1ODJy?=
 =?utf-8?B?d3A4aWRwRm1FazJoR1RsY3locjhHZWlZbWtUMHAwKzIrek5TQ1FYQlptYUxp?=
 =?utf-8?B?cG4xaG5kQVBtU0xxWVJXRmQ2cnVVeTFCbFNNcXpQcG1pNlY3YndJSVNaTFNO?=
 =?utf-8?B?ZjdXdkJDRWdTaFdURlpGSUtvd1drdUJTY2VLQmdlZThDaVB4QkgxTWFsbk1R?=
 =?utf-8?B?dWVvdVd4WmM2akkxbTlTclQvOHZIVlA0ZkxwQU1SK3ovU3lxUkE5ay9nPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Mk9xbEM1ZHNhRXBXZFlSMWxJekVtZFhlb1BRaDR4SU1GeC8ydlJEZmJZbldC?=
 =?utf-8?B?K3BheXd2c05OWmQ2a3ZpY1hKWjhXVzA1UzV1SWtIMzRPMVZ0elVFQ3FjWDdU?=
 =?utf-8?B?MWNhT3BjdklubHNGVjZBczdkYUNLaTJnM2tZZlp2NFdLeGN4bjFidWdXU0FX?=
 =?utf-8?B?SzNMYitEdjlMZGlKWUNza1VWeU5qbmZ1NWprK0JmcERoLzBJSG9zaGl6Ynp5?=
 =?utf-8?B?c1VoSkh5QlUzRnJYVVFod1N4eFYxSDBVaFZnYjJXYjlreTg4TFA4U2Z5Q01O?=
 =?utf-8?B?RDg1VXR0V3gvQXh1YmQrYmRtbGN4cVVEK3RRUEdCSC9zbW5kNTBZKzd6SFBR?=
 =?utf-8?B?UmxxWGFuOENRUDB5WENHM3pqdnd4VHQ2TStLSEdOL0ZmTmhDdFFPYkpPa0NS?=
 =?utf-8?B?bTFyK2c2SXd1UGFYSXFLd2VIcmxRSWN6VkFLcWd6ejZIeGVLK1lmeDVSZlEy?=
 =?utf-8?B?QXd4YWhtMG5rWnZCWVV5WHNPaHN1TTRlcUtYNDBhM2RzRUFpdnhBbTJSNEJE?=
 =?utf-8?B?Zk4va1M1MEVyTm5QeFR5VFNYQkpxOUhhTVd1cjVYYW8xeWcrNXl3eEFxUGVq?=
 =?utf-8?B?cnlIbWtJNkw0K1owanZTZGs4LzVDM2dNVW12WnZyMTB0MHRPYnhjOUdYQTZD?=
 =?utf-8?B?ZzFEbUhlcUl2TGlVa1ZGKzliTTFEbU9sU2pjUmdGR1ZBQnFGMXZ3Y0Zla3N1?=
 =?utf-8?B?NnkycW13U1ZoOUc5b25yejJ5Wnh2WE5IbnlEclQwSFcwSUszK250ekZ1cStq?=
 =?utf-8?B?ZjdNN0hqZ3ZIMy9ieTZFempIQWd4U2l2OTJjM0ZHRVNWSEdUZmdIQkhiZG9V?=
 =?utf-8?B?cWE4a1R1UzV0Ukd6VHRzbjBmQkhqa2J1ZE5NeXo2MTZqTlNBd0JkZTQzTjRV?=
 =?utf-8?B?SnlMc2lXOGFhQUwvaUFOcmgyN1BGOWtKWUtOeG5TVEl6WmVWclRFZVhyb0p5?=
 =?utf-8?B?aVFkTnhxM1V4QStyMUJtRnEvek45ck4vTWV4TmtzZk9xNzFscEI3RnJVdDJY?=
 =?utf-8?B?QXkxTVA1UG1UKzJQSVRrWUIzVkh6eUhueFJHb1dWckcxUzBmWWhNYjI1Q0dy?=
 =?utf-8?B?czVsM01seVdlTU9RZU8vRmJGWlltR3VYMGpkdlhZZmhBTkJyZUxmSWVreDY5?=
 =?utf-8?B?Nk9xd1VBYUpBNGZBcmppUVdCZUZjeVdHanpjVkFVcGNFM3ZnQjd0TExDUDRu?=
 =?utf-8?B?OVZjOG1aYzYrQm5saG01Y1d2R09HMXpRc2xJdlVTSkxMYUx1M0ZzOGlYQ0dZ?=
 =?utf-8?B?OHhscitsNVhieXUzQnZTdy90YVhmek9KcWxPOFRCWlFXaDdrTHVreGtDeWhw?=
 =?utf-8?B?NEREQ2hqWFI4WE8wbXFCOTBWMW9mUW5LTmtuWWdhdlRDUHZYU2lyZ3NJU21r?=
 =?utf-8?B?ams0NElIYzdEL2dia2FDVmRsSUxPcHU5NlhKZkRTalBOTklRZ01KcWZCell0?=
 =?utf-8?B?cDN2WEVRTC9XYkthMjlVaTZ0UGM0QVorU0dKa3ZIUTVQaFJVTk1PME42aVZD?=
 =?utf-8?B?c2dqcmdrT29tSlpXYmhUYUR0WitSSEhsUTN6ZWcvMERxZm9mbWpKSnNtK3ZF?=
 =?utf-8?B?akhCVXZtUVhqK25pTmorWWhweEVHTGhiUThCK1ExeFdZUmtCcTZIejlRc0x3?=
 =?utf-8?B?N2szSGZxSzk4NGZtZ1JIQWlCT3VsOHNTVlg3VjM1ZFZOaVpJdm5xN2hsakIr?=
 =?utf-8?B?RWFsSldPOFZFRG9sSm84TnlqUXpDbTRrdjlQUzEyV3BpQ2tKZm0zd1ptUHls?=
 =?utf-8?B?MlpOVkc4cXZIeW9Ra0NiM0dpTHVXRmJseC9MbVhkaUkwaENIT0ZkV1N2bG02?=
 =?utf-8?B?a0JyREhxV2drSVdVVXhBdEgrOElmUzJSdTJrT3huMDREWENjelg4YXpyU29O?=
 =?utf-8?B?eU8xa2N5am1mZkx5WTVuZHJWeVdtd1pSR3BHZHBqUXFtbU5LWU16SE51ZlBy?=
 =?utf-8?B?akYzd3dhbWM4TlRMbG9uMjhUVXhIYVl6ZDNsQ0xvc0thZWRoZHZoOEZNZ2hm?=
 =?utf-8?B?MGFVcnFMTWpvZmtWd2NBY1lKWkI5N1dKVkpHd21LVDdhVFE5dHV4UWFUQnA4?=
 =?utf-8?B?bHh4c3M3WG1FVDdaUFd5WmdoNnZzbHBjSG9DN1QyRmJ5T1JHeWQ3NCtpblRP?=
 =?utf-8?Q?LNTslnrwy4acER7LPfROKOXUm?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ja5L/IcAG+tvkL9BjkaXDkdxMcIF5OjZsJBa9q3+GtIcZGmj+0xuOlw1uwKTyIppFtf9wDh8+EzudvxUgIxSf8pskf3kdIGGESaB8ryWtaPDzaqstuy1F7e352RYxliv2MfJH/i3CI17ti0Gr2ddFiC1OLIr0deJ8ffQCmvxB03tzq3Mi8dq8osL6PuP0SLjma0maE5Y61Kkd1FXcxCGtxIvhfZrL1+0EXH5WovBi1x3NV+QscMlFi1cirIvlnNsFRF2EWcbRNXN3Vt7HWkyN64qgMDjO2p/FdYTIzUzndHKxnySRKbLiq2u61088di41+v5QeTryUiWE4IINckGx+4Mi0qiQkX3XqlTdxJCcGOroS78FIYYNFiY8SJM1Jo/JChf8YGMkIaKzk/wiM/KK+0D3pRu7ldwI9fmWS+aUHdC9MURPnD3a/AwQJJdxrswjydQiuJHgZfOYHbjRkkONou15t+cMDhYW6+f2Wm/NIe/q89jkkD8o/yLkNO0EqDoWDmxd06naO/APKQrh4o1f5JyXjIV7OnbUZMkE+liioGVz9zEY9KdicBtEZAoTd+2FDmOy0gHZw37jrgQFoDEP1TDc3Fh+T+kyjvey74Jg/Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fda850dd-b24a-4563-4eb6-08dc7b633195
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 May 2024 20:01:54.5237
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9QRhk5ZKrUpD3MUqpgUV5+SlnmFWOSS5Ws2w2W/RYRozRsA9mE5LzUS4Hhon6jewfdvYshmb5rnRJzmvYoxB8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6149
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-23_11,2024-05-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405230138
X-Proofpoint-ORIG-GUID: f4BWqgr6GTnX8Xa2qbNGvtizObR-nNiM
X-Proofpoint-GUID: f4BWqgr6GTnX8Xa2qbNGvtizObR-nNiM

On 5/22/2024 8:02 PM, Miaohe Lin wrote:

> On 2024/5/22 7:54, Jane Chu wrote:
>> While handling hwpoison in a THP page, it is possible that
>> try_to_split_thp_page() fails. For example, when the THP page has
>> been RDMA pinned. At this point, the kernel cannot isolate the
>> poisoned THP page, all it could do is to send a SIGBUS to the user
>> process with meaningful payload to give user-level recovery a chance.
>>
> Thanks for your patch.
>
>> Signed-off-by: Jane Chu <jane.chu@oracle.com>
>> ---
>>   mm/memory-failure.c | 35 ++++++++++++++++++++++++++++++-----
>>   1 file changed, 30 insertions(+), 5 deletions(-)
>>
>> diff --git a/mm/memory-failure.c b/mm/memory-failure.c
>> index 794196951a04..a14d56e66902 100644
>> --- a/mm/memory-failure.c
>> +++ b/mm/memory-failure.c
>> @@ -1706,7 +1706,12 @@ static int identify_page_state(unsigned long pfn, struct page *p,
>>   	return page_action(ps, p, pfn);
>>   }
>>   
>> -static int try_to_split_thp_page(struct page *page)
>> +/*
>> + * When 'release' is 'false', it means that if thp split has failed,
>> + * there is still more to do, hence the page refcount we took earlier
>> + * is still needed.
>> + */
>> +static int try_to_split_thp_page(struct page *page, bool release)
>>   {
>>   	int ret;
>>   
>> @@ -1714,7 +1719,7 @@ static int try_to_split_thp_page(struct page *page)
>>   	ret = split_huge_page(page);
>>   	unlock_page(page);
>>   
>> -	if (unlikely(ret))
>> +	if (ret && release)
>>   		put_page(page);
> Is "unlikely" still needed?
I'd say not, because this code is not on performance sensitive code path.
>>   
>>   	return ret;
>> @@ -2187,6 +2192,24 @@ static int memory_failure_dev_pagemap(unsigned long pfn, int flags,
>>   	return rc;
>>   }
>>   
>> +/*
>> + * The calling condition is as such: thp split failed, page might have
>> + * been RDMA pinned, not much can be done for recovery.
>> + * But a SIGBUS should be delivered with vaddr provided so that the user
>> + * application has a chance to recover. Also, application processes'
>> + * election for MCE early killed will be honored.
>> + */
>> +static int kill_procs_now(struct page *p, unsigned long pfn, int flags,
>> +				struct folio *folio)
>> +{
>> +	LIST_HEAD(tokill);
>> +
>> +	collect_procs(folio, p, &tokill, flags & MF_ACTION_REQUIRED);
>> +	kill_procs(&tokill, true, pfn, flags);
>> +
>> +	return -EHWPOISON;
>> +}
>> +
>>   /**
>>    * memory_failure - Handle memory failure of a page.
>>    * @pfn: Page Number of the corrupted page
>> @@ -2328,8 +2351,10 @@ int memory_failure(unsigned long pfn, int flags)
>>   		 * page is a valid handlable page.
>>   		 */
>>   		folio_set_has_hwpoisoned(folio);
>> -		if (try_to_split_thp_page(p) < 0) {
>> -			res = action_result(pfn, MF_MSG_UNSPLIT_THP, MF_IGNORED);
>> +		if (try_to_split_thp_page(p, false) < 0) {
>> +			res = kill_procs_now(p, pfn, flags, folio);
> No strong opinion but we might remove the return value of kill_procs_now as
> it always return -EHWPOISON? We could simply set res to -EHWPOISON here.
I like that, will change.
>
> Besides from above possible nits, this patch looks good to me.
> Acked-by: Miaohe Lin <linmiaohe@huawei.com>
> Thanks.

Thank!

-jane

> .
>

