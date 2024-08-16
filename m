Return-Path: <linux-kernel+bounces-289607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0806795481B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 13:33:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEFB81C21A52
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Aug 2024 11:33:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1A0198846;
	Fri, 16 Aug 2024 11:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f6+rt+RN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zs/BV1Jm"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083FA13C695
	for <linux-kernel@vger.kernel.org>; Fri, 16 Aug 2024 11:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723808023; cv=fail; b=YpqZ1D7UT1iRgxIq1sbpY3pWjh6OEjrc1bAM/q1ZFPNuq9m1LnzlttD/6KBz2CvP5mXHcvu6NDWkEFdokkR4hEHHxdnT3UWNFAcfqSPzeIJkuHrShwiNp3Yr45wo6JoMIXK5fKO5TMChHv2wbLvPrhcbmh8t4b9EeSyuCaATyiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723808023; c=relaxed/simple;
	bh=m6CBdAZhJeYLySIi+QFcz0HyQYn2WatvZhhQdICDPmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kSo4IRy8fGrWk+Dk8djZwInejf3OAVrKJbLyEvN74uEFU5aqkcN+OS1ltg8j+DEnD/36IVeobmEQYIH0xI09+SCDI2BE0Cljb4YbtPyBw6qWc4Y6Pb/VulKNXU4+YJkbXrxzarG1K5XbAANDXubVQApLo+acnuMYhrnBk8KY2MU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f6+rt+RN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zs/BV1Jm; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47G7uPxq012733;
	Fri, 16 Aug 2024 11:33:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=zVgsOcRXLJK7U7a
	J+iDqpEOy2+noJ6td3RC1JjqFZWA=; b=f6+rt+RN4Y4t5KAwxVaf/m8RLuaVWLN
	LPoEXDw2Nnyd2cQLIoFYHIR0X33jrO3KKRwMuRqC0GQK3YfnWV9couzNrqBToqxt
	D3ghEKbNJw9oGHArf2gZYc8TvmMAcSdk7sKk6KQgTjvIFOU7WUkko1R+xRSSdPm8
	6vKr74+9VLchIQ3OOnRlu3Fp39B762dnB97jr87c6FQA3nYOSkzGoX+bEQ1OWmpV
	MapchgoOFMrMZilCl75DMXD/ypExdeXWN3Y+7iO1QICrqgbudpqjmTLG3AQQgCPu
	FMFScnkp5PlsNFeO4oS2CvnqS3Yi2FfhnTcc2sOlTnd4abuhiAGgx2w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40x0rtvce1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Aug 2024 11:33:21 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 47G9Irt4010621;
	Fri, 16 Aug 2024 11:33:20 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40wxnc9q84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Aug 2024 11:33:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ihHwrz2EPUCmmVDZZG2pQy5eXcO7IXFy4a2InNY+/YT7Sg8S3FT6s1KhC2T1KN59oy+oNJVRkyrZv/0buFhVveFzaLqR5rFIG2dxq7hh1jDQfN311+wHrzRai5Z4EraKqhZPYSEsu67pDrpY6eSpxb9ne+fIq/SFaayhE2MxlolaB9LdlddXrmo58fU0HNl1byzTETg5rLEz77J2ekxSwxozpO5DS/E1RN8/oFwJzwMaAZeGOmF8KQoKcwLH14enIQ9FSlVc05Kc3xI/tdvRZLzVuQZLE2DcIFaYmVzP3RkaKJ4HaX5xoIAh8vvwCYMDr7lZLy2aW5n381342pDPJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zVgsOcRXLJK7U7aJ+iDqpEOy2+noJ6td3RC1JjqFZWA=;
 b=bY7TadfR0GncKz5+4Oo8bA+7UvwCS+2d9fUBr5ZPp3Xgc6O5TjcKxkQi7U8KpGgMC5KUXJYY/rbTv1u3ZVzeQh4PqihZzMJxatvzLm2p0fz9S6NwzglI8pWPvboA9TdkDBNDFyJSxnrLBXWrQdMguq25Ouc6DUIn30u4al2qWT5c2kHr8Y1n4qRx9zRsE93bl8yBTZ+vLdnCCann/kDgUtqPomRGvTvrNoQBGkU47ZJCbAOuQHvE7qhvvl1Vszu1B6DYwZMO1FfFzYTPtNkm22P9sgu+/Sh/0I4NvsvMLY7NK9VQYUgQ7dtsAngd7US1nodVy7ZmqXe9qwZrncLVLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zVgsOcRXLJK7U7aJ+iDqpEOy2+noJ6td3RC1JjqFZWA=;
 b=zs/BV1JmKwex39TFT1XhznkDwfX5l0e67Af8edHcd0vNMJpmgi9rME1uXJqgCY5hUTaAhr9oJnlfNAvvaCIDyC8of8Aevl1i02UmU3Zf9+tuaGFUU89tlmV5Imj8V/0vesBEBDE7YuBweYwdBOmdtl+1F2dPKrfTS/NiwyAmhx8=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH7PR10MB7106.namprd10.prod.outlook.com (2603:10b6:510:268::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.10; Fri, 16 Aug
 2024 11:33:17 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7897.010; Fri, 16 Aug 2024
 11:33:17 +0000
Date: Fri, 16 Aug 2024 12:33:13 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jiri Olsa <olsajiri@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <kees@kernel.org>, Jeff Xu <jeffxu@chromium.org>
Subject: Re: [PATCH v5.1 00/19] Rebase v5 patchset to next-20240816
Message-ID: <5fa31825-e7dc-4d58-b218-d54ed6d86507@lucifer.local>
References: <20240816111405.11793-1-spasswolf@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816111405.11793-1-spasswolf@web.de>
X-ClientProxiedBy: LO4P265CA0056.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::23) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH7PR10MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: 914908d9-edcf-4428-5ad8-08dcbde738da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kD2yjRGEPOlUipuCcM/k4ELoPc7w9vWAGnWUb9wPLTmEDBjUipgZ448gxTqM?=
 =?us-ascii?Q?R7jV0Z8pkadlXwwMSTSyuDXvdtzaC0ptTNZLOD0l1Me6nzEwrxxECPNbQ8nB?=
 =?us-ascii?Q?Gg4kTKHo4BiQhI0F8u73Sxbk0GgJ8pO/Lb0HqJyEReM9n3mTmwfoGWD0F/Il?=
 =?us-ascii?Q?byA3h0XyrYw581ElreggEpZWa055Vr/tIsyI6Gxfwj3FHlOIcA+AOmi1plHc?=
 =?us-ascii?Q?/SRe/pk3/6YpmQ5nBgeZyesOX+x/hvZ23UFKWv3wUpUEyIXvwEybAn+w+8zE?=
 =?us-ascii?Q?TZpU/IFGuDnxAqMLv3kNZMWkjKmcLPh5naiPi87pJxbNU/qs/Yz5uVYBD3Bj?=
 =?us-ascii?Q?LHTLH3Xta8pCcuH+ivwInHMyXwGqL9OovaT87Yu5Zi2H//Mg9iXIRt+K+J0b?=
 =?us-ascii?Q?9hKiyC0qBCSQH0+L80GdXcIMa3m+QNl5PRUYPH+iUSQ2xu4A0b3QcD6p3eOd?=
 =?us-ascii?Q?RyO28X3v2Yve9+mFJQb39RZQ642+ABUHMGrCP/Fke/DDLY1TqnIc74XLJOlh?=
 =?us-ascii?Q?LZ+9hkDb/l3h198VUt/pxUT4BLvVoUA3s24mUsJB/tUgIEYjX96qRU5sxhht?=
 =?us-ascii?Q?qzkn/wtuxqVY3Zf+4SIV0r1CM4FTZRUylhmEcDmwv2ki6cUmSFtpg+GjV4DN?=
 =?us-ascii?Q?/LVBMeeNihZAc8LSYGhKpacemTv9DAlnZqLMx3wgG7YWwVfvm2iomiVN1/Zn?=
 =?us-ascii?Q?AQB5AAHdqguCtvj7PRUjijt0LxWAC+mSSl/hSOBQ6hjp9kmtWmt8Y8HoGc1c?=
 =?us-ascii?Q?TVxrHzf/AtsGibNGUBrjP2w9na1STTfIuPBI7ATd3yYbZ/J4Cm5RkwoEHt0I?=
 =?us-ascii?Q?3/mQ9nD0DJGCJtZIHnpJVRCC4gACdOVdwudtXok+1btvcTa8KddWgA3zifby?=
 =?us-ascii?Q?Z/EwqZFudHvTtsKzoi3FxW1uh3ACiifDuo6t7vaB6Ki8CACphxhf/lL26t3d?=
 =?us-ascii?Q?dUYihI2rEQhx5fDJRMOnFuKU55DEj6fYIcB4KiL/fFbNNyolCtgah61MHbbj?=
 =?us-ascii?Q?nWaqBktbBg2iqHcToRY5YjtjnQH4Goqgqb3VDIxEB5/ANls/GMeKLQncSxRo?=
 =?us-ascii?Q?JdTmX2fOPX8MFDENrVsdsj+3GrH5qtO2Go35n+LqH/lct6pbQlFSd9xXEe9U?=
 =?us-ascii?Q?aBgW6t/k4pK1PZdDj/oanSk0atjCo/gCjR+Xj2rIK7xHSSM1kP2qURcwwu3b?=
 =?us-ascii?Q?4xsIRruoXWn9zyJ3PhgxicfdmI/9sEub3ln4zAdicz6M1vBgI6mRBa8B4Qe2?=
 =?us-ascii?Q?os+9T/6o5pn+bQ2/6bJuV8ev6loD/lPt7stDcMcrQOZcD+EhCBoOOdinEIP7?=
 =?us-ascii?Q?lFIEb/rvDADYMsBsk1cgwF2mDa6kp7XxSAEtrMg7r/FM0QTAxteV5lXw6UGi?=
 =?us-ascii?Q?07lsy6w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fk35s4gXiWlLwZJAUjSqo6ZBp9XozxbcrOI7MsAptDLI0OgqT1I8ySC4ahBG?=
 =?us-ascii?Q?R9lp7qK/6Sp3aGqfrwMHW2qP+G6uBPk7ed7frbujboyAUXnZ7tx2+h6ixUp1?=
 =?us-ascii?Q?6hT+s0cwQrVDdi4hTyJOjqCBM1UvwvaCavCW4av3Aui5rGCqL8Vmaw/ScX1j?=
 =?us-ascii?Q?H7S5IntlMP+Z3HM2XZ1vhgw544egU2veTsoXsKptyU5vci34uZ5u6jjj+1mT?=
 =?us-ascii?Q?ypAwMK2QGQYsbEj8vjA/G5qWo5iOncKPlbNlz3lpNMPGGpZVVHC0xCbSvNNm?=
 =?us-ascii?Q?57MB4FuJWM2JcL4UTmdsG8fq+HQd570WgT7mtmN9kbIiFH9i/WRQyhBU4KPw?=
 =?us-ascii?Q?J9gFqyqgHuCtqdJUO6i0OsWgq5afmxJQZG1gcGGu1Y09ZX7g12n5rJbBhqsl?=
 =?us-ascii?Q?eFEUnIXGZVrrgv0Ltkt0oW2OeCC8HIe0zyQgfr3vwuNyhzJUZKhX1KnjHAuH?=
 =?us-ascii?Q?sZN/HIdaAAVJb9cMf7UMWk/VJQQlaHVD/4Jj+pLJU95dgxpahPpV2OBSWXdg?=
 =?us-ascii?Q?wrNSh8c8l6YSJgUf334MslYKl1J5wGPHZRkQFh/iIe/OAR0zKXgD7Dh9VZCX?=
 =?us-ascii?Q?iDdnb0VD6CfElozNaOh9giYRHVIlDmNGvaSakEY9BK+B8tlo5cmFN8Le/iJC?=
 =?us-ascii?Q?Sf9bZdMMEeYGJUvVz1XQZXTsmGO3zeS1CE/Y1IOyc2wza+sQeZyC7z2/28HW?=
 =?us-ascii?Q?zZbDQOzhXYl9FMjdDj49bI2eJp5vjA14a9tTYTDxM/LxV4GIGg03emwxOZ7o?=
 =?us-ascii?Q?7NYc7vtTqtCYe7QBtiySqRw5bBKCClcxjOrfv52IRkvv+UWBwNtNVFO72z2z?=
 =?us-ascii?Q?/UyB1ap5d9n7fB/E60KneSR+EhiYRU6VcUNiiJaElAjl3xMhTbbZe7Z+KwLe?=
 =?us-ascii?Q?KMR4euc2JLRGtsOh69ZqMH/Wp5DaEz5ify5+8Ss8i/Iw8iwkT5g1stQ2aw4S?=
 =?us-ascii?Q?SmhhFAk5Qxd+GPaxx7jzMi4nQTckP1OtrJ0+Iy0s5dLyC7Gr7827tBoPPvas?=
 =?us-ascii?Q?RyCA87/F/3XYFEmdpGUif8We4T4XRVOXWNJihsoLHe6t6sLDHQvw6uZV4S52?=
 =?us-ascii?Q?lt0XRJcpQkW1YxzGSoaKNk8G0xKzs8xwPps06J8D+Lpn55yMXqyp6ph6FRtG?=
 =?us-ascii?Q?OkEYcH2gsqVQnM0chA5vkBcJHE3MVsPgK/syoJRZB3rW4I5yI3vOsOVlyMKW?=
 =?us-ascii?Q?pph1fxBJhveBtOydeV4GHTkBAyYMOGaOzpFp8dWjceYNAGGOXY/BiM00qQxy?=
 =?us-ascii?Q?RKpbuDV/k5qm9v+9Tf6xoslyxYCDviw30A+ysRPjAPZQGzrqLJmsFKfuz6Fg?=
 =?us-ascii?Q?1841pKon+f9XLEX+mrfyMc98nQsIkr4GoL/3cNL5phdWBy7OBJLS6pS+xynV?=
 =?us-ascii?Q?Wy8rSbOhpff8ONj066NDRsakGq/d7rvvJl111dZzc9Kz4ZEPoMsgWw5xGUu6?=
 =?us-ascii?Q?pjAuzeBGS0byehfP0pu10YkAb9BlrkroWqjnKaABhb8x8vy+sify/bW6M99U?=
 =?us-ascii?Q?yzh2wMLBUxicY0G+VH/LKavdJjqGXzzzowpp1FgPXpv9ZcFMJ5eHUyWALU9r?=
 =?us-ascii?Q?RAEWgaCaFmzgVJCitqxcxZxMVmPbNxvdAxP8O/dVYW2sqTM0yv/6TngxzVZx?=
 =?us-ascii?Q?chbqdVDBMLj0/DwDMItR4YYkxPpm2zlhA7c0nHE2zDKhZ22SkikDAqNUpPWR?=
 =?us-ascii?Q?Na7ZKA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c0DRy5aeMQtSDzCg8eJeoYdBmw3YZKaMUO7KoAQoJZ9nv6jp1ECN8Ke35IngK6xFEjPFHVdY6OP2v6DnTc1WJD0DMz+6UZJ+d7eiX6EpA5zjqn8iuwvKaH0K4pKzTu4E1WaQTAuNiGix8UUjqeUIWwuzXfSKBjjLfUsln8NdTyYR+dxezj1PMLK4wTONRQ6nSIjiT1Iq9RbMLnhuoXOK4PwHJD9SAgSfWQM6jYSBmiQmLY7gAft4NO8YKF+JHNszLFuUm3ROvbCVoA68TYPJFjHzuFwhfIwtsOfB5M7s5EuP7tEKKVQvOSDv665cJI7AIP3b6issjG99iINc4G76NC1hdAitLHKnBevD/+e2CXkPkvnrIihqh+8f7icSPckpmGYxoVH86UJMP8JlUNrTIUTNXBAr6XhKwgQqYoWL19nVJlJQCQuOilgZE8OcLzlVuRHWsoIKi/p9EZAyGRZden6GSLGYw60XKGu/7hrFm5bcKzAGJYJU4FwEFyVh8ZyIICY4MEO6u3cTEJq4MqCTehYtp3in1svHgJ2vhliZNi+tS9l+RCbln5GjepzEGxScXwSp4JcoOalEYxLw5vHnNgtGnQcGXcd6VFh0Kjb4Slc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 914908d9-edcf-4428-5ad8-08dcbde738da
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2024 11:33:17.1570
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMYU7S10GfS/iYXiGCZlVTAxOCjoyUpAafDpCmC4K1BGD+rpiXSEhqtqLOtPGd5TlqjOhDGYr8TK1qf2vFKuG1xIbzXCod6O+Eax2envQmk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-16_03,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 suspectscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408160084
X-Proofpoint-ORIG-GUID: d8h_QXnv1Ma7lz8iuxim1AQML04g4VID
X-Proofpoint-GUID: d8h_QXnv1Ma7lz8iuxim1AQML04g4VID

On Fri, Aug 16, 2024 at 01:13:41PM GMT, Bert Karwatzki wrote:
> Since the v5 patchset some changes have taken place in the linux-next tree
> which make it impossible to cleanly apply that patchset. The most important
> of these changes is the splitting of the mm/mmap.c into mm/mmap.c and mm/vma.c
> and the splitting of mm/internal.h into mm/internal.h and mm/vma.h. Also
> arch_unmap() has already been removed from mm/mmap.c in next-20240816 so
> there's no need to take care of that.
>
> When testing this with `stress-ng --vm-segv 1` dmesg show errors like
>
>  [   T3753] coredump: 3753(stress-ng-vm-se): over coredump resource limit, skipping core dump
>  [   T3753] coredump: 3753(stress-ng-vm-se): coredump has not been created, error -7
>  [   T3754] coredump: 3754(stress-ng-vm-se): over coredump resource limit, skipping core dump
>  [   T3754] coredump: 3754(stress-ng-vm-se): coredump has not been created, error -7
>  [...]
>
> this is most likely not a problem of the patchset but instead caused by
> a more verbose coredump introduced in the following patch:
> https://lore.kernel.org/all/20240718182743.1959160-3-romank@linux.microsoft.com/
>
> Changes since v4:
>  - rebase on next-20240816
>  - some functions which were static in the original v5 patchset
>    are now non-static as they're used in both mmap.c and vma.c
>    (an alternative approach to this would have been to leave
>    them as "static inline" and put them into vma.h (at least if
>    they're only used in mmap.c and vma.c))
>
> Bert Karwatzki
>
> Liam R. Howlett (19):
>   mm/mmap: Correctly position vma_iterator in __split_vma()
>   mm/mmap: Introduce abort_munmap_vmas()
>   mm/mmap: Introduce vmi_complete_munmap_vmas()
>   mm/mmap: Extract the gathering of vmas from do_vmi_align_munmap()
>   mm/mmap: Introduce vma_munmap_struct for use in munmap operations
>   mm/mmap: Change munmap to use vma_munmap_struct() for accounting and
>     surrounding vmas
>   mm/mmap: Extract validate_mm() from vma_complete()
>   mm/mmap: Inline munmap operation in mmap_region()
>   mm/mmap: Expand mmap_region() munmap call
>   mm/mmap: Support vma == NULL in init_vma_munmap()
>   mm/mmap: Reposition vma iterator in mmap_region()
>   mm/mmap: Track start and end of munmap in vma_munmap_struct
>   mm/mmap: Clean up unmap_region() argument list
>   mm/mmap: Avoid zeroing vma tree in mmap_region()
>   mm/mmap: Use PHYS_PFN in mmap_region()
>   mm/mmap: Use vms accounted pages in mmap_region()
>   mm/mmap: Move can_modify_mm() check down the stack
>   ipc/shm, mm: Drop do_vma_munmap()
>   mm/mmap: Move may_expand_vm() check in mmap_region()
>
>  include/linux/mm.h |   6 +-
>  ipc/shm.c          |   8 +-
>  mm/mmap.c          | 146 ++++++++---------
>  mm/vma.c           | 397 +++++++++++++++++++++++++++++++--------------
>  mm/vma.h           |  61 ++++++-
>  5 files changed, 403 insertions(+), 215 deletions(-)
>
> --
> 2.45.2
>

I appreciate the effort taken in rebasing, but this is quite confusing,
it's like you've re-sent the series (with tags...) as if you were
submitting it, which I'm sure isn't your intent.

You've also cc'd Andrew as if it were a submission and everybody else on
thread...

It's probably worth marking the series to make it totally clear you're just
doing this as a favour or for testing purposes (I know you at least changed
the title of the series accordingly). At the very least RFC it...

Also you should mark that this is based on -next, as mm work is based on
mm-unstable (for this series, likely the same).

Liam is working on a rebase/rework of the series in parallel also so we
should definitely be careful to avoid any confusion here.

(Oh and as a side note - please do not send email to my personal address,
all kernel mail should go to my Oracle one please).

To avoid any confusion:

NAK this whole series in this form (+ wait for Liam's next version...)

Nacked-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

