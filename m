Return-Path: <linux-kernel+bounces-427151-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E9A9DFD48
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 10:35:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7F25B22694
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 09:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8401FA831;
	Mon,  2 Dec 2024 09:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qvr61mc/"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5C33398B
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 09:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733132133; cv=none; b=UsLHjOTqjAJbBMmstXsMpHeJ1Xp4D9WBxjqPDB5YM4QUhGyrUHHz2ltFexgy6Cpn1fO4KWqjxbnvfrF0X9e8Ri9hA2ggOYVkFGbJzTHGR3PeOKQozEbRMt1OG7ItmmXosH0PIbhC2qoNEyjDIaCPq1SSn9Vrm60eoeCmOiOKHXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733132133; c=relaxed/simple;
	bh=6autZL+1MODvSSer7+vC85PoRulLEMMO7PS+fzCsIgs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OkFDoaOO+230DxK6H6ijHhtS1R7y9DaKXjUHGeePd+fFMM5VzK8O8nxmuwUhv0pOd8jlcqo3V0IrBMtwDKilq4ik4FZGtuHMsVSgq0OkhEpwWh3tttp2BVXpbFjVgu+rkoe0L3cjDgR32zVtdG/Q/F7SBVRoMGLxHnLC4kR1iIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qvr61mc/; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ffb0bbe9c8so44568401fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 01:35:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733132130; x=1733736930; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dt2TVt20eO+6fZpSm814SQa3ex5u0vscKnXHANIdRWE=;
        b=Qvr61mc/OtwDzDfNKliRuBG9NOewazCrtpdYR8EdMY4ULKN3ST4Ydro0W8rDeJx9Re
         r7OkJ21Fu0CkIHAi9Chf4q/8NHLNFfjFrr/jnUPwoHrTAbLq4bFwwt3CUrXvnaz3XzJd
         4ALslKyM9nYM0IyPm7PxX4HOwE82+Fus2ZbEJgAVUxhBJKuNCUDQ/00/Zl8cjQvLQa2D
         XUuaUecUbin9suGOkOpUTeXI3C3nLuQjsamCSvrsI0MFBu1oJxBVbrN3Yx8s27VkydJu
         aVFi2HF4JfCbsMOAS9kCFr7auoeJweoZFD03RkTeQroWr6vfLRIPyxFeOVzE+El0bxWy
         aeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733132130; x=1733736930;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dt2TVt20eO+6fZpSm814SQa3ex5u0vscKnXHANIdRWE=;
        b=BiYxM09bbJWjsoDfqbVNSmy8jit2Cb3pU8g4EJA8gvRhjx/Dm+bV/0N8u3p7IcuxlU
         iDwPzufHLnepTVtSF3rW4eBygHbtWg1T+JuhrBJOy2N5i/o7nWKqfKfL+7pi00SKZWqU
         gdkfSlB40iMUNfCk3D1CnB9A1MOOU+eJ6jtwG84IoP/e9cWgk4mDai9CAc/oTM3ysdYI
         An5KUQISKCs9dLNXON3RTxEiKwdov45627wLaz7sP4AeTZ4EgjclnhDCj5voL7titpN9
         h1gQkGEr031hpjbKPz3d15IfYEKOUt+ayC4koYoIDX0l3BxVaoPE/qYHmohMgisIeBix
         m6uQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0FDSV00cfBbTvviNP5yFKsMywlDHxerFnakkZ6PLuOHPPemmR4twYYg+J7KKGAaWOAoYQInDn47akAck=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfzKawUy7h0dnk5R469rQUpLs56V3pwwC29JHGU8i6GuA6XDdJ
	h7rwGF1BLWsW9DKmucwOE6bUxYQD/GZRzWrpBigbJ2ydov8sRmegCWNVz/mxX+w=
X-Gm-Gg: ASbGnctd8nIJGO3IenJ5jCzjBfDYghConWtcl4m8vkU1bbdub8PpnIMJm4L2BW3Z0De
	DsmKx2vIdAAKMc6jp8LaV34p/5/GIaeIu1udAc53qzpPZ+2T79Viv8C4VYv8XOn6v9pyxddgvSn
	SNWXSCG8e48y7vCApMlONXd2flZxw69M6SMjb9gCbGXOXo+73bviSxuBbKHghIz/eUDU6HTHOdZ
	8e706t8HwPVSO/PWviOpskvAfBVfng/li/qeivvbf+RQrYmwzsP5ryI/OJqGaENDKXh7Us1XaZF
	OHJocg6xCPh01K5E3llF1xu3q/5AbQ==
X-Google-Smtp-Source: AGHT+IHNU47uQDa5zlYUyUe13GGmMqDc5+hiwAOH746/APHiIUBloLMtC0ny5VGjuUcBVKRBt4XeOw==
X-Received: by 2002:a2e:a987:0:b0:2ff:c8a1:c4d1 with SMTP id 38308e7fff4ca-2ffd60ac1c8mr100084341fa.22.1733132130015;
        Mon, 02 Dec 2024 01:35:30 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffdfca1302sm12472391fa.103.2024.12.02.01.35.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 01:35:28 -0800 (PST)
Date: Mon, 2 Dec 2024 11:35:26 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org, arnd@arndb.de
Subject: Re: [PATCH v5 1/2] misc: fastrpc: Add support for multiple PD from
 one process
Message-ID: <pqes6ixjbcvvicnfairzmy4gqokffy5aixqnadu2exi2d5rxar@ywify4ambmtr>
References: <20241202064806.1164800-1-quic_ekangupt@quicinc.com>
 <20241202064806.1164800-2-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241202064806.1164800-2-quic_ekangupt@quicinc.com>

On Mon, Dec 02, 2024 at 12:18:05PM +0530, Ekansh Gupta wrote:
> Memory intensive applications(which requires more tha 4GB) that wants
> to offload tasks to DSP might have to split the tasks to multiple
> user PD to make the resources available.
> 
> For every call to DSP, fastrpc driver passes the process tgid which
> works as an identifier for the DSP to enqueue the tasks to specific PD.
> With current design, if any process opens device node more than once
> and makes PD init request, same tgid will be passed to DSP which will
> be considered a bad request and this will result in failure as the same
> identifier cannot be used for multiple DSP PD.
> 
> Assign and pass a client ID to DSP which would be assigned during device
> open and will be dependent on the index of session allocated for the PD.
> This will allow the same process to open the device more than once and
> spawn multiple dynamic PD for ease of processing.
> 
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>  drivers/misc/fastrpc.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> @@ -1480,6 +1481,7 @@ static struct fastrpc_session_ctx *fastrpc_session_alloc(
>  		if (!cctx->session[i].used && cctx->session[i].valid) {
>  			cctx->session[i].used = true;
>  			session = &cctx->session[i];
> +			fl->client_id = i + 1;

/* any non-zero ID will work, session_idx + 1 is the simplest one */

With the comment in place, LGTM


>  			break;
>  		}
>  	}

-- 
With best wishes
Dmitry

