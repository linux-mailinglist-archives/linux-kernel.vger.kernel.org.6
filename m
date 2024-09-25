Return-Path: <linux-kernel+bounces-338213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8599854E7
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 10:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D60282095
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 08:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620C2158848;
	Wed, 25 Sep 2024 08:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="UfiT7hBs"
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C27156991
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 08:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.159.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727251334; cv=fail; b=l5k5wJKJF9P/QiyJtwZS60IafD4HHLpRXhpfIN2W0AJE2xQLbJ5inb7Dny6FY+gFspXmOzQO2XLQuvmEBGoqFDkjZnqGeNWPAT6RBPNDfT4kcKkI4xwqSG2Z4GD+LNTpyFsLk67jMz0p0u3mmsNGDxdZQYvs1F5d3MzE0VWNXTU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727251334; c=relaxed/simple;
	bh=hFH1HByF9hGOstAXN4YKVRkOnqC0EIQ9+XsyePpbzxQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PYW+hVdG9AjQTmRhn4WP+CmuScJ+AJ2p6R5oeR59YsZ/lUbhj6mLLbozRhYdRyj3K5cqrcRibxvY2/T7ejs/HjPgph50M6/OOpSb8zI7yU8uH3HqcJa3p++1vrQGG83E9yrFmta8Jmve7aliXQP2DbyGSEmq2jsnDr3PoWLTgSI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=UfiT7hBs; arc=fail smtp.client-ip=68.232.159.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1727251331; x=1758787331;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hFH1HByF9hGOstAXN4YKVRkOnqC0EIQ9+XsyePpbzxQ=;
  b=UfiT7hBsSlAV5TuUhKHRnq4V5bFDLfVVEICCwt0aiSYIQDxR/r8RcBYR
   LvCYD7IDK9cDgb3sG5i22K7Z/TWg41S7yMdyss388JBRDxGNTj3tOGPkP
   v0/yCjDt/5rcwK9Wm4n4rXeSi/WOF37/EViFjjyPwedWXKdDDkwPa8Ak9
   TRoZGXsbTYuhN89ri6dtYoYG6UZfDCFAuQPuiyxhc+CTkB1gTqdXm1uyG
   qkXY2mHwnv+oIawV9+k3rNXG/vvnbB13EJkTcPNUjU0TzrqfiJ12SBV9S
   /nb3NzJ0SNi6bMOMbfdX6BwyxL0i4nXbX+2aIV8B4kc/eJzmMXC0+8MNP
   w==;
X-CSE-ConnectionGUID: SBjGQvbBQU6ZazIr9Gqe8A==
X-CSE-MsgGUID: Xk8ceWzWQOOwbX3yx3FLhA==
X-IronPort-AV: E=McAfee;i="6700,10204,11205"; a="131676195"
X-IronPort-AV: E=Sophos;i="6.10,256,1719846000"; 
   d="scan'208";a="131676195"
Received: from mail-japaneastazlp17010004.outbound.protection.outlook.com (HELO TY3P286CU002.outbound.protection.outlook.com) ([40.93.73.4])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2024 17:01:55 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NKncc8u+g3kD+Z9oWgpGLND4OMD0fh5JBAY5qGTEjB0bT1UmLhwYjK6C31wxyovBKNUuRYz30XB+tZcSaG6ENptmdcYwbf9Loy2iplkmqB3pl+94DgXkrWyPW9w5+9LMENvde7Dx/9zM9f9F7rk9MxpDXENF3OA6PL6k4YlDFpFPACowfy4KhrXCsZluHGZvGDLTTm/xf2dAmyQSoEt5EK0I2bFaNLoO+daKj8qNHZJftctVb0MhPPd4Z4Tk0RE0z/eBmYDmfrBak6iNDdJ+jb7qN/3tG7t51iFHJEPAzIgsMEZKWny0vE/ykPkSQIgoG/4OLGZm0EbDWdvrXgdeOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hFH1HByF9hGOstAXN4YKVRkOnqC0EIQ9+XsyePpbzxQ=;
 b=dTSK/538D1qUfciqE8GNTZw4Aqd0/h7Arqb/aZsYIexi7lqGTG3O8abUBoSaxgaSB3zNmnG+jh06P4vXNFRDut2XVvx7AeO4DtpG1UMCN1cgb399ZUwwTQqEjurANnTX+edtoACJp8jU/1TZdp9mUFJW1xdCTjUAnRbVLZmKudP2xQVyNG4nsFdNiutGMo7+FCpLrTw7PTGRx//LXvR7AtROv6gxnSx47taxWMWkXTecHoC172/dFdQKxvO638vLX71F93IO1pgP6mThZMTZDWlhZGYRby+zSmZDhn7I0jf30XLRqJw+vro2stBv8cYQVOxrZL4Owjgtei3mC1OAAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com (2603:1096:403:6::12)
 by OS7PR01MB11468.jpnprd01.prod.outlook.com (2603:1096:604:23c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7982.27; Wed, 25 Sep
 2024 08:01:51 +0000
Received: from TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377]) by TY1PR01MB1562.jpnprd01.prod.outlook.com
 ([fe80::d9ba:425a:7044:6377%3]) with mapi id 15.20.7982.022; Wed, 25 Sep 2024
 08:01:51 +0000
From: "Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
To: "anshuman.khandual@arm.com" <anshuman.khandual@arm.com>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"david@redhat.com" <david@redhat.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>,
	"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>, "osalvador@suse.de"
	<osalvador@suse.de>
Subject: Re: [PATCH] mm/memory_hotplug: Print the correct pfn in
 do_migrate_range()
Thread-Topic: [PATCH] mm/memory_hotplug: Print the correct pfn in
 do_migrate_range()
Thread-Index: AQHbDyErxhahfdpSoESWDVgy/wQbcw==
Date: Wed, 25 Sep 2024 08:01:51 +0000
Message-ID: <8f48a487-f8b0-7a0a-069a-78706413bd22@fujitsu.com>
References: <42545fc6-8c91-4f20-9959-2416b9e112c2@arm.com>
In-Reply-To: <42545fc6-8c91-4f20-9959-2416b9e112c2@arm.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.1.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY1PR01MB1562:EE_|OS7PR01MB11468:EE_
x-ms-office365-filtering-correlation-id: e0cbd4b9-fae0-4ae3-ee07-08dcdd38505f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|1580799027|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SGlXY0cyUnA2S3RLeU1ZQ0lSZmltZ3NGZUNBREczaVZOOHczaDFhamhqZ1lH?=
 =?utf-8?B?OTZxNFdHTnBzUWFNMkd0Ynowa0tLTXhDSEs4d0t6em5vNDVnRlk2TUFPVkFT?=
 =?utf-8?B?czY5YjJZNGxDOC95OHVlWHdlZCtncG1PKysrVjlRS0JsZW5vVWtJR1phc29E?=
 =?utf-8?B?VWdrVlNCRzl5TTROMmVZSEtZeE5xR1pSK1R3ZjRyNm9wVFQvWklKb0xmbnA2?=
 =?utf-8?B?SnNaalVObVRtZnlMckh6MCthTStlbi9LSThXRk5KSmN3Snhoa2wzUGVzVmYr?=
 =?utf-8?B?WXp0aGJmdHRFTWRIVlU4M3NjaE5ZNzJFTmNrQlRvRWVTb3dDUEdpVVNNZmVq?=
 =?utf-8?B?WXpTNGhhem1ZRnVCdi9Eb0xFK0pPdll0Rnp5T1YvNEFpdk5BZkVUTUhZcHdw?=
 =?utf-8?B?SndrSEF1Y0NpZWJFRTdKVGJ6MWFqNXJpWUhzSTYxQWZEcHgrellsQ080QkJG?=
 =?utf-8?B?S2hFcXlhV294d3hWMnpYUmxhaFBCU2VKVlR1ZkVqN1lheHl2MGpHN1ZVRGVi?=
 =?utf-8?B?aDBCSzNWVlVXNjJrbE1lQWtCQWswb1VxYm12ZHFzT25NaE9tN09PY0NsUUlW?=
 =?utf-8?B?Ulo3NHUwZkFwYjZQZ0MrVFJyM1BqcGlId2x0bnN6L0RTQjlpRWpmVk1paGFu?=
 =?utf-8?B?YUFKYUtudXl2MVp0czBQVWxOVmF0VGNaMTRMTEVwRVBTVDB6cUxCUjBuR2RM?=
 =?utf-8?B?NVB6SXl0cCsvMTFjbDhjVUpVZFRQbi9HNEJPTnJLVjFLRmloSm1oSTIxOWxI?=
 =?utf-8?B?MnV2ejIyeTJuVjdDSUxWWmZSRmtObzZkbUk1STF4T3N2TDhXQVZGM1hmd3A0?=
 =?utf-8?B?b2loWjFGaGFySk16NmFlUTIvWUR2L0pSbzBRMjRxNWRhOFBQeWd5NVp4WWpQ?=
 =?utf-8?B?dnp3a25OUXZ1ZmNJM0wwQmhwdWx5SC9TcEdrc3FDbXdhcG54c0tRTHJJOXUv?=
 =?utf-8?B?SzQrRnJxQXhFTEJxUjZRZVVGcFVzRHEyeWFwbWRuQVB2YzUvdnI0NU5OS2lo?=
 =?utf-8?B?dHBkZ2dWQTRBYWdlcU1zcHkxcWtWc1NSSnVhR0FpQm5nbENqMUxCYW55RzFv?=
 =?utf-8?B?VTJmaGNQcFNGRjVwbkQ1S1RKNnE4S3lycTNTYUxhMzV3b0Z4U1RVTmdhRUN6?=
 =?utf-8?B?d0VPbW5KSVJQVUZJL1JrYU5yVlRwMUlLUDJCcFlnZS9BZko3WWN1cy8rY3Z1?=
 =?utf-8?B?aGkycHFLajNHbWJBV3J2Q1R1TXhkNWNWeFFGYnFuUUFxZ0hUamRDbW1FQk9Z?=
 =?utf-8?B?dUVOdmlUcjFxMGJoNEtwd1pHcysyTVE4TExXR0U4MlBvaStSdldyeDFyMmdO?=
 =?utf-8?B?N1Z0WXhkYkhicUZOVlVvb3BrTzkrenphWG1POWR1TnpaWUkvdlplbXpLUzE0?=
 =?utf-8?B?c2JSOEc3by8xTUxrSVRMQUxoTXF4emszVitFeGc1TEgvSkRtR0tFS2Z5ZVR2?=
 =?utf-8?B?Tm5NL1kzS2JNTDgrNXdSMHVUY0VydGFTczU0ZHlUVUFzcXlqbzNUU2FkSmV6?=
 =?utf-8?B?aDQrSzNsQ0JMaVZNYnRoSmlyVU1SWlpQTHZWRTdZOTh3RzdtczlHWm80bXE0?=
 =?utf-8?B?SFNyVTVNOTZ1VU9kbmN4NXhFTFhkNnovbGhwTkU4K05WVjJ1WHFlZzlMOU1r?=
 =?utf-8?B?VU5MajFEcndSdlJFVHVuMkdJUmFRdmFDREowUUp2V2lad1AyUnBjUUlGREU4?=
 =?utf-8?B?WHZ4V25CVmhvZnRKSkwxeCtkcXhuYmdaMjVzOUsxM1hQNlJsNGo4ODRIQ0Ev?=
 =?utf-8?B?Wk1YNHF5eTQ3U3dFeVppb2ZxMjRmL3Y2Q0VVL2E1cFRxWGtEZlRkZlVWbTN4?=
 =?utf-8?B?ZEgzS2hNRVpMV2NObHBiSDZpMlpyRVM2SEN0eE9BdFpjaEx5NElGSUFPeERB?=
 =?utf-8?B?OFhSNFhYSCtRa2RTL1NlTFZDb0JaWU1aUTBDa0xQd3QxbkllY1NIMzdZZG5J?=
 =?utf-8?Q?t2IIizu7fdA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY1PR01MB1562.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(1580799027)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?K0VENUlaMHlRRDFSM0s4YUgzVWRacXVhRzhGWmV2WWZteEd2WXhzVjFROWVu?=
 =?utf-8?B?Q1lPaE81d21hc3NsTHowRG1SZUx3b3hZa2EyczhOakFGUG9scVZyck1Ra1Y2?=
 =?utf-8?B?UllpTTV3SHNwWjN3OG5mNnlxV1BBR3Z3em9SY3hLd0hoZkFBSzF2dTlXZUtH?=
 =?utf-8?B?S0hOUG54N0g3YUU0VFA4OGorczdEVGc0eHo2VFl3MTdPZ05TK2tORHFqQXhW?=
 =?utf-8?B?dlZzaytZczQ5eEYvMGZMME44VHZwOXFZdm5sNHVweWNvV1B6MjNkRFRkOVZw?=
 =?utf-8?B?cXhjODA0ODJvMlJDTnA0bm1KYldEL0Z6NCtXb05XdE1mSGE0eE1CbHg3NWFn?=
 =?utf-8?B?MUNCVmVvekVhWVQ4WkZHbEtWc2dhV3FjZUkzbThWeFdVU1hWNVpaRVp3SGtS?=
 =?utf-8?B?dXppcCtQZS9wWndOaUhMbDRjOWFUNVFlRHRGTG9ySmoyTW5XaDhBL2dPcUtD?=
 =?utf-8?B?bjVqMjhzemU5dmdpbXNZK3BYTUY2K255ME8ycnNoWUk2NlhwTEZuWWJ1RzBs?=
 =?utf-8?B?dy9hbXFiVzlBQTdYRWlXNXhyYU9yYmk4Z0lVS1FVUmo5SE9ycWJPbnZVem01?=
 =?utf-8?B?NDFZV0tvL1pvcjlPazI1b2J5NS9KYnVJOXgreG5DUGhPeDJuTUt3dDFJODVi?=
 =?utf-8?B?d1ErWGhNVFNESjRLSm9YT3c2clc5QW9ab3VNZTBYMjhHQnNuZ0N4cEIvbFky?=
 =?utf-8?B?bzd6SEhXS25LL3VjcXFlVXk5Q2RuTHhXQUhzMjhIUnBuT1Jua1JZTFJWbnBh?=
 =?utf-8?B?MDU3ZFBkVlh3V2tzWXowa2FBU3hrZ0hYQTZiQWlycmxoc0RYRFlFMTA4UkJq?=
 =?utf-8?B?YVBwaTFpdE1XV052SFE1ZEdEWlpPRWpQYnhIdXlTMzdEby9aZU5RdHlNZmRE?=
 =?utf-8?B?VFFaaFdiSkwzakovdnRieTRLLzczVHIwRzR5bzNqTCtHUU1NSmRPbEx3dXRN?=
 =?utf-8?B?TXJwWEYzYnl2TnlLdmsyVlN6cVFJUmZ0MHFzRHlSS09uODJTc1FZTGExVEU5?=
 =?utf-8?B?cnR6TmJvQlZYc0s2bG5McHViRkU1Q2IvczFtKzQvMGJCTlN0Nm9wNE9TTGRa?=
 =?utf-8?B?MmpyQmNNczBTMStRZGJYVWtFVXBvSENSWEsvYnFOWmRCSi9udlBESlV6RDFr?=
 =?utf-8?B?aTNlWnNnQ2VYaHZSLzU5MkRzbkZnajBOc1dBSVZvTmZ3cGtaeENlT1V2TFFr?=
 =?utf-8?B?ODM1SkdhWGdRV01qZnJ2NEJBdG5VdytiMFVQRlNCOEhFeU8vOW9LdUhOQk13?=
 =?utf-8?B?T1dTVnRRSVV6M2o5RXZQOHdJS3E1OVdBVWVQbGJSQzd3N2NHTFBYR1YyQk9s?=
 =?utf-8?B?eldiNGZUR0JSc1ZCNm5MMUpPWHk5VmhEWHo3NUx5RGRsMXhVRDBWdEF0bWRp?=
 =?utf-8?B?VmU5NVFxM3d0bGprUXBkR0tMeFkzaWdTN2tUcllkOUMyNyszYlZjWlp2MFd1?=
 =?utf-8?B?citOZXh4dmFlU3pjSkV1aUNuNStoYStXUXJSVG95ek0wWVFTQ0xFcGVuRTN0?=
 =?utf-8?B?RSsxTEQ0eXlkOU9kUHliMVdzYldRRG4zMGlCV3NJVGZkRE5HSklpbmFSeDZE?=
 =?utf-8?B?VU5OU0dRYTdidncydEdTelIwQWloU3llTkpwdGRNYWhxbm5UR2ZYSkI3R1hR?=
 =?utf-8?B?NmFOaVMvem15MmRSZ0hDNGZ6ODY5RjJoRWl6SkhteHBWSGVqRjlIekZZejEx?=
 =?utf-8?B?NVVsY2lDN3dqMTFYVkl2ZVkvd3NudDlzSFBXZmlnNC9KM0NPR21yc1ZhSjYy?=
 =?utf-8?B?aWFpZkVLVUNDK0dycXRiTEh3ejBTUWc2cXZ2Ui9yN3hEdWhkbGFoMWdRZHBi?=
 =?utf-8?B?TjFIQjdlMVBwVy8yV2RnK2dZK3hvc1B6WmxpZVdSUWhkVHFQU3pIdTlaRDlR?=
 =?utf-8?B?ZGptaTlFQWpQbUVjVGlXVnlKQlhjL2lWbmhKNWVUcHVIUFNWclFJU2JHcEgx?=
 =?utf-8?B?R3FMSlJUNjk5MjAxK0tMMGZOZTBoS2ZMcVlHd3Y5N0hxcVEzNThUKzNrNXBB?=
 =?utf-8?B?ckF5MjU3Qk5GempvUTJ0TloxYnM0VUUyRlF0SWxKOEFhWm91dVlwZ1M3QThJ?=
 =?utf-8?B?NUUwZ2huT29ZMjlucGVRT2t5YXczV21CMHlzQTlWNWthSlFwLzFPVlNNZzk1?=
 =?utf-8?B?a2k2TW1XRnk5VFBETTVHZnJjMVFLSFpWUTRrSGthcEZXcHVUSGlzMW1HTDJ2?=
 =?utf-8?B?RUE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4412C3161976164CA65FD4114012966B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3oyUR3BbEtvn8gc1Ll4q5yP+EsxGr55xAutlDucb8JfKP/6JAuFC0nCa9GbI2VTACAR7A+ttHiHXgvyrS8hN2ddn1U0lGuSOVMLMZLZgdIsEeaZMd142xEzzpFcE+oF3oo9JzCMnspunPN7FEm6MusDJfA+ogKvMeQWPhbk0KEQh4vX9B5RzvH/NmojOMmozA79kCzbZYgJU8Qxli/E6HNjjshm4l4tO5jYZFxw5KR0z2ZqCKyvF9TEpWq0Z8qLor6MYhUwEYSmiJueI3G4jOUZzY8q8ocoj+UiTPrvWNswJc+OqTByiZvazVf3BSICmSSCnOMe4groB99FREICbOrewFaD92V6me4y+ELuCOKMBtrKbk8x9RnmlyFDPPIMxNIhnYPE8E/1p4uoyHwTVhZov4YJM40+t3L3sgJj+jy8H42VvtChF81OFovMeu0SM9aNAAQ6p5+clqS9gKclXPcM4WvNRJuLrjt7WvaDFbCcJOtiX4q/Sg3uiB8bxSnK+44djH+M4Pepo9Kroo8fqHKa0ET73PNioCiFsmtYorG7Q6o/tgsy92wLtInMrgYwSiwlZDomNJMKvUHyBZgT0shLM+JJbRDBMYt8RG39fbN1Ds9Gr0iCX/OUqXhtR3yha
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY1PR01MB1562.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0cbd4b9-fae0-4ae3-ee07-08dcdd38505f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2024 08:01:51.5970
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dVXx7S1NBeAp5Ajs4ql0tl4I0smlFYEL3vdmHpDSHKv11f0i+3L0Nr0P9g+7uqRgvB4v/iRtHxZ0GWzF/QC4oA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS7PR01MB11468

U29ycnkgZm9yIHRoZSBsYXRlIHJlcGx5LiAoTXkgY29tcGFueSdzIG1haWwgc2VydmVyIHRoYXQg
ZW5hYmxpbmcgdGhlIA0KRFJNQUMsIHNlZW1zIG5vdCB0byBkZWxpdmVyIHNvbWUgbWFpbHMgdG8g
bXkgaW5ib3gsIEkgaGF2ZSB0byBjaGVjayANCm1haWxzIGluIGxvcmUpDQoNCj4gT24gOS8yNC8y
NCAxNTo0NSwgTGkgWmhpamlhbiB3cm90ZToNCj4gPiBUaGUgcGZuIHZhbHVlIG5lZWRzIHRvIGJl
IHJldHJpZXZlZCBjb3JyZWN0bHkgd2hlbiBQYWdlVHJhbnNIdWdlKHBhZ2UpICAgDQo+IFdoZXJl
IHRoZSBwZm4gY291bGQgaGF2ZSBiZWVuIG1vZGlmaWVkIHdpdGgNCj4gcGZuID0gcGFnZV90b19w
Zm4oaGVhZCkgKyBjb21wb3VuZF9ucihoZWFkKSAtIDENCj4gU28gcmV0cmlldmluZyBmcm9tIHBh
Z2Ugd2lsbCBnZXQgdGhlIG9yaWdpbmFsIHBmbiB2YWx1ZSA/DQoNClllcywgdGhhdCdzIHRydWUu
DQppdCBzaG91bGQgcHJpbnQgdGhlIGFjdHVhbCBwZm4gdGhhdGZhaWxlZCB0byBpc29sYXRlLFxc
XCBUaGFua3MgWmhpamlhbg0KICANCg0KPg0KPg0KPiA+IGlzIHRydWUuIEZpeCBpdCBieSByZXBs
YWNpbmcgdGhlIHVzYWdlIG9mICdwZm4nIHdpdGggJ3BhZ2VfdG9fcGZuKHBhZ2UpJyA+IHRvIGVu
c3VyZSB0aGUgY29ycmVjdCBwZm4gaXMgcHJpbnRlZCBpbiB3YXJuaW5nIG1lc3NhZ2VzIHdoZW4g
DQo+IGlzb2xhdGlvbiA+IGZhaWxzLiA+ID4gU2lnbmVkLW9mZi1ieTogTGkgWmhpamlhbiANCj4g
PGxpemhpamlhbkBmdWppdHN1LmNvbT4gPiAtLS0gPiBtbS9tZW1vcnlfaG90cGx1Zy5jIHwgMiAr
LSA+IDEgZmlsZSANCj4gY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkgPiA+
IGRpZmYgLS1naXQgDQo+IGEvbW0vbWVtb3J5X2hvdHBsdWcuYyBiL21tL21lbW9yeV9ob3RwbHVn
LmMgPiBpbmRleCANCj4gMjY3OTBjOGQ1YjQzLi4wMDA0MzA0MDZhOWUgMTAwNjQ0ID4gLS0tIGEv
bW0vbWVtb3J5X2hvdHBsdWcuYyA+ICsrKyANCj4gYi9tbS9tZW1vcnlfaG90cGx1Zy5jID4gQEAg
LTE4MjksNyArMTgyOSw3IEBAIHN0YXRpYyB2b2lkIA0KPiBkb19taWdyYXRlX3JhbmdlKHVuc2ln
bmVkIGxvbmcgc3RhcnRfcGZuLCB1bnNpZ25lZCBsb25nIGVuZF9wZm4pID4gPiB9IA0KPiBlbHNl
IHsgPiBpZiAoX19yYXRlbGltaXQoJm1pZ3JhdGVfcnMpKSB7ID4gLSBwcl93YXJuKCJmYWlsZWQg
dG8gDQo+IGlzb2xhdGUgcGZuICVseFxuIiwgcGZuKTsgPiArIHByX3dhcm4oImZhaWxlZCB0byBp
c29sYXRlIHBmbiAlbHhcbiIsIA0KPiBwYWdlX3RvX3BmbihwYWdlKSk7ID4gZHVtcF9wYWdlKHBh
Z2UsICJpc29sYXRpb24gZmFpbGVkIik7ID4gfSA+IH0NCg0K

