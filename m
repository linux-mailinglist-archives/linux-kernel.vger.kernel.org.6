Return-Path: <linux-kernel+bounces-225519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EC689131B3
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 04:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543DB1C21B74
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jun 2024 02:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CDFE8494;
	Sat, 22 Jun 2024 02:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b="AGN9EyJZ"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A34A5F
	for <linux-kernel@vger.kernel.org>; Sat, 22 Jun 2024 02:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719024933; cv=none; b=gQBObjHoHhPDfF4BnzWsYVZQ5wp2uiBGII0dUTc8KCjIddNUHwYyiqLFNV7Tli/4XU/kFPgTMrlYeb3+Vn5f5F5a55lLUQ6HWfgnrmqprm8aWwCde1KNuim9sTbJIHnomWkuDrl6oTYNbia0dVJp2TR0+wQ+moZk6yKYbyolYFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719024933; c=relaxed/simple;
	bh=cFm3oU+O3ftwhE1/YyR//xmiv64Jhxl0bY53bUEjhkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ii2TZvF25LLuUJiDrN7UByJw/OyI8mz+IiomGpLPbxiug6rY6psTw+1a2TUS7ZZq0awNTKokd3GaatsD9PGvZ8JR+f7mRb0+K1YfNJct0wave1rRUcjjHpTtFaAlPMBscoz9Mmc6FOi7vGD/kkGGwD1VjWoiNdF/Ewa5N/FNsq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org; spf=pass smtp.mailfrom=wbinvd.org; dkim=pass (2048-bit key) header.d=wbinvd.org header.i=@wbinvd.org header.b=AGN9EyJZ; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wbinvd.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wbinvd.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c7cd2f077fso450511a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 19:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=wbinvd.org; s=wbinvd; t=1719024931; x=1719629731; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LwP5SXjNhIZlkDmJOYjqFnuGdCe4xjq6ghxO1lquneU=;
        b=AGN9EyJZ6zI8ePpVhW9aZVfYfCyf3297kIp7c8rqg77s4Fej2BDXdAhtuOrHWMwtGJ
         0wwoSzS6zQytMdjGeNzDHUvaZLWrbBFSu/giWvL3Yu5dDYA71NG1tQOals1g2VBWE2Ld
         XlBvMrKNsjTTO04egQFy3sr/cUJZP+DqSut1BqMTUFLDdb9QU1xcXg/GBwAH5b7o4sLv
         /tTIpksicDQMXa0nqN8Eu6A2gWUOGZfP5GVpmHdabs9UxlNSk9agOpZA6B0dZHnLnNec
         J7pxcn1EnZpnSPPxc9r0VKsxhjd3v28d0xS775Gthp3pVGLug6WNKmuEGjM43fifdTfr
         OKoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719024931; x=1719629731;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LwP5SXjNhIZlkDmJOYjqFnuGdCe4xjq6ghxO1lquneU=;
        b=OXPvr2AIZtNpYI3z9/RVQ0KSW/Y1g1TqJwOzTZ1WLYt8/QBBcvM68cHqw9ugmNbWgi
         KbhRqVYlnreG4QpJapaZTatAxAmI5LquCxn7OXvHWK9buQ8xDtP/UrVX/u/K+1Wtyfub
         vkK8HChnQhO/8MDmrjJtxI73kLzwXiyZSIfd7MHRLHI6r0wk4TY44oR/eRY2HXZqotIp
         4f3PMwHnS52sXLLAuDCykKjQazlGoh17QDHztg825hcGvaKtDA3uGF48MevF/9TKbBe0
         goO944aj0HDL0rRM4ur0KcpxKq7c5eMvW40G027EktdVpBAgCaK52mKXrOy6mgoBrkOF
         HNXg==
X-Gm-Message-State: AOJu0YxgduMj1DEpk6iFaWk+/dsjq0OUZToQBb8HH0ZEwrlcsdSS4QE2
	ceQlgP8TBjfNJ/k5YSR6Alhs73f2AbbqYP+emyDdrO0R4poUMksGltSUaQEAUPyFFfOM8Gy937q
	d
X-Google-Smtp-Source: AGHT+IF47sfgPxYe0Bek1fqI/+hwfyhqIs29uq1xyzUPKjbau4Bd/kc73W0dBrGxpSbBSzfQHQBEkw==
X-Received: by 2002:a05:6a20:9483:b0:1b5:6b5e:c100 with SMTP id adf61e73a8af0-1bcea5f5f95mr539893637.5.1719024931149;
        Fri, 21 Jun 2024 19:55:31 -0700 (PDT)
Received: from mozart.vkv.me ([192.184.166.71])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c819dd0cf7sm2325325a91.48.2024.06.21.19.55.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jun 2024 19:55:30 -0700 (PDT)
Date: Fri, 21 Jun 2024 19:55:28 -0700
From: Calvin Owens <calvin@wbinvd.org>
To: Nathan Chancellor <nathan@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
	Nicolas Schier <nicolas@fjasle.eu>,
	Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [RESEND PATCH v2] kbuild: buildtar: Add explicit 32-bit arm
 support
Message-ID: <ZnY9IEt571DwqtTJ@mozart.vkv.me>
References: <ZhmKzqxHXaSZmXee@mozart.vkv.me>
 <6bc61e82eaae9e614cbd50a322322173f593c90c.1718936424.git.calvin@wbinvd.org>
 <20240621145514.GA3770753@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240621145514.GA3770753@thelio-3990X>

On Friday 06/21 at 07:55 -0700, Nathan Chancellor wrote:
> Hi Calvin,
> 
> On Thu, Jun 20, 2024 at 07:25:59PM -0700, Calvin Owens wrote:
> > Implement buildtar for 32-bit arm, so the zImage (or xipimage) appears
> > at boot/vmlinuz-$foo, rather than at boot/vmlinux-kbuild-$foo, matching
> > the structure of the tar-pkg on arm64 and other architectures.
> > 
> > Link: https://lore.kernel.org/all/ZhmKzqxHXaSZmXee@mozart.vkv.me/
> > Signed-off-by: Calvin Owens <calvin@wbinvd.org>
> > Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> > ---
> >  scripts/package/buildtar | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/scripts/package/buildtar b/scripts/package/buildtar
> > index eb67787f8673..23d7ff675396 100755
> > --- a/scripts/package/buildtar
> > +++ b/scripts/package/buildtar
> > @@ -104,6 +104,9 @@ case "${ARCH}" in
> >  				cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinux-${KERNELRELEASE}";;
> >  		esac
> >  		;;
> > +	arm)
> > +		[ -f "${KBUILD_IMAGE}" ] && cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
> > +		;;
> >  	*)
> >  		cp -v -- "${KBUILD_IMAGE}" "${tmpdir}/boot/vmlinuz-${KERNELRELEASE}"
> >  		;;
> > -- 
> > 2.39.2
> > 
> 
> Is this change necessary after commit 2b1ab1405068 ("kbuild: buildtar:
> remove warning for the default case")? Without the '[ -f ... ] &&' part
> of the expression, which was removed for other cases in
> commit c3f7bed8fa14 ("kbuild: buildtar: add comments about inconsistent
> package generation"), it appears to be the same thing.

Oops. Sorry for the noise.

Thanks,
Calvin

> Cheers,
> Nathan

