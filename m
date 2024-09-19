Return-Path: <linux-kernel+bounces-333142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AF397C475
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 08:50:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28B251C238FD
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 06:50:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3464B18EFC3;
	Thu, 19 Sep 2024 06:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="cDsTmW+g"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2062.outbound.protection.outlook.com [40.107.215.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FC618E763;
	Thu, 19 Sep 2024 06:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726728634; cv=fail; b=SpbzUproXYKotVqwzACWA5SdxpEWHvzusmSVoBAPQjO/qTpKN/es7fOdzO+qI7X+Ifwu0vetaBEsXyi5enuCQdwQDfK61UV+cV3pFzZbjKWkV4DcXxd0/vCuXwNVvIoOA7EnEjG36LnH0G5DbJkYOWYJa0zCZG1+UiqUeev7kAQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726728634; c=relaxed/simple;
	bh=SEyHxizpwiaB5I41KTSxZfwYDh9yIDZb80ME1yrv+iI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=SWA0InHAHFrdFoUXkOi53BKqs+l5Q326gm16Hrwjs6GM9iJoGldcja23jY6pUDxiqbW4wbNJkEsJDewOLwhk0g+WkrHKyMvvdbgk7wa3XdCyQELjNILk+7esrRnanUCrkg4TiyQItDoCILFzZr+kZNToMSWGeM62ZW8wkQeUjnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=cDsTmW+g; arc=fail smtp.client-ip=40.107.215.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QPXkKHBWRWBG7Fk+EvqNlB5xo7HXbWOBOx848nyEqbuZJAdqKPKXSs2NfNGaYESvRyIfeI/CAzYW88BRAWPYYUpoeIuhTrNeQELTTf3BYEgZfEVyrib/5P0rQRcLtjA8QrPmsXLfdDu28JDaACs76FcKXnAs1eN+r+B4Bi+Vz+dO8QA39CBBZXCF33IUvYquLxfCofWGu7U4nY2Ei+vDENmQw10ZXuG4+zXhwxB2hKGXs7k1FnZ8MK4oHe7bABaAbFB3FJq6lf9ng/q8bFH/nE67cvOcvx1qyZFZaSsqtyVrGIYhBt+E7AwYx0pRD3uH3Icq5NlX7GO/rAvhGU5yaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhO7ITAlP9s8XX1++jWU4S1wgwRQNr7cQ9Wk/+83/W0=;
 b=K6TYBDx2/r8TTQp18cK/HhP9rQZb6Sua2naPgMjlhjLeLV/sehSjldP0lDZn9GqsQl84F6vb4ub2MA1t5Z7YdjRBJ6lHihpssnMpIa2J6aZ3oINZBEy9HM05QWSgrYZiIkpDPNhYIL6lbmdbJsYKldWRrRiiEhmt7AQ9zYpRDu/pWxLlT7fEFsjeor9WZFJoCV1SUA9DMckHzuNC3iuB7DNFnGAFJma+RYYnKVmgr06syDNWdWV87BvOnW4jVFHhYL2Epnd4+5FcsgeRO/MNIkJ089Ql8IN1lBNLVnlWFo5VHm5rBVrGqYleKc0CkWx1zpwqnGAg6I7ffjHA7qPQHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhO7ITAlP9s8XX1++jWU4S1wgwRQNr7cQ9Wk/+83/W0=;
 b=cDsTmW+gV8pRUt7GmV2jIFiqgHLuJpDDv64LVTtwhnsiYHQfMEbwQpH++bHNUZFHbKEmmEMlPvgqfTDCOPQU9erSziGv2bJuth3+Bf2ZxHEXboKxkm1QSKKBhlFxU3/crbcVPaRWtEMphq+E+xZNhmfZseixoyZpuugHlyES2RMfk9By5Agd1FT2sHE18ZsSF50h6WwkWvk96Us9Z5GmRMNAHNp73YrD1ohg4MzY851jhlkKna+0apJsgqsvgH5vchWdssRk9ukh/6O/ie9EZx98ThBm+RlEH/sJ64mLtwKs+sqa1hMetlzaVWBrXXN8Mcj7mQyWbpC8jc9Ab/bI7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com (2603:1096:101:e3::16)
 by JH0PR06MB6702.apcprd06.prod.outlook.com (2603:1096:990:35::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.23; Thu, 19 Sep
 2024 06:50:23 +0000
Received: from SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce]) by SEZPR06MB5899.apcprd06.prod.outlook.com
 ([fe80::8bfc:f1ee:8923:77ce%3]) with mapi id 15.20.7962.022; Thu, 19 Sep 2024
 06:50:22 +0000
From: Shen Lichuan <shenlichuan@vivo.com>
To: jdelvare@suse.com,
	linux@roeck-us.net
Cc: ythsu0511@gmail.com,
	u.kleine-koenig@pengutronix.de,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com,
	Shen Lichuan <shenlichuan@vivo.com>
Subject: [PATCH v2] hwmon: (pmbus/mpq8785) Convert comma to semicolon
Date: Thu, 19 Sep 2024 14:49:39 +0800
Message-Id: <20240919064939.3282-1-shenlichuan@vivo.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: TYCP301CA0065.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::10) To SEZPR06MB5899.apcprd06.prod.outlook.com
 (2603:1096:101:e3::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEZPR06MB5899:EE_|JH0PR06MB6702:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a8d9790-3b55-4f18-911f-08dcd8775570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?okLWfT6NxKQfFqS/9cGu2vJiwxz/UAwAh9CqTMe8VbW6koxMRdLY1gvK1zgW?=
 =?us-ascii?Q?YGvJGOb+gJSW7R1ImkPF9wvwR39tOtk1BH6S4P7Pk1dpgT7WNjO81phfI0kH?=
 =?us-ascii?Q?rGAvq9of5SGOAdi5LSZqOQjRuK/ZRs/tcJYWz8l0rlYeOovpqVpFa6m8cRNU?=
 =?us-ascii?Q?rlnXKZ05PYBY6DbbOrp/333TsIMAi8J+8QwOLyhnvHZ7/rqF+FysAnotsl2q?=
 =?us-ascii?Q?GUQxh15dOQui66ud74+ZP6eubbyYzHe6fnyfdRbdvia5c1jujGb8hcHJ9di2?=
 =?us-ascii?Q?STJinXDieA2Zmtq6WaJVJT5stlw8lVSyyN9y5Ys+uaUdGXAS/5Ll4DmcF4gp?=
 =?us-ascii?Q?1ztGnxEbWicqCO/6IEECEtFPc3pFVymRKjXU9NbazarLvShrMDA4/o1VKo0n?=
 =?us-ascii?Q?qHwi1UGN7/V7J5vQUv3ZH83/zUd+O9AhopE1fjpKUENMf/hEhYP17GvGiGK0?=
 =?us-ascii?Q?M1703SX0G5xuMq4PoNQ0W+LNTsWA2i+XrLlExGAcgqA00vzfEnDgmjDtj7+p?=
 =?us-ascii?Q?L3ncQhdTqLuplz3hk457HU6BZFmkGzzYURkuN96+VZDi2Bm76dkwafb0n0/l?=
 =?us-ascii?Q?Ee6j++inHmAcEhTphRfAlNYiuGJ08fKqQVC3/lb1LFeQFRPH03G6GPnEtSqo?=
 =?us-ascii?Q?o/OtxaNeIjVq3TFHLp8w51sztP16Sf1Pk8kg/pKftm4EI0qTPJn3HBaO2/rJ?=
 =?us-ascii?Q?sah0QFC7CSdusQ6bHNuflu1nkJjx3eJUbycGjymPp5s3Oz94sjgkqXsDjkoi?=
 =?us-ascii?Q?Fw7gXlDV3ztWUBW1xAaJPzXFQ/tzoR8/AtxWAmkAh17U7pF9W4Ql/pB8rmP3?=
 =?us-ascii?Q?q+fJr5xgbLMF7DtH6bm60cziE4YhpgRjT859CC4LJJl1C4394p+qM+ZLKlKk?=
 =?us-ascii?Q?JcLcyRkwcLqFZAjY1txf+MFt9uTDCXQckonuR6Hr3+x0rWWMIx867/yNz8SM?=
 =?us-ascii?Q?dh3V84V1Dib4ytasfxwBrirzqmp4P8+3G+UlZd5/ctfo/a0FHqkFD8WuWBr7?=
 =?us-ascii?Q?2JdZix+6qdYD8B7Rmap+mL8VV4HUYDx3tqLUqT+bUqwq3oNT85ChkPr9W/gE?=
 =?us-ascii?Q?WoqGnrkXCCTJ/DMVdbtFGNXpppzyQ4S0bwwMLxdWbq49PE80b8wzKX/CiNTf?=
 =?us-ascii?Q?qxB7A7JW7dL44Duck2lfIZBKCYoZSLkrNyLr2kYLKO9y4FD3+G741D8QLJ1Z?=
 =?us-ascii?Q?PG9j0oJ2AFjMYm5R4vYAYtPBhKOy41cBPrlFL+niEAl7P29kKUR3Ch+93Zf0?=
 =?us-ascii?Q?jHaJSfy48vzlIwAFvfGQoQajhjzYVtqcGVhC/g8yrHJB59wkJ2lQ0DpHhxKF?=
 =?us-ascii?Q?OaF61ZpY4LRPgPvdnTt1+0Qx91StqT3nWiWo+fZ61BGERW7iBIMBCUMSDzFI?=
 =?us-ascii?Q?S71qrJYIG/aCZDJo+I/9xjsyXWEjqHbQ0BkodWNjwoTAqRPtQg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEZPR06MB5899.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3PhLzMFzTja7YgixCLNS5Lp5BC+jl4KrjO/0lS4AejirrOcBfsnh668ONIWG?=
 =?us-ascii?Q?e//w6i24YVVcnkQS7h650qEW+KZT14Jye89Z/uX6DK7LGdN0mVdo9fOKDqlf?=
 =?us-ascii?Q?IJj1pw47iUhHLxKxXCWwHOWqEqO6LGsIFOThB9o5cPDKxWAD82xxwBCuW0dB?=
 =?us-ascii?Q?EXmzdgnyZgGcjtPalxHabONLjnGfKsiln/B/+h3pyEqVraBS0XJ0oSVmRrfz?=
 =?us-ascii?Q?tonZFwwjN49MG2aT+VFqQdmUsJowqH/dC1I16w7pjEc3+I4AK0qS4d8Tqd1m?=
 =?us-ascii?Q?4oGZCcF2tv7wHbMH8oMwX6HsJRdGjK5ssp+0wEQbZZSu/ecbtq3L8LH7XXzT?=
 =?us-ascii?Q?fEKG7GPl0dZCl7rRwXrBoTfs3otmadBRTQY/HyBGhV/7NBrsL9F05YTYnBag?=
 =?us-ascii?Q?AwfbpTB3/vEBOcemwUFKF+puHtIDdFiQoXVhEz0UDl4tO3crBykRFfwubv9H?=
 =?us-ascii?Q?3Y7QGSAVtmO80FTBK7zQooy7REYfSv3nbUsxIEEC7jGQGjcrdb3iFGv4OMpB?=
 =?us-ascii?Q?lfO4WjBB6RgJaDzyIyCCE430H8CnSM1duf8aG5oxuu24FqxYj60xuoou9iw8?=
 =?us-ascii?Q?TGoZEQLQoeZiiG7qqusYCBI0JXC1dmJChmvCQo9cHKAMv5ozxi6XDT020V8L?=
 =?us-ascii?Q?Fdc2D/Aqm+hOKrz5aWQ7FZfygueRXTNIxyrJNGwtfTXxVZ7Pl2P46zBe8YYV?=
 =?us-ascii?Q?AqeKOGXlQKchqR34f1Q5EneQo0fm+LFsG4B6SxVtiMewR6zb/NiV3SdV96/9?=
 =?us-ascii?Q?zFbYgxO+/bIpmv50GSgrBioOFyzakWPYKG7hQ/5ZsoAkYf0xrja88UwzfWzJ?=
 =?us-ascii?Q?uzVKz/5qX+5ac5fhGtmbn4KXpT1mr5QDQnOXhUXDKfLaH2vwXMdpO1/vqA2t?=
 =?us-ascii?Q?pR3GCzMDwauR5jzGqMICp8Uat4fFlZzXyAN5Cujj+BoSCw2HC/vdO+G3C+mA?=
 =?us-ascii?Q?GPH7W+sBTd0Uei0i7cjhzBnUge9LWcAs0rsnFfmDw3es4lcdWJvFfKWsYwzp?=
 =?us-ascii?Q?L44SoUgGYxfZ9yrU0h7J+xxWAcRzhiPCJEroqxu+Do5boYi+ki70e0hflCMe?=
 =?us-ascii?Q?EvgbKh5iCxwtMHR9xxWbZjP/LQN1sOo3a5aw7Ve2HYu/fIvzmq3G7ybLcMz1?=
 =?us-ascii?Q?yG8h9i0A2giac8XGB/lTGHEbxoNd9RTdpPmWzEt9jcOTpQ7nMYoiZ6lQmNsc?=
 =?us-ascii?Q?zMh8wYTBM9vtDol9YdcbyhxzEL+9FmdnDki/i5+9gs/QOO/Z89r/iKaFVZ//?=
 =?us-ascii?Q?Lu7ZXOL7Af4HbMMORc6DbQJZqvWwMzjiBRb3BlxQm0F/ibTlhQ7f1ZNNu65Q?=
 =?us-ascii?Q?oVz00rU/Cdyq2FUHk2vGszsoC5RPgjsCzO5o7l4+ZC6/YUUe1+PjasMs6a7E?=
 =?us-ascii?Q?i6KSc+mkXkPSqVFiu6kCnk2JUUZNkxBm2da/FeTxrl1IhbRQfxMrk5Fm6Nqx?=
 =?us-ascii?Q?7lxnKG2xXLf+b+mLQPpE90iKJHvszXE8/MWTkZ/bx3j+9xdcY+l/SJLggimt?=
 =?us-ascii?Q?x+guwZyfSwO1FTJls3TxDoSY98Gcq+q2gp/ggm6KCCxqnuc5MONcj7Ft0x77?=
 =?us-ascii?Q?u3CEgvMKxLyiXsqHvyASz99He6erSingz9v11Wpj?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8d9790-3b55-4f18-911f-08dcd8775570
X-MS-Exchange-CrossTenant-AuthSource: SEZPR06MB5899.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2024 06:50:22.8461
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cNSPdMBccHfTOuvy6RjtxIou6UG8g20qhyOqplJQjHS2OFnehXFRetuYTUde/41cpQrlcNThLtyqR23MgXlGOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB6702

To ensure code clarity and prevent potential errors, use ';' instead of
',' as a statement separator in the function mpq8785_identify.

Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
---
v2: 
* Changed subject prefix to "hwmon: (pmbus/mpq8785)".
* Modified the commit message to describe change more clearly.
v1: https://lore.kernel.org/all/faee3de3-4fd2-4b48-87af-348c8415b84c@roeck-us.net/

 drivers/hwmon/pmbus/mpq8785.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/mpq8785.c b/drivers/hwmon/pmbus/mpq8785.c
index 7f87e117b49d..0d16491cd770 100644
--- a/drivers/hwmon/pmbus/mpq8785.c
+++ b/drivers/hwmon/pmbus/mpq8785.c
@@ -22,7 +22,7 @@ static int mpq8785_identify(struct i2c_client *client,
 		break;
 	case 1:
 	case 2:
-		info->format[PSC_VOLTAGE_OUT] = direct,
+		info->format[PSC_VOLTAGE_OUT] = direct;
 		info->m[PSC_VOLTAGE_OUT] = 64;
 		info->b[PSC_VOLTAGE_OUT] = 0;
 		info->R[PSC_VOLTAGE_OUT] = 1;
-- 
2.17.1


