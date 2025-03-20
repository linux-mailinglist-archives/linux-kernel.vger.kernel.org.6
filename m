Return-Path: <linux-kernel+bounces-569327-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D27A6A186
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B89BA19C1880
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087AB219312;
	Thu, 20 Mar 2025 08:36:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="n9t8kuQk"
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C9C20FA98
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:36:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459800; cv=none; b=Bgcq+mOGlY19CBMWTi65s4GFQk9ELPHJibpplxYidt01uPAVYeM+OSJJqUneukvHXJ5tgLj122EUEfc2dUxzDZw4XXoKCQaBkus3QyFWk8WPE8a6WogSQg2612/3Wh2H/YEzDXkvabXs58N8Ppn7lO6s6ZfXf/A7FnJEqWJ62jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459800; c=relaxed/simple;
	bh=uUdtpvZVON7BlCg8C1bUw4EGV+nvS6TOedE2ZoM7ztE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A3RJBRnGFUkWdS+Cd2G+YVnvgCaVd7b5gXEnj/agNhRvt3s/g/v+i6F57n2mkTBbyHmOdfBvfOEFhZqPyi1WxKEgKK3ontI7tuNq5WU73n4AxKtLOd6C2q/W9HIEdjeir80fF9Ffl235BPUoOSQW4o2bYoBOi1TkSY6lTEAhmwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=n9t8kuQk; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-43ce245c5acso5406995e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:36:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742459797; x=1743064597; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yFIMGOYH7y3C8PhwT9bCF8sIzwdxvGBAVhS2YrPnTd8=;
        b=n9t8kuQkldPD5aZJBYEi3nljPAqSmMWjMEbPdojFDyw7mJkR3hibQmo13Zf53sHF5M
         mQ6SVLlhy6RaOR8zMh+M6SmukmV/SLF64nJnzvkHcFCe0+esbf0OR1hVLZEi9/a8pY6b
         aMK1VDxcq5hTWXJG2G3jWJsGcX3LELl/8RBdwjzcAtYLKh/MP1koracNSsubPj8ukuMP
         s7D2KFnvmZInzXQ25ieeEh7Z9J/5ZXGCPulDT2pXuloT+e7VDlDRYOfAmZLM0YUcBs26
         Au5QJulgqrSJTFI60ka1OtmsxRTuazY9SygtCS4g3WlmXTKtTSWQ7twSBMFqGsq3kixa
         z6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742459797; x=1743064597;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yFIMGOYH7y3C8PhwT9bCF8sIzwdxvGBAVhS2YrPnTd8=;
        b=G8oMR8CQurKjGRvVtiENmWrLskQxloGLK5CWckgP/I9XCt6UbI4XhQsVGz4KatXDfx
         rA3lcl9oFuKOSb/GLKXnQq0/Re5xA4pxdfJe03YuTWZkkCRCwj3kbzasGRU73jg15tFi
         ZwQlcJe+YEkk+eZvyj0UPMSy+4HudQwSQ/AhkqC+pcjLwZONA77ZxEl7aqB4Z/qWrreQ
         x/G4nEfSqJAhqH3qGmfUwi3FqanE/s7fx/9VJTRMJ/rjzEbcEkBbw0MmneUikSmrcJT1
         OdzqIJvXUXcKKiC0Kzb5JLA5n8fdFPdvbjsQF4scNUgkDlUfJ+OWYnkNS7umbiIEiEej
         Rt5A==
X-Forwarded-Encrypted: i=1; AJvYcCXFJtjKqbYzSHhpYOLXWNa2ndRZrCjIMigpCVeCihn9j8MsNCljY3+7IIQbJDaSHbKMQ+rmzuFuQG8ZALY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBN8MucxEb+rshW8iGEV/c3PkipGG2VhbDIQLclBAI+ae1DB0N
	UrfkLOv3yVa0MYIyDu4CoNMJoKwbOZ8cgCKZdScB1M3la9cQwFwIYS+JHH8jVHGeyw5vGOYWney
	9+lm1fQ3SvPE4Yg==
X-Google-Smtp-Source: AGHT+IFH1QXeB5i9lept2S6Sa6wweQ1pkpeU06zZ96I7u2P4VrMZC3n7NvYipzi71RDjJd6MGyhA3Ey4WFom9Xw=
X-Received: from wmbgz10.prod.google.com ([2002:a05:600c:888a:b0:43b:c9cc:b9b3])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:ccb:b0:43c:fbbf:7bf1 with SMTP id 5b1f17b1804b1-43d495b084bmr19680055e9.30.1742459797197;
 Thu, 20 Mar 2025 01:36:37 -0700 (PDT)
Date: Thu, 20 Mar 2025 08:36:35 +0000
In-Reply-To: <20250319203112.131959-4-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250319203112.131959-1-dakr@kernel.org> <20250319203112.131959-4-dakr@kernel.org>
Message-ID: <Z9vTk5aUB8Y5TASG@google.com>
Subject: Re: [PATCH 3/4] rust: pci: impl TryFrom<&Device> for &pci::Device
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, tmgross@umich.edu, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Mar 19, 2025 at 09:30:27PM +0100, Danilo Krummrich wrote:
> Implement TryFrom<&device::Device> for &Device.
> 
> This allows us to get a &pci::Device from a generic &Device in a safe
> way; the conversion fails if the device' bus type does not match with
> the PCI bus type.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

