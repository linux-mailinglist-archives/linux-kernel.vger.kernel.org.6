Return-Path: <linux-kernel+bounces-528467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A14A417FA
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 09:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035DD188FA3C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 08:59:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0C724291B;
	Mon, 24 Feb 2025 08:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cKF2vsMw"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8A8818A6D7
	for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 08:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740387565; cv=none; b=YYixZv94wXkIMkUUU5TJxjsECo+366Qqy5+m/tUuDRo/ZnW70Ek+3WKd05IUZ5XF77NvfO9lXdRZbCrFh6OpwhrjHXFE8o1lqUFjz+aF4Y7KMyiI4CpbyZKONJZkNSlpPV5b+oEIRhro2vUBt8DOn2xFXOIa6psgLvOOfOYNkbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740387565; c=relaxed/simple;
	bh=vc93JQEohEbYq4mQNpdj80fyVUiiKRsH7qvFpGNh63c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XI1oN9gqqERrIMREhuiLDKslRVGvOX7m2VXV5py93AqCqZ2tx8bCLSo7bivZ4e4Y1s38lo8hfRREorgiGU7JmDg8ulEpnoc4EJwhcHiF2Al02V99W1DTrg1P+xuwjG4SUJgtUPoJqZyQLeJxeh46Ku+orBRmP7zRdhhpPG8x+CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cKF2vsMw; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5dccaaca646so7299654a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Feb 2025 00:59:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740387562; x=1740992362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=neJ6tLdV6Pj901cfP/S2V9InTeEfh19A+QUYQKvLMDc=;
        b=cKF2vsMwos2zGS/hazVfVZV7JoZOZJ2REDhtzwdEM5ra9P2ExcGcCCrnZtJiw2itKR
         ogV39DW6uHHYBrVRaSZCub/w+reosVFcpDl5kQbISHANb1XWWHGZW4sHBXOFdy6UwDT3
         LEMjdj+0XZ8us35o09ZC/v9C1solEUj4qG/9WCHi2aTtynvaAwkppQ532Tkx9pKplAPV
         oK4pt4M+eHsVuWiZIFhwj5sEF7slYv5Lv2Q27euGl4CaL+OgrGLixK2Ae+nYHqWM/LIz
         +X6kPj8L55D3VlhQiOizK2wxHEdb1ZQgTpWQ8XX8EtD9LL+TV3DJZW+SHER0D3IR2bmx
         OwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740387562; x=1740992362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=neJ6tLdV6Pj901cfP/S2V9InTeEfh19A+QUYQKvLMDc=;
        b=ideQ2+rGbj3U4RMuJekuhd0PJLeMA6XfsEToKcLnJv9FQc8sWY7Jg7eNTlanfPCCW8
         gNsMlitW+ioCnWVcpFj7wN8HFTW7Pi/RO9AYH5PfJ2k1PjSDdeYcPhzuuzJjsOsHz1wi
         3dOIr5JKgnto3cpx/3e1PSu8faIGlQRdr/SRleswsqPFj0sWnyyHF3dwiJ4nnLFKEbTQ
         agF9b8bPo13mLKvtl6AM+9LsJvsfkqc98vGY2+zlyP1wXhDiaq0WWZz1MxkDXVcun3pH
         GsgdPXtMKeiKdFu774BwCC+2lYeU2uIRGYIMgw/WKn7yX62UlD3YjOzBY8uZG6nEIIi2
         CLaA==
X-Forwarded-Encrypted: i=1; AJvYcCXBxw46R2kKSz9Ev5URheOIgHOi9lRtCnPkatYMfaDjR4QghurymTma+6S/+QArC59QIlXSwRKItPbRGoQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyruea5mwtYo55ObOIFqsBal/lWYHmjRsTPkry9W0GNYu1rXIoD
	2iv9t9hWBrcnKuQf07/dcep48Nv6zcwxFwCATl3HUlojrhO0Z2im25OHl+xoqbb/zxUx3fxC1c+
	BZNRM/r5FqNp2P7Fern/eTW9fPS8WkmqAvumU
X-Gm-Gg: ASbGncszbd/cz5tS9UTY8z9nwx6piWUtN4SK4Itr2RJTX9eW99YAH5C1BTMygcR/38y
	z7LfxzYL76qvaWKcyEI54ez9m9m/rN91Bxgo+XzK+ME/vmRVmuJ1oAitzExYGXAJsU5DGVyFpcy
	aQf4Auqg==
X-Google-Smtp-Source: AGHT+IFck3W57TNLkGUizyHUeVGp2loSrvbYOXaJ9bWEut9fqRCQ2ANN+W0ws4sYSjDdVcReDTlaVfDPRVmW14Twv+o=
X-Received: by 2002:a05:6402:350a:b0:5db:7353:2b5c with SMTP id
 4fb4d7f45d1cf-5e0b6331da9mr11276859a12.11.1740387561801; Mon, 24 Feb 2025
 00:59:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250222103928.12104-1-wanghai38@huawei.com> <CANn89iJfnmsZHtcc7O1oQSutgC5m_Jrhkxy3EYeOxQnjz4wwUQ@mail.gmail.com>
In-Reply-To: <CANn89iJfnmsZHtcc7O1oQSutgC5m_Jrhkxy3EYeOxQnjz4wwUQ@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 24 Feb 2025 09:59:10 +0100
X-Gm-Features: AWEUYZkmbAxixMSREAlrws71v9qG-dnZ2a5F3ZIejXJhuG5-s4ijbg7iLdvupBw
Message-ID: <CANn89i+sG1eHW+EAfcy+5_XTAF5VuQuNc+vjg_m=iqZ=ZPFE5A@mail.gmail.com>
Subject: Re: [PATCH net v2] tcp: Defer ts_recent changes until req is owned
To: Wang Hai <wanghai38@huawei.com>
Cc: kerneljasonxing@gmail.com, ncardwell@google.com, kuniyu@amazon.com, 
	davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, zhangchangzhong@huawei.com, liujian56@huawei.com, 
	yuehaibing@huawei.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 23, 2025 at 8:36=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Sat, Feb 22, 2025 at 11:41=E2=80=AFAM Wang Hai <wanghai38@huawei.com> =
wrote:
> >
> > The same 5-tuple packet may be processed by different CPUSs, so two
> > CPUs may receive different ack packets at the same time when the
> > state is TCP_NEW_SYN_RECV.
> >
> > In that case, req->ts_recent in tcp_check_req may be changed concurrent=
ly,
> > which will probably cause the newsk's ts_recent to be incorrectly large=
.
> > So that tcp_validate_incoming will fail.
> >
> > cpu1                                    cpu2
> > tcp_check_req
> >                                         tcp_check_req
> >  req->ts_recent =3D rcv_tsval =3D t1
> >                                          req->ts_recent =3D rcv_tsval =
=3D t2
> >
> >  syn_recv_sock
> >   newsk->ts_recent =3D req->ts_recent =3D t2 // t1 < t2
> > tcp_child_process
> >  tcp_rcv_state_process
> >   tcp_validate_incoming
> >    tcp_paws_check
> >     if ((s32)(rx_opt->ts_recent - rx_opt->rcv_tsval) <=3D paws_win)
> >         // t2 - t1 > paws_win, failed
> >
> > In tcp_check_req, Defer ts_recent changes to this skb's to fix this bug=
.
>
> I think this sentence is a bit misleading.
>
> What your patch does is to no longer change req->ts_recent,
> but conditionally update tcp_sk(child)->rx_opt.ts_recent

Also please change the patch title.

The fix is about not changing req->ts_recent at all.

