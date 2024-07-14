Return-Path: <linux-kernel+bounces-251858-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F3A930ABB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 18:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB5AD1C20924
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jul 2024 16:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7FE13AA2C;
	Sun, 14 Jul 2024 16:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jZTP9z7u"
Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57BA1E52A
	for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 16:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720973655; cv=none; b=rln2zmrw0HMwWglIzOCHES8j+YqnJtdJ9LBiP98VoQ8ckiVKpDywW0pQoCZJsPR30AblcV8sJrY5AXkheEWgJmp5ovZnEgYohrq98fRyo3CypO44nRXhFwA6SZCo2HEHryLANIU21HvyFTEXGD53ylz/7P5AKwiWNq5iniQ1+Q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720973655; c=relaxed/simple;
	bh=6Yyn4bM42Ap4ZrCijPtVJNkueH9wiTy2GjVXWUySv8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Un1DI+w5FPXo1D4JR5ua57U+KRPDZAFetxuGHWhHdvmAedYLfrWZ99585GWMbP5qWW6SwyQQorInuq86PwlKa5p0LlZXnGDyW8TkI9gfnUvr3PsXtiueNZGCtwM48ObYf2qTXp0B8hlAHPvE368OgPMYdnOpAQOWbnlUtw0P/Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jZTP9z7u; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-81021667125so1178033241.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jul 2024 09:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720973653; x=1721578453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Yyn4bM42Ap4ZrCijPtVJNkueH9wiTy2GjVXWUySv8Q=;
        b=jZTP9z7uydXo/b004zfe1TgGLrcboiNgzCi2EHJ7JY8J3iRacH0n0j75upaOtDhNif
         yaz6IOp7+i72NqnpN8gx7fONjeaYZYiinhCaLgRfPy/t/yUij8cxkGCDWm5fmRJfTNBY
         e7N3ddxL5VkXs3AtlWkUi4MhIHrVJjdjwr0FBgeRLN3saUjGbkbzxE+YpS9dhVFuZfd3
         NxNQpeNVylSuKkmG0i3LCRv4zuruAnivUCLlJmfN9YnxOufEA44F7tEbqbJcQv9RPtgv
         ApJL4m2kycSoeiFrKCXiZ5rri8Pjkc0SJhsmZz1mW0YCMrLTubw1IqfGqpFzpiOPybSF
         tLqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720973653; x=1721578453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Yyn4bM42Ap4ZrCijPtVJNkueH9wiTy2GjVXWUySv8Q=;
        b=n5k1xZzY0/2015RWXOECeUAO/lf6JS2I64WRm1ZKFWiElqXFrm8gKC7/NHtyZIFIx4
         uu1e3/Qb/wuhieVRy0XQ5YB4l050VdO+srZgjjcm157PaoS/Wo70RFBNjGHr3/6PnxYe
         IVR/+a/FnaBowxStXQRc/49uteklu6qqxTQRdVfZOsxHNZMYC+xM1DPMLcpBUds9HzRS
         j3DvnjrOMurLAuzFz9usI7rZOzfWTUcx42vC3x30vVlq6MV9HhlQeHNMHWYfy3jHWcWj
         c0uX7Yqua1HZBQh3Qx9isrIoTqnyJbCHcrsfCdoPOZkqy65YdhNWcVGrVavr0gEfjhrI
         oiLQ==
X-Forwarded-Encrypted: i=1; AJvYcCXyNq98nAoarwG6q63FQLy/Z+11OxoHjKEHHjIDbb8cCuOa95Z2nMBLTDVP5Xa02BBipQoM7R4FCY9fJ8T5H21zXUp38cyURQqQ28Fw
X-Gm-Message-State: AOJu0YyjOXWHVf+s356Va5uwq8beDY9EX+tGxdN2xkWcTpMl8v9QVEDt
	Y9LWWtWGirHboWY7IZh1L/e458LWHbqOC0BNRXIpGXMQUa8RnBv1zuhK60rCPDooB7SYvmuTYF5
	JHe+WNt9cKGQnzWVwS8A2KXwJ6vA=
X-Google-Smtp-Source: AGHT+IGJpHdSKRAkgcgSszPtuJsHHRbse+wAzDBjWHdhQlSC6mBAg6s9Wu/C6A9Crh6oLSWE6phJW+y6tuTOyGtTC6U=
X-Received: by 2002:a05:6102:32c1:b0:48f:1bea:3c70 with SMTP id
 ada2fe7eead31-49032147ae1mr19644741137.17.1720973652595; Sun, 14 Jul 2024
 09:14:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702215804.2201271-1-jim.cromie@gmail.com>
 <20240702215804.2201271-28-jim.cromie@gmail.com> <22bc825c-d726-4a4d-bd3a-508773c04071@collabora.com>
In-Reply-To: <22bc825c-d726-4a4d-bd3a-508773c04071@collabora.com>
From: jim.cromie@gmail.com
Date: Sun, 14 Jul 2024 10:13:46 -0600
Message-ID: <CAJfuBxzLiWn_t6VDxzYzfjm6GaZcjeASwBX7Nbma6yGBKEtB9A@mail.gmail.com>
Subject: Re: [PATCH v9 27/52] selftests-dyndbg: check KCONFIG_CONFIG to avoid
 silly fails
To: Helen Koike <helen.koike@collabora.com>
Cc: daniel.vetter@ffwll.ch, tvrtko.ursulin@linux.intel.com, 
	jani.nikula@intel.com, ville.syrjala@linux.intel.com, jbaron@akamai.com, 
	gregkh@linuxfoundation.org, ukaszb@chromium.org, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org, 
	intel-gvt-dev@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	linux@rasmusvillemoes.dk, joe@perches.com, mcgrof@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 10, 2024 at 2:23=E2=80=AFPM Helen Koike <helen.koike@collabora.=
com> wrote:
>
>
>
> On 02/07/2024 18:57, Jim Cromie wrote:
> > Several tests are dependent upon config choices. Lets avoid failing
> > where that is noise.
> >
...
> >
> > test_mod_submod() recaps the bug found in DRM-CI where drivers werent
>
> If this fixes any but listed in drm/ci/xfails folder, please update it to=
o.
>
> Regards,
> Helen

This looks like a good avenue to follow, thanks for the hint

