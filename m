Return-Path: <linux-kernel+bounces-236521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 031F691E35B
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 17:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DAA4B27675
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 15:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D94016EB7A;
	Mon,  1 Jul 2024 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="oA/bwQJI"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2085.outbound.protection.outlook.com [40.107.249.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA7016EB5A;
	Mon,  1 Jul 2024 15:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719846261; cv=fail; b=W3Xq+UHP/C5KQXEKQJJkMgechhtHhpXomn01pyL8/E5xYuRJXFuvlxXTDF4UdFoHWC8sS8VrrtAaRS0jdwwKkm/WYq4a6GdgKLlkuBB2lJUR3LCugd/OmyeVQoBrGcn0vuhot4dfC8raooiKTK1rGKBrdxHjeb5m63rzL4GMnh0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719846261; c=relaxed/simple;
	bh=rhHOnBdLWO/Nj1642+iKpqwtg1DgGHaLd4UhUTEaXtk=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=gGcT86pH37c+6uLkjA6Yhh1MhBeZZVaEMyyavC/oKKWadTCqCCrFlOn0ArGCLOf0d/++j0kq9hTwIApNd6Hqxjp5pvWD5Jxug9EIyHH1zMqLyOXhfOPwBaJSiLWE0fK2od/7w0/GP7NnZs6egK+jExWLVZoY/EngFNeFCzOjqjA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=oA/bwQJI; arc=fail smtp.client-ip=40.107.249.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KPKm7upRF/KHfXk1WHpbh1DRw7ndocUh3LRSoXhc53i2pKgRsQH8gGNoOmLZvVuHCSwIYuVRWJHPp6H5hb8d4uxFLoeIQc2zx8/jf/Ju/IpQNZsj+rN77+rnUGPa2zy7NoVIkCleSYJpuFmFYUHVGxDPG9G3skaD0h9yuZC+7R/S8kCa80IVZUOBXbgFJyCxTt3DqYaS52i9o8IfGReZkZ4hmAyM6ULV+zR33XD4K5voQUup2MxBn4lTpcg+fA90yOYULabF4PEpvE9A9cMPiQJmI0bU1rXIHl/fI76ukShqdRRXuk2vmqILItb1GYsHRWGQtFnbRqohZqhXhNvRNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lOJI1iaee9Jymwz8AJUUbGkJ/EcdSWtdrfuapCt0PQ0=;
 b=HtgkqCVpwg/117uyVEWfxtKGYxOLPe5qYbE9e0t/+734kvgInSKyW22Wr+YpvWrj3JuNNxJXtvocm/tJPqRf5n1rahwJBkQWmENTQk3Rl1xNpz+3R+rdPpiL597PgyKAcohxsn73ooSWqDvJOYXC24BRv+fTU9N0ni1ad+7ijI/zyK9+lAR+h5oozaYQ1Ekh9eSo7hX/XebgskoFSS77yysTCsjO9tB2YmBMBPKevt1g6oJccv0HSVYt9uVDNiXb9O2h3Ce9I2ysBaynxZ4DvEqfYzPlfL8u85zD6+0S1NPgYPrpK3rf0bz+SpmnHZArikQkHc9yXsomzEhQJIY2Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lOJI1iaee9Jymwz8AJUUbGkJ/EcdSWtdrfuapCt0PQ0=;
 b=oA/bwQJInYPi8oliMRPHR9YrXnCANND5pdQPy4WRj5mAGeiT1RDq3gHyEqnsHDSlvFSg9atWzQ5Rj0EjVxQs59ElQgooZsiIMsLBh3rRd/bHXxvE3smyouNdd/xO2SHd7GfFzL7ECEEktjsKc0uGjS9ZbmdIzYWBwZI1QoV4cig=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8169.eurprd04.prod.outlook.com (2603:10a6:10:25d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Mon, 1 Jul
 2024 15:04:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%2]) with mapi id 15.20.7719.022; Mon, 1 Jul 2024
 15:04:15 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 01 Jul 2024 11:03:34 -0400
Subject: [PATCH v4 8/8] arm64: dts: imx8qm-mek: add usb 3.0 and related
 type C nodes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-imx8qm-dts-usb-v4-8-03cdbc8c44b6@nxp.com>
References: <20240701-imx8qm-dts-usb-v4-0-03cdbc8c44b6@nxp.com>
In-Reply-To: <20240701-imx8qm-dts-usb-v4-0-03cdbc8c44b6@nxp.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Dong Aisheng <aisheng.dong@nxp.com>
Cc: devicetree@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719846224; l=2977;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=rhHOnBdLWO/Nj1642+iKpqwtg1DgGHaLd4UhUTEaXtk=;
 b=oXnnujpT6Om1ct0gNnJMuAjEEA0SJVu+7FbfnrxtVOLrrKlclX/26q8QVl6Ayiq/2KhjP17wv
 CZegtIMIZDWDVQFpTwU3sXXFUXcB4A8NdHpX7vbaxDr+bwr5fY8QdBv
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR13CA0149.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::34) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8169:EE_
X-MS-Office365-Filtering-Correlation-Id: 31b1cf78-2a9a-4acd-c2fc-08dc99df1310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q2ZyM0RVWG8wejc0eHNtS3dURkExSlhWdEpEOC9iVUtHekhuUUxDVDVFWkhS?=
 =?utf-8?B?WmxQMmZGTWRVd0NoMDNEN0NMRTZ5RmQ5TDE3emxOT0lYK3ZxL2ZtbzFwK1Y3?=
 =?utf-8?B?K282aUs5dHFrVTFybzBJN3hHRVAweHZhSERCeDlUS3pSeDlHVHplekZsNEJV?=
 =?utf-8?B?bVByK0lxd3BXREtsZVhPSUs0clFENjJtL0QrL3Y5bGJzNHlmZWwwY0tFbWtn?=
 =?utf-8?B?Y0dzaXJBbkdKaDFjUmpnOXZBS1pVeHU1Nitqbzl2eFRTWXg0NHZyUXBTMFJz?=
 =?utf-8?B?TWEvVzIvYkZrNm4xb1dZZ0owbXhJaDJlR3lZWXYrQjNOTzNaamR3ejM5eU84?=
 =?utf-8?B?NXB0aWRDek9WbmhDQnZvZ20xdGptUUNabW56NStCRVA1UmNsVmFPd0JIOWFn?=
 =?utf-8?B?dmxqVU9HUTlrQU1qWW0zUzk0M2J0OUdGYmxBL3lMVlFITDY2dzl2ejd1KzVR?=
 =?utf-8?B?T2V6alAzbDVDNHMrMnlKVWZFVWJpM05GQ3JVKzdMNitpTWRZcHZYTE1vNWp6?=
 =?utf-8?B?ZllmVTNPNCs2Z08vOVNySDUwWmpzdGJJYjVHTFhYenhUOUEwaWx2WUgxYlZY?=
 =?utf-8?B?RFYzRmlnbjlodXFSTFlFZkNDRU5tNzhFV1pTVW9Yc3JOWEZJNHphZlFwNHB4?=
 =?utf-8?B?QzRMRlpDNlhkeGFGQkc4MGxaNkpxdWVISE56amRkNEl5TEdtU3pkNS81ckc0?=
 =?utf-8?B?T1FoQjloeVNwSmg4NnBsSmY2cVRPeVJvV2oxU2hkMVhEK1laM1dUUkRUZkdE?=
 =?utf-8?B?cnIvT1o0R3ZDc0VjWXdCeXJNUmpRVDV3eTJleExRMmQwNkFVTTBDd05VVnRF?=
 =?utf-8?B?Wk55TGMzTGlJYldiZ1BTN1pWM2dvMFZnd0t3MTNwNExueThDckU2NFhodFZW?=
 =?utf-8?B?NXBQaXN4RlNuUTc2RHNUN0ZoRHIwUDVHK0MzNHFVeEZISXE1WnNLZGp5aElu?=
 =?utf-8?B?TkNxdFRQY3VqdnFLWmlST3ZlQy96QWhqd0E1VzFnL0ZhK3V2QTVneG9rOW1h?=
 =?utf-8?B?YkVSUCt1NS9idnB4eWZNc3JHOFRES0did1I2MGRzUzRUdTBLWEJsajJKbGN6?=
 =?utf-8?B?c2k0OHoxUTBsazB6S01walF6MjdxS1JnTVdFM0c0WGFTRkZiS3FiclBBd1Ji?=
 =?utf-8?B?WHAwT1ZTb3pIMjhkcDVRM2lqNG9XNHVjSXZKTWpWRWVkQXNndW14eTlLNjZ6?=
 =?utf-8?B?WEdCR0tNUWxORCtkZ210K3cyZjZlL0VZYTYxRFF4YUlWUDhhaWxlM0FBL05G?=
 =?utf-8?B?ZGlaNForWGw2eWpRQmhIV05mWUF4ZjExNWxQczZ5Zk0xVzJmY1hYTVlMeW5z?=
 =?utf-8?B?blpYUG9jTVBxQkh3LzRCeDQrWnRmSjJ0R3l4M0VEaHZpdjF2VlNIMWdURmFL?=
 =?utf-8?B?dVc1Zy9GZnFOazhvZ2VNeW05Q0ZDMGIvR0h1cElUZm5ackVzNWtNN3dnRWJp?=
 =?utf-8?B?eldxZDZLb2Q4MmF5bDlNU3RQeWYwanZoOE5kblh4MEVYUTNtSWU5SkNGcW1Q?=
 =?utf-8?B?SUdiU1BCZ3pxWEM2MmdIYUQrRmJaNE1IUUs2ajc5M0hZakFHNWxBOWpjUW81?=
 =?utf-8?B?dWdNOVZPb0VPM0g5M0dJYWwxcWZ0bHFPMndzYU9EMGVKbHV4NE4xd05veEpm?=
 =?utf-8?B?a0R0bFQxbEFNc3I4SU5DZEJLUnhUajl1ZDlWRERKTU5LYjdGODVrOWQyRENX?=
 =?utf-8?B?aTI2WGJzOHpYQ0lKeGJxT3JXTlV3cGltVnBQbk1kS1VjcVkvOHZvV1hxK0lk?=
 =?utf-8?B?UW1kcE9xVnFIaVVxd1p6VGpKM3dYZ2ZSSFkzUHZNSkN5a0FyVm52bUdGam03?=
 =?utf-8?B?Vnl2VjZNb2k5OHBKSkFjU2pOdy9MaFhBczZVNlNFaHNRZUlIWXlOMXdRc0g5?=
 =?utf-8?B?bW5IV0xPdmRRb1c0d2UvTVZPYmdXZmNxam1vOERSYlp0Qnc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NGdKOGp3ZGxPY1ppNkttVnpVcGk5a29NYnZXZisvOHl6U1VFRU1yZklXcHBG?=
 =?utf-8?B?QkQydDkxazBJVVVVQUFDYlFObHlKelBRR3NGSVdQU3FVbUZRczVDYnZtMExK?=
 =?utf-8?B?SEtqZ3BrSVBjMmVBWjlzWGppclc3YXo2aC8xbzArYk1DRlkwT29kUHZHMjJh?=
 =?utf-8?B?ZmVmMGdIaDNUYmFWcTFVVUFGcWRBaVgxNzZqN3RwSlc1WVZEOXdQOUxuVm5E?=
 =?utf-8?B?Z2FjRlAxcDNHTThhWTNZTnlldUNOWEhIdUFDTUlXMGNqYzhEbG9HK1pzS3p5?=
 =?utf-8?B?VXZtQUpaZG8waXdGTUViVXVZWHlDVGROa2h0U1Y1RERMSGJtdTdjWi9XUDZZ?=
 =?utf-8?B?YVVBQWRkck5JMEFmc3lyUFBSd0ZublNFNHlmc0t2TlpRSUYvMmtHR2U2TVA4?=
 =?utf-8?B?S01ORjdHQ2pIVno2ZVNoOGxpYkJoVWxoZzFmZFphYllXWDZJRXJnRWJNRDF4?=
 =?utf-8?B?RE1ZNlVmaVRYT2tLcmNGZEJtQVJPamR3bkJFMzR5NkhhMHlkWTBNTjBBREd5?=
 =?utf-8?B?UkxKamJqUzhydmcrcW1jQ0V4eTd1MlBuZ0JKTFN1TnovdmtEaGpZSm1TM2ZT?=
 =?utf-8?B?QTE2Wmk3bDRhSlJ2U2tWdDJDWEZZOTQ3ZFBCYXdscnptR2Z0TTljRTRJYVBz?=
 =?utf-8?B?RG5mZDhrN2tUM25vM3R5WkdzYkEvMlc2bE96S003UlJKeEg1UmpRanNOdUJS?=
 =?utf-8?B?L3dFa0FRUHJoeDl6SllXRVlXVlRzM0g4Nm5RbHN3MWVPV0lFM3pvNkNJRHVi?=
 =?utf-8?B?V3FSV2ZpenA4ak80UGNIWWhKTFhyV285NWU2bGRVSkJWZjgzNTBNK2dRMW5V?=
 =?utf-8?B?aHZLamJQZlI5YmhFVFl6Njl3TE5UaituUDVmZFo5ZGh0M1l1dER5dHQrZ3Jz?=
 =?utf-8?B?cGlqakhuUm9ON1FYVmg5YkpnU0FyMjVtR1MvRmlZOUo4Q3FkMWNMV285Wm5L?=
 =?utf-8?B?bGoyTFlzbjdpY3FZc01SdUREVDRSOGZWRkU3QnF4c25CaDBvUmhKU2xRbG1q?=
 =?utf-8?B?NStXeEhjMTFuZWNnV1gvT3NBVkZhN3daazg2cSs0eUFLbFo0cCt5S3E3Q3pN?=
 =?utf-8?B?V3NmZmd5blBueVB3d0xuT1Qvb0ZDRkE4ZmpVeWtoUU1ncU5JdzBxVDNRYzd4?=
 =?utf-8?B?TzFLVmlIb1MyL0EzRTJReWgrZ1ErK3JFa0pZMnZXMUozZkg1blRDZit3MW9Y?=
 =?utf-8?B?blBpVnAvMjFYY1R3V0dpL25XQi9PWDRMS2RxRlBWckg4bmYzMUJTa3plVVNz?=
 =?utf-8?B?a05XMVI0WE1vZkd4N2V2S0x0SW5ucEpaUUdPOWNPenZrSmZFc0l5VENvSkhj?=
 =?utf-8?B?YkVyQ0U4SkxmUnBQTGlaSWFZOWJITFZVZkRDV1FndGN6NFhQTlJNR0xwTVBZ?=
 =?utf-8?B?cnowbzI2N2FFWTkxb1Z2V3docHVCNHFXdE8xUnkxdmdmUE5ZWnBqSnV6OTdo?=
 =?utf-8?B?aVA0RGFBcXEzMHZoSUJCWW9lQTltQ2trRlh0WnFFNHBWZ0ZGVEpXR0hlNlBo?=
 =?utf-8?B?U2F1Z3pFTnNFendaK21taGVLMXd3aHJjbFM0WVQ1S2lmMlNUcSsxVUJ2dXlo?=
 =?utf-8?B?MVk2LzdVRzdwc1luYVNLL3IrajU3RGI5bXpRSWJoQ255K1NaMUlsYnRqMHR2?=
 =?utf-8?B?N0hJbWJjaFFQN3JXRTFvM0pKVU9TSlFneG1GeGJJeW9xVFIvT21tU25IeGgv?=
 =?utf-8?B?b3hxNjdjNGZOYkU0Vk1wWFVtZi81bXZpdWhNcnhObDYzRHhHWFg5YlhmMlFZ?=
 =?utf-8?B?dC9rNHcxRHU5VVE4Ull2SGtnMi9IWm1pSmo3NUZhQ1NGeUdIN0ZoNXNlTERJ?=
 =?utf-8?B?T3dnY1ZaTkVwYXJzTmNtaHJhMFFKL1V2WDFJcDVtR1NGMkJSSHE1RUVZelhq?=
 =?utf-8?B?Ui9VcW9SRDBCNmpVTm1CWUZ4RkpBVEVTSDlVVXVFQi9vMktBVzJlcXl4OHdq?=
 =?utf-8?B?bEg0bDV4THZIWXZUQnVYdzN1NlJ4RHhxVlNnRTZGbGF3MEZDbFViaktIUmN2?=
 =?utf-8?B?dm9tOThRN3Nod3FBLzZvd29LK043SFJLVWxZK3l4N2xXTXFJK216MFRUNWVq?=
 =?utf-8?B?U0ZkN2M4SUg2SGo1NHhMMzYwYVA3R0F5WTdpbW5PeEpRa0VXaitXMmx5czBv?=
 =?utf-8?Q?txXCr2tw+XjKHmokelJvqROaA?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b1cf78-2a9a-4acd-c2fc-08dc99df1310
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2024 15:04:15.7131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: crML+HwWYs6XxVVzTtGmJcKwrG2slyxhUceI5HBxVAPP80ikUrlo/eZyDzmthkn2ELeslQvcclZfZUXKxgFsdA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8169

Enable usb3.0 and related usb type C nodes.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm-mek.dts | 87 ++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
index 7ceea79f658db..aa874576e974b 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
+++ b/arch/arm64/boot/dts/freescale/imx8qm-mek.dts
@@ -6,6 +6,7 @@
 
 /dts-v1/;
 
+#include <dt-bindings/usb/pd.h>
 #include "imx8qm.dtsi"
 
 / {
@@ -109,6 +110,21 @@ lvds_backlight1: backlight-lvds1 {
 		default-brightness-level = <80>;
 	};
 
+	mux-controller {
+		compatible = "nxp,cbdtu02043", "gpio-sbu-mux";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_typec_mux>;
+		select-gpios = <&lsio_gpio4 6 GPIO_ACTIVE_LOW>;
+		enable-gpios = <&lsio_gpio4 19 GPIO_ACTIVE_HIGH>;
+		orientation-switch;
+
+		port {
+			usb3_data_ss: endpoint {
+				remote-endpoint = <&typec_con_ss>;
+			};
+		};
+	};
+
 	reg_usdhc2_vmmc: usdhc2-vmmc {
 		compatible = "regulator-fixed";
 		regulator-name = "SD1_SPWR";
@@ -321,6 +337,44 @@ gyrometer@69 {
 		compatible = "st,l3g4200d-gyro";
 		reg = <0x69>;
 	};
+
+	ptn5110: tcpc@51 {
+		compatible = "nxp,ptn5110", "tcpci";
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_typec>;
+		reg = <0x51>;
+		interrupt-parent = <&lsio_gpio4>;
+		interrupts = <26 IRQ_TYPE_LEVEL_LOW>;
+		status = "okay";
+
+		usb_con1: connector {
+			compatible = "usb-c-connector";
+			label = "USB-C";
+			power-role = "source";
+			data-role = "dual";
+			source-pdos = <PDO_FIXED(5000, 3000, PDO_FIXED_USB_COMM)>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+
+					typec_dr_sw: endpoint {
+						remote-endpoint = <&usb3_drd_sw>;
+					};
+				};
+
+				port@1 {
+					reg = <1>;
+					typec_con_ss: endpoint {
+						remote-endpoint = <&usb3_data_ss>;
+					};
+				};
+			};
+		};
+	};
 };
 
 &i2c1 {
@@ -525,6 +579,26 @@ &usdhc2 {
 	status = "okay";
 };
 
+&usb3_phy {
+	status = "okay";
+};
+
+&usbotg3 {
+	status = "okay";
+};
+
+&usbotg3_cdns3 {
+	dr_mode = "otg";
+	usb-role-switch;
+	status = "okay";
+
+	port {
+		usb3_drd_sw: endpoint {
+			remote-endpoint = <&typec_dr_sw>;
+		};
+	};
+};
+
 &sai0 {
 	#sound-dai-cells = <0>;
 	assigned-clocks = <&clk IMX_SC_R_AUDIO_PLL_0 IMX_SC_PM_CLK_PLL>,
@@ -791,6 +865,19 @@ IMX8QM_SAI1_TXC_AUD_SAI1_TXC				0x06000040
 		>;
 	};
 
+	pinctrl_typec: typecgrp {
+		fsl,pins = <
+			IMX8QM_QSPI1A_DATA0_LSIO_GPIO4_IO26		0x00000021
+		>;
+	};
+
+	pinctrl_typec_mux: typecmuxgrp {
+		fsl,pins = <
+			IMX8QM_QSPI1A_SS0_B_LSIO_GPIO4_IO19		0x60
+			IMX8QM_USB_SS3_TC3_LSIO_GPIO4_IO06		0x60
+		>;
+	};
+
 	pinctrl_usdhc1: usdhc1grp {
 		fsl,pins = <
 			IMX8QM_EMMC0_CLK_CONN_EMMC0_CLK				0x06000041

-- 
2.34.1


