Return-Path: <linux-kernel+bounces-576019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BB8A709E4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 20:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CA727A3A16
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 19:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279891E1DE2;
	Tue, 25 Mar 2025 19:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkQHMeqm"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B551C8619;
	Tue, 25 Mar 2025 19:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742929506; cv=none; b=BFCwae1DjJ3IrR9G9Y0Pw7K85XirxbnCxFB2QsUDkUgPtemiIG2IKxnqE8p7nL5y25TKKAzxng4CWrM0jy5ZPlRoK9rH8U2siS8XQPWoDbTjlzyZ6poPvT33qBoiLXQxT2XqFjRI/acvPn0f70eIviCWxIMZNOuihXhZLcIXRXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742929506; c=relaxed/simple;
	bh=6TMgaEW+9sayzHvoDGxPrtSjxiQA+4hzRkywj2TAG0U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ouCnnS/quqHd0gn/JFjQjFsyp5vsoiDUt/PxmM/1SPC0IfVOqAI/mEKw/A8/KxYOd/6F6a8nWsJBc47Mq3ICIqe54BqtfGn6SWd9NewBXy8ZIiVbmT8nDyPiJPrjS9AFd7Gczn6/J+JMncMAMKG3GSHK88lWtIEHBQUMKkJ0Hs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkQHMeqm; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-2ff6ce72844so1561023a91.2;
        Tue, 25 Mar 2025 12:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742929504; x=1743534304; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6TMgaEW+9sayzHvoDGxPrtSjxiQA+4hzRkywj2TAG0U=;
        b=YkQHMeqmVLLS97tItqY9zjSq9CsYwgffXnuCDnyo3WqBpQfkiCfDQBj1+dOcomWP5i
         vpF2KU9XGpkIpoTNYmDSbyV6v9N3nhfKoxBVHci71B1ClbpD4o8TSLl70W4BaFDDMRSJ
         n80/RMLEX1u9aF5Z7ZdL0WVaC8cHxMs0jtaqauuTrTqPrVkK3FTV7B/BrbniAPIzCcP6
         3p63XsyJq90yP7LZROOQlrG+3Hh3njpOWBJZ5Nv8faF07TPDlY3bM6ib6f6JeGby6Z8U
         juKTT8WXejs7qfeexTBoFJfSn6GBfXTGWjN/8vfbwRBtUIVOh1Ux8CnrQLaQRROd8GEN
         TQgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742929504; x=1743534304;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6TMgaEW+9sayzHvoDGxPrtSjxiQA+4hzRkywj2TAG0U=;
        b=gBSsY2RXnVNW+qYiPagRRu9ttS4kNe2Zx3QdL5dkoIUMBVW08n2snClOWdciORvpCa
         cpALkshOuE1mWVZUfL5de5v+E3KhRQGAqXA6zI7UjG4SEqb6Qb9iDGW5QnNPOJjysbP3
         f8J3ItGvaSNc6L0Ol/AksPZwpGKEN4mNclMqDbGl1h/Xa0dwELP4PX5ZXX+biVb+KFA6
         ENV+BhvgDHzHEIkOS04IUWOzWxI2faUMXJs1oC8EJdj4QKagM0dA0vJXhZNoNP9Nqad4
         MwobjIDt1T0CgPosrnYMNXcESykKcQZ9t2awfpKZqMky8txcgknR8yntFEPTzCD7l/De
         i7SQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW72Jc+jTr5PNRD116bEhtnk0Hv8O0Gno2CKOSAiNouhneR9THdPiHo+5zkK2Ctcv04J5+ubrac/AFSp0=@vger.kernel.org, AJvYcCVBiPbyp0Ly2DPYzT5jWxNVmxGYlN3Kn0Im06cNw2rvXlAafwDeYEFQMeF4fkDEMIJhB4F0NJQyOJKo1sDAHco=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcKankGWPiJM6wfOsIz97Uyrb0SNqGHhFTVWtsEHPiO1INKlx1
	F5B82/+dq/s/bSzHxB17xZPtt/o5LjaCY7m5SJmyBZeCUe1+xgUaKwAoU8O6+CYBadKU7bFNmNM
	z83wXGgCQyoqISICgU+5L1627WLs=
X-Gm-Gg: ASbGncu2e0N5TEGVp1QQpbIk48owlrnUKGzW10mG23H42sq/aTRMU8rCLIYsAEqLNme
	RNTlP3tnPWF/u+JfHsulLEwmbG9JCPaNKMD5N0TJqf+eIw0f5o+cmDvOsM3+O+XWpXtu3AKd6Sv
	TeqPFHOrj2OCS9ZB+UP/zgmyAYyA==
X-Google-Smtp-Source: AGHT+IEaXErss0xXwV0lJBIcOaPCzt+p7KmJRqpZTTvZUvZnCO8fOgnNeypm8mZP1MAMagB1I17kUy/UdhjTcObxQRA=
X-Received: by 2002:a17:90b:3a8d:b0:2ff:7970:d2b6 with SMTP id
 98e67ed59e1d1-3036b4abf73mr2506809a91.5.1742929504147; Tue, 25 Mar 2025
 12:05:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250324210359.1199574-1-ojeda@kernel.org> <20250324210359.1199574-3-ojeda@kernel.org>
 <dd1616d5-4808-46be-9167-6fbfe76e0c73@redhat.com>
In-Reply-To: <dd1616d5-4808-46be-9167-6fbfe76e0c73@redhat.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Tue, 25 Mar 2025 20:04:52 +0100
X-Gm-Features: AQ5f1JpmlWonQlCTJ2hC2bel5qL6r28Y6ygrNFDOCt0MmPyi13zbtF_Iod_7f3o
Message-ID: <CANiq72kz9SW8Rexj7feZRvTAhgF+cBwarpFnqu0TSk6C2r9SRQ@mail.gmail.com>
Subject: Re: [PATCH 02/10] drm/panic: add missing Markdown code span
To: Jocelyn Falempe <jfalempe@redhat.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Benno Lossin <benno.lossin@proton.me>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org, patches@lists.linux.dev, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25, 2025 at 10:05=E2=80=AFAM Jocelyn Falempe <jfalempe@redhat.c=
om> wrote:
>
> Thanks, it looks good to me.
>
> Reviewed-by: Jocelyn Falempe <jfalempe@redhat.com>
>
> You want to take the whole series in the rust tree?
>
> Otherwise I can push the patch 1-2 to drm-misc-next if needed.

Please take them if possible, since others may want to take them
through their tree anyway, plus it should have less conflicts if you
change other bits, plus these are independent fixes anyway that can go
in on their own whether or not the lint gets eventually enabled.

Thanks!

Cheers,
Miguel

