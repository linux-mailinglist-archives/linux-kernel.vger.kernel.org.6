Return-Path: <linux-kernel+bounces-380138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A47D09AE96C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 16:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C81321C21EB2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 14:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58F5F1E379B;
	Thu, 24 Oct 2024 14:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZWEgli3y";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ZWEgli3y"
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2059.outbound.protection.outlook.com [40.107.103.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2518614E
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.59
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729781714; cv=fail; b=Hy+yd+BbBspA5bt4LLxv6oqezR6m5KjVU9cQisV06xaRq1f/QHGP+LrN4pcqFjyi5f53PwLG8dWdc2V99yTSq+1EZ2DY2nbV26ZEfyHTnReVx9XMNW7AUvU/0AL7y3cRKgzYAm5TIvN9VaRut+NwGB1oemtZWsM4jxOnmvdre3E=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729781714; c=relaxed/simple;
	bh=AgI5GlYjGhfdwF9MfPFfoHc9ku48F1Z5Eb6BTN9P3S8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=HPSK2Fxa73WOsM4P/Wf2uJU63swkbzIXSQk1nzSo9ZavFZTC5fS0tlhuyy6lFMKsrhBzU4lbhO3MksuTASVCVyYodnjzm8nCB8ui+5pIKFaVSAvcrJ1tiP93/FxYKWwsAsu/GRH71WTJjkzZo8PcNP+u2ryHXHCOTQTcNyDhcZs=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZWEgli3y; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ZWEgli3y; arc=fail smtp.client-ip=40.107.103.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=M/0I0ifukcplvTWg4xUDC+hyGfhwGHCycoEFM4omFlkk47R2IOSStbGhdSF9praYx/CCc7SbWYK8QChM76Wnb16pX0x/UHbQ3aAV+OwPIbCP35h9seg9XAar8vkcz+0y9OVB+PDW5QDoy2OEyGY9suzVUuBMov7FqlDpTMC0EhQYIH2eO4h279OxTXs2XJmucjgu/XDSxHhrTDsMxSdZfcQUWTO5B6rRAIqVJwZww7H7YNo3sVfhSv48j9NNbFj9P2LlTztWYChumOzyAteF9p22dQwFLTnRX+sjioGPJgT2KeKvQ1Ucp4UsZmybQnlbsf04uma+YtNMTCUPKs8yug==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6ZeSwAQSamrB2cR294FVChtktsrCelRH9urLxMHwVU=;
 b=yQ/2+7VgC98MUM+uR8psC0PP8nLWcITnSzeQBlL8L4mj/+qik3bICaQCLp6raAfO1IHU3HPD9bNWXYp4gnqyGfEf3F3oqX4B8FyWWn/dArWHwtVda/hBGGShM1cqZp2On9QIHpxENbPr7N4rxf78iHjefiCiSwRpjuudeKqRHBodsJgQbxrL46pwbyROWit/Gs8r7zIZCMY93BC4thfxo+rGS1SShD70qZrt2HNy+tcpg5n/J4cJeaqICqFs7V20sdM6hLAXEHZSTLbOjaWRv1El7Rot01CSc7BevOO8vQIeOFw837zXm51ReaAgIKO4P87+kDYfHCVNgGO3+J3ptw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6ZeSwAQSamrB2cR294FVChtktsrCelRH9urLxMHwVU=;
 b=ZWEgli3y3d6OCRN1PTdBqEKXOiS1hA3/3WaD6phwhSidRIFHRsnT6NWu4YG0jdQvKZuADBce7Lz79KWLsvoT7abdRAYZ522im6CJqw2O5aG7XdIt3rK+cWbvSw0bGY9YVvRMvNmT0yVK8SudjhpDr+nUUv1Med8GRqyyy+5aPoQ=
Received: from DU2PR04CA0213.eurprd04.prod.outlook.com (2603:10a6:10:2b1::8)
 by PAWPR08MB9031.eurprd08.prod.outlook.com (2603:10a6:102:343::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.16; Thu, 24 Oct
 2024 14:55:05 +0000
Received: from DB5PEPF00014B9F.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::8f) by DU2PR04CA0213.outlook.office365.com
 (2603:10a6:10:2b1::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.29 via Frontend
 Transport; Thu, 24 Oct 2024 14:55:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5PEPF00014B9F.mail.protection.outlook.com (10.167.8.169) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8093.14
 via Frontend Transport; Thu, 24 Oct 2024 14:55:04 +0000
Received: ("Tessian outbound 99870d44e01c:v490"); Thu, 24 Oct 2024 14:55:04 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 45a0a018f56e3c6d
X-TessianGatewayMetadata: 5xcGNrjZyIrsIvYsheUjfctmuVkcjhbzp0TiZl0YQDJfoCLiE5km++5aWrwFm5OJcnk0wLbQobtkG/pCbIt3LtYXaoxofmf9wSTJ+is4K4d+slPJ/D81JuK7Xk6daoub1+yLtrIAIeStr2OxKO0cwtULpqnd4BUWm8lrhOkFFKQ=
X-CR-MTA-TID: 64aa7808
Received: from L4633a9386ab5.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 9B6C49F9-6694-4ED0-B99F-EB95789D90FC.1;
	Thu, 24 Oct 2024 14:54:57 +0000
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id L4633a9386ab5.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 24 Oct 2024 14:54:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pRBWXBIF9coQp+uZPu0NGIKa/VYfZni9husuOgqh+4ORQLB9HSo5+CyBFhkGzwOAh522LT5msJ7YSv/ILXz1ZrHpYJuSH+lgmtG9FA+NnT792wwrKgqXRjOMd3KSq+xKyixDw0grDKFZ+u+HEONaYjkPtbUqotxJxeDcQKMMi5y3mtSQO/JcTgHqtOHnIP4omVO387NSalP4VgR03r4a2c+NbKb4DFFYTFvGQte8DkcCqaIfMIVAcir07ANsZGcP/E4xnzKRqlIn9uv3qa6sLaIQ0DUuQhUlbn6wzeGbMyUOV2o3FDDOKwXOl6Q5OzZEzcTttF8TQ/4FbZze4mWirA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N6ZeSwAQSamrB2cR294FVChtktsrCelRH9urLxMHwVU=;
 b=ZSBcl7RhzCQ4eX1LZ4CQlbxD6cS1mEfevXrMnk6HFW/pnmp8PONSApB+tla8RXxuM/WbqrYfUV1nK2uq+GWe4aYPD0QBSxfHkWu1EL/1tYNuxmlAunP+Jf4XBIQwGRpE76qC76ViEBHar9YefsmN88q7wkSQfvjOdPFyNO3g3IIL40X3byiOPtKAyi1mwpn6B6ceCUFkiM7LniROY/AAzWnKc3WuvLvt8q8UgaVAiP9xPJB/CZ3fPeul5i8Vnb4d4f8/mpoRb5CYAZiEvh0yn18o9hQezihgH0SDNIOfnp4LWoSdf2zgm/Y65OyIqtqat+ozeK3AJv9Prd4Go3vdLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N6ZeSwAQSamrB2cR294FVChtktsrCelRH9urLxMHwVU=;
 b=ZWEgli3y3d6OCRN1PTdBqEKXOiS1hA3/3WaD6phwhSidRIFHRsnT6NWu4YG0jdQvKZuADBce7Lz79KWLsvoT7abdRAYZ522im6CJqw2O5aG7XdIt3rK+cWbvSw0bGY9YVvRMvNmT0yVK8SudjhpDr+nUUv1Med8GRqyyy+5aPoQ=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from AM9PR08MB6982.eurprd08.prod.outlook.com (2603:10a6:20b:415::16)
 by PAVPR08MB9650.eurprd08.prod.outlook.com (2603:10a6:102:31a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.18; Thu, 24 Oct
 2024 14:54:55 +0000
Received: from AM9PR08MB6982.eurprd08.prod.outlook.com
 ([fe80::5d5d:a4a7:198c:fbdd]) by AM9PR08MB6982.eurprd08.prod.outlook.com
 ([fe80::5d5d:a4a7:198c:fbdd%3]) with mapi id 15.20.8069.016; Thu, 24 Oct 2024
 14:54:55 +0000
From: Akash Goel <akash.goel@arm.com>
To: boris.brezillon@collabora.com,
	liviu.dudau@arm.com,
	steven.price@arm.com
Cc: dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	mihail.atanassov@arm.com,
	ketil.johnsen@arm.com,
	florent.tomasin@arm.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	nd@arm.com,
	Akash Goel <akash.goel@arm.com>
Subject: [PATCH 0/3] drm/panthor: Coherency related fixes
Date: Thu, 24 Oct 2024 15:54:29 +0100
Message-Id: <20241024145432.934086-1-akash.goel@arm.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0271.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::7) To AM9PR08MB6982.eurprd08.prod.outlook.com
 (2603:10a6:20b:415::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	AM9PR08MB6982:EE_|PAVPR08MB9650:EE_|DB5PEPF00014B9F:EE_|PAWPR08MB9031:EE_
X-MS-Office365-Filtering-Correlation-Id: 0553c01f-c21d-4d1e-6dbc-08dcf43bd833
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?FRwrQb3hEfsBvKe+jpQttu4i/NDDbnvk/6SO/dOd/vKYagZDwo9uLSr1SywA?=
 =?us-ascii?Q?v/PM/XpXAo6ehKr+LqpgxwMHsV8FJJ0YVYKTsq35R9wBY8k6cmghcyQ+eZvs?=
 =?us-ascii?Q?0GnlJ8bL+6nuUz9eGIRdR0jz2fdpAJJ8fDwWUw/varpbGz/9J8Yar5i2tHw9?=
 =?us-ascii?Q?rozqj8lTNZ8mKWoAH3mJlBoKOLFwLMExwKpVUeuFBt22o7fVzpra9sH2TgAw?=
 =?us-ascii?Q?wY4MJ1rx/Bau6Is3Th61loXUmnI6x1AMgzjJRLkA0VEAAdx136r9anAB4i2V?=
 =?us-ascii?Q?iX2d8RlAHxHpNXpc8LX+FivZSo5fbxJFFjVVxFIn0v1nl+vaVaO+6SR0zoFi?=
 =?us-ascii?Q?GEwf3HCJ0LjrpoOWEM5Tk9vpEtT/8qcwBqmVqWT+725/BP9+HpNClDEot5KH?=
 =?us-ascii?Q?Ojlq/JNlalBZ/BUPBwq8k6bMucsiTuXbKp/EmE8Bzo183KeGYEVrLTB2l66S?=
 =?us-ascii?Q?ii7oAaDs32IToX0swBVbKQ+/vxFw86xSaSwXc6u34E0DXQfCagymqT0Cc94G?=
 =?us-ascii?Q?PhJEQnerOJ5ydfxaG0emQkrBtt8n07uCT3g5BFqOBwcDdkXKNWKfaDpXAITx?=
 =?us-ascii?Q?h6XcMe/OO/KzzoO1iz3NYi1kWv4gRhdpF8KCTvxT8fa6ijewK+lgBWeqeI2o?=
 =?us-ascii?Q?qhi5ilQ0jPg68qK0E96iGDy71bG/6yz9IeiLY+TcsB/NUf3gH7Y1Kxf0Cyps?=
 =?us-ascii?Q?TXf0neWB18qfZEUy9Fz6/6q5j+i7Z4W4MTpQRpA2FdIGiEnh9rujIzoIeG0w?=
 =?us-ascii?Q?r5Im/lXVbhZT6M+URDRdGBwyzK+AH8bs24TiL3amd8jvk+8j26d6L+DwndKg?=
 =?us-ascii?Q?lo8MiARcKEniQOy20YgkF8OPsCoJpVZ5ASzfuQE5YDJyEU4XtQwM/IQ56+8w?=
 =?us-ascii?Q?XmwF9yA0t4Ce6NQcpeybH70aFfl8w7c+av8UTB+X9iQ7a6zEXaToCSFzYnfY?=
 =?us-ascii?Q?xjXWejl+AIGj3QeVtXdhDDYbtLeeZA61EGyQU0kAHBvi+RQprFK3gRlVIrEc?=
 =?us-ascii?Q?QD+nJboC8p0FbBLeoei+Er5zMl3ezzJYm4Xq+zEXWOM5RzIile5MAW08KEhu?=
 =?us-ascii?Q?t5DfJpM+pKnWTfKoZK48D16724HS5B4DR0MdBYMJ0Vy552cHwfyulpuYJxxB?=
 =?us-ascii?Q?Kg4txCcTh95EixkrTjBPaWuEOmeqgJh5K5hp7KRjssL3noVTBJOhRJxVb3S0?=
 =?us-ascii?Q?0nLKX27DgZRT4LNOjb0BCOc7hOqXAvRjTsoKUTLyz4G4dsxBPgTXP3PnwQI2?=
 =?us-ascii?Q?HnvwM+HUM04SQW59zq7xnzcTxfe+jMC3+d/tVpIsDX3PzgpU9Q2pIaLfHz73?=
 =?us-ascii?Q?J1LjQUTtKbK1j3hg9svzAgIT?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR08MB6982.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR08MB9650
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:20b:415::16];domain=AM9PR08MB6982.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DB5PEPF00014B9F.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	3bc5e371-ed0f-47eb-b4b0-08dcf43bd252
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|35042699022|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?T5eqaW6LLIVKncmGYBeli1UmSGIvLOzoa4oZiNdkHbcAhNh7XZZOMBvrWlWh?=
 =?us-ascii?Q?pJ2chrogVnC9f0diIiLcxjCVuOSunzPdtqzLmwHYERCl3U0Q9rrHrMG3VEKL?=
 =?us-ascii?Q?SddfsTU5eZIb8OF8BKUBJcpbOWMPYgPjCDBvCRmMynaHIY0uLDStbu6EZSKd?=
 =?us-ascii?Q?c3iHR3KgGGwZWsq1Zbhtm1ueWF3cyCYlQKnI6Ep2iJsnmt2fdxCyYF5Qg0ln?=
 =?us-ascii?Q?V9ThR6gYX7MKhBV10ywujJJpVosoyw96nALdZhpJHZ+z7FeTwY0cVelqS9jM?=
 =?us-ascii?Q?j3Kdul0GU3al7VRaDlYigG/EFK797kXa9em1b+ARZ6X7q7QMpcPaEndtEVZ9?=
 =?us-ascii?Q?q2HYowj7vVhStUSUR944QkpZ9NWKyec2OfuQsZzPzWis/XVApfLL8uoHIcTX?=
 =?us-ascii?Q?7RVKKn6SFPVTom3lSd6fpzUu0TkJOco9ECoNzeRlTjdyDo+5D2fbgD58LmLR?=
 =?us-ascii?Q?Cnsi6PkeeZArnrn8/LOfhJorQOM6Kw6ACiwtDlHk6wxGqxvLJKOV3m2xEUql?=
 =?us-ascii?Q?KfQEwu82jH4hnlmvLe7+02OkUtcPlaRHckdBZAM4PappfRuEfIFjeFB3wmlr?=
 =?us-ascii?Q?nA9BV5kvbN89REx8NT5/DEqtjmGtBxH8lmYJeOsSEHxCG9m2VQUYw1uLKG9z?=
 =?us-ascii?Q?tn9m5Jh1UVqAWoDBviesLUN6eljkqPNln6F9PDjyfMicRhEkcHDwhJKw5pbs?=
 =?us-ascii?Q?JcJk++Wxfful5VRMMQdiL2SxeA7k63htqtwVEe4VYKd+PDkTjf499ouzi486?=
 =?us-ascii?Q?BbNfmrUngQETyrB0bGGjXiGAYCV07zNAyoS9MCLhfIa+kSzuq+LG+21fZV+6?=
 =?us-ascii?Q?D95FhJxRD65vkczUQudJZ8LTwK3cpznRUwoTHRsWIJCPU1XPh16AQ0ad7o4J?=
 =?us-ascii?Q?+8fIcytLYGEwS1n4ekDCH7LftBu49e6eTWewMG00wg72R+GUpx8wgX7UtCeK?=
 =?us-ascii?Q?3R020BVyoy9JEr3SeM2r4UjTCsg5hvN6J7Wh6erPlLxGKc7ZUoh9dGdlhQ/E?=
 =?us-ascii?Q?N6lhaMEGAQrSvVIkPGGJzwgNKw0C7eyZMNVgI9TXbHzSPOkK4ZFtp2WMAf1+?=
 =?us-ascii?Q?q5xvPnvHhjcpW3NQOYbJTMXJ6z672ihyFFEXJzJx8fQe5WKwQdUYahtexiXC?=
 =?us-ascii?Q?htjYzR8bc/CAXAS3khJEqvtJbZNq8znFlwL5gGY/W67l17gfW2TAAl8HYvVL?=
 =?us-ascii?Q?FTdre/oVVe6iLiEfA2IRpImM1eQl/QcymxG6D1xJMv36J6Jr76pZUM1Nc6Nk?=
 =?us-ascii?Q?EkwfzXDtAsucyaJI151UFqZ+h6sozMzF/M0PgXhtt2T2D8XCWOrTd3Uf1b49?=
 =?us-ascii?Q?+xebyfS+xPHArpsmnVORrgQheMVt7T7/uPHX1gznfER1yJN3hbJaI7/L3bz4?=
 =?us-ascii?Q?dN+RwxPSuAZT9iyvsS6dgyRx0Pj9Ek2gawM4kpQSrcTFgZUKBA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230040)(376014)(35042699022)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2024 14:55:04.7264
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0553c01f-c21d-4d1e-6dbc-08dcf43bd833
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB9031

This patch series contains 3 cache coherency related fixes for the
Panthor driver.
- The first fix, regarding the Inner-shareability, is mandatory to
  ensure things work on all platforms (including Juno FPGA) when
  no_coherency protocol is selected.
- The second fix regarding the coherency feature/enable register is
  required to avoid potential misalignment on certain platforms.
- The third fix, regarding the potential overwrite of buffer objects,
  has been prepared speculatively & it may not be required in practice.
  Please provide feedback on it.

Akash Goel (3):
  drm/panthor: Update memattr programing to align with GPU spec
  drm/panthor: Explicitly set the coherency mode
  drm/panthor: Prevent potential overwrite of buffer objects

 drivers/gpu/drm/panthor/panthor_device.c | 22 ++++++++++++++++++-
 drivers/gpu/drm/panthor/panthor_gem.h    | 10 +++++++++
 drivers/gpu/drm/panthor/panthor_gpu.c    |  9 ++++++++
 drivers/gpu/drm/panthor/panthor_mmu.c    | 28 +++++++++++++++++-------
 4 files changed, 60 insertions(+), 9 deletions(-)

-- 
2.25.1


