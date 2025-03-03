Return-Path: <linux-kernel+bounces-545122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E84EAA4E94C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB37A177BA2
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650E51CB31D;
	Tue,  4 Mar 2025 17:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Z+kVJVWl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YiTvLCcz"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F7B20B1E7
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=160.75.25.115
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741108017; cv=fail; b=BCgQxwnvHFVGcQTzGgGj4qas+FMUIIinyDi3BLL51rmoHEEf0Qr4eddGy+66MHwW3CmlWgQvuwB4w+/ck1MMtpT28isoz3EyBUDEsgQagrbq/afuRN6r+Acsq12n/9UFXU/2V36hH/1oCj6WD+G8HS4Sl2WOGvPlhJr5IJB8hTA=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741108017; c=relaxed/simple;
	bh=mfrZJlzcbpSrpc6nAM5dEMtvle+FriK9B9HY7FuRqgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hDIfmuiPcrhWkB/tNX+d7FIOMhrYzJEdyZ5+l23n9YYJkAViAyVf/hOi4BF05xENadqJ4irI5Ia5/cx/1CdEXA4AOfszt7fDFExlnN4kyX2NaEb1AuZZ5T7+ae9dZOyf1Qfs+yulaObZwcTq37w1VThi+vCYYocytJfqNPw9kEw=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z+kVJVWl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YiTvLCcz; arc=fail smtp.client-ip=205.220.177.32; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (unknown [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id E567E40D9775
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:06:53 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=oracle.com header.i=@oracle.com header.a=rsa-sha256 header.s=corp-2023-11-20 header.b=Z+kVJVWl;
	dkim=pass (1024-bit key, unprotected) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.a=rsa-sha256 header.s=selector2-oracle-onmicrosoft-com header.b=YiTvLCcz
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dRN3PzRzFwKw
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:31:44 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id C559E42751; Tue,  4 Mar 2025 17:31:28 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z+kVJVWl;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YiTvLCcz
X-Envelope-From: <linux-kernel+bounces-541713-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z+kVJVWl;
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YiTvLCcz
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id 1A5A941C0F
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:39:13 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id A7BDA305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 15:39:12 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CABC1721E1
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 12:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA7F1D5CD9;
	Mon,  3 Mar 2025 12:39:02 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2459C7FBAC
	for <linux-kernel@vger.kernel.org>; Mon,  3 Mar 2025 12:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741005537; cv=fail; b=SJ0jaa/FnkQZS6i2S+1d0aqgQC9VbniYfQ7Ki+PBr3Q+Ofl/Yn4riV2NtG8O6mIK1SsESWA4oGpLUasSsnUXOFOfWhF9tAzI4TmBPJxPBDWoR8X0UuZnwYcdrVwMaOVVlnlBPwkDl82FnP4GFWB77l9GH7M1/VhTNRMhRU5GeQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741005537; c=relaxed/simple;
	bh=mfrZJlzcbpSrpc6nAM5dEMtvle+FriK9B9HY7FuRqgk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZJnixKFi1v9Iyhw9aZMk/bMJnud5+dHJw3JJ6R7b6v6/zxioK2b6ToSj5ZlkJT8HjwTqEUGY4MLFGx5tm0Hl9wSj9uYoyUgvkXUamfVN0qe/y/rRCMBz9pW41u6wMhPEV7MZGrZbHPTDzgdwA4YVVxfyvaHu7AHj52tfq4bTlqM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Z+kVJVWl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YiTvLCcz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5237tcg0022593;
	Mon, 3 Mar 2025 12:38:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=kfzur7MNSc69nOxlNw
	4xabmSpKL0pK8FPbldKOLqWsE=; b=Z+kVJVWlR5DPcq+0wNIuRK7wvz9i0pI9aG
	6zBiOt18Fy5YH/niatx7ZYZc5BW4VZNasXmSOMZdOzqihXt491TxiNijtBhHSkf9
	yGQ3VvwCvammQHYuTM/jvma9OpcQYeSOSF2maf3NKHxExLEMHFDpthHbRxKNaRM3
	tKbXpw1sgN79/9Iv4DvtQEnHNBBLD0CFS7aSTvkijXjVSq1nSn1cSSz0My+FF/P0
	nFshhDPp1s70wanEGMZX55ymD//hHpIX+7MGpNsAi+KiE5/zg52dmdYruizpsUtI
	w0kA3W5U/KBVH3h0TB74fGgSBWoruO118LVcwDYJZTu/tYvjAhWw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 453u8hajum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 12:38:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 523C6LxU039131;
	Mon, 3 Mar 2025 12:38:43 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 453rp85bbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 03 Mar 2025 12:38:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f8haNW11WZW7cvDcbmuWzmLAlDsvWioVX1j/YMeFE33ktLPYi9zPc/oJ7H7KV2uZEMHnkt7Ju+aODwT8hgRQxOQdMpn6Fz/MpK+Lv54IqeITZ2JpINQrYikuWlGktTc6hhhvyqE4jrA5qi27qiklm4CFG8jcFZaBtkWM0GUhJkLcEqLDV9+WkpBT2FsZRw9JlxknGxs+6QTjNkZ9T8p5rHOeUN1jxjFr1yXpFylFFMiGBh6I57vMyh9Zv4yEMBO+QCY2w2xLTkaD1BhI2CEzjpByrkC/x0KZcPI2faHu2XEYuMI8MPu4GkdeAOisEoCXNI9U+BJ5Os/qJ8/d0KraOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kfzur7MNSc69nOxlNw4xabmSpKL0pK8FPbldKOLqWsE=;
 b=IBvh/dyIAtoB1VNFUqINZNZR6sQoImIjSeScwKBnY55IrHDdG4vrDF/wplEMXYlSRGPda4o24me//JGF6NYMQ4/tf5BnxbMGqyt+sPem2asHinokmSqRVSFL67iWVbEcai6vv6iX5EHXxODL4RJp33Itw81Cq0OXuIEl1x1UfAlOFe8i0cbepQNUy1RMjoq9207EVsQDURgOVclHj/3jDcRgKWEZeFAsO8OAGNmDxPo7hyoWiogrGNSD7kePWeKMlwjbINZ2KHQiAPzlFPogDmUcFen6r3rHDWkIWmIuV24zLF0w1o9oj/QDCtmSqtVKLhfxYtiKA6gFBDW3JOkr1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kfzur7MNSc69nOxlNw4xabmSpKL0pK8FPbldKOLqWsE=;
 b=YiTvLCczSNKBNaKD4YJ0ezOn91degXADxtstHDpgKV/+D40AnsZyeD1YRI7q+qSjQMZTKVAg+t6Jr4ikowNCWcXG4omHb1qcWB8M2IsLl1k4q7GuO0BFPlK5adVyA5jhPNDxGSWuQHwI5gyphe7GKZhGhPLNErGIINqYjCLkhfM=
Received: from MN2PR10MB4112.namprd10.prod.outlook.com (2603:10b6:208:11e::33)
 by CH0PR10MB7462.namprd10.prod.outlook.com (2603:10b6:610:188::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.28; Mon, 3 Mar
 2025 12:38:41 +0000
Received: from MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c]) by MN2PR10MB4112.namprd10.prod.outlook.com
 ([fe80::3256:3c8c:73a9:5b9c%7]) with mapi id 15.20.8489.025; Mon, 3 Mar 2025
 12:38:41 +0000
Date: Mon, 3 Mar 2025 12:38:38 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, lucas.demarchi@intel.com,
        linux-kernel@vger.kernel.org, willy@infradead.org, acme@kernel.org,
        namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com
Subject: Re: [PATCH 15/19] perf: Fix perf_mmap() failure path
Message-ID: <21acdcec-a256-4309-a6b8-891c97a46f42@lucifer.local>
References: <20241104133909.669111662@infradead.org>
 <20241104135519.248358497@infradead.org>
 <Z8NdLn_04_7XU_w_@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8NdLn_04_7XU_w_@gmail.com>
X-ClientProxiedBy: LNXP265CA0075.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:76::15) To MN2PR10MB4112.namprd10.prod.outlook.com
 (2603:10b6:208:11e::33)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4112:EE_|CH0PR10MB7462:EE_
X-MS-Office365-Filtering-Correlation-Id: 11ec4e1a-f52c-49ed-12f5-08dd5a505415
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/6ZPh4TC9DrEWtLyXRwNFLxaI3YH0vEDytkPmxi1y/M5oY0B3HyHr9Phar8r?=
 =?us-ascii?Q?XVz/ljbhOaQ2QSxSC9UopcnmUG6V9+WIYtYZAnnWzh7OW0kz+6skVKEUYwmU?=
 =?us-ascii?Q?ppArTDpLXICgMvh22RjrCcp3T7OcugmnjJFhGSycDrqoXt/buZgVLqzqYEa+?=
 =?us-ascii?Q?uVXBuvs1SwbmbTuEvUnMHAMUlIkjLXORKIQRG29WM34O0b7eCDeAQs9b510T?=
 =?us-ascii?Q?qNJP6OcYolJAxnPBxePHU9K1b94T7vdnULEyc+/9oMetCtJhTO4oOmyWYTwE?=
 =?us-ascii?Q?JL4f6TqI7aHvC+T8eKUPk+ESwoqbveC5+2CCm6pEq0wiL1t/j60ZNteYMHHa?=
 =?us-ascii?Q?82LVcDK0Psc4e9qAjhOJ5k9LPAgaIC/vWGHKYryD3dIupcdKbfpN++QE10Cw?=
 =?us-ascii?Q?JXDX9/qiIRrMK54a4QVY7OAfWrudPSmigDOLJJ7MTt2A1HURFNpXjCULbDdQ?=
 =?us-ascii?Q?bxB67Ey295rEdLfAL00//AiyjtAvlsjcY4jQfkvai4S5vOj62q94dkPFZENz?=
 =?us-ascii?Q?tcFL5raVyd18uXV2ONSGryiql1GdmVIWwGav9R87HQ5EeAB5UJCJ35Jzxlpw?=
 =?us-ascii?Q?bsQZA32PoagHKazQ87eVDJTD9vH4EmpRIIbBhr4Ze3cx1gU6s1Z+q6aNDt4x?=
 =?us-ascii?Q?9gCyw13W0T2m9iVvt4YrzvjfC4NzxPwxwZ8+AFU4NIvXpU2zxy6DIENMTCnM?=
 =?us-ascii?Q?f10O8qmrveFlX2weFVO8k/JgRxGBn722B/yE8vIETo6W8OCn6wqkK8iSFPgp?=
 =?us-ascii?Q?nqicJbuhn/rR7VJAQKKSs6l3vHNZVDbrvi83JYGsW5E7iXseiF76X2dSJKxD?=
 =?us-ascii?Q?751x/z6MSsUetfXkMSIvhnqBWlxhO6hUWQvjmF8UGO0nDS0bKxXX7NN2Z8uF?=
 =?us-ascii?Q?75ThbxR3wk/kvacnEI1hITNh4pY5/AJtGp2k41B8lpf2BgQ3qqOQobZd/IIi?=
 =?us-ascii?Q?1HkBl9DKl6yKlSsznZd0Nv2FZaUbzWdMc1C+K1I/aWsBogwpIxEP5/Vy8QMm?=
 =?us-ascii?Q?gvRZ7S4XcRQdpUvxzJ393UB7rwUHLsm5fHtKAjhe8OUga4jmqhBvX9Lp1vsW?=
 =?us-ascii?Q?EsA6q7bY6tf34GsRN6sbZKMIdmww+THuxR4gpCbUyJcgdHWc8SSGdb6DyAHI?=
 =?us-ascii?Q?epu38zT+YkBHU/zMs0uYuBlVbKhQatyZUjGFA8QOYkWMuXeV73MAUfLCWDsU?=
 =?us-ascii?Q?R/BSti4D00/BnWh3LVMn3o/eZTQrCMG0Mj9c3I5vEiMsm2A5fjMlnnmF4IJl?=
 =?us-ascii?Q?flCr+/mXaQzUpevGvmfOS1slRs6XnsBOoY5TkkAxm8kREJQ+j9muHrJgMkR2?=
 =?us-ascii?Q?2JChuvQwZzyNB3r5IsYwt9MFe7+FdtHT9IXbk7tRsrPXRQl0PIOSUY1Ra9mY?=
 =?us-ascii?Q?GOnWiH3opHHzMeuVVqtsGjrgOMwP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4112.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?R8uc3zxUerrTuBhqgXyphQ1KaZdK5xBjwT3clOSBQdvYXNF/YRpV7hAgXjX4?=
 =?us-ascii?Q?QT4awUDdRX8spN7/h2fNG1TQRpmnVyDww4V+Sh/KVdiE7H1A1PvFQD+bTia1?=
 =?us-ascii?Q?fj/3oK7xceGQeugeTcaoC5xoYFKgLe7lkd/n47gOCN2DtSHXbka0NLo6UWiM?=
 =?us-ascii?Q?93rP85EOP66bWMq6PgQGTg5F7Esnscv+cq426PrKnHSJEERWqWGiXRNEmL+o?=
 =?us-ascii?Q?5yHb7+zApOBCHcFzqNRlrMP8g+fxykfjVmLATOTz8//WUIik+gJtgc0+x13w?=
 =?us-ascii?Q?NyB6ijanaMcSgJzjWdJOGi/z1F2B/lfCWbYAurdWVddNZGprHl0wKjU7+05a?=
 =?us-ascii?Q?u3NUqEcxQVfqREN63JdipcE/lp2514iQTQBNE7jbqc+oFTQMqxBQIl2rawl6?=
 =?us-ascii?Q?U5MmiCmhNLpNSWtSaj9eKvgZgeOnS3AcAXKPOTO3Atx9Rn/1J739963q3w48?=
 =?us-ascii?Q?coZ8vWyDyYdRwOXhFw7CFNDnvr5gCuX4DvJgHeKwESbaCjzVtXGrh0SPAHwg?=
 =?us-ascii?Q?V3znXrDLWOCcl3g5WRCkp3lho7mbeSKtusihPLke0b/RaC+dj5mCurhFNu4M?=
 =?us-ascii?Q?kuBqkLb/6bMDOz1HHs2PhrOsqw2+8B3omfZHkZoiaw/yH6yXlOQqV/wDljkT?=
 =?us-ascii?Q?Im74NYF9fF54ju35SsmgJukwh4OoirZ6xmceT906KgnZA5IpWWed6/QQ9ndx?=
 =?us-ascii?Q?F4URtFLDhwefwad/nnCFhvR3NI6mYDDS3dAG5VbBqw8NLbctBb4VDWtgNMsJ?=
 =?us-ascii?Q?Zvr+AxsABub2EHSv6X/4d5dh18U/usedcdlFKpl0jJS7BAiRujliRcYApWox?=
 =?us-ascii?Q?8YSssdEQorFuxNjS9MPpeAg2XR/AHs/XAWs3y216i4rsol966fNoZwILBYBv?=
 =?us-ascii?Q?2tipXNDNwfRwdpliLpkzI69ly8mECW3diDMj7UcsU5J2bZIXZ0N0y/oeqq1T?=
 =?us-ascii?Q?Z1WW/8jfC6cGuumzjrgreNL4ZRZwkMQGPVyLoUsSB1eaXnzkNnF1mwiEBkXr?=
 =?us-ascii?Q?w7+BvJ12DdGQITcrW2ye8+6dd2lFUcxZnVIfbChIssNQiS1wwpH1MaysiteS?=
 =?us-ascii?Q?2xVOUJ5nLh+YDxyhymBv/Y/WkFKW++GWFoKx5cWt3NGopWki4Onsx7KVcIy/?=
 =?us-ascii?Q?RSEter8K4wjQ4H2cuu1eCDOPzu3fYkEW4W+T+T1LLiVVf05bGTs60+rj8FNY?=
 =?us-ascii?Q?2NYgDWGYQtZOsFL2mQDxYvZ1Ewb/7QFH+d7Pe/qC9VhChNJhuRWS1CZrnL1i?=
 =?us-ascii?Q?v7+cTHQRFPD5aeze++VshxLD04welNIObnfqHsEm1qMD+Tskex1olvm5hy0l?=
 =?us-ascii?Q?AtzhWhNYJwP2IG8bP83s1KVLPIhEhG0qMtiPTNrTjT74eGJfQ2HJ/ape9HND?=
 =?us-ascii?Q?bZeDUbCH46B6qtk1jjPusT5V+bipUgK6r1aWoasPFXAffQbeS+dhkUE43tyW?=
 =?us-ascii?Q?70EUSXp7aFy20N5nilRTTo8HvFwo7qpy4glC4+h39z+I5pNsnYhLmPRjh1/u?=
 =?us-ascii?Q?0XjcDRUhYBfu9kymsZ5lVgHartCvsuUSyP+bc2e3m7QYmc3YbQwwzsmPUyBF?=
 =?us-ascii?Q?zo7uEuza+360XXEghiYGmEXxPa5KauoP4FHRI7j+RomQr0tmP6la7cbjaGaN?=
 =?us-ascii?Q?Eg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	1d6326H4BGPszhcQr17qfwo0OA+hnXXbo+7/o6Nm1UR+PAm8NJhxfmVll0Fc/RimB419wPIBPXxPsr7P8nEO5shbLuFfK3Gl4pu4HY1g32WD90Fml+froZhOkrbZmE1X328h6A38X4Esg1B6p0ULWlLc5Vpf0wnX3jW4uORu3mD7ad5swFWBUPqF4MpQG3rznQlPa4C2ak4fL/sbGwhoKzmMn5+CG614RNPDR0sB6EXMqmjErrWb/uqYMSSv8jCHcEJTEfsatACDWjdftVQcOS5Gt9Uwh1LAopZBVNCom+w1waIdO1ykGLnROobIJKOi7hLyGrhsdYAPUe+CXlwZNFDvHCI15eaU70MC41AMi78WeJxVfNBoF0xYwYwU7Rjnfr0QbRPyqm5MsuCcq5XWUU1sNnARVtO6VL+tOhuGuEjiz7MszMMTqrpfDT4853vKYYGYzjoKzclZ0NMC4jY1gwFRWWATU7wDl+3UUrm16t4nc896yF7r5eU6WT7l/LAEqGvYguaSs1gjw0gQY9S7tFqIkh6tEnAw59EkIn1QJ4n/B/9d4bugyrAyf+ZNgghll5cK77ZyaeN+xU4h7isdFO1/TMSsb43us+BvJlDyed0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 11ec4e1a-f52c-49ed-12f5-08dd5a505415
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4112.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2025 12:38:41.3150
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HCCN9WpwBnzNMCN0YlNHE64+aoSkZbAXPxWP6J753OOJm24QpMNmiUP9piJiiyEISDyzK5V6+gbjoh+gPquOBblZgj4xnm3cnEFkNQi9tmg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB7462
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-03_07,2025-03-03_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502100000
 definitions=main-2503030097
X-Proofpoint-GUID: u_Qx0W-70wla_XrlcAvqi16fb_qV38DO
X-Proofpoint-ORIG-GUID: u_Qx0W-70wla_XrlcAvqi16fb_qV38DO
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dRN3PzRzFwKw
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741712691.1569@6MuUKHNy5FHFEv7NiGIAdw
X-ITU-MailScanner-SpamCheck: not spam

On Sat, Mar 01, 2025 at 08:17:02PM +0100, Ingo Molnar wrote:
>
> * Peter Zijlstra <peterz@infradead.org> wrote:
>
> > When f_ops->mmap() returns failure, m_ops->close() is *not* called.
> >
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  kernel/events/core.c |    2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > --- a/kernel/events/core.c
> > +++ b/kernel/events/core.c
> > @@ -6830,7 +6830,7 @@ static int perf_mmap(struct file *file,
> >  	vm_flags_set(vma, VM_DONTCOPY | VM_DONTEXPAND | VM_DONTDUMP);
> >  	vma->vm_ops = &perf_mmap_vmops;
> >
> > -	if (event->pmu->event_mapped)
> > +	if (!ret && event->pmu->event_mapped)
> >  		event->pmu->event_mapped(event, vma->vm_mm);
> >
> >  	return ret;
>
> I'm wondering whether this fix is still relevant in context of this
> recent commit:
>
>    b709eb872e19 perf: map pages in advance

Yeah this is, as perf_mmap() will still be triggered by the mmap code when
this is mmap'd, all we do is essentially prefault the pages at this point
also.

>
> Thanks,
>
> 	Ingo


