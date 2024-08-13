Return-Path: <linux-kernel+bounces-285541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4246950F3F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 23:45:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734A128480B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2024 21:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2BE61AAE10;
	Tue, 13 Aug 2024 21:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="PurZK8Cz"
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECEA17B515
	for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 21:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723585491; cv=none; b=T5ydLUgEEyoQnP52lXaJcLQZNhWp0Do6nK1Bd/KIGLp+9EiTbClvyLPr2IW1jBMXB8sWSNZc/bJxLS8FN46bsuM4MMHZ2MzCO9fyjr/n1wf/FPDxak2LCJmeLlYjmVKAsgBbNs4C6gB9xSmkpmUe0c3fONQY6hSFvjSZFepPUSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723585491; c=relaxed/simple;
	bh=hEZOP+vgSIIz1iVA2wI6/fd5wbCXlwuASEVB615sMFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhtETXuuavkPp4jMx0MEG7jVG7XqKYRUMA52xPSUK6w7Ohw5qI4og3/UysxOUKh7Uvny4ivRvHP6fEl/qXVoeH0nku1ptJH4owv9VmNYgfxL6MFELQZmotRplA1gujaMiY5XEYSHmczgkCbEMQynaf9M7KsGlfVUVngCBqK4O7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=PurZK8Cz; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3684407b2deso3231563f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 13 Aug 2024 14:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1723585487; x=1724190287; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N0GCzpkrF2/Eqvtb446uvQll+YHxL+4f8Ry723ecows=;
        b=PurZK8CzYkiP6cHrWwSSlhIIctL624lh6pSkZqoBpf+2vw+ezW+d6BkYPoTEw4F/Ox
         vBdClBJMtqtQTCVqTG0kdtwSmy+jGo2NktqqYJ5SFUm1Qo6QdBly/L54apHYRZA66UCz
         7jnvlZXg8zF8ZgEkTPwdERE+XuhPdS3Vj9AOM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723585487; x=1724190287;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=N0GCzpkrF2/Eqvtb446uvQll+YHxL+4f8Ry723ecows=;
        b=jQdqIeq5WiwQM4XPOOOuIUBvyJf2zP+QIREoJZ9WmDeN3+mpa6QsVre+nsRAfJ94Xq
         Sh0/8ZArG7BzJKDnq9i0QH3L6A0QEIYWFrF8E9PUzYKH++eW7CObDGEe8qeL0JlGhQbY
         GYYRtfzIZqy46DIaKe0g+kdc+FlAO+O7zEGC4pEd+db4XHBAFHAo9h9L089qAnAXHQdW
         dJtJ9y6FBdKXB3fsaS2/PecFY49NJVosMBqHa7Lqo7GUfrLA8peqsy1M9qKgvVeOjCWW
         hAV38Qe0pb6kHV4e5aOvMM7ZlL1gCe3LfErdk0OeLtX+jG7GZx7i3QLWovMpMgmmsmei
         z14Q==
X-Forwarded-Encrypted: i=1; AJvYcCWbkJ+z9p2Ucaus2RemNDlPgP+1pqYQQHun4QF9jC/GSIOn59W+jc6RKA/iVmfMUWzRTw9IA3tqS7yUejHEo75V3DpfIH13V0Jbnhzw
X-Gm-Message-State: AOJu0YxeZ112B21rIc73WgQBdkVv/OhxB+9+rajZP/07qnZYSoKDKz91
	Fz1nwvH1wxx1EPAKLLJcSwah/zQgSAUv0zBQKAbK8T23NAC7eDMARbWk9A8oLWU=
X-Google-Smtp-Source: AGHT+IHD9XHV2aa9kZQekAPa47qm/fCrhVrC6mB8/U1PKYvLzVUMBb1baRzVyxcHAI2b1wNLbHARVg==
X-Received: by 2002:a5d:5228:0:b0:368:460b:4f8e with SMTP id ffacd0b85a97d-3717775cd8dmr670291f8f.13.1723585487346;
        Tue, 13 Aug 2024 14:44:47 -0700 (PDT)
Received: from LQ3V64L9R2.home ([2a02:c7c:f016:fc00:7516:6986:2fe8:5b8f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4e51ebe4sm11361650f8f.85.2024.08.13.14.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 14:44:46 -0700 (PDT)
Date: Tue, 13 Aug 2024 22:44:45 +0100
From: Joe Damato <jdamato@fastly.com>
To: Shailend Chand <shailend@google.com>
Cc: netdev@vger.kernel.org, Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [RFC net-next 3/6] gve: Use napi_affinity_no_change
Message-ID: <ZrvTzX8CfyM40c8I@LQ3V64L9R2.home>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Shailend Chand <shailend@google.com>, netdev@vger.kernel.org,
	Jeroen de Borst <jeroendb@google.com>,
	Praveen Kaligineedi <pkaligineedi@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	Ziwei Xiao <ziweixiao@google.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240812145633.52911-1-jdamato@fastly.com>
 <20240812145633.52911-4-jdamato@fastly.com>
 <CANLc=av2PUaXQ5KVPQGppOdD5neHUtUgioqOO4fA=+Qb594Z4w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANLc=av2PUaXQ5KVPQGppOdD5neHUtUgioqOO4fA=+Qb594Z4w@mail.gmail.com>

On Tue, Aug 13, 2024 at 11:55:31AM -0700, Shailend Chand wrote:
> On Mon, Aug 12, 2024 at 7:57 AM Joe Damato <jdamato@fastly.com> wrote:
> >
> > Use napi_affinity_no_change instead of gve's internal implementation,
> > simplifying and centralizing the logic.
> >
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >  drivers/net/ethernet/google/gve/gve_main.c | 14 +-------------
> >  1 file changed, 1 insertion(+), 13 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> > index 661566db68c8..ad5e85b8c6a5 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
> > @@ -298,18 +298,6 @@ static irqreturn_t gve_intr_dqo(int irq, void *arg)
> >         return IRQ_HANDLED;
> >  }
> >
> > -static int gve_is_napi_on_home_cpu(struct gve_priv *priv, u32 irq)
> > -{
> > -       int cpu_curr = smp_processor_id();
> > -       const struct cpumask *aff_mask;
> > -
> > -       aff_mask = irq_get_effective_affinity_mask(irq);
> > -       if (unlikely(!aff_mask))
> > -               return 1;
> > -
> > -       return cpumask_test_cpu(cpu_curr, aff_mask);
> > -}
> > -
> >  int gve_napi_poll(struct napi_struct *napi, int budget)
> >  {
> >         struct gve_notify_block *block;
> > @@ -383,7 +371,7 @@ int gve_napi_poll_dqo(struct napi_struct *napi, int budget)
> >                 /* Reschedule by returning budget only if already on the correct
> >                  * cpu.
> >                  */
> > -               if (likely(gve_is_napi_on_home_cpu(priv, block->irq)))
> > +               if (likely(napi_affinity_no_change(block->irq)))
> 
> Nice to centralize this code! Evolving this to cache the affinity mask
> like the other drivers would probably also require a means to update
> the cache when the affinity changes.

Thanks for taking a look.

The gve driver already calls irq_get_effective_affinity_mask in the
hot path, so I'm planning on submitting a rfcv2 which will do this:

-               if (likely(gve_is_napi_on_home_cpu(priv, block->irq)))
+               const struct cpumask *aff_mask =
+                       irq_get_effective_affinity_mask(block->irq);
+
+               if (likely(napi_affinity_no_change(aff_mask)))
                        return budget;

with a change like that there'd be no behavioral change to gve since
it didn't cache before and still won't be caching after this change.

I think a change can be made to gve in a separate patch set to
support caching the affinity mask and does not need to be included
with this change.

What do you think?

