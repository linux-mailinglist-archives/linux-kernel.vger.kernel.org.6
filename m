Return-Path: <linux-kernel+bounces-190670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63DAF8D0132
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 15:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02D00B2731D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 May 2024 13:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74FC215E5DD;
	Mon, 27 May 2024 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="erq9wBZ+"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A5E4EB55
	for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 13:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816015; cv=none; b=FSbGLMqG14iqaJqduOCASIwYWi4F+J2Axt9kj8vMD4TBlGQ7u8DWyRWY2um/5VxALwPP4wuuQ3f55/oDlPU5hcqWQrhL8cn/geM3JUlwU5kyB8PfT/cklbf0f3fp5KTJXsHd48H0beeUq8KLHhcWDISw5KU7eM6JY7YAmItT4rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816015; c=relaxed/simple;
	bh=S6iL6oDWFaJR+E/+A1MILtVvh7HVUlIMKSpUEQQGFBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JuPfyumtkRXR007Rz1ucUr/KF2iHdex1LKUfgXMFkmRm9aisKW1x6VYfVfwoDszEErpM1ib7RC0rPx/Xoz/PIuJZ0z3C2bCUOO0rCUz+tHNNnfcTx/uA5E9h6yGkw4AT+J+dofJ7K2MS3OtbJPUcKx+8cyxvnX661b4wK/4j4KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=erq9wBZ+; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a61b70394c0so924084466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 May 2024 06:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716816012; x=1717420812; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=583OMcuKvHNT1Ww+Sb5JEHcYkO2V/RPQQEiPPcbZRAU=;
        b=erq9wBZ+Ucd45vJa+noeO47HMVHyxRGR6NDAaciHIewkNaCmpj4HObFbZHAUNe4UBQ
         qQ4i/86zgVqVVuaicCWaO1PqhUROduYhtgsNPojBecG5OiE/J9TJMQ/ezJmIb2GSXdMn
         vzCMxcnEq9+5t1OlOk9UeGf1rYwB2t+3iAeX3qzYKlTMY0spqB/3IFEkV2qv8B2WCLHJ
         37cesqQ9xlPX7tnNxXoGzyY5b7UjwoAwDl34/plI9kB753O66aVpz5H+gP+zohSMCcVH
         qEwwPxAMVnrrAKLFxUjamFcSfIvnD2nUY/QijfzJFLDFjRJoXMbbHKvJGxmQJW6fwjjv
         D5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716816012; x=1717420812;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=583OMcuKvHNT1Ww+Sb5JEHcYkO2V/RPQQEiPPcbZRAU=;
        b=vDYaXGX4IJFm/4Ao65F0DR15JP7sF16uGb6qmLCeA0ddHqdt5DFy7MipPtFF5kWaNV
         fwzIyU1/mlJ54nG5g8S5ncSs0KsUeUHy6q2td8eHAdhwwragQXFv7z7h6hV6wVKcotu0
         OjJi9MjtZczlJrOebjjr6mGlxwqANjnZTSOh/v32mXGOc2/7PLHbHIgk2tv6yud8UDrC
         0xh8KdJbiNDra3+A+mNHHLgqjj7KXFYzsZPZSgTQj+UJr+5qhOVKGuH4dWhOq65SxN3t
         n1+S2wv0o2zBJc6OcYvOUqAuhtu+yVYc5mhX+sjuV8KRHi2TltuH90aAqVGPbV2mQfH7
         M3LQ==
X-Gm-Message-State: AOJu0YyXmxgjsgmnDYmQndomBn9diQ3iaciRGLX/WMQYtsaSwWRedCyK
	RkGdg68CKkyxZqjoajpVfDzCv5zqoSwlONvR+1TV88sYFVIAMyoQdT4I+Jdh6iodLIEZ2leVR0D
	o/K6vV4QE7pLVAyhevv5/dnP6hcg=
X-Google-Smtp-Source: AGHT+IFAU5YkoQQCpo2YBJF5cZ7P9SUOU+cK1hlCD0x11A8DdQnGvCOJ3WRTYFceD3JkPIeraFXM9GsH58VbgH3clsU=
X-Received: by 2002:a17:907:971c:b0:a62:cecd:26e3 with SMTP id
 a640c23a62f3a-a62cecd2767mr357363566b.39.1716816012441; Mon, 27 May 2024
 06:20:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240527094320.2653177-1-jani.nikula@intel.com> <20240527094320.2653177-2-jani.nikula@intel.com>
In-Reply-To: <20240527094320.2653177-2-jani.nikula@intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 27 May 2024 16:19:35 +0300
Message-ID: <CAHp75Ve0vyOv3KNY_7286wLKd8u6HOvu0Trm17rs46h-BOGsfA@mail.gmail.com>
Subject: Re: [PATCH 2/2] drm: use mem_is_zero() instead of !memchr_inv(s, 0, n)
To: Jani Nikula <jani.nikula@intel.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	intel-gfx@lists.freedesktop.org, Kees Cook <keescook@chromium.org>, 
	Andy Shevchenko <andy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 12:43=E2=80=AFPM Jani Nikula <jani.nikula@intel.com=
> wrote:
>
> Use the mem_is_zero() helper where possible.

..

> -       if (memchr_inv(guid, 0, 16) =3D=3D NULL) {
> +       if (mem_is_zero(guid, 16)) {
>                 tmp64 =3D get_jiffies_64();
>                 memcpy(&guid[0], &tmp64, sizeof(u64));
>                 memcpy(&guid[8], &tmp64, sizeof(u64));

What is the type of guid? Shouldn't it be guid_t with the respective
guid_is_null()

..

> -       if (memchr_inv(guid, 0, 16))
> +       if (!mem_is_zero(guid, 16))
>                 return true;

Ditto.

--=20
With Best Regards,
Andy Shevchenko

