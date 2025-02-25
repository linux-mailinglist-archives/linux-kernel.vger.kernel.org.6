Return-Path: <linux-kernel+bounces-530446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49633A4338B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 04:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA23F3A7E63
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 03:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A237424C67B;
	Tue, 25 Feb 2025 03:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="22496/5r"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90E2D610D
	for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2025 03:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740453582; cv=none; b=QMBsJUo+29gCN29nZmw2awyKrO6/bwpz6WXHtVS6Uds0Xg9FoFRKWEdnLUatbYcq7G2WTfn378Kpb7+Mr9oa59djazF4eMLfUjIIQmAZadk1D29olS6oix0v79+exYTsUy5dg2QiwHSMnpO0Vep7OQsabShOB45epZvy+rHI2Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740453582; c=relaxed/simple;
	bh=KmqJ5UPyUn4QKWhlPOJYvXUy8SdtTAvRkRSjnFipiZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rdOxvSOCSCJ4kI9FRNjHfmtG2J/6p41Y9cHvNzmGDVxdoLlI4F3EKXDW6h2hfuXDnSpdrR3smq0yUyrT+cCDsksluHpIFMYGeViG9W1FPuOv9KONux4gZ5rQJ5wY4x/feWJLY0eNlcjKLJ7vs6geMTaiF8TIbJ8EqfnC7/wqKcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=22496/5r; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2212222d4cdso81345ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 19:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740453580; x=1741058380; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SG0vPvDkU+Cn7gEuriL77ttwykS6l1lmqIssAkQWxSI=;
        b=22496/5rvjtyzQzH0W2UwpDmopdQIHamOSIGdKMwVApZn6ch4fQ7Rqj75B9/Hqax71
         +Yq2guFcmiIDCFM5gOL/3n3a1zsTYzeK2zX6xQogM7DHiRuZNXEehzGvBlbUsdu50CTm
         mftau51LHosFLeUs/pqIyOpgizpPQcu5lqGW/9z8WuaT2erles+9DpullQ/Hgrz0rJ+V
         96bXfVjA9CXMKyPmef9qdpDOu7gavaPAfTguaIdeencBnHK496j7byYM6Njsx5+OH3af
         sddMiBAr7k2QoAs0ifssP5UvX1ekfIShCO7e7H+rXm7Leq4pVOfkIkgnE3BbpINsvTMJ
         rZoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740453580; x=1741058380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SG0vPvDkU+Cn7gEuriL77ttwykS6l1lmqIssAkQWxSI=;
        b=PHlclGoU0mv80VpqOTr0g76Z46xZQNUF7Vm6Wax3HMf2l+nEcYfQE2O/7m/cy5TK0h
         Huj7kGA5jdXzGNt3DO0eW9TLqgr0TsMWYkxg4C7iq3yc753LdQngmjKhUiQuI+Xjp7zG
         8pSFI+1wcAodqLV3DXwWDWMiQlbUUXWkON4I1oggDKn22qaR/D5CUUU0ka3tfXQjek3+
         Fu8FbF+qc5ZPHH798oqKst7e/gYu/4mNy6BPKBEiGkEPUvOBLlT9QiU4CzGzTB6tyCkA
         peJHOFLvn0tFiUOSgujmrNnNxSWtXaLB+Pd4yGbNpvBuCAYiQrXs2m9OpRSfJnMSy0Fc
         zSuQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfwKPlYdT+2D/V436N9uRVZ+9PyKi/0KijuTq8QGmVaOmWIsot1siXgt0rkKhEL/encLcWdoGWGqOaXZs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoY5eBysGSVBaiHkoLlP663Un36VG68TYH2oii2dQrOTI21OSJ
	W+xXXShr1H233tsiuG9dQoZT0u6liost51iw89CayPiSfXmfgeVKz1RI+y07kIX1Q0TTll6xe7M
	VS775/j3o76p5y+c0/LCAxrKgLmvOAhOss/Jf
X-Gm-Gg: ASbGncsMRVW3frWPHu+jFlqYEyIXj+xRN2om4oibfszGsltzHUscPO/EPI8gQ5McgT4
	MaBoSL97YMQQFqAUOtDwFnEh/Dpebcjumx/2IKcL0n4d5kLOsKTbXC5RzpqrzlMAS9n0WIpL68+
	lc2gt8xJE=
X-Google-Smtp-Source: AGHT+IEtZxuCVd0tnzxcUGZ4gQTicVs14GYdJr0CNhWdXPCDZapgO9XyLPZYzQJgLaG9UA9AQIHRIeLixV4juXWMkIc=
X-Received: by 2002:a17:902:db10:b0:21f:2306:e453 with SMTP id
 d9443c01a7336-22307a3d994mr1928995ad.7.1740453579681; Mon, 24 Feb 2025
 19:19:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222191517.743530-1-almasrymina@google.com> <CAPpAL=xvVYmiekEkQZO314JczbNK3kf_2Sw=15crgjQLfzQU4w@mail.gmail.com>
In-Reply-To: <CAPpAL=xvVYmiekEkQZO314JczbNK3kf_2Sw=15crgjQLfzQU4w@mail.gmail.com>
From: Mina Almasry <almasrymina@google.com>
Date: Mon, 24 Feb 2025 19:19:25 -0800
X-Gm-Features: AWEUYZkE739kPYOS1vvRcfM-p2BwFYz8vTlR5KcbwCGeAbQzIBCCJ-WS6P6ifgA
Message-ID: <CAHS8izNtGrMV+6T83-tNGpXsFqLo5N5jZpHueZ=SkDZ24pvKsw@mail.gmail.com>
Subject: Re: [PATCH net-next v5 0/9] Device memory TCP TX
To: Lei Yang <leiyang@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, virtualization@lists.linux.dev, 
	kvm@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Donald Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Jeroen de Borst <jeroendb@google.com>, 
	Harshitha Ramamurthy <hramamurthy@google.com>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	Stefano Garzarella <sgarzare@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Shuah Khan <shuah@kernel.org>, sdf@fomichev.me, asml.silence@gmail.com, dw@davidwei.uk, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Victor Nogueira <victor@mojatatu.com>, 
	Pedro Tammela <pctammela@mojatatu.com>, Samiullah Khawaja <skhawaja@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 24, 2025 at 6:54=E2=80=AFPM Lei Yang <leiyang@redhat.com> wrote=
:
>
> Hi Mina
>
> I'd like to test this series of patches because these changes are network=
-related. But there was some conflict when I tried to apply this feature. C=
ould you please help review it.
> The latest commit id which I tested is following:
> # git log
> commit d082ecbc71e9e0bf49883ee4afd435a77a5101b6 (HEAD -> master, tag: v6.=
14-rc4, origin/master, origin/HEAD)
> Author: Linus Torvalds <torvalds@linux-foundation.org>
> Date:   Sun Feb 23 12:32:57 2025 -0800
>
>     Linux 6.14-rc4
>
> About conflict content please review attachment.
>

Thanks Lei,

Did you just want me to review the code in the attached file to make
sure it looks good or was there a merge conflict with some repro steps
that you wanted me to look at? Or you do have a diff of the conflict
you want me to resolve?

The attached file in your email looks like an exact copy of my first
patch in the series,  "[PATCH net-next v5 1/9] net: add
get_netmem/put_netmem support", so it looks good to me.

--=20
Thanks,
Mina

