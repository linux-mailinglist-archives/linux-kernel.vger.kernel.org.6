Return-Path: <linux-kernel+bounces-392184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3CA9B90C3
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:56:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B2111F229A0
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB49419CC2F;
	Fri,  1 Nov 2024 11:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DlXt89pp"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E1A19E98D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 11:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730462142; cv=none; b=PkDPS0/p+k9wVTT0D6lmMReU4hs8JD3zrrG6fMD8WcBN2pBgUyrll9BmUH93ekIsKJxaTkvjJAd64LG5pvzMLUUzLjbPHnF8r/g64CFx9SUbJsOyyGcv4pshSFz3kcVEmaFnJd/o4vdbg81S5UGbG3kct+9etxzjF/s+dPBtqNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730462142; c=relaxed/simple;
	bh=rLQ4GXrsRTWIucVhLiNMXbTmVHbjcN4k1ofxkLMQ4Hs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LxS29V102b1r4o1JgmWzQKnnyAs8oK8drLk/O4ZyvY6B92O8EUp2o/zoOtSCC6TQNI7HoHa9aWpgQetgzF980TwQHOV/L9ZyODREt3sVLaS1JtvTrAwPsnGHh6BdSKisiguuQXQ5DgEAFNdcZih8quzIXzUBfWRF8qN2xG73Lgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DlXt89pp; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730462139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rLQ4GXrsRTWIucVhLiNMXbTmVHbjcN4k1ofxkLMQ4Hs=;
	b=DlXt89pp0tsbn7Ogej74tDuDw1c5nOYnMmwQsotaVnbhXgq2se/20cGeXX9fFEAu19AJsn
	Ms+ChaqdB5Aw5E7g95v4py/C7TylEXrt94G+WaFbC7Xlda6oC4IADcdpdXzOErQeiIxRck
	2ZXUkeR/uKb1BFs6yjAW7KKz/wYUPnE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-vXCFvVF7N1ysstw0-juCig-1; Fri, 01 Nov 2024 07:55:36 -0400
X-MC-Unique: vXCFvVF7N1ysstw0-juCig-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-431ad45828aso12466185e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 04:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730462135; x=1731066935;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rLQ4GXrsRTWIucVhLiNMXbTmVHbjcN4k1ofxkLMQ4Hs=;
        b=N2HLsOxLGfxuZ0cj3x5wP8BiinJvkxZRGKKKQcrz4BWFdnlj9gIMaVrzwWtI53NR1X
         mc+qZESIMQD7LHFufPC+xnSTgqj+p9nYXHerMQw38wypu94jA2dY7EQJ48bGnxXS3zGj
         Nvbm0yRQO1kDQrAqmiDZt585tIxWZe8XMRawpsku6VbsZyK8Et/NW9obFA40H6G+nTjt
         KlIyM36q7CPm4k3LrD48nFW7Uz2e4TOP+76xpSIbRwquk9RG0iL1VqydbqkLxEilD4on
         3nLBpSUR9QVOqAD3I1fBs/Gx+hPyy3bxayrhl+U74N9efsIQaI8v0WHzt7fEjRLOaCAG
         blRg==
X-Forwarded-Encrypted: i=1; AJvYcCV0zfi9sF2IISzzYNaY0qU7unvOc9sp3XzCSUSbF/FL7B9FQbIR6NQJ31PYiaEx7MViP+3Xj8cT3styI6o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8B6Z42kELyYQ6bendeA5YwlUHzBVoxkBP4AWoG0ndX7TJatl9
	PjvpNzWMOfIIS8F/rKkLrLWKemK1MMnj4FZdjJa7oen6pMgj84KnkDPT1wclfURJbuHeu0ID4Bt
	C1YmTWnf3gnSKAjKp94QqQrRYhco4rfr392D87+Ozn6Jv6qysafbtUXg27SABZA==
X-Received: by 2002:a05:600c:44c7:b0:432:7c30:abe6 with SMTP id 5b1f17b1804b1-4327c30aceemr55975955e9.21.1730462134942;
        Fri, 01 Nov 2024 04:55:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXdZQxj5mJ15uEy0W+r4kOyT+V+7YgqEIK5DabkPt4xJ6deLsXNknYU9o2vdqVUwG8HD9SXg==
X-Received: by 2002:a05:600c:44c7:b0:432:7c30:abe6 with SMTP id 5b1f17b1804b1-4327c30aceemr55975735e9.21.1730462134490;
        Fri, 01 Nov 2024 04:55:34 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431bd947c03sm88091215e9.28.2024.11.01.04.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 04:55:33 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id C2940164B952; Fri, 01 Nov 2024 12:55:32 +0100 (CET)
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
Subject: Re: [PATCH net-next v3 08/18] page_pool: make
 page_pool_put_page_bulk() actually handle array of pages
In-Reply-To: <20241030165201.442301-9-aleksander.lobakin@intel.com>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
 <20241030165201.442301-9-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 01 Nov 2024 12:55:32 +0100
Message-ID: <87o72z9nij.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> Currently, page_pool_put_page_bulk() indeed takes an array of pointers
> to the data, not pages, despite the name. As one side effect, when
> you're freeing frags from &skb_shared_info, xdp_return_frame_bulk()
> converts page pointers to virtual addresses and then
> page_pool_put_page_bulk() converts them back.
> Make page_pool_put_page_bulk() actually handle array of pages. Pass
> frags directly and use virt_to_page() when freeing xdpf->data, so that
> the PP core will then get the compound head and take care of the rest.
>
> Reviewed-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


