Return-Path: <linux-kernel+bounces-316597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 605DF96D1C4
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 10:18:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 930241C2494B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 08:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA355198824;
	Thu,  5 Sep 2024 08:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iBTuuq+q"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8BA194A44
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 08:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725524084; cv=none; b=kNgIUxevm7+87Yb5o8CC3HXaG6sDVcIEf9J96qzIgPBvWXOn5Tf2vKjVbklS1+H0zosj/76RUTQ00m5iPnIxJJWjJhOMGfEOzkHjqPkVVoTrF8uGUKxahc9Fpr6dgJb1Ipkiw6NQZlSyQSNrqUG/7afWPAlMSpoijcWINxmhjjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725524084; c=relaxed/simple;
	bh=4Z7ZM2Zqsf7stqQxw1qBOI8mLWWVIXA0qh6UQvkxfis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cjwRwD19/Ng2EHPvXiDxmvjH8xoVdINtJVWTC2SSXkP6ZtXGoPoSiuSGgIhw08ElvQzQoP0mZA3unPvnei/XpE28Yg2x+6Psi4817ueZo8IaOUGscf0UeaBLZVCuT/c0S7T3oyF9ysGbTknH6p7TAMJ+PTG4DDCwVLB8qi5FSQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iBTuuq+q; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-428e0d184b4so3190325e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 01:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725524081; x=1726128881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Z7ZM2Zqsf7stqQxw1qBOI8mLWWVIXA0qh6UQvkxfis=;
        b=iBTuuq+q92PnrDUI/KzUkUAaFV6Wuu5BqcmwnebxJY3KG/2qj0tmLXq3nlS086TNvK
         Mdudi+X2qT84jfXsYFks1u+6jBBUTPi/Dik938rRf+RhZgBruhsi1ImsbwzXx5KvlREa
         1KFDiGBDf+95CK5Gvp3S1ibVtYcZV9f72+eZq7YmIq1I2cgwS2QffcwiPYlSiRSWZUhc
         7W37rsCWdFC0VtPuqUcBlh4Ag9bhXb/M4KR3N6jW3O1kC+TfPMoqzCwSKF/+0Oq07BqR
         c/4Qkiu6XHBPjy7cIhJYhsS60B1mdElufMC8gP87719iyfgAFkTpRz5yPicRJCfmtvyK
         xWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725524081; x=1726128881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Z7ZM2Zqsf7stqQxw1qBOI8mLWWVIXA0qh6UQvkxfis=;
        b=hAEOXymJiqlqmxQwO5L5RneLXArpr1aqodeebkM6kmQOZjlmBjicQlmLJq6p8iiw8o
         AguWiCzpuiXjSM+0e6KlateGcGfA3jjStf4NF0DJvegtTVYmmJie9B+XxvMr0tvVXqse
         x8WxZdvZwGn06Zzs+ejjJWKl+dtMSi+oLdvfa33PjEjcg3NMUDuDizUjyH1xA9cbTbT1
         hjhX9ISJTxvIfp4mssZ87N1xc7uFltzWXqjvASlaQAnEbgoKsuXVXHRQPdLi9kM9oWZK
         02jdRdD5z1q4NRfFiwImEC/IKSF+EphoGC1gPcU1yiJbDzICzQPbKUWKNajMTcAugjC6
         CMCg==
X-Forwarded-Encrypted: i=1; AJvYcCUzTiAIqlw5dy0yDjbmcP30VpjfrbEgRFop49MTJJJVfqKxpIwMLa9NlKP4o9TZEj5MRp7S0a66+htfsjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKJ3B3EvsM+PrSwAuzq+5A3XX2QwHv0hGmV8YqIzvsT4UUITE1
	qOD9Yxp1QrLW1bnGR7GtXF9NNJkYGWIFELqQ2Aem7mm+PqU271iWyxwGWo/lodsClRNm/YbVekC
	slpZ2dsz2oytnADuf6dPr3iqcplQbMSXCAgFE
X-Google-Smtp-Source: AGHT+IFoFMEFG++KUV5iQ/Tyfkl/lsDMQem/o0J6AzcE+fLX1huKPxyQpwstvU5CcpYtGKJwWga2u5zlwmR9qabq4Js=
X-Received: by 2002:a05:600c:1c09:b0:423:791:f446 with SMTP id
 5b1f17b1804b1-42c7b59e335mr112875365e9.7.1725524080520; Thu, 05 Sep 2024
 01:14:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-16-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-16-ojeda@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 5 Sep 2024 10:14:28 +0200
Message-ID: <CAH5fLgjnX1hF6OSJco5xce1Gmd0brSLKDbmotCPUmOXa4UChEQ@mail.gmail.com>
Subject: Re: [PATCH 15/19] rust: enable Clippy's `check-private-items`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:45=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> In Rust 1.76.0, Clippy added the `check-private-items` lint configuration
> option. When turned on (the default is off), it makes several lints
> check private items as well.
>
> In our case, it affects two lints we have enabled [1]:
> `missing_safety_doc` and `unnecessary_safety_doc`.
>
> It also seems to affect the new `too_long_first_doc_paragraph` lint [2],
> even though the documentation does not mention it.
>
> Thus allow the few instances remaining we currently hit and enable
> the lint.
>
> Link: https://doc.rust-lang.org/nightly/clippy/lint_configuration.html#ch=
eck-private-items [1]
> Link: https://rust-lang.github.io/rust-clippy/master/index.html#/too_long=
_first_doc_paragraph [2]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

