Return-Path: <linux-kernel+bounces-264573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8FE393E555
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 15:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F07EDB21B42
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jul 2024 13:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26BA4AEF4;
	Sun, 28 Jul 2024 13:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="OFuJtOPd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gFSviS6l"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20277364BA
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jul 2024 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722172089; cv=fail; b=KPx1/9xtyHfwPCphiMlx2kpwBg3dEW8BpNEEeD7SZUI+nJqtT4gdgeidpL1UXJGyWY88+hzIiTdKR2pbr9MdWZgCFAWOe57n+A8lm5xfuRlQQz2b1zhTEyIFUNn3wMNtbKMKFImq+oI95mfv53AzqrqewSI6pVeL53yr9vVnYe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722172089; c=relaxed/simple;
	bh=VDfsOgwZ0MR0dOYsYgNuDoPnXq9LtwhONpmop73Ncus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Y6Z2i7UQ/rlfwcg44mZD8UpmbP1FiswNZutRFnm+OUlYMhOyAHWAP9hYNSIvhZI9xomulo80RkE8DEV0DUKwYX4Ivvg+z6qXfbzE5GjLYwXJQ3pj3dEp5jsU0tb0+GgKLaHGO0iH9K3DznG0of1LmjMLINKBHlaZWiminyjt5D0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=OFuJtOPd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gFSviS6l; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46S3u38w020686;
	Sun, 28 Jul 2024 13:07:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=wYLmqZ6bmCdKkF3
	UkJTfZ7cLCSGqPtWpA1veisp9OmM=; b=OFuJtOPdzp7fhbbiwQVXnMP6d5BeG/k
	zo6o4MVmA62e0y89SJSRPt+ludRu4lgd/cFcyC1HqhC+sNU++F2EiTSzNSgVHRbw
	mKipdIbA/osRHx2qCHgeUX5B0LKf8XnCIlZVDmd8BBG7VBMzN+JsKHbWh9+9+LNq
	DAsmH+AhRGIh6NIlTnCSH5icIyzf6iSM5vxws7AdqDVyC5TSFRGxrhfwHkNB1NBt
	9KFCBtgIjAghObTDv0lBv81PXxeMpsN8gVm00mZlL6r27zLkOPQ0gU/EI39s02kE
	X/I8cQAUO/Nlc6U/BHYnxaW8u3puvYFEDARJKJlB9cSe8ef0IrZ7sdA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40mqtah5m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 28 Jul 2024 13:07:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46SCqBEm025589;
	Sun, 28 Jul 2024 13:07:45 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40npcdr7gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 28 Jul 2024 13:07:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryIQmhDruSTn0BdblxmnHQ3e3m/GDuAmicww0MFmNbz9N43o4dWforVcOcxQFBz5BYjW7r9dcHVa5PuytJL0q0CVII01iPWFkGBvKPhsKctxF0kUe7wUNoFzkuY/qNJHWSVkJKFkl+6Js5n6oZITRCn2rOaxlcZW+4iA9YjMiH6ijGCpW8+eJDR0Pjk1TzGN2+Q6gmBqgwFq5ppPYEoyNU49el8j9C9z37UlRkO+6l1Y0J1/alLYlGJe+tUXrPQEjanf99U/7NzerAIN0Agp5g5XYTSgqEixOv7Up1UIj5/e26SbsBXGv1aZoRztQeVFii+W7r6DdgLPfTxKV6mDfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYLmqZ6bmCdKkF3UkJTfZ7cLCSGqPtWpA1veisp9OmM=;
 b=XfvdljEBdLdUYzcDxZ9Xws+sPNk6/TGtCawmB97oFq5MwxEODyGpw8mIog2ksQaT8kkDIiZBH4SPXmw/xKRELR3OgkV9H/Obo90BurZlrmNAVFaMU4EbRoFZa6Av2tp5KV42/2FevzPU2y4vl9BKrRJbHzELfMtXyw0ti49Swo6hLnASU0HikPiah0wbVvrD4SS2rJPx8Ol0h1BRDXiijIx2DsXl6H+IjSLDJwQlOzSTQ5w9YAj8PQ2E3JEIxVzd7J0QsLATlh+Ujpf8YZJAAXyGnd56blup13N6Ek9cXV5BjzgrsVHcC5j26E/QGBbWLCyM8UqkoNDrYkfSjw3FPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYLmqZ6bmCdKkF3UkJTfZ7cLCSGqPtWpA1veisp9OmM=;
 b=gFSviS6lph0gCVjbrjwbIGpx0l/PACREJUak6qnQgWGhk4ycvLaq7cL6U4EGwi+23ut7Xp91pAxlHSeQyw5BYG2w3CIeQ0zvoaunlU4yW3c6HID46EdUlohzlCir+GsuPfHFw3zlpEratwBYdzJgXmeOBLff3Ou1h6/At3a3b68=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by MW4PR10MB5776.namprd10.prod.outlook.com (2603:10b6:303:180::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.24; Sun, 28 Jul
 2024 13:07:42 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7807.026; Sun, 28 Jul 2024
 13:07:42 +0000
Date: Sun, 28 Jul 2024 14:07:37 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Laight <David.Laight@aculab.com>
Cc: 'Linus Torvalds' <torvalds@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Arnd Bergmann <arnd@kernel.org>, "Jason@zx2c4.com" <Jason@zx2c4.com>,
        "pedro.falcato@gmail.com" <pedro.falcato@gmail.com>,
        Mateusz Guzik <mjguzik@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 0/7] minmax: reduce compilation time
Message-ID: <0dea6700-6677-42ee-b298-a8844022a53d@lucifer.local>
References: <CAHk-=wjCV+RmhWjh2Dsdki6FfqZDkM9JMQ=Qw9zGmGQD=ir6cw@mail.gmail.com>
 <b8722427-cf1e-459f-8bad-04f89fb5ffc6@lucifer.local>
 <CAHk-=whsMPLro6RDY7GrjvXpy+WYPOL-AW5jrzwZ8P4GPBHxag@mail.gmail.com>
 <137646a7-7017-490d-be78-5bd5627609c3@lucifer.local>
 <36aa2cad-1db1-4abf-8dd2-fb20484aabc3@lucifer.local>
 <CAHk-=wjPr3b-=dshE6n3fM2Q0U3guT4reOoCZiBye_UMJ-qg1A@mail.gmail.com>
 <CAHk-=wgVZwBrCXyphH+HcY9X56EK0KNQrnWZ+Qb0Bz79POLSUw@mail.gmail.com>
 <40369e153bd447e5b597c31e7bc9a2b1@AcuMS.aculab.com>
 <eea5d9a4-fcb4-4076-8222-fcff668a2bfa@lucifer.local>
 <7a5cf18b6141453988247cfa4d4dcd49@AcuMS.aculab.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a5cf18b6141453988247cfa4d4dcd49@AcuMS.aculab.com>
X-ClientProxiedBy: LO4P265CA0185.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::14) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|MW4PR10MB5776:EE_
X-MS-Office365-Filtering-Correlation-Id: 65df6935-6ad4-4763-1e65-08dcaf0643d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?MFUpK2DLg0gpw9hJkB0PtzPNFCd8HTR8kCPYCheevf7UX3Q+hnO9UTUGVweh?=
 =?us-ascii?Q?E5cKF734zxxJ0nyW9I00J1oJSSPzed1A32g54FcmAeWJGZdMiaPm/e0sGzcW?=
 =?us-ascii?Q?ZTL2oPhqQo+8aXCt8SglvLPr8Ye3/cyyjG6RusmIrKptJ94vtLLDIaWlB4+a?=
 =?us-ascii?Q?RzNL/LH8KO3DvQ6NY1o/013aprL2sco2kQQ2QN8a2lxjl+sj/asY2AO/H2q2?=
 =?us-ascii?Q?PTvybuzHtn/ctlKNR2UXpkNafnMUGLrTGexqogZuHkWQSBx+1PY+lwjLk8+b?=
 =?us-ascii?Q?/cJXvpQXuBQPyrKSN5J7jSs4xmqtWS0RqIKVUGTr6OW8d5U44UVbdwi53K5F?=
 =?us-ascii?Q?DTXjhWJoVMsXOCzYmeCrTE+XpB+HC+KlzDLrNWmqvsBdt2Bl59UbCn8Ju8LB?=
 =?us-ascii?Q?Wk3OW3FQrR6P0CKKiFjoxEgM2vrGKUtkHBEzzUkX0JU0N7YicWJoBcNey+OK?=
 =?us-ascii?Q?KJQ6kdFOFQ9aegwL+dfkyyJitxnw1dq0zd3YeTX0JdMmrILDBPvNXTHozRh6?=
 =?us-ascii?Q?Grmb9xaDe3GrmVUV/nwRdiQFlr0oKc7MqPfAWmeSKrj8ePq3gVnB3yxjAJgf?=
 =?us-ascii?Q?ONgHeHGry3ZU4zWU8NLeshVWjqOoO21Bm6L/dSbEuADVMHGy2NyXUudDyIVV?=
 =?us-ascii?Q?i+/jD26YZcG/govVhKU532ZfI+ytu+Cz7A9IkCtzgO1TDEFWwrOBkvYVgczF?=
 =?us-ascii?Q?AY05R1I+GyVu92UHdC2ChXROoD1wlolcnjEMqmSA4aBZvo9KZOOpjWSka/yH?=
 =?us-ascii?Q?XShC8102N8440pkhdD4jP1TfjBK0IBnqnNjTrTW3oXs52AQQyCY6+sYqAGAB?=
 =?us-ascii?Q?41VppOaRqpR4LJP//aEfJKxpfbrw1DD1LevWbM7/+Oysnh4o7JaWSZHodLW8?=
 =?us-ascii?Q?/yjVhr783tBYo4BcPXv7yrGpeDcbYyIwGXrxTlrUpq/iD1yFZkXCF+erzDDI?=
 =?us-ascii?Q?2LNN3XI72iDFhJdQ5u38oIHJDZ8X89MUOPN2Q3+5XFKgS4LeDPtf64n7BCpF?=
 =?us-ascii?Q?MFnUMpDd/YcXMd0FDlcteV36kK/sfMjVC7tmbfnac6227i5VxOrycmk/vgqZ?=
 =?us-ascii?Q?PP9B2QpR7VJIab1JgTYkmCelxXKiqsVoxpQ7lpKjvCasAgdruWMtfqwVnoAP?=
 =?us-ascii?Q?YNpUWPejmulkQZRgbMAgGBfvfS1CPGS7ljo5h4MA1M57dfSbPuWVtuuoI9Xs?=
 =?us-ascii?Q?KGDSyFWVvYPWg+gueyAiC7AG5TCIJnIN+q0WEpKGZdvtO2GE5trNBQS6/B24?=
 =?us-ascii?Q?TrnZJm/4ICKsH75TriTSXnGFjBzajSeX6GnE4fAQrvvBSP+eVIjNzGPwCyty?=
 =?us-ascii?Q?beg8YKDkZV8ANxsv6K6zI9c3XHIuu0FmkVu1ueP0krnNGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?yQQ5EkejwCIF2fzdntSlZdatSwEx9/5PFUsHgq3hg21HDUE5ksML4N0+pZOp?=
 =?us-ascii?Q?RMVsk8LReXMFMPRzB3ZjncgqJVnMQjUt9nTAwBG9/gyjA2jG62+iCok3Eoxj?=
 =?us-ascii?Q?TBYbLc0PATRfeZfJl2NZcAFc0X7gr7gutKEpRlsDb8Gq2ZZEUOMWNVV6JGew?=
 =?us-ascii?Q?OjDxdfBzG/Og5TqB2pgyBbgMfi9A5rzW1tj4IodbnaXscUjac3T8bFHrtMX5?=
 =?us-ascii?Q?ZtY9xo8w+WtIfDBfwdmWpcBP8tVo/yXOpo71qLlZsVYcf9Zr/vnWC+T+uhWh?=
 =?us-ascii?Q?HI+hOk+auQWUsZFRt/qFrzEN1p0jmwvvXRrepzDG2Syj7PW41filr0kAdJZe?=
 =?us-ascii?Q?+cnt5JIKTIwgYbBp1Bmzk7hSz0Zhr3awQeLj0Ku7UGcEi+iXUt1E/8gK5g2p?=
 =?us-ascii?Q?zzWJ463a9vrJIHXIoEqhvBDJVw/Ps7yd00VWoufCE8y3F7hr0YwllayFhATM?=
 =?us-ascii?Q?dBXBFDulWXUlJ+oGfQBL4E3fp+yxFhZ73uGf1Duxdq6ccZdVKfUBs7vHXU32?=
 =?us-ascii?Q?QVy32QT7RbXj6NTZuThuvxpMDIO+SX3//ASUPZDjii3JXCHC040lHeL6TM+y?=
 =?us-ascii?Q?Dn3l+taK9Ui61NYKA9rJVWuhv0+YyWB0G8vpIz0iUslcFHCFCeHUYdO5rxua?=
 =?us-ascii?Q?amXUYI2j/kM9As2RcthDrNjMet5DawLGpI3nYRW+LYwsp2UcsErFJw19Bs0z?=
 =?us-ascii?Q?vgZjF3Z9LvLcffkszrnYiTH77pN8zpKncfZ0YrpA86DASIpTnJBigH5pNPSN?=
 =?us-ascii?Q?LvoHnfGBkNeL4btwRcAM7fTfeLsyFdIqwZ3iW2TofB6VC0pEdr8Va50URrlQ?=
 =?us-ascii?Q?LLmLs1WvtwNBTEPH+OFt3TQ2TYUW1dvXNgsPEtxtzqLaAG3zm0Lk4GxT5czE?=
 =?us-ascii?Q?AIk5Qe8+3K5VJKDTIjCT+1S4PUogz6NYNUbMc/SKk7yMObSAtdF8ZO+Gi/a3?=
 =?us-ascii?Q?5fmwtxK0xCvmil4DmxH8trd8giwE2iPOtRY5UjAWVJQUxI1+ljRL7S3Eu6bD?=
 =?us-ascii?Q?DKu/TdNDTmCnATeAs70xIFs4ZBVXU81/a/T/sgVCbkrzOe3qBq+shZgY9S+T?=
 =?us-ascii?Q?2cJiNZgfQ+VEFV+tBKP4E6V8vDdf5i93jxFEU6tLV1kjsYq71x+EDTn/hq+U?=
 =?us-ascii?Q?xZGDjj80sTXHRPp8LkkX1OVG2xcaIBZkRaHyg+GaB7hyPl7e+A5W3Ya3ato6?=
 =?us-ascii?Q?JdSWBYPa5jp/nMLTr47ef7qQRUlvuqp7KQWQuyfnP07eNmgtG8mOqbHAdOlN?=
 =?us-ascii?Q?nhqnhn5zD8hoTuj5IL0XzrBr7E8c3sIPouCIWUVWQMBBNCYvl0g5uhz112Kp?=
 =?us-ascii?Q?VDN0XvRR6tXNrWMGdZfdc27kYIexjZsaGZQOYemuvP9HKZ+siOQ05TY5+ZOH?=
 =?us-ascii?Q?kntb8hLTxWwlgQaqH2/wK1lx5uQPL44im7HeM6Vrj9k8FjpTdyKedR0AoSMs?=
 =?us-ascii?Q?w6gqRgV+XxrA57JLWGi/p+A8NobFnvSfyzG3+Y/3Hoc8pcAK3B/vzGuOkSjA?=
 =?us-ascii?Q?yzcn2HC3iAOOdS7Lny8NO6vDpLx5Us6fKDHLziPNUjkLNxN2Vfb8uXHOOsgf?=
 =?us-ascii?Q?C6r0JwfzwLGUuTD01ZGaHBN/432EzHECfSZS1JpIsCkpZpNjFfvLfzWjnfjs?=
 =?us-ascii?Q?HF3c3MzWHqraiMV33/0fBxHKhbaYO4zfxLtuhZJZ4aCK3g66ZB3LBkMDP4Qe?=
 =?us-ascii?Q?R2oNbw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	J7cVibsOadZ18DQr1Fd7RSR17jeMupJR0dq0oOyOKsLke1vJUucIakPI8/khBbRNeo8CdES+xpeMfKjDUAw8qWfeWxnDJoVHipLPJaUM1tPtPd1cWAwL+QBTSmlR03nh+MyEuoo+vls+IexSQyfE3COzx6rcVJcRmlOkVZ8in93KLKBvwN19js5VP/Y2s+qPhZ/XRfp9yq9h1H8WswN8QqLnsxOnCdvfsvFDythV2wONlGO41J8orW/544c2ZOGB+196oTcblUF/7VpLEq0rJBTg7Q2Anny5Ek1/qvPKDtk1GkS9WV733Qm77iC7xQWvzYwCnTu2lWTN+FElMB33UWDFQ1HnhIeIDYiksRGAfRpr1ULi7d30B5oPknl9GAlMlVvYT1R0kloUOEZLJfR1XtxtitJZUlhh2uf21QFUUDo0ZtZLPfsV3Q9eVJYmUkjgG0XAlon5A7maAf4hHeY8wkTgvt7eXtTmP4M8Q1X2ICGUQCNyHkyF9ySX+wsOUHyWiV6lzJcQ4JfGivlDxVqcXYXGwC5+0IskhVaHR26Przijnpg9zlCfkKUJ/G+6d7GGAImRZiySRq7B0TpHeER0Vs3vO0SV1bC6A7yKWflWDw0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65df6935-6ad4-4763-1e65-08dcaf0643d0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2024 13:07:42.3125
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7ZwT/XiTla9lsg8/9WFyxiwix7WomMoj4GNsRCxvg+8DMYjSPLntMTwrzQfLsQ8KN152qgvxuyJrTqQH5hSg71LjsKCK6Z44B5IxtFPEARk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5776
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-28_09,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=928
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2407280096
X-Proofpoint-GUID: lst1bgL6bVP6s1O3GXmi-v9YZdt_3hkG
X-Proofpoint-ORIG-GUID: lst1bgL6bVP6s1O3GXmi-v9YZdt_3hkG

On Sun, Jul 28, 2024 at 11:17:19AM GMT, David Laight wrote:
> From: Lorenzo Stoakes
> > Sent: 27 July 2024 19:59
> >
> > On Sat, Jul 27, 2024 at 08:08:39AM GMT, David Laight wrote:
> > > ...
> > > > and it will spit out
> > > >
> > > >   Longest line is drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c:1136 (2346kB)
> > > >      '   ((((((pkt_size) + __builtin_choose_expr((sizeof(int) ==
> > > > sizeof(*(8 ? ((void *)((long)((__builtin_...'
> > > >
> > > > to tell me that we have that insane 2.2 *megabyte* line due to the
> > > > MVPP2_SKB_HEADROOM thing, and I should apply this patch:
> > > >
> > > > -#define MVPP2_SKB_HEADROOM     min(max(XDP_PACKET_HEADROOM, NET_SKB_PAD), 224)
> > > > +#define MVPP2_SKB_HEADROOM
> > > > MIN_T(int,MAX_T(int,XDP_PACKET_HEADROOM, NET_SKB_PAD), 224)
> > > >
> > > > to fix it.
> >
> > Yeah sorry just saw you had already addresed this Linus... I just went with a
> > clamp()_t in my patch.
> >
> > >
> > > Or (if I've got is right):
> > > #define MVPP2_SKB_HEADROOM clamp(XDP_PACKET_HEADROOM, NET_SKB_PAD, 224)
> > >
> >
> > I'm pretty sure you can clamp_t(int, ...) here safely based on usage.
>
> Why doesn't a plain clamp() work?

It was on the assumption that it'd cause less of a combinatorial explosion
due to the various clever checks your macros have in them.

However I stand corrected after checking - it's actually a little smaller
if we use clamp(), so I am fine with us just using clamp() here.

> The xxx_t() variants really shouldn't be used very often.

I disagree, but for the sakes of civility (+ sanity + thread length) I'm
not going to go on about it :)

I might (politely!) suggest, however, that under the circumstances it might
be best to refrain from suggesting what should/shouldn't be used when it
comes to these macros.

>
> 	David
>
> -
> Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
> Registration No: 1397386 (Wales)
>

