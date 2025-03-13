Return-Path: <linux-kernel+bounces-558941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A15A5ED5C
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 08:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AE7C1769F4
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 07:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB6EE25FA1B;
	Thu, 13 Mar 2025 07:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JLK2zGqv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="zmV2u8lO"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3AFF9E6
	for <linux-kernel@vger.kernel.org>; Thu, 13 Mar 2025 07:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741852416; cv=fail; b=JY/7J4xZ9/DA9T9v2rfalM7z296dhDjUzgbb1fV62OXHm2bqQaQIlA5OB1WO/+Su/f6yw/ZROJG4pjpM5h/DKIs5vHRa/66v8Ybq1mkvThWXUot224mH/Odl6pwhHL613pAJXNw/XkCs8B1l6jDwcimpo1hJUy7okGRLxX2ecds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741852416; c=relaxed/simple;
	bh=LMebe6HREESe6JpQOgJxzFygGuIvMMADIreXjktawoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=PsoPBWVpXg+tUJUtYAQ9eRWfd+H2HptrQetDjptN9uxtEXzOqCjRH+97ZD9T8GQHdmNrNH5yBj6C+0KCvrwQ7Z5u4BTu1jaYrAdokTIzS1yPLky3FBIi1C/gSTtb9DtmE+fbpLSRWDBUN6nbNmnDHXHNmvnuXRgSB98iNo4pXmA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JLK2zGqv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=zmV2u8lO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D7Y0Et026636;
	Thu, 13 Mar 2025 07:53:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=dRT/mrHqFef1m0rA6/
	9ZBcpErsGtlwntSE4F6F9CEKg=; b=JLK2zGqv2uglFlmVF6jZaYplCdIjhk+sz1
	5D6X2rXqqxt1LwlGqX3ToyEyOdeLOQkKax+wYnu11BTa/q8tLrPP3aLw5Lkhw+AO
	lE9mbzVwkaRf/QqU8NKYZsJ3XhOrIum7rRWuAeP/kcULREoESNT4g3WiGFI0EYRd
	jny2bS5l/dUmkQn7JM+nPbTZNUS+sB/F5nlv7nWRmk3LIeiYvbmBsQq6FSdedN00
	XKUuPqqTg/bagc2MByYMIo2qiDBXbzu0AlXEtzu7kqkYeIE594SVm92OM9/an5/v
	LVhkWVfgyRuoXhdWGWXJ1O1l3ZSCSk+v6QZI/WqTnlWDhLdvEjBg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au6vkn5s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 07:53:10 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52D6oiRr008440;
	Thu, 13 Mar 2025 07:53:09 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45atn4bsn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 07:53:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x35kACbOuFsxGG0HrjjQmOacpaw6OfF6xqvMmXDfKyfI/YHxBEBZfmOQQuPT4olmPJZAEh9M6yOiQFobhHSwDgoUSBIaR+77dtnXVY+sqhgNsz1gdH6R+g0R2+r/MGAnL6DNjUw66TZkSe0AbV4e+TEDXQjDjlHKOuX/29Vy+fSxFA4r9C8ooYno32KHIdf54dPNbixLfVe9Yu+74whcaYRkJHFhtZ9JjsS+TcWzTYwFKnbbZMuaJqlCxdRkeQHCTQ0kc9Fjfh/tfVcUylieCphb/E4xNJAz9JWIBhFtw/C9u5o48AMCbw7l7D+rwk8WJY02KMmaV8a+/4ciqAKhZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dRT/mrHqFef1m0rA6/9ZBcpErsGtlwntSE4F6F9CEKg=;
 b=ARCOh84jZRdUPfamZEWXrBj1URCou39Zup77k3ssviaX7cuIqOZOtXgKSlyfD8RaeGDnwBEytinJWRnll5BfZ9NPQm7BWncAKMDHfdda0N9sm8QJ+K6jvE8ymvy8tl0+8u+Dpq+zQRIaT5UUQeS2aHHsBpLrD3H1U9EZpTuUojYgLT+8IhXleNGNmfvDkoNyrvOjZyJYRkzoBjq00ePTQ62ulHU3TYVNjSg6kDJg0kRigH+JfxoKWnGGEtd9t77DFuIp5sIIjaNZEG9fVWbkOShPor7TxHQZfG9GY9UAzSEuV55h/b7LbgCHckOWW3NBwGB79PgbJFFrrD4R7HJgHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dRT/mrHqFef1m0rA6/9ZBcpErsGtlwntSE4F6F9CEKg=;
 b=zmV2u8lO8SU9ITgYs5bTBy1m+YPNd342jvWvjOisFDJ/uHAxyDlkgl9pKiR57/qD7c9Z1VY5yplgTuV+By2POPzPzV9h7N3vYxaJqAUReHJPASSyiF4j+A1VdiqRTGEVmeq/Ueo/Q2rsb2r+QlrMDL3t6xwcsCwvXvUhHq3OVQM=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7611.namprd10.prod.outlook.com (2603:10b6:610:176::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Thu, 13 Mar
 2025 07:53:06 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 07:53:06 +0000
Date: Thu, 13 Mar 2025 16:52:59 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Yosry Ahmed <yosry.ahmed@linux.dev>,
        Oliver Sang <oliver.sang@intel.com>
Subject: Re: [PATCH v3 3/7] mm/mremap: introduce and use vma_remap_struct
 threaded state
Message-ID: <Z9KO2-XXibMrSFHx@harry>
References: <cover.1741639347.git.lorenzo.stoakes@oracle.com>
 <27951739dc83b2b1523b81fa9c009ba348388d40.1741639347.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <27951739dc83b2b1523b81fa9c009ba348388d40.1741639347.git.lorenzo.stoakes@oracle.com>
X-ClientProxiedBy: SL2P216CA0136.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:1::15) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7611:EE_
X-MS-Office365-Filtering-Correlation-Id: e53a87b0-8558-4d32-1ff2-08dd6204172b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ZyTc3dRJFmeCmg4lGAp6vpxIwlwveeinio3R3zYy7nYdQCcperUSCAGaTUQC?=
 =?us-ascii?Q?7D1yJUwb4RT8xyfBiUIhVDBuin/w7UE/Se/bLvNkJuOZOmEr8vp4ita+agM4?=
 =?us-ascii?Q?CtpZt4n2WtN7KwV7RC12/QGznAXJjWyywOKk0mvh1d59SpET+O8NKT5K8XI1?=
 =?us-ascii?Q?1jisSi08yxnVI7Hf5oRDmZfJ8ZQ7ir1FUmnzRVdkJGEN+6mvX7jH7E6X2Mb3?=
 =?us-ascii?Q?aWdS+m4x3IHuJhoI8qlR/SNzwpQKV07zql38Vk3AX0tp0OlukwpJTLkejMhD?=
 =?us-ascii?Q?L9L8lz5DGGNsCqQi0bBJOaww+K6q8CdA2u8mD3xsrjxrhAcpHmhWfiza4Emr?=
 =?us-ascii?Q?CbZ36BZBqCmkhwoR5eoTThsEtt/m+LgUET1B4VEM8R7BVU6CiETc2OulcZoB?=
 =?us-ascii?Q?Ld6y8xOFKuEcbjGQ8grdmlvePX44gz0Tt2aTQcafLuYwcQW9RUfAI6NNxF63?=
 =?us-ascii?Q?MYRhABiqPS5kwqLoM40jdfszZqutrIYK9udzKyeuTNI0APENnp2JSDte5a9K?=
 =?us-ascii?Q?ezULGHl9CRJNPZfpXejdjbtLlcjT4SicnmmF1ghg0iQjfn0mPPGD+Dtvo5oB?=
 =?us-ascii?Q?yhUx8SlOn5uDKqz2ITmfvb4TQyd1a+kMnmNo5lgJHwoX3NtAtGwTfvrUD205?=
 =?us-ascii?Q?c3S0TwJj1IhGpDy+DBXILhvDRI7LRqvg0OdjH8YX+PZBGKMvTdynzb9CpZkm?=
 =?us-ascii?Q?4vP+BfseaQT5GpRr3nGYXsyk8B6aOj6LZdIjFOGDXzODAhIRTIqAgQjGM/gm?=
 =?us-ascii?Q?Wi9hEeQTV3+1KblPGD69RZEVhQzndGVvtd0Ncq27bIVDK2yTaafwmWPrW+SD?=
 =?us-ascii?Q?UmSjjMSbRi3c6eI75XbwUrKlldQOsLAx5mcu+Pm8CK0zNzKTrzQU+F0wDGs+?=
 =?us-ascii?Q?BiJ2nK9NWBWOIlum2/M+yD614k7lzy4vz3sf5KU+Y6AMX1Nq0Rpcg7AwqDnQ?=
 =?us-ascii?Q?+BR0B9QVM9SW/jQHq5UwLdyve5cT9ELGRVK2Mb6Ik2EGms25SrnSz7Rt/CPa?=
 =?us-ascii?Q?smU5mjJ2L0xp5IaLaySwyAPVpNJ+ITWme//ARD6gYHGjg9CNFjcKMNrpqjsr?=
 =?us-ascii?Q?5ZcnMgS3F5urJfQ52zOXrK1omDmoG8xDCCW9D1PhEnOnbqfYFUULH3j892Dp?=
 =?us-ascii?Q?f4MT7DmRb4i1vmDCjXdKEV4W4W8HUtqsTnm0O2uHIQYoayFMEZ9hcUvYq805?=
 =?us-ascii?Q?ybf7Wy3Wkelhi0BYaPgYQde5Wn7TXaR07GpsGoxBt/G4Q9emAb1TI8d+0CZw?=
 =?us-ascii?Q?JkePTYCTu19+eUXmIpsGOUkDeQr6yIUJm8UMn6jyRq2kAhf3g1mReM0jCZtR?=
 =?us-ascii?Q?TEFBkaS8BsoeDK5NB67A7gMHZk1TfYslxrhEQKB73PyCWU6bJWge6A3jbaX6?=
 =?us-ascii?Q?/NjBAjmmjnfu9IdRgU8YLrQ2H2fB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3LlAOwRjIwPfD47ITnizTDxtZilZF0ENWIY0CwmDL+oKN4ksaakv9e2maTzx?=
 =?us-ascii?Q?p/goVCBFyvp+TrrxDfvictOhrkt7Qe/jQd7I39iY4zbHgHZ0zCn3s0kINnGA?=
 =?us-ascii?Q?6mlHMJyCWmZX4VRRGQKC2OLByVWDRbGlrrNK06mRA/sNi2t16O+MSZTqaq0l?=
 =?us-ascii?Q?LGB1Mlo7GfokF6h4Dk7Q0lS8guMXZqVnvlhKjq7VpRNXjDKoWceSf4m3tpSn?=
 =?us-ascii?Q?KYgYvu2/C2VLper+bjRiaXG7E5ZqiTj1JJRcaJM/e/HIiCPYt2HoUf7wapO5?=
 =?us-ascii?Q?g86AkFWvTBPEKTtsgPqrcjdX9GNT4oasi95cXzY8NrkLVwW1xNgAjBIi2xvO?=
 =?us-ascii?Q?KKPr10kgxPtHQgKiTR2U+svGu7wBLRzbLyeED9yeKtZf+gS5gi884ynmEGTg?=
 =?us-ascii?Q?RTzLingUgWoc3C8ASaKi5NUDnkc0hVUFTNwBEIbDgBYf49gRBxj0MKBfSnEM?=
 =?us-ascii?Q?ASa5UCuBkbJLoERg9oDMknF+C4z29ucEZHpVPt+w1lDOpHhPNhclbprGMgY7?=
 =?us-ascii?Q?KrKqLfQfiliEa+y/Kcx5Dol1DAGnL5KuZzFzxV/PTQ2XkwGCszfzXd7xBO8Q?=
 =?us-ascii?Q?OigxZJsjKrMqPWPJ73zqr0hdfa3GqHfYrT6O80ieUpPUpqM77pnOSY45/s32?=
 =?us-ascii?Q?eQwyFTSO0BUKTEn9ZLaFpfDOl2AYPZMPLXOo6EQ9wmeiXZDTwBp/l9tBLiyL?=
 =?us-ascii?Q?RAhk3sXrmQNPvcZED37W4svW+DenT73w9meCuM53HvqygrtXvGKJdaxGQyKn?=
 =?us-ascii?Q?m/qx6+qlTgpflsIE21VowHCjpUoN4vihdAo3+eY/XHNRNsBmEYKpOs/kD02g?=
 =?us-ascii?Q?rZLP9Io12rQli663iIxBzV62oQLRJwQKtZA307H/uoeE9sA2NPeM+XflnqPd?=
 =?us-ascii?Q?3RvBhwCHxIdDxBQsL+N9ipY7ZsNGCjkX08mng7qz7A+qIRSpwUKs2xAOCUbD?=
 =?us-ascii?Q?aWYuztvGLEP28/ZkR+F1Yg7NU0os6Ev1Xork3N+t/Zxh7UFUJ23fo2BxtLtc?=
 =?us-ascii?Q?s6vWE8tDub1BgqX1dzdlBqfc8TWYLNZhXgkV0qxtom3kk/h+2uN6a5arBDDj?=
 =?us-ascii?Q?0PM4wMSPB9wme5BW+WUi7zvPoLokWcUtr3LYVi7ewvwCOt5N4dr87FjUEXuh?=
 =?us-ascii?Q?AfpdmGIYF5+tgOjx/QCwHWoVPJLCSK88UamO3+QR1J+jcqce/w9IMmA+EOES?=
 =?us-ascii?Q?BX8K8uTuFAODqWC6YIBdCMNk5xh8paEXkmr4kLvzcG3VwCXMgpxsq9315GUm?=
 =?us-ascii?Q?56Pfcvnh9I0cruAHTwV7fdPMu+vhJ1ZV4j9bWXfPce0iGRPnn4q5XOrqZ1hh?=
 =?us-ascii?Q?EygYFXvNefrxu8pmUgpwIAsODxNv+8bvTctpNkaCbCBjFGTWOXLKXN7kVOPN?=
 =?us-ascii?Q?R8kmj5JZVn8DmWjSqAYeD2mtO8Lt9RkdrCn/6WKmF7s17R0beVmRslCArUkD?=
 =?us-ascii?Q?CFX72iNb7jRZ28oq9IhgyYr0dHNEP8XbKSC110W9djeUUUXIOJAtEYF7ITOS?=
 =?us-ascii?Q?AD1RY58EZpbDOBbY65Cly5f/Uz0LGbu8dnuMrcScx7eDxVP9bp0l06RJSmRB?=
 =?us-ascii?Q?rEeqa1i5hJE/6DEH2kIbCayPnrzjuWBtk/suZj/T?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KJ0TMi2pEITfkP1Ytdd3DZLkocGkSrNNrFHfY/XVdquA2mcfa7XWnVG0NXwk8iWu5oqCI4PdSVTB133s46ax/ZFxujyJTnER+x9BNeZlXovemlFjAH1ouH9cYFuf7cguai0THJTPKuan3cf1lJ8WxrfvNQvnvM3TeSA2x9iLqYpJgKDI9Zfy6AcvlcY3isiLdxq0TQ4p/IemMXrMthLWIwN4/SO+SyTWaLNwzEwEdml0xJI3YKu25bF9l3c/Tt4hkvPI8WJOLKvMBOEL1uNYu69m0MUc+l3M8K4U1Oceophij4fZGslkv77Ka2fYp1kAa8q2JZ5T8LtWvRNRsmN6YKlB/S3Ael4fLTxIVLyetcmZTWO2Zs+tqaZNnOWj0Htywu7+qJDvdO+cMnA+gnY2DegPI8GUosx8kX1Ki5AqbYjZcQvh8Wx9JoaajoxAPCnrymjLtC1gaPPimdLP6aOPq6f3kSXJUeZRdgZ9b6aOnv7s/42+DGU5/bpoJtWp2AdNNB/TvZINtJe7Bdicd8iEs74YcN/vRKjNqiUft/Vr1+zCEL7N1G/yBS4A5H1P8s65Tgn13v41Rg/IM52/tYteaJkcg8XJ4+HyECv5m8To6to=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e53a87b0-8558-4d32-1ff2-08dd6204172b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 07:53:06.6252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qI/WJpTqU3krOwSt3fGDWzG7+iw8xNsBcCsb4HMvbpvFWbutBuxDdlIfE7OOpRyyqD8bbzuf9yDgu1HG4ds1tw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7611
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=888 mlxscore=0 adultscore=0 phishscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503130061
X-Proofpoint-GUID: QtQ_njh05ifEJ-bKezWckFn5CNbJK6Q2
X-Proofpoint-ORIG-GUID: QtQ_njh05ifEJ-bKezWckFn5CNbJK6Q2

On Mon, Mar 10, 2025 at 08:50:36PM +0000, Lorenzo Stoakes wrote:
> A number of mremap() calls both pass around and modify a large number of
> parameters, making the code less readable and often repeatedly having to
> determine things such as VMA, size delta, and more.
> 
> Avoid this by using the common pattern of passing a state object through
> the operation, updating it as we go.  We introduce the vma_remap_struct or
> 'VRM' for this purpose.
> 
> This also gives us the ability to accumulate further state through the
> operation that would otherwise require awkward and error-prone pointer
> passing.
> 
> We can also now trivially define helper functions that operate on a VRM
> object.
> 
> This pattern has proven itself to be very powerful when implemented for
> VMA merge, VMA unmapping and memory mapping operations, so it is
> battle-tested and functional.
> 
> We both introduce the data structure and use it, introducing helper
> functions as needed to make things readable, we move some state such as
> mmap lock and mlock() status to the VRM, we introduce a means of
> classifying the type of mremap() operation and de-duplicate the
> get_unmapped_area() lookup.
> 
> We also neatly thread userfaultfd state throughout the operation.
> 
> Note that there is further refactoring to be done, chiefly adjust
> move_vma() to accept a VRM parameter.  We defer this as there is
> pre-requisite work required to be able to do so which we will do in a
> subsequent patch.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry

