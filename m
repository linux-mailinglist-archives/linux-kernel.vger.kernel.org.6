Return-Path: <linux-kernel+bounces-420355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBFC9D7941
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 00:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13188B23C98
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Nov 2024 23:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5058618B476;
	Sun, 24 Nov 2024 23:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCW5SK6y"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3753B1514CC;
	Sun, 24 Nov 2024 23:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732492589; cv=none; b=due0YoR96nYJ5P/Z4zBVimIqMekiiN6XIdnOKi1jfaqUZUxVy54dpFitRtYrT6s7u8dZR8zHwuVjrBfBSvmHsns9MitcEvkpZR78tslw3YMFKwlBtAcsiM5JV4aJ6gnth+T+bKW7ZKjazOuM/kLlrxHCeC59/Odk41ke2ccZAGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732492589; c=relaxed/simple;
	bh=5XsI2dnv37mBv+p+BtUHDZFriUnNCf9wr1yXZXeXyFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A0bCd+kcDNUHtUWlAcMXc93aRBiHuCytJyiVC2aCvNiJ/BushLcoUa6vTJBH/sLZxDJF1hsjlCN+2BPzCn0uWUqefDB+B31DLV32Hjqitbg0TpWRxPAB2Nl1uYwXsi6SOziRyAm/ccYCvV/2n7mJXSve4zQMd3So6Hn+L8AUM3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCW5SK6y; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2ea4c418488so649950a91.3;
        Sun, 24 Nov 2024 15:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732492585; x=1733097385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5XsI2dnv37mBv+p+BtUHDZFriUnNCf9wr1yXZXeXyFQ=;
        b=LCW5SK6y3b9s6DFatw2Kg4xF43X2JmIuYJR6JRUwJY1Rpm1E4t/aCzo3jsX/btJs8b
         23V/0YE/Okx7CkJbLl2YAej4hZD8dOGUDa4h4SiIwPvUuVbyJ/rmj2VCYImNLxa2DeSu
         tT8VuEQ4qvGsaYxJvEx46yIHgtJxRgJOZBWU6fIKOEZnP4bRTBt4Eq29lGbNuIy0oer4
         weL7bGJ6BcCfzxMINehQlMs4Owe9h7h7cPIVCkVgPBQNSdxeviFLdoFnwgOyopQ4dCMl
         t/hVTP8zJNQjLQUYZhqW83+7DBATwWJn2W1y6pdC3DrxT76ybN3UfQUfp/dVyUwKFiqw
         8HfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732492585; x=1733097385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5XsI2dnv37mBv+p+BtUHDZFriUnNCf9wr1yXZXeXyFQ=;
        b=t3O15BwmM6VXo3fvDVEy+IEaj48FyEwuYyGsq8BrRMrEPkS0bd5fMEqp0pfeYt3a2s
         NFdiAZfXd7DCIy7Gzl0Zho+u6+iRoJD8TqV/iEKKFAtIUDfpRXG9/Dqn+udlrAEt2Ehx
         m8rNk5f4udw+TvF0/Xcc+cG6wNI1Z9ULXUXJ3FkVwgzLqnFU/CsZBiBcuVhGWSNisdN1
         wBHsvMlnMw+FTjn+jkLyGSq3W+8XyAo1A7onVLOTt/1XvUuyfgBoe8l+FpiSJCJxvf2K
         Si+lL3Dp7Y+j7M8fL7jh+7BpCjXSOP0ULaL1DYVsZcguqU9OSnln6PmvftBQd6ngm493
         ReWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUWzb+K9QNKh8Ln8EmIbXB7zN+mO6VvZpy/47f1QiCLafSAu7tRFhuGd2FmKbqkXwD7/nGV6LZgT8WR8us=@vger.kernel.org, AJvYcCW1r9JQMw44Pxoo+dQN3ur6QzljIHKxbYlen3X9+kKJ/sF47KRnC0qLXO+vmL2wFKt8Sh73k9FrOp9Ms/np8aE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Xmi1vFHUU3sBdbfHPZqy7xxLuK0lJYt5tYFU4RblItIWsveD
	+vyQJln97NlTfKh/3hHDCgj0zgFyWpe8QjxX3Dr5yTCSEbLch3m9PIs2r8uu/ujgH3XDbsCHo+V
	MXYLP/ql9BZphwhLge49rO80x4XQ=
X-Gm-Gg: ASbGncvuFWza7V0CNoEbfeVhXgxOg5rsW1G0YvZYv8Yu9rHjzgmIdAhaTjWbHfzqKxO
	sxE/gJDNBZLsUvs3Uj/reqcNTS+5fzQ==
X-Google-Smtp-Source: AGHT+IEI7GYwhVxYuokBXCBQbL5ucki1Qy1so2aGi+FFVysnEyTiRPfnjOrI8Gl0mVt194WhWC3goLNn9vaUL4FIULo=
X-Received: by 2002:a17:90b:4f44:b0:2ea:956b:deab with SMTP id
 98e67ed59e1d1-2eb0e87f52fmr6103731a91.4.1732492585588; Sun, 24 Nov 2024
 15:56:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241123-rust-fix-arraylayout-v1-1-197e64c95bd4@asahilina.net>
In-Reply-To: <20241123-rust-fix-arraylayout-v1-1-197e64c95bd4@asahilina.net>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 25 Nov 2024 00:56:12 +0100
Message-ID: <CANiq72=bYXd+Rx4tTmoUPeSMCuPsmrNWzX6fnBR+siULzK4t1A@mail.gmail.com>
Subject: Re: [PATCH] rust: alloc: Fix `ArrayLayout` allocations
To: Asahi Lina <lina@asahilina.net>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Janne Grunau <j@jannau.net>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	asahi@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 23, 2024 at 11:30=E2=80=AFAM Asahi Lina <lina@asahilina.net> wr=
ote:
>
> We were accidentally allocating a layout for the *square* of the object
> size due to a variable shadowing mishap.
>
> Fixes memory bloat and page allocation failures in drm/asahi.
>
> Reported-by: Janne Grunau <j@jannau.net>
> Fixes: 9e7bbfa18276 ("rust: alloc: introduce `ArrayLayout`")
> Signed-off-by: Asahi Lina <lina@asahilina.net>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

