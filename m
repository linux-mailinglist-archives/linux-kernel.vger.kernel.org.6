Return-Path: <linux-kernel+bounces-186424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5378CC3FF
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 17:20:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D2A1F233E3
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 15:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AD8356B8C;
	Wed, 22 May 2024 15:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EXJ5H8mu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UQ2+lXbL"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350FD7D088
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 15:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716391206; cv=fail; b=aSoFXZ3KjZHq6otAk4GPaqaR8sqXXSGK0L5j9jVkku3DREHKEwhoFSgT1ELWfMXrS81bEB+SxNKBdmT5acsV7SpjCYP5A0FFqZtFQFt1FkzgtS//ocv15qsYzDPVqnPZF4eJIO8QQIzWW5rWUu9t/o0q/bnW2CgIuNWniDrBd/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716391206; c=relaxed/simple;
	bh=XpjeyKNfKVpb3FsoAemMrlAm/iTwq6el1YpLowHxmFU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=HhmOo8cZZzn3+OIn+WH43vfewlZpi0wwThg1v/NxGGD786ERPckZ8Kc+0yVbQ2UvhwMkYD1bdDVFkq145e13mFlV/hfCoHFK2w+3yNv4QMXbu/NWprJ0Xlgcy0xKb7IaASD1k9r7IS50LZmeQCPiD2qcVH383dRpAn7mwLoxDSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EXJ5H8mu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UQ2+lXbL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44MEo6Q5015315;
	Wed, 22 May 2024 15:19:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2023-11-20;
 bh=t2+K1MeqK0A/m0UBmkFFyXob8l3+vT4GPCihnDAgNbM=;
 b=EXJ5H8muQFGqEmQqeArcS6g2MNUzcNuHULFR3kJHfqeW6sTvGO89nYj1ipX6SUYnEfYD
 0J3DiDOOWlg8MaptmWTKtzdOnMDoTS2FUP/0qT4e0ho52Fa5yAHMaoGC3pf+lW/Q098b
 6Kd/n6KULLrm2MduKwVdq5KLh1xjE+Bxab2EAk6/CiSi4rVQjAfNvpVo8m0bxvZsRHAL
 dLcOY81DlyFjhcmBBhb3PnKaO1IDNEVaT2KFhuF4BmgM9xqhJASUO2OYg9U1BnGJBXIe
 pwG0YQMTsOe6J+y+wOf+JQSjZq1zx8dX7Yv2D5taPSfknqOQEQ/Pzgmm51apNbKdzENL Pg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y6m7b7s2r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 15:19:50 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44MEbctO002592;
	Wed, 22 May 2024 15:19:49 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04lp2041.outbound.protection.outlook.com [104.47.74.41])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3y6js9ayne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 May 2024 15:19:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OdwC6vV+mLHQJWFw8CKgSh0iEMDzN2qjZn61cSvhc12j6X+t07gsEjdPnu7aG/GHHJR+jmCFSWXkX+SaBx7rtgka1+2R4wOc+QvD4KBLzcs3XiSHMxKQeUiXxv3GgRY/IocJdMznTmbANvZbG5Qjg7eXKSH5oZ8mzx/V9iCWeA1fLgr7vkgr9aT8iTfcawbMv1zjDJ3Tl2hLN4BnG7uUpm4UAt2FrTEuHaAkp2D+J5nJ09cE5k8gcngPchKdtPURVvZVEd3S7sfnVz16AydB2RwgiU1KGizS8wlUMCOgQQPDs6l0FwUgtItejtOlvda6P8q7nTPUY+hagSE1qwFFFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t2+K1MeqK0A/m0UBmkFFyXob8l3+vT4GPCihnDAgNbM=;
 b=DAFgre8GlyOEy2/cG02M8lMfdlb4AqtjhM/yuQdDN9D9yWS2lXmyjOlnSkoXc54+ASydKl4Mu6EHeJAX7RRdm0BD21pUvbt4ZndjQReZUP2vs8ss3yhvuq6QntKtp23MRHvqJwnuSlcizFffnxslyLGmCahEShqnjRTIL/mw0oI/GSNxAsr/ggg0BL5B66uqeZ3xsYXgq9lbbXBvFVEEdRBqxjcTtbCb2MKxJT8Imrk1+7xN0/ZLUfDjxq9VoleKLPubTa/nfWhrYz3E2xIsWIUvNUTEyszkuQ2fuCBMXlymYl7gz3zbg2qM8MUM1QgxVo4UEpYu4QO7nTgktXCaEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t2+K1MeqK0A/m0UBmkFFyXob8l3+vT4GPCihnDAgNbM=;
 b=UQ2+lXbLD8C5Q34DbIAQa6CXbrCeey2hVC75eevORulc4OkQUAmO9aNxAKB0sCcg2VfZfnch+LQXgPVGDGN9ZmE/MeRxWU6QR7MsBfqk5xM/d7I2xe/udpzWuPRh/W+XOT4DUXC9kLPEeZtYyPo++oIwvpgs7rEVAsvkiRZJG08=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by CH0PR10MB5081.namprd10.prod.outlook.com (2603:10b6:610:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.19; Wed, 22 May
 2024 15:19:46 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7587.035; Wed, 22 May 2024
 15:19:46 +0000
Date: Wed, 22 May 2024 11:19:45 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: akpm@linux-foundation.org, vbabka@suse.cz, lstoakes@gmail.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: batch unlink_file_vma calls in free_pgd_range
Message-ID: <v4k3u3h5b4xkss3qlltfqnlmobbihzoelqhnmjbhc57jup52wp@csaqg7h45co2>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Mateusz Guzik <mjguzik@gmail.com>, akpm@linux-foundation.org, vbabka@suse.cz, lstoakes@gmail.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20240521234321.359501-1-mjguzik@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240521234321.359501-1-mjguzik@gmail.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT1PR01CA0152.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::31) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|CH0PR10MB5081:EE_
X-MS-Office365-Filtering-Correlation-Id: b3f339fd-e337-4d3b-e271-08dc7a729d5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?nTXX2ajUGN/UPNsx3/fOjloM3Ct9/wYA5fMd592SstJtgB+RcpRjFQb9mU5V?=
 =?us-ascii?Q?BtzHllPs6uUU4H6mLjW+FFQTIZD75TAkG+cR9JDA6LSHKAqZKACgKJdFsjhI?=
 =?us-ascii?Q?LK9f2YcYpo3u4D6xA0P3hoRDL6+LGHS4q0NVcbuVmJRGqEVuhYoaYXR54E2a?=
 =?us-ascii?Q?wV6tZXLB73tIX/KBEYVMWBHH/LjsWoNNtZbOr/1k9WCA/TYxc32BP1hdhij+?=
 =?us-ascii?Q?aypkxaBmtCDzk4eYmxn3vgTQuR+Jx/jcx7w/kp3KP94/XkhJSbFU0iOtC+gx?=
 =?us-ascii?Q?0AxWhYNFzFLtJ9XWSpNbJQN7gVhKABjo9qnRyrXc/B47A89RfJQoQeBEa/n8?=
 =?us-ascii?Q?DMcD9p2P19+Q1kA93bCngZgmNYWcnZTH1TIv+honvnwcbYRW3VahM39/RIzl?=
 =?us-ascii?Q?9l+DnvY3sAcC+aWBOtm9EY/cL9h7qLaVH8Wmf5KPNyCFhRYcEiC2ECgmiyqV?=
 =?us-ascii?Q?IvIv8/aKjI++MLq1YLncAWIvmldwGCi4GPj0Rja/icjq6hMkgscy7oI45L8i?=
 =?us-ascii?Q?nTMAQ+YhDU/8SrYg5flTs4/injZiOVp1hvEoMepo730GbGmwIjjvkNpB8LVj?=
 =?us-ascii?Q?oJCx33lRW9EiIzbDLs1+LbPFz2f4BdCH+4wOvyUl1Up69B1PHn4QNCpT2pXr?=
 =?us-ascii?Q?cVgyLzZ8owxzaxV0VTVPODObFxU+xQjTBqUYRl0qwp0YS4YhE7Z4jNOcdtMV?=
 =?us-ascii?Q?GjyHa+3Pu8sUuT5Eui5pOCtLfVkzr/TFA3lr56gWAVGkYFJMpfyYjgMkzpZg?=
 =?us-ascii?Q?OpEv505Xq+LbVICMIQmVStQgPhX7ql9aVrju3yX3cxXkeQxWDZiPV0Ts/gXf?=
 =?us-ascii?Q?mjrGrPSb8doX9WYponvojVKEwtcog36uD2/g94FA0ZS8sdXGVqWpPKOwWsp+?=
 =?us-ascii?Q?TzV9vdtzcVXFjy5z4UvXnEZmz7wWKgRPmzbHL4qidoNzeC2br3Yha9Y1HwzS?=
 =?us-ascii?Q?EAef8gGwNmInw5zHm9a8JB6hEPeS+mouRqa4VFaracJcWW9Uw4foXjVNL+QG?=
 =?us-ascii?Q?6e86b8M+sXFGuPFaexZ34LC9F3cd6uhdnXJ3jeMLJXjgllqmJl2UkgLqZtfo?=
 =?us-ascii?Q?tptGtD6Ry49m65kTt0DyExjbazqypvESQKMklp7rZ1bD+cA54uHtqDxE8/g6?=
 =?us-ascii?Q?AUIkkU5v+epEcKUyJVbYYgU5j4xo3QzwwGxap3ELkvuIQXxLMT/RjpRE12SF?=
 =?us-ascii?Q?/OXhcAbCljLS2CGP+2O1n/rjxMZ9r0PFOox+i2Um0g/0Hl7Md2TAuBkGlyQ?=
 =?us-ascii?Q?=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?he1+YCmLTPPzP4jG30jgvfWmp77jilt+kxD8fBKV0Ttk4ZlFF4R8BsILEKk2?=
 =?us-ascii?Q?L17+woa+zY84juEdEQRBgz4dT/ThjS3qQD/FboIJklqu3YbCkW6RrpB/Rz2P?=
 =?us-ascii?Q?XaSFSGy0rburPPukX6uA8spW9uliHM3LNKHLXg9GvjK740rPVCrYq0lCaS0v?=
 =?us-ascii?Q?1eVBms1g7ozhu03PXqlS8nt+CQtFjW9sXtp5erLomP1CgjStt/jf7QVoWRGy?=
 =?us-ascii?Q?kQUtT8AHLKxn/nlc9/8FoRy2gTymAzVwj54rta8Zcser4alrbzK2hGT5TjRX?=
 =?us-ascii?Q?jp14ml2bFZRqhCMAzvrfPvrxeqOYdAbhzXSQRHER5tgj/Y2iZQ6g5pnhJyxi?=
 =?us-ascii?Q?zvBDPF24kipJ/uJUCKmFRxnopZL0A3MVv8/bsNZCOogjskyXP2fU0kUwsQgK?=
 =?us-ascii?Q?cONmWQh8txi8iSFVfI6+G2kCsP2gFKpsq0iQdZy2EUFAZHuZ473aqgw8jlFe?=
 =?us-ascii?Q?arSt8EeENTOELb/s5NaEsxA9+0XqMShlbwkWtP0VTJWr1j7+TjCDlEtL7yQs?=
 =?us-ascii?Q?VMKCZ9P11BjnWKtG4czxFqFVVh7l+7XNwDK4d3b3Z9txgfsWDaE4gvEO8U56?=
 =?us-ascii?Q?NdeWZLuK0ddrdtj2dWzvEP2fK1MBYTc8iiiiXOFU9oIKDK8zTuktljT8dftO?=
 =?us-ascii?Q?JWyshlgu9Ff0z7x0V/QUO381uxiynTP7j/tD4ntYR6EA3vUZWjl2wYGxbST/?=
 =?us-ascii?Q?QHkQ743CCB4VzCnmV5UQZh6nucU/A3E18EDAGiLmGTyfGe2umNSrMOBqwRzW?=
 =?us-ascii?Q?Azw1gGy0s0LADZc1RlqIyUrY/GAYdFdsTonG8gzbTKNywDeNRSrCKKccx6fi?=
 =?us-ascii?Q?amI0jtC5yL75GogcRu31omqVxkgSO114wTHnd2HJQqNO4ZUCSozcnT6vWnDk?=
 =?us-ascii?Q?16UfWGigoQP0+Q+7nx+8Z/OSttacUbPo71Kkx8dfppURdnzq777eQyuqJ7n3?=
 =?us-ascii?Q?aXubaV58DHaS3MGoO2w+wo4iUc0bpolJB7Nf4eEzwTLh7kwTt9jXqfbptoJZ?=
 =?us-ascii?Q?Zc7H7AJGIi29oOWQYZZHFspg3+RMPlWNAzSKNACkW6tklZkxXt1Fr6Oq8FnC?=
 =?us-ascii?Q?RkH+5/E7T4V+Ds05JewI51Wqp7LxvUzwHP59IxXMIlwHsNUOISNzY7vlNnMd?=
 =?us-ascii?Q?/66/R03u3tKqg3ThhCh/i2Vy0GRPgy0jZD193b5QN98nt2NYtVbbFb5nDUdx?=
 =?us-ascii?Q?ZExyuMxuoORE10RVFNXkvhC2IWJiN6ZW/Z0Pevr9bVUQtj59pPUvppmjpqWk?=
 =?us-ascii?Q?fyy4H5II3Z8hNES2njYEy7Ru2YOiCsqUALTUNS9E5hJ1qSg27Qt95gC4nhQ/?=
 =?us-ascii?Q?Cx0I2X+9Q+Y+yVAkaPzfBegde1LNZgt/qmogZUn19bTaEK4EceJVDah2J0mJ?=
 =?us-ascii?Q?q5h+7pNl+eSToKdi5u1I9t2sCOwoFrL15RF21Dvj9+UeB34XAmK+GO/P2JVU?=
 =?us-ascii?Q?Z9XrGKLmp4CNu5rAjSJRkx2hqYsV/gVhzwVxrSdCi+tz9/RmzzFJ9cPucFZM?=
 =?us-ascii?Q?VBQh0/dN/N/XJB40Uv5XrF7mpPnsWYLAXo3h00K0srrIg4tK943uSrCOw9Xd?=
 =?us-ascii?Q?4Z2sOnBZAVzg5/86Ma0mYaCQBcTqi+GwCcAE1gVy?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	beVjGp3bP8MFnXMYdL9OTJ9AvEW6rDlPYFhkEBmbmzRvV1A63e7eyLKls+TEuhwKt4XNjMCOnMwpqDlmhr08rnNE3O6YJzeDlxw++dRFjAXDoN0VeioGQIF6I/hSJ4zeBch0meKsgAM0A6iHXoh1+dUvtwWofFeOFlgYgcAdo9YF92qMNt4GXOz1Pb9rn7pMFBwe/AeJSGN99KzSt7IqkxvkB05wfAM90dXKON++xMHvPxSN1PrUYRiteQOqHdUZBnW0sY9YMhJT8INXya7+HnEHQ5zY5ch6W4mNGNhkmSm+nRmd0LdwzjHf9g2vy7tg5gJsDWR84LTFbQABiwZiUFhW2tpgn52/PNJEFbwZ6Z1/0bLLOq7YP5k1QBSYRgIPsd0FVnlQWsxd6AIpBo7CB6JalV3UKkWw3EsbriTfaf8nw2qCy+LMz0hWUKg/6LcBZCm2W6AGYkBoNohmR+fPOoHu65uMS/lhWWXYy3/6bAkCfP9kzKsi7TcZ3LYP/3r2RnL4njL0esVIB1FpcZK/j4d6cBEC/5XglkH54HiyYgUUJcIVzxz7IapPCL7CDJE0f+ONJhZk0dKYCH8xdxLWt5gz7WjuAc09aRMNobKne1Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3f339fd-e337-4d3b-e271-08dc7a729d5d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2024 15:19:46.6339
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSNmia4tVkCVeR/UpoDUlx+wRyZm32mZC1QH/CuZ6J7tdUMOVNQ8XStZsWqkpI16XAJflzv1GDQoyD7koPIzwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_08,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405220103
X-Proofpoint-ORIG-GUID: Vuw-uSO_USUys7Bs8VcfnibV377irLhe
X-Proofpoint-GUID: Vuw-uSO_USUys7Bs8VcfnibV377irLhe

* Mateusz Guzik <mjguzik@gmail.com> [240521 19:43]:
> Execs of dynamically linked binaries at 20-ish cores are bottlenecked on
> the i_mmap_rwsem semaphore, while the biggest singular contributor is
> free_pgd_range inducing the lock acquire back-to-back for all
> consecutive mappings of a given file.
> 
> Tracing the count of said acquires while building the kernel shows:
> [1, 2)     799579 |@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@|
> [2, 3)          0 |                                                    |
> [3, 4)       3009 |                                                    |
> [4, 5)       3009 |                                                    |
> [5, 6)     326442 |@@@@@@@@@@@@@@@@@@@@@                               |
> 
> So in particular there were 326442 opportunities to coalesce 5 acquires
> into 1.
> 
> Doing so increases execs per second by 4% (~50k to ~52k) when running
> the benchmark linked below.
> 
> The lock remains the main bottleneck, I have not looked at other spots
> yet.

Thanks.  This change is compact and allows for a performance gain.  It
looks good to me.

I guess this would cause a regression on single mappings, probably
within the noise and probably not a real work load.  Just something to
keep in mind to check if the bots yell about some contrived benchmark.

> 
> Bench can be found here:
> http://apollo.backplane.com/DFlyMisc/doexec.c
> 
> $ cc -O2 -o shared-doexec doexec.c
> $ ./shared-doexec $(nproc)
> 
> Note this particular test makes sure binaries are separate, but the
> loader is shared.
> 
> Stats collected on the patched kernel (+ "noinline") with:
> bpftrace -e 'kprobe:unlink_file_vma_batch_process
> { @ = lhist(((struct unlink_vma_file_batch *)arg0)->count, 0, 8, 1); }'
> 
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
> 
> v2:
> - move new stuff to mm/internal.h
> 
>  mm/internal.h |  9 +++++++++
>  mm/memory.c   | 10 ++++++++--
>  mm/mmap.c     | 41 +++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 58 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 2adabe369403..2e7be1c773f2 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1484,4 +1484,13 @@ static inline void shrinker_debugfs_remove(struct dentry *debugfs_entry,
>  void workingset_update_node(struct xa_node *node);
>  extern struct list_lru shadow_nodes;
>  
> +struct unlink_vma_file_batch {
> +	int count;
> +	struct vm_area_struct *vmas[8];
> +};
> +
> +void unlink_file_vma_batch_init(struct unlink_vma_file_batch *);
> +void unlink_file_vma_batch_add(struct unlink_vma_file_batch *, struct vm_area_struct *);
> +void unlink_file_vma_batch_final(struct unlink_vma_file_batch *);
> +
>  #endif	/* __MM_INTERNAL_H */
> diff --git a/mm/memory.c b/mm/memory.c
> index b5453b86ec4b..1b96dce19796 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -365,6 +365,8 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>  		   struct vm_area_struct *vma, unsigned long floor,
>  		   unsigned long ceiling, bool mm_wr_locked)
>  {
> +	struct unlink_vma_file_batch vb;
> +
>  	do {
>  		unsigned long addr = vma->vm_start;
>  		struct vm_area_struct *next;
> @@ -384,12 +386,15 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>  		if (mm_wr_locked)
>  			vma_start_write(vma);
>  		unlink_anon_vmas(vma);
> -		unlink_file_vma(vma);
>  
>  		if (is_vm_hugetlb_page(vma)) {
> +			unlink_file_vma(vma);
>  			hugetlb_free_pgd_range(tlb, addr, vma->vm_end,
>  				floor, next ? next->vm_start : ceiling);
>  		} else {
> +			unlink_file_vma_batch_init(&vb);
> +			unlink_file_vma_batch_add(&vb, vma);
> +
>  			/*
>  			 * Optimization: gather nearby vmas into one call down
>  			 */
> @@ -402,8 +407,9 @@ void free_pgtables(struct mmu_gather *tlb, struct ma_state *mas,
>  				if (mm_wr_locked)
>  					vma_start_write(vma);
>  				unlink_anon_vmas(vma);
> -				unlink_file_vma(vma);
> +				unlink_file_vma_batch_add(&vb, vma);
>  			}
> +			unlink_file_vma_batch_final(&vb);
>  			free_pgd_range(tlb, addr, vma->vm_end,
>  				floor, next ? next->vm_start : ceiling);
>  		}
> diff --git a/mm/mmap.c b/mm/mmap.c
> index d6d8ab119b72..1f9a43ecd053 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c

I see why you put them in mm/mmap.c and it's the best place right now,
for some definition of best.  The vma work is spread across several
files.

On that note, kernel/fork.c uses this lock for each cloned vma right
now.  If you saved the file pointer in your struct, it could be used
for bulk add as well.  The only complication I see is the insert order
being inserted "just after mpnt", maybe a bulk add version of the struct
would need two lists of vmas - if the size of the struct is of concern,
I don't think it would be.

> @@ -131,6 +131,47 @@ void unlink_file_vma(struct vm_area_struct *vma)
>  	}
>  }
>  
> +void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb)
> +{
> +	vb->count = 0;
> +}
> +
> +static void unlink_file_vma_batch_process(struct unlink_vma_file_batch *vb)
> +{
> +	struct address_space *mapping;
> +	int i;
> +
> +	mapping = vb->vmas[0]->vm_file->f_mapping;
> +	i_mmap_lock_write(mapping);
> +	for (i = 0; i < vb->count; i++) {
> +		VM_WARN_ON_ONCE(vb->vmas[i]->vm_file->f_mapping != mapping);
> +		__remove_shared_vm_struct(vb->vmas[i], mapping);
> +	}
> +	i_mmap_unlock_write(mapping);
> +
> +	unlink_file_vma_batch_init(vb);
> +}
> +
> +void unlink_file_vma_batch_add(struct unlink_vma_file_batch *vb,
> +			       struct vm_area_struct *vma)
> +{
> +	if (vma->vm_file == NULL)
> +		return;
> +

It might be worth a comment about count being always ahead of the last
vma in the array.  On first glance, I was concerned about an off-by-one
here (and in the process function).  But maybe it's just me, the
increment is pretty close to this statement - I had to think about
ARRAY_SIZE() here.

> +	if ((vb->count > 0 && vb->vmas[0]->vm_file != vma->vm_file) ||
> +	    vb->count == ARRAY_SIZE(vb->vmas))

Since you are checking vm_file and only support a single vm_file in this
version, it might be worth saving it in your unlink_vma_file_batch
struct.  It could also be used in the processing to reduce dereferencing
to f_mappings.

I'm not sure if this is worth it with modern cpus, though.  I'm just
thinking that this step is executed the most so any speedup here will
help you.

> +		unlink_file_vma_batch_process(vb);
> +
> +	vb->vmas[vb->count] = vma;
> +	vb->count++;
> +}
> +
> +void unlink_file_vma_batch_final(struct unlink_vma_file_batch *vb)
> +{
> +	if (vb->count > 0)
> +		unlink_file_vma_batch_process(vb);
> +}
> +
>  /*
>   * Close a vm structure and free it.
>   */
> -- 
> 2.39.2
> 

Feel free to add

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

