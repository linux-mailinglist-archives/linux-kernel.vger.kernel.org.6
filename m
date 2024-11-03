Return-Path: <linux-kernel+bounces-394035-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D2D9BA967
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 23:51:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2D0C6B216D7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Nov 2024 22:51:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B451118C93B;
	Sun,  3 Nov 2024 22:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Rb1aC6CS"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B82F18C010
	for <linux-kernel@vger.kernel.org>; Sun,  3 Nov 2024 22:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730674262; cv=none; b=GcU0PJelfeEQBWX05N6F4yrHB7i9Flm8JvQQ5arDCaRmeaZ0kXUO2YphvX2ogiDl9UP2WLpTwRv+nOn1qrQCsBR3ImfilT6SEG3bAg3jTEGQxEB4ZV/Wtcd+9craLNxqDC44lfbvcIfBowdcX1LE4On2NIDtN43hHoo+59sPdHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730674262; c=relaxed/simple;
	bh=vbZ+uzGqdW4hX03Xi3d7fgtT2grFuBySNiXCV4fiIF8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQLIknzNItp7a5Hc3A1O/aOQhVv5YC0H4yYP12QGyux8A5Ggz2l6naWy41U9A7p67+zExJ8yLdNoOYee3auO02LT8CnbzjWDhAh2fvfB6tlZzKDzhrhcOLL4H5WLREwKtA9xkKwxoyRZdEHJ08K8hpn73+q/NK2Q/6BJR8A1Iyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Rb1aC6CS; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2e2b4110341so354470a91.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Nov 2024 14:51:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1730674259; x=1731279059; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vbZ+uzGqdW4hX03Xi3d7fgtT2grFuBySNiXCV4fiIF8=;
        b=Rb1aC6CS0PoihxDfK82nfYdLZkQuf6gn8jYryWsOdwASBB0xPeuLVj//7tKWMvJJLj
         ewAHrYvotvyz+9jrWzjp2a6QHGfB0WXQB2E53jRg9HiZub8t96s5rlJuOmG3QF8seMhx
         iPHOTAhkRE3eoP3Bz574YzrDAyfmePP7xdyqYX2vNe1k3e0sGtVQSSm/M+YWGZlgm1w1
         jpXnSQTqtenPU8MyKukvT9n3qAyZXWeKOJlWnGQDebRFlig1HpppsN4GO/Yx/ChtURb5
         duH12G3Ols5gbtlQOef6mqxikCjXEFXFnLU0IiCp0MGGPjMdWowrcbeNCjNBDMM0rXLL
         4i9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730674259; x=1731279059;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vbZ+uzGqdW4hX03Xi3d7fgtT2grFuBySNiXCV4fiIF8=;
        b=hoGo5XyVDXVpnxGwW9hsZTHEHTdmxXcNjF98fqd19faYRQQODKrxyR+8mZfhS4vuHr
         mg7annYiNQbPyGMjtCSk7JGuBgXvHmX0wDcqiybUJbg7BJHndPZ8wULjUYHHwNTtW9ZC
         7Ov+KpE8O9r7eMZrtZYDK/3Iah+Z6JnsLR+doDh4yanbse4G1Fikzbbdv+4g9YIVTvOp
         A5uVCgVgO7oy3OTOQZXSKY0fQEg+89biURShcbqA01HZxWMB8mMTjMgHRhOK9LctpSPX
         JFBfUvtnqYGwflltf4PKThLefl0fglg856DNmSpU/3sUFTU8NwnpRSfL/cf8txkjNyrb
         JR6w==
X-Forwarded-Encrypted: i=1; AJvYcCUQebSLrgPhxeJrziaK8aRwm1JVJnOAq/L9K+qCPmnjn20vLny/WBc9kozPX4e3+ctiwQMEq7ZPE9wC0pQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YygyHz3BiR8qxxUN/5YEgNMEG7Ap+8UGPTrvFzkMkl+WI8mu/QA
	Dehxd3RsQPq0OnwBbC4ypg2lQ9sg3TvaqQU/2nbt0zEjjXKKakaKZ8/pBZ6DsvJ9OLeg8eI0Zyn
	8SHE1t21+hiehP8N/mtly/6nRCqvXO7COWqeETw==
X-Google-Smtp-Source: AGHT+IFUl1GCcoqWHoZYbz+qEG71KEMvn1Im+9ZYr+neR/oxPoOmgzFQQqZYN0kcHlFEkQf/7jeXNqXwpJVr9GMXuU8=
X-Received: by 2002:a17:90a:e511:b0:2e2:e139:447d with SMTP id
 98e67ed59e1d1-2e8f0d62425mr14589494a91.0.1730674259424; Sun, 03 Nov 2024
 14:50:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241031002326.3426181-1-csander@purestorage.com>
 <20241031002326.3426181-2-csander@purestorage.com> <20241103122138.6d0d62f6@kernel.org>
In-Reply-To: <20241103122138.6d0d62f6@kernel.org>
From: Caleb Sander <csander@purestorage.com>
Date: Sun, 3 Nov 2024 14:50:48 -0800
Message-ID: <CADUfDZpBfwGJwhUHCZk8AgZDY0QP3j2dEUHZfC1VkR+75jj2WA@mail.gmail.com>
Subject: Re: [resend PATCH 2/2] dim: pass dim_sample to net_dim() by reference
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Arthur Kiyanovski <akiyano@amazon.com>, Brett Creeley <brett.creeley@amd.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, Claudiu Manoil <claudiu.manoil@nxp.com>, 
	David Arinzon <darinzon@amazon.com>, "David S. Miller" <davem@davemloft.net>, 
	Doug Berger <opendmb@gmail.com>, Eric Dumazet <edumazet@google.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Felix Fietkau <nbd@nbd.name>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Geetha sowjanya <gakula@marvell.com>, hariprasad <hkelam@marvell.com>, 
	Jason Wang <jasowang@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Leon Romanovsky <leon@kernel.org>, 
	Lorenzo Bianconi <lorenzo@kernel.org>, Louis Peens <louis.peens@corigine.com>, 
	Mark Lee <Mark-MC.Lee@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	Michael Chan <michael.chan@broadcom.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Noam Dagan <ndagan@amazon.com>, Paolo Abeni <pabeni@redhat.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Roy Pledge <Roy.Pledge@nxp.com>, 
	Saeed Bishara <saeedb@amazon.com>, Saeed Mahameed <saeedm@nvidia.com>, 
	Sean Wang <sean.wang@mediatek.com>, Shannon Nelson <shannon.nelson@amd.com>, 
	Shay Agroskin <shayagr@amazon.com>, Simon Horman <horms@kernel.org>, 
	Subbaraya Sundeep <sbhatta@marvell.com>, Sunil Goutham <sgoutham@marvell.com>, 
	Tal Gilboa <talgi@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, intel-wired-lan@lists.osuosl.org, 
	linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, linux-rdma@vger.kernel.org, 
	netdev@vger.kernel.org, oss-drivers@corigine.com, 
	virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 3, 2024 at 12:21=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 30 Oct 2024 18:23:26 -0600 Caleb Sander Mateos wrote:
> > In a heavy TCP workload, mlx5e_handle_rx_dim() consumes 3% of CPU time,
> > 94% of which is attributed to the first push instruction to copy
> > dim_sample on the stack for the call to net_dim():
>
> Change itself looks fine, so we can apply, but this seems surprising.
> Are you sure this is not just some measurement problem?
> Do you see 3% higher PPS with this change applied?

Agreed, this bottleneck surprised me too. But the CPU profiles clearly
point to this push instruction in mlx5e_handle_rx_dim() being very
hot. My best explanation is that the 2- and 4-byte stores followed
immediately by 8-byte loads from the same addresses cannot be
pipelined effectively. The loads must wait for the stores to complete
before reading back the values they wrote. Ideally the compiler would
recognize that the struct dim_sample local variable is only used to
pass to net_dim() and avoid duplicating it. I guess passing large
structs by value in C is not very common, so there probably isn't as
much effort put into optimizing it.
With the patches applied, the CPU time spent in mlx5e_handle_rx_dim()
(excluding children) drops from 3.14% to 0.08%. Unfortunately, there
are other bottlenecks in the system and 1% variation in the throughput
is typical, so the patches don't translate into a clear 3% increase in
throughput.

Best,
Caleb

