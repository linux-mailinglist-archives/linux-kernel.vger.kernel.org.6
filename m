Return-Path: <linux-kernel+bounces-209815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A98903B3B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 13:56:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EB101C20DE3
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 11:56:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48A5517C204;
	Tue, 11 Jun 2024 11:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LZGBVHT0"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3983176FB7
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 11:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718106993; cv=none; b=pgMwxkLNCdSJW9UmyzIkmnxFvqAY/j2SAQWHY2oW9RUbr6s0uxbcGcTKB4nSVyJWNJ0ssXx0U/HHUpW2NZD2k83s7EgIRBXSpKN/z6g3itcvuts0BpDUWXLzTXBz4c9QYeAq0xqvS1OjeNLRNKKr1U3NsCbakvM7MzSB8FK3YfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718106993; c=relaxed/simple;
	bh=W1uTW0uou/2g/48D5Fc/QCRPCK1v20x3VE4SAKIKhHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iv0MuHSGW3j+wr0myP+XLW/oX3Fy3sDCEhSk7yuoh3uJ6gbOInLgqEcxJ2ykvm6E0VBCDNOYRqwJ3tigLtwkTIQta4jZACaMeaEDm6H42jBxu6mwrEjtTrb2nco6Qf8TbP3zVGjx260pWk5fqz3BmVaNgjeQsiCmEqRnDZhtgaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LZGBVHT0; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ebeefb9b56so11683401fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 04:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718106990; x=1718711790; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UCtSkX41R6sJ1nBhx8bB86pNgXlKqe3D1DzJJjI5VBA=;
        b=LZGBVHT0CXX+Ipz0pCZP08A9F+InzuwioupJovvC4jQJwqaVpi5dnveZrewIDyLpVp
         umGs6t3TxjFv6/s9GSJcSrQ6U7XpduECh50+Cu76KAcDXTXFdMLJk0WAEWumaIY/ErmZ
         tlTz6z6cf9LegOoGj1kyOl3iYV1TYsxCYeTInvIMgUyNbltezG3IPs940imupRtvY/WX
         ilE/fhT+fYyhxAQEWHBnmVCBWRb+k6Zr2fc1A9TA/5D0JNCBJMZdmf+TE6qoIRXE05F5
         4nBF2LJnKDMyQ2oX11dXimbsvjgJ83ZcxXB3YvFuH/o6/sq+HiELoLSMymdPz5I2cs4w
         guAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718106990; x=1718711790;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UCtSkX41R6sJ1nBhx8bB86pNgXlKqe3D1DzJJjI5VBA=;
        b=uvA+MmfzVxahbuwLwr048kxObsCN+pdrUuw87z7OqkEXvosHoWGakfcDZ8AvjVBkqN
         em4bTs7KP8RjO7Qj4McvofFU4sXMgWEOEQJROfwvaAK8U1UktdrZbBgrA5CF+MKCTopF
         v5x1O9ZR4MvIc61UsdV1VIqG9+Z+Mn2mAX+Q4PhUUzc/rbZFyG7HlSEAkY13kTnrmxxo
         bKGPRSOYM8Nv6q48D4VsbIF+NdSoa8QQ1DncXSPV/XtQNJWnJJfLyBs8WiSOZ+ATM+WF
         AQB1IOMrBEs9xFeNnbSiz8s+DImCybOr5+pfiOjp3oRQcCMokFVjeMVU5rt0pfJ8nc2W
         9CyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWIickJwqlAABNoEOtNCbPK+BSGdxoXRqph2ChZWkpr8Af5IFo/C6CE3Naqafa+5xIW++v+vOD62SRMtsrCK5S/6XHVHntHRw5L0CcE
X-Gm-Message-State: AOJu0YxVW2IRzypbd928PFOzPDYsNRv/Qh3LKdqNISuQ+UxOQ+5fgDm2
	RYTaWJoFqxH70Y/F/l1EYJNXOymjhPtm2tlsOjfC6uDEfIdC5DhCwQEnvGr5rx4=
X-Google-Smtp-Source: AGHT+IFNtdJSAv2AvYvNCQCWgYsYSG5yVjWDjp3ColP0ww+Rnj66j7tn3npEM2iuvVYpscst9Hb2sQ==
X-Received: by 2002:a2e:b615:0:b0:2eb:d77a:850c with SMTP id 38308e7fff4ca-2ebd77a88b7mr69409961fa.4.1718106989081;
        Tue, 11 Jun 2024 04:56:29 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::227])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ebd4c83217sm15268501fa.109.2024.06.11.04.56.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 04:56:28 -0700 (PDT)
Date: Tue, 11 Jun 2024 14:56:27 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	quic_chennak@quicinc.com, stable <stable@kernel.org>, 
	Caleb Connolly <caleb.connolly@linaro.org>
Subject: Re: [PATCH v5 4/7] misc: fastrpc: Avoid updating PD type for
 capability request
Message-ID: <lmygcblukqlrobkdnwadgatwf2ldum6tfbcxjr2ooi4thbv4bo@qjxv4fo7tluu>
References: <20240611103442.27198-1-quic_ekangupt@quicinc.com>
 <20240611103442.27198-5-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611103442.27198-5-quic_ekangupt@quicinc.com>

On Tue, Jun 11, 2024 at 04:04:37PM +0530, Ekansh Gupta wrote:
> When user is requesting for DSP capability, the process pd type is
> getting updated to USER_PD which is incorrect as DSP will assume the
> process which is making the request is a user PD and this will never
> get updated back to the original value. The actual PD type should not
> be updated for capability request and it should be serviced by the
> respective PD on DSP side. Don't change process's PD type for DSP
> capability request.
> 
> Fixes: 6c16fd8bdd40 ("misc: fastrpc: Add support to get DSP capabilities")
> Cc: stable <stable@kernel.org>
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> Reviewed-by: Caleb Connolly <caleb.connolly@linaro.org>
> ---
>  drivers/misc/fastrpc.c | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

