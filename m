Return-Path: <linux-kernel+bounces-348226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5809A98E458
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 22:45:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0BEE1F23E79
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 20:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1AD1217310;
	Wed,  2 Oct 2024 20:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OcWmcbEY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vyz8Fp7W"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620F1216A3E
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 20:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727901896; cv=fail; b=nBNXvMRrslGpNBcldo+iohqFzMmjxVup5IoarHuCVJ5Ch91bJpBblFZIvb/9duehLFYUe2cb5VlcOW5ySYC6deLuPpz5N/93oi58qUn4C9cTIoKAT+h1vc+cjL5Y2L9dESbmEjlDq56J3NgrGX7x0gc0OU/NNnG0O9ImH6y+rbI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727901896; c=relaxed/simple;
	bh=7IiTK2lXbHuJ43KV9ns3QD+A6zOMbOvpqz80a7jVb8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TSZQNLCCw8jc9bYYAsXEXqSLKd/09dViGeU+DG6xwU1eRELTi3eiUyOfqehvEPwfBAo98ORfuAGz3TKT2OQ06RybHV0gO7VnBJM6RkeXlcv6A78kcd18+zg7yY+GF01M0lAEzw3st997+pjBPF5BVKByzgVZf9yDp5uVXIk72lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OcWmcbEY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vyz8Fp7W; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492J0Vau030285;
	Wed, 2 Oct 2024 20:44:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=7IiTK2lXbHuJ43K
	V9ns3QD+A6zOMbOvpqz80a7jVb8o=; b=OcWmcbEY1845dTaqctVAjJDMc+ZcApL
	rH8vg46EOnfSNSiqxTsnAOewbPuoOYtwNn2oJIYs9PceFhbifI1OMho26LVrfFC/
	uqyywj5dS/DS0O14GOx23bwGXgQ2JsKZI6haDPufpjxUq+uXokv4+q78AKtAy/3i
	tZ+Lm1o/6xItdkz17z//zISN+PI531A3v8kwU5E8E6WyLhpu/t835v20oMus0bL8
	VX0t/taGbNE8KLmO3dBGhuZRBL/6q5izlo9oey4tvuSYHfSK3OLhqi4wv6TgkYq7
	dGSFaJtha8HbAjALDGtyy5O3R5jBm9sC/zpPLmqicnnmYa4lMImp9dw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41x8k3asnw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 20:44:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492KAx4V026199;
	Wed, 2 Oct 2024 20:44:47 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2048.outbound.protection.outlook.com [104.47.74.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41x889dtws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 20:44:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NmlD48/ApH+pR6nWoWaDgwqY50jdWe0M2cfD1lQeuEM/ykCrayGt1Xn4GfSkt0Hz8nPKKMK5E/QWRSALTRH+AGmj5mcH7AgXp7LYKCqoabdm6qkYoAuq56t8+WyE8afXWnKNivz4kpT+EZPvQdqJwzSJ3/lwCuRjJgVGjI4XB7zYcbPbzeFDQ0tI2PI+2GgTE5hNcvXOnjAmdNzmrO+JGWaxkb8IasvmjA+ZpjPOs+YcHqm0+XKaS0AZwhVBCD5EwUG0bdi2DhO6L7xa2XxyfLthVaK8IkZqLYvodQXEwfViBOX2TlXCauPRNzNjYp4eRaa5wfvxH2joc0A1Nt4R6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7IiTK2lXbHuJ43KV9ns3QD+A6zOMbOvpqz80a7jVb8o=;
 b=w038UD3TGrfzEkyT6f/rAPR5wxDyG9W9PNU1ul0gal3tdITibzrTXkqRblGh4h/+jJAR3dLSB0bjo6mUgvT5Kphw3Q4ZbCmHmgu9oX1mWUIAtv2lp5v8D3Y+Nyx/oUzseK3/ffe8KU3T1OZjurCOEXFbvTXiQXztJWdINVD0N7d615NqtbOtjZw7qmyrP/2LoZ+Q0YBwoWE4CvYMf96tfLi33Fu+HZkuipEZimo97lOt7oVdMLS2QwE4k/XPqwEn6Sjl7HqvjK9cm9E5S6Q4LPBgpMLwBxXIrqBgQBuyjqi5m5qjD5N5jjCXhCM4LsfB8exwhoZpjD0x187vAMgH4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7IiTK2lXbHuJ43KV9ns3QD+A6zOMbOvpqz80a7jVb8o=;
 b=vyz8Fp7WAp9bNUIFlzvgHuKZ1DNqCOxjD3R6htiCZFiKnHxDfnsRYhGi4G4xD4h9OV5QslXB3KLa42g6d/16AxMPUXMtvCl/gEEThAKIhuaFY+gn7Rb9wFdfRX/ZH24EGcasuAV0vF8rIzufMdf5b2JbB5vOtWp368Nr/A5x4U0=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SN4PR10MB5655.namprd10.prod.outlook.com (2603:10b6:806:20e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 20:44:46 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 20:44:46 +0000
Date: Wed, 2 Oct 2024 21:44:42 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <68150802-eea8-4d3c-9904-43c02d3e3fa4@lucifer.local>
References: <20241001023402.3374-1-spasswolf@web.de>
 <26991b8a-9fc4-4cf9-99de-048c90e7a683@lucifer.local>
 <32c0bcb3-4f05-4069-ac18-3fc9f76c6f7f@lucifer.local>
 <9d8761c5f32e2bad14b23772378a0a856b51003b.camel@web.de>
 <c63a64a9-cdee-4586-85ba-800e8e1a8054@lucifer.local>
 <cf72fda8-5fc5-437b-a290-6a2c883e6adf@lucifer.local>
 <240ede917b6712021481ab356714977e247036b6.camel@web.de>
 <385da45a-16df-4c8b-ae5e-33734e21f827@lucifer.local>
 <102b06e5b9004c7b292fb10b245e4fa0aef21ab8.camel@web.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <102b06e5b9004c7b292fb10b245e4fa0aef21ab8.camel@web.de>
X-ClientProxiedBy: LO2P265CA0150.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::18) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SN4PR10MB5655:EE_
X-MS-Office365-Filtering-Correlation-Id: 2da673ca-cd41-41f1-36b2-08dce3230cdb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|10070799003|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ngo7Oi5xsDm9r67PjCxJLJsfUwXkWsW4tIFf449XPgp7R+SZbsTAbKYNxKIo?=
 =?us-ascii?Q?LoKF3JWVDjbqqOlVr83oT30oQ3AHPBrvdlLAbEDearL4ghnytU0ZrgA5bCiP?=
 =?us-ascii?Q?6vLUmPmK6WBVuiAK6sH1aFsPOU23ADbMu9WJxC6AzW0f7XiVlDFVT2zTNFg3?=
 =?us-ascii?Q?48mzBnDliXivuMUCPpXjwP9K7O69eV3/cScVZaA2KxE5+brq0EA1bjhEpciX?=
 =?us-ascii?Q?mShZKEoLAXzqfQIKry8XRK+5bCgXKlsqn4eOxN+EAf/WF7k9JDOtBnWgyoba?=
 =?us-ascii?Q?PEObhC4Ya4iLhm7RDTrdP7/AQfHtLCR1zn0lM4dqwvAGXlsPpDgGoI9Hg9o1?=
 =?us-ascii?Q?KjavqGyMajU4T3tVSJxZnfIQ6OGPl+mbCg8xsODR2/9W/Lcb23mIbIXKno9T?=
 =?us-ascii?Q?T5RGNMzoCB+QrkgO72NksRpsVaBdHbeCQHONh53ZIYLafue4kXM645S2N/76?=
 =?us-ascii?Q?uiJPuGavl5nhT76HRK8Jrlr4F2scVc62x15MC8XyF1tnvP/IJlcRyTYRXk/V?=
 =?us-ascii?Q?FDXB5oVvDiUwRQtBDqCRbiO71LeY/XW8393yRz3JFfZeRuZ+I1zKpzbgiOyR?=
 =?us-ascii?Q?/JUBhtsiY3/sX4DbzQCR/SwK5KfiNJ7JWMZbFlIqYEeZRsUodVUXb19Di03j?=
 =?us-ascii?Q?nOe8CqeCZjE+POsKxvitOF1dNF8yuN3DW96ntY2DcZRNStHm9Zhuf2qD0AnW?=
 =?us-ascii?Q?ScS1es4g+YdxTU28JLuAQOVhxbbp5MELn3GtkKuSoQmlDmLMJvoMp7CcZSpf?=
 =?us-ascii?Q?nG8pYa+CRn5OentIsEvcMdmuGk/4HBRn7Yf6cagDrGnIzIQBZMJMFhpH6Ba4?=
 =?us-ascii?Q?4Vqnw34aFaqbCxH600I/VHiyFBz9ggpvWjaE9ksWTFarn058NHz48KEqWyKb?=
 =?us-ascii?Q?zKS1M4Vim9iVu5eShCBUxj0TewPEoKhGQ8Gp0bHZuX9/pzDzH594hBGauPb4?=
 =?us-ascii?Q?xYghpXQOot9s8cOBH2SmZQXCaDQkkQWa17rUuDHXz3dFG3lYJUDDwJZ4vhwe?=
 =?us-ascii?Q?oRJFNFys9JekiM6Vjm0x8KZV6x0b5HxsL+b0OpNUcW0IR7cVJh862NUWwgca?=
 =?us-ascii?Q?/hRbXA9F9lxkmDScHg0JbQSVw0YP4g+RpcEZG3Nrt57rsPYrtQKTwkHdSeh8?=
 =?us-ascii?Q?NwlC9xlHnAiyhAI2qhklZ7bUMAexOPN+HvIyeg7arvthGJK/YOr/GKndO+Um?=
 =?us-ascii?Q?JK1b694x9ZcCKqaUpFqb6pUzwferDzl2/81O44wFVjEUpxTwLr7/+UNkl3qQ?=
 =?us-ascii?Q?8MSY/du+oSR1spsJzWZBGyqfz1O2uYbNhlCR5o5a1Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+WVBD0eAZou0mLdTDSIScl0N2kSscL8WRSfnkXMUCYkFGd8ySEdXyfdG2LuD?=
 =?us-ascii?Q?JQeDnBt2ctcWNG5JYntvwocojFZ8Dpoiih+GXvxia1YK20F+fapCxiOj0jHl?=
 =?us-ascii?Q?J7tWfByRCzijvfZSh4ag3Ep/+iQ4pp92cpWVn/N/+FI4OMz7QZRbDXO1fM+g?=
 =?us-ascii?Q?Kz6u3OBIF5uyAFq0U4lp/85J6kLkV58TIDx/m7XTmgjIINAZ62w4SdlF9JRE?=
 =?us-ascii?Q?osukoMqz4L08RmTIpU1AgfiCTqLiJJ2bsLOgIT9l7zg9Avae7a7VbTLuth2W?=
 =?us-ascii?Q?7fButK/zuSxIJPuTluRYogHJjei/blu4vzj7kT1GE5gZSiHZtukn3aZx6iXS?=
 =?us-ascii?Q?4eYsjPhapbUqpydQSBlRPbmTuf95ZAIWvVS9Q1HPMTs9/ZcYwqpPgzu3IrkJ?=
 =?us-ascii?Q?vgnbAN9qmLOheDkau/29Oo7/rWma/31NPK5FlZK1SRb1yz53wOc6fgU/IlTi?=
 =?us-ascii?Q?AWjvcR/WoawtNvEKOy1i0Sn7wmIJwixs5NyX2HgMQZRVFZjgRny9btPDpESp?=
 =?us-ascii?Q?NCpKaHftBsN6GbicAzg+zwLebBRRNqvYX5NhdXTXSFBF87jUxv4xhrmMoZ30?=
 =?us-ascii?Q?kKzTy4rOKNtg8MkMullx8HGRJdVaOqsWLoIGnA5n0AbI2ZcwqXfV5wBXEmeX?=
 =?us-ascii?Q?Z/mmfkcP0G3rPdduU3UvZABlUO/yzL0jPiNYE0m872ATznRjIu4A1ci2DoZ5?=
 =?us-ascii?Q?TtWMMZm/yivlnpINBj4JA2FahADAepfs8qQve/IPJmoSgLPI3cduv+s796/f?=
 =?us-ascii?Q?4tMggLWX5lcmgVKXeTn/Y3Rnc+uVkk2h4nxQIXnlqLHvtYvljqsMEOm3p8bU?=
 =?us-ascii?Q?RN3eM8fHd8YSp3tOBJj7w0sNlSjvubTLSRfkKdAzFw77orB+1kDQx1YKIFPE?=
 =?us-ascii?Q?elSxJS5wy0IqT810X0ncF+Gpo4iKU3MVlYROWlY/QJFywBCZRAQRWxNls80x?=
 =?us-ascii?Q?0Lt6y7rxry2Qx/Sswc6zTz8kF7HylNBhAhbpV6cFHtAkL7qUTEfx1ICAFPnQ?=
 =?us-ascii?Q?9d6HARu990ZxNVip3vTZ3teAtzblqk2+PVx1EWT7WG3ON8zWbHcY3Mahl7EH?=
 =?us-ascii?Q?saFST7+zikM7psDt/k4V6fopToteMoJVpwnZVA+heCSMVpNGnVnEZVebrdTv?=
 =?us-ascii?Q?bhmetylHsKjpIeO3VQqKA56YzJbs0yL4XvKD85DgmZ3cVNMz7nOMUFIAx0JK?=
 =?us-ascii?Q?gb1ZChq3DxXj/V5UtrWWiU+uFOQIKYVDeCK/qU52/pwQyxs0sAVUXWIdWIh0?=
 =?us-ascii?Q?Pano5pKy2BrnxlGvHWzmVQpOvbacKlstVqjBTIP+YuT4SdsKISVSSngPo/Jp?=
 =?us-ascii?Q?C7ySLX379YcVJypoUpI7dq/5s0Clfzxlr2IPdMVuzDYdNgqfCGIiMkx9/mh+?=
 =?us-ascii?Q?E399gbnUgCCoJ9bUuJYWwUbEyID37KT7QPbFNBvRYt0yx9Ll5AR2oNzR14wR?=
 =?us-ascii?Q?rzVfCNYAnrGMBbwTyoFxnk5rK19lHyI4XGx+3FiWYVHWW58JrtOD7gf0BmOv?=
 =?us-ascii?Q?/RY/hTRt4ZP01WpYkbvfd2zsHa1sLAFi98gplU49G7Cgs0Zh2jPNVak1YObo?=
 =?us-ascii?Q?fvrtAQUCMB1xdBhLulgfpoFIFxNxJ78gQqDeiVKLjqA8mIiJm/b9wRkq5PrM?=
 =?us-ascii?Q?z0Hfs1CuR5oRvvWEQ1pjW1+uydg/pi6gwCA00svVUycRwgMqt/dhedB6zmKN?=
 =?us-ascii?Q?l/M5eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	UcAQ+KpCZvfPv5zojmYDcX1cO3SmXblH8ClgvEN+sXg/iGCmTV00Hrv+QbFs3tLYfo9AJ2FVAiQeq8vf6asJGbUo1KcEeem14+TNe61MkPOSlC5quc6959icgQbWitcyh3kfVK5/nek9jh2NiW8pnS7nZ31ZvccMBi0BDZLLvxCrQilTUQDvgk8z6Ashu/l9d7S3n0eXtXFmeZ9AFOZ1Hvg7zRwvRYoHEY9TuMLvtCe1cSu5EWsR5Ve+nQUxxWftrK+NccKUWgm6aVu8WQDT/CxjWI/GvJjo90TxKxnuDv99TJOLqPSbllcOP24ZOjgH1eOgoQYZAdD1wX8eFOn+znwNfVokxLI37I0xrzY7F5P7H3/EfkhQWyIdAiSlO+O7yhff60OGh9Qt8gKAMvNZBnXBaNE6wGVU/F50uy2q4jfDxRgsJUlq/XghDTP4eW99HXGL7H83F3/1U67vwCHLwCDBVgizQF2RMW8XKg6bxHV9WXkuQ4HKgkwD0qzQ3Fg0Bvq/Ew7SyKG+jlp8BUd6Ir9t6J3IXWQdpJVQ2lwtGG7EwSLxQhEtbV5A85pRJS/xYryJheHDTUAAbuXTvkQIPczqA19bXA9zz2DCYudQwb4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2da673ca-cd41-41f1-36b2-08dce3230cdb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 20:44:45.9554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: neLZ++IVNjzExJmwhV1wKuLbfH5vD7UWf/c1IgRGePPgizZLnIqi6UDZ0ZDeGzo/QvaUR73fv5qdDuqumg8kYou1GnZJVcdZwKt7vr8pbvU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR10MB5655
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_21,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=753 phishscore=0 spamscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020149
X-Proofpoint-GUID: 2d9Ld0R6oZ93RW0tcOtvjoeAMrap1juC
X-Proofpoint-ORIG-GUID: 2d9Ld0R6oZ93RW0tcOtvjoeAMrap1juC

On Wed, Oct 02, 2024 at 10:39:06PM GMT, Bert Karwatzki wrote:

[snip]

> I just figured out what was wrong for me in "Ruins of Tasos", I didn't have the
> 32bit vulkan drivers installed, so perhaps if you remove your 32bit vulkan
> driver package you can get the crash, too.

Thanks, unfortunately I use arch and it has a hard dependency on that. I might
try to force it uninstalled anyway.

Sorry to have to keep asking you to repro but for now the only way sadly :(

Hopefully this final patch that I set should give us the final bits of
information we need, can't be sure though.

This is certainly a very strange thing! I wonder whether a driver is
relying on old mmap() MAP_FIXED behaviour...

