Return-Path: <linux-kernel+bounces-199758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8E348FA568
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 00:13:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469131F261F9
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 22:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3628F13C805;
	Mon,  3 Jun 2024 22:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="kCnPF0Pc"
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CC4C13B791
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 22:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717452803; cv=none; b=r993RxhXgVnwBRJy1JTjv6vE0SL3/LYJH6Hhsce8a15FFGJ2i4ftYt6GVeFvELtU6CfTDdJiUI/zsj+WkPZsK1h9Oe8tATBk6OmjDoKmNgyQBbOK2Zj0s9Fc7cNPrEmjnpMVjeOvEfv3E3SB1sCRrqQgM9zuLigwcoEwsvAI37o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717452803; c=relaxed/simple;
	bh=aJhjXnF2DVwiI6X1n9fo1zGWEx7AuZEFVV6ZcB9ivPA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y/zdWKwnEE34bF0h/TwGTP55KlX/v2IHHBDXALEGOy5OS2kl/NXl3HXfod1RnXcbn9L63Z0rivs3j6N6ReE59j1EICX1N8zQjr4LDlcfd4R3/5Zd5dU76St1EVeRrD9SGNhWRuiA48i0RQmcwTf1e1rzzqQyAXnk2oHqEmJCfM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=kCnPF0Pc; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1f692d6e990so4466465ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 15:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1717452801; x=1718057601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nP4zXx1imDHTRt6msFwZ4kc8CLmCeCfkixgMLqJEuh0=;
        b=kCnPF0Pcps9SZEdrWT4yBGr4cX5jp9ZPcv++S35ol5GA3CauHIV+5At9f5YERQVQCS
         forVbtuUy42w0catFFpCn9McDgwh9mU2j3Ai4AB3Fa/tyFIQE1SNUyDEr5sdi7yOoXRR
         RXQ6YiOQlg0XHEWY0Az4rbsopGhqhY60PC2kGkQyo3UYA5f/9w1RKkNchA79ZJW4SlYi
         A69Wg+PTBei90+9e2tBhvlgJ3jWrNsDJkpq+G70NiVtF61Bejp8tdmDP1Z23LdhRm241
         PI4keQ/Vx55l3ZBBkzuyIU9KxXCBbGHQKk2C+tlj1V67yVlFewt2IPQ76dUqhKQzgYVM
         xD0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717452801; x=1718057601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nP4zXx1imDHTRt6msFwZ4kc8CLmCeCfkixgMLqJEuh0=;
        b=SZ+JLJ6aXx/tQlnrttO0IZyZ34Fy/BzLdNjOz17bEKQ3ak7zLXIwHl8B6F+oSeV68M
         M3T6/+yQOhfQVdJECMRZxs3Tj4kxLzMWBwjTWHG+C2KpOFybeOAT2meQYCg2/7mc40Wz
         9RINUs3JtIJcbipnvJ0/c5G1BTAjMN+z0U3+l8JzkoRnp3qiLXzcZQ6UIVYra00hetbK
         6hHicxSgN6Stnatsp27iRye7GN4gIphSbnbQ7waxortUP/Dk7LcCOQbpZcpTqex6/puI
         mEB6OxbLD26PzHiiX4Y8AGO02DapGzOWO16BwVSLE+u6Vsoga+GVIjp705qe+uRapjDG
         h6Wg==
X-Forwarded-Encrypted: i=1; AJvYcCURN3JuxzkdWVyKp0vERKxKQDea3GaZydlYKVC5ZyQLs12pOrNqsfgLLnEqxNoFAjZ0xMKfHRF4Oa8DpaUfwM2MaeGE88/Xb5VNx93l
X-Gm-Message-State: AOJu0YxPa2UDYr8fKmG+G26yI6aMTwnT7ikZZnkUBaAnwjP859ixXnYj
	a1TqkB9K8x7Kq6dQO+iE+eG47tfbyN2w6EmOYmzEO+HJkKu5y7c79e3pJvACCR0=
X-Google-Smtp-Source: AGHT+IE7mp6LZkxPSEbfuy2krcOv2ji3+DxJZRRGBVkxrMqAPLf6Rbo4th6aMzPvU9+8o/zjta95Zw==
X-Received: by 2002:a17:902:eccc:b0:1f6:65d3:27b with SMTP id d9443c01a7336-1f665d3045fmr78258975ad.57.1717452800720;
        Mon, 03 Jun 2024 15:13:20 -0700 (PDT)
Received: from dread.disaster.area (pa49-179-32-121.pa.nsw.optusnet.com.au. [49.179.32.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f63232f26dsm70663145ad.46.2024.06.03.15.13.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jun 2024 15:13:20 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
	(envelope-from <david@fromorbit.com>)
	id 1sEFva-003KSn-06;
	Tue, 04 Jun 2024 08:13:18 +1000
Date: Tue, 4 Jun 2024 08:13:18 +1000
From: Dave Chinner <david@fromorbit.com>
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] readdir: Add missing quote in macro comment
Message-ID: <Zl4//pUnGQJhtNDL@dread.disaster.area>
References: <20240602004729.229634-2-thorsten.blum@toblux.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240602004729.229634-2-thorsten.blum@toblux.com>

On Sun, Jun 02, 2024 at 02:47:30AM +0200, Thorsten Blum wrote:
> Add a missing double quote in the unsafe_copy_dirent_name() macro
> comment.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
> ---
>  fs/readdir.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/readdir.c b/fs/readdir.c
> index 278bc0254732..5045e32f1cb6 100644
> --- a/fs/readdir.c
> +++ b/fs/readdir.c
> @@ -72,7 +72,7 @@ int wrap_directory_iterator(struct file *file,
>  EXPORT_SYMBOL(wrap_directory_iterator);
>  
>  /*
> - * Note the "unsafe_put_user() semantics: we goto a
> + * Note the "unsafe_put_user()" semantics: we goto a

No need for the quotes in the first place, so why not just remove
them altogether?

-Dave.
-- 
Dave Chinner
david@fromorbit.com

