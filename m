Return-Path: <linux-kernel+bounces-392281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D34C89B91DB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A1B71F23221
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:20:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6783319AD5C;
	Fri,  1 Nov 2024 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UeP8CHfs"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 060A139FCE
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 13:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730467222; cv=none; b=Pv2WIoqmoF4kN2yuqZOKmkleERs0iVyxfNueHQsceWwLhFX0M5xNuJmBzCXuMVHOks0w2xsUmnUDY3RTzFeDU9kRpFLOd0IKk3X9lG2R2qNVtHPuyy/4FORwJkkY31wVOqmjMHFc5KqK1WvVVJPg/UcgZIaHoLwtyKhPHSkv1JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730467222; c=relaxed/simple;
	bh=Ib8c0+yuO2W2Ly0kNs6PCZE+6yi5m+yTERQ1KrasL38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kVHLtDkXy92/6TmeZb+3cxFVyOVbQJ64eRZCk02iYxRAoLwkkrNMjTrSA9XrKT+kP4DSjjEpqVadG8PQVQFog7VZXSNisu+kPBFT+gxQVofY6Ca/uoNfTPzj2o/Zgt3NgUd3KB5iEVtxPLeARHUD9zxlXQ0ZjTfbTH8vir088UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UeP8CHfs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730467220;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ib8c0+yuO2W2Ly0kNs6PCZE+6yi5m+yTERQ1KrasL38=;
	b=UeP8CHfsqcotZPPLvKPPdKM5UVRjgHqfOW1Sq2sB1CHTjCKzer6M5De8RXqzYQsfcMgFQS
	eTnWi52hfpUg8Ojbva3+FWY34byu5V8115sjq2zW2dD9WfRQUhNkuW/IV/8+RaQpNKrphT
	l3M9EkWy+JQctJbbyo7BVJCJnqkYMTM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-6z04EaFNOSK-ukkE1XKCvg-1; Fri, 01 Nov 2024 09:20:18 -0400
X-MC-Unique: 6z04EaFNOSK-ukkE1XKCvg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5c943824429so1274141a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 06:20:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730467218; x=1731072018;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ib8c0+yuO2W2Ly0kNs6PCZE+6yi5m+yTERQ1KrasL38=;
        b=Rv3sgRs1SqmlttuP1L1HC3jPO0kePqAJCA1CVk7dn5IXWSFv/VAEbTM7YzJ5YTxIx3
         aacrGrkNaGC+qEZgr0g4va7otQ+JxoC6gU7ZIBJTWwX5YFWyzJb2R1++4t54bT3HHbZP
         xbG17FbrqlXGETH6syvkq/84x6CPpw/OnqFLF7722CBcfIr8uJps0xeEdX8jdcPFXDn1
         CYBeYrvOyvT+KTr7jJ8CMQM1lGHi2v52Lq+nKAR7AeLEKwonJ4yT2I/hwyB2g0K4NlpR
         itpd82bFiXID0f6xCUmRiLpBEImDz36vAdB+8VdSHLzgjQGDRMFJTeY5FUDT/Gx7mnU2
         /3vQ==
X-Forwarded-Encrypted: i=1; AJvYcCVe6BMtOiXZbfInGt0+kd3okTAbNIjW6Ya8YbtkXG1RL/1V2a7qD/8FwbvpOnK6nL1Ok7VUiQ80/BdaMVA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcpHcUkFFTcfEF8mEUDv8I6pjA+PmP3QypqwHU4ES0IkzuOzYP
	uc5HKeF80jWLq2vpQ6sVx1EvOTa8fvplTq3xphQtqNp1+cl9IVQ09A35VHw4H7DfH1URhzvlySb
	WGRpx72DZ5DNa87rhKXfs1d2Jbmzv6DlWFHj/HnKX7Bh9G3MHXkjAPMpzpejUBQ==
X-Received: by 2002:a05:6402:1ed5:b0:5cb:6ca4:f4cd with SMTP id 4fb4d7f45d1cf-5cbbf8796ddmr18547523a12.7.1730467217655;
        Fri, 01 Nov 2024 06:20:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFn2LPy1gUSuHKruS07GtqCmqVzlHOCD3B7tPcLNUXMz/VgPBnOw/2+LoemulFTTN8uCfv4sg==
X-Received: by 2002:a05:6402:1ed5:b0:5cb:6ca4:f4cd with SMTP id 4fb4d7f45d1cf-5cbbf8796ddmr18547486a12.7.1730467217170;
        Fri, 01 Nov 2024 06:20:17 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac74c6a3sm1513563a12.1.2024.11.01.06.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 06:20:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 1A99E164B96C; Fri, 01 Nov 2024 14:20:13 +0100 (CET)
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
Subject: Re: [PATCH net-next v3 13/18] xsk: allow attaching XSk pool via
 xdp_rxq_info_reg_mem_model()
In-Reply-To: <20241030165201.442301-14-aleksander.lobakin@intel.com>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
 <20241030165201.442301-14-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 01 Nov 2024 14:20:13 +0100
Message-ID: <87cyjf9jle.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> When you register an XSk pool as XDP Rxq info memory model, you then
> need to manually attach it after the registration.
> Let the user combine both actions into one by just passing a pointer
> to the pool directly to xdp_rxq_info_reg_mem_model(), which will take
> care of calling xsk_pool_set_rxq_info(). This looks similar to how a
> &page_pool gets registered and reduce repeating driver code.
>
> Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


