Return-Path: <linux-kernel+bounces-553888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DEF1A5903D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 10:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62DD13A4480
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 09:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B18AC22541D;
	Mon, 10 Mar 2025 09:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BsKuJzZg"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1102253ED
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 09:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741600208; cv=none; b=RwMFRsVHH0f5qQSjZ1uMo0jnP3+CcnDUDOHJ97Yde5JPLLMD3ANCJ4szCBJBF4pSLUhR9cjYSmkEiCEDOHS/YiFJISMsb/e/cTjM4sCZEjO7mNpXsgHYi89VRLj9iauL2g8PBnRjcZoQ/4l+KZJ1RJdqVVTPEX4oH2pb0A0+/ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741600208; c=relaxed/simple;
	bh=li9maBtZYH0WSwQ7I4Sx8a2w/PrJcS0hZ8B1pMYw794=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XJYuMCH7Dlwqd9rNt/myeysIqR8IepA0I2Dv6zLcZjYpvQFyFq/i1QVADra57CECr4aw/lr3rsa5vCjPpLv81u1YqRbVEJzRKltRg3m1Ea/e5ZzZIjC9o4lbei/L2pm0NJRPf1xjHvlPJ3GGFwnO0ggHOFaIY2oMkTN1Me0CcR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BsKuJzZg; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43cf446681cso4209705e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 02:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741600205; x=1742205005; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zayc4ME8ub10z847YBIo2OSP/R7y2OfUd/FH2hrf0YE=;
        b=BsKuJzZgNkMN0gd1ldRnao7dettc3eGf/7vIIodjJYuAbZG7YPu9881ujBtpDvHaWl
         PycahbH5cEMd7VP+CXIBku3jnPe4vQrHML8r8AjUe0tNxPYd6G2knFp1tdYpwODjYdSw
         DtrnZA1AG7pgpZ2E3T+5H9sT0v02/W4CR4N55PmrJZZQiXDiFQW8I4XUl7M6m1bHxP3l
         uRLg1Ss8N9vPuspEilaBC1lcdYKm5yAMqZbU6rE+2PiO5IPemGbZ7++Z7I2gHaW03e9V
         TOxCUbigJgGdpkVe2qcAuEjy0Szz1TXkuxYwPFwTEqLoRsMsC6XYMM9kLPIEeXgFAy6C
         gU7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741600205; x=1742205005;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zayc4ME8ub10z847YBIo2OSP/R7y2OfUd/FH2hrf0YE=;
        b=W7TUdEs7J/SCeuNcG9pK2W2InizAb3KwTQBxFi6P45bGHEIImuZ6G2mkzVZe0PblFi
         Yuao5PyOTvqWtd8xzT2WYbgkIOr5sZDswo4EO2HUTKmmaYGC26mRAOfRj/NkiD61QMDX
         GxwSeH4H1wsn/hxcbaoG5NyLkk7cesQV4hJooam2XY9wPD7i2PES+3gG8ql2wux6tdBd
         3OtvRRxUyaKuuH3LVUxzMb+caRR7vwBZc+An47R/44FYbGznN8spCudkBovNxvw57o9W
         Zh9LKYjvfJaIlmRryKFIZp7BLwrejVHlIr4qTetyYLae4MnwgDcWrcquJdwoLZ8RZ/rP
         8Q1g==
X-Forwarded-Encrypted: i=1; AJvYcCUvyHR2ZBhtQihZszjti5WGoMFPMM6dfTevl1LgvhiiE8nUUWHwCxZuwszcemdoJfz4wfY0IO9R9iDVtLw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyELzDXIXgk7IxTAbcd/Z/9EulBD3JR87iRc7jqaROarKftq+F0
	gjRgJw4HQ52KZ1WMGoLLFEiK6efp7bwQdolhUCAuS0UQZxe5tiBe6BHHVPzQRPh6MtDdLvpJ8yD
	/vtGGSc6iMRwqcQ==
X-Google-Smtp-Source: AGHT+IFh6zDOg5JSQ5hBks5Kv2fA7ferdFCU+xaQli8NpPVCQgSZ8GXEKmfHPKiJ2GFqReRUcUZjB4F9g1Vim14=
X-Received: from wmgg17.prod.google.com ([2002:a05:600d:11:b0:43b:c336:7b29])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:474c:b0:434:fb65:ebbb with SMTP id 5b1f17b1804b1-43c5a6116f2mr81052195e9.17.1741600205067;
 Mon, 10 Mar 2025 02:50:05 -0700 (PDT)
Date: Mon, 10 Mar 2025 09:50:02 +0000
In-Reply-To: <20250310-unique-ref-v6-1-1ff53558617e@pm.me>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250310-unique-ref-v6-0-1ff53558617e@pm.me> <20250310-unique-ref-v6-1-1ff53558617e@pm.me>
Message-ID: <Z861yk1hRZUtLtLp@google.com>
Subject: Re: [PATCH v6 1/5] rust: types: Add Ownable/Owned types
From: Alice Ryhl <aliceryhl@google.com>
To: Oliver Mangold <oliver.mangold@pm.me>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Mon, Mar 10, 2025 at 08:49:43AM +0000, Oliver Mangold wrote:
> From: Asahi Lina <lina@asahilina.net>
> 
> By analogy to AlwaysRefCounted and ARef, an Ownable type is a (typically
> C FFI) type that *may* be owned by Rust, but need not be. Unlike
> AlwaysRefCounted, this mechanism expects the reference to be unique
> within Rust, and does not allow cloning.
> 
> Conceptually, this is similar to a KBox<T>, except that it delegates
> resource management to the T instead of using a generic allocator.
> 
> Signed-off-by: Asahi Lina <lina@asahilina.net>

You can't send a patch by others without adding your own SoB.

Alice

