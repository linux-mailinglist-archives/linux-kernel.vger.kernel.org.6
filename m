Return-Path: <linux-kernel+bounces-342786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C99989306
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 06:35:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCADC1F22E87
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Sep 2024 04:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D39F22611;
	Sun, 29 Sep 2024 04:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="VI2NIJnM"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7981DDD1
	for <linux-kernel@vger.kernel.org>; Sun, 29 Sep 2024 04:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727584527; cv=none; b=I/7I0o9eGrMInhgIysuLxy++umGUQGijq3KyyXv6hugbNeI/ugldg9CNrlpyZLWqLDT8QQiuHvdf8kOaODdnzHiqb3sULI2HejIXmwyo5ZZ9vCmEZzPkdv5TGLjWwIqoiOX65d+k1Jy+gciIq5FVZTRk0NgQchNkYmzAtgmD+1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727584527; c=relaxed/simple;
	bh=iq8nYlJnTvsBXaVdMJD5ZEW9MPx3F7bxAs2/3KJBB/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uGEjlB1ZO8LW9mVoJ0uBXOpZxNT865qX4jiAVs2cpDL+T637noyKFkIDjz9km7C5j0HnZKBakskG2H0at4fvLSjJR+dQXabsw/PSdPf2pshLzZcIpiPyZcX5Bz4zYhA8RLKOl+TaQ6g2FA04vZCEKKFAubUF48rkWmCsGlEk0Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu; spf=pass smtp.mailfrom=umich.edu; dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b=VI2NIJnM; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=umich.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=umich.edu
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e25d57072dcso2526912276.0
        for <linux-kernel@vger.kernel.org>; Sat, 28 Sep 2024 21:35:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1727584525; x=1728189325; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iq8nYlJnTvsBXaVdMJD5ZEW9MPx3F7bxAs2/3KJBB/o=;
        b=VI2NIJnM6ZcaAnoh5hAEAIdS0eqB+9XJg9futIWBBWUTBI1aSjD+DIo3Boei9vGK1B
         lS98gm7Ni4+xFqIqzssnXZQHwllcyHjKH2FxkxmkA4xSy6LFz2a9YfXXXqhynL55fasZ
         kjz5yKqIt+t/S94AnhqFoMOilX9HXGrQShnAq2yvlcxFNr0h+d4hrCKUJGv25DxZBTEA
         WWqZSMIOGY06ibmzA4/HdWh/kwiKyTpNIyuh4hW7nEibDSwlwgsSMpGxtDwrsJjANRRq
         TtZXdFPydUocAr1KX6RlhUZTXAGAu1Dwx3gHiVmy3UB4xluyz1MEc2CChSfIZJDDyuH1
         vCVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727584525; x=1728189325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iq8nYlJnTvsBXaVdMJD5ZEW9MPx3F7bxAs2/3KJBB/o=;
        b=n2aJ08mekvRab2FI3eRuMEsNDfsi3hkILx0Jh9XSYJXy7KVOAzBCQEEX0Sbu1swhpZ
         ycOEOelOjXBHCpadstk+Z8fK4ifbRoMlceJNw2NMlbdXMy89YOSnAuiQ9hDqSEUtfJnW
         IzvFf9cacAKZeMzeRqq3xs7RUwXgQBpoH3Dl6Ne1DIkFYEK/zQ9+bRmqZDZbYSZzU5WP
         Em3jAkGkaPVeDA4lUM/O9DbPJMS3lMCRzL7KYymfThyoOY7a4s6LweDB/F/N9Cz+7hJB
         p3NQQZq3YYOZU0pj1Z5EglhF+QGZU0hMR2H/bKlmoYc8mxjMLNAyiA0/U9Fmeg4jMljR
         iv6g==
X-Forwarded-Encrypted: i=1; AJvYcCUrkjO29T02siHfrLbEWVHNYtMn9ZvBtANT7T5SmGUQIMfJOgund7k211NKkQbaDsXZGj3oPCJKwd48vu4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrPsS97dN0PKIj6O0TQnkdKIAvbxQScOZvB5oIDFMASgKZNF3o
	+jcfHL/GwiUbRkY3aKbNmL/PYidWfT/S4EKTR7R3Sdf26P7FQ8iljicV3raTtuRXOY9Uyh4lAaY
	GYsZTbdjOalAVNKtGnWi3W1YG6RmtazBdqGmRmA==
X-Google-Smtp-Source: AGHT+IFTy978tTVEtvPzHwUu9f9ON7IF/qpS/26+6FLmZ3cp8HWcWTa+ibDUFZepM7iaF+ljOiiv7aClfsJOk7PuJM4=
X-Received: by 2002:a05:690c:4285:b0:6ac:ce34:9726 with SMTP id
 00721157ae682-6e247584d12mr50393967b3.18.1727584524823; Sat, 28 Sep 2024
 21:35:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240904204347.168520-1-ojeda@kernel.org> <20240904204347.168520-6-ojeda@kernel.org>
In-Reply-To: <20240904204347.168520-6-ojeda@kernel.org>
From: Trevor Gross <tmgross@umich.edu>
Date: Sun, 29 Sep 2024 00:35:14 -0400
Message-ID: <CALNs47s9t=bFbcLOuwkMZ8XV1S_hF1igdfLKG4RLCwAsivG+ag@mail.gmail.com>
Subject: Re: [PATCH 05/19] rust: enable `clippy::unnecessary_safety_comment` lint
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
> In Rust 1.67.0, Clippy added the `unnecessary_safety_comment` lint [1],
> which is the "inverse" of `undocumented_unsafe_blocks`: it finds places
> where safe code has a `// SAFETY` comment attached.
>
> The lint currently finds 3 places where we had such mistakes, thus it
> seems already quite useful.
>
> Thus clean those and enable it.
>
> Link: https://rust-lang.github.io/rust-clippy/master/index.html#/unnecess=
ary_safety_comment [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Trevor Gross <tmgross@umich.edu>

