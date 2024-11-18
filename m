Return-Path: <linux-kernel+bounces-413271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 366C89D16BB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 18:06:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9C7DDB26B0A
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 17:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB2E1C07E0;
	Mon, 18 Nov 2024 17:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ETq7BNaa"
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3451D1ADFED;
	Mon, 18 Nov 2024 17:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731949525; cv=none; b=W9+uZOYO0daMq/Xf5+NaQMJB5rAg9QARWfsvLbGt6OnqIKgH0t2MGPqptwld7nhlGUAhk6GbRaPV3gDX0mFroCSS4Oxt4y168z8L1Axa9OAgMuhJVZevxCxjsMvwoh9R31O+N1vxHaDlXMI24nkFOfxLxn8X/VLeEiulVM5YMf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731949525; c=relaxed/simple;
	bh=0IwQEvKuO0n2G8u01ZnPO/ACYYuE0X5NVhRh/jWudak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=f9lR9ekGk4cV39iLmjWc1tn8U7odcvu9MfDPnKawJ7zugaTppKgk0IzyliJDVCwNX+2kESXc52DAq7f4nm5Q3ThO5SJPL1ZiO5fWdtsqrXrZ0X38p7RhfmZWX8m+4WL4dgfnzjk2SYptHmAJvld+aNCIYM5gskwUobpVE0XMbrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ETq7BNaa; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7ee36621734so781850a12.3;
        Mon, 18 Nov 2024 09:05:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731949523; x=1732554323; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0IwQEvKuO0n2G8u01ZnPO/ACYYuE0X5NVhRh/jWudak=;
        b=ETq7BNaaXc7xnxWZtNtzO7WCVWmI2jWZInpj+EVBizvU+yRCQTNDVOgiZHFiD2h6LW
         QCuzITYI4+Z+RhnSph4t3lTyZvByjHhPDiOMJwXTi4D60qm+HXJ5PG/v3fKkLS3Jke3t
         SoeouJ5lCZJNIBpUgJRkTwhmg/5HUNG+p8tTYuHy2+QW3zNTlSZMAaI7ZakLicMBMhCA
         tZxkyd6qcCvmh2ZncEnhLZlH+Wo5UBDCSqGlAg0mndeDg8k5F6M0U8tfkxJfyFE8eZdn
         nkDnCxV1JimZNkxHAZs94f5lFzGPg6uOZ51VckRpv7Hs10iD1dOX95w03e7ynlmtI007
         VofA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731949523; x=1732554323;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0IwQEvKuO0n2G8u01ZnPO/ACYYuE0X5NVhRh/jWudak=;
        b=afW2RXwwQeWKay6FrdEXGgnuUbcGhUuQXp/RPTWcyZSVzykLV5U7eL/qvAqR9jPuZs
         XGCWmetz4FucsEQLPV5MYgpt8KyrvECTtve2TLq7Mfp+LFQt3fDrYYp5/gyHs0pBF1iy
         PfF0i2aWvBix8hGP5TjR4L8F/hPSypR8iP1RL8QzasGDpYsJtfjHFdbLrzbs15joGQhX
         Za1kqAYLEJFikUzHAE2BZgTfS+S0e4bmEaieQ7BzpRRGLo2hfCs5VDX0n0hwe5de+V+V
         f/CRsKNgFLzP24vqIAAUkUEyV/hCmhgP6eiZCRu0/0wCoaBi58YUq3VAsmsODulE0jDM
         gF+A==
X-Forwarded-Encrypted: i=1; AJvYcCVXHXhSTPEZP39XX3RRvU0l+MbWZEpxyjcuNAQt32+nNR0/Ty0Fpu0FDtaw4xxEt8o8X7E9Mzk8uVjButA=@vger.kernel.org, AJvYcCWWMLtk5/FN3qflSFSRn4wb8NSzxTxxCZRSYPhF8iPzIdtnqU9qryUV+L2Ktt0cZUgf8WxeD7g7U9iN2vzmfLc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzN8dlUMsrQBqK5MUV5Lm5FIWPjT/Uc7VgyCHBNivqi1kuLadvv
	QTKe55zucdeoInMp7+jaes/+kVttcRVka7fd2FeJb+IDPI9VdHXGcH34y2f2RSaD4PCBMYFXni1
	NvFLwlZJ0C9isSQl6FefqWTmaUJg=
X-Google-Smtp-Source: AGHT+IH/lhBixklfQhFdqhvMwg0PfSbQZN7tc5UwcxY1luSDL8mqf3c67Zzi0sdplJasM2bzMfO98I6LMQO2SFA7tOE=
X-Received: by 2002:a17:903:22c3:b0:20c:a63e:b678 with SMTP id
 d9443c01a7336-211d0ed64e5mr70230355ad.14.1731949523322; Mon, 18 Nov 2024
 09:05:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118-rust-xarray-bindings-v9-0-3219cdb53685@gmail.com>
 <CANiq72=13uaXS+mptTiQZ7OLpyO_=r7-06cXEujFqtej=150YQ@mail.gmail.com> <CAJ-ks9nqcrOhOSuw+fN9+871W4YEs_rwRJehm=mnAx+M_v8Pqw@mail.gmail.com>
In-Reply-To: <CAJ-ks9nqcrOhOSuw+fN9+871W4YEs_rwRJehm=mnAx+M_v8Pqw@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 18 Nov 2024 18:05:10 +0100
Message-ID: <CANiq72mqtUL==LDcxQfJL+h99PeDceBaktePDSF0kNPNYSmgaw@mail.gmail.com>
Subject: Re: [PATCH v9 0/2] rust: xarray: Add a minimal abstraction for XArray
To: Tamir Duberstein <tamird@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	=?UTF-8?B?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>, 
	Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 18, 2024 at 6:03=E2=80=AFPM Tamir Duberstein <tamird@gmail.com>=
 wrote:
>
> It's fairly different, and I discussed with both of them - we agreed
> that Co-developed-by would not be appropriate.

Thanks for clarifying!

Cheers,
Miguel

