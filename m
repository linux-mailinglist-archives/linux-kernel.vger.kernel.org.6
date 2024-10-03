Return-Path: <linux-kernel+bounces-349697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F57798FA29
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 01:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C4212855C5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Oct 2024 23:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 665EB1CF296;
	Thu,  3 Oct 2024 23:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Esz+7/aV"
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8376F1AB52D;
	Thu,  3 Oct 2024 23:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727996466; cv=none; b=Lc8/JLI7HUsCP4YxCQ7VaNFStm4Z8pjqhEzfYqWIe8vUbuSHuSF28mrv4FV+yDqh6clHw2SU1KoXtMA/NLo3guqxxiI87w6B3YJOixGgMLpLgXuPmOacwDULZNTHE2o0N6Pdja/LFGjgrEjfE9SMz4q1UDcUOArxXgBwYpL9iDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727996466; c=relaxed/simple;
	bh=MAlNjd2Gjx9vbLZCH67D2CWjR0mlhEINbnWtlORLSo8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rfGWYFvQUqax59s71heASf6h6Z41CIvGngQ0FlKFVYRNAn5QapUg15uKXZcOri86eDklZhFXFwWF7UnKbjdTALqcbdJjytlwoMHqVXZ/yswh9og4FZ+V+APPDwpMlYNQwRRiQFDVGBBQiaA25l48DUSSC5F2DjtYtIx1cEfKzZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Esz+7/aV; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-718e55bca81so250701b3a.2;
        Thu, 03 Oct 2024 16:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727996464; x=1728601264; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JniPPMiNwOcATPoj22n62sJ6W0pTnc5eKePuj587BMI=;
        b=Esz+7/aVunEIUDULIHmWZY8JhPGkPMj3tM+CX9QmfGGdfmiOXCC3fAZuOc5SvrOPuX
         3wV+VftPfnX+m0T4QWvzSbAjVehX+XUF3w36/L1FhLyqD7ngGZGCzY0uC+EPGQQjKot0
         zpuJeN62+OUTb+1XNhxI8/kBryeb8vW1Iucyk6idOPfC5Cc07faUZEP5LJl82teCyDTD
         k5BY7sdGheKSVeb2YI3CUKoHxGmc+pDK/N+RJ3CTkdY2pwLsPpfDwgY8DjOojWKwxl4M
         7v7tDCGzfZv96DWO2MrArPnFpcl2NVDO3TVPcCUGSqHOTSBQxI/EWM7rEotzhIJL8CBo
         EgpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727996464; x=1728601264;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JniPPMiNwOcATPoj22n62sJ6W0pTnc5eKePuj587BMI=;
        b=oYj24/eaZilRRs+bTEagYWDAABQ/GYzOYEjGnTa9rYLt1jsJBOiOn3yMO1X3FDrJmW
         BQBrKPe/WXcigvQzNVVCN2M/tgR8dWngx0IGjFh2gaLlPuHRxjHATrjAYFgz04IqmGCb
         vu3AsRqj75yHz3NCvPsOyDI2E0f0WnOONcbQFBdu15lFaF6N4JBUtyZp4EKsMZ7G/MJd
         CA9azsOWZIgxQ40X391a0sLoBIj2X/2l5DcXdDhJdHjOTqKVlajb4XOORZSyY3lO2/Zp
         5fxOAOFkbyCPGXW2uiySRadnNJTnDOrdlKLnFxIPzcTUTfqGs7DssgP7d8ds5v9d67I+
         gjKw==
X-Forwarded-Encrypted: i=1; AJvYcCUb+t0The+PLMLQPjFN+XveqrRAgDvHOJInD7r9+WSyF7fCjnjsTsQr+ZDVklv4pgb0cLB5Gs+u75IvqJ0=@vger.kernel.org, AJvYcCVYxrHmymdNW73aH8XnwMEXauQ/kpSKfETXwWZBDcxHqUqiRpt50GZSkOErL+YiRPs64LxLara1HCDV1bECNZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxtz0Pl/eucw0GdSCYH/gLvSb+RoS2b6bfBIBpPyUAwaDayENXA
	xx3UEOfyEnhYkdhKM/CyR4AxNrNSRaZ/lxIUA09tundJ1MhM99/5wQU5P8oo1pNavoQH16zHVYB
	bXZca4gMvOU0Sr1FtVtwI1KejGlY=
X-Google-Smtp-Source: AGHT+IF0VZFkojW8u1zXbUFjF1T8Ual4Q5svQy7ix890GXbrNEHO4yIiRHNuFfBZTx4iDG3p78zV10RJXaySpSAE2xA=
X-Received: by 2002:a05:6a20:2452:b0:1cf:4fc0:4ad8 with SMTP id
 adf61e73a8af0-1d6dfa46cb2mr654022637.6.1727996464455; Thu, 03 Oct 2024
 16:01:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241001150008.183102-1-dakr@kernel.org> <20241001150008.183102-12-dakr@kernel.org>
In-Reply-To: <20241001150008.183102-12-dakr@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Fri, 4 Oct 2024 01:00:51 +0200
Message-ID: <CANiq72nN7regVGe_FfONSKE5waG3L2xr-cdY8c0v8Y6xn297EQ@mail.gmail.com>
Subject: Re: [PATCH v8 11/29] rust: alloc: implement kernel `Box`
To: Danilo Krummrich <dakr@kernel.org>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, wedsonaf@gmail.com, 
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, 
	benno.lossin@proton.me, a.hindborg@samsung.com, aliceryhl@google.com, 
	akpm@linux-foundation.org, daniel.almeida@collabora.com, 
	faith.ekstrand@collabora.com, boris.brezillon@collabora.com, 
	lina@asahilina.net, mcanal@igalia.com, zhiw@nvidia.com, cjia@nvidia.com, 
	jhubbard@nvidia.com, airlied@redhat.com, ajanulgu@redhat.com, 
	lyude@redhat.com, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 5:01=E2=80=AFPM Danilo Krummrich <dakr@kernel.org> w=
rote:
>
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// let x =3D KBox::new(24, GFP_KERNEL)?;
> +    /// let ptr =3D KBox::into_raw(x);
> +    /// let x =3D unsafe { KBox::from_raw(ptr) };

This is the only place that, after applying your series on top of the
lints one (i.e. current `rust-next`), triggered a missing `// SAFETY`
comment lint :)

If there is no new version, what do you want me to write when I apply it?

Thanks!

Cheers,
Miguel

