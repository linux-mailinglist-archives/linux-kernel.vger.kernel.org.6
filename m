Return-Path: <linux-kernel+bounces-348723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD20098EB0B
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 10:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC691C20C3D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 08:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F013B137905;
	Thu,  3 Oct 2024 08:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MUVD+oAK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zZ0AQBEW"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60C2136657
	for <linux-kernel@vger.kernel.org>; Thu,  3 Oct 2024 08:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727942799; cv=fail; b=aKP/wla6ZsCEbkqOH9r0/CLlzkYiWb1wk+XLZOpCKqKateNpp5oSd2HRmWx6iIrSzTrDhyL/1QvbUBWO0qBWVqNyKZegUZddcF2P2rlmYz5uMMZCV4AYrYrj8bGNWaSAWaOhx99h+9DfPdwJtEgvJTRIxttRtNSCYzH6vKLyGck=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727942799; c=relaxed/simple;
	bh=31TfIrflEMad10EZ19A7vroQNx4G4ejc11VctbPwqtY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=uPV6NuuVREup+14b6rPhf6IEjqPt1e/o2kVivDS2BOU7erZmpYJGvubEmaHLFAAw0cdgMqhJr7O0sYmxLGcWmDkXNkQVCVHd5zeRiz28Mq4VKMTU+J5TlE8t0sEy9Y7WD2K5MbUfdiwmM5z9MhSZBvDj6Bp4MHbC3tmIw+//ePY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MUVD+oAK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zZ0AQBEW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4937td5R023966;
	Thu, 3 Oct 2024 08:06:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=31TfIrflEMad10E
	Z19A7vroQNx4G4ejc11VctbPwqtY=; b=MUVD+oAKZfRi9fuMBaGLCDMHgQDOKtS
	zEwjEktGB4dZ5EGwcxlI76BcQl1xdfoJj2v/UqeTKcFfhhLfpjm+4lvFBBrd11oc
	YKvEuPAv3EDCPbPHXjS636bGIr4MwNHwC64victZPr+XJv6OiMBcWOCy7d3HDSv7
	JzpmwZ/lcsxcCF1RzfR89FHzrCs3C0lMjtCoDHvb3mFfM1USQEHMvtVDZGUZybaK
	kB85DRUwZhWgYHDgcsVWVcqSAKa3xypsIr6AFiKEaR7gF8LPKn//mcPwH4dVKn9V
	W+mGAyB8BeijRCGovqjxWcAu1yq3+zCwKqYmClSNWSWVtQRiglyw33g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41xabtubga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 08:06:29 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49365atu038719;
	Thu, 3 Oct 2024 08:06:28 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x889xdk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 03 Oct 2024 08:06:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gjZtV9IzW2YEwjXhzN/6basv/mWN/Iv4YsuL+aL39wOJnpeVh9QpZSkejSDD77j/eTDNHbDmWAK5GnAWVaqSzweN+6OuLo39Q878mNB5mMf94oBDZ9OfIx/VfVKCvIGBwW5Z7WZfuaq1k5TS2itIoNCYCmNQVcugHcAaviaCyH4RV5PF7N7NmXAcQAD28QozK+DVRU0BvNnaaQ4/iRJlOVRMnHSQtpiXBpa6rNc/0R7voMC3RNab888zUmGjH89IVkHeMppXNvrZfD8ZnlJwSqkn3z4LlW7kOuQ4e++RHB2phHnN6tt4YRGgU1JSftVzEyRe1W0GpMPJ+Ngfju3BTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=31TfIrflEMad10EZ19A7vroQNx4G4ejc11VctbPwqtY=;
 b=BLdl3UcGktIZ9dOAbaU6CQfiXzWKhb0eMkAGYbgPuQMpwIIV36791vm2KSPUZi6hImqOKrkMu1xCLz8XIbhV8JM5u0twNT8jdV3y0SzX1+fR5JeRCTkQNsyz21jTMvrKypa+0vO70knNdu12TRerpMS2km4iJOJaxm2BHWPB9DNr/anK1cBFuvpoPwavZYR6PL737qoukD+a6sO5cP9RubIseLtKhlH7p4CGDNWgpg+UhksCYXfvbFtd/cVHoItGsRt3Xe+Kiw3SsnXDUDFNf/hvPdHbhwRnWQQr9vyvy8CS3bjKtvLop3O8QRGCfJXsMoGywHlveS6/C5m7dyVGmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=31TfIrflEMad10EZ19A7vroQNx4G4ejc11VctbPwqtY=;
 b=zZ0AQBEWQIvgUMf+wdXAb7F7Dt893b/+X7vpmCnbadUaMnqhivKAbPNeieNz27wBlbEXrpNRrcOQp0IkjdEReSwpggdACnELJO0fZ7yJKlFrtQB+TUy5igZRG2wYaKmULyuoaM9VhKhjCC/kZoSYVHo7zSPlVUx1Mi6MeimsqfU=
Received: from PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16)
 by CY5PR10MB6072.namprd10.prod.outlook.com (2603:10b6:930:38::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Thu, 3 Oct
 2024 08:06:26 +0000
Received: from PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2]) by PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2%7]) with mapi id 15.20.8026.017; Thu, 3 Oct 2024
 08:06:26 +0000
Date: Thu, 3 Oct 2024 09:06:09 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <a7cfa348-1221-4389-b3dc-71f3735cb1f0@lucifer.local>
References: <20241002225722.3746-1-spasswolf@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241002225722.3746-1-spasswolf@web.de>
X-ClientProxiedBy: LO2P265CA0098.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:c::14) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5611:EE_|CY5PR10MB6072:EE_
X-MS-Office365-Filtering-Correlation-Id: 87204c8a-1588-45c2-8b4a-08dce3823fc8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|10070799003|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8r9Rwbvv9lrmbxTJex4HYjaAzXPdUFhgH4AyFgFMtWcxkyJvZBg3v4NVBpnq?=
 =?us-ascii?Q?Hcde9ibNVsRSDsG38/W4onb0Z6dK0GpZJEU90gBgbhWWcEDkt+M9GcSXo4Cg?=
 =?us-ascii?Q?/VqOkunisKlgyEBBN5LbSwl/xaKjnMEpRb9TYT1147lNySGtVZRg1cabdXcg?=
 =?us-ascii?Q?DwWVOzODj8YIt/5uH2a+yVWWqMEmIPpSG8EAvpyopzf8lnA7FVd+hMCQPu87?=
 =?us-ascii?Q?9J5D6gU7lm63OS0LdLhQWadMfc823CjJ1S3elH7cmt3agm2742hFOEAaN14x?=
 =?us-ascii?Q?KCerpq+lYVv5TdeYMGRGU5RL218Jh+j7p6wiOmVK4oTNM19cLXHWk8yvcRaz?=
 =?us-ascii?Q?pw4F5I+bTxF9L9OlJ5moZaNxxv2XsfA1G8/b7G5p374fvIxBtL8Nzuj7myPS?=
 =?us-ascii?Q?yIFQZh/+8YBKuqOMzUREfr21EtoVUFkJdhQyMjU2OwBwhzthrGq+3j1nvnoq?=
 =?us-ascii?Q?c2Z7mPLpfpkTcpMDgznf1Yr07hegIH9CpbvCl5moloGruFB8OuzjqJ/1PY3C?=
 =?us-ascii?Q?7UAZllqIXoW94bTpP0+TWNeWqIWm9wuPFSZYtaaP+ZmrvUY/0ehsQEZoHsej?=
 =?us-ascii?Q?p0d8e9VbBM68gW0y5c7mHQkbJfdngP/wRXpevvky8QZyOiREP6c4wLvu5G1N?=
 =?us-ascii?Q?9LD/klVBeSw3C83e9J7wrvLnX375v+OqfNTYirZcXbHewUXGdiHPrdFMLoGV?=
 =?us-ascii?Q?ixH5F2VwfPuV1jH4HVw0KdsiQk11zkYm01T1w7LY095gj18RfacsF8xZlm+m?=
 =?us-ascii?Q?NSW738iRVekeIDYVzZU+TUANe5ng3DN6sJ/ikAm9huRky6KLkx8pYNkVOuZg?=
 =?us-ascii?Q?vRmYF3J6EIRpxuvbYjQi3pwHma1jnkOukUpzjNW1ywQ5zIaOvfRoS5ctgA0v?=
 =?us-ascii?Q?QAJ+c15n98boOz8U57nhGJUHQx9HEJCT6u2F78EHlEqgyaZOhs0Nrdr8w3R0?=
 =?us-ascii?Q?0hmSPW/ylAaYd1elUN5nFUDErNeHD80NHaBsxo8OdkuxApXa9NVJD8M2FcR8?=
 =?us-ascii?Q?ak/leb5O6xeKrwqKWN3Km8Qb5v5osZYhr93kXpREul9qJorkjxtLq/VRyOjo?=
 =?us-ascii?Q?geTSHJXvqPTlf0yytNc2DgsHeUdtrAczCUntdCX8DB0RsrNnqGEg74xJrOXw?=
 =?us-ascii?Q?tjz7OQHqst+OOoDn+k6d1v8jJhcAbrcyuZJz74FT3+Ih9++2PUomFtv9JEPW?=
 =?us-ascii?Q?YKQyvKdLXs3EFIvyt69qDauLiKSq3GsG+wZGOYTvonYVxRIiIWFYVfEnBHW2?=
 =?us-ascii?Q?P+OIhgFP6A5xCx5pXuQQLsJOcvLsjAznKsNBJbqT5w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5611.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(10070799003)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8uhzPcJ37K+RhBvM0MrsklYbObazhn7pmcY4a9IpoyvdDKDfJjY/uGSG9ST6?=
 =?us-ascii?Q?GDNcg6jD694OHqlD8g5iJ6mQ4jQF2zFxnhIRQtreL3sEqWWubBnf0TjWpXd1?=
 =?us-ascii?Q?SazraJd+Ux1+6zWY8uNhd+TnAAi2rCAvC40Mqst6oiXuw4V8YqEHNMH1qWpj?=
 =?us-ascii?Q?ib7SVxIqI5ziAweuQY4UyOtOiE7aLjRzhy6gv7pR8lSvX7DTdAVUO1wvtfyJ?=
 =?us-ascii?Q?4YXxo0Rsw/o5GzaJyCsj1CQ7owm5Q/0cGl7tfCk6cXr7pFn/xEGlpyjbZtUI?=
 =?us-ascii?Q?PqNMQnisYxBb5QLWo1T1hdSPvGxOa9eF8x22KrgKtot5uq0LSXnabukYfBx/?=
 =?us-ascii?Q?JF3OSFYrxrSP7uzdTWhDllpLedROCD3wMyOeFxehucZA9Sft/b6hNh913JCL?=
 =?us-ascii?Q?0+XEY6Irku4aL6EmSP2Fu4Wh5MBiSN7SB93NXRSnn+LpEBxV7QCVEe9eI4OM?=
 =?us-ascii?Q?a5ChSOJftQCVjIvopYt7EQeDEcUAf0SAbVLV+11E5LzgQGyPusoAwNCWOqzg?=
 =?us-ascii?Q?mSxkaUbU7FqWHRSjJ+zUHj3neCEwLTrhQDW5tIRXDiOySak6kxtrY4sw4YYT?=
 =?us-ascii?Q?Ql3jbRfbOp0HQk/wZ2UxmZyGH+ta1XkmRb8v8xB+Io3+pi7pDkQ2BPmjARxJ?=
 =?us-ascii?Q?OiUojCes5zbssMOTylZnSZZRROBvGQ735kdAWt5HypMqvNzrLxdBqaEcv3ay?=
 =?us-ascii?Q?p422gfCuqcMd4kdHbcii1dgimL6fq5519RUQrNGpCE1/DA0oqOMOO0d/xHRI?=
 =?us-ascii?Q?5+buunvYE7zPal5L5QuBjusgQ7pUhFOORZt7dmtlNxDv8ANvB4g+ThYQZXo7?=
 =?us-ascii?Q?Tymi+Xg2EzKsWQDntZiD+alIhcbAnMG1wZRYILZpZgQWRYns0RVgKEvRymOw?=
 =?us-ascii?Q?kxIviZOEgExV6X0pAeHla09ngInR1dk7pV8g0j2Lt/OxOzt3qSWY/O+FEbcM?=
 =?us-ascii?Q?36DD4POu7TnYgL3mo1q5mVXRwDw4ABkfG3N3h8WNopWA1tihTNI6FdseDHUd?=
 =?us-ascii?Q?IkAwUaMJffRNWT42D/FOXdxZEHSEbDUH4vsO0YZNKO3SUcVj3p7bCVoHMpBa?=
 =?us-ascii?Q?PSfvmoQRiEhWJqQU+BCKhIby5sBL7lllUUVEnAqjY3+TuM5SIuwp29oGH8G6?=
 =?us-ascii?Q?EmEwenz17Pj3BLusQXM66FMxgGMU+duAcBatiMbw6zL/UlZ93/8OfXcwCy8p?=
 =?us-ascii?Q?8pos4FvHEBO3/YjCdeXkRMxbgE9t5aK+3nvCqjyggRhAjabYXAOEMcXhYBjL?=
 =?us-ascii?Q?yGgplEGy/s7j6wfslh8/5Fb1BXglRcz1C4FFQ1LA0YzA90JFQDz2FzbtMs3N?=
 =?us-ascii?Q?Et0P1ahRo4SojiiFKUK9fPRwCpIh5DWDe0ZA6KKSVvcksoSnc2Kx30tnJxXA?=
 =?us-ascii?Q?laDf4paoCAhLD6QFvUhZi0RdRzLmq8qPQYuAvXwZq9pv3CWMwj4Lgt47lYmM?=
 =?us-ascii?Q?Ft01Q7z+vpRfzmUEJW2yEjrVuewb09303z72jxO1yU+o2XQVMXCgjBSWU41I?=
 =?us-ascii?Q?rd+SqmFNNejSmgfP51050y9wjbckT+G7AIUMdO3xRvHpZU+5+gT6Sl0mGbqL?=
 =?us-ascii?Q?pPsIoe7C+5tbC5vhHnnjQy/EdxYwJEUCnMVnksShXT6bj5kHoRRX6YwLCl5D?=
 =?us-ascii?Q?kXbBTYdkGHX0dvsp+emQKOChzG1eOIftFfbulz2avtdipV7k/z2qu8lhd7GE?=
 =?us-ascii?Q?23oWwQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+JAhZPuYbv1C/u6g64SXODdutViXPLkunygCA9f2vwjLwcjaWe2A3wwam8DUgHfJDAGpFf47W/u5lkNdyGEiu1iIUwUXkTvqBxNaP8YfrWI0gKbsd+h7ZdJt/aFHzASQWb8CJOCtGs4WP351LUVqL9g2idbWbs6gmLe5ljizAnwduvaGuTOfrIoBzrrE4nqbufQomc/6qhl9y06Qw2NfMLMXkZrnDGXFgbiNddoJyojDNzjfg8Vwn1kML4M+OyGzq5bdl1Wi6iqV/Oqy+ROAzvyPUMYfNfPYjcZNZmER4gHCbx26KtPTJ0ufwqaEgxH+N/xGsJ1pkkioTW0O+LIYQctZ9LxLYNTPMVvH5lQ/4+ay00uVYu/8uq9SuI/lzQkPQWi3Pej+6wNyaDwLcjJ4IZBsRTyjpbkiWFVeVVrhFSypRWdR5b5ZirIhR3HJVHmkV1mVEtrpuQpKCmCATjD6pZiIimJtgIllQkRafIE5K6ZUXppkaGgBWqk2nBEhi3CuYvWcqASaLl3B8EDg+y02X4kL4zsh6mwc25IrYUl6JB/05UB1vTOMd2gi4ThYepY5bwa1ujPof4VQb0CmsZrfGvo4bV1bm0Pyh7tvRjwAiKg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87204c8a-1588-45c2-8b4a-08dce3823fc8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2024 08:06:26.1640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7qIUd0m86cdOneY0bePMrrhiNGv+y79hG/U3/p6cOONHBuNGBpGf42cqnz49bvymr8CAKzb3e7clhmlSVEB4Xz4ukIMxQ2F5MnfQjOOZ/3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6072
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-03_06,2024-10-03_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=843
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410030056
X-Proofpoint-ORIG-GUID: Vs624FQVExCeL5q6U9zPIN0nAohpIWeP
X-Proofpoint-GUID: Vs624FQVExCeL5q6U9zPIN0nAohpIWeP

On Thu, Oct 03, 2024 at 12:57:20AM +0200, Bert Karwatzki wrote:
> I justed tested the same kernel version with a .config which was created by copying
> the .config from the standard debian kernel, running "make xconfig" and saving.
> I got a crash here, too, but only on the second attempt (this has happend a few (~3)
> times before). I'm not posting the log as it got to long due to the repetion of the
> procedure, also a standard debian kernel does not print the thread id which I guess
> will make the log more confusing.
>
> Bert

Can you confirm which file system you're using for the repro? Thanks!

