Return-Path: <linux-kernel+bounces-269112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A130942DC6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 14:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2E61C237B2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jul 2024 12:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA4518DF93;
	Wed, 31 Jul 2024 12:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b="iVWxD/be"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2119.outbound.protection.outlook.com [40.107.22.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53BC1AD416;
	Wed, 31 Jul 2024 12:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.119
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722427678; cv=fail; b=g49awhVGX0+f/oj3yuQ0MfQnG89IGIdWeYN8fOBRhb8OYkRu88MUf/jUFlVI1VIhW5kQM7SkO19bdyxDowYLZLL/UFWS52mRl5ACbsqqM3B2jbj5E5kqnvDu+zIyL0WpDsgMhOxnd6ypaeHS3JmTudtfU8OJINPHS2JH4S/AJiY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722427678; c=relaxed/simple;
	bh=6kR2oRIJqcD3og1nw2g0miy8i79H3wbIOR+HJSJ6LmI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CfIA3jycAc0/GnL+66b7/smKBZVpSgAlO0IpteDQ9OVGHr/P4eIyTBJAmN4ufsCMScXInXsP1Ee41Th2HESurveapdwvw9w+o2njc/6xTZcjyajc55jgZ64jdpvjrO/g2PB8sUgBDOljDbcnffVhEn7KgH8KhpSm+dsNr2ZIIdc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn; spf=pass smtp.mailfrom=supcom.tn; dkim=pass (1024-bit key) header.d=supcom.onmicrosoft.com header.i=@supcom.onmicrosoft.com header.b=iVWxD/be; arc=fail smtp.client-ip=40.107.22.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=supcom.tn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=supcom.tn
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hcbwl1ANdTLIZtxATppfVolgcskw+Y/i7zOeWJ6T3wf8Xz7eD5UdmMP4NdYdlnSj8ML7wgHwEUTcuvBX8w0FyYBbN/Mk4uR1JqMYGmLUSPQ8Z/Z2FLdCRdc88P7pYutj65WcuU90bfiwh44Z4Pfq0Rw/R2cf/fR2OFrWxUJngeAWvcrsMCeJT+yBQY729dAQZnmCufvhPFF361fCm7O0F0IX1gy7moA1zqAnMQxBmBj8otdTJhrioyqVIw8ZIfXqA0YSP83LQz65QS2YKuSswmX6XS6Lg/Cn27pQq79YY+U8KZ8TQDj2eZfOq5oTpk5ERIz6QJYjgKz31ARn5aF7kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psPOn2kht9QwpoT0DrGevUnTL9EiZpGxkM/0mZjQBDA=;
 b=NbVVZvYNRHLshtmMyHD9nYOaTBC1vvL7d11ryehAhjcliY/lxaGaI8agADjl2eJ1aGcA43oGRHWA3m4uT6CmWwafGIrhbIv4UmMJY7o3OlXTYJDg8iGD/qY3uFHrOyK4SgqnivRJTdZTlnygRemmKSb9C9h49MBQ+L4MnaNOI9WeP84Sjpbk0qTwNPUh3QQGfF/Kem9/2VJc1wQasvKVmxXGrhgvvRkd1kUQVZtQHfRnovK5e0TAAc94nHnxf9vg00MKIOBGVeiG9Er22PuIKpH54RjRk7/hB9Tw90bSwjZThj8E7EUvCVIb1AqLRPABPgYH2hBIKNRt7ctnDSgX5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=supcom.tn; dmarc=pass action=none header.from=supcom.tn;
 dkim=pass header.d=supcom.tn; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=supcom.onmicrosoft.com; s=selector2-supcom-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psPOn2kht9QwpoT0DrGevUnTL9EiZpGxkM/0mZjQBDA=;
 b=iVWxD/beQHrvaL0dC9PnossCOPWNtGW3mzNoxANUj50PO3j19Ftu9uydq7OAWmT+DQE0cFTSRzZL7f9SfIFiI80BV0eLHt1ij+XCDPrqH6iOKowivQp0hG3J0cBhiXG8bwwWdq54t0k64RyclqHQDzrPiMJccGnDwdaJGh4UYFI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=supcom.tn;
Received: from AM8PR04MB7908.eurprd04.prod.outlook.com (2603:10a6:20b:24c::18)
 by PA1PR04MB10526.eurprd04.prod.outlook.com (2603:10a6:102:441::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Wed, 31 Jul
 2024 12:07:49 +0000
Received: from AM8PR04MB7908.eurprd04.prod.outlook.com
 ([fe80::eb8c:cdd5:a0a:757f]) by AM8PR04MB7908.eurprd04.prod.outlook.com
 ([fe80::eb8c:cdd5:a0a:757f%5]) with mapi id 15.20.7828.016; Wed, 31 Jul 2024
 12:07:49 +0000
Date: Wed, 31 Jul 2024 13:07:45 +0100
From: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
To: Luke Jones <luke@ljones.dev>
Cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/1] platform/x86: asus-wmi: add support for vivobook
 fan profiles
Message-ID: <ZqopEfPCuU7-7mUR@meddabeast>
References: <20240609144849.2532-1-mohamed.ghanmi@supcom.tn>
 <20240609144849.2532-2-mohamed.ghanmi@supcom.tn>
 <9daef2c6-6df4-4f61-966c-239450de7b4e@app.fastmail.com>
 <ZnlEuiP4Dgqpf51C@laptop>
 <ebad3eec-576b-46ef-887b-6d3ce31bd5f8@app.fastmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebad3eec-576b-46ef-887b-6d3ce31bd5f8@app.fastmail.com>
X-ClientProxiedBy: MR2P264CA0191.FRAP264.PROD.OUTLOOK.COM (2603:10a6:501::30)
 To AM8PR04MB7908.eurprd04.prod.outlook.com (2603:10a6:20b:24c::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7908:EE_|PA1PR04MB10526:EE_
X-MS-Office365-Filtering-Correlation-Id: bee567e9-1046-4581-a61f-08dcb1596595
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|366016|52116014|41320700013|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZDh6VXZRcVNTSXRKSmw3ci95cHZHbHNQQWRpUWxGNElwc0owemptU2hoUmRs?=
 =?utf-8?B?VXhBdDhQcmFwclBmdDZ5M0hrRG51T3dqeDdzcHB3ZWRyT1owYTU2TkdHa0pu?=
 =?utf-8?B?MitocklLVHBiYUwwWUsrVDZYamwyTkFQOVB2UHozbitrOUViT042cFduZVJw?=
 =?utf-8?B?RXFSeGN0MmNVWUFBM2VIc3lUVzZLOXdSN003czhaYnE4aE5xaE9wbGF4ZFFG?=
 =?utf-8?B?TmJOS0VCdFJiaHZwRkVLVnNyWEMwMkxCdlEyeUllSHFLNWliM0w1bTFVMVh3?=
 =?utf-8?B?R2FrRyt5d1pXRitnQUJHOUNkRUhPNVRralZxMG8raDdUYmwxa2JJNUtTTHpF?=
 =?utf-8?B?VUhnZURIVXA1ZStXbVRVMS9mZnp3QlJ2Qk1QbjJuQ2ZlOHl3TTF3RjRKeXhR?=
 =?utf-8?B?S2JKZFVFWWVjcml3emlEUUwvZWFNTVdPc3c1NE1idkgxT1U5b2ZIbTlFTUor?=
 =?utf-8?B?bWc5VW1aMmlvelZxRGVYWmRreWlqSW83RkJReUdZejFOQXh1QWQ2UXkwY2N0?=
 =?utf-8?B?aFdwQ3c5ZnY4WnFjV2l4NTRqTkE4N2RvckJyZ3NCOTVZRGhVV3pWR29wQTEz?=
 =?utf-8?B?R3pyVE9SZWhZdk51Y3djR3JwNkVjZFFHUktJY1VDT1FJVTl4OENJMDloZWl5?=
 =?utf-8?B?eHROZWZDbElyS3E2bksxdC9rUGRUNTdqcFlFYzk4dW5Ddy83d01teGJvNTE4?=
 =?utf-8?B?RlhGKzNEMEM0WnpXSVVEUnphMEltL0h4eVI3N1I2UkM5aDJpREU5TjkrUWRM?=
 =?utf-8?B?bGlNbFAzRlc4bnZZQXNSZ2pmOHNFbklybTF0TlpWWHViZWs4ajRzVnZTcE8x?=
 =?utf-8?B?T1BRSk12bFBCU0d0emcrbUtiaDk0NC9sUDhrR2JuWDFrMlF1YkFraVRmNGF6?=
 =?utf-8?B?U21MYm02Y1ZtMnBkNkpxZXlPZzR3S2pseTBMYkwvWWJKZ1V6UDdaSTZHMGhC?=
 =?utf-8?B?RkdRaHhWeXE0VDhNS3RtczdxdDFtSWI2K3J6cGdGd1JOQVNyZVBQMm85dUZI?=
 =?utf-8?B?N2JCY1BOWDd2ZWxOTnNTeXRhVmI0VUJXbHp5cFgyZEk2ckJFZGoxa0FIL21p?=
 =?utf-8?B?b2doTnRBQ2VvVFU4UTVpL24rTldCWUdDZmFvN24xbFZEaDVneDhOTGtWMmtu?=
 =?utf-8?B?dDRNeXlkdmR0QW9pYzk2S2ZIbHY1UDQ4WGdTNmd0b0dwN1BXem5VUlY3c293?=
 =?utf-8?B?ZS8rMnlBL3Y3d2FYSFpsNnJ2QTRmN09rUjREUkdvZjFRa1h4bklGV0lPS2N5?=
 =?utf-8?B?MmYyZE5PeHhHVlhKR1c2SjNHN3NIcUFkd2NwcDRrOWJkUlUwbmQyV2pUOHlY?=
 =?utf-8?B?TUtodU45WHU1OE1rMHJid25YZjFoYnN5TUpjYjFCNVlnZTgzYTh4L1RLOUth?=
 =?utf-8?B?S0xqZjdwc2tLWXJsR3BEUnVuSE9mK0Z3c1VHY0d1YXZlNFdPUEZQbk5WbmZP?=
 =?utf-8?B?ZlZZSWkwMi82b3NwcDd3V0V4REdGbzZGSWZXRnZjNEV0T3dMcXA4RlI1cmN6?=
 =?utf-8?B?a2NodkJDOWRDZUlFSWtCNmYxOGZsQ2tDa25MMWtiT2s1NWNVeTFsZHY5K3FL?=
 =?utf-8?B?Y014NE9QUGRHUnpDdFJyYUZvOCtWMks4WmdXbTIxcHVMdWh6WWNzL2Z3dmJL?=
 =?utf-8?B?aUNubFhxRWFpVzl2MzJNa3lRZDFhclJ4ek9ZZHZCMXBmMHVJWCtZbzljM0hD?=
 =?utf-8?B?L24yOXN3cDFzeVl1OXJmYU1jVTZMT2V1NVVJZnpjQmY0RGZrK3BPZi9MY01S?=
 =?utf-8?B?Vkl0R3VPYWIveUhhOHNkK0h3MUdzM05WQnlKaEU2d2VLQ3FOOTNqNGQvTnBK?=
 =?utf-8?B?bXYreWxRTUlVR3BONmFxN0h1MkIySjhEQThUWXgyR1lIenVaK2RaU0FoZVBj?=
 =?utf-8?B?c2NaczkvYm94ZDRVdkdkQUxNRlArUldwMnY2MDRFa1RjbWc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7908.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(52116014)(41320700013)(1800799024)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?am1vbHM2THN3dEhBaHRnRTRIeXZidFV0ZHptTWJlRXM1Zjh6ZXZiVmhwT1Br?=
 =?utf-8?B?OVMxc3BqMjJuYmNPRzJBRG9ZU3QyYWFWTU14dUpWK3oxTVNFTUVlaG04aWxE?=
 =?utf-8?B?UE1oSnZJZFl1VlZRLzVtemV5cnFaaDJkT1lsd3U1cDBMNnhndFFpcEVQbStK?=
 =?utf-8?B?UVhVUWkrT1BoRUFWTkVHREYzemJRTUpWSE5JRDlaaHQ4enorckRzZDNVSlNQ?=
 =?utf-8?B?ajg5RG05dU9XOFQreUhRZVZFVWoveERXRjY1bWtFM1Y0QXYxQkRPdUN5UHRm?=
 =?utf-8?B?TXNPZVcxR1pTQkdhVnUzcUUvOFNLZTR0M0VhLytRdmtCMWMwdWFnRHF1YnJp?=
 =?utf-8?B?b0RFblB6T2NlQnlBT3BPMGFzVGw4NGNzUXY3dlY5ODdnbk15U0lRcGs0clVF?=
 =?utf-8?B?M05jQitLMjhlakNWdFh5ZHlmeTF2RFo5OGRhOEVPUC9VZnRqaWE1TkF6STZL?=
 =?utf-8?B?VHNvU0EyUVp6NjhKMkNycms1WU55ZUQ0SlZwMVpJV01TRDl5aGd5VENjMFlz?=
 =?utf-8?B?TmpmK2p1V0ZLcnlzUkYvdDRYZ1gvOTZKZ0trMGYxZHZTMVgvZDF3V2E0aVdu?=
 =?utf-8?B?RjNvcjA2VWJVcTI0SldYYWRtQysvUXVJNmxWYS9LQXNGelBZbkt1RWVQZzRa?=
 =?utf-8?B?ZHJtbHdaNzZUWVdBT3FvZ3FnWFhMNkpqQ28rTmdxK2daU2orR2JUUDZRQzYv?=
 =?utf-8?B?VkNpNXF1OThrZkxtbGxzanhwNFhOWDRRcit3bnE4ajRheG0xUFJSSTFwRDM2?=
 =?utf-8?B?eUNiMFNTTUFQM2dadGd6NXA3TUdqd2ttNkpZYVRnMXZXbTlJMTBPRzRxcHN2?=
 =?utf-8?B?eGNYMmNzU2FZZjFrNjlJeHJXVEFuZUd4T2ZEc3pYbnU2cmJObGVxRTRDSEla?=
 =?utf-8?B?d0hKaFRRUjVaNmpSd3dwa1ZseHYrMUpZZjZERWh0bENhOTdJTzhnRGRGaERK?=
 =?utf-8?B?MGh6ekIvVHdXZjh4UlZhSW9XSmVzV1dVNzRTSUEzQk1xQ3pBUDJWcUpzQmY2?=
 =?utf-8?B?K215S2o0TlF0ZlRXRzZFcks5TExuTi9XanpCMnRBQUdBMnhzOTZMb2xTQkxz?=
 =?utf-8?B?d1pzL1pkZkhDZU15cVpabHJuVmtnckJlTjEycUg2Rit0RGhNVFN4eVhTVWp2?=
 =?utf-8?B?ZDNjalJKS04wZVU5cWE1QUZ4T1puajd0Z1Z3d2FkUTJ6VlprQnVMSStVdmky?=
 =?utf-8?B?SjBOWXVpMHdLd2o1STkySCtDcHdSRTN6LzBaZlZXNXJ2Ty9iRzUvL1pydnJn?=
 =?utf-8?B?aXEwUFJ3MzlzMThkVkREcThWdWNZQ3pBMWt5ci9Ia3JnTWJTc0xoYjFRNkJN?=
 =?utf-8?B?Z1I2UW1wbkl1bjQ3ajgvWmNCRmRLckJQL2tmMVFFeGM2diszTHkwejE2eWM5?=
 =?utf-8?B?OFBaK280Wk9OclFuTCtSbGJWOFlwZ3dRdGt6ZHVwdGpOMzRoY1lGRE1zdG9V?=
 =?utf-8?B?eWtTY1ZvVkdmUW5QMUppZkRwOHVSazFhOWl2bXY1WlpxRVM5U3dxamt6UU9p?=
 =?utf-8?B?SERNOC9NZXJuK2dpZXhzWWtqcmJHODdSaENUK0lWY25ubndMVzV2Y2dLamdY?=
 =?utf-8?B?Z3JPT1Z4aS9ieWJ1VkNycVEvbTllN2tTeUhrL1dTQWw5RHlNcDR3ZEF6ZlFy?=
 =?utf-8?B?SEhMdlFqWHF1U2J4UFhUN0s0eWZvakovSVZGcU1LUEJUQUw0SXBwRS9yZi9G?=
 =?utf-8?B?NFRQNFlTM210eXVMcnNlaHYzejBid3M0SHpGSWhuNEp5dVZkM2RodGRLS25a?=
 =?utf-8?B?QkdackxYQlJIaEhFMmRhVnZseGpOQkRDQW1ITGhJdW9zaUgvYzVVQ1VocGN3?=
 =?utf-8?B?eHpUWWdkNDlJcEhrSzM5bk85djhxZVlYdkJkeHN5WHdERngyOE9iTnhrUnBS?=
 =?utf-8?B?QTVWakdxQ09pTExWSWlFRHc0RXoyd0ttaTlLQnVDdlU2QmdzcDdnZmlEc2JZ?=
 =?utf-8?B?ZzZvVTJMMTV3WDQzN0pmcUFoRnlSLzM4TW8vQ2dzbXpKQmx3c1MvUWsrWWRk?=
 =?utf-8?B?VGVJTWd5dGF4UkZqeUQ1c3F2UlBBTlovdWpKc3hpN0NPUVYrd2NBZENONXlS?=
 =?utf-8?B?a0N0S3pqaGxycGFWdkh0MnBPc0ZGNldrS3lydDFYT0sxL0hrTGg1V0RuVEds?=
 =?utf-8?Q?jDPLE44l9/1a6fMMkhQ3LCD6I?=
X-OriginatorOrg: supcom.tn
X-MS-Exchange-CrossTenant-Network-Message-Id: bee567e9-1046-4581-a61f-08dcb1596595
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7908.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 12:07:49.8509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8f85f528-6195-4e97-8e41-f5a9ad3bed4a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rUG2XWp1RHKl5Y8xip5Ljdk1qUx/cHPKJLeGsLn+oZgIjPHiw9IBXldTjAXJGBI3g3zbmC283N1i8xreVdT0LmCRtPWkvCuYdNJ8Y4JhUds=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10526

Hi,

On Tue, Jun 25, 2024 at 09:46:36AM +1200, Luke Jones wrote:
> On Mon, 24 Jun 2024, at 10:04 PM, Mohamed Ghanmi wrote:
> > On Tue, Jun 11, 2024 at 05:31:46PM +1200, Luke Jones wrote:
> > > 
> > > 
> > > On Mon, 10 Jun 2024, at 2:48 AM, Mohamed Ghanmi wrote:
> > > > Add support for vivobook fan profiles wmi call on the ASUS VIVOBOOK
> > > > to adjust power limits.
> > > > 
> > > > These fan profiles have a different device id than the ROG series
> > > > and different order. This reorders the existing modes.
> > > > 
> > > > As part of keeping the patch clean the throttle_thermal_policy_available
> > > > boolean stored in the driver struct is removed and
> > > > throttle_thermal_policy_dev is used in place (as on init it is zeroed).
> > > > 
> > > > Signed-off-by: Mohamed Ghanmi <mohamed.ghanmi@supcom.tn>
> > > > Co-developed-by: Luke D. Jones <luke@ljones.dev>
> > > > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > > > ---
> > > > drivers/platform/x86/asus-wmi.c            | 125 ++++++++++++---------
> > > > include/linux/platform_data/x86/asus-wmi.h |   1 +
> > > > 2 files changed, 76 insertions(+), 50 deletions(-)
> > > > 
> > > > diff --git a/drivers/platform/x86/asus-wmi.c b/drivers/platform/x86/asus-wmi.c
> > > > index 3c61d75a3..2e3d8d8fb 100644
> > > > --- a/drivers/platform/x86/asus-wmi.c
> > > > +++ b/drivers/platform/x86/asus-wmi.c
> > > > @@ -97,6 +97,12 @@ module_param(fnlock_default, bool, 0444);
> > > > #define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST 1
> > > > #define ASUS_THROTTLE_THERMAL_POLICY_SILENT 2
> > > >  
> > > > +#define ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO 0
> > > > +#define ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO 1
> > > > +#define ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO 2
> > > > +
> > > > +#define PLATFORM_PROFILE_MAX 2
> > > > +
> > > > #define USB_INTEL_XUSB2PR 0xD0
> > > > #define PCI_DEVICE_ID_INTEL_LYNXPOINT_LP_XHCI 0x9c31
> > > >  
> > > > @@ -293,8 +299,8 @@ struct asus_wmi {
> > > > u32 kbd_rgb_dev;
> > > > bool kbd_rgb_state_available;
> > > >  
> > > > - bool throttle_thermal_policy_available;
> > > > u8 throttle_thermal_policy_mode;
> > > > + u32 throttle_thermal_policy_dev;
> > > >  
> > > > bool cpu_fan_curve_available;
> > > > bool gpu_fan_curve_available;
> > > > @@ -3152,7 +3158,7 @@ static int fan_curve_get_factory_default(struct asus_wmi *asus, u32 fan_dev)
> > > > int err, fan_idx;
> > > > u8 mode = 0;
> > > >  
> > > > - if (asus->throttle_thermal_policy_available)
> > > > + if (asus->throttle_thermal_policy_dev)
> > > > mode = asus->throttle_thermal_policy_mode;
> > > > /* DEVID_<C/G>PU_FAN_CURVE is switched for OVERBOOST vs SILENT */
> > > > if (mode == 2)
> > > > @@ -3359,7 +3365,7 @@ static ssize_t fan_curve_enable_store(struct device *dev,
> > > > * For machines with throttle this is the only way to reset fans
> > > > * to default mode of operation (does not erase curve data).
> > > > */
> > > > - if (asus->throttle_thermal_policy_available) {
> > > > + if (asus->throttle_thermal_policy_dev) {
> > > > err = throttle_thermal_policy_write(asus);
> > > > if (err)
> > > > return err;
> > > > @@ -3576,8 +3582,8 @@ static const struct attribute_group asus_fan_curve_attr_group = {
> > > > __ATTRIBUTE_GROUPS(asus_fan_curve_attr);
> > > >  
> > > > /*
> > > > - * Must be initialised after throttle_thermal_policy_check_present() as
> > > > - * we check the status of throttle_thermal_policy_available during init.
> > > > + * Must be initialised after throttle_thermal_policy_dev is set as
> > > > + * we check the status of throttle_thermal_policy_dev during init.
> > > >   */
> > > > static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
> > > > {
> > > > @@ -3618,38 +3624,13 @@ static int asus_wmi_custom_fan_curve_init(struct asus_wmi *asus)
> > > > }
> > > >  
> > > > /* Throttle thermal policy ****************************************************/
> > > > -
> > > > -static int throttle_thermal_policy_check_present(struct asus_wmi *asus)
> > > > -{
> > > > - u32 result;
> > > > - int err;
> > > > -
> > > > - asus->throttle_thermal_policy_available = false;
> > > > -
> > > > - err = asus_wmi_get_devstate(asus,
> > > > -     ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
> > > > -     &result);
> > > > - if (err) {
> > > > - if (err == -ENODEV)
> > > > - return 0;
> > > > - return err;
> > > > - }
> > > > -
> > > > - if (result & ASUS_WMI_DSTS_PRESENCE_BIT)
> > > > - asus->throttle_thermal_policy_available = true;
> > > > -
> > > > - return 0;
> > > > -}
> > > > -
> > > > static int throttle_thermal_policy_write(struct asus_wmi *asus)
> > > > {
> > > > - int err;
> > > > - u8 value;
> > > > + u8 value = asus->throttle_thermal_policy_mode;
> > > > u32 retval;
> > > > + int err;
> > > >  
> > > > - value = asus->throttle_thermal_policy_mode;
> > > > -
> > > > - err = asus_wmi_set_devstate(ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY,
> > > > + err = asus_wmi_set_devstate(asus->throttle_thermal_policy_dev,
> > > >     value, &retval);
> > > >  
> > > > sysfs_notify(&asus->platform_device->dev.kobj, NULL,
> > > > @@ -3679,7 +3660,7 @@ static int throttle_thermal_policy_write(struct asus_wmi *asus)
> > > >  
> > > > static int throttle_thermal_policy_set_default(struct asus_wmi *asus)
> > > > {
> > > > - if (!asus->throttle_thermal_policy_available)
> > > > + if (!asus->throttle_thermal_policy_dev)
> > > > return 0;
> > > >  
> > > > asus->throttle_thermal_policy_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> > > > @@ -3691,7 +3672,7 @@ static int throttle_thermal_policy_switch_next(struct asus_wmi *asus)
> > > > u8 new_mode = asus->throttle_thermal_policy_mode + 1;
> > > > int err;
> > > >  
> > > > - if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
> > > > + if (new_mode > PLATFORM_PROFILE_MAX)
> > > > new_mode = ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> > > >  
> > > > asus->throttle_thermal_policy_mode = new_mode;
> > > > @@ -3730,7 +3711,7 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
> > > > if (result < 0)
> > > > return result;
> > > >  
> > > > - if (new_mode > ASUS_THROTTLE_THERMAL_POLICY_SILENT)
> > > > + if (new_mode > PLATFORM_PROFILE_MAX)
> > > > return -EINVAL;
> > > >  
> > > > asus->throttle_thermal_policy_mode = new_mode;
> > > > @@ -3747,10 +3728,56 @@ static ssize_t throttle_thermal_policy_store(struct device *dev,
> > > > return count;
> > > > }
> > > >  
> > > > -// Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
> > > > +/*
> > > > + * Throttle thermal policy: 0 - default, 1 - overboost, 2 - silent
> > > > + */
> > > > static DEVICE_ATTR_RW(throttle_thermal_policy);
> > > >  
> > > > /* Platform profile ***********************************************************/
> > > > +static int asus_wmi_platform_profile_to_vivo(struct asus_wmi *asus,
> > > > +   int mode)
> > > 
> > > Given the internals of this function I'm still not sure if this naming makes sense. Perhaps "maybe_platform_profile_to_vivo()"
> > >
> > you're right. this function doesn't only remap to vivo but if the laptop
> > is a not a vivo (in our case a ROG) it doesn't change the mapping.
> > 
> > The way I see it is that there is a logical mapping (the ROG mode
> > mapping) which is stored in the asus_wmi struct and a physical mapping
> > that is used when writing to the acpi device (the vivo in this case). 
> > so maybe naming them asus_wmi_platform_profile_from_logical_mapping() 
> > and asus_wmi_platform_profile_to_logical_mapping() is a better naming.
> > in the future there will be other device ids for different laptops.
> 
> If we go ahead with a function name change it should be shorter, and add a oneline comment to describe what you just did here.
> 
> Perhaps "asus_wmi_map_<to/from>_platform_profile()".

I would like to know the status on this patch ? 
should we go ahead with a name change ?
I’d like to hear your thoughts on this 

> 
> > sorry for the late reply
> > > > +{
> > > > + bool vivo;
> > > > +
> > > > + vivo = asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
> > > > +
> > > > + if (vivo) {
> > > > + switch (mode) {
> > > > + case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
> > > > + return ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO;
> > > > + case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST:
> > > > + return ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO;
> > > > + case ASUS_THROTTLE_THERMAL_POLICY_SILENT:
> > > > + return ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO;
> > > > + }
> > > > + }
> > > > +
> > > > + return mode;
> > > > +
> > > > +}
> > > > +
> > > > +static int asus_wmi_platform_profile_mode_from_vivo(struct asus_wmi *asus,
> > > > +   int mode)
> > > 
> > > Same as the last function.
> > > 
> > same as the above
> > > > +{
> > > > + bool vivo;
> > > > +
> > > > + vivo = asus->throttle_thermal_policy_dev == ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
> > > > +
> > > > + if (vivo) {
> > > > + switch (mode) {
> > > > + case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT_VIVO:
> > > > + return ASUS_THROTTLE_THERMAL_POLICY_DEFAULT;
> > > > + case ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST_VIVO:
> > > > + return ASUS_THROTTLE_THERMAL_POLICY_OVERBOOST;
> > > > + case ASUS_THROTTLE_THERMAL_POLICY_SILENT_VIVO:
> > > > + return ASUS_THROTTLE_THERMAL_POLICY_SILENT;
> > > > + }
> > > > + }
> > > > +
> > > > + return mode;
> > > > +
> > > > +}
> > > > +
> > > > static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
> > > > enum platform_profile_option *profile)
> > > > {
> > > > @@ -3758,10 +3785,9 @@ static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
> > > > int tp;
> > > >  
> > > > asus = container_of(pprof, struct asus_wmi, platform_profile_handler);
> > > > -
> > > > tp = asus->throttle_thermal_policy_mode;
> > > >  
> > > > - switch (tp) {
> > > > + switch (asus_wmi_platform_profile_mode_from_vivo(asus, tp)) {
> > > > case ASUS_THROTTLE_THERMAL_POLICY_DEFAULT:
> > > > *profile = PLATFORM_PROFILE_BALANCED;
> > > > break;
> > > > @@ -3775,6 +3801,7 @@ static int asus_wmi_platform_profile_get(struct platform_profile_handler *pprof,
> > > > return -EINVAL;
> > > > }
> > > >  
> > > > +
> > > > return 0;
> > > > }
> > > >  
> > > > @@ -3800,7 +3827,7 @@ static int asus_wmi_platform_profile_set(struct platform_profile_handler *pprof,
> > > > return -EOPNOTSUPP;
> > > > }
> > > >  
> > > > - asus->throttle_thermal_policy_mode = tp;
> > > > + asus->throttle_thermal_policy_mode = asus_wmi_platform_profile_to_vivo(asus, tp);
> > > > return throttle_thermal_policy_write(asus);
> > > > }
> > > >  
> > > > @@ -3813,7 +3840,7 @@ static int platform_profile_setup(struct asus_wmi *asus)
> > > > * Not an error if a component platform_profile relies on is unavailable
> > > > * so early return, skipping the setup of platform_profile.
> > > > */
> > > > - if (!asus->throttle_thermal_policy_available)
> > > > + if (!asus->throttle_thermal_policy_dev)
> > > > return 0;
> > > >  
> > > > dev_info(dev, "Using throttle_thermal_policy for platform_profile support\n");
> > > > @@ -4228,7 +4255,7 @@ static void asus_wmi_handle_event_code(int code, struct asus_wmi *asus)
> > > > if (code == NOTIFY_KBD_FBM || code == NOTIFY_KBD_TTP) {
> > > > if (asus->fan_boost_mode_available)
> > > > fan_boost_mode_switch_next(asus);
> > > > - if (asus->throttle_thermal_policy_available)
> > > > + if (asus->throttle_thermal_policy_dev)
> > > > throttle_thermal_policy_switch_next(asus);
> > > > return;
> > > >  
> > > > @@ -4436,7 +4463,7 @@ static umode_t asus_sysfs_is_visible(struct kobject *kobj,
> > > > else if (attr == &dev_attr_fan_boost_mode.attr)
> > > > ok = asus->fan_boost_mode_available;
> > > > else if (attr == &dev_attr_throttle_thermal_policy.attr)
> > > > - ok = asus->throttle_thermal_policy_available;
> > > > + ok = asus->throttle_thermal_policy_dev != 0;
> > > > else if (attr == &dev_attr_ppt_pl2_sppt.attr)
> > > > devid = ASUS_WMI_DEVID_PPT_PL2_SPPT;
> > > > else if (attr == &dev_attr_ppt_pl1_spl.attr)
> > > > @@ -4745,16 +4772,15 @@ static int asus_wmi_add(struct platform_device *pdev)
> > > > else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_TUF_RGB_MODE2))
> > > > asus->kbd_rgb_dev = ASUS_WMI_DEVID_TUF_RGB_MODE2;
> > > >  
> > > > + if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY))
> > > > + asus->throttle_thermal_policy_dev = ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY;
> > > > + else if (asus_wmi_dev_is_present(asus, ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO))
> > > > + asus->throttle_thermal_policy_dev = ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO;
> > > > +
> > > > err = fan_boost_mode_check_present(asus);
> > > > if (err)
> > > > goto fail_fan_boost_mode;
> > > >  
> > > > - err = throttle_thermal_policy_check_present(asus);
> > > > - if (err)
> > > > - goto fail_throttle_thermal_policy;
> > > > - else
> > > > - throttle_thermal_policy_set_default(asus);
> > > > -
> > > > err = platform_profile_setup(asus);
> > > > if (err)
> > > > goto fail_platform_profile_setup;
> > > > @@ -4849,7 +4875,6 @@ static int asus_wmi_add(struct platform_device *pdev)
> > > > fail_input:
> > > > asus_wmi_sysfs_exit(asus->platform_device);
> > > > fail_sysfs:
> > > > -fail_throttle_thermal_policy:
> > > > fail_custom_fan_curve:
> > > > fail_platform_profile_setup:
> > > > if (asus->platform_profile_support)
> > > > diff --git a/include/linux/platform_data/x86/asus-wmi.h b/include/linux/platform_data/x86/asus-wmi.h
> > > > index 3eb5cd677..982a63774 100644
> > > > --- a/include/linux/platform_data/x86/asus-wmi.h
> > > > +++ b/include/linux/platform_data/x86/asus-wmi.h
> > > > @@ -64,6 +64,7 @@
> > > > #define ASUS_WMI_DEVID_SCREENPAD_LIGHT 0x00050032
> > > > #define ASUS_WMI_DEVID_FAN_BOOST_MODE 0x00110018
> > > > #define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY 0x00120075
> > > > +#define ASUS_WMI_DEVID_THROTTLE_THERMAL_POLICY_VIVO 0x00110019
> > > >  
> > > > /* Misc */
> > > > #define ASUS_WMI_DEVID_PANEL_OD 0x00050019
> > > > -- 
> > > > 2.44.0
> > > > 
> > >  
> > > If Hans and Ilpo don't have any requirements then:
> > > 
> > > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > > 
> > 

