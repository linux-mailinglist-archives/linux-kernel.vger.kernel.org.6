Return-Path: <linux-kernel+bounces-237763-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D992A923DD9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 14:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CBD01F264C5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 12:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FF517084B;
	Tue,  2 Jul 2024 12:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ekXuqG89"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8849616F85E
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 12:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719923281; cv=none; b=pOOF5NOxg15E1JGiylEVcPnoaRUEiWXJ9qEYXZEsdCnp+Ij5f8qmu+cFVtkaDJPmR8iQ3F1/3nfXtMHEctSWLCVEDKPauIjQtMR67F/BPQMGMX+26S5TOzjEhs6ffr+N16ssk2iV3ORolQi5ywLaBP45DCDqJsT23t498tLkKxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719923281; c=relaxed/simple;
	bh=1v5lOVUChevQP+N2QZWisjCxH7AUTxAWh+Bnio2PItY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cD7bo20eeyhcXh2Zgmkym5lY/8K8Re5s22y1+HRHTfWDIeJuj5pf0XJYfilwFy7AN8K6VohwG/3cjesFLAtMjBShnygZEJs7eeoQSIpq9uc1CCi7nWDHG1APkbNlCIY25HTSaMAiGqp8ug8rg2P91GcjQZUS4ERGFv5fjFb37pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ekXuqG89; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4256f102e89so27746035e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jul 2024 05:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719923278; x=1720528078; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1v5lOVUChevQP+N2QZWisjCxH7AUTxAWh+Bnio2PItY=;
        b=ekXuqG89b+fAiKRdV2IZfgBSYgw6jaFMBIrwG9dNcFcUGTDP6190ViYvCaVZboT5Zz
         UbNYGPaqW1sGl7S3IvE05/gS163fH0wMRW6tYKalYy+EvosHdO2Y3mUVI37W2qrfPYMT
         fikBocX3TFRqpD6Dx6TN2mLDJqgfBOez8JB4pkqFQCDGHIlAo92V3W/26on3v7rjgOnT
         KWD4AeFthVeREjD2f1fLMTupJMyDzQvYm5WObZ+vVZnUMwNlFSmiO/DMovxstD1Uc2Jf
         BJtd4tk17hU0LreLSVLl19SGNP67KIeYAoAtpx1udQ/EkZuonWHsBFGreFusev9h1bi2
         aO3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719923278; x=1720528078;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1v5lOVUChevQP+N2QZWisjCxH7AUTxAWh+Bnio2PItY=;
        b=kAXKzJu+yvY4FaIrNCkt/KQHPDIWwqHehLT6vU/h3gau6chfw9vzfczYoSCVEd8k6H
         0jkpVAlXaAT+/r+xLhSvHSDe0N7gype97WxsUJczKnhiGkNNrQpP/es7ClV4XErOoq8P
         3ZWdTjLwJUrRGmPVB/2MXaOvwHamFimNId021qrr3km6T4Zh08RrF/VUH+JwHxOaiEzj
         KPEO6/W4tslFD0Vysz9esSSbXhJRCUuY4vDG0BLceUcPkVRgCBI3nApDD07XDZB4MsL6
         4wLXjmKaVErWND8y0D+xFcQXbZ023SeRRz99h9mrZMXW9+/fPoJopa9WJaaqdPpY3B1I
         WLUA==
X-Forwarded-Encrypted: i=1; AJvYcCUpvQFf04TGANhJsfjDbJOgen7xpoI4xu5yIAwRswpSF8GT4SC0KOrdNvoAYzovoYOmeCUAdz1S3yYyDzVj+z1vp08aTFGqcn2YmLEI
X-Gm-Message-State: AOJu0YwNE39H/up2MH0OXkQt0WkbLJzUdDPh7VpS266Bjd3KCkvzc2Vc
	DNLCpErsMbYCfXniooT+ZBtJOTbep9eHa5Aan9mnNRuWOsMeRXKVBjsbDffjwMKxNYf477gIMoT
	fY+Giehvf3EzI/xqF4Vewk9S4Hx9oKkC7wfTi
X-Google-Smtp-Source: AGHT+IF4qZD52kZRJjBUJxyc2yqwkhHDch0UUTYE9b5JxPadLBBqquNx7emNw9zg4DSnlg0OkbPdmI7A1w5xcyHHBrU=
X-Received: by 2002:a05:6000:1045:b0:367:13a:5276 with SMTP id
 ffacd0b85a97d-367756ad617mr5683027f8f.20.1719923277752; Tue, 02 Jul 2024
 05:27:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240701183625.665574-1-ojeda@kernel.org> <20240701183625.665574-3-ojeda@kernel.org>
 <ap7u5hpgfdzYgTkobIleYc0uolBIsAVbq56CwMJG6k4x57wXeEtu4fpLpgSOvQtbJHvB6D0J1wlBaqDV-xt2owlVejhfABUv_ivILyJ2J9o=@protonmail.com>
 <CANiq72kMaPm2OsGb3o0VUtdoMhSUoo8QEsCFzVjYFtCThvNJ1w@mail.gmail.com>
In-Reply-To: <CANiq72kMaPm2OsGb3o0VUtdoMhSUoo8QEsCFzVjYFtCThvNJ1w@mail.gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 2 Jul 2024 14:27:45 +0200
Message-ID: <CAH5fLgiApXtur45Uz+o+xOTX4qqFAf6LnB+Csz2-0CGmJue40g@mail.gmail.com>
Subject: Re: [PATCH 02/13] rust: init: simplify from `map_err` to `inspect_err`
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Andreas Hindborg <a.hindborg@samsung.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 11:58=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> On Mon, Jul 1, 2024 at 10:05=E2=80=AFPM Bj=C3=B6rn Roy Baron
> <bjorn3_gh@protonmail.com> wrote:
> >
> > The formatting here is a bit weird. I would have expected the ) ending =
the inspect_err call to be placed on a new line given that the unsafe block=
 isn't placed on the same line as the start of the inspect_err call either.=
 This seems to be a case where rustfmt mostly gives up on formatting. If I =
deindent the comment and unsafe block rustfmt will keep it that way and if =
I add a trailing space to the inspect_err line it will keep it and emit an =
error that it left behind trailing whitespace. Maybe add a block around the=
 comment and unsafe block to make rustfmt work again?
>
> Benno: any preference here? Or even open coding it.

I would open code it with an `if res.is_err() { drop }`. Using inspect
for a side effect other than printing seems weird to me.

Alice

