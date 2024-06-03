Return-Path: <linux-kernel+bounces-199228-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D66EE8D8426
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 15:39:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90FD32897D2
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jun 2024 13:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EED1F12D775;
	Mon,  3 Jun 2024 13:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jh/f1rHx"
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DD312D762
	for <linux-kernel@vger.kernel.org>; Mon,  3 Jun 2024 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717421940; cv=none; b=XYjZTuuMeDOC6LXYc0F5JJenm76TFHAII7k3KpqWk4mFobP0DQjsRfwSZvjZRwp+8r1H+jonHSTiXBpGTKp83HFWovRKR9UMtEW45rn0xQicmUh9mS6r4yFWqynGzfrkI4Z+BLZYi0t3HNegGuuqIoMCeAEjzbfE73ryukdW8hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717421940; c=relaxed/simple;
	bh=7d9o511NhmOtY1OEzexettVw0U4ncDoLQP6qqwcMq/Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HfD1ynVwO3NkxuDuXXuR9qSvZ8mnhiKXcE7AjbPjaAjsOnn85Y8LvpP5MkJ7rCF8rSnRUhp3LzTG3F9m2cw9IdDu6Nxqn89SGDNqf0Ul6jaAoy/kqZyHljHDmd0Yj3B3ktmH/313aGjRuJ+VyeLCPPND6SQc5n2aIoOhTkalsGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jh/f1rHx; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-7024494f7daso2682330b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jun 2024 06:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717421938; x=1718026738; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7d9o511NhmOtY1OEzexettVw0U4ncDoLQP6qqwcMq/Y=;
        b=Jh/f1rHxlyWYIIzZwqr+oRLt5ojrng9yx07iiGMbRGAdlVWXnZsfpaaR2By339l7Nz
         YKW1BgK3mS35O3IYI+YLOYsYECfwCS0SkBG4N/WTtBycxSVEmJdzH5q8IKMCH9hTs08g
         912j4FFhWiL/L0YMb0nliIbBG1gF4nuqXomGILJSB1/FisF1M/nixevzJDONpEsEzprq
         IcJYgcK+3C93GC7NAm3VquNjLUaSmM4CF6mbCIsr2jE0VmhxVi17c+B+xRVoRugD0j9u
         UShoGgGDQRFSqFBlgLIhsHBeswMvJdoM0U46joxBr/9n9jTJaHu5xAJzD46Oj6xGYC28
         uInQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717421938; x=1718026738;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7d9o511NhmOtY1OEzexettVw0U4ncDoLQP6qqwcMq/Y=;
        b=UgPgjpTchUrNK4bh3JdMkKEmTS8Vl4m9Gaqde4pP720KMAeXddYfJylP+PnC9weDMj
         IofshMxYJPU2Lrb13TbyVLLzUtDb6C7oG+GiAeaqoedhSGYHezk//qGf8HZ7gLiTeZAG
         /UCFcmkPLI0yz1JZNgYkCfqp5bk0H0nJTVooxJPicbSSrswlQ7v1EARRs6RpkEtW+a9E
         4QEypfPSxEokkrSqXE/jlnDCVdpxBYeAbvcziV1/F6u2CCllj3NkjUQQjmpcxEkaeY8g
         pimmxac6kvmM7UnDRktep5P8M3Ay5Z3ZGaQmVyOVtV5eitczxYgcUx5qNNtiGjyU+3lY
         +bPA==
X-Forwarded-Encrypted: i=1; AJvYcCXWjtIbHouHL0eCE5MxA73kTIRXUh8YQWJz3wyDpia12jMBguAJfeJRP0bAZ91PUqUzx74o9oAzhW3fg5cXSLYt91yO9CUkn7POYupn
X-Gm-Message-State: AOJu0YwTZdGZvUAJNrp6vZjd4IiQUAhAjbYi3mEqV4SHHmnrvWfkkWan
	v1uP4Rcy+n6sPGoQHq7h2dpPUZTLaNYb1KB6xDIuPKTq3Zj904UHEUNNKkJDn2N1r0+wh9prR+q
	YFbC2Ms/M1seppzDnuEGMmRIrXvI=
X-Google-Smtp-Source: AGHT+IE7jHjXB+vbT7BNzqGL24TQ9vBmNUdjIMR3zL0qBzEHsuu66iPeHBnoj8y25eAP4RMn1jeH69d6uVdUQPY+PWs=
X-Received: by 2002:a05:6a20:914d:b0:1a9:a32d:17cc with SMTP id
 adf61e73a8af0-1b26f141cf0mr9409267637.18.1717421938255; Mon, 03 Jun 2024
 06:38:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230601075333.14021-1-ihuguet@redhat.com> <CAMZ6RqLoRVHD_M8Jh2ELurhL8E=HWt2DZZFGQvmfFyxKjtNKhg@mail.gmail.com>
 <874jiikr6e.fsf@meer.lwn.net> <CAMZ6RqLJmTjM0dYvixMEAo+uW+zfhdL1n4rnajsHCZcq971oRA@mail.gmail.com>
 <CACT4oudYAK07+PJzJMhTazKe3LP-F4tpQf8CF0vs1pJLEE_4aA@mail.gmail.com>
 <CAK7LNATqNNVX8ECNoO82kY503ArfRPa9GdbYd9tOok_6tGOsew@mail.gmail.com>
 <thbrfziusf37nj5mwsj2a6zmjtenj5b5vhzwu2z5zkhr7ajsg6@whvx46y6mxbz>
 <20240603121853.GA19897@nvidia.com> <CAGudoHEe=AiRpkyLJTZzU8MtiGC86Kivbyi1xF-Hh0hGJKWhCg@mail.gmail.com>
In-Reply-To: <CAGudoHEe=AiRpkyLJTZzU8MtiGC86Kivbyi1xF-Hh0hGJKWhCg@mail.gmail.com>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Mon, 3 Jun 2024 15:38:46 +0200
Message-ID: <CANiq72kPH_gZrGAEr7WvjzNiNUZz2YtgRV0=PP0LuxaecckUoA@mail.gmail.com>
Subject: Re: [PATCH v4] Add .editorconfig file for basic formatting
To: Mateusz Guzik <mjguzik@gmail.com>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Masahiro Yamada <masahiroy@kernel.org>, 
	=?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>, 
	Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, Jonathan Corbet <corbet@lwn.net>, ojeda@kernel.org, 
	danny@kdrag0n.dev, mic@digikod.net, linux-kernel@vger.kernel.org, 
	joe@perches.com, linux@rasmusvillemoes.dk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 2:52=E2=80=AFPM Mateusz Guzik <mjguzik@gmail.com> wr=
ote:
>
> At this point I suspect this *is* the intended behavior and other
> people don't run into it because their editor does not look at
> .editorconfig to begin with.

This is https://github.com/editorconfig/editorconfig/issues/208 -- a
`modified` value is proposed for just trimming modified lines.

Given the latest version of the specification, it sounds to me like
the intention is to trim all lines: "... to remove all whitespace
characters ... in the file".

Cheers,
Miguel

