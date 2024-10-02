Return-Path: <linux-kernel+bounces-347740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D6D98DDE8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 16:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035F91F23E48
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 14:53:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509AB1D07A3;
	Wed,  2 Oct 2024 14:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e7iwHWOW"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2072.outbound.protection.outlook.com [40.107.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905F0198822
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880663; cv=fail; b=enYQhKAW4xqrS7F0iUSnkJ7NT91WSQxBeQ8sMQw+DHAjN+eJca9v2VChE1T8YUhcXrID4FRme5G1V5JSdxZcaNaCnFTPuDM7CbHOgZmIvVx5M+EqldSQnTUKZHnCwMwwzSgejVaZGroQi37vKZEZ9cYb1MMdUW/NWTd2avF8ey0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880663; c=relaxed/simple;
	bh=Gqd0wCYgtoBFMpBxtk0AaOasL9R8L0WjBcTL6xq2nd0=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=l83ixMucfLUH12XbK41mOtbENecppW/MWF9LJBuZ88Z90dllG3/g3dDxCugxmX1/ejxIpIzna/wKWyZMLZOtDcv3R0Bp50zkdTAuaPHZnA4vvdCbGBrCZLXP4Q6Sx/ADGh1doTllmexW+WQNlEMbbPxmcLgW/N6VGyXuz3LlQSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e7iwHWOW; arc=fail smtp.client-ip=40.107.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KkYZ+zE2rMHlnc70VSAQ100789i18tAaO8SQTNbW4kg5CWGN+r4Cp1ETZG5/L0hjL6H698ejpvxYORdf4ouqDoAEidFXkvSEolcOoP2k1MNvNtrvsEF4eBp9qXNHDUqgc0R8GbVGeOWteNRhTfkHdqBmsXslG8CYevugKWB6Ym5ITHvL+G1ML5Js60SJHIR7X7lEl/YK46L0p2mK+DKpIpLA+fDLgD7tqhSFFXtKJf8v23MFQOBYWUV22wGN5CqnmbH2oKoTGnexE3WIMJgw0i2XpOmIq2Mh/Fq8ppYSodws+dmteD6QFp4ES93tCQW9JU8lbU+RqMpgq0GmemYm8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X3g4JdrXttj+9kVg/nPdSIQfctPvNkrRl+XAcULKDEM=;
 b=S9pdwUc1dRVSoCrkEhdsicNH+Hg1hivnE+JDuV8sOsXdT0uJ2hzHRSzFuR+JSUEW6z15qdYM0J5XsCaV+wQayL7WjWrtbYitcuNcqUNN2H8cps8vCOH2qONTIqW5FLu3Jkiank8iMerZPXo9rJM0lX91alPCsQxWTv1E31cyCqby3uOQM3ay/pXw7lcVnMHZdLJssmxYzqG19su0ZOKWtH4ustrYiLAk/IEwk0XRy/Af7hvaNNGxcn3201ilSFjdkyS5PZMKjxPzWyAn2ih8llcEp2PsBwRCXc7JPiOwtSLzINYfVAY5rmkDdqDjqr9N3WjHMxyluipIzlbeaXdZlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X3g4JdrXttj+9kVg/nPdSIQfctPvNkrRl+XAcULKDEM=;
 b=e7iwHWOW942zd9e1aU+MKBpxV6Krlc+S+tkBT0jQKHO+LM3Sz0qlQKeu+mW0XREBFhTxGvANa0xsv690yhgGb3rdDm6RQuK9fSOSFWNLcwpevJYwwEKEcJlXaE7kiK8KumBDfV/uDJEOV8ZbNtucVzyJ2xZH8XJdC29+7G4j8f3pEdMkCzQBlGKbhv7zxZ5SWh/TdC1h2yflwhscszxNxfNQ0uV/NC816BUyEwr8d76CSsJLm5qHE/KOfICS6ulIkIUpSV2C6dpCFvCJZ4fJ1gNS6qyO9qUfsTOVTe8grBBKq5jO/S25rEwyQDdQNmurwKpHBy5qGDaOa/3hbmZM+A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS1PR04MB9699.eurprd04.prod.outlook.com (2603:10a6:20b:482::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.27; Wed, 2 Oct
 2024 14:50:56 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Wed, 2 Oct 2024
 14:50:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 02 Oct 2024 10:50:34 -0400
Subject: [PATCH v6 2/6] i3c: master: svc: manually emit NACK/ACK for
 hotjoin
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241002-svc-i3c-hj-v6-2-7e6e1d3569ae@nxp.com>
References: <20241002-svc-i3c-hj-v6-0-7e6e1d3569ae@nxp.com>
In-Reply-To: <20241002-svc-i3c-hj-v6-0-7e6e1d3569ae@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>, 
 Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727880649; l=1900;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=Gqd0wCYgtoBFMpBxtk0AaOasL9R8L0WjBcTL6xq2nd0=;
 b=yTdOKTPn+Hk4AHdfqpLCafDEvmCl2BrJJxQOVbedY6RqaFUBlJ0BGf+gflgCusCn1PCsnkUsn
 f8OQ7scY4pHAVImiva3L8kVM/j/nVX33oQCoyxzyx9Gom48JoOQtYYI
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0177.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::32) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS1PR04MB9699:EE_
X-MS-Office365-Filtering-Correlation-Id: 48628745-f4cb-472f-994f-08dce2f19f01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkFYS203cmFydUpQbGFoaGZyYmlOR1JJb214RXhhSHBJdDBnMDRYblFWYWxM?=
 =?utf-8?B?Zi9ydDhqanh5cFFLeXNoRzg4d0dqZ3hGaThWaDBGVlA2Q3ZMdkFDVHo1YmNP?=
 =?utf-8?B?R3cvb0MwVWhxbm80T0h2U1EwZ0xsSCtUeDdWMDZyUzh6a0pleTBySG50T251?=
 =?utf-8?B?ZVVuMDRWYjJwNkh5Um1xK0RKblBTVEhPME1uaFpBYzhHLzg1SE5YUFNDZGwx?=
 =?utf-8?B?cDZSV1Z4dmpSbEdpbStqRGVBK05icWRtSEpUSTc2NVNMbHdTODJDQTFJV3p5?=
 =?utf-8?B?SkRibitRdzRzRVREUis3UXRRaVRnbU1ncHRoa3gvSXFiSVMzOGtabGovbjRH?=
 =?utf-8?B?dHQ0N2xTdm5OUHhrTHZZZFMxZGpOZWV2b1BXcVdJdVZGdzl0V0RZVjliMHJK?=
 =?utf-8?B?TWdva0kxTXRESXZNdHdwMnFOQnJ4WndSUzhweGdLUXVpSFlSUjVrN2RSLzhj?=
 =?utf-8?B?QTFRbG1JcTlLK2gyYXNQajdyRnM5aTY4c0Z5VFJWd3pjWUxIYndUYUR1bEQy?=
 =?utf-8?B?WTdOSmptMDRqdDk3eGh1c2ZvQVRueXlEd0VPclZmTHFiN09uNWdGODFKOWdh?=
 =?utf-8?B?eXN1WnNCSGM2U24zTThSWElxWms4aUZIU1VxWU43MkZLSzRjQWlwVk1OQzhS?=
 =?utf-8?B?WDRCNmpxcWJTSzlEZkwvQUhxZnhnUmR1TlRHU2tucHRnblJ1M2NqblNJWXhv?=
 =?utf-8?B?T2EyQmxjRG5EVWhLdTRWRWRYS2F0QWt2UFE5THplTTJBS0c4ZXhlbkl2M25F?=
 =?utf-8?B?RnBNWWJRL0M4NGNGQ2ZGUGdwaUZJSVdNNWNhbHJKdTlzRXdoQkI3MmFXSjhT?=
 =?utf-8?B?Ky9lRFdxbVN6eGpnTERONzVZdEhQK29TM3hKREtBeWFqUUV3clR1YWVGWXlK?=
 =?utf-8?B?WnhPSWZxOHZlUTB0YlZJa1c5RGZOTzNGSFEydmx4Z3pqY3YvWHhkazRjenR0?=
 =?utf-8?B?YzdjUmc2VWplNVRYRGJKZXlPMUl0d0tpSGlReFJTd0pDd3NKQUgvbjdqYnpG?=
 =?utf-8?B?dEppZzFMWkpZdlFIRUZ3L3Azajk3UDdoemc5MlVGR2dQVVVJdGFUeEFuUDNz?=
 =?utf-8?B?SmM4SmxPODZaMnk0TUpKV0VsT09zK0FtMXpYMnQxMUswQUVLMXZIUS9wV0J0?=
 =?utf-8?B?aXBuWkJLaXE3bVlEY0hGdXVZa0k2Y2FacTZjdjNmZkkwT2pDSlN5aGc4bVdW?=
 =?utf-8?B?eklIWDdva05LZmx5RUlSak1zbWo4YXB2dStIMEZYT2ZhOE52QytmWUlibU9t?=
 =?utf-8?B?aVZHR3libUlZQUM4TC8vUFFvbWQ0MFlTSmRxd1dtaE9DVG0vTE9CS25wdzJZ?=
 =?utf-8?B?UzBtTndhUVgydEZrNmtQWHlTRUVvZWRGNExqZFh0RURMTU1DdWxlakxLaUdn?=
 =?utf-8?B?S1dOOE91UytERm8wczNKc3Z0UDNpdk9QS2RmTm1VMkxrTDZLd1k5cWtnTmd0?=
 =?utf-8?B?MXh4ak1od2NkRmRmbU9JeUdrSC80Z244c2FkdlBGcUJYN3g5M21rdlNMeWky?=
 =?utf-8?B?TVY3U0JlVWYxek1hM0dxRjFqR0NZNWVUbGpKMjRwQ2tseFBNbmM0UWRJeHJB?=
 =?utf-8?B?WCt5SXJzQk9qZDF4VnJVMUpTcjNiQUY0bVRiTzJZWHg1eGFSVWhXUlVSeVdH?=
 =?utf-8?B?QTBqRS8ySjNwb3BTaDhobm5XQnJiNlU3RGxRWEwxem1iQ0tzNVBIaENMRlZh?=
 =?utf-8?B?Ky9EakRuRS8rL1Z4Y2t5YkNZZnVtR3FOUnVoS0xBV1E2L24yZUdTaDJ0ZXlM?=
 =?utf-8?B?NFBkRHlHRDFyMHMvQUx4M0M4YjFKTUxYaXFnVmwvOUQyZS9Pc0JJKzFvQ3Ns?=
 =?utf-8?B?Y1FCb3FGam5ZczVlMDVnQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UU9hZU0vNnFCS2hYSW1OZHlrSEJMSWdGNlFxODRTRzNWVkE3bnhlcVpTalBV?=
 =?utf-8?B?dGthdVV1c3NMZVhXTGVRWXlrRXdQV1dPcCs0anpLeHF0VTZsNG1YeEhXSWtK?=
 =?utf-8?B?VjlmbnZXM3lhWFNtdGFQOHpKMUlFQ2txYkxhS0QrYzJ6NlFHT2Q2bVVBRE44?=
 =?utf-8?B?ZDFMcXFweWMrVERwMEdjZ2ZtTU14bTF1MGdZcURvWGRGa2w3N2pZeWxTaEJt?=
 =?utf-8?B?VWsvTmlkRFNHaHYzaktWNU5HZGpVaVU2N0REZ0JGMGc5eHBvcld6dmZYeGJk?=
 =?utf-8?B?WVJEWjJHTklxRWFjQitJekc4T2htVmdONlFrVjVRTnozS2Z4ZlZGdHhhZ0xo?=
 =?utf-8?B?bTZsZG9JRDByK0tDMHd1c3RpTjROVVlZSzNGK1RRU3BkNDZHYjVmMXM3Nkt6?=
 =?utf-8?B?WlIvL2Q0VkoyNkMra0VDWmN6WEM4UlB1b3dSM3JpVzd6cjZHbEsxQmlDa3Fw?=
 =?utf-8?B?UmpBcHB3QU5nTS9zeGRkNGM2MnlVME5JY3J6aXM0TWF4YUNWNjhaYk5INGdM?=
 =?utf-8?B?OFo4WVl4T2RFNkhCL3VNT2VqVHl5S3dDbGRsZDEzZGF6RGIxMEpONEZzcXVL?=
 =?utf-8?B?WXhuYnduZ3EzdnJlcWd5QlZqWTFHcjkvTXZtZW5YbHZsR2wreDh4MmszMllN?=
 =?utf-8?B?SHNwVnFBWE9TNTFBZGNEU2N5b1YxOW9vaGE3TVpQR2EzSHNyYVE4RlVzZ0Zm?=
 =?utf-8?B?TkJHVUZDc0llL3RTaEVpZGxxWnVrL1A2M1VEbmM0azBDOGcvM1NqVnhMcnV6?=
 =?utf-8?B?anRvZkZNajRKWWJ4ZTR1WGpCellIaWJlVFlpWXJmNnZzdTJQTTFDaldHR21P?=
 =?utf-8?B?WlVIZE9ERWY1RTB2bDMxWkgrcU1JckZOdk0rY2tqN1hnaUU2VTZGUnVLa0Fu?=
 =?utf-8?B?V1dFaXoyWktIZVUvQW9nTU45b0NZRXlhZjBnMHJoR2YxRXVXekhtZ1VEM1JU?=
 =?utf-8?B?cEs0STkrSzl4QWxiNHpBc0pVYXIrcVVGUEkvTFFNWTAzdHBjcVZ6MkwyTGty?=
 =?utf-8?B?SmczZW5GdDdaWFcvWHM4eHZURmhzckJYdlhMZzJTTWlMUFVMQi9jMldyVmhy?=
 =?utf-8?B?UUFFSjF2cFBwdVNrMWxGN1MxSzJPV2l0ajQvVkE2RjhEVDdpRGpVTFcvSVNw?=
 =?utf-8?B?WXVONFU0VGFFNmJvR3VZbWlyNDRwbDFRSnlqNmtNdzZSWTV5UnRCdlRQNXVQ?=
 =?utf-8?B?aFFPajFpbjQzUzJBTjBDR3FXZkdDaFNGeHoyTlZYNlhuY0M2ellSNWMwUWtT?=
 =?utf-8?B?VlEzaWVlYmNka01uTi9TY0ZobTloa2wwdm9aeFRSVldmWDRDeFJ3NDAwb2JH?=
 =?utf-8?B?T3U4K1JBNkJlZ2dMem9HT3NXNnk3ejd4aTlueWppR0ZxMjBKckYyWHF3K0RL?=
 =?utf-8?B?RGxhdFJzd2xlUmRaTHhOTzExTzdPNVoxNDA5UWJYNVhDZTJPVllzSjluQlgx?=
 =?utf-8?B?U1BPdHlvRU1FV3Jldk9BMFg2UFBaSG9IR2lYYnlrREhoaE9zbkxPVDBOQlJD?=
 =?utf-8?B?V3hPUEZybGtMSzdBelpQTU1zdWdaYXY5ODRNYTRuYnJyYTcweWk4L3hRdy9w?=
 =?utf-8?B?dS9ZbC8rcW1sRmU3TGJrUWJoWk1rRXNVTzdvY2JsR0RLSDlLWElSNjFqWTR6?=
 =?utf-8?B?OUpPTUNmVU1hRGhFYnBGeFRick1nd2hZdVdtOGduSmlKQnZya2ZUdTk4TUZm?=
 =?utf-8?B?cUptNEdIaGdXQmV1cGFkb1RjV3hRMEZhdkpleXNoTHZtbm0rTVNWV0M2ZVVB?=
 =?utf-8?B?NFIrd3EyelN5MHBycFRzSHNFSm5xWlVmd0kvc2MzZXpWblY4eWpLR0hDSHBr?=
 =?utf-8?B?NUJmY3JteXM1MEI2UG9iVDZwZlN3eFFnZW5aR3VQNFFGVTRCdmlLdXJpV2ow?=
 =?utf-8?B?STkrSjdiZXcvR1VtS05jZS8ydWg1bWNHRys0a3F5L0xiWUhaQlRFWDhnd1Bl?=
 =?utf-8?B?cDlWNnFkSzVFNE13TGcwTWhEai9mWUNhNnRCVkdJSDlzbi9XQnAyUS81elJD?=
 =?utf-8?B?a2luSFo3L0s0eFhsMkh4U3hmT0xSQUNENXBOMncwYTcrazVnUUp0ay9KUzFH?=
 =?utf-8?B?SnE4dE5hTjhFbjlvM05IalI5QWF2MkxKaTArbFpRN0ViNWpsalZtZnlnVnRM?=
 =?utf-8?Q?Dsp9m9ASoon3X0ZeW2srdWYDl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48628745-f4cb-472f-994f-08dce2f19f01
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2024 14:50:56.3360
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1xd52IG72cRUZpMsDz/QlwkyrX7bmWjP/Z3fgFCd74g2Z8DugpepE4TYdLBAoSNp6M49Le+7PR5fBnqzQqx5zA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9699

When the address is arbitrated at send address, the hardware can auto-send
NACK if it is an IBI. However, manual emission of NACK/ACK is needed for
hot join or controller request events.

Add help function svc_i3c_master_handle_ibi_won() to check event type and
send out NACK if the event is not an IBI.

Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change form v4 to v6
- none
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


