Return-Path: <linux-kernel+bounces-203043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 475398FD581
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 20:13:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B55F5B290ED
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jun 2024 18:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4144FD53F;
	Wed,  5 Jun 2024 18:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iL60tYX4"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C5118044
	for <linux-kernel@vger.kernel.org>; Wed,  5 Jun 2024 18:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717611072; cv=none; b=U4ADeiYzMA2qmrALEoGOJOWYEi4Eq6VJ2gYkLN/yjO0/Vl7WdHuRGb4D/uOS+ODJ6gf8aiQdLDm73scqONNeqZph+x6/WmCkDdUS+HYXzRkgTpqf/4UB/ZlxFTrJUkkj8eoGi5VNfZjBUAuqHY3Lmv7Rpa1dtNtIj1XRkKdlzck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717611072; c=relaxed/simple;
	bh=ZYgyqUm/nPx2BcoBYH3Ly9CGOsPM59EsgLll8G6q804=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bmOqluRT2nj8DnB8CEGRr8aPfJNqbarWqmZTviVoy8/HoYuirJkT2p2gmcgtCHUp/lZs9HhYL582CnZRa/zNbW1urmj/MURUjtV+UI+kYUzwFCs45BYM21/bbmGXogLHiPxHWcoShDEqoxqZFg1B8seI6OsWt2pGc7NtpxRtaFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iL60tYX4; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717611070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IJzYdd6GwtBpGYX5QCieg7CT2gtuFBe/DdwRoosPgwI=;
	b=iL60tYX45OHmnq6mn8PGTyv/ypo0HTSJMxiel2W/xdYoKHzMETFlByazsUiGmXPILKb1Ip
	ieq7HTiVxJcbOHkb7cXgBJEzm5BnVvqg1nDrJFVmFjNEqZZyRn58mJ2e36IY5jYN5Vqs8F
	WwKZJNh1oRE3Pw8RvbRIHaiPWwYDSWA=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-Bhm5uhWMMuCD5eDPnf9L7w-1; Wed, 05 Jun 2024 14:11:08 -0400
X-MC-Unique: Bhm5uhWMMuCD5eDPnf9L7w-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6aecef9ae19so673626d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Jun 2024 11:11:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717611068; x=1718215868;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IJzYdd6GwtBpGYX5QCieg7CT2gtuFBe/DdwRoosPgwI=;
        b=eHN9Kma3SJOrYmVVo544Qsl5lopgpclP30Z4A8s1GaeyWTPuN/ADWZJdUJQRLobjm/
         CuWMAO9r9rIpYsKeB0t9ZwIe8ZVYP6QuPK5dzLhoo6tFZh3+nfnQqtcDR21M959ntnl2
         uN6BTXI11LMKIj1kuJ7iF+vu/vbXQUAmL114u+rMaH3Q+clEBB0/X5thFNh5MgqRaWx6
         3xWKf9DxAYyjHUtPOv5iK8fPH9lrQveBBz+TZYtVhykHA6B8Lk94hzUeeFQo5wJT6SlM
         fbjsO917FHYN7ibZTX5kqUiW+1e0tceiKSCjCbS+429LOzkHDHtpEL8410q81l779IWo
         9DOg==
X-Forwarded-Encrypted: i=1; AJvYcCWMhhRbIaAUqfo9idBXk2+jyeG4KTBCkgVnWFdEYHcvzD+OFa9HKmNcekSsIguiS/YsRVVOObPamk9zCrvLogu3vQsydOIZl3wtB4pQ
X-Gm-Message-State: AOJu0YwoDuI9BWqRWUTnQJI7L/+l0tVGXdLUYgKCFurkXAlBQlfYdMYi
	5yEaHwsMmAe3nNqOW5JEGXgFqmX1LFcm3Qnzp1jW+F1HVP2Q9CIw3a2V60x5HTWd1XgF1pqYplo
	uLr/9rlLzDMMkLclBLoShM02YIhpjDEiI9j2/SDajeibCL+IlaezterRzrL6Vsw==
X-Received: by 2002:a05:620a:5a5d:b0:792:a2b8:862 with SMTP id af79cd13be357-79523d4679bmr342771085a.20.1717611067904;
        Wed, 05 Jun 2024 11:11:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IECmW2I1q2W/pebRVG08SxND366xmrLoztW+aqiCLBV0JNGdS/R308E5OyFndB6o8hRO4wijw==
X-Received: by 2002:a05:620a:5a5d:b0:792:a2b8:862 with SMTP id af79cd13be357-79523d4679bmr342767385a.20.1717611067329;
        Wed, 05 Jun 2024 11:11:07 -0700 (PDT)
Received: from x1 (c-98-219-206-88.hsd1.pa.comcast.net. [98.219.206.88])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43ff2595290sm61941841cf.89.2024.06.05.11.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 11:11:06 -0700 (PDT)
Date: Wed, 5 Jun 2024 14:11:05 -0400
From: Brian Masney <bmasney@redhat.com>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] lib/Kconfig.debug: document panic= command line option
 for PANIC_TIMEOUT
Message-ID: <ZmCqOS8xgSAY7bRa@x1>
References: <20240605174736.778321-1-bmasney@redhat.com>
 <87wmn3nu3g.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wmn3nu3g.fsf@minerva.mail-host-address-is-not-set>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Wed, Jun 05, 2024 at 08:05:23PM +0200, Javier Martinez Canillas wrote:
> Brian Masney <bmasney@redhat.com> writes:
> 
> Hello Brian,
> 
> > PANIC_TIMEOUT can also be controlled with the panic= kernel command line
> > option, so let's reference it in the Kconfig help. This option is already
> > documented in kernel-parameters.txt.
> >
> > Signed-off-by: Brian Masney <bmasney@redhat.com>
> > ---
> >  lib/Kconfig.debug | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> > index 59b6765d86b8..a6eb7425b888 100644
> > --- a/lib/Kconfig.debug
> > +++ b/lib/Kconfig.debug
> > @@ -1043,7 +1043,8 @@ config PANIC_TIMEOUT
> >  	  Set the timeout value (in seconds) until a reboot occurs when
> >  	  the kernel panics. If n = 0, then we wait forever. A timeout
> >  	  value n > 0 will wait n seconds before rebooting, while a timeout
> > -	  value n < 0 will reboot immediately.
> > +	  value n < 0 will reboot immediately. The kernel command line
> > +	  option panic= may be used to override this option.
> >  
> 
> Thanks for adding this, I wasn't aware of that panic= cmdline before.
> 
> Maybe it could also be mentioned that the timeout can be overriden by
> user-space using the /proc/sys/kernel/panic sysfs entry too ?
> 
> Regardless, the patch looks good to me.
> 
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

I can add that. I'll wait a few days send a v2 to see if there's any
other feedback.

Brian


