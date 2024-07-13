Return-Path: <linux-kernel+bounces-251537-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8308F930602
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 16:50:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 246701F219E6
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jul 2024 14:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1307013A402;
	Sat, 13 Jul 2024 14:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Hf2FzdDD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5276EB55
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 14:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720882201; cv=none; b=Hbom2CyejCnqQ0+Wa0wZd0qKPlSFlnrfLru6xe7+QDAoCkDfhi3gieI2gCd573/KfTuWLtcNh6IhD4WoSG58K4DMHRmv2rbnRqJuEX+55ByTzHtcwcIwInB3Jclt7znIz2FNNSHRV0KPO0s0NeylpbuKIGAYhgFH1gSbSIwHPXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720882201; c=relaxed/simple;
	bh=lvDrQV56tBUXKpSUYxbx5CkTdDccFytAphDjQRZAsLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WV3dy1bl5mgUPRv6y44PyTHAsSGIoZ9mKTrti9NkDvDmowUVWYZhky3SaJLCf1M61pHAQSdsa+6SvMliC99eaH0z5qA5Uc4C7DC95N2+lZMLi8ue8SU4TFo9MCOaO82zYiQmsB+5wJyxmli6A1BKkJjmVcmVS8AGXRuRtDE+3u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Hf2FzdDD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1720882198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=a4AbNjpp4hqCHzZOlyISRcLeMmOnjyeu6DKbsQlyQtA=;
	b=Hf2FzdDDbb6QMoTUdYK/YN3DAKOGU7+vzaEfyH60W6/KC315PVzEzWUDrpBha+qbR7yNwA
	EqCcCgvwc+p8Mgk3g5/wAq+Ygv8JOe/SSaMnYra0aH7fVueo+770FZBPRF+yKh3qo7nSxV
	W8XtnimzS1Xsffl+DIG6LcftE78oZ6g=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-TqrXjFkgPhOzZk34WDcQIg-1; Sat, 13 Jul 2024 10:49:56 -0400
X-MC-Unique: TqrXjFkgPhOzZk34WDcQIg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42666ed2d5fso18988595e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jul 2024 07:49:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720882195; x=1721486995;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a4AbNjpp4hqCHzZOlyISRcLeMmOnjyeu6DKbsQlyQtA=;
        b=Rhj/htLL/z/JodBv3u8GcFq5UHLqKxr9buc0yW4x67V9UBagyOhg2CPk8eQN2+i8YQ
         2LsBg+ngGU7vyCnaZJ7rdtqH2DAT0nd0jJJA5sKDEWoZ2rXlIeqD+ntB9Ok8ZdtToX/1
         u+wvM1gvFp3O4L69AxVUr7FZuUu4/x2FaWFLY6crnt3aFj1kb3H0ZlWTUWes2uQzCezL
         tzfZvMUjtmes44+jCoNDv7Gt2XPapO4tliRbXO+DdmQ0UsrtPf1bf/O7EGGjemG5biX9
         PopcaJWinHg50nXltm9i8g2SMEz7IgtYBHRgvoebUO5OUlfQxNK1fZ+by4viv3oxYICY
         Qo3w==
X-Forwarded-Encrypted: i=1; AJvYcCVEcBlJkSu5l1uSCRlHVk068l9aU892lYP9Pb0qjiKbq+oR7fVdkBaHbrNjk5d4uHhdgXg2mnuWeVox2I1ADcpvKV7VVNyjO4HJ7sdj
X-Gm-Message-State: AOJu0YwHOGUDMkYX6Ee76Ctk1+ayZbqwFVwS1uScdhHWzmbP3cZ5q97S
	H3tR584xun+cbMTU3WMsGUH5TO0pgTJBuHHbJMhXzlathkLJFcq+xmZ8M1+Miqm7SPkBN5aYezv
	JtX5YhrHLDLCK9eUAlNhrrahn1pbfmjeRB6Bv6jIuLn+1fzsYsgHHp636dsDpfg==
X-Received: by 2002:a05:600c:6d8f:b0:426:6f0e:a60 with SMTP id 5b1f17b1804b1-426707e2ffdmr97349195e9.17.1720882195395;
        Sat, 13 Jul 2024 07:49:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHYybzB01yKZQiOWZSW/pi8k9FrEkZ863yhN5Xt/4doo+hsXQoxYA/zL09HPsKtMFVmYmKhRQ==
X-Received: by 2002:a05:600c:6d8f:b0:426:6f0e:a60 with SMTP id 5b1f17b1804b1-426707e2ffdmr97348925e9.17.1720882194772;
        Sat, 13 Jul 2024 07:49:54 -0700 (PDT)
Received: from pollux.localdomain ([2a02:810d:4b3f:ee94:2522:59b5:3360:91e1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-427a63449fcsm21716525e9.29.2024.07.13.07.49.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 07:49:54 -0700 (PDT)
Date: Sat, 13 Jul 2024 16:49:52 +0200
From: Danilo Krummrich <dakr@redhat.com>
To: gregkh@linuxfoundation.org
Cc: miguel.ojeda.sandonis@gmail.com, a.hindborg@samsung.com,
	alex.gaynor@gmail.com, aliceryhl@google.com, benno.lossin@proton.me,
	bjorn3_gh@protonmail.com, boqun.feng@gmail.com, gary@garyguo.net,
	andrewjballance@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-kernel@vger.kernel.org, mcgrof@kernel.org, ojeda@kernel.org,
	russ.weight@linux.dev, rust-for-linux@vger.kernel.org,
	skhan@linuxfoundation.org, wedsonaf@gmail.com
Subject: Re: [PATCH v2] rust: firmware: fix invalid rustdoc link
Message-ID: <ZpKUEKHh6gK7SODR@pollux.localdomain>
References: <CANiq72=6LSGwRsc+deE+U8H=mdgFisrKEPOYgVkZfHhGm8hwog@mail.gmail.com>
 <20240709004426.44854-1-andrewjballance@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240709004426.44854-1-andrewjballance@gmail.com>

Hi Greg,

On Mon, Jul 08, 2024 at 07:44:26PM -0500, Andrew Ballance wrote:
> remove an extra quote from the doc comment so that rustdoc
> no longer genertes a link to a nonexistent file.
> 
> Signed-off-by: Andrew Ballance <andrewjballance@gmail.com>
> Reviewed-by: Danilo Krummrich <dakr@redhat.com>
> Acked-by: Miguel Ojeda <ojeda@kernel.org>
> Fixes: de6582833db0 ("rust: add firmware abstractions")

Can you please pick this one up?

- Danilo

> ---
> v1 -> v2: updated commit message
> 
>  rust/kernel/firmware.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/firmware.rs b/rust/kernel/firmware.rs
> index 386c8fb44785..763d7cbefab5 100644
> --- a/rust/kernel/firmware.rs
> +++ b/rust/kernel/firmware.rs
> @@ -2,7 +2,7 @@
>  
>  //! Firmware abstraction
>  //!
> -//! C header: [`include/linux/firmware.h`](srctree/include/linux/firmware.h")
> +//! C header: [`include/linux/firmware.h`](srctree/include/linux/firmware.h)
>  
>  use crate::{bindings, device::Device, error::Error, error::Result, str::CStr};
>  use core::ptr::NonNull;
> -- 
> 2.45.2
> 


