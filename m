Return-Path: <linux-kernel+bounces-353019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04CF8992751
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 10:42:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C11FA283E3E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 08:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A08518C037;
	Mon,  7 Oct 2024 08:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3hM/k9lL"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC0016F909
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 08:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290499; cv=none; b=R2caINODraEoWj3sEiQMYrn6Zczv5nWkqTNgwfUBw76PoIgKxBTbCoYzHfv42fb2HtBl7BA7gy/RvJQl8KSzj4gpP/DlavIG0pQ5TjZHXc5wPIjyBw56XaJQxADDmGk/uY8kWbuR5KazTN8o8EQDgU6K7ePZHLlOqzNNKTRfEms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290499; c=relaxed/simple;
	bh=lZq9penah7gAuMo7VonFN6z7LH5CuCz+KTWzrVG0Kkg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rQmO/l5r5Cg7KaFsqkkvRLBec139GH1uoF/18w3bgy39mtLx8LgyFR5oz/c/ALrro9h67eZ2LRGKYrqOXP+UkfeQLjIYRLbCrx96D48Mm0gvPIde/WqFGBBOYUXWjddNAwQFUkqXP1vR4L2nkrKzzm44n6Fm9Fw197fkhzJUyyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3hM/k9lL; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42e7b7bef42so35843085e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 01:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728290496; x=1728895296; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lZq9penah7gAuMo7VonFN6z7LH5CuCz+KTWzrVG0Kkg=;
        b=3hM/k9lLi4Lrhjpkdhvk7bALNKUdSPjDlAyaNHCY+7KAAW1qvf5B0sKPhZVU+qlHzY
         /TgWNSeETECbzwLv/CqLDctjwyjpub6v90FzdFa/8+pHCH8mP46bLsuqelOYdAbBEgUE
         zLVt9wXC/k/80SRkGiOiEGca2M8w4/pmhss9JCkd2RNEPSJjaD3HmzW33yWQ1KISeiBJ
         /y4Kw5KcH/p9MUny7MAzjm8RswvrJrmliOiUF/415+fBDE2qtXSJryXm1uxUsCTqflll
         9kpM+x6THpwe0t7En1MWDG4qGVhpxwRFmrxRoxD8pdj1RNBr9UzYM9dIsRiNGCc1G9oA
         PwRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728290496; x=1728895296;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lZq9penah7gAuMo7VonFN6z7LH5CuCz+KTWzrVG0Kkg=;
        b=l78vEK2hkqjItpQObLRKdvG7gfERVS/8AN/AfN2j4AhzXVnwuNXJ3KOIWoavQZVZm5
         yadIdp91CLwSraF5eDlk6qB8lFWZGAgN7xI2qqS0U58gC5+H9LgKDo3Enr3horaMFoto
         IRLB6dpq1jhr3aNZOSW4/3WG5tOIBkEzzbnhjhsugbF+rFsJVJzt5tU+yXDivzfWy52X
         2cQb8hfH1mspChVvpydh5V6kBBMC9mI+96MQCLSDrUwHPcrEkX/fiK+K1Qa1Rd/eg9l+
         vxf3V9IvgQSQDVc+ONHpmV33/7hImeQFwDt8qsABICiuJBkGyHBF87E9OlzMYv5l6wbh
         0+fg==
X-Forwarded-Encrypted: i=1; AJvYcCUcEvSEj7r4qko3tlOxmQ0phjtHlxv6/WmR6hpknwnRVpY7hSp1xrSiNEIR7ifBTja7I/i/tzDgFaqktu8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1TaUo+amvox2crnkzSOvXyZmMsh+uQDNOEFdHgiF5lY59q/qf
	69DAZhICrHD/B9cufwb7d7WNDA6zSuzYoYE9fiOAJb0j7sB9Xm5k85osvoMpxdu7l7VGCTOITHk
	+vJUdMk0DE+F2oYk/ZIZfy02DNhYP36IrGKi9
X-Google-Smtp-Source: AGHT+IGTRgHCCYQ9wvmh2HAydK1cwGiHD4ib1IG2CJRk6JiPA1BuIRNRo/7C2CaH7YWebj5QH1G8ucz5efiqpGwNw7o=
X-Received: by 2002:a5d:6149:0:b0:37c:cd71:2ba2 with SMTP id
 ffacd0b85a97d-37d0e7bcdf8mr5314481f8f.38.1728290496403; Mon, 07 Oct 2024
 01:41:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005122531.20298-1-fujita.tomonori@gmail.com>
 <20241005122531.20298-2-fujita.tomonori@gmail.com> <3D24A2BA-E6CC-4B82-95EF-DE341C7C665B@kloenk.dev>
 <20241007.143707.787219256158321665.fujita.tomonori@gmail.com>
In-Reply-To: <20241007.143707.787219256158321665.fujita.tomonori@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 7 Oct 2024 10:41:23 +0200
Message-ID: <CAH5fLgirPLNMXnqJBuGhpuoj+s32FAS=e3MGgpoeSbkfxxjjLQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/6] rust: time: Implement PartialEq and
 PartialOrd for Ktime
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: finn@kloenk.dev, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	andrew@lunn.ch, hkallweit1@gmail.com, tmgross@umich.edu, ojeda@kernel.org, 
	alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, anna-maria@linutronix.de, 
	frederic@kernel.org, tglx@linutronix.de, arnd@arndb.de, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 7:37=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:
>
> On Sun, 06 Oct 2024 12:28:59 +0200
> Fiona Behrens <finn@kloenk.dev> wrote:
>
> >> Implement PartialEq and PartialOrd trait for Ktime by using C's
> >> ktime_compare function so two Ktime instances can be compared to
> >> determine whether a timeout is met or not.
> >
> > Why is this only PartialEq/PartialOrd? Could we either document why or =
implement Eq/Ord as well?
>
> Because what we need to do is comparing two Ktime instances so we
> don't need them?

When you implement PartialEq without Eq, you are telling the reader
that this is a weird type such as floats where there exists values
that are not equal to themselves. That's not the case here, so don't
confuse the reader by leaving out `Eq`.

Alice

