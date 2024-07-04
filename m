Return-Path: <linux-kernel+bounces-241649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E3CF927D98
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 21:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32CD0281C37
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 19:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F9E773465;
	Thu,  4 Jul 2024 19:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k0/I828B";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HvGdWVyu"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394903219F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720120088; cv=fail; b=k+JRmDG/HjVM9IIX9rEKBqHgoTbRT/Wlafp04WrmNFyxcEkuDlImD9ozneRWjlAFiEhZE6Ol8IS41Wx6Do4ivUGAUWKMvjjR0DeaWaqW0/DlmgK4WWsqnz3SUSDZFUrrh3pHjlti69N7CtPXugOq/7WkxUHAdmjZWqhdcOWwrnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720120088; c=relaxed/simple;
	bh=yLsCZojYpceWxBcHPMJfRXfVPYQ+yXjS5NbS8G6N0SY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kUKsx5XK6D9S+ci+/iXd1qH1Rqm6rd3v89C91CoeT26EMwYCjvuE5Dlqu/9QVdg6+QLJkUrEZJFOzVHS1Q/puXQ+//R6kVhcVbqH7BlYpd5BiEXgMyC1fCpBR7hPuZgW7HBfBe51jye5TjRMEs32gYAAGQCBajPMO/fWW4zoi1E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k0/I828B; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HvGdWVyu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 464DUYbg031309;
	Thu, 4 Jul 2024 18:27:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=CR5r5SlcrI9HaSM6OStIkTOvAIfiXnGdaLZK//vb76c=; b=
	k0/I828BESnLBHiZfvYiG4k92TEbEtnrRsjPeO+6gxnOCysWsKcxqdn/59qEwLuU
	DF0aMB8XaeJZbRRWpX3eurFiekOpc39i0g3uPnn+UToJggdE+3Z8k4anZoYrO9hM
	Jlpkrif3XUyu4exLP6okHxeBrhjCH7DeQJmeAC5SctwrMeel5VW3UlRf58BMP+wn
	LRN8/pOv3EOPEKONSYT8RP/Op4CJWXDYlifNequfnut1EHJZAeRS6IMBAlHqP9sU
	JdHo24MjUhB5JrAqUKUF2wIHkM7D/60CgpIDhsW6SkwoAFM38HdaqBdUb32HqVxL
	RDOALb3D/yMwYD3uKJPGKw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4029vstk3r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:34 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 464HF6rN035655;
	Thu, 4 Jul 2024 18:27:33 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2040.outbound.protection.outlook.com [104.47.56.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028qacuhm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Jul 2024 18:27:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iT3NTnDBUJ1bccDpogxpkL3EJTe2drl6FCF/v9CyInSbrDeRqT5H2SVglUvA9MF2b1dx5V/6LPx7XddMs9gp4/+K/9tx+pDvwGmfFRADgV3e8lib9v9z60THH+ApfpzlAGbnLE0O4MEFgHFAV9asijhrzi0O3QtiLkgSzAO8lWdfQaxSm+MChgYkkJCxcAjy/Wt38SB6TUaBppmbN91vDRRlqX0LQ79ksZavMaqYtVXQBxlK4NEDgXWUtSEQzRjuFcOOOy8wjcDiqLHp4FmDyviE7T+T2Vpokmb1zTek6ZyFDgt/x1f68874XzTgpXJAGEoAQR0HGK0arsd5ElbTyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CR5r5SlcrI9HaSM6OStIkTOvAIfiXnGdaLZK//vb76c=;
 b=lZP150JAUdvz6H8eTpiiVbOz/K/Oxv3yXSIyH9M2pnh5N17I3nrZXU20faJsyBU0VgxiO73KA4H2m9I0cANtg1YaJz54d0iKseBnSMyj3G4uw4uA34WYM2RFqCee6ICLx8r4+SV6dt6t5k/XmcgNWA84aLO691e6MjDXOWspVJA4IQmpvC5p0eqgEhagzpGZiLAkeHSxLXx5g8mt/wTQwdvaDSgoP2AO/f6AbxcZh4jUbxpz0wDIbkwlKuas1yI7OdQ7Okb0hDb7cVcKs+2Jz2CgvTDQ9UoTIPrbYShRVBHDiLOPUURuezV+ZSWwDMxqGF4PBOledCVg0VTDIBdyeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CR5r5SlcrI9HaSM6OStIkTOvAIfiXnGdaLZK//vb76c=;
 b=HvGdWVyuPqVIWCRgbVA0JXyvRr1d446JAYcm13rBvpqQYyT1f9ivdy61+Tn0x0Wk4t852O/nniZytnMNfMCmnDCexDeR55aObl+IDvH6lEC2ebRenQ7667gMevRu+lAWdxpmGInELddbh7yC6vnuHcGs88EMumRtd2phbS/4qQ0=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BY5PR10MB4242.namprd10.prod.outlook.com (2603:10b6:a03:20d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 18:27:31 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%5]) with mapi id 15.20.7741.027; Thu, 4 Jul 2024
 18:27:31 +0000
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: [PATCH v3 04/16] mm/mmap: Extract the gathering of vmas from do_vmi_align_munmap()
Date: Thu,  4 Jul 2024 14:27:06 -0400
Message-ID: <20240704182718.2653918-5-Liam.Howlett@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: YT1PR01CA0098.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::7) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BY5PR10MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: f670aed8-e1d3-4459-a810-08dc9c56f767
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?iidFsdmsAN91xH90QafBtpV3UI49GFjIY/5+e0qWhGV9sIO6cCXJqLrQ1yuc?=
 =?us-ascii?Q?xV+xESEwsSG1UDmNHdNZrMf+OQ8yVV1CUtIk6+SjfZlURNuhwYwB4IX16s11?=
 =?us-ascii?Q?oVRcafoWubDFpID8uatR4+3EB30MIBysa7RaRe908EJlhccQXH+Wra058Zn2?=
 =?us-ascii?Q?NXaeY7FA1KhWmJwn107vrhTCOTSwTLTRWggjhP/uAxDXRdsLMRrJg8mmwsA/?=
 =?us-ascii?Q?z5BNe1dwdD/+vwTRFgX5xmORSbgZK0n2nxV5/cHqsHXNfQe1dXI0i37abK43?=
 =?us-ascii?Q?Cea/3hTwiyllFeLJq5McSFcJdu9p+Ulbxy/Qd4fOA/cioC3hZEbf2O8g0KJg?=
 =?us-ascii?Q?Edft15Ii+667M5YOFYrOjEMOGQW4Gmdbycduc33FjjHPbQhpz6p6O3caWA+Q?=
 =?us-ascii?Q?6UQXQtr4RN7+NziixAPYqIOrw6gxXhIMXOEArOqalrVA5eo/KyFpnnAgJb37?=
 =?us-ascii?Q?Cwt6Fenko9HMIyobKwUe7Yj/nEdV4SjC8jYFPcUeJL265oHf3/FMiMVg2LqC?=
 =?us-ascii?Q?xt14Xu/jNMWkjRhXz8bI8EHMJ/1AuWP2GG/bUnotIVuv/hTFVI6ri6CRUbBP?=
 =?us-ascii?Q?SnOXF6gvwcZcHNUepkzD28XVcO8vNYg02naCdQxacE3ej1XcfUxpibgBCrwL?=
 =?us-ascii?Q?+F/bctYf5XMDq7ae54X0oUI+SiYbIQvJ2UmQPwb810Cq6jd+wYTXEEaShkDz?=
 =?us-ascii?Q?yCM8J8G4sw5O58OWFDXPENI4jB1y95TC5XR/QwtGgC/7Ea4u6+nruYsszDGY?=
 =?us-ascii?Q?0duVdjLlYFua5k1UP9c+ZGOLQUWy5UU306qwOmrPGhNAXB61V69+UBKZorE/?=
 =?us-ascii?Q?3kQ5Lq0PQInR4cHHG+Fr8OqbwRtwu79UDVWs8i+7ZHobN2jiM71bjZ48WbbZ?=
 =?us-ascii?Q?g/FT9+tVlYjxapsdfvGZckT79ADZxFfNGPzIAv1U6t1MRTIOhvWgrCp0Lmuf?=
 =?us-ascii?Q?rSGHAQIWfCvlqCjwg7Hk9aCKCJUsuu1FT0eDdx3QBcPyqPCt4w6ca9/r/9t5?=
 =?us-ascii?Q?/iaWPOOaqrPUbTwAFN69QFaQx5LvIFieuCVyntoXdI++A1f5a8iapW79cvep?=
 =?us-ascii?Q?KOnfhhdZioXTrqKuOuUeHF1twq9uJh2EkeXoVtFps8BJXQYB+XBTD3nKRwkK?=
 =?us-ascii?Q?NdQPLSsWJ17FFpTaq/ltN23spkgLlg95u0fgka9TZSoIx8GnAJGPa+sCgUAx?=
 =?us-ascii?Q?LTw4sZxW5Kac6Ab666tk1OmNX44nxhR8d9KyLCtWjwn0ZT9PnTSvrTv9Qcdd?=
 =?us-ascii?Q?darbaKNxtsSpDk3QAJbT4cj9l17MiVMIt504j3CVrxjN5gj+8QhzzuSZxQ57?=
 =?us-ascii?Q?b1D++eZMBOH5rHV7DXuu+qwPKEbNQ33d538n/m+3Cd+zpQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?/p4oqDMQ/Ehpw63abDVFfF0CpCzWOU00SGE9Lye7N7ldqF9v53QH8UDicTRM?=
 =?us-ascii?Q?XsEBdbmEw7NexsjdqXtjKJZHRg+v4i1SJlLHqtGODKsHcJcGDRfTEyDDU92f?=
 =?us-ascii?Q?t8rMNBJLn0R0thWGN7aJKTw3P1Bat4eBNIInfnLFMUyi0cFGp0yimqG9B9La?=
 =?us-ascii?Q?mSyyONLxwr3eUjWLvMuDQMAAkvE4zDVYX9H2P2SD68lDegjeM2w3SVe8NsP+?=
 =?us-ascii?Q?K40NWNaN8ABbmo9up5fo05jtJqEg2d0fcefYGgMvWDjlDr7T/trg2KdLjk37?=
 =?us-ascii?Q?9MQ33hR6ZFtC3NefFPmiReP3VcR7YDhzeMc5yqBpA2a3vQmJRwxCF7ceAxgL?=
 =?us-ascii?Q?Hy+Qe5vt/yo2l/PWknNv42rT/CORPZpoea4eieGTKs2ZtyV0ZkzPcLeXEwD+?=
 =?us-ascii?Q?5dBVxIpVmJeU0MTIx3i3tPYL3ga6q7fE6tyjvzoJCgpyeI0BILWRMB0w2YCw?=
 =?us-ascii?Q?Tksd/622nYW8EnedMI2YrlHfBxDzMTLBzHekpL4QNZ1y0F7L0XBTecdjYpM+?=
 =?us-ascii?Q?z53wT60MFFl/Vi2AWioYZb+7cex/fQs+/PPW8bmq5OWA4num/uI4C1XEFDlC?=
 =?us-ascii?Q?SaRxjco4C932JkNTOAs2UdA012+3oJ6RAsXD9VkiRuYHLAWVRqEwt2FGMGcF?=
 =?us-ascii?Q?SMGAwFR73j0Qkao0VnJ3QMjfA/4D7QhMETQQkvG9RSYLuapaKjYmspVhgWNN?=
 =?us-ascii?Q?iyO7isRtl/00gLeHG96O9ax0wArHBhl/1wc8cPEuVrTm7TIYNHqnAu7gV/Hp?=
 =?us-ascii?Q?CTNi8lxrq64JMsV7XoBwDOZqwklofJ600kfp7aAS4uAqCjlC0yiqJzWICosN?=
 =?us-ascii?Q?ffps1XlmKRNihbcE0dvpTJSfZgkTe/aLs+dM/D41rchz0Ta6ognS5bjXs6hV?=
 =?us-ascii?Q?npe7F8u4mi2Kn+cqbaMGn5YYEvaKkUBM9t7AsWaLEjbthWA9AUF8HwIfUWBe?=
 =?us-ascii?Q?uRTHPjLgh+9MxTzkxt/wVRru3sod0EugigybvcOSwA4vtSILhBRW1fiiHi9n?=
 =?us-ascii?Q?d/6Fx5GrqSOiOOzG9ujdnNbREoikfnT+mqVh8XXECfdG0mQsErqS68XOF1Pc?=
 =?us-ascii?Q?rHlr6o2otYoA/JswRC4kSndMuvpge9h/X1zOgIZbajDLF+3ZeIeTPuYUEs7f?=
 =?us-ascii?Q?NPT1We6/SLUgoKnXnJjZrpn/aGGfp/c5WFyZ4uudj2GAEwLmjJtlMetL7TNB?=
 =?us-ascii?Q?h5pJoa4rKyxWUxIUrELlqeIg2KGe+TJlQtOwmfkuQ3nx6KOMdUDQay10+onL?=
 =?us-ascii?Q?EDh5hSageJYLSx+bNlK/+JGPIFCUP9wdW+l1v5E1xT8C0og1P4CxaVzCXZ0r?=
 =?us-ascii?Q?o0E+6z2RhIk1vLpQS+dsRviK0yfPTiPLnCIcDZptznkg4GfVqZiy5hI17VjR?=
 =?us-ascii?Q?vfBF0xu0UlWi7VAZXvjpnUAInwuSJLUc5wXX5EPKm1yMaWBwXGQEdrBy9q+N?=
 =?us-ascii?Q?SgmG6gVmx1jAnjQ9rpIzUdtNsVfazjH5enm6a0I9XULMqZqe6nBx0NQAatJQ?=
 =?us-ascii?Q?cPRhpH7VoIu/GHkGPvkm+1KNOBafkHdcoyzkke0r5GwW/KkXaHBIJeRSKpin?=
 =?us-ascii?Q?uVtCCQ4NCkbNl79ZGiWOCwP3KCwdaCyjlMJeKGXYa/KUDnWCR6XuewMus/1O?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	IriLtbFdEvg/aV+AeDSUIkshBv6PoN5gTvEVquLE5HwmwZW9nnUc2V4UYmSOu8KjHqQMKjUjMxlukIcQlUVdaipekIAfFeZ0YPA6MabHHmDs7eupFqkyeRqS9aB36DuET+34Ei+umAwZOzi2Ohy5Ev/8be8CEbOTeL9+G2xJ8oprst9WARwtZtMOAl8l8u/j5N+uEjPCX3Y5DDkA/CwR8bIb84fZZqbPN/YdwDv7MCG0YRUsTJix+Y21OM/n0ERPSeHSWfEJDaw8FhghVXKHR0om9KEt0lEVJ7+GcOe+y0J1XqVu6mX4bRgTACnELh449j2lHa/1/MnhIWjV/Jnx4QB+LcvcTBoVZZFJq4mDh+2Uy19eEmii0exAF/NkeKTulpu5ne6vD3XkZEckn5xCo1vZAgTuTtJj9D3HRA6Jtjs/v8g1wyNOFxv7k6RWFo+Ig9wVWFqN5ZRfl2IVSEh5vpn9eQxsMhSOcifrVm/TfrH7S3egtB0RPeLA+R4DruENCdtBS2qHpEAESQc0ACGvIiKVUv3zY9zKYtk9X/AQOscaRMA4O/VAkHNxk29B/gd4rJznSg5kPw2YXWDwmQqkAv8nGVBf9y2GaRQaPRPmbEM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f670aed8-e1d3-4459-a810-08dc9c56f767
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 18:27:31.2439
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /UbAupT1Dxp7r7PJ8YmW82wYmQ3nElQAf3TFizAFR+yH/GS35LeiE4APDYQXmfuWP7fZY4J+wDWSY12lTXKJPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4242
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-04_14,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407040134
X-Proofpoint-GUID: wE1rpxM_zspPWIc0_z2CuqokNmyF2go4
X-Proofpoint-ORIG-GUID: wE1rpxM_zspPWIc0_z2CuqokNmyF2go4

Create vmi_gather_munmap_vmas() to handle the gathering of vmas into a
detached maple tree for removal later.  Part of the gathering is the
splitting of vmas that span the boundary.

Signed-off-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 mm/mmap.c | 82 +++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 24 deletions(-)

diff --git a/mm/mmap.c b/mm/mmap.c
index 411798f46932..8dc8ffbf9d8d 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -2656,32 +2656,29 @@ vmi_complete_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 }
 
 /*
- * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
+ * vmi_gather_munmap_vmas() - Put all VMAs within a range into a maple tree
+ * for removal at a later date.  Handles splitting first and last if necessary
+ * and marking the vmas as isolated.
+ *
  * @vmi: The vma iterator
  * @vma: The starting vm_area_struct
  * @mm: The mm_struct
  * @start: The aligned start address to munmap.
  * @end: The aligned end address to munmap.
  * @uf: The userfaultfd list_head
- * @unlock: Set to true to drop the mmap_lock.  unlocking only happens on
- * success.
+ * @mas_detach: The maple state tracking the detached tree
  *
- * Return: 0 on success and drops the lock if so directed, error and leaves the
- * lock held otherwise.
+ * Return: 0 on success
  */
 static int
-do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
+vmi_gather_munmap_vmas(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		    struct mm_struct *mm, unsigned long start,
-		    unsigned long end, struct list_head *uf, bool unlock)
+		    unsigned long end, struct list_head *uf,
+		    struct ma_state *mas_detach, unsigned long *locked_vm)
 {
 	struct vm_area_struct *next = NULL;
-	struct maple_tree mt_detach;
 	int count = 0;
 	int error = -ENOMEM;
-	unsigned long locked_vm = 0;
-	MA_STATE(mas_detach, &mt_detach, 0, 0);
-	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
-	mt_on_stack(mt_detach);
 
 	/*
 	 * If we need to split any vma, do it now to save pain later.
@@ -2720,15 +2717,14 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 				goto end_split_failed;
 		}
 		vma_start_write(next);
-		mas_set(&mas_detach, count);
-		error = mas_store_gfp(&mas_detach, next, GFP_KERNEL);
+		mas_set(mas_detach, count++);
+		if (next->vm_flags & VM_LOCKED)
+			*locked_vm += vma_pages(next);
+
+		error = mas_store_gfp(mas_detach, next, GFP_KERNEL);
 		if (error)
 			goto munmap_gather_failed;
 		vma_mark_detached(next, true);
-		if (next->vm_flags & VM_LOCKED)
-			locked_vm += vma_pages(next);
-
-		count++;
 		if (unlikely(uf)) {
 			/*
 			 * If userfaultfd_unmap_prep returns an error the vmas
@@ -2753,7 +2749,7 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 #if defined(CONFIG_DEBUG_VM_MAPLE_TREE)
 	/* Make sure no VMAs are about to be lost. */
 	{
-		MA_STATE(test, &mt_detach, 0, 0);
+		MA_STATE(test, mas_detach->tree, 0, 0);
 		struct vm_area_struct *vma_mas, *vma_test;
 		int test_count = 0;
 
@@ -2773,6 +2769,48 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	while (vma_iter_addr(vmi) > start)
 		vma_iter_prev_range(vmi);
 
+	return 0;
+
+userfaultfd_error:
+munmap_gather_failed:
+end_split_failed:
+	abort_munmap_vmas(mas_detach);
+start_split_failed:
+map_count_exceeded:
+	return error;
+}
+
+/*
+ * do_vmi_align_munmap() - munmap the aligned region from @start to @end.
+ * @vmi: The vma iterator
+ * @vma: The starting vm_area_struct
+ * @mm: The mm_struct
+ * @start: The aligned start address to munmap.
+ * @end: The aligned end address to munmap.
+ * @uf: The userfaultfd list_head
+ * @unlock: Set to true to drop the mmap_lock.  unlocking only happens on
+ * success.
+ *
+ * Return: 0 on success and drops the lock if so directed, error and leaves the
+ * lock held otherwise.
+ */
+static int
+do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
+		    struct mm_struct *mm, unsigned long start,
+		    unsigned long end, struct list_head *uf, bool unlock)
+{
+	struct maple_tree mt_detach;
+	MA_STATE(mas_detach, &mt_detach, 0, 0);
+	mt_init_flags(&mt_detach, vmi->mas.tree->ma_flags & MT_FLAGS_LOCK_MASK);
+	mt_on_stack(mt_detach);
+	int error;
+	unsigned long locked_vm = 0;
+
+	error = vmi_gather_munmap_vmas(vmi, vma, mm, start, end, uf,
+				       &mas_detach, &locked_vm);
+	if (error)
+		goto gather_failed;
+
 	error = vma_iter_clear_gfp(vmi, start, end, GFP_KERNEL);
 	if (error)
 		goto clear_tree_failed;
@@ -2783,12 +2821,8 @@ do_vmi_align_munmap(struct vma_iterator *vmi, struct vm_area_struct *vma,
 	return 0;
 
 clear_tree_failed:
-userfaultfd_error:
-munmap_gather_failed:
-end_split_failed:
 	abort_munmap_vmas(&mas_detach);
-start_split_failed:
-map_count_exceeded:
+gather_failed:
 	validate_mm(mm);
 	return error;
 }
-- 
2.43.0


