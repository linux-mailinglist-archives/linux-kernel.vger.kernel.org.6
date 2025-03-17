Return-Path: <linux-kernel+bounces-564052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 041A2A64CC9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 12:34:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AAA391737EB
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 11:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8356323643E;
	Mon, 17 Mar 2025 11:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PZls8em7"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9240922FDEF
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 11:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742211266; cv=none; b=jY175rJXBrfk8/gJliUVLtm3yEoNItjPTtThoieCiRZZAwujq5PaXX5x40qYbcZVB8/thMRkFWG2MlUQ/l0/7u6DTOXiPr/uKqiWeXq4oZHUFmBuZrU//512yHqejaBJQeeLV9rTqZmrGvjTOjojDJx/4NLfvVdo6uyHOWJhDcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742211266; c=relaxed/simple;
	bh=kUqKDQgLk0lOWoo6zrn+sqGAWOd7NqDnkn6MpEGZ6gA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=SbXMa48+AAJDP1aH7ZkIxRZklFLdAsIVZrtCDttohutXk6UvBH7wCo2aeJ0JoAKr3Nr6lQdhBGwecy4Q2UmRWn8F01Bc/Vx0uGckEPDvjyCE01PGNhVTIgTnjzUlrrYJntbVXE6qCcXqIZXhEhvfRo1wayGrw4Yrmx7spgFXnAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PZls8em7; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3912aab7a36so1821118f8f.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 04:34:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742211262; x=1742816062; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Do8JoGx6228gB3AaeuIbJ8FMOfeiMmC+G1ZJ0ZLZmD4=;
        b=PZls8em7sYXuGLx3ZEiR2sKAN35ozEgp9WOi+cO4RBZu7ew1SOLJnuz2GcKbCOE8Tk
         xd63YRJgkAbIAH5dn5Jl/0FA5bK4n4yXgBQ7PkeWmqmGCAN089DqndVOFbBfHWQksG7/
         SFO7/brhJyBplHDMsdmxFSe1AhSCVyf6OZIViTtJYBMbU1GKghHLRHRPYKL9R2wBSlRw
         6yftpPHikiyVanZdwTsaBFc2vgElg3tcpiS62hiMl4pqXFybkAfMaXzmnAJrQharhfvO
         XFeHxhTl3l4Ym1TSELmmtnGHt+YcHqc7uSewpjzi77k+hEvjnueaR2Nw+8v72rwEulmH
         88Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742211262; x=1742816062;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Do8JoGx6228gB3AaeuIbJ8FMOfeiMmC+G1ZJ0ZLZmD4=;
        b=W23TOVTiAo4X/odTEw5mTe/rqcG/jekb64SfZrgzn5PAG2519Ql41AjzCZoXaUgMcR
         +9F1GM5R7EvdaxH8E4u4KcB6naaHz00for/Mse70oRSjdSb36JMD4ujb9Jp20zc7x3Dp
         gSfmyq+2pcolx+5caa+RPyOxqWBMnCYsCg/zgW1IK1MVvntmWrEfQ2ctZoEJ6PwOvS9s
         yg20OBSHUU9FFWtvhm87qPV2jvEVG9XHLeM+/kzc/THW+CJyNOGZGuvhG9igdUw2MSAa
         z391WieRhdv3/KF7jB4nxtKLvQIbEvsEIZJnEANaKHy7gIR/X/IIwtacbm7cCi7eV6Ot
         rMmA==
X-Forwarded-Encrypted: i=1; AJvYcCUKvj+ZIRjEpplvLEY2cilPE0ER2RWLmRMP4AIb//KAvb7ZkCJC6ZUdqNGP3R9kDB0zjxvgHVItk86znb4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywae4yor4TLv66I4SfhgsycImT1eIa6NvR7KOrEVw/SHVwRdwFZ
	4q0WSoGvoPjXJYPbqyB7MpRXwpeL10Yvx9Hl/RN0INRWwGc+n2uwPMPW3RtE1RyCMeSux1wBq/U
	RAH2Z4Q5HRQpbZw==
X-Google-Smtp-Source: AGHT+IE+GFK6aUT8VtO1YLl1EdSXwHkqzlvFnUUi4hpIx4yPr9yX+d9CU13yzl6NVw5N3FZBnQnLYgc2HRECFLA=
X-Received: from wmbgz10.prod.google.com ([2002:a05:600c:888a:b0:43b:d6ca:6dd3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:59a9:0:b0:391:ffc:2413 with SMTP id ffacd0b85a97d-3971f9e497amr15125196f8f.40.1742211262006;
 Mon, 17 Mar 2025 04:34:22 -0700 (PDT)
Date: Mon, 17 Mar 2025 11:34:20 +0000
In-Reply-To: <20250307-no-offset-v1-2-0c728f63b69c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250307-no-offset-v1-0-0c728f63b69c@gmail.com> <20250307-no-offset-v1-2-0c728f63b69c@gmail.com>
Message-ID: <Z9gIvLY1uubS6OX-@google.com>
Subject: Re: [PATCH 2/2] rust: workqueue: remove HasWork::OFFSET
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>, Tejun Heo <tj@kernel.org>, 
	Lai Jiangshan <jiangshanlai@gmail.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Fri, Mar 07, 2025 at 04:58:49PM -0500, Tamir Duberstein wrote:
> Implement `HasWork::work_container_of` in `impl_has_work!`, narrowing
> the interface of `HasWork` and replacing pointer arithmetic with
> `container_of!`. Remove the provided implementation of
> `HasWork::get_work_offset` without replacement; an implementation is
> already generated in `impl_has_work!`. Remove the `Self: Sized` bound on
> `HasWork::work_container_of` which was apparently necessary to access
> `OFFSET` as `OFFSET` no longer exists.
> 
> A similar API change was discussed on the hrtimer series[1].
> 
> Link: https://lore.kernel.org/all/20250224-hrtimer-v3-v6-12-rc2-v9-1-5bd3bf0ce6cc@kernel.org/ [1]
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Overall looks good to me, but please CC the WORKQUEUE maintainers on the
next version.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Rust Binder still builds with this change:

Tested-by: Alice Ryhl <aliceryhl@google.com>

> -    where
> -        Self: Sized,

I did have trait object support in mind when I wrote these abstractions,
but I don't actually need it and I don't think I actually got it working
with trait objects.

Alice

