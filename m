Return-Path: <linux-kernel+bounces-392259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5160E9B91A2
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 14:13:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 816C51C21DCF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 13:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F05619F42C;
	Fri,  1 Nov 2024 13:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bODVFlYc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81185155A5D
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 13:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730466822; cv=none; b=E23PVs4bpG8GR9F2C17+wrM/K1mI5jWdocj6/+romsm6ZSTMJ9KIv3lHZUkofe4qHWqBU7hAp2E/RoehEKssPepdZKnQ1/v0cmpQKgHA2a6711nP4thi6yk/hlsR10MlRw9akBA2Pn+24FMsYH95LGc9b+C+SWhQM3vTkaZ+VVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730466822; c=relaxed/simple;
	bh=L5CVurix7+30nzpI9IV03X7MQodXDpgxTJqDlhMhtTg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q5pd5EJ66U4YCOKDuZ4puvEQ0cbSM1NTCZN18IrPAW3zSBkrpXaZmg3AFdheKPA/NgB5iQH+n6hSbjot+NyIrF7dX996nnlU0HSlEXj3L1mUP8+ItrRJOIbwEd46639mHsw/OTSXfjFlJYTfHUU2OdPp0PphLKE7oN/2zdloe7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bODVFlYc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730466819;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L5CVurix7+30nzpI9IV03X7MQodXDpgxTJqDlhMhtTg=;
	b=bODVFlYcTvDZK64S0vUZ7rYN2FwmK8SMTzX09NYlttGq+18qMKsVZC0CzL+EzyKJQ57DEA
	FDfbpdFiiwrLc84xmlvxWZTwMJfw9KKN5OjtFXG+V35hYZY9tZ4JvKIQOxDDmhV276Fc4Q
	3yfHlUF+GrClfsqMPRtab/MGHf4lw5w=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-vUV1T2MYOvy2kfOtnw_LSQ-1; Fri, 01 Nov 2024 09:13:38 -0400
X-MC-Unique: vUV1T2MYOvy2kfOtnw_LSQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a9e0eb26f08so168812366b.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 06:13:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730466817; x=1731071617;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L5CVurix7+30nzpI9IV03X7MQodXDpgxTJqDlhMhtTg=;
        b=urs7QfrxEliITqRtiSPb/y6/ZfQfHWGyxSrs1SizGS6I1+bc9uElWkDIRXyBHHlmHH
         f+Iro1+M4hWKDTeUkwCzj0fAth95eKKB+sDlmNrMjRf2icHGtdYlN2rMBjdKDelurS86
         YlBiNO103aTxXzS31bT0VHSImZE1EWVqewpjFrTj2ZQbGMWoljidjf/Bap8HaHXzCzkC
         jVgJrowQuzeYsuK76y656kzC5jGiJhSrcTR9tmqWOURANhjn63NS0hSCh9vanQQyc9gA
         Uc9EWi6iuzqLw/AE2n07p8GCLs5LAo3XUHHrfSmKax004so8z0n40cn74hoG9vWrCAKD
         ZbiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWilbQvA153QgBO6MsVlSqmkchyHUVaxYpXC2m7+AsVGRmZnmYG9PQg/sN6kwsqrxnKO7H3snheBihu3is=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxf4U7LvJuveBFx6MGkSglxD6KCrXcnPVfKvNVxAfr4fEXjSDW
	G97GZwWRzyfsQq58V0f4exmJj02zKu4TOMpV1oEMY7nyi6l63Vm1bWp+hpJr2BibRd8ELY/+u/M
	NySvskN4HvPCmi4lUtzM2v/0GxHcBzSK5uz70KoP0q5UzIz7ATdcsQwB/7d18zw==
X-Received: by 2002:a17:907:3f99:b0:a9a:bbcf:a39f with SMTP id a640c23a62f3a-a9e3a6ca281mr1084509366b.43.1730466816966;
        Fri, 01 Nov 2024 06:13:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuHAS1/AYRkBTQXHwF48y6LdOUW+QPelszDi8D+myCfGJMI1eTs1lFcGd+BkSBw+5Z+W4uKA==
X-Received: by 2002:a17:907:3f99:b0:a9a:bbcf:a39f with SMTP id a640c23a62f3a-a9e3a6ca281mr1084504966b.43.1730466816491;
        Fri, 01 Nov 2024 06:13:36 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e565e098asm178704566b.132.2024.11.01.06.13.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 06:13:35 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id E7766164B965; Fri, 01 Nov 2024 14:13:34 +0100 (CET)
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
Subject: Re: [PATCH net-next v3 10/18] xdp: get rid of xdp_frame::mem.id
In-Reply-To: <20241030165201.442301-11-aleksander.lobakin@intel.com>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
 <20241030165201.442301-11-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 01 Nov 2024 14:13:34 +0100
Message-ID: <87ikt79jwh.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> Initially, xdp_frame::mem.id was used to search for the corresponding
> &page_pool to return the page correctly.
> However, after that struct page now contains a direct pointer to its PP,
> further keeping of this field makes no sense. xdp_return_frame_bulk()
> still uses it to do a lookup, but this is rather a leftover.
> Remove xdp_frame::mem and replace it with ::mem_type, as only memory
> type still matters and we need to know it to be able to free the frame
> correctly.
> As a cute side effect, we can now make every scalar field in &xdp_frame
> of 4 byte width, speeding up accesses to them.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


