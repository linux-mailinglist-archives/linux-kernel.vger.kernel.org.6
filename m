Return-Path: <linux-kernel+bounces-342787-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31847989307
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 06:36:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2A6B286015
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 04:36:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9D222611;
	Sun, 29 Sep 2024 04:36:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="obY9WmMG"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972B720326
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 04:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727584560; cv=none; b=dJCVKUzeS85DiaHdafIs7fiF5esj5O3s9OFNUDl7Xp1BB0/X9LEOTdbDK0fIalbjooCWhGetr4awsyLH/3Xn6mpeMtVlaKoAxCNawrH50lc44BF88rVP5JyZr61CGUeiVyyfoARRuRDf8ISi2/Aefpom9zR68ovwB3kCIH78NrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727584560; c=relaxed/simple;
	bh=Cw52eLb8pxcuWBn5qW3XHz+bqeyKJurQoZGsckqC9ZM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sqDIgHFVuhG3xw/ROn4ScwX/4cgNoCD44RPMfQYPdsbnXj3+AcCGmRqNp90P0pywG2JuYGlbQRP0Ms0+idiGNfxV9Z2SLMX+YLUHamFV4DIALDVZ15kqz9YSHb0Mxy4yrPfxKs/lx+S9Tdix/vjlRE5E02gs879ojUXRQVVCYTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=obY9WmMG; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6db4b602e38so27256797b3.1
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 21:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1727584556; x=1728189356; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cw52eLb8pxcuWBn5qW3XHz+bqeyKJurQoZGsckqC9ZM=;
        b=obY9WmMGht7rgj555kYktVXiN1r+Bq2SNjGqL0xZhR2fVwNpQdwBYIiwqAv+ut8D1c
         O9xtMpNgoAOJh5s7UAewoOEzReyjM5JSqoBQBigyb1ZOvHBIY9lt4I9TPYRfgBvGKw2t
         k1PmY7MBbmz6PoqPbSp/sKoGZbumUgeUHCxzefZiOLuYucRrCTFyETAmZ1HacsSZA845
         wi6PDvjzHR6vvvc+PMtpQQi7l6NOn9McIpInq20MBxKYO98EFcTQ6joj/sm8F/Er0ayQ
         Mkhl159Nsl9YIsnC/xwmMic4+xO0hiyMPtl/xKwCYHvPsq8hp8C3AAjGgsgzEjmMG/r+
         KH2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727584556; x=1728189356;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cw52eLb8pxcuWBn5qW3XHz+bqeyKJurQoZGsckqC9ZM=;
        b=n1CGPeINarN0u6W1pYI8IGQ8Ti8e7gJMGqfgYvBXakIshCrxk/CXZaWazFKyJMA+6K
         iXQecBgjSXvNsmH9DEiTIjz8Bc9QRqPLzpSLuXAZTjMuugt98vFhYIKpxCz015Io9I6N
         cWuK2btEWBN7Sbcc1pPzwq9LhJ9inUC+oWVkefxc7qbpCxq19kXU1llnz0jgdF2MfzId
         Y3U4ZMkV1zOgBqf/l+05u86Ddt7JtdP7NwgVPvyx1KINeGcEszKf8mohYjAeMFaGVLtG
         0e5MgEMionsivpKXFM3NPClkajhx1tu+9ueGK3cpe/4FeUyMOf+gQwKxrjtgrZoP3oo/
         QICg==
X-Forwarded-Encrypted: i=1; AJvYcCVCPnnCV5X9yMi8lxz0q8Gg/RSacC5tuLjmr3bv7di8OPc7knpQVkYpetpdQ4bEMYPZQlzT86DowzumGF4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfV5Pc7+BUQ2JmmROQxbKjc2PWg4kl9bPlzZpKr5WqeIMZUxJo
	9ZoCHvI6HKzjGJJIOmGgMeuzEEf77jR4Q+eYuCghER7ujmNgLubJIsk7f+Evv3kE0SUH+ygw/w9
	33Xwn8QeN8UQDXRHBhLTfB8OxIWYmAr55WCj/PA==
X-Google-Smtp-Source: AGHT+IH3BpjQXLR+cTBvGGV0ZUgSzcTqoLWPzJwNjTW4/pMBS8HN6jUU4/gi/Li9YPYG6vdNFq7a8pH2JdBOD1J0HTg=
X-Received: by 2002:a05:690c:490d:b0:6e2:7dd:af61 with SMTP id
 00721157ae682-6e24754df9emr60630647b3.17.1727584556602; Sat, 28 Sep 2024
 21:35:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-7-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-7-ojeda@kernel.org>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 29 Sep 2024 00:35:45 -0400
Message-ID: <CALNs47vuWxauvfTwfgGNdmDGFP8=ZUQvmtTw2SmFGi79ZW6CKA@mail.gmail.com>
Subject: Re: [PATCH 06/19] rust: enable `clippy::unnecessary_safety_doc` lint
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 4:45=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wrot=
e:
>
> In Rust 1.67.0, Clippy added the `unnecessary_safety_doc` lint [1],
> which is similar to `unnecessary_safety_comment`, but for `# Safety`
> sections, i.e. safety preconditions in the documentation.
>
> This is something that should not happen with our coding guidelines in
> mind. Thus enable the lint to have it machine-checked.
>
> Link: https://rust-lang.github.io/rust-clippy/master/index.html#/unnecess=
ary_safety_doc [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

