Return-Path: <linux-kernel+bounces-194262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E438B8D3912
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 16:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1FFA61C227A0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 May 2024 14:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD5615820C;
	Wed, 29 May 2024 14:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FzEFmOaG"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDFD157E9D
	for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 14:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716992680; cv=none; b=B2SMiJiqxNf8Oy/u9fsq04qo4zqOGM958U9xF8P5Tgy5scaqEZD5APQTSP8pQ5SNO1kONWD13r2Qa/pbMruHHT2VpCFqp2IPLJZcFT4P97+N5WPTUjkXtFXSrsLFFdVn3CWXTleZUQH7uBhsCEShYSSfW721WOisJB1LCBFarNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716992680; c=relaxed/simple;
	bh=JAxbuHoQBZ49w41Mn9Exw5TKZvwkktDZUEKmSaoKOFo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Lr/eq6iRnEXIs/Wz9tn5Ay9YNvkO8K7EFO3wt9EdrFIqi2nS7r41N2u2A1cQoPuH+rihoK8xT7+lRjy1DHSTUmQ1VFw5gMQ1y2Q7Bekk/JbAAhL/nDDAiLuS4mXutuUR2X2KXOki2xftQ/TO0p5lZbILiL+ibjBsv0NTFhX322k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FzEFmOaG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1716992677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CaOh1l0Lu41LPYOrXz2nXavJQHgEuj8sHreCoqbxNhY=;
	b=FzEFmOaGCXkqxhm7fCBba5UnkYALl43qLXF+V8HJ2UrDth5YQTYjXuQolAMSVYHjjTTHaT
	w3yvTxaAVCZ0LoaeH5SrWYNou439nfpg+/O8y+GsWa1CmeFvXmyMx/mYD6nNL+ZxhMTGpe
	tTr7q1bivPAkSYBEaoU4aUHX4P1a7PI=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-rThtDyCGNAuuVKpeH9PlFQ-1; Wed, 29 May 2024 10:24:36 -0400
X-MC-Unique: rThtDyCGNAuuVKpeH9PlFQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a659c998bc9so25459466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 May 2024 07:24:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716992675; x=1717597475;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CaOh1l0Lu41LPYOrXz2nXavJQHgEuj8sHreCoqbxNhY=;
        b=v34gNlij+lvcjNBCMVK3E8f16grVjfGN/gAiLAfs0Q7Pu7hgXZE8CxYe5x9eJuoCNE
         DFU8ewh7gzkgwzQPpDmaxAIEowHpBeBfRFSeVZgwXVUPh664x2YfTJmgjrZKQvfKGDd7
         k0RdSzuyyZoQV+2m0X6mudRRoRGehe1D1PwuIXdbi6zR4Bwdln0c4tZ0TbI3XEUkCtOV
         EEdYjJnNAPxUHXPax1ajh30M+qaC8NGdqt4XlRwVubn3wNumMRdOoj7nc4p3h41/V+fI
         tN7+gDaCxZg9vdjLRmX7IHfaRE0epe6QnQfRNqEK3Rbd3SS8ViadkOQOAb5bpc4l4j3G
         GmRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVHjiy8fSO7M4YeMtTgm9fxlpLpnhEuOl6qODGN4FYqIkfsRhHEmcbjOGqyUVF/ZEFKda1DLgR4muLFGWi+EGmCPmGsKIBwJDRDRyR
X-Gm-Message-State: AOJu0Yzdlq6yriio9gWTLor0bzYoTGjq26+mAknJ4/yj2tAoF9KV2Rrx
	WIo+3YwhwppvagA5YI9PVEu0ixrmSLmo5wdMlOJsA9pKc27fK+UZlq9bfaY5EhVBTxWCO9Tum0E
	4ry7FvABGW/rianz45bsltdkr31YqyAziWQZ7ZnCmL6ocWptLYD8GK9wTe1mF6g==
X-Received: by 2002:a17:906:413:b0:a63:4e95:5639 with SMTP id a640c23a62f3a-a634e95579dmr280209066b.47.1716992675171;
        Wed, 29 May 2024 07:24:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEoMcMMypUJzk39vMbEP225084t98GDv20PFArbG9E2Gd05mxwJZaA+E/zvafN6DVb5r8Z9aA==
X-Received: by 2002:a17:906:413:b0:a63:4e95:5639 with SMTP id a640c23a62f3a-a634e95579dmr280206566b.47.1716992674677;
        Wed, 29 May 2024 07:24:34 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a626c8176e1sm715455666b.8.2024.05.29.07.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 May 2024 07:24:34 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id EFBDF12F7EDE; Wed, 29 May 2024 16:24:33 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Thorsten Blum <thorsten.blum@toblux.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Martin
 KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, KP
 Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo
 <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, Thorsten Blum <thorsten.blum@toblux.com>
Subject: Re: [PATCH] bpf, devmap: Remove unnecessary if check in for loop
In-Reply-To: <20240529101900.103913-2-thorsten.blum@toblux.com>
References: <20240529101900.103913-2-thorsten.blum@toblux.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 29 May 2024 16:24:33 +0200
Message-ID: <874jaghf1a.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Thorsten Blum <thorsten.blum@toblux.com> writes:

> The iterator variable dst cannot be NULL and the if check can be
> removed.
>
> Remove it and fix the following Coccinelle/coccicheck warning reported
> by itnull.cocci:
>
> 	ERROR: iterator variable bound on line 762 cannot be NULL
>
> Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


