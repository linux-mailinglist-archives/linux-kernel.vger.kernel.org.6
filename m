Return-Path: <linux-kernel+bounces-301409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D44A95F02E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 13:53:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBDE51F24A1F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 11:53:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49D1156241;
	Mon, 26 Aug 2024 11:53:25 +0000 (UTC)
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.164])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6397E154BFB
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 11:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.154.164
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673205; cv=fail; b=JISExUMLEkr2evWLdgjHVomqOjutGmRvfTR5NSwI/40UDd7iJaPu2CRzRCSDm/xWW25Qk7kdIwKZJsE8gahnRmwhzAnwHpnbJqlgkfB+M257GWQeIF75RcOD/qlZ1BDyFvFkV6tPqbH3DLSQEBLpZlujxYcsIRJCNKwyK/QlXzQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673205; c=relaxed/simple;
	bh=Ym7RF2gA/cOVXs8HJu8q1nQE+/uJT1oml3ACprE78Cw=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KgxGKiJSO8vactQCTs04DinvOn8ydqkakzwXX8a/iikRQ92vIkk881IAQaMeEmJCPwpPsdnj5NxQ0gqyNgjwbhMgE1EHza9SPQzhtvUsX+48PyOi9HeIxZPTuzBvo3nPMsG+5jLFw1cMUoMwp3XvN/HgbQwPUwY3o5baNtqvekE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=educatalysthub.tech; spf=pass smtp.mailfrom=educatalysthub.tech; arc=fail smtp.client-ip=67.231.154.164
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=educatalysthub.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=educatalysthub.tech
X-Virus-Scanned: Proofpoint Essentials engine
Received: from IND01-BMX-obe.outbound.protection.outlook.com (mail-bmxind01lp2233.outbound.protection.outlook.com [104.47.74.233])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 699168C0073
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 11:53:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eom2BTtmZambzbUlhpaGWeORc0JRl88r87RIL9zPUleLpoGSkT3YS7iUH4iUDtc/ZiQ5aqKglQVRJYAdReuEzYO00qvkDYTtuKG8gG/XRkNqXBoi+I3BnQ08nFfnTNfiWfnlJseU/jzGEZCjzJIeOrE4Fm300WLQOUZgo1o4LPTSHMeZBEK7AyrQ34cFdiGKO/H2Ej4oWLsjE1ZqsxEbgbH3151omztWI7RPcex1/S3mE9WrksziQvQIVtMmCJyIZJsKxTCX2ty1jL5RkmT5B3D6d8wc3GR8ZYD4DdvTeM4AniMBaIFZmbeKOTVxhsXHEvOCK53J5PWfGVNoZrfpEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1kzJHMKSzZVAoCwqv80m4dAYcMyxMmZgAqm62jkw214=;
 b=O2XONkkrR0jM7dSa/rBzTmjC3g9VL2aZVTEPoTR19srAyBqhPXNLqf9dq3wZbVOWnvnMANIS2U76KSIWCuaj+xu03/QqQyR2DdzFV/sTOyzniUTjjTeu/47EIt8cWhMqq1fQgZP5DQ4mFFru24Hdmm/sOnc4+7HajPQfVQwcyk1uQPNB/VjFvsvKan+zAZ7G6SFnnCg/dVL7x1Q6Gs2v/YfBclVXvo4qv7Mv9rYyr89SNfcKDOndfYyC3DdXOQqaRhGrx7OmsJOfREXpQLwloMtUqlSixSrqJpu+RNy1sGXUvT2+W6J/DFJy+KfkrId/ZVnCAZe6OOZSnt8GLTVFwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=educatalysthub.tech; dmarc=pass action=none
 header.from=educatalysthub.tech; dkim=pass header.d=educatalysthub.tech;
 arc=none
Received: from PN3P287MB2845.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:20f::13)
 by PN3P287MB0387.INDP287.PROD.OUTLOOK.COM (2603:1096:c01:d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.23; Mon, 26 Aug
 2024 11:53:12 +0000
Received: from PN3P287MB2845.INDP287.PROD.OUTLOOK.COM
 ([fe80::568c:6557:ed67:d933]) by PN3P287MB2845.INDP287.PROD.OUTLOOK.COM
 ([fe80::568c:6557:ed67:d933%5]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 11:53:12 +0000
From: Lily Green <lily.green@educatalysthub.tech>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: School Districts Contacts (Updated By Aug-2024)
Thread-Topic: Re: School Districts Contacts (Updated By Aug-2024)
Thread-Index: Adr3pjJlaLEwZBeVsk2uctBegIP0Yw==
Disposition-Notification-To: Lily Green <lily.green@educatalysthub.tech>
Date: Mon, 26 Aug 2024 11:53:12 +0000
Message-ID:
 <PN3P287MB2845F1C27C97075F3E0388F4858B2@PN3P287MB2845.INDP287.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=educatalysthub.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PN3P287MB2845:EE_|PN3P287MB0387:EE_
x-ms-office365-filtering-correlation-id: 9ca5e991-3417-4ead-d90a-08dcc5c5a974
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?czorpomxMNoJOD5ilaF8sayyEkB68bBHSpdAB0SzjV8JEqGx2wwGIUFrh4Ww?=
 =?us-ascii?Q?UmZqmMxEXRDcHmWJOo/wCTOOyMV+8/XS+gMFvJin0RVtgQ7vvanB5+OpzGXT?=
 =?us-ascii?Q?2LaMq8PxDbnl8gFTZ0L7ti1c5YAcmkxFpssShno05EoBv+s+ZvNKtWBfVIHN?=
 =?us-ascii?Q?wTywZsBk6jW/KUjxz4RFNbfpS8o51u9aAg+XE7eqabMTesiEW6se9dI0nuu2?=
 =?us-ascii?Q?9noYtXlimAZSFGdHQ+S+wFTIfgCYW0vYaA9shwQiXOwdE84swM4PzezYP3Sw?=
 =?us-ascii?Q?8YlQwkMV/Dr7rsgRtXu3GeFm5UzqTu2K4hhnqdoMH4Fj3IN8K97lsXd0jXJf?=
 =?us-ascii?Q?b9EvP/Na5nlIVkswwqH9dYP0HEQURSqAv9resbrZOGXdtMRERI5cyK6co73N?=
 =?us-ascii?Q?jKrdNkFVIhu8rzPlhCh6dYU9EkhrAaZaZHIWeliKZpo4NjEbre5Q/UJ3Q4Gy?=
 =?us-ascii?Q?h3zLB8drboMGhSeVC2nWFVj5LZeJR+O5jRIOaYny8mJY3aV942SA7PIvLzq3?=
 =?us-ascii?Q?9+OZ0IuXkQs9kIVFwecDnt/zYocTpRD5PAOqVN13tKMkqLD+JBS4tjtP0NSz?=
 =?us-ascii?Q?4NfMT05SPL2VsQihtTkmeviO0gwYpsQShxRN2381eOxWb9qz9HvFNpDl5klJ?=
 =?us-ascii?Q?IuqsNolGDl9WBQZM4ZxBDORqAmqA2fp1FgPRs2R/cEnTtOwZek7scee5BB+1?=
 =?us-ascii?Q?QUHiSv4HY3BaatqACmirf2uGW7fpgkgfi/jityybem4vmGG1XAg2rkrDhtAV?=
 =?us-ascii?Q?Kdve9XsgaiMnBtuByTuUlD5RNen6wLAfuCPUZVXT/PkEIL8k9iAEm0YlVqu2?=
 =?us-ascii?Q?E1kG9BkbHyJJUoVtyV+9YpAZ6yBKxqDLn3uVLPQqvHElXpaaU7whxdRvIhhH?=
 =?us-ascii?Q?9LHwdQc7jAf7XFTM2macvi3l1tctkWS4z70Udj2SYylmlY4gHaCRNZtpZ1t7?=
 =?us-ascii?Q?2AnYXqG3soCUFzMaTkAlNgS9L1YKO6WgDZs8Ts/rJuztYz8fuWlMzKQp4sqM?=
 =?us-ascii?Q?RTKGgUdKAS9SI/2O/TVmAUD8QmAQQu/5wPDWS3qJ6tCLPWgKQyoJBLtA0vti?=
 =?us-ascii?Q?+dzMKfoCkpPg07ksyRmVI8mSC91GYBB3ySLmQhMjOccuWwIg4Sfosoo4S0Nl?=
 =?us-ascii?Q?dW4sVqrzMs512A3fp+K1sKeq8DKL4mZ8jhNFAlVdQk235YgNGiHJq1ejavQW?=
 =?us-ascii?Q?Gyil7DZKT77b0yAMhmTs//rDzEY2vcvr12jH7UsT8Qq1aWYdn62f8/hVo9jI?=
 =?us-ascii?Q?YfH6BGsZ9XwbTjfzFSK0eFViSUhcLlgUTPe6D38hq1X9mJVfNyuHnTxACt83?=
 =?us-ascii?Q?Gp8r9Wqc+13R3od3ypENNCKCcRxPIXw5/OF1/jTeI6di9NRpIO7BQ7dE1Kwv?=
 =?us-ascii?Q?H7ZLSihOizWJRhbUqyD6z60dY9x+U4nctttQtYuHkuDZEGwerg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PN3P287MB2845.INDP287.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?RT3Zv7EOuVZE+BFiwJ/z09f29Lcq34/PzZSNbyySwLsPISDVMa5Ek1AeLO+g?=
 =?us-ascii?Q?+65Kkh2j6+/D25Dwhse4jtxeQ9y6ilSFvPy8aoxNk0E5HAJPqgA4QMBKF9oI?=
 =?us-ascii?Q?4kvZ1NtW80HJAPS3MMn+u64CESnBt5gxa7aGSKsHLKqphQQwy+425B49GXsb?=
 =?us-ascii?Q?07PEzyGCWX5xLIqxrNAQqO9pmKm0YJDxYr01KpTaqx5L7sacz8qFtIdeLcdg?=
 =?us-ascii?Q?PTgi6NgMmJ5dCtEClO4k+Hvu0M0qQf8rAC07nfhy7ZHAueD92QP6iFRlOtcZ?=
 =?us-ascii?Q?U5qbfBm/41q+/snltZpIfNB1VynpKCn3SDm8wFqu4SWxGADQX7fLe3HNR69X?=
 =?us-ascii?Q?GXWmC3RJJza1NsbEEcFWjMgPTxnXDtJo2EY99VCXOM7AkzY/u5wi5UvrOXfT?=
 =?us-ascii?Q?2BFdMQADX/359M+13fJMZc/DI4IoyTX7FaTZJZqyL5esN5eUpcivQIJwwJIE?=
 =?us-ascii?Q?J86/q7hljMQPJvvCfEwXQbBxSfoMHa21AX2TmzdTMDq5l/S38niPlj6V0Irw?=
 =?us-ascii?Q?W+bYGqWj1aQkUC8QfhVjaPLvrJcMves4+Traba4hF2NdaN+Annjh1Y9O/yGC?=
 =?us-ascii?Q?LGBvh6fikfbqk4j3UBLhKlFNTzvoTwwZ5G0Wn/Cb5x7br3/T/p8WwcoPUfUE?=
 =?us-ascii?Q?ASgrZjkJrhobLoD0a0qDaYnJyVh3yhNAw9kE5NeTspoQHGz/Q3n+Rz8DG9rT?=
 =?us-ascii?Q?/Q4K3hEyz7zNRAIiFNXz21cBkA6oqqqhJeU3k/gqbcBEOnDvSDHRfkmroxOa?=
 =?us-ascii?Q?Eh4GQiUpa62nZFXL8I5zbpvQTROzwJFLvm6XIAk7FRLBH1nP1iEGg4KKw5es?=
 =?us-ascii?Q?CAALuUxL5dOV7thbdrnXAaUf00AW/2DlEyiaK/gxMnu4tS82gUGXvYX07mNh?=
 =?us-ascii?Q?e84mC5N/U4DcShz1XQsCSB79IP7nDMnSjDFFz9sqVR4znY1sHcbXiP8u+Wqh?=
 =?us-ascii?Q?ebzInQb+tpn1RhW/FcPiLiiCHONgN+QPU5FN7hElhO6HJ9q2pQuIPcye3sk/?=
 =?us-ascii?Q?Ht9xufsIpi+fHtnQG1iSpwzNmXaXfcFmdHa75NHB1lmSYmGh/imi0zEu9Vh8?=
 =?us-ascii?Q?4Wh+IZiW3cRVFQgqzDSF+WXXdJRk2x8TuRL9Xv/LiJLDyBVuGmOUOqIxjjyV?=
 =?us-ascii?Q?/UljBvGHZnhkya+ZKO6tyoL9ptcO04kjw1l17+tTJ4bx86Rf9I1Ic8l9m6ep?=
 =?us-ascii?Q?Om+lLSgaHHKcCaaBhtHEf3mRNH14XAc3uguHfAGj9mtqkabdrBXfgD9uguco?=
 =?us-ascii?Q?b25oV3SjdKkdcIcZDJJHWElCILaLL/FhVC7ucfDzBM3yrwEP3ClQSgHsptn0?=
 =?us-ascii?Q?GaKj1GRqIHmp4CSj62CYMWhpP2re8VT0KAwrbrLWz7KA0iw4otijzzgUBhq3?=
 =?us-ascii?Q?R0Lup/DE0uE4cmO6rtS9KoFufe3NaJakXse+/lsU5AO3MKHOSE6du8IyNwms?=
 =?us-ascii?Q?GkZ/ZwC8IDx81lJWYYiiths+Hh9pOy5bnojb/7dyYN6xCGo9aa6L5VP7FHCb?=
 =?us-ascii?Q?0VyqO4ZoF8v81z3TXuVwwea9lXlds6Ae173L71Ksh9ofaasKnWvL3HRR9fQw?=
 =?us-ascii?Q?CfC2ROaF+80+57cxYyMkxK1ZT5FQgo02bLqoUFHVkNaUweIYWJ7SaHTp2s7d?=
 =?us-ascii?Q?mX8pVaA+PMzL5taytJ48lTpIOcWe9rNp9vH2/hWbqWMqIhEp6/Xq0LLWyBkh?=
 =?us-ascii?Q?Jbqs7g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FYXG40xTVioB9vJ0jkCMKiwgcTnFO3IcqASWAQoyOmBPpkTtkGnW4wIf/q2wJAJQcwrvxW7kR+SeOQjXgYc0+poXrkyzDRCuqO+TyAhYljVAOK+gVk9SOt3jhoLpEzb53xWOz7twep4C7upqLT3+tAjEUHZ3F/dLc8JOcVJz3EfgG5TknSN1+tLBXd5u04lxTvk8jBguEUWRoO3wMUwrPhyArhKVM6gM2CQPyt7+HD/rHjb0g2ScpcyvIR495CeLD/c5BZc9qIn5eFt9HjDiUG+5+xy9QbuiBhBiilILhxB5VgbkJGdhDLsyT7TJLTo3aX6+dgl1MivZA1TGobIP3vrpiEZb6nGF+wgMwlIgXrLy49/KIsJFUecW4PqwaguYTEH4OvxFivD313+rBV8ngFWKvtZ2u6+2q5HUVhCCyZTBAQScWVmcgKRrQNgl7uPcJsd/n9RCmdw6clFaFxXCG+L2QwvNilBkeO+mSLh99pz3i+PGL1EAEj3HjxYwbYyFuJywo4kx8+FngI1QvBrPO1RfCT7SpWbwzINQLzvp+CyzptYAlbDhlnWLvb29M4R/7nlllJhDLbFUkc0e7ybmyNZbRRH1knpA74H7VG8i1wM=
X-OriginatorOrg: educatalysthub.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PN3P287MB2845.INDP287.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca5e991-3417-4ead-d90a-08dcc5c5a974
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Aug 2024 11:53:12.1510
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: e365ff34-85ca-4d9e-869a-17889878f5ae
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XCdTS5Umfg75sgSsEoC7O93mXicZ4bGsNX8RUCW3lnmPmYb5+DqSUYIdTPpFx2tWtPxEaJydhEB5DV2hMwTIc3S3hE84oHOMpJiOKEs5VOM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PN3P287MB0387
X-MDID: 1724673196-hml1k2M1o5Tk
X-MDID-O:
 us4;at1;1724673196;hml1k2M1o5Tk;<lily.green@educatalysthub.tech>;c71d53d8b4bf163c84f4470b0e4d7294

Hi there,

Want to expand your outreach to K-12 schools, colleges, universities? Our e=
mail list of principals, superintendents, and key decision-makers is ideal =
for you!

Our List Includes:

*       Principals
*       Superintendents
*       Board Members
*       Department Heads

List Contains:- First Name, Last Name, Title, Email, Company Name, Phone Nu=
mbers, etc. in an Excel sheet..

If you're interested, we would be happy to provide you with relevant counts=
, cost and a test file based on your specific requirements.

Looking forward to hearing from you.

Best regards,
Lily Green

To remove yourself from this mailing list, please reply with the subject li=
ne "LEAVE US."



