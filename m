Return-Path: <linux-kernel+bounces-434343-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA7E79E6545
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 05:07:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A691283BF4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Dec 2024 04:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03B9194120;
	Fri,  6 Dec 2024 04:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ms6W7Nt1"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE6461917C2
	for <linux-kernel@vger.kernel.org>; Fri,  6 Dec 2024 04:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733458043; cv=none; b=ri3OUWqPonKUCdT1BRmqddLVgS61RweWSREd4vzWo1PtiAU5LNEvYTsomhdkMBGdnK5LGYYZtFb+WsAt3vySPIryDsLg5FFJBjCfXcI84SwvJqMUli61kTz76ogWhs/2OGJcAy6QzDtwWEW9WA1b2D4eKvmua+rSKo+n2H1uBC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733458043; c=relaxed/simple;
	bh=zc8IKYC4bYs7JFUcgXSE+xqzD66zSoP3UvAGErf24aM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gfRptZ+paZhzDhCiyimRnOWl81E1vYXKkarou/qJM7TTrbpGlg9swU9MCsthdAky+lNzwMJcnyKXrgTs5OkTUp4P38E8lXboEkBEquVNfjb75jzsQ7P2ptBJhMPsWBzs7nSeMq8AK+gO3gLgJ7g41coGW7DNdTaQdPDBMicV3vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ms6W7Nt1; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-466ab386254so81471cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Dec 2024 20:07:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733458041; x=1734062841; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zc8IKYC4bYs7JFUcgXSE+xqzD66zSoP3UvAGErf24aM=;
        b=ms6W7Nt1Q1vlBgN16gSsKtMcq0emGF+BAiCn9qzdJsSQ5olN2tl0KhqGW1UlYLtOVU
         RH87GhLhqX/08quaAuhQACOai7SbI+/qY7mnKBZH0NRDLS75ZgpXg5MB4v96R6CTe7Sd
         1j4HQw9L+C72cbNRX5WHwFc5vm1ZrTLQQ0pIm2M67TWiyNj9p0UvlgZFsuuK54brP/9a
         j5p+7iftxC3HC4nG2CikY+B2gr8p+mZFhLYrftL+rP2NLM175ifDR2ym97lD9QJPqZry
         A4UX3iD2zBOouvJTkKKrwxZY8me+GKMuSLKBkVeMNFrVXycFVo+XpCZ/z2YM7Sk8qBqo
         LqoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733458041; x=1734062841;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zc8IKYC4bYs7JFUcgXSE+xqzD66zSoP3UvAGErf24aM=;
        b=ahkoOeXrekMfzuRzyVHail1wKBUAjrt7NE/XyDgydqs3Ve0zNZ8SgfKqUuOpszzxy1
         OJx3i3EgaB1DhcaKaLBTzoPm/k2fWPZV0TKvDIehzjYKk1Q1QdkES4e3S6Ce1tmMGOey
         DLDreRu/h32zNOv3OcvcJ6Hhqif55/H+ZzY2OvfFV3VVMdZ5PZdo/1/bd01wcOoDjtvT
         ngOr1EXA9bL4cAt31CFkKZ1OBBx9pt6ShoXF9hCZv5+iQuRnbS2yX62Hnc3m+22Sb0Qd
         /6Lf/jGRxwcsfYPb277ziWopPk98lQMqzQLJj91BG0CP1wAKuJr5Q5QbxlhMueOl/WcH
         nnwA==
X-Forwarded-Encrypted: i=1; AJvYcCUl3pDhEWBB/91Xh5uDTFsczlLMHj/JGxCtg1ujte0bNVAU2bjvRQMwZBaldsLSR9L2eiQ9oRxd8CqPdno=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxNAqFJVqarRFYYyVWV7aWdzpNOovx9r8Nr5MIWxtsniIUsapu
	w9iaFTpa2i7GMiGzinFxgnNlP7tZ5l5+gCRBCDaNTihYGCFLCErVNp1hhTWs3U2TRYoxL+kvPbN
	mXiZmPa3MvzDEYrRCudqX3Ubl5waVC/9TrQ0t
X-Gm-Gg: ASbGncstJ5OBUt+hAyCuc+LP4qzdYeAMN/dL5fDUK2VyGWrpxaEWeAO/CRY2BDQNk38
	ev0sx7m3ksxMq3V+jMqyNPqY5j5JAVNA=
X-Google-Smtp-Source: AGHT+IFhNufgJHHhaY4RGILgttSTB6KCwdR4rnZG6VizGxTFxIQRMw1S9EFuvWf4IcRYE183tm/6FiRSsYge13kTuAU=
X-Received: by 2002:a05:622a:4d0e:b0:461:679f:f1ba with SMTP id
 d75a77b69052e-4673567465amr2080011cf.20.1733458040480; Thu, 05 Dec 2024
 20:07:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241203173733.3181246-1-aleksander.lobakin@intel.com> <20241203173733.3181246-9-aleksander.lobakin@intel.com>
In-Reply-To: <20241203173733.3181246-9-aleksander.lobakin@intel.com>
From: Mina Almasry <almasrymina@google.com>
Date: Thu, 5 Dec 2024 20:07:08 -0800
Message-ID: <CAHS8izNV7u_opjXvf+WE__qDDxbUiGorodOeihS2EOxjoc2J-g@mail.gmail.com>
Subject: Re: [PATCH net-next v6 08/10] page_pool: make page_pool_put_page_bulk()
 handle array of netmems
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>, 
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Magnus Karlsson <magnus.karlsson@intel.com>, nex.sw.ncis.osdt.itp.upstreaming@intel.com, 
	bpf@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 3, 2024 at 9:43=E2=80=AFAM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> Currently, page_pool_put_page_bulk() indeed takes an array of pointers
> to the data, not pages, despite the name. As one side effect, when
> you're freeing frags from &skb_shared_info, xdp_return_frame_bulk()
> converts page pointers to virtual addresses and then
> page_pool_put_page_bulk() converts them back. Moreover, data pointers
> assume every frag is placed in the host memory, making this function
> non-universal.
> Make page_pool_put_page_bulk() handle array of netmems. Pass frag
> netmems directly and use virt_to_netmem() when freeing xdpf->data,
> so that the PP core will then get the compound netmem and take care
> of the rest.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Thank you very much. There are a handful of page_pool APIs that don't
yet have netmem replacements/equivalents. Thanks for taking up this
one as you look into XDP.

Reviewed-by: Mina Almasry <almasrymina@google.com>

