Return-Path: <linux-kernel+bounces-359695-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D753998F2B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 20:01:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07B7228B272
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 18:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CA41CB33E;
	Thu, 10 Oct 2024 17:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j54GWuyT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RV3DRME/"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEA61A303E
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 17:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728583197; cv=fail; b=s0r5M8LR5o8IrV+1SvPg9hb2sAV4r1kGdkrpF6ytwEAyh4b7AVILNpFT1WxxcknAXl29IafOILdPKkP/xx8305YQWEJbfMZ+BfA+sSgKgUCYm96ZZ18e7Zz6iXtZAsmtNDWhCR4t8TiqczIwRyQKMc08mwJmvNr1yCss2zYrBew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728583197; c=relaxed/simple;
	bh=lT3CFJkjkidzc9/8lnNn7D9Ija5XIBCKq2mCJdf4IyI=;
	h=References:From:To:Cc:Subject:In-reply-to:Message-ID:Date:
	 Content-Type:MIME-Version; b=QVJwoiBwqYDRp9AL42GGp22DtU+5b1bh71VbKAE3lNQe77yo/s4BEYArgkDD0K1IqbUajJZai+YJtJu2OmQmZJ+4WQyG3w9WaElYQtsAzcMXd8EpNysokKw0LOxSwSpWA7pMYeV2tOwM7rp/MIsLkms72rNQeJokDMh1DSnZ9Lw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j54GWuyT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RV3DRME/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49AHtdq9013529;
	Thu, 10 Oct 2024 17:59:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=JP6gApcfzAe0h9s+SJ
	kXkNolc4ZUs4QmYZCD/uxcYLE=; b=j54GWuyTup5qfg3cvwGms52CGrWVc50Jq8
	aAFt6Juq2QZpVnGOlQuqxu/oQ7waqzPtcxXDXm9RLrYkjzp7KT7AuxdznZmtIH1g
	JjfAmg3Jb82xMfbwyxLIaNVw75vWZ1nrFEIG4JVAgRvAPnaGVWs/jPUhJDsluOEN
	qseYfUQrkJyglTHanpfTqdUgKbmhFXYFxraTP/tTZ2DsDhdcoc9ipwPbXN2C0SfY
	CgcwayxDWXKVnGAIvfHKNoU6NcdGVcWLMNdBeMz2EDiMVtI7sydvl/G0L2mkMnvv
	tjhULX4IMacXoN2O/BRGmHnYc1BGbZyhHzZmCO1VCDTSYcXyfSVw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42302pk7qw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 17:59:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49AHIO6M034162;
	Thu, 10 Oct 2024 17:59:36 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2046.outbound.protection.outlook.com [104.47.55.46])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 422uwacvsp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Oct 2024 17:59:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XhyROc5lzRymRQnfk4ELLg3H9ONiXj5PWKQiNQnklShfi8R+4AbMPjWYp3AQgfBfHqQG0oGBUHB+bcqaMs9Q7aLuEA0PbQ14IpY/ZeZxTulQaWQMitcVnMC+wl2OJQAxLYpqinXaVmL+D0Rarw1SDx+FoSbc/tD5ygec3NzHsb4N9y7nDKMN0DoVRBDMtQQRQv3k08/i5Wf37YhBGjR3OgTlWCdKKxdEBy5H6agFIR9P93YUD5DI3AxzWVwjVTfI18awUcDWoUoDq7BT7sEfz63KDZaqbn/djOelVDMuGSAU43N6vXFftlArNPGgk28etAOhUSMq9aMS4WC5UPZo6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JP6gApcfzAe0h9s+SJkXkNolc4ZUs4QmYZCD/uxcYLE=;
 b=rTUnahZn5N/u7XCC0mx9Q7zgaxxCs7v1HcT4HRCZUWkOrKa6NEfx3MyvhWbepgQ3JcVNjao9FRw8mIQlUSlZoZ65HxC1p67lWvL0FYkDxuxbGTgQhhyOR+uNSNpdH+CB4nL2tHx3eoW0FyfZ0oi2UTKMQIWKd/zAXEcyAehjyvoIYr9pe0SxUyJKJjpWJhdq/hsFiaGnSt4UG60PjU16venxJDO1pYFDipuG7h3R9w6El8DnbZMonSG8xG+SeZ38H6eg1P8GwSeglpHZvBEf4Y4dMZ1PsyTczmBE7SjS5Dq+Cs8SrkWdPTnVLl9vffy7cYdiBL1tEavRbh3e3VzTBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JP6gApcfzAe0h9s+SJkXkNolc4ZUs4QmYZCD/uxcYLE=;
 b=RV3DRME/Lnm/9Xxh4OW7aAGO9RpWS2mLV+aPGvhtQ2jvVnhoQL3nqb4BY3p+ViW6OL7RyWQ8lARvMdwUfsOB+UXn3icO03AxU+zf41rWhhVijJzrtCRA3jCm/GeR0FTG1xRmJSK1AkkXZpcrFC57CSuU6xtangjMMSk/wc2UBWo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by DS0PR10MB6995.namprd10.prod.outlook.com (2603:10b6:8:150::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.18; Thu, 10 Oct
 2024 17:59:33 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%4]) with mapi id 15.20.8048.017; Thu, 10 Oct 2024
 17:59:33 +0000
References: <20241009165411.3426937-1-ankur.a.arora@oracle.com>
 <20241009165411.3426937-5-ankur.a.arora@oracle.com>
 <87o73t9jw4.fsf@oracle.com>
 <bbd35e87-c7ac-4e69-9f82-7c7338307079@paulmck-laptop>
User-agent: mu4e 1.4.10; emacs 27.2
From: Ankur Arora <ankur.a.arora@oracle.com>
To: paulmck@kernel.org
Cc: Ankur Arora <ankur.a.arora@oracle.com>, linux-kernel@vger.kernel.org,
        peterz@infradead.org, tglx@linutronix.de, mingo@kernel.org,
        bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, efault@gmx.de
Subject: Re: [PATCH 4/7] rcu: handle quiescent states for PREEMPT_RCU=n,
 PREEMPT_COUNT=y
In-reply-to: <bbd35e87-c7ac-4e69-9f82-7c7338307079@paulmck-laptop>
Message-ID: <87v7xz7sak.fsf@oracle.com>
Date: Thu, 10 Oct 2024 10:59:31 -0700
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:303:8e::28) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|DS0PR10MB6995:EE_
X-MS-Office365-Filtering-Correlation-Id: 5079cf92-a2ba-44f4-f2df-08dce9554ba9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rcafPvz4eFhxdAa1h6yWowRoBwg3kynPhF1m51+FMadxMMQ1XzSmpW75Cy9M?=
 =?us-ascii?Q?36UDgXIpCDqPMZeL+9F5VWvWN/7GAEOrGUUoiR+/tlUBTODMtoElwVlXg756?=
 =?us-ascii?Q?O2SKC+jd8KxKVykMxW2IIPymdoURegScmcVunlu2WIWFRQTgyY2se9s4cEKk?=
 =?us-ascii?Q?Diii6OTJV1IWpM2AdgX8RfO4UPC6i6rYBGqmtzlCMrtOIsowP0MlTvbevCu7?=
 =?us-ascii?Q?LcyR4AIIC5KgJaIX6eyb+y7BC5ceGmBR368pxW0Vl963MsUZqmAoXG039HNZ?=
 =?us-ascii?Q?usr3HK9KT2s0T5vB6bahP2ss9fVtLO72ps/9d7dNRdbLJqCWTsWzUKBoeRV4?=
 =?us-ascii?Q?HOBk3PKQ/oArAj/C3hvUt2I2a0Hr6UXkMLtsmPK6tbafzp3lAadTLW0uqIYi?=
 =?us-ascii?Q?oGOMMH90Re3NAxkD0XhzxJzo9RjGV71/J3pz65r2DuhB6qijpwLXJimz4s3B?=
 =?us-ascii?Q?XeY8VVelKZQa9sunPiT9ndr9F5WAUu2YkfH4eIYXWpWq/U2CJr7CHguNVOTY?=
 =?us-ascii?Q?GrvR8Loy+fVPgCaBbOFISLmlpxQkqIVvxY0LA99kP+FhPCzhSGYAFgdwT6ik?=
 =?us-ascii?Q?T1SLJh+ky7nHOV2+p4c5po9AksfkEbyO1I3Ah+j6sViMm073y9cDTJkHwXoD?=
 =?us-ascii?Q?s/76vpMhB03Pr/8TxFx/CMGJbmiCiqCrbzhvEgyHYGJTH8iCXIKot4+NedDf?=
 =?us-ascii?Q?Uy6AWSb6IOoAH/Yz0iTHh5SsgWnT/NbNP/lyPQk8u9GUawliEsqFHeJ/T+9O?=
 =?us-ascii?Q?dLpSiOUulxwYXExppMJoA+aw187w5j2hnHA5xBaXlvJNChSlmOcb1yyttkQT?=
 =?us-ascii?Q?vp69ppWaDSzW44oNZOW4k9W4oDuYBaeKxKg1A2KJB30LJDb4BLMQTsfaLhtT?=
 =?us-ascii?Q?SJYs7UeNQkU8zWsTKkFf9bHIT0zIzqpShWpp0WK1P4xKZKsjDzJDtywh/8AE?=
 =?us-ascii?Q?5V2KCDQXGeLOqbWOqmaIsCq5SJ2tX+B+dn6al1uQwkxta1ijxeyQxg0pvmFR?=
 =?us-ascii?Q?VAmzLBJQR8Ezti24bv0QB2u3YRudheOuSmgVECDX/j2XFaRg8ZNnlpTljxLo?=
 =?us-ascii?Q?d68HJCTcFvl7XDaQ0y6pg5hkmfSLhChmCNCrVh0j/GRlpopMvnfSCXgefmd/?=
 =?us-ascii?Q?ofGMPVkSoiGX9qOiVJcBE+kThRd/k0ORNfSJS0T322wZ7uskDlyCl9ADrOEK?=
 =?us-ascii?Q?CQ/7jfkxA0XHFl1ZSylF40PeQyjbLm44E7O2fLNH59UOkSEcDi/4EVRmTtgf?=
 =?us-ascii?Q?SiwfFKv/3maqZ5WcvUHA9ywQ75V2DZ+MjsOsWCVjMQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rVlDUW7O14OGmw2TFacAQ90mjvglyKhPTrWepUvVSPO3uCZperKLppQ6ai8a?=
 =?us-ascii?Q?HQlmWBaigXTk0+VOkEb77GN1uyIhuiSuniwDUjVGEdjmtdngQNE0bcfJA0+H?=
 =?us-ascii?Q?RBLjehla05Qqlx478RKv4mNhCCixpHqjuBN0dqBMHjtFu3X2Jd5Eh/d6YUYb?=
 =?us-ascii?Q?GwT6AqM3DnAKv8L8TbaN+WGXWdI3bUPVkYminwYE0VLnqchqpBvGJ8iXKE7q?=
 =?us-ascii?Q?IcWw+mOUB3df9vKI/pXa+t9Lrmws/+BakwCh2KezjNiL6+dGsbFz3fn4EeDn?=
 =?us-ascii?Q?g/7TUaQWFZrcGkCObJJcu3nEXuJgMP3ngciIdLO5Q1PG/r+KW6qVOeq1QPc+?=
 =?us-ascii?Q?QBhtFE3D5UXrKEKL+mA2Gf0TjDelWXMu9ZTctUzCExfUaba3tqvxfZxUFzDK?=
 =?us-ascii?Q?ZC4iMHTywD1OidUMDCpB72lFLO5yZT3cE5dE62WMoceNYX+XUyOMjR7SXKVi?=
 =?us-ascii?Q?SltLnOsPQM57x8Vh1Vuv1OaHRcLq5nz6UMkzxqlmEv9OEImFN+HJwGp1wtbC?=
 =?us-ascii?Q?KHck5iY30of2NX75lkqe8zyds1HQ6CsLEX0nyoisg/iYgl4tYZReK+BjT+5F?=
 =?us-ascii?Q?CM2kIl/Rf7ToEeLlF2dbO02Q5fiVY8WQwYDlQ3aDUzzmW2UaqcBBmRkTvJaP?=
 =?us-ascii?Q?LycurXYbcA5aBSSVjrRxlGgXIQYtJJoQAw3Ri1KuCYMkYyj4wTIz+4Gq3Vmt?=
 =?us-ascii?Q?TesmzGdyQjis241Ej9lb8SJuR/u6WUX/Qgdgl7l0Rqn/MxDqi7h9cpeTAKv1?=
 =?us-ascii?Q?+uvEELlnZ1E/2SkAL6ia8gr0Q8pRtT++mVdtJlKmRCu5DcorgWJ9yMqR/w60?=
 =?us-ascii?Q?RtGlAkhDMQA9A8tAyyf8JC/8mC2zlsJv8/ZE/Scsgh6aJTcHIzxgYVi3Pb9Z?=
 =?us-ascii?Q?iyKHMkVLISBKWJ9Auk3gQMGH3NabM/sEDVwvOfAo8YEG4JEyuUav4qhwUuzX?=
 =?us-ascii?Q?LjCZPquGAcQAHVfJyj21cagJbiDZ3DNg+8xDIBNCtMO13AuaQGk7Y2dOg3jl?=
 =?us-ascii?Q?YYesUQ5fCnzLQ4sKlf75LGs/oimRSgfXS91UZKEqIVNw4pLd3ZaNv2EYxtzT?=
 =?us-ascii?Q?H9MgzKtNirCDg7Bnn3EBylu6vFLiSobIvMScp2qXygms8755JrSrxeP7xQsc?=
 =?us-ascii?Q?VQiIwwqF7Ktzd11x8z6v/Vy4tzSdQytReb65ifqdhaWdEaWcLBiKzQ/Z13z5?=
 =?us-ascii?Q?MiuXDTKnJJAFpoSOuZuApMeUStahwtAe8qDTGdckrHGc1LEybXiP7mqPvxYk?=
 =?us-ascii?Q?wKP3u7D2HwJgfRPY0FfI9cMH+hBTxeOpk3ZmTgQ55D2z1SdcWXlaPguh/8+C?=
 =?us-ascii?Q?S54Bz0kKoBvzQZDxE1QHL871QfRVci3hthmq2aCS5KjTz5oawYTJdhz3Kzvi?=
 =?us-ascii?Q?QcrxyqxiRFfqDc04hplphs9MGzdjRRMqIAK/T4I1YQ4qEL4nsnASmkJCZFP2?=
 =?us-ascii?Q?3MgC0bFegtCqBOkryWKRHfd8zjaJ62ia1RwPZ79mKDVQt1pDzUqoOWRBwwRb?=
 =?us-ascii?Q?jbGZ/Dc2pYRymEd/qdY3Cb7tnExBunDUMYSuXajFjZSomkcQn9XBOG7wqgkU?=
 =?us-ascii?Q?gTimisPk00D/l0/6UEJZqSXxyIvbvuun/7wGFhZT?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CnZTrcOoWZgO8xM0HNXe0/ocY6qaAkt6YcgKce8RsdjZOGxBcIL2UIDlNh9LybR2+JtuUIcADIAreuYm/yrmuROebAmbGvpZ52DGSzuxpaiWhwo6VNkwiKKFpUndZklEEBS0bPEvC6eud73MlKUGCyC4XuAAdaY/flTsvCjk90CXXb7o1LiTTheT864V8KIHogI1RLftovlysiPEe1OBhjeVLUDQijp9M6/iboT/mls8KR98fK+9dJlfLIC0Xet4f22UTObSh9DAJ5Fs9u5QUSKK0Bk05sFsk6/YglThzG1tm5ocu6jg/2jv49JRXeZyoGlf+wVvTkrhyWvjdgZiSO5gCJGhQ0n7jg9jSgKfkCkpxcAREWxs358nRNQYdQiQj5vgIYlC99RYatLBJdshgt/nKFL0AwpL7MAyzLPST8jZnZkCfRUVjuH8TrT4sLsiYSgNaP0QQ1QwNpETDT6rzqQRdy6cL9d1UIqoXanky+JRgoDV2fecWl1yGNSHHqb8e+cyLRW6j1Xh5mzFaN44AxDfWLQhBBM8By/cR4wt4tkJyMpDN3SmuYCQsHkh5tq0N8h1KT3qfzcbsORRuMmeaA6XfNrTHnYYd7dhzFeD87Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5079cf92-a2ba-44f4-f2df-08dce9554ba9
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 17:59:33.2252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 02SWZnz/srPO+1oCj6U8q1Ey683O52FsnGR0i3D/VnozOlaNLtss78dc1/I8UhaQNYaDflDBPcFBbV7CSR9bGF7Tuqe8SEwn6ZCdcKtQD6A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6995
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-10_12,2024-10-10_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=737 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2410100119
X-Proofpoint-ORIG-GUID: Zg0n0AZNJo89GiB0SbRsVrpNfzdMC-Si
X-Proofpoint-GUID: Zg0n0AZNJo89GiB0SbRsVrpNfzdMC-Si


Paul E. McKenney <paulmck@kernel.org> writes:

> On Wed, Oct 09, 2024 at 12:05:47PM -0700, Ankur Arora wrote:
>>
>>
>> Ankur Arora <ankur.a.arora@oracle.com> writes:
>>
>> > With PREEMPT_RCU=n, cond_resched() provides urgently needed quiescent
>> > states for read-side critical sections via rcu_all_qs().
>> > One reason why this was needed, was lacking preempt-count, the tick
>> > handler has no way of knowing whether it is executing in a read-side
>> > critical section or not.
>> >
>> > With PREEMPT_LAZY=y, there can be configurations with PREEMPT_COUNT=y,
>> > PREEMPT_RCU=n, where cond_resched() is a stub that does not provide
>> > quiescent states via rcu_all_qs().
>> >
>> > So, use the availability of preempt_count() to report quiescent states
>> > in rcu_flavor_sched_clock_irq().
>>
>> A note about the inverse of this case, where we might have long running
>> loops which only temporarily enable preemption and thus would be
>> unlikely to align themselves with the tick: in prior discussions [1]
>> Paul had pointed the need for providing for forcing a context switch
>> in such a scenario.
>>
>> I had a patch which did that, but I think it is unnecessary since this
>> clause in rcu_sched_clock_irq() should already handle it.
>>
>>    void rcu_sched_clock_irq(int user) {
>>         ...
>>         /* The load-acquire pairs with the store-release setting to true. */
>>         if (smp_load_acquire(this_cpu_ptr(&rcu_data.rcu_urgent_qs))) {
>>                 /* Idle and userspace execution already are quiescent states. */
>>                 if (!rcu_is_cpu_rrupt_from_idle() && !user) {
>>                         set_tsk_need_resched(current);
>>                         set_preempt_need_resched();
>>                 }
>>                 __this_cpu_write(rcu_data.rcu_urgent_qs, false);
>>         }
>>
>> Paul?
>
> As long as the tick is actually enabled.
>
> But looking deeper, there is code in force_qs_rnp() and
> rcu_watching_snap_recheck() to force the tick on CPUs that don't
> response to the grace period soon enough via the -1 return from the
> rcu_watching_snap_recheck() function and via resched_cpu().

Ah. I had missed that path. Thanks.

--
ankur

