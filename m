Return-Path: <linux-kernel+bounces-575473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C99F0A7030B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 15:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45FA21887E90
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Mar 2025 13:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF2D72571CB;
	Tue, 25 Mar 2025 13:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="RWtBZ5fp"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615CE256C75
	for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 13:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742910851; cv=none; b=P+7+RT9ELavlbDLIARkCS1f6XAeKE5M26rcOnSkhkC2Enu2pA72VMxB5eBN1Y2DXkJyVgwzz88CBJ8keYlQ9oLfLHy4qZrV6lRGyO/P0JOHfoZ8gyKmREnGrmv1/btel0hRCuCOo0Ux8bw/INeplMGjvpuWl5mmA03rAv7P/7xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742910851; c=relaxed/simple;
	bh=piMudt0azqm4x04liAujtwd/WJBgQTXcbKpgXZkf+Tg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mfOOvS8Cm6ufEahb2UztyxrRyWhoX0Hhn63zitIoQ3u+bRuw79ebHQN/PhqRrI20uJimz3lYYmq02gBtlPF/4V/LlGvT7T8IMkSrR17/Xe8c1QuVEv8DDml9eiA1GiJJVgZENCMAWpjXTUscl9TQi39nEfKy4auZ0D5B0cpWJKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=RWtBZ5fp; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-39123d2eb7fso565499f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Mar 2025 06:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1742910846; x=1743515646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Gwwg+GnTHbGXDmEmCUDRFdBM6BT3+2rym1XD/Z/nfe0=;
        b=RWtBZ5fp1TASFgjUqRbAlKmy0RO5oyAK94rd6gK60s32aqPMmlPaP2h8Ahme16BbNO
         cWLCWXfIigTVRwe6yb2MTN8rQbX9drFmGWNWLqbfuD205Iaej3/1e+c7F0+7hu65iprx
         qZ6fxjNjMAnIWaObip9Bkln0lfQxvt3gM+5pLZS2M7lXSdrDmTIJFbbb7pVurujx4vgj
         KQ/kkvjCK+SEHeOxthDpRVw0nDj4qe/lrGL9Sd6QHaNpZM3Ao+xxLyJ0eWg2l2+eXzVj
         qw+Pj8H9aE9QI2cbmqpcABywmZFQkiMcQS8CI5cLdI6noUjRDFcEytjEryi+9vpeQcla
         u7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742910846; x=1743515646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gwwg+GnTHbGXDmEmCUDRFdBM6BT3+2rym1XD/Z/nfe0=;
        b=w5+3RRMKCDp2zdbqYHzxtddbKsfhEENaUtVjPKOCHijxmEFvJzB9hkBFJgJkdzgjpj
         BE4zLx9Cu0KEcqgt3/BqAnZNf7DyrzSp8qEMWMS4Gh2wO2aNWr1j94mzIGUiv/6WtAb5
         4Iuh0C90G0Eo4cs4YfsB5XYHprpef0hB1TB0k8u62mHv146g0fOy2QJArej+L3GEkY+x
         FPKdCSA6G6D33RMPM8se3+dAQ2AZCk1gcbkKOfwYESQVeATuY1tTirDJ+cPp2JGXV0sk
         hHMqBooy4MeDgiOXr9VF7nQYBCUQlONgGUNVjCIl/BfoEXxpVHvqPMG/3+5C4TZkRx6f
         Sisw==
X-Gm-Message-State: AOJu0YzA5J3rxsS/P22QThMGMOMQ8gC1yrqIYlq0cjo1purUWBY2Q2g/
	6rwaL/i0rFBLRON2n9WnUx4s/9kHeMAK1fRRi0Uw+DO1yeR23uXmlnPbcInS3cFoOJnRAK/kzzi
	v
X-Gm-Gg: ASbGncsRtbdc7KoI+1w28Q9x+fyfhU/x97+SFPr8bfw/gMHFygy3pDeKspZfAkXn5Fg
	c1a2jF6RTC1vCLZ7NKzxW7Y19raFtbNsi++zVF8AaYUGjMrj76KSNV25cAf0cqDuM334ijWkrTw
	UR4QprFDPKoG0T7u5s63fpDq4Ou5hD227tRtYi9g/8KWQloJkvIIv+JHXv27NAm5vSACMGBhSjl
	uNtmjZ/Q07lvtXjUY1rmO36VVW4VI4l0gxYsy/Ho01B7lt2H+5VoWDqrpRT9g4cmD0wrU4ndOLW
	fyTRnqZrLUvkB+ulgCLTy0XuOvl0QukFYUYpAKonERPaQGbWvds=
X-Google-Smtp-Source: AGHT+IG3p7acf51XkkQT4qtWtsUVZ7Jau+hrvi4qbugWjJ931joBN8pZ3ZeshcCMXoKYMYVjwjjMZQ==
X-Received: by 2002:a05:6000:1f87:b0:38d:d371:e03d with SMTP id ffacd0b85a97d-39ac7fcf2f4mr1050264f8f.3.1742910846459;
        Tue, 25 Mar 2025 06:54:06 -0700 (PDT)
Received: from mordecai.tesarici.cz ([99.209.85.25])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4771d51fec4sm59794251cf.52.2025.03.25.06.54.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 06:54:06 -0700 (PDT)
Date: Tue, 25 Mar 2025 14:54:01 +0100
From: Petr Tesarik <ptesarik@suse.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: core: warn if a GFP zone flag is passed to
 hcd_buffer_alloc()
Message-ID: <20250325145401.0562b2f6@mordecai.tesarici.cz>
In-Reply-To: <20250325134000.575794-1-ptesarik@suse.com>
References: <20250320154733.392410-1-ptesarik@suse.com>
	<20250325134000.575794-1-ptesarik@suse.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Mar 2025 14:40:00 +0100
Petr Tesarik <ptesarik@suse.com> wrote:

> Remove a misleading comment and issue a warning if a zone modifier is
> specified when allocating a hcd buffer.
> 
> There is no valid use case for a GFP zone modifier in hcd_buffer_alloc():
> - PIO mode can use any kernel-addressable memory
> - dma_alloc_coherent() ignores memory zone bits
> 
> This function is called by usb_alloc_coherent() and indirectly by
> usb_submit_urb(). Despite the comment, no in-tree users currently pass
> GFP_DMA.

Let me provide a bit of background on this patch. My actual goal is to
remove the DMA zone; I'm now going through core code and removing
GFP_DMA references that somehow look incorrect to me.

I hope this preparation makes it easier to review the removal of
GFP_DMA later.

Petr T

> Signed-off-by: Petr Tesarik <ptesarik@suse.com>
> ---
>  drivers/usb/core/buffer.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/core/buffer.c b/drivers/usb/core/buffer.c
> index 87230869e1fa..10844cd42e66 100644
> --- a/drivers/usb/core/buffer.c
> +++ b/drivers/usb/core/buffer.c
> @@ -108,10 +108,6 @@ void hcd_buffer_destroy(struct usb_hcd *hcd)
>  }
>  
>  
> -/* sometimes alloc/free could use kmalloc with GFP_DMA, for
> - * better sharing and to leverage mm/slab.c intelligence.
> - */
> -
>  void *hcd_buffer_alloc(
>  	struct usb_bus		*bus,
>  	size_t			size,
> @@ -128,6 +124,12 @@ void *hcd_buffer_alloc(
>  	if (hcd->localmem_pool)
>  		return gen_pool_dma_alloc(hcd->localmem_pool, size, dma);
>  
> +	/*
> +	 * Zone modifiers are ignored by DMA API, and PIO should always use
> +	 * GFP_KERNEL.
> +	 */
> +	WARN_ON_ONCE(mem_flags & GFP_ZONEMASK);
> +
>  	/* some USB hosts just use PIO */
>  	if (!hcd_uses_dma(hcd)) {
>  		*dma = ~(dma_addr_t) 0;


