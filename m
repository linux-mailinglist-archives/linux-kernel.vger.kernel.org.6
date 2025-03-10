Return-Path: <linux-kernel+bounces-554583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6367BA59A2B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 16:39:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B603218919F6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 15:39:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02A4422DFA3;
	Mon, 10 Mar 2025 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fk6wlPTI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CCaxWWac"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC55422DF89
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 15:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741621126; cv=fail; b=QqxSZRo27GdcHtqwrFSYI3siZovTohI9L7ad8VDbjFeFufXdeJaiZTT11LTXXDU7F63wre4y+OqYq4IXLdTVJI81MzmFlNxDKcz3VB5i9WF0srOUmumyemTTVNv/QhmXBt88JgJjOhujw6PCSvZleJNdQYGQqar1qaxox0upHwU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741621126; c=relaxed/simple;
	bh=BDN+xYAlBdS8JnlRE2TGsD/aaZLGJQpxpgpYA8oj+ho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=h88QeAuGk9XAQsTi+Pw/uJ8exJULGtEP4OFW7k3OBPUL31Sv2vBmXArkRuz3g+owl05NGN4MxVj92JFM5z+YObxk0lxahJaoXhmteFsFgoZuLriuXZH5FjsCnHRt+PmJEBhTpjg+GQQddRaf7wdpFm39PDZdag8WOrBTgXTHzIY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fk6wlPTI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CCaxWWac; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AFYFlL024296;
	Mon, 10 Mar 2025 15:38:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=kb4MqJ9jsrYbnJZEzJ
	iRlzYaO1N000teEcBwTsmUkHU=; b=fk6wlPTIHtHXAvxhyBLIrGyzTkai63N9C0
	AZ63zz4GdAAqbBP2eRjKajUxFQllAXcTrMvwzJbMzu9940h/vFckbA4cC072DJBY
	kckyxwRbU8JTQaZOxcXuoc9iTrnehXGl8gOdm+23PJedggaflqS2DUKQpYIPEx0q
	BjHBLf+in82iolDLQJr34sWQiSaaWh2AcwS3XhdYPXGN1czKhN5SV1zP+LYzshrO
	+/wmLCayqc5WnkDNnDsoWLQ4XOWx21d/SUw0er8VJKn7+/jQ5OjZ+WEQDFHLCbJ5
	rW9uwxwOaO4Vs4Wzzl+yVtY3duKsnCMDJcQPlJ5Vg+zSNRr9C/Kg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458dgt2uv0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 15:38:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52AETWsF019363;
	Mon, 10 Mar 2025 15:38:23 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 458cbe9acr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 15:38:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVSa4YS4vUPpHOHbyKHi0AT8U27q17yv6DaGglHbppHXVXpbN+pll8m6+mMNm71EqKADb7NmaW4ka1H46IECfSeUABOugchXRMA6iMxsa1lxOdcyzzJJNtSkOlhoUoZav4RLDrX8B8j4LjsoKYL95fhnkT3O6RBHoGk96sv1vQ9MDmtAFUZhAgziRQT8ypAw0fbRLh9E6TWrqyseLOSMj2Y6vxQoCl7BQ/CT8St+eDk3WOQgljMzGh4vjNiB25ujzUeIq56C8VTrJCDhgAW8yw7i3NjH10zY/oZADAx72MeUyFnF2rtVPYTRihuzDnfqs5XagruzXVK5uELeHfvkeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kb4MqJ9jsrYbnJZEzJiRlzYaO1N000teEcBwTsmUkHU=;
 b=xGbtEvAWR/+1vD9plmaQ2lIVdl+eZ26wh/pjOjnYhHWXZbaLxrk2yXzx7oAgSfVgPHWoC0pbbh6fA3MnNTeyz1gZXqO9Sqif6UP7cRKrSl+4vd9U6cEx1IXODFP7Dv51m2Cp+85nBUU5H7x9jFxJ0dHv9FsIv4czXnA40sxeI2cYmgjwEOaPxOrGRZcOAQDg7n3WT1lEc+4ytNK6/K4EE9l4ghL1uOXOiMb0piwYFj0SpenhH/iI7N38ILVozIbl7ECXR20UAa8LtnzxVfd1uYFw4fzPtlabDcTTLsBYk43QjDI5Sd/bSIU1HnEitOVNbm86AseZF+8slzJ04Zyc1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kb4MqJ9jsrYbnJZEzJiRlzYaO1N000teEcBwTsmUkHU=;
 b=CCaxWWacGN0ByNONnkLvOnJQtLOcyRf+MFRi6hMFouUvsPEpH67ebG3v75wBEEfL3a1U5+hHJvn4T6GrLc0P+RVEblLLIRG4QM9nRLR0N7qddnOIE9ULegxr5/t4orsTyBKkknBEwWc3XdN0LYNpWG685hTjELn/iKL2uPfqfXk=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by CY5PR10MB6024.namprd10.prod.outlook.com (2603:10b6:930:3c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 15:38:20 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 10 Mar 2025
 15:38:20 +0000
Date: Mon, 10 Mar 2025 15:38:17 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jann Horn <jannh@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Harry Yoo <harry.yoo@oracle.com>,
        Yosry Ahmed <yosry.ahmed@linux.dev>
Subject: Re: [PATCH v2 5/7] mm/mremap: complete refactor of move_vma()
Message-ID: <06e4a72b-d599-4ba0-8cfe-69050b955768@lucifer.local>
References: <cover.1741256580.git.lorenzo.stoakes@oracle.com>
 <bb6fa26fe29c5ff6cdbb162fd9ffdb0b050dfefe.1741256580.git.lorenzo.stoakes@oracle.com>
 <99922cca-ed8e-4996-8833-a89264783b28@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99922cca-ed8e-4996-8833-a89264783b28@suse.cz>
X-ClientProxiedBy: LO2P123CA0024.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::36) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|CY5PR10MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: d6d4fd45-76aa-4a96-b661-08dd5fe995d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ieAK3paNu+xRgmS/r2hcqnZI569KuYWi3D0ASR/Gg3uPa0J4RJo5Gxo5uZl7?=
 =?us-ascii?Q?0Sc4XFUv3nPtZL5eXBZ6bCPeafr+dRVOWpiPEj+EgwmqJbCVTIPSIsjBCznY?=
 =?us-ascii?Q?Oqfwyx12CHHvvX8ivEy6vvNLo6gD1ZhMjgFaQ6a9OwwKktrSMdhoq+/c+o9j?=
 =?us-ascii?Q?U0bP5NuuP+7ZzBLRr8b8phr59SOaHxFXkBxfVxgjOiVBQUWXMlb3Ri01UbGl?=
 =?us-ascii?Q?JURYGe9hLiWxe+QXPFtQ0EI1kW9nEtNvFUq9i9EFMyTq5B8EtWUsrjGCnrHQ?=
 =?us-ascii?Q?BBeFBuwl7/w0hZupVbQFbqqsXYFm5aQPtmd3QvsV5iSYYsQ+VHSsqX1A17yu?=
 =?us-ascii?Q?5fcenJdIea+1zK39O6bGwGHSKJ7Af9Hae+p7omSD8IUgL4UN1BFzd/tHmiNs?=
 =?us-ascii?Q?fImM1wMgGeWviMQfpOT2mAFX1bzMQeccmqJf3zZ11vNsGfdJm0jA2VLMOuSM?=
 =?us-ascii?Q?yCgoccl5ipSG2rNpFR5V5S3rtO8vkbQKURWHx3ob7wdLv6C9P5f8EUEKdgq+?=
 =?us-ascii?Q?vsGdREU4vMjBp01ZJB+U9g1PFCvFEI4Em+etZ90ahmum1EgGb1AukoT0F4EY?=
 =?us-ascii?Q?r4BPy0zbm7S6kA1+NW1r2IxTK8Yq5On7MvXbn2MlF5obg5bC9mgvSHxBSB+1?=
 =?us-ascii?Q?RmDmhbmG3JLyN9Vjkyg4EDCYKHNCYilWqyTgPGZ5bbCCFj93V1VXf9v3su0A?=
 =?us-ascii?Q?FG250V6KxA96dtVyjJZqTrBgXL1oE8B8d1YySuRzRKMeSWGW+Oxfvcl3h5A3?=
 =?us-ascii?Q?EbyclNJi/1GA+Xhs7+1MsWUaqVRB2ZJY1Hh8lAulQir2BQYi91IiDiHruZaL?=
 =?us-ascii?Q?IrPo8omatBvWbpmO5wbIthrLXYoAYbDlSwbw9NtQ4Wh1BrdHp8IeJN5va0pL?=
 =?us-ascii?Q?4C9/YKs6qckrDau6dPNunaZmxH50WxYNvFl1CLs2thM9ne28Br44YHXj+Mj6?=
 =?us-ascii?Q?uy8CjTGiCQk6T0B5FwIpLo3DFIEVvSwzXoymCT3WJ+b6PEj8IVEjLW2Cz6Pn?=
 =?us-ascii?Q?RCyZKAYBU/34U87Oranc9vCOlEZBQ7n0M1pIDIULaSocYRO2jD91Mbo6dYCJ?=
 =?us-ascii?Q?oYWkk7vp8DHC1WlBKznlgM+kcXBiDc36oRDDBmLE7j7f2ckX/ypyqe4IcUBQ?=
 =?us-ascii?Q?Mmhf2WGmCXj26z78MDOlfY8S0ePrYRvewvnHWcOkdTFWQiw3s/zUtJluoGFH?=
 =?us-ascii?Q?qOdxXs8WCl/SFNxm8ySvqXM8aNFpZNjEd9iUOOXCjSujvvo1l+HmLiIzCP52?=
 =?us-ascii?Q?DRjpfIk0tiWC2f3qPgbm6gqpu3Tlh3pR5utSKCvMji65ml9g254KnF49Yw5e?=
 =?us-ascii?Q?qVplJQzoHPMeEjYrZmVP+9p4Qe3Xdsf2Ry4LQu4b7UhhSwaa0AQPQkWzAxvz?=
 =?us-ascii?Q?WCL6y27G3G5wKI2MzF5XI3Dd6nhJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8a7C8kH+2d1S35Zx6NGAVF/ALwkOPjCHHc1hzPGmfPxNhDUuVmrLv6B/jjqZ?=
 =?us-ascii?Q?UPs+DsQ7NfAb2t+uukZyWvujjuXn0/3moevKFFDQuh50m+k4rhEzEXmuyoBF?=
 =?us-ascii?Q?swWn3RgeSqPHnu6VrOY0W0p+A+YatP/EzDb3B4SY50JmiILQYSeGhB2shS7/?=
 =?us-ascii?Q?Uq9ygOp7sDh1bH6keRW9D/Y70DjPHc9dnIpc/fA3xQd2Te0zc18oXNHQpE5X?=
 =?us-ascii?Q?ddfF4VEjD1Prnf7Fp3SQkqpoCPkwRgp9pOsdGTnQO11Xt2SRjFyNIfwA4sN2?=
 =?us-ascii?Q?GesZHbZFajg2Orzp5sE9eoN8fTu0ZzSuQAlVB+quArsuwE7Z2HLZJ0NQ9Gbt?=
 =?us-ascii?Q?aIJ0Av3evpsrFJmlGgcpV832PLFkouQNc9cVgJfvQyWQkNvwlhQ44x6j6wPM?=
 =?us-ascii?Q?VItZQKFDRPd0aBkl/VCIpeHaUpYZM+BTYf8XCFBVJNZZgrPAKbUfjt/dtVO3?=
 =?us-ascii?Q?FiHkHuh4i0kEQtHOw8vZdI8oTj0v9KVgojPhlzQfUNY2aYQYS+IwxkYBL/hy?=
 =?us-ascii?Q?g/RhAvyArCGbJjl6vLdNN35i7fn7/SNgJ8K6ZBCkLUynggbh+f+E3vuKnQgB?=
 =?us-ascii?Q?E98f3cghxs9WBb2iQ9r7dmQPyc39fnwQIoRIYkq4byL1saDCKuI+L/Q5QCVw?=
 =?us-ascii?Q?FXco3MRO5Zihhe5bOlX/N8fI0P8YUyJR2NwdinOKEyCvxwnVOz9eeWFNkpQm?=
 =?us-ascii?Q?DQbEmlzUFlyROoJNZUofwddmMJwbdexkG5RrTe1O5Z2a70tWrYUaZ9VYFixX?=
 =?us-ascii?Q?as8ral7STR+6IE633W/FWx4dZYn8PUr+5IxIT6GHyc0voFTHzfT4QfsMKWPk?=
 =?us-ascii?Q?4jNPyl8CrlWkN7V5Yk91oYURtPcYVg/3KqF5OgZfyoeDdUufu3bo5PI47RZy?=
 =?us-ascii?Q?CMiocXMEza+1z6bEFPUlU66HNsL2rSDzPdZ6xJu1nBrYQAmg4HDHIC2PfFct?=
 =?us-ascii?Q?b9lHhF813xdL/AscKi0/ThTbfWBSEfaziQ6UpjWwrc5M8Vwi97MqgWr5X4IM?=
 =?us-ascii?Q?k9ZLW92W06DF+PbQwOn8FKkFB9jlktRsFgb3brIKnBsh4pwfv32VCu8DTic4?=
 =?us-ascii?Q?2iDzunudDJhDaD6gX7/L1MqltEBKu1NlocrRl05W6Le1knf+DdgzkZ9l5ls9?=
 =?us-ascii?Q?zYxAqwuXPyqSuLAqOvRCeDi7qjgPL4OtBzWEQSiKpRbUBgopYvVro2+wkb6G?=
 =?us-ascii?Q?hdGOzoCJ0mgOgdVBgouNGJgWU3BL3R0G3erLunLQjbk6PgaPG2rTAh5QjX29?=
 =?us-ascii?Q?QidvmrSo8lUeuB74argyXI3BgM6TuFKRR7Pxlvnqib1mlzRDznIP+l8KoeRn?=
 =?us-ascii?Q?VT/KQyTDBhJqvy9hss9Bqqvj/DNRt15rjqGRDeX3Rim+zHQhR23atLvMXKIb?=
 =?us-ascii?Q?zP1tK8Kl4H9BuyoRPiaO3DcfeA6SxZvIOYlT3UdXhIb72MDx7F0t9FCXuWC3?=
 =?us-ascii?Q?JCBrFRkEODRj4DgbtDDC2S4wEoRUUweFqAtfF21V6D/6XDBvAQqMwTCmfvU/?=
 =?us-ascii?Q?pSwaVjhbdxYCCMDOGT6ZYo3G0vTaeAicTWi8PLtAIUowJJUSL2hjxqqlojux?=
 =?us-ascii?Q?gSuryeNRkh0zNLpvvTFtXH6B3X1ufsjv8GPcAkEH7ogETJac0ItQ1eYQ8Z4W?=
 =?us-ascii?Q?nA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6I8j/wuvgGdKY0/UWvYLiDgh1oYBvc3CEngDryn+6wOaWDwdvB5HYPYxOY3Vh8AIRYDY1b5VWjcaMFaWd9FOg0z972sPjbIJOodStWy+M4DwsfqdgBlXn0+u3535Rpa16eUJmSaYtbF69Fixe2JLOSJaV7KdiaNNze51g0+Sqez2wMsYjXkoWKlPoeIirsWgUIJqNVIhOSK3Dzi28wT7IoHXJ1KN5lHRjXuySd11wkgS0B9/XyVkrvt/tR0TtNUsB1ER2d2F/SCgVrTqJW5byNaPWLZRjNJauIem95ecO/mffquMhxHeDpqj4OXnLgTkZYWXlyMeH3rCFb83hdZT7/lE5tXnPaB1Vo540QeaK1Xgh7F07oU4p24+HIkkClsD/I9exuoKe4Lhg+vrWj05aYDBSbXTxTCwO4A6mCwbeOAgcHtnhml5I0t4E+24aFcA65qJi2LX/VPa1OcK7xjs0bKVkon/fnhXdtGbvG1bZFUQ0BY2GLe8BUhCmZQY+/C36NZiu08bB0ejCnHlNcochJ53JOZ5Qv2PSPszV8jWxNKZOMOtEx1JX3DXW6c918dYtrYKfSeqHvxm1eu05FIg+KKm6pn645GJRbbrK/F2RkM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6d4fd45-76aa-4a96-b661-08dd5fe995d1
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 15:38:20.3244
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0GFfF/k/qspqoFQgAyySy2zYbkirLNzL6GUqKlFfsCPtSY9wsRtY51yW/lblm4g+y0IxTKONfx86r2A0zv3A/nTx/ilFPoWzUdjBANGUT+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6024
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_06,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503100122
X-Proofpoint-GUID: cjBggR-2B_vPJOQeU6afn6Sc9kltMtl9
X-Proofpoint-ORIG-GUID: cjBggR-2B_vPJOQeU6afn6Sc9kltMtl9

On Mon, Mar 10, 2025 at 04:11:59PM +0100, Vlastimil Babka wrote:
> On 3/6/25 11:34, Lorenzo Stoakes wrote:
> > We invoke ksm_madvise() with an intentionally dummy flags field, so no
> > need to pass around.
> >
> > Additionally, the code tries to be 'clever' with account_start,
> > account_end, using these to both check that vma->vm_start != 0 and that we
> > ought to account the newly split portion of VMA post-move, either before
> > or after it.
> >
> > We need to do this because we intentionally removed VM_ACCOUNT on the VMA
> > prior to unmapping, so we don't erroneously unaccount memory (we have
> > already calculated the correct amount to account and accounted it, any
> > subsequent subtraction will be incorrect).
> >
> > This patch significantly expands the comment (from 2002!) about
> > 'concealing' the flag to make it abundantly clear what's going on, as well
> > as adding and expanding a number of other comments also.
> >
> > We can remove account_start, account_end by instead tracking when we
> > account (i.e.  vma->vm_flags has the VM_ACCOUNT flag set, and this is not
> > an MREMAP_DONTUNMAP operation), and figuring out when to reinstate the
> > VM_ACCOUNT flag on prior/subsequent VMAs separately.
> >
> > We additionally break the function into logical pieces and attack the very
> > confusing error handling logic (where, for instance, new_addr is set to
> > err).
> >
> > After this change the code is considerably more readable and easy to
> > manipulate.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Thanks!

>
> Some nits below:
>
> > +/*
> > + * Unmap source VMA for VMA move, turning it from a copy to a move, being
> > + * careful to ensure we do not underflow memory account while doing so if an
> > + * accountable move.
> > + *
> > + * This is best effort, if we fail to unmap then we simply try
>
> this looks like an unfinished sentence?

Damn yeah, will fix. Will wait for rest of your review before either
fix-patching or respinning.

>
> > @@ -1007,51 +1157,15 @@ static unsigned long move_vma(struct vma_remap_struct *vrm)
> >  	 */
> >  	hiwater_vm = mm->hiwater_vm;
>
> This...
>
> > -	/* Tell pfnmap has moved from this vma */
> > -	if (unlikely(vma->vm_flags & VM_PFNMAP))
> > -		untrack_pfn_clear(vma);
> > -
> > -	if (unlikely(!err && (vrm->flags & MREMAP_DONTUNMAP))) {
> > -		/* We always clear VM_LOCKED[ONFAULT] on the old vma */
> > -		vm_flags_clear(vma, VM_LOCKED_MASK);
> > -
> > -		/*
> > -		 * anon_vma links of the old vma is no longer needed after its page
> > -		 * table has been moved.
> > -		 */
> > -		if (new_vma != vma && vma->vm_start == old_addr &&
> > -			vma->vm_end == (old_addr + old_len))
> > -			unlink_anon_vmas(vma);
> > -
> > -		/* Because we won't unmap we don't need to touch locked_vm */
> > -		vrm_stat_account(vrm, new_len);
> > -		return new_addr;
> > -	}
> > -
> > -	vrm_stat_account(vrm, new_len);
> > -
> > -	vma_iter_init(&vmi, mm, old_addr);
> > -	if (do_vmi_munmap(&vmi, mm, old_addr, old_len, vrm->uf_unmap, false) < 0) {
> > -		/* OOM: unable to split vma, just get accounts right */
> > -		if (vm_flags & VM_ACCOUNT && !(vrm->flags & MREMAP_DONTUNMAP))
> > -			vm_acct_memory(old_len >> PAGE_SHIFT);
> > -		account_start = account_end = false;
> > -	}
> > +	vrm_stat_account(vrm, vrm->new_len);
> > +	if (unlikely(!err && (vrm->flags & MREMAP_DONTUNMAP)))
> > +		dontunmap_complete(vrm, new_vma);
> > +	else
> > +		unmap_source_vma(vrm);
> >
> >  	mm->hiwater_vm = hiwater_vm;
>
> ... and this AFAICS only applies to the unmap_source_vma() case. And from
> the comment it seems only to the "undo destination vma" variant. BTW this
> also means the unmap_source_vma() name is rather misleading?

I agree it's only meaningful in that case, I am not sure what you mean
about the undo destination vma case?

We have 3 situations in which we call unmap_source_vma():

1. normal, no error move.
2. error has occured, so we set the source to destination and vice-versa.
3. MREMAP_DONTUNMAP, error has occured, so we set the source to destination
   and vice-versa.

I _hate_ this error handling where we reverse the source/destination, it's
so confusing, but since we are doing that, I still think unmap_source_vma()
is meaningful.

unmap_old_vma() is possible too, but I think less clear...

The beter fix I think is to find a less awful way to do the error handling.

>
> So I think the whole handling of that hiwater_vm could move to
> unmap_source_vma(). It should not matter if we take the snapshot of
> hiwater_vm only after vrm_stat_account() bumps the total_vm. Nobody else can
> be racing with us to permanently turn that total_vm to a hiwater_vm.
>
> (this is probably a potential cleanup for a followup-patch anyway)

Yup agreed, but let's do it as a follow up as this is how it is in the
original code.

Will add to the whiteboard TODO...

>
> >
> > -	/* Restore VM_ACCOUNT if one or two pieces of vma left */
> > -	if (account_start) {
> > -		vma = vma_prev(&vmi);
> > -		vm_flags_set(vma, VM_ACCOUNT);
> > -	}
> > -
> > -	if (account_end) {
> > -		vma = vma_next(&vmi);
> > -		vm_flags_set(vma, VM_ACCOUNT);
> > -	}
> > -
> > -	return new_addr;
> > +	return err ? (unsigned long)err : vrm->new_addr;
> >  }
> >
> >  /*
> > --
> > 2.48.1
>

