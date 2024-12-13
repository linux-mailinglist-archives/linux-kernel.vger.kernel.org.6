Return-Path: <linux-kernel+bounces-444257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8215C9F0365
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 05:08:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844B516A32E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Dec 2024 04:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4682F16D4E6;
	Fri, 13 Dec 2024 04:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZDnqWfnd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="vcuRHM61"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FBD184523
	for <linux-kernel@vger.kernel.org>; Fri, 13 Dec 2024 04:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734062860; cv=fail; b=tYxK3HNraqktApQYE/7Jmsri1GPkCs6NXhulGvZ8B9Wc/iG162dFieNfsfpabWLMH7orBAgN3Du7bWu8vUOG6jugW6vHCc72dTSSzbmx9rCzMo3JfWFM4Cs7fOSrWLKtPaDHrUktl8ydCmuywugosjAiQkTpUbkYLkszlfYDEmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734062860; c=relaxed/simple;
	bh=D+sCuz35E6W7FWfRcrrCNPfa5/E8bYYHVWcVIZtC6cc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IQ9Ck2cMvCb1YjcrntD2ycyQv4adEO/86v2YtMur6KrGGwHmL7F7YGJboQ19daz0Vhtf3TuWsXwQ41D4BD+pfxB9uCzvpktti0Ccv+7sIE/ZS4SdkpfLAsW3kzufOQP5PzYMPyfptbkpmDQJLxw1vvBe9/M+UNYISsT4pFSEAfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZDnqWfnd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=vcuRHM61; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD1g05i009107;
	Fri, 13 Dec 2024 04:07:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=nyhYpgS9i9ajJK274JsYhz2GYnOWVmmyT57VtxVhtu0=; b=
	ZDnqWfndzRZ1p7q2s7iHYoW+OmnUpO8KjRYtZeklt2ZWLPs9mMNIvrTUvkPycGsi
	CWq3TYmx85A4oXKjsne4Z3B67uoAVte0W7SLcCP4Y6fca9IJBr6K/9TaCTQLu9mn
	IBbs2dYbP/THEwnqjDStNYIz3U2rrG4e/tn9BsMzsFW/PLnJ8RsQHVGe0dJ83Osd
	G5XmTU8EWy5pKRkFEUv8wee9V6OjfBRVvD4LlTzUOy3VT0LLEHtITtRjp3cIObh3
	+yy7i8fLxSfMQ6vpq4NcCm7PbKQuIO8j2GHYlK1VpKedmSxBPm7mDdi9LfqKG0A+
	F+Jxd9/F/Rb5yz47VQzIJw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43ccy0ct2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 04:07:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4BD3CrM2019226;
	Fri, 13 Dec 2024 04:07:16 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2043.outbound.protection.outlook.com [104.47.58.43])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 43cctc8baa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 13 Dec 2024 04:07:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nkxpLhbFPbIVdT08aVSP+PNiAPvDrxdLDGwFtEbc16I3iss9+ttmCRvRJHY+aEuezyS7xVfPAVDx8PUJvDTr7ZgyfwWPTGQpYbCFxkV6K6ZHlavhyb0ZJupLeOx5e17exL24VWkPeqbCnoLoFJZxfi028xTPe1Rgt3JheqD26NetNf9VXcB4Nl4036fdWI1YB/odw1qqyRrI/Ha1rkppUWTwZ7y4OypWdhKtzC6tvS8tBZ0O/3vLW3dswvpvjDOC27s5ISBX0CzSD+oYrPDsZ8J052iXSC/roMeKArUPFDxhjoGczugQPMQQi3ao5lwbFU8cfOgzVLU5F7rilk9cew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nyhYpgS9i9ajJK274JsYhz2GYnOWVmmyT57VtxVhtu0=;
 b=UCG06bwfd3KjtDTmJZIkwQsln4E1//xCsbgLiSuHD2laQc2r0tqv+CzWJFA8RpD3Gladw0i+svfqIFkjwDNm+p/9ATyV5ihsii0XMwjaDwP38BMQHFI8+wUnVUnddm6eQeVVgx94uRBXL3HgEoSFN1gUbZ3H4YYmnLgUyWuqiEeKIKKF/8U/r5VoX8SsXImrH97iR1HU/YQKPrhjZ6mOvYMMI5dnLesJg/WDrfg1xE7sDO3bcVOJ9CKcmzeCiU44U4ctoTPOnzqb/KmbvAPXHrcIC4pJuZZx67VB+bHMjaJGpCw69mnKWD2DXdICxQQ5Zua06HtNlqp9iYDy/7SaPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nyhYpgS9i9ajJK274JsYhz2GYnOWVmmyT57VtxVhtu0=;
 b=vcuRHM61p44KyCU07PioDKaAaEHhutMfW9Gyr8UraEYLuQ4+t6U1RacNXdsdC8FeaCOgK7ljKnfSkEhK32UpJRLq1PDh9uL+t2MQOq4tMiukjYinaHT8BUrCNbr9yA3sx2QSbBMh472yCVJqCRdZ4owceG41jpc1dtZgXnqVduo=
Received: from CO6PR10MB5409.namprd10.prod.outlook.com (2603:10b6:5:357::14)
 by PH0PR10MB5848.namprd10.prod.outlook.com (2603:10b6:510:149::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.16; Fri, 13 Dec
 2024 04:07:13 +0000
Received: from CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e]) by CO6PR10MB5409.namprd10.prod.outlook.com
 ([fe80::25a9:32c2:a7b0:de9e%3]) with mapi id 15.20.8230.016; Fri, 13 Dec 2024
 04:07:13 +0000
From: Ankur Arora <ankur.a.arora@oracle.com>
To: linux-kernel@vger.kernel.org
Cc: peterz@infradead.org, tglx@linutronix.de, paulmck@kernel.org,
        mingo@kernel.org, bigeasy@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        vschneid@redhat.com, frederic@kernel.org, ankur.a.arora@oracle.com,
        efault@gmx.de, sshegde@linux.ibm.com, boris.ostrovsky@oracle.com
Subject: [PATCH v3 3/7] sched: update __cond_resched comment about RCU quiescent states
Date: Thu, 12 Dec 2024 20:06:54 -0800
Message-Id: <20241213040658.2282640-4-ankur.a.arora@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20241213040658.2282640-1-ankur.a.arora@oracle.com>
References: <20241213040658.2282640-1-ankur.a.arora@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR03CA0295.namprd03.prod.outlook.com
 (2603:10b6:303:b5::30) To CO6PR10MB5409.namprd10.prod.outlook.com
 (2603:10b6:5:357::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR10MB5409:EE_|PH0PR10MB5848:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d03d03b-1511-4e41-ec8d-08dd1b2b9fca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?c10uOOBVngZkIvQibtVrPCrQL8HyMzUKkgFLACuP5GA06ZGejjijRYH61AtL?=
 =?us-ascii?Q?EA2U2WLxM4Cvre4Q9jUSIbKQgmuK0XmMHk0RTQpQ2Y92FkcipOBkbmYO1+56?=
 =?us-ascii?Q?0A70nwXxCrjtacBC0mPuDurBZJMOmtHNAt+YnBg384p/4ztJiO7BwoDYCfAR?=
 =?us-ascii?Q?dTWKjdDhcKwTpw0Z8utIxwG6/jCaB7cplLC45INKE/Lpdqgrmt88ml5fl93b?=
 =?us-ascii?Q?TrLLC3Fu+xThl79tLkeywdi8UfLFs+EU4oaCRdzm9i91oFBPz7CX319kZWsC?=
 =?us-ascii?Q?k3tjw5YYP5xtUyE9aC4YA7iF5713KwxVVDoWSKiv1mH5gVL4rgaxO80w28Hi?=
 =?us-ascii?Q?Y6yltess9UKqVA+JYmBYs4qMEUgKZELQNnOe2OHHH1KFe77Fq/2Ou+yKnLkb?=
 =?us-ascii?Q?XlxvbnXm9g6T/uwaAHk+HsQeerGvjbfuWqO0vL6lRzYw84/DyTdLSTzg5vcO?=
 =?us-ascii?Q?QqXpM3PmeFd/Vsx2kH1uQLPmv/itcSA6KqSs9Ut4R0iGENxck4WF8HzO9ngP?=
 =?us-ascii?Q?sAWsBjtfUn7AF/JVv/Z226Mxz0kYAjyJ5lbE+V3HucmwElaqF/jQn3UeTz6R?=
 =?us-ascii?Q?Jm/ZFrrBKoGQJwdFax6t6iX5Bcn0YCgdaWXSsSFU5uBPZ6ZXxTsGn4zlSBQJ?=
 =?us-ascii?Q?JQmnteXi9SOxnwZEqh2UOaDvUaG/ax042zLqRyuvKc3MKKCHPqP3tE+T3grq?=
 =?us-ascii?Q?pA/2OHol+N/xBucqnsoor1G5+Y358p2fYEpEEOM8kvCxuZN5DUbUsA7k66zx?=
 =?us-ascii?Q?WF02uy5+TeTichkafyAuZtSus3TYNvgIECkQm8mQeFWN13VBYCT3hZ5mujNz?=
 =?us-ascii?Q?TXAy0FQV9Drw6c9b3h3TJRaAt7CXs/F9pLtC88aFenZvG701XufFuPr/Yqpz?=
 =?us-ascii?Q?+fl1y2trk/kkDkVIhnf7aLla5aaGcQCd2pHxtKsOQfacmFff2Qr5zNC6LevA?=
 =?us-ascii?Q?9sxeqzwc5zuDJ6mritT2cUu5otsXzhaBMrdbJT4QuBFF+KyQ2FZKvB2P41qu?=
 =?us-ascii?Q?y5Pe/Bs8V638xzH49UuyqLhmIitBa6ULnV6XN5a4+WyrIn4nVB2VIvbaDnvG?=
 =?us-ascii?Q?30HZHE9gkqp05bfmmuKeWOhcNb7ZZ0nDzuSbG80jX6kDzWi9viLJFyRmUVlQ?=
 =?us-ascii?Q?JimZ8CHC/zUBxemMR1o+nJpzTe4OFwBc2TO6/1KTGIBtCOCW6cpDsNtuTDJC?=
 =?us-ascii?Q?4bvp2QVFcT6VmjKtT0Q4HlAIm+xz4ZJsrIqWhYcNLdIWxpaDuRuqLeEcf7KK?=
 =?us-ascii?Q?RrtX7sT/TlG4C+f6IDWAB/sP9ROAVHUV33yV3RSV414gyLevn+hHlb8wEsk8?=
 =?us-ascii?Q?O8AQy+76FPcnnfbIpEgcB2Gl1r/N2ABpDPr/spu5IAoVhvdOTR5ADl7gd+fm?=
 =?us-ascii?Q?Hy8ncCa5SmFJIQR6FGSf0LSg9D9R?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR10MB5409.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?iyyUvnuJvFWM2LvlaOJDukJrKdRiJ9eOtt1hJtwOaWmRhxLxON4np/v6K38Y?=
 =?us-ascii?Q?h02OcyvNmAtlNVCciNs4cdvKEFMY8RvbZKbcIsr54fvftqQp1sqDHyFkAZnM?=
 =?us-ascii?Q?pqX2iBBvjstaz3Z0mpOQNoQr9rphbw6M6CBCnbX/gLPrRnqNDXPXoU3oJpaT?=
 =?us-ascii?Q?wVhLIw5DuRJ61LW4Z4JyktGwaODV0gYE6HC9DHKZGKVT1oJV0gzRSV9598BL?=
 =?us-ascii?Q?0s7g+tyGFrHyJnI9M61lR0R2KyrrM+vqa/OC/nRW+eeen9dyD/d+4MO3KqIk?=
 =?us-ascii?Q?vjmGftTc5A0EwKi+Vkh/NX/P2Ee5XjgUZqOnsWpQGCIp55WW5q6gRIeal7V0?=
 =?us-ascii?Q?KvBAJ/+JnWuwZiKWBIV5JU0sUERJ+ls1Q0ovo4TW/xOHPxAoU37WXeUeVDXX?=
 =?us-ascii?Q?3Nlub576Br5GvqSF8QfTOOu0kNY3/Yh/P59TZ0vfsp5tCl9I2R37gmxKSwpE?=
 =?us-ascii?Q?lHfonDuwOWdaMZHOkh7lLs/YM+4Gw4vZiLRwJftyG9C6kcZC+LpwaDyn1kPQ?=
 =?us-ascii?Q?pArlukMGOo/YbikGRusHQwyNlCXhcMkaIq94AL3xK5oDEPzSvu9MWI16Abwl?=
 =?us-ascii?Q?DE3RKW2VtKkvE2IiIxrV4ttovBKogeg29IHQMH1KezBejXTp1H0rjqZWK2jS?=
 =?us-ascii?Q?9EYFFtFXML4Bu49sCCgCHsDuRfOSdFhr0Rq3pCgvuoK7HNbnhm0NSVe0CM/z?=
 =?us-ascii?Q?NRdSO9YQmAUQQqEKrVacebPR2nyrWVinat5vSFDDn57ekTeVyx33d1MV+QJB?=
 =?us-ascii?Q?ALYxSkIoSiaXvzKqKrTB08CrnxPysUP2r07GzzBBQ/ljibfF9dY0pfpEuJ3z?=
 =?us-ascii?Q?qe4PSLMcCvehY8PL4sEhQo1p4VDqzi7/0RFH4ssHZTQZSz3Jh8Vxt1+MpL8S?=
 =?us-ascii?Q?+ef/5NG3E1c+nRa/oe+oBpy2qvSHgiG4C7rhVeBURP9JbbKbWcaKcbVxroMm?=
 =?us-ascii?Q?UzFrTVjT6WByDgllVEz6/1RsJnTzWv8bYQmgyUxlB+bwrJN0iW3LZq1S65ws?=
 =?us-ascii?Q?IQZGl7VUEx6q3SyDcAc2nZQm3TkLl2vhuAKrqNMLO0wkOJRGGlep8FZCST5B?=
 =?us-ascii?Q?Q4RqfPwLl4mvNnX9Hbn0AKWKJNC9VJI+B8XNxcsR9yyiEccTQ7znlLlHm6IR?=
 =?us-ascii?Q?npYFKa8zAxGdIdI4wi9pCLIPfVSndv1xd6/impIICrrfcjNBRjthLIKLigMs?=
 =?us-ascii?Q?14ny2Vi7Sxp9DlnqwItUDNSuUI9MxSYdnFWMLTb7hrnJTlSgxvAU73ZJRebA?=
 =?us-ascii?Q?KfTRFa1unqS+46/c3CR/NaoUZhS+bghA6kJTTSoU415oEDv39/uj44dVXyT7?=
 =?us-ascii?Q?cN0QwiLYaEgpbRV+KSxoxMY9arxLN0649dMc8gDp0FaxDLrg4Ibm62s901+T?=
 =?us-ascii?Q?o6rdlx4Wmj0kD6EIW0JLAznUPRZ9egOR06YcZBQ46Zrr7Xxj7206i9HNnTvv?=
 =?us-ascii?Q?gURrhwpBRGXe0yg2hleHVE+KcLXpVbFR/21WJsjgKKAaeO9N19yvnfXr30fT?=
 =?us-ascii?Q?H2uL6uw5yRedqru5DDMEriyV20f8+hW3iA3ULbig0IeQ3s6gDjSGQrax1deY?=
 =?us-ascii?Q?5aaKqTydCagvnaP+UUxkGshQ9K5Q2ToNGQKJeNhbSBj4ezrwvLwUobFomI2/?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rw1bGbYihDhFU+TPjBqRCDcb9mCzCkFaWH4ANT9OqBs47RQxadt7wDDnaGp2VcF/JUM8vvLwjbsbj7LldwEbLQKWvx23wv2Ab5LeeS685LPELfx0YLWYb3LuSje+4m9Pq8i7ZTpuiykeWom3zU80I6YNoE+QQil1Id8lsMdD8jp4Xz6FBwvWS6B/lM9M16hadLkIXYetvSA+NKKgrUsHI7v/sqbWa0UcKadRobQk818rwYCVXl5cdUjTloji8AimtYD6v1gCqcCvxlIgDjam+qcn/YcGj8aOFKAJlV/GWaCzZrR6M0tReqwrfQQF4I3FbW9VQYWjDocJDORU0hFP5m16KoliAJjRljgb5LyFcVft+VUZEoxAzoXaFTeP3+H1rB86KAWFDOV1qHXtSnvRNdUqp3XmRzMBzsIUF2TXAsdN+CzG5afqswgMsLW9Pc9yEKH5/tpbNd6PPoIvL0xcKh85dywXj0l0WCLGUTNy4dOnJpxnVN0D9XNy5WxQJjsajbn6dTTJHK4etyMp19OB9YWgAG/JwwEDMR2X8tps0uX5p514KkSBnADKVW/0DQ68yxh5bsPPQAQt3DQF2aEjMF5Bc4D4hIQlGkbPwKlGK18=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d03d03b-1511-4e41-ec8d-08dd1b2b9fca
X-MS-Exchange-CrossTenant-AuthSource: CO6PR10MB5409.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2024 04:07:13.6323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pPg0atqdPLSTFOz62KadwvZvm8XRla3khCisXnK17XXxo53EkzR6Ux+rJwMnJeX2xU8bvipMSiWM7gYpOedgWCXD6akQCv8Qroc0ayERGa0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5848
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2024-12-13_01,2024-12-12_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2411120000 definitions=main-2412130029
X-Proofpoint-GUID: UfLH0nnWARSnO7Yhg0E7VSOKZwa04M_L
X-Proofpoint-ORIG-GUID: UfLH0nnWARSnO7Yhg0E7VSOKZwa04M_L

Update comment in __cond_resched() clarifying how urgently needed
quiescent state are provided.

Signed-off-by: Ankur Arora <ankur.a.arora@oracle.com>
---
 kernel/sched/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c6d8232ad9ee..4be3e4f2e54d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7281,7 +7281,7 @@ int __sched __cond_resched(void)
 		return 1;
 	}
 	/*
-	 * In preemptible kernels, ->rcu_read_lock_nesting tells the tick
+	 * In PREEMPT_RCU kernels, ->rcu_read_lock_nesting tells the tick
 	 * whether the current CPU is in an RCU read-side critical section,
 	 * so the tick can report quiescent states even for CPUs looping
 	 * in kernel context.  In contrast, in non-preemptible kernels,
@@ -7290,6 +7290,8 @@ int __sched __cond_resched(void)
 	 * RCU quiescent state.  Therefore, the following code causes
 	 * cond_resched() to report a quiescent state, but only when RCU
 	 * is in urgent need of one.
+	 * A third case, preemptible, but non-PREEMPT_RCU provides for
+	 * urgently needed quiescent states via rcu_flavor_sched_clock_irq().
 	 */
 #ifndef CONFIG_PREEMPT_RCU
 	rcu_all_qs();
-- 
2.43.5


