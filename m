Return-Path: <linux-kernel+bounces-271444-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A001944E53
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:45:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 676852812A7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F3D41EB4AE;
	Thu,  1 Aug 2024 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VLxd+fo6"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1E9132116
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 14:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722523518; cv=none; b=Xj794g4LIn6o9UVoJkMhPMyQ1bDPRdil96Rhy9FVB0B4aw+f5mGgjMrSfshVvDe+YhZuPvP+QMsoFqql/rATt71YqSIjlgzlep5vYuR8NiNd+FKZky+4Re/evOf/Mgsh8nZw24KXvDuNxhvgsKh7kgbds1r+Uaub0gaENbu3MVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722523518; c=relaxed/simple;
	bh=XOSjN69zw10K3Fscll2PgV5ah6M1BAQQhoIZfIwIR1k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vwd1uOwHIU0xwVCX0vQ0bOqXUbljVnRNipN1aryBqD/0qm/Nljr5MzKvNGTKahUzwf3xmaWGIfpbz/Pj0UGuXUTQrSuglkOmT3Zn7Rb5FmBlOALHSjLpvtpKHLu3vX2YaFMGFKMGja3gk47eew0xWAJS+2U7S4ZQROtquCX4hes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VLxd+fo6; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70eec5f2401so4364747b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 07:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722523516; x=1723128316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOSjN69zw10K3Fscll2PgV5ah6M1BAQQhoIZfIwIR1k=;
        b=VLxd+fo6vjQI+VSzXp6RqWIN8YuiiaM9MS1ZXEVEi/rduHHtzy6UEycVmGLmQTYXVC
         RdlmBixWjRjwq9t6a88A1bN0CAS+faT/bPdyxOBvAXgLkOWc6zrniEj6wcV9d59SpjMk
         AENgHjijLBn23GnFvmqhNukuyYzYlEVQQKX/7Uj3T0XZkuqkB5Pc4utbxlgU40udC8oa
         X2lISmqnFXQxxI4u0UON1uVcJLe47v+yq1vn/4JoWHxrnhDSs55DMRz8AV6+/Hsekcjw
         TJxSfEFY2S19sBiFkbnSlqUi8AbLWpdhg/2AWSMssRbJDBVMxUOkEQ97HUflmfBjQ7rx
         a4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722523516; x=1723128316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOSjN69zw10K3Fscll2PgV5ah6M1BAQQhoIZfIwIR1k=;
        b=W4f2w2Iwriqr1JHkNaYPhqcpWknByOlFbnMmfqTmcDvzR79ZLCzueLadCvqIWLHvUT
         XM9tbiniuS7v2wT6NrjF9iWfqaLNh/BTat3AFbIcbynkqhD56V6fDbhqkRpAfhFBsDSP
         gINU8ulJgBoP+EwkAwhcVsICfq3T0zwHbsKXqE32jhEqwrBOJAaasXhatTupG7JgqyHA
         59epRC1zPynEikgrP7mSHpXNzPbS2IWFRg6kTT7WXeOA+xfj1sMoLFC8A3AYAbDhpMzT
         /JF2O2T7SjlmBt/AWnH6o4QizVrJX7btWyNflI9N8wy5PzpPQlrAn7igH30Od3kUpbVa
         mwSg==
X-Forwarded-Encrypted: i=1; AJvYcCVAMnidgv9f5kDorsanuFe0BvA3dAg8vhUTPaMMsYv631JYIAmQPvCgSNUjM8Jlw1ANQ12/o5+sdbEgg/icn1sYoPc+Dd4R7zyNf9K0
X-Gm-Message-State: AOJu0YztazUmDTDergHoLEDarLI3iGpIz73l8CblyrecO5CMeaywXZaR
	n5s1izoaio9hX2wQZKByFfnNtb2sgC7zk3HLgxVzJIJYS1fA69KtYf1+JbApr+NPPUwivYEpew0
	PjNGKDP54h9YbaDQd4uo0WzVffeSKGCz36DAw
X-Google-Smtp-Source: AGHT+IHg3eY4H9S6biB7z1YipVyfB4koSyvQQsNi6v0oY17gqi/bFromitBT2zMM0KriLTqOB66ZPB4n5KkEj6qSJ3o=
X-Received: by 2002:a05:6a21:78a7:b0:1bd:709:e4cc with SMTP id
 adf61e73a8af0-1c699680614mr721554637.38.1722523515569; Thu, 01 Aug 2024
 07:45:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801-aref-into-raw-v1-1-33401e2fbac8@google.com>
In-Reply-To: <20240801-aref-into-raw-v1-1-33401e2fbac8@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Aug 2024 16:45:02 +0200
Message-ID: <CAH5fLgiHc7azNtwTKNoLP93-APMqkK6vGFKYSEPepWoyNgNjrA@mail.gmail.com>
Subject: Re: [PATCH] rust: add `ARef::into_raw`
To: Miguel Ojeda <ojeda@kernel.org>
Cc: Alex Gaynor <alex.gaynor@gmail.com>, Wedson Almeida Filho <wedsonaf@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@samsung.com>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 1, 2024 at 4:17=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> Add a method for `ARef` that is analogous to `Arc::into_raw`. It is the
> inverse operation of `ARef::from_raw`, and allows you to convert the
> `ARef` back into a raw pointer while retaining ownership of the
> refcount.
>
> This new function will be used by [1] for converting the type in an
> `ARef` using `ARef::from_raw(ARef::into_raw(me).cast())`. The author has
> also needed the same function for other use-cases in the past, but [1]
> is the first to go upstream.
>
> Link: https://lore.kernel.org/r/20240801-vma-v3-1-db6c1c0afda9@google.com=
 [1]
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Actually I just realized that there's already another use on the list in
https://lore.kernel.org/all/20240725-alice-file-v8-0-55a2e80deaa8@google.co=
m/

