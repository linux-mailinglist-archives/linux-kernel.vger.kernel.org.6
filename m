Return-Path: <linux-kernel+bounces-196468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E040E8D5CAE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 10:27:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 084201C22E4D
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 08:27:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884AC14532D;
	Fri, 31 May 2024 08:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="Gv2unKed"
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14659EEAD;
	Fri, 31 May 2024 08:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.139.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717144043; cv=fail; b=dujhhpUZOTj3ErEEa2lCfqQQebldDd9lMLWeu3ds0ydLGbG2Jw8g5/lKTCey8bos1gind8pvBCg/YA8zfbttVNR0l6GpXtSin1Esx4xBQs+dmX0bi0I9LzRV2T5tWfBW0YUyinUBas6edQUXpwWTEMbnN9sKJvBU7SG8mLa4xoM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717144043; c=relaxed/simple;
	bh=CTr8XBAGvFJfqHNJj5YeC1bn0ylzLEOSTUbgmEk6IIw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JTy8M2ws6zPaDVu3SJxHr0T+MrgEWVCkEH7gvwioOSk8/zOEaeb0LgpZRLMhEVku/RIqsgI1mD7itE6rvQrRsoz3Cs8j8gu3Bg2GwI7dOGi5lHWj/xmGa//kfhbO7gNfFTtXP7bhpVJg7h6C94vn1zzZVumlBKutzYlhOPPp2uM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=Gv2unKed; arc=fail smtp.client-ip=148.163.139.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0375854.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44V6Sqv8030403;
	Fri, 31 May 2024 04:26:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=LM8M8
	fVrdlFYTGjInzGXyD2oJSq95+Bp7/UGHSjs0Xw=; b=Gv2unKed0s5aOLmXL0WM9
	7yhDf2GyE0L2zddIuUCYjw6W0jrqLVn/HzGpRvxn9yajjXWQt+44LsP0+hOlQbQm
	x7+H17WHGz7mIxrUVTgQmB4hSPy1oYslCt9shdKxva4Ndu0+6kY60WAwO3UnYMtj
	yR90pVRa0Y9NYbp96pTNfqipHKaL5E9lgCqhG0+px/PlHocHn2pQqGDJWWKNyRdT
	rgDIlyqHlpRqoKP1bQH7TR3KseWOpo/VaG3b19SaiFty4WV/AsqxF+Hnn6t92thw
	uud4aAklyT2bVuxiuUlXl6rDfaObd40yC2yQklmAM+Kn9aPIWKgQydoTG7vgYJt1
	A==
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3yf9argb92-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 May 2024 04:26:59 -0400 (EDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EKbp4cMKf22VUBnjpgaW4dD6Qf+r+KKmobw5l3RSwiTsLsMdGvcGmE8L5AP/L/EoeJlkneu9Jm67yFDhYLXPXWSca/Wl4QgBB5hT1baMfzSRFbPMWXBj5c0PY/be5c5XQZgXwUV2KeX2ETaIGncE7uucCoyS12bHfQ4cSw41V41rpmm69XKah9x1cY6lNKB0pjiKirOqquQvol1z8iEiWgxwrD0i7wfc7k0vx7b5PsMcqK7R9J31Mkb3wZtatvSxy9/IusZyR0eInCKEtHvP/ord+0N/Pmp4fHxhpC77Rpf298KkOgIAFFMkN24ZAC1YqmwcIoIdYnnhlLHvJjawpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LM8M8fVrdlFYTGjInzGXyD2oJSq95+Bp7/UGHSjs0Xw=;
 b=WPN0Bn2PnH5wYWed/a9xS6YZ3qu+qn6RaYw6o9hMPF4O843wGOlCeMFRJn79rxIABLVXxTmvEfQFV+WFPWcNKioUMAZ+rehonE04Pn+v7fby7J7i2hoIxrRevGY3RI4S/rnMj6bxOMOv9LzAwxovlnfppd0jmrn4MYZ5xGlJQSobynFA6IyG7f49vsHc5PAYh+zC27pzD1OwKOaY5zYQ9p4wkWtLJGBevnPuhTso6+aqPuU/V/6wXUoGmZQxFNkIalNLRG6HEoVAWQxs3H+L7sD4F9566XCV7WS02o5mpPLRnGS+VghJRcx+yytYSZ8W2brB9D6E3NiSO+Ss23rSJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
Received: from SA1PR03MB6499.namprd03.prod.outlook.com (2603:10b6:806:1c6::8)
 by SJ2PR03MB7450.namprd03.prod.outlook.com (2603:10b6:a03:561::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.22; Fri, 31 May
 2024 08:26:56 +0000
Received: from SA1PR03MB6499.namprd03.prod.outlook.com
 ([fe80::c9c9:97fc:3779:8dd1]) by SA1PR03MB6499.namprd03.prod.outlook.com
 ([fe80::c9c9:97fc:3779:8dd1%5]) with mapi id 15.20.7633.021; Fri, 31 May 2024
 08:26:56 +0000
From: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>
To: "Sabau, Radu bogdan" <Radu.Sabau@analog.com>,
        Jean Delvare
	<jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet
	<corbet@lwn.net>,
        "linux-hwmon@vger.kernel.org"
	<linux-hwmon@vger.kernel.org>,
        "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v5] drivers: hwmon: max31827: Add PEC support
Thread-Topic: [PATCH v5] drivers: hwmon: max31827: Add PEC support
Thread-Index: AQHasoQWyglzjeI7aUWz4Ib9poW0nLGxAsVg
Date: Fri, 31 May 2024 08:26:56 +0000
Message-ID: 
 <SA1PR03MB6499B0B15E16917912A24429F7FC2@SA1PR03MB6499.namprd03.prod.outlook.com>
References: <20240530112505.14831-1-radu.sabau@analog.com>
In-Reply-To: <20240530112505.14831-1-radu.sabau@analog.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: 
 =?us-ascii?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNccnNhYnUyXGFw?=
 =?us-ascii?Q?cGRhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?us-ascii?Q?OWUzNWJcbXNnc1xtc2ctODk1ZTAzOWUtMWYyNy0xMWVmLWE1ZWMtOGMwNGJh?=
 =?us-ascii?Q?ODVkZjE2XGFtZS10ZXN0XDg5NWUwM2EwLTFmMjctMTFlZi1hNWVjLThjMDRi?=
 =?us-ascii?Q?YTg1ZGYxNmJvZHkudHh0IiBzej0iOTI2MCIgdD0iMTMzNjE2MTc2MTUwNzkx?=
 =?us-ascii?Q?NTI5IiBoPSJIZytDTDdCYlNHYXNmZTUrTzZ2Z1YxUVRtTDQ9IiBpZD0iIiBi?=
 =?us-ascii?Q?bD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQUFFb0NBQUJw?=
 =?us-ascii?Q?eGJaTE5MUGFBUVRxdGttQWRmTnVCT3EyU1lCMTgyNERBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?RUFBUUFCQUFBQTNMaFNmZ0FBQUFBQUFBQUFBQUFBQUo0QUFBQmhBR1FBYVFC?=
 =?us-ascii?Q?ZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0JsQUdNQWRBQnpBRjhB?=
 =?us-ascii?Q?WmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFHa0FkZ0JsQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFF?=
 =?us-ascii?Q?QUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQVpBQnBBRjhBY3dCbEFHTUFkUUJ5?=
 =?us-ascii?Q?QUdVQVh3QndBSElBYndCcUFHVUFZd0IwQUhNQVh3QjBBR2tBWlFCeUFERUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFB?=
 =?us-ascii?Q?QUFDZUFBQUFZUUJrQUdrQVh3QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZB?=
 =?us-ascii?Q?R29BWlFCakFIUUFjd0JmQUhRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?us-ascii?Q?QUFBQUFBQUFBQUFBQUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRh?=
 =?us-ascii?Q?Pg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR03MB6499:EE_|SJ2PR03MB7450:EE_
x-ms-office365-filtering-correlation-id: 5eb0d7f9-f638-429b-4b8d-08dc814b6f3c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230031|366007|1800799015|376005|38070700009;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?QxYnHtAgOnDhr+fhpk4vwtv3nsDw3orQTToiS7yRNIgvyUMVYCe6+NXauTVA?=
 =?us-ascii?Q?wu/hovakxDnXstk7ue7XlHM1mitbPXlhrmcwnh4LjeBYvvdqj9yHh9cJSdNL?=
 =?us-ascii?Q?NNB2V6zH96mFwPpBtznt/tl/8HMslZOfalPPFoniv80xBlVW1NyEJhTTJxv+?=
 =?us-ascii?Q?3+Qv9tDkHUilgJzA8xzPLfy2oP0yHLQDyiRy3V9to/HFaaDl2McB82WHXEE6?=
 =?us-ascii?Q?0Jp4WR7kpI4Kluc6DOeGdXZDFrxetF0MbKvM6OjFCtPCAHI3IcIdmCiLGWmI?=
 =?us-ascii?Q?BI2uFTqpQC5V2e+e3EMrwXjlHlwKIa+GK3uS0a5tOpY6WZvAYP/dm18BXJ6O?=
 =?us-ascii?Q?b5rkl8F3TYxJsQpjKTXUqYydoxlJE6DBP6VpEqD6+UvGrGrMNbsp1q51MS+i?=
 =?us-ascii?Q?oDXChvgJ9TCN6wzMQTPGxMjk7BsqxyhzmYgWzCri5J0pcX6258qvG2eo9nGe?=
 =?us-ascii?Q?Cws7qOB777CYwDiJPTvS+2weh8Nr6wHT7SjYHcQqO1pSM9fdEdnCjGs5FKof?=
 =?us-ascii?Q?v7ONATW7qLPXpxJ4F3TwmGesxPLrq1Bi1vXLNlpSmlf1cMAN7URHrW4ghmBj?=
 =?us-ascii?Q?zYp2rW8+iQkcz5iYD0odDV36Wa0NS9VpzJOchSJu17dbho3RslvxNiioqHPZ?=
 =?us-ascii?Q?oXpvbyfpX6BxXwn56vEch3IGyndLuIwFBPjgE3Btrb7wVFv7rYm6s74N8qqX?=
 =?us-ascii?Q?texH0MUQuJQoysTg0JMWWlNN9MR7yEtul2PDK/3tG9QVc124/mjwmSKOyhsy?=
 =?us-ascii?Q?JXZDZSbDN01Vxy+8KSKl2rEnOHEWiTFa/Ix3oZnz0B1D3X+CuZip8Mg7CdQk?=
 =?us-ascii?Q?fgWPUsz00K3xJUcJCej829d204remryLb04dGG4wdgFPaINwkH+ngDH8YLEY?=
 =?us-ascii?Q?M7+/QcyoPH7egI9/wCpzWs83IXGZzRdx7H6GoEewz1KHXfqCw6g5Bq7FG5wE?=
 =?us-ascii?Q?8CxadjwTS/nE8Emx/JfOLuw7JkOt8FEOiHYtYcO1Pa0s7QWrz1Yxo41ehwsO?=
 =?us-ascii?Q?qqwtdRNZ0KADl71qKgKxbRmJ/4jnc7OABPylbney0ZS7zUlfbfHrFaRWDN1g?=
 =?us-ascii?Q?3kj2+0WQsCLLa0P3MLCl6uUi0/RSlTaW2V8/eeU3AzJE/qLBiStuf/3HGjWV?=
 =?us-ascii?Q?uvpy6FTIMqzX+hAntW6huCb1tX4f/ZW4nO8+e9eSLW1GsIR0JvfDBZ3iEDzw?=
 =?us-ascii?Q?HxeZA9rPotevM7zSfPvp46phLcxdD3xN4Ckpt0mgv5CgwaqBngJEQBWUfbxR?=
 =?us-ascii?Q?/LuVXYFweSCjxhKCS49+MqSdpw+F9KWfKJj0YsjOKNxz0X68hcuK0VlPgZT/?=
 =?us-ascii?Q?KtJgAwkzMw26JRgf49kEf9ZGniI30maeQjlvvlL2jOUTgw=3D=3D?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR03MB6499.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?mh6qjXWvmAlPiANJA1Le/laMBQ0Jg/CY3Mnt2IMUSJ+2mZxYbnN9mX1zDj8C?=
 =?us-ascii?Q?I5MQo8GyzHvvSbJG1r9JtNTGd5HcMVQUMwzzjQ4pt5HsSnzLpNEOxwC3dTkH?=
 =?us-ascii?Q?7ZDZBVotS9zbtlYcr2mODtsvSZgvTWg523EXr4yByy8nhX8exCewInpKGOmm?=
 =?us-ascii?Q?5l/0tPLbUq7xGTTNPk8a89jR/56XwXb+ZUrXe6YZXvKW5hDnmTyk/dhEZqiI?=
 =?us-ascii?Q?QIchSFYCu4NdLhIvitJOkYC155wN1nR99WS3UxzE40tXX2c5A8lJeOZkbp1+?=
 =?us-ascii?Q?5Y2bHtHWXlLwUpxtUY7o71eTTGXk4IrzTIFaFp+hbhLkTfhoSJyXh9iJtHNj?=
 =?us-ascii?Q?JLY4Kjhvt+tcaPJfXrt6gWYNOu3HpuKmqwztL2mHHIp+lXb4FtOiP/UQrhzQ?=
 =?us-ascii?Q?HAbb/2grOyp+h8yQmszIjUkBygvNadul0lpMPuRit+iwUZjC6HqIPQcfDKv2?=
 =?us-ascii?Q?Uu68VNiBTPLaRLAvUu25WdKvdjv9098p5Z8KULBDFcXEeW/H0DF9wziRINer?=
 =?us-ascii?Q?xCSXPBoXUeS7fGaqMIeoXC2tzBetTmWZ0YgY6BGvVKaCtG7hHyF+PBbdJAH9?=
 =?us-ascii?Q?TRKLu0WWebEhsjcJ2J1Dwbc0FfXJHfAqoznxFtws2YGIzP9UyieqFjP7lUBB?=
 =?us-ascii?Q?rYwFUxQ/Qr1b92XSPT6n5LDqN7+qOBc3/dUxKvlUNScrkMl1OGN/nzn9mgWe?=
 =?us-ascii?Q?CVFgbSyd1UQSSNXxOBt94CnK00DjEbt4YmhlPLkUm1oBBMpzGdcvAMB+Rhmx?=
 =?us-ascii?Q?ARiOqJg1uEWZpOLMTaXbd7n+90PF6Ol2Yg4v2MOm/fHOIrIeGxZ5Qe1uFTbk?=
 =?us-ascii?Q?DWazkp+7qv8eU0vDar0H2VTjppp+I3L5hAP3k81OkkdFoGmgQxC30cdnnJjS?=
 =?us-ascii?Q?T4VdyJNJ7XlDC/9kg55AbJt/sivKDnByAEHOjHjOFO0Z4pS25oVgbJ4RBq5f?=
 =?us-ascii?Q?Yy2vqnV2BMpnr+7E1rQqfSWTRJpod8pWhh8GEH2+wO1/rkXQj3b+mRPMDUGE?=
 =?us-ascii?Q?/8JKX7hFr7aoZKjx3rErWBho247CQ8CpJBNq28yMZ+0xji+Hu1FPhILhAmpL?=
 =?us-ascii?Q?M9dhuPoWdKkX4UUSl1R06RsjTuTLriJK2y0t/dWJJQKEKYGhzNy2ANsIvbbm?=
 =?us-ascii?Q?CN7ejDmanHgfOmNRUGhM7wNhEuMdbw5nsfwZ4hSS9Ui9DpB/wJyRWdRBFELW?=
 =?us-ascii?Q?VDuorrgDpNXUooFXhXQuz3N9ZMLYhxWrN8kZ1rWJKH6yvYrLeZs8ngJPlSOn?=
 =?us-ascii?Q?oc6V4AErpogpnM9aDqf+88t97GRsfivxZRyq+Oqx8PsQBXM+x82HdGmalbwW?=
 =?us-ascii?Q?Mni/4QEs7oZVhGvy0uGRWO0wZZk3LheIWB3nohWDQzfl2eKPJ1Q6rEQjaud6?=
 =?us-ascii?Q?3b6rzhOalzOCfgBWK7hpNURDJaUaoirW540JMokCE+A2/sis9ilHnAGSZrBJ?=
 =?us-ascii?Q?bZYKwBUMcedC7u78wZxCZBGqnMvJYEthnyET0VfwkJgAc6sdL+pxZupdXOEl?=
 =?us-ascii?Q?ikxsB0nWSf/mvp3LXGXf67JCt+LHwaLeCXrx+cfPOT7tH+iRx11fWt4ugr/4?=
 =?us-ascii?Q?WqxyWv0FzoDxmF/pGiVQRqTGKj0IT7inQviNfiS/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR03MB6499.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5eb0d7f9-f638-429b-4b8d-08dc814b6f3c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2024 08:26:56.8367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CA/YUtr6DyZ1ZbHYApSPCDb5jDneXtTLbcy013cpNhiOf2X6Suo2gkRlBkWiD8ckeVnsF3qbU00CUe7ETgl8+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR03MB7450
X-Proofpoint-GUID: fLbkgVrbxEOIAPL1pc_jd8yzxJkGbEPW
X-Proofpoint-ORIG-GUID: fLbkgVrbxEOIAPL1pc_jd8yzxJkGbEPW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-31_04,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 impostorscore=0
 adultscore=0 mlxlogscore=999 priorityscore=1501 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2405310062



> -----Original Message-----
> From: Radu Sabau <radu.sabau@analog.com>
> Sent: Thursday, May 30, 2024 2:25 PM
> To: Jean Delvare <jdelvare@suse.com>; Guenter Roeck <linux@roeck-us.net>;=
 Jonathan Corbet <corbet@lwn.net>; linux-
> hwmon@vger.kernel.org; linux-doc@vger.kernel.org; linux-kernel@vger.kerne=
l.org
> Cc: Sabau, Radu bogdan <Radu.Sabau@analog.com>
> Subject: [PATCH v5] drivers: hwmon: max31827: Add PEC support
>=20
> Add support for PEC by configuring chip accordingly to the hwmon core
> PEC attribute handling.
> Add chip_write function to be used by max31827_write when setting
> the attribute.
>=20
> Signed-off-by: Radu Sabau <radu.sabau@analog.com>
> ---
> Change log:
> v2:
>  *Rebase on top of v6.9
>  *Attach pec attribute only to i2c device
>  *Fix bug to attach pec attribute to i2c device if the device supports it=
.
> v3:
>  *Use only one variable to write PEC_EN bit in configuration register
>  *Use regmap_set_bits to set PEC_EN bit when requested instead of
>   regmap_update_bits.
>  *Fix typo in commit message.
> v4:
>  *Use regmap_clear_bits to clear PEC_EN bit when requested instead of
>   regmap_update_bits.
> v5:
>  *Adapt driver to the new hwmon PEC attribute handling from the hwmon cor=
e.
> ---
>  Documentation/hwmon/max31827.rst | 13 ++++++++++---
>  drivers/hwmon/max31827.c         | 17 ++++++++++++++++-
>  2 files changed, 26 insertions(+), 4 deletions(-)
>=20
> diff --git a/Documentation/hwmon/max31827.rst b/Documentation/hwmon/max31=
827.rst
> index 44ab9dc064cb..9c11a9518c67 100644
> --- a/Documentation/hwmon/max31827.rst
> +++ b/Documentation/hwmon/max31827.rst
> @@ -131,7 +131,14 @@ The Fault Queue bits select how many consecutive tem=
perature faults must occur
>  before overtemperature or undertemperature faults are indicated in the
>  corresponding status bits.
>=20
> -Notes
> ------
> +PEC Support
> +-----------
> +
> +When reading a register value, the PEC byte is computed and sent by the =
chip.
> +
> +PEC on word data transaction respresents a signifcant increase in bandwi=
tdh
> +usage (+33% for both write and reads) in normal conditions.
>=20
> -PEC is not implemented.
> +Since this operation implies there will be an extra delay to each
> +transaction, PEC can be disabled or enabled through sysfs.
> +Just write 1  to the "pec" file for enabling PEC and 0 for disabling it.
> diff --git a/drivers/hwmon/max31827.c b/drivers/hwmon/max31827.c
> index f8a13b30f100..4a5f86afd84e 100644
> --- a/drivers/hwmon/max31827.c
> +++ b/drivers/hwmon/max31827.c
> @@ -24,6 +24,7 @@
>=20
>  #define MAX31827_CONFIGURATION_1SHOT_MASK	BIT(0)
>  #define MAX31827_CONFIGURATION_CNV_RATE_MASK	GENMASK(3, 1)
> +#define MAX31827_CONFIGURATION_PEC_EN_MASK	BIT(4)
>  #define MAX31827_CONFIGURATION_TIMEOUT_MASK	BIT(5)
>  #define MAX31827_CONFIGURATION_RESOLUTION_MASK	GENMASK(7, 6)
>  #define MAX31827_CONFIGURATION_ALRM_POL_MASK	BIT(8)
> @@ -332,6 +333,18 @@ static int max31827_read(struct device *dev, enum hw=
mon_sensor_types type,
>  	return ret;
>  }
>=20
> +static int max31827_chip_write(struct *regmap, u32 attr, long val)

regmap parameter is declared wrong here, will send fix in next patch.

> +{
> +	switch (attr) {
> +	case hwmon_chip_pec:
> +		return regmap_update_bits(regmap, MAX31827_CONFIGURATION_REG,
> +					  MAX38127_CONFIGURATION_PEC_EN_MASK,

typo, MAX38127 -> MAX31827

> +					  val ? MAX38127_CONFIGURATION_PEC_EN_MASK : 0);

typo, MAX38127 -> MAX31827

> +	default:
> +		return -EOPNOTSUPP;
> +	}
> +}
> +
>  static int max31827_write(struct device *dev, enum hwmon_sensor_types ty=
pe,
>  			  u32 attr, int channel, long val)
>  {
> @@ -340,6 +353,8 @@ static int max31827_write(struct device *dev, enum hw=
mon_sensor_types type,
>  	int ret;
>=20
>  	switch (type) {
> +	case hwmon_chip:
> +		return max31827_chip_write(st->regmap, attr, val);
>  	case hwmon_temp:
>  		switch (attr) {
>  		case hwmon_temp_enable:
> @@ -583,7 +598,7 @@ static const struct hwmon_channel_info *max31827_info=
[] =3D {
>  					 HWMON_T_MIN_HYST | HWMON_T_MIN_ALARM |
>  					 HWMON_T_MAX | HWMON_T_MAX_HYST |
>  					 HWMON_T_MAX_ALARM),
> -	HWMON_CHANNEL_INFO(chip, HWMON_C_UPDATE_INTERVAL),
> +	HWMON_CHANNEL_INFO(chip, HWMON_C_UPDATE_INTERVAL | HWMON_C_PEC),
>  	NULL,
>  };

This patch is wrong due to the fact that hwmon_chip case is duplicated insi=
de the switch, and therefore
I will send another patch fixing this and also modifying max31827_chip_writ=
e.

>=20
> --
> 2.34.1


