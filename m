Return-Path: <linux-kernel+bounces-271462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1C7944E8B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 16:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC59F1F217F9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFB81A721D;
	Thu,  1 Aug 2024 14:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ppw3JicY"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7240B1A7F79
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 14:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722524071; cv=none; b=a/jGzRsWEZv1rfF4CIkWSK/ISb5S+MEb2K7nmlWZLXbgUOlm6yg6Jv69jJk0KYbosUEyrO5Xvz7enm/xuwh9nfW/7slyvePJT+f28ZH95q+1LGqLIL5jwT9tUR+hARm86itYeqxx3VKr1rlq45oCEItwesTwKx2iEV6il9O/2vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722524071; c=relaxed/simple;
	bh=qKpGpoABkSKp5w6u3HGBwFQQJnfdF1X+ai1CeDUq1Sc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fc2cf8VJVCRVgDm0Kn9u9SVt4a7Od6aG8z5Ndo7dwRQoValISu2aNwHAxfjB6200JYtlhQqJrSRfEPvEd85gz+cOO8Eq2LK/Bx3/mMyA/opsmvpLvNz3j5WajOohUoRCYAsIHPAwpKdPGJJSaCRXyWvIc8aGfwXM3k0xrZZ2vOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ppw3JicY; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3684e8220f9so1230935f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 07:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1722524068; x=1723128868; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qKpGpoABkSKp5w6u3HGBwFQQJnfdF1X+ai1CeDUq1Sc=;
        b=ppw3JicYDvrpRBfxHx6V3NJw1EQhIfnukxfljOZWe2sKZ0DcnFtWmEciV8fLiIGbG1
         rU/Kv87V69cEqpNzysbGCDklrGWKTWoHomm9zYO2f+8HQVwjTw4OzPj6l3+u509+wpuz
         Gkmh2NqmTnLudRd9mRxGKw8tFkQF4fykm3U9DbvWhaXFfvKbZGhq4y3R8xHEdrCyZ6T4
         D2Zhe2BYiiBEnxoPl5oem8llni+wy/2QbfDGh0rVnmXhouZm+uyXcTrzTplqGaK8EnFj
         KN21PUJsqLi1D4hd6M27VxAeFBAZJN/pmou5PdQlKK68Anc8vRjFxTXPZfj9aHs3o/Xq
         L4ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722524068; x=1723128868;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qKpGpoABkSKp5w6u3HGBwFQQJnfdF1X+ai1CeDUq1Sc=;
        b=jDEAOcUjwC48H8b+DdOC9gAujz3D8tNq9lf6zz31yT2FbsYaf9iga4HwRiICmHqbO3
         VSJALt/Lb/eQseROGqttEKaRW8A9W8lXiFOLy5GEQz81qjP4eyCQHtsFY7ZFw4IRoja2
         A+bzdFQ6sUk5UF7x1EwC0Cm4qqRCEX6q2+SgbgG1bf2hpbFJtR2TAZTBdqWV2rXNng7m
         W2/MQof7mwXeVtc3NM7Tf5PCYpoCWqDQHUiVvEVgUWmL7Gwc0IcyIzBqIaIALrXPsIUE
         aHbV8XAu0IF41iXC5tIX6c4W8qpFlz7NXCUD08nz+fdOKAHQDmTVrBXxroBDuKyP4UPv
         IRng==
X-Forwarded-Encrypted: i=1; AJvYcCXukf4te48rpw67p4DsnYQ5mfx27XY4wvdOnHxF0O9eedmIyjKTIhVxwmSPnrPalSqCuzfHIy90fcP6vRfBCL3W6rRJUo1QRM0qrGXJ
X-Gm-Message-State: AOJu0YzVOuUAbwkvvHQJlXTPkdzCIQv9ZMY9b3s7RA6Zcf/t8z6cHcWn
	TphC5XXSREOqm1f7bf2rIqWuCxw7X++WavQDnqn6IZ8m21FyyzgIQLdyHIWd5ZQei6kfK3QdgGw
	0jHzJO8/6gcNDFGMe9kWhR23SmOT6M+b5Ku/9
X-Google-Smtp-Source: AGHT+IF9Dysw+d6iU3bY6tA0Xzr0EV1yGVmyzivNvZhZYRb4OSI5V3ovk0R2a5GVexHyd9z+6BVIah4FLpQuPpgg870=
X-Received: by 2002:a05:6000:156e:b0:360:8c88:ab82 with SMTP id
 ffacd0b85a97d-36bbbeefe27mr246365f8f.30.1722524067353; Thu, 01 Aug 2024
 07:54:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240801000641.1882-1-dakr@kernel.org> <20240801000641.1882-13-dakr@kernel.org>
In-Reply-To: <20240801000641.1882-13-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 1 Aug 2024 16:54:15 +0200
Message-ID: <CAH5fLgig8nKSxXgvcr=8TOF6PZ+D_QqiEqeH2rourGDJbMa4Vw@mail.gmail.com>
Subject: Re: [PATCH v3 12/25] rust: alloc: add `Box` to prelude
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
> prelude.rs, add the new kernel `Box` type instead.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

