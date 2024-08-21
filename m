Return-Path: <linux-kernel+bounces-294894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C362C959400
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 07:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6DCFA1F22DD9
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Aug 2024 05:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 937EA168492;
	Wed, 21 Aug 2024 05:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fclwXrrC"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DBA161936
	for <linux-kernel@vger.kernel.org>; Wed, 21 Aug 2024 05:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724217866; cv=none; b=kB5i72xZbhwwLfz66ZX5qNAvCcCfL15//2spUA6t5BpYXpI9Lu16hTaYkKAPYF7uuEFPw6t73jw2/v9bzfgySI34Lv5IyflfQ5hAcnbDbfyCZJ3ac0f3zmbmZiRTeIEc8BJvdkfm2mKJZvEAK9gLejylEFh2enzWY+aUXIGg2zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724217866; c=relaxed/simple;
	bh=+c9ry0gIKwo4UXh5zsTLVRtv/dS4wCh2ZSvVpVlgmGA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R/3wmstQMmtF67tg5DCV1O2kNNij9owXuNcyimNcncVeqzZY/RMwTsTJHAZ+7CPjOSMPmK5eRlhYZjOtEjl5K7Psf+6CG2bqFfsSkwlUzYWUG7CuWtJ9aWZ2U2QLDZ4wpSmCrteME7IKz9K9K3f+IRdzeiDTT8gdTArqO0DCHs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fclwXrrC; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-4518d9fa2f4so198321cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Aug 2024 22:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724217864; x=1724822664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+c9ry0gIKwo4UXh5zsTLVRtv/dS4wCh2ZSvVpVlgmGA=;
        b=fclwXrrCUbNostfgCMd1La3shPRVOZWX7NBGQo4UHZzjMXPcrSpNKULQ9MImg5XYFZ
         CUegKrg1Fyl7CyJRn/1/tvPw1wlrt+bGmLJHhcMcUUJsGIa8Zb0jsdfkPrzBVQU8OHQm
         8dIMv+2iaxJeeFcP+n2mDKiRM3dkeyalcHar9RC9H8LQ0bWAw/onpJFqpKriGZ01a/1t
         M9b5rA96B74LZiM2zdhf5YwWort6xA2xcpXOx0Bi82d5wU2qSbpIsuQN21WeeNkEXlH4
         LxpudhD6SeYCDorLcudcwf16ua7KSTQhRL/9f9SCln4QOAenhivCtyYt5MlCr6MqTKM3
         F+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724217864; x=1724822664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+c9ry0gIKwo4UXh5zsTLVRtv/dS4wCh2ZSvVpVlgmGA=;
        b=Y5hRUCDwTylAQ/etMTygS69G3wqSWzanpwmSM7Gsgth9bPNl2MdVfRWPvDCeX4Wvjy
         ON7XT4Y2hGEFyyvqDE12YCpQcGvIeLPIh5KEQ8dViR/fpbUTKiBT/T3dZ5DAUmK3BzmN
         oGIn2OQ1UXfWDGGH+g48Shy2C2tPJ3Wrqn3ekVt6cQdmwjhSetQTlQehzwn48Sop+FcC
         LB/gON/gg0gB/1nga5FJ0AS+rTXUhT00bNTMSjHtE9iijOTrvLsjtccswnNwZvLSJhqV
         GO2IyK2oczzhZeV9vjongg1bQRy5iz+pemRrG42P94Pclbin1aSSxLGcOHUC9ezA6TVR
         L2sQ==
X-Forwarded-Encrypted: i=1; AJvYcCUqNEvFNgxZ5yNHOvVmP4IB5QjrfKiKV2/ojbCSfRfFR/aDcgGoERzjcdNHCANT2TgCI+7JY9bfJeLSZ/o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz35qkma3zAGRTpPGCOIZbvyC2zLY9yKZZKP4lepIIZhkmnxm0p
	QpXrvYuTAPsNgC5kLmqsC4W5qt8TiA3S/9d0FkQKxaRhVN3QHinmhwA8Kso8J30hpCyeNlifMPI
	VNUDa0LTpLjkwbPcmMoIptM/T2Hs02drfGXhp8h7/dkGXPoF/grZ4
X-Google-Smtp-Source: AGHT+IF73BCpn5UEcqFM/BhSSvMcfe9RO5QJr6iMJ/RDZUzv06kFzVkx6JeX8ZkAINLWgUfT5JTOhJyg6PRKU3OeCEQ=
X-Received: by 2002:a05:622a:452:b0:444:dc9a:8e95 with SMTP id
 d75a77b69052e-454e86dd4c8mr4839811cf.15.1724217863923; Tue, 20 Aug 2024
 22:24:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240821045629.2856641-1-almasrymina@google.com>
In-Reply-To: <20240821045629.2856641-1-almasrymina@google.com>
From: Mina Almasry <almasrymina@google.com>
Date: Wed, 21 Aug 2024 01:24:12 -0400
Message-ID: <CAHS8izMyAxw8DyG11b6h17ghU6Xa-be-C7tDOvGCjkCJ1bZDKw@mail.gmail.com>
Subject: Re: [PATCH net-next v21] net: refactor ->ndo_bpf calls into dev_xdp_propagate
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, bpf@vger.kernel.org
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andy Gospodarek <andy@greyhouse.net>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
	Dexuan Cui <decui@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 21, 2024 at 12:56=E2=80=AFAM Mina Almasry <almasrymina@google.c=
om> wrote:
>
> When net devices propagate xdp configurations to slave devices, or when
> core propagates xdp configuration to a device, we will need to perform
> a memory provider check to ensure we're not binding xdp to a device
> using unreadable netmem.
>
> Currently ->ndo_bpf calls are all over the place. Adding checks to all
> these places would not be ideal.
>
> Refactor all the ->ndo_bpf calls into one place where we can add this
> check in the future.
>
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Mina Almasry <almasrymina@google.com>

Sorry the patch title should just be:

[PATCH net-next v1] net: refactor ->ndo_bpf calls into dev_xdp_propagate

v1, not v21.

