Return-Path: <linux-kernel+bounces-392172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C48009B9097
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 12:47:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 89CD728163E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2024 11:47:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0CFB19ADA3;
	Fri,  1 Nov 2024 11:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MrIR/2tS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FC12A1B2
	for <linux-kernel@vger.kernel.org>; Fri,  1 Nov 2024 11:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730461666; cv=none; b=I6+RPQJjhe1QF9wI34x4b+wDQGA8zn0AECpNh3tcm/GPLLYRu7k8ROtFRFDOfEJwj2CK6CEuBHscNlnpiohkUIGxpsbVBZ1KPV/TSRraXQRNwOznm+2nCrp+euvV2bTgDChQcoPmVMzANXUw7DgGvIyrz+QhmtuAyMDtoXmqT0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730461666; c=relaxed/simple;
	bh=rFzzuYAv2SKccWouLovsdeghCh1s+OmcwrhbhkmvI6g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GWFMszJ1Hqg/rw6U24uolAIqheUKxKMDVkFtbVWUW5RcvStIZ6mBKiBYcX3bizHN6Fmwjwzz44+okW0HxqACL8RrEj60lLpFVfizVNvSXU2Y0pUle9YIGJR9Q5U8JkxR1xiaZhqeQtPz4/sEPM7QlwDxJMjLNJ/ZIp26Zj+eb2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MrIR/2tS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730461663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rFzzuYAv2SKccWouLovsdeghCh1s+OmcwrhbhkmvI6g=;
	b=MrIR/2tSj/O9MnsqGKOoKSTJv+r8QS35qsRD2C3KaIzpAUjLB1cYo/4qebJFYCVcLUN8NA
	CuolRiQDG1MpU8dFf/WoERWSFaLhoyERKAqkH2EOfs4BboLg4iIAreLnrbcDIn23SNWi6p
	wBYdxPpQFJu4tHmNtc4p8kFKi7YC8jI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-2-pnDb-oMcOHPpoLqEOSZw-1; Fri, 01 Nov 2024 07:47:41 -0400
X-MC-Unique: 2-pnDb-oMcOHPpoLqEOSZw-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43152cd2843so11744995e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Nov 2024 04:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730461660; x=1731066460;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFzzuYAv2SKccWouLovsdeghCh1s+OmcwrhbhkmvI6g=;
        b=hT/4YIv2V+38ocFN0vhvtvHTJ4lsyVGtoUqXOgW8nugGOGyr8dpuN/SY+FctFT7BRy
         hj0sl6AonLCtX7+cqR3gyN4iG2GYXIRTOptKjb9J1aqIGS40F260Q1HYWUjvXg8tCyUO
         uwODNW80db66/JvKDc+fu7SQf3kwdqt0z+lAFewOhQM264eXRFygunLYf0WhaYNQEd/M
         PUHPn52ibvfitwpfxHSHskizKPEnY/riYDaHgxKOH3lrq/VvOprjbJ98FJMvG1dngWaI
         Lx2UtMdM+l2KEYnInDr7Isxy1rhUbqiS75QZcIk857z9IUGjDGYtpNHiIHR2hIM8wpFA
         YeKA==
X-Forwarded-Encrypted: i=1; AJvYcCVirp/hU9TO+KwrVV4YKR5vc7t+KjWR3+gbYvZ8wiBdWLBTf9xUnKwGnTZxMK7h3Kz2BPT39PqsNAQMoAo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzH+F3jm8JjhCv3D7RgfVG0aOlWJk3fdLsYw6/3e3gnZia3GFWd
	BiGI4u84G/FQhrBueg8nA37N8WVxfIFhd4KyzXhUb0dr9AJnrNO/ZSdE6DJ4v/rHKQBNqm1I00r
	oWAyunnXMAnYezl5dvPqbkL3mGyfMNX70YeO0keahrJ1m+YTazld+1lelKZB4PA==
X-Received: by 2002:a05:600c:1d97:b0:431:5459:33c2 with SMTP id 5b1f17b1804b1-431bb99053bmr107786765e9.17.1730461660617;
        Fri, 01 Nov 2024 04:47:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNlCYVzQ8SAbhWfaM5n3nvXcLZFSRiXEpUvQ8tFWfAU9tvUBvRq0rnYNEnYa0nWbeMoxReGw==
X-Received: by 2002:a05:600c:1d97:b0:431:5459:33c2 with SMTP id 5b1f17b1804b1-431bb99053bmr107786455e9.17.1730461660233;
        Fri, 01 Nov 2024 04:47:40 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10e7365sm4783523f8f.54.2024.11.01.04.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Nov 2024 04:47:39 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id BA4BA164B94E; Fri, 01 Nov 2024 12:47:38 +0100 (CET)
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
Subject: Re: [PATCH net-next v3 05/18] xdp, xsk: constify read-only
 arguments of some static inline helpers
In-Reply-To: <20241030165201.442301-6-aleksander.lobakin@intel.com>
References: <20241030165201.442301-1-aleksander.lobakin@intel.com>
 <20241030165201.442301-6-aleksander.lobakin@intel.com>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Fri, 01 Nov 2024 12:47:38 +0100
Message-ID: <87v7x79nvp.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexander Lobakin <aleksander.lobakin@intel.com> writes:

> Lots of read-only helpers for &xdp_buff and &xdp_frame, such as getting
> the frame length, skb_shared_info etc., don't have their arguments
> marked with `const` for no reason. Add the missing annotations to leave
> less place for mistakes and more for optimization.
>
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>


