Return-Path: <linux-kernel+bounces-186229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B92B38CC155
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 14:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 213B3B20BF0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 May 2024 12:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16D213D632;
	Wed, 22 May 2024 12:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kULq4VoT"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8D01E86A
	for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 12:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716381455; cv=none; b=ilXDcM4lZd3QV5bhe9W+8TVLwM3pMo7gckK1hGFW3NmbauE6oFDYTi/TSY6Iqmi95yB/VW/eCWtd7wwNAHuYb+U4PM5BY8ArR/cV/TBkI4xjsm3ox2lc0xnew3zFdKFARpwFYKn+qdNaiOllsq/yj7CdI/LW4pKlo/wgcGbVhNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716381455; c=relaxed/simple;
	bh=EMnIYHaY7LLVlAqbN0Em3LajT8YCdusKQh/jH5I8FNA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ChrASqcWq3hj8kHrOhZ796pabRArVx72eDw9YhhYVfIEA8FwlyNZmLgN8xabRWiPTaGutRX2jKiLOMMjrZv5L6yaEosRIUJZIx6h0O6NKQyoaCqj7IyXG9S5fdFW8Xbv+3sqC8y0Lo0wjtCwAp65AEjZYcygybs/BYFPEPgUOeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kULq4VoT; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-351da5838fcso4609985f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 May 2024 05:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1716381451; x=1716986251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P25DPsLo0fuN2OKJTl/EGAh8Y3s1DSkqFIXVqeeCVVc=;
        b=kULq4VoToY2Vat7vm8GGjVA6foF0Uvp7NuZJAGIy/qwIu6TJdSrH8/rXgvsTlUUGtN
         E28mvwzI/Q4zWKdxGVhmPx7unW09xyPwoGQckbRGHR1TEzP2X3iODzruBUrlqnpnpTeF
         Zhwg1DGEKgJEGubaDnwoaGZByR8PTj8eA9ok4xPDLEFwl4pni8WOlxt+45TYFbUlP/1m
         jmau5/scArzcXYJECl+5QBuBvDq+zc8AfZ2gCc2gkDImjpPAT+Dxy8BeHyiziP7M3heA
         gSfi52+83PyN8AScEFHvFGd2wC5lqXkRUi9LeaWprrXKojuLjyVVWeMGd+/Vd4hZ+nGW
         LKPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716381451; x=1716986251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P25DPsLo0fuN2OKJTl/EGAh8Y3s1DSkqFIXVqeeCVVc=;
        b=F5cWpZMVlGEO5Ai3tbSTiFdbcrKuUmfXJNQJaqRRZV/OUNTiWui4UZwvCX8FjzbnZc
         LM7m3GNcgtrWsYLVTOLLPCkrBGpGybY5znyWOoyxocXUDKztZG51A4kqPNZMh5l6jijj
         Z/lBskiGcPNHd5tNFGUeBzcZz5GuMhRcRoFp5y+5Teml4dZ35hJd6kJHwlUM2jrz2JtM
         q0rK+abbcxyGikVaM6V9GNwYxzlvGSByLhxHubTv22/GIDqgNwbBGn2c6O3b/wvAU/Le
         rcoDC1HKMDiUSzOMEcWNqCvhfow0/TRP1PNNPDxDJ2yjLwQ4zLBSXSroWqyaeu/agtvX
         ElWQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTcyYDWSQwlGvMTql3EMonBFXUlv685ec4T6tkQ0nRFYFHMN97xymSJ/jecIDBQ8V0u+ohrY8fpsI068SD78DpxoJe0a4TCWBChCm8
X-Gm-Message-State: AOJu0Yyc5yOzs2hEaSXz73gj0GBitNfHIriNK/s2j6OqGLPPmsGk9qSP
	Ycp1KLZjIvHFY4z+p3b7jJtoaDkOLaOkMRajTt5cP4sgRcgThcC3Uk4u+Evb+VIWQJnuADnnT0+
	qLwslz1oa6ZrFsrmz/IIzz8bC339wipPtE/Gf
X-Google-Smtp-Source: AGHT+IHqXaamjnUmjvBxFPNiRV+xFMiG4l6hh3Y9Gjymq+7Usr/czLNVkJc84E+5l0e/SJVREuKfW8ugea4XTlNrNck=
X-Received: by 2002:a5d:4104:0:b0:354:f2a7:97dc with SMTP id
 ffacd0b85a97d-354f2a79916mr422094f8f.2.1716381451014; Wed, 22 May 2024
 05:37:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ME0P282MB48901A79E405F9CF615FF2F1CCEB2@ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM>
In-Reply-To: <ME0P282MB48901A79E405F9CF615FF2F1CCEB2@ME0P282MB4890.AUSP282.PROD.OUTLOOK.COM>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 22 May 2024 14:37:19 +0200
Message-ID: <CAH5fLgiL7EdnzRL79x4zX0pXrtb8OjVkRib+qkoi=TyzHzEc4A@mail.gmail.com>
Subject: Re: [PATCH] rust: kernel: make impl_has_work compatible with more
 complex generics
To: mu001999 <mu001999@outlook.com>
Cc: ojeda@kernel.org, boqun.feng@gmail.com, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 22, 2024 at 2:27=E2=80=AFPM mu001999 <mu001999@outlook.com> wro=
te:
>
> Signed-off-by: mu001999 <mu001999@outlook.com>

Please provide a more complete commit description. What user motivates
this change?

>  impl_has_work! {
> -    impl<T> HasWork<Self> for ClosureWork<T> { self.work }
> +    impl{T} HasWork<Self> for ClosureWork<T> { self.work }
>  }

I ended up doing something similar for the generics in some of the
linked list patches. Does anyone know if it's possible to support this
without giving up the <T> syntax?

Alice

