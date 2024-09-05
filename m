Return-Path: <linux-kernel+bounces-316724-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DDCE396D320
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 11:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E7751C21D35
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 09:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AF541990B7;
	Thu,  5 Sep 2024 09:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wjaf8SNf"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D73198822;
	Thu,  5 Sep 2024 09:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725528453; cv=none; b=XmIFwkU/VQwnOv2FIfuS7/EIJab06LaBnFl0opdG4Kh90HrYnfvQKfGKTEw7/9bT9knDjHXpyLSebzZsh+TWR8KGoyQY5hXscWLXlYq+kf5fpE/XACqp+B0c/2/wTEovbPSPf5Eq1VWa00SvlxNckN5P6TVIILQMKlVhE5SKKFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725528453; c=relaxed/simple;
	bh=sAZMwktIK3YKRAZVnZju0CX7HpP63pX1nZYVPNJfOVU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1rmIYtV9T4e3j6eciDLOzNNnqIB7mZ47IQgApcYF8VV6L7e18ONu6xVjDqg5S7NtcNIWvcrpNwGk8MC52ZX27+czWh52SdjiwQl9o3sRGk6mOXbqGpxp7SXMfFgpqWZluKuOpEjLvDeLfMq+EeNy8juzc1kpOLcxSiVmYrFwOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wjaf8SNf; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3df23311dccso90342b6e.2;
        Thu, 05 Sep 2024 02:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725528451; x=1726133251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sAZMwktIK3YKRAZVnZju0CX7HpP63pX1nZYVPNJfOVU=;
        b=Wjaf8SNfjQLTZGot6WP9+Y/ZQXtemMRcwQhK2zEnptlxQ7qy0RXkDTCgckpUq2J4SJ
         +DaQyQA2UApooYWmqzuj2mdUUEiTtMF8WMUMyVKSq669sdCgOzs680VkJXupDaUPy3XJ
         QoTGZLeF7DaZgzAy9bUBKmmR7CNqvjzfUvTWv4ygrdbVkAwW+QVz18OcfcryqQkptF85
         DXHY7tEg3XLjzRBnny7ejR+Ut0RZKeHIOQE3PqL0oAyL8NRyFin7eh7+prNhpAY5v7/T
         g8mR+avan3oYD0HkZN0yAonze+685dmlLSwQQlnYAuESARzgXTH9qmB4WK4JKEzPso4k
         wQ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725528451; x=1726133251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAZMwktIK3YKRAZVnZju0CX7HpP63pX1nZYVPNJfOVU=;
        b=XbfcJviSSWLUCPMn0XAder52QBDyuOKRfH8msX7ElOgBjaY1Gf3lFuHkIyCA9Mz5k2
         LUDDVwY3CSMyVJHBwSajg5YaOW2rPVujRf+zALHWPIy3vGVj3nJbjjFxnAU6nkWnTyNv
         LUz8jIx48w76pcdtBMztspOYbtIJPwhXPVemZiEO7kgkxnfziMEUUSZ0gZc44f01hhyT
         kE7trlAT1skb03s6y4vVEw8/Va5nFRug+qF5zu5mETB6e60a6IHNwXI1Gfw85xelaA+d
         AVUr5GMvHcNmP7p502CSYGr5hkPz4FOo2/C7UQBiojQsRQ13CBtL4EiSfQ49zrqfLQkN
         dqwA==
X-Forwarded-Encrypted: i=1; AJvYcCU0jCQ88JziB9Uh7VWyVfVwRU4U1kujpgYTbKwnPr+4QowSL/PrH86BU1WvFsuOUy2uFnAT2C6R6f8mF8w=@vger.kernel.org, AJvYcCV3l6B7FCQ1DYzIngMS/EMp6PbAzzU9HrTKJxls7WSeYb6P30cl2mvs2HP0yhDOCnUGNoFvqyApD3E27o0/PDk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHAs++fognxTGZQC27p4uEoBbHBOurYw63U9X6KLcsbmcaRZIR
	TC6gzvfoMV7LJS/ykCZkYj+U1FfCCdBGkkWN49P57WoSNqjf/VN8+kBUWErbVBW1MwYxpDcxdDT
	ku50U9tCP6ht5eDM3Mt/49DbyJCU=
X-Google-Smtp-Source: AGHT+IEsl6m7kT10HtKDX5CkoIfxB0mk5gmrU2avcA2Pe0aumkMklamu40nsU3C0izBc7uVm8+BhrHiVBvDiidH5JU0=
X-Received: by 2002:a05:6871:8701:b0:277:c0b6:2224 with SMTP id
 586e51a60fabf-277c0b6642fmr7015378fac.2.1725528451020; Thu, 05 Sep 2024
 02:27:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-20-ojeda@kernel.org>
 <CAH5fLgjfxSOmnPsk_673qNdnpVoj1W11LD+qgKqBG8J7sm-u3g@mail.gmail.com>
In-Reply-To: <CAH5fLgjfxSOmnPsk_673qNdnpVoj1W11LD+qgKqBG8J7sm-u3g@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 5 Sep 2024 11:27:18 +0200
Message-ID: <CANiq72m9y6agZyca0dhchr64xJYjuNL3G-NVSKO6=wyU=skJ=g@mail.gmail.com>
Subject: Re: [PATCH 19/19] rust: std_vendor: simplify `{ .. macro! .. }` with
 inner attributes
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 10:19=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> Are we ok with changing std_vendor?

Yeah, to some degree, i.e. the code is already adapted slightly (it is
not intended to be a 1:1 copy). As long as we keep it more or less in
sync with upstream, it should be fine.

Even if we had to diverge, it should not be a big deal, but it would
be nice to be able to pick up improvements if any, e.g. there is `let
else` being used now upstream, which we could replicate (I will create
a "good first issue" for that).

(These allows/expects are not there in the original anyway, for that reason=
)

Cheers,
Miguel

