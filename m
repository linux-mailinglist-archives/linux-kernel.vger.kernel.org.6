Return-Path: <linux-kernel+bounces-344324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA4398A84C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:16:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E00E2839DB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 15:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585171922ED;
	Mon, 30 Sep 2024 15:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Q/fqjksP"
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010049.outbound.protection.outlook.com [52.101.69.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983CA18FDDA
	for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 15:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727709383; cv=fail; b=eiPOXgHWsGmgNipqdX6SVlxp1w+V9zcHvK+fywBlpOLYetX80UnpHIzOgJE5IGlBvvJc+FnJ3+lPOySXQny6hznGXXImLMm5+oO4G5wko+m3DfEC784ttNWrkhgMQ40PIPle3eb3OVHs0dKbBrXVbFyxi3cfUjw8rUh8DrKsSX0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727709383; c=relaxed/simple;
	bh=KCir1UjYhu++FQ2aObMIby6ddy09GUWHTyotDInRd04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hk/94jf+NNdqbpMjTiqUeltcNNVX8aKYEPXwGePvDkWpWW0QiXuo6zYxuIoS0nGCWxSq8PCjuTBytwB1Xgr2LQwHOccvspzukOSRzr6CD/fqEG7YTsGawbn1ZSnkhvCLR9/PBYlfJUYfVoEwHGaYuuJjzFuUtPAd+HDBdzYDCuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Q/fqjksP reason="signature verification failed"; arc=fail smtp.client-ip=52.101.69.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRGkBPwTdmJiydZmfVIklutKiJs0FUUY3/cH0PhfndRoz/1ocD4cJFqZP9xyzpBzrnnZo0rAy+YV+YK20CpGf6+MYqW74XyIyUeBzkgqH0NkQHpttZwP1pm2ZtGfyRKp5NfGL+6559rP6jH6q7RjrXinsD/1CxWmq0HpYSJLVW5rYm+I+227D7ieCNVWKt5eVEABkVEHpIuIOVWVxVIS0txs2wLnC2jD0FWYp5GgarsUbMhzrVf0ufPA76wKmjDglOKAd6Fli4OckcdYoS42cESTjQdoDmB8D6OHxUuaWJcMmfxmkjRdTiknSyASgSnH7wR0BOCmaI+aHL0uqvqkgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aLnhwka8UvGyA38XIXCjyFnF6YKZp/dkllH9GKHbLhU=;
 b=KFK+VxPPcwznvDmEQq9hAaGz3OuGHsxMnJIUNcDUP85ZZomWa2BWBOt5AO7PgQrO6d0Cay3kIo1A7B8gcuhAexpRxGvHFJ+RtDI5ozUQKMVcoNBLP0bEBxrFCTeZERKD6SZIUEOGtH52d+JUlOPAEBc/pPbGp5y1aroKIPyMF+qNh/5VQdXHSqNPwem7Nd0VGCUK2+aoG6p790mvFssYc4gg1EcDvoyERRyDGxLPrxk6KztZFTeiZAi1PNCn+Tyc3qo0C/TJhbvhTMRQ3GOy7QhPU9/nZOM4I5iRDIHSuNnvUtpMgjnsKCqhDhv3wt4ASosL4nOOejek5qB3dKrbZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aLnhwka8UvGyA38XIXCjyFnF6YKZp/dkllH9GKHbLhU=;
 b=Q/fqjksPezbpUShQTE4JGmf8DciIMiwt84UBypcUKSwcVVe/2N9/pP6dxjXodbOWw1KFQnwYWZUQL2ABd3m0u/QX79P699+M0d+RIs/uyZlj+htJnUbUSDFzWILQwim29Mh5sOPD6FcxrUfYtDOpRpsahr1sP/ENp8prxFjdtMJQdpiLsaAXsgNxM1aIaOyihKLrFQUA1d6qGcKEIZgIb++7HByn/y/hsnp49cqqUyNIR2HmuT7R4rUSzhoflt0lbGaohtXC8oKvwdN6ONYzzfaS904YtWmfQCpUI5x+nPpHQ85IY4RZj2PfrzsirW/Lwjs/lgxxSMsDfzVeRYvyYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB9PR04MB8266.eurprd04.prod.outlook.com (2603:10a6:10:248::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 15:16:18 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8005.024; Mon, 30 Sep 2024
 15:16:18 +0000
Date: Mon, 30 Sep 2024 11:16:08 -0400
From: Frank Li <Frank.li@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Boris Brezillon <boris.brezillon@collabora.com>,
	Parshuram Thombare <pthombar@cadence.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Conor Culhane <conor.culhane@silvaco.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	Ravindra Yashvant Shinde <ravindra.yashvant.shinde@nxp.com>,
	stable@kernel.org
Subject: Re: [PATCH v4 00/11] i3c: master: some fix and improvemnt for hotjoin
Message-ID: <ZvrAuOBLgi+HtrPD@lizhi-Precision-Tower-5810>
References: <20240829-i3c_fix-v4-0-ebcbd5efceba@nxp.com>
 <ZvWTjjuRU26dTyKT@lizhi-Precision-Tower-5810>
 <20240930113436.318a7c0f@xps-13>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240930113436.318a7c0f@xps-13>
X-ClientProxiedBy: SJ0PR03CA0390.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::35) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB9PR04MB8266:EE_
X-MS-Office365-Filtering-Correlation-Id: 40554b61-f017-4968-20f3-08dce162d529
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|1800799024|52116014|366016|7416014|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?iso-8859-1?Q?7gvPwe1dcQpCEWKHokrp3TDl4seiHi5Hpw+xYDNAzr6OTljDRauanoOyEq?=
 =?iso-8859-1?Q?mS1nehK9KOL2/RlGePyzNLUv4+es5zDWPU9l2uzg44bgSEclbD6uHpZDHt?=
 =?iso-8859-1?Q?kzuvaNARQioYxIiB+llhSrZZsGhqMeilD6g9h6fvurirL7ES8dj7WuUnBl?=
 =?iso-8859-1?Q?zZ9xEeXOPgYa15xd3vrm+xD48Src986zftOX3QIqTxlDN3WXWq48ud+u9f?=
 =?iso-8859-1?Q?YwHh7+Fi6EfDT4BPmg/O2ZwzoB9vrZ6UP/GZtcqexrYB8tyqK5OebKdD/N?=
 =?iso-8859-1?Q?Hp33CKYNdzjVwcXk7+by+7ILZISc+tG/3MFdbQDJLJc3N9ubROgcXQyDlI?=
 =?iso-8859-1?Q?0RPs+UqobPpUBUvfOLxaVArYW89HDHRtOUY8saorWTfr/Oxr8uL4bv4Eeq?=
 =?iso-8859-1?Q?JgYKcHSfTV8+LS0iFvvjVkhlUdAxJa3jrMSHEJkTdI9H+jaFFL3Z/F+5y4?=
 =?iso-8859-1?Q?ghFcf+zw28KsSFurIGi1GkKH1v2dkdY59mf9RFuVhZC+sztYLi6H6YbUSS?=
 =?iso-8859-1?Q?PzcFbPzpKfQCFy7MgspNXsPFfaeFnur1shG+gU3DPRc3jK0zD/htQzTNh7?=
 =?iso-8859-1?Q?18sb75mFpsrDdnRFduiIXm1r2D780A/zOfCoge9f3KLA5qd1Yc3iYCjQrx?=
 =?iso-8859-1?Q?Ju3n79XCCI0utfQyfHDncD54NJW8E85GkIpuEe1rSqm/fycJlIh8EKWCmm?=
 =?iso-8859-1?Q?jzMQCfw/tDQ4o/kJ+9SQQ2+LhYvS48roKAyq9dovkzePjVE2wTMitpHTQZ?=
 =?iso-8859-1?Q?3LNO86vG9HiTMyURpgYdmgIu3Xg1xn+LTCZd8Fr/1uBR+Z8EnAl/82iqih?=
 =?iso-8859-1?Q?dz7LVCgGocy48r88HjDHluAxMZVlmcP9l6Hh2Ekl+86TF8ZnwGPrHSHlfv?=
 =?iso-8859-1?Q?hxwLW76M18nGDi9HuEDCt06cb3aUzDzu2xGW/mjaLC1iQPOxzLk3rGudzd?=
 =?iso-8859-1?Q?cyWV7q4mDViBMTtAzkdrPxcK6fqRQoohDT72be7hy8ZXFhl/GrJTcd3Dh+?=
 =?iso-8859-1?Q?JyWYh1SqElOBPf61DadNSovMYhiMz4zB/kRJEcvJRIcyuDRJa9BFHgatya?=
 =?iso-8859-1?Q?qHRMUqNF9XmXAZytN73L/eRsERN9R79Z7R8bLn7lbNqXzXAJ2uIuUI6+v0?=
 =?iso-8859-1?Q?lI//IA8pXcMEZbBpOJ+ix3sIHnhghedsCvZ9dSEudxokyMrqL78oB6uEgf?=
 =?iso-8859-1?Q?k7SRNebYH773iPTdVL57bMeTWAjqEalVSxipbJPpBkIA0sT+nBDHbz8pcZ?=
 =?iso-8859-1?Q?YyEZMJ0ro+HNfaHdPC4L84Z90wUylvNNmo1xElaZ9p58RdBNBO2CKTTPOm?=
 =?iso-8859-1?Q?zjzONhD3NHZ/pmbSXz1EEH78c2/R912DDYi1FGxnW/icR5jDMKQS17jx/D?=
 =?iso-8859-1?Q?yL75ZIaKRPTVtKj9DAsZr4DWdTE6aDTsxaib3Pg1ZI+MhZVaOxoyF5cfls?=
 =?iso-8859-1?Q?PlLkro5UDF1ghegONlDyU0JVMEpiKpHBvVcf8A=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(7416014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?iso-8859-1?Q?7w4LAq7d9TbuPXwudlL/MqT4ZTa7/P3VoGawAY0DYX6s3PsQUG0hmlot3j?=
 =?iso-8859-1?Q?7p0QjiybpdsIRCD9rHIj5v+2rX9TdHLlvz2kCWBYAe1Qe9Q8t0Z++N9nU0?=
 =?iso-8859-1?Q?vIaPXqRJTqTxbwVp7ctc1EjiCPUdQjRU+eVtge4WYozmH6lO4zbizgrdwR?=
 =?iso-8859-1?Q?WTuOMtQs/cUnjdbvbYiLabeTxlK+o0Fg19TwSvvH18foh+Wc/PrAmY0wQ9?=
 =?iso-8859-1?Q?PEY9UdritP6RLTyE3NfWSbELgIMT4VRNy9jx1bV1f3SEfxdRAcPP/axZCl?=
 =?iso-8859-1?Q?+VUKLMVAEY8ry8faKfQltRlndRcgnbSSfvVoqKkFegN2aMxubsPzYrx3Wa?=
 =?iso-8859-1?Q?rboh/Zh8/iLuqlgQs9jVfR0NG+iDSqqmPSW4o13EIBI7VtLokpu1/hIwNU?=
 =?iso-8859-1?Q?hEdRIJy2uHZ8Nc95ZNJ2phy4+e7inVv1G5e1EMTLf7cPGObmsTRxIsZ4qd?=
 =?iso-8859-1?Q?by/rK3+qarRd/5/DXjFz0g7zN/cVRh2KkwqBfer2eb8YBGZn6/AwDVPxQw?=
 =?iso-8859-1?Q?0Adg2PzOUUZ0UPjF1AFqiNdKzEmPjfjcLzqpjP1HWnXYIRTlRrElwk2OzD?=
 =?iso-8859-1?Q?DtzxVmvD2RafZ6buYS8IVYOmkA0y/3KXptJdysYoxc0PTtdv/dDeVgpSr0?=
 =?iso-8859-1?Q?EOLjteb1yAIreSLlty54KN/K7cY3Ww6EN324txadxXeD1yRCMebuvE+H1f?=
 =?iso-8859-1?Q?SzvBSUImlTlpd5EPC6Rom0+uGvkUlQC+kpfC3mLN95myKOJuEkNhKHkylm?=
 =?iso-8859-1?Q?FAQKhnkKb0hi+SqgRoLRTsgN6+DXiG0NAMJZLb+YgtlxMUHmU4dkgGSY4g?=
 =?iso-8859-1?Q?hkYNIUGGXVGjdLSyoX5xBRLCeObAd512513Iuw5RPNp4FgdBmrY5K/oNlp?=
 =?iso-8859-1?Q?/KusXO/77kJea5CDaXLCcDyCYVsTzEjzG8eq7pug87xBPYoaX87LK+LJcr?=
 =?iso-8859-1?Q?wIDJzi2Gc1UMS6sFGo9aKvvx+eiKBowQUlZTm2Ia9pMTc3N6Ll8eFqzbzO?=
 =?iso-8859-1?Q?T41N3WH40T5IGzdvi4T0w1h1rpRyAJG8baMlZk9PJAC9r+CBXBx5L8k+Wo?=
 =?iso-8859-1?Q?Jd44Od1E1u/8yPdplOL951KiXfpNaeKHhMCGJ1L7BOeyL94JhnBFEIaquR?=
 =?iso-8859-1?Q?y8FhfAR7m8N9SxXnx1T3G5aE3FfJTxG4V7CP4oRL0uVZWQDOcJPJXIvPOr?=
 =?iso-8859-1?Q?HwSK6tSmu68mZPfN901z3ZhDITdhG/48tavVce7QY6EgDbYuvye8VeRcWc?=
 =?iso-8859-1?Q?lUf9xlnADVhPwbjljbrWAwsNLDtjaw/JLliUOzJ+LRvcitQTaqJJQOQBGo?=
 =?iso-8859-1?Q?lS5jIzd467FykClgessbzf7DLRGmhE6MPEkOk8VMxobgTtw6FUXvSYnofH?=
 =?iso-8859-1?Q?pFv/hizFbNsg4Lq+5uQNsVQ4qX8SynEhC5+3p6lVwylE228eK3JG/OwBe3?=
 =?iso-8859-1?Q?bstyYVjJCoDg/OrHhvtvvUmuXjlC/aB6pyePvSQ99GlxcoJKyyXg0yFXgO?=
 =?iso-8859-1?Q?ePIt3tzBFh1LgtWbuPpXLMsxjcIcNkuRmTgw18ge2laGDuoCet5munyHtu?=
 =?iso-8859-1?Q?57SOThtf/2W5YEOZ4hSh+XqKKKjPQ5Xve27kPp2qMGSH8PPniZuGIODtda?=
 =?iso-8859-1?Q?SLIlFKWNwOUfI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40554b61-f017-4968-20f3-08dce162d529
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 15:16:18.0682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EcRUgNY9IZxMIUs3d+RoA7wLcwauy5ydK9vsFDJ0pB6UdS/Ek+QmJKISAWt+S3V48ukb/N2wVcsIwbD4i3Jdbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8266

On Mon, Sep 30, 2024 at 11:34:36AM +0200, Miquel Raynal wrote:
> Hi Frank,
>
> Frank.li@nxp.com wrote on Thu, 26 Sep 2024 13:02:06 -0400:
>
> > On Thu, Aug 29, 2024 at 05:13:57PM -0400, Frank Li wrote:
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > > ---
> >
> > Alex:
> >
> > https://lore.kernel.org/linux-i3c/20240819-i3c_fix-v3-0-7d69f7b0a05e@nxp.com/T/#m16fa9bb875b0ae9d37c5f6e91f90e375551c6366
> >
> > There is some discuss about assiged address, I already explain the reason
> > and ping 3 times,
>
> Pinging will not help as long as the code is not clear and simplified.

The problem is that no reply after I posted last reply and ping 3 times
have not response about it.

> I honestly think the PID should be retrieved earlier in the HCI part
> and that would solve most of your issues.

If there are problem or difference opinion, we can continue to discuss it.
But no reply will stop the whole thing move forward.

I3C HCI Spec 1.2, sec 6.4.1, when do DAA,  "DAA CMD and dynmatic address"
queue to cmd together.  We don't know PID before DAA CMD. So dynmatic
address can NOT get based on PID.

If I am wrong about HCI, let me know since I have not worked HCI before.

>
> Otherwise if that is not possible I still find hard to understand the
> big picture, the comments and the code. I've already spent quite a bit
> of time trying to improve it with you, but the logic is still a little
> bit too specific and complex from my point of view.
>
> > These patch are actual fixed hot join issues.
>
> It should not be the case. Hot-join should work without the devices
> having all the time the preferred address. If hot-join really does
> not work, then please split the series with the "preferred address"
> handling being done apart in a second series.

I can do that, could you check svc part and most already acked you? I can
post svc part only later by addressing your comments if you have.

Frank

>
> Thanks,
> Miquèl

