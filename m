Return-Path: <linux-kernel+bounces-280922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D8DFE94D0FD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 15:16:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BE031F21BF5
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Aug 2024 13:16:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612E9194C75;
	Fri,  9 Aug 2024 13:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ij8QSxps"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2323418C93F
	for <linux-kernel@vger.kernel.org>; Fri,  9 Aug 2024 13:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723209389; cv=none; b=MQlv3Fdel3x0YKwOpSXYslUjV4kOSP9eYS23b7Rxk37igQyOBo3lTvEtEGMQy+yMbD4uX1go4Qe1pgeC/uvesFZ78gRV9+bGIz5vhOfcEBvTiqC6W9x4q+MELSXrJf2aWb/PiF9ED6vcKPV/xHrYMp/3nWuP5xgB1QXfbDKBhng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723209389; c=relaxed/simple;
	bh=92qOkLCSYu9nmceUlAEJm9hX6RmjzSfHnPjdMwunYvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Knzw3isNKkdeYSzCsWVkRCVglMvYIZqQQPtsp0XND/dYV8yQkGFfASTwdn+FHq9PRCrhY4Fm0/AOsfSxdD7W8Ac/m2OSodIlRwfqtG9pt5JoIm/uvABG3aJuro++sOUHEabBhQnsihwbNikoZxeFgooBUtMzcce6jWkR2xvKrR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ij8QSxps; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-428e3129851so14766165e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2024 06:16:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723209386; x=1723814186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=92qOkLCSYu9nmceUlAEJm9hX6RmjzSfHnPjdMwunYvU=;
        b=ij8QSxpsg2UMcdzOEQX4CYZL1OeZI4vWBGBX5QHtR3glQk7bQDkbcfZhjuXimJCudH
         HS5Qro1ADMVr/yIVw9KUDRSoYTGNYoBN/PN8EGYzuOGYGcBWeAJxMKCrbw2g7Ol6YTXy
         ZrckBN1y/ao7E8gjfUxDlFipKqZBIM1IEoxzy/a2Zrp/wgmYa8fjd0Y1oMml3OXg77OM
         5GlzIJ/Gh4dAwfe5hrPUNoMgeCzDM63gLQ5D+qwvtPS3WksSw643bob6/XSPO7QC07GH
         J2CgivjRtgZslYmjhwokSkBfNPFGpotCtDXHVk2g7PVASHrSVPCFVjuyuL9eREjEPrQO
         5Kww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723209386; x=1723814186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=92qOkLCSYu9nmceUlAEJm9hX6RmjzSfHnPjdMwunYvU=;
        b=Qyr/Pi7wKokd+r8hHT/HCE3oABx0WLqVj/uQqcWm+DIHbq2zHB5DJQMe39sCaxoOLY
         jH/gy7lth8497We1T8rhPTInHtIBOTABuO0kN2MwqmLo5x2ESJerRgGuOigb/uS/MjGG
         bmv4/FC2XPEpxegDKm+pFm2uDDKOLIm/OXPj23NMA7UBtcBJjOeevEjdNj0pCRIimX5Q
         zkox0aPAw6esE24Gx3nuMhi6otcKE7GveaPXKXuEIECKuXgPldb9uklsPM2kqwUVViP9
         XnxG4DahiEpcO0M024g5znRtcnl1JFlWM3+OJZ83DzVZimtG3CCGeBqMMSNPf3rYrq8r
         j45A==
X-Forwarded-Encrypted: i=1; AJvYcCWwgZTvQmfTp35MoEta7Nk+v+xZVCNRZE2mS5sJurXwdssCgY8dU1SsJkvWVAYWkdz5yj9BPx0cxAm7IhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgu1x5zgv3ueMoUtx98reVoQRUJgD2SgGgL+FL1fmPv35r7qge
	0CewKioKFZ6bQCkfNyNMy0BxOmNeHF9pR3ofyHeMZ+ZFf6nAop48yx1XcKHBQsnDXK9Si/QDiq2
	o7rh5HQsf7GvrvaJmI8I6kpRhhH8DcQC92uXW
X-Google-Smtp-Source: AGHT+IEencuwb5ZiZqBxrl2yiXarWFIGCnvBaoEIUj3k90VcnrheSq2WUA4koqg2hebfaLRX95IYrP+jEef8wEWRJhg=
X-Received: by 2002:adf:f545:0:b0:369:c6d7:7b93 with SMTP id
 ffacd0b85a97d-36d5ea00d30mr1177252f8f.28.1723209386152; Fri, 09 Aug 2024
 06:16:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809064222.3527881-1-aliceryhl@google.com> <975158d8-4f26-4b5c-9cc7-eec15d901eb6@kernel.dk>
In-Reply-To: <975158d8-4f26-4b5c-9cc7-eec15d901eb6@kernel.dk>
From: Alice Ryhl <aliceryhl@google.com>
Date: Fri, 9 Aug 2024 15:16:13 +0200
Message-ID: <CAH5fLgiqQ6GxPk4-JCdRnKmi9ECgzVj+MkoUnZLYtUp8-yCebQ@mail.gmail.com>
Subject: Re: [PATCH] rust: sort includes in bindings_helper.h
To: Jens Axboe <axboe@kernel.dk>
Cc: Miguel Ojeda <ojeda@kernel.org>, Andreas Hindborg <a.hindborg@samsung.com>, 
	linux-block@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 3:07=E2=80=AFPM Jens Axboe <axboe@kernel.dk> wrote:
>
> On 8/9/24 12:42 AM, Alice Ryhl wrote:
> > Dash has ascii value 45 and underscore has ascii value 95, so to
> > correctly sort the includes, the underscore should be last.
>
> This commit message lacks an explanation for why the change is
> being done. Yes it states that it brings the headers in ascii
> sort order, but WHY?

I can add the following to the commit message:

The headers in this file are sorted alphabetically, which makes it
easy to quickly resolve conflicts by selecting all of the headers and
invoking :'<,'>sort to sort them. To keep this technique to resolve
conflicts working, also apply sorting to symbols that are not letters.

Alice

