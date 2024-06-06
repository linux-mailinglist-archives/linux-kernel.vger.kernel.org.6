Return-Path: <linux-kernel+bounces-203452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 213248FDB76
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 02:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7451F22A75
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 00:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0448F58;
	Thu,  6 Jun 2024 00:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="jnazM690";
	dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="eMWwOt89";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b="n4DqiYcs"
Received: from mx0b-00230701.pphosted.com (mx0b-00230701.pphosted.com [148.163.158.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B0C4A31;
	Thu,  6 Jun 2024 00:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.158.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717633774; cv=fail; b=k4l0Rcq21fLO4cggxGFB4ODs7nHW8kTozK9XLNjpjB4oxHirGJc5nNIMDaMDEnV9wN7zQ/bwCDZvp+Z/VJFFPsLaS47sOYvRHJHSqm85LAErvG5WP41HneGN8ASclUZSPuGRe3QW3jBr9Jz5lYfDL4ERHDQJyXPRzWDzgXIeiUY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717633774; c=relaxed/simple;
	bh=bNLZhcn9AQkt/6qaLlc851xeg/jFxJ0KBi93GjtefTA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CHIF/ouidpXfepbD276Avx9HGOKVG8sqyHwLKxkjjojghYr2zzj5//saIhGGfvYPnu6IYIgBw5sLR8APOSCs75Nirp3ukVlJoZA3uM97QOi2ay+fsNxcfVBYWDskP5Au9nhJWU4KuhR2TFQO/pw1PLNeIqYgVVJA5Hno+ZgfbrM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com; spf=pass smtp.mailfrom=synopsys.com; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=jnazM690; dkim=pass (2048-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=eMWwOt89; dkim=fail (1024-bit key) header.d=synopsys.com header.i=@synopsys.com header.b=n4DqiYcs reason="signature verification failed"; arc=fail smtp.client-ip=148.163.158.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=synopsys.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=synopsys.com
Received: from pps.filterd (m0098572.ppops.net [127.0.0.1])
	by mx0b-00230701.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 455M3o43018958;
	Wed, 5 Jun 2024 17:29:21 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com; h=
	cc:content-id:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	pfptdkimsnps; bh=bNLZhcn9AQkt/6qaLlc851xeg/jFxJ0KBi93GjtefTA=; b=
	jnazM690HCx4afepFGkeRcWd1mfs8/shj40ZFAL1GCBJbtVYJKbT8T7kgIrVj0cJ
	qYtbkxJfOW2y28RryVxVfz/+R0eQ0Kgvgalq+PqkjsUBAaCvRRb+464INhiHn5Sw
	Z0qyRlzZ3fgINGgFJ6T40ENU0kx798rPrOBmXj7IZP1NGaf4p7tnru5Dga4ue0uL
	cET6z8XJWSO1HVRwQ374ZMjLXd3Y8fZxRMFF8KCSSG4SO71CxDS4F5s61Bm/i4nl
	Z8VYHOPCEugO8VNGwm4JpXGgKaAW21Jpuv3YTTDfQTkbgh/dhg2Cm+rU3ork1gVv
	mtn+CkqNklY9UGB8tkg/Jg==
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
	by mx0b-00230701.pphosted.com (PPS) with ESMTPS id 3yg29ckpk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Jun 2024 17:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
	t=1717633760; bh=bNLZhcn9AQkt/6qaLlc851xeg/jFxJ0KBi93GjtefTA=;
	h=From:To:CC:Subject:Date:References:In-Reply-To:From;
	b=eMWwOt89/H3oV/O4MnrmtVMGBPzOPoZIoBt77G9/5NXJ6nw0ZgrZpStAcJqlQvMNQ
	 bmCOg/iMg1SUjp8hkkWT/i2ZBbj7h37y0hgRpSWyKhpujWZV7mKum1uFOfsEtbqGhG
	 gc2xvpXx99SjsLysRzMe7G7HOjqKHzona+U/F5Pe3jEjaH+tfM3dXiUYZPF274CmtZ
	 /Z3BiKRdYDoCgL7mEktn/bdkC1go9CMqfocg7Lal3/lgNWXYWlkutIHDOCBQ+U+BZN
	 TdRpzGLdv5GJZkeICC1urEWrewUEEqAnBso2HORCk3ExFfKdJjDr0hOgF0KUz0GgP6
	 tqmpNCeXdwO7Q==
Received: from mailhost.synopsys.com (badc-mailhost3.synopsys.com [10.192.0.81])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits)
	 client-signature RSA-PSS (2048 bits))
	(Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
	by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id CB097401C6;
	Thu,  6 Jun 2024 00:29:19 +0000 (UTC)
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
	(Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
	by mailhost.synopsys.com (Postfix) with ESMTPS id 73C39A007A;
	Thu,  6 Jun 2024 00:29:19 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
	dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.a=rsa-sha256 header.s=selector1 header.b=n4DqiYcs;
	dkim-atps=neutral
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2040.outbound.protection.outlook.com [104.47.73.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
	by o365relay-in.synopsys.com (Postfix) with ESMTPS id 41CF5404D6;
	Thu,  6 Jun 2024 00:29:17 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnkXOLdaOoxRPWXGo3T74py4XLdmjBrCriNK6sH0qgVgHxIZv4jonKKQ8TyJQ+k//O8FN6Kjkxamhx4BwIcahuca5w7JQDMLPKI2RHgJH5VV01rBd18bdmnvCkwRDJvLnC6gjK81S0oe1LNNmchxJRk2YtdhM96gNYhI7YE6xsxs7x6YJ3Xp9dCS7+S5ZjKL696Z+d5w3qSlJ29gWyQU/PParq9wV86HMn0hgu9xO3Y+Rj1VoFIhUkt5TPKXZoaAF1wpDTXUxYPgqkq4/VApnUqGcko+ORdA65r9+1mJ3LmiT3cXT6lGluTNSoJ8t6ZI1VOFEaZZmwvcr0bHxUPTWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bNLZhcn9AQkt/6qaLlc851xeg/jFxJ0KBi93GjtefTA=;
 b=RyYApKdLmsWzXFqTQkEQe6fpdGjGmLymOiu20VXrh3yAVehXbFZ/6DLgAYmhwZuUE3/RyW0yEX1EZ/aYoEe/MZExmiVC4LW3GoLaEQF/L2TRQF5TF7xI/XaZono6qNrApyuTP2hVSnf1G7me+upSwVpbNDa+Y6hElsUzKO7dco43HPLIHChGvRBolqhDFv4cy9ml2lSyNDtPj+aNI84Bif8vjbAW/U2TzQjcyVMaxkvEFlEaqBkIyo6S4IQCOMfonu2N0RJupkoWDZSrnu3ISr6+thiwi4ag4SzQHxk38ra2rY1VcL9kd0Dnu0DKG7+4iwhK9EU4Bp2lcNBTKAIuhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bNLZhcn9AQkt/6qaLlc851xeg/jFxJ0KBi93GjtefTA=;
 b=n4DqiYcsWzvNAxksVQl7Nsr8FZHlCbYMegX8rX/ae/TL/vkduzfYl1YBcq7XFqM/PwcNEC7Fn/n3oxsK0vKcehCoAugk0Gi9LAaf5Yng7eSUqC6RhfwTzEuWGfREHmJa8kLVFlfocMi7NlNAVaVSihpxfkI+zdsxJrG53ZS54cc=
Received: from LV2PR12MB5990.namprd12.prod.outlook.com (2603:10b6:408:170::16)
 by CH3PR12MB8075.namprd12.prod.outlook.com (2603:10b6:610:122::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.27; Thu, 6 Jun
 2024 00:29:14 +0000
Received: from LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8]) by LV2PR12MB5990.namprd12.prod.outlook.com
 ([fe80::3d09:f15f:d888:33a8%3]) with mapi id 15.20.7633.021; Thu, 6 Jun 2024
 00:29:13 +0000
X-SNPS-Relay: synopsys.com
From: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To: Mike Looijmans <mike.looijmans@topic.nl>
CC: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc3: gadget: Inform system of suspended state
Thread-Topic: [PATCH] usb: dwc3: gadget: Inform system of suspended state
Thread-Index: AQHatbfXThCMnoxt4kuSB1VpY3Td2rG2ym4AgABJugCAASgMAIABBTmAgACkO4A=
Date: Thu, 6 Jun 2024 00:29:13 +0000
Message-ID: <20240606002909.f6a7fwfh7ccb6pxq@synopsys.com>
References: 
 <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.c5f44c79-75b2-43c1-a791-806fe8b693cd@emailsignatures365.codetwo.com>
 <20240603131304.233403-1-mike.looijmans@topic.nl>
 <20240604010256.4dxamwvcjxug6xfb@synopsys.com>
 <0fceefc4-2b3c-41a4-a6ac-d0b6dbacc1f7@topic.nl>
 <20240604230624.dk3pssivd7g3qb7p@synopsys.com>
 <23bf65a8-b3b2-459e-bee7-ca7c4e4993de@topic.nl>
In-Reply-To: <23bf65a8-b3b2-459e-bee7-ca7c4e4993de@topic.nl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV2PR12MB5990:EE_|CH3PR12MB8075:EE_
x-ms-office365-filtering-correlation-id: 1820a0d4-9e8a-4b11-c923-08dc85bfb137
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|376005|366007|1800799015|38070700009;
x-microsoft-antispam-message-info: 
 =?utf-8?B?dVBtYUZ1eFVjVitQWHNsVVZwdzBsdUM0cFpPM21nV1VZVkdCcWYyQTF4bTJQ?=
 =?utf-8?B?L2FmNWVQdXBKT0N6K09YcUZFMUwyNFY4Y1hiaGNPZGtuVldkNkttTzZSMzE4?=
 =?utf-8?B?MHk5TUJaZDk2UHBSdnowdFlSYzR3Ukkvd3BUZVp2VmxYSGxvUTdveHF6anBP?=
 =?utf-8?B?ZUFSUmlvVFJhTTZjTnJvTlgraGNSVGV3R3lhLzVETzV4RzQ2QzlaWjRuVDVw?=
 =?utf-8?B?bUY3QTZBem1ET0w1NEFVY3FrLzFrdTFySjg5UEk5dkxEVFFDNVp1bHNWeHJE?=
 =?utf-8?B?emZaVEkyOWhPRXk3ZWNpTGFmOXo0aHVaZlM2dE8zRGJsOFBwaitKSW1KVTJa?=
 =?utf-8?B?dnAxYjFSTUlOQldkN3FzUkZNbGcxK2xDc1NQclI1czNmaEdQcDQzd2pheGdS?=
 =?utf-8?B?VEdMRWdTQzlyMWU0NmtJYU5kMlNEbzJtOGFSVFVjRWRVSzRGeGUrd1p4K2F3?=
 =?utf-8?B?VVFYM0NmdG0vanFmRFRyOUpBa1p5QlFyd3EzcCtBQjZCMFlGTm5NcEg3ZEs1?=
 =?utf-8?B?aGZuRnh6b1puTU9uY2xuMHFwOUo0cEdYcm4rK2xwNnRmV092Z0RLVXZOcnlF?=
 =?utf-8?B?VUtlQUVwR0RvSC9MRTdGUXh6RTMrZ2h5OHpxQXNYOTduYkhGTVUreGx3aCt5?=
 =?utf-8?B?TExwcTJHenZMTHFaQm11cXJ5QkdhUDlTWXV0eTV0eEF1UGdDaXkvOER1NzV5?=
 =?utf-8?B?MlUyOEJ3NkJDSXRxSjdRVzRqaEp1dXM1YVdLa3ZtQjdmNzk4eUR2YVBmazZh?=
 =?utf-8?B?MnY0ZU1mM0IzWG01TkcybEpTenhXNFhXaVR4a1RGVjZNNmgybzBUcG1Rb1lo?=
 =?utf-8?B?YlFaZFppa3RMZ2RnYmkwUGFSYis1TFRDa2FoQ25sVUhFTlRtTHhicTYwb2xL?=
 =?utf-8?B?MzRwMU9INDZHSTg5a2p5MUNLMGdVNUJROHZlSDVYQ2VXZzI2NWVIc1VwNTR2?=
 =?utf-8?B?aVNMRWlBcmFTVWZ5UnladUxTUUVXVEk4eUNQOGc0bERpWWpGRXVONEpGcDNE?=
 =?utf-8?B?L1A4SmpuOC9ZY2JUTGxFaXVyc1Z0YXpYSmpmbmIwWHFhMkpHOU5yVlhORTQ3?=
 =?utf-8?B?aGlrYlgrSXBpODdBaWlwQVR3UUJmbzVtQTNQUGUwZkYvMXFuNDJGNnBkQ0hh?=
 =?utf-8?B?VytXU0sxcVIrL2xYcHBRTmptTVd0bUhyUmxydmZWY05wS1RwMmlzNmU0bXZj?=
 =?utf-8?B?MXV0NVltYnBvdkt2TWl0djBXcTcrdGNOejNKLzhaNGl1QTVDcUlTSGN2Z0dP?=
 =?utf-8?B?dWlleERYRTBZUWlRcTBlWmltZWlZSlp1amtoRXNPV0ZZM0tZSHhFVjl5anE4?=
 =?utf-8?B?anM1RnVJYWhxTG51YXkzV01EdWk1aTdobUJPcXhBQnM5L2N2SUhQZ1NFcm9j?=
 =?utf-8?B?a1dZeVdqVVVyNjBiSlpRYTcwbUtEbURQb3Izem1zaUk2aE5qdE5BODVIOTJk?=
 =?utf-8?B?cGswMWRST1hNMWcxNlFQMmtkVEZ1aEJsc2owZUhaSWl6ak9xUUIwVno4WjUx?=
 =?utf-8?B?WFMyODBkWkxuWnR0UG5NamlCTEI1TEZiODhCelNDbU1YZmpxS0w3eXo1VnlO?=
 =?utf-8?B?ckZiMWZ0Vi9VUXJHamtFa3NCYzcwYVVabm9SV0lEbWF5MGd3aGR6ZWhRU3Vo?=
 =?utf-8?B?M2xObHlsNDdERU01azUyZ1dBamZWVEl4MXJoZW5WTlVMQVJPV09PVlF4Vm92?=
 =?utf-8?B?TFBodlI4bHFBVHU0M25nNzVEbW4yWXRkYk9UdkdJN3J4bDJjano3QVJjRDYv?=
 =?utf-8?Q?AOCWxEiVQupx/BNWidkt1qg0hJmW4BzZxhgA8Qx?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5990.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?VFY1aG0zVjA5SkxwcWthVGJHZ05GdVprN2xwcVF4aTJKUGZwK0JDcjVDd2JZ?=
 =?utf-8?B?N3J5bVJFdUhicEFVSlVNSHo4NXJXNmhjVlBnTWduQ1B3aWUvbTBlNlJoUVo1?=
 =?utf-8?B?RDVQZ0VibVZ5N25HaWxVSEVmeUpCQzRsYi9kWElFOGJueUdqUHZhc1F3SDBr?=
 =?utf-8?B?L2ExQUpzOGpNTHJRT3laNFpUdEsxbWNnT2U4K29WcSs4WEJjcGJ6Z0lVd2sy?=
 =?utf-8?B?aGtOdUpTK29KL2I3SE0ydjMzVDh3MmYwZFltbGtwRzdwT1dXY1dpODVDTk9y?=
 =?utf-8?B?ZEdNak92Z3VRM3gxM0V5NHphRlAwaUFLdzBhRXdKcGRRT3VWRjhiNjFWMi81?=
 =?utf-8?B?eUJmYjgzazA0WmZSQWNiSGVvRGxlbWxsSEozLzZDUUllVmR6Y2JMY2hETmdL?=
 =?utf-8?B?YWxjdUFWOTlCaGo5Y2lORG1PS29mUmVKMkJpN0RxVWRiMzRYTUFUa2JsbFJG?=
 =?utf-8?B?cHZhbE1hS0sxZTRIY0tQN0R4azJWWHQvMVE5aHg4cStsRjl0b3c2czZ4bGFH?=
 =?utf-8?B?WDJ2dWpHVU1NL0tERnpnRkd6Y09ZeGtGajN6aUpPWmh2WVNvR1JoVnkwY05B?=
 =?utf-8?B?NmxwdmMwM1JFdkZpUFFoU2RxTHBLbWFuZjVIcGNPbndmTlhsZ0IvKzhDclYr?=
 =?utf-8?B?L2FydURWWGFPSmFISC9NMmV4ZG9hcmhpL2NzMkhMUU5sVjJ5S1h2UHFwREx1?=
 =?utf-8?B?WkloRzRFNWVYZGlFMkpnVi9zSk9zc29VQ3VIQmlwR3JLeitxbmkraTBBUG1h?=
 =?utf-8?B?eEwzOExPLy8yU3RweTA2dnZxb0JLRHEwb01JbUlQVnhwWXNFNkpaaWQyRWY3?=
 =?utf-8?B?c2FGWXl6dVp2azFKaHpWNWRwNTM0Nm9IQ0dsNkdMYzdOK3Vudk85UmdSOFRH?=
 =?utf-8?B?RjlXVDY4anNjSVlzQk9RMjFBWVZPWHI5RGduOW9IeEdPcVhya05PbzM3TGpr?=
 =?utf-8?B?eTlkODZKYlhpdFdXOHkvS24xS0RvTG9RMlpoZVpRR2R0ZVJsZ2RFYzljaFM2?=
 =?utf-8?B?cSt3SU8vWjNZUWNVemJGcG45SW9SSXVVYU52UnhwZ0FndTVmMUR5ZXQwWGMr?=
 =?utf-8?B?bnM3bTlWQjVqNE1xeUx6WkVoN01DYUczdXBGbFhicUozenNwa2s3dHVKQ1Ro?=
 =?utf-8?B?aWV3d3NnSjhKQWh4M0RIQmU4bVlqdVFrN293eURoQ0NyVzdJSkJzVjRFa3dj?=
 =?utf-8?B?akVNa3dhUDNxMHdxUlhGUnZ4djVhS0JNbUtYS1hZdjI4c1JHWlJ2c2c1cysy?=
 =?utf-8?B?bFhWZ3EvL2pZWHBkYWg2azBFSnpWWm5VVHp4WE1QaVpmRWphSklOTEwrYjlr?=
 =?utf-8?B?N3FDNFc4NDRRWTJQTDZCc21MR1l5a0k5QUpMTlFHcm9NYjd0OWYyR2lhOXlv?=
 =?utf-8?B?M2NaQ3VqRG4rTU5ndUI4ekpQR21lQ2N4aUEwOG5tK0twSk1rQkNWZytWcTVI?=
 =?utf-8?B?akMzZ3AyZ1JxQlNXc2NvbEphY0ZEcUtWL1Z3aEZSUjlXSnRRcTk0TE1FWXNo?=
 =?utf-8?B?Z0hvUjFBMSt1aDdpY2U4aHduY1BSeVY3S1lPWlVJWnRPc0lTMGxudTgvT1pj?=
 =?utf-8?B?WmU0L25OUXBBMG9aNndsdVI3dVQzRjdMWWE5SHBRM28rQUtkN05uaW5yU2p2?=
 =?utf-8?B?YWwwQkJEdFNqMkE0NlkxRkU1ZjQxcGxsVTZDb3Q0bi8yQzZ4QjBqbEN3YWdL?=
 =?utf-8?B?S2p4T2puSjBRajhQUG5GVUkzYTFTSHI0NWMyZTJ2d1VYbEpQbkM2THZzb3Uz?=
 =?utf-8?B?d0ROWVBNL0Fvbm4xdnBsRWRpQ2g1Nmt4WWU3blVPVGlYTExCUFcrZW9ZbTN0?=
 =?utf-8?B?WWZlQmQrL2pjOURxWmNqazUrd0dsNWY3MnF1ZHNZLzFuT2lPMEk4ZXdaL3Ra?=
 =?utf-8?B?algrZ2J4eHNjUDJmMkR1a3pqRFloUS9lbmxoWTlwakZLY3NtTlNWVUEyaFZy?=
 =?utf-8?B?bFBuZDg5NERJZEthMklBMVk0QzcwNDExWWVQbndLL0lUWHl1Y3JiWWMwNnND?=
 =?utf-8?B?ZlQ4WE5CN0NSOTR6bWtraW5CN3gzSG5pRVZjcFhSTGE5SFV5M2NrUkRPb01U?=
 =?utf-8?B?Q3Bla0p4bU5xVHdSNU94K1VucEI3a0xCcFlHeUVVVW1kOW5FMW5sLy9uN0pS?=
 =?utf-8?Q?zqTOCv/XTXnxfxaQd/g+7Awk9?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AF6EBA89E5035D4E9248F83D11A9AB72@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	kr33l8rPNxk/uNuXh+xF0TL+fc55Abfdl/oRN5V2u7CthWITIQgKK9jfMoj54780CFJJQHziXM5mTng4ZtxPvDLJkzbVWd0c1i4/yLJ0b/QqNrgbqC2smJ9UwI2mTOgfGsUa/aLahtsRIPouk3p4jUN6PhefpcSMhuwCdEH9CPF453GPW5aimb8m3JmANnhtKJ6EuFo44UqDpImgAVsYvlOdRGQdwyY2glB0nPbZ91V8G3ddxCcqhzduXCbzBHwynwZDNV4d4F95Mtmm4Tbwylx0L0Vik0l6fWSfu6aM5/PbAjfYcxwC+fFQKNuBqX2Nk853zMExrqJMH9iiMidHvmhh33vbAHQYixQ4jVXYEAFXm3KG2TY/kMthv7B6KyvNnHXIg8bN1M4Zw0wYEUPko6I3/l7z71+xCJdLB2jee74ILMdbsvkpqNxENcd8xGcMiClNYiD+niFkG2yLWGTpq91OzZer+a9HDvxfhgi93dzMcujyhLVuZ1dqEUyKMJlgkTY7lnprJcyfUF4kpf0TRpBSLFAVszeOZS0GCiUF6wOIOV2Ox1EAauo4uHDC7+foSOh/8PjjJwk/XIo6iOoEef0rynlIDch79vfScEP8Fi3EcEN2CTXMzkrtKkkeF53E8df/53W7PopR4549vy8G7Q==
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1820a0d4-9e8a-4b11-c923-08dc85bfb137
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2024 00:29:13.8150
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ohoXMx/Ggk32hG9uiTnY5W3yvl+VWXaf1ucT4LyYu+S0PkLgssgeK/Zpd9/neu/pRKCDbVqYkkCVH+ODXIwjEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8075
X-Proofpoint-GUID: VfB6Cao_2Td8p-cYopaQijs-_ibH0cm4
X-Proofpoint-ORIG-GUID: VfB6Cao_2Td8p-cYopaQijs-_ibH0cm4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-05_02,2024-06-05_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_active_cloned_notspam policy=outbound_active_cloned score=0
 adultscore=0 clxscore=1015 priorityscore=1501 spamscore=0 mlxlogscore=999
 impostorscore=0 phishscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 bulkscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406060001

T24gV2VkLCBKdW4gMDUsIDIwMjQsIE1pa2UgTG9vaWptYW5zIHdyb3RlOg0KPiBPbiAwNS0wNi0y
MDI0IDAxOjA2LCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+ID4gSGksDQo+ID4gDQo+ID4gT24gVHVl
LCBKdW4gMDQsIDIwMjQsIE1pa2UgTG9vaWptYW5zIHdyb3RlOg0KPiA+ID4gT24gMDQtMDYtMjAy
NCAwMzowMywgVGhpbmggTmd1eWVuIHdyb3RlOg0KPiA+ID4gPiBIaSwNCj4gPiA+ID4gDQo+ID4g
PiA+IE9uIE1vbiwgSnVuIDAzLCAyMDI0LCBNaWtlIExvb2lqbWFucyB3cm90ZToNCj4gPiA+ID4g
PiBXaGVuIGRpc2Nvbm5lY3RpbmcgdGhlIFVTQiBjYWJsZSBvbiBhbiBMUzEwMjggZGV2aWNlLCBu
b3RoaW5nIGhhcHBlbnMNCj4gPiA+ID4gPiBpbiB1c2Vyc3BhY2UsIHdoaWNoIGtlZXBzIHRoaW5r
aW5nIGV2ZXJ5dGhpbmcgaXMgc3RpbGwgdXAgYW5kIHJ1bm5pbmcuDQo+ID4gPiA+ID4gVHVybnMg
b3V0IHRoYXQgdGhlIERXQzMgY29udHJvbGxlciBvbmx5IHNlbmRzIERXQzNfREVWSUNFX0VWRU5U
X1NVU1BFTkQNCj4gPiA+ID4gPiBpbiB0aGF0IGNhc2UsIGFuZCBub3QgYSBEV0MzX0RFVklDRV9F
VkVOVF9ESVNDT05ORUNUIGFzIG9uZSB3b3VsZA0KPiA+ID4gPiA+IGV4cGVjdC4gQXMgYSByZXN1
bHQsIHN5c2ZzIGF0dHJpYnV0ZSAic3RhdGUiIHJlbWFpbnMgImNvbmZpZ3VyZWQiDQo+ID4gPiA+
ID4gdW50aWwgc29tZXRoaW5nIHJlc2V0cyBpdC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBGb3J3
YXJkIHRoZSAic3VzcGVuZGVkIiBzdGF0ZSB0byBzeXNmcywgc28gdGhhdCB0aGUgInN0YXRlIiBh
dCBsZWFzdA0KPiA+ID4gPiA+IGNoYW5nZXMgaW50byAic3VzcGVuZGVkIiB3aGVuIG9uZSByZW1v
dmVzIHRoZSBjYWJsZSwgYW5kIGhlbmNlIGFsc28NCj4gPiA+ID4gPiBtYXRjaGVzIHRoZSBnYWRn
ZXQncyBzdGF0ZSB3aGVuIHJlYWxseSBzdXNwZW5kZWQuDQo+ID4gPiA+IE9uIGRpc2Nvbm5lY3Rp
b24sIGRpZCB5b3Ugc2VlIGRpc2Nvbm5lY3QgaW50ZXJydXB0PyBJZiBzbywgaXQgc2hvdWxkDQo+
ID4gPiA+IHRyYW5zaXRpb24gdG8gVVNCX1NUQVRFX05PQVRUQUNIRUQuIFRoaXMgY2hhbmdlIGRv
ZXNuJ3Qgc2VlbSB0byBkaXJlY3RseQ0KPiA+ID4gPiBhZGRyZXNzIHlvdXIgaXNzdWUuIENhbiB5
b3UgcHJvdmlkZSB0aGUgZHJpdmVyIHRyYWNlcG9pbnRzPw0KPiA+ID4gVGhlIGRldmljZSBkb2Vz
bid0IGlzc3VlIGEgZGlzY29ubmVjdCBldmVudCwgSSBkaWRuJ3QgaGF2ZSB0cmFjaW5nIGVuYWJs
ZWQNCj4gPiA+IGluIHRoZSBrZXJuZWwgYnV0IGFkZGVkIHNvbWUgZGV2X2luZm8oKSBjYWxscyB0
byBkZXRlcm1pbmUgd2hhdCB3YXMgZ29pbmcNCj4gPiA+IG9uLiBBZGRlZCB0aGlzIHRvIGR3YzNf
cHJvY2Vzc19ldmVudF9lbnRyeSgpOg0KPiA+ID4gDQo+ID4gPiBkZXZfaW5mbyhkd2MtPmRldiwg
ImV2ZW50OiAweCV4IHR5cGU9MHgleCIsIGV2ZW50LT5yYXcsIGV2ZW50LT50eXBlLnR5cGUpOw0K
PiA+ID4gDQo+ID4gPiBXaGVuIGRpc2Nvbm5lY3RpbmcgdGhlIGNhYmxlIGZyb20gdGhlIGhvc3Qs
IEkgc2VlIHRoaXM6DQo+ID4gPiANCj4gPiA+IFvCoMKgIDUwLjg0MTQxMV0gZHdjMyAzMTEwMDAw
LnVzYjogZXZlbnQ6IDB4NjA4NCB0eXBlPTB4NDINCj4gPiA+IFvCoMKgIDUwLjg0MTQ1N10gZHdj
MyAzMTEwMDAwLnVzYjogZXZlbnQ6IDB4NDA4NiB0eXBlPTB4NDMNCj4gPiA+IFvCoMKgIDUwLjg0
MTQ5NF0gZHdjMyAzMTEwMDAwLnVzYjogZXZlbnQ6IDB4NjA4NCB0eXBlPTB4NDINCj4gPiA+IFvC
oMKgIDUwLjg0MTUzNF0gZHdjMyAzMTEwMDAwLnVzYjogZXZlbnQ6IDB4NDA4NiB0eXBlPTB4NDMN
Cj4gPiA+IFvCoMKgIDUwLjg0MTU3MV0gZHdjMyAzMTEwMDAwLnVzYjogZXZlbnQ6IDB4NDA4NiB0
eXBlPTB4NDMNCj4gPiA+IFvCoMKgIDUyLjY1MDk5MF0gZHdjMyAzMTEwMDAwLnVzYjogZXZlbnQ6
IDB4MzA2MDEgdHlwZT0weDANCj4gPiA+IA0KPiA+ID4gVGhlICIweDQwODYiIGFuZCAiMHg2MDg0
IiBtZXNzYWdlcyBhcmUgZW5kcG9pbnQgZXZlbnRzIHRoYXQgb2NjdXIgYWxsIHRoZQ0KPiA+ID4g
dGltZSB3aGlsZSBjb25uZWN0ZWQuIFRoZSBsYXN0IGV2ZW50IGlzIHRoZSAic3VzcGVuZCIgb25l
LiBBZnRlciB0aGF0LCB0b3RhbA0KPiA+ID4gc2lsZW5jZS4NCj4gPiA+IA0KPiA+ID4gSWYgeW91
IG5lZWQgdHJhY2VzLCBwbGVhc2UgcG9pbnQgbWUgdG8gYSBkZXNjcmlwdGlvbiBvbiBob3cgdG8g
b2J0YWluIHRoZW0uDQo+ID4gPiANCj4gPiA+IA0KPiA+IExldCBtZSBrbm93IGlmIHlvdSBydW4g
aW50byBpc3N1ZXMgZm9sbG93aW5nIHRoaXMgaW5zdHJ1Y3Rpb25zIHRvDQo+ID4gY2FwdHVyZSB0
aGUgdHJhY2Vwb2ludHM6DQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8v
ZG9jcy5rZXJuZWwub3JnL2RyaXZlci1hcGkvdXNiL2R3YzMuaHRtbCpyZXF1aXJlZC1pbmZvcm1h
dGlvbl9fO0l3ISFBNEYyUjlHX3BnIWVweHRQbVhIaWl6TWc1XzVpZ0VZaUtVNDgzT1piMXpjWUsx
TTNhZnFYeElmZ3N3X2NVX2tkejlSbHBmMXctMzBKRjB2NFVVa3hCVmlKdHg0UHJ2M1pXY2hqS05I
a0tFJA0KPiA+IA0KPiA+ICBGcm9tIHRoZSBwYXRjaCB5b3UgcHJvdmlkZWQsIHlvdSBvbmx5IGFw
cGx5IHRoZSBjaGFuZ2UgZm9yIHRoZSB1c2INCj4gPiBzdXNwZW5kLiBCdXQgZGlkIHlvdXIgZGV2
aWNlIGdvIHRocm91Z2ggc3lzdGVtIHN1c3BlbmQ/IElmIHRoYXQncyB0aGUNCj4gPiBjYXNlLCB0
aGVuIHRoZSBkd2MzIGRyaXZlciB3aWxsIGNhdXNlIGEgc29mdC1kaXNjb25uZWN0LiBDdXJyZW50
bHkgdGhhdA0KPiA+IHdpbGwgbm90IHByb21wdCBhIHN0YXRlIGNoYW5nZS4gV2UgbmVlZCB0aGUg
dHJhY2Vwb2ludCB0byBrbm93IG1vcmUNCj4gPiBkZXRhaWwuDQo+ID4gDQo+ID4gVW50aWwgd2Ug
aGF2ZSB0aGUgdHJhY2Vwb2ludHMsIHlvdSBjYW4gZXhwZXJpbWVudCB3aXRoIHRoaXMgdGVzdCBw
YXRjaC4NCj4gPiBJZiBteSBzdXNwaWN0aW9uIGlzIGNvcnJlY3QsIHRoZW4gdGhpcyBtYXkgcmVz
b2x2ZSB5b3VyIGlzc3VlOg0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2Mz
L2dhZGdldC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiA+IGluZGV4IDg5ZmM2OTBm
ZGYzNC4uMjlkYmI4ODlhMGUyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2Fk
Z2V0LmMNCj4gPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+ID4gQEAgLTI2ODIs
NiArMjY4Miw4IEBAIHN0YXRpYyBpbnQgZHdjM19nYWRnZXRfc29mdF9kaXNjb25uZWN0KHN0cnVj
dCBkd2MzICpkd2MpDQo+ID4gICAgICAgICAgICovDQo+ID4gICAgICAgICAgcmV0ID0gZHdjM19n
YWRnZXRfcnVuX3N0b3AoZHdjLCBmYWxzZSk7DQo+ID4gKyAgICAgICB1c2JfZ2FkZ2V0X3NldF9z
dGF0ZShkd2MtPmdhZGdldCwgVVNCX1NUQVRFX05PVEFUVEFDSEVEKTsNCj4gPiArDQo+ID4gICAg
ICAgICAgLyoNCj4gPiAgICAgICAgICAgKiBTdG9wIHRoZSBnYWRnZXQgYWZ0ZXIgY29udHJvbGxl
ciBpcyBoYWx0ZWQsIHNvIHRoYXQgaWYgbmVlZGVkLCB0aGUNCj4gPiAgICAgICAgICAgKiBldmVu
dHMgdG8gdXBkYXRlIEVQMCBzdGF0ZSBjYW4gc3RpbGwgb2NjdXIgd2hpbGUgdGhlIHJ1bi9zdG9w
DQo+IA0KPiBJIHRyaWVkIHRoZSBwYXRjaCBhYm92ZSwgYnV0IGl0IGRvZXNuJ3Qgd29yay4gQXBw
YXJlbnRseQ0KPiBkd2MzX2dhZGdldF9zb2Z0X2Rpc2Nvbm5lY3QoKSBkb2Vzbid0IGdldCBjYWxs
ZWQgd2hlbiBJIHVucGx1ZyB0aGUgY2FibGUuDQo+IA0KDQpUaGFua3MgZm9yIHRlc3RpbmcuIFRo
ZXJlJ3Mgbm8gc3lzdGVtIHN1c3BlbmQsIHNvIHRoYXQncyBleHBlY3RlZC4NCg0KQlIsDQpUaGlu
aA==

