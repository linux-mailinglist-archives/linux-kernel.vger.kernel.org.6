Return-Path: <linux-kernel+bounces-561164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B071A60E35
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF341461741
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:07:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4761F2BB8;
	Fri, 14 Mar 2025 10:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rRzeztTe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FB61DF982
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946839; cv=none; b=bIOntieUalM760wnCf6RDnqRjEZrceZc6mFc48/bN1psAgiidhpUT7d2sR38MLNk+LpWNyeYVyYwtG/ytkLSg4h1bIBVC2L8Rt6bJejPsnH2XLrQsU8pU1QQvXftamR+SZ1A/IBWxgGVx+fpTA+NI+jr7yQrdrXvg6jY6CY3Gjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946839; c=relaxed/simple;
	bh=0yS2KAgrPe1yZ517KKUzW8cOvlnmeopzxk4jNjNyfWA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ikhI4lHsnkp4NWi0zJ2zO1VcpFgLVeCn3nc5bOA6dGoFMfuSeJy8GcYuLN4elM6k5essNM2H2medk1+mj5oNSVboTzpJ3pwCkLf0T0gW7ILRmdJ7fP7QsLDgg7Sx5/IwCXfMAXSQimX1s1BZOfk3kkK+r5OOLsVuc3cLqX5US5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rRzeztTe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C59AC4CEE9
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:07:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741946835;
	bh=0yS2KAgrPe1yZ517KKUzW8cOvlnmeopzxk4jNjNyfWA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rRzeztTej2Ku8T5bEE5hZ2VcHMk4CblRIomrtlJEg8FjMC+piKy7JxFBJi0eeFTNG
	 +g3EMTu0auIN1Tl9ITUsNgrMbxUsV/072zvNfY63fZzQR8iKb2jqj/c+RGF79qo7MJ
	 4m7Hd1ubfxe2tcNlnkwQwg29PHdlaXKLu1Vxv1TArOZLrO+KuoErhLkDtRx8pE0WRn
	 U1ToqNkSQt6JqGnahwlWlu4pJux2+kBTxOAI1OVZ4WuA6vYQwM0u8Hv/H8rXWQu9Ph
	 pAqTJB32/rcfNd0iLMHtOpdesMO0UPxq+aUDqdS4nx2szh6c7GT36Fcou0zGN8wfuO
	 H7LRXkjfKA0CA==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5499d2134e8so2299814e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:07:14 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXpcUuju7RJ7iXf+KjStSadLwsf1GHPRxEX0cWsyXDI/qwBqm99DfP63yvRToI0bSqzwmYiznfIlO83mBA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo/9Wc4/eLcORCyscuf1kdRLaWYs8GSkDUeP7d9p/B7CBSeHac
	R7AyAeGwaQjqNVCYgqQwp5zYYvqUbfBcgcZDIklhrqvv3CUZ+7Tycbxbo9pm0p3htij9vr60FqB
	wIba5y2U+2lfM4hCBPfmKfxQEpjI=
X-Google-Smtp-Source: AGHT+IEX541pw8tHBtmR2xtVFXkJW6BZPGSaon1yhR7Z6/N08CXKshMjgaivw/E9PTO844q8x1fy2ksW1K+CPFTpP3M=
X-Received: by 2002:a05:6512:b0e:b0:545:3032:bc50 with SMTP id
 2adb3069b0e04-549c38fb8f3mr729455e87.19.1741946833660; Fri, 14 Mar 2025
 03:07:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307150940.1309703-1-matt@readmodwrite.com> <CAENh_STT90u1G1rqiXOarM5O8Ls5CyxTbrh+Sqi9PBqPmg9RXA@mail.gmail.com>
In-Reply-To: <CAENh_STT90u1G1rqiXOarM5O8Ls5CyxTbrh+Sqi9PBqPmg9RXA@mail.gmail.com>
From: Masahiro Yamada <masahiroy@kernel.org>
Date: Fri, 14 Mar 2025 19:06:37 +0900
X-Gmail-Original-Message-ID: <CAK7LNASyyoJJV==wy2KkrNYOHn6xr0-Y780jJ4cut-wvkvh4Jw@mail.gmail.com>
X-Gm-Features: AQ5f1Jo8S3DczfHRITGhYea4Kd1qHzlV61cYf9PIJXod2n0FVVrNMmpIlP59b94
Message-ID: <CAK7LNASyyoJJV==wy2KkrNYOHn6xr0-Y780jJ4cut-wvkvh4Jw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: Add KDEB_COMPRESS_LEVEL to control compression level
To: Matt Fleming <matt@readmodwrite.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Nicolas Schier <nicolas@fjasle.eu>, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com, Matt Fleming <mfleming@cloudflare.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 13, 2025 at 9:38=E2=80=AFPM Matt Fleming <matt@readmodwrite.com=
> wrote:
>
> On Fri, Mar 7, 2025 at 3:09=E2=80=AFPM Matt Fleming <matt@readmodwrite.co=
m> wrote:
> >
> > From: Matt Fleming <mfleming@cloudflare.com>
> >
> > Give users more control to tradeoff compression time vs compressed size
> > when building debian packages with a new KDEB_COMPRESS_LEVEL option.
>
> Ping? Any feedback on this patch?

Sorry, I missed this.
I would have missed this completely without your ping
because this was not sent to linux-kbuild ML.
(sometimes I still notice, but sometimes I do not.
Including linux-kbuild ML increases the probability of my notice)


"man dpkg-deb" describes

       DPKG_DEB_COMPRESSOR_LEVEL
           Sets the compressor level to use (since dpkg 1.21.10).

           The -z option overrides this value.


This provides the same functionality as KDEB_COMPRESS_LEVEL
you are adding.


If you use dpkg>=3D1.21.10, you can do

 $  DPKG_DEB_COMPRESSOR_LEVEL=3D1 make bindeb-pkg


KDEB_COMPRESS_LEVEL might be useful for users of old dpkg
versions, but I do not want to add an option which we know is already
duplicated, since we would end up with removing it again sooner or later.


I even want to remove the currently-supported KDEB_COMPRESS
at some point in the future.
So, I submitted a patch as a reminder for myself:
https://lore.kernel.org/linux-kbuild/20250314095337.2209653-1-masahiroy@ker=
nel.org/T/#u





--
Best Regards
Masahiro Yamada

