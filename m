Return-Path: <linux-kernel+bounces-237355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F1E891EF9D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 08:59:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFC1A1F234F5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 06:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 596AC12E1DB;
	Tue,  2 Jul 2024 06:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CR+kvVLh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2718A12D1E8
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 06:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719903563; cv=none; b=jxZEghBgcA5GJbRYiPD6pZwBmDmp4BRepzRRTTZZ93hpbLsHD5doDVpJGsAmcmJi7UCZ2DIswBcBlN9an3wNJ1Mp4OsiazJU7nfD5FrHaBwowv7hnkir84FugqMMJJnjU0NWwWVYhbZRL2gAs02NiVu0f+c/Xv4g+x0E7NuRLqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719903563; c=relaxed/simple;
	bh=Rd/RzdxgFoao+tjvS20h2iENS+qz6H0tKNh29qnyTTQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r71vRpxGrTMnjoHUj+ee+rH6kZbWfgPx8PgNdsWl+HYQkPi4dDn8Z1MS1by/rop11WY74GnbBqD76JGx3iOjWEEzaAg9Jg/heUMy22p+cbbw18+3UeQAUrNjIeJGW9PN01Q28gkcSfK5EJImt4lz4GL4N9shUkzujDMFBIrhY1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CR+kvVLh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719903561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Rd/RzdxgFoao+tjvS20h2iENS+qz6H0tKNh29qnyTTQ=;
	b=CR+kvVLhiYjfT8gaSSTv9V681ATCK2RBiOK3GDYyyrh/zgNaRFRAPBYMFyMlY+qrmjRcrf
	+FSygMLO7NRXcdlrngYA6mbbNOgjuLMb1H53kHnlqoUn/Ak2Z0RFGIj0KmFPFPPe7z0t/w
	ExzE2H3JYlUyG/FlOj3KUp/TWushJgg=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-SIJ-20VAPWGLmJgJmPZclQ-1; Tue, 02 Jul 2024 02:59:16 -0400
X-MC-Unique: SIJ-20VAPWGLmJgJmPZclQ-1
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-52cd9405c75so693282e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jul 2024 23:59:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719903555; x=1720508355;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rd/RzdxgFoao+tjvS20h2iENS+qz6H0tKNh29qnyTTQ=;
        b=gL0YH1t2srvAbpf1DCMEov1++nTDQWuidI8P7bvPSuyJAjZ9Lf+nXrLrCMZuOTLSce
         hmOT+iqpMzdpJ+FF9C0zD/1yp2Vv7lwKkZH7axa0g3JLsaJnl5r8iL5IQZikVupfyr9+
         rWXdwOQl+4ThsjwELLGiUKVIrOvNnriocAtjw76GkVPNAXCSYfvmqyAYQn8BZdT3QaiV
         f72i5LeN2BJsI7GhF6WvIUNzrKDpZ0XOWh/yb4hR0Uf9PlCLzsTMHGcgdC4dKXlGtvSC
         ENITfCMSHya0YcU8juJtatWuUwFHBYjcBRZsqheq36CrwTKGmEa+rn+kh1K74SY1GcFt
         QvfA==
X-Forwarded-Encrypted: i=1; AJvYcCVXI+hUZRfiCFXH2FgVvBxF3w70SUTjnwQjROGhwqd81yfTcgjF5jIVIa9knJHSIPEC2tllOq5+HdEfYbdojTwA2vq893JL2VOuDqlr
X-Gm-Message-State: AOJu0YxnIiBtaqubpt3iZa7kI1nM8gw3H5LtNW7de5/WIxQTyLvpAv9W
	ovYhhgAyRySFPI0pmZJektb6OR50uk1n/jJBThqNG6V0Dy+WbOZLQg3Kce7uFM69uKVH1oTC4V8
	oOSankrl2mnFgFZRYP1Jkgor7/Sk5xAmr4BKXCZKmXQnyzBmyLEe7gk7SlHui4g==
X-Received: by 2002:a05:6512:3b82:b0:52c:d7cc:33da with SMTP id 2adb3069b0e04-52e82781728mr4311177e87.5.1719903555011;
        Mon, 01 Jul 2024 23:59:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhDdqPcifqRCMpdR3/pZrpWaJ0ehef+3kASf9fmzugXWnbXQzPcb1hFh97Iab2IrnSolSs+A==
X-Received: by 2002:a05:6512:3b82:b0:52c:d7cc:33da with SMTP id 2adb3069b0e04-52e82781728mr4311164e87.5.1719903554605;
        Mon, 01 Jul 2024 23:59:14 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42573c55ff4sm160862905e9.46.2024.07.01.23.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 23:59:14 -0700 (PDT)
Message-ID: <ed7a3800674cf5bc94f4d8119f6f7c311f9e7eaa.camel@redhat.com>
Subject: Re: linux-next: build warning after merge of the pci tree
From: Philipp Stanner <pstanner@redhat.com>
To: Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Bjorn Helgaas
	 <helgaas@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Bjorn Helgaas
 <bhelgaas@google.com>,  Lorenzo Pieralisi <lpieralisi@kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Date: Tue, 02 Jul 2024 08:59:13 +0200
In-Reply-To: <20240701201532.GA272504@rocinante>
References: <20240701192453.3e4a0a3e@canb.auug.org.au>
	 <20240701193748.GA13881@bhelgaas> <20240701201532.GA272504@rocinante>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-07-02 at 05:15 +0900, Krzysztof Wilczy=C5=84ski wrote:
> Hello,
>=20
> [...]
> > > After merging the pci tree, today's linux-next build (htmldocs)
> > > produced
> > > this warning:
> > >=20
> > > Documentation/driver-api/pci/pci:10: drivers/pci/devres.c:556:
> > > WARNING: Inline emphasis start-string without end-string.
> > >=20
> > > Introduced by commit
> > >=20
> > > =C2=A0 06fa2e1e9116 ("PCI: Deprecate pcim_iomap_table(),
> > > pcim_iomap_regions_request_all()")
> >=20
> > I fixed by changing * to \* here:
> >=20
> > =C2=A0 * void __iomem \*mappy =3D pcim_iomap(pdev, bar, length);
>=20
> I wonder if the following hack would work too:
>=20
> =C2=A0 void __iomem * mappy =3D pcim_iomap(pdev, bar, length);
>=20
> Separate the asterisks from the name, so that the parser will no
> longer try
> to make "mappy" bold.
>=20
> Also, "mappy"... Philipp, this is so amazingly cringe. :)

The kernel community has a reputation to defend =E2=80=93 that of not being
boring corporate people :]

P.

>=20
> =C2=A0=C2=A0=C2=A0 Krzysztof
>=20


