Return-Path: <linux-kernel+bounces-216746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61ADC90A5E8
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 08:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0776C1F21210
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jun 2024 06:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EDB1862A1;
	Mon, 17 Jun 2024 06:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DaerU64D"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CC854907
	for <linux-kernel@vger.kernel.org>; Mon, 17 Jun 2024 06:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718605940; cv=none; b=O6gyFLkMUWmsPxjRO6lm6u7+P/XVmXY+DZh/Czvxh4QzFw9rsJ96Ne1wYlYSJNhSYpqnnwL4ocjmh4SXTx64j1Tv7SbJ27iU5JDs/zg6FWrkv5WmuityYJc8CeROl/P0TcE4zTVYQvAujXaa4MytEo6Tc2BecKdURqe5deOETqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718605940; c=relaxed/simple;
	bh=KRrB/O5yQX8OPBbsQKrWwNIfyDnBh+PQCIyoFPES/Ko=;
	h=From:References:MIME-Version:In-Reply-To:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GD5w+64iDkzEs/zViaZq8vKkXDj7uvuvXrND8b2azUI4H7GP9LWLLHqvng2+wKj/SgZuTjlG1UjmuTknI0nR4WBvlZfE45suQpZ+AJpInOFX9Rka1pBx/WahAf05DmhHbgcm3NKf/ezg9elHZFxx95UIhf3KI77LkGfSkHnkWlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DaerU64D; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718605937;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KRrB/O5yQX8OPBbsQKrWwNIfyDnBh+PQCIyoFPES/Ko=;
	b=DaerU64Dpx/a3vwTJf4m2NaHzNwJwx4ZoZSBqrS0PDFkt+hgROc9m8I4I3tTrZCNBG9sLh
	3dVVtiktdo6XuJ3JwtMYD+BORYWQvC/NZT+ZiJcDh441sNgrm9bAFBo+mgh/9UIWvq2+dB
	kQCa3y4Qnn5sWnNq5sy+Bws+XyLnKnI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-M7z8YVvJPxG8txJTgxkKGg-1; Mon, 17 Jun 2024 02:32:16 -0400
X-MC-Unique: M7z8YVvJPxG8txJTgxkKGg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6b06f5e35b0so72931856d6.0
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jun 2024 23:32:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718605936; x=1719210736;
        h=cc:to:subject:message-id:date:in-reply-to:mime-version:references
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KRrB/O5yQX8OPBbsQKrWwNIfyDnBh+PQCIyoFPES/Ko=;
        b=LmNkJw3zKNO7OeUAZ0cHZpLYbgeT34ae98QruwDcbBalaD1WqFWP+zDvK2+Og7O5v5
         +a+3vJ+DafPakhExBniQrVP8i08WuAeSm8DXU2vD3BiZYKw09L7oCCdz7Bo7sp6T+TOY
         Hj82amu/VUSvBH8Yb+muX4FtDqbXFxlMgMrOy+/oQ6QcRrDwtqKQTmiAg/qSo2hgCnu0
         Y195Y+Xx5RmWzdQRaOMmlXMXK/YvAJpiXMdgIMTDEbxc7+fl87XeSrSDKc3QA0CdlkNg
         8OzdY1H/C5mg/WuNXMZKNJuVcEyFTqrBzA7jgGS1f0XThN+M96ZKwxjDphh0i0C5dJ4C
         B0fg==
X-Forwarded-Encrypted: i=1; AJvYcCWC0UmtfFx5NdJKOlw7+i/NeAYkd1+VIX8VePNJhbtTYLmvFI0k9JtbKCER4xx8I6AB1k+T7Qldj/8oSkjACLO6IEAeTBbqPMtRhttv
X-Gm-Message-State: AOJu0YzoDcVKLwZzhu6YPPcMBjqOCgw3wKEi07ZBcX/vHnHXondPO2A4
	sqt65SKcrTUZuSLyhBdOsMH7WmGTrJYiImJDxlYCyV0skOCLW6AQRv1+dBm323rQMOhqGERTiW9
	mM/9RCOnVX6FaiWymi+cc42Kh6Vqfl7rPIgFxUPjcPYUGXa6rxa30LA/HKUIx9KVKDPmCNKGLjB
	pOrNaWRZ/EVzeOnmk6djg2pIYPELlU7CvClXDs
X-Received: by 2002:a05:6214:293:b0:6b2:a47d:8f2d with SMTP id 6a1803df08f44-6b2af2ec799mr156801756d6.24.1718605935765;
        Sun, 16 Jun 2024 23:32:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4tB/FFUFsmnbNdE62HLufpIEZwTTCThxc9q8czc7ntVqJ47pkFtsTVqws9cwSgSrH5BSmFGqpzcbLP5qigvs=
X-Received: by 2002:a05:6214:293:b0:6b2:a47d:8f2d with SMTP id
 6a1803df08f44-6b2af2ec799mr156801426d6.24.1718605935299; Sun, 16 Jun 2024
 23:32:15 -0700 (PDT)
Received: from 311643009450 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 17 Jun 2024 06:32:14 +0000
From: =?UTF-8?Q?Adri=C3=A1n_Moreno?= <amorenoz@redhat.com>
References: <20240603185647.2310748-1-amorenoz@redhat.com> <20240603185647.2310748-5-amorenoz@redhat.com>
 <20240614161130.GP8447@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240614161130.GP8447@kernel.org>
Date: Mon, 17 Jun 2024 06:32:14 +0000
Message-ID: <CAG=2xmOhMMg8JDVi4x5P5F39yfG2p72kyYxDud0fcjc9VzDeLA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 4/9] net: psample: allow using rate as probability
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com, 
	i.maximets@ovn.org, dev@openvswitch.org, Yotam Gigi <yotam.gi@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, Jun 14, 2024 at 05:11:30PM GMT, Simon Horman wrote:
> On Mon, Jun 03, 2024 at 08:56:38PM +0200, Adrian Moreno wrote:
> > Although not explicitly documented in the psample module itself, the
> > definition of PSAMPLE_ATTR_SAMPLE_RATE seems inherited from act_sample.
> >
> > Quoting tc-sample(8):
> > "RATE of 100 will lead to an average of one sampled packet out of every
> > 100 observed."
> >
> > With this semantics, the rates that we can express with an unsigned
> > 32-bits number are very unevenly distributed and concentrated towards
> > "sampling few packets".
> > For example, we can express a probability of 2.32E-8% but we
> > cannot express anything between 100% and 50%.
> >
> > For sampling applications that are capable of sampling a decent
> > amount of packets, this sampling rate semantics is not very useful.
> >
> > Add a new flag to the uAPI that indicates that the sampling rate is
> > expressed in scaled probability, this is:
> > - 0 is 0% probability, no packets get sampled.
> > - U32_MAX is 100% probability, all packets get sampled.
> >
> > Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>
> Hi Adrian,
>
> Would it be possible to add appropriate documentation for
> rate - both the original ratio variant, and the new probability
> variant - somewhere?
>

Hi Simon, thanks for the suggestion. Would the uapi header be a good
place for such documentation?

> That aside, this looks good to me.
>
> ...
>


