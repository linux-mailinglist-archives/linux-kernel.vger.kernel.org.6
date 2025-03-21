Return-Path: <linux-kernel+bounces-571230-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D260DA6BAAD
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 13:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59D323BB847
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 761EC226545;
	Fri, 21 Mar 2025 12:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="djTuvp78"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA50225761
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 12:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742560114; cv=none; b=e5ytJh00zc2ugOrXvFVbjJTSzUEg4gGtu43kRRhxnkKOO5XYLKLsloCvKh/ANGyBNUTOAy6nDabQX5QcQWnRW8HyvOOGbU/vjmzVCIP32To0AyIkbn3Ni7LZMr2iaA9MuVSo8ssC38FK72brsKsZuwE6XlKySGcyo9uO5ta5CK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742560114; c=relaxed/simple;
	bh=xNTdXsPV7ZLLw7TInR7IVWdNotSiaVd6/yq6CpjdPNI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ddYAdN49w6kQo7vYupoTYRrlqymv5lSrmCbqhwr28CkHzaQTHlGZs4hFhPJZSret9l8U0O11x65RN36M5Xu7O4rXATfwM8/fgk7oX2CJwMlI304tVQ6+QjbkAG+5Drp6JDERGsN/1Ua/33LdctWo9nudTC+GCmbsLiWorOmL2SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=djTuvp78; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43d08915f61so12029435e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 05:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742560111; x=1743164911; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=b5TcWZiE0ilse5UvOGyrUMGqPLytNxTeNJ6aN4o6LPo=;
        b=djTuvp78Hd7WYLs7kv3RNP7s7vmIuHPSrN5tSXBHpBqngQguGzoB4qh/As8psd/+4x
         l9SHG1NmeMK/2AQ9dh4xklezwyozDJdb5NvVNex2euqkpsRBT2v0ZU4A2MrCNp42XWtH
         sHzzcJLWhELOJHEj9A3fW6ojN9lQTWVMQdyWePgxwS1mCjTbevhdy+SY6bmL9kLdXxVN
         BvQup3VsA6A48cj4ZYuApwcBMMBY9erzwKG49i2pzLxZ/JZjiAc9WrMc6XVfNcccQcA5
         coxrWuC7LS31cDQSSHdtHTRWeTv+maW0WT7Zzu1kPxjqDXsxxgKixXhDK7gWiSJjf++i
         RXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742560111; x=1743164911;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b5TcWZiE0ilse5UvOGyrUMGqPLytNxTeNJ6aN4o6LPo=;
        b=KPAKaD20AWpCfw4pKhF7b9Cqb8eAL9GreqWoR4/TPRtK1AalbY55eKaadUem4+xr7v
         U+V7i7iBaG66j0lYM1qXIDfH/k/c9Hy4804tasyXHm5bLuSTtNOvjZjVmOF1pXzoZWBH
         CSJscQ+FrURJaMW8Vq0kVKfXLrvLKch7Mg6nezjZYefSb/FOhIbPWEAtAFRpXXejEvf3
         qc2kn9AGPuCRhPPdXQokp8sFV5L70XEGFiGm7jDUdF/XG+SLobbooCIR4pdQBaw2stvG
         on5Chkj0RKWX0TmS3tb+PInFjxfQX5Z4+lZj0eDw4ixe6F8pf39OuivxS7VbM/YpDU7b
         uG7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWIw1amK/7CFoiqUYj+GaNKnCCHHlmpJtZVwxm2mBEAGgjfxMky7pgy7MbWFP25ZggLa3TNzZJgil7pcPU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyitHYJwBL1ok7DH7KXcrWAXxqhU6sPxayGo1HOYFkCoXpUJYU
	Y8x3uUesUuJKJk5mRc2WK0ZbHCWH/l7a0f2TQq6WjMfalE28qaOu51LMa/3TaMku/Y0njszpDtC
	zmIxCrCGjhBQ9gA==
X-Google-Smtp-Source: AGHT+IENczTHdx1nb9pOMIzleGyvG3hLaKmxIgbwMngbB9RAPEpzfQoh1+OX1XkGUsZAGg09pVhxpuOz4Ajl+44=
X-Received: from wmbh11.prod.google.com ([2002:a05:600c:a10b:b0:43d:4fae:83fb])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4512:b0:43b:c878:144c with SMTP id 5b1f17b1804b1-43d509ee50amr30863035e9.12.1742560111811;
 Fri, 21 Mar 2025 05:28:31 -0700 (PDT)
Date: Fri, 21 Mar 2025 12:28:29 +0000
In-Reply-To: <20250321-vec-methods-v2-0-6d9c8a4634cb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250321-vec-methods-v2-0-6d9c8a4634cb@google.com>
Message-ID: <Z91bbTevB0LCp2qK@google.com>
Subject: Re: [PATCH v2 0/7] Additional methods for Vec
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Matthew Maurer <mmaurer@google.com>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Benno Lossin <benno.lossin@proton.me>, 
	Tamir Duberstein <tamird@gmail.com>
Content-Type: text/plain; charset="utf-8"

On Fri, Mar 21, 2025 at 12:09:55PM +0000, Alice Ryhl wrote:
> This adds various Vec methods. Some of them are needed by Rust Binder,
> and others are needed in other places. Each commit explains where it is
> needed.
> 
> I'm not sure what we concluded on the set_len / dec_len changes, so I
> don't depend on that series for now.
> 
> This series is based on top of Vec::truncate from
> https://lore.kernel.org/rust-for-linux/20250316111644.154602-1-andrewjballance@gmail.com/
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Oops, this doesn't compile. Looks like I've already gone on vacation
mentally. Sorry guys!

Alice

