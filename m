Return-Path: <linux-kernel+bounces-317387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0F296DD6A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 17:10:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD815284090
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 15:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53EC51A08AB;
	Thu,  5 Sep 2024 15:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="eECuB1AD"
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011023.outbound.protection.outlook.com [52.101.70.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C3916F908
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 15:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725548879; cv=fail; b=c4ZIDhWKkozlkwauLQiecGypYs1ZM42SwgUZA42kmsg8j8rMwtVrm9ovTgsaI43nEqv5n11k+HyIO0eVq0HZiWrO5aR+rQ3Ej/VcQmnczfT4ODBFfFhK3yaoEqnxg1hiEFVbSlRrj8LJWzEA5jn5VkMFlIvrvhMjIxbdKwVHkiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725548879; c=relaxed/simple;
	bh=Y8u/fynf9//nRZt/lY9lHUgf919tt/HmWWqY6YJ9LvI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W/Xie+UGU0SDJkMC7ixtkvTIaLnjRaASa1hVHOBS3UoatLdLJKmucnaRNGlg8JCN4qL66m5d/1J7Pfeks5Yxo5XOtsh+dhQwoTJL2K16flmzdyAqCJiWBbt7Wie6/KcPMxb8jIxSG4aNBk1AHaEyTUHb0HOWCmTx5XhVCohO6hg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=eECuB1AD; arc=fail smtp.client-ip=52.101.70.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=swj/vqeDO9CDO6Q6eNTcZeaOLqWK7Ub2mctdruvv3SQR+HEuXAUquMgaUZ85ePLquQa1gpJEJxeZNkd+d5uVgsEG5n8GW2Ai2PnEmSC1qhLQ5FWAL8qdFgkPdHs0Egl3/A2pGs7Zn09rf9T06QL8+kwi2mzNKmDgJUUP/5CDI7O4I6eVxgZh+75eeLQqSr3zf23qxNXw5RH0BN91xT990+tg4xwf8npg2wNpWzWNavGv89ngDXZL5PZJED8wLL6Y9b7LonwtLHHfnboEa26lY44WWo2sZso0ltrm12HpE4PjPL4ZamKpe/CgWrJxYYRlpXHe7vthZ4QHmRFy30EDng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HLltFxx3nsYekv2O1PUQxkWnaUeQTa7nrwL6wk7a22A=;
 b=U0GmKIbEm5wRZUPpHIU2bI48uk7jGNrs5131tK5cVLbyCmf0HF8H1BK6aMCBZcWzpFLnekoyPK1Nrry78aCjI0sZarLPtUJc1/qB1FNhZCPOcsPuV+6Q7UabzqJM3yfiVhTGHnu4FC6wB6996BBQ1/4ha1nkjWaPWFopCVsOkOukaRl79gxKZsJd2Z/cmJj/AondT5CrmYw0QbDGDoOWr9fRYb/13OWWGYMRAw78yIU/EMC91oXuFwHZQfx/5Zg9SNaOwza5W7ZqSnXHu4SprBT7HQ/AGx1JgqHOPM5lppV03gDR8U1W/Z6rkywp8QraejyCHF10l2qyJJ1H+vH61w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HLltFxx3nsYekv2O1PUQxkWnaUeQTa7nrwL6wk7a22A=;
 b=eECuB1ADmelnPPB5eFB/AAnoGBkKb2zxvWzXiOXCEwufLqn/MhLjWSaHz084AFSNHqkj64jjh3X1zGxOFfiuNmBpFN36Nk+lO8mR1l9O6wlbsrt177RwP7D71USHJ33zMp7ygktFMpIy/rqxlVcoueq2xw6NfjjEdRGOmF4fcfTpfx97cJMK0y6ipc7xx8tk0ugiEU7WGBYrT9OO173TSpJsLGNSJ8MBcxUjrzi5gercqg8rRU1x48z/kk90JUnYlWNozZiVoP8irAZ6How9pBGvbFDRqh7o5SWYvVcL+eGt2r5KWVrhLviZB34SFflKixLyV0QK8UThJ4JG04lAkw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DBBPR04MB7628.eurprd04.prod.outlook.com (2603:10a6:10:204::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Thu, 5 Sep
 2024 15:07:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 15:07:51 +0000
Date: Thu, 5 Sep 2024 11:07:45 -0400
From: Frank Li <Frank.li@nxp.com>
To: Mukesh Kumar Savaliya <quic_msavaliy@quicinc.com>
Cc: Ravindra Yashvant Shinde <ravindra.yashvant.shinde@nxp.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	"moderated list:I3C SUBSYSTEM" <linux-i3c@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH v2 1/1] i3c: master: Avoid sending DISEC command with old
 device address.
Message-ID: <ZtnJQdu2V2DPmT8R@lizhi-Precision-Tower-5810>
References: <20240820151917.3904956-1-ravindra.yashvant.shinde@nxp.com>
 <3da836dc-d79c-41b9-aa44-06a94b812bbf@quicinc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3da836dc-d79c-41b9-aa44-06a94b812bbf@quicinc.com>
X-ClientProxiedBy: BYAPR07CA0064.namprd07.prod.outlook.com
 (2603:10b6:a03:60::41) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DBBPR04MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: 8550551b-3aa3-4e5e-5f4e-08dccdbc8310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E31lthL3B5tlmXwQNWzGcSbbhqXVFNfcl+jPFq9DPalgkn+X5ehFc6fGKwQZ?=
 =?us-ascii?Q?PHOBwlZFDaVxAYrjPA8lYl4FtysB/D0P/ajeFosrriD0RcP9EYg9LLJ+SG+P?=
 =?us-ascii?Q?pJJSCn1IC59DM0o1vplAzZaY5HzoKGRkzdYYGbs3KmN/amXjc9qTQ5Y6YTDI?=
 =?us-ascii?Q?hXf77QM2/kMHw2ZK2I9Sre+1SwC/+vc3qZsrfMO5PVcsSpckmc5COnNf6Z8s?=
 =?us-ascii?Q?1JmlGCX44Rxvvl+WC9BXE0lU3sVCmHhPCrDMZW9Am1qqgruMGLqX7R4Ak6fO?=
 =?us-ascii?Q?JG991SmYnED9MqrMCfx1Idyj3/muomt3ci66Iz1rTsDxRm9RKcsGFH0G3V7O?=
 =?us-ascii?Q?sZmvrPbTAzmCCjkH6DkhIWY/Ru4JiOqIh18znhWIWpaaTWcDrsAFAL2JFU9T?=
 =?us-ascii?Q?5MnpBIw0M2V/o180Pv2qCRAozM+ZM5Hk85CqtWBEvvQ9rHKeoa1ReO5Og5Tj?=
 =?us-ascii?Q?jNV0ophrpsarP4QBrKf5jP+cuxHNv9uRHeWJtUtBYEtvbXFooV4pcSWxBJUo?=
 =?us-ascii?Q?8qeuUtqz6Him7sbraOL6RvBqnnGSc1Xoe0+qusuM48pLZXFO4mosQQ/Xw4xJ?=
 =?us-ascii?Q?QxuGbRL9c3XUkccARqSXFq5vr9BNadBJfZUPXeY/2Gqy/scAeG4K0oZrI3k1?=
 =?us-ascii?Q?h6bWUOiB0KRtG1PduXnVnLsjBeg8PrjxjjJyMlHhTjtp1PRK/S7FR6Mf7RJP?=
 =?us-ascii?Q?gTeibtKf33zMNrsehX96kcPQ84HH8B3o/E6/vpQFm0OfKHMrYcXs3/ilGYFK?=
 =?us-ascii?Q?mknYgKnBXOuMxnow6DnkM2NVvMY/0cje/6NPJSpz07odgbSQ0ahEJ9Nn7MY3?=
 =?us-ascii?Q?bWBhgRxlD5NSlWEs/pP4sdMzc/EFcW3LkxG47yJe4d8w+Iry3N92FCeDwgQs?=
 =?us-ascii?Q?NWr+JgRpbmKWpR/kyRsB8c1IHpWIjdgeEqRHSxFOYfYN/IKIFv8WHDXI/tIL?=
 =?us-ascii?Q?CqZVrCINCA/i3D8PrhFcwTcByASlJd/j5svEacAdlupSJb7a2ecN5xhEQZSF?=
 =?us-ascii?Q?m5mnDF25Wh7J5BOuOw9zIsapx2hsqL+ZMbJqoRHMxLIIjp9S3hmFUPFCQDEV?=
 =?us-ascii?Q?dItVdm6skPHm/ivGjSCmzcGDNXkXlF3XznzdXP2eLWHpYq3Lb5Jmm5jGmnJ5?=
 =?us-ascii?Q?2JS+xa9daFrIzEn2NiSPdzXL5pgM1yp2m8QHG3MZignKP13BxB2NUfbHS6e6?=
 =?us-ascii?Q?2GvmkQ6I+kAA1CJE1eeFh+6sPyd8D4cq7yatzSbK8Y+wi9O1v+JVtJXmqBUv?=
 =?us-ascii?Q?/w4S9Bm3ZItKA5y0RJJRKtUybNsqamKLd6ypjs+OjDbC+BVAK/kV2H6Lcu79?=
 =?us-ascii?Q?x8RvdaG/a+VG2xVdGTO1WbULyhJcA+k/m/E+OpTJZq+cBRS6cu7/9+24c9KK?=
 =?us-ascii?Q?lpoOrlgj24BmYsczMUK8EIJFv82XBOo+x3DiVBwQy8OklbnmRQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6mK0tIgmHftLAPDoTxMKUkYGInpOmp9BF4EbbUl5/crwg6NFUpjVixV/DeCu?=
 =?us-ascii?Q?alEy87+qVK37wFEKkPj879XlBue+otnVp9D5mhvYCRT8PmlwYRNIjHIAg4a4?=
 =?us-ascii?Q?59vWsbLl7UxvlobhlZq42spEVgOXF0jiB0llk62HAia1rxrg/j8zfyy+or5d?=
 =?us-ascii?Q?KNiV/fZo6rPQcMf0CD02G/HjBmSlKeMByioS/2zjrI5YBKWSeARm3E213Ns+?=
 =?us-ascii?Q?WWDRg3YD3MaCy1VhwsZIUqqmhBl9F4Ia/aaaF1YoLrXi/Sx8VvhAm2nIXljT?=
 =?us-ascii?Q?a/3D/q/VC8LKNQFQPxGAnbeyiRH6Mg2QSrb53twoRWF2k2ksEv6KxIwWXTzr?=
 =?us-ascii?Q?1JC4zAVtQyf4VrF3UGtTJQ68L8xiUg93gKFmAbjJFhVtiqG6VAkoO0QENkI/?=
 =?us-ascii?Q?8XXNzCk+J8HeBgocBvcO+WhJWLPnq1YI7LNnf7TQRIWniI/UXwlqZCmiJFrS?=
 =?us-ascii?Q?/azt+NAqIIN/YvnZmFLyOZ/qpUjICqudFQweWDE3dF4umykrvkQqg7LpbVTv?=
 =?us-ascii?Q?clhB/5EHi1S7tvpGQ96kdNKQdWFeuPw1sTIp24vOYfZfRheonNUVsavmYh0t?=
 =?us-ascii?Q?kLKYwLfLmMFMV7yPNDnWv3ZqvWu7OHpNPvkADJTXao3hLvw1UfmJmG/LiBJv?=
 =?us-ascii?Q?9RwL6r1nMuqQGycdMvfK/ntVSIBbMx//fhljudDqthb2be2I4kf77uGnRDas?=
 =?us-ascii?Q?0rEmArWLpjsW2qeyajWpQvtfNJPd8CLy3Eh6wz83ImOpu4OAtvInbFmZcwHW?=
 =?us-ascii?Q?NMuUfhPzkaScfx76BVorrPIQ8HqeDDicVzOdQjVazO3MAdnhnVLBM8T2gKtS?=
 =?us-ascii?Q?6wZsa4Awb+s94K1g1fd+ZW9JMC9wJlGIt5Pbju1HL4+bQksYAnVLoYYSEuiB?=
 =?us-ascii?Q?fGquVhHNgJWQ1CKWXo7EZC9kw9Wf+0hOQ3urkJZufOjfxX3Xv3LBDm9tAHqe?=
 =?us-ascii?Q?6hK5stdHAMRA2wibUCemIXVVK94whOVMUVyGGyGaQ7n/oj3LjPqhwzRe7aMt?=
 =?us-ascii?Q?1xOt+Hym6hsjM/XXyT/YTcpK//LwvbiXpd9zD92kZUWwabBqM5gQBf3R23QC?=
 =?us-ascii?Q?9PKkeVF89JpZCpolAH3uJr/h3/cJGZiKihwGRzGYIVfyz0YVmWWuZaSl1U4s?=
 =?us-ascii?Q?pF5gPorN91pxCFjMkJ0rrfFxpqnirb7y9dLloyZ+1KULLXdO6TMcEHgbGxvv?=
 =?us-ascii?Q?aCOJmkgjIHMtk1S1txwJnJRzzH8X/PFTaKcjokN9Pjx5ZaOAaPtLfDZzJNUG?=
 =?us-ascii?Q?w/F2OSQTqWOuTtQ5OVuoA1br7wHdUW9cT0vwVeeaMwuuQ+BKYaeud+oZgvE3?=
 =?us-ascii?Q?hav4tsJa+pZD0kc4e26l0eyhVoOm36Tvf88Lp6Jp/Ti4bO9cghgBPS1gj0xH?=
 =?us-ascii?Q?ir5Phymb9jJ50tf18mz/EvTn12xTUJ+I/7v7dwM/h6FJH7Ef7i1QOZUd7TAy?=
 =?us-ascii?Q?SnmEBPMah6VkgQy2T6tU5SIddh1n3PmAG5Nvfhx632eJeYeqAQ12XuOVGDwC?=
 =?us-ascii?Q?Gbsm5/3xu9MAmQa580IeoadLKch/gVtiT+c9C7X6WEiwvufWJwD6WfJCJrcL?=
 =?us-ascii?Q?+8IjhoC9LQknm+ZaMNY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8550551b-3aa3-4e5e-5f4e-08dccdbc8310
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 15:07:51.7371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UCtZ5eGFSTpY5zNTNFVAP/n1pXvUHhQGF4nNAaW0g53f3uJiYTGSBBngz9IQ6Ehr0Wd6/TjkZQtXi7h1CI7A+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7628

On Thu, Sep 05, 2024 at 03:25:09PM +0530, Mukesh Kumar Savaliya wrote:
> Hi Ravindra,
>
>
> On 8/20/2024 8:49 PM, Ravindra Yashvant Shinde wrote:
> > When a new device hotjoins, a new dynamic address is assigned.
> > i3c_master_add_i3c_dev_locked() identifies that the device was previously
> > attached to the bus and locates the olddev.
> >
> After  2-3 reads i could understand what exactly you are trying.
> Could you please keep the complete commit log here ?
>
> "
> The olddev should not receive any commands on the i3c bus as it
> does not exist and has been assigned a new address. This will
> result in NACK or timeout. So, update the olddev->ibi->enabled
> flag to false to avoid DISEC with OldAddr.
> "
>
> Make a complete story here, you don't need function to be added here since
> description should make it clear to understand.

This one is only partial fix this problem. I merged it into
https://lore.kernel.org/linux-i3c/20240829-i3c_fix-v4-1-ebcbd5efceba@nxp.com/T/#u

This one is full fix.

Frank

>
> > i3c_master_add_i3c_dev_locked()
> > {
> >      ...
> >      olddev = i3c_master_search_i3c_dev_duplicate(newdev);
> >      ...
> >      if (olddev) {
> >          enable_ibi = true;
> >          ...
> >      }
> >      i3c_dev_free_ibi_locked(olddev);
> >      ^^^^^^^^
> >      This function internally calls i3c_dev_disable_ibi_locked(addr)
> >      function causing to send DISEC command with old Address.
> >
> >      The olddev should not receive any commands on the i3c bus as it
> >      does not exist and has been assigned a new address. This will
> Isn't this the same device who raised HOTJOIN and seeking a new dynamic
> address ? you intend to have no communication with older device address
> right ?
> >      result in NACK or timeout. So, update the olddev->ibi->enabled
> >      flag to false to avoid DISEC with OldAddr.
> >      ...
> > }
> >
> > Signed-off-by: Ravindra Yashvant Shinde <ravindra.yashvant.shinde@nxp.com>
> > ---
> > change from v1 to v2
> > - Fixed the author name.
> > - Unconditional set to the false & added some comments.
> > ---
> >   drivers/i3c/master.c | 9 ++++++++-
> >   1 file changed, 8 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
> > index 7028f03c2c42..0dd8d1c28d58 100644
> > --- a/drivers/i3c/master.c
> > +++ b/drivers/i3c/master.c
> > @@ -2043,7 +2043,14 @@ int i3c_master_add_i3c_dev_locked(struct i3c_master_controller *master,
> >   				enable_ibi = true;
> >   				i3c_dev_disable_ibi_locked(olddev);
> >   			}
> > -
> > +			/*
> > +			 * The olddev should not receive any commands on the
> > +			 * i3c bus as it does not exist and has been assigned
> > +			 * a new address. This will result in NACK or timeout.
> > +			 * So, update the olddev->ibi->enabled flag to false
> > +			 * to avoid DISEC with OldAddr.
> > +			 */
> > +			olddev->ibi->enabled = false;
> >   			i3c_dev_free_ibi_locked(olddev);
> >   		}
> >   		mutex_unlock(&olddev->ibi_lock);

