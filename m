Return-Path: <linux-kernel+bounces-209181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 45001902E53
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 04:26:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE4341F216D1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 02:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E6B15ADAA;
	Tue, 11 Jun 2024 02:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="izBso0nU"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB9EC15AAC1
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 02:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718072807; cv=none; b=PrGw7oLG2w2tCjOcfBWo9utSAjykzxmhvb2P1vLT4mrPEYHxTBTHilx4UDTyPaFUdbyPvGq3vFc2FgPEV+/+EO1ZACpFq5TUQpAzP0LSTM1IAZ4vXqakvHQ48aT8YO5uPxsIs9mGQIIRCYSV1xOmcTBpA+r3C5EbIFpsGPgzrVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718072807; c=relaxed/simple;
	bh=1SjQU7XDrESMzGlE8GU2J8XuZ6lEmXSGB8C0miWDHFM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mA9FP8+Wpc2HykGwee26phaSx5uDf+mYknsK6eYS4wfAk0yCiAOQ9yobrsy3Son9Szdu2LWEUvQq0Omoer+dh4fzvE2hlycoU+2JDgjaKHCgZQnNvxdTynsRXyX4JNiUHneugO44r6m14nJRY20PawU1L0Z1SHMEhECEZRTCsb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=izBso0nU; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4216d9952d2so32185e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 19:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718072804; x=1718677604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SjQU7XDrESMzGlE8GU2J8XuZ6lEmXSGB8C0miWDHFM=;
        b=izBso0nU+S3wFnwV3S7US3+wI2ovpRs8fMAUGLCx8G01F1mE4ccsJb7rUHg6/peB2T
         6sUwrE307IopZjPr4SE7D3tfdnz1bWmCxrEv1P4Cj5qC/UdxBnYFOhnA/NVuUslzhRG5
         WOEydQnl0/lS20CfIW8FTKuWQ8apKpw7/p0r3XpQNGLuTEqjsjPzEQaWOupnzKdb+C/j
         6vjmnNj8d9lXe5nBbTq4mwoR0V64ntfyTXJkvkpx+oDjJObZthGIOg/U+0Xz5Xpzf9z9
         JDuXW1us022JbuD6w4WWRcx9KGCxVRysCXI8x5w+F66DD984ecCfMzwuAvKh0T00YlA2
         Ah/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718072804; x=1718677604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1SjQU7XDrESMzGlE8GU2J8XuZ6lEmXSGB8C0miWDHFM=;
        b=HQvcEffZO6KHKxG2qcshSBJwoScn/hfKSC3tUc34Do6PSUKWMEJ2rlI4SBa0AWQzB/
         SCs6IVkkLOgTRrkMZkAdQHTmN9MvX8z48wxdTFnK8gXjuJhBlWv7yATorYvXM3Tdbmk8
         06J/xSxtsF80EWfn9lfshxvFlV/vg45DJpa6PMaEYcJR+6LOj8nA4WFtWuw+wcbrIbFH
         v/RanoZ+z2irX4Zq5DMAbUxiCSlYBPgVuCUK9Kf1fWaRYkRVfyfvxSDPbrFKcCIZV9AQ
         LPWKbxsHVPM0ZUU5pI38UDKqMsAoCsJkP4X1oSvE09U/42zOWYPvcqQg7oKnvRKUJqQW
         ciFQ==
X-Forwarded-Encrypted: i=1; AJvYcCVuFrNKR8ezhDs7ErDxiRMHRHfHEU4FaHDqdgDYb2wCAqZWu2sJuLaR7TIpbpE5x5p5U2of2+sjZtGKOz8LFSLufCaMbvrjvj7GMBMT
X-Gm-Message-State: AOJu0YyqRDqx0U0j+N5HxwIwkEnHNDE9S0QHi3JGwnp2V1g6uDW4Tmf5
	ufM5aAPPgTrnBWdvAmLPuuRg27XQh5Am9F5bPJrooND0qiIooB4uX0jSi7pKjhgc6de6liFa75s
	ryWOMzcdkmX+fSH7fVT3Z24cBon8N5VCqLWKj
X-Google-Smtp-Source: AGHT+IEwOpUvdhG0m/MyGTks1/kGUd7I7XxowtIPTkFYilBU+DbYF7lNxvZksYVsfOaQc5P+IvU6HzPUSuX/+vmMsVs=
X-Received: by 2002:a05:600c:b93:b0:421:75af:e66f with SMTP id
 5b1f17b1804b1-42244b2c8bamr880375e9.2.1718072803818; Mon, 10 Jun 2024
 19:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240607060958.2789886-1-joshwash@google.com> <20240610225729.2985343-1-joshwash@google.com>
 <20240610172720.073d5912@kernel.org>
In-Reply-To: <20240610172720.073d5912@kernel.org>
From: Joshua Washington <joshwash@google.com>
Date: Mon, 10 Jun 2024 19:26:32 -0700
Message-ID: <CALuQH+UtX2xqDCghHqPBckzC4k-GGi58NmOd4FNfeqOr+C4jWw@mail.gmail.com>
Subject: Re: [PATCH net v3] gve: ignore nonrelevant GSO type bits when
 processing TSO headers
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, davem@davemloft.net, stable@kernel.org, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Willem de Bruijn <willemb@google.com>, Eric Dumazet <edumazet@google.com>, 
	Andrei Vagin <avagin@gmail.com>, Jeroen de Borst <jeroendb@google.com>, 
	Shailend Chand <shailend@google.com>, Paolo Abeni <pabeni@redhat.com>, 
	Rushil Gupta <rushilg@google.com>, Catherine Sullivan <csully@google.com>, Bailey Forrest <bcf@google.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

My apologies. I'll send an updated patch tomorrow without --in-reply-to.

On Mon, Jun 10, 2024 at 5:27=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Mon, 10 Jun 2024 15:57:18 -0700 joshwash@google.com wrote:
> > v2 - Remove unnecessary comments, remove line break between fixes tag
> > and signoffs.
> >
> > v3 - Add back unrelated empty line removal.
>
> Read the maintainer info again, please:
> https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
> we prefer no in-reply to postings.



--=20

Joshua Washington | Software Engineer | joshwash@google.com | (414) 366-442=
3

