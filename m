Return-Path: <linux-kernel+bounces-357747-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 81515997523
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 20:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D2E41F234F6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Oct 2024 18:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F3C1E04B5;
	Wed,  9 Oct 2024 18:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n+bmVryc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XNjS0ce7"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4C6198A0D
	for <linux-kernel@vger.kernel.org>; Wed,  9 Oct 2024 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728500012; cv=fail; b=s6txOv91TQ8v9ZWg0lhGDgSxH5JK6XcKL1W15qr0/487ng/z9K6PhBAxFAhm3dzxDqEJhTOV2bTWmYLNKAQ6/sd/0HZP8gm/0/Ka9Fv5+YRF0/ChOrfc/0cExmTGWBYyyhCmMjIfnk9RhsJMeLslr0YnrxYMRfabaOO9e/cfsgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728500012; c=relaxed/simple;
	bh=kbus978MpZTIAGDdc9pLKVDgSjgDZVOzOcS2UQgvD3U=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=Xvb1Ej902veuY76qNd81clszjcQsBDBIpt7JoHhB3lL9HY6Nkw34mtx8HbG1ybBvCwsIT2iBJ22RjQ+ZLW/6McmitKmt0Umbte8QEpUVjUkhRrwbHq5UyxZRa8pTnziHEJ/61RhG6Ls5TvFPs75oie7WO+fSwGGBANHFcpBbxz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=n+bmVryc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XNjS0ce7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 499IITmb004836;
	Wed, 9 Oct 2024 18:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=KKaAHAUhdM3e3ffg7m
	+Uy8T1yQIYL2Di5KVjrJlKj/k=; b=n+bmVrycUL5dgrm44udrW0rf5qFhMeQ/vz
	8b+uXiJTpYxR18/8seACYp6+wo9AT2Vgr1+OZ7HbJWHrfdXCLcIBv8xqU60vw/1R
	WNR50n0tfaz1PFJ+pc36/n/Xb2yeFrDCnwv/Xf/6ZV1Z6F7iRcxFGtnMbTsUFTwr
	h+rOm8DZ7SeaGAATTraPaxnYI1aaR/qKRWijN3uoDVYYmQXRqG6W/yitxOObsrtg
	FdWgNsqqdFumU+BLgdBczh5njs+MuckyrSGxWDbcN+Ek/vioVfQ2pakylhup2sJT
	v90Qe4Y9MDa9lIIB8psvDp3N6+eYuN1n8pZmpC0cYjwNRsE0Yt4A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42303yh360-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 18:53:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 499I7mKB038233;
	Wed, 9 Oct 2024 18:53:07 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 422uw93pa7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 09 Oct 2024 18:53:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mqDMJMRg6agwfcrE4Rcr7RXkM+sJuqFGEpekzfUTOmPz3lNRE6PIXqLmxqGMSzzKXZuUDY3IVld+uFDhUIoGVBOouVkEFaP6EioKcbLtpmumMSqoxHBqkLa+ozQfkvBUWZNsvAjRNCzHYK4m2mHaaSkJoIbpab8hQkCpnmwM1VeYVgRpaVqnsWGsry5jXxvYdFWulieZBHvRQ8N2FsrmVspV+pNAwc2i+M5qrQ+ajLetHlIkpaVLn2N+r6CcbVXWAqGVPw53o8IKTaLwKQHD5DLrpFf8ybt+jpEwrTLPZ6mA6nzO8tMLM6aaFOEYBGJ1kW9r4eVW3G1DXezXQVyP2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKaAHAUhdM3e3ffg7m+Uy8T1yQIYL2Di5KVjrJlKj/k=;
 b=lFxjChiwjf3OHFUD4v4mumo93HG/cl2ML2Ny+HWR0YJZ25PeQJn/kN3XJFhiDRdeL0Im9LRDv4KC/Hav//pjXudWvZVSFL+oeRgblepV5vAsileyvOy9b0RCaTBOgyQB6++qDc0EuhbHQcbubFG8Fxu2V6mIxCms8klIjKQ3XxKrvzZonuT+OGN9/+kZvVko7YpmPCtRbnxxOK6mNprBqeqgtmqTS6nwXiDcBBzhExK593OOEKDU13DfOZMOHNWK+eAKoMXTLCcxVPsgv5PV84CJcwKDuf4jft88GpW5DRxkDTScjG7Qxf3TIgrrBG9ou1jPQ8dYPXs5Xcs7R+4BRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKaAHAUhdM3e3ffg7m+Uy8T1yQIYL2Di5KVjrJlKj/k=;
 b=XNjS0ce7GfPODRsOnf6krRFs2YHk2ccQEPhEfwWIFplc8AoxkKcSiwCHRMdZur2A0xCKHPltXZCSBS0CKiM5ToNCnFYIyin0AmK6xLBCAiJ2tQtdFgwuiQNB70qfQnBfmEYeuJroiqoz5w41V2nL5OXtugjCa/J6jleZJK51rCg=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS7PR10MB7347.namprd10.prod.outlook.com (2603:10b6:8:eb::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Wed, 9 Oct
 2024 18:52:38 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8026.020; Wed, 9 Oct 2024
 18:52:38 +0000
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-6-ankur.a.arora@oracle.com>
 <20241009180232.GT17263@noisy.programming.kicks-ass.net>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, paulmck@kernel.org, mingo@kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, efault@gmx.de
Subject: Re: [PATCH 5/7] rcu: rename PREEMPT_AUTO to PREEMPT_LAZY
In-reply-to: <20241009180232.GT17263@noisy.programming.kicks-ass.net>
Date: Wed, 09 Oct 2024 11:52:37 -0700
Message-ID: <87y12x9ki2.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW3PR05CA0011.namprd05.prod.outlook.com
 (2603:10b6:303:2b::16) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS7PR10MB7347:EE_
X-MS-Office365-Filtering-Correlation-Id: 2182821c-bbd8-4c90-5d56-08dce8938c10
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nsc98IZF8E4Gt1bMK6vhbpaC8G9GyHzXCmtzueimE/tSQxONzCdN53MNE+zV?=
 =?us-ascii?Q?15TJCaESJKsByDcrDqV8KYpaUdUgV81jIIScvwEbZ7CDVf3yOFYyTGiI1ijT?=
 =?us-ascii?Q?rmmgp8BfOTbJbVQch05id0zcxN/ISy9j7FMWtgp+GLWvVOKAMWrZlvX2HjLx?=
 =?us-ascii?Q?U/cK3JvRfPOq9yDmsaAU4V59XwabDr0QfOkc5plLw7OEfhk4MJep2dLBu2yr?=
 =?us-ascii?Q?tDpJ0KXfMpKeeCK+bpe5/RqUNgQR+i0/BvnZ0A5YwM7ps4IkpB9nGfL0SXOT?=
 =?us-ascii?Q?X8pSyoFug5Dy4GRfR7e53HWL4HIALU+O05iv3f4sOW89GBsRs3inqSmX8QFV?=
 =?us-ascii?Q?OrmGiN2q2o3n6USi+D06b5PH4gA9q/bOwafFC5wBvMSI0pE/LlyYaE/yBYF2?=
 =?us-ascii?Q?B9TGSxZd1JcnFzUDQIAEkJ11srAY2xRNpaBiS9ydKNacthf4xljbv9qxEwnX?=
 =?us-ascii?Q?TWCQMXk2DrcVD4N7QWwUrbKaC4G+IBNVa9uhjiav+CqY0aa+GFexz9mjx//a?=
 =?us-ascii?Q?XuAjkGfvRjeMENjA5MVyAXgxlfZvmADksYIfPU+dPy8iU9Il4GFvvlU4ghip?=
 =?us-ascii?Q?aN2kP9HmXFJ1cNkpykgdjDFdoXt3loiFwtC+JtvrJhZb5WiqQvstWQCJkH88?=
 =?us-ascii?Q?bmMXJykorjyioAwlGiVeKn8mtoxsTQPiiHdsViNdASMDbIIZ2A5R/7g6qiW3?=
 =?us-ascii?Q?wmAsoqn0+m2pzFkDDWds31Ta005GIfq9pzC+Pu1tHrc0AEkPcBvVpbHbJTrJ?=
 =?us-ascii?Q?Uv9QKpQgMrXUTsKbOGtbCXJMT4sAUk+mbNJuKZs0xEPk7LNvnKv3mR9VhgCQ?=
 =?us-ascii?Q?CGDLW/JryxOwdBS3YVqpoY+V9qOn/h3R1ogSpTj+r7GvjMFf5pyhEr5BKjoW?=
 =?us-ascii?Q?0dLd/pxAa/myQR6ONttaunkWI+cVRndgTQoQg6vFq6KaodyH6z41h0UEUeSY?=
 =?us-ascii?Q?siRXJ6ZIbdHYyfaEPxBoktp6iiKwDh8jvVYq/6Mlwe2i7lEQbCZQUfl6WC+D?=
 =?us-ascii?Q?rygdDje/QDYoBa/DVIhb3YrDZXHNwf8G0ZXDEAa8egq8M6kfu3s9Eb9CFSeN?=
 =?us-ascii?Q?EWJ0ymwL9YnELJb0vLVP/9C7CbTxoBZUl7A/QIdq/Wr+TVCLrEZvwWl4vo07?=
 =?us-ascii?Q?/OjChlkTjux7zAorzgs+FwJAsI8Hvn6I1A2kaT36xU9s7FuCdAUZUAcbUjz4?=
 =?us-ascii?Q?WKceeqRSdbKprWCXgOPK3j+5RqOvPBe+KQ2tz5ctPFTvNgKtlE5XajhLeCj4?=
 =?us-ascii?Q?cN1qreMSB+6XvEEexdq+fbJC/A6kYfGzWvmgBZ9EUQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HI7iEo6dF0DmYNjJCoeLUFi9GBzbpqizFjwTJnoFBhDZ4YjASyRuxe57Ebbn?=
 =?us-ascii?Q?009I1GW5+K0nSiEQSIhRWIKlUJx80L1K7scFbyr2r9nkVoeq71Wql2eWHBwT?=
 =?us-ascii?Q?V/I6pOG17uK0I8UZ2Ajs1d6YaOLhJFNi1ZVKMvyK3ztN/iExUpa6HHxfRnjp?=
 =?us-ascii?Q?BQGxuGdzdHOV0lej2TAu/4kGoP7HXJZ4tI18ThNlkrENzg8JnRNRx3SxIuhe?=
 =?us-ascii?Q?h+C7mHU4Qw9/pG+ZvttgBDCyOXVvLPHfiQh9Zwi5+3e0bPclvk1ZRPbxodyI?=
 =?us-ascii?Q?wkJlod34WYzf7PmbETYChGT9oy4oMNVUytIjwhL/zXxq8PDTvpnXPdtiO8lO?=
 =?us-ascii?Q?My4yp/kYvIHVe5BfTvPXE3+xJ8hQAYPMTBjj/cnJCpY1l424gEFsbxBSwqL9?=
 =?us-ascii?Q?BlweSLMHoiXcApnen3eECoU91f4QHn1pbYtnDjT0z7seRB4dFbeSRT0/G+Zg?=
 =?us-ascii?Q?SrFdc5ZaIeJBt5m+r26yYKjNka2usVRgrNftkaSl4xCRGSHbM13xmpq5fLFE?=
 =?us-ascii?Q?e10kft+dwSUwIcbAyWvea7E8GvmheCCLyGYUDGQajM+nMZzzRSRTK+1wAPWJ?=
 =?us-ascii?Q?q5dzsEXd8ZyAUlIreo4UiRmdrIRnKZvYRl6vMWRl3wHvqMiyw12+RuCbDANU?=
 =?us-ascii?Q?n6wI8Z7ki7Sc9NXPDYNhuGmo4GHgxqmMb33xUuudZJJa7FukGljG56UntGf5?=
 =?us-ascii?Q?VcP63WAlmuJA1s7TxAlruvoMpD8wijWU4RphpTDPTapwerxHJ0AvfD17+nhM?=
 =?us-ascii?Q?X0J2oaI2xsTQyGThHLf3d4zmiJurW1tQl4FkkdggKl75y7wAMZ46fX6DDUG5?=
 =?us-ascii?Q?R+h6CcF321GjgpQcsDUAmDn+vef9XLZwcx3rhIaPfvUd0547DILZti2RmTt0?=
 =?us-ascii?Q?18K7cKVlMjMDfqLG8+3EaaMhZNShhydWkjVHDa2OD7g54KwaaU24vDG6gKr9?=
 =?us-ascii?Q?oXeGNgeEN4CVmkl3GtBMn9u85oYwaks6t3vZKhsqqhE0vkbI6enRSgKSNkZq?=
 =?us-ascii?Q?mB7gKuViDfNPHKezeeg4jLM9UMxxDAM+urWOjRxGtp52mAxfQSnHRZSfZz1U?=
 =?us-ascii?Q?nXPlyFRmofk6Wib5Sa1kmuH4IJiBbgXWKPmQFXHq7oGSRiYfAEz/u3atcL3E?=
 =?us-ascii?Q?AZ2jtRGKyQvQ9FIZVGTq+/YWXpd53cFAUpP1sk+DTzzwDZ4hL8pV8SOqOjhA?=
 =?us-ascii?Q?lKlmVNujHIHlY4ccHlRV8/IbtkShnssrs1Ua/3GcN7k7LjfY/FoPsN9sKZ34?=
 =?us-ascii?Q?yWe8OoCcwmYEsZKgbHsphZ8+xYfX3H0ZB9quri0cx4J3esZhjaNoK3FnGSmB?=
 =?us-ascii?Q?sovQeygczjKuALlHp7srQJyv/6Rz/hRjcHprxD6GYPUezhTwFK2S+EhoM5aV?=
 =?us-ascii?Q?dImr1F1ouzHhxBQ3eDxuYoZJcx8R3Eyid16EeJn3BEHDQcC7wbQgcH3k5iog?=
 =?us-ascii?Q?nSXgpl90texql5YTOyITWNoH0QSEHx27N59nkmT1U6UT6m69vXYqZhVhWlo0?=
 =?us-ascii?Q?rBZ2eBWyXl/YTb33N68aszAMK7hm1sDcWUuTYGtB34BWQXwL/WVt+zlh793J?=
 =?us-ascii?Q?YBaHvkQ1bHU3MNKkfg1mBjb+eafo9vXta2me381COotvMtgqz3O3kp+b/zMo?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HvRMWnC3vua9ryE2k7AH5LSswnRkQFrh98pqp1G7UTIvbx4BNaKM/y22+VADe2cQjDZcSDaap556ywZjQCGS6Nl2hdCAw+MpeV4T7XR2SntTUR0vV4npheCpfDoO0D47nDpwtDjCS0Mzm3+jM5JvUjZFHcECMpeXkiXfuF84oA3pjrXU9dSxsIQjkIK2+dtKLp6Zw5dVhqDf7h2e9+hrvMbJm7diKVnS/DG6zOZpl9Sd/uNEraLL1wvDS0Sbx+UAXT3vPYjLqqC1fBCm83Q5YJqD8fqTm8otmAEd5KRW9l1G3lnnWgyTuI80IGjdSrxIws6KEfRENigjUfOHBrUFL8LKTDJCwdlHUG5tcXaNOy+OqbQmYePQqhfm2EKKSV+R8oskOZQV1Gi+OedZfk69rWHua+oS0vyKA8kU6N98bwgajwB1QvFFyjJ3BAY3IjvSlLH4yinqWT6LOFUUph6A9vJZSAc7GJEjGtSUfva2gfFwsGt8bcEqQjnOTBWaFgMbI4XH/D0HeIuHe0T+opQTjlgDrVw204X/hCcz0a67nxtP5I3Wyr+9iyya45S8u5A4iWlOC9xmqIqscrQbat6gCIq9kCwRRmn3Trpz+M7h0Kk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2182821c-bbd8-4c90-5d56-08dce8938c10
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2024 18:52:38.8382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9Bcn8bn7du088P3s9FzuT+xBFvqGDqxtU/LOXnCLgmYG5YfsiB+fLgQ6lUdVWnx+Exef5enWswYN3yTXOkHuKf44VKDNyI4AR/5cvoJcJC0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7347
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-09_17,2024-10-09_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0 spamscore=0
 mlxlogscore=700 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410090118
X-Proofpoint-ORIG-GUID: FIbPJrWJevVDvGC2BYhpqBTi7lO56nkd
X-Proofpoint-GUID: FIbPJrWJevVDvGC2BYhpqBTi7lO56nkd


Peter Zijlstra <peterz@infradead.org> writes:

> On Wed, Oct 09, 2024 at 09:54:09AM -0700, Ankur Arora wrote:
>
>> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
>> index 1bfe7016724f..cd3148fb566a 100644
>> --- a/kernel/rcu/Kconfig
>> +++ b/kernel/rcu/Kconfig
>> @@ -91,7 +91,7 @@ config NEED_TASKS_RCU
>>
>>  config TASKS_RCU
>>  	bool
>> -	default NEED_TASKS_RCU && (PREEMPTION || PREEMPT_AUTO)
>> +	default NEED_TASKS_RCU && (PREEMPTION || PREEMPT_LAZY)
>>  	select IRQ_WORK
>
> PREEMPT_LAZY implies PREEMPTION

So it does. Not sure why I included that.

The PREEMPT_AUTO conditional can be removed altogether.

--
ankur

