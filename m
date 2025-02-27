Return-Path: <linux-kernel+bounces-537382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF500A48B2A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 23:16:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8BCF3B61DE
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 22:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 570B1270EB4;
	Thu, 27 Feb 2025 22:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="uzpPr5Zn"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C65053E23;
	Thu, 27 Feb 2025 22:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.156.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740694566; cv=fail; b=gkvGAiRDO/hltnAm/hIp0kDDfcLD4HM/iH9x46cMOA9irxaev5rjh4tyXT8q5xn3/tbWF4TB8p+q5fh3i8S7YAtqhh4UU9t3/Sg3wa5RMXFPgtshqMJQRUPW3hfZn7+nZHo7ClKtkGag93cNX/U0NBRR+vtkKi/vm1+jzUAQcMI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740694566; c=relaxed/simple;
	bh=GIiLJlnze/gRpgbGH5S0yRWcqjGxONIlwtOlnbpL1aQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 MIME-Version:Content-Type; b=iX2tTnYkg2hWKMg0LLrqF96p2p2/TvsdX6s7yjWzgSbLZvm1O++3/YuxFIrsF3g3ySeujKG7XbnwXZfwh0vMIDLBpkpwVUvuPwoBXgvjlZWf4+tUuVO0rwTGtu0MNoPjaox7olHziXX+hVwMsgb5mdABpk6iA8TvRl+6FbH5TsA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=fail (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=uzpPr5Zn reason="signature verification failed"; arc=fail smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51RLUuXY020527;
	Thu, 27 Feb 2025 13:59:01 -0800
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 452vpv0g0c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 13:59:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uhZmVB2i6zwuZRjUkei3mYAe4Ne3929i6poBcXyYOoanBv0JNSk6Mxkh+gFGUeUQP26IqYIR/0ST2Y5Cl2lxoXkTSfp44IdS9Ywi+183kFnqxNz4JlysiSjbSOVaLADF+19wpVp3fxmv17Jr4IY2VJJpbE+Wuf4wGNjviAE7yaVVnYfeRzuQX2V8s9NnaXSKXA8kpD1sVsDRYY4/w2npBBRv8E0Q1fQ3Ri6A5SqcBiVdFZ8SdZ5FLD8lxTcW7RciH1Dd2ykTFIOsCTOS2KxbzmiqXeZRjJrmXa3CeN0HczfuyH8V/wsCKoFKThyyW3OeYCHkfuHbfHohmIKgmwcJpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mUjRZQBpYRMsMHHFyYHh7ziTfdbheMBBmpNt9jz83/A=;
 b=YGXuBpkGKwiYXHbkkbIZV9hjKnh9G0tdNlxSfTrLRgvEozhRZYlsC3VP6rmQFK26PYR5GHRm7XfDdyAKe1QTtuKH8mZFcTqfT4nbCJPwSO9xEf/fIbqFx/PkC5CoAq4nT6grHGFEqfb5zEPgCBXEX+0Tn3tCw5OmZ4vhrmb1Xlptx/3TmH/akAJtYGZFfdFHDHlSTz4/jYeyqDiDZSU2a2Q02+ltCTvViMke+8CXo1EP8yhrmqUwMjZDuhrFVdBKGDF8IxyZPTujqPB5vjfgb3RWdMWpWgt0d1dQbFEivWlOVSkYyyYH7l8AJzqwo8YyFP+2z7dHNc2weAr3lgkaQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mUjRZQBpYRMsMHHFyYHh7ziTfdbheMBBmpNt9jz83/A=;
 b=uzpPr5ZnCKlL1eDxx6xs6EYXmiIi8m4R4tbA0Ns2HifI9WfKVhgMWI0j2PtZYhBm/GB32v1LAE9ZfleZjxSRPfDJXuvNKG3WeD6xbfvRl1dy0ehWOrR7pE2Mm/qy3ugc1k9/oH1fwZQQb4VOU9hBIeBckp4reUFQnEsaHqE5gzg=
Received: from BY3PR18MB4673.namprd18.prod.outlook.com (2603:10b6:a03:3c4::20)
 by DM4PR18MB4335.namprd18.prod.outlook.com (2603:10b6:5:39b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Thu, 27 Feb
 2025 21:58:59 +0000
Received: from BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5]) by BY3PR18MB4673.namprd18.prod.outlook.com
 ([fe80::fbd6:a3a:9635:98b5%5]) with mapi id 15.20.8489.021; Thu, 27 Feb 2025
 21:58:59 +0000
From: Wilson Ding <dingwei@marvell.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        Sanghoon Lee <salee@marvell.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "gregory.clement@bootlin.com"
	<gregory.clement@bootlin.com>,
        "p.zabel@pengutronix.de"
	<p.zabel@pengutronix.de>,
        Geethasowjanya Akula <gakula@marvell.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andrew@lunn.ch"
	<andrew@lunn.ch>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>
Subject: RE: [EXTERNAL] Re: [PATCH v3 1/3] dt-bindings: reset: Add Armada8K
 reset controller
Thread-Topic: [EXTERNAL] Re: [PATCH v3 1/3] dt-bindings: reset: Add Armada8K
 reset controller
Thread-Index: AQHbiU1k6RN9NOXhEEKkKsof8xm437NbmJSAgAAZ9AA=
Date: Thu, 27 Feb 2025 21:58:58 +0000
Message-ID:
 <BY3PR18MB467346EB1FA7CEF0A3300350A7CD2@BY3PR18MB4673.namprd18.prod.outlook.com>
References: <20250227192536.2426490-1-dingwei@marvell.com>
 <20250227192536.2426490-2-dingwei@marvell.com>
 <174068786548.161165.4348563654300627455.robh@kernel.org>
In-Reply-To: <174068786548.161165.4348563654300627455.robh@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY3PR18MB4673:EE_|DM4PR18MB4335:EE_
x-ms-office365-filtering-correlation-id: bc0bbafa-8fb2-48fd-7b83-08dd5779f04e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?QzMyR0RMTnNkWW4wSkRLeVRSaklvSm5vSHNJczgwcGQxUm9kdWtaeEQ0TDJR?=
 =?utf-8?B?ejZBZkliNVlUU3M2SmdqUlJ3OEZSZkhoVkJ4OTBEM1VWY3JmTkN0UHdESlcz?=
 =?utf-8?B?WnZTcjRoOEdISUx5OUdpcGt2Tjd1MGVwZkJHOXZlVkd6MlV3M2pDU2F3Rlh4?=
 =?utf-8?B?dXZDL25Yb01JbEo4UzhzVDltK1hIdUdONURFc0pTRFBCYnNUK2k3cEU3NVp4?=
 =?utf-8?B?aW9xZlZIZ0dKUEJDQVluakVDdHRVOVR0REViZ0VpZWNmR2lMRXp5SDZDd1lu?=
 =?utf-8?B?NStnMktSajZFYWZ4aHQ1Q2Nza0xmNS9xZ0ZsL2JmTmMzTCtpeUNOSVpBTEF4?=
 =?utf-8?B?Z0tBdEFybGlRT1Jac2E0ZTVKTzl5dk5TS3BJSlBoYURSdWVzRmZieWJweWpI?=
 =?utf-8?B?QTlKRk11VTVvMENmSUNCWEZ4UmRubFdTSHpwSkVXN0tiUGQzbTA0Tmo3R1FY?=
 =?utf-8?B?V05pOUNUME9NVHp2WDZxNVNoOGtBRUd0M3ZKZUdjdWxnbFdsN0h0TWxKTzNM?=
 =?utf-8?B?QXNCVjRtY3NiRldUNmgydEFBWmZvT1RFMDVqcXFOYzRJUzVoTHUvYnVkYzZ0?=
 =?utf-8?B?UUVLL2FSNGdpN1l1UTNYMU5nQTdlVzRZbjY0MEtyM2dTZFpxeUpxV3dyS0sv?=
 =?utf-8?B?S29adUJ6U1R4bUllc3ZoTmRuTnpmNUtZRjdDZ3ErbDEzTjBnU3RKWXNXVWVv?=
 =?utf-8?B?NjhCNURYN3pZWW4vT25YZ0dtQlpablNRTkJVdUFxYytGdlZ1NXdpOE14Rnl4?=
 =?utf-8?B?YVpOd054ZVRBeXBYYmhwRnIrVnFaU3htTURRR3pyM2NqNys4YnJIS0xSd29I?=
 =?utf-8?B?Q0RvRjR4RXNyeWZzRWxSV01CKytoeVE5K0RYRDEvQWRuK0oyMzNmdWQyVkZ5?=
 =?utf-8?B?L1ZaWUY3bElNcWRDZ2k0MXpiU1hqUjFiZk1ST3V6RVl3aFVqRkszMlVXYUdX?=
 =?utf-8?B?dGNEWlNhRWVVd0FXNS9HZnByL1VzY1RpRGZWanlXYTlCMXZiWWtNUEhDOXp5?=
 =?utf-8?B?aVE0SWlHdGJtQis0UWsrUEFsMm9XU3NIUXJVSnhoQWlDSUU3R1AzbDdpMmFK?=
 =?utf-8?B?bG51ZHdRNUFJSTN4MjdyVE10WWhJYzNBUVFEZ3c3cEFGOEs3YVJ4WXE4Yy9t?=
 =?utf-8?B?alYyb0NBSTZJSCs0dSsyTE1IZHJkRytURXJXL0tZK2Y3WU5KYzNDSGdpekU0?=
 =?utf-8?B?RitJMUxzWTE5MUQvMlMyTnJ0TFhsdDA1V0YxNTk1RlptdXhPWmRLYWVYbGh4?=
 =?utf-8?B?eVBrRStMU0RqUHJiUlJiVmd4WHcrWnY3NTVuazUzZVcvZW1TYW1XRjJxZEtY?=
 =?utf-8?B?MnkvdnNndU9ITVhCMTQ3cWF6YmRkY1RiY0ExcGh6c3FNZ2h5dVBsWk90ekVL?=
 =?utf-8?B?Q2kvVEVKZHRuVTUrTWpXaUF5MWVzSGMrTkVrR2t5dFMwOG42TDkxbVd4ME1t?=
 =?utf-8?B?d09hNTVLSlpiNjNxVzZ3TlhEVy9jNG11eWR1UkNTd0hoT1duNWFUM1lrV0l0?=
 =?utf-8?B?TVJ2MFF6Y3piRmdERWUzckwwckNSak45T0tKTWYzMkl5bFYxREwyTnNhOW1E?=
 =?utf-8?B?N05VSmVqUVJ0RlRYeDN2Z29xdXVtNjZ1MEo5eGliRWYzMHkyUTkwSFZmZVM3?=
 =?utf-8?B?Y3NEWjRvYjJocHFKTXhTQTd2NDJKUlBlSVl4Q1NGT1djc2d6aTBlVW9QTGJB?=
 =?utf-8?B?N1JwczRtdStHTVBMZm1JNnlPOFBERENqdDVKT09tbmZjcS90bnRYNW5CaU5P?=
 =?utf-8?B?WFFBK0ErTnBSczVnbVJqcTA1cmxmYkhzR2l0Ym03ZVdQcVdaNzhMakd6dE1X?=
 =?utf-8?B?ckxZTVhHTHpwbVBiblJzOHI5OWJQcVZXcHl2TjEvajdRZFRxcHNKaDBudFpD?=
 =?utf-8?B?MmpyVmh1bnVYSzNHY2xlSG9yV2h4OHlScklORnVDS3dsc2c9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR18MB4673.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MUpIWHBXakFJQU1YdjdiczR2Nmw3czZGaE9WZjQ3MjRRM3M5MEIxTzhKM0NR?=
 =?utf-8?B?QXk5RWx2NzVjMUhYSHJ0a0RmQytVVXRhc3RuaHpzN0plQjlqR05HdzZMS3l2?=
 =?utf-8?B?R2NsY1dCRlZ0V1RIamExdklPUjV3U1BUZU9RQmliZitRSFpUY01BektMZkJJ?=
 =?utf-8?B?cUxPOWJ2d3dlRGlTZnVQdTR4RW1oQnhhSk5sN0RpTFlicXVkU0lLQldOQkVw?=
 =?utf-8?B?VUFmYmNqdVJERUp2clNWNFkvUnVaREpla3RRZmZvYjRtVnlRT0Z6dzdoY2d0?=
 =?utf-8?B?ZitnZjNPZExpM0IzT1QzdUVFQzg2NzdGWFhRZk8wb256VEV3S05wOXZxdXJw?=
 =?utf-8?B?STN4Uno0eTVzSUt1YzZnV2RDcVRaZUFEekcvMnVXRXE4eWh5WWV5cnE2Sk0w?=
 =?utf-8?B?ODFNaldPcmlyaFhyTGxJZzd0SGMzZHprMjQvNVIrcllJZTlWSk5ZM1JaSEVK?=
 =?utf-8?B?V1M5N1l6U1VQaGl0RVk2UFNpblRveG1vZDNnOUNhb1ZQdEZhU0lubytHeThN?=
 =?utf-8?B?NXpORHo5bzlvZEh5OUlIVU94VkF4dHlGQTc1ZnBLTEFnek13cVBtSmJCMnZk?=
 =?utf-8?B?RStXd0JqaENqdEVud2pCWnRmT0hVMFJSOHJkeTJKVnJiWDdQRllaL1g4MVY1?=
 =?utf-8?B?UmExeGpaOXVzYmVocFJPYjlnMm0zVjFkUlpZMmh0bUpuaVJjWlI5S24rMU9x?=
 =?utf-8?B?WFY0aUk1VndqdldlTWp4bUhkeFRyeG9NY0ZNNTh0ZnNycGU3SmxQdFBkK2pv?=
 =?utf-8?B?ZWN1dXp5RUJVWWJtTXh6N1FBaU1JdlRmMG1HSFFPSWR1bDJqK09QYUNrZFUz?=
 =?utf-8?B?bWxyeUVRQkJSekxZd2QvUk92Q2hlZ2YwMnpLd3NkUlVFaGltbXJva0hUQTFP?=
 =?utf-8?B?ME13dHhNbzBHdlhNSWlsdlFFcjlYazJsVG5EcFovK0pTaWl0SXJKdER3elR1?=
 =?utf-8?B?emVCdkZqMExTdExzMytWZmRHNGt5OU9FVVdZU2hqbVJ0bE5mNTA4RjV3L3NK?=
 =?utf-8?B?aEE5OVVhaVZ2eFFCVnlYRHFDQVRoMjdVTkovNGxrR0N4ZjdlVThBOTdadk03?=
 =?utf-8?B?NkhGQjF2eldKemlOc1NCWmhBbjNrU0ZwK2FERURvRlZGV1ZDS2NwTWpLVUtr?=
 =?utf-8?B?RDlmc3U0OGhpQmlxdTZlQ3pJWC9nbFRMaHVobEtkUVljbWNSM3RFU3FCRjNF?=
 =?utf-8?B?RmVlc2krVEJJZTREeTFKbXc1d0tRR2VBellKbkRHcmZxVE1GZlMrM0Y5THRZ?=
 =?utf-8?B?Q0F4MHdsb2RIMXNwVmE5NVlOMkN5L3B2aUhNNnc0ajQ3Y1ZIaXZ5aC9lWDZY?=
 =?utf-8?B?VnVpd3R3Wlk3Q3JsRXVOTzlJNTJPcTMvS1crMnZVdSt2c045ZUNEQ0VTUEZN?=
 =?utf-8?B?REIreVIvWDNpOE16RDRwaG9YS3JCc3pMemE0L1pKWTkwWGo5bFgxL0txRzQv?=
 =?utf-8?B?K0ltWW5rZGl6YTdQeFFzTW9iU2w1SVRlZWtUSEkxN3EvNXM3WU4zeDU4NkVQ?=
 =?utf-8?B?MFJZMzB2NzRPTnkrV3UzY3VLak1rQVNPT2QrWGpwMkFBamFubzFOVDJ3MCtW?=
 =?utf-8?B?TFFmTUtMaUFickNtQXRXaXh1QUY0a3NZK25hTDdmZFNJN0FwZ0JXVnIvS2Rs?=
 =?utf-8?B?djlwQUppWEZRL2VyN3diQjh0di82cXVndDJweTVnNWxKeVd4V1FBMGxDL09k?=
 =?utf-8?B?c1FwQ1BsczkwdUh0NzJJR3BmaVEyaG9VT0RRSW53bCszUFdHeEgxUy8wbTdv?=
 =?utf-8?B?TTlvV3ZTSnN3QytFeEpPTEkvdzNXd21LNXVLL2JYczBTY3ZieDQ4SUNHeWt4?=
 =?utf-8?B?czByUlRVWkFFV25oOFZuT05qb3pvWUw0RVpXRE1qN2lXSVZMNmRIMDJtZmRh?=
 =?utf-8?B?NnhObXM4Q1ZVa2JoYVVGVHJkNUd4SmtCVlBQSW1YbGVZRmlYdjlDTndIY2c3?=
 =?utf-8?B?N1Z6TlkzeGg0Tm1BODZTT0JBSzBaekFoTkk0aUwyT0dhODJYdEFKWm5UZ2wz?=
 =?utf-8?B?aGQ1M2NSTWpjcjA4ZERDeEZhVkF0eVgzVmtJS0hzQlUrMTZvMkNIeGJycWNT?=
 =?utf-8?B?bTlFd0czSWJod0dqT1VNSWhzeWUzU1V3QU9vUDIzY1ppcG5LbGdQYkMxa3Vv?=
 =?utf-8?Q?vM1V4ZAQ9qBpaqpjcYW9drJXE?=
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY3PR18MB4673.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc0bbafa-8fb2-48fd-7b83-08dd5779f04e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2025 21:58:59.0588
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PA5XzQth0qvTowBQ39iPUP2zqeeNRt4Es8rHuLnK7K9v0DjMULn4ZumGIvn35sFtcewgmzPo+80welQ4CgJK6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR18MB4335
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: 9wz-CnR8IfI-sINxsAuSf9h5cWFoInyd
X-Proofpoint-ORIG-GUID: 9wz-CnR8IfI-sINxsAuSf9h5cWFoInyd
X-Authority-Analysis: v=2.4 cv=JOjBs9Kb c=1 sm=1 tr=0 ts=67c0e025 cx=c_pps a=b6GhQBMDPEYsGtK7UrBDFg==:117 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=T2h4t0Lz3GQA:10 a=-AAbraWEqlQA:10
 a=RpNjiQI2AAAA:8 a=VwQbUJbxAAAA:8 a=M5GUcnROAAAA:8 a=JfrnYn6hAAAA:8 a=P-IC7800AAAA:8 a=pGLkceISAAAA:8 a=elLWZlKbAAAA:8 a=_k_7hSW8PJy6QCgwLjwA:9 a=QEXdDO2ut3YA:10 a=OBjm3rFKGHvpk9ecZwUJ:22 a=1CNFftbPRP8L7MoqJWF3:22 a=d3PnA9EDa4IxuAV0gXij:22
 a=YXs7sxRoaa14xkmg_1jM:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_08,2025-02-27_01,2024-11-22_01



> -----Original Message-----
> From: Rob Herring (Arm) <robh@kernel.org>
> Sent: Thursday, February 27, 2025 12:24 PM
> To: Wilson Ding <dingwei@marvell.com>
> Cc: linux-arm-kernel@lists.infradead.org; Sanghoon Lee <salee@marvell.com=
>;
> conor+dt@kernel.org; linux-kernel@vger.kernel.org;
> gregory.clement@bootlin.com; p.zabel@pengutronix.de; Geethasowjanya
> Akula <gakula@marvell.com>; devicetree@vger.kernel.org; andrew@lunn.ch;
> krzk+dt@kernel.org; sebastian.hesselbarth@gmail.com
> Subject: [EXTERNAL] Re: [PATCH v3 1/3] dt-bindings: reset: Add Armada8K
> reset controller
>=20
> On Thu, 27 Feb 2025 11:=E2=80=8A25:=E2=80=8A34 -0800, Wilson Ding wrote: =
> Add device-tree
> binding documentation for the Armada8K reset driver and > create the new
> head file for the reset line index definitions. > > Signed-off-by: Wilson=
 Ding
> <dingwei@=E2=80=8Amarvell.=E2=80=8Acom>
>=20
>=20
> On Thu, 27 Feb 2025 11:25:34 -0800, Wilson Ding wrote:
> > Add device-tree binding documentation for the Armada8K reset driver and
> > create the new head file for the reset line index definitions.
> >
> > Signed-off-by: Wilson Ding <dingwei@marvell.com>
> > ---
> >  .../reset/marvell,armada8k-reset.yaml         | 48 +++++++++++++++++++
> >  .../reset/marvell,armada8k-reset.h            | 27 +++++++++++
> >  2 files changed, 75 insertions(+)
> >  create mode 100644
> Documentation/devicetree/bindings/reset/marvell,armada8k-reset.yaml
> >  create mode 100644 include/dt-bindings/reset/marvell,armada8k-reset.h
> >
>=20
> My bot found errors running 'make dt_binding_check' on your patch:
>=20
> yamllint warnings/errors:
>=20
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-
> ci/linux/Documentation/devicetree/bindings/reset/marvell,armada8k-
> reset.example.dtb: system-controller@440000: compatible: ['syscon', 'simp=
le-
> mfd'] is too short
> 	from schema $id: https://urldefense.proofpoint.com/v2/url?u=3Dhttp-
> 3A__devicetree.org_schemas_mfd_syscon-2Dcommon.yaml-
> 23&d=3DDwIDaQ&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DsXDQZu4GyqNVDlFUXakS
> GJl0Dh81ZIPlU26YS4KHGIA&m=3Dxw0M--
> 2th9TCt05M0q_c8C0jvg1t4qbuXx9_d3WgCc0HOBpg5_f5E6TjXP_xdcrU&s=3D3
> Gdm4ABV10PnYEpAvJXrV9x-TsfBAHIp5KCn60ohngM&e=3D
>=20
> doc reference errors (make refcheckdocs):
>=20
> See https://urldefense.proofpoint.com/v2/url?u=3Dhttps-
> 3A__patchwork.ozlabs.org_project_devicetree-
> 2Dbindings_patch_20250227192536.2426490-2D2-2Ddingwei-
> 40marvell.com&d=3DDwIDaQ&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3DsXDQZu4GyqN
> VDlFUXakSGJl0Dh81ZIPlU26YS4KHGIA&m=3Dxw0M--
> 2th9TCt05M0q_c8C0jvg1t4qbuXx9_d3WgCc0HOBpg5_f5E6TjXP_xdcrU&s=3D
> WJznALBWhejS9hq88jCvZqevaNdN_5-meKfowRfl-bA&e=3D
>=20
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>=20
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>=20
> pip3 install dtschema --upgrade
>=20
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your
> schema.

I cannot reproduce the above error with the latest 'yamllint' and 'dt-schem=
a'.

$ pip3 install dtschema --upgrade
Requirement already satisfied: dtschema in /home/wilson/workspace/repos/ext=
ernal/venv/lib/python3.12/site-packages (2025.2)
Requirement already satisfied: ruamel.yaml>0.15.69 in /home/wilson/workspac=
e/repos/external/venv/lib/python3.12/site-packages (from dtschema) (0.18.10)
Requirement already satisfied: jsonschema<4.18,>=3D4.1.2 in /home/wilson/wo=
rkspace/repos/external/venv/lib/python3.12/site-packages (from dtschema) (4=
.17.3)
Requirement already satisfied: rfc3987 in /home/wilson/workspace/repos/exte=
rnal/venv/lib/python3.12/site-packages (from dtschema) (1.3.8)
Requirement already satisfied: pylibfdt in /home/wilson/workspace/repos/ext=
ernal/venv/lib/python3.12/site-packages (from dtschema) (1.7.2)
Requirement already satisfied: attrs>=3D17.4.0 in /home/wilson/workspace/re=
pos/external/venv/lib/python3.12/site-packages (from jsonschema<4.18,>=3D4.=
1.2->dtschema) (25.1.0)
Requirement already satisfied: pyrsistent!=3D0.17.0,!=3D0.17.1,!=3D0.17.2,>=
=3D0.14.0 in /home/wilson/workspace/repos/external/venv/lib/python3.12/site=
-packages (from jsonschema<4.18,>=3D4.1.2->dtschema) (0.20.0)
Requirement already satisfied: ruamel.yaml.clib>=3D0.2.7 in /home/wilson/wo=
rkspace/repos/external/venv/lib/python3.12/site-packages (from ruamel.yaml>=
0.15.69->dtschema) (0.2.12)
$ pip3 install yamllint
Requirement already satisfied: yamllint in /home/wilson/workspace/repos/ext=
ernal/venv/lib/python3.12/site-packages (1.35.1)
Requirement already satisfied: pathspec>=3D0.5.3 in /home/wilson/workspace/=
repos/external/venv/lib/python3.12/site-packages (from yamllint) (0.12.1)
Requirement already satisfied: pyyaml in /home/wilson/workspace/repos/exter=
nal/venv/lib/python3.12/site-packages (from yamllint) (6.0.2)
$ make dt_binding_check
  SCHEMA  Documentation/devicetree/bindings/processed-schema.json
  CHKDT   ./Documentation/devicetree/bindings
  LINT    ./Documentation/devicetree/bindings
  DTEX    Documentation/devicetree/bindings/reset/marvell,armada8k-reset.ex=
ample.dts
  DTC [C] Documentation/devicetree/bindings/reset/marvell,armada8k-reset.ex=
ample.dtb

- Wilson

