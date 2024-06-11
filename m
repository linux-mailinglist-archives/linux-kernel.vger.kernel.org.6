Return-Path: <linux-kernel+bounces-210024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85699903E42
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:00:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 738FC1C25936
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 14:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFFA17E906;
	Tue, 11 Jun 2024 13:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O+Z/rUoS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="yfdmiHG5"
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A757217E902
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 13:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718114215; cv=fail; b=uyfGETuic9qzAKm31IYtuiLDeNRjAw7hMJU6BArOkQ5CjufCxg1IboMqZ/qDwXYrTFYDWDgAjUoToWigVmO3GICQ3uAvy+EiRnGH8oyM5A2f7htcFob4JrWU1jk5BxEL9mv9LsWefU/O84zrnlTxjeAdOh5/7jtUu17kfgBUcYM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718114215; c=relaxed/simple;
	bh=FMFmk9bdICZu+9tlY8p11bV+88HLBqw3rQLAGQxNC5Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FTqcSjYGhJeaG4IEuJlzLKA3C2waqi8xhXYYMdKOnskkA7ecJLrUoz+bDJptgyMkVQRiAl1le+6trAiNd1xwuUXrhH8kO2+HDD5I1W+PJqfNOX3HZrYaFftoJ7W9vZiqV880WGmwOyhy6TJJCV4x5Op0XGuDI8qDXmMJFkAdxvk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O+Z/rUoS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=yfdmiHG5; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45B7fWOE013482;
	Tue, 11 Jun 2024 13:56:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:references:in-reply-to
	:content-type:content-id:content-transfer-encoding:mime-version;
	 s=corp-2023-11-20; bh=FMFmk9bdICZu+9tlY8p11bV+88HLBqw3rQLAGQxNC
	5Q=; b=O+Z/rUoSJoMZWis8qOQwAzEy7elIi8z//DnDSxPWS7gryL33JcuawfvIg
	Y6DfjyAufWf+/MVvABgPIL9Tdgd+AnKPprbWdDqxXs+4GAev8kWUA/hKXqd8GvWG
	rvknEL0GLVy2C3kPNNX6nkJTqTRf+mz5zCg1wOAQ560ENKMU0oOAK7ul2brvqZ1t
	dKuKiANBbxU11jfrWcxBAPPvwIxMQLBEzM95pnz0UWZD/sFOUdu8K2r1o6LK6A/x
	HTchE8Z0zLmdEPSOzcfdxxo5KWalSp+BqqfgNbJPn1B7orfGX1Lo4+GtLhCAj2KZ
	PSQlrm9EcfgLgxagM0BHs5Urx8sGA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh7fmukt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 13:56:18 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45BDMNP1012419;
	Tue, 11 Jun 2024 13:56:17 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ync9wvrsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 13:56:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ehzmuT4xEGW4KRgPOgj6kOj8/B1zbjnlhBR4iFjUk8rN5PSHwNNvqGXp0+uJ94RDOmMiNKPclN7ZAofCdjvtPrF5jWdba4/WIHj57WlO8+lPibPKzwkO0cfZ1GiSwL1afHgJvncDYaiKbwPHl7a+Jv/ljqumMZkF395NNrZY/52B5c9gqbWAGQpyQkFL0pivYtd8INrr/r4HcdrocksTSblxZ6zaeQAMwBV5FMFZTSXFGkiK+8xwJTWhWt3gr1LqPvhgyQoBjkjOK6yxEXa7dsp7EVALVxFFJ7jrBlfqNmSf5pH2hP6VjIinkCTCAe2vFitYPb1EZ7C8sTdLcZMZEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FMFmk9bdICZu+9tlY8p11bV+88HLBqw3rQLAGQxNC5Q=;
 b=c8VMH0Phdgl4WBfdz2y7in+M8JQP2MnMirnnDSCkgcVfjJsuvGvtXouH8NMQduR7JpWvJ8guL8KqQrCXLc+sRmb99FjD674G29zQOrESpu3tz9ZqhDwQJUjjzJxF0SARn6919VS81wTBV+gvzrYR3R9jqJz6sXL+A5oVu8Tq4zLpu19JA8i01wOyiUC2HCXUNkbW2yHRasfk0ZbKgBWg04UYj9gVbrbAH5CetYZxJ5ITPoZEYvSyRh6ocVGAe0jv12Z0y7JjAV3OBN4rlxenSfFaS85fjHNQq30Gj89034xI/GMQterVh6LPV8DckqlA/nZ68oa0XMxbhAYr84lG4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FMFmk9bdICZu+9tlY8p11bV+88HLBqw3rQLAGQxNC5Q=;
 b=yfdmiHG5wIqPLIpYxjDYhu9evdCNMLvb5cVYUlItNQzDDT/T4Oov/augP1epGCRVdLAScctJQg78/V82ODDDYvA22AsSMqppzn3gDRKEZTiY8MUMX+HUxhYjv4N+Q+0I1GwIsZE0vpZAS839ujRupLPG6MU2B9blVVQrnZg2wVs=
Received: from CH3PR10MB7762.namprd10.prod.outlook.com (2603:10b6:610:1ae::7)
 by CH3PR10MB6786.namprd10.prod.outlook.com (2603:10b6:610:140::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.37; Tue, 11 Jun
 2024 13:56:14 +0000
Received: from CH3PR10MB7762.namprd10.prod.outlook.com
 ([fe80::136:7fd2:6a9f:b3d9]) by CH3PR10MB7762.namprd10.prod.outlook.com
 ([fe80::136:7fd2:6a9f:b3d9%7]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 13:56:14 +0000
From: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
To: "jeffxu@chromium.org" <jeffxu@chromium.org>
CC: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        Keith Lucas
	<keith.lucas@oracle.com>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas
 Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        Andrew
 Brownsword <andrew.brownsword@oracle.com>,
        Matthias Neugschwandtner
	<matthias.neugschwandtner@oracle.com>,
        "jeffxu@google.com"
	<jeffxu@google.com>,
        "jannh@google.com" <jannh@google.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "sroettger@google.com"
	<sroettger@google.com>,
        "jorgelo@chromium.org" <jorgelo@chromium.org>,
        "rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>
Subject: Re: Re [PATCH v5 1/5] x86/pkeys: Add PKRU as a parameter in signal
 handling functions
Thread-Topic: Re [PATCH v5 1/5] x86/pkeys: Add PKRU as a parameter in signal
 handling functions
Thread-Index: AQHauGKPMqfEFa2lWkaUJq1oDLFgSbHBik4AgAETHwA=
Date: Tue, 11 Jun 2024 13:56:14 +0000
Message-ID: <2BA1926A-8720-4B85-8D15-557CB9A8464E@oracle.com>
References: <20240606224035.3238985-2-aruna.ramakrishna@oracle.com>
 <20240610213122.3377462-1-jeffxu@chromium.org>
In-Reply-To: <20240610213122.3377462-1-jeffxu@chromium.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.600.62)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR10MB7762:EE_|CH3PR10MB6786:EE_
x-ms-office365-filtering-correlation-id: 2efbf328-936c-45bd-2830-08dc8a1e424b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230031|1800799015|366007|7416005|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?U0RhRjhpTGc1aWhLejJoNjFaODdEaUd1K2pkS3FXWGtpU2VqY2JuLzRubC95?=
 =?utf-8?B?bWFCV1c1eFBBcTFadEpGdHJlbnYrL012YTJuSTE4V0xzeW95T0I1ZFJVVTFm?=
 =?utf-8?B?WU1sM2RPUXQwUHF0RDVxWk84ZVdmeVVSWjVodFB6VDhTVkdUbWpkYzFIM3Jm?=
 =?utf-8?B?bjFSMERiSXFnVXNtSG5kUTcyUlB0cDNzeVVkcWhPMnJYazZXSUcxWllHWnFR?=
 =?utf-8?B?NERNaWtya0RwRU90VStnMkxiT1RKNlcxWm4wRHhzUnZNSFY0QVpCK0xqRm8x?=
 =?utf-8?B?WEtFQTc1dVNraDVkblFJNTc5ckx5elZ4R2tlZG5maGdNQSsvaHlrM0RRT1NO?=
 =?utf-8?B?R1pUVC83WWZYYk95aHZIaldJQlRPcjRzeXFwZys2eVBkNndDMVpEUHE5Q2tO?=
 =?utf-8?B?amppaWV2TVpQVk5MWTJta211d1N1SUF2dEM1ZGVhUm85NTgrWktUNVREeC8x?=
 =?utf-8?B?L2lmZ2UwTEVITFJXb0JXVGd3RzRhMlNGaTdYU1BnZGVUKzl0dGZqN3hTdmJ6?=
 =?utf-8?B?VTdlSEVRQmJXQ2V2dWo0aGo4cFB5YWV1TzZYamJoWFlwbEpLSEt4eU1VZ1hl?=
 =?utf-8?B?K1lnTU5TTHFabkltWHNyQ2lrWG5MZ3gvWW9hM25sZnJhTFdPcUdOSmlqTG5C?=
 =?utf-8?B?V2drcWpDcGIzMDNiL1ZFckM4bGgwOUxwV21yVVNIZEV1Wko3TnFjN1ptbjZO?=
 =?utf-8?B?UzB0K0ZvaTVZYk0xSVF3bFE5ZTd3WUpPbnFuSEJQSElJaWJ4RUpNdTE1T2VF?=
 =?utf-8?B?ZU5GSUMxdmVFMmZVMDBxRjFFOXliUkhTT2pDWmowczlmdnBBMGtSR1F1cUNF?=
 =?utf-8?B?ZU56Z1VURWdBRm9TMldOL0FRTytyc2tmZ2xPV3d5V0tLYjV1VXd4dC9mL1Nu?=
 =?utf-8?B?ZlZBdWpCVDJvSEhoODVRNDZDS045bkEwTzlKMUdtMTgyUHN2NytSazFySjdn?=
 =?utf-8?B?aGR6ZmNlS3g0WFFDaHlwcnlpSmpscFpqcUpCNHhEek04Q2UvUFJzbXdaUzRx?=
 =?utf-8?B?dWVjdUNqSEduenR6Zk9FUUdoOGFNQTRqcVZ6Y1U1ODlNUVR1VXlqRXNFZGFt?=
 =?utf-8?B?YktRUEFmeWZ4R0NIMy96R3BaNitjV0RFU0ovUlNWWjJaK0JRNFRvTmJGNHZu?=
 =?utf-8?B?N3MzMDRFVzdVYnVKOWtiMk93YXhmazNkVXFFOGd6RTF6blQyYXllRktXK2Fw?=
 =?utf-8?B?OWZFZ1JLSFZPaGVoYnFKR1ZkM2tsQXM5VUNOTWVkU3hTblFFMXZNalR2RVJw?=
 =?utf-8?B?UktwUEU4S0loZmsvTnUxc0FxOFhCUGlORXdaRWd4cXNKM0tBa2RuR3FGR3hP?=
 =?utf-8?B?NHg2dUt4RlVXSGhTaDUrU0g3SkRiYmJXZStvQ0lxVVBzb0RydVliaXlzTVcv?=
 =?utf-8?B?bzJQUFRJVVM3MEo1VXJGTVhHQ2pOSkxYMnExSit5TndGYVZ0My9yWXErUjg4?=
 =?utf-8?B?TnBKQTJ0eDNZOEVzUDY5djY0N3VmSjBGRjJHSWdvdnNrNDQyOUtCd3ZVZnlV?=
 =?utf-8?B?YmVURjRIZU5aWGdVRC9BS3VRRkxvblNReDRIbnFDSldLb3lncGg1QTlpZEZ5?=
 =?utf-8?B?MXErRkdjMkhhbk80TXBoTVZSVG1iWjFidzMxZVNTMU9hVWhtaFhSTEw0eEZS?=
 =?utf-8?B?R1FXQTdXNDFkNzIrYXF6RFpoWVh1U0VuRlkrWUhQdEFObVJWVVpCZnYveGty?=
 =?utf-8?B?NFV1UTM0VHBFYTY0bm5MNjF1UCtsdWd3eStnNUNBR1lyN2JIeEJoK1ZscHJh?=
 =?utf-8?B?UEkyWUhPajJQZUNncHdoTkZCRHR0M1RvM2xVdUphMDNXcUxnVUZzdVBscmp5?=
 =?utf-8?Q?lFQISwf8RQusN9B9U11vbZOI8lZnro0Kurojg=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7762.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(7416005)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VkFYL3NkSXFGRmFRQTlTMERic0NwSXBHeDRqNFU4aEZxMUlpV09zMHgzdjlz?=
 =?utf-8?B?V29jckw3V0MzdVRJSDNOd1lUSjNiUnJlbGJnMGdnN1BvaWI4MDE2RFo2S0NS?=
 =?utf-8?B?NzY1K3Rvcjg5MncyQUViTi9ldEVmZmlHM04wQU53OGUzdzdDWkUrWk1IYm1J?=
 =?utf-8?B?eGpOZ1ByUFRzZ1ZsUU4xL3pQYVgrSFcyNThQeDE1dmIzTkRNTm5tVlpwWHRW?=
 =?utf-8?B?am9NbDhHM2R6SXlRemN6NFM2dDQvRC8waGV0RHNlbkkzUVNjaGFIbmpmSUVh?=
 =?utf-8?B?MEFRYUZtdVVpTEJjcnl0NUhJZXltVmpDUk5OMld0T3NKR0xzREZnVG00YnJj?=
 =?utf-8?B?c2pxRkRTZXJqS2grcmgzTm83dXk1ZHlWOElUNk5IUW1PR04yNGQ5aVo5YzZF?=
 =?utf-8?B?TDRiYnV3ZSs3djZmSUJEa2FoZnpBUzhSdlAyOHltSWV1OE9YSmNlREZWSmRo?=
 =?utf-8?B?VzRnRjdHM2FnYmM2cDV5RGhaMmNybHNpNVMxYlRpWkNKcnpocTVSdmZQM2J3?=
 =?utf-8?B?T0lXL0QxeGQ2MU56QmZaSUZaUUhqUDdnVHZzaWE3OWtxYkpHOEhMVkx4SU5w?=
 =?utf-8?B?WkxPQno5bEhWdWtidi9Ea2ZUSlBJQThCSzZtcURZdThqbUhlRUhTYlY3OWpw?=
 =?utf-8?B?Z0tESGdPbXlhbHJPalBnU1RNS1hRTjF2WVVWV1NtczVodnEvMDVGeExFOU9L?=
 =?utf-8?B?YURIckw1MXlNWDIyMXVtSFRlQWhPRE45Y0haNXkzUllWanQ2aisrcWllL3dv?=
 =?utf-8?B?RTNXZ1BoTjdJQzVJZFRwU1JXdEViaDBpb1J1SXA4dmFVR3RseWtYRVBMbFZ6?=
 =?utf-8?B?NmRjbnNQOTdNVE9iSUliS2lvR1BBTlFvV1pXNlFKNTl1dWFKTUhrTkNkVlJW?=
 =?utf-8?B?RHBlL0E2eFpzb0VEVnVqVjJsd0x5VjdmYzNuNWVhc1pSWG5GamR4NzRkeGRa?=
 =?utf-8?B?dC9FaVU1TG5VN2V5YkUzSkdSVXlEWUtoQWZZbE96VUhxdjRuUGZKMFFmdTMr?=
 =?utf-8?B?TXRsY1JZQjNtQ1Bnb0w0eTFaM2VRZDFSVjVTSXZwZzBuVXI1NVU0dTYweGky?=
 =?utf-8?B?S0JSS3ZHSC9ta2JzL1lhTTNVYUNnM2JTSWlkRTE1ZUhBVS9wbjJQK3N4V2E3?=
 =?utf-8?B?VGZoZmZ6dEVCV3dqVEx0SFRyWmpZelY3NTZxQlJ5d1F1eTRWSitycTdlMXN6?=
 =?utf-8?B?dmN2dkpPZEdFNlkvQklZbVAzaDR3SlRpZ3BpZkgrK1piSG9iMmZZcHZ6MGpu?=
 =?utf-8?B?ZXhoRExDdGo3R1lVVThqYUF4WDZSY2xlODBmT3NPeU5nZEM4bkhpSU9rSGdq?=
 =?utf-8?B?RlpRNUxIWHNvRmlla0oyTFVSRkNVL3ptajFsb0J0NEJ2NWtkTCtBM1RIcUp1?=
 =?utf-8?B?WUNwdlNsWlFMWXhTb3p5QThYMEdlQzEvUWV4YWxWeFZnS0oyU0JraCszdGVl?=
 =?utf-8?B?OGQwMy9CbnJPY2V3OGVDaVY5dG0zRnY3WFdSNHppd0kxSzlNcExNblE2dmJu?=
 =?utf-8?B?MjNZdUkzNzR2K3ZMejcrZWxMdm03WXdiNFUzT1EyM0pZa1Nmc1RQaUticGtP?=
 =?utf-8?B?dUlTeEJxQnRyRlJrSFh1elFDVk9tM3VGV1REQy8zQmRMRW5nSFY0dnNGeGpy?=
 =?utf-8?B?eS93aElFN0taVmtia2tMRHg0L3VtcUZQZzFXR3pUU1ZPWEJZQWsyMVYxRmkv?=
 =?utf-8?B?T0tPOVhuNUZLdkdubWx4bjMzREZEakRDRTl5dndVRzRkclhuTS8zaEkwVVRJ?=
 =?utf-8?B?NXZPL3ZHSnM2RUtaZ1hZdmpkS1B2c3N6TklHbVJBbTNxUUtORVlPWDJNSGpq?=
 =?utf-8?B?RHVZR3dMUUdmY1NXb0FFeUNSdHNyeHF3cStsTzlVSG1TOCs3azcxdUhDUE1t?=
 =?utf-8?B?OU9SRFhRL3krL0ZXNTdsc0VPOTIyUTN2Y1RJaDM3dkhaUHB4L3pzTnNraitz?=
 =?utf-8?B?QjRhS2FvRndZZmM5MjRuOVNVbEhjZmZueFcyRFFlRit5SWdzUS85YzlyT25N?=
 =?utf-8?B?dWxaWEJPQzNUcHFDVmJQTDEyMVUzYmg0ZVM5SWk1eXdqa0RhOU1wdzRNRVpL?=
 =?utf-8?B?RzVOQ1BnaGpFUSt2ZEIxMXJGT2MxcTdQbWtMQkhMSnFoeG4xSzl1QTdsbHFu?=
 =?utf-8?B?Y0ZJZEpmLzkyYVlRcC9qQldSd1o0eUpjQU9LYTRDd2FLdkx5K0QvUnVKZzBQ?=
 =?utf-8?B?VHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <61772DEBEAE53940B0D078070C418797@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	w/ThpOIxsZJEfZ3wyN45mMsjm9Gl3wwKxofnQB+yu5RzQNd4dRonGUSqrXQyXu8VPmiFtls4aKGzI+tpArBX6z0QG+OZpvm9w2GgeVX+bzQ5FdIjrYnKZUsUv1rQvrKsu7migmLyN8tprYjQ/Mn+JiqdsHiEimRgsnXuP0K62m+qCyAoI9kE5PKwsNBPZMRA9WybARddMisd/alQOFWr0aBpZNpe8y6htGgBFwc70jsmFK/jmOyDYUecx+YZBB1VMJ25Le5epvhmB1xGLDDDaZ4CoRsnlaw6dtr3cRGMAJLN2kxvwrIHulrlVEBI/z+qySowE189OibfQZrYk9yhT92GgZSABNMde8r8qaCkaX3uOK4/RhnnKpB3n257kC2S/a8iseXlsVaVRmMplr/bNIkLEAhc8ZILhzpa1k+Ul5o95b1kVP4Sre1dtZZts1eHT0lOretTPSFcQvk0EWb1E6bduun6/07F7+5lHNVOpZ4CfbP89P3EzYofzPKdDEjaQjBOh4w2oxkCJFxQGfNTvqCcWpS0N3aXF64hHJn2rcjXju1GkL0WRbQwyyn+wOQD6ABQ17fkFCf2ICdTpg6Uyq36+lH4bkPOtByvlYyiEHU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7762.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2efbf328-936c-45bd-2830-08dc8a1e424b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Jun 2024 13:56:14.5511
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TLw7XRl4tnB08SA34Z6VJAQjBa9ZnjPpBm+Z6K9a3f1l9BfYVidfrl/hfXJLrgMVjsqdhn92qwqRN4lm6cLerZNsrYISZvrzX9OHPfV3/n0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6786
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_07,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 phishscore=0 suspectscore=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406110101
X-Proofpoint-GUID: d2P6qtpRZwBXzyJdK9fKGxWSo9DD8Cnl
X-Proofpoint-ORIG-GUID: d2P6qtpRZwBXzyJdK9fKGxWSo9DD8Cnl

DQoNCj4gT24gSnVuIDEwLCAyMDI0LCBhdCAyOjMx4oCvUE0sIGplZmZ4dUBjaHJvbWl1bS5vcmcg
d3JvdGU6DQo+IA0KPiBPbiBUaHUsIEp1biAwNiwgMjAyNCBhdCAxMDo0MDozMVBNICswMDAwLCBB
cnVuYSBSYW1ha3Jpc2huYSB3cm90ZToNCj4gDQo+PiBkaWZmIC0tZ2l0IGEvYXJjaC94ODYvaW5j
bHVkZS9hc20vc2lnaGFuZGxpbmcuaCBiL2FyY2gveDg2L2luY2x1ZGUvYXNtL3NpZ2hhbmRsaW5n
LmgNCj4+IGluZGV4IGU3NzBjNGZjNDdmNC4uZGU0NTgzNTRhM2VhIDEwMDY0NA0KPj4gLS0tIGEv
YXJjaC94ODYvaW5jbHVkZS9hc20vc2lnaGFuZGxpbmcuaA0KPj4gKysrIGIvYXJjaC94ODYvaW5j
bHVkZS9hc20vc2lnaGFuZGxpbmcuaA0KPj4gQEAgLTE3LDExICsxNywxMSBAQCB2b2lkIHNpZ25h
bF9mYXVsdChzdHJ1Y3QgcHRfcmVncyAqcmVncywgdm9pZCBfX3VzZXIgKmZyYW1lLCBjaGFyICp3
aGVyZSk7DQo+PiANCj4+IHZvaWQgX191c2VyICoNCj4+IGdldF9zaWdmcmFtZShzdHJ1Y3Qga3Np
Z25hbCAqa3NpZywgc3RydWN0IHB0X3JlZ3MgKnJlZ3MsIHNpemVfdCBmcmFtZV9zaXplLA0KPj4g
LSAgICAgdm9pZCBfX3VzZXIgKipmcHN0YXRlKTsNCj4+ICsgICAgIHZvaWQgX191c2VyICoqZnBz
dGF0ZSwgdTMyIHBrcnUpOw0KPj4gDQo+PiAtaW50IGlhMzJfc2V0dXBfZnJhbWUoc3RydWN0IGtz
aWduYWwgKmtzaWcsIHN0cnVjdCBwdF9yZWdzICpyZWdzKTsNCj4+IC1pbnQgaWEzMl9zZXR1cF9y
dF9mcmFtZShzdHJ1Y3Qga3NpZ25hbCAqa3NpZywgc3RydWN0IHB0X3JlZ3MgKnJlZ3MpOw0KPj4g
LWludCB4NjRfc2V0dXBfcnRfZnJhbWUoc3RydWN0IGtzaWduYWwgKmtzaWcsIHN0cnVjdCBwdF9y
ZWdzICpyZWdzKTsNCj4+IC1pbnQgeDMyX3NldHVwX3J0X2ZyYW1lKHN0cnVjdCBrc2lnbmFsICpr
c2lnLCBzdHJ1Y3QgcHRfcmVncyAqcmVncyk7DQo+PiAraW50IGlhMzJfc2V0dXBfZnJhbWUoc3Ry
dWN0IGtzaWduYWwgKmtzaWcsIHN0cnVjdCBwdF9yZWdzICpyZWdzLCB1MzIgcGtydSk7DQo+PiAr
aW50IGlhMzJfc2V0dXBfcnRfZnJhbWUoc3RydWN0IGtzaWduYWwgKmtzaWcsIHN0cnVjdCBwdF9y
ZWdzICpyZWdzLCB1MzIgcGtydSk7DQo+PiAraW50IHg2NF9zZXR1cF9ydF9mcmFtZShzdHJ1Y3Qg
a3NpZ25hbCAqa3NpZywgc3RydWN0IHB0X3JlZ3MgKnJlZ3MsIHUzMiBwa3J1KTsNCj4+ICtpbnQg
eDMyX3NldHVwX3J0X2ZyYW1lKHN0cnVjdCBrc2lnbmFsICprc2lnLCBzdHJ1Y3QgcHRfcmVncyAq
cmVncywgdTMyIHBrcnUpOw0KPiANCj4gRG9lcyBpYTMyIHN1cHBvcnQgUEtFWSA/IEkgdGhvdWdo
dCBpdCBpcyBYNjQgb25seS4NCj4gSXQgbWlnaHQgYmUgcG9zc2libGUgdG8gbm90IHRvIGNoYW5n
ZSBhbnkgb2YgaWEzMiBjb2RlLg0KDQpGcm9tIHRoZSBJbnRlbCBtYW51YWwsIGl0IGRpZCBub3Qg
c2VlbSB0aGF0IHBrZXkgc3VwcG9ydCB3YXMgeDY0IG9ubHkuDQoNCj4gDQo+IA0KPj4gDQo+PiAj
ZW5kaWYgLyogX0FTTV9YODZfU0lHSEFORExJTkdfSCAqLw0KPj4gZGlmZiAtLWdpdCBhL2FyY2gv
eDg2L2tlcm5lbC9mcHUvc2lnbmFsLmMgYi9hcmNoL3g4Ni9rZXJuZWwvZnB1L3NpZ25hbC5jDQo+
PiBpbmRleCAyNDdmMjIyNWFhOWYuLjJiM2I5ZTE0MGRkNCAxMDA2NDQNCj4+IC0tLSBhL2FyY2gv
eDg2L2tlcm5lbC9mcHUvc2lnbmFsLmMNCj4+ICsrKyBiL2FyY2gveDg2L2tlcm5lbC9mcHUvc2ln
bmFsLmMNCj4+IEBAIC0xNTYsNyArMTU2LDcgQEAgc3RhdGljIGlubGluZSBib29sIHNhdmVfeHN0
YXRlX2VwaWxvZyh2b2lkIF9fdXNlciAqYnVmLCBpbnQgaWEzMl9mcmFtZSwNCj4+IHJldHVybiAh
ZXJyOw0KPj4gfQ0KPj4gDQo+PiAtc3RhdGljIGlubGluZSBpbnQgY29weV9mcHJlZ3NfdG9fc2ln
ZnJhbWUoc3RydWN0IHhyZWdzX3N0YXRlIF9fdXNlciAqYnVmKQ0KPj4gK3N0YXRpYyBpbmxpbmUg
aW50IGNvcHlfZnByZWdzX3RvX3NpZ2ZyYW1lKHN0cnVjdCB4cmVnc19zdGF0ZSBfX3VzZXIgKmJ1
ZiwgdTMyIHBrcnUpDQo+PiB7DQo+PiBpZiAodXNlX3hzYXZlKCkpDQo+PiByZXR1cm4geHNhdmVf
dG9fdXNlcl9zaWdmcmFtZShidWYpOw0KPj4gQEAgLTE4NSw3ICsxODUsNyBAQCBzdGF0aWMgaW5s
aW5lIGludCBjb3B5X2ZwcmVnc190b19zaWdmcmFtZShzdHJ1Y3QgeHJlZ3Nfc3RhdGUgX191c2Vy
ICpidWYpDQo+PiAgKiBGb3IgW2ZdeHNhdmUgc3RhdGUsIHVwZGF0ZSB0aGUgU1cgcmVzZXJ2ZWQg
ZmllbGRzIGluIHRoZSBbZl14c2F2ZSBmcmFtZQ0KPj4gICogaW5kaWNhdGluZyB0aGUgYWJzZW5j
ZS9wcmVzZW5jZSBvZiB0aGUgZXh0ZW5kZWQgc3RhdGUgdG8gdGhlIHVzZXIuDQo+PiAgKi8NCj4+
IC1ib29sIGNvcHlfZnBzdGF0ZV90b19zaWdmcmFtZSh2b2lkIF9fdXNlciAqYnVmLCB2b2lkIF9f
dXNlciAqYnVmX2Z4LCBpbnQgc2l6ZSkNCj4+ICtib29sIGNvcHlfZnBzdGF0ZV90b19zaWdmcmFt
ZSh2b2lkIF9fdXNlciAqYnVmLCB2b2lkIF9fdXNlciAqYnVmX2Z4LCBpbnQgc2l6ZSwgdTMyIHBr
cnUpDQo+PiB7DQo+PiBzdHJ1Y3QgdGFza19zdHJ1Y3QgKnRzayA9IGN1cnJlbnQ7DQo+PiBzdHJ1
Y3QgZnBzdGF0ZSAqZnBzdGF0ZSA9IHRzay0+dGhyZWFkLmZwdS5mcHN0YXRlOw0KPj4gQEAgLTIy
OCw3ICsyMjgsNyBAQCBib29sIGNvcHlfZnBzdGF0ZV90b19zaWdmcmFtZSh2b2lkIF9fdXNlciAq
YnVmLCB2b2lkIF9fdXNlciAqYnVmX2Z4LCBpbnQgc2l6ZSkNCj4+IGZwcmVnc19yZXN0b3JlX3Vz
ZXJyZWdzKCk7DQo+PiANCj4+IHBhZ2VmYXVsdF9kaXNhYmxlKCk7DQo+PiAtIHJldCA9IGNvcHlf
ZnByZWdzX3RvX3NpZ2ZyYW1lKGJ1Zl9meCk7DQo+PiArIHJldCA9IGNvcHlfZnByZWdzX3RvX3Np
Z2ZyYW1lKGJ1Zl9meCwgcGtydSk7DQo+PiBwYWdlZmF1bHRfZW5hYmxlKCk7DQo+PiBmcHJlZ3Nf
dW5sb2NrKCk7DQo+PiANCj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni9rZXJuZWwvc2lnbmFsLmMg
Yi9hcmNoL3g4Ni9rZXJuZWwvc2lnbmFsLmMNCj4+IGluZGV4IDMxYjZmNWRkZGZjMi4uOTRiODk0
NDM3MzI3IDEwMDY0NA0KPj4gLS0tIGEvYXJjaC94ODYva2VybmVsL3NpZ25hbC5jDQo+PiArKysg
Yi9hcmNoL3g4Ni9rZXJuZWwvc2lnbmFsLmMNCj4+IEBAIC03NCw3ICs3NCw3IEBAIHN0YXRpYyBp
bmxpbmUgaW50IGlzX3gzMl9mcmFtZShzdHJ1Y3Qga3NpZ25hbCAqa3NpZykNCj4+ICAqLw0KPj4g
dm9pZCBfX3VzZXIgKg0KPj4gZ2V0X3NpZ2ZyYW1lKHN0cnVjdCBrc2lnbmFsICprc2lnLCBzdHJ1
Y3QgcHRfcmVncyAqcmVncywgc2l6ZV90IGZyYW1lX3NpemUsDQo+PiAtICAgICB2b2lkIF9fdXNl
ciAqKmZwc3RhdGUpDQo+PiArICAgICB2b2lkIF9fdXNlciAqKmZwc3RhdGUsIHUzMiBwa3J1KQ0K
Pj4gew0KPj4gc3RydWN0IGtfc2lnYWN0aW9uICprYSA9ICZrc2lnLT5rYTsNCj4+IGludCBpYTMy
X2ZyYW1lID0gaXNfaWEzMl9mcmFtZShrc2lnKTsNCj4+IEBAIC0xMzksNyArMTM5LDcgQEAgZ2V0
X3NpZ2ZyYW1lKHN0cnVjdCBrc2lnbmFsICprc2lnLCBzdHJ1Y3QgcHRfcmVncyAqcmVncywgc2l6
ZV90IGZyYW1lX3NpemUsDQo+PiB9DQo+PiANCj4+IC8qIHNhdmUgaTM4NyBhbmQgZXh0ZW5kZWQg
c3RhdGUgKi8NCj4+IC0gaWYgKCFjb3B5X2Zwc3RhdGVfdG9fc2lnZnJhbWUoKmZwc3RhdGUsICh2
b2lkIF9fdXNlciAqKWJ1Zl9meCwgbWF0aF9zaXplKSkNCj4+ICsgaWYgKCFjb3B5X2Zwc3RhdGVf
dG9fc2lnZnJhbWUoKmZwc3RhdGUsICh2b2lkIF9fdXNlciAqKWJ1Zl9meCwgbWF0aF9zaXplLCBw
a3J1KSkNCj4gDQo+IFlvdSBtaWdodCBmaW5kIHRoYXQgd2Ugb25seSBuZWVkIHRvIHVwZGF0ZSBQ
S1JVIHJpZ2h0IGJlZm9yZSBjb3B5X2Zwc3RhdGVfdG9fc2lnZnJhbWUsDQo+IHNvIG5vIG5lZWQg
dG8gcGFzcyBwa3J1IGFsbCB0aGUgd2F5IGZyb20gdG9wLg0KPiANCg0KVGhlIFBLUlUgaXMgdXBk
YXRlZCBpbiBjb3B5X2ZwcmVnc190b19zaWdmcmFtZSgpLCByaWdodCBhZnRlciB4c2F2ZV90b191
c2VyX3NpZ2ZyYW1lKCkuDQpCdXQgdGhlIGNvZGUgdGhhdCBkZWNpZGVzIG9yIGNhcmVzIGFib3V0
IHdoYXQgcGtydSBpcyB3cml0dGVuIHRvIHRoZSBzaWdmcmFtZSBpcyBoYW5kbGVfc2lnbmFsKCks
IHNvDQppdCBzZWVtZWQgY2xlYW5lciB0byBkbyB0aG9zZSBjaGVja3MgdGhlcmUgYW5kIHBhc3Mg
aW4gcGtydSBhcyBhIHBhcmFtZXRlciBkb3duIHRoZSBzdGFjay4NCg0KVGhhbmtzLA0KQXJ1bmE=

