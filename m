Return-Path: <linux-kernel+bounces-245139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB79F92AEDE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 05:48:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 35C061F21F5E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 03:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01A98487BF;
	Tue,  9 Jul 2024 03:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="kz2ETLDT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eXBgG7ae"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550CA4A0C
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 03:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720496918; cv=fail; b=f36FDEPfv170r64RdLpunuh7hdg61J4GzdoWoMwOKmubOv2iHGEi4kP7lLM2vY7g1ejEokhow6nESURWB7E9P7Xu8kuu/Kh9V3/nKRjnzOj1kGxeL0aIn+a/6r427+aMjbU8HokvtpqWWtxqOUzFdvIPzwlgHUaxiLlH022keog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720496918; c=relaxed/simple;
	bh=xHmSj/fGsuObBU/otCxWd2D753eYwemMvdC0sq8H65w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:Content-Type:
	 MIME-Version; b=K3AXrtEDq1JajxpHeQsmTUV9gQjiUQiBea+sTGwmncLy8sjpAfrh4oWN10MaEkA4cKA0vbyLKBxTWdozJWOntvBBZSuLrDYXjyVlT/hVbi4U7pasP8bCRhTjhxxZgh/I1wKXGQFeqz8wEwG7BNLoHhXRppVSDuCtPiNWcT31yDM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=kz2ETLDT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eXBgG7ae; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 468JfSjs028980;
	Tue, 9 Jul 2024 03:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:content-type
	:mime-version; s=corp-2023-11-20; bh=xHmSj/fGsuObBU/otCxWd2D753e
	YwemMvdC0sq8H65w=; b=kz2ETLDT5pbXqnkpMmvLbk1GRX71Gv45tLRt5w/eMvk
	3bDxTyPq/pkuUc44q2kQBNZ6KYA8kkT2w4sjjdkX6l+RujfT1IYye5cSlA245DUY
	hP49hDwAsYD/HK0nRbBLmeUyx5hOgLuw8zx63YCjRng3oSHEp0b4zgc8FUvP03Rq
	fNU44gAgZea9I7cmy/gRIRmOjoX2b99BAA2uds+kjrRDO2wejD3JthjVwyC5ZgAA
	LkVHIbyLg/ZlVD+S85z9QDCnRsvMZ9qVQFJJZ9RxLcD+9LwC3zKY1Yt/PfE5WA3S
	euh5cgb5cohAPeSwCxo1TX8wijaWrwKryplgJWbje1g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wknm0y8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 03:48:32 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4692cVcn014282;
	Tue, 9 Jul 2024 03:48:32 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2040.outbound.protection.outlook.com [104.47.57.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407txgc5mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 03:48:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZXc67N9qvGsOte9yvf9QbjVqe/eFN7ZyDjtpjGUkWL3RDwjcdvrTxSzJ8EskK4OfMR/qRTRrkSR1eQ2lwLOTqhsK1+7oQb2uoWIkDICyDuIwOcN4R/3JD3r8sBpcWQD7Z13uJ54ZyMVg93nzYYoGFhM5vRUKsb3GtpIIrcRV6yJv5pzLqREOY+ZrE7z7FwwGP/+RJomf4mPvZSyOC/bnvCRA7PxdusIdyEr/n5/3WDirRhlx0lfTxoioC3xNG7iDoYnjwqAI0YEkKYOLlwQgubw6vND5cjgdY8lM23jAwxMDcRY7kdfEv7qX+gibhCC0qnC5it2wPz4qaF7z37HIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHmSj/fGsuObBU/otCxWd2D753eYwemMvdC0sq8H65w=;
 b=aMiSgd+PIJLgUtqnbCwC6M1fThUQSmkOagCrClN0s6sCSGWhn/HWQQiFkzlV5kuXT5JzyPN8NGITmhnCcK56UKfIXWHcK/Ci70aICOdpQdtZQu05oE4k11XPFIb+sfa9zzrDAXnXeUo7O5Amn1sco8TJzHvFDYgrxRYth6aEduzgk53nHxoOn1Wk8XvBzXs2OSwIZKSEvsBOGmhP3SkrnYEsg8MYHe+uzf7EhzMabyfNtugh+m+70UNCm/zDhm4H1WToftW6MzdktU9ql1zUxv7LAkD9MdRThhpKD9M1iYXGPEyEFOJ8BNy9WQCprxnsTyh9EjrgGSnssljjyOXqdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHmSj/fGsuObBU/otCxWd2D753eYwemMvdC0sq8H65w=;
 b=eXBgG7aeiFW/W2/xamHukpDNR/gi7+DRxamefFUNhm52FtsQkEiXpbCEuEgCA5YI9yxJGFOI1vnWirx6wpSxyp7lSa7mp7wxd8kj4bGhQxNFp3soRy+tP8Z9VjpfSybN6WvynWq7AoY8Ab+dZys5PMAV+KSMN9Jx+ZwB0NOZfuo=
Received: from PH0PR10MB5563.namprd10.prod.outlook.com (2603:10b6:510:f2::13)
 by CH3PR10MB7459.namprd10.prod.outlook.com (2603:10b6:610:160::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 03:48:29 +0000
Received: from PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240]) by PH0PR10MB5563.namprd10.prod.outlook.com
 ([fe80::1917:9c45:4a41:240%4]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 03:48:29 +0000
From: Siddh Raman Pant <siddh.raman.pant@oracle.com>
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC: "cve@kernel.org" <cve@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: CVE-2023-52628: netfilter: nftables: exthdr: fix 4-byte stack OOB
 write
Thread-Topic: CVE-2023-52628: netfilter: nftables: exthdr: fix 4-byte stack
 OOB write
Thread-Index: AQHa0bLc1MvUTJZJO0ydj7HfzDsXUg==
Date: Tue, 9 Jul 2024 03:48:29 +0000
Message-ID: <b8b8f6113ac1e7f1fa07659c32d34b033f775a84.camel@oracle.com>
In-Reply-To: <2024032850-CVE-2023-52628-14fb@gregkh>
Accept-Language: en-US, en-IN
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR10MB5563:EE_|CH3PR10MB7459:EE_
x-ms-office365-filtering-correlation-id: 6e46024f-982d-4d8f-021f-08dc9fc9fef1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info: 
 =?utf-8?B?N09LbDgrbHBZVm4rbFBVdnMxNnl0VVpiOE1CZWx2M0RWdEV3SG91ejNzYTda?=
 =?utf-8?B?VTlON0RuaWxqRXB4ZXJPODd2SnpsWWVtSTNIeEZVT3VCNzZwTEJoZDJ6eDJE?=
 =?utf-8?B?bW9WQXIxY1l1RzIwUFB1bTh1dHltK0Rpby9nTXZXdG55T2ZSWUJQRXdKUjJR?=
 =?utf-8?B?WXIrcERUcTdueUluK0tIdUliell2VHBIWkJKWUx4K0V2T3l1elk5RHRoSTdN?=
 =?utf-8?B?aVVGU3B0NXNSc2hSb1gwY2c1d2JmQWhsMVpTem5zd3ZaRDdEQmZKcU0wWlBZ?=
 =?utf-8?B?ZFBoaE14VzM4NytBNDNyUlBZNTErMFJkY3JyeEsyNlMxbUNUYU9MblhnZ29p?=
 =?utf-8?B?QWxjbGp1V0xLNEgyeXZOdnN1a3pyVmdleWlSLzFqWElNUXh6Zm5BbGJiSE9K?=
 =?utf-8?B?SE1JV2tQSFNKR3NQenBpb0hVb1dEWFBXYk1tWW04dmZhS1kxeWp1R01sSWtr?=
 =?utf-8?B?YlhVNW4xdFBScGxMblZ3QTFzeGhhaVJNRnZ2anZYZzc5RndIRVFGVkhuK3JU?=
 =?utf-8?B?UlZ6c2JwMnZJeFZRNFB6KzNpanNJa2xralNxVlNKbHZaenkxWXVVS2N1ZU8r?=
 =?utf-8?B?WmJrWXV3U3ZqYzYralM4cFJwQzZmdXptTENNcTl5amloeTUvS1Y3akgvdnNm?=
 =?utf-8?B?djdWbFlWSHFubVptYVVYeE1KbHBqVWppY1l3WUNqSVZydzJydHlHVEcyWVBt?=
 =?utf-8?B?V0RVNTREYkxVd1grQU1SNVRYcDdSS29vV1RkY3lvdVVZWEpLaVdmVGt4TmQx?=
 =?utf-8?B?S0JxYjgzMTkrWTlFVlRwem5iMXR5TGpqNDRQcm15TjR2L0xJemwyOEY4SHdS?=
 =?utf-8?B?YnhORnFHMmhUUmxmMktFZFgzS0dEeDk1Qk1aMlFKNDQveXBYM01LM1daRXpY?=
 =?utf-8?B?WUxsbmNBcmV0QS85YkIwQjluV3dhUmNXWjdzVWhJNDBBeDU5UFg1bWt3MEFV?=
 =?utf-8?B?U2NUTTRqQU1wb1ZzTzZETTU2K1dqRmJ6aVl1b0xuQXk5eENsblpQczAxbWtE?=
 =?utf-8?B?UCtleU5qUC9kTUU4UWF4VVJ3VHlGTnBFcDJOR1p5U1lOSGJMb2Jwb0U1WHVY?=
 =?utf-8?B?UHdDM0V4Qmw3Mm9La2t5T3JKQXUydmt2NUVuK1lMRnpUSU45ZDdvV0VEVEQ3?=
 =?utf-8?B?amJ3NmY5VFVJVTU5bmhYcDRaQ1BSVUZWUDBCcDMwcnV5ZEFybTF0aUFYWVNh?=
 =?utf-8?B?eFFPOWg5Rklidk9qL1drNXA5czJUQllUVFJlWFk1L2NhcVVYb2M4bndDekJQ?=
 =?utf-8?B?OGhscExXQnQwbTlCVGl1VGJma3RwZTljdnI4WmhpcDl2QUY1OWk4ZFVFMG02?=
 =?utf-8?B?MVhkeFBvdlhQZ0dJcEtWU1A3TEpMc1g5M3RQcmxyNjdhY09hNU5xazJLdVR2?=
 =?utf-8?B?b001ZWl5dm5PU3YrbjUxUTBNVVVDV3M2dEVQakt4bTlCcy9QQU13dmJUbEdX?=
 =?utf-8?B?V3hJQVR6UDREMnNiOVp4N001eG1iemNmVFluS1pUZE9WWTFPWk45SXJxdjhl?=
 =?utf-8?B?V0pvTGNYVFZmSUpmMVhXZEJ3RHJPQTJxMU9mK2pSbzFBSis1WG5BMytzTkoy?=
 =?utf-8?B?Ui9XdzlveW9Gdlc0ODBHM2RRcnBHUWFFOVQ1SlFFRDZGTCt4OHRzZnIwR3ZL?=
 =?utf-8?B?VEFUcnFMK0hheWxhSmhSR3hzYU9DMVNRMnRFam1wV2tlSUNCV3ZnLyt6M2Zn?=
 =?utf-8?B?RXpQZVRNMnRUYlRRMzVEOGhmbWgvU1NpdVJHN3FKVWdoMTQvOHZjYnFQaGJo?=
 =?utf-8?B?K0wzVzVIQjRPT2RPa00rRWpLR21pdlVXcktZN0V3VERzM1ZRWk10ME5jK09k?=
 =?utf-8?B?QXJ0MEZJYXMrdEhVaytnUmkzYU4yTk9RdFljNU1qU0Z3eEFHdThibEdqVmRH?=
 =?utf-8?B?czZUSm8ybEZCVFA0bGFZOGdYY0NyREtuZlVLV1JvcnNVMFE9PQ==?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5563.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?akhoZWttQUdIL0QvYXVSc2x0eWFMczZaZkF6b3g0Y1BIQVN1QW1EdENtU2cw?=
 =?utf-8?B?ampNUmMwV0VWYlZwRFZGSkFPNXZqOE5DczViZmlGZ0tWQ1BaVGFhR0NJMUlN?=
 =?utf-8?B?NEJTNmh6SVdlZzYzWWQxQnYzVURKblBYejhPbzU4dkl3RnIzZFZUNUxBZVRn?=
 =?utf-8?B?SHRDRmpFblpLK25GWkxkSjlsWDhxL0Fsc1hWUW5ibmRpTG1pUzBMcUs4RGhK?=
 =?utf-8?B?MEVjdlZKeUdScXF2QUljSFhHT2tGL0JVRi9RZTJZNGI1TFBwbG5WSExBKzIz?=
 =?utf-8?B?TklaNXhHVHU0eGE0TGE3NStBazIxK2NHU3VWUElDdGNtWTdzTldxeFI2bldz?=
 =?utf-8?B?ejlCemtyK3Z5Y2lYTEIrb2w3Y0tVdXgzRFI5TkF3d3NaYzBBZkMrWkRZVUVF?=
 =?utf-8?B?bzZuc3h6V3U2ckEyTzhudWVjZjZRcTV6aFpNSlNnYmJmMkp4TGlYZXlyU0Rp?=
 =?utf-8?B?WkNDVDNSaC9Ua1JpMDVwbjI1Q1BLMVRDUVJxR0ZLdUIrSGk1T1Z6OC84WWRo?=
 =?utf-8?B?dHRIMGpob1lkZzFWOTF3RmJCYzBBWEYrd2hxME5kWllRUVFNdW5RWE83ZEEv?=
 =?utf-8?B?emNxb3F2ZW03Tys3ckszYnI5UEgzN25ES2xEVjk0UDZBbWIyRWd2K3liVFlE?=
 =?utf-8?B?T2IzamF2Vm5JV2hIcDErQi9udzk4Y245QzRKcXU0VXBFL0RuRTFJNHVNWC9K?=
 =?utf-8?B?aGdrRnkwL3VPd3RjTkRGVnRsdjZHSkhvSFBjUElydFMxbE5OVmxJYnMwWlNB?=
 =?utf-8?B?MENmY3JFVUVRUU5LeEc1bzNnSmM3OGcrd3FQaUxMS3ZTanQ4eCtQWGRtdEtH?=
 =?utf-8?B?SmFGK1FNYm9kUC9QYXBBQ0toM0VoTG01QmVBR2JRdXhCTnROVUxJZHRNTnJG?=
 =?utf-8?B?L0lXa3I0bmdza0libXFmT1NaSHlGMDl5UWZXZ0l3K2p1dVIxN25CZXFJbWdu?=
 =?utf-8?B?OGxmb1g1emdnUEFNK2pZNmRiYjJBR05zN2RvUnFsUGVvUkxMdEtsYlh2SUFQ?=
 =?utf-8?B?STBKSlRNQU5xOGdZNDFzUmwvaFptZVVPV2N2SkNsNzZuYWxOS0U4Rmg0Mnh3?=
 =?utf-8?B?cS9naG5zMUdnb2xJSlNoc1FWM3p2VGMxYk1ZREVTTXZCdDRranVNaytSTEhU?=
 =?utf-8?B?STRmRHRaOUNCQ1pwek1NeXE4RXV6eEI1WElQaGVEWk5VTzk5THQ0K0lNMW04?=
 =?utf-8?B?aWR3OXRUd0E0V09ZdEhCajdDdlhRWFVMT1ljYXpvMXRRUFJtTDdEZXJCT3dL?=
 =?utf-8?B?RkJqSUZyVHlLcE9qbFRDbVdyN3pJUDk2L0Iya09Ia3Vla2NXTHR5MlJXcFNN?=
 =?utf-8?B?QzF5STQvMzlUc3NWK2ZEUFlDdWdUSnRnbk96aFlOa0pWMXFVOCtQc1BBdjh5?=
 =?utf-8?B?dXFlSzBGdTVJMjlRUkI2TmxsZUlDZVhicnp5TWk3QURZN3A4L3d4ZmlRa29Q?=
 =?utf-8?B?dDhVN1RqQ2lvaGdxY05weXZrK3J4Tk45eWJucmNsekFrKzZEcEdmSGdKbzh6?=
 =?utf-8?B?aGNVdHNZNEFHMi9PUWdmMHRNOE0xYjlJN0x1cy82azJndEUyK3dGaDJXMGRB?=
 =?utf-8?B?Vi9GRG1jRGhuaFhrTmI5KzJWZHQ2SE11TFozNkd0MFFxSlRKV2tMajhYaytP?=
 =?utf-8?B?WlplWGpmTjVObHRNdmJBcUJUU3BXR3gySTcrK3ZTdlRKcTNSajl1Um1KVVpE?=
 =?utf-8?B?b2w1czQ5aXY4NHlQbUZMK0IxTitHTjFVWFlLaU0ySjJCZnMxeUV0aWZLaml0?=
 =?utf-8?B?Z2kvQktIWk9zdlh2c3VPZXh2V2VsVjhKMUk5ZmJOTTk3RFgvN3ZwMHFHYmZl?=
 =?utf-8?B?eGFmNEtZcm5wVitmY2tsOU8zK2JtRktIWS91UU4xMUJ3Nk1BUXdnNXNTd2dO?=
 =?utf-8?B?ZlZCYXUvWWdQTENRNnhGQUxZcGhsejB0OEhPb2dVYWs4NlZ0T3NEZkFBc29Y?=
 =?utf-8?B?RDlWdkNYbFJCUU5GY2JnVTROQ1FwUHY2YTZjWkE5ODdtK3JmYkV1Q0g1Z3Ns?=
 =?utf-8?B?Um1BaElwSWtPbmJGaVpJSEhLb3N0ckVSTzFQQXpUSHlzVkZYVXhWNE1rcXBN?=
 =?utf-8?B?Y1UyV05FQ2NuZGswTG5Uck4rVEdtcS8zSUdXcEFXNWRxTERhb094bDdjbUVn?=
 =?utf-8?B?Q0dtNnV5b3V1ZGNzNTBpaEZDTVJCZXVxTVJuZ0owMmtweFh6Tk5jazFGUGor?=
 =?utf-8?Q?awamH7BvIOoUARQLEpS7J0B5ZDOHYitKQ2v1JMpftX9j?=
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-9JwUHcSibnmWYQ4OQeJv"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tKHXJfDxSe+yqqry5xf4wJMuJvvrtnujuOxWoGm82yL6bnlsAA54rV4t0W+pTU/3oqCY8rggDDKvhKusPNFaXOjk4Y2X0yeCUyycrEAm+a6nrk3+t2S3sl0fZFTUyc/AK7T/DT1liWH3zT/zneieDWoHN713MxuGliNKLJHQ30c7HKvS7TbNMAvhJ+LGtW4Hh3U3A/9kmsUEG5vFcGzdxgyyACgGpA86ksqbvVTigU2DglmEGmClrQLc/4xTUm0y8Rivp+DUOefyXc9np644A4rM/P5ScW2afijVWDwKBwyuOpG4yK5eyNavzjO3guJKGDIui0zffsQGCl3GOx6RWdwsPaUeukO1QaNOnmdSd6aHIea/OS4bBVFcGoTK7PUhKCJQl2VWFb/KBGyrS5zccMozCN78epSyDL5Co7xU59tGbvz5ukF7ioLS7w7UnPGtAT6Zmu45CU8OHASkfblL7+TlYLogtHml4jQQSKoRmiyzlSqc+jpQ6yZVSPQhXMLgB1U/rlc5V+zK+36ppbg3GhVz2q4wS74J+PPI2WuSYzqychcFjXtkFHnoBuaeT1An91I7bJ9EKW50mkTaOKNg+TVn87kXGQfuC+J2WBCQJg8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5563.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e46024f-982d-4d8f-021f-08dc9fc9fef1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2024 03:48:29.3661
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: feH80u5LXqal7bSpit82/jKk5PXoJe33szGU+i7lokKkEzvqxGSuhxizklDK6grnKYKyiys4mSQ3IEiosOMCeJow9m1P0NGOiERYBAWr6wE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7459
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_15,2024-07-08_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=795 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407090023
X-Proofpoint-GUID: mdOd4an35_yBdQD6Sz-fRRkc2dYrm7fB
X-Proofpoint-ORIG-GUID: mdOd4an35_yBdQD6Sz-fRRkc2dYrm7fB

--=-9JwUHcSibnmWYQ4OQeJv
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Is this a duplicate of CVE-2023-4881? It was rejected with the reason:

> https://cve.mitre.org/cgi-bin/cvename.cgi?name=3DCVE-2023-4881
>
> ** REJECT ** CVE-2023-4881 was wrongly assigned to a bug that was
> deemed to be a non-security issue by the Linux kernel security team.

Thanks,
Siddh


--=-9JwUHcSibnmWYQ4OQeJv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQ4+7hHLv3y1dvdaRBwq/MEwk8ioFAmaMswEACgkQBwq/MEwk
8irFDRAAovFlhau7pnq2WzUOBSmUJMskpcIIjR//rOm3FCjfYXMKofGWwrs37kmQ
XVMmsI9zkVkflV5XWPGIk89YNzxT920y6RNXQL8WN/7BiQE1c6HXQoKqoWyfSHjh
uXWvTfzresF1Eo3/6vp2rNhekN2wHYotH9cAfviW5RQ8R6HGpFmJzWHq+WK9kgS0
8OzCXQnrJfMwDplSE5aJ7go755Y2H/haMJB/KFHINjpK+xy5Vh8mzaHXbdxEX2x9
qVLm39uqNwxQDEhT9ui8bT715KBjMSDaN9DirFZoiQm31H6t9YNS4XwvVtUNC4Eo
bo8YopDPF3F1rvM+fMItL2bXc7qn5cnri1oK8MLexwXR8jPsoRWD7Xk3MRErpR/B
8LRjFZqiCXC67rFJCLb+8XhMMRlKkwo7Mn1GJdeeF+a0a1EbyzybZDn/iVgm8ek9
aK+8vz4DIerRY2xZd+rX4VRy5Ax/+Y1vqVITSP7FEBpcW13rud+dxVmSsKUDDxUO
fIKcWR8W/1J8iBf6/9Xh8jJGrorXbW/o4r46KbPIwXwFKRf8S/9bbL8KrxuMxrR/
0Dz+Oy6w5AxoQbvzZw493XFvJX/8z0LhWjoy53nS/vh8/4aT+15r7Ha/t/vzW1h2
Jq0EFKBuYvubDC/ZS9cwS2VUHGKPgJ+1zJVb0tjoREsGP8PbMs0=
=aiJ3
-----END PGP SIGNATURE-----

--=-9JwUHcSibnmWYQ4OQeJv--

