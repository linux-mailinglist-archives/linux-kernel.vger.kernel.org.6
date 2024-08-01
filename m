Return-Path: <linux-kernel+bounces-271465-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D07944E96
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 530591C2594D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28F231A99DF;
	Thu,  1 Aug 2024 14:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Wno8p+Qu"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D34FE1A71F4
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 14:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722524138; cv=none; b=f3D/x/YqvNYSqICTBj87mKwJ9n220vZ2gW7GPI9kU5+sn3jkzOJ4dCvkU/CYq6k8FT0keLLnfXdZHgiquKNqsPHgWWGYUXMyJho29g4M+rot7mPGZG4QLU47JGFBhgBceAa9zZPCOP0o56Ipr6WkIuPPij1SywY//2MoIKVd7WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722524138; c=relaxed/simple;
	bh=xUiRVXdqJnJHGQsTlKVIdXPw660El0a1032LEw6t+N0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=un29ZO3g53ArhuiciskdBxJlb9feJQ4S/166VlwqcnL+8cpFZhaLV7hRZ5R1Y6uQwS4ctOGkhu6nRSnKw/bhLjbiejshVwWzMCMsl0mY+Os7sadkArZp/e9tQA0LfbwTF9SNSVCFNVO2pvrZCqhvBdJb5SlzlDJ49SuqkwaOTVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Wno8p+Qu; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-36887ca3da2so3286224f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 07:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722524135; x=1723128935; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xUiRVXdqJnJHGQsTlKVIdXPw660El0a1032LEw6t+N0=;
        b=Wno8p+Qu6W/dwvjXSVloozpgHuNo9b/FA88WKDDMFtpZ4i3RtnH/U1NHFHbMR0oIHo
         plyoartlKOEQ9gS3bRr8TVC4pzs0UryVJLj5RKFziLqcSSLMLu0VHz/LeII3Xhs9L9Ro
         xBNzBKvprnUjzJ3VovcOIuN0534qncVZVdXqEgRN6agMbLxUH9eeNCFxbE9jZpQO/gO2
         4PTviqCNX8jDqkwgpGf11FdYj5aw2tXGCmPO1nFo+EeDAftodHGb5yap9/J7FB5aRXur
         5LUrap+ESVN0yD2zlTXaJ/1In3MLuMV8IfUbZ5C2MIxGtSi41dc+qdIs0v7x24NN89qK
         EEdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722524135; x=1723128935;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xUiRVXdqJnJHGQsTlKVIdXPw660El0a1032LEw6t+N0=;
        b=CQYPdtt0yTrPUgA6fF1l3zfwP84av1OhFlNUpOlhN/rFoRB7gh4QSe5tQ1STM9IH5g
         OcTGjFVBdUtOPdIjf1qk3qDSMpl0iTYNiubz1/rkeluEEgisUP0wvf5XOtyKOW1j+O4a
         QeJFoyUYRV8afvj21vhLdmnVLM5jnUpQR57sGIxMw8X0shysCCRqYuWGjYInLQHwG1oS
         1EMLftzVLgGNMV1a3K/kkd4PwCweaSIuGYsTax1/aqbGMnf0eBSlPpIODiUq6kkMFQep
         82YQXmMee0vmVz58Px+xBXBbRHfpDhBcc0c69w4S9TsnbzAAgRdrGP51gexvD0+WUVuf
         yCIg==
X-Forwarded-Encrypted: i=1; AJvYcCXJlShBbQD/mHjXz16DBFo4TcDlAFLPLWvW+7M/hqqvGLwscHQg31ZcoOSyqxBncibk2+a8fMn56+vcwpA1xGS4bFEDP0TuShNdAvjs
X-Gm-Message-State: AOJu0Yxc4BhQXftiC71nHlxA/DkPd7j3AEhs+tlNWcwlXBqDLyNrRDwp
	ovFiHnTR4NiyrHqS6nvMnAHhXoYubaiJaTUCAonVTUG1vnof7xJla4sQNTJnzU5uH0j00Ty0pZ0
	EyaE8KRuwRHdn1R5Fkd1NQwOnPhkPYPl9Ksdi
X-Google-Smtp-Source: AGHT+IE+a8lfGWpFJwmXLx8kiiDn2dCpGA0/L2Yd6wxto7PZKwihGMM8kJ87GNXQ8hR3TN8GXU0NYbGKBQXQ/hAe3n0=
X-Received: by 2002:a5d:6112:0:b0:368:5a32:f5bc with SMTP id
 ffacd0b85a97d-36bbc1b6f58mr52879f8f.38.1722524134871; Thu, 01 Aug 2024
 07:55:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801000641.1882-1-dakr@kernel.org> <20240801000641.1882-15-dakr@kernel.org>
In-Reply-To: <20240801000641.1882-15-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Aug 2024 16:55:22 +0200
Message-ID: <CAH5fLggXrRyUEf0aQL9qtjHbOQjKsq+9XDMHVr_vx+TgAZM4wg@mail.gmail.com>
Subject: Re: [PATCH v3 14/25] rust: alloc: import kernel `Box` type in init.rs
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

On Thu, Aug 1, 2024 at 2:08=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> Now that we removed `BoxExt` and the corresponding includes in
> init.rs, add the new kernel `Box` type instead.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

