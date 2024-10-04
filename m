Return-Path: <linux-kernel+bounces-351294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F193990F63
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 21:58:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D4E17281C6B
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 19:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08CA1DD890;
	Fri,  4 Oct 2024 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Ds72Kc1c"
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011012.outbound.protection.outlook.com [52.101.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBE71CACEA
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 18:58:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728068335; cv=fail; b=ipg3xSMvjYwHuzFAfiPde0ok0z4dkoCqlm5tvr18VU6aiIdybCFvnFeIT+NegNOSIioRdr0+xI97EkDE8BQSkOMxlaQAoJBEmnlReToc9Rf8UK3FtKUAVmC2R9DYkZ47COq+1TKYudpyFwxKvb9X9bYVPnMtP+ZBvS3lgM+NF3E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728068335; c=relaxed/simple;
	bh=J1QnstCn4o8Xz6t8QutswG1z0Fu4lGgF+RbYezvzQHQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lnmX06Dk20IaUWPjlBwW+67u4yp079OW8T+ineEavFxQQ8jnps+1LB9CFaaySeIE3WSUUTlspG18bLhEHTMQQXxujeVmVUSvJgkGcT+lDh7oO2+HGq5zcsKL8swi2X65A0r2e1E9KN5LbcqdXsZWlGPuSFhgISrDXd68vYW9qOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=fail (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Ds72Kc1c reason="signature verification failed"; arc=fail smtp.client-ip=52.101.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=twBfcxjGN0PQzwlOXFaowC/bKy6DfK9YO3OaoNYDnh2oheulE6dNy+ree7nf3+QC6aUsCKu8NGkuEvS8B5yrSfAQcRID4I8Xt6kp7VFI2GcbazQGLyC/KlE/cePPqS9+zCykUlIw7KA4EWxgXvtAsIzQZZ1rakwIP7JxmsyyiBho63iYZAW0qQEDf+NrTi5sxiMIzz4f1xL0XyVahp32+Su7NXbEkM1nVBhFvrpOx/26L9sPogeescM/naesH4wQJCK58Ax3rVbVQcRv2zIrxFDdQqwF0knmpBCsno43sFkJF6aw9ZtNxo/Jk1FDoBt7V9X+2R+OgTSHZmPRp0RIzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=etBOJ4DvmRBvUIggEZGeLQ2Dmr73osEeWcOiC4dKV9M=;
 b=GnnKXWq9tkOcD7amdf39ze4S/SvX5TDb83VWOkEQ5QHWxj4nLyZD7hv4bMwbj3dg+JVWCmejqlNThfzb0rl4EMfqED7jWD5AorJxt1RR3/C0xpJ4FauGN870mBao2i9ZLIcEolwEgUSborX9jQ49M+DcPQl/xmtWEosh/H98V0jRA7qB5NLdlPnQnZczLfyK9Yja4iOMhmuWsj6PrCeXQAghL01cE2zdGSJYrfa/9TLKLXAyruyri4D+mNdrGhjtE+K5UONCE0PbpkznvejU8Kk0o9XzIne9jplNv5LpX0Rxsjh0fDUp0tp+9F+GKRUPNRZzsRfxaCRbXAfbmv67UA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=etBOJ4DvmRBvUIggEZGeLQ2Dmr73osEeWcOiC4dKV9M=;
 b=Ds72Kc1cGrZ5U1hPkDrRSTdDN25G1IxGukjJw2nQqXR5cn0cBNsqQkmepr6tZYh4L1G61DxF/fSdKhxoyCERqMqfSxIftCMd3ov4UcvYnYWRoC5XYu50jdzKXoVYg+SJ4qxHoc9ibR638Pv/9dSW2ly27APe3R9euPZPeq01/k2PtFUhMAJzBRKMh0O53K8e7t5Dm8MJ/pnXbIUyJnDPC4TsdF8ZDGMi2Mt8uI95LNtAPwC76Fby3GtEh2W7eDtiqC4uXI5Tq5h5Z2oSB4/Ewg3pXjMJ8qtoxlXtqGGkoYA7sz2GhDRVdv9XaZ/3B4ANlJ+QxsjjkzdPhAGEyf1fVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8897.eurprd04.prod.outlook.com (2603:10a6:20b:42c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.16; Fri, 4 Oct
 2024 18:58:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%4]) with mapi id 15.20.8026.016; Fri, 4 Oct 2024
 18:58:49 +0000
Date: Fri, 4 Oct 2024 14:58:38 -0400
From: Frank Li <Frank.li@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
	arnd@arndb.de, bbrezillon@kernel.org, boris.brezillon@collabora.com,
	conor.culhane@silvaco.com, gregkh@linuxfoundation.org,
	imx@lists.linux.dev, pthombar@cadence.com,
	ravindra.yashvant.shinde@nxp.com
Subject: Re: [PATCH v6 2/3] i3c: master: Extend address status bit to 4 and
 add I3C_ADDR_SLOT_EXT_DESIRED
Message-ID: <ZwA63q40ZQYAz+Sf@lizhi-Precision-Tower-5810>
References: <20241003-i3c_dts_assign-v6-0-eae2569c92ca@nxp.com>
 <20241003-i3c_dts_assign-v6-2-eae2569c92ca@nxp.com>
 <20241004092914.42701e56@xps-13>
 <ZwAHziElHUR7ZdKS@lizhi-Precision-Tower-5810>
 <20241004182229.6e08d02c@xps-13>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241004182229.6e08d02c@xps-13>
X-ClientProxiedBy: SJ0PR13CA0086.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::31) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8897:EE_
X-MS-Office365-Filtering-Correlation-Id: 19749690-0202-463a-6ee9-08dce4a694d8
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|38350700014;
X-Microsoft-Antispam-Message-Info:
 =?iso-8859-1?Q?+X6D2dFJHST4eZFMsrlR6WYZ0aCtfZ6ZerzF/UhuuaEHvSSzesa3VwsJfo?=
 =?iso-8859-1?Q?7rhWqY4C9iWn9bVIo44gwlI9OK0FHJMi152OVsjFHqK/Noqkq2sEroHVkE?=
 =?iso-8859-1?Q?3iM5CSnM1tr2WnsgQiFai5OfA/ZBoxI4ZJBs2g72n/WqFoM8tikP6vgFMi?=
 =?iso-8859-1?Q?+psYIuYAoEGvQD/Uuz9l9QihZUKPIv7BpUW27vPyMwUde+p4OiEVsIB1+G?=
 =?iso-8859-1?Q?zkQhK8pC5Qe49ZEkCzSpCUWvwj6+T/IHCsL2yFzR+QabcsOZlLc2RwE/ud?=
 =?iso-8859-1?Q?We4L7NmRH5+PiKcMaN3IbI1BppfkHKjCAlbgLDSE3/0YPP1L6TdIwyxgdc?=
 =?iso-8859-1?Q?Bq/U5lSMNQi4L8KFE/7O/aODuwfDx/4Tkvz+swQGZ1iMBNoizPqXAw9KfP?=
 =?iso-8859-1?Q?EMPtGuH9BufEB1tO+WUiXBDozK55UWSK1wDBKHp1BkxB830m5OlpVdgZP4?=
 =?iso-8859-1?Q?Rm8FeofDchSdj8VYMKOP9DXKAdlGDNLdLPOcUOlF5L1OpdD1frBvKg4xfV?=
 =?iso-8859-1?Q?iKFOh37fdU6uARuQ7ShL4lWA7NHaHCbsu5QThymLhAsJ0NjWhN6FLPcOpe?=
 =?iso-8859-1?Q?auNdMjx9gOz/0ZBbAPFIIUuF7pq/KvEkcBTAvuSnpp1TFwSyyKKBOq4doN?=
 =?iso-8859-1?Q?PUfRylEbePGnUJQfhVd+McwLb9xlr3AfMxFHoHfWBsQN9PX4EAgCYNSc5v?=
 =?iso-8859-1?Q?2dl2blP/AD1nBcUspCN56zyqc2M8H6zlGSEXlPcaWlnLQzrVzCzcg0QuDB?=
 =?iso-8859-1?Q?mhZDwyZLcFNBiLgCkURYwP7p3y6jNsqCpH82OCPhxxFDSSR6GOsvhD7DgL?=
 =?iso-8859-1?Q?aFzRSc6X8m5l+sUsnzfNcptDHE6oiGgAukOzs73n/SConlqpYexofonQbZ?=
 =?iso-8859-1?Q?nOzXGra9SyFYi/SV/ooySz+JGkCcw0WG5ZAYtZpRx3mzVhr/GmajGSVdqp?=
 =?iso-8859-1?Q?AXgy6aO+q41uxxTsh8Ce+g8jCF77KwsRsVGRxUE0pmtnYdPJio4Thu0tog?=
 =?iso-8859-1?Q?D4citRah0snMVpKl7GC4yzsDPZlW4DRZGg3WeI2UijBwS3epPzcrgsz8cs?=
 =?iso-8859-1?Q?hy6StL4MXzy+oh0bj5ynDV6Z9GcZm+Bb6vvRPtJOxNMGAAZUbKzeqgnnpJ?=
 =?iso-8859-1?Q?6aWoUzlswbteIHB19nhUfXr5lN48Scv9SJC7PDcyjioekfq/+PbV2ytHFF?=
 =?iso-8859-1?Q?dbsBfZ/akTovlgpJUrEQkHMAb94wNX05B5A4X60YfJ4P6rMrd1JkrJ2PiX?=
 =?iso-8859-1?Q?qGCzI/fgMQfxwYYSFufVeJM+kITqKjXRTfXcFs7Ce+YRrpsK6KMTSeUSLP?=
 =?iso-8859-1?Q?IYjN1TLMtWNtJYlZj2XJFwu2cphtcXQw45y/JaBQfLKGbf0CnQLMvYPaRJ?=
 =?iso-8859-1?Q?anZOjS4Z710Dj9t8d6yw+rM9FmpPSJGA=3D=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?iso-8859-1?Q?fyNileJUM8vxdA0EgQk3LZc5Kuao2tZi+0hJ8ExE26TrhmzjWJg//fyOLW?=
 =?iso-8859-1?Q?kJbD9/gMbp72mE150zltdvkLKDB41ZQiQRMBrtazXcq/Wmmw5Fps7vU3hs?=
 =?iso-8859-1?Q?7DvlsKCXXbyKGOixf3M0yN/PLh+4u4SG3L/Z55kNQ8DfVRvbP8+8brfKda?=
 =?iso-8859-1?Q?9e40ybYlkeGSvdmT66URcWwHK2xN4O8wQxnO/I808+L+DYzMwnj/QJ83+J?=
 =?iso-8859-1?Q?6SicCeAEKMPZfgpYDxIfNAZyRS0Dl/fQ4O137RjOFJgg9ceXE7dr8kTBm7?=
 =?iso-8859-1?Q?pJlH8CIqrMixMgcUpH//uscQ5HBs5fSluYOOSiPoCGlNQV+r1uVYOMuxcY?=
 =?iso-8859-1?Q?IxI1G4uCWi84Jfiiwut5BQ3zCk733LCjfJmI3hOXp333qLmy8goWaLysNz?=
 =?iso-8859-1?Q?lCeoCI5qjo6AnNGWpIS+Myl2GoDB1n1mpJAA+Epzed8k+BKJh1k1dzpnQs?=
 =?iso-8859-1?Q?vZ3mzWfJv86tpuaEpss12qWDeJAinKfefnE7GjTO9Ppr9U2mcv/R9q6/ME?=
 =?iso-8859-1?Q?lJo97j5FUY7wjnOzv1zRII7XRi/DJ4k9ekD9anv4kE79KRwJUDmg1eOzKv?=
 =?iso-8859-1?Q?XA/fKzCLFvXx4XNAth9Q3jaACBYqrry3OGdw0F6UuxyHfQ5MDoecPT9HeY?=
 =?iso-8859-1?Q?7AjasCg9hzg2j1/7BPG9KmrvC3L9PIfNYqQ3DMltE190M4WzRFXffv53z1?=
 =?iso-8859-1?Q?M0VT0+u3DCWXeqQb20/d7R7Qc7mgb+zMCWb0hVeBVQ4n/hdZuzcCNLaZlI?=
 =?iso-8859-1?Q?ZNVFX2sH+4x+l5gpABpKhaojhKiBUPapxknA5sITxrNbgeItiMJl8iLoFR?=
 =?iso-8859-1?Q?BUzrbYLyFW0xTE64MrXhht/k4UH0Sl8eIqd5bnJp/7K1CcNJUvzjMFvmi7?=
 =?iso-8859-1?Q?XhcGjw5Q+6JJEgPI2P8dlMsEYRFM+w0U3RvL+JVOqcIoZ1xn8OpcQnWPCj?=
 =?iso-8859-1?Q?jc9gTwGQahGknbSSQBwr8JgEwu8zANUpyL8H1n2ZQ34Od3fUWFAvjQgiZ9?=
 =?iso-8859-1?Q?Uc1qY/WiTQCk/GKyT3vPGeloI2MGm7IvipUkcGfDZn90g9D0vHFoKuttuf?=
 =?iso-8859-1?Q?oxd8wYuY3bvayPBISNhu+V1ZK5yZGZVyx5LMUfFILR7QXPjX/6cRzjLxoC?=
 =?iso-8859-1?Q?HOpnA1bHUQTCYoMYKpqfIV2U7Fz2BwlsD/lg4l8aFo4MlOtMO0CWQtMSmM?=
 =?iso-8859-1?Q?i7NT8nKwqoiSs96v0qvmVV5ajAo6/j/+AVMZisODhuLnuweTy5GczlzFFV?=
 =?iso-8859-1?Q?mGla5ScDiXAC6uMUsRkddpzehWuSAhlI0jmaoJvPkfyBxEI0acssefww/F?=
 =?iso-8859-1?Q?+UqPwSnUX+2Y/iUjUFZcUtB7jKPPz+p63+c7XURypjWSYVUJXnfs4iFbcn?=
 =?iso-8859-1?Q?M0YcNmOn7m6R3gQa2Ok0C3zbK1sK/2BxXsZ9DsTAbiFT74Ezn1ohTK+IVB?=
 =?iso-8859-1?Q?iH1QHOiwEecf299zbrHktCOBvCEyMlKTuqLfdKrsoNAlMKi1OWrhiN1F1J?=
 =?iso-8859-1?Q?ILGh+JvxkqiAqDZsdM/ZCG5jXoC7natCZ3vn+pPD4qiofCL65U4W1RuDEB?=
 =?iso-8859-1?Q?e+6TGNC70faCk3lSw1RJhJTmuWI9YB4ABeUkOMYXGcEQHbx9c9GSVAxV43?=
 =?iso-8859-1?Q?dmbAZpqW5xU8ljfhZfNpHxKp0eso4fdnX9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19749690-0202-463a-6ee9-08dce4a694d8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2024 18:58:49.5243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /H70LbgvTcXYHCO3qjea5aeW8KLjEL2g5zT4W/b3o+JWsqR+IK+ctC+9dLWeB1ySV+6CBhb9PL6d0nvLzv1/9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8897

On Fri, Oct 04, 2024 at 06:22:29PM +0200, Miquel Raynal wrote:
> Hi Frank,
>
> > > > @@ -1918,9 +1959,10 @@ static int i3c_master_bus_init(struct i3c_master_controller *master)
> > > >  			goto err_rstdaa;
> > > >  		}
> > > >
> > > > -		i3c_bus_set_addr_slot_status(&master->bus,
> > > > -					     i3cboardinfo->init_dyn_addr,
> > > > -					     I3C_ADDR_SLOT_I3C_DEV);
> > > > +		i3c_bus_set_addr_slot_status_mask(&master->bus,
> > > > +						 i3cboardinfo->init_dyn_addr,
> > > > +						 I3C_ADDR_SLOT_I3C_DEV | I3C_ADDR_SLOT_EXT_DESIRED,
> > > > +						 I3C_ADDR_SLOT_EXT_STATUS_MASK);
> > >
> > > However I'm not sure I understand the use of the
> > > set_addr_slot_status_mask() function. Can't we just use the normal
> > > function and just extend the mask in the fist place?
> >
> > The major purpose of set_addr_slot_status_mask() is that reduce code
> > change. There are already address alloc/free by using I3C_ADDR_SLOT_FREE.
> >
> > we don't want i3c_bus_set_addr_slot_status() touch bit
> > I3C_ADDR_SLOT_EXT_DESIRED since it was init at scan dts.
>
> I agree, but in general you will never remove any "desired" slot, so
> the "set status", besides at init time, should never touch these extra
> bits?

I am not sure I understand what your means exactly.

Yes, it is first and only place to set I3C_ADDR_SLOT_EXT_DESIRED.

Other place's i3c_bus_set_addr_slot_status() will not touch these bits.

Frank

>
> > There are 18 place, using i3c_bus_set_addr_slot_status(), but we only need
> > touch I3C_ADDR_SLOT_EXT_DESIRED bit when scan dts.
> >
>
> Thanks,
> Miquèl

