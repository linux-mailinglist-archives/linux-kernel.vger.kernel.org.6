Return-Path: <linux-kernel+bounces-225246-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E6A7912E09
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 21:41:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1AD5B23874
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 19:41:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53F0A17B504;
	Fri, 21 Jun 2024 19:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OjFTH7mZ"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2067.outbound.protection.outlook.com [40.107.94.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDBF4770FB
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 19:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718998905; cv=fail; b=c26K9OSYtuJ8zgpJG+WFCyR3lfwm5FFsgwzcw9cFlQBlJZMZKeYy6F8vv4s53b5okKTBdPZjX49B3TnNzXHM8kzV8AALoaf38gJ1GMRkzJRULKLUmnBGup0jSu9UBecQhpZWctDcgn+/sicd69ECMBIAFethcBrT3WKAwW5WWm8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718998905; c=relaxed/simple;
	bh=0HNWPSciNbiNgCF1QcjmJrcwMMPNhhqcpCPgS6b5q6M=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QD0u96ZPbnN3MfUsNFrh+Qb9lleaJ4o2wzk1LzIr791eXmTunQkpdW62g+eo2NzFT8pP2aaFjDslESK4MExPF6Q8eJzWnsIpn+t+ZLpdvXNRDRGJVK10FOwmusj86asP0gbVOXk294M2duabELK+urffVP2s28Cd3H24+Ln+Gx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OjFTH7mZ; arc=fail smtp.client-ip=40.107.94.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hb0SU0oUQFas5CdXp6Q2mwU2TvKzypsyuigmpVuPz4NONqH5nMxKrJGW2rABXDeg57aZDYdYrltjcHEFsuyzWwAtsVxT4lYQmftCSnMiKUwcMnIKN/XVozK6TxsiaDRNcfi5gSbobuGadYbVE7bj25JactlX30HQ7Z8LaWCcdojKZfdFSlQYkNnRQO3rKgQh2Sk1qSC/r3N53h20qputkhT0YmoFjoKMxShq+1ZTMlfn5YwTaX5GANuqZPYI5t0hQa+f+aBcZAxzQ4o5Ar4fG+qD6jGXuDMaW9hA42U1qzSDK4aNmVClX3bm4Q10tV93Dw8QREzeZ9l1nRN2WlC+pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2Os22LkZ4qmT2z7wXx/WOBF1DK+lozDfOxbumelSNYU=;
 b=QmcY+T8PR+gEERD1sjDD+e1LfuZxzw/KNDAu5Z/pQjJFCy1k76kJeuW4wDTYrav8jD9Bsaw1IkdlTiqlDR9aQr6Zbav9BN5J7ELd5ZNB4ZcWdRgZJYG31USddvTve7CW6gtEZsZjzE+qomx1cwrNFBkorOzWtk6X+ZWpCdvUc5SxmytSdcCRRVKZe9e/H7rD9zFCw2fhGoOlfltSoVw+XWkDKHpsuAGlsDB7Bqv82dPis6Sy02h4+zE7zZ+CKdMf/7miqqp1n+ilPdbsoK3NeRmCo1Qp3zRkYSOcGqsIKNf952N4j8qK6VYt3AFdAVLToiZEidz48JUE9GJ/TT+q2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2Os22LkZ4qmT2z7wXx/WOBF1DK+lozDfOxbumelSNYU=;
 b=OjFTH7mZh6pxbLqFMj5TZ2bP/BDZw1+pld+qNwyvlxcOqxtntGrz5jk3YhVvtVA3hJw52GY6kQyjQcVin8Iqz0Zv9J7oYSClFmZu9vmqST/U35AsekmvTU/pTMRGtJn9oiFhl1qp9RE+X+lrDtkqiC7oSlh9pRiSKe5nCTyDO1A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SN6PR12MB2767.namprd12.prod.outlook.com (2603:10b6:805:75::23)
 by PH8PR12MB6771.namprd12.prod.outlook.com (2603:10b6:510:1c6::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.21; Fri, 21 Jun
 2024 19:41:39 +0000
Received: from SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7]) by SN6PR12MB2767.namprd12.prod.outlook.com
 ([fe80::e441:89a7:4dd:dce7%5]) with mapi id 15.20.7698.017; Fri, 21 Jun 2024
 19:41:39 +0000
Message-ID: <40ed4296-e9ef-423d-a40b-889334eebcd4@amd.com>
Date: Fri, 21 Jun 2024 14:41:35 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Resolve problems with kexec identity mapping
Content-Language: en-US
To: Borislav Petkov <bp@alien8.de>, Steve Wahl <steve.wahl@hpe.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org, Pavin Joseph <me@pavinjoseph.com>,
 Eric Hagberg <ehagberg@gmail.com>, Simon Horman <horms@verge.net.au>,
 Eric Biederman <ebiederm@xmission.com>, Dave Young <dyoung@redhat.com>,
 Sarah Brofeldt <srhb@dbc.dk>, Russ Anderson <rja@hpe.com>,
 Dimitri Sivanich <sivanich@hpe.com>,
 Hou Wenlong <houwenlong.hwl@antgroup.com>,
 Andrew Morton <akpm@linux-foundation.org>, Baoquan He <bhe@redhat.com>,
 Yuntao Wang <ytcoode@gmail.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Joerg Roedel <jroedel@suse.de>, Michael Roth <michael.roth@amd.com>
References: <20240520183633.1457687-1-steve.wahl@hpe.com>
 <20240613152826.GKZmsQGnO3OthLH3Vu@fat_crate.local>
 <ZmsbZCF9rFzuB3rO@swahl-home.5wahls.com>
 <20240616202533.GDZm9KPZtpDKw5aXWX@fat_crate.local>
 <ZnBR6MgS-jzjgA8A@swahl-home.5wahls.com>
 <20240621131742.GEZnV9dn_0XVH0IZ58@fat_crate.local>
From: "Kalra, Ashish" <ashish.kalra@amd.com>
In-Reply-To: <20240621131742.GEZnV9dn_0XVH0IZ58@fat_crate.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA9P221CA0007.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:806:25::12) To SN6PR12MB2767.namprd12.prod.outlook.com
 (2603:10b6:805:75::23)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2767:EE_|PH8PR12MB6771:EE_
X-MS-Office365-Filtering-Correlation-Id: 01956b06-3744-4b37-610b-08dc922a2b3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|7416011|366013|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RHYvdnZUR0lraW9MeTYwWkdUcUNNRU1RUUNCRXVERElPTWxDVGZPc0h6VkVt?=
 =?utf-8?B?MnZXejhENXZBOFpwVlRJZ1p3MlFhc0ZRdzRTcmwzZmt6OG9yQXdNKzRCdmZD?=
 =?utf-8?B?cGM1UUN0N296OXNBeEovaVN2ZEtuZzEvTTJlMFI2b0t4dFRFdWlKbnFBb0JR?=
 =?utf-8?B?TkozUVJvY3hXNGtLRXF0VVByUHVneldHdXFpeTljWlJ3SEtlZUtUQ1VPVXJv?=
 =?utf-8?B?RXpnQ0l4VThKQlNYVGsrL1N5b1Z6WmJGTTZLbHdPclpidld0czhHUTE1bHgy?=
 =?utf-8?B?aGVsMXJQSzVHZENyanp5T2VaNWI0MDN5NlZseGJGUytxZWxldU1YOFVBSUQ4?=
 =?utf-8?B?ZjYxY1p2WWtiZkx2ejM1S29hd05Gb2N3STZ1OVkrSWc4cTIvWUJJR2pxUUxH?=
 =?utf-8?B?RGcxTG5XdzlZMTdtbzZ4cEhuS282Y3YreTI4eVVtUHdCdy9HTVV1Q0dQcjlo?=
 =?utf-8?B?MTlsdHRhaWFETm1aT250ajJCRDJsaFVJNk1DbFJicnpOSFVUYkdvd21pUW9Q?=
 =?utf-8?B?QUFEY20zVzd3OTlncEo3dXRlOFFjK25PWGp1UEpxd2hRck04WW9QUytmSGdF?=
 =?utf-8?B?aDRuRTNnSUt4U1ZFZ1hqNUZpR1ZjVk53ejJ6ajR5aGZKNTNNUU9GSW9xdWly?=
 =?utf-8?B?cEcxQWd0U1Rab0t5cytkOHNZeUNZSEZhUHZaL1ZkRVV6QmZYTFU3b1ZISS92?=
 =?utf-8?B?dlNwV3g5QVZZSWpQeFlySHhyVmo1aGtwTGozNlRFT1JTY0Roa3pRUVhnWmRK?=
 =?utf-8?B?Y3NjNmp4OHFrQ3lqZWlrbFk3WGxCdG16OWdsanhNZHlXdDh3MXcxL3BZc2tY?=
 =?utf-8?B?bFZEcWZsaS9VODRWQy8yVkprSFFiR0QyMFlNckNWeFJQZkEzdWwzWk5JTTZF?=
 =?utf-8?B?ZVllM3lzYjRWUk13OElqUmFUVFEyZm91Tk9MQ0JmNS9sZDRndWpyUW5VOW52?=
 =?utf-8?B?SFQxTmxIZ3ZQb1ZtZFhrQ1dUbTFDc0NkNVlKS1MzNE0zOGJrbk9aN01sSU8x?=
 =?utf-8?B?cC9RM21tN1FFWmphcVF2VGpRdzdqTG56WUtjU2ZYOFMzUm1nUGVVcEg0YkVt?=
 =?utf-8?B?Z2p2Y0ZNWXlEYkxqWWdxQmhNdEd6QTU5UU9IRHpPeGhpU1hvT0U3bXQ0OE41?=
 =?utf-8?B?QWJnSXV2dCt6YkxLekEwai9DV2FUcUxWbFBkMm4xOWpwWjh5ZW5aUnZHc1NE?=
 =?utf-8?B?ZnpKWk92ZGFNMkVmNEUxb29QUHFzOW9wRThMK2UybHhlU21GWllqSWNXcFlm?=
 =?utf-8?B?YWFNSDRLcUljekNoMGwxZHNxQmI5QjNRTFgyNDJHZjBCWnJrRC9tMnlQNFdx?=
 =?utf-8?B?WHo2TEUzUCsreWYvMTNwS1NUTCtQcUNOSXZYSUxiclh3dW1EN2xoVVYwaHhq?=
 =?utf-8?B?bzJFNlk0U0VPTFQvN1dURUNaVHVLNEFmdTV5RGJZZ1krUzdjZHB5TDhOczVL?=
 =?utf-8?B?Z3JMYjNRc1F6L0huYnpYZzA5aDNXZmovd0xYMzd1SVd6d3p3Y0ZYV1Q2YjdL?=
 =?utf-8?B?eGVUU25JaWZvSzV2SHQrS3dSaHl6aTNYaVljb045bjNpNEYvME9WV1J5aWxC?=
 =?utf-8?B?ZGRUVVoyczNod2xyNlFFS1p2V1UyMnVaZnAyWmVtVEc3ZktHUllKbDI4OERk?=
 =?utf-8?B?eEFHaVZvaUlQODNnY25BbjlqWlRMSmI5bU0rZmxzSjZqMWtvQjgzeGxYTXov?=
 =?utf-8?B?a3BZZVhZWjVUN21IVmdkVnFiQnArU3FPemNBWkMxYjVmYWJOTEZRQ01lb3Va?=
 =?utf-8?Q?KGzNi3A4wy97L+6lGcr/iWQK4tAjN32sf42Fm9h?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2767.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(7416011)(366013)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dEo4MkgyMGs0dFVWdHIzb2F6Q1ZCTXBueU9zbGx5Z1RONTFOSjAxQ1FmbkVl?=
 =?utf-8?B?NzVHb20wZ0ZVVWFVRHQxQkI1c1VmSXVDS3lsckVpZzB1Tkh0c3RHb1dkN0Vp?=
 =?utf-8?B?K1VySUFQSW5TQnVKcHltSm5HTjIwS2F6YmwySjc0Mkc2VzRMT2x4TG1TeWpz?=
 =?utf-8?B?aGRLV21nSjF4dDI5UDJsYmRoVWJwVFA4bjhxcUNTU3dDUnhya2dTTlAxL0lT?=
 =?utf-8?B?cFlpbHRHbGIxb2RhU0laeEhUWnlMa2ZxRk0zUmtyQjRQVE4xL1UwbGplcDcr?=
 =?utf-8?B?aTFDVUx4SXZ4cmhFOVdXZ1FQNXVzeERiaDZaNUdEUjU2NXR5cytybWRHQUNz?=
 =?utf-8?B?NnRXZDRBMXVQaXpMd0VicXQ3YWl6Z0RaQ0p1NVdNVG5nWHVVd1ZGbUR4Zkth?=
 =?utf-8?B?SzdERkd0RVJYYnR3Z0dqWGJGUDBxS2JpSnh0UTRvUWFOOFU5c3llWGZTUzBQ?=
 =?utf-8?B?MHVjcGdVU1NpaFFLa2k3dkxtMWd6MDl1Z2VHZU11UEpnZmZSdThEa1RnczdY?=
 =?utf-8?B?dlBPczM0R0xDTXJmUDBFZjNiV0xNN2NHMXRvdGRiS2EzZE9VSGxyUkxqUEh5?=
 =?utf-8?B?RTZyWThrcUVZbkllWGg0Sno3UnU4TnVvYk1hRkVKUVlKZXljVTZKa2UrWHp2?=
 =?utf-8?B?TDF4TnN3U2lGdDJKc3V0bmdPOTdOa2h1RExJOEJVNWtxdlJzcFQrb3MzYjZB?=
 =?utf-8?B?ZFRtSjJSZFJIQityKzFleXJBNHZmUHlsZjltS2J5VkdBQ1FyYldrc21mUk56?=
 =?utf-8?B?NGQxN3QvaTdLVXRqOHZ6QzhLcHJhaGsrSGw0dkN6OVpNMEZBNEc5K0hxOVpn?=
 =?utf-8?B?NXRiN0pHRS9yaU84akR1cDM2UE9Td2FxOEFsSGJObXE1MmIwME4wLzZsbEZL?=
 =?utf-8?B?VjJnUlRWZDdsR3JxL08wSG5jLy9kUUV2TGRMQ2VIcHFjWnF5cWwyU3c5YjFX?=
 =?utf-8?B?UEw3ZmlRQ1FXQTdkZE9aWkZHbEJibGYwalJWaFVTTGF1N2hMQlBld2NIUE5l?=
 =?utf-8?B?K1VLU2Y1NGlTdExEdmt6cDFXOGQydXZnOXZrSzRYcFZTanF5TGp4bW94Tjd1?=
 =?utf-8?B?emY5dHdXcTJVU09EdzhqQURFdUd3em1BK1Y4ejcvT2xjNmhNb3J3V2dYYWRa?=
 =?utf-8?B?VXlCQzJKQ0RCcGUxWFdwN2hZZEhISEQvVEMvN0VyZzdsSml3ZUtLSXdoWlNR?=
 =?utf-8?B?NjVHWE1mcEtjTFk0TDNvZEFTcUxmcUtBVjd2SDJvR2hkaTIyK2taQVBGd1Zk?=
 =?utf-8?B?OHd5TzRtTFNiYUVZd0ZxNnZrT1dQYjlRMUtFNEFyRHlYL2w1VjFLdmNHL1Ft?=
 =?utf-8?B?dHMxaGcwcDhEWm53SVYwY1oxRFZBQ0hUOUZQY2QwamhZNTg1OGhyN2k1YzAx?=
 =?utf-8?B?aStJcllMV2FVZVRvaHppN1RJQ09aTDlMeTZpNGpYejBpTkF2OXRIQ3lucUFr?=
 =?utf-8?B?S2VIL2pCbWE3TUd6OGEzN1pkU0dJMDU1U3RNaEE5NTVqUTRrd2xxWHhvSWhR?=
 =?utf-8?B?d0RjY00wZU5aOHU0aE8rNkFMQ3lqZ1luVlJ6WHh2dks5c0R4K09tZHpXVFhK?=
 =?utf-8?B?L2Q1dHR0M0ZDYU1IODZ3S2RjKzByNGZmeDFBVHErbzZhZDEzQUwxSmFGdTE0?=
 =?utf-8?B?TVhpTXh2WjYxM2FmQXV2L0RMTEJ6TzNhOGwvZ0VSY2czZmhKREdXSWRrRjNs?=
 =?utf-8?B?b05rY2JRTmRJbXJNaGVxczdIUFNhLytvMnZaeHExUGlUdnFWRmxWcGVqYkV2?=
 =?utf-8?B?NW5xUnFJQ1psU041YVhIWCtNUWlFZ3I2dGZIVndMcW9EclozT0M5RXFWZ1lu?=
 =?utf-8?B?SXBBTzRkalIyN3ZJTFRKajErTlBjSHNJaHJFMjAvZnUzQldPOUdjOFBrZGp4?=
 =?utf-8?B?QUFIUVVUbGhVVmJ0ZW1lOUNBSlRaTHNkL2h0OE9mdzN5TmU0elltMHllYWkr?=
 =?utf-8?B?U3RWSU56RVk0bnREWkJqTm5TZ21iMnhOWVdZVWJYRWRhWG1hdktqYXZraGJW?=
 =?utf-8?B?M1grNS9NdlphK3dMZExHV2JHWEZCRy9ORHJPaDRjNWlIYmYxdlZRdzNVak9G?=
 =?utf-8?B?ZDBjQmJTYW1UZ0pkS2dEV3pPcWV1NkRWSldXWWFFLzBpK1hockJJUFl0RjBM?=
 =?utf-8?Q?VZeuJywoCmlshnvQtAk7M2vBe?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 01956b06-3744-4b37-610b-08dc922a2b3f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2767.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 19:41:39.2892
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /BDfpewgQdO1p4qzxC7MOri7UAye+Jojy/YLfwjo53qpv3aMTQGszqJWG0GEQpg+K/wZyL9XzOWefuCkVWwLVQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6771

On 6/21/2024 8:17 AM, Borislav Petkov wrote:

> On Mon, Jun 17, 2024 at 10:10:32AM -0500, Steve Wahl wrote:
>> The first, hardest step is locate a system that is AMD based, SEV
>> capable, with a BIOS that chooses to locate the CC_BLOB at addresses
>> that do not share a 2M page with other chunks of memory the kernel
>> currently adds to the kexec identity map. I.e. This is a stroke of
>> luck,
> Ya think?
>
> It is more likely that I win the lottery than finding such a beast. ;-\
>
>> and for all I know could depend on configuration such as memory
>> size in addition to motherboard and BIOS version.  However, it does
>> not seem to change from boot to boot; as system that has the problem
>> seems to be consistent about it.
>>
>> Second, boot linux including the "nogbpages" command line option.
>>
>> Third, kexec -l <kernel image> --append=<command line options>
>> --initrd=<initrd>.
>>
>> Fourth, kexec -e.
>>
>> Systems that have this problem successfully kexec without the
>> "nogbpages" parameter, but fail and do a full reboot with the
>> "nogbpages" parameter.  
>>
>> I wish I could be more exact,
> Yes, this doesn't really explain what the culprit is.
>
> So, your 0th message says:
>
> "But the community chose instead to avoid referencing this memory on
> non-AMD systems where the problem was reported.
>
>     commit bee6cf1a80b5 ("x86/sev: Do not try to parse for the CC blob
>                           on non-AMD hardware")"
>
> But that patch fixes !AMD systems.
>
> Now you're basically saying that there are some AMD machines out there where
> the EFI config table doesn't get mapped because it is somewhere else, outside
> of the range of a 2M page or 1G page.
>
> Or even if it is, "nogbpages" supplied on the cmdline would cause the
> "overlapping 2M and 1G mapping to not happen, leaving the EFI config table
> unmapped.

From the instructions to reproduce this issue, it looks it is only reproducible on some AMD systems with the "nogbpages" parameter supplied on the kexec-ed kernel's command line, so supplying "nogbpages" is essential to reproduce this, but then "nogbpages" as mentioned makes sense on Atom processors mainly and those are already safe due to the following commit/patch:

commit bee6cf1a80b5 ("x86/sev: Do not try to parse for the CC blob
                          on non-AMD hardware")

The question is why would you want to use "nogbpages" on AMD systems and then find one of this system which does not have EFI config table mapped as it is outside the range of a 2M or 1G page.

Thanks, Ashish

>
> Am I on the right track here?
>

