Return-Path: <linux-kernel+bounces-218564-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DC890C1EB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 04:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E96F1C215FD
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 02:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989DC19ADBC;
	Tue, 18 Jun 2024 02:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="CkZsQm7v"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2066.outbound.protection.outlook.com [40.107.117.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C860D197A7B
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 02:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718679032; cv=fail; b=kw3FSTkwEgAdIAfdllpif29S1W5hBtxw57rrofTxfwa41CC8sGz8v03tYa++m/ICkapE2Nx+sZwC5Of76samRUuN91xacwk0Zep5rt9vT1kMBwngiA0lxJ/VWb9e97a17yrKrj7Kmr+CTIYSI/+t+lRIlfiOHta2jMf6qYGir5I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718679032; c=relaxed/simple;
	bh=eXVq8pybtNAXeWoA3MGp3Ug0cnsAluv7kV7qCxRP8vw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dpRPPg7rS487M5akH+Gl9iTu/jvrxfGNqn01eHPP4tv/NhUG8s2ThpU56sYZ3u8mQUpjAX4uD8P15dseGj+m/nO9T7O74rCWClmhwxrAYLF2Ha+irL6UYOfwk28VPURpv1dZJSsli2XaCzjJwOXCOEy+eyusu94voZlv3ZiALoM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=CkZsQm7v; arc=fail smtp.client-ip=40.107.117.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nS8WrV3nw1sAN2yqSV77/hEkPWKcdGoToACIlwEMHdxaUh48ctLoHdsSowN91698vTMB5YaoLUpJvO7jtbB4aiwSoUglE4cZfSRIrXtanvBdU/bmqRDYwNA1uxVrfLCL3mdxyV4+IgO4qfytb2SY5i8DUEjzv5GAQyyrHfLsPNfA0SE2mrCZ+JX6aqDh1BNMFWXNTylN+2+0GrxQ4kArFvEcksmSR9CAeAqpw37SFsX7WUSuSAjguyZOqaWeAo9RYSl6FbDRacyj5E6/eMGfVh8B2/96OfyIHz1RJnMNARkr30EwXD7PlbXGvcN6uu12DrqywNraiqFZ7jd2oclb4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pn+DY6BubZ7dCGC/bINp+q64TeR3k50H+M53uwISo4w=;
 b=Tz1+1I2NUm1aC+t5/3nrFFfjGoeIwQnmesXWJWhYyk4S1YcaeAByoWPCajlb4imScUhVJOXweXlBIIV3oN/nUl0gwWkPDI2pLf/rEvsZkqhssnja0AuVRfTTdsr6+H4sfR8mWYLaBdHPfX8Un5w/s1ZpQAoEmL57Y/f4/Q95nH5zz0sBiIUrsasbq8wFjyDerC9pihigLfweqidiZkMFA2i51BS2gzv21+ml0hdCqAoQ2N2gUKSP/p8yz7iNTnuLgmaOgkVmhYbIlXjBN4txRaHh/0MHjA+R89cUVP7ayr2YOM7USeTATS8t+E2bV8dq3po0+sDVyhT7clhXk4jBpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pn+DY6BubZ7dCGC/bINp+q64TeR3k50H+M53uwISo4w=;
 b=CkZsQm7vL6oAuBfTiZnHKreoWyfQ2hdJQdTEQrUBtffDxhMlSohDCilGJ0ZAs7Fxl7QEPudnnrenHlsv67v2Kjf3CWZT32NuZQfoFg+omGH23xj44PR2ZrpikhKWLV4++SydC2O+197Eg86G9KcXmKw/vh5nPHWjc+ujUrx5THMqH8inaGpvCdltNowYnH/7hHzG+xtomgZVj5dBkmcO2mTXYqeeah+viDsPsdu2khsUMMa49LCbNuTl00yAek80EnU2zYOx8SZ12eM3UeQHaEjSwpBUe4UTPYiqFKBi7a3j3daxlF5wgOsUW4nUrnnxWQ1kbfCPvF257Z3rNSfGIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com (2603:1096:101:c8::14)
 by SI2PR06MB5170.apcprd06.prod.outlook.com (2603:1096:4:1bd::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.31; Tue, 18 Jun
 2024 02:50:23 +0000
Received: from SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd]) by SEZPR06MB5624.apcprd06.prod.outlook.com
 ([fe80::e837:10e3:818e:bdfd%5]) with mapi id 15.20.7677.030; Tue, 18 Jun 2024
 02:50:22 +0000
Message-ID: <32e0c2ea-6035-4ec9-b99c-e6b686f04cf3@vivo.com>
Date: Tue, 18 Jun 2024 10:50:17 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] binder_alloc: Replace kcalloc with kvcalloc to
 mitigate OOM issues
To: Carlos Llamas <cmllamas@google.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 =?UTF-8?Q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>,
 Todd Kjos <tkjos@android.com>, Martijn Coenen <maco@android.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Christian Brauner <brauner@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, linux-kernel@vger.kernel.org,
 opensource.kernel@vivo.com
References: <20240614040930.11119-1-liulei.rjpt@vivo.com>
 <ZmyOJJmA7h6sZ_8A@google.com> <c46a07f5-f504-4c6f-af54-cfa00f987ce3@vivo.com>
 <ZnCDvpFveS6X0a1g@google.com>
From: Lei Liu <liulei.rjpt@vivo.com>
In-Reply-To: <ZnCDvpFveS6X0a1g@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TYCPR01CA0083.jpnprd01.prod.outlook.com
 (2603:1096:405:3::23) To SEZPR06MB5624.apcprd06.prod.outlook.com
 (2603:1096:101:c8::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5624:EE_|SI2PR06MB5170:EE_
X-MS-Office365-Filtering-Correlation-Id: a4bcc3b7-d80e-46fd-e1a0-08dc8f4165d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|1800799021|52116011|366013|376011|38350700011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T28rM1RoaGFJOUxFNzNjNldGbEdjWEpuQW9jSjBrQUtXTk5RV0pNcVU3Tit6?=
 =?utf-8?B?QjZGcENiSFpKeXA2REM2czB2UUVJYmdLcUdLVVIrRUs0eEk2ZGZUN1MwZzgw?=
 =?utf-8?B?OHFlQ09XaTh3SjJUS2ljZW1OVWtYY2RpMmpKVklaU0cwcTAxZXpyRzUxYitk?=
 =?utf-8?B?dUgvWk45NWQ0QUJYVS95Wk9LTW01bzgyWmtwbmNYWFA3dVFIZjU5ZUZKZFVo?=
 =?utf-8?B?Z2tmNEt6ZFIxOGRxd3I4TEFWcXNDaUF2b0xKNkpSMEF5TC9jdm9abXRrTWgz?=
 =?utf-8?B?Y0hDenFvcTlNekFycW5hTG96eFU5TVRwaHdEblBYZnhxeC9qRVpJeUpMMzRB?=
 =?utf-8?B?UlNQOEdsMVBwelNVc0Jqdkc4MlMvaDM3WUN6OU12dFFRRVcrY0dGeEJPV1Za?=
 =?utf-8?B?ZmVPMGYwRzJERVpmRzUyNE01ZFVIUkZKVVo1Yk1nblJNZVA1ekQ5VUpBTCtX?=
 =?utf-8?B?N25TY2FWS2hVNjZqRTdOdDNNQTVuenY4bDh5N0lIRmxSSC9uWWV6YVBWdWxx?=
 =?utf-8?B?bGRGdTFFZTRVSjR4aU1EeUxIR0ZXQUY4QktKdnFmLytWSzFjbWpCUjcrelZ1?=
 =?utf-8?B?VTM3RHU5cE1aT3RMeEduc2QwUHFZQ0V2ekxZNVpTYVpPTUdhbDBaZmozNnNI?=
 =?utf-8?B?eVpUQ1BUUlpsL0JlTko4WExIRUxVSEg1ei8zMlpLandRN2tZYmNheEtKZ0Rn?=
 =?utf-8?B?Z1B5a1cydlRmT1QzSDdueEtTY0JleWh0T3M0TUhvMGNGYkk4Q2RNbWV4QWdy?=
 =?utf-8?B?cmV3Tk1jR0huZjRjM1o5SitMaTE1NU5aSU9Hejd3WjlYL3JEazlqZU1iZHNQ?=
 =?utf-8?B?VUZMNjRNRG0zRVNTaEw4alRRaXMrR2VzWjNDS05sMXFRM1JQTDJnQTMzcHo5?=
 =?utf-8?B?cmJYSlhnUnVaL0hodkFRa3drQXc0ek0wSERWeWd2ZlJ6ODlYamVPOWx1ejJY?=
 =?utf-8?B?ZXlaa3N0ZXprYUl3UzRWQzVVQ0ZUWDZrWEpMZUR2aWJBWUxYcVE4SkRQOHdq?=
 =?utf-8?B?R3VTYWhHRE5EMExBcTJSQ1ZabmJzSEVZcXArdDB2c1VDWHh2bGhtK0E4Vmgv?=
 =?utf-8?B?ZEpHUHJvbDg5K2lQVTR2aHo2MU5tb0hXTW0zQWdlbzU3SXpxU3dVSHN5UTlT?=
 =?utf-8?B?YjJMaTNiclkxaGtjVWVCS1UrcVBWSTJacDBjVXFzY0xBOE9YYmd1SENueHBm?=
 =?utf-8?B?cDBXUEl5dDZuU3ovamtZaG5wM21lT0x5ZCtjdnVCRk1kU051U1kxYURlWk5L?=
 =?utf-8?B?WXBSSGZsb2dvYVBkSGEybUZRK3loRkkwaFRrL1QyQ0h5TDdxaUxRUEo1d1do?=
 =?utf-8?B?aTRKaUt1SnNsNS9oOXp5elpLaVM3endXa3R1NlFxekMzTVdNSnVIR3dUNDJQ?=
 =?utf-8?B?Rm02OGx6N1lZN0x3NG5HeXREU1p2U2tZaE5pOEoxZEFSZlNqNVZzVFd2RUYv?=
 =?utf-8?B?KzI5SDBKMlFBWXZIbHA1eXQ1MzJORUhaUkFPWEY4blU1YUdJUThOUVJOakpB?=
 =?utf-8?B?RmVwZCtrbmd6Um5YdU92aU81eEFiMzRnZnpUYVB6a1lCYjI0SkJBZi9SbjVL?=
 =?utf-8?B?bkRaejFQUnRhS3dabXVNbXFld3JZT3MycEQ0WWN0UVBLRTRKYS83alcySnlR?=
 =?utf-8?B?ckVlYzMwMi84MXo4WGo2eEE3bWE5NlBhakVkWkFBNjl2TjJoa3pKQlR0T3VL?=
 =?utf-8?B?a1YxTUZrRjFwZVpSOVpLTTlMVkZIMjZJOG1JQVhHaFJRTmNkK0Z5YUtheWJW?=
 =?utf-8?B?bW1NREtYM1pXR0gxMmsySU1ZZE9xUERjT0NIRmQzSFF5a0gydk5LVWswUmxF?=
 =?utf-8?Q?Y+MVpsY4PL6UFMyXZnbikCGIxI1AmY11ZIgz4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5624.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(1800799021)(52116011)(366013)(376011)(38350700011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QVNnaFoyc244Kzk4MExWdjZuVXdqU29pMXl3NkRMWjk2R3pUamIwQ2pQdEtU?=
 =?utf-8?B?Sng2bmpRTmp3ZVcrMjhKNGxpaTVORDErNlFOcHozbUJyY3RjVFA5NEdCRGdt?=
 =?utf-8?B?SUk2M0pob1RMMkM4VDhGblpuNnF1OWlVSVRjN21DcHBEMmZ5bnNHQzVZUnNw?=
 =?utf-8?B?WjJHR2E4NTVwaU9teUVJSzRTZWtCa0ZPZnJnNEhyeTBRUDJDbXh6K054Z0xJ?=
 =?utf-8?B?QllJYXBUY3M1Z2gzK3g4MDVzK1NHVTYvUEZQK2V3dG5nL21xRk8zWFo2dEtV?=
 =?utf-8?B?clIxUEh4b01IbTBxYk8zQnBTZmluL1ZiN0llM0x5VWJYMktoeHpNSXl4ZVFW?=
 =?utf-8?B?eGFkYzZnOTdIdGpwc0N5OGREQmVOVk1TMnJKUzd1Rms5RXJwS1d2RDZZTEQ4?=
 =?utf-8?B?WWQ4YUgzVG5BQlhoREl6b01RNVJiNUZQTVJGZFJsMkswQ2wzQ09pajErVHNB?=
 =?utf-8?B?OFZpQUZyUXcySGNFQmZtU2kwK2JEZGlvMWsvOXN4RWZqb1Yzai91ZGJrbEpw?=
 =?utf-8?B?L2tGZVVSalZsUTBkNzFBR3ZZc0paK0NnN0c4RFlCeTR0b01vOG5od2wwajhO?=
 =?utf-8?B?b0o2Yi9DTWdidkVobXducmdkR0pvWTcxSkdndEFUbTZSOUpScFI5RGJwSnBE?=
 =?utf-8?B?cUkrSHczektVOS96QXExMWN3RHFCcTlBMlJaMVBYdUxpS05NdWF5LzAzWk8x?=
 =?utf-8?B?VEh4S05FV1NPSjJqVDVia3hWelNzekJENG5qbXJXbUllODNBRWJjWS9UaXJW?=
 =?utf-8?B?bmljL0hzYndSVU9LeW9HY3J3MTlTTlBYbEdOcklLbmZOdi9NdUxWaFhhSkZZ?=
 =?utf-8?B?RlJmVE1DTjRzNWVRRDNoWEROckxpcXAvL1I3LytHbTQ0YlhHOHZHUmNrcTkw?=
 =?utf-8?B?QkVMend5TUJ5blg1K3J0OW9EM1FoRE4wWnhXREdXM285bk0xcHF4bWJMVmJ0?=
 =?utf-8?B?SzF2aGlHeGdwR0RNR1VmNVBNSk8xbjZuTTNCNUFkSjRRblRUd1VNaVFKODJn?=
 =?utf-8?B?aWJWdG9HbmhnQ0VhRFVUYSs1MnFid1RyektHVjQ5YWpSSFNMZ1p3bG10Q0tF?=
 =?utf-8?B?YVdTbTRmVmdGdU9OQjdGWWhoWXRlaHVUa1EyN3ZiVDNLaWZ1M1lKKzIvcDVV?=
 =?utf-8?B?Q3dmd2Y2RDVCTnVpSm9QUk95MjgycE5KWHZPZlF6ekpCMnZVWld0SnB2cmpK?=
 =?utf-8?B?ckFzU1NZZWFJMmYwVXQzM21UWlIzSTdtWFVMOFVpa0FoaGprSWVQYlZXWjEy?=
 =?utf-8?B?NFI2dkpOMmFwS2gyVHFuMmhWR3dLQlFhblVETUtWUmNYeTVlRVlPL0RCY0cx?=
 =?utf-8?B?Ymx1aUsrN3EwWENVTFcvcS9vOWs3TkV6VGp2UElUOEZGOFZLRFA3WndGUXIz?=
 =?utf-8?B?Zy9iQzJiQUZKMkxDTTRlZGpTVGdHa3gwbnNKbE0xRFoxT3pvTU1zVXA2YmU4?=
 =?utf-8?B?ZHRScW1KSDdZcnVzaWNuSngyNlZrc2NMMmdscElvb3hZM1VhbS9CeUNHcGRO?=
 =?utf-8?B?ZnFoTUx1U0VGQ1dYSHBFbHFzcy9MQ0o5WXg2ejhmYXpQQXJjTlJPb1p4ZmFy?=
 =?utf-8?B?eGZBTDF1QXAyNzIxR3JGUWtnWnhIckpKdHBhdUJOVS92cEJySGZWcUhUNlBU?=
 =?utf-8?B?eElEREU1emE0NnpDZFVPTGRBa1ZwazlncXdkWHlnRE0wNkkwYVRNVXFEUGo4?=
 =?utf-8?B?SGJET1M3eVZuZXZ2KzAxL2loN1o1RWhZVjRnREpSNkVSbFVGcnJpTUNFVVhK?=
 =?utf-8?B?a3FvUGwvUlIwWUlXWTY1WmY2MXEwdTVEQk16K01Ya1pkalBieTZmSzkvVDBn?=
 =?utf-8?B?TUtSb0ZnbFBFNkVQSExkTmRGTzFreWFTTFhSYTRleVEzZHo5ZENkSHZXamxD?=
 =?utf-8?B?T0p5ZTJoNkRNdzNqQ3psc3ZONm5NUFBJaEliWUFRcTVZTXBYK3hWb214WUda?=
 =?utf-8?B?c0t5b2RlN0MzRUFhdFVhU1ZvZENlSkdQTVM5YUJKdUZUditod2p2UmVJR0Vn?=
 =?utf-8?B?d090Rnp6QjluQWFkRFNrSUFQd2ZmaklXSDYwZmF3YU5nMVVoL1VFdnFJcTM2?=
 =?utf-8?B?amlBcXdzNkxuRTNtSmlZeUtvTHduZ1BwMXlabUFVWDVIUTd5d3d6ano1UHoy?=
 =?utf-8?Q?N7C/Lrl6QFhX3BUwuzNDMbzaY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4bcc3b7-d80e-46fd-e1a0-08dc8f4165d4
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5624.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2024 02:50:22.5987
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KW88KDAkxsE7moKe93GfD/yiLnDQ0Jjjn8+ZA73J1PTwTZ/hyEkjN3n2XSys1g1tDJCHBRPn0d0FIIRnJSARxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR06MB5170


On 2024/6/18 2:43, Carlos Llamas wrote:
> On Mon, Jun 17, 2024 at 12:01:26PM +0800, Lei Liu wrote:
>> On 6/15/2024 at 2:38, Carlos Llamas wrote:
>>> My understanding is that kvcalloc() == kcalloc() if there is enough
>>> contiguous memory no?
>>>
>>> I would expect the performance to be the same at best.
>> 1.The main reason is memory fragmentation, where we are unable to
>> allocate contiguous order3 memory. Additionally, using the GFP_KERNEL
>> allocation flag in the kernel's __alloc_pages_slowpath function results
>> in multiple retry attempts, and if direct_reclaim and memory_compact
>> are unsuccessful, OOM occurs.
>>
>> 2.When fragmentation is severe, we observed that kvmalloc is faster
>> than kmalloc, as it eliminates the need for multiple retry attempts to
>> allocate order3. In such cases, falling back to order0 may result in
>> higher allocation efficiency.
>>
>> 3.Another crucial point is that in the kernel, allocations greater than
>> order3 are considered PAGE_ALLOC_COSTLY_ORDER. This leads to a reduced
>> number of retry attempts in __alloc_pages_slowpath, which explains the
>> increased time for order3 allocation in fragmented scenarios.
>>
>> In summary, under high memory pressure scenarios, the system is prone
>> to fragmentation. Instead of waiting for order3 allocation, it is more
>> efficient to allow kvmalloc to automatically select between order0 and
>> order3, reducing wait times in high memory pressure scenarios. This is
>> also the reason why kvmalloc can improve throughput.
> Yes, all this makes sense. What I don't understand is how "performance
> of kvcalloc is better". This is not supposed to be.

Based on my current understanding:
1.kvmalloc may allocate memory faster than kmalloc in cases of memory 
fragmentation, which could potentially improve the performance of binder.
2.Memory allocated by kvmalloc may not be contiguous, which could 
potentially degrade the data read and write speed of binder.

I'm uncertain about the relative impact of the points mentioned above. 
I'm interested in hearing your perspective on this matter.

>>> I'm not so sure about the results and performance improvements that are
>>> claimed here. However, the switch to kvcalloc() itself seems reasonable
>>> to me.
>>>
>>> I'll run these tests myself as the results might have some noise. I'll
>>> get back with the results.
>>>
>>> Thanks,
>>> Carlos Llamas
>> Okay, thank you for the suggestion. I look forward to receiving your
>> test results and continuing our discussion.
>>
> I ran several iterations of the benchmark test on a Pixel device and as
> expected I didn't see any significant differences. This is a good thing,
> but either we need to understand how you obtained a better performance
> from using kvcalloc(), or it would be better to drop this claim from the
> commit log.
>
> The following are two individual samples of each form. However, if we
> could average the output and get rid of the noise it seems the numbers
> are pretty much the same.
>
> Sample with kcalloc():
> ------------------------------------------------------------------
> Benchmark                        Time             CPU   Iterations
> ------------------------------------------------------------------
> BM_sendVec_binder/4          19983 ns         9832 ns        60255
> BM_sendVec_binder/8          19766 ns         9690 ns        71699
> BM_sendVec_binder/16         19785 ns         9722 ns        72086
> BM_sendVec_binder/32         20067 ns         9864 ns        71535
> BM_sendVec_binder/64         20077 ns         9941 ns        69141
> BM_sendVec_binder/128        20147 ns         9944 ns        71016
> BM_sendVec_binder/256        20424 ns        10044 ns        69451
> BM_sendVec_binder/512        20518 ns        10064 ns        69179
> BM_sendVec_binder/1024       21073 ns        10319 ns        67599
> BM_sendVec_binder/2048       21482 ns        10502 ns        66767
> BM_sendVec_binder/4096       22308 ns        10809 ns        63841
> BM_sendVec_binder/8192       24022 ns        11649 ns        60795
> BM_sendVec_binder/16384      27172 ns        13426 ns        51940
> BM_sendVec_binder/32768      32853 ns        16345 ns        42211
> BM_sendVec_binder/65536      80177 ns        39787 ns        17557
>
> Sample with kvalloc():
> ------------------------------------------------------------------
> Benchmark                        Time             CPU   Iterations
> ------------------------------------------------------------------
> BM_sendVec_binder/4          19900 ns         9711 ns        68626
> BM_sendVec_binder/8          19903 ns         9756 ns        71524
> BM_sendVec_binder/16         19601 ns         9541 ns        71069
> BM_sendVec_binder/32         19514 ns         9530 ns        72469
> BM_sendVec_binder/64         20042 ns        10006 ns        69753
> BM_sendVec_binder/128        20142 ns         9965 ns        70392
> BM_sendVec_binder/256        20274 ns         9958 ns        70173
> BM_sendVec_binder/512        20305 ns         9966 ns        70347
> BM_sendVec_binder/1024       20883 ns        10250 ns        67813
> BM_sendVec_binder/2048       21364 ns        10455 ns        67366
> BM_sendVec_binder/4096       22350 ns        10888 ns        65689
> BM_sendVec_binder/8192       24113 ns        11707 ns        58149
> BM_sendVec_binder/16384      27122 ns        13346 ns        52515
> BM_sendVec_binder/32768      32158 ns        15901 ns        44139
> BM_sendVec_binder/65536      87594 ns        43627 ns        16040
>
> To reiterate, the switch to kvcalloc() sounds good to me. Let's just fix
> the commit log and Greg's suggestions too.
>
> Thanks,
> Carlos Llamas

Hmm, this is really good news. From the current test results, it seems 
that kvmalloc does not degrade performance for binder.

I will retest the data on our phone to see if we reach the same 
conclusion. If kvmalloc still proves to be better, we will provide you 
with the reproduction method.


