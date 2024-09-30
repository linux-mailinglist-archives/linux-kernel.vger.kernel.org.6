Return-Path: <linux-kernel+bounces-344542-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72F0D98AB13
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 19:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19A041F236FD
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Sep 2024 17:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F63B198833;
	Mon, 30 Sep 2024 17:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZitWeMR"
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE221940B2;
	Mon, 30 Sep 2024 17:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727717291; cv=none; b=IWqmMQP2U0ltd/4byw7vytrPfdtI7BjFn+wvoXrMbl0hvhuBE7YoK3ql7yXr+qxrBli4TUerI8AmaE0EKgUF3lkZVHf3uDp01cvCLZ4P+N6B/PdkAvvgD96i+YdKs/igjWrb/AIaNich86DDv98XkQQEH9gyyL7IODOJT1x0NJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727717291; c=relaxed/simple;
	bh=y4BXX/3MgyDzqMoUXB/PqYpfXdVxol8FGHPAPGrXo0s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y/KPsLcjk4jntjcwyVdXdR7zr5QUZafcBvLSF+5ZSk/Gyx8Ocod9RHpjNnm0FokXLYhyFdQAuI3mzAHu9iZyBIKx/tbeYL47olsGLWJXKbO/EbOspeCJE81D1hVE7klOsq2zWg9vG1sgB6/Alda6aLBHqEtimeb2cIMhYsNSB9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZitWeMR; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-7db61fd92a1so204261a12.3;
        Mon, 30 Sep 2024 10:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727717289; x=1728322089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y4BXX/3MgyDzqMoUXB/PqYpfXdVxol8FGHPAPGrXo0s=;
        b=gZitWeMRihGl49NYMAtjVwuPvfvpabulVNmmaSdIq2uSyCa7i+yXZQ8UCfqAxjrXsR
         YIgO+0L2TP74VVYPyv6XFj5KqAmDuzuDvr7JmeIIGo/oGNp5eKANimgLUELOhC6+jIxm
         4asfISfem6FoPTJkDD6BKc9fixH3tEuZAbb2f4fzSOb8fGfSVqXNSRfGBc3Sm3MuUA7m
         DKMcs2U0w+evxZgeZeTwMEg8Koms1VgyTcam5yRNmJE3Vs/AZRjNmAGngItgR0VRFmyJ
         1J44HU1iWJaC76+5CYL+++JUhtmuhXsMpUDGqeH4nJYcyJBYIzGa6sgxQHLhcrDMlJYZ
         uFiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727717289; x=1728322089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y4BXX/3MgyDzqMoUXB/PqYpfXdVxol8FGHPAPGrXo0s=;
        b=M+msD5iFuTPE2OWA1gfa7rwg1/UWrXtridBe2I4ZQsCD8C/CECvDBnw+VJvRZBRxzQ
         OsCFerdJuMuR3vAfedeHL3VOMmVshXwIuO97NLAkwjooCy1AGH/fBqJSBF3KdZ2o3Ix+
         nvXYxnJUpIyb8HdA25PBpYTqkAznpVNML7uro3UJKVRB5FvKJpEh7obhwv6pJ+27+5xf
         whLW5XoDwZU5Y3n9utBpQIrHB2+kQ7FUtXfK255ZJrxQ3nl1CAe/Kqo2YnKUg677QDBk
         X5GBq4P9SX+rmGv4g2BXj8lK316RLgWU8vPBkLNYIs4oJJEPdkxtzUVjtKMz1j2rn4N9
         TtrA==
X-Forwarded-Encrypted: i=1; AJvYcCW46XQ6pfjlKnpTM8lRwpcCBpn7rNXWyZeJHRIJRh+UfyhdMKjkPxX9vanSOjdEncWkF0/jXBIsU3IY6Mk=@vger.kernel.org, AJvYcCWqu6PloY1H6SgxSdXWspfQAqmFIR/aex/C8ckE6+kfJJyJAn2l5cHNWbIBgIiD6fONRCUXoQiCUDlq4qiqTgs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx6hhiIOj3iIYoVHRajFY1mGYFhxAZibHBUm298Q8JrE0fTpna
	OlZa2UAKe33lucNx8pnSAPTSkxQ2JhUXcR0B2DnMrb7RWrXQF6nMYZQHCTnLSWGcP1UgaBHnjqe
	BPQjmy5DQbI40Kc9pkIOcLhPIAD4=
X-Google-Smtp-Source: AGHT+IH3VabIhyLMuBTP0YVRfxEJ5e/5dl7ZWztnHXEjPqs5yQwDhZ7Mvp0CJPXRg/kXTRsTG863uzeaF6KiqEjlS2M=
X-Received: by 2002:a05:6a00:190e:b0:717:87c5:84b with SMTP id
 d2e1a72fcca58-71c636144bdmr5543692b3a.1.1727717288794; Mon, 30 Sep 2024
 10:28:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240930144328.51098-1-trintaeoitogc@gmail.com>
 <20240930144328.51098-2-trintaeoitogc@gmail.com> <2024093044-violator-voice-8d97@gregkh>
 <CAM_RzfbJ5qsHKfNxV1EzhYEDdCmXP0THH=g1MX1yHiRP=9tYFA@mail.gmail.com>
 <2024093007-safari-lego-45ab@gregkh> <CAM_RzfakS8=Qr=vThJcW-eX8izBs5Xdjo+p8=Ji7Nf=_ozv0Aw@mail.gmail.com>
In-Reply-To: <CAM_RzfakS8=Qr=vThJcW-eX8izBs5Xdjo+p8=Ji7Nf=_ozv0Aw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 30 Sep 2024 19:27:56 +0200
Message-ID: <CANiq72=tuzfe__WJN3Apva7EFYA=PJcYDEFkRtu=VMyDdoL0ig@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] rust: device: rename "Device::from_raw()"
To: =?UTF-8?Q?Guilherme_Gi=C3=A1como_Sim=C3=B5es?= <trintaeoitogc@gmail.com>
Cc: Greg KH <gregkh@linuxfoundation.org>, rafael@kernel.org, ojeda@kernel.org, 
	alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, aliceryhl@google.com, 
	mcgrof@kernel.org, russ.weight@linux.dev, dakr@redhat.com, 
	a.hindborg@kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 30, 2024 at 6:40=E2=80=AFPM Guilherme Gi=C3=A1como Sim=C3=B5es
<trintaeoitogc@gmail.com> wrote:
>
> The 0/1 email is for explanation the motivations, attach a link for
> discussion or issue and too for explain how to test this.

Yeah, that is fine. What Greg is saying is that, when it is a single
patch, one can put that in the patch itself, below the `---` line. You
can add explanations there for each patch, and when a patch series
only has 1 patch, then you can use that space as the cover letter,
thus avoiding a 0/1 email.

Cheers,
Miguel

