Return-Path: <linux-kernel+bounces-532352-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C565EA44BEE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 21:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54F70170B9C
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 20:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83A821A727D;
	Tue, 25 Feb 2025 20:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="ihNupJKs"
Received: from YT6PR01CU002.outbound.protection.outlook.com (mail-canadacentralazon11022080.outbound.protection.outlook.com [40.107.193.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBFE2907
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 20:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.193.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740513872; cv=fail; b=UJY9C5tdvYCfRFsvfcWDtS+Y9FbkE8sq15xCal4WMZGWwnh6j/VcrJJdVhJWoyUJ9nvIOnLZ7+BpMJ59WG3feSR2FGysVCndwD7v9l64Mf0U84MIhJCxfdNUoQWbTlZM/noYMxrzDS22/v0z5V7F6BFW8OEEBoPnCuhX3tz1V9E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740513872; c=relaxed/simple;
	bh=0ykohgq4yTLrMN+wOXy0rvo3lIYOTVoSs3cDvTTyyeU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=nOkHP30NFNuD3Jb4uKiWtEkyPEzurivPMPv/wsBmtm1flUumSTnJX5tgxLBeiCwawzADaPzCNfPOIOPcm2LTT0zmlwMFliVlhRYulYRibz1Sx6JVxNAQs5jBWT2eK+xuHeVR837qCj7OOk/kwSSzNHr93daftYIgr1epA9gargY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com; spf=pass smtp.mailfrom=efficios.com; dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b=ihNupJKs; arc=fail smtp.client-ip=40.107.193.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=efficios.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=efficios.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+0apF21UfCIPkRXK5WY+YkgX6QbJM5e1FHakGBh2+rKbNoDAnaesMBCEUSxP35rSpu7/uot6bNWAL9X6zWV7FpDpLW1Aimn0ocfthlrqOMKttYSkm2Rjaa/8daH/1q1cMLgqq2eCpn1BJPgwnBRvH3ZSsaBoVhP9qIgeS8ukdIC2D27w1bXbDBacYmsMJy+mVFcd2bHYx8wG3ruEGNDkOk16OkhHmU3m+e2ls/7eUgZ1Q6hwt39gTancmMe5Ojob9z83dAXHsx92VElMn4065uUcqiNPOX+Xjqq33Njy5Da6+h5PAO1yhbo0uEVPkbH7PKa1yfsTkGxqn67xHPUlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZVJP36SQMR8CX7zhlAudPZPbAs2KAQbC3JkG4hvKeo=;
 b=gai4YCOM0nteY/5IqLAU0Iyfok5svcjTELF9ZcAJkXRV4Lc8LFfyJpDToR1h1c7ZRAyiLwmqdeW4TJQBFWunH5LhHoxxEub1SFgV7i3xXdG91d/HyCdZTVv4J6JrCHIM9qZ6F1p0FGNGTuhg8q8hw5XZ/YJUeBzkOMMmsvLzUCXNAvsDw+E1BUulLiPZmGFG9eGgPnSyEjEMHqhh10FYVP6p1SVJYrC2cRzMLxpwuIRm+xrYg3MWY9sf4tYNMfrhYCVdA684/ROL93qf8b9CbNl4sOkzgc+wJao9V/5bPb86REcnN284y/HSG9jiBZYoDZqO619ZJCMIL9bZMB4Zgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=efficios.com; dmarc=pass action=none header.from=efficios.com;
 dkim=pass header.d=efficios.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZVJP36SQMR8CX7zhlAudPZPbAs2KAQbC3JkG4hvKeo=;
 b=ihNupJKs4/vaoHxu7R7H3nghFGAex5vueicv5lItM45A2rCiK0K6V7+uVvg+XVkxMqlrMBt5Da9f9ZypCkpzX4a6NgTk57Ikuhn5Rs+vZtl7n0QpYQT/ibwfzdiFYImXgImfsNEKJp+VPYlmxkd3OxaBZfRQv5Q2aT4AU8SwkF0wjipK0GMyuPUX7Uf7f9aMp/IyNSzTJbbGiGMkY4LV+kUhByfghHjcdBF+uo1WqLDh9Ct1F9Q0oTWe0TVfW0HzNvCUiiFFYecIYy3skPc3/J84C44GCyA1bX+K308AUr2yOJ2U48QZlCOYlWMeI+kU+tBx1pgbSRBPQhSgYLeJvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=efficios.com;
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:24::5)
 by YQBPR0101MB5797.CANPRD01.PROD.OUTLOOK.COM (2603:10b6:c01:30::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.22; Tue, 25 Feb
 2025 20:04:25 +0000
Received: from YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::be09:e1b:b343:7f9]) by YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 ([fe80::be09:e1b:b343:7f9%4]) with mapi id 15.20.8466.020; Tue, 25 Feb 2025
 20:04:25 +0000
Message-ID: <d61a3723-919d-40a7-a5ee-89f55bf8c445@efficios.com>
Date: Tue, 25 Feb 2025 15:04:24 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rseq: update kernel fields in lockstep with
 CONFIG_DEBUG_RSEQ
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
 linux-kernel@vger.kernel.org
References: <20250225153536.711012-1-mjeanson@efficios.com>
 <Z74giMre3SJo-3Zw@gmail.com>
From: Michael Jeanson <mjeanson@efficios.com>
Content-Language: en-CA
In-Reply-To: <Z74giMre3SJo-3Zw@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YQBP288CA0001.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:6a::14) To YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:24::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: YQBPR0101MB5080:EE_|YQBPR0101MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: 91f0ab20-fd46-4aa8-3b2e-08dd55d79a7a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tm1zT2ZkZnYvQlVuNjhvTHkyd0ZRM0RwaXB3NUJIZUJ4U3ZtQnhKeDZDalFi?=
 =?utf-8?B?K2JtdVlFWExLNzBQbDB5TWtuWG9JalJFWTVWU2VYNEh6NzBtYSs2WGhiNHpu?=
 =?utf-8?B?eFhZVUJLd1VMdEpqeXNkZy93U2RaUnJjUmxUdm1lYUh6RFlsT3ZGd3VyUDJW?=
 =?utf-8?B?d1MwS3k3b3VSMkNsdmx2SE1Sc1kxaXV0K0dlN1hsT0hWUFg3MnpqMkN4OGVJ?=
 =?utf-8?B?VWNwUnR1bDczUTJwTS8wcG03UURVNkg3NzRpTUZGcmRxcFBJWW8rQmE5d05I?=
 =?utf-8?B?ZkI3K1FDOG1OQXgwVXNQZkU1VnlrU1hYRU9CRExpZ2svNnl5RTU4Y0tML2N5?=
 =?utf-8?B?c0phR3NmVXVCRDRHbmlrVEVCc2ZiRFcrZEkyR01GZWFBRW9aVERYY1l3ZUF5?=
 =?utf-8?B?NHhGT2ZzMkdlK3dDdzl6WCtybFozQ0Zxdy9iSTdjeHBTRTlrZzJjV1JMWlpa?=
 =?utf-8?B?bE95aFpadTdNRnRzZklyT3MvRWdVY3V2QzdWNGtPK3FaVXZ4UTNTNjUxNWlk?=
 =?utf-8?B?T1lZODRaTzVFb1FFd2ZIOGhaeWZWS3Uwd1ljYW9Icm1jVkQ5bE9SeDU2ZVdO?=
 =?utf-8?B?eEZyeXNVVUJQbDBLQmZMcTJOTzZ5M1U1RmsvRnRWTjZOT05PcnR6d01xbE4r?=
 =?utf-8?B?SmhhVDNvYmpEVDR4WUYrNGNmYW5HUTlYNExObnhYOG0zZTk1ZmVVNmU5MWkw?=
 =?utf-8?B?ejI2Ym1lOTFZR0FaaTQzVmJnbnBNZ1VXQWk5cGwzNjNkUjJ3ZDlwaTRybWhN?=
 =?utf-8?B?c3JkNHdobitkNk9tbDh4bnNxbDJ6Q2M0MndFZmRwc0k2bWVjZG1vR2kyYmFh?=
 =?utf-8?B?YklLVERtdURDWjV5enZTazU3aml2bUVZQVVESXduSjFWV3VzKzR6Z3lMMk94?=
 =?utf-8?B?MkpUTkpEa3FCZS9qNTlySjdNNHNyVVNhWlc0a05KOHBhcldxYUpjSHRqYXZl?=
 =?utf-8?B?di9qYlYzNVZVcWZsMDdJYzhVTEJzWEdITWxLSXdxUUlBZ0xFOGFXdDVacFp1?=
 =?utf-8?B?THBDYVhMaXpSbTYwems5UExJN2RNbTlJYWNnN3dnL1pXVkVRZjhxZmdkTklx?=
 =?utf-8?B?VktqaXdZb3ZCS3ZSN2EzbnlzYmx0blg5b21CY2w2RmM1SkY3OGRHUk1QeUxE?=
 =?utf-8?B?UjhMOXJ6ZWJTRGQ4TEFqQlQ5UjE3UFdtZlJ6VXphdk95d2N1eTNKV0wxZWtC?=
 =?utf-8?B?ZEYzdDNBMDBMbXNJbEwvcWFDNWRsWUNDTjlLTHpTOXdINnRLVEp4di9NSHZI?=
 =?utf-8?B?VmNMRXVHMVRLd3E5cERFMHkxeXNmdU45ME1BRXRzQ052TFF5Wmc0N1pYcjZ1?=
 =?utf-8?B?SUdnOVNFQXo5bXNvdU1COThYYU0xOHF0ekhqemo5K1JqQVJtQUY5b2dBQVow?=
 =?utf-8?B?emFqcGJyaXNKZ0lkMU8wb1RpZUNyaW1tdkNJS3UrSmNLQjMvMEk4MDhlSzlY?=
 =?utf-8?B?cEhOaERCZHI2YUlOWk8xNWRwTUgybW5hRHBHTDNaelRYK3JrbW9JRWlXb0c4?=
 =?utf-8?B?R2E3bDZNUXBJMXA4MTFiN09Hb2tWUVJJSWhocEVCRlI3aDBobCs0eWZOMjFh?=
 =?utf-8?B?NmVrZDdueUJqeGRxc1d2SWRRUE5hUFJqU0kxNEVjRXJTbnVRUWorYjR4blMr?=
 =?utf-8?B?RGo5YkFIMjFDY0xQbHB4dEZxcVhTTEhVdmVXK28vWlg0d1RuZkF4SHBLMmRG?=
 =?utf-8?B?bVNJMGsxdmxsZHl1ZDU4T2psaHU5T1RQQnFmaXJmWVVlQk84VTQrYzY3NzhU?=
 =?utf-8?B?NXBTSGYzZzBGelFzdWF2eFhZOFFRSnBGVXF6Z3p4dlRrc2FsNXN1OFJNSlNB?=
 =?utf-8?B?RS84NjBJWjN2aXpIWUxQdlhuZ3lxUzg5S3VnTlRsdVE0c1ExMkI1Y0NIS2Y2?=
 =?utf-8?Q?1ygHXkPyod6k1?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UGZsRzJvUExJbmxwU1JTd3JHUXd3VnlpTnBuVWhmOVREWkNvMXpjTnhweTR3?=
 =?utf-8?B?ejBWczEwTG8xZXpMNVF6dVdzUHFENmFFblYyT2RHQTBzWlNGd2tDR3lMS0Ni?=
 =?utf-8?B?d2I5VXZudWQvMkorenhpTVI3ODYvaHROVGRHNys1cjBBV01nNXdrR1ZqM1VD?=
 =?utf-8?B?U085bDdMRTc1UFhmcnhUWis5eFhSNnlSU3FYQS9HSnUvNEZ2d09CYUhPbG5Q?=
 =?utf-8?B?NlFjcWlLMWg5bHJ4T2tKM2dzd1lmYXFaU0R6SjBnek85N3BYenlFT3I2R0tz?=
 =?utf-8?B?Nmp0TGFCWFRQTnBjbThldmFnanVnRlVITm9lcjk3U1pFNTlpY0tzWlpsZ1hN?=
 =?utf-8?B?bmw4a0t4VTF5cm9XaG1UeDZKZVEvYjFSZm9HRzdNaGgxUkNLUVFPNjF2ekNQ?=
 =?utf-8?B?TXRoTDc0MDZMNkloOXhMalpoaWpzNXhIVU5mWllqU0U5N3h6UDNDVFFUUldF?=
 =?utf-8?B?NGJDaHVrUDV6U3ZLNlNjTjRsQmZLR1YySmJvQmpFa1pKWGhrZzFGdktCNFpo?=
 =?utf-8?B?Z2ZMVXZhYXFUeGYxaGhoS092eTRhTUlDamtqT3FEYU9XQmUvOE1TZE1oazRR?=
 =?utf-8?B?elZIOFpKUG1vR21DeGZIVTVCMTRlZjlRbEQ5UUJtenZId0lSSlBGM1M5Yktt?=
 =?utf-8?B?TEVKeE5sUlM3T3hPcE5uR2FjVjRvb2Z3QXlnTDhRUjRFTGY3S0hmSDRYWjBD?=
 =?utf-8?B?MDBJL1lsSFk0ZzhQNWlaRmFYNVE4eFB4NGkrVFlhTmJUMFVQY0wzNkNtV2xL?=
 =?utf-8?B?ZDIrUVR1aVlaWkg0ZWdGSU5JM3ZkQXhaU21Tai9BRURIaEx4Nkk0VEM3a3Y0?=
 =?utf-8?B?c0JVNkQvWndvRTF3YlkvM1RMNk1jcmpqWDlhaUl4UFdEcFUxN2tsSDZ5K2pB?=
 =?utf-8?B?NktIdXVNM2JCYXYwMytZdzNEaWhUZVpyU3ZyVjdxYTJLNXVNRnVvVlhhSHAz?=
 =?utf-8?B?L2xCMWhvVjNYT1RaTGdBWXdmbWQ5aDRxaWFPLzBjU2J4VVpvbkptRW5lQ1Fl?=
 =?utf-8?B?MnpRdE0wZFc4eE1YbjVkOVFPVGZSVkQ1OVJVWDdPVFVUaW5KLy9zakhDRWg5?=
 =?utf-8?B?ZXl4SytvQ2NNRCtkQjc0WllkR3N6MXNpNHdubkU1ZWZlVHJpTmhRY0p0Rm1s?=
 =?utf-8?B?T1A0a3dnL2lkYlFhaHpOWkJMcXlNL2dVZzF3dVl6cFpucFd4Sjd1ZmpJRFly?=
 =?utf-8?B?NEExdU9BcG5RWm0vR2IraW1yVFJTdkdWTlU5Nkhrdkticm5kYjhIL01DbVR3?=
 =?utf-8?B?YlZxaUVCamVVZmcvN2p1QmhpY2tLVmduMGZqenUyWldaVHZxendTTTc5Q0Ux?=
 =?utf-8?B?TjFPMk8wRzJUOVh4SktwN1NXSTFZRFBJNnBaMStpS2JwMThqeHdGdGJzMG96?=
 =?utf-8?B?MUo5b1hQM3BtdWNEQS9FQXYxSzRxaDZJT0ljcVl5TDNBWDZ4TThLTTRibWU2?=
 =?utf-8?B?cXorU0tSSCtmaS9mTUIxK2NHc0VHN0xIQ0pDbTZnMlFCOWZqVGxFeDNPelJS?=
 =?utf-8?B?MDRBTnp5T1hpTUx6YVpIMmhmL3pRMyttQU1VUlUxdExtbTJwZUJHRm5qTUJn?=
 =?utf-8?B?OU4wZUU0QjNzRWoycmhDZUJuUWJYZEN6TEhERnJBT2ROOEpHRVd2Si81VER1?=
 =?utf-8?B?ZDh2ekpiaDBicFphcUI0ZUZrdmc0R0wzSW1xWHlGQVp3TkQwdm1UcEYzbCtL?=
 =?utf-8?B?NjZJbE03RW5NRk0zc3hScU94WVduOVVnaUxWK280bkNBcVJVbE03T3NMRisz?=
 =?utf-8?B?N1dmZG5PdVJLQlhEWVk1OEt6ODdpTGtZdmx6a0R1SWhRTE9IY1JlUE9iMUk1?=
 =?utf-8?B?RXpCWXg4cUlrWDFORUNiNkFJZzBISDNiSzIyZzllMjJVUXhkTkc0YnVvaW5R?=
 =?utf-8?B?NGcwNmg4M1pZdFlITVZRaFhRdWcvbGlVNFhqY1hUUVhEdjVrV2hCNThmZWl4?=
 =?utf-8?B?UjRXYmphZkVJWlJZM1BWT21EU2JZT29oU0lyOU9xdzUzN2VPMU8rU3ZJUFJ4?=
 =?utf-8?B?U2M4dEtoMUE4MXc2dWFEeU5rdTZUKzkrV1lOcEFiZS9QWVdBTmpQRWg2eWYx?=
 =?utf-8?B?Sk1YbncyOHR2b3V1Q0Z2elU3WFB4VzE1UGw2VlphdTd5a2FGbW9XVjd6ZjMw?=
 =?utf-8?Q?ixfwkPYtToT0iE+HjMhVWibU2?=
X-OriginatorOrg: efficios.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91f0ab20-fd46-4aa8-3b2e-08dd55d79a7a
X-MS-Exchange-CrossTenant-AuthSource: YQBPR0101MB5080.CANPRD01.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 20:04:25.6085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4f278736-4ab6-415c-957e-1f55336bd31e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bvRCBjA992msntD5jCofOzU29jlY2ua68xcwDf1FSVSzFMVMzZXM8sMm2YCkSLyAAjCw1GLeLHjxPYDdFqyeSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: YQBPR0101MB5797

On 2025-02-25 14:56, Ingo Molnar wrote:
> 
> * Michael Jeanson <mjeanson@efficios.com> wrote:
> 
>> With CONFIG_DEBUG_RSEQ=y, an in-kernel copy of the read-only fields is
>> kept synchronized with the user-space fields. Ensure the updates are
>> done in lockstep in case we error out on a write to user-space.
>>
>> Fixes: 7d5265ffcd8b ("rseq: Validate read-only fields under DEBUG_RSEQ config")
>> Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
>> Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> ---
>>  kernel/rseq.c | 85 +++++++++++++++++++++++++++------------------------
>>  1 file changed, 45 insertions(+), 40 deletions(-)
>>
>> diff --git a/kernel/rseq.c b/kernel/rseq.c
>> index 2cb16091ec0a..88aa780f8cf4 100644
>> --- a/kernel/rseq.c
>> +++ b/kernel/rseq.c
>> @@ -26,6 +26,11 @@
>>  				  RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL | \
>>  				  RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE)
>>  
>> +static struct rseq __user *rseq_user_fields(struct task_struct *t)
>> +{
>> +	return (struct rseq __user *) t->rseq;
> 
> Why is this wrapper needed?
> 
> task_struct::rseq is already of that exact type AFAICS:
> 
>         struct rseq __user *rseq;

It's not needed, I can remove it and resend.

Thanks,

Michael

