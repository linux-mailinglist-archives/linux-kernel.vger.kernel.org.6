Return-Path: <linux-kernel+bounces-301692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 358B895F418
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 16:42:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5500A1C21DBC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 14:42:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C0418D633;
	Mon, 26 Aug 2024 14:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fQbxftpI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tbrH7Sx+"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9CEF153BF0;
	Mon, 26 Aug 2024 14:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724683330; cv=fail; b=dBxIAmLNOmdaTrKJuErsVCLht4ColyEQPyiiR15xsaTv6HE/Xv+3Hf/l7QZzpIaCTizmEgH8LyJVilmRoTz1XGoyzYtFINdlDJbT67LuglU2XwZru9QFbq28M0GcLsFQtzwsxbt276TiuH0p5Jk6GZrBZAXiwYDdCPxshLAPDWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724683330; c=relaxed/simple;
	bh=DyKbWWoVDt4a/79ZtU6kQZSeb2t6DUBPAC6Air6jZkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u5KE1NdPOtZ7IwCe8VsdcUqT5DGkAXyiBTLkBNDuaT/EDDEJnE4+2x5s4Epk4x6YuJhNmTYF8vRd0R6TjyNiKhFUL21UHYNBQxQHbAmd5b9foNDcn3YuV9YrpbxxPaSFOHVp4OyeoHORjgJa3rP8ycz5K2ChqRl+BW/iSVzHw1U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fQbxftpI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tbrH7Sx+; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47QEfTHM000485;
	Mon, 26 Aug 2024 14:41:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=nKOXpRHmgrT3SKf
	VZJnUZ9DUZPkkBlZ+CpulngudGk0=; b=fQbxftpIrweJIv8QDD2fzFXjUz/2vx4
	GqE8aFA2cxh2koC5ljKQ2r+/bXJewToE9N5BfSzVKGiLlY1nro1SUt8QvZ9EP0Cf
	bgrkKnhcqhK4+D1ysuE0bm64Xh1SLT/wvZzQ8dub0wtnNOHRU/u61Ce6eepcPLyc
	8qnL3HaxrLJCKvR+18etZptF3YIEBLDI9USVeTt98bZ4w/po9aphr/tnkCyt6v5s
	e5dhXCvyjd/ZKY28qUdJjzGxVZCoYB70jvksytQsm6hegA18Pmuo260CFFARLlXi
	PCBDx0at+04KvF7o7Na/3yi/TXUj7qSActwA91UW2hme9gE+8Pz35Wg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4177naba39-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 14:41:58 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47QEFqP8034673;
	Mon, 26 Aug 2024 14:41:58 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2043.outbound.protection.outlook.com [104.47.56.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4189srnsrm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Aug 2024 14:41:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=si3qPilLV/tsNJ6nrIJ+BsFLlyBlX9cXOfyBmDVyLSZs0bpdbMov6t7FMgfWbA4ckef6guWMOOXgAQcyeGvXuhQ9q7GTPoK6mCc9qam8tEsMp301TP6ZXH4GttKVSY481a83y0AZaAO81YdVsd3ElPJ+18TP68pUlAM1LfcIwsQF8sCGi6PB8v3zgqckg7vP+i7a3i8+9kibCymVPJ0fFbmvKU/dmqutJ0+r7PrNGPIQxONkeddhocKWxi7X7YDcydTJYZnmfB8BhCJDcYv5+exOygPy4usvs9LNe0aP3wu3RNQ+EOx6k2OEt+u13TQwU5cgqNOjrsnV4MxGm8Z6UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKOXpRHmgrT3SKfVZJnUZ9DUZPkkBlZ+CpulngudGk0=;
 b=Pkf6h9aRpAxwjmcJJbeGHyQCOjPt3HzpeOfiODb21jntMkM7vSCyLqXHzisT/G5AxFUSCvH7FboLAWqtTq8FGlambhJ/4ece+ZC/vKWdMlE8DgihmNuu/AWokwyvpsAeuFMZG60YnblKZQfFOmy3J00EZWKGDTrqI0QU/goQtuYsEVyXcM0PeIvfPjLA3stuuTsJZO8/pZ2sOpnsbZeaWoT4+VGEcfM3rIvjKqbUtI6t8uV3WMAVSTYljJdQC5vz52UKFw3hqSyen0GknvyLkF1kz1vlnt61mTdudOociuN0ZM8LbdzOsXDig7iAvovInZoLAfKzJaPpn3aNy0c8gw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKOXpRHmgrT3SKfVZJnUZ9DUZPkkBlZ+CpulngudGk0=;
 b=tbrH7Sx+SP0H5CvreSxlYENlC/85iE7E6GmxQogH3Ois0Uka8U815CUcQL88fu494lTrfzu0LGEG4jWZxf//n0thHynMB2qlR20v/qu8X0r2AQTEENMZj3gkNWdlBJNNpZwQnScC6Qo499iyWC8RPMRSOBrbNIM7GCGoGPkGWzs=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CY5PR10MB5987.namprd10.prod.outlook.com (2603:10b6:930:29::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.14; Mon, 26 Aug
 2024 14:41:55 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7918.012; Mon, 26 Aug 2024
 14:41:55 +0000
Date: Mon, 26 Aug 2024 10:41:53 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: linux-mm <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org,
        Linux Regressions <regressions@lists.linux.dev>
Subject: Re: next-20240826: arm: tinyconfig: mm/vma.h:184:26: error:
 'USER_PGTABLES_CEILING' undeclared (first use in this function)
Message-ID: <a35fh7ve7uaobipdhkcnjling2w2h2on4bwosgllhm73iirg4s@eppqfp7ehurf>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Naresh Kamboju <naresh.kamboju@linaro.org>, linux-mm <linux-mm@kvack.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>, open list <linux-kernel@vger.kernel.org>, 
	lkft-triage@lists.linaro.org, Linux Regressions <regressions@lists.linux.dev>
References: <CA+G9fYuTLbZ+UiONYVQbtREuOZXc3oWP5=x-qqDhmFRmFfPtHA@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+G9fYuTLbZ+UiONYVQbtREuOZXc3oWP5=x-qqDhmFRmFfPtHA@mail.gmail.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0310.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::28) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CY5PR10MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: 98d972bd-ad3c-43d9-f2b0-08dcc5dd3b29
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?SrqmxpG2wOwvoWCxVBgu4AVUR2nuQISwO40YeTOHect438bLbq1cX1vxsUu9?=
 =?us-ascii?Q?qYSmkKftetjP6aNEtGTVwL5vj+Iq8mj2JI7WB05Pokuoyp8JqnwQsaXR4sW6?=
 =?us-ascii?Q?7tRYWrZ4I+Lfqu18q5mJukYxDGuu+RECo4D5DwI9y2V+AfgpJtx5ao8ix45F?=
 =?us-ascii?Q?w4j4+1hBPSywb8D8v/tWosie8FHf+BPdEu2OMDv0+y1/4jsc2fOQhiaIJrmK?=
 =?us-ascii?Q?N3yRIOQ2GMGMYqiPjAhIZkh3itf+/xVB1IavOV2GeVe2RKGzcBZd9RFbVbWD?=
 =?us-ascii?Q?RC6KLuw48ZgnRVKTtG0Nmv+f6zbaQktahCrKf+pzFGGLgrFzkarx5x1fseNO?=
 =?us-ascii?Q?DRY0QrSyKVFLil3dcNfUjQQkemAIRSO1OF15Fl9Pd8VIwcMkh+Pn7qLUUOsh?=
 =?us-ascii?Q?7+FK1VuxtwI9BOh8h7x2mLkaRKOX1SAVoX/FCqDrxM0UhSnr2e+brGg6283B?=
 =?us-ascii?Q?kJwCoVUFiDtbgoX3W/CWPa2M+D6ccgxoGxr3ZCqnrMrtWgvrgpXQ+tqW4Ram?=
 =?us-ascii?Q?orYDlQhfj1j0ZwV4U+uOhiv2pz55LgtVmzwCYD+6YR278xxTNxe0t3eYPmrX?=
 =?us-ascii?Q?VqUmgzsjejkPQo5sFxfID1rvNEo6PikRmDsP8iRb6XcJRGVz+3i+h8JZUhlK?=
 =?us-ascii?Q?Pauo8PM3CIpgIa6Tcg3bIGcis6ByJ0vdMq3RrJxIXa6MJj7vZ6AvY1q3J1tn?=
 =?us-ascii?Q?9d+RIHk1YFQBbmM6R3SPJk9yKQA4bt7vm8qeIkZgmElC+XBUaqviDX/OrbHs?=
 =?us-ascii?Q?pTh6yCe9/7mGvvYOrE3ewusy4ZdqhT75iiA7RVUbD+lHm8vMzRJdxw8OZPDU?=
 =?us-ascii?Q?39eqz9ilvnNW/jilD/nhIs2YSevf6ea2aoEEdm5bXavUN2dYAfvwT2/cwwgC?=
 =?us-ascii?Q?5ELR/Kn22yweUxiBZu/sYLuD5s93TT9dJ8YmR0OCxU09+qvDqwh2GwKp69lb?=
 =?us-ascii?Q?aT+YRkqlPgAKV/kEsBydRLZJJQGnD9B3R6Q16UV+ZL8hZg/Vh/SA/PfGi/Sf?=
 =?us-ascii?Q?kFGHIL90pMa132LPak32FGRQ7uomwzl+kJRaSuwb1DNaAn8ArE3VJ75RMtbw?=
 =?us-ascii?Q?ftTzO9cjuovQh2lhFn09sk/hpZQF5WjEcouFroVCuVUse7JcTJK62VFwGR0c?=
 =?us-ascii?Q?3f0mu2wOim80w6o52NS9ASRYTsJnz+rtSkYxFs3bXro88kKmCjV1N7KCTYgK?=
 =?us-ascii?Q?rAi8FamlfRvdGUttlb/JjTNAsXjqM6P2W8Bu/Z74TTADFPS+K+//wST+ozw9?=
 =?us-ascii?Q?OCrVeYcPm7qenlutDwEZfuFCtJU1uOVESMlh3u4YFxYtHNEV7Z9dpGflUNBq?=
 =?us-ascii?Q?w0o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gft+7eidGDZHxLJBw5faqSWqNBXh7tOXvWlqJTmMexPQYJueoEPMi+0HEjdY?=
 =?us-ascii?Q?BHR0gD7Z6lPIUKoAWetsY3uBKQMDdPuP6KE6R5M0rHf+5+hOILr/oQCo781d?=
 =?us-ascii?Q?AZ1hf22n9lHmO3wSaOHPeoipaVHJ6YLnZlFhbm8Jtaw1u2aTZ9Ye+B1d0hrq?=
 =?us-ascii?Q?RWi4YN3XSqbqyqV9tAukc8vVc/3lB3vQPqGfwNBRIvAPp6UfnCKgo7klRMnE?=
 =?us-ascii?Q?yFV2eAKRrHAYVUhORhGBYGZs2xvk18CwH1qGiMevZh2eqAaP82Cn6RSNQz5z?=
 =?us-ascii?Q?1JkFX0VjLbC+lP9Q3sPUVmGPPO/qat3jiwyCcxHXMdTSqgvzOxItEdme0FRM?=
 =?us-ascii?Q?SEYGgorkTlO5DBR+3XiPD2zjz1yyBTFT0BLC5RABLitMJ4qT4nHYUCirGxMF?=
 =?us-ascii?Q?9IpYJYmFUG47pQIfdmbAn9zLUHCRjut/aQ2E7BedPsUFSoyBrZPfWiRwiGPy?=
 =?us-ascii?Q?iP3iLBJmFSoAg2HAwfQbCDuICtJ8Mq1w3u/ShASOPaOtmnydMvyvVQQAIbDk?=
 =?us-ascii?Q?yTen76LjIfMYNrqDYtwkz60Tm46chHKQ+tVM2vlACvEEDNQH6kKTvZhh+2Fq?=
 =?us-ascii?Q?2MxQEbhldb4JUc9XKot2FKXQffla+yPU4gnhMYl/afrdEhajXx5DVkUo/XFy?=
 =?us-ascii?Q?T7085Y2C0WusJSd0XtYP5raae18FViAMQpaSBv4xuehrqyJkxzVdySM+VSI8?=
 =?us-ascii?Q?WZWP6d8/nHNCq4viYLBrRgao/BXVchafJ7XhRKIY9ouclb3KW/E3bBarYm9T?=
 =?us-ascii?Q?faYpcaFrBn3Dg+R/7arzWmBJ2p+zJrdAffHgHQNQRFU36jd/MFts93cyFrph?=
 =?us-ascii?Q?vOU0EcN29zv48I32c0kzceft0Cv201zTrqbGC8+O000a3c7NnrOfHh8xGnTx?=
 =?us-ascii?Q?jhdvpXoB0ekLX/L2pbyJp9ZmBj6AhZ5K7W4gPzVNwofB3ZKryI9KrX5Ftu2O?=
 =?us-ascii?Q?dLg4YxACt9g5wSUr/gGa/AyQdG7LLQKrhoTiYDvTG2nmQj7X59O+AAdIgoBG?=
 =?us-ascii?Q?PM5yGvP2ZCNRGQmNqhPIcBFCTp6IyLGIMHndfTJWPd+5ztjiiTKUKDKVSOnd?=
 =?us-ascii?Q?XVkwpyNMR6v9mSzBWC+VWsX6aj7I/m+QBZJ1h6pgjVAaA6O+itchugsSpGai?=
 =?us-ascii?Q?U8+gkktq0Og3Ga5Z2e7rDB7KkU0mTA6Pu2vubMaS+Xr9jedozEDAsuhm/rn5?=
 =?us-ascii?Q?YfZHJUM260ZCuHuUn+uq3OA2MWO2rjdVH+mWwEc8Z71wywI/mhuKcu3I+7E+?=
 =?us-ascii?Q?DW/uyQN4WHruCadPYLKNVzB8M07GAPZlWZiIdcN4HHL+0LbRAk+WYuY4VRf4?=
 =?us-ascii?Q?pWhiE98AdtuKP1c9eoRm3Rpd3NOaJvP+UG+opuJx11iFYA3ssD2j7712Rw1U?=
 =?us-ascii?Q?zUiuuK48txnTr0YK/DRaU0wrQxGw1YRJIslTabG5u1u9fJoHW6jJ1GTWg6+Q?=
 =?us-ascii?Q?vTI5gw/tYSmsmzTWbnWVy+ukISNlrLKqZ1QuJ/Cn6pRUQcALkwbNKhqXnF2t?=
 =?us-ascii?Q?PIdX8BCmasu84Q708jHNzsBD+L2dNI8ACdwsww9FUzwFCaRKgjZYQEpIQstc?=
 =?us-ascii?Q?EYnuLWSz1kGexl7CQHY1dLUnluNYc+NDDZdszHio?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	2jvj5X5sO0xM5fcP14CkJbHLQY0r4EtQJVdw/3AxNYyCiEGOTzgrSH6OH5AzYWpH7GQ+ykkt+MBzi/aB2oZgdW5XIZil/hkBo+Nacq0P79iutFyYI9ttu3kqWcSYP+40Txb5oC2tu0Osbo51/lJjJbq0aDgpIVDOc4/nPAGVMYo3vb3qME3e9NEa2G4N2D7S8bvIYBUTe8mwD7O92fHEF5GJR34yEn4fqpwGnXVSi9H4njRjggbCQzKsrCWUF9EkjxDI0IYRJg0fUN/s3V1u74r3G8LlroM5glwpr9hwbbujpSLI0Z6M269dqLyyvK263GTKyuvVA2ufCZ5RtNayKSTcbGTrKRsmOtFIJ+eKt6yEhOD3TjXMRKs/ON9x0CQ9Acaw8gEv8Q4YgugVWFGzv3HBD9bkqIHiVgO9sww8KrHDSulP3wlGmkJoNW1imA5ZqFiWoP7QEBLnTna5k2Rhac6k8Qxozf5ev5eyp7Ved75JpM1w+qqgDee2XkAl6PS3nm/4lpW6x8L2Bg49Gdn+c3F1i/PwR+oAblbZaG9f75DfWgtmN5IknIayJLXAS87Rb86WGjb1S1PrEZ7T1VeJjKRDedNYeWoD5uVneatUKMw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98d972bd-ad3c-43d9-f2b0-08dcc5dd3b29
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 14:41:55.2808
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvlMXZz5lw8iK8vzdFlz7GISbLl/crOUwlWRsuElODEkCEWgbQFl3dV9d/oAD+xVD5JS0IDl/YEIR7fvJ2PIiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB5987
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-26_11,2024-08-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408260112
X-Proofpoint-GUID: BXJ3MTtc_EkVoHC95FI9DfdAJYElnNn0
X-Proofpoint-ORIG-GUID: BXJ3MTtc_EkVoHC95FI9DfdAJYElnNn0

* Naresh Kamboju <naresh.kamboju@linaro.org> [240826 08:37]:
> The arm tinyconfig and allnoconfig builds failed on today's Linux next-20240826
> due to following build warnings / errors.

Thanks for the report.

> 
> first seen on next-20240826.
>   Good: next-20240823
>   BAD:  next-20240826
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> 
> build log:
> --------
> 
> In file included from mm/internal.h:22,
>                  from mm/filemap.c:52:
> mm/vma.h: In function 'init_vma_munmap':
> mm/vma.h:184:26: error: 'USER_PGTABLES_CEILING' undeclared (first use
> in this function)
>   184 |         vms->unmap_end = USER_PGTABLES_CEILING;
>       |                          ^~~~~~~~~~~~~~~~~~~~~
> mm/vma.h:184:26: note: each undeclared identifier is reported only
> once for each function it appears in
> make[4]: *** [scripts/Makefile.build:244: mm/filemap.o] Error 1
> In file included from mm/internal.h:22,
>                  from mm/oom_kill.c:50:
> mm/vma.h: In function 'init_vma_munmap':
> mm/vma.h:184:26: error: 'USER_PGTABLES_CEILING' undeclared (first use
> in this function)
>   184 |         vms->unmap_end = USER_PGTABLES_CEILING;
>       |                          ^~~~~~~~~~~~~~~~~~~~~

Please see [1].

[1]. https://lore.kernel.org/all/7d0ea994-f750-49c5-b392-ae7117369cf3@lucifer.local/

> 
> Build Log links,
> --------
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240826/testrun/24951924/suite/build/test/gcc-13-tinyconfig/log
> 
> Build failed comparison:
>  - https://qa-reports.linaro.org/lkft/linux-next-master/build/next-20240826/testrun/24951940/suite/build/test/clang-18-tinyconfig/history/
> 
> metadata:
> ----
>   git describe: next-20240826
>   git repo: https://gitlab.com/Linaro/lkft/mirrors/next/linux-next
>   git sha: 1ca4237ad9ce29b0c66fe87862f1da54ac56a1e8
>   kernel config:
> https://storage.tuxsuite.com/public/linaro/lkft/builds/2lC5HukjOlVYM52f7n4rm8EXOLG/config
>   build url: https://storage.tuxsuite.com/public/linaro/lkft/builds/2lC5HukjOlVYM52f7n4rm8EXOLG/
>   toolchain: clang-18 and gcc-13
>   config: tinyconfig and allnoconfig
> 
> Steps to reproduce:
> ---------
>  - tuxmake --runtime podman --target-arch arm --toolchain gcc-13
> --kconfig tinyconfig
> 
> --
> Linaro LKFT
> https://lkft.linaro.org

