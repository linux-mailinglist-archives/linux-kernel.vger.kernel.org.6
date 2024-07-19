Return-Path: <linux-kernel+bounces-257618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2228937CB6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 20:51:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F144B2106E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 984C5148304;
	Fri, 19 Jul 2024 18:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fG05yJP0"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACB21465B7;
	Fri, 19 Jul 2024 18:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721415059; cv=none; b=RCiUtJrCpnbrowAFkoT4ZZbWZawST1rSTWian1ygEKqDZvpntRYR6wNNgulMpTo5yMwfIoODH3nV9Ogtw06C77ApTwwV0x+jJXLmc24O8FqBRO/Qaku+HBdnF1bOVjTsTHCeKoeEC7ZRrNLNPU/VzCAPk45BTJLJBYDMfXxl1k0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721415059; c=relaxed/simple;
	bh=Ee9ro+8W2ACQUh4oM+H8UjzP/GPKGir4IM61B80FmYw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sWw/FgozCpYLpsxVTxDp8ZVOjovGjJRe+nkOcwFbsB1pf49flr6qnYOrjUSLq/EhxMHT7DDgK1dQDtplttqJ2LMKWLtB/h6+UUpoF2+K0Pon/FFXblStrgtjBVWVS/3483DfsM2AKMEtUfnCxySB/tlptX5KconTph8iNYDZHow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fG05yJP0; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2cb4c584029so1174563a91.3;
        Fri, 19 Jul 2024 11:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721415058; x=1722019858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RAEv+MGhyDj802ZNnZVlhgfJ7rM5mroogx7bWE9X/x4=;
        b=fG05yJP0GBXcFl+lgsGDE0haIeiL+JIS43RKgzQt5ppejpU5r+qRYXj/ZyJT7G9A+G
         m5vMN+LrmNsF1fS8so0EqTKIpgiXE9ZqUDdLNooKXgSxdb4JsMF2jDUjeFWvkbfXPQkd
         7xCjpLLCc0z0PlYRmi10ZdSoD8DS7GBE+YQJ8vrxc55UHLf6miN4jy7mQjFtiJbKZU0l
         Rb2nKETISWa7e+NE0kizCAz47brAbiX8ZnHFLMYHBf+5bZJ+Ao5X0T5V0p92hZN7JeuM
         2PIM4p3Zr50PJ3jxG7ehdNfmcXLb/6d+xtdC72Vm5+n/d9EDsracFh2+QZkwgF/ozMKe
         /rzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721415058; x=1722019858;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RAEv+MGhyDj802ZNnZVlhgfJ7rM5mroogx7bWE9X/x4=;
        b=jAOsCTNQCgyMgjB92VpKgXPT7C8SUWFpJubClmIxULfAW0D5SUz1PDIxI7W0BX4qsY
         3AyY/93/6D3RplnTuHFeNYqbggVSYorh6HD4OJCBHqwiL7qcMQVSVH7OFir9fMf+FzbS
         tAWHz9mogZExxD/jatAB5/wtw7G7EoaMUA7fgM762JT1+uX3deL0RYZKkO9e/MbdtfrR
         rxYaXpKUmFyXbi1y/xfaJn1c90HbzHGz+I7VprUdbktoFF2tgTVfGT/9I3e3v0mW6856
         TIrqcDSD8Vemn79OpeJOcEEHyXFEWxgWOI1s2/OJ13Ls3w/FugOzNr9CtzLm8nQBa7Vn
         yDdw==
X-Forwarded-Encrypted: i=1; AJvYcCXhe0FMrwQgpHDbQxCtFHOtvE6krEWoGUO1HMeGxnPhN3nP3AQEyZsw8Zk5zbEQGcA+UY/ACqw4MnauDRdknZcFRIxVSODbiGseXT6+yDjPhEMbhkPph3oWFpDERcJETZM47A4KJR64LpaNOfw=
X-Gm-Message-State: AOJu0Yyg4Txs/3jI7Hr0wcOlLf7gEQXVL3IooCErmxjSl49eX5LwtSUu
	rPh4wC1N7jHwQzIpEyaOGH/jzOvwMpoI56Aibeysd0cWk4em7Zr5
X-Google-Smtp-Source: AGHT+IGbL5E/MFEgPWn06cYckxokoAX5eI4e0D2YJL6S5zac/xTsDRmKykBaYUraPNM6HMn49Mj4Qg==
X-Received: by 2002:a17:90a:fd0d:b0:2cb:5134:562a with SMTP id 98e67ed59e1d1-2cb5246a16bmr6746195a91.7.1721415057638;
        Fri, 19 Jul 2024 11:50:57 -0700 (PDT)
Received: from [192.168.179.119] ([131.107.174.134])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cb7750688esm3143801a91.37.2024.07.19.11.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jul 2024 11:50:57 -0700 (PDT)
Message-ID: <0bad8507-22f3-38d2-5724-0aa6433990cc@gmail.com>
Date: Fri, 19 Jul 2024 11:50:55 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 0/4] drm/panic: Add a QR code panic screen
Content-Language: en-US
To: Jocelyn Falempe <jfalempe@redhat.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng
 <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 Bjorn Roy Baron <bjorn3_gh@protonmail.com>,
 Benno Lossin <benno.lossin@proton.me>,
 Andreas Hindborg <a.hindborg@samsung.com>, Alice Ryhl
 <aliceryhl@google.com>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
 Danilo Krummrich <dakr@redhat.com>
References: <20240717142644.1106060-1-jfalempe@redhat.com>
From: Mitchell Levy <levymitchell0@gmail.com>
In-Reply-To: <20240717142644.1106060-1-jfalempe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I am trying to test this patchset on my setup, but I cannot get it 
working. In case it's relevant, I'm running under HyperV. Any 
troubleshooting steps/suggestions would definitely be appreciated.

Thanks!
Mitchell

On 7/17/2024 7:24 AM, Jocelyn Falempe wrote:
> This series adds a new panic screen, with the kmsg data embedded in a QR code.
>
> The main advantage of QR code, is that you can copy/paste the debug data to a bug report.
>
> The QR code encoder is written in rust, and is very specific to drm panic.
> The reason is that it is called in a panic handler, and thus can't allocate memory, or use locking.
> The rust code uses a few rust core API, and provides only two C entry points.
> There is no particular reason to do it in rust, I just wanted to learn rust, and see if it can work in the kernel.
>
> If you want to see what it looks like, I've put a few screenshots here:
> https://github.com/kdj0c/panic_report/issues/1
>
> v2:
>   * Rewrite the rust comments with Markdown (Alice Ryhl)
>   * Mark drm_panic_qr_generate() as unsafe (Alice Ryhl)
>   * Use CStr directly, and remove the call to as_str_unchecked()
>     (Alice Ryhl)
>   * Add a check for data_len <= data_size (Greg KH)
>
> v3:
>   * Fix all rust comments (typo, punctuation) (Miguel Ojeda)
>   * Change the wording of safety comments (Alice Ryhl)
>   * Add a link to the javascript decoder in the Kconfig (Greg KH)
>   * Fix data_size and tmp_size check in drm_panic_qr_generate()
>   
>   v4:
>   * Fix the logic to find next line and skip the '\n' (Alice Ryhl)
>   * Remove __LOG_PREFIX as it's not used (Alice Ryhl)
>
> Jocelyn Falempe (4):
>    drm/panic: Add integer scaling to blit()
>    drm/rect: Add drm_rect_overlap()
>    drm/panic: Simplify logo handling
>    drm/panic: Add a QR code panic screen
>
>   drivers/gpu/drm/Kconfig         |   31 +
>   drivers/gpu/drm/Makefile        |    1 +
>   drivers/gpu/drm/drm_drv.c       |    3 +
>   drivers/gpu/drm/drm_panic.c     |  340 +++++++++--
>   drivers/gpu/drm/drm_panic_qr.rs | 1003 +++++++++++++++++++++++++++++++
>   include/drm/drm_panic.h         |    4 +
>   include/drm/drm_rect.h          |   15 +
>   7 files changed, 1358 insertions(+), 39 deletions(-)
>   create mode 100644 drivers/gpu/drm/drm_panic_qr.rs
>
>
> base-commit: e1a261ba599eec97e1c5c7760d5c3698fc24e6a6

