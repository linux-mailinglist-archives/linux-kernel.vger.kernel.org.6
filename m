Return-Path: <linux-kernel+bounces-286451-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD169951B13
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 14:45:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63CEE1F21A79
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 12:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ABA81AE031;
	Wed, 14 Aug 2024 12:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VA1K+RUl"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245E14688
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 12:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723639519; cv=none; b=DjMTZ5aHadGG8KwL/w2nxQEZXjetyi5XTa939pDzHCRkdC0U5ELYG//5TXQixSHDXWMtNHa52SVcXCgqxf9iOEVnIr+fS5yIeDiI4hLgohePmrYYzW6DI9SeFlQqfN85nQ2hxeyyJmdSNFxnePinCqnrMI3oApM969NekeIkJYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723639519; c=relaxed/simple;
	bh=lq0CIfce0tB5J0gVu0c0ocegR1rx81v9Y9wewp28J2c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cwuxmCmo1L9UTjp4ODfLaIgrhngXAP2Rz4o5i0SHf/G5tf3AHo1RxgHO8inmVoNb0kerOm8mEXa4h3WM0lusVJEawfhJlllxkg26cMMxVU9I4G7QJohinfTxKTwCw4Q/ZpliAIec6FlEKP7nQq4w+vlCDM8O5xqKzadn9lTcJtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VA1K+RUl; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7b2dbd81e3so836626366b.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 05:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723639516; x=1724244316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gXiJ6h0vBhMAdw5LUn2BvsS0+bvRUr9R1B0J7lshEqk=;
        b=VA1K+RUlnYOnFwnyYorvlV4JWUaaAP8bRCbegLbxsPfeO5Hq6XoARVkOEp6ZzMt7Qo
         cPVwkxVm8rLWuRrlMbwJ95RUn8RDE+k/t8WPxea6UR9eKXcjoFx28RQR1+aAFBEdYfcc
         SsonDyS9YxUltYg+fx0imFF86rBK6YBRbe22jqQw2LUgmwMeorYoKZ/qy+DSAAeOR10z
         9jZ9Yj+BGgxzXMQj0y26daINOKYStmQTVTOjZi2Zj0heBuhQMz0RlsJgVg1xozHK5ZjV
         JUlRExLe3obbSMJQAKSIkfCefY54Nzp+6EGcbyKfm/tIGpRNvsYhM6Wc6tiO38H8/5tP
         67hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723639516; x=1724244316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gXiJ6h0vBhMAdw5LUn2BvsS0+bvRUr9R1B0J7lshEqk=;
        b=a0kPkOVDx2tzDwMskoJ+EAElZbP4R2AmlJzfdc2OeCkkLS909JCIxXrBhnark4nlSw
         70OcgvyWY80AOqeOQ33p6DmrSZ768rriWM7YznUCYVZX+0l6frhJ7+w9Dc03G1AbBbXd
         Xu0lytuqcPN5Om9GuMPUEMmEzDa3aBZoHVVz8MFBPcenO52KesqotmtaQNiF3++Uk6hn
         CNsLTTK8qUFIcJkQqlaK2h5ZLVIuJoJws1zrv2P0RppTsgpk06tPkYjnlQEaUT9DzANG
         cDWrue9V3pYUY9wXV+xF6mOrmEYLC259nCvlhA685Zp+KQW6HZtJVP3+JHUkd1aTBKZD
         y1Rw==
X-Gm-Message-State: AOJu0YyTwoCFNailplDmtY7d5dR1G4F7xji4vRVqrQSB8pSoCYYmcojA
	mjzFi2W4D6ZxoUPm4ev/SlP5J/rNH3IX+jlG298WS2FCrBTdqGuKas+gkgBPYNsWIUtlQEUXHn+
	y+zNs72lSVtvpx6FQh8TwLfW7SwY=
X-Google-Smtp-Source: AGHT+IGZr2QwBx3fGlXSkOaUCnb4hbIxI+4OY6LAlhqkkpfUF/4fww8rKMqhp3vT4LPNsuQUeuvbRSxihSq1GVd5UOU=
X-Received: by 2002:a17:907:d5a2:b0:a7a:9a78:4b59 with SMTP id
 a640c23a62f3a-a8366d4146bmr182304366b.23.1723639516109; Wed, 14 Aug 2024
 05:45:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240814100035.3100852-1-jani.nikula@intel.com>
In-Reply-To: <20240814100035.3100852-1-jani.nikula@intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 14 Aug 2024 15:44:40 +0300
Message-ID: <CAHp75VciLg3KjeSAeEQyc1xa7o1cjoc5oEjYcGCK_MuSzmAWiw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] string: add mem_is_zero() helper to check if
 memory area is all zeros
To: Jani Nikula <jani.nikula@intel.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, Kees Cook <keescook@chromium.org>, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 1:00=E2=80=AFPM Jani Nikula <jani.nikula@intel.com>=
 wrote:
>
> Almost two thirds of the memchr_inv() usages check if the memory area is
> all zeros, with no interest in where in the buffer the first non-zero
> byte is located. Checking for !memchr_inv(s, 0, n) is also not very
> intuitive or discoverable. Add an explicit mem_is_zero() helper for this
> use case.
>
> Signed-off-by: Jani Nikula <jani.nikula@intel.com>

...

>  void *memchr_inv(const void *s, int c, size_t n);

I would group them here, or move the above.

>  char *strreplace(char *str, char old, char new);
>
> +/**
> + * mem_is_zero - Check if an area of memory is all 0's.
> + * @s: The memory area
> + * @n: The size of the area
> + *
> + * Return: True if the area of memory is all 0's.
> + */
> +static inline bool mem_is_zero(const void *s, size_t n)
> +{
> +       return !memchr_inv(s, 0, n);
> +}

Reviewed-by: Andy Shevchenko <andy@kernel.org>

--=20
With Best Regards,
Andy Shevchenko

