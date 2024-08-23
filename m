Return-Path: <linux-kernel+bounces-299445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8734695D4B6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 19:52:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A2711F23CC5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 17:52:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDE3190665;
	Fri, 23 Aug 2024 17:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VySAkGup";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="T4BKVapf"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250DD188A1E
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 17:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724435516; cv=fail; b=sv2lIWT7gK4ejSlOQ4OckgDvaoDv3dQus2U8KkfyeMqYxg32KcC5E3QgN+bLwGQ1DGp/7yzX8+S1NjbOZjBGMT/RnytyWlS90BfhmgxSWiRKT7Anb+vcL/6vdE0DBZt6xiWc14oENuMGfEJmdAtgomxvMlsCJnMJbk1w5LkJoFw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724435516; c=relaxed/simple;
	bh=SCu3NWXfc2Do2O47D3KlQpLEoEaKKXHCMoq/2cJ2H4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KMibeySbVVczWwOrCmROooucScmEIkHTSqTgs3GU9ReEVXIkTaWGv1jobppP5Ff0QnJK3tYnqpR/fi8Azzut0kIM8rJmHtBTL7t3BtRqnbUBC6bjqA7bsgsf85RTehDZMibshSZ1F44YL1dL3CH9S2/zfQfLkfs7nhye3nRrRFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VySAkGup; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=T4BKVapf; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47NH0UMs010829;
	Fri, 23 Aug 2024 17:51:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:content-transfer-encoding:in-reply-to:mime-version; s=
	corp-2023-11-20; bh=YkDpvAM/2kCiDJGiaYHyE6BnqUalnHh9gDqxHP3VvJ8=; b=
	VySAkGupEokdfoJuZN3Z6g7LMbW1noIe7gUPj5SNsGFybCVnflplUQDdLj29+X2T
	Oa0Yt3W1Xk3D2rp2lRhYa5oR/0xcFkgvu0E9LprKIsZDfYPa8IxkODC/zoNVtYSR
	8uGb9/2O5xA7UDbnk9SKE7szMbJGJpPVSJPEyOwQnjGkx7MfZSct7Y4s5qb5GHpP
	vYGHLaV+CS6qY2pgqmhF4VLp2UAOMLISkhTRD1P/hyOtnBUrZLdLyPUpO1fjqVAw
	MlXu7jg+cRN1h/pZFB9NNg7MYfuztE+9Ifw/q8k7V1MtRvaV0qWVE+RF0B+C1wFe
	i1QeRQ0iyUmaDfAeTPn1jg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m4v4xxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 17:51:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47NH99pb029752;
	Fri, 23 Aug 2024 17:51:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 416xjusjbt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 17:51:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BksLyPkH1czEBu6MJQLNj4rTb9AW79Th7Pwyq3WG64K6lgOMOOaPDZgb4iK3oPwv79xnnsZGSxSge1zdvRUjh4GUGtn9P48v+Uoohx6UdCAlg1aylkbl8Ac/0J9oYZR4ludrunv76ue2+3cTCSnQVKae4ol3ync+cKj4d1WFJw5Sp9q3ThV0If48l8O3/SeEmkHEtemQiXCHNkP0uXOYjRsp997blIidiyzHfWJFbA+JHVQLnLcptBJxM8WM0YxHMp9c9SlI7bSo3vwShXSGfH3ZPD+ep825bPTc7JALkvj2GTK+7r15XhFoW5eqAoV1crbM+huXB2bJNQ4vW3R4pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YkDpvAM/2kCiDJGiaYHyE6BnqUalnHh9gDqxHP3VvJ8=;
 b=RSIo6C0273OTieLY6UoiJipcfbt53/mn5/WXQ0SwefzAxLElOVIS9m0ai7KYjNQMsbeGyoKGuA8Fdz++fI08QSk9DKJCPT5GO2Kn+2ErZDvITzFFYXPile49mZHA498PO4+fnOcHC3bDcKflWXcMJe/WVj07XNFrlpq7DdCkW5m7dGGZzPfzjjGki9eFaJuFAKP/+Upx4pOZ7STbutJrW4y8qR5vNMC3pGOZ6LtdEdc42gjmZw3yhjOXp3ULIkCAydyrR4ZEDssP3T7dmLRhk8rxYRZxZE0yuwlDrXQojsS0vCGceA/i/YbfdF48U0+V20oacIKJUumchQMSc/MGVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YkDpvAM/2kCiDJGiaYHyE6BnqUalnHh9gDqxHP3VvJ8=;
 b=T4BKVapf6RlFOodEQd3ThXbTzTHjaWAiQim6Ru7gAFYEXS9i8M0nsO84Ia9HlcbBCDlOg78+tFN3as/qqWttYHFnFJrb88JAhoOcb76YChNrzALypCajHczbeS9GHb2bVPkiSTgCClmLv2hsSPNcspyQjXeNd/yEe6bpFvetEPE=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by MN6PR10MB8045.namprd10.prod.outlook.com (2603:10b6:208:4fb::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.9; Fri, 23 Aug
 2024 17:51:30 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7897.014; Fri, 23 Aug 2024
 17:51:30 +0000
Date: Fri, 23 Aug 2024 13:51:28 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Hao Li <haoli.tcs@gmail.com>
Cc: Peng Zhang <zhangpeng.00@bytedance.com>, akpm@linux-foundation.org,
        maple-tree@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] maple_tree: simplify mas_wr_node_walk for improved
 readability
Message-ID: <k7mse2jyysazfayjayamr75dxtsjx3dbgvci65jhaaiye2l7qi@hwwvinj2mgoa>
References: <20240823081729.GA23434@systemsresearch.io>
 <8f98e3e8-b6c4-4888-bfc7-204bea32004b@bytedance.com>
 <20240823093824.GA566@systemsresearch.io>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20240823093824.GA566@systemsresearch.io>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0110.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::19) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|MN6PR10MB8045:EE_
X-MS-Office365-Filtering-Correlation-Id: 41d57270-2ab2-4b37-3484-08dcc39c37e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1NTTENvMXd5THQ0dWdXMFZVWE5RaGxuNS9iNlJueW5HRjJ3NDNPeDgzTGdt?=
 =?utf-8?B?cXY5Zm9vVzZqYUt2STl5Wk9XMlRzK1E2UFczcVF2NTh4V1RpZ0k5dkJWc1Mw?=
 =?utf-8?B?OUdjc1M4Y2RQSEE4K1RjMjgvYjA5djBRN3pmK2RPNFE2ZDRFeVpUaFJMSEhX?=
 =?utf-8?B?L2w5NzZ5ei91NllZSUMrampoU3lqVFMzenM3TGdHa3pyMG1XL3lBMFd6S21F?=
 =?utf-8?B?ZmZFcXovdWZJUE1SSUY4MkEzM0pOYTZZNGNVZGNKR1ZpL0MxMEVMQkFXMS9z?=
 =?utf-8?B?aW01SU5sK3plSTlKN3N6cjlob2F6Sit1UjVQYzMycWo1UDhXR054b1lqckRL?=
 =?utf-8?B?YVdhUEhHalRBa0kwelZlVFNFSVcyUFRLaEpDSWpLOTlMcStrR0tVWDJYdjNS?=
 =?utf-8?B?R1owZDlWMHRJNmltYTFsblpBSXNaTFltY1Mxb2U0TDhEMEpheVF5ZTJ4UHFD?=
 =?utf-8?B?THJMVFI1WFBKU0FBd3A1TGsrWDRvVmVOTWVDVUxrT3kydXVYeEExS0Y1OEc0?=
 =?utf-8?B?dGNhS3ZZeFZwMVJ4MENKOCs5NDMrbzRLUU5nU1lmTG93TGFWeW1qd3F5SFkx?=
 =?utf-8?B?bzdOODcwcWE1dHRsQ2d1ekJWVW5UbkpTZmpKQ2Ruald1bHR1RmorZmZnSXh6?=
 =?utf-8?B?Wnp4dWN4Tzc3Ykx5WTRDbzFuN2hOZXVrbDgyeitoQXBXdmw1WGdBTTg3bjMw?=
 =?utf-8?B?ejBQc0FlbmNUVDNQRTlPeXQvemMyaktHbGwxWU9udGtLOG8zK3RiaHQwK1lO?=
 =?utf-8?B?RkVhMkJZTnkvK2tXSElBWmR1alFndEhYc3RBaVdqRVVteUMwdlZHUFhETDVI?=
 =?utf-8?B?THpQL3VqbUQ4R3V6Uno0dG5DRHVJUkxwbTlqSDlWcVh6M2xaSmlnZ0psKzJL?=
 =?utf-8?B?Mkp2b0JlZFM4QllhTm9kQ3BMOWNlb2NJVThuWU1oVGROUnl3ZWlkaXFFOENh?=
 =?utf-8?B?dHl4RkpnL2c3VzVlSmMrQ3FwUzFVU2FmWjRCYW4yQ3U4SG0yU3ZuWWk2di9K?=
 =?utf-8?B?ckpzRHQ4bVZrM0FvZEk4cmJSYmkrckdDZDJlblpVUERyMytwRko0QmdENW81?=
 =?utf-8?B?azhOY2xrdFJJOUpxc3IwOWJVR01GbmQrazcvQVNGQ0VCajdPMm5GVWV1ZGNo?=
 =?utf-8?B?Mm1QYWU1UFE2T2lxdGxIZ1h6Yy84eTE0UVl5VU5aUUNLOGp0YzZJWFVlY0Fj?=
 =?utf-8?B?azk1SWhoZ1htOEZnellYcXlBdUJFM1F5aEYwRTdqMmZ5alFUMzhUbjNER29l?=
 =?utf-8?B?WnRrZGlmUFZBNXJ5WDBMQXl5TG51eXpoc0VhaDNNUEhtcStQT3hsOHI1aGxt?=
 =?utf-8?B?RDRnaUExTVk3T1hlUFp6eVBZRXh5UWZmT3kwZ245YjUvcWZkRUJoenZJWjZa?=
 =?utf-8?B?MVdTMzhLN3RrUzdFOXhCMkZYeVRZSlJieE9pNlNsWWxqSGVwMVJOVXZhWGlK?=
 =?utf-8?B?L0Z5QnhGaGM5VWlYWEw1aFBtc2RpNG9qWFZMaXc2OCtTbjl6MVNyb1QrVmFz?=
 =?utf-8?B?ZlhKQ0hyUGx6NTRLL2RRRXVHYzhaT3VrZWxtb0tBTGxwTmJCMW15eStJUFds?=
 =?utf-8?B?ODB1MWhCRVoxZCtaSGJmcHFmTE9zSGVxbGoyNVZuSXZlOGFRNnYyWGtYNzhj?=
 =?utf-8?B?TytDdUd3WGFqK1psSVRhMGhYSEFIZTVDTE5aZjRtcTgzNGNJY1g1Q2tXNThK?=
 =?utf-8?B?dWxZMDRpZS9JYnFXeHNvY01FVmRIakJLeVpmT1pFTFo0TUgxTkRacFJ2WTVo?=
 =?utf-8?B?OVo0RitXMFdIdmw3YWE1ZFpVYWlySk5rK1lvUlBPZW0rRGg4bDlvdmNwTnho?=
 =?utf-8?B?V1NHZjJPMEpXckJKRDhYQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yy9GRkVPNXVBc1NWcWVhbkQ0dU9yd0lRckxaNnREVEd5S1NnVnBJY0NiOVEr?=
 =?utf-8?B?blNNenFhU3lZWTBvekMzU1Qxa1daa0VzaW1GR2V6Z3FWOGI5eCsyVWl3NGVY?=
 =?utf-8?B?WHkyOEdFTjA1cVIyRDIxV3EwUVIybFRTdTdKaUwyemFYUlA2WS9FdVpyRGZo?=
 =?utf-8?B?QmVVakREd1ZKK2JoSDFyRkQ3clp0cGpWTVV6QW1tdE05U0JmNm5ZTEJ1S2Mz?=
 =?utf-8?B?OXord3ljc0JjQjlaQjl2NkluUDlTMmxzT0dlbjR0RHFXdlhnYkh4K3ZmbGF1?=
 =?utf-8?B?T3BSeWZXWmF4L25YNWdwVXd6dUxvU1gxWjBZSzJTcEFKMzNXaXl6V3hCRDlm?=
 =?utf-8?B?M1BkbWgxeGhQMG5NZXNyNkhCZFpZVkVGWExpSjgrejB2eGk4eE02QWx4YkFQ?=
 =?utf-8?B?WUMrZU0xSXN3VG45SHY2MGNwYjUyMVBKcm1DU2c5YktEYVJzSm0wZUQ4bWk0?=
 =?utf-8?B?L3VuTmF1KzJPWWpGVFc3S0h4ZHRMZ1VxY1FmUGdmQ0k0ZmF0STJEL2JhMzBQ?=
 =?utf-8?B?c3B2Yi9ITjNQWXJMdHA4MlhKNW1QWU50QWhQT1dtQVVCa1g5RGVPbzg5RkJP?=
 =?utf-8?B?VVl4YWhYR2pDTExYaHFqZTZtMlZ2VlVWWThUaVI2RmdXTklmbkRueTQvb2VP?=
 =?utf-8?B?NjJnMzRSb1Z2Z2xlL0R1UzhlbktOOXh4anBZTFYvZC83ODlrS1djVWlYbi80?=
 =?utf-8?B?b3RsVXVYdzF4bURQM0RDNDNDYzF0WThrU0pua2FiMUZvc0pKQUxiSDM2M2VC?=
 =?utf-8?B?YXZlNWdYT1I0bFV3NU8wa2dEYXhzeGsyem9qZXpJRTUzSHBFbm8zTmVZUmNy?=
 =?utf-8?B?ek1JS3hJQS9BRmpjS25CcmtEc0plT1FRaWt5dkN6QkJFSU52dXRmTDg5RGR5?=
 =?utf-8?B?MCtiam5Lb1Z5b2hseklnWG5RQTNUcE9FV2dFZlNBWEswQTJFN1pQNEk4Vjho?=
 =?utf-8?B?dEZ0K0czYjFaZU42dVN1aVZQSy9OcS9KbEkxUUl4WDZFQzZiMTNJZEJ0cGJk?=
 =?utf-8?B?TWFGRWpqbDEzenhaWC8rKzlPb1p4QXdZbHJNY2RaQlNTWWlyOVVvZU9UOWJ2?=
 =?utf-8?B?czEyRjMzdnNTSzA4TmM4RTZPLzJhcXZjSTRmZU5UTVNoL2JyZVpwVWFmbG0v?=
 =?utf-8?B?N1V0QTFDQzRVL1FpYm1MSUU5R29qdmVuN212M2V6bVRSa21VMjRnM3RKMVVY?=
 =?utf-8?B?UVpqQjFKeml0bi9udTJMVkJ2S3lHQkYxYVJxMGdpYldObVJzcVpYMFRSM2lE?=
 =?utf-8?B?SUxZeFo4TjNUdlM1dndUc3Y5UXk1dXExckhWMmlPbkUyTys2V1BDaUFjQ3Y2?=
 =?utf-8?B?VCtuSjc0TXVRb1Y1eHFPNVhmVGtVemtSMmhGbzhzUVZWNFRRcGpTUkc3c0pi?=
 =?utf-8?B?a05Eak1zQWd5K2xoYzJuU2RLMEp2blBCeDcrVWlPaXpNZ1ExRWdMQ2tpazFj?=
 =?utf-8?B?bTl5S3hHSmFrQTd3ZFYwZ25VcExDa2luNUc0a2lLOTV3TElmU09yeTc1ZE5v?=
 =?utf-8?B?Q3QwbHJBM3plcGhjVVo5aFJ4aTZLN3JMSW9lTitJZ0w2OEJFKytLbkljWjdy?=
 =?utf-8?B?VkxyZ0Z6cnlRYTZ5Y09ENWZRVElHcDUrUWJ6YkRlVzJKczAxei9TUHNDZUdH?=
 =?utf-8?B?TE53ZWRlemN4eHh5ZlMxM3htWGpXTlFOVzJxNlVadDJobE9acjFObGUxQlpv?=
 =?utf-8?B?S2FMRFlYdHNOZDYyQlhNWC80RzZ2MzVCYVVhNXptQjZ4U3FMUFNjZWZvcUMx?=
 =?utf-8?B?d2d3aVAxS1BFV2xpYnFidmM4eFFWZTZEUzgyVUU0RUdtSlJ1N3RJWFd6VnVy?=
 =?utf-8?B?TTVMbFFXblFObTNxNWtmSmx2Sml5bXR0WXBPK2xsejVwZWZFN2kyV3REb1Rv?=
 =?utf-8?B?dkFWamJWL3dhVDVzRUZaRmJGVTlremFwSkdSMUlpRTdwc3RteWlMNnJJYnkz?=
 =?utf-8?B?eDEvSUFzMWx1Z3B3OHdhREVYQ0dPdHdhNE5xN0lEWEVyUTNZNW9DNC85QkVI?=
 =?utf-8?B?VHFWOTZvN0VnR091bzhIbXpCd1dHd2JnQUluK2lRQ2NkNWhsTlJHUXhqL09q?=
 =?utf-8?B?NXcyTTFWYmtZMStJalVTc1FJd2t6bUtHWkZEdkxoUUhyd09kS2lTci8ycG9D?=
 =?utf-8?B?dm1PRmF3aVhSWnpaUTUwUGdUbEliZWQvWk56UFUrSnk4NzJySTNpemdsTDBx?=
 =?utf-8?B?OHc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qMlaBVDmnObJqQr/CzNXHRXmNTlx7ugZgASWSogeQquyDtVlbG1xGQvtMwfK5E14Szo8RtV4Gb9mvAmcWDp0mmHGq1BsN1gDpGqYoqfRKSKuiyvI4umaZn2kfB7Xj175z5y3TxuBrdCrOA/S/hPLocN0UAas2Os7sbE0BPWmvGGQO0awrZZcUraVno6uAJ435tJHbeiSGZ10F4vXpyeAnzVaBNgfpu2ao3OtfxtSgnyFzN0pxWdPGgaII2DAufCsQztCZebueLyx1Vt1G7lwyWiN8k3d46tvyiPvclaokoTeCUQDA/HRK3YdMSeo9rfC0aSe/IvxzhyWnM6StXrV+6a+lOnD1Qy7dhNuYuIsRaoHB+OT4rMKvYpf3sBLPs96REoX5pWiRPut04/SOgDtdFz1BP8Yol8PrRZt4osCOFK7mqFr9HlDOFx4bfykiJutUSEI7GtQ32vqcRH7wsujl8DFbloNEf6cSLQ7unOOSgSSlEU5mByO3CzDqcO60WtO3copjyL1gAXm4PEAkdPznlphGhlFP/5I4Ij1aViASaT4/LqIy8pL9l5TtqzVLyTyfywE80QB12B3utFpE9tArODn+r4xVQMsGB0KZEK2zJ0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41d57270-2ab2-4b37-3484-08dcc39c37e2
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 17:51:30.1945
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7d7vrWHsIHWsXm1bdfdAsmH6vncG75UFT88ah74Fu9jEcMlBsyRv5DvK/jO+UYwgsj7wCbzuBQx4wr7RsD1azA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR10MB8045
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_14,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 spamscore=0
 adultscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408230131
X-Proofpoint-ORIG-GUID: T_kF4oFSfpg3pqjHfHLJEgv5sHzVPlPp
X-Proofpoint-GUID: T_kF4oFSfpg3pqjHfHLJEgv5sHzVPlPp

* Hao Li <haoli.tcs@gmail.com> [240823 05:38]:
> On Fri, Aug 23, 2024 at 05:07:31PM +0800, Peng Zhang wrote:
> >=20
> >=20
> > =E5=9C=A8 2024/8/23 16:17, Hao Li =E5=86=99=E9=81=93:
> > > Refactor mas_wr_node_walk to make the code more clear and easier to
> > > understand. The main changes are:

Thank you for your patch, but I don't think this is a good change.

NACK

> > >=20
> > > 1. Replace the forward-iterating loop with a backward-iterating loop.
> > >   This simplifies the logic for determining the correct range
> > >   containing mas->index.
> > I don't think iterating in reverse is a good idea, it makes the code
> > different from everywhere else.
>=20

I also agree with Peng that having one loop go a different way seems
like it's asking for trouble.

> I understand your concern about consistency in iteration direction.
>=20
> While the original code correctly handled all cases, the process wasn't
> as definitive or clear.
>=20
> The new approach unifies the logic by eliminating the need to treat
> `offset >=3D count` as a special case. This results in a more
> straightforward and consistent flow throughout the function, which
> provides a more deterministic and easy-to-follow path through the logic.
> We can more clearly see and understand how we're determining the correct
> range for `mas->index` without having to mentally parse complex
> conditional logic.
>=20
> > >=20
> > > 2. Eliminate the ternary operator.

This is not more clear as one may miss that the loop may not execute at
all. So you eliminated the ternary operator, but have all but hidden the
assignment.  I would rather an if/else for verbosity, but not enough to
reject the patch that added it in the first place.

You also replaced the "unsigned char count" with an "int idx", for some
reason.  It seems like you've rewritten it so it's more clear for you.

> > >=20
> > > The new implementation maintains the same functionality as before, bu=
t
> > > with improved readability. The performance characteristics remain
> > > essentially the same, as we cannot predict which interval mas->index
> > > will fall into.

We do favour the left side of the tree to increase data density, so it
is more likely to find what we are looking for in the lower slots (but
not by a whole lot right now). There will probably be more of this
favouring in the future - minimum span for internal nodes.

BENCH_NODE_STORE went from 8.79, 8.85, 8.79 seconds to 9.68, 9.74, 9.72.
This change is slower.  It may be because you removed all the temporary
variables that avoided dereferencing, so the compiler can't be as smart
about optimisation.  I'm not really interested in finding out why it's
slower as I don't think this is a good change on the grounds of other
reasons stated as well.

Thanks,
Liam

> > >=20
> > > Signed-off-by: Hao Li <haoli.tcs@gmail.com>
> > > ---
> > >   lib/maple_tree.c | 18 ++++++++----------
> > >   1 file changed, 8 insertions(+), 10 deletions(-)
> > >=20
> > > diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> > > index fe1b01b29..0b3eb55d8 100644
> > > --- a/lib/maple_tree.c
> > > +++ b/lib/maple_tree.c
> > > @@ -2203,7 +2203,7 @@ static inline void mas_node_or_none(struct ma_s=
tate *mas,
> > >   static inline void mas_wr_node_walk(struct ma_wr_state *wr_mas)
> > >   {
> > >   	struct ma_state *mas =3D wr_mas->mas;
> > > -	unsigned char count, offset;
> > > +	int idx;
> > >   	if (unlikely(ma_is_dense(wr_mas->type))) {
> > >   		wr_mas->r_max =3D wr_mas->r_min =3D mas->index;
> > > @@ -2213,16 +2213,14 @@ static inline void mas_wr_node_walk(struct ma=
_wr_state *wr_mas)
> > >   	wr_mas->node =3D mas_mn(wr_mas->mas);
> > >   	wr_mas->pivots =3D ma_pivots(wr_mas->node, wr_mas->type);
> > > -	count =3D mas->end =3D ma_data_end(wr_mas->node, wr_mas->type,
> > > +	mas->end =3D ma_data_end(wr_mas->node, wr_mas->type,
> > >   				       wr_mas->pivots, mas->max);
> > > -	offset =3D mas->offset;
> > > -
> > > -	while (offset < count && mas->index > wr_mas->pivots[offset])
> > > -		offset++;
> > > -
> > > -	wr_mas->r_max =3D offset < count ? wr_mas->pivots[offset] : mas->ma=
x;
> > > -	wr_mas->r_min =3D mas_safe_min(mas, wr_mas->pivots, offset);
> > > -	wr_mas->offset_end =3D mas->offset =3D offset;
> > > +	wr_mas->r_max =3D mas->max;
> > > +	idx =3D mas->end - 1;
> > > +	while (idx >=3D mas->offset && wr_mas->pivots[idx] >=3D mas->index)
> > > +		wr_mas->r_max =3D wr_mas->pivots[idx--];
> > > +	wr_mas->offset_end =3D mas->offset =3D idx + 1;
> > > +	wr_mas->r_min =3D mas_safe_min(mas, wr_mas->pivots, mas->offset);
> > >   }
> > >   /*

