Return-Path: <linux-kernel+bounces-437491-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 337D89E9405
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:30:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D8F166165
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 12:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9AF223710;
	Mon,  9 Dec 2024 12:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="N3MISC1m";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Noc1wwuW"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618D7224894
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733747416; cv=fail; b=bEoTdtfOmRGxVKIU4YUBXRnms5oZTBzvkssY09vtWs42uYM88yl9Oc20EHpnRB1VbVdAlN7nqxQWwHcusmnwZot0OvBo1JN44zcgP8rpnACRi55bi8JEWvb68sfbjq5ssFBV5rG51wLgPTqx4Lf0n8VVjPgKEuQxerP6q7m6Ehw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733747416; c=relaxed/simple;
	bh=Ie9vGUr7msUmDO6iNDp8HkFyQiM2DiR5SwrubGCNLCU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=ViZ7BWWLWwC4iJ9igxOAuJyYZkClXw0HJvpQh+waK55AmBURG/B3myoC+fKnUPzxdhs/YrFldo4bWOE7pZKEddapOMDTnMYoR7dOUCXtfNwNiFJNlOw6coUiQ5Iy6bfN7WO5/6WXlVq7g5HqVGPJn6eu+qlqYyzJCtjC0zhD6QY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=N3MISC1m; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Noc1wwuW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B98fuNM000348;
	Mon, 9 Dec 2024 12:30:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:subject:to; s=corp-2023-11-20; bh=Ie9vGUr7msUmDO6iNDp8HkFyQiM2D
	iR5SwrubGCNLCU=; b=N3MISC1m42ur2NjvI3ENwaI3KWjsmRduqlXnSU/lpkiKo
	biLRBDD0P/TfmYIbLOUzSNF8eTvMHKq5wsCi9mT+Tt6C6UzKt9B401IiicOyg/TC
	w29S+Y4LFHT4YE91+NyY+rb80dJghbdQruOAmMCBrMEW7tPmBEVxWptcKspj2eWl
	RePRtJB2AOTI0VowYs8b5m8HW9mESszRro+jV/huLPL5cLq3wyDNjB+OUTa/3nL/
	IoPUOl13Fz68t2cMo+zVubjHGggwn7j6exJFtvQSUQJwxU8GAFqyvb8WYVMVQ5Rs
	mInYcE7k5Aa57fwi+mLJ7mVj4wekosoBNkhvyDxdA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cd9ak454-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 12:30:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9CLjD8019205;
	Mon, 9 Dec 2024 12:30:11 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2047.outbound.protection.outlook.com [104.47.70.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct770by-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 12:30:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=obuOBTTxpcjNFJjDtw/qaxoe+31Oap2aQtZMV2rWJHHVfrZ3WhicnU3W/206tnGct9cfw5gn3ppwVXkJsMRUBTHxDkFPpO8agIU2TVXvqYqmGwHetbTb+N/ipEAr8Aexz4wxOIO0gWQxDbNK0N3CNR7haVOfwjH9ZIslAiE4uY9EPwY70Nzq6pRiwMlAJlq0ayZSvxc3Zd0UDqrMuPg7pTJ/KPGO0Ez3V0FRAK1VKIdqmLQkaKYgbTQL1noToAL+wrUNrJ/zjpMAFvE044yGeX+CW2YCcpzKPwZwPBX6wkUNgZBIwqlnaHqH7hOGt2HyM1tsFponrGTmY2taxboBng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ie9vGUr7msUmDO6iNDp8HkFyQiM2DiR5SwrubGCNLCU=;
 b=KFwnRNalRw7nTPERnWpabXinPGIjvlvj0rze4frSHQFhmhJD/b4+3jdaAgRuO737k9l7LNXE7U4fh9UyX9IK8AADGco4CJ7dToGH/c4KyHhOKwFsPrr64eGIARttjWKyzbP9AxBKQpRddG5Zpgyqs8T6u9oGdb7mhtKRQ8SGVY19g5NFaQXBkt43Micrx+UjVYER9BdWG9PABSrguscIaFlbT0fKWQK29WiUmsPV7cIl/dvTMnYMAeGMWwLcE8/n0Q6Jog2wf/MsE6llGPid78bH7A3w2JXxTjDYCL5bq5hVCGJY4t2ersNgigamz6mL7VUOaDrGnj2B6l9V/Vql0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ie9vGUr7msUmDO6iNDp8HkFyQiM2DiR5SwrubGCNLCU=;
 b=Noc1wwuWksnywy2fQY9zC9bGt30SKuOkauepzjPhCIT8wlVQ9mT5Bf2Ev1lz6KkVu5/CR1fk1BT0hlLl1vFC36C3irHybehqWM1I5JQ4Se+Qxi0Ars67e2L4ZsH+CUJurejbt0HuEBrVn0HPkE8IV1KqK8r2MgSuZSFcaLrIOUo=
Received: from PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
 by MN2PR10MB4399.namprd10.prod.outlook.com (2603:10b6:208:1d9::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 12:30:08 +0000
Received: from PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240]) by PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240%6]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 12:30:08 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: CVE-2024-49967: ext4: no need to continue when the number of
 entries is 1
Thread-Topic: CVE-2024-49967: ext4: no need to continue when the number of
 entries is 1
Thread-Index: AQHbSjYV3cYxD+6lcUG/wVb2/qTtwg==
Date: Mon, 9 Dec 2024 12:30:08 +0000
Message-ID: <be6117aa16c1a42d9c192e95334a440ac790de11.camel@oracle.com>
In-Reply-To: <2024102133-CVE-2024-49967-a58a@gregkh>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5563:EE_|MN2PR10MB4399:EE_
x-ms-office365-filtering-correlation-id: 90f0cf18-59e5-4827-5117-08dd184d3812
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|10070799003|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?RW9ER25CZUxnTHc0R2p3b2dXVytESUkxOVovTEF2TFR1NFZuVHN6QkM5dWFm?=
 =?utf-8?B?WnhjVnEzNEtqK1lkL2svd2xLRUYyNzB6TU9ackxiaWcwdTlLb2kyZDN3SzJW?=
 =?utf-8?B?T2tabFphMTVDRExtZnloVHNleGRvZ1gyWkVvRERVaVRBcDZsbWJOYXF1bWMv?=
 =?utf-8?B?RlFmR3EveFNkNG90SnBRWm5EWWUraGxzRTA5bUFQK2gySGxXd3BseVAzOWww?=
 =?utf-8?B?dy9nalUyckNpQTFQTkxzWUd5OWtVM0hybjhMWEJuYWljaU1ZWCtVMmRxOERa?=
 =?utf-8?B?dGJRdWxZb0NxcHZUaFdCSmJGR01sdWRzSFo1Z01VMFVPYkFHZitTUkFPSEw1?=
 =?utf-8?B?NG1qclJ4T3hBa1llaG9Tci9jRWZySUlHRE03ckxXR3pVdGIwaUZ6SW9jMXI5?=
 =?utf-8?B?blZLdnBGVC9YRWljZ1NZWEp2ZlczVjgrSUllUEYraGc4YVdnaTY4Wng1YVpr?=
 =?utf-8?B?ci9XWFJ1blRTUFcxSkFMN2tLME1SQitrbnlYSzZDZjdlS0toVi9BdnFwaDVi?=
 =?utf-8?B?eWJxUjJGcERJY0dMV1Awakh4dU1wR295YTgwYnlNZnY0dXY2VTBjeWpaR0wz?=
 =?utf-8?B?SDhKV0RIZzNFRUpMQ0R2WFdKdXVjOUpRdE45bUFIWW50S3ZlekI5RWNaQ1Bj?=
 =?utf-8?B?SFVKSUlMZG5QODFub3lTRmk3SUd3SEdUTUMzZ21KRk5CL21YZXdZeTkrQlEw?=
 =?utf-8?B?U25Vb05zWlJOTElFQ3U3VjJuYTU0Q2tHTUJ5NFVERkFCU0xEU1lnN2tSQ0hE?=
 =?utf-8?B?aTZpYm5wcy9yUnk2ZWJHQW5vTThyRnVNQSt5YkhIOUtCQThWeUVHbUlkMW1v?=
 =?utf-8?B?cGsrNC9ONEJrODFLcHBvQ0ErNlBtVFRPcFNYRHV4NHlaQnN6VkFLL2FabUNR?=
 =?utf-8?B?VEk3U1ordHNWTkVteG5OL1BHeVVYQkVIYUNaWFZpbW1QQ0I2bEp5OSthTW9s?=
 =?utf-8?B?TkpsTUNjOU5rbWhib2FIM1lNZHFBT05TaThodDRJRFpUTU9SUG9rWkt0bmlX?=
 =?utf-8?B?VmZOdkwvbVp0QVVnWTVGd28yVWdsK0ZMOVNKOFVENzlqbm56cTgrdndxSEtG?=
 =?utf-8?B?dndxcjZyOWJ6cW5pMmN2SXExd0ZNT1U1TlhwSGhlL0FaZ3J6dStEYnZMVW1z?=
 =?utf-8?B?WmNWY3NJck5wUlJjMVlIMFAxeHZmR0ZEakFvYmwwQmFBZUtrRlJZNVNQc1gw?=
 =?utf-8?B?YUE4OW9ETmhja21WTVlOMHNvMGREYjBJa1VINlZwUk5KVkdoUEZSSjhkbTZK?=
 =?utf-8?B?dThZWEFZUXA2TmU2S3BneEl6U2paMHRnd214SE1rdVUxRWxIMXhDN1FlWith?=
 =?utf-8?B?b0VwT3BMZTBXRDl3a2JUVlJ0eHVIakdDYjBzTzAwWURtb0tSa01uVXgwRTYz?=
 =?utf-8?B?OUl3SmZ3S2JJdnF4VW50ZFNFL08yejR1NWFObXZLVUw4d0M1d3VxRjNxbzdL?=
 =?utf-8?B?UDMwUDlLQ0xBQ1lOWWZaUG1Kb2RKM3R5U2NjbVF6b0VWR2IzOXNBUFJVdnRY?=
 =?utf-8?B?dTBnZCt1NGxGRm9kOTd6cTVwaUlOMzBBNmxCT05PbXFTQnhMbGxzOXNzd2Nm?=
 =?utf-8?B?Q2ZTOXFZK2VFQkUreUVsTFVzTkcvY0kxLy9RNmtQWEVwa21DNlJ2blkvTXNZ?=
 =?utf-8?B?Q1dWVnVkdVlSRFNUN3NMdUN5Tm1WSzBoS3dVMEp6N0FMWFZDWm0yTzNzLzRh?=
 =?utf-8?B?ZWo0N3E4Um9zL0lJdmlOSEhkYkNoWHpXN01DcnN1NzdBS3FPekVvNmdOUWRV?=
 =?utf-8?B?cmNmNkk1dGRYQVEvQlFTQzQwZXNkbGdsNU52Yzc5MnFiR0ljRmw0a1pvNk85?=
 =?utf-8?B?UWVXU0RBNUxKbHZteWhiR25FWnk5dGljeHJpTFRCYVFoNG16MmM2ZVRBU3lx?=
 =?utf-8?B?RGU5T0o4djhZVHI0TDBISEF2NFJtMWwvNkYyZVdPaFpkYWc1Vy9GdzFDUE56?=
 =?utf-8?Q?GKw8xMbDwMA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(10070799003)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?cHZaWHJhTDVtaXVhU1k5Z2FiTCtqWnM2WnE3c21Nb2xDUllXL3VFWjdiZUpl?=
 =?utf-8?B?QUJhQnlITWZzOWx4TjdDNjY2RDBnZ2tIak8xYndYTUdMWTN2T21aVUxSSHZ2?=
 =?utf-8?B?ZzhHRnJDZkZlTEZ2NzA3elR0UjZVWXp3d3VsT3RDNHFHYXlxbktZK0FKTkVq?=
 =?utf-8?B?aFRWeW02ZzBZeC9CYlVRaXRFQnJtckNuYURKOUdYeXdaRENzQTYxbTBlZDhK?=
 =?utf-8?B?N3JuWURGT25YTHdzWXkyUmNRY1dXM0ZVU0JMeWVNbnk4S1F6cUtqaG9sTHg1?=
 =?utf-8?B?eklXUHJhbUdSWDZhMUc2bVhyZG5uZXN0emlReE90S2RUSDdEUzd1bnFYSmQw?=
 =?utf-8?B?eFVibWdacm8wMjdOaE1rMWgxY1Iybk40UGdaWDNPV0ZPSmRuNXBDSk00VzEv?=
 =?utf-8?B?U2ZvRUpSQjQyMkczZk8rUkxiV3hlUkdOUENXZkNSdldSN0c0eWJVWncvR25u?=
 =?utf-8?B?eWNIYUplWXRJNGc0Y1hNNDRMTlBWV3lNNU9jTEYxRFV6TWhFVElJT2ZncC9u?=
 =?utf-8?B?UW1XWks5U1daN25hVWhGRmxOUFpFM0c5YkVrMzQ1dTNiQzFZL1NVSTBJREVq?=
 =?utf-8?B?L1cwdnBPZkxOUHhYVFdJSzNkMkU0d1lGZGd4ZVhWeFVjUGQwbkVpaHRrZGQr?=
 =?utf-8?B?R1RnOFVlcGlVV1UxMnZsSjkrOXFZNjE0VnlId3FpVEd5Z3hsUGM0TGgvS2tn?=
 =?utf-8?B?eXkvUS9aa3I0TWtRN0ZxNGdZYTh0L3M5bWluTVdFWmdvNVFNNEhYbDU4Tjlr?=
 =?utf-8?B?U0hrbXVyL2xqcHNNYW0zWStFUXdYWjk5M2NxQzFxM2I0ZXNydkdwR2p1TENB?=
 =?utf-8?B?VzhWblVCVkx2L0EzeDIrL0JiWnlFTi8weGJBZDQ0b3BkSHQ5YzJsQWRKdHZI?=
 =?utf-8?B?a0ROYUgvd3p5UVpSZzZsQU9jM0xCSWVCbS8vZEczUi9IY1ZzaE5LV0lGekoz?=
 =?utf-8?B?RUsxNHRRQXQ1N011VWx2RStyaE5jenBnSzJJcjhMS2VFUVRMZUpkaUxycFE5?=
 =?utf-8?B?a2hmNHdRTDdPdU5GUjEzZWl5a2JkaTA3c3l2dHQ4NmJmK3hrTWdvSTVpU2Rj?=
 =?utf-8?B?UkVxcHhrQ3p2UndwRU5KekJ1UnF2WEN6eVh5aGkrRVZ0MHpXZGFHWlprSDVt?=
 =?utf-8?B?bllVL2ZjTTBXQ1YxYk1mamhvQVF6elVQS2IzVWV5Rk53dUVWRVhicm42UlVR?=
 =?utf-8?B?NGk1czlrUGRrNHNxSFIvRXZYYlA2MUp5akZiemVCTnpJRktlSUpzaHRrdkZi?=
 =?utf-8?B?RnpNS0doaTV6Sm4weTh2YmdUNzdRc2VtdGNnb1VLWk1TUi9mbnhiOXF5ZnpL?=
 =?utf-8?B?VUNJUFJiQjBpc0l5eWFQS1lYSkZSNCsvKzR2bHRNN3pzVG9ISmFPTjBHU2Vj?=
 =?utf-8?B?Qzc3OHhhSmVyRkdieGZuLzZmZVRKWCt1a2VlSXM3dzNEdjJ4b2Z5TFd1Sm0x?=
 =?utf-8?B?eC9jTHR0TnYrSExsVXZsWm83NE45ME5ISDdhSWV5ZVNkUGpVQjRZb0JtaSs2?=
 =?utf-8?B?WFV4QUZKSndCMVk4KzhlQVh6RSszZU1Rd21CR2FBSTNMQ2dWQVlNMzUvenY2?=
 =?utf-8?B?RmdjWGJYemt2RURqSStZOU9wbXNTMitLTVVoSVJUWSs1SVRkR3RISC9WRnJN?=
 =?utf-8?B?dVNVcDdPMUVKNnJxYWRwT3NjV3ZadS8xZFVyc1R0dGV1N0tlMkxYTEFZdmk4?=
 =?utf-8?B?ZExmbEMwbXYvOXpCazZLKytURUFlSUpYejdlY0RCY1owcEhrdzJJaVFldlJq?=
 =?utf-8?B?cVV5Vk5uV0hubmozVDJNZ1Q4OThuU1VhQWl6TCtyZ1AydzQ1cHRKNUUvOEZH?=
 =?utf-8?B?Y09kMllFWGNHZEdBcWF1NHZqV1pyQWJ5WDVXckNSTWk2QUJCVHZPUzlUdzFM?=
 =?utf-8?B?OEtHcVM4TXg1UzA2OS9yTGF3Q0JsYWQ0NkV4NHM2ZUcyNHVsNFlvRzFBTndR?=
 =?utf-8?B?Q2lxZGpYU3NSdWVqeHV6OFpYemNESnN0U1JleGNEcXMvbHVNZEF1TXc5VWxj?=
 =?utf-8?B?UUwxMmlhRGRsNGszTnVWT2ozZEJyOUFua0RFSERNS1dCSFlLRVJubCtiVVN2?=
 =?utf-8?B?czdwdis3eEQ0dktjU2g0ZjJqS2ZLZlp1Vnk3OU9yVGR1SDZ6Njh3b1RtcGxQ?=
 =?utf-8?B?TjN0MzhUN0k5Qk8wTk1mWi9xazVrUHFNVGlQanRVbmVDcnhFamVGWlYrTTVC?=
 =?utf-8?Q?qMX/LHH/sEYK2k5hklaixISuZ4NwgWbScAHVU1eG7p6x?=
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-Aj+HjBJg5KswLcOb0pGa"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Z8p9WRw48ctZZoYQWFkO7540+ZYUIzQCPrfcYQnux5MszSaTWBmuRxNeD3WZ69u92vwA9jzx+cd70A25YeDg9j7YAZ/3JiWSKkMMb+VEQiaVgpQ5V9L2Val9gf5TBKa/MpTrp3Od6xW1gfNwZcbivezfPvVm6bRHIBNkA/yI/Kfg6waUvr2jINEFSuDOrm5nl/1/Z6VhrRzGjgtQpDp/EyvUU7zr9wpKLSxcCBi5Yq9p+38NfKtHLN5KI9y9NZpKGF7h7DQhUCI2eRAipjGyteUUuE+bl7Td5Oq4nVSxMVVZ/WLFLY5wzVX3gBDbh2SNmJ6hJZAkdWPQHkDzXDvOmh4GCLZSNERddNtcYk/yhsnXgCgROLZIPe1Xk56DJfD8e2qDnDg7wqVAgHi3FJaV26qyQRsOtMXTjlUXpXJYu74uZYFWXRX2dQhUV1+gWuu3NJgB+ghC7bTm6hURVUCdRruNjJNz9J9MqgYoKA3wJ4N0awuHgb1Dqn2Zz+nJIqLzxioHEAAnogNPinSX7gltxx+AG/UgSz31wBdJpa596w3npXGt8yA6+pF65F0EiDo8aN4m8lVBW73LnMcXU6YNuTjkkR2PrrDElbDdq7wBRxs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90f0cf18-59e5-4827-5117-08dd184d3812
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Dec 2024 12:30:08.8486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yth4AtyHg6+cFP6Z4SmOLva8Yio5eLR+Qr5LDIIiRHm5IIoQb46ZRfQLIKUnpHZJ3RHvUjdUrxJdhdj173HATVQjUzaDe3SfYOdkryFBOgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4399
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_09,2024-12-09_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412090098
X-Proofpoint-GUID: nBdshN4mRrui2o5_4yVB1_dKyuUC5mUz
X-Proofpoint-ORIG-GUID: nBdshN4mRrui2o5_4yVB1_dKyuUC5mUz

--=-Aj+HjBJg5KswLcOb0pGa
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 21 Oct 2024 20:02:55 +0200, Greg Kroah-Hartman wrote:
> In the Linux kernel, the following vulnerability has been resolved:
>=20
> ext4: no need to continue when the number of entries is 1
>=20
> The Linux kernel CVE team has assigned CVE-2024-49967 to this issue.

This seems to fix nothing:

https://lore.kernel.org/all/6ba9afc8-fa95-478c-8ed2-a4ad10b3c520@huawei.com=
/

Thanks,
Siddh

--=-Aj+HjBJg5KswLcOb0pGa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmdW4sAACgkQBwq/MEwk
8ioNrg//eB8qJsYy074aHPHWr0PxqlmcAWDhkTiaBtfClK4QZ67Ahg+DgTcSc8gW
zSAu2DB6/sGvgYfKqzoSLE+72oJVOWggEePBp4ADn7qZlk1aFfER7hGu8rluusyc
7aCUgRThEv3a+EKIQ0UaHPYeNlcilMKyO6zl8wjOafI9rKx8jroutXEg69KJdxj5
8q+gn65XOi4y5U7HgHIdScS4oiUGMLwZ5+SQPo7jArQKR+oVILZ6QOQZs26mV5wN
07mlQKZIcPBilcMZRHaqvc2qjbcwhaWJHrcRfJE2UZKQ1fvJfeUkju35MBFalv9/
fNpRNmWaOUIAz/ksxXqy2WhOwHMjtAKcmlG3Y1adHCjefffj43/TxzYJabatXd8H
kHYVd7o+JILMJuDEoBmfx/vFNeEiMi9G2znvCgLEFWyTLzCJ39xCEkokcCjPxpR/
6VF1jWCap9+TMoUfyPHTdH7TTUjGplpi0ZxI8J/w5NyFlvLsoT+s+PuDM5CoCF6O
W0tX/l6EUaqhJW3/5UcJfuBvsdkTYqfdaleRiyZzh4X4DqRv94HHRUrGoYJd5d6h
f/kQstGqREUgpjAp2mVCnT1nX+wG/qZVdhURf7u0dFlgFw6NutlLP1FrCDrw3fqP
c7ejXfdkX7BiwnqU+0X8NKRrsGeTdySX9xGhajdMQrpAnQSTbyY=
=t5A2
-----END PGP SIGNATURE-----

--=-Aj+HjBJg5KswLcOb0pGa--

