Return-Path: <linux-kernel+bounces-565208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 546C6A66340
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 01:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7344188D127
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 00:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F321C5F0C;
	Tue, 18 Mar 2025 00:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b="cLt2/jP1"
Received: from gw2.atmark-techno.com (gw2.atmark-techno.com [35.74.137.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F231519B4
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 00:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.74.137.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742256012; cv=none; b=j94SoT4kGsD3oo5GvEpvPpX1iHY3S/16r58mic2t2/xHlV68EN3aN6ZYyY9hKW6gLFbuZ5FqmtjVaG3vdPUwOZ6yCks/6AtpWwhGuXV29lYUfJ/hLvJGZr52IuA2IieZ5QAfO3d3wgE9LLcFh9GNwyC7YwJwlS+anu12oCTAQLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742256012; c=relaxed/simple;
	bh=5i13wLKTyNDlBKchwfsIXJmrY3fLphQS5cqXHJehJHo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHbQVq1EK3VUfDw0kdPWZygczeFGwV1FcVV4/traqWz0kT+SzRoEWO3Ynb/cfUswTY0nlUyPnGzgxKUJlrvY96hxX0QE2GZSCZhQJqqmJuESQe/UP9cgJ4liRxhG+Os1M626qI/hFAC+umh7LvAMNaUQBYEoHbUEfeduxBY0os8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com; spf=pass smtp.mailfrom=atmark-techno.com; dkim=pass (2048-bit key) header.d=atmark-techno.com header.i=@atmark-techno.com header.b=cLt2/jP1; arc=none smtp.client-ip=35.74.137.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=atmark-techno.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=atmark-techno.com
Authentication-Results: gw2.atmark-techno.com;
	dkim=pass (2048-bit key; unprotected) header.d=atmark-techno.com header.i=@atmark-techno.com header.a=rsa-sha256 header.s=google header.b=cLt2/jP1;
	dkim-atps=neutral
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by gw2.atmark-techno.com (Postfix) with ESMTPS id 62B1A687
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 08:51:25 +0900 (JST)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-2ff8340d547so4336782a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 16:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atmark-techno.com; s=google; t=1742255484; x=1742860284; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TRQ/GwuEKDlWODVcSQfxpM5Lw2RQXG7ZSKeiwlAjR7g=;
        b=cLt2/jP1Ko35UMsCHcn3RoLnE+onqkGU8r9tJI2ojX7AyFzEvoRtvjN31csz7VbeBr
         0TCuZb2gm00ILfaBMv6/B0hp8Rqs0Zbb1PM+5wyHPqCGdfmgS9oIYm1Is9oeCYcdxAVJ
         UwBcU745Cb8kkj8a4D2y0fKTBX+7aNOwwjMVpjyvk4reUCGmurAranHmmJ1uXpUXXNKZ
         PKzPfgin97YURnNkOmQ4MbpL6z7v0vgnwkUMfDApVJRGopIuTWYMAmq6PsCDO9uYOhzk
         FaX+UsM9J8al6Yfz4sq2fNwp7c9b0qkIdXIDlLzwg/bvuEfz+bRc/Zxj1YfyxuYo3Hi4
         moRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742255484; x=1742860284;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TRQ/GwuEKDlWODVcSQfxpM5Lw2RQXG7ZSKeiwlAjR7g=;
        b=KMcnVUaVvJ/WPRTl+TX56rgwgL6ifrDWFNE01utagqi0Gm9uxamtbQ39POGR6Jr1vn
         pDYP7kDRAkByL9xhl/GExsdzzQaR8u1QAV4SRwlKvKxJKfiu7MzC544EiXP8ZONtyue8
         soGrHxHzZb4qSuIM5FKD8jvGKslX9FxGJk0bt5IrJsLWOnYsp0kV8UjRa/sFF7HPm6Z1
         BkjqfHDQy7vBr8D2dZvVyJLjAIjOh57LlI5wxPWnxvBb8phj84Jt7cx6QoD6IjE56Xbh
         OdtHdZEPRf/j2cPdSdC+Oq/HbPns3ufPuFtxhjQDF9fBmw79UrvOZRl+NvLPaY22KZSC
         oNMA==
X-Forwarded-Encrypted: i=1; AJvYcCUyfCMWucOfRDH2L+RqOj4svDy6eFZOY2T2yTNSyJwWP8HpphPu5Jm4udEYNqW4y7eazQxG++L4BtW1pmc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQQyEcES1S1rkepEVkpEDdawpaBd/XZES0kZFIapkz5t/GQD5W
	7wrkDv38Prrf+6zR7XW6Ol5jq80VydAniMbrY54k4knSXmHNYqxVPqW3o1b1Upd1PxOFIDGL/Km
	HzxNc1mgp5qiFS39CjMipS0WNAaNMw1vK0IIpTp3tFrsPUshkMFP3CXSom5lbQ90=
X-Gm-Gg: ASbGnct3t5+hmIvMPLJIR0DlcTOVkawMC2Gp4Nan4PjSHLWUYQZAeL4CShi/dtHXl0C
	VfabZHwDj8i7oPapxK0i9HtZsrLx5LarDAAgzzOUAd3Tth+W9tzCT9hqMzTcR8uatj7kmWr2/XQ
	s0BoqQiz/0xarruYVfia+4BjPHrLJoDV2Ntns6w0Wn5ul4MYFXpHmdYZuuQpGmPKnIBt0Ur+j/K
	0fiLzWu8lXXTDTkCkYVSj3TulEIdHWWt4EQa9IMePOyXTrOkdvGT5qLe13B+na/vx4wQ/GPJXXK
	ttdjp1scyPhLz0wYFeOFUt8BSOY0c5XTVKceG+ADzXKn9sCrzZ9PF/lIXfN4HjDnWgQ9keDj9TE
	=
X-Received: by 2002:a17:90b:4b92:b0:2ee:af31:a7bd with SMTP id 98e67ed59e1d1-301a5b03f3amr308528a91.5.1742255484406;
        Mon, 17 Mar 2025 16:51:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGk+XPSS97YKPi4vp9oXul8r5wshwMpKmVOIfHLVbaOIyiKLKfsKF4T1efoV0atb9QgEGz0bQ==
X-Received: by 2002:a17:90b:4b92:b0:2ee:af31:a7bd with SMTP id 98e67ed59e1d1-301a5b03f3amr308500a91.5.1742255484114;
        Mon, 17 Mar 2025 16:51:24 -0700 (PDT)
Received: from localhost (162.198.187.35.bc.googleusercontent.com. [35.187.198.162])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30153519fefsm6734019a91.12.2025.03.17.16.51.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Mar 2025 16:51:23 -0700 (PDT)
Date: Tue, 18 Mar 2025 08:51:11 +0900
From: Dominique MARTINET <dominique.martinet@atmark-techno.com>
To: Neeraj Sanjay Kale <neeraj.sanjaykale@nxp.com>
Cc: marcel@holtmann.org, luiz.dentz@gmail.com,
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
	amitkumar.karwar@nxp.com, rohit.fule@nxp.com, sherry.sun@nxp.com,
	ziniu.wang_1@nxp.com, haibo.chen@nxp.com, LnxRevLi@nxp.com,
	guillaume.legoupil@nxp.com, salim.chebbo@nxp.com
Subject: Re: [PATCH v1 1/3] Bluetooth: btnxpuart: Fix Null pointer
 dereference in btnxpuart_flush()
Message-ID: <Z9i1b9hzZzwJnIYh@atmark-techno.com>
References: <20240515070657.85132-1-neeraj.sanjaykale@nxp.com>
 <20240515070657.85132-2-neeraj.sanjaykale@nxp.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240515070657.85132-2-neeraj.sanjaykale@nxp.com>

Hi,

Neeraj Sanjay Kale wrote on Wed, May 15, 2024 at 12:36:55PM +0530:
> @@ -1269,8 +1271,10 @@ static int btnxpuart_flush(struct hci_dev *hdev)
>  
>  	cancel_work_sync(&nxpdev->tx_work);
>  
> -	kfree_skb(nxpdev->rx_skb);
> -	nxpdev->rx_skb = NULL;
> +	if (!IS_ERR_OR_NULL(nxpdev->rx_skb)) {
> +		kfree_skb(nxpdev->rx_skb);
> +		nxpdev->rx_skb = NULL;
> +	}

This is an old patch but I hit that on our slightly old tree and was
wondering about this patch: why does flush() have to free rx at all?

I think this either needs a lock or (preferably) just remove this free:
- This is inherently racy with btnxpuart_receive_buf() which is run in
another workqueue with no lock involved as far as I understand, so this
is not just about errors but you could also free something in a weird
place here.
As far as I understand, even if we don't do anything, the rx path will
free the reply if no matching request was found.
- looking at other drivers, the hdev->flush() call never does anything
about rx and seems to only be about rx
(ah, checking again as of master drivers/bluetooth/btmtkuart.c seems to
have this same problem as of before this patch e.g. they're not checking
for errors either... This probably needs something akin to this patch or
removal as well. All other drivers have flush seem to be mostly about
tx, but I do see some cancel work for rx as well so I'm a bit unclear as
to what is expected of flush())

Thank you,
-- 
Dominique

