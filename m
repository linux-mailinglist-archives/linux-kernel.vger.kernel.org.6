Return-Path: <linux-kernel+bounces-305370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8A50962DB3
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 18:32:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 012CEB21410
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 16:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 036201A4F29;
	Wed, 28 Aug 2024 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Dh9MLZwU"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2082.outbound.protection.outlook.com [40.107.244.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A139D18786F
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 16:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724862709; cv=fail; b=EpK5NTwxUSWhDzGRQG6MM8g65zBH1eZOdiRR8QWu18+f4Ch+IJDKoDFuM1sGF5SNg1qlFkUdg/7grFNf6GiMZdXEEQpo+C7jXEH8W+Z1c8y+IOsB1Ym+WMPNuYc/xd8R2gUQj4QnXHrdjQ0R32bL3lmdSC9pip8DW+pcfFlABPc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724862709; c=relaxed/simple;
	bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=hvmz07Pwo8P9HdJf+LsFBNP13YPsxvbzqLyd0Ex5QNeWXaBviJgNVuzYpAGEIBpy2jOh/w276pEhitZWjcPUcUYdqT5jZ5v/0dXh2tkbocI+OpbTIaP94qAByoRk0BxCxIyWYnIQUlhKcjAHJCRP1wRtMxeemAGS1BkynTusyaY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Dh9MLZwU; arc=fail smtp.client-ip=40.107.244.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dx5+biS823LFjIE1m70+coMJaRc/qSsKcOG/HlnuEKHFPk8pM8ETto6CQm95MKvtL3nVbeIZ5foHDQtF8prbKPjM+leFtU6xMWDmkag6AbGw6cdu9TsL+hF/9CQjL5SzPXl/o+PlrFS+YeQbBvmLNTGQUl92J77d9/sWafjXl0JOG+bpzmJLg3w3+VDIn9XeTQkidVBjmQrav9sSiuHP7sXqOlLtN+ThJl6uTYqLE2Vly6mF9AIvspHXpJuf2YCL1K5UQb/7qVlYKM0peWRLjcaAiPJ66ZyyX3CDo6qDVD0yKZOARg4b7l9DWx0byADRtjUnhqwRHA9/V1AfY7FTBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
 b=NB+pGsD8Xf1Wh5JHM+JOBtVO2o9tCjNwmwDO/R7vyGwGg8SDDNOVbIEDoCWoFHNL9bUATyrMkgptQm36DCjGFGyuYgCPYKBGBUWVRuSLGs5V16oZrbwrQszYeYTwEmOwvwIEon6W3QzStI6ZtURWPdw5TV3t/E4WqlCaTxKD1byds/uzz9moyKTPp7Z9AzgcAeJzA7FeUtaTrUT0lmm6IqdtcojmosL0g8CdUG33zH/TFyMew61+2oYUrOZhOPFhitrd1MTMYT0dD2uIhU10dEX19dgmEH6QzgGUqAaM2WlYCkoqhXvFmUASBc36YeHr240Oxc17Sm9pX54WqS+zdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIkL3j1SUti+mxRknWXsGzjEHfZ++LfAOrCAj6OvBfk=;
 b=Dh9MLZwUsKua8NUYx6e4IFNYf7g+PefJqhn2tJ8bq6/UHF7+tukcKShXFzYS0zgSw/cwSwoJI6/VIB3n5eoL4PHW+Xxe6n5n/wXnQ/fVbmalA8X4KRWsMxf7m9Z4U3HvNmSjmV+us+IzmfOc1EVB6po7STGNB7+lbZJppUNMxMQ=
Received: from LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21)
 by PH7PR12MB7188.namprd12.prod.outlook.com (2603:10b6:510:204::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 16:31:45 +0000
Received: from LV3PR12MB9260.namprd12.prod.outlook.com
 ([fe80::e5c3:25dc:f93:cb99]) by LV3PR12MB9260.namprd12.prod.outlook.com
 ([fe80::e5c3:25dc:f93:cb99%3]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 16:31:45 +0000
From: "Thangaraj, Senthil Nathan" <SenthilNathan.Thangaraj@amd.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: subscribe
Thread-Topic: subscribe
Thread-Index: Adr5Z8OKQ2kGCi5sQSC55Ej+37aaLA==
Date: Wed, 28 Aug 2024 16:31:45 +0000
Message-ID:
 <LV3PR12MB926073100AE1D7F928597BD8E2952@LV3PR12MB9260.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9260:EE_|PH7PR12MB7188:EE_
x-ms-office365-filtering-correlation-id: 4a3c8660-769d-4f0a-2b81-08dcc77ee810
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?nBN5DEUDnA9bD6+S9oVaFhCGUe52tGN0ncdgFz9T3NJ11lV3L8h+zsodHrll?=
 =?us-ascii?Q?vXAA4v6BPkJJLcYD0hvSM0nylDR5fdhDyFVzSDPm+kPgyRUlOwgao3Sfsp2M?=
 =?us-ascii?Q?PZTsOY5pgQd6R/3PmHzlcY5uG+gKnPHKFLDnLmpJqvVoPYtNDkaD7uya8IZK?=
 =?us-ascii?Q?RSRhBIv/zQMQkftVaASAMLM3dDm3MtLPhvY0tXjXOLU545o70Oe9489UJZah?=
 =?us-ascii?Q?wm4JByEowFgpyU+MdYk96wF21mxEIAMsVYnfYRGLtUmZvxzGN1qQVq92BsDc?=
 =?us-ascii?Q?5xVEPT/9yrhevGKM2XiUiJjrJtpAxGNEHc9t936DKvcouCOrumpcrWqM71jB?=
 =?us-ascii?Q?WVtNgDADM9r5QqEK60z3Ulz8AN7qoPsuRkKBFRkOpXG3M5dUAv8O7ii0ciCt?=
 =?us-ascii?Q?Yt157HNkuGFd+zKk1VJmNHSeVNtHAcYlT0Lcoyd0wyZcDgSUNgVzuh8sw5/0?=
 =?us-ascii?Q?+WLTFUwcMdfVehLj7OAEvpaeux5SjYczRrxybWgcBnO5nPVgNgsYB637XXfm?=
 =?us-ascii?Q?o47njsQGxFy2tNozys5wr6WRTn4vAAmSSsFJDBG6r9+477nTsD3PVG7YAY5G?=
 =?us-ascii?Q?NmZJ66IyRppLqRX1jvBgiMI5Q06ZlMOEZoSkWf9HjlhATSRfP+t8hM2GqywV?=
 =?us-ascii?Q?RDzbx2zlihi88YT5LmqLMMjPuVsvA/jYnHXvUOM8hXsqJVOD408pKqqONX0y?=
 =?us-ascii?Q?rRWKZ3qkJ8zfaqZ0tXw8RYUummgjq0Vw9PX7RKOTgTO4L6gl3lzeBWzs5t+B?=
 =?us-ascii?Q?PXQKD1XAtk4fEYhWtoo17vJ3+uo+h3goU/tVxeedlhGVPwlx2cFUL73W+Qwl?=
 =?us-ascii?Q?XV2gdVhA07PBTvxZxvheKoV9V4hENa+nBwz5J3tGZeiYFCjUfY42+NaqoZaJ?=
 =?us-ascii?Q?MCJRo84/z/6urREHxIYe+7FY1yHFY9cdSCD/2Q5uYCyTgRcyvuR7phhkZ6bZ?=
 =?us-ascii?Q?EcCsfx5WQIkaITpmi1uzkj4JfxZhAZ+KL1P/CTDYsOA+3LlvTg/rfFV71CI7?=
 =?us-ascii?Q?072A/Hu1giReiMc47LvIjiOmRvjQ3ZZpsJiUspuUKgWoHwJA4QJBh5WPlfDS?=
 =?us-ascii?Q?U0xuuKhxqrRFhiW1+KJwrJqRELFfjIr4Xd2CTvHer+YuURcDvziUusqDfXEK?=
 =?us-ascii?Q?riEJEmhUvEas?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9260.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?yIRm4KaFb8ju4r13yDfMImAbM1wMwIvGSnwce1ykqu5SPZrJ9Bw8law6Wf9s?=
 =?us-ascii?Q?LWCqFxxAOTymZmLTVjCrc5LemtvB2mIZ89o2iz8X4Oqrt23umziwYQAQ2mjI?=
 =?us-ascii?Q?YinCONgF9Ll5K4DORpKiZQd8pasOpZLAD/7Ssppdc6QChwJzPnu3mItlvWQy?=
 =?us-ascii?Q?hVtKpe8PpGO4/PT0SWH7roiZ/lDhq4RYyoTjxmToqS/kHWjeOLXiaD9HMXZu?=
 =?us-ascii?Q?n0YLgO0cLHtyC2cO4BQJcXpAI8NIS3PXf/S+NoYrfCiz6CWGvhozPLC9h97Q?=
 =?us-ascii?Q?mdqFaHxmNpwHtEXzG2/z3IvfhtM52HClwrkt5FFhXO6094Mv4IrC0ylhem6K?=
 =?us-ascii?Q?9C1GCx3VVttMA/U6BEa/Gk2GbF/aAj5tS8mV0vl6Ip5RFhl1LxY0jFXeuWOU?=
 =?us-ascii?Q?TXiwijMk/8PVguaxtMPH0L+/nc2JEiHoeTaDYo7kpECv/ZSppPGOnw/QMV+L?=
 =?us-ascii?Q?jhZ/OvB8fqmS0kKu4f0mGUXLyNHOquheTji6a8hNFFj2oW8KNk0/dP6Rtl9v?=
 =?us-ascii?Q?VmKqItYVw0+I+u6qh3IIegRhcBgFKpulYkTSH5okyoufhRarwJktsEqnqNId?=
 =?us-ascii?Q?MsCxW1YWd52/plpOY/xSkD8OgB+HDoZF9qL3i+XZcwGERwKFGsx+JiZ2sJgo?=
 =?us-ascii?Q?mLhrxW5FWNhqouorTpCCS7XPB/GpxN5vk0H2FNiuGuViJvPrH/thedQEjPmY?=
 =?us-ascii?Q?UTeI0DFui7y4U+/CXTeKnQCEL84aYDmNA4Bzxq7wP/AOtKYL16fmQWv62WAo?=
 =?us-ascii?Q?lvVLtqlqXH46wBxf7Q0iIrCXy4LcQwylSnCKXxHeSgK65Id5SZ3iOee8VbXF?=
 =?us-ascii?Q?71LmKscXxUU4MEycEtDSzvC3uSCkx79tvmW79EzRFkvnXVzGIDiZJd2Cm2lf?=
 =?us-ascii?Q?VzQzJBSfzUVAh0VOXWoiSqNd6eIOpkXa25JWw0SOeK72RUx2dcmgvAY1rT2r?=
 =?us-ascii?Q?/vGo4opJzAGdlqS7/1+MMp6gbwkcJCn9ic+N36JJ7v22a3ZcsPrP5J74Dszi?=
 =?us-ascii?Q?xIe/TJFcUh6rx1tE+HuoHzXxC/5qk1riJvJ4KdaWTD6Jv1oVnPsiCStha8x2?=
 =?us-ascii?Q?RlgMNDIla8964cB8M1XuY3+IHlRi2Atug6Oci7k+xgJenlh2eCCo130ZUrnl?=
 =?us-ascii?Q?3zQdZk0BI7/8ylEX30e3Aj+V8B6P2BStYpAi94O+mfGAb9Q8hyMb9Pj8QR3C?=
 =?us-ascii?Q?l/L0zE308wCS1rMNxb637kHgZsNm1Ik/Rf5VdLdqVRkGd6MmJitNBEInSzOO?=
 =?us-ascii?Q?foqApnDNGWbEs+a65XFP78eWZejvwb/cmKWO3QSQpbpdGQh6SjHIFlYogqwM?=
 =?us-ascii?Q?E3OguN5WZfNxfJrabTitjYorwcywNvdhjDz0DEc6cb96UZtlDnFQxG+d5fWJ?=
 =?us-ascii?Q?v/PXdJnWWCGIAJtvslaa6TKpZXCS2hrCQ3FvPF+vKVkzLOSrIW29667IweIS?=
 =?us-ascii?Q?j0v8R7FqVdD8we2OU+mDtB4d4wd/tCuSpvKpJUkoz0SGciryDxAc/PoKXOjB?=
 =?us-ascii?Q?UeDptUZn7TBgKVk4cDHCFsO69o++/1EFQDt19d6/4F/pmfI0QvHcSQ7GsNRk?=
 =?us-ascii?Q?8GjmuC+w4+j7x/Rj59E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9260.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a3c8660-769d-4f0a-2b81-08dcc77ee810
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 16:31:45.2363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lqWJGXFC0+ucjC1uwp0Qcw8y1VNSHLkLDpORaGaprLWie8+NB3kjBMqVlCIKqh7JiEzRsHM2a3O8w6jQ0JdPvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7188

subscribe

