Return-Path: <linux-kernel+bounces-203948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DCC8FE2B9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 11:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 257F7B2A19C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 09:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E4413E8BE;
	Thu,  6 Jun 2024 09:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="Mfe8kNA8"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2137.outbound.protection.outlook.com [40.107.22.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EDD13F43C;
	Thu,  6 Jun 2024 09:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.137
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717664653; cv=fail; b=Tndul5aV2BH8Q5ln3Qs3k71dhNiztYgxmNwbSbW/6eQQGxRkCa4DvBtrMCwzVWaLErpGhPY6CBRLSFdhn0KMLQ3SjKHsxsY5acV+y8FisM1/LO80aD9KpgDEJBb9QaGS1H4cqxAspr8GBNaPsndcYJYL+nQE4Zs4yolJsYSOLS4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717664653; c=relaxed/simple;
	bh=/bvpjmuTI73t9Y50sKoIVGe6v8d3c15b5jQEKsWXO6g=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=J3U8To1embw1OO6Nl/dqdSPV6qxBS+f0CTCyomPgNTQ5QNWwh+Q7MqDK5KCZXCxVQBJfvJ5XTPOOstOMiWqhjvUyvUc9T2e0FOyK77Bvi+K2fFw7HuIQg+WcUaiyfTjr9KKc7xLlB7dNp49exIBeCx3yr/8vMe2E7ADQPYmEXCQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=Mfe8kNA8; arc=fail smtp.client-ip=40.107.22.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D0EafCGd4TYE7ps86p31XWdT1gkhqR0oxOFguEHrHUBjOSb6WBkcitdRiJL/dbaAJv0Kw3SEUcy8TXarSUWOf2iRWkb9GtWzB7DBJe7W6ydaOeOkkxMS7WOHQxC8iuVhnph/ITJoj2v0aikOPU0nWAe1NWGF93N6SSJVm7kr80kmYDN+jkDHl15fE/RYlo7rY9NUxQCZ1dT36sRIH3OYXGHvgvQ8VMDvluo0edY/KRjoKQUKDYAVHMyS2cpmzvnNA6tLeZmnDg+yRgBjOo6IdBHdtMR1PTFHn4IqJT+6fQwPT8HKYG821ecLtTa52ci57A8+gzfv0WC+KdxIQCfqLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0sPv/kgzthBYwBq9wWhLcgJfqattFC5Ri363g8RG+s=;
 b=bbqHXrGym1JJIdRhMEaJN2PTM1xqVL51r8XWFNA85VHUwZyYwqj7ZrL//FEbQTgiMO4lrW3kTHs1B3BVk45TRCT3I9q8kIiIDjxe0l8tdBCsw06/0uwp3a6io0TZCgnE6Z7HUf4WPXAzCVdd6SxbdrRBqMLJFS7wmkh9zJJpCXRWOPGfY4B8QIN3TsQSf4C09VHbFB754Zde9aXEqYrA+pWVuLncDZZAXpIbPk/fhaJyfPMicrQRWv5en8X0JMJ6GMYpH6ANXwU/IIxtM6wE3A6en2YKif+Tint1lxTqYbcdRHcPfU4Iu8zG10rAj9CtrxnLgE/Ae9TWgASU/v46/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0sPv/kgzthBYwBq9wWhLcgJfqattFC5Ri363g8RG+s=;
 b=Mfe8kNA8MnhORslnyJW2ba+tsUavRNxPtrQZjcT0BTbkaZLR+OeWdvXujiRZBn3ObdzZ3nlAQCV0oyh5gSZldVm509sBBUMF3LaJ8KAGzsVPDrtzRtILFy7fNIvPI0kc4Lxmxc5Xn7imhgbhmbroQrasqjDPZSDbiuFRUxadnFE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by DB9PR08MB9513.eurprd08.prod.outlook.com (2603:10a6:10:459::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31; Thu, 6 Jun
 2024 09:04:04 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::a08:11be:8709:f5e1]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::a08:11be:8709:f5e1%4]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 09:04:04 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Thu, 06 Jun 2024 11:03:57 +0200
Subject: [PATCH 3/3] usb: typec: tipd: use min() to set tps6598x firmware
 packet size
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-tps6598x_fw_update_log-v1-3-2b5b8369a0ba@wolfvision.net>
References: <20240606-tps6598x_fw_update_log-v1-0-2b5b8369a0ba@wolfvision.net>
In-Reply-To: <20240606-tps6598x_fw_update_log-v1-0-2b5b8369a0ba@wolfvision.net>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>, 
 Julia Lawall <julia.lawall@inria.fr>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717664643; l=1069;
 i=javier.carrasco@wolfvision.net; s=20240320; h=from:subject:message-id;
 bh=/bvpjmuTI73t9Y50sKoIVGe6v8d3c15b5jQEKsWXO6g=;
 b=rItKa9iubWFufBYxSWm3roOl9DhE7SOTQxKGq428uU59ImBcxOIMUFYbYzbZ3wxucnyPyl1bK
 B0Q+qwA7qAXDBnqhPYkS/59J6l17DKOK/7cEYVanpJDeEEG/rDwd0s0
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=Vxk2/0sGIxM8rsKnceszFuSuHVfQwa1Yo8+is7BX2nY=
X-ClientProxiedBy: VI1PR07CA0310.eurprd07.prod.outlook.com
 (2603:10a6:800:130::38) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|DB9PR08MB9513:EE_
X-MS-Office365-Filtering-Correlation-Id: e8150fcc-12e0-4735-f2c3-08dc86079d54
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SUpQZWtHNnZyYnd5YllHc216TEYwMmJMemhMZVcvMmFvc3VQTlVkdmJFa2RD?=
 =?utf-8?B?eDNpWUd5ZTNLYjhBV1pLZlhrMFNVaHVwMFpoaHczRkVQUThiSmtPS016M1g1?=
 =?utf-8?B?dlhLZzhEdVh2NUY5NU53NmQ5QWdmd2dmZ0FtaDdQdjlRam5BQ041dDBrTURp?=
 =?utf-8?B?WURpVjc2OHE0d0pkdXBvVUE4Qk9qMHdtbUFPUTI2b1psSnJ6T2lVWFliNGxB?=
 =?utf-8?B?aEpBVzEyMC9sc0RJQzh5ZkJtbnpUTnptYVordHA4Z2dLVVdMbytmcTVEMEFC?=
 =?utf-8?B?NjFRc2JwdDBVRFFJTDVBZWtQQW0rajVWOFdGcnZnWkhSKzV1NE0wV2ltdVM4?=
 =?utf-8?B?NWxjdStIbE8zeGZqVElVemwrK1dUOVkxYmdnc2V4NGdGN1VGeXlpODg3M05V?=
 =?utf-8?B?M0lCaWN6c2U4N0hBdkk5RHBrUitwdzlnblBTRml0dWlBc2ppWVdsQVYrWENM?=
 =?utf-8?B?ZW5na0VtRWdxdk1VUUplTFd5NDJMTVdVQ21UZVppRnR0c1RNTGJRU2hmVTZo?=
 =?utf-8?B?M012NW84U0VrbmRYSVFYVDlCM0RzYWZyUllqRXFuOXEwdldVbk9jZklBakor?=
 =?utf-8?B?b2FYTDNwYTN4ZkFuOU9mbDQ4N3R0M0IyV2lqM0NQVDhmdFJ6TEVsZ2lEb1Jp?=
 =?utf-8?B?UEt4WVlub0Vpc1lKUFpuWi8zaldVVWpmZmdDcVJiNG1GUkpZUTNvcXBGL3J4?=
 =?utf-8?B?Y3ZRUnJBM1haZTJxZ2pBcllnZU1ueG9aV0hGNUt6bEVaSG0zTlUzUWgzMmow?=
 =?utf-8?B?Y1F1eG5PcDFIS2dZOTVId2d1OUMxckttdWg5SXZBVC83S2FHdVBWbnZDV0RF?=
 =?utf-8?B?N2psT0tZTVFDNGdncU1UY0xFTW5qZ1VaditLL2N3TWc5WUh6cjJhS0xRcnlt?=
 =?utf-8?B?UFl4cVpSOE1DakdvRFdOT3RoUXYyN1AreWU0NGkxUWYrNm1mai9UYW1oMERr?=
 =?utf-8?B?STBONGpJRWR1SldHajRDa3pxWjhkTmRKZ1pVd1I4Vm1zTkV4SU8yTEdUR1d1?=
 =?utf-8?B?Z0J2OFozZlhQeUFNR0VqdDU5a25vY0ZSNmZVblN1K1hXNnhleWtkTWVSTC9s?=
 =?utf-8?B?V0cxY3pWQnhQeml3QmNKNUQrMGcwRHM1T2lXcWZMRk9PSXdFTjJ1UTFuSXNm?=
 =?utf-8?B?am5mQk9DZ1BhWkMva2UrQXZxTmF1WjQraDJJSWxvd01TSUlDdXRSa1VBNVQ4?=
 =?utf-8?B?ZW9IZW44clVITVZSRVdVR1VoTUc5UHg1a2QrVklSaDNsTnpPM1hNY3Y1RGJp?=
 =?utf-8?B?MWJhUXpaSmR1eitYVHNNTDdreUY5RnUzRWNrNGduWHlESzBmTmpQTkUwUG5V?=
 =?utf-8?B?TzJCVkp0Qm1qc28zN21YalBmMG8xRHMvcE9pb1V3bkk3ZnlNdjcvSnBQTTdv?=
 =?utf-8?B?VzUvcER2WWs3dENaLy9GZDFMSjFHdUVqbE5yZmhyVmZvUGFGK1M5WkFBY0Zy?=
 =?utf-8?B?TXdsMWhSQ2NqTXRPdVRxQ2dibGhxWmlrcHFtMFRUL1hKUWh2N0Rxc1pyM2U2?=
 =?utf-8?B?QjRlTXRkYUJYMk1NTW1ibUwvWGZqdXJJYnFqM3Z6NTJkS2V4WkJlYjFEbEIx?=
 =?utf-8?B?Nmh1MkJaNU02QXZQU1lXQ3Nic2JnZUc4cXl2bGlkdFM0M2dPYjZCcHhQaFFH?=
 =?utf-8?B?bUxEOFhlUk1yVkhXWVpRbjVkcFBRZHBtdVN0OHJiQTFHS1FHYmt2bUgwczd2?=
 =?utf-8?B?ZjVDTmdGcVUvQnpKa3I4SS9zSWxDeEx2WGtRYTVWa3h0RDBpTmowTDBoUDZH?=
 =?utf-8?B?akRHNTFPa2lKcy9zWVlJczlNN0dabGR2U21pYWtobTYzRVo4YmVXS0hFZE03?=
 =?utf-8?Q?StM0blWGQBtAFbsRXHWV2Y0229K4DmHOWIYjQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVVNc1l6Z1FNR0NoMm9WMUMxSFJ0T1BkbUc4VHhxcW8wTTdZcGZ4cXZGc3JV?=
 =?utf-8?B?ZHRKd0xWN0hGOTFkK0lqMnRkRUVJL3llb3JjYjJDejZhV3MrUFhjd2VBNG4x?=
 =?utf-8?B?OU53czhMTFlKWFJMdEJzOE5KcjYvRnFBbjRQQnQvRWMzMWk1SHI3bmd0YmUx?=
 =?utf-8?B?REZqYXEvU1Q3cTc5VDN5VHAzZmZQM2ozLzZ0UUpTUldWTHNKMXVMejhXTWJm?=
 =?utf-8?B?L01lamZPSk0zV2RWd0pxendNL093UTFUUUt3OWdKaTQ3bUxTamVOZm9qM0Rk?=
 =?utf-8?B?d295czN5R09LNHlldDREZ2d6VmtoY2J3OXcxU3JGUkNZcUlFT2lBRU5IdGF2?=
 =?utf-8?B?bHl6SHpBK1hMbkUxN0JIOHhTTStSbGw0eld6MDhid3FVcXNnanVkemkzUXVI?=
 =?utf-8?B?ZDJ1UytQSDdncVB5NStsYkc1TGE1NjZpcitBQnVMUSt6SjNmNTZoVkJaSlZR?=
 =?utf-8?B?Nk50WnB5dDhNYVA4UFdIVDFiQ29sd1JSK1FFb3hrK05idUt5QXR4YzFVZFVr?=
 =?utf-8?B?dWZVQ0tubnRGVWora1FKdUQvcVNtOGQwaUxJMGRsUElnQzAyZmI3M2ZTeTdj?=
 =?utf-8?B?cE1IT2VDcldOclV3MjJrYTJoeEk4enNBZzEra0tNYjQ0SXgrZEJUL3ZJVklj?=
 =?utf-8?B?d29xR0h2NWJYU2dBeTlPdU9NTGcvYTdkWEFmSU15aGRqUkg2d2l2Mk9OeC9H?=
 =?utf-8?B?Q21tRHBZM05zYkJBbURLc3hUNjgyZ1BJWlRpMWFnUGlJZDIxTnA4QjlLNitn?=
 =?utf-8?B?aHRUWGdRdkJIY2dnb1RyNmJQcGV1U1lPMXVTbXMwRlZVMGhCSXFtczh6Um5l?=
 =?utf-8?B?QkpGbEdRQW90Q3lKTVhoc1YzaUlmOUJValpJL1RDczl0SU9IdkkrOVc3T0gy?=
 =?utf-8?B?UUpyK2Fsa0FzVUt5bmF2c0VINzNVYUpVR2VscHhuMnNXTEttM2JwWG9lbDZt?=
 =?utf-8?B?amdxak5mZEFld3ByQ0pKN3BxdHduQ0FaS0dmRkh0NjAwV012TFBCMHN1RWdZ?=
 =?utf-8?B?RnVaR1plc2RhVjZFczFWSVFSdDVjVjQ1M3VMQjZtOTAvaHk1RlRTVGtsTXpZ?=
 =?utf-8?B?VGhtaTJIdmdOVEJpejdSaWt3b1BTOWFmUjdtclVSSzZQNFB4SjlMWjA0MXpQ?=
 =?utf-8?B?dEpmNTRuLzhsN2FIMWpxR05oaHdSR0FXWHcyMlVTVTJla0QvNGQyNkZEQXF4?=
 =?utf-8?B?Rlkwa3o4Ulh5dUk1ZEYvZTZ2T24vaWxld20wRk1zK0pJMi9yZ0RXQzR3b0dE?=
 =?utf-8?B?NXlycEpzb0l1Q1JuN1U4TFc2SlorZzNKTy9oM2h5N2hmUHRwS3ZMRndDdnNv?=
 =?utf-8?B?SE5WTnBHQ2xoZGhPLzVjQUxwQnhTcSsrR0FXekE3UnZZWGxKdFRRaVpWNUpo?=
 =?utf-8?B?cnlESVpMOExYYUx1dDdSZXVLUVRVS3g2SERjajM2bWdwYnpTUncvNmFpWGpH?=
 =?utf-8?B?SXFRa0VsVzhaQ0JKVjQ0SkZyaC9pampCVVpIQ0szS0FjOVI1MkwwQXNkVyt6?=
 =?utf-8?B?VkV2ckt2WFl6UjJmNFhRNmVJVEtxSTZleGk3MGRvY3VOQ054OEhBQ21JejBr?=
 =?utf-8?B?cS9wLytvU2cySjZ2L0FzYlc4MW43cTBzSmExUFh3V1lvYk1jWDh5UDJSSGVG?=
 =?utf-8?B?enlTWGtjNHo2dVF4bTFQZThuY0VreFJYcE1zUUd4YkV6VHc5OUt3WWMyWjVy?=
 =?utf-8?B?cHN5Z1JTdndseCtpYUxZUmZEdXdSOGRDUnlsbWRoNXV2T0Q3V0pZWWNKNEd6?=
 =?utf-8?B?RHlJL1JLYTNRcnlnMkxyVmcreEJoM2RTYXB2TGZnSDVBSll1Q2ErUFF2Yk1Y?=
 =?utf-8?B?S0syWkhiV3dKRnhQd3Z1cWoxc2FXVUZvQTlPTnNjNENFZFVUSENJL0R2VE9D?=
 =?utf-8?B?L2hnOWtHMjNPS2xtSUQ1Nm1iNC9GWkdRdmpFaUZvNWxJL29WTWc4L3lCcURJ?=
 =?utf-8?B?U1EzL1VEMElIRHEwN1dXMEQrbjFnMVpBbUFqQVFkSlNuNEJGeUxMSDhqZ2Fz?=
 =?utf-8?B?V3hEK09sY29ZTWxJRHlVK2dzaEtFSDRkcHJLTlRVT1RIOFRiSGY1aHhYcWRy?=
 =?utf-8?B?WjFkYVE1UzRiWXVadWEweFNlOUgranFCQk1Fc2YxQlNaalBjRnJsa3c1bEdH?=
 =?utf-8?B?WlRjQ090eEM2MTJwZEdTRGNpeDVlSTdrYlRqMTA2YlpvcHlzRHhNQVJ5RDFJ?=
 =?utf-8?Q?36O4Gn4D6sbKVne2AyAuXPQ=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: e8150fcc-12e0-4735-f2c3-08dc86079d54
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 09:04:04.3202
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YPjXAs4gDcCNtis9VgPMVGVEGwrPsujzqIDg5WbjO9QEnlF+PS1bns7A9gEJU8zkoDv/9Iaidtx/4G/tYdgo9t/a6GPuJ2gvGeSYV7GzSAQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB9513

Simplify the current firmware packet size check in the tps6598x
implementation by means of a single call to min(), which is what the
current code does in a more verbose, less elegant way.

This patch fixes a cocci warning ("WARNING opportunity for min()").

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/usb/typec/tipd/core.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 58f6eeffd070..ea768b19a7f1 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -1165,10 +1165,7 @@ static int tps6598x_apply_patch(struct tps6598x *tps)
 
 	bytes_left = fw->size;
 	while (bytes_left) {
-		if (bytes_left < TPS_MAX_LEN)
-			in_len = bytes_left;
-		else
-			in_len = TPS_MAX_LEN;
+		in_len = min(bytes_left, TPS_MAX_LEN);
 		ret = tps6598x_exec_cmd(tps, "PTCd", in_len,
 					fw->data + copied_bytes,
 					TPS_PTCD_OUT_BYTES, out);

-- 
2.40.1


