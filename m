Return-Path: <linux-kernel+bounces-207769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 776BB901BDE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 09:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BE6B282F82
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 07:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01CE33E47E;
	Mon, 10 Jun 2024 07:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Gqwbo/7M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="a+d59YO7"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247EF3BBC5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 07:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718004288; cv=fail; b=uBymjNK74yWZVSVK6wk8Z3OF4SUxvwFqDOfpHQ/Xcs7OEAib8w2pvRd5Ou7ju+HC0KS3gJXwh2bQlYBC42vTBvWtWjPYnoy7eed6TInT5p5jVQ8mp01b4A9Sxm6Vus8wyYHJQ1prl50vRHBpQRDSW8MRrO23CUD2mZH8S4CRHG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718004288; c=relaxed/simple;
	bh=FS4hl9A/hYU4pePf2SfPsOEsOUDcu7P/KbvdjdEy/5I=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 Content-Type:MIME-Version; b=jtrY0lo1op+xmcifJmPXlWbYsl6GvGl/7CuRvtp/csgyolznkFZUnoj1qsp9tA3968Y26CWhqUxsYB7E7kOjpqJVr3zMSg0iYRVHWEjMU105HPiS0BQMQWr0ef6K8HNY7S3kZckGk0zE+CWCYq9m4F4kl0USwlTyb9lx+we8LGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Gqwbo/7M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=a+d59YO7; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45A4BRar024983;
	Mon, 10 Jun 2024 07:23:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	references:from:to:cc:subject:in-reply-to:date:message-id
	:content-type:mime-version; s=corp-2023-11-20; bh=i9ICgC04IzHkam
	JNwn7fb/VkGj1RDnM/JIYH08qEnf8=; b=Gqwbo/7Mf4BzcuxbAT5GTLE5ziCLWZ
	WfuFjdxjJZru+plgWbeL8e9WhsYPpOCPmCnoBBbCZwoLYh3D8ByhBlz0lZAWllJK
	zcOSEjoox0O6IyS6RbN00JjNBkq5SEjIY7LFXZDOV0eMu9rQp6n3PSReLrWgXZoE
	e7YRe8QTH+Rrhp35b9zyCWSLEttqZ3M8PGLCieb4OWo3YoDKMrQgmuuMow8e+S3H
	PpawLTMRML93b6BROtr1Gjoh3czzgbgA39N+n2VHZu5/fhfrs8Ln8RwAYHSUqpHq
	EWCPC1MeBzhAZzj9sUqEBm5QGmJ+0ZBx/ucE0WoElUzwRsaOdleENkUQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh7dhw7w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Jun 2024 07:23:46 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45A5VWLi020366;
	Mon, 10 Jun 2024 07:23:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncasnefn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Jun 2024 07:23:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OEDth+kakK6+LSO9wxJ+9KTIT/ie0Sf3Ne9UHsXpMVyT9OEmiYX8veRmeo/tCYq/6Suuc4HZu0dwNyYcDgXEH6itje/Rh6yCGrwARspe3n/4J0DBTTi2gRU0/OSsMtYc+jYy0g6a9nd2Iw471USNA41XC9xQCn8/SXwhAFMXUUXqeAS9E1RghT7nN5S11LcJNZ1cxhMAoGqAIkAqW7EHP/xSN7Qh6PVUXz9GSPHhyPM3zL9LQnSMjQIHYG3z9I+fnxUf0evaZYlpvMOtgZ6XUnIWfxKRKePye6eowCLTl4fRdUgGxfKudQdBtYjWp5DeJGcVIM7CRw6CKWmhnMeAiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i9ICgC04IzHkamJNwn7fb/VkGj1RDnM/JIYH08qEnf8=;
 b=BEidhHhyLBoCAous+qUnXfttC7UVBJa341Q1Hsuu77j4cuew6QVK6RYKnUzWQBvB3OUR/Tt2Fm76iSzfLUhzg7uxdvKNYd8wLDpmT56w7lkfMyzAut8hH5J50rtw3jIYoOPDBnUqr6fQoVXFLzTuXB6gNTF4E+/GsEE7Ygh8oL/cHhsPIJBmN0xQRoDcsU8M746tVA46gJz/7gVIGI4gcACMciAopMwJhV/qSsfDB48gB/Ashcc9QEFo/fumxCmzje0A0WzxJc64uGinpwAxRZmh1Np5eq8lh0e+UmVvvDt2B6Jia4/uMXnc4nrc5ycwS0WYOv4RN3C+vgZPMcA3GA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i9ICgC04IzHkamJNwn7fb/VkGj1RDnM/JIYH08qEnf8=;
 b=a+d59YO7UVAOHYhG0vBKFynQ7mLq/rmmgi/GSFarWrOdVDXfi4qgQ/+ClKitsQRacMp0Z7iTwP/y0QoJ+TKYTo/+E+lyTGiPAc7MyY0jQm1MfC6QF/IeM/QxHnU5dItY5vTBIL9UP7d0xbBDgHvsSvxOBCtZRrR3JIdPu/XKUHU=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by MW5PR10MB5692.namprd10.prod.outlook.com (2603:10b6:303:1a3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Mon, 10 Jun
 2024 07:23:41 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%3]) with mapi id 15.20.7633.036; Mon, 10 Jun 2024
 07:23:41 +0000
References: <20240528003521.979836-1-ankur.a.arora@oracle.com>
 <2d6ef6d8-6aef-4703-a9c7-90501537cdc5@linux.ibm.com>
 <8734pw51he.fsf@oracle.com>
 <71efae1a-6a27-4e1f-adac-19c1b18e0f0c@linux.ibm.com>
 <bbeca067-ae70-43ff-afab-6d06648c5481@linux.ibm.com>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Ankur Arora <ankur.a.arora@oracle.com>, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, rostedt@goodmis.org, mark.rutland@arm.com,
        juri.lelli@redhat.com, joel@joelfernandes.org, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        LKML
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 00/35] PREEMPT_AUTO: support lazy rescheduling
In-reply-to: <bbeca067-ae70-43ff-afab-6d06648c5481@linux.ibm.com>
Date: Mon, 10 Jun 2024 00:23:38 -0700
Message-ID: <87zfrts1l1.fsf@oracle.com>
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0141.namprd04.prod.outlook.com
 (2603:10b6:303:84::26) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|MW5PR10MB5692:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f45616b-add1-4f7a-998f-08dc891e40fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|7416005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?HRHnstolAz1qJJymuT7eV7q35FJiVlr9EjTC3kPzbWZnGtaoD72mEb0mI9JK?=
 =?us-ascii?Q?EKSGZQ+BOI+/phkcy/3nBkru4acVR3v9wT9euPcP5UCOAw5fbFoES5GBdKMr?=
 =?us-ascii?Q?QgCgzS0zyPzIay9FiSQbqY3IKi76P5YktHn5zG5FElwqtWOybCQBBwwWXXfx?=
 =?us-ascii?Q?zNxh8erfML8OXGv/XDMPVLRacY7sc/rfW5yAQ5zG+kaFl0q1ciBSQxrN8o/7?=
 =?us-ascii?Q?WNlLQeLJp0jdelVkBf9eQ5+aOPr9XdDjt0w5CRcO0pC5663Y84cGlSON1hqT?=
 =?us-ascii?Q?tmRYPaOYVsXJWX33b9R3hfy4jNzb6BC61hzNO+kpxY6j5w1niYw/lcrfhyOq?=
 =?us-ascii?Q?YNR0sVA7Qmkn11zuy4jjG95t5yZkDvTRwN7ABSYdfJtN2ujX2evmW+L6AxRY?=
 =?us-ascii?Q?W5CTQz5o5JG54coF3qfgOBsbHuWnVbVVegxx5qUFL1iU4i9U4XzgnHrNB2US?=
 =?us-ascii?Q?cDfluVWLVTWU3mtsD6F//4xMcrUJaf6nDrnMvFreAkDPBruCw2uMxmlYKuhj?=
 =?us-ascii?Q?HHIntXfzIe0+ucVI2FFlLGUiHzJy9iHcDJgui8KKT+XfICnMe1b/Q+SWi4Vw?=
 =?us-ascii?Q?7wYG10otS+wnZF+V4UCmz3+DPFQBhSDNzUmvHeNkmP1+Edf5oXEgdb1gAWvK?=
 =?us-ascii?Q?OiS5aU0oHOfayYcdxCQ8lpxmkHI83XMV64yeZ4T1uwypC82Ga2KW2jYI8iNl?=
 =?us-ascii?Q?CHhOb+2z2dPd2QzFftO6xm5j6RGzCs4bysLnBKMv0ZOlkXhaXW+F/5/Z7eno?=
 =?us-ascii?Q?iNI+5drmsdRdJKZJTuhICN77JJnX/wVoHDf4REOwcisdgXkOfvbkPC5ssb8j?=
 =?us-ascii?Q?XyZNwCIUj8i7nE22KPHwH9AMw+ON48rvYmuhbQwXxD1ITPmrgYaQEdB+CdW9?=
 =?us-ascii?Q?otOJ1M1j2BmPrf5q5R/ijCrocPLEl3VUjJ5oHhIdyIpdsO/ys3OA7AbzZe7r?=
 =?us-ascii?Q?pQ0qzwMq0X+ZsFntwzYQD9J9MxX+d2tLu6W0kXjL8PXm2mue4tSLuJPQT9Vz?=
 =?us-ascii?Q?iPHgiP4MKLf8+sYdE94NCSGejGggosxzyi/iy2He8LQIMlKZnnCkMxUrElQ3?=
 =?us-ascii?Q?yr4cDCXnSxo9AoTrkd1XEw3+IKfEvoZO/5OSnSAm+mZMabsoVnI094StL9f6?=
 =?us-ascii?Q?tHxntGXY+HYLiXxz/NtFP32/D/IgDd1RrgH6TPQcyCe/HgwxByFPZg87ZfLS?=
 =?us-ascii?Q?lBb37JBylKR8viBjcEhkZrQqmn+1m7UzawurSMVDaFMGXjU9Tk/30U5HPpbP?=
 =?us-ascii?Q?0luibo5DdXg/8X+n8+RQucXknnfU0Iv3xXhb636mpuUZ1s6lifdw4pa/xfy+?=
 =?us-ascii?Q?M+NKUaAPXZVdWPSds07SHm+I?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(7416005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?UZDS6zDhpjmht4sDQMh8bVXLaia+M2It9nslmQ65ThGUtwrhd/6pkzni45QQ?=
 =?us-ascii?Q?87Co9daJM5pveEyqb5UgzaPhNLPblvjnDaHFnuKTaQPmKuUJSxl8qmRR7N15?=
 =?us-ascii?Q?MnNY3z/Us1cDlIqgxxX0CU9lT7RavU2bQoCsM2ZM3awNZmKr6I+89v390FYB?=
 =?us-ascii?Q?oguIeuGihhDqq3uiM+9J9QlfsRlbc38VpZwgQjvHV9AttUWFECWmZc5/nHA4?=
 =?us-ascii?Q?R8Yqq9buFXqsiAuqgnMQLoabWa6JfBwMT12xGpX3Q8/8Z3UjAK0AS9LgeFCA?=
 =?us-ascii?Q?frn1r8/tHr1ogEI6KTIHA/W6/O7IkBzo5gEyQb+tzv5CduHGcks6BPk5vStf?=
 =?us-ascii?Q?kt1yvRL8taa6QDAJYF6MFGVRSe2gKwzXxL9oG3x/OiOPuCB61QBqMkvp4tD2?=
 =?us-ascii?Q?CohVL2ykwMzbJdGYmtNbOfxb/8HS0p9cL+Rp7t2JL6sIuzSOP/BdBulov01E?=
 =?us-ascii?Q?+bsY9jECOGurCtUJ1Co30+WyZcAmNfKnRBvN5AaHw4OgeCPmMU6n1iLbS5Ek?=
 =?us-ascii?Q?kdM1413gHIZ6TkJ/TUQaABxHXeintX6bmdoFGolTllweXWyXwdV7Fkm5LoAU?=
 =?us-ascii?Q?HW5ctv1qx8nOZk18x/8jBCrH1DpsnJxO3UFJTN+e4PE2xE2WAPCZFSjyd4a1?=
 =?us-ascii?Q?xdZCGzyLhPitR8P0Mm248DlU1FSiHmps3WjcuNZ5peqxKYaFU9HN7U/CUp4p?=
 =?us-ascii?Q?atmBuRWoZedrePsXatOBKXUaGmMDnY3Mj/pTQwYkRc4KzFFw7NKk1qUgRr+9?=
 =?us-ascii?Q?jZchgWNc/djmHwcReicjkK56hWZ09OqCIXDEF2We0CursLNXjLnLkDJ4oQ2a?=
 =?us-ascii?Q?TWxyO7fr9fwWyN5DDIErJVbcOGAa9bHnA6hnxBUJyVgW3avV9/Z+23si3q1l?=
 =?us-ascii?Q?W8/Ud08LVzm7vmZv4EQlcR/DNpOPJCAkZ8P8lXdybUhkTu2FHI4kAYFfGbO7?=
 =?us-ascii?Q?KM5fM45CikfmUJTW+dzRQ0y1kvMiUbMctWSLM5r35bIh6YiJqRIhpWRp0xqX?=
 =?us-ascii?Q?4wvOBB+BUfnE4qYwQsrHxPfW3zyUWakOkFxV+n2AK2mG6b85odt85psUNt0Q?=
 =?us-ascii?Q?RcNbch7R9Mpk9PxXwiqoLICy1tG1P7TL5wsnq1jU/pjN4zGO4Pl0SCCTg2gm?=
 =?us-ascii?Q?RjZu8qhULvXato/1kLH9coEm/lPW4IKE01ijtfSc4Q51v3BDLQF7eNt+D6xL?=
 =?us-ascii?Q?rniV7b9UI2ekEPpOBwspTAP/3v/dX/E6PbIYCBXUUa1ywFo90ALDdtjKJepo?=
 =?us-ascii?Q?x0z1iiM5201I8P3qyryxwalxzthY0HXz3Yj/eyyNKwjxWIPs2UIahbG9Xfdm?=
 =?us-ascii?Q?NbilLoPkd9nTUlOe8B1RRqyhtM5VhzOQhPUwl4KTErntmQjkwzXSZeCNFdVT?=
 =?us-ascii?Q?u4Y+goc6ZgIZYsfjeX4KsvRFaiD0t8C3vOzWNgGDC2aVwT8n2OYZcTZjN49D?=
 =?us-ascii?Q?GaMk6VqUOI018dpZDBGji0oVa4R4OkkRFF0xp0VUOiK7z9UPTft/N9A7XBhA?=
 =?us-ascii?Q?TrwZqKqC/dGA3MUpuKkOTmkAyeyuGcWTejfVyUwySreulTYn2o48+yPCD9Ax?=
 =?us-ascii?Q?IZLsNlSQpokRs7c7fTbSm7ju6wDn1hcaDL7NG78pwI1ZzkWPp3g6PBmo8g2K?=
 =?us-ascii?Q?YxKcjiE5lPQumJGEa3bSLtg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YDdXgtIf4YqvPC5BlqT/5xhmiDCa4JkJGkK/tAXAfvUgSKrB0NN48p6SFQ9QUCE+B5Y0abpSPCQFHE3Qj5rgQ1vY3YfQbFdqn/PtSRK0rYHgjf/cQ509thwxl3Q0CkZ9VLBsonkb2jdKRxIXBtTxnF8YLN7xTy82607o2oQONmL6OtzpZfs7pq4Io69yPeMgp8vLTxUv0CXoZahZ8DHfm5fyaGL04/xKdLT9KC6WgVetIUsSk/wfXrgEeLxfWIz9/9R+yAFuxljtsThR+LoPg+t6420/VMGhHcHcHrlrYlwGqW3gDkfgBF41AnA8I2EtHDuOnEHcxXd2mz0MTOGVgBhmDTclvFbKy1Jkt518MpWRlMuGWr2UflVyoOsjDL9bmCXnfOIJpXpewaPObUaovhkCWIr3R6DWyHr9FueI3KrvhSSexpoaMWyoDH9RS1AtS6Jb0Qpli0hzLwE88gbwJ+e+joa1SXO/zfXjXvs/1fUy3gs82+xgOcZPuvXSyIr3/G4jLmduQ6NmHtsBJ6hg9PeAKCbEoOwMC8HB2dKRYq05fdPOGqpUF8Z6FfB8Rq/mW9Vhzzn/Fg6nBmk13Vk7kQgkCFZsVSb78zpnyL2fQLY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f45616b-add1-4f7a-998f-08dc891e40fb
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2024 07:23:41.7234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Se44wobizlI+9CdeCq5yZPDNOY5LS7N46/IDdyUR46z9efFLkkdx5h6aXXh0FdXiutHCM1fqj41qKiXisAojKHRt+o7K60x+WZ9MZmFOa78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR10MB5692
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_02,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406100056
X-Proofpoint-GUID: GJD7KfofpUUQx3kyPkiPBBuD8aDHnoI8
X-Proofpoint-ORIG-GUID: GJD7KfofpUUQx3kyPkiPBBuD8aDHnoI8


Shrikanth Hegde <sshegde@linux.ibm.com> writes:

> On 6/4/24 1:02 PM, Shrikanth Hegde wrote:
>>
>>
>> On 6/1/24 5:17 PM, Ankur Arora wrote:
>>>
>>> Shrikanth Hegde <sshegde@linux.ibm.com> writes:
>>>
>>>> On 5/28/24 6:04 AM, Ankur Arora wrote:
>>>>> Hi,
>>>>>
>>>>> This series adds a new scheduling model PREEMPT_AUTO, which like
>>>>> PREEMPT_DYNAMIC allows dynamic switching between a none/voluntary/full
>>>>> preemption model. Unlike, PREEMPT_DYNAMIC, it doesn't depend
>>>>> on explicit preemption points for the voluntary models.
>>>>>
>>>>> The series is based on Thomas' original proposal which he outlined
>>>>> in [1], [2] and in his PoC [3].
>>>>>
>>>>> v2 mostly reworks v1, with one of the main changes having less
>>>>> noisy need-resched-lazy related interfaces.
>>>>> More details in the changelog below.
>>>>>
>>>>
>>>> Hi Ankur. Thanks for the series.
>>>>
>>>> nit: had to manually patch 11,12,13 since it didnt apply cleanly on
>>>> tip/master and tip/sched/core. Mostly due some word differences in the change.
>>>>
>>>> tip/master was at:
>>>> commit e874df84d4a5f3ce50b04662b62b91e55b0760fc (HEAD -> master, origin/master, origin/HEAD)
>>>> Merge: 5d145493a139 47ff30cc1be7
>>>> Author: Ingo Molnar <mingo@kernel.org>
>>>> Date:   Tue May 28 12:44:26 2024 +0200
>>>>
>>>>     Merge branch into tip/master: 'x86/percpu'
>>>>
>>>>
>>>>
>>>>> The v1 of the series is at [4] and the RFC at [5].
>>>>>
>>>>> Design
>>>>> ==
>>>>>
>>>>> PREEMPT_AUTO works by always enabling CONFIG_PREEMPTION (and thus
>>>>> PREEMPT_COUNT). This means that the scheduler can always safely
>>>>> preempt. (This is identical to CONFIG_PREEMPT.)
>>>>>
>>>>> Having that, the next step is to make the rescheduling policy dependent
>>>>> on the chosen scheduling model. Currently, the scheduler uses a single
>>>>> need-resched bit (TIF_NEED_RESCHED) which it uses to state that a
>>>>> reschedule is needed.
>>>>> PREEMPT_AUTO extends this by adding an additional need-resched bit
>>>>> (TIF_NEED_RESCHED_LAZY) which, with TIF_NEED_RESCHED now allows the
>>>>> scheduler to express two kinds of rescheduling intent: schedule at
>>>>> the earliest opportunity (TIF_NEED_RESCHED), or express a need for
>>>>> rescheduling while allowing the task on the runqueue to run to
>>>>> timeslice completion (TIF_NEED_RESCHED_LAZY).
>>>>>
>>>>> The scheduler decides which need-resched bits are chosen based on
>>>>> the preemption model in use:
>>>>>
>>>>> 	       TIF_NEED_RESCHED        TIF_NEED_RESCHED_LAZY
>>>>>
>>>>> none		never   		always [*]
>>>>> voluntary       higher sched class	other tasks [*]
>>>>> full 		always                  never
>>>>>
>>>>> [*] some details elided.
>>>>>
>>>>> The last part of the puzzle is, when does preemption happen, or
>>>>> alternately stated, when are the need-resched bits checked:
>>>>>
>>>>>                  exit-to-user    ret-to-kernel    preempt_count()
>>>>>
>>>>> NEED_RESCHED_LAZY     Y               N                N
>>>>> NEED_RESCHED          Y               Y                Y
>>>>>
>>>>> Using NEED_RESCHED_LAZY allows for run-to-completion semantics when
>>>>> none/voluntary preemption policies are in effect. And eager semantics
>>>>> under full preemption.
>>>>>
>>>>> In addition, since this is driven purely by the scheduler (not
>>>>> depending on cond_resched() placement and the like), there is enough
>>>>> flexibility in the scheduler to cope with edge cases -- ex. a kernel
>>>>> task not relinquishing CPU under NEED_RESCHED_LAZY can be handled by
>>>>> simply upgrading to a full NEED_RESCHED which can use more coercive
>>>>> instruments like resched IPI to induce a context-switch.
>>>>>
>>>>> Performance
>>>>> ==
>>>>> The performance in the basic tests (perf bench sched messaging, kernbench,
>>>>> cyclictest) matches or improves what we see under PREEMPT_DYNAMIC.
>>>>> (See patches
>>>>>   "sched: support preempt=none under PREEMPT_AUTO"
>>>>>   "sched: support preempt=full under PREEMPT_AUTO"
>>>>>   "sched: handle preempt=voluntary under PREEMPT_AUTO")
>>>>>
>>>>> For a macro test, a colleague in Oracle's Exadata team tried two
>>>>> OLTP benchmarks (on a 5.4.17 based Oracle kernel, with the v1 series
>>>>> backported.)
>>>>>
>>>>> In both tests the data was cached on remote nodes (cells), and the
>>>>> database nodes (compute) served client queries, with clients being
>>>>> local in the first test and remote in the second.
>>>>>
>>>>> Compute node: Oracle E5, dual socket AMD EPYC 9J14, KVM guest (380 CPUs)
>>>>> Cells (11 nodes): Oracle E5, dual socket AMD EPYC 9334, 128 CPUs
>>>>>
>>>>>
>>>>> 				  PREEMPT_VOLUNTARY                        PREEMPT_AUTO
>>>>> 				                                        (preempt=voluntary)
>>>>>                               ==============================      =============================
>>>>>                       clients  throughput    cpu-usage            throughput     cpu-usage         Gain
>>>>>                                (tx/min)    (utime %/stime %)      (tx/min)    (utime %/stime %)
>>>>> 		      -------  ----------  -----------------      ----------  -----------------   -------
>>>>>
>>>>>
>>>>>   OLTP                  384     9,315,653     25/ 6                9,253,252       25/ 6            -0.7%
>>>>>   benchmark	       1536    13,177,565     50/10               13,657,306       50/10            +3.6%
>>>>>  (local clients)       3456    14,063,017     63/12               14,179,706       64/12            +0.8%
>>>>>
>>>>>
>>>>>   OLTP                   96     8,973,985     17/ 2                8,924,926       17/ 2            -0.5%
>>>>>   benchmark	        384    22,577,254     60/ 8               22,211,419       59/ 8            -1.6%
>>>>>  (remote clients,      2304    25,882,857     82/11               25,536,100       82/11            -1.3%
>>>>>   90/10 RW ratio)
>>>>>
>>>>>
>>>>> (Both sets of tests have a fair amount of NW traffic since the query
>>>>> tables etc are cached on the cells. Additionally, the first set,
>>>>> given the local clients, stress the scheduler a bit more than the
>>>>> second.)
>>>>>
>>>>> The comparative performance for both the tests is fairly close,
>>>>> more or less within a margin of error.
>>>>>
>>>>> Raghu KT also tested v1 on an AMD Milan (2 node, 256 cpu,  512GB RAM):
>>>>>
>>>>> "
>>>>>  a) Base kernel (6.7),
>>>>>  b) v1, PREEMPT_AUTO, preempt=voluntary
>>>>>  c) v1, PREEMPT_DYNAMIC, preempt=voluntary
>>>>>  d) v1, PREEMPT_AUTO=y, preempt=voluntary, PREEMPT_RCU = y
>>>>>
>>>>>  Workloads I tested and their %gain,
>>>>>                     case b           case c       case d
>>>>>  NAS                +2.7%              +1.9%         +2.1%
>>>>>  Hashjoin,          +0.0%              +0.0%         +0.0%
>>>>>  Graph500,          -6.0%              +0.0%         +0.0%
>>>>>  XSBench            +1.7%              +0.0%         +1.2%
>>>>>
>>>>>  (Note about the Graph500 numbers at [8].)
>>>>>
>>>>>  Did kernbench etc test from Mel's mmtests suite also. Did not notice
>>>>>  much difference.
>>>>> "
>>>>>
>>>>> One case where there is a significant performance drop is on powerpc,
>>>>> seen running hackbench on a 320 core system (a test on a smaller system is
>>>>> fine.) In theory there's no reason for this to only happen on powerpc
>>>>> since most of the code is common, but I haven't been able to reproduce
>>>>> it on x86 so far.
>>>>>
>>>>> All in all, I think the tests above show that this scheduling model has legs.
>>>>> However, the none/voluntary models under PREEMPT_AUTO are conceptually
>>>>> different enough from the current none/voluntary models that there
>>>>> likely are workloads where performance would be subpar. That needs more
>>>>> extensive testing to figure out the weak points.
>>>>>
>>>>>
>>>>>
>>>> Did test it again on PowerPC. Unfortunately numbers shows there is regression
>>>> still compared to 6.10-rc1. This is done with preempt=none. I tried again on the
>>>> smaller system too to confirm. For now I have done the comparison for the hackbench
>>>> where highest regression was seen in v1.
>>>>
>>>> perf stat collected for 20 iterations show higher context switch and higher migrations.
>>>> Could it be that LAZY bit is causing more context switches? or could it be something
>>>> else? Could it be that more exit-to-user happens in PowerPC? will continue to debug.
>>>
>>> Thanks for trying it out.
>>>
>>> As you point out, context-switches and migrations are signficantly higher.
>>>
>>> Definitely unexpected. I ran the same test on an x86 box
>>> (Milan, 2x64 cores, 256 threads) and there I see no more than a ~4% difference.
>>>
>>>   6.9.0/none.process.pipe.60:       170,719,761      context-switches          #    0.022 M/sec                    ( +-  0.19% )
>>>   6.9.0/none.process.pipe.60:        16,871,449      cpu-migrations            #    0.002 M/sec                    ( +-  0.16% )
>>>   6.9.0/none.process.pipe.60:      30.833112186 seconds time elapsed                                          ( +-  0.11% )
>>>
>>>   6.9.0-00035-gc90017e055a6/none.process.pipe.60:       177,889,639      context-switches          #    0.023 M/sec                    ( +-  0.21% )
>>>   6.9.0-00035-gc90017e055a6/none.process.pipe.60:        17,426,670      cpu-migrations            #    0.002 M/sec                    ( +-  0.41% )
>>>   6.9.0-00035-gc90017e055a6/none.process.pipe.60:      30.731126312 seconds time elapsed                                          ( +-  0.07% )
>>>
>>> Clearly there's something different going on powerpc. I'm travelling
>>> right now, but will dig deeper into this once I get back.
>>>
>>> Meanwhile can you check if the increased context-switches are voluntary or
>>> involuntary (or what the division is)?
>>
>>
>> Used "pidstat -w -p ALL 1 10" to capture 10 seconds data at 1 second interval for
>> context switches per second while running "hackbench -pipe 60 process 100000 loops"
>>
>>
>> preempt=none				6.10			preempt_auto
>> =============================================================================
>> voluntary context switches	    	7632166.19	        9391636.34(+23%)
>> involuntary context switches		2305544.07		3527293.94(+53%)
>>
>> Numbers vary between multiple runs. But trend seems to be similar. Both the context switches increase
>> involuntary seems to increase at higher rate.
>>
>>
>
>
> Continued data from hackbench regression. preempt=none in both the cases.
> From mpstat, I see slightly higher idle time and more irq time with preempt_auto.
>
> 6.10-rc1:
> =========
> 10:09:50 AM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
> 09:45:23 AM  all    4.14    0.00   77.57    0.00   16.92    0.00    0.00    0.00    0.00    1.37
> 09:45:24 AM  all    4.42    0.00   77.62    0.00   16.76    0.00    0.00    0.00    0.00    1.20
> 09:45:25 AM  all    4.43    0.00   77.45    0.00   16.94    0.00    0.00    0.00    0.00    1.18
> 09:45:26 AM  all    4.45    0.00   77.87    0.00   16.68    0.00    0.00    0.00    0.00    0.99
>
> PREEMPT_AUTO:
> ===========
> 10:09:50 AM  CPU    %usr   %nice    %sys %iowait    %irq   %soft  %steal  %guest  %gnice   %idle
> 10:09:56 AM  all    3.11    0.00   72.59    0.00   21.34    0.00    0.00    0.00    0.00    2.96
> 10:09:57 AM  all    3.31    0.00   73.10    0.00   20.99    0.00    0.00    0.00    0.00    2.60
> 10:09:58 AM  all    3.40    0.00   72.83    0.00   20.85    0.00    0.00    0.00    0.00    2.92
> 10:10:00 AM  all    3.21    0.00   72.87    0.00   21.19    0.00    0.00    0.00    0.00    2.73
> 10:10:01 AM  all    3.02    0.00   72.18    0.00   21.08    0.00    0.00    0.00    0.00    3.71
>
> Used bcc tools hardirq and softirq to see if irq are increasing. softirq implied there are more
> timer,sched softirq. Numbers vary between different samples, but trend seems to be similar.

Yeah, the %sys is lower and %irq, higher. Can you also see where the
increased %irq is? For instance are the resched IPIs numbers greater?

> 6.10-rc1:
> =========
> SOFTIRQ          TOTAL_usecs
> tasklet                   71
> block                    145
> net_rx                  7914
> rcu                   136988
> timer                 304357
> sched                1404497
>
>
>
> PREEMPT_AUTO:
> ===========
> SOFTIRQ          TOTAL_usecs
> tasklet                   80
> block                    139
> net_rx                  6907
> rcu                   223508
> timer                 492767
> sched                1794441
>
>
> Would any specific setting of RCU matter for this?
> This is what I have in config.

Don't see how it could matter unless the RCU settings are changing
between the two tests? In my testing I'm also using TREE_RCU=y,
PREEMPT_RCU=n.

Let me see if I can find a test which shows a similar trend to what you
are seeing. And, then maybe see if tracing sched-switch might point to
an interesting difference between x86 and powerpc.


Thanks for all the detail.

Ankur

> # RCU Subsystem
> #
> CONFIG_TREE_RCU=y
> # CONFIG_RCU_EXPERT is not set
> CONFIG_TREE_SRCU=y
> CONFIG_NEED_SRCU_NMI_SAFE=y
> CONFIG_TASKS_RCU_GENERIC=y
> CONFIG_NEED_TASKS_RCU=y
> CONFIG_TASKS_RCU=y
> CONFIG_TASKS_RUDE_RCU=y
> CONFIG_TASKS_TRACE_RCU=y
> CONFIG_RCU_STALL_COMMON=y
> CONFIG_RCU_NEED_SEGCBLIST=y
> CONFIG_RCU_NOCB_CPU=y
> # CONFIG_RCU_NOCB_CPU_DEFAULT_ALL is not set
> # CONFIG_RCU_LAZY is not set
> # end of RCU Subsystem
>
>
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=y
> CONFIG_NO_HZ_COMMON=y
> # CONFIG_HZ_PERIODIC is not set
> # CONFIG_NO_HZ_IDLE is not set
> CONFIG_NO_HZ_FULL=y
> CONFIG_CONTEXT_TRACKING_USER=y
> # CONFIG_CONTEXT_TRACKING_USER_FORCE is not set
> CONFIG_NO_HZ=y
> CONFIG_HIGH_RES_TIMERS=y
> # end of Timers subsystem


--
ankur

