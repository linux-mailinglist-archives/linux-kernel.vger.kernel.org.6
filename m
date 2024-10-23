Return-Path: <linux-kernel+bounces-377453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7029ABF11
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 08:43:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 269991F24C94
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2024 06:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A00914AD22;
	Wed, 23 Oct 2024 06:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WmOi/QxU"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A73C4EB45
	for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 06:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729665833; cv=none; b=RMPbRXJTV3RdCa8kIba+TeY6EBGROM9fHw8WHZFm7P4xzpsW69EDpmUeATIPr2dMdkaszYzFYnBWKwz32eC6Z9owM5fPcFJBW+iZwu5Z28Th4kjDrpPOSRwNBLikyqq0v/qZiStq3ufytZf8bwrZPiBWPXZ0RYeBEyJpNqC4WU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729665833; c=relaxed/simple;
	bh=hE16K3E7H12Wm7Jno6gGmVcperdV0RIsswFmt+g6fJE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g+SjJftoW7VRcDoQQPEorcp/DOa3yV/xLPL8M2NtX4zdmITZTpmVLZosVLdvvWuyWjyQ2TwIjKIufz5SBZkzx1NzASmX0X2cLXa/DP9iWGF2LI7Dv2gdQY79WBWQ4ynjhhel8V0EBxHBxJ5xVk+YlKRpB1K738EhxIRTZ70yCVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WmOi/QxU; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5c9850ae22eso8057134a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 23:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729665830; x=1730270630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dR8Js9xDii8BH4xir6aYosjpe9kbmbUf58ZCLU8Tfk8=;
        b=WmOi/QxU1dyWHrnh4n903jzK70piVtiyMYVLnB2LLfe1+CGRHeyMdXjL6bjS25CWn1
         zku2+LYtvnBb+62VzR6XzjySQsQTaXSFxCzA9077ETwE/dCY25uXaq4tll1Vx4+P9ynU
         Zy07wTf6BZivb3K78yC7HzEF07j8tKwm2zQcYgI2MyPmNaKHL0IztP4JhH1aUSa8rX3E
         V9dQ5TeK3a8iHGiSv+W//3ng85SQeBe+onPfbs2Hlt/awGYf0QscWZHaDNqWQs35J9PR
         0JBxcCRRU0f5BE2J7TRU2kvqMfG42IiYwGLbGFTKNRiCqJ3VB3uJJ2lUQ2K02bAZrNvq
         6akw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729665830; x=1730270630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dR8Js9xDii8BH4xir6aYosjpe9kbmbUf58ZCLU8Tfk8=;
        b=JlbfpEuoFJcH/JWSvWsP9sLF3kY4hGzVVgbTHRmw3sOKBljzyezB8HzTRj+w1cmhW0
         crWR+DA4Qlx352tyAECSdbH9QcrnYEPK+R+vZmQbJS5xdFk+HZvTkSc69C2n37Tl3OGp
         EI28Lpaxed3nI0IRcdiw11bN7Z+QaFQ+3pAaB79O3h8zV+VpBHwebSnts9Ntzq+3RjYH
         jc5msvGkWI5yZ8+ioC4JEyYc2KAIjO8YPN21wYHCuk4EuKGhv4mGiTAd0my+Urqm2/tO
         AqglpoqbJyrHiMs8w7XNifXfOlIEfMXBT14fj3eXIO/NT0zjbysDetj4UptwuvecmXHt
         QO4w==
X-Forwarded-Encrypted: i=1; AJvYcCU3F2r4OeAEMTzV7cOTQs5Ot27RJwVqf94u1agoaSuQY63YnYIVXdOb8hG13Ju+A6fC3VpHwfhu/B4EMZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5jPIbSmdrFlQLqib6vfWscQxPpmChzNHqnvVG1i2vGgvIMNdP
	ZWHyWZlP5Gv5o9kxStxseIZmJ9xejaehR8rtEdVqBql8UFjrdgqULMWForKsxpeC3+ZjtM6bf2f
	oTjkC5XanS6XN3QrVyCrsb2pK4zc+n4P55L50
X-Google-Smtp-Source: AGHT+IEFSLUWvPFdrt0U6HQ7IeRygWwKTZbtQ5TFk4Dq4/uOOQ5k7MFogvGu2vS+B5GpXGBigKZFzDIlwJIvBYnrQTI=
X-Received: by 2002:a05:6402:40cd:b0:5c9:8a75:a707 with SMTP id
 4fb4d7f45d1cf-5cb8ac56883mr1349139a12.2.1729665829370; Tue, 22 Oct 2024
 23:43:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241023035213.517386-1-wangliang74@huawei.com>
In-Reply-To: <20241023035213.517386-1-wangliang74@huawei.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 23 Oct 2024 08:43:36 +0200
Message-ID: <CANn89iLpMv8E0=VR=nEBB_AJqR74=GbMvZs4NdESpCjBv7x7iA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: fix crash when config small gso_max_size/gso_ipv4_max_size
To: Wang Liang <wangliang74@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, idosch@nvidia.com, 
	kuniyu@amazon.com, stephen@networkplumber.org, dsahern@kernel.org, 
	lucien.xin@gmail.com, yuehaibing@huawei.com, zhangchangzhong@huawei.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 5:34=E2=80=AFAM Wang Liang <wangliang74@huawei.com>=
 wrote:
>
> Config a small gso_max_size/gso_ipv4_max_size will lead to an underflow
> in sk_dst_gso_max_size(), which may trigger a BUG_ON crash,
> because sk->sk_gso_max_size would be much bigger than device limits.
> Call Trace:
> tcp_write_xmit
>     tso_segs =3D tcp_init_tso_segs(skb, mss_now);
>         tcp_set_skb_tso_segs
>             tcp_skb_pcount_set
>                 // skb->len =3D 524288, mss_now =3D 8
>                 // u16 tso_segs =3D 524288/8 =3D 65535 -> 0
>                 tso_segs =3D DIV_ROUND_UP(skb->len, mss_now)
>     BUG_ON(!tso_segs)
> Add check for the minimum value of gso_max_size and gso_ipv4_max_size.
>
> Fixes: 46e6b992c250 ("rtnetlink: allow GSO maximums to be set on device c=
reation")
> Fixes: 9eefedd58ae1 ("net: add gso_ipv4_max_size and gro_ipv4_max_size pe=
r device")
> Signed-off-by: Wang Liang <wangliang74@huawei.com>
> ---

Thanks for this fix !

Reviewed-by: Eric Dumazet <edumazet@google.com>

