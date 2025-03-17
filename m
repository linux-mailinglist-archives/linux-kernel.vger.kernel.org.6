Return-Path: <linux-kernel+bounces-563866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFD3A649D2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:29:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357F41893D1B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 10:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7C4622F155;
	Mon, 17 Mar 2025 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdkZtt5m"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD20D18C332;
	Mon, 17 Mar 2025 10:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207026; cv=none; b=U5ctnmzGDWjcFbxbboIxLE4iqsmapX0kj0cyi6PqRE8ik+Ypzw0Fz2wj2o+0x4m69L1vu/egECIAJVGy97MYwrmOiFoMZdT5ptGh0/Ip5ywBHtwFAfBXSMQjclO1t8Sd5gQY3ML9ToscU+7Q0ALNdbEpsG9RMt/jAr9Tz6lBkjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207026; c=relaxed/simple;
	bh=lFwo3t2K0faffjx0ahEmDR9S2s/LzxFxAk4RGtNf3pE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qVAlYwZSNMOfTSsrWc+SPnjdBUtH04UALHQZyMKHsR8s1C9Y/DLKP/fld3L1WkNrbh98Gx+/5LIBlZd7gUwKiB33lluamAVjAyYS2wQCoTyIA5MRPfrJBUJCGAZQaW/kEMuqw1eYpwe516RRI7PTu7LWXSpFn0ho+cjxx73H46g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdkZtt5m; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22400301e40so10130415ad.1;
        Mon, 17 Mar 2025 03:23:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742207023; x=1742811823; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFwo3t2K0faffjx0ahEmDR9S2s/LzxFxAk4RGtNf3pE=;
        b=UdkZtt5mVU4Sowqqj3U5H5PuJRUzCRspvhqDe5Ea8YbD8B2bv7NKVMNmSrTmiG33FL
         nQVTNpW8Y6D0Q5Iwe/iksc8q5YKRf2EwW2phdLRevFSJjI1anfCkucrAA+++yDrIhmGE
         oO1pSGiT7iM3zsXysgEfCR6W3oPS6BB/iYCP+4uszhJHbYvn/uRVE6vpsZRGCTu9xL9f
         SdFnL8f+PNVZKgvY2a7X7t4BWK69o8UDoaw7adXI3RhJPP+wOGudV4DaDmuMUw3P6XTi
         Tvr6lGzyrW7Q9GBtnl76bjf17pZl5kpVMtBdFr0WJu3Cf3hoDYeU1sbgfcXHnCVaWEwJ
         i8+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742207023; x=1742811823;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lFwo3t2K0faffjx0ahEmDR9S2s/LzxFxAk4RGtNf3pE=;
        b=RWXzYxRPhWvZz0/w8Lx/a9r0oaSyTA52+ZFWJokmfABz7ODArG40xAiUmqiR0pUXpk
         b8IwmM0OsqBjrauO6IWQFrTjU1znrM07faMkB2UJ096C4BzydrwGj7YuG3B9shcobzlK
         IQRtAvOyoMKvNj44fqrLWhLx8nxtw00sSFR2mYdh4FmwNomjLUS8HlCFkkiVNjWtAm32
         VpBKgNGa3E8Bn/LClNjwiwbPSKEU9RguG0yiAqiKJsjfWfMzOYAwBcRvFx/9NJdCgc7b
         Oipmkz6npmHHUya98KgbefMT0ET4HM7vMKF6Y2lJV4cdhtxiKRdOQgLgw5MF8MRPDr80
         iH9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUU/r6c3kTI6NMWeDr82NUyYl6Us45l816hOqKViGVPI4cUBYZ6dSwK/gCqS6gbbWNRxmFY3H3HzIijUec=@vger.kernel.org, AJvYcCX73FYkazPbJUSXo3IDPnzahXg9X5ib0bCCuAR8p3VUP3WAHJtmd3pg/D+eldLV4FKlfIXfJD5N2oYXJ7dCZuw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUw3KKrmBaeB9NZ1yQxS1rnokCf6YV7vAXrPvo/i+0JRzSWLeP
	OS+oIhFUzInwmd4mG18MgTva+Q/zhmKY+pI9uriHdS87gpi914kkLNS1d8UwEOK0NPYhqfyRhhw
	1NlGVcE/NtkpuVMik6cKwTOoKNvs=
X-Gm-Gg: ASbGncu8R3kt+ukZgo8GGs6kR+t1dYM90lQILg2vTxm+3M4OYuGp0xBXtyPSY75USHH
	uAKABpbc+71bpoJLrb9a7yWXTan8F8vQH1WqhlGqSqrLsWb1GZdoa07LJcVwTx8YtWv/jgVlh7R
	0LnmpCwYlZsJ7RVxsxWLbvM2/U1A==
X-Google-Smtp-Source: AGHT+IFwqtD706xqkPEBJ004FSqSifKO+MnVonUSIs83WnSuqVcoHfGaYBz7bkGErmJcmsDjSfXdnz07SEMA1523czI=
X-Received: by 2002:a17:903:24f:b0:21f:1365:8bcf with SMTP id
 d9443c01a7336-225e0acca8cmr61653215ad.10.1742207023031; Mon, 17 Mar 2025
 03:23:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250316-vec-set-len-v1-0-60f98a28723f@gmail.com>
 <20250316-vec-set-len-v1-1-60f98a28723f@gmail.com> <D8IGB61NVPBT.1I3IZYPVPIEMU@proton.me>
In-Reply-To: <D8IGB61NVPBT.1I3IZYPVPIEMU@proton.me>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 17 Mar 2025 11:23:31 +0100
X-Gm-Features: AQ5f1JqG32cyuu_JPeZ94bUP4bQL2HfMPiLfFPj1IRG2R4Z038XFua8kVh1ZW78
Message-ID: <CANiq72nZrHzhYztDMQnhuW3hhg3eXtwM+kZMd=3ARbWZTZWe9g@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: alloc: replace `Vec::set_len` with `inc_len`
To: Benno Lossin <benno.lossin@proton.me>
Cc: Tamir Duberstein <tamird@gmail.com>, Danilo Krummrich <dakr@kernel.org>, 
	Andrew Ballance <andrewjballance@gmail.com>, Alice Ryhl <aliceryhl@google.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 10:58=E2=80=AFAM Benno Lossin <benno.lossin@proton.=
me> wrote:
>
> What if this overflows? Do we always have overflow debugging on when
> debug assertions are enabled? If yes, then this is fine.

No, they are independent settings.

> This change seems wrong unless the code was wrong to begin with.

Yeah, even if it is correct, it should definitely be described in the
commit log, because it does look like a functional change.

Cheers,
Miguel

