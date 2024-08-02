Return-Path: <linux-kernel+bounces-272238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA6494590F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 09:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B2D61F2386C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 07:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B5DF1BF320;
	Fri,  2 Aug 2024 07:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iq+HzlKS"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7ABF335C0
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 07:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722584359; cv=none; b=ThfuQMG+5qqDUDCl3ee8/DyEa/5LQRcj9I6t5wK1tfdV8OrKiuMq9eexlcpYN6fnwpbC6dVvLvhnzOvk4ozKFn9rY+AgTEWibWmCY1AosAhp8Tr4Lw6z7R5Mr4QA+6vb9KOyVE54XqzQrkl8N5dJd+ak26AeRhJWY9rrAtWeGQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722584359; c=relaxed/simple;
	bh=XyoAsjYXR6vlNnAFOtS7SDp80nop+IcyYDiUz8xV5lU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VPAaSiBzpz0xKTKjdNkOVrrmQ4TexXtLgjnkGZD/t/iRi4T82l64BCEKigqcAHCzOoDyxs1qZ+RjhGScoul4fvx9/de0XfBh5K1GsUD8BEMDH3PIeVFg4KvKcWTTxNCurTH1HQan1Bn4SE8FbAhsd8cDtmU2YskEYYWFSEkEPGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iq+HzlKS; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722584356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyoAsjYXR6vlNnAFOtS7SDp80nop+IcyYDiUz8xV5lU=;
	b=iq+HzlKSA/AXyDsPJt66046TyIomT4jZ8kOYF0/T+Yjlgy4sBFPDVFFzKedIW5h3s8NeEr
	uxAno3kip9SrbEG6/ZLSvwDqsaVTSlT/OusjdHeiBG9EL8ikb02fbvljLZctFshPuGVjIe
	ubZe5ZqOC4W7vLY9EPT2IXIuzplrgGM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-609-j4WR81OCMNCg3CVGiRvClQ-1; Fri, 02 Aug 2024 03:39:15 -0400
X-MC-Unique: j4WR81OCMNCg3CVGiRvClQ-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5a29c8de0f9so1209946a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 00:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722584354; x=1723189154;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XyoAsjYXR6vlNnAFOtS7SDp80nop+IcyYDiUz8xV5lU=;
        b=t+W5jYJBBFZB3pm7/cAOcgfxOhEUbs4b/J7R5g3sWC1D5GqREFAT+r12TozuSYaOPy
         2fIrbg5vBsOdiSi5mVG1uE6eahzcfa7mIB7X6C7rxyRC4VCGXKGyEzS11/gyrJpzXM45
         6QqMZ+J0pJUDDieL6tL+yXTCqiIA3/bcM53QmI9ofY4q92GNoCgDciPHk8jMpCGE1gNh
         JroHn3QHDYiZEpKBX80hgoBuxfG6t8e/9ybE/FpO62g/QQ3i8VIfQl0LcM/NPStrF4C6
         /Zk1WKlCb/EViEQcduJcSjJgpj0Ut0URIWl+MRpIts72Kj44dtdBTfvFiiwxG6LvyxK5
         Srpw==
X-Forwarded-Encrypted: i=1; AJvYcCV51eUgGDWrV3g5QiDRVcOcdhM2MPtSYhYJ5CwEOV/xDT09IE27wm0KatXLCo1aAlVYOJjKdSJm+xBukmN8RKpCDCb9Qoi0gFyJ34f5
X-Gm-Message-State: AOJu0YxnRISEr+LhdYHlSaj26S8PcXMTWuURA7u1zWwO/VHdiWARtqbT
	fdS9c+E0GDyjmXeeBcXh+C1Iy+qxW7Vk3MFV6FJtGU4/vUKu9lfmq4/+eIzFmV6P4CV+OCm3RIm
	yRXRO4/833GljE92/cZ+8SvuIvHWlgTuJqg/4DUnG2K3g5ow3KUDKeJqu+0fxSQ==
X-Received: by 2002:a17:907:d8e:b0:a7a:a4be:2f8f with SMTP id a640c23a62f3a-a7dc4b2ed0fmr130670466b.0.1722584354322;
        Fri, 02 Aug 2024 00:39:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFONH/seRIPn55nxoXB3Ih6iDe58gzFUv6VfG3nc8IISoWvXI/jL74Kj1p+wvKOnC3k+pqpQ==
X-Received: by 2002:a17:907:d8e:b0:a7a:a4be:2f8f with SMTP id a640c23a62f3a-a7dc4b2ed0fmr130665366b.0.1722584353684;
        Fri, 02 Aug 2024 00:39:13 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3d6c:8e00:43f3:8884:76fa:d218])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e80eb6sm66892066b.174.2024.08.02.00.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 00:39:13 -0700 (PDT)
Message-ID: <6eb427a501499273b39439dd6514fef399c3b55f.camel@redhat.com>
Subject: Re: [PATCH 08/10] serial: rp2: Remove deprecated PCI functions
From: Philipp Stanner <pstanner@redhat.com>
To: Jiri Slaby <jirislaby@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 Giovanni Cabiddu <giovanni.cabiddu@intel.com>, Herbert Xu
 <herbert@gondor.apana.org.au>,  "David S. Miller" <davem@davemloft.net>,
 Boris Brezillon <bbrezillon@kernel.org>, Arnaud Ebalard
 <arno@natisbad.org>,  Srujana Challa <schalla@marvell.com>, Alexander
 Shishkin <alexander.shishkin@linux.intel.com>, Miri Korenblit
 <miriam.rachel.korenblit@intel.com>, Kalle Valo <kvalo@kernel.org>, Serge
 Semin <fancer.lancer@gmail.com>, Jon Mason <jdmason@kudzu.us>, Dave Jiang
 <dave.jiang@intel.com>, Allen Hubbe <allenbh@gmail.com>, Bjorn Helgaas
 <bhelgaas@google.com>, Kevin Cernekee <cernekee@gmail.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Jaroslav Kysela
 <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Mark Brown
 <broonie@kernel.org>, David Lechner <dlechner@baylibre.com>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, Jonathan
 Cameron <Jonathan.Cameron@huawei.com>,  Andy Shevchenko
 <andriy.shevchenko@linux.intel.com>, Jie Wang <jie.wang@intel.com>, Adam
 Guerin <adam.guerin@intel.com>, Shashank Gupta <shashank.gupta@intel.com>,
 Damian Muszynski <damian.muszynski@intel.com>, Nithin Dabilpuram
 <ndabilpuram@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>, Johannes
 Berg <johannes.berg@intel.com>, Gregory Greenman
 <gregory.greenman@intel.com>, Emmanuel Grumbach
 <emmanuel.grumbach@intel.com>, Yedidya Benshimol
 <yedidya.ben.shimol@intel.com>, Breno Leitao <leitao@debian.org>, Ilpo
 =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>, John Ogness
 <john.ogness@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-ide@vger.kernel.org, qat-linux@intel.com,
 linux-crypto@vger.kernel.org,  linux-wireless@vger.kernel.org,
 ntb@lists.linux.dev, linux-pci@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-sound@vger.kernel.org
Date: Fri, 02 Aug 2024 09:39:11 +0200
In-Reply-To: <8d2e03ac-2a08-4a25-9929-dad375afb738@kernel.org>
References: <20240801174608.50592-1-pstanner@redhat.com>
	 <20240801174608.50592-9-pstanner@redhat.com>
	 <8d2e03ac-2a08-4a25-9929-dad375afb738@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-08-02 at 07:18 +0200, Jiri Slaby wrote:
> On 01. 08. 24, 19:46, Philipp Stanner wrote:
> > pcim_iomap_table() and pcim_iomap_regions_request_all() have been
> > deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI:
> > Deprecate
> > pcim_iomap_table(), pcim_iomap_regions_request_all()").
> >=20
> > Replace these functions with their successors, pcim_iomap() and
> > pcim_request_all_regions()
>=20
> Reviewed-by: Jiri Slaby <jirislaby@kernel.org>

Thank you for the review.

I have to provide a v2 for a small bug in one of the other patches.
While I'm at it, I would rename the title of this patch =E2=84=968 here so =
that
it's "Replace" instead of "Remove", making it consistent with the other
ones.

I'd assume that keeping your RB then would be alright. Please tell me
if not.

Cheers,
P.

>=20
> > Signed-off-by: Philipp Stanner <pstanner@redhat.com>
> > ---
> > =C2=A0 drivers/tty/serial/rp2.c | 12 +++++++-----
> > =C2=A0 1 file changed, 7 insertions(+), 5 deletions(-)
>=20
> thanks,


