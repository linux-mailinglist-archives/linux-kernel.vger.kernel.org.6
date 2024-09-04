Return-Path: <linux-kernel+bounces-315455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 585D196C2E6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 17:51:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C3001C24FCC
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Sep 2024 15:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3013B1E133C;
	Wed,  4 Sep 2024 15:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NnBUXOBW"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2059.outbound.protection.outlook.com [40.107.21.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127EB1E0B9F;
	Wed,  4 Sep 2024 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725464976; cv=fail; b=oZPsHjgvgAOCmt7N/tv5un+vxS4+4MgJzilX5cW2VWaCsLNdKLKM2mDRQ+PH2FaGje6BH6BBogPDk3BiBL8pCsLH1XaMmPW0pm2UmBaemX3m9jBGwuWwRVt7u7vy9YWvcNvb0LgCGmGJQK7cchqsL+28rX6yGZI0Ssh5wyjbMFc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725464976; c=relaxed/simple;
	bh=SSBQqly1oyxDE2Ca0oLiGpwaCWTsOBymC3u7/XHMbO4=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=PAv3UuqCX9kvfpEyFMa2DdrFsx5jvyTydWnfNY5tZobk+mQzT+oYHbsdT37UQ3MzzCX5esvEBkTTNZllyPEThI7fOKi7N1O9f4cM+l90IEc5ABdbuQazIoNOjTZx/PkT5foRKDN7UYgMdTZN46z9cGy8mGqRgHwnjvJvG+/oxl0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NnBUXOBW; arc=fail smtp.client-ip=40.107.21.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zIkltuCE29oY1sIEWRe/gVXif7sy4NGn0iUeE173OYCwp8LH/lLXBEL0QMc3fp4sg0pxyqer4yQMfjTV/ddiQ2LqE6uUYPvE5l5LApxQtOINfoMmfsGG+K9qotVx9Y2o3emfKzsqn99cIH17A7KblKQHT1H50wB45NpeSRJsPLLy4hZxPNWaEEG1IjhCakpVuKje2NpJQXHFOLfsFEUdivmuJjthe/+K/+PJNc5nXOi1vBOBId37boCmVm/gai9X2sGEN4eavCA2eLeZrxVVHaummaD7lh2c7uLZnmAz3HAynmemG2j2ig66mdqBec4TnpQt0S27UCp9GRUlK9DAJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oh5rmW1fK+ikUT7LDb6WhkeuVrD+/rsoKDvoXvWDMc0=;
 b=t8eajuuwIHHDdiz9uhnNbYNOsEPXtG7FMpZlW+O9NrZwAa7YjO7ylbnWSbYjXKDdH+uNkwuyoD4OdPMQJUHPRQRv4koQVkk4HiyJz9z9uMyOa6WQuptGtdoddtKqbwPVbODD1rIscPTtoPSdxcVCALhNh6ScO5ImcDjs+UlQsSUYYdc17S9J+rrDL18KXGHmtkJZ6Rwihhbr48Bvh/EQd/PWPD9qQEbn2bfvllK9cwZItgc/ZwxH5y4SHGivmz5g1fXBu4yu6DTln1Uh3eTCbbp33W4HHtHe8FYPyVq2xvP04SeaUrECukseLP50KCFlBJwOxM0FYhWquu1fK5KtEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oh5rmW1fK+ikUT7LDb6WhkeuVrD+/rsoKDvoXvWDMc0=;
 b=NnBUXOBWBcrM6O8i83QPWKAjWBhfQv5tT+vq1BeW1f+l4OE8BOBSKTp89pbYjnUjlHMzOju6HQkMs4Y8174Jwx6adziQVx4ebYAOcoWd2GWB+HXvK+4q/mmpykLZ2qe3J+ILKj/YRVgSrQjWyHLXvHUOKgD0la5vsQnUNawahJlLPtVBL9zzHgQszip3F6EBEIcycBttNKPvmbjALRDGLutdEZSYncujx4j/h2p9h3FBUVnQAMp/XIz3nn10PedbnoR6OQlfwWex85JI0nGPYQX0E9gk0EqDr9AOqTJaljy7f8P4fgK5iW9LH45mn8yPyHo26o62WXRW6vlR8tWHng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB9859.eurprd04.prod.outlook.com (2603:10a6:800:1d9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Wed, 4 Sep
 2024 15:49:32 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 15:49:32 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 04 Sep 2024 11:49:03 -0400
Subject: [PATCH v3 2/3] usb: dwc3: imx8mp: add 2 software managed quirk
 properties for host mode
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240904-dwc-mp-v3-2-319947736ec0@nxp.com>
References: <20240904-dwc-mp-v3-0-319947736ec0@nxp.com>
In-Reply-To: <20240904-dwc-mp-v3-0-319947736ec0@nxp.com>
To: Mathias Nyman <mathias.nyman@intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, jun.li@nxp.com, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-e586c
X-Developer-Signature: v=1; a=ed25519-sha256; t=1725464962; l=1819;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=SSBQqly1oyxDE2Ca0oLiGpwaCWTsOBymC3u7/XHMbO4=;
 b=QF3lcAmlCf/msSXa0QMewUP3UY+m0xPAdXfEtj3CUT88dq1I9QU7B6EqTftF+1svkyz2I3t0g
 nNm8rS+P3/uCS1HNQxCLyILEid/GSR2214SnvfhHByPINWXAkd3t3q6
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: SJ0PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::13) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB9859:EE_
X-MS-Office365-Filtering-Correlation-Id: 305fa641-1dc4-481f-1341-08dcccf92b35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cXZYT3pKOElac2lhYUtodC8rM1ZxV1VRb0tFK0RqK0hRaFl6WVZmbnQvV0w2?=
 =?utf-8?B?cWdyMVN3aU83MXByWDBkUlBkVmMwTGJCOUNXV3FXV0ViYmhBNDJIaVNlUlJa?=
 =?utf-8?B?cGNCZTd6RHg2OC9qV29vVHJZOEx5NWdZT3kyaFNybHVYT0tXS2tJL20wdGk2?=
 =?utf-8?B?V3loMEk0cmVtMlBPQ1E0aEN5NFZrdXN6SEJCR1NEaDNRNTI1bHdBZmJ1Qjlq?=
 =?utf-8?B?Y2ZqMXBNYVNLamlHWmVMTHBtNi9VQmdvNU1mWUVNV0Q3WS80Q09wTUNjOU00?=
 =?utf-8?B?ZFRYNXBRS1lIMzJXeWFqMCtkNmJ6dEFONnpXZzVjZ1E2aVZjMkJ2cnVENE8z?=
 =?utf-8?B?dmhtU2UvT0hLRXRTRDE4Rks1WEswVUE5V2pEdnFPZDNlSWw0Yno1TWtEUnc3?=
 =?utf-8?B?T3daQ0pKUitlemxjVXFiS0Y3Nzg1eC9WVStCZjRyUHIxaytBVVB4Y212RnZu?=
 =?utf-8?B?eFZ6TDJvNkpMaHJ5S3hqTmFOYmhSNFpDSE55ZytzVTlzWldGdTIyNmpMTVcy?=
 =?utf-8?B?UFB4aVVVSlcxWG9adFQ4MlpKVVhHU2dkNE84eUw4UlBpYlBSeGZVblM5Undu?=
 =?utf-8?B?MmhrWk1MRWdyU0FtSjVWVVBQR212UFhPWmFHZjRNeGI5TkVwek13bVF0MkdF?=
 =?utf-8?B?dUNUUkxnSDAxQXNYbTdBb1NzdDJnLzF3MEpJWE03eWE2K2x6UjBrUG50eWVx?=
 =?utf-8?B?dFpBZG1TYlYra05xYUZiQjc5Y2hya1Y3TmR6RlJaTmFkQXY3TUhyVkptS29Y?=
 =?utf-8?B?UVcxWVpxaGVNditLUHkxWW41dUVKTEcyZFNqQmVXS3V2WTRsVzRCNnpxRWpW?=
 =?utf-8?B?WjFDTnhuTE10c2MyenhSU2RQSnRGUGNRaGtTLzhNTmdnK0lPcUpkMis1ZTNu?=
 =?utf-8?B?TVM2a3VJS3ZGcG5JUUIydnY4ZERydVBNeVdkQ2djdTZqTktZLy9nTGpkRXpS?=
 =?utf-8?B?VWc0OVUvdUVkclhVUEhzMFJuL3lyT3ZFS01EZmQva2U0Y0JWSjhPdWk3TGxN?=
 =?utf-8?B?RG5NeFJKM3ZJTmVVTXRFQjlEaVFJS05jRU84ZE1Cemg4bFFFU010ajlkSC9z?=
 =?utf-8?B?NFNMcU9QRi9WV1p4QXJXOTJJVUdMRlFLa2F4dDhHT1NoOHBwSHlxZ1VFMlBn?=
 =?utf-8?B?QU1KQzFDbGF3d0tDS1QwVEhlTnVFcm5zVjMxWWEvR3BiYUZydU43UEpHbVdw?=
 =?utf-8?B?YjBaM2IzZ3M3QUswYnFOZ2k0SmZqL3JTSk5CRExJOFZFc2FtU05QYkxqVGpM?=
 =?utf-8?B?aUNrUi90Z1FLWjUyQnJCTExoaDBVMlNxRFN2blBkN3habjJKanRiQ2kzcnZN?=
 =?utf-8?B?a3pWU093Uk9KSFpsZzNacCt5Y1o1NGhGYlhEcDB1TXhqSkFCSlRyWlhnUDN0?=
 =?utf-8?B?VTFKMFVQSC9FOUx2aWwzZXZUY0dNTEhaZzdXc3FaMmh5N2ZhVXQ3YVhrN1lQ?=
 =?utf-8?B?NEZUZEcwa2tSL2VaNkdwSG5ieUtYTithM0JrQnRsR1FLTUdIUnFzUWhPNUdM?=
 =?utf-8?B?K1huN0JQWjJHa0FnVU91cFFIdlBtUmtEWHRqWVV6VU1uYTBNemF5RDVQMWJK?=
 =?utf-8?B?QkViMmwxTk9YVUxNV3pzREZuL1A4MTBvYmdZQUpiWkd4U3FxRXhhL1ZvdEFQ?=
 =?utf-8?B?dUJraFdhc3p4eTF4WlczQVRickgyYkovLzBQMzJJblp2MFE5SDJ6c2JtR2p0?=
 =?utf-8?B?bHJ1OTYycWgxOUVKdEltbFpiOVFBa0dBeGF0WEd3N3UxZXdnSUVXV2NLcmxv?=
 =?utf-8?B?UTlHK2Q4enA4L1YyNnNST0p4VmxnOUFucVM0S2VoQ3lvL0pvWkhKTXJKZ3dT?=
 =?utf-8?B?RXBHeWFNQ0lObmM4WFhEc3lLbGdmbUViRnAyYWxWcEdVemVSN2diWk1pb3JV?=
 =?utf-8?B?NWZhOURpbmZzVmw1ZEJreFl5OVcxZHlmdTV5bzRiM2crZEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(52116014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?V2NKUnJ0dGtLcS9SL09tOFVqQ2F6T0s4c2pWTGNURWxBZzArbFFaK2ExRHFo?=
 =?utf-8?B?Si9sQnZvc212NGJKQXZBUVZkZTdhWDJhZGZFOGJocjhZM0hRd2NOOXpCekRP?=
 =?utf-8?B?ZW02Q1pOSkVYNks2OGxhREJRQkdpdDBCZ3FnTS9BSFFHYVFiWmdtS3BuTXBo?=
 =?utf-8?B?Mklac2JVOTVVbzl1Q3p6aGs3OGRvcjN3Z0h4QlA4bFo2QklhaFpyYWZVZzR1?=
 =?utf-8?B?aVFZZ2Y4SE80L3g3T3pGNzk3U0pIR1I1TldCdEdpWng3aXhoZHIxS21mOThm?=
 =?utf-8?B?NW93ajhLWkVOeXhhNHpZTWNRTHJtVlZBb29kRTh4RTlpVWxzbWtjM21MZHNz?=
 =?utf-8?B?eis4ZlFtWk9DamQzYjU1VkdZaE1pVGs4Q1RwQ2ptR3FZb0ZYV3FkeDZwMkRO?=
 =?utf-8?B?NVJyQWVrRDkyaUtnQzJEYzlRZzFFZGxTSG5ZNjVXZksvNjlHY1Bpb1I3NVdI?=
 =?utf-8?B?R1dQMkNFMC9aN3FYWExiT1F5ZGxyT0ZLOWI0Vm8wTkFiQUFSbExxc1pISExh?=
 =?utf-8?B?eDRUMzN2UTlGZTNnNFhUdEJTZzBjYUN4d0hBa1Z3WUMzNXFTcCtSL1Yxdy9H?=
 =?utf-8?B?K1pUZTZTSFVSSmNURytzZnNLYVRnUWQwYmpIbEluSG8rVjQ2WTRSUUxQZzhO?=
 =?utf-8?B?MDVBMEYwd3FNZW9yNDY1TUlzNlVxYzNsd21yUldkQWtuMW1pZ3hJNmJpWlA3?=
 =?utf-8?B?YzNMaS94RDYrT2ltc1RHN0RiYkpvaEdseHloYkQ4aVNsQzlTZlludk1qUVRH?=
 =?utf-8?B?aEtEYVRvdzQxQjVudzdNUW02aTQrZVp6MkhBd3pBcGg5MldkdkI1cVFETnJ1?=
 =?utf-8?B?NGZhcHQ4amtYMGJFb0FqN2gvdlY2bDdEQ2s1MHcxL2U0OXlPZjNUd0VBYTUw?=
 =?utf-8?B?Q1ZkOHpNUFY4QjNacjQ0emw5ZXp6UXk4QkVsN3Z2cTJCSzExcHRqWDAzc1pz?=
 =?utf-8?B?V2RiREwrbUxoUTl0WDZRSSt0NmMxL2xNQnNRcHlRYzhuajNZblFMM0dmdU8y?=
 =?utf-8?B?R2RqZ3hYbW5aWTQzODY5Zjl4eVYzSzlLaGRSd0hUMWVRdU81SUluVmIxdGRJ?=
 =?utf-8?B?Ymc0bXdLNkFDZzAwYmV6UW9yazk2Um1HNVZ1blNCb3F1cGVhQkdOUjVQL2JC?=
 =?utf-8?B?Q1RPV0Q4R3lFTGcrSVIwM3lEV25HT3ZwNllQVDlwSGJNd3B2Y0JkTzhZRmdJ?=
 =?utf-8?B?QlNKL2tmT0dhTEt0NFNtVGh1WHJLU0xMZHBrcEtTZ2FVK1lGRzVPS1pCcHhV?=
 =?utf-8?B?MWMxbnJoRGxBRXpqU2NaRVUzQ3Q0UFJ4NldGS0F1QVd4d0phWUVaMmpneXVz?=
 =?utf-8?B?R2RsNEhaL1BucGswcnVPcVBvZnArV21lSGVZZmp5NWE0UVNXZTRFd1J1cmRP?=
 =?utf-8?B?UHBMemxUc1pVcW5GczF1WVlJNk5zZjVBK2NHYk5GK3VEZUkrRkF6U3dHVzAz?=
 =?utf-8?B?dU5ORGNkemhLZHdhL0pyL2dRYi80L3NkeDZmUVZ5bHZWQjIwUG9IcWU0Rm81?=
 =?utf-8?B?bmYxcFlrd2U4MEIwdngydno3dS9kdWU4TDZXOGEvaTROK2tsWmJ5RE15MW5J?=
 =?utf-8?B?MDczaVNwWEtGWVloNUdrV2FNSWJJSXhJM3VjUUxJTSs5VGwzcmxUTUl3NTBW?=
 =?utf-8?B?VmZjaWRJY2dWSk12SnRQSUtQNGxyajhEYmJaN2pwZGc0Vjl3M3JEamNva2Fl?=
 =?utf-8?B?WU1kRXpmT3hIckFONXE5cXd1dWZ4YTROelVuMEwvQksyeVZZYk4xUmlqcFV5?=
 =?utf-8?B?N0FtQmtRbTVXQWNNbk9JNXY2TTlDUFkrdkQ4QmhRWVUxMEswU2lZcGtFTzB6?=
 =?utf-8?B?dERiamRBbmh6ckNySHFXM1JMT1Zyd1MrLzh4ZEhsa3ViSXFxRG5hekJjOWZJ?=
 =?utf-8?B?NitBWk04Mll4YmFRejZJM1lHQm1Ca0pFeU9ubmRPMExvOWdpM0d1b2w4Y29B?=
 =?utf-8?B?dmdBN3JHOHp6ejJCazlHN3doSUh1TkxWenpZRzMrcmdJZ1V4eC9IbTlvYko1?=
 =?utf-8?B?bFRXZXc5R0dOd0dLWEFqZ29veDZ4UjFYQjd3eXc5RHgyY2piTDhQZ0pDWDYv?=
 =?utf-8?B?QzZrTElXYWpMTG8xSDdmMXNxc0ZGT0NMTUcvRjEyS2lzeXEyeUQyR0xRby8y?=
 =?utf-8?Q?DH05bWoQdqAZgsE4VdNiZb85o?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 305fa641-1dc4-481f-1341-08dcccf92b35
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2024 15:49:32.4584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WwqYLs+odmds+CMXJ9RWxd+Bqe20X0CWg5/kqI/J66sWTdPhiWD4rx+yBh2PB2ZyW/pEBKZDBgxaGAefxtnMgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB9859

Add 2 software manage quirk properties (xhci-missing-cas-quirk and
xhci-skip-phy-init-quirk) for xhci host.

dwc3 driver have PHY management to cover both device and host mode, so add
xhci-skip-phy-init-quirk to skip PHY management from HCD core.

Cold Attach Status (CAS) bit can't be set at i.MX8MP after resume from
suspend state. So set xhci-missing-cas-quirk.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
Change from v2 to v3
- rework commit message to descript why need set quirk.

Change from v1 to v2
- use {0}
---
 drivers/usb/dwc3/dwc3-imx8mp.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/usb/dwc3/dwc3-imx8mp.c b/drivers/usb/dwc3/dwc3-imx8mp.c
index 392fa1232788c..bd6953246f42e 100644
--- a/drivers/usb/dwc3/dwc3-imx8mp.c
+++ b/drivers/usb/dwc3/dwc3-imx8mp.c
@@ -144,6 +144,17 @@ static irqreturn_t dwc3_imx8mp_interrupt(int irq, void *_dwc3_imx)
 	return IRQ_HANDLED;
 }
 
+static int dwc3_imx8mp_set_software_node(struct device *dev)
+{
+	struct property_entry props[3] = { 0 };
+	int prop_idx = 0;
+
+	props[prop_idx++] = PROPERTY_ENTRY_BOOL("xhci-missing-cas-quirk");
+	props[prop_idx++] = PROPERTY_ENTRY_BOOL("xhci-skip-phy-init-quirk");
+
+	return device_create_managed_software_node(dev, props, NULL);
+}
+
 static int dwc3_imx8mp_probe(struct platform_device *pdev)
 {
 	struct device		*dev = &pdev->dev;
@@ -226,6 +237,13 @@ static int dwc3_imx8mp_probe(struct platform_device *pdev)
 		goto disable_rpm;
 	}
 
+	err = dwc3_imx8mp_set_software_node(dev);
+	if (err) {
+		err = -ENODEV;
+		dev_err(dev, "failed to create software node\n");
+		goto disable_rpm;
+	}
+
 	err = of_platform_populate(node, NULL, NULL, dev);
 	if (err) {
 		dev_err(&pdev->dev, "failed to create dwc3 core\n");

-- 
2.34.1


