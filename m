Return-Path: <linux-kernel+bounces-172914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 439788BF897
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 10:33:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE0E7286784
	for <lists+linux-kernel@lfdr.de>; Wed,  8 May 2024 08:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF69535C4;
	Wed,  8 May 2024 08:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="K9uRWPjf"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374F21A28B
	for <linux-kernel@vger.kernel.org>; Wed,  8 May 2024 08:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715157214; cv=none; b=W2PDo6Nv+ytSodw4Hu5lrfYvJ+xEiAHcJpbJvw/VxTJ3m9vUZKdiGXCfHFfxvqbJuH/iLhpfhK27FS4C7niDuKEYmwgG/JbtKuhM+IXqxZ0grC0BoMivSEDB0jVIm1klYrcUtWu8JdcZo0NcVve0iYfkRh+w9f+r7MfxKrbGW8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715157214; c=relaxed/simple;
	bh=yVA0FiOqbqE2S/DFz9MrWAmt57JjHMvIMtAeb/3chdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d6dNZuPribCjwzUGEwlUsJM3s6EYRjUbsgEMhAElhHso8uAb/j1qT+ODISPDBd9AedRj+kRueOA/8V+HH9lykr0k+/OVI8sHTgcvqyYjxbJ/X9EzuUEYslhim79fK4FTMh2S3SkIQeekXV+7+RtXrjZQwsxieL0MQSNUGSWAVyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch; spf=none smtp.mailfrom=ffwll.ch; dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b=K9uRWPjf; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ffwll.ch
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ffwll.ch
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51ff8cce77dso618716e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 May 2024 01:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google; t=1715157211; x=1715762011; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6y4EwFqVETg6O9C1VDyvCbQ1UYKFlViM3dNLmDxh+rE=;
        b=K9uRWPjf6ZKRGjUAajZTF5RzrGQjVjybeBJbVmsdjx9FVOH+eO07nJN3V6C1PWMMP5
         EVEcrSWLEOBKYK88VF4rFtOBl5YdyH6j3lmPgbh0x40X5Riptr6FdMDokW+cj6jqMR9O
         7UrwUzq6gZhYtz6C+/w8JxprCZyDk68QN2TWc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715157211; x=1715762011;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6y4EwFqVETg6O9C1VDyvCbQ1UYKFlViM3dNLmDxh+rE=;
        b=Fwm1kMfYPvewPXUE9O+KKyenhfUBMRZO2lBFIOLxpTS+1oiKk2VKfV7+2b73GSOd+m
         E4Sg0+yylr4IWVq32ZTMHVdOGzgVo2k7weueQo9N9WDM7CeZd2c1+CUu9hbo1goX1tOD
         aRWuGcttyGadY3yXbmaXka/xso5wsa7KRGFsNrTAi7fju1/+/7j2SrwaMbduKtmyQft7
         ghxxDMpOFlrpX7BhU9469n0QLunog/zYTPzkLcZ9ZvcMJZx9jr97HFTFouxqeYJSVXHk
         sR1dBnASqIM0WRKO9iEWkcNEuEpUGZJJ8boiwRQGmX6r+0ZvSEV04Ujn1wTE8Ch29+Y0
         gViA==
X-Forwarded-Encrypted: i=1; AJvYcCWAA6nHFInHXd82xscZJthIqWtfMgV4Brr/7sLZuU3gr/fyUDvgGhs7hG0Hg4p7/CQXwE9gW80+pVxy8eN2gRN8fs7xv+1dEIYwmCcj
X-Gm-Message-State: AOJu0YzveoVytmZbLwGGZAPExWe1W6BjCn5fqh1urG2XUPl6T025uSqc
	j9Y5kP5uKzoj+pXM7LsxtuWUeKDElqadzyurCHcOpC/vDJwAOfETht6x3ENQHZQ=
X-Google-Smtp-Source: AGHT+IE8WloieXoBNrz84YwZxVbzeE/8sdLkgTaGX4kiUy5piDKudNOJ6ss5nr4szNlRJ4Cd4qE+HQ==
X-Received: by 2002:ac2:499c:0:b0:51e:ee83:bb8b with SMTP id 2adb3069b0e04-5217d242e7bmr1063993e87.5.1715157211274;
        Wed, 08 May 2024 01:33:31 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id q11-20020a056402248b00b005726b83071esm7424373eda.4.2024.05.08.01.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 May 2024 01:33:30 -0700 (PDT)
Date: Wed, 8 May 2024 10:33:28 +0200
From: Daniel Vetter <daniel@ffwll.ch>
To: Daniel Stone <daniel@fooishbar.org>
Cc: Hans de Goede <hdegoede@redhat.com>, Maxime Ripard <mripard@redhat.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Robert Mader <robert.mader@collabora.com>,
	Sebastien Bacher <sebastien.bacher@canonical.com>,
	Linux Media Mailing List <linux-media@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	linaro-mm-sig@lists.linaro.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Milan Zamazal <mzamazal@redhat.com>,
	Andrey Konovalov <andrey.konovalov.ynk@gmail.com>
Subject: Re: Safety of opening up /dev/dma_heap/* to physically present users
 (udev uaccess tag) ?
Message-ID: <Zjs42PGvilLlF0Cg@phenom.ffwll.local>
Mail-Followup-To: Daniel Stone <daniel@fooishbar.org>,
	Hans de Goede <hdegoede@redhat.com>,
	Maxime Ripard <mripard@redhat.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Lennart Poettering <mzxreary@0pointer.de>,
	Robert Mader <robert.mader@collabora.com>,
	Sebastien Bacher <sebastien.bacher@canonical.com>,
	Linux Media Mailing List <linux-media@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
	linaro-mm-sig@lists.linaro.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Milan Zamazal <mzamazal@redhat.com>,
	Andrey Konovalov <andrey.konovalov.ynk@gmail.com>
References: <bb372250-e8b8-4458-bc99-dd8365b06991@redhat.com>
 <20240506-dazzling-nippy-rhino-eabccd@houat>
 <ZjjdUBYYKXJ1EPr5@phenom.ffwll.local>
 <cbe5a743-d8be-4b0e-99c4-e804fbadc099@redhat.com>
 <ZjoNTw-TkPnnWLTG@phenom.ffwll.local>
 <CAPj87rN3uSZoHpWLSQqz1SW9YMZNj9fkoA_EDEE_bzv-Tw8tSw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPj87rN3uSZoHpWLSQqz1SW9YMZNj9fkoA_EDEE_bzv-Tw8tSw@mail.gmail.com>
X-Operating-System: Linux phenom 6.6.15-amd64 

On Wed, May 08, 2024 at 06:46:53AM +0100, Daniel Stone wrote:
> Hi,
> 
> On Tue, 7 May 2024 at 12:15, Daniel Vetter <daniel@ffwll.ch> wrote:
> > On Mon, May 06, 2024 at 04:01:42PM +0200, Hans de Goede wrote:
> > > On 5/6/24 3:38 PM, Daniel Vetter wrote:
> > > I agree that bad applications are an issue, but not for the flathub / snaps
> > > case. Flatpacks / snaps run sandboxed and don't have access to a full /dev
> > > so those should not be able to open /dev/dma_heap/* independent of
> > > the ACLs on /dev/dma_heap/*. The plan is for cameras using the
> > > libcamera software ISP to always be accessed through pipewire and
> > > the camera portal, so in this case pipewere is taking the place of
> > > the compositor in your kms vs render node example.
> >
> > Yeah essentially if you clarify to "set the permissions such that pipewire
> > can do allocations", then I think that makes sense. And is at the same
> > level as e.g. drm kms giving compsitors (but _only_ compositors) special
> > access rights.
> 
> That would have the unfortunate side effect of making sandboxed apps
> less efficient on some platforms, since they wouldn't be able to do
> direct scanout anymore ...

I was assuming that everyone goes through pipewire, and ideally that is
the only one that can even get at these special chardev.

If pipewire is only for sandboxed apps then yeah this aint great :-/
-Sima
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch

