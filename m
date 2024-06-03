Return-Path: <linux-kernel+bounces-199766-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF428FA597
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 00:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BAF7284128
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 22:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F19DC13CAB8;
	Mon,  3 Jun 2024 22:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="JUnqFBuI"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9E784FB7
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 22:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717454173; cv=none; b=q7m3XV3FPDlKuALITsgTUgyGIT4zYEVlod0ekx/LFLq0ULXWfW/7YsUoq0v8fq0j6NoGYZXgIAZ5x7kXdGG4rpZcE70IYi2Pp/eHYSmMP8Voy+LlYjJQSpkyiOUZdvZtxO+EY41w1hwBgpJTk18d7bAHzicUKmu6LpKuDEC//00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717454173; c=relaxed/simple;
	bh=eLQTm5bdwsIaGMdIKYVz+iwaKfPty9F535UJJa1XdvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sr8hfNjKeXoLcE7taiMLKok51BBS/NIlFJ8YuIKVRZMVUbU+gs3k1SpUwxd7r9IBcDoJwccfXhaX4Rl5FychbCBtLUGP71yyXuzu0HFS8Cgp9aEQ3I9nfkuPMFQ+pFPXunAEqZEV8FH1pYmOxKRbksoLUcVbVKJOOmg8mC5izR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=JUnqFBuI; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-62a087bc74bso45583007b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 15:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1717454169; x=1718058969; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLQTm5bdwsIaGMdIKYVz+iwaKfPty9F535UJJa1XdvU=;
        b=JUnqFBuImCJDxqUT1ykjHVXh/ujwI5KrsEYcF8hSJ8DtqDHHcqkSEg4FZru1kvyFte
         MA6rVBesYqx4Sz2p+AoXgo/mo9uUMZbr/e4goohb9qLEes8CSzML0Deb7qgRFWxjxV6v
         AFRu2UJmCkmC1nuAaut6YXv58I5Hoi3HrFx1/LNpcTDRPWnWvMUAifAzPtoeGycycNPD
         jI/eY72Vv5CG1w6dv5hVKYCeWcAgtVpEK/FPbys7BikwBpQ01eSo16084nMqZ3deecjJ
         g0QbKCAQS+rXzf7ol53epun0N9ZChMnP92nPOKHolmGxzNCU2mimAGRwrNdoqWemv6vi
         1Sow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717454169; x=1718058969;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLQTm5bdwsIaGMdIKYVz+iwaKfPty9F535UJJa1XdvU=;
        b=cFBCvwkdxFXMkWezesFEhsWwMLhdIKPsL1/2kE1j8EMiiu4VFHsXesghM02+j5mvEG
         jA3IHfoiMyty/V1EJcpm+iPhCsGYjJB9uLdvnPl+s11eWkm5tXTP4EmBDs8O94qjFG3f
         26I2sHtrE4FqkKCQvpvNssxyWEzQCkA9Eqz2TNmK4DhIJyTJcfV4yGB8QCSdsuJ8YY2t
         29I/jO2clQvh/oC5iAloCvw87qtsNyPzWj5XxdMjYnN+ecnl1rkCiVgP/hRR2kI+SLlZ
         qmewinuAtxTziEy03acD0I0yGo58//hCx3xiteaw5gO2WebyujZTY+IdlnUinVdnVr9Z
         ZXeg==
X-Forwarded-Encrypted: i=1; AJvYcCUcUtw6B6HTLLV0twyy0m2uc5o8kT+vKn1uEUNUQV4MHn3YZv6t6D4OgKIWTnMJyKkrOLZBXw7PotxC6q9yl+4GCOYujQHh3A6uKbAD
X-Gm-Message-State: AOJu0Yws4lWnRj8UcY6utX3/0+ZKouSUuxvfgGC7pm60rpGaKMzzST1u
	hfhKEpFQJ+b++hemOiN5HO+GhEScYthw4WaCzNvPDWD3sUBIYgXZjDMmjKRlOSTtuntzRwG7+M9
	tlcFV5tMbKKx4w/8hotYUA1pIvg4Edpfc2YQQivE8FC+S2+fo4Q==
X-Google-Smtp-Source: AGHT+IEnEj0HaAe2XXJ+P58B/3DENp7qDyeNgjkaCnTRpS2uJyaK4IE7boqra/mRVtjfChhSz9siZckxkdCbwRz+WVk=
X-Received: by 2002:a81:ee03:0:b0:610:e9b2:f84a with SMTP id
 00721157ae682-62c79720b48mr101000677b3.26.1717454169627; Mon, 03 Jun 2024
 15:36:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315125418.273104-1-cgzones@googlemail.com>
 <20240315125418.273104-2-cgzones@googlemail.com> <202403281506.46D9C5BEEA@keescook>
In-Reply-To: <202403281506.46D9C5BEEA@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 3 Jun 2024 18:35:59 -0400
Message-ID: <CAHC9VhTWoehrxwPe3_Xf0Jud-ouc8Cfwp0hwcE3+JekWQ2nJXA@mail.gmail.com>
Subject: Re: [PATCH 1/2] yama: document function parameter
To: Kees Cook <keescook@chromium.org>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	linux-security-module@vger.kernel.org, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 28, 2024 at 6:06=E2=80=AFPM Kees Cook <keescook@chromium.org> w=
rote:
> On Fri, Mar 15, 2024 at 01:54:10PM +0100, Christian G=C3=B6ttsche wrote:
> > Document the unused function parameter of yama_relation_cleanup() to
> > please kernel doc warnings.
> >
> > Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
>
> Reviewed-by: Kees Cook <keescook@chromium.org>

I ran across this in patchwork just now and don't see it upstream yet,
you're picking this up right Kees?

--=20
paul-moore.com

