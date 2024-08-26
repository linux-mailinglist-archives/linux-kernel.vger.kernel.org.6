Return-Path: <linux-kernel+bounces-300915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B41395EA71
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 09:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E510B21D58
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Aug 2024 07:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE91B135A63;
	Mon, 26 Aug 2024 07:30:57 +0000 (UTC)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C07582490
	for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 07:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724657457; cv=none; b=ASP0qNU2FFzsvEnZyyL2FWtNmHNWvfVh0qaSctMGX7ZoAiNIjwJujigQYUBMcQkfw9Ytls+bYoT7UcV5wnsUcIeaJlMaWneL45+jIiZfzD5L7EbUeisEBMe8ETS6ztzSExQG3UElvamlRWgO+PzjBc6eOYq9lU+9zE6eCA3eaAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724657457; c=relaxed/simple;
	bh=CX/j63UgkM15rLGMJ0MEpUE6c01kEYDRQQNx5pWSrmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UAFiYkZu1X1We8dG3Kkfb6YGLVjherwU7gkyVtIy9gQS8yyvskXRDhcFjtLbX5lbfz2xzeAbLyD7kFvjtNpA4SvgZS07RO2YRZuRzgXWSWDL3xYPtkHc5AkqqtOkpOHrm1j819DxIRDrlu+3RlolVM+/QMiDMvjaQ4zbfYaioBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e115c8aa51fso3940522276.1
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 00:30:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724657454; x=1725262254;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ej0Y88/f1FavQ2R0a1yf4wgWu7EXeTD+zQk15WdLEY8=;
        b=v5C+n3zGBFdv41B9Iknd8Bd5rkYl0ruRMoBfdyCBLRLrqIxpn6zk2WsULPjz5Cv1kl
         U4MMnL6Jj7WB18zPkaqayZAb2e2vlMYLifZ6HglV+Sg1i4u4UIQ4Y0T2Y5UL6KWYpRX9
         bWz/fIU1t9bX5D4AjRSJS8+/SKrk4Xmp5tWOBoXB5c1Ym3L67idfjgUfYWJGdX2DwBgp
         zGNRiWYDdJlJ9YFOeMwSH55f2xvZdleBPyOSC06sl/04oADtJzx9rgIi81f6iGXkHxhm
         Zps+Cs7AyJCKPrwigAXLbEvyfK+seUDXMKvNdlVjviFJyJYBRf9/xbVGs8OvG+PaHjww
         LyTg==
X-Forwarded-Encrypted: i=1; AJvYcCUWEL7HaEoderHg2ID+6ibfYhNQk0+xlaWataUDcSg6WT0bqEDdnZf+/La7JJ8JZQRllc7ShYUUU3ZKJ1o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWsqSx4x69euYjIqlggkRaGdQqQXtut18kSnmpaAObGh86shsO
	gW9mRrgQf8bsrV0yLVqE2ZbjTPdta7wGCzhVxZQT8ZnEcpFR3UdLs+bek3U/
X-Google-Smtp-Source: AGHT+IGFIVAoBU5dwaQ5WeBoQ52StBWuNSDwdPFe1nIKnS8LYCdUYieoFzE1ZzSpuQKKb80Q/dgZ4Q==
X-Received: by 2002:a05:6902:98d:b0:e0b:caef:9845 with SMTP id 3f1490d57ef6-e17a866e3ccmr10305143276.56.1724657453749;
        Mon, 26 Aug 2024 00:30:53 -0700 (PDT)
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com. [209.85.128.173])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e178e56a5f7sm1922288276.44.2024.08.26.00.30.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 00:30:53 -0700 (PDT)
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6b5b65b1b9fso32858137b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Aug 2024 00:30:53 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW1UdPD/7o0k7pKBTD7P0ARWJNBV4JHmuoE+N77TfekC7QuQcFgF0wVzRBJw2Diwb4eiOlvH/HhuAVb6go=@vger.kernel.org
X-Received: by 2002:a05:690c:660f:b0:673:b39a:92f0 with SMTP id
 00721157ae682-6c624bd7e33mr108695887b3.11.1724657453347; Mon, 26 Aug 2024
 00:30:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240730234506.492743-2-thorsten.blum@toblux.com>
In-Reply-To: <20240730234506.492743-2-thorsten.blum@toblux.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 26 Aug 2024 09:30:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdVP+tpOEKo61EEd0Ynk=efaWRxoXDzSiWQo7YVe=W74iQ@mail.gmail.com>
Message-ID: <CAMuHMdVP+tpOEKo61EEd0Ynk=efaWRxoXDzSiWQo7YVe=W74iQ@mail.gmail.com>
Subject: Re: [RESEND PATCH] m68k: cmpxchg: Use swap() to improve code
To: Thorsten Blum <thorsten.blum@toblux.com>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 1:46=E2=80=AFAM Thorsten Blum <thorsten.blum@toblux=
.com> wrote:
> Remove the local variable tmp and use the swap() macro instead.
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>
i.e. will queue in the m68k tree for v6.12.

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

