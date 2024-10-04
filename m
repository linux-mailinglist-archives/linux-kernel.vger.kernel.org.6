Return-Path: <linux-kernel+bounces-350569-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089519906E4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 16:58:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 255BE1C21BED
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 14:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D8D1D9A57;
	Fri,  4 Oct 2024 14:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="imxJW6NR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YHPQ62cm"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111C41D9A4E
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 14:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728053893; cv=fail; b=qM2pmhR7ti8AoD1oWOhz5FmCWBh21QuZCnP75YQQ7FFw4j5M7PzYtqahaqFGxoZs56isn6DoLbHxEauVBoqYK/zI7as3tSUbvfq3zeg5xad47ohjZPTxT5l0BEQNNJYFcgYdudFG717+lDMTSaBHaJcPRZA7TDhZKXbcjVHEu9Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728053893; c=relaxed/simple;
	bh=8MkW2JEBenUkWInHLNlp/9T62Ho1//0kvS5c9uKNscg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Gdoo4+HTsw3RvQ89VDoo6F0YRMN1V0VBwLryV3atWZxkDe+2OXa8fyhYSj0W5OdCbQc6LPQlprNTJRWQYJU/TEO0iLYk52bzCFSFOsEyUuZw2H0N/Q3GMPncJOl3FR6tnWGM7vt6g+E2lBq53gV58jhyD7se6MXWi244sjGTPqk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=imxJW6NR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YHPQ62cm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 494DxvLi021760;
	Fri, 4 Oct 2024 14:58:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=e2hlNKZecYh++xQ
	tO8XTvCAtX/UgdQTCEamms83cA3M=; b=imxJW6NRCXMZO3K+E1VxmfL1US1yrDQ
	puzvDQkn5w8KX2b1cSFZPF0dQq+SvyR841oX/hLsZXu/PrA9SxI+1/TtDyc5T2hb
	bGhjvYIvGKLiBKCYlLJWOVdFRsjbxDfhtAturektWVBXbFclL9gH/9aLzkMttt++
	SRaLTY2E+eN+2v5KuOv4xlOdq862DNd7gru376R04zTtsplSwZmkopXbtsJe9pMR
	z81MFwZdgaMW/v0N5/kF46CdiU6/8HECtwzjJDxew46fOHM0MWIPINiDjCEMg33D
	bqHCIOWZRhrKULtx4/cgYPFt+r2gDbmgLrAqprQ6kjQraXOuJpRJW/Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4220491t51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 14:58:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 494Do2tS037876;
	Fri, 4 Oct 2024 14:58:05 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2049.outbound.protection.outlook.com [104.47.66.49])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422057de7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 04 Oct 2024 14:58:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GzQ9RAD/mR6e6Zbt2ujcVPW9usl1otjWJiF2N5K04mchqCVwme7+9bDA9AUQtYO2VqSnzXRAAjToP1gxk7V0eXe3yecmcsPrnCYCgYTyBKjz0TtEH4orYqyfs3OoV4kPvv3JDKcJLRRdxyX3iPPWN03YzCkmen7gVoWvwWPJ0I+MMSCybJ/+LKbqfNK9savPSAHif34WT2DcVG/BQaJDUBxiTCLu7vAGHRJMpisgIb4UX7D+yGGVKTQCS4957hgp8UvPW/V/63PeGoHD8dURLyX56V/GnATjW2u/WeTDK7nBgX5cH5bjqafoLtXRyDQ2Kib19hU1uFswuYyZZwvu/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e2hlNKZecYh++xQtO8XTvCAtX/UgdQTCEamms83cA3M=;
 b=nNN6yDeZWvVh1uwmalUJ5j0eHdtjHE1Y/oDnxVEXdR+sVMFq0yicqT2i2bqJfDe5oZGNAIowFZsE25NVEOJtj6wywbQsWbxHiDSg4RF4tfwBNF9k9dg45TmUJEg+kTM8rxkrsxIXNUqTP28MbbMeYNmXAwj/OW+O0UlS+D/yxsu6mHoInC+bq5YnNi8pg+2KjTo5wr5qZ603TgfP3x+RFiOBSTSyRI09Df1AjDT/ke+4xxmSQu3ahCzonhtc/yDhuoI89zcqdHZw5ORneC+ky6pU8RwZ99Vnk5XG3D9pdiWpBff+8neH5NjyiWxjp6JPXbY1gs8iNWYJO6Jcy6V7mQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e2hlNKZecYh++xQtO8XTvCAtX/UgdQTCEamms83cA3M=;
 b=YHPQ62cmqC1GJ2SlfZV5sCj2q3YUx1RZxTEt8nYVT33nxMIXB18TMiaHfSqnE3iqa5OABB29aJPkBCEbsJHALd15guyYj7ScjwYNvz4ri24pxPWx3BYODUo/DS3dUu8SwGrMUR1wEo9w1Ust/NmTZnoXVrKgVrYj5OUF/0fUJ+w=
Received: from PH0PR10MB5611.namprd10.prod.outlook.com (2603:10b6:510:f9::16)
 by CO1PR10MB4596.namprd10.prod.outlook.com (2603:10b6:303:6f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.18; Fri, 4 Oct
 2024 14:58:03 +0000
Received: from PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2]) by PH0PR10MB5611.namprd10.prod.outlook.com
 ([fe80::d513:a871:bbf9:fce2%7]) with mapi id 15.20.8026.019; Fri, 4 Oct 2024
 14:58:03 +0000
Date: Fri, 4 Oct 2024 15:58:00 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <311acc28-50fd-4acd-b5e5-fa03ae4ab2cd@lucifer.local>
References: <20241004093546.3232-1-spasswolf@web.de>
 <d07c85a3-d1b6-48e7-9e98-bb533bb73417@lucifer.local>
 <a34fe509-f1d0-482e-9aa9-8dc3fa0743f3@lucifer.local>
 <76a7c74b-9240-40b5-a5ac-9b128c7007c5@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76a7c74b-9240-40b5-a5ac-9b128c7007c5@lucifer.local>
X-ClientProxiedBy: LO2P265CA0321.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a4::21) To PH0PR10MB5611.namprd10.prod.outlook.com
 (2603:10b6:510:f9::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5611:EE_|CO1PR10MB4596:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c8703d6-5950-4681-2d57-08dce484f22e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3A+qrLUQ8nvmYlDzrWoRUkyt7lx8jaG7F5rcLIz8io9Okhj45IVeVxtJp1D2?=
 =?us-ascii?Q?sN3NLo7TrH5hr8F0QfPI8fZ8HF5iKhI4/0+3z+iQZvKhmTvpMY7mNT7MZ84O?=
 =?us-ascii?Q?7qMPVTGCS68mDRvpx7IU+7CRpU3ayU7qD9uls2YmbO5Gn1CJg614QhKxc6xJ?=
 =?us-ascii?Q?1s9kdxlL/oW94o9ePQ5GR3/PwDh6b4ahIjAHL042xrEi2N6UIkWphK1UENNm?=
 =?us-ascii?Q?MYjyWvx8Qqe2CsOl0gAyasVfDpzpptQh3qupNETpf8WCHgSAaPghsmxe/Bl/?=
 =?us-ascii?Q?2JUhaZjZcd/Qqd7SEVEIzqHCN2NDclY3u6qhEMNclr5RUyalD+i0qKsk0ist?=
 =?us-ascii?Q?Je6zaSbyuFbZtCzeTkRWNfKugoyOWz9o/O95enwPH5R9fXTL0EzvH3hr0CKa?=
 =?us-ascii?Q?SvVnAYVBkpRZFBbfRGLx0D2Kzi32Ei++7SiIAEmPFQ1a/peAMtX+uyyifk+M?=
 =?us-ascii?Q?X5TFhkibSevKh+oF/fNpXrZ3djIMHYhk+KUyekT6yuNwzknw39C+8QH0iw2p?=
 =?us-ascii?Q?fUjsHh1jRr8NnmXcxoNZMVu+voL/bjK59c2ufQOuqWc2Z/fNj+7Sn2pKbpaa?=
 =?us-ascii?Q?ilJe6J6lyyBycfk/Rh5wPDUMuXjejjpllFzKy2aGfCqgGQutY+F2pzZDUegY?=
 =?us-ascii?Q?fSIOl9yjE5J7k4nhRKRfU+ZRytV/pf/TTY5Jv8PQvfmbZvug91BdWA1LfMVZ?=
 =?us-ascii?Q?HSS/wTJI0RIcQgYSup34ocVUZoNsdMUN0jELUOR4x+t+E180u3Eq86wJcHnI?=
 =?us-ascii?Q?4ypks/ZyAEaVh2meCaibr1svtdGYJLClaKF6FeEhdggIUmzXh2jQdaxf69CH?=
 =?us-ascii?Q?7NDSZkruFKFN3BBgP9dvv8x8Y0UPaWrTPqhe/2mVNKc39VXKkD/4UUiO5JYp?=
 =?us-ascii?Q?ntnqPEQrw9ub4J4OKXz6dz0srEVcCUm6D31Xac2JZYTWRNwja85rKqtFB2s1?=
 =?us-ascii?Q?Op0r+amChlr5nRQatrSN6oJ4OxwqcEAOt/DM8pZcKXhpEbtZP5gI4vxe5QKt?=
 =?us-ascii?Q?CtqRYhYeXF3wCfxQFG65DwPUHhP+0UZktEHcIB2lkFxeoplSYloHNPf/CLvO?=
 =?us-ascii?Q?8vO+9NxJHwmRiBRqFFsDfOfx6OBZVHx4fFTm5E/rRgTjPz2B93eAukNzwf7L?=
 =?us-ascii?Q?fDZzZ4B8FnZgLpVqMRoZ5gnp99hKQ5jYx/7XtwlCRUwmIlqsijGv7urg2e/3?=
 =?us-ascii?Q?DxA3eal+g5gC2jfStF73gYRq9zgtOsnhBgoSSFTGg7jHIEkGhLjAnHyXLbjA?=
 =?us-ascii?Q?ng8wNGI9mRH9QQv8yR5+SoNjbwoxZl2wzPrg9fcVhg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5611.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LMO710zD0FcEgvN0zEZd1bFTFNjjaTp+0CBzFdqOrMViiMiP55QYFvMJzwBw?=
 =?us-ascii?Q?LXbjK0Z0WD5q00fgnI6nwVF3D4uvEnu8uM649aRAfyReubdpMZyyuFVeU9yx?=
 =?us-ascii?Q?V/hGhRC6CCEqYZlb+calizssDf9XXA15LoYnuPim28I8nvFt7BgXpNAGQzAU?=
 =?us-ascii?Q?CUVDUu+NxN/h0FKohI7MlP7fF8Ebj069dSL1znODXSAjzBaY39SVDDxYn7Fy?=
 =?us-ascii?Q?+xGRDqOmHtO47Fb34bDJIigtijxP3yw9sUh57wRclTIEEo1pI/g9mMlZGtuW?=
 =?us-ascii?Q?cOo+kOeOiFyj8X5XqAZolEUDLcuitXjIO7+lVJsMV+Qp1Q2fKeap60/htbdY?=
 =?us-ascii?Q?A3+UML0GideTOseL27Z1CmQ9qLOXyxcsARKcHqbT/JWBEzV3wZxHiRefwEU1?=
 =?us-ascii?Q?1EhfeHBDAC+5qfM+McWwUVqYAJrT54aDJOuFbkQqzXaOxr2QqvXrj3axLuTG?=
 =?us-ascii?Q?/E/ZmV9AR6YL9U3RvMVL9wI1n1Weh92xZSETpd/M2voK7t7aZ/TpBckaJZ3J?=
 =?us-ascii?Q?JjQJM35M42/r2EcmgBFhIPxUp1HkoddyQByKHSGB937FQwN3/5Tjq4MZ1EM7?=
 =?us-ascii?Q?2xnW3I1ZsnGnZQf4KYqXjyOXvVyb17R/755q3UDjMFyGEBeNmlzuCdEDqpBg?=
 =?us-ascii?Q?HZD64h3Gom2cOVTzPdQ9TYjNt0mSCLTOUUXPk5SEsuOJS8j1Duv8nfMtLynJ?=
 =?us-ascii?Q?kOkeDUuKUrjm53uXSh/ZxP5vDJPpJo9RUm28B4TMWdiAH82DpdPvoy2+Xr2v?=
 =?us-ascii?Q?f+GNLXK9z1Zz2sUc0gxSzXf4mHUfICrPhpKVHp98JZ5uoKbpKwsmuUT2v4rn?=
 =?us-ascii?Q?g28iHMdCzKjRf+tN8LHEA9oB8YLpmHhZgxjvu3P+mW0ZAz77diljCF6d5nVY?=
 =?us-ascii?Q?ivfOcoPLcl7q2vavNcuFIANUWzlXhCCnVVshBIhMzHRv8nHgXfZ5sbw1fqlC?=
 =?us-ascii?Q?oZCDE8TZoLzc6mvg6dYFj24Ct1/mOif1113Sr5uBjcq6/Bd8EZWd5sVAVwxU?=
 =?us-ascii?Q?sNHQ1aLJsOetBhE27vrQKd2gFyGG5H9U8jPfVnjl6vjQQA+GnFl96p/AUBcl?=
 =?us-ascii?Q?dAaUnbhHgFk8VZseQu4GVQ5GLxle1WDok5VsFJCsgrXKTUL+Nwya8BgkBU5U?=
 =?us-ascii?Q?J9bsbQaLpIw1hoS2l9a/OqSTjuOlP+odkWgNJc3ViDS2uE4vASnsizsPK05J?=
 =?us-ascii?Q?PTnD94qIH4OgUNUt2GzR8s2wXrVKJJn78N96K11xVHJsHPPqIhmkDQSgaSUO?=
 =?us-ascii?Q?mcYK1KrqPnN9W+7CFA3b6e936GnFsBaF13sg2rRd9jumpIXbpY45gy/V0Xln?=
 =?us-ascii?Q?T3n5zynjK0om3+kZDZjcM++nvor5LYtsMf34JBiQJ/jauy6WmliibAyvUmFE?=
 =?us-ascii?Q?rw7ahimYgHQmE3vurqYZFVPx9jQlfBdwCgKA1QT1LGKL7CEH4HdG9KMR6y8N?=
 =?us-ascii?Q?at09ensAolpZe7xKjCXRKD9JY8ZTWXJHzsg2cnQOXHboRGgKL8k5RQV93nEF?=
 =?us-ascii?Q?JtX05dGR3M6O+JRAL0XVL2UPYqEN/g8vjLyaW4sI6F4KoUK3OLRRaP9EC/Yt?=
 =?us-ascii?Q?QRe1Plh7r09TMvoxoEZm9YT4QESHGEWScgASkUa5f5ZaPBnz+OCYC46wH7kG?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FapvEQ5K3Xzyrxk1ZlW0HaX/L1WpQufh3cge3AenUkAL3QvEAj8rQD/qURysS5h3MiYy6AZguOIKsgCc+10UqofTfUz7k0S+sdGumDy3xX3OgUtrn/CzDJJexC1dV8L1Xt1eYgiLZqJHYX+H6zP3EAMAxzGIsFaLVXYbElwX/NBMMRNuhsbeu+tzNaXyRth/f5mCj9/oZwYY9PRByhoOWBr7INcdRi0Fc2GbM50H65oYnGhNdUrexGm9olXCr039sJqmp3cwNxxx5PQRo5Dm7GAk4Khf0gg7sCuptY5n1nSPxAbX85jte1P2G0lhoWfCnAZZu72yaHAR98B1HqNEzApoX1olSxQ2U2FXh31MbgGsuxTrfAHpVnFWm+FEr7jWIcWzzsgWvhARHoIVstJyrj/1bWoyErOlm4Pj4CeAaTuaevk+QP3sOoN1011OrOcvdWkidFSjWoxBn0OQi7jB0+kruZp+QfRsLYZC9vhKRu4htuJjvw+97clk792HmuBFbSveXX8nfI3K0MrEDtdOcIt2+oHCOpyKp7G8vI9eqPmgG7vmH+zo0rf5nRaTBfFt1T0coGxBNwpDx6p+8Mq+QjgUa0q/gmTA66St9hIvhTQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8703d6-5950-4681-2d57-08dce484f22e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5611.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 14:58:03.2460
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S4Kt4JMMcblgciygBfg/n4jP1gk0DQlIPkp5WvBNjDOcou5yodMRmJ8chzc1Mizj1sMqA//fTsZNU/KeOQPFYg8D+68eAfvEqk/zvL9iutU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4596
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-04_12,2024-10-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 adultscore=0 suspectscore=0 mlxscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410040103
X-Proofpoint-GUID: dbJCqMJhGn9uyscEg66dkRKQ_DK6wFL3
X-Proofpoint-ORIG-GUID: dbJCqMJhGn9uyscEg66dkRKQ_DK6wFL3

On Fri, Oct 04, 2024 at 03:32:28PM +0100, Lorenzo Stoakes wrote:
> On Fri, Oct 04, 2024 at 03:26:26PM +0100, Lorenzo Stoakes wrote:
> > On Fri, Oct 04, 2024 at 03:23:37PM +0100, Lorenzo Stoakes wrote:
> > > On Fri, Oct 04, 2024 at 11:35:44AM +0200, Bert Karwatzki wrote:
> > > > Here's the log procduced by this kernel:
> > > >
> > > > c9e7f76815d3 (HEAD -> maple_tree_debug_4) hack: set of info stuff v5
> > > > 7e3bb072761a mm: correct error handling in mmap_region()
> > > > 77df9e4bb222 (tag: next-20241001, origin/master, origin/HEAD, master) Add linux-next specific files for 20241001
> > > >
> > > > Again it took two attempts to trigger the bug.
> > > >
> > > > Bert Karwatzki
> > > >
> > >

[snip]

OK sorry to keep on updating so quick, but been busy testing out the fix.

This version passes all tests so shooould work generally.

I'll do a proper write-up, etc. but generally it's because we can have a
condition where one node is empty other than the end node that is to be
overwritten, but we weren't being careful about that on a spanning store,
so were merging this AND writing in the new entry resulting in the observed
duplicate.

You need very specific circumstances to trigger this which the MAP_FIXED
series + steam seemed to provide :)

Please give this a try and let me know how it works.

Huge thanks for all your help throughout this! :)

----8<----
From 3d01e0f97a2a62992b5f2bd466908628ae72da95 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Fri, 4 Oct 2024 15:18:58 +0100
Subject: [PATCH] fix v3

This now passes all maple tree tests, so should be good to go...

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 lib/maple_tree.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 37abf0fe380b..4c0bb56a3142 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -3527,6 +3527,7 @@ static bool mas_wr_walk(struct ma_wr_state *wr_mas)
 	return true;
 }

+// Return whether the node actually contains entries at or greater than wr_mas->mas->index.
 static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
 {
 	struct ma_state *mas = wr_mas->mas;
@@ -3535,8 +3536,11 @@ static bool mas_wr_walk_index(struct ma_wr_state *wr_mas)
 		mas_wr_walk_descend(wr_mas);
 		wr_mas->content = mas_slot_locked(mas, wr_mas->slots,
 						  mas->offset);
-		if (ma_is_leaf(wr_mas->type))
-			return true;
+		if (ma_is_leaf(wr_mas->type)) {
+			unsigned long pivot = wr_mas->pivots[mas->offset];
+
+			return pivot == 0 || mas->index <= pivot;
+		}
 		mas_wr_walk_traverse(wr_mas);

 	}
@@ -3696,6 +3700,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 	struct maple_big_node b_node;
 	struct ma_state *mas;
 	unsigned char height;
+	bool r_populated;

 	/* Left and Right side of spanning store */
 	MA_STATE(l_mas, NULL, 0, 0);
@@ -3737,7 +3742,7 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)
 		r_mas.last++;

 	r_mas.index = r_mas.last;
-	mas_wr_walk_index(&r_wr_mas);
+	r_populated = mas_wr_walk_index(&r_wr_mas);
 	r_mas.last = r_mas.index = mas->last;

 	/* Set up left side. */
@@ -3759,9 +3764,12 @@ static noinline void mas_wr_spanning_store(struct ma_wr_state *wr_mas)

 	memset(&b_node, 0, sizeof(struct maple_big_node));
 	/* Copy l_mas and store the value in b_node. */
+
 	mas_store_b_node(&l_wr_mas, &b_node, l_mas.end);
+
 	/* Copy r_mas into b_node. */
-	if (r_mas.offset <= r_mas.end)
+
+	if (r_populated && r_mas.offset <= r_mas.end)
 		mas_mab_cp(&r_mas, r_mas.offset, r_mas.end,
 			   &b_node, b_node.b_end + 1);
 	else
--
2.46.2

