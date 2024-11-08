Return-Path: <linux-kernel+bounces-402290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B51489C25E7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09C11C22593
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 19:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6DC31AA1EF;
	Fri,  8 Nov 2024 19:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="BXwsjZdi"
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9051AA1E9
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 19:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731095653; cv=fail; b=ZpMQy/78HOsol5z2lrDOrPj1ejmpGaJxkFbGhyJ/Lm/vCWZl07xJ6x4oMupATq8FkZ+VaZF2Uq708kzXqTZTehOn88y8B59p54x3iP8cMEznffiEKVGO0Em+6M4psN+ea7k7p2GJ3amAeYuFrWc/vu4q4bgBAkY2vBfHJIkWpKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731095653; c=relaxed/simple;
	bh=RJENZzmbZmvHF6L2wWu0bpAuK7OUg7s1FPL/1xI8Br4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hwZdFfr2ejzT75aOxvz168F2YD/NwUbhsvo1Iwt2i74cDncL/ketOFbNdAYfdMpAlerss/0wPoDUCVz2aUsXdMyY42+9RDhtzLPI5hQcg8VWfzd2PrGzrjscBYjTjGmkzgdoi1nQVFpHZuDRkV8l1KWfCEsNuuhL71fvO+h83Es=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=BXwsjZdi; arc=fail smtp.client-ip=40.107.100.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxNEy8acK6D+PENAEWmemmqjXV5AnCpVu8jkuH5KXIaY7GrsBH6aDJVYE3bDY5zl8BYR7bgoRE298vzzQwbkDXikIJzqM11pPcEEk0v14rPSw9st3+FeqWLVujzZfZgNKOHPP+jF+9v2+1BOPdigZ9xuPTk79DZ2D/iDSXlAa/nC4NUls6YJVSFRYZGGwJHM+q6eUl+bf89TqCacg13EmnheHcqoEPjVtMAcIjKLSr0Ml1AjMyOs5hTB/S5qzEFa4npMziDNci9xV2s4HDrpJ1TDYIusuRKbYBS1UQiNCWDrY/0FKa0QcyKAIpdM21AxlT8G4Mn1guySQhF32dMn7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4rEDJP5zzOK5cGdK+G9bIbMjJ3J1x9HfM24yd7L0QzU=;
 b=uNlzbhxlCa5uWjFWcaJyg/caSwBHrd2CaNl88Vas4x6uVV2NQbIzvsGDba8YO82AB8ud0xHXCxGgpkEzZ8J4ERaoUYdojyvSaY8boNNGSU8wQkmNs042hM8qK5tBFQoX+UJuymimKHhL36GqN5cWtiL/3q6ugvB/0YcO3AVBA8KOoFnzdZbUJRdqn3RbUiUd1WJTW34fdtVPGoQFo0Gsumj/J9lVDx/nAMO93adiQjCs3Xm9Z1NXyvV2/x4zOpTm7IFHf3V47ZK7hKMwM/msxoMMysRpOfdVoEpWcmAQ2Q6ksomNQ/E9IHmnJhZixVVM1zRa1ZmPfXuWjGO7f38l4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4rEDJP5zzOK5cGdK+G9bIbMjJ3J1x9HfM24yd7L0QzU=;
 b=BXwsjZdiouHZmVlQx6MZEAgPVVH+yRlrFE2T7TSqEm1jhka7Vz7sXzeMR77WhlYsU1HzbBTyrsT0VteD4QInak/yqk4Y2z3u/9rXc8QUGdO8zhv/USagJjoviyCXbf/D+1WElcmVh0GFi1JaLtmVU+y15SNy4a5BSJzRfG5xX3MjGHyd+przdDlrC3A7vOO0rhPYCT6LINnH2vW+RrWEnR5XJNcqoIo6NYOwzIXD+ayJKIfftQojlhUD1/QMCc4oJZVbZf+tyCtg/F7zJPe7HrMECm03n7M5sPXN2rrTYZQYlU3Sy67cn9tJmQHo0+MRPWec9eMf4q/bc+J6rWFSTA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by BL3PR12MB6403.namprd12.prod.outlook.com (2603:10b6:208:3b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 19:54:04 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%6]) with mapi id 15.20.8137.018; Fri, 8 Nov 2024
 19:54:04 +0000
Date: Fri, 8 Nov 2024 20:54:01 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Tejun Heo <tj@kernel.org>
Cc: Nathan Chancellor <nathan@kernel.org>,
	David Vernet <void@manifault.com>, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v3 sched_ext/for-6.13] sched_ext: Do not enable LLC/NUMA
 optimizations when domains overlap
Message-ID: <Zy5sWUEQuqhXH1qE@gpd3>
References: <20241108000136.184909-1-arighi@nvidia.com>
 <20241108181753.GA2681424@thelio-3990X>
 <Zy5eadwAuQSzqp-1@slm.duckdns.org>
 <Zy5o44PLucx52Fp1@gpd3>
 <Zy5ptHdJaU1aHzaK@slm.duckdns.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zy5ptHdJaU1aHzaK@slm.duckdns.org>
X-ClientProxiedBy: FR0P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::14) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|BL3PR12MB6403:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a754c09-6627-4f02-8d72-08dd002f197c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S/ia1hIHfA8CgCsrok64QX0WQ8vXqvHXd/VTP6pypEfOYhL1AF9qqD5M6mwj?=
 =?us-ascii?Q?3/qiESSnohhp62Icqf3r1tZ0Bv0H8fKR0ykS/xJShw0Tt+3lXa33SbIG//wz?=
 =?us-ascii?Q?asl0vfE/eT0luWDG6dDOxbyjQ8SndWkk4mQUuNNxAhJP7z+XZ4C17fPkMrlo?=
 =?us-ascii?Q?LjY8Aunnebflba3D0UyxU2rdifx4M1BPXOYx66A99S6u6iYEzQafhdRNMrNk?=
 =?us-ascii?Q?MGDvI0d1E1DtCc/1cXP4HdfqMV3CQk5+FCzt4PdrPRkJurOe6b0qM9nsUD+Q?=
 =?us-ascii?Q?D4uo+u1u/y5ctwmEgRaJ4WMArRCy86hZAN8vJeHe1OfjLJwAodBbAnfHf2RX?=
 =?us-ascii?Q?Ny4/mVUAZcGU7e8dGnIsLWwJ4GOPum6JJ2ccLMOGoISWduyAIE5s1DF1L//U?=
 =?us-ascii?Q?EmSK1VZ9394DUbDNoqVtb/Zm1a9LsWCuRw8WvnVU17QmFmsd+h6usuCgnT0q?=
 =?us-ascii?Q?06+nTbxysJ/MTX9pgMUjKxh4RwSLJOz8DudyAvo6S0aA5iXAVfzethvZnqc7?=
 =?us-ascii?Q?sCMkWkohQwETMAk2HRRUvIlPGCE1/3VLhgrn9CogITWDeMnIC8EXLdVTuOe/?=
 =?us-ascii?Q?xqZQtPulgNCSWXykJsn0Gjo4fflAR5n6zw5SfE9dCnUZkuSoNjOtMHonfNiS?=
 =?us-ascii?Q?LrT2gGTceKHUUuGn4vn29qCuWgFiF+dsO+mI9eYaCK+g790HbwZ+WY9jlQDF?=
 =?us-ascii?Q?M5uKGZHXCW9+UkU95JfMb3l7IBnuDtZA41uDATPq11Ao+uQlvkVADUOqCMPE?=
 =?us-ascii?Q?E4Ry3lc7NjotrXj62cwjxUGS8QgO/XgxH76XVyVSzOd4kzgNCXrFn7uk0Ypz?=
 =?us-ascii?Q?1HaXqJ3mUOjvKbgTlOnrSXMzHS05Zu/D6miLc0oPmBzplKCJ5a2BeK4oepOs?=
 =?us-ascii?Q?BZtPMoImTOsmniCUZaIlTsnDKWbZLoZ2WURVSouXBeTk0Ij7367JKoSZv93v?=
 =?us-ascii?Q?p/+Aqir1W33TTEnJlg4xHwHyD6FJt9s1nF6l6N6630rBazVEJoFnxvWjXSfu?=
 =?us-ascii?Q?hj1bRNvxbb4XtQFmdh+567EIoDU0E/6ue/zmTyCNFXURIMIrFoj1tpRLgziV?=
 =?us-ascii?Q?wGOIfMaeBvUVfK8zVD4bnD4GOyTXcvN/DX4tlM9UnDyrHEWB8TOXoLHC+YiP?=
 =?us-ascii?Q?Fiot9W+V0KxdN/xRv6NsAhqIrVoXikkqzBcrJ3OpRKexmXSzAPH8fPkPzeAa?=
 =?us-ascii?Q?8eJ81NEFSHQtT5kk1BcpASjKv8i9MqhOl3aKqzrZvom1jtxINTSGPNFRue3U?=
 =?us-ascii?Q?lelwiW8qHP14S+ZhcsTh+b4vUTzKTMvmUyR0auaz6q9TtVDD+CKSjtv5acrU?=
 =?us-ascii?Q?NxQWOdfvcQh79we52OMwUirY?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JPspU2hzC09JmU/rhzOPErjFNKkewMM0ebuO878rjrLNK3uKOZ1dfWUWXaIz?=
 =?us-ascii?Q?XVdjPGSTyFU40IEmKTwX/j/Li/M52+f5APylrbZuwPY9QJUyjSs+K2jXolJ4?=
 =?us-ascii?Q?h/jj8kzw8jU9oTtTpIB/L6Xa6eYi7K677JhdzO6aFXDpZ4ThdgLMHVkR4sjM?=
 =?us-ascii?Q?CjVxUbaTMPXCiuhKuXPh3BYEDYP4kiQadyYNhUx7cP7+GYhYbIffzhfJ6xBQ?=
 =?us-ascii?Q?5CylUnAgImoJRPEVLWIiBw67mVbRSoktKsCp3a7ASeTfSkv1YrK+Ws8YlySk?=
 =?us-ascii?Q?JaPpeFMZFJcnk2hkxN9bgD+j4jilBIKRR30WsxrcAKslmf1YC/ZlUSAVmpBN?=
 =?us-ascii?Q?HGs5Mc2yMbnqjjwQh+hiQX0kmc4spnxMD0wE7KKRaXOEvAylJ9+OgdepRPYu?=
 =?us-ascii?Q?Vi+Rz4A0PUjmoW0RBr/k5RpqT7VMMSEcLY0quQSALsPfrmfrdJyUDAKtLzdY?=
 =?us-ascii?Q?tNbfi7GHMFwfxkmEfxP/4A5x5WsPLr+k01LtrcbMXb4nHKH5ZWJDX1njkxWZ?=
 =?us-ascii?Q?tgYv41swcDNz5iXGfVn9H+8Rv2BvRwCApsPXMxg58bYT5gSGQ0qKYkU1Aw5+?=
 =?us-ascii?Q?HzX/UU4PeKmkFXvNYptRfM5AMDftVEutVs9iFqsIj5mW4mPhy6enDptxPvcr?=
 =?us-ascii?Q?4HrwckoL8MIZqmuk6ajXLKwMVx6WhdpT19nJW1TE+gaWiDPDogNVp4Jinvmt?=
 =?us-ascii?Q?fLW+FTKPHhLdOO+U/pJ1S8bzFXDW/nrG5hOy3NPfY1ZytlvkOW/4daRPLFpk?=
 =?us-ascii?Q?VfbF7laF4+Wny+v1ghTesAUVTULmdgja+7f72bZXl2zfwVPjnzIhTaHQaMZp?=
 =?us-ascii?Q?caP3M8wiZVz1stYQFfqvdqBDmECEK3VnzFRvNzw/bb8cSper/zjisLJngnjo?=
 =?us-ascii?Q?rUSiGUDD/5DuSDo73Q8ClSrWbV2bv2WSBSr+vBZATAzCYszivROVRZMWjpu8?=
 =?us-ascii?Q?vF4B3QZpFhc8oxsjCuLGBHb0wwJaUs+n8SHJQnhGdSmhiDfv1gqKMDmhxhtY?=
 =?us-ascii?Q?vU9YKo14/ITXpJwJxXuJAoHHBWTrTT/xFQnAqbOfGm6Z0arI70g/+5b7yTWb?=
 =?us-ascii?Q?5z+D3kjwVCFlfIDPTniNZRD1JDNE2hHubakPYtzn/1nSnjBukklet47PE+MI?=
 =?us-ascii?Q?eomToFYxXPtRmPWt0J1UuG3pBlYXhktCjQPTv3h29+ko5f4l56UGwSyG428p?=
 =?us-ascii?Q?XFjwLPTl+zgN8cKnEuYMLTOjh+FvOfwuaCPdq1EEmjZHUVXBIxccmID5EDfi?=
 =?us-ascii?Q?oQ3ceM0wqAEQ3kicVbheN9EEqRcX1W0tuQNO21e4YXpfwZrGSFFBVln9iWaC?=
 =?us-ascii?Q?/4R7Twa658pJ5Y2tBmLpvnTLQlIzeGWCzFPyk2zgKCmfEhkKAjZekCiP1hif?=
 =?us-ascii?Q?/+JCyp1+3Wj9nokCviZbaGxN1BAfFJ4bAADN/6vhEnKhRQhCv0KWAxUJtpiJ?=
 =?us-ascii?Q?Qjp1WeqWXjtTR2z0H0LUR3Jj/iNiBMny9B+GM6KGu2DVy4+cCSZwA2A8VTRR?=
 =?us-ascii?Q?5NDOquYdfdYzejGjrU73dIXcpvZv4Mzo+4zK8aDsDbzqMVMJ5f9y+nlrHYi6?=
 =?us-ascii?Q?wERahZ17ZNIlUn3upqcyAs3sPiGXcENQTa8SV+KR?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a754c09-6627-4f02-8d72-08dd002f197c
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 19:54:04.8341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sD+Pzze/knGV2UvgdzT9BP96LlOsOho74QnMOW1Y2wgQ4qlBBm1esP5t0P2+zZ8M2YgbMWbaTQ2TEWPvZfKtRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6403

On Fri, Nov 08, 2024 at 09:42:44AM -1000, Tejun Heo wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Fri, Nov 08, 2024 at 08:39:15PM +0100, Andrea Righi wrote:
> > Sorry, this is a mistake, it definitely needs to be &&.
> >
> > Do you want me to send a fix on top of this one or a v4?
> 
> An incremental fix patch would be great.
> 
> Thanks.

Sent. Thanks Nathan for noticing it!

-Andrea

