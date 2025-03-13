Return-Path: <linux-kernel+bounces-559519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47C3BA5F4E9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 13:50:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0ECF7AA630
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Mar 2025 12:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0C402676F2;
	Thu, 13 Mar 2025 12:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="Bz2LeEJB"
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013050.outbound.protection.outlook.com [40.107.162.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07094266590;
	Thu, 13 Mar 2025 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741870237; cv=fail; b=QuuZXogh2mdQ5MIZqVw+vg6r7VAgZllZiRJw9n/nKOdY8gfHbwccHykSEmvZotuIIFtFaMpoPpIYRRv63wsTCjApR4ZGXZzjSqJ5FbKJfILHy8CYDHIxuAfy84dqUjFrIni+umWCM+83u/CjMDifV1wwIW8X11uQfPL2T/+YkWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741870237; c=relaxed/simple;
	bh=+pRKLGjVUV2K7HW4XjBTpZv+k3QPlKDkzB4ysqaZOWE=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ShX7Oh/MTg1/05MTccoQfgszcFBtRkx+SjJiYUxxyNKz0PhkRrS6F+aUnfUTGgxqjx//0ZdCRvjNWRg4Igt6PlI0V2mY88Rx4pkiiYLsXHmNlqjIpYzYnVJpFUOI8hnit4qMXOTQfMJCxYEffDBtDJYasljzs9T0NlW7pVOz9M0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=Bz2LeEJB; arc=fail smtp.client-ip=40.107.162.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N15dEoEqRlMaJ5aOyQJ6QaUX5HEoN1TmHHUD0uwVnTN9wMC1PiF57C952/Vc6AFTIfVsKZ36AUTZoyK+XEz6YmY7zRgs/qiz2LqMt2mBkiP++nPZ84fbMq+/iorwU8yBEt+haDKI+5PR0sVXfRu63YvCmQM1hHrSlivakjo1J4cvdBffunb6HV1+KyOdkRk1NwjIO7WbSlQ01keRltaNUhcpYJbuMKQ6D4j4cC7Ot6ZNryBRQ03AQzOX9h+NBvmH49k3WGdSiC11Cq5o1F9mBHcPtXk/qol/b20Txhsj2toS0WMQzcuW9/p//ca/6PH8700XIdet0he+kJzgqAoQSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W3l6R/stwEv6uTQhkVJHmR6wmEkE3isQ7Y25mnYLogY=;
 b=Ocen8IiO1t/3/K19kNNinSz033ourMEUwHxPFz/5rsDip5+CuWtPEgKoA8j00YRO/MtSPDVxpYmr9uCulhFZUNKZ4taB5UNLmSogJGbOtC+GSjq/8xB2sptVDDT2LFGdTIJm5vDAc78Wzc1byYqXqi6oON8ggM6gXpScg5ecOmrrXZ1+Ve8MGosGAICTjwvZyeeQ8Q45+a3o5ZbHg4jdb7iNMFA47j9nDIYjfl3yAU3TpRE4u8W/wU9aj3552ID3jY4sbNjRkZ9HIybrFoM8bNCqROjw0zYUxUA8Y7bNe+pEq7Bigj6p3iCc40Xzdf0vr4eUg1YD6T+9KIDVmtvYdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W3l6R/stwEv6uTQhkVJHmR6wmEkE3isQ7Y25mnYLogY=;
 b=Bz2LeEJBCDkpoKqZ0/M/SURwYypcBRzx779UF4d2g78fdvuYfpO+FSSW/pajw6mRC0DUAbdlosiAmN06l9UQjBp3OVuXMrijApyvA2JWsvGNxnfqHgVrn18zotyg0NDxXg7MeI6tswNLZzoxKs9M8hSpVPf9Duzmu18mb4MfHoYbFngaCFkkiNRkAyT84cizW3l41FHQvJrOimHP7x4gmcR3uRWJsMexmLZJrYaY5v8CYHjiCvL8kk/X5wWm3mJ7q2t6YQnRtAjpC0UEKhp/PZfra5SmzrnrWA9q0UBWJG0w+uqSgprh9rZlGR6EVIq0EiUhK6T7x1My6spitUojjQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com (2603:10a6:10:5b3::14)
 by GV1PR04MB9056.eurprd04.prod.outlook.com (2603:10a6:150:1f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 13 Mar
 2025 12:50:31 +0000
Received: from DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db]) by DU7PR04MB11163.eurprd04.prod.outlook.com
 ([fe80::3a74:80e4:4144:62db%4]) with mapi id 15.20.8534.027; Thu, 13 Mar 2025
 12:50:30 +0000
From: florin.leotescu@oss.nxp.com
To: Jean Delvare <jdelvare@suse.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Michael Shych <michaelsh@nvidia.com>,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: viorel.suman@nxp.com,
	carlos.song@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev,
	festevam@gmail.com,
	Florin Leotescu <florin.leotescu@nxp.com>
Subject: [PATCH v4 0/3] Add OF support for Microchip emc2305 fan controller
Date: Thu, 13 Mar 2025 14:57:43 +0200
Message-Id: <20250313125746.2901904-1-florin.leotescu@oss.nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AS4PR09CA0005.eurprd09.prod.outlook.com
 (2603:10a6:20b:5e0::11) To DU7PR04MB11163.eurprd04.prod.outlook.com
 (2603:10a6:10:5b3::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU7PR04MB11163:EE_|GV1PR04MB9056:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e61ec8d-2f9f-4fc5-e34a-08dd622da2ed
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?10Pk8s011zWEexFYHldXLJPDhOIzzkKkVLWZQ7+ctTBD2WmCSZWys/mIH7?=
 =?iso-8859-1?Q?XyUGXOi59Lz2IiFwhYW1VddO994q5+n6sEIdxqZ5t6KTf+zRkUuqbhF/Fz?=
 =?iso-8859-1?Q?uAdc5DMBgI9r4ay6tDg7l+ZREtkWYvmoIfl/QiWJVJSDP39qGIvMK46i7d?=
 =?iso-8859-1?Q?l/9ryj4cLp9JcemgmjSJqqrDqgRQd3hi3j+MycQ1qAa9sEHoG7hvnGcb1B?=
 =?iso-8859-1?Q?Fjd2E+O8apMMcU8PRIZ3HjvAl9TwfylTEO9pvVStsXSGkCBaDEknGT4tLp?=
 =?iso-8859-1?Q?HjvavDuRd/hzewUJUByWChcAH9oATu1Z11aQN2Sg+EvqCFJTaOlc8lZWD0?=
 =?iso-8859-1?Q?TIp740De/iF4js9hE9GCPd6kzp0B7iDVXQE/ZwqU2yzeWjuVxA804wKc5d?=
 =?iso-8859-1?Q?KEJEo0JUdukQ/HkfXMfiIaTZ8E0rDhhvia/sPRGgLDq7k8a907XMnQn8QP?=
 =?iso-8859-1?Q?RGw9yjN0R5O9igntQYpzgdEp2Z7XFw9Q6/w9TyPFnI0hz+JuuqmEpiby2N?=
 =?iso-8859-1?Q?ppq7IUGj+RrpHOXEcK+KbPLjjBUqxfeJxU6QSrHGV/laAIW+B6Ki+6/lET?=
 =?iso-8859-1?Q?Yr9a891rgJj932DdLifb6RQJGagd1NDPPwEJtpqfCYAtu+5hOLZBFcySvl?=
 =?iso-8859-1?Q?skz+o6XMDh8yB7psy4Npp+T4WrgKHwbtuwPSkE87t2BdrUJShjADlQJU8M?=
 =?iso-8859-1?Q?8y4rdBIG12vFypSmHMzqtKfsfTOBn3h7xBttJtWmfbXTcgQmb9XrV9AYbj?=
 =?iso-8859-1?Q?QAHJm3ooS9rN9xhrT8LbQcMtOO/0w+bEt3amRUtsHzaU8f6OQ1WsEPJ4Ex?=
 =?iso-8859-1?Q?oTVjXWAEeFsNlAr8JztDqOS2MiOd47LH5vtqmUmgvNF+9U4cROF8DoxX/R?=
 =?iso-8859-1?Q?vGmNXvXXGun6fCOr3hlZc31NDmjBVKGIsNntdvEDbDc2sBEGzOvNHkb/GN?=
 =?iso-8859-1?Q?kTNa6ZKnF1Diegy0u4fMVrXcnq/D7KcCYXOntISwkCIbvYOxnRyIv1e3Zj?=
 =?iso-8859-1?Q?ql3F1vuQJ6Z00tERXJuTnwYDo2X9NEequWCQKRfpkRzrAbVRecqbhvKkHQ?=
 =?iso-8859-1?Q?CNq8xpxqUKW2pQZDAystkWbI0g6C/eQ8i+lLcjKzGobnvgz5hsGipLhjpi?=
 =?iso-8859-1?Q?7tmauQlXEggg37/n+y7cQSLrOTNXHAoJgjIgV5Ufp61+mjpx2xYIK7E84N?=
 =?iso-8859-1?Q?bGUCkZuVOcUZ/V3E2zeWLgSzZCEAaiJPiN5g0AaC423M8Yxiyogn5+a2Cb?=
 =?iso-8859-1?Q?EJfYfYScmHe1d2q7JHXkTQlXRBg11uQ6beNMXOAb4burSTL3zxkkmYuaZD?=
 =?iso-8859-1?Q?GqXOlsmIBgtJU5K2VJiRWrq+Ot5Z1dyPvnC6bUoUnqjNv4APKY4tBxVO9+?=
 =?iso-8859-1?Q?Art6HtAnKm+gSbLSYqkyNcAkxZBBKLeA8jozWFX3xTKyM7zDsnuYl4lo9S?=
 =?iso-8859-1?Q?VmxSstZ9q1b+t4SO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU7PR04MB11163.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?d1bdqR2QUya7WoYj8aCTX1HG6J684CPCvrFUeE82khSMa291KxZ9RnJM3z?=
 =?iso-8859-1?Q?WVch2M9AE02ZrPtbwJ3URZ/2MjOgTqFgjcZ9qrf0uc59eBTDzdq5cadGAh?=
 =?iso-8859-1?Q?q5+AwCwmbqM/FmrlqENptYjBJgKQIbTBqY/dRSmuhjeAoipX8AS79srYL/?=
 =?iso-8859-1?Q?Htri913DxVwOn42o3S9hxsGnZ/qasHMQfKiHGUrrea7jtkxbCbV3G0K6dn?=
 =?iso-8859-1?Q?JvLXjheEYQZCUzInYTM9KE30OB0UiVsnKifGKQ0wTz9cZxnVRIYThLySfy?=
 =?iso-8859-1?Q?E0rm6EhGLQQ+vVzjZSE50lRa7t8Or0WxM+55hAJTLgqqlIbltlPQDLj0N7?=
 =?iso-8859-1?Q?aX0UqZ4sqTXwte9HgFLVGPua/7U2feeunyXCLFCMrkVHxHCrdNsP2mEB+U?=
 =?iso-8859-1?Q?oHNJw4aBiPNlp4A958i9s/atnhu1WtPhcGWukTI+UEGSHkOdRX5OeRwxvt?=
 =?iso-8859-1?Q?wU8DR59/6yA2rf+QPse4udyB40YTc7D5ZVqEHC9FsamZP0u3tiFOmlAMV/?=
 =?iso-8859-1?Q?XcMEQS5AXaYZXJlI/Jf2uNrI2iAb3yRI9LT68wp6xJ/OUkbBdaL6IxRbCQ?=
 =?iso-8859-1?Q?mh+ciMdSE+tBga9v/eNRNjEOMoTENBGjA4taukyIkojLJ6APTL+SXQ2TPO?=
 =?iso-8859-1?Q?Y+glLDYC4a9hgBew1H3sIVoum+BUAD9hc1m9pzmooUw/rZd72fh/bJJ2J1?=
 =?iso-8859-1?Q?558hJhFUaho/5rLzmdEEZSXf5gmQF09qox+O9Hj9oaPdMbUQP/ImbMeuuh?=
 =?iso-8859-1?Q?kRJN60WpUWLTZOB0VGVNNxodKj98cFrKRrHeWGl8Sh4OWi8kwaWTVs2DqO?=
 =?iso-8859-1?Q?mQ9WtwkaJeH7aXgHEqfgqD66oM1toMMDW31oxR9AQapULoA3ROlvg8M1Nq?=
 =?iso-8859-1?Q?FkGGNkmC4gT5Uc6l2bMfj8C+Os0bWAnc3wuo9GDLqKMNXgdQ4Qb4pZytto?=
 =?iso-8859-1?Q?3FQhwHOR9oYOWxQvq8ePdnN80B8nQRxgV03gI/DEzUC3zKZ0ukBYb49jHZ?=
 =?iso-8859-1?Q?sHfHXs+deiPvBS+70vxMWmBwONmlhs2WRuyz5XEgIg/qHT1TDghUo7YDpF?=
 =?iso-8859-1?Q?SAvv5xAneFbHaMt1vLk8GyI/G2IPjBeE4zAK/S+pPRFOFe/365JqjYdA+k?=
 =?iso-8859-1?Q?IizPaYEl/hJRWWgP4/pZf6T22uYna05rYCpYvfStoxRvjWQZK/TDoX+HC1?=
 =?iso-8859-1?Q?2vLZXXvQIw7ZBKfQ7Hw4twGA5d7u7ziMrQetTlbbNzxLLCMU11BEo8MN1h?=
 =?iso-8859-1?Q?I/7hXUd8gyOd6XKPK5fw35kDHZdyZXzPhm30jL9/N0fuXthib31j/Yeb+p?=
 =?iso-8859-1?Q?zsKb5w32T1osz8z5F9RylNA0MQ8EpYqG+C2oguuwcqILk11ZxJZkQW3qzJ?=
 =?iso-8859-1?Q?uWRHUxRzHClqvLBvOq1R+B0cAbuJSgPlYVgz036j2g0o+c4nZb4jzSvOPO?=
 =?iso-8859-1?Q?122oaB17IQ4WI52BoXEzh/6e2XVEGQYD72M39w/w18FrXAk2qLoWMo2uO/?=
 =?iso-8859-1?Q?bqpzUszqe1OOHlAi0QmaxMBedO3LDLH0t+kkVeWuKkqUNrjwtZpgUu90nr?=
 =?iso-8859-1?Q?AueWOBlHL/mRC2lwebryNYuj8mngqu0GjLE6rJwh5RLCgOkvbaSVnsNkKB?=
 =?iso-8859-1?Q?IwHIbOqGqt2KhQqFUNOZKyR4/RjJ8SMR+S?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e61ec8d-2f9f-4fc5-e34a-08dd622da2ed
X-MS-Exchange-CrossTenant-AuthSource: DU7PR04MB11163.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 12:50:30.7343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NIZ7o1a3SowXFuzLcCS6nhIOQLA5NWZvLMqCia8k3L7RG89aN2v3lIi39Ah6rYyUZwIBhmtO8NZVhzfbmW9GTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9056

From: Florin Leotescu <florin.leotescu@nxp.com>

This patch series add initial OF support for Microchip emc2305 fan controller.

Changes since v3:
- Removed thermal_cooling_device_register_fail label since is no longer needed
  and replaced goto with imediate return, as recommended by Guenter Roeck. 
- Redefined compatible property in dt-binding, as recommended by Frank Li.
- Updated driver of compatible list.
- Renamed node name in the dt-binding example, as recommended by Connor Dooley.
- Corrected dt-binding commit subject.
- Added dt-binding fan descriptions and $ref to fan schema, 
  as Connor Dooley & Krzysztof Kozlowski recommended.
  Used similar as on maxim,max6639 and nuvoton,nct7363. 
- Updated dt-binding example.

Changes since v2:
- Removed the introduction of new properties for now and we only 
  enable basic OF support.
- Link to previous version: 
  https://lore.kernel.org/linux-arm-kernel/20250219133221.2641041-3-florin.leotescu@oss.nxp.com/T/

Florin Leotescu (3):
  dt-bindings: hwmon: Add Microchip emc2305 support
  hwmon: emc2305: Add OF support
  hwmon: emc2305: Use devm_thermal_of_cooling_device_register

 .../bindings/hwmon/microchip,emc2305.yaml     | 104 ++++++++++++++++++
 drivers/hwmon/emc2305.c                       |  38 ++-----
 2 files changed, 114 insertions(+), 28 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/microchip,emc2305.yaml

-- 
2.34.1


