Return-Path: <linux-kernel+bounces-192238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 095938D1A7A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 13:59:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 991AEB253AA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 11:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9A2C16D32B;
	Tue, 28 May 2024 11:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wvR3m5ZZ"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B224516C863
	for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 11:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897531; cv=none; b=I/LMTBCukVBwkBby0ul/Wy9YnHrdVDM0njdTwn6ENFdlAb00Y8yaGsWnfyOc2QEq7eRRsGwVJcV1UCwsegk054Wn1oGyQyKjWkulHjJm/CCM9BPIUyRBf5Wn1LKeB0wTIZqPDT9gjkxmZHsssKUf7B0o+amy6orYnHfVdF5Vh3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897531; c=relaxed/simple;
	bh=XYEcwBrn2ZuAVxK/8OUQeCzOCxQyqvHA12tGOH+svqk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aevywr0RM2AoCBtebomvCFEUA1IIUSXkT0dYySTzKEnBhv0dkOhhs4XZ5PM0rh9Cl2NajK/PgXyBP55/CuaBdyb4qRUHjTTcbpdpWhcvuyYowuwZ0Fd1qdzcVjDVPEyMWHbRYyMRsJOZng+TUtgvb7E2HbRcWDInsYZEjFgJEYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wvR3m5ZZ; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-62a2424ecdaso7320427b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 May 2024 04:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1716897529; x=1717502329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XYEcwBrn2ZuAVxK/8OUQeCzOCxQyqvHA12tGOH+svqk=;
        b=wvR3m5ZZpG9TtziiPqDPQd0C34yd81oJCe8YxiDKUc7x3yDmT7O61VeD0EuhMNMEfA
         JPkShAzEB05xK3MwdHG0UN53ECPH+FcKzBaXBYzvmFZFg73NSah1Cyl4QLhTlS4DN9Xw
         y7Xu5ADr6FQgPeL3KBt/snfKfeCGH6cu3osGRYmwamijfnjbQqGsSoENKN5kyXnmOT6m
         NkJxGf9W7QKX28IlARln1KP+2pS0jF9P+LfCd2gRSgBbzXglwdJxWq5+JsQE/XWHP+q0
         L/j8iD6b/QTfd3PIyTEIhFdySbTNKb9YgYyR5jLd/Vk1wbP0Vt6YReX+QHkdfHlSu6X4
         7F8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716897529; x=1717502329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XYEcwBrn2ZuAVxK/8OUQeCzOCxQyqvHA12tGOH+svqk=;
        b=rPJAHxCnAF8GPGR7NqXv0+jQFWGNoNEKDUCBsz3zBha4yCT1oKxprylWDe3eCG8e53
         BlIQ1330AF/FsV49IV37VR4c8/8haaCH89XbdfrwDr0SkCkMZNDacUUQ6iwcS7U3OHqj
         V33NXSAIxdo7EiUu3vY4/QIZgtVT4T9Ih8e4BBRVM73efx8EeB86fCsj7zTgYcwMfuPZ
         oW2ysQzH/KONKBESWtSyiFMPuQ6RnfH61c6fOi1BPTHeEvc2RUp0KKOA588lhgRe3OGS
         B+7IOREkFHy4ApXkPNhUB+HVJInTk/lf6tSdUJaeI/0LlX2h5KtRkN6b4rG1qAwgFMsV
         EYzg==
X-Forwarded-Encrypted: i=1; AJvYcCXo8ahxwiHeoeVHLSwx+KGK8OKazhS4tnAognvnhuu1PBORrBE8/Y4DWCbX1a/qvxau63qyCirfm90LqYBgglHLEUuMJ/7lKtIQvAAR
X-Gm-Message-State: AOJu0YylmNrUZY83hDkg17IuIew8KQgkqC6dFLkXvygXkluJ1shYhe3P
	Z92aiICcWryGDpnimldx+Qxk+J3wdIa+NwYCrMfJ0PeuVVzI8MHqOcL25MOk4V+Wt+K4Yfosr+h
	nJIDLkFl0W5wh/tqmorMZ/ppHP/X4ZZffrq7dMQ==
X-Google-Smtp-Source: AGHT+IEi2FFXpJzm6Ui68LI58fiW+9ORaUI9qMfSH5fZ2ghY0PYbSNMQ3NXlttGGYAUDF59nM+IzQBpvFB2cxXuz9QU=
X-Received: by 2002:a81:92d4:0:b0:61b:33f6:9bbb with SMTP id
 00721157ae682-62a08de4efamr123625807b3.28.1716897528671; Tue, 28 May 2024
 04:58:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240521152602.1097764-1-patrick.rudolph@9elements.com> <CAHp75VfpFtYtStacY68-iu32x-XK3XMn_34N7EH07vvhjwp36g@mail.gmail.com>
In-Reply-To: <CAHp75VfpFtYtStacY68-iu32x-XK3XMn_34N7EH07vvhjwp36g@mail.gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Tue, 28 May 2024 13:58:37 +0200
Message-ID: <CACRpkdbFVpZhF_RZEeZf06PRq-Sf1Z-8apUbnaJAFDaQt_5xMQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] pinctrl: cy8c95x0: Use single I2C lock
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Patrick Rudolph <patrick.rudolph@9elements.com>, naresh.solanki@9elements.com, 
	broonie@kernel.org, linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 21, 2024 at 7:25=E2=80=AFPM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Tue, May 21, 2024 at 6:26=E2=80=AFPM Patrick Rudolph
> <patrick.rudolph@9elements.com> wrote:
> >
> > Currently there are 3 locks being used when accessing the chip, one
> > in the driver and one in each regmap. Reduce that to one driver only
> > lock that protects all regmap and regcache accesses.
>
> Right. But please consider converting the driver to use cleanup.h.
> Dunno if it requires a separate patch or can be folded into this one
> as it seems you anyway touch almost all mutex calls in the code.
> Linus?

I think it's best to add a separate patch for this for bisection,
just right after this one.

Yours,
Linus Walleij

