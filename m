Return-Path: <linux-kernel+bounces-392174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A67A9B90A1
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C14FD1F22A5C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12A4019CC02;
	Fri,  1 Nov 2024 11:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cseM5bZD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB05F16F900
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 11:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730461899; cv=none; b=XiQb6UBqZLEwPYa95aHMTDIh6uzx6fm80Z9YU5jqthKsMBeoluWIw1EBBXCcGdZkbx9QIDHo8JL5xxxvQi3ggK10g+KGhqfRb/oROuuhSiaoiYxP8MH1D4Xj3PMPgrjtN3gBvV2W71lRnjdKqwvxCliw7k5WhKpxG1jzwO1kHIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730461899; c=relaxed/simple;
	bh=rsEHgKLuWcvz36/Rz5yzfsGk6AH+liwbTq1/0AfcL1w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PcFk9XQ6vK10vYH8Xb9nogmNc6qpKsRUVqxGOQBn5cScRJY5c32MYzty1UB+pNEmeKkJ1ml+ExJUnOOgvKFis5UE4tWeV/pVDd+DEUpdCJ/5KZXlpUNQJLBxZCdG7GiCncabCmgPTthEInswt42nTOqTj9fImWwrPMoBIUVddoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cseM5bZD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730461896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rsEHgKLuWcvz36/Rz5yzfsGk6AH+liwbTq1/0AfcL1w=;
	b=cseM5bZDXfdL/sXIY6MvY988lorunH8k5w1EJyfXtKhhNpooKqHMEzG9ueFUTbv4j0Jld1
	B5FANt/+qtwJCQtcnk3kxAq5ad7k1k31NmKpLoLuHspWjCbuQbO0pAd4feydmjcO5/xa++
	dV++jTZQ7g13ttIsbGz07N79Prt6wP4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-lj5kXeRHPDqqUbzhwdqSFQ-1; Fri, 01 Nov 2024 07:51:33 -0400
X-MC-Unique: lj5kXeRHPDqqUbzhwdqSFQ-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-37d95264eb4so1026937f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 04:51:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730461892; x=1731066692;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsEHgKLuWcvz36/Rz5yzfsGk6AH+liwbTq1/0AfcL1w=;
        b=Zn6wg+x0/h6WZpCegVmZUbUPx3S2TbT5H13Vyjr+j+07+JAuus2KdslLaOhlsln+GI
         fHIjQ7vP8TklJr6L4urRZTXHkHHMr1LmWhLewpYBT0ZIRcfrnMrvi2/OuFh0N0P4+imZ
         NMkjhzLDhZ/lYgCDWBlrZBPgxwQSySB4qyr24VZZX0unciTa3r7KkrlGH55OLaneo/Fy
         pmxCqmhJ92C+Ml0RZjgsCsLtn5Spjvs8+flPyNGFf6cqH4hfkWE1lzgtbHkSXAMDUrCd
         sfkucJGSfXaAdNxSuS+NY+Yyyd1MyaZ3K3l7GA4fZMfDhSCMeF2qpvGmzNBifka2XbiR
         gY+A==
X-Forwarded-Encrypted: i=1; AJvYcCVTWGugfUwesE1b02n0rm/NWU4iNWoekEam+2bViT+38DVFICNUbUnj7N2vX7Ezib0a7/adjruZC6gU1pE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxz1N9g1DGlgeLfVp5+pPytMqGz3X2D9g7fpUOq90AQ7Bdnl61f
	Ob1h5hbirlNnZrrhbqpb0KrAIJ0EEcKJx+pDOIZwHRGqaw/vsxHkAOFH2qRfU4t7+oTSbMm9RMC
	lu54uc/9XRpBVCtNAqNafhjObU8YGhrvgdkduTtbiGhF5zjADyl+gLG2llN6alg==
X-Received: by 2002:a05:6000:1564:b0:37d:94d6:5e20 with SMTP id ffacd0b85a97d-381be764e4amr6409653f8f.4.1730461892455;
        Fri, 01 Nov 2024 04:51:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGS/eOEyEN3rqadpyq16ef47A5nw2zggvZfNjgqN1OyQ1xs15a45QCa7mgQruSh8w34R8VLyg==
X-Received: by 2002:a05:6000:1564:b0:37d:94d6:5e20 with SMTP id ffacd0b85a97d-381be764e4amr6409639f8f.4.1730461892097;
        Fri, 01 Nov 2024 04:51:32 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c113dd8asm4861201f8f.73.2024.11.01.04.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 04:51:31 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9329C164B950; Fri, 01 Nov 2024 12:51:30 +0100 (CET)
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
Subject: Re: [PATCH net-next v3 06/18] xdp: allow attaching already
 registered memory model to xdp_rxq_info
In-Reply-To: <20241030165201.442301-7-aleksander.lobakin@intel.com>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
 <20241030165201.442301-7-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 01 Nov 2024 12:51:30 +0100
Message-ID: <87r07v9np9.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> One may need to register memory model separately from xdp_rxq_info. One
> simple example may be XDP test run code, but in general, it might be
> useful when memory model registering is managed by one layer and then
> XDP RxQ info by a different one.
> Allow such scenarios by adding a simple helper which "attaches" an
> already registered memory model to the desired xdp_rxq_info. As this
> is mostly needed for Page Pool, add a special function to do that for
> a &page_pool pointer.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


