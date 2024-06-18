Return-Path: <linux-kernel+bounces-218790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 404AC90C610
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 12:14:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1A631F22413
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 10:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3337160784;
	Tue, 18 Jun 2024 07:40:37 +0000 (UTC)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com [209.85.219.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1781C47A5D;
	Tue, 18 Jun 2024 07:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718696437; cv=none; b=U6FyAknh4m+1eGpLh0nC6rnZQexhWHg3Gn7/RC0uEF+0G30JRrgziHItndXl2PTx9594rK2P+m9GnmrMCkbk5K2c8JkgrRrCnG19VygtZEfAKLc7TPQLMUDD9HorJ6f53pwLBTbELeGwMLmZ+Xc5qO5pZoa3J8enidsu3mDG0zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718696437; c=relaxed/simple;
	bh=yj43muI9Zx5DTjKKVxrlSMZFj+rvK9otEprK9qxy+is=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tcSkXqlMPMQS/c07w0KC2U1LVSi9S+b3GaM1ycxPOQVMUtYngbMxgkmmBRcn1yGM0psicXzdKRq/fmShZGefu8DJ64Rs+Y09qrvJ9/CVSzJVX34jK+zMhD69one8G1ESpeXfAMcNPt9y9yMEohUwFtjT/7/jGTlGTJQHwXy3zH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dfe81d54db9so4870248276.2;
        Tue, 18 Jun 2024 00:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718696434; x=1719301234;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1+xcRo0rtv0+KrEU5Kv7T95pjKSl0TJAoMf3IC0KPCA=;
        b=l+fy7Wp+RBz3XkXxD0jp9vu3p8twYEtGtwOyrYISQnwwuTZMzyhiK7OEgcRuhpNt1E
         67+q9gOgb1g8bcOSnuNF+zQBU/Z+LIk2Hq548CIaDcqYTq15UUs26xc6RTmG79spiXOd
         5PKTj/ZpPUumKVq3nhPHJYcCDvTVGb1RZqpXri9OLSaGIF/9HBFBavKwxUPwz2781nZW
         AJxVqVqE2US/6WoS97arS7UGUpgI1MuZhlFOO/6OfYzPlOz0aR8nsZxuSMC3NM1XMLk/
         z723BTK9NKuN1JnnmHGtshG2NP/qzO5qwhS+MRxxMscYtK8HjEuZ7FTLjFcJ8DkTYmGp
         kAFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQAO3Lf/Pto2KTBi3dbr2X0z/tdYu0nsvfcbgKfxuHgAu3XMye3MIrWDKK7VDauD8t9mGru34M6d+M0/5SksqM21/S1blD6kok+KsPAseuRlisCXQgoVw2o4Az0EjiMvC36magBbe0LkM6jLntqUEoRt5mSBhAhlCJY3Tu76Ejdisgr83R/ugtIeI=
X-Gm-Message-State: AOJu0Yxo8tu0ESWAIl0Y+pbwkTeZy0i+0Vl9ATIpoYSzw5Si+bRNnhRa
	LETw2pZlrGYWV6q/ribP22NGsegjT94gwVJo7nbRmnzFCY5xKm2Uutyw5UAo
X-Google-Smtp-Source: AGHT+IFE/eiJfk7YtJdLf8aJw3afMZg7pGrKWus/v4oMRqxTbo+xPXMcmiHIG+il54ABAhA4QIrP3Q==
X-Received: by 2002:a25:24c:0:b0:e02:b7a9:48fd with SMTP id 3f1490d57ef6-e02b7a94d26mr144464276.29.1718696433939;
        Tue, 18 Jun 2024 00:40:33 -0700 (PDT)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-dff046690f2sm2202434276.7.2024.06.18.00.40.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jun 2024 00:40:33 -0700 (PDT)
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dfe43dca3bfso5695511276.0;
        Tue, 18 Jun 2024 00:40:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX1/vBvIwbbPTqAqy6qGnPfZMsBeWRJgXO23kQAnMqVD9svqS3RyO9OaFtLUVFCQ11uXpF/+mG8DCKoWaNAPMrefHIZ3FtNr7GaeRLBpCVlY876epIAUA23Ba2D0zV6VTME8Wq51i0TyThny2aor5K2aRLTRXg7hF5W4C34uI5oP8RZmgrKFEkKQ+M=
X-Received: by 2002:a25:688e:0:b0:dff:137:b5cb with SMTP id
 3f1490d57ef6-dff153aba11mr10722840276.23.1718696433486; Tue, 18 Jun 2024
 00:40:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240617-md-m68k-sound-oss-dmasound-v1-1-5c19306be930@quicinc.com>
In-Reply-To: <20240617-md-m68k-sound-oss-dmasound-v1-1-5c19306be930@quicinc.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 18 Jun 2024 09:40:21 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWqMqakMH+rVoCc2LTpGj-+v+rF0XmEeQwTHrT73Ay5Rg@mail.gmail.com>
Message-ID: <CAMuHMdWqMqakMH+rVoCc2LTpGj-+v+rF0XmEeQwTHrT73Ay5Rg@mail.gmail.com>
Subject: Re: [PATCH] sound/oss/dmasound: add missing MODULE_DESCRIPTION() macro
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 18, 2024 at 3:37=E2=80=AFAM Jeff Johnson <quic_jjohnson@quicinc=
.com> wrote:
> With ARCH=3Dm68k, make allmodconfig && make W=3D1 C=3D1 reports:
> WARNING: modpost: missing MODULE_DESCRIPTION() in sound/oss/dmasound/dmas=
ound_core.o
>
> Add the missing invocation of the MODULE_DESCRIPTION() macro.
>
> Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

