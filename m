Return-Path: <linux-kernel+bounces-169031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2247A8BC1AA
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 17:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 20DAAB20FB4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 May 2024 15:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71576376E7;
	Sun,  5 May 2024 15:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zenithal.me header.i=@zenithal.me header.b="pcMH5txY"
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01on2104.outbound.protection.outlook.com [40.107.113.104])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3573F2232A;
	Sun,  5 May 2024 15:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.113.104
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714923117; cv=fail; b=guvfM/l1xm5kleLwpPx9cy86ckExQBuiO8gwp6el0ic7QqXs4LbnOfcpQrycRxq/PAMY/jizDX8WmII3pQAw9/hOvzPQZzxYXBsoS8aNhAAyYQq659yzJ22eQRhLpuMqHVC5HAuXNnkqJ/oimYYQfFCZYMVSetwkuRb+hPplmxU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714923117; c=relaxed/simple;
	bh=P6H+mqpy8+9mN0oCtx4hFsIed36ZRsmtKnPw6ECChFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ahyEs+qih4p2rNSAekoTYiH9O5sx77WrnAGHaJNBz8TFFDQLNNuI0Zd+UCCH/ZSxgmogEVp+ATc8MxFfBbsoPK8qZJRNr86jhJjoB20Beokv2hyRvtSlq8MQZlwqL2xe9/Ra/TkXUI3nG4JJRUe/Kx9W9xQdmN+46tHqgNp2coY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zenithal.me; spf=pass smtp.mailfrom=zenithal.me; dkim=pass (1024-bit key) header.d=zenithal.me header.i=@zenithal.me header.b=pcMH5txY; arc=fail smtp.client-ip=40.107.113.104
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zenithal.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zenithal.me
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ON4rQeXx0Ta3yBkU5hwP9riApJp4Ga1stVWqTTJ8NWrN0o3gQbBZYUcnKl1ybPhNGWcdg89xb/R38+vTa4jaqAu7pbI5YLwLRPBGD7EbNcW8GlTr13qoB7p0k9xzskVDhV84BO/t8xZgI5nRjVrJrPOTfxQE3VIAQaYqMn35BtPRNjdJ3F+oCXQDUoaomLI4qQtpZ92a57gOMUKZk1BXETNOAA1C7g03TJxYm0icHmwxEgImHNmUcQiWHkOe/LnHX3qiblWYKTBCE5KVw2Wmw3eLHe+hqO+2XtfR/qDOn1S2yZEeZR0f5wa3cXjCh7X0j7VwRIECB50ZrqiKHbo/Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=knVl2MWCjyAQkv53/ycOoJTR3C2W0EGM0Mc3kHm1Fms=;
 b=PEjHoT0/TtsSizgNJI8gz393dwAc+Rsue0SlitENJJjuUhwmOW9IowjYr2W72S7gSfua45IqKFTtzdjF5J7s1msMeXKv5PWY1LAV1+C3G+h+fkyayCwU8y0I/vGwO+bWfKWD9oMMDLm7Hmi1Yeh8KOsC73nkda71+skzoOdZDrGG2+1Pe24KYCb1OOZap0O/Y27vtWO9ufXJ5gqVSKs/3DC5ABrEG8PieBvs6FulzwTWCqpiJgVoxIrt8Sna+M+6eXKBZ9KGosyc6MSX3Fg5Kqh4sXzMHiEAN9Deb7NHPEgJ4zRsmwUeRj2xtjnkv1ndac9wQFAOEsLjz99MD0Nqeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zenithal.me; dmarc=pass action=none header.from=zenithal.me;
 dkim=pass header.d=zenithal.me; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zenithal.me;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=knVl2MWCjyAQkv53/ycOoJTR3C2W0EGM0Mc3kHm1Fms=;
 b=pcMH5txYFnNxCLr5OplQDa1aWO30Z1zRJyB1zAg/DzJm+X1zxO5LJwDx80yoQYtsssvHXkSJhzrC2dPtg3lsZl4u6Sn17r4g4Lk5XEzBB+1XjIrosQ9PVsqmHSNH72nkxv9oMaaoTEjg2DEMGukzcCmQe2EozlkCUQqOOWd0Dns=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=zenithal.me;
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:c0::6) by
 OSZP286MB2031.JPNP286.PROD.OUTLOOK.COM (2603:1096:604:181::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.41; Sun, 5 May 2024 15:31:52 +0000
Received: from TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::746a:424a:348:bab6]) by TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 ([fe80::746a:424a:348:bab6%5]) with mapi id 15.20.7544.041; Sun, 5 May 2024
 15:31:52 +0000
Date: Sun, 5 May 2024 23:31:44 +0800
From: Hongren Zheng <i@zenithal.me>
To: Simon Holesch <simon@holesch.de>
Cc: Valentina Manea <valentina.manea.m@gmail.com>,
	Shuah Khan <shuah@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] usbip: Don't submit special requests twice
Message-ID: <ZjemYB6CpAx4Kx5f@Sun>
References: <20231217194624.102385-1-simon@holesch.de>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231217194624.102385-1-simon@holesch.de>
X-Operating-System: Linux Sun 6.6.28
X-Mailer: Mutt 2.2.13 (2024-03-09)
X-ClientProxiedBy: BYAPR07CA0054.namprd07.prod.outlook.com
 (2603:10b6:a03:60::31) To TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:c0::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCP286MB1393:EE_|OSZP286MB2031:EE_
X-MS-Office365-Filtering-Correlation-Id: afb05ee6-281e-4d17-6649-08dc6d187ccb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005|41320700004;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8zt8ISaO2xyIjTEfW1GVQUcorEe43upsWSafYMMBWVAQwhA2HdSC7SBTHzx4?=
 =?us-ascii?Q?iWAuNAIQxGyMSDN1WsKqF0jBRU9vsEnFtdp60IGA7flE1Ru+KEmf5f2prTJW?=
 =?us-ascii?Q?cyVPoI3OodcAOnMT44GSndF2rtiZRIFM2sZ6uEA3xF4lEsL5zkjWpbZ20Hl6?=
 =?us-ascii?Q?iYDGxIA9oXpwH1v4MMkDU9A/KyworUM+3qzLmpdC+zbD6UW+1Rj69HRItEx0?=
 =?us-ascii?Q?gXwPqNOs2P0vHl6MDfVZ4/d5Guh654k+z/zajEbHT5/REJkG2UfJjGLS0DHc?=
 =?us-ascii?Q?BoiOTOzY3c+xCHlGvUdufNSS4WtRcKM2GEU42bwWgG9OnSVCJ63UILwszMAL?=
 =?us-ascii?Q?XqURGrQ8rQbnXF1+aWWPIEc74h2sYKdlrKKZXk003bxZZwb5L5xqEVUWPBQp?=
 =?us-ascii?Q?CYVw/xaKntk5WXGqJfTOl6uS1UZZXgV8dbpY++KprAzlJpCxeBa7omsv5gZL?=
 =?us-ascii?Q?yupkIFpiwUcjo4Yqe5Vl9wIfTHqACxQ7Py7iqLvPySC3Bm9ZVdbgUTduXeCy?=
 =?us-ascii?Q?FM8f7FANr2Koy32ROiqpAZwVEkNy6bnZK/qVcXZwYWEh+gAIsqjjjbv6pkfA?=
 =?us-ascii?Q?+Sv0G+Wb6rK2ibfRR1No3D2jAHz/PAx5nFKD7oPW7Am8sewTHsbkevyzk95l?=
 =?us-ascii?Q?WTOb6AzEVsPs7mMpIft0do+HsxjSX8UQTOoX2XS5petIBtX3hNOO+R9Dd32x?=
 =?us-ascii?Q?QMh0Y8WL0ls1nv6r1/rrtTzGjzP8sdIxCzjsiUCE9Tbga9d0ovx6eXoVvtJl?=
 =?us-ascii?Q?eVR+LOric5zsHSzIrw8MjNTPNwNcTdgpLIv2+SYFP2DHlmfdQU7OzxTJPsfj?=
 =?us-ascii?Q?wD6JzwunxUmZAvjJ4edYHqrpoeRzHTveFLYmZsjVEAUgqVlfdHSSSKX/tBma?=
 =?us-ascii?Q?BZ0KxfzRjVN0CXiVunCxNTm+5lU2gl4kdhD6ynAcRB4W9nj8xsdd03NQCMkU?=
 =?us-ascii?Q?3+UlTjayWG8XCFGocdvhbCKvaWltVWUiDr4Skx5xUO6QLkF6WsYwH+saNac7?=
 =?us-ascii?Q?VoBZgfTeNaArQGSzwkN/GrOnU2qFSjWXY8jxy1HKCgiIR6jZaGYRuU1NsZ9y?=
 =?us-ascii?Q?Js4/XghNi57Jy0cjL5IX74hCA8AifK2MjovBzq7M4hWBi4CIteGZ1T1FXHEw?=
 =?us-ascii?Q?ReeUP3aQgTET7Az3akJRblpI6S7PLA6yyEA5k7LOwz/EbwEVbF02eyzONTQF?=
 =?us-ascii?Q?FOtAyWfjTRt9jIkl01Y1g61KtPckc4Kvc9CE1NhKcWZebn031q0gVzFIpzhG?=
 =?us-ascii?Q?ij+MFY9YgOPqrkOwRJr1uIQHRAIlDviK+sgpv+5HIg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005)(41320700004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GTfmgmq3eK16dIv12BxkTSv7lcWz57ath+6h2M7tsIFoCe6E333fa1Ku6S7h?=
 =?us-ascii?Q?kDp+DgWHn32h4AR3/+t5qA8EuW2h8wvRffmdnSUZuTA+hkNKbJsqZQhQ/aec?=
 =?us-ascii?Q?zZ0yDTVxHmm9eL7UpSmY2fIYNdaneuerOgnHwM3J6K2Ov59yJ7SGBNOas/O7?=
 =?us-ascii?Q?54i9R5nPLvVZ55uz+wY8xqKFFCqZCltQJC6i6hLFGPQ6mFhq052nOlDcP2Pl?=
 =?us-ascii?Q?5QA9N0zLJSLcWZ75NRXR+yvNGeDM8/L9ndEvFrdnQqBnvB1UfUgzWacsFFQL?=
 =?us-ascii?Q?tlpg3NlfSdkIAOMB/ndPubDpRVWJ4iTeeJVsRca4VhzkwZYeNEzU6D5pCUrJ?=
 =?us-ascii?Q?AeXmLiZZLk47SkIPm97mKK9MZyJ4bjzEBTth2Lj0VJwFb59ul/kECye18WYM?=
 =?us-ascii?Q?qukWpo5HOycfEvrYynRLudjSrprG0rsvAsp2Xo49QRQaim3LYPIwyoPeApa5?=
 =?us-ascii?Q?vcTAD+4NHZJm67ylMLWG7ssmtwktqqdS8w9GY1v5Me4VUIfVBf1aBrPoFDRY?=
 =?us-ascii?Q?hXaymzPPy3UMUYpk9I2rNXWPot2NwkIr9Oi+27pbbyoBSt6Cb3FiIuuML29+?=
 =?us-ascii?Q?cXczKNXh0an78pI9zPRAcChmVKr27B7EpWD8rUDKj4HZDnxUT/g53c/FsIDv?=
 =?us-ascii?Q?8wK2MqP+NEI1doAbcRplfNHzbl59PGQnaUftjk2syJbLrX91q/AQUpBjcsCG?=
 =?us-ascii?Q?BpEqoYCg6gF9w2dTK93GbxGpVrU2lHmqo6w+tAoSZKFQtdkNLdKE1R2bqJSd?=
 =?us-ascii?Q?If39sZMKNEc26NPZ2g4f/fXsIBxJiUYq1GuwRIVLkkVBW9HfoKSe7GEUiaea?=
 =?us-ascii?Q?BDjDKuIEAwMhPzF8E2vRyiOKn13bfDGGLt1JX7vTF3IhMVQLkM/cTUtbu1k0?=
 =?us-ascii?Q?FhMZ3bIgVws+eMmdM8zZMrHxfPBcKl/cw0A3JuuN6dgmSAFNOZoY+O0Ta0oy?=
 =?us-ascii?Q?9Z7vHj1hazoLhwJWge1bGc6FVlEs7hhMs1FFgKLaeDAGIvB/DGJsBjo8tKV5?=
 =?us-ascii?Q?N+XAneBKk2avKvzeuPcX4lT9k2Yzscfe3cAp2pXZ5jXzahqEFjJwX6EaMOKn?=
 =?us-ascii?Q?fTEa6X1ftc+OklQLkbsOk2zkn0toTMpyYI0vHX4Y3JI9/Eyluh4obwDMOw8K?=
 =?us-ascii?Q?DXzjeg45egi0bDBcZOQIhbHPu6gcGWdbTq7nrInVNuVOapT7hKqUTFFodAyI?=
 =?us-ascii?Q?fJmRwmHjb4K8NORlMyAgeX4CTO2D9TVHo3KVPSDpwQzBpu8WCEj98+BvAXGm?=
 =?us-ascii?Q?D33Yyh6gbXy9dbuzPy4C+m4TGGZHudfxT5ohF+hnsYDy5PBeHIkhYL6Stcae?=
 =?us-ascii?Q?2AH6XV2qWG2aBRmjZo6fgJKx47gtGAN9fR/cO3GZkU1QwvX1u6Zmgt9xbcuf?=
 =?us-ascii?Q?4yTzUtfxu8QLBEDlS/76UgMui/Wp4JySE4loQS15/OaFxumtkyYPI8ttBZZE?=
 =?us-ascii?Q?Bj+1O96YCrLOd6uuQNuRmYFuFepopDGYmSYw3laWJ+YtFijPmKBypGFQ3uf5?=
 =?us-ascii?Q?Xu2IZSUoIhMTuZD8Ob9NzZ1AxuEs9mm7WK33JnAAY4Si3v4PUJOVVYT5orBM?=
 =?us-ascii?Q?+bkMPPUdCHhJHI+ipuj91Fql7+7v87Qp2ix0SWOZ?=
X-OriginatorOrg: zenithal.me
X-MS-Exchange-CrossTenant-Network-Message-Id: afb05ee6-281e-4d17-6649-08dc6d187ccb
X-MS-Exchange-CrossTenant-AuthSource: TYCP286MB1393.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2024 15:31:52.2431
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 436d481c-43b1-4418-8d7f-84c1e4887cf0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wyKtt/THKLAuXL9DILMS5MvMyBi9ZVesm+/dbrvuMqmTVxh0Zsd/laYCZ2oZWiY5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSZP286MB2031

On Sun, Dec 17, 2023 at 08:30:40PM +0100, Simon Holesch wrote:
> Skip submitting URBs, when identical requests were already sent in
> tweak_special_requests(). Instead call the completion handler directly
> to return the result of the URB.

Reproduced the behavior and this patch fixed the bahavior

> 
> Even though submitting those requests twice should be harmless, there
> are USB devices that react poorly to some duplicated requests.
> 
> One example is the ChipIdea controller implementation in U-Boot: The
> second SET_CONFIURATION request makes U-Boot disable and re-enable all
> endpoints. Re-enabling an endpoint in the ChipIdea controller, however,
> was broken until U-Boot commit b272c8792502 ("usb: ci: Fix gadget
> reinit").
> 
> Signed-off-by: Simon Holesch <simon@holesch.de>
> Acked-by: Shuah Khan <skhan@linuxfoundation.org>
> ---

>  /*
> @@ -468,6 +477,7 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
>  	int support_sg = 1;
>  	int np = 0;
>  	int ret, i;
> +	int is_tweaked;
>  
>  	if (pipe == -1)
>  		return;
> @@ -580,8 +590,7 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
>  		priv->urbs[i]->pipe = pipe;
>  		priv->urbs[i]->complete = stub_complete;
>  
> -		/* no need to submit an intercepted request, but harmless? */
> -		tweak_special_requests(priv->urbs[i]);
> +		is_tweaked = tweak_special_requests(priv->urbs[i]);

One question though, if there are mutiple urbs and one of them is
SET CONFIGURATION, then all of them would not be submitted,
as is_tweaked is a *global* flag instead of a per-urb flag.

Now it is assumed that when the urb is SET CONFIGURATION then
num_urbs is 1. I assume it just happens to be the case and I do
not know if it holds for all scenario.

>  
>  		masking_bogus_flags(priv->urbs[i]);
>  	}
> @@ -594,22 +603,32 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
>  
>  	/* urb is now ready to submit */
>  	for (i = 0; i < priv->num_urbs; i++) {
> -		ret = usb_submit_urb(priv->urbs[i], GFP_KERNEL);
> +		if (!is_tweaked) {
> +			ret = usb_submit_urb(priv->urbs[i], GFP_KERNEL);
>  
> -		if (ret == 0)
> -			usbip_dbg_stub_rx("submit urb ok, seqnum %u\n",
> -					pdu->base.seqnum);
> -		else {
> -			dev_err(&udev->dev, "submit_urb error, %d\n", ret);
> -			usbip_dump_header(pdu);
> -			usbip_dump_urb(priv->urbs[i]);
> +			if (ret == 0)
> +				usbip_dbg_stub_rx("submit urb ok, seqnum %u\n",
> +						pdu->base.seqnum);
> +			else {
> +				dev_err(&udev->dev, "submit_urb error, %d\n", ret);
> +				usbip_dump_header(pdu);
> +				usbip_dump_urb(priv->urbs[i]);
>  
> +				/*
> +				 * Pessimistic.
> +				 * This connection will be discarded.
> +				 */
> +				usbip_event_add(ud, SDEV_EVENT_ERROR_SUBMIT);
> +				break;
> +			}
> +		} else {
>  			/*
> -			 * Pessimistic.
> -			 * This connection will be discarded.
> +			 * An identical URB was already submitted in
> +			 * tweak_special_requests(). Skip submitting this URB to not
> +			 * duplicate the request.
>  			 */
> -			usbip_event_add(ud, SDEV_EVENT_ERROR_SUBMIT);
> -			break;
> +			priv->urbs[i]->status = 0;
> +			stub_complete(priv->urbs[i]);
>  		}
>  	}
>  
> -- 
> 2.43.0
> 

