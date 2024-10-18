Return-Path: <linux-kernel+bounces-371394-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFB1B9A3A81
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 11:52:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E20291C20BFC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Oct 2024 09:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E6820102B;
	Fri, 18 Oct 2024 09:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="thqzPscw"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2080.outbound.protection.outlook.com [40.107.21.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D6F20100A;
	Fri, 18 Oct 2024 09:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729245158; cv=fail; b=fJIqEKHwbtPpgHGS077KO9AU6HDe6WQ5Gl/bD9cNTA6+WYD9Yh/PFrseqMbOB42/2zxuhmqf1zKtwhanAF8gP97hrXWs3jmqsGLTdON24NxVDxgeHms/t6In7m4hKy6a7elmrXDT+pmPy4SuyqWs40+TrNvKecs5pGRYmRn4Shw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729245158; c=relaxed/simple;
	bh=WYkMqcmzSQqssu3iTqvUC9FUZ6QanVNIu6veJiyDpHk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sBp2CBsQ3Mb2Gp3bJZLXwdyQj6XoCQKQsiexNhq9xandUV/19xAiheBF5RGP3jr53AnKn0o2gQjjEIDSmbErnCWUQAdEI7/a4B/spj4CCHkFUn8Npv4xoan/Fgv3/mTVNUFo5iPiiZap01OaFEBuGWduHtElGZ1YE7Yoc0fimNs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=thqzPscw; arc=fail smtp.client-ip=40.107.21.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=io5TKuDedAetOXwvKm0oAH/oLTSa5acKAqGG4RRyGRJDnL0d0SIa78IVN+mtB+T1DWWm9ZTVJHltWaYfGX0jBK2v7Yp3oVoXcBFnSvewUsg9+3KcaGy0nPVNjb873bWk4iiThw5V6gyxVfgTggLV52uwUtFwFkmrlUH3Hsxu/KpFNE8aVtIazfpwNDHM67GEW8V2YeTZJhKETZe41413WphexNANor6PNzwQIe2Ij3PlehlchPyiHWkRSsY6jCUih6UMchQqkrjBvFgn+5PHMzrzGsAT7QbGZnjPS1tLWWg+53TNBRo439+TGZoAWdpg3S0z62S1u8HbVtaecy57XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n45sX0jlW0hUXc+CXKLrG3U7xIQumx5jCDpKYVho75s=;
 b=reZI6rubg7cBePb7xzp7TEn7/qjDhZKlDHKnW6e3Bjp2DM5GRnB6LWjCFLDlELLN8fJjO2jpJNzqsqRB0uk/JzC+gzeQsNk1z7hlb6IjAiWKyjTh5J6aWf8vg8I6AswTc0NZmJCNyQaRz0zpylPHMGubkILUakddYNjrN0XCR1u06BTaVi4cL/7WKRh5MLTPjPUre6MEVRa5Kdm0GEwgKDPzHVwQagW9Nej7ibVmn7Kt0cSm/d3urDzmvW2PRkmHqPv+PBooHY1EVI9VQTawv4PF3OGOrymOQd3xqNWHAhYlIpqjHFAArF3pigfr9sm1EVW42tkkN7i5wFTqV+BIXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n45sX0jlW0hUXc+CXKLrG3U7xIQumx5jCDpKYVho75s=;
 b=thqzPscwV1B4Fh3hW7IfSIlgO+Z4WF2uOJxX+kK5B2AcFQTnWP1QKMk0IM6RZXGP+eU6vNaNaz6csJmYBjvuorHRwVrKnOPGWPCc/LM1x7M844R+hQ30GMyCq+/yXq6RNUBxt+jNY4OuvtMZ0tzXCsSkTEw7F43yF5TtKl9sdyjS6lD/QcZ8EDQCWMb/McISQKc9fhiYFYphDrsAaqEHTZHT5zXrew+MQ2AzwBkn9uy+4ItzVvnj0lO5X9zfIb8P2AHjSdonkEMQeY+wV82CJKhkgymV/Nuf7O51F8F00kR80C1On0xBrauj05ajS5QWjH5a9A/W1CSXbWCSPXTPMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by DBAPR04MB7285.eurprd04.prod.outlook.com (2603:10a6:10:1ac::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.20; Fri, 18 Oct
 2024 09:52:32 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%6]) with mapi id 15.20.8069.016; Fri, 18 Oct 2024
 09:52:32 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Date: Fri, 18 Oct 2024 18:00:55 +0800
Subject: [PATCH v2 1/4] clk: imx: lpcg-scu: SW workaround for errata
 (e10858)
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241018-imx-clk-v1-v2-1-92c0b66ca970@nxp.com>
References: <20241018-imx-clk-v1-v2-0-92c0b66ca970@nxp.com>
In-Reply-To: <20241018-imx-clk-v1-v2-0-92c0b66ca970@nxp.com>
To: Abel Vesa <abelvesa@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Aisheng Dong <aisheng.dong@nxp.com>
Cc: linux-clk@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729245675; l=3168;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=5lV6Fnymwi08mNJOqfNiqBqacUaEGvCOefJyeSXwdDg=;
 b=zldSwAASvzZPp+4QoKIdmyOjLYUE2CgIaCB5H/e+itCHrvZX2WNvv45/rbzX3una65nJkJhP7
 SxJMK9swp/RDf3AB1+IxJRCpmiDz0ARmD8gDN1bRNKXlEpkflEubfU7
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SI2PR01CA0028.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::21) To PAXPR04MB8459.eurprd04.prod.outlook.com
 (2603:10a6:102:1da::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8459:EE_|DBAPR04MB7285:EE_
X-MS-Office365-Filtering-Correlation-Id: d05c2861-10d0-4168-dd45-08dcef5a961c
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|7416014|376014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czZ0Qm1sWkFtWi9nalpkM3JYRUdkWmttLzNxUGg1MzY2TTNRYm9oMzQ2ai8x?=
 =?utf-8?B?ZE5sY0E4dE9RZmowSHJVcnM2UHhNQlhqcGFkZGtCNlQrM2E1WTdnWmVmSXly?=
 =?utf-8?B?VlczNGJWcTlvUTc3cUwxN0l6bVpvYzg4a3ZTWmkwM2k4bHlPZ2pvQW02N2xS?=
 =?utf-8?B?SWtzTVpEMndEVGducTl5MnQ0K3pFUnozUk5NOW9WaGZ5dWQzbFUwVi9xVVFq?=
 =?utf-8?B?WTVNem5HQ3p6SUlGVmtIMDV0RFRtNzVlaGxlb2hMV3JvVXBib1hhRXhRL1Fa?=
 =?utf-8?B?SlRHK0tPZndtcG04MGNRNk1nQlo3UHJkRmtlODExUG1TZFhHa2JYVDlRMUNR?=
 =?utf-8?B?WTZFKzlydXkxRC8zMk83cjdSaVJnNEpuR3cvRkVYaU9VWkdVY0FrQ0IwT0lx?=
 =?utf-8?B?Qy81bTVYOEczb09reTg3ZElVQVBsMzZLOHJ2RDZ6cFdJdkNDdXlmNkJVQkJ6?=
 =?utf-8?B?SnpvQ1gvQ2xGUWlHT0JWN0VNcWUvT25GcVUwUDZ4L1pSRHZhSkFlMkpvVnF2?=
 =?utf-8?B?cWdqMEVOdkM5VGluOG9vRXBhSWdSeGo3TTZwTVBmMnl5RG9GMGFPSEFEcW1O?=
 =?utf-8?B?MXJlc2I5eGJqV1JmVW5SYzRNZ09RNnVCM0lpQmRFMVJ4ZXdTRmZUWndNN0xH?=
 =?utf-8?B?UnNaaEo5azBHRmtGRHl6cjBxTTBJNm5yNWpKNFJJWTFnV2ljYjdZWjlRNWZT?=
 =?utf-8?B?TXZHeEErb2w4TUN3ZE5PcUUrakk3YjBURVVtWCtXN3J2cTlJUmpUa2labElr?=
 =?utf-8?B?QzNHN0R5ay9Ga0RtY2FxNHR6eUVLUEdmTGwzUXF3WFJzOTQrZU5xSzNFYjNF?=
 =?utf-8?B?Q0JyRDYrd29SbEZLY3FJV3VFT3BJQUQ2TU9yVzIwQ3lnaWFZeXgxZ0Q2SE5l?=
 =?utf-8?B?Q05NT0VGOGdiS1AwWjkyTVhtMjNoUWdUVnFwdzN6bUo4KzF0bXRqNnoxZW1u?=
 =?utf-8?B?NWUxOFJ4YXdGVDkrTEpUUHNpbktTdUFnWnJvOUxTMjBiZW53NHlTQkg5aXJ2?=
 =?utf-8?B?aENjSkRFMURkVmdrbHlpcDlySjl0RzhoL0MyRHlGOEt4MC9EZEt6ajdEY2Zi?=
 =?utf-8?B?NXlMK3JUYzUvM3ZZMkJzTXV0bEZiK20yZlM5YU5UVGlTZGZLckdBTzJGK0pZ?=
 =?utf-8?B?cEl2VUZYYVI5UUpqQ0xjTkIzMmlLWm9BSW1FUUFBdzllV2pod0dzaEk2WC9j?=
 =?utf-8?B?ZCs2T2FiNndEUFZmR1BmUnNndzVCS2tqMkpXLzFTejZFTTZ1UmJwd3piVjVs?=
 =?utf-8?B?OXNFZU5UR0MzYnRsbGY4SVhnUTB6MXQ5SGgwcnJLS1k2N2RyS050QUlJRnRI?=
 =?utf-8?B?V1FTVWFXMG9iR1gyRHlrZnN0VzNVZmZGdTR3V0pKV1JMRkFQZGtwek1hanFX?=
 =?utf-8?B?alJMbmd0MUx2M0xsWkZTK3FtV2FzZklGUlVUazUwUU14NVM1NHo0U0pReXM3?=
 =?utf-8?B?ZnNDVVluYVNYcXI4OUF0T0NNNVN0WndzL1JVbWVYK2NRNDhnV3NSUGkxQ3Nm?=
 =?utf-8?B?WVh0UkpuMitnbDB3djBBV0tHYUpscjRxNVhQYW52SXpmWDRiWXUxZmZGdzJU?=
 =?utf-8?B?S0tjQzM4cVAyTEY4UHdhSTZyN0s3ZjVac3h3UytTRUZ4b1JyRlJjZllFVURq?=
 =?utf-8?B?eTVYN2Z6alRTM3V4cldGZ1NXd0tnZmZRd0R3dE1iUFNncTRTR0JrQjU5bnJp?=
 =?utf-8?B?ZVFKLzc0MjZzZFRUaEwyaW03QXR5Tk85Q1JlMWtMQmFINEJwVUZwME41dHNB?=
 =?utf-8?Q?fnisJ4hX7suCcg4+nuGHfi4jv/eoGkZxt7v2rN7?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(7416014)(376014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHRiZjF6c1lvT09sY3owK0ZoRzBISWlENWRDVHZtTHdYMkFhWTg0S3ZNbjNQ?=
 =?utf-8?B?alAwR1k2TEh3aXhMbVNjc2k2Vnd3WEtBcW44L2ZoSDU0ZTRlVDBWU3VqeXRr?=
 =?utf-8?B?L21pei9wc2NKTUdqUU9kdUYzWDlkSTdIR2xTU2VabW9MKzgzMHBMSjJFQVQ2?=
 =?utf-8?B?L09KMDVVbnhmck1wZnRaQjNQUkVISFBtQjZTa2tNNmtaS1pMZ1lHVGNxbVpH?=
 =?utf-8?B?WUNzVHlVbjc0RzdKQ0FjZWlKWS9WNHQwL1Bsa3h6bmhFOHBqU1pjZVBvRmRY?=
 =?utf-8?B?eW5jV0pSYjRRaldrbXZJQit4MTFUZFE5dTVGeEdmWFRVREhzN2x4anhrRS9Z?=
 =?utf-8?B?aWhUUEdSZ2JpMDdaUjVocDAyakNLUnJCZCt6L3Bod1pTaFc5MXFUMjN3NWRO?=
 =?utf-8?B?SlluT1AwMnlocHdZNmRMd3IvUU9oR0ZlSHdqU1RENGdOZ3RYTzVPY2NjSmNN?=
 =?utf-8?B?REF6MDBhRFRGcVBtUEt4K2tUQ1JnSFRWTGdOdU5NTUVCOFFFc1kxYU5OeGxl?=
 =?utf-8?B?SGpqMjBDd1ZZVGRsUzk1eTg5YzhKRzBCSEFwcHY0eWcxWTk2RnRNODRITTBI?=
 =?utf-8?B?ZStjZW9rRE92UXpYM3ZBcDNZdXdCVzliZlJRVUdmQVExdnVwYy9NRkNncjUr?=
 =?utf-8?B?Tk9zVGpoMWhUc1FkTTNBa3ZnODJ6eVNpQ3cwU1F3c2NGSXYvbDRkUjRaVkgw?=
 =?utf-8?B?WEYvaGZ6MVpuVzYyMFA3TnlUdU5QVmI0UG1KaU51eDc1Ym1oWmlDSnpoQ3Qy?=
 =?utf-8?B?RnlLTFMvS29LaDAzc2dnSDc5aHJRMWhVNVlCbEE2VVErcWdtTUV4dUowQmp4?=
 =?utf-8?B?UmhjSzZaYklBTWpxdFJTbkZ0UklpTVZUQzNZUEdaQ0oxd1ZPVWxRck8vWnZx?=
 =?utf-8?B?YndaYlNVdnM5Q0laa3JJWThDR1FsbzVxbkNQOEVpWTRYVVpiKzlYU2dMNW9y?=
 =?utf-8?B?bjlHODVPUVlycEFsOWpqbnJZK1ExNmxPSVp0UWFGZzdPanFITG5PQTBhVnpL?=
 =?utf-8?B?cnUrTGdXQVhjMkRIVVV2YXZabndORXlwT1M0d0hlMWFDdlNRcGJ2akVQVGx0?=
 =?utf-8?B?QUloeU5iU1FsR2k0emhPc3lYLzd1YWNTSHJzaStEVXhLZFd0WG1rVU9MaGJX?=
 =?utf-8?B?N25ZdzE4UWZXZEEvNXRuSEs5NWxiQlFCZmZNVVdyOEVFVEJ5NUxRQVQ3dUox?=
 =?utf-8?B?S1NiTHRIRFo2V0NGRWlZTTg0eThJNXhVZ1FhYmcrSTVFak5yZGhzWlFrc1Y4?=
 =?utf-8?B?UjBYWFJZdG5GUjhrWktLZmRNWlhLWktYSFdyalhZMlhRWm00NGE5aFNHbktP?=
 =?utf-8?B?U3dqZXM3RFFxR2VaQ2V3K3Y5ZmlZODhVZU5iVlVmNGtENHRRUGhVVWQrUEZT?=
 =?utf-8?B?QXg5Z0J4NGgwVkpCZTRSQkpSU2lxeVFPQm1rMlhBZXVoeXE4SS9LQ2d5S1Jw?=
 =?utf-8?B?akVqQ0hnSzNweVlXWmxZSGJ6U0FXemdnZkZEaktnbGJoNWVyTzl5NnRhMGlv?=
 =?utf-8?B?ek9acHdRb3NTWnhLVUYwYTFURHNrdk56aXlwbHhHb3JjdVpvTjN2Ync3bmJT?=
 =?utf-8?B?UWNucENwK1FvaEhpUzVRc0dUN0tIT25PaGR2T1JmZ3MwQmY1azF5YUlxRkxS?=
 =?utf-8?B?N3laVndtR2djZDZ2a1RRYVNPSVVnaG9hY2kzQlRpaVBuTlgyUXUzQzIyZVFP?=
 =?utf-8?B?RUhHblExZzlYSGJYcGhyaXFmWXlxcWF5VkJMY0NxUlIwUS9vczV2VEJtZUNy?=
 =?utf-8?B?K3IvZ1ZYNCsySDhkOVJTZ25qZk5nMmNyMVN5cEVWTE0wcHZIYVc4VnM4UlRj?=
 =?utf-8?B?K1VVemg2bXVRYkIwYTB2S3ozN0R1dXRmUWRMUlhVcmp6UWI4VkxsNUdidVRm?=
 =?utf-8?B?WVA1QUhYRVZmVmdxMVBGVVRvdVJ3NldFYUNlZG5yUWV5QlE4NW9QOUdIa01o?=
 =?utf-8?B?YjRNd0drRjkxMW9GTmx6SDRNMDRJeE1NMllHdmpZeWlhN0hqZE41YkEzRmla?=
 =?utf-8?B?K3R1eHhXeWdMdm0rWVo2RXNKTm8wYjdCZ05jWWlZZXJvMmV6OHpENU02ZlFh?=
 =?utf-8?B?UHZjWEhzdnNKdGtNOWtjT2FIMXYvdUlBMVpZOHE0R3F0bndrcit6eldlcUov?=
 =?utf-8?Q?blAlM3yadEztJQcz9TfCIh7ak?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d05c2861-10d0-4168-dd45-08dcef5a961c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2024 09:52:32.5843
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BlJNxB6c06PDt+XxCWxMk4Bni+t3v45/nI+hxnTJdrus3UNqvfrwDcz4hEAloQ0a5UfY8IEx0MSc0Sb+sWYVcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7285

From: Peng Fan <peng.fan@nxp.com>

Back-to-back LPCG writes can be ignored by the LPCG register due to
a HW bug. The writes need to be separated by at least 4 cycles of
the gated clock. See https://www.nxp.com.cn/docs/en/errata/IMX8_1N94W.pdf

The workaround is implemented as follows:
1. For clocks running greater than or equal to 24MHz, a read
followed by the write will provide sufficient delay.
2. For clocks running below 24MHz, add a delay of 4 clock cylces
after the write to the LPCG register.

Fixes: 2f77296d3df9 ("clk: imx: add lpcg clock support")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-lpcg-scu.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/imx/clk-lpcg-scu.c b/drivers/clk/imx/clk-lpcg-scu.c
index dd5abd09f3e206a5073767561b517d5b3320b28c..cd42190233662c66f2c354f0a2eee3a2531eeb3a 100644
--- a/drivers/clk/imx/clk-lpcg-scu.c
+++ b/drivers/clk/imx/clk-lpcg-scu.c
@@ -6,10 +6,12 @@
 
 #include <linux/bits.h>
 #include <linux/clk-provider.h>
+#include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 #include <linux/spinlock.h>
+#include <linux/units.h>
 
 #include "clk-scu.h"
 
@@ -41,6 +43,31 @@ struct clk_lpcg_scu {
 
 #define to_clk_lpcg_scu(_hw) container_of(_hw, struct clk_lpcg_scu, hw)
 
+/* e10858 -LPCG clock gating register synchronization errata */
+static void lpcg_e10858_writel(unsigned long rate, void __iomem *reg, u32 val)
+{
+	u32 reg1;
+
+	writel(val, reg);
+
+	if (rate >= 24 * HZ_PER_MHZ || rate == 0) {
+		/*
+		 * The time taken to access the LPCG registers from the AP core
+		 * through the interconnect is longer than the minimum delay
+		 * of 4 clock cycles required by the errata.
+		 * Adding a readl will provide sufficient delay to prevent
+		 * back-to-back writes.
+		 */
+		reg1 = readl(reg);
+	} else {
+		/*
+		 * For clocks running below 24MHz, wait a minimum of
+		 * 4 clock cycles.
+		 */
+		ndelay(4 * (DIV_ROUND_UP(1000 * HZ_PER_MHZ, rate)));
+	}
+}
+
 static int clk_lpcg_scu_enable(struct clk_hw *hw)
 {
 	struct clk_lpcg_scu *clk = to_clk_lpcg_scu(hw);
@@ -57,7 +84,8 @@ static int clk_lpcg_scu_enable(struct clk_hw *hw)
 		val |= CLK_GATE_SCU_LPCG_HW_SEL;
 
 	reg |= val << clk->bit_idx;
-	writel(reg, clk->reg);
+
+	lpcg_e10858_writel(clk_hw_get_rate(hw), clk->reg, reg);
 
 	spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
 
@@ -74,7 +102,7 @@ static void clk_lpcg_scu_disable(struct clk_hw *hw)
 
 	reg = readl_relaxed(clk->reg);
 	reg &= ~(CLK_GATE_SCU_LPCG_MASK << clk->bit_idx);
-	writel(reg, clk->reg);
+	lpcg_e10858_writel(clk_hw_get_rate(hw), clk->reg, reg);
 
 	spin_unlock_irqrestore(&imx_lpcg_scu_lock, flags);
 }
@@ -149,9 +177,8 @@ static int __maybe_unused imx_clk_lpcg_scu_resume(struct device *dev)
 	 * FIXME: Sometimes writes don't work unless the CPU issues
 	 * them twice
 	 */
-
-	writel(clk->state, clk->reg);
 	writel(clk->state, clk->reg);
+	lpcg_e10858_writel(0, clk->reg, clk->state);
 	dev_dbg(dev, "restore lpcg state 0x%x\n", clk->state);
 
 	return 0;

-- 
2.37.1


