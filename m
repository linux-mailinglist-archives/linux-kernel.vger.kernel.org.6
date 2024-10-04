Return-Path: <linux-kernel+bounces-350053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E0898FF29
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 11:00:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC9C01F226AF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 09:00:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1F7A12D20D;
	Fri,  4 Oct 2024 09:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UyuOQdRO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fT4Gu+AJ"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152262421D
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 09:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728032415; cv=fail; b=JJksrIKseRjbeUyhvjAi6KgbfxxwH+DtXlM7iGD8xDaTxN9DXUvtLqX5HtrPIWf+CmHnoU0RoyUEKXNeahoe8YVHZQ5vqiU76pH5iuTy5VfnPL6JLL/OzdetuDaEk7r2UTPqcu9Ytxl79CG0oRuAKtZhFF8PTotSMhdoqm1sK6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728032415; c=relaxed/simple;
	bh=BzGUDgikFvNPnTuOSmKb2YjjJnJuqrFCpXNGLn47S4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FZvKJRjcZPB1y7Vahl0diiL7te88JT0l2iHu1s9VL6w7ZJu+DMsNyl0Z7mSSndU0vnRRdFgk2/h62ExUDDh9I5Y9aMH5s3gG2v5WRzraO4PQOEbb53ZoTvAiqXeoYWv1XPmVKqrtQuTDldX9uRzdsmVgYuv3h/pI1DnyROri650=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UyuOQdRO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fT4Gu+AJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4947tcl6025925;
	Fri, 4 Oct 2024 09:00:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=pzGdxOhLXT6et6P
	LEyveEyFZ3YgxkNcQiu215o0I6oA=; b=UyuOQdROqgg7OqEauLmjEl1qF1l3nOS
	a3P7yHVJNWpPgNyKMI7VggU1XFvM4ej/cRGUTpJS9fVn1H4F6HfwMBDoj4UeO0jH
	T095KeZKbhqiLD27Vhot7SEf+SSd1fnvnzLmQ2fS+3Ttu+JzC4qnMrS0vQJ4m6Y0
	1plxkooJOSCnKOyRKitTLI0rnNiBLEDsGhkhcwWNYyzOYAbnvQjhuVDAyrEmCTNn
	ht7Vj16rZHB/6J5F2f5GCh00Lz52djR6wDKIUkkTW6Cg9wJjSuGac5JebOJGYPcI
	gGXBuhwLV+EaqdJbgOL3bP0If7a6tYBgxl6rvWS8s8cTF01yZ5N670Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42204fs7dv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 09:00:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4948j4OR026309;
	Fri, 4 Oct 2024 09:00:04 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422055gpwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 09:00:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HW1dx5lfeyoakIypxtMq8nSL/30wrSLv68K3YNdbIAUXubYmvdMMw/ZIhmBzCUQYn8KF3ihif0i6k8yxiyDbb+HgYR6s672qRXP8iKfJEBydCkLRCZOtpNcXMLi5Ik6tPJAz8I2D8FhZhY2Z8LzebgN3UnxrxZEXhlGgnn/1ZyetnBHmfkfvF4ejMx94VNe0NcZHKJjIpJU0KKuzJf4tA7RDfVWWXjucX4H5CJQ4jR/am52Fyvbz7B7Wy3QagHW0/hOz/IHvVR2hgpBmWqTPbPoxfmiUOunwoc/O3Fk8HaicSnPgn8Lp0d1L5t8LgGtuhMCpL3RjiSGSt4sfffEWPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzGdxOhLXT6et6PLEyveEyFZ3YgxkNcQiu215o0I6oA=;
 b=lkRjn/d2Cs4yJbIXenJ1D5zMaUlQ48QSUUOejC/CIqoL3uDiKI3vT7B1rrGBNtsTS2Jm78bclSVcZu3fkKiYTbpZF3YtYyVoPjiza1RAyKaKFuIkYcLvYGzLtb3YpML2pkaUwkJf8RLba54zstb/+EG3aP0bVoYzD7P80Jo2fLLG89Vpt6f7XY/dBu+i8M/z4JV39MepahxIaAZjntgmabCaE4+cNn/bcJD5Zx46F5tft4wJJZ0rMdSMFZoMIccGinIA7+01v1G94BUvMDJBgE9zIBAjWLEX4RhfDG2KPm6lGLqhflyBABmASOsmCTYT53eiaClaDwaUxl4Ym2mnXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzGdxOhLXT6et6PLEyveEyFZ3YgxkNcQiu215o0I6oA=;
 b=fT4Gu+AJmqBsSwLAdWH72XlC5qStpIjdKlciyRJa1vy6wBXW+OZnpPDSmxcf/Kos7Ur792k10JskPMR5hab7ItOwoE7Lb1zQgKi1wMRNGpTGsQMuCedhu9VkY0sAzECympXjMc4LyUj83UIq7bBDf54qwAUPsvOD7W3FDEH+Iek=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by IA0PR10MB7230.namprd10.prod.outlook.com (2603:10b6:208:403::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 09:00:02 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.017; Fri, 4 Oct 2024
 09:00:02 +0000
Date: Fri, 4 Oct 2024 09:59:57 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <f11063be-7a06-43c2-9695-8dd03ed810f4@lucifer.local>
References: <20241004085107.3165-1-spasswolf@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241004085107.3165-1-spasswolf@web.de>
X-ClientProxiedBy: LO4P123CA0270.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::23) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|IA0PR10MB7230:EE_
X-MS-Office365-Filtering-Correlation-Id: eac32a60-7c7c-4aeb-d6eb-08dce452ee5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XTjzEgbEPnE2mp8IOr+17Cik7ylDUPy+weGznWm1z0W5Q7OdmZ26OrWciyMX?=
 =?us-ascii?Q?mBuainrOnsaicPAzRoL54eLkCrd8hdM3K+Io9YuQkA9Y9D4CC2TDVvSk/Y7f?=
 =?us-ascii?Q?EC4WGHPIrBEtH6kLLovSiNbWYvMa4X9gjmCBEu8j3gBr09bUyXx1kHrBqG87?=
 =?us-ascii?Q?jwSr+rEyeSnjUz+sVtZeIhY9HBtDHCNybUzH4lZqpr5IhPmFvdeRREqLHhPc?=
 =?us-ascii?Q?uab+IAFD09SIZ6nRkE2XBrMgVI+7bWiiskVhqLJtrdShyX4T54X/L8x4C2ic?=
 =?us-ascii?Q?iQZ2JxcGC813EszFq4IZ2MJKobnLvugmEdTthplbZ8hV6TNLEvH+lgckI7mF?=
 =?us-ascii?Q?gM5jbZMgc7KzuWppZ2xcZIMEXPoGs3wArNL5nVSinCM2E8op5Uh+/c0UBwB6?=
 =?us-ascii?Q?xWAplG2IKofxtNqHgU0/ft52m+9cCuNxOuS4Byz1a8oopxcgsHa2aGjBjgRU?=
 =?us-ascii?Q?wTWyrLsGC+g6oqqjpFax75UIEcSxJCutvQgPifRhcPFGGhaIXZnkpPpGcLZ9?=
 =?us-ascii?Q?mjaCpP543eJxXMSP/y+8Gz+z7chsrct1nRwdBx7wcYX9/zL03TJG3+aHOMAi?=
 =?us-ascii?Q?FwM58DNZkoPcKIsOKWj2bOTPxCHh+jg3K6ur/rYzLNI7VXm64ucgTxRQPnRh?=
 =?us-ascii?Q?5ENEk60mw+1CaDXKHqljuVhdhxfaL+7yKBtwIu/naimajCgl6VVl8vD8uUnf?=
 =?us-ascii?Q?DSMSB6kJNKI20z2OUeZghrOQjMo+NXsb7PRJ/jWrJcjrgcnimYT4G7mTtflE?=
 =?us-ascii?Q?//FpcpzaNzWY7pDKOeSiPgpLiwW1j5hyrHlTaMFh5YvRSZjv1jAypvpJNvBV?=
 =?us-ascii?Q?5s3ytpv4iRHyD+uoFCP1VABDgubQ9PBixy3s749Ost51bytrvXvOTPV9cZuP?=
 =?us-ascii?Q?t5Qzp/wl8y//rH5K4G+gmFdarAxwfdaIzGN/luUPf5heZIWRQPazf7MUDW1y?=
 =?us-ascii?Q?Qi5/Y3IgHEFl1NLHmhEpAVjU2MNVUY341FHd3Z4/IPxDPNOxvOm94hjeCxB5?=
 =?us-ascii?Q?relWKM5BNWOVbJIj2nMEtcQ8ezS55GJnyGBEcdwLnePO2VURkbdGRHnTJNW+?=
 =?us-ascii?Q?8EJ+S20PA6bDkCkr3i+3Iw/KBpuBYw2tMU3EeW3WcP/dHlrhw1K23CK0n2sn?=
 =?us-ascii?Q?4AhSG/bYiD6rN0QgUuFJinsQKEUF/ZugpPx40QnCX0fEej0ZAl+Ad3LxCHJp?=
 =?us-ascii?Q?NOWTf/XPsXsY76282TkCjjTsC2H88p60waQ8WZru7gqJWKaaXbQlDzuWgCKJ?=
 =?us-ascii?Q?2DZENAxdKqbZu45hxbCEtMnyjmgnyzFomW3o+U3fKQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hLZ94ecAF5eWiM/1aI+pBG48mVD1xEVzf6rJsB48EgzCLPBS19WIVhebJHyt?=
 =?us-ascii?Q?4x3Z9XxAGzy7ZkS0JvnZ5p6Sog4nq61YTBHobzudYHblVSLx3OLL1xn3ehKJ?=
 =?us-ascii?Q?yckWqbTiNDkK5Rm5zaFvyLwlRFfyagmeFv6p1kpbYACaaitZXbt1IhuvqctG?=
 =?us-ascii?Q?ozxafYIAqn+lybov0Lgt51HRAXY/ArNPvmtf85NwI/Go7/qK344dP7FWX3Uy?=
 =?us-ascii?Q?kBfG4Flzwi8hv4ChwJekkDyffCzSN0uG4RyroVOcdadU0XY2Wm3g1n0IVGG5?=
 =?us-ascii?Q?Oi6ZyQFblP6yUjEcusPHFNj1KmyqRYODF9KYSxEkirj65b3ACrI+Y6s81MlU?=
 =?us-ascii?Q?PoNhLeTAc8qV9Qpjyxbo1IdOWEb702QOdDUsDf4oq7XWLrRmDJ4ycznldWDy?=
 =?us-ascii?Q?w0R3D7jbonqo+qIrvKkVB7rh1hapPLITN4OLqqtEeEiilQ/DUofwpF1B0bko?=
 =?us-ascii?Q?zj5k33D5I2Ux0nw7cUF7wW8QDt8cKXrbqNSf34FMPJ89i2Zrgi2hJcv+Pggn?=
 =?us-ascii?Q?IOxMBSXTeBZbC60uIVgOsADNTpHnF7xz8Vc8eYJUMmyiK+W3iKQ7sE2WN67t?=
 =?us-ascii?Q?rhD+4Z7+166WBYWQCiwSZnFDbLMgxITQTKOk8sddkANrm5kzNIv+ggahz6/F?=
 =?us-ascii?Q?a50WYfbTZjLSmMPx6ZwTaKZ0Y5QioeyZGuHG47ouTaNuCIO3gRKXmV/4lxKr?=
 =?us-ascii?Q?BAOJ0G6HOT02E57UzhkafgKaZmSo3tHeDn5EEkkw+Ev2gCA1s62m9Oqmc5J9?=
 =?us-ascii?Q?I6dfmnyEup201C8LurU4rEjfaqg7fXq0IdEkxHdZmyAqYk5fNWfKF49FaNgY?=
 =?us-ascii?Q?munr/ys1U7OoRdmHdzW+MBKHKwXKpsMKnoXsygDC/13m13Tsr5YI/IqdxVGH?=
 =?us-ascii?Q?AMqV4/Ljj1PGDIITyi31w+keDNr5VvLTQUOGHTbwqhYF0d06iB1ljdWV5lwd?=
 =?us-ascii?Q?J88UChKb5/Q9ez9hQIC2GJRWDLuzo11MUnZtBZ5gkIniE2RKwg/hpE1pWAEH?=
 =?us-ascii?Q?/0eKbRd5p4g7mmQHIEJ3g+u59f0/77gow6lAohwksEY/M3ZDMulJ+YzFStid?=
 =?us-ascii?Q?yTpUefOteGwo/mCcAPcCfvDYwEM7DivcA2j0ZARyrbkscbMH1hXu9ZXQdD9K?=
 =?us-ascii?Q?Dw3m4Yw+J1s8a+pbNE99YTSw1vt4irYVG/dtc1opFg30bfLnnYvQ6llSpaTZ?=
 =?us-ascii?Q?9IqmrtG3XaZhmau/LO08R0YqLjGGiPs4RcXip3KilgfW8LFhaJJe01Jj1dAN?=
 =?us-ascii?Q?B8r4tPfn2YHIHbWFRb8oaDm1kLOkWaGNb2ft9CXknpTHXgrfJOdvMo4bKjSn?=
 =?us-ascii?Q?1zFrJERY/+iPOwA0eN83rLY077EDNW2hPHpMovd4FjWlNikBQ51t1u4m5o14?=
 =?us-ascii?Q?zpyhMehAJoFCofQUXqHF2ISgHbwhQNMbnx9zAieIU2umqWq8+KPIGkM7RfXj?=
 =?us-ascii?Q?33aOjpBxbYljrSYrodVmC3oSRTSSa4FJxgP66l2B1wuGFQGt274nLrvsR1U9?=
 =?us-ascii?Q?AvYY57TsNzIIjWkJrExxowg5sL0EpaUFDDXhHBMqxZZmQCvLaCUE5GGhLvDA?=
 =?us-ascii?Q?IrAay4Ty4cio0QVM2duHjxam+xzcJIir18jL0LzTqA6Unbl2kY7JcSQj2kUl?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/rRD5ebbCdK+d1Yr/1ap7ZAo7cWB8MA14+jGcftW9YlCDzl6xBFAzoD1noiH5H7Bbnemj8OWZKI2DZNmgI2oREysPI4HVvSui0n8pYSP726TCG+Kz95J39EoC0fHjMHDEIMxWoXUgfUIrLqotpBrK2QGlGz2OE5p0ZKwa+8FXfHXREKE7Te9Vhz9Snr2S1bu84VwgWZR7jJb8c8TIk0BZHdfTJpc432LzrSk7aEuUQj/D82wh5Tzl3BaWC0NuIQn/7iPehJfiLN2ZgJvTFB/AUEVuuk6TdpLza1P3UwH7+HHBUpU0UsLPW0fTinjCTdt0e6T2jweIVqacg3tI9zzXQVN3OLoTxsq14QLaBPzZMGD69VDQCaT8JFPCV0FMXo5vj+/lszIvAiJPVSkUyBmIw86xLbIz5tJgYfZZ0fEeYZTL0o1mHJyVVfqwyPBOs3PzKQ++9JnRstzKKtKIOUtZY6ymNNP4DNZFlIimP30F6VrhsEuTGZ8gJe+0H+I01mmPoBJJkn6QhHxhwkQByKoUc9PsDeqDs9189+09nc2l1vpBFN7c4my9Ehbpk6xOrEfoyfPfk/oelrWNEHZq9FUFto1Ls+S+v7i+vcluzwHaRY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eac32a60-7c7c-4aeb-d6eb-08dce452ee5c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 09:00:01.9713
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vbOwdv8xJoNmmQhzpxpT1d8lJh+SwBB5+VsLsY24Nk2fdR1queW1Xlqh5I05qENgKlVAQ8kcYOsQPhWUY70yDxcDk+iVhF8y6+NXx4X95vE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7230
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040064
X-Proofpoint-GUID: BRvLu_huQVU2PopfJ_6kQAzDxdACEwYb
X-Proofpoint-ORIG-GUID: BRvLu_huQVU2PopfJ_6kQAzDxdACEwYb

On Fri, Oct 04, 2024 at 10:51:05AM +0200, Bert Karwatzki wrote:
> As a sidenode I've tried to figure out the minimal patch it takes to trigger the
> crash. The first commit that triggers the bug is f8d112a4e657 ("mm/mmap: avoid
> zeroing vma tree in mmap_region()") so I split this commit into two parts, the
> first part gives a working kernel while the second part gives the bug.
>
> First part (to be applied on top of commit 94f59ea591f
> ("mm: clean up unmap_region() argument list") in linux-next):
> From efdd914b012b35d34d1cae469f199023e82f7a15 Mon Sep 17 00:00:00 2001
> From: Bert Karwatzki <spasswolf@web.de>
> Date: Thu, 3 Oct 2024 23:59:30 +0200
> Subject: [PATCH 1/2] mm: mmap: Prepare to avoid zeroing vma tree in
>  mmap_region()
>
> In an attempt to create a minimal patch to trigger the mapletree
> bug apply parts of patch [v8 14/21] which still give a working kernel.
>

Thanks, this aligns with expectations as 'zeroing' the range will collapse
the overwritten VMA entries and render the subsequent merge trivial.

It seems to be the state of the maple tree that's the issue, it appears to
be fine, then we attempt the merge (and the store), and this triggers the
issue.

The v5 version of the printk patch which eliminates kernel pointer hashing
in the dumps should give us hopefully enough information to repro the tree,
as otherwise all attempts to do so have failed (this is a very, very
stubborn problem).

Kernel pointer hashing is an issue here because the dumping code uses %p to
output entries, including the last entry that stores the number of entries
(so we have no way of validating what this is) and also some pointers like
the parent pointer are tagged, so the tagging causes the hash to generate a
meaningless value.

So at this point we definitely need this (and I will write a patch to make
the debug code not hash here too I think :)

Thanks again for all your efforts, all much appreciated!


> Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> ---
>  mm/mmap.c | 39 ++++++++++++++++++---------------------
>  mm/vma.c  | 54 ++++++++++++++++++++++++++++++++++++++++++------------
>  mm/vma.h  | 22 ++++++++++++++++------
>  3 files changed, 76 insertions(+), 39 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index 304dc085533a..da9bfb899eec 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1373,23 +1373,19 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	unsigned long merge_start = addr, merge_end = end;
>  	bool writable_file_mapping = false;
>  	pgoff_t vm_pgoff;
> -	int error;
> +	int error = -ENOMEM;
>  	VMA_ITERATOR(vmi, mm, addr);
> +	unsigned long nr_pages, nr_accounted;
>
> -	/* Check against address space limit. */
> -	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT)) {
> -		unsigned long nr_pages;
> +	nr_pages = count_vma_pages_range(mm, addr, end, &nr_accounted);
>
> -		/*
> -		 * MAP_FIXED may remove pages of mappings that intersects with
> -		 * requested mapping. Account for the pages it would unmap.
> -		 */
> -		nr_pages = count_vma_pages_range(mm, addr, end);
> -
> -		if (!may_expand_vm(mm, vm_flags,
> -					(len >> PAGE_SHIFT) - nr_pages))
> -			return -ENOMEM;
> -	}
> +	/*
> +	 * Check against address space limit.
> +	 * MAP_FIXED may remove pages of mappings that intersects with requested
> +	 * mapping. Account for the pages it would unmap.
> +	 */
> +	if (!may_expand_vm(mm, vm_flags, (len >> PAGE_SHIFT) - nr_pages))
> +		return -ENOMEM;
>
>  	/* Find the first overlapping VMA */
>  	vma = vma_find(&vmi, end);
> @@ -1410,6 +1406,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>
>  		/* Unmap any existing mapping in the area */
>  		vms_complete_munmap_vmas(&vms, &mas_detach);
> +		vms.vma_count = 0;
>  		next = vms.next;
>  		prev = vms.prev;
>  		vma = NULL;
> @@ -1425,8 +1422,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	 */
>  	if (accountable_mapping(file, vm_flags)) {
>  		charged = len >> PAGE_SHIFT;
> +		charged -= nr_accounted;
>  		if (security_vm_enough_memory_mm(mm, charged))
> -			return -ENOMEM;
> +			goto clear_tree_failed;
> +		vms.nr_accounted = 0;
>  		vm_flags |= VM_ACCOUNT;
>  	}
>
> @@ -1475,10 +1474,8 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	 * not unmapped, but the maps are removed from the list.
>  	 */
>  	vma = vm_area_alloc(mm);
> -	if (!vma) {
> -		error = -ENOMEM;
> +	if (!vma)
>  		goto unacct_error;
> -	}
>
>  	vma_iter_config(&vmi, addr, end);
>  	vma_set_range(vma, addr, end, pgoff);
> @@ -1605,7 +1602,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	return addr;
>
>  close_and_free_vma:
> -	if (file && vma->vm_ops && vma->vm_ops->close)
> +	if (file && !vms.closed_vm_ops && vma->vm_ops && vma->vm_ops->close)
>  		vma->vm_ops->close(vma);
>
>  	if (file || vma->vm_file) {
> @@ -1627,7 +1624,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>
>  clear_tree_failed:
>  	if (vms.vma_count)
> -		abort_munmap_vmas(&mas_detach);
> +		abort_munmap_vmas(&mas_detach, false);
>  gather_failed:
>  	validate_mm(mm);
>  	return error;
> @@ -1960,7 +1957,7 @@ void exit_mmap(struct mm_struct *mm)
>  	do {
>  		if (vma->vm_flags & VM_ACCOUNT)
>  			nr_accounted += vma_pages(vma);
> -		remove_vma(vma, true);
> +		remove_vma(vma, /* unreachable = */ true, /* closed = */ false);
>  		count++;
>  		cond_resched();
>  		vma = vma_next(&vmi);
> diff --git a/mm/vma.c b/mm/vma.c
> index 83c5c46c67b9..648c58da8ad4 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -136,10 +136,10 @@ can_vma_merge_after(struct vm_area_struct *vma, unsigned long vm_flags,
>  /*
>   * Close a vm structure and free it.
>   */
> -void remove_vma(struct vm_area_struct *vma, bool unreachable)
> +void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed)
>  {
>  	might_sleep();
> -	if (vma->vm_ops && vma->vm_ops->close)
> +	if (!closed && vma->vm_ops && vma->vm_ops->close)
>  		vma->vm_ops->close(vma);
>  	if (vma->vm_file)
>  		fput(vma->vm_file);
> @@ -521,7 +521,6 @@ int vma_expand(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	vma_iter_store(vmi, vma);
>
>  	vma_complete(&vp, vmi, vma->vm_mm);
> -	validate_mm(vma->vm_mm);
>  	return 0;
>
>  nomem:
> @@ -645,11 +644,14 @@ void vma_complete(struct vma_prepare *vp,
>  		uprobe_mmap(vp->insert);
>  }
>
> -static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
> -		struct ma_state *mas_detach, bool mm_wr_locked)
> +static inline void vms_clear_ptes(struct vma_munmap_struct *vms,
> +		    struct ma_state *mas_detach, bool mm_wr_locked)
>  {
>  	struct mmu_gather tlb;
>
> +	if (!vms->clear_ptes) /* Nothing to do */
> +		return;
> +
>  	/*
>  	 * We can free page tables without write-locking mmap_lock because VMAs
>  	 * were isolated before we downgraded mmap_lock.
> @@ -658,11 +660,31 @@ static void vms_complete_pte_clear(struct vma_munmap_struct *vms,
>  	lru_add_drain();
>  	tlb_gather_mmu(&tlb, vms->mm);
>  	update_hiwater_rss(vms->mm);
> -	unmap_vmas(&tlb, mas_detach, vms->vma, vms->start, vms->end, vms->vma_count, mm_wr_locked);
> +	unmap_vmas(&tlb, mas_detach, vms->vma, vms->start, vms->end,
> +		   vms->vma_count, mm_wr_locked);
> +
>  	mas_set(mas_detach, 1);
>  	/* start and end may be different if there is no prev or next vma. */
> -	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start, vms->unmap_end, mm_wr_locked);
> +	free_pgtables(&tlb, mas_detach, vms->vma, vms->unmap_start,
> +		      vms->unmap_end, mm_wr_locked);
>  	tlb_finish_mmu(&tlb);
> +	vms->clear_ptes = false;
> +}
> +
> +void vms_clean_up_area(struct vma_munmap_struct *vms,
> +		struct ma_state *mas_detach, bool mm_wr_locked)
> +{
> +	struct vm_area_struct *vma;
> +
> +	if (!vms->nr_pages)
> +		return;
> +
> +	vms_clear_ptes(vms, mas_detach, mm_wr_locked);
> +	mas_set(mas_detach, 0);
> +	mas_for_each(mas_detach, vma, ULONG_MAX)
> +		if (vma->vm_ops && vma->vm_ops->close)
> +			vma->vm_ops->close(vma);
> +	vms->closed_vm_ops = true;
>  }
>
>  /*
> @@ -686,7 +708,10 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
>  	if (vms->unlock)
>  		mmap_write_downgrade(mm);
>
> -	vms_complete_pte_clear(vms, mas_detach, !vms->unlock);
> +	if (!vms->nr_pages)
> +		return;
> +
> +	vms_clear_ptes(vms, mas_detach, !vms->unlock);
>  	/* Update high watermark before we lower total_vm */
>  	update_hiwater_vm(mm);
>  	/* Stat accounting */
> @@ -702,7 +727,7 @@ void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
>  	/* Remove and clean up vmas */
>  	mas_set(mas_detach, 0);
>  	mas_for_each(mas_detach, vma, ULONG_MAX)
> -		remove_vma(vma, false);
> +		remove_vma(vma, /* = */ false, vms->closed_vm_ops);
>
>  	vm_unacct_memory(vms->nr_accounted);
>  	validate_mm(mm);
> @@ -846,13 +871,14 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>  	while (vma_iter_addr(vms->vmi) > vms->start)
>  		vma_iter_prev_range(vms->vmi);
>
> +	vms->clear_ptes = true;
>  	return 0;
>
>  userfaultfd_error:
>  munmap_gather_failed:
>  end_split_failed:
>  modify_vma_failed:
> -	abort_munmap_vmas(mas_detach);
> +	abort_munmap_vmas(mas_detach, /* closed = */ false);
>  start_split_failed:
>  map_count_exceeded:
>  	return error;
> @@ -897,7 +923,7 @@ int do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	return 0;
>
>  clear_tree_failed:
> -	abort_munmap_vmas(&mas_detach);
> +	abort_munmap_vmas(&mas_detach, /* closed = */ false);
>  gather_failed:
>  	validate_mm(mm);
>  	return error;
> @@ -1615,17 +1641,21 @@ bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot)
>  }
>
>  unsigned long count_vma_pages_range(struct mm_struct *mm,
> -				    unsigned long addr, unsigned long end)
> +		unsigned long addr, unsigned long end,
> +		unsigned long *nr_accounted)
>  {
>  	VMA_ITERATOR(vmi, mm, addr);
>  	struct vm_area_struct *vma;
>  	unsigned long nr_pages = 0;
>
> +	*nr_accounted = 0;
>  	for_each_vma_range(vmi, vma, end) {
>  		unsigned long vm_start = max(addr, vma->vm_start);
>  		unsigned long vm_end = min(end, vma->vm_end);
>
>  		nr_pages += PHYS_PFN(vm_end - vm_start);
> +		if (vma->vm_flags & VM_ACCOUNT)
> +			*nr_accounted += PHYS_PFN(vm_end - vm_start);
>  	}
>
>  	return nr_pages;
> diff --git a/mm/vma.h b/mm/vma.h
> index 82ba48174341..64b44f5a0a11 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -48,6 +48,8 @@ struct vma_munmap_struct {
>  	unsigned long stack_vm;
>  	unsigned long data_vm;
>  	bool unlock;                    /* Unlock after the munmap */
> +	bool clear_ptes;                /* If there are outstanding PTE to be cleared */
> +	bool closed_vm_ops;		/* call_mmap() was encountered, so vmas may be closed */
>  };
>
>  #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
> @@ -96,14 +98,13 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
>  		unsigned long start, unsigned long end, struct list_head *uf,
>  		bool unlock)
>  {
> +	vms->mm = current->mm;
>  	vms->vmi = vmi;
>  	vms->vma = vma;
>  	if (vma) {
> -		vms->mm = vma->vm_mm;
>  		vms->start = start;
>  		vms->end = end;
>  	} else {
> -		vms->mm = NULL;
>  		vms->start = vms->end = 0;
>  	}
>  	vms->unlock = unlock;
> @@ -113,6 +114,8 @@ static inline void init_vma_munmap(struct vma_munmap_struct *vms,
>  	vms->exec_vm = vms->stack_vm = vms->data_vm = 0;
>  	vms->unmap_start = FIRST_USER_ADDRESS;
>  	vms->unmap_end = USER_PGTABLES_CEILING;
> +	vms->clear_ptes = false;
> +	vms->closed_vm_ops = false;
>  }
>  #endif
>
> @@ -122,18 +125,24 @@ int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>  void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
>  		struct ma_state *mas_detach);
>
> +void vms_clean_up_area(struct vma_munmap_struct *vms,
> +		struct ma_state *mas_detach, bool mm_wr_locked);
> +
>  /*
>   * abort_munmap_vmas - Undo any munmap work and free resources
>   *
>   * Reattach any detached vmas and free up the maple tree used to track the vmas.
>   */
> -static inline void abort_munmap_vmas(struct ma_state *mas_detach)
> +static inline void abort_munmap_vmas(struct ma_state *mas_detach, bool closed)
>  {
>  	struct vm_area_struct *vma;
>
>  	mas_set(mas_detach, 0);
> -	mas_for_each(mas_detach, vma, ULONG_MAX)
> +	mas_for_each(mas_detach, vma, ULONG_MAX) {
>  		vma_mark_detached(vma, false);
> +		if (closed && vma->vm_ops && vma->vm_ops->open)
> +			vma->vm_ops->open(vma);
> +	}
>
>  	__mt_destroy(mas_detach->tree);
>  }
> @@ -147,7 +156,7 @@ int do_vmi_munmap(struct vma_iterator *vmi, struct mm_struct *mm,
>  		  unsigned long start, size_t len, struct list_head *uf,
>  		  bool unlock);
>
> -void remove_vma(struct vm_area_struct *vma, bool unreachable);
> +void remove_vma(struct vm_area_struct *vma, bool unreachable, bool closed);
>
>  void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
>  		struct vm_area_struct *prev, struct vm_area_struct *next);
> @@ -261,7 +270,8 @@ bool vma_wants_writenotify(struct vm_area_struct *vma, pgprot_t vm_page_prot);
>  int mm_take_all_locks(struct mm_struct *mm);
>  void mm_drop_all_locks(struct mm_struct *mm);
>  unsigned long count_vma_pages_range(struct mm_struct *mm,
> -				    unsigned long addr, unsigned long end);
> +				    unsigned long addr, unsigned long end,
> +				    unsigned long *nr_accounted);
>
>  static inline bool vma_wants_manual_pte_write_upgrade(struct vm_area_struct *vma)
>  {
> --
> 2.45.2
>
> And here the second part which causes the bug (goes on top of the patch above):
> From 312feab01ec0a2562a1e44e231de12cc3dc3cce5 Mon Sep 17 00:00:00 2001
> From: Bert Karwatzki <spasswolf@web.de>
> Date: Fri, 4 Oct 2024 10:28:12 +0200
> Subject: [PATCH 2/2] mm: mmap: Avoid zeroing vma tree in mmap_region()
>
> Now apply the parts of patch [v8 14/21] which give the crash.
>
> Signed-off-by: Bert Karwatzki <spasswolf@web.de>
> ---
>  mm/mmap.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index da9bfb899eec..405e0432c78e 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1399,14 +1399,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		if (error)
>  			goto gather_failed;
>
> -		/* Remove any existing mappings from the vma tree */
> -		error = vma_iter_clear_gfp(&vmi, addr, end, GFP_KERNEL);
> -		if (error)
> -			goto clear_tree_failed;
> -
> -		/* Unmap any existing mapping in the area */
> -		vms_complete_munmap_vmas(&vms, &mas_detach);
> -		vms.vma_count = 0;
>  		next = vms.next;
>  		prev = vms.prev;
>  		vma = NULL;
> @@ -1424,7 +1416,7 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  		charged = len >> PAGE_SHIFT;
>  		charged -= nr_accounted;
>  		if (security_vm_enough_memory_mm(mm, charged))
> -			goto clear_tree_failed;
> +			goto abort_munmap;
>  		vms.nr_accounted = 0;
>  		vm_flags |= VM_ACCOUNT;
>  	}
> @@ -1484,6 +1476,11 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>
>  	if (file) {
>  		vma->vm_file = get_file(file);
> +		/*
> +		 * call_mmap() may map PTE, so ensure there are no existing PTEs
> +		 * call the vm_ops close function if one exists.
> +		 */
> +		vms_clean_up_area(&vms, &mas_detach, true);
>  		error = call_mmap(file, vma);
>  		if (error)
>  			goto unmap_and_free_vma;
> @@ -1574,6 +1571,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  expanded:
>  	perf_event_mmap(vma);
>
> +	/* Unmap any existing mapping in the area */
> +	vms_complete_munmap_vmas(&vms, &mas_detach);
> +
>  	vm_stat_account(mm, vm_flags, len >> PAGE_SHIFT);
>  	if (vm_flags & VM_LOCKED) {
>  		if ((vm_flags & VM_SPECIAL) || vma_is_dax(vma) ||
> @@ -1622,9 +1622,9 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
>  	if (charged)
>  		vm_unacct_memory(charged);
>
> -clear_tree_failed:
> -	if (vms.vma_count)
> -		abort_munmap_vmas(&mas_detach, false);
> +abort_munmap:
> +	if (vms.nr_pages)
> +		abort_munmap_vmas(&mas_detach, vms.closed_vm_ops);
>  gather_failed:
>  	validate_mm(mm);
>  	return error;
> --
> 2.45.2
>
> So the moving vms_complete_munmap_vmas() to the end of mmap_region seems
> to be problematic.
>
> Bert Karwatzki

