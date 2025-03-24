Return-Path: <linux-kernel+bounces-574282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 03E0DA6E303
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 20:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 769847A72E2
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 19:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E57F261370;
	Mon, 24 Mar 2025 19:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jZOdBGuR";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="jZOdBGuR"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C541288DA
	for <linux-kernel@vger.kernel.org>; Mon, 24 Mar 2025 19:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742842986; cv=fail; b=HA729gLRSrfwkpxVBXdWtTh+ZGmzfITne5o8lgciN1noEEqDWGA24Ytm1jqq123dnSHIT4wCnMh1x8JZK+aZj7dLazh9DXosT1VMh9AgnsqDO0N8k+dyq7REwLxdHtWXw77+zreUH85H9kFmLFmZTrH0RwqLcoiiRKbDOGpP6Rs=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742842986; c=relaxed/simple;
	bh=UuA93O1wFWzDRvVSFUPdyr6P0LGsNqnUWwZktM+ArmQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Yb58VBS324D7RCSA2OKfhVAuqQyraj2wQFERTJK1bigAE28w3UiwTBxT0x3tIyOlmAQKLB2Lpv11VxlOV5V04FHVARteushK95+xIdyPvepiP0OZH7OMjipqyDoHd6xdENM40CpkGrlNVJWJqBrpoa7hhet62KhNKkQ9blM5TTM=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jZOdBGuR; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=jZOdBGuR; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=QYa+o5oWS17sDotszovj88FCgRgidrbZiUBRJIAzd7RZTv19tpm8joTdwhrLXBzEd56TVH3EJKOUVmJmrOZBEDvg+VFciJjc6PaUO66eNSlumJYDPHzDo+dtRLQFRUs2JqYZ7GQYuW64s6CuEGaSlCfhU8q1WvuXEVuVZ4T2WYdEwd/9GDZND5Lfb5GEYkqXEBN78y0oQ8VZ5cPrsLMrL/zVW9W6uadoi17j4twx+If3wkpyvYh1AtwzBjCcbh1rXZrlWJcNU9ZZ8ftkMCoOA7JfStJxZ7eirth3RWTQafcjotyfXapxUNV1rH+kh9g3C8gAfUzGpW0xJ+fnfVZCBg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Plh3OngN9TixK2+nQUI9d1cKcpcLRw3mqZVf/pnjUPE=;
 b=sOt5QjetLDnzFOwyeWg3HwOLYDaFeriGrMev3OvcNAFhfa8T0OEl8EufgqHMz3CGmsBFZLj6ZqfFaAkJQO1udqNgHhc5CioP4ESbZDaPsuClN0T87dRt9SNId3ooQFRGXI6RMoMFBAmSWMOrhY6QSkF/IwCpsDem+O+NemBP3o8yCMKU19wQPhlnd2Nzu3+FheruTq1XGshxaabqocx5VztCSvSUApWzKyTL/MYsZcMYQd+jvw95hD0qY1IWivre+ftZGZOiXvwEbxxr4uUFJuvw/1CT+tYp7KPKLNjuVi7fPxDIbTjlT3iRJLKa5tTBhRGtUAQEfoZyXk97QC4lsw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Plh3OngN9TixK2+nQUI9d1cKcpcLRw3mqZVf/pnjUPE=;
 b=jZOdBGuRxJ6AXQRpObqVGrj1SXV0rKbz29ttOGggdqnpGX2pOU0IRrSy1VrJtE6Gr4/w5KwTINroY1MMjHuPtBryBJByE26icyAcfAcVVAgXhbWAWb7xqMIqMxGiB7fkxw9oabh9nWTRWN1yOhu0ezdZMAxPB3yQUu7hZ6D5nWU=
Received: from DB8PR03CA0006.eurprd03.prod.outlook.com (2603:10a6:10:be::19)
 by DB3PR08MB9060.eurprd08.prod.outlook.com (2603:10a6:10:433::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 19:02:55 +0000
Received: from DU2PEPF0001E9C6.eurprd03.prod.outlook.com
 (2603:10a6:10:be:cafe::3a) by DB8PR03CA0006.outlook.office365.com
 (2603:10a6:10:be::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.42 via Frontend Transport; Mon,
 24 Mar 2025 19:02:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU2PEPF0001E9C6.mail.protection.outlook.com (10.167.8.75) with Microsoft SMTP
 Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.20 via
 Frontend Transport; Mon, 24 Mar 2025 19:02:55 +0000
Received: ("Tessian outbound c43b5f5e5ae0:v601"); Mon, 24 Mar 2025 19:02:55 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 9d04d07ac7a9b0a6
X-TessianGatewayMetadata: qAeUkTHhOoCXGWGTcA7i/XfT1eX2ylx252KiLicV0JEshJK2obj4mh4Ienv2NnwpdtYVdJ6Rt5DdCB4TcbcoLyGE3xnUf3dkOpomUJgrqynAoKlMvRPT3+JqW867CeKeXfM6pjMcO2atm0oPEepl0Q==
X-CR-MTA-TID: 64aa7808
Received: from Leb1d72267412.2
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id F8C2AB0B-D168-4585-87C6-06145D6C7924.1;
	Mon, 24 Mar 2025 19:02:49 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id Leb1d72267412.2
    (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
    Mon, 24 Mar 2025 19:02:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uX45vN2ByiIg31rcmxb8Aj0ixOpAvZqjpQETKhuexa07cmLhKP2WlmF2Hxl5gp4QU+U8rVUe0O9jUDsw7Oi8A4NJJ3yhdas7WEzC1mNPZPhw5rQgAarfqEOYU8dEfIBipgvMR4WfaGUrIJiQrge2o/PjqaVOKUEYkFay9o79mhr/6v/iJmaxdzojRnWsjNFVVUuMyZgU7bSElKbqPIk6Rq61u9YwRyAN8ShZ4asv7QAdYnFnDuV7zGcYr6dmhQ3vnNbqN8VaMee7I+28yKEKH9Heh49MOAzldgUeztkQ+UjWBcMRImealdNs9HesHMKSVTLDPM85qjS/E597lelrPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Plh3OngN9TixK2+nQUI9d1cKcpcLRw3mqZVf/pnjUPE=;
 b=kJX9yHo08fl90WU7q9NsekVF0iI2n5KbUttRTNycXQAVXi0+q6xMmjOYX4arVOdAg3gPJvQBgIsS8wM2falwLbpO0i17Xl9VY5+6VyZ25gPCE/7D9ozx7JdADtv5dhwcK7iXrnwvwBLm2hBYRy6DD1iprlhtExm/woyEoqdROxgscjZpfj2T+gJazoXwQSMOGyc14MOnGNZSgY4hyyfbKpR5GytZ2oGqUy3Fm2ULqo1SrTGClyilp7OZHWpyp8pz18vmPnHLgw8T0Hy4BRstm7WcahbpBIvzqeAPtXdGGNfABCv/Ho/8YR+/VpQegMOiLJGnjgYyAgen0EAwesDMuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Plh3OngN9TixK2+nQUI9d1cKcpcLRw3mqZVf/pnjUPE=;
 b=jZOdBGuRxJ6AXQRpObqVGrj1SXV0rKbz29ttOGggdqnpGX2pOU0IRrSy1VrJtE6Gr4/w5KwTINroY1MMjHuPtBryBJByE26icyAcfAcVVAgXhbWAWb7xqMIqMxGiB7fkxw9oabh9nWTRWN1yOhu0ezdZMAxPB3yQUu7hZ6D5nWU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20) by AM8PR08MB6611.eurprd08.prod.outlook.com
 (2603:10a6:20b:36b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 19:02:46 +0000
Received: from GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739]) by GV1PR08MB10521.eurprd08.prod.outlook.com
 ([fe80::d430:4ef9:b30b:c739%6]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 19:02:46 +0000
Date: Mon, 24 Mar 2025 19:02:43 +0000
From: Yeoreum Yun <yeoreum.yun@arm.com>
To: Mike Leach <mike.leach@linaro.org>
Cc: Suzuki Poulose <Suzuki.Poulose@arm.com>,
	"james.clark@linaro.org" <james.clark@linaro.org>,
	"alexander.shishkin@linux.intel.com" <alexander.shishkin@linux.intel.com>,
	"coresight@lists.linaro.org" <coresight@lists.linaro.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/1] coresight: prevent deactivate active config while
 enabling the config
Message-ID: <Z+GsU2Elmq14UU81@e129823.arm.com>
References: <20250109171956.3535294-1-yeoreum.yun@arm.com>
 <CAJ9a7ViuVntYL62q=WYPkFR3++cyufPdKUHm0FUAPyGy76pB_A@mail.gmail.com>
 <GV1PR08MB10521BB7C93822F5124F2D66EFBD22@GV1PR08MB10521.eurprd08.prod.outlook.com>
 <CAJ9a7Vgz+L+UYf8Yqyu9J5hp3AB3WPSKutA4AvR-OFdu8b-dPA@mail.gmail.com>
 <Z+FlLDLV9WkGNbj+@e129823.arm.com>
 <CAJ9a7VgsBZ6MkgwVjDiOm7rvcy9KVPfPc_PbaRNX7ra8NWGb9Q@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJ9a7VgsBZ6MkgwVjDiOm7rvcy9KVPfPc_PbaRNX7ra8NWGb9Q@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0289.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::6) To GV1PR08MB10521.eurprd08.prod.outlook.com
 (2603:10a6:150:163::20)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	GV1PR08MB10521:EE_|AM8PR08MB6611:EE_|DU2PEPF0001E9C6:EE_|DB3PR08MB9060:EE_
X-MS-Office365-Filtering-Correlation-Id: ec331e39-863f-4d4f-11f0-08dd6b067c67
X-LD-Processed: f34e5979-57d9-4aaa-ad4d-b122a662184d,ExtAddr
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info-Original:
 =?us-ascii?Q?Et9hfRvJFudaszFz0gxPu6vylYCuaRlkSTdsD4amLcbzLSoKL0EGluqJIziZ?=
 =?us-ascii?Q?lu5ViXx5R+JzR4DsbYO7OZxKs6BweYtK9cLUbDRI84FDhxG9jeef1JdYSEWX?=
 =?us-ascii?Q?/ZNOgrHMenLmlWb47r4M8IJDVtp4C4KZP2AhHIcspD7yIQJvEgZnf5k617N/?=
 =?us-ascii?Q?t356Tf/HV32ewM2V0GDEpilYmwjzMx9/JsvAKPaStBPvo0RpQaSHRu4A2Lkx?=
 =?us-ascii?Q?bgm46ivxun8qXueOgTj9rXqZA86lR4pDP1irkT1CERTQWvE8gb836acLlLPu?=
 =?us-ascii?Q?kl8m4HIli9AOxWd3HrThClZnIXf/AnrsyMqOPPpJ+alyCrEqbI3t3QTf94No?=
 =?us-ascii?Q?OUEPxpskdoQ5WhOR0VhLPpYrgN6irl2PBR+dr5irPlby4h4sFdiNCfnz4WSB?=
 =?us-ascii?Q?CRMP4sDYut6KUNdZ7FYcuXS1gk/XXkKC6/BV0ciWdpMxPV5H5YQqxM+eBdNI?=
 =?us-ascii?Q?GUx127KpnlOc0zEErWtWeCqWufIpFleGvsFb/1UNCxvDVML9P0dpWTULNHj0?=
 =?us-ascii?Q?Cl1ynnbs8oI2fM9Ay8xsUh6P17SZfee8aVo/nmAIJK8/2NFiumAOqce48VFG?=
 =?us-ascii?Q?nTBe22Q/CVUVV59SDbd81TXl019SB+qxSOf5SWPKjkAOfhJk3gHDJXUqX16I?=
 =?us-ascii?Q?WNyVuhiGrENpOPxbViWnOqyZZK8r7JvaK2w/O9obIP6zXXMy5dGEsHfDNNjO?=
 =?us-ascii?Q?18+jKTCf9S4LEq9O3RTmGf1K+M1IAz8UL29NPsY2kEMuN00GYR7Jfoj+FPsL?=
 =?us-ascii?Q?JBRkvGxOCtO9EUb/ciQuGzM8MWUTmQ685HysgCq0ML40e/Tk95uAmZFliIRR?=
 =?us-ascii?Q?LOzgewl5YTDhFxPGJvH+0YkI/KMvFg4HcjsR6X73qyqZx370Sz6ZJiwH7dA4?=
 =?us-ascii?Q?zoOEbSD47Hc2VdP2TKCnLm3ji7lAxoH6+h7JxdycQDoPD/OiX2KFmM2VLHQ6?=
 =?us-ascii?Q?zM2gJaHnICIZfJz0j+BvHOI42ayHpq7X04Ts4/Eqle17n4lDIdfD40EMmmnS?=
 =?us-ascii?Q?BWkuka6hnZxF8kRe0E056OUh0BzE91UD1tSKjGq3TOv9d/CogGfgF3Y+aLGD?=
 =?us-ascii?Q?lq0XqPegIbfHOtXFQxxhJlhlOyCSKWE2s6vhSFw6vkmlftTHFTzo42wSKk9m?=
 =?us-ascii?Q?IvJneErk8OoxGtMDQUgIo5M7PB8j3pjlPzLOdL671LrrAr5gNC+8HDwegjSY?=
 =?us-ascii?Q?1387kAA2AM3C6A0hB8k7n+nvPcxvMD0csmO/djHVIAe9uTGfvxjsjCM870+s?=
 =?us-ascii?Q?1wdtLIXhC7XYffi09fl2A6U9wE4VP2lEca+PvZRyMma547maYBA2OVnSS2eO?=
 =?us-ascii?Q?vU+badpJiiii4QCJX3z6m1+dXHvaYu7ellzwIhkoH4PdUpOJRhh2cgIjr5X1?=
 =?us-ascii?Q?JamVfKL6Cfnc0Xact8ReWwZkMUrP?=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:GV1PR08MB10521.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR08MB6611
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-SkipListedInternetSender:
 ip=[2603:10a6:150:163::20];domain=GV1PR08MB10521.eurprd08.prod.outlook.com
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 DU2PEPF0001E9C6.eurprd03.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	b19cacb3-68a3-40e5-ba61-08dd6b067673
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|35042699022|14060799003|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+7j03r/ZUcqsX4KVmMLy70wQvykaM1953OaQBI+PJ68uuHDqzc6SRjaDDzTg?=
 =?us-ascii?Q?pIHFtbBYiQfJ7BBooD7ZoD6T7Has+/gLEK4MVlP2ivvwyWko+mLwnK1R8INo?=
 =?us-ascii?Q?bi+vAxjve9vFYXdyI3P589KfEy5+mROsRWje4p6/KHptfJmalbqwt/fBqYiv?=
 =?us-ascii?Q?9KADET0xT+sjSrwuutrgHBSHa/3U2OzaBO6ryKGaofLnOo7tRtgljEmZFMtm?=
 =?us-ascii?Q?GLyrAR3d1X9P+JZHSW0rb/kVayIFQ8y0X//qqAnb009/m06FcxtZDam6fTXo?=
 =?us-ascii?Q?hvQHOBRN14MsPMundfu/lghsAOem4CbSFtnTlI/aod5YOZ2ZKxUWXEUaQ7iH?=
 =?us-ascii?Q?UD31+3KODcrQiWvQdP+0UOunGzL3FHrRAmFGl26MzV0iOMcaOYeAS5uEFMxh?=
 =?us-ascii?Q?Y0RNLN4xlhv+gY0NtCzxF7DovaS/i6DQqs145JdRVJvbYfG1rJesOJ2+YNjt?=
 =?us-ascii?Q?4x8S4YgkwRr3KwsXbC33tFoENPuwH8b3NQECno+5kCjyGOBE6hZocvX2UoF2?=
 =?us-ascii?Q?5gu4kDppLlrYn4rjcyNhk7VTH+MeSqrE0OoXBSMeg8UqLEIDyFAbZUo+RoVY?=
 =?us-ascii?Q?DERqtbriA5JHX6d3YlkeKC+/Ue9i75MBe1Umv7S5V9ZDadZkvRUcOHNqttD0?=
 =?us-ascii?Q?7jrqRaUSg5axu0tIVhFPAVbg3k3ul33b7xvZRzlxt0ZgEb9Iwj4qwys8XdBg?=
 =?us-ascii?Q?jgKiOUuECWJRZckrMebhXyuwuFsc2z9IXb7O+o9mzLQ5WgGmrAZk9Gv5gZM8?=
 =?us-ascii?Q?/dR4QTkTqoNmBLSsfcF0dIfv9MeLqIL3qV8FiHV3lyp6MHld94nXGvhfucE7?=
 =?us-ascii?Q?f7/+0P/9j1ktxktwPpF0IXU0Aeg56oYbBi9e0B09He7QQgQK4qERzWPu75lG?=
 =?us-ascii?Q?KOdlkdeafYGjEr/ksEqBeytLhGEEnZOsCEthyhVltEhlrsH70Mia29F2GdhU?=
 =?us-ascii?Q?CVw25Z12UCCShX0+zywUqjWo/S1eM50y6cx37q/Mubx4lwvnyjljNtIJAklT?=
 =?us-ascii?Q?igCzrSUatcQ1xh5+QLz1sk0GlCqWc5Y8QAEEpFr/brfzWalBWdyTHWJH1vkp?=
 =?us-ascii?Q?xP+6RuW3xggcL4MZ3o/gy5XhG2waogmMt6memlyq7agTKZhkCoiuVMZ54f30?=
 =?us-ascii?Q?VdKUB95DQIDFMPjFJGRvCforcIJ98NX5X4RLYkXM2jo+ZURveoGl8KWbsTJh?=
 =?us-ascii?Q?6ignYSXy5qiuT71ZbySOsxh0L+vT1fgHtbYAqBn2zHal2wm2gOO/3r9YZqWj?=
 =?us-ascii?Q?awWEvpvbwHyT2ex5SuAHE8WAmK4nEWKBe5Uapq9kPBSKeSxkHZQVYIYIMNBt?=
 =?us-ascii?Q?88WvZwLf7GXns0eLQa6bv8BAomGPAfR5wLTwLRRLy5WyAZPu3hvGoJit0p/2?=
 =?us-ascii?Q?pUhbyQBKMBeFZvDcObv0Wi2YXmZSUzTXLWscTntGfOt4hN9eps3hlj6Aaic/?=
 =?us-ascii?Q?1PsJgt8IP7tbORjTXMPiSC0yMt3Wt7sG0frovQRjXip4Un78wdVrETjEooiE?=
 =?us-ascii?Q?Pw49xrtLYtFTETc=3D?=
X-Forefront-Antispam-Report:
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:64aa7808-outbound-1.mta.getcheckrecipient.com;CAT:NONE;SFS:(13230040)(35042699022)(14060799003)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 19:02:55.7271
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec331e39-863f-4d4f-11f0-08dd6b067c67
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C6.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR08MB9060

Hi Mike,

> Hi,
>
> On Mon, 24 Mar 2025 at 13:59, Yeoreum Yun <yeoreum.yun@arm.com> wrote:
> >
> > Hi Mike,
> >
> > Please ignore my foremer mail.. and please see my comments for your
> > suggestion.
> >
> > > Hi
> > >
> > > On Fri, 14 Mar 2025 at 15:25, Yeo Reum Yun <YeoReum.Yun@arm.com> wrote:
> > > >
> > > > Hi, Mike.
> > > >
> > > > > >  static void cscfg_remove_owned_csdev_features(struct coresight_device *csdev, void *load_owner)
> > > > > > @@ -867,6 +870,28 @@ void cscfg_csdev_reset_feats(struct coresight_device *csdev)
> > > > > >  }
> > > > > >  EXPORT_SYMBOL_GPL(cscfg_csdev_reset_feats);
> > > > > >
> > > > > > +static bool cscfg_config_desc_get(struct cscfg_config_desc *config_desc, bool enable)
> > > > > > +{
> > > > > > +       if (enable)
> > > > > > +               return atomic_inc_not_zero(&config_desc->active_cnt);
> > > > > > +
> > > > >
> > > > > Not sure why we have an "enable" parameter here - it completely
> > > > > changes the meaning of the function - with no comment at the start.
> > > >
> > > > Sorry. But what I intended is to distinguish
> > > >     - activation of config
> > > >     - enable of activated config.
> > > > Because, current coresight doesn't grab the module reference on enable of activate config,
> > > > But It grabs that reference only in activation.
> > > > That's why I used to "enable" parameter to distinguish this
> > > > while I integrate with module_owner count.
> > > >
> > > > > >         list_for_each_entry(config_desc, &cscfg_mgr->config_desc_list, item) {
> > > > > >                 if ((unsigned long)config_desc->event_ea->var == cfg_hash) {
> > > > > > -                       atomic_dec(&config_desc->active_cnt);
> > > > > >                         atomic_dec(&cscfg_mgr->sys_active_cnt);
> > > > > > -                       cscfg_owner_put(config_desc->load_owner);
> > > > > > +                       cscfg_config_desc_put(config_desc);
> > > > > >                         dev_dbg(cscfg_device(), "Deactivate config %s.\n", config_desc->name);
> > > > > >                         break;
> > > > > >                 }
> > > > > > @@ -1047,7 +1066,7 @@ int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
> > > > > >                                      unsigned long cfg_hash, int preset)
> > > > > >  {
> > > > > >         struct cscfg_config_csdev *config_csdev_active = NULL, *config_csdev_item;
> > > > > > -       const struct cscfg_config_desc *config_desc;
> > > > > > +       struct cscfg_config_desc *config_desc;
> > > > > >         unsigned long flags;
> > > > > >         int err = 0;
> > > > > >
> > > > > > @@ -1062,8 +1081,8 @@ int cscfg_csdev_enable_active_config(struct coresight_device *csdev,
> > > > > >         raw_spin_lock_irqsave(&csdev->cscfg_csdev_lock, flags);
> > > > > >         list_for_each_entry(config_csdev_item, &csdev->config_csdev_list, node) {
> > > > > >                 config_desc = config_csdev_item->config_desc;
> > > > > > -               if ((atomic_read(&config_desc->active_cnt)) &&
> > > > > > -                   ((unsigned long)config_desc->event_ea->var == cfg_hash)) {
> > > > > > +               if (((unsigned long)config_desc->event_ea->var == cfg_hash) &&
> > > > > > +                               cscfg_config_desc_get(config_desc, true)) {
> > > > > >
> > > > > This obfuscates the logic of the comparisons without good reason. With
> > > > > the true parameter, the function does no "get" operation but just
> > > > > replicates the logic being replaced - checking the active_cnt is
> > > > > non-zero.
> > > > >
> > > > > Restore this to the original logic to make it readable again
> > > >
> > > > It's not a replicates of comparsion logic, but if true,
> > >
> > > sorry - missed that point .
> > >
> > > > It get the reference of active_cnt but not get module reference.
> > > > The fundemental fault in the UAF becase of just "atomic_read()"
> > > > so, it should hold reference in here.
> > > >
> > > > So, If you think the cscfg_config_desc_get()'s parameter makes obfuscation,
> > > > I think there're two way to modfiy.
> > > >
> > > >     1. cscfg_config_desc_get()/put() always grab/drop the module count.
> > > >     2. remove cscfg_config_desc_get()/put() but just use atomic_XXX(&active_cnt) only
> > > >         with cscfg_owner_get()/put()
> > > >
> > > > Any thougt?
> > > >
> > > > Thanks!
> > > >
> > > >
> > >
> > > The get and put functions are asymmetrical w.r.t. owner.
> > >
> > > The put will put owner if active count decrements to 0,
> > > The get if not on enable path will put owner unconditionally.
> > >
> > > This means that the caller has to work out the correct input conditions.
> > >
> > > Might be better if:-
> > >
> > > get_desc()
> > > {
> > >     if (! desc->refcnt) {
> > >        if (!get_owner())
> > >            return false;
> > >    }
> > >    desc->refcnt++;
> > >     return true;
> > > }
> >
> > I think This makes another problem when
> > it races with _cscfg_deactivate_config().
> >
> > CPU0                                          CPU1
> > (sysfs enable)                                load module
> >                                               cscfg_load_config_sets()
> >                                               activate config. // sysfs
> >                                               (sys_active_cnt == 1)
> >
> >                                               // sysfs
> >                                               _cscfg_deactivate_config()
> >                                               (sys_active_cnt == 0)
> >                                               (config->active_cnt = 0)
> > ...
> > cscfg_csdev_enable_active_config()
> >   lock(csdev->cscfg_csdev_lock)
> >   // here get module reference??
> >   // even sys_active_cnt == 0 and
> >   // config->active_cnt == 1.
> >   get_desc()
> >   unlock(csdev->cscfg_csdev_lock)
> >
> >
> >   // access to config_desc which freed
> >   // while unloading module.
> >   cfs_csdev_enable_config
> >
> >
> > Because, the desc->refcnt meaning of zero is different from the context.
> >    - while activate . it should get module reference if zero.
> >    - while enable active configuration, if zero, it should be failed.
> >
> > that means to prevent this race, the core key point is:
> >    when config->active_cnt == 0, it should be failed in cscfg_csdev_enable_active_config()
> >
>
> This is not a failure case, it simple means that this config should
> not be activated for this device.
> It is possible for a configuration to be active on the system, without
> it being active for a particular coresight device.
>
> Having a get/put interface for the config descriptor - which prevents
> the config from being unloaded is fine, the key logic here is that we
> are searching a list of possible enabled configurations for this
> device and taking the necessary action to enable it if we find one -
> and there can only ever be a single configuration enabled for a trace
> session.
>
> Therefore when the list of loaded configs for a device is > 1, then
> all but one is allowed to be active - so the search code will validly
> find instances where config->active_cnt == 0.
>
> My objection to the original interface was not the get/put operations
> to protect the module from unload, but the fact that the logic
> deciding if a config needed to be enabled on the device was hidden
> inside the get() operation.
> My suggestion is to restore the logic that decides if there is a
> config to enable on the device be clear in the enable function itself,
> then use get/put as appropriate to prevent module unload.
>

Make sense. Then I'll respin with the suggestion :)
Thanks for clarification!


