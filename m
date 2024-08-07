Return-Path: <linux-kernel+bounces-277976-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E380E94A8E2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:48:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 663C81F23986
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BABA201255;
	Wed,  7 Aug 2024 13:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yvZJqWxG"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC68E1E7A28
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 13:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038468; cv=none; b=LTNuRspvlsWYcv35Y1Yn/hRIBRnkipzrX/0hZRK56HxnvqK7N4cTGlS/mdhkW2hnn2YUZZUPhhwaQyxOn6UfasPfk0XHyheviG2qY/jBByX/JuKoMmF3LgHUJ4oPbIqdys8BTMgoeuHkHb04QK0hvnbVCD8+++B1OG2fmf6r7Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038468; c=relaxed/simple;
	bh=cXwOnnPPtRayPwPAiVsgc6Pd/oGKw6lZ8vM5fMa/JMw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfJ8BLb1KiLAtHvJJR4zWOHu8ymY6udXe8laqSqYRQG/N7m3fWU5zNasJXDxYPpVNOJonEylQhRvPoycaRGWPmQbhCWoZYjUdH21W82RkZqgLf/paeEg8DOpGi1zh/MVdc9Px0HdzoMOqIVWE/9ox8xhpzI00ppN7yT2qxJVSug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yvZJqWxG; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-36bcc168cdaso1227768f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 06:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723038465; x=1723643265; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sg7Fqj4yxnRRstVzhSE5Ryqqe8IAda9IMrvigugwW40=;
        b=yvZJqWxG79yR3Xd+OdWm+nvQoVCjRRaNuRqeVk9TXp27I43hfuokZrBXkJmAbfGOYV
         CfxJhK27z3TgPVrZ058neRqs2nOLfeqFzdLMxOm/uhphMqQk7abDYfVhXl71bZv3wvWb
         Pdk7qSindaqWo3S0T7aZaOTEvWb09Zbk+VViAsj5DhR2DV5unAarCKMfDa0GUBF6mHNz
         vPM9F/GbgdyTPK2yXXGtB6cFJf3lApruesUOLS96eUalW0iZDnix/onQyYT36/iAn8rp
         3JyX8Ftb9QvVEErubwA8Z5E3NN8eKhYfWA5MRj/tozlZtqISFCCEAVbB7vDldVig8bF5
         q71A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723038465; x=1723643265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sg7Fqj4yxnRRstVzhSE5Ryqqe8IAda9IMrvigugwW40=;
        b=KuI0HDfqngBm5m54LDCwye5vY3OUrS9Qm1oiJxs+u9Rhk+H9PulG9MqBhGCen6XNJt
         iRM+FDWc5+w/cA9XoLq+v9qgMDzF6OqURgX2USbolDwvcxKzh4zaHS+LrlYCnQ5dTKja
         jPlmGz42gfapWVc3bD39yUeWJSEceEC1BOeQPLMC2NuF/JdzLSwbyYzj50lyqs8biFTY
         KWb6ZxSObEnR78d3ELgGnieRWkssSunbISkMP4vR+SSpjVaEU7R3Bj50oXMfQ8jDL/Hf
         kTx1XfN6+cpRFi7aw5onHyoAIYJl3RxcVCgomcWTZHuzdBAt9ArS2qO/HmtxCtzSXDwi
         tfMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVx93m6YBYjvb5Ij8YdB14DlMrz2qAgh4plviO2K31/QplJqdXI0aA1vZ18CXB5ISRVEAKVEQlE20sQL0qS+K3kg68OaKpnwNgcSSUl
X-Gm-Message-State: AOJu0YytjwTjH40AgvuuNR8do9QdYZAqDvwvrD8vPeA0un5duTBu0UOF
	PBtF3j2IlJ3GlnpUqI3BIBl1V6yCmaipRs1Rit3g7HeZKFih65uMibZ9Ib6CrgV9eBFUa5C7kAZ
	LPB1B95qUU8N0ZTBLmhtY9jMWfxVR31wMdH0H
X-Google-Smtp-Source: AGHT+IFzaWTlF/4BlvwqYPHLnWdT/Gmw2l5stRTgHWn8X6rjJf6wTFKZewiQ+LXH5HE/7PN7kTx4+9RQ/vAiGcJuj2k=
X-Received: by 2002:a05:6000:1789:b0:368:6337:4221 with SMTP id
 ffacd0b85a97d-36bbc1c7934mr18838226f8f.54.1723038464685; Wed, 07 Aug 2024
 06:47:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-19-dakr@kernel.org>
In-Reply-To: <20240805152004.5039-19-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 7 Aug 2024 15:47:32 +0200
Message-ID: <CAH5fLgjDHe5Sv-YA5mzA2Gj9Pxbxjp1GTDGZkdMKRH4thrWgcQ@mail.gmail.com>
Subject: Re: [PATCH v4 18/28] rust: treewide: switch to the kernel `Vec` type
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, akpm@linux-foundation.org, 
	daniel.almeida@collabora.com, faith.ekstrand@collabora.com, 
	boris.brezillon@collabora.com, lina@asahilina.net, mcanal@igalia.com, 
	zhiw@nvidia.com, acurrid@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, 
	airlied@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 5, 2024 at 5:21=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> Now that we got the kernel `Vec` in place, convert all existing `Vec`
> users to make use of it.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

I have two nits. With them fixed, you can add:

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> -        <Vec<_> as VecExt<_>>::extend_from_slice(&mut buf, cstr.as_bytes=
_with_nul(), GFP_KERNEL)
> -            .map_err(|_| AllocError)?;
> +        KVec::extend_from_slice(&mut buf, cstr.as_bytes_with_nul(), GFP_=
KERNEL)?;

This would be more idiomatic as
buf.extend_from_slice(cstr.as_bytes_with_nul(), GFP_KERNEL)?;

> @@ -291,9 +288,9 @@ pub fn read<T: FromBytes>(&mut self) -> Result<T> {
>      /// Reads the entirety of the user slice, appending it to the end of=
 the provided buffer.
>      ///
>      /// Fails with [`EFAULT`] if the read happens on a bad address.
> -    pub fn read_all(mut self, buf: &mut Vec<u8>, flags: Flags) -> Result=
 {
> +    pub fn read_all(mut self, buf: &mut KVec<u8>, flags: Flags) -> Resul=
t {
>          let len =3D self.length;
> -        VecExt::<u8>::reserve(buf, len, flags)?;
> +        KVec::<u8>::reserve(buf, len, flags)?;

Ditto here. Could be:
buf.reserve(len, flags)?;

Alice

