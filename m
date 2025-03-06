Return-Path: <linux-kernel+bounces-549286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E80BCA55051
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 17:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 180397A5DBE
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C5532116EE;
	Thu,  6 Mar 2025 16:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Emb21hm0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Iv4V94oJ"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EC7931A89
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 16:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741277497; cv=fail; b=HwISrS3UetW3RILG/kjVMWISmDyutIFI7X+B8nmhp5PD74TE0BDAFxv6NbuYkBdICDcB6wjMPginUeeqHkamljKOCC4wQQSiK3KAPCm0+4xQX1Wkb1mlu40FGFX2F1CuqUT5gYPkRPWpahXd379Fa+/ybHWg2G4moWHau1aldJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741277497; c=relaxed/simple;
	bh=+mPU1OVuJvycQJWqTgckh+EmfMVvVjHSXbiI8c6ZMIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=qbk10lf0r8IxzCwZPA7pkjzBQgpwxUwcdCYb2xwTx5km4XUG1ghPL+KCk2WKWkJdrpu+L0aaKF1UxMoWX+c9qy/pabz+1dGIwKbkUdPJzz7L7e5PSB/+7fgkZURWq5in3UPITsoeogVX0FGkspj0V5MwgNxFH+XmzMfCIogdeH0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Emb21hm0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Iv4V94oJ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 526Fi6C1007624;
	Thu, 6 Mar 2025 16:11:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=TwQ2eECvXZTJDh//Cl
	p+XRLrXF4M90PJuK+oTsXEl1w=; b=Emb21hm035A6nZU7RRdrJvM1eeTj977387
	w0sFYlfA9ODOdcbImAg2ygy9L3dBGKKUBPZ5ABJHnZSuOTuG7Hbkr2G6uN2CNzCJ
	3Z6mlTQo6Tt+xz0QSc25HDe/toU0QzWRTDC68Gftwo9NlKWgHH/y3za+rYe76x3T
	8tY/qq/AqcQ2k1n6sWFwFL+T8H41vIdBKLATSZokZdelIFDnibcDCPm0Wp2Y6Xpr
	HdPm9eiVx6MUEaZr+LU0dqxM5c6ocW0Mkh+b0PYmMYnoSP86bOu/cPmWUy94kV7O
	YLFw3uO4Ejn1CqtY+0R05g1B3dME8qRxuiGiZiRG9jvjheaPiDUQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u822gbx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 16:11:02 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 526FDPHQ003236;
	Thu, 6 Mar 2025 16:11:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 453rpcaa21-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Mar 2025 16:11:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HjpOBmVOms78ZnBTDzaX4Ap6bApxZcfT00D5pnNfaq/ovSm/rn3wrOMFx+A7mG3oCLNgr5lXn3wSmCYPJse1C+WhbiKuPIqQUcxHVO0hEww/vV3jAoBsK7jiHNAf4eDOJ/OP25T0H+Tnku5s9U5IjTzSg7vhz6njff7BqYhCRrP8WDb5KOLbf2+dE5RExDaNhVBJn4RQOaeWCHjlz1VrUWItK1Mh2buYVDZN0Xd8uwY6isXBOFyBPX94yaVfU12neigIXqsVqBxngZ6pJrei8jaqGnpDsQR0/nLKPyGcclmF+o227jG9PMf1VXowC8Cv3sWQjodMMALbt2RpF4vcRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TwQ2eECvXZTJDh//Clp+XRLrXF4M90PJuK+oTsXEl1w=;
 b=CtLQHPo+ahzm+5dvpFzo1r7HoJJE3RLtI55HMpBC4OqK4CDAcdL3NI+NFB6D+Oxpx/2ZP9qcRhZRvYE1ufLqZfrOs4/Y83ZLJ/1iejlH4nbv3T5IWUZGc+I4ik17ozTePfa4GdNrjO1BZeBT+EEdxPocIlJ04fOaxJIVHi25D0y8bKnWFO99lRLKTUW8rTHmw/moPrRLtpI5oY3MJsY75JdPh0kcPH3+m5U09eio+khzN2qfWKdjd1W9iKzAPv+EQTLQ0lB1GnQekAGkLCpZa4sHd0Z0qvDux0Ssa8H3idEnDZE9RegMfuUOcGEKCqFEOdjIp6axYu1A82YddD36RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TwQ2eECvXZTJDh//Clp+XRLrXF4M90PJuK+oTsXEl1w=;
 b=Iv4V94oJx0GM3WrNwBahwoRm+N6DUuXQKOhH7xVWNhWM6ug8aXeuOMqSvsh1/aLmU9+R14QsvJ/CcleivGQAFUxSciie467WwIHR4UAYjV9l14J7+H51bq45AN2Hac9Z1Fli62Rz6YQxlJaBd5BMQYFHZoDDvt0muOyAwkAqcSU=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by LV3PR10MB8106.namprd10.prod.outlook.com (2603:10b6:408:27f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.18; Thu, 6 Mar
 2025 16:10:57 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Thu, 6 Mar 2025
 16:10:57 +0000
Date: Thu, 6 Mar 2025 16:10:54 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Dev Jain <dev.jain@arm.com>
Cc: akpm@linux-foundation.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
        jannh@google.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        ryan.roberts@arm.com, anshuman.khandual@arm.com,
        aneesh.kumar@kernel.org, yang@os.amperecomputing.com, david@redhat.com,
        willy@infradead.org, hughd@google.com, ziy@nvidia.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] mm/vma: Do not register private-anon mappings with
 khugepaged during mmap
Message-ID: <91f91b18-2188-4328-a458-60531c588186@lucifer.local>
References: <20250306063037.16299-1-dev.jain@arm.com>
 <67f0916e-9825-4105-b044-a16c0e82e736@lucifer.local>
 <c8eb5701-47ad-4cca-b123-31a5a978f801@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8eb5701-47ad-4cca-b123-31a5a978f801@arm.com>
X-ClientProxiedBy: LO3P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::6) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|LV3PR10MB8106:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c14d0b0-7411-49b6-e2a1-08dd5cc97aca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ScmLsuhS5fUy3bheELrkznAnTmQghFxGZw9RBUkHFb9VvMCIUtW3K7Dl3vLz?=
 =?us-ascii?Q?9MMS8XU9YgR0CUZgK7YTIVCVKdCJ3IWIhOpU9SCOYGs/JDw5YGmea1hfbssK?=
 =?us-ascii?Q?xEPqJylWVQ/7Nxo9fam7tQm9lEDNzkErfvGXYGpTdPLSTszNNcbibCyTQaEs?=
 =?us-ascii?Q?n95TVwLz4cSKT8rzhO80Ccwd9fyNnaFGa1jyj00si2kar3N+nWeFm0mefUZx?=
 =?us-ascii?Q?bWQvoXcNk6sI8B08FXeYqbBGoG4/6Ynwj63D2eOwK3Ipy2gmQAiMko4GyxWB?=
 =?us-ascii?Q?BkOAXmEHs5fTHf8M2UPl5608CY+B7Id3okJiDCrYnpFGT6V0/hKxVz7I9UWO?=
 =?us-ascii?Q?xDcuI5AErY883tM48RwuB6vDEnFRcDAhLP6Je2tS4B6UXUePFsX8FB6BAXDL?=
 =?us-ascii?Q?2N2BrTUBd+EPePBAbopXbfZ4zIYXAEf5ZqevkDQruWNlgrZYmlBX4ixbDP58?=
 =?us-ascii?Q?XVD6rG9fep8h9AM1l3smKeLVC0U0TOw4B9svKsFGt3ClU/ajdugFIxUZCd1T?=
 =?us-ascii?Q?vlusPzJJCWE5ycQYlNM0hxY2vnb1HiAtsDLHYypwFpoqpOLp1UIF3JszuvuH?=
 =?us-ascii?Q?nu//II0hDwZd345uLHdFl0/6Hvl6rkt1mGCnr1OFwISkSm/E4AGbeyzyPcLA?=
 =?us-ascii?Q?xs4Bk+7to/VK5LP5ysTKUdslrQTPoeJGupFHMfGmH8kMo1ss8VXnuzkUHWRK?=
 =?us-ascii?Q?uhWrccTyv70Y1+gAWdhB91h1F8cv4MFmSMoOmi7lDU57gMKoZOdZy622r+Pt?=
 =?us-ascii?Q?cM9SQGn8SXjxvWdVJ4/ID690+wE7rhscIiO1GY7y6JZzDyjjVPtNvDhrBIiu?=
 =?us-ascii?Q?RaQJwAE5M3o3Hv1Zg48cnBd880grhTCCd9kYqQIbGqTWm+aAO/uqw8cvj9Os?=
 =?us-ascii?Q?4HEuNxvUTKxVy189uQwADUs+o55XtD++BucBuvoTm8SYA+OiBql8H/FoZTrM?=
 =?us-ascii?Q?G/kvK7h/pLAHSN0fmINFibABfBUwvf9gqQNA3mjb+6XUGcT5AtXeQRWl3Mx1?=
 =?us-ascii?Q?8wjW0GCZuxijlidofjRBiTpok8eSn/xBxDbwNcbhpJs9psvvKBn3lxz8E6fq?=
 =?us-ascii?Q?KaZM8+/9w2wUE2nyq+z1MBrMKFqlK1XVBVZ2acatCUf9USQhKanDO1Mbc7Tw?=
 =?us-ascii?Q?5ybBR670J3q6V0gxktJAkKSimsxYTul0+SB2pY68Sy2hhouBsaAplHVmqjVZ?=
 =?us-ascii?Q?6vzwf3xdR2igrOlo/sUpkOCpNeHcccfhZLafniU7lZ2Ov/mms0Ac66orLCE+?=
 =?us-ascii?Q?GpbD2UImg9mFb44rGd8MTx36VuMC+47HOIjMUCA1cBqPI9VgUXhk74o/bkrE?=
 =?us-ascii?Q?+lHwN6OW32+62444pFRYFy3zbzMtecCgEs29F2ywP40d/0LiVMO8GTpKKMdt?=
 =?us-ascii?Q?aGjWM778erGTY+47lYunKIoGd2hH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?14+cpZGyyBUjym9l+oXK+8ZzmbFZDcAjFXpGW9LybTLFiBUVJOAnzGYwJ0og?=
 =?us-ascii?Q?8SU3o5b9ZcQI2y0hgq782v7BGISdiEdeVmIfYNZ0cSEHwX+a9b31esfxtrfz?=
 =?us-ascii?Q?+hZWvdp0BR7HFvwitVQnP9BKOJI2NF956u3UIvUIj0eO/m3mxS1KzTHiqmG2?=
 =?us-ascii?Q?NVN7kpGp3RqHjG/Xc87gm/UeL1NoB6wJmOIgVoIYrlf1BFZOcEOL2y0q/Ebs?=
 =?us-ascii?Q?AhUttxYA6UQFU42LCnVnK75yI3ejV0De5VagVIfawaR/J5R3169SYy/kBuZQ?=
 =?us-ascii?Q?rIdBm4RGVCTJxXZpmwz2lQ6HmTrTXiT0+csRl7liynQbDOlFkyMio3eRXL3r?=
 =?us-ascii?Q?Lnrg0H5gxNZoiPOkjLOogXWGoAQvdpE9G/MgVHUEjgstcJNRbPCZD8o4S4Jp?=
 =?us-ascii?Q?aVXJ/WWMBzyIMB2mmgLujPF96ynDSEio4NnJyS39DySw2iBKT3Yjh2AC4ELC?=
 =?us-ascii?Q?8sxkph3KVbQSzJiPY6sgQFU3G+Y2ORacVdXZryv3IeW1hr/6lJKcMvjX/iqO?=
 =?us-ascii?Q?hakBE56YJplA6tEfp4RO121+r/lof9wEV3lGQdie919DoV8tX8Mjv+6QfbxU?=
 =?us-ascii?Q?UdpysU68ucuGR2DEJ6zcxTZ4DYgRu8gVjNgnDwURBfbBM/p8RUwZXF+ZC4Ow?=
 =?us-ascii?Q?5DjJAVhNfcFJFr1qKvZJgqR+hzKnk3KWMsPLXFMdMf+0LuLpY7u+E9IRyImv?=
 =?us-ascii?Q?ri2FUebENIWjdUld/zKTIcCceVbpixhIEiW0mBvnJyPGo+w3xiVXMSURHevd?=
 =?us-ascii?Q?F5oz9EF0QygfGlskby2esY+luxNN7gd1TdfjqYwcXGgxw6aqE4+iKfkAl7Uf?=
 =?us-ascii?Q?iFto00haDxHikiZy66NCT7VtO35lahhBnk6UkxwDGL3edMVqsNQdlLq6OahW?=
 =?us-ascii?Q?qmOVPxdiC3SMZx4Djthe4+SEN5WBmW9V1RdZAE+l85pz53x5kz8cRxR8mENi?=
 =?us-ascii?Q?E8PHVOg+KKY1/Ky8JEWbc8C5Cqlk/Izy3A8g6oh5oMzS6vE5pOhmBaSzrmfD?=
 =?us-ascii?Q?0GkGX3UcXuI85IB4I0q0Y0HHojsuW6vLGrs1lZnGH2yT1+3PgnCDuWExIYqz?=
 =?us-ascii?Q?kxMFwMPm5je3Ohl6GC/AMJAj2qq0sBqUUo0qzcFCTHwC9VO3hZ3qghzZATWq?=
 =?us-ascii?Q?SDEc8e+i7EC2w1gNPikbWRDnnY2BeEqw3ii1pfmnrZxgc8j3cXEY3RbhwnQk?=
 =?us-ascii?Q?tzoQxOCtieOYgESB7NsGdY+y9RV+9nL7aocwW5gDl0jmjQgV6AxH7CH2qt6c?=
 =?us-ascii?Q?bk1dMOPsP/Uvwx4kSDiYRAAcS1rJRad6gNFBo1ZFsaZbUm63P1CF6VbSxk6e?=
 =?us-ascii?Q?FyBH7CQc/8OisHPUpxW7dRKnmylm4REnsoiosdPBcCwDI8TRmPPj8yZElHxE?=
 =?us-ascii?Q?qcO3Z28zoI+nhn8STcFt2aDi7RgRDzshabzWndLDQaCOyAhanSF5FfeAYo30?=
 =?us-ascii?Q?XTYD6DumLS8WJjl4osRDOOcZWGaz5APT4nAmPOypWEoVJGEQZuuVFX0yv5cM?=
 =?us-ascii?Q?svrF1Uy6K0RQUqrxN0mlSoTgSIPLYMDLWfCk3whdrZLAXD8+KLWaGQ7MWtWL?=
 =?us-ascii?Q?OEscvlMLR846iZuOWFwHSLaPMqVkuubORDNmpCkhLulo/4P5Ca+jO2O7wH9A?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	muweRTCGpk/9ne7KOjkQHn+iGmFzpUBGtS5YDIvqUiOWrYF4/JBBgmBqRo9bKsPVNUzQPAq1cik8osfhWRUmWR/fhvnYBVfa8s0QsNut26kQh/oT3EYU/+Oss/IpwUMObddXYOPo74fYEHy+N5BLDLD6dH3vs1amwkku39oR3SUTIY+w1e1Cg9M2azauEUQWkWrJkKlJJ4HraU0hFL6oYtPl6FAKXlKB5FvMoD0VVAZ91wcx6XrMCC9IFAvMNGwPvOaz7Vw/jt8Ced5VrRWUV9Fhy51zEo9XAYqUfWAmbOoI/xTWWEm6IrAXaRtEVawxUT/DgoqjCLNM/NIrzMOla4nNJKllPVxnf/FL7Wsw1FoWOxOBSIcS7cr9IPpRF1LwQlKlwo6wry/i+FosLsK1VaCNrVmTVJTu7YFJ0wTVFzkeTOh7OLN9oRtfMoqefw+vlMwy9EZWWrdsvzyPm8McTiGsr2PtfgJQovejIVT31F9qDhxB+9X5G0AjKdtWtT63AOZAUG9FSPBjKHu14N3gkcdCG9WuOzqzjcb4gS7dR1izkbJ0QAyzMgX5n4h2JeMs5DgNcHqklsvxLzsyjauoGSFaAmMGJVMF7MgojGT/kRY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c14d0b0-7411-49b6-e2a1-08dd5cc97aca
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2025 16:10:57.6843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I+mnyoiUwiHZmuJWGUWT19PssGrG5UjngOp4xoKuGUWssvzu7t0f3IO8ZaB4vpctZFdBkEwy+knRNHi2X5Ql85v6p0rNcIZq9PenIhBGdGs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-06_05,2025-03-06_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503060123
X-Proofpoint-GUID: wd3-E9WG4IIf9GknSVqDkoSyqxuzEolT
X-Proofpoint-ORIG-GUID: wd3-E9WG4IIf9GknSVqDkoSyqxuzEolT

+cc Greg

On Thu, Mar 06, 2025 at 08:02:10PM +0530, Dev Jain wrote:
>
>
> On 06/03/25 1:48 pm, Lorenzo Stoakes wrote:
> > On Thu, Mar 06, 2025 at 12:00:37PM +0530, Dev Jain wrote:
> > > We already are registering private-anon VMAs with khugepaged during fault
> > > time, in do_huge_pmd_anonymous_page(). Commit "register suitable readonly
> > > file vmas for khugepaged" moved the khugepaged registration logic from
> > > shmem_mmap to the generic mmap path. Make this logic specific for non-anon
> > > mappings.
> >
> > This does sound reasonable, thanks! Though does need to be expanded as
> > Andrew says for user-visible effects just to be crystal clear.
>
> Sure.

Thanks!

>
> >
> > >
> > > Fixes: 613bec092fe7 ("mm: mmap: register suitable readonly file vmas for khugepaged")
> > > Signed-off-by: Dev Jain <dev.jain@arm.com>
> > > ---
> > >   mm/vma.c | 3 ++-
> > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/vma.c b/mm/vma.c
> > > index af1d549b179c..730a26bf14a5 100644
> > > --- a/mm/vma.c
> > > +++ b/mm/vma.c
> > > @@ -2377,7 +2377,8 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
> > >   	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
> > >   	 * call covers the non-merge case.
> > >   	 */
> > > -	khugepaged_enter_vma(vma, map->flags);
> > > +	if (!vma_is_anonymous(vma))
> > > +		khugepaged_enter_vma(vma, map->flags);
> >
> > This really needs a comment :) as a Joe Bloggs coder coming to this my
> > immediate thought would be 'huh? Why?'
> >
> > Something like:
> >
> > 	/* Just added so khugepaged has nothing to do. We call again on fault. */
> >
> > Would be great.
> >
> > Thanks!
>
> Sure.

Thanks!

>
> BTW does this patch merit a CC:stable? I am not aware of the general
> practice but I am not sure if this is a *serious bug*, as per
> submitting-patches.rst.

I think it's fine to send 'not serious' bugs too :P I mean this is a perf
regression right? We don't want that in our stable kernels.

Unless Greg suggests otherwise (cc'd) I'd say it does merit it as there seems to
be no risk, only benefit and reduces overhead, so from my point of view seems
sensible.

>
> >
> >
> > >   	ksm_add_vma(vma);
> > >   	*vmap = vma;
> > >   	return 0;
> > > --
> > > 2.30.2
> > >
>

