Return-Path: <linux-kernel+bounces-329070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79576978CEA
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 05:00:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9D7501C226BC
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 03:00:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C5F175AB;
	Sat, 14 Sep 2024 03:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b="gpA+tO03"
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6927014A90
	for <linux-kernel@vger.kernel.org>; Sat, 14 Sep 2024 03:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.183.30.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726282810; cv=fail; b=VaIqdW1YrfTX9Z2eEcR1lapw8LI0LypTxIyR2yaJPhtl9ErsRB3tMCXqs4nfOHHJzqLxU9vFzQsxVmqIWlDZZUsxME9pNYVFiQN23Aycr924AdKKcLWq0Q1HPmHQL43icmwLN1L6Plvmi0MAH8gVtjI89jvAIO/Hq9czOSTpjmQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726282810; c=relaxed/simple;
	bh=JYfHMlJdS0Ydki68IJBb/w3DADWjmsxizewPPf3+3OE=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Rl9hVur/ubQzwj9qyvbID3uYbhCCw1YFQeGSd8ffXdQU5N+TUGwzmhmDLn/taQmRpZQFKwcIR0mpX5uLblReEwHhoIF6eN2Ztj8MMpw5Vm6Ivd3XFDRw8h90+fLcU3Q5+RzbkmQ2yJ3zkLvENzlRQ7A5sNv8nwM+9GQYaEnfwjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com; spf=pass smtp.mailfrom=sony.com; dkim=pass (2048-bit key) header.d=sony.com header.i=@sony.com header.b=gpA+tO03; arc=fail smtp.client-ip=185.183.30.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sony.com
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
	by mx08-001d1705.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48E2graT020189;
	Sat, 14 Sep 2024 02:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=S1; bh=HIy3oKhJbfEExYGB0076W8w0awvl8
	AuiOINZV40f/qI=; b=gpA+tO0369vL6Zgv/EGlDZCTQ6dBAzcoIh14pxxTLWNrI
	id3Obet0uRoOig3hs4cnvhruJPvnulm0mlmM69E5BLeH+tBhbBt7mxtob1TzBIUU
	pxaYcrlmMq/Aengs/wSSakEhp15RM5Getjg5wYD5ZH8XI42YdufgoYnkdao6DMmP
	FvZw/uzsVtgHMIjDJAi6khv8/zTa3lYDKS4YT3/N0GDSv/jGBI+j/4Fbi8Bw+Ord
	RWPsWnouhLrxubnecqTbzPe0PkRKZBN0mbIpm5rVtapumuZLR5Fpg4pXR8IJ1k5a
	9cr4mfN5+SX2abn7oNjeot1o+dWESUcnAqpiJ7Cww==
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2104.outbound.protection.outlook.com [104.47.26.104])
	by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 41n19400rx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Sep 2024 02:59:49 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F6VWC3q8ThG+iU0VKyRkz1W+ykOYVI7Dsmw2/RghPtP6x8qL5whSUzQfW4EZNjC9xg9GT8FT6f7Yd4UH+5xScGw33k3248JXSOzSjfcvd+Dm1CB/G0bv0Z75+z8pJrrnESjvj8FwnsoCrHoeQCX9zcZ+cfIoXymaHTBo4zl1OS/mYZtBF9+cVoa/9J/t/R1+nJNhvybnSRBUFeyO0zAKA+yxr3mixYwHZu20g8wCzinRubLFaGNv3VPO3gZdOrfwAn8PHFx3xVf1oFOdPWqGp8YZL+zD1FQwNWsuPKmkzWsFH+SMlekHn+jgJ8Y/MqQ+m7f+38glcpoGuLrKQ8HViA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HIy3oKhJbfEExYGB0076W8w0awvl8AuiOINZV40f/qI=;
 b=VlJHiqGLKRZptfusj7ku6AeB/A5TrUcOXRNSUfxW/RN+fwt5BQ4PWcwDcch6HIbOQC4TmC4JvjVrRT0dRq4j4c4Xu3nBGLLMzJjhIEZROqKzT4YI6uvpKDsA5wkJA7KJUKBcvdCgau+K7NxMaWfM6P9d1XVu3mDS7WWww//O4QbI8zInw0Dh3YAfwlrGTTL2+PrruDmDCLcapCeZrFBtW3J2jMJHl8LOn9VaTwY7SRATjzLcv4LqnX7Ii1r6FI9fhSaMTRSn9WB8U0vzHjYXCjTRzCW/HEM3zOako+01AicYJZ3gbfBeqwkBmIwB6oShZ9HeW9cqHyDMIDoraVDaGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TYZPR04MB5950.apcprd04.prod.outlook.com (2603:1096:400:202::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.19; Sat, 14 Sep
 2024 02:59:39 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::409e:64d3:cee0:7b06%6]) with mapi id 15.20.7962.016; Sat, 14 Sep 2024
 02:59:38 +0000
From: "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To: "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com"
	<sj1557.seo@samsung.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Jacky.Cao@sony.com" <Jacky.Cao@sony.com>,
        "Wataru.Aoyama@sony.com"
	<Wataru.Aoyama@sony.com>,
        "Daniel.Palmer@sony.com" <Daniel.Palmer@sony.com>
Subject: [PATCH v1] MAINTAINERS: exfat: add myself as reviewer
Thread-Topic: [PATCH v1] MAINTAINERS: exfat: add myself as reviewer
Thread-Index: AQHbBlGLUG5At6fvSE+Es33d35eK5w==
Date: Sat, 14 Sep 2024 02:59:38 +0000
Message-ID:
 <PUZPR04MB6316617B76FF4DE05E2DD10281662@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TYZPR04MB5950:EE_
x-ms-office365-filtering-correlation-id: 508f24bf-413a-4fe0-de14-08dcd46945d1
x-proofpoint-id: d8690225-876f-412f-87c6-a7cb45557a4c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?NXEBoIFnfa047ZUsWsiQ+anu73XqcTTR57+jfzWCpXxsgIBdEfNxa64/cm?=
 =?iso-8859-1?Q?vyDxSeVYbH+TLKCWN8T6xc7qKQN1LZVEvr+46efWg/ug34wAmxjqG5pJ4/?=
 =?iso-8859-1?Q?0tCrhKLxymb0YzJiqpqQorA9IJ11e/B1yDHNiBQFCQS6EzzxisFapDwlws?=
 =?iso-8859-1?Q?5rj95Zm+mWCq/+ZGFU7W7i5MJDDX7KGIJ8q6DseLW0RQCpnlZs4TkJMhdG?=
 =?iso-8859-1?Q?pbGfOCcj0yE0AaVlCRguyZqWYWuZP+/w5KhPl7RO/rj5h2YJvGBCUsZ8Jn?=
 =?iso-8859-1?Q?aJWc7wAg5L5OPWBmV73rXL4RSjizEJqz0rYBfhMQx4K1SpYMKNj4p1/31n?=
 =?iso-8859-1?Q?6YtQ3l4RprevdF1EkVhEvS/Szb8dYLqnaO8C1c+HjFcYn22jEw4LlJiznC?=
 =?iso-8859-1?Q?qDmAf9nEI71D2lAgz/2IIxuTVXoBZs/KBXmeQx3qpLAlbo8+uq9erhwngp?=
 =?iso-8859-1?Q?T3fKyJNh1f+U1ecpEM+L096pcZ8nXOaGzHbweUBnIIJzSUZGDFvwaItKKp?=
 =?iso-8859-1?Q?D8SB3GvrJZnL11oKnDx7+1Y0BJAgHtWYK3xBio84Fbcdu5BZnpb8LC1Lfi?=
 =?iso-8859-1?Q?TtnsOx3a8bRjkXBhgX/YpEUW3Urn/28ulQzhf8fGeoPZ0nXExbXg2KT7AJ?=
 =?iso-8859-1?Q?CqKprDT1UKZzW8q1N6c7kwDMOEzAhAMB6UT2jFfrTY9RRGfIHDXZsPtT8d?=
 =?iso-8859-1?Q?5Z4zUNJ2n8BmSRw2FxiJPS6oKpF/tQoXyi6szip4O70Xg7l2UIn3JaVs05?=
 =?iso-8859-1?Q?zsTzKzTmrfnkq1p72MyTuqvaxkWJpEiEkk0rpjdW6+l5NdCffLIM4+ounZ?=
 =?iso-8859-1?Q?CJMQMLI6WEDemsFlXzu78PO5vNm9sVpwrAFABRKVgagUCVqYIBJl27UYmJ?=
 =?iso-8859-1?Q?fFaiPCqKIWqkhjciKISCV3il+5qTYZ3NliA6WZHSqWhzZbjvl2zn3uc34Z?=
 =?iso-8859-1?Q?4G5SKfBegNaNlM20ChSy8qtuDCfnr9I16srF7JUupVlBo62JHkpUsl28ze?=
 =?iso-8859-1?Q?gRFhXTnXBu1l3dymN5qlJyBmJOrDFjefoB1SDAQvXQ2PAsuO1WLfkAzBMp?=
 =?iso-8859-1?Q?YyJIce9ePqZel3EQL9XUMo5eJ/S3bN32PgT6YmgrZB1idK14yBh5fXYsyT?=
 =?iso-8859-1?Q?YsebG/Qk3628M9SDXSkshs76LFV8a0kkhcM4FqyRsEskocmzXm3zWvtl69?=
 =?iso-8859-1?Q?NSZ2pJkMq1MQ+I09PbweUP5OXcq7ppzo8e69LoGp3SrfBoy/3zmap0Bp7c?=
 =?iso-8859-1?Q?ZmAkNw9Hze7kpt9PLG0xjJlBdRMJsD89M6nzaJSzXuWMeLKmd1ds5pymes?=
 =?iso-8859-1?Q?P9j7STN+3hLbJEWJnTYZLGWGfTihexJQsJZSRZwr1O7gqJ9aHLIVMCgY3U?=
 =?iso-8859-1?Q?D92aHeZpOqBs/1bbLNPnVBLNw5mw8qz8M5RQ0DmFsET8sqRAXLBKJ30BLx?=
 =?iso-8859-1?Q?OOrcNazq5AkyPKEOj6HSRpMzjRIYcPZ1vzeZIA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3caYJy/1lRoVLHCQSO+EL/VnF+EHnnZRGMErMbQWh3zhaT8qsvz8S1CrFk?=
 =?iso-8859-1?Q?51vXWzd/ZuMkCxihVDovV70wo9451AW/sFU6PX/68FF4mX/SFP5bzvVA0q?=
 =?iso-8859-1?Q?Urao5rVbCsZJ6QajKLtOtVDMJui2OoSmOeYAUIlX70cKh8OSU91AAlvML1?=
 =?iso-8859-1?Q?JII0DY7m7cyeSEMexhP0BOaqnsEhzFC2gGUap/kyqwZNoqa3dYhrPp+Haa?=
 =?iso-8859-1?Q?uxjRJVysBId5Q0zAGSIbhSNZMX1O5fmsqJFAzBz8u2H62JCO96izljFs1E?=
 =?iso-8859-1?Q?JWIaN/m4sbBu3RL1YVvHTdbHitAulMsBsBnlzYoPNGbqtLhOjVSXFmGeF+?=
 =?iso-8859-1?Q?At2EE53Gke42lWUCfRjEkX4TmR1uAHuhxaKiQOoPIJ0gf2nw7Xpi9mvzoj?=
 =?iso-8859-1?Q?TdTPU1CgNh9YcC9jkNzW7AHMcmQG1QrTHnjFWAugIPU4L1m8tsddRYkm7V?=
 =?iso-8859-1?Q?WVaaOIXuAbngs6PooI8TG73K/pbXRdKjy5YYP4mglGnN4Ya5w0o6r+Xdyt?=
 =?iso-8859-1?Q?eP6rQAUoFcgNCe3JNsSFVsh1evicRRBzPIGM4E//H+E3BL74zXSobjMjBY?=
 =?iso-8859-1?Q?69YxfPNzS2Bn49eW6N8n4lC6tIGC5wwcc0ruarN5j1zvbEQEd+O1xTW6Sf?=
 =?iso-8859-1?Q?+TYOgn9fG6UinQllFRJNdjQUJQCq98n0yZr9LYW+RlmPmmYBeJYO/oUiAQ?=
 =?iso-8859-1?Q?ZkshVAYh1nmcsNEHojqfzxdODwdq4JovW2yvJb45zERvJEAxpwlnSQVxgk?=
 =?iso-8859-1?Q?2zCTjAqJ8WDQHYc/LO28cJE2RcPZxKT0IeIaiYDI4xxKeb7X1kJlgaNewL?=
 =?iso-8859-1?Q?fFfKGYa2Tbtt1qvLpZEKp2TxpedUWfcMD7dqR90VXgnE70ASEnvInIDQES?=
 =?iso-8859-1?Q?bMnbFXr1QLF2NaSkGIsoT4HdoHBxJvn0Xu8gtppzc4BsXS8Qj+gUakMThB?=
 =?iso-8859-1?Q?E1MBGBHDBSIb/NECpJWzTPB0mQN4EdAmh0L4kGuA544CQZCogFqGadruog?=
 =?iso-8859-1?Q?Qvoz+du7XF9h968eYyxLWuVtH+QQyR4a9VPqpgOOCsDjasy4aDN82knP2j?=
 =?iso-8859-1?Q?4e3MOWeR3TxSyne81puhGehUR/k5Z5NBV5aVcSsADYdVoeGLf7+e/PAJiN?=
 =?iso-8859-1?Q?IeeBbB80Rz9AQ0tmcVm4khjgCw/Lk7rURESgBMsenMPPxFaGZMNdR0CGON?=
 =?iso-8859-1?Q?pNgmf16k0iLPgioiXg71eoaQyTNbzXADBctoBAPooVQUjcPeqomMEPi7et?=
 =?iso-8859-1?Q?gGHqDTduyGZyfWs1mWFX+eZta/RBdJ2nylb56w4qUbRxPLsMz34urn8TVG?=
 =?iso-8859-1?Q?+Ir27GNBQnhvKYeNuWbHVKqBkf1UB/eOJAM2VYm00eaK1Nb1TgMtcu3b9Q?=
 =?iso-8859-1?Q?7u9yOSUT+29NOTI/51bHxqN4ctHvqt8Dl4kCb0gKMwjUIpNBL6AK86Zmu0?=
 =?iso-8859-1?Q?ORIF6XzItXRuH5Ch8ggLZ6zm6xvgKCRIv/NJxDsJk+IBfkN8VCf6lQ2Gv1?=
 =?iso-8859-1?Q?Na7p3WKmWU8jc5x+P/YYePWnI/IJHpV5mEnV0kdxhOOMo5Pa9UVw7/hIAh?=
 =?iso-8859-1?Q?kWJrB3s6u83/ckMw9WRXVDdsd05qbvO3rzp3qOG/QtxWiMi+PH9ttaCcvy?=
 =?iso-8859-1?Q?KIv6ZEvUbvVu5ljhXg8UY9rfR65EbdpJ7AMZBG8u5FNSOIoUifnrKn7kf/?=
 =?iso-8859-1?Q?VW84NbNBNZZwt6OK3hI=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GeyZUi4fiTjwgu8de4QF0JIEuZTqvTGSC1CE0v1vTIT2kbYkIu4a1y1rZmS5giGe9S9Qjzgsep2IL5Zbf2NAWl9VG2/iZBbLJCrJYjLjVLGS8WW90PpKuypVJXrqWQZFvOeocZYNzKB9cDayye7se3UfyYsGnbTf64jcR4uzTVn0BA27x+tLS7TN1/OwsRwIeW2kkxB3zOLWLSd40cajcwV7DuIQQdK7HJfHuDiJn0qwVQXt+KyX6aZHTZXkeApEUziEJpfB/6vmi6VSAkg94tnf20+kfupEN+DHEjznr1QzSk++pELjglD3w8dgqMtCoTFJDDj6zPLsRcoLN4b5yrODQ+8aFQI+FWsV3t0bWZ0cL35AFasZmMN2yPFqBwy9/B1mLZhlRarVdWiJfJBAvuaaoyy5S4dqDTyplHhs15hwVFwMlYtztbcio7ECjJ6s7sigK6106US8PUy6tIu41glmP48R2SDHZHM+v3Bt8pT7tNeoesYm5ixPQJNmc2+7wDq2DQhZrzQeqstYXtb+ohrcCzXgMFxNqqKatY90DKVpVsNjzjfpiW0w84nPUIBzqJdW6BTOBidnoGhP1lsCERNZBLky5ljJt5g6a06S4PVYmfqyt5Yc8ARpvFvg0ZJd
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 508f24bf-413a-4fe0-de14-08dcd46945d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Sep 2024 02:59:38.7248
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cPmN9IOzEwb1Xj3FFu9tkIXXfInT4AUEFgoL7fpHx4+3bM4mX7SUK3l9G5opV4oR2ERjUcl3sFeNYhRpf1ij1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5950
X-Proofpoint-ORIG-GUID: 0XWxc607E-EoR-8M9FrpvOaMt80PWhkt
X-Proofpoint-GUID: 0XWxc607E-EoR-8M9FrpvOaMt80PWhkt
X-Sony-Outbound-GUID: 0XWxc607E-EoR-8M9FrpvOaMt80PWhkt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-14_01,2024-09-13_02,2024-09-02_01

I have been contributing to exfat for sometime and I would like to help=0A=
with code reviews as well.=0A=
=0A=
Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>=0A=
---=0A=
 MAINTAINERS | 1 +=0A=
 1 file changed, 1 insertion(+)=0A=
=0A=
diff --git a/MAINTAINERS b/MAINTAINERS=0A=
index 82f19f0f0752..031fd91a4e57 100644=0A=
--- a/MAINTAINERS=0A=
+++ b/MAINTAINERS=0A=
@@ -8378,6 +8378,7 @@ N:	binfmt=0A=
 EXFAT FILE SYSTEM=0A=
 M:	Namjae Jeon <linkinjeon@kernel.org>=0A=
 M:	Sungjong Seo <sj1557.seo@samsung.com>=0A=
+R:	Yuezhang Mo <yuezhang.mo@sony.com>=0A=
 L:	linux-fsdevel@vger.kernel.org=0A=
 S:	Maintained=0A=
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git=
=0A=
-- =0A=
2.34.1=0A=
=0A=

