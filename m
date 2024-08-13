Return-Path: <linux-kernel+bounces-285060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C66C9508BD
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 17:18:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85B611C22FBE
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 15:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 401491A0727;
	Tue, 13 Aug 2024 15:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c27DUjVg"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337B01A2564
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 15:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723562166; cv=fail; b=rGtyW58qti0KRwO9ZfNf5pREfDkmZr0MvfDMTOjgFvqHJpnPVpdy/D7WgsD5lQlGL6G5qVM/XHSOGcwOYdyxaVR4uNFwLdCpWwouPQ7RFGSBL+iH13TniDROALCZ7iYWu+yNEM6yHpm1f8P6oj6kVqzhvYKKYYKISOX2eRF6ohg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723562166; c=relaxed/simple;
	bh=DaLGN7qQFvP6oGFtxS4SP64nZLiI2N6XmjBeOGjaOcQ=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=aPG9soWC89UMK1991jN0Z9W0vdVck/dMuDVd23eG5s2kJ94B7BHVAwQKCPohbAviQjbVXtbsxNVYxbA2gFNDDvD+VOeGTN8sPm3xChwS/1+EnTmbkr63JgANvxs4sJGIz0GbCYYLstjcm/fhq4nE2Q3vBqxEcssQJcax2fVA6fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c27DUjVg; arc=fail smtp.client-ip=52.101.70.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PnM/YKQs+qbWLr92Ql4O/2Qh00vzLSgYqBSRDdJUWObNOd7SpPr189BsyPk7iikZzyrdrFzDHTmVqdPYzNmGMh9zjV+cFkkIywKTEH6l4ek5S8ZZbWB8hSzkQ4aTbbgWt/6dRvA173uETR/pmwmQrf9rWTFARuyJBcVWmH5fEjKYDwU8kyA2zYQ3dMZ02PSMureaJMyh0mfyR1SevWUIu5nsakI1dFg+dfo0WLGcQBmcDdXySgTiw4lI/zTSNyZAoCRvJ+RmZeXjsaJhxB0tvFj7GP1fKx4Gc87Aa/tIXrwlvYHhV8wF++0zAQ+AKxCYBrD2+mdc9ZtLBcEPLh4peg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2/SVwfWRORhLiOwxpskuAqNJQ7ey0W3ly62qeO1Waoo=;
 b=Hwh7rQ9vWMcG80LS7RxBNyoHSFnXs0Otb7EXj0/TxPI3KmYAgExmmWMaGtF5yuKRDLJh/2rzLsIcjo/jG2NNM3doVofjBDcQY3aUNPczshoaiGvx/liRSsn+LYx9a8f0R1R4outf78Aw9inWxnVNgsthn8Qw3uc6QOGbhRQxlEI3VDnjP7KqRcObnfAQGRYfrvC7uPw5ln4zpbD9Kf95MoyNiIBKua1gxubXSk4K1SmqhHjEnICQI4lNsDbqnRewuZiJ2UZsie6G66qZtoSDgneMn85Z6ByozAJ3mKOehgoW2s+R4s2E7KX4GQWsm+G+p/hgFDY9eaPHA9ogWMwvxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/SVwfWRORhLiOwxpskuAqNJQ7ey0W3ly62qeO1Waoo=;
 b=c27DUjVg0P/IAGIIybfGOVnxaUT2PVYml5WPp0CQEnEvhiR9DpzQ9yzjS/QrR3devDxgajYH1AuOl88JtQ6JdQkAOdq3vzjX3TQbs+B+sfs3llS4Ogxsj6q4GHsT/5Hebr55UiubFp9vPsl+lefF4vr5OMAC0sbMRCmQXyOkE/BN1s/u3J5Br+aKfGszbDmvs4qnpxxGHX157i7TjkgSQJ+f9X+n5OXTDg0LbxNrabZTLrPHddO1/2NArBc6V8BfwpvMRP3AmmjPTKc4MZB545XERyvYI6Gl3ydUR3sMGDCsoTZYr1K9EKtmo3k0ckfhhTCCNuPKsjQPusB0zxMcmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU4PR04MB10623.eurprd04.prod.outlook.com (2603:10a6:10:580::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Tue, 13 Aug
 2024 15:16:01 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%3]) with mapi id 15.20.7849.019; Tue, 13 Aug 2024
 15:15:56 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Tue, 13 Aug 2024 11:15:09 -0400
Subject: [PATCH v2 11/11] i3c: master: svc: fix possible assignment of the
 same address to two devices
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240813-i3c_fix-v2-11-68fe4a050188@nxp.com>
References: <20240813-i3c_fix-v2-0-68fe4a050188@nxp.com>
In-Reply-To: <20240813-i3c_fix-v2-0-68fe4a050188@nxp.com>
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Parshuram Thombare <pthombar@cadence.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Boris Brezillon <bbrezillon@kernel.org>, Arnd Bergmann <arnd@arndb.de>, 
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 Conor Culhane <conor.culhane@silvaco.com>
Cc: linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, Frank Li <Frank.Li@nxp.com>, stable@kernel.org
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1723562115; l=1988;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=DaLGN7qQFvP6oGFtxS4SP64nZLiI2N6XmjBeOGjaOcQ=;
 b=GmVe6uM9oxyEhl6ZteKP2TVSycfDEG5HUkd65JC7G2Zy73mA4c1KYOodtFIOdzdceRSsCCj9B
 cvpTEUv0I3nDC2sIgB+dEyGHHxGqyl9+wrJBOIc8D0tiD9/leFhTr4+
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0125.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU4PR04MB10623:EE_
X-MS-Office365-Filtering-Correlation-Id: 82908c0c-227a-4542-cfe7-08dcbbaad47f
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?TXlnVFJhR09OdWRxUWd1MHliNTBnZ0hKV21BeXdsYjI5WGRlZVJ4Yy8rbUFE?=
 =?utf-8?B?NWQyVmttb2o3blBVZGpZQ20zMlZJVXp2UUR3dmwrdlhXWXpVTFJseFpsZkEw?=
 =?utf-8?B?eDB4WGdWTmVQeFd1alNhb01oczNCUGszSlJLNkR5cHBSbWplYU1ubHRScmZ6?=
 =?utf-8?B?Q2dhMnJNemFnQkdZK2xXQVI5SFJJbU1USVk0S2lFMkZaY2ZhMGphRmtJeDRn?=
 =?utf-8?B?cytxWjZrbHhjTEpaSDlQa1lzS0ovaHFLKy9zbGFUOWxaRGR1bysrWWZUWFc5?=
 =?utf-8?B?S01MRG4vRGVzT3lLWXJwUytCYkhUaHpxbVdDNnlpUEdTOXRBeU5IQ0p6SG9i?=
 =?utf-8?B?bUhWOWhnanZFSTN6N0daMTc4TEZ5b0R3dWgxVGhSanFIcjhJc3VSK2JXS0RE?=
 =?utf-8?B?bHhVWXU5S1pyMnJkdG5qNEVNaW5ua0xzSDhxMk14YURoVW9qM3NNVkR1UjFF?=
 =?utf-8?B?ZEt6LzBUL0NMRE5idHhtQXhKMWZZNEk2RVUwYVRxdEIxZVhJVjcra3dNVTk2?=
 =?utf-8?B?UmVqemdmZU9VOU03aDR1Rzl1TmYrcU44ZC9BeERzc0luYndBYmlkeFhudUc1?=
 =?utf-8?B?Mnh0SUJrcWZMWGJ0b05kNkNsZmtmTHhBV3o5endUMlhoYzFScjgwamIxeHl3?=
 =?utf-8?B?TXZjWWU3cFJmN2RHWGdzNmgxT1YxV0EzQ0ppQXFRNCtNcThtZlc2OWJERytm?=
 =?utf-8?B?WVpaUVBPcTh2UUQ0dCs0aU5PZEVCcGpYSTM0ZDk3dzNCZUt2blp1VGpUNlZS?=
 =?utf-8?B?eDFSeDc2azZKQm5CRklOZ1lNaDNuaGlTb1R4cFZpOEx3WTArR0hHRTVhVWJP?=
 =?utf-8?B?bDNJYW9kcnRxcFh4SFB2eHhYS3g5OGpXaDAzNWVoSW04ZFNtaUprY3p6c1kx?=
 =?utf-8?B?RlFhYlZQMW4xUWVaZWVlS3N5M1ZYc3ZyQ29VenVYSXd6RFZmTTBCb09XZHBj?=
 =?utf-8?B?NlJxdC9QaDJPY3M2L3dZaEdIekNVbkVTeXYrVWF5VEdRN2xvUW02dEJFTjd0?=
 =?utf-8?B?YTk0dEkwWFdObk96RGFmSVNyTHVSaEN5akJpL1ViUHFsNHBnVk9tamJ6Sk9s?=
 =?utf-8?B?VERGNm9vNXhNektuVEpNRFZFUDNieDVKaFUrTDhqazRUVUdZTEErNEdnM1lv?=
 =?utf-8?B?YTBVNjd4U3ZxNUtpRWJtcFdMNXd1N3lBSDIvUXBqKzJGeENFU0ZlOHUxTnZT?=
 =?utf-8?B?MExTQlBJYXVhVDN6cW1iTlJ5Q1BvN0xHc2g1YkpUSUlLbFRWVklWYmF4VVB0?=
 =?utf-8?B?THEvYXlaYi9LTnprZ09rWFVpamszRHpuRE5EdHd4UnY0b3dKazBwQnF1OUZR?=
 =?utf-8?B?bVVlNUhzUTYxZkg4b3krSWxvWDRPSElGejhHaFIwYU9hTzI1emVhVE0vUzBL?=
 =?utf-8?B?cE55VkI1cTQvMGkyRHltbXM4ME5EUzQxSXJVTHM1VXRMQWszT05LYndpMUFo?=
 =?utf-8?B?OTRzQU5tckFhU0hFeGx5aHFnMjRjdWhTbEZTaGlaWUZySk5NaExaSVBMTmhz?=
 =?utf-8?B?dlJMaUREaFU4eHZIYTZYMjBqM3lNMEUwY1RCalhSdmhtaW1OVjlkM1BidFQr?=
 =?utf-8?B?VGhMV0NHWVVjdW5MTzZ6TElrbW92UTFQVmZWVHByUUx5NENyVkFFZlB1c1Q1?=
 =?utf-8?B?bWpSd2I3UE1PZWVZWVVEcEZONGdMcURrUWtuWHNGRlJtQi9mcVlKUWMzSzM3?=
 =?utf-8?B?cC9aZENuYWYveGtQdnpMcFIzVCtvY1Y4c1NyemsxZGNpeUhKalREd1E5SzN4?=
 =?utf-8?B?TXhPQlordFNJVHUxanQ2TkdOMGxwazRvNk1xWWpXQWY1eE9TR2VWWFI4RCtS?=
 =?utf-8?B?cXRVYktUaVFrNG1RVUdKT3R5Wi93RXBaSWhickt5OHRzUnM3QzNLMVRxcktO?=
 =?utf-8?B?VkNMeGZsbmNUREZjUk54Ni9kTmMxVm5Ra1NlK3lLUStNY0E9PQ==?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?NC9vVHE2Z0VsT3hOaGRreElya3FjSUNqUVljTmFBakl3MUIyWFlqdmQyN2xu?=
 =?utf-8?B?UldjaEpra29RZFBOSmo3bHFFT1R3dGNjWmtpaWtZK3c5dkE1bnFqWWt2Y01l?=
 =?utf-8?B?MGxLZS9Qem9UTnR2M1Njcm92TWdrVjV2Si8zU0RXcmhySitGdmhzQW5kdGJJ?=
 =?utf-8?B?TjZoOTVGbG1PMDNBZkxlbW0rOU81OGp3U1I5QUpIVld2TTk3dFlyOUhjU1N2?=
 =?utf-8?B?bVB3aVpXQTlwSE5lZ0YzTEpLcXdic3VzTGs4SEJIeG5YV1RpV21IV3V3R0tr?=
 =?utf-8?B?R3VQS3lCbEVpYjEvY2ZUWFZUcEJIckdWcDdyOGU4Rkd5K2YwVVV4S0RtYVVx?=
 =?utf-8?B?akNMTldZTWpHLzkxbVdLWHFBT1J4N0NvMVVpeCt3bVlQU1lMTm15cHlLKzNC?=
 =?utf-8?B?MXp3clFZTGVIUFUrcDZLUUZqamlRWUY2Q25TbVExQURONDdRT0tRaEQzQ2gr?=
 =?utf-8?B?TEwyWGs5dW5pMW4weDNRT1hmMFMrek1ZcnpMcys4V1Jtcm9TY01UN2RxRTlJ?=
 =?utf-8?B?RHZJc0FwQk15dEM3YVNEYWtsQjFxUVV4TTZpZHNudWpRaW1IdUVMUGxZU3lB?=
 =?utf-8?B?TEVHaW5sUDVtNm1KOWRBdUd4ODFPc09hQmVIcXdXajFxelV2OEIxSzEwRk1j?=
 =?utf-8?B?VnJGV1BLRTlWT1E5RTZMcEpiRytoTnc4T1RZMmorQkl4aVdic1AxKzY4QmNW?=
 =?utf-8?B?dTdlcEcrVjV1aWJPZU1yckNXWk91TGI3NVVQTW1FVHdscWlQak1mTlRKejN5?=
 =?utf-8?B?WTYrSkJVMlRFNmsxR3ZmTy9iOVp1aUtXYmswblhHYU1vK3J0T2hqOTJHNGJ3?=
 =?utf-8?B?S3Z3NmVrakRTQmk0T1E5VjFyNnhEbmo1bVI2Y1Q1LzlGUTlUVlpwRmthNlpS?=
 =?utf-8?B?QnZhMUk5bXB3RVNjUjJkVEU2U3pEaUxCbTFiMFpDWERLZTZ0ZzIxYm9TSEVE?=
 =?utf-8?B?bHc3QTdRcmhJbEJwWjV6VzJxSGNMVGVYK1RlVzU2cFp4NGVOYXlBN25mc0I4?=
 =?utf-8?B?cldCdHNuWDR3SmFJZTVkbFpSNlc0M08rT1hDdUdpWHdYeVNXdVRyMXpDbzl3?=
 =?utf-8?B?MHpEWjJGV2lkcXgzTXh3M0ZydFA2OHlEZWFjLzhGeHV4VWUxWW03SEpBYnd4?=
 =?utf-8?B?V3hNL1Q4ZndxT1JseW15N0JjUkR2eWZoY05SKzBLOEJKeHdoVVo5L1pvL3pM?=
 =?utf-8?B?eTNrUFBzdS9tOEZBWTNyY3oyMnpkZW56UGZZUExHM2hmdlRWaDhPeUxNa1dS?=
 =?utf-8?B?R0JzOG0zWVZiOXg3SUFDMzhSMDBuMXFRWkNvRkdHMUg1em0xTHhDMm5zanIv?=
 =?utf-8?B?RDlyRmlEU2pyaldjVUwwMkVkc0E5eTdrQnRMTHMyZmRiWnVzcVVGY3lOT2h5?=
 =?utf-8?B?eUNpaU9Oc1NES1JCVlFyWGpjZGhxMFJycmFqR2xnanp4Z0txNUMxQ0p2eC8w?=
 =?utf-8?B?dEM0cStBTXZlb2V0bEpuRCt0VHVIUVpob3BRQjdZaW1TQU1nOWpXQnJod3pt?=
 =?utf-8?B?N3FhZXl0Kzc3bjBxSEhTNmdOd2RneFZWZ0hRNUFsa0EyQkJCSElYUHhHaXlK?=
 =?utf-8?B?L1V6TkdNWVQremREaXJrMER5QW9yRTBoTmVaQjZndDQwT0pEVTRBMkwydjlX?=
 =?utf-8?B?UGtuT2wrZUxFTEVCOFd4YU92T0U3WUR5ZWRrSXorNERwOFFmK2owdXBYcmtp?=
 =?utf-8?B?OThWMHlDNi85VWRESjFUNjZEaFp0NEZXclFPSm1meFczSUpLY2dpRVV1RDlW?=
 =?utf-8?B?Q0hkRlBNbWVPUmlIR1o5YjNXMFNPa2hYMG1OeGNWaEx4UWZzcCsrS09aaXNi?=
 =?utf-8?B?cnFLL1NWOVBRTjNDb3czV3VUcm5DTm10MzBPeWJ3U2h4L2dVVDBVMGk2TkVr?=
 =?utf-8?B?TnR3TEsydUtQRXMzNmx6eGQxR05vYm5OY0lFYVFXN1Y4dlF1cmtKYUVCSFVv?=
 =?utf-8?B?NFFKUytGeWhjaXZaTlJadFZ5VG1MSldDY2F5dG11TGx4R0xVUk1acTAwbEtD?=
 =?utf-8?B?WWU4d2IvRnVDTmQzZ21IdGh2UFRXUHVJRFE3K1RtQUFYdWkwYkc2MjBscVJn?=
 =?utf-8?B?dVpvZ0NPQnpqbTB4UjFCSUY1WnN3WVlWUGNiaDVmRk1FditiVkhibjExWWIw?=
 =?utf-8?Q?EgP8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82908c0c-227a-4542-cfe7-08dcbbaad47f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2024 15:15:56.4539
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jMWJi6sxoONkt/rwkcAjeCKoZX/VOsGfbCnfL5veBpGyM3Oz5a3LokRup3dcHTfKcn/PjcguRmXtq6wZ5Donaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR04MB10623

svc_i3c_master_do_daa() {
    ...
    for (i = 0; i < dev_nb; i++) {
        ret = i3c_master_add_i3c_dev_locked(m, addrs[i]);
        if (ret)
            goto rpm_out;
    }
}

If two devices (A and B) are detected in DAA and address 0xa is assigned to
device A and 0xb to device B, a failure in i3c_master_add_i3c_dev_locked()
for device A (addr: 0xa) could prevent device B (addr: 0xb) from being
registered on the bus. The I3C stack might still consider 0xb a free
address. If a subsequent Hotjoin occurs, 0xb might be assigned to Device A,
causing both devices A and B to use the same address 0xb, violating the I3C
specification.

The return value for i3c_master_add_i3c_dev_locked() should not be checked
because subsequent steps will scan the entire I3C bus, independent of
whether i3c_master_add_i3c_dev_locked() returns success.

If device A registration fails, there is still a chance to register device
B. i3c_master_add_i3c_dev_locked() can reset DAA if a failure occurs while
retrieving device information.

Cc: stable@kernel.org
Fixes: 317bacf960a4 ("i3c: master: add enable(disable) hot join in sys entry")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index 0de95f406c95b..f47e5f4af68c9 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -1041,11 +1041,8 @@ static int svc_i3c_master_do_daa(struct i3c_master_controller *m)
 		goto rpm_out;
 
 	/* Register all devices who participated to the core */
-	for (i = 0; i < dev_nb; i++) {
-		ret = i3c_master_add_i3c_dev_locked(m, addrs[i]);
-		if (ret)
-			goto rpm_out;
-	}
+	for (i = 0; i < dev_nb; i++)
+		i3c_master_add_i3c_dev_locked(m, addrs[i]);
 
 	/* Configure IBI auto-rules */
 	ret = svc_i3c_update_ibirules(master);

-- 
2.34.1


