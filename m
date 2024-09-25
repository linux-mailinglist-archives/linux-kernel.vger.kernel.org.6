Return-Path: <linux-kernel+bounces-338193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6569985496
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 09:51:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D972C1C2354F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 07:51:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6974157A72;
	Wed, 25 Sep 2024 07:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="krXNYUNR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yBLRYwBF"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99B95156F28
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 07:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727250710; cv=fail; b=b+Pg3egkNYszUVLDK2h/7iLGVrEu59tq8Ipa1N0tUfimgQVRQBZmnlcS5p7aY9nNGqUFGd3p2fktZ6dEU9m0xhL7uESheijBqEUKIrr56ABlLI5GhLEP+DgrzFhwkOTxhV87oco5l1UHjF5SJJDQkFK6KpRN4ywiUA2Wdchmrmk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727250710; c=relaxed/simple;
	bh=5LkvOhzQWCH3qpZz2KoFl6l9QRvXcublu1/6OVHCpOA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=T4uOhbrJm5GAFRueanLI2SC61m6OlDmwGVX474VpDPGG3NWzvNeRq5nQXlb1xs7SGh2pQ+WEzV0hNn9OSFaLkiwquWgd7+0TuzFmiNtQ/hkLTKFPUFdETYn/LnAkw30UDMvNhOYfN2UPz6Zw0D8vPtFuJOSseTzT7dfYdcTBrD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=krXNYUNR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yBLRYwBF; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48P1u9bF001806;
	Wed, 25 Sep 2024 07:51:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=lZHmwWBVvwddV2r
	0kIuAXERm29qmjcVb9et8vmiZ6cM=; b=krXNYUNRYnzYBS1t3o9gxCVVSPM8TS1
	QNBlSJ4MWnySJmxFX2VkaLPvAbclsi/k15k9pwjvpTlIBaji9MGCEUVQWm33ig1s
	3OMP1IesWMBZ80Dl9OAsbC70G4O+OFaAbGrTtdttYowVuCydywqFKS002oLYRz2N
	x9LvQr+5hWEEnJr0mm0L/QYpad/AsHV4T2lwwqbt+VQMkd78Wy1WDsmp/07z7YRw
	6Z5R/YXOG7ppsXPWPwhK76IzXXldJVsBkbBJYoxfHLVzcuoccbMGpOMKlSOWIgqj
	nDdV6Y32PHR1qnB2j0u5OcPaNnDJTLrFyk/tyW1WEu6wK8BjXtZtqNA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41smjd72nx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 07:51:41 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48P7bjFu030329;
	Wed, 25 Sep 2024 07:51:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41smkac4c6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 07:51:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kHF8oX5uLAlCWL9sixZYkIOlI0IUnoAb4K2uKbAvseStfssAxL53RUFke3MSQw4lSD30tQDmhz1R2aJ8XXmGThhEXKDTllpAX3bA2cMMWr/tO4VHf5aGa4xr3SzMiiIZ6clc8dkEo3Aqbm7PWPJ23NZtsyNy+YW+4Q98fv7MIEnSHKAH2lv22NWwH/cQOkTTSZ3K1DBgkuXxxURV3kImyy49Rdo1We2PgpAgpzhWtriyDp+KvRd6o9K4OVyFJ1LUSNSAYFg7JSG4GF9j4k2lxB6lRtbONP7mQ67XKJ73WXXvm8SWCIOj7Uc23toKOwTS10+sgtEzbXX9uDrPrwQvbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lZHmwWBVvwddV2r0kIuAXERm29qmjcVb9et8vmiZ6cM=;
 b=IZ2Gt8AFaqHuXSRxjAYrfQVlVrHIYjftUFj3zpBz2vQGn4FQa0vhzSnlkmMVB6tImQbOXP+P6cMghv/tWpPUDqAo/9OAcdEtPf5Aay6PdZZMowNjMS9aIHDAyacRqsbCGfA4QfHQ9+uIEG7Ca/GCKTGMJ6GfVquEZJxPPnRIY920Ce1w8EkM9aYHmzH+LTETXsJvDCl/4wiqAt6eYCCos6E4ZfYv1RU2w2p63XTeCvAsqyzmD1eIyX18XwKsh7OcbSpMtix55MJx69xrBn8z/la0Jvo5XkjUwtjprQ+jW1zEc2dIc9/WiY7igX875IPQUz0OMssyCMpXIbyfVdGVzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lZHmwWBVvwddV2r0kIuAXERm29qmjcVb9et8vmiZ6cM=;
 b=yBLRYwBFitRrGpm6nIlSOHDWT/9eFieX9BGTyJf9oaXdq5VVZ3zCA27rzfyQnFJkRhg71MiQ/3nPpu/vNmPC48doX7sCBJsjesGjU7FTFR3ozHNJxhAsQuicgcLe9txXAQZYlfBJFbXdPevaUCIF9ogHGxQKmLWP2nvinZnJttw=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MW6PR10MB7589.namprd10.prod.outlook.com (2603:10b6:303:23b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.13; Wed, 25 Sep
 2024 07:51:38 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%5]) with mapi id 15.20.8005.010; Wed, 25 Sep 2024
 07:51:38 +0000
Date: Wed, 25 Sep 2024 08:51:35 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] mm: refactor mm_access() to not return NULL
Message-ID: <2fae1834-749a-45e1-8594-5e5979cf7103@lucifer.local>
References: <20240924201023.193135-1-lorenzo.stoakes@oracle.com>
 <20240924201352.GF3550746@ZenIV>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924201352.GF3550746@ZenIV>
X-ClientProxiedBy: LO3P123CA0022.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::12) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MW6PR10MB7589:EE_
X-MS-Office365-Filtering-Correlation-Id: ad664bd3-6579-4ef8-bff2-08dcdd36e2fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2+v8hshIn0XYDR5vDeyjWT4Qg88B1OnYDl+UiUwEzI8/f5raLqRMLJS99Wks?=
 =?us-ascii?Q?7hqPwK/PQHmR/OqiI99NRQNQ9hNxCXNhS7t3Kxxb1JVaWuzyVNa7wpDPRaQk?=
 =?us-ascii?Q?T7hrh3jGNT51vWAfMRw9g3/WGmG1mIRqokcBXldoAoUchdREVzlR5dcOfIBn?=
 =?us-ascii?Q?HBVzgJvgpl0eErFNZdeqcickffGtOUDztQYDtqApKwEMzvEfSW8dIA6pHmiE?=
 =?us-ascii?Q?oHwwyvhK9B+obUgDVl03JaV9ts+aCcvXvmVa0fxrCER1Q5MQKDSwLAVUlBBQ?=
 =?us-ascii?Q?VeoqETA4VjLJ74dYRgTcs2h9fqTHBJNIkz3/PV7oh+elZZ/1b2EiSfWdDu2C?=
 =?us-ascii?Q?9Xi7c7Ve1rshuOVty0qiNF+pL6xFon/GiLtqdtaO3YKXgPZERxrC6XtpFFR2?=
 =?us-ascii?Q?+z/I417q10esM36CuNVqRd09PPjYUIHA088N/+bOn3sYzWU4StnQmBQYRHWx?=
 =?us-ascii?Q?9mShB2ioc9DMrPnIaREW4NjbQ7Nj+zDP0WaKXW/03ly9x2t2Jc5UaxLQIQTI?=
 =?us-ascii?Q?SEuIkG2pcUsK746aePF8Fyxd2vjPE3c4MB3vDAzZWaqilVQhl0WaplL4fwEz?=
 =?us-ascii?Q?AE98eT32S2XOkaKrlHyKZs+45PJfAP8IjlBZ842c5M1gJ5AjYbZ9v2f5VEst?=
 =?us-ascii?Q?dpDVUpXkEG7L/mKjIWN6B7Xf7tQoF0RF4dt3gGURULEJoJKrGiKnTHb6YuwN?=
 =?us-ascii?Q?2cSRpd8yrrillj5IRJjx856oxLiH24XROqemarfQaAKsbu5h2+KaCnyQVVzG?=
 =?us-ascii?Q?KThDa7rEAVeXV1gWdE6YZjQ+qiAMwY6QFfHSYJNyrbMfCxhT0LVxHYZwZR1G?=
 =?us-ascii?Q?aW4PTRUmJvR6btqElWGrB7eTvKJqOmxjFwfIAfim2kKWO43dRioS7M6FkYlS?=
 =?us-ascii?Q?0qCKuM3mZb1WX1qzIx28ap8QeJeEKpHfAODdRnAE5BIs8se4aijuQ2dUv4Uk?=
 =?us-ascii?Q?oxxklrIE6n+V/PpudKkWrbr97OvMoVBcQV6QIwBw0iKHc8ob1LuVKTjaiuSB?=
 =?us-ascii?Q?QjWTSyYYTgU75RWCfgLbrsc2rNxFMQPmnawBzjJb94A0CjZ64Qo19Jd9c60f?=
 =?us-ascii?Q?9zsnr4VnA54CKU+WVWOyjXG6zFOYEL4brTENC0UxrSBM/IYuqsfH+RdQDFOc?=
 =?us-ascii?Q?v1IoIEWiN7S50TvyzQ44QfZmcSIxEglcs1N6CcyQ2W6qiH1nfnW8iPT74A5L?=
 =?us-ascii?Q?kSoXO9uj+wu7Tnkso1XZkh3ENtw88NvMZfOqWRGtSr5XIb1r7Dpocumx3QmZ?=
 =?us-ascii?Q?EcZTSiO44Z/t+zHqU+qoz7KhQw0zwIyWKGQIeb6N2rpPcfwk58qoC+6Yo7tG?=
 =?us-ascii?Q?8GI0Qej20fuMxjER8vAglvbn6o547sL9MtTRGvkKe7r+BA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WccEkndLn8j02HMbQTr/7Nb4Devo+RRW2wUTm+z8wqk4dMvYQ57ZAoTJXyNE?=
 =?us-ascii?Q?6exRqHjjd5KJcCc3AFQEogHB+MyrssEeWpp2YTQcipsewC3J7YSR5Sq8F5H2?=
 =?us-ascii?Q?pqGbathRBpPYtXWVBDipWGNaC3n4BUBpB4ti0pnLPwT+3YdFj7bLiTLBk+SJ?=
 =?us-ascii?Q?ey9W5w0B2W0p2Xhw6okq9D3MbQkrfhuYYPiRqxTQ1ORA5/nvBM7Z/zXM1Ylm?=
 =?us-ascii?Q?J1URYOmyYfRW6EX+n2B5ursqzLDQHT1/N+3eBqGyGMurzS3VRDhcA8j4tifp?=
 =?us-ascii?Q?1s0hB14z7g7ISN31BuU/Prj3Z6FqX02+sLbctsfml7u7J2NqR/R2i5QSE0Js?=
 =?us-ascii?Q?loRpKhxEUV7sySohlQs6OOOKR5jGrv7dlM4cq+y0lVfhyT1+HF38kAQwjXXJ?=
 =?us-ascii?Q?XALkT+HZJowwrZ7w3fDImlt90b9XMElyl5dLkmDxQdsdRtbtEr/E2zKE4o2H?=
 =?us-ascii?Q?eHsna3q+jux7iBvLdtf/hVT4Qe+/Y/Ywgwdys1CT9f/XyrrswaioGwWGOQdB?=
 =?us-ascii?Q?pEAPKOYTQpAGJB/QNpaoaPWyv0eHUwM+vbke4m0YYyAsjjrOMyumD9pFSk2b?=
 =?us-ascii?Q?ILqkSxM11YtyHankAUxB6cgw9SI/cd0BJbbFcDL7mFv586rglCGX/ERn1dSH?=
 =?us-ascii?Q?unL74e5jMLpHPdrNmSSF0muszjIBIUUKhIzsY0U8Wc65Ofr8eJk/5o/Xvky4?=
 =?us-ascii?Q?Y5tOdD1LQ2WJPSZ3vx63l+/UZEgN5DKCWIcWmtfaPUCqVtH5l7cCntypWVQE?=
 =?us-ascii?Q?14gbZ1tirvkERnJCIJt5LkfSJTWn162M41kdejl2+yOo8PyBLLaCm3Ge45dK?=
 =?us-ascii?Q?+J9Oe92IslKMnH7BlNZi/RkGEI+SM2vWKsTCX57SPTiKqUYottHz1H+30lar?=
 =?us-ascii?Q?u7n8ZbkkbqexOO6bg3CkGQKNhxg54te4yotxto2TXrVDX21JvCJjoeWE9Sdm?=
 =?us-ascii?Q?zUAE5o5Kgn8CoyRtnv8kAQxEdx2l78A984/p1KDG4r7ROwuKl9K3sJtNolrs?=
 =?us-ascii?Q?Kn/Mr+CT36UYtkA9CWBN2zn+XNuyfqLNhs5JDzYx+/4is8KjRlfyPUc8jugO?=
 =?us-ascii?Q?49SOPm/3HSe4Vz7cUhRKu0s//BWZYGnfiGUjSei26jsBvHmnZWjWrAKRKjm7?=
 =?us-ascii?Q?FZ+eFH4raHPljVwXlyDFhgzMmg3wvynRy3Z7eUNtSK8kR2XgUZ7/00aVuFsw?=
 =?us-ascii?Q?u881TTEv0wU5DZT+DXeDEeTeFVJ39pI2cpV4v5WIsx0d0gFlSiZ12K/EUQLH?=
 =?us-ascii?Q?HOdF9llgTeYswl15cVrmwNaEQ2ZoTZEM21EfveId+BBfdL7/pmTFKke0UMRT?=
 =?us-ascii?Q?RDLFpPcGmJ4iLZogM4j7vrG+DrdFLrUQ3goHlgRm/cNT3uVeyOWaVPravL9+?=
 =?us-ascii?Q?6jOxHqhBVlKHEdt2V88K0C+yjgNXFVlxEfOr974l5KTIa91J0QNNdOz1VmDI?=
 =?us-ascii?Q?EYmu7OPbnIaiJa7l013LUKqkRAkiQgzBmkZqXXYuwGvpz9Tb5w5NW/EG8m4p?=
 =?us-ascii?Q?REvBdTqgk+wlJQHv7Qiwr4C+1Y+kIJCfDPAu3mmC1dcQJ0PoabnZl8WbAOQu?=
 =?us-ascii?Q?hyPMG/yFvwjNn/cHG6DeN2N/JHKdCSPJk96vyfskVODyY65wVW9cbhw9PrKx?=
 =?us-ascii?Q?vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6rNLtOMzHezS8JZQsThDS5Gei7FF/1eWrTOqHu2SVlMd7B7QFwxxep5oLbNIQPrKj5due5ZkddTdI6Sbu3tQy7de6lKOgUyYE8OkqfwzXUjOfsIo45NoB1IU14rGcEnefe3NOjN9sEMExiXlbNI+DpbHTKOPtLlnki5uXzuWyWozDAHeg5yJ3DPD6wmUNqKfKARyXNR+1DZnQAra7y4BXDrCc9fmorxiZ7//vbgfFQQHQK/WEETWgCJBuRiui367a1Z165VkpDRTVp1s5rm0sBVTGZGe2lcV25KgsHjBQIDzUR/uuKu1e7RXy77iG0qt+eP8E9vbKd+4SzujuppbxeBBb/8WZhOP4gC7u5914cIXOoA2nSxCxzYjw6JEdsofh/O/sYj1m69cRxiYHkiplmFXBqCcJrD7n4yQX9tkN2qhvrabFnulQONJ1saxheARwHdGhHcK1x5phGwOv9clDtZoHIY22qiP3AhavSyQZlLc0iJvFB+P42XoBr7aexgJ2GxGgTVHVEB7K6p7wS6tYUIt0lFY0h7a203PC39aQumL3X7XlezTbjFqH/pE/OyjZJhT9sd9WRPFwLROTOghIt9lKTiPylA50PIxSlUepOw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad664bd3-6579-4ef8-bff2-08dcdd36e2fb
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2024 07:51:38.6582
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: id0ZcGSk5DBvhkCKwNLfpHDNUzM/eAFpZUAwEGptguwYQGoUdv6DOHBKnQpJshOeSypFpxbCm17ZWjgbGLUEL1deFbx4whtnUp9GToMIB/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7589
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-24_02,2024-09-24_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2408220000
 definitions=main-2409250055
X-Proofpoint-ORIG-GUID: agM0QbkiOGgxW96wmVjUhKsRW_ZASNtE
X-Proofpoint-GUID: agM0QbkiOGgxW96wmVjUhKsRW_ZASNtE

On Tue, Sep 24, 2024 at 09:13:52PM GMT, Al Viro wrote:
> On Tue, Sep 24, 2024 at 09:10:23PM +0100, Lorenzo Stoakes wrote:
> > +	if (IS_ERR(mm))
> > +		return PTR_ERR(mm) == -ESRCH ? NULL : mm;
>
> 	Pet peeve: what's wrong with mm == ERR_PTR(-ESRCH)?

Ha, yeah I'm easy either way, though your version is less ugly than mine
(and places the macro/constants together which is clearer) so let's go with
that...

Andrew - fix-patch attached, please apply. Thanks!

----8<----
From cb132b841e8cee09da5428ea625b50df9222a74e Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Wed, 25 Sep 2024 08:48:27 +0100
Subject: [PATCH] procfs: prefer neater pointer error comparison

We can compare a pointer to a known error code via PTR_ERR(ptr) == -EINVAL
or via ptr == ERR_PTR(-EINVAL) - the latter is neater and collects the
macro and constant in one, so refactor to use this form in proc_mem_open().

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/proc/base.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/proc/base.c b/fs/proc/base.c
index fe31decc12b5..94112df5f2a2 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -841,7 +841,7 @@ struct mm_struct *proc_mem_open(struct inode *inode, unsigned int mode)
 	put_task_struct(task);

 	if (IS_ERR(mm))
-		return PTR_ERR(mm) == -ESRCH ? NULL : mm;
+		return mm == ERR_PTR(-ESRCH) ? NULL : mm;

 	/* ensure this mm_struct can't be freed */
 	mmgrab(mm);
--
2.46.0

