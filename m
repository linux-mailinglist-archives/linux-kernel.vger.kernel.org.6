Return-Path: <linux-kernel+bounces-348206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9326398E411
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE2B71C22088
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98E29216A34;
	Wed,  2 Oct 2024 20:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gLPn9YOw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VA/2THNd"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB0B194A60
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 20:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727900554; cv=fail; b=JMZlqvRcLN/RK0jyxLf6KmxZii8B99MxSrx84pjfGNBaiT+LtfnB6NO2haj2G1cdGQoc+G7t86wZD0iXPQNaYnmoX7xprzDdarh6Xos5XGCctOgo4ICgeMprFXaFMYRcSDAKf34dOhJXX1uX6VvEEEF1e7lKhOSNrDwgBQSzlyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727900554; c=relaxed/simple;
	bh=CdgmQfXkFiRMh3kGVgLfE+7NUsHwzZUnQf7wKIePjx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uBuaqaDlFs2DmZ+pM2KcceJ4zcNA9Y9vtojbVD/NoZulfD2I7ba96HVrpZXohTF8tkOWrqqXQ7r6ANbZ3+Fm01v4oQBcXI2pEl1Y+Ves3yM5OrDFSmOE3l/Fyn2qrFpjEofeEri6okUaLWDZPDXz/s2A7CPU5b8CgnmEbrI8jXs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gLPn9YOw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VA/2THNd; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492J0Xsk021457;
	Wed, 2 Oct 2024 20:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=UuMRFLta2Ej5irW
	HuNG8e6qSLHFTk3D9TrKwTqdmaQ0=; b=gLPn9YOwJnvjG4n5D4CDDzfVibAu8L6
	W3mnwV2IUSJQhHNuPIxrWzXA3KNx3dJVFVZrMQQJmqUjK+TEKEsd13mUagsNWydW
	t2m2o9SIcJu1WDI28KMn6Ttn/SyB7kih4obtW8gF/tF+cB5Ej2kdnWLDHNCiNeoR
	NCtBoQTycsR2YuOiUUMlsDUVUXIs1m/3KzU7liDBaTX2EiY9d5qgaPA+MNqcqUsL
	UQx5/3N9b6GvGmh72ok07NoQeJvoJb58ybHqyG6KDs/HXWEFtoA1bqV7udYJ2TcI
	tchZzb8+jpqQPA8egEh8Ry3IAX/FPlKyq0qpKl8d0HsJiYQiB6NJP8g==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x9p9tdsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 20:22:23 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492JedLp040595;
	Wed, 2 Oct 2024 20:22:23 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x889aqvw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 20:22:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mu8yd+1rR7U2N2Ywb14F/A9hDIV7qEyMcTH9KaPtOwhbZ9+9jdzYF/HDwSiJAlyAl6eaaGuFMZDozfCa0iEfuKbtNpUmUQ8z987hFSsvjTCBrDK43GX6ex2K3h01Oiq8m+dDhoRSI+iY8OaqKb9Lg7EsOQ0SMfLuDakWL9RKG71gQHY5fUKgoVBHYn9jgfz/UH/5W25ObcSdt709Jj2o7Wib78dfw9qBd+jAtXCCEZT4ZhwaNYvQmviRXTccaxiDN6jHfg4zn3ftywsF00r9kP3Qd72RSskJKaX3Ok79DirhKu7ppIMMUJ00fexA3YMN5l3iVbnavk8QnZZA5HiUhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UuMRFLta2Ej5irWHuNG8e6qSLHFTk3D9TrKwTqdmaQ0=;
 b=IoSYuvuo296blDj+3AKsPD2U9KvE7VC5F7du1A1Cj4Se7lojmiZFHNhXbI07Bzyv3EryrpUGNvBAnhfQbJEb1NNNh6x7ofma9IU/sECiidsmupNeh3Z1Yy4Dlsj2R1RfLywtObB5hrmU6vUAMlcYT1bv/rpj5NvRqy8MTjPDC/zQ+Wql4ac5XLXeoLyQ6XIAsOrZgJWKQnzv05OHLRQva46dbiackIsu9RNye369XYXDyO27zmgACwRZ1lRsu9ZGfSkaEG61uR0jsbCHtvVur4mcnx+oniRIUgSo4iJDGQIVnfkdpiEsoPF2iy7EZ9WJdctPx1N95/nlxr0F11yNNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UuMRFLta2Ej5irWHuNG8e6qSLHFTk3D9TrKwTqdmaQ0=;
 b=VA/2THNdsCVW+BKFo2uj5bqggs9vjw9MtICaWYDGMvkgc6f0xwJdpt4+qbb4NEfDBVQGRKqxVP+JVQ8QZCO2Fof5XFrnn3OtkT4jtRc03wkBRlMOamvIQFGS0Twf6LIg/lG9uB7526PATFI4ordY0BNxEP50ovkFguNmU/sO7AE=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MN6PR10MB8143.namprd10.prod.outlook.com (2603:10b6:208:4f5::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 20:22:20 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 20:22:19 +0000
Date: Wed, 2 Oct 2024 21:22:13 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <385da45a-16df-4c8b-ae5e-33734e21f827@lucifer.local>
References: <20241001023402.3374-1-spasswolf@web.de>
 <26991b8a-9fc4-4cf9-99de-048c90e7a683@lucifer.local>
 <32c0bcb3-4f05-4069-ac18-3fc9f76c6f7f@lucifer.local>
 <9d8761c5f32e2bad14b23772378a0a856b51003b.camel@web.de>
 <c63a64a9-cdee-4586-85ba-800e8e1a8054@lucifer.local>
 <cf72fda8-5fc5-437b-a290-6a2c883e6adf@lucifer.local>
 <240ede917b6712021481ab356714977e247036b6.camel@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <240ede917b6712021481ab356714977e247036b6.camel@web.de>
X-ClientProxiedBy: LO4P123CA0356.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::19) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MN6PR10MB8143:EE_
X-MS-Office365-Filtering-Correlation-Id: d3db6363-7345-4a46-0e16-08dce31fea25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XwLfwcCpwaNeNlqx4C2FGcZ0V+IxjnHNSp6km3fbqxx1MYVwftsumGEyZSpp?=
 =?us-ascii?Q?6WIuw4MrPoectImGQEVRjbFeWs6UXv0kMd8II6e+6SSYVFQygFxRWgOHMalV?=
 =?us-ascii?Q?2B7TyRpYUZGO6fMa4NAgVBxu3Wg7qqzq2Bgxq4c4W87Qs8JIe1/JoNl97m19?=
 =?us-ascii?Q?KLiTVUj+lDkHMm+JHe8Rt+Au8z/5p1hXLKNWUsTgXa3Y+yx+UBO5TePZmfGG?=
 =?us-ascii?Q?MlZageh4zGbFXHoViw4QDbjVybGx9N+Tn6UNJyLAGJm99K5bjObdyF8h9nZx?=
 =?us-ascii?Q?9bagzVBtbA7uOyLw3APkjkSFcPTHOs89ZUG0aywMIjAIbRhgHRdX2Uq9HYBY?=
 =?us-ascii?Q?11hvRBOqJUP3qyan3iyW0Gow9lyCEdO2w40utlcyT2jiRlW5Tg5rA/59TS1r?=
 =?us-ascii?Q?PtFx4dL4tGrkpsmnkwcdoabaMUNid3IR0Np9HZvL3Xs7QNTPe0dw5bz8IBPx?=
 =?us-ascii?Q?QeouoMXfnF96hbcIxJ3RyvNNAq9ORHlRPwnQ6c4eVTZfsfezoAHsfs1wcZVs?=
 =?us-ascii?Q?bROZVcbiCcufDknHr80TsAbROXNY39eYMNiEucObFTlNXphe+tydvH4lfXtz?=
 =?us-ascii?Q?gnJ4F61PiktUc/j4t8/agCBpaN6rIex+ZGgt4W8lGMdACuWJAt/qeOUzsaLa?=
 =?us-ascii?Q?CyX/1/WyMSSoPdeYOpIagCSUI/GELv/+AdrFsC1vptEg0oIReVzjn5dg1TrH?=
 =?us-ascii?Q?XD6b1CU7wjGNS+gDn1lyG3G8bv2BhMfrptsIowbHDRbMXdYaqgIFXQOSxIIX?=
 =?us-ascii?Q?kD3tqpQugNGjM3xpCcMbjNb2OBXlOAPs0RtF7Zj0pSdJFlPAVg7rfmFRLeYt?=
 =?us-ascii?Q?ogdDA8shw48R8KxIAakLO/QRMMkGaKYzR85SFxTgLEx6e9c5zPFcovavYMzW?=
 =?us-ascii?Q?04acz0/716c9nf0kwC8EbpP6hI7+dpB5jqM7jIOXhb2k6s/n1WaeymUT+/cY?=
 =?us-ascii?Q?8374RmtkfN7AgQJnnJytKde4R+N5n9dI3D+eeazjyWVuC6mfFJyzybMTLH/P?=
 =?us-ascii?Q?VaHT+1b/UCxz3ti5+kqP18LRv1mKWassscKR0PNrHYbHICzJC/6SPgxhvAaC?=
 =?us-ascii?Q?lAwK5zvKVrRkn1zN85Jw3kjaQcGDvcUMhY4LWbhrmtwl9i4p55FzVQNGBX+y?=
 =?us-ascii?Q?tcnn8dQbpoyKCEs555ygCYQ0DSIMprzGka6CxzOPk8EChiEBw1OAI9D8aE8k?=
 =?us-ascii?Q?G795HCfPM4dC7qSwPBe0wNRtpevRM/4jw7Z4R7iPd+hOofqoGTw1L4YV07iD?=
 =?us-ascii?Q?/wAFEGUm67mxi/oB6FYCWUmSraP5JL4bRwYdnKngRw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?D8YN6rrhXz/Y8Ha+z8tnEVdAA7kQE34vMWx8jSKO5MdgToJZ0f2J24vTS6X9?=
 =?us-ascii?Q?CHppLRiXw3q5RptZ/DF7b0nIsOFa5LxiRcUwA2R8AfzxID/BDCIS+HOY1p/r?=
 =?us-ascii?Q?tPnWckAUJ1JeBILbJUcIOegR3TmJxUxfwu0OYAUAd5+3Zu6+vTLtAhkc7ePq?=
 =?us-ascii?Q?1ZVW1Nc8iyNjwHat8jrwOa8MXwQcrSyw3GlNTkC9YnqmWIOklzzUvqD5Eqae?=
 =?us-ascii?Q?QZ2KRfKGdHVZ7Y7cqrvaHLHjzr/a4PfLuL1QgF0HWsaJg6EOpKdREMVw3nQJ?=
 =?us-ascii?Q?qLkQ0jSdhUDZ/TfcbEcZaYBMiCYpKZrt3QxUVmXQwvNETsHLQyhRuLo6AF3r?=
 =?us-ascii?Q?bzujTf8j3TZd2isLNec4zawyj6Edd9SC3eqvaIPsiYRBMjaWuWBPMEEgKwGa?=
 =?us-ascii?Q?LRF6pIw29KYQXRuWNh+F/JLfL+qEFcoFLE/xkl1mpelSUqq/JFup0uBuuYdv?=
 =?us-ascii?Q?lMzJI3ykaLIlAHlvBh3pj+KyBY+yvAtZGB6TytRaKlGXHougOxSGBk5ELP2R?=
 =?us-ascii?Q?NhBxh6sqTnouPGo8o616rR0STQV6LhRw+14FQz7ZabGWuOpXQYLFfD19rn7T?=
 =?us-ascii?Q?Fla1k0ogIArRRPLYJbcFgK5EWuxGAJTAoCU+B3hYK3PtmKDhOWj2rHPnhTx4?=
 =?us-ascii?Q?MfR2GpjWBw7iwsvHfqWHbROtjernEy1dqRJtL81rEz0zca37bDEOX2VGsCFh?=
 =?us-ascii?Q?5X6aRCNM4ggvvnHRu1roKT6zZSE+uSEd3yUWTvVFiKw/QBbpNExGxtTOsVHJ?=
 =?us-ascii?Q?9mVNp0RCstdmWwazwL2f49eymFVwrdS/KyojjYyIx2XSe/V2pnh0Gtnrf7Eb?=
 =?us-ascii?Q?ot5wPcvZ7Dm6CMn49xhYXR9jQKN1HbUX8LX0lM8WDP0UXtcW+7TlidFX2dNx?=
 =?us-ascii?Q?AuW6hmgYrcCm9hUtii5oR9cK5e+D0TRSYyG0bOM+0z/b4Ee1RoMTcZHgPACb?=
 =?us-ascii?Q?Sduoy+4CCLY+rnWwvl+uam33K2NYKZFXLGi7rEAnjT7DdxfpqAgS9itp1LPq?=
 =?us-ascii?Q?Dmb9lKm9WyxsjYKf8PdK/ImoS/lLTzH/t807aBtmSh91k3uWzrBaPj7jdaGR?=
 =?us-ascii?Q?sMWmf4F7esIyyaDbxTazQIm6ZhbcYuRPD75vBMPvox3KQmHfiVLg+WvdPLhQ?=
 =?us-ascii?Q?WO3qzItvwiPUYznJBi3XTOzIFsJgc6HhDFiQX/52+wcO5mkj0CBqxOB82hWD?=
 =?us-ascii?Q?E4Y3omoY6jWT4BN3saoHVz2xLs/ioI5oChHs402KFTjyaJXyPsx7PIA+V0ts?=
 =?us-ascii?Q?21tG89W/MJG/ov798yQ3XEDO497gNxdnTB3a1zZLhsrr/gb/sI5a8oi8qhhK?=
 =?us-ascii?Q?vv0hRVw6Vv8ThyXYEOYyjCBfrP6qOYZhxD/QRcbkCSsp3MSxT0RckL5CrXqH?=
 =?us-ascii?Q?kwVNKG9oIVnIu9s/R6V8OGNB88E6tgYqyE3dCWkNE3W8MPOkYysbUAd3tzgB?=
 =?us-ascii?Q?0pMM2YZOzW9R0osqt04Ikk9SEQCxOrSvk3w8X60U5fpuSEkZsmRg0suMVLN2?=
 =?us-ascii?Q?+r2R8gcXPuLtN33X+2TzJgD49e6qXJ7HOU603k6JfRqeGrF6U7wYyAggrn4P?=
 =?us-ascii?Q?oYN94by6A/BrLTt7O091incLat+cKKGbkinIAKVudcf8+aWLJgjunuOAPy5n?=
 =?us-ascii?Q?w9kamZ83rlscctiEbqlUoW8CDvnxYNIWwmCrOoaOgYHlgqouR8ijSbz1eyD2?=
 =?us-ascii?Q?cm6RrQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Bo8XB7T8gKqDUpDtlzjUih7Q8Bb0UlSpR8c4s4FYMzhRZmrAN5RkeVAclxt+cxKXjuvHY43/b2Aap7RK1EmfqroCSgnDsAO7xiVJcamqacVE/MjItBnjhVaxdZV1REFMCRhTfVSLzXZJ0crKZsTN23nhddKtwZkqaxoOPztYiom4SpGMhltJHnuJ/bBB8/Jh4IHoNyf0HMXcMpXNlaqXx1WIeu2QvOpaXZUxmKfrLmbQUMAsb6X7H3GQp5bKJCEgfnEajDHQO8O39yOc53yYMvzcee/NDm1jxx2ZJOAd8PJ4p6EDHEar20GwDoqq8/rAQ9pjyr3Z/+qALw1H5Hk0FIr/JzA523GbzKfxi9QBSdfdvs/Y62AxxvYcINR+4tx/LUe2VEreKVXw1gT753bbtavj2MLSm2c9soCs36B2YmTv5dFsiM19ANcUz9vqQS3bIE8sP9MjryKY9j1wIokB6nTRoXoEpQ3hPzbwF0lzQDFTAFg8MMt+3FlIkUk8pJuePWjxoA8ZgXJR2ndEFmhg3bhfTI0UeCn2YS9XRsG+G702sfFAATrDjoW8/fdDdzj0lZ+l5YqL6+AndnvvD1efu/jMxm79fV2btD5t18iwkj0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d3db6363-7345-4a46-0e16-08dce31fea25
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 20:22:19.4114
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ILNZZp/dGr9beYblj0YQH7w2h29Yehi4PF6B2xvA7HMfljfy31LitVUHg6BRHsT/iyd4YnMZeDaUVY/fhbK3GE/KrKP215DoYXE6uQ8ClxQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8143
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_20,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2410020146
X-Proofpoint-ORIG-GUID: YRF1znl_Tl4-Zw40-Nd618IJlWSMAsg1
X-Proofpoint-GUID: YRF1znl_Tl4-Zw40-Nd618IJlWSMAsg1

On Wed, Oct 02, 2024 at 10:06:34PM GMT, Bert Karwatzki wrote:

[snip]

> >
> > diff --git a/mm/internal.h b/mm/internal.h
> > index 93083bbeeefa..cd9414b4651d 100644
> > --- a/mm/internal.h
> > +++ b/mm/internal.h
> > @@ -1443,4 +1443,19 @@ static inline void accept_page(struct page *page)
> >  }
> >  #endif /* CONFIG_UNACCEPTED_MEMORY */
> >
> > +static inline bool check_interesting(unsigned long start, unsigned long end)
> > +{
> > +	const unsigned long interesting_start = 0x1740000;
> > +	/* Include off-by-one on purpose.*/
> > +	const unsigned long interesting_end = 0x68000000 + 1;
>
> In an earlier patch you requested this to be changed to 0x798b1000, is this
> correct?
>

Yes, please leave it as it is for now.

> > +
> > +	/*  interesting_start            interesting_end
> > +	 *          |--------------------------|
> > +	 *           ============================> end
> > +	 *        <=============================   start
> > +	 */
> > +	return end > interesting_start && /* after or overlaps... */
> > +		start < interesting_end;  /* ...overlaps. */
> > +}
> > +
> >  #endif	/* __MM_INTERNAL_H */
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index dd4b35a25aeb..8a1d5c0da86f 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -1341,6 +1341,18 @@ struct vm_area_struct *expand_stack(struct mm_struct *mm, unsigned long addr)
> >  	return vma;
> >  }
> >
> > +static void ljs_dump(struct mm_struct *mm,
> > +		     unsigned long addr, unsigned long len,
> > +		     vm_flags_t vm_flags, bool is_unmap)
> > +{
> > +	if (!check_interesting(addr, addr + len))
> > +		return;
> > +
> > +	pr_err("LJS: %s mm=%p [0x%lx, 0x%lx) [vm_flags=%lu]\n",
> > +	       is_unmap ? "munmap" : "mmap", mm, addr, addr + len,
> > +		vm_flags);
> > +}
> > +
> >  /* do_munmap() - Wrapper function for non-maple tree aware do_munmap() calls.
> >   * @mm: The mm_struct
> >   * @start: The start address to munmap
> > @@ -1354,6 +1366,8 @@ int do_munmap(struct mm_struct *mm, unsigned long start, size_t len,
> >  {
> >  	VMA_ITERATOR(vmi, mm, start);
> >
> > +	ljs_dump(mm, start, len, 0, true);
> > +
> >  	return do_vmi_munmap(&vmi, mm, start, len, uf, false);
> >  }
> >
> > @@ -1375,6 +1389,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	VMA_ITERATOR(vmi, mm, addr);
> >  	VMG_STATE(vmg, mm, &vmi, addr, end, vm_flags, pgoff);
> >
> > +	ljs_dump(mm, addr, len, vm_flags, false);
> > +
> >  	vmg.file = file;
> >  	/* Find the first overlapping VMA */
> >  	vma = vma_find(&vmi, end);
> > @@ -1390,6 +1406,12 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >
> >  		vmg.next = vms.next;
> >  		vmg.prev = vms.prev;
> > +
> > +		if (check_interesting(addr, addr + len))
> > +			pr_err("LJS: prev=[%lx, %lx), next=[%lx, %lx)\n",
> > +			       vmg.prev ? vmg.prev->vm_start : 0, vmg.prev ? vmg.prev->vm_end : 0,
> > +			       vmg.next ? vmg.next->vm_start : 0, vmg.next ? vmg.next->vm_end : 0);
> > +
> >  		vma = NULL;
> >  	} else {
> >  		vmg.next = vma_iter_next_rewind(&vmi, &vmg.prev);
> > @@ -1413,9 +1435,29 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  		vmg.flags = vm_flags;
> >  	}
> >
> > +	if (check_interesting(addr, addr + len)) {
> > +		char *special = vm_flags & VM_SPECIAL ? "special" : "";
> > +		char *has_file = file ? "file-backed" : "";
> > +
> > +		pr_err("LJS: Interesting [%lx, %lx) flags=%lu, special=[%s] file=[%s]\n",
> > +		       addr, addr+len, vm_flags, special, has_file);
> > +	}
> > +
> >  	vma = vma_merge_new_range(&vmg);
> > -	if (vma)
> > +	if (vma) {
> > +		if (check_interesting(addr, addr + len)) {
> > +			pr_err("LJS: Merged to [%lx, %lx), addr=%lx, end=%lx\n",
> > +			       vma->vm_start, vma->vm_end, vma_iter_addr(&vmi),
> > +			       vma_iter_end(&vmi));
> > +
> > +			mt_validate(&mm->mm_mt);
> > +		}
> > +
> >  		goto expanded;
> > +	} else if (check_interesting(addr, addr + len)) {
> > +		pr_err("LJS: Failed to merge [%lx, %lx), reset...\n",
> > +		       addr, addr + len);
> > +	}
> >  	/*
> >  	 * Determine the object being mapped and call the appropriate
> >  	 * specific mapper. the address has already been validated, but
> > @@ -1441,6 +1483,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  		if (error)
> >  			goto unmap_and_free_vma;
> >
> > +		if (check_interesting(addr, addr + len)) {
> > +			pr_err("LJS: call_mmap() on [%lx, %lx) old_flags=%lu new_flags=%lu new range=[%lx, %lx)\n",
> > +			       addr, addr + end, vm_flags, vma->vm_flags, vma->vm_start, vma->vm_end);
> > +		}
> > +
> >  		if (vma_is_shared_maywrite(vma)) {
> >  			error = mapping_map_writable(file->f_mapping);
> >  			if (error)
> > @@ -1467,6 +1514,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  			/* If this fails, state is reset ready for a reattempt. */
> >  			merge = vma_merge_new_range(&vmg);
> >
> > +			if (check_interesting(addr, addr + len))
> > +				pr_err("LJS: flags changed for [%lx, %lx) from %lu to %lu %s",
> > +				       vma->vm_start, vma->vm_end, vm_flags, vma->vm_flags,
> > +				       merge ? "merged" : "");
> > +
> >  			if (merge) {
> >  				/*
> >  				 * ->mmap() can change vma->vm_file and fput
> > @@ -1510,10 +1562,18 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >
> >  	/* Lock the VMA since it is modified after insertion into VMA tree */
> >  	vma_start_write(vma);
> > +
> > +	if (check_interesting(addr, addr + len))
> > +		pr_err("LJS: mm=%p: iter store addr=%lx, end=%lx, vma=[%lx, %lx)\n",
> > +		       mm, vma_iter_addr(&vmi), vma_iter_end(&vmi), vma->vm_start, vma->vm_end);
> > +
> >  	vma_iter_store(&vmi, vma);
> >  	mm->map_count++;
> >  	vma_link_file(vma);
> >
> > +	if (check_interesting(addr, addr + len))
> > +		mt_validate(&mm->mm_mt);
> > +
> >  	/*
> >  	 * vma_merge_new_range() calls khugepaged_enter_vma() too, the below
> >  	 * call covers the non-merge case.
> > @@ -1530,6 +1590,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> >  	perf_event_mmap(vma);
> >
> >  	/* Unmap any existing mapping in the area */
> > +
> > +	if (check_interesting(addr, addr + len))
> > +		mt_validate(&mm->mm_mt);
> > +
> >  	vms_complete_munmap_vmas(&vms, &mas_detach);
> >
> >  	vm_stat_account(mm, vm_flags, pglen);
> > diff --git a/mm/vma.c b/mm/vma.c
> > index 4737afcb064c..33f80e82704b 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -1108,8 +1108,13 @@ void vms_clean_up_area(struct vma_munmap_struct *vms,
> >  	vms_clear_ptes(vms, mas_detach, true);
> >  	mas_set(mas_detach, 0);
> >  	mas_for_each(mas_detach, vma, ULONG_MAX)
> > -		if (vma->vm_ops && vma->vm_ops->close)
> > +		if (vma->vm_ops && vma->vm_ops->close) {
> > +			if (check_interesting(vma->vm_start, vma->vm_end))
> > +				pr_err("LJS: mm=%p Closing [%lx, %lx)\n",
> > +				       vma->vm_mm, vma->vm_start, vma->vm_end);
> > +
> >  			vma->vm_ops->close(vma);
> > +		}
> >  	vms->closed_vm_ops = true;
> >  }
> >
> > @@ -1179,6 +1184,10 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
> >  	struct vm_area_struct *next = NULL;
> >  	int error;
> >
> > +	if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
> > +		pr_err("LJS2 vms->start=%lx, vms->vma->vm_start=%lx\n",
> > +		       vms->start, vms->vma->vm_start);
> > +
> >  	/*
> >  	 * If we need to split any vma, do it now to save pain later.
> >  	 * Does it split the first one?
> > @@ -1202,6 +1211,11 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
> >  			goto start_split_failed;
> >  		}
> >
> > +		if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
> > +			pr_err("LJS: mm=%p vms=[%lx, %lx) split START of [%lx, %lx)\n",
> > +			       vms->vma->vm_mm, vms->start, vms->end,
> > +			       vms->vma->vm_start, vms->vma->vm_end);
> > +
> >  		error = __split_vma(vms->vmi, vms->vma, vms->start, 1);
> >  		if (error)
> >  			goto start_split_failed;
> > @@ -1217,12 +1231,23 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
> >  	for_each_vma_range(*(vms->vmi), next, vms->end) {
> >  		long nrpages;
> >
> > +		if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
> > +			pr_err("LJS: mm=%p vms=[%lx, %lx) UNMAP [%lx, %lx)\n",
> > +			       vms->vma->vm_mm, vms->start, vms->end,
> > +			       next->vm_start, next->vm_end);
> > +
> >  		if (!can_modify_vma(next)) {
> >  			error = -EPERM;
> >  			goto modify_vma_failed;
> >  		}
> >  		/* Does it split the end? */
> >  		if (next->vm_end > vms->end) {
> > +
> > +			if (check_interesting(next->vm_start, next->vm_end))
> > +				pr_err("LJS: mm=%p vms=[%lx, %lx) split END of [%lx, %lx)\n",
> > +				       next->vm_mm, vms->start, vms->end,
> > +				       next->vm_start, next->vm_end);
> > +
> >  			error = __split_vma(vms->vmi, next, vms->end, 0);
> >  			if (error)
> >  				goto end_split_failed;
> > @@ -1295,9 +1320,14 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
> >  	}
> >  #endif
> >
> > -	while (vma_iter_addr(vms->vmi) > vms->start)
> > +	while (vma_iter_addr(vms->vmi) > vms->start) {
> >  		vma_iter_prev_range(vms->vmi);
> >
> > +		if (check_interesting(vms->vma->vm_start, vms->vma->vm_end))
> > +			pr_err("LJS3: addr=%lx, vms->start=%lx\n",
> > +			       vma_iter_addr(vms->vmi), vms->start);
> > +	}
> > +
> >  	vms->clear_ptes = true;
> >  	return 0;
> >
> > --
> > 2.46.2
>
> I just tested the "hunch" commit (without this patch) and it crashed in the same
> way. Here are more detailed instructions of how I create the crash:
>
> The game used is Rogue Heroes: Ruins of Tasos (which is basically Zelda). The
> game itself does not work anymore (even on unaffected kernel versions), it has
> been crashing with a
>
> Unhandled Exception:
> Microsoft.Xna.Framework.Graphics.NoSuitableGraphicsDeviceException: Failed to
> create graphics device! ---> System.TypeInitializationException: The type
> initializer for 'Microsoft.Xna.Framework.Graphics.GraphicsAdapter' threw an
> exception. ---> SharpDX.SharpDXException: HRESULT: [0x80004005], Module:
> [General], ApiCode: [E_FAIL/Unspecified error], Message: Call failed.
>
> error for sometime (probably a year).
>
> 1. Go to Properties->Compatibility and select "Force the use of specific Steam
> Play compatibility tool" and the select Proton 7.0-6
> 2. start the game, the game should then crash with the Xna error above
> 3. Go to Properties->Compatibility and unselect "Force the use of specific Steam
> Play compatibility tool"
> 4. start the game again, this will usually give the vma error (on two occasions
> so far the whole procedure (1-4) had to be done twice to get the error.
>

Thanks for this, however the game does work for me, at least on nvidia :)) I
continue to suspect an amd-specific issue here. I will try on my intel gpu
laptop too.

> Bert Karwatzki
>

