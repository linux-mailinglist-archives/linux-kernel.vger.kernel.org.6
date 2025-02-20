Return-Path: <linux-kernel+bounces-523403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FB5EA3D653
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 11:18:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5173189881E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 10:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF3C41F12F1;
	Thu, 20 Feb 2025 10:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iris-sensing.com header.i=@iris-sensing.com header.b="USHeHIG+"
Received: from FR5P281CU006.outbound.protection.outlook.com (mail-germanywestcentralazon11022090.outbound.protection.outlook.com [40.107.149.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BDF1EDA17;
	Thu, 20 Feb 2025 10:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.149.90
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740046703; cv=fail; b=Lgg6pqsBqPF5S1x4K0+kKNgM8RyeCC7GwrowJJLQA/vvfFnqTlnRYZ7hjzYaP8mOaO455niW4nnXlVttCDBOYykg7S2qbfR7tFcJUCBSZD5E2JyxoGgnCVrOdwxJFG0w7a9y2/nofF1g/c6ruJ07xTs4WjaRISrpkeeyCvNpxVA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740046703; c=relaxed/simple;
	bh=kJy06ltDgpL34pAwZWM1V+WMRgo/7mPFLxa4GMngmEk=;
	h=From:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=bhKl7eTpl538qFBp1nLwcqG0OgecmbmBSrJgBspe5kf9E9gmTVj+J61OMaUKjIqE0bemLP5YIs1NefOfc8PuEjrgJ+a/4goF/bsr/dq3G3rwOZHHoUVn/Q6m9NoWNLzGnbjUcn0SBF4CqXulT5xdKBOLZqAxpwStSrRiNaeM7ik=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iris-sensing.com; spf=pass smtp.mailfrom=iris-sensing.com; dkim=pass (2048-bit key) header.d=iris-sensing.com header.i=@iris-sensing.com header.b=USHeHIG+; arc=fail smtp.client-ip=40.107.149.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iris-sensing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iris-sensing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PcnyXiRF+xU8q0ozMPVe/bVgAgfXzDgHR+golayMXTB4/VpFmSPoviaePeeVyEUb1SWUfEexpAsJL2FPGmY/lRKh55Kn/YkTzSJYWtJGKZYks8f9mgkaLb4d3OUE+QTtVRyRkwbdkbIDjZFvJc9lkdkyRkJzTCGUDA4NghwKi6scGB2DOqoRnbteJPhxozK457jhcbKmtdAghLZrYHc4O34AIqmjuCOVgGZfMMM0c3xlg8uXafJ9TCubvewRbY+KqnbQU55PI9vm5ILHUCHz+h5/XXAZ0htv8jMRh6XJksogr6TI8+xQN3o1/0XS7KjPhm4BUBPgsi9Z8GjeY0CjFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kJy06ltDgpL34pAwZWM1V+WMRgo/7mPFLxa4GMngmEk=;
 b=x4AmK8ariWi6ZQ0MIL11YOUYpvqG37FSBqXxxosC3zowXXyUkbYZOfHnacIdDyRITsRYSnL+xhspZaCstISN9PkplGYumt3mSCk5u1ZCBsf8zRnwfAJqIQHRS8kGyIMSDN8zkD+/E4YPOPjxKOww40IrxwXvVy+mQvDezrOJzKyiTNhmAwvtNc2Ufueolc+jG+YrUEldXLz9fyzS8VFWrydeEqtR3yMd8YsWdc4tPc0OqqPtlBcMb2qlQIVjZPn7iWoBySnX6+d0hz6M3Ara9nbmfQXPbGZoHPYBiQ1LICw0+7TSLGkMR1YGn335f/ClDa/fo7nhQi+kY9ovh8LU7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=iris-sensing.com; dmarc=pass action=none
 header.from=iris-sensing.com; dkim=pass header.d=iris-sensing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iris-sensing.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kJy06ltDgpL34pAwZWM1V+WMRgo/7mPFLxa4GMngmEk=;
 b=USHeHIG+qJiXLWjVLhDjci7fsQJMYj38dTtyYx6JkU8CKHiCR0b2eB5j2fuZK1xHptIHk4L5WQ2K5wksbq3fPt8RSHQDDLTk+4L6MVLNQqePG8inGwCYOZhnJW2zdwy59j1KyFYkA9+YuRezi5uWCp4+6+nE/qEMrUnFE3PKjxg85eX63CIJuVcBk6PLA6u5d6TJ8ZsluH8PUIMdDhTwkKEuyclSp2vZYX+8tQYPHYTsW02V2zeypeNUjgrZn3kjt+9ddu9BVlE2yiklNXkybVXcZiyq3flEY8h5OAI+4dFwBLl/HD/7pZnaLns9IWjkaJOCRMvI9Wbl5rYV8jG1HA==
Received: from FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:23::8) by
 FR0P281MB2047.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:29::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.16; Thu, 20 Feb 2025 10:18:17 +0000
Received: from FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d685:f312:e114:519e]) by FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
 ([fe80::d685:f312:e114:519e%3]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 10:18:17 +0000
From: Erik Schumacher <erik.schumacher@iris-sensing.com>
CC: "linux@roeck-us.net" <linux@roeck-us.net>, "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "jdelvare@suse.com" <jdelvare@suse.com>
Subject: [PATCH] hwmon: (ad7314) Validate leading zero bit and return error
Thread-Topic: [PATCH] hwmon: (ad7314) Validate leading zero bit and return
 error
Thread-Index: AQHbg4DCZYgTN21mOU+h0PycRP5rAw==
Date: Thu, 20 Feb 2025 10:18:17 +0000
Message-ID: <c54ef4dd7b562268768200239b00441a74b547c3.camel@iris-sensing.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=iris-sensing.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR0P281MB2809:EE_|FR0P281MB2047:EE_
x-ms-office365-filtering-correlation-id: 4eceffe9-e758-4c10-af51-08dd5197e4c1
x-ms-exchange-atpmessageproperties: SA
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UThlNnIwd2VSS0RVa3JOVVU0WE9RdnFuK0I3M0QwQXdhbWpKRCtsSldZdDcv?=
 =?utf-8?B?QjJ6WnBXeWtZZ1AwRG1DSkNpQVdxRlVJdzVQaVIwSURkQnRtRDlISkt1R2h6?=
 =?utf-8?B?c1JZUFFKd0xseWk1dlArOFdnUzA0NU92Sm53Z2kxNVA4SzY1RkJSTVM0Yjhy?=
 =?utf-8?B?SFFJUmF6bzY0Q0lsZXF4MXhiTTRhTy9KQlduWnpzb284R0Q3Um92UXRlRW00?=
 =?utf-8?B?bVQ2VEEzTmtTWWQ3ek9Pbk40V2JLR2dkWjRJRm9abE1IN3AxbThBalg4N1BO?=
 =?utf-8?B?bnpoYXphL3MrMWkyaGJVK3dBdWNqSFV4blZxSU4rSUtOVGtVdzhVQWxFWVdQ?=
 =?utf-8?B?bmpPc3pRZVhDMDZsUmh6WWJXbDkweGZRNXRDNnhRSDEvWjBCS0RZRWVCQ3pM?=
 =?utf-8?B?OHYzY3g2ZmV6d1hvZ1h4RU9JU0hNdTA5Y2VyWnI2ZWlRN25TK3IvTUQwSndk?=
 =?utf-8?B?SDVZaUlEcy80aDFrU2N5dS9qWnRzS2pXSlRRM1pERDBLd0J0WVFObmlnbGh2?=
 =?utf-8?B?VjVlMDRwZ05ERWtxWVNYeXVQK1gwMlFzWDMwR2JDNGY5NFp6czQyR2p5bkIz?=
 =?utf-8?B?UHdJNjJvTDh0ejcyUE5yOHQxK1RwQXViL3FxY05XTVA2RXhyVFk0Q1ZaRC9N?=
 =?utf-8?B?cWJlTm9lWlJxbWd4YTYzUkpaVzJQYkVLNXkrTXhCSUQ2bEZKSW9paWRJYnZN?=
 =?utf-8?B?eUpTcjIvWWZSU3dkYUJhbkEwRkNRakZqUjh3alo0NGlTT01zQ1c4NXVyNWRH?=
 =?utf-8?B?dzQ2eVk4eVRJcDRCR3FEQnp5TGpoWGhmc3RCKzBoVTNmVGZ5ZVBYSlhmcnVp?=
 =?utf-8?B?amtVWnJhWlkzSUdnL0h5b1JmQnBFdllYbTFuUVpEbjVvcjNmcGJNS1JTSW5m?=
 =?utf-8?B?WFpYMytZeDJLMmRPMFBUS3hhQjdHU0oxR256U0ZOSWZRY2U3MHFjRElVZWI3?=
 =?utf-8?B?OWl2eFcrTWk2L2dVaDZXckpZZmduYUorcis2dkFJZWVvY0tYTThBTFVDdEd6?=
 =?utf-8?B?MjFidmRRVU1EdktCRFJnT1BOaEhabFBZc0VTOWxVa1g1NDZyQW9qMEdsN1hD?=
 =?utf-8?B?Z0xkMjRlZjgyUzhKeHpvWGkxNzV5aUM3Z0pPTWJLSUI0ZnJRaGhZbGsxN1VG?=
 =?utf-8?B?RlBwOVpmRHRFSkdheUI4d1JrdEUrT0JMb0FxeVFud0htam1ndmJmamVsSnFy?=
 =?utf-8?B?dXlkRHpjTjMxa2VGU2Rxa01sajh6VEZiSFlrR3JiUUl3MDRPdlVJaUdGcUUz?=
 =?utf-8?B?dUpDd28yZnRhYlZGWmpndlFmaWw1YmxNMDZUZFBmUXVHS0JyMkhtOE5LSW82?=
 =?utf-8?B?cHN6MnlwMTE4dnNXa0tiZ3ZUWjdYT2RCcXRpU1gwbllCTTZtVjJCWTgwbWtl?=
 =?utf-8?B?eVNQNXBobFlBbGxnTzlqWGhGSHJoM25PdDdsSzRBMGFrL2xsQ1VUK1JwV2Fv?=
 =?utf-8?B?UlZ1K0hSK3pZNWo3eFFnQk1LOTRFbGRGNXdqQ3VZSkFXQlE5SHpzak1OWVEz?=
 =?utf-8?B?b0Zxc09ha2RxMVdDaFU2L3IzU2hLYlJicG9EbUFJRmN2QkRrc1ZTWXZueFl3?=
 =?utf-8?B?QVRYYnJuWFhGcmptZ3ZaNVRaYmtjblhRZnErM2RYb0FNbUJYbWFBTGdOd2hu?=
 =?utf-8?B?Mk9TVjZnbG9IZHVNRlRzck5ON01YR2dmMEdCRXFBQ0hyUFphTjRFQnRkK2FV?=
 =?utf-8?B?aWhoYkZiVlJJdHd1dDVLbm13U3c4bmlWNndyZ3FabkJNSFdQNTRVZkF2S0Jh?=
 =?utf-8?B?V2tsMlRqSEhZS1V0NkRDYm9iWG5mK1JzWWNYZ0RuNUVEdzVSa2RxT0VtMUp6?=
 =?utf-8?B?L09MQUR3c21qMVBNWTgyQ1ZxeE1yUlJrVXZtbklOeUIvOE9ORTI0NTZkYUt1?=
 =?utf-8?B?UGhGU2R5S2xZZmduVHc1QXhZVFBxWk1LZ3ljWTZwRzJVTnVNSWdKSVFQYzRx?=
 =?utf-8?Q?RrcBtUjnf8c=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?dCtLSXV4OElsbzg0TmJhY09KYmdLbkZUcWg3SG9QRS9tM3BKazNyVHk0aVpS?=
 =?utf-8?B?Z3g2QXJDUVp6eDRCRTZEUTFJUHp6RnJPMkUwSjVYd05MRHZnTkJzOTRLOTl5?=
 =?utf-8?B?QTA3Nnp4cVlMYjdrNWJveXd2OTBjWjhOMklXMXVJRnZHNkMySW1FVER3UjAr?=
 =?utf-8?B?SUlVTWltUEZoWmJZckNZMmtENENxem84bEJqbmZUbFd1bFlBcmdyTm5XSkFV?=
 =?utf-8?B?WTdEUkFPOE8yekhrNnBKUEQ5dlFtMk42QW5VMTE3a3c5MFZwS0k2bFhMUnJk?=
 =?utf-8?B?aGJyV1dOYVhKaTlCQ2wzRVYxVndvMzRxYk9QTlNHWTN2OTNtQm96QTZCL0JB?=
 =?utf-8?B?dlZWNVR3SmQ3Tit2aXZ0Smk1UmVaUWZkaUUxUXF3RW9aRWJFNE5OeUg0TTJT?=
 =?utf-8?B?cWRSRGd2WUlsT1Z2SzRnbmRiNGJGSXNybE8xZTl2eHZLVk93SUJuWXcrN2h6?=
 =?utf-8?B?bTFyZWtrY3pSTnF4cFozZXgxei9Kd21BRWV2YlE5UHZFR0hTTkt0ZHdCMWtB?=
 =?utf-8?B?b2NtaTMxVVQvYlVsTk1FN1F1bTVJRk1Md2s5T1JNMGZ0Qk1MR2RsRzRFZklJ?=
 =?utf-8?B?ZVVSeXpwb0lDYXR2dFJkWUlKbEVvSGF2NG9seDc1M2N5aTVOMS9ONVgzclhP?=
 =?utf-8?B?dDN1aUg1MDVQaHhqM3hLYVoyblBqY3RYVWkvMWFBT2w2dUNaMnVOalR0RlRa?=
 =?utf-8?B?M0kwRVlWOWV3TkFja1AwK1JXd2Y2QUhYWThjaCtRN1hLWjMwdTVJcjJGM0lj?=
 =?utf-8?B?L2NqYTNRbnRFT0h5VER2ellld093NXBZQzVUSVFDL1VHaURUUjV6eXQwT3R4?=
 =?utf-8?B?ckdjR1AzVm5rNit1QXgrNjc3RWVGdjdFeVJmUGlWS2lMR0JTaStrSThUb3hO?=
 =?utf-8?B?SFJTUmoreFBqaWVzUnNSNG5HVnUrcEZJZSs4dStKOGFTcnVvTXZYNEVHMGxN?=
 =?utf-8?B?a21mRUQ0cFFSUks2dndQRUgvdW5NdC9yME1ISFhnWUJ2bitLMDBIWVpicGJ2?=
 =?utf-8?B?b3ZzWEhsL2ZldzlUd1BHQ1FJcUV6TFMxSFhLcTlPSW5uUzZMdUZXUktGajA5?=
 =?utf-8?B?VTc4djd4U3JKaDJaUUdKSXYyVG8rSUNjRmV4d0dHa1Q3dU81Um55MDdPUGRp?=
 =?utf-8?B?ck5TYzhDdG5BRkR0K2RxcHlqMkFpcC9xK0w4RjNsZDJ4WE1HaUUvRGs1VDR1?=
 =?utf-8?B?aGxpNG9TQXZaZWQxNkNyV0RzMkk1bDcvU1pnOHVLK1o1Ym9VSEdHTitaUDJs?=
 =?utf-8?B?aTFuc1pFYkI5TWk4OVg3OG1kdlJ4Tmd0SXRmV3NvVHRSd3FNaU0rc1ZRKzg3?=
 =?utf-8?B?K0ZPdU9xc0ZmN0JiUVZuZnZMajloS29WSThGYXJDYnBZa2t6MHp4OUFpOU5Y?=
 =?utf-8?B?WEJ4RmNSaUdwR0xWc0pOOWp1Z1orSWtiWVdMSjU2SVhybllSa3BLalNaVVlx?=
 =?utf-8?B?T2QvT2JyYWpjUThibFlHZXliSVowZVpjWDBCSGtnT1E0UHJhbW56aUl5aEQw?=
 =?utf-8?B?TkZqbnNCcFhNaVVybG0rcTg3Q29YV05hczduT0FDVHBWZDlaTFdGR09waE9Y?=
 =?utf-8?B?YWYzYTBjNjFqUHlRSlJjb24yWEVQZmdYaER1am82RHpSeWxIOXNWcnFxREtp?=
 =?utf-8?B?QU1kMzgyZGdVb2U5N1BzUHBSS1A2UjRzMndoamYyMDNhVHA1K25UWFh6ekQ1?=
 =?utf-8?B?WU5SLzhvbmVPZERjRDFzL3FZcWdWanpKYzd3UTZxcjJ3ZmZjWkNKVnk0a0FY?=
 =?utf-8?B?SWZtdkRWMVU5eThlZXlyTm1mVmZUN3F6cnpMS0JHMTFZcUFTUDNEMmlGMlEx?=
 =?utf-8?B?MzhrRTZvK0tCVWhET3Zac2U0dkR1TWkwM2I3bTZTY0dTb1lHcHJabTJtNng1?=
 =?utf-8?B?QlFlN2Rjb2xZbGtlTlV1ZzhSRExORWF2NjNnMTZwalFrZEQ1QlFXa0Jqei9p?=
 =?utf-8?B?MjNlUDBRTWgzZGR3ODRTUXJna0Rwem5nYTFNV2dSWUQzdzZveHVudVpwR0Nh?=
 =?utf-8?B?cUpreTE5VERqZXY5YW51TjF3VUQ1WjJGN1hTaktlRENrVEx4TFpkTWR5M2hh?=
 =?utf-8?B?K3lXbk11U1FuWnNVSlhYeWVQekk0NmNSeitTN3gvYmpCK05HbDFFRk4vcFlS?=
 =?utf-8?B?TG9rU290VDVnRWR4SlZDOUtCOXFkWTVBbFphcWVPT2toblJlZGxmV2s5bG9Z?=
 =?utf-8?Q?lNqIjOtNaYFRFAs6pbwMhcQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <24D7CCA1DB3E894AA79A7E9173164538@DEUP281.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: iris-sensing.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR0P281MB2809.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4eceffe9-e758-4c10-af51-08dd5197e4c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2025 10:18:17.6103
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 963f3913-ffae-43fd-856b-2dfd3f6604e3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XBeWspnq7gNx7ojyYJ3fXOKTXluyeZX8xuZlvFmELwzQySONjgOD38A/KE2rywoqhh3BXZh3ymyERDZ0sQ2A5kaTy5wBmMPEsrR//QDmmf/Zx09TsAbuqsVRSb8WJ0m5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FR0P281MB2047

QSBsZWFkaW5nIHplcm8gYml0IGlzIHNlbnQgb24gdGhlIGJ1cyBiZWZvcmUgdGhlIHRlbXBlcmF0
dXJlIHZhbHVlIGlzDQp0cmFuc21pdHRlZC4gSWYgdGhpcyBiaXQgaXMgaGlnaCwgdGhlIGNvbm5l
Y3Rpb24gbWlnaHQgYmUgdW5zdGFibGUgb3IgaXQNCmNvdWxkIG1lYW4gdGhhdCBubyBBRDczMTQg
KG9yIGNvbXBhdGlibGUpIGlzIGNvbm5lY3RlZCBvbiB0aGUgYnVzLg0KUmV0dXJuIC1FTlhJTyBp
biB0aGF0IGNhc2UuDQoNClNpZ25lZC1vZmYtYnk6IEVyaWsgU2NodW1hY2hlciA8ZXJpay5zY2h1
bWFjaGVyQGlyaXMtc2Vuc2luZy5jb20+DQotLS0NCiBkcml2ZXJzL2h3bW9uL2FkNzMxNC5jIHwg
NCArKysrDQogMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9od21vbi9hZDczMTQuYyBiL2RyaXZlcnMvaHdtb24vYWQ3MzE0LmMNCmluZGV4IDc4
MDJiYmY1Zjk1OC4uMDI1ODQ2ZjFmMThiIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9od21vbi9hZDcz
MTQuYw0KKysrIGIvZHJpdmVycy9od21vbi9hZDczMTQuYw0KQEAgLTY1LDYgKzY1LDEwIEBAIHN0
YXRpYyBzc2l6ZV90IGFkNzMxNF90ZW1wZXJhdHVyZV9zaG93KHN0cnVjdCBkZXZpY2UgKmRldiwN
CiAJCXJldHVybiByZXQ7DQogCXN3aXRjaCAoc3BpX2dldF9kZXZpY2VfaWQoY2hpcC0+c3BpX2Rl
diktPmRyaXZlcl9kYXRhKSB7DQogCWNhc2UgYWQ3MzE0Og0KKwkJaWYgKHJldCAmIEJJVCgxNSkp
IHsNCisJCQkvKiBJbnZhbGlkIHJlYWQtb3V0LCBsZWFkaW5nIHplcm8gYml0IGlzIG1pc3Npbmcg
Ki8NCisJCQlyZXR1cm4gLUVOWElPOw0KKwkJfQ0KIAkJZGF0YSA9IChyZXQgJiBBRDczMTRfVEVN
UF9NQVNLKSA+PiBBRDczMTRfVEVNUF9TSElGVDsNCiAJCWRhdGEgPSBzaWduX2V4dGVuZDMyKGRh
dGEsIDkpOw0KIA0KLS0gDQoyLjQ4LjENCg0K

