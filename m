Return-Path: <linux-kernel+bounces-319132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 433AA96F829
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 17:27:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60CC81C22724
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Sep 2024 15:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40F81D2F57;
	Fri,  6 Sep 2024 15:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Las9Lhbw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bnr9adKm"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E574322A;
	Fri,  6 Sep 2024 15:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725636412; cv=fail; b=Mt0wKtOC1uot7v2wCLb8jX2XQJ4WbvsrdPfFFu76V8QLbB6PJUYwm3vcovXIlphYW2JeceixFBRo0RzfU7f/XO+8ZOp4t8KTggZiwu8zYdA9cTydt1aSxHjKbituMfvbOYyZlz1VLC1E8ELoHHf4+HJV6yvICx4g5K/fvFmdmag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725636412; c=relaxed/simple;
	bh=pEGwGSeKIqhpnaeG5MmpD/odXjma8vp2F6Y645hCxQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Jm3EokPiF5OM7vD7TDKnDUm5yyVpyOEqPob3U2H4PsHOapFamEbK4xf/s8yob6JNC8TAL2h+bIAbQg88VXH0UJXg+ztRylBxthghmqJAEyfHHOK8YuvgiQ+gnWfg8xxZ7XrRSV7k9AFWXT6JbGb0Tjl74gLH9/xhKTiWf6M+LUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Las9Lhbw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bnr9adKm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 486CS3cr009916;
	Fri, 6 Sep 2024 15:26:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=iK6EoZr168Fya+q
	1/szsVX/zmZH8vMKknYpnul8Tmgo=; b=Las9LhbwjotXxjq4lVni3PRIqiE1L5a
	dRl5ccq5bACrHN0IuV7PwYIpBY1ha1sUPTretRKH7chVVhR53pW2F5nynVHf2zTG
	Y81eCrgvOy8p/f9x6imSr2k1AnO0Q1tFD7Nta/N1lF2A62w+Ubem03rUQPTu5/NP
	vnU4xTS7n1MGrSjry+1vJvfdSIf7Y+rb97BkmSbjdFlBsVeDsZuPYfR/4Zk0alpM
	T9pRjhU5J1lvKe5LUkVH7xaWG9DPSZAy0LmLm1USO8G+M3OxmGJv7GlRJElCW3sb
	ToCorHx/fr14TtolhLojrcYTsqpZALIpyFucDWOZlN8WuPbxvDUvTqg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41fhwqhu3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Sep 2024 15:26:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 486ESf5P040908;
	Fri, 6 Sep 2024 15:26:32 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2042.outbound.protection.outlook.com [104.47.55.42])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 41fhyc3efs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 06 Sep 2024 15:26:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C8lkpsNNC7y+shOkQX8EqXnXuWqelAYnt8v2iw4hpo8vx/S8bDPGc8Sw0DYQmewoIyUgOvvof7vIBGSMFiTRbV4thzGYPDE2ov3LFIxySzqDhbumZpL1lbxC8zW+ijYzpd2IVRVAPjZouTh5+G/1XNbv3/o/rNQrdirhzg3pEH74kMs5jUsGFuOSrgeDdmkBq3PMI6FOFI1wgsaQ1PrAQlWeBMd4FBj/Tr/omcvj6l00zcL1NKzJDr2Kwhr0pq/HW3ndk6c8jqUblCOicOmfSQuMwH++iCGEfSu1ajz3pWpr7SkXY+HHh2Ky8yf4tqToGIu7MOSzb7k/+YW8SEZm1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iK6EoZr168Fya+q1/szsVX/zmZH8vMKknYpnul8Tmgo=;
 b=RtgEJrgEFQxAUQbH+QjjMSaP3B1lRxnNHKMNvA0QaG2qzZUps8B+3Iuoj+RZCi3tyyICGuYPbHxF/48C2Q7B2PbBQfCFuBISFxTTSABYSgF+K4WdaAqg3+Sf+2N/AHGPq7v+jHjYFsh54Eoe0y5DejiCMYGz4jiWuj63hE5NVmkgvoaRc7xgoQWQu9wazvumblgwy0BSDtEqPEYo0IC+mQnnDaIi1rhOULte9F/PQ3o0egV4EQzlNrjAMPwqeG/Klc/PWxKVDcQ2vbbeLAEkSv6l/UTZzZ516VYcbA6dLFXEvDr1uUHv3KK1wLuvjGDfL8alddkgxjjJ9KGDA5Pevw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iK6EoZr168Fya+q1/szsVX/zmZH8vMKknYpnul8Tmgo=;
 b=bnr9adKmIrMoRpyDQeCp1cF+c8lx/a4QtceVsC0XPrkECActICmyZSr52BMqkCpXMvuas/XYGg1EeYUKMCchcgwqwDr1AqgHlwtf2NaxITxW9m0jknGiMzTgm2FRTLw6dogvFVokjx9G0HGVnwN3ldMAV6q6QEHi5vIDwzAYnfg=
Received: from LV8PR10MB7943.namprd10.prod.outlook.com (2603:10b6:408:1f9::22)
 by SA1PR10MB5888.namprd10.prod.outlook.com (2603:10b6:806:22b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.23; Fri, 6 Sep
 2024 15:26:29 +0000
Received: from LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d]) by LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d%7]) with mapi id 15.20.7918.020; Fri, 6 Sep 2024
 15:26:29 +0000
Date: Fri, 6 Sep 2024 11:26:26 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Bill Wendling <morbo@google.com>,
        Justin Stitt <justinstitt@google.com>
Subject: Re: [PATCH v1 1/1] maple_tree: Drop unused functions to fix the build
Message-ID: <krsjmi43ziyojqicc4pxzwfwbffqrnk5npbuoq6l2cnq5eovkd@afofyteb5wo3>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Andrew Morton <akpm@linux-foundation.org>, 
	maple-tree@lists.infradead.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>
References: <20240906150533.568994-1-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906150533.568994-1-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0012.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::13) To LV8PR10MB7943.namprd10.prod.outlook.com
 (2603:10b6:408:1f9::22)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7943:EE_|SA1PR10MB5888:EE_
X-MS-Office365-Filtering-Correlation-Id: 57824a56-5e47-4a3f-9750-08dcce88474a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mWtBjtOYdoQwOaJRkEjiD8Rhpel3EXUj/tDxYMuUuJ8MW3JNdXzhQ6rlNTmf?=
 =?us-ascii?Q?Z497ZU/SyGYjO98P5WpxFmSe0Pw1E6D9Yq3yOwN7HRt7feG1xp+Qv6ZdN0ld?=
 =?us-ascii?Q?xNxt3gx8TXUMlB6DXeKU3eGJ9DcGFdNqqVS/OZb0KnTBKuArGTRxIUzyHxQz?=
 =?us-ascii?Q?DLSDK0MpD/J01A3JwmGmLVDy0INAgpDCiM7yDB8aYmtbXlyipEavLrNRXuxh?=
 =?us-ascii?Q?o1JnhzvVv0SFnGSoMZH+o4uGhgwJifP7pGWxNZ2VTCBXleTn7nDn31ja/x1H?=
 =?us-ascii?Q?6AaMDajAU4X5Sp/wt4GaovH6EsZSoRlUm6VAn3kE9Lah79tKJdfQhts5/Itm?=
 =?us-ascii?Q?o3QyWA/YivPrKyPvHA8f2F01CzUQme9HcYDt5xE2AXIYyIynM1VZBYKsIeqt?=
 =?us-ascii?Q?H2i/y92Fj7iFA+2N2gDNlZxc7hHuvDj0qtfjN8frZv0dWPgGSspcKTElrh8T?=
 =?us-ascii?Q?0nyy6+30cu7f4hNxXKuuaYP2fUUkAFb39oB+yv2oYXCZtBpaRuJHKwwB7v6V?=
 =?us-ascii?Q?BVAYhHsvRUQiuaxbFSc9t1FnDSFtWhY45sQ2dpXT+ju+7uwaZFGXx2p9Y001?=
 =?us-ascii?Q?d60qRX25yT0Pvk1LOmMmiZzq/lEE7g5GK1jDHKOsdJSQV/NUiA/xCF9C05yU?=
 =?us-ascii?Q?sjvEjY83t+ZC1HqmKxnNIBdwdqwYmFlMpkUg2ucKt+N7jg+oa9mufo1rMJ/R?=
 =?us-ascii?Q?yHYgSkFcIqhp3Pq9mqnth5U0Vwbg2sN3nObP2JX+j5DuzavEglDLDetky3kg?=
 =?us-ascii?Q?XIq+z54A2VtUJoyMQ0L6xGghAsl+hIxxA/AJNlhGVLFnriCT9j0WzxYufkLl?=
 =?us-ascii?Q?FevlWwn/T6iY42NKsVXSfWQHoRQ4DTvT2p4RJaux9XF+6Jp3MXWjvxQHWjvZ?=
 =?us-ascii?Q?DRC8LK9b1uuoEH3pA6f16yTv+80XpA2lRjm0gDO9SNIU9fFekaAZ3ZcYhNYq?=
 =?us-ascii?Q?gyChxw4zMYJmdYD9DO7J2h7GBQVTkCxOivvt3CHxDLOd/GvJEOtY+RZMmcgS?=
 =?us-ascii?Q?38NJ/qn/SqmHtdNsRkcTo7OHaNGYeA7zq1Py0ApZathHIguTd89AxTJDYMSR?=
 =?us-ascii?Q?H14d8+gQ0uuSRDX9IkpEhwLQjH2anjYE/FPTpZ0bpbhEnpXZO1K8bfMVp8jr?=
 =?us-ascii?Q?FBenMGrXx6sxvqITXS8qmTSFsxQ58cTvbM3ksKGvzHcHOEKkpPrIHTL6jv1W?=
 =?us-ascii?Q?DnZFHsByyT/rXTCN+uIZKq/EdIRm70WAJ0zidJkKvpzH4ChSmOZboCPyLB77?=
 =?us-ascii?Q?gxbm32sEXYuXBHggDk6zyY3U6upxddGJc/XHjAmOcy7ogaThClhfmy+pMLh+?=
 =?us-ascii?Q?OWskqXeC1fjXF0fcXVufjZD+92pn4joCIjhee6qke5UOsw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?SxayQ82vil/U/a7BPzJbxVcUaE+tEexrjKFtMzJUBCNPGk2PTOwd8/Zhz5io?=
 =?us-ascii?Q?GFfeRv4RpcpYy/t1RKooXo+ni2WT8jp1nZ5fuCx1+7EsDx/EWP9Fx/RXgKIa?=
 =?us-ascii?Q?00+rZrTMuOxDOMJ9/MeHbOvH090FmM8dz85IKGmRfH4mN8g+JFLqg0H4Fqzi?=
 =?us-ascii?Q?MYyxCE5+0q2D7hRknrYg83KlAjokNkmtMIEShqpOwev0wg1G0nmX7X0iihx8?=
 =?us-ascii?Q?e9tyJriA03aosr/H0ubDpmOrLVeeeFarTiCbTGpgVR/RVg6hLyHvR//GvBK1?=
 =?us-ascii?Q?8M3NU3G0YOij4/6wRBslermbsLx1ukOOJ7UtLuJm6iWFFhjwkmnc3UrcxFm1?=
 =?us-ascii?Q?Ffmpij71LimHy57hjijKlZxAxXhTYWoZYTtrptKRjwwu2UZiovwfLzoOlvQ9?=
 =?us-ascii?Q?9SNcRLgvaUbj785Jm3QVAEKnpOhmEbUEEuk7PHpTDhckxBwrk0hdti+0pdCb?=
 =?us-ascii?Q?q8J1kMwvDsNU/em1rQeXrZZ2JJvnLXUQao+UJJpWjSpQvxWDL8c2TQIkRDOW?=
 =?us-ascii?Q?m5kn/yAvXgkw4k3b0B+v7InV2ba14WJQMQVv/ASHnIkTqM2BbN0NE6+229kB?=
 =?us-ascii?Q?Qmh01XEHgF+LCAvoGGKx1xyh0xFYoblvA6Sw/54PCvzBhoBhRkQLYVR/YX4K?=
 =?us-ascii?Q?0WEtcv4JCBY4Tri+v/yDvpL7o56E50JST/FaWEyaSgBrC6BEdcHhc+x4oqxU?=
 =?us-ascii?Q?skhLZsyJrz8bHN8j4hby9RlFtuyTWB9uSAtCYn6es4WaUh3l3pCtkckeQhfw?=
 =?us-ascii?Q?3PG60YGBWX9sa+dxA1gOvzgSLwuTuSAK7Os7dcSbloNOGlyx3tlLEshOmGAT?=
 =?us-ascii?Q?KkIrvgIvoivUhtXUb8rVTeVGQXvz28hvJOgpk4khpkuCTp/Ey+yIGm9BTWbg?=
 =?us-ascii?Q?J1znlkP9PO5qkOZH0G2KWU8AR6NMBQuAn/Yv28F9MBY01eAerZ+jGeV3pJqV?=
 =?us-ascii?Q?AlG/6px9PkWmxCxSPqKIFd7Z73NMCWDhYzp9mWjO041w9YkBbSDAL+pjL8dw?=
 =?us-ascii?Q?QIKBDwcV9ApLaK/vsdSGSsr6goI3mWpaNMQ0eggPczcKCWMCRLt0duCbOzVL?=
 =?us-ascii?Q?Of6pwmxowq9t00CR1sFvQ0fphDJeAP9M5RBk8N7Tuw0ACK+kBDGRH+OIWeHL?=
 =?us-ascii?Q?aTrFwQJuMT6FwPoTSDyq1TFDNNZixAbkGNPIAmoqXTY3mGqsK1grjIZ6kE90?=
 =?us-ascii?Q?MumuxxrXVOPXq0MsygBRdZgmT+fhAi68R16zdgPpBvfDVhGvjgW1TSKc6zHR?=
 =?us-ascii?Q?ZQhxOZUnuxTsWehNly9dpm6EqNk2185RriDqfrSe7p4c4uMtK9voATKaIrc5?=
 =?us-ascii?Q?r07l/KnZ5eeaRrbbI7K6JasHnR/ZzLQeO7Lq8ePuF+gwnhdish6v6yl+BBr+?=
 =?us-ascii?Q?NzHIPgDKZaFmRcqD8PwPqRo5v/2bDaeTidCHlZ79pkPz3k0pQNFfbTH4OSnN?=
 =?us-ascii?Q?yu2Mt493EGh59fXUCIV3WumwyynVoS/4V+wzFqSs3XPmre+0TJKYCsecs5a6?=
 =?us-ascii?Q?4CK/RB0ZS0+8+0Yv4l8zhsK1bwp2CnKn1BQUUAva2dWiyqs6q1XsrO6GSold?=
 =?us-ascii?Q?zNdmUc1JbSJT/KolJ0gYg4zzbvPIOIsAxGZ0FRb1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mal8yHq4zjz17h9kjN1NyfhnumVzaRzo68YXxTOYRkUzuXnsSlUy9mTTOQwDRZUEvbJ7Hr4PlFxZSM0R+l1UP3949AGZZOiXmC5mcCMDu/c/m7Ps0RIqCHMoj+EuItpHXRV9hSr9CExkRHHqT01hvvAoUBe8bzd2GWg24DqBhqI8uoeWySZF8s+K0SD79kza5PeHw3q9TE4w37ZSaZj6IAI/L8k0eguPL1RjfLUVaX+j8U6/igr1jzzKLLu+hp60xFzhK+oxWD9SCHpubr2ZC3hb2aHIaCqdoMwIdNB3lJeXkUUn3LxjLlK2+cwvfO1UX6+5ZXfkJguys3a0eScK8BTCe6HjZjcRelh4oTnOkrV+Bu3khGZ8mbp6Xsp/WuQIRm7PaHM9xRrmsW9+dnnHJuFTjKtvU7JtJFRXe15zp07MfAEF86D6dKepXvZW8zHHPDdtuzPErJ2/lrofaoqam73k3nIckOvv/W+vkKKSCEVo12yF5/oG0e8gdrARemJeB7m1RsLaUcXaJhmEij+6d5f8V1hIzQONiFENeKwINjKyjMg8mZGrZ0yM9BiDKDm1F4KxJZTf7gjGtaFDSsb8Z1VrJmOBu8CVqMVUnYR33Cs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57824a56-5e47-4a3f-9750-08dcce88474a
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 15:26:29.1904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z8h+R4GYq+JMSUsQvI7QgrqLFCQWprDH98gJWt7QLOFRYB87hBAmbJz7tGscnp1d4cTlYqg94zVL0+UGg9RXTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5888
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_03,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 mlxlogscore=751 bulkscore=0 phishscore=0 suspectscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409060113
X-Proofpoint-ORIG-GUID: cSpRqQ56U1JboPbwFepN5pwGR4W7sRIh
X-Proofpoint-GUID: cSpRqQ56U1JboPbwFepN5pwGR4W7sRIh

This exists to stop people from using the bits while the feature is in
active development.  We had the same patch a few days (weeks?) ago.

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [240906 11:05]:
> A few functions defined but not used. This, in particular,
> prevents kernel builds with clang, `make W=1` and CONFIG_WERROR=y:
> 
> lib/maple_tree.c:351:21: error: unused function 'mte_set_full' [-Werror,-Wunused-function]
>   351 | static inline void *mte_set_full(const struct maple_enode *node)
>       |                     ^~~~~~~~~~~~
> lib/maple_tree.c:356:21: error: unused function 'mte_clear_full' [-Werror,-Wunused-function]
>   356 | static inline void *mte_clear_full(const struct maple_enode *node)
>       |                     ^~~~~~~~~~~~~~
> lib/maple_tree.c:361:20: error: unused function 'mte_has_null' [-Werror,-Wunused-function]
>   361 | static inline bool mte_has_null(const struct maple_enode *node)
>       |                    ^~~~~~~~~~~~
> 
> Fix this by dropping unused functions.
> 
> See also commit 6863f5643dd7 ("kbuild: allow Clang to find unused static
> inline functions for W=1 build").
> 
> Fixes: 6e7ba8b5e238 ("maple_tree: mte_set_full() and mte_clear_full() clang-analyzer clean up")
> Fixes: 54a611b60590 ("Maple Tree: add new data structure")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/maple_tree.c | 15 ---------------
>  1 file changed, 15 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index aa3a5df15b8e..f7601aa470e0 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -348,21 +348,6 @@ static inline void *mte_safe_root(const struct maple_enode *node)
>  	return (void *)((unsigned long)node & ~MAPLE_ROOT_NODE);
>  }
>  
> -static inline void *mte_set_full(const struct maple_enode *node)
> -{
> -	return (void *)((unsigned long)node & ~MAPLE_ENODE_NULL);
> -}
> -
> -static inline void *mte_clear_full(const struct maple_enode *node)
> -{
> -	return (void *)((unsigned long)node | MAPLE_ENODE_NULL);
> -}
> -
> -static inline bool mte_has_null(const struct maple_enode *node)
> -{
> -	return (unsigned long)node & MAPLE_ENODE_NULL;
> -}
> -
>  static __always_inline bool ma_is_root(struct maple_node *node)
>  {
>  	return ((unsigned long)node->parent & MA_ROOT_PARENT);
> -- 
> 2.43.0.rc1.1336.g36b5255a03ac
> 

