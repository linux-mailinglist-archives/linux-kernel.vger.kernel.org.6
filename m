Return-Path: <linux-kernel+bounces-567953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93CAEA68C5E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 70F05189C78E
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C8C255252;
	Wed, 19 Mar 2025 12:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="feKZdc2S"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2C62505B2
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742385937; cv=none; b=m3YBA+WmHHi/0hcgK+gSopaZ1YAixPzdZmhPA7vzRrLqTDf05fckX3rPOMDx/4S8iAY7CwNPmDOna53sGeM5tKXz8wS9iMWIMTSloqERFXVsBW8odORyIb4uleKobpP3OKRNuUjQdmF64GTw091RpGrwIFJlCk5hPI4aOBYISjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742385937; c=relaxed/simple;
	bh=/sgMUq9kyU4ZUSQimzoCzp9shmlalLR1UBW+34qXz2s=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DwhKa1O0LhXz5pftDS2qNnD1ndYVX+RfHIBNPUypfnjqFZVh+NTrQi5GjOlldDxiqRR9HL53S3CP9OizR7yN78Letd5XX5wvLjWv5rlirVkKhnqfqrySg9x/0SNBrt3hi2zdEyq1BYr5nEgrahNBJ4HKK1aCxjYz1B6Tu1kcLTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=feKZdc2S; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43d08915f61so25050075e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 05:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742385934; x=1742990734; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Afx+r5Luww/Abgd2iSJsqzRz7kjWQCvle2A8j07pIdc=;
        b=feKZdc2SrwdwXAbfZnX4Xrmd3/r/9NJiqSRG6NkLVzd0GIabC1RiN4OO8qmSIdM1+V
         v3AXPdKCUTo6UawHMiMShgZTg/OvVplbNI7Vil0WDb7FmoqhP7rVoeC2o/fAC78ECYDz
         KaxDMPCppca9aJmMK4xTGaiIP4LTsntvVIddgF5/sfY+wyaDZRVfIOzVlna5KbQFYCrV
         26ExxqmVK8bpWDkj5sHuOP6ey+icVbTm0A/g73bzyLOPTUPnnxUvd/ckPraP+EQqWzO6
         fjKJCR1R0VyD4skm+QloxqBzNueOSykyQPauJg7vbLM8P76dIwz9jGd3SEmc5+eQBpLi
         lhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742385934; x=1742990734;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Afx+r5Luww/Abgd2iSJsqzRz7kjWQCvle2A8j07pIdc=;
        b=i/4Kq+2+2mGFh9w+vwbugnlgYrQx1+7H1C/wSO6BFlavvMbAHRDE/WkNisinekdZe+
         2Z348pEK5U98E7smg41ipb46Yzed17cDgh/vWsMw0imO/DYKb93ScazFurHV3290VGoN
         lHjzcg+Ly3vu28jQFO2/PaMPyzQW8ZZJevgncGrpa0ZXOeuSx1HvMPk0yv4snWig2FlW
         lqCPAQKStLasXhDx5kO+ANUBRblozzszVi/daLfd6WAW8XrgtZ3Zjy7dSMqkHCCX0Ncx
         uX4G8fXm/XN/fNe28lp80STpJRSm2hKOrW2A8o1rI28Lv60Em3TZIbHISFpRhFTL/mcn
         tEGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXw1lx/TqwrKnOEAwvdDoz94+HP4VtKYJRd+oFeZCwmwIZadSDrJGZfJCizr0BndmYS2l4tB7FRdYm5Hrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyupsbXvZZyI6nOW1xjthZlVJ055Jlx9YoOuuyamjWIFoZEsT1a
	ATRusTOvRXyp925yX23xJXLnq5GApqUz1Vm2nqvtCVrTIPc1KHX0LiUV5APyi64VjvyfeZt9xJF
	4F1GUSzDEUsdy+Q==
X-Google-Smtp-Source: AGHT+IF4W9TrsaeGW9ftDK5AwQdh8v1B1xsNPi4MJVe6OyLmzGV662Yxr2zDVzBA/BPZdMbIvH+MLcJTtHS+ZYg=
X-Received: from wmbg8.prod.google.com ([2002:a05:600c:a408:b0:43d:1f62:f36c])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1f0d:b0:43d:ed:acd5 with SMTP id 5b1f17b1804b1-43d4378d039mr25931565e9.10.1742385933857;
 Wed, 19 Mar 2025 05:05:33 -0700 (PDT)
Date: Wed, 19 Mar 2025 12:05:31 +0000
In-Reply-To: <20250318212940.137577-2-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250318212940.137577-1-dakr@kernel.org> <20250318212940.137577-2-dakr@kernel.org>
Message-ID: <Z9qzCxlACKUgYstd@google.com>
Subject: Re: [PATCH 2/2] rust: platform: impl Send + Sync for platform::Device
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, tmgross@umich.edu, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Mar 18, 2025 at 10:29:22PM +0100, Danilo Krummrich wrote:
> Commit 4d320e30ee04 ("rust: platform: fix unrestricted &mut
> platform::Device") changed the definition of platform::Device and
> discarded the implicitly derived Send and Sync traits.
> 
> This isn't required by upstream code yet, and hence did not cause any
> issues. However, it is relied on by upcoming drivers, hence add it back
> in.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

