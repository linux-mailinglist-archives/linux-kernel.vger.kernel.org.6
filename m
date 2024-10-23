Return-Path: <linux-kernel+bounces-378864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EDE9AD672
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:15:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0A389B21B7C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61B2C1FBC80;
	Wed, 23 Oct 2024 21:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JCBhlMDe"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F95B1FAC50
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 21:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729718110; cv=none; b=HFcUCvXOq3yLxviLshcHN1Yxb2ReIMLXQVm21jLnZNzEOaCZo6DmC7ywzS/ecdtox4AzXLVwuDs8RGcx740L+bFIXzQqpKC+otvoOgqQOIa1HU6eUz4hgT8w9+GasBvE0ffoQEsHCW5U4Q5t+WPdqdOO9QCG2Z2Y6k+gIek9XfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729718110; c=relaxed/simple;
	bh=4ZP52DrOKx/INwLhclU+6dl4fO5N9uCgynBJoArxSTI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t6U8a+M/Xxvt6sdgrvIdovF6fnRO6zq1CTSpDVmdjY1vtHPtVMYICAEJsrxaAJGUhmgITXZ40JbTUCWbfgOk1U2CerOmZr1xzEoROM2M/RysMoyDbGMxSAvb1qRgV+uxrSCMZUC5Xxxw+4w74/DbELUoy1TObjOrfCmpIhsX3Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JCBhlMDe; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4315a8cff85so20635e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729718107; x=1730322907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WfTzqdb1VSf8Gk5yizZmo+tj3CJXoQHkksQYnazcBsI=;
        b=JCBhlMDe4thyQiMvCnjU7Cm62K3f4D/bQJxXwiTfkdaGX74UcG+RqrrjhDEK3CBcFD
         0TKd8lMZMNTcVDT1rt2XNW6+yt41AxK0wdup8GeV2y9sWbncpeULC2EPTUJv52GFHEdI
         AnC8csmb3MG+sHpoA8zdm4ANyEUp/EcgUwxzHVd8SsDEGmIMQeB9SNo5NR84UHIGhPLL
         CZsj/v6b5h9uRtv2qTGScWboWAyKttG6NoirpxYS3QPxrd934uAUWtfEkIOQxIiDgRIO
         BCuusWi0H+YfVCsxF6bK94uOo2pTkUN+eL61zpBbz1FWz1hJvcsp5zWKzKWO6LrvFfAZ
         IzBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729718107; x=1730322907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WfTzqdb1VSf8Gk5yizZmo+tj3CJXoQHkksQYnazcBsI=;
        b=geYBgRqhB+jxgV9RdgUOHtejcQexoJ7zVyNBydOijy2Jfengy7tcvxW0g8kZbfT1jE
         K/+JJhU+4yxgXj8nWweNIy2Pt3wHKb7YLGzBcRW4EwJKgagScUjkbJoqDbSo48iKnQ4e
         ZVdpmjFFd96KAGbswu3UnmfNqBjtb9vHeNp/ampdhSZPsIWtEgB5sCwvzBNJ6Pt+sqTT
         VqPnNQt6vJxIP0xXlsLChNdSw2wQMHTUB+emx3Swq4ySBgif6veZruNXgoCtsQjSF8Gl
         qxmRo1wUYGvkLfDUDTxBQhVKc2WZEcHdHjFyNZJMirWhc+Rab0YwXYK7MWpjfho1ztlD
         IStQ==
X-Forwarded-Encrypted: i=1; AJvYcCXH08HbFON8rTN2QP1AmjFWPI8CS5YsUDJ4LpvvPnhU8dgV1X3iMD25MwQfu3uos6mmjJgmBsJcP42x+mI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2MbZn/WuTIvEXVbLDGs8I/RhTYuMGXMwjABsyxZ0uMBAGxxow
	T4z0eIOfzMco87e2cB+2gHYC/OWVKm9kibGmNAifgUjgK4Ou9S8jMbuOrKIW8LnGOu8jd7uXpV3
	nmYT6asumAvz4ioacgdBRtAJgECom2/ZJ+u3r
X-Google-Smtp-Source: AGHT+IFqBJIw1NFCo41gy3+FTzGpIJM2Xgam9sFU+VbVhx4UVG5MiIzQo2Dnw0+91MIY4eDDcQSOrd12O2f8n7BVvB0=
X-Received: by 2002:a05:600c:3d86:b0:428:e6eb:1340 with SMTP id
 5b1f17b1804b1-4318a55bda2mr1281755e9.4.1729718106868; Wed, 23 Oct 2024
 14:15:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008183823.36676-21-samitolvanen@google.com>
 <20241008183823.36676-39-samitolvanen@google.com> <8017c328-f039-46c3-b472-f203cd6e2cfe@suse.com>
In-Reply-To: <8017c328-f039-46c3-b472-f203cd6e2cfe@suse.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 23 Oct 2024 21:14:30 +0000
Message-ID: <CABCJKueABoo8xVfE1JBZk-kw8cTK0h5ibOqo+hBEAgpfGSTgdg@mail.gmail.com>
Subject: Re: [PATCH v4 18/19] kbuild: Add gendwarfksyms as an alternative to genksyms
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, 
	Janne Grunau <j@jannau.net>, Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>, 
	Sedat Dilek <sedat.dilek@gmail.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Oct 23, 2024 at 2:59=E2=80=AFPM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> On 10/8/24 20:38, Sami Tolvanen wrote:
> > +gendwarfksyms :=3D scripts/gendwarfksyms/gendwarfksyms
> > +getexportsymbols =3D $(NM) $(1) | sed -n 's/.* __export_symbol_\(.*\)/=
$(2)/p'
> > +
> >  genksyms =3D scripts/genksyms/genksyms         \
> >       $(if $(1), -T $(2))                     \
> >       $(if $(KBUILD_PRESERVE), -p)            \
> >       -r $(or $(wildcard $(2:.symtypes=3D.symref)), /dev/null)
> >
> >  # These mirror gensymtypes_S and co below, keep them in synch.
> > +ifdef CONFIG_GENDWARFKSYMS
> > +symtypes_dep_c =3D $(obj)/%.o
> > +cmd_gensymtypes_c =3D $(if $(skip_gendwarfksyms),,                    =
 \
> > +     $(call getexportsymbols,$(2:.symtypes=3D.o),\1) |                =
 \
> > +     $(gendwarfksyms) $(2:.symtypes=3D.o) $(if $(1), --symtypes $(2)))
>
> Is it possible to pass options to gendwarfksyms that apply to the entire
> build, specifically, how can one say to use the --stable option? If not
> then I think it would be good to add something as
> KBUILD_GENDWARFKSYMS_STABLE (similar to KBUILD_PRESERVE), or maybe
> a generic GENDWARFKSYMSFLAGS?

Yeah, I left that as an exercise to the user in this version, but I
agree, adding a KBUILD_ flag seems reasonable.

Sami

