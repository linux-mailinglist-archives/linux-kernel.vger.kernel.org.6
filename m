Return-Path: <linux-kernel+bounces-398913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5740B9BF7E1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 21:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9CA2B22A33
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Nov 2024 20:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BBE20C012;
	Wed,  6 Nov 2024 20:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BUEdI30V";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="S/ll8L9b"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609B520BB55
	for <linux-kernel@vger.kernel.org>; Wed,  6 Nov 2024 20:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730924344; cv=fail; b=oklO06/KyxFySmWOwBK/cWegGYW/gRwBTe76gbnpzI+mWR4M0BcjRbsw4Og6RG6WAAUSDF4WrjnC8ZVZSQcEPsyf5KG21yW2SFoDk2h/AZLfg9/JzApieaI7QNvKZtaesYETrXTJFmCTaIhdah69a69E62Tajuih/p2XjNbwQIE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730924344; c=relaxed/simple;
	bh=toR+bl5Qq7yfvtID2hgsQR98EUl89J8AuDRcftuC+Xc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PjxEmV7Siezp5cShSzplBieaIKCW249/Q7kv83xVvxE0JE38RlMBqYW9PlvJjKmFcI+3p8NOUxLhc6N3Nu1jtvd/txGtZmPZaEd2yCpb4UHBkddEovcd4wH4dPsUniF2K/n+UiOKPr/LpFa+lrLNXVfrYVSxjqRLoNBAHa/82gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BUEdI30V; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=S/ll8L9b; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6JXWi0023148;
	Wed, 6 Nov 2024 20:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=qFWAOT83sccsIUzYCey1DvxJ5ag5g5q6b7wWaxbW3uQ=; b=
	BUEdI30VasM7Dg8LNBtoSZlV0yw0zB41/C9k0nQ3VKghmsnT2QgmeQeJH0zHzEd8
	pmpYCrWENLTF1QYjug2D9OraBILNKqgeGWrYyv12FXKec00VJNXIfKyiPV4RbSis
	YmT3mYk/iNPoIa2hb+DgpR7rK7NzgnS2xO7sDOeOo6HDY0Kmsc256nD7mc8MxKz+
	vbP3nLkR3VMtjM2f+KWzib2E1bTSt5G9oxiUmuMvriZufYNwghGAeDnn0ElZ+TgR
	FISFr1AOEISNlcW342iRI4pVSD/R0usdf4XUVuJoPs2Sjem9RawcZKYKfQ/GTHW5
	gwxsDDn7u8u6CBYpVAjIMQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nbpss0vy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 20:18:32 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6ItHS6008469;
	Wed, 6 Nov 2024 20:18:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nah91n0d-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 06 Nov 2024 20:18:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FUssV1xNvhv9E/H95M1BUm9Fm1hmEIte1VuH8I+0qd2ZAOAdokvkkWupI19fEg7jemVfJNz+ieeTkfJS3skCWra/sJkOy70cA0m2LuXvFTd/umegNe1ciGtuppDtWJsYNPw8SMG548A1J/CXyQ6WRm27EtC/chGQ1148jrOU5b1vsNo4ADrOh5Eq6r+2UOaFBkfg+C7JgGGUpBP30HBA9TG87kdK+Yzdbmd1da79FNXMZLpekyl4vcxQxXJx71QVlkpsmCn42DW2K4SJjA+hsImj2ZqbeTFjimSXITrVkrl3NmdomqhQfJgOV0AY+rWMl1AFGoiHLKrsBu12tZE5XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qFWAOT83sccsIUzYCey1DvxJ5ag5g5q6b7wWaxbW3uQ=;
 b=sWxISgxOCm70hsCydgTeYwtv1CFtw+FSBcRJbgQbaRJ0+1DBrWyH9sD00qomFnc+Kv9p6LcDGBmj9ZF4l3b/k0B1F1+wreFchALhNOfbvyiMa0B3iIKjU9ouBgWhO8ninARlyxytsPh2z4Dc3yp7+6HS8NH2vR38wwl3TckTsmdhdfX3RVkAuNF6WNwDmcn83ge4VEWuE7EKUZSqJryZZCZvp9w4jlTCqikFXH0oFsWr+nRwGlcPCeAxIWjlcWE3F9/TLN8plaONZ9XKwjc1SPrjsEr8kj1+iqGu3A9Sjhd+s4oqdiAKbAlvf9YpxtYSvJ/K5s0VXRSbib2BuF2n7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qFWAOT83sccsIUzYCey1DvxJ5ag5g5q6b7wWaxbW3uQ=;
 b=S/ll8L9bzXLr/h5vvETpH2fa5tj6g+ndNdyhGJ4SgcUmE2FmUa1T+JmzHkofNkJVHqeusVcLEQWlQLEgrSVwYprOXSdfGuXR8ltIULjhW5WpF7Du6NFFxwBbTGbo2UZ71D9vTMEkBzmGoFxDyEUhnbTF4XHgsrVQXBJ2nRdlulE=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by LV3PR10MB8107.namprd10.prod.outlook.com (2603:10b6:408:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.18; Wed, 6 Nov
 2024 20:18:15 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%5]) with mapi id 15.20.8137.018; Wed, 6 Nov 2024
 20:18:15 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, ankur.a.arora@oracle.com,
        efault@gmx.de, sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: [PATCH v2 4/6] rcu: handle quiescent states for PREEMPT_RCU=n, PREEMPT_COUNT=y
Date: Wed,  6 Nov 2024 12:17:56 -0800
Message-Id: <20241106201758.428310-5-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241106201758.428310-1-ankur.a.arora@oracle.com>
References: <20241106201758.428310-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0148.namprd03.prod.outlook.com
 (2603:10b6:303:8c::33) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|LV3PR10MB8107:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e18ab48-a2e3-4403-4a2b-08dcfea0253d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+FVW7etgRK+bAkfbC6mdm1VMeVzK0kQbPuHsIco4B3QEiXtnyNRbMZG6G9xa?=
 =?us-ascii?Q?N8kX84m0rwAiddXK4kl/f+2wdCjLyZvih3+5Ba6a30Gj7cqDwZubSHsPi+PL?=
 =?us-ascii?Q?thYz6Fso7+/g9JdnEajV3VznezzgM9fBNqgX11yK3uvv7C/qS2EwN2G0PODY?=
 =?us-ascii?Q?D2qvM6HuYwl06zh2e2rz4GcKiUA/Nl6ftcy0QHykRAYHv/cnuNTIOuF5pad3?=
 =?us-ascii?Q?FfiIceHZIpgdjvN5rhjDJcD8S7nv3qlHySZiGnRXC2Wk2/RlHLyb5VDg5le+?=
 =?us-ascii?Q?b6HqdyrTy7IU6bNNLPj9CE5AqnYId6rSxkUJA3eM1eHoe3Gs0IMGnvjLoDTu?=
 =?us-ascii?Q?8w2ivgx0bGoWr/+nsh61OKoJ0ILAMOnoYzzGljswlbCtHeCfT80Q1Ulh/tcI?=
 =?us-ascii?Q?Zd4Aery64LT+ZGN6NAeFAe51h+qv6zmb48uZKudIcId5OfPEjsHpVGe5Dwla?=
 =?us-ascii?Q?WBv+2ZbY332ku3tP80Z+9So+IIYKAmWXtk1NfqlMN6hcg1l8QnNPTEU4ANa9?=
 =?us-ascii?Q?ogQ1ICQ88sB7vqk4UaZzFycxzO+EjxfOgM8LEQj7iqSVhPcBbcJKI3VKSOpk?=
 =?us-ascii?Q?lMQD6p+vlm0276uKpnjaJQFn2WOXGcj7K2hyhPktcQ/rbyTp4tiN2NK1OCqJ?=
 =?us-ascii?Q?dF42/sRRwHcAL5yt3avmlF20Fxlm6rYEDu5Tz3j2+LFmvczJYQJIIfuTDTVF?=
 =?us-ascii?Q?japaZfCKe/M+oq7U/MZ2F8H4eYsWplJmR7w6lf9XsWXfYK824QH3dpCl0joj?=
 =?us-ascii?Q?75UzJVV+HlRt+rF3oFWebTqoP5S1WQBUb8WtuGROl6WhMcdutbgTJQJ4GXMG?=
 =?us-ascii?Q?vALWXMMF9bx5O+XZmkXdG/jGYPf2Yd5TxGaxZRvqBjemd47XrNctfYldkS7p?=
 =?us-ascii?Q?tcROu59SgCvObW08KJKHzJ/NYrwpmYiK2MfAbRiYBymgHNISqtgprgwpkgHL?=
 =?us-ascii?Q?qMkYJ0/fgSpJFFUZP11TX/2VSgUSC5vJ/+MoAGGtbmMFIwyEbY+Jou+J73z+?=
 =?us-ascii?Q?xW4ZgumoCprdy7+99Q8U0Nl36zjxL0/xqJIGZjuyJPQPFbDrtmmEoYBXdfEn?=
 =?us-ascii?Q?kVQG/PbS9GFyA1nxxVOZ7rpeGz4T0ieR+pnk/J8k/TULC1/bEFNbhlWSwkUz?=
 =?us-ascii?Q?KT9/MctNl1o/wFErlmPlW2lhbee9bI14II9o/juQRKGB02GtTJWDqiu+yHRC?=
 =?us-ascii?Q?w5R3HcfUujj7lehjzkc4DKLJpga5uodMSIVKsVimA5INRRluVy+shVO1jW/t?=
 =?us-ascii?Q?BnDEf8RqABZJ6d3OmQd4TQ0D+JQvZBX5jQte06HbT+hIAL0EG4SEub0YaO6D?=
 =?us-ascii?Q?sSGL8vqu7G/jun3hTh6NzCnx?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3wptHjotRdBvlF1xuREbfKYUbHIwtDfPEjh3Mw25xHmAGdi1zm3n4jNy+jD8?=
 =?us-ascii?Q?X5jk/8N+ATITaOCTsYI4DTiPfkvRhE8m9tUJWg6SUv1A105nZdsVFXoohAZp?=
 =?us-ascii?Q?7iZa145RiKkPUn60SWGhZkiHLVoR0EGtAacs16mIw0E9YYgbyyZDOSQgfpd0?=
 =?us-ascii?Q?FraNQbm3tokLM2ko/jLyJLPePSkWhVovZvTkNQofVYjl5PMTyYa89S6MYw0k?=
 =?us-ascii?Q?3UaHay6dXTNg6e42tgflhAxmAsOrk8yU2GJNzBADZEkr2t8dwrhdZ5AdjkwC?=
 =?us-ascii?Q?MOUYKK9NNQaH2M5uPf8ebsjzEUfx5iOORgXzs8O7vSFatZD/jsRDuHlZhMtd?=
 =?us-ascii?Q?R5Jpl18VBJDe6XlGytDXraOJBu4d7IvdikmTzd1VPchirxrLWjsjCDZ1egfe?=
 =?us-ascii?Q?4YGX72o1JAtIz3KLaTkUItbHKkhOHDrU91G+Z3qtp0S8MDFUhcK3wWGN/DK6?=
 =?us-ascii?Q?vXs2BTjW0Dk8EhHQAstPVZ0RaO/21hnL89HDYWVBTX0w/X55DoBSV+SYmXD+?=
 =?us-ascii?Q?8/xfNzwZa6wKC+rorfI4o3x96WNaCvgm+byF7/vlQSjsHz9pmJGp0MAQN06N?=
 =?us-ascii?Q?r0mslXs59tXM1XDYgxNfgJ6daEhovQ3Mq7CdeHn0Iaq9bzoGf0F+e8sS+6pZ?=
 =?us-ascii?Q?PLBiywNtBUuG2TcyRwg9l3w8jqMe9e/J3zjNiEgx+AyptxOauwxPgzsMv0mq?=
 =?us-ascii?Q?uWtutiqZFKTLY0YH2UdPfMEb6L9JmQMPF0bFXW4UiHLHRiK28LSEssvmT/aL?=
 =?us-ascii?Q?RPvKiStPDdJ17T+Zqz15DYOWAsa5cAfAWiR8qtDrKAMkv4RBcf+1jCIUyuWl?=
 =?us-ascii?Q?Iebag21OykPX56S6VbAW8UBH7X+U538IMZg9FjWxrOMmMPp7/V+0Gg1I5GFN?=
 =?us-ascii?Q?n89S1QBooeXL70zqFF5/QbTeKgf6XA8Ik9GC2fN3hFqqYOiy8lMHzw5v64mm?=
 =?us-ascii?Q?5fH11cnVEJNAQ9WHloUNpue7k6yItcRAznVvtF55KzPWnwSbBmctvniP9ow4?=
 =?us-ascii?Q?L7SugueCai/JyxHliqx+fGH562xvPUmzc6DiGHZB74G0r+2g/GKJg0yqTtuz?=
 =?us-ascii?Q?pq05p9d1SMVE93fO6McAiyp99FHQcVMQXPahW62lukBM800lx14Jn9t+RtQC?=
 =?us-ascii?Q?eFsZ8qaFdYN/FSW59amlyntz/Er29RjW4HSkIkIjQZ9iQlqrsNdKnsmk6wn1?=
 =?us-ascii?Q?Exwm6cNmMM8KblWYp1p2/A1eDqAMduX36M12/5pltqDLlnWLN8P4LMH19RJJ?=
 =?us-ascii?Q?rwPaHV6KyeQP3Oc0dCNLH4XKBHx2VBPLiN4kbEmanh3Yvl+biOeF8xjkkIGy?=
 =?us-ascii?Q?ySdQNgK7CUodQUk+884t+i8jNxb+wX8wzuP8dONDnFyL3wptIN5nrsyzm2++?=
 =?us-ascii?Q?H21a4NqwJOpRDXOwPD4TmcyImi5/erSqj+Xfy+HhELLZiF5qHLHOx6sLZXeR?=
 =?us-ascii?Q?O9NCnG11zR7CrufmRVFHAqn1fPkr2sxDIUl8lsCmeJGa9uy72LG6Mo0B3NM4?=
 =?us-ascii?Q?Dl4LOQ4ybFGhtwgMVmujiKiipP5En5c1t8UDx/ps906Z1vmJMuOtxQ/sGwab?=
 =?us-ascii?Q?d0iBwRjHrKH5+OQ+75zxgkNMqBAPIdOSdTX70nDt/FnxRn0jdkF2tKO76EcN?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	8jdazl+Ry0HOErweckLuSlmyg5WBl80OsAnfGDeT4/80oBnq0kviS6EDsEbpdL7wnURKLK9c0koNo/rB+eX3tikHxxQSO8DrTMWS8HJWuPyb3vklgHFiaaYwKzaTqGazPuRS6JMCorlu9d1vXrqpkmz7CGW3WxoIkW7v95u9X0gexDmrAkRg/lqkjf3NoIvY9aYsNd2phMxpPPaD53authJ/+Ngex1xF+VtMUQugxxSFi6TQTeZUd7oX2GTOSIvlIhqLkRoBVky2VbHuWVsL/rwAb6NR/L4kUlU3waOg1+6lNNCnmBEBl6n/HqJU+jy4QjEoY0LE9rvU2jdbJY+VfdynMgKZLf4KfE4mb9IafgDMEg8X3JaqefOhK0dcDvnDyq3ojAcCfO3/ZPkKtRKwU722wkl408x40+a+kZ7Y7amz3zOajbAQblMoRWX2iZcm3WSwfcHE5tp58doi/tzmEQSTF4oNcxto1qK+DqeH2r4JTRfwG0CoWL6PlDA4w0SlHbvMiJggicaUU5jX6aP4CzixTqZbgu+Yx77nvV2t+Nno3IG3MMQVBSscKcknFH/xdl204Ib027b+z0RkDKOgZCq2p55ZZnxJSKL//08d0hs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e18ab48-a2e3-4403-4a2b-08dcfea0253d
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2024 20:18:15.4624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hAT6LDYpbXNT5CVENHU+1RfUkF9XoXULfvBHrF6l1LB5U+T8ZSaoPrRk+mR0VKBoEepbfgqktBTrH7XVEyjjXO6EWkkpjCS9cFboMARl0p8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8107
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-06_13,2024-11-06_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0 spamscore=0
 adultscore=0 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411060155
X-Proofpoint-ORIG-GUID: WHItWugsbgbrzpbpNHnfJQO6hZQBVZE0
X-Proofpoint-GUID: WHItWugsbgbrzpbpNHnfJQO6hZQBVZE0

With PREEMPT_RCU=n, cond_resched() provides urgently needed quiescent
states for read-side critical sections via rcu_all_qs().
One reason why this was needed, was lacking preempt-count, the tick
handler has no way of knowing whether it is executing in a read-side
critical section or not.

With PREEMPT_LAZY=y, there can be configurations with PREEMPT_COUNT=y,
PREEMPT_RCU=n, where cond_resched() is a stub that does not provide
quiescent states via rcu_all_qs().

So, use the availability of preempt_count() to report quiescent states
in rcu_flavor_sched_clock_irq().

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/rcu/tree_plugin.h | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 1c7cbd145d5e..da324d66034b 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -974,13 +974,16 @@ static void rcu_preempt_check_blocked_tasks(struct rcu_node *rnp)
  */
 static void rcu_flavor_sched_clock_irq(int user)
 {
-	if (user || rcu_is_cpu_rrupt_from_idle()) {
+	if (user || rcu_is_cpu_rrupt_from_idle() ||
+	     (IS_ENABLED(CONFIG_PREEMPT_COUNT) &&
+	      !(preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK)))) {
 
 		/*
 		 * Get here if this CPU took its interrupt from user
-		 * mode or from the idle loop, and if this is not a
-		 * nested interrupt.  In this case, the CPU is in
-		 * a quiescent state, so note it.
+		 * mode, from the idle loop without this being a nested
+		 * interrupt, or while not holding a preempt count (but
+		 * with PREEMPT_COUNT=y. In this case, the CPU is in a
+		 * quiescent state, so note it.
 		 *
 		 * No memory barrier is required here because rcu_qs()
 		 * references only CPU-local variables that other CPUs
-- 
2.43.5


