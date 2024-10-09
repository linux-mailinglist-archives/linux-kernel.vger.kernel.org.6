Return-Path: <linux-kernel+bounces-356084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBFD995C4B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 02:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E311B1C21FB7
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 00:27:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5A27462;
	Wed,  9 Oct 2024 00:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="i0LPg06R";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="thWgBl6w"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E692F2F;
	Wed,  9 Oct 2024 00:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728433643; cv=fail; b=m6zEYK2v1qaohT2oYHRT5muDsZXzmrGkirtgvLdUfZSa6uLjrf9iEaHc2jRpx2PthHPKxMuetmhSpv99diVraGYnD3sVwgJ2KS5EFjuu64u3lEdIsri87PSEYGAuAy0EAe6mQ+8dALnbeIfd5rHqLI75cOdyW1+NMl84ECOOLcY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728433643; c=relaxed/simple;
	bh=IRkv+YMMrxip1ST0Gh6stez+5H5jWF/ndGsnKsh2OH0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lawIxWg+7LMmG855YobB37CUWM6eqIUOEPLQLUQ3eL3rdfJ78iFrzaSTsJ28a7khsX7YW+fmQZKzcYUI5WuZHC84m1PfAOfvTC2NAe8r6MaINJ3IcgxQwq68ZM529v8AxLs63yRfzlp2zUwfvAYDRgG0D8ia/pYCxKL52e90tws=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=i0LPg06R; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=thWgBl6w; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 498Jtcrp003535;
	Wed, 9 Oct 2024 00:27:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=3BVlQstrUDj4TAIfHC
	YUpUtBIEitO1VOz20wFMPQE/w=; b=i0LPg06R2ZcyrCRWvKAmHYuLQE9dH5nOqn
	VgxC2fTToOtzzRrr6DstCREHNDoNc7IUm9e4Ff9MyghFVobdbZ+9pYC4lla/OPJh
	P1M7zG+qI1BUeVt6egPYLLkBSawzN3TOl8TsOE7gZn/t1+Dx115AnChssVJ2B2/f
	Pg1E3LE8J9aC6Q9sUcKMFokb3hm3jgC1pRvB8NoA0V3qI4MsxBQNedosobLheqWD
	hRh31JXw3xTYqPOf227qbbuCD0L2l+KgSmuHSRMtuJGiCtIpsCzYPNUBk5Z7vF6G
	/ijPINfb5ZSaGmoLPrUj007PZp+LIc96kqCmeC1B6iVnJcRqZR0A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 423063q21u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 00:27:10 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 498NEDTA031328;
	Wed, 9 Oct 2024 00:27:09 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2043.outbound.protection.outlook.com [104.47.55.43])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uw7wvma-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 00:27:09 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bi09bpSkVHWLYZZwnzjY4VrgBz7+kO7rJnqaztHHKqJDNC/mJn7JbXM0BNBw5lV5/5ADvkT7DsC+M9de7puX5pzpGUg1HOQ6meqUSITIP3xh1okitoKkbKp8HLwqGtUEjM1OP8nNSXYYs6JK5rXelxLcUzYYq/5HTN+h8qiUe6SH72haewhg1Q0CDF9xi33r5zXsRpkkp+qNeHfM2TDrV9tm38v87uJ/W8q/KwjOs4ztwkhKuC/Kr9uykJwg0Rg9A0B9c641udL6sXE87bx0kFMdWjm21KKAAAuFAen042oFPLFI/wZc01kO/PtJ9DODYqrKZwlOoRKYsaBeGbhdRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3BVlQstrUDj4TAIfHCYUpUtBIEitO1VOz20wFMPQE/w=;
 b=f7qG9zWLAoLzrvmYGgWDia5fEbszugTG5bxp+gI9i8waYIdwRu8zEYZRg0G+Vcjw/TFCtc1UDQEjXvCo5ERRzJwjmb1M5XC2c6wDm88Y+ncx7fMaBZBU6nVq6EwqEuMAVZrkRWD14XRXv6F3MA/U8+U+tFGrI4gQD9wX+LUu0Yb/1kCXsocmurSDRAMoF+c9GDtv554Fbr07T9T94cb/4jnMCQfVU5RJzE5p3Tw4LcHqt5nZUYESu3LqwsqHPswKy8FlGwBAu2k+32VzWeSrFTAITZ6oS7RwH5oExsSFXKKSFk/7dtd+5rSDbN4wmijo8NJFgfB+MSfRU6Zl8eozDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3BVlQstrUDj4TAIfHCYUpUtBIEitO1VOz20wFMPQE/w=;
 b=thWgBl6waqNXVrcU9zWoYclxUWLsNqb7a6A4LExy+nNeMSKBU3G9zUxS/W9Kx31GEsvIPdFiuGft14PRFCs4/7CUGEqvcrTmx6lA5nLqE97ef0c1gins9ixvdR4TRgSNOCFuyST6eIpQ0T/Lez6j3qbjr97sRrzAyJPRP0VV6Dc=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH3PR10MB7629.namprd10.prod.outlook.com (2603:10b6:610:167::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.20; Wed, 9 Oct
 2024 00:27:02 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%6]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 00:27:02 +0000
Date: Tue, 8 Oct 2024 20:27:00 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: kernel-janitors@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/35] maple_tree: Reorganize kerneldoc parameter names
Message-ID: <o3bmzzj22wquh24g6hnlbw3anqk5ykxgjlhtzu5oy35sd6p7vq@kpwd6llxgiau>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Julia Lawall <Julia.Lawall@inria.fr>, kernel-janitors@vger.kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, maple-tree@lists.infradead.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
References: <20240930112121.95324-1-Julia.Lawall@inria.fr>
 <20240930112121.95324-15-Julia.Lawall@inria.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930112121.95324-15-Julia.Lawall@inria.fr>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4P288CA0059.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:b01:d2::16) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH3PR10MB7629:EE_
X-MS-Office365-Filtering-Correlation-Id: f85d75f5-f026-417f-7ff8-08dce7f9187a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qRXfkQIDn4GiHiEZqhlT/JP+UL1OBYK0W8AJTCcceaLfG4aFROutmH95oLzO?=
 =?us-ascii?Q?2mIo4lwXtbY07yhbJu5g40rF+uZ++541BRE+HCmzDwJr6d+KD/gZS6dx5ZjF?=
 =?us-ascii?Q?KLG7qx/J/kzbge4kgy1WAOIBcs1UqDrS1yr2JCSQ1bNsc0pGrlNEm3WnzFZC?=
 =?us-ascii?Q?pg1bfnnNhpGx4sWThTgsxYOGYqzUG/iQVzH07OHx/k+7eVsM7UN/iNct4NKK?=
 =?us-ascii?Q?dsaCGqu0oh2H4QhkTI1mNQECcMyhe6vjkrfsCKYGw2ZcIzmAyLzNCfvvRyyP?=
 =?us-ascii?Q?tomCHaJOSqQf5MKGUpqVT3ETRGdI98UZnbS9eTAKaux4OS2QyPX/OswVgOeh?=
 =?us-ascii?Q?B7Gfniv0JEy8JPZUwYaQwsIiCBaSGNURyWw5PcWwzx7AbVGQhplvnQu+oGwq?=
 =?us-ascii?Q?MVcNvN/xNru60RGj8WICp4LOrSmavQ0PSjDPGk8FPsTUhB7NyDjHd6iRnYbj?=
 =?us-ascii?Q?Sjiyaiab7VqB9gfYaQAVrNrEKmkOfN+fmPWUuCWm3ZD14P7j1qJmSCJl0a2c?=
 =?us-ascii?Q?TdddGtKq1n5T/h53+qroHVUPcS7XggT3lYz+bPfMeNwGg2uENYJtFq9xdD/2?=
 =?us-ascii?Q?h2eqLJ01CoTZH4ow7DyVS8mDXiIBb8s1zflJktdgnzRqD8lMddb4M7axCxKM?=
 =?us-ascii?Q?CF5quk5HFSR37apBoQoZaZU+3hVvwjScG3ghro0SvIoaOPA05r1Uz0npMh2W?=
 =?us-ascii?Q?knf+/kakuW0DT6MoUBJ9JxW/etlSbIXu9R70ltV+CLU5/ydXVA8e0gMhVjqZ?=
 =?us-ascii?Q?Dt8Adg8WCHVsyK4GYISK98aYBZh9rLYCa20N88ZJQ+tZD3oVd7uiCKAszsN7?=
 =?us-ascii?Q?0iqaNR8jB6UokfMHNJjCYUHjIXIhS5yJJ415x0lQtWXp74Br52XU82XIGCPH?=
 =?us-ascii?Q?UotF25P16P0X8CJ1uPVks1vwCWMkDUpPUoVnYtvcip+huzsKD0Z4dBoWZQsS?=
 =?us-ascii?Q?HMFUntIVjTY8LqlPQmTgYQZKbKDOLBBUOiEwtqAyrV4nSBTzoFAz69WM3E7k?=
 =?us-ascii?Q?6XCBfCdRxVFO9gnxV1Izm4ECC1uCfkx1/b/y8gLIQQbVXmt13WymQQl0mFPD?=
 =?us-ascii?Q?+xQZ0sNQAorj/hJorkVVsnR5ANW6lPEfv6wTfdInpENDAdmTpYly/2lmV61B?=
 =?us-ascii?Q?pqvK2nSpzJo1LYzDeRJG25dYLv5eg5jvhPIdjC7m/8S4282ZOrOzPilA8lp0?=
 =?us-ascii?Q?GjbRZdRagu2sPTYok2PHpO2XwqIdA1y4ot6KOAa+pnr7hmH/umQ4Dm6xmBJl?=
 =?us-ascii?Q?FnH6M4EGXoH0/5zrR/DyqKFO9ySM1szTHLzSyu0t2w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s5hnv8RqzNDM5iKRW3VKJ1cV5vwfFpUYV0qVc4fv2c5+n/OGMIn41L3iqkl1?=
 =?us-ascii?Q?91vbcrSFZ3JKsPxfJ6bCc1LDkHJSwRUCx2yeYEMYNeQOkOF7YNW6hXsud/VS?=
 =?us-ascii?Q?TsrpQdRd+MUN9FFj9sCP4pEWBVgzBTVa76+Jtni6zTsWuox41DqXDBgrxRiQ?=
 =?us-ascii?Q?ve5yWpKcXyXuq8dcXOGadXD6+QWyoiP/ypqgZmqknwyntweB2Ts+oSxxkUVy?=
 =?us-ascii?Q?KXufmVdgO/RAn4R01Z9gcmchkzYcwfRfuD6G84QSf4qqvLM5HrFLbvqnIwGD?=
 =?us-ascii?Q?C2eS1FBxdUa9UC6W3b500sdS4Fza1wK72yeAtIDJMsdu8h2lOvmvzp3Xw9L8?=
 =?us-ascii?Q?zUzsiblaIo66griLM0HuAIPsVDeazvKfU3MemrcXUO1xc4DeXICpiQijZrP+?=
 =?us-ascii?Q?UyUp15tlmvTcQUZeHxN8vx7GEWP4rfY+xE1UOxJefontc/eL7Ta1b/JlxKF5?=
 =?us-ascii?Q?ao48f3j/VZIL8XrNJmvIRjg5LMpfzi9fHaRe5dIzLvhOKCVV+TnG6dGwfPG5?=
 =?us-ascii?Q?aGKOA94A4VkVwShnHPhm/sXlw+k6Y7PECZtIzB0VlPgNJ4V5S/y8/F0xFscG?=
 =?us-ascii?Q?/XhKLRUdzfjjYd+qxJ1vY4eKkbAU54JYNS3wtRDs6IiVlsymIfOMzywd/Dim?=
 =?us-ascii?Q?j8td8+Q9sEmEysqD2dXx6PSEr/zoqoiplNFOliTSALb0ZZseZ1VFb2/b0pZe?=
 =?us-ascii?Q?CrcYiRBpS+Em0Ee7k8rGHwMhTp9Yw17NucmXWZjEonQORBzMMpUCT0FTDsOf?=
 =?us-ascii?Q?5ATm33UXjcBmvokWvfyh0NEfuZzLTnF+8i2cSnW9TIpHvRy40hBKcXL6EO2j?=
 =?us-ascii?Q?7MZlXwdleWEXgH6j5dWSS6j456IyG6A0GOKlZ7zlpJ628d/1hJfFrDU80Xxg?=
 =?us-ascii?Q?5wOxo5yb8/PtfVZPB+e1a0nsfwdk/P72LGA+hdxRFGTpLbtvCwPhb13ZeJL6?=
 =?us-ascii?Q?DXonhwV1kLoHs90O+0RWZzs/arL8VrMamdk5QDPv5WtGsVlgevCm5GVJl67Z?=
 =?us-ascii?Q?NbwzQfBEKbIc/p+ZfIBJ/FztCByqSxoximfp0wqpNlQ7c1n/E538shXmhb53?=
 =?us-ascii?Q?AQGyMsfr1XyZbcPKSkd41YoT3RwZt2SYpJ2XAmoaWtDtqH8A5rgKTw++of16?=
 =?us-ascii?Q?np6cHDy9mcQgrR/P/FtR4Ttqo2yuixXCjg1yuZ47HQUGBjMACnDiwFB9Tcez?=
 =?us-ascii?Q?Ojy0tHUtKG0eKVjcVXWlTxlVhgugC5dmdICQS+HSucFGaoHoxqdx+wmLxpk/?=
 =?us-ascii?Q?sLbjOnvI66iZLWZQ2qpjqGGEAAs2ODOG5PdMequ1xClsILwWDJMyT5s29EVz?=
 =?us-ascii?Q?RHgQ+V0KcUUaUjT5uxnQsg1D0bqb7qZw7mCzQmrpIgRWS+/YqZCzUH5xxi7x?=
 =?us-ascii?Q?cZYu4NUfRIZgKjhV7Af5lze20KimMqtP9jFChViz93RmU3PYTrOIFhbF9D9M?=
 =?us-ascii?Q?/O6t7w710EDMUzbpQ5NCehCpECN2xP9oOAM4Eb0CLIFGi3G3N6BiF0MFrp6U?=
 =?us-ascii?Q?lWw8l5iuB1ZK5tPWN5mOte/B3XJKlsMDv0UJu8VLHim0rmQT5lccGpiXOuKS?=
 =?us-ascii?Q?wW3Nf5ovnwwmnfGPkwDaMCouQ0TWiezY3DDKMaas?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XDxs10N0OMKxS3pWmV/cfYYZPXpEGCsc8898hm2p+K6wcZolSmMxBG4MVl3f4GZyFuEQulJpoft1/Z24hS78d/kIzLbYv/ZNPcyE8Eof0Uo3A1mZFsRMTyJJHjDXNroWpeg53PWD5F8pM8mQ+0EGHTxYhAtHNnLKazlMIhcyEX7nyWwlrmVXPr3iX5zsSEhEHF0DG+ujzjrKdWVy8ru3jAP/ipjQ4nCyclCI1Rgm18rqlYyEOxeBT4kola1cbH4hyKwfcYLcgOzDTr5WvQi5Emto78xej72aER/LMGj9AOOgj+17MWauwPzogsLb6v6HjlppI6tIF0ON9bKzOcJ10Aj99er+tUgzXx+/OisTfqq9127Fz3fy2xQ5+R/ewsn2j/8OD1DLLnIgGv5sasmbK9LDCxRxx0sjx0b3dmUjRqWkHoQaLZqANXGIgQyr+d94XQ+A58xZnKQcD9HMOdZHa1Exn6dqmwVmao3fDaifVWzxJ1djzl6I3KSYPMc2qCMovDjO24q3FBH2jOZUqJFLJz2qVJQDZs+KoG+MO/zyrPJs+IYmFpqjWKRk9UHkWoKeFfug8dv0Pc25M3r7lmWkFbr2wf/iD4bg9io28qHJYus=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f85d75f5-f026-417f-7ff8-08dce7f9187a
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 00:27:02.4411
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5bFNIdNN+SwLQ9PcmdWdTC2kj/nlmWy4rgW9MnZjcK9dh51ivb+2QyYBIZCAjQEL+2tO0WKb0FDvLg+RM8WWNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7629
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-08_24,2024-10-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 suspectscore=0 adultscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410090001
X-Proofpoint-ORIG-GUID: DhX25oGCnNU0AGdevIMtzJJksqTLTRCe
X-Proofpoint-GUID: DhX25oGCnNU0AGdevIMtzJJksqTLTRCe

* Julia Lawall <Julia.Lawall@inria.fr> [240930 07:21]:
> Reorganize kerneldoc parameter names to match the parameter
> order in the function header.
> 
> Problems identified using Coccinelle.
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

> 
> ---
>  lib/maple_tree.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 37abf0fe380b..b7f59c40530e 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -4327,9 +4327,9 @@ static inline void *mas_insert(struct ma_state *mas, void *entry)
>   * mas_alloc_cyclic() - Internal call to find somewhere to store an entry
>   * @mas: The maple state.
>   * @startp: Pointer to ID.
> + * @entry: The entry to store.
>   * @range_lo: Lower bound of range to search.
>   * @range_hi: Upper bound of range to search.
> - * @entry: The entry to store.
>   * @next: Pointer to next ID to allocate.
>   * @gfp: The GFP_FLAGS to use for allocations.
>   *
> 
> 

