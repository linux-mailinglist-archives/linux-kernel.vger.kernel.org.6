Return-Path: <linux-kernel+bounces-211595-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C46905424
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 15:49:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5748F1F27454
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jun 2024 13:49:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6A417C7AD;
	Wed, 12 Jun 2024 13:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ByZ7abNU"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D51502BD
	for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 13:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718200138; cv=none; b=BjtB8sT3qH2Cc0YK0NLj094eJ7qGh7H23GPxh7IXlM237NmItxkIRfEM/MS4YqhKvjq4q+pmPoUps1GNz8u/yqqMXOIxh7QR/gxqd7AYOB0/CsJGBSKyXmJpuYpsQ4oUA4Ne+MRDVemCGcfl/2pZ4js6gB+WGs1h7zZeXIxZKtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718200138; c=relaxed/simple;
	bh=peIuDCBOI9NiQ6wy38mIxzHfuRB/Z5w9+xE3rqGSkXs=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nmN0GyUNRWxx6bFp9zjiEI6ZYHnDz/66jl5GenketPqeE+t32rVyUDD1SGYeFsT6v43kxmQUkIyu0PM98quPnC4BbaI9/abLlb618pVcK+6XPiRF6R7uubKJWkXZUIz9Mcc5NSwb3/P5Lh0mMdRFm9IuIhNDhdyIioWn6mbmWOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ByZ7abNU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718200135;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=peIuDCBOI9NiQ6wy38mIxzHfuRB/Z5w9+xE3rqGSkXs=;
	b=ByZ7abNUJLqnWfnEvRWEJulnM5Q5TlcJU54Qa7tDvThq9jIp1TUsyKap3e/PhVDPFL+uJH
	SXfJvodl7Qh5eJchn+iEARdAMhXQ2RQetr/f/TVuKS8nhmGeCoB8Xu1r8fLzJkyP+oKCW/
	Wlf8jgukmB+IkwZgpL1ix1attd9L/PI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-xepQBL3VOtSzXorfVzu3sA-1; Wed, 12 Jun 2024 09:48:54 -0400
X-MC-Unique: xepQBL3VOtSzXorfVzu3sA-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-35f2ae13e4eso249664f8f.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jun 2024 06:48:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718200133; x=1718804933;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=peIuDCBOI9NiQ6wy38mIxzHfuRB/Z5w9+xE3rqGSkXs=;
        b=dhby2lGn+HSiR0weX2kfUIsYtR/SjKQ6U3OYIItIWGSt7SlEtQYoF+phXeRCV5/s0I
         ZNnSaMtzTQLwDIZjQtW/vva5uMdyABhdSBSbzkrsS7ag+wxn2wVJX26s7YJcKNOlF8oo
         jRWlbBItBJrHfXV+uiOIORUQaD2fYfNGS/WuyMx2pZvpSI+qujsCPdUotj9HdrakJ6uZ
         ndM+1A2JSadLJF9RtvWJoc8eq0A0akCuo0AMdKX5GbgmLS0eaP+krQTzKp+/q8AflMgx
         7T1Gj3vwnDRN+UDB5Z9QZ62L4DbzMBFj+LwztmFExVJSVKgxas27rUUX43Qa9rvsbhZW
         0qHg==
X-Forwarded-Encrypted: i=1; AJvYcCWtiO1GV50i9FfK7GfOLlb+pnUJ2mE+HHwJcL16xUQc8ACcdlWlIC+D9UQTTzOQftWH5Q0tt5GmlibT7LA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1AENhrksxlmAg+kF/2SqVnksjRyYYX6PpJ73BB70GeO6ncHCk
	H3AeKPn8QG0sE95tPLNz9Gen9ulDmD23kf4/vhqjy8XywZM8JtCym+jIg1LNYPB0wmfc23MYwUu
	EVvzgg5SSaQG9XorNRCFP+/UbE+QhHATWPyOKcYoX03YEEQ5iZMQoJ7L3RcDelmteZ5Jwxw==
X-Received: by 2002:a05:600c:358b:b0:422:ce5:2a3f with SMTP id 5b1f17b1804b1-422867cdc32mr14007585e9.4.1718200133190;
        Wed, 12 Jun 2024 06:48:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGO9fRZDpgE3yVaHTPYpPYIWsbMhL426M4xfN9RR6ysrTwrukg97QKYi2wweLbohnoi4ah8XA==
X-Received: by 2002:a05:600c:358b:b0:422:ce5:2a3f with SMTP id 5b1f17b1804b1-422867cdc32mr14007405e9.4.1718200132813;
        Wed, 12 Jun 2024 06:48:52 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422870f722esm27490825e9.32.2024.06.12.06.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jun 2024 06:48:52 -0700 (PDT)
Message-ID: <795366b601b0b9bed2144ea94c08519dcf198beb.camel@redhat.com>
Subject: Re: [PATCH 1/3] resource: Add resource set range and size helpers
From: Philipp Stanner <pstanner@redhat.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,  Bjorn
 Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, Lorenzo Pieralisi
 <lpieralisi@kernel.org>,  Rob Herring <robh@kernel.org>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,  linux-kernel@vger.kernel.org
Cc: Jonathan Hunter <jonathanh@nvidia.com>, 
	linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org, Robert
	Richter <rric@kernel.org>, Thierry Reding <thierry.reding@gmail.com>
Date: Wed, 12 Jun 2024 15:48:51 +0200
In-Reply-To: <20240612085629.5015-2-ilpo.jarvinen@linux.intel.com>
References: <20240612085629.5015-1-ilpo.jarvinen@linux.intel.com>
	 <20240612085629.5015-2-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-06-12 at 11:56 +0300, Ilpo J=C3=A4rvinen wrote:
> Setting the end address for a resource with a given size lacks a
> helper
> and is therefore open coded unlike the getter side which has a helper
> for resource size calculation.=C2=A0

"open coded"?=20

How about "coded manually unlike [...]"

> Also, almost all callsites that
> calculate end address for a resource also set the start address right

"an end address" or "the end address"?

> before it like this:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0res->start =3D start_addr=
;
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0res->end =3D res->start +=
 size - 1;
>=20
> Thus, add resource_set_range(res, start_addr, size) that sets the
> start
> address and calculates the end address to simplify this often
> repeated
> fragment. In addition, introduce resource_set_size() for the cases
> where setting the start address of the resource is not necessary but
> note resource_set_range() is preferred.

"note"? I don't fully get that sentence.


Looks like a cool little improvement otherwise :)


P.

>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
> =C2=A0include/linux/ioport.h | 32 ++++++++++++++++++++++++++++++++
> =C2=A01 file changed, 32 insertions(+)
>=20
> diff --git a/include/linux/ioport.h b/include/linux/ioport.h
> index db7fe25f3370..2a1d33ad151c 100644
> --- a/include/linux/ioport.h
> +++ b/include/linux/ioport.h
> @@ -216,6 +216,38 @@ struct resource *lookup_resource(struct resource
> *root, resource_size_t start);
> =C2=A0int adjust_resource(struct resource *res, resource_size_t start,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resource_size_t size);
> =C2=A0resource_size_t resource_alignment(struct resource *res);
> +
> +/**
> + * resource_set_size - Calculates resource end address from size and
> start address
> + * @res: The resource descriptor
> + * @size: The size of the resource
> + *
> + * Calculates the end address for @res based on @size.
> + *
> + * Note: The start address of @res must be set when calling this
> function.
> + * Use resource_set_range() if setting both the start address and
> @size.
> + */
> +static inline void resource_set_size(struct resource *res,
> resource_size_t size)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0res->end =3D res->start + size=
 - 1;
> +}
> +
> +/**
> + * resource_set_range - Sets resource start and end addresses
> + * @res: The resource descriptor
> + * @start: The start address for the resource
> + * @size: The size of the resource
> + *
> + * Sets @res start address and calculates the end address based on
> @size.
> + */
> +static inline void resource_set_range(struct resource *res,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resou=
rce_size_t start,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 resou=
rce_size_t size)
> +{
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0res->start =3D start;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0resource_set_size(res, size);
> +}
> +
> =C2=A0static inline resource_size_t resource_size(const struct resource
> *res)
> =C2=A0{
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return res->end - res->st=
art + 1;


