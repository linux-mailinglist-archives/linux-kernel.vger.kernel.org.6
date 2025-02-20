Return-Path: <linux-kernel+bounces-524439-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F789A3E322
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 18:56:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F15F7A9DD6
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 17:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74437213E6F;
	Thu, 20 Feb 2025 17:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ew6ZoDSI"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2061.outbound.protection.outlook.com [40.107.104.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5473A212B0A;
	Thu, 20 Feb 2025 17:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740074176; cv=fail; b=rs/iz1MiaRRfbugwbs7g28OWd5RjoyL1PD+fy8GnMgu0UCsnnFkTkEn3cZzvPfIbvL0F4OnWNAD23KjQ4d+n8ui50uDLY1STJMo0wImoIYOuMMKGZ1RNoCmSWH7zgzaaQwfS5Np3OPoFe+T9zKGMhaBtAozntGqSXdq+M9JlefQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740074176; c=relaxed/simple;
	bh=ZwMjr88k36GdlKsKO++JpJYVTHw89Xvgd6F5o5gW8qQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=NUeSA+qGoOx0WKSesY+nmJGG8Hoe4MLEyApxZGJ4h5SDvSZZf/+KfxD9F38+5bldJpg6t7NSiyMAmLk+b5Ig592FEWWJOihBnFvt3YPBZ+Rrnad4uZawhkE03+p/AWJ2zdeWaIGu/ijOT5RSkM4yRXtr9sjsNolOiPjHVZ1XFIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ew6ZoDSI; arc=fail smtp.client-ip=40.107.104.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=D2EE2kqWvRhsMWbKiEcOpr3ru/Bl2203BLVWFxFzViiPPU6TVeZ3kPp6ChCUW8FPbnJ0GVoGyMCUzCVYTtmH6ywRecgREu6gXEejjveOasrrWc4xNmeo30hxC8AZuE+pCkQkw4GszxQidIB433qO6mA4eAiLmQIY7hHyPxB8aym7+vx3M7JO2V++Hfo1DLlXS8K490vizy4bXp3RcwpLRLmtx8LmD6hOzZjm4vcRrcI6qKznUuKj9EaFM0FySve0RFrdDeotQv2l1acM3K1GPLVl49hGYyjVr1EHXut4KOJvQYnnZL6TFhCSvm0/ybo96R30G6+EoXqvUc8sKehSZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F9hdUx0Y+qxDE2vFMkWtsRjXRwWXmfEvyBWRWbEVRCY=;
 b=lDr65wJ849Rf0lj8/DUKpKRpRLmpghT9T0epuJ34atQRNCeJm45E/O4qA2dNZZAYTieF7JgX6FBvP2yw78WS95e29ER7jhFnsz1y1BjMCIW+1jBHETIC8nde3ZX53jp6LKDm1TgGocJueG+TY8VKGr0v+uMJDGZsBLjI5ZtIgHDRNEOlTTBMnKMGVwshGEL8VmdiyP7iVuSLMDs8lZXe2s5GV7VKYPsJZbPwKmDT40AOyfo5z5kjwvB7xHZzkrRTU/5N2VZrh/1KHhL/4EiimOYLUtDXadi7BswItlc6rJsnpATxgLa+FTq/RlSxU1WagKfU9qGC5M2UZTrU9GyO0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F9hdUx0Y+qxDE2vFMkWtsRjXRwWXmfEvyBWRWbEVRCY=;
 b=ew6ZoDSIpmHKeZHCoMgpZG6zVoCjAbCzgxpB4/CDURYN9CYJeasolp4TwzjURH+GSOurHss3jQ5mi6bqF15lgiInFnrDA9hEwJJ3mbV6/fTCysqkLHRajvllbwLraMqYnPti4uMyZ5l3b4z7q0NI5SygsEZ56vPA03b1OBIZ1W5U9gcI6cGPWXFcNIZD5VoMp5aptddEFgY/NmfIYK4QaXElyMCJwJ7Wg7QONKxn2aiUFEhgP4NXGapZFr1x4cNm7e3wlnovc4cgvhwDdC6HIP6HRrY7QHkc9Z3A6YLqBYWBTioT3idOTDe0qOW+VAeXfRokxwTfb6fTtUx/4Lh7nQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI0PR04MB10613.eurprd04.prod.outlook.com (2603:10a6:800:25f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 17:56:11 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.8445.017; Thu, 20 Feb 2025
 17:56:11 +0000
Date: Thu, 20 Feb 2025 12:56:04 -0500
From: Frank Li <Frank.li@nxp.com>
To: Stanley Chu <stanley.chuys@gmail.com>
Cc: miquel.raynal@bootlin.com, alexandre.belloni@bootlin.com,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org, tomer.maimon@nuvoton.com,
	kwliu@nuvoton.com, yschu@nuvoton.com
Subject: Re: [PATCH RESEND v2 3/4] i3c: master: svc: Fix npcm845 FIFO empty
 issue
Message-ID: <Z7dstL6FBYh3/cz7@lizhi-Precision-Tower-5810>
References: <20250220061107.1718239-1-yschu@nuvoton.com>
 <20250220061107.1718239-4-yschu@nuvoton.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220061107.1718239-4-yschu@nuvoton.com>
X-ClientProxiedBy: SJ0PR13CA0185.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::10) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI0PR04MB10613:EE_
X-MS-Office365-Filtering-Correlation-Id: 35dc28d8-8494-42eb-1185-08dd51d7dc15
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pQqSBVQdlCHzw1usnwuxxTWuIYy0Luo99dFm/y95pwKUh00TTNvkHhBXCXmj?=
 =?us-ascii?Q?MQbPNkFtxmem/4IDOvaB1TJ2vcoXljFEz1SC/kJ6t9JYlwJUz0gJ1lozKMET?=
 =?us-ascii?Q?yFoj2pzTy8iQjeKzO7ofMboHC9Y35lwNnw5f4o4QZOsiyPPsep71/jfk253f?=
 =?us-ascii?Q?44Y7XDJmUnu0Basmd8V8BIanRarywGtyOtQJsMkIkD0SOHk9uLG1PpUjgV/w?=
 =?us-ascii?Q?l+Vex1Th5eJpWmsK0uClI2OXs+yryo0pVvNc59GOMOwEUYOFE5g1ZkRDiVUY?=
 =?us-ascii?Q?m0DNoBkbpg70qorJFj0WktM3Spe4Ydai75m+e30YfjfblO+mi0GnB1stxZq3?=
 =?us-ascii?Q?z4ko+lIuglhlyd+cjDEAnyHYA15qh+xTf3QBDveeV99R0XY2didLzJwNV2dP?=
 =?us-ascii?Q?AP4TvQy7E159/FBM81xuTGyhVrqV4LMweGQH7W7Ba/vieQuKFy8zU1GXir1b?=
 =?us-ascii?Q?+jjRvWVNzTU/GIl1BUw9bKf8J6g3HRIt688qmJtByYmUOUjCQyyvZtz32m5P?=
 =?us-ascii?Q?AdTc7bTtMQCLfvSBuxK9KxIr6T7LI7XHI37kQBQXptxpXWAo6tCAOswavHMY?=
 =?us-ascii?Q?5OCoSmHtiYyzkDHOYhuryXikuxljptRlxSCQNRFjUxt+7p6kREEa6+msBTL7?=
 =?us-ascii?Q?DRf7m0uuW/7tUi++z1MpHjYmdDDMhEtOHHJbhwce872jXN/9S1PS7t0LAtCq?=
 =?us-ascii?Q?UBDGsJOjKA0t+aUTtwOIrdF84GvOfAWXtNEOm/YcqoOuBwQTFd721k1r02Su?=
 =?us-ascii?Q?PGrgKyUoL+TswX9dIQaPli4vddYyemU5jbXIRn8PtsrIv+QQ/KWNyHUhnFbP?=
 =?us-ascii?Q?1EdfdY5lY6Y/RqbBNth3PSL0GswMtxtIsUhJFqB/pOY4z3kFiT/Pp3KWDwGT?=
 =?us-ascii?Q?hYKq2lWYyy4mLgKKibOTSklkiLGLZF8FuomYoCTe/fTQzG3HB+I239Zg/mHA?=
 =?us-ascii?Q?SVn+7D5syG8Bj/j65yAY2knTFmA/hw+C87idRBis9lfwRv/4cBofhhxHoo0R?=
 =?us-ascii?Q?gUBGuj9OotQlbEYrtElahn3HNXDUgaKFOrDobGlCvYZKtHJgbDbs9J+xBFlT?=
 =?us-ascii?Q?Kgz7pLGpKJrGzaishUr197F097ppOH5o4nbmum/V90Y+n+531eCoKTiTtkAw?=
 =?us-ascii?Q?GxrK5XLCc/dnp4Xrr2GsDhaJTZVTtxIRQ2D8luaZfW9bDoyQBhnkCwz8QgzX?=
 =?us-ascii?Q?j+kvMUCyWEleXT0xtpHcI+21Uvz91w9kLnTW10K4/fXPsh9I57/VBPS1Gy3C?=
 =?us-ascii?Q?SieITR1OyYumLXorlYM+MdhK8IMOn2A3DFtDjc0iZS1Co8imGG/09KvYCY5O?=
 =?us-ascii?Q?Fb7ebSflUNwkb8n2xonURkHIATkrns2E3xOwSHkoqNAQQZi1MeTttOVnLBEM?=
 =?us-ascii?Q?LyU55MhE6W1lsTXKAxbFpOKhmVKgsQ8eBzAgE+7rmx6styI8pdV1W8B+XkAz?=
 =?us-ascii?Q?XcJM/pOjxjF93dMM0N1L6So+0k62S3AD?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ueKLhvZiAQaQ79mTL7jhjsHy6c6itdx8HLVD651Z0FRM+YZnVkVjFG7e5WyL?=
 =?us-ascii?Q?expuVVcVp+xy74zuFph52fVbu/PO4uSjH3tZFqIlp0Bgh/MUToqULCVWbMYm?=
 =?us-ascii?Q?4nGvrP86k4BzEyyNWTbNu9P6ObojAe8D5a2GQs7LESyVaKpA09jYYVLtRVuL?=
 =?us-ascii?Q?u5zgss2CN4TSJpYjT8K9QW6JnGDHew+gwk9Qyii+AhTUf6nHT8kY8j0u9Yq+?=
 =?us-ascii?Q?se7xyMak9Id4bovJiDsFUTaT84ylWOPfN7yZFHmrQBn+d0uOvIRalnKdCyUK?=
 =?us-ascii?Q?cF1ie+kDrMouNlAI2PplBLgV5jvX7Cq31D61RpDrM1Qkq9VZ3ylxH4YvYGxz?=
 =?us-ascii?Q?oa3/+cDOp1E3VMmz2oEVBsEN4JfbTeQ/v57z7hv/N3J6jQxh8fYLLef2hN49?=
 =?us-ascii?Q?EfeElKpy7cIq/EfeN0CmctXLXEef/TXe0iAXpsQSUiMXXhSm4Vb3D7GCOUJ+?=
 =?us-ascii?Q?8O84BHH7PFHghCTNddzayZvrSmmDa3yAjCXUAP0jMAwzFtcNLrg2jHrWQoDs?=
 =?us-ascii?Q?8Inp+KPcFbt9iwgZigXRftuTRgRHX433v6NZD4DF24GUQqjiIqPRDRaEP/5l?=
 =?us-ascii?Q?lqM1uWD+tLktksED9LWYB+hV9R3h9sgG8ASAv/wmNXB4upi2YvqQIufcv2PP?=
 =?us-ascii?Q?rBrRtZiCK1gJ+Ll66UYaajhbI9NplrmeL4tcepiilwcXwuycoN7cQhdV4gMh?=
 =?us-ascii?Q?hWb5w/DJe0zF/6uLmBxY9cu6BCHwrrU4GCBc70R7jwNOump8nfRI4TWppDH+?=
 =?us-ascii?Q?4Ag1OpIvgiN62woniBItXL35oWrrzWusc/rJbgtEVkBvyE5BW3NpYHZGTqp8?=
 =?us-ascii?Q?DaNOsfjoMdKiAC+u7qm88ZmfSpaXsK8Fj6keNstSi9sHF8JTlN1cGUqKj8gf?=
 =?us-ascii?Q?0kOZg99RmlMeaPeki9B8U4AADOj5052QJ4F2D4ZRncZeSft/tUOQQ4COY2Lt?=
 =?us-ascii?Q?qfoj45ZxP3FGiuEs1zTSra3AlCFbV+8LhCzrBS+PCazSFlk08GwwFyct4k6i?=
 =?us-ascii?Q?XxW5ysYVFCx6nGq52vpuvWk+gEqs8XXgilY1pFfKRZIgNXGqEL/KCuiD7SuV?=
 =?us-ascii?Q?rExPSfB1hUebGKIIBYg5+9rrmfs1LtRbTxm7U+SpGMUoy741Q+DGiCEDkpHu?=
 =?us-ascii?Q?Rg+rxbTfmkTbyA0kh7iAbMHOa2qgx4AvWHDJC7rrzltq9hCuSuXNxmK57o6C?=
 =?us-ascii?Q?EDJ9QF99qwS6wn6G0i7+elHXDuy8T/uWPAClkFZsFJIkAKBwSqCdlnXGkNKq?=
 =?us-ascii?Q?978Wvtbe5nKuvNB6gMlLzf+dmXCH2ls+pGDvBQzt6JqO6w0VY3W/QjrlAeXD?=
 =?us-ascii?Q?m+lrUSQ1MJvanRwinGSSXPeS21AbZery0HIgPdHQwAElofSo9JbFPnn3QmLT?=
 =?us-ascii?Q?UyI756NvXXvHPWXvSu3+hUYPIyHFKbSsIz3sTkQM+LCBBUxsUqpUWDD4P2PM?=
 =?us-ascii?Q?7X9TNyWu59SyNcwA5aL5EMynQqwK1YoMy9jA9dXEDRCdqCGCPKDcFRKRJRSB?=
 =?us-ascii?Q?djt5o0YP8ng7oet0E/0ft92tiY/CIFFTy11k+AadicjRGHRDFD0L3M1SVWIy?=
 =?us-ascii?Q?SusXNKye6hXYxt+1IGo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35dc28d8-8494-42eb-1185-08dd51d7dc15
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 17:56:11.0095
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SU1JAPVkuSSj8oLYuJko6cSG03828wY0rSKilA53l1dJuPWWSiSuKi/mcFq27PKuZzUFq54c14fGb2clYapXRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10613

On Thu, Feb 20, 2025 at 02:11:06PM +0800, Stanley Chu wrote:
> From: Stanley Chu <yschu@nuvoton.com>
>
> I3C HW stalls the write transfer if the transmit FIFO becomes empty,
> when new data is written to FIFO, I3C HW resumes the transfer but the
> first transmitted data bit may have the wrong value.
> Fill the FIFO in advance to prevent FIFO from becoming empty.
>
> Signed-off-by: Stanley Chu <yschu@nuvoton.com>
> ---

You missed do_daa part.

>  drivers/i3c/master/svc-i3c-master.c | 22 ++++++++++++++++++----
>  1 file changed, 18 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
> index c58440061d5a..2140da3f5187 100644
> --- a/drivers/i3c/master/svc-i3c-master.c
> +++ b/drivers/i3c/master/svc-i3c-master.c
> @@ -1196,8 +1196,8 @@ static int svc_i3c_master_read(struct svc_i3c_master *master,
>  	return offset;
>  }
>
> -static int svc_i3c_master_write(struct svc_i3c_master *master,
> -				const u8 *out, unsigned int len)
> +static int svc_i3c_master_write(struct svc_i3c_master *master, const u8 *out,
> +				unsigned int len, bool last)
>  {
>  	int offset = 0, ret;
>  	u32 mdctrl;
> @@ -1214,7 +1214,7 @@ static int svc_i3c_master_write(struct svc_i3c_master *master,
>  		 * The last byte to be sent over the bus must either have the
>  		 * "end" bit set or be written in MWDATABE.
>  		 */
> -		if (likely(offset < (len - 1)))
> +		if (likely(offset < (len - 1)) || !last)
>  			writel(out[offset++], master->regs + SVC_I3C_MWDATAB);
>  		else
>  			writel(out[offset++], master->regs + SVC_I3C_MWDATABE);
> @@ -1245,6 +1245,19 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
>  		       SVC_I3C_MCTRL_RDTERM(*actual_len),
>  		       master->regs + SVC_I3C_MCTRL);
>
> +		if ((master->quirks & SVC_I3C_QUIRK_FIFO_EMPTY) && !rnw && xfer_len) {
> +			unsigned int len = xfer_len;

len = max_t(u32, xfer_len, SVC_I3C_FIFO_SIZE);

> +
> +			if (xfer_len > SVC_I3C_FIFO_SIZE)
> +				len = SVC_I3C_FIFO_SIZE;
> +			ret = svc_i3c_master_write(master, out, len,
> +						   xfer_len <= SVC_I3C_FIFO_SIZE);
> +			if (ret < 0)
> +				goto emit_stop;
> +			xfer_len -= len;
> +			out += len;
> +		}
> +
>  		ret = readl_poll_timeout(master->regs + SVC_I3C_MSTATUS, reg,
>  				 SVC_I3C_MSTATUS_MCTRLDONE(reg), 0, 1000);
>  		if (ret)
> @@ -1306,7 +1319,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
>  	if (rnw)
>  		ret = svc_i3c_master_read(master, in, xfer_len);
>  	else
> -		ret = svc_i3c_master_write(master, out, xfer_len);
> +		ret = svc_i3c_master_write(master, out, xfer_len, true);
>  	if (ret < 0)
>  		goto emit_stop;
>
> @@ -1333,6 +1346,7 @@ static int svc_i3c_master_xfer(struct svc_i3c_master *master,
>  emit_stop:
>  	svc_i3c_master_emit_stop(master);
>  	svc_i3c_master_clear_merrwarn(master);
> +	svc_i3c_master_flush_fifo(master);
>
>  	return ret;
>  }
> --
> 2.34.1
>

