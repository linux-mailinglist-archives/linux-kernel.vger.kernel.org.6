Return-Path: <linux-kernel+bounces-406207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C35669C5C20
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 16:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C4751F21C9D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:41:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0182B20127F;
	Tue, 12 Nov 2024 15:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vwJ/seVj"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF119200C8E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731426108; cv=none; b=hKV/ip9EpTpaRmqY9yXIKgIyGIpaRv1SiA1/TN2AAP8gNKImBh8jrng14X6Kqk/ty5A06QtLBKsjx/mnZJUn0/0OsbyrtaSXgyhmgwwiZE5JdF6pipLt0xuoHMgPCbbWuA3I/qG7lROOtu+hZZjxjSqUiU2DQLwGes50xN0yYtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731426108; c=relaxed/simple;
	bh=xgNKwdx8fbeGP/sL5jmeeV58ujRWHOcZVehMXSMJrkA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KExy1L6YjZfeXk6wXNmfb3DIkVUEYUOiY+j9E6RJgHn1pAsxqxv+sllkTRN2lDpB7KU6YWxEC0dCeAO9O9hhxrDr8StSme2SenwpEavnlltlHKiV7rxBNvC8smDevL9VfdopjBue5G8K0q66PW01te+gapbLfCQHcHW03SADAwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vwJ/seVj; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c934b2c991so13508a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 07:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731426105; x=1732030905; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bkZf0dAyKpaV6oeL97qMQayHnuJCrWyOMGk6lUpa8dI=;
        b=vwJ/seVjKW189c7pPEYSjDrLu5YV5wTkUn194YpzmIWxVeWPse6EEiYIaY6rQCTBo2
         FxZoXMQMwIcl5jLnN4jMOAcc6B6FPYxWk96K+f14BBtpQbvYReNP03RSU/ig3Fj6EADw
         SaQ9C8y/5SoAbu18EGA20g8vwmaXuJnlxH5BEI+Os5LbLwNj4Bnl3N+IhgldIRbdhsWw
         CfbwVlsS3+Yx4gDEgseV0Zs/5IYVaU7r9LjmMMbhcsiTzr9LQSDwETNOu0pGd1a+Bu2b
         gEnm8GcqAxpJKS9wmlUhsa5w1UV6mpIxG3JbPRfVklK175nfP7m5+SGF2MGRyXHftPpP
         IH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731426105; x=1732030905;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bkZf0dAyKpaV6oeL97qMQayHnuJCrWyOMGk6lUpa8dI=;
        b=pkbQqQmCAa5F5UNbDv4EFNRwNUn/eN+1+p0YdLdjqeovft8dpCdiZRJGLnEmZMUi6W
         U7hszvyycsSbPjd+q5NnBW3b3ZerpXQjLqW32tKy4rO3yNAkN2Dfcp6UNugegoBDV0Jf
         Ci+z9/n6Ew+pi2HHVHZPNNHFue+9iM3Kwx7hDeyiPEIdFraATbFGp7toAiwDrzzhr7mt
         hCbTgdAmEELjiNMbgD/jglEvs49JIhc4dN+kmI8VvKkjma+oZ2d2jhoptbsbB8aATwfg
         2TTLvaYhgRse67CD69+Hdyjp/vSIChN5rL5SlYSqO4Ud9uuKPj+VJmuNaVatjQuJ1zUm
         nVCg==
X-Forwarded-Encrypted: i=1; AJvYcCXt5FXMl8FuV9Diz1TsgI/U67aqgtxMgKK164JUkToDOem9rB2KueCvsoezkJm+RUzG5MjhFmPXnS0pPes=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSFUMqycjIh5mWf2QeATVKbvoMCWZ/Tip2AnXbhq8xKVck6Fk3
	NzphTRPEBWWFitEbxAzMG324l84fRPfen1cvqxYsOlWZaQLPUxwz1ZAYVAKg9oimLBHX7i2kP3y
	3qAS+a+8yPX6Y7FftdD/gk5Bn+YL8eVzYgb/+
X-Gm-Gg: ASbGncsFD/lTkDhHbRgOjWXhwXKqH9iTcapJklqiD9qH76IXWnqNBRW19ecy6uSFDuz
	VLqUgILFYBOIMG9vQwwPL3NZpcaMlv+843Zp5A1lYitOvVZDhBUJ1hw/4zxM6
X-Google-Smtp-Source: AGHT+IGKGj3m0K6cw27EtgaGcbRERBtnwAgADHveQ1xpIh6tli+bg/P/um8bA7UFcXQB7YKvR9KUq5R8xprHojQBtMg=
X-Received: by 2002:a05:6402:234b:b0:5cf:4994:501d with SMTP id
 4fb4d7f45d1cf-5cf5234185emr287895a12.3.1731426105003; Tue, 12 Nov 2024
 07:41:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241112105604.795809-1-james.clark@linaro.org>
In-Reply-To: <20241112105604.795809-1-james.clark@linaro.org>
From: Fuad Tabba <tabba@google.com>
Date: Tue, 12 Nov 2024 15:41:08 +0000
Message-ID: <CA+EHjTyPc5o3T1jQY8VY+W5qtneiKw5wVMVhuSif2ZVs3S=ChA@mail.gmail.com>
Subject: Re: [PATCH] KVM: arm64: Pass on SVE mapping failures
To: James Clark <james.clark@linaro.org>
Cc: maz@kernel.org, kvmarm@lists.linux.dev, oliver.upton@linux.dev, 
	Joey Gouly <joey.gouly@arm.com>, Suzuki K Poulose <suzuki.poulose@arm.com>, 
	Zenghui Yu <yuzenghui@huawei.com>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, =?UTF-8?Q?Pierre=2DCl=C3=A9ment_Tosi?= <ptosi@google.com>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 12 Nov 2024 at 10:56, James Clark <james.clark@linaro.org> wrote:
>
> This function can fail but its return value isn't passed onto the
> caller. Presumably this could result in a broken state.
>
> Fixes: 66d5b53e20a6 ("KVM: arm64: Allocate memory mapped at hyp for host sve state in pKVM")
> Signed-off-by: James Clark <james.clark@linaro.org>
> ---
>  arch/arm64/kvm/hyp/nvhe/setup.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/nvhe/setup.c b/arch/arm64/kvm/hyp/nvhe/setup.c
> index 8fec099c2775..cbdd18cd3f98 100644
> --- a/arch/arm64/kvm/hyp/nvhe/setup.c
> +++ b/arch/arm64/kvm/hyp/nvhe/setup.c
> @@ -146,8 +146,7 @@ static int recreate_hyp_mappings(phys_addr_t phys, unsigned long size,
>                         return ret;
>         }
>
> -       pkvm_create_host_sve_mappings();
> -       return 0;
> +       return pkvm_create_host_sve_mappings();
>  }

Reviewed-by: Fuad Tabba <tabba@google.com>

Thanks,
/fuad

>
>  static void update_nvhe_init_params(void)
> --
> 2.34.1
>

