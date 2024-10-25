Return-Path: <linux-kernel+bounces-381369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE2219AFE2D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 11:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 345361F23C7D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 09:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7FC1D2B13;
	Fri, 25 Oct 2024 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kHyZDu6H";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pKPtfeUl"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7D218BB9A
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 09:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729848528; cv=fail; b=EgjAJyXpNHCItNoOo4MAD9JnFoCPcP/Kikffmb8q+N6sIyNoTX+aovsatng2Ko6ctacpiOIc5fL7aqbu0HfW43CUiT0t7Cw0+ZCfNrDIcB8TF04SHgKgu052C6MHqKkbuGnySjUAdT5e+MxpknhtjtnX8JjSE+DLUQ4WJ/vjM0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729848528; c=relaxed/simple;
	bh=WlP3IfP/wdwgH0loR2Icf1NnRaKgXIXXjDy/6dLIk/c=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=lKP3nvuem29SYO3XnCGmlStM15Kh6FJrFqW5LkgP3BKX81YMhgZ9uXiMfLttkL4dbhdVV8hE5GL1J4vm0alTP8/MIJbupAZnD5n9B5RT4EKpoFUfPaVFubS+Y+c9JzwHKOnK/MH+UYQ7POuvBMd46pTiQK7rV6hv66juMeXfZ3s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kHyZDu6H; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pKPtfeUl; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P8BXmu025031;
	Fri, 25 Oct 2024 09:28:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=M7bkI8d98UEAlcwGaq/BHHcZoGoLS4PWU54MAquXhSg=; b=
	kHyZDu6HbViURQ18Zu+z2qUZn83idVl6xYu5d3eBtL+Y99CPcyCDUTiz2Sn3phQi
	uKtbfV7+Dnic5gbBD9lmk0fzPrkLhnFNDu8MrprqNAB09eFkShaiIamKq6ZTfNZ9
	g7By3h8DEg46O/fHD+IWZGz66s73F4U2fQj2YgjCNe2v04U3CUyxwhRyMMWsRcRk
	BCgw9sc5GwcPFHKHht+IfnG2ZzFi44OazOPxQDOITXgr4SPyu3hVOiBll3t608bZ
	5qBOAlCkc8NMAjUbzNj77zKXKag937i7UszDRelAa5OimGAIgQVqvuF07KSvjYP8
	AroBaQm94rtX1vDAzcolvw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c57qmje0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 09:28:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49P70nhZ025346;
	Fri, 25 Oct 2024 09:28:31 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42emhc2una-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 09:28:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kGF+QnmdqZG7zg128wB8p50EJ9ZS2FCyzq92KxHwrB5VXImNPVszdj5HqocBS1DKYuHH76vjtYb9ElpmukYJSjtPEB3I3uL9rSPEmm2e7QiCaTyv4bxWq0PJY4Ve83CTnZzt/nPzlx0Ur3DCuwOfDii/4m92E1eCJYWCtvFfOfo18FKWOeU9Mg1zcm2w8mjIPHBdPXK2eYwRvQxO224APaOS9fWyszRIyLSfXMyaPTZPLznDpHXjTqwmDgVMzcbe26GW7pe5FC/O8Sghtpv8/K3XxVWp/ZC3GCuIh2kd/N1HoJ/BpGaYdb532311TNhQC5CMlRHS3rnW5qn0ynZZUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M7bkI8d98UEAlcwGaq/BHHcZoGoLS4PWU54MAquXhSg=;
 b=rQwun/edQ/DN2ZDkQEGieHvVbuQ9oBn97uzTCw/x2pDqYgylRdKXs+102m/fqoYwV1XbnXKF3Su1W4yOZU+jwhp3PkYoXcqiWbFoCBrwCNlwBBIh0503UG5L3k2GMhgp04blyaNN9a9jxywKLpvKp6HSzAxcxdOsmtSaH62KgzkmIOn/MjHITyGeY1vEAxycwm+uQxDDbDUSlEj7i3lQHncEIOweyDspJnoCCdNiQdNyl+rqGVJ2oIyCj7WRy06z9U+Qf/OT5u9YBiVKRmVldc7VNmkuH4VXt9DuG65Y+ICL7I98MVkkLS+YTAHVLEhtRZBdF5XQadTfOKFP+s2h5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M7bkI8d98UEAlcwGaq/BHHcZoGoLS4PWU54MAquXhSg=;
 b=pKPtfeUly9VxTEHDwJa/7/IYJwhvhXZzUhEnUIzDVhWvwe3f/AJNxQISJDkVPCdl+tBtQq0whoznrDx1V3BGWCXBBftLDP2IWtkucDM68OSLy0NobOa/M+gOuT05XgWAwt+H8oLm9mA2WYDP/JfREaBvy+S5CVv9DrIvzfnT2lA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB8128.namprd10.prod.outlook.com (2603:10b6:8:204::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29; Fri, 25 Oct
 2024 09:28:28 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8093.018; Fri, 25 Oct 2024
 09:28:27 +0000
Message-ID: <9cfe9161-2ada-4fa0-bcdf-822401708fbf@oracle.com>
Date: Fri, 25 Oct 2024 10:28:24 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: workqueue lockup debug
To: Tejun Heo <tj@kernel.org>
Cc: jiangshanlai@gmail.com, mingo@redhat.com, peterz@infradead.org,
        juri.lelli@redhat.com, jack@suse.cz, david@fromorbit.com,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org
References: <70cb224f-a468-40a0-82c7-735c590bdb43@oracle.com>
 <ZxqYT9RfTBebgIIc@slm.duckdns.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZxqYT9RfTBebgIIc@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0009.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: fbfe9ee3-791c-41fb-e44f-08dcf4d761bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEFRT0ZGR0FzaTk0dnhuSERRck50WkNkSHN5RmxRZ0ZCL1FsVk1KUk9jQ09W?=
 =?utf-8?B?TmJPYmh2bml5dUtWL1JvTFFZZTJTalgzNWpIN1RkYkFSZU04L0xVUThyNGhw?=
 =?utf-8?B?ZS9Ud3Nya0pOdklwcDVTWkhQeGxwZ01URlNKREk0MjVQQ3NSc3NPT0tPa1c3?=
 =?utf-8?B?WWl0ZDBXVUNDTExOdWFZQ2t2UGNnb2dSTmFWWmQ5YWk1R1F1RSt0M29ldXRV?=
 =?utf-8?B?alRpODlpVnl2UmlHKzQ5NEdOMjA5OUJ3bzlmSGZaQWNxWXNQNXdYVnJtWkdL?=
 =?utf-8?B?V2ZEV241dmZlTkIvY0lDRmRKeVg2eGtSWDJGMS9pekh1VjlVUCs5MERjejl0?=
 =?utf-8?B?bDMxek5Iczh2U0p2YlBKR3JhOEFHRFJiTEdxWVFNS1YyMWxCL0FhS0FlUmpq?=
 =?utf-8?B?MmdTc2JpZ2ZmNTFDSzJ2NkQycTNpMnNVVGFnRG9IbENYOFdCNGk2bk9zMmhQ?=
 =?utf-8?B?bWtIWXBPM3k0T0MzbW1oRkp0L2ExOGc3bW1rd0l3Qzd1RlpoSmlOV2t6alZ3?=
 =?utf-8?B?R2FVbktzRlgzbHNDVis3c3pua2x1WVRqT0lLN3BTRjlNbHJXdk8ySVN3bUZG?=
 =?utf-8?B?RnJZQjE0aG95RDl3TVFWblhNM21BM3JWVk0wNDJqVU9TcDI5Ym5SdU1EeXRa?=
 =?utf-8?B?TmQzbytobzVWTll0TCtmNG5uMWw4aTJsd01YZ0pZOGY0cGpOSUU3YmRUbzZo?=
 =?utf-8?B?KzN6L0ZzRmM3a1hjOGhsTmlSby9VMWVITEdxUDROa21ZaFlMQTFGNXdWOGRK?=
 =?utf-8?B?cHRqbitHTHVEMFpjTEgrcnAwdmZTeUpFTnZiS2VxVXBYVERaSS92N3hKY29I?=
 =?utf-8?B?dWZhQTRaOWVxbTVObHdEdWZudFVkaGQrd3U3WGxmS3RwdGVHVEk2aTFjWFJO?=
 =?utf-8?B?ZWxqRHpLK1JETWEzVkVoc3RrQ3hLUklPMnB3cjVyL1g0RFR4TW1XRmI1S3pW?=
 =?utf-8?B?bTFJUjY4eUNUNW5aSm42N0tYUWNzMHJCeUNPRmhqMUpXT0dvYVdvV3Jlc3dW?=
 =?utf-8?B?REJXSStTOGpJanB4djQyazZmQVNZc2srUitVVTh0bmJkQ1RNb0JNQjZkNVoz?=
 =?utf-8?B?ZUlRL1NUYkE3RWppcXAyQjRmY0JMK3V3Y1NrRDR5VVpzNUZIaEs2bHlaaDA5?=
 =?utf-8?B?Y3N1VnFpRkZhTlZMcW13TWdDSlord29MSnpwRmFxZ1BvMlBEQVdjRnhOdHBq?=
 =?utf-8?B?ZEJHQkRsVjlleUM1MVZHU2dDQzhwM2h5bXBYU0ZoWEtYWXJwTFlxSWt0Zk9H?=
 =?utf-8?B?RnhEV1ZqZnU1VTBCR1czaDN2WVExdHVIb2FEZ2labzdSZWpPdk0rbUxSWHRN?=
 =?utf-8?B?UzFqV0tBclVWVUV0cDJSbEh3cjNqN2FMWmk0TXQxQUgydExGTVJreXJBOFJY?=
 =?utf-8?B?cnlkTzhVK1pmN2llTE5XUHR4eDlaMGNQMU91bC9lOEtMaEoxWEEzSjdPWmJM?=
 =?utf-8?B?czUrbGlFTHZsc2JXMC9yVGtqVkR1NnNlVWhMUTRRZVRFTzQ0aWxYbGg5dGRa?=
 =?utf-8?B?d0NOMGtPdjdBaHlDMXJCWEVvNGV1QXFGRUNnRUZJZ0ZCMlAwZ1VxQXF3cE9s?=
 =?utf-8?B?M0JKeFpUSVJ5ckJoUGIyMXEwNkFJOThYZjVrcTBhWjVvSytBMUFCS0QzSzFP?=
 =?utf-8?B?Wmw1TTR3YnIzdkJQMzBVQmRVUkJpb2I0V29YeUxadlIxSThJRW84RGlkZS9L?=
 =?utf-8?B?QW1USWNQSWNld1VlcGF0Mjc2a3k2Z1lMNm5xekZ1aEk0TW5lRXhRZytDQTFU?=
 =?utf-8?Q?3OcgOtT9P6PRx5cMbXX/X6aCcoht1/j1XnqPPVT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NmhVUFZqZDdidUprRkRMUGNEMHh2SkxFOWxpVERJeVdmVHdEOSsyZGNmWGth?=
 =?utf-8?B?b2IrOU84ZlE4QUdabWg2ajBTOHJVQWUwODBRZFlHZ3hpTlp6SUN4UkttRDR5?=
 =?utf-8?B?Wm82eGJIN2F6MEJ2M2Y1Y2IvQng2Ry9USHN0ZUVDaXRqU3prZi8yNzBUTlRp?=
 =?utf-8?B?aDdUZ0tnRW0vRlB5S2d1QTduOGQ2U1lUOHkvNlI4WG8zMFN3QXlPYzJSclI0?=
 =?utf-8?B?Z0N2blV0aXZFMnEwcEZvMG5CSXZMTHN6QkNpUzh3ejg0eWJJYWkxdDNyUjRp?=
 =?utf-8?B?NUFKWTdYMTdVWmdCVW5OVktMc3lHaFFPMExwRW5pMjVUK1ROUnlBWUhwdWNx?=
 =?utf-8?B?bmhSaDQ2dlgzUTFPclplUk1XeFo0bkNjYWwxRDNSZ3BJaVZUeTEzMnRaa1Qv?=
 =?utf-8?B?TmR1amZTdjhiZG16MGhVZncxRW5jSE1mT2VxeFRxTTdGUVAvQWR2eUdmMUxn?=
 =?utf-8?B?YTJlTk53alFKL005eE5tK0N4ZW8zN0RPZVBUQUNoNnNIOGZ4WTBxc2ZYSG1x?=
 =?utf-8?B?d0lZSFo1T1I5RUYwamdNTFZPZ0xLN2hMenFXWldobldRMU1yL2c4NWxlTXF6?=
 =?utf-8?B?NHF3NDBXVzBlSTNQSENERHFET0tveWVRcSswNkYvT3d2Sk9RVkRPTWllSWNI?=
 =?utf-8?B?cTR5cEZ4U3hyektwWTZtY292VWFWeExuTHFCMUtBZWdDbUJaT29YdkxZcCtP?=
 =?utf-8?B?V1JwWThIU1RnK0ZKUFpybnpCclVIcWNkRHBaQVNmVzZiRHMzYmlwRzVhZXpZ?=
 =?utf-8?B?YkRWSzVkZ0g4VTQ4YkxkejNaRWJHWVVWUlgxRC9YbGpkQmIrZHhDMjZJMU9O?=
 =?utf-8?B?UjFNdmJyVXk4RW9mSk5kaVhsaWllVGRzcGVGYW8wVDdrVXU1VFpkWmxWOHJz?=
 =?utf-8?B?YzlQZ2lwcXFKUDV1UE5yRTZocXJwK3U3RW8zUWRMMkcvd2Y1OTF0QTdlT2Fn?=
 =?utf-8?B?cmlHR2grdFZHc3BKdnA3T0xGVVFiaFVCbitRTHVQVlFJZnBzYmd2M1FrR0to?=
 =?utf-8?B?cnNlS0hkQ2M3OXNZN0J1TTNVUngzVm15a0p5ajNFK25iQVcwQ3pxMzZXOWlU?=
 =?utf-8?B?SkNXcUduZlp2eXdmMncxcE13NEJXakxuajVkeGpVL3k2ZzU2a3Z3YXF2bDdp?=
 =?utf-8?B?WWtNNnB4bGJhYkE1a0lLR29VSG8zelhtS0ttQ2NYbnpMZjFoZ2E4Tm5qT3J5?=
 =?utf-8?B?QXdOajBKN1QvMEZyVWhyVVJOdjlDcmZWWjVyei9jZ25ST2JMdG9JWU44Q0E2?=
 =?utf-8?B?bmM3QWNLZWZPNlZ6R1I1WlhJQVBZTUdCbnR0NVBFTWVJekVHRTVudHF6Umpu?=
 =?utf-8?B?Sm1nRk1rdU5BUW4veFpZT0gxbHljdmNaTVRkdldTVGcveWFDM0pxbVN0QU5w?=
 =?utf-8?B?bzV6RFVKejJaVmkwVUo2cG0yck8zMmJDc3NtYlQ0aHI5MGEzdkllbEFCcGVr?=
 =?utf-8?B?dG45U1ZjbUh1eTMxR3hQNmdRNkVzamkzNWp2dXFxUVVkd0h1d05PbXZBT21j?=
 =?utf-8?B?cjZDVUtCbzEzajVGOTlLdUExSXFYYnBPM0ZMcmlDREFDSldyQlpHUng1aXRQ?=
 =?utf-8?B?dG14VkUyM2tUNTF5UVlta1k1QkUwYUx3cDY3RUFsUkgwVi9ISXRuOFE5aklv?=
 =?utf-8?B?VTNmUTlva3NXYXpvMDgyTmJBSXVTVEorekVuVFZ2YjNDeHNlYi9oRDNvUEph?=
 =?utf-8?B?Mk5YUkpsNGI4dS84Mk1CY2s2dVRKOVo2SWpwY09Ec0dxbzlZbnp3dWRIT09i?=
 =?utf-8?B?RWtyYnNWNkxPQVVHZm1WVVAxYnErZnVhNTVVQmUwWmNTQk1QaDhyZTlSeXNM?=
 =?utf-8?B?YzVLSlhGWmRoNDhpa3cvMGlSVGxvMHNRWm1tOWFBOUZrSFRoK0djUmFoQ1Fv?=
 =?utf-8?B?QVRPRUZxSlBNcWpEYWVUNHRnVG5MR3pSWE9KbDh3N0tMVGo3UVROblNVeFlT?=
 =?utf-8?B?eHIzTHRzdkt0b3gvNnpiQUw4REpEUG9RUVpPenVWbDZFWVgzekpEelJaSDc0?=
 =?utf-8?B?eEJGeDVNUGJQaEh0VnYvSnpmckZveDduc1lVQ3VZTHRhYVRFYUtpU1NVdVpa?=
 =?utf-8?B?N2JkTG1QN0cvYnF2aS9wQUxMVkNITzNmcnVsZjZsaDhjR0pJLzVLb1MwK1Za?=
 =?utf-8?B?NHN5Y09pQXlTTE9oQ0M3MkU3N25jQnJ6WDdUMFNaTzNreGFaRVErcW5jTUcv?=
 =?utf-8?B?WWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QrB0Oy0Iim7AtlUeDoZad//KjbevNdQB0ZCRfZWJncHNTNTjv8nl9s42DKzxyasYAwfjJ7Ud6HffqFEdY/coL+iYjZLGxnjl1GTfF4MlT5Jl8tPr1Zsxwzmw/CpUjXb7mxa/kwhKhZsGIIc4b6Kfq883jEz0iHT/L0xo2b/tUYHAbDuhyPYBYi7QGp/Q2I0UDdADOwRlONiX+gihmDGfx3GSibaWAhODEAPmp70qlsoNcZldcmHrqKtqntlj9TlOZcBuhx610CeKYwITbY2Eye3nq96GZV5TVbmPSu7Ko8OIyQRuzkG5Py+0FlOf+hYIUc864Y0HkNHuSJsy4cSW/F1LdSpYYAYS3+8AS3kxeS+4g7OWkhAp5/Ii32sWTZYl/ENnWcog4xYD+4HUd40jPdRXwxnRKWVR0bCrskKyxehn5Qy6sgXsIfXPhpIjdCT7LNoW5bzJeFVDUMGLfMDgf0F87Y4UE4f/18qQ4LLI8cWg0HmqnaKdvCLMvG6uL21wcDVQg2KD/0RUOZ3/xYSK/Ra536W+vCSfRT+pRiNwHZlps+FteNobIPXfMaDX6u5djxQ9BMrujD9lhbAaKmlzCgRDyPqa7jhneEvTsY4baLU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fbfe9ee3-791c-41fb-e44f-08dcf4d761bc
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 09:28:27.8072
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vjpyb9sn+N6V/xy/WB/fSlIou4CY+U7j1xEsWM7BusDBmZahcA1KdLtcPFnsFL+Ljq9LkypcYsh+LD86H1xt1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8128
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_06,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250073
X-Proofpoint-ORIG-GUID: _h6OCaW4S430Ur0X1FTNpdiYvBV8AD5o
X-Proofpoint-GUID: _h6OCaW4S430Ur0X1FTNpdiYvBV8AD5o

On 24/10/2024 19:56, Tejun Heo wrote:

Hi Tejun,

> 
> On Thu, Oct 24, 2024 at 04:49:40PM +0100, John Garry wrote:
>> Hi workqueue and scheduler maintainers,
>>
>> As reported in https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/df9db1ce-17d9-49f1-ab6d-7ed9a4f1f9c0@oracle.com/T/*m506b9edb1340cdddd87c6d14d20222ca8d7e8796__;Iw!!ACWV5N9M2RV99hQ!Jn5gFi_KIzLb-7uCOvHRIcf9Zd4RyHCTnm15Lo8u0KsgaMmwEPZHH2m4l-w4Fr-b6aRICoRWb5DU$ ,
>> I am experiencing a workqueue lockup for v6.12-rcX.
>>
>> At the point it occurs, the system becomes unresponsive and I cannot bring
>> it back to life.
>>
>> Enabling /proc/sys/kernel/softlockup_all_cpu_backtrace does not give
>> anything extra in the way of debug. All I get is something like this:
>>
>> Message from syslogd@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 at
>> Oct 24 15:34:02 ...
>>   kernel:watchdog: BUG: soft lockup - CPU#29 stuck for 22s! [mysqld:14352]
>>
>> Message from syslogd@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 at
>> Oct 24 15:34:02 ...
>>   kernel:BUG: workqueue lockup - pool cpus=4 node=0 flags=0x0 nice=0 stuck
>> for 30s!
>>
>> Message from syslogd@jgarry-atomic-write-exp-e4-8-instance-20231214-1221 at
>> Oct 24 15:34:02 ...
>>   kernel:BUG: workqueue lockup - pool cpus=31 node=0 flags=0x0 nice=0 stuck
>> for 49s!
>> ^C
>>
>> Can you advise on a robust method to get some debug from this system?
>>
>> Maybe this is a scheduler issue, as Dave mentioned in that same thread.
> 
> So, while the symptom *could* be a workqueue bug, wq lockups are usually
> more a side-effect of some other problem.

Sure

> All that wq is saying is that some
> work item hasn't made forward progress for too long. Given that there are
> soft lockup messages, which can't be caused by wq lockups but can definitely
> trigger wq lockups, I'd start with debugging what's happening with the CPU
> that triggered soft lockup. 

ok

> Soft lockups are nice in that they're
> synchronous failures, so probably start with the backtrace?
> 

I'm not getting any backtrace, which is not helping the issue.

But I'll continue to look.

Thanks,
John


