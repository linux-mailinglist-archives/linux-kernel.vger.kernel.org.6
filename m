Return-Path: <linux-kernel+bounces-390003-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EDCC9B745A
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 07:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152EE1F22B2C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 06:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0086140360;
	Thu, 31 Oct 2024 06:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MGrio9ey"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABCF13DB99;
	Thu, 31 Oct 2024 06:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730355311; cv=none; b=nxUs84tZgjmOgB3pgdPooiC5r9kE7801JYBHfIEksQFgZU4gJkq99or3h8BKjNldyPVyTBWMto8XIwxkfmqBBnsG+Fnj4z4hui1FSu5ks+1W85Ey29YuAdSg11wAieQWNtzqHlpdxQDYoPE7c3/5j95RFxSd5moqBs2yZZsubHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730355311; c=relaxed/simple;
	bh=DnuqAVCDEoiNqvIljcES2Gj6fmR7w07gT8Kjtmhb/PQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uYXiQnXu0jOzqJU/2/MI1w6+jcReQhLCnPpXRRiDsqvfE0eEARgr+yevAXhiBgItZA8F0y1iagu3Cc4cG8oBO3Etvq2PeYPIJO7Wa7AoqaK+91QVRQ0gzn8PQxAiPX0c3Ep/lfmYWanViJptqD92FMv5dbKq1OBUTLpRfuHUa10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MGrio9ey; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-71e592d7f6eso436493b3a.3;
        Wed, 30 Oct 2024 23:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730355309; x=1730960109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XNHizp3vdR2jJwWfWzhOjHw4wEUjGKp2hXV+t4+ArSE=;
        b=MGrio9eyI6bgdOT4iv3XWN5rgY9Y6gDHd46FMR7P2v29yJyDjjaOEqnEekWhbjG0mb
         fvYHGN4eItTB/St1Ff0fRWQnzndO2zhj7yThGSnwIPItbAf29C1e8abuMfr/IqwyZSoF
         lzLatwErtXdpXePp99EirLPFcLdsCe4maKjHCT9Rajp472V4puM9tiQjNODV52ukjrTJ
         yLoqG0qaUzcyyN6Jf40TzuJzvabwh9sxi6H6bp19TKgb7+TT8Oo8xV9TQ9RVi4qJrvN8
         NF7DHQeW1tILeOANkBWwiojnHGNaOmATT0FM2rffJBniS4l3aWyzlsl2B6Jc4SXz5c5n
         2gCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730355309; x=1730960109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XNHizp3vdR2jJwWfWzhOjHw4wEUjGKp2hXV+t4+ArSE=;
        b=QuajytvI/Om7GEIXbONUvk84p7sZpJMozNkJneHWc3zsBonRrEcgTo7WXJz/q9gAjT
         bJGFmSsJj3kJaapLrSJvOmdDkoqTSzyezpJt8EVBVgQeXYzaWgGdIuvGRtv1ntExjbzD
         3JJ/4abJEynBynpox9smzJ4AtmDg1bfN9Z6VOJUfgURZyVsOwFxxC0TXj6j0GMj+iRPk
         yHX/3IlnwtmH7TH+GuizIGUV36e/wopfwn/ICoTCWZrE9XlOXEknPzKHMAN4psA5WUij
         iHPx7LpfRSsPOGzwxQe19TCtuetstDpffyzXWcVKf3vwMJhn6zNafYqXZmkjuREYkxjK
         TICw==
X-Forwarded-Encrypted: i=1; AJvYcCVY5tFJqh8LWwtLGHGkbam3IV1ygE7VW4a5ByfrSHtui+YtsmqECe9QsI5rs8C9qsaGPTKez98G2Z1bkSZ9@vger.kernel.org, AJvYcCXcnKof6c+E3XnLBLLEZ19y00I4+GQI89eZyyb3FjMV2pdFkiBhjPLSv9DRz6xdYenYdJV/v8ceTVSg@vger.kernel.org
X-Gm-Message-State: AOJu0Yxzq2eNsBOPOGQYjkHl4Im1T3H3nDFYpl7yqBu+8KtmSStvGnMz
	MddyLodiwrqxa7HyRze5P5Q0N3gqsBiat6LkAWclGnLUIG28cvuy
X-Google-Smtp-Source: AGHT+IHe8ZlhfO4mUD9OaBTVRSTp19pxfjwgeX5Q24Oh31kpwAwy3z/U7oVNpbqUXJpwMzMLLWNxEw==
X-Received: by 2002:a05:6a00:b48:b0:71e:69e:596b with SMTP id d2e1a72fcca58-7206306de29mr24794428b3a.17.1730355308831;
        Wed, 30 Oct 2024 23:15:08 -0700 (PDT)
Received: from localhost ([2001:da8:7001:11::cb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c54c2sm567916b3a.134.2024.10.30.23.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 23:15:08 -0700 (PDT)
Date: Thu, 31 Oct 2024 14:14:40 +0800
From: Inochi Amaoto <inochiama@gmail.com>
To: Conor Dooley <conor+dt@kernel.org>
Cc: Chen Wang <unicorn_wang@outlook.com>, 
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Peter Zijlstra <peterz@infradead.org>, Inochi Amaoto <inochiama@outlook.com>, 
	Guo Ren <guoren@kernel.org>, Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	Yangyu Chen <cyy@cyyself.name>, Anup Patel <apatel@ventanamicro.com>, 
	Hal Feng <hal.feng@starfivetech.com>, Geert Uytterhoeven <geert+renesas@glider.be>, 
	Yixun Lan <dlan@gentoo.org>, Longbin Li <looong.bin@gmail.com>, 
	Inochi Amaoto <inochiama@gmail.com>, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v5 1/3] dt-bindings: interrupt-controller: Add Sophgo
 SG2044 ACLINT SSWI
Message-ID: <esuteqvz37blehx6wa5cj5ixlglcbullhuls3rcvjtuiviqqpb@ojho3arlnwst>
References: <20241031060859.722258-1-inochiama@gmail.com>
 <20241031060859.722258-2-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241031060859.722258-2-inochiama@gmail.com>

On Thu, Oct 31, 2024 at 02:08:57PM +0800, Inochi Amaoto wrote:
> Sophgo SG2044 has a new version of T-HEAD C920, which implement
> a fully featured T-HEAD ACLINT device. This ACLINT device contains
> a SSWI device to support fast S-mode IPI.
> 
> Add necessary compatible string for the T-HEAD ACLINT sswi device.
> 
> Link: https://www.xrvm.com/product/xuantie/C920
> Signed-off-by: Inochi Amaoto <inochiama@gmail.com>

Hi, Conor,

Could you review it again? I have updated the description of
the binding and mark the device is T-HEAD specific.

Regards,
Inochi


