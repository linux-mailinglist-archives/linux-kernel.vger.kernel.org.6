Return-Path: <linux-kernel+bounces-407935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C15E89C77B9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 16:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE472B36CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63FE13A8D2;
	Wed, 13 Nov 2024 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VRrwVJh2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SfXnMUkF"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19E07C0BE;
	Wed, 13 Nov 2024 15:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731512702; cv=fail; b=rhamchCymF5XVO36Q+RHf0NRsDsxArd31dX1Nfd+a1MkZhBS78JM00eDv2Q6ZKvPM8IiwdI2YQBYjFbuBrouF3IWYqrGO4klN8buytZpsFSJrlOXYp+dE706dh5nuXQiu3B3Zxv86FYhJU+COVlvGpxnRMFur+nEHbJMJX7Bf/o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731512702; c=relaxed/simple;
	bh=g5p67pxL/xC+quObjdJ0FlbOaaCWrimgmBhY3ist5pE=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jwnizN5IoGkkR0jNh8gd/eI9u2BX8pipdxwFrXkng/M1F5O4ypacPrksqPnlNMPZC+N31gqo0MkTOQWSDCJ/lyIS8LZff1l2ksbt/ltP57Cln9wIp4IWR+h9V+ADEywZ0AMeDO1aImFi9H9D/7hewxBBJaVbmlV88UnlSD3+EsE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VRrwVJh2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SfXnMUkF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADDXW9u018897;
	Wed, 13 Nov 2024 15:44:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=hyLPFCS1gLCxGhhf5b
	n5WcKdRxxzTU3HX8IkBeltZgM=; b=VRrwVJh2EKHzl8tgy9fAzO2VrfYYWz8Fhj
	G6xH8wV9YOPRduoxOgtzmOJdmE9LJf6VRQlKKUNlxhsAPgO0984uTY3g6DOTK0s8
	zGk7f24Ztdn3apOikb1IlUiaQ4zmUHWi+Fcbtfx7DznBBZyX/IKMqpLbSlJZIHeb
	HtHQWjj+VC02th9YtdwFJhWcdAiQJ1c73BJg1Ifd8lRY0O5gzv4HHmDeGysfl+K2
	6LF+W7sGbKIeFK9zNckEW/WtMRWQInoHAoBBJYF05a5Y5A3SYApAqHch10iUw5Rx
	cBvSqJHP25awVosdYpfCcvZO+5WLRTdSsDbXRvA9grAPWy7gWxzA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0nwq5bg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 15:44:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADF2NLi005679;
	Wed, 13 Nov 2024 15:44:18 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2044.outbound.protection.outlook.com [104.47.51.44])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx69swe7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 15:44:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=llx5oO2WIIFPPA31PIvFbllkYQ6dvEfSmKSFm1g0nHdrpapLhSdyWl+VHLV+gip5v5SzKYBPIohWTAPoXiLXUqA5htjh8Z7boWPb/tthjn8qxH96oT25vsALBY9tBj0G2Z/jyNcEa7gFr3iW/PdYyifR9IEUDxcVtHfKkmt8IxFcJDMaFVffuJbBYfKBBlrNE1bkBLcM+L6MXxn1kA0A5AT7KuXSGz0FOs2zyiom2QhSh0CrJgPlFgFj974vLgJegfUqIfU8gKwnPIv5XeKO+YKHOTo9agE1ZpMYTZaQlL/iih19GAedmHw4WanxzaBUduciRVVEIscCMWrA6I8NKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyLPFCS1gLCxGhhf5bn5WcKdRxxzTU3HX8IkBeltZgM=;
 b=wBOl/Vk+7U+ZxebmWgsRrx3/ViSXUAd+C5C4dwLqq2Jv11I06FB/EA6QV8DOfmbd1htFOhDO67+d0fqY9lhWstiPKdi8q2Abg7wo6raSddUIBHzZz3BxuPEzjVnN1DOO2DAh4I5NOnJRivzOgqKYfiKmhXjPegJmF2dizefQFAuuk8W9PyR49A42cf7QNllBSup9pvIChfDNuYzHiOhMgq6MzSqOzciwNjoJ6AR6iTyyK4KxrDfEnIrQMlM4g/PgLnMSVUviO0bP2r5kIVT7HZVvxSc/f1/+0sbU+F/IDwVG2Po3cy4wgKRRrcxs0Dd1uoM502ExOJ51g1sPkjpCpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyLPFCS1gLCxGhhf5bn5WcKdRxxzTU3HX8IkBeltZgM=;
 b=SfXnMUkFVzBxORMP0c/ChKIoyxK3SYAduOt7HNZgn4BCDMMB/4Dj3MkCuFpvIykKxZqPPTPITno6YizSGQyXXnik1U1NV3A8YjtWWSMToFmDnEA06ddC5iNAum2NGWUmNChdVKkGiG7b2eJYUBRD0N3SpjDuskJNsuSv01RiN/E=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA1PR10MB6897.namprd10.prod.outlook.com (2603:10b6:208:423::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Wed, 13 Nov
 2024 15:44:15 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 15:44:15 +0000
Date: Wed, 13 Nov 2024 15:44:11 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, Vlastimil Babka <vbabka@suse.cz>,
        Jann Horn <jannh@google.com>, Alice Ryhl <aliceryhl@google.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, Mike Rapoport <rppt@kernel.org>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Suren Baghdasaryan <surenb@google.com>,
        Hillf Danton <hdanton@sina.com>, Qi Zheng <zhengqi.arch@bytedance.com>,
        SeongJae Park <sj@kernel.org>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2] docs/mm: add VMA locks documentation
Message-ID: <3593f7ab-c37d-4c1d-bf2f-e47c30bb5d2b@lucifer.local>
References: <20241108135708.48567-1-lorenzo.stoakes@oracle.com>
 <le3ykvrau2lbncrjsqll7z6ck43bf3shon4g5ohchxcvcs4fuy@h3pq646xgoz6>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <le3ykvrau2lbncrjsqll7z6ck43bf3shon4g5ohchxcvcs4fuy@h3pq646xgoz6>
X-ClientProxiedBy: LO6P123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::16) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA1PR10MB6897:EE_
X-MS-Office365-Filtering-Correlation-Id: 296dca0f-29e2-48df-99e8-08dd03fa06e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EBM7IspdFD7+uKAhnngSf1MSbrgdASENjF/OHdekcNvCgMiTJxJnPNSuc8+A?=
 =?us-ascii?Q?C0SZohy0qJFkEY9dN+Bz8ixL2xZPyi0G3tHPvSwSEzNHpEQAFUANloGN1lpd?=
 =?us-ascii?Q?pPgX4jGeHTc1MDSsP7Gqs7FhP9+z3XjWFrUMTlQqu1Rsi0t43XvXCXHykFWC?=
 =?us-ascii?Q?I6JF4N3gRz89d9qHgm6MfiHE1smZn+UmH5Hvy8P7gK/dmHi65K+1WadIDsSR?=
 =?us-ascii?Q?j6T3XMihgv/09o3oUTpuHITlXpOj9OxAeo5t12pq28KN+iaWF9OJqoVLDXjk?=
 =?us-ascii?Q?0N9GbZl0EoFru+Bpe/qwVzgo5f+y/HAbp5nllJc0nTK2AEmFBD1XVDTltXwf?=
 =?us-ascii?Q?MDhJSzoL457FFBEhb4qtsyJajglfDRkwh93w/w0kCEImBQmgV9vzTb+AH1GX?=
 =?us-ascii?Q?D/BZhofDfepVXFeji6sV96nVAhjngjJsxcOiEogefiupjnVY7dJkCTrLEk02?=
 =?us-ascii?Q?CV4/+Ds3ccDDU+3xoY0qHBVr9ia5cIaMikk9Qpz8Yhiu4zIkQ9320Yt9eWzI?=
 =?us-ascii?Q?1hlrqWROxBg0e56az6qpu9tBPBw6StrfoqAMrQspWNOhUD++o1Q7aa9i5Q+b?=
 =?us-ascii?Q?piy+uK5kEoLIzUlul/Bd42vx8CMBigWrCnd1/o/3E30xyLhUOqaKCE5VOrf6?=
 =?us-ascii?Q?qpP826GZAklt4mqNX87MKPKJhVRNXsCymTi9CJ5T1CGFsDdWBbSELuGnMtti?=
 =?us-ascii?Q?iE7Qtx9lqqOJ/nYY4uRoD2SeVT83VHsBWR0GyoBdwFB5pS2Q35ijQACIZh9J?=
 =?us-ascii?Q?m/tvUt3FI//a6XZ4Ex8D7j6fbkKeh1My/fVGa3AvAyLr3B3XnjifeQpR0m5m?=
 =?us-ascii?Q?4s/aW48Yog/mKu17TAdJ/04k++VY+jjB2oY2YDtAdT1OLvgwaRZLqMMV3ZOu?=
 =?us-ascii?Q?366yVj94L0hbGPeFBosgAG4yxcv6uLf2fjZx1c3c8Lv8BYNEMu8xzdYlMRLH?=
 =?us-ascii?Q?5n8nJw7vnbWpeScOZmukwyu3tg/P+bq0tGsoHU0YkYzDRQqqlhhtGC3EO4qq?=
 =?us-ascii?Q?lQCyb+Gkd35PyWWSIpKkRae+UIJA6XNX3Krlztf1OpXUS0TH8CFqazauGYc0?=
 =?us-ascii?Q?HmBnWe8ZPIn34KtcqC38EHiL5JJSYA/ad0XhDtEoYHc0/52RbfFgSXJ1qw3r?=
 =?us-ascii?Q?BU+9sAwWbod3QYMmJ01NgIHiuc52vPvJJiCpIlDwMt5EmoSZ1gIuKnJyCfKI?=
 =?us-ascii?Q?KPlPzEe9xHhBJMzwRIfONA8/044UiBONleCAxhzp5+Ng/Ct2GijWQ3/rLyep?=
 =?us-ascii?Q?z1wO8r3vipLJRijY1tdsIVy7QIBavqsWU9IvHNQEjdjvZDYCEVcljK8piME4?=
 =?us-ascii?Q?FguI4puqhjQjHCPwT0OdRsO/IFfLgKpTQFw9q+UoOyFEWQ/kpTDAonAoYJBC?=
 =?us-ascii?Q?gSQcLI0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3p4fILnqDIzzFMMbAV4ajIHTp7xbFgHjaUDeYIYRb+G71mv3DxWoKsPjL4Cp?=
 =?us-ascii?Q?R+P5GHnsBjZVJJUJ1Zlku2ErekzG2VdaD13vdCJmQn2v/t6k6nn7diHRXCLJ?=
 =?us-ascii?Q?HBoQi0+m6iHMzNJazYF+uHiKlS9QoEyEPggL5EBRKP5OrLy8jTDhrQd9p1ny?=
 =?us-ascii?Q?llqy+TU6pNhBp0Q+hooWYF3vx7d/6qt6Soee+1DBAZQMWGjmWzJ7eQNgipSn?=
 =?us-ascii?Q?19M6oT0sY+mezDrH51FNL70lTTfG8m18WDc7tYBGxVp1Pgk6zRu+kN02n6DM?=
 =?us-ascii?Q?dL7zsg3UwtYIkzG2mCw3DQ6Wgd2HFsJ7poRzhU1iMNpJP9Aaac6h7oR96e3s?=
 =?us-ascii?Q?XpL9c6gfZ6miA122HxJLLYa+wiMovZGJDb6SUG4xa4/XiR/q3AAOprqAMZJy?=
 =?us-ascii?Q?6VNOUvt0IQYhPRxfHY9TtWdzVTWOjzdmMntXSDhLnLWeT6U8h9OlRp9+ly9v?=
 =?us-ascii?Q?Zhn1AC/E1ynB3ZuHee+TYC+Ur8hn/DawUEhQu9gi/wml3GXi6NhXRmx3YoU6?=
 =?us-ascii?Q?/i7dluIlOpqguPAhFgmRZ8CE+muZ59Q5y++Inq44GifurlmtEJqB/vA6FGx0?=
 =?us-ascii?Q?kciWFOp14rOfz1mV7Ua2Net/4qzJsA+m4tgsoW3SmD8hreBpBmGAg4HeTNMr?=
 =?us-ascii?Q?2v2ir0NVRT6DtuU5CTzUpFEUrkNujITmpe7OLldRSg47pXO4VB2PVEP6pYYb?=
 =?us-ascii?Q?QS1sVAGYZn3qouCDcRTlR4eFxyDosazNQY/dYbBpKsdlvh8wePkmTm5LDwIS?=
 =?us-ascii?Q?f2ELgdtIn+dyis+CmHnjhHi4jwsic+amTRcy1UgR37Qz/XNeqqiFzD2sEz/c?=
 =?us-ascii?Q?RaRVMtalj+IEDIiHIKhTgFw8tFSLR6rbl2vHgL3wosnfukUDC95cFPRHYzh3?=
 =?us-ascii?Q?dtCQmgSVE2WD5RgYOhfJH7OIAfpTClFNe6amMN3IvBJJ1w8dh/8sFzekH9Lj?=
 =?us-ascii?Q?tQQG4zC4dnmOdBqvHVzyyLYcToSoYaH/qAmDcweZlAAyDFUNiDk8/09+tSTE?=
 =?us-ascii?Q?amkU/sRlcTn/fZtHY5eaERN6eFysQDi/pTyaQMRYSLLUEYJzvZN6WGesM2Xx?=
 =?us-ascii?Q?zu9z88H5sxo3dJIijRQNoNfV1qaoOv2mt7RUPD0jCiTUj/S5pQ5nKsx7dPIa?=
 =?us-ascii?Q?cGNWZKH3HL9xHQsdDUultPnBlXsWSpigdlfLolT+epx56agMDmv89W/bR06a?=
 =?us-ascii?Q?vIo3v/VuorNjutCTY47eiHCjR11UU3lGbxiKrCkJ7yYkUfZwNx6okXmmb1Xk?=
 =?us-ascii?Q?6GVqiL2SA6npa4h0HiGf5DH2/btWGJBPyd41lCOhQcgj/Ftl0cxTnpVQrLhm?=
 =?us-ascii?Q?e0k0f1H/eEaA6BlwN8FJfa2URe1u1Luy3OTcZwZ/zoflhRlyOgbfa8EliugT?=
 =?us-ascii?Q?+VCLwIjsrSHc5/6PS9rNLwAp7IF5xtQOYxYOvup8/rF7JFmwBF+uS3+GRmIc?=
 =?us-ascii?Q?gJRpEzzxGu8X7D28shdj9Mcnn/jq17vlN4IhFHKPvu860H7rBnZdhO4ny8Xs?=
 =?us-ascii?Q?nWy9F3m7lzeAyzehZPUo54jdENWiZtjWFt5sbV7pZ6mmjVrw9kqOFrMbMq6X?=
 =?us-ascii?Q?+kn5ENZo6V034Bvj27fyc/VB/77ksw14mBiq2ajdBy+l8ju9CulJ1jCJeOsQ?=
 =?us-ascii?Q?dg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7cTbFF5Te/Z5r0gJs6xXOQcDIO7wVDfEWlj3mxQjbq1s883I9tfbploScHOSnKjB4RosHUsy02e51rg/6l8d0GGnJE5cQCNFde1M73j4OcYbCktTGStXsmDkXU6JOHveDdf73+DlT9+rPeQLqvwRP0Hic8GJmCAMxhHopjwPOJxt8Arwf/sTUEjHC6M6Ez05qclFQPv9iy3bQsvDNK861f1tk3dM2/ISzjelowOdaNftREp7Ft73OjcBL6yQXeuEKhIXPrV+8exU9/hMviDLPHVCn3dHYSXAm1LUp2SGGflpfh1eVYBdy38WTHM97DSGOQCV34MkMiPmFUD0tuK2FtMMj/fTzRAlv2KwVl0JvS+RGYF/unlHqT6rnhk6G2V0YBrvRZ8s/KzECEpPQfGahnG5YdOBzjSPoPz85AJ+0nhhsWT/HDhF7/2wHkpqd/GUxcSdxp53y7UAsG+f6rKjH7AQKogmjlaiTB4O1P2+X1v8eGrW4kOTX+OhEw3a5iJwVJb7Ide8zfzB2EGFTyAdU+6uQWNvR+HWOWAy0USN5giM2IfpkTfRAsXk1pn74ZMjvNZhHhjRAsMFIcHqZG46oHarfj2n/VAcfZk0UCMR4N0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 296dca0f-29e2-48df-99e8-08dd03fa06e2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 15:44:15.1335
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIvLk38r9UowgJbut3UdbcY8otzvK91kGz2inppKo5PAsTowvUGQdFu6k/bAI4krIIOkCqIsvF+dJYPSpahjOrtPh6CqDvXVf7cimfwlmc4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6897
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_08,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411130132
X-Proofpoint-GUID: l_D4hguza04sxbazJGu6DFShCMlqmQOW
X-Proofpoint-ORIG-GUID: l_D4hguza04sxbazJGu6DFShCMlqmQOW

On Tue, Nov 12, 2024 at 10:15:44AM -0500, Liam R. Howlett wrote:
> * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [241108 08:57]:
[snip]
> > +Each mm object contains a maple tree data structure which describes all VMAs
> > +within the virtual address space.
> > +
> > +.. note:: An exception to this is the 'gate' VMA which is provided by
> > +          architectures which use :c:struct:`!vsyscall` and is a global static
> > +          object which does not belong to any specific mm.
>
> vvars too?

I'm not sure if that's the case? For instance for x86-64 we have:

/*
 * A pseudo VMA to allow ptrace access for the vsyscall page.  This only
 * covers the 64bit vsyscall page now. 32bit has a real VMA now and does
 * not need special handling anymore:
 */
static const char *gate_vma_name(struct vm_area_struct *vma)
{
	return "[vsyscall]";
}

With no reference to vvar. Also vsyscall exists in a kernel range, and vvar
in a userland mapping (along with the vdso).

I am not hugely expert about this area however and may be missing something.

[snip]

> > +
> > +VMA locks are special in that you must obtain an mmap **write** lock **first**
> > +in order to obtain a VMA **write** lock. A VMA **read** lock however can be
> > +obtained without any other lock (:c:func:`!lock_vma_under_rcu` will acquire then
> > +release an RCU lock to lookup the VMA for you).
>
> This reduces the impact of a writer on readers by only impacting
> conflicting areas of the vma tree.
>
> > +
> > +.. note:: The primary users of VMA read locks are page fault handlers, which
> > +          means that without a VMA write lock, page faults will run concurrent with
> > +          whatever you are doing.
>
> This is the primary user in that it's the most frequent, but as we
> unwind other lock messes it is becoming a pattern.
>
> Maybe "the most frequent users" ?
>
>

I mean the only other users (at least in 6.11.y) are uffd and ipv4 tcp, so
I think 'primary' is fine, this doesn't preclude other users but I think
'the most frequent users' vs. 'primary users' is likely to be equally
outdated should we move sufficient other stuff to using VMA locks (and then
docs can be updated too :)

[snip]

> > +.. table:: Config-specific fields
> > +
> > +   ================================= ===================== ======================================== ===============
> > +   Field                             Configuration option  Description                              Write lock
> > +   ================================= ===================== ======================================== ===============
> > +   :c:member:`!anon_name`            CONFIG_ANON_VMA_NAME  A field for storing a                    mmap write,
> > +                                                           :c:struct:`!struct anon_vma_name`        VMA write.
> > +                                                           object providing a name for anonymous
> > +                                                           mappings, or :c:macro:`!NULL` if none
> > +                                                           is set or the VMA is file-backed.
>
> These are ref counted and can be shared by more than one vma for
> scalability.

I'm talking about the field, I think this can be treated as an implementation
detail, perhaps?

In this opening section I tried to avoid too much detail as v1 of this
series sort of went all-in and people (rightly!) raised the issue that you
couldn't pull usable information out of it right away and it was too
weighted towards internal mm kernel devs.

I can add a little thing about it here if you want but I feel probably not
necessary?

>
> > +   :c:member:`!swap_readahead_info`  CONFIG_SWAP           Metadata used by the swap mechanism      mmap read,
> > +                                                           to perform readahead. This field is      swap-specific
> > +                                                           accessed atomically.                     lock.
> > +   :c:member:`!vm_policy`            CONFIG_NUMA           :c:type:`!mempolicy` object which        mmap write,
> > +                                                           describes the NUMA behaviour of the      VMA write.
> > +                                                           VMA.
>
> These are also ref counted for scalability.

See above.

>
> > +   :c:member:`!numab_state`          CONFIG_NUMA_BALANCING :c:type:`!vma_numab_state` object which  mmap read,
> > +                                                           describes the current state of           numab-specific
> > +                                                           NUMA balancing in relation to this VMA.  lock.
> > +                                                           Updated under mmap read lock by
> > +                                                           :c:func:`!task_numa_work`.
> > +   :c:member:`!vm_userfaultfd_ctx`   CONFIG_USERFAULTFD    Userfaultfd context wrapper object of    mmap write,
> > +                                                           type :c:type:`!vm_userfaultfd_ctx`,      VMA write.
> > +                                                           either of zero size if userfaultfd is
> > +                                                           disabled, or containing a pointer
> > +                                                           to an underlying
> > +                                                           :c:type:`!userfaultfd_ctx` object which
> > +                                                           describes userfaultfd metadata.
> > +   ================================= ===================== ======================================== ===============

[snip]

> > +There is also a file-system specific lock ordering comment located at the top of
> > +:c:macro:`!mm/filemap.c`:
> > +
> > +.. code-block::
> > +
> > +  ->i_mmap_rwsem                (truncate_pagecache)
> > +    ->private_lock              (__free_pte->block_dirty_folio)
> > +      ->swap_lock               (exclusive_swap_page, others)
> > +        ->i_pages lock
> > +
> > +  ->i_rwsem
> > +    ->invalidate_lock           (acquired by fs in truncate path)
> > +      ->i_mmap_rwsem            (truncate->unmap_mapping_range)
> > +
> > +  ->mmap_lock
> > +    ->i_mmap_rwsem
> > +      ->page_table_lock or pte_lock     (various, mainly in memory.c)
> > +        ->i_pages lock  (arch-dependent flush_dcache_mmap_lock)
> > +
> > +  ->mmap_lock
> > +    ->invalidate_lock           (filemap_fault)
> > +      ->lock_page               (filemap_fault, access_process_vm)
> > +
> > +  ->i_rwsem                     (generic_perform_write)
> > +    ->mmap_lock         (fault_in_readable->do_page_fault)
> > +
> > +  bdi->wb.list_lock
> > +    sb_lock                     (fs/fs-writeback.c)
> > +    ->i_pages lock              (__sync_single_inode)
> > +
> > +  ->i_mmap_rwsem
> > +    ->anon_vma.lock             (vma_merge)
> > +
> > +  ->anon_vma.lock
> > +    ->page_table_lock or pte_lock       (anon_vma_prepare and various)
> > +
> > +  ->page_table_lock or pte_lock
> > +    ->swap_lock         (try_to_unmap_one)
> > +    ->private_lock              (try_to_unmap_one)
> > +    ->i_pages lock              (try_to_unmap_one)
> > +    ->lruvec->lru_lock  (follow_page_mask->mark_page_accessed)
> > +    ->lruvec->lru_lock  (check_pte_range->folio_isolate_lru)
> > +    ->private_lock              (folio_remove_rmap_pte->set_page_dirty)
> > +    ->i_pages lock              (folio_remove_rmap_pte->set_page_dirty)
> > +    bdi.wb->list_lock           (folio_remove_rmap_pte->set_page_dirty)
> > +    ->inode->i_lock             (folio_remove_rmap_pte->set_page_dirty)
> > +    bdi.wb->list_lock           (zap_pte_range->set_page_dirty)
> > +    ->inode->i_lock             (zap_pte_range->set_page_dirty)
> > +    ->private_lock              (zap_pte_range->block_dirty_folio)
> > +
> > +Please check the current state of these comments which may have changed since
> > +the time of writing of this document.
>
> hugetlbfs has its own locking and is out of scope.
>

Yeah, I've generally avoided this here as kinda implicitly out of scope, I
mean hugetlbfs has its own VMA locking too.

I think somebody reading this document interested in hugetlbfs internals
would kinda get the point that the lack of reference to it implies we don't
cover it.

But can add a note somewhere in doc to say 'except hugetlbfs'? :>)

> > +
> > +------------------------------
> > +Locking Implementation Details
> > +------------------------------
> > +
> > +Page table locking details
> > +--------------------------
> > +
> > +In addition to the locks described in the terminology section above, we have
> > +additional locks dedicated to page tables:
> > +
> > +* **Higher level page table locks** - Higher level page tables, that is PGD, P4D
> > +  and PUD each make use of the process address space granularity
> > +  :c:member:`!mm->page_table_lock` lock when modified.
> > +
> > +* **Fine-grained page table locks** - PMDs and PTEs each have fine-grained locks
> > +  either kept within the folios describing the page tables or allocated
> > +  separated and pointed at by the folios if :c:macro:`!ALLOC_SPLIT_PTLOCKS` is
> > +  set. The PMD spin lock is obtained via :c:func:`!pmd_lock`, however PTEs are
> > +  mapped into higher memory (if a 32-bit system) and carefully locked via
> > +  :c:func:`!pte_offset_map_lock`.
> > +
> > +These locks represent the minimum required to interact with each page table
> > +level, but there are further requirements.
> > +
> > +Importantly, note that on a **traversal** of page tables, no such locks are
> > +taken. Whether care is taken on reading the page table entries depends on the
> > +architecture, see the section on atomicity below.
> > +
> > +Locking rules
> > +^^^^^^^^^^^^^
> > +
> > +We establish basic locking rules when interacting with page tables:
> > +
> > +* When changing a page table entry the page table lock for that page table
> > +  **must** be held, except if you can safely assume nobody can access the page
> > +  tables concurrently (such as on invocation of :c:func:`!free_pgtables`).
> > +* Reads from and writes to page table entries must be *appropriately*
> > +  atomic. See the section on atomicity below for details.
> > +* Populating previously empty entries requires that the mmap or VMA locks are
> > +  held (read or write), doing so with only rmap locks would be dangerous (see
> > +  the warning below).
>
> Which is the rmap lock?  It's not listed as rmap lock in the rmap file.
>

I explicitly describe what the rmap locks are in the terminology
section. It's just shorthand so I don't have to say 'i_mmap_rwsem read,
write, mmap_lock read, write locks' over + over again :>)

I know this was a bugbear of yours with recent stuff relating to these
locks and I totally get that it's annoying to have this sort of non
standard way of referring to them but I somewhat gave in.

I sort of have a (crazy) desire to do something about this separation at
some point and make it one lock by eliminating the anon_vma stuff... but
that's perhaps an RFC in the future...

[snip]

> > +If a THP collapse (or similar) were to occur then the lock on both pages would
> > +be acquired, so we can ensure this is prevented while the PTE lock is held.
> > +
> > +Installing entries this way ensures mutual exclusion on write.
> > +
>
> I stopped here, but missed the v1 comment time so I'm sending this now.
> ...

Thanks, appreciate your feedback!

