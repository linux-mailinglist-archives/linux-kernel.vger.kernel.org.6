Return-Path: <linux-kernel+bounces-316754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3991F96D385
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:42:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DED7B2635A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A8E119882F;
	Thu,  5 Sep 2024 09:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VYavYrix"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59140198827
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 09:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725529305; cv=none; b=ujisihpxQkuFUOfwL2ONEQ5pjmYiyP20cfohpFndCbIYBgdqu1mefOFEVTCDmI4znfzXiPSIr8L9f/uwVKS3cGLfOjgaRT7i53vMPpZ0ZdhjOopXN2Cfj2DTNFfADLC1mPHoMiN5/B/D6o6wpV++fovklMmO9o2SqBSMham+89I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725529305; c=relaxed/simple;
	bh=1zkNgUAM/QwmJuwVc3NX3CSZZoP5SUWIgiCl+DR8w6U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQxXywvph7dAcpDfiZx9/WoU06v7lLOuub/Hq57fRejSzPrKI1zC0v3OGgGWT+m32hb6kfvlfKAiiKiB/84t7hjp1h6QrtGCTbnfSFcTGCHTSC5aEKI6Mt4Es+e5vTAgPZkQulgfHaBuFZTx43KXDGQKhDLy0iV+M74sg+nlqtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VYavYrix; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3770320574aso301961f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 02:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725529302; x=1726134102; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1zkNgUAM/QwmJuwVc3NX3CSZZoP5SUWIgiCl+DR8w6U=;
        b=VYavYrixjN0EUkVJ8P3CSgV42zooTLTB6VpcGWzNnL/QcB8Jh9imA3VF66mQsvfn8A
         NUNwyWisT/mWs7zGyvs+yIEMrAg2HIdjS5g6TjH7TF1OFKsOURN8TFuGhcSwZUDiqYkZ
         ykI3QX2be96cMOErY7mrP4G82FVS4MESAYhbJ/m2k0yuy6as9kFAGCCE/C3e/tXZSrYZ
         Ovg3lZZ35chRDxBhKAhymuNuxwVJi6FvHls08DU8qwwk2pj31Jpm7VecoVUgFyKw10p5
         g0GJW62lZbMO1Z0X2YzSYUZll77On1j/K5dL6cVtNiupFEPUGuQCho6rS3ntSRh/wnqh
         YCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725529302; x=1726134102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1zkNgUAM/QwmJuwVc3NX3CSZZoP5SUWIgiCl+DR8w6U=;
        b=hJEGrIeqnq8kmPeUvj67JLe82GWH+CCN/ZDJGEb8OHnQnpaezPUz/ua9OTYq5uTQ6x
         bK1syEPRALY1/iNMdnLyJuvdwWqzPmOHJoAAnpOnPJXmNY/QdtSdP8oKiyAJPy7cXvsR
         BCB6PyxS5hwuIMPwBs8askY1oCuNcAQ3x70lRG09yQZf9+q6ly0bXY49OxrRfKPKDmSv
         mYhJGmikjv7tLiqBlyq8WHDMYtqPtvcHo1KmTrPib8iP4lJTC4xaZkBdWr5UJAlT8c/1
         4PsKmnXkWsw+Z9c0Y8+QOD54PCPGbGpa3CUK9XgC18iOJdvyfq/fkXWdhMW/bDW9y5ua
         8eaQ==
X-Forwarded-Encrypted: i=1; AJvYcCVL/VStuv7hCugmJ/4/tQTQwuGyTwx17auS9fVJ+KJngCibOcifMEShYe52djCpyYX9hNBOMWm1JDkUau8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkQNXxw61CtX46nBbGngEu9CZWj5DT/6DvsA2q/x9rGO75DeB/
	Sj9JsKL4mnTrW4zBxLISY98W/SePIHubnH8Xr/QnrnWK7dXDrgdlP0WxmgL8dR9BcVaXq+Hlll5
	s9E7NiQIEzdH67sINACwjTq8TurTYKtemWzfo
X-Google-Smtp-Source: AGHT+IHJPny+Snwd0y0fa0gKoADQLjpbyUkOKURoPb20rbDcDh68aZg+DCflOGtgw2LNVd0/14snpmMwRHGXhfR7Vww=
X-Received: by 2002:adf:f0ca:0:b0:374:c847:86d with SMTP id
 ffacd0b85a97d-374c8470b7cmr8594180f8f.16.1725529301228; Thu, 05 Sep 2024
 02:41:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-20-ojeda@kernel.org>
 <CAH5fLgjfxSOmnPsk_673qNdnpVoj1W11LD+qgKqBG8J7sm-u3g@mail.gmail.com> <CANiq72m9y6agZyca0dhchr64xJYjuNL3G-NVSKO6=wyU=skJ=g@mail.gmail.com>
In-Reply-To: <CANiq72m9y6agZyca0dhchr64xJYjuNL3G-NVSKO6=wyU=skJ=g@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 5 Sep 2024 11:41:29 +0200
Message-ID: <CAH5fLgg8KSNLrAUsFHTceVA0Zp3gUCP5yjawXN_3SuOR5Y4Gig@mail.gmail.com>
Subject: Re: [PATCH 19/19] rust: std_vendor: simplify `{ .. macro! .. }` with
 inner attributes
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 11:27=E2=80=AFAM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Thu, Sep 5, 2024 at 10:19=E2=80=AFAM Alice Ryhl <aliceryhl@google.com>=
 wrote:
> >
> > Are we ok with changing std_vendor?
>
> Yeah, to some degree, i.e. the code is already adapted slightly (it is
> not intended to be a 1:1 copy). As long as we keep it more or less in
> sync with upstream, it should be fine.
>
> Even if we had to diverge, it should not be a big deal, but it would
> be nice to be able to pick up improvements if any, e.g. there is `let
> else` being used now upstream, which we could replicate (I will create
> a "good first issue" for that).
>
> (These allows/expects are not there in the original anyway, for that reas=
on)
>
> Cheers,
> Miguel

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

