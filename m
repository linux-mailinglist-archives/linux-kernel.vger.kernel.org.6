Return-Path: <linux-kernel+bounces-402270-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B069C25A8
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3AAE428389E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 366481AA1EF;
	Fri,  8 Nov 2024 19:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BMpd6yG6"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B35EE17A5BE
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 19:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731094777; cv=fail; b=KBv8r3xk62d0vNQVOTHnR69LSOhQ0RUnXK+CL/UKRa+tPfmy13xFIVF2zxFqnVftbqoodM4UqvkZG/7Xfwuz1td8btYw1gdg3oBJ8Uf2pJ5Lx1VCYUoBxao9Ayepe2cPODT+9ezPOBPfGjWIOaDGLUI14SPGzlImOnG0dxROhuY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731094777; c=relaxed/simple;
	bh=6S4+npsBu+2NtcbstLGFUCYHPlAZm6Px+v2dhBr46Mg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=BloElm3sJX3O5s5D8obAcwJvZTPuTPoK1Peizs0FnZ5+viwkivKslAwCrX1jf8cpTUmd88LysxycFFiu0nbxMA58NTwc7M8y5RM9AEPun42hEsvQr4TbnGu5XKfWOuPIXGLDM6o+eakelHgNXOFVXJBMpYALPbZGvMfj2WS5SMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BMpd6yG6; arc=fail smtp.client-ip=40.107.100.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tt0p+Se1gHANDjUBIwPEA6Bem3fekCRE4AAqsygNz2yimM9SCSLCom/64FPM4LD7msu0DwpBZI1W5WlveNyL/+C9HadUII2mqmjrc/MZjFz8VdARell7jnVOqDXiWAOQ0kBY7fGM2+nL5baBRP2ZgDlf6zpBYdnU70nxANN2mipVu2k02q8xeeznZ5dT1XTsGRbUgeKJPAzXcs36FbZhl4x7pr8zQysC/Nayp8Ep+BuE2IFQHlMqEFkyPzC4pygbkfJsPDVSxUNBB55FuJh4bwNXG2fM5kvTQkZ6AVHeHWCQPdrs/XteUGHToj7rCa9pM4zZKueaK9tcwMF+yEfwBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7JQoF1JCJ3j4icAhP2BhJroWyXEeKuPO8AgNoMk8yhs=;
 b=rihydJDWEMTz7Wo3Ex2Lt8XBeRrCsDW4CX9XmWZrYirFjnS73AFCrvvwZePu+Ts3mJE5KZtCMCMrSO9IGkOKuaHHRo6LWhiPr8fW4G0yLgiMHnYbMED6NIY2dTDwAVG94vJeX4llc8AyP/pzbvpbthei9+7Fjk/PpJe4+cgEjgvXo1CXKnDR527wd8OX/hbMnHvVRgYUtp8VHlq0jgB7W2hfaSNUNioxp0IUgJpz0cFwl5CR2yaofm4apyrI43nLKrN/zft0mdpB81qDsNZKhW2IBtH4E3Atc7tqE2el/VcxcfSrYFCKF2qFwp433Ih/NUQ8sEcKn1IaP4OSryxkJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7JQoF1JCJ3j4icAhP2BhJroWyXEeKuPO8AgNoMk8yhs=;
 b=BMpd6yG6HV/gPc8JYfem94aLn0vWAKsirU9qUOAmkkNdILnyh2VZgNosAhDS55LVVV7QqQeQHi8PI4PQEEBSL7/qke5xNNMUJ3JEcpRD0nK2qygQwbVRZCg2lK65m0aUVStKq2EAFXl70ch0QpCyczlQgF85/FwoGpywWc9le4HsF8rLRRV30kSBDsL8UavC6T4658lVWcVBcw2UxaBTw8arkCxTSzDxGYQCLgdbI++3P49RpkUBcfEyuKqW8emciGS/dghFzsdVhIEt2XCCl490dRl9LiykI/WzUdBHpD37/ujzS3wDbmHge+XR/yDZkco1bRgJYee9xYgh1/7jrw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by DS0PR12MB8294.namprd12.prod.outlook.com (2603:10b6:8:f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.19; Fri, 8 Nov
 2024 19:39:25 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 19:39:24 +0000
Date: Fri, 8 Nov 2024 20:39:15 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v3 sched_ext/for-6.13] sched_ext: Do not enable LLC/NUMA
 optimizations when domains overlap
Message-ID: <Zy5o44PLucx52Fp1@gpd3>
References: <20241108000136.184909-1-arighi@nvidia.com>
 <20241108181753.GA2681424@thelio-3990X>
 <Zy5eadwAuQSzqp-1@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy5eadwAuQSzqp-1@slm.duckdns.org>
X-ClientProxiedBy: FR4P281CA0443.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c6::17) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|DS0PR12MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: 8813bf18-2c6f-43c9-933b-08dd002d0ccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BuL4Dk8PDkMBNQ4ODpB8rDCUQJTNc8LRT5tn0YrrdhuZnDcWQIvoZDQviFjk?=
 =?us-ascii?Q?cAbUTBzerTLpExoi01myZ3y03Gu6rgWXti0GnHNsEMeTkOPM69wkEPOgU8zj?=
 =?us-ascii?Q?3XGaAcjA3G32RrY9u02RpXAOECyqqsSIMWtyLmRACZUpRXI5uis5cuCnT3kB?=
 =?us-ascii?Q?4Sao2k+XCIK/pg9wPMG1o2LMs8G/5ieIXjKMzLUkZX2g/D+5+swXkluniWvx?=
 =?us-ascii?Q?PEy1Xw9GFiU5Vw97N1Wz0DE+Qn7/YTBDC7vHF7eSBATTW+5cWHIjff7zV9Zp?=
 =?us-ascii?Q?S1gfw8zJ1vlDWTbjvrUGoPCWNbq7DO4Fl6UvykKFSqnPb1+4ty2yt4suKJLo?=
 =?us-ascii?Q?iJ58Xm1etLIESvPcWvD8TiwXSUdvUxzNlgeXFx04RA0piEiTmjV/axwgtRBQ?=
 =?us-ascii?Q?6e28Zfjca8YE9CjkFCPfUkTv/Hygs6L4DnZUXs3CWVtp2+MO7WF/BRO2GOTM?=
 =?us-ascii?Q?G5zLiwcqN6jdPP4wSQMbhxYsP1baM4LcL2+1aSFygpumHv1g7N2VfCGGWItU?=
 =?us-ascii?Q?5hf+6sZakQ+xyEGWxkZBlpDJJk0eHEdehwe/ufeAJ4jvtiNepfrEaIc2zvNH?=
 =?us-ascii?Q?cHxRqdcuoHK8Oo0n/wyubZA1fRsLYgBEBjBDrTLh7hiLbxZcWE28uYCS0KlV?=
 =?us-ascii?Q?81Gju1hpzPBiuk86HUGyp4jiYZy0ysjzuPtpIlo9R46Gw+mvvMhOWpXe8ppg?=
 =?us-ascii?Q?xasZTUPt1tTUDE0jero0/8rOUIgqDy9Z/oUekFEPCYIoInAfWx9q5Bj+nEjF?=
 =?us-ascii?Q?LXhwi9enWqnb8N2064cIY5vTWXBLLeM0QJQPAdNAlF6qRnYLL5qONZ8QREa9?=
 =?us-ascii?Q?DsFCSVIX3E0teVe83bKESPnaL758VRJ1ZpIsdIAwmN/SZaFr3JjIhXlpYhjW?=
 =?us-ascii?Q?FeSe8FBDCICrM36nGZDUiCPTjc1OW884ZI6/4ECk5DhJ3Ai0RM2l4gaKMzb+?=
 =?us-ascii?Q?wlEJ9iFY8B4mHGPOmlFe4pBB+3QAfZslH8miU+UIYUZMsLJJSsJzj7JmmQyu?=
 =?us-ascii?Q?XVSQvOgXwj+YhxErAE96ns0jyBk32O18xe9lIdglrsROG4c8a1kpRj/wnyd6?=
 =?us-ascii?Q?tT4oi4ps2HO/sO/14+RoK1fCwvplbxqWMUuhjyGNMz3vYDa/Q6ywXgGYMzea?=
 =?us-ascii?Q?fbYONOQvMoQ2fSax7HfHPhdVwD0xvz314wcuGDTFLs8L2+Ig6/yxyNXPJLps?=
 =?us-ascii?Q?h3iSEQKlCRHP5nqy8ZZZkvF/WwOICvTk7RwZIXWr8ohoX1EU+GBEkw9AA/Gd?=
 =?us-ascii?Q?yJmJDGhhsfNlCuhaJxbZboW3q9yXL03YfXlskJ6CEF6SQdkeEs6QaAEtaJJg?=
 =?us-ascii?Q?cfadsOVf25PjBQHoEBrlpvq5?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KiT92Y9mO99SD58SBuzYz7wxF1XN3lomO8OrUdTnC7BJ+9S92cm3K6hQO+DK?=
 =?us-ascii?Q?rNfXuDKMo/7fCmL6SYJueBoFsFfEeHmjIjWFP6IZyzDp2sZv54NnWb5OvJT9?=
 =?us-ascii?Q?fg+IuKoJAtPXqJa/PugI3vuV7gfdLUFSkm/3vx4yRWKm3oejpPvrJSvBAZrN?=
 =?us-ascii?Q?VX0aLs558dpRWL0nhCh8LIjTGRDc4mQrnY6jbsSrw3Lsag0kq/HDoTEvtYV1?=
 =?us-ascii?Q?F4Or6+UeJSwqfwVSIeodFmLItz825fWggtpc/rt8kypfPw4CDoKd4wHsB5DU?=
 =?us-ascii?Q?A2S+QzpCJQKl5VvmF6cAV7C1hjqPFzAdV9cqmtaQdZPED4XdiKyUkRleDUdw?=
 =?us-ascii?Q?Vg4KHzrTv6kHsJRYj2QiHYOp8DXW3FbFi5HzjFoctkQa3MbZEjL9PnI0/7KG?=
 =?us-ascii?Q?PCVTQyjFoJAt1b/4BU+nudSS5U37T20/H7JIgwO1QxFaEsAeQxQPgTtOztgJ?=
 =?us-ascii?Q?cFifviKw8wxXbX6/s1pHmUX0bbCAsGImjxNy9GyVOKKU7Pw3o2B+MY8Vwv+/?=
 =?us-ascii?Q?8LOpk0rcALEzARtHC9cYucRXEi+Zaa+P4Nx72QHdMTuxix4DjL/q7nh78G5y?=
 =?us-ascii?Q?qKHHfCFUnu1+8osD2IRi3i0GaSx6iXgtKd8iSnR7JihhGJ9KucwqPgDw0Rt0?=
 =?us-ascii?Q?u3oo+fDK5mEm89+nkzV6vZewBddNYElTB9y5j8I0ZI0WewBeGnnJuGx9oKYE?=
 =?us-ascii?Q?kzzBgNr3Rfg9DwfDmFl8YY7XzVcGYMEzpkSaN9BJJ1ZfnUdUX9UGR5Mnvenz?=
 =?us-ascii?Q?wnVCeLDLwAweRjAEJCl+VOqNa8IfVrzjvKCU09Q9fNoyAzGLpEqiErcwejjU?=
 =?us-ascii?Q?r+zDTIrQbHn2lYKvbfWGOuQUShNSYSnDj8zwpZBr7oPBui7NUcygNzT50Q5l?=
 =?us-ascii?Q?destysdJr2YhsIOATfdFdU1eTMXd8/m9/wmpwlEAJve2cRl4d59EfwLq8Plf?=
 =?us-ascii?Q?YKx09vt7bSVh7EHNw7PAHKt4Hmmvqe4zG4sHKnM0Vn3dybpBcA2ztIb83XPE?=
 =?us-ascii?Q?IUUlHduNRvsUs/C9j3V8Zqe4YfQ7/jjllXrc23fMUDLO9h3xGMSzaEB8wdYL?=
 =?us-ascii?Q?UP4DYCuXYqk8XAWIMZyZyLsLS1SBLswFFHrNJ21rXY5Z1szDs6MCTRDcYWwm?=
 =?us-ascii?Q?4G9w2D0/6DYv3l68AUrTp6kODsbBC9jbGAZ30mG4m3RYaXJZhHwy+8yqAWXS?=
 =?us-ascii?Q?ChGHoV3u6LQV2s3nHioCjHBU/epZH86/FWuOIfyoUYqMDd9rzByvy8t4rJ9O?=
 =?us-ascii?Q?STgipsMhdNWrdu41gAysesLjeYZgBjNxZp/CBwaSTj/9qVrP36KlpeYc3DV+?=
 =?us-ascii?Q?GFA8XoPr7HfzBAaL7//RhJYJ0cexlOjC8pfGV1QHaQiQYjRjr10YRwMwldn3?=
 =?us-ascii?Q?GaMWLJSY1QS8DON2xHQj3Upt0pvkXLQBYgkImand6TmMov0L1uSX32OACRbS?=
 =?us-ascii?Q?p47PhxH+73CIVsH2uV124gz+3WgYTVCM3XNPPX+Spfg+QyH67G/761IwZK8S?=
 =?us-ascii?Q?JvJ/lb3MGC8kfTlmtPHvCEKHYyE9z83+u71NzBVAJlNNW2/9BvwbYgjDOUAb?=
 =?us-ascii?Q?IDOx5p0CEYBPAJN8iP47bAo6v3INxTfOt3p3GyRE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8813bf18-2c6f-43c9-933b-08dd002d0ccf
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 19:39:24.7578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jV9iYBjElM0CgmxuYuuRjzt03d6rs2O4UFe4cmmDUKtpZzk7qgMA/6rdb905Oi/INi+qE6J7KXIdMqNOHo4Gmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8294

On Fri, Nov 08, 2024 at 08:54:33AM -1000, Tejun Heo wrote:
> On Fri, Nov 08, 2024 at 11:17:53AM -0700, Nathan Chancellor wrote:
> > Hi Andrea,
> >
> > On Fri, Nov 08, 2024 at 01:01:36AM +0100, Andrea Righi wrote:
> > ...
> > > +   /*
> > > +    * Enable NUMA optimization only when there are multiple NUMA domains
> > > +    * among the online CPUs and the NUMA domains don't perfectly overlaps
> > > +    * with the LLC domains.
> > > +    *
> > > +    * If all CPUs belong to the same NUMA node and the same LLC domain,
> > > +    * enabling both NUMA and LLC optimizations is unnecessary, as checking
> > > +    * for an idle CPU in the same domain twice is redundant.
> > > +    */
> > > +   cpus = cpumask_of_node(cpu_to_node(cpu));
> > > +   if ((cpumask_weight(cpus) < num_online_cpus()) & llc_numa_mismatch())
> > > +           enable_numa = true;
> >
> > With this hunk in next-20241108, I am seeing a clang warning (or error
> > since CONFIG_WERROR=y):
> >
> >   In file included from kernel/sched/build_policy.c:63:
> >   kernel/sched/ext.c:3252:6: error: use of bitwise '&' with boolean operands [-Werror,-Wbitwise-instead-of-logical]
> >    3252 |         if ((cpumask_weight(cpus) < num_online_cpus()) & llc_numa_mismatch())
> >         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >         |                                                        &&
> >   kernel/sched/ext.c:3252:6: note: cast one or both operands to int to silence this warning
> >   1 error generated.
> >
> > Was use of a bitwise AND here intentional (i.e., should
> > llc_num_mismatch() always be called regardless of the outcome of the
> > first condition) or can it be switched to a logical AND to silence the
> > warning? I do not mind sending a patch but I did not want to be wrong
> > off bat. If there is some other better solution that I am not seeing,
> > please feel free to send a patch with this as just a report.
> 
> Oops, that looks like a mistake. I don't see why it can't be &&.

Sorry, this is a mistake, it definitely needs to be &&.

Do you want me to send a fix on top of this one or a v4?

Thanks,
-Andrea

