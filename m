Return-Path: <linux-kernel+bounces-437773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0C519E987D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 15:11:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90B5218826A6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B03501B0400;
	Mon,  9 Dec 2024 14:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MMRgY/hT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nq1AQPKv"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6CFB233123
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 14:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733753507; cv=fail; b=VGKYQK51iST1xqZ7lKWK9Spxe2Qh0KycKqtjMNMMrqQnguOSellcwwaKONxc90fyPpDICp6pcuwtJESpQd2KmCMKc3hZzDzVTV6LkHktCvBrIKeJzy8j57C7nM7cxWk73fXu7soRZ3+Tt3gFeksiICk0pFSdizcXXL8XfXI6hrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733753507; c=relaxed/simple;
	bh=OI/CkffQeSXznHG8NuAkh7dNurbdcxDJcUELvFXyMVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lb+oKTAYMTL1IBYy0to2ct3Vl6wsY2bUkomt1PFiqT4OfaIHcocivIzzM+2PFCxrQyOLrc3L69WzaWlWS/7m+xNeBx17GfibwygOzN9xVZC5DIg7Tp5eP+3CvTT3ea3lrEi/rJh4Qz1qIz4uVUY38WZ5bzuVu9qQPgX3MNzVEGw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MMRgY/hT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nq1AQPKv; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B98fuUq030486;
	Mon, 9 Dec 2024 14:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=V3s0cT6ET/PmrB5XPW
	Qr2SH03UZQh6BJdqR0S3iXscI=; b=MMRgY/hTixMOvoUJK/Ne7jQfnLpbeBhya/
	f6vifMUVyKIy7oCj1x8OkIvUf8MkU5Fd6ldChnouMNMYqteVby4/2bNnz+9jnIUc
	geWhgs68bFGEvutKiFsGaKXmu5R6e+yuk4zO+Qzts2zzFybXCt815FHXPW2ke8W+
	62XgmPq8Aka7T0m82QQj1HCM+yxTj9PHM907bDLVjY9uZ5eGX+4E99BkC+hMALt3
	9S5jeC1vk4o5gLcP3Es5JljphRXRoKc14RcHaF+2SGeE6K3oP7+aIVh/awXISAeV
	z7YlbXskS4bQPmmJE6R5kv19nH3cgsuZgTZ4VK5cR/qxTZlZGJ8g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43cewt39k2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 14:11:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4B9CAp6R008547;
	Mon, 9 Dec 2024 14:11:32 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cct72sq6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 09 Dec 2024 14:11:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rvk129Ow2JatBkcKzy2ieK0tM+f1VVVW7lCsovete28NbZWW8QvJ561N0aCRqbJpexCPe92CxcOx0xlsnhU5bkELFpGm1M8GtUmKwfJv2NxeIfGg08Gikyhr7y18s0b9z1ajLbEaNGUylPXmpancA/lh+2mEUpJb085JPpYrv2+zBRVuvPt7GgdRfWBSbS/m+aq/1QZ6spbYtoySFYXoKZcXhIJJHA9o+0I+/T56NhDQ1H+VZMNqcKKJieXCbtwOPG+q0ckPh9b2bYaVOTXGiaF9fiULXJdEkElvWzPfHdowI1FGCKvsLZSEY9qtBIkTe978sFgEt1w+UY6eTrlNLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3s0cT6ET/PmrB5XPWQr2SH03UZQh6BJdqR0S3iXscI=;
 b=O+si5NejEsZLcMGMMudbjQViivbOjQoyHWq3vnvaDSzLnz5k8mJXisEg765+SuHpaUg0O+mPceY4RRL3cJDZ2b+QjivkeiGhHU6qh9HTHeU1EsSMe+DDl6QsVf0tNfdneEYKpt0aCDfsxjRw/abGlsGwZaDVGBegRQjwvAs73Kp3dKoR9mFw+9vOxIcxjFl5JrzT7SWBdwiNVAtxnEeftppEkkGMVV+xnZp0jA/1EFmQRFsESaQtNEHHv2Mo+4b4US7KuZQkQYzhBpLAOdKSxi09x/WAGn4niklJxgQl8clRJVOnCRQm51EUx2CBBDjkTxEQy8N7t5zoSR0X1hRZ0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3s0cT6ET/PmrB5XPWQr2SH03UZQh6BJdqR0S3iXscI=;
 b=nq1AQPKvEKrw9+uXZ00rp8hyrxl/ZSME+VTKWT0fu0uB0ZQZ3QcJycMMY+WeSx9aKgjkQ+HCXO5W/ojf14cmzvnakZXRIX7v6gRABC3EMFoo8hW/KcRN2ltFg/gcYdhswstj4VMHjptV2UAbIlj7NqQ9zL/9mgO2PWs+LV5EEs4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA2PR10MB4748.namprd10.prod.outlook.com (2603:10b6:806:112::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Mon, 9 Dec
 2024 14:11:29 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8230.010; Mon, 9 Dec 2024
 14:11:29 +0000
Date: Mon, 9 Dec 2024 14:11:26 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: group all VMA-related files into the VMA
 section
Message-ID: <71beb3d1-21ac-4037-8363-6484c0c333b8@lucifer.local>
References: <20241206191600.45119-1-lorenzo.stoakes@oracle.com>
 <23d3d7f6-d6d1-430e-8ea0-ccae76b253fd@redhat.com>
 <41a14051-75ee-4de3-863c-d0532aa7e3aa@suse.cz>
 <1e4c3e31-ea9a-4af4-83f9-15a882732e69@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1e4c3e31-ea9a-4af4-83f9-15a882732e69@redhat.com>
X-ClientProxiedBy: LO4P123CA0575.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:276::7) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA2PR10MB4748:EE_
X-MS-Office365-Filtering-Correlation-Id: 7591e253-9d3f-437e-f094-08dd185b605a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jtu+m51F3Xrwo90VIqH0pQlUhnlh03W2/KB3mIMd3cSXhn3Ykrbh8rm2Q/Vp?=
 =?us-ascii?Q?j+i07UypkiE86IDbYAZpfI0rDtJsRuhIDgS8+dFX3dDr8gNF2dqqtH6RTBPy?=
 =?us-ascii?Q?bEdRNn4S/4ngzA6+JqUmH2D9WDlSzWFWq2u+V5BBZ7MxPK/5C9vfS4JTWTSU?=
 =?us-ascii?Q?6C4utr1HSwINEJJND9Xdl6Kso8oIP/RK6kQUV2ppwhAz5UC977gwwLi9iCT0?=
 =?us-ascii?Q?fxKOXqBHsYk8MNINfooEV5Ww6Cr5eodqsvb2Uffz/yijB/Q8+E3pCsx3BDn0?=
 =?us-ascii?Q?PcoF3bbQ3iWdHdbRsBdl1cQr9quu4yfJcG2jKJIf7e6roHhNplwTS6Ubxv0Q?=
 =?us-ascii?Q?O+WT2OgHr+bIZfGD6uRTOLuF0gOhMRzCzHtEV+Mt3oJQEcysP4Y2d99+6I8k?=
 =?us-ascii?Q?2dLDMNi2/InGMXHqfXgXCqWXyY0srW6sn3fYtFBYTf54bVIOFZiHSAxAwaMC?=
 =?us-ascii?Q?2hWFTn5lxBV89ud23+QrQbGXq2Wz1XUwmDqDsspXDV+8Rt2rgu8rh7HhhvRd?=
 =?us-ascii?Q?u9jk8pzQDbWWUYmoAYVFRXsOhu/OaopC8+9O+d9Ddgr3E/dYTvGddYRsYSAm?=
 =?us-ascii?Q?zJDw+f4CAdhB8yS7qR9MGRTkWkJV+26llpXAa959wzS3EhvtgZOSUqnVwyLG?=
 =?us-ascii?Q?Dg+B5J1bZNhnPX7uAC0gvx0co23o2m1GXm7YcovzY1Ol2+EXyUTIf+iWdtPj?=
 =?us-ascii?Q?/5ijsUV4J2LBYz3Jj3JDX5qDe77V3nODT/EIiPoGuJXjVbxwUpuulMfJlWck?=
 =?us-ascii?Q?YIAy6bw+MM+DsjjwN+29eMfxNflnewFM14nSPHlDfcmGq4oLOfEEAi5NzDdY?=
 =?us-ascii?Q?aYy+UUWHTIvTa4dz73AINL5/rcKA6L9Y0qJsgy3vbt1wKw53XRE+d38hwLVj?=
 =?us-ascii?Q?TBJrgx6EoUl2+PjFp6kl0mgemv7BAKXu6LtZq8nPqFe/0XTZ395D2lY6RVP7?=
 =?us-ascii?Q?FGL0weZO/HTz2CviUAIWHjIpOCh47JHdjcHOBsQ1FmoR0kITSVIPA3yyWe0k?=
 =?us-ascii?Q?T7gHESbSFWlK5NzOR/SX78i16xGLF/raDHTtvIcUDDTQPFC4WNQ9Ltpx4aSJ?=
 =?us-ascii?Q?Wjdb9mnrL8A4B1E/C9vcLyG3aamXoXu1RkvAwXk31BpYdRDhFHn1J/TJNxew?=
 =?us-ascii?Q?nRA38ZeLggnKM75XXuQ+Wm37TBDRw1+Mo3QrHSQaTnIX564QzFiEUIy6OHcd?=
 =?us-ascii?Q?aVmesTM2tDT8jx2STHl6HsTYovau3ZLq3vGUJwMsHjG91pg4Bbf+GvV2L9V6?=
 =?us-ascii?Q?q5dcKKkXvTXoTY5ZmPadhXe3dgaAcOlLnyQ1u7N1fynD4zMvzUje+MqisRks?=
 =?us-ascii?Q?pbk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?oN9JmZI3xviuhFdTxm+K5MDAHVTbH8fhFovMn1MDLfkAweb8BCvNBeK0ky8S?=
 =?us-ascii?Q?+m/vj931G06TeU6FbEhibQBkJk97ieUSaHeBS8f09wXBYP7DRR4s6Nz/lJgc?=
 =?us-ascii?Q?ab31y2+nBADlJLERsafXt1sxHHPennRJP1lLAsRXRwh2n5/3ZAR/BM/o8u52?=
 =?us-ascii?Q?7mpsnkrYeXLnPy0Rs+BDGlapJBC9S6T8HkNGbNEvJ5zM1v7KEYqZZUgDjC90?=
 =?us-ascii?Q?TKgC0/8G/OOGobmMOroBCiZMz5dx86DFiduubpmV9+l6vD2SxI5ihnmEsH5p?=
 =?us-ascii?Q?VbZBozo0I/VyqaTkeDvfN7AtQzI9+NIqF126EUGp5aDFGiHJdS0qrj1fLIxG?=
 =?us-ascii?Q?kz5uT4oiNflTIZD8e89xtq1gwYdBE+3si4umx2qohFyx8MX3hou8VbCVVksT?=
 =?us-ascii?Q?NE2weIp8/6afWkhiq1Dnf2N9YewrtWVBPtgFuyC86Fx8Xg+uVbf21Mh9hpDX?=
 =?us-ascii?Q?gjtgSh2gY44g5W21WHq5AQltKsW4lGoHa3va6JmBZ4ZC6N5KyNsYoF/2ZFae?=
 =?us-ascii?Q?7XhaWxvI15LwX+pY25PsEKlxTxcqU+DuF7tOlJy5+e9vl0VNVHzcXTiHyFbv?=
 =?us-ascii?Q?PhRZuiwIkuWuc8iMce7QjDw5D30ItEokqHJD5pV1t9FdRKF5YDb+ZGyXcq+P?=
 =?us-ascii?Q?Kz0caG9+SvGLM7nA9m7nmZGAXBt2AeGvDyk2jxuAWpLSuULayQ5WPJox+WPJ?=
 =?us-ascii?Q?y38B8wFG3FxmJCjySD9hssh3wXr3z1WxWgIPTXt45z62xHuM4g2W5bKDJhaw?=
 =?us-ascii?Q?db62pHEBSpcMlQ5WLAtG4WG0Wh8fux0GpBvEVX+PXhJyzztRGddRi/01jpj3?=
 =?us-ascii?Q?b11pmt5xk6onRpssk32kib9KFIN0OFVDYhrgqF1Di39X9Dbf3l+HYaFEVFrv?=
 =?us-ascii?Q?uCB/VfcrnekXFoTZAUC8i4szR4558OfYJmXrqqQ2WHpCaxKzOl/4CcSF3Iju?=
 =?us-ascii?Q?VARjgT2+Yx97vp6sI3XCEh5zGZMtuoql3T5b7sDE5xlq1ZVpAHjZyGvfg11U?=
 =?us-ascii?Q?iyAs8Jx17kBjGQQEIo+AO7jOf9huVJj+zMZQqkFVyEnvTVkdkXj1TmJwHYUQ?=
 =?us-ascii?Q?8EE0Di1i0C78djhDRwAvaANDperCvmaWg8xZ9SWztF/shtLpN/DcujAmoLC9?=
 =?us-ascii?Q?KtW80mQuK25xGR2fBLTemeaScM20fsqsIph6B/0MIr0ymhAWMXVUJDqO+qqC?=
 =?us-ascii?Q?dMNfvUCHyuF0YFv/SIk76uyfqkbzKVfKyoYb7nfZSTgeg2594t2UuTUZtNNQ?=
 =?us-ascii?Q?gaZHoEpf+SUkq/c9+TEah40VxP6ak7FufSiXmoUFbu3QRJo97salXdgt8/le?=
 =?us-ascii?Q?7klVghU6QTW0BIfOhLMDybhAO8e47K2TgJTQpurRhS6TxjFRmRa+SMJOOldv?=
 =?us-ascii?Q?sXBD9XW+HoGXXj+P/eCMYVBwgL3n1mpB/hydPDgW2fu3E1T+wW7Xo4CZmSiE?=
 =?us-ascii?Q?PePjnyUxSlPImBE3DpZ/vYtLhXLUiaXLYYwJzN2RnUHtkUM9rsJ2Jo2r49px?=
 =?us-ascii?Q?UdX0tuvAQmjLUfoK5KuyaQ6ZeHgRyZOIVaZ4HNCJK9ksN6DdNmsrDkMYSt5q?=
 =?us-ascii?Q?mnMih3hotAWKggNMFOkEyZsBSUooMAyEZZfKK0/8DFIZDjxwpmmWdzf1TDoE?=
 =?us-ascii?Q?DA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iW0S7EY+jOEfgRBhbG/uKO0/P1HwxVoC06X9O+FOypyexw5zjhZHtPCqayP8Mfh1xu+7AvG30OcYGRD5J5Mb34STIhodv53YcCjW1UlwTp50hj78K8BRIMo519yog84YD27dUSskKAeVYQHd1QdWEt9+Z7abolW5gTILD0FTogwO0hIPX302YPh6RXcJ89CUMgRxjhb2ZuQqjgBkoBcivV8GFd/7wtgGjBnLlSd17cNi9vjpzhCBO0V4xY6TvOipaU2C0oYNY4TLL67gxiFE7gfhnwWnDF1GFYuaDrX5U1M3Kh8xSHdKssc/ZWYVqLSG2XEHMXNYnQf36O8YwxfLGr29dgDW5sttubqB+a2z70G614eTIG0ZmtpxLAnju+OEIUwznMEC1iPJ78vOJ46t/EoIdseppjoLdnhnhsIBv7F23rBJ8MbHl0io4e0+p2LX7R4UPuVq6zff58V1oIlXv3QvhgLAc2OpYiZw8tPn9a9KW38GbFT0RlaVmNvBn9UYpBqdGAQKVpPLQtDAKTCVUJiXj2dvskXjNz7oA/ynRuRPaU9iJVjZonROGhq+CgGTQTkHbDF+UmMIIwnzKhTJ/jBlIil889kR+4uO64wiJvA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7591e253-9d3f-437e-f094-08dd185b605a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 14:11:29.6292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kKyHC2hnVucs79/OhG4fSAHbJ/KavV/eUzz2YgNCcg8buziRbQSs6LVoaDFOE8lolNU4aIdC1uAZXxDJjYEmwzhLlavnX21SUjRHDHhprSg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4748
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-09_10,2024-12-09_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2412090111
X-Proofpoint-ORIG-GUID: nWxEASyzJs1NPhqcTS-pxB8xM31lRmkH
X-Proofpoint-GUID: nWxEASyzJs1NPhqcTS-pxB8xM31lRmkH

On Mon, Dec 09, 2024 at 03:00:08PM +0100, David Hildenbrand wrote:
> On 09.12.24 14:25, Vlastimil Babka wrote:
> > On 12/9/24 10:16, David Hildenbrand wrote:
> > > On 06.12.24 20:16, Lorenzo Stoakes wrote:
> > > > There are a number of means of interacting with VMA operations within mm,
> > > > and we have on occasion not been made aware of impactful changes due to
> > > > these sitting in different files, most recently in [0].
> > > >
> > > > Correct this by bringing all VMA operations under the same section in
> > > > MAINTAINERS. Additionally take the opportunity to combine MEMORY MAPPING
> > > > with VMA as there needn't be two entries as they amount to the same thing.
> > > >
> > > > [0]:https://lore.kernel.org/linux-mm/CAG48ez0siYGB8GP5+Szgj2ovBZAkL6Zi4n6GUAjzzjFV9LTkRQ@mail.gmail.com/
> > > >
> > > > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > ---
> > > >    MAINTAINERS | 19 +++++++------------
> > > >    1 file changed, 7 insertions(+), 12 deletions(-)
> > > >
> > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > index 1e930c7a58b1..95db20c26f5f 100644
> > > > --- a/MAINTAINERS
> > > > +++ b/MAINTAINERS
> > > > @@ -15060,18 +15060,6 @@ F:	tools/mm/
> > > >    F:	tools/testing/selftests/mm/
> > > >    N:	include/linux/page[-_]*
> > > >
> > > > -MEMORY MAPPING
> > > > -M:	Andrew Morton <akpm@linux-foundation.org>
> > > > -M:	Liam R. Howlett <Liam.Howlett@oracle.com>
> > > > -M:	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > -R:	Vlastimil Babka <vbabka@suse.cz>
> > > > -R:	Jann Horn <jannh@google.com>
> > > > -L:	linux-mm@kvack.org
> > > > -S:	Maintained
> > > > -W:	http://www.linux-mm.org
> > > > -T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > > > -F:	mm/mmap.c
> > > > -
> > > >    MEMORY TECHNOLOGY DEVICES (MTD)
> > > >    M:	Miquel Raynal <miquel.raynal@bootlin.com>
> > > >    M:	Richard Weinberger <richard@nod.at>
> > > > @@ -25028,6 +25016,13 @@ L:	linux-mm@kvack.org
> > > >    S:	Maintained
> > > >    W:	https://www.linux-mm.org
> > > >    T:	git git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm
> > > > +F:	mm/madvise.c
> > > > +F:	mm/mlock.c
> > > > +F:	mm/mmap.c
> > > > +F:	mm/mprotect.c
> > > > +F:	mm/mremap.c
> > > > +F:	mm/mseal.c
> > > > +F:	mm/msync.c
> > >
> > > Not sure about mprotect.c, mlock.c and madvise.c, though. I'd claim that
> > > the real "magic" they perform is in page table handling and not
> > > primarily VMA handling (yes, both do VMA changes, but they are the
> > > "easy" part ;) ).
> >
> > I'd think that moving vma files into MEMORY MAPPING (and not the other way)
> > would result in a better overal name, that would be a better fit for the
> > newly added files too?
>
> Maybe. I think vma.c should likely have a different set of maintainers than
> madvise.c and mprotect.c. (again, the magic is in page table modifications)

The bulk of the logic in mremap.c is related to page tables so by this
logic then, that is out too, right?

>
> --
> Cheers,
>
> David / dhildenb
>

