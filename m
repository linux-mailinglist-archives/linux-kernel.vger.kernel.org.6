Return-Path: <linux-kernel+bounces-348253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21D9798E4A9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 23:14:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 854E6B222F8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 21:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EBA021731A;
	Wed,  2 Oct 2024 21:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MOb3dbnl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ieiezz+y"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98B681D1E60
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 21:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727903639; cv=fail; b=TSlMfTcpsleDlxO4qA3puOCvBiBDE/kyUgZ3bTagD3tX3r6SvkOF5HBf23buFWO3JzfAsH/IAwqCbT46K4PiF0qQmObpDJj/2LKH/n8716AzzVOGO1ftWE3syXh4mN68NlmWeu0oZ/Zy6kBBCl72CK+B0foF7s+gVtSLgXodQUU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727903639; c=relaxed/simple;
	bh=awcFcie/phEWcgue6uXiudHhwrH4oRU4fpftVkdVZFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ss3PwV+lM7A2EhlQRUBDCWHNZeTWe7qFVO5EeSG9E8gQrfMk4Jv/UqdOBEdYofZeK3F8oRLUUro7PyahcqdPClHpETtmXabTAzlK3a9JE1is9Bv3apgJNAiM1oSoEZhYmukb7iW63+AMBJs5xKusjvTjN/gyYucLJS05q666qhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MOb3dbnl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ieiezz+y; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 492L6p5w011593;
	Wed, 2 Oct 2024 21:13:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=yhD+IRNOhSthcu6
	dQBiP3H38l25QhxDrXzt5RybL5uo=; b=MOb3dbnlBudc9MTgTHke3XnMRt0zKHR
	UyRPBJobdEmKvOSWUCsjd3x9tMug3hlLnNZ8eDCxCwX5Bhm5gHYda87fbhyxIBCE
	x5nV0sza8oMZEViPTt3uML+RAY/1ORHmIC6EANTYpBs7vcP69ILXuexOh3RUkFYj
	Z3wCMkarRygpz2J6MRgeKv5dtIpL7EXRlSKBc1N7/LQcdiP79qzK/faimRYgCP7v
	pP21Q5fmE3Ry9GhshObtZWRzkJAAU7UpC1Xacv0wPozdL/h4DCCp8myqgJagCzSY
	dRl4Vi7WnNXT7tjPJvVW7J6M/79wFGBBN6cBO0KNdLihjtT8YLGS7qg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41xabttmbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 21:13:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 492KB1Ki028430;
	Wed, 2 Oct 2024 21:13:50 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41x889m8k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 02 Oct 2024 21:13:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sFTL9EVxzIOGgA6K+9IYjyKowA4ayuCXwBQAgxmkPLbteTInjeHXEhCV4hjrXfb2caNZ7xflmEGgGhP0NWobmhbNZ2cPi9sb71SX4HYaeKnUZVo42LmkibnF00QU2HEeAjFnBNETdvX43nQNu3LdyNWo9PhCfU3k1o6jbuvZktfIaeFhgdO0cXJnwVDdtZOL+CbV/yu6Rxy5puG3Q3fpsr7WTxPg2nJ1C6zWEavDf+fgiIEZy5ndbvqkAZYT2eoQESvd5b22mflOEOAYljZSuWUfxPg/SYCCZ1AjJP5sxIEvNOi+94Sxrj48kohG9UQK/w9VXzcMwoJAJxXqyqaPHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yhD+IRNOhSthcu6dQBiP3H38l25QhxDrXzt5RybL5uo=;
 b=GTkROYsmx4iKWBF0p6yrcj+CX8ZjBmVk9odNjccyfcrepxg/cIxlkMr/mhCfj1FdZnMGKMNEXvo8BhfGay4lg5khfOwZvp3speKMv33pju1ZHO0+UnwhdecZcypLisPHR6qaYTq2TAg8lUoG+emlSfvoEI7lXYHWRem51RnxW+U4Yu5BEoMtWdsCBAnAZBvh97HPfDuRwPH0vq+qgeiZOG+iThtkgCm/vHtt/7FUbAkEt0rpJzNwkm+XbqlzhmYe6yixK6IALI6JBdXHL8/YROhipLYhtc6juYFPi++Fh2JpEHzvyrsnCCGqeahYIC/GWxUWKQ4BsNEMDGA+PCM/4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yhD+IRNOhSthcu6dQBiP3H38l25QhxDrXzt5RybL5uo=;
 b=Ieiezz+y9jk0ZeVkJRob9OYrRteWNhatSkAzuY2H/cHq7QnAFoNxHZm+0XXTpokBNkXXE77vEfNF/rGnMFlBkv/O6vusCaT7vFtr1E0/H16zYwuRzCIKxshU1nZhODqXzeNMSqy32KAChDt7tHRYouBEf4SYzSONvQ8akz+jiWU=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CH0PR10MB5035.namprd10.prod.outlook.com (2603:10b6:610:c2::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Wed, 2 Oct
 2024 21:13:48 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8026.016; Wed, 2 Oct 2024
 21:13:48 +0000
Date: Wed, 2 Oct 2024 22:13:44 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bert Karwatzki <spasswolf@web.de>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 14/21] mm/mmap: Avoid zeroing vma tree in mmap_region()
Message-ID: <778e28df-3bb6-4428-b2ad-3355ddaa12e6@lucifer.local>
References: <20241001023402.3374-1-spasswolf@web.de>
 <26991b8a-9fc4-4cf9-99de-048c90e7a683@lucifer.local>
 <32c0bcb3-4f05-4069-ac18-3fc9f76c6f7f@lucifer.local>
 <9d8761c5f32e2bad14b23772378a0a856b51003b.camel@web.de>
 <c63a64a9-cdee-4586-85ba-800e8e1a8054@lucifer.local>
 <cf72fda8-5fc5-437b-a290-6a2c883e6adf@lucifer.local>
 <240ede917b6712021481ab356714977e247036b6.camel@web.de>
 <385da45a-16df-4c8b-ae5e-33734e21f827@lucifer.local>
 <102b06e5b9004c7b292fb10b245e4fa0aef21ab8.camel@web.de>
 <68150802-eea8-4d3c-9904-43c02d3e3fa4@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <68150802-eea8-4d3c-9904-43c02d3e3fa4@lucifer.local>
X-ClientProxiedBy: LO4P265CA0200.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::15) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CH0PR10MB5035:EE_
X-MS-Office365-Filtering-Correlation-Id: a7f7ef72-86b5-438b-66c2-08dce3271b32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hitw7CMvW6Wrh35Mm6MCSgrN4vDPH5g7P8YmBbGYKvnTfHrbclLDdIooPox9?=
 =?us-ascii?Q?wC+H7L4TifmkUDKBOwUgAQPVEE8AgSkoD3lL675c92kRP7Cgwvr3vqmnRs/b?=
 =?us-ascii?Q?Je5BIlbnVJQWp5JetgE1/ht4+Daz/BvVscz5aHPl8JsFfCzXqiaQu020ySOm?=
 =?us-ascii?Q?Kw1ASgQeFmBS3hkLKh8yYt7ZLY3+5fdQuUQb+XGv+sUd3i5K5PwwtbG6plQT?=
 =?us-ascii?Q?ZBO1X+faMOdubSKJ26VOJCQepyVOQIPUQa7/WuHoXv3siIzgrKrVzo6tpDVW?=
 =?us-ascii?Q?W/y0xebDXKNznTp5uwwtNKkoewQs/rCm06R0DCOhOGkcCF/SP4N1xrYaJ2zn?=
 =?us-ascii?Q?G8lWMEpHLFrTruBGI84eAKBi5DHqQlpT96NV08lSdY0+f1Yy/vK/hBK4JcHi?=
 =?us-ascii?Q?Bh2GAwQG0zRjhhalIxhIr6xoO19FmqMTdeSE4mbN6nuW/SmTn/eL/YAyRaJ6?=
 =?us-ascii?Q?L4+nwTooIuhB4865L480zI8umyu75/g4rvYj06iA9Hb/6dWgh2Yk0L4vhbNl?=
 =?us-ascii?Q?TXZKtvGqJAax5l2AUFSN8EHLvWDl7LvXMIIhYOx8X9ezO5VdQVHcOqZGFC9J?=
 =?us-ascii?Q?VroYqTNsZvFrADFO6ZFjVMaeHyC65PVfCFzm+Ezd6dly8KQO/iDPaDrHLM/T?=
 =?us-ascii?Q?AAgjxlSbrFFZbup+1KgKcJZDKEWwpD982gDL9rb3NzWNYB38r8RpE/ARmqzS?=
 =?us-ascii?Q?1gBLfEcgXcxaQNAHX3CFkBE69V/PQPjQ3YzEqwxFRreIbVkd0X/TObZAqT6M?=
 =?us-ascii?Q?Prbbqo5xWr7uyEV4kKOAe5JcMAcVuAcB+uqOZFN4L/5mkpFONY96mJVzs19y?=
 =?us-ascii?Q?Fr6Uw6ie8c/ZZ55lqIteFiWU5e1qIpwMH+7CIzYFlQ+yR/Vh3sUO61DCnNt5?=
 =?us-ascii?Q?iPnQqcXtMagWJQKaQ/he124ywePxyfZWGdd1M/lM5FgvOqeHe1df3+nt45dc?=
 =?us-ascii?Q?8om0mJjPAlR8L2qUIB7LgSnLNUuEXKRNNmFR6GtNylmdCpWY/3UN13nWacek?=
 =?us-ascii?Q?2aycejIMOY6LXlFWsw/xJrngohji5AaJZpUcjqn1/MzHPRZgYqpxtKBU4m5I?=
 =?us-ascii?Q?g5L/aJs8pLKn5xJ/MydLN+GDI3+JbBbr5ejhiKV55spM9b2sgH9PT0s83tr2?=
 =?us-ascii?Q?LygNy7Ja/i0B4L5Mmso51gMgk+hTfpPgGF9KDW0kq96pX2Mtg0E3+xKZijMU?=
 =?us-ascii?Q?EUEEo83lrJLCDYVnTxBq+hWOftY06wXeKfsuvskiYvgd0f48iybpXmgXTBrZ?=
 =?us-ascii?Q?Pm9lazmRl7UWE4EUbX7i9uhWI8HPN0mA/qw0Njy2bg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ItH6pJ7rP5y5acAVC790Sv4HrrjRMyFpfm2pzNK+nOBIb6rOLuUFhcsF47Do?=
 =?us-ascii?Q?cZghak/Iaiy1yht7NoxMlcEQc9RuB+2CFlshXIIh9593pHWI6Ibt4CkDXAzT?=
 =?us-ascii?Q?sJTFH7EZ328bMwYp2eLMGrBRvbIsbQpesmmMWugG6hFz8T9LusWfPSz2aFmY?=
 =?us-ascii?Q?Hn14fm1MmBbkl20bltg5ugTYCjXe3c++kTV4M0vpProMP1gSbv9fJ/n9kSEH?=
 =?us-ascii?Q?KbkU1xa0dw4SOFpsoPrDQwIMXn9+VQmMt0WXLPQIU6wrNaJOTaf4qD9idFfM?=
 =?us-ascii?Q?5T23EyDAkqTkKtaIUONrlDwN4l1nPrEpPVvGhAzKdqcf82JZkIoR3kzTse/0?=
 =?us-ascii?Q?clZEAkdRuaztwXNLElMUnY9x+gAPj8ZC6jyY76cF7ikn0KPA8o7VWfKtPVCe?=
 =?us-ascii?Q?vB7YVpUuA76f+F/eJtLgtgympm0osRkorZ/OcHsMFe7TmsIGWPioHkCWbysD?=
 =?us-ascii?Q?G4psfXiol76frNgzRuLxjvngcXu+gLTas3aw38Gz6VFRJvG/TxEUzk0dJ1gW?=
 =?us-ascii?Q?oVNiO2yTMGt2cBrteTwL0SB+qdtnWLGU0jvklFDL8HEcxw+rbmllxy6zMrGU?=
 =?us-ascii?Q?Ul0YlWmIm4KICy0VwHNGyk3tHEwSumUFzf/JOvoTUks5gC6P6Lh2pND7nkTz?=
 =?us-ascii?Q?5OjZ2t7Jx9vWYLzoLs3DwESs4Oo3IJOSrfqL/eyiCArgLeSm5OMueKaMssbY?=
 =?us-ascii?Q?7mpY1a3WJLjvc0x4DD4Hl8lID8IY4isJwRIbFbvddvwch6p44yJQr1Cysm04?=
 =?us-ascii?Q?VklNqkhXmQq2SoFwCKjpXfkBLDCZL35hjhAXJAAczm0TmlzOXJCqOZewdQtA?=
 =?us-ascii?Q?DDsa2idMKSdSdlXF8EnBLEp2sS11+lW4tJ+u6LSZR1NNJydk7KcBxFkDoQkq?=
 =?us-ascii?Q?5CYJMEWJTGFxs0/pqDpDT1kqxjiD3mod1pyyn0XCFqU9L/raRrwlV5W4x1Sz?=
 =?us-ascii?Q?y5DmYFyq0rjsOJDP++99XmclzxTZ9sTi/efOZwlZMYaST9Wa6F5Re4IeGJgJ?=
 =?us-ascii?Q?Ke+tOZcBxdITjsBbQXoRAPqXGgSAvpiE6lkPZlkSYx4oua7Q6Dm1kce7Ppp3?=
 =?us-ascii?Q?e16P9m4p3ALyPYPDtWsRTpYyTrQ/8OeLKIihnwO0wRfNcoUNQ+uYHrgqT2jE?=
 =?us-ascii?Q?1jA8FbuZam2OlTDjwjm8gPuyd920dFBnL46IFiAac4/5yWlRHJr+LC7QBgh9?=
 =?us-ascii?Q?ZQH1Eagkgpf7ZE6usjt2pd0ntK4wW+WVbsgG33/uixIk+WOIyBO8JhbztMjB?=
 =?us-ascii?Q?AU877PzRhQBHc0pUwkVv+xkWUGQjlVW8ESaAb9eHWx7wVVzPSygDy3hyuuC7?=
 =?us-ascii?Q?bu/fVhTltv+qBXUO2i9kUqHXZW3vK71e0wzTwLxBT4zBWoq57cFq01j/gap9?=
 =?us-ascii?Q?bwlzlTWHK/hNCgTHeBZB/SBWTcjRN27+rZnj5igSrAAXb3JMnd8JWsQBZNyN?=
 =?us-ascii?Q?7CcU9QvgdhvAwxTFtYaRMcvjtwFOTTKJ+zMfs93biBt77XH/lgNeudvW9O+e?=
 =?us-ascii?Q?7YkekIhBMTbcw0Hfih9q/I3IY3/QjmGgWxQkXJ1mDKmroMgJCzXEmkMVoq0O?=
 =?us-ascii?Q?2PBvp+FAVYFY368Qzyce4TCHoRdUpu1e9NCqY2fTxLIt9VRbRY0MdyGUp95I?=
 =?us-ascii?Q?S3ZsXgXb7yUbewx58Xf30vv4nO9UgFYl2QPhxLjiVtbR50G4zygKTvdAItCb?=
 =?us-ascii?Q?VJtHVg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QiUIir68yxVeZ/s0/1Xlv9TZHas1/nU83CnFWhWSGJ4pMNCvLOo8RHx1kOSVMb38cU+iWxhYu9znnnlbA9l4orlqKF3nBYiwc2pJ0MbiY4q1G1fG9RCBSRbwnXhYc4N2KkeSsro+nY4QKuKbWKkjZ+SrN20k0vtOVDMq7GhxSW0B0c24CaSLIcz+b1jzS7C1wNSoKFvgqyevTGqHEF5KNUp3vMeoqHipkfMFdSQqpymDBEjHxzehOqHxeG95PueHYXjEU/rAqGADNplIS1C5kyLMDF4ouBA8m1aV2SKewsgWXjzbwM+DI8PlN4h13XQn4C8pMTIYMocxiI9ddKRJKALjjESjw4ok6LuvHurvDT3GfSzwcbSzaAGLGgKjEwp3qZfcYW6ytavsOapZBbLVRSIZLO7bqWRk9UFBVs0gMIh1vcMvuKI7+qiCEIb4bE7R8sSSbXQmLluQpQUnqY0JI2MJCz6bMKmsiBCEpBT1NjCziTlH0f1LhxcJkCMxZY/feFzHPvlonJvwP4FZA6Bkrnn5y3HrSq2nwTouXkjcoZ6sWmwBv4L99Ok2ZdGrkMr2ujCzXF7mYeDk1aDR2MB255k9eUSrqD3N0tCwB1RJX7E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7f7ef72-86b5-438b-66c2-08dce3271b32
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 21:13:48.0310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y75JwOjbWQ1MfJO8Z+nMkoPdVmZSZ4mFpooDuQcgIFme4+uyov1QsLlldcnz+6c5ufeGrOCnzS48zpt+NanQln1mucedJdgwyfdT76OVzIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5035
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-02_21,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2410020152
X-Proofpoint-ORIG-GUID: rtYa7QEsRiSEH9Et6MdmxdBc45P5fUL9
X-Proofpoint-GUID: rtYa7QEsRiSEH9Et6MdmxdBc45P5fUL9

On Wed, Oct 02, 2024 at 09:44:42PM +0100, Lorenzo Stoakes wrote:
> On Wed, Oct 02, 2024 at 10:39:06PM GMT, Bert Karwatzki wrote:
>
> [snip]
>
> > I just figured out what was wrong for me in "Ruins of Tasos", I didn't have the
> > 32bit vulkan drivers installed, so perhaps if you remove your 32bit vulkan
> > driver package you can get the crash, too.
>
> Thanks, unfortunately I use arch and it has a hard dependency on that. I might
> try to force it uninstalled anyway.
>
> Sorry to have to keep asking you to repro but for now the only way sadly :(
>
> Hopefully this final patch that I set should give us the final bits of
> information we need, can't be sure though.
>
> This is certainly a very strange thing! I wonder whether a driver is
> relying on old mmap() MAP_FIXED behaviour...

I realise (being tired) I missed one thing... if you have a sec could you add
this to the previously included patch?

Thanks!

Rather important, as this is the main munmap() entry point...

Again, hugely appreciate all your help!

----8<----
From 200301df3dbd1ca5b3ab2e9238af15602d72e839 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Wed, 2 Oct 2024 22:09:21 +0100
Subject: [PATCH] munmap fix

---
 mm/mmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index 8a1d5c0da86f..68817f83263c 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -1658,6 +1658,8 @@ static int __vm_munmap(unsigned long start, size_t len, bool unlock)
 	LIST_HEAD(uf);
 	VMA_ITERATOR(vmi, mm, start);

+	ljs_dump(mm, start, start + len, 0, true);
+
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;

--
2.46.2

