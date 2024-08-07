Return-Path: <linux-kernel+bounces-277994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 432CB94A923
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0363D282290
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D331E4AF;
	Wed,  7 Aug 2024 13:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="taCjc+yT"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84CB11EA0D6
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 13:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038958; cv=none; b=N3ZjBQOau2GHomjw8ai/BN1f2ETKxJ4lgoIRdKJcUcPmCiyGifWCymw2qf/pt6Rzr2/+A2pR9tUolAywK+I1GpDZmHX8mjGm5tl+aDvlfBTGTBJ2zLrDzyuf2eNwljv1oWJk7g71kHL+vBAfZkdgiHj3mZ+g84ln8qdACFicElo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038958; c=relaxed/simple;
	bh=MZ44TK7vjwRuyQ9dOgihBCa9p07QgTcgR8nV2B374bI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mhRSYXxlqHoxj+KCz8gMRiDP23Wa4b9o11IxGRxuV3nt5IazheDgu9ZGuf+WnIvy3N4CPEQU1YwoufbU2Z8i2ffDmA0nyqx0p8xZXn6GbqotspDfefNQWR1DC50FkOgsK49oFIydueDARlk9pXXJSbEgbDUWcafvhIBTeOcrpQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=taCjc+yT; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-42812945633so13532015e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 06:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723038955; x=1723643755; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZ44TK7vjwRuyQ9dOgihBCa9p07QgTcgR8nV2B374bI=;
        b=taCjc+yTK/tVA2MCIzt958rRMoxuU43JjQANWGwz9Aoya++yYgIA2sQ5dgqfzuCkpw
         MI5TnB7Xp4WY/xBGlpvDT8cWWHU5u6SLXI4so9eNjCFLLeUAdozJ4uL0vdVih0KaNtQq
         4qygSz/ksGT3AtxOgLBFCWOlkEddBYhbvGLDw/OFYcK0+D5V5mLBR15mAdF5xAJQ5pMO
         HhYDDU1omdpTAi3uxZiAF4uHQDjIuprt0Y1/i9bsUiDYUVcrCh23V+xLT/BLV5h0JAnV
         cpbSOpGBesrDSkcZjOe/3XwxfLYobQQsrdnBPoRwnjMhGT8UT2Q4gG6EWIJEHrosxQZb
         aKnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723038955; x=1723643755;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZ44TK7vjwRuyQ9dOgihBCa9p07QgTcgR8nV2B374bI=;
        b=Zf8FQHrJS+fSmJEKRqrFT6MumsRszRYZGEtRJSM6CeAyJqsujz9n67aFZgnuD1nLHT
         +FyvohbtJH9deb/sknsU2v/HBwfwgvKmpdu7sTZvRcTHVhO/dIpGevEHPG9InT4rbxGp
         VKtUkSPNMX3Nn0ksi14jdMe5bdKIpe6mR05Tip5mvA8tiJNXel9KvSudPaBLhJSdZhtf
         MBg7PROzGaWRztxVKfkTFWfjG6Jx/gx0F9/jCSQURfOH/2oE2assNHZ8Em6uRndejtdr
         LDy2rqI5Lv3S+Hxa/7ISXGzZHJRiRl33JJs7lDBoz/mUX693Ez2BWrcsmBJd9ie2POAA
         kFXw==
X-Forwarded-Encrypted: i=1; AJvYcCVNy4Pod+Z8O0pJVTQv83Py4Npi9jTxp5aVBswcKsuSvkHTdMG+Ys+ZMHTEOAvo+JeCzNA2YoIuzii4ztNM45d77hdyCtvNEHrZplHh
X-Gm-Message-State: AOJu0YxW2IqN5utl0XxQm5agIpu9RCQuhh3mCBCbbp3J2XDGLbQNDOd1
	XpzKEOEse/X7iEKk5st79sdJOv/9ZqUaJthTinOS6/qqViWVH+YyocuqsDaRVbbYEWuZ9+7IkKg
	+k3EzqSXno5C/HTDiOqWcf50xWW9FPqJwOGKQ
X-Google-Smtp-Source: AGHT+IExEsaJLzPgD2P/oGXhuQDQgbdYIxzQYwD+vDeT9oGNd/3KIYbpFaaqnO+fryzi59+HwlZXrERAE+cYU3j/hw0=
X-Received: by 2002:a5d:5d81:0:b0:36b:d3bc:af03 with SMTP id
 ffacd0b85a97d-36bd3bcb085mr7521727f8f.15.1723038954536; Wed, 07 Aug 2024
 06:55:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-21-dakr@kernel.org>
In-Reply-To: <20240805152004.5039-21-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 7 Aug 2024 15:55:42 +0200
Message-ID: <CAH5fLgjVHrBNgyQSnBU_rg71M4EnOpt8Sz5ad1okwME9uXwOMQ@mail.gmail.com>
Subject: Re: [PATCH v4 20/28] rust: alloc: add `Vec` to prelude
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

On Mon, Aug 5, 2024 at 5:22=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> Now that we removed `VecExt` and the corresponding includes in
> prelude.rs, add the new kernel `Vec` type instead.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

