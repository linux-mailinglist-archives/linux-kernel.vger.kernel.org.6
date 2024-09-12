Return-Path: <linux-kernel+bounces-327048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D88897702F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 20:14:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 803151C21BD8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2024 18:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25B991BF81D;
	Thu, 12 Sep 2024 18:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b="TtrXhOo3"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E251A156F44
	for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726164842; cv=none; b=e86C0zrrCq2N4/mBkeKngr4VJlrhisD3lH5DGUs2PmC3Ksj+VDQlyuEROIunqHD4UlwwhZcApdneWSmFGw16BkNFNzA7ievuWrbh+THGY0nuq9DiH84+u1HRpFRRlxdOzLFG9xuNcdqZ7L4lOWlKAw8EM4LFpThbnmZbNbcwYtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726164842; c=relaxed/simple;
	bh=fdpCU+YyvgCSDSVeREV+L9RKobSp5F+iDyQvOOsJLcM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VH/QUIXd/lrnCcj4Dq7/8SXuiYfnt8dhmeYImggzRGhxm95ADyq681bgjtGL1W5E28qUdoCP6ZjTi+vXgGZYvIBt02lnmr40B3FdPDMff+KZ91X0o3Uuw4rKLcMLbjl96Py2jl3wo9ELOXb3ZW3Zu/NeVcEHwNTciMYIZM5mUbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com; spf=pass smtp.mailfrom=fastly.com; dkim=pass (1024-bit key) header.d=fastly.com header.i=@fastly.com header.b=TtrXhOo3; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fastly.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastly.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2f77be8ffecso15672911fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Sep 2024 11:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1726164839; x=1726769639; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=epRzpdGMMw2gAPymSIGzQUTWoaWQrSuwK9G/di8knkI=;
        b=TtrXhOo3teY1dxpJVBLqWVAS27g/Su8km2Ntj11hyeBnvLHs4ClD+2pI4fjUuyYxdZ
         +r4AYsK3VPmQxoYTdo3zolQu/bxtMwg93HfiKeyDA1970sp50Vl6yev1FUlTTIySMnro
         uu8d+eDvnKFpYoyJRDmGxLTi29hRaj9F3P630=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726164839; x=1726769639;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=epRzpdGMMw2gAPymSIGzQUTWoaWQrSuwK9G/di8knkI=;
        b=HsGbg7IV0jUkJ0ktOVIwAV3QFbXk2S/NC6nWLrmcWf9hk9182V8smpPd1Ka5iUTYb6
         E4ogL8Jgc7AysXjh7NS3RffftEulKhsTTRTX951ZirJknpwQUv93+/Jn5UNxDQfIYWTE
         ZPBLriLEs6nICCRbabfQkkUc3f6mEPTxcP/KsqculNkqZKVIZ4U3Rv5xeHY2hrdwdgDs
         uC1C6JbSPXtYgKAxqY4hogJ3p9fQROfGoWCPOb5rlTSbkQb37I1+rJfO6AuVLBD9dFOZ
         rYarbQ9jmRtAS0Sl6vUmhrdedF8UXXK7W7EtkhmUTGn7YWgcA2t8Kj5Uz+JVXyuT4CGw
         HoAA==
X-Forwarded-Encrypted: i=1; AJvYcCUucKMVGV7EqmhfyxQzGIkW01+X++rg10DhNTvresq8gBGMTobw9kPprVPj5umACuhP59VuUm+eU1Y8HU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyylWHAuhUA0QLKksaVQmNyb3Pk9hkqW7qL+3JFjzFBV0itm3ww
	HBKE9xNeUqpXGS69DkgcLF5SNo+ZS8YqsLKMKOMUarYc/2FSJTZmSY6hWc31XrQ=
X-Google-Smtp-Source: AGHT+IGlaXcWL6q+hkJae3s/jYwseEFn0HziOG9Qk04yVzZqLiRLFOVMz1Ka5wsVpSlVqYvPjKuSKg==
X-Received: by 2002:a05:6512:3c9c:b0:52c:e3bd:c708 with SMTP id 2adb3069b0e04-53678fab54amr2222970e87.10.1726164838147;
        Thu, 12 Sep 2024 11:13:58 -0700 (PDT)
Received: from LQ3V64L9R2.homenet.telecomitalia.it (host-79-23-194-51.retail.telecomitalia.it. [79.23.194.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25c72ed3sm776374366b.135.2024.09.12.11.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Sep 2024 11:13:57 -0700 (PDT)
Date: Thu, 12 Sep 2024 20:13:55 +0200
From: Joe Damato <jdamato@fastly.com>
To: Michael Chan <michael.chan@broadcom.com>
Cc: netdev@vger.kernel.org, Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next] tg3: Link IRQs to NAPI instances
Message-ID: <ZuMvY6_MolZYMT9m@LQ3V64L9R2.homenet.telecomitalia.it>
Mail-Followup-To: Joe Damato <jdamato@fastly.com>,
	Michael Chan <michael.chan@broadcom.com>, netdev@vger.kernel.org,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>
References: <20240912155830.14688-1-jdamato@fastly.com>
 <CACKFLimO60wNu3VggJ+cs9K2SBfMBtATCFxZ+3J1Hy3dbfLOCg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACKFLimO60wNu3VggJ+cs9K2SBfMBtATCFxZ+3J1Hy3dbfLOCg@mail.gmail.com>

On Thu, Sep 12, 2024 at 11:04:02AM -0700, Michael Chan wrote:
> On Thu, Sep 12, 2024 at 8:58 AM Joe Damato <jdamato@fastly.com> wrote:
> >
> > Link IRQs to NAPI instances with netif_napi_set_irq. This information
> > can be queried with the netdev-genl API.
> >
> > Compare the output of /proc/interrupts for my tg3 device with the output of
> > netdev-genl after applying this patch:
> >
> > $ cat /proc/interrupts | grep eth0 | cut -f1 --delimiter=':'
> >  331
> >  332
> >  333
> >  334
> >  335
> >
> > $ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
> >                          --dump napi-get --json='{"ifindex": 2}'
> >
> > [{'id': 149, 'ifindex': 2, 'irq': 335},
> >  {'id': 148, 'ifindex': 2, 'irq': 334},
> >  {'id': 147, 'ifindex': 2, 'irq': 333},
> >  {'id': 146, 'ifindex': 2, 'irq': 332},
> >  {'id': 145, 'ifindex': 2, 'irq': 331}]
> >
> > Signed-off-by: Joe Damato <jdamato@fastly.com>
> > ---
> >  drivers/net/ethernet/broadcom/tg3.c | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
> > index 378815917741..c187b13ab3e6 100644
> > --- a/drivers/net/ethernet/broadcom/tg3.c
> > +++ b/drivers/net/ethernet/broadcom/tg3.c
> > @@ -7393,6 +7393,14 @@ static int tg3_poll(struct napi_struct *napi, int budget)
> >         return work_done;
> >  }
> >
> > +static void tg3_napi_set_irq(struct tg3 *tp)
> > +{
> > +       int i;
> > +
> > +       for (i = 0; i < tp->irq_cnt; i++)
> > +               netif_napi_set_irq(&tp->napi[i].napi, tp->napi[i].irq_vec);
> 
> Looks good, but why not just add netif_napi_set_irq() to the existing
> loop in tg3_napi_init()?  It will reduce the lines of code a bit.
> Thanks.

I made a separate function because:
  - tg3_napi_init would need two calls (once for i=0, and once in
    the loop), and
  - tg3_napi_init and tg3_napi_enable are separated in the driver,
    so I figured I'd separate the IRQ linking, too.

Can you let me know if you want me to submit a v2 which modifies
tg3_napi_init instead?

