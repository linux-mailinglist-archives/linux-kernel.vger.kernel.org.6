Return-Path: <linux-kernel+bounces-571120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A42A6B96C
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 12:03:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55E019C1D56
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 11:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3A7422155C;
	Fri, 21 Mar 2025 11:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VnUUuLZY"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B192D1EFF93
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 11:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742554859; cv=none; b=QybxSxWu7spdnZk3u/LayKIhU85lq48xdft8mQ2Zy0ptPKKJWOrgXu4oD7L9aE/MKPf+9tzo1so6bPIlkthB1X0SWLa/zNehTzGQiOguKWdREhcVzLs6+BkP664Ppty/estSYKml5eMp9YyYfLo073lV/w1wvQOh2JiNFNFrObE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742554859; c=relaxed/simple;
	bh=MClhHYdDYbfSs0X8oLGlhpUPZfPqb+p3CJs/tABView=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lJ9VtbpYR+bxSu+CjI3t0evL+rE757czTdLdINqk6F+8JxYJvcofr/8mklry/9724gAi2tKWu+nDOPM+FlOSsdZrcYjBW+Y8XjnyLLbMgxfaEAmS8B9btU8UOr533jbRghBgksjVkV9uzRK4TRqR5VXaeswQpIWSIpt0pLiOUug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VnUUuLZY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742554856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kR92x38MaPIUcSwwuTEs6+JYl/zG4hCrnKTSGKNxEmY=;
	b=VnUUuLZYWef2vkjUbEAdHaGLDkH2+95egn7TnnIkniJGieVMWGXeQF5xqeYfaway912S/o
	ewHcahtVkelLVUVVOxblarkBDH7+WqdN6Y6TjNxZUJftA0bEQK4PDAtTb22DqfCzLdPVzF
	WoUn4c2hrTnQpT2rq77Yc7Ly/4wHA+o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-286-mee-NGPyOiG5eBzh11t4rw-1; Fri, 21 Mar 2025 07:00:55 -0400
X-MC-Unique: mee-NGPyOiG5eBzh11t4rw-1
X-Mimecast-MFC-AGG-ID: mee-NGPyOiG5eBzh11t4rw_1742554853
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac2bb3ac7edso186400066b.2
        for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 04:00:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742554853; x=1743159653;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kR92x38MaPIUcSwwuTEs6+JYl/zG4hCrnKTSGKNxEmY=;
        b=oAY6l0yCFYEwfX9lPZpO9wkdQ7hwEKvhbBKVUX9yX5M0ts8QIaBlV0Lc4tfQ7Hje0t
         skJcO0k1mJQMdFzYx/2Y0vTcr/IaTN0sHDyEd5OGF+9pIwqHy4nn7OfMdEkhLNhhvZt+
         j8VMS0nyoxn9f+S3rZsGP2Tn/v2vt2tmG0SbgyB5FLAsUtQts8wcsRG+U7UCVOpdEz9q
         gX5HOSDlqDrmuKDQoP7j3dB+UGvyuK8TzdRl2wJKIKjd+BWVGVWVKsL9vPf3BOZkU4d3
         wIxyM+1zCgvVQcXemXSK6oeHLn3oqXXrbtTfpC5UzH04beOTjd/A3WSpWfhFCNCxgrPc
         rWFA==
X-Forwarded-Encrypted: i=1; AJvYcCVUd5hcYfDcTUtWHTD/z78yOJ9I+86jt2xTO3doxWYP+VpvbEX69PenkP9EJhLCkW92erWXqaxtBfVQ+5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhRzj5vDTUIe4MwalJVl3ZQNA5EEVdEfdMLqNCEXaXVYVMu0Kb
	9I6+YkiJTlp4BMfGkKiStrFDBeQpRJ+XtTPTXdb+A7JUFTUzA3LDeu23uIDBzCyU9caAHyd1u37
	zDRecffBIT5/a7YlvNYzMlPp7QPm5j2WpKNmFUch6qksGqbOeGXhThPyXPHR79w==
X-Gm-Gg: ASbGnct8MHvanXTFRb+wrPK+WZgykogRApN4lLetCsCwjlBFuEsp8GJnyuKMQfLHUQu
	2FMhhSc18/p5K8BnzNnGJwlfbmDaffjp7F9Qbm0rMdv1TzGUDWOov+oio3PaKe8pKdd7Jic4Puq
	8DDJ4sUyZyUsUtOz9wJv6YEzry3bn1pgDKV1t7JPieIKo4TNmX9O+/p8o1FW5EpUYZryiD+4U5g
	V1XqyKD8ezTwE1M1IjFkBTk8wEc8h9FaiXapba34IrOFLhmkHwkiy/kbsY5UZyHm6RR4rDmG6PZ
	7qjdCEUgOMz+asD1QzK1yMgjZaNVEOevWI55kh/UeagqmIITk6x5vQrjx2o3
X-Received: by 2002:a17:907:7ba8:b0:abf:6ec7:65e9 with SMTP id a640c23a62f3a-ac3f24d7921mr264856666b.43.1742554852923;
        Fri, 21 Mar 2025 04:00:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEUELeIFk2iV4bJhmhlsWZybhpWr1ETkAjOnrpXoDFpNR4vvFc6TbQxKArtqciFKT2yl++k2A==
X-Received: by 2002:a17:907:7ba8:b0:abf:6ec7:65e9 with SMTP id a640c23a62f3a-ac3f24d7921mr264852566b.43.1742554852498;
        Fri, 21 Mar 2025 04:00:52 -0700 (PDT)
Received: from [10.44.34.122] (5920ab7b.static.cust.trined.nl. [89.32.171.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3ef93e1bbsm129520966b.81.2025.03.21.04.00.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Mar 2025 04:00:52 -0700 (PDT)
From: Eelco Chaudron <echaudro@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 dev@openvswitch.org, linux-kernel@vger.kernel.org,
 Pravin B Shelar <pshelar@ovn.org>, Aaron Conole <aconole@redhat.com>
Subject: Re: [PATCH net-next] net: openvswitch: fix kernel-doc warnings in
 internal headers
Date: Fri, 21 Mar 2025 12:00:51 +0100
X-Mailer: MailMate (2.0r6239)
Message-ID: <1FAE19BE-E1F9-4836-9AF5-5EFB7FD291AD@redhat.com>
In-Reply-To: <20250320224431.252489-1-i.maximets@ovn.org>
References: <20250320224431.252489-1-i.maximets@ovn.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain



On 20 Mar 2025, at 23:42, Ilya Maximets wrote:

> Some field descriptions were missing, some were not very accurate.
> Not touching the uAPI header or .c files for now.
>
> Formatting of those comments isn't great in general, but at least
> they are not missing anything now.
>
> Before:
>   $ ./scripts/kernel-doc -none -Wall net/openvswitch/*.h 2>&1 | wc -l
>   16
>
> After:
>   $ ./scripts/kernel-doc -none -Wall net/openvswitch/*.h 2>&1 | wc -l
>   0
>
> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>

Thanks for taking the time to fix this. The changes look good to me.

Acked-by: Eelco Chaudron <echaudro@redhat.com>


