Return-Path: <linux-kernel+bounces-246088-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36F1492BD77
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:51:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD83A1F22B15
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A353115B57D;
	Tue,  9 Jul 2024 14:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dsRsZxRZ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="TmnuN4YK"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C161E864
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jul 2024 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720536703; cv=fail; b=CPwqx+cu6kWvMUrGj4ClLnWsIrCb2zsmqmk4aAJbo6e0clV3/jgSUabZssAZCHj1JIOpAVEJVLhqTbMWdqhDyjEs+WMJdSoLlVzd4uiwcIK1mRvUwwA56aKgpesmppQ/KFjUBDSZtXq/c18epJ7sI6cytJtK1Tr+A1oRfudtk/k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720536703; c=relaxed/simple;
	bh=SU/8xWcVx71U80cksaKzlxSKAayFcTFD/I/TGrmOZZ8=;
	h=Date:From:To:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TNW0fS2RaUlI/6OAfXHOizbULKxO21myQsAUUc0ZE7MKBKQEGn5MnJ10s4srKYLDJVn7+m6nEGdSayFpmLfzxBmn/52CiVPhbNoPgELa6UplRVOeaD63k6u+LRuPQGcrTLRgwIaE1GGkIwh+rOo1hc8DFP3tTySylwouZkzuQnM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dsRsZxRZ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=TmnuN4YK; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469CT3Ku022003;
	Tue, 9 Jul 2024 14:51:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=J6e6ARFqKEyZOoH
	qZDY0mFiC26JlILP2xpJ+6NmhBBs=; b=dsRsZxRZHASJiuibwgmVj1edTlTBKdD
	iRf9jdzdQreK18G0KruAm8re8IMqWQ1CaLwzzmWBiT9DzbaLctUTJKVja4cfUj5m
	ZAYByBfKjteEzUD3W4kVRu6CPR8+uygtg+9UuJapNh0ZyI9COttuFuajYINpgcFF
	A3sD49y2TByWdUKPJbUaQiSb/mtb4jGs+K2h6jXE2ZEOkYhlKUrCVvlykP2hM6OA
	JxOU6shZHMIGz8lUASHfpqciFtFhFJ4qJ1B5WoLbNrB89e/2nZPNbbtdQ34SvDHB
	TZMJI8Q2wnmhmRpOsckhYEhefE1iLHdVbjKBUFMzvJYPYVVN46uzl/w==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wknn53q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 14:51:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 469E4evO005052;
	Tue, 9 Jul 2024 14:51:25 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tvdstse-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 14:51:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HfUo77gL3s2ynp6vGbHvUmosKsZTTOMnrRkSJlP2F5r5M8t5eVruBKFwSx09fzpv6HFmmR+tBgbcueUgRJXm8br2oxTeAvJUqVuglkGzR0UmUsabx0PyyyzJcjAF0lVFEAj4gThK6YTWmcJtv9p4hhR5Ed0qDLemfpk/yRP0mg36tYo2NGmS/RRjRu47T1T9Hb7gqP6lbdCTcznSa+4k5IlSrUASrGlg1Xqs/TgHO00dUd/GVEhPz7exCDgaTu4QEc3rxkHjFRamuSJwDNwHPDZhglAfbkLyJiZBk/YPp3hDczASbAj27L+6qPxdwJYMrY/uRvdH+zTc2Bl+NNsL5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J6e6ARFqKEyZOoHqZDY0mFiC26JlILP2xpJ+6NmhBBs=;
 b=FdYCGeLF1oIJ9jT/Azg6BTxJS+DyGD6yXPyBLY7YjG3CHiYpZbwdN+FtTSBPl+ZvXiPcpCKqyTU6Xh8INggFyNDq0ovFuQRM4sOzxNH88fT0qq/gOv7ftg1YFNXBK+r3J9f5yxVkg3BcIwBBZA2TOXP6uyYJwPwOqqjhwZnf1v4TpOKVCWFQ+LxQdpf5MZH1rqR/rS7rd0rk0j/KBuu5dDTrf1O8ErhcqshAQwY2id91xdHR46dlxwlIk8wiKOuJvQdXjGV7GVO2BVpAdlyQjZCFfqk1yCilhBOcK+bRDDMy0uG9gOakOQ1r1bcbD6iuBhgaoWvDEwrbXpJyFrgb1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J6e6ARFqKEyZOoHqZDY0mFiC26JlILP2xpJ+6NmhBBs=;
 b=TmnuN4YKaZYkqVBZ75sp4QK+nK/xZ7KQtzrsj3yy6IbzkVYyrAWVwB9UnKxdyBEt205uHTJxQixI9xuWwWhMdW+cjZiyzdycHtqJk7DO52m0NIqHBIjLepfE2zKiAyM9gGhJyWOY9UgdOq1If0l289hovcxmMaw2Qv6r/+DsfwE=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by CY5PR10MB6166.namprd10.prod.outlook.com (2603:10b6:930:32::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.20; Tue, 9 Jul
 2024 14:51:22 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7762.016; Tue, 9 Jul 2024
 14:51:22 +0000
Date: Tue, 9 Jul 2024 15:51:19 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
        Matthew Wilcox <willy@infradead.org>, sidhartha.kumar@oracle.com,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Bert Karwatzki <spasswolf@web.de>, Jiri Olsa <olsajiri@gmail.com>,
        linux-kernel@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: Re: [PATCH v3 16/16] mm/mmap: Move may_expand_vm() check in
 mmap_region()
Message-ID: <3b75fd97-7c57-4eac-ad5d-134925415a76@lucifer.local>
References: <20240704182718.2653918-1-Liam.Howlett@oracle.com>
 <20240704182718.2653918-17-Liam.Howlett@oracle.com>
 <8fbb424d-a781-4e61-af7a-904e281eba8c@lucifer.local>
 <e5ldsusdn3som7wn2rw76wtrhnlrxk3vkyk3iyimh6qv3ptvwu@24zfmamllev6>
 <jn4owbmmjrthhmaene5lsnliou6lfoyrvn4cxs5mbmkvmd5qoo@banbwbsp3l7q>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <jn4owbmmjrthhmaene5lsnliou6lfoyrvn4cxs5mbmkvmd5qoo@banbwbsp3l7q>
X-ClientProxiedBy: LO2P265CA0481.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:13a::6) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|CY5PR10MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: a2166460-2d1e-4a80-a8ad-08dca026999c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?cLTtCVdKOhnrDmgZdNjSePFVSk1nXgHx02X5rCQEIWQcxErR/znwtzqZ3wMy?=
 =?us-ascii?Q?LFoj6QAun8UywEY1926Dvm9WvH0uu6SkGl/FRwJlZgwKAIEXDdq1HwRSJAeD?=
 =?us-ascii?Q?wrYSOLAskU7FquryEvvLmEw+erdCbNX8OAKm1fnGhfVQb0VCoe4vG4vIqJoU?=
 =?us-ascii?Q?8gwMiqREop+hT7RF+OPPHvlB72XAOrIRL0xGU8EBtpeVefcEMzOFdxLIvnXT?=
 =?us-ascii?Q?7aC54oMXLYaykGMEDEt4FGq25FS3RUiMP32w13UXzgJSkLCynSUo1wwzWu1j?=
 =?us-ascii?Q?jwEweu4EXMy6KtvWcg/U0gUDZGbz68jqijV65lDBbD5sUIHDC4b8szcQo0bC?=
 =?us-ascii?Q?G6OdK6bqe6q/zUYzks0hZBFEyBJl4vl26E37oSJGkJotZo9QqMS1QLOvyWim?=
 =?us-ascii?Q?aqX7AVNe8+AmoWBihhw7+DEubkwGrsL6nbBaNy+s35zz9OLX5suw+S8yNZpf?=
 =?us-ascii?Q?J/A/ECpkFWyijm3f2eqAQIBazY5U0LtOq6rDw2vzsO+xSAqurgLjAowbGh6T?=
 =?us-ascii?Q?RYNnlDlDukhk3m7TFBB8tzU84+UXO43lKSaxZ/4tpGmrw0z7YzfJ5lDO+g+B?=
 =?us-ascii?Q?YCVUzkhBhH40IV4L21kiW2qyt7naNBq+H1YNxeMz0jk6QZPp4mHCDfolfmLZ?=
 =?us-ascii?Q?qNgtYT99KzyuX5REW4x/1dhuqSKTQ+1OlTF/OBfnlSRtSByrFgIZar2IBYlA?=
 =?us-ascii?Q?mVWMbfjgVYo2Lgwm9xGnV+vOWGAeyWrvd+bpQRMh6gEAJyHeKTIn+MunLpHN?=
 =?us-ascii?Q?OWh3cgyfXcSKCu0KbIHDGhHUX01h2YJ8/zyu6otxjh7sopjDJKjMZzDkTpEq?=
 =?us-ascii?Q?bDGbz7dDbmb5S9dtotkpRILJvFJPZvHD4lq6JjzBMiT6J89FYRAHMbQCk3l9?=
 =?us-ascii?Q?Xbf6rsjOrFEHIVQkhvhgCAyDGFLSqFmqzVek1fwqwsl1MvouekQYMmA8jBor?=
 =?us-ascii?Q?pRnCOjjCgIIyeFJA9s17Bj0AOQbRaLyH2w1jf4FYQ8NBHEr2eXWOcLbOjTOJ?=
 =?us-ascii?Q?kkQe7KPNEOOLvYaxdPoNW6rDroy74u2KAknEECNCyJjjyqPNLNDPLxETCTbe?=
 =?us-ascii?Q?6+77e4XL9GZxhJLm2R4pTmDSVu66z3/t0ItE2w/1DerWI107kFXA/4t9FoUZ?=
 =?us-ascii?Q?fyrMhBT1ES+3eLd9/q9+Mz1tGqtNZJmev4/EFuFIC1GhgkCsoFdoGlyDhXb2?=
 =?us-ascii?Q?jMSfc9Zv/jrOCcR1ht3QSHEIEzqhjRRrJ1Okvt4+mtc1XaRJpZoNYNKp31Mc?=
 =?us-ascii?Q?AUaofiLhUHVH+TahSTofrH5dCmdBhxb5Wc8nlkxWC0rKLMya8IJMY5D8TcLS?=
 =?us-ascii?Q?I9bcNiK5MRdfTZXA/YTzlWbirrro230h/qRYymkc9GJkQbbFIZX6LMVdfsW6?=
 =?us-ascii?Q?q4IZ/sk/7YF4fOE5kvrF8TSPlp6Q?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?hVrWlCbGp9x6srQkTWQvWfbUWL+cb+ZKJFYGqagon6gfJ+yQi74mYnFfUMp1?=
 =?us-ascii?Q?6d4XX8u+rJczkxwMQPxSYCUZdc+arYgGD7fhOEiXxZVWgaweM9t2k0iTI6eO?=
 =?us-ascii?Q?llzXjlVjWd93PKdHIjTzwsxFFCzX7OjKqUpodDfiHpmrgTnWWbPj1w5td+ss?=
 =?us-ascii?Q?bOdtECx7GCkfZ7uQ2I4VccccFwxsaiM3iJ9/9NXFreeko17K/OU/+ublDgR5?=
 =?us-ascii?Q?+f6uO1lyP2aPJ7FEnEFFxLE7c9i4TEgbDtHWT79RomkgKUR8GoZkA4lsZdvR?=
 =?us-ascii?Q?/KTFAMtMZP/lW03/JSpVcB8GLQmQuGhYZULf8rc4qpbzRbaNIPtNnMa1uzRx?=
 =?us-ascii?Q?lrbn/sPHik8rrQzqTLNb0ZRgCJ6IWgK3PYOshvrYTEIUnvyrzMHMsju0sri8?=
 =?us-ascii?Q?1EYRHWwNzKDyEsy6Qzkl+wxSCNQ+16lcJMwb+s+lpczd6Y6+ggmPAVku4IB2?=
 =?us-ascii?Q?15FME2yuCLfcrtTL2hqHiT7td7hSFuZSKrUJ0H1x/O+0Q87xmhnpUbEJPHvM?=
 =?us-ascii?Q?RpWS6cHmYYbk2prH89/LqJlSmzQi0+BeoDRjPweJ85TbHT9XpZ/9LSrbmQh0?=
 =?us-ascii?Q?sKCzwWNONz/5eSMcq/PkU0oz/UCWE0UIinOA3EQ4zXRKI7Jelzx1Rpm5FCqE?=
 =?us-ascii?Q?pGMR/JYDIMswgj3ZKwvqlQSXIY1EeyvCVJLOreSNuDm11x9ltsxyDklGYzNH?=
 =?us-ascii?Q?8ZnpzpS+6nh06BPqNb6KMnFpF/zvBm73AJ8RhBoDMaveEyh080VbRCr1on/t?=
 =?us-ascii?Q?8tMOX9QgB/ENmHWCFv2fJxhGfMjm/42yzER4RAq5hcE9ucmY3hC48wjxt1Gb?=
 =?us-ascii?Q?j81jsugtatEGCPzw4jXVcogll1E56y/SZNc59sLFSqIDEetmVmOhkIB2SWso?=
 =?us-ascii?Q?+UKboOThEH8/B0LOan6argapY1uAECa9VuZebD90iBLQjpUVLWhHUc+g0+bh?=
 =?us-ascii?Q?iHgwNUKRSSEr+/mX0ZQ0Tu1wx4csPc2gKkeHpn4SalQHxSRxdVVYxhNgItKq?=
 =?us-ascii?Q?xkFeSJLCwoLt69ypco8xTvxvJHlce0zLDAi7HHd9rsAPhDT7W8D7Uhtq2UP6?=
 =?us-ascii?Q?ciWcFiqMpF3HcXepi87222EVEYW3Ed+hpaOjtO0mu8e802jDo8ABumlDMjGs?=
 =?us-ascii?Q?zZUa16aPEYZIy/X//G1q8rcUYii6cxiAVRwaHYn3F/7J6jhWup3TD5WGtQOJ?=
 =?us-ascii?Q?0mHshxzGY8ko6V8xt23jqfMBJB1CrmtYIbqPzjHHm+/1eCXcVxQayS1IhFJs?=
 =?us-ascii?Q?Ora8GdS0XN45bSHcJE3TA3R2TUjD1TCGCzIINJxq0/NdncfJAVchZWqnVVmF?=
 =?us-ascii?Q?IL9XNiC6Zux6fi38E78ME58GPpb2c1Dx6wWj8ObOwnLRXjzQZNV1ajj+oB9D?=
 =?us-ascii?Q?ledFvCOT76+YvhIlN89ty+zQqrF6ZByXcWP1rkVVVN+AvS2ahj02BoT1eN7x?=
 =?us-ascii?Q?3cKbTxqimCztg6IEUwerlWdLfh89HcE4S65EyWX5fGXIRlQShqQNHmSq2CSZ?=
 =?us-ascii?Q?WXE4J5Yt8z1HrFcY8cS21enA0XQyh5TvLM4wpD7gWhj+u12Y4r44vFOLdXAp?=
 =?us-ascii?Q?5qQ3LzgywpNamEeRwo+q4J3q2smIP/CN2/jFrCxmrHet6iAn6j2g4GdsYdh7?=
 =?us-ascii?Q?lQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	ohZ00W0Aa+qKlmfXLdWAytF8G1hqdn6OPc9f+sLt8xu6+13iOWzcv9WusULAbdc3eQq+Y3LPLahNolfSSVFhSEc8AqRAX8U6WgQuddWc1GxlLr84QGQm94JCrdBBty5+U5RBH+p1d5UmFZoxGOb9c55vcQ/1X0bJYWBcQQEaf2suRg39JGwa6nJhQrbMjfnJbgcIuSMiasMqMCe9RVSgDJAxaYGAIwGPW3nxhhrKmNihQT3Eno07NFNl0J/WlMex0PnuR5gviN3nDXD1GbPTPSwIDgZIyf4yi1PihcIlLLRDz7a+/H7j+5uTTnrf2mb9HujYIlMTheIy61c8bLVB+YcrEHe4jXdGpYB1obkbGBG2dqMLnxO9AQyL/8T/ncn1FTV3Fi4pp1DSSpapUAOP3GMSyt2KPEE6vgBkJLZE666tPKRrGbV41YTr2ujpuEu5cuHTK7nxJxEA5vKxCZ+CGUWG9O2DSOsL2eYPsMSav+0b0n3JXLFPG2caPxNqmsQ9rb3lLz6ekjkTX6RHrufMZtkUi47KZ4u973fIbzzW/3XdsJ3GappubfZVGgnhE+uIIkFc7WpLzTGIlfzMww4moAvpyYXV7cOw4NgPMCs4QDY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2166460-2d1e-4a80-a8ad-08dca026999c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 14:51:22.6897
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKKl0Ae/InDJhYZ9Qd3DQBiCIxr+24s3DLsIi+xF8JfD5zz2WwA+1IUgOZHf0t5pnbHzaRItvYSapb+HNpSmJBb+BAv4RE9wCVkKJzbn4l4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6166
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_04,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407090096
X-Proofpoint-GUID: hVVmIC_QND9tI3oZvwRsyI7g5Clrppmr
X-Proofpoint-ORIG-GUID: hVVmIC_QND9tI3oZvwRsyI7g5Clrppmr

On Tue, Jul 09, 2024 at 10:42:41AM GMT, Liam R. Howlett wrote:
> Cc'ing Dave Hansen on this.
>
> * Liam R. Howlett <Liam.Howlett@oracle.com> [240708 16:43]:
> > * Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240708 08:53]:
> > > On Thu, Jul 04, 2024 at 02:27:18PM GMT, Liam R. Howlett wrote:
> > > > From: "Liam R. Howlett" <Liam.Howlett@Oracle.com>
> > > >
> > > > The MAP_FIXED page count is available after the vms_gather_munmap_vmas()
> > > > call, so use it instead of looping over the vmas twice.
> > >
> > > Predictably indeed you removed the thing I commented on in the last patch
> > > ;) but at least this time I predicted it! ;)
> > >
> > > >
> > > > Signed-off-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
> > > > ---
> > > >  mm/mmap.c | 36 ++++--------------------------------
> > > >  1 file changed, 4 insertions(+), 32 deletions(-)
> > > >
> > > > diff --git a/mm/mmap.c b/mm/mmap.c
> > > > index b2de26683903..62edaabf3987 100644
> > > > --- a/mm/mmap.c
> > > > +++ b/mm/mmap.c
>
> ...
>
> > > >  static void __vma_link_file(struct vm_area_struct *vma,
> > > >  			    struct address_space *mapping)
> > > >  {
> > > > @@ -2946,17 +2925,6 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > > >  	pgoff_t vm_pgoff;
> > > >  	int error = -ENOMEM;
> > > >  	VMA_ITERATOR(vmi, mm, addr);
> > > > -	unsigned long nr_pages, nr_accounted;
> > > > -
> > > > -	nr_pages = count_vma_pages_range(mm, addr, end, &nr_accounted);
> > > > -
> > > > -	/* Check against address space limit. */
> > > > -	/*
> > > > -	 * MAP_FIXED may remove pages of mappings that intersects with requested
> > > > -	 * mapping. Account for the pages it would unmap.
> > > > -	 */
> > > > -	if (!may_expand_vm(mm, vm_flags, pglen - nr_pages))
> > > > -		return -ENOMEM;
> > > >
> > > >  	if (unlikely(!can_modify_mm(mm, addr, end)))
> > > >  		return -EPERM;
> > > > @@ -2987,6 +2955,10 @@ unsigned long mmap_region(struct file *file, unsigned long addr,
> > > >  			vma_iter_next_range(&vmi);
> > > >  	}
> > > >
> > > > +	/* Check against address space limit. */
> > > > +	if (!may_expand_vm(mm, vm_flags, pglen - vms.nr_pages))
> > > > +		goto abort_munmap;
> > > > +
> > >
> > > I know you can literally only do this after the vms_gather_munmap_vmas(),
> > > but this does change where we check this, so for instance we do
> > > arch_unmap() without having checked may_expand_vm().
> > >
> > > However I assume this is fine?
> >
> > Thanks for pointing this out.
> >
> > The functionality here has changed
> > --- from ---
> > may_expand_vm() check
> > can_modify_mm() check
> > arch_unmap()
> > vms_gather_munmap_vmas()
> > ...
> >
> > --- to ---
> > can_modify_mm() check
> > arch_unmap()
> > vms_gather_munmap_vmas()
> > may_expand_vm() check
> > ...
> >
> > vms_gather_munmap_vmas() does nothing but figures out what to do later,
> > but could use memory and can fail.
> >
> > The user implications are:
> >
> > 1. The return type on the error may change to -EPERM from -ENOMEM, if
> > you are not allowed to expand and are trying to overwrite mseal()'ed
> > VMAs. That seems so very rare that I'm not sure it's worth mentioning.
> >
> >
> > 2. arch_unmap() called prior to may_expand_vm().
> > powerpc uses this to set mm->context.vdso = NULL if mm->context.vdso is
> > within the unmap range.  User implication of this means that an
> > application my set the vdso to NULL prior to hitting the -ENOMEM case in
> > may_expand_vm() due to the address space limit.
> >
> > Assuming the removal of the vdso does not cause the application to seg
> > fault, then the user visible change is that any vdso call after a failed
> > mmap(MAP_FIXED) call would result in a seg fault.  The only reason it
> > would fail is if the mapping process was attempting to map a large
> > enough area over the vdso (which is accounted and in the vma tree,
> > afaict) and ran out of memory. Note that this situation could arise
> > already since we could run out of memory (not accounting) after the
> > arch_unmap() call within the kernel.
> >
> > The code today can suffer the same fate, but not by the accounting
> > failure.  It can happen due to failure to allocate a new vma,
> > do_vmi_munmap() failure after the arch_unmap() call, or any of the other
> > failure scenarios later in the mmap_region() function.
> >
> > At the very least, this requires an expanded change log.
>
> After doing a deep dive into the vdso issue, I think it would be best to
> remove the arch_unmap() call completely in a later patch set by changing
> the two areas highlighted by Dave in patch 5a28fc94c914 "x86/mpx,
> mm/core: Fix recursive munmap() corruption" back in 2019 in regards to
> the powerpc pointer use.  But that's for later work.

Our replies coincided but yes absolutely. But should be a separate patch,
agreed.

>
> In the above mentioned patch, the arch_unmap() was moved to an earlier
> time to avoid removing the same vma twice from the rbtree.  Since the
> mpx code no longer removes the vma and powerpc never removed the vma, it
> seems safe to reorder the calls as such:
>
> can_modify_mm() check
> vms_gather_munmap_vmas()
> may_expand_vm() check
> arch_unmap()
>
> This seems very much fine because:
> - powerpc is the only platform doing _anything_ in arch_unmap().
> - powerpc used to work with the arch_unmap() call  after the vma was
>   completely dropped.
> - The vma isn't even dropped by this point and so all proposed changes
>   will be completely undone in the rare case of may_expand_vm() failure.
> - The arch_unmap() call doesn't need to be that early anymore anyways
>   (mpx was dropped by Dave in 2020 git id ccaaaf6fe5a5).
>
> I will make the order change in v4 of the patch series in its own patch.
>

Great!

> Thanks,
> Liam

