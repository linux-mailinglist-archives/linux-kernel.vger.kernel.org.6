Return-Path: <linux-kernel+bounces-394802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A05979BB41A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 13:02:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6331F239A9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Nov 2024 12:02:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0950C1B652B;
	Mon,  4 Nov 2024 12:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BBdPgBgw"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC4A1B3939
	for <linux-kernel@vger.kernel.org>; Mon,  4 Nov 2024 12:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730721714; cv=none; b=IsrHFJQ9cYaleI72/Bb29ZuGCM/5HDS/4i9Yc0KrFQP+TSB0QZeTfC3OFSuE4RpM2NG0ng6ciyc2r5T7mlSxqN3599z4ilr6PE7zMImXCVcDZfbLYfX3guhf5fVe44/Ey+tvOeZJGxKHffMYlFJ4Gv3gLKLjNhfimnVz2Rcebx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730721714; c=relaxed/simple;
	bh=qSdyZ2s9B5cARaoKsuwvCuT3hG3tvvz7d7IN6nt4dn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VqlV0J5Vc34MfPjtkD5jIR9an9o5Z1bO+/9NDiGYSCSS9hyIu/Ebkw2Pazi/rxOpDb4Ywm0wfyBI1/kA13p1/YTjlLDDUItNQy1QTNsgiQWLpY4ZXtzWw7lXGyido7wM7KqDtVHJHjERylR3HMycNsCqV9VZNxmfIqP8PQZ9ii4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BBdPgBgw; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730721712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kZjGJ8hV/x/q11ugCunF6S0uI4EeGKZp0XSGAnU91A0=;
	b=BBdPgBgwDhNZAW+3HdhWS54WOath3rgmlLbZNNIALRRqr25SgQVHpd8ipLQRYrN8BdRFin
	Ez6dYGXBx257sPPflaMOG2h3q/O1JaSu6Butslxj14YXrqjkDlWeHDwVKX+kulBaduqvRb
	w4E1XaAu7yHBf62INF+VgoHcwKraX5k=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-GEDCTxUvPQCGzpstchOBjw-1; Mon, 04 Nov 2024 07:01:48 -0500
X-MC-Unique: GEDCTxUvPQCGzpstchOBjw-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a9a1be34c68so338040566b.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Nov 2024 04:01:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730721702; x=1731326502;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kZjGJ8hV/x/q11ugCunF6S0uI4EeGKZp0XSGAnU91A0=;
        b=hf0kAbX6huSvo0FhrW4aswEP/HTTCL5WCE9lrkicxFerjVeXfv83of26mhD7PbyfYq
         TUA+mbqa1NMwrEMYHV6Uln7ZZW9JLu0hwBKTG9qPd4UtPdykYLv7lJBG6MpI5GTa+cnH
         nEkDyetgYTzxoFcekF3/z8P+e+i3KIb9cEp50/Jk3H1SFW5In0RHtOO4Rbdv8Y8LNKgS
         t53E/QSP4PCoV2XcJa6m1+eucWYnpy1krLZy5oj25eAGmu7/XV8yLEvLjRzWKVln7bwu
         F6I10H7q5HkCsQ1EUwauK/+j7Zl4AFXk4YGLFFuRhU7XTrIZOflEcWHvVuTELx/ALM8w
         Yojw==
X-Forwarded-Encrypted: i=1; AJvYcCUSXH2LniFqrOwuCbtsGiWL1pFksghK4XHGPi6BHr2DJaIZoISBA5kNj8BvGiub2MfvSWQEfYPuVbiN5+A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzis+PlkepxIVERYZRMMF+9b4Hn42YGf+ya0Oh718YyaitCKJnz
	oqBHpyTpgdf/PmyogbbeQ1qzZpVDr1++cQkYQ9k8oxxhW2PgmnCIJOu+8rI1FdhLGXqaiODoeA5
	JitrD2YsWR/SxUtuBmXSZcMNbaxDv3XgJ2WKR/wNR4zMkgcOXYVwg2pvFyAF2bQ==
X-Received: by 2002:a17:906:c14b:b0:a9a:1b32:5aa8 with SMTP id a640c23a62f3a-a9e3a5739demr2118206166b.4.1730721702157;
        Mon, 04 Nov 2024 04:01:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEI+dMfsJ1bB1NHBzblIbjvGUdy5Hh2SEjrlZoRzKI+72rOu6N3AO1yDnXa1sfJg51HrWX1JQ==
X-Received: by 2002:a17:906:c14b:b0:a9a:1b32:5aa8 with SMTP id a640c23a62f3a-a9e3a5739demr2118202966b.4.1730721701790;
        Mon, 04 Nov 2024 04:01:41 -0800 (PST)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e566442easm542115966b.166.2024.11.04.04.01.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Nov 2024 04:01:41 -0800 (PST)
Message-ID: <c220507f-5701-4602-9627-82728dccfb33@redhat.com>
Date: Mon, 4 Nov 2024 13:01:40 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] media: atomisp: remove redundant re-checking of err
To: Colin Ian King <colin.i.king@gmail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Andy Shevchenko <andy@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-staging@lists.linux.dev
References: <20241012141403.1558513-1-colin.i.king@gmail.com>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20241012141403.1558513-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 12-Oct-24 4:14 PM, Colin Ian King wrote:
> The check to see if err is non-zero is always false because err has
> been previously checked on whenever err has been assigned in previous
> code paths. The check is redundant and can be removed.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Thank you for your patch(es).

I have merged this/these in my media-atomisp branch:
https://git.kernel.org/pub/scm/linux/kernel/git/hansg/linux.git/log/?h=media-atomisp

And this/these will be included in my next pull-request to
Mauro (to media subsystem maintainer)

Regards,

Hans



> ---
>  drivers/staging/media/atomisp/pci/sh_css.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/staging/media/atomisp/pci/sh_css.c b/drivers/staging/media/atomisp/pci/sh_css.c
> index ca97ea082cf4..7cee4dc35427 100644
> --- a/drivers/staging/media/atomisp/pci/sh_css.c
> +++ b/drivers/staging/media/atomisp/pci/sh_css.c
> @@ -6308,9 +6308,6 @@ load_yuvpp_binaries(struct ia_css_pipe *pipe)
>  		}
>  	}
>  
> -	if (err)
> -		goto ERR;
> -
>  ERR:
>  	if (need_scaler)
>  		ia_css_pipe_destroy_cas_scaler_desc(&cas_scaler_descr);


