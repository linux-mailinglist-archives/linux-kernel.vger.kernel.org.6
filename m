Return-Path: <linux-kernel+bounces-390617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85869B7C50
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 15:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 546F6B214EE
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10911991CB;
	Thu, 31 Oct 2024 14:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2x67lOBd"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABBD7483
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 14:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730383431; cv=none; b=QIf2IewpG5sc4g4vMfjDczZlkl+MJXtReZ1bii4FpAx/NV6/OQbbd26dHnTmxdSRteFXa+XNx2IeVi31Rg/BKZoenhYt9xLRjIprSGUVcff2qiAZNo/Ao2SHj7Jifk0bBW0Wdlk/NY7g/raLa5nrfyGWw886psx5oELFc/BGnMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730383431; c=relaxed/simple;
	bh=/ujG1cezyJOLtrJGpOSVlHT/h9268ICutSdVP2Ou40Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TE7NJ6ESDXKtLCV7eEnTqOMkxQmhKvrQMI6yq6Ke+EBw3WKrUFMZBOsYxumvNBpD9u+3Q4SY+546R7iXF6bGsfgqbl4W7xkImLr9qKiZICYVuPM3IGB2hzyvHl1p1JeG2HptAuFhkU7zt7jrdihZ5igEv84NZgBRwJaCum4W3I4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2x67lOBd; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d49a7207cso701237f8f.0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 07:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730383426; x=1730988226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/ujG1cezyJOLtrJGpOSVlHT/h9268ICutSdVP2Ou40Q=;
        b=2x67lOBd4axvrilCA99OAdT7oI3WqCHOv0489EHHahjCpiaunmirfy+sxdvBwJ2w6G
         BxaHxZf0VVqKeE7ISXJ2Oh+fLobtsO5QWFkQ3rqiuKrDw1F/UBrUavAAutOq2RgzkT8w
         Zaco5TZLD4b+nDRs3jCoVJ4So4mal3miuJQgW5I3nTlBj9vH6Px3NwyKV1oSSvszHgL+
         DEnqu6zj6C6PuzSpfSLY91IDglEy/1OXNkv84blfPSSF0FKSwP+JtljPBSCp31yRzm8W
         vQC0q/XNe96/8WQTsOi+uJ+Oi4p8hM7ZCN1Uu9HODB4ZZlJEDL9LlY+pr0uc0zrx8xiS
         H+UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730383426; x=1730988226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/ujG1cezyJOLtrJGpOSVlHT/h9268ICutSdVP2Ou40Q=;
        b=WE1V2mWuWS2n6Xv4aw5i1/NxMIBqmkHZrG0AlxxEBNcQ7HXbyRkg/pZryw5BvLMelp
         Jx6Iz0zPP8cnwBu6w0l6APCzMYeYqBl9KSj0TVDPBKxknQDNJyG1a1w1E2Z4Vkdm1NQe
         FSNeBaN2NyICpPJ+/9Vo8+xiCPZSrDivCDlkWgQ7+GqwZiVWGJUNhJiXEJaI4hmdEAfO
         z+3rx1RTXoZ44etcTzw3DyvGLvkbeZglWXOQE+0p+nH/Y8ApAbwbpiZlmlI29Aq/JIZx
         wik99HqbeJSSKmE8NT21CZLwrSfwJPXNL7RgZHXV+8rCPHzbDkwgn913DOnbTsgrR+BQ
         kFyA==
X-Forwarded-Encrypted: i=1; AJvYcCVKXv1jJnhINobVUGIBGfr99PS31l/bM6Q+BPD3lkkjxlbTkWCFNKNJGPvyNYVCd8MVKU1GsORekon6adY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbRDiiPV5seWT5wT7t4Y2893HJVkr7ft1ULyjHeD2+usUVDc9h
	gUgWagHxP0GIML80/hXHLof43MHhCgbPjlfh3ncBD0vwUKyKd0SHEnpIZIUaKuEsNotmKH7VQQh
	4CmQbtjWsI2e+g5oOfQW0VGK8vgt2Mf/g+o39
X-Google-Smtp-Source: AGHT+IHf/f0WMGY5XNed4m51/xvXz/jJNZeXwlI9IFRgtvyFISoVvCcIb42ZBfoVHnQGnw0bffjs/1UKGO7A1p8T41g=
X-Received: by 2002:a05:6000:1569:b0:37d:5103:8894 with SMTP id
 ffacd0b85a97d-381c7aa4a56mr46347f8f.42.1730383426371; Thu, 31 Oct 2024
 07:03:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022213221.2383-1-dakr@kernel.org> <20241022213221.2383-11-dakr@kernel.org>
In-Reply-To: <20241022213221.2383-11-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 31 Oct 2024 15:03:33 +0100
Message-ID: <CAH5fLgj1rd3b4aaMj8b6Rs77_t+LZApxK-dmP2gk98L-NjFyWw@mail.gmail.com>
Subject: Re: [PATCH v3 10/16] rust: add devres abstraction
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	tmgross@umich.edu, a.hindborg@samsung.com, airlied@gmail.com, 
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com, 
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 11:33=E2=80=AFPM Danilo Krummrich <dakr@kernel.org>=
 wrote:
>
> Add a Rust abstraction for the kernel's devres (device resource
> management) implementation.
>
> The Devres type acts as a container to manage the lifetime and
> accessibility of device bound resources. Therefore it registers a
> devres callback and revokes access to the resource on invocation.
>
> Users of the Devres abstraction can simply free the corresponding
> resources in their Drop implementation, which is invoked when either the
> Devres instance goes out of scope or the devres callback leads to the
> resource being revoked, which implies a call to drop_in_place().
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

How is this intended to be used? Every single field I add of this type
is going to result in an additional synchronize_rcu() call in my
destructor. Those calls are pretty expensive.

Alice

