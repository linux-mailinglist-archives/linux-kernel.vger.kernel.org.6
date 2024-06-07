Return-Path: <linux-kernel+bounces-205683-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CC48FFEDB
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 11:09:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9637528DB6C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 09:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07CE15B155;
	Fri,  7 Jun 2024 09:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gSeo9dg3"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C456A405F8
	for <linux-kernel@vger.kernel.org>; Fri,  7 Jun 2024 09:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717751352; cv=none; b=cgmj4VVriyjLXht1wWz0dfGgTGkC69OOiqJl9GI7SGR1TGkTF9hxdQFCkXj9F8qUYL2ym5jBGx5+rTex6edNG1aelWMvCfuJlSdjy8g4H8VMV57DHxMPmWyxfgt2IP2Ns+HdktchHLiDhpbdmU60PFCwWa6kp/9Nwm4yZYBxVVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717751352; c=relaxed/simple;
	bh=2g085Qv2sZ+lzpHJ6d/morSwEobDi+HUPO3OoA/Wcfs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hZ9d/0eKfHfzncMKNsM7QOVQpmqWbdv+SQkNSOKxi1YBKB1sSRF+CWgI1cY/zlBe+wc89dg6Pe1KcygRCMmDX9VP8l/+YLxzLh1ya7pISXwYCZK6wNkBsSkU4Qxh+luHC0XWhKr3BwN9hcmWPQpsrLV7dNAKLkfJwTEUNaNYCJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gSeo9dg3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717751349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=B+hA8Ge9BqN2Oo6x+bvaug2r1jAxQeeVpqVkv24yF+U=;
	b=gSeo9dg3gkJ3uFXys7rf/NzL4ixujJccnGPs5ovDDpzyBDAp+sc106j5ViJyaCzQPVPPrC
	SfiK2/i0x5Wk8XQc/HYcCMAE4TPqMyBtFHbTEIXs2883ut0huRV93wmxixtXd84FYD4gc2
	+SE2RLzm0//Z6c22nM8D7Zb6PHjC0C4=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-GZsTN2QNPzWhCt3dnY_e9g-1; Fri, 07 Jun 2024 05:09:07 -0400
X-MC-Unique: GZsTN2QNPzWhCt3dnY_e9g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a68cc214ac7so113507166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jun 2024 02:09:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717751346; x=1718356146;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B+hA8Ge9BqN2Oo6x+bvaug2r1jAxQeeVpqVkv24yF+U=;
        b=FOYmPl5xkliFPPfG4daBTaSBsKiX9b9rIfEp0/V8ffne8hlw8O+reM/vFq8T5IdxOl
         ArQ9UvtO/SQ8jTSHDficZZQrKD0eMZESp+CE5ujTu37fIwp77ZMclH499XQYS3uF0/bp
         1gnZK5oBpAB4Ahi9CjNdPgTjgX9uZQG3ZFBLKEPqOKV/Ly09Q1yAjniZsOZg3eOWwhDq
         dfMHhaQhxXiY6wzFrdgIOBqjc1j8+UVoJptVg1VLy2rSSkgyc1y7bT04qbTCtvq7KpYQ
         Sn8AoXMEzGZ68+xPpNBb3oC8fE3seT/yMqbevROgH8eHKQKiXDSRlC2vqyrhvurriIvU
         Bsqg==
X-Forwarded-Encrypted: i=1; AJvYcCWlbInXWdPuiJ+amQXxpbZWzEqAcxjrTsoug20hrsGYDOh6QKyyOYOtxEpbrsmRMoTcFDU8QQjsFOf7pkTLlqgVqadzOMgSz1hQNRzD
X-Gm-Message-State: AOJu0Yy3u067k01e0jjOVNVZW80AbSVSydAftpvtwz8aVJiQyUzbM+fq
	ACiN2Cv5PYY/Gywc58khoTkZxtnrAuiOUFRSwxZ5oOUoORWbbhIuje8UTwGnvVkjnWcXcUyRYWD
	ysd9HF/PyuSg7Rf3mX3b4Vyeq1LQjqw2Mr1vkVJjRVnOGbFup4NqRAqFp2Z/JzA==
X-Received: by 2002:a17:906:48cc:b0:a68:e7e0:1fd1 with SMTP id a640c23a62f3a-a6cd5616af7mr139567266b.7.1717751345966;
        Fri, 07 Jun 2024 02:09:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeH+nc8VxKm7H4zo7Jyw3/GG2IBw4hOvl0fOyKmEAvw8ocTKoS9aGEe5N4RDOTTILMmK/Vfg==
X-Received: by 2002:a17:906:48cc:b0:a68:e7e0:1fd1 with SMTP id a640c23a62f3a-a6cd5616af7mr139565566b.7.1717751345434;
        Fri, 07 Jun 2024 02:09:05 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:d5af:1ef7:424d:1c87:7d25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c80581f42sm213657566b.1.2024.06.07.02.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jun 2024 02:09:04 -0700 (PDT)
Date: Fri, 7 Jun 2024 05:09:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Harald Mommer <Harald.Mommer@opensynergy.com>
Cc: virtio-dev@lists.linux.dev, linux-can@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Wolfgang Grandegger <wg@grandegger.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Dariusz Stojaczyk <Dariusz.Stojaczyk@opensynergy.com>
Subject: Re: [PATCH 1/1] virtio-can: Add link to CAN specification from ISO.
Message-ID: <20240607050716-mutt-send-email-mst@kernel.org>
References: <20240606141222.11237-1-Harald.Mommer@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606141222.11237-1-Harald.Mommer@opensynergy.com>

On Thu, Jun 06, 2024 at 04:12:22PM +0200, Harald Mommer wrote:
> Add link to the CAN specification in the ISO shop.
> 
>   ISO 11898-1:2015
>   Road vehicles
>   Controller area network (CAN)
>   Part 1: Data link layer and physical signalling
> 
> The specification is not freely obtainable there.

This message really should not have been posted to any
of the lists that you copied.


> ---
>  introduction.tex | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/introduction.tex b/introduction.tex
> index 8bcef03..72573d6 100644
> --- a/introduction.tex
> +++ b/introduction.tex
> @@ -142,7 +142,8 @@ \section{Normative References}\label{sec:Normative References}
>      TRANSMISSION CONTROL PROTOCOL
>  	\newline\url{https://www.rfc-editor.org/rfc/rfc793}\\
>  	\phantomsection\label{intro:CAN}\textbf{[CAN]} &
> -    ISO 11898-1:2015 Road vehicles -- Controller area network (CAN) -- Part 1: Data link layer and physical signalling\\
> +    ISO 11898-1:2015 Road vehicles -- Controller area network (CAN) -- Part 1: Data link layer and physical signalling
> +	\newline\url{https://www.iso.org/standard/63648.html}\\
>  \end{longtable}
>  
>  \section{Non-Normative References}
> -- 
> 2.34.1
> 


