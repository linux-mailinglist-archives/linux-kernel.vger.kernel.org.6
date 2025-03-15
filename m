Return-Path: <linux-kernel+bounces-562740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBBCA6321D
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 20:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F75817334A
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 19:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB31719D071;
	Sat, 15 Mar 2025 19:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ke4SKZJl"
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DC218DB26;
	Sat, 15 Mar 2025 19:52:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742068363; cv=none; b=izEIq52IeAHw2OOfUMCjmfoLApHk3oAl/Pujb/rqSK/mpx7qY2qUI7Je/6IIbZzu4icL6Nk2pCJl4qjDHhzAYZL8Hk7Vxt0dM0XxQOr+DfQ+NS3jKc00TEAaebhrIfTRtgv+NvLW88eQY4qwCNvC9Xq2pUkdsrME4wGbFM0Fa5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742068363; c=relaxed/simple;
	bh=aphQV/JLsUSmCIMw81P/ge/EhmGuL13XJTzZHnMu+e8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BngCoXzqaWFmstz2kJCzEjivc819qteR1NKceufk1o5Z/0EimmH/tI1VTDI+BDcOrT0WhpY0q/9hHgEW/1XJneG857NnYJq5yLHwSYMNtFNu9/1XK+bVtF+D6A1kTtaJs0kKSJn5hWrAwG8LqBgNc6upsJ2Yy+4iQ69K+xXoUas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ke4SKZJl; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2ff6b9a7f91so222517a91.3;
        Sat, 15 Mar 2025 12:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742068361; x=1742673161; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RkSRY1nf3/CCgGX8CixRKz7GOQ9oD7FKwLr65/SUc7E=;
        b=ke4SKZJlb125Qx00IBmXCBT8lC1WO1ItOlp9HBvJNPb1ufa18va+PRRBYc+fjzF9ok
         OJmwVxJ04ccOz638EXRYTjA0+6AYhkYdxrAP5paeQCLmZamo5VD2ptOF3YGKLHch9nfz
         r2kFuRiSZPIUEaNna6XZ+5AOmJTV09O/lYHCkBtH88GT5QQPUPWFyX8kgxHN0UdL8sWX
         7eEz/AMut/hnkGAxkZvqKck1a5AZqb1JafYlNFbENlT7b6cxV1jt9NT5csxf5cRqjk5K
         Uzscz3VzJvcsj+McA8JoqYq2zTJXaEXEqhs8/qyb52m5yJCygdl86wuM3/Usq18J/7hF
         +lyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742068361; x=1742673161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RkSRY1nf3/CCgGX8CixRKz7GOQ9oD7FKwLr65/SUc7E=;
        b=Kb2zHlFl/1ahVag5QRAQdFAJo26zSqeKxIG2ozO0CJ0M1h7C5eymST+C8MaFYFWvnn
         Yg1Dx0D9yhazHOzr037b14EFNYEQnawmVZM4XiJJTcPgG6GkPbfXZEmkyRBTUUhm0toH
         f2PKlrrqoZJg0CiTAjyBjNqCMx54s93PF9RjeF6YU5hqQWBk4YsQtWhYU1NO5E8W3M57
         BXPrIPapXprmvej/OnFkk7JuUfawf/bpR8s4ahi27Ks2XsvuRMg8C0YGFune4rKuVXHt
         BOs9oqkDSpDbZyVa/YaEc8nXfh1afIDOXPEIk1t2O1BdHXonWKaxsJtQ/XFSjwM+fZzF
         TVFA==
X-Forwarded-Encrypted: i=1; AJvYcCUNiwXRqKbh89CIWRAgzqBDzmpDRykwX5cb19tysWG13ohwhyRfm5ELoKgKYQmsJgpWhlLBOP8LbnrWgUgR@vger.kernel.org, AJvYcCUm9osuNW9Nc6D7NUpokqe0pzhrAStZW9c3aNPPfI493HLGk6z6bclSlbUEI6DHxfvNsQVHxwSI4DI=@vger.kernel.org, AJvYcCUn/Fo5t/3IwjbgsUdQ9wIqaYyYQdH7A/Dzu6DBaaiw3aJ4B6ciEaqhDfD5fVF1vQjEiya7PWJA1S4U4aVkemM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3VLNGMxk7bx12ZFLZ/PI4HA6ZRTmXOIjc5q89t2N6m2NoZqOu
	FVVPaxDi40gbFo57LB08t+EisBMtXVAbntUkaErNvAkonNzW6W5fhM9ci5mwl6LP0Nly0t2HKIS
	BV88pNspO4KLe0mvwTMydG7bhnnc=
X-Gm-Gg: ASbGncuLCLBjPt/yvLVuEzqOq0+2ABxKQEXJ8N58fWcPp2xbeFwAa/tAGVqjfOlD+Kt
	PgvpwJ1gvmacwF9sypdTDNo3WCjT/6r3ADgp93uNz2PJ9szihxIglx52jd3HLCawQ1t8BVEv51u
	fXX/p8jf7VcQ6VOrx0kEegLu9ZaQ==
X-Google-Smtp-Source: AGHT+IFxs4He+SBXrB/e8968d3Baar4MKu0CcOHNfsoZUjb9jwXqfRgnNLe0uug3mxIerqMFsB0azD9mjCBGHGObzng=
X-Received: by 2002:a05:6a21:9189:b0:1ee:e99a:469f with SMTP id
 adf61e73a8af0-1f5c12df14amr3661527637.9.1742068361121; Sat, 15 Mar 2025
 12:52:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250315024235.5282-1-andrewjballance@gmail.com> <20250315024235.5282-3-andrewjballance@gmail.com>
In-Reply-To: <20250315024235.5282-3-andrewjballance@gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Sat, 15 Mar 2025 20:52:27 +0100
X-Gm-Features: AQ5f1JryREH9Epw5Czi-uWWexrRFhCZPOTW2A9z8mj-ycImcQLdxcWM1ZbztLgw
Message-ID: <CANiq72mLX6d9wYGC_OfQ_-0SKsjM85hP=X5n9qRwx5krNw1NLA@mail.gmail.com>
Subject: Re: [PATCH 2/3] rust: alloc: add Vec::resize method
To: Andrew Ballance <andrewjballance@gmail.com>
Cc: dakr@kernel.org, airlied@gmail.com, simona@ffwll.ch, 
	maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	corbet@lwn.net, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, 
	acourbot@nvidia.com, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 3:43=E2=80=AFAM Andrew Ballance
<andrewjballance@gmail.com> wrote:
>
> +    /// # Example

Nit: please use the plural for section headers.

Thanks!

Cheers,
Miguel

