Return-Path: <linux-kernel+bounces-281337-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A9A94D5AC
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 19:53:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0AB41F21B42
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 17:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B55E143C7E;
	Fri,  9 Aug 2024 17:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iCRn8VOj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B16A321A3
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 17:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723226020; cv=none; b=RVBpxD78QZdSlw3Z5lJSRm24UUJNxfJ6io2rgMqgvq+yg8tgk8rXqnf8GBAYP5HeW0fv977S+7PAqjrRtSY4bDjwyXfm6bms3E6Hk6XTs6zXoUPIE8oufCm0wOdbrgYWM1l1XBgS0jYAx6U30G5sOkbTbVNulthqCsB7OG6A9g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723226020; c=relaxed/simple;
	bh=7Sn5zTLeILz79ErK8b/F1DbmZgWmp91sN0qPXv3ZHh4=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=mOg5aO+s/9JNStPKtsuIwxpQmbxC6HKVICSm7IaKH3KLPrxyfQ+HzCJ7/sqkzQzt0Njwv/QkUZaLwH7x+dF+f7QFa0rsu+M81Sz+sfeQeKwyb4A1k7a851oERRi8c4QRQZwTTHnsUSVnxI8Fhq2BEFGk8B/y5E3nauCAGfKhiSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iCRn8VOj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723226017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=noMRONJmEnphGIGG6XXEoyySIPmdg6oUrywJynfzqkw=;
	b=iCRn8VOjHkR7kXXucNvavB36bntAq1rh3Klx9QtrjrPvC1g0ZFY6ncStgGsABFcT7XRo+7
	k98gSFbrWcjBGkEqnt/Rb5WWWGb7LYhl/qaTdEARmnOL7b57aFh65jZE5TFTM/yJcgUlBk
	3PZrXPkD9U7Xjjw+eS9NLXk/4iahosw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-_qeuBfg6Nm-5iEdUeJDn7Q-1; Fri, 09 Aug 2024 13:53:35 -0400
X-MC-Unique: _qeuBfg6Nm-5iEdUeJDn7Q-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b7abcdbb42so46789636d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 10:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723226015; x=1723830815;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=noMRONJmEnphGIGG6XXEoyySIPmdg6oUrywJynfzqkw=;
        b=VZ0LvwTkkv/lFzs2zM0a1/JvmCdlaLwQ0nGD8uEPHF3+/OgWZRDIeRUIq+RFpn7v9s
         J2sowP+GEp4MwfvOHqokv48GcLpYgY/Lmh4Jm6p6uJx3zyPpyp0mdlfqJULzbQ7Mlhwb
         Z64OtKjLQg7HPxiR7xGZGOioynd3g3C1qcCH0H3rQWOY6YBn+cDpU6Erm51OjpizXS69
         WqCk1ab8BgItTWUtOlRcGkqtggtL2WH02wTNjCAyLQsJ0yk/kObUaJtn8lDVPbY5TNC4
         Ydzu4c8kycH8v9d3uABop3X907SFHT09iEI2mBwUCFEcxLbalNPJVmwLQ7wNlr44unBO
         iXxw==
X-Forwarded-Encrypted: i=1; AJvYcCVYN+f8jplBYKY1j5lI4/9LCwOsN+6OjFqODfrILvHdd4FcAS0UCdbat1jE7q6g96Sur5ZiX5lFxH9zVB/3WCxY7QUQmPYpKIquh9LX
X-Gm-Message-State: AOJu0Yxx2YrwQnxRIp4E+ktG6sckgd2y6MukX8JyPrTdYuK1uMbHTl1H
	J5ZTjvDSyWMG4Yl6/v38M1ZQMSgWnFFRcb48SJV/eMSDeagDAIJEyuxLT58yjpijQMy6BRrMcz5
	JXyyq0fWPrQ9NSDOLg7f2pyzHKX19Xk4Q1jBbkyWlK2Hkyk2bPsd3enagjmwSog==
X-Received: by 2002:a05:6214:3987:b0:6b5:81ac:6b84 with SMTP id 6a1803df08f44-6bd79b628ebmr35449246d6.14.1723226015089;
        Fri, 09 Aug 2024 10:53:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH9OGtq7qQAsDR9pVVwwXR0QjSLhgmC6ppwwOV1ZYvAe5OWF9se9U79Zo0q8ynY3kCnoAc//Q==
X-Received: by 2002:a05:6214:3987:b0:6b5:81ac:6b84 with SMTP id 6a1803df08f44-6bd79b628ebmr35448836d6.14.1723226014706;
        Fri, 09 Aug 2024 10:53:34 -0700 (PDT)
Received: from fionn ([142.189.102.234])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bd82c5fa95sm298906d6.6.2024.08.09.10.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Aug 2024 10:53:34 -0700 (PDT)
Date: Fri, 9 Aug 2024 13:53:33 -0400 (EDT)
From: John Kacur <jkacur@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>
cc: Dan Carpenter <dan.carpenter@linaro.org>, 
    Daniel Bristot de Oliveira <bristot@kernel.org>, 
    "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, 
    Clark Williams <williams@redhat.com>, linux-trace-kernel@vger.kernel.org, 
    linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] rtla/osnoise: prevent NULL dereference in error
 handling
In-Reply-To: <20240809134133.751723e5@gandalf.local.home>
Message-ID: <7ece353a-36a6-6154-97d9-b255728b9807@redhat.com>
References: <f964ed1f-64d2-4fde-ad3e-708331f8f358@stanley.mountain> <c73c51ae-99da-793a-6dcb-2fbc6871261d@redhat.com> <20240809134133.751723e5@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII



On Fri, 9 Aug 2024, Steven Rostedt wrote:

> On Fri, 9 Aug 2024 13:34:28 -0400 (EDT)
> John Kacur <jkacur@redhat.com> wrote:
> 
> > On Fri, 9 Aug 2024, Dan Carpenter wrote:
> > 
> > > If the "tool->data" allocation fails then there is no need to call
> > > osnoise_free_top() and, in fact, doing so will lead to a NULL dereference.
> > > 
> > > Fixes: 1eceb2fc2ca5 ("rtla/osnoise: Add osnoise top mode")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
> > > ---
> > >  tools/tracing/rtla/src/osnoise_top.c | 11 ++++-------
> > >  1 file changed, 4 insertions(+), 7 deletions(-)
> > > 
> > > diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
> > > index f594a44df840..2f756628613d 100644
> > > --- a/tools/tracing/rtla/src/osnoise_top.c
> > > +++ b/tools/tracing/rtla/src/osnoise_top.c
> > > @@ -651,8 +651,10 @@ struct osnoise_tool *osnoise_init_top(struct osnoise_top_params *params)
> > >  		return NULL;
> > >  
> > >  	tool->data = osnoise_alloc_top(nr_cpus);
> > > -	if (!tool->data)
> > > -		goto out_err;
> > > +	if (!tool->data) {
> > > +		osnoise_destroy_tool(tool);
> > > +		return NULL;
> > > +	}
> > >  
> > >  	tool->params = params;
> > >  
> > > @@ -660,11 +662,6 @@ struct osnoise_tool *osnoise_init_top(struct osnoise_top_params *params)
> > >  				   osnoise_top_handler, NULL);
> > >  
> > >  	return tool;
> > > -
> > > -out_err:
> > > -	osnoise_free_top(tool->data);
> > > -	osnoise_destroy_tool(tool);
> > > -	return NULL;
> > >  }
> > >  
> > >  static int stop_tracing;
> > > --   
> > 
> > Although your fix appears to be correct, I wonder if it would be better to 
> > create a second error label, such as out_destroy_tool: as described in 
> > section 7 of the coding-style.rst
> > 
> 
> There's no reason for that. It's the only error path. That is, nothing
> would jump to the original out_err:
> 
> And for a single error, an if statement is good enough.
> 
> -- Steve
> 
> 

Ah, right of course.
Okay in that case, Signed-off-by: John Kacur <jkacur@redhat.com>
(applied the patch, built and ran)


