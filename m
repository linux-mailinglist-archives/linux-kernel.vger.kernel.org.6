Return-Path: <linux-kernel+bounces-531810-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB499A4454D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 17:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCE383B2CA0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13486175AB;
	Tue, 25 Feb 2025 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iSVh4OGZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BkJ1c8uP"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B8B2FB2
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 16:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740499363; cv=fail; b=HHpeTmAeMN0JPSQNyqYIbnfo9IhpiInkSu+YBY1eM0dmt6s9mMwhfD54C3tCAgZh+32pK42uSRwWc5q5gbBd2ffuYfyY9/J+LonkmGOLl14nKKp5786ho0pU0D6AMUagFG5nkLyLnyzah4H3WtEnOTLuru+5wtkKLepG+WkmN1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740499363; c=relaxed/simple;
	bh=+tH7gBTwSfvJgxRly0wHBTvdlPRX4wHFVXoF5H6Dvj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kTsHcII2XH9iTIirrqyddCCNcSB1dZSphmsN074u2y+LRIHIg4ennATg4mzewqSv3hx2LNRqRp7SQsXInsh4AT8kTB7UwNKZnOFRyFNI6OtQ8NsLaIVJ5K91p7JZ1Q/kKgdCLDbFlCO4ef/MnPrumk1ZgNLYPjqLlH4nHcKuhK4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=iSVh4OGZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BkJ1c8uP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PFMdMP002068;
	Tue, 25 Feb 2025 16:02:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=6WK99dKONhI8NmDtH3
	7gnQNoC3Bzpo71tdeGhzu9NG4=; b=iSVh4OGZwE3n5KzHWuRsl26o1Y98USaXzU
	VMAhQm3ZYm3QIpvbTXQtj4X3bhBFCLz2ReQ77N0/MNyZTwjUsUy9ZYfsITOsiryM
	vSb6Cr5WJORxQk8nsKsewt3zh/pYBF4TfxLSVALaPxFxor/mCXDaeTCbYFJFec1z
	Ls3Q0I3K8C+5BBriCBgleHp/aRicvjBW5Bgu2HkfDIdg89I8hbR0delLhk2ycmDE
	kqOEukBDBdvuxGR9As5ic6cbs+5QDbXepF4PYLtfk59RYKnc116JI8hKaeEFtcst
	fFeGSxBMpMWp1JJuKcfRTzdv/PVqIXjU7viMdyHAkkKr9d3XiBMA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5c2dnfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 16:02:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PEkGlI025485;
	Tue, 25 Feb 2025 16:02:29 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y51fya2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 16:02:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bgpVpTEVrB5CMc9CkCGL8bcpzary0V9/S05OLUI+6iDA1kchc+aTM0D3THK74S1MZSfKeZGs6IwJHKYTTrrg2G/Cr0Sd8xZiwBcquWkARO3Aah6O9XEUTwHskgpfrEOKm/y+v2sllmS4QC81h/L+vVWWpGblPjxp6svPiTeklAv16IvV4Zo4jLhPkm+KxcoYaJyPc+nwUTp6OhMY3Zk8/FA5aQ1Shj9/MN+nmo4nTBsVLzoTxlu1m+SPgO9dfdfvA9v+sF9LdN2jM+pSKY1C0meq8gfCw+VNm6KtvcWZs5HisVWu3qJQ/zfXESStPizNWljSx5FmHqbBKwg8JwCWkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6WK99dKONhI8NmDtH37gnQNoC3Bzpo71tdeGhzu9NG4=;
 b=KMFvvgJONPtvFZKLEHAVa8fcF0D/Qhj4gjy96Vr2sH6n6r7yBaBL2pOtffkW+xBr0k1xMtj4bNr4Po3AuuR9NJuI3AZ+VzKrThSBrzAoFx4CWyQl51b8lHFDV4pLJVCzXznXF4NEZXZErv6MA1i/x1lNrWYfPYybJXqGvLtEtiM69OYgiMMLJm0kBZjM6+o23BU0SLBFx87DdRJ7M92H5OfQQpjvau2NVhppW/2mhyAC9ODs9g/N1gEF5rJaqNHYDe9fSJWyFm/fkCJvJaB24OSHRGs/4Y8lDntLH0Mv4J4SSr56IwR2riNq7DzokwzWHAGfwSjaW4ESo79tXIaK2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6WK99dKONhI8NmDtH37gnQNoC3Bzpo71tdeGhzu9NG4=;
 b=BkJ1c8uPYGFHQ1LDZBwmrgDpZSaEkEekRXmjsOeE7Nk9pUxWYroWEt4uL5JYYZtq1aht/zYsALCaFcw1hCk0StIn9VcK4jHJdyvVu4IApVrR8Ohlyee20JfO91JoiEU3XYmf8FUVN+0KPKFFYtI8iJlQVH7b7W2x2Mhk17TAGHg=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by DM4PR10MB6086.namprd10.prod.outlook.com (2603:10b6:8:be::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Tue, 25 Feb
 2025 16:02:25 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 16:02:24 +0000
Date: Tue, 25 Feb 2025 11:02:21 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        richard.weiyang@gmail.com
Subject: Re: [PATCH v2 5/6] maple_tree: add sufficient height
Message-ID: <kgmriha5tcene5w5hny7vkvx46yw5i22avtqntapmsgclr72cx@bvzncliaywba>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, richard.weiyang@gmail.com
References: <20250221163610.578409-1-sidhartha.kumar@oracle.com>
 <20250221163610.578409-6-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221163610.578409-6-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT3PR01CA0149.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:83::35) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|DM4PR10MB6086:EE_
X-MS-Office365-Filtering-Correlation-Id: cd258adf-7ffd-4acf-1912-08dd55b5caf1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?NMA1RUBppRvfWmd+izu+JGjl3mp6z9rf2iwd1toAL+leLChwOJ9l/9E4CbXv?=
 =?us-ascii?Q?QSRz5kfUG3+XC47o7C7q1+9LJZELaPYzwjBVBLHByqMnupE1Px0NcHUpQpke?=
 =?us-ascii?Q?e/NH9l6gtKJP7MmyYErunbkRITTwcKoVKsDfHQw11Z/xRFcBEGx5Vyrq7rQk?=
 =?us-ascii?Q?VvHSkt5ZXpZ52BsZD6BB2787xFsAW5//XB5c5sTIclFwEoQhcylugsHhFM8P?=
 =?us-ascii?Q?XYjtZyo8EL5tV66px89+XFvWWBplXOiRg/ngHZ9XLSk2w/RnvTzBjlZzVvg7?=
 =?us-ascii?Q?/fe+BLCL/2uVc4HjZg2BRGRPj6ViRGByFJrxpdSsjZdwOIBp7PBGNe4+RKDN?=
 =?us-ascii?Q?+Lk5vyxOtuf27aKpbXQ+8mQd/okZwAj1wfwc5zfJNuYdC+Fg1cYB4nqSegiR?=
 =?us-ascii?Q?9F27vw/CBGj0FherXT4QFK6beuVyRvMQly4zu5kHexwHX2BKm/5qz749bMkG?=
 =?us-ascii?Q?danBepRVQfhFkeaRbW/FouAKDss21rqG9C+aC0dJ53zC1XG2R8Ch+yL4HNYF?=
 =?us-ascii?Q?S5PnGrHwM+9oQGA1VBVwRpuyV2MT2BGaoxAu5spgqOVgXrhKiUd9B2nhW/jl?=
 =?us-ascii?Q?dzIgGay7KZuzhBi+hjy8sx1RfYmmiV+fra1WbVV0VXOEr57bqCRhNKYD2hpc?=
 =?us-ascii?Q?4p9Pq/hl4qnSg3jzp5aGiathxjuabU7mkCdkVDy865Io/6xaXO51cOwvNt1j?=
 =?us-ascii?Q?qbF4phyI27+qGDHktpffyzTYqwmHzstOfu3TGsbYjAPtjh4i4pTdMXA06baM?=
 =?us-ascii?Q?jzR/ZMm++BftbFt2SSOeBTHWoWw6u2x6fkNG9VwOyiy7ZlOLBaiD9letjHyb?=
 =?us-ascii?Q?bvb32kcOBpjOXPG9rUFjQuBLg1ClqhvN8fIZ2rZ2y/j3S9fE3ZYBWFGNeDqB?=
 =?us-ascii?Q?yI8cUHdj1rARiI6FAG/vWZemwH1fvQ4HJzQDlDrkAg/+wokTCbT3n264kMcf?=
 =?us-ascii?Q?JaSPmcJW+ZZ2kdAuvJvf8uxHYW7rm9yroI98GOVd/8gllIvU0lktuPpsgvHG?=
 =?us-ascii?Q?EyT9xntRByQbBBCop/72xH4Ih4lbReL3sUCacmkhOkrUv2un0MH3xwlE9Xfd?=
 =?us-ascii?Q?N1QIUIZlCvqy6ide9Z5nPNQjwb/Iq6PadDKgre8I1Aax+pn8B65aeIivPg9Y?=
 =?us-ascii?Q?MrJOxC9sHF+8y5X8frlRWNDEl5rSEjKjWlMvccFK+oivJJYZ/enMel2Cyvuz?=
 =?us-ascii?Q?EQbuvsInim/RQUTJZpa9i5wLglDiGYErV2fzUau2Z5XYODWE3QpHimjSoKxQ?=
 =?us-ascii?Q?ffyRXsNdn2SyPIZiyz+WAWX1SGi0iEwbsKnivLR2AsjakZWlW3hQMvSlKCiX?=
 =?us-ascii?Q?CdYUMQgO3gWOSZkPcCaajMUWLng7HORfBdoMNti3+I+KCnVx6U/dngIWM6Um?=
 =?us-ascii?Q?q0rnJbnWRzVahN4L064jE1joXUqrviSWeMPHoFGqjmSr3hfLk6K0ERvvOHDT?=
 =?us-ascii?Q?VaK5qBkRfa1+FuEAbiaqNKxiHNMp7ika?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mKLRKP2uOgJlaf18ia2SqGCJi+XEFG0F0P/PbXDdMA73tLMfdkRNjo1Ttfn7?=
 =?us-ascii?Q?DoKbavm6ba2QvK5dY1kUkZBIOx0mBG1XNH6yLfNxuv7Tk63rgWL+XB9SPZnq?=
 =?us-ascii?Q?AHYgW5sF2T9wzUb2jGF/N0wkxG4DLqryGePM3EriRSM8Qu1aKr96UoM024hK?=
 =?us-ascii?Q?p9W+WB9SzhG+bSO/fjTd12WC7TQP2HAnwpZFmgifQefyrcmAyfGxUavAu4rE?=
 =?us-ascii?Q?5Dbfnq25dqjQzQo9CilpqBnXBn3Acx9NwNZ8Te7ZtEvQoXFuynDOsjTzQZe8?=
 =?us-ascii?Q?yRiJQR/UM+Uqyj9zEaNO6FEHCFW3TLLHEbnYdg9NosQwMFban6VKSYHxuXmL?=
 =?us-ascii?Q?3a/Yq2/3zjFW4DQYAYeRa2lkyH+NCmyCfuBak9TjdMAu3wQGugC9zsGTsVsK?=
 =?us-ascii?Q?nA5NFC78kVKG0qrVG4bsH2elebmCKSPks+zVFl52WmkDQQ1Y6GuYx5XIuQar?=
 =?us-ascii?Q?uSuohx4VJM83kXhBTnj/353zkwu9eJJboN3tFOMHLyRDsXe0dhtt6k0wIuqg?=
 =?us-ascii?Q?JJjfeLkc62zG2LGkjwM0s0GM8Y9lWRmmefJk/KL6jK9JBbQpkZF7iVVR1Xzm?=
 =?us-ascii?Q?I6jGD7HQcIdJNQcce6iD/EMA/0rcyXEJ025YYPUMUp77ftrXuVE+jHL9f9dR?=
 =?us-ascii?Q?IDwTJm+gEWlKBTLVqgO09c4elmGxKpwdnJJOL0JvIYg+OMXBpZay0Yvr//QL?=
 =?us-ascii?Q?EfmD5xZ832L+/ech0LXqexMnCC1ZYT9Ks1GD/mIY6Ur9JaDRjajIou+4HFae?=
 =?us-ascii?Q?0kzuO4fUwdrJu8OL+epuhkvz20xihRWu8w7vYzp079qDTGnv4wqJgyeVY/EP?=
 =?us-ascii?Q?R3AouarsGTn3OI0J3brOedpfZkfHJjUstKvdz5+Zr/va4MQLpmhLyfPPwXqp?=
 =?us-ascii?Q?YUyFSKJ8Iw1hQXQI8nMXvTrPPF0YVVsW0aDYXyzGJ5LiY9yfODJx3GdBrswm?=
 =?us-ascii?Q?uIy62PWnMDd1NBQRmqe0ujLAbgaDMup8XpC1GHQKMmQI07nlScCpheRXIPKJ?=
 =?us-ascii?Q?Lg22xYJ3yzmOIxODUa2WX6Qm1xt2vDunFHk6bJON1Ap3l12C90xbHUTWWXUi?=
 =?us-ascii?Q?qjBRrFAMq6aJQYgOLrHEkYMCIMOnZfEAnfcaZNRCGezCqDsqtKO35wL+yOJ6?=
 =?us-ascii?Q?ZQtWpGKaglWsacGpToNA2Mp6AcN1vNKu/sk/E0QvG+sB+0C7g12B4zJg/5YK?=
 =?us-ascii?Q?k/CBICKQkMAvNcTGvrrKM4nPT/t2J28Rp5rKvp0nTWC98f/QITyKNLHERA+u?=
 =?us-ascii?Q?yUogCB7/g2NiYHbyAHcdCwqXrz/W9su/AiYGcF99qqCkhi0l+rt4nYbW2jAW?=
 =?us-ascii?Q?LkRsoPSYWJJMUIGFevO7gkvuI7Biffuz3uauw2E6GWKp/P/U6vVNu1NtPxRB?=
 =?us-ascii?Q?HtedIpCCIkeytX+YOwLIhLTSUVD1ZyjwhUtCBNOf2hOdwh+q00EGDkfi8jzt?=
 =?us-ascii?Q?SDXfNOEYddPoA7FpsTeB7NxwwCe9tMjf+Owk5cAHH5pGrju3jpPd6Jj/8Asv?=
 =?us-ascii?Q?4cG9ozuDYrpeA2JD+ftZNDIuGmW/RX6xJOUlccw7V+jCM8NNeU/EVwDfYtY2?=
 =?us-ascii?Q?yMXD3gtkrZTnP/UUDShh1zt7WcI7JUfWHBufWLzk6wSthFA6qc4/4kyZsE5K?=
 =?us-ascii?Q?Sg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	BD8zKTinsfmkvADaU5KcimWwJuS08Ok6FpwR2WioXd1U9mz5hrzMieJ61p7avv8Q0WGO4hF4RmXPtaArD00IZp6U/DmYPFa3pAN6e5nsDHKWBr5Ke3m455TvP/73c+DMYgZSovnJjHFf9tFtHdxPO8+mjFa3isk9KBTkfEg8WDwRjhVlnCWkqG1tprUd0nHPwN2Z31dyzUsPBZK7ZfudVlstFkENIOXGwP1Oa1f3ZDbIJsa5POEfCCH+broCwlUMdS+dN3O5jWD+suIrwcp5p0mqNRQcxe2mLMzK3rd4owfCIduqabDbEPDsfFl/TURgPyqxddUUH7xbuCL+he0kU5i/8av4SRfM5YCRfyfZzDyf3WBgzD9iO0E/vv0L0j8zx0wARcTs6ik9oaZkjUMfb1GXO2shajMM9OsTD3j24pYApta4/xEjVSc69+8dcHW3hGz7s9gHWoSv1dXDvwGpDwUsZIiQVKBl1wWvvaAzFJBPQ393NefGjAT7wwvtO0tDX76HWmUSk2l2kdZXbFEewrJdmw8pOx3v649jhGHlpReRITW1T75wgy05+OkoM0vdWR/B67yS5RA88cRvGYYaAEhb0r7Q9PS5Y+v7InJrEGY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd258adf-7ffd-4acf-1912-08dd55b5caf1
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 16:02:23.9743
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KuOwmkq6KRaFMjsP0p9M7LxZzxwfLvBRjL42NmFu404NI3sKwcAXwDkH2gHXHzkyFNAeVnZM6fWxgsOn2iNg4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6086
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_05,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502250103
X-Proofpoint-ORIG-GUID: ZN4QjCcZY0pEfA0IJ0bv_1W-Cpkopfv8
X-Proofpoint-GUID: ZN4QjCcZY0pEfA0IJ0bv_1W-Cpkopfv8

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [250221 11:36]:
> If a parent node is vacant but holds mt_min_slots + 1 entries,
> rebalancing with a leaf node could cause this parent node to become
> insufficient. This will lead to another level of rebalancing in the tree
> and requires more node allocations. Therefore, we also have to track the
> level at which there is a node with > mt_min_slots entries. We can use
> this as the worst case for the spanning and rebalacning stores.

This may not explain the situation fully; We also have to track the last
level at which there is a node that will not become insufficient.  We
know that during rebalance, the number of entries in a non-leaf node may
decrease by one.  Tracking the last node that will remain sufficient and
stop the cascading operation can be used to reduce the number of nodes
preallocated for the operation.

Note that this can happen at any level of an operation and not just a
node containing leaves.

The spanning store operation can also be treated the same because the
walk down the tree stops when it is detected.  That means the location
of the walk that detects the spanning store may be reduced to be
insufficient and will be rebalanced or may be split and need to absorb
up to two entries.

I think this commit needs some more text explaining these changes.


> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  include/linux/maple_tree.h       |  4 +++-
>  lib/maple_tree.c                 | 17 +++++++++++++++--
>  tools/testing/radix-tree/maple.c | 28 ++++++++++++++++++++++++++++
>  3 files changed, 46 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/maple_tree.h b/include/linux/maple_tree.h
> index 7d777aa2d9ed..37dc9525dff6 100644
> --- a/include/linux/maple_tree.h
> +++ b/include/linux/maple_tree.h
> @@ -464,6 +464,7 @@ struct ma_wr_state {
>  	void *entry;			/* The entry to write */
>  	void *content;			/* The existing entry that is being overwritten */
>  	unsigned char vacant_height;	/* Depth of lowest node with free space */
> +	unsigned char sufficient_height;/* Depth of lowest node with min sufficiency + 1 nodes */
>  };
>  
>  #define mas_lock(mas)           spin_lock(&((mas)->tree->ma_lock))
> @@ -499,7 +500,8 @@ struct ma_wr_state {
>  		.mas = ma_state,					\
>  		.content = NULL,					\
>  		.entry = wr_entry,					\
> -		.vacant_height = 0					\
> +		.vacant_height = 0,					\
> +		.sufficient_height = 0					\
>  	}
>  
>  #define MA_TOPIARY(name, tree)						\
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 4de257003251..8fdd3f477198 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -3558,6 +3558,13 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
>  		if (mas->end < mt_slots[wr_mas->type] - 1)
>  			wr_mas->vacant_height = mas->depth + 1;
>  
> +		if (ma_is_root(mas_mn(mas))) {
> +			/* root needs more than 2 entries to be sufficient + 1 */
> +			if (mas->end > 2)
> +				wr_mas->sufficient_height = 1;
> +		} else if (mas->end > mt_min_slots[wr_mas->type] + 1)
> +			wr_mas->sufficient_height = mas->depth + 1;
> +
>  		mas_wr_walk_traverse(wr_mas);
>  	}
>  
> @@ -4193,13 +4200,19 @@ static inline int mas_prealloc_calc(struct ma_wr_state *wr_mas, void *entry)
>  			ret = 0;
>  		break;
>  	case wr_spanning_store:
> -		ret = height * 3 + 1;
> +		if (wr_mas->sufficient_height < wr_mas->vacant_height)
> +			ret = (height - wr_mas->sufficient_height) * 3 + 1;
> +		else
> +			ret = delta * 3 + 1;

Ah, ret was short lived.  Okay.

I still think this stuff needs some more context in the commit message.

>  		break;
>  	case wr_split_store:
>  		ret = delta * 2 + 1;
>  		break;
>  	case wr_rebalance:
> -		ret = height * 2 + 1;
> +		if (wr_mas->sufficient_height < wr_mas->vacant_height)
> +			ret = (height - wr_mas->sufficient_height) * 2 + 1;
> +		else
> +			ret = delta * 2 + 1;
>  		break;
>  	case wr_node_store:
>  		ret = mt_in_rcu(mas->tree) ? 1 : 0;
> diff --git a/tools/testing/radix-tree/maple.c b/tools/testing/radix-tree/maple.c
> index d22c1008dffe..d40f70671cb8 100644
> --- a/tools/testing/radix-tree/maple.c
> +++ b/tools/testing/radix-tree/maple.c
> @@ -36334,6 +36334,30 @@ static noinline void __init check_mtree_dup(struct maple_tree *mt)
>  
>  extern void test_kmem_cache_bulk(void);
>  
> +/*
> + * Test to check the path of a spanning rebalance which results in
> + * a collapse where the rebalancing of the child node leads to
> + * insufficieny in the parent node.
> + */
> +static void check_collapsing_rebalance(struct maple_tree *mt)
> +{
> +	int i = 0;
> +	MA_STATE(mas, mt, ULONG_MAX, ULONG_MAX);
> +
> +	/* create a height 4 tree */
> +	while (mt_height(mt) < 4) {
> +		mtree_store_range(mt, i, i + 10, xa_mk_value(i), GFP_KERNEL);
> +		i += 9;
> +	}
> +
> +	/* delete all entries one at a time, starting from the right */
> +	do {
> +		mas_erase(&mas);
> +	} while (mas_prev(&mas, 0) != NULL);
> +
> +	mtree_unlock(mt);
> +}
> +
>  /* callback function used for check_nomem_writer_race() */
>  static void writer2(void *maple_tree)
>  {
> @@ -36500,6 +36524,10 @@ void farmer_tests(void)
>  	check_spanning_write(&tree);
>  	mtree_destroy(&tree);
>  
> +	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
> +	check_collapsing_rebalance(&tree);
> +	mtree_destroy(&tree);
> +
>  	mt_init_flags(&tree, MT_FLAGS_ALLOC_RANGE);
>  	check_null_expand(&tree);
>  	mtree_destroy(&tree);
> -- 
> 2.43.0
> 

