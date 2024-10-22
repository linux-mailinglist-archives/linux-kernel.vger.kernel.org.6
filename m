Return-Path: <linux-kernel+bounces-376364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 930539AB05C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 218E01F2336F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 14:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0514A19DF77;
	Tue, 22 Oct 2024 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BWLlsEJ8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oGDJd4P/"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53657139CE9
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 14:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729605867; cv=fail; b=elMzQgbE+5SmgOTu6N+17BWQFHZzpPwV7gESEDhFJvuH2lY9A/xFXrXCCCBPe+UjPBgDT9wwC7c5ip4rWN9F6HGGgus12B21oi4MGOCx6AGmQh71JPLyEbB+tLpyI8iln1O+NWNcCpw/m3PGkfqimS50IWHbNch0ec7dYA9lHFs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729605867; c=relaxed/simple;
	bh=rOc7ZLfK9Gqo50U9Lau7qJw90QuNO9rgN3uncUeU1Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ANMBrmJXdJJ3v9AbwE3wHHK434Uyjd+1intPO0E064sAgYO5CrwWv7GJkiXNv7CnRGk63rjNHcD70WslLZUdsVAzjqC0rttLUHY+n9IWMFiBlPKsE6JQMeOD/XrQ/Gw+ASCCSjYe8xd4fLhAz4w7ZaksOPLhyPqgI7ZkwXHQEP0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BWLlsEJ8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oGDJd4P/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MChdCY017047;
	Tue, 22 Oct 2024 14:03:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Q5GHkW9QcoRS5MnHk7
	NadEEzv2JbirmLB9AKHgnrK9s=; b=BWLlsEJ8R0NXsvs/s5QsI+HDYbfGQdEAdt
	p90FiR4MSx0i1FY+BWhZVVP7qG9/7N48iO1OGTKjFNCj8qE+LhN96dvXHWLr7QCU
	1cYexhPlu+LRTCtmPislB42hqABV/I14JPLKLE8VGIomyQaz2SdmCebleCzZEkD4
	hoIpGwVmT+oQ0t6zWGXPGxQYXdAB6aBLSmSIkLleE/hAohzJwFj/r06v5bAj71h4
	YmX7j2JN2JQsdpmX/TEDWpUgJnTJQohNOELcHsHgrjbaWGxGkfa0pKaMo8JHMipr
	KXETzEXXFhIpYtsdaykmiA+cXrEUjNM9Jubdl11w3hUNVkWovU7w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5asdnvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 14:03:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49MDY5u9012296;
	Tue, 22 Oct 2024 14:03:46 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2046.outbound.protection.outlook.com [104.47.74.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c377gs77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 14:03:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VnsaPpnYGSAcwNXVos0dwNLfpTUORimHqr3vP0ytcUH4vaTP5YuJnsF/Cis3qsuMVkU2pMf5KgXLXEcOKDjQwFD6U3mVTmMFjA41I4Qcw3LSSfO9Md/wi+CccHmHwtmeV4HwvWz7LunKV4qWvkHoCu051dgzN2xsWAN+QLruuh6eR2xzgnsrHZbsMl5Q0VdpMn4RzmL4QYReu8hlq+lYorSj4D9djO2hS+6oWw6YDKXSn0YOYv3r491OGXSbjrcBqN89sFQo41vV1FQb77w/sv1ypY78tDoHbaWXdaAOR9Z5oHsW0bFONr1v9FvSGewh7FEaX6ROu1z/qbYEGSp+9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q5GHkW9QcoRS5MnHk7NadEEzv2JbirmLB9AKHgnrK9s=;
 b=f83nvF1QLN4H1EhwEmr83O1Q5dKwqUc8V5Y+R46iI+weViMBoEzSDVqoZIrSAUq42yZJlX0QUjegtpNT0BMWdR4b0HlF0B+543Erm58BqrK44cXQoUaMViiNWZSGznJmPvOjQC/yo/puVGdEixXmZbE1zrtBBYD7yQ7ohc1L2a0NoKNIXS9Y1dHxAtdweyyF0YjWJKYeaU0YHhxQcLPMuFFdzukk9dag/Zbff6DBJ7HvLCiyJjn555aDaoee/FjvU807En4cEuC2a6ddbRl2begNjItXFvF7BNapiGctd/fGsEsXnsdaf23g4qc4/lV90TEdhAPOMe9t3IVdKLCR3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q5GHkW9QcoRS5MnHk7NadEEzv2JbirmLB9AKHgnrK9s=;
 b=oGDJd4P/yt4coEdth+9hjaNaSPu6v2Ch3MPMzHcgQdVVWoGaSlE5N0z4SIawlalLGAhazQjfz2tE6K8iQtwGdyFX+nTHpz/r6AB8B7aOqSzkqcuz+FdbwMUgPE6RnMwIlQHjmIo021wHifBwXCiB+db500uYY6Yy6RJx+Q92fZQ=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SJ0PR10MB4413.namprd10.prod.outlook.com (2603:10b6:a03:2d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Tue, 22 Oct
 2024 14:03:43 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8069.024; Tue, 22 Oct 2024
 14:03:40 +0000
Date: Tue, 22 Oct 2024 15:03:36 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tools: testing: fix phys_addr_t size on 64-bit systems
Message-ID: <a6183df9-3108-4d59-8128-4fc6c14e22a5@lucifer.local>
References: <20241017165638.95602-1-lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241017165638.95602-1-lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: LO6P123CA0020.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:313::8) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SJ0PR10MB4413:EE_
X-MS-Office365-Filtering-Correlation-Id: 521e0b7c-c762-4d67-1918-08dcf2a254ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|10070799003|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cPyjbowBgOWjksFGjTqpk4PmpoDfrUmGNNTMjjSx4bVShl36rlhCnp7Z1Tt2?=
 =?us-ascii?Q?alfdKK62b4R+7yJLfLdUVuyx4nyMsFzb5PGBM+OhtudGObINb0Hf1gElTupL?=
 =?us-ascii?Q?k3dveQKeA7T/Lwv2HFjz+LLeS6iAoUu1Tfdsr5IqiTzklFYo4eSmicfetKtp?=
 =?us-ascii?Q?UAZeNUOnIjLyHUkPfw7dFu2KT0C76Y0wjn/GgpUwAbuQO4ImQxpcJWckP+gG?=
 =?us-ascii?Q?WV3IuBimZw9DtGOq29Q+ztzGAEpCJd8VowP8u2Ap3MN6plX0XNBNPFQVThwp?=
 =?us-ascii?Q?hDv0I03hf9b8G1qKRq6UgQm3RM9WJg1Dr2zdPpTCZVM6+3mFAIj1ABauDAWC?=
 =?us-ascii?Q?gOGlDGxdi1Xc1j4MQ5/w93qp3XsQlNDH7ahmkgc+0uSeKh13whZcT0cvPR1s?=
 =?us-ascii?Q?riop/Wy2nl02VWIZfv/Y29YNY3H92pvEJ2J2V/h5pw+i7N1LDc8wG8Xl0THv?=
 =?us-ascii?Q?LXWwVtb8NzTPjgJ5shmMVf5kDDo9hHQM0kWn3YaJAfkoxLUb1M+wpAPBdRsc?=
 =?us-ascii?Q?8J3YHKUqj2bPb5oDdXqzk5dIjT2e7Hc/JKKY22XXMhIIH5U99iB7ZORA+PkM?=
 =?us-ascii?Q?1S4thNZ7vSG0VL9A66KjAXt8r0F6yd0oYEJp1BVQXOrSsN5u5Qbf/OCrjhyF?=
 =?us-ascii?Q?fbh1zJ+vP0vPlH6JWXjQR5B7g7tuxZfhRgIb3yOv0T675+SQNzlDAkMZeM5d?=
 =?us-ascii?Q?Oag4A/bc0h9yLRqrBuf8WabMgn14Qc471nSMHj70+00cyAThXuuHPJCcmmmL?=
 =?us-ascii?Q?uVxdujmmZcJrYlKdn/B/tPxoTbkZJnuRowD9aZO04Sc1nocLnPG3WpgVRzqm?=
 =?us-ascii?Q?w6/sUiTMQtg8+Ac6yySDKhk+yVC9VtKx4b2Z9Z0Fj/ZHB1sYkgVt1jpJzmVp?=
 =?us-ascii?Q?8KFCq713eC3Q2N529DctcHti2SV6QpP4542Cxd1vxfi+7C5H4VIv7jHhr2/T?=
 =?us-ascii?Q?GP/L76FCiy5+itTW8oii1QfCz0f85c7EHY0PiyFYHrJQvxOIFo8E1K54v0Jd?=
 =?us-ascii?Q?qbNZWdXcSB5C3/v1WtJNsIJagGdKHnO5XuBH/Px1Tasa7A0LGCMKA4Tt4JYM?=
 =?us-ascii?Q?tFdMFhMIX8voCqTipy2DbtcCsVHdlNJu/hoGlnU5OqSDoqUlvWLw6LF9XWcH?=
 =?us-ascii?Q?zPf7vX+3zGf6ji+HpkwdBu2CIPYDi2NZYIec8zjesDITvkI5HTxRDuNVw3kt?=
 =?us-ascii?Q?7jq0rzBntQFMfFy5WHKuC3k9f8rfY6G5DeLjf60PaDGmmD6TyzVrI/mjWsOG?=
 =?us-ascii?Q?Ucfz9d7khbGPUt+mYch0EUs0k+ajOyNEqVxd6EgRyEkLqLiaQDYVdLvZD2G1?=
 =?us-ascii?Q?jjHILvUND+iBUQXI+w4YaxpR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(10070799003)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7MCBU25YDHQDZ+u6dG/OFy4xXPkjcgg9ygwgw6+1zqLAal11r0l7DVlJ/yf9?=
 =?us-ascii?Q?ANSX0s7IOV6G7DZKat39VvDv+WPTF72Z3TVrsL1OuV1rA091rzUaRcDFYhlU?=
 =?us-ascii?Q?hzrn8cZOhVZWg3LWufVCaxRf408Z5+b2Rfr8mQow/Mx4t0uGhhaZtWD4grCA?=
 =?us-ascii?Q?gUOtMnouuXubyulWRufJI3CGJHcC5mjMzTYyrKviPAGgP+icCcNt9PWvsM0C?=
 =?us-ascii?Q?1zhZ1p3xVPQb64OB74Cn9n5k2Ec9at+3w8rlFFlIZMVWoe03s5NIHEISVEw2?=
 =?us-ascii?Q?eyjjFE14TJLL1WAg/xE0ZlKE0Q12MG3jonbOi0BM5JaLpvJnl+LX7rpVroQL?=
 =?us-ascii?Q?ptNOAItg7gIKWVyEiR5nWD8IuflXStNJF3n2WqKiAwCpx8pOSDH4A733/Hr3?=
 =?us-ascii?Q?Q0wvaFwSfivhvsNNE/yNV8KqigSHia+SSPijIgwLo3mAJn2Wym1qGfgvQEpL?=
 =?us-ascii?Q?2YLQEPs4vU3VXMaaX6L2cv4uokJWCn3D+N5QXfLijeYHBY3UXR0Z5r/Kss3R?=
 =?us-ascii?Q?yfNmzVnGfQ8ech+bI1hkzU2DndNJqebTfHU6OudyOVJm364Kh2V0tNt/FW8S?=
 =?us-ascii?Q?fAe1TPhGRw+ifu4fIw4BRfzYivhFxi9hInhwj7jzWlMLs2owiVA2Y17kQjLO?=
 =?us-ascii?Q?qV6CjHUkc+PABvJ3ru70jA8R2VWX30KomNK9dsMCLiETqn2ZRqBqVG07fWG+?=
 =?us-ascii?Q?7RjXVlKu7+1IyJlxGDKVd19zJ3YIGknvtLq5D1kxU9a8JPBXCWhPdKzIddZK?=
 =?us-ascii?Q?VDqOWW5T5KteL92T4LUVzBLjR2X5yzSfPEfpM0yFgdy/pORVmkXjf2v6Jrbs?=
 =?us-ascii?Q?G/kfYsPlbGymLnMnndQS3wXvvEh9Fm5q/8kB7ojpDpV9ygXOhLmD78CJI5bx?=
 =?us-ascii?Q?d9SjMy8RU47+ENjL7+R8hz24Sz0yzapwjPAc02DWfyxaB0okRB14W4lQvaIH?=
 =?us-ascii?Q?bmsQWGfPN0Tgz/XT8Nwn2B98EVpxJ104v2JHrlSXLpGg7wTmaQIry8/3T+Oh?=
 =?us-ascii?Q?cACX8hoyBflkdG7XXxTH3Tc3OQcb5QxOzLSHWv0J5KxrIQqTGtl8YilP9ks9?=
 =?us-ascii?Q?jgYe0GEnZm21OkUOL64MTLTf38evP5MrMcJMOK1BuCP9qwwluDncIydMgjY3?=
 =?us-ascii?Q?z4Wofa6CONmfNf+hkIeCTY83srQRJOeQQ2aD0ZnRpI599YXMSZteDtnv5Prh?=
 =?us-ascii?Q?t2n/rFYYL+zWHYo0ftQER891XeUJQJEUJXItloWWuEWKurNnaz+GMrbWegIc?=
 =?us-ascii?Q?pJW6bNYiBE94NSLbTIhqqNIXdSbDrDScIeSWRwb/drO73uGNpKwkqqFq6DGC?=
 =?us-ascii?Q?7i+2BRjoSNE7fxEEek+6XdOr8A3z0UIkQnASJ2dbvn8TtGW4iZGXrEf/w1u4?=
 =?us-ascii?Q?DlMhLZ6XuZ6+SySD5JuEBolPTcOM6wFAcddMtZJF0J5rM+/vIPrwy+N8Rryz?=
 =?us-ascii?Q?uWKjSpCAYTjmlwNr9xPa5k2SDtPINyGmO9y5psK8NpnsNUMTpyDwgvXJnFCd?=
 =?us-ascii?Q?N1QdYrSCfDyliPBUrn1bJ3WMOKZepVD+s8XEcOoYwEOKz4APQ75Yf3AmtWUx?=
 =?us-ascii?Q?hjJ93mQPQt3K9yAGI3W7PPqDryMp6e8mDI91sBWpSwUy/euwKgCktyT997hV?=
 =?us-ascii?Q?OxAWbVx+BSrB2e+2fuJlWy4f5fepzYnPax1WNz5eyLgD5b593HJnXw78UbeI?=
 =?us-ascii?Q?AxzGDA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vpHfnwXah1qZP+Ycp8GyMXGKHiefraFFR6y0TMlBD2hyc+XKQscm7+SF6ZsqH0kmynSCqyozOt220qKPllQ8Z4r7gpX2qrOJrDs7JWFBR58D73xVGt5l/0rJW1H2PqZtps3JAwwALLZkYSODYC46tQnTc0xozcXS0lJMsjHgIHq10nakK2zul0YN3leg4TzOlHCU8a3VmcOakpcyRTuJRB3K3hyGNGT3L3vHwHRv6f+08ttYltAOw8p9aARSJfqmAf7mBzeFnKVZ7itrvbKiz8aXWMt5P7q/jJSy/SdUDQvqsdMHpGQn7EKuhcEsBzu3wz54yOBFK63F6EbbtlPJ9howZ1UiIsxiNkG5x4hIZymp9KCz1DfEwtt00lHb8ug/6vbaXDqtLFz49Ll0qb8FAaRL23uKXzheb+wRTJFFLkdzWh8Vuk7hGiYzDOACyIVYf4SAeFTL5sBKIpPL+jHEHDIwvCRtul1RbiBSIKSEa3DjPBU7FQq9m9i+uMWMiZoGch52LjoXSi7jSATP1hw9a6McrT+vVYoOBHJ4khiA/4xRM0Vx8QPfPx/+qCURaRk2unpVudTORq3pnr659QgtPzWmmSXJDdPQrWjA8ppmLG4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 521e0b7c-c762-4d67-1918-08dcf2a254ae
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2024 14:03:40.3537
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QjoGrWPo1N0kbR4e67LytFpc7gwLA9908GScGIMEBpqjEdNQdE7ekRiExZ1wgpZWfdrNn8vZO1j5yGRGnbdU7MRywJxTbf5oyVzz9FNyf3w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4413
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-22_14,2024-10-22_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410220090
X-Proofpoint-GUID: cDlVN5njH8Xh5_mRqVWIC01gxc8CTwWR
X-Proofpoint-ORIG-GUID: cDlVN5njH8Xh5_mRqVWIC01gxc8CTwWR

On Thu, Oct 17, 2024 at 05:56:38PM +0100, Lorenzo Stoakes wrote:
> The phys_addr_t size is predicated on whether CONFIG_PHYS_ADDR_T_64BIT is
> set or not.
>
> In the VMA tests, virt_to_phys() from tools/include/linux casts a volatile
> void * pointer to phys_addr_t, if CONFIG_PHYS_ADDR_T_64BIT is not set, this
> will be 32-bit and trigger a warning.
>
> Obviously this might also lead to truncation, which we would rather avoid.
>
> Fix this by adjusting the generation of generated/bit-length.h to generate
> a CONFIG_PHYS_ADDR_T{bits}BIT define.
>
> This does result in the generation of the useless CONFIG_PHYS_ADDR_T_32BIT
> define for 32-bit systems, but this should have no effect, and makes
> implementation of this easier.
>
> This resolves the issue and the warning.
>
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  tools/testing/shared/shared.mk | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/testing/shared/shared.mk b/tools/testing/shared/shared.mk
> index a6bc51d0b0bf..b37362224a73 100644
> --- a/tools/testing/shared/shared.mk
> +++ b/tools/testing/shared/shared.mk
> @@ -69,6 +69,7 @@ generated/bit-length.h: FORCE
>  	@if ! grep -qws CONFIG_$(LONG_BIT)BIT generated/bit-length.h; then   \
>  		echo "Generating $@";                                        \
>  		echo "#define CONFIG_$(LONG_BIT)BIT 1" > $@;                 \
> +		echo "#define CONFIG_PHYS_ADDR_T_$(LONG_BIT)BIT 1" > $@;     \
>  	fi
>
>  FORCE: ;
> --
> 2.46.2
>

Andrew - apologies, I made a mistake here, VMA tests are not properly
importing the bit-length.h header (the radix tree tests do appear to be)
and we are overwriting that constant (ahem)...

Could you apply the following fix-patch? Thanks!

----8<----
From 92c247fe99b57f14b91c5e7479cb29616f0c8281 Mon Sep 17 00:00:00 2001
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Date: Tue, 22 Oct 2024 15:01:58 +0100
Subject: [PATCH] correctly set bit length in VMA and radix tree tests

---
 tools/testing/shared/shared.mk | 2 +-
 tools/testing/vma/vma.c        | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/shared/shared.mk b/tools/testing/shared/shared.mk
index b37362224a73..923ee2492256 100644
--- a/tools/testing/shared/shared.mk
+++ b/tools/testing/shared/shared.mk
@@ -69,7 +69,7 @@ generated/bit-length.h: FORCE
 	@if ! grep -qws CONFIG_$(LONG_BIT)BIT generated/bit-length.h; then   \
 		echo "Generating $@";                                        \
 		echo "#define CONFIG_$(LONG_BIT)BIT 1" > $@;                 \
-		echo "#define CONFIG_PHYS_ADDR_T_$(LONG_BIT)BIT 1" > $@;     \
+		echo "#define CONFIG_PHYS_ADDR_T_$(LONG_BIT)BIT 1" >> $@;    \
 	fi

 FORCE: ;
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index b33b47342d41..8fab5e13c7c3 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -4,6 +4,8 @@
 #include <stdio.h>
 #include <stdlib.h>

+#include "generated/bit-length.h"
+
 #include "maple-shared.h"
 #include "vma_internal.h"

--
2.47.0

