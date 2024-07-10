Return-Path: <linux-kernel+bounces-247304-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 407F692CDD0
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 11:01:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA5DA1F274CB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 09:01:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A902D1862B2;
	Wed, 10 Jul 2024 09:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CePkZSpP"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D25185E6A;
	Wed, 10 Jul 2024 09:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720602103; cv=none; b=ZKf3c7Il+cdzMt5TOhd4v+sCkuDx/Fy9Szfyv0kaVdW3k6+VK3BtpDyCCMf8sJrqfY4dUvzjiagzK0sQg5ZJrYpQhH33rSfW+jwB4VMKHys0GNj4X8btLYOG5541CQLk4SBhE6vpmqR1QagU8fNXqoEdN6ORi0Vyh/8ndMHCzAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720602103; c=relaxed/simple;
	bh=vmFXtyVCMNyYbHABAh9iS+RSpjavkSOYAah2Pgbu5sU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JgVrZIiAcHYKqhaVHZUu51lS5RQ1uwQNwFZPF6mj57TLQRHWPBtKMTsT73yNHXRYfibrU+PtuPmIxjveWEkRxplhmHUGoImKvaQ1ucr/MISZC5R61Am49YloBB1eVcLLFOtggqr9GZi1J1UAROLCGY3mmjIDZZmJrMIBnyKO7yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CePkZSpP; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c983d8bdc7so4481685a91.0;
        Wed, 10 Jul 2024 02:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720602101; x=1721206901; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vmFXtyVCMNyYbHABAh9iS+RSpjavkSOYAah2Pgbu5sU=;
        b=CePkZSpPDrkFPl3Gn6a8okuj1P+4dni4rgmqac8S064pzoP8qWrwT1PP9DuIJB3yTG
         2kJ0rASc8JR5Hm4V/8yGvniflWUi9fnfmUSnUtee5ULAy35tYz8wNFaCTb6OWxMd4tPo
         yA/am7lPfnWRJg+CTR+7Aj+Qsfs6s0ndjGOMngdhQ/UMo/hQDBsz+1eIFIxfBCOSYyBP
         vHtGfRAmMhc5FVJfmOf8xxlV9RwiX0gWT2SxTgTJA0XE5nDRMXJ5+aKFuxyBHOK/DZIc
         mLMPz0x7Ap7IZ8+H7wpl2h+SDibFCS2zhgeYu+q25y4rhcDi1CGYIn1gYBtoX/SGHaMy
         rPsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720602101; x=1721206901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vmFXtyVCMNyYbHABAh9iS+RSpjavkSOYAah2Pgbu5sU=;
        b=FUglQXFOYjAXQBk2W0plej80OO+EAP8aBrvi5jU+L0L6pPTPrkXIsdePDYqy7xbywn
         K0MR2dtJ8d33qVY4n0KuliLRAOtfPRvQ0DPETw+DJG8mVrGiWRy8UjdbRi1eUEkSwteu
         8d62hKagc4rsWNzMjbyisv3iD3qxqUnfMzVCPPu7jvb4ZVeOiTnmRGr90F2rlCXiNoc8
         i8RP1rnLqfovdpypW37K70LLSiCgVT7V7zCRtO6rws80OxytpdrW67pjnkFKgQ8aas3n
         sa5AK4mjxD0BgYBWrAfrFMuZGRKVXY9hhFxRlYTuSSRt51103GWhh8RcE58LOQSQW3Hj
         sXLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIGXMBhfMzGoAx99y2F8GCXMHdCl3+d3WmKbP82OIfeooH5zw9YR8z7y0f/wpiZ6cFL/mhdAAIyBAM/RPtxp4ptkxhKvqgULVuNlUphtPFv/9N9VRKAt36nmZnjAdEZTDlxedfS5llE8sMrII=
X-Gm-Message-State: AOJu0YzK5ToYSezLkvswZKXddksDxPiiywPyQ6jfQuT7P6CDj36NXhWZ
	YFtXt1FdcsTA75JOFSsrMjKBp+R9qmjIyTLk8cN1+6J4mMXTnoTjasQBA9vCSfnq5CVA+dcyHOf
	ibvuLUhPio1/YaAGUgBF8FaXdsIM=
X-Google-Smtp-Source: AGHT+IEzaE9GFxB1MbaoIUhf8vmwgNC6NulwUarj52xV5HAtPJpAIzgEeJpgYD+koAiX9yk1ne21kbfzrbf8TOOCYEA=
X-Received: by 2002:a17:90a:c385:b0:2c9:66d3:4663 with SMTP id
 98e67ed59e1d1-2ca35d58971mr3979784a91.43.1720602071142; Wed, 10 Jul 2024
 02:01:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709084458.158659-1-jfalempe@redhat.com> <20240709084458.158659-5-jfalempe@redhat.com>
 <CANiq72kS2fAgRnR8yNfpN69tMG+UPfgfytaA8sE=tYH+OQ_L6A@mail.gmail.com> <e19d875c-70b4-4e0d-a481-ab2a99a8ee42@redhat.com>
In-Reply-To: <e19d875c-70b4-4e0d-a481-ab2a99a8ee42@redhat.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 10 Jul 2024 11:00:58 +0200
Message-ID: <CANiq72n-OXYPywckp3M5T8vA3AcFt0kSUUVN60FLx+yY3pPpag@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] drm/panic: Add a qr_code panic screen
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl <aliceryhl@google.com>, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	rust-for-linux@vger.kernel.org, Danilo Krummrich <dakr@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 5:10=E2=80=AFPM Jocelyn Falempe <jfalempe@redhat.com=
> wrote:
>
> I used to list all QR versions in an enum, but I find it a bit too much
> boilerplate to ensure the version is between 1 and 40.
> By transparent newtypes, you mean adding "#[repr(transparent)]" to a
> struct ?
> I don't plan to add more "version" usage, so probably not worth it.

Yeah, that is what I meant. It may not be worth it in that case -- it
is just something we should generally consider when we see "raw" types
appear in parameters that need extra documentation/preconditions, but
sometimes it simply does not make sense.

Thanks!

Cheers,
Miguel

