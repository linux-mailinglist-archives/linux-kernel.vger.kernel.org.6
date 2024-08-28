Return-Path: <linux-kernel+bounces-304459-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7778D962064
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 09:11:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3374C284AFF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 07:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D0C3159217;
	Wed, 28 Aug 2024 07:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J89aSZEX"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148C6158A04
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 07:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724829060; cv=none; b=R2OxlzVX5go8i1yC/ydyyg3rhqCJwfn0yTtD1VGEg2htFgefAS6gnkmOnaKO5esjG3kHoedsLysJ/qDlfOlsXBwcWtLyRMatGmsOHvNfkFo0pW2+n8xDCG6m+h2nC+x46orzZZNJFMHyXQ7SfOumu/cO9iPRnLLv0mBv0u+vPDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724829060; c=relaxed/simple;
	bh=hrdybWADZxrNOGDFQ+iblbPSFaRlDH4YMdydN364uxU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KDeZaeD4cYgt/GioTZlLcQQpxTrLd3/GpnnVajqcLNj9j+sv9O4nNk7ZhLCMM5XR7PXliNbpK17tW8/Pg0+4eLDSPphhN5AEgIUg8YZovcanfhpD6XcrGf+oY3qap8rrpmmdffxPMmRZ8myr4fA91fXDFwQQvFGT/iJ2cP7C7kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J89aSZEX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724829058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4exFj43hWLT00BAGeYDHEqubvTOHjaJM+W+ukum/0tY=;
	b=J89aSZEXszSOJoFtln1/zWcF/jLgXyNrcnpHyirMwnd5LwXNd7jIyioRTzTG6NK+091BKg
	UOfS3QhM53YaECJKNYDfz20P9cJ+ra1cIsujHBtvWcPHC6KmuLNYk9CLCI9J6EfHfF+Tw+
	r7prXHR4ya0JF8G6eCXtyJtRffx4T9w=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-99-iQoUvNQQMuKXfiM1Iz87Wg-1; Wed, 28 Aug 2024 03:10:53 -0400
X-MC-Unique: iQoUvNQQMuKXfiM1Iz87Wg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7a1de7141f1so825964385a.3
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 00:10:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724829052; x=1725433852;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4exFj43hWLT00BAGeYDHEqubvTOHjaJM+W+ukum/0tY=;
        b=YlQ2lJgQzllhDBUfsmGyyqySJskxeJFRp0rm3Bqj/I/9FnKaQZ6lqjgYt5X8Q4E5Oe
         TG6Wj4krvBTNRW9XRONRNfMM74f8UY8XmGd2zOxSph99Gojse/poVkMc8vnaqjFJvNKT
         1wRsvW1nTLI8y1SOp5IETO3xq1szMUedZwg9FIqLx0Q91xoDHRdLAJ6D8IQZ1+3qCu8P
         BQnVYnmu0hjpaP1QZj8JN+XnmW9OwpBByWV/5bg1gkqYMrtw1I6xVFqjMyp4XOQ3KzqK
         Wqaht+y/76NMkudLs8Onl9UB2p4o9smTH6fqIiM0KUn+VjPw6ybgz0Ysq2Jm+XU5iTCP
         JWRA==
X-Forwarded-Encrypted: i=1; AJvYcCXmYRwyong5BSHrlJkpAF8JiUXPdRdC1HILB+/vTX9iY+HdFBp5E1zCc0RT9w2d3FZAyzIPgZdn280K9hs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjbxAk5z2YYg3HdYAM8o4b13zGCuXjqxueqMEAOmJV4sQeq3Ii
	WycWeyBqrXnpR/hrHibXc1JdfPqjjQR/UjLy+fkev4ubeJpHa494m4debKfEwO92IZ6A8b8rSQA
	dGuXYdRNk8E5DbKGTq78wB4+oB2UPnqu7gAROp7n2VdoRVEnu7zVioF98SW3wDQ==
X-Received: by 2002:a05:620a:468b:b0:79d:6276:927a with SMTP id af79cd13be357-7a68970207amr1677962285a.22.1724829052416;
        Wed, 28 Aug 2024 00:10:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoJpkEEQicGfWPZT1lOW4zceJ6tHVmY2Rb8P+ysJBwyYwzs7rm3IwCsm6DsOeUMwreCEmk+Q==
X-Received: by 2002:a05:620a:468b:b0:79d:6276:927a with SMTP id af79cd13be357-7a68970207amr1677958385a.22.1724829051978;
        Wed, 28 Aug 2024 00:10:51 -0700 (PDT)
Received: from dhcp-64-16.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a67f319050sm617950485a.11.2024.08.28.00.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2024 00:10:51 -0700 (PDT)
Message-ID: <189ab84e8af230092ff94cc3f3addb499b1a581d.camel@redhat.com>
Subject: Re: [PATCH v4 3/7] block: mtip32xx: Replace deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: Jens Axboe <axboe@kernel.dk>, Wu Hao <hao.wu@intel.com>, Tom Rix
 <trix@redhat.com>, Moritz Fischer <mdf@kernel.org>, Xu Yilun
 <yilun.xu@intel.com>,  Andy Shevchenko <andy@kernel.org>, Linus Walleij
 <linus.walleij@linaro.org>, Bartosz Golaszewski <brgl@bgdev.pl>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,  Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Alvaro Karsz <alvaro.karsz@solid-run.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>,  Eugenio =?ISO-8859-1?Q?P=E9rez?=
 <eperezma@redhat.com>, Richard Cochran <richardcochran@gmail.com>, Damien
 Le Moal <dlemoal@kernel.org>, Hannes Reinecke <hare@suse.de>, Keith Busch
 <kbusch@kernel.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-fpga@vger.kernel.org, linux-gpio@vger.kernel.org,
 netdev@vger.kernel.org,  linux-pci@vger.kernel.org,
 virtualization@lists.linux.dev
Date: Wed, 28 Aug 2024 09:10:47 +0200
In-Reply-To: <c7acca0d-586f-41c0-a542-6b698305f17a@kernel.dk>
References: <20240827185616.45094-1-pstanner@redhat.com>
	 <20240827185616.45094-4-pstanner@redhat.com>
	 <c7acca0d-586f-41c0-a542-6b698305f17a@kernel.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-08-27 at 13:05 -0600, Jens Axboe wrote:
> On 8/27/24 12:56 PM, Philipp Stanner wrote:
> > pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
> > the
> > PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
> > pcim_iomap_table(), pcim_iomap_regions_request_all()").
> >=20
> > In mtip32xx, these functions can easily be replaced by their
> > respective
> > successors, pcim_request_region() and pcim_iomap(). Moreover, the
> > driver's calls to pcim_iounmap_regions() in probe()'s error path
> > and in
> > remove() are not necessary. Cleanup can be performed by PCI devres
> > automatically.
> >=20
> > Replace pcim_iomap_regions() and pcim_iomap_table().
> >=20
> > Remove the calls to pcim_iounmap_regions().
>=20
> Looks fine to me - since it depends on other trees, feel free to take
> it
> through those:
>=20
> Reviewed-by: Jens Axboe <axboe@kernel.dk>

Thank you for the review.

I have to provide a v5 because of an issue in another patch. While I'm
at it, I'd modify this patch here so that the comment above
pcim_request_region() is descriptive of the actual events:

-	/* Map BAR5 to memory. */
+	/* Request BAR5. */


I'd keep your Reviewed-by if that's OK. It's the only change I'd do.

Regards,
P.


