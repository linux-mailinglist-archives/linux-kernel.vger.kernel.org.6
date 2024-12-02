Return-Path: <linux-kernel+bounces-427696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E40D79E04E2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 15:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4867286072
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 14:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98082204F63;
	Mon,  2 Dec 2024 14:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zuehlke.com header.i=@zuehlke.com header.b="rfLPXMwv"
Received: from ZRZP278CU001.outbound.protection.outlook.com (mail-switzerlandnorthazon11021138.outbound.protection.outlook.com [40.107.167.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51BD31FECD5;
	Mon,  2 Dec 2024 14:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.167.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733149667; cv=fail; b=OzBqBgbuPZgjvm+Fy7UrVQDCUPOrpt9LN2GSorZQ5YuPY6g0rererCD0Al7ObPEHft7ZKZEPYo8SLwVB6CrrUnZ9eHrJINrizrTb8JZkSb0QfNJDL6Ud+CeSqiZDRMGF4o7tijdNu2whkgC+dlZwyDpxt7RqUOXRxCGkBagihEs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733149667; c=relaxed/simple;
	bh=gw7VcwCSmshIHtueQpBN0815y1V3DnPSlXUKb+m4FPs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tnWRS1Yad/FzQyUK6HTjsa52N5ZF5481v07H6YNIRiNegKtYcSY/FhdNQK5c1gwMxINhCcYuVcW2A3zynlS0XXwS3YIrncwAwNl9fQvbpinUs4RGcnKuwD7UQlmn/IvjzBnJn7xepDi1iulzFYX2dvwOFj8YmMyRn4JkmDyXlUc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zuehlke.com; spf=pass smtp.mailfrom=zuehlke.com; dkim=pass (1024-bit key) header.d=zuehlke.com header.i=@zuehlke.com header.b=rfLPXMwv; arc=fail smtp.client-ip=40.107.167.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zuehlke.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zuehlke.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aA8F0Mhx8IBXyxVfzUvARXTmBK9IwWi8wu3RGTIo4y0AzYXl1ZLVYDzxPoALd3LtMiJRFhv3HBy9mQBYb+KL2Athcn0WKz53pSuc74rerT/9Id9Epe4B9em25JvpLjHgr4RYTdMfNjBsQaV09YeRsDX86uJlFe0I+7Bx/6KDqSgBUD4mfIomkFwey+CrjvXJj8KZxpuxUFy0OMYKWcu37a7lE2iVx+wvzZku3PCypQkka4doOtVUkrTdB5/TUwA7c0acDJ7bsUDb2cOFLkTEmkPIUPO2rWxSvUgKSUoTlEn3XPtfK7tVQPkQnNmhwMPSNmskKuCMLewKWyvtO+DvxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jc5gZHv3HejPaS6AmVr0Wdd9Aw4hgoRK+bi+xtRPjsQ=;
 b=kkDWswCNoUAANkFiRUlz6vcPGBeT4AJel66oHHtFl37b9Bb7czffhTS42+lN6OlsnlKFp7YxGpzjumxGab7zc/Wnt6+DnB9tM0/ef6G2cMLr3tuhp0bwY24zPq9VHhAN2v/EdwGZWNSpAG5xJDDlJ6NuGhmWjSr2qr7gaHKRZe+mMcmdhcxUIs7hKIGoHQasrjvnuOaZMh47sTk2N891tsSEygJF6eJ8Wdr42D1OWfu4+NsMyKAERgifPwiVxP4EREzKORqVrquBHmVDlQSwWNZdM9+Kv4TrTdU2THUmVB2rC1JuGywfkUI+RA4OXM1mGp0bQYeLzPEACxI969tcuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zuehlke.com; dmarc=pass action=none header.from=zuehlke.com;
 dkim=pass header.d=zuehlke.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zuehlke.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jc5gZHv3HejPaS6AmVr0Wdd9Aw4hgoRK+bi+xtRPjsQ=;
 b=rfLPXMwvmixxz5Qem2vL20HQG0N1SflCvmd5eV4L/6NhcLdgapIPbLdn2IPigDFcON46ifFugzhg713uwcvAUZc3XwyF2Cb3YlM5i6svj3R5TfggrsaqEyIbrBgyK5/hYtWEkVJ6YDcAIg0EnP3GB84nDDY12hEL1XCfndJGs1s=
Received: from ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:5c::8) by
 GV0P278MB0832.CHEP278.PROD.OUTLOOK.COM (2603:10a6:710:53::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8207.18; Mon, 2 Dec 2024 14:27:37 +0000
Received: from ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c887:bd2f:4c91:3d13]) by ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM
 ([fe80::c887:bd2f:4c91:3d13%5]) with mapi id 15.20.8207.017; Mon, 2 Dec 2024
 14:27:37 +0000
From: =?iso-8859-1?Q?Facklam=2C_Oliv=E9r?= <oliver.facklam@zuehlke.com>
To: Biju Das <biju.das.jz@bp.renesas.com>
CC: Biju Das <biju.das@bp.renesas.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, "linux-usb@vger.kernel.org"
	<linux-usb@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "von Heyl, Benedict"
	<benedict.vonheyl@zuehlke.com>, =?iso-8859-1?Q?F=F6rst=2C_Mathis?=
	<mathis.foerst@zuehlke.com>, "Glettig, Michael"
	<Michael.Glettig@zuehlke.com>, Heikki Krogerus
	<heikki.krogerus@linux.intel.com>
Subject: RE: [PATCH v2 3/4] usb: typec: hd3ss3220: support configuring port
 type
Thread-Topic: [PATCH v2 3/4] usb: typec: hd3ss3220: support configuring port
 type
Thread-Index:
 AQHbNmuKAbQgSYuDD0+aIkfTlZwMRLK88xQAgAAYJXCACtFsAIAC7fPAgAAamoCACDHJMA==
Date: Mon, 2 Dec 2024 14:27:37 +0000
Message-ID:
 <ZR1P278MB1022A148E41AECEC8718DBD39F352@ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM>
References:
 <20241114-usb-typec-controller-enhancements-v2-0-362376856aea@zuehlke.com>
 <20241114-usb-typec-controller-enhancements-v2-3-362376856aea@zuehlke.com>
 <Zzsp2JOhnnPPOWvB@kuha.fi.intel.com>
 <ZR1P278MB10224924F48419CA813402309F272@ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM>
 <Z0RRQoRN7721FF-Z@kuha.fi.intel.com>
 <ZR1P278MB1022EC72C26F483A416DB1979F282@ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM>
 <TY3PR01MB1134648B9A537D826754AFB0486282@TY3PR01MB11346.jpnprd01.prod.outlook.com>
In-Reply-To:
 <TY3PR01MB1134648B9A537D826754AFB0486282@TY3PR01MB11346.jpnprd01.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-processedbytemplafy: true
x-templafyemailsigvstoversion: 9.16.0.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zuehlke.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZR1P278MB1022:EE_|GV0P278MB0832:EE_
x-ms-office365-filtering-correlation-id: bc808c50-ef47-403a-345d-08dd12dd7864
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?OapDUvO6lLqV92n1V+R0fbvscGD++CYQnwMYjomgX7R0XY1ot4iLSiP+Mc?=
 =?iso-8859-1?Q?HQbugANNwI//RiHCc+pZXg7LAJ6NrkUyGcHyyI3soyF9eEu15GRT9Isuwf?=
 =?iso-8859-1?Q?ts1Zkl0vFrwl7JuQWAz2Dkz5WlkbsZqC+1LYafG6uywq6t5W/zTPCzAzmH?=
 =?iso-8859-1?Q?WuyohtfZ0txQBoeWXHSB7rseo/Gk+LeSyClpXQJrN+FsjHrUxi34UQ2Kj/?=
 =?iso-8859-1?Q?03HIy0hDUGi4CYgY+LhUiGls6qfe1gefu4mqBaujhbfpUT01lNW6M4FoNn?=
 =?iso-8859-1?Q?YL1wLVbv8xAJL4uY3uxc31ZukYwwh87qcN2jrVqr7qgtSGOsfY2VLLpJg1?=
 =?iso-8859-1?Q?2b+hyjIpL2ucsxSVxUVcxDt57N1YiHp5dRfxFCu0LCMkDGqiahqwMbEipo?=
 =?iso-8859-1?Q?Fl2oaiq/EgBjzlyh1rTwfDBOZOcAlYDo4DF5ba7C9ey3dLMV4lziu7si9+?=
 =?iso-8859-1?Q?uS+T8XVGmg2njplE/hPaD5y4VtpICw+wv/P8i+0PuKzrX5ZuU1gepkpyhh?=
 =?iso-8859-1?Q?iaXORSk92/u2msZ8X4p2e85CNS/ERbtiS9j34pr80idC1mptkiHVuFSCTX?=
 =?iso-8859-1?Q?Vpkm1juaECTdbqyKz+lPCBWgrpU2vZHBxKajFEo+32BAtSzAmKGhlo965K?=
 =?iso-8859-1?Q?6yZz6siZUSR58DdNvYSnDhfBTOP09d79/8RYRcHdimatYocKOnZb/82VQn?=
 =?iso-8859-1?Q?BwwH9iu9H5QJdghH3j5GdioG4uuIv91HUWHMNv0MiSIswn8wqVbyPbmo6d?=
 =?iso-8859-1?Q?0faaqCyTgHaLdWoHHJ/MyXRZ6jAUPklS9BHK69xRqcoEWtLf1tZqwXit6y?=
 =?iso-8859-1?Q?ptNSac+z+g86riHd3jmON0j1BegLha1e7Xa3s/xRPMnLil7pioZK9mVDJj?=
 =?iso-8859-1?Q?QKBCUzBeNvpR82Wg1+TF5iJhBv1IbPGy+ZiKPhkzwIzbDRoIDf04AbsMh6?=
 =?iso-8859-1?Q?QXriYUFijC7M1v5HqgQnq9ecJDKil05bkgH8f+kmGkdXyP3dou0QN/4k3a?=
 =?iso-8859-1?Q?ePee6+Q2u0OWi8dhXpxU+7Bx4Y4iCDY9LAUjW3Dwf3fNazowuT06BgsajG?=
 =?iso-8859-1?Q?iX/W3twBLdtKLdPOdTxh+lcVnLle7mEQZ9/rBles40V0WV47a4JAnFznz2?=
 =?iso-8859-1?Q?Au/kyTa9fiITg6AJoJ8Y+BycyPgaqPV/1Y9JVfzBYp3COtaFvqL8+4BDp+?=
 =?iso-8859-1?Q?l6BCosrs1c9gE/MKtBxp9wOq68Z+tCito5t+5drhuKyGJq1yiiDABJpQYo?=
 =?iso-8859-1?Q?3ynReISl6Mp1K+32IOSdTCJeIO/ZalNZD3bgkqV7kIvrMF73PIFld2xClK?=
 =?iso-8859-1?Q?/G7Q83EurAixbJDcZiTy4wWyDoTynG3gC+WYouHv5mYwnOVuGKSgqB9wP6?=
 =?iso-8859-1?Q?BzTq3jD8rVIg0uJo4T9uonCpspD2O/BOCUqFdnJ71PZVXtYwDqwtc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5PI2FWsa7bxyOca7X5wR6vITpNQVCn7JXoGBytnZ5QU7pfhE8SvCiLXySo?=
 =?iso-8859-1?Q?P0Q4V/6xJephNlCNEKYXBj53Z9na5H/+1MxaFvrhR0pl8G1hLFeCt32n63?=
 =?iso-8859-1?Q?CwHAcR66cgabz10FuEFgmbvF/1VTUtmgIk9DKjF2Sw702t/5ms81u3LjQT?=
 =?iso-8859-1?Q?Wn52Oni3/HD3lWT3ZTcY1R8v/USjJT4hqhKx9caQ8qd5bMYlY666GR1dtS?=
 =?iso-8859-1?Q?C63jkCVv/W9BVxcRVrFzLT1ZXD6n2p0BlW1bsDUrVUFEQpfT9kSnFnGeT+?=
 =?iso-8859-1?Q?qAR54+rpGE1A9WNEEfI8yvqT3rIrVe+GTAI+fSj5c6PxhMWZR5XSgJ430J?=
 =?iso-8859-1?Q?mzojzaICfyJlS/qIm4xpG60HIG3WlqL44YWxF1nsUgYqd/cpQdEsc8iX/K?=
 =?iso-8859-1?Q?BrJmvuwO6juq9O/OjLu8LwkL/yC0CQBPusM4cmF+9Gpf3gL0wNoRNIG3sG?=
 =?iso-8859-1?Q?AAdg+eQuGxvqJt4ZcuNEqvJFCEH09aswNx3FxIHyl4O3pvqZ9Oh+DrEkxX?=
 =?iso-8859-1?Q?JLnW8Kc4HkLiNcupT47/9zWK5pXtmmGOITexoWR4FPW44IytK8WwzKAYFb?=
 =?iso-8859-1?Q?bc9L1apFNzfJoY7WfalCr9iaKilXN3Nbcv2fPnMSz49ns6DzCjqwaxbOHr?=
 =?iso-8859-1?Q?CpRiSx1uSD14tlZOkEhBZVkkUUirqxTKkG+qyabZX3y7f7KnfqNWrUW/6A?=
 =?iso-8859-1?Q?53Zj6pjr3zuGLNA20ddRckAsxNWN05aNvExnXQ/19V7fv1b31hvXWoNXVY?=
 =?iso-8859-1?Q?ykMLV+mG73vMII1O2C/S6E2QgMoSOmn9O+gsIr1/h25vp1pcJ3sPw0Obic?=
 =?iso-8859-1?Q?V46MOaBBUFbYzmO4l6/enaMwdN/yTdZXb1enX0J99vm+a0P2V4YbyS31Rt?=
 =?iso-8859-1?Q?hqfZ/WyZFwuTHYHKHLAmQQMu/FmkoEkk4D4fQvKtjam88KtOX3KSBgUIzl?=
 =?iso-8859-1?Q?dc6N/CiPwu0kp8YJHy4cL/cGTCKAA6ie9KtVzufxoSv2q7vB+ioPoM8Do5?=
 =?iso-8859-1?Q?xC97M/Hgp6dc+tOnsEQsqOyX1hVFr5tYTsykPhvdFRGdvwBac9J3geUgDj?=
 =?iso-8859-1?Q?NqGC/KZiLTqlrAs2go+bQn7jJkt5ax3qGM8QTgVmsXV6nn2eVcuxk5ZjXj?=
 =?iso-8859-1?Q?gzYDLIN+8n0FjfMn5PFSm//CWWOSWoXLJ3X73EzhePRJ5hEbOjH+tA1Vxo?=
 =?iso-8859-1?Q?/LfFwG8sKr3BWHdMcFfdaoK4EjndF1zLQnBvRxA+BVAK3KuofDiqqKtm1f?=
 =?iso-8859-1?Q?AkoJWMGnY+t70KUlPhLGxuU5raiYL4JKOlrbF3a0yc9au9R5k03m741zDx?=
 =?iso-8859-1?Q?pE3X3oEhOCpT3FDS5QGKn1A6OVUWZQP8T/nimPwN8BQ2S71Y4LT1MqKFEF?=
 =?iso-8859-1?Q?OM1qdJBALwygesKbWQ5tHMBlX2TDYzV1jnuYo6qFA3HtMy3uP8nAiZlYgL?=
 =?iso-8859-1?Q?qXAIiLDupaxOcHifRP+dAZmxR5A+xdtzeurTW5uD4uO9/NLQIAbQp1oH29?=
 =?iso-8859-1?Q?VAHlF88a7xYWi12e3ESGFATLxDtcMHsqsGEt1d24QWWq8PO/ZXRiydvdHW?=
 =?iso-8859-1?Q?HQcWrOnhL1Bp1l24vR5Av3fIWwkMb+iQ+uQYRk19Bf27wL3ZVR5fBhIo52?=
 =?iso-8859-1?Q?mHM2TNwbopZgKEtwvsYJJ+s61G6AbLg/nbtJR1neEBdYR0fwz917RTR4p1?=
 =?iso-8859-1?Q?QIbDhLZdO3Glz5UK1UB7t/W5vNfKq5A69X46jsM4?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: zuehlke.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZR1P278MB1022.CHEP278.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bc808c50-ef47-403a-345d-08dd12dd7864
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2024 14:27:37.3142
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccce7f5e-a35f-4bc3-8e63-b2215e7d14f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EH6A2wQ5+842YywQOr/bKOi9EG0wiLIMELA1u/jCOnm8jwSOO1Ad2xq6bGE7vOMl6t6QjOH2iPBmR4AjxuE0emvtCXL2OdALQKDU45JcTpw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV0P278MB0832

Hello Biju,

Thanks for your response and sorry for the delay.

> -----Original Message-----
> From: Biju Das <biju.das.jz@bp.renesas.com>
> Sent: Wednesday, November 27, 2024 9:48 AM
> Subject: RE: [PATCH v2 3/4] usb: typec: hd3ss3220: support configuring po=
rt
> type
>=20
> Hi Facklam, Oliv=E9r,
>=20
> > -----Original Message-----
> > From: Facklam, Oliv=E9r <oliver.facklam@zuehlke.com>
> > Sent: 27 November 2024 08:03
> > Subject: RE: [PATCH v2 3/4] usb: typec: hd3ss3220: support configuring
> > port type
> >
> > Hi Heikki,
> >
> > > -----Original Message-----
> > > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > Sent: Monday, November 25, 2024 11:28 AM
> > >
> > > Hi Oliv=E9r,
> > >
> > > Sorry to keep you waiting.
> > >
> > > On Mon, Nov 18, 2024 at 02:00:41PM +0000, Facklam, Oliv=E9r wrote:
> > > > Hello Heikki,
> > > >
> > > > Thanks for reviewing.
> > > >
> > > > > -----Original Message-----
> > > > > From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > > > > Sent: Monday, November 18, 2024 12:50 PM
> > > > >
> > > > > Hi Oliver,
> > > > >
> > > > > I'm sorry, I noticed a problem with this...
> > > > >
> > > > > On Thu, Nov 14, 2024 at 09:02:08AM +0100, Oliver Facklam wrote:
> > > > > > The TI HD3SS3220 Type-C controller supports configuring the
> > > > > > port type it will operate as through the MODE_SELECT field of
> > > > > > the General Control Register.
> > > > > >
> > > > > > Configure the port type based on the fwnode property "power-rol=
e"
> > > > > > during probe, and through the port_type_set typec_operation.
> > > > > >
> > > > > > The MODE_SELECT field can only be changed when the controller
> > > > > > is in unattached state, so follow the sequence recommended by
> > > > > > the datasheet
> > > > > to:
> > > > > > 1. disable termination on CC pins to disable the controller 2.
> > > > > > change the mode 3. re-enable termination
> > > > > >
> > > > > > This will effectively cause a connected device to disconnect
> > > > > > for the duration of the mode change.
> > > > >
> > > > > > Signed-off-by: Oliver Facklam <oliver.facklam@zuehlke.com>
> > > > > > ---
> > > > > >  drivers/usb/typec/hd3ss3220.c | 66
> > > > > ++++++++++++++++++++++++++++++++++++++++++-
> > > > > >  1 file changed, 65 insertions(+), 1 deletion(-)
> > > > > >
> > > > > > diff --git a/drivers/usb/typec/hd3ss3220.c
> > > > > b/drivers/usb/typec/hd3ss3220.c
> > > > > > index
> > > > >
> > >
> e581272bb47de95dee8363a5491f543354fcbbf8..e3e9b1597e3b09b82f0726a
> > > > > 01f311fb60b4284da 100644
> > > > > > --- a/drivers/usb/typec/hd3ss3220.c
> > > > > > +++ b/drivers/usb/typec/hd3ss3220.c
> > > > [...]
> > > > > > @@ -131,8 +183,16 @@ static int hd3ss3220_dr_set(struct
> > > > > > typec_port
> > > > > *port, enum typec_data_role role)
> > > > > >       return ret;
> > > > > >  }
> > > > > >
> > > > > > +static int hd3ss3220_port_type_set(struct typec_port *port,
> > > > > > +enum
> > > > > typec_port_type type)
> > > > > > +{
> > > > > > +     struct hd3ss3220 *hd3ss3220 =3D typec_get_drvdata(port);
> > > > > > +
> > > > > > +     return hd3ss3220_set_port_type(hd3ss3220, type); }
> > >
> > > > > >  static const struct typec_operations hd3ss3220_ops =3D {
> > > > > > -     .dr_set =3D hd3ss3220_dr_set
> > > > > > +     .dr_set =3D hd3ss3220_dr_set,
> > > > > > +     .port_type_set =3D hd3ss3220_port_type_set,
> > > > > >  };
> > > > >
> > > > > So here I think you should implement the pr_set callback instead.
> > > >
> > > > I can do that, but based on the MODE_SELECT register description,
> > > > it seems to me that this setting is fundamentally changing the
> > > > operation mode of the chip, i.e. the state machine that is being
> > > > run for initial
> > > connection.
> > > > So there would have to be a way of "resetting" it to be a
> > > > dual-role port again, which the "pr_set" callback doesn't seem to h=
ave?
> > > >   This register can be written to set the HD3SS3220 mode
> > > >   operation. The ADDR pin must be set to I2C mode. If the default
> > > >   is maintained, HD3SS3220 shall operate according to the PORT
> > > >   pin levels and modes. The MODE_SELECT can only be
> > > >   changed when in the unattached state.
> > > >   00 - DRP mode (start from unattached.SNK) (default)
> > > >   01 - UFP mode (unattached.SNK)
> > > >   10 - DFP mode (unattached.SRC)
> > > >   11 - DRP mode (start from unattached.SNK)
> > >
> > > Okay, I see. This is not a case for pr_set.
> > >
> > > I'm still confused about the use case here. It seems you are not
> > > interested in role swapping after all, so why would you need this
> > > functionality to be exposed to the user space?
> > >
> > > I'm sorry if I've missed something.
> > >
> > > About the port_type attribute file itself. I would feel more
> > > comfortable with it if it was allowed to be written only when there
> > > is nothing connected to the port. At the very least, I think it
> > > should be documented better so what it's really meant for would be mo=
re
> clear to everybody.
> >
> > After researching some more about this operation, I came across the
> > driver for TUSB320 [1] which seems to have a very similar behavior (als=
o
> from TI).
> > [1] - https://lore.kernel.org/all/20220730180500.152004-1-
> > marex@denx.de/T/#ma7a322bc207414e4185c29d257ff30f5769f5d70
> >
> > For one variant of the chip, the implementation relies on the CC
> > disabling like in this patch. A different variant tests the current con=
nection
> status before proceeding.
> >
>=20
>=20
> Can you please provide your test logs?

Adding them below.

>=20
> Previously I tested 2 devices with
> Switching roles host->device->host using
>=20
> echo device > /sys/class/typec/port0/data_role
>=20
> and
>=20
> echo host > /sys/class/typec/port0/data_role

Could you clarify what your test setup was?
Did you control both sides of the USB connection and execute these commands
on both sides?

>=20
>=20
> Cheers,
> Biju

Here are my test logs for the "port type switch" functionality.
The hd3ss3220 driver doesn't log much at all, I added one debug line
(NOT part of the patch series) for testing purposes:
diff --git a/drivers/usb/typec/hd3ss3220.c b/drivers/usb/typec/hd3ss3220.c
index c6922989a3cd..76fea657398a 100644
--- a/drivers/usb/typec/hd3ss3220.c
+++ b/drivers/usb/typec/hd3ss3220.c
@@ -199,6 +199,7 @@ static const struct typec_operations hd3ss3220_ops =3D =
{
 static void hd3ss3220_set_role(struct hd3ss3220 *hd3ss3220)
 {
 	enum usb_role role_state =3D hd3ss3220_get_attached_state(hd3ss3220);
+	dev_info(hd3ss3220->dev, "Propagating role %s\n", usb_role_string(role_st=
ate));
=20
 	usb_role_switch_set_role(hd3ss3220->role_sw, role_state);

My test setup is as follows:
+-------------------------------------------+      +--------------------+
|        My device (Linux 6.12)             |      |                    |
| +-----------------+                       |      |    Remote device   |
| |                 +------I2C----+         |      |                    |
| |   i.MX8 M Plus  |    +--------v-------+ |      |   - phone          |
| |   with USB3 DRD |    |                | |      |   - USB-to-Ethernet|
| |   controller    +----+ TI HD3SS3220   +-+------+     dongle         |
| |                 |    |                | |      |   - computer       |
| +-----------------+    +----------------+ |      |                    |
+-------------------------------------------+      +--------------------+

=3D=3D=3D=3D=3D=3D=3D=3D
Case 1: Device tree: power-role =3D "sink";
=3D=3D=3D=3D=3D=3D=3D=3D
# cat /sys/class/typec/port0/port_type
[sink]
# echo "source" > /sys/class/typec/port0/port_type
zsh: permission denied: /sys/class/typec/port0/port_type
# echo "dual" > /sys/class/typec/port0/port_type
zsh: permission denied: /sys/class/typec/port0/port_type

-> plug in ethernet adapter --> nothing happens
-> unplug
-> plug in Samsung phone

[  147.581160] hd3ss3220 4-0047: Propagating role device
# cat /sys/class/typec/port0/data_role
host [device]

-> unplug

[  485.495874] hd3ss3220 4-0047: Propagating role none

=3D=3D=3D=3D=3D=3D=3D=3D
Case 2: Device tree: power-role =3D "source";
=3D=3D=3D=3D=3D=3D=3D=3D
# cat /sys/class/typec/port0/port_type
[source]
# echo "sink" > /sys/class/typec/port0/port_type
zsh: permission denied: /sys/class/typec/port0/port_type

->plug in ethernet adapter

[   94.590028] hd3ss3220 4-0047: Propagating role host
[   94.733892] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[   94.739427] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned b=
us number 3
[   94.747464] xhci-hcd xhci-hcd.1.auto: hcc params 0x0220fe6d hci version =
0x110 quirks 0x000080a001000010
[   94.756900] xhci-hcd xhci-hcd.1.auto: irq 198, io mem 0x38100000
[   94.763060] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[   94.768565] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned b=
us number 4
[   94.776246] xhci-hcd xhci-hcd.1.auto: Host supports USB 3.0 SuperSpeed
[   94.783382] hub 3-0:1.0: USB hub found
[   94.787178] hub 3-0:1.0: 1 port detected
[   94.791484] usb usb4: We don't know the algorithms for LPM for this host=
, disabling LPM.
[   94.800068] hub 4-0:1.0: USB hub found
[   94.803859] hub 4-0:1.0: 1 port detected
[   95.781709] usb 4-1: new SuperSpeed USB device number 2 using xhci-hcd
[   96.195802] usbcore: registered new interface driver cdc_ether
[   96.396140] cdc_ncm 4-1:2.0: MAC-Address: a0:ce:c8:9e:54:a4
[   96.401753] cdc_ncm 4-1:2.0: setting rx_max =3D 16384
[   96.419345] cdc_ncm 4-1:2.0: setting tx_max =3D 16384
[   96.434385] cdc_ncm 4-1:2.0 eth1: register 'cdc_ncm' at usb-xhci-hcd.1.a=
uto-1, CDC NCM (NO ZLP), a0:ce:c8:9e:54:a4
[   96.444940] usbcore: registered new interface driver cdc_ncm

-> unplug

[  133.501500] hd3ss3220 4-0047: Propagating role none
[  133.506518] xhci-hcd xhci-hcd.1.auto: remove, state 1
[  133.511636] usb usb4: USB disconnect, device number 1
[  133.516732] usb 4-1: USB disconnect, device number 2
[  133.521934] cdc_ncm 4-1:2.0 eth1: unregister 'cdc_ncm' usb-xhci-hcd.1.au=
to-1, CDC NCM (NO ZLP)
[  133.602023] xhci-hcd xhci-hcd.1.auto: USB bus 4 deregistered
[  133.610348] xhci-hcd xhci-hcd.1.auto: remove, state 4
[  133.616023] usb usb3: USB disconnect, device number 1
[  133.624475] xhci-hcd xhci-hcd.1.auto: USB bus 3 deregistered
[  133.733092] using host ethernet address: f8:dc:7a:a0:c0:ae
[  133.733104] using self ethernet address: 1A:22:33:44:55:66
[  133.739134] g_ncm gadget.0: HOST MAC f8:dc:7a:a0:c0:ae
[  133.749825] g_ncm gadget.0: MAC 1a:22:33:44:55:66
[  133.754587] g_ncm gadget.0: NCM Gadget
[  133.758354] g_ncm gadget.0: g_ncm ready

-> plug in phone --> phone is getting charged
-> unplug

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Case 3: Device tree: power-role =3D "dual";
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
# cat /sys/class/typec/port0/port_type
[dual] source sink

-> plug in ethernet adapter

[  252.688228] hd3ss3220 4-0047: Propagating role host
[  252.823920] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[  252.829468] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned b=
us number 3
[  252.837506] xhci-hcd xhci-hcd.1.auto: hcc params 0x0220fe6d hci version =
0x110 quirks 0x000080a001000010
[  252.846943] xhci-hcd xhci-hcd.1.auto: irq 198, io mem 0x38100000
[  252.853098] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[  252.858614] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned b=
us number 4
[  252.866307] xhci-hcd xhci-hcd.1.auto: Host supports USB 3.0 SuperSpeed
[  252.873424] hub 3-0:1.0: USB hub found
[  252.877221] hub 3-0:1.0: 1 port detected
[  252.881532] usb usb4: We don't know the algorithms for LPM for this host=
, disabling LPM.
[  252.890122] hub 4-0:1.0: USB hub found
[  252.893911] hub 4-0:1.0: 1 port detected
[  253.872375] usb 4-1: new SuperSpeed USB device number 2 using xhci-hcd
[  254.282643] usbcore: registered new interface driver cdc_ether
[  254.483834] cdc_ncm 4-1:2.0: MAC-Address: a0:ce:c8:9e:54:a4
[  254.489447] cdc_ncm 4-1:2.0: setting rx_max =3D 16384
[  254.505900] cdc_ncm 4-1:2.0: setting tx_max =3D 16384
[  254.520769] cdc_ncm 4-1:2.0 eth1: register 'cdc_ncm' at usb-xhci-hcd.1.a=
uto-1, CDC NCM (NO ZLP), a0:ce:c8:9e:54:a4
[  254.531322] usbcore: registered new interface driver cdc_ncm

-> unplug

[  273.270877] usb 4-1: USB disconnect, device number 2
[  273.276084] cdc_ncm 4-1:2.0 eth1: unregister 'cdc_ncm' usb-xhci-hcd.1.au=
to-1, CDC NCM (NO ZLP)
[  274.192136] hd3ss3220 4-0047: Propagating role none
[  274.197161] xhci-hcd xhci-hcd.1.auto: remove, state 4
[  274.202251] usb usb4: USB disconnect, device number 1
[  274.207994] xhci-hcd xhci-hcd.1.auto: USB bus 4 deregistered
[  274.213739] xhci-hcd xhci-hcd.1.auto: remove, state 4
[  274.218841] usb usb3: USB disconnect, device number 1
[  274.225032] xhci-hcd xhci-hcd.1.auto: USB bus 3 deregistered
[  274.335934] using host ethernet address: f8:dc:7a:a0:c0:ae
[  274.335947] using self ethernet address: 1A:22:33:44:55:66
[  274.341994] g_ncm gadget.0: HOST MAC f8:dc:7a:a0:c0:ae
[  274.352692] g_ncm gadget.0: MAC 1a:22:33:44:55:66
[  274.357455] g_ncm gadget.0: NCM Gadget
[  274.361225] g_ncm gadget.0: g_ncm ready

-> plug in Windows PC
[  322.321716] hd3ss3220 4-0047: Propagating role device
-> unplug
[  343.825254] hd3ss3220 4-0047: Propagating role none

-> plug in phone
[  454.410340] hd3ss3220 4-0047: Propagating role host
[  454.558026] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[  454.563594] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned b=
us number 3
[  454.571652] xhci-hcd xhci-hcd.1.auto: hcc params 0x0220fe6d hci version =
0x110 quirks 0x000080a001000010
[  454.581104] xhci-hcd xhci-hcd.1.auto: irq 198, io mem 0x38100000
[  454.587295] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[  454.592836] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned b=
us number 4
[  454.600546] xhci-hcd xhci-hcd.1.auto: Host supports USB 3.0 SuperSpeed
[  454.607623] hub 3-0:1.0: USB hub found
[  454.611475] hub 3-0:1.0: 1 port detected
[  454.615817] usb usb4: We don't know the algorithms for LPM for this host=
, disabling LPM.
[  454.624451] hub 4-0:1.0: USB hub found
[  454.628295] hub 4-0:1.0: 1 port detected
[  455.085270] usb 4-1: new SuperSpeed USB device number 2 using xhci-hcd
[  455.203088] cdc_acm 4-1:1.1: ttyACM0: USB ACM device
[  455.208249] usbcore: registered new interface driver cdc_acm
[  455.213947] cdc_acm: USB Abstract Control Model driver for USB modems an=
d ISDN adapters

-> unplug
[  477.940537] usb 4-1: USB disconnect, device number 2
[  477.960408] hd3ss3220 4-0047: Propagating role none
[  477.965448] xhci-hcd xhci-hcd.1.auto: remove, state 1
[  477.970570] usb usb4: USB disconnect, device number 1
[  477.999753] xhci-hcd xhci-hcd.1.auto: USB bus 4 deregistered
[  478.005519] xhci-hcd xhci-hcd.1.auto: remove, state 4
[  478.010605] usb usb3: USB disconnect, device number 1
[  478.016507] xhci-hcd xhci-hcd.1.auto: USB bus 3 deregistered
[  478.124154] using host ethernet address: f8:dc:7a:a0:c0:ae
[  478.124168] using self ethernet address: 1A:22:33:44:55:66
[  478.130222] g_ncm gadget.0: HOST MAC f8:dc:7a:a0:c0:ae
[  478.140901] g_ncm gadget.0: MAC 1a:22:33:44:55:66
[  478.145663] g_ncm gadget.0: NCM Gadget
[  478.149433] g_ncm gadget.0: g_ncm ready


# echo "source" > /sys/class/typec/port0/port_type
# cat /sys/class/typec/port0/port_type
# dual [source] sink
-> plug in ethernet dongle --> same as before
-> plug in phone --> same as before
-> plug in Windows PC
[  593.662330] hd3ss3220 4-0047: Propagating role host
[  593.794008] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[  593.800172] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned b=
us number 3
[  593.808248] xhci-hcd xhci-hcd.1.auto: hcc params 0x0220fe6d hci version =
0x110 quirks 0x000080a001000010
[  593.817695] xhci-hcd xhci-hcd.1.auto: irq 198, io mem 0x38100000
[  593.823871] xhci-hcd xhci-hcd.1.auto: xHCI Host Controller
[  593.829390] xhci-hcd xhci-hcd.1.auto: new USB bus registered, assigned b=
us number 4
[  593.837075] xhci-hcd xhci-hcd.1.auto: Host supports USB 3.0 SuperSpeed
[  593.844370] hub 3-0:1.0: USB hub found
[  593.848153] hub 3-0:1.0: 1 port detected
[  593.852335] usb usb4: We don't know the algorithms for LPM for this host=
, disabling LPM.
[  593.860805] hub 4-0:1.0: USB hub found
[  593.864586] hub 4-0:1.0: 1 port detected

# echo "sink" > /sys/class/typec/port0/port_type
# cat /sys/class/typec/port0/port_type
dual source [sink]

-> plug in ethernet dongle --> nothing happens
-> plug in laptop / phone
[  726.770383] hd3ss3220 4-0047: Propagating role device
-> unplug
[  729.842140] hd3ss3220 4-0047: Propagating role none

As you can see, setting the port type really changes the behavior of the po=
rt
w.r.t. the initial connection setup with the peer.
I hope this helps.

Best regards
Oliver

