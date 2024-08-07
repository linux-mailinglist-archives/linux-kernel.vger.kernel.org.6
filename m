Return-Path: <linux-kernel+bounces-277937-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A4694A869
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:14:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C74E61C229FD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C11701E7A35;
	Wed,  7 Aug 2024 13:13:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RSXsTQmQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hluBD9SR"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB321E4EFD
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723036425; cv=fail; b=pximfzEAboBrS3TG0epleviB9HvZQVs0p0IHKlSDGoAB7yk8Gx2Y6zt0Jn8gaTSAkoWu/nU0UFBrMky6EabUWRRodrXhxNd8Wp/FDbm4ZBXMoPU+vwrGHHCe7GfqElJ+LP+l6GTVnxkQnMsaywLlM/+buy67mV1w370y48MqcXs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723036425; c=relaxed/simple;
	bh=HzY8vcGSS8N4rmbim6Rzq2u8A4SCdpyBMevGH5lCPQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KUDJVHszW2KWTr1LSBsJESugaRAQ4RSSCKGit9jPlxzLMbeIyyn5hsHFsBWLa0I4BJahLTBmDKWUFU17hQkM5qXyQ+OxnTPhHo6UnBXXAXL33a69nYocjWYvHdd+smIlrsC9O9JwCZLTZVuLf2wXWwx20z6TCvdfffml/0ra1Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RSXsTQmQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hluBD9SR; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 477ASbAJ023497;
	Wed, 7 Aug 2024 13:13:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=GjmppoYnnWg6mbh
	19vDNCIE2bVjQFFWAZrkCVH720bg=; b=RSXsTQmQffCqwnGEjkwXjSSM6yU+ARZ
	YsgMCmeYJcjgv6GsjYI4M9Z5UsZEa8cDy/LLmFcoTJmYniwrVNfK+ZC+/CBIUk34
	YOWmVzvlYtSjKv6ofl7eZWmuWETCXX/L3BtPShOE4IVvx4Iv2/JCdg8z+NNupLxI
	3Lw1HKj9lh3RYO3KNP2dxhbDNlfn1ZjLwYMIApScolJhSXaXNkLiomeJT1hVDjzc
	8D1qwpSTXRlEDz30CE1chARs9yXEUJXxojW7Kzzk9pRBKI/ljFqwud3njpCxw4pT
	yZBcK0H6f+oitz5lM55a6ofPsB94rgxlPcuXOQjM+KGHejrQ21PNM8w==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40sb51fjd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Aug 2024 13:13:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 477BlZwm027310;
	Wed, 7 Aug 2024 13:13:26 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40sb0g9et9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 07 Aug 2024 13:13:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jkePaRmeuXYmgkcm7IDtCy41fe8mRc1VROrS6fjDRthd33HTVKGMPfeioJdy/h6AzyUes23UP3t+6JIZFLgZK35YllLRh8xOABNdpYkJQpRDxfgOtFv9CRpHPXiP2LB4vdOwJEepX6ZAUi8dDKRw9LNkOB5H3jl66+n3PXHJf1NMF50rRGr6wYm4VPSkRGjEvIC5lSh2ET5hvseTDqfGp+t/XvKzIJ+FoM90y5T5I+H5prnroFSlQkcjV04Z1Z0TVI3mKA1SQ08BmpKGwhlMlxAY1ZeHn5TM6H/Gjq6j3vehv3X7pcta3ocVE3BZmUUwQDz6xzyAMoaioRKC/Q7TmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GjmppoYnnWg6mbh19vDNCIE2bVjQFFWAZrkCVH720bg=;
 b=VBb4z/XRJli89VXLFRZUtS8ye0LpnDeGWhg4DlF4vh42/oJ42aB+2xcIZ1TW7DrqRPoKL3rfOKeDgGKo7kHGqn4iiRQyPDKQShMXOs+9yCR0+1phC8LgVEJ2etEK7CtGDyJHYMIQm9pwWkAWRr9xgNSiz7a23M32sKu4x36wpyhcbfGnYr3MbFpokr4iXXI3vYXlWeSWRctrAMQiU29fUGtm20ziv6M86/0RRDToC8EI2cz1c2ANsXrkdto8NCrYTI+7gXDeQUCfhKFHzQ3Ym53lmrL4b35OOFaUjkyt1VXrLFBpTmuhnMqt23kj0oBo5qS5hDqQqpyDNPW/a+ZHHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GjmppoYnnWg6mbh19vDNCIE2bVjQFFWAZrkCVH720bg=;
 b=hluBD9SRUnha3pD9sxfJ7wVtSHZRJJlbJQW29+vtq9/YgJt21THnI9wBE/n+MHFbuTbh4zV8+ud5CRspYsaci6B5cXsWPBZtHphU+ZVv2AUcxyP0or/Lrx16ZMpc/3ZVGF7lsxW6iG+eJjNsPy+BuatRxdezPfxpR53spwusQck=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by PH8PR10MB6647.namprd10.prod.outlook.com (2603:10b6:510:221::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.23; Wed, 7 Aug
 2024 13:13:21 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7828.023; Wed, 7 Aug 2024
 13:13:21 +0000
Date: Wed, 7 Aug 2024 14:13:15 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, oliver.sang@intel.com,
        torvalds@linux-foundation.org, jeffxu@google.com,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 5/7] mseal: Fix is_madv_discard()
Message-ID: <7c62d837-d205-4924-8839-644d8981eabe@lucifer.local>
References: <20240806212808.1885309-1-pedro.falcato@gmail.com>
 <20240806212808.1885309-6-pedro.falcato@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240806212808.1885309-6-pedro.falcato@gmail.com>
X-ClientProxiedBy: LO4P123CA0390.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::17) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|PH8PR10MB6647:EE_
X-MS-Office365-Filtering-Correlation-Id: bd2b7941-268a-4989-6598-08dcb6e2b63f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gtA7AG85ewcr+CAY+lUhV+/+GI3uMR9nyz/irTHwvr5sCaKQrOlr3mQahUjg?=
 =?us-ascii?Q?pjdSyHm3FuKN0QQNdU0gB1ib9Si5oRrUd6xsl/YFH0GqxMRuXvf8sbQ/EXOz?=
 =?us-ascii?Q?fcy+pwXbpdyceW4tR5oPR2TXMyjfrvL6Y6QsatVBS8VbhlTa3Je6Oxsz9Udz?=
 =?us-ascii?Q?aUGpxN1fBdtsLG3joYDfz8BEgrHgpeTq/WkRY72rSMBzwVW7ROxqmYUq+0D7?=
 =?us-ascii?Q?YlXyW3+Z+Rcbdiuhx0j9kiXruq85zCMeZcVcmr1g5cuUWplKbjI1c82+jEdU?=
 =?us-ascii?Q?hW2wNEychA8db2Mg1vOhC/7lZZLu5VVwuQDiXTezBHCPiZcDuLei0DGa8ta1?=
 =?us-ascii?Q?4hAa3B3swRcBFN44or64CotANp8HxNGdQGsVaRabbA9ZSIRcH/eYKEov2nD0?=
 =?us-ascii?Q?9dF6r4TnUJqXtBoZq3wylnia/uqt4lkU0Rtdj71FhTIQUQZu/fVhy11oP/sb?=
 =?us-ascii?Q?Xitnrtrwm0q6pl9mDZw/kS3dDiVbViF4ESiXcKKfQuXNxqV4QKDeVsxbRwwN?=
 =?us-ascii?Q?lxKPoXP/b5EK30nIqIf+PHjz8knN6r6bNJ/A+To02meF3Yoz4Tdrel64XQRm?=
 =?us-ascii?Q?mXbN3hI+d3vqIjFhX1QCfws9qyh/fST+QT7carfTLIPGR690eAQf599ClVaJ?=
 =?us-ascii?Q?BmFYn4J3czNbVHAZg2YnheerTZy8Dfni0vfjYalKQpNvmMYgI5Sl9bO+FqFJ?=
 =?us-ascii?Q?9w3c9rWT1S+D3c9K2JPDM/SJ0mau5syFjW1H82iF/4U4r9GHeW5izw0j31x4?=
 =?us-ascii?Q?O/HYhTnYJlyFs2jIBJy3sNSYOhD/+lLBOv8UOj7Zp0V4ztMjSQ2uA9n0gVHx?=
 =?us-ascii?Q?WoaSaDGQw316+Nf9k4zyChY/yI/MvEGIJeDv2GtxpwzKYPWrgheVp2WqatVI?=
 =?us-ascii?Q?GTHMZ1c7bf2Lud6gdpPWlXPdnxyt9tz2A19zDrNMejlFPlHwzs/5iNOJ5MIP?=
 =?us-ascii?Q?AzV1b/dM+pOqmB82XXpDIQnj5I6SRHp25RO6dm5Llij3TN4xKp6cYq+o8tMY?=
 =?us-ascii?Q?+r+uV96NoaPo8a5k+rU05qAHBsJuVnx2nrtVW2ICML8PY/5prwlMq6DbL7sd?=
 =?us-ascii?Q?a6Sl5TBHUoA5DV7qVzLSqftaEpAjryGLq5IKCfGnXrNiXhZGKmBI+JpfQ66b?=
 =?us-ascii?Q?rC7vI+TvZQBLCHRc1CSocRKN9uva8PjVSS5bChUQ1thcSSZL2v3gmu67cxkO?=
 =?us-ascii?Q?MYbmyCXlwY3Vb1TyResIsu8NerjgPtfxB7U2BIumK+cdy4CoBKK8mfmnVruA?=
 =?us-ascii?Q?Z7Pr3uAJ3+tfu0bVubl5L85J8N0opWqPza/T2PgDF0ft/8xbSAQUGlHH3VYG?=
 =?us-ascii?Q?Ej65/LJ3yLyg/egXWUPnz7ha36lJWrskaTXMLSIuvMDrEg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7HkIQTmcWXaoTPjKXabAuXls5Oslc/PwVXfP3M65LDkUb+dtPm6I+nC5mrD0?=
 =?us-ascii?Q?KFyLYLlHZYYPzlu3ne/MW1iF134SyZKpIVczNYGAnzhckQW7K1TeKjmYj178?=
 =?us-ascii?Q?y2k2YDi71QJsZn0rg8FdWQcxFzrGuCQy1XRlUvawGXGGS488+AoAOJ87WSEc?=
 =?us-ascii?Q?qSL1tV6tCMuZBD4spaBkvQ/lOy5O56zly7g6w3bFG49dNEHcgAuI35b4O4Ap?=
 =?us-ascii?Q?1lrYlyylbkBF/qocZyaskwD03M+/X4mXYAY9w0DUaF5oziTEoC0P2EYAxVHC?=
 =?us-ascii?Q?ITFq1olCakIlcdGskl7sHYVB74yNghQJ4HEtTS+fR0LKrIbyQW92UVAIVjTm?=
 =?us-ascii?Q?OtND6eim7RZRFSqYq4JwhQXjn+kE1JfrwIJYXx+10cKvYpf7c0yakznUDeU3?=
 =?us-ascii?Q?9msageH6MW5lcjFiySwt96eQrjXFNVUSyxl1a/7Kr3ACjP5VZeZtfV39p7qL?=
 =?us-ascii?Q?wBP8nB7ZcbA3jAOw2G7GtBeD55CsNwavHGSCGIrS0RHu/+rlg4nRzAPiB8ic?=
 =?us-ascii?Q?GyQ73rXpoLUnHDIo6l+GkaDPbif7TOia7EK2D7iDzP4wKFnMbPmQM8i5cNbx?=
 =?us-ascii?Q?UesHlHSOjwJZzLAmBWc6tsx8h7RGE4/GQsr6rDChaeSkK7h2RjzIYq8t/Wec?=
 =?us-ascii?Q?gtwHv/OknoxuWPr5eZ9WJiMi0oQ1v6DftXFJh1HosTPjpWdloP8Xg0lmwhfN?=
 =?us-ascii?Q?J0fNxirotNQAhfyCpwr1DM74pe1A5kOCvBGnvWGbsXPK9cgFRw0+iJ5Oqwjl?=
 =?us-ascii?Q?K1dMifKIUpEUTAv4wfsZYSg5t4ZY0KBf1626+6YoyKz48S7+0YqCceaeGWKN?=
 =?us-ascii?Q?+a80kL8Zn6wGErs6QYmvlCe1t9KXPqHxex0smAQlWFWI5BTYhlQpagWtEoS1?=
 =?us-ascii?Q?3FW5dE0yutqD9caoZKPqhE6xwUagjdY7r1JwKndEhIBW34jcFK4DCIT9m480?=
 =?us-ascii?Q?Vl/519Tnzu5DS8vAHRz5PVdCa5FRrUj0rXCowpgRavqOB+nG0qxmZviAhKtY?=
 =?us-ascii?Q?YcttHHvZ+6tq6mFS/oQaodfSPymG8ugcOcTR4TOHWQuFsckbdD5n4lq19gEh?=
 =?us-ascii?Q?Gos+3XhMLdZOLySjsvO1inP89GVE78MuAXhumI87OAS01mjOWO3AI1Mbnvcl?=
 =?us-ascii?Q?BZH8DGW7YgTAj9EJrYqbuD5TW70x647AzAfm0BmIJEmel/KGFWu2n/XRqjFW?=
 =?us-ascii?Q?Wsws5+n6q24NCfk82Dcmats3Zp7ZkRhrQJIGcL17PGL7o9QRpO6iFSZdz3JC?=
 =?us-ascii?Q?5nyTYfUmuKU8bpBG8km9JLRabDlpWebs7CZT8gPIgfOrqiRrZoNnxOl1oWyg?=
 =?us-ascii?Q?JNQV6nqZIQiXJNUVcChVmEz8PM2Atkszh90b9qrIONrTtqAf0bXD6ohP5uJM?=
 =?us-ascii?Q?NHrZWHMRhW+kfd6Mm6ou4DKNylW4BQ+sImzxBdgg9yXGZe/euAqh5V/XJy95?=
 =?us-ascii?Q?4qdFYGeQ86Fx28kcTMo8wFwsH3SEN87VDs8wbn2dOvrUZcyofygdHYGLMaBq?=
 =?us-ascii?Q?vPV8m5lK4t/UZBdnhmTLsE7m3c61/Y51faNHlc9PwaVtKWu/HLeONz2eG9Mo?=
 =?us-ascii?Q?zKK8pa4YKbxog4f/YSmRkp/czD2NHzVDjjW8ZjJk15vP840YCqKU1ykezk3q?=
 =?us-ascii?Q?vNqx4TddsAV8ZKPSX6Cwpr4rYaZez7/W8Z2HfotNKGeM/Wa/5ywy1GGyseuk?=
 =?us-ascii?Q?LkJdgA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+CDku9kuMvFQCdxURseDGI2N6AN8BDZ5mxU62pkFWbygBcoirT7bbkpqLfQ/UFp7EmC+E6Ggh9+TQRKYQxS5w3QWuCwyyJNmBwbEM5SWz6DZfjHZ2MWHHsQBbKykDp2Iim8yOkjRqlhHA0UXN9Cp8gfIINC22VTlFGgyKONjiBS2bv8+OecX1ugyk5Gm56mrvXlWwOOKsjJVRapAYy71fPxgr63qRmxdJlgBwN6oD57aCqpSdS6bzaTMS2TXqN5/iin1HN9JeWgsVJmaGtd8+JwctEbaly+fQdXhgVUHQX1OHESC0UlCoGOCOevKvDUB/bVSi2iAaFtDewkciDjSeyEzf6AaavVuvuJ4ET260KNbXy+XYYWUE9sp5H1Z5ibWeAAAu9S02UUfvB4JS8+MZ3t9aWcaCHJ6tsiL6CIPJhxrdC0aTVNwRkmZRNBkbnR73ze3iDp4Rdzua+1roN8n0F7tQZ9CBspFToglfsOOz96adIIEVNAMifN0MoxquEMCK6IcALRjrfYsZqL9yUhywhIYtryFnqypKFfvWALqxUJG/2mZ7SPNrPOKgvhBFUbzu6VJpHeGUHYGlHuEuHZoLcKtBzoi41BgIA6sjsNWxO4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd2b7941-268a-4989-6598-08dcb6e2b63f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2024 13:13:21.7533
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rLxAySLTVGY95Ft+YOlUtpEgaKB1yhmcWvflEi+dT1zxsCX9V6KMmJt3SnV95y7GsE6+0lWPCPXbWVGyFn+yszN5xumAlaMs5jzctLicuYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6647
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-07_09,2024-08-07_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=967
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408070092
X-Proofpoint-ORIG-GUID: i9urpl2LTRC6YV4yVLjyRmhu4-lezi7z
X-Proofpoint-GUID: i9urpl2LTRC6YV4yVLjyRmhu4-lezi7z

On Tue, Aug 06, 2024 at 10:28:06PM GMT, Pedro Falcato wrote:
> is_madv_discard did its check wrong. MADV_ flags are not bitwise,
> they're normal sequential numbers. So, for instance:
> 	behavior & (/* ... */ | MADV_REMOVE)
>
> tagged both MADV_REMOVE and MADV_RANDOM (bit 0 set) as
> discard operations. This is obviously incorrect, so use
> a switch statement instead.
>
> Signed-off-by: Pedro Falcato <pedro.falcato@gmail.com>
> ---
>  mm/mseal.c | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
>
> diff --git a/mm/mseal.c b/mm/mseal.c
> index 4591ae8d29c..2170e2139ca 100644
> --- a/mm/mseal.c
> +++ b/mm/mseal.c
> @@ -23,9 +23,17 @@ static inline void set_vma_sealed(struct vm_area_struct *vma)
>
>  static bool is_madv_discard(int behavior)
>  {
> -	return	behavior &
> -		(MADV_FREE | MADV_DONTNEED | MADV_DONTNEED_LOCKED |
> -		 MADV_REMOVE | MADV_DONTFORK | MADV_WIPEONFORK);
> +	switch (behavior) {
> +	case MADV_FREE:
> +	case MADV_DONTNEED:
> +	case MADV_DONTNEED_LOCKED:
> +	case MADV_REMOVE:
> +	case MADV_DONTFORK:
> +	case MADV_WIPEONFORK:
> +		return true;
> +	}
> +
> +	return false;
>  }
>
>  static bool is_ro_anon(struct vm_area_struct *vma)
> --
> 2.46.0
>

Wow. Great spot, and what an oversight. Agree with Jeff, we really sould
pull this out separately as this is something that urgently needs fixing.

Ideally we'd add a test of some kind, but since it's so obviously wrong I
think it'd be fine without at least as a quick fixup.

This will need to be hotfixed/cc-d to stable too since it's in a released
kernel version.

