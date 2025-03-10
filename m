Return-Path: <linux-kernel+bounces-555055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1049DA5A4F9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 21:29:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31964163BA0
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 20:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C0F1DE8AB;
	Mon, 10 Mar 2025 20:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VCkHgt/J"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52131CAA6C
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741638582; cv=none; b=TxBTA0LWqMr6xy7GL45OTt/MFEdTK+OIoV6eMIhxHGO+79YeYwmll5hXG97i3HFydoAKd8s6ve+0TMmEoDOxbiQrAfA4ZpHBU5HsgxBCO5mMOPu+C0q6iCAGGCdPA0YM+/zNg+38Cc4OXl16ktc6XwX5TMqutXMZ+SkpiOuSiu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741638582; c=relaxed/simple;
	bh=hWy1NNmb+wDtSIi4PW/nVnogw+nRN5uXUX33xLXpMkM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Nw39Sj4aGkiBLx7hYkoxP8/nOFNHtZCD8vTVls9crJFYkr457YAH+YViGZQVla8sR8T+aJUMRJZ/KsGbgJv9BiZRzAJ6rVeuQO3gBF/CDbkevta7vkG+przzDJxjBrP0pa3vMmMYbP4mXBNP9G1ZuAtirvtY8S/K+9v4QqGHltU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VCkHgt/J; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6fd8be1e534so43849567b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 13:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741638579; x=1742243379; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tDUgfGNw9ICwKZepnDkVTHAQdOKERWg4DcwDZnus3D8=;
        b=VCkHgt/JZaaPTIXA8KjXEbI/hOwbz0aOVcm/oBCsfOFjj6uJr0x5WBJDnoWAsMMxvO
         Exp+6wdYV9OaAKx9zo6vTBRZEKbonGGANBBFg0IWysKG7StkZfwI6dLqzKp75MmiKb+j
         KW4aq4+WJZeX9+pqCPAx9T/KelJWUbF/2OGOnnC19dNeNQegA5WMs6cqrbndgbfiaZpi
         FWDovvyZQvAOiC3FVMW0UbRTGJF9YNGCxX7VMkh3JlNhl9eacFHYVkjtAfbgo1t1g2Go
         IyuG3jXM8xPopjWsa/DN9XwtNNtmHscFyFgt7wbyELF2ZwI741u8ak0+gJVjIz/M9cys
         f5sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741638579; x=1742243379;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tDUgfGNw9ICwKZepnDkVTHAQdOKERWg4DcwDZnus3D8=;
        b=VQK/Sp71id09IiId22Prp5tH/0weCnZ2zwQjYeNIfZ0g/lN5ouNQGhs12h1VGQTbxO
         FXaW39qb+AXiU1OsATRHYngwLkjfX4mqmaDKE4Bo3CwJL2o3GRs1vS0jV/0klaJMMrzS
         vN3Qt8ti9S5mReUIN1njW7aOKp+TSIfyKbNj1l9BqjsjS4q3eA9hp51NyyAAF2enUm7a
         KvJw0Pnpgp9C86NGVktGxjlhHLTYNWm4H+7SD/WW011OKiIPg99/QmOzc4VHi7oE64FT
         LJTeqtKDdJQfA3k7Jpi8Lncl14HaLQW9mrgo0pHsqHhG85z24psCN32/ZuF3q7kNYHfH
         3Btw==
X-Gm-Message-State: AOJu0YwIzrMPGZ/OlWF6tROkyJ2zQhvQTPhAQ9DofaBH/pInfW8P7i6G
	RV7q+GbzFnFbJtjEZFsus4tKVh/9EvN3ykQNmIJqhNBGzxXEoZrhBAb8Rk21p21dQq4zIrK54u4
	JWKmGGIWqbnOhRgXf0zWC6r+SKOWtqk5srWvr
X-Gm-Gg: ASbGncs4oT8FdiNsIsyYi4j8Sqlhkj/pNQY/K9gfwAojEfuFdth2uNIGfnx1RAX0qc8
	WhivdGISch4PUGWvVWDJ3YourBvg5eGaAc3w/ZmhT+oRybIo7wVGFAmpDIvcRgB1hnTMHhP35UJ
	GXmmXfXuykuktXGjD5eYlxu0O3iRxS6I2caLJM
X-Google-Smtp-Source: AGHT+IHo9iy1GNgVzKJMJvK8t10zpvURWG53DXUjC0ljR28U670/ZoBhoVEa4msK2fl4fpIGkvkg9EPXy5FjpxcyQvg=
X-Received: by 2002:a05:690c:25c9:b0:6fb:5498:70fa with SMTP id
 00721157ae682-6febf2fc84dmr218686397b3.18.1741638579693; Mon, 10 Mar 2025
 13:29:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304222304.214704-2-paul@paul-moore.com> <20250309.5ddca2aac3f6@gnoack.org>
In-Reply-To: <20250309.5ddca2aac3f6@gnoack.org>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 10 Mar 2025 16:29:29 -0400
X-Gm-Features: AQ5f1Jo6QOPoGUFGOIb3gjnWMhzQIShhWRjzY8eEyp8Wz0ElgezHE72pke3O1VI
Message-ID: <CAHC9VhQRWOJkSTsYDGHArmm212CW+EOia-b0hR_r9HrCxspLcg@mail.gmail.com>
Subject: Re: [RFC PATCH] MAINTAINERS: add an explicit credentials entry
To: =?UTF-8?Q?G=C3=BCnther_Noack?= <gnoack3000@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 9, 2025 at 7:12=E2=80=AFAM G=C3=BCnther Noack <gnoack3000@gmail=
.com> wrote:
>
> Hello Paul and Serge!
>
> On Tue, Mar 04, 2025 at 05:23:05PM -0500, Paul Moore wrote:
> > The lack of an explicit credential (kernel/cred.c) entry has caused
> > confusion in the past among new, and not-so-new developers, about where
> > to send credential patches for discussion and merging.  Those patches
> > that are sent can often rot on the mailing lists for months as there
> > is no clear maintainer tasked with reviewing and merging patches.
> >
> > I'm volunteering for the cred maintainer role to try and reduce the
> > confusion and help cred patches find their way up to Linus' tree.  As
> > there generally aren't a lot of cred patches I'll start with simply
> > folding them into the LSM tree, but if this changes I'll setup a
> > dedicated cred tree.
> >
> > Signed-off-by: Paul Moore <paul@paul-moore.com>
> > ---
> >  MAINTAINERS | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 896a307fa065..68e4656c15ea 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -6139,6 +6139,14 @@ L:     linux-input@vger.kernel.org
> >  S:   Maintained
> >  F:   drivers/hid/hid-creative-sb0540.c
> >
> > +CREDENTIALS
> > +M:   Paul Moore <paul@paul-moore.com>
> > +L:   linux-security-module@vger.kernel.org
> > +S:   Supported
> > +T:   git https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.g=
it
> > +F:   include/linux/cred.h
> > +F:   kernel/cred.c
>
> Maybe also add the documentation:
>
> +F:     Documentation/security/credentials.rst
>
> This documents the prepare_creds()/commit_creds()/abort_creds()
> "transactional" API that tasks should use to change credentials.

Thanks.  Serge already posted a patch to add the doc page, we should be all=
 set.

> Acked-by: G=C3=BCnther Noack <gnoack3000@gmail.com>
>
> Thank you both for stepping up to establish a clearer ownership for
> credentials!  There is a need for authoritative decisions in that
> area, and it has been difficult to find the right contacts for
> credentials on earlier patches as well, such as:
>
> https://lore.kernel.org/all/20240805-remove-cred-transfer-v2-0-a2aa1d45e6=
b8@google.com/
> (patch by Jann Horn: "get rid of cred_transfer")
>
> https://lore.kernel.org/all/20250221184417.27954-2-gnoack3000@gmail.com/
> (patch by me, multithreaded Landlock enablement)

Yeah, the cred_transfer/keyctl issue is particularly nasty and needs
to be revisited.  If memory serves there was still a compatibility
issue with Jann's patch, but we may want to consider merging that into
-next just to see if userspace still cares.  It's on my todo list to
take a closer look when I have the time.

--=20
paul-moore.com

