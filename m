Return-Path: <linux-kernel+bounces-437697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EF29E9742
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:36:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CE4E1647FC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DD81A2399;
	Mon,  9 Dec 2024 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="p3CIV2zx"
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D02623314B
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 13:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733751262; cv=none; b=b57ZSaHhLwQukXI9xp2HddAJnajzRmjFeBijjQibfXBOQzEH/+EEOQ8aRxr82MxoOXaDdNBg2uWFPCdZML61sITEyHB8VOvn39b2vKcREcT9sjF4nCm72OS+bCCW6axpsnyN79YdkPnGokMNylpYCNPida0nTk58+E3peZ13TaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733751262; c=relaxed/simple;
	bh=2XnCJO2Ir1RkGS9FPuM9lx46jfc3ddfFDKFy3P8d4s0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bfqv3FX/F4zK5tBhjqxazw9GWdrJH7YM5Xacsh7xrBSnvKzSTgW9fX3eHldjYYs3xsRCPWjmU/yFXRnOZk3JNgl0j8cKy+9/2m/y44Ho7RGZCp7fpC/NcG0OU/JCxkiyh5TaLU4Xw5ZeyZ2IHk532rMbo1XCY78BvMr4lYOY4Dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=p3CIV2zx; arc=none smtp.client-ip=209.85.166.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-il1-f182.google.com with SMTP id e9e14a558f8ab-3a7dd54af4bso19651375ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2024 05:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733751260; x=1734356060; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2XnCJO2Ir1RkGS9FPuM9lx46jfc3ddfFDKFy3P8d4s0=;
        b=p3CIV2zxhBVji/6bO3YfxmW4O2TcIZ1T7jgU26jtHnLoS0d3aVfNnEZNSDxuCyHzr+
         7vR0pzM/Kp+kXZUC6PvyQ0E92QZ4/HBvaeJ9vCP59FDKwdvP6iyASccT8V7mBW7gP0if
         4v8uS4G/NZ0yE+RlXkrcEXbEzBNBA17CUzOASteMQY7JewCZoVYNGE1/G9Pu9ZCndBAH
         8sQS1JmKAoaPdXF+BWtENRvFkxtWm7Y9X9F2diLyALvaPdbZKcCBEw1edJvFfwVuT6xQ
         MKZ4gwJDphkyrEkL+z+bdSRJEZb6XruAnhrn21WVmc6qD9s9+t0lFiHc+Fz1HQDOatAH
         h+4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733751260; x=1734356060;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2XnCJO2Ir1RkGS9FPuM9lx46jfc3ddfFDKFy3P8d4s0=;
        b=ldKAva12p8nDijgJqPKYu9RqYf1J7Cfo0d1Y8PRz13yPu9o0KUb73V8UYOckiPjMA3
         DOjRGS2wsFLhnspYs7XYn7DfAKKf2F9pqHmEspwL1qD1029oN/lgsa4S9j9amf+AMcgm
         bTIjZ/Ejj66XKGeRbB2Ary8l3g5NowooKortoBAlVZN65Kt96zT/ecWz7Rte+ZlzJqTz
         pmA638vxSDAK/ZkAiQnfsY6SKeh4eRK/DM9RhVhOjRIfq5JonHv6a0GD80O1m/a3gzr8
         qc5/u4gAxmO/1/A9yfzTm796xKHKStSGWbIVaQVkg2pi0qGaVcpG3AkKX9PKZxgQKaHG
         FOjg==
X-Forwarded-Encrypted: i=1; AJvYcCXM13J86i9v9giFJvL1QIRb6g8YAB5ZZrJcqUyYpB9+A1bgvn1Zc7zqCNb0/9iaF70p08quYvwvPclyhtI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtBGBx7KCsiK2lp0mfFWazPSNaHPWWMngjUZanfecYgusRzpvy
	xgH+rAaV2Jm0I+3+I2ON1KQZo0DQz9a9WQd80wzgtXkl6o9kR6qMs31I8I3aQBuFCrMIHeKKHC7
	lDPkgGeMvY8Xo1v75hXf2cUhBOmyuCiY4KT+O
X-Gm-Gg: ASbGnctQOn9ktNE5HtSfgkTbC6XBGVI8S2TkXtk6fMIZZTBsKfeJvBYv7cCjWUByEc4
	TyHjtEij3C5bttHPorCGRsVmP684VAw==
X-Google-Smtp-Source: AGHT+IHRSd8liIwypeFGnJ2w4GP4iNsA1tFPI9rJi5aQdzanGH/U1dY5+7Sdd0pd0DZsUi7LvwuAbNc3wqFv/AS0+bQ=
X-Received: by 2002:a05:6e02:1e06:b0:3a7:d082:651 with SMTP id
 e9e14a558f8ab-3a811db1f7amr136023395ab.12.1733751260168; Mon, 09 Dec 2024
 05:34:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241209-net-mptcp-check-space-syn-v1-1-2da992bb6f74@kernel.org>
In-Reply-To: <20241209-net-mptcp-check-space-syn-v1-1-2da992bb6f74@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 9 Dec 2024 14:34:06 +0100
Message-ID: <CANn89iLipfRa2jj7bXNQzx4ocgbD2C+z8+cYChQfPRwQ2SoiEw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: check space before adding MPTCP SYN options
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, Florian Westphal <fw@strlen.de>, Christoph Paasch <cpaasch@apple.com>, 
	Mat Martineau <martineau@kernel.org>, Geliang Tang <geliang@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, MoYuanhao <moyuanhao3676@163.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 9, 2024 at 1:28=E2=80=AFPM Matthieu Baerts (NGI0)
<matttbe@kernel.org> wrote:
>
> From: MoYuanhao <moyuanhao3676@163.com>
>
> Ensure there is enough space before adding MPTCP options in
> tcp_syn_options().
>
> Without this check, 'remaining' could underflow, and causes issues. If
> there is not enough space, MPTCP should not be used.
>
> Signed-off-by: MoYuanhao <moyuanhao3676@163.com>
> Fixes: cec37a6e41aa ("mptcp: Handle MP_CAPABLE options for outgoing conne=
ctions")
> Cc: stable@vger.kernel.org
> Acked-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> [ Matt: Add Fixes, cc Stable, update Description ]
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@google.com>

