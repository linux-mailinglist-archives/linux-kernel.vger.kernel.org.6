Return-Path: <linux-kernel+bounces-534465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D80A4676C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 18:07:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6864C165F7C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 16:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5369221D80;
	Wed, 26 Feb 2025 16:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VS1+HiMi"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011062.outbound.protection.outlook.com [52.101.65.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3ED13A88A;
	Wed, 26 Feb 2025 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740588822; cv=fail; b=hJXTLM+Hiu8+EFQSNFMmKRHHr+60yOy5hxJKnFeH+lzHI5AmYZuirOqUWdBlPzMIHzsSdnNOoHPY9F9sIVcYJuiKxzxpP7z/NigPSfXi/9fSPUgYw4lcYbtRJKfikKQr73gxeaXJpJKL2TykLbojPOqoSL/gBeVs3WkWhQ7ktVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740588822; c=relaxed/simple;
	bh=XwirX/nqqTHHet/xMiinNxeJ2KBAFOHD62X258LDIqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=aoMCjm7A9+PIiKVhJWzwrkXD1oLknl/U7R9ruVxpIovPai+TOC9Uyedv6Qhvo9faHGSNmYw9caDW1nOd44rFmVRiDPU7CbQYOesuJCy3ZBaCpTp0ssnkU8mfyOxW/VTV4so4O4Ltzq2YJq9jUD7zYy7TDxEbiVmxo5UewMqjgiE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VS1+HiMi; arc=fail smtp.client-ip=52.101.65.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tevp0VXfxrMM0V48SXDdXIgoa/iEJaIZbj7919iZWcDEBWoEZik6rUvrumCJmfiGJp2L5fkauzJVY7fB/VwrhppfZeQRsGCSDMXinrM2EXT4TMHX89m3jYgxqT73z6YKP91/a0Wfhow59qv4dmGpVwc7qwxtORoBml94op0b699NmAqOVKBDA8gKmTpxkIA+27iQUwhxpdeRTeLbppcxiVRuC/y9RPZLm3URSw26zgE4dBiy1OG2AJXOm6Eic3snon6XqIOftAKdD1WsZyKwU9DRC751iERWkNykIfcHir4DL6trxuOHsLaVQr+d7A11D0BB88Eib0US2QNrCb382A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X8HClUwW2BcyyXnY2fW6YegSkU1EmGRNWvd2/tiRaOE=;
 b=A+6z0C7yehElYdDqlmspLdlpMXlCFBFM8lJEoNEJJE211esGyNtJ1S3F4KO1BNeLuaECGn9kwyoTv13NqlaKRtOVaXN1cGROpxc3t9ttI2C+dvVof3Q62ZjfR2lI9SI+FO2j0l7qCDc+/tYnJ5MyE3yHchE07trbruA1bIjOJCGhFfRsD4NA8VloCZOichN04/nE6HSfddtBwB9Tmj37K6nGUGbUSM/sREF1Bhs8od/TLF60Gz2HFXNU5F7GMH0Bfge2PCBpUV0h5WKvtnDHjHKL3gVpCjSQRgaQD+uF8iLaUwWTM+R3+4dDCoHxgkx6zuginFfiWr4TkglzmAnxGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X8HClUwW2BcyyXnY2fW6YegSkU1EmGRNWvd2/tiRaOE=;
 b=VS1+HiMi53dJMdPTZF1njS8HRUka2nYKijPg1Kshkw0cg5rb668IQT73Pp+X+Im75uiWo45oKgIybwuZWYEsL/5WSvn1I4Uw0Aw4AzNmOTEzwDv8NLFsTheJb+4Nng0i+OHUjjPBjpUohXKnJ7V9uR/8KRKYP8B2ZMO6ZkYpGJhBBxqHjspzWDaPko0oXsnc14ZaYAyYc1X/SceTsutAuDEguHD1trgBeW20XehnIJgSES7rBKhxhyclgcw+t2h9LhPWc+MvUGhaiuLFUzg9en7tXFp6DCRS9i8kJzQO+Fd/15M+vcc6+3V4o6dsyDJZPzgRz999uYheksPeY6vnmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB6971.eurprd04.prod.outlook.com (2603:10a6:10:113::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.19; Wed, 26 Feb
 2025 16:53:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8466.016; Wed, 26 Feb 2025
 16:53:37 +0000
Date: Wed, 26 Feb 2025 11:53:30 -0500
From: Frank Li <Frank.li@nxp.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH v4 3/5] i3c: master: svc: Fix npcm845 FIFO empty issue
Message-ID: <Z79HCj+wxYDN6W0e@lizhi-Precision-Tower-5810>
References: <20250224083908.1880383-1-yschu@nuvoton.com>
 <20250224083908.1880383-4-yschu@nuvoton.com>
 <Z7yfEunAWuR8jchq@lizhi-Precision-Tower-5810>
 <CAPwEoQNZef_CeeCDNFGG4oJHCiM3MN9-juq+xX3hB5DKp4vorQ@mail.gmail.com>
 <Z73wr/6Or6SWOQD8@lizhi-Precision-Tower-5810>
 <CAPwEoQPmbn0N5UCJn3c90A6ppNCa9t2MYUBppiosrOFN4JW9xA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPwEoQPmbn0N5UCJn3c90A6ppNCa9t2MYUBppiosrOFN4JW9xA@mail.gmail.com>
X-ClientProxiedBy: BY5PR16CA0035.namprd16.prod.outlook.com
 (2603:10b6:a03:1a0::48) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB6971:EE_
X-MS-Office365-Filtering-Correlation-Id: f66cce67-fb7d-46b5-8515-08dd56861d51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Vml6SHc1bnU3QkJTcWllNHMzV2QzY25SQ1BFM3pKTDNQNVZmbnh1R0ZtVUJx?=
 =?utf-8?B?aHdvbnp0Q0tXSnhkVGV1b3gwbU96Yzd1T0g0TFpNdENibUVrczREMVk2dmJp?=
 =?utf-8?B?SEJKdzRlemhUbWFWYnkvYnVLMmhNRERMcEd1d2dWSzcvVGdqZWowSnE1d3Zv?=
 =?utf-8?B?RjlvTDEwWUs2WFlYYzRrVFB1aUY3L0p3MGtWNmxoNUY5dVJxQWMzOHczWWJS?=
 =?utf-8?B?cVlWQmVYTjU2ZTV4T1pWeFNJR2grMzFzakorT0p2emtQcXhTN1U1R1NxZFhi?=
 =?utf-8?B?RzZuMXplMmhZTGpIanNEYVB6b0tsTE5XdmUwSmhNbSt3OXlLT0hpdStVcnc3?=
 =?utf-8?B?N2tFamRpM1pCb0wyYmU3ano0SXE1dTV0bXhMTllHcEV1b0ZsM3diU0taNFE3?=
 =?utf-8?B?SXVTQ0w2WVJ4VThVQ2JlbmFIK1B6OFYrTW5UWjdxYURsQjNaRUtjK01BbWZv?=
 =?utf-8?B?azBkdzNGMXZFMk8yeHlXejZjNDNRZmZaeGhjczJSYndFNHB1TWlGOWE3dEVw?=
 =?utf-8?B?YzBucGF4YXEvakdDNTBlNUY5WXVNVzJtMG42dVJDbzBCbFVrTmhObjJmRVFP?=
 =?utf-8?B?MTgwMlZIc3ZGYjFKWXV4UE9CVVFKbkpzL2c5NGtkbHM2SHpYVEY1UzlDUjR5?=
 =?utf-8?B?dXhNdWpONE80aG5NajlIUUhON2dXdmpqcnVBaXo5d2dGUW43N0xsMGd5czNN?=
 =?utf-8?B?WUNBYmIwK2ZqWVQ2ckptUmZKUUFBMmVIajJXbGxqZ0hoeFlYME9Kd0hYNmpr?=
 =?utf-8?B?QnRCb3VWZjcxTm82OWREMHJsYXROOXdlUXRmeUxad012OG9XR1dtbWRqREZN?=
 =?utf-8?B?MnIvVDY1Q2FmMC9wbjZrNnJrMkp2WlhGUWNrQk1kN2VNVC9GMjF3Z2h0YVIw?=
 =?utf-8?B?ZDJDSENBVnFkZ2RVK01jUlpUQXhjb2RMZ1ZKa2MvZHRzVUd3NHRPLzVPZ2Yv?=
 =?utf-8?B?L25aWStEQnpGTDRZK0N4dUVESHp3VXVrWGpIR2lsUzU5V0M1VExpME5LUVJ6?=
 =?utf-8?B?TlJzKzYyYysvSEdXTVUxanMrZTNWS290cnlGcE9OdDA1VWJiRW1rOUw4RWhs?=
 =?utf-8?B?R2xDOFBwaTVFcks0NUkrRVpCV0JRNmpBTDVZdUZObDVaZ1dlWnI0R0FhMk56?=
 =?utf-8?B?UkE1WlJFSTFZeU1HejZ4WW9XcThLUzZUZTZPZWJnUE5YK21VVTlrWEx2d3Vu?=
 =?utf-8?B?cmNsMjc1M0UzWkt1aUhIMWVRMjdDZHhLbUphYUg2bEZnbUdSYXNQdndBTldr?=
 =?utf-8?B?WEFCWjVpcjA1WCtuaW1ybEtkYWhxTTJ2blpucm1JaFVHZTVTaU5wMnRNd3pO?=
 =?utf-8?B?QzR0RHBSWDg1Qk9rdkNMMW1mekhZMFJGczRoMDB0cHY3N05YamtUaFJtMC9J?=
 =?utf-8?B?cExxWUdJZDh1VGlrZWdqVEdybXRTWWZNbW90dUFONSs5VGdEYVAyQXV4dFgr?=
 =?utf-8?B?empwZUFHYTBDQjJ0Wk9hRjRWeEg0S0Y3Y3ljMzNab2J3ZnZhY2hURmNsVUVz?=
 =?utf-8?B?R3NHS2dhTXBmWEM2Rk5iK2M5Z0Z4TzZVZ25VcTdEVndySlU0ekk5b0s2a1JP?=
 =?utf-8?B?cnFlYWZqeFhtQ2xyZzBpeHlNbG5nTU9OcHRlR0M1bDJxcnFkUnFucUhSUERQ?=
 =?utf-8?B?Q2I5enlocCtJU0VMVUxLb0o2RHp4NDdQaTFLS3EvMHpkWVlLUEZreWp3a2E2?=
 =?utf-8?B?WE9tTGJPMG15aTdZTTBaSlZoVjlNUWpHZ2NrYTUvTkN0TGpPQ0FrdkhjZVpC?=
 =?utf-8?B?S3VEMHFEZTBQSnAwZE9QNjJWM1JOYnZvT0djZjd1aXA5OENyajJSV3hMeU5q?=
 =?utf-8?B?VkNYaUhKbzRRakZFRFNueUUvdFlEUy9XRGY0cGd0Zm56b1NOU2ZzdkpweDBs?=
 =?utf-8?B?UTZzT0J3eDY5dktmTFhrN2FWR0JxWGZKV0F4TGtpNUxYRmc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzVSZWFlNXJVa2swVFY1VVQ1UzNXSFM0OTg3c1dqZ3VSUkhFMGVNREsxL29H?=
 =?utf-8?B?UEtjSGt0bmtRcjVSaHBDOWQ2SVpmQVdmQXlKcm1xMFdyL3BKcGxVSUV4Y2xG?=
 =?utf-8?B?bFdjK0NXendnZHdsU1NMRXJKWEFaOWcxM2RtcFNacGdzYVJMK2wrSitFbWM1?=
 =?utf-8?B?c2tWTFlCeFBUMEZ2Sk56L0RvYVRtZ2hQVEJhMkY4SEhKazdFcUg1Z3IxaG4y?=
 =?utf-8?B?ZEdWLzNzVDJqWU81Z0tUWmZZbjJ0dkRocVNSYUs3Qk1oR2Y2NGl2eVh5UGV5?=
 =?utf-8?B?WXV0dktkMEFPZ1A0dURYdWlSWXRyeUNJUlpPbUtKOU9Qd3AxMEtoY3JpQjF6?=
 =?utf-8?B?MFgwY1JzWmVOY2dSVFRTT3VwbjBBeDBOVmljeitOTkVhdmV3N2JTY08ra1pB?=
 =?utf-8?B?cG02RzBpYnBUV3RmczY1RTBxYlJwNnE0Rld1bVFjSlliWkQ0Y1g2d2VzUFM5?=
 =?utf-8?B?MHd2NWRKTVRlYUpYTU16U3czZUJhWXJjak1PT1JVWnBkSjZWM2NCRTU4OTUz?=
 =?utf-8?B?L2NpVDJGamRYN0s2V3FSWEZ0eWJhU1pEcGZtcXUyMWlNZ0xseWhlMUFSOVVW?=
 =?utf-8?B?L3ZLMDAxSFVFSHAwNXBlQSs2QXNaVEtBREZiN0VlcXc0MHMvYmNkUmZ0ZmIz?=
 =?utf-8?B?aVRmNWs2dC9jTmNLdTQzbGt0Sjh6V0I1WVg0QVo5bys4RjYrVzM2WlJBUExQ?=
 =?utf-8?B?WFYyblozeDMwVWJEL1RYcDF4ekRybVlqUzJIakVVeXA2L1pXZE91TzZsOFIr?=
 =?utf-8?B?SGpZR2kvQjd2eWE5Y3hRbmxWQ0FWOTh3dWV4RGNIZHlLbnJKQWhVSFJvKzBV?=
 =?utf-8?B?Y1RaR1lldzdPTVNIalFvV1dsWVVsWmJzcjdIUzcrZjVkTjd2NUlGZjliQURW?=
 =?utf-8?B?RnFKSE1iUldsMEozQm9xWTdFMWxtOTRxanVPOUFoNFF6S013ckdjbVJRazNB?=
 =?utf-8?B?VC83MVVuOGpvT2lETlBTaFF6MkU4N3AweTNiNHBneDlmbTRpK0tEQzZncUx2?=
 =?utf-8?B?OWNyUS9HallzaXdlSmxSUjhpWnZUSzI3UU0xUloxVE9hVDdGby9xU1A4KzZq?=
 =?utf-8?B?UGJBTzU5dFp2ZVpsNnYvbHpXREdycGEwd01nYWYrQ1pBczJHQUdwb1RIWi9u?=
 =?utf-8?B?RjZjZmhyNlk1MEpFUEVRSlFDY2haSDdzK0J2VXJkR0dYSlJvd1ZnZ3ZEV0ZD?=
 =?utf-8?B?cGZCb1kzQXRXWlYyRFJmYldaMWVQN2lSVG1icERCS0lzUm9tZTc5enpmOW55?=
 =?utf-8?B?VTliNExqMEtZT1lCTGxxbnBxVnB1SFlXQ1d5MWVUUUR0d21WcUV4Z2ROaWE0?=
 =?utf-8?B?UWJCaU9URXlMSUQ2L1FlRnRiMXpKRmNMdXJWNm5OMEhsU1BkclhDVFE0Zk91?=
 =?utf-8?B?MEJKeDhjSUt0eXJodEdPUjdObWZxc0xNY0dRZnlSRE1lZUR4YWNEOEtYbzB2?=
 =?utf-8?B?anhGZE5XMmtGODFIUW5NbHlRa2xiWHlFcktpQ2djemF5cmh6TXJ4KzZjVFNi?=
 =?utf-8?B?bjUvdmRWdUVoWmFvdEsxc2cwWFhmWm9GcVVJY1lFUU5oWFRNdlJ1SG1nV1d1?=
 =?utf-8?B?Y3Z6S29udmdhcWdGMXZvbjc0dXZZWnJKeVQ2ai9XTFozV0tqT01EQ000aVhs?=
 =?utf-8?B?Y21jdmpQRnVmdzMrMjNvWGNSaEc3K3dmVHQrNkthTStXcDJxLzlhM281Z1Zh?=
 =?utf-8?B?UG4vWndPbnJaZUlsUWlGdVV0NURucDV5aEh6RHRHR0R5eTgyaGtwVnFoaVZD?=
 =?utf-8?B?ajZOSE9DTlRleGhIeHh0bkFsTVVvc01hemV2RUJSeEZFcGNhd0t6bFhSN3V4?=
 =?utf-8?B?eUdBZGxyM3AySHJVaXJCNjIrODE2aUhxWGd2dm9ySElhT05hSzNMMlgvVC9M?=
 =?utf-8?B?WUZUVkZ1SnJpZEY4b01MdzRJNENVLzNkYXRQeXRuMzBZb203RS9rZlhQSmty?=
 =?utf-8?B?Q3pudzIyV0V2cUp6U2E3Mi9aSnQ5di9IWGhERlZzenU1U2dVVkFDMXJYcW1r?=
 =?utf-8?B?YlpoRGZ4VnJvNHFTUXk4ZHYxQVB0aG1EQ3JndHR4ZW5YcjZCYTlHUGpMQm14?=
 =?utf-8?B?Yk1XWTZFZ1k4WkVpdGk2c08vclJlcWZTSlJtYUZFRGMzWlJmWUJ3VXZFUGxo?=
 =?utf-8?Q?7TauApNrbNsLaHI4iHezjfyk+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f66cce67-fb7d-46b5-8515-08dd56861d51
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2025 16:53:37.8353
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKrcyIPFDqIo3p7oM2wGEKcK7MN3MCooObz/X9tJ4d1az08OA/1n5ansgAMilKsHxcDLY0wYRQfQoUWqYUgvMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6971

On Wed, Feb 26, 2025 at 11:26:24AM +0800, Stanley Chu wrote:
> On Wed, Feb 26, 2025 at 12:32 AM Frank Li <Frank.li@nxp.com> wrote:
> >
> > On Tue, Feb 25, 2025 at 05:28:48PM +0800, Stanley Chu wrote:
> > > On Tue, Feb 25, 2025 at 12:32 AM Frank Li <Frank.li@nxp.com> wrote:
> > > >
> > > > On Mon, Feb 24, 2025 at 04:39:06PM +0800, Stanley Chu wrote:
> > > > > From: Stanley Chu <yschu@nuvoton.com>
> > > > >
> > > > > I3C HW stalls the write transfer if the transmit FIFO becomes empty,
> > > > > when new data is written to FIFO, I3C HW resumes the transfer but the
> > > > > first transmitted data bit may have the wrong value.
> > > > > Fill the FIFO in advance to prevent FIFO from becoming empty.
> > > > >
> > > > > Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> > > > > ---
> > > > >  drivers/i3c/master/svc-i3c-master.c | 44 ++++++++++++++++++++---------
> > > > >  1 file changed, 31 insertions(+), 13 deletions(-)
> > > > >
> > > > > diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> > > > > index 8834f87a4767..07506ae0f914 100644
> > > > > --- a/drivers/i3c/master/svc-i3c-master.c
> > > > > +++ b/drivers/i3c/master/svc-i3c-master.c
> > > > > @@ -942,7 +942,7 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
> > > > >                                       u8 *addrs, unsigned int *count)
> > > > >  {
> > > > >       u64 prov_id[SVC_I3C_MAX_DEVS] = {}, nacking_prov_id = 0;
> > > > > -     unsigned int dev_nb = 0, last_addr = 0;
> > > > > +     unsigned int dev_nb = 0, last_addr = 0, dyn_addr;
> > > > >       u32 reg;
> > > > >       int ret, i;
> > > > >
> > > > > @@ -985,6 +985,17 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
> > > > >               if (SVC_I3C_MSTATUS_RXPEND(reg)) {
> > > > >                       u8 data[6];
> > > > >
> > > > > +                     /*
> > > > > +                      * One slave sends its ID to request for address assignment,
> > > > > +                      * pre-filling the dynamic address can reduce SCL clock stalls
> > > > > +                      * and also fix the SVC_I3C_QUIRK_FIFO_EMPTY quirk.
> > > > > +                      */
> > > > > +                     dyn_addr = i3c_master_get_free_addr(&master->base, last_addr + 1);
> > > > > +                     if (dyn_addr < 0)
> > > > > +                             return -ENOSPC;
> > > > > +
> > > > > +                     writel(dyn_addr, master->regs + SVC_I3C_MWDATAB);
> > > > > +
> > > >
> > > > Although there is 64 clock time after issue do_daa, it is still better if
> > > > prefill dyn_addr before sent do daa command?
> > > >
> > > > If add a debug message before i3c_master_get_free_addr(), does it trigger
> > > > hardware issue?
> > > >
> > > > Frank
> > >
> > > Ideally, prefilling before the processDAA command is better. However,
> > > it requires an additional check to write the dyn_addr at the right time
> > > because the driver needs to write the processDAA command twice for one
> > > assignment
> > >
> > > Prefilling here is safe and efficient because the FIFO starts filling
> > > within a few hundred nanoseconds on the npcm845, which is significantly
> > > faster compared to the 64 SCL clock cycles.
> >
> > Okay, please this to comments.
> >
> > >
> > >
> > > >
> > > > >                       /*
> > > > >                        * We only care about the 48-bit provisioned ID yet to
> > > > >                        * be sure a device does not nack an address twice.
> > > > > @@ -1063,21 +1074,16 @@ static int svc_i3c_master_do_daa_locked(struct svc_i3c_master *master,
> > > > >               if (ret)
> > > > >                       break;
> > > > >
> > > > > -             /* Give the slave device a suitable dynamic address */
> > > > > -             ret = i3c_master_get_free_addr(&master->base, last_addr + 1);
> > > > > -             if (ret < 0)
> > > > > -                     break;
> > > > > -
> > > > > -             addrs[dev_nb] = ret;
> > > > > +             addrs[dev_nb] = dyn_addr;
> > > > >               dev_dbg(master->dev, "DAA: device %d assigned to 0x%02x\n",
> > > > >                       dev_nb, addrs[dev_nb]);
> > > > > -
> > > > > -             writel(addrs[dev_nb], master->regs + SVC_I3C_MWDATAB);
> > > > >               last_addr = addrs[dev_nb++];
> > > > >       }
> > > > >
> > > > >       /* Need manual issue STOP except for Complete condition */
> > > > >       svc_i3c_master_emit_stop(master);
> > > > > +     svc_i3c_master_flush_fifo(master);
> > > > > +
> > > > >       return ret;
> > > > >  }
> > > > >
> > > > > @@ -1225,8 +1231,8 @@ static int svc_i3c_master_read(struct svc_i3c_master *master,
> > > > >       return offset;
> > > > >  }
> > > > >
> > > > > -static int svc_i3c_master_write(struct svc_i3c_master *master,
> > > > > -                             const u8 *out, unsigned int len)
> > > > > +static int svc_i3c_master_write(struct svc_i3c_master *master, const u8 *out,
> > > > > +                             unsigned int len, bool last)
> > > > >  {
> > > > >       int offset = 0, ret;
> > > > >       u32 mdctrl;
> > > > > @@ -1243,7 +1249,7 @@ static int svc_i3c_master_write(struct svc_i3c_master *master,
> > > > >                * The last byte to be sent over the bus must either have the
> > > > >                * "end" bit set or be written in MWDATABE.
> > > > >                */
> > > > > -             if (likely(offset < (len - 1)))
> > > > > +             if (likely(offset < (len - 1)) || !last)
> > > > >                       writel(out[offset++], master->regs + SVC_I3C_MWDATAB);
> > > > >               else
> > > > >                       writel(out[offset++], master->regs + SVC_I3C_MWDATABE);
> > > > > @@ -1274,6 +1280,17 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
> > > > >                      SVC_I3C_MCTRL_RDTERM(*actual_len),
> > > > >                      master->regs + SVC_I3C_MCTRL);
> > > > >
> > > > > +             if (svc_has_quirk(master, SVC_I3C_QUIRK_FIFO_EMPTY) && !rnw && xfer_len) {
> > > > > +                     u32 len = min_t(u32, xfer_len, SVC_I3C_FIFO_SIZE);
> > > > > +
> > > > > +                     ret = svc_i3c_master_write(master, out, len,
> > > > > +                                                xfer_len <= SVC_I3C_FIFO_SIZE);
> > > > > +                     if (ret < 0)
> > > > > +                             goto emit_stop;
> > > > > +                     xfer_len -= len;
> > > > > +                     out += len;
> > > > > +             }
> > > > > +
> > > >
> > > > The same here, you prefill data after issue sent out address, timing still
> > > > tight, only 9 SCL clock time. should it prefill before issue address?
> > > >
> > > > Frank
> > >
> > > The entire transaction can consist of multiple read and write
> > > transfers. In the case
> > > of S+7E/W+Sr+dyn_addr/W+data+P, If the data is prefilled before Sr, it
> > > will be emitted
> >
> > I think S+7E/W should be xfer[0]
> >         Sr+dyn_addr/W + data + P should be xfer[1]
> >
> > this function only handle one xfer each call. xfer[0]'s size is 0, no
> > pre fill data.
> >
> > Only have prefill data at xfer[1].
> >
>
> Hi Frank,
>
> Please check the example, a transaction contains 2 transfers.
> xfer[0].addr=7E/W, no data
> xfer[1].addr=dyn_addr/W, with data
>
> send xfer[0]:
> 1. Emit Start+7E/W
> 2. Wait for MCTRLDONE
> send xfer[1]:
> 3. Prefill xfer[1].data  // data is emitted immediately

Yes, you are right.

> 4. Emit RepeatedStart+dyn_addr/W
> 5. Wait for MCTRLDONE
> 6. Write remaining data to FIFO if needed
> 7. Emit STOP
>
> Part of xfer[1].data is emitted in xfer[0], which is the problem of prefill
> before EmitStartAddr. This is the reason I moved step 3 after step 4.

Need comments to show the reason.

>
>
> > > immediately and become part of the previous transfer.
> > >
> > > It is not a problem to fill FIFO here, the reason is the same as above.
> > > I will also modify the code as below to make it efficient and keep
> > > svc_i3c_master_write unchanged.
> >
> > no issue to modify svc_i3c_master_write(). I consider prefill data before
> > actually.
> >
> > This hardware is not prefect.  Although it aleady in spin lock, it may run
> > some secuity firmware in secuity domain.  There are 100us timeout. If a
> > hypervisor manage firmware interrupt transfer, one timeout may happen.
> >
> > If prefill data before send address,  it was safe at least for lenght less
> > than FIFO case.
> >
> > Frank
> >
>
> Since prefill before EmitStartAddr has the problem I mentioned above, the FIFO
> should start filling as soon as possible to work around the hardware issue.
> This is why I prefer writing MWDATAB here instead of using svc_i3c_master_write,
> as it can save some polling time.

svc_i3c_master_xfer() is too long and not easy to read. You can create
new helper function/macro for it if you like.

>
> The hardware-specific quirk is added to avoid affecting other platforms that
> do not have this issue.
>
> Stanley
>
>
> > >
> > >                 if (svc_has_quirk(master, SVC_I3C_QUIRK_FIFO_EMPTY) &&
> > > !rnw && xfer_len) {
> > >                         u32 len = min_t(u32, xfer_len, SVC_I3C_FIFO_SIZE);
> > >
> > >                         while (len--) {
> > >                                 if (xfer_len == 1)
> > >                                         writel(out[0], master->regs +
> > > SVC_I3C_MWDATABE);
> > >                                 else
> > >                                         writel(out[0], master->regs +
> > > SVC_I3C_MWDATAB);

Or
#define SVC_I3C_MWD(last) ((last) ? SVC_I3C_MWDATABE : SVC_I3C_MWDATAB)

	writel(out[0], master->regs + SVC_I3C_MWD(xfer_len == 1))

Frank
> > >                                 xfer_len--;
> > >                                 out++;
> > >                         }
> > >                 }
> > >
> > >
> > > >
> > > > >               ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
> > > > >                                SVC_I3C_MSTATUS_MCTRLDONE(reg), 0, 1000);
> > > > >               if (ret)
> > > > > @@ -1335,7 +1352,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
> > > > >       if (rnw)
> > > > >               ret = svc_i3c_master_read(master, in, xfer_len);
> > > > >       else
> > > > > -             ret = svc_i3c_master_write(master, out, xfer_len);
> > > > > +             ret = svc_i3c_master_write(master, out, xfer_len, true);
> > > > >       if (ret < 0)
> > > > >               goto emit_stop;
> > > > >
> > > > > @@ -1362,6 +1379,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
> > > > >  emit_stop:
> > > > >       svc_i3c_master_emit_stop(master);
> > > > >       svc_i3c_master_clear_merrwarn(master);
> > > > > +     svc_i3c_master_flush_fifo(master);
> > > > >
> > > > >       return ret;
> > > > >  }
> > > > > --
> > > > > 2.34.1
> > > > >
> > >
> > > --
> > > linux-i3c mailing list
> > > linux-i3c@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/linux-i3c

