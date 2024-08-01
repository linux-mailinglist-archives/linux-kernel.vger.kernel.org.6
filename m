Return-Path: <linux-kernel+bounces-270899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E50B79446CB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 10:42:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E8301F2526C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 08:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2715616F0C1;
	Thu,  1 Aug 2024 08:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="TjevA9IV"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 253AA16DECA
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 08:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722501712; cv=none; b=bAIb3H7SknML44uAW4aYko+0e1CVjZd5MwNmo3ofSj2mRvZaz7aLZVY6ef8EiYgDeyUpaojJoTsYibEdAQA9rNjB3EShc+iD2/6EFp4X8K9CABKmWepHMwwASviofV+wEyfYKCp1XZXJlRZlNRxofy7Dleu8SzTd/KO+zLoha+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722501712; c=relaxed/simple;
	bh=aw9s8bH889T89YP6YbwpNL913F1GzGilpacEd/D8P4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AZX5WvCbONcMyGNoQIPXaxM56wjfPMs3l4npAVz7gKKIdv1TY7IkW8x2fN/GAIe+rILQE4Zht6LyK1gl03vv0sasmuCqW9WiRmNQ0cmQcidj8miFxHlPy7pE/VO6hfPgpsG4nY1aw1vR8eJ+IrCMR7TRHwwvZaKum7Z8Ly5zsyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=TjevA9IV; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4281d812d3eso46027745e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 01:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1722501707; x=1723106507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=TIN4KBQZ4pBCfdikPcgAEWweUfMO0lXsLC8I9nmJx2I=;
        b=TjevA9IVEtF17sra0Oec8TIWEnhLSi3foJBa55lgfTfQcJhgctMEz6Okrk9NTqAHNk
         Oge7Q2A23rqSc+YSEQtjdtZH+VZYypygHj8hHFa1XtTKUBxttYNbe1iOg9eSdSnRfDNh
         RLVzSh28b9ew0IsC/E+1x5WkdPKo18J6/jMn65lQYompDMqIR7NQgLcRDKKl9ig3iSPZ
         jdGIOnf8NA2MjL9W/83UEunzpY2kavPFd6FUNJee74wZpdKt8kKuGUq7xr7LLuBI9f4T
         lzc+J1fR1vpKl9t4xnFrCld/M30QEtgZBYLz3qTDpshoyAUC6OIrM0C64yUYuh5q9xrB
         nMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722501707; x=1723106507;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TIN4KBQZ4pBCfdikPcgAEWweUfMO0lXsLC8I9nmJx2I=;
        b=meydQaDzcFIJAyFHvBUrlZxlNhgISSYh4FX+TyZPrBYUwAEtSBJYZJaIiyoZfBPAWA
         nHHdZNBT5Z1vsH7Kf221OeUNPdeZUIj1xc+TfhYOVpY0Yuyvv1+nF7oYgTrq6z8A/EcZ
         ff3HLYgLMFM6zbiY08j1SmQhH8ht96Q/AfEt/uQgGxL3icWvoapzoofZi7EHSUlZHSGu
         daH+9Z9Xii9qWa1MhxcvyT0SqfJtYUeOsvTlUuDxGnoAyua8Qy/oPDhOQLV8Rtc7oyk1
         6xg4WvsroigxnSAnURqjgSqe166p7sG9d8gqa7SlMGWaL2/q+OceT2mlW9fDMNVjYngX
         L7PA==
X-Forwarded-Encrypted: i=1; AJvYcCWu7dE/z+0lJh77KWh7jW1Lj0htGT3sgVhYk2zab9LD+cvNvAwbmkHQXAUwcwUECGeM4jrUZ/SHw552OmkQj/Kf5owz4hLtcGf8w2+M
X-Gm-Message-State: AOJu0YwcupTqxvjObRsyD6iknGU36ywBhMEWenAIhW1ChfE3dVG3JpOW
	2Sw6mb9Fnz5fKmF37RgiQK8Zv6/TbvPqJNy+5etO4egt7vtUn+ltd55W5Wab+o4=
X-Google-Smtp-Source: AGHT+IEnt1KPUDXb7f5QTSvgXAcJ5YPBVa0z/LPxP9R55nTDeIaLCTwSH5+5oMPbf8egz1Cxbi9z5Q==
X-Received: by 2002:a05:600c:4f45:b0:428:e30:fa8d with SMTP id 5b1f17b1804b1-428a99dfe89mr18783405e9.6.1722501707318;
        Thu, 01 Aug 2024 01:41:47 -0700 (PDT)
Received: from localhost ([193.196.194.3])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367d98aasm18927393f8f.30.2024.08.01.01.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 01:41:46 -0700 (PDT)
Date: Thu, 1 Aug 2024 10:41:45 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: Use of_property_read_bool()
Message-ID: <syfawfdkulanw7kile7qfg5qpfzakaqolh2qkjqwyarskgg2sg@ond7ytjil2yi>
References: <20240731191312.1710417-25-robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="crydygo6vpaqs2bx"
Content-Disposition: inline
In-Reply-To: <20240731191312.1710417-25-robh@kernel.org>


--crydygo6vpaqs2bx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Jul 31, 2024 at 01:13:03PM -0600, Rob Herring (Arm) wrote:
> Use of_property_read_bool() to read boolean properties rather than
> of_get_property(). This is part of a larger effort to remove callers
> of of_get_property() and similar functions. of_get_property() leaks
> the DT property data pointer which is a problem for dynamically
> allocated nodes which may be freed.
>=20
> Signed-off-by: Rob Herring (Arm) <robh@kernel.org>
> ---
>  drivers/pwm/pwm-omap-dmtimer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks good to me. Unless you object I'd apply with adding
"omap-dmtimer: " to the short log.

Best regards
Uwe

--crydygo6vpaqs2bx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmarSj0ACgkQj4D7WH0S
/k5Qvgf/RPDM4kB7/fcEZF0W6KAFeH80jbWn2u9+QoSp7SmnBsBVc1MDc1kVePJU
2DnOsOAkra3cQbd9v83IBB6JujrBWALvLxHn3ax8zgtLYkjkwcfYKO/a25+l1S8a
XkU8tyzlXGy7rfnTtWPoT/so25+xQTzD5iX1HP2KptwE+pf0p/dvnOGqx1B+cvBC
iYvS6VpuJNqSdU8aK/ffaTepAKjUvm6d+eRiFeFcnSjsZ8vzntHwAl+wnH1sZ25h
ohpZg7UbdrHcNIL6BtcXzyHiuEFY7POvR4LLAlfaZPsVBBI6Yx/sMDPa2SiA6qG3
u0+WXtClKdIFUOkyWvAiQXNGuKI/9Q==
=WGEv
-----END PGP SIGNATURE-----

--crydygo6vpaqs2bx--

