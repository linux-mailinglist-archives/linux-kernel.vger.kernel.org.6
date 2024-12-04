Return-Path: <linux-kernel+bounces-430989-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EC5E9E37DD
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 11:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2313169624
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4CDC1B0F2E;
	Wed,  4 Dec 2024 10:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HYQnrOXT"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48471AC8B9
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 10:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733309354; cv=none; b=lsmBHCVhhp5DTqHVa7DXIyINAAyyPQLd2g00Oxk0A7BiBMCx5KUM9hODLoGjlCgK72jUFwI6Tz2KqAWm/jWTBSZgWJLds8ZfF7CLcw1W17NH9GA1R6iUwQuhL7B0yDxKJZhQ6+8IhBZfcqtbtPPi6bm5jH2rFs+vaN5oMiHFGAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733309354; c=relaxed/simple;
	bh=bGyB4438J81jRH4x6gWKO6BpBH8blrXI02fUkyoMcgo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=thmjT5JbUzo4SkniAVseZOz2PXRKo6VAf5aIQWluN/FsVMfxoaq4WLbHkUcqMA7A4JQRSNAH9gZ688CYN0T9SemvOk4ahTZKUWzvflJ9cnmI92QoY6mn0AD4EvuAWZs+WV/dQYs3HwnFoH+JfO3hrgekd4SjzlpiwwGKQ6mUAiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HYQnrOXT; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733309351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gTz3waxgahN3oOX83LVGcoQz1BmDfZdx8p5FTeZL4LM=;
	b=HYQnrOXT4gK1jXJZ6Phz4bDdhK3JXseFPQb9cFwEm1dR/hn1vEVqUp/D7LbV4IND4d5WrJ
	74skfoQBUTGrTwzA1YbZkOJLhMvVDoOlEp4LCPTXCjnkXM+PpocMQihFvbMZ+NEUs7a0lC
	6i5/i8a04hN2apIu8wJzXcNOjRlJinw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-QezxPo1cM-WqQ1U-QCkerQ-1; Wed, 04 Dec 2024 05:49:10 -0500
X-MC-Unique: QezxPo1cM-WqQ1U-QCkerQ-1
X-Mimecast-MFC-AGG-ID: QezxPo1cM-WqQ1U-QCkerQ
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-385e9c698e7so458081f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 Dec 2024 02:49:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733309349; x=1733914149;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gTz3waxgahN3oOX83LVGcoQz1BmDfZdx8p5FTeZL4LM=;
        b=QXk+jzuqBzlGPNA8NQIuIvtsQhpX7jB33569TkTgKAnvs3DHWN7NGtQtJfmvpSd9ax
         QgU5vqUZAkgKPazbN2/pNaADcef1GXKBr5zKCEXshtL5K0kL92IFRtrJ4cEFgrV+/oqs
         WpfcpWflDOWxpJgKafiuAn/Q8bX0aQeoFCyv/av6JwX5iGfERLDQTd6am741458cWifU
         ozmv5vl1YIaWWr7Tksb6JzwAOjUAOiWDWMG0o+sjw3BQm3lFTqe8Ttr/5F/qelCzMVUl
         Ia+hMgsTeQuvYs7l3kd8x4/4WOlosn18lxnwuXFZddBN6YKQ5P85HFXrXjZQDi9NPPxX
         Ef6w==
X-Forwarded-Encrypted: i=1; AJvYcCV1FbKSQnIO5bWHdG2Xf5/dz0jeFh9qTm3i0JjNKuIj5s8xIX7w0BdN8GKLBAZ76ILsBCiAuXx9BpPHBNY=@vger.kernel.org
X-Gm-Message-State: AOJu0YznztbN/2yN7wX9UmQ5L9xGyvzOKwFZHBPpawbum0YYewpdLOyO
	jc250Dt5jNgxPBukfjwGjhsnjuOw7BzOF/LaJD213HOY3Z6EdGibpnA/baY1DILToDMSs+ziZLu
	sLCKAkQZyZLhmDSmOSDTZUsnowBSF2yyI/s0cQn+9T+V9Vj5/jGyIZRga+9xHBw==
X-Gm-Gg: ASbGncu4sFC0L76XLCZwR8yts9s5mZ07GHRPDzEIcB9AZRrkdKtT/L9PfhTkhygXo0E
	fEDQD8YForTeBXEu5bxkSexTLANk+JdlwNEOYjMHPx2P9/32eu6HwQD5Zkw00tpWtNOoGQm3SH1
	SyE7/2rcpEzeyYpJP5SSehyOebovdyYJz7SThBDaZUHh8akWihNUxwCo1sPcuPB8us9HDQ8KJpd
	kYbdkDLjnFNJS3kIyWN4Xi6+QDdUQH85c7XqnJilnLGP9U=
X-Received: by 2002:a05:6000:401f:b0:385:ef14:3b55 with SMTP id ffacd0b85a97d-385fd9abb87mr4384223f8f.19.1733309348364;
        Wed, 04 Dec 2024 02:49:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHcEgMypYhXM56G/nD3wm0gwci3A8/obXgJv7EiRTyM21DWn6RxvvWTZKFaMDEAHFySbGhZ5A==
X-Received: by 2002:a05:6000:401f:b0:385:ef14:3b55 with SMTP id ffacd0b85a97d-385fd9abb87mr4384198f8f.19.1733309348033;
        Wed, 04 Dec 2024 02:49:08 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd36b80sm17799002f8f.29.2024.12.04.02.49.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 02:49:07 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 8C43016BD10C; Wed, 04 Dec 2024 11:49:06 +0100 (CET)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Maciej Fijalkowski
 <maciej.fijalkowski@intel.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 nex.sw.ncis.osdt.itp.upstreaming@intel.com, bpf@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v6 07/10] netmem: add a couple of page helper
 wrappers
In-Reply-To: <20241203173733.3181246-8-aleksander.lobakin@intel.com>
References: <20241203173733.3181246-1-aleksander.lobakin@intel.com>
 <20241203173733.3181246-8-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 04 Dec 2024 11:49:06 +0100
Message-ID: <87ttbjafkt.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> Add the following netmem counterparts:
>
> * virt_to_netmem() -- simple page_to_netmem(virt_to_page()) wrapper;
> * netmem_is_pfmemalloc() -- page_is_pfmemalloc() for page-backed
> 			    netmems, false otherwise;
>
> and the following "unsafe" versions:
>
> * __netmem_to_page()
> * __netmem_get_pp()
> * __netmem_address()
>
> They do the same as their non-underscored buddies, but assume the netmem
> is always page-backed. When working with header &page_pools, you don't
> need to check whether netmem belongs to the host memory and you can
> never get NULL instead of &page. Checks for the LSB, clearing the LSB,
> branches take cycles and increase object code size, sometimes
> significantly. When you're sure your PP is always host, you can avoid
> this by using the underscored counterparts.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Makes sense to have these as helpers, spelling out the constraints

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


