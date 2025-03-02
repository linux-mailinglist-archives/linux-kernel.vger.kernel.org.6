Return-Path: <linux-kernel+bounces-540696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4AAA4B3DC
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 18:45:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D62047A60E4
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Mar 2025 17:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49A551EB1B5;
	Sun,  2 Mar 2025 17:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OPdXf0sT"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0095CB8;
	Sun,  2 Mar 2025 17:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740937527; cv=none; b=hT5nd4V5tGdbJtw0syrrJM6rd80uuyKEduW7R2418sM8N4/2+h6VoEHXxZ8wSnH1KXZxN1lmHfrTd8oWVUpy44VBHuWHFlFlyfQP1II9JV2pQlkVFO0Af5A56pyCYEXSjFtLM7N6c3GBEllssju5xbxozHvaBazoDalH3es6mo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740937527; c=relaxed/simple;
	bh=k3vFqL/xKCk8f4E661+8gVjTKIGeRjDEleSeHCMboHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V+Md8ksuovLvtE9EWYlW6RwnKBPozRKyvzCD31yCmKwFj07m4vFTqNEJ5UvqfADTr+0TlcrEY5jdk/ECuSMXEx4WshK4zCK7Qb0gWHGZc3BCPCNNlmcEExiwcSTi/a5ALyHJw+AgHz9aBbeIhW90gLxKWOp67Ys5nEfrfoV5wLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OPdXf0sT; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2232aead21aso9508255ad.0;
        Sun, 02 Mar 2025 09:45:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740937526; x=1741542326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k3vFqL/xKCk8f4E661+8gVjTKIGeRjDEleSeHCMboHE=;
        b=OPdXf0sT7tIjp5FbR0OikGyd3AZxrXf8qqq4gRfaf0poFqtVJzv0vj9pz3f4zFPx32
         e0ecBO6t0Q0v4n8mLkSrzv8u35xPzaN9U5UdIJaW+aXceRgBbHvUR/dETxnzOv16MVnn
         X2KoNqbfFyWOtoSb/XY2FzMhufi68TeMpyzziodzRGfb1IJ9hxtTeJLTYWdcM4tqCYaY
         wLlns7hne3AhwWXEEzubFXwBis0k6jzEzFH5k12BjORyZLAaT/9tKsqBJetyujstQAlp
         UYyQkS/n5aSXm/NszgITsM1KtWeaBXYR9I1smZ8dVfR8sATHoge1U3HTJagcO8+IhSoy
         lwyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740937526; x=1741542326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k3vFqL/xKCk8f4E661+8gVjTKIGeRjDEleSeHCMboHE=;
        b=EZQkbq7pKXW5zRsFKDdNoM6J1LIDWhDJWVJQ4s8M3stU2NaPURGSAcM7j3e2GLcmmz
         35Q0iUnIl1rc3wo3f9VmxSlOIjz6KvDOpcKItddV2QohRYJfjeNDj9IAH+e3wg1QzTSC
         z6EE5p0b60fyiE9gjH5inq24fvrJfzfngHprObfNt3tM0ZWm7qWebx3s240fQbr3SRZm
         RDbFNUQkL2eAlPikeh1ZFx2YSDew+EsjWLH912hEsZVpjniZEIqKUaPRQeiKRkYqlMhq
         JcWYKPfDeXtqgE7Kq9nhsP7VySaCUthlQD2uBb4FpoE4GlHXpk5b9d+3v6NI71akqJPV
         qeWw==
X-Forwarded-Encrypted: i=1; AJvYcCVHwMUqjjnZCsLRG+tz4Mky2x4n0kN+Lr3ra4h3gSsXLavVL7omJO9Sfenakttiw6IwqEYMWpPoLj34x5l7XFw=@vger.kernel.org, AJvYcCWtXjVhXaNt5dmB8lkRLBl46DF9a0gfGLVa6TwlYbIBF/3QzpVAi8c2Lf2AR1/Ypif0DZ1vwVjtOt+VchU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZKq0746KRMAc+jilR1vT/a4Vs5S2RU4Me6dZfMFBKxMdM1q1k
	8IHfm19lfvQE1oo70mVyXzhyhqhC+wLs7LWanIrQPWq6L6UgEELFTIhSqLuG2gtj/N/PLqbZ7I2
	fJmjt3CsQQgi5aI8rZn4V5U21XBo=
X-Gm-Gg: ASbGncvSe6bfxTXXMpwyN1BV0Z14ltFYhoh/8mo+MdqyWHUJx2bAKd5hT/NMTtvvpLR
	Dcq2UmuONOAChl0fy1eh6G+HUY5uLb6ktrkIP0hC/IsgJscD3GY4nlbXr/VrXX6jUaQMHsSVPHM
	jzIe4wlWy0QxVrO7fIosEtUCldag==
X-Google-Smtp-Source: AGHT+IEM14oBkasxbrfLuhdlkhBgKZTVdRXsNXBGHPpuX7+iINgsw0kMfQM1BNFq3lNwVS4ywEhQiqhc4ZksgvZKfdc=
X-Received: by 2002:a17:903:3ba4:b0:223:5e57:44f0 with SMTP id
 d9443c01a7336-2236925928cmr56864515ad.14.1740937525642; Sun, 02 Mar 2025
 09:45:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250301231602.917580-1-ojeda@kernel.org> <20250301231602.917580-2-ojeda@kernel.org>
 <CANiq72=69XAOapYBurbwsQOEaw2uamZ6ta=DT6cC-om9XK3dvA@mail.gmail.com> <Z8SMTiWzTDjIwGfO@kernel.org>
In-Reply-To: <Z8SMTiWzTDjIwGfO@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sun, 2 Mar 2025 18:45:13 +0100
X-Gm-Features: AQ5f1JrCn6sPBiedOcepz2gVBmJgyJO37jSMsKXrpOq7sHIUfZKwiTfBkhdUN48
Message-ID: <CANiq72nQNFSa0quEwLYMUVw-2CH3FwrV695k-rWfoQn5r0Mo0Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm/panic: fix overindented list items in documentation
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Miguel Ojeda <ojeda@kernel.org>, Jocelyn Falempe <jfalempe@redhat.com>, 
	=?UTF-8?Q?Thomas_B=C3=B6hler?= <witcher@wiredspace.de>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Alex Gaynor <alex.gaynor@gmail.com>, dri-devel@lists.freedesktop.org, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 2, 2025 at 5:50=E2=80=AFPM Jarkko Sakkinen <jarkko@kernel.org> =
wrote:
>
> (cosmetic) Nit:
>
> I think you could just:
>
> Cc: stable@vger.kernel.org # v6.12+

Thanks Jarkko -- I did something similar in the past, but sometimes
patches got backported too much because they could be applied.

Normally they don't hurt, but I try to be more explicit nowadays so
that the stable team can decide, and thus I copy-paste that line for
changes that are related to new compiler cleanups and similar.

Cheers,
Miguel

