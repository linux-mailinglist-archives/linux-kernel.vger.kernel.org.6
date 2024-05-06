Return-Path: <linux-kernel+bounces-170506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215F68BD831
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 01:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 723F6B22187
	for <lists+linux-kernel@lfdr.de>; Mon,  6 May 2024 23:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D1415CD7C;
	Mon,  6 May 2024 23:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vejhz29H"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAB715B0ED
	for <linux-kernel@vger.kernel.org>; Mon,  6 May 2024 23:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715038244; cv=none; b=ZcRxbnwnFoBJcia7iM6PapMb3EG2x6v9IY4ETaQkkFBYg+S2NGePJpTJVi+3OWhkt+H4yG5CbVZiB3Un8ITsgi56IyZ6g2Vs34qSlZVESEsXOdd44hxVLwkpZFZJ0iYxun5zVpAJUM/y1IQH8bZUty6eblTCwx3W4KXO730RdDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715038244; c=relaxed/simple;
	bh=dC5gmNPxNSH+aIEWUfqlcoUV3/RSi8n3oR46/xve6dA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qi62R9jNJERojl/JXLKWCJ1li7mqltu1r98mQ3W8vRKp2NUGaeH4HpjSsmbvNRTdKlN8ggtsPYGB4elE8jNfnhoUMUT9gGYdCvdjbG4eFG3qeQgGBsl8czlqIyzFc34sh0fdXJQ5Q5yWOWrUZ8lkSXo2LGUz3NPxQoJHKGD/m7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vejhz29H; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5724736770cso2362a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 16:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715038241; x=1715643041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rday+enGpH1mUN4w1iIrCf7IG9Q6aF8QR6lBBrCyZ7g=;
        b=vejhz29HQj+gKtb2WBiToZaEiReMxu6rMyWsEaQNyrYelzJtXm6QXARFGs+gCMc9uI
         1bR8A8t7uZb8FSTLnOipGuyAZmNvSCl2NFiAbn4XxXfy1Imvhd7IVqvIN+bib+3w1lg5
         IPQd+9F7JFynHtvPiJBcLsZxTmMac1vH7Gm2e1xTsVooNKySrtOU+K8dzpYmwKqHaa82
         0CNs5dMpqqcaWO5Xlv5V0TwvxIYN32LFWPStMApOSn/fJ5Nxj1XPwaooQvf/nQ/JLTvf
         H+wXXm5iOf+UNGNkM2f30GeWTBQxcMGMYv7L7JHrGMtb3P7m+yGK18wfaU1L5bTxH32p
         r+ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715038241; x=1715643041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rday+enGpH1mUN4w1iIrCf7IG9Q6aF8QR6lBBrCyZ7g=;
        b=iaBZys04c2ZZIBzzKnvpZNnP2sibiSgG6yMjcBkSTLlZiiKbTjGf7O1tsWOlGp0ldH
         dH87vMuywC483nAetBYn75PKp0rDsD8WOkzLk8eIbSIjFarF7wzz1oDH/7KhmJpu5Xdq
         7A7ZAocphUu/2pDXCfWKkURlHiAWJbrDNmMPg0nhInWQQ7UGY1wUlZD4UDTYV0kR5vec
         A2N4GgBE3dgfqVaUSRi4TrD+kCIejCkPsF9cG8SZ4276zs+DYSQLq0Jdw2e7eq2YX7YQ
         zqJ7x36Ekwca1AH0mHSEwL5qV3OHZ4owNmu5YK1C2EAR95BRM4eagiHPduGmyH1snhnQ
         rtYA==
X-Forwarded-Encrypted: i=1; AJvYcCVLniFypJWYOgDsUXaT2wbl+0dfGbbngPZUaxth7Tw4gL11f7jKkfXeAmCTxC+daueiJ+BIc6abHsXXYTqmo9WXmLEBKld/6YkqyLEr
X-Gm-Message-State: AOJu0YwcaKsRnNRT32F13i7YASbw64J/n1Rf+h92gjLNRXRwyj0a6olz
	RIPJinOkI5wakozAiP2HnO2670EQAvJrI1EYQ2tzsWJTvh977zErX9oRJ1+n2CO+qyPqxzrxlw7
	Z6GMcTXBQB+k4TT78IMHkOMq7jElvkpjxy54q
X-Google-Smtp-Source: AGHT+IFPtbSaAcsaOKbHp6npYdFSTUzqld8pO8i1uwvZe0pXCtMxJsE/ukQM7Zz7NLIcHgg7/XYVun1u85SF7+71r+g=
X-Received: by 2002:aa7:d389:0:b0:572:554b:ec4f with SMTP id
 4fb4d7f45d1cf-5731316c507mr37653a12.3.1715038240800; Mon, 06 May 2024
 16:30:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416152831.3199999-1-usama.anjum@collabora.com> <202404161027.63F4D4FDEB@keescook>
In-Reply-To: <202404161027.63F4D4FDEB@keescook>
From: Fangrui Song <maskray@google.com>
Date: Mon, 6 May 2024 16:30:27 -0700
Message-ID: <CAFP8O3Jjkh0U94CbS=epXELMtCBpYt4fGejX3spH4=GdF7zVSw@mail.gmail.com>
Subject: Re: [PATCH v2] selftests: exec: make binaries position independent
To: Kees Cook <keescook@chromium.org>, Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Eric Biederman <ebiederm@xmission.com>, Shuah Khan <shuah@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Yang Yingliang <yangyingliang@huawei.com>, 
	kernel@collabora.com, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 10:28=E2=80=AFAM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Tue, Apr 16, 2024 at 08:28:29PM +0500, Muhammad Usama Anjum wrote:
> > The -static overrides the -pie and binaries aren't position independent
> > anymore. Use -static-pie instead which would produce a static and
> > position independent binary. This has been caught by clang's warnings:
> >
> >   clang: warning: argument unused during compilation: '-pie'
> >   [-Wunused-command-line-argument]
> >
> > Tested with both gcc and clang after this change.
> >
> > Fixes: 4d1cd3b2c5c1 ("tools/testing/selftests/exec: fix link error")
> > Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>
> Thanks for this!
>
> Reviewed-by: Kees Cook <keescook@chromium.org>
>
> --
> Kees Cook

GCC versions before 8.1 do not support -static-pie,
while https://www.kernel.org/doc/html/next/process/changes.html says
the minimal version is GCC 5.1.
Is this a problem?

If not, and CFLAGS is guaranteed to include -fpie/-fpic/-fPIE/-fPIC
(PIC), using -static-pie looks good to me.


--=20
=E5=AE=8B=E6=96=B9=E7=9D=BF

