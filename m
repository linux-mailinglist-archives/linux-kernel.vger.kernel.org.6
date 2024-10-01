Return-Path: <linux-kernel+bounces-346274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8602598C223
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 18:04:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A81541C2320D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 16:04:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1580F1CB530;
	Tue,  1 Oct 2024 16:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="D/oRgZFT"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013043.outbound.protection.outlook.com [52.101.67.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5016D1CB511
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 16:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727798627; cv=fail; b=sJA01nP3JLeH43vRQFCtcSRegXjn0Pk0pps/qTJGUAB/qSotDVS+LYnX28NpeYGce+GcRw/fJqmy/ekO6JKURUzXvdvYfIqQhnn7QPEbh4F2eXI0vbEHNRkIL11rIPtGOZ+HQdSZgUeh8vh0fFpNi4Ymsp/Q+/qC+7MVxbJexMg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727798627; c=relaxed/simple;
	bh=HGmPEBh3mp0etKTNyLcYhyNHTes4xfDtOurveSww8os=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=q7NKWO2g6VAP7RVo+Gt4M54ugxj2lwSppPemdhV32U6VMcCly9zTfSDtShOYcgtedq10gFEY5ABum5lYSP032oppGe2+Ybutf/FBxawao/elQml33dp21atJDczuYZRcGLmCwiJDzc+CKbodLBV+iPulmm0g+bnx5DmTyQfu+0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=D/oRgZFT; arc=fail smtp.client-ip=52.101.67.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bv8oIuO3d/wNoWfiduoIRsfCyyVSry+j/hSDC4ADfgBOEXlVUDyFoExXGwDz3S1yUJBhI+pExYSn1lhT3IdqpuAhoKOxUEv1+TjipW8DRIn0eZq6y1LhtCR0/5X/2o8rUnAfbA7AAtwPeU2IRyKdW24PzGeA1bKs6RaZNQmEmLDrtN/aPtEE8fluPTPYD/RYxMwa2k6aFuKXTjRZ5kGsGNg99hVySG+RZzpTiepbta2lNHSj2U8xF+taf3csTQdee7IJ0R3cE6WKY4nFXfQ2sQckVlBxF72KuzapNJ7ixy7FvEs0gYkxmRggayqfG5uHg9NGM+6cq8rfIk5IuhUwpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=phGcqpjKBhpboIAfePzMU+xlXCV/r2VDbu5UN0qglSI=;
 b=F3gVSIQf9JtAl+zIWYyduXLB/GKe58KN5J000left4RKB898OzpyvsDMrsoKGRpO81w0Jj8ix8XemZMTRnDseNifaszZxJS9q3nG7p8r5AG+buMXqo6VwnnUbCOqFQ0+5gW4gg1inaHMcl6zAYaeVAXqN7E/Y6Iu9prwEPBE+V8s17DT5O70u6OMUVQGb3EzYMftgGpkqgazCH9NPYXmuqmQCZOngrWcrpUJVn8t6F+UsevwYj053lspK8QqYTZlxr8ursw8D+zrk9SRyysOOG+Gr0I4+IhxEH4+BXJrqkAQ9kFFbNntYmgfRi5xFdZ3EOhc8Wv+o91YO1hRjVfgEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phGcqpjKBhpboIAfePzMU+xlXCV/r2VDbu5UN0qglSI=;
 b=D/oRgZFTz4AS5e2soZYQ9QnFh9u6uTr0ok+id/5XJBwJUeY7q9+6tmZMM/6tNCEiwpLJAw2SWXek0nYRj1SrLIkizak33kkJHeExPLB9XM913ueVb+5uuS4PXMJ0qm2XYOfcuHqg+IB/wHVWKrj4QVVe4aa8tkLEcQdqYv3cxssu2FNebNPWuefSJ1ii3Y2oGtlAV47lrW47C/yc+B5r8iT3wkMYcR3eZEgr4L5XJ72x3mv4pO8b6szSxeWIc8N0jij7clJuTER/qEYdDpEhzZhhyu6+yStA9rE5vph8QLnUJN20pGbMbJe7S5CjcJokpECv6+A7ueZStCHzqI4ALA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB7879.eurprd04.prod.outlook.com (2603:10a6:20b:2a4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Tue, 1 Oct
 2024 16:03:41 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Tue, 1 Oct 2024
 16:03:41 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 01 Oct 2024 12:02:51 -0400
Subject: [PATCH v5 2/6] i3c: master: svc: manually emit NACK/ACK for
 hotjoin
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-svc-i3c-hj-v5-2-480ab8aed849@nxp.com>
References: <20241001-svc-i3c-hj-v5-0-480ab8aed849@nxp.com>
In-Reply-To: <20241001-svc-i3c-hj-v5-0-480ab8aed849@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727798616; l=1870;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=HGmPEBh3mp0etKTNyLcYhyNHTes4xfDtOurveSww8os=;
 b=oUeixh/hE6hKHFP0GFQxi5DGSNggf9MDispFIBBJzUmMXx+VmMdMRY+iyFkW2dMpSXsBdp/6S
 jsMtmNlUCy/Ai2Bd6TrmoLQ2uE5uPYWFjHP1NpeVRZpEkPujcFRw8Wt
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA1P222CA0045.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::22) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB7879:EE_
X-MS-Office365-Filtering-Correlation-Id: 45b9b58d-ef8a-487c-ac79-08dce2329e39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|52116014|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?U0UvRjBhWk1JblRrR1YvRHFXYnRlVFgrNlN0Q2p4dW0rTGozS3RCTDhuTmk2?=
 =?utf-8?B?eVQzdEtPeVlJNlhsTXRSODU0OWlDRHhlc1ZaY0Z6aUd6V3dnT2pUdVNhcndx?=
 =?utf-8?B?N2duZFo3bXBSdFk4SkZNTFIreW8zaTVQUzZUbFhoZ3RES3RxQ1FhY0VQaE9m?=
 =?utf-8?B?VVpyT0pReU4vcFYrVWhaaFFUYS8ySzBidE5oZHVYSnJOL3E0VllNSDA0eE5J?=
 =?utf-8?B?d2RVQm9wSFZDemRBR0p0bFFuVnJrZ29TNU9Rdm5GRDFVZDlsNWltZFFDbFo4?=
 =?utf-8?B?RllYaW91aG1oK2J5TVkxYTkrMng5cEpGQ1NwYU5sdEo3amEyakhRQ2luNVl3?=
 =?utf-8?B?SGpiR0Z5Wmd4ckRNb2QyekNiWXVLZll3R1VJTkMzOXQ5N3RHSDkrVVovbFRB?=
 =?utf-8?B?alQwaTg3ODhjd3ZqS0ZnWWI4SndNdFZUV1JJRFl2NXdlYUtpQm11WmhGYW5s?=
 =?utf-8?B?b3pSS2xHSVBqZjRocGxJVzRJakpJTk4vdllKZ01NNW5sSHptOGxWbGtaVVJi?=
 =?utf-8?B?VHFqWkJLKy9PNHpmbm44TXdDd3BiTDNwK1NpUGY0cWxnYTc5RVZPa2RRMFU4?=
 =?utf-8?B?cGZxTmlKbmpnaTNtR09kazlNTkRrTUNyOCt6dWVDWWtQSGJDSDcrcHBmb2NP?=
 =?utf-8?B?TStnQnJBZ3dEQnpyZkplT0JUZlBacTFxR1Vtc003cUhLdlVST2JvRmMzTlBp?=
 =?utf-8?B?UENZUG5vTWFZanVSckE4VmlhRzlQeUExdmFtZzBKeTkvV0Vza1YvbXZocjI1?=
 =?utf-8?B?a004R0hVMGI2TTdHanlHZ3VETUh5NXhZNFRQTnoyeTRRVG10RnRFMDZpb0hm?=
 =?utf-8?B?eS9NN2s5dkNVWEl2QWJCWEJZZU13dVRwaEVwbXpwQWJMY0VBU1lwcjgxUFNs?=
 =?utf-8?B?ditRUzMwcXFxR0x4UTU4MmVMOTQ1d1JVL0pNR095c21pS0pLU3ZqYzVNNXI5?=
 =?utf-8?B?anQzOVN5RThGbmhkTnZyeVRkTlJQMUJSQjc4VUErWm1vUjl2dWZTd1A3Mzkv?=
 =?utf-8?B?Vy9zRnZITTg1VDF6a2xYWkdvRXNJRUZHUm0yMkh2NStGMHBhUUlCckl6YVRT?=
 =?utf-8?B?MHdhSEJzTDMwYi9MVitXenhvdU9SemxYK0k0TXZIVHZwZlpMWFordlVRV3Zk?=
 =?utf-8?B?Mld5OGo2YlhBcVdjYjZlMGFLNE91b0pWVWdDQ05LR1RKUExGeU9pcmlEQ2h4?=
 =?utf-8?B?WE9rb1M5ZmFCQXM1Vnh0Tm42WmxDVFIwQUkvcFRMUEtwK0xWeFY4U1hrdGla?=
 =?utf-8?B?N2MxTWVsMGp3YVo1VFlWSTZydHc2NStPZGpMTUVRa1pJMk9SOEtjV2wvK3py?=
 =?utf-8?B?eWZFMkdQekJuWXFwcm9lUjJjaXVPU29xMjlXMGw1TndQSFlNSDE5Mk15aU4y?=
 =?utf-8?B?RUhiZ3RReUZCMWRMVjJXSHBncXJWdlFjaGc5SlVnOGx6blVFbit1VWlMOHQ0?=
 =?utf-8?B?alFKQkZiN0dwb0dOcktEWmk1OWsrWUUydmJsMXNJd2Q0ZW9LMHZ1eDNHM3g3?=
 =?utf-8?B?QXBCQkZJYkY3ay9XQU80N0JyUENXR1RQaC9ZU0FlZVBaRDdmeDVrbGtlMUZ5?=
 =?utf-8?B?UE1ZK0p5OWExS2pRZkQvRTZ4WHZzN2M5aENnOXFtWXkzUjJ6MDR5OGFPdGJ4?=
 =?utf-8?B?RFl3NU5FN3FYbWRZS0JuSEtISWNzLytBOXJMVDJwanZ6QS9VenpKOFE5RG9h?=
 =?utf-8?B?bjlBZ3RxaWw1aUxhek9jeWZVK3l2VXpEb3pYMlAvVTRwend2T0p6WDNGazU0?=
 =?utf-8?B?RVhzcVlsMmROLzgzUlg5TWxVMEVsVS85TlJUZVhNS0gxMWFjZDl3dmppNSs2?=
 =?utf-8?B?NmRIV1RxWWVLcnlTUEZ2UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MldjTXpVMHRwKzFIMXdTSC93QXlGMUtGdUkrRXlwZElyQkNUc3RvOUxGS0RQ?=
 =?utf-8?B?S2M5dndhZEZ6L2dCcFR1ZGdrY0JteXNjQlF6QTY0aGNGSUdhTDBMc0E3emIw?=
 =?utf-8?B?NE5hU282azJETWpoMkVYWWJYUEZnRGw5TEFIRDJKUFQzczJpa0srSWlNOVhy?=
 =?utf-8?B?dTZaWEZBUHdTeC9INUJTb0pmVHlCZ3UxRkJNeUtvckVNRnlCYUdOMW5iVGdz?=
 =?utf-8?B?alhNblRPVUlNdjE2dFliWVFyei9LQ3hocEpLNVZOZlQzaGRYWXVudUwzcERq?=
 =?utf-8?B?L3laeG1ZbjJFMWp1SUlzVG5OT3RnaUdyY1BjOW04ZGZJTHZhaDNtMUdIQ1o5?=
 =?utf-8?B?b1VPbzMrZEUwM3Nwdm1aNW16S2UxbnhxSnRIK2FEOUZLSHB2RUJ5UUdEajVh?=
 =?utf-8?B?ZUVjWlViMk5kckloQmdBSmpHK3BFdmtmeHpHd1NxK1AwOElqZEFRbkdJZlFY?=
 =?utf-8?B?OXAya2FISjExV1lMT1JRNUJ3MzJzV1llcEhTOG1XaklkalFIQjdKZk9jZEh2?=
 =?utf-8?B?Y29zcDhyRVRjUW1EVzlZb00vdGNyR3NRSEFrNHVwNVB5V0txTXNCSHhhWmRm?=
 =?utf-8?B?Y0tqeWNXQXNkTElIOTVKREFYQTZucFhQNzdNdkJOdEdmNDAyVjdKL21CTUhR?=
 =?utf-8?B?UFJoME1lVFNEakVYMFZrbkVOelBWMnNYejkrRGtJdFFMVW5HTjN0TjVuR0hL?=
 =?utf-8?B?WDhFRFB0c3gyWWlDTno5dDN0bklma0FuZmEyMnVrMUJNekN6MTY0K3lCaEQy?=
 =?utf-8?B?RFNzbkpKMHdqOTBtNXIzb1NFNE1Ub0VuSDFYVGdrekxZZUNOY2FaajR5cUJ6?=
 =?utf-8?B?aTlpQVVtUjVKVFp6ZUZYQm9QeHVkRXYzalZuK3BkVnY3WW9UdlVpb3IvRmZO?=
 =?utf-8?B?SmF5QkVEZVdmS0hvOHlteEVQVlJUNTVhZ0FpQUFGMk10Snp3d1Z1V1F1Vjhu?=
 =?utf-8?B?QWJUSko3bWVSOENjRyszSDdlZ3hyb3NsK1hCVWxDdGNrcmRSK0l3RGNpNjRj?=
 =?utf-8?B?bTZyb254NzRUdmlZLzMyRE0xNHNvTGpzMk9xSzlkTlRxS3dHRHcxQzFja3NP?=
 =?utf-8?B?c2VTT21WandZYThtdFAyUmcxZVBTV3ZoRWVLcHhIWVBNb0NSaTJaQlUrRExs?=
 =?utf-8?B?U21xNytpVWw4OFI4WXZkRm9BM2VuZVBSNGFtV1o4WFVMbUlBYitUTmw2dFR3?=
 =?utf-8?B?TEFVK2V0ME94Z1Z0b09FVWJ1TlFIYlZUYWxVdENMZWorZDlwd2dTUXZJbDZW?=
 =?utf-8?B?bnBCTWFMUTZSenpYU3d6bzE1Y1pUbFEvUVltUEVFY0RIcGJOTHVRMEJiR3FZ?=
 =?utf-8?B?YXdFUnpSZDlYVTJhQkhybUFISGE3SXQ3aXROSGhaRkQ2QUFraEVTelB6Qk1a?=
 =?utf-8?B?MTQyR3lIcm93VDB0b3pRSm1yZWduQkp4em1YZFZ0Nkl3WTZQL0h1VUsxQjJ0?=
 =?utf-8?B?WE9jQm5aMkIxRmE3cUFRWDdxekJtWjhOMmVoUHBHWEdoWWRmYnYxVmtGVVpx?=
 =?utf-8?B?V1orK2pCUE0xQ1JVdFhvc3pMN1E3V0tkWTEvR3duemJ3TjVYMnhseEhMeTYx?=
 =?utf-8?B?SjRBYXlCVTE0QWJ0eEQyQ1dnR3pDL25EVzV4MDZ6ZWN4VnF4T1pvb0hXUnBT?=
 =?utf-8?B?bE5hTlByRTYrMXpKblVLQllsKzBPczV6T1dWT0d0WUd3SE03cnA2TE1UcnV2?=
 =?utf-8?B?aTYxS0xIOVQybkJ5M1dxYjk1cE9vZEZMcXpjL3ZZdlZxK2FOS0xwU3ZOS3l3?=
 =?utf-8?B?MXB6Ynk1bVIra2Z2aEVaRGlrTkIvdVJ3dUg1WG44cnpHQWRFdnp2RXh1ZDUx?=
 =?utf-8?B?VlRuMU04R2loY3ZUVXUxdFhLVElLZ3FpQk52ekJpd0RkMURyY1NZZGgrUmR0?=
 =?utf-8?B?bTkrdm51ZFRndUNVbXB3bEVpS0pKRkl0R0pYWkxTTWFDVEJlV0ZFZ0x2MElH?=
 =?utf-8?B?ZTdVSE5YRDVJd1hkM1U4SWtGOUFuUmFVWVhOY3ZMRm8vQTZEem5lN3kxQ09Z?=
 =?utf-8?B?ZnRwbE4yTlFyNVhoWEVQV2JUVC9nNHJLOFVmYk80Q1FtRW54ZmFrZTJrTnRR?=
 =?utf-8?B?RldCb3NMb2V1QWRlVmRGWS9QVG94bG5KRnhiVWx2OVdVYmxSbTJpNEUrWjV4?=
 =?utf-8?Q?fiHc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45b9b58d-ef8a-487c-ac79-08dce2329e39
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 16:03:41.1224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i2M5T9zxo17/dyGgUsFkdI6kFprxRMoPMkl+16KR6SstpTfo3N1lsvVLuhpnWbi5Uvx4IklzVBeNd1U7oVTgAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7879

When the address is arbitrated at send address, the hardware can auto-send
NACK if it is an IBI. However, manual emission of NACK/ACK is needed for
hot join or controller request events.

Add help function svc_i3c_master_handle_ibi_won() to check event type and
send out NACK if the event is not an IBI.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
change from v3 to v4
- add Miquel review tag
---
 drivers/i3c/master/svc-i3c-master.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 7cd3ce2643f1a..c35a228f0c2f4 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -409,6 +409,24 @@ static void svc_i3c_master_nack_ibi(struct svc_i3c_master *master)
 	       master->regs + SVC_I3C_MCTRL);
 }
 
+static int svc_i3c_master_handle_ibi_won(struct svc_i3c_master *master, u32 mstatus)
+{
+	u32 ibitype;
+
+	ibitype = SVC_I3C_MSTATUS_IBITYPE(mstatus);
+
+	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
+
+	/* Hardware can't auto emit NACK for hot join and master request */
+	switch (ibitype) {
+	case SVC_I3C_MSTATUS_IBITYPE_HOT_JOIN:
+	case SVC_I3C_MSTATUS_IBITYPE_MASTER_REQUEST:
+		svc_i3c_master_nack_ibi(master);
+	}
+
+	return 0;
+}
+
 static void svc_i3c_master_ibi_work(struct work_struct *work)
 {
 	struct svc_i3c_master *master = container_of(work, struct svc_i3c_master, ibi_work);
@@ -1177,7 +1195,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
 		 * start.
 		 */
 		if (SVC_I3C_MSTATUS_IBIWON(reg)) {
-			writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
+			svc_i3c_master_handle_ibi_won(master, reg);
 			continue;
 		}
 

-- 
2.34.1


