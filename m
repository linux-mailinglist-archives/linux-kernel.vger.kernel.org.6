Return-Path: <linux-kernel+bounces-543445-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9006CA4D5A6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 09:04:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1D6D71888221
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 08:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C32501F8BC0;
	Tue,  4 Mar 2025 08:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HFhF0vwO"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9513233998
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:04:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075452; cv=none; b=KEFCMygWy5+X5/q8ax5qUC62+NnvVKulMo528lDpVKyoisDcPn7cL1lEjhCfCIVGvTJcRo7Vu2Fj7Cm8H9yP71ACBtXh4so8VX35IO2AOyzQY08wp596RK9XGSuJQMoWZmU2RnH6moPaedaqhFPcHx4M2j6x60U7XfA9pcVd+54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075452; c=relaxed/simple;
	bh=sAzTUkskqFANm/ZL5XzhKxmHu1rE7O5U8eewvrLoL4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=psmorQ+7gqdagwQTqaXY+BTXfjds6m3UckXOxgQ90LF6bGL8A1EfVTzPo/QvJiqhkH096eO9yMdgN6rIBM73M2iHk78Z8gaRZN5Sjb7NDQRqLJ+D8oJm4UDnxU9ucJ79U2mHaxDVTE+Yhc+bGeqsiR7QwjvmmuucP6cG4YMXGTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HFhF0vwO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741075449;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sAzTUkskqFANm/ZL5XzhKxmHu1rE7O5U8eewvrLoL4o=;
	b=HFhF0vwOPtC1lzxbAUIq0CFZEioOQWJNCrodRH/hoKW5aqO6Tf84XI7C9taoYwby/KHW/F
	n5ioChnl7EWh9gpc9EI0ZZHSvUj6DJry5mOzIhmdltaONSRI9ziP7Pq2DDh2u06OjjtT5d
	bpIDgdChh8SWQJKyS05CxjAdJw/KYE0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-CLAdtbMqNPqDgzo5flwpfQ-1; Tue, 04 Mar 2025 03:04:07 -0500
X-MC-Unique: CLAdtbMqNPqDgzo5flwpfQ-1
X-Mimecast-MFC-AGG-ID: CLAdtbMqNPqDgzo5flwpfQ_1741075447
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-ab397fff5a3so688212266b.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Mar 2025 00:04:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741075447; x=1741680247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAzTUkskqFANm/ZL5XzhKxmHu1rE7O5U8eewvrLoL4o=;
        b=bxRT/5uE4Nz3OFmQ7/KORiX1PusXUYwwVGXW4EYgEBbBoj+gjLmGs5ry0IyEz4vSaL
         dpw7/x+K7C2q92RH4mEGgA4V8IMO0ZuaiHp0fMjx4QLIxtBQbM5KU1U7T2NajhPN2M52
         yPwNE24tKOopcz+12DdBWa9XjLwPi7XH8TCXsghxbFUKw4wJ5uU4gmW7OazqbsIo3BW9
         U70GzasEPuwUMbKnE5Wnu2bZoR/2wp9zbWqkKKQ0d1wXjWxRIvsP8APBZBCy3WuDxOPY
         NkdcELrwJCwpwtkH9TQ3AYPwWSZZoJqd7trPF7VrO7N+CaLBV6M8ArdVhnYu4+ydY84j
         2oIg==
X-Forwarded-Encrypted: i=1; AJvYcCXwbS8Rm/zD/RXhHCVkhfCSh/DHRMDp0sKzicCNAXgseoecc+lGmeFCdbYJaUFWvx30HKYbFzWVie3yrPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRyd2UdeIjiGnQCVXz8agfkI5sh36z0wlI52NswA91T4JGhk/n
	9D7dDt/4MQ+lemqPELfxIhNhEV38yE5OBr54M+u3mMQxahjBMGE+mvlgI/ZZbERpMF1PNCaphC0
	2oRPEXPQ05SQi8yYYW9cJiZatOptUJhE/M3OMi5j7wW2v/4gOrM+80BGluw+E7H9nbgpx9sJZFM
	BFyqnu/1qr9xOpED3VQZFjaG/mGfYemzB2Vp9u
X-Gm-Gg: ASbGnctKWV6tGBBPX2IwcNFrlFUdI8Loo18SOuG0zvlDFm2OHrXn2ilaj/Jere9CJ7w
	Op685jXLAnGSM+zsaX6TPy9RhGBM+Ow2TXhV8tYrMY+Ry/QS2RMO1dvvqbgw6Yi6m7zDUe+u3
X-Received: by 2002:a17:906:f5a7:b0:abf:5778:f93e with SMTP id a640c23a62f3a-ac1f11e1e49mr196575366b.20.1741075446667;
        Tue, 04 Mar 2025 00:04:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMlvQhJSMa3o5MDPkih10cYTXXoBgWdsfMBlBzK4PZOMAtrxmS3ejEm6Rb9oGBns3LDIQ87ekx3ly/gV77Hao=
X-Received: by 2002:a17:906:f5a7:b0:abf:5778:f93e with SMTP id
 a640c23a62f3a-ac1f11e1e49mr196573466b.20.1741075446350; Tue, 04 Mar 2025
 00:04:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127170251.744751-1-costa.shul@redhat.com>
 <20250227200623.60f20571@gandalf.local.home> <CAP4=nvQXaFmemBeW8U3U9zTMK0gVYvp23gfq_6ALsBJPTXt9Uw@mail.gmail.com>
 <CADDUTFwyMt5zFqWeKXXiECOeqeyZ46fJcc4-ff=rjccsMDHKSQ@mail.gmail.com>
In-Reply-To: <CADDUTFwyMt5zFqWeKXXiECOeqeyZ46fJcc4-ff=rjccsMDHKSQ@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 4 Mar 2025 09:03:55 +0100
X-Gm-Features: AQ5f1Jp8s1Qa4Hjbj_2ILgoonOOrXdtSK1KX8J9VpSATDK0_36Dw6hYizV0UtBI
Message-ID: <CAP4=nvRtY+kEzxW9Lj2uSYZuFhuESbYs3yj0oq6resyuWVHjjQ@mail.gmail.com>
Subject: Re: [PATCH v1] rtla: Save trace when option `--trace` is specified
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 3. 3. 2025 v 16:55 odes=C3=ADlatel Costa Shulyupin <costa.shul@redhat.co=
m> napsal:
>
> Actually trace collection can be performed using just trace-cmd start,
> trace-cmd stop, and trace-cmd extract.
>

Yes, but that does not necessarily mean we cannot add it to rtla, too;
we already do that e.g. for event histograms, which you could also
replace with trace-cmd. It has the benefit of synchronizing the
start/stop of the trace collection with the osnoise/timerlat tracer.

Tomas


