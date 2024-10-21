Return-Path: <linux-kernel+bounces-375010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9CC9A731F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A289B21BC6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B4C1FBC9E;
	Mon, 21 Oct 2024 19:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XELdRZtW";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dvIQK78a"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C174E1E7C05
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 19:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729538514; cv=fail; b=kbfDo/WKWHqnR/hTGABztVa8rSvUWTDkFh71JmUs+gDCIKBX6G7NrJWevi6ZHy5vrbyT+/Pp0US6/EuyHwywS8PKHrK7E0bTr7bzOa92zcnVq4g47lRwEuYHOoUX8Yw24uYAe+u5hMgXQ+9hTsCs4UIIDSVGqGgHtTWClxy20j4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729538514; c=relaxed/simple;
	bh=uhhfd3FmAHnjSUemupKtfKBlFYQ7AXZ0NEaaARe2FRA=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=Cqsj/bdnMaSc+9JwwRhevg+GFIrUWWd7UGXj8Avbssa7ktLZsWk6+8nSqOIVhGbSZK9s+VUCqXSTWsXsAxIej3Mg0Noy1luxNxLfSfDHpPGU8RF9+7elfQ6rxK3l1ZTQmzBo1kHv4+PzQxx9gPazWjGv4lEfT6jQNBFiZMBoyos=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XELdRZtW; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dvIQK78a; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49LJBdUH019596;
	Mon, 21 Oct 2024 19:21:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Y1Hb0sVkLcWye6yxJv
	bOURDGiz31OIU23nczchEie84=; b=XELdRZtWrv16IsULJQGHSnhRIcluXTrc+O
	ONR1oRDTpzn3tuBszRBDjNEafxXj1rP1gZjtvC3VyRaNu5f8z9c7Fn6AwxxgfHoa
	AC5ghBB33CIHXQBl5Qyq1Ny+hY/QAgEg5O8lLathyxNhNFyehhaegoAD+YSR3UXJ
	jHoIlfFkKcwteGktlZf/bA+PZJm8Yp0KJ7Ona/+dKGgzHj0NGiL6nzjSoTrXvLed
	YmW6L7WGq5cGYCg4MSsF2VkTJaxCpQJCnBbFPYzHnPvlN7QU7CaixtdMcNBSv7jr
	lOUvyURMJ8Lv+d+98oS3jf3gEQ0PPF7odiQh5Q9s1/d40FyVSQDQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c53ukyck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 19:21:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49LHxwD1019639;
	Mon, 21 Oct 2024 19:21:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2174.outbound.protection.outlook.com [104.47.58.174])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42c37cwgw3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Oct 2024 19:21:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=isVsZuklGBvsNoN3yTSHW2tBbn24an9aCMjj4M4OkWfXfpwNDbHD9sYB/pqeVXYGgS928J+zT+HACu3CHLxRdVB1dmBgHpKc7PEWmIjUx+g5yUX6YuLdTIqjRkXmatn4J2ZFtLku0RXMqpreMfYLDN45sZxSe1ezR9WcCxIigNgApQtKfIMqH8kLNF+0REBN8WzUh77uc4cKRXmMItSc+nqP/timqLLSgucsKNPP9SFxOBP8WNFWjWVcdWu5gF9kTeZzWWxMcpTfrV8McV93va3k+oNIvImA7cIcogz7BiiO6QeODu9Cfa4m508RlHqblpV+ysTDhdE2pwmPsaLzjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1Hb0sVkLcWye6yxJvbOURDGiz31OIU23nczchEie84=;
 b=OExkNP6sEONgpKfprzLLMAkgCG8npEb8K6DRJcKg6vbGZzfonY+IYZIhcsAfLmB35DTpGd2L47d/TfmDag+BTdm2WkQMrWyEpDcKwHBfsd2dbTpUCMCcs2VE3D/aNEFiipTa5Ui6S2RQ/ktcCTdTqw6O1jt0hKZXLFGYcjUAYYKfEW24sKFLB2ruxNCZYclE637/BA/ZTzI3WauVcxVg2zVg+V7B5agxrWeVaNTntofZePyZ/RWXJoCOkAr+DxQwx/6p8UePkgL/nr7wmb5hnblZ666FM2nvrp/6NBAHpJ7+3+Ck94LACYSC9c4E/WbqcnikDQXtU1R+7wG1k+L3Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1Hb0sVkLcWye6yxJvbOURDGiz31OIU23nczchEie84=;
 b=dvIQK78avJr2NDdVN0PIMj0bwHB3ufN3ni/yiKWnhd8xpQRz/4GqRRPKpSTcqp9Kx7S0PdHLYClqVld59S7MX4VVTDt4DMoUmyZ7443CD8wTxVw55/UF3Im3mgcy/3NfqWDypNdxSresFDOoiip2SSUq0hD/vZsRi0n/K63oSy0=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DM4PR10MB6839.namprd10.prod.outlook.com (2603:10b6:8:105::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.28; Mon, 21 Oct
 2024 19:21:01 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8069.024; Mon, 21 Oct 2024
 19:21:01 +0000
References: <c6cbc343-01c3-4a38-8723-cc44e83dedf7@paulmck-laptop>
 <20241011081847.r2x73XIr@linutronix.de>
 <db3b0a4b-bec6-4b2b-bb22-d02179779cf9@paulmck-laptop>
 <20241011144341.mQKXkGkm@linutronix.de>
 <dcffa722-986a-437b-abb9-af9f4de852df@paulmck-laptop>
 <20241015112224.KdvzKo80@linutronix.de>
 <2a2a3ae6-ed0b-4afe-b48a-489cf19667a3@paulmck-laptop>
 <20241017070710.U9bTJFMS@linutronix.de>
 <0313c8c5-a6a0-4d09-9f85-ac5afa379041@paulmck-laptop>
 <20241021112755.m7dWNbc0@linutronix.de>
 <a71a7154-7cd4-44da-be41-5f2831fbfbbe@paulmck-laptop>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: paulmck@kernel.org
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra
 <peterz@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, mingo@kernel.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, efault@gmx.de
Subject: Re: [PATCH 2/7] rcu: limit PREEMPT_RCU configurations
In-reply-to: <a71a7154-7cd4-44da-be41-5f2831fbfbbe@paulmck-laptop>
Date: Mon, 21 Oct 2024 12:20:58 -0700
Message-ID: <87ldyhi7ol.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0292.namprd03.prod.outlook.com
 (2603:10b6:303:b5::27) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DM4PR10MB6839:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ed4805f-1bbc-4b26-81a5-08dcf2057fb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wUC1pvc9XWrnCGV9iA468ntGNvBZx941Rc/gzHiHHbbs2ZYzWNQoWVir1f4S?=
 =?us-ascii?Q?bdmKy9qsRSgE93qkkOEYVzBiWq9bgy9/AebcJ2dja+mqeG4Oongnr+kc/8sT?=
 =?us-ascii?Q?d8Ne/BIdaYxc5KifcfFxWkO8PemHr075RFBy319R6Rw2l5WwNFR4D8N1eJUi?=
 =?us-ascii?Q?GcGGx/TZ9pWpvkqLHtwbJRpoQpLoXxdPKIUthzkZcWIgsZxrpszphwjgdLta?=
 =?us-ascii?Q?FkL+ZO2PH+8bkQsxc0a7CsPLJH5+7tU6Zkz31BD1rz2BN77km59AkUx9Fr+n?=
 =?us-ascii?Q?rvBJz0ec8h1UEFarWs121w/VdXV+1gSsfrZEBgYq22JRiYA9gvWVATyCwlWE?=
 =?us-ascii?Q?zul2H3S5nFg0fKTTqVEKLHGqrorsECHArHLgGmY3HaU+v/P6EyKTY5DovWEF?=
 =?us-ascii?Q?j6T93b4xtoNclZS2t3GDyfAlUgkeZnjkl7ByklIsG3jyx1sseLudqSqj/HjI?=
 =?us-ascii?Q?FTy+Mo5SDdGXh5SH9JVHgUJLQGhOc2a08U88oL2Q7nWvI0yXaHXv9vJUcZNP?=
 =?us-ascii?Q?pIa6DFgyDN8O+Yi87CpIpi1PIImjF4gUAGsUQ6R6/9tOMToyfxW8iAn1o57i?=
 =?us-ascii?Q?tUVC/oF3iqB9sl/i0SXc30ut/uM0s4skpYQz8f7L/xuqG0V8gL6zdjJuzzBT?=
 =?us-ascii?Q?hGVyM061nVQc0duaV6nDBThpV9jG4nukeGlBn/WvFOq8NWa8NX5G6t2tkAeL?=
 =?us-ascii?Q?YI7XxuL2j+2K0cfkZi7KNLvjPqqhQZW+zXYM7NEXxzYvNqyiB2idkOw7dmGU?=
 =?us-ascii?Q?EG6dpn/k307rDVHIWQtta4lf47gLKM/QFFJOff1JC8ZYH496PyzNUqHJNVXf?=
 =?us-ascii?Q?xqUjOWrRycPAtmOMQW4Wv8nVnrAY9Lg9TMmiLn12wft/alEfwziPa6tFigTW?=
 =?us-ascii?Q?dlZZ2Nn2mXjA28MwxmvKK7Qry627k2wpz4ljRayAHZpiCa78PIf253T4CKYr?=
 =?us-ascii?Q?/6OGgH+YBgE8r3TIi1YjAAsz15y5cZTIAUDQdAFJZFLeW9ZyXsWN+dwp6YNa?=
 =?us-ascii?Q?S4AOtHvwUvPiLfjaAI4EKqHkBru9RucEyi5JGa3qzoTmtSPD9Ab1au8gGQnI?=
 =?us-ascii?Q?yGV1SCfGAqt2bSbWcriajCqzVgoMWtuI4+vnmQciv+F+gRsBZGFWKTg22ZmP?=
 =?us-ascii?Q?JHerb9/SRPQX4hNuXixzdXRM2Qj/ACkPM/tJQ60AicnICuMPY+p4VJPOFlLB?=
 =?us-ascii?Q?jwfKOjfndi/Fb0Il2idhtyqKHSm8Palb6+Zldz+FIeBlW5tIwX64bPl7zgEw?=
 =?us-ascii?Q?0BM7KvZtsdsbrZTMUa7onwVCfB+EOThAZHvuPk2yTYFL6JWe63sCajCGAOp8?=
 =?us-ascii?Q?yNAcKs41PlE95tM63+dV5JWf?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DKZoFg3ToL2YgWYw5oPryUm2bLYEP1LWywv+f5N8QOVzML4pdvFnkXhbFzUM?=
 =?us-ascii?Q?TS3eaY/rGUxJ7cMMMw6BG3Xy68S2jdRpl+dbMf2EHyJL+XkkuhkxyW/6kpWj?=
 =?us-ascii?Q?1Y8sd/65KAL9fhS3twwZVptUX2XyiuP6IFpVRljmxnyyCXNwLt0eMXY9AZOs?=
 =?us-ascii?Q?A8Gh3HnUhclPL+gPY/VrNbk953sIU+tPG6iD6ZRhjbQ7XGVxFX5cPkhDJTff?=
 =?us-ascii?Q?4NHGR9c2YfaO3/TL8MlFiWJQJYOzG8YzwezmHAdN6iIeYL6JvyQSSvvFk1gL?=
 =?us-ascii?Q?GkJrFwE3MYNF6MgtXaxAHjoIrEHG1RiXc7i0D5d5/9hEMNxGmAc+mlXjHzgW?=
 =?us-ascii?Q?2rmdhvyZjRuwESd8hVl7XvGO9WRrO7pkMUqoRGAkBVBto0lTQUaaxs7JkIwm?=
 =?us-ascii?Q?vvqiJeXHIKs5HbRR8d92rPEnlq+Z8jiCylkPWaTqYEYt3PxPGo9VdYoFpknI?=
 =?us-ascii?Q?mf4YSkthIhwh0Re+AtXcjJ1eFmoQZ7f6yMkgj7SNvVjAm2k2u1h8hwIyK+yH?=
 =?us-ascii?Q?1AJ8GILATz3bbKDFxS7Wlmrawyh/aWZf7aFUwpIGJs/3AqFG+m2GaMlLwRtU?=
 =?us-ascii?Q?aY7hsnTrUppViKytVl6u1x/ujLElJ7T/LLy8lZJ4AXU1mp1fH7pCLsEshE9U?=
 =?us-ascii?Q?epNfsiIT5UciA7oJUwswfCQMC6tspQ7LNT6J7NVZlpBpJCyRnYy+qz80XYg0?=
 =?us-ascii?Q?w4PRh+qz3pdO4xbQYiWuiD/Y1dm3hHyb7GVvHcsHm22s2iuTplBRm+Cl8ika?=
 =?us-ascii?Q?HpnAGM4Xl/4DxsTqam5i0K0lQaJhTzCpFI39CRq/1t8tlmPD1pIfp+7TRwQx?=
 =?us-ascii?Q?2HzxylMWXQr3uIWkYCb0Pxuti/7XvB1fgNUR67FsF3Bo+YThzxdj/uFcjOHl?=
 =?us-ascii?Q?iOQU4kmh1+Irhx4Vm8zOpd2Xn4a+NkiO3W6VyEzHK6gzEvT/9mh/yy/0xuDY?=
 =?us-ascii?Q?aBYVy3Py/lOkxB9wZMSOYfDTd45Ym89iEyWGDtz9pdRx2P/pyeVKI3eg/AY/?=
 =?us-ascii?Q?/dLPgxEDayGqj9tg2uQJwg36GaLLpJhixytZeYa+r7TkNjUwJ4XmyjMTCnL4?=
 =?us-ascii?Q?mYEj8cOdyxmuOPF148Lugwcs3RysIiv3z26t0LG+aB3GTLZRqGmXMY4I9064?=
 =?us-ascii?Q?/pASvlERbTGJlxMM6PJULSECsFDDnP84Q1AIykl4TlnmgPJu0/vo82FlrUmB?=
 =?us-ascii?Q?FHWLq1ArB2Ove5+QrLqyLfla9R0iU3HvtYam51VlSb1Km7v798BetGORe5Kr?=
 =?us-ascii?Q?fHTRNQfrnFX31/wB+3fQbhKxEF09lmBL7IhxgyZqN26da/thfMwRX2dT4oGS?=
 =?us-ascii?Q?IAd7mGIj45Y6h50fpc5HeLHj+Jef4Xjo2Fl5MMUHQFpu/n5G3lvNQqsP+6Wr?=
 =?us-ascii?Q?0kjyh1ZtXHNyEzMXu5BCCGpGCjRXU10VVnuR5vO5EWkKUWTn7QSs5MmYcB6u?=
 =?us-ascii?Q?7N7DBhxauXbo7NxG++odcABKNrenJ3/snHqeep/vtb+lidLzb5dCbeB5mLGl?=
 =?us-ascii?Q?W5OnD+I0E+COn9HZaInygOQhdkESni4BT7vOVzPD+C68+a26o31lXq/anLiP?=
 =?us-ascii?Q?OwtYLODqXC6NdumvfYR34jMrqFBqRpAdYEGqKAo7?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6pa2Oh3eD+gkST/lwW7OccUhEfKZId6CPwrEXMoAinfw//m8OmT/779V4gcIR4dQxVcn5ebJbeWIi1G5BouJiHwFLJ+hxOImR3m51VBB0iPkeCG1qxKlnBSaBpPX9mza0CUC+vpecKOfsH/HesqOLd6DmrmCBpFlzKj8hpxwd6TfoEps3vCjgscGFMDS9I6YkuTRwNnA+NdIvmR5QkVMqqNQ3kaiNEnj61qH40kNPG2YsXAByt1NuSKVYKQSO9zy1NPIXucxX/u2g0HAqADKpI2DvJsH3cE0pLP1yCFKNsGU6R0MphVA36SwJJky3R0bJONsjXrbcooZpj4hb4M8w8NO+o/HsW5YwVlp5GCoUkYHHMktQpgapFxToDr5/HUVvjT9NkUcdUoCxmHPqPbEE2w6E3Ru0V5/JhozJSs+u9e+b56/cvi5y4nbNOkxYGASRg6QIiCEnY/wOhgG9bWZyWuq7GScSewoNppvA7WUqG5rCLYlqBlLl3wf6H6OjiNNp4tse4ECi6gdVOy+IB2/mg3si3GwjN4eDhl6J/IrHKLJnIkovWjsKjdqN9oq0/jiA14+awgD3vvv7MRvMNeGUz4n67BlOlz5Fa3DErU3OXA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ed4805f-1bbc-4b26-81a5-08dcf2057fb7
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2024 19:21:01.3385
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pyCvTo8cBVgKBxyLc9oDWSKZhJMGhBI6UIOpNEGTJsC+N762t3No5jYaPXF6vrzk7kxbgsaXUcU05LtwbUZ5LOTX9NYBj39NFSE5fB4JAqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6839
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-21_18,2024-10-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 mlxlogscore=757 spamscore=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410210139
X-Proofpoint-GUID: bphb9Hv6Lax6u7zWX3PNPiZcbGcrAupA
X-Proofpoint-ORIG-GUID: bphb9Hv6Lax6u7zWX3PNPiZcbGcrAupA


Paul E. McKenney <paulmck@kernel.org> writes:

> On Mon, Oct 21, 2024 at 01:27:55PM +0200, Sebastian Andrzej Siewior wrote:
>> On 2024-10-18 10:38:15 [-0700], Paul E. McKenney wrote:
>> > > > > I don't think this is always the case because the "preemptible" users
>> > > > > would also get this and this is an unexpected change for them.
>> > > >
>> > > > Is this series now removing PREEMPT_NONE and PREEMPT_VOLUNTARY?
>> > > no, not yet. It is only adding PREEMPT_LAZY as new model, next to
>> > > PREEMPT_NONE and PREEMPT_VOLUNTARY. But is is likely to be on schedule.
>> > >
>> > > > As conceived last time around, the change would affect only kernels
>> > > > built with one of the other of those two Kconfig options, which will
>> > > > not be users expecting preemption.
>> > >
>> > > If you continue to use PREEMPT_NONE/ PREEMPT_VOLUNTARY nothing changes
>> > > right now.
>> >
>> > Good, thank you!
>> >
>> > Presumably PREEMPT_NONE=y && PREEMPT_LAZY=y enables lazy preemption,
>> > but retains non-preemptible RCU.
>>
>> PREEMPT_NONE=y && PREEMPT_LAZY=y is exclusive. Either NONE or LAZY.
>
> Ah, I was thinking in terms of the previous lazy-preemption patch series,
> and just now got around to looking at the new one.  Apologies for my
> confusion!

Minor point, but you might be thinking of PREEMPT_AUTO=y && PREEMPT_LAZY=y.

>> > > > If PREEMPT_NONE and PREEMPT_VOLUNTARY are still around, it would be
>> > > > far better to make PREEMPT_RCU depend on neither of those being set.
>> > > > That would leave the RCU Kconfig settings fully automatic, and this
>> > > > automation is not to be abandoned lightly.
>> > >
>> > > Yes, that was my intention - only to make is selectable with
>> > > LAZY-preemption enabled but without dynamic.
>> > > So you are not complete against it.
>> >
>> > Help me out here.  In what situation is it beneficial to make PREEMPT_RCU
>> > visible, given that PREEMPT_NONE, PREEMPT_VOLUNTARY, PREEMPT, and
>> > PREEMPT_FULL already take care of this automatically?
>>
>> We have now NONE, VOLUNTARY, PREEMPT, PREEMPT_RT (as in choose one).
>>
>> This series changes it to NONE, VOLUNTARY, PREEMPT, LAZY, LAZIEST.
>> Ignore LAZIEST. PREEMPT_RT is a on/ off bool.
>
> In terms of preemptibility, isn't the order from least to most preemptible
> NONE, VOLUNTARY, LAZIEST, LAZY, PREEMPT, and PREEMPT_RT?  After all,
> PREEMPT will preempt more aggressively than will LAZY which in turn
> preempts more aggressively than LAZIEST.
>
> And I finally do see the later patch in Peter's series that removes
> PREEMPT_RT from the choice.  Plus I need to look more at LAZIEST in
> order to work out whether Peter's suckage is our robustness.  ;-)
>
>> Based on my understanding so far, you have nothing to worry about.
>>
>> With NONE + VOLUNTARY removed in favor of LAZY or without the removal
>> (yet)  you ask yourself what happens to those using NONE, go to LAZY and
>> want to stay with !PREEMPT_RCU, right?
>> With LAZY and !PREEMPT_DYNAMIC there is still PREEMPT_RCU as of now.
>> And you say people using !PREEMPT_DYNAMIC + LAZY are the old NONE/
>> VOLUNTARY users and want !PREEMPT_RCU.
>
> Yes.
>
>> This could be true but it could also attract people from PREEMPT which
>> expect additional performance gain due to LAZY and the same "preemption"
>> level. Additionally if PREEMPT gets removed because LAZY turns out to be
>> superior then PREEMPT_DYNAMIC makes probably no sense since there is
>> nothing to switch from/ to.
>
> We definitely have users that would migrate from NONE to LAZY.  Shouldn't

Indeed. This was the original intent behind Thomas's proposal of preempt
lazy.

> their needs outweigh the possible future users that might (or might not)
> find that (1) LAZY might be preferable to PREEMPT for some users and
> (2) That those users would prefer that RCU be preemptible?

Users who care about low latency already have perfectly good options:
PREEMPT, PREEMPT_DYNAMIC and now PREEMPT_RT.

I don't see the point of elevating low latency needs in all preemption
models -- even those which are meant to be througput oriented.

>> Therefore I would suggest to make PREEMPT_RCU
>> - selectable for LAZY && !PREEMPT_DYNAMIC, default yes
>> - selected for LAZY && PREEMPT_DYNAMIC
>> - the current unchanged state for NONE, VOLUNTARY, PREEMPT (with
>>   !PREEMPT_DYNAMIC)
>>
>> Does this make sense to you?
>
> Not really.  At the very least, default no.
>
> Unless LAZIEST makes the most sense for us (which will take time to
> figure out), in which case make PREMPT_RCU:

I don't think laziest was ever meant to be a serious option.

Peter mentioned that he'll be dropping it:
 https://lore.kernel.org/lkml/20241008144049.GF14587@noisy.programming.kicks-ass.net/

Ankur

> - hard-defined =n for LAZIEST.
> - selectable for LAZY && !PREEMPT_DYNAMIC, default yes
> - selected for LAZY && PREEMPT_DYNAMIC
> - the current unchanged state for NONE, VOLUNTARY, PREEMPT (with
>   !PREEMPT_DYNAMIC)
>
> Or am I still missing some aspect of this series?
>
> 							Thanx, Paul


--
ankur

