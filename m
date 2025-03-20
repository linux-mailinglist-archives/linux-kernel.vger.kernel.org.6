Return-Path: <linux-kernel+bounces-569263-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7F6A6A0B1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88428189E6CD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 07:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA831F4C96;
	Thu, 20 Mar 2025 07:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="137+w+Jj"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58503191F7F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 07:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742456815; cv=none; b=ZaXcUSCtnqXXnwxAiXJ6Hv3hfMfSKzXRVsg/q5zFD9VY49/3UsNVcb9TkAgkSi7dajtbj/WCFQPPMkD4BrwiGIC0dFIVRFy9bE/weM2EmMMUvMIQkvtM7t793dM2wthe52iUMGejMJhyzUAiSy2rnf3fx/8PWkdwITzoRz4Wa6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742456815; c=relaxed/simple;
	bh=gj0T5HuZKUF4LsyqYn4Oi6dgRfTp9BHyFdoHpQ/q1xw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lKCcuszpmZ4PjG+Vn8m6Mp1XEh5ZsL9Q7Rcoy4fMm/OQGuX9xU4IYjVXFc2Mc+kS3L+oAUd+znVb7DhDI42exJUCI8cAtZ/HskgyB4TyuW7FfeEWYoOYFu95Ak8crEgUiQBUauXidroPfUNii2gsRSBUqaEG7OYltl9ZuQoswzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=137+w+Jj; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43d4d15058dso828405e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 00:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742456812; x=1743061612; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RWnZOZ4G2UEQUs8BB1HUlPKLt/pxBX0R0xeUfMvdz+o=;
        b=137+w+JjAsT8S1thfJb8gkG4RpmM74D4J7K13fU6pX4xCGmi6w140CHtqg45aDa56U
         J+CvBClmOgpl/kADguZoAOuU4QFDyKx80g6LmYbejOqPgowxnY1ki+HHHOROu7HJXTe+
         tbkJUsNerzzBdA6ox0gNCirUrD+ELJgZ1gZBzL6k+X14w7flcSYorr6kjk/cNCIgNHZq
         Nwj8uMBYrK+N/cB9+SIGbX33b81MXEZHxWGRmhhx475BwFP+POJvQPBZDvmIlgwnD9f0
         tPP1JuZnpOlwhpReE3dpDwUyuEc+Ux1DPXhX1UvQvOOCH7vgG6tZiTDeKWPddJhmTuQo
         MVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742456812; x=1743061612;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RWnZOZ4G2UEQUs8BB1HUlPKLt/pxBX0R0xeUfMvdz+o=;
        b=AETsmlRIM7F2+XoAxUE7GLWNqR4v/KAStrek2Q4Kk32S5oRXfXfNh9LmikPZtOy2t9
         h05si7gGYNQFq0XZm/0gjo/dbq8VqrlLJmKwZhXNP/tXMxWbREVjfD7hVKlTfIlI4rci
         hiCH1djfHEN5UtjzpbGcK5suUzV9yPa1SqyT8lyzZ5ueunb/NEWS0aKeudclwrdB4C+e
         4uJaq/VTjfEJeAA9y3GnRYmPzacETitI5hYbpigRMvbB4v+EZzPR1/QNpwxP2m/aHERK
         ufu2vTu92MjlLQnim7matHm53DIevMlNIe/Nd3h7+pKCBFwI6zbe8JyuAjmiwo8nYu+n
         UHdQ==
X-Forwarded-Encrypted: i=1; AJvYcCVgBXeKh9u4K6hOiM8X3/Fhq8VqDIjOWtIEaFIhP8U7GXA0MT2XsfA5IC3b+lEYF+pTiPYhHhAP1QA6RT0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1vfqYFo9djUnUOwXiPVO3NTJBw196z11fYH13QElt0e1dZdjE
	dhtaKUskZQp9+NYI1R9JAv62I/4JRWTRYWgpoEDtGAgMhqUGEKQg9wHq5Y7kEnoOObUxkbqXrys
	ZKv1Mn4YiQkaHZw==
X-Google-Smtp-Source: AGHT+IGPFtgrWNwVI2qhejZwBO5cZfS5Ix8SCkNN3ywkYIRQi5Uz0gg/ddHWAw7vDTz/ahAJLiPwu/mwevGIzv4=
X-Received: from wmqa14.prod.google.com ([2002:a05:600c:348e:b0:43c:ebbe:4bce])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3508:b0:43c:f513:9585 with SMTP id 5b1f17b1804b1-43d49547751mr12399505e9.13.1742456812739;
 Thu, 20 Mar 2025 00:46:52 -0700 (PDT)
Date: Thu, 20 Mar 2025 07:46:50 +0000
In-Reply-To: <20250319-pin-init-internal-quote-v1-1-19de6a33a257@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250319-pin-init-internal-quote-v1-1-19de6a33a257@gmail.com>
Message-ID: <Z9vH6qSAx2Hps3SX@google.com>
Subject: Re: [PATCH] rust: pin_init_internal: fix rust-analyzer `mod quote`
From: Alice Ryhl <aliceryhl@google.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: Benno Lossin <benno.lossin@proton.me>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Mar 19, 2025 at 09:35:40PM -0400, Tamir Duberstein wrote:
> Replace the `#[path]` attribute with a symlink to work around a
> limitation in rust-analyzer that requires all modules to belong to the
> same "source root". This allows code navigation from `pin_init_internal`
> to `quote` to work properly.
> 
> Link: https://github.com/rust-lang/rust-analyzer/issues/3898
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Are we allowed to have symlinks?

Alice

