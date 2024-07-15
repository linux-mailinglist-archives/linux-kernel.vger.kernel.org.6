Return-Path: <linux-kernel+bounces-253106-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 055BA931C7F
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 23:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2984D1C21481
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jul 2024 21:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAA113C83D;
	Mon, 15 Jul 2024 21:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hu127ear"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2372D1804F
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 21:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721078478; cv=none; b=uUKVTBr294b5fyTpV/5jZe5MU+nJKAt3LWk8HP3N/xYyq2soLLWqwi9VJBqhzgK0x6A5eKDuy8GoDhK15dIiWqGaBkp8UfH9TiJhY0SRHdu3Eduu/V0boaZLHDN8io0vIlilp/SKzFDGiFRySm00jssszr9s7UQLlOqVXzuw6Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721078478; c=relaxed/simple;
	bh=QxuwEKVXjZsdKY26h4/v6WSO1T1t9ElACgPiaHmj6U4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPunfT9JgkdX244N4Bv6+AT4Nc+rzgnt6Gda2pzfys3GOGZlLXv0C3qYoz4TpDPB8OaH9dlPHg+6pKDtcNS2QoMtJaG7uK4lSeu16uxY+IyzIP5f+2JL4dNcLdYZzXA4/y7z/UO0SqFMYT3srNDqV684yh3rxRCpaRfTnROUrWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hu127ear; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721078476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+J+YcViW4+se6Ty9DnL7RRzeCKJXPa01mGVrkYn2rgI=;
	b=hu127earyu1oyL6m2stDZndgDQfdCtOltBzHmuP6sbL+rJrftBvMfX487oVEjIRsKfpM3D
	l4rrDfCjeWQNLZBVDVBBaTrzQyzz9/rE8l7vrE1RWXFkZhu222m1k3eAVLth5t6m3AExWr
	JmzbPmKeYnhbdXuow9OU61ZgzcJDMs8=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-kgPyObWUMoWV98dCic0-5w-1; Mon, 15 Jul 2024 17:21:14 -0400
X-MC-Unique: kgPyObWUMoWV98dCic0-5w-1
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-6b5f15564f4so64405136d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jul 2024 14:21:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721078474; x=1721683274;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+J+YcViW4+se6Ty9DnL7RRzeCKJXPa01mGVrkYn2rgI=;
        b=a5xErwsTg7LNPQ6zDEPV1PSZ9x9d2Ilpy4TKLcB2s1iObOrEo29AIqcVStKqjZbZC6
         gYNmLuB0rET1S+Xr1+lzd/XHFIrjtpF9CtyIyIfBCsF+w7OXmz6GSVzzf2g8xr3AuWNj
         fF0Nbn5RnEuUwinJlIzmG7UJi9dB1IYUw5xgWhMdQ7zdCPOiT2DYgUuoChkm7Q7k6k3x
         1y+J5SJY1YvpnOSdlY9YwpVatN8zIpujAHPt2MQVp/8FvOTIAQLblzASyT/g5affA6jF
         5H9l/m57aXPSwxive754ePV0isEOwZ7taQTFwAKZFRagJ7PnTtX2/SUpsDmwNwv1NEL6
         fzaA==
X-Forwarded-Encrypted: i=1; AJvYcCVRAEMuHd3CvutQXD65QIRj9fE+XNTJJE8jdvuK3jGvafBqGtFEE0V2y1PTU+VdWv+IKh+V9F170wZ85GuyoSAezNBnPsqygOgJ0WfB
X-Gm-Message-State: AOJu0YyemRns9acwllWmBA9QxZqd/hRGA/THvpXnUf+cXXJieE03iWPV
	fktLG71Yqf9Ki7AW/bm7rnqEYv7xoCBjQhGW4H1z96ydZeScktwpL/W2mJ92Zs3zUWSt3aaWV5C
	6drqGrMmcmPyve4YxjGFxnERGlV9Gr+7Wk6o+DKvCE76nZIhB1GicLapp00iuKg==
X-Received: by 2002:a05:6214:f06:b0:6b5:43f2:d65e with SMTP id 6a1803df08f44-6b77f4cdd31mr5983736d6.32.1721078474054;
        Mon, 15 Jul 2024 14:21:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlTQEKr+KGZW3xPOo9edF/4XcyG2agkTD6yfvAkGGhD5YrTDFFw7ZUB2kYcR3YeWPnxYqqyA==
X-Received: by 2002:a05:6214:f06:b0:6b5:43f2:d65e with SMTP id 6a1803df08f44-6b77f4cdd31mr5983476d6.32.1721078473640;
        Mon, 15 Jul 2024 14:21:13 -0700 (PDT)
Received: from optiplex-fbsd (c-174-169-122-120.hsd1.nh.comcast.net. [174.169.122.120])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b76198591esm24796056d6.48.2024.07.15.14.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 14:21:13 -0700 (PDT)
Date: Mon, 15 Jul 2024 17:21:10 -0400
From: Rafael Aquini <aquini@redhat.com>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>
Subject: Re: [PATCH v3 2/2] kbuild: rpm-pkg: introduce a simple changelog
 section for kernel.spec
Message-ID: <ZpWSxtUzBRkqB6CQ@optiplex-fbsd>
References: <CAK7LNASzX29R38ApwByCO3kpiY6-L5UqHnP1Vs2WRBQM8z+kQw@mail.gmail.com>
 <20240706164423.1934390-1-aquini@redhat.com>
 <CAK7LNARATMy4hJ=Jp0fLd=JyD_SRC5ok8CFmLwHPv7kam4Eq1g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAK7LNARATMy4hJ=Jp0fLd=JyD_SRC5ok8CFmLwHPv7kam4Eq1g@mail.gmail.com>

On Tue, Jul 16, 2024 at 01:32:56AM +0900, Masahiro Yamada wrote:
> On Sun, Jul 7, 2024 at 1:45 AM Rafael Aquini <aquini@redhat.com> wrote:
> >
> > Fix the following rpmbuild warning:
> >
> >   $ make srcrpm-pkg
> >   ...
> >   RPM build warnings:
> >       source_date_epoch_from_changelog set but %changelog is missing
> >
> > Signed-off-by: Rafael Aquini <aquini@redhat.com>
> > ---
> >  scripts/package/mkspec | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/scripts/package/mkspec b/scripts/package/mkspec
> > index ce201bfa8377..e45fdb12fbc7 100755
> > --- a/scripts/package/mkspec
> > +++ b/scripts/package/mkspec
> > @@ -28,3 +28,26 @@ cat<<EOF
> >  EOF
> >
> >  cat "${srctree}/scripts/package/kernel.spec"
> > +
> > +# collect the user's name and email address for the changelog entry
> > +if [ "$(command -v git)" ]; then
> > +       name=$(git config user.name) || true
> > +       email=$(git config user.email) || true
> > +fi
> > +
> > +if [ ! "${name:+set}" ]; then
> > +       name=${KBUILD_BUILD_USER:-$(id -nu)}
> > +fi
> > +
> > +if [ ! "${email:+set}" ]; then
> > +       buildhost=${KBUILD_BUILD_HOST:-$(hostname -f 2>/dev/null || hostname)}
> > +       builduser=${KBUILD_BUILD_USER:-$(id -nu)}
> > +       email="${builduser}@${buildhost}"
> > +fi
> > +
> > +cat << EOF
> > +
> > +%changelog
> > +* $(LC_ALL=C; date +'%a %b %d %Y') ${name} <${email}> - ${KERNELRELEASE}
> 
> 
> I am not sure whether the version is required or not.
> 
> In the following guide, not all entries have the version.
> 
>   https://jfearn.fedorapeople.org/en-US/RPM/4/html/RPM_Guide/ch09s06.html
>
> 
> If you want to add the version, perhaps is it better to
> follow the fedora convention?
> 
> 
> The spec file of Fedora looks as follows.
> The version is enclosed in the square brackets.
> 
> %changelog
> * Wed Dec 13 2023 Augusto Caringi <acaringi@redhat.com> [6.6.7-0]
> - Add rhbz#2253632 rhbz#2253633 to BugsFixed (Justin M. Forbes)
> - Turn on DRM_ACCEL drivers for Fedora (Justin M. Forbes)
> - Linux v6.6.7
> 
> 
> 
> 
> Or, is this not important because there is no strict format?

Darn, I've been using the "- release" pattern for my RPMs for 
quite a long time, as circa 2010 that was the suggestion. 
I guess I just got used to it and never really noticed 
the change along the way.

There's not a strict format, though, and it's just nice 
to have the version showing in there. 
I have no strong feelings about the format we should be
going to go with, so I'll leave it up to you. 

What is the format you'd prefer for the changelog entry? 
Leave it as it is in this patch, or adopt the Fedora standard?

I'll wait for your input before refreshing this patch (or not) 

Cheers,
-- Rafael


