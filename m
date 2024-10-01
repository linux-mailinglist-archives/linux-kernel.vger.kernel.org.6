Return-Path: <linux-kernel+bounces-345603-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B610F98B7FB
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 11:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77F412819D4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9EE217BB08;
	Tue,  1 Oct 2024 09:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e1I8E0ve"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F85219CCFC
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 09:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727773823; cv=none; b=bxdSuEy/C+ihjyg0dczy7w2M/HzjRMXsAOa3n0xou9FdCsdDnso9x6tYxLm41O3LJBgUTV8TC2QDxmpFeWUtTS4w4qGZ7S2z+ePS64XcszMlg/ItxQ3hpvxXCcDvdHeKegJIy1EoIJ507ZVng7GcYSmsgbbjVPonP458iASJWlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727773823; c=relaxed/simple;
	bh=ry+5U1RRK9ZAgBMN29kvnIGojbUaEu/LwU9sId/aW0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PXzg31tnMaSnna8PWNWNiDbPiOPRd9X3W8rPJIVSpTRbRS6UaO/AN9j5XIuc66Vi/WKnnf20IfAe6CiOof/lvpH0t5fRF5/sUxjBxos+wmqRShgqqohz1aFohJ+7x1RVVC8i2VrxATM1X243/MYMYMmRmBKKl50YGbgnf8ecrFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e1I8E0ve; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5398ec2f3c3so2921007e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 02:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727773820; x=1728378620; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OrX/qUUa70MFKBirdQOuFfMXBU3W0Qk+D1y9VaWgpaY=;
        b=e1I8E0ve3iByP6gzyvKui/E8D4sHhIhunjMio7H1QADUmKPX+fXtgPpqnSoEIKcCcF
         QGgYYaRf4Ozbiko8RogUVwq1aFRTh24rgQGToyUahvpzZfoz5+L789SqDRPFqLAbWjIW
         CAZKVgXX05gOtoE/tbz9YFGCrltMVt6aIpETYFzB8w2ayUVXIZboypD8Q1Ti3NaJylkN
         hp7xM8QzQgQv7el+vhoXg9A9Wq/klnS5YYsvl9yNj9baUzTRitTCk4jKa5/2UtpCT9DK
         7HZtAF1rcQDUDRgBVrblFzIg/5jUv1gsSPBhE650V44dPRXTlmdnIvXg05F8SgMTVg6O
         D/nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727773820; x=1728378620;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OrX/qUUa70MFKBirdQOuFfMXBU3W0Qk+D1y9VaWgpaY=;
        b=w7POelMdI01RQb5ZAcrYuTlMXaEPMBHWo7CXYEVBpo+ZQQq+LfZCidEIVgqQOyUBSb
         0NTfh4S493viFWn8qTDvFgJpfN1V7UaON0hQRS8cewnU0e5fqdJ/LVU7reqWd2IbORCO
         EuZpWrCSDDM95Zx15Q9Xykel+xHLfRZ8hp6azp9dfJo4c9yhjUe2bezRezOxWZaxAfZO
         TWs7d9tYI6my0zRk+lwT8o9zhatsL0JYE22RqkVS0cuQV+P75Sc299oIcqUs+db0mFkf
         4o1Hy/bSBvxq2oqcjxCtgfmM6Be5V6GrsxPuMRWeEny7dM2scMUEVIkpnc9tpP47UnuZ
         Rngg==
X-Forwarded-Encrypted: i=1; AJvYcCUuDKKzxl5EdRqDqZWEV3UMRHLOoBw6mbUPfc4hoYwxZIhvX0g+tGWZoHC6zL5k1I+98goKoFViUHguCWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YytojQMJ9LkU8I/fwHCQDohIN/ygWKseuz1xrl1C1+xfbIy6H3S
	Btg3ZRhy1UM5ApFa9Gmwg6itN4g6uSSRee3i9hUUy16FftQ23HU9kr6W9IvMLWw/CCvPsOpuqDo
	3RG7WjF/j6/srgqFRlanGuEEiyOOW7P8+tQYs
X-Google-Smtp-Source: AGHT+IHTa2kwcQ/VO9sC68bYbDFLwKywCSe4njSHSFh3O0OooD8vlIO0akxflLW7b/VNqaFTMHZtReBh/t1A1b5qDbk=
X-Received: by 2002:a05:6512:a96:b0:539:8d2c:c01c with SMTP id
 2adb3069b0e04-5398d2cc065mr5250996e87.41.1727773819424; Tue, 01 Oct 2024
 02:10:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001-seqfile-v1-1-dfcd0fc21e96@google.com>
In-Reply-To: <20241001-seqfile-v1-1-dfcd0fc21e96@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Tue, 1 Oct 2024 11:10:07 +0200
Message-ID: <CAH5fLggH_uThjbdNW6pwOTT72ogLbyZGXDAnTLoJyvmfZ8kf_A@mail.gmail.com>
Subject: Re: [PATCH] rust: add seqfile abstraction
To: Christian Brauner <brauner@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Miguel Ojeda <ojeda@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 11:07=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> This adds a simple seq file abstraction that lets you print to a seq
> file using ordinary Rust printing syntax.
>
> An example user from Rust Binder:
>
>     pub(crate) fn full_debug_print(
>         &self,
>         m: &SeqFile,
>         owner_inner: &mut ProcessInner,
>     ) -> Result<()> {
>         let prio =3D self.node_prio();
>         let inner =3D self.inner.access_mut(owner_inner);
>         seq_print!(
>             m,
>             "  node {}: u{:016x} c{:016x} pri {}:{} hs {} hw {} cs {} cw =
{}",
>             self.debug_id,
>             self.ptr,
>             self.cookie,
>             prio.sched_policy,
>             prio.prio,
>             inner.strong.has_count,
>             inner.weak.has_count,
>             inner.strong.count,
>             inner.weak.count,
>         );
>         if !inner.refs.is_empty() {
>             seq_print!(m, " proc");
>             for node_ref in &inner.refs {
>                 seq_print!(m, " {}", node_ref.process.task.pid());
>             }
>         }
>         seq_print!(m, "\n");
>         for t in &inner.oneway_todo {
>             t.debug_print_inner(m, "    pending async transaction ");
>         }
>         Ok(())
>     }
>
> The `SeqFile` type is marked not thread safe so that `call_printf` can
> be a `&self` method. The alternative is to use `self: Pin<&mut Self>`
> which is inconvenient, or to have `SeqFile` wrap a pointer instead of
> wrapping the C struct directly.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

It's supposed to say this below the --- line:

This series is based on top of vfs.rust.file for the NotThreadSafe type.

I have no idea why b4 decided to drop this information ...

Alice

