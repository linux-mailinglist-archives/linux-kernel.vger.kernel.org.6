Return-Path: <linux-kernel+bounces-407790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5539C745E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 15:33:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DBA61F2665A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 14:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BF62038B3;
	Wed, 13 Nov 2024 14:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dTYBmoet";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="w2WKlq8Q"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40DA01FCF78
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 14:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508158; cv=fail; b=MjbTpmHSF1hm3Dm1hG1GWovdHoiGTRIR4nsAl3DBSp10g59vMpqIDz0JLHKOKfVOuLdCjLJRCxyptUs7PfUnsNfP76Q0SwsMn83xWHg+m31FA5iO6o7Cue/br6sOBBL5rP1ei6O5EDwAk2TdDOETSb1jLKfdSx8jXazj8FiM3tA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508158; c=relaxed/simple;
	bh=ZnJ0QMxhV4SNYWvG3vMptrYOZb5YhF7TDKSpZCdGqhI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S+MXZIHOapi2Fm+t8bx99ApHIxMKfLN5L9Dz4EpLKwSDJkqvf0u2UJ1bPqC3V3Ldi5an8m2YCA0wU7g1qRlIztMMQgXG8upkhIwKAoXjNoTk4XBBf4K6EoLRIhAeBsmwPmpBWXnPcSvl1tjBePEDLd/Lgk/P8869oIQ1EOgG5ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dTYBmoet; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=w2WKlq8Q; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADDXXpm022400;
	Wed, 13 Nov 2024 14:28:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=+IqIfX3luaNDO4HXmw
	4qFTnc6xusYD3oFdk5GpXA31Y=; b=dTYBmoetHDI5wMYRz3NmQZ1tTyiBX81mOn
	rR7VY7ElNIHoR/LzQga2Wn7zEY6cdD19e0Cq7GKgIZW+24ZQvPWpLhznPOWWP4PI
	Zf3K3WiQXdSVOkqel7D4BgSdYOwpEWk4vmA5FoSGe28GuNR3twtv+QyfY6JmGHgG
	sKlpdfL9UvgWnXCtZvF/cXh0GYQgJE9wbNLuGMlNzCy/+egsj4fWL3JcD3QcJbPw
	K1tUVebuoQMbeqSa9zUPqgqByPhje+6EvoA3uOmOZsotSgjoZTqkNFrOYHvTv0k3
	XeHPoSoEOpfPyj2y/0rHbTxm1zMnUFtLJhCBxYTNFB/DVkKGUe0g==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0k26wsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 14:28:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ADE5DZ7000566;
	Wed, 13 Nov 2024 14:28:23 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2046.outbound.protection.outlook.com [104.47.58.46])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42tbp8ra2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Nov 2024 14:28:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wt5FEqgreinkWKvGyqwt/sVH7Cn78u+VmdYik0k+jGqUiYhQw3Z9XvbnMkdFQEIIzTVyByKftIOz6SHW5MmFcD+EzLta4z0MFbpL8vbYWdcy17sI7wmtxTnexxOmc7xdXWkDNSVZRNM5CwY3CtaROGCwAQd4tbmD45qTuin0zguwoK7hTdg5sM/7H5mBcOYuzQbN+8Li8e8IC2kxtL32bwlI0CHTh7Wje1Yc9LQEZpWMzGuxynamcv7jfwSMZm+trbWLv3mMqXrkHipTdzJs5is2rtYJofMM9KbUpFJaN/kC7vSwFnldZ2/wPhtqDhIbwy1kCK9KwN7PXBHxHLh69g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+IqIfX3luaNDO4HXmw4qFTnc6xusYD3oFdk5GpXA31Y=;
 b=n7U850+0uM4DTztrTiCNJsTmaEkXkegpgAOZXNLbvqdnaxPE1jfR/5WAx8iz5CS5vkUnccTQPx7q+cy/SeMsARcwFzoN6nFosZgBcyTZV0unQSlZ7LNz/w5wZdUExJxjYOw1SUpLhxlzlx+wF2yoEQGqKwoOC0+ef8ll9JzEJd9VWwWSRjuqzn20OKg2CSQm0wCFOPM6jsJaKyh+RzeTwaJpeh76BVtsUvEEsowaBh+5ZYlbkYWIz0tJB5i33xQ9yUXAY8io2LZSKjJj901JNBhzHMLvn3wG+VQFlsjTqp5/o6JdTsXuM6YTTIJPvRz73aRbAmGMg4W5K5x27mQYNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+IqIfX3luaNDO4HXmw4qFTnc6xusYD3oFdk5GpXA31Y=;
 b=w2WKlq8QJZBCwJc1m7kNVgCzAWJCDoSdfDE5Z115QxqgNZDsNzfHbA8j4Tb5g1AhIBuG/AdAVy6+68p/G7eUp8KHnvVAihuF0l4UEcw7BPD9ROG9iVc6j9lCgQY4D15VlQT2bzN+cIbX8kBZm+t7y6i2eS31C/bTiq8sWoKPqm4=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DM6PR10MB4186.namprd10.prod.outlook.com (2603:10b6:5:218::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Wed, 13 Nov
 2024 14:28:20 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8137.027; Wed, 13 Nov 2024
 14:28:20 +0000
Date: Wed, 13 Nov 2024 14:28:16 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, liam.howlett@oracle.com,
        mhocko@suse.com, vbabka@suse.cz, hannes@cmpxchg.org, mjguzik@gmail.com,
        oliver.sang@intel.com, mgorman@techsingularity.net, david@redhat.com,
        peterx@redhat.com, oleg@redhat.com, dave@stgolabs.net,
        paulmck@kernel.org, brauner@kernel.org, dhowells@redhat.com,
        hdanton@sina.com, hughd@google.com, minchan@google.com,
        jannh@google.com, shakeel.butt@linux.dev, souravpanda@google.com,
        pasha.tatashin@soleen.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 2/5] mm: move per-vma lock into vm_area_struct
Message-ID: <637370b8-3e3e-4457-81d6-5913a3ff1d4e@lucifer.local>
References: <20241112194635.444146-1-surenb@google.com>
 <20241112194635.444146-3-surenb@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241112194635.444146-3-surenb@google.com>
X-ClientProxiedBy: LO4P123CA0343.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::6) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DM6PR10MB4186:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dc30200-747f-4c0b-516e-08dd03ef6be4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7qIc1IhxaGk+nRZNY1FL79A1fLJtM5Ypdfi0eRWL2SIKc/sU7YUE4nzVEuRT?=
 =?us-ascii?Q?O7XGkpz+6weIXA/le7NHkLpF0wihv5OltifvSjqYs9yVVM2skdbgcRyOd7qe?=
 =?us-ascii?Q?KOVF+fjHzSNxILtedMqw3G5yY5OfWneFqiYZHsbBrmgaxkh5o42JtBENADYN?=
 =?us-ascii?Q?l1SoZbog1/22k18io+ZqLz/cGIcFaTPmKoBzWekaCmGAvHbaF+n3Urs2XR2x?=
 =?us-ascii?Q?tJ4IAVESgh+zgXoJqxAizV45gzqCSu9pLJIqksIRbCF4Kx16LHsaxbsgMdii?=
 =?us-ascii?Q?GETIbBPr2Whl9CUQhBMoPS9mye/JOYQX3tVO+NHoI+OI46VQ4AKFQjoI00s9?=
 =?us-ascii?Q?VFO06LYJ8/Ij0RB5RLHGNBiE8Gx6Uu2Ld88/D8oU6gR3f2bUkMTd4OOdUi4S?=
 =?us-ascii?Q?mi/CA3Y415cZfKHje383OiN8iGUGAmP1uAN+FumSUh+jaI2OnooLCUs/yVF5?=
 =?us-ascii?Q?jfnIkxzXDuFBwG6yjXt02hzlegxWWps+ueolgOzFkCKviw3fAYQua45rszrs?=
 =?us-ascii?Q?iLblnKG0MalWK2MVR0KNaBPhjDsq8gK9+rJ4HCmil95kl0jaCkuHO+CRxNz3?=
 =?us-ascii?Q?WzVyRZpx9v/kucOG5vRKU9gfblJluQ1yEZJBVmI+YnwTpj2aJxxJ16oBi+VA?=
 =?us-ascii?Q?Yof9jj24jNo66tISmovxMpIZ0AJsXzDhJR1CsD1HSruDAI3yUjQmUhijDZ7E?=
 =?us-ascii?Q?hn9AyLShhx6BBVhiCsjTbxQNt4cu7jJv5xLzLJE50Rrw5W0jntzHKkHbWAtr?=
 =?us-ascii?Q?BX8EyHcnPhiEJBa3eYkJol1TCGQHpijtC9mIsui218brfqJhdPEZTIZfwmeT?=
 =?us-ascii?Q?LQBNa+a8D6dL63NH0qSj11G0z7PxMcAWwWyaHpAiDTk5/9SY67EQQ/13TQdg?=
 =?us-ascii?Q?Fn103GTGis4BZ84EAhFtAhhxwlaHmg842kKLd5wPYqHC6rqR8KkuOnoNImuv?=
 =?us-ascii?Q?j39wx/ffhxi8vPnJAp/AH6VV6fIK7TyJ4E+T5Y6JsIWQk6bIFOYtHZoy0mRQ?=
 =?us-ascii?Q?kzpt+t7uBczLGNfS2TIaNWdTdpUODcLm3++kr+J8Ti8VmAMDGeEyaACO9dox?=
 =?us-ascii?Q?QFpjCaKO+yKxHYyIwon8Oacgf6Zjjo0GQOwjl9uM1LxuN8IqAtBcGGpqeRNq?=
 =?us-ascii?Q?mE/OLeP9/rL8HU7GsrMXBYufd8dUB06tE0l6+SVm7AfoM2YCUeGn18PFuQRf?=
 =?us-ascii?Q?4kPYJSJQp1LoYif38ZfftCEp6uxp9+zMzTgohFilrDEb4RIjGCCelMRets6A?=
 =?us-ascii?Q?Hsw1FJboUSgFAcdejv8pZpyOpZEAQ2q0YlLQstFxig=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PF7FzrzqJ8fLwU9lL7Ki4B6mzk2RZo4ZKj8eMnn2R58d1WXgQzDAjRZrO+Mi?=
 =?us-ascii?Q?5ongj/jonPwenMmiCn30Cz3wo2V0IjxeHdXpU2EgF8YZvc2EsuvdA+SVT39p?=
 =?us-ascii?Q?qOnbehy7XNPxv4+By8Nt8J6x2gFKAMDudpH7r1YLb6kSzeV4biMcNe8PLzcY?=
 =?us-ascii?Q?I21nyCZoUV4qBVki4Jf88cJEpAYtQVTPMhqeygdKsW8U4sQ2Qnby2/dDURnq?=
 =?us-ascii?Q?6d9HCylqVTFqFISgY/qH0onKcdYAHiedEdopGLNqFoeepcIlTxW1YdZrSlqy?=
 =?us-ascii?Q?ifnC2FjBqi2qnUmwVTXRIN9SOjkazL8qO7614x/vRs2VAiCV+TKNnbtO0jLf?=
 =?us-ascii?Q?VV23gT4/AhhcixY6XjZDAWtv1ffOWhNZaDI85t788Pq9FDXqsyqAYYCsjqBB?=
 =?us-ascii?Q?IE0QfCCQgHgwVphaz+mB10oRJ1QPgA83ViK8L52JHwdB0lnRYu8lSAzjwo/F?=
 =?us-ascii?Q?pi9UwGC1eHk1dipGl1R8jK9L+yCprqC5YTMjDfbmbtHq4aD9ErYxNgy6lV5o?=
 =?us-ascii?Q?UVpKTxGiQBtZTVZCF7QV4z5uhuomL9k9GkDOT0vvXSEpi0gc00TcuhBwbQtR?=
 =?us-ascii?Q?01sZX4w+hb3ohzbbLRPg36qmme2NXECCdhfY/HbQfzsffyRolbAq1SkQjoKj?=
 =?us-ascii?Q?leXKm/X0sFnwKOltZTW2RxpAZJd1+lyZlFJcmgw3PxdnrVKy/shrAj1T0Z0J?=
 =?us-ascii?Q?1fwpI3Yu2dop3lbW/7EPeGqkgzrj0zD4YFiMI6bDCdw5yq1FHj+E/oLtLtrH?=
 =?us-ascii?Q?DxVQ8RlE602E+L5WYtssCnPIS2GSjBXOHV/odtfbcra8cQz0vTwmF9LWKfMc?=
 =?us-ascii?Q?1DgmVj68kYV9iEkowemgGf2keB2Rxo+wzZ6jpcTyRHsRBecADI38F/Gc+tXc?=
 =?us-ascii?Q?hoW+2wLK2jfYB/QG2O95BKog1gSJ0GtRt8kFxoq74m4j14MzKlo61w9xtiko?=
 =?us-ascii?Q?JRnE4ctn8plCMdGN/ZUQtnZ2dIwuUo3MZyIYyyZ1e0D3qRs1vcwHcHDqdsw+?=
 =?us-ascii?Q?BX9Gqx/P4iGKSzhZxL/PUBNN/xtg0hVmFEfpg6X4wCVpNrY6ThzRZDX/iG8a?=
 =?us-ascii?Q?fmgzPly3nr2S46kJbtZP59TLcL6HhqWqWIVRuw0KYr5h+m032jDtv2u+cZoh?=
 =?us-ascii?Q?BHtw/C70O2CqRrmIE0lWEVFfe2c0RVg1qjMgGz86GZWdmixWfQ7I15ayg0BE?=
 =?us-ascii?Q?eghYT/wpayDVP1AMPT9CszhYlsemFq3CdO2yNhH4zRgX57f2RG+bx3Jw5p5T?=
 =?us-ascii?Q?69QTpAm1dsNm7AAjXe8joodh73wQ/gOnlTpPYDRtd0/oxx+p9f7+0e4GXDNN?=
 =?us-ascii?Q?9pC7C05sVivfJL41KxXow7Nqm5zqTnPNHWat+4YU88nhaSSGi1ioGq+ATY+Q?=
 =?us-ascii?Q?BcKF7/vC3yDo3ahcvbX9faRNAsSQ5MZ4NNhpUCcInv+LNeplxzORaVzxSOUE?=
 =?us-ascii?Q?T/Qck+9HBQnhrh5zPEryuyceyVsT/5QawNMyWDt3CVsIH0MQbbQzTDAja0t8?=
 =?us-ascii?Q?gzeBgOUVFznaYXcWgRH9IC2AWJamv+OH7U1eOTmaz6kH6acrvVN4GQx5RNaF?=
 =?us-ascii?Q?tnm//j7auKpxIEqElFqXInq/h+CCCWUsapIFU+efj1zwas5YYmzmhBu3Gylf?=
 =?us-ascii?Q?WA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tU/Ool6eMepMW5OUHOsLNOhV1bmF1YI3SX+XosMC4NpfZ8cyxTZgvmpL/NeFTsutisAecp4bJU6LDocNcEQYlrDhX6sT3nlLNJGZJL52HDZBFIDV8LLp9qwDnei1kOnLVPMacTWJ9A3HRn0lqYteMuKtflwHTtNGZNzl43n8vsWOzInXiho4vf+OFQmav47UhbnJ+jiWNtA9x8hN5G+UgJbWew3/nQzGQleBVKqF7L0I6RssEWQHyL57w8TCL2dgnDUzzv/0uX+dq+nsljLh/JJnr3kNFX6870vRrICoTHaI96BR2sFzYVii1g4hvtURsuKanIOQavPdJBOJVGR75P7DIzNWqqiaRRCSb7JnrRvwH2F+jf+mI8aOlBvc/QnfNXWfHVDQ3Le/sFeuWdd+iCTD6aNJ4zfdJ/1d+X5Cd/B4uYn/vmz2OSWjNHLfKAo1iTpdb2pR24XY+H63wQpxGMGJ4oU4KgNWKSm0mZlYq2y5IIRe/LC9maPCpEMCXPCE5ttG40uAh7yfh5as526YAiMHrkyAR/qOjgKNwk0StDFF4fj99C2fs/NhOF2H1Woa7k6okdA1bzP3DV82G4aDRMmkWUymoihWSIZIxwZGGKw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dc30200-747f-4c0b-516e-08dd03ef6be4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2024 14:28:19.9754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KpHqSLcKN+E7BcuNQSgQCS0cMQsuudZwfD8UP8f5qhU9y+Uam/G1yr2xDu73eSE/q3NZdV52U5MOrvb/5V2VY954SGlaZFgCTBJXfErE0WM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4186
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-13_08,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 spamscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411130122
X-Proofpoint-ORIG-GUID: mhrTtjVoaLRK6O0qEtGeQtQNv4AKzlYD
X-Proofpoint-GUID: mhrTtjVoaLRK6O0qEtGeQtQNv4AKzlYD

On Tue, Nov 12, 2024 at 11:46:32AM -0800, Suren Baghdasaryan wrote:
> Back when per-vma locks were introduces, vm_lock was moved out of
> vm_area_struct in [1] because of the performance regression caused by
> false cacheline sharing. Recent investigation [2] revealed that the
> regressions is limited to a rather old Broadwell microarchitecture and
> even there it can be mitigated by disabling adjacent cacheline
> prefetching, see [3].

I don't see a motivating reason as to why we want to do this? We increase
memory usage here which is not good, but later lock optimisation mitigates
it, but why wouldn't we just do the lock optimisations and use less memory
overall?

> This patchset moves vm_lock back into vm_area_struct, aligning it at the
> cacheline boundary and changing the cache to be cache-aligned as well.
> This causes VMA memory consumption to grow from 160 (vm_area_struct) + 40
> (vm_lock) bytes to 256 bytes:
>
>     slabinfo before:
>      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
>      vma_lock         ...     40  102    1 : ...
>      vm_area_struct   ...    160   51    2 : ...

Pedantry, but it might be worth mentioning how much this can vary by config.

For instance, on my machine:

vm_area_struct    125238 138820    184   44

>
>     slabinfo after moving vm_lock:
>      <name>           ... <objsize> <objperslab> <pagesperslab> : ...
>      vm_area_struct   ...    256   32    2 : ...
>
> Aggregate VMA memory consumption per 1000 VMAs grows from 50 to 64 pages,
> which is 5.5MB per 100000 VMAs. This memory consumption growth can be
> addressed later by optimizing the vm_lock.

Yes grabbing this back is of critical importance I'd say! :)

Functionally it looks ok to me but would like to see a stronger
justification in the commit msg! :)

>
> [1] https://lore.kernel.org/all/20230227173632.3292573-34-surenb@google.com/
> [2] https://lore.kernel.org/all/ZsQyI%2F087V34JoIt@xsang-OptiPlex-9020/
> [3] https://lore.kernel.org/all/CAJuCfpEisU8Lfe96AYJDZ+OM4NoPmnw9bP53cT_kbfP_pR+-2g@mail.gmail.com/
>
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> ---
>  include/linux/mm.h       | 28 +++++++++++++----------
>  include/linux/mm_types.h |  6 +++--
>  kernel/fork.c            | 49 ++++------------------------------------
>  3 files changed, 25 insertions(+), 58 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 01ce619f3d17..a5eb0be3e351 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -684,6 +684,12 @@ static inline void vma_numab_state_free(struct vm_area_struct *vma) {}
>  #endif /* CONFIG_NUMA_BALANCING */
>
>  #ifdef CONFIG_PER_VMA_LOCK
> +static inline void vma_lock_init(struct vm_area_struct *vma)
> +{
> +	init_rwsem(&vma->vm_lock.lock);
> +	vma->vm_lock_seq = UINT_MAX;
> +}
> +
>  /*
>   * Try to read-lock a vma. The function is allowed to occasionally yield false
>   * locked result to avoid performance overhead, in which case we fall back to
> @@ -701,7 +707,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
>  	if (READ_ONCE(vma->vm_lock_seq) == READ_ONCE(vma->vm_mm->mm_lock_seq.sequence))
>  		return false;
>
> -	if (unlikely(down_read_trylock(&vma->vm_lock->lock) == 0))
> +	if (unlikely(down_read_trylock(&vma->vm_lock.lock) == 0))
>  		return false;
>
>  	/*
> @@ -716,7 +722,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
>  	 * This pairs with RELEASE semantics in vma_end_write_all().
>  	 */
>  	if (unlikely(vma->vm_lock_seq == raw_read_seqcount(&vma->vm_mm->mm_lock_seq))) {
> -		up_read(&vma->vm_lock->lock);
> +		up_read(&vma->vm_lock.lock);
>  		return false;
>  	}
>  	return true;
> @@ -729,7 +735,7 @@ static inline bool vma_start_read(struct vm_area_struct *vma)
>  static inline void vma_start_read_locked_nested(struct vm_area_struct *vma, int subclass)
>  {
>  	mmap_assert_locked(vma->vm_mm);
> -	down_read_nested(&vma->vm_lock->lock, subclass);
> +	down_read_nested(&vma->vm_lock.lock, subclass);
>  }
>
>  /*
> @@ -739,13 +745,13 @@ static inline void vma_start_read_locked_nested(struct vm_area_struct *vma, int
>  static inline void vma_start_read_locked(struct vm_area_struct *vma)
>  {
>  	mmap_assert_locked(vma->vm_mm);
> -	down_read(&vma->vm_lock->lock);
> +	down_read(&vma->vm_lock.lock);
>  }
>
>  static inline void vma_end_read(struct vm_area_struct *vma)
>  {
>  	rcu_read_lock(); /* keeps vma alive till the end of up_read */
> -	up_read(&vma->vm_lock->lock);
> +	up_read(&vma->vm_lock.lock);
>  	rcu_read_unlock();
>  }
>
> @@ -774,7 +780,7 @@ static inline void vma_start_write(struct vm_area_struct *vma)
>  	if (__is_vma_write_locked(vma, &mm_lock_seq))
>  		return;
>
> -	down_write(&vma->vm_lock->lock);
> +	down_write(&vma->vm_lock.lock);
>  	/*
>  	 * We should use WRITE_ONCE() here because we can have concurrent reads
>  	 * from the early lockless pessimistic check in vma_start_read().
> @@ -782,7 +788,7 @@ static inline void vma_start_write(struct vm_area_struct *vma)
>  	 * we should use WRITE_ONCE() for cleanliness and to keep KCSAN happy.
>  	 */
>  	WRITE_ONCE(vma->vm_lock_seq, mm_lock_seq);
> -	up_write(&vma->vm_lock->lock);
> +	up_write(&vma->vm_lock.lock);
>  }
>
>  static inline void vma_assert_write_locked(struct vm_area_struct *vma)
> @@ -794,7 +800,7 @@ static inline void vma_assert_write_locked(struct vm_area_struct *vma)
>
>  static inline void vma_assert_locked(struct vm_area_struct *vma)
>  {
> -	if (!rwsem_is_locked(&vma->vm_lock->lock))
> +	if (!rwsem_is_locked(&vma->vm_lock.lock))
>  		vma_assert_write_locked(vma);
>  }
>
> @@ -827,6 +833,7 @@ struct vm_area_struct *lock_vma_under_rcu(struct mm_struct *mm,
>
>  #else /* CONFIG_PER_VMA_LOCK */
>
> +static inline void vma_lock_init(struct vm_area_struct *vma) {}
>  static inline bool vma_start_read(struct vm_area_struct *vma)
>  		{ return false; }
>  static inline void vma_end_read(struct vm_area_struct *vma) {}
> @@ -861,10 +868,6 @@ static inline void assert_fault_locked(struct vm_fault *vmf)
>
>  extern const struct vm_operations_struct vma_dummy_vm_ops;
>
> -/*
> - * WARNING: vma_init does not initialize vma->vm_lock.
> - * Use vm_area_alloc()/vm_area_free() if vma needs locking.
> - */
>  static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
>  {
>  	memset(vma, 0, sizeof(*vma));
> @@ -873,6 +876,7 @@ static inline void vma_init(struct vm_area_struct *vma, struct mm_struct *mm)
>  	INIT_LIST_HEAD(&vma->anon_vma_chain);
>  	vma_mark_detached(vma, false);
>  	vma_numab_state_init(vma);
> +	vma_lock_init(vma);
>  }
>
>  /* Use when VMA is not part of the VMA tree and needs no locking */
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 80fef38d9d64..5c4bfdcfac72 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -716,8 +716,6 @@ struct vm_area_struct {
>  	 * slowpath.
>  	 */
>  	unsigned int vm_lock_seq;
> -	/* Unstable RCU readers are allowed to read this. */
> -	struct vma_lock *vm_lock;
>  #endif
>
>  	/*
> @@ -770,6 +768,10 @@ struct vm_area_struct {
>  	struct vma_numab_state *numab_state;	/* NUMA Balancing state */
>  #endif
>  	struct vm_userfaultfd_ctx vm_userfaultfd_ctx;
> +#ifdef CONFIG_PER_VMA_LOCK
> +	/* Unstable RCU readers are allowed to read this. */
> +	struct vma_lock vm_lock ____cacheline_aligned_in_smp;
> +#endif
>  } __randomize_layout;
>
>  #ifdef CONFIG_NUMA
> diff --git a/kernel/fork.c b/kernel/fork.c
> index 0061cf2450ef..7823797e31d2 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -436,35 +436,6 @@ static struct kmem_cache *vm_area_cachep;
>  /* SLAB cache for mm_struct structures (tsk->mm) */
>  static struct kmem_cache *mm_cachep;
>
> -#ifdef CONFIG_PER_VMA_LOCK
> -
> -/* SLAB cache for vm_area_struct.lock */
> -static struct kmem_cache *vma_lock_cachep;
> -
> -static bool vma_lock_alloc(struct vm_area_struct *vma)
> -{
> -	vma->vm_lock = kmem_cache_alloc(vma_lock_cachep, GFP_KERNEL);
> -	if (!vma->vm_lock)
> -		return false;
> -
> -	init_rwsem(&vma->vm_lock->lock);
> -	vma->vm_lock_seq = UINT_MAX;
> -
> -	return true;
> -}
> -
> -static inline void vma_lock_free(struct vm_area_struct *vma)
> -{
> -	kmem_cache_free(vma_lock_cachep, vma->vm_lock);
> -}
> -
> -#else /* CONFIG_PER_VMA_LOCK */
> -
> -static inline bool vma_lock_alloc(struct vm_area_struct *vma) { return true; }
> -static inline void vma_lock_free(struct vm_area_struct *vma) {}
> -
> -#endif /* CONFIG_PER_VMA_LOCK */
> -
>  struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
>  {
>  	struct vm_area_struct *vma;
> @@ -474,10 +445,6 @@ struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
>  		return NULL;
>
>  	vma_init(vma, mm);
> -	if (!vma_lock_alloc(vma)) {
> -		kmem_cache_free(vm_area_cachep, vma);
> -		return NULL;
> -	}
>
>  	return vma;
>  }
> @@ -496,10 +463,7 @@ struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
>  	 * will be reinitialized.
>  	 */
>  	data_race(memcpy(new, orig, sizeof(*new)));
> -	if (!vma_lock_alloc(new)) {
> -		kmem_cache_free(vm_area_cachep, new);
> -		return NULL;
> -	}
> +	vma_lock_init(new);
>  	INIT_LIST_HEAD(&new->anon_vma_chain);
>  	vma_numab_state_init(new);
>  	dup_anon_vma_name(orig, new);
> @@ -511,7 +475,6 @@ void __vm_area_free(struct vm_area_struct *vma)
>  {
>  	vma_numab_state_free(vma);
>  	free_anon_vma_name(vma);
> -	vma_lock_free(vma);
>  	kmem_cache_free(vm_area_cachep, vma);
>  }
>
> @@ -522,7 +485,7 @@ static void vm_area_free_rcu_cb(struct rcu_head *head)
>  						  vm_rcu);
>
>  	/* The vma should not be locked while being destroyed. */
> -	VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock->lock), vma);
> +	VM_BUG_ON_VMA(rwsem_is_locked(&vma->vm_lock.lock), vma);
>  	__vm_area_free(vma);
>  }
>  #endif
> @@ -3168,11 +3131,9 @@ void __init proc_caches_init(void)
>  			sizeof(struct fs_struct), 0,
>  			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
>  			NULL);
> -
> -	vm_area_cachep = KMEM_CACHE(vm_area_struct, SLAB_PANIC|SLAB_ACCOUNT);
> -#ifdef CONFIG_PER_VMA_LOCK
> -	vma_lock_cachep = KMEM_CACHE(vma_lock, SLAB_PANIC|SLAB_ACCOUNT);
> -#endif
> +	vm_area_cachep = KMEM_CACHE(vm_area_struct,
> +			SLAB_HWCACHE_ALIGN|SLAB_NO_MERGE|SLAB_PANIC|
> +			SLAB_ACCOUNT);

Why the SLAB_NO_MERGE?

>  	mmap_init();
>  	nsproxy_cache_init();
>  }
> --
> 2.47.0.277.g8800431eea-goog
>

