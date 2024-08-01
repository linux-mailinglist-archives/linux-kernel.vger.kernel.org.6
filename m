Return-Path: <linux-kernel+bounces-270866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D02494466B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0C0E2B23979
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 773A816DEA6;
	Thu,  1 Aug 2024 08:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EctJB/Ob"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30D4416C85D
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722500489; cv=none; b=S+tZbFoHBXzl8vaP8tAn+fwc0giCbEFX1YaXitg2ypBxCKo9aA9uFmzKESmmaWh7XcM+A/NKMnIlP/w/DYwSbRq9+ZGIkUWKMCxA52uE8NP6L6G2qRyglF1juALvaOiubukNq2OUObV6vsacF3seAxxDK/LwVg2U8OJJ+88+46s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722500489; c=relaxed/simple;
	bh=Ift7TzORqGbhU6p7sF4Zt54uNnequ529bnGRDSsXufY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSSFNQrTFN9VcEzB3oPEnSUftYL0rfTzfqRP1iwZnG2FQDUiwqeuPevA2kRSe2iZkdX6qUqZbOFQnkOzCmfIwC1yBsawT8JDwRTKkefAJBOmE8opsdMcfYQ5KnSElRF9/sElVdY8I4Wk0663wKGv0ZlLjknEnzdG7MYq+9txaF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EctJB/Ob; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ef7fef3ccfso78709171fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 01:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722500486; x=1723105286; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ift7TzORqGbhU6p7sF4Zt54uNnequ529bnGRDSsXufY=;
        b=EctJB/Obzxr2KdykbmB+JweAyQ7/H1sVewc0je2iXZYPRd/EUTjZMCMPW+H9L116vE
         UmSPiM+sg+qb+PlNOTUrKgchITs5rVE6BJ51vQc0L5LjkEhfEUHIbKQGO34SMzVIheOB
         I18ZpN6j01IsGWhLAV9Dq75xPio5Q/9PByE0PCpqlegGDvhasYGVtT/S0tuzhOwcZLU7
         OScqdMZmcdyXpaPcNuEHoshd9srduKa8Jp+Irbe5ZLtaf3BMiMqgbrk6X6YbM44AFPG1
         26Sy3MSZGAhaWV4Bg/cUyK1RyQPR2FqAbaDfusSmyAcIteyr3WyREUbw1RyEWzTfNEmO
         m+0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722500486; x=1723105286;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ift7TzORqGbhU6p7sF4Zt54uNnequ529bnGRDSsXufY=;
        b=iHqqChIQvfIiDwstI5cacLxsdQr9sd3YMx6emqugTUCDml6z+cWlmsRXRD7HO7x6rR
         2aSodHl1lf2fjDjdm36/zX3X0iFiMCX35RadQVQ5YajhQtwqgTdhZNDcXxysn89zVUis
         zvQatPR30TxlfeKQlq7yHkNoHd9MzMl54lBLsi6RVUqtvzZOPzSIb5QPlmwAHcCWH2y2
         yLAVvDEejkOQMKnUWnej5hHkunwiTpJYQq9fkzDSS0t/kwfWnTvPlqes7/X7nqimA8KL
         tBsihd+VNSHS674QUREL6ZxovorNLkyC9iETMPilpnN9ZqqlGPd+yPiX91aGW3wRhT+t
         yO4A==
X-Forwarded-Encrypted: i=1; AJvYcCU4qAixIx0vJqP+14Jl+YfheeqdVq7RF4VPb+g9zMp8T2FnZkQkzZRwNwsC5Ix3epGnwtr3MExZndZg1rYKcfes7fBLXTkRRakz0rWS
X-Gm-Message-State: AOJu0YwAewKPraGg0Tgh+QVVvICQGtsPyCDt2e9kidwOwMVNXZYXjIxG
	8hzb4thuq34ysTjx264/ksgwhaJ4gonwgpaNhLmoG8N8x6LGWFRQi0tI+VortMkIdP7P63zm+P0
	I4qaI2CpNRIw90C9owW3odB4E2qwrART+97VV
X-Google-Smtp-Source: AGHT+IHsR2voflQxRCSCFqdxDUx0/w3yBaqi9tYqoopje2/QUhwqJ2c0wR0BypuLpRopenPqhbkO1ohoFYuhjseiL4A=
X-Received: by 2002:a2e:9b84:0:b0:2ef:1f51:c4f2 with SMTP id
 38308e7fff4ca-2f15310069amr12958661fa.14.1722500485934; Thu, 01 Aug 2024
 01:21:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801000641.1882-1-dakr@kernel.org> <20240801000641.1882-3-dakr@kernel.org>
In-Reply-To: <20240801000641.1882-3-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Aug 2024 10:21:14 +0200
Message-ID: <CAH5fLgjQ49HUngZx9vxVNWJuHQzYWVTnrUT7xMxvNNKRGaD4Ag@mail.gmail.com>
Subject: Re: [PATCH v3 02/25] rust: alloc: separate `aligned_size` from `krealloc_aligned`
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
> Separate `aligned_size` from `krealloc_aligned`.
>
> Subsequent patches implement `Allocator` derivates, such as `Kmalloc`,
> that require `aligned_size` and replace the original `krealloc_aligned`.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

