Return-Path: <linux-kernel+bounces-262856-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E51493CDE7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 08:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C389B21B18
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jul 2024 06:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1AE81741D4;
	Fri, 26 Jul 2024 06:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JWbTejoA"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E932B9AD
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jul 2024 06:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721973679; cv=none; b=uS7QJ3BorLYbJigX/9m1CGzlx4tL0+CJJkzrIPO0OEZ0JyPDKmHGHJWMUjLo3noBW398DHm12ddlhzHEJ6RIWChaLaRyEX+nfLYi9MSz1zzanN+3j8zlHfjf6HS/vgs5GLB19MWK0TQR1B4Gii18QubSRs5zzmsgYKjf2RHjzfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721973679; c=relaxed/simple;
	bh=RrAz8M19RlXBZyywNcLjF7uUh2zwnvcHtuqWlY2LLTY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sIDFwNsxQC6PMu7exIPE4uuC4xFBwRyz/o+PLhC3NzpZZBYBlnVv2m07QVOc71kkXxJF1QAQU5/oynu886ZqnCSOqh9jPMOhe5SEQYslO97NSz1SKsVRNGbfhbES5auDzSG7iadIIgEU05hKShzi1pFt8YrDOWG96sOMI+KpOW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JWbTejoA; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4280c55e488so1128955e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 23:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1721973675; x=1722578475; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RrAz8M19RlXBZyywNcLjF7uUh2zwnvcHtuqWlY2LLTY=;
        b=JWbTejoAWyNOU6J3f0ceeQ/zVoMQNScw74mFTrmzK+uKv6zJqairNcfriA02iUegOT
         AmoTdSDbgJeQPNinFsNZHS2vfhl/EqYBnL7BPlVosxOe3j6HE83PmgRqqcS0MRebjuGM
         mAipF0+A1xtyB6dwq9DHvLtk6Wp0FAhEOs8HKnj+b7x5O50dA7Dxpc0MckHmheEzllOW
         beVfKzpBDPCDURXBkZwWOXhjKH6fjmJduc59z8y2YbEqUJJq2W7aEEicjhOcOg25Qdn7
         IbppqGwD3A2gj0iP+Lm1QcgnrewhKP1o9rmMeEuOOYQAJmmtfd7kmfI8DcCuHqW02Z5j
         UrQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721973675; x=1722578475;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RrAz8M19RlXBZyywNcLjF7uUh2zwnvcHtuqWlY2LLTY=;
        b=GxQ+SH8ZL2uVUcy1HtHFptrdqdgUsjCHS3BokxeFw8pcwctwPZ701dNmpgCWmnE10U
         3b02S8bY9UwsIDHJot7P0uLcRXlhXCu3Jf2AEpkuQ/jstTDD8Lea7uAnb8hoRBrufc1w
         F4pYSPpWOU5ycgFggBVqKyss5KwGtcgx2qUZy7jvp5O5guLVqDdRmsn/mb/LIr+K27UO
         4fT2hED9mu9KnHglTUGVgLREGERyo0V1UsRkJ7gQf6ySj8tsFNy/arcgiSGsXJ4u7hYx
         avtP42d/mchf87TDn6MPLncX3HA5LHKxg6H3cxehM2YjKAzqbGjiJKkpHHabVQZSk2Y5
         azRg==
X-Forwarded-Encrypted: i=1; AJvYcCWljdqUJ53ImHOTDjEOWEtsGWfgU8nkAa7Qm93MmGgXjZBQ5lf4EOrbifLEu7hr5pSAx0l2PjPr1ufwMRDR7/AXG6Ao1ozmj933UdnI
X-Gm-Message-State: AOJu0YyrnvC7rA0TjP4SsjkT4VtlVUkgv/h1ef27PeslJjlYOVN2d1+e
	GXydt3FAD7F6g4JI0OSwbsiblZCAjfd5vy9j7aSUX3/zzCJ+C2X5OPQGQEHSvZo=
X-Google-Smtp-Source: AGHT+IFYHxnbpasEh3IPrhx4/linkLt3MYWCDJhJhHxCgfmPNYvORGRvu0vhoxlG6aKHeQXM2+1QzQ==
X-Received: by 2002:a05:600c:1c21:b0:426:5b17:8458 with SMTP id 5b1f17b1804b1-42803b4612amr32590065e9.12.1721973674242;
        Thu, 25 Jul 2024 23:01:14 -0700 (PDT)
Received: from [10.1.1.109] ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c0668sm4037938f8f.10.2024.07.25.23.01.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 23:01:13 -0700 (PDT)
Message-ID: <1e650f29c2714b5f390a2bf5edf5920c2975fbac.camel@linaro.org>
Subject: Re: [PATCH] usb: typec: tcpm/tcpci_maxim: fix non-contaminant CC
 handling
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, Greg Kroah-Hartman
	 <gregkh@linuxfoundation.org>
Cc: Peter Griffin <peter.griffin@linaro.org>, Tudor Ambarus
 <tudor.ambarus@linaro.org>, Will McVicker <willmcvicker@google.com>, 
 kernel-team@android.com, RD Babiera <rdbabiera@google.com>, Badhri Jagan
 Sridharan <badhri@google.com>, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Fri, 26 Jul 2024 07:01:13 +0100
In-Reply-To: <20240710-max33359-toggling-v1-1-f6dc123f3a0a@linaro.org>
References: <20240710-max33359-toggling-v1-1-f6dc123f3a0a@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.1-4 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Wed, 2024-07-10 at 07:28 +0100, Andr=C3=A9 Draszik wrote:
> tcpci_maxim currently never triggers the TCPM state machine when CC
> status has not changed due to a contaminant but due to a real
> connection event, i.e. a genuine plug event, meaning the system will
> stay idle and not notify any subscribers.
>=20
> The reason is that the initial state of the port is 'toggling', which
> causes _max_tcpci_irq() to only drive the contamination part of the
> TCPM state machine (via tcpm_port_clean()).
>=20
> What should happen instead is that if no contamination was detected,
> the TCPM should be notified of the CC change in this case.
>=20
> To fix this, we update ...is_contaminant() to also allow its caller to
> determine if more CC processing is required and then call into the TCPM
> as required.
>=20
> While at it, add a kernel-doc for max_contaminant_is_contaminant().
>=20
> Note: the code has an issue where I2C errors during contaminant
> detection also cause the TCPM state machine to not be updated. This
> commit doesn't change this behaviour and should be addressed by
> follow-up commit(s).
>=20
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---
> =C2=A0drivers/usb/typec/tcpm/maxim_contaminant.c |=C2=A0 7 +++++--
> =C2=A0drivers/usb/typec/tcpm/tcpci_maxim.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 15 ++++++++++++++-
> =C2=A0drivers/usb/typec/tcpm/tcpci_maxim_core.c=C2=A0 | 12 ++++++++----
> =C2=A03 files changed, 27 insertions(+), 7 deletions(-)

Any comments on this patch?

Cheers,
Andre'


