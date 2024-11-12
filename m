Return-Path: <linux-kernel+bounces-405233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F2429C4EDE
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 07:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6551FB222BD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 06:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157C920B1F0;
	Tue, 12 Nov 2024 06:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="XqYZXt2t"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2126.outbound.protection.outlook.com [40.107.21.126])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F7520ADD8;
	Tue, 12 Nov 2024 06:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.126
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731393723; cv=fail; b=J61Lr04eeaY3HXzmHeQTzBPkLggXhlhGsk32HCtzteoh6lhZ6Pg89Y3ZGGgFaOcg9/wDiKEMIHUIikcC9Rs+kueJX6cwUsCL3yVovYyJcgAytZ1oAxDp0mYK94OIgisSf7VXYNFLNwK6qw+AfzZ7/5023ZcOv54XTqyO5HXhv/w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731393723; c=relaxed/simple;
	bh=yO6P2ANUhrdpP1pZBWznKoPfOxeVLVttmjOWHjuEeLM=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=HtWAg5dHA1O/5vX4cz9gzLCl9MyGVucmq+rzJUIRuE6PoCHcrhR5mi8agIJXgwFOZoMAL2Zi68ev03ta2v402zxvSwkX5+8k9SnO0OJR3ST8sK0Jq5Lch9x+FcoF6tlYCXtpWJmGDvfDrVSonMe4/xUHDMjXXPY5LeY0T0SHwAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=XqYZXt2t; arc=fail smtp.client-ip=40.107.21.126
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r4gSb7HGQo6o+0FQvP49In6AHc/Sp/y/kCDXaufaH+QFJzfIOn5XsGiDWeRlFjwD+mJJ6xkDWktfn8OWUnYR9S7aGT8gQUknDEYv4FremrnO2v+YeA80AFuUiPzxgH0I5rQJCqKfEHNJoFaenGGVFqmzIi7keIljlX1yRTvlmptXZ7n9RDbGUUctQwiiTWeB/Ar0tueEO0DY03BhQpxGvGvMndiatemohcxXSXrCDd3bgVt35fB+qZcpPm/BuRFmlqkaYuXsQNq24dG8E+MzwY5ffh3QV2LyrMZuzk3yUzULWL/l6tcuh9JzHi9VWcbUXAeh9M0DaLJF8JDcUOHC1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6T4IZs1Gv41w/SNtX56/TchU7qWinfqOFYQSgWYfxnM=;
 b=w4u32oPED5taCPVewH6FSzitDNL02uqyz1iQn7XuvxITWFZp7EDJL8wWUelYVxpddc38995U5q+twoR6q19RwS+HczBjAxsT5isnYGjS0ug/AjEVHzIEO5TPJ/Hp/sZ6h9eeN37ypg8EFGdhnCSLdKExM4znN7itaAiaNuDiB0bXzA5+oUJicnLUjrdky0WBDGTbqjlmivGMt8gNekDYGNdVFoFKsi8tLH8YDp+95YF/n755AgMTEmcs8m7I5wsOtjzxxj9DP4JATYWDcgVyppgjZ2ASz3M+EhQVXBK1lygR+akJWRYW9QgTRIMGEtp4tf5TeqCAGjsoMwmHwZhJSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6T4IZs1Gv41w/SNtX56/TchU7qWinfqOFYQSgWYfxnM=;
 b=XqYZXt2tfm95arVJ0YsnHejeZw8Cque0cSk05SkFzXrkjQyamhyGFHLj89pfC99+x7y4L4MplFVX+D5s0NcHnRIS22bKjRBYhId9XdHjG43E2OC74U+pZcoW5NtiQNi7rEKIpW/jClK7SkWY11zRDB82zfuWST9TaJjZeCjZ7DE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DU4PR04MB10959.eurprd04.prod.outlook.com (2603:10a6:10:586::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8137.28; Tue, 12 Nov
 2024 06:41:56 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%4]) with mapi id 15.20.8137.027; Tue, 12 Nov 2024
 06:41:56 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Tue, 12 Nov 2024 08:41:33 +0200
Subject: [PATCH 2/2] arm64: dts: ti: k3-am642-hummingboard-t-usb3: fix
 overlay boolean value
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-am64-overlay-bool-v1-2-b9d1faff444e@solid-run.com>
References: <20241112-am64-overlay-bool-v1-0-b9d1faff444e@solid-run.com>
In-Reply-To: <20241112-am64-overlay-bool-v1-0-b9d1faff444e@solid-run.com>
To: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@google.com>, 
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, 
 Tero Kristo <kristo@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Geert Uytterhoeven <geert@linux-m68k.org>, 
 Josua Mayer <josua@solid-run.com>, Jon Nettleton <jon@solid-run.com>, 
 Yazan Shhady <yazan.shhady@solid-run.com>, rabeeh@solid-run.com
X-Mailer: b4 0.14.2
X-ClientProxiedBy: PA7P264CA0446.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:398::29) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DU4PR04MB10959:EE_
X-MS-Office365-Filtering-Correlation-Id: 644c137a-1640-4421-47ee-08dd02e519d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZzdOeTI4U0VQZHlYeEZkUHNFdm43TGpEZEZNSGYyeFVYcWs3V3V5anRiTk1U?=
 =?utf-8?B?S20rRlNkTXN5aG5HYW5aeDZjSzlGNVBXbUtOcm1hU2ZvNUF4dnNSN08wekZK?=
 =?utf-8?B?WVdLRVV2K1ZHZjQwa0lBR3ZzeDJIS1ZLMmdJT0VPb2JIdUVPcmxzK0hrY0ZT?=
 =?utf-8?B?RWUvVTFMbjRuK0Y2OE55L0xVOWdnVzNwdzFWZ0FCeGttS0dpamxjT0c2cGZE?=
 =?utf-8?B?Zm1zRERhUHBCbGlQL014ZDJWYitPRGFOcHlkcE12VWovYzNjNjEvaU8yVjJP?=
 =?utf-8?B?Ym9VbTZTU0NoanA1Z0dqcG1RenM3ZU1GRHNleFNUSnpEYmhOb1pHV09ISEZy?=
 =?utf-8?B?dFFSTmxzV3hrdUh0WmVDazVSaXJGUkJ3UHdDRDVXaG1KMzIxSHhTWVdvM3RY?=
 =?utf-8?B?WnpnUFc5WGRTVUM3OTY1c3g5ai9MUzZZaTR4a1l2RzZFSFptbi81ZHQrUGtV?=
 =?utf-8?B?WVVLNWVhMFVBTmVVU2kyc1orTEs1aXE0MjJuR3cxZ3hMNncxUHdYUzBmN1ps?=
 =?utf-8?B?ZDc4RmpLVmY0aUFFRm9XaHN6WmtiOUpydEh6ckcxQWlvKzZEZW85aEZ6S3NJ?=
 =?utf-8?B?RDhrQjAydFgyNmpZZmpBR1BLMWlJV25MVFRUdmRJU1RJaDk2Q0ZjeUZpU2xD?=
 =?utf-8?B?OFgwNnQ2ekxCSFhmbkQydmVQM1JkcjlPamFQYUh2SG1ZSWJmb2w2SFRXdXVK?=
 =?utf-8?B?K01OTEtjVklFU2x4cyt5WWRKVjNYb2h4VmhzOUxWUjFScHBIZnRXOU8rOWdV?=
 =?utf-8?B?T2NSblBYaGdObzRtbnI3WG1hYVdCbytkWGI0WTJLNXp6bk0yZHFhSlVqQ1dJ?=
 =?utf-8?B?dUVMZVB0L2JZTHJOb3dMclZOTlYyUGpqdDVLbEZiNE4zMTE0NzdlbklTdkp5?=
 =?utf-8?B?amR3WGxDKzVNSkhTb1orZzB4aHUvTWtUbW9YRzNLWDJ5RUtmbzdFbGxuN0U1?=
 =?utf-8?B?MGhnb3NJbGtzQlNGYm80TVVOVmh2WFdIajc0RDEwK2NXeEMybmdPYTUwd0tQ?=
 =?utf-8?B?Z20yclMwTlA1d0RwVURQeTV4TXFZK1d5SlkrR0FDRmJFdEtXSlZ3dFBjMVV6?=
 =?utf-8?B?dzFYcFd5ZUROZC9BSnJHbFFTRW9SUnhseTBwb0NyNVFYbS9RY1pXVE1UWk1Z?=
 =?utf-8?B?MCs4S1dXYzQ4dEE4T3ZDbkZFcHBCaVJTeDJKUzRUSTA4QUQ5NUFXZmxvdWR3?=
 =?utf-8?B?a3NUaTd4b0lqZ2o0RkhEUmJJRm56Q0NRRC9JSkFJZE9sSnQvUGZsNi9JTitY?=
 =?utf-8?B?VlBxMTZPQnpEOFRQdFNHeSt0c3Y5QzNFTmtIZVNpaW9ISU4reXZBelRVWk5v?=
 =?utf-8?B?YjR4eTdENW1Wc1dHUFJPKzlVelRyYjRjZ1c0NDhRYSs1cDlFdkhLbVAxbnFP?=
 =?utf-8?B?VDBnNVM4QWNQVGtnYUk0UFR2eTNjQ1kxZnh1S25xWVB5Z0ZTMTlsVkVjaytC?=
 =?utf-8?B?NVpqVUZPZVRzR1MrejdCUUMxNEJLUGQzZmZEd2o1Sm9rOVdibyszcHBlWTIz?=
 =?utf-8?B?ZWxmaGxaVkR6OFhQTnY4SnJEdTNuUlRvdzBBUjBRV0NTcW56VzlSTHc0dmhk?=
 =?utf-8?B?OU5qSFNuUXBDSG91dUUrMzRSTVZobDJFWXkzZzBxc1pZR1BwTkRlYXRvSEh3?=
 =?utf-8?B?U2p4MndzVmFtYjF0NkFZSFhuQ2lVeDJPQks5TXUxWXdpNGExdkovVFQ1S0J4?=
 =?utf-8?B?eGRUUGhGcmFTbzF1Qlp5TVFMU2dlTkJ1RTFSY3JnNU13YkhFVXNHUVRwUWtU?=
 =?utf-8?B?M3Y1STRKanJ2WlNzYnRUUHM5aGtmTGRweVRkMjNXdGtremx5Y2pHbWFUaitk?=
 =?utf-8?B?UGc5VE96R1F3MU9TWUZ4TUdwdlR4SjV4ZlAvTG9wQmVGWFpITU9BL2dDTUZL?=
 =?utf-8?Q?2GzqUhGQWAlwB?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(52116014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YlpqU05oTTFVL3IyRFk3bHkzWng1b2lYSW40a050a2pSUU5yWHl2WENJVnNn?=
 =?utf-8?B?dXJIY1FOSW9yY2NWYjhsYTV1a0NudEQxbVZONnZuRHV4UjZtUlNyaStqRW1Y?=
 =?utf-8?B?dFZSOXI4cEl6SzUrckNrWGZTT3dtYXlvMlIzZUhQNGtqQ3FyeVY1WG1DbXZP?=
 =?utf-8?B?dWhPZWQ2czBDWjd5Q1RNMkJDaDk2NCt1TGJYZTBXVnZrN2NSajE2MVVxbjN2?=
 =?utf-8?B?MUJJeTk2cGZQdm1DRjY0TFVDSFUza0dQdnZQcDRGTGJwckVMU0I2dEhiU2FF?=
 =?utf-8?B?aVl2Q2EzdmFFQUVqajZjdTE1b3VCOEJQQzJxenNhTGlCREFhYm9TMStubHR0?=
 =?utf-8?B?dGNxMTAzRFM3NVUyK3RIWm5wSSt6YmhkM3lyTkJXNFFJT1dsUGZmQnRuc3pE?=
 =?utf-8?B?MGxvbit5aytqdzgrSjIwN0ErUk5aR0hUbkxHeW9kMm5heXRKM01CNTlFY3RM?=
 =?utf-8?B?SFp3Nzd1VjU2TlJWYmxPeGtlQks4SjdtUEFUWnBVZFA2YzlxSWYyWERaWDdx?=
 =?utf-8?B?VnBKZGpLR28yR2dabGI1dEdLcGFoY0hJNlROM0NyNmhPLzk5TVF2TnpWWGh0?=
 =?utf-8?B?VnFCRXpzS00rSW02L2hXbWE5RHNZdTBsUHdrWkNMZzZRTFRmWEt5V2RaTmxi?=
 =?utf-8?B?Zk1kS2tuN2JMZGlKaHhGYWNud2Rjc1o4b0JCZXlTU1MzQktESkI2MWFhM2hY?=
 =?utf-8?B?dDFoaks4OHpLSk5wR3dmeGRGVlMzaGJaU28xWit5MEc2MldDMUl3Q012aXhE?=
 =?utf-8?B?bkZUNnMrR3hPYXlvUGJsWlIrR0c5aFdrelM3SEJ3Z1ZkdkwvejUyd28xc1Ny?=
 =?utf-8?B?ZkMxSGVtV3VZZnZhN1QrR2ZOUkNUZ0h6Smp3bm80cVdqVlFTWktJTityUEwr?=
 =?utf-8?B?dGNVL0lHSEo4UWIzVFpPckZqUmVBNDc1VWFZT21peDhnQTRJb25kQlNraXhq?=
 =?utf-8?B?bzlsR2g4OGltTUlQQTBIazhUVUFNbHhVd3paZXlnREtYdjhJZ3hvRDFQYUFn?=
 =?utf-8?B?YjlMaEFyMktGRVVHUUhmV3oyREZnbmxRNVFQeEpCRG1LU0s3WTZOTlRvQ2tS?=
 =?utf-8?B?cEVMRklneEVIMk9DKzB4QjZtZjZkR1hKbXEzeTRpWEs5ME9yM1U1Z2MrUUxF?=
 =?utf-8?B?OXNTdXdVZ3h1UFFvZDRmd01vV2x2M2djYnY3RnVFYUR2Sy9zclFXY2hUMjU3?=
 =?utf-8?B?S3dneW9WQUZmSUdJT203UWZobVR3VTRESUVlZjBJVGkyUTNueGNmQldORVd2?=
 =?utf-8?B?ZU15MFpyVjQzM1ZQS3JyUUdvZ3VZdlpsYm8xSVJxMEozR0RGd05KMEw3a1Uz?=
 =?utf-8?B?OUlZcWpjWnJmZElEMDE4S2FjSlgybTEwaWwzM0RKc0xLTkZBeTJ6MEdaeWRj?=
 =?utf-8?B?KzdRU2FlSnlTQTU3b3RDTFRPWWl6ZmJuZS91OFhkclp2RnNuQUVCcmE4NU1W?=
 =?utf-8?B?cHphZmk0TmExUXFCRHRlVi9hYXkrUWxMSTF2bUYvb0FHbnNpRmE0eWZvZlJ2?=
 =?utf-8?B?VlJUdzBXU2J1Z1ltNWNBQ2F6VllGWk1iQlc0alE4eVNwS0h1N1R5bHBNRkl2?=
 =?utf-8?B?T2JIT1VKSkVNWTVkVDZjdEVLQ29oOThkZTBzSDBFc3ozMGlycEx2aFBhZ3VZ?=
 =?utf-8?B?dWx6eVczSHRMNTJjTnpCRjN1bEVvZ2w0cFpMS0dBVy9YRHJYdnI2QS9tNEFn?=
 =?utf-8?B?T0JaeEhmZjVlTERiUzVnMnoxdTZWWWx1amZyOU1GNnhmOE43MS9PV0RiMm9q?=
 =?utf-8?B?TlUvM2Jsa0xRUURITjlqMkpDUE9YTnpLSDJ6ZWVRcVJpdWs3ZysyTEtPMld0?=
 =?utf-8?B?SHpXYTZSaDhMTGRFOVNLRkJoZ2c5WlFCaitwTmVBVFNXZC82VEM2Nk80Zm5v?=
 =?utf-8?B?VnJaNkFKRE9jZ21IZnhOZXphVCtzdHFWQ2lGRGhmQU5tcXhNVWYwYm54bVht?=
 =?utf-8?B?YWhVTC9Hbm5QTnI3WWd4SjdzaUpya1daWEF1NmlBQlNaVlc1WERUT1pQTWpU?=
 =?utf-8?B?WXRsd3ZiMnAyQmF4N2RJRmcycEFuaUxaRnlhL1EveXpkcHNrb0ZFY081QnIz?=
 =?utf-8?B?a0xiMmNkcE52OG12SjZsSmkyM3k1ei9vUXc1Smthb21DRkJRVmc4em1zdlQ0?=
 =?utf-8?Q?QjqtZvuI2KpJgohrr8c6tdzl2?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 644c137a-1640-4421-47ee-08dd02e519d5
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2024 06:41:56.2109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NPr3qBfzFqX9EQecaPpEdygCg+ox2H8XkSmQ2yxG/IzwylFCLPLV5G92ulxwg4lg0Icq6ftS5Ln+cpPXLC6aXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10959

The USB-3.1 overlay uses /delete-property/ to unset a boolean property
on the usb controller limiting it to USB-2.0 by default.
Overlays can not delete a property from the base dtb.

Change the overlay to instead assign value "false" on the ti,usb2-only
boolean property, which is of_property_read_bool now evaluates as false.

Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
Closes: https://lore.kernel.org/linux-devicetree/CAMuHMdXTgpTnJ9U7egC2XjFXXNZ5uiY1O+WxNd6LPJW5Rs5KTw@mail.gmail.com
Fixes: bbef42084cc1 ("arm64: dts: ti: hummingboard-t: add overlays for m.2 pci-e and usb-3")
Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso
index ffcc3bd3c7bc5d47ce9926a95a13af3f61182a2b..3ed709ff11fea1ba07e180d442ce6fda6acaa2a3 100644
--- a/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso
+++ b/arch/arm64/boot/dts/ti/k3-am642-hummingboard-t-usb3.dtso
@@ -34,7 +34,7 @@ &serdes_mux {
 };
 
 &usbss0 {
-	/delete-property/ ti,usb2-only;
+	ti,usb2-only = "false";
 };
 
 &usb0 {

-- 
2.43.0


