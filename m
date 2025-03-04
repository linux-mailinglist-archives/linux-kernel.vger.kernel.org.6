Return-Path: <linux-kernel+bounces-545561-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A55DA4EE98
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 21:43:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E25A3AC0AC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 20:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5676F2641D5;
	Tue,  4 Mar 2025 20:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="XGwAZ2uq"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 062272620EC
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741120958; cv=none; b=APKQNLFrT+G4LV5Ax8lFELEskQlVyl7e3sMbocjK4JvCMj1jnXry2tHVVXIFD/qhtca9QYQV4sk9cTohqy7A2bao5wMsG7mzFgVhgUcvap0Tuv9X9QpD//wDlcCE2YuPUo36pon4C/oBjoGOusijpu0Df+oFy7biOkvbFc1UfVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741120958; c=relaxed/simple;
	bh=hY3ox+Cv8L/hy1uWd2H+uDH/wZ7y6rjKqKarmY/cer8=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=nUpdiSZj53hAZQwmEr6Fdl/oQ04tv+I2mkS4wE7/4PbLhc/28zwsQtJurKiqH7uHgs8E43OrEhmAKQxJMMhm1Pc6yP3mdmYOWMmjayx9tGMhJyPkArEqHWo9nA7oUWgTPwhDHrsTJ6SofsH5F0qzKzai27327w9pH14Xzc6dEtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=XGwAZ2uq; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-47210ab1283so89485931cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 12:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741120956; x=1741725756; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R1qRuitdwwYSELTXdkDkMV/eQ1X4sgsaSnPBdxYSrvM=;
        b=XGwAZ2uqxdiAH2xE0p3xo9XIG3BZ8wSwL4Vgycku8YGLHMfJg3Z8BNOk46sxsDRbZ4
         EWC8F81xDdEDHpkpU0iMF1irO7cdwFqR+8pjY6SuCokEw4/NHXyhH+JPJZnSYop7qJJZ
         pWGbgQTX+iiX4l67s0kb956n0RDaMMhTon2LJI3NvQjXcxdCNg9Ygb2TZuoWrKG3w5im
         JK8hJCAGfP7gYWROVGPVInwp+yRyAa+zaBvDBZSFRv1GRNGtHdcnwUyYcMjjBcGuC+HL
         tkUaJRm9SaALtwiRgFgDpyBcX7FE0fOFFwR4oGxe3a2EkfIM4rzF0+Wp5/6iPdMszJEW
         w30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741120956; x=1741725756;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=R1qRuitdwwYSELTXdkDkMV/eQ1X4sgsaSnPBdxYSrvM=;
        b=Wo5D1T4B2gRH3isGS8DwcShAvXNyEu5N4Bef5rEcnATiGbpiVbXrc+cWgUSPnrEBM1
         0C6nBKPeVucJJapzlTLtXgmNZh9c9zhVVzUQ3oNBB2Mq5PdopCvQEW4lHiLUrhxv9rYs
         y/GQuMC0MClvb3j4AuL7QGIxI6d0D5GLGVic7Btq62CmdWdHbM0rRYd+oQIZjnEj0DZi
         T52QmxzNnTZ5P+iHgDBRH6N1QqEQjwb8cFmsay0wyroQidzISO2sc8/X3u3ctXBMmTrO
         E/WEYGsg7otw2lLMjdsUlH6w8UbJLjFJVYzy9x3efh5FiSI++rM/Lx3Mljnrk7ENAYmw
         iw8Q==
X-Forwarded-Encrypted: i=1; AJvYcCVncxZl83nG/Yi1xfY2hWym2hosPHdrW+n2uj/oYkKRiLiZSXJpB+YJijSQ81EucAIWHaMEHjIJE/WROZY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZMu0YopAm+yqaMJqxleMa0/KSMLuKjloNi1SaMQ4FYI5FB57X
	xBi29Bx9UrI6fqkiSdVkKJmxHLchGbAiWPfMPNgnL9efAe0989INfvMHvgq04g==
X-Gm-Gg: ASbGncu+otldx9HvbC/k0w1WXFn8rPt388VGVBxbK5qr9p9qHaAK26zOav0En2tk3JA
	c1Mtp6/sxI2bgqdakKyFwYrluxvm4QGVVvlXajkiD7B8JivtoRxxMyhuGlatZoKCMfyJ1EZSBEO
	O7ANBkR/XCA0VCbca/q3c3A2n4JfdBd9X8bokk5YdmwzoA3nXHZyiAXlRDyCeZdyvo8/q2iNl+U
	WtKnUH4JK2yfgE91zHVVB1u5kHcnwqqjYqc3amUbXGkoPs9olr6BCZO4dGY6fuFZjWUlGSBtjig
	+pRpogwv2E7wYfqaHgyyiYCtsRIXgMCuvL8bsT6BDu/GRD0Ri8ykcCUbwYuJhc2cvL4BdrJQ3J7
	kUucFbmFixYWyzQ==
X-Google-Smtp-Source: AGHT+IGGJzyx/Xq+umUg8sGni4KDBOk9xYnclv58VIy14he0JdzCkkSuM+jn28L4VU0r2ABS6Z+JDw==
X-Received: by 2002:a05:622a:1a0b:b0:474:f38d:58d0 with SMTP id d75a77b69052e-4750b245031mr8398401cf.3.1741120955860;
        Tue, 04 Mar 2025 12:42:35 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-474ff3aa7d8sm12524121cf.30.2025.03.04.12.42.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 12:42:35 -0800 (PST)
Date: Tue, 04 Mar 2025 15:42:35 -0500
Message-ID: <00f1cac46dcba6dc8e2e602674b55671@paul-moore.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0 
Content-Type: text/plain; charset=UTF-8 
Content-Transfer-Encoding: 8bit 
X-Mailer: pstg-pwork:20250304_1539/pstg-lib:20250304_1539/pstg-pwork:20250304_1539
From: Paul Moore <paul@paul-moore.com>
To: Alice Ryhl <aliceryhl@google.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, "=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v2] lsm: rust: mark SecurityCtx methods inline
References: <20250304-inline-securityctx-v2-1-f110f2c6e7ff@google.com>
In-Reply-To: <20250304-inline-securityctx-v2-1-f110f2c6e7ff@google.com>

On Mar  4, 2025 Alice Ryhl <aliceryhl@google.com> wrote:
> 
> When you build the kernel using the llvm-19.1.4-rust-1.83.0-x86_64
> toolchain provided by kernel.org with ARCH=arm64, the following symbols
> are generated:
> 
> $ nm vmlinux | grep ' _R'.*SecurityCtx | rustfilt
> ffffffc0808fe8a0 T <kernel::security::SecurityCtx>::from_secid
> ffffffc0808fe9a4 T <kernel::security::SecurityCtx as core::ops::drop::Drop>::drop
> 
> However, these Rust symbols are trivial wrappers around the functions
> security_secid_to_secctx and security_release_secctx respectively. It
> doesn't make sense to go through a trivial wrapper for these functions,
> so mark them inline. Also mark other trivial methods inline to prevent
> similar cases in the future.
> 
> After applying this patch, the above command will produce no output.
> 
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Fiona Behrens <me@kloenk.dev>
> ---
> Changes in v2:
> - Reword commit message.
> - Link to v1: https://lore.kernel.org/r/20250303-inline-securityctx-v1-1-fb7b9b641fdf@google.com
> ---
> I will also reword "destroy"/"free" to "release" as suggested by Casey,
> but I'll send a separate patch for that change.
> ---
>  rust/kernel/security.rs | 5 +++++
>  1 file changed, 5 insertions(+)

Merged into lsm/dev, thanks everyone!

--
paul-moore.com

