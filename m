Return-Path: <linux-kernel+bounces-225152-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31563912CAE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 19:54:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 629151C23C7A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2024 17:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894C916A936;
	Fri, 21 Jun 2024 17:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dKNecg6p"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DF2F40856
	for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 17:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718992444; cv=none; b=gZsGmtqAy/ihGHP0pcH0RWEffBBbL/Ih9Y+/j5MbauH1NtufXd7+uynWuC0wqG00X7Y7F9hb4Vz1Unbt9l3nkbtjDSqP/WMKK4MppAgZmGoHxNlNF+ZvhIT6ARpXjhhZ6dQgJWMFT6cl3TyKK740Kdk/84LlpC0O3u1s4M6MgMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718992444; c=relaxed/simple;
	bh=5Ul1dcj7VExsFyXCnzd+GQq0jgR2txEAK2Ur4F8DNN0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RTv+LjW2ePBAnNFr8bLTE1XlviA847aWq2DqffoyxUzyiarxQhYwd/Ir3f6ksjyvFzWPA2SGb9uVxVFPLwfUTvfZX30JYo5YKDP7yCMdD/S81zcDc3x3FntIx6ynujh8Wtad9ZAgSHUOYFR98OdOZUfNPOHG7WJJ0NyLiAOS71Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dKNecg6p; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57d20d89748so2343605a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 10:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718992441; x=1719597241; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Ul1dcj7VExsFyXCnzd+GQq0jgR2txEAK2Ur4F8DNN0=;
        b=dKNecg6pwMqM+StHoS6wM2n0CVcYHvEOxeI1X/aRuymyzAmwH9hHY2KXE/EcIwLY6P
         /bvlOa4z4sqIpvsEQF77ujwPGxcr8bysbmOoRT2l+Y1zbZUSUlfACt7g7eCCxDjUwYKP
         bWz5Lgj8nJIM/BdMIM7SRl1XSjzp1HHZlmDjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718992441; x=1719597241;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Ul1dcj7VExsFyXCnzd+GQq0jgR2txEAK2Ur4F8DNN0=;
        b=H69OG1F+Nw1ORG5NUV4H58KhBDwlo6JiEw0L6cn9i9oQMjbwmQDyFli70ODqyNOYcA
         0PdmDvY2RtH99iyyJcx2HjIPvhSxrmxSldZ6ahYl9y3e+4o4hCp676dhUtfedXqHXkag
         9QZJ3U72Z3O+RTnrZH4NHCgMizN4x/hIUTn412VZ8sA7UD8l9byPvuwNPno3wHDa1dEE
         AsFHvgCUH3zvX4kN11hYue+n060WkqgucGfQhLH+f7vkNs8YxE7Py3ot33BQb5gHGtIi
         /vQw4Malffkgnd4Wpzor72P8nMJxKn+4UHn1xmUqy5vIfxbBVzubOy1bHRWWoQyhPf3V
         Q07Q==
X-Forwarded-Encrypted: i=1; AJvYcCXdn+tf7ggzSJh6/tbueN5/btLFWX8vmiGiP8qAfXPrDGVG47j7WUjgJPGA9kwNV89N7k0ULOKS0puqmiKUhiXYlxesEz0RYF5XOp+r
X-Gm-Message-State: AOJu0YyVAKZUZV28px+vOuOMg/ZzrCNYb6X6RTs+8Fl2S/QgkYHfepTt
	/qrBaMJqX7JDdrbYpiPBtpdcc2h6hOF0EnWaTqI3MtizLGu7+GYlkoj4q1COeUx2lDBwhaDeg1M
	=
X-Google-Smtp-Source: AGHT+IE04/25wM3DPVslXvp98MC/tJwM5EECBFkc/nJfjSCeXzjGK4VdESSz6uB5OvtkHVFdsnmxKg==
X-Received: by 2002:a50:d498:0:b0:57d:2ce2:69c6 with SMTP id 4fb4d7f45d1cf-57d2ce26a43mr2107857a12.28.1718992441291;
        Fri, 21 Jun 2024 10:54:01 -0700 (PDT)
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com. [209.85.218.53])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57d3048b92esm1259809a12.57.2024.06.21.10.54.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 10:54:00 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a6265d3ba8fso243474166b.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jun 2024 10:54:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWt5KfX2db0BaAnpdg6syufKaDsZ5xdqaydzVPr17uJOImrGeFjv+NLkF/0pVDQYaSJO52J6Y5nSjHCUzVC/k5IGQc0LvMQ0RJjyx40
X-Received: by 2002:a17:907:c283:b0:a6f:57f1:cebb with SMTP id
 a640c23a62f3a-a6fab772482mr519008266b.50.1718992440147; Fri, 21 Jun 2024
 10:54:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621075208.513497-1-yu-hao.lin@nxp.com>
In-Reply-To: <20240621075208.513497-1-yu-hao.lin@nxp.com>
From: Brian Norris <briannorris@chromium.org>
Date: Fri, 21 Jun 2024 10:53:45 -0700
X-Gmail-Original-Message-ID: <CA+ASDXP1W5dwuiD0wRzwdvkH-0OwXMJN+3h4d5qNxz6XvftzbQ@mail.gmail.com>
Message-ID: <CA+ASDXP1W5dwuiD0wRzwdvkH-0OwXMJN+3h4d5qNxz6XvftzbQ@mail.gmail.com>
Subject: Re: [PATCH 00/43] wifi: nxpwifi: create nxpwifi to support iw61x
To: David Lin <yu-hao.lin@nxp.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kvalo@kernel.org, francesco@dolcini.it, tsung-hsien.hsieh@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 12:52=E2=80=AFAM David Lin <yu-hao.lin@nxp.com> wro=
te:
> This driver is a derivative of existing Mwifiex [1] and based on similar
> full-MAC architecture [2].

For the record, mwifiex is a fairly awful driver. For one, its locking
schemes are generally unhelpful or nonexistent, and sometimes
placebo-like (as in, they look like they are protecting certain data,
but they do a very poor job of it). So I'm not sure this is a
promising start. It was just yesterday, in fact, that I was telling a
colleague that if mwifiex was proposed for inclusion in mainline
today, I would reject it.

Also, I'm far from interested in reviewing a new driver here. My only
interest in mwifiex is in making sure existing hardware (especially
those used on Chromebooks) doesn't get significantly worse. That
interest doesn't extend to "nxpwifi".

I just want to be up-front about it, and that you might as well drop
me from the CC list. (Of course, that's not a requirement. I can
ignore email too.)

Brian

