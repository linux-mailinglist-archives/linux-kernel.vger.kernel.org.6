Return-Path: <linux-kernel+bounces-172695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 089498BF58D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 07:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45D481F25FCC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 05:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1D517557;
	Wed,  8 May 2024 05:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IG7/QerI";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="eVM+J/cb"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C7215E90
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 05:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715145593; cv=fail; b=X6bLWcrmtShmWMTtDaLeny9loCO6ljU+sVl6erSmZVBHY4yDQc5qjW/TdoTsEojEqVym+/SOuwO0rMv8jMUH6n0d6C4RzqzNtqMxz9sEJCEPt/ezKkLLNbJnuuVLTVcEjGrlegw/rxHW3gL0k2JIntwUWToiLlKPHkZYRZ6HOWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715145593; c=relaxed/simple;
	bh=PwI4QnZczJXjtgqn3cT0/mvXInUEuqj8QWwqI1XE4YQ=;
	h=References:From:To:Cc:Subject:In-reply-to:Message-ID:Date:
	 Content-Type:MIME-Version; b=an0qXzA6uiWP0nfHG5C8l+taxjBcMswDk1jmaa4jsR6SPNH8+HzfHKHcikYBRuLShUJaH67jMcdimz7vhNrNuv1FLs2TFKZXfAY91E+o5GJ2yp83w9yLtDbPo+BtuWX3RpNDSQBaT8TTRfz3EwIJhWyvV2Cqn2kSMJzLcfaYNv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IG7/QerI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=eVM+J/cb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 447IK7NX026216;
	Wed, 8 May 2024 05:18:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=references : from :
 to : cc : subject : in-reply-to : message-id : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=D7p68GEsMMS+Y5aKY7HdVH+Ew1RG7uhNbMPvpYoQMf0=;
 b=IG7/QerIUQEIMbDRFZTG3lt5XNR8tZNg8qjmYfURrKV2PV8xYqyHDqF2mmYacupAUKUH
 +1vYaUzm3hX/HRhl/zOBMmlPYdymuDz525dLUfdwQgu8DaA13+6LHI4xXnz6pATOQedQ
 e0lGA+o+V7y1cLcEWnPif/w6ZbRw3Syzu17feZxJk//1KCmX4w6VlzLznXOxq2VAS0t9
 G6nKnPM/UrYwEQkpltrQ7ttKpmFjM1JYHt2deBKkEbd2HreBQsQqvzpnxh2qmVxA1vbx
 NCmnn3NQEUOU3fsb460WgPk1J8tTEA+hcNc9TMq9WqQPbAcSSvbfgwcvrKCZp7tv5RDd 9g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xysfvguxu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 05:18:17 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44841HHU024509;
	Wed, 8 May 2024 05:18:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfmt8fs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 05:18:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YlJeyk8sQvaOizztLMafu34WzBw4qZy/QUUt78Li20my0LWS+w8LDIfhKGGCB9rVOEYL1vOmUZGIAMSFndAb/czzrtS9wmBUrEKkA9QDhfL69KAovue6LkN+2fgm8F5YtQN1w7pRGeGcQfA2cVJ85f/m4UnJMCUesejRgm50vLQ+TWZQyzPS697YkB4u+UiZEe5/y47WJ1e63oqQClMVe7FdW0dEHpjNOkW+I8pWaLlmDiZ47jJTnvcdP0ig+X/NknHSOSt15hjpAy0OPgKkAo/B9IXxVAOLY4ZW8gyaStdM4+3z5ScoeaO4R0ypV7C2Wy5kWbvjN08xkr6t6tkq0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7p68GEsMMS+Y5aKY7HdVH+Ew1RG7uhNbMPvpYoQMf0=;
 b=cdCSAF52JrB7S6Hcg/nO3xwZgh9XFBGiwqfJLTd7GCkCpgoxbqKbuc9LXHri1zaN/cB7NuPjlJr9z4idEV/j4rFTNAy53wl7OyT+1FGcwprIymt9SUYhk4KbXlvscucNeBjf/vlOvaHULgKilAkEzoNUIIQl6+waHWP6u1rA6zlIUYukwt229yWR1sANPF7hfnDP8hTJ0HmkPqz+jnnpbKs8dMC1TPKCsp7nJoggZ99nJURh7FB9zahA2n1BQ9f6FgIazdsAbysexj9D1EuTATk9/CM0Uk0cMMRjA85hURbp1Z7mZ5t6oUKAEU5Fc74/JtbepmAKBj5EraScPTGjIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7p68GEsMMS+Y5aKY7HdVH+Ew1RG7uhNbMPvpYoQMf0=;
 b=eVM+J/cbiRhQrWuf1RmsOpeZ80pkgP+4fe7QZmfODtUdmA2rWpdphddo9Vg9UpeK9OzRPb8Ix4BnJeoBElq/Xg0Nu1Ds0bQQWUp7yvcF5eXQsaxoG2MjrLIWmz46fO5WOAe3rO5t10fDxeaCZIQYzyrKWKhzWSjd6MSWoIdQjdI=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by SJ0PR10MB4525.namprd10.prod.outlook.com (2603:10b6:a03:2db::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.43; Wed, 8 May
 2024 05:18:13 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 05:18:13 +0000
References: <20240213055554.1802415-1-ankur.a.arora@oracle.com>
 <74ffd154-5d92-4303-9977-6ddc9accdf01@linux.ibm.com>
 <CAHk-=whrTE30xzuq4mcXidT4M0z_HRYJW9i8M9gD9VG7d29Qpg@mail.gmail.com>
 <63314d92-9226-4005-a166-37c8648c5351@linux.ibm.com>
 <87r0esc5lb.fsf@oracle.com>
 <34f216da-da8f-44cc-a9fc-47c8634e84c6@linux.ibm.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>,
        Michael Ellerman
 <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Linus Torvalds
 <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        paulmck@kernel.org, akpm@linux-foundation.org, luto@kernel.org,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
        willy@infradead.org, mgorman@suse.de, jpoimboe@kernel.org,
        mark.rutland@arm.com, jgross@suse.com, andrew.cooper3@citrix.com,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 00/30] PREEMPT_AUTO: support lazy rescheduling
In-reply-to: <34f216da-da8f-44cc-a9fc-47c8634e84c6@linux.ibm.com>
Message-ID: <87le4kyj8t.fsf@oracle.com>
Date: Tue, 07 May 2024 22:18:10 -0700
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0300.namprd03.prod.outlook.com
 (2603:10b6:303:b5::35) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|SJ0PR10MB4525:EE_
X-MS-Office365-Filtering-Correlation-Id: 3fb69a1c-789d-4f8c-fe1e-08dc6f1e4244
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|7416005|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?DOZXAhs9qiHhrt62Any5qhbF9NboCL+Zbl0pDmI9yOv7DKny6LaDqmO2HrKc?=
 =?us-ascii?Q?qX1m/D2cCYJXXqZMCSQCUe8shQnh1c7rrUr+YN7PMCpnuKvgXCUl1ZBtZ1MD?=
 =?us-ascii?Q?KgtLkH6diV3O7UGHDaGMnFYvvf8GkCTnP/h0xUxOYkwrr4eVB1QG1Z5G1SzP?=
 =?us-ascii?Q?Y7Nr77NeDafXpJ/FHMTIc8rTH9oDcu7hZXKaGugKnoCDKt+m0ddU+jNVSL57?=
 =?us-ascii?Q?GZLHLog8LMix6fu+rIOZAbkVPjofUvO21KpXlaHrxLUmTF6uSrlSr7mF9CZh?=
 =?us-ascii?Q?IctpMPyT5oPJif6i0Bjq6oI71CZm9ECHUvZ2N/3oU4zeb9sDKDpcEEZyud1J?=
 =?us-ascii?Q?ulswjEv7x4tHTVwxE89Jkm/dYLhmF02uIADWWy+1UMVppd2WctpcV8XB26cs?=
 =?us-ascii?Q?lMhL4z72ufiO+FVnbYaoHY84wGhEQTL5FeXE1zzEfAhdrzvkarISNq2QO3Qa?=
 =?us-ascii?Q?uutOZ40JmOc1AugLWjQbBXee9YZVtx7RkbXcOP5ZgQo43rDyDKzGzUQise59?=
 =?us-ascii?Q?DDQGRrvzkfQ2j5SVU7UPg5fQ7MAy3G5s4/UEGPe9f0zLGQd6aes6H3+dDqnN?=
 =?us-ascii?Q?5C0A9SD0nhjGrI3SPhy5jPIdy11WfKiUZHhf/h5FdF6VlwaqwZQ8C7x/PbRs?=
 =?us-ascii?Q?dz4ja6kcZcou/0glRJ5J5yL0cIcRzONBshbHMMUJDHt3BnWCHQmp15vjFV1o?=
 =?us-ascii?Q?y+F2wGN65n7r3fEV1JNagFhnDZnZWgkftthBImH6Na5vzlBSQFXo/OrOCCDa?=
 =?us-ascii?Q?34jPKvHI6ENEUwRMka0rr+bsvIWS2rZYhl1VZTHgdS5H0uL+c6SD94GQ3pxf?=
 =?us-ascii?Q?3DSnq31WASjUIUxSzfzYqkBADbsMdjH9BWh52K6PwHM97wW1n2M0wOC2vVjO?=
 =?us-ascii?Q?cRldgC65CoK1f+Y6KlfeSmRx8efbEGDIgqLQQhp6u85S1/tXNKJDUyRREsLG?=
 =?us-ascii?Q?3HmAZ/brHQH7Xy+FC6SfGwUjKBnuCYkd4CyjBz5Vu62G8sqku3RvWynIIU2X?=
 =?us-ascii?Q?3G19/5zgjrP7ML0SZL5JMG418iKnl5YLLUUNwI9os0453n/42I1CdoakvMHl?=
 =?us-ascii?Q?O280mdhTCf5PmRAHPHeeU8kHFxdLqRHJmfqmopj6K2WOX0t6YhSS17RPXZSH?=
 =?us-ascii?Q?HErffLbL22guGVZ37njUW9RInoifno1U9C9wNYnJAxNsispdpZA7coQdY1P0?=
 =?us-ascii?Q?FV6BEgSBzfVQFpb0L9AcYAZzXtHIYXFjFFa7lSHxNla/EmWF80RaoWMW2fyj?=
 =?us-ascii?Q?wyg3ZfuvixbUjx7JSmjlVQO/JDT5McEjV0o5buvCAg=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9gFakMw1YbVb8uPRCMo3iRy2vXZkrIA2BDO1qjbAqv8/wpAurjkFjfvRR6v6?=
 =?us-ascii?Q?1Vo4ZM5M1Cbk8z7JAEC7pvW81tAWDnPZkPLjSKA73MIfCt6j0HjhFN2i2xad?=
 =?us-ascii?Q?hlxvGdHvcvT4MKtCqFrWUdjjXMoMHVfVjHnEOIJPzrrRJsE4Zn7tdNEUCE+V?=
 =?us-ascii?Q?f19oz/FFIE2nDUJqRdN9j8f46fyDqLRTXSfS0z8cQ95qg+etuuy2l9lYnHMo?=
 =?us-ascii?Q?VYjVSIEJpa6OSDAcBNwYBIYi8VaIO/loUEk0HRWvoLa0YqYzZrq1IpWkdp0c?=
 =?us-ascii?Q?712iempOJn/2aVAukEe+woZ0wQsFTaZVI0DbQ8O7QKbcEsLQgEE+pPofNpPc?=
 =?us-ascii?Q?VD7v4EbXcjqyxzQKX5bdLsL57NKvML+W/kM2KHjzH+k+apXUoUoHn4lGie71?=
 =?us-ascii?Q?l2FGznCDVS31M8lRrR2Yph4Xv1Y8Hz4V5dzLYU7AgqEweXGiHsL5acshsHRf?=
 =?us-ascii?Q?e4aYQzjcW9mQuKOO+pf4uZMcWXhfheoUQ3twSMDAZ73+1rXDMksC6ug/t7Sm?=
 =?us-ascii?Q?XkIQwX83gXOGfSZ1XuZkMzIMl7SdXiy0YEgKOar/FIET5NKcrAVFI42t7H/Y?=
 =?us-ascii?Q?ds/v11P90vXMQ/TIyAHF6Y6aeePGkKfQ4dzybGo6C+aqJ4hM/0x0gHoKC6yB?=
 =?us-ascii?Q?m+++Q+53BFD2s/ce6gYxMcHgRPA6gAaMOAQXbzQanX2RmQTk3dx9TBNbCATf?=
 =?us-ascii?Q?C6WSy+NPViNIjvffZSS5ahp5LuSdjo6Rh3addRaSjcKrtxTFCgCSL7S48VRn?=
 =?us-ascii?Q?V/cp40UnreAQxLsNPGB0Xu84C6vtLCsNePUl+PiScZlnjuBR7X/7KbcbuhPs?=
 =?us-ascii?Q?HMW18TjX4p+bykdQ+mAjvDLDreTfnQWO5AEdPibVcKcIb6jVRMuhD1yyvixH?=
 =?us-ascii?Q?kLAPlk8QIIOj6fFm0pCKe5MOZzG9HYzzUnH7n9FMB9etOOzeW5ONmfSG0mSS?=
 =?us-ascii?Q?JNNqaj/861BXxbL5aEKRrV98l2WDfMwy8VmOy/77ONIhfnVY92ansrDsGXaP?=
 =?us-ascii?Q?C3GqX0Q5DDg8E5GsRJbCog6VD8DkJGQWU0SYaulSuzotzfT9+kU2e5OGCH+O?=
 =?us-ascii?Q?2dD3zLUpFcVoZXipy7oXym2dqL7BhtoMb0I4O6ewumhpVN5PVBaqJcf5xc8a?=
 =?us-ascii?Q?mzeP8AgqGim+piYcvAWDDf25DDezVB6WcJeZMwHL9gvybSINQuKszCBuxLH+?=
 =?us-ascii?Q?Ag8ITs34ynk7xRnJ5F0hZAqotoQaYJ3HxMzIBomCHFxSxJ3vngy5mbe0IrFA?=
 =?us-ascii?Q?Ss63nTwfz3TS/noHsllgTTiOTHHzz3zRwIx4L44WVT+TKqHnKrajwbrAnaFw?=
 =?us-ascii?Q?k8hUUpd0h8T9r+T+O7g9d/RDfrVs64pvWYvC0gBB1eyYceHWjqFpEZSjhIA+?=
 =?us-ascii?Q?7wI9WgaIbFn9VumwuomD/dueVDzq7RoxI1hC9sstPeonCiaqqjNzCR6cEQX/?=
 =?us-ascii?Q?2U2iMY++UHrkVswVbiF+sja7iRiexFz2EMBoGEzsiuwJRwVXDB5yE3DRtQ9g?=
 =?us-ascii?Q?sN+Deb6KpAIEttpihNmImNM5Bn3uGmEUbRxl+PNCce2taqJc40LiOOK+nY1T?=
 =?us-ascii?Q?RKwIcwRCsg8wtG7Mk0LA78z7YEyckwa8j3VPOMIpr1pU1tO145HfFBfOkuLI?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	rSWaZ78PY3fXiX/7r5joi0b+gXnSn8fMIlI/BENXvADrLpE/ewInFS5cNATyy4U0WeOeJS3/CVzaFs5hBC1W5inuXOxpeXilKUBzYGTfHVptsSr6eoPnvkrp4udXycfRID+J605AwNGPXrodetS8UIkaRufeFI02KiuBoCDeWlvpQvFq4qSWpmH2N4PPoMT9YkKArH5RJ8iKOe2UvQjWubCccn8n5q/Si1DUE5tm9a1n1+30Tm/0zdtH35mWjRNj4wM20+FLcuGkRtBp3HLBv+y5KTPfDummlb+bJSzKiuDSdctYz8/uTeLigFM2sNECse3J1NLDvsTSFR2iGtAeazaGP+qHcr7FUB68TkhmRqF0P8zlw+n2rn9jGcAcQcHXC+K3bqtgLtjawbms9B853CjScfyaTT0/sVdcjNFWlpwrPX5hYgNPGx0vpchxd9NbpJMqtmedcWQB3jKHesyQbLW2ybT9CV7mErElNsdMhgPa2qhwhwJFIk4baYeVbRg2YNcgVhua1oUnXTYNu9dxZ1m9aYplDDLLlGIpxQjlN8p1JMAnNlpRbHlHabrymgAHbg6WfDSN191SoI86rxhAj3zXs9CU/Z9aAHfFw737pwA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3fb69a1c-789d-4f8c-fe1e-08dc6f1e4244
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 05:18:13.4292
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D8E45cRxgQFaY/FE1LMaJUr+G6YMhMjxAdaJJARtzUoF04l9Y041u7qgWi3n3cvmiGfqCjkc0XW9n/QK6mUJPkETTZbvaVoM5b9QWM2KPI8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4525
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_02,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=977 spamscore=0 bulkscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405080037
X-Proofpoint-ORIG-GUID: NGbsnk-aT8CkRDysKhtrNnqd0F7_MqMz
X-Proofpoint-GUID: NGbsnk-aT8CkRDysKhtrNnqd0F7_MqMz


Shrikanth Hegde <sshegde@linux.ibm.com> writes:

> On 4/27/24 12:30 AM, Ankur Arora wrote:
>>
>
> Hi Ankur,
>
> Sorry for the delay, I was on leave last week.
> There might be a delay in response as I am recovering from fever.

Please take your your time.

>> Great. I'm guessing these tests are when running in voluntary preemption
>> mode (under PREEMPT_AUTO).
>>
>
> It was run under preempt=none.
>
>> If you haven't, could you also try full preemption? There you should see
>> identical results unless something is horribly wrong.
>
> I tried preempt=full with patch you provided below. ran the hackbench for much longer
> with 100000 loops. I don't see any regression on the larger system.
> I see slight improvement in some cases.  I dont see any major regression with 10k ops
> which was tried earlier as well.

Great, so no surprises with preempt=full.

> ==========================================================
> 1L ops.
> ==========================================================
> Process 10 groups          :       9.85,       9.87(-0.20)
> Process 20 groups          :      17.69,      17.32(2.09)
> Process 30 groups          :      25.89,      25.96(-0.27)
> Process 40 groups          :      34.70,      34.61(0.26)
> Process 50 groups          :      44.02,      43.79(0.52)
> Process 60 groups          :      52.72,      52.10(1.18)
> Thread  10 groups          :      10.50,      10.52(-0.19)
> Thread  20 groups          :      18.79,      18.60(1.01)
> Process(Pipe) 10 groups    :      10.39,      10.37(0.19)
> Process(Pipe) 20 groups    :      18.45,      18.54(-0.49)
> Process(Pipe) 30 groups    :      25.63,      25.92(-1.13)
> Process(Pipe) 40 groups    :      33.79,      33.49(0.89)
> Process(Pipe) 50 groups    :      43.15,      41.83(3.06)
> Process(Pipe) 60 groups    :      51.94,      50.32(3.12)
> Thread(Pipe)  10 groups    :      10.73,      10.85(-1.12)
> Thread(Pipe)  20 groups    :      19.24,      19.35(-0.57)

I presume the ones on the left are the baseline numbers with
PREEMPT_AUTO on the right?

Also, these are with preempt=none/voluntary/full?

> ==========================================================
> 10k ops.
>
> Process 10 groups          :       1.10,       1.10(0.00)
> Process 20 groups          :       1.89,       1.88(0.53)
> Process 30 groups          :       2.82,       2.80(0.71)
> Process 40 groups          :       3.76,       3.76(0.00)
> Process 50 groups          :       4.66,       4.79(-2.79)
> Process 60 groups          :       5.74,       5.92(-3.14)
> thread  10 groups          :       1.22,       1.20(1.64)
> thread  20 groups          :       2.05,       2.05(0.00)
> Process(Pipe) 10 groups    :       1.13,       1.13(0.00)
> Process(Pipe) 20 groups    :       1.98,       1.93(2.53)
> Process(Pipe) 30 groups    :       2.91,       2.75(5.50)
> Process(Pipe) 40 groups    :       3.85,       3.65(5.19)
> Process(Pipe) 50 groups    :       4.91,       4.91(0.00)
> Process(Pipe) 60 groups    :       5.56,       5.90(-6.12)
> thread(Pipe)  10 groups    :       1.23,       1.23(0.00)
> thread(Pipe)  20 groups    :       1.99,       1.99(0.00)
> ==========================================================
>
> Other than hackbench, I see slight improvement in unixbench and stress-ng --cpu workloads.
>>
>>> However, I still see 20-50%
>>> regression on the larger system(320 CPUS). I will continue to debug why.
>>
>> Could you try this patch? This is needed because PREEMPT_AUTO turns on
>> CONFIG_PREEMPTION, but not CONFIG_PREEMPT:

Just wanted to check if the regression you were seeing with preempt=none
is fixed?

> This patch can be considered as the enablement patch for Powerpc for preempt_auto.
> Michael, Nick, Do you see any concerns?
>
> Ankur, Could you please add this patch, if there are no objections.

Of course. Thanks for the patch.

The patch overall looks good. A minor comment below.

 Will add it to v2.

> ---
> From 878a5a7c990e3459758a5d19d7697b07d8d27d0f Mon Sep 17 00:00:00 2001
> From: Shrikanth Hegde <sshegde@linux.ibm.com>
> Date: Tue, 7 May 2024 04:42:04 -0500
> Subject: [PATCH] powerpc: add support for preempt_auto
>
> Add PowerPC arch support for PREEMPT_AUTO by defining LAZY bits.
>
> Since PowerPC doesn't use generic exit to functions, Add
> NR_LAZY check in exit to user and exit to kernel from interrupt
> routines.
>
> Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
> ---
>  arch/powerpc/Kconfig                   |  1 +
>  arch/powerpc/include/asm/thread_info.h | 11 ++++++++++-
>  arch/powerpc/kernel/interrupt.c        |  6 ++++--
>  3 files changed, 15 insertions(+), 3 deletions(-)

..

> diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
> index eca293794a1e..0c0b7010995a 100644
> --- a/arch/powerpc/kernel/interrupt.c
> +++ b/arch/powerpc/kernel/interrupt.c
> @@ -185,7 +185,7 @@ interrupt_exit_user_prepare_main(unsigned long ret, struct pt_regs *regs)
>  	ti_flags = read_thread_flags();
>  	while (unlikely(ti_flags & (_TIF_USER_WORK_MASK & ~_TIF_RESTORE_TM))) {
>  		local_irq_enable();
> -		if (ti_flags & _TIF_NEED_RESCHED) {
> +		if (ti_flags & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY)) {
>  			schedule();
>  		} else {
>  			/*
> @@ -396,7 +396,9 @@ notrace unsigned long interrupt_exit_kernel_prepare(struct pt_regs *regs)
>  		/* Returning to a kernel context with local irqs enabled. */
>  		WARN_ON_ONCE(!(regs->msr & MSR_EE));
>  again:
> -		if (IS_ENABLED(CONFIG_PREEMPT)) {
> +
> +		if ((IS_ENABLED(CONFIG_PREEMPT_AUTO) && IS_ENABLED(CONFIG_PREEMPTION)) ||
> +		    (!IS_ENABLED(CONFIG_PREEMPT_AUTO) && IS_ENABLED(CONFIG_PREEMPT))) {

Seems to me, this could just be:

        if (IS_EANBLED(CONFIG_PREEMPTION))

But, maybe the intent is to exclude support for, say
(PREEMPT_DYNAMIC && PREEMPT_NONE), then maybe it is best to explicitly
encode that?

Alternately, a comment on the disparate treatment for PREEMPT_AUTO and
!PREEMPT_AUTO might be helpful.


Thanks
Ankur

>  			/* Return to preemptible kernel context */
>  			if (unlikely(read_thread_flags() & _TIF_NEED_RESCHED)) {
>  				if (preempt_count() == 0)

