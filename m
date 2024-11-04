Return-Path: <linux-kernel+bounces-395212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A17C29BBA58
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 17:27:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDEF5B226B9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 16:27:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16731C2DAE;
	Mon,  4 Nov 2024 16:26:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="igWRG2Bo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Tmy5TVfR"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296451C2450
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 16:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730737617; cv=fail; b=UE2LhVTPlnWzGBvch464jCFA9T71an96pZjDiUojIRpVYavHLzHAhFr7M3tFfm/HnhQyxSKq6kz72Bmfy1qDjYuIlD8/qeDrcQOijmh+3nUJo0VHLJS9pU9Dem+9bwfaStr0eNq1PFXaEhPLs0xdthwJtGGtrQrHoa2NCAw1rEQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730737617; c=relaxed/simple;
	bh=3SXz6MV7GNmImXD0KaN0P0flX3jmHloLzvH9Qv/Jb40=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QOuoP+vk+5aAgdOB/AHtulRYnPJL1UFQ+wMbm1TNqWQeHCBOo999Or15pqhVU81Vwddfsv5Mu4K8Xc0R7z7bo8QC0AJFTEVQ+Vhp+FWKe9L/Mwm/0Rq15kXCuvXJA1H/6py/14TdM226qzGGGsrRKGDER8jsIKQ62CyJb1zyZts=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=igWRG2Bo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Tmy5TVfR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4GMbbn010234;
	Mon, 4 Nov 2024 16:26:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=3wwWyyaOWn+obBV5YO
	YCkzjAKVM2E9xHsENEdx8k+AM=; b=igWRG2Bo6pyMDLly1kCvylc8SQqiZVE0s2
	pGpZyCwx6ZT5gIEj+dgJzEKn31blcqavnTyEI8x6QfvCVQYToWNttjCbxun3wmI3
	vQ/uCWiIeJJKO4Cms9oqa0B8HBG7ixCs8qEQgA4PkHnM2aK1mW4Tg0R3LeUaivPG
	Z8V9RabZZu+TrUkzJprG7tfICqLH2tXAqTvpGra697He1Jk1YygCF6diBr1DQGQi
	/e6+J++s8TkWPQb8G1/MXG7pgsETTqEkwmR4/O5Qp9AbNKyb0KQWzV8qjiCip9HI
	a9cGeiH6O8ubZjjHsvVr3/bIF43vj6rg5He4ZmoO0VrE+wVs/g+w==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42nc4bu5gf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 16:26:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A4FZXZw005170;
	Mon, 4 Nov 2024 16:26:39 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2171.outbound.protection.outlook.com [104.47.57.171])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42p879cx5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 Nov 2024 16:26:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nC0yBvL7MQCWdunYnAXeFeJbdTY531nlOLc/mI98vJk8RzZuAdEAdIdZWE474U3dALdod3+Myk1cZUsrhbxxYBHKfJbfbwd+MSC4Hkn8SCarV0AZKcYqUErmNCew39KTNolR7v9fztzTbeu+lPGE/4Hvx1MQdlnmzb2P8L+zR4fpV0cioXgtydC+Hn01ix2ImF460vY2584/cOu/50kC6scgR2Bl6y3qRYRHF5cUYtVHtfpUv4qJJqJ96SiG30qqmZftTMldNhrlqrNlcNQBoiZjnUhMpklp6B0FP5sE+sYavG41Ieu31BR0pHQMYH9MSmvyGeWF/jVNYBS+5CBM0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wwWyyaOWn+obBV5YOYCkzjAKVM2E9xHsENEdx8k+AM=;
 b=LrbX4w9sQmiHS9LTBLaEfJ6s/UhvPRdhPZtR9l4BGgzMibMirCoYuK8334SBsx8k/K0eqYH7Vc6NyAA314MgHUhEmTMZs2FdKcZlhr0acmwNxdWO0EXSAiOB1DTsCVArfIKyF0hyPV4s/2uRJpim54bmAv7XzjncKPM7ciyIgnbkFd7nYNLM5V6l57vQKGrS0np6RXX6hI1RgxxyrWtuaf1EtixRfy++sKZ05fDk7t37dbO4YWtl7lAktZvfFbnOYl3azCVaNnFsF0djHZYZIyYByG8v9B9IwkOC6FAOrleUmYweFqCpRms0FCu7JYmIWmdajyngP3R3zqXmilmJ+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wwWyyaOWn+obBV5YOYCkzjAKVM2E9xHsENEdx8k+AM=;
 b=Tmy5TVfR+y5acWBVoZiSZhqfk7MBNJdSSl/f3a+wJ9M66WzsDnhu/bxD27fSuA1oauhb8knKhJj0GApxEnz/WjlRfCK3/v0LB3Ln+lIf5P7AvGPAKbfwizz+OIua7ZQp9kfyk0w0yf93okAd7LPuW1JRqNIdFOL1bi9EMllY74g=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by SJ2PR10MB6964.namprd10.prod.outlook.com (2603:10b6:a03:4cb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Mon, 4 Nov
 2024 16:26:35 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8114.028; Mon, 4 Nov 2024
 16:26:35 +0000
Date: Mon, 4 Nov 2024 11:26:29 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: syzbot <syzbot+dee8aa54cb2f5a150f9e@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, arve@android.com, brauner@kernel.org,
        cmllamas@google.com, gregkh@linuxfoundation.org, hdanton@sina.com,
        joel@joelfernandes.org, linux-kernel@vger.kernel.org,
        lorenzo.stoakes@oracle.com, maco@android.com, surenb@google.com,
        syzkaller-bugs@googlegroups.com, tkjos@android.com
Subject: Re: [syzbot] [kernel?] kernel BUG in binder_alloc_deferred_release
 (2)
Message-ID: <zgopoeun6qh6olzr7rogagibyhpdr4n42cakznftggwq6dwss2@4lyki4vw2dkr>
References: <671fbcd6.050a0220.21b2f.0009.GAE@google.com>
 <6728f46f.050a0220.2edce.14f6.GAE@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6728f46f.050a0220.2edce.14f6.GAE@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0124.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d5::21) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|SJ2PR10MB6964:EE_
X-MS-Office365-Filtering-Correlation-Id: 94d646ed-c80c-43d5-59a3-08dcfced714f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vzl//bj6BsOsPru1zHsoHk/FJxRAg1tmqliz4iy8me5Gl/JnfUY/PXtueTyq?=
 =?us-ascii?Q?DrzLdKvrD9EdmKIl4XqzhFZkHXliNOkvoIt1gyP7CboenAdcxQ/6TqQ5Ywbl?=
 =?us-ascii?Q?AEOWV1UxPJ17lkO4P8lQ+ksrKQGmxnhidGIH5fssiSPFzPNY9le7a4VsdpCd?=
 =?us-ascii?Q?B0yvh8cg/fsYSzEJ4zn8pfQMUkxwTPv+4FjEH1jnRbtCYEvIVKfGPb9TaVxt?=
 =?us-ascii?Q?0SGRXLPwOz2MLvgR3Fj4JkNmrdLmBsIbDN1qvgiP/DisbTcCTC09cR8TtlCD?=
 =?us-ascii?Q?CidsIPzJ0BH42D9Ca2CKSxHjqr+nYzdpnKGn0LbH+mECpGS5aaUclg4BhdC4?=
 =?us-ascii?Q?JMllqm7KLjcyx1NJe9fwj4+TNsQvToxbxYa+EyeSjWyNU4EBtlR8gTMo6hHa?=
 =?us-ascii?Q?uG4jb3UHM9f7HaQ9wMDNnBMpwvFpEcUWPjPMvTuT87EySj0YCg0NZToOZoso?=
 =?us-ascii?Q?kJXND24j90QHnrDx23sGQoqKjgCIbdUHl40Zye1v+XhcM3pTA06+KV3RdSM5?=
 =?us-ascii?Q?Du2tJqgFlnoaBHpsDroNdXq8feuc9HZVNw52f+TiB+jTymVJjm0pw7d8ucc9?=
 =?us-ascii?Q?LdXLXDAXkeV0Beu/FK9Yje0NpAYFtdr7l3+BlFbTveSbc9z1dnqLq1Qhnsd5?=
 =?us-ascii?Q?sEeJ62/wAggZUoudcXvHcrGH8bzsmN4JJRxdcgUsl8GPuyaIMjVv0xW8K7/V?=
 =?us-ascii?Q?qQv+VfbO+Rk6H2yWlB2cP9xyepfjU34II3zrRZK73qB5JMzAGM0C5AE5PAWA?=
 =?us-ascii?Q?6jt5NPsqiV0QJ3GJZ1tD6AdXwuGT33QmIv34AN7thZvdFDyQ6hM8HrADR6GE?=
 =?us-ascii?Q?RRSpTV1pqAmGKvyCwOOKJ6dBwna0Jnf+n7QfuJ2M2LHWd22KTVEUjJ4JRIVN?=
 =?us-ascii?Q?2rNcqmCN59VsNfT2NqVG8hzaGHIwXcBLlGmfyAHpoArtWWvzTu57o4YBn+r0?=
 =?us-ascii?Q?rPSfVmRDTCKzCy2LlssYg+6gqyb3LHohk1pUPnC1eKQnKlMB8FWhH94Lz4ny?=
 =?us-ascii?Q?w/QHGrXoXAOib3zxl2jn4Sn1GOTwutotn7mCSaVRLfslUzCM8vg1NpzT3KYE?=
 =?us-ascii?Q?KieqjhRsdZFwjPGZvoop7z83JPYjXfIkHhJKNuBdPyIa5FZpSpozIlq5AvPw?=
 =?us-ascii?Q?D6WWYiDv4DD5T0J1DAhLJ6QCW8FnneaNium4qZpe62vfaktYB8pobzAKAyLo?=
 =?us-ascii?Q?vLE/lbKj4QyEiAQxZA2cEeYYcua/LHmG0MsPgbaWRoQ5QdjfJLsL8ykoMGVF?=
 =?us-ascii?Q?D2K4JRwUok0B0Ujr3pHPnxUat66LWhXwTPdvdZM75w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nkXGNLQOXvOkLi/RMyjtzkqa9v1ZfD94CM9Bdkf5nHtCHcG8y8r8adAw9l5G?=
 =?us-ascii?Q?FyQjBsuzvJ9UGX82SDOoCzT/mliGFAthGednuz+UGk2+fZmSA7q03Rl9Ryxy?=
 =?us-ascii?Q?Zl+upJL3ALJMTx35iKkqcF6PEtfYcoFzLBZ4vCNliul/9NyIFkVmaPq+MLoD?=
 =?us-ascii?Q?/X/gQhWyzRVzz5/jegfhSz7AKkTr2ONnOvkROlCyu8iPiykALv+xF3O1tj47?=
 =?us-ascii?Q?9M17gZTDDDqaReIfMz1Faeckp+hnQwbzdqiaYuobTIHuJqAbsGQq0u8xT1HD?=
 =?us-ascii?Q?9WxhOpon3MXWQuW38rPxVdJGOTDxbhVO1MgAiix1p6DerD2hDPdudZG494WA?=
 =?us-ascii?Q?Pm/F8WCawWCB+Mf+FPZZwcKgkVmg4VBMQycGfNK9cFePKR3yC90W6n1m6qeT?=
 =?us-ascii?Q?LAnVL90X5O1JSIPsvYf5H3mNHtvMMPHd2SB/cEigHNuoCiZJiDVEEchC/ETM?=
 =?us-ascii?Q?zFiXM6ICJwB7ytBN3FrhvxyVBCIKjZ60kPELoKi3F6y2lcbpI3CElkvy+a1y?=
 =?us-ascii?Q?W3EDOhzrndfWkuwsCEBbzUbM+A6k7i5lVhTBPslZUTEPR5xwB3thm2i4/I1+?=
 =?us-ascii?Q?gtkYuvI6FpGXVqIlNoDA6XbmxTH2bbV5brCKmVQHI+PqdklEDVl36iv9Jm2Z?=
 =?us-ascii?Q?qyHu6FkaC7q72l9jvYiEXM71qM6dYcPulDxA9il06eEoSHtfl+g/BC0MSSfc?=
 =?us-ascii?Q?nq1O2MfYqV8BbvAgodeudMya78ocHT4AtPfBM39zxl7MXkd0lhEtXM1CKbDK?=
 =?us-ascii?Q?/0pTJOYZMuWK7ge0jqfqCLm83CpRuySG+Z5cucWhizXfIWOMoHceMmt9t9gW?=
 =?us-ascii?Q?BhR03XohZmxs1yQcogKyHZ0N1XW7E1dSJ3hRVI4ADgG4WLjaN91iVurAJC1M?=
 =?us-ascii?Q?sX5SsxqbfMK4oipl0WRw5+rdJtwgph4rSFm7mWpF+XpSbotBLvJtZsPFX3Rp?=
 =?us-ascii?Q?lxlDYT3jNKMtkzH7vUEbWJ3f3BWUA/yOHL34dWUtvlu0own9rlZLfWscCQxy?=
 =?us-ascii?Q?nDl50cpu6CfWsVHF+YMzSOXKBd4jQPEpU9DApv6GcxxI96gpzzRrftOkh/Sk?=
 =?us-ascii?Q?gZvyOajgdZax+RHaaDtpav5ItRJuUTA1QqU3y1me8asvhP81b0udX2SCybPf?=
 =?us-ascii?Q?5iB3kLfbzzrnm9WvgnEUYKRpJ6A1uYEFFznCyc/+Fa1qXlOn9hSi+9o3gLzd?=
 =?us-ascii?Q?q/ZgwpZMBuLAetDeR72rB3qcy5bgsvbUzoXIVLwU4yzZGeFpV1XTZqo18WsW?=
 =?us-ascii?Q?Gs30qv+rZ4XylZP12GQBaIlblXBKUceDlXQ9/n9ewDr0MUrXSDF+jDYUB4AM?=
 =?us-ascii?Q?VqZnBEs23nyi83l5hahr0PhwhLOgkaXkYcZdwocBl1znWO91ZI8hHQCVq8Ax?=
 =?us-ascii?Q?xW2aPuw2n8tM4cctBYNu7kjblHkgT57DhwOQngI24BmHOUuo+2YhjO+Enkr0?=
 =?us-ascii?Q?iEVbqqhTuhrySzOjQB3xGh6tMN2fHXFax6yVXdMKHNX/qcehGCA3A01eeHHo?=
 =?us-ascii?Q?oAhY1T5bCQRDPiIKVH3ga6QAL7HNqbRku0O5498KaLrImtyjKEgt/2DFJIWe?=
 =?us-ascii?Q?kmxBeM1Lsj4caNv68gOO38nMdjz+Qnn006Gu69pR?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	crxwIShvg1j5Wwm31OMDHk/S2cVSaatQYri2xYbnhuMSCg5nkd1iGdXMeb5r0cCgq640oV8VkN9pnogoOo7mNoD3MPIfohpeA0h5J0Kz1Z6lPvwjbgr+DqRh4+rS/Ge/1LvRj016o4qyg8RZ6JgLDornsj2d8HC/dsNvs3TzmM46gfx1idan40QFgwVVnvpiJBk4uye+ZLVynXskoo74Gu1ARxG+IB7u2vTVhiT5vNQKafW8JuXszz43QE/e2cNl2jG9SmrAmzPXHkMcbvuRTfE/GpgdJ62l+UKEsyrIJVSIMHLY4LMFns8VIFmweh74d2uQkVD5IcOckzQFG3m5uzadjz/sRqfq9GG08VUcCzFbRv19MzpeIFi/bpODR+4hihJw2pvcwlUP/sGGsyux+Nweci5iD/4Xpjs0v813sEj33izLCig1y1L3TpHk6HZnu43eMf7pAuc1/NPuAjh181BGTphpOq6VQkK9X1Xn4jijBkkBPbBNlSzp4WSO6UhAApollUtvrLkyQPmJShb3VN+De507VqOESRA5uh5Fwnp5QBSSXH8kmdzAthl476FqPxpEqDRRi7vz4/K70ZwFdFDa751M8iDVSLy5T0OeND4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94d646ed-c80c-43d5-59a3-08dcfced714f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2024 16:26:34.4983
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WWpQZACh8is4eewSk92zbulkOm5V1h+yK5rhXD6XKXpcGu4yqayE0E6bsJKEQ5xh0Amw8UZJI1elsgs8G4Vvwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB6964
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-04_14,2024-11-04_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 spamscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411040138
X-Proofpoint-ORIG-GUID: -GbczdEoy8DbHSgBcXLS_hFvMAtA-EEy
X-Proofpoint-GUID: -GbczdEoy8DbHSgBcXLS_hFvMAtA-EEy

* syzbot <syzbot+dee8aa54cb2f5a150f9e@syzkaller.appspotmail.com> [241104 11:21]:
> syzbot has bisected this issue to:
> 
> commit f8d112a4e657c65c888e6b8a8435ef61a66e4ab8
> Author: Liam R. Howlett <Liam.Howlett@Oracle.com>
> Date:   Fri Aug 30 04:00:54 2024 +0000
> 
>     mm/mmap: avoid zeroing vma tree in mmap_region()
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11fc46a7980000
> start commit:   c2ee9f594da8 KVM: selftests: Fix build on on non-x86 archi..
> git tree:       upstream
> final oops:     https://syzkaller.appspot.com/x/report.txt?x=13fc46a7980000
> console output: https://syzkaller.appspot.com/x/log.txt?x=15fc46a7980000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=a34ca8ca33c0e535
> dashboard link: https://syzkaller.appspot.com/bug?extid=dee8aa54cb2f5a150f9e
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1484165f980000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132b2ebb980000
> 
> Reported-by: syzbot+dee8aa54cb2f5a150f9e@syzkaller.appspotmail.com
> Fixes: f8d112a4e657 ("mm/mmap: avoid zeroing vma tree in mmap_region()")
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

Let's get this out of the way..

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git/ mm-hotfixes-unstable


