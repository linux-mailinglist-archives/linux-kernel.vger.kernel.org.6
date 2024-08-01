Return-Path: <linux-kernel+bounces-271463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E5D944E93
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E909A283FE0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CA0F1AAE1E;
	Thu,  1 Aug 2024 14:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DhoZn6+4"
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B5D51A99FD
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 14:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722524109; cv=none; b=eDwsDcRcI+IDhKO6EA4ubAdGQ4FHPNvQm8qULCFYnWC6hwaFIxUjmcwL7eripGQMN+9kv+I/JLIAfbGXyJKuAWkOJZXgULPEbFqm2pe/fkAGp8MOYn4vc8zzWX+Zzv2eBCtXIN+/5XJ3igpmJn9UfRr1mw/NVl+6CqQxnnoCKZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722524109; c=relaxed/simple;
	bh=4Mnvnxa0CeGhhg65Ymq4vHWt9mbjklRhMqqOpKMkRW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EOXKpvJMYciK8GZAL2fJBMbl9h4syG9JiukHFDq8Cl3lDj1v1EF42jnx0iG3YMEeyu5OiRipBjCS9QvCdYYKSLy11SMqDmwEFbGh7QMgUgoU05n4Us7IqoCuW+6nZ3PGgEBPt4B1B6q0M5PifYChR5IH82dVlaqKuciWUL68VtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DhoZn6+4; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-369c609d0c7so4837667f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 07:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722524106; x=1723128906; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Mnvnxa0CeGhhg65Ymq4vHWt9mbjklRhMqqOpKMkRW8=;
        b=DhoZn6+4i1qEXg4BHN/WueA3Qv9Jdjv9mc480C+SP0l/AdttSv5YWGLjrP29lJrBt7
         qCM0DXqzm/ryfzOrT069n7XgN5F3cKf5L2hMfXucf/PCDb2TWI2zWpIaSIQ+LREH7buN
         iI0WcJs6FcrsecadPtBiAfX7iKJ1OAzlVMPNRA15zZXBYNln2L9JyOX7HkAG3pco24wz
         fNX42gJLTK/jYlUvORpVDwpV/5R6jWkf3erSg0qMgdcYtfl1OIEImN0a1IeYLZVUOWKa
         qQqW0arPfvZ0l0aLVz17+pM8awVVa0P136Jqen9qVtHTOiq7PdlldHll0xvLHTPuOyOW
         E+QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722524106; x=1723128906;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4Mnvnxa0CeGhhg65Ymq4vHWt9mbjklRhMqqOpKMkRW8=;
        b=K6BolJSKsOajtCyaB/TAdP8eVDRhcXQHsRVVprhnmaZ90KWjoR3mMrDwUCycu+xaDu
         b4tIXmhzdDKMWU2T0X7xLg8/BvtK9mfQqVGQZ9BuKQ/JzU0zncUyPYDcdJZAbDPCfMfS
         XWZoBhjAfYbv1uVerEUvulhWoiaKIglJk1V0G/wfpCfkluzH1qWaAFOLMslPSenoAykO
         l5x66i4bBBC8BaD106ixl5PsHo+0IbsjscLGb6eRrBQgT5vUxF2OLKG2P0C0K9h1C12T
         kAGFeFVM5MFNFMq28LKj1qWFjNTsYX4M2Ntqxw+Q+OuczLJioBeoXkWmG3GOo985JNOp
         MWxQ==
X-Forwarded-Encrypted: i=1; AJvYcCUg1nMFR+Hd1Ll/8sNQTLKxW5866UukkKWdJ8J3e+G/jt9aTkjSp/1jynlA1cDTBxkWHKRxqAQ+DiNwRsB/IELCWJwqBATp4h6hT6Cx
X-Gm-Message-State: AOJu0YwcWS9MwGdc+CLTNP7oNuDzR8EJ1zuo/2VR+9Q1vhigMf1UZazD
	+AgdvDKnitk+2AhNRk3mhefAeb35Z/+QXVsDcKRubwWKIfOEw4WYhvgwT/IwN0/GR5akfrsWLEU
	I0KauKwrX2S+yDKb4rAjtHXCjZP6+mw/qjJgc
X-Google-Smtp-Source: AGHT+IHQzAlC/Xcsp8MdisO0A1D6EnmX3JthJeFoOZqtJVIlWlOZhdNRzMnOI88skn2V16j2MZs72tWauHlOfTFJoSw=
X-Received: by 2002:a5d:5f56:0:b0:368:7e54:baaa with SMTP id
 ffacd0b85a97d-36bbc0e0f88mr73209f8f.4.1722524106118; Thu, 01 Aug 2024
 07:55:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801000641.1882-1-dakr@kernel.org> <20240801000641.1882-14-dakr@kernel.org>
In-Reply-To: <20240801000641.1882-14-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Aug 2024 16:54:54 +0200
Message-ID: <CAH5fLggg-P_DNhjVS86Wdj4vqMPzxt7nAH+=38O0g+pG9sD++A@mail.gmail.com>
Subject: Re: [PATCH v3 13/25] rust: alloc: import kernel `Box` type in types.rs
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
> types.rs, add the new kernel `Box` type instead.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

