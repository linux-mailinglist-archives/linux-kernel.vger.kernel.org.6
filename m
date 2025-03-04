Return-Path: <linux-kernel+bounces-545667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F176A4EFE5
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 23:08:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17B3B1892247
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 22:08:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9208D264F8C;
	Tue,  4 Mar 2025 22:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="ChvdcD5J"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847271F8BC6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 22:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741126072; cv=none; b=BsipeZDa/TFOi8oHFo96ac2re+0CepAjurhG+0jaCsj17hCt83Ob8jC8VjmyIUt5hjxQvfriSl1rj2pLc79LoiNxTvmsrplmt6HZxYchJiGTErct7eMVIfKo3tZOfjWMe51QrE+52OI+JiS221yF3hvfbLi3CF3QhYjW9jrykBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741126072; c=relaxed/simple;
	bh=rYa8UwAmLiF/ruWm+7Ip+yWVFZ1SaMjS81Bt+resw34=;
	h=Date:Message-ID:MIME-Version:Content-Type:From:To:Cc:Subject:
	 References:In-Reply-To; b=jW8rJgoaL3A069IJms3tDjvynUQV3LA0QXiWIEPlZvETW6H59W16ZSv4Q8CbX7JsYNouOJ8MYyXIPRasUP0Y+zRcObwKxfpBdYLfnjqGwbwLBtnxkZbQUhN5AlPnHH5XdhV8in26JiJBZuKo3/Q2EFQfQOFGAzmtDitlCGW/rXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=ChvdcD5J; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-47509ac80cbso2872961cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 14:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1741126069; x=1741730869; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BKFucnJ0eu2hFoCdtrns3nmxFOzTMWGPnJoCE8LE9lg=;
        b=ChvdcD5JcW6GT82AZREdI9KJI5wMf9FHldqZCztGGm4XN/xNKrW3hnsfaFifNNI8Nk
         AND4RdlbUJoLC2IoFeTyDYV3SMdMgx9ZD+G25ygZaX09WbFNBFA8tbDaEuuVOPB1T27/
         0ZPBJfOU/kdBWwIIpcQ12Z5zj0bn85U3qGw3iL5Jk+OfXiNv+b6+pAxGN7CioqxCOn/s
         c4keFaTd394WdtGQfq4UEGbvuWQXs94As6WtZk4RGoybM+HV5WynToZX24Sr1mFHRVoM
         WOCe9xHTrzIIhwk5V2TBkZJKptNQ824nv1ih6ccKKb2tzfn79WNS6/bw+06kNKqMUcZQ
         Ru0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741126069; x=1741730869;
        h=in-reply-to:references:subject:cc:to:from:content-transfer-encoding
         :mime-version:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BKFucnJ0eu2hFoCdtrns3nmxFOzTMWGPnJoCE8LE9lg=;
        b=ATCO2TtVhv/18nI4Q4ARa9SyY5Uqer/GnYAhSYTNN7dbOvhy8CL2tvJC5lwfVgHmgX
         4Ze8HDZ2tQdAzfUmmeQD7fR9iJeWfbWEYkQgTwB2pDcVG31fAE1GmSHSPC8A8L0WMyVj
         rDwIUMFq33oCPqKboP4Eg0s90cKOfSiUKYtXKWHYyatCI1++NwfEtWxMq5xD2KgwLHpY
         oxsAT/nBWay455u8i2cpRtK0p1godmPoRljkl9KuOPXL+9G0eScnOtLVy18ejr371RX3
         AHQzO24vO1Q39MKMh7UKx53XRJHVzRVlCdxkdZ3b3FPoxvGoV7FRzWGBNZznpMKDZUJ5
         Aqug==
X-Forwarded-Encrypted: i=1; AJvYcCWyNyT531PwE2YMmEquXF7lsicB14ANifaE/GqL07OvHgWgDqfVfvCJkxARrcafNNwuA+8DawpYZHuAhAM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy9/Uys8uG4v5a1S5+J2Wpx/S7jpnOQ7+6JxfSsbc17GwaSZ4if
	e+XJKtnWHfpuV8pPU9J8am2RswQGBx3uCJGCO2kFq5aumziPP0Mc098wwwnFhA==
X-Gm-Gg: ASbGncucCNbGoOOigQ+ze+wvCLeiOD62hBrmhePwy0EIZXcPwRkO85de+3Ac7Ul2y3h
	C/vkzRZzJ48YImpDZKxWhLqpBNhWjjQdvFWEXTOztGF5DlVoLZ7CnehxPxaKb2rMC4HOaZM/XrF
	fn7GUkl+mLGJkZgX073QMnBpH5rfDGHI7r+CZWWIc6bBWovnm8K2HIaF4YV57oFNf8zylFbxLCO
	SrK1XLTocrRKQvfvXEC4woIXv3zU8iXWOLpG9I7tMJODLH8nHT3cOETaMCwizEIVTU5ogFfE2eg
	WapYp297jwDwnWJBiQwJE4D8SewqlU6Qf/E19gs/yqGHzqsTqh7ctzOr2urrwXP4zCVyLPs9mG4
	n4GRJtKrDYz+9Eg==
X-Google-Smtp-Source: AGHT+IGUzI53OHoAUblYM2qlVQBUsHxaboxVDz0QodPEH5dELjV4Uu9kfywXUTbmN5tYZHwecjh2Aw==
X-Received: by 2002:a05:622a:cb:b0:471:fc74:100e with SMTP id d75a77b69052e-4750b4682d0mr10512251cf.28.1741126069306;
        Tue, 04 Mar 2025 14:07:49 -0800 (PST)
Received: from localhost (pool-71-126-255-178.bstnma.fios.verizon.net. [71.126.255.178])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-47472431036sm79332581cf.80.2025.03.04.14.07.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 14:07:48 -0800 (PST)
Date: Tue, 04 Mar 2025 17:07:48 -0500
Message-ID: <f52b83c88d715ac3ae989427bcc20030@paul-moore.com>
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
To: Alice Ryhl <aliceryhl@google.com>, James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, "=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, rust-for-linux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, Christian Brauner <brauner@kernel.org>, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH v2] cred: rust: mark Credential methods inline
References: <20250304-inline-cred-v2-1-7aa54011bcab@google.com>
In-Reply-To: <20250304-inline-cred-v2-1-7aa54011bcab@google.com>

On Mar  4, 2025 Alice Ryhl <aliceryhl@google.com> wrote:
> 
> When you build the kernel using the llvm-19.1.4-rust-1.83.0-x86_64
> toolchain provided by kernel.org with ARCH=arm64, the following symbols
> are generated:
> 
> $ nm out-linux/vmlinux | grep ' _R'.*Credential | rustfilt
> ffffffc0808fc540 T <kernel::cred::Credential>::get_secid
> ffffffc0808fc588 T <kernel::cred::Credential as kernel::types::AlwaysRefCounted>::dec_ref
> ffffffc0808fc570 T <kernel::cred::Credential as kernel::types::AlwaysRefCounted>::inc_ref
> 
> However, these Rust symbols are trivial wrappers around the functions
> security_cred_getsecid, get_cred, and put_cred respectively. It doesn't
> make sense to go through a trivial wrapper for these functions, so mark
> them inline. Also mark other trivial methods inline to prevent similar
> cases in the future.
> 
> After applying this patch, the above command will produce no output.
> 
> Reviewed-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@kernel.org>
> Reviewed-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> Changes in v2:
> - Reword commit message.
> - Link to v1: https://lore.kernel.org/r/20250303-inline-cred-v1-1-b2527beace76@google.com
> ---
>  rust/kernel/cred.rs | 5 +++++
>  1 file changed, 5 insertions(+)

Merged into lsm/dev, thanks everyone!

--
paul-moore.com

