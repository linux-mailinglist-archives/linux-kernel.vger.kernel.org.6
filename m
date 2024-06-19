Return-Path: <linux-kernel+bounces-220986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF6D90EA41
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 13:59:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1EC1C22195
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2024 11:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF58213E3FD;
	Wed, 19 Jun 2024 11:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vox1CVvX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F86213D242
	for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 11:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718798386; cv=none; b=Ul5Xp4p7H+kwxC+h7Z9rxvOMUtLo1/hvMIEgxIthExQYlGQ+NNJJmS9hH2w/uHiyTNNPLypNYOLzB7GXewfHDxxaJ1KEG9rOnyEOPOQMxM0WA/EMNfgmbIOyNSz+5NVjzOFpZM3ZEbL8ms6EAlvrsyuiaXubHQofJn8mHZCBtmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718798386; c=relaxed/simple;
	bh=4pUXmg8tvBd4/enK6DhVVPrUAzUNxmY937r07g9IdxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RbDPgSl7cH8Qj5OcejmSYgcvjB3ZR/oDitR0sUZImyLyKApM766E9yFAxhS1MLxoADOH5Y3TTX4h5lGyfRIIZOnwsYF5Os5bHxCvrSs6DNoKFkfShKXRVpNLhnxGgo/oo99pt2wgueVqdhbkIabMz+7UgJpAXj6DbVni8Puj3OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Vox1CVvX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718798383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PB56SY2RVpI0Q4zam47FNIcr41Z7FNuOT0Omjr+HEoo=;
	b=Vox1CVvXWdaDyDYtg4SFxgWxXagG5NCdAHabT8IeOf2CP0AgL9d0u682m1nSjQYX9vg2Xc
	rG77NCMgLMQ6UbhQXmWvhM+zTzghepmBd28QrUEBzcwysF50+MdA0IpoerZa5v/pf/O9yg
	hJdLCZUqvdQGH70j+ThqiGu+R7oGGU4=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-601-enAcDaMgN0GPAY1ZP4aUQw-1; Wed, 19 Jun 2024 07:59:41 -0400
X-MC-Unique: enAcDaMgN0GPAY1ZP4aUQw-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2ebdc5ccb17so48620041fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jun 2024 04:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718798380; x=1719403180;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PB56SY2RVpI0Q4zam47FNIcr41Z7FNuOT0Omjr+HEoo=;
        b=WMDzxRpiqapT5Ayre6aL8yOjyHfEBFRQTDZyAmExv7GZYsjcDDnsHMS8cJz4UlsPQy
         efWT0uDBBdQQSB1X8KQ6LQJu0+fuciJzo9yYZNNQ7CLsUpct3TWmRsKaWzI6C+WDvCLU
         voKGUbNNPapyp+dyDG9k3v4rI+CrBmzleaPYTAKWwKIRaZNDaactTHoMld6gSEkrMgGv
         z/FmbhLZ3UZZGSa/ORX3zdjRVeuK+poT95P9cGY1XsicSqgpmhOMeXb/NkVR1TyjyJVS
         mtss5ozNxqBP5FhxoALUo4TP8fHa4QH7weRKRYDC5wgy9XjY9NnOV4t1vLnNDfyn3a93
         3qyA==
X-Forwarded-Encrypted: i=1; AJvYcCUvygwZdRnPhfpc58Z4r9VVtRE/htrhSfzGZ/klXX8TEPLsiJY+qAm3n+7gHsXsi+X/uDAgBi/FsKYmry6NlUHDaXJ7/kxELvR/jm9D
X-Gm-Message-State: AOJu0YzRgpb8WS2/gREajqAC1AMN+dfQ5hiE6cOQ40r8kTbfa6C3SXhR
	mBBRBNAhKC9bgTy0JUiLkrH3fr/WNF0A2so/AzI6VmLn9m+yUSYdn0MgtvPemJYdRBnMOq17WFi
	vx6jRFqNhmkidQ7RZLXSObBbU3x1/cuRXZlzlHpgdOi9JJAlmH27LxH4G83hA1FJpX0YgMg==
X-Received: by 2002:a2e:7a0d:0:b0:2ec:3ca1:e54c with SMTP id 38308e7fff4ca-2ec3cffc5eamr18365821fa.43.1718798379978;
        Wed, 19 Jun 2024 04:59:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3DIwLSSt+g2QyLbF22jGNXIU73vEU43ydFOx4aD/OJAnDChOc06t7QxDe87GwALKmeKPnoQ==
X-Received: by 2002:a2e:7a0d:0:b0:2ec:3ca1:e54c with SMTP id 38308e7fff4ca-2ec3cffc5eamr18365741fa.43.1718798379580;
        Wed, 19 Jun 2024 04:59:39 -0700 (PDT)
Received: from pollux ([2a02:810d:4b3f:ee94:abf:b8ff:feee:998b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422874e73b1sm265682115e9.45.2024.06.19.04.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 04:59:39 -0700 (PDT)
Date: Wed, 19 Jun 2024 13:59:37 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: mcgrof@kernel.org, russ.weight@linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] MAINTAINERS: add Danilo as maintainer for FIRMWARE
 LOADER
Message-ID: <ZnLIKfqQF1hqOjhK@pollux>
References: <20240619001209.109227-1-dakr@redhat.com>
 <20240619001209.109227-2-dakr@redhat.com>
 <2024061944-abrasive-creamed-d2d9@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024061944-abrasive-creamed-d2d9@gregkh>

On Wed, Jun 19, 2024 at 08:47:45AM +0200, Greg KH wrote:
> On Wed, Jun 19, 2024 at 02:11:59AM +0200, Danilo Krummrich wrote:
> > Add myself as maintainer for the firmware loader, as suggested by Luis
> > in [1].
> > 
> > CC: Luis Chamberlain <mcgrof@kernel.org>
> > CC: Russ Weight <russ.weight@linux.dev>
> > CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Link: https://lore.kernel.org/rust-for-linux/ZnHkQpyiX4UKdLEt@bombadil.infradead.org/ [1]
> > Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 38e7e0edd9b8..19e4a21e574e 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8569,6 +8569,7 @@ F:	include/linux/arm_ffa.h
> >  FIRMWARE LOADER (request_firmware)
> >  M:	Luis Chamberlain <mcgrof@kernel.org>
> >  M:	Russ Weight <russ.weight@linux.dev>
> > +M:	Danilo Krummrich <dakr@redhat.com>
> >  L:	linux-kernel@vger.kernel.org
> >  S:	Maintained
> >  F:	Documentation/firmware_class/
> > -- 
> > 2.45.1
> > 
> 
> These never hit a public mailing list as you provided an incorrect email
> address for it (hint, lkml does not have a = sign in it, I fixed it up
> for this response.)

Huh! I indeed fat-fingered an additional '=' after '--cc='.

> 
> Please fix up and resend so that I can take them.  For obvious reasons,
> I can't take a private email thread.

Will resend.

> 
> thanks,
> 
> greg k-h
> 


