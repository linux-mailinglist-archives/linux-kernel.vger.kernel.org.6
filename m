Return-Path: <linux-kernel+bounces-568715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 682B0A69993
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 20:38:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7486642536F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 19:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B9C62139C7;
	Wed, 19 Mar 2025 19:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="p1MvH8np"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D01D1632D9
	for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 19:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742413089; cv=none; b=D3GXvKhPJYhSboSuoyOXHASUkeVJqiX5WeLs7zv8CfX6rAXHv0deH9u1Lwpo7aSogrqocJmJd+QPw283CJe437P8OKozrzXJgvcMv+V5YNx+4z/MRavt+gkXv35kSMGLnhqmkaO7eS8JJonRPKc4hDoamENJMQBj9QNhWVc9mwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742413089; c=relaxed/simple;
	bh=30JAlBfQnE91w+G6eMxgVHreBlcdCIfF5Y0h1aWT67k=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=APi00udQw5U1EfNMxg8yHTJ8IbMKK7pUd41Optkr7h9lhHSE7Qum1HZuAOpGugYbFaFZcz0vpBQQJ3xrcS0oaDduUxobP94Kqx2996LJpBhdoJV9xASPO0eRy5odcBfnfYxT5PjtN9mEkOPVi5xqkYuzIKirqANF+NBvt0DreYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=p1MvH8np; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7c08f9d0ef3so3455685a.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Mar 2025 12:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1742413085; x=1743017885; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TH0Nh5CACQMdGum1T1kJ03+J8IXhrVFogQmMwWePgpw=;
        b=p1MvH8npsZHR/vMLhFEcO9yfrZkhUMYtVVz0wi0XZtT+rANjE12KxL5Oq3cAbm+zax
         VSTCehYdKNrzqvGxswKYR7PTvD+3BK1h1fnnR1KnTdsHj0CasUbF6H9VscwhwgRbpT7/
         IFR1z3rnBU8eLqhPWSaGSRtDi++tX8z5YDFVg4kVR8d26VQSATk2LU7ScMbLxaHMSRe5
         iP8hoddh9bIKvyAxuBBgCyo4CHJQdTb+laLswVOIqF+4bIQyADlha9xZkVDey0L3dM3c
         MsOVDcoZKMCb19Lqwzniq9T1Pr7gYhC1CdMyijx60ksGmn9WMQXdI3Jr8ErwpvyNDqV1
         KZpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742413085; x=1743017885;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TH0Nh5CACQMdGum1T1kJ03+J8IXhrVFogQmMwWePgpw=;
        b=hJCMXmaJq3NYWWfv14M0hn0zneVVbsTCmrx/dheHfzvwabxglultV7GGhgJwwqhUlE
         Jo3IaAcM4MKeuXIlF6LnW8YZA5N8ncooFL7O6lIMlTj0H9NghMtl6D7W1zl5dAyPFHrT
         IsuZdyW+JKv0tDvPocoGjg9DqkX82rAC+JkjObKSb0Efz/ihiYgdhN8PmKokxyMV8WoQ
         A6X+1qUq/y4iVLo2J4VTPRbQNgKLrCTvofDNSMKlvXawqNwbwpNE7fRSizLDo9YRTNNo
         jKso9MVc3WPu9kViWnrNXcLbVp6MPm/2q0gJcFn6WNjd8/0eIUtbMHqNPhF2U/NVwW4f
         HVlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUFQtz8JEL6wJPLk6fQqKwhceHqBEtFF9gpUJep7j2LbPZlVQn87YeXkkC6viI0WEF6hh14qgG254msx8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlZ8l8KYlNh8sBCcX2ByuqP0zDK/xlQyQYzNK3c5GUz9XBxbn4
	VPEMrnjVxSJx4k5QcfhAA3w6Bcr7UO26yBEWsnwNbjJhWfiekuH9IYi92yL5qB4=
X-Gm-Gg: ASbGncvVygP5Fm2lDqMNLI1zYurjfqpRp8wj7ZTSbPRIEYCAzNCfJ5QHaL1auxcoO3n
	5Pk9qWXIsNaX0XMulUogDCgQu6Ae0OI86D+YPb7AoysM5Z9Q8ewXfrQ4Km3ZrFoVVHTuuI9MXXj
	QI3jnkJ3TS8IBD2G3MYge5RLyNEL4zZk6Mf5ss24xHvV4AJXdGM+tG79o8Z3gWa8M+QR+fhTSgH
	MfE+wRWuqefr2IMsN70Fp6Nvkfa9g1ev6vE2eHtCGzs0Uoo8Q6TsS4a7z37WL+Hnoxe854ODoZF
	Dg6gF7t8pHiHiWrEPE0ZkACF7kknVyP2xUlK4Srx9IUmKcTcy4ntp46LmsNPQvu/0AuSUkeZS5V
	KL9oFTzI=
X-Google-Smtp-Source: AGHT+IFdQZTM+f2ZX+pX309Ze5nBEw6FCBgti2A9XONKbbkCAnOfOx6N8XN2TagYu4vrkMGuyqd2hA==
X-Received: by 2002:a05:620a:1908:b0:7c5:9b93:8f64 with SMTP id af79cd13be357-7c5b0d068cbmr59928285a.37.1742413084966;
        Wed, 19 Mar 2025 12:38:04 -0700 (PDT)
Received: from xanadu (modemcable179.17-162-184.mc.videotron.ca. [184.162.17.179])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c573d89815sm894661385a.91.2025.03.19.12.38.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Mar 2025 12:38:04 -0700 (PDT)
Date: Wed, 19 Mar 2025 15:38:03 -0400 (EDT)
From: Nicolas Pitre <npitre@baylibre.com>
To: =?ISO-8859-15?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] math64: Provide an uprounding variant of
 mul_u64_u64_div_u64()
In-Reply-To: <20250319171426.175460-2-u.kleine-koenig@baylibre.com>
Message-ID: <66rr3q6p-2449-6722-0716-s5245pq4on9r@onlyvoer.pbz>
References: <20250319171426.175460-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="-1463781375-1765559341-1742413084=:292211"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463781375-1765559341-1742413084=:292211
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 19 Mar 2025, Uwe Kleine-König wrote:

> This is needed (at least) in the pwm-stm32 driver. Currently the
> pwm-stm32 driver implements this function itself. This private
> implementation can be dropped as a followup of this patch.
> 
> Signed-off-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
> ---
[...]
> +#ifndef mul_u64_u64_div_u64_roundup
> +u64 mul_u64_u64_div_u64_roundup(u64 a, u64 b, u64 c)
> +{
> +	u64 res = mul_u64_u64_div_u64(a, b, c);
> +	/* Those multiplications might overflow but it doesn't matter */
> +	u64 rem = a * b - c * res;
> +
> +	if (rem)
> +		res += 1;
> +
> +	return res;
> +}
> +EXPORT_SYMBOL(mul_u64_u64_div_u64_roundup);
> +#endif

Might there ever be a need for a _rem variant similar to 
div64_u64_rem()? If so the _roundup could then be a simple wrapper.

Otherwise:

Reviewed-by: Nicolas Pitre <npitre@baylibre.com>

---1463781375-1765559341-1742413084=:292211--

