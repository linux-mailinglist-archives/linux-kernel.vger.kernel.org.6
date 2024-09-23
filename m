Return-Path: <linux-kernel+bounces-336124-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF91897EF79
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:46:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A0421C210F4
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 16:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62FDE19E969;
	Mon, 23 Sep 2024 16:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dyWla+mb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A258C1A
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727109979; cv=none; b=HnsMM9r4lQwbZretBmKlPht/7Cfe82hqsY/WWgKJcIrxcPJw8ivV7qTWMNY1z6ex0N43MB78cbMqHqcDGV0zVt9fYdQgIut+ATocTjGigFhMWCkh2FSe+uQ+2ZdstQ8+Lmrrxq0Uu+dbysgcBVfaCAy/l1AZSeshQJczmaNrbDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727109979; c=relaxed/simple;
	bh=CBaBcZjvSjE2uqo1qSHWS8BMthhUAEogThtkqQHzEvQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PazuxpfUFxOjbd6leSUToX4bE8WS0nm2WRWnj6BUHtXxcAVguLF2/S4mU01VjuPueDzBIUokMT0evyCVZxTYkZBWO5USZ/3ptr+boQwRuLL/pMpOHiDCEPhogHMFzd19RsrXAW8VtfftfLIi3ABVWBCPIcU4rF0kAi3rvYQ7sTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dyWla+mb; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727109977;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CBaBcZjvSjE2uqo1qSHWS8BMthhUAEogThtkqQHzEvQ=;
	b=dyWla+mbNpGE7HzOTD3N99WDMOXmRXo/jPwLD4uXvIrH4faoCfFDtQsDJYWY712I0675nw
	V9LI2H+Lc+kUrhwHIjx35e9wNzSxNZeMszXHU6FN/IUqTB/7q8xZZiib6MOoZUrGsFmw8f
	Ler7X1SzRIusJZKMqwmUZ1wdJbq4hKc=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-302-IZgI68ZaMqyNJDy0gvoX6g-1; Mon, 23 Sep 2024 12:46:16 -0400
X-MC-Unique: IZgI68ZaMqyNJDy0gvoX6g-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2f759688580so25969121fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 09:46:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727109974; x=1727714774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBaBcZjvSjE2uqo1qSHWS8BMthhUAEogThtkqQHzEvQ=;
        b=PM2IJcs1nU19pgTHD5VUIALAjx6Bvd9fsZ3nD5KpStSgdj/Zr4NNgaa7GWVhipxLR4
         OulBe5exwb2MPyr6Pfk5h3lfEgYVi9VMHuHCT+xY2rmR9GFZs2eFfaYkMATMzTerJ+th
         +5IuhUVQAX1q9u8j+/pM1BWta1IHG4RnfeMNrI738bDgDVtIOxbcz6iZoIyatXs6Vz+x
         D2wqChmXcXrYCA8r+nlMXGEz9mKHLwX0D/Q0XuW2z3yQJde0wdP2Hl7d87qdvqjsZPAe
         fXCMfQ2gbssS/JbvD4T+RXUyWncVjhaqvuth3p9C1JWpmkB6gFOjZPoFvoa0PoDTpjl0
         Ke6w==
X-Forwarded-Encrypted: i=1; AJvYcCU17acD7U86soq8DuoslVBPFc/AZabVypWnvXl1ZEX3ZlyQcGCPaTLN4ZjfZhZVJAQqxj1l5j1Xt5Kco6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxn8mA+nj+Ckph7jyjLetGtUrnCVPyXoaVW31fUmdtcdwbu6VmM
	EoodGf0+8iPMW3gSev648oNbyzsoDK/fF2wqD0b/JdXpu+4i5LUWcZq+yOddhTYNlBp7q8vXAOF
	T26SXwGrpUyQ9XcJ/yxymunBn+ghIw+zWiYt9C2qtISTtCfbjps3W7CW7P9T0CRakY3uRH7yAxK
	YlF5Drr5GFS9ZiiXl+xrWObUqtkLC1Edv+13Vr
X-Received: by 2002:a2e:824e:0:b0:2f6:6029:c63e with SMTP id 38308e7fff4ca-2f7cc375a2dmr47198611fa.23.1727109974354;
        Mon, 23 Sep 2024 09:46:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6qm7m3hWwtODGuDM1oa5WQCLNv0Y3IKoTB111Cx49PEhbpDmWp9BFnvuAJKnx3CHurDhFPWigvS/XiFS0BxM=
X-Received: by 2002:a2e:824e:0:b0:2f6:6029:c63e with SMTP id
 38308e7fff4ca-2f7cc375a2dmr47198471fa.23.1727109973965; Mon, 23 Sep 2024
 09:46:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240920185918.616302-1-wander@redhat.com> <20240920185918.616302-3-wander@redhat.com>
 <7e2c75bf-3ec5-4202-8b69-04fce763e948@molgen.mpg.de> <02076f9d-1158-4f3e-85cc-83ee4d41091e@intel.com>
In-Reply-To: <02076f9d-1158-4f3e-85cc-83ee4d41091e@intel.com>
From: Wander Lairson Costa <wander@redhat.com>
Date: Mon, 23 Sep 2024 13:46:03 -0300
Message-ID: <CAAq0SUkeVkiit383065nhfCibn-CG701uvaM6UHpWu9RaZE83g@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH 2/2] igbvf: remove unused spinlock
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Paul Menzel <pmenzel@molgen.mpg.de>, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 23, 2024 at 6:04=E2=80=AFAM Przemek Kitszel
<przemyslaw.kitszel@intel.com> wrote:
>
> On 9/21/24 14:52, Paul Menzel wrote:
> > Dear Wander,
> >
> >
> > Thank you for your patch.
> >
> > Am 20.09.24 um 20:59 schrieb Wander Lairson Costa:
> >> tx_queue_lock and stats_lock are declared and initialized, but never
> >> used. Remove them.
> >>
> >> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> >
> > It=E2=80=99d be great if you added a Fixes: tag.
>
> Alternatively you could split this series into two, and send this patch
> to iwl-next tree, without the fixes tag. For me this patch is just
> a cleanup, not a fix.
>
> >
>

Should I send a new version of the patches separately?

> [...]
>
> >
> > With that addressed:
> >
> > Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
> >
> >
> > Kind regards,
> >
> > Paul
>


