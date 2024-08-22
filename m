Return-Path: <linux-kernel+bounces-296208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82A6895A7A6
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 00:13:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1297A2841B0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 22:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553A217BB30;
	Wed, 21 Aug 2024 22:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gghBrVpR"
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E97379D1;
	Wed, 21 Aug 2024 22:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724278391; cv=none; b=qCMcH6SG+lKkm3uIe6HW2Li339r1sRUc02bYiQxFOoMRIEjINAJFHGz2Qkt6kx6TcWp4hVzzeqfQyTGuz1oEWwBvo2CyLKEnCGMXD+vZvud+Sc1c4g8c+xr73zhXdTcUBy+U8Hr7Jlonq5wginFbeTu2IfCvVoblQg6ipxxL8GA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724278391; c=relaxed/simple;
	bh=gy3kLIaleiVIHByaXjXNu2tCJzHMdUmyUeCRezl9d40=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GQioDGYP/2GhLFgPLStfv5qnu0YrcACRUl5nshuoTS8i+xQN0pSPyu7TCDFF5kMzIRigq1MEuQopign1il7tzsm/sFUSVNuG5ICrOh4n4OliV5gzJt0JqT8rM2YVWFWV0HuMQtoPIKZ80ks6nR/w0jL85EF5ruWiMqZ3hHvt7RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gghBrVpR; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2d3c99c5d69so17852a91.1;
        Wed, 21 Aug 2024 15:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724278389; x=1724883189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gy3kLIaleiVIHByaXjXNu2tCJzHMdUmyUeCRezl9d40=;
        b=gghBrVpReUryarcOnFHuzzuH14EQoByk0W9C9s++zpU7vOVi2ezituIqf8E1o4RDrt
         obfNwk9I7ugnkqhwc55DKJZUSaiZ+E3S9guBm9TvdnZqi8nEmDzo5v2/jD0QocjMCz4P
         IEPotMMqHFcpgt3X3tHtzbZCRYX/GLfn+ql7TW0iCaCrEfHevNhusFieg0gPH/jPBC7w
         t8b1+OR+FSeXwV4ksdMvGX+ei7K3vo84neiScnGvtF8C6OJK6U+YDOUolzVpi/s/M/G3
         75x/SE3dsvzC1KSbAExjRMmZ8Cq7bTHUXM1utLPtK+nLvA3MS96gR2pZwtCP9bD02lV+
         XkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724278389; x=1724883189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gy3kLIaleiVIHByaXjXNu2tCJzHMdUmyUeCRezl9d40=;
        b=UU0jVuuUvzQFcP8sFbASIreemDM6qC+9j9U0Z8d6fIDArv3EOBCQyJ0uLViL5SDCyf
         97Xzs2ZjiTJHFjud0uqRRSj1s3kS4bW5RnQJSOcQWEKWwkssJkW5gLyzBUW9qH29u5O8
         VvuPoG7eF1a0OCVlOYo6FoBq8sEGRvSG+eIVSBN1f7rDyttHH/qR+3D2GVMjaVhtYrSm
         caS4gwK5NMClebVT4Pozs9oa95rLipR4HBuQP5DPHmjBO/BV2fRhHcTgEzbMagC1GTYG
         HTidV8z+GKhIYlaccloso7DVaThPJkyeiDgZntEDb+fQEhaWEyL37GZQ2Oj2EqCkSn8u
         7pBA==
X-Forwarded-Encrypted: i=1; AJvYcCUx9KZ7lWf0wSYr+BlwW9eLmHZSoQnNQ/WorX0zZJeDnWj8DFtovDFmMppekqKWNSy0f+YmgRHr5EW5yQ==@vger.kernel.org, AJvYcCWYPHiBgVjULVu1uqhzafUJM6ZF7sp9+Jq4aqECpzN3f5kWGRr5it/sV36wftcOgUlIJhjDPGkzOE52iY2l@vger.kernel.org, AJvYcCXoq/tQV6LsEuw2RlU2n75J/gp/AxV2IcUTrkN+f0eNCZMalGpBigMqvZ0FK58WbkOrngzV2Icd67WsCuFpNEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZ7aYSWo03RMdCnxfZIhNtbMPcGYDWoh/AJ0pJcqYSGrzlpOas
	6r0pd48uVMMQhYbSjDJvmknfHDkhK4nUEKOUqWTwyhy6QGJj2Ji3uO39xBpK3O3xfwZRwpZSiv5
	EPhhTAiArGWwkzJIGFfK8lXpdPCs=
X-Google-Smtp-Source: AGHT+IEyO/v91YT8hlltO4AIZ6dJNYaFf77ZtQnzqKrJkXJggP6AKu8AaggFXEnVRMRzrCMNGRwq9zlJyndgHxbbjAA=
X-Received: by 2002:a17:90b:3ccd:b0:2cb:4382:99f1 with SMTP id
 98e67ed59e1d1-2d5eacea29amr2406449a91.6.1724278389415; Wed, 21 Aug 2024
 15:13:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240809132835.274603-1-aliceryhl@google.com>
In-Reply-To: <20240809132835.274603-1-aliceryhl@google.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Thu, 22 Aug 2024 00:12:57 +0200
Message-ID: <CANiq72nFOYA6oZ4rECBsq3U9CGzMoN8zUz+4PrVWHetzNcAXiA@mail.gmail.com>
Subject: Re: [PATCH v2] rust: sort blk includes in bindings_helper.h
To: Alice Ryhl <aliceryhl@google.com>
Cc: Jens Axboe <axboe@kernel.dk>, Miguel Ojeda <ojeda@kernel.org>, 
	Andreas Hindborg <a.hindborg@samsung.com>, Danilo Krummrich <dakr@kernel.org>, linux-block@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 9, 2024 at 3:28=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> The headers in this file are sorted alphabetically, which makes it
> easy to quickly resolve conflicts by selecting all of the headers and
> invoking :'<,'>sort to sort them. To keep this technique to resolve
> conflicts working, also apply sorting to symbols that are not letters.
>
> This file is very prone to merge conflicts, so I think keeping conflict
> resolution really easy is more important than not messing with git blame
> history.
>
> These includes were originally introduced in commit 3253aba3408a ("rust:
> block: introduce `kernel::block::mq` module").
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel

