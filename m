Return-Path: <linux-kernel+bounces-377964-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 902799AC93A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 13:40:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 51D55282161
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 11:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAEE1AA7AF;
	Wed, 23 Oct 2024 11:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2Jhrbdae"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4D91AAE34
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 11:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729683612; cv=none; b=gOAd8RO6U/eyUCtgqcyBhCJLYP2sx1oHujVBbi2fSx9xL5tW0CnYD5MyJ2J/x6SON72Hm4vYQj/gag70IHKKj+Ss4WiEIZoqfLMLwq5Kvi0ixkxOwDci//UwGbbY/XIdOqCWRu6CbpLrqGxwPTA8NCGI5/LeH7zrepVjYTSVa6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729683612; c=relaxed/simple;
	bh=xl2DZrBDAwHAwD7yDt+ObJBK8xoU3J7UOJJvL65VD9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CgfZsIvNCpON6Giqwi5Oue+6q0CWmB3Vx1d/SM1u52o9+m2CjHt9+NJdp9hDP7Lf1c0r/ySf1HVRLuk6xVEuIQp46hJqnc6ZazrzDLdEkoZ5zEr952ZpvlxfPVjEfMb00sTcmItbL6CkBw6YKQKAtS7tQMKFqUmwx/E7hU7dyJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2Jhrbdae; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-431616c23b5so5577775e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 04:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729683609; x=1730288409; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=clO3ASdctIUJD5++Y7CTlIkog8RbQEY5Gg3bJn77ybg=;
        b=2JhrbdaeNohkzmtJy1hok7Ec3sk9VQ81e46CdVfB2ViC1nSKZjzJItEGCMPhsCM7pH
         xsRQgd60bYpbz5fOMxsTd2tqVqwh4HjBlNH0OXrLYDR7vq3rRNwgFN5HUjECekJNwJ/+
         ltuA2jIn/ZbX51yetDX6sfKt7K8u3XgYgjMGGm0Oqb0uA/T1gUurS/xHuv0OMp1krnV5
         Y451qh6zTQ1glp2xOuOlc10zLH5q2i0S/8fGGr5wbh/6FPOaMQJ6syqcSSqk1f5NT/Vk
         0o6COy3qazx1rv1q5/NVmI34J8FIH3Bn/osCcafCfMzaLotZHzfIg5iQghn/2Km3d3vb
         O5EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729683609; x=1730288409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=clO3ASdctIUJD5++Y7CTlIkog8RbQEY5Gg3bJn77ybg=;
        b=J1bUsFlw2PmhE5hy2r8XvGcQLa7+Kydn7Qbjyb4Lb8Bx8z0ZruZqffuznH4pxlVu22
         JjLzULF+QDwDENVkFgKaCIAHmUEHF4zRcJFOSOIFryxHgwNFc5NDrW0XUSZx2sXnJ7ri
         zDVW6VoNFyqo/EDXEIpzlJLt9YtVt4aY5RN/+IrS0FLsUPcQsMS3r2lGPW+0CY4/dTiX
         iFdBAya2j8EgKYe6op2U/Kap0ozq4rLZaFs7WHTTIeCOJfAtcKo9cYCRwFvUunYRlqAp
         wpj7jl48vTZhVO8QY8ympQ47n6hIw8tmplPxQSedfHAywyT+oGZxNZg94gej+eFsYzmM
         9QXg==
X-Forwarded-Encrypted: i=1; AJvYcCVIbFR2vWZLXVNdRoWjfQ7JG1ZX/KJ/mwl55iDDfCHF491P0QVbPtlICq3e6yWcJPsmyTvS6rH/csjc35g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRLfpBHmROEH7O82gbgPgIv9gaW4vlvd3180nl0tdmyiWj3wzW
	35TkGcZT8LbRS0dV+p6TK42vdzY63vdX8uIO1uXVgwREgns9ywgwN+JctjuDia+Qpmf2/vdo+ij
	Qy9zthOlfKrOQCkobPLcmejzUl23nTr2T71fy
X-Google-Smtp-Source: AGHT+IGWgw759kiGD66grzT26Z696gsA71jAmXE/eLn7Ey94LzdBGl3UV7M8+V5TtxEuYd1NAA9FNJeDVteYPGuXGco=
X-Received: by 2002:a05:600c:354f:b0:431:57cf:f13d with SMTP id
 5b1f17b1804b1-43184337402mr14563655e9.3.1729683609114; Wed, 23 Oct 2024
 04:40:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023113309.1724992-1-abdiel.janulgue@gmail.com> <20241023113309.1724992-2-abdiel.janulgue@gmail.com>
In-Reply-To: <20241023113309.1724992-2-abdiel.janulgue@gmail.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 23 Oct 2024 13:39:55 +0200
Message-ID: <CAH5fLgj7zYc6jg3vyqKNc85vkAvfgD1yqrUWj2-NcyR3kDPCbQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: error: Add EOVERFLOW
To: Abdiel Janulgue <abdiel.janulgue@gmail.com>
Cc: rust-for-linux@vger.kernel.org, a.hindborg@kernel.org, 
	linux-kernel@vger.kernel.org, dakr@redhat.com, airlied@redhat.com, 
	miguel.ojeda.sandonis@gmail.com, wedsonaf@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 1:34=E2=80=AFPM Abdiel Janulgue
<abdiel.janulgue@gmail.com> wrote:
>
> Trivial addition for missing EOVERFLOW error.
>
> Signed-off-by: Abdiel Janulgue <abdiel.janulgue@gmail.com>
> ---
>  rust/kernel/error.rs | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/rust/kernel/error.rs b/rust/kernel/error.rs
> index 7cd3bbab52f2..92bfdaaedb02 100644
> --- a/rust/kernel/error.rs
> +++ b/rust/kernel/error.rs
> @@ -63,6 +63,7 @@ macro_rules! declare_err {
>      declare_err!(EPIPE, "Broken pipe.");
>      declare_err!(EDOM, "Math argument out of domain of func.");
>      declare_err!(ERANGE, "Math result not representable.");
> +    declare_err!(EOVERFLOW, "Value too large for defined data type.");
>      declare_err!(ERESTARTSYS, "Restart the system call.");
>      declare_err!(ERESTARTNOINTR, "System call was interrupted by a signa=
l and will be restarted.");
>      declare_err!(ERESTARTNOHAND, "Restart if no handler.");

The commit message should explain why you're adding it. What will you
use it for?

Alice

