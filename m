Return-Path: <linux-kernel+bounces-292456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F914956FAD
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 18:04:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A20BB1F2249C
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 16:04:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A57188CC8;
	Mon, 19 Aug 2024 16:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Y1cXQShr"
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013044.outbound.protection.outlook.com [52.101.67.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69278188016
	for <linux-kernel@vger.kernel.org>; Mon, 19 Aug 2024 16:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724083354; cv=fail; b=rGFYF3chfop5X0dZH/5LMxzjv76Q3AMfJeOKoPkGgsIhdr1nKqbODnjeoANIsJt7FEKyw2bJ/yFVhV0Zc0pRsvIZonJQtwSvRct1aIh3buYOc5U2C1P90pFVWuABngJgdeTFoVsdH1w295jhSuHJW84r5FVpYux4unTKtWkH7LY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724083354; c=relaxed/simple;
	bh=eh2E0Be8sY7V85u59um2EkSafUz25sxM0/X2fX2jZpI=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=KidFlc9HPHNK9KGQJKvbFhno09yK8WKtwfVwf7mjx2TY68vVDLFBKLcRS+niqwgVdvnFsxM007Gbni0mFxThYiXFz12mjjkR1/VXxTw/e6VUKyMb15UilUiXvRkdd1Cs52zFX4/7cYl4nTEPcgjzNbeEKdjypLa7We1kG7kFpVI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Y1cXQShr; arc=fail smtp.client-ip=52.101.67.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AetfqVbMgicTBd+zAttqDtWxKoA5uq41q+yEu+d6BAYRHdDPnmFpNINI6C2R+dldvuZ4LJI3RVijd3kZIwtCwrlmsmpeX9l3M+ZeR4SlfVVFfFYqiIq9yZeGeKgV8FlOCwmUt+uG0qAOCdsmYwkXbi5yYopQt+TDKuOgtv/WXsc2jWp8fyapU5fcS+3OH5Dsjkgg7Qm/h8zoUqgKeuAXCruSh3rOCD1vCIYs/xG8QmPmvFEYmMM4a7qcaLHoFVe+lvhtHhMLnmW7UC/ZflfbYbykWZ2F+f2vW/hc7N94a7tKTEh1WdQJd9qTrJ7Uthw/kOHUnvOL1fMYR1Z0oMq9XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X2ZAcKNPuQ4Cy7AYm+SAGciuweTjZACn9ZhCaMcypok=;
 b=bkqLH9t1HwvkoAApj73Is23J2GP5cc7E3vUJc/jeSqLRCfBBZ5qGc9D3daM+sgO44Kf+FFitiLiYateVgaHx6fVtlqUrMZPPCYqKKcKEtyONxvXet2shIUQCCtrIBP1v54jcz37U+jLybIJrJQMiYquHlr+5dm4syiM7C7DqAhMWQqoivdSU2ANZ8HUxqAunVYUJHl7r+Qyg+7va19JEoPPztV3ppmkGlP8lXVsh+R3qEQi3cfXGzpsLNFSe/cL0DU5QOIm4BDnvjnSA/NTvbIdGCm8GPePwzWCj2zt6CRdiZMc5lRvm8jGIUNiqVSwuwwBdQtncTYRu5ujDg7yQNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X2ZAcKNPuQ4Cy7AYm+SAGciuweTjZACn9ZhCaMcypok=;
 b=Y1cXQShrkEO9BVVRzW3Sx/Pr1NuChx+TbdqgDg/jeB3uaJakdHcucCwvOz4sOhotBM/fWGW09xbaEgvkU9P68gBEvgXKqk59tUAAFFpdRiQnxCbBzAtQFTkBdnKlmWrnR0e/C+TYgnFv+SXZcVX9SlhcGosV72MHrWMbzi0XLwZ7FD61C8G7IpDeyBbeCt4oJK514PZ9Kq8z+YsUzribslXQAgmEGLXSN72EBVR3TTcW95fvaTV5TyV7Br3PE41iJ4p/hmydDEJICWAzvqaJAcYNbB52GXuzUecOBnz6IPa9UcM1XFcbD+qqrj0cO3kQSnISs6UoQKs2XrjcZEdyZw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU0PR04MB9659.eurprd04.prod.outlook.com (2603:10a6:10:320::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Mon, 19 Aug
 2024 16:02:28 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7875.019; Mon, 19 Aug 2024
 16:02:28 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Mon, 19 Aug 2024 12:02:03 -0400
Subject: [PATCH v3 09/11] i3c: master: svc: use spinlock_saveirq at
 svc_i3c_master_ibi_work()
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240819-i3c_fix-v3-9-7d69f7b0a05e@nxp.com>
References: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
In-Reply-To: <20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Parshuram Thombare <pthombar@cadence.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Boris Brezillon <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1724083326; l=2350;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=eh2E0Be8sY7V85u59um2EkSafUz25sxM0/X2fX2jZpI=;
 b=a7JLHlKiUwfjI8lZ3CTMofCK5gTYMUzJACfZhPpJPZX2VCIhxGci6PHq/KKFxNyO2fjG/JaoH
 aWNeJ5iCtScBZtKp6F5z0spHp0c1otbnLV6tes6GJhGRUFsTYV/lh/H
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SA9PR03CA0005.namprd03.prod.outlook.com
 (2603:10b6:806:20::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU0PR04MB9659:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e891062-ce08-4c36-c333-08dcc0685358
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?M3pRcm9ldGZpYkppMStkN1VIUXl1MXBJVFpJRXF4c3Z5YkcwS0JvdjFPeC9r?=
 =?utf-8?B?MTFvVnFUSUpFT1R5emxGMUIxVmMxcStPcjlRMW1FVzhpejQ2NUp2MUlTUWJi?=
 =?utf-8?B?ZlJJY0NoaUhuelBDcHlMbzZpaEI1d2tpT1RkTWoxWjNBa3Z6TmJvMnRFQW1y?=
 =?utf-8?B?eXJYQjducWFWc0s1Z25VK0s2RmV6NGIvZkpJOXhYWTM4Yko0UGg2akhYOWRH?=
 =?utf-8?B?aTlPcGJUOG5ScFdtMitsNStuSDNydFZ4bXFaZkRnL1JHZXhlU2c3WldJdGdx?=
 =?utf-8?B?NmVFWTYxbXNoaGhKOHZybE10SWdiZW5JVElaTGo2TVZzSUs1bjdTM3F6enpN?=
 =?utf-8?B?cXhrNThuQlNxZlZWK2x1cEZieGdNYUxTSTFQNVJKOGY4Q2NXN043UHk4SEts?=
 =?utf-8?B?RVJqbG81VS9kQmhySUxHREVxdjN5K3ZBWmQyT1V5Zk5iN01PM3daSWxnaURx?=
 =?utf-8?B?WnJYSjhxUHduL0ZVczFKS3pmdUdoUTR4aVliUlBOUGJDanZQYVZTR1Y5aXZy?=
 =?utf-8?B?d3pKWlZlbEVUM3FLTUdIRjVadFIyeTBBYkdOZVlxblBWOTFhK2ZYLzNyUlMw?=
 =?utf-8?B?c04rNTVGMHRzaUdBelhsc0N0QWU3dXg4Rmt0VXlaRTNUV1VuOWRBeEVwUGly?=
 =?utf-8?B?YXVnaWhtTm43R3VpRHgrajZ3WnRVdlZTalFvRWozcGdwWWNkWXdLTVpReWMv?=
 =?utf-8?B?QTcxR3hJSFY0L252KzlBczNJaWN6VndMZnBUbEZKRVZXNkZEbWVTNUxKTWVC?=
 =?utf-8?B?UUg1Z3RhMFpYWmYyVzVCTGRicGp3eWtQZHZoMXJaTEJYSTYvd291Rm9wb01u?=
 =?utf-8?B?WkFERHVsRS9GVWROQTd1VWw0MzdlVzNGRUNyMEVpVWw0OUhDRnRZVEYyWDJE?=
 =?utf-8?B?dklKWWxkWUYxT3NkSVByNitPU2c1ckZMRFFTcFlMeW9saWRWZHZnY3hIcGpI?=
 =?utf-8?B?ejZWRTJxb0NUSjU5T3JXK2tFQlptMDBreE9JRXhMUEJ5dzlvU0VOVjNkRkhF?=
 =?utf-8?B?WEVWMWN5ZVozSG5FMVovY0dtV2lUNjhHR2t6dEdNek5PZ3ZaMk5LVjE2aXdy?=
 =?utf-8?B?MGpCOUc0TjZidjNqcjVlaVJPY1NFa2V2QjJUek5lMCtKbHI4ZEdmVXpDajNx?=
 =?utf-8?B?aGlraDFNS0xhMFZTOFQ4S09zZW1BeEFvcFBEenZrT3IxNUJad0E3QVBMK2FZ?=
 =?utf-8?B?REJBa0o4SiswbDhpOGQvL3NBUTBORlFIMnNsNkIwN2hRRXk2OHNza0dPbWJR?=
 =?utf-8?B?WFlZSE0yWG45T01pOHVqdDFBaW52dzlraCt2Q201SkdSaUZjUW9ncjVpT2RH?=
 =?utf-8?B?bzF4SjVsRWl1bDN3RFRrYmlyeHBQdDFkSExMTXFpRFQ3VU44bHZHa3RTUlBa?=
 =?utf-8?B?YzJiMlNtTUtYb1pSSldIdUJxdVUrWVl0OE1hT2R6bUVLQlZZbzFlNFc0a0dZ?=
 =?utf-8?B?R3hnWldEVG1RaWd1TWhtUkI4OSt4aGF3QWlTbHJ3REFTaEhUWVdnSWw1QnJ1?=
 =?utf-8?B?SFpXVllsUklvV25rbUY4QlQ4RzM0Mnpmc3pCNEU2aWFuS21JRXlaOVhuMFRy?=
 =?utf-8?B?YW9CZ25aNE1rZzdERDd6Z2tQUTdTZTJ2eUdVUzdkdDhNWis5N1JGa3ZUMUhX?=
 =?utf-8?B?Y1Jyc1d6UFJVTVdHT2FlY2JLTEwwT3hqNDMzRG5lRlRkN1RFTkZpektDcEhB?=
 =?utf-8?B?UzQ1emNJVDhzNDZTb3ZWd3lpSUVYZHY1YXBBS3paZm1CY2VwcVNPZUFjOFly?=
 =?utf-8?B?RjJORHBseTFDY1g4M2djeXdXVUJla0RuWlcwREJpMnNwQmFlKzZJZXdhTTc3?=
 =?utf-8?B?Q1FubzNqUUQ1OVNLczdpMWtFRkZMdUZxV09abFFhcDJOWlNZSEEzUzRUaXlx?=
 =?utf-8?B?R0NWNUpvWmhlci91Tm8wRnFtUlU3NzNDZ3d1dU1qQlZweXc9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?cFp6L1hvOUx5KzBKOStBdmhFaTJDZEFkRW9qTjBOWExRMHhiSUtTem90YzhS?=
 =?utf-8?B?cU1HdWc0T2U4Y01ZOUhPUGFGMTJxWVg3RkRZQVJPNG1wZTNsWnFBR3pia085?=
 =?utf-8?B?d2QyRk4yQzFYcFNlb01wb0FiVk9vQTlsQnloTzlveExyK0Zac1RkMkxqQXB3?=
 =?utf-8?B?Z1J4TVhiUnNRaFk2R2toaExqL05ueHQxdkFvZ3dZT29Yd21icEJRUVFMYjlT?=
 =?utf-8?B?WWNXNmt4SWY2aFBuRXZSMXV5Yk1SZk92N2Fob2xwTnhUVXNLcG51UW1GRG5H?=
 =?utf-8?B?aC81dEtmekJOc2dsQkVHMHhXYXJ5blhhVW9XcHBKKzFCa3N1SzdjdDlvTXkz?=
 =?utf-8?B?SUk1VmlSUGdaeGxuSXpCbE00cDFscjYwNk91eU9KUWJBZUQzMkt4ei9KcVpa?=
 =?utf-8?B?RC9XaWp2bU96TUN3QkNoTEVUd3ZhSDBrcVh5K0hVeXJtY1ppQjd1SWlNT3BG?=
 =?utf-8?B?SjV1emw4S3prc2F0bS9EZHZCS29tdUl3bTBYTWRHR1pINDEreFZuMjBEVGt3?=
 =?utf-8?B?M0NFRHg3UThuclliZnFSa3B5TGpBWW5oMHpEUUlYV2ZCRmJMWkZlTDlpdnpH?=
 =?utf-8?B?a093RWNQeEpqb0tkaXVQQ1VDcnVZTGRXeFNjNWZzb1EyNmRudGdvSmd3YUUr?=
 =?utf-8?B?dWFZdVlLNnFwcTRjNHpBMS9UeUI1Tnd6MVR6bmJmUjhXN1k3VTM0MGM0TWwv?=
 =?utf-8?B?SzhnZ0dJZ084V0NhM2dZSTVNUFpEVThBN3ZOOEp5MFJML1EzdDFvTCtLeXZ5?=
 =?utf-8?B?TGwxQmRydkFNdTZBRFh1MFJISzhTNUo3YmE3K3JIenQzbHJaK25IUExseWlQ?=
 =?utf-8?B?MHFGeE1GMUJrdFFGWU5aZ2FDZk9DQUp0UVZHMjRIbUFyWTB1ZXhBUzJPQnJY?=
 =?utf-8?B?a1YwbEtjang2OFJKcG9XdW5ORnc4dXZsSWVOd0h6NTJMZnVPaFVkQXpabUdl?=
 =?utf-8?B?NHpRM1NqcXdKN0FSbDRXSnI0QTFUSVhNQ25IQzlrOGt1WGlGd3pIamhqc3Zl?=
 =?utf-8?B?c1hXRHkyblRSVnloSDJkWEFGQXh3aDN2ODl3RDB1dzJhd3pvMjNVMi9wZld3?=
 =?utf-8?B?cGxYZmRvTTZjRThubDBvZ0hQL3d4SnZZRlVEdkF6RGRrcTFSN3ZLdHlVRTU0?=
 =?utf-8?B?NDJoNHQ4QTlWcCtMbFE0OUdTeHBYcHRzTHc4RDhOYXJRY1o5SEZtYS9WWlla?=
 =?utf-8?B?K0pxV3RxTlNwNHN5OGk1Qml5d0NKV3FRREU5eFZlSStIeUt1MDlpZzJjWDZa?=
 =?utf-8?B?dTIwU090MGRySGFtSkVCMU9LT056NlVmQVhMa2xWV0tOVkVYWHVMUGZ4MVpG?=
 =?utf-8?B?ek5SZzZKNFNWaFdMdnlUbGFuYXArQ0VPazlTUVVjd0RqQlBUZ2VSSjFqWEZF?=
 =?utf-8?B?VUlaS1dnMjlOWjZaREVIN2MzNm5lWUNUaWx1TEhibnRKL0UxaGJiZE9Tektj?=
 =?utf-8?B?N3BCZEFkTlRid21qZWsrRlU2Y0trMzlZVDQ5ODVuK0FDNFpzSGFJMDByMEUr?=
 =?utf-8?B?dG1sQWErKzR2SlRRZFJITzFFMFJCUnpVemJuaVhpN3N1ZWZQVG9TZENxMmxv?=
 =?utf-8?B?ajdGWVhWekdMWm1mdUNTbjdQOW9Pck4vMERmZENkaEIvazFpZEhUUVlqQ1hL?=
 =?utf-8?B?ZXNnbFI1ZU9qUEFtMjcrdUZ6VTRVc01TbUp2QzdLY3MxSlIvK0FoWG12UFhp?=
 =?utf-8?B?NFFoaHgvaWdEUFdBYXpXb0xSdGFOeW1aanBVbVZRTWxSTi84YWZMMUJqZ2xn?=
 =?utf-8?B?UXZCRDduNGs4SUZJZyszYWVybnhVRy8wUzBkNVJlK1dobzh2Y0wxcU9Yd2VT?=
 =?utf-8?B?NkMvb1FObkY1eEgwL3lrM1A1ZFc4ZWZOZ3poVFBxNTdJUlkrTGdDT0UycHU0?=
 =?utf-8?B?Uy9xWWU1OGZlQk5TUTUwWEdmZ1d6VWN5WHp0R29Bbk9XL290TDF5Ly9IMHJ3?=
 =?utf-8?B?NlJMVW82emxTK3ZjcFBnS3JOWVY0Sk9ORkpocmJRbjU3LzRGZXh6cVR4TExx?=
 =?utf-8?B?Mldab1FXQ1lKTlhyeVlTaXB3TFlseVdaZDUzQktDdzZrZzZUN3hTcEp4TmhW?=
 =?utf-8?B?U0pxaHloUjltRmdQV3hNRWhkMFVGSWtpR1M5c2J6bnRWZTk1SnlyMDF5R2pP?=
 =?utf-8?Q?6L9HzjjVelwtsfo/tZIhWWtjV?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e891062-ce08-4c36-c333-08dcc0685358
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2024 16:02:28.8208
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: r4qgaa0BI4NL3Zh+cvbHeUaxQnsoYqo/4n+lRZ54a5bcTc1QNul1qBaQg0M5LxqbCyq+MKYefG/Gn1D++OfL9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9659

According to I3C spec ver 1.1, 09-Jun-2021, section 5.1.2.5:

The I3C Controller shall hold SCL Low while the Bus is in I3C/I2C Transfer,
ACK/NACK Phase. But maximum stall time is 100us. We have to disable irq and
schedule during whole I3C transaction, otherwise, I3C bus timeout will
happen if any irq or schedule happen during transaction.

Replace mutex with spinlock_saveirq() to make sure finish whole i3c
transaction without stall SCL more than 100us.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 161ccd824443b..fbb6cef405577 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -432,7 +432,16 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 	u32 status, val;
 	int ret;
 
-	mutex_lock(&master->lock);
+	/*
+	 * According to I3C spec ver 1.1, 09-Jun-2021, section 5.1.2.5:
+	 *
+	 * The I3C Controller shall hold SCL Low while the Bus is in I3C/I2C Transfer, ACK/NACK
+	 * Phase. But maximum stall time is 100us. We have to disable irq and schedule during whole
+	 * I3C transaction, otherwise, I3C bus timeout will happen if any irq or schedule happen
+	 * between transaction..
+	 */
+	guard(spinlock_irqsave)(&master->xferqueue.lock);
+
 	/*
 	 * IBIWON may be set before SVC_I3C_MCTRL_REQUEST_AUTO_IBI, causing
 	 * readl_relaxed_poll_timeout() to return immediately. Consequently,
@@ -452,7 +461,7 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 	       master->regs + SVC_I3C_MCTRL);
 
 	/* Wait for IBIWON, should take approximately 100us */
-	ret = readl_relaxed_poll_timeout(master->regs + SVC_I3C_MSTATUS, val,
+	ret = readl_relaxed_poll_timeout_atomic(master->regs + SVC_I3C_MSTATUS, val,
 					 SVC_I3C_MSTATUS_IBIWON(val), 0, 1000);
 	if (ret) {
 		dev_err(master->dev, "Timeout when polling for IBIWON\n");
@@ -525,7 +534,6 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 
 reenable_ibis:
 	svc_i3c_master_enable_interrupts(master, SVC_I3C_MINT_SLVSTART);
-	mutex_unlock(&master->lock);
 }
 
 static irqreturn_t svc_i3c_master_irq_handler(int irq, void *dev_id)

-- 
2.34.1


