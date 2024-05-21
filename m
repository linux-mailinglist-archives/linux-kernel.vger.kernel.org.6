Return-Path: <linux-kernel+bounces-184482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F39678CA743
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 06:14:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9332D1F21C81
	for <lists+linux-kernel@lfdr.de>; Tue, 21 May 2024 04:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0538C2AE6A;
	Tue, 21 May 2024 04:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FqzvrUK+"
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E9225569
	for <linux-kernel@vger.kernel.org>; Tue, 21 May 2024 04:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716264852; cv=none; b=Ny61gB7bDi9D+FOYwt+sQMnSpMZO48mSqhPVdceo9StaGfeMBvazhZ2PMVd4z1nBCCeTAhre/7OwjNOXAn9mIl1vNqlayxjD3elSxioJwVpW7VnrdJx32soQCOVJrlRjkhOemLhRXaoP/KIIEXvWAwRC3lutZAwJSk3+AZir6Vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716264852; c=relaxed/simple;
	bh=CIfsby2oPpYY3kXs4oddKQZp1v5fbpImVUNDZjOnRlQ=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hrq6pCX2jZvmA7TXK1obPVkmv7cBgAGJla5sX0z0dRL7osen3uA4P8lKuhzOoeG5SuU0ZLJd9XsrElOSgWoLeACYeOD58Sa4Oayv0t1DOTvP6fiJt2p+OQBcOCapOhVy0MTzehw2Xcde54qP8Z4WwxWP9K5TAoH3pHS2vPz+v+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FqzvrUK+; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4e1459a13fdso1685407e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 May 2024 21:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1716264849; x=1716869649; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQAMz+e0g3nZFFrVh6fJZF5RVSqH/2InZskkKfH8zyQ=;
        b=FqzvrUK+NdBYJq1VycMOMh8ZN0tRdbaKWSMXeI/6r5UUsJOLYzunr9KGFP/DsYaMwh
         MG8zrBUsYAbv63C1DE402ZkysrdXurAK3o44FaMD2s6W5oHluZQThEztf4R43xGiUySR
         Uzj9EW2DRZtNnCYEbk5O5Dyxw2xs9y9tyUEv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716264849; x=1716869649;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LQAMz+e0g3nZFFrVh6fJZF5RVSqH/2InZskkKfH8zyQ=;
        b=spDljWt3EpoNyhaod+UNZTU92VGdmFe6X66ZVwRpn/f8VPNGujmWIeY4HH1eI2dRlq
         zGdUxaiRl2Xerq5z6r9sfcNjW/T88rGh1vRCPmnbhQHgXLKQw5fHZsTi/Zs3+U2CEYox
         ZxQ7Blb66yJzHZtgG4SE+RNe4f+KDYcytAH0DFoT7W14SuVOYK4aYPtYur3lHwD7cBJo
         LKZszXbkfPtm1hMKZuX9vJvWkzpV7TzUZTkaPMlqPlSGKvw79xAWf99u8gD5UE/2klLv
         wOetXnEt7A3jRBB01fSByPSriliLkuGn3/VhgkvSz1GSmTkN946RNS9dYOutek014fSx
         tfog==
X-Forwarded-Encrypted: i=1; AJvYcCX61qbeRIyMnQnqOpUO/g1zuFqWaChl4afIoZhHWT1yy4hmVjxClAfEROB2n/xPY2vVShLurxlSA2xtaHuX8imSppYq6JK5DblmdGno
X-Gm-Message-State: AOJu0YwNUibr7FdsLGlVrvcbtNhNCMjwy99UhEwD7tBz1gO4txO9J1pk
	oqegKrZOccwajY7PDH/1Va9LdBRBpFpHIRO8iDrvCB/JkBJ1+knjBcC7UbnZ6kI/vWr57bZPBJj
	Ot7k9JolnYZ99KuZdqTVxZ0SNMDURWxaOtOVC
X-Google-Smtp-Source: AGHT+IErt01awAAr7IkOBO0CcMyBfFJYFdKpLSMo+GZEaQYY7nAl+Dw2FgYvqdFb3fdaEaa/X8kAqIyrlEk7mqPwHt4=
X-Received: by 2002:a05:6122:a19:b0:4d3:4ac2:29f4 with SMTP id
 71dfb90a1353d-4df88286136mr27403633e0c.2.1716264848783; Mon, 20 May 2024
 21:14:08 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 21 May 2024 00:14:08 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <202405181346.901048F98@keescook>
References: <20240514224839.2526112-1-swboyd@chromium.org> <202405181346.901048F98@keescook>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Tue, 21 May 2024 00:14:08 -0400
Message-ID: <CAE-0n50TuoSEaWmAcUoX3KDtp2ivdHmqWpaYn+dVdo4_L1H2NA@mail.gmail.com>
Subject: Re: [PATCH] loadpin: Prevent SECURITY_LOADPIN_ENFORCE=y without
 module decompression
To: Kees Cook <keescook@chromium.org>
Cc: Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	linux-security-module@vger.kernel.org, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Douglas Anderson <dianders@chromium.org>
Content-Type: text/plain; charset="UTF-8"

Quoting Kees Cook (2024-05-18 13:47:14)
> On Tue, May 14, 2024 at 03:48:38PM -0700, Stephen Boyd wrote:
> > If modules are built compressed, and LoadPin is enforcing by default, we
> > must have in-kernel module decompression enabled (MODULE_DECOMPRESS).
> > Modules will fail to load without decompression built into the kernel
> > because they'll be blocked by LoadPin. Add a depends on clause to
> > prevent this combination.
> >
> > Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > Cc: Douglas Anderson <dianders@chromium.org>
> > Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> > ---
> >  security/loadpin/Kconfig | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/security/loadpin/Kconfig b/security/loadpin/Kconfig
> > index 6724eaba3d36..8c22171088a7 100644
> > --- a/security/loadpin/Kconfig
> > +++ b/security/loadpin/Kconfig
> > @@ -14,6 +14,9 @@ config SECURITY_LOADPIN
> >  config SECURITY_LOADPIN_ENFORCE
> >       bool "Enforce LoadPin at boot"
> >       depends on SECURITY_LOADPIN
> > +     # Module compression breaks LoadPin unless modules are decompressed in
> > +     # the kernel.
> > +     depends on MODULE_COMPRESS_NONE || MODULE_DECOMPRESS
> >       help
> >         If selected, LoadPin will enforce pinning at boot. If not
> >         selected, it can be enabled at boot with the kernel parameter
> >
>
> I've folded this change in, since loadpin also works in non-module
> situations:

Thanks for fixing my thinko.

