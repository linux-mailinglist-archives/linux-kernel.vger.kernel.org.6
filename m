Return-Path: <linux-kernel+bounces-358235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9144997BC9
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 06:26:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA5B71C222BB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 04:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E3119D8BC;
	Thu, 10 Oct 2024 04:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mB+SIOp6"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD9AA6EB7D
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 04:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728534391; cv=none; b=cKNL84ox7/nuK8fboEgdECQqFtXBB2EmpjHWnIGRUDPVCgqLmqXhz1RkCFUvLKIQ8AvYVClwjzolarhuRzzMhyL5ZQ5ISwkCPdcXi9pn0kTTPzIyZONtQG8MR7sGtn60267AEarOXRysgnCPXfE54eM2KPZXaEeVrEE64EFKUyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728534391; c=relaxed/simple;
	bh=oQtJBgXZ49fqlcGAOWec6TJbRw9q9uhx1efghBS5KrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V1kx4hpiD06XBQZC9X3qUAlJyJ+ChGbOVCYXn1ARtwyiC2Q51KeUu/HQ7zvnSquD6BalMrCeQH0kFtwyJpvKQfrNwA5ZVwPFJzm3NIc28oTV0YYhv4sRcT4qefdwL+udTqmyWM8/wyepCA64JEdb7SgvPJEttMHNrSWMdSsRv9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mB+SIOp6; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c9150f9ed4so533729a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 21:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728534388; x=1729139188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQtJBgXZ49fqlcGAOWec6TJbRw9q9uhx1efghBS5KrM=;
        b=mB+SIOp6S39zL02iNF05wi5izoaaIALmBI2NLp4GgKbrVkg2zVf2CC8dRLLTh8rMGN
         1MmGo0bDuqGLQU1bC/Peub2ylbJzV4fwHIVYftphbkZGWepLUkEXanaOE3ZlJCK5mmlU
         1+Ia92x+tk1tsIvYqhuDZWZlpzs/164gx8gmroj3TSx2nFZWWWmYM5LayIalJP+UPVlC
         nL62U9/UdCE+22Q7SgDxtb4l2CTlFE7c8q6J6PWtdpuJINuZfvNvmEc1/3kDaia/n4W8
         ruow9vjhW2KS0AusRSmZj4xR6ivLk8b0TG8pSlnezBsjuxwUL1KS3kebXv6MZvXSaoy7
         KDew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728534388; x=1729139188;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oQtJBgXZ49fqlcGAOWec6TJbRw9q9uhx1efghBS5KrM=;
        b=qnwwdph95QrRlyI2Drh0XIX9xEyPLqurByGVIt9kk/XJwueHFgsLiYZ1ymMbHmp2YO
         c7B+K8csdZ7gcFVEREzoAr6XB0nt94G+wsm71AfprrZPKOYKe6IOt802nGxbMpe8krC+
         pTtQiZ9u4AVgJXyxUllo4urvlbWUJ5xjnVpGYxynHdcC11ZJUSr6YmO7MscMRcLKs9kE
         fbxyvSmkk9q/9v947NRYTJqOlhrEyX3tTNAyB84A5nLe8qwGLeWdhdCTsflVL7sPEAo2
         sVLCNRHX2F+PUaoAAWkDAuRhag4FB4P1nUVMvIVpyVoCUfNgE4aXS4SenZoh6uHtgzgg
         qbyg==
X-Forwarded-Encrypted: i=1; AJvYcCXgRpREi1bCl5gQv9Y4kAqFZGZCDq/LA/pTrN+yB9C6UC9hn0v6z1OxF+D2lNaPblA9EgM3j9iIdmftuUI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0xkYvQm9GKbc59bmOS8lXXkodI4P2AjlXVahAwZW7lyY5iDFZ
	m91YCjc3gborpBI6tg7uL3tHLfhqufTMRLsfQnYps22kEg+8BffHds3gdOGQhOXrfPe216guc7f
	81n8VY5jzsm5fqovlANXsM6CZz9gGXrjq2UyI
X-Google-Smtp-Source: AGHT+IH3aOD+TQFzDcwLMz/etoxPu2lwsdb1UztvG+BDjyzY3bVpB/b+2U96a18G2jKJ4ZWK65RuI6uboYZeWwjSVZE=
X-Received: by 2002:a05:6402:248c:b0:5c5:b8bd:c873 with SMTP id
 4fb4d7f45d1cf-5c91d5a5531mr4672487a12.16.1728534388007; Wed, 09 Oct 2024
 21:26:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009005525.13651-1-jdamato@fastly.com> <20241009005525.13651-9-jdamato@fastly.com>
In-Reply-To: <20241009005525.13651-9-jdamato@fastly.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 10 Oct 2024 06:26:17 +0200
Message-ID: <CANn89iKWPxBtDm=9+gUuMAnvQ6KF2RaXSyNHin5579AvcGKgYg@mail.gmail.com>
Subject: Re: [net-next v5 8/9] mlx5: Add support for persistent NAPI config
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, mkarsten@uwaterloo.ca, skhawaja@google.com, 
	sdf@fomichev.me, bjorn@rivosinc.com, amritha.nambiar@intel.com, 
	sridhar.samudrala@intel.com, willemdebruijn.kernel@gmail.com, 
	Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"open list:MELLANOX MLX5 core VPI driver" <linux-rdma@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 9, 2024 at 2:56=E2=80=AFAM Joe Damato <jdamato@fastly.com> wrot=
e:
>
> Use netif_napi_add_config to assign persistent per-NAPI config when
> initializing NAPIs.
>
> Signed-off-by: Joe Damato <jdamato@fastly.com>
> ---

Reviewed-by: Eric Dumazet <edumazet@google.com>

