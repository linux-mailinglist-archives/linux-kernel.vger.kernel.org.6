Return-Path: <linux-kernel+bounces-574433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BDBA6E53C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 22:14:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E2889189C2A6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Mar 2025 21:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC221D7E2F;
	Mon, 24 Mar 2025 21:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3wU6m+d"
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C19A01E3DE0;
	Mon, 24 Mar 2025 21:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742850446; cv=none; b=FSxKfTotLtUqfceNBiozAw1rdJ3YDxv4vM/K5m0KA0w/iAaibZCt2VPrvQFAVATYZP3KgbkTjO0bQSxLFVGQ3biQ4RJN0AEhCXAdHGsO63ydZBEwiAvWnDvXKj/O/NxlD5+k7V5sNPQOyM/LW5IMdFKbTXf9jTVtlDwhIqJBtaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742850446; c=relaxed/simple;
	bh=HIM146H+SmGtSNE78iI/F0ZJKaItnpxecxGkKXyUKvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fhYqtQ3CseV+xZ4qGQsxnebrsN+zZ++Y3+ptuvOEGquz1mUQdgpWyK5OvUbhU5Hk8FoeOwKf9/GEpYjWSmEEglnHmqx6Cc6ywwXa8QeD7Zb2evExtD0vMmV41e85ifjI6gCnaoeYt3UWMRyZRiyMGohV1+xLkseJrnzVL8AyLx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j3wU6m+d; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-301001bc6a8so1356129a91.1;
        Mon, 24 Mar 2025 14:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742850444; x=1743455244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0f4oMKaqWF/1RYznP9bKhltlGtX64Ox9tuugsDhbh/I=;
        b=j3wU6m+dYfAWK7s6DQDCSSWB/wlH8iI8OgIt7mOvZpW+g2jkn0q2uPQBL/3/zrX+nm
         V/CJ31BA5MxVHk74T1+lc3qxUlhJUtlkXvUoscDvjBZesgNmh/imP6nScIsuRQUh8Tfl
         ZUwrJC+Dlm6vvVLPJEvU7r4cHHfnkZ3rgYLLyPmqBot7wofYWCbXR+zkSV1YMl5m4laO
         HwQ9SnRfLtT5z2QOMbXfzmSg8z4G6fkIRSpyu6LeRU3acWVj9/a9g27Uxt1393ci1/Ms
         Dc/Ys1bTLbU5Hij6LxBD1n1TBVAlrt4mtMt5r6m+pbm69uqRlBbT7CbZ6KdhPQI/KHd8
         U2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742850444; x=1743455244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0f4oMKaqWF/1RYznP9bKhltlGtX64Ox9tuugsDhbh/I=;
        b=xDGw3XMiJc2M8V4P7pS77tyx7t3lG/LjQPZKTOge1R/OAOdCz/tp3odqbsPSgf8vcY
         oKIYU1FiRf9uNadGu3k/kIksyeK93/9ltGvLSd/u31HUPcD8xb33eRLY5Aj585VD4mi8
         V1dvkFAdt9ycVrjBr3vqk0hZv71SEb/YTz1bIlVIR41Wfno1UWayQv7VhbKHoG9fbeiq
         g7Q4S8IroRzsdlpfCCAffjgzWwA0Uu+l4VUolTBbddbvtJqwg7TZypb2I8bmW/OVFf6L
         VTo0S3zOMAfciHWNp1NCXJYkBtp8bT+iVaLTu2ymdnqlZfQjsKD38dYMdz2F0djk8ok/
         eEvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDDTgC69uZ9wgYP0mDo1Kjs+XOULctPo1XNJSvRRsd/3uKZE2YKuhbn6qdSUi9XAOD+Vo5P62Iu66pCJE=@vger.kernel.org, AJvYcCWauFiy3cQI7S4MpU/xr7O2MGAwHySMYKfLJB3JtU+4yigGI2zORfF1yMqF6f9wIAWi33Rgi4aIy319RUNlqKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YygfiNhUqz32eqlYoyhodwvBLOrCVhdVvg6dpu7gViHb5gP7VFc
	2TPtLurK183kq+jHubmG5605QnokA0HcqS7YViWjHtk3E95ifTiJ+hnlDiSX80L0/enNJjLgdSU
	s+/Sb+loBsJrYrFURdjYqhGucdq4=
X-Gm-Gg: ASbGncvVUbkoTIeL33jIXvLeamgJ4c55nRGqE9KXYfWCvbEiyGpBESMwV00EBbi2VKo
	qSn5J5z1Tql4RYPV67reSdJFDBJ1IR+Gtugs8pOwe1Dro+kKSHYauyx0SpG9mloqSrzsNW0wakV
	+jvOWrWj8YSUnz+k7MX4/fjtNAHw==
X-Google-Smtp-Source: AGHT+IFFjtafG0wMuZOrq5yJdlInKcUlyDtdZ577YwhsNZ3Yq5ctbw5CS07D7387Hjb2bVPr/RDfiCq2gCBAQwtQGQk=
X-Received: by 2002:a17:90b:2250:b0:2fe:b972:a2c3 with SMTP id
 98e67ed59e1d1-3030fd37008mr8714903a91.0.1742850443707; Mon, 24 Mar 2025
 14:07:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324-gpuvm-v1-0-7f8213eebb56@collabora.com>
 <20250324-gpuvm-v1-2-7f8213eebb56@collabora.com> <CANiq72mQ3zuYmsq1PD-49kKLNji8OJwuvxK5QWkNaBMuC-PHQg@mail.gmail.com>
 <509EADD7-607B-4DED-ADAC-152D7338EB50@collabora.com> <CANiq72=aVRMvOaU48DBLL=p+VoG3RvHK+K48XQhvHw3ARc0BNg@mail.gmail.com>
In-Reply-To: <CANiq72=aVRMvOaU48DBLL=p+VoG3RvHK+K48XQhvHw3ARc0BNg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 24 Mar 2025 22:07:10 +0100
X-Gm-Features: AQ5f1JpZ2zvfI8VoAwy2TeonYlCMJU7HVQ7vBEitKnbxHHICGiRlv1x9aYjaYgE
Message-ID: <CANiq72=4+ubh0F5y2QMobFoyQPs4Aj7bOL8n4y9LzHxrb9Z2sQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] rust: drm: Add GPUVM abstraction
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Boris Brezillon <boris.brezillon@collabora.com>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Asahi Lina <lina@asahilina.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 24, 2025 at 8:38=E2=80=AFPM Miguel Ojeda
<miguel.ojeda.sandonis@gmail.com> wrote:
>
> Yeah, I asked upstream if we could have something that at least
> detects what could have been intra-doc links, because that should not
> have too many false positives since it is a subset:
>
>     https://github.com/rust-lang/rust/issues/131510
>
> It is still tricky, because e.g. `Some` or `None` would need to be
> excluded, even if you require the exact same case. So it probably
> still requires extra heuristics.
>
> Then there is:
>
>     https://rust-lang.github.io/rust-clippy/master/index.html#doc_markdow=
n
>
> which is closer to your idea. It has a few false positives (e.g.
> KUnit) from a quick try, so probably we cannot enable it for
> everything, unless we commit to maintain a list of terms in the
> config. It spots a handful of things we should fix, though -- I can
> send a few patches or create good first issues.

I went ahead and sent a quick series for the latter:

    https://lore.kernel.org/rust-for-linux/20250324210359.1199574-1-ojeda@k=
ernel.org/

Cheers,
Miguel

