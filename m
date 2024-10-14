Return-Path: <linux-kernel+bounces-363393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C8E99C1BD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 09:43:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 176841F21CBA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Oct 2024 07:43:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BC6414A624;
	Mon, 14 Oct 2024 07:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MenY87zb"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22F74204E
	for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 07:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728891790; cv=none; b=dbpQYAGesisO1ynnUq2hluyzaHHuzwCBuW6LTvRachZVF1KE2IJqZqbbTnQLnt4QeM0Hkd7ZyxSUrnGyDj5FKEUevdf6nrgVn1Lt4eLDfFyrv5/iKpVPCxP2iNgCiD7yx4wPNf9AxftDQMoX7bqT5wu79/XZjdBnq9g1Qf5GDfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728891790; c=relaxed/simple;
	bh=+g4VLx1y4rTCco0Bfo9tUTjB1bWOGr7+O8v5/Po4yFI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t8jG6p4Yp5JV4gaMYqwfY3gYg+N4nu6pvxPyb2rbI+X+s9TUdmfpzVsyFCeUG0vYBQqKX5hY16usvOL5mGnOmkghqWSAutnBBSYjEfpFzRspAzjceHkO+1JA+dlr1sugxn7xt7bO9cg8OcecW8uBFo+PJR5K48g67gfLp94IRwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MenY87zb; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c94b0b466cso3128467a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Oct 2024 00:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728891787; x=1729496587; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+g4VLx1y4rTCco0Bfo9tUTjB1bWOGr7+O8v5/Po4yFI=;
        b=MenY87zbE+9/Lzev8kzG8MK2Eg8qcJo8KggwiwBVxNE+lBZRMzVl8XXo0lYjljjzFV
         5Hbdl1jGm8PafLx4YgRTaDXd+jNqhfIbnL9pEvu+K1kLPPbXN9LILfpq24ED2Dk+p3JJ
         PDJpVhghI5le2mx8HsosEIKyA01bj8tFrhTVaKbXUsNnLIZCSkdUAKMR6g8oPgMSMFW9
         AwQ52yEUXIwmiG2Jh5uPnfZtmYBTzC+ObsQLMVhMsFZCeGhPL1w9HQMk448glRhcQojq
         73TY6/bFfX2zHSC5+eKqeTLLHj8qMV1gZQedaqTpJ/D1hTxFiyeGfemZ6zL0g0/8EyQV
         4tyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728891787; x=1729496587;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+g4VLx1y4rTCco0Bfo9tUTjB1bWOGr7+O8v5/Po4yFI=;
        b=gdbkGWwVORsgB2ObV14whO9NUK2EWyJIR3zMPyogffPVEq/6nWqRY8NeALGGD7Z+/v
         WLWK08YY7N49jMUSLGRzr/H8cJMKNsYwe8UQft29wZ+jccyW2IFVLi+W92MKUkxG4vm4
         iUBygEOKFR/2PKmHf7ml0WNGuMck17giNWruVxON6sKDiZviLqWOBf4mVNUSIpZeKRs9
         /LkaiGF8lXDxKFY4qMllxbvwbFQxa24Gi39t2G/HhtXYOlgfL4Q0JevHnjzvcDI7sdcB
         TQhBKnxxmKJjrRt1q7J64Sjkf1cd/GBV/m9uMfIj/qbNoyBLNdIq2USMvcm2zSmTtaHr
         nTbA==
X-Forwarded-Encrypted: i=1; AJvYcCUX5Fk51UDaFWzK9YSWbsxcobMCphvJHTkV4aMCqVfzj7NXzPAPcugaGC0E9TFu4WIHxUReySks4JUBESU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtQJuHrDoMkNG2UDs22RYvKGXeN3pvpdevlDGzr+8+TG4G+lSd
	IERI6qNbUTCuYoYXS7w15Hr0DvQutvres8OCh7dzHbwX2PVsWXAMBrt5KR+3JMSIxQHuTYVE5FK
	BgUX65fbpNmNLntrYj+HPA8in9bKKw8Km4tZO
X-Google-Smtp-Source: AGHT+IGuvZMzRXCYECsuw+x8VNowD+t14ByUWke3daYyYrET2tmW9vNZChsIu54ZzwxoPl2kRhOna6EkqNPhh/X4rjI=
X-Received: by 2002:a17:907:1b96:b0:a99:d3f4:ff3b with SMTP id
 a640c23a62f3a-a99d3f5095emr550405766b.27.1728891786788; Mon, 14 Oct 2024
 00:43:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241013201704.49576-1-Julia.Lawall@inria.fr> <20241013201704.49576-4-Julia.Lawall@inria.fr>
In-Reply-To: <20241013201704.49576-4-Julia.Lawall@inria.fr>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 14 Oct 2024 09:42:55 +0200
Message-ID: <CANn89i+qkK7NvsJMiV1wWhbUajJCbtTeDLPB8TH1DsQAJk4pOg@mail.gmail.com>
Subject: Re: [PATCH 03/17] inetpeer: replace call_rcu by kfree_rcu for simple
 kmem_cache_free callback
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: "David S. Miller" <davem@davemloft.net>, kernel-janitors@vger.kernel.org, vbabka@suse.cz, 
	paulmck@kernel.org, David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 13, 2024 at 10:18=E2=80=AFPM Julia Lawall <Julia.Lawall@inria.f=
r> wrote:
>
> Since SLOB was removed and since
> commit 6c6c47b063b5 ("mm, slab: call kvfree_rcu_barrier() from kmem_cache=
_destroy()"),
> it is not necessary to use call_rcu when the callback only performs
> kmem_cache_free. Use kfree_rcu() directly.
>
> The changes were made using Coccinelle.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Reviewed-by: Eric Dumazet <edumazet@google.com>

