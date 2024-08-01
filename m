Return-Path: <linux-kernel+bounces-271461-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C45F944E89
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32EAD1F26EDB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:54:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FE61A99D1;
	Thu,  1 Aug 2024 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zdHFh7jl"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04931A76A1
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 14:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722524048; cv=none; b=W+lPH14mjUYe1d3MJdZfDjabTrSpBaA8MS9hil9LA1dAFbv1qg2QpLU1W92hRVKWV5K9y8iBpSSW06EkyEkkCMHnRQ74G7i9cT0Fx+XH5IOchx7TTWlthsBIOhGz5Kr23f767/9UV8/o72UqYo3mYrynrG7Ay132fGy+NIUWuMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722524048; c=relaxed/simple;
	bh=88SRWxOKGMT+pDvc5tDniKNYoUKlzDumGAA1uuJmbSo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g8sMbAqEtKZVJx+3CqXRaRi4ey1QLHS1H+lWl/3Mg+xLK22XlJe2N4hzxP1JZUkK+BtaRJ7tYoy38HmtBDL8G6l3gpS6YfKWhdnJrab2jWX/Dd/P8qdXt+bQQLXTYft7M8xEMA88NWVqvQThuIreIxCH9GIzCOex/0SVD7O1nO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zdHFh7jl; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-52efa9500e0so8603620e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 07:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722524045; x=1723128845; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88SRWxOKGMT+pDvc5tDniKNYoUKlzDumGAA1uuJmbSo=;
        b=zdHFh7jlUTq/60sRMQsPhSsXo0x6Rh30HHQjPrCGMLusJLbe9iVIJN5+2z0DEOOMOq
         upz/ImDKDEFORHoold8AI6Lc11f+sEf07xy59g50t5b/q02KFnN8cviQZFDNPcPGTEuP
         1aSxQV5yIQdcfSMGscMB2/Dfygxj/lQcawa5fuzMkNRKHgbJhWEXsGM79a0tveROjseE
         2/MVKZVtHSFefldIlr88wJkCR8pxS8/8E3NqGhKrUtXMsLa2fKmv8U79vNPXrB9xIRrf
         VLco7NqukdMius1SivVdUQpe+zz9tEjXj8RNemRO2zjBGvRxPiWmDVW7m12SyKUJPFY6
         zvrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722524045; x=1723128845;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88SRWxOKGMT+pDvc5tDniKNYoUKlzDumGAA1uuJmbSo=;
        b=A/nJJYA5kkKLFMc9JFttlggO+tqmOKVs9MLS8JAEqujrJknI69k3VHqNNONOEm8xfg
         UpJTZFN70wxCv+N4OyJbo99xv8rUWtfAvsMXz35nb/QYstkKPOkBnRQdOqMS07YmgghE
         lX6Kao9DYfloIKqvBnoMHEa8XiUOJyNCuIiPlW7GB8T58DnZwzK4XzeMCN0ncUiKAla7
         ZXMC6vDE2MJUOQ/PuNfliIIE7ZzI7evb6XdzAYSCZag0K2yxPZkbHU+JwOUiZTvn+mxb
         VzyNFn1kBmc+gLEWXop6W4MeBByeuenB3b3ojLWuXcjvg6ij6NsR0WO3Mvym3DZk6YU1
         2BmQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfoFZ3Dq0dtXrAk8y5Ap4rx38Gdw79NSk3+irBp9aBOEgxgH21u7BGJri7C0vied9q3co4Z/VcRVupbiAB2fAimXG8AdYvt6DHOC6A
X-Gm-Message-State: AOJu0YwpPcTI4K07Iu6xgAF5NKMMc6Qu5HzcDOeKuI+KlIsnoKe0TKgP
	p2e8mYGaxAw7ZVwZHga74mrq1BzsF/fy/WTPf3uAz1AbX69cS3K/9F3w7NYXGZax3Fm6KDpZxop
	kr7CQCcOuQZRWNNONmljsUDNMngrAnBt2u1Jh
X-Google-Smtp-Source: AGHT+IGS6PECdayQywdeyyvbPEGDV4wA1A0/YWtbHt6glRc+EcG+BgYjN3vWR5zth1qceTxw0AnntGI43ZnY6C3+PKQ=
X-Received: by 2002:a05:6512:220d:b0:52e:a60e:3a08 with SMTP id
 2adb3069b0e04-530bb3663f1mr109813e87.11.1722524044665; Thu, 01 Aug 2024
 07:54:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801000641.1882-1-dakr@kernel.org> <20240801000641.1882-12-dakr@kernel.org>
In-Reply-To: <20240801000641.1882-12-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Aug 2024 16:53:49 +0200
Message-ID: <CAH5fLghEXkAm6KuuQf5R088Vud1cOsWCAkqK6Skz5_OrAoV_Ww@mail.gmail.com>
Subject: Re: [PATCH v3 11/25] rust: alloc: remove `BoxExt` extension
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

On Thu, Aug 1, 2024 at 2:07=E2=80=AFAM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> Now that all existing `Box` users were moved to the kernel `Box` type,
> remove the `BoxExt` extension.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

