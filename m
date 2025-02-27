Return-Path: <linux-kernel+bounces-536430-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A894EA47F63
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 14:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C75111888FA3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Feb 2025 13:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DCB22FE05;
	Thu, 27 Feb 2025 13:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kmSEnrpb"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352332309A6
	for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 13:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740663601; cv=none; b=CZd19wh+3vvOchWgigVgaDjsCfIE7esV2MA/nEolZ1FKCC38XvvCuNAsaSO2jYCjL2S3Pt54/uXa3fhj3GY0cKjSkeCp5v33DojiciTkGJpi4/+UhviMby6qqqCEeu1vZYgzfl8ff73CcakiZgbegkfQWpoHnO7mFOw/Q+wiF3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740663601; c=relaxed/simple;
	bh=2cSgpAMzuRDyg/OP6JlvBhgcN9wqw2ZkQw1H+nq1MIM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WFXrWO4qmZXfFXdJmRtoPG0HfmskUasnMpTkw1ZJvqtS9oGiGzRJCTaoZFGnv37xtFSTOkWDZZpr7NamTp6QneK7U6GciCgrxx2Q3eJH/zBK2eLLTHNA3BO66MOm7CXAjYpPeiCi7FMX9dMolW6KCNYZEZ6nykRDp5wfDZXxM9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kmSEnrpb; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-30a440effcfso22380171fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2025 05:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740663598; x=1741268398; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0QqIj+Xj2KKd5yOn9wT3FKv7ilH/QlR+xG09MXlqr0=;
        b=kmSEnrpbsDstq93JrQAc11bgYRJ04qHCfsckNfDMashPvjc07h1rsxjwvRcwz6Y+Nl
         7xgxCk8LbQDkfmWlixWr1+M+zYmAmFVWZN5Lgpwy1+VxHiq1Doah3TYVtkoqm5icetXe
         oHSzI61j36vVwiOcmsduC3OpbMmnT+mUm3Z0SVTZhRBtajWq2zWMkaKjK0Xo64wrsl+V
         2O3tiNADelwWso67S0KSph+e9hJDTD7UmvxssCF5/tfVRwqCqZDVh2nwdvyUu3y10rr4
         MjdD/yno6GmPx49sTBYoYM34XO8KDUkM8jTGaNuuBiigEIwOn3Mncq9ZyTe1owTaGeKr
         D3Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740663598; x=1741268398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X0QqIj+Xj2KKd5yOn9wT3FKv7ilH/QlR+xG09MXlqr0=;
        b=EUIJB2Wghn13/jafxS8ZJ8LNlKoU2XLGsdRJEWDKQur5zIcJCN9WKRoq/ACDO7dIsc
         IKS88AdW3B5f7YjBW7y90gY52XWyf7fPkN4tpvoEOvoK3vy34V7MT2mD0SJc+L22FSz1
         3aRDod6EvtI6dnJLvlox7ByLW+tRgEfkiSs6s0j15PateRiA/vwgg1NSYDOCCr8WwjWK
         9Ao1BCVO3xOaqADLCYYkNs8uvGY+3N4LJ9o/YKTe57vaID+TaP1IgEqHO8vuvCEW7H0H
         ZP//4a1hlh0w/ZjK3vESCu2dwn80nz7cTJibs2tZM5KlqYpNaxKSYsS/PPl1hWs5s1Nn
         cIyQ==
X-Forwarded-Encrypted: i=1; AJvYcCX1kWvPPtuUcx2qLPQKn/lqv8QnEJUyeA7B4X8U+YTgjgToD6/1EGF69FEz9x/1J/uJTEwikvdG6dvY7AQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjKLMjpIkgDAmcptL1pzm6ES8Uet1N/C5cUTscqkrPfXFUr8D/
	3JJXM45mq6cJgz5DCCbv/v+sdg3gUF+gtlhFbmEDMzGL56Mf9bBGCfdaSWrqzSc3aDMfev4lmui
	rvVv8GngykOeLGPWge6NV5FNpdjk=
X-Gm-Gg: ASbGnctdIq4WOp7F/8bMWzzxtDTIPb7vTOby2BjjMGSu3DndeS18eE/oNiEAKfH5J+Z
	SlU32SHNDCURDsSb0dtqcfQ74DquoUhNSvNaEnR+FhtL7HOcRCWoy4N40oJuY7aBCn3ZRRjyY+I
	+Y+x6YfMHyo9cQpXgP9jZAzch03wPLjvLOvDwiS6Ze
X-Google-Smtp-Source: AGHT+IFv8UCQLBFW+HmySTIopoV3gqxaBg5wvtyqxsA9/SWPF9AXdxTyZjDvJBXPJMy/X/nEAbqTXjvKUANVm2PlmXw=
X-Received: by 2002:a05:651c:50e:b0:308:e54d:61aa with SMTP id
 38308e7fff4ca-30b8464a2bamr20649531fa.2.1740663598018; Thu, 27 Feb 2025
 05:39:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224-macos-build-support-xe-v3-1-d2c9ed3a27cc@samsung.com> <be5abg6u6wm62nhak7xrhtlkqxcekael6ztnkatwqxcil44x5y@p6yrbfingm4e>
In-Reply-To: <be5abg6u6wm62nhak7xrhtlkqxcekael6ztnkatwqxcil44x5y@p6yrbfingm4e>
From: Tamir Duberstein <tamird@gmail.com>
Date: Thu, 27 Feb 2025 08:39:21 -0500
X-Gm-Features: AQ5f1JrvujnQrNdPwimNUvnOfF-Py3f8kwIyufq_KgAHEzKnySZFBMMWJGb3ArY
Message-ID: <CAJ-ks9=gaxW2191c+K0E0MgjsQWLYoKxJZLxGb6RMbPRVHc4tQ@mail.gmail.com>
Subject: Re: [PATCH RESEND v3] drm/xe: xe_gen_wa_oob: replace program_invocation_short_name
To: Lucas De Marchi <lucas.demarchi@intel.com>
Cc: da.gomez@kernel.org, 
	=?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Masahiro Yamada <masahiroy@kernel.org>, Justin Stitt <justinstitt@google.com>, 
	intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	Klaus Jensen <k.jensen@samsung.com>, "Theodore Ts'o" <tytso@mit.edu>, gost.dev@samsung.com, 
	Barry Song <baohua@kernel.org>, Daniel Gomez <da.gomez@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lucas, chiming in here since I also care about building on macOS.

On Mon, Feb 24, 2025 at 10:05=E2=80=AFAM Lucas De Marchi
<lucas.demarchi@intel.com> wrote:
>
> Is this the approach taken for other similar issues you had? Note that
> argv[0] and program_invocation_short_name are not the same thing. For
> this particular binary I don't really care and if it's the approach
> taken in other places, I'm ok using it.

Believe it or not, this is the only place that
program_invocation_short_name has ever been used in the kernel. There
have been numerous instances of:

#define _GNU_SOURCE /* for program_invocation_short_name */

but never any actual callers (that I could find in the git history)
other than this one.

> I was expecting you'd take the acks and merge it all through a single
> tree since you received push back on the need to build the kernel in
> macOS.  Is this the only thing missing and you'd want it to go through
> drm?

I believe the other patches have been applied or dropped. When I last
tested building allmodconfig this was the only issue I ran into (macOS
arm64), so I asked Daniel for this resend.

Cheers.
Tamir

