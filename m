Return-Path: <linux-kernel+bounces-328981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0B5978BB2
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 01:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152DE1F25AC3
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 23:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99A0917A59D;
	Fri, 13 Sep 2024 23:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="gp+51+qA"
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C32C148848
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 23:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726268854; cv=none; b=D4JrZrNrccKVe7hivU+NETeTIm9MOUn6/5KaE9zxGSWR66MKaTs7jXSz3hq0kOXUPLXykykFFmZLtxLZcdDA6g7ESIn7zMZaI/k17U6IvwgkUT1wDp7B9XaBCS5IfpskweZqKQWtci1nGZnrDarv9BMx5rHZtYm7hwaXqJlODDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726268854; c=relaxed/simple;
	bh=XK6gtAi1OXFeL1vs4htfDCwnlmFgFzZBC0wIvvmcOSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LuG31L0QUwA75lJx1jF6Bafypk6zaRoFOOEMJ+/W5aASflTzuHuG4EaVn1IirQuaSQE7ahwLTWwFP7XFwuZb4TqV7lrmzmSKr5N+n9sfmw+DW+yM43Piz7mB/000RfkyAfxbyi7zY3zbhvk/xKiy4a4a6Twv7BQvAUcVs7Gn/FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=gp+51+qA; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-7a9ac2d50ffso237167785a.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 16:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1726268852; x=1726873652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DXwgSapoWxOYR4k+GSYJnKgxe+7fV9y5qWNXQnS4uNU=;
        b=gp+51+qA50eyqsKv0GS9SOW8TOLK/F+gTvwPeDQE9vFEC9hOMA3i/UdsTPQeSDsSzd
         aT0VA6U5kXKHiUlNTs/iQhUNHctHbgG9Xxzg1jte6s0q7SJsNUXOm8q7Bln6vOdrJl65
         oL9dxWE0gd9YWtP/odxyzdtaR98kMqyCjwZhOJwuejYqykplScSplycbq5V24fPVTjbP
         bWzRGbFqQb4hDaP5K+AA3NtOoGJuYggf+IfWxiaS5W194VhG7FBLlyNijl6mr4zNxOh5
         rqBwUeE4Miz5vFd4UTcQeHQqkLDL61+HB0n9CL5hksxCixxuLYxyj6HVaEQ1GFlsEQsc
         NB1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726268852; x=1726873652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DXwgSapoWxOYR4k+GSYJnKgxe+7fV9y5qWNXQnS4uNU=;
        b=kHiBhCc0p04gi3UZQcmI+MNx5PxEP4LKWws6ZRw3DBPyaRr/4thx8UV0L4BmhMtUBj
         uxkR1JV7VswB1ojPvwwe35Jz4d7UMeaMqCukUxnZpwNtOhpnIRKYUcVn3INn30VOJ4OL
         kPU87AZmzw9oZvNflyJ855K8PvH/zuElGBCFOxNev6kvn37trrtFlx4TI0ilJTNnqkEk
         ceAa6LFsYw+i9DFsqHiKmfrrPAWor1IcuTNSFum1jQaJeFHGu6YJC5KtKSDQfTaZe+Uq
         qt+3xCPtEqNT0sZQjDCdfYEZkvAhIWegRGkKOprvMtcBjjD+l62KcJDJUZ0AiudXf0xm
         jNgA==
X-Forwarded-Encrypted: i=1; AJvYcCUjeovJAXAZX/kgTT0xDZrkfv9Mp2T52Atxw34kNYXaWH2N/wr6Ts4cMJAjFmmYxknrjou4BGGLIvK76Cs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMSKa0WD4I6LFHQQcBVmRLrX2rX+M/48BA/bBugsE+e8qmGIIz
	Gv0MAUFeqFkrqFDuozYxdmEnPYA6ay4NTJzcOwkRQeQ+CKWYVbcArmIzlbV68UXIVhz0on9pNku
	O
X-Google-Smtp-Source: AGHT+IEiZLgBcbTQhZcrplm7xCblgu9LXIY0zBXfx9erBzLwSfEZdNy/mlwQXMlUgbDZ8Zs72aCDQw==
X-Received: by 2002:a05:620a:172a:b0:7a9:b2f4:42e0 with SMTP id af79cd13be357-7a9bf97c1d8mr2753825885a.15.1726268852134;
        Fri, 13 Sep 2024 16:07:32 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7ab3e9b1c73sm11720985a.61.2024.09.13.16.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Sep 2024 16:07:31 -0700 (PDT)
Date: Fri, 13 Sep 2024 19:06:45 -0400
From: Gregory Price <gourry@gourry.net>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
	ardb@kernel.org, leitao@debian.org, usamaarif642@gmail.com,
	sathyanarayanan.kuppuswamy@linux.intel.com
Subject: Re: [PATCH 3/6] libstub,tpm: provide indication of failure when
 getting event log
Message-ID: <ZuTFhb8IF_EC70Wy@PC2K9PVX.TheFacebook.com>
References: <20240906202745.11159-1-gourry@gourry.net>
 <20240906202745.11159-4-gourry@gourry.net>
 <CAC_iWj+uieGoH1ouc6nwdZjirULgjYk+H6YFQQHSHcAySdaFog@mail.gmail.com>
 <ZuQ2xmXo0FPZpJa-@PC2K9PVX.TheFacebook.com>
 <CAC_iWjKFmHUV4EzhfJ_OAHOZhrAzH35O8QMzVK_Zs2aTG5h+1Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWjKFmHUV4EzhfJ_OAHOZhrAzH35O8QMzVK_Zs2aTG5h+1Q@mail.gmail.com>

On Fri, Sep 13, 2024 at 04:10:08PM +0300, Ilias Apalodimas wrote:
> On Fri, 13 Sept 2024 at 15:58, Gregory Price <gourry@gourry.net> wrote:
> >
> > > > -       if (status != EFI_SUCCESS || !log_location)
> > > > +       if (status != EFI_SUCCESS || !log_location) {
> > > > +               efi_err("TPM unable to provide Event Log\n");
> > >
> > > s/provide/retrieve/ and yes the print is going to be useful.  Do you
> > > know if the EventLog is mandatory. Reading at the spec GetEventlog
> > > only has 2 return values, which implies you can't return "Not
> > > supported", but it's not explicitly stated anywhere
> > >
> >
> > I believe it is mandatory from my reading of the spec - but the
> > "Final Event Log" was only added in 2.0.  We report an error when
> > 2.0 is reported but the final event log is not supported, so i figure
> > we should probably report when the event log fails as well.
> 
> Yea I am fine with that, I was just wondering if we should do _err or
> _warn. I am fine with the error
> 
> /Ilias

Per Ard's notes on patch 6 i'm going to drop this.  These prints apparently
don't actually end up anywhere.

~Gregory

