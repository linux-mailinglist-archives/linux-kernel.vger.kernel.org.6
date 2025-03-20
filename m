Return-Path: <linux-kernel+bounces-569329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DE50A6A188
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 09:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54DDF465365
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 08:37:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A17214227;
	Thu, 20 Mar 2025 08:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X0Dc/mcE"
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD4C20B7F9
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 08:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742459837; cv=none; b=fPvXbT8B/656echcWy7VtRVkkOiUO32RF7tqbwXkP+uPG1Bxc88hcffEwXQEp/J5r6uksWRgJJc6r2w18q4QWI8aYRDK4ssfg5a4kf/HRl3iLAIVMmJRX+WJt0rqb0MOWqx6iB4auRuBNaTOjC+XRUQUuT/H5tG/zqXI9DAMoI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742459837; c=relaxed/simple;
	bh=7TetEMynBoINrTYyjJw5+oI6pd6od3UUHaaz7qU6eMA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DxXosJ7ES2oYYD//EplbqQ4rDOXvOCD633EohtZ4fZSIMzCvHZwWW6IHsszubzYIVvskjSi51C59LObn6GyNwagVixg+J00K/qWunoSDLzDrwXkfBFGR+PRW9/HlzVHIFDN3/uRRE84aFkFC6ShbIAVxgl9FZYK4CcLv58e9CIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X0Dc/mcE; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3913aea90b4so214939f8f.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 01:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742459834; x=1743064634; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=GPIWUDVih1Sb5uTelU2ivnCNtpHKvDoc/ZssNjFyHts=;
        b=X0Dc/mcEQl8ue/o3pMYoVVjEzFC2BhNhu5yo3IgcHidLsvJiCh/mMvbQ+oBtdNnd6y
         HULE1fqeS68FZeNLPfymdKpqZeIDI6nq2xFjxrdaRoz+ZPvAgyzwCRMkmS1dJbj8twxP
         u4qfzTV54TbJRQyJTBpV5Hw/dr7/RcX9rOHSyD/W22GeJqOfGcZ/+7GmtQDb+mS7bq83
         Qr8HxKlayAt/BLuKMyR8YQHbNFaNPVZ4Pw1xFewuAk9pa48jTRtaDeEVziCx3Jlre/oW
         mfWPT4wrrwu7PZatTcbYCFlHARsA/IpyYcPEy2llulqvwryzm6q7qc1y0JdcK+U2Ktvf
         y8XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742459834; x=1743064634;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GPIWUDVih1Sb5uTelU2ivnCNtpHKvDoc/ZssNjFyHts=;
        b=c+IVfm847NWZ3SngC4gSFdrCP7gDn3qV/MA6J1TwmPydubTZ0DXNBbVhyYf7y+O9cV
         D6GovJOLmsCIoflIIZ9B1aReVgBngEglLJBf8szxSiM3OKO8xBpNBqmjaIv0palL3IMv
         oz4h16g03/jiXi/+NV0aKtcsKovm/AbjkcOL/Bp6nNQFoYF3b2h+rBEESBwv3RcDiarI
         TNzdw4OBkZ6JQ2VcgNNK4ejuydjhj+HN/7nCt2mONJTRDg9+jQVZvs61MRauq3b4rEqu
         YhqW7ovsjJfIaZE3qwrDac+0oOpGj39Y9ibjLGLsa5Ap5oY/DcbwCmsaXbtuy2IEcC2a
         Ombg==
X-Forwarded-Encrypted: i=1; AJvYcCUsB0MccKTvq6Lh3b5oFjYtJlpzXE2KvQTHSgRx3X+PkrO2VFZajX4PdWCMCSvslzLO3433dw9dlozVFk8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN9Yi3EXuAYFquMB6jFo573zm4pADmd4Ka0WPGE4mjfQOTmvwy
	gkV2YmQsJexBeI3C3+dLCQARXooeZLdu3P/Ld0Mx7V9cyE70SMLxhmKtqxU5cyOrfZxo9ZyHTM0
	J1+ZgB+WZISzJig==
X-Google-Smtp-Source: AGHT+IHuZ/wR4qWvGQ7/uSH0SsJWVQsfNb9EAzn/4o40D7wBbbwOean1AjWxFD4wZ1ijuUOd9CO33V3YtiCdOBg=
X-Received: from wmbgx13.prod.google.com ([2002:a05:600c:858d:b0:43d:8f:dd29])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4025:b0:399:7916:a164 with SMTP id ffacd0b85a97d-3997916a1a7mr2988222f8f.31.1742459833932;
 Thu, 20 Mar 2025 01:37:13 -0700 (PDT)
Date: Thu, 20 Mar 2025 08:37:11 +0000
In-Reply-To: <20250319203112.131959-5-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250319203112.131959-1-dakr@kernel.org> <20250319203112.131959-5-dakr@kernel.org>
Message-ID: <Z9vTt2A3eiecQx4e@google.com>
Subject: Re: [PATCH 4/4] rust: platform: impl TryFrom<&Device> for &platform::Device
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>
Cc: bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	a.hindborg@kernel.org, tmgross@umich.edu, linux-pci@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Wed, Mar 19, 2025 at 09:30:28PM +0100, Danilo Krummrich wrote:
> Implement TryFrom<&device::Device> for &Device.
> 
> This allows us to get a &platform::Device from a generic &Device in a safe
> way; the conversion fails if the device' bus type does not match with
> the platform bus type.
> 
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

