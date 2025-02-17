Return-Path: <linux-kernel+bounces-518323-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BFEE5A38D3C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 21:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9185F188F8DB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 20:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E41B238D2D;
	Mon, 17 Feb 2025 20:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="Mqz+MmaO"
Received: from YT5PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11021077.outbound.protection.outlook.com [40.107.192.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6332F149C41
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 20:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.192.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739823798; cv=fail; b=s20ArJFkn/JFV7szPVPFn9Ax/JpgLsYeXCwaRHqAGuzBCdavbIxdw37Ds+ICy5o1z4vsiQ2Cy3c/WomR6ORhzHrM3g17wDnH+9Etlmf9KedLbzx+9RIkZOZbMCf+HrH4VBtDA6/OzaW7BtgZD0wARvtNaPUPvGrmxxrZHA9NEBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739823798; c=relaxed/simple;
	bh=pM/stm34c/vH52natcFlub4kf/A0QJ25L8VNs/jNp0E=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ljhjlGlHq9wVxck1rhrsm/kKs4gHyxp1U7eAnL5IHsfowKF9VAXjyMQ5hVvUpy8hvUsihyLWNF74FI0/NDzm+rltAcU3haNMihy2ze2E3wKKsIqmJ489APEB7Q++8d7VVTsCXlseDdoL1En+eYf03ZYIMhCoPpYm8Ydx28F2SUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=Mqz+MmaO; arc=fail smtp.client-ip=40.107.192.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PbVOd7GXbO8JZcbxLUhdwEg7XC8rZCBEQbKtq5ID1eE7jZ6HXYQ80T2IMd3P1lqzGXqWqUdu+FcimSJ8p8xjdX/08Ml/9kGFhM1AMjed/WPWGwuZHyu/Wi03uRCrmbHhZAvqZxQnoS0ovky7IcsNxgGaMszpbYePiklgBVBGQsPOJpuEIvteg7Fk/0qaKYnH14FsSpAJGRKgZF34uanz3sH5U/GVfS0+icQTPDxBFbwwSDizGDMzevD68n6deElHAxOSFyJacVyeJqH8MRTbjhVvufacwOO2trVqvKPAYxz+mbcAvVMYCpv25wcsDaDwIwDi3QrBlTozOyknxvt/7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v05A5DBG0gR6LRCFrKnO6Hi+ry3/tV/PgVZRox4Plnw=;
 b=gz9HZFrjuO4AXb2e7qELqAzIlPCYJEZdAK/FSY2t072/BGnzcjq0VZOF4jJhfiMigv8Woq8KkpOOKQ023IJeDbEnoMJzML/TqFiEoHE6D/SVQ+0mV0Euu7kwrRQl8mwQaR0+d8i3zAlFu2XL6qK3Rp98yOx71nu557GH8B/L00AgfUCnuDPFhbes/rWiXcnXfqZKQ8PZ6hKgLqsWgJpu0g9XIad6W90rFyO0Dnb4KU4TpIjm9w8LdZkYO9KN4claA9bNXXgE5bXHde+aDABNpnMw9x5K9w5ovsrCgx7pDRl6pRJR5AAmPeiext3mNw6U3aTIbMTifa2GZsoy22pMfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v05A5DBG0gR6LRCFrKnO6Hi+ry3/tV/PgVZRox4Plnw=;
 b=Mqz+MmaONP2NqFPy+wo1m1W7As9GiDxrYlqoIwiN3c0oqMOWhPh0x77n63QUvjonf2hMENqGYMNqZ+Oyw2rKj2JL2s93qDeqUCylPBYfBDgRKQLdPQ0KTuu5MX3kzP86MNxyJbjr8y326hIq8nyvGCYxW/RCVrRVh4JIekYrodPOokscSbYVvtWW0YZvtq5N3jGQhTihoGxV21/K56CoCCBEil3u5GcyeyvFfNCor/RyFmUeswy2WcUcgicX9yQKP9NptCrka1QGqDW2sHx6JTrYZg4MXXf2dA/fGFKM7tv9+fl7yXDYIDYdIT3QCZbm6q2RSRpaR+a5MRSdjuCuew==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:be::5)
 by YT2PR01MB11254.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:b01:147::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 20:23:14 +0000
Received: from YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4]) by YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::50f1:2e3f:a5dd:5b4%4]) with mapi id 15.20.8445.017; Mon, 17 Feb 2025
 20:23:14 +0000
Message-ID: <a9862b5b-61e5-4455-9b6f-d05050f11b64@efficios.com>
Date: Mon, 17 Feb 2025 15:23:13 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] selftests/rseq: Add test for rseq+pkeys
To: Dmitry Vyukov <dvyukov@google.com>, peterz@infradead.org,
 boqun.feng@gmail.com, tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, hpa@zytor.com, aruna.ramakrishna@oracle.com,
 elver@google.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
References: <cover.1739790300.git.dvyukov@google.com>
 <1f0cd73072eb321fb5f6993cbcb9b2e67ba6355d.1739790300.git.dvyukov@google.com>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Content-Language: en-US
In-Reply-To: <1f0cd73072eb321fb5f6993cbcb9b2e67ba6355d.1739790300.git.dvyukov@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBPR0101CA0239.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:66::22) To YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:be::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YT2PR01MB9175:EE_|YT2PR01MB11254:EE_
X-MS-Office365-Filtering-Correlation-Id: cebc7ef4-74a9-4683-a044-08dd4f90e81a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K0VDTjh0TU9yTWxEUS9MVWhxUnI2YmRjVnNESmhPMnlBT2FGbE85WkJIYzBW?=
 =?utf-8?B?QkZPR21PZk5uUjE2cDZGTWlXMW96TGlYRGJJbUNGVTE1NHV4QWo1YkdhQWp4?=
 =?utf-8?B?V3JDSkJ2Qkw0bnlsWXRkaExqZmhLMXpYd1ZLYWMzc3ZTMW5DYUpvTWFURDU0?=
 =?utf-8?B?UDQ5ajV2YVE2aXN5WG82NU5hcVl5NVlHd0RBMnVuV0hyaGFlc2ErZjBRbkRa?=
 =?utf-8?B?VkI0OC9BNzRzN1d3Mlc0alZ5cjdULzNhVlJFb1RVRG5TY3dPN2lFR01tVSth?=
 =?utf-8?B?ajZaZis2cC8vU1lLc0FTMnUvM1liMmVCU1pGWi9EbTdSUVZEd1BFMnUzMlF5?=
 =?utf-8?B?a254UTFaMHFyMFY4N0JsbGVmU1pFMnFzbnpaNGRLa2plUnMyRG5MdlVNZmdm?=
 =?utf-8?B?VUVmYXplZ2hXRFdDR1dMRE5MbGt2bllNMlBGazNZWGlVN3MvREp5ZXJpU2hp?=
 =?utf-8?B?MWpDd05HbVRxc2J0U3VQdzNHMURnSFdzV0N4WmE5QjR0dVhMNFBzWSthN29l?=
 =?utf-8?B?NjBEUEtFS3dtTGhwcEZ2cVA5akRwVjV6UkVvQ2Y4NkhpWVNVa09mTzh3Y25B?=
 =?utf-8?B?QnI5N3ZnYlBkaE0xZkFtT1hxT2lkdU1ZZ25aaVJtclI0Q0dMVmFGaFZsWkRp?=
 =?utf-8?B?Nm5hSUhYcG5Md1hacGYvcXBXc043MmRxakZFeXNRTDVkaWNUenZnc2dmQ1Bu?=
 =?utf-8?B?ZUNBdC94WGhRZ09tRVV1QkJ5bWtXUzRrc09ESEtDelJlL0U4bXpFUHd2Ym1Z?=
 =?utf-8?B?bmp1YkRDVFVGZVhZK2xRLzNaNkdRb0tMdi9VS3VXRnNPQU1yRDRxN3NUcjMz?=
 =?utf-8?B?dG8rdVNhYXNUNTVsaytYTGg0VzhMbk9ZaDZ1dFM2TGI4djgvYXZWaVpLL0RE?=
 =?utf-8?B?bmVHRWI2YndIY1YxMlJoL2gxeXhCUnMzejlPOEExZkl3Q09qM2s5OHZXK1VV?=
 =?utf-8?B?NzNqaVlSQklKeVRGRmEwUGxneEJKYVNFTUU1eHkxcmhDQlNFWDd1NzJ0OTJV?=
 =?utf-8?B?UnRnNElmbnFBbXlnekpnMlRFbUs5VGJYamNNNkpEUnkxMUJhNG1uMXAveDk4?=
 =?utf-8?B?dGxsTG5hczJ1Q0ptODhkeG56OVlMamQ0MEhqOG1kVElnaDRFVWpTYkJYclcz?=
 =?utf-8?B?anArMURqQXg2SzIvWXF2emh5TWpxZU5vazdXRkJwSUswSFU3N2ZqWlRvbWVt?=
 =?utf-8?B?VHhLVFJHazUyZExQTkY5U1BpcWl2TDlsaXRsYXhoTG9kWkZ0NjZ3V2UrMElJ?=
 =?utf-8?B?V3JHdUszdnN1YWJHOWFVUDdIVU5aVUV4ZlRBam9xUDhrMDFTZTA4aUR5MVNz?=
 =?utf-8?B?ZVd2VGZtTWs5L3ZIMUFENjMxbjlBdjM3UXlsclUxbTJ0SDZJRkJVNTVYdHBY?=
 =?utf-8?B?K0szUW0rZEZtSnpZcnZ2czFFcWhIMXNzemh0djRJWE91OElkOEZKK3hEZ1pZ?=
 =?utf-8?B?a2U3dk40QU9XM1hMMG9qRGVSYXVFcHJOQThSTHJxdUxRRnVFeWtjNWxxcjhs?=
 =?utf-8?B?Zkg0NEhCMFZJZUJmTnFMYWwxUjVxUmhMSnpJbUNKeThOY0tqdUpZY1QyU25a?=
 =?utf-8?B?d3JjZjhqOGw3RlZ4aDhSQjhBVzZMY01NTDhSSzNPZ1RSUEJJVy85QnNBdThN?=
 =?utf-8?B?WWUxZ3JNbFFqbVRJWURqd0FUa0JxeEU2NUUwUFpJbjdYOEZpbUY3Ty9PSDNG?=
 =?utf-8?B?U0RNUS9OOVdJZzZpOVpzWGluMWh5SFIzdDdoMEhCVGZwWlZKWkdsQkt2d3Z5?=
 =?utf-8?B?MThXdnZHYjVmb0FlbzJLTFc2L2pJWVpkU0syRlBiV2N5a1R0emMxZDVXNTZZ?=
 =?utf-8?B?Uld1Z2ZrZXk0QUU5Yi80TkNHd2xzcG5QVm4wZTZkWmxHNSthWEp5NkxhWGxx?=
 =?utf-8?Q?BoIuy7qRJPECE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a1pPZXAwWEdhaDFpUFlFYTJ4NmFVTkl1NG9lQ240ekRSbkgrUUxScWp1ZmF6?=
 =?utf-8?B?OFdUWmNZMUpGQmgwcHUxTEM1Y3NhUU5GZ2d4ZnNDMUxQeW5WeWVnczZZQ3Fk?=
 =?utf-8?B?cEhXSVRudFhGdktjYlhRaC81SVNhQlJ2bnFvWnl0eng1cTYvMEs4bHhMV1VR?=
 =?utf-8?B?RVZybWJvdk10S0lwUHFHRE9NVy8zOURCK2NydVVPSGxSQ0FtdmxNRWV6NVdv?=
 =?utf-8?B?ZXliSWdWdjBYbzFzMXVxc0ZocnhRTG5ZT3dnbFh6Nmo4RU9remhXeDc4UGpa?=
 =?utf-8?B?L0JnWlhGZkJldjExUHFJN0k5TUFVOEg4MFRSQWpEekdubEtzc3V4ZW1SVE5B?=
 =?utf-8?B?SXBHT2tJZWU4UUcwTmFzczF4WGFnRlpnWjlpMFltSXJWNmtEL0kvQlJxR0VZ?=
 =?utf-8?B?cDNLU1Q0ZTZkVGhEemh2TUpqRHJoQWNRbXU3a29wRkg3bDVzNjB6MktwbFk0?=
 =?utf-8?B?aEl0MUJmTFNCOHV6bndWTUFVU1kvVXBYb1lPUUgxckl3Y0dvRStWOERwaW5E?=
 =?utf-8?B?a0hCQ0dNZEY3ZURRUUorU3N5RHRpZ1RSNVF2blFDTy9taEVzV1JhUFUvUExS?=
 =?utf-8?B?cDRvMTVkWEdQdmFwZVA1QkViYytjKzQ4dGF1cWl0b2ZaZnVkZldmT1hPYWR4?=
 =?utf-8?B?YWdVbm5UbDF0N3RDUnBkSmg4YXh0dlJSTVB3a29FbUtlY1RTWkdFNzFnSEV0?=
 =?utf-8?B?TVE1clFUbldyMEN4YXRNY3k3VkovNnJLdVhGL0FLeWxIcG5JVThNYjl0ck9j?=
 =?utf-8?B?eHlDcXF2NUU2TFZwU1E5c1M2QmNhQnpzbS9zanhOZE5nTmIyV1dvQURvNWF6?=
 =?utf-8?B?ZHBJRmt0Tyt6REpFL1RDZVRXVkY2eTloSnUzdms0RCtKSmdxMkRFNGVQT2lk?=
 =?utf-8?B?QVhHVTZ0WUVXN0NWNitQTGdpMW9IVzBwallxOXdNNHV6dnRvSzY5T29UV3Jy?=
 =?utf-8?B?WHR1ejNwK1VHQSsrTXVuVVZscTR3S29xdXRKb21aRDN5N055ZEMydktMSVd2?=
 =?utf-8?B?Q2hmZ3ZIb0h6US9zWG9rWXhZek84ZE1DOXRMdnFrdlErRjRVSktTbEFQUXVv?=
 =?utf-8?B?WlRqdHpDSXNpUHF3YXdSdUlhVWFlRTVFWEViRU5sbXhsVVl3RXRWZWRXZCti?=
 =?utf-8?B?WlpWekJQaE5YTjhkNXJJZnFRTjFVQU5SYmFTRDExeFRLL2k2WTF5Nmc5cmdp?=
 =?utf-8?B?WVE1bS9OL21sdFdkV3pMbUlJekI4Nit0UGUrdmw4K3lUSkl2NDVMa0V1aG91?=
 =?utf-8?B?Q2c3Y1V4RXU1VkJqWFJ5YkJPN1JsS1V2c0QvWjNxdEx4UWhUUWR6dXlOMmV0?=
 =?utf-8?B?dDNZdUpkUWFPVGZ1K2EzMGo5bXpKaCtyZmJDMWxKU2s4YnhmMTExYjlxRE1U?=
 =?utf-8?B?aVRUdTVGRHgwNy9qcmc2MXBnYXBTZ2ZSODhIYjJyTTdDcGdDdXJ2SDliVmJr?=
 =?utf-8?B?RVNEb2xUejhaaytObVVyeHJIcG0xbGpIaEhCUVBXREpnT2hhT0w3ZUhBWjMx?=
 =?utf-8?B?NzRzcEtMNEg2Zi9uTENFUzVqZnRZVUVOQXhiRFJ3VFRXa0pCSW9uNzlVTzFE?=
 =?utf-8?B?U0U5SUl5ckdqdDB1R2Z1Ymo5RU9meExhcDl6WjVKbDR6aysreEdzZFlOaXFy?=
 =?utf-8?B?RFhkckV1SURRR0p1RElydkQvTWYzQmpZdHdUN1o0Y0xmV3J5YkE0Skl1U2wy?=
 =?utf-8?B?Ry9acUFEenVvY1FEWHBJSkljRjNLcTZaWGJjbUZHYWFta2M1UW9UQzBZNmNs?=
 =?utf-8?B?SHdYRE92cjV2dTJiaHJHRGJFTndjNTF6YWFWNlBjOWUxOWhsRVJRYmhOa0lO?=
 =?utf-8?B?SFNReGZtTW9qYkZkSWk5MWlkeEVXOU51WGJsbDhrK2Fac0hLWXZMQTZ2MXVC?=
 =?utf-8?B?eFVlOTR0UllPWU95OWlkWjdoWHkwK0xEc2grclg5eXVEME9mZ29kaEQ3Sk1V?=
 =?utf-8?B?WWEwMmhxNWpNaGZiRjQva2hPa3BSVlR5d052bDEzTzBDN0t5emVITS90c2Fw?=
 =?utf-8?B?bUtwLzVqTUR3Ym1hYjhUL0pHOFZHNTYvYnloUUJKTW81ODhZRlBKZjhsTHdR?=
 =?utf-8?B?OU5OeXA2V29rWjBHRjBkVFVLMkl6WVJVU1JIQldhckc4RHd6aW9FZGlRVEU1?=
 =?utf-8?B?aWFhNkw4TFI3dkNscUttWTUxWkxqQTBiaUtYNUdwcFdZMFdiQUJPaHcyWHlp?=
 =?utf-8?Q?45/aeymbXGgDbIKdq6aKb4g=3D?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cebc7ef4-74a9-4683-a044-08dd4f90e81a
X-MS-Exchange-CrossTenant-AuthSource: YT2PR01MB9175.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 20:23:14.5625
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BXXDqTs7X1sO04WC/4IrHH6q/rAzXnhG75aDp5QYCbajMEcy5go+kbhe8K/ZgsdDxp51G1F9KMiIld1VTusolOaHCocXHFBEtRUjTms7LCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YT2PR01MB11254

On 2025-02-17 06:07, Dmitry Vyukov wrote:
> Add a test that ensures that PKEY-protected struct rseq works
> and does not lead to process kills.

Rather than depend on the glibc rseq tunable to disable glibc
rseq support, you could simply setup a rseq_cs in a separate
page and get the kernel to hit _that_ page through the
rseq_cs pointer.

Thanks,

Mathieu

> 
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Boqun Feng <boqun.feng@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
> Cc: x86@kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>   tools/testing/selftests/rseq/Makefile    |  2 +-
>   tools/testing/selftests/rseq/pkey_test.c | 61 ++++++++++++++++++++++++
>   2 files changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/rseq/Makefile b/tools/testing/selftests/rseq/Makefile
> index 5a3432fceb586..9111d25fea3af 100644
> --- a/tools/testing/selftests/rseq/Makefile
> +++ b/tools/testing/selftests/rseq/Makefile
> @@ -16,7 +16,7 @@ OVERRIDE_TARGETS = 1
>   
>   TEST_GEN_PROGS = basic_test basic_percpu_ops_test basic_percpu_ops_mm_cid_test param_test \
>   		param_test_benchmark param_test_compare_twice param_test_mm_cid \
> -		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice
> +		param_test_mm_cid_benchmark param_test_mm_cid_compare_twice pkey_test
>   
>   TEST_GEN_PROGS_EXTENDED = librseq.so
>   
> diff --git a/tools/testing/selftests/rseq/pkey_test.c b/tools/testing/selftests/rseq/pkey_test.c
> new file mode 100644
> index 0000000000000..ba5c1f6e99ab5
> --- /dev/null
> +++ b/tools/testing/selftests/rseq/pkey_test.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: LGPL-2.1
> +/*
> + * Ensure that rseq works when rseq data is protected with PKEYs.
> + */
> +
> +#define _GNU_SOURCE
> +#include <err.h>
> +#include <errno.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <sys/mman.h>
> +#include <sys/syscall.h>
> +#include <unistd.h>
> +
> +int main(int argc, char **argv)
> +{
> +	void *rseq;
> +	unsigned long page_size;
> +	int pkey, i;
> +
> +	pkey = pkey_alloc(0, 0);
> +	if (pkey == -1) {
> +		printf("[SKIP]\tKernel does not support PKEYs: %s\n",
> +			strerror(errno));
> +		return 0;
> +	}
> +
> +	/*
> +	 * Prevent glibc from registering own struct rseq.
> +	 * We need to know the rseq address to protect it, but also we need
> +	 * it to be placed on own page that does not contain other data
> +	 * (e.g. errno).
> +	 */
> +	if (!getenv("RSEQ_TEST_REEXECED")) {
> +		setenv("RSEQ_TEST_REEXECED", "1", 1);
> +		setenv("GLIBC_TUNABLES", "glibc.pthread.rseq=0", 1);
> +		if (execvpe(argv[0], argv, environ))
> +			err(1, "execvpe failed");
> +	}
> +
> +	page_size = getpagesize();
> +	rseq = mmap(NULL, page_size, PROT_READ | PROT_WRITE,
> +		MAP_ANON | MAP_PRIVATE, -1, 0);
> +	if (rseq == MAP_FAILED)
> +		err(1, "mmap failed");
> +	if (pkey_mprotect(rseq, page_size, PROT_READ | PROT_WRITE, pkey))
> +		err(1, "pkey_mprotect failed");
> +	if (syscall(__NR_rseq, rseq, 32, 0, 0))
> +		err(1, "rseq failed");
> +	if (pkey_set(pkey, PKEY_DISABLE_ACCESS))
> +		err(1, "pkey_set failed");
> +
> +	/*
> +	 * If the kernel misbehaves, context switches in the following loop
> +	 * will kill the process with SIGSEGV.
> +	 */
> +	for (i = 0; i < 10; i++)
> +		usleep(100);
> +	return 0;
> +}


-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

