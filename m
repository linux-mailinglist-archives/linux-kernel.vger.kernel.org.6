Return-Path: <linux-kernel+bounces-574116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2B92A6E0CE
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 18:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF4707A4643
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 17:27:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0968B2641DE;
	Mon, 24 Mar 2025 17:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="WkmyYvk+"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10olkn2011.outbound.protection.outlook.com [40.92.42.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB022E3374
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.42.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837314; cv=fail; b=PmDueJ8TH7reE5a1fesZZ4irWmea8JvDVX/VzR697kOsyFO7JdcXDFxYSVb3TrdIRZQd5lfMBPHx2MjlY/0VH0AgxizaGgMl0LYrU45zJo6VdyhItvP7oTH2vD8eBNBCm/204GHZau89VXnUnGKn0ZLbgEXRHr3jUugtgiigMZs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837314; c=relaxed/simple;
	bh=UZO7uZs/V9Qm1uIjvhRTsLrH14D+CECd5RxS4HkY0jA=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=DqHfwrgIu4ly9fb3hHjqevDS9DkffLZ4anCExUK4yKUzGcZjHqucuQH57JeBZjW7Y/d14dfYYZ0y4obvIUl/4HBNdgH6SfOwlOaWPwQT6v34HfNZD5++8TmbuQCl5ZyfSamc2Nba/VVOncRhsghzyRtXiM7/8oAnGeZqCueNkVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=WkmyYvk+; arc=fail smtp.client-ip=40.92.42.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQIKQlRL23gf4eNTq+kBDedsmUt3FsDnQEgmE2+whJh22XF1D0nLayHQgBeDDaK6Led5X6PeD/uAjYHhnVspd8VuEhw21fp3QTG2pZ5uNrHxH+QduVL1nlxJja7tU4LUrbR+f1mIXOuK6RAAGIQdoDZizwhVCJn/RJoPk30Jb+jx2hfvth41P/tnEeSGq4YKda7qvG3/VYXiMizv0vd7LPy8U1mMaEDAbukJDOuL7MnH79+j7fmZWKGe+HriwExifO44HoGgwkSSuXGMLmwA+8RuLlxOZ10mYyn5Qcj7tBhzFokFgwA8g+6AVSdNt6C8ATBY0WHzGumUGfmuko0Dzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UZO7uZs/V9Qm1uIjvhRTsLrH14D+CECd5RxS4HkY0jA=;
 b=cf3MK/KCFszVlAfx8WXlYMZ4/r1ysGvGA2VIfX8/dyXBFXyCYkCEAeXow5vMceQ7Mq4PCPX+NCWSuhdVPmAsQn6vkXJLYlKMl023dqT33fXzTY3ePFLlLlT7oBtZsfoIdR8bE+yPCFZTPUHiyWaRWBNuxemQd36CInbtk0GghMKI4/T9u/S+1WLQNcV+fwYtzVkwwdzUeKLd1HjkLSXfso8sgMvXu/V8A2zxvebJ8pxyTHgIQGoCcq6gGVCo9pL6DAPMzmV55qSCNieAeGQm4676cNdFaCcb9Sx2JrlQYxlRnhRIi9+U6XzPRtEUhB4tJId8mIgub2vFIoGNfpFmbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UZO7uZs/V9Qm1uIjvhRTsLrH14D+CECd5RxS4HkY0jA=;
 b=WkmyYvk+eUUhia54t1Nc7wL+06PUZAnEzsURDPeoirBzBWUQc2P1ZmLsi0Z5IpQLXSkjZXd+V9ElJSDMFAh/RGYY7sJWUscHLh9XQB+63qUo60ZiKBIh2VECFdM/Ub4VaT2QbfeWNcqHKktYyhHrW3imSNKnzH9mY79mnqkxe0DDh+zYMhsvuctTrcduKQH8NVhhjfI2OdRVzTOp9nqI5c80WiSr1W+xIvJtV6EvvQvCsFSzudkUAO8Ve+6+/VthqPw/WM5KWwsZR7GU57wd9MMWcq7ckSUq0CMm0W0YHb3MqoGrxZL6gckYzbr2i1bbTmQGr24JrU0+uDRn25Tmhg==
Received: from BYAPR20MB2247.namprd20.prod.outlook.com (2603:10b6:a03:159::24)
 by DS0PR20MB4983.namprd20.prod.outlook.com (2603:10b6:8:c9::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.42; Mon, 24 Mar 2025 17:28:29 +0000
Received: from BYAPR20MB2247.namprd20.prod.outlook.com
 ([fe80::e60:961c:9981:2755]) by BYAPR20MB2247.namprd20.prod.outlook.com
 ([fe80::e60:961c:9981:2755%4]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 17:28:29 +0000
From: Ben Graham <ben.usmarketingdata@outlook.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject:
 =?Windows-1252?Q?ProMat_2025_Attendees_List_=96_Ideal_for_Lead_Generation?=
 =?Windows-1252?Q?_Success?=
Thread-Topic:
 =?Windows-1252?Q?ProMat_2025_Attendees_List_=96_Ideal_for_Lead_Generation?=
 =?Windows-1252?Q?_Success?=
Thread-Index: AduczI7Vkmz2jPq7SVWBdgRjOufDTA==
Disposition-Notification-To: Ben Graham <ben.usmarketingdata@outlook.com>
Date: Mon, 24 Mar 2025 17:28:29 +0000
Message-ID:
 <BYAPR20MB2247D0B34C76E90843D2A7D5E9A42@BYAPR20MB2247.namprd20.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BYAPR20MB2247:EE_|DS0PR20MB4983:EE_
x-ms-office365-filtering-correlation-id: e02c9c81-5041-40be-5ffc-08dd6af94b2a
x-microsoft-antispam:
 BCL:0;ARA:14566002|15080799006|461199028|8060799006|8062599003|19110799003|102099032|440099028|3412199025|41001999003;
x-microsoft-antispam-message-info:
 =?Windows-1252?Q?9Yhn3bPzjEdsG2m+FdvyxxuZX5me8kFD8O/hYANOh738/2QrtBIBBkkI?=
 =?Windows-1252?Q?7hInY93hK2737c5S0t5ZaPBo1OcgdoenVXRuylcq6dfSYStQQeAzzTW+?=
 =?Windows-1252?Q?x4Z9RObD0sFrQr3Oj96+wOpcN2Bjd1xpSCufORHkY4Pf72IugSXi1C/c?=
 =?Windows-1252?Q?aFFkHS8Hx7qmjKya2ItaTpMLEWwiKDjEzLapN9gYIgunuCEw8EhQAHFl?=
 =?Windows-1252?Q?QFH1Cy0kggq786alhMEYaV9/2IkEhkrpp+6i1nqPl2Jd+OZxteJGIeoR?=
 =?Windows-1252?Q?jBsh+D2WhL8kauugplJpc1J0rEuZflP4OUCbOGG4mvuMsW9oGyNZLTJS?=
 =?Windows-1252?Q?/BR7ztLJuzbMhqREPXJhTynWkbfcYCIUuDiW5fg7NU7c+x8Zq9tJn/I0?=
 =?Windows-1252?Q?8GFzv7P0Zl9CTXEX9FRiehADSASFJqENg9TPLo6nyIZfxYahg6g5u4On?=
 =?Windows-1252?Q?kaU473puzSTk1kAMnovCUo2EiK1vtngDeiuGTcG6zqN4UtNjWmFVTY8c?=
 =?Windows-1252?Q?8tTagYstrHKC82s/juAfJQfVu0c4SgUL25IAizUvZOTo9FbO13mAoIMk?=
 =?Windows-1252?Q?1F4QH292HRkbrjLIXVmDA0KZ6Qi1GRam+6gx9mVx2651/FRjSEKFihd7?=
 =?Windows-1252?Q?w9UQ+uvdYqWPfTXCxMyG+m+izJ7aUzqcHFsiJldPGVF6Kry+b5ZHQPBQ?=
 =?Windows-1252?Q?zlRgydfeCZ3cjnfSEI++cIMQcuekraNiFCLfSQ95hmrkiUkjN0xrBCQ3?=
 =?Windows-1252?Q?qwf0C0PohDtYq6UQLVSCRU81Zp9pg1vU/oykPyCrQS1tQr73vdmcydEy?=
 =?Windows-1252?Q?+0zBguWLPmJy4MifbPC58QOS1KIRDtMLexhCkW6nc5GlV0a0MGDiNmXL?=
 =?Windows-1252?Q?Jgm0mZt5Ikh5w1VqN6WffOaSUdZqepMEqJ6OCndHWeI1o77wroWTY4g0?=
 =?Windows-1252?Q?g15zafS1EigC4DXBsVGRUI1H8wmFjJLJnDYVyeKsubvJwvA8KPVJfP5f?=
 =?Windows-1252?Q?+gUJklyDqy9hN4HW4hrrHmEpWM3XcwWutXjEbvJSmmEnzmn+GOxMsnBU?=
 =?Windows-1252?Q?mKWyDfIwOFl6x0YAQXpBz4sccQZQlGM++F98i5g1qwaIk7sgHllx0Bnx?=
 =?Windows-1252?Q?uCZwAA7xqq0lWEbON6WAAZyvBh521GMlh2cDWvPhCOgitimP6LUpjMXk?=
 =?Windows-1252?Q?kHluPuOpnJE=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?Windows-1252?Q?pyIc0ukre0PzLC0xxq/b8H9vEsaH4mSHl8d8gb933n1dbnvDr+D1/46W?=
 =?Windows-1252?Q?L8Q8rYsu0WSvXCPf+tXod7wnxncT7onaqWUC5nC7mwXzHapuvuvhw0fz?=
 =?Windows-1252?Q?Wf+dtdjBUBMZlDb9c4Y09CYeJ6HdU5+Z5yCKnVRpty6DAG2dYfvBGKKK?=
 =?Windows-1252?Q?CqWbmCi3lR8DmFYGa0XmD5/LmLM5eq2WNjb5Qn6UtwMpGCvC1scOWtIg?=
 =?Windows-1252?Q?yHBzJFEveLpXAMTn2Xw+ZIo/3OexAqiv9dReGsQ9u/CFIA+x2QW2PT/q?=
 =?Windows-1252?Q?L9Tg3vqPgCqtrRXytyQiKqOT/IpX30qrRp3PeAIucNmlqf/jNnFFSgpL?=
 =?Windows-1252?Q?lmYWXy/m8PNcCT2muEXoU9Gi/zF7KcR496DVpNQyf6enXYZ61EnsyDyE?=
 =?Windows-1252?Q?n/txCFPeQbwrdRrHNHiwmxmBwknWk+4CWgQeAnn0vvuT30WouPFNTODS?=
 =?Windows-1252?Q?mncSJdbDA0aWTY+PXU8qFB4gVsmWTHfERYkMsY+/t8HR70l+2NgnKXj3?=
 =?Windows-1252?Q?xwOvWm4zuOOy7oSjxlsCZcd56hkaAud8ZdRihDgVdgSb9HmBWZzBCUtH?=
 =?Windows-1252?Q?8zUnLhHCJebbxVa0lAzYM8gGs8h9t1yhzk8/IYMvBWzuucBolTjygJvm?=
 =?Windows-1252?Q?5EiZcLHKcTcDRE8qXPihOu6I4N+7hguHqP89P4ChEeqQyEd3/pZv5+LN?=
 =?Windows-1252?Q?HiYvqhoquY35pIgH7/vjVUjtzBu6o+TaUhbRMX64UBJ4WszlFXOaZi7l?=
 =?Windows-1252?Q?UZ2oGoH5OneRDu4wlOUfiKbrBkTOwQcOxQYW20tjU1vxR+w0TuuOAVHU?=
 =?Windows-1252?Q?MeMgOH+bw5yR3cIBCVFmOT3aUpUDuHpzGHI5xVfRvDdYf+mXs6QJeZIC?=
 =?Windows-1252?Q?Fr7BjeUSsW/jHC9AIuSbrcjvymEAJFsNY6+LKTCDkRmyRw4gxN3dtMJ4?=
 =?Windows-1252?Q?0/CxaUWc6u/Pfl01DwU36IbQzdb5NEa2qRPv0uEze1KFMZgmafUONrQc?=
 =?Windows-1252?Q?FH7gXzt63WpA91TJFiWaMWlRvKagEIaqamwhMrLfSVp6JcB3uLSjFXgr?=
 =?Windows-1252?Q?dhpNF4S056LdKaqYZTpD/NEnrQVKGHTKQKYH7Bt0yr2EYo8C3ekHf8XW?=
 =?Windows-1252?Q?5rFdg5NTpCASclx19H61s+3lY2RD+AolY8UwjZPZU9KQazvrV4CT2uIX?=
 =?Windows-1252?Q?xB25qm+wrLm/57CH5Xk2Aa8UdTarsR+nVR9A+szixITA8E3M97QyRCTD?=
 =?Windows-1252?Q?T/2bmvg0Hxun3AqsA7HVid0YDY0Nwz5SQbmBvrrkSSRF5B8M5XwsM1dn?=
 =?Windows-1252?Q?PmSfQN7rYa3sOXv4+uxIA80Wu4T8DWaTWoDk4t9nxJ7Uy355lipa+bh8?=
 =?Windows-1252?Q?/IvDj/5vqFszwt8OVCWP+mmZlf4Y6CGrenrveFC0Mj197w5isnvaCVyy?=
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR20MB2247.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: e02c9c81-5041-40be-5ffc-08dd6af94b2a
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2025 17:28:29.6618
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR20MB4983

Hi ,
=A0
Are you considering securing the attendee list for ProMat 2025?
=A0
Expo Name: =A0ProMat Expo 2025
Total Number of records: 35,000 records=20
List includes: Company Name, Contact Name, Job Title, Mailing Address, Phon=
e, Emails, etc.
=A0
Would you like to buy these leads? I=92ll be happy to share the pricing wit=
h you.
=A0
Eager to receive your feedback
=A0
Regards
Ben Graham
Demand Generation Manager
US Marketing Data Inc.,
=A0
Please reply with REMOVE if you don=92t wish to receive further emails

