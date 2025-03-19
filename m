Return-Path: <linux-kernel+bounces-568037-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 562CCA68D43
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 13:57:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19D5C3B4CC7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Mar 2025 12:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6232561D0;
	Wed, 19 Mar 2025 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H7pu23bv"
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A92255E4E;
	Wed, 19 Mar 2025 12:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742389015; cv=none; b=kS2nGdRNyRAWMV1ko4CzOLu0q9Xyb3akDyBo2a5WV7pelkN2MYbKQcGslps8Taecx6HY2jcknf92vA2vIGS8OdcdxF3TkJozeHPgmx9GPEYt3g6hAb/xaVeDw4PkuJQpdxHHd/E0HeAWuTboniXdKTRhxcRJYApcK6xGWpxHB3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742389015; c=relaxed/simple;
	bh=rP5OqDL3fH4Cg8a+h2J+kDWfriTgr0IxmZYcqE/+s84=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b7gWyeCBCOMOzXmtXNBR9hezYGTgjkvT1dGwRhkiKF+oHIIFxMjdIBVk9a+JdQNebSS44euvizZY6wLAoqTDmkwwnfROzGyxBRQrKVPrGjeqq6lFnVNIrc9lXRsM00g08wmCP3XmOdSY/QMHUtlMv/6TOmgyP5dzddOoFwaA6qE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H7pu23bv; arc=none smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3f6ab1b8fc1so4028805b6e.0;
        Wed, 19 Mar 2025 05:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742389013; x=1742993813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JS++ktrb2/HykLlbcoAgHKVDVhWZ20hOobCegoXat3s=;
        b=H7pu23bvkkkxRYBKeugFsQ6DNYfPajsnaE8jhTN4K+wosw01TGMt/Q0ujXleKnJRI4
         un4Ro06JOyunZcmfywp+BMumAjRsHCIAwTzDIbnJ6Cs0vNdPLEI5YcmzttDLY9nG4qZ3
         AXtwK6TI2kRhe4B+DKapl3PNCV9O1WOIlhdWvj7+CuCNoOLpnVrm0rLL4/5hS+42rmZl
         dLGv/9jNfZJelBrE0S4Y15jijRp0oFvP1WAJzBi3YiIDh/m/mATOZH8jRrpihsCKtBlv
         OesbVMOLO2/fZfZ6MvBcRH8Om6FVfSfIcfowKRnfaHnfA4t/XM6JZe8yKQV3uzeCUKAH
         9zdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742389013; x=1742993813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JS++ktrb2/HykLlbcoAgHKVDVhWZ20hOobCegoXat3s=;
        b=fBZB25EPt9aYh1hG6E0y5NqWiU+Nq8EB4QpcwOxiSCtch2qbUntJmR0ahD/sb9HJ+4
         7ZdPUbYBR4rpeDyu4rX/hauiJtlc4WBU7M1B7BS+OVFPsvPC8PioPm2qlgDLTDuaVLpO
         ItiABDqzdgsk2zJJxTdGwZBn+X/77vNJMfI0ajGbTMIxruwBxhAZ/xLbqL9KuRXOdpQ+
         tPNV55KGnLDVYbz0gcPGmpWqWq07K7AWlE7U5kydN4I7hHiPV+52sRgPQ8AnVgW+7h4w
         ibYeOCuUkFCmZzcnJsgTlUSEXLI5QNIVEJEhc8ERDkvIJWqLh8TinggA45c1sh5PA1yC
         2rtg==
X-Forwarded-Encrypted: i=1; AJvYcCVdZsey+/Qg7yMEiwt81a6qBrRsxL8pX7YmB/tjrhJ8TWh8bmHYInNTieomHB7AqLV5BSl2cGFHKY5ofB8=@vger.kernel.org, AJvYcCWwVif69l9KN5r8UTnThf1UCQFaoJVI1QceEpX7vURacgxYe9tYBtVTd1XlZ7MWIuN9Vvc1qzYjNgqt@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5bkQVdDeudzPsF4ou+53MH7YOunFyTNjDGIraoIq5vYtp7Uw6
	lPZ3/E6uUwent+UsXjBmwBtUkZhctOQJvu3TGBm6W6v4m+EIKtdcFrRNAJbctjtyeDzQ0gGfq8g
	+gVvFNdRqZBgXwU9OS6UnpyjGpMg=
X-Gm-Gg: ASbGncvYZme0Ik/s4RtGsp9UvqU8TPEODq6nL9SEW15fHa/i5JJxJZ26cwc68S9KlNk
	vCXSW8po41eZ9m86eWJM7Ofzea/18G7uG7zdQvPUXNJen1NlmEzND4P2AeG7U27wwSxfiNUaXqa
	82L9lVyH1++cckBTwHQHqCZ5TJ/Rocm/n4EnfJHg==
X-Google-Smtp-Source: AGHT+IFF9SQTna3K6AFhrUaB1l2KAoa9AnC8ZS6CW+cEAO1pLAksDNvr8ULJLTv0u7Y0S0dwE6DhzXku8kRcFbjfrtQ=
X-Received: by 2002:a05:6808:1585:b0:3f9:a187:1f5d with SMTP id
 5614622812f47-3fead5ea449mr1843804b6e.35.1742389013497; Wed, 19 Mar 2025
 05:56:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250317222927.5b76518e@foxbook>
In-Reply-To: <20250317222927.5b76518e@foxbook>
From: Kuangyi Chiang <ki.chiang65@gmail.com>
Date: Wed, 19 Mar 2025 20:56:43 +0800
X-Gm-Features: AQ5f1JoD8NekiAN6LMoD1gcAH-XPaXA4CuWiAAbXL62OamY4aIhDdHgjpT3TutA
Message-ID: <CAHN5xi1RgkKQ2J8tJ5+hWUksMm1F9wU6Lx9p_VgqGwCp4812GA@mail.gmail.com>
Subject: Re: [PATCH] usb: xhci: Fix invalid pointer dereference in Etron workaround
To: Michal Pecio <michal.pecio@gmail.com>
Cc: Mathias Nyman <mathias.nyman@intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Michal Pecio <michal.pecio@gmail.com> =E6=96=BC 2025=E5=B9=B43=E6=9C=8818=
=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8A=E5=8D=885:29=E5=AF=AB=E9=81=93=EF=BC=
=9A
>
> This check is performed before prepare_transfer() and prepare_ring(), so
> enqueue can already point at the final link TRB of a segment. And indeed
> it will, some 0.4% of times this code is called.
>
> Then enqueue + 1 is an invalid pointer. It will crash the kernel right
> away or load some junk which may look like a link TRB and cause the real
> link TRB to be replaced with a NOOP. This wouldn't end well.

Ah, this could happen, my bad.

>
> Use a functionally equivalent test which doesn't dereference the pointer
> and always gives correct result.
>
> Something has crashed my machine twice in recent days while playing with
> an Etron HC, and a control transfer stress test ran for confirmation has
> just crashed it again. The same test passes with this patch applied.
>
> Fixes: 5e1c67abc930 ("xhci: Fix control transfer error on Etron xHCI host=
")
> Cc: stable@vger.kernel.org
> Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
> ---
>  drivers/usb/host/xhci-ring.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
> index 60d89cf418da..dc674bc24a89 100644
> --- a/drivers/usb/host/xhci-ring.c
> +++ b/drivers/usb/host/xhci-ring.c
> @@ -3786,7 +3786,7 @@ int xhci_queue_ctrl_tx(struct xhci_hcd *xhci, gfp_t=
 mem_flags,
>                  * enqueue a No Op TRB, this can prevent the Setup and Da=
ta Stage
>                  * TRB to be breaked by the Link TRB.
>                  */
> -               if (trb_is_link(ep_ring->enqueue + 1)) {
> +               if (last_trb_on_seg(ep_ring->enq_seg, ep_ring->enqueue + =
1)) {
>                         field =3D TRB_TYPE(TRB_TR_NOOP) | ep_ring->cycle_=
state;
>                         queue_trb(xhci, ep_ring, false, 0, 0,
>                                         TRB_INTR_TARGET(0), field);
> --
> 2.48.1

Reviewed-by: Kuangyi Chiang <ki.chiang65@gmail.com>

Thanks for the patch,
Kuangyi Chiang

