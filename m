Return-Path: <linux-kernel+bounces-402365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B4A9C26BF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 21:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34D30B233DD
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Nov 2024 20:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A671C1F2B;
	Fri,  8 Nov 2024 20:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bWzBEbKD";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="rhfrUdKC"
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295EA1F5854
	for <linux-kernel@vger.kernel.org>; Fri,  8 Nov 2024 20:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731098528; cv=fail; b=epTsRW/z/eM+Qo6iR2DIMroToLDENNEDDV81vzZ/qCxfbp8gICDhVQmGJbLjaefy0qe8rlYcj9QfbfHhru+UOkw28ctdA1TNU6YxHfCOEvw+2ZoraeaE1cpALeD/e6YNpym1F4q94R8VSarEueyIDv6cWX8XPbU2EYUQ77GTACw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731098528; c=relaxed/simple;
	bh=Ui9c+LPXjy+CtbZYWo/PYZH2m5+jgH4cyC//1iKsZzM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=VhcaeBc8ZUl3jTekZLNvZLCXXclrJxYL6a1AX3bcmC4HYAo4jn3dToXAyZUmjA0m4Pl9TkteYnXVXm5ZgB2Yy29OjxXVdAX9nhGoy+3NVrNUgyMV6gshSbX+uxevAGGunOy9i5QpJg4JOD1Rl+0yWCMVKRHrQxBWSVsqrAiU8jM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bWzBEbKD; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=rhfrUdKC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8FtWEc001556;
	Fri, 8 Nov 2024 20:41:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=Weuii9cKKaqnTt2hjH
	beXBXwmGiKAgxBDHMwuyEan3A=; b=bWzBEbKDefrPD3iHsb5ayY1HwZJ2S83Gp0
	cpbU4BXx5RCmQGKRijbHib34mXaNNMMiAHBEoQWrsfrD+KvWn9rr9grcXy+zjJ4E
	sUVKYDqX+eEDFma/bBavk2FnkuVkk9iL353OlFqV207guxzH9IKAiWZfREhn1wC2
	m+XxRCjG/QrCg3e7mM723pUFXCjrFBkO3IIofJlPCnVpSsAH7+OaQQZO4WAjig+/
	+xtiNREwuCHi/ehDhiuXucE17deOVsunmHN47PgbmvSLefglZAIo9OFpDuq7X6pp
	6PSKmjLjyie7GTPCxsD0WjJD9F3e7LRjZDp7G2oI3sVUkO7revOA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42s6gjjex7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Nov 2024 20:41:48 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4A8J0w4Q026492;
	Fri, 8 Nov 2024 20:41:47 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2176.outbound.protection.outlook.com [104.47.58.176])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42nahbm20q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 08 Nov 2024 20:41:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tc0iJ4psTW2Wr6gi0/Imma0Y9zk+4MKS50Y5HC/B6cG0fZN7OX7eu67jq5RQUX9ZWRdyiaOIuHycxNmyEzC9+Pu0un7Sp+P4mCPHYV/jjXIup37wpOzeMRAqoKw+qNzgxRtt4KP6tsyv0esPx6nuzLTBlXGGN68YjXNkUAPGD7/ke5Lo5w4VeRoPYLOxxVgNC7GG9lKwOHT9hYVKsF+NhEUHNk1sEM1wU5nVM+ch+NIYZ/SuF9jxKiL2K5/SMvXxCqQT7B/L2lO0Sl3CLHhfNL6/Y1YvARme+tVq1xe8SMcSACwoORS+4XDBCw+lAJrZXKIC/ycyMFomudiv8MAFIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Weuii9cKKaqnTt2hjHbeXBXwmGiKAgxBDHMwuyEan3A=;
 b=nDXB+ss41xRkDvpZThK2emc9MZ/DRYlUNRqmdcAkexQ0+urcxHFdBMVt1GOkh8xV8/IUx1+S4ycjOBRjM3oUKupowmOpUmwYY+L9vh0WQZp9XUe6u2b3F3+tlUudf9FMSYtPt6PrqYLMvNsfoal+Yow8W5CvQCCz9xepwuLEawJTXqKSpQb1XFWju9jZtD89zzVJV6quqdiaENd/HaNxFNJf9kXes1OzYlgN77gpBpKwZJKoYiS4suQU/cRrm/bLMHJxCwiDaDg6leZwQCbBxJMb/ZnchrnueP09zDCVA6nUVYFk3VP/4jvuurbzSaOd8rMzFbAkdk9vwqAvbTG0MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Weuii9cKKaqnTt2hjHbeXBXwmGiKAgxBDHMwuyEan3A=;
 b=rhfrUdKCMhwo8C3z3c6Fif4U5tnVsJAZxm7nrPRGMQV4eeUdLw3eY0b/zCnGiph2BQO28op5ti8aZqYcoxPviE9JirwtlBPvD/hQGOJRJoEgZ7otwPSdUj+54Dkldbpifm/rDdXJPb47VnFqA43HJaSSJ0Z44P7pwM4AaBJ5Lqw=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BLAPR10MB5171.namprd10.prod.outlook.com (2603:10b6:208:325::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.20; Fri, 8 Nov
 2024 20:41:44 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.8137.019; Fri, 8 Nov 2024
 20:41:44 +0000
Date: Fri, 8 Nov 2024 15:41:41 -0500
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arve =?utf-8?B?SGrDuG5uZXbDpWc=?= <arve@android.com>,
        Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <brauner@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org,
        kernel-team@android.com, David Hildenbrand <david@redhat.com>,
        Barry Song <v-songbaohua@oppo.com>
Subject: Re: [PATCH v3 2/8] binder: concurrent page installation
Message-ID: <xpzec7tqe43sykvqtgrlh3furu7vn2nrnkjmv7odzy7ywd4lf6@hlawbgapxcfk>
References: <20241108191057.3288442-1-cmllamas@google.com>
 <20241108191057.3288442-3-cmllamas@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241108191057.3288442-3-cmllamas@google.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0358.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fc::19) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BLAPR10MB5171:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f8cc53e-e929-48ce-fe5b-08dd0035c1a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|27256017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?2NV8l/waq3ygkWtop5ZVycSenWxJSoULtXWrqx3z1XufvOr18wXg50A7Vtcf?=
 =?us-ascii?Q?b6EXLEQGdkis/zTK8/kWDkBB4brgpARZcovGGkGviqf12cW9tYWNPn2hkf5V?=
 =?us-ascii?Q?1q4PgEw/4vHw8gjOrNcWvDNKogUAFfz01qMrL65Ee/ylZF7zHLhSXRj2PQH6?=
 =?us-ascii?Q?wZzp4L9PBinEGzq59LNWH/HKBm80ik5jYNUmH3bGkx/y97AU7A9i1YXTfYCu?=
 =?us-ascii?Q?UK2FtvwvGgV5Lj8rW/FHZcOkUoc6tmfYSnJlUui4fRa9ozFTXD/cKSH/PaZ3?=
 =?us-ascii?Q?N3Xmadm11Thl+UoPeCeNyCv81QmiWa5LEvqyE8e/3kN2JM1dYbTC39s5tn5S?=
 =?us-ascii?Q?zUzbKcDmi8qoN6g6ZBVJXRFgOpCFsSkxQw/nDp/XTA2icaPacQF0Oib7AF/g?=
 =?us-ascii?Q?y7axom8/mcl5WS8F8/un+jQNtrTzYvke1WjEcGAAuhwKheAfPKXcAVZWHmbT?=
 =?us-ascii?Q?prNmQMHF+vDTy39WGZ/GBDxm7xfn5qjXb1wdyeT9hkQuSPukEHI92Z4esRqm?=
 =?us-ascii?Q?wR6KUjRIeRssNzUqInhXx5Bvk4s/24qQs7gcNz/OCT7D3yLdPpfFhoZP9jRf?=
 =?us-ascii?Q?YIzZE8eZGQhqZStR/hXESErP+RpXp3iTORhgo2Aoe/mkeksPdVecrUJSFO3F?=
 =?us-ascii?Q?oCYTfE7iuNAIFycbc8irjJstkag0lubifDrRMqjhtDDWrV7we0nZ3oSDlKJy?=
 =?us-ascii?Q?JxeDBY/4rt0/hmTV1riMGuFJ0mCT0+hC67NYwcEExO5Vqk99Wq/OoeOkiwV6?=
 =?us-ascii?Q?/O6jxT1V3e/K3afu3m7jLMbHKx8sEOxboJna7TcAnjKbhFreqf0AvRf5Fiko?=
 =?us-ascii?Q?nu6BcJImLenPssmQvVvs6WlL9d4LTIZ7Qa/aIkDO+IacjNiYsOxP4lpfSj49?=
 =?us-ascii?Q?QU0uXXs7KV9vnvYj9waiwVOqUQrVoKuadydgtsprvATPVc1F3mqB6ylhdBaL?=
 =?us-ascii?Q?Re2o340fw9g7C0hKKiCEOT19IHxvIj+TLeUI/gt1jj8L8j1FHwgEZyLQ/r7l?=
 =?us-ascii?Q?89IEnbLkEaczj62OIyX2mj4O66Z4s7GPlzVJfQY+d4SNpIphdf5jonoTA5P+?=
 =?us-ascii?Q?zj+VDqOI0NpgBJGMevPIgz+KySKUM1zZNJmgV7CHMPAPtfNH7c/arvi3C3YR?=
 =?us-ascii?Q?4fRCcqFnXge6lOTF74Ak44uL+CmO+wFM/X1u96srXCInCq5+JsaVEKuRe86O?=
 =?us-ascii?Q?aeC1OygolrTQJgVQ1IqGvN4e3tGTB7FycN2wgsFi0W1QBoNI96NCHJ/Pb6CP?=
 =?us-ascii?Q?EfZt5jxTSkqG8AQJdiXgd5FTJ6owkidR1ZxSem3xDBugj4+tyWY2cqG+ypKE?=
 =?us-ascii?Q?w3MS6aRoyS+07UC2dKsi7+kHtwRE5Vo+YmGWmn5a8SprQF89ywlQFkP1ncjx?=
 =?us-ascii?Q?OQK66nifP/Zou0UI7NftLRjklPW/?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(27256017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pXFcycjU0rAlJj6HHYvbyGdMCeRYUe4NmBk7MRNoWDglq3n3cKyZR2Al5CRz?=
 =?us-ascii?Q?wlbtlApCZGFYv6i/x4WrxLQxp9eOwq6ST+k6eduiB/y8mRtzkyo8MwjZAqhE?=
 =?us-ascii?Q?A/A/MNj72rtsQcEgn0M+wZlJ1WlduxmgNIqirXdVRbl7BPUT0au1yLQtIb6e?=
 =?us-ascii?Q?FfLNi7GDcdivp68z+hm+2P617YvYtUlYUFFTIXrAknvHuRJgTjGELbkWdZbl?=
 =?us-ascii?Q?fyPUsod0aXhJfDUrWRudN6hUr76X3o0C4cq9IS5qIjyitJoa+INeC2BK3CKW?=
 =?us-ascii?Q?Md9U+UmWzu/onYT67qiQ3C/JQLtWs/b95kMNVmtwt4CWX61D8MV+KPCnLKNN?=
 =?us-ascii?Q?f60eRBI3u9IXYlbkqFW0K7yIvtHQDJfzSBYODhid4MsXhQzDrst96niFsa1u?=
 =?us-ascii?Q?X75VAM298y/bN9Ngy4qh65c189jm9At0iXH/gUIpoFp2mTcIuxFMVpZm+lAH?=
 =?us-ascii?Q?MsYSm0K4XRiuX0Z5agjWyA4NpUDFpJf1wZPOjNtnl4lWBfZUMesYi3wxSnEj?=
 =?us-ascii?Q?UtchoYZgAlR4hNSDqvHFY2reQtSHUfH2Ql/zEHSa4JmgosnT5g4F1ZtU2RAm?=
 =?us-ascii?Q?QO0dsUxdHN79y6HPs2p/xQ+DOQr3eA/q0Oa5tT8h7UT8c5HPXjNnkppZXSEO?=
 =?us-ascii?Q?t3jXgS08PwOXCoFOy7Zj6UiWeVHJ9FPMNIM799j0Q8IVOGMHF1jPu1vp3K1r?=
 =?us-ascii?Q?gvxA+UGfzyi0PUpo7yWCH88oR4FIVTSBb96PjG36DwgkdtPgEpUyiEVI5zza?=
 =?us-ascii?Q?jmIGtN7+qTi5tIN6HRi/Xl4YALKtAZA/zf8z3v4kYH8WauMKw6ghTDkyqXIA?=
 =?us-ascii?Q?em+cxfdUuqUiuSBVfPipiOFAnGMGf4DX1gxMm2I3P5Nha6vNngDWldu/gMXd?=
 =?us-ascii?Q?XmWQawcuwIZfx76YktSwFokYge+i9e0iQoJVyDQi7IAvy3H+lfqcrGCL19kM?=
 =?us-ascii?Q?vhugxD2QvGxkMG7gZOnqjAm4fuocp8lxfaQyXpMQLaX3m39FI09XioH8Vv03?=
 =?us-ascii?Q?AmIS47YyBgMAG2/7yRn1UbmYIZvmqjmZvc33eKF1pldzx1jPU9HjnU8vDXFi?=
 =?us-ascii?Q?uXueDkw5kbux0MsUoeiii4Pu+ibc0vjs9hwrPlG5XNta5zrex8lCQVbrhvc2?=
 =?us-ascii?Q?UYZ99arZIuwQ+TEPm1kUeSNDVegCF38eUs2kqtiIADGeuGXrgghi/q3Ye+fl?=
 =?us-ascii?Q?6FnvFLU5Ruj/PNuuSQbAzw6RaQY2K591K7Ka/kG0r5s/jsKMny/AhiO6XkPt?=
 =?us-ascii?Q?tprHnHQLhQ9CWkB+VE6czbEuoikag1pLsjNC7lv4KgOcbCCz1Yjx3flU79np?=
 =?us-ascii?Q?B1pONJkrkpoWjeYD6f2v6GNGY9glKmxHdT14iNMH09jBqyYDw6yrwjOToFVs?=
 =?us-ascii?Q?i/FMt4Z3OGXZskrKY1MkurXJR7VCgYfdNy48xBw+yPvChMg/EGCGvJ4k9HEj?=
 =?us-ascii?Q?tVfaug0zOymQjCCqlXty422t7nJPc7sVW/DW5fS1zw7yfE/NhqjEfOJrCP7r?=
 =?us-ascii?Q?8E/3bdrCjRq5A2F/sCzVQmx2QO0LOFZN7zLS8Qa1d/8Dkj0n+utO9Y0vJA4/?=
 =?us-ascii?Q?nADgACbmPhFuRbKTIno4tFjFazakBZXX5QFaEAqx?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Htqk0md2Iu+LNuDl3vh7XvlyhiWpZs1l6bXAK0GoHrWnSIvFSU48NZ8lKMe8EIItQN2SWEBBFnz3gEZq7j3M7eBmTJVOLJhq1dJ8zrTybu6Vgt9Tafu3TzYQhXYDzPx0T3Xrpn3qW6HiQCPoDYP+nzpv9PfKL6y3xBXm1UVKJnVGikrOjFvjxKiH7HbTPhN/QGbtHMSug2ExCjnZu3kV8GcxujFO/c3msjVHedLKFnZzvh50nsAhs+QnjlRviDOjOg6P06zzzz5u0HQU75qZELzbIWNiMGbP7GSO4hOtBWbsd9EnKdkM3tAP91BxJuIe4tOi+Y1Z7uJcQo6IxsMYjybPNksNYmPhJfhjbs4XVJZwcwyRI8ZaRneHPqx2158upGtWtLUZ9fTCJnBSnqhVKTFNPh+QU2a/Dpd6peCy61mb0+Ondqa6tiWA+z09aLJiXPnDVl19OC4yrKdJ6lou0JJeiE9bAmr6xmJ77mFLPd/EE/0wfrWgqObo/oOzWIpxrM3yl1D5kPv2CV49TCuXab+QRRsuY4ggc571RT6cTVEMDyLLkniSD1HPrc8tB038iTOqi3jpB2CllshN7Ue6XFds7BKFfLwSmj2jcyBZbIo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f8cc53e-e929-48ce-fe5b-08dd0035c1a8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2024 20:41:44.1096
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eW9DpqeefglDJZZPvTtp/PPns9DAVuxV1EYWB+u6cEULgRZtbm6InVZa5CBJg1kkrzj9Eoin6ZkdxOaK8ZC5Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5171
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-08_17,2024-11-08_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 adultscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411080170
X-Proofpoint-GUID: _MEjhb_oBYZtGs5tmOFfCmvVSD9YgzTN
X-Proofpoint-ORIG-GUID: _MEjhb_oBYZtGs5tmOFfCmvVSD9YgzTN

* Carlos Llamas <cmllamas@google.com> [241108 14:11]:
> Allow multiple callers to install pages simultaneously by downgrading
> the mmap_sem to non-exclusive mode.

Since we actually allow downgrading of a lock, it would be more clear to
say that you are changing from a read lock to a write lock.  I was
searching for the lock downgrade in this patch :)

>Races to the same PTE are handled
> using get_user_pages_remote() to retrieve the already installed page.
> This method significantly reduces contention in the mmap semaphore.
> 
> To ensure safety, vma_lookup() is used (instead of alloc->vma) to avoid
> operating on an isolated VMA. In addition, zap_page_range_single() is
> called under the alloc->mutex to avoid racing with the shrinker.
> 
> Many thanks to Barry Song who posted a similar approach [1].
> 
> Link: https://lore.kernel.org/all/20240902225009.34576-1-21cnbao@gmail.com/ [1]
> Cc: David Hildenbrand <david@redhat.com>
> Cc: Barry Song <v-songbaohua@oppo.com>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Cc: Liam R. Howlett <Liam.Howlett@oracle.com>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Carlos Llamas <cmllamas@google.com>
> ---
>  drivers/android/binder_alloc.c | 64 +++++++++++++++++++++-------------
>  1 file changed, 40 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/android/binder_alloc.c b/drivers/android/binder_alloc.c
> index 7241bf4a3ff2..2ab520c285b3 100644
> --- a/drivers/android/binder_alloc.c
> +++ b/drivers/android/binder_alloc.c
> @@ -221,26 +221,14 @@ static int binder_install_single_page(struct binder_alloc *alloc,
>  				      struct binder_lru_page *lru_page,
>  				      unsigned long addr)
>  {
> +	struct vm_area_struct *vma;
>  	struct page *page;
> -	int ret = 0;
> +	long npages;
> +	int ret;
>  
>  	if (!mmget_not_zero(alloc->mm))
>  		return -ESRCH;
>  
> -	/*
> -	 * Protected with mmap_sem in write mode as multiple tasks
> -	 * might race to install the same page.
> -	 */
> -	mmap_write_lock(alloc->mm);
> -	if (binder_get_installed_page(lru_page))
> -		goto out;
> -
> -	if (!alloc->vma) {
> -		pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
> -		ret = -ESRCH;
> -		goto out;
> -	}
> -
>  	page = alloc_page(GFP_KERNEL | __GFP_HIGHMEM | __GFP_ZERO);
>  	if (!page) {
>  		pr_err("%d: failed to allocate page\n", alloc->pid);
> @@ -248,19 +236,47 @@ static int binder_install_single_page(struct binder_alloc *alloc,
>  		goto out;
>  	}
>  
> -	ret = vm_insert_page(alloc->vma, addr, page);
> -	if (ret) {
> +	mmap_read_lock(alloc->mm);

Ah, I debate bring this up, but you can do this without the mmap read
lock.  You can use rcu and the per-vma locking like in the page fault
path.  If you look at how that is done using the lock_vma_under_rcu()
(mm/memory.c) then you can see that pages are installed today without
the mmap locking (on some architectures - which includes x86_64 and
arm64).

userfaultfd had to do something like this as well, and created some
abstraction to facilitate either mmap or rcu, based on the arch support.
Going to rcu really helped performance there [1].  There was also a
chance of the vma being missed, so it is checked again under the mmap
read lock, but realistically that never happens and exists to ensure
correctness.

You also mention the shrinker and using the alloc->mutex, well zapping
pages can also be done under the vma specific lock - if that helps?

Freeing page tables is different though, that needs more locking, but I
don't think this is an issue for you.

[1]. https://lore.kernel.org/all/20240215182756.3448972-1-lokeshgidra@google.com/

> +	vma = vma_lookup(alloc->mm, addr);

Thank you for not saving a pointer anymore.

> +	if (!vma || vma != alloc->vma) {
> +		__free_page(page);
> +		pr_err("%d: %s failed, no vma\n", alloc->pid, __func__);
> +		ret = -ESRCH;
> +		goto unlock;
> +	}
> +
> +	ret = vm_insert_page(vma, addr, page);
> +	switch (ret) {
> +	case -EBUSY:
> +		/*
> +		 * EBUSY is ok. Someone installed the pte first but the
> +		 * lru_page->page_ptr has not been updated yet. Discard
> +		 * our page and look up the one already installed.
> +		 */
> +		ret = 0;
> +		__free_page(page);
> +		npages = get_user_pages_remote(alloc->mm, addr, 1, 0, &page, NULL);
> +		if (npages <= 0) {
> +			pr_err("%d: failed to find page at offset %lx\n",
> +			       alloc->pid, addr - alloc->buffer);
> +			ret = -ESRCH;
> +			break;
> +		}
> +		fallthrough;
> +	case 0:
> +		/* Mark page installation complete and safe to use */
> +		binder_set_installed_page(lru_page, page);
> +		break;
> +	default:
> +		__free_page(page);
>  		pr_err("%d: %s failed to insert page at offset %lx with %d\n",
>  		       alloc->pid, __func__, addr - alloc->buffer, ret);
> -		__free_page(page);
>  		ret = -ENOMEM;
> -		goto out;
> +		break;
>  	}
> -
> -	/* Mark page installation complete and safe to use */
> -	binder_set_installed_page(lru_page, page);
> +unlock:
> +	mmap_read_unlock(alloc->mm);
>  out:
> -	mmap_write_unlock(alloc->mm);
>  	mmput_async(alloc->mm);
>  	return ret;
>  }
> @@ -1091,7 +1107,6 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
>  	trace_binder_unmap_kernel_end(alloc, index);
>  
>  	list_lru_isolate(lru, item);
> -	mutex_unlock(&alloc->mutex);
>  	spin_unlock(lock);
>  
>  	if (vma) {
> @@ -1102,6 +1117,7 @@ enum lru_status binder_alloc_free_page(struct list_head *item,
>  		trace_binder_unmap_user_end(alloc, index);
>  	}
>  
> +	mutex_unlock(&alloc->mutex);
>  	mmap_read_unlock(mm);
>  	mmput_async(mm);
>  	__free_page(page_to_free);
> -- 
> 2.47.0.277.g8800431eea-goog
> 

