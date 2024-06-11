Return-Path: <linux-kernel+bounces-210657-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F7B9046D7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 00:17:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B04721C23512
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 22:17:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56637153836;
	Tue, 11 Jun 2024 22:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gAPCIT5p"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A87386
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 22:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718144225; cv=none; b=O8PbilYeTxvkBZpSPy92N8la1PTC8OMybHk3ES9ZuGrZariEweZN8U/t3zIbm/KEAB6NnpqAodxB1ONckREF45L4V7a1pxqRcLby72KtIKFoOFlrD+bdqQtttHuivLlzL0CJmuVo3Ygh4SZ+HNWGc57IT74h+C5PoDXzOSPj3ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718144225; c=relaxed/simple;
	bh=d4W9P+5av9h6obZCkp5mhi1yp/9/xBUzGVfOlM/MGzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lbqu/s1TQDRGiSkbKL6qqV4lHO24xwL0JGI5phJfVN2RCfpiwsNpSyzmIq8GkSIv292ExjbmT+vsLEHjrUDW46zAPstmmeoxi8tQGGQbZY0/E0be5YQ18s+4ju8NyQFgd/DR7jBQpMMAhQXHpAtNW4LnYBBFD3l21F5twHyxwZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gAPCIT5p; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5b2e93fddafso159816eaf.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 15:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718144223; x=1718749023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQfSGQJg4wrKubolugMom3IenxfWexnhriikQh8dJwk=;
        b=gAPCIT5p8D6H1evrA+vVxBcmRYIG4eoVPjt1nRMcZ5CVlAhqDN2nKSN96uRlwBCN74
         ToBRvJed5a3U5ThmHih21iQvOatXmY3JzmAe8AK/o9c9FadXgQpHR7SjPKsYP24NxICS
         KZKdb/ei6fH79OHodMcv3P7SrnxTVh8f6aLX8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718144223; x=1718749023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BQfSGQJg4wrKubolugMom3IenxfWexnhriikQh8dJwk=;
        b=esOdZPJXni+uHtMlY+Mc5Mo5UXtcs/BG6dO55HKrsfiBzRwCcrcMamBbRYwKBHXFXf
         zkbgfVhwRqLSwJjgQ05LUBxOG8OlPSrEXsHE7OLZxrCJgjfwj3N9VdJHPyL6O70ztJsW
         wHM32j2MMuk9V4X83nL8H0nd946i2YZPBOAhsVM1B0W5kpUJ+3TuErhkaQ/Q2U0ptrf7
         YKYceGLWcYqBw9idb94KhrQHNZcSQcFTIE2zhRvYRHIbNOx2Ov8aB9TMjybHKgx7VxdU
         VrlSYoIYTtsNx/nrDaKfcnh4CBhlFcTKEEcB0Fcb0kzaF/TEj0JSfydgZH24ET8jknyR
         iqIA==
X-Forwarded-Encrypted: i=1; AJvYcCVRqcsSGi+nFTXhlCWBnyUaTp/is1hXaHd9ieXFDwIv/+rVBtGFzMtE9NgxRMPoXgo3SvPlayS71bkhqeeiYGhNbLnSCBy2lB7Rdvea
X-Gm-Message-State: AOJu0YwzKXWuAGXc2tnEydiZAtxCa8Yg07rp7a/Z7JPfDVLenhbhfHMu
	NQcPLJ6xvwoFbyMezPBJ/Q3FJI0hZXjMWb/vnv/Vje19265D3r+hexdNDH0oYokCOG6+uxYwSDG
	dJf2ouNhXjoFCWLeTEG7HDOSnzZyJGrq7PXnG
X-Google-Smtp-Source: AGHT+IGHr3S//OuVDQmb/JSAtKlai5Gn3ZBqvNjWxEk+id+M27ALiOy0Jz/0t7RlvS66cu2AuRPhUr8PVi9/CT4fikM=
X-Received: by 2002:a05:6870:968f:b0:250:3c9d:fd20 with SMTP id
 586e51a60fabf-255131599d8mr147040fac.0.1718144223109; Tue, 11 Jun 2024
 15:17:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240606224035.3238985-5-aruna.ramakrishna@oracle.com>
 <20240610214446.3380115-1-jeffxu@chromium.org> <C89ABF81-0EF8-40CB-8B04-B71868B79316@oracle.com>
In-Reply-To: <C89ABF81-0EF8-40CB-8B04-B71868B79316@oracle.com>
From: Jeff Xu <jeffxu@chromium.org>
Date: Tue, 11 Jun 2024 15:16:51 -0700
Message-ID: <CABi2SkV6znRR2QirETncu4u7PN7x0jQEij7s1wD4-aTJTO_UBQ@mail.gmail.com>
Subject: Re: Re [PATCH v5 4/5] x86/pkeys: Restore altstack before sigcontext
To: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, Keith Lucas <keith.lucas@oracle.com>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, "x86@kernel.org" <x86@kernel.org>, 
	Andrew Brownsword <andrew.brownsword@oracle.com>, 
	Matthias Neugschwandtner <matthias.neugschwandtner@oracle.com>, 
	"jeffxu@google.com" <jeffxu@google.com>, "jannh@google.com" <jannh@google.com>, 
	"keescook@chromium.org" <keescook@chromium.org>, "sroettger@google.com" <sroettger@google.com>, 
	"jorgelo@chromium.org" <jorgelo@chromium.org>, 
	"rick.p.edgecombe@intel.com" <rick.p.edgecombe@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 11, 2024 at 7:08=E2=80=AFAM Aruna Ramakrishna
<aruna.ramakrishna@oracle.com> wrote:
>
>
>
> > On Jun 10, 2024, at 2:44=E2=80=AFPM, jeffxu@chromium.org wrote:
> >
> > Can we we move this patch to the first of the series? this can be an
> > independent patch, the problem not only affect PKRU, but also other
> > scenarios, as Rick pointed out in [1]
> >
> > [1] https://lore.kernel.org/lkml/d0162c76c25bc8e1c876aebe8e243ff2e68623=
59.camel@intel.com/
> >
> > -Jeff
>
> For this patch set, the issue with rt_sigreturn() is only exposed after p=
atch 3/5 - i.e., when
> copy_fpregs_to_sigframe() calls update_pkru_in_sigframe() to update the P=
KRU value to
> user-specified PKRU that might disable pkey 0 access, thus breaking resto=
re_altstack().
> So it seemed logical to me to have this fix as patch 4/5 of this series. =
I=E2=80=99m not strongly
> opposed to moving this to patch 1/5, but this ordering is easier to under=
stand (I think).
> But if this patch needs to be broken out of this patchset and submitted i=
ndependently
> (for the other scenarios you mentioned) - I can do that.
>
My main thought  is that Rick mentioned this can be a cross-arch changes [1=
]
and we can start with x86/64 and other arches might follow.

[1] https://lore.kernel.org/lkml/20231107182251.91276-1-rick.p.edgecombe@in=
tel.com/

Thanks
-Jeff

> Thanks,
> Aruna

