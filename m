Return-Path: <linux-kernel+bounces-271039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D59989448B5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 11:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F15728203F
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 09:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6678616FF26;
	Thu,  1 Aug 2024 09:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ES70TpgB"
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B442EEB3
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 09:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722505545; cv=none; b=XfjZjHfPfDY+AlzbQ1kxcZ/3EkwdkSSsW9OW8NwkLOkFsonGJRnilEAi2CvEKiUercUmtbmm4FLboOFf9vG1EH4gorLNKtL7dEa5n8m9YIoDMqODfAyDjKrlQ2kFYndKYYovZC1pBUYTB0lHJRaCrHN4D9cPv6qzxVvCyaAGisE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722505545; c=relaxed/simple;
	bh=XpkAxp7okrXGe7fsOgq5G/ZKFTAHqaBYu2PoXBbFtBI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBGQcEwqBeFFv++TvCfUqxixh1OuGia3VcgeEb0DwWgflFJO9SZohYzKPil7ralZTQ/DMJGartDTPMeRy92eVRF4xoyEfbBcExwalc7wUBaUciWrV7WdhpNopVugiD1v4Kn0l2nVmUjLI3664r3i8ZSZj06Rhs4JcH9oSfYSqe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ES70TpgB; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-7a2123e9ad5so1290021a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 02:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722505543; x=1723110343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XpkAxp7okrXGe7fsOgq5G/ZKFTAHqaBYu2PoXBbFtBI=;
        b=ES70TpgBHJ0vBN4M/5quHsvLcX8YyA3M1iVwQa/k7/Yssqm3/YQDf9aKJ443CLxmAV
         5kLzSESxs1fzois491XM+hijbUnUZK7KTjDeXU0sCzz661ezxKgK8CvvV+E/Ye0L7FRU
         q4PQ3oCcdvxyN/C0vHySAcybbd1hOPl2n6SkR4uNIz9Iwp7G8Yk/YvQQG+zJczg0g8jW
         UXMy51yZBI6JOv0auMKGEiLmEdu2wg9QgEXT2dmTBaqxFdScPsSdgmVfqHSvM4eqXTWb
         gmUB8mEWMAne6432EDS4fEV5CaWadtBDT+k3prMBhY9+j11VJKDqwmx6oIcO9R2WTpPA
         blEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722505543; x=1723110343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XpkAxp7okrXGe7fsOgq5G/ZKFTAHqaBYu2PoXBbFtBI=;
        b=BoVbpSRFT8GXxYBxyg/J8OUyNCgxmtANa95vi82maOQZcsp6g6//VoJzDfuS1tKXf/
         0pWmDdFnIh8xW+qzKCm7q1LEHVYm7fY07GWlYjEGodY6qr90/0L29AfHM83mXOBpnByJ
         WMcuGbofcehTi155ATyoiz2QSI9+nPQ+yCnNe1Np0OzixH66m4Lb/9zRoSAmP7fH+YuI
         cSBFFK9+3fbCfY5XeinEqW3kRUPdoAA6FBVlqumvjCbae7BfwFKmhoR3zN6O+VHvcON6
         CshYWn6Uv0JocKtJC5gS9/jPbAgXNRZ82DV+cwtmaMQDgxyjFsXnIQ2JJuFiXwyul81/
         MejA==
X-Forwarded-Encrypted: i=1; AJvYcCVmq7gS/g4wFadscDakjv0dAkEt4c6cd2ARyhJRnc3GUqBvDoV7L+0Bzy/QWT1gM362AwzZHaf/sI4+7qOfwmZMfCrquWw9Mpdzyo16
X-Gm-Message-State: AOJu0YxFW86UfCu1QM0RwSR5FkIgvecpf3GX7Tf1BmujkSFUJDn66Hoc
	wK/UZ3+suO6Dw0UBr++D5oSqDo7w3z7p8O5IK0Fzm4bdjvmUdZMf8tWw/Vf9tQkRapH1UKexsLo
	0dMk0tB5XNpeOH6fYPWv++jJdE9UKpIiSTRt7
X-Google-Smtp-Source: AGHT+IHgNblA39iWI0MtC5wDRwbhiQn7rkgImIvStKgTFOsbnjctz/BVvpws989SGthdiKf/2ftETDgmCV1WPewANGk=
X-Received: by 2002:a17:90a:ba97:b0:2c2:c3f5:33c3 with SMTP id
 98e67ed59e1d1-2cff093a154mr1266464a91.6.1722505542973; Thu, 01 Aug 2024
 02:45:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731134346.10630-1-zehuixu@whu.edu.cn>
In-Reply-To: <20240731134346.10630-1-zehuixu@whu.edu.cn>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Aug 2024 11:45:29 +0200
Message-ID: <CAH5fLghrX91Ad2eYOR-d8i31vkKAWs8tj=noFMZrTSsDumcPyA@mail.gmail.com>
Subject: Re: [PATCH v3] rust: Kbuild: Skip -fmin-function-alignment in bindgen flags
To: Zehui Xu <zehuixu@whu.edu.cn>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 31, 2024 at 3:45=E2=80=AFPM Zehui Xu <zehuixu@whu.edu.cn> wrote=
:
>
> GCC 14 recently added -fmin-function-alignment option and the
> root Makefile uses it to replace -falign-functions when available.
> However, this flag can cause issues when passed to the Rust
> Makefile and affect the bindgen process. Bindgen relies on
> libclang to parse C code, and currently does not support the
> -fmin-function-alignment flag, leading to compilation failures
> when GCC 14 is used.
>
> This patch addresses the issue by adding -fmin-function-alignment
> to the bindgen_skip_c_flags in rust/Makefile. This prevents the
> flag from causing compilation issues.
>
> Link: https://lore.kernel.org/linux-kbuild/20240222133500.16991-1-petr.pa=
vlu@suse.com/
> Signed-off-by: Zehui Xu <zehuixu@whu.edu.cn>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

