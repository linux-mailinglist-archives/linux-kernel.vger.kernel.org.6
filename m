Return-Path: <linux-kernel+bounces-424307-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6679DB2D4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 07:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A379F163134
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Nov 2024 06:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB5B145A19;
	Thu, 28 Nov 2024 06:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MeuUQIMZ";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="MeuUQIMZ"
Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2051.outbound.protection.outlook.com [40.107.241.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C0281448DF
	for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 06:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.51
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732775996; cv=fail; b=G2Im6MkBq44z8P6eCN77G+T6WYH7v9z6rD2MvPJOoZCJZ3bAEinMwOgvlWVLtKdsD+TXfW+0RII17Esqh1I5LUyQBbVymmnJjf1etuhK/noMgVGbO/F9dBlmNWQKxs7oROKE0lJNda2ShwKRq/cJr4QkX6biaoknOd3xmW+iTJk=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732775996; c=relaxed/simple;
	bh=+aoMCpH356omVntog99tdxpr0Qy2Oe//iOD3wmNq6UE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LmAFMlbi42h4g04ZMVJTQkivZtxmDcqaUp1uEsZuG8AnP23yGQxVkjYxTmoQDjyx4BkIWEpy8XPUiNQRFsSSEPY/Cw64KwIJjBKxbkXFxR0l0eoSl6Rwo6wkcum76R7RvSKGsFK9+IKghkhcva+WsosNUpsFT1C+PSDdCsRE49Q=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MeuUQIMZ; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=MeuUQIMZ; arc=fail smtp.client-ip=40.107.241.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=Q+scb2zgOzJc0O4koXBLR5qsw//7N0WUEA6eUOZH4XmP6MAO/RLC6cJx61rBJGusBq7V1Uju6m9BSurQ5K5NDi0+3Vob3T3h/EXdmCWfyI/SaUf8IHGxcxaDw3LsjLyLBwFPwEzb+ghfgoBf+Hx4lEXYoy9bNHBhfbfkAObz+df9BRqnWsfVhTg02dCecKefE29mklWdm2MXqLlX2BqwLmUzjSOMgLTsSW30yTRFWKAuk8C0QqMyoSUM1+sfnzP6w4KSzICxiVuR0WlwGfGzwsk/KOPIleFogZvk/e9fId2rWBgHQPOnASaVc6pngIzMEkt6oIMmumtPHdfedPdW/Q==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+aoMCpH356omVntog99tdxpr0Qy2Oe//iOD3wmNq6UE=;
 b=t9WdwtmexO2L7JEx5F9Cp5ImOSc6CfX/5brJOcWrpWbv2gSkh5Cn2mzyYa2x+CyKKjbnk8mufDzI9L5V/bcsnmpKevEY/2UkEDsaOzkpYB1QynN2w8xt+PFWsv/bVQU/mpFMOEJnrnPVCxSGSBX4MmDuAgPhy2caMV1LldwZ3JNlXelbXVlZ+kN9wXnHQ1Z+VTHaA/mRSXE8WD3HhmZHkCmuswhyvYwU8G7FpgokJoifPaLMFjz05UWXq2AWNky4KY9qF3EXLDMEwqaIB+Eevlx23thq1ZYKldrkx8+rrjGind9dZReRnswMF7nzDfjGPvDd//aRBA21KRkWzDlW+g==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aoMCpH356omVntog99tdxpr0Qy2Oe//iOD3wmNq6UE=;
 b=MeuUQIMZ16CJQsqbu4hQsycbSVRyxIDeEA3gIB4GYUdb18gA1aDFGu5AZmb7xUWdRjIwWkORLbhMgwqALvHYdWP0MF4hMxPkKwbivlnL3j2iabqNnq49s2keINQ8z+umYbqnZD/Oq+SG2KqxEEe2Oj/4WtI3g19Pey2yP5KrGHk=
Received: from DU7P191CA0028.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::19)
 by FRZPR08MB11098.eurprd08.prod.outlook.com (2603:10a6:d10:13e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Thu, 28 Nov
 2024 06:39:48 +0000
Received: from DB1PEPF00039232.eurprd03.prod.outlook.com
 (2603:10a6:10:54e:cafe::70) by DU7P191CA0028.outlook.office365.com
 (2603:10a6:10:54e::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.13 via Frontend Transport; Thu,
 28 Nov 2024 06:39:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB1PEPF00039232.mail.protection.outlook.com (10.167.8.105) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.12
 via Frontend Transport; Thu, 28 Nov 2024 06:39:47 +0000
Received: ("Tessian outbound 2e0b2b8680ec:v514"); Thu, 28 Nov 2024 06:39:47 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0c8a664c0d5c8a9f
X-TessianGatewayMetadata: nDKixdBfzbXPt2+Dz/zblatzw5zj+6We+y1e7I5vZOj334c9psx2Oum3VZ2hC/+mMbfVZY0nrPIIk1iTkiQIo0J8upEr3wKk1ZLmAqL1vPLg4S0HQ1aE1rfAPDmUK8hvrp7XYejvV+sPWdDTvvBsnIUFxeB7wWFb6IxHXsBuK9KBxwxNpbx9RORngiuSQQTOnSpcsGM9a0ThLUAG/zbfAQ==
X-CR-MTA-TID: 64aa7808
Received: from Ledc7acb6e79e.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 277FAB56-E488-4395-A830-6F64534C8C99.1;
	Thu, 28 Nov 2024 06:39:40 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Ledc7acb6e79e.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Thu, 28 Nov 2024 06:39:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUxd2ffbSk1RcRpoQ6r0kmBPL+Dhuu0dsXUPH09VVWR73wBfGBUQfagYWLrhysg1BXoqom/YXBnUYbYfb64jzmm2G+rRD2EMMp/AP+wOV3d0u/QcenDyzAnj1Yt+GnsUUzsu/zoCeD9F+SJ1KdBQ8yecWgVuffwsTjGm/iLEVFyjKqVH0Z7fHdkKdIw6/1AfbHokyCEOTlCDwu0cucZtQudgA08SjTyToHu5uDYmqZW+xFslT/J7f0fu7fVBvxudJB7qRiDEIdsMRnXt237dv2Cc6T2gRFK6X83K8O6+XjxkIZmrMKZUdFYwS3nniyD+Td/fKvKa987Rge1i3spDew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+aoMCpH356omVntog99tdxpr0Qy2Oe//iOD3wmNq6UE=;
 b=A0YdpnOplac/vnH0ZtOGqWa3mgY/3Ad7GNhLtfHE3MkeGV4f+p6inPbj00w60pqV0AVBqvcyFIaR3eC54erFkL39FCK/l/VmbrYZbfg8+0ozY1fkkoDnX5tZjB2Hio7St622yC/zykY5B64uTRloY3kfMazkde0xfM0FviFjC55VyqvFDZFDG1eVYnWxdz/9Q0ZtyTlJB8UNtKsalktkQUCJMLpLANzd4SRd+adzwnmJm3bopaNOAqkfn0iP7eklGS5dA5fMa3VKHqDSp7B3LHbS9njVlKCpikuyvitfRTT+R25PT0RSSCQE/3YOIXUujHM/dJMOdGXaHtNbQCcT/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+aoMCpH356omVntog99tdxpr0Qy2Oe//iOD3wmNq6UE=;
 b=MeuUQIMZ16CJQsqbu4hQsycbSVRyxIDeEA3gIB4GYUdb18gA1aDFGu5AZmb7xUWdRjIwWkORLbhMgwqALvHYdWP0MF4hMxPkKwbivlnL3j2iabqNnq49s2keINQ8z+umYbqnZD/Oq+SG2KqxEEe2Oj/4WtI3g19Pey2yP5KrGHk=
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by PA6PR08MB10394.eurprd08.prod.outlook.com
 (2603:10a6:102:3c6::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.14; Thu, 28 Nov
 2024 06:39:37 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%4]) with mapi id 15.20.8207.010; Thu, 28 Nov 2024
 06:39:37 +0000
From: Yeo Reum Yun <YeoReum.Yun@arm.com>
To: James Clark <james.clark@linaro.org>, Suzuki Poulose
	<Suzuki.Poulose@arm.com>, "mike.leach@linaro.org" <mike.leach@linaro.org>
CC: "coresight@lists.linaro.org" <coresight@lists.linaro.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-rt-devel@lists.linux.dev"
	<linux-rt-devel@lists.linux.dev>, nd <nd@arm.com>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"bigeasy@linutronix.de" <bigeasy@linutronix.de>, "clrkwllms@kernel.org"
	<clrkwllms@kernel.org>, "rostedt@goodmis.org" <rostedt@goodmis.org>
Subject: Re: [PATCH 2/9] coresight-etm4x: change etmv4_drvdata spinlock type
 to raw_spinlock_t
Thread-Topic: [PATCH 2/9] coresight-etm4x: change etmv4_drvdata spinlock type
 to raw_spinlock_t
Thread-Index: AQHbPx84d5utnNsCpUiY+BlleRX5/bLLVRAAgADqXZ0=
Date: Thu, 28 Nov 2024 06:39:37 +0000
Message-ID:
 <GV1PR08MB105217A184D21CA8FB7C4E6BFFB292@GV1PR08MB10521.eurprd08.prod.outlook.com>
References: <20241125094816.365472-1-yeoreum.yun@arm.com>
 <20241125094816.365472-3-yeoreum.yun@arm.com>
 <ec11e7f4-ed82-44eb-8e72-5a5094b67cda@linaro.org>
In-Reply-To: <ec11e7f4-ed82-44eb-8e72-5a5094b67cda@linaro.org>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic:
	GV1PR08MB10521:EE_|PA6PR08MB10394:EE_|DB1PEPF00039232:EE_|FRZPR08MB11098:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ad1a256-9be3-42c9-226f-08dd0f777402
x-ld-processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
X-Microsoft-Antispam-Message-Info-Original:
 =?iso-8859-1?Q?TyaOWIBDWP5f1X4iP31vTe78XIyhrT/lUJ5oN+qX1w0IIIJenYKP9DL1Cj?=
 =?iso-8859-1?Q?KSB2go9yGSXTa8cKqxaRGJ1RUxBizej+v1PzzuDkkRCBtnAB1JNRyU5lDT?=
 =?iso-8859-1?Q?JXeKYbRLJm8fw3hvvgaUYUqk7E7NaU2qVLLq7cPGtaXLZOPTxvMxAIyvVR?=
 =?iso-8859-1?Q?/7+tWLHfetfCkMPOuoJeRtnoJBHkWCXtd3JWp8pXGKo9X3AyqsY8+9b6WM?=
 =?iso-8859-1?Q?qf0z/feGvCILcJ/rXTyWbS1fY6dNnkuWbfkko9+cnOVrD0BiUyQVtMqrDQ?=
 =?iso-8859-1?Q?mpEX2xqULEEhqToHkDEa43IPrkkzYGfnjZaImPxkmkrfQhZlyReRMhyeg+?=
 =?iso-8859-1?Q?auGan4fKdBOLkhFOmRvjnb7+xyVQNjvtDcMDiHc81jLe2zB+axcfq1HuT3?=
 =?iso-8859-1?Q?/zFSqG7rCTj8Bhvajg+0dZXCDmrpJgFFuWVpUvjmcveYUBfH0VRqyhe9gh?=
 =?iso-8859-1?Q?Azt+2uTYn3bK8AIv1u7Bd5WcZX/nONYdwS/ZBA3nzXuTN7+yydQjY6CcsZ?=
 =?iso-8859-1?Q?VUYxS7Qf8YvXy+Ah4ND+3+QgcEw5HEAIYTfuOqBZC7v5wHWjJMM0E8fkfX?=
 =?iso-8859-1?Q?xWqmE8c6u9B3OtG3DHq3SwRtu93TYMbMCH2fAB4mkcYqgGSTeK56qqB8ic?=
 =?iso-8859-1?Q?79deC3T8LHH4RD+eL0BexsTGhQ3VfDdWEBn0Ke5T1DeddOtLbeX1smQWUx?=
 =?iso-8859-1?Q?ukaSFdRB+JTruRWnxsRmLwgZ+2RCo7kzomPl1rN5uolt3vcGLX5+3Sb/rP?=
 =?iso-8859-1?Q?8NvFQx5qiMItQykZxwzIALElicuDRu7LAA4qBeigsOK+zIwYEs4SsGMJDR?=
 =?iso-8859-1?Q?/gxNiBKl1fMXblxkPnDw97oDxhhlOamoMi2KwXbY693YuJGN3iO084DPV9?=
 =?iso-8859-1?Q?olFYUlLjmgw03tIRZ0kKbRClMvQC+6nmzWgRW3yTjw+5VMcaXUdq8GmXs6?=
 =?iso-8859-1?Q?UUwqM8XflI/4PQ5iAUh0KWzJG24m2ddRUgb0WVXNZ1uNTKffoySV5ySVzO?=
 =?iso-8859-1?Q?8/cX7hmVq0ZCY3JRS3jLVeKvS+2JqtucpnLxeh4nI4PzhsAvPXrxkIUtYn?=
 =?iso-8859-1?Q?It+hZiH1yXGNE1CRcsj+hXpG9gWYGwcRx4yYldsvDLq0T0DMoI6/6B2lD3?=
 =?iso-8859-1?Q?wzWHgAj77PDNJ2RVgLDKsaZKfxMGrIrtQYLLU/DoZBdApIPawp7TCJTDww?=
 =?iso-8859-1?Q?OS0qcH+gcukOaHVkOk3f21Q3AH41XKO+wtvdyYHxo3GlfaKZYbHUpRKL+U?=
 =?iso-8859-1?Q?/7YJAQ2Xxf94WPh4NGE/aJQzlAGcfuRvlnI8HfNXhBBPJnRVcBn+vIVrxz?=
 =?iso-8859-1?Q?dchAAMHGAStj738q+pRyW1Y21KjMT54FXAEG6bFV/0ZpZKPTORf+N4Ceun?=
 =?iso-8859-1?Q?ls6lVwM907H/v1Xf2ynf/VIkXAoYTl481Ymeh07ZiNAtP6BXYTl6iIpQ7o?=
 =?iso-8859-1?Q?1qgzHihtxs7WAflK96UuoTGHvvDC6dXyPdpA5Q=3D=3D?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA6PR08MB10394
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB1PEPF00039232.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	1a37b7eb-48f3-43ad-9a13-08dd0f776e0a
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|35042699022|1800799024|376014|14060799003;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?FTB0bJS+reORNeY3JCbB4uOoVaBTnFAUvRrAHhkopRJ93SbDssc54l8HaW?=
 =?iso-8859-1?Q?sW9gdfU81draYtK/1JWcbe0iIMdFzS0qK6Yb9jtqdvCfHlgP3J/4XfLhOO?=
 =?iso-8859-1?Q?dV2YrBVE6wnITQrPE6hMcs8G2+jBmGlep46/87RcfAOxqsEvRAxGPRSsPk?=
 =?iso-8859-1?Q?l4JCzvA2fnmF8z3ODbg/U0Gb0FeWHZvT+mqFckuj6IUs3wOgK0Iu7tmlQ/?=
 =?iso-8859-1?Q?RrUmlsZytY3gt5U7OlvXHzex6FM7XjjW/YVrrcbbLw7pgqFSUHtPwPcPQq?=
 =?iso-8859-1?Q?jtpyqEZmy/bdpK5oiH5wmsSvZgNeVfW2dbXLZ+gDSNJY7QA83Jco30f48t?=
 =?iso-8859-1?Q?1Xas4Cw4wxmVd1nXIWakCWkT7OU+mU8sw4Pp4rFbubV17FSb5zNAqf5OcL?=
 =?iso-8859-1?Q?svtl0ZEX65yh36GnzvNXE9BReMy71L+mae3KVT52FRrYK6oB92d7UEPJE6?=
 =?iso-8859-1?Q?Nb0vJJtKClxChvGNizbsj245FTCCmvpHTQlJ0IvI0OzAQ0KWv4CBue/Ihk?=
 =?iso-8859-1?Q?NgdpXwpuRUiZxc3k5CpoVLqS05CsSahjS4EbGamUvw+/xM30wxQ9AQ1GIL?=
 =?iso-8859-1?Q?RYMiMckph5H1+zW7GrWLMYhJ6qlPmrRSu3GD60NZqyV9DuS3xm/YZeWN62?=
 =?iso-8859-1?Q?2VeUc1Tsq9nh7dImzx3N4RXcxi9kgcf4Aq7XQd8q6Mr3N/NWN/zZTbqmE4?=
 =?iso-8859-1?Q?MtUNi7rlkOqXLirk1cG4mKzlCbZ9PzWQmf4T0Uxrk7PumV0+AkLAwSs6Pv?=
 =?iso-8859-1?Q?373l6OuF81evKSiDo3Jbm+lGs5GH9j+WMDQsc8kViaMGdNNgtopKvqnpF1?=
 =?iso-8859-1?Q?90sNqJ3qmT4xCVB5pQ5Fd/n1/Ugih37KWKXNH6WRzgvPW5TPTQBh0s29gE?=
 =?iso-8859-1?Q?Kl02F+0hbw5xroui9t9x0gVj1MsSQBUgn+YydWntxZpRxEj50LkzVm9iob?=
 =?iso-8859-1?Q?ckEAEJ+UvJrpCsale9e51T8BTm+jP5+50cTZ7ikgs3hFprBB5e1ImKDwr2?=
 =?iso-8859-1?Q?8leIXBrpHIDMGKq7K3ANSYTU7vJsbeWzX3IBwechr6b5xCWcFBiairrlGf?=
 =?iso-8859-1?Q?8SaUOVXaa6Qa2cSUh8kRjoRCELGw963PUfCRPM0pS7PWxFIZBunAodweRa?=
 =?iso-8859-1?Q?ZAVmeNwCs3Gg/dK1Q7UN+eeupaGnzO4aL1xDtN/J5j23H5g1CzvL8G8XFN?=
 =?iso-8859-1?Q?ho8OEhitEFtodrSq8/0fuJZcxd0tOlylavkM+KqQv/sZdNfgYFUpKNXUXS?=
 =?iso-8859-1?Q?Lc1TKOHpVb2jXeurNypFOTaam8RnSFEv73jTDjOSAXZvE6SH+Pfb25GsRx?=
 =?iso-8859-1?Q?bNKucxruZ57NgcuDMPCGSzq4LCo8hQvH40yHLH7hHq7enI8eYPcsnrY750?=
 =?iso-8859-1?Q?kiI61AhY4mN3FBeAvCD7f908CNFSpJTP69gfbYq8dK8rilFZapdFl5lQ+t?=
 =?iso-8859-1?Q?JAeGztEPZtxMlU6QhEnmhWdzv9Cm6IEcerW8PUsRORFmnEJGQApj/O/yVO?=
 =?iso-8859-1?Q?74ajQiswRi+A17r47eMV3o?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(35042699022)(1800799024)(376014)(14060799003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2024 06:39:47.7987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ad1a256-9be3-42c9-226f-08dd0f777402
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF00039232.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRZPR08MB11098

Hi James,=0A=
=0A=
> There's a lot of churn in this function just to use the new scoped=0A=
> guard, but there was only one lock and unlock anyway. There are a few=0A=
> other cases of this in the whole set.=0A=
>=0A=
> The scoped guards make it easier to write correct code, but I'm not sure=
=0A=
> we gain anything here other than a bigger diff and more to review by=0A=
> changing already working code. Having said that I did review all the=0A=
> changes and I'm pretty sure they're all ok, so I'm on the fence about=0A=
> whether it's worth going back and undoing all of them.=0A=
>=0A=
> Surely updating to raw spinlocks is a search and replace to fix a=0A=
> specific problem, and the scoped guard stuff can be done on a case by=0A=
> case basis when anything is re-written in the future?=0A=
> =0A=
> I don't know if we're considering a fixes tag, if PREEMPT_RT is 6.12?=0A=
> It's probably not necessary but if so we definitely want to minimise the=
=0A=
> change.=0A=
=0A=
At first, thanks to review :) and as you said there's no functional change=
=0A=
except change of locktype.=0A=
=0A=
But I thougt making seperate patchset to change locktype and=0A=
apply scoped_guard to two patchset makes people do duplicate review for=0A=
the same code and almost same posittion.=0A=
=0A=
Since there's no functional change and reviewed,=0A=
I think it doesn't need to seperate..?=0A=
=0A=
Thanks. =0A=
=0A=
=0A=
=0A=

