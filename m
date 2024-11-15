Return-Path: <linux-kernel+bounces-410776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDC59CE0D7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 15:01:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12898286D45
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Nov 2024 14:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DF11D45FC;
	Fri, 15 Nov 2024 14:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YZwXXHdU"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E5D1CEE84
	for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 14:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731679261; cv=none; b=g5bawFi4aY5RnGdqhoXB1PIMkumjAjFSuoIN2qXrFPU/0CMManFTpsCclm5NNupnMP2ggIRHGB7l6hfMCBUDEQ8RQkZvu/niQcEAUoWtYf/hKuWJWibf3CzE3JTnNjGFOWmu6HNqcwrWPoEDulF8uI+tQaG+HAcQgvgJk5/R6Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731679261; c=relaxed/simple;
	bh=VfVHZrGd4tsTjMi2xv8h9FRmG7Ah4ZiFj6Wn70prO8I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WmYPUzeDlqd+XHLh9C1zCOIRYyyFGN0oEZ+V5aHcZOwLy/cyUzD5gogTHUaTSrl5YjfNRupY8us5SIBPsX37MJUhxaXOO+PKPYTzQwZtx9HJR97nJFqM+6x7hlN+rDG3vnnlQ+NdA78L+zHByVqoi8Er+NOFs+A+7u1FbyzGiQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YZwXXHdU; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-432d9b8558aso11535465e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Nov 2024 06:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731679258; x=1732284058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfVHZrGd4tsTjMi2xv8h9FRmG7Ah4ZiFj6Wn70prO8I=;
        b=YZwXXHdUBDYsijL/FblRRNt0rQLifvWexFEKtb5m+BVYyAy+gtG9c1rw6J1hsXnsmg
         KCAdCMS+yuX1/Igm7FT9+s05Z5roKqIO0zPD/ZzNZNhTC0iw//NOINmEpcd39lLDI3Qg
         gS0a0Os/rlKHZTmnHSjvcuGPvDOqTXhxRSBAyLef9biaKBSaz49C1OzdTa4SnlT5krW4
         5Dq3umj5qVIgOND44Wjkm+wZ9lFzFSp2HnUZPcFnFQF6MC5gdH4RTnSgEvKeY+HV8kcj
         8kFciltEWiuY5N2fVsZ1j7FSegiGT36h3/hxLmAUbQjGZkZ3/MBKjJVXnJWcZL01Zt+V
         BjVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731679258; x=1732284058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfVHZrGd4tsTjMi2xv8h9FRmG7Ah4ZiFj6Wn70prO8I=;
        b=Omy5plZeeWj+SsMdR127YfcI5u9dCo0Db1NI5jXs8UKezE80qoggVBvOFbsHmlDR/4
         ZxDLLbSVVW0vS/pg8MfvRapkLx7mw4I46btU97TvKlGhFQpEu++ScDNVuwwcR3Ctg6kv
         w23WcePcMk6nybTDKmm7aOcC3Pf0VV7I8MGZnPSFgqC2CBExXg86OEr3+DcwFvIY6MJj
         BXLei6KlA9iI+iUh/bPFz66gxvfk7U0wsnF3NV5wgs7+35cR0JsHhImijq5te4Db4HAj
         66TVlpJUjEQgxkvqw6sh5GxSjDC3NReg4zFttmBDL1sgLZyMqKa/eLoZxONJ3u/1fTFe
         nL8A==
X-Forwarded-Encrypted: i=1; AJvYcCWshpHSWxOwgI6asoNlMgt88sfjqc6ggx8Lbj9dZn7gJWqBa4lJ6ml6XW272AQ0PRiSDBUl22O4T/ckQ28=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5d8trn4nkLprgz9+/EiOGUxihOfdDXChe1FTQwthcGH0BLxv2
	gamHlJg+VD3RdodW0STBedFa0sZ8Z84ZVq+gyYenWEozhVsp3NfJnpygeaZ6UueHsDgGAQqexEq
	/DuX3JnIhLLNX+INByAeqMyGW1Df5BN0l9JDV
X-Google-Smtp-Source: AGHT+IFk8/GvWJwG6tNDd12MbN9MckIetCAQntsvm7RXN/fJBQRSRREZVjA31lahN/uOpJgQiKXbK33daKacZwaEsSw=
X-Received: by 2002:a5d:5982:0:b0:37d:460d:2d07 with SMTP id
 ffacd0b85a97d-38213ffe4c1mr6588655f8f.10.1731679255711; Fri, 15 Nov 2024
 06:00:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241004154149.93856-1-dakr@kernel.org> <3b843e34-48f3-41ca-bd83-9bc137ca6c76@asahilina.net>
In-Reply-To: <3b843e34-48f3-41ca-bd83-9bc137ca6c76@asahilina.net>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 15 Nov 2024 15:00:43 +0100
Message-ID: <CAH5fLgg68b-pfGhDubJMzGA8w4dywviMv+ghw0KV1emFvNKe9Q@mail.gmail.com>
Subject: Re: [PATCH v9 00/29] Generic `Allocator` support for Rust
To: Asahi Lina <lina@asahilina.net>
Cc: Danilo Krummrich <dakr@kernel.org>, ojeda@kernel.org, alex.gaynor@gmail.com, 
	wedsonaf@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, 
	bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@samsung.com, 
	akpm@linux-foundation.org, daniel.almeida@collabora.com, 
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com, 
	mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, 
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org, asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 15, 2024 at 12:33=E2=80=AFPM Asahi Lina <lina@asahilina.net> wr=
ote:
>
> We (Asahi Linux) noticed that this doesn't support unsized types, which
> is a regression from the alloc Box. drm/asahi uses boxed trait objects
> to generalize across certain object types like render commands, so this
> breaks the driver.
>
> Is there a plan to add this back in? AIUI this would need the
> coerce_unsized unstable feature, but is there any other blocker?

We're already using coerce_unsized for Arc, so I see no reason we
can't just add that for KBox too. Soon, we should be able to use the
derive macro [1] I proposed to do this without unstable language
features. The limitation that the RFC mentions for custom allocators
does not apply to KBox because it uses PhantomData<A> instead of A for
the allocator field.

Alice

[1]: https://rust-lang.github.io/rfcs/3621-derive-smart-pointer.html

