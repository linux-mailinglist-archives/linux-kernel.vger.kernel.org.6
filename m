Return-Path: <linux-kernel+bounces-302446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D2595FE83
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 03:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 583B81C21C63
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Aug 2024 01:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10EFF9479;
	Tue, 27 Aug 2024 01:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="l+BcpFU8"
Received: from APC01-PSA-obe.outbound.protection.outlook.com (mail-psaapc01on2085.outbound.protection.outlook.com [40.107.255.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8676610C
	for <linux-kernel@vger.kernel.org>; Tue, 27 Aug 2024 01:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.255.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724723443; cv=fail; b=s3xeFJXQ/TGBzEQIa8yW48qa1nQ7WgQQPh5fzIZKrGr4GM0J4SEk6mjk4mruKGIUGVxdnVpFcaTFoYaa5bZ7RSWtySDBVX3ZPl+y5HvFz1Qq9CfIKWgVnQPM8tsUD8uRDQEjUaqQw78xVmDnOaeLJ1SwuaBuHnPXOH7GX2gg9y4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724723443; c=relaxed/simple;
	bh=UyiIcL4N7F7h+F1p1aCUm+RCNETdhU4gOc9uEvsA1hc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PNxV2e4AFaV+Myh/oVu3DA+JzJtq3pt0u6r6NXYT++2arIIcq0zsaT0Aw22QsFgdeiWFgKue0EZD3MfxPtiA/pf0XdAaLErHiUrvb4fVGNYmHcI9IsXLO4PSkdHgmkIlzYwkI2tc0joTmM0OkfyjpDsDguUcabPsEpcma0YbbDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=l+BcpFU8; arc=fail smtp.client-ip=40.107.255.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N3LjjkXXnJok39yZfKjV69ZiVzXK5qhn0TDGXqMQrLN7Es2d00Wd5o7IrqCnj5in/FMLq9XrCeqfFrJwXpse83fZfmfAgnDeRWqbh+QCHPFNQezuAOh+N7pxHW3Z4KQlpvnQL5jrt2lPu/ru+PidQECxtce5uhwjzq96ZymDjdEjIHydGx287+tNNKaFbIYIeN1rTmHWZI3RbPgzhiv5LD8E76JwC2sLOBRUNVMQOVQnY9xcPmohQy8kpMEMlF5GA+b2EwbEgMtYQeGN8KHwAz7HSIdrKth86qE8agS21Blp7MxPnM18m0tZF/jIyeIsSUYy1DvZ3EZNSky61UHqkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNKXxOu+ZNzeyrp3ZPenMLgkgadEaol2oYRtEb/Wbz0=;
 b=mYIFB/OfOe4MoCqpgtC+RTTGBvQcL7qs/Jk85GWIRy/9AS4A6O5c47xM9IbqJjazV/gOGvbnmOX6TyGDb2dN/PCxAPDeDC1emaQ0sx7tbzReMhpGxY+aNtq43JuNpKJYJ8H/eDXsiLketzp3CbUMfHbuJSEuCwVNBUR9eRy8VWF5AuYeZwiLSiQy6NNVSM4V16eG4dtnfS6Dz8+g/IN3wfnRpuxZedm1h/UdKcPeTpTsNhoAhABw9T7DNirnRwCDjZedJJQhx/KA0fqFwwdGm0kRqnpVc0B+MrBU40dy+EmxxIlwe/XHBbF38rbsyTJZYsrFGJuJpxPDfmuvG/JfmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNKXxOu+ZNzeyrp3ZPenMLgkgadEaol2oYRtEb/Wbz0=;
 b=l+BcpFU8/fQ3mqAxiv22U/p2iJezt6vlnjWgVQ9s01gR0BEtHMs7oEaM2LrqnHNv5tD+E7MMh0uoe+E2JMQVqQuwuU1HlHv6KEE48zusElOB/OMW0tVL9KmMjLCoHJYrffzdYWjKtCYW/nE1zf/TgCAUJpGqhZsEvM2pF8iva0UOPaSb8SUahREAlq3c7KAhtRtvBo2PLd8F4jlws0gc5cCpnG9MzL0kOr9G6qFjxkAr3dsZfNOC61RqfPNb/KpQdNM1o6G+WEbgryRkQSSm83pI0IKxLjfPFIoFVSVQ9iCRpQOekZDX6Ld/HjLU0zYpLtWQ/pnW7oVWQcybJn4e6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com (2603:1096:990:47::12)
 by JH0PR06MB7081.apcprd06.prod.outlook.com (2603:1096:990:6a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Tue, 27 Aug
 2024 01:50:35 +0000
Received: from JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed]) by JH0PR06MB6849.apcprd06.prod.outlook.com
 ([fe80::ed24:a6cd:d489:c5ed%3]) with mapi id 15.20.7897.021; Tue, 27 Aug 2024
 01:50:34 +0000
Message-ID: <d7978429-7875-423e-8c95-f81137a4e6cd@vivo.com>
Date: Tue, 27 Aug 2024 09:50:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] vma remove the unneeded avc bound with non-CoWed folio
To: David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, oe-lkp@lists.linux.dev, oliver.sang@intel.com
Cc: opensource.kernel@vivo.com
References: <20240823140139.263-1-justinjiang@vivo.com>
 <2f19c2ff-66b2-4860-a870-a1bffe73320c@redhat.com>
From: zhiguojiang <justinjiang@vivo.com>
In-Reply-To: <2f19c2ff-66b2-4860-a870-a1bffe73320c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SG2PR02CA0089.apcprd02.prod.outlook.com
 (2603:1096:4:90::29) To JH0PR06MB6849.apcprd06.prod.outlook.com
 (2603:1096:990:47::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: JH0PR06MB6849:EE_|JH0PR06MB7081:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f388ce0-f9bc-43e8-2730-08dcc63aa436
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|43062017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TTRtWXR3T2lDZnRLbE41UGY3RnFpS0Y1T0ZENGZ4dlk2cHFhdno2UFR6ZlV0?=
 =?utf-8?B?UmsrZHdsZ3dmS1FibzZ1VTRtT1pqaU52WTF2UnNQc0ZVWGgzUElPb1NpV2Rs?=
 =?utf-8?B?Y21Uam13djZIUUlCeVI4SU4wWnFaazhHMXM4L0N4Z1I2VDJpWXNsRTZ3dS8r?=
 =?utf-8?B?QzNKVm0zRWNaN3NPK0xPcUFabUpQb3lSU1RpWVR3VWkwTEI3YlRnZDVYNTc1?=
 =?utf-8?B?OGVwS3k0WTU0cXBFV0JBNThER0dVTUtKWmFkdzlTMkRCZUJZQVp6bjh2bVBn?=
 =?utf-8?B?azRYaDJUbWhzaHhDQnl0WDh4TW1LWFlUSUZpWWg0UlN0eC93MWpPTVRldThh?=
 =?utf-8?B?K21xSVFUb1BiS0FxUjVPamgrZlc5SlBZaXE5dFdKK1BiZVU5SjFpNXZnR29p?=
 =?utf-8?B?aVpaVmNBeGFBSjJrTWNLMTRKWVcrajZLZlIxSEZ3Uy8yQVlWaXFYVkQ1czdx?=
 =?utf-8?B?Y2hxRHFtNk5PQ0xYL3JEc0J2eTdYVXIyc0hlT1dIblNkdklsRGIyaC93OGdC?=
 =?utf-8?B?ZkcwN25WZHB3dWZTRFNWczMyZ21pbmlrMDN5RE4zcE4zeG9WenA3RmgxTVhv?=
 =?utf-8?B?ZjZ6WlJPNTJyV2ZRcjFaS0VyNmxWdXBSSUN6dDZCa0x6ejYxNHRNOUtyVXFt?=
 =?utf-8?B?WTJOblU2MllINWJOQkdHSjV6T09lcmh3UHd5dHJJeG1NSnBaSGR0cEpjRHRl?=
 =?utf-8?B?V25qeXk4Y2YzOTY3a0VUUnlzcTAya1U1K0s0QkJVQkZDNlNSRDFvdWdYejJm?=
 =?utf-8?B?aVZDQ3dqMVRlajVqTVdFaE15OUdGY0tiWGJpWG1ZQ3I2bE1iL0NQdjl0STVj?=
 =?utf-8?B?VVM1cTNmTFBEcnM1dFVJNUY3aEZhdWE3VDdnNE1KcEt0eTZxd1JHRlNXU2pa?=
 =?utf-8?B?dndyZXBWYmtKUU5OZUd5SzlVczh2R3dBRTd1aHlnMjBheERtZGJ0dWNZNUJZ?=
 =?utf-8?B?eVNJQUxacUo5cmdQLzBwMnVQVHlFWmFuR0d0Unk1cXFyMVVxWk1ScVJHL3pS?=
 =?utf-8?B?aStzS0FRZDNVMXFsTXlydjVsWlZTN3JlWmE2aGVQRUZzQVNRUE9JSG9yQklh?=
 =?utf-8?B?TVcyL0ZJT1NUdkdGY3lia3ZCMGxTcE9WUURiWGNPQTJUSGNZZHk1a3JyOTJl?=
 =?utf-8?B?WXBaVm01QnVKdjAzeFB6cHk4MVRBdG02SEhVK1EwK0xyOVhtRlkxSVRmNHU1?=
 =?utf-8?B?Nkt5THhaNFRjNWpucXIvdUVRYTBFaEc1WUl4K3BpRFAzZjdOZzhSWVg3dlJo?=
 =?utf-8?B?MDJiVEgrbktJSGVYMnFBZXhlZFdzN2daazBZNisrd1dGZWVNdUNjSE1HTWJ0?=
 =?utf-8?B?bWh0WnFpbDBsQ09LakFoS1lPeUJOMEFQQ2pHVWZjemQxL25tWGpOWEV1NVQ2?=
 =?utf-8?B?OFpzS0x5UkwzVFhDbFRTM0wvY1VqQzM3V3BPWmhsYzJ3OEVtOUszWGc2VkRs?=
 =?utf-8?B?eDIzMStGOUpKVi9iNmdEU1lmaUR6TGxldm0yVDFSM2hzbyszSEd4c1VPM3ZU?=
 =?utf-8?B?MlNmeHROSVFVTDgvcDk4QTVyOCtBQ0x4UkhPT003cmh1SzgwK1BwaUR6b2kw?=
 =?utf-8?B?cnd2NkkwWUh4ZmRzYnRTQU42K3FJajlZc0Q1R3IvVi93MGxoUEZwK0V0QVZH?=
 =?utf-8?B?N3BZWlhWYy9yaVFkYUlvbXBlUjZGMUpQNW5IUVNnMXg5ZGViMVNmQnBBQlZv?=
 =?utf-8?B?akt0UVJTOHVINVc1bGxIcGloRHVNOXBjaDl6a21udVg2K3FpdXA3ajJqa0Zw?=
 =?utf-8?B?cmM4NFFoTkVhNlROOUpOR0FMeUhzREcrY0hBdHdNUmRvUGNpZk5XZkdQQS8w?=
 =?utf-8?B?WDhxeGJEcGt1aXZueVdJUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:JH0PR06MB6849.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(43062017);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UzFENWN0L2VpRExVeXYvOVRYQjZzQ2xKL0RZbW9EbDNPa2NpYkZ4QWlJS2Zi?=
 =?utf-8?B?eXhSa0N2R1Q4T0xEYVQza3MrSFF3QkJxZEJSWnNWZVdPbzM4WDVlMno3NjFS?=
 =?utf-8?B?V3RMZ3g5Y3VjOVVDb05vNnczL2JOU1JkQWUzaFBOKzd0R0ttMFh6R0xsdFRt?=
 =?utf-8?B?WWUwSlhrdFpIWDZubUM5T3htVkZDYy9LNjcwZG95Nm5pcTg2SDdlOGlFS0p1?=
 =?utf-8?B?SVl0dFVjODNlS3BkVmlqa2xZT2JMQ0pLWkxWdDRVNSt1bGQrNDBIMkNUbmFS?=
 =?utf-8?B?MzdCeVg4L0QvM2QwYk92eHYwelBQMnF2WHJJQ1pQeWh4ZTFJTFB3Q2xjaC9q?=
 =?utf-8?B?bW1rVGlCVklKaVR2UFZ1cWludEtnY0dUOElXY1VaZ0s2QmNNbW5NZ09KbWZQ?=
 =?utf-8?B?QllqNTZFaWRqTUNRR3lBVFRseVJjT25SY2JJUSs0aGlXTDlWYWR6dXkzZ3Ur?=
 =?utf-8?B?SFdudm53Sk9memVEQjk3OHErbkpwZ1VEMG5XWTVJNU1HNXM4SStFNWFLaFNZ?=
 =?utf-8?B?Y0ZOWUNkNXBsUU9CcFphTWVyTXFLbE5pNEJMRXFkaWRYQ2k1ck1qTUZRTjlv?=
 =?utf-8?B?OVJDWXBUblJXNWdBU3pBTDRObXpiMnoyNnJDdXl4YmtxTW9BUGpPYjZ2eFZm?=
 =?utf-8?B?T3V1c2U3T2FnOWhKUnpTdkNYNFVnUy9LUHFHOFd0Y1V2TUdDc2xLQjBiVmlY?=
 =?utf-8?B?S0hmK1V5eUowb1o5dTV0SWRsM2t4a09vZ1NQeE5RQ2RoNk50c3JSdkJrcHVT?=
 =?utf-8?B?K2syV3F6VUFjL3Nnb05kUUk3MlRKaktCRDFrdkNjeFVzbVFubHhXUzh0a3Fj?=
 =?utf-8?B?b0dnZzRXMGljQ0Z3UEZkQWJwVGlINEJTVmpjVmFnb09ublhyb2YvMFY0dkpo?=
 =?utf-8?B?NldzNmFWZ1pleG9MbVBoOGVDZ1RhMzhUakR0OXhBbkJ5eElIbDZ6eWJMZ202?=
 =?utf-8?B?dWs1VUVzZDVMcWNRUnJJZ1Z5eWplS2Y4U3Fndmk3ZTcxYUtJZWFKek5nY1Rn?=
 =?utf-8?B?emlEVkNvbmxvNWJ3cjd3WkIwdWhkc3R3WkMrQVdkdEFncjNTWmlOT0VhUFNX?=
 =?utf-8?B?eVJndThERnVlSHk2YmlKaHBEWGdXdHNsMWV3M21FS0tPRXB5VlhIdC9UZnVP?=
 =?utf-8?B?NlN0VHdzaWtpL2M5anBuZjdtMHpWZjgrRFJ3SDBxWkgzM205d0V3QWxvQ0Mv?=
 =?utf-8?B?Qy9sd1I5ZWVFckRacEVSd2FZa3VtY2JiSGJKSnVHOG9KSUlCbXZ0VEdPSGRt?=
 =?utf-8?B?WTRGY0Ixb0gxYitMSWFGeEd6Um9Qd2hZdGtjeFFRazQyNlhaNzU3bTdvNktO?=
 =?utf-8?B?Zi9takxkWmgwUlJuMU5GSFZPdVl1eXpOdW93UVJxcUh5bjRjb0ZLSG1CZm5y?=
 =?utf-8?B?K0ZsS25VYWNsZTZ4WVZDYmtqNHpITGE5R1ZWNlZseFdWNnIySHI4T045Qzdv?=
 =?utf-8?B?ekJSTHpzSjh0Tk1CVFVwM09JL2pWMjRaa3lkbTBGdlFpVFpvWmYrL3RwbkRE?=
 =?utf-8?B?QXdpcmlSQk9YYzJOSzgrTTNMcWRiUXNGdGVxTVZHMEt5SHRVNzd6eWprZEJx?=
 =?utf-8?B?eGhwMWp5TGxIMGk2L3dPNlVVTEx2RVI1MUU3NGg2WFBWUE5ZV2JOTWkrTUd1?=
 =?utf-8?B?YmlMUmN3a05zQXp3NTBRSEFYTnF0TGNMeTBzRUlBczVXY21jalpuWVZXOTVy?=
 =?utf-8?B?L2s0NjJpcHYxdlVQcEMvK1ZYUUxNd0krckkyRWNsRy80R0tEcWxURkxPc3BX?=
 =?utf-8?B?WEhqZ0w4L0NwS1JGb0hyc2UxWkl2RmtMcjM2MFk3SUpzaGI3YWE2V2FKMFRJ?=
 =?utf-8?B?dXpSZWxuU29abmpaNUkzbEFDbkc5cXVoRDNML2EwMHhrU2ZsV1E4UEwxbjdH?=
 =?utf-8?B?UTltQW9FaU1mRFprcmJaZ0ZKL24xM3k3REkrQmg2bzh3QTVPT0MzQ1Z4U3lm?=
 =?utf-8?B?S05WbUZmUGxVY1FRYTVCbnlEeGI0UHV1Q0VMeFp4THFNaTAxZlJKUmpFL1ow?=
 =?utf-8?B?M1Y2aHZtOWIwVGJic0ZPODlDb25UcVdITU84MVVkOUc3N2lVTDFqSUZEQnNC?=
 =?utf-8?B?UEpob2FMWjRUZC9FQ1Y3Uk9LT1l6RHhlYkNWRDd4bmExRkpuRy91UXZwTmsy?=
 =?utf-8?Q?44kUL/ncEf2Q7iizcdJ4XtAs9?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f388ce0-f9bc-43e8-2730-08dcc63aa436
X-MS-Exchange-CrossTenant-AuthSource: JH0PR06MB6849.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2024 01:50:34.6220
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Apk3aqCFDafmydC5YEtLSGf5Ck8G8MWFP/EB2zcQ+YXQabKYy4oD/PmaS4f8GfoeutPt/PUipu4U7/xHY/BoNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7081



在 2024/8/27 1:24, David Hildenbrand 写道:
> On 23.08.24 16:01, Zhiguo Jiang wrote:
>> After CoWed by do_wp_page, the vma established a new mapping 
>> relationship
>> with the CoWed folio instead of the non-CoWed folio. However, regarding
>> the situation where vma->anon_vma and the non-CoWed folio's anon_vma are
>> not same, the avc binding relationship between them will no longer be
>> needed, so it is issue for the avc binding relationship still existing
>> between them.
>>
>> This patch will remove the avc binding relationship between vma and the
>> non-CoWed folio's anon_vma, which each has their own independent
>> anon_vma. It can also alleviates rmap overhead simultaneously.
>>
>> Signed-off-by: Zhiguo Jiang <justinjiang@vivo.com>
>> ---
>> -v2:
>>   * Solve the kernel test robot noticed "WARNING"
>>     Reported-by: kernel test robot <oliver.sang@intel.com>
>>     Closes: 
>> https://lore.kernel.org/oe-lkp/202408230938.43f55b4-lkp@intel.com
>>   * Update comments to more accurately describe this patch.
>>
>> -v1:
>> https://lore.kernel.org/linux-mm/20240820143359.199-1-justinjiang@vivo.com/
>>
>>   include/linux/rmap.h |  1 +
>>   mm/memory.c          |  8 +++++++
>>   mm/rmap.c            | 53 ++++++++++++++++++++++++++++++++++++++++++++
>>   3 files changed, 62 insertions(+)
>>
>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>> index 91b5935e8485..8607d28a3146
>> --- a/include/linux/rmap.h
>> +++ b/include/linux/rmap.h
>> @@ -257,6 +257,7 @@ void folio_remove_rmap_ptes(struct folio *, 
>> struct page *, int nr_pages,
>>       folio_remove_rmap_ptes(folio, page, 1, vma)
>>   void folio_remove_rmap_pmd(struct folio *, struct page *,
>>           struct vm_area_struct *);
>> +void folio_remove_anon_avc(struct folio *, struct vm_area_struct *);
>>     void hugetlb_add_anon_rmap(struct folio *, struct vm_area_struct *,
>>           unsigned long address, rmap_t flags);
>> diff --git a/mm/memory.c b/mm/memory.c
>> index 93c0c25433d0..4c89cb1cb73e
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -3428,6 +3428,14 @@ static vm_fault_t wp_page_copy(struct vm_fault 
>> *vmf)
>>                * old page will be flushed before it can be reused.
>>                */
>>               folio_remove_rmap_pte(old_folio, vmf->page, vma);
>> +
>> +            /*
>> +             * If the new_folio's anon_vma is different from the
>> +             * old_folio's anon_vma, the avc binding relationship
>> +             * between vma and the old_folio's anon_vma is removed,
>> +             * avoiding rmap redundant overhead.
>> +             */
>> +            folio_remove_anon_avc(old_folio, vma);
>
> ... by increasing write fault latency, introducing an RMAP walk (!)? Hmm?
>
> On the reuse path, we do a folio_move_anon_rmap(), to optimize that.
>
Thanks for your comments. This may not be a good fixup patch. The
resue patch folio_move_anon_rmap() seems to be exclusive or
_refcount = 1 folios. The fork() path seems to clear exclusive flag
in copy_page_range() --> ... --> __folio_try_dup_anon_rmap(). However,
I observed lots of orphan avcs by the above debug trace logs in
wp_page_copy(). But they may be not removed by discussing with Mika.

Thanks
Zhiguo


