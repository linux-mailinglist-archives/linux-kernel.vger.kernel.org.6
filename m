Return-Path: <linux-kernel+bounces-547748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 777C9A50D0C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 22:07:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 827381888395
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Mar 2025 21:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0D9C2517A5;
	Wed,  5 Mar 2025 21:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRlRwE++"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1868FC139;
	Wed,  5 Mar 2025 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741208852; cv=none; b=AndgHQ0JMgmTWegLJyo1qrBboQv3gqJFPan/gYgy5s1NWgk3umMrO+KQbL7vu11Ut6lPi4nJvGs3vgLv9PhNWqzT3J8XoExBKYISQDppK/5gEx18fR/fX7zdNkX9LbypDef6SdmVnrSBzc3LUKYRpFt0Oci0XF1o9q+MOBxp/gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741208852; c=relaxed/simple;
	bh=ppeUxjaKjmx50Q3bQDc5N6dSfYxyGJbGKWKkwVwTeuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RdYbxil7VmgO+9MGfmBPrvLpiNzFfMfu+DTXceVp8n20HnyzOsjMCvnSVWqnsjvMtRT4u5PH5y9XvqXsmHLzy4fLgtkDGzSBINpukNTaNWNA/MiGmU5bC/REGVLzA7WssSK+ZgdrTalqMB4o3piD8OHGkRFtJ4Nb45RFyQ/1Wuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRlRwE++; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2ff53b26af2so3460a91.0;
        Wed, 05 Mar 2025 13:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741208850; x=1741813650; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ppeUxjaKjmx50Q3bQDc5N6dSfYxyGJbGKWKkwVwTeuI=;
        b=QRlRwE++KX6AFIpsF2Fd4sRq0fT21IBTnqFlFtB1sZ+rt7G5wrkz6fQqmf/1mE8D/e
         yvwTgJBpk7L/t/6DjNiMqHI10NB1nDjj7waK8mhBLo/a4EoojcbwvglZ7FfX5648lWpb
         hciLaUmRj5Uvb9ycfUL1T0ztLE+MbGe9mIN3XrtkRmXEaeYE9biErwQyXzPIC5mSOiCp
         Jj6aRKLtM3vGzijw427JBX1hvaf5KjyYTEqdO9dbA++txTlMTA6vxrRZVVPTv4AbE3pg
         BI0AP6vUBNNZO+nfuNcsbhO8h23svilV6gnNvD486DPGZ2CA3TMkhTRK1mKzHwD+C0R/
         B+AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741208850; x=1741813650;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppeUxjaKjmx50Q3bQDc5N6dSfYxyGJbGKWKkwVwTeuI=;
        b=PZ7UqJiPj92F6Jc6YOnYxBft7aQD066neyG/yMoZmTZ0JCny0YCSfZF+aL/mpVtsTZ
         +DPEGth+yNlP2ygbNZpOsMYv1U4KmVQvHae9pDSaxYv0upADrX38DfrYudWL5+sFLYk1
         ckqyFwmBHFiLSRBWrW1Cu9KDLFiZrpYHtT+AnHYVjMtxW+yLgeE23I1gNNGyx7obG3zr
         S7jUYzsywnAnlc6VT87uhEm0Ki6wVRxNxPksE7TIIxqRAnZdiCsLUiZEVkp6GGn3ZccW
         +fxbbq4beFNYz3kI5JLZKmQYit8GpjFqE9I7HkxfNGgiEjJZIZA74WOg+Qu3so//ZXk+
         Nyzg==
X-Forwarded-Encrypted: i=1; AJvYcCUOfKYkoi5p8tiOblvSvAcoVO0xMHrr3A14KZCPrOVrKJPlTrliY0AVBu+4FkvJLjCVYDxc1DrJpvI=@vger.kernel.org, AJvYcCUdSruTCks6k1VUINidBJ026fnw1aigniE3eXh6yhLtKiCc9vijTnGErdP0PzoAru6gOjTIKVtar2KxyHcy/j8=@vger.kernel.org, AJvYcCWDWqOPghKdBjBDqwklY75vWbGTw8LdZzXXd17yOMiXwlOOjCQ+6a6xj+cl7hOPw/INaAnHypIZVtDusYDk@vger.kernel.org
X-Gm-Message-State: AOJu0YwzaCyKNlqd95TtgCKyaWcRLYo1PD3N/VtyTbgy/r6fA0cvNBH+
	dKMPIIh0LxBdzVuYlgDHuCh1hnAKAe1aYKfYL6SqLkPHEBM0uaQsqV6llHBXzidFT/Jps967wRR
	tnESyDe7LuYB0wa/xc/JXBM8iDrE=
X-Gm-Gg: ASbGnct7h+xZCAlryw/ZHJIhTqEdpcIj2ObGXe/uf+j7WZWaJW+NwW1i4cHQwdJYVSk
	LZrgRpNRfWKjpK/YFGT1exzsUC7DXSmNzvQRb/sOzl33ZgpzIfPxXdlnPb0N7fH6N6smj6T3h3k
	IAUHzX7LnG0SCMB/IjFkW8VWNk3g==
X-Google-Smtp-Source: AGHT+IFdCsF1vk5OPN4taJHp2TBXL+JUlxGZBmkkbeifhcezimLuADcrM7P2FojcMB4CukfeYQQYekuvC1Sp9CWZOJY=
X-Received: by 2002:a17:90b:3504:b0:2ee:6563:20b5 with SMTP id
 98e67ed59e1d1-2ff49634954mr3085426a91.0.1741208850256; Wed, 05 Mar 2025
 13:07:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250304173555.2496-1-dakr@kernel.org> <20250304173555.2496-2-dakr@kernel.org>
In-Reply-To: <20250304173555.2496-2-dakr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 5 Mar 2025 22:07:18 +0100
X-Gm-Features: AQ5f1Jo9uyXmUsRhx9aiXZGx5yBRRudRw6l9QRLBH4aKQdIv0iL_aGAt-0G_uyM
Message-ID: <CANiq72kr1NU-xs2f8TG3XXG5su4HmZG0TGj6p2vtrzygxTv0TA@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] rust: module: add type `LocalModule`
To: Danilo Krummrich <dakr@kernel.org>
Cc: airlied@gmail.com, simona@ffwll.ch, corbet@lwn.net, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	ajanulgu@redhat.com, lyude@redhat.com, pstanner@redhat.com, zhiw@nvidia.com, 
	cjia@nvidia.com, jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	gregkh@linuxfoundation.org, mcgrof@kernel.org, russ.weight@linux.dev, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, nouveau@lists.freedesktop.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 4, 2025 at 6:36=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> The `LocalModule` type is the type of the module created by `module!`,
> `module_pci_driver!`, `module_platform_driver!`, etc.
>
> Since the exact type of the module is sometimes generated on the fly by
> the listed macros, provide an alias.
>
> This is first used by the `module_firmware!` macro introduced in a
> subsequent patch.
>
> Suggested-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel

