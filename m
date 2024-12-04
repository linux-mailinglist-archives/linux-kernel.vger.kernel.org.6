Return-Path: <linux-kernel+bounces-431905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 686369E4285
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 18:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B30A8161729
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:56:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F77D213242;
	Wed,  4 Dec 2024 17:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CVBThe/w"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D1720D4E4
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 17:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733332870; cv=none; b=cBWuUstHOD1g+SaSlgdPZNMOaicXB4w1aeSxhdYMYwy4qDuDKN7ec3P+Bx2xypDZ7uXMdHBG0wAoLMsSmxFjnFEqaJ94xlv/5nsamvZ9/4qYdRNAFBpoHh+YElmhtGXoK+P/cG9SVjFO/LeYgC6zlX7HzNzPW2LPKROXfr+5zaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733332870; c=relaxed/simple;
	bh=cS4i0U6cm/rszccFiZBNCF5t6wXp4Gy6L1mmeeVxTLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iXFOXGRaD6tzlgtM/CH6nN6HUaUCJiO0YnXlkPj24rfoSDosQ44QUpPUO0nccQREKBCWvdqcA8WVKWxEhtFNLRwMhwcxP3rqoOueT40dv7NHLi1oismGttRPbAGy1UlrylYTEElDblNtDNLTVlYeGs3xRj8Etzl2iwDMvdFl9ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CVBThe/w; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-53de8ecb39bso46644e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 09:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733332867; x=1733937667; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CwUi8SmsPb5Vycsa9GB+I0BWedaEfg/jRhZVV6qa67w=;
        b=CVBThe/wFYiiF4xr5/DzIJxa8qCYtzwYoZgfE8E27JgRqP7KxhwxFgzsweU4OPYr5Z
         m+b0kwFPSXpaklLcxAi/dReIHBYD9unZsuprrWSp2oBnpkyXVm2mY4u9DXsGc1B/iBe7
         tQE3cORTNB29jbrdglWB9VGJeQbUdYU0Kdf0iQorbnLy3NDd1Fx5235qtaaeroihLlXU
         PlFzV8koM41ZmAiAQwtJxzTFPc5vRQON4XA/IDjawHAUuxwRShmEiwbCcDMySxMGYL4e
         ZvOdUtq6z+D4XwZa3dw7vLRjUft6oP0zskdTiZBbdnVA5tZ7jKNs+oc+rlx8Uyd5Wd/j
         2Ymw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733332867; x=1733937667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CwUi8SmsPb5Vycsa9GB+I0BWedaEfg/jRhZVV6qa67w=;
        b=u+yjYSTghI2wRLO4evwU1qMhQ1liUfLnoZkVUhZ0b0c0TAQnKxhV3sATcUUVs5GcZM
         sjpyMvVsDm5Sn8UfsJ5y2Aho8inBhZ87OZlfYtRgbkZhMr8OP3eFjFXdF0nLpIX+emzt
         gSiX1gEP6rE2a/nSPqbBWrq9Y2xAwtX3jVyUgdhIiEhmwPBoapu74wK6WMgHz5ulZ1Yv
         rZnxgLIXcr2XhFDnjgHrGyGwxbmnfTpJzHlCjkXeWkwoZBO+OzxGRNLdM926giCYQ3Sl
         KYWOdrTRP86ITjR7S3tF/GPoxIJKJiPgnew2brkU94/Rk3NXF435UkP598iOwPwLDSQU
         aaMQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmzZUbs9MK54iWWLgHKjgJW89A1mZ4fBHatSR5j3xxxPlauluQAcyqY9E3Dv1ig8seafw4kB810O4YV4g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9jdEfht73wLDPKpl/mwJuOJchyMamIulC4+DTSjvmanAGvw8R
	RzgYI0nc9Q1OOfbF5gI8JsToLrp3uHCLP5kMfbOUk4e80pP2gk06VYQsUvCxR6w=
X-Gm-Gg: ASbGncsTzNwggaIYYIkQs/rXgTKC59p/LiO3CIzBbXmeSnpQwSiPZV9amSMCP6f+d9n
	FO3qj7mNa7RQ2B8O3aCCYgY1vOiCPeP83TE8W6JzwufQyPGDsyMw70L8LbgrMwEYlN3NhMSMijD
	nGJ6YTyb/V6o36AvmidcEVXxHIbiUtCJcbE4+TGyE6jKlb1gYsGwC6RAGdkwQGqALVmDpZIqxPh
	PJIMWJ5YI6SuFeBbJPTJGriv5LIO/PZAepWOX1fvWrl1a+4HRAfLHNxD5nqABJ5g4nK4a2biA==
X-Google-Smtp-Source: AGHT+IEPTiihAPUsJWXirfrgqA0sgpTCOG2Fx4MskWfdIdP1ollzTCwt1fpOL8Ol16tbpJQQ/vIs4w==
X-Received: by 2002:a05:6512:4028:b0:53e:1b94:727d with SMTP id 2adb3069b0e04-53e1b947326mr3303792e87.10.1733332867234;
        Wed, 04 Dec 2024 09:21:07 -0800 (PST)
Received: from localhost (hdeb.n1.ips.mtn.co.ug. [41.210.141.235])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa5997d55b1sm755789866b.72.2024.12.04.09.21.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 09:21:06 -0800 (PST)
Date: Wed, 4 Dec 2024 20:21:02 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Dave Penkler <dpenkler@gmail.com>
Cc: gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Marcello Carla' <marcello.carla@gmx.com>
Subject: Re: [PATCH 3/4 v2] staging: gpib: Fix erroneous removal of blank
 before newline
Message-ID: <1012388b-f316-47a3-a98f-0f40dc74948e@stanley.mountain>
References: <20241204170443.28333-1-dpenkler@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241204170443.28333-1-dpenkler@gmail.com>

On Wed, Dec 04, 2024 at 06:04:43PM +0100, Dave Penkler wrote:
> The original commit removed the blanks before the newline
> in the protocol string constants to satisfy checkpatch.pl
> This broke the driver since it relies on the correct length
> of the string constants including the blank.
> For example the original
>   #define USB_GPIB_SET_LINES   "\nIBDC \n"
> became
>   #define USB_GPIB_SET_LINES   "\nIBDC\n"
> which broke the driver.
> 
> The solution is to replace original blanks in protocol constants
> with "."
> e.g.:
>   #define USB_GPIB_SET_LINES   "\nIBDC.\n"
> 

Let me help you write the commit message.

    The USB_GPIB_SET_LINES string used to be: "\nIBDC \n" but when we
    were merging this code into the upstream kernel we deleted the space
    character before the newline to make checkpatch happy.  That turned
    out to be a mistake.

    The "\nIBDC" part of the string is a command that we pass to the
    firmware and the next character is u8 value.  It gets set in
    set_control_line().

	msg[leng - 2] = value ? (retval & ~line) : retval | line;

    Imagine the parameter was supposed to be 8.
      Old: "\nIBDC8\n"
      New: "\nIBD8\n"

    The firmware doesn't recognize IBD as a valid command and [whatever
    starts beeping and sets the computer on fire].

    Put a . where the parameter is supposed to go which fixes the driver
    and makes checkpatch happy.  Same thing with the other defines.

regards,
dan carpenter


