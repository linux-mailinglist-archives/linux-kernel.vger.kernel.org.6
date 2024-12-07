Return-Path: <linux-kernel+bounces-435825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3B629E7DAC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 02:14:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82E77286932
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Dec 2024 01:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F8AC179A7;
	Sat,  7 Dec 2024 01:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dz8iq5f9"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09256C13C
	for <linux-kernel@vger.kernel.org>; Sat,  7 Dec 2024 01:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733534054; cv=none; b=QCDuAItAALWXk7dTOqAPhXVjTKRGSLn1V7+9YNgn5tcxqqCcncijWLwn4NTkw5Gsm2KOZQ4CBtm4hZhRcKk1sqBBfTswGrHWWwqmbYdHKMJDxts4Xw1v355Gg8aSi/T/XJldcwxXMa5OBl3v9fIDSbkxuau4g9KxNTcXcZAmMJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733534054; c=relaxed/simple;
	bh=1UDNfOgAXHiNS1laqsuNcIe0CfMA9SfD/bj3xh3ULE4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UWYrTdd5eDdvjJ1Rd2REeFJpiVuK8d1obX7X1y/kGgQpNRLZkkf/vsbXSyawp2CAqSp4mgW7EWj5AG3KKnUoVPa3AGOE53QVRV6b+WVA2hG2UHW2SQcns57nWIdc7S6FG9Kxu5QLDU0uQbqr7WNH36UwWEzT4itMjpDGaK+QgZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dz8iq5f9; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-385e87b25f0so2212792f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Dec 2024 17:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1733534051; x=1734138851; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kc4i0kJQLOWcBEfKkh0Mird9pq2rATpCYMpyHBDNC9Q=;
        b=Dz8iq5f9DSBrGG+VSu3ISHBYgs7VrSh10cEknSughBmoHAmqiComy73O9E+KtcNV66
         eSLlY/QcZYW8PqmEpNVZNhhl6tHLg6g0MVtK47aFlsWGzoPoXH3x91GpySNxbaIh/tQK
         IkY4ODuUmmOMkT5Hl6O31YsxsV6YJDuFk8Pvlg/QDL4NUqXLwQYunbkksLiuja6CVjVm
         pq3b0dGgIGf5C8OKuXEZfkbxUkcLBjW09dbTd3PVEWlIsCLqRTxz8R3XPGK4M4HwAyIN
         jO/DFNH20FpkAGwHRv8NCS8NqaoTRrjJIPIgxUyIkBv3gtD9X1GuPKVbIaoePw+RWO3w
         yyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733534051; x=1734138851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kc4i0kJQLOWcBEfKkh0Mird9pq2rATpCYMpyHBDNC9Q=;
        b=n5A5R/Gx5R3V9ZRrLu/2i+jyDs+8VcdXC5Ai04atFKe00wotybT4Uju3kp5+oZ3lOf
         yEs9lzyXNNv3esKCJhpLisRd++ytK+LpR2O8ufeTdpFgaYVMJBnTOWx6ls9DlHF0/MeZ
         De8XeFamSXiS/KKTW6DdVtZIk+q9mu1gqwIZQZ7wDnzOgzt/QIej7ZgQ4LRbficgSrQz
         reAnsJ8uoL+svtHsFRyxc4TPnhIHOc8EFuT/qHxuBUxYIuH5uHcn7bB6xi3ejbpKY4s/
         SGSK9IUYp51pBt6QftI7XuLrcLRWTkLFcRV4zVDkreD13qkHmGCkdOrOLKixCXBfh/qZ
         lz4w==
X-Forwarded-Encrypted: i=1; AJvYcCW+3WJh06QHa556DXa60DawoH1NrzFuPQiNJX0GIGHBDsSTaJJtuO28UqO2dQAmbOrL3IvCV4mGjWhcKQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzABAo1FTYLz6UXx40uKA13yM6eZ04vvXW2smD41kFp9RJsGQfu
	Y5hWzU+ujYWC44ciD957yrQwro+7R7JPsGJDIf9dfPbXR5Hr/pulmXxYMd9M2Hn7plLjnxHvvXK
	rOUI9levjiOHWuimNnwFIJVS1QqoOPFxhUST7vQ==
X-Gm-Gg: ASbGnctZJnJO2//bFMIRYcvxbKib7hIsA0oIps2uKz7YMl7LUi5f7XDkAxYmvPH595L
	Vyg0K9nrRpTmkS6jGN5snnTwOVkwwJKvNc9UhYjUahVPkcLkIHzO2pCUa5Zma8y4=
X-Google-Smtp-Source: AGHT+IEXUUe0fWZt4pPEQxVTHw6twtVV/mHWiQX4ajOGKuM43alY918V0NbCArXqqS7AFHkv/75t0ILgA7HTIDbSd1o=
X-Received: by 2002:a05:6000:42c7:b0:386:2e8c:e26d with SMTP id
 ffacd0b85a97d-3862e8ce40emr1978498f8f.0.1733534051301; Fri, 06 Dec 2024
 17:14:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241205141533.111830-1-dakr@kernel.org> <20241205141533.111830-4-dakr@kernel.org>
In-Reply-To: <20241205141533.111830-4-dakr@kernel.org>
From: Fabien Parent <fabien.parent@linaro.org>
Date: Fri, 6 Dec 2024 17:14:00 -0800
Message-ID: <CAPFo5VJ9=VAghiUGbzPjDDdG8tg6xNQaRtBduHk8R70jktPQNg@mail.gmail.com>
Subject: Re: [PATCH v4 03/13] rust: implement `IdArray`, `IdTable` and `RawDeviceId`
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, 
	ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me, 
	tmgross@umich.edu, a.hindborg@samsung.com, aliceryhl@google.com, 
	airlied@gmail.com, fujita.tomonori@gmail.com, lina@asahilina.net, 
	pstanner@redhat.com, ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org, 
	daniel.almeida@collabora.com, saravanak@google.com, dirk.behme@de.bosch.com, 
	j@jannau.net, chrisi.schrefl@gmail.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, Wedson Almeida Filho <wedsonaf@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi Danilo,

> +/// Create device table alias for modpost.
> +#[macro_export]
> +macro_rules! module_device_table {
> +    ($table_type: literal, $module_table_name:ident, $table_name:ident) => {
> +        #[rustfmt::skip]
> +        #[export_name =
> +            concat!("__mod_", $table_type,
> +                    "__", module_path!(),
> +                    "_", line!(),
> +                    "_", stringify!($table_name),
> +                    "_device_table")

This doesn't work on top of v6.13-rc1. The alias symbol name has been
renamed by commit 054a9cd395a7 (modpost: rename alias
symbol for MODULE_DEVICE_TABLE())

I applied the following change to make it work again:
-            concat!("__mod_", $table_type,
+            concat!("__mod_device_table__", $table_type,
                     "__", module_path!(),
                     "_", line!(),
-                    "_", stringify!($table_name),
-                    "_device_table")
+                    "_", stringify!($table_name))


> +        ]
> +        static $module_table_name: [core::mem::MaybeUninit<u8>; $table_name.raw_ids().size()] =
> +            unsafe { core::mem::transmute_copy($table_name.raw_ids()) };
> +    };
> +}

