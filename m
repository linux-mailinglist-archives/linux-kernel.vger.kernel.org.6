Return-Path: <linux-kernel+bounces-292125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C61956B74
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 15:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22FDF1F22DE7
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Aug 2024 13:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18AFC1662E9;
	Mon, 19 Aug 2024 13:04:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEO+s/ee"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CF321E4AB;
	Mon, 19 Aug 2024 13:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724072652; cv=none; b=ZkFCjUTEpqJGq1SsIHXik+hyI/nAHCema5AHizetzn1bNfQkpZlV5sYFyhnuOzeG2ZtFiOQpCdEtONmTf+4bIZG9WEnMlXpg5E81qdaalq+Ya+vfIfzS39U5kIuMWqHHfb7v5lQtq4tQcsn5BKmrWFakBW8bx2zVntS5U+Vfm/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724072652; c=relaxed/simple;
	bh=jyfAn8dUcudlLvulBnmIku0W1Gbivc7wVmOdNkcgG/U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pNJ02X2s2Oiw2ZQixdpmEOA9BDdWg21EJhyBZoy3pd2Rp5puQ8DcSKvkRbTCbBR/RiMNl1nXZRlxOwgMG7VQDSkc8FYy8F2esCEk4fVkzYUjD76f8yf80GlLaw/4ILkJKNKXt0hUfYsvbv/Ws+zbZKLvjT7dLxFO1dghVEYo8EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEO+s/ee; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d3b595c18dso3196775a91.0;
        Mon, 19 Aug 2024 06:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724072650; x=1724677450; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d5tKZxq1FCx8yBXYhSVUiSbzvbO4Et2vnFtJ8mslMwI=;
        b=WEO+s/eeqs6UHinAua1FUF2x32h42gTumUAHd8TUUwSdSjsOdkTwqgtiI3bsI9Nmer
         KeCGAs2t+6nZcF39m7aA/YDeBSj2S6F2YTrz2w0yqgLcizfX1JwHr/GBjn+xLvignSNv
         uYngj9V6TQ620e9lWSJKdCqz+WEAijqVxFgzUvrc61DWyU7EozblebW354HnwKS/mOYI
         4jmW51rdtHmHuQR9uhUXrUaYTlWqiqIsWp/LJcWgZcRnSv2hzeEhZq3lzxYiHpnQfm8+
         xDsRcxUHk07IWysWiD48+ajntRnpJpMMSoTJGxTgeNMtdBXPcN+IkqMCV/NVIqTfx+4J
         raMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724072650; x=1724677450;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d5tKZxq1FCx8yBXYhSVUiSbzvbO4Et2vnFtJ8mslMwI=;
        b=MYbCB+PCXnUU3bp8KQWQ6JvUXlyC2WL7+OfXgifvcnNZAiFoV5hhLDD8Axadq29NDm
         F8qIzql8LtgNYWe6oLD8DAEP0vSuW6NclaXipjKEyI3CFvinKK8pBUn5BD+v5kHuL3iV
         K2vMg7VfGaSyfWna362YUmGWnFotHkQKfchvlqaT++eETnBH2nFrhS0JfvhZoNPo7Tpq
         e5soY8fBkcOGTVwIfEynKFghtdXeHN8L5SUzwuDqepncptcceQDrCuhq6RmdVyNbbh8Q
         lJq5WDZaVOEGuxTpl6n6D+A7ZQbuaRq/shf4vxXNWqnJ/+RIACaov9H6/IXBPNa9fNDY
         1jFw==
X-Forwarded-Encrypted: i=1; AJvYcCUwCxWB9rOEJxck+wctLlnN54+K1iuESLeFouqw1taKTJZ5k33EhGdhGK/AQ83zQqVcegdWIl/ugApu2InpyFyy7k5nxzNcwM8HZ3mK7NtVdGMZSUtkdzdsj4ysoycbzaayGVOA4pMRcdC67P8=
X-Gm-Message-State: AOJu0Ywpo2us+p2ZydYc5GAdFSozKJx++cd4RjgSjW8IHYUL5OK/RwNj
	kruKXt8XU/kB/PllHwPgcXxW0+GoH2lrSMzyRa3xf+HSdz58nEa0TWptBIhM/sqZkjwL37Ol0Qc
	PkGs/IJbK328A1aFkJ6kp4rxmXCM=
X-Google-Smtp-Source: AGHT+IH4FYhpxpfvS2aoZZ+AnOF+NEZ8UNiNNW8OA+pgeymbSSwA5mLhitnXzRrV2/Ta45YDRJ4eDt4tc5nXUOZcLe4=
X-Received: by 2002:a17:90a:d352:b0:2c8:4250:66a1 with SMTP id
 98e67ed59e1d1-2d3c38dde41mr22303342a91.3.1724072650278; Mon, 19 Aug 2024
 06:04:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240817165302.3852499-1-gary@garyguo.net>
In-Reply-To: <20240817165302.3852499-1-gary@garyguo.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 19 Aug 2024 15:03:58 +0200
Message-ID: <CANiq72mGbdKRKuEPbmC7TLOJVXMmpvap8Vinpex-TCtorKaUVw@mail.gmail.com>
Subject: Re: [PATCH v2] kbuild: rust: auto generate rust helper exports
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, Dirk Behme <dirk.behme@de.bosch.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 6:54=E2=80=AFPM Gary Guo <gary@garyguo.net> wrote:
>
> This removes the need for explicit exporting all symbols.
>
> Generate helper exports similar to what's currently done for Rust
> crates. These helpers are exclusively called from within Rust code
> and therefore can be treated similar as other Rust symbols.
>
> Signed-off-by: Gary Guo <gary@garyguo.net>

Applied to `rust-next` -- thanks everyone!

    [ Fixed dependency path, reworded slightly, edited comment a bit and
      rebased on top of the changes made when applying Andreas' patch
      (e.g. no `README.md` anymore, so moved the edits).  - Miguel ]

Cheers,
Miguel

