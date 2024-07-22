Return-Path: <linux-kernel+bounces-258690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3438938BB1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 11:02:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20C0B1C21279
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 09:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5797612B63;
	Mon, 22 Jul 2024 09:02:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bHh10a9z"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1330D523A
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 09:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721638945; cv=none; b=qY+6Gx2qseDJAWI/hkUw6DA/82y4uy9F2TBpehQDIH5xGpG7vKNC5c74EcqBMy98E8iA3Ismk+OS8coMwzu2CFg+6TL+YsVFL5Sa2QsHZScHZTJJDpUYef0YNsjck4fJ6TMGagOfGpW6pOVdrHYNfr8atlSytc0nSO+V57sbAIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721638945; c=relaxed/simple;
	bh=U0lkHrSTLCBCsQqeMoWQa6ogRlMB0DgaC4BX0Yn3Nuk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fX2LogoNtzhZepc9rukXlx+lv9LEKcRS7Dknyxc9O9UUuCD4DwBECD3Z/Qb3u7IH8GcFD7zuebxdDyrMTo2a2sJ1oRrcgZp6XPgA4UTj6cYnoHQH0jZjf/B5erukCKA+kG8iaQqnF8+c4s9YtfXHL1r62BF2Ziw+/SOwG8ALGUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bHh10a9z; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4279c924ca7so29188335e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 02:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721638942; x=1722243742; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qy3prohTdKukbZeeTIm9GnFzCUR4CLmWXZ94N/+yPNg=;
        b=bHh10a9zXpnIouUPEsgpgjUXSGRHoYLxbz2t5Yhp4MimzlrtFNFL09Je/X9TUbafSg
         FU6Z45sNiY3gMtBA/cL/xfVNMhrgs2o/fLGftBUu3tKhxIoVCJijEXTAhRtR9B+XhNEx
         4f2AHWnV87a0fMPiIcKYTVBxgQsQNBgpgiIQOx2xqhX5gQ280k4BqHGI0XCP7xvdDSN/
         XJlF/LtDktx6qy/nXT55nAHB+vP7yWv0OuEYvqHzUXY8hurukMWoujWocFIcC3XWSElU
         wtL1cpS6ybPRjAHSXYr9WkBCKo6IGKpG2oUrhXmZlk3fgcU8AIHeSjEmIDrgeftt1msr
         N/kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721638942; x=1722243742;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qy3prohTdKukbZeeTIm9GnFzCUR4CLmWXZ94N/+yPNg=;
        b=KEm1w5F2TiF1Oq52LvqwXmDGvY38WYKpv4GaS27IrNJxzuqEu+KVh57L8PfqBJCJcv
         F7FAzt1UiAgOhJ7HBrT3f5DalrE3wy/z3ObQkoTeU9QBcZ0l00YLqX1qBGjF6LBqudiv
         FCAOMqV0cGsOESCAS9Xde64Yw2DyZmuguOfmFFALMB2UYb2v7KMAOW8WDBF/d7+EKEki
         1ax0KQvLrHoyif3uS1F/NoWCCdef5l7ZzYdgCVYr2OUSmCJLJOO04Mu2aDJ6vSZFbJMd
         P2eaAB0qbXFdke3+NyIQ8H39ncHsbuT+55BiQrCULUDvA1VkGl38Z5nQnkB8lQmDAE5u
         sD1g==
X-Forwarded-Encrypted: i=1; AJvYcCVc35ox20VHyNBX6PAdqpkpAhEGunlvBBn2FOtjOCax/gI0t2QWPt8y0TKQBkeiFML9W2/b1sDuWCiOcFbXni05jJfhnGAA/lNh4rqB
X-Gm-Message-State: AOJu0YxNc4+Vb2usIhjbrFVl8Ml45XDEq2Q2F6ltVatz8MqZoRj81TLa
	mQhgfFiWX0MnXCtYb5jM7qa8lATUaj/Z4lYdB0DHqjFrF9zVy4FHbPQkTOt8bIrBYBPM76AV7mF
	Jm7iEtGhrUem2AUHxIdWBSk3xCCuvTjadYSGf
X-Google-Smtp-Source: AGHT+IEsd5dvn5A2mqFen80qMtQ/JIIOvc7TZZUXavWiZyTt87ua1ZrxMMfyPbkZftrRqdx1QVfeZSkwq8qIrzDoYMM=
X-Received: by 2002:adf:a382:0:b0:368:3f61:b955 with SMTP id
 ffacd0b85a97d-369bae6b08cmr3273430f8f.38.1721638942107; Mon, 22 Jul 2024
 02:02:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717142644.1106060-1-jfalempe@redhat.com> <20240717142644.1106060-5-jfalempe@redhat.com>
In-Reply-To: <20240717142644.1106060-5-jfalempe@redhat.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 22 Jul 2024 11:02:09 +0200
Message-ID: <CAH5fLgj2v-7Fx8pwrnQCkHXZeR6m7kOBRzBDS94hjh9BsT+vtw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] drm/panic: Add a QR code panic screen
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Wedson Almeida Filho <wedsonaf@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Bjorn Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <benno.lossin@proton.me>, 
	Andreas Hindborg <a.hindborg@samsung.com>, linux-kernel@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org, 
	Danilo Krummrich <dakr@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 17, 2024 at 4:27=E2=80=AFPM Jocelyn Falempe <jfalempe@redhat.co=
m> wrote:
>
> This patch adds a new panic screen, with a QR code and the kmsg data
> embedded.
> If DRM_PANIC_SCREEN_QR_CODE_URL is set, then the kmsg data will be
> compressed with zlib and encoded as a numerical segment, and appended
> to the URL as a URL parameter. This allows to save space, and put
> about ~7500 bytes of kmsg data, in a V40 QR code.
> Linux distributions can customize the URL, and put a web frontend to
> directly open a bug report with the kmsg data.
>
> Otherwise the kmsg data will be encoded as a binary segment (ie raw
> ascii) and only a maximum of 2953 bytes of kmsg data will be
> available in the QR code.
>
> You can also limit the QR code size with DRM_PANIC_SCREEN_QR_VERSION.
>
> Signed-off-by: Jocelyn Falempe <jfalempe@redhat.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice

> v2:
>  * Rewrite the rust comments with Markdown (Alice Ryhl)
>  * Mark drm_panic_qr_generate() as unsafe (Alice Ryhl)
>  * Use CStr directly, and remove the call to as_str_unchecked()
>    (Alice Ryhl)
>  * Add a check for data_len <=3D data_size (Greg KH)
>
> v3:
>  * Fix all rust comments (typo, punctuation) (Miguel Ojeda)
>  * Change the wording of safety comments (Alice Ryhl)
>  * Add a link to the javascript decoder in the Kconfig (Greg KH)
>  * Fix data_size and tmp_size check in drm_panic_qr_generate()
>
> v4:
>  * Fix the logic to find next line and skip the '\n' (Alic Ryhl)
>  * Remove __LOG_PREFIX as it's not used (Alice Ryhl)

