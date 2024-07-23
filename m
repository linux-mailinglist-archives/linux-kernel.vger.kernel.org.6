Return-Path: <linux-kernel+bounces-260032-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BE54093A1C2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 15:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF8511C22384
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 13:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4920153803;
	Tue, 23 Jul 2024 13:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="YovPReyO"
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADE415357D;
	Tue, 23 Jul 2024 13:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=185.132.182.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721742104; cv=fail; b=K8KXtSrtWYhpUmGl24wV6bogrJB8AyFm7tRJpO+SLo7naC6pvN8FfLUB96SvHkz/X5dtDAMplC/Uq/0nGcm0OEAdX3VwyvF1X/EkQwtpKsJbxlUdcgF+N0FC42l6+yhjIPRZzsaiMT/YsjC1+wj1O0vzaDEBkMbEtCmswraeDCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721742104; c=relaxed/simple;
	bh=hRxyzNBpVrhg3F1Zd/W2TqpQCJLgadJOJWNXfy49/t8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QKdSLdMtkZ2NBPPUEnPyZ/PeZN7SslNq3dBacIRdyKdhXAudzX1PMJwJNwp+V9qwRr9kNVfQqHWYFREFzCuRXKI47nnba0JeVOLOjuj0Q3J96dD9KoG28pr4AQGSX3J2UWa7kA2grF5UhMzZlFKCpecdJOpJJM1GLAJ967p5Y5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=st.com; spf=pass smtp.mailfrom=st.com; dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b=YovPReyO; arc=fail smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NBcpQs032422;
	Tue, 23 Jul 2024 15:41:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	STMicroelectronics; bh=hRxyzNBpVrhg3F1Zd/W2TqpQCJLgadJOJWNXfy49/
	t8=; b=YovPReyO/CQVZgkCCvHBrLmb+Eif08tn9il/FtTqMyo/5r4MI33B4hgSR
	HiA+T1F/EOxpuv9yOe3t1qQC1KSRcNmzHJcBCKXLnDgS7o5Tp1l6PW1WocznE8BC
	LyH4DgsAuywYU6IZzDYrro4hzWbGGbDXVtVwn8+d8xZRM2i6+wb051Lz853kBihT
	SNi4P6tBxo65rWjYkfeQ5PUTuJQHM3TSt8Uw9FiyqP3huDAbcHN5B2KOyPe55oHX
	WZlbiGwCKvtCGcEGbGfVszUiIQBdYH6Y8mRESt4jfPR/VEV0tkGRvtkTusOOO0nW
	xkR1b0Tl3TZt96PdRKzspSpMFI81Q==
Received: from eur03-am7-obe.outbound.protection.outlook.com (mail-am7eur03lp2233.outbound.protection.outlook.com [104.47.51.233])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 40g4jxjkcj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jul 2024 15:41:21 +0200 (MEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VYI8mh/TMzX6PgOJ95F0mcPoRCwDPnfeU2tC+gHtgZU5z2HxAXEmqQvN1JuyZFTfvMAvzhS/5E00l34LRXB2o42JdbJj+ZEY1HsndL6KURtf9lN4uh8XL7tDWmQ73y4xFd4PAkFzyD8UMkad4iMxcBC+5Ew+rsmj6EF0bizdag4kvXTi+Y7894IwM7v/zgadIkwhgNGXgPYSHRLZ1jetNdk+lOkKG9fQ2/v+v8/oilVC9hqe+9pwqY+v91MWx2TH0Yc0Ncn8/nl3bp+5VL+0B2moJER4q6ZycoyVPV/CqsIJkoucycDQ8EvZImd6tFuT6QKGG29bjmnYvCjEWJDCCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hRxyzNBpVrhg3F1Zd/W2TqpQCJLgadJOJWNXfy49/t8=;
 b=bKNJBBi/OknwMaliEJGDrbrSp9RxTFwCHqL3qe0PQx/bsAlGLg9iO9wNsUcKBrfhjc19HkxpPuD6Qx3SWa9uTWc/hqhsQHrTdQRa8zuSYH9gfc4cMolKRV4hOs8pGmGZOxc9mEgSUv5fD+NkCTqYW6hR4xDEj81E4BrpXb3HD42n6aiJHSfFVXE7fLFfFzcgZ9sV9tDKreBYCK0WUi4o2fdlM3nX/pFNDrHJg2ZA4cm9To8hOPJsV6104WbvaI0H7QfVsWy/AX5N2tA2E0AZ2c0jPxLE1U/oYVKDmvHn+OIP84nU4fgue9qjYIDHwuP4gjCXpbgHav0xmNuxQv1iUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=st.com; dmarc=pass action=none header.from=st.com; dkim=pass
 header.d=st.com; arc=none
Received: from PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:157::13)
 by DU0PR10MB6827.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:47e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.18; Tue, 23 Jul
 2024 13:41:19 +0000
Received: from PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6004:1d1:46c2:e67c]) by PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::6004:1d1:46c2:e67c%6]) with mapi id 15.20.7784.017; Tue, 23 Jul 2024
 13:41:19 +0000
From: Etienne CARRIERE <etienne.carriere@st.com>
To: Peng Fan <peng.fan@nxp.com>, Cristian Marussi <cristian.marussi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
        "arm-scmi@vger.kernel.org"
	<arm-scmi@vger.kernel.org>
CC: "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "james.quinlan@broadcom.com" <james.quinlan@broadcom.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "vincent.guittot@linaro.org"
	<vincent.guittot@linaro.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "michal.simek@amd.com" <michal.simek@amd.com>,
        "quic_sibis@quicinc.com"
	<quic_sibis@quicinc.com>,
        "quic_nkela@quicinc.com" <quic_nkela@quicinc.com>,
        "ptosi@google.com" <ptosi@google.com>,
        "dan.carpenter@linaro.org"
	<dan.carpenter@linaro.org>,
        "souvik.chakravarty@arm.com"
	<souvik.chakravarty@arm.com>
Subject: Re: [PATCH v2 2/8] firmware: arm_scmi: Introduce packet handling
 helpers
Thread-Topic: [PATCH v2 2/8] firmware: arm_scmi: Introduce packet handling
 helpers
Thread-Index: AQHa0u8hQ9C+JDoCxk2oyJ4kGi0AkbHxWG+AgBK9WUs=
Date: Tue, 23 Jul 2024 13:41:19 +0000
Message-ID:
 <PAXPR10MB4687B2FCCA6E59CAEF769713FDA92@PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM>
References: <20240710173153.4060457-1-cristian.marussi@arm.com>
 <20240710173153.4060457-3-cristian.marussi@arm.com>
 <PAXPR04MB8459E1ED6375ECE89C8471AE88A52@PAXPR04MB8459.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB8459E1ED6375ECE89C8471AE88A52@PAXPR04MB8459.eurprd04.prod.outlook.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Enabled=True;MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_SiteId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_SetDate=2024-07-23T13:41:18.915Z;MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Name=None
 (Unclassified);MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_ContentBits=0;MSIP_Label_cf8c7287-838c-46dd-b281-b1140229e67a_Method=Standard;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR10MB4687:EE_|DU0PR10MB6827:EE_
x-ms-office365-filtering-correlation-id: 6b590741-3a00-4056-84f6-08dcab1d21fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?s6I6OQ1P9INB4vINX+SZ5E2hy+QarVraoWxZWNnRTmYuv/fpmcoecCs1kP?=
 =?iso-8859-1?Q?GzCenVTLqyz+WE2loo5jfd2tNHfq2I3QI3eWIhuVUIrvmj1UVSqW8uvP9x?=
 =?iso-8859-1?Q?A1njmnukcI458vGDOBmqnLW1rnnLxNJLAIWHXVikuLbdJRIlI+6mkj3C88?=
 =?iso-8859-1?Q?1ofvcsN2d2DyaiswoAqFViy4m4lAv037qJfSYGnHH8dii/Kjmu/t/w0S21?=
 =?iso-8859-1?Q?TOI4BBBNRvEm2yCJGXdXwW2ZaXQ0Y4l9RanVYpIem1O2S95OxwuIu7zxeq?=
 =?iso-8859-1?Q?RNLLom4J5rb5Zs5X8CTe8Y8lJjSALgbmt/vzUU8sgCpCYIwjcQNdromIzm?=
 =?iso-8859-1?Q?c2lma6BYLtwAUfVhjb3WVHFE/MWVWAd5oztNsKm7Q3j6YPHRbknB4P4fsd?=
 =?iso-8859-1?Q?Tu6u3s/GCJxLOe+mBWgRh5ZwVrnKJcAaFCEBQ4e6FjY4iFge0Nw87L9Zuv?=
 =?iso-8859-1?Q?LmD3PnNUbbyq135S7zvM6yHboRj5JxZqh/6Bl6ttVGSBrUgKxGYH+gZhYh?=
 =?iso-8859-1?Q?H2eVQqWYSWuRwEdvseicQwEy+GlKN835iNlycXnGTnZB2hzSe8kARsZtLD?=
 =?iso-8859-1?Q?6YKdtfk067GV0l5v8CmphyFPfiepYeNidfOk5i26GVgl2Bk1OCKmMkUo40?=
 =?iso-8859-1?Q?Docm4AmXoaZQDErm39MHZZhR2I4pTnSqw6vMffDIjqqKjnYm4MENAB8s4V?=
 =?iso-8859-1?Q?S5JrOlFckVi8d/A/gpqudMK2yXpywPd1cGoUiuL/ZObmdmaB8TwA+05zcc?=
 =?iso-8859-1?Q?SFn+pm6X9hpaRlSHM4wSnnzYsrDfArLPVLDVXLK2eLSKIqz3BhQdy/x1Gq?=
 =?iso-8859-1?Q?iNRbt+5OhPRNResn8eYT99BoedzdOiFbzr3Xo7Q33ChoWupanRLgAAEo2E?=
 =?iso-8859-1?Q?RLnnAUeqhtLj37DFMbJhlZTcInvE5SfrhWyoqlu5kkUdOr6lQOAleN8W7Q?=
 =?iso-8859-1?Q?0pFSDtAlM5C4AVDGkGIm5c5CTx5Iz24iFVgp+5He5xt13xSVzOsRgw/Uh7?=
 =?iso-8859-1?Q?x50EA0ZnVfmKJd0mr4891Hz4izWT1I3jpJ9a9cbG6SzBarOEPdN/VaaqIw?=
 =?iso-8859-1?Q?Oi/lePB3v54UIBSoO1n0SRY2FDZc8gzDRiiC1YLJ0pORSaBnY4J7H+r+sH?=
 =?iso-8859-1?Q?p32vagwCzyGBQbAdt90vf/976NSTJ1X0n5eqrkbVTcQ4SwFdVEnvwRkzO1?=
 =?iso-8859-1?Q?Z/m4AdsBOpYcNBCiQw0fQDy10qDPXdLIm0hgsjmrzMMyZrZ+apt8VDfNHi?=
 =?iso-8859-1?Q?W1e6BK7UvcQvm2R/6hHpQB4iiF6sQZS9GJjQH7uyicTlHtf6p4H51RTF8T?=
 =?iso-8859-1?Q?3NkN0PuaRECmrTe04N+GfBbMkGDCGZOjcsEu0hZmsRdruBj3v8B2uyMwRI?=
 =?iso-8859-1?Q?iAFWispf2o1kd3Q7pRsNgWOl3r0RnkxGqJITlVUqMT9E0yNykVc0DKp1Kv?=
 =?iso-8859-1?Q?uaggxygSZwAovWSbuFvgM48xbEySjaXCilf9eQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?EeNhObxa862zd2K84yT+GJu70o7/yU53AfoCNN3/N8m/BIDaKQoHygSWpp?=
 =?iso-8859-1?Q?XrR2T+3+E6ufJwq4gon9XOyEu938bj49yUdyYgPIp6JeP84XBt7rBLCjBu?=
 =?iso-8859-1?Q?RL+u+xp+/HbgMyW33zkayn68AY+U2sJ2ZOFw6jl/j5UBmzjIA3nyt6t85t?=
 =?iso-8859-1?Q?By4uQM9SFoC6B3CiB54aDMNE5kzC+ZjI6mFbRDhZfa7+7Tf3QrrQ+j5h/h?=
 =?iso-8859-1?Q?DnwBmw1yersoRA+p1Xg1QIHAVwhzwta7onwZ1EKhCzM/i8d3G1yxrtWFZ7?=
 =?iso-8859-1?Q?WeTie/aGVioz4FVJl/RYQB9Cbf2uL3dyD3E/v5J0nS/Gjv9GiXWVNJmPTN?=
 =?iso-8859-1?Q?EU1fF6Ff/Ipv05hFa92SG9MNq7HgDXeJek/7frEx51XQH+adFCPTEA8gUr?=
 =?iso-8859-1?Q?izgP6rm9Uigb1UtTRII0PIV1LRISjVSv2D4++EDGi4cF8py7PSAU/lFlb1?=
 =?iso-8859-1?Q?G6BShU55wbfOJehTmBx5cezDnsg10zfQgIffA+3bkcwKxIHwGlUxkGXuhC?=
 =?iso-8859-1?Q?38CAP7Khv0Hie3f9F1CYKCqgj9+2QRUXWVjN3OxRvXlee6uZgGtbwjSrJU?=
 =?iso-8859-1?Q?K/p2hDs6dlwhmC4FG4xFgzrRvwm52IGWKRBKDNVZ0l7Ttr7qJ9joercnNi?=
 =?iso-8859-1?Q?XQJAdoj/GXorHvR/K26d1PQDKq9X+nPh2FEoJxYcEx8QCrWNKMzGu99pGY?=
 =?iso-8859-1?Q?wcO9wTwqx6OUr672akeZHipYUyjMnNVn2UVSyVznpU5rF4GuXpXGCAZ2Op?=
 =?iso-8859-1?Q?lH0jYypeGIb94hq9bZNWW/U+f4QehX9cyxxKkAoCKn+cgS5/Vj+mcNY6qp?=
 =?iso-8859-1?Q?nSuHIUTJHJVgEN9J57ujs4hndl/IXjcPUrJ7v+ut417/sJnDiOVNqic31X?=
 =?iso-8859-1?Q?BbVaxX/nCjnd/VjjvmyiDURH7EQRxEM0UXODNhOUi1UICR66ONMsWwE5IA?=
 =?iso-8859-1?Q?jn9Zrrzr6IorQVUy12nYeZGYj3qPl+/ZbdeaD46m/P1VEA1hGhtKP3/z82?=
 =?iso-8859-1?Q?Y3c8l7VQfPcz0rcCnopdAWKEhPnL7mnA/1Kj59vB2HnwQp41wr/Thw5Ge2?=
 =?iso-8859-1?Q?drkSZf6QaIBNdMI66sqDEe/laVb41eZgwXnGWw08zgTgCmgVYAsMkPgvKW?=
 =?iso-8859-1?Q?0Bx2WNC6wLkwYK+lllsKQ7Ecqo2lZ+KfC1+v6xqMkIwR24FXLFY96qJUnn?=
 =?iso-8859-1?Q?64z60NhFeEjzdFxUIxdJkI36DPBTimvqXK9bZ3xjCbC4yIFGGsvz34iW0s?=
 =?iso-8859-1?Q?uIl9DFYFMwIrada3caeW+lZyoqFv9HDxplhG5ySCEi5kaaiDbjR+9nUCa0?=
 =?iso-8859-1?Q?8DEp6Z707kxK/d/lWpM7ysDTLQtgXcBRajJ7zT4tcgjlGuhHKiXD2pl9Po?=
 =?iso-8859-1?Q?Lh1M4jceQDLWyVan9BjrD5vyYrKoj73C9+4pJL8fCCcdJ4M02hXDDpu6Iz?=
 =?iso-8859-1?Q?kq8akHf/iTcS12bPAli9HJr9e8pptYnFT871kYzIIrWA+xuSNEJuceSsTT?=
 =?iso-8859-1?Q?xQaeb2qQYxb+Su9uvzzerc0g7NskjjdQY6GgnTorB4naUfEKgX7EEKH5W2?=
 =?iso-8859-1?Q?q2dWPSQQyOXOYltcu1D/P7kO/o7WQv4gzl6kVML2e6o8GCJa6MXHDygUY5?=
 =?iso-8859-1?Q?Eqxy1gpI7hFd06iaUneiLjgrlVXlcs/Cyk?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: ST.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR10MB4687.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b590741-3a00-4056-84f6-08dcab1d21fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2024 13:41:19.2183
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U1mvs6wl3UQJWOuZ8TAMI9mwfXUUZIwR87yCKJ5YjqHTAzf8uTDkXBuPcta+uaoPKLTiOhAgL4QxIbMrtlGvbQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6827
X-Proofpoint-ORIG-GUID: GZCvirrSfONTLcElZ9BBLkb80gcxyaAB
X-Proofpoint-GUID: GZCvirrSfONTLcElZ9BBLkb80gcxyaAB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_03,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 bulkscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 mlxlogscore=999 mlxscore=0
 malwarescore=0 suspectscore=0 impostorscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2407110000
 definitions=main-2407230098

Hi,=0A=
=0A=
On=A0Thursday, July 11, 2024, Peng Fan wrote:=0A=
> > Subject: [PATCH v2 2/8] firmware: arm_scmi: Introduce packet=0A=
> > handling helpers=0A=
> >=0A=
> > Introduce a pair of structures initialized to contain all the existing=
=0A=
> > packet handling helpers, both for transports based on shared memory=0A=
> > and messages.=0A=
> >=0A=
> > No functional change.=0A=
> >=0A=
> > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>=0A=
> > ---=0A=
> > v1 --> v2=0A=
> > - fixed commit message=0A=
> > ---=0A=
> ......=0A=
> =0A=
> > d33a704e5814..f4ba38afe0bb 100644=0A=
> > --- a/drivers/firmware/arm_scmi/msg.c=0A=
> > +++ b/drivers/firmware/arm_scmi/msg.c=0A=
> > @@ -4,8 +4,8 @@=0A=
> >=A0=A0 *=0A=
> >=A0=A0 * Derived from shm.c.=0A=
> >=A0=A0 *=0A=
> > - * Copyright (C) 2019-2021 ARM Ltd.=0A=
> > - * Copyright (C) 2020-2021 OpenSynergy GmbH=0A=
> > + * Copyright (C) 2019-2024 ARM Ltd.=0A=
> > + * Copyright (C) 2020-2024 OpenSynergy GmbH=0A=
> =0A=
> Nitpick: OpenSynergy year should be kept unchanged?=0A=
=0A=
I agree. Copyright dates on original non-Arm contributors should=0A=
not be changed, here and in patch 5/8, 6/8 and 7/8.=0A=
=0A=
> =0A=
> Otherwise looks good:=0A=
> Reviewed-by: Peng Fan <peng.fan@nxp.com>=

