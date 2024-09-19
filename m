Return-Path: <linux-kernel+bounces-333050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A4A97C2CA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 04:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D9BF0B21B80
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Sep 2024 02:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F4E1F5EA;
	Thu, 19 Sep 2024 02:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qAFONkWX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9A51E517
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 02:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726711879; cv=none; b=EBZaJWDM0FMOA98dDI1EyXWonzifrO6fs7Zal5ytz429JwwALhjh9ih9foPEStdeJvOGHXE0KHW4yWh41E0ryM5pGGYUjcRE+vDkWa+J/fOb3GAPVMCzSkjW9cqaKgGpiOk/WiCGv0A5WKRtcvjf2DHy7K7YwhaVyGPKkezpiYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726711879; c=relaxed/simple;
	bh=gGaUKoa+dM0FQu8U47KtUCbRAgB1i567HstcK+K/wXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kK1jqUuwrBs47uQJh0/hBUVkFtlGqEcKIRsW6nDUwmnY1EkcYYz2ezIsidp9T869epsrxavoWZLfs/V4sMvSFayEVgbgdzzSV7c/ME02TNzEK83xvLNMTpemfM7OBba6UhCkI/+Ho65TeAnSklO2zUEQL7/o2GKhrKjjxrb6UMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qAFONkWX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3847FC4CEC2
	for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2024 02:11:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726711879;
	bh=gGaUKoa+dM0FQu8U47KtUCbRAgB1i567HstcK+K/wXQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=qAFONkWX8nRLXD9w+1UeRQXINj2O3uqvPW+CiOA10TPNo9Uw04oU0rKCz91C1FLIB
	 lcAPpAi4sBtY9styPcrff3GC8ppHnzh9IVjOWSD+cJI3Y9/0V9yjxutTTRnh1bXqqV
	 ljCEEVsB/EryCMryRv7sxfRunjD038mmEI1ncq5N2hmtsOaJqK+77UCuQUVMiYCzN+
	 jUyYQqJ92Oxfu941CckUzzXkMFqRA98vu1ZFpPDr0BgjuaIINrXHMwIIppq4gAY0qH
	 q275PhU8wVc1V/8JdIKNkUKeYL24NAfclsIbFw2qLa3VwZFe4xPjTzAZkfUqUUirRa
	 ojZSSQ1Wx/Oiw==
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-277e965305dso199678fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 19:11:19 -0700 (PDT)
X-Gm-Message-State: AOJu0YzHjFx3TPZT20xoTkVqSKqXCHCBZkJXq/sPPBZXi/z9lYZxvABS
	NDUGXuQ24sJtU5Tc8KwGWgUXtljnHHzUdQE7VCzGbMUEIvBOkh4sbQqjeq1H5fO9pwElofwPzJ4
	JcTVsChEr1QmpLIqdODsZcgHTEDg=
X-Google-Smtp-Source: AGHT+IECu0Jo3zOz+TAIwm1XxazpZHIcJuxJgjUtR0DFNU10vWP1zJ/rReqEUwlP+vP+FQOi3BTRbbncdIwNone9lTs=
X-Received: by 2002:a05:6871:520d:b0:277:e6f6:b383 with SMTP id
 586e51a60fabf-27c3f2c661cmr15698511fac.24.1726711878545; Wed, 18 Sep 2024
 19:11:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CGME20240914030000epcas1p3ea5fbfcf2a139d61193ff4eea5bf6042@epcas1p3.samsung.com>
 <PUZPR04MB6316617B76FF4DE05E2DD10281662@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <1891546521.01726710482634.JavaMail.epsvc@epcpadp2new>
In-Reply-To: <1891546521.01726710482634.JavaMail.epsvc@epcpadp2new>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 19 Sep 2024 11:11:07 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_TgOTT4ijsZSGXxRAKNcvVw+fch4ijZoN9Jv4-UVpf1g@mail.gmail.com>
Message-ID: <CAKYAXd_TgOTT4ijsZSGXxRAKNcvVw+fch4ijZoN9Jv4-UVpf1g@mail.gmail.com>
Subject: Re: [PATCH v1] MAINTAINERS: exfat: add myself as reviewer
To: Sungjong Seo <sj1557.seo@samsung.com>, yuezhang.mo@sony.com
Cc: linux-kernel@vger.kernel.org, Jacky.Cao@sony.com, Wataru.Aoyama@sony.com, 
	Daniel.Palmer@sony.com, cpgs@samsung.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 19, 2024 at 10:48=E2=80=AFAM Sungjong Seo <sj1557.seo@samsung.c=
om> wrote:
>
> > I have been contributing to exfat for sometime and I would like to help
> > with code reviews as well.
>
> Thank you for your active involvement in improving exFAT.
> Acked-by: Sungjong Seo <sj1557.seo@samsung.com>
Applied it to #dev now.
Thanks!
>
> >
> > Signed-off-by: Yuezhang Mo <Yuezhang.Mo@sony.com>
> > ---
> >  MAINTAINERS | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 82f19f0f0752..031fd91a4e57 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -8378,6 +8378,7 @@ N:      binfmt
> >  EXFAT FILE SYSTEM
> >  M:   Namjae Jeon <linkinjeon@kernel.org>
> >  M:   Sungjong Seo <sj1557.seo@samsung.com>
> > +R:   Yuezhang Mo <yuezhang.mo@sony.com>
> >  L:   linux-fsdevel@vger.kernel.org
> >  S:   Maintained
> >  T:   git
> > git://git.kernel.org/pub/scm/linux/kernel/git/linkinjeon/exfat.git
> > --
> > 2.34.1
>
>
>

