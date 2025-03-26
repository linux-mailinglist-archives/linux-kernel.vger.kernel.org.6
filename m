Return-Path: <linux-kernel+bounces-577043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A19CA717A0
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 14:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBAFD174BE2
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 13:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D95B1E98EC;
	Wed, 26 Mar 2025 13:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dwIpa3yp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t/iQtqBm"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F0A1DED5F
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 13:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742996199; cv=fail; b=mqFtGGLCZ9E/pqJWV3fl8+ds1BchX1clKbvyXJWYij+nKbvxpLqMJmQ7mytFivwqp1AAqbWvXS03//LLHj37yvGzgav/I1QAHZxfarX/s0a3eQWQkhBiVmqxVFRY+8yu7lDZWtswjgFI+/XUJalub0gHRLKk6DHxVOkYYm0rZgg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742996199; c=relaxed/simple;
	bh=9uH7acXwX9y2vkmnb30mJfJlCYb8qeQKAZwYvmjlcyA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=o+Ij/FhUe39kK7cgLIHI/f40vkhnk8A/cvZuKxSWDooZuX/hHwieNbOEYw9q97oUH3rLEksDkKyhB+t2A2r7Pv/NDyOUbaIJZ+3PSD2BSNwA03Ld0zCEZ4SgCPx9z4NbpHwq9pCUgqGD72BmbIRT5mpVHf5BzN2CSfPPNNFpuJE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dwIpa3yp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t/iQtqBm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52QD271Y011575;
	Wed, 26 Mar 2025 13:36:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HJoC2SsE/opfiFcZSXiDVgxdIAw+HFMxCcHwC9o28SA=; b=
	dwIpa3yp8IIBJL7QyYz+UwBh45dGUESanPYknR/oG8Gh/yOTYchujRZd+f4Q5nDe
	AGbhBLdcJdR/Oe3q4KpBR4+Y4593XyI7vKupkARZmIHRAG7Usgfyiwfva6GmaEr2
	RaAWOqsYnRK3+DhUPrX1IGPGY9/99NgSdjHROxaSF08Pg3ykuv2pfZ1yfan5/Y4j
	PszxnxhvI2nCYAjqf2+/aywagOXELEuiCJtBbUqdiWtqSBmeVhnLIO4c9OOprhrg
	15NDc2gBPi+mn9yKPLq+KAC8QO87krKaUHrk0/p8bqUGZVrJxjVjB5Xy2uZicSEt
	9Pg7FF+2Z5FWON/WD1jkYQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45hnrshfw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 13:36:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52QCgpV9028773;
	Wed, 26 Mar 2025 13:36:16 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45jj6txy2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 13:36:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPgFUcgvPOEDoe0UPQZ6gWRlmD9g0dXieQgzeZ5thFZS60FkmPHSHBwsrDpzsU8l9TP7KKkK/ZOuKxQLGT1ajsd50YJgpiV442TjSTHWHOIyJgnHEZiFyOYmYtuAjMh6GlHZzts4n95M/cVtZiOWmwuA8gmVFSOH47POwwNmStlAg+KHqyRAYQHYsuKZhOllMwjVTLZO38C86/pmBJAx9mMXBGXoc1TSBtVFpG35oxM9kf7kgonSEd7WbtF7cZmyoRzt2GXJYPxKgh+Y7FsJ0rYT29OTfA3vFOcQAHVV+7bBRpfc20xueOuovOLTcdIiP9hvcErF0/CZ50X/1QLI4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJoC2SsE/opfiFcZSXiDVgxdIAw+HFMxCcHwC9o28SA=;
 b=h59s/DXQG+ed00V4XLsiUw+5OgLxJTimZDyFrPcTACUMO5qmeVzbM8R2w7mv0H6lzDOWNwEjUvhInmGhhbcbrD9grd3gnVghZk+uVfgB7KICwUl/vstJ+/JXYbx7WNGP6MZ2NLvXW6K1zU3jXx3b9mjSJW7jvbu0dBACbTq1rezv0YLJ4vI5/eOgaWuEuhgkDxPs0D/yx9XEsxsk3GyWcDaaEevGLTF4c6TtLMEG1/1MvW/WuF16T25EB9nvdK7GE2rDW8aTMG4PXXb7bWqJGbgFMM/bRU3mUd6eq7Jd8bY4xhAE//+uVeaA/R2Txzkzr57v9E/QsO646f+Ue26f/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJoC2SsE/opfiFcZSXiDVgxdIAw+HFMxCcHwC9o28SA=;
 b=t/iQtqBm9eYz8pTnJlhIhv6wnWskcOLUOv1lxKe8YQstwl5Yr9AsYCZjAloIUBOpXfAgEkwceub8FJUCx36sS6/D9DjoS7KMp0Ux9qPD9wxFpdOjNFSI+iZAixwmbI7kaUHLPcBDVVWRxyMyIVP3+YHLwArXdYT6js31UWU4HE4=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by SJ5PPFDEBD75B51.namprd10.prod.outlook.com (2603:10b6:a0f:fc02::7d7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 13:36:14 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::187b:b241:398b:50eb%6]) with mapi id 15.20.8534.040; Wed, 26 Mar 2025
 13:36:14 +0000
Message-ID: <160fdd56-d7d2-460c-a142-fa2c8434385c@oracle.com>
Date: Wed, 26 Mar 2025 08:36:12 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: General Protection Fault / KASAN: null-ptr-deref in jfs_ioc_trim
To: Dylan Wolff <wolffd@comp.nus.edu.sg>, Dave Kleikamp <shaggy@kernel.org>
Cc: jfs-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org,
        Jiacheng Xu <stitch@zju.edu.cn>
References: <CAJeEPu++aAiF=ybq+XHEdGad+RsxR8d=tmEe5LxCOnDjWY_OFg@mail.gmail.com>
 <CAJeEPu+0EttQaFYKhGUbn2j=_nLvT-wfdBS0wQjXDkBq962g6g@mail.gmail.com>
 <8548e6ad-c21d-481c-b9c5-bd0403ee26c1@oracle.com>
 <CAJeEPu+AgjJD--boaj79Hp-QKskOm2AMqVwor_k+cwqUg_X2BA@mail.gmail.com>
 <CAJeEPuJt6nhTQM7S=1A==C+5w04R2bWHAYiHgpve-AcL-1u98Q@mail.gmail.com>
Content-Language: en-US
From: Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <CAJeEPuJt6nhTQM7S=1A==C+5w04R2bWHAYiHgpve-AcL-1u98Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR14CA0018.namprd14.prod.outlook.com
 (2603:10b6:610:60::28) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|SJ5PPFDEBD75B51:EE_
X-MS-Office365-Filtering-Correlation-Id: f13abad7-f280-465f-c542-08dd6c6b2dcd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|13003099007|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDVlaFNvTGx0d3NpaGJTQTRmalkvNHlCVlNmbEZuU3lHWXFkRDBVUm91dlJI?=
 =?utf-8?B?d3RlU1pNbzU4bU5rblA0S3YxV1k2cE9lclpvemh1dDZidEMzYVdIajJnWG9U?=
 =?utf-8?B?RHhSdTVnYzg5My93b1NLQ2tKU1hRWVVjU0V5UnowN2wzbk50RitLVGZrOEZo?=
 =?utf-8?B?QXAwM2NTVzJLZ2hwZWVDTFZGMVovY1pNMUt5ZDJDSFdrWlQ3eEh3WlNLWFpR?=
 =?utf-8?B?dG0vRzkyYkQwOWdIVE1MdHppL0lwYlZUeGtDMy8rS2N1Szhla3dIcXNkd0NI?=
 =?utf-8?B?R3FIWWcxY2lWR0hwMmJhZmRTSjNvM0gvV0dBNHUwNkhER05xYVFkZ1N1RTkw?=
 =?utf-8?B?dWFLQjQwZ05yNFREMUh1b1A5bWx6dDZ2YWp6NlFVY0twcGxaZm9vR1VkS1Bz?=
 =?utf-8?B?Q3lEUGdHcE5tc2o3UDRESzV0cWlxMlBGSVJlSkQ2L1BWZGZBdVJDa2Q4Skt3?=
 =?utf-8?B?b1JsUlFnQ3Zjc0xJVkZ2UFh1VDZzT2RueHhKaHVnNWM0WWdGOXB3bG52bmxi?=
 =?utf-8?B?K0ZhQm85dDVhMi9wa3dKYVQ2OXhoR0RPTG04dnRBZXQvenlkZlgxKzU5M2pt?=
 =?utf-8?B?cHdoODhENEI4QUZqS0VGVzFPSDgrbzIrSzI5d0NzeTFyQVJaYzc0VnFBYVBu?=
 =?utf-8?B?M0FvQWVGV2R2OCtUTnNSWVY3cGJneHlGWkVoOWVpZ1JKQk85T1pmVkUwTHBz?=
 =?utf-8?B?eGdwNS9BV1NFcmhGc0ljL3laT0NVaEVLckNCb2dLWFF2SndOQ2VnVEp4bVBv?=
 =?utf-8?B?LzUxaHRtbVM2UXZQTVBLVHlNaXAzYUJpMlVMQTZnK3RQelpnRm81dUk3L3ZB?=
 =?utf-8?B?Tm5EeG0ybWlTOXdSc3BQSHJDMXVkZ2NWMTRMOVVsTU1CZnN4UTdwY1BVOUcz?=
 =?utf-8?B?TUFFTnpyK1UzS3ZRalR3QlZWS2lqRkJCajlyNUx0S25INXcxK0l1YUlGOERr?=
 =?utf-8?B?VkUyWmprbVZ3RE0vKzVuOFhSalFwOEZ5OXNCVW9CeVg2QTNXVWJSeDFmTVox?=
 =?utf-8?B?TjBzQ1RIelUvVFZzVGJBOXVPUStuRXZJSHRoZUdBUGRvL2M1dWczc256VDUy?=
 =?utf-8?B?MVBaRkszaUxTU3YxaElJYy9USXBpc2Z0Z2dMRmxXQktFTy8zUjJ2ekJuVkdu?=
 =?utf-8?B?N29lUUZVY3puTHFqV2YvUGtZYWtLTWsxWDkvVGViTlF5VW5FNWsrb0gzSjA4?=
 =?utf-8?B?U1FOazZhL0NqQWZFang2elV3aWh5ZVBLM0dTZUdMNlBlUXd4OWVobmh3bFRF?=
 =?utf-8?B?RVpsdGVLelNVVUF3cEFyYWVpS0wxSkthSjE5cjBzbzc2WlZQMXhzdXRUblZ6?=
 =?utf-8?B?NmVqaWZLanRHVGcwMlA3azZxOExaeGhuSlcxWm90TGN0YS9yR3FjUlBHRm1O?=
 =?utf-8?B?NDhkeGNZaVlJTHZTWWNOZUVmWlVZTnI0Zk12WE42NDZSM08vc0VmSEQwWkRr?=
 =?utf-8?B?ZzZVQlNzYUg5UmZvS0Zzd0JqUmRFMlRNeHpvd05yZDJvbjhwK1UzSEtGSXVO?=
 =?utf-8?B?Z05EZHNsdFo4Rk4rT0pybFpDbG5MdFFPNndybkx5cUp4K1JVYWpVMHQybHA0?=
 =?utf-8?B?Q09Mb1J4Mm9GMzRhOVR2Qi8rWGZkUUsxZmQ4alQwQjdiK251L1g2RE9IcS8w?=
 =?utf-8?B?MGYwY2xPZkJtTVVQZExQVG16bEpQbzdtdW9MdkhqSm9UdlNvaWpZUjNjeEF3?=
 =?utf-8?B?OGI5UnYrUFNVckpzbjM2VVlwVnFyS2xHUXpLd2hpNnNueTdXbXBMVjROcmdI?=
 =?utf-8?B?SVRKZWQ0UnBmeWVCL0xXUFlGNnNIaVNuWHhET2pISTd3RUZMYWprSjhxdU1Y?=
 =?utf-8?B?NlFYT1g1RXFCN3RxNHlQUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(13003099007)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aHZYb004MTcrY29xWERNUndHbm9NSUxNQnd5ck5pbHJDNEVNd3U0SVp6ZGFI?=
 =?utf-8?B?ZUVNUEV3MlBWU0wwSWFUbVdDelpFWVo3RE1YV2poenhXVnA1THVhTWxMMCty?=
 =?utf-8?B?N1BRSFNDb0VZenJMRGV3RlpwUTNxRVNIYzVQeFNNWE4vOFVJam1tZGFOSEEx?=
 =?utf-8?B?SnZ4TWtlQ2drdGlnSkN4WTJvczF4bm5NRVk0TXJOY2VLYXNJaXNyUDRMa1VW?=
 =?utf-8?B?Q2dSeHdoa0N2a2FLVU5KRkdRUnJjL3pmTjdESXZDSVA4MVU0ZVRWZlEvUEth?=
 =?utf-8?B?eDR2MmREbjIxd3dXWXR0a2J4SFM1MFY5V2k4SXNkZGQxb2gxUDFxNGkvOW1D?=
 =?utf-8?B?TmtlbCsvUXNZK3JxbzB0WHoyUUpObDEyb1ZKRXBIN2VxcGxSMWlIdXRoamxG?=
 =?utf-8?B?TmkrbEwwVlhhV2RScVI1ekZqTGluRDNHV2k0a0hkaWErdUtBZk5PRThqQThv?=
 =?utf-8?B?SVh6RTBQcGxYN2dhcXdtbXdDSzZQRjhSOG1JRllKTHY5dmZ6YnpGV2Zzb3o1?=
 =?utf-8?B?R3A2MisvMGc1QWpSdExZbjIzSmJjRm1kL0FXdUV2alR0T2poMWpkMkhOSnhM?=
 =?utf-8?B?YzAvcEZyNDcraVFZKzJJYmVnRHlGQXk3ejI1S0xxcmxVVDJmaEdZR045R093?=
 =?utf-8?B?N2NQOGZVTEQxTGpoT2JkSXcvanI4MmJyeE56azdDa2hnK2twYjYrdjhUcFRy?=
 =?utf-8?B?TXBOY1NsQ2V5N0xlMVJDZDdKamluMzliNmdsK1ViRUVpYmVMNDk1NVBZS0Nl?=
 =?utf-8?B?WHVpc0dPeXpHM2lGRThhUWVqekwyUTRpK0NwbFpDeXdNVUNFb1RicnpzS2NP?=
 =?utf-8?B?UFNIT1RiZzdiLzdBdFhCYklNU0E3RUZWQXFleTRwVG9HWTdyTXRJV3VwUWJ3?=
 =?utf-8?B?YnM4Lzk3dlFjelM2RmdZK0VvcVF2eVlCMndnSnJYZUl4bzRFaHN2UFB4S0Vz?=
 =?utf-8?B?MFpzN21vMEN4WmhRb1NLeHlMaDRpaXBpS3RVdDZRRU5hZGZHcW40MklNMy9C?=
 =?utf-8?B?UHlyMHZidXNaNHdZSE05bVQ3bGhwUXUzWi9EUTZSZGo0QSt0cjVlMzBSVjlp?=
 =?utf-8?B?NUcwbE1oTGZZN3JiT0hTR1NNc3RrVkI2dVE2Z1BZSE9VT1VEckdUV0dMalpy?=
 =?utf-8?B?Y2ZpSFArbEhsamxuT3F4cktRam9CbTZEZXpNbnhmY2l5dE9wS0JRd0tReTdU?=
 =?utf-8?B?dmZ3VU13a2NuaVYxNS8wbGM5MFoxLzltYU5yUHcxTTZnY3BnRWd6RDNHa01m?=
 =?utf-8?B?aGNrdXgrWUN1Ly85eUp1OVBrdjRQdzhvMm1xaTZTbXh4dDc1bU9DOVFvcWhK?=
 =?utf-8?B?UEQxUGJMSzkvUHp6Q0w0dTRya3JhQ1k2S2FHeSs2M3psK0o1aW12eHVjRXhl?=
 =?utf-8?B?Z3ZKSmxXR2svcUxEYU5NOFYyM0ZiZWVNSDU1bnRPUThsWVJpalBnUkxTY2RZ?=
 =?utf-8?B?YlZzL0NhZGsySjlBR0tZcWhUd2tPcTVUM3dGMitaY0tGeTJzdnlXTXlMNmlh?=
 =?utf-8?B?aXFqanZ1RjF4S0owSDNHU2JFQWdqcy9JSG5Jd1RNYnUyRVJZbXczeTNQYVVn?=
 =?utf-8?B?L3B5Yk9vUVNOcEZaaGFyODhSMjlJZ21zVVpzOEJET3B5U2hLRlNuNWVGSEdi?=
 =?utf-8?B?eGFrS0tDR2lRc3NSdGExWTVjZHNnMGlsV1BrMkpCUGFkR2pOaTh6TXg5L1pG?=
 =?utf-8?B?Z2NaK1JDbXFNOEt0M0xwRE5lbjhPVnVLb215UmJPTjdOZk1lMU83R2M0a2tw?=
 =?utf-8?B?WUFOODBjR1FQOGp5VVFvUjZPMlV3Znd2dGtES0ZtSEg5VXRBdFhEUjVYUGRR?=
 =?utf-8?B?cSs1ajJMbkplenlJeGRyU2t1cmhtM2VIVkp0SjFGcnBkUTZRcHZ3Nm5IUlBy?=
 =?utf-8?B?b21aQ0dBdmcrV1JTRHZ3NlBIU2dacW9YT2FGL2dKQTc3ejFPNE9oUnMrVHNr?=
 =?utf-8?B?Y1dOOStBeTROSWkvNlhzSFFMdThXcFZGUllVTzNPNjdpcmZZcWFDZjk5Q0RP?=
 =?utf-8?B?UXdoWGhqekRCNncrQUtqRWxhV0JWa1QzVktLRWlWVWVZMmZVbVpETnU1Z1la?=
 =?utf-8?B?djdCTkw3OHN0NFNramM5UkR5cEZHTGdZaGt3WWUyeFNSdXBCMUpxQVk4NHkw?=
 =?utf-8?B?a2dVcjRaS2ZlTWk4cElpOFRtTWVFSms5dkNUYVBmMW1FUjU3NU1TdndPK1F4?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BWuE+0xSIXWXvm7Hn7HmNlhF3ptGUP0NqtxZJhaLyQB4JIHUfGP9NTXMaKqwPo3IW2GeM4Yvad0eAZMSL3aObJ/p8rN6gm0k0jP+AhnyyBzQJcsKuSTmc7rDbPtk6k5h23YW7d8tfd/7AA0YD9aF7ayr9d2SbP1METjYgmXxF5Lv8t/+3HfWgCskwvBUvUYLVdR3q059uMMWDg1RkPZYX9eKjbL+PECEc5SBUYWJOEuS1x41E27Ohq3dcfWdGdeB/Lb8+CJfI5YmA8AjyKQhbyYttkTf4LpiR0HJib2mhBtlkNrUyM7q+ra5p9rAw/9amqUGUgQbd1lPXAdGnlCTAHSAnEmdsyuL7sXFT6h2aNA022TbeOHj2InWKqBqbLieiISnTXvSR9tKoX8c1Dd3qP4Iu7rkmZ4nOu+Ap1iITfjriR7EzEm5FdVgTjzuT909HNjs5Aary9edjuUuzsBWPLn1ALMVLI3pdjY2PrLjA6IvLIeMtIhOaptU26wO5bwetZUY5laU6IybrrRoIfuFzrP+Mj5ScpwoktqIKbkR0T0jlDKhP7caDc5uPlp+yxgwrxwaqsfpzhOZxLat8KYV9NM6EOhN6I1qJ5JHhWYHmB8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f13abad7-f280-465f-c542-08dd6c6b2dcd
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2025 13:36:14.3975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9MS6PBeasGl+0W7t+r9sGofxzFGV67v2cImGPpg5Llk+2IMOHQ+CxhFZ8cbrHWtp9vGdCNRD94+E5Opo6wDpeM5+6kWyv1LbfXFhjHEwMDw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPFDEBD75B51
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-26_06,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503260083
X-Proofpoint-GUID: XOJ72ds6lBH-CKWdsKCRwB0lk-b9wqll
X-Proofpoint-ORIG-GUID: XOJ72ds6lBH-CKWdsKCRwB0lk-b9wqll

On 3/25/25 9:23PM, Dylan Wolff wrote:
> Hey Shaggy,
> 
> Just following up -- is there anything else you need from me on this?

No. I've just gotten behind. I'll try to take care of this shortly.

> 
> Best,
> Dylan
> 
> On Wed, Mar 12, 2025 at 4:02 PM Dylan Wolff <wolffd@comp.nus.edu.sg 
> <mailto:wolffd@comp.nus.edu.sg>> wrote:
> 
>     Thanks Shaggy!
> 
>     I've included a summary with sign-off below. Let me know if I am
>     missing anything else!
> 
>     Also, we aren't sure if there are security implications for this
>     issue. Is it possible that induced load could result in Denial of
>     Service? Could you comment on whether we should initiate the process
>     for a CVE?

I don't think a CVE is necessary. If anyone uses JFS in a critical 
environment, it's news to me.

Shaggy

> 
>     Thanks!
>     Dylan
> 
>     ```
>     [ Syzkaller Report ]
> 
>     Oops: general protection fault, probably for non-canonical address
>     0xdffffc0000000087: 0000 [#1
>     KASAN: null-ptr-deref in range [0x0000000000000438-0x000000000000043f]
>     CPU: 2 UID: 0 PID: 10614 Comm: syz-executor.0 Not tainted
>     6.13.0-rc6-gfbfd64d25c7a-dirty #1
>     Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1
>     04/01/2014
>     Sched_ext: serialise (enabled+all), task: runnable_at=-30ms
>     RIP: 0010:jfs_ioc_trim+0x34b/0x8f0
>     Code: e7 e8 59 a4 87 fe 4d 8b 24 24 4d 8d bc 24 38 04 00 00 48 8d 93
>     90 82 fe ff 4c 89 ff 31 f6
>     RSP: 0018:ffffc900055f7cd0 EFLAGS: 00010206
>     RAX: 0000000000000087 RBX: 00005866a9e67ff8 RCX: 000000000000000a
>     RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000000000001
>     RBP: dffffc0000000000 R08: ffff88807c180003 R09: 1ffff1100f830000
>     R10: dffffc0000000000 R11: ffffed100f830001 R12: 0000000000000000
>     R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000438
>     FS:  00007fe520225640(0000) GS:ffff8880b7e80000(0000)
>     knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: 00005593c91b2c88 CR3: 000000014927c000 CR4: 00000000000006f0
>     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>     Call Trace:
>     <TASK>
>     ? __die_body+0x61/0xb0
>     ? die_addr+0xb1/0xe0
>     ? exc_general_protection+0x333/0x510
>     ? asm_exc_general_protection+0x26/0x30
>     ? jfs_ioc_trim+0x34b/0x8f0
>     jfs_ioctl+0x3c8/0x4f0
>     ? __pfx_jfs_ioctl+0x10/0x10
>     ? __pfx_jfs_ioctl+0x10/0x10
>     __se_sys_ioctl+0x269/0x350
>     ? __pfx___se_sys_ioctl+0x10/0x10
>     ? do_syscall_64+0xfb/0x210
>     do_syscall_64+0xee/0x210
>     ? syscall_exit_to_user_mode+0x1e0/0x330
>     entry_SYSCALL_64_after_hwframe+0x77/0x7f
>     RIP: 0033:0x7fe51f4903ad
>     Code: c3 e8 a7 2b 00 00 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 89 f8 48
>     89 f7 48 89 d6 48 89 ca 4d
>     RSP: 002b:00007fe5202250c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
>     RAX: ffffffffffffffda RBX: 00007fe51f5cbf80 RCX: 00007fe51f4903ad
>     RDX: 0000000020000680 RSI: 00000000c0185879 RDI: 0000000000000005
>     RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
>     R10: 0000000000000000 R11: 0000000000000246 R12: 00007fe520225640
>     R13: 000000000000000e R14: 00007fe51f44fca0 R15: 00007fe52021d000
>     </TASK>
>     Modules linked in:
>     ---[ end trace 0000000000000000 ]---
>     RIP: 0010:jfs_ioc_trim+0x34b/0x8f0
>     Code: e7 e8 59 a4 87 fe 4d 8b 24 24 4d 8d bc 24 38 04 00 00 48 8d 93
>     90 82 fe ff 4c 89 ff 31 f6
>     RSP: 0018:ffffc900055f7cd0 EFLAGS: 00010206
>     RAX: 0000000000000087 RBX: 00005866a9e67ff8 RCX: 000000000000000a
>     RDX: 0000000000000001 RSI: 0000000000000004 RDI: 0000000000000001
>     RBP: dffffc0000000000 R08: ffff88807c180003 R09: 1ffff1100f830000
>     R10: dffffc0000000000 R11: ffffed100f830001 R12: 0000000000000000
>     R13: 0000000000000000 R14: 0000000000000001 R15: 0000000000000438
>     FS:  00007fe520225640(0000) GS:ffff8880b7e80000(0000)
>     knlGS:0000000000000000
>     CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     CR2: 00005593c91b2c88 CR3: 000000014927c000 CR4: 00000000000006f0
>     DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
>     DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
>     Kernel panic - not syncing: Fatal exception
> 
>     [ Analysis ]
> 
>     We believe that we have found a concurrency bug in the `fs/jfs` module
>     that results in a null pointer dereference. There is a closely related
>     issue which has been fixed:
> 
>     https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
>     commit/?id=d6c1b3599b2feb5c7291f5ac3a36e5fa7cedb234 <https://
>     git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?
>     id=d6c1b3599b2feb5c7291f5ac3a36e5fa7cedb234>
> 
>     ... but, unfortunately, the accepted patch appears to still be
>     susceptible to a null pointer dereference under some interleavings.
> 
>     To trigger the bug, we think that `JFS_SBI(ipbmap->i_sb)->bmap` is set
>     to NULL in `dbFreeBits` and then dereferenced in `jfs_ioc_trim`. This
>     bug manifests quite rarely under normal circumstances, but is
>     triggereable from a syz-program.
> 
>     Reported-and-tested-by: Dylan J. Wolff<wolffd@comp.nus.edu.sg
>     <mailto:wolffd@comp.nus.edu.sg>>
>     Reported-and-tested-by: Jiacheng Xu <stitch@zju.edu.cn
>     <mailto:stitch@zju.edu.cn>>
>     Signed-off-by: Dylan J. Wolff<wolffd@comp.nus.edu.sg
>     <mailto:wolffd@comp.nus.edu.sg>>
>     Signed-off-by: Jiacheng Xu <stitch@zju.edu.cn
>     <mailto:stitch@zju.edu.cn>>
>     ---
>       fs/jfs/jfs_discard.c | 3 ++-
>       1 file changed, 2 insertions(+), 1 deletions(-)
> 
>     diff --git a/fs/jfs/jfs_discard.c b/fs/jfs/jfs_discard.c
>     index 5f4b30503..4b660296c 100644
>     --- a/fs/jfs/jfs_discard.c
>     +++ b/fs/jfs/jfs_discard.c
>     @@ -86,7 +86,8 @@ int jfs_ioc_trim(struct inode *ip, struct
>     fstrim_range *range)
>              down_read(&sb->s_umount);
>              bmp = JFS_SBI(ip->i_sb)->bmap;
> 
>     -       if (minlen > bmp->db_agsize ||
>     +       if (bmp == NULL ||
>     +           minlen > bmp->db_agsize ||
>                  start >= bmp->db_mapsize ||
>                  range->len < sb->s_blocksize) {
>                      up_read(&sb->s_umount);
>     ```
> 
> 
>     On Tue, Mar 11, 2025 at 11:48 PM Dave Kleikamp
>     <dave.kleikamp@oracle.com <mailto:dave.kleikamp@oracle.com>> wrote:
>      >
>      > On 3/11/25 1:47AM, Dylan Wolff wrote:
>      >
>      > Hi all,
>      >
>      > Just checking in on this report. Is there another email list I
>     should be using for this issue? Can anyone confirm whether or not
>     our fix is acceptable?
>      >
>      > This is the right list. Somehow I missed this one and/or forgot it.
>      >
>      > The patch looks good to me. Can you re-send it with a Signed-off-
>     by: ?
>      >
>      > Thank you!
>      >
>      > Shaggy
>      >
>      >
>      > Thanks again!
>      > Dylan
>      >
>      > On Tue, Jan 7, 2025 at 4:53 PM Dylan Wolff
>     <wolffd@comp.nus.edu.sg <mailto:wolffd@comp.nus.edu.sg>> wrote:
>      >>
>      >> Hello kernel developers!
>      >>
>      >> We believe that we have found a concurrency bug in the `fs/jfs`
>     module that results in a null pointer dereference. There is a
>     closely related issue which has been fixed:
>      >>
>      >> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/
>     linux.git/commit/?id=d6c1b3599b2feb5c7291f5ac3a36e5fa7cedb234
>     <https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
>     commit/?id=d6c1b3599b2feb5c7291f5ac3a36e5fa7cedb234>
>      >>
>      >> ... but, unfortunately, the accepted patch appears to still be
>     susceptible to a null pointer dereference under some interleavings.
>      >>
>      >> To trigger the bug, we think that `JFS_SBI(ipbmap->i_sb)->bmap`
>     is set to NULL in `dbFreeBits` and then dereferenced in
>     `jfs_ioc_trim`. This bug manifests quite rarely under normal
>     circumstances, but is triggereable with the attached syz program.
>     We've also attached a trace of an execution that leads to the crash
>     (thread id:location). If needed, we can share our setup in detail
>     which reproduces the bug with very high probability.
>      >>
>      >> Here's a proposed patch:
>      >>
>      >> ```
>      >> diff --git a/fs/jfs/jfs_discard.c b/fs/jfs/jfs_discard.c
>      >> index 5f4b30503..4b660296c 100644
>      >> --- a/fs/jfs/jfs_discard.c
>      >> +++ b/fs/jfs/jfs_discard.c
>      >> @@ -86,7 +86,8 @@ int jfs_ioc_trim(struct inode *ip, struct
>     fstrim_range *range)
>      >>         down_read(&sb->s_umount);
>      >>         bmp = JFS_SBI(ip->i_sb)->bmap;
>      >>
>      >> -       if (minlen > bmp->db_agsize ||
>      >> +       if (bmp == NULL ||
>      >> +           minlen > bmp->db_agsize ||
>      >>             start >= bmp->db_mapsize ||
>      >>             range->len < sb->s_blocksize) {
>      >>                 up_read(&sb->s_umount);
>      >> ```
>      >>
>      >> Applying this patch to our kernel locally appears to resolve the
>     issue.
>      >>
>      >> If this looks like it might be a security vulnerability, please
>     let us know if there is anything we need to provide for the CVE process.
>      >>
>      >> We would also appreciate attribution for the discovery / fix if
>     applicable:
>      >> >Reported-by: Jiacheng Xu<stitch@zju.edu.cn
>     <mailto:stitch@zju.edu.cn>>,  Dylan Wolff <wolffd@comp.nus.edu.sg
>     <mailto:wolffd@comp.nus.edu.sg>>
>      >>
>      >> Environment:
>      >>      Qemu (invocation attached) running a Syzkaller image on an
>     Ubuntu 22.04.4 LTS host
>      >> Kernel:
>      >>      HEAD commit: fbfd64d25
>      >>      tree: upstream
>      >>      compiler toolchain: clang-17
>      >>
>      >> Thanks!
>      >> Dylan
>      >>
> 


