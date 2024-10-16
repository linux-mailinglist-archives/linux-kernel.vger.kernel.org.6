Return-Path: <linux-kernel+bounces-368083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC78C9A0AF8
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 15:05:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0A13B1C20E1A
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 13:05:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C6B208D96;
	Wed, 16 Oct 2024 13:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P7Aw0Ng7"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E97208967
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 13:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729083918; cv=none; b=YcYDIqKgAhd2xexxRaCOg7iOK/Y5UkfhEjTEsTd3IVrse/bwxWrvglio1SCx0rYtd/KiOcWnbf5CzzWOSiVnzjqShazRsO+wHcktlEbkR4U3bEdeCPYjQXvp4PbBytuIa7hQJADwkncRU+37huOQ/qyCvFBicahQyUYYO6e+QMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729083918; c=relaxed/simple;
	bh=SKvM6CdR+oyJ0Yu3NB75uyOzcADdnJSBpDgOLrDQ6k8=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gg4TyvHpUWKyU9mbaQb3wXxTo9ilRNdbwVNxFmkTEcnQGabcc1XA6wHDhEHxmx3E2VUmDxXHP4H2BdTY+ctMWiAyEHQ6u4rTndVnpHsrofwAkMsmiCV1uocZ5X1Gpwto3wqm63ZDq4+bX7xlpik4kzUNFFcy2ggCrLbiNHZoP98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P7Aw0Ng7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729083914;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ACVXk1eqVCYcihZ6o/19CXkIxiC5+iHoehaaXe8KMYM=;
	b=P7Aw0Ng7FMrsMGYo0RfVXP8lgVOro3kWFU7Nk9ODIpwTfWJMjlfTyP5XooRNn21axMpPo/
	tYexIb/t9TsPmO/6rkB5kOMJdYHMpnxCL/3nsNI1uzZwkBCH/SEmt7W7BsoNdOJpBMuoBM
	dhK64EVH7PKXOlo5k68nw1QP0+qHu28=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-FA9Don6VMbKpljydWWYM9g-1; Wed, 16 Oct 2024 09:05:13 -0400
X-MC-Unique: FA9Don6VMbKpljydWWYM9g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-37d3e8dccc9so3229775f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 06:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729083912; x=1729688712;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ACVXk1eqVCYcihZ6o/19CXkIxiC5+iHoehaaXe8KMYM=;
        b=M1ijHc0nesBAIviquwEAiNHhscxy6bnRKxwVBiPLZwk4HYOhCa6SLLEFeCnS0WOYIy
         IuA8MUPgMHzZ3c9UD1NEYLLU6pGVhn8u/Muczq69ywywi0eKHSkxKnBeRM5cJucvIYJM
         yGlGijNS/8qtSMimEy9byVZ6eQwGhRh9mFwGcjz4+/HGIRh5AsKpedH2vcPUQpgqqxb8
         rwiSL9YiXFcDfi88G3KfBBIIKCGpNo0fvi6jtfwc3z7y01oPAjLYn9iX6xGFD4uFLqCc
         UI5Jxj/urUdinJgkD6Ss0q78aDNWsq+E4SudoDXUKB2NKLA0kdn4Q16Nyj7XHnR0NxYc
         F+TQ==
X-Forwarded-Encrypted: i=1; AJvYcCWenxnq9x5Wt44ippFbKXX33dHjM7ZFlXxU/McfNecb+4/QS5BT0hmKkBwKlns6/4L1cwtCT0unwVAW3Og=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE6xyORBab6XH6W/lQaiLtqEjBX5x39nVnfRNRo0mxuALXw6b4
	ksAW94e7C5CMM3/eSZ4DFxak2rr6ldr5FAknQFHMGPgNeKeKZdZ5sxJIQlM7262mysB0w8KdK1W
	YoM3Q5+pCRFRNjG0aFwQQ5tgfln6tj3ZmpmwjtHXJKp7Wmc8ovfNm6/wANQTotA==
X-Received: by 2002:a5d:53d0:0:b0:37c:d2f3:b3b0 with SMTP id ffacd0b85a97d-37d551d5113mr11285548f8f.23.1729083911887;
        Wed, 16 Oct 2024 06:05:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWDUPb62QGiZV3FoX7Zj6XqFuD7zwRWksL6H+UbI0V181nFzohNZUjYzU07DPoUgxKqp4c4A==
X-Received: by 2002:a5d:53d0:0:b0:37c:d2f3:b3b0 with SMTP id ffacd0b85a97d-37d551d5113mr11285533f8f.23.1729083911527;
        Wed, 16 Oct 2024 06:05:11 -0700 (PDT)
Received: from dhcp-64-113.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fbf818esm4280091f8f.84.2024.10.16.06.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 06:05:11 -0700 (PDT)
Message-ID: <1cf314b3e91779e3353bbcaf8ad13516a00642e3.camel@redhat.com>
Subject: Re: [PATCH 1/1] PCI: Convert pdev_sort_resources() to use resource
 name helper
From: Philipp Stanner <pstanner@redhat.com>
To: Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,  Bjorn
 Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Wed, 16 Oct 2024 15:05:10 +0200
In-Reply-To: <20241016120048.1355-1-ilpo.jarvinen@linux.intel.com>
References: <20241016120048.1355-1-ilpo.jarvinen@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-16 at 15:00 +0300, Ilpo J=C3=A4rvinen wrote:
> Use pci_resource_name() helper in pdev_sort_resources() to print
> resources in user-friendly format.
>=20
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
> ---
> =C2=A0drivers/pci/setup-bus.c | 5 +++--
> =C2=A01 file changed, 3 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index 23082bc0ca37..071c5436b4a5 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -134,6 +134,7 @@ static void pdev_sort_resources(struct pci_dev
> *dev, struct list_head *head)
> =C2=A0	int i;
> =C2=A0
> =C2=A0	pci_dev_for_each_resource(dev, r, i) {
> +		const char *r_name =3D pci_resource_name(dev, i);
> =C2=A0		struct pci_dev_resource *dev_res, *tmp;
> =C2=A0		resource_size_t r_align;
> =C2=A0		struct list_head *n;
> @@ -146,8 +147,8 @@ static void pdev_sort_resources(struct pci_dev
> *dev, struct list_head *head)
> =C2=A0
> =C2=A0		r_align =3D pci_resource_alignment(dev, r);
> =C2=A0		if (!r_align) {
> -			pci_warn(dev, "BAR %d: %pR has bogus
> alignment\n",
> -				 i, r);
> +			pci_warn(dev, "%s: %pR has bogus
> alignment\n",
> +				 r_name, r);

Why do you remove the BAR index number, don't you think this
information is also useful?

One could also consider printing r_align, would that be useful? Note
that there is a similar pci_warn down below in line 1118 that does
print it. Would you want to change that pci_warn()-string, too?

P.

> =C2=A0			continue;
> =C2=A0		}
> =C2=A0


