Return-Path: <linux-kernel+bounces-551164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B03A568E3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 14:27:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 362081893A14
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Mar 2025 13:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B000621ABDA;
	Fri,  7 Mar 2025 13:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lMDNUjQH"
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1D1219EAB
	for <linux-kernel@vger.kernel.org>; Fri,  7 Mar 2025 13:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741353981; cv=none; b=CJlJUocoZv7AReQmexF0q4c4ziuHJKc90rHNHpCAtE2bvPNzq46lF/0j8gLzp1O4fWVZZdIc4I89L72l//vs+yu93duXT7GnS/p2Wz8SrMdoxPOjXz6rBA4hSxLj1u+enpWiTj02lcBOlXamKQpJIcoDVSGB6AQmLW85/K5Isjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741353981; c=relaxed/simple;
	bh=i/Nd47neKspIbrpCGTysdhYwJN/jpzlkct1vJ8I0ugw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Pyv05sSe7UGKXe3f2LuLXeBFafS/6umsxjNh11VM717cIa7HwnfPoC0Yq1/7vviokatBvBq9WPbCNV9+yrO1/Z7KlXJn9wdnUK+ORqjWp2o3Yedex3vzPIBzufByzpCHGkqgjDdY+qxsDsWht4oAlE0YswGf0lBSqeHUSXFmTbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lMDNUjQH; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-43bd0586b86so13025975e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 07 Mar 2025 05:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741353978; x=1741958778; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=sK8tKr89R3hEy8Nz4X9L555xpgSDTxpTa0yPlA5H/0k=;
        b=lMDNUjQH/kpEAmmjdYvFYDqkRbM1NIrQlcR5+e5MqHsQljPYfXE3MkRYx/ISzTy5+v
         vmpWGlpyfdkKwZSlwO+CISTc/NcXSixYw5s9G8cU/BDH9a9toYOk2NxOQLXcGroP9sc0
         fy/1bx/3cvjMD7X0dTMeM+0dnNsDPiP7XCwW8qv/1JfT0RTVj/MJ22sg71nBUM93V4sy
         dxZfl2BRnDOyJTQW6RsZ4uxhZgqOJYpqIrfPVHVXh9LKpcbKOEa+7AaF2owx/l0ELvfd
         pScMDbLPPO8XOCk0VF7/4x4EFsrqfX5Bk6RhyG1lLpFlMc9CW4LwDNvHBhE4tGjLC+mZ
         e7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741353978; x=1741958778;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sK8tKr89R3hEy8Nz4X9L555xpgSDTxpTa0yPlA5H/0k=;
        b=qhOY/+Y2PfPkXcRIuvZ5aN6a76mGCNLEjR+xXvBVafFq1SJbvbtNTp40Ywdc1JDXru
         pFWJOulxAqQlOAXpdvelIyKyR4onY2hvIqiy2wurQFJSQ+7psLn3LD7nV6hsjPgOdi2U
         ijDaJCi6VN6DrGsB8GVVuZb04Qx7oM9Y2aSYRUfVa/ySMRnbMAGC/OO/MJMtoBCbMlPY
         Kjf0SOMR1JSDCWFS4CN5+s4DTW+2Qe4lflYH2BkbFbpoSEeuFRvS5gNs/XZvgzaFBvfQ
         c05PSU3NmPgLb+WXJ9Lj6KfUDzI9ET4ALCPPL7vppl64ra6/7IssuS8AHI7DvUvTiK/D
         /IEA==
X-Forwarded-Encrypted: i=1; AJvYcCWPVadnt4GsawC1n9ry+wDXBOeM/FqhubjaPeW/BjAEuRduxU+5EQPkyeWlnesHSCIxOYSyklDga7VKN0o=@vger.kernel.org
X-Gm-Message-State: AOJu0YykE6w5CUapBhBT9VYu+HPt+gx3pA7hA3XAojsf9QpMGsDnI8OA
	zar3UK5LZlLynD9zw1H5WFm40vnWMAxZtSNflS0gSPv/16/m7czPE8qT0ESpFKgyN91Jy8X5vsR
	yfMQnmCOtGIPloA==
X-Google-Smtp-Source: AGHT+IHD2hPdViwRHmZBv75Fs8RZCsKFOeBeHbYroGDlwM5dRIq4MeJ+VqXbFaA1Sy6Oi5WcvmL7+mxRBt3lsKs=
X-Received: from wmbfl19.prod.google.com ([2002:a05:600c:b93:b0:43b:cfc3:aabb])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4750:b0:439:9828:c434 with SMTP id 5b1f17b1804b1-43c60ae9832mr21207035e9.20.1741353977854;
 Fri, 07 Mar 2025 05:26:17 -0800 (PST)
Date: Fri, 7 Mar 2025 13:26:14 +0000
In-Reply-To: <20250307131401.638820-2-trintaeoitogc@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250307131401.638820-1-trintaeoitogc@gmail.com> <20250307131401.638820-2-trintaeoitogc@gmail.com>
Message-ID: <Z8rz9nrY7Yj1Z2hP@google.com>
Subject: Re: [PATCH V7 1/2] rust: module: change author to an array
From: Alice Ryhl <aliceryhl@google.com>
To: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>
Cc: a.hindborg@kernel.org, alex.gaynor@gmail.com, apw@canonical.com, 
	arnd@arndb.de, aswinunni01@gmail.com, axboe@kernel.dk, benno.lossin@proton.me, 
	bhelgaas@google.com, bjorn3_gh@protonmail.com, boqun.feng@gmail.com, 
	dakr@kernel.org, dwaipayanray1@gmail.com, ethan.twardy@gmail.com, 
	fujita.tomonori@gmail.com, gary@garyguo.net, gregkh@linuxfoundation.org, 
	joe@perches.com, lukas.bulwahn@gmail.com, ojeda@kernel.org, 
	pbonzini@redhat.com, tmgross@umich.edu, walmeida@microsoft.com, 
	charmitro@posteo.net, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="utf-8"

On Fri, Mar 07, 2025 at 10:14:00AM -0300, Guilherme Giacomo Simoes wrote:
> In the module! macro, the author field is currently of type String.
> Since modules can have multiple authors, this limitation prevents
> specifying more than one.
> Change the author field to Option<Vec<String>> to allow creating modules
> with multiple authors. Additionally, rename the field from author to
> authors to make it explicit that it can refer to multiple authors.  In
> modules that use the author field, update its value to an array of
> strings, and also rename it from author to authors.
> 
> Suggested-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
> Link: https://github.com/Rust-for-Linux/linux/issues/244
> Signed-off-by: Guilherme Giacomo Simoes <trintaeoitogc@gmail.com>

I believe I reviewed this on the previous version. Did you forget to
pick up my tag, or did you change something in this patch that requires
a re-review?

Alice

