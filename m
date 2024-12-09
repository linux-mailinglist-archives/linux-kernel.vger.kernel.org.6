Return-Path: <linux-kernel+bounces-437874-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F5D9E99FA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 16:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A4DE168392
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:04:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52CA1B4245;
	Mon,  9 Dec 2024 15:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JdrRXQXX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="C3Nwy7Ru"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7081A2392
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 15:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733756664; cv=fail; b=ODf12IA66lI9y9fYOYgxzVsTr+pt6ZU5ZK0WGVr5hiyQLvPMW7ExB/W3K224DhuXFWchjqSq8qcvQrLmsJjEHYr85Xi8jo5ZsFCB7CwRdVhpWQ3BI5ecV8TTlUuR0f+C6sSW45m4zew8Fylh2SH++OhiIU5+XQRrC7HmIVJhfgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733756664; c=relaxed/simple;
	bh=gV42QCVFsZeNoo3jfy/cEgV8FvbYxCShkdcHYq0CdwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=GuHOMcrv3+V7ljamnaT3gXK73VH1nAb51RdWKtm71UzKy7r40bD95jKtw7b1CkE7VxcyVOEvvu5Dr9wLD0tp2SaJaGCdnm6DN/I+q93Rg4dkezyM4bABvZKgfrih6cclzWnB+F8ISb4AWTizVtEIkKEGzRkdE7yi0Rve6CKNrKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JdrRXQXX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=C3Nwy7Ru; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B98g2KP011325;
	Mon, 9 Dec 2024 15:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=YUPvCHa+4v1zNim1qa
	WP9BEv4k/tadWyJdpu2gOwUJ4=; b=JdrRXQXXa6HpmGjY+0TjquB9UE8N29fIkU
	UB8t63FVGm9t4OXyMMjiJxJAZJujaFD18o54p+zp2sAbNupX3sH4Dl+kmC6slMs5
	bW+OBzK6OzhL/War/obgQtTN6VLZZGGHwIDUvmSJZbu0ZlGsuR8YSVQhJ8IZqt86
	a6XnrVtV2tuGA/kMJO/zpdguUas9KX2ggY39uH/NmR84LDIiOraZQluK5Gf2cMth
	nOSrFqX8KnRtXfad41CklyDDlHiF3bBMsuGo9d/31fBgaO/K2ZLKOMTJcnmeOFOt
	xLbBYUYNPNC10wXY41kWIvmYPGcU/0h+xoR3A5Xml9vHjDEMYzNQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ccy03fx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 15:04:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9ECZw4035549;
	Mon, 9 Dec 2024 15:04:08 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2046.outbound.protection.outlook.com [104.47.73.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct7cy96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 15:04:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QVNMLinRvjtcy7TKZFwQIfKTAVs1yYi9rJmLx+nWVaP3yKlpD0rYwBZsO8/8mL/DBVTg9QIViK0U2QymfZdgMg7zrGyyDUIYZPUiBYjMNVVTeSu3MVmGGQ1g6q57/ZfrhiPzxmC9QG4G9ffNflcM1WYfrzh9SRJZcmCzxAdsccOJtKLb5mmk0dYtshJGf+Z1GrDZRNOJ1ponppgv/o6Imxc7jmy71nkTyK5lO9W0zaEUdD/aON4Kum22s8PHrSFctLY+6rJG7jdgiZMb+d3KZZ+q37gy1WlFftK90pIaua3uvkKr1sSyjPVHxQo9xqmrQL8q8nXiMNslqG0rY4JARg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YUPvCHa+4v1zNim1qaWP9BEv4k/tadWyJdpu2gOwUJ4=;
 b=xqGShBdknFkcd7zp8YUusSPbwVSRvKy+CyGnqLuI76AraQbhchSdLmkM9yP0kMTa8AgbABXmjWgFdQTQM96ugOVAmdB2UcJY9Ra2umz6P8Lo0afEQF2oBlL3Ii7BAWYS9W0VKR6ryy2PHO8oSgjVkMAHA8WZkym1KEobq/B2cs3aNTMqF8Ik0mtkAESZxE0xqNDVu/dlYclBAmxmpyLGR4htrUT66W5nnLTkTTkia/1zLmsgEqt++qtDVL2KAS6k7x7DYwRoc7cfYtdK4soefBWWvt6xM/oNVVTUUEAcOp3BTKHwU6aAiq4xUz6M/1QTbHvX0cKrbJzXo/WuKTueLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YUPvCHa+4v1zNim1qaWP9BEv4k/tadWyJdpu2gOwUJ4=;
 b=C3Nwy7RuoVsx/QIrgBwwWIhJYQ3n52gTygbPrzCwWkFj1bowNzRY+stJquti5JWZee+nmtWAPhwQFKDNKKBStwoqfBEU1FrfKsDXiwVtnm4uWGtCKc4L1cawpZYCyRubhizgDZhYbmMdSyXdi5dsqwY4xqbHH0LxjQM0wUqSNA0=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA1PR10MB6783.namprd10.prod.outlook.com (2603:10b6:208:429::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 15:04:05 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 15:04:05 +0000
Date: Mon, 9 Dec 2024 15:04:01 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: group all VMA-related files into the VMA
 section
Message-ID: <281f8874-61fd-4e51-b756-f3a749bf55cb@lucifer.local>
References: <20241206191600.45119-1-lorenzo.stoakes@oracle.com>
 <23d3d7f6-d6d1-430e-8ea0-ccae76b253fd@redhat.com>
 <d9df6f73-9e6c-4f8b-b2c0-5534725d1b18@lucifer.local>
 <c53c8f59-1e5d-40d5-97df-7200c21c43fe@redhat.com>
 <9fb4761d-db28-4271-afb7-9e3cafa89438@lucifer.local>
 <895361fe-5fe0-47c1-81a9-e930fde482a2@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <895361fe-5fe0-47c1-81a9-e930fde482a2@redhat.com>
X-ClientProxiedBy: LO2P265CA0356.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::32) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA1PR10MB6783:EE_
X-MS-Office365-Filtering-Correlation-Id: abd50159-2a10-4f56-62ef-08dd1862b91f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/WcooIYpSDwlB9TL2mXPX2cCXQXQuAPWMrvF6jUBbER3trD7i78YYeRQWJUU?=
 =?us-ascii?Q?5nAIYvWf3i5S6XZ/MjcWGsFT0uT3U/qHnPbHeMFR9aC/d23BMY+FmkmLqtDi?=
 =?us-ascii?Q?WeRKy7MyiNKK/7ghCf4QM3iuevZhzHHe1jIfnJbV0iU982rqGCeiCK+OVQhe?=
 =?us-ascii?Q?5Weg/j7SoEOB6xgPTK1680SplUiREF5oE3s/QVtDlngTuR2hSpRJLC2zbxMI?=
 =?us-ascii?Q?XzwUlmjksQANTSZCAAvr4e2av338FBA0qjsqf++opP/5tfo0BqXTPpp+Y+L0?=
 =?us-ascii?Q?7gGjGy8QBM4aRReIQN3yYpvugGCpDp2v1E6T0EKtglDt6WmzQV6wxI62cmmP?=
 =?us-ascii?Q?++GsK1zLuRTAk4vFu6CzEnXFAw0IGhI01EBjcco5EOUCvyluvxw7q8rlmYTN?=
 =?us-ascii?Q?y67DWkZSdFDRrXEZGGoFJoqRa0XUqvomXPDevPapISZodpxVeo+zp65HeI78?=
 =?us-ascii?Q?vjTRfggCJEo3Ohtb4zVk7urRA+q1UDvaibYKCSyX14MgQO5HwWfjIuiptJa5?=
 =?us-ascii?Q?rmkL3MncT11fLOrMYidd+n4VersehLrqPtACwJBlWYg2t/U2fiumF7q4fKNS?=
 =?us-ascii?Q?GLrfg3afCEjpbNfPJmm1vUqAcQfnctAep38NzMV8HI3j3x3f0BxmuhODIvF2?=
 =?us-ascii?Q?S+K8OIzj066NjHhnOIkKsIexuJMFGGW0DCuguvBOfvd4aVHJd3nAHJvOvxWR?=
 =?us-ascii?Q?DUnNRnHifnHbLks+2XN/mGzK48jI25lO6OgPiXkA4aox7TWaSoHbwtKiVTVd?=
 =?us-ascii?Q?s+XcvFYkPqvHngoNrgkWaYkpn4pyU/o/tt8M9MdS2OoYY4V6Wxtr/WSh/HA2?=
 =?us-ascii?Q?xhzUJjtaAn5iMeyG38KzfcIa/WiIMMTJ7yPlXYQQPvL+bfQ5I3s37pRjQdA6?=
 =?us-ascii?Q?CXyat7EHy9mSC97gYOxTCQe2PdVxidDBubza8/ZGQj4iMWOod488S6nZcfvo?=
 =?us-ascii?Q?C99kP3Fv17+p3bZ9t4FIfIftwsrFu5QaVyZaVHJPk9eP1s/0FPG1VvcaITKn?=
 =?us-ascii?Q?Dy42vkCBAugkClLSGtKAGy61VtjeK34Z9ysFdYrRkIpyHRgu69Pci8dOocNQ?=
 =?us-ascii?Q?DQF5SmtNLFH6XJHsqKSg2rNkcGkRiiWbc2rwKI7FqLKPkbpTzXM5C0+IkiuZ?=
 =?us-ascii?Q?12HQ6V2FUV3xREWokMPaE4RvLuDJidmxcV0IVos4hTaDMAXZbM5JzrG/lzfA?=
 =?us-ascii?Q?BhWQxzgWmfTm5pTjabvLjn1are6QuKlrIMfP89p/5C+6AbHjZv5Iu7mZg2GS?=
 =?us-ascii?Q?8MduOrET2RG2RAlPeavDGNT2JtPQXNyLNPfxOgVd2RfhpPaPrLbnB8uIfxwo?=
 =?us-ascii?Q?Tzw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zeklf+qFBhX+UuMufbIFicPMOfDILc56K8QDKMs4q4WETycjKCM6iXfnno7D?=
 =?us-ascii?Q?7IHTS3HZ/9nn5pLweS4OhaKa12cMuY19CB+JCsQU2vH70cGttzEx0g0nKUXr?=
 =?us-ascii?Q?OkH8VrwpSyRjSusASfeUXy6Z4jPhpKFqPZ7IIRmuW1Vfkojna8zBbqIHzr7D?=
 =?us-ascii?Q?hlkOXpVgkv2WCdDbhMgMrhvJ1NuE5jzaH6b/iEENV4dtSMGhscQNYsaq3QsX?=
 =?us-ascii?Q?TKu1p+68NySu0AB0ihMbNGYT/0FhD+26ZqLcI/OFu2jR+UZ8yOyZdypg+J+U?=
 =?us-ascii?Q?SEfLSN1RVfWyGnINBVYAaj+Te2ADaS1/r9HNmwILdFDeFkAdmP4pDQCWviZ7?=
 =?us-ascii?Q?ZKj0d/rPDqp72CKAlLIFnkbQO9d9pURG8We/kpZ91A5/RIa10ypokG/gI5YK?=
 =?us-ascii?Q?6ngONTkIrMCMrsvgt2ZJQci9EpBWqXdLPLdioe9RxA5vAw25C7MqDI0OO/LX?=
 =?us-ascii?Q?PlXKQNq51Yt1CBotHtJpzfV7AbH4Xvzp5HPsLknTlHBFhwNVxMNlbBTboEbi?=
 =?us-ascii?Q?iHpXRHr/1EPDGF3imi0KILZOLGtlPk1bgmUM10lYwywyj/yKoGqbemxQSuUr?=
 =?us-ascii?Q?ZGi2U4C5oRCCm3U8eEOiPzaV2BHWHXc7myhkpiRExfiFJ9coVNCoiCksDNBQ?=
 =?us-ascii?Q?3x65kQoMLbKqhqFzmjj3HvAuz4CNZiQNIbHAquAp7DW7m44S3RrYWjwqqCno?=
 =?us-ascii?Q?hhEULKa0dL6c91wbQC9Vien56KpVMkNuxkGJtfnWIisbLO9aea57irWb+I6Y?=
 =?us-ascii?Q?Zb7HEZd7RLGWHIo7T1L+eJTJFrOvMGXQ46QAjZsEKzuttEJLrbjEUi3tCGzR?=
 =?us-ascii?Q?WZqvn6vq2Zj5Ok+nayc9GEiCXdcIAPHnehL/FDCKtvY4llVIBEoKeFlP3BOw?=
 =?us-ascii?Q?4uZMj4g4k1OEbRF4tOosGpYqe2KByLutMYcUPhR488vD8lchGmfKVNhWr6hK?=
 =?us-ascii?Q?rOte5BYfzYrmNQ+82ZRPE9nr2Vj3GPyY6TEOdZxqEQye8jQG+rQ3PlwOWzGc?=
 =?us-ascii?Q?v9QGAM8gMo5gdNBFa/MVhXnopZVp2w1gzZu1I8ffXvF8BUlaqnd0mZmfr1uw?=
 =?us-ascii?Q?aHypwYdUhx84H4AI1/JK1ZLMDX72dzLhAnZf42sFNe76ZBz0mHZL++ldtx6W?=
 =?us-ascii?Q?Vvlw9xbcnZhps7xgG7ymok2KXbWs2/Y+PUg6dvVNW2Rrejpslir2Ea40p7d/?=
 =?us-ascii?Q?3HxK6rqIazvtUMV75aPlA4rPmhAMWqZGjdKj1b1SKZYpORmdJ15dE5g10Oj7?=
 =?us-ascii?Q?M0VeXkz6VMF8LzWQohi57uGNzjVsnrFjVxsVI6X1VCKY1WX1qYeL+FgIrtog?=
 =?us-ascii?Q?LX6SBq4OrDkKAdFqCoOkcxP8mTs5fRZYVTaNb3R+LmTfui956JQvkLldkCc7?=
 =?us-ascii?Q?Ok/66RUEKjIO9Yw4AdiugMY6QUz6W2YgYn275bupWe2O/O2EcgvW10Zj+uYw?=
 =?us-ascii?Q?ApdAS4G7mfgQkRvkXw+y82tFxLixl2D+wpj8h2FnrbWBTxloVOjcjrBe9d+1?=
 =?us-ascii?Q?EMG6Mthqnq8flIptDGeLOgDDc7cYDUOUGEqOMmDtT98kER3mGwmpCGri0T4j?=
 =?us-ascii?Q?wSHXkpjIa97D1qTH0dd8Jo8ABnPEmS7f7LtRzJj2c5VDQeKHDJEIc2W//EUE?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+Dimzblxc5N9VkysstBkbX6mYjh6bOsdNl2gAuPXYJlRMwu1HZXFYIe4ojdnVSSqrWzz+YcpoMn/RHWBoIOvVw/DuKm6A6LVe6vWJInjG5BRHE5RI7ULHnXxltF/AvoVDL+CG5zFlexNocPOAnqSFN2SYcJvH/o493W/LL5APdiM85L12GJUY2+INsr9/sUqAThH7w+4Y9jdaAScESvw+GOZE01w8LCBZc8aloIGvu7EOU5IwkVK+ndJ58gnLm3hNZyBn77e8AAzT8SVgxvjgL5xL/MjOdKjvt+Ek9R+f+cQDXptSfcblu1F6SR5M5M3S0h+U7p7i4QkUD0m2irtprtRSbM9y6crUvNnu+WiCOG7F74BcjtBcJSqhFY7K4ZR7NJoNlzrHigZqlVT5LEYPelBN5qwBteX4sKq3EA3zVRUKM+uDG11cF3v2hwTvdypmJKvyK7aNsV1We+nZSKlNdG6uO3JeAa4lxz6fSuGTZvGfyp+96pOGiJgoOCZmmabnHBw9e6gaCs8l7RtC+B4ncAlWD03yz6ktFO3NMjSfb1FWh3kC5zg3rBy3Ft2b6Ums36jr3wuZHPbhwqLia2Nr5gBG7J/bXJzthpPAvb/vDs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd50159-2a10-4f56-62ef-08dd1862b91f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 15:04:05.1259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yvrlYRVDdNNZ22iqnRwYTCuJABql7jnHpq1fD3EtgXEAkFQI6VduTtrE2mg426/FFJRoTURHWBh7dON2dri02fPpdr7Upn2XgzAWknQ2QAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6783
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_11,2024-12-09_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412090118
X-Proofpoint-GUID: qxGydwnvQRtvHyqJf9BKYV8C98eh4tRw
X-Proofpoint-ORIG-GUID: qxGydwnvQRtvHyqJf9BKYV8C98eh4tRw

David -

The key aim here is to avoid having something get merged that everyone misses
that sets off a landmine... So.

Let me propose a few things, and if none work for you, perhaps you can suggest
one?

1. We also maintain mm/mmap.c under 'MEMORY MAPPING' (see patch below). Perhaps
   we could place these files here, and add you too as a maintainer, if Andrew
   were open to it? That way you can keep an eye on it? Perhaps others who have
   relevant knowledge?

2. We add a new PAGE TABLE section, with us and yourself + others as maintainers
   which reference the files which explicitly manipulate page tables as the core
   'magic'?

3. We do the same as 2, but add yourself + any others you suggest as maintainers
   and us memory mapping/vma guys as reviewers, if you feel that this makes
   more sense given our relevant areas of expertise?

Or whatever you might propose? Or would you prefer things remain as they are?

Key aim here is so we can explcitly avoid anything that breaks or blows up
memory mapping stuff?

Thanks, Lorenzo


On Mon, Dec 09, 2024 at 03:56:55PM +0100, David Hildenbrand wrote:
> On 09.12.24 15:28, Lorenzo Stoakes wrote:
> > On Mon, Dec 09, 2024 at 03:09:26PM +0100, David Hildenbrand wrote:
> > > On 09.12.24 11:06, Lorenzo Stoakes wrote:
> > > > On Mon, Dec 09, 2024 at 10:16:21AM +0100, David Hildenbrand wrote:
> > > > > On 06.12.24 20:16, Lorenzo Stoakes wrote:
> > > > > > There are a number of means of interacting with VMA operations within mm,
> > > > > > and we have on occasion not been made aware of impactful changes due to
> > > > > > these sitting in different files, most recently in [0].
> > > > > >
> > > > > > Correct this by bringing all VMA operations under the same section in
> > > > > > MAINTAINERS. Additionally take the opportunity to combine MEMORY MAPPING
> > > > > > with VMA as there needn't be two entries as they amount to the same thing.
> > > > > >
> > > > > > [0]:https://lore.kernel.org/linux-mm/CAG48ez0siYGB8GP5+Szgj2ovBZAkL6Zi4n6GUAjzzjFV9LTkRQ@mail.gmail.com/
> > > > > >
> > > > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > > > ---
> > > > > >     MAINTAINERS | 19 +++++++------------
> > > > > >     1 file changed, 7 insertions(+), 12 deletions(-)
> > > > > >
> > > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > > index 1e930c7a58b1..95db20c26f5f 100644
> > > > > > --- a/MAINTAINERS
> > > > > > +++ b/MAINTAINERS
> > > > > > @@ -15060,18 +15060,6 @@ F:	tools/mm/
> > > > > >     F:	tools/testing/selftests/mm/
> > > > > >     N:	include/linux/page[-_]*
> > > > > >
> > > > > > -MEMORY MAPPING
> > > > > > -M:	Andrew Morton <akpm@linux-foundation.org>
> > > > > > -M:	Liam R. Howlett <Liam.Howlett@oracle.com>
> > > > > > -M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > > > -R:	Vlastimil Babka <vbabka@suse.cz>
> > > > > > -R:	Jann Horn <jannh@google.com>
> > > > > > -L:	linux-mm@kvack.org
> > > > > > -S:	Maintained
> > > > > > -W:	http://www.linux-mm.org
> > > > > > -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > > > > > -F:	mm/mmap.c
> > > > > > -
> > > > > >     MEMORY TECHNOLOGY DEVICES (MTD)
> > > > > >     M:	Miquel Raynal <miquel.raynal@bootlin.com>
> > > > > >     M:	Richard Weinberger <richard@nod.at>
> > > > > > @@ -25028,6 +25016,13 @@ L:	linux-mm@kvack.org
> > > > > >     S:	Maintained
> > > > > >     W:	https://www.linux-mm.org
> > > > > >     T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > > > > > +F:	mm/madvise.c
> > > > > > +F:	mm/mlock.c
> > > > > > +F:	mm/mmap.c
> > > > > > +F:	mm/mprotect.c
> > > > > > +F:	mm/mremap.c
> > > > > > +F:	mm/mseal.c
> > > > > > +F:	mm/msync.c
> > > > >
> > > > > Not sure about mprotect.c, mlock.c and madvise.c, though. I'd claim that the
> > > > > real "magic" they perform is in page table handling and not primarily VMA
> > > > > handling (yes, both do VMA changes, but they are the "easy" part ;) ).
> > > >
> > > > And large parts of the VMA logic interface with page tables, see - the entire
> > > > 6.12 cycle - around recent changes in mmap() MAP_FIXED - which... the VMA
> > > > maintainers fixed :)
> > > >
> > > > And then there were the issues around VMA and mm locking relating to page
> > > > table work which... oh right yeah we had to fix again... :>)
> > > >
> > > > I mean you can make this argument about probably all of these files (mremap
> > > > has -tons- of page table-specific stuff), and then we get back to not being
> > > > notified about key changes that interface with memory mapping/VMA which we
> > > > end up having to deal with anyway.
> > > >
> > > > A lot of the reason we have 'magic' in these files anyway is because we
> > > > don't have a decent generic page table handler. Not sure I'd actually use
> > > > the word 'magic' for that though.
> > > >
> > > > I am planning to make significant changes to mprotect/mlock soon, which
> > > > have some terribly duplicated horrible handling logic, and both are key
> > > > considerations in VMA logic as a whole.
> > > >
> > > > Anyway, as far as I'm concerned page table manipulation after the point of
> > > > faulting is completely within the purvue of VMA manipulation and a side
> > > > product of it.
> > > >
> > > > However, can concede mm/madvise.c if you feel strongly about that as that's
> > > > a bit blurry, but of course contains a whole bunch of VMA and... page table
> > > > manipulation :) I mean it still to me seems very pertinent.
> > > >
> > >
> > > And then we have mprotect.c being heavily used by uffd-wp and NUMA hinting,
> > > which don't perform any VMA modification.
> > >
> > > That's why I don't think the change proposed here is really the right step.
> > >
> > > > > > > They have much more in common with memory.c, which I wouldn't want to
> > > see in
> > > > > here either. Hm.
> > > >
> > > > No, memory.c is really dedicated to fault handling. This is really
> > > > different from manipulating page tables in specific cases in my opinion.
> > >
> > > And fork and such stuff. And if you look into huge_memory.c, we actually
> > > moved all of the THP logic for mprotect()/madvise()/... in there.
> > >
> > > Not sure if something similar should have been done for memory.c, or if the
> > > THP stuff should actually also have gone into the respective files.
> > >
> > > To me it sounds wrong to have VMA maintainers maintain a lot of the code in
> > > these files code because these files somehow modify VMAs, sorry.
> >
> > This isn't what I said, I said that de facto we (that is the MEMORY MAPPING
> > maintainers as well as VMA) were dealing with a great many issues around
> > page tables and page table manipulation which are rather inseparable from
> > one another.
> >
> > I even went to the lengths of writing a detailed set of documentation on
> > locking behaviour in and around page table manipulation and solved
> > security-sensitive issues in relation to page table teardown over the 6.12
> > rc cycle.
> >
> > To me, the idea that mprotect() and mlock(), operations that are explicitly
> > about manipulating VMAs (_and of course consqeuent page table
> > manipulation_), are somehow separate is really bizarre to me, but I respect
> > your opinion even if I disagree.
> > > But unfortunately your arguments apply equally as well to mremap.c (more
> > than half of which is dedicated to page table manipulation), so I will have
> > to drop the whole patch then.
> >
> > If issues arise there in future, I guess others will have to deal with them
> > if we don't notice them (luckily Jann did and pinged this time, hopefully
> > will in future).
>
> Again, the main point I have is that basic VMA handling (the now very nice
> vma.c! ) that wouldn't even require page table modifications (the very nice
> testing framework you added) is different to users of that functionality.
>
> And I agree that many VMA modification users imply page table modifications
> and more.

Yes.

>
> >
> > >
> > > --
> > > Cheers,
> > >
> > > David / dhildenb
> > >
> >
> > To be clear, I made this change in the interests of the community and
> > contributing. It seems to me that within mm has far too little sharing of
> > the maintainership burden and I only wanted to help with that and make
> > explicit what I work on day-to-day.
>
> And I appreciate that. But putting everything that touches VMAs under VMA is
> wrong to me.

Well perhaps the issue here is the section then? See the bit at the top.

>
> >
> > I am glad you at least don't object to my doing so with respect to at least
> > some parts of the VMA logic.
>
> I really enjoy how well you separated the core VMA logic from everything
> else.
>

Thanks! Why I admire your work too... :)

> --
> Cheers,
>
> David / dhildenb
>

