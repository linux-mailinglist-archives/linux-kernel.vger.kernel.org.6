Return-Path: <linux-kernel+bounces-223135-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D907910E4E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 19:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DFFE1283562
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jun 2024 17:19:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BE51B374B;
	Thu, 20 Jun 2024 17:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TFrUKFje"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654631ABCB1
	for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 17:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718903958; cv=none; b=twXx4qrWxl379S62X8f4YrUaiDF7u2ZtSSrSumKefP+ZryTSmQddVEzwQtswvSMWcPfLQDyltz7FPDtUddCw9D/hNDd22mFB2pzIsoLCkXSriixa79UQaE6JoF7/en1GvAHI2ryVHeYp187qGsW3dOSM+BA0udWjJcGoI3/liJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718903958; c=relaxed/simple;
	bh=JojsNdDoqtfUU+AjE38Mk1phWSmEDbMLX4gAYYovSiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xsn9+I/sBVq5hbir2H6fq6HxbyOM1+YOCl9KXE2Sr0BfcNY7KvbzIehT9uO0NU9DzgBIcexWGhCwzSCeZaMzrJe8FW6LjTU1PWtF8YfN1RzaVqoHEcB6PejnDTl5GnY0OnAAhwuXfAdrIFLY9kEcJ8wMcmdYJ4etiAi6owwlopg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TFrUKFje; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718903956;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2hkBOZv2r9S3fSZnAhW59l8nG8mIjRVJRjKBvYq9JMU=;
	b=TFrUKFje/YfHkMTMWK1X1x9G5DXYs6mCXWbwmlWvN9bAo620ixPJ9a+ogsj8n4RTUq08G2
	+SWarbXs/Eu/cuMUWZk6w/jlr0Y6rTwxkoMK/1GmKrm5gOvQWwPDByx3xChi6qeCfSrEsn
	EorEfYhG6RXabURy4wzAAkAFeh7rx4k=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-58-g9B7RBsMMWi57BuHOgcSpw-1; Thu, 20 Jun 2024 13:19:14 -0400
X-MC-Unique: g9B7RBsMMWi57BuHOgcSpw-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7955d047920so131340985a.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jun 2024 10:19:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718903954; x=1719508754;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2hkBOZv2r9S3fSZnAhW59l8nG8mIjRVJRjKBvYq9JMU=;
        b=clMThbCk5IWOoDydo+LlAvGIQW3WcBFsGRUk9fi6Pzv9m6fcJTB0sP7DgbySu8XeJr
         nULMKROu/uPFjMZfj+reirI5sVajE/c4H3LUOYzGvJxJ+bEseqBAvtB7kuBN21JVSpJi
         CyZKw/0V1mTECU66ADlkQArlwcD9ZF9YpS/cPLyjTOqHrb/vn/hMMtT+PyjMYupIdjaM
         fURPurY2HRE9lfji+Y7zuC9eAlQjN7jOOEiyAC83W+dLgjIUhb7yEO62dNu7ZP2QGsKJ
         qPVvwgJwGq1+WK4oZoz2UXVrFsORbmoG1pD2u+q4V20UsbFBOysvrtd9RKLlncGlCcuD
         V6EA==
X-Forwarded-Encrypted: i=1; AJvYcCX2UqPYvVktlmnSEcVpRBPlasBSCw4xETxvmCpnODdoEYI03sKwH+1NFMc46yjIjK8q/f5NNsM9EbskjTwTiVf/CoQJ1plM8Ds/p3QF
X-Gm-Message-State: AOJu0Yy0vtoj/rVeEut0IpeUeM3srqp2u6rwMVnn2nUZFZx+3ycT+7dz
	ExpzqmgBHzeBir2IbmrxbgmIyWzGTys7sYZcRbjVNeqp2lc5804aJ3nGHLzRE/cbtgpa6XxxxJp
	EZ7UNKgfOtXod3+kuKNomKtlaiHffuUo2NddwNTUJB79ZMJGJYXL1gRV8F5LJeA==
X-Received: by 2002:a05:620a:31a0:b0:797:b319:c38a with SMTP id af79cd13be357-79bb3ed46f5mr689806285a.60.1718903954209;
        Thu, 20 Jun 2024 10:19:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE9Apjs1+aQ+o8xTmalO8U409DqWJ5eTStoRIC3ZB1CbFPGYcoJfpT+7HH8JziXTMPhGx7TOg==
X-Received: by 2002:a05:620a:31a0:b0:797:b319:c38a with SMTP id af79cd13be357-79bb3ed46f5mr689803685a.60.1718903953824;
        Thu, 20 Jun 2024 10:19:13 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::13])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-798abc0ce27sm709237085a.90.2024.06.20.10.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 10:18:59 -0700 (PDT)
Date: Thu, 20 Jun 2024 12:18:37 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Derek Barbosa <debarbos@redhat.com>, john.ogness@linutronix.de, 
	pmladek@suse.com, rostedt@goodmis.org, senozhatsky@chromium.org, 
	linux-rt-users@vger.kernel.org, linux-kernel@vger.kernel.org, williams@redhat.com, 
	jlelli@redhat.com, lgoncalv@redhat.com, jwyatt@redhat.com, aubaker@redhat.com
Subject: Re: [PATCH] prinkt/nbcon: Add a scheduling point to
 nbcon_kthread_func().
Message-ID: <skr5kyam73ldikhn7uc6b3ikq4cxrtd4ohd4dekkhlmtyxmnbg@mw6xlvaop6hz>
References: <ZnHF5j1DUDjN1kkq@debarbos-thinkpadt14sgen2i.remote.csb>
 <20240620071545.Es9LoyJY@linutronix.de>
 <20240620093246.HE9XDWSZ@linutronix.de>
 <20240620094300.YJlW043f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620094300.YJlW043f@linutronix.de>

nit: s/prinkt/printk

I make that typo so often :P

On Thu, Jun 20, 2024 at 11:43:00AM GMT, Sebastian Andrzej Siewior wrote:
> Constant printing can lead to a CPU hog in nbcon_kthread_func(). The
> context is preemptible but on !PREEMPT kernels there is no explicit
> preemption point which leads softlockup warnings.
> 
> Add an explicit preemption point in nbcon_kthread_func().
> 
> Reported-by: Derek Barbosa <debarbos@redhat.com>

Acked-by: Andrew Halaney <ahalaney@redhat.com>
Tested-by: Andrew Halaney <ahalaney@redhat.com>

This survived a bunch of tests that normally would cause some lockups
etc in PREEMPT_VOLUNTARY systems. I can see that the nbcon thread successfully
migrated NUMA nodes etc during periods of overwhelming the console backlog
successfully, which without this would not work prior.

Thanks!

> Link: https://lore.kernel.org/ZnHF5j1DUDjN1kkq@debarbos-thinkpadt14sgen2i.remote.csb
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
>  kernel/printk/nbcon.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/printk/nbcon.c b/kernel/printk/nbcon.c
> index bb9689f94d302..0813ce88a49c5 100644
> --- a/kernel/printk/nbcon.c
> +++ b/kernel/printk/nbcon.c
> @@ -1119,6 +1119,7 @@ static int nbcon_kthread_func(void *__console)
>  		}
>  
>  		console_srcu_read_unlock(cookie);
> +		cond_resched();
>  
>  	} while (backlog);
>  
> -- 
> 2.45.2
> 


