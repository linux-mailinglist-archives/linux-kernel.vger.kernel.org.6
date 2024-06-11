Return-Path: <linux-kernel+bounces-210208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BDE9040D2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:06:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BB01281863
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57FD13D0AD;
	Tue, 11 Jun 2024 16:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJ9vOgaf"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AD739FD0
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 16:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718121790; cv=none; b=fBtafp416SnQJkoiNrXsApDLlYUhSEuDOESdo0DXS5Ta7uR7hBqk4R05m/rTEMD7EpfXNNr5IbnRTA5Tg+eeO6kogGGt329WzN4JqygM1C+Mt61dz+hEv6Ov39rG3HJPwQInXVlI/EsxYNBtIEoVB8kuaNoU2nVzYhbJBZruWFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718121790; c=relaxed/simple;
	bh=85XwKIEyD8KckQ6PkEQV+MMGpUPEf6eImQT/QBrvAe0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TlU5i6A6rk4wCzXUWqCS4b4ohtpRYr2uQrJUyz1i2ILViZDYh23stn2kiZ2htV6Vsp1Z6Q0xmKz8D5PouFvqhtZxSvRhPBvGFC9rB58f8pRzA8KDWJ7A1kr7kDIrJe55HA6atAWTTPx3g+bxt31OLsFmdpCs7Lf3j1RXGtfCuJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eJ9vOgaf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718121788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JSREr6R5C0Ap27lAslygWCiIveFJotp7zWPFYC5XIhc=;
	b=eJ9vOgafstTLjjFugLmh5BnRnHo2AFrarHL7DZJLXuwfnIOIz18zdlpydOpB3ypqqyaa37
	980sniw2ELjfYsiZxusYp1Aoobj1D3HVybcoyGKHq6B0Md3PcirHD65khMwyYkKlzQyw8H
	QmgtKi5+V4NL/i2Y69JAzg/lYSFBRbo=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-mChuvN2zN6-qX3EA4VYkNA-1; Tue, 11 Jun 2024 12:03:05 -0400
X-MC-Unique: mChuvN2zN6-qX3EA4VYkNA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7955b3dd735so374951985a.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:03:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718121785; x=1718726585;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JSREr6R5C0Ap27lAslygWCiIveFJotp7zWPFYC5XIhc=;
        b=CxcPPR1D81xsUz91gLgdRu/j2/ZJFdf67pkgE+iAQZ9QBzRZQU1zUrTpYdOV8TFtIG
         WWDBfeghNp2Val9mx99TdPuJqtQ7iw67otk1/CP0PkWUBmJAqmKvhE2PrM/9lOVOpyTm
         DuHld+U9bJfo2oi54K2SWYK6A7hB4F4W0dwoPmgE0aWNI9UiNt+WAn/KYOyWkKEbhFzR
         30wQLmbTRCbXxcn0/STLaoFKNhv8maivmKnMxJ80mRuQ8F3lPzumHhHPDwj1cFqkKzPw
         5RLDnOwpZjrweCsJMLTqXb1+xzpWzxAkd2zvxpzPaRXjqYEO2/sRRGs8dsKayXeafBw2
         Drgg==
X-Forwarded-Encrypted: i=1; AJvYcCUQR8lANFuQIHP8hTXPfRJFUIbTDeG58UAxNQfWKpXZLbDL+RCpy7CjYlT3ofeAJd0AKY45OWBSSMBMP2R7NkdSyntr+DI6inmuMGjC
X-Gm-Message-State: AOJu0YxyesBARraAWpubuwgw/pvoVKcXMHAMhABIEWu8Tpns0s9Q9ggL
	+xsoXLH1JmrB+nsMhXGbEDnM+aXiXAqRnifOaawzYf65Si6/NCf9ZlVMZ/iPJsf4k3HPrWPfFuv
	0uAK8F8B6ZE4oYyGpX1b5/ls6uU55zuAgPza3EUtRkBgMzX+L3FEsmxmT4d4uHA==
X-Received: by 2002:a05:620a:4409:b0:795:5033:a79c with SMTP id af79cd13be357-7955033a906mr1152936985a.67.1718121784858;
        Tue, 11 Jun 2024 09:03:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGX9IQDx0X5A/HraO373mXuCGpMD9QViO3pahJV6Ze3wwS4HkXgImRkv8Ny+AWAOUGLBc7DQ==
X-Received: by 2002:a05:620a:4409:b0:795:5033:a79c with SMTP id af79cd13be357-7955033a906mr1152932985a.67.1718121784391;
        Tue, 11 Jun 2024 09:03:04 -0700 (PDT)
Received: from optiplex-fbsd (c-76-152-42-226.hsd1.nh.comcast.net. [76.152.42.226])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79558163eeasm302010785a.124.2024.06.11.09.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 09:03:04 -0700 (PDT)
Date: Tue, 11 Jun 2024 12:03:01 -0400
From: Rafael Aquini <aquini@redhat.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH] kbuild: rpm-pkg: fix rpmbuild warnings for kernel.spec
Message-ID: <Zmh1NXtY5W63BmRt@optiplex-fbsd>
References: <20240610163856.693110-1-aquini@redhat.com>
 <CAK7LNASe0q4W2cuLnLnpJbWtyoOoZ6Gi+wJw=JiRyZrT9KdNEQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNASe0q4W2cuLnLnpJbWtyoOoZ6Gi+wJw=JiRyZrT9KdNEQ@mail.gmail.com>

On Wed, Jun 12, 2024 at 12:00:18AM +0900, Masahiro Yamada wrote:
> On Tue, Jun 11, 2024 at 1:39 AM Rafael Aquini <aquini@redhat.com> wrote:
> >
> > Newer revisions of rpmbuild are throwing warnings about the current
> > kernel.spec template having an unversioned kernel-headers in the
> > 'Obsoletes:' field and not being able to source the epoch's date from
> > the spec's missing '%changelog' section:
> >
> >   $ make srcrpm-pkg
> >     UPD     include/config/kernel.release
> >     GEN     rpmbuild/SPECS/kernel.spec
> >     UPD     .tmp_HEAD
> >     ARCHIVE linux.tar.gz
> >   rpmbuild -bs rpmbuild/SPECS/kernel.spec --define='_topdir /mnt/nfs/work/kernel/linux/rpmbuild'
> >   warning: line 34: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
> >   warning: source_date_epoch_from_changelog set but %changelog is missing
> >   Wrote: /mnt/nfs/work/kernel/linux/rpmbuild/SRPMS/kernel-6.10.0_rc3-1.src.rpm
> >
> >   RPM build warnings:
> >       line 34: It's not recommended to have unversioned Obsoletes: Obsoletes: kernel-headers
> >       source_date_epoch_from_changelog set but %changelog is missing
> >
> > This patch addresses both RPM build warnings.
> >
> > Signed-off-by: Rafael Aquini <aquini@redhat.com>
> > ---
> >  scripts/package/kernel.spec | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/scripts/package/kernel.spec b/scripts/package/kernel.spec
> > index e095eb1e290e..4d58b29c03ad 100644
> > --- a/scripts/package/kernel.spec
> > +++ b/scripts/package/kernel.spec
> > @@ -1,3 +1,5 @@
> > +%global source_date_epoch_from_changelog 0
> >
> 
> 
> Another possibility might be to add %changelog section.
> 
> In Debian packaging, debian/changelog is a requirement.
> 
> scripts/package/mkdebian generates a very small
> debian/changelog with a single log entry.
>

I'll take a stab at it, then. Thanks for the pointer!
 
Cheers,
-- Rafael


