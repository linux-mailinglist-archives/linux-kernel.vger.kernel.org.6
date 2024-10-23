Return-Path: <linux-kernel+bounces-378852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8D99AD652
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 23:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDB281C21A8C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 21:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EDB1EBFE0;
	Wed, 23 Oct 2024 21:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X4YNJ68t"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4131E2826
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 21:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729717566; cv=none; b=Z2rLzp219beLYLXyIFCJm7f9t19GEVxjXi3uKAW/P0O+30BWYF0dOg5Eqmp7Yl8W2AD9gvGrL8vuCFoIlVqkH5DcImgHtuYC3EADKTkomKoOK7LjxMwt71SdgcRhBPEzGQc87r5PY/31lp+2oxq1WTxnO842v44g3/U3UgGhyZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729717566; c=relaxed/simple;
	bh=/JEcIBihja6V3LP52eHEY4Q3j5KZkMGS+N+dxgjhsRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/9fkUgE0P1ryiVb6L0apdfzl282kwumgEJWm8WutW4YZYMPlyx7FXQ3jLKJVdHNp+q/9BRjqAR9S/kZ6Me48N2fJJQJ0RHhAOhmkDtPpOP7gG8MhuFqxvUJoqWKbWCNFDaaCuZjeQixJi8NBbMQOn3icnjtsODzdD/Wi9aIK10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X4YNJ68t; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-43150ea2db6so17895e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 14:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729717563; x=1730322363; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JEcIBihja6V3LP52eHEY4Q3j5KZkMGS+N+dxgjhsRc=;
        b=X4YNJ68t0nwRFvxpqTrPL5CBJYmjDBnPdlWa0T0sajxnUKiHqH6PxrgMr7ESOh34Go
         uRnj9cS2v27XeMen/pbCT4inSZRm02OoqPJbSPT89R4TGKiZ6xBhpx9Ej2/f2UtAGK7F
         7T8pCdmA8lMC8cFzK8G8Ts2sTNVbIebfcFU6KlDTuHW/oRL8tdEh3U28hbI3LZQkJKzx
         o6LVG9QUzf7ytipO8RGDhSttTdF/ri4QUukc3vge4W57Mxt0enKDk8lVPvvUNd50/UQe
         3bgWCpGfzLU0I4dMdOsZbkymfmn/qT1CbmRf/UuhCaphnrWqGkKv8hZ0Ovd3bKxPUdAI
         txLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729717563; x=1730322363;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JEcIBihja6V3LP52eHEY4Q3j5KZkMGS+N+dxgjhsRc=;
        b=N5Bzo1dI6yoDWodesk+x8r+q9hZgpx3sEF+XWlMfIPvooCPCBUdrwuBi0go5JlXB1w
         hOKGyjqzgqae+6+CcQSD1YKOEUoUaGPVMB3jRstn2Uez8NMxhEMozMkWIWOoXsznsY39
         ZZhJsuhQei1WtI1MXv21vc/4yGxNewmu5MSszUpenUOl3KIUOHHVani4oUx/qVXoh2F7
         fgIxKmRyft+BWEKO1B9S8+JmX/jRqXxzcCxPZGMoNub+B2eSBhQi+Si7EhfhzCSKk8PX
         wCJEuqCT07JppGlINcSqtDtPkiyiYgEkPVqCVS1nlQjkaVjbeZ1b9VUTVgESaIYM7rRq
         l0rw==
X-Forwarded-Encrypted: i=1; AJvYcCW+kHozQflm8vpoq45ajTiFIC9Ls5mEOjg/z9L6voDbWRCngi5TqpA90JNlrUWA2oePoBwFCiJCRsbWyTc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaUywBdM3CgEngwiygYKDnlqWioVHJqzXLNFvgdD6IaV2u3F/V
	vocHjRiTz+7ANmbD+p9/4tz4HTfbdF/OWRjQypFnSLAQgr5dvnEmM3mYYkVDOpR9EFbH+/G5WoN
	PJAMYrfGPLZLopyjknGm8x8zAzemf81OuNLb4
X-Google-Smtp-Source: AGHT+IE7E1sQKkdi+IOPziXhygUCQe4DRbGEMh2n+xHqKHoCU4m0rJ13HS4/hKLnTcO13YuD7nqu8DLLl+hDRTXCmBQ=
X-Received: by 2002:a05:600c:5023:b0:42c:b0b0:513a with SMTP id
 5b1f17b1804b1-4318a50525emr1319735e9.2.1729717562737; Wed, 23 Oct 2024
 14:06:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241008183823.36676-21-samitolvanen@google.com>
 <20241008183823.36676-36-samitolvanen@google.com> <55549683-2453-4b67-a380-8ace34b3a06d@suse.com>
In-Reply-To: <55549683-2453-4b67-a380-8ace34b3a06d@suse.com>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Wed, 23 Oct 2024 21:05:24 +0000
Message-ID: <CABCJKudc-f4OfyfWnDwXGM=ohSin7Z=y7Fk92Du_17LB9ptV+A@mail.gmail.com>
Subject: Re: [PATCH v4 15/19] gendwarfksyms: Add support for reserved and
 ignored fields
To: Petr Pavlu <petr.pavlu@suse.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Matthew Maurer <mmaurer@google.com>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	Daniel Gomez <da.gomez@samsung.com>, Neal Gompa <neal@gompa.dev>, Hector Martin <marcan@marcan.st>, 
	Janne Grunau <j@jannau.net>, Miroslav Benes <mbenes@suse.cz>, Asahi Linux <asahi@lists.linux.dev>, 
	Sedat Dilek <sedat.dilek@gmail.com>, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org, 
	rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 2:53=E2=80=AFPM Petr Pavlu <petr.pavlu@suse.com> wr=
ote:
>
> I've noted some nits above which you might want to trivially address.

These all looked reasonable to me, I'll address them in the next version.

> Otherwise this looks ok to me, feel free to add:
>
> Reviewed-by: Petr Pavlu <petr.pavlu@suse.com>

Thanks!

Sami

