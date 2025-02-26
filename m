Return-Path: <linux-kernel+bounces-535044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C263A46E23
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 23:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 506293AF85D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 22:06:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEA026E63E;
	Wed, 26 Feb 2025 22:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFOTIqiQ"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD13A26A1A1;
	Wed, 26 Feb 2025 22:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740607510; cv=none; b=mxvvE+66FFY1D3UKXdXh33V6abvoP5DWlBANby9ZkYKZ3UdPIGzgy5EFey1f6x2e+XikRc9Rn9b8RC7+uynsV1JcxVlSnPpPYqn07PRbM1UajP5fg1reP0kNbkLtOxSashIPEVukb0nPLBo96KS0A8jn10/4+JqDyZvpIBzFFu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740607510; c=relaxed/simple;
	bh=8tgf2Niq60tnIQ2wQGQSd+VgbYKSeD7iRUGJCScR4qk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LmCOSdR9CZ0E6xg//8WP4PdeoM3Gs4E6YHtTyQQoL0XRpH4aHrBaWNKDClK4E0xmDJyK2ZXgwWMitO5l3Ux7iWKaYchjEy1dIPYSuhGf1vUAH6c8sHBue9gWhiWaM39R4L+ZPgSxi4HdPDgydAp6+nFpAiIyabSSNUBDXUz+4N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RFOTIqiQ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-abb81285d33so53398066b.0;
        Wed, 26 Feb 2025 14:05:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740607507; x=1741212307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FymIR0DqOsm5IY1L57Sd016sY7sVjga5Jh/Vx8PavZg=;
        b=RFOTIqiQ1Om0qyz24/sKWU/F2ZEF+pSqu7bJz6H7r5XybwxDStDrFsmoE9eCw2MQM6
         Kj9jlEwzvHmyY1w+alRpbgXL2IxIKt9bbrzJhxvXFsH8aJSwAEuL10d9jvvOpu8Fr+wS
         8b1NRgT4zHiRd4vQAlT4kyheMT+Ua7lWrloguy+5LVGQE0nSZl7ivoM5pvqRqgXzJioc
         4AJcbXnt3mEeTirBhc2w/7hVA697hhd0TYw58K3BkSY0ASFSKoO3hDCJuyc9RuLnpnie
         M7QgoCYVoehn3ebsi1vGtDU9jXFu9KXYki6aAvgmHFYl4jwwMNvA1qLXimj4ETIR++QX
         vdcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740607507; x=1741212307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FymIR0DqOsm5IY1L57Sd016sY7sVjga5Jh/Vx8PavZg=;
        b=uBfQLq/y0VbFVonSqrpgnLAxILrtr/bsfvCgIAxHG7Qfx2YmTq2ScQeRjjYGoup1ZV
         2NvxslN9hu6gZFhN9Q1G7M95GdEw4MbtusmBpZbbctkGvWAhNniuUQEfTVSIO2ZaARUo
         wSXA5++ltMt+OXCn5DcXygYvhl84DEALffhGuJPHGPyA9n31n+fKvf8AZ/p2IwPMQH9W
         vYv1Pv4HoidNssqv26iUJ4PPXLmvcZhCX3Qv3c0vYfD7V7nIUobVr8tCEny9yYPa4ZI/
         uSfe5qbPcPFR3SrYXDtvJI/IEA2fC1RbPyiI/A35cDMurHaeBK3xYggYmvbKqbnKsSGR
         vTHg==
X-Forwarded-Encrypted: i=1; AJvYcCW/gxqUcxpkCxB+rO09TpccNnhGR8AzYr6xTTLWYOgkydpGItkKNtK5Omo9rySQjBYKUD508wetYbmO@vger.kernel.org, AJvYcCWkUojgppJFK+GhFeOttw6cVUNTXE+ktZOW5vVr+93kfNrdbTCuyTcjirbnF98BEPU8PG17CSGNwLZYhOs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxpF1b9j+sw1msGvncaVfU/c+VyoghydMbo7DGY7Nsr8ZYgs7G
	6nn2Ar5nPZf6loaRHlyWr8V+DLHRRB1RKWrE9l6vutCNtdtvehUw
X-Gm-Gg: ASbGncvE9ZmJnWwbCcGwRu8YC9VvCKXwS9mL5LAwLpyaa1gG59IcsBsrj8X9kOKcTH8
	pvYuweMaesIEVu5HHDI5t2Jov4SwVbVyv1ZUzWDo8ZW38yU9kKxMm/AuiIpTAme0J+qfsx1ATeT
	+tjp9Opeyi54FwtWSnSWI9ZgkQaRD5p9SsDK7OGPj/cmjcSO9ZMpK/PFKbBkdlEVRLD1j1AyHAI
	mfAvZxeglDj/fl3PEruOr7igFbofaVsuxz+sAhYPRgC7dFUY868FdcH/tJL6/G5Q9BHOkHqOSr9
	NKhih9COQzB8JTWBicrgPgiY5tX+PwLXO0Vb2t+i
X-Google-Smtp-Source: AGHT+IHiKeI6hS01NjB4p0NKtpiH+xwIk+lvhqsp1fkSdnXg0QQl60fhpqlB9yu3KsEP6AdImOcgRA==
X-Received: by 2002:a17:907:8e93:b0:abe:d140:ba55 with SMTP id a640c23a62f3a-abed140d038mr807921866b.28.1740607506595;
        Wed, 26 Feb 2025 14:05:06 -0800 (PST)
Received: from foxbook (adqi59.neoplus.adsl.tpnet.pl. [79.185.142.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c0dd713sm11975366b.60.2025.02.26.14.05.05
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 26 Feb 2025 14:05:06 -0800 (PST)
Date: Wed, 26 Feb 2025 23:05:01 +0100
From: =?UTF-8?B?TWljaGHFgg==?= Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Niklas Neronin
 <niklas.neronin@linux.intel.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/5] xHCI: Isochronous error handling fixes and
 improvements
Message-ID: <20250226230501.48e8b23a@foxbook>
In-Reply-To: <8bf4212a-72af-4c5d-a9b2-f3363d3ee3cd@linux.intel.com>
References: <20250226080202.7eb5e142@foxbook>
	<8bf4212a-72af-4c5d-a9b2-f3363d3ee3cd@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 14:41:44 +0200, Mathias Nyman wrote:
> Updated my for-usb-next branch to this v3 version


A few remarks regarding "Add helper to find trb from its dma address":

xhci_dma_to_trb():
This function could use xhci_for_each_ring_seg.
The use of in_range() perhaps deserves a comment, because its
correctness is not as obvious as it might seem.

Long story short, my own version:

/*
 * Look up a TRB on the ring by its DMA address, return NULL if not found.
 * Start from deq_seg to optimize for event handling use.
 *
 * Note: false positive is possible if dma < TRB_SEGMENT_SIZE *and*
 * seg->dma > (dma_addr_t) 0 - TRB_SEGMENT_SIZE, but that shouldn't
 * happen if seg->dma is an allocation of size TRB_SEGMENT_SIZE.
 */
static union xhci_trb *xhci_dma_to_trb(struct xhci_ring *ring, dma_addr_t dma)
{
       struct xhci_segment *seg;

       xhci_for_each_ring_seg(ring->deq_seg, seg)
               if (in_range(dma, seg->dma, TRB_SEGMENT_SIZE))
                       return seg->trbs + (dma - seg->dma) / sizeof(seg->trbs[0]);

       return NULL;
}

>+       struct xhci_td *matched_td;

This variable is only used as bool so it could be declared as such.
Other places still use 'td' and assume that it equals 'matched_td'.
And that's OK because there is no need for iterating further after
the matching TD is found.

>+       /* find the transfer trb this events points to */
>+       if (ep_trb_dma)
>+               ep_trb = xhci_dma_to_trb(ep_ring, ep_trb_dma);

This may deserve a dedicated warning. It's a pathology. Either the
event is bogus due to internal corruption in the HC, or it's executing
TRBs from a wrong ring due to damaged/ignored Link TRB or bad Set Deq.
Or we completely screwed up and are looking at a wrong ep_ring here.

>-       if (trb_comp_code == COMP_MISSED_SERVICE_ERROR && !ep_trb_dma)
>+       if (trb_comp_code == COMP_MISSED_SERVICE_ERROR && !ep_trb)
>                return 0;

Good idea. I think I would go further and refuse to handle anything
when (ep_trb_dma && !ep_trb). Nothing is going to match, nothing good
will come from trying as far as I see.

But that's a behavior change, so maybe material for a separate patch.

>+               matched_td = NULL;
> 
>                /* Is this a TRB in the currently executing TD? */
>-               ep_seg = trb_in_td(xhci, td, ep_trb_dma, false);
>+               if (trb_in_td(xhci, td, ep_trb_dma, false))
>+                       matched_td = td;

If 'matched_td' is declared as bool, this will become simply:

matched_td = trb_in_td(xhci, td, ep_trb_dma, false);

Regards,
Michal

