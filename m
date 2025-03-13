Return-Path: <linux-kernel+bounces-558749-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE8FEA5EA85
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 05:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53F643B9159
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 04:23:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D042126BF1;
	Thu, 13 Mar 2025 04:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CEJyg53D"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2080.outbound.protection.outlook.com [40.107.100.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53CE78F37
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 04:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741839799; cv=fail; b=jdGqoUIX7ZnvlfMFqFCWb5ssRfwW/MdTH0U0b/3N3iqhpVr48bMHWH2wFaIybmHif2vXEe34/Eg9WR7RMzpZ4P2mhpdeSi/NcNpal5WS0+n7ZIP7jp+zXlsn4bXZvOFm0zc4hg681slOTgHhz7BFAxLEyYYes+k7a+1SULxy+go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741839799; c=relaxed/simple;
	bh=CKXXs//ExH3YV2RYd91qLELREPgpaYutCXZouSiDe8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=kOLasI/SY5m+hxovdDaybh0gtKbcWirIcxbvqe+tzX/Sndl3bPNpHJ0MB7uzaclJ2duwHv87IDUKkp8sD1kveGHKYo0gdeN1i2vR+QZAGk8ghjNajo1ze2tZpVPg/R4nSHkBIuREAqDcd5A8KIXS91LiR2t3bByAz/9B3xz0P/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=CEJyg53D; arc=fail smtp.client-ip=40.107.100.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rOsGvGdipZ+m57ffKYbdJ8jAzu19+Vl/qmY8vLbWwY7h6DV+F3mOb5F5BDdEraedFBQlWedRbXkgyBcdlnoGOxmb3Wsyrln2ct7ERyvK2ZcosjS1+T8yDpRZOkA7NCSrifkqtqIH4nHwWG3Kmd/mHEPAaveRGD/2hXtvv1aNcxbo42SXh5m7d/XoqIvhFMOPjO7+FYTbi4q+326D8uN6TSNnw5HIQcktPMNLm2Lkt00D+0ui2eXGnSXJEhwJiSQA/C7cR1/CNbfZgSr06PUPvqrwdR+0bmE2ZNYduOvzyHuL1KO2CSzfr3JIKb9/QgGqzFIOYBUV7u7wVRT2/4k2Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TE6kwcSaKePCEY5BlnNE2wi5hPaLeoIEkuEIavGkELk=;
 b=Rb1G+CIrcv1+X11w3Fz9pLA8KXKJWtS2vRLdFv+Q7boKUz9vdNJEYdJpgmFUmaMgqDKVOJ+Eu7nbij0J1fzinPnOhn/mSiFmuGZwpV8raeOcxowAUGZ1aLZomAMQOq1rd/3+DSEaSLumJQB64xj+bSrTPXGTj0Q85bLO6kEcQUeNg1wDvaktZmT4HTRAWJY2WP3oWtALq1SizXgb7Zile4YuCMZnO1o0z3q2ZshCAs8PNanprcnwZn3b3xRVux/43ODzcAsae+nfEY+57t41xZSyxSJV0v8LHYGOIAQO/ku1cCnK38tKy9LO96T9yHjMgUhQka9g5Iju/M742lxXmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TE6kwcSaKePCEY5BlnNE2wi5hPaLeoIEkuEIavGkELk=;
 b=CEJyg53DoDM4C3YVCGq6PYdaDMDDCAw6preZDZoX/sQaTWY9ldsKtvXVHdLUIcoaU1pdndrDphcSqTvQoozWL9nFlWheUeo5p4AuJAGl7OWf9ZqlumMIs6rNfCrIaAPboKZ9UegbGdcpgWi9odEvwOczr5VowBWZclSqBi/7Nk+5hpd+Czc77Eeku65XZvVDCCpHTknfoZNXQfsweW2VlpudM1Ds9YodvejAUG/DDjWt1Xk1tyK5oFYRiOViiD+D3cjUSkTgQhkY6qkeOj0DWDeHdXny3BK0X9ILtCBPIiVSKEAw4aNpygSCQ1hd6tTD2/+qtZ/YwQZK0BuSTunMEg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN7PR12MB8059.namprd12.prod.outlook.com (2603:10b6:806:32b::7)
 by CH3PR12MB9170.namprd12.prod.outlook.com (2603:10b6:610:199::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 04:23:15 +0000
Received: from SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91]) by SN7PR12MB8059.namprd12.prod.outlook.com
 ([fe80::4ee2:654e:1fe8:4b91%4]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 04:23:13 +0000
Date: Thu, 13 Mar 2025 00:23:11 -0400
From: Joel Fernandes <joelagnelf@nvidia.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org,
	=?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
	Darren Hart <dvhart@infradead.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Waiman Long <longman@redhat.com>
Subject: Re: [PATCH v10 01/21] rcuref: Provide rcuref_is_dead().
Message-ID: <20250313042311.GA1395318@joelnvbox>
References: <20250312151634.2183278-1-bigeasy@linutronix.de>
 <20250312151634.2183278-2-bigeasy@linutronix.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312151634.2183278-2-bigeasy@linutronix.de>
X-ClientProxiedBy: BN9PR03CA0673.namprd03.prod.outlook.com
 (2603:10b6:408:10e::18) To SN7PR12MB8059.namprd12.prod.outlook.com
 (2603:10b6:806:32b::7)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR12MB8059:EE_|CH3PR12MB9170:EE_
X-MS-Office365-Filtering-Correlation-Id: c1d193dd-7707-438e-6a5c-08dd61e6c514
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Wrh3nqVJ5YoUVIVWu7gEhEoOyV8vXJGReSPs2oprXZgd4OW5HD2lPKacAUvr?=
 =?us-ascii?Q?w1jzkuwjFAPJ3c+cHtxQFG2L3tsfW46H7HKmXSBCaFdCtu1xi6F2zeNxrl6s?=
 =?us-ascii?Q?2PSD8Tj8J1F5es9hY86Kf996PTtU+YZvbEHlRJpGUywBBMfwxiVwqsGiG5QH?=
 =?us-ascii?Q?NYSU/iaypXT4tcVaBm2Dj4jqW5Q9C3xd0hCoRX/fkT+D73nRhh3eGA+BTqSt?=
 =?us-ascii?Q?4EkTVpzvwchG0ZTlE9wrWHyCXC9no/ewtY5poZZtCQaQiEggswbp5P7jqTkP?=
 =?us-ascii?Q?6QnifQNNzU9RcvBZ2yyjSHUHJRCRYXeT2IpRo1pJFAu5xutwbRAbHdAvScZJ?=
 =?us-ascii?Q?M0z2xuWNI/IagnbL+F5OxyhS4zdjnWyxR0eAOnR5fXfx7vHAj6kQZasGNZxH?=
 =?us-ascii?Q?gthVj6wLCy/k1tTGxxo0X+pRy8m5MniE33JAVlHDpBpQVRcblnzpgu9e7A2A?=
 =?us-ascii?Q?cdQJC6zu+yvs/pTjmYfz/CDyEPlPWZpMjcZxL53doBAtsDYnzsqiIQN7F6jM?=
 =?us-ascii?Q?5oZIJTJini6Lx9mS1B/p9rvvBsyXhjP8dpimH0etlo7QJQW/DmKX29o8aZWy?=
 =?us-ascii?Q?KdAgk0Ns+X88WMqWzNlOAanQVz7E5he3UplW2USVPrBzOagsS6B/P7k1/TS+?=
 =?us-ascii?Q?Cr7rGkDzJZ7SG4BSDz8IHtiuvobywLkH4QdqNNMm/3pykLktljbhskpbi+T8?=
 =?us-ascii?Q?E0PRxi1t/cavuiQY13668RyKY2vo13XnDVICFrLPu4BcTq9V58fys9KgMvOM?=
 =?us-ascii?Q?2iKxz+PdR9QrBZlw3BmPdMB52C+BYsTN8gBlJTqo1LO26yhrYDHYCt2X5Q1i?=
 =?us-ascii?Q?krXSnfyp2IQ18CDfbmJwk+uWqj2uTQ32uRp0D21z1iX81PsP8ET+QAuK+Ay8?=
 =?us-ascii?Q?lqGSmEh3TE0FLWq0EsGSnBIfbydkhQ7brJXNQvyoRLGDlCzonQ0yKr3w/Twz?=
 =?us-ascii?Q?meT9ZAC2NKnzSP5Ile2bk/ZmhFdauw/WnZp1Qd7DVJiOEocrPgsngoyVypot?=
 =?us-ascii?Q?SzNyjUwrwKZDtd/RQR0Jq9YywBu1GrmfCyYlDPVZst6nzrY2ySns4JUv6ovY?=
 =?us-ascii?Q?zkm5gGluSPHz6RylQdp5fDbMZNa+1BpQ9WCgCxSJjcvvrRJCpXUZRiLfC2Y2?=
 =?us-ascii?Q?biKYnc+VqslZN10kqnCuzFj8BX1mEGvAuApAZWdJKV6RFXueHnVMh0xOTrw/?=
 =?us-ascii?Q?qWqa5XfI0QqNS5ltCDNHxFaHbX6cQ+JgbIgkZlGWd/sMwhz2uS+n7Gb8zacv?=
 =?us-ascii?Q?3Y02Gs/v3CmDHneYGMSqZ3wodkFDOJSlim/VuLbI/e5q57ybiaNg4elmx7lD?=
 =?us-ascii?Q?xForCUldI0vpAxKwhEBsGxbdb19koCsr+uiIlHnkxr+EfpXQDUkBiNiexhZj?=
 =?us-ascii?Q?wVHuf8v74RZ48TdIcJGJObCH4O6y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR12MB8059.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8P8vtLXFAOdnWqMiT2nqhTR+xLZrGpg7CV3nTssihDUyfzoyKS+EbiF9dP/V?=
 =?us-ascii?Q?ZY+OV6/SjlSFEujyDU7qRlTzyLzXsBaAI4oiZDf7saMT4dBi8OOcNyvHLusf?=
 =?us-ascii?Q?w6AQ1iSfEe99i7I30cyrV6exykVXz45qtzPWXeMg/YkfBmztLlYIUrJUYhob?=
 =?us-ascii?Q?vn3faefoKkbslgvfnugV30eYgpBkdz4YLiIUlYtTFb7z2t2dH3ZQR+Q8j1cE?=
 =?us-ascii?Q?rY+c++EhWHN/zaAeDBQOWz3yPc3KUI5553STXo4+m0zTK6LAX0nftBqqrV+/?=
 =?us-ascii?Q?HYPwSyM6Y/ZwcJCQKB/PIHwHPbe2Zl0ZMBa9EbWB9aHt7RxEATFiUaNT0wNi?=
 =?us-ascii?Q?P3WzP6XcQk3GSbPbttxQrnT4glOqryY6uUxfM3V4v5bYFu4/10zDYnAH0JNZ?=
 =?us-ascii?Q?HRI+OU0tuCmYk2cXizrPvQ0pXLSiHSL0Rl4joeJcr16a7JevitaGZMDYUXqU?=
 =?us-ascii?Q?5DzAK5tit+2cgPJf9avShTAx8EYJZKnV6FXqxW5TU6HrR7+qWrwkgGNi/ha/?=
 =?us-ascii?Q?vXqz0z6ChDvZslC1gq7e6jYxQYCFmE76HfnLcT5U/fJ0DL+vIGUicVYc1Ur3?=
 =?us-ascii?Q?0TVd2HTXyIvhd8nb/xgwomWBVH33nNIyXiFXWGqr/QHU4Q3U/lSoOtWkJZ1c?=
 =?us-ascii?Q?fKIZkSvJWTTKI77Ri8oacBxVh/KwMau8JHywZ5dBhiGOPUXBeGHU4RskOI3X?=
 =?us-ascii?Q?pCo/yPajT/j7pQPk3+gcyDaMo+vOpBBTb3BPx25+6RZ2Ue8ltX3NgRzec5sG?=
 =?us-ascii?Q?rXsaNCRDUvcdm9pAKvPVnNRudnDnx5/EhAR+y41BtqtXGzmMa27sYqaltbyk?=
 =?us-ascii?Q?ca27lnIX2+8nS5fC7YUpUWWYHFZmsavGOTId5By1+fzw7jwwNRSmIMGTXVgl?=
 =?us-ascii?Q?hCIjHbTx6wM9TU39oKEkoTBMnqxiakDP1kbtMVWCmFqlHuA23Cvq/NvAPwzw?=
 =?us-ascii?Q?l4MAKy4Ax3Eq4cPVzQJXz9fHsI6jqk0Kqxrb7X2rPI92eHZA2VCV36pK35wp?=
 =?us-ascii?Q?0J8En2LzsmIB7TxBD/FMLQtmulnWNB/0S5KDA4nGF/cQYvzEXPKw96snQqxX?=
 =?us-ascii?Q?EKFmymILRnsrkJGrnVYWm5EwsInP52mI4562JgYKycsPFCmb16fpuO7+mNVv?=
 =?us-ascii?Q?MonddPCaQFNLOm7x+LHLd3AfkbNEqkDaTnKtsd3LNwywoXC/nRyHEUmYTLrt?=
 =?us-ascii?Q?RMYl2QqhPsaRcSg6jkCq8KSOSEGHA3skaj1XK3OXwukafVlTwrnWmTO6uTFB?=
 =?us-ascii?Q?hE44PRM0ucqLlgdOgrqnvUV8WUJXiQKlxzGJw4btlhn423uDKy7UpBeznSN1?=
 =?us-ascii?Q?P9z0+VoFL2yb8aDSsI2bY3tQXIpL/SCCUqjnYkcwde+1D+DbwqGReOyTrOMS?=
 =?us-ascii?Q?DWoCs9J/XghZBNnvgdvzy/umF4Wgyx+HlZsCFtOh25s0mVFuD012k6bB6VY3?=
 =?us-ascii?Q?P/o/6FjJ6rsOyv7mJzdXBz0VLAEPENZWOBXKtV3R3FwavliBpiSb18yCCQ5j?=
 =?us-ascii?Q?GYjMmTrnWu3UZX4tAS7ogDMXxVTVSS3m7u8+1Yn6DKz7JK3lyEGGz4DX3OVQ?=
 =?us-ascii?Q?4TWuoXXqhHuhFM+yl39YlFWpCak5ZGgbOUYAXpSL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1d193dd-7707-438e-6a5c-08dd61e6c514
X-MS-Exchange-CrossTenant-AuthSource: SN7PR12MB8059.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 04:23:13.4638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: P8QuUjlh9R5Ih2XxpJf6S4YmhdVSl4lcphfr1evQ5IHFJ3tF0k25CbUfVF/tfKMFysEBfWexz106ox8KKFEkYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9170

On Wed, Mar 12, 2025 at 04:16:14PM +0100, Sebastian Andrzej Siewior wrote:
> rcuref_read() returns the number of references that are currently held.
> If 0 is returned then it is not safe to assume that the object ca be
> scheduled for deconstruction because it is marked DEAD. This happens if
> the return value of rcuref_put() is ignored and assumptions are made.
> 
> If 0 is returned then the counter transitioned from 0 to RCUREF_NOREF.
> If rcuref_put() did not return to the caller then the counter did not
> yet transition from RCUREF_NOREF to RCUREF_DEAD. This means that there
> is still a chance that the counter counter will transition from
> RCUREF_NOREF to 0 meaning it is still valid and must not be
> deconstructed. In this brief window rcuref_read() will return 0.
> 
> Provide rcuref_is_dead() to determine if the counter is marked as
> RCUREF_DEAD.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  include/linux/rcuref.h | 22 +++++++++++++++++++++-
>  1 file changed, 21 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/rcuref.h b/include/linux/rcuref.h
> index 6322d8c1c6b42..2fb2af6d98249 100644
> --- a/include/linux/rcuref.h
> +++ b/include/linux/rcuref.h
> @@ -30,7 +30,11 @@ static inline void rcuref_init(rcuref_t *ref, unsigned int cnt)
>   * rcuref_read - Read the number of held reference counts of a rcuref
>   * @ref:	Pointer to the reference count
>   *
> - * Return: The number of held references (0 ... N)
> + * Return: The number of held references (0 ... N). The value 0 does not
> + * indicate that it is safe to schedule the object, protected by this reference
> + * counter, for deconstruction.
> + * If you want to know if the reference counter has been marked DEAD (as
> + * signaled by rcuref_put()) please use rcuread_is_dead().
>   */
>  static inline unsigned int rcuref_read(rcuref_t *ref)
>  {
> @@ -40,6 +44,22 @@ static inline unsigned int rcuref_read(rcuref_t *ref)
>  	return c >= RCUREF_RELEASED ? 0 : c + 1;
>  }
>  
> +/**
> + * rcuref_is_dead -	Check if the rcuref has been already marked dead
> + * @ref:		Pointer to the reference count
> + *
> + * Return: True if the object has been marked DEAD. This signals that a previous
> + * invocation of rcuref_put() returned true on this reference counter meaning
> + * the protected object can safely be scheduled for deconstruction.
> + * Otherwise, returns false.
> + */
> +static inline bool rcuref_is_dead(rcuref_t *ref)
> +{
> +	unsigned int c = atomic_read(&ref->refcnt);
> +
> +	return (c >= RCUREF_RELEASED) && (c < RCUREF_NOREF);
> +}
> +
>  extern __must_check bool rcuref_get_slowpath(rcuref_t *ref);
>  

This makes sense to me, another way I guess to determine if it is dead is
actually to do a get() and see if it fails? Though that would be more
expensive and silly.

FWIW for this patch,
Reviewed-by: Joel Fernandes <joelagnelf@nvidia.com>

thanks,

 - Joel


