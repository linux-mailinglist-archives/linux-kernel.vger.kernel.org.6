Return-Path: <linux-kernel+bounces-392280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F0AE9B91D5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1590D1F2301F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:18:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB2219CCFA;
	Fri,  1 Nov 2024 13:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Jid+Hu6O"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A54175B1
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 13:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467098; cv=none; b=HZSId3gkj+4uhAsUvTrZXAYAa6HzyzhEuZhiZnYzbEdkBvL403KvSLCR6y1qsk0hqGYrHQEu2LWy2jEpyMBUOFDiZ8musKqEYs+EEWSASu5LPU9Ty2YwsRgE0v554EJE58HGbgBn0N/E8NPTs2aIT7DFL99enqVkNunJl62GQZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467098; c=relaxed/simple;
	bh=RdxH1k0Ii8oRON4S/9EyXeN10ibRW1RJYi7koqpVzMw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sEkhVjAT1eV96gY8k8HNAHeI5s7yNN6/tGgeeU60Lb4HaNhylooNx38dU1nGyjjk+aCjK1d0h4diNn8MjJxFkQVC+Z0ZDnAdcaGmtbf/F2PpvBPUUiXeScWgT6URiKTtRCjwC4hyvZ8TYtEGcU+eNS5PAezFozoAilGAgklkEYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Jid+Hu6O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730467095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RdxH1k0Ii8oRON4S/9EyXeN10ibRW1RJYi7koqpVzMw=;
	b=Jid+Hu6OH2Y8T7UkonBQwAs8gg34p4OvaELKKnS3e0ErnvloHaQWsDPkcnduD2soEaGQVo
	OH20cCvGjxohcDNUCHLXWmOinuT9yAgO6l4isHGw3Fze2Wvo6Bh1+JTGhJgJu4568zT8/w
	x/4Gnt+BOx2zzwdEAKXOZbxXZjZLyAA=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-_3DBnHfINZeV0KCh01iTVg-1; Fri, 01 Nov 2024 09:18:13 -0400
X-MC-Unique: _3DBnHfINZeV0KCh01iTVg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-539e0fa6f3dso1650327e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 06:18:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730467092; x=1731071892;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RdxH1k0Ii8oRON4S/9EyXeN10ibRW1RJYi7koqpVzMw=;
        b=bom1Asi7HD8jg4xZ4AC3jJwvZtRJWcMPIaC972REFHZYgeZgrF7PePA61rWldvYUxM
         Dd8o8UIJ4RxRUAHYnCndD3mtXZWk+ZlCMPu82utY5kzNDfNPXhZyGiIkuIjygiKJmE0B
         GqXDOZI97yXErJDZwuMAP4qX80FpBQrCwkxuUKhbtwuxcaDB30vrkU01rIvPJaHjJGE0
         xBEoqYRbxgoO94fSraqgYyBpsw4EwQvGhePJCmRMS7zmtPwLgtSqpmBxhtOsS1auxdf9
         9ofm2KLG/eXXSZMNk0KwLSTz3rW2nSUk1O4fUNIW0LdoO8tAFoYpYtgHOICtNUFV1CUJ
         APcQ==
X-Forwarded-Encrypted: i=1; AJvYcCWokM+d+iPtoXJZw1+3e0wBpQ1HFZygeR2kf5a3ad01pzuvHgWajXa//6YsETY7Pu330CEJvjd/Injy/34=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqXBANXprykQaeHFJXZdv036ZqvrLU8M9txpd/Eh6Pq4DyezrH
	e2XN4HTPcZo0vtPSUH/ENtSWUhKbB5/5WVcVluvZHLFFwYtMqS1iB+/Gto6kdB+K+gGe+rCxAlS
	Q9uswnIBeGWONVVUUpA6RYR05kSyEH89m7oILihrnAH+w4yOdossJzm8SdweMng==
X-Received: by 2002:a05:6512:2243:b0:535:6925:7a82 with SMTP id 2adb3069b0e04-53d65e0a8d4mr3212615e87.41.1730467091610;
        Fri, 01 Nov 2024 06:18:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJNVGRmbx39lG0hrP6GbSN+xYWdg5dI0TkiCnLiw1oNape2uMbIqGq3hW8ch9y34gU6zJIuQ==
X-Received: by 2002:a05:6512:2243:b0:535:6925:7a82 with SMTP id 2adb3069b0e04-53d65e0a8d4mr3212579e87.41.1730467091191;
        Fri, 01 Nov 2024 06:18:11 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e56681a03sm177661866b.197.2024.11.01.06.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 06:18:10 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id A10EE164B96A; Fri, 01 Nov 2024 14:18:04 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Maciej
 Fijalkowski <maciej.fijalkowski@intel.com>, Stanislav Fomichev
 <sdf@fomichev.me>, Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 12/18] xdp: add generic
 xdp_build_skb_from_buff()
In-Reply-To: <20241030165201.442301-13-aleksander.lobakin@intel.com>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
 <20241030165201.442301-13-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 01 Nov 2024 14:18:04 +0100
Message-ID: <87frob9joz.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> The code which builds an skb from an &xdp_buff keeps multiplying itself
> around the drivers with almost no changes. Let's try to stop that by
> adding a generic function.
> There's __xdp_build_skb_from_frame() already, so just convert it to take
> &xdp_buff instead, while making the original one a wrapper.

This does not seem to be what the patch actually does? :)

-Toke


