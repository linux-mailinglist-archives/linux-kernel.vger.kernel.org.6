Return-Path: <linux-kernel+bounces-531770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5209CA44491
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 16:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4EA1789E4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB47C1547E3;
	Tue, 25 Feb 2025 15:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AK0NeKIo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="agVrSo16"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C82C140E3C
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 15:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498019; cv=fail; b=dbz/2KWQ+xQhd47PijYL9N9Imy4Ypd8dNIBaeYMl2AlyxyOzA+9CNtrBptcZZksG0+ELQg1cV6lH6gRWQodPUF7Wxo5cgrXW2gLu31KNOVzCMYwq58LGMoWDBpVbPjmJtWk5gA/jlcsdfen5sOl2jUtjpsFnR3DQ76u8NHrISNI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498019; c=relaxed/simple;
	bh=cvxnDwWtmxFioAPSBqQikg76zTaVMy2prk21sY8zoGc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oEuH4CgfNwhnVk30VJcRki6j52pUfgQuuZw3hsrW2gsjGc0i676oxSwQQjBs/bu25dQivnjf33U/gfi3EqcD5dQaQ4En2EVEJ8Cd6uxcRqh6JsQySwk38jI3bn1cfJu6a4HiVnabwjxpDTZreELYvl9vq8a9mbXseag2y0eewAw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AK0NeKIo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=agVrSo16; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51PFMZRr006464;
	Tue, 25 Feb 2025 15:40:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=NCX2sZak64GwAEfSuR
	Sa/GFS3Y31q8Pf5alM7U5nZp0=; b=AK0NeKIovhVrnO8L++t072GsVrAhPy1jtV
	b3AT+QvifvbPNp5kFQ/ZcK5LMWclzxHcKUbAkntBeFeyUVUCapC/s4/lKMBsSz7g
	gUiYtHamKCctxYJw9Zr+CmYlEC6KXLOENSZ0xNEIsH5eUBJiPizLuHMtqZPrYNJ3
	jKvub6imt3Tmlm59hF0+2gT9ivJPjQpZyy7ZmQs33kBc46da3FfxcIiQU8CPbsAP
	+n0+fJzH+UrDDj47yl7J1QnhP1bGw02l8SZFbFJBOoMKOWAv4OFpQzsijLtQl+23
	z+IHxBFLqIsJ+4/byJ8p03RlUPwjQ8t4nLQpouxgtNiQYgent0qw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y50bnh7b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 15:40:05 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51PEL51j012522;
	Tue, 25 Feb 2025 15:40:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44y51amxsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 15:40:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YPcRLxv5ZwhWAOW1buc1/B3JBLEIlaeTDk1Ulkua5KXY0RM/BFSI8hr4RGamhNMyGXO4p9q44D/4LX7Ijs0j7hMdssRkFlD0X2nW/SaL1pLB7eBmCu7z+wCuecteO3sjUW/RYQ8a+iwYbx3zJspEL50OSLkGfry5maiCr0S0QUKG8aaVSKZuXNvoK+xwTOxyiAPfOuq6HLe0xVIs29xxuNdJrv3ybR96EIitx3xjjLMVRnixs9cBZEnzoff0uqh9aZYX7sSu+iER8LZZvV/NluCvvnAHMutYas5iqV3plrHZtf3uBybHJhU3Ldo7yW53YzA5ozv3Li8NiG61txRKwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NCX2sZak64GwAEfSuRSa/GFS3Y31q8Pf5alM7U5nZp0=;
 b=hsUyl1MLRNpSfyW9U24fx+c/5qu3TykDyqkq9Wpw1KtULHAy47Kap8Ed+8VbMdBGNF5aCx1g3ajsz7sIlBUzL+JgS9/Np090qPvU/K2RTzXSSP1Ay2TXPgAsQYwwUG7IRV+qFRwDV3WinxZpg6+XjLePlZDAB5ctocTx3AHOzrkcZ4lXhwabPNK3Dy9Sz/OQ0/GXUgkUdTM/oi5zw5WtjdGhD1HudsFqEzalfOnOUU2O+lWr/h+Zyf6EGIlZF6u6PmKrG/xgt2W3cIdVHy2AI5HXaJHl2SnILNZuLOPInJIYQU7FkiE1Q+izJhR7XGXhharWQmsTVVFhiLQRpEmmHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NCX2sZak64GwAEfSuRSa/GFS3Y31q8Pf5alM7U5nZp0=;
 b=agVrSo16lG4js/wkNiV5kVo0PPhEkqOjOIizL2KZhJ0D8gTkEReWDJZGy2EoY5Mb0/uM0aGsYmxxGGyPkVfZFrbIiQfVxL8v8hOhstJ+JkiObL39RrFfDv/8MeIZ4WcaWdLznFcZs+p1x2VXN3X4dIuoyorvYJkDFOWqJxHAJ/U=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by BL3PR10MB6257.namprd10.prod.outlook.com (2603:10b6:208:38c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.19; Tue, 25 Feb
 2025 15:40:01 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%4]) with mapi id 15.20.8466.016; Tue, 25 Feb 2025
 15:40:01 +0000
Date: Tue, 25 Feb 2025 10:39:58 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Sidhartha Kumar <sidhartha.kumar@oracle.com>
Cc: linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        richard.weiyang@gmail.com
Subject: Re: [PATCH v2 2/6] maple_tree: use height and depth consistently
Message-ID: <adwnvy44e3x52u2f2qng2ltkvimjlibdt4n4hk3ws7w7rxuqou@jjunrlaqnwam>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Sidhartha Kumar <sidhartha.kumar@oracle.com>, linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, richard.weiyang@gmail.com
References: <20250221163610.578409-1-sidhartha.kumar@oracle.com>
 <20250221163610.578409-3-sidhartha.kumar@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221163610.578409-3-sidhartha.kumar@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0312.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10e::24) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|BL3PR10MB6257:EE_
X-MS-Office365-Filtering-Correlation-Id: ce81691a-e644-4063-3f80-08dd55b2aa6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?PccutYizcckZh5sS3Oa9qhDaMCjR7cayyHjR0l8rTXuPii4dmS6bh712pFNe?=
 =?us-ascii?Q?JVhDHN7PigSfuWv/1ZnKhOuQvLX64FYXs/5k0y2hpSve3Iu5bUOwi7bS0JqX?=
 =?us-ascii?Q?zUgd2VBAccAK+KXaoKYUg2BH70CzwCcJSEKEQkQcmNP836IEh5Dg5ytN2yxT?=
 =?us-ascii?Q?+XHfbidxggFDUQQsQXuPQl/JGuFkxfV+RSolyqZHzqHvFFkfwZ7fLACxVUUW?=
 =?us-ascii?Q?0d5yStT6yCfNnpkFa6WUWx94SUBNu5e3xV2Og9CQaBaQlWTT3G79pMMDEk2G?=
 =?us-ascii?Q?KDNdalZXRjWhwK4jybErHZ3WMtPnZ8FP4Z6mTYTpxlHbRRjFhU8GU/A58/Uj?=
 =?us-ascii?Q?V42JS/cGsaTRy/7GtjxyUfLVrRPr03pX/m13rscXujOwawzQVpbyFdlja3oH?=
 =?us-ascii?Q?6LBwkLrD3IE2q0/E59tSKE1XGDuf+oUpDzCPP3kLRJJi9xMyflGyCqrYCStQ?=
 =?us-ascii?Q?ygmq4Gbx1xTm6HZfVznVnB58m9cc3+XoOoivTvuO4zkovz79pjNk9j2ja3MS?=
 =?us-ascii?Q?cshkR/D665UbnFABD9tzwLsjlTsK81wofc79Hu0WGEnyjTo4igaB/s7bNZQ5?=
 =?us-ascii?Q?s/olSlMNsA0PORtDkqm6+jTG2KNcf/0ij1jO4lKq1qGPa7Ailh4QArPzD77b?=
 =?us-ascii?Q?0uOTmfmMcibwGJgKFFhJ66slR+afwIoK47aIM2L6Vn8zPZOCsxLS0H/4rnqx?=
 =?us-ascii?Q?f03Y3Trp7Tw6iTZFnRpsWO+quL48bGA5L7cJzPXoPp+x52QYUekKa9yCBseD?=
 =?us-ascii?Q?O3gKbrUviGMUP2GfxzvUA+rTjkLjfpLFTZUOaYmCp+aR4ojhyN94hwdkcQZr?=
 =?us-ascii?Q?7Kcs2Sjq3N+3bjGebKi5pv2qeWB7ipjxmBPMKgfFhqIS4yv0EOZlaIx1cUtZ?=
 =?us-ascii?Q?dQIFsrxNpB87z5UMOd+bHdV2RPK8ZL9UQ9t9Agr4vn1Oc/e07c3gqQSBrsp1?=
 =?us-ascii?Q?NPssyhkVC5qwpP3PBr70GxqgyRZ4DMcqPHBKMRhzAHvOJCNukFuNVyTfNryt?=
 =?us-ascii?Q?xOiBdzjT5h3hm91wzsAZ/H79JwR4d6wX5yR55nOPoH2dHtjCxQ5IwiG2USIW?=
 =?us-ascii?Q?MxZtyZwhg5NqUbnuG9kfVXEtuA+uzLUchCBcYU/QyAOXOeS+YFWjFh20Syzz?=
 =?us-ascii?Q?8Ql5RV7iXbZBU2MRwHQawpq1VEW8jiL3SYa8xvD/xB6DlNOfR+cxUAJKQMHf?=
 =?us-ascii?Q?I/oehfVJ41E6+q6+VwfqQ2MPf8kU+bR0K0Gl6UykBkxeP5UK5S6QYWcZ+ZJR?=
 =?us-ascii?Q?euM9MqR7J9TbJr4L8RrwjwfzSfiGieKPYzl7++onkXxUAfD8XcP/2whuLPdK?=
 =?us-ascii?Q?/hATduvK5x8pGhX0gkpCaMcQca4o1C5H0iGFwrFi/GzmJ0HHi9FY1J/KH4eL?=
 =?us-ascii?Q?/F8vJ0MrnmUjUszgnsD2ENcmRu2uVwR0JTSEmAvnWO9l4+IDJX7+zP00znUy?=
 =?us-ascii?Q?KpIOYvCd+uA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7n/Drh+CIMXQKTdzuYuJZzPcuelWMJCn0l6Iyk2ub8kjyFvD9AvD7ZzTwQ3Y?=
 =?us-ascii?Q?lIEANI3hfvnfuOmYv741Nfy+0aDd/veZfoc6UgDdFj/DI/v8ENxy6yqnTcHW?=
 =?us-ascii?Q?VHp24UFSgWxiCpZeL44nV9MNHr+xZuYeOBfrm9J25SSHJvkURBK0mt0zVIcw?=
 =?us-ascii?Q?3JiuXgl65qMp+f8qScJy5qeo+XokQ/9FEQdawWo0txJSMSXfKJUHe7O8Cw17?=
 =?us-ascii?Q?QuiIoMa04fLfs4iWF7rpts0Pwmd2VJpDMn3cMKOuOE3o4IQJdpcLDpgPp/Ib?=
 =?us-ascii?Q?sOQcjOB/0dsKOr1soTiy27eJ8im95HnbA8FpT8K91tM5oiDH1R1ozlKrY3qK?=
 =?us-ascii?Q?Hd6oBN/pSSFKaH7Uxzo+oo+sPpam8OyN+hfPzJ15wcfgClJlT7EVSbAIxTxa?=
 =?us-ascii?Q?1qJg6/r8xxWkvlhKLsJIrAXOyXR76ZpBfH5VzyyLgVvzJU/fHC2fHnUE/1wq?=
 =?us-ascii?Q?0qXkPQuanGsic/8W9YnBgDcx0lQKxtMU/RbWm7Lm40anB4urNKgRqAX1q8CO?=
 =?us-ascii?Q?T+HibFgVzkrhl7Yx9Ch6rTtChAgkXyIuiUCrz4+slf8OXgx1wI8vZ+VhUc69?=
 =?us-ascii?Q?b7K2iJDn7m8l4LathBpN+SJdFOJIr4lK+fx9zCcjJd0S7cssD5TgaWn1pHsg?=
 =?us-ascii?Q?EVWdwDhfsD5pm5AsBtEUPp9RFx9nYxI8H5xbi0y+xUdODBGWlyM0uIrkkAsM?=
 =?us-ascii?Q?OEnTGIbUzoQOcN8GtknQbzi3DgGOoWN9SJJswIq9eKnzLIgdpqed7ZA02QPm?=
 =?us-ascii?Q?gL8aOAppWbfhKMKSWmqADs1bSewWENlXi7QEST8AmMGqPftg8E2Wv0QsZj9q?=
 =?us-ascii?Q?sccAIUFwd+tMA0H2UZGo/OStffoOm8i9ezKiXDU5DyJMZu6DnyKbgAP4b+CS?=
 =?us-ascii?Q?qrOu0ujLxbTPLJoBK5cNPCz9PzdXyq+SA9Ao6Uj3/MqwG9ZKfPhVpBMTtgPr?=
 =?us-ascii?Q?Op+Fxva9ETwCrwyzeupvBwnbyLBrCSbhfsJ5HxkVE1uqPQzl0VJ4UnW84PI9?=
 =?us-ascii?Q?dJKtUEcAcfIf22qzVSeSDYnJ+3jiOeLrZbAeKw4L+B5VelUALFkGfr+YPUtR?=
 =?us-ascii?Q?/XdjmpE8WbD1f6PIZ4JRvoYpIxtNs8kwalxYkyqfTZp8n4RAtMYaxwUN2D8N?=
 =?us-ascii?Q?CuRnCSqvKbJWUHen+7jjLh5jT5Xplg6AKF45DJ14IlUPlCqf13q7cIjiv4u5?=
 =?us-ascii?Q?3H2Gkt93K08WgONE46ln/oBtUA2slRvxpkDlum6IUo/0ih4k+aBGP15h109g?=
 =?us-ascii?Q?RpoZPGN1lpj8LF0VUO1adnmuGKgeuauxpsUIYPHnWc3uZ6JTTXDETf3fTbKX?=
 =?us-ascii?Q?p+pvI8mq8eda6nbcJkFMYHTqbNZ0ZBg/OMmcdOpNZrTgxTtizkBnsy8updyo?=
 =?us-ascii?Q?rfZglJScpMO9awfxQcaCPZEyOn5PdhcyJOUb4nhOsgjNbTwvYyEjNCiutT1m?=
 =?us-ascii?Q?NNZP3g9Y9Hre5sy2z2qi+8lK7kWHteBZ6r0TRnL2ribURgtivoUsJhMwqku2?=
 =?us-ascii?Q?RsrFX3sELE/EQLd0hupdtWX7DCG33LwBJWC3zdI1qXXFr7SjHF9eRUUSoOy6?=
 =?us-ascii?Q?lB/j0eq9M2jAQnwbT20rk6dCVHAwetbAxQ8JENVO8pbuMuIZuuL5ddOEd8R7?=
 =?us-ascii?Q?JA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	MvjOZBL3ItSzHw1z5muj8aUiblujhz0uDhSd5K5YiWK6np1J1dggw9/4PSiAJpo0hpRbSnmwfOpT1CdRw1/Dat2fgHfAj3hKsr+z9/00xN+w/D7xaaFoz7xTaWUxgVHltKHes9YxKTxW+EgYLO450geHhrhm+qZcQCJ80lOxW2d3eyp3HFmF0V/4Gox4O9yvex68e6UmekexxdYuGJcm4Ae7Sz3fWZbyKiGKGSlre9SMmeNdu/u6ysTht8El5Q0vNrLZZhtvXN4pkuyfcmWvowwR/18SzQzkFNCPT4W3R0KNrI4HJlsanWtKTySueIYq+7gOXHWHScZGyu07upSU9rlc+r2nizF5UWPNWa9fkrxV51ikr+pP/LtlCNW4mao4kfqdzMLh2lcq7falUjJ1nENF41cbSPJdWDNrDrP3o160r2+lDbzG+Fwoz6Fdx0PR+rr3l97Y74Km1mnVRYOtIDSAfqqUf2adBRJ38hV6Xax46IVmTxmOE0XdPQV8ac/qUS55sR+ZjY/vBLj/v29VrSUMPQmzIK1QqyX8/CsJL3dxVlrXxxAJmCDiNSo2G5vZcx+tBZtTSL7qoV95d8CPo7wUGt2h4+D1LshVBrjyByE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce81691a-e644-4063-3f80-08dd55b2aa6e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 15:40:01.0454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YXsoG7pS/VVFW4MZY26s+uLtQq5OqgtHuq+nZkzLZki6NYrhoBET8ggeXD1fvbPey8q+fmn3+HNFuv1B9DxVWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR10MB6257
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_04,2025-02-25_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 mlxscore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2502250103
X-Proofpoint-ORIG-GUID: ILcZjST6iFXlh6VGeB7ceBvhpWnhY_-6
X-Proofpoint-GUID: ILcZjST6iFXlh6VGeB7ceBvhpWnhY_-6

* Sidhartha Kumar <sidhartha.kumar@oracle.com> [250221 11:36]:
> For the maple tree, the root node is defined to have a depth of 0 with a
> height of 1. Each level down from the node, these values are incremented
> by 1. Various code paths define a root with depth 1 which is inconsisent
> with the definition. Modify the code to be consistent with this
> definition.
> 
> Signed-off-by: Sidhartha Kumar <sidhartha.kumar@oracle.com>
> ---
>  lib/maple_tree.c | 85 +++++++++++++++++++++++++-----------------------
>  1 file changed, 45 insertions(+), 40 deletions(-)
> 
> diff --git a/lib/maple_tree.c b/lib/maple_tree.c
> index 0410e13a099e..d7dac3119748 100644
> --- a/lib/maple_tree.c
> +++ b/lib/maple_tree.c
> @@ -211,14 +211,14 @@ static void ma_free_rcu(struct maple_node *node)
>  	call_rcu(&node->rcu, mt_free_rcu);
>  }
>  
> -static void mas_set_height(struct ma_state *mas)
> +static void mt_set_height(struct maple_tree *mt, unsigned char height)
>  {
> -	unsigned int new_flags = mas->tree->ma_flags;
> +	unsigned int new_flags = mt->ma_flags;
>  
>  	new_flags &= ~MT_FLAGS_HEIGHT_MASK;
> -	MAS_BUG_ON(mas, mas->depth > MAPLE_HEIGHT_MAX);
> -	new_flags |= mas->depth << MT_FLAGS_HEIGHT_OFFSET;
> -	mas->tree->ma_flags = new_flags;
> +	MT_BUG_ON(mt, height > MAPLE_HEIGHT_MAX);
> +	new_flags |= height << MT_FLAGS_HEIGHT_OFFSET;
> +	mt->ma_flags = new_flags;
>  }
>  
>  static unsigned int mas_mt_height(struct ma_state *mas)
> @@ -1375,7 +1375,7 @@ static inline struct maple_enode *mas_start(struct ma_state *mas)
>  		root = mas_root(mas);
>  		/* Tree with nodes */
>  		if (likely(xa_is_node(root))) {
> -			mas->depth = 1;
> +			mas->depth = 0;
>  			mas->status = ma_active;
>  			mas->node = mte_safe_root(root);
>  			mas->offset = 0;
> @@ -1716,9 +1716,10 @@ static inline void mas_adopt_children(struct ma_state *mas,
>   * node as dead.
>   * @mas: the maple state with the new node
>   * @old_enode: The old maple encoded node to replace.
> + * @new_height: if we are inserting a root node, update the height of the tree
>   */
>  static inline void mas_put_in_tree(struct ma_state *mas,
> -		struct maple_enode *old_enode)
> +		struct maple_enode *old_enode, char new_height)
>  	__must_hold(mas->tree->ma_lock)
>  {
>  	unsigned char offset;
> @@ -1727,7 +1728,7 @@ static inline void mas_put_in_tree(struct ma_state *mas,
>  	if (mte_is_root(mas->node)) {
>  		mas_mn(mas)->parent = ma_parent_ptr(mas_tree_parent(mas));
>  		rcu_assign_pointer(mas->tree->ma_root, mte_mk_root(mas->node));
> -		mas_set_height(mas);
> +		mt_set_height(mas->tree, new_height);
>  	} else {
>  
>  		offset = mte_parent_slot(mas->node);
> @@ -1747,10 +1748,10 @@ static inline void mas_put_in_tree(struct ma_state *mas,
>   * @old_enode: The old maple encoded node.
>   */
>  static inline void mas_replace_node(struct ma_state *mas,
> -		struct maple_enode *old_enode)
> +		struct maple_enode *old_enode, unsigned char new_height)
>  	__must_hold(mas->tree->ma_lock)
>  {
> -	mas_put_in_tree(mas, old_enode);
> +	mas_put_in_tree(mas, old_enode, new_height);
>  	mas_free(mas, old_enode);
>  }
>  
> @@ -2543,7 +2544,7 @@ static inline void mas_topiary_node(struct ma_state *mas,
>   *
>   */
>  static inline void mas_topiary_replace(struct ma_state *mas,
> -		struct maple_enode *old_enode)
> +		struct maple_enode *old_enode, unsigned char new_height)
>  {
>  	struct ma_state tmp[3], tmp_next[3];
>  	MA_TOPIARY(subtrees, mas->tree);
> @@ -2551,7 +2552,7 @@ static inline void mas_topiary_replace(struct ma_state *mas,
>  	int i, n;
>  
>  	/* Place data in tree & then mark node as old */
> -	mas_put_in_tree(mas, old_enode);
> +	mas_put_in_tree(mas, old_enode, new_height);
>  
>  	/* Update the parent pointers in the tree */
>  	tmp[0] = *mas;
> @@ -2639,10 +2640,10 @@ static inline void mas_topiary_replace(struct ma_state *mas,
>   * Updates gap as necessary.
>   */
>  static inline void mas_wmb_replace(struct ma_state *mas,
> -		struct maple_enode *old_enode)
> +		struct maple_enode *old_enode, unsigned char new_height)
>  {
>  	/* Insert the new data in the tree */
> -	mas_topiary_replace(mas, old_enode);
> +	mas_topiary_replace(mas, old_enode, new_height);
>  
>  	if (mte_is_leaf(mas->node))
>  		return;
> @@ -2828,6 +2829,7 @@ static void mas_spanning_rebalance(struct ma_state *mas,
>  {
>  	unsigned char split, mid_split;
>  	unsigned char slot = 0;
> +	unsigned char new_height = 0; /* used if node is a new root */
>  	struct maple_enode *left = NULL, *middle = NULL, *right = NULL;
>  	struct maple_enode *old_enode;
>  
> @@ -2877,7 +2879,7 @@ static void mas_spanning_rebalance(struct ma_state *mas,
>  		 */
>  		memset(mast->bn, 0, sizeof(struct maple_big_node));
>  		mast->bn->type = mte_node_type(left);
> -		l_mas.depth++;
> +		new_height++;
>  
>  		/* Root already stored in l->node. */
>  		if (mas_is_root_limits(mast->l))
> @@ -2901,8 +2903,10 @@ static void mas_spanning_rebalance(struct ma_state *mas,
>  			continue;
>  
>  		/* May be a new root stored in mast->bn */
> -		if (mas_is_root_limits(mast->orig_l))
> +		if (mas_is_root_limits(mast->orig_l)) {
> +			new_height++;
>  			break;
> +		}
>  
>  		mast_spanning_rebalance(mast);
>  
> @@ -2913,7 +2917,7 @@ static void mas_spanning_rebalance(struct ma_state *mas,
>  
>  	l_mas.node = mt_mk_node(ma_mnode_ptr(mas_pop_node(mas)),
>  				mte_node_type(mast->orig_l->node));
> -	l_mas.depth++;
> +
>  	mab_mas_cp(mast->bn, 0, mt_slots[mast->bn->type] - 1, &l_mas, true);
>  	mas_set_parent(mas, left, l_mas.node, slot);
>  	if (middle)
> @@ -2937,7 +2941,7 @@ static void mas_spanning_rebalance(struct ma_state *mas,
>  	mas->min = l_mas.min;
>  	mas->max = l_mas.max;
>  	mas->offset = l_mas.offset;
> -	mas_wmb_replace(mas, old_enode);
> +	mas_wmb_replace(mas, old_enode, new_height);
>  	mtree_range_walk(mas);
>  	return;
>  }
> @@ -3013,6 +3017,7 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
>  	void __rcu **l_slots, **slots;
>  	unsigned long *l_pivs, *pivs, gap;
>  	bool in_rcu = mt_in_rcu(mas->tree);
> +	unsigned char new_height = mas_mt_height(mas);
>  
>  	MA_STATE(l_mas, mas->tree, mas->index, mas->last);
>  
> @@ -3107,7 +3112,7 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
>  	mas_ascend(mas);
>  
>  	if (in_rcu) {
> -		mas_replace_node(mas, old_eparent);
> +		mas_replace_node(mas, old_eparent, new_height);
>  		mas_adopt_children(mas, mas->node);
>  	}
>  
> @@ -3118,10 +3123,9 @@ static inline void mas_destroy_rebalance(struct ma_state *mas, unsigned char end
>   * mas_split_final_node() - Split the final node in a subtree operation.
>   * @mast: the maple subtree state
>   * @mas: The maple state
> - * @height: The height of the tree in case it's a new root.
>   */
>  static inline void mas_split_final_node(struct maple_subtree_state *mast,
> -					struct ma_state *mas, int height)
> +					struct ma_state *mas)
>  {
>  	struct maple_enode *ancestor;
>  
> @@ -3130,7 +3134,6 @@ static inline void mas_split_final_node(struct maple_subtree_state *mast,
>  			mast->bn->type = maple_arange_64;
>  		else
>  			mast->bn->type = maple_range_64;
> -		mas->depth = height;
>  	}
>  	/*
>  	 * Only a single node is used here, could be root.
> @@ -3153,8 +3156,7 @@ static inline void mas_split_final_node(struct maple_subtree_state *mast,
>   * @skip: The number of entries to skip for new nodes insertion.
>   */
>  static inline void mast_fill_bnode(struct maple_subtree_state *mast,
> -					 struct ma_state *mas,
> -					 unsigned char skip)
> +					 struct ma_state *mas, unsigned char skip, int *height)

Update the argument list in the comments?

>  {
>  	bool cp = true;
>  	unsigned char split;
> @@ -3226,7 +3228,7 @@ static inline void mast_split_data(struct maple_subtree_state *mast,
>   *
>   * Return: True if pushed, false otherwise.
>   */
> -static inline bool mas_push_data(struct ma_state *mas, int height,
> +static inline bool mas_push_data(struct ma_state *mas, int *height,
>  				 struct maple_subtree_state *mast, bool left)

Update the argument list in the comments?

>  {
>  	unsigned char slot_total = mast->bn->b_end;
> @@ -3283,8 +3285,8 @@ static inline bool mas_push_data(struct ma_state *mas, int height,
>  		mast->orig_l->offset += end + 1;
>  
>  	mast_split_data(mast, mas, split);
> -	mast_fill_bnode(mast, mas, 2);
> -	mas_split_final_node(mast, mas, height + 1);
> +	mast_fill_bnode(mast, mas, 2, height);
> +	mas_split_final_node(mast, mas);
>  	return true;
>  }
>  
> @@ -3297,6 +3299,7 @@ static void mas_split(struct ma_state *mas, struct maple_big_node *b_node)
>  {
>  	struct maple_subtree_state mast;
>  	int height = 0;
> +	unsigned int orig_height = mas_mt_height(mas);
>  	unsigned char mid_split, split = 0;
>  	struct maple_enode *old;
>  
> @@ -3323,7 +3326,7 @@ static void mas_split(struct ma_state *mas, struct maple_big_node *b_node)
>  	MA_STATE(prev_r_mas, mas->tree, mas->index, mas->last);
>  
>  	trace_ma_op(__func__, mas);
> -	mas->depth = mas_mt_height(mas);
> +	mas->depth = orig_height;

Why is this still needed?  It might be worth adding a comment or
removing it?

>  
>  	mast.l = &l_mas;
>  	mast.r = &r_mas;
> @@ -3333,7 +3336,7 @@ static void mas_split(struct ma_state *mas, struct maple_big_node *b_node)
>  
>  	while (height++ <= mas->depth) {
>  		if (mt_slots[b_node->type] > b_node->b_end) {
> -			mas_split_final_node(&mast, mas, height);
> +			mas_split_final_node(&mast, mas);
>  			break;
>  		}
>  
> @@ -3348,11 +3351,15 @@ static void mas_split(struct ma_state *mas, struct maple_big_node *b_node)
>  		 * is a significant savings.
>  		 */
>  		/* Try to push left. */
> -		if (mas_push_data(mas, height, &mast, true))
> +		if (mas_push_data(mas, &height, &mast, true)) {
> +			height++;
>  			break;
> +		}
>  		/* Try to push right. */
> -		if (mas_push_data(mas, height, &mast, false))
> +		if (mas_push_data(mas, &height, &mast, false)) {
> +			height++;
>  			break;
> +		}
>  
>  		split = mab_calc_split(mas, b_node, &mid_split);
>  		mast_split_data(&mast, mas, split);
> @@ -3361,7 +3368,7 @@ static void mas_split(struct ma_state *mas, struct maple_big_node *b_node)
>  		 * r->max.
>  		 */
>  		mast.r->max = mas->max;
> -		mast_fill_bnode(&mast, mas, 1);
> +		mast_fill_bnode(&mast, mas, 1, &height);
>  		prev_l_mas = *mast.l;
>  		prev_r_mas = *mast.r;
>  	}
> @@ -3369,7 +3376,7 @@ static void mas_split(struct ma_state *mas, struct maple_big_node *b_node)
>  	/* Set the original node as dead */
>  	old = mas->node;
>  	mas->node = l_mas.node;
> -	mas_wmb_replace(mas, old);
> +	mas_wmb_replace(mas, old, height);
>  	mtree_range_walk(mas);
>  	return;
>  }
> @@ -3428,8 +3435,7 @@ static inline void mas_root_expand(struct ma_state *mas, void *entry)
>  	if (mas->last != ULONG_MAX)
>  		pivots[++slot] = ULONG_MAX;
>  
> -	mas->depth = 1;
> -	mas_set_height(mas);
> +	mt_set_height(mas->tree, 1);
>  	ma_set_meta(node, maple_leaf_64, 0, slot);
>  	/* swap the new root into the tree */
>  	rcu_assign_pointer(mas->tree->ma_root, mte_mk_root(mas->node));
> @@ -3673,8 +3679,7 @@ static inline void mas_new_root(struct ma_state *mas, void *entry)
>  	WARN_ON_ONCE(mas->index || mas->last != ULONG_MAX);
>  
>  	if (!entry) {
> -		mas->depth = 0;
> -		mas_set_height(mas);
> +		mt_set_height(mas->tree, 0);
>  		rcu_assign_pointer(mas->tree->ma_root, entry);
>  		mas->status = ma_start;
>  		goto done;
> @@ -3688,8 +3693,7 @@ static inline void mas_new_root(struct ma_state *mas, void *entry)
>  	mas->status = ma_active;
>  	rcu_assign_pointer(slots[0], entry);
>  	pivots[0] = mas->last;
> -	mas->depth = 1;
> -	mas_set_height(mas);
> +	mt_set_height(mas->tree, 1);
>  	rcu_assign_pointer(mas->tree->ma_root, mte_mk_root(mas->node));
>  
>  done:
> @@ -3808,6 +3812,7 @@ static inline void mas_wr_node_store(struct ma_wr_state *wr_mas,
>  	struct maple_node reuse, *newnode;
>  	unsigned char copy_size, node_pivots = mt_pivots[wr_mas->type];
>  	bool in_rcu = mt_in_rcu(mas->tree);
> +	unsigned char height = mas_mt_height(mas);
>  
>  	if (mas->last == wr_mas->end_piv)
>  		offset_end++; /* don't copy this offset */
> @@ -3864,7 +3869,7 @@ static inline void mas_wr_node_store(struct ma_wr_state *wr_mas,
>  		struct maple_enode *old_enode = mas->node;
>  
>  		mas->node = mt_mk_node(newnode, wr_mas->type);
> -		mas_replace_node(mas, old_enode);
> +		mas_replace_node(mas, old_enode, height);
>  	} else {
>  		memcpy(wr_mas->node, newnode, sizeof(struct maple_node));
>  	}
> -- 
> 2.43.0
> 

