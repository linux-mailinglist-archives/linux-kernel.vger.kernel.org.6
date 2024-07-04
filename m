Return-Path: <linux-kernel+bounces-240817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC78292732E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 11:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82EA41F22A44
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jul 2024 09:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84601AB50E;
	Thu,  4 Jul 2024 09:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eym81bar"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF824748F
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jul 2024 09:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720085890; cv=none; b=r22/TQMhctyVS1noxA914r6wLSsEPPtY14BdrYJHAJlOLRZP8cfxe0t2OZ8fCgIQ9+yUeScp28mtKgXV1uTOoqjoz6speGKydr140RSzhv8gXA6tWh8i9f+ke7lAXM3fARr0BxXIFfmQ5Tm9OUbh7ePyL5KCVkPS5Nf/TOqhCVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720085890; c=relaxed/simple;
	bh=B61Ndz/Y+22Ue4UGWv4+nbcIEIQi+VpzgZKgjVAJvzU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dCO2Iafs/RphfvRIqShvP4BSLxloy/ijIgGokkL8tpfOaYOt6RbnY7xeDAizVM908qulYDW4+WkctGhf0/kKXc02SCGsJ79wRlEjSblj+IXcwLfsKoaRi0J970YajSbYAAG6R7i7m++ln9+QOqbpMDuoa4e0L8Y9hnP9jShn3sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eym81bar; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4257a390a4eso2863765e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jul 2024 02:38:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720085887; x=1720690687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B61Ndz/Y+22Ue4UGWv4+nbcIEIQi+VpzgZKgjVAJvzU=;
        b=eym81bar6JP18wEX50i6iHsHNMEBhsQMlagQM1y6+zurejJkEbqzOniEP25w1SnWYv
         JRStVrnu253gDQCggvWRoYNs1b6O5DJg4MyW3e2oAPBiNpQdRfRAQWKA6F+VruKitVk7
         bLunWSgnI6nrw7IdwK9MzOfn6Yd5PYVKt+CXre/Ek738QRd4I1xPbXMJ5aKeYrjSIRTF
         PWkT277+MDhYD8h5P1LR7nBeCu3uWyMtzRpQRsHGrE1TLh0MQVJ7wPpZbvIAbMJ8/AQ6
         ZaRLWw2O6ADr6Lx8Ci4CvOCdNlNdQZw1xUplPencGaaWtv4AiAb+n7K9SGMLZVefMyn+
         fAWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720085887; x=1720690687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B61Ndz/Y+22Ue4UGWv4+nbcIEIQi+VpzgZKgjVAJvzU=;
        b=iKWGAMFnYzfFXMi0yo6bRKcZ2eTTSTCeH0V5bo3t+KiER6LVdD7IH8Lt+0f+JVPNGI
         GW37tX6LSCXJfWeTzkJ5s5NMb8l1+/aLosadDJgR9IlotC6ziWTyHA4oW+LK/b4R5zUN
         ptUxjLjmiGV/gkdzHOEzUTFmoPAnbLAHiZ1uebxzBIiceIRTXSVmL8h66atnjsF2Ds3z
         1oqIc6CarGWPJqCzrcXcjk28A07S0ajoL2jVthuRDWtnB4S1EWpZ7UyxWL3qTeNKueWy
         0imKy2V0e4qB3WC8RBwy2XbHm4pZdCPGg9WR6ZJibmwcWzn3BHdUQUkpbXOpKjoNqFhG
         p+Bg==
X-Forwarded-Encrypted: i=1; AJvYcCXmZ760s24SCuMYNUyWBg9qG5g3JrBKI1XS8Pe7dC75VjZizpr0gXDC5FwC3m7hNjkAq4tByDmXdyMks74tCW+0HRk05v5+YZL8/x1p
X-Gm-Message-State: AOJu0YwJTH5BrSqw7O6lFMnPdOU0qlO1zHxmInBsvPoncbDgVDTpwJeq
	9DHXoIsFzxziDHgB6I4AtEvzB2o5psrnnXlQWDIqNeUEX6BR1+B1EW49Z2KqySeyXgH5A/ifjQ2
	6ivltJcauj1gEmZ96UxgXCZmxcgRX7IIWs1YZ
X-Google-Smtp-Source: AGHT+IE3csL2P+Oa1bm2MMKxJf3sdfNwLRB7vTutviF9jHId7ofiRmfWJCeXK5ZIB/EESpULmX6hfWO8Mr00zUiietA=
X-Received: by 2002:a05:600c:887:b0:425:7784:56e8 with SMTP id
 5b1f17b1804b1-4264a4319f9mr7152035e9.28.1720085886954; Thu, 04 Jul 2024
 02:38:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240703154309.426867-5-jfalempe@redhat.com> <20240704091109.1453809-1-aliceryhl@google.com>
 <2024070407-pregnancy-hazing-add9@gregkh>
In-Reply-To: <2024070407-pregnancy-hazing-add9@gregkh>
From: Alice Ryhl <aliceryhl@google.com>
Date: Thu, 4 Jul 2024 11:37:55 +0200
Message-ID: <CAH5fLghobuv39Pv5gUrieridzHg5ouAESCOdXGWcjAe=yx1U+A@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/panic: Add a qr_code panic screen
To: Greg KH <gregkh@linuxfoundation.org>
Cc: jfalempe@redhat.com, a.hindborg@samsung.com, airlied@gmail.com, 
	alex.gaynor@gmail.com, benno.lossin@proton.me, bjorn3_gh@protonmail.com, 
	boqun.feng@gmail.com, dakr@redhat.com, daniel@ffwll.ch, 
	dri-devel@lists.freedesktop.org, gary@garyguo.net, 
	linux-kernel@vger.kernel.org, maarten.lankhorst@linux.intel.com, 
	mripard@kernel.org, ojeda@kernel.org, rust-for-linux@vger.kernel.org, 
	tzimmermann@suse.de, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 4, 2024 at 11:28=E2=80=AFAM Greg KH <gregkh@linuxfoundation.org=
> wrote:
>
> On Thu, Jul 04, 2024 at 09:11:09AM +0000, Alice Ryhl wrote:
> > As long as the above requirements are satisfied, calling
> > `drm_panic_qr_generate` should never cause memory unsafety, so this is
> > an appropriate list of safety requirements.
> >
> > (You also require that `data_len <=3D data_size`, but if this is violat=
ed
> > you get a kernel panic which isn't a memory safety problem, so it does
> > not need to be listed in the safety requirements.)
>
> Panicing while trying to print out a panic message is not a good idea,
> so enforcing this would be nice :)

I guess it would make sense to have an if that verifies that `data_len
<=3D data_size` at the top of drm_panic_qr_generate.

Alice

