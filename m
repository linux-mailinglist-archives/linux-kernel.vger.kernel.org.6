Return-Path: <linux-kernel+bounces-277993-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D09394A922
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 15:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FAEC1C22470
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 13:55:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE4D200121;
	Wed,  7 Aug 2024 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DibU0r1A"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9C61E7A4A
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 13:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723038939; cv=none; b=NeAt8sf1LLJ51LOPxvt5Yla2CqpLthxOTPDMYWDteshfiQwoylximZgI0niliCOxbxuGS6mdrB+FRIURiB8W8tB/+5fwf23Ly7lqgWVYKwgvPQRbUJ/dW/jflWPFAKiRQexxvXWmN0S0SpfKJQUe+iGNMW8d8RCl03isW2AZ6oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723038939; c=relaxed/simple;
	bh=OOkW0C3TWxiXh0KWW6Kt/17VMC+Wv37GHf6UcFqo9FI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zv3O+loc5jBWPljrrTH8P3u6XkwC35RCgQNqaHxXTGIzVxrZkd7EzgXmGoAeynrqb2lC0UNnHaeRAunEuten7gwTfj88c5P4PlR4Dot9n9w+WclWdm9u8jCbWuPzPp4Cs5U2uy9o+CHH/y716cylo4G6F+Ro+dXFrODVRAi5xDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DibU0r1A; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4266f3e0df8so12281485e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 06:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723038936; x=1723643736; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OOkW0C3TWxiXh0KWW6Kt/17VMC+Wv37GHf6UcFqo9FI=;
        b=DibU0r1Aid5jmzN9EGXaSk8OlU2iz+cllOA/xmGNfIlnYm4s9lj6NpnHkS8+2Ib1As
         ZsV08QGVZpn0/MgS1gGyuH80bEao5lbFrcwT2XQbLbfpB8RnyhAcW7E1FrNOD4nx8F0o
         oO48sWqzy/mqVm217x1V7C1ioIaCmVcESSf/7VHglfnmqhEkcSJZKZ1CpIaO9BwoZ1py
         ErxTLvo+ixDHuHhmKpDCviRPqHL2bdqEoSTSYcXVRyt5jdcJCy6kceSvoyCtscB20Ujb
         Ojgt/4QnNyWshsFXUyH/j/tSeK+32foazF0LybIhACYYPR1GOGNNHcDXpNlfD/qS0nRw
         sNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723038936; x=1723643736;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OOkW0C3TWxiXh0KWW6Kt/17VMC+Wv37GHf6UcFqo9FI=;
        b=b1HpO9f0rggcQrYSM+pbjIOczO6dwmXd/+LN5poUQ43CWfT4MkXr1Pu4Z4iN0VJY1z
         zCE+oANJk1U7y0VUaxgIWJawMAZ20dc9i63nDfAXtkyeo0/xLHw5GmafLy7TpMq2S9Bu
         qOhyF/WJExhT61zGqse5tXc5B7YC01MaJx6q2RA+jOIgvq34O8UbzyPF6qJE2Ln8cqWH
         nnlwdwAK3qSb9ax4YHQ5/+duVwFwtFQV/1MuF94baQNdE0zgqkNur33edY7lkPbfoZnt
         3YD1AANG8wkqol4aNVRRpo0PYGxzXvVrOpcm2RVSPhGQsqFQMbzmkKXvIq8rpXYt3lAK
         4cKA==
X-Forwarded-Encrypted: i=1; AJvYcCV8GPRVoCCMWepMidSx0zTwgkUKyH8k5d4kSJD48c9JndB9pvFJyieIF3uluTnOoVas0hDGU0OePD+KHFeMsJCN97MrpojHyMc688Zc
X-Gm-Message-State: AOJu0Yzv0EQmXIGQdXdW6iJkboa64PWpVqMm5I9R/Qm9V1TftOvP2pUm
	FmHnzqjBEhdcUqQ1l7zj64MOz1aunjUuE3RboUIlcCL2s7oIFhORTwECuWGujkvNEPoKFcFeLhR
	vxKnjpR8z0LuyV2acopFo+F9Er6QoJ8zrBisH
X-Google-Smtp-Source: AGHT+IGPQgzETpzG41seLRcbtcsEFnCBPNR2P66mPBNMHEJ61nNcZOcNkbvgkcOQKESvuTz9aFPu8cM8JjruPJkyN/s=
X-Received: by 2002:a5d:6d87:0:b0:366:e7b5:3b49 with SMTP id
 ffacd0b85a97d-36bbc1c246dmr15612543f8f.54.1723038935713; Wed, 07 Aug 2024
 06:55:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240805152004.5039-1-dakr@kernel.org> <20240805152004.5039-23-dakr@kernel.org>
In-Reply-To: <20240805152004.5039-23-dakr@kernel.org>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 7 Aug 2024 15:55:23 +0200
Message-ID: <CAH5fLgi3C3imTjwx697zCuDnipmX_KZpsQaGYUzz+3=MW_Cf_w@mail.gmail.com>
Subject: Re: [PATCH v4 22/28] rust: error: use `core::alloc::LayoutError`
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
> Use `core::alloc::LayoutError` instead of `alloc::alloc::LayoutError` in
> preparation to get rid of Rust's alloc crate.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

It could make sense to squash some of these super small changes that
prepare for deleting alloc. E.g., patch 27.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

