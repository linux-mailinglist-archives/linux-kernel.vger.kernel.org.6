Return-Path: <linux-kernel+bounces-437587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AB79E957D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 14:03:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48439280CB5
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Dec 2024 13:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C34E1E9B38;
	Mon,  9 Dec 2024 12:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="psKlawxL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EBA1E9B18
	for <linux-kernel@vger.kernel.org>; Mon,  9 Dec 2024 12:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733749010; cv=none; b=WoI0HyZUTPQJxWLYqU1lrSUbCagWwBysG61vi0LfGO9iN2WbqArQKd29aT58j6UHuU73Gk0hWF/CLh89IltFESW0GkhMVTgcJRQHsXkU1aRfR8XVPlCByNGvv0QTOlkWMdBGRPJ/ErsDVmAgmFeT1Vx2eJbz3FkTo6pWDAeuVCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733749010; c=relaxed/simple;
	bh=AwatSeIitxHKMVxau0ctM0Z69MO8L7GCr6CTMv35TjY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sTkmn0KcpcuSmImTCYYnsmn2rS6Hboqw0mZR09Lm1PMI7lOpXMc4/Dh9rv8B58OBufnenLZm8mK91s8ECKVhZXKir41UlkQiqPsmh7QCMdxYcH3Hway5emNs5GdijZJJ8ZYAfZ7JEu3Ti04MYo/+LRTfQhYCTRPQLCh3BSGCcOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=psKlawxL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4D6AC4CED1;
	Mon,  9 Dec 2024 12:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733749009;
	bh=AwatSeIitxHKMVxau0ctM0Z69MO8L7GCr6CTMv35TjY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=psKlawxLvSbyTHmtZYS5hK9j6fytRvyVPx4gtyU6B34TBFtZHe2yRxcCgIAo9fkIH
	 8Wq7I8O5KHnOa6ljfovXtGmXTnKBPBG2PNQVdEqMOx+oQChFuzIllDYjhJckHEAIoO
	 oCWmE7+tzp4Hg4E1RpMFOSiHocCl21ZMPkNugHNDCPcV7jm1yRHoFwZt9Y+iVAavi/
	 RzsstVB67o24IUATf2ZXsTrk+DHYUaGBA9E5dAkp23w3kaieRpPaVrINhQVtZTQcva
	 fOT4WOfTU68J0pUe49jqIstca2ozN4LyujVMfoeindS7pIeNM8BdPeBEGzRotDbDrA
	 sHcQmpN7IGfIg==
Date: Mon, 9 Dec 2024 13:56:44 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Shiju Jose
 <shiju.jose@huawei.com>, Ani Sinha <anisinha@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Igor Mammedov <imammedo@redhat.com>,
 <linux-kernel@vger.kernel.org>, <qemu-arm@nongnu.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v6 08/16] acpi/ghes: don't check if physical_address is
 not zero
Message-ID: <20241209135644.19869834@foz.lan>
In-Reply-To: <20241209113640.000055ab@huawei.com>
References: <cover.1733561462.git.mchehab+huawei@kernel.org>
	<95c0fa3fc2969daf3b6bc1f007733f11b715a465.1733561462.git.mchehab+huawei@kernel.org>
	<20241209113640.000055ab@huawei.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 9 Dec 2024 11:36:40 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> escreveu:

> On Sat,  7 Dec 2024 09:54:14 +0100
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > The 'physical_address' value is a faulty page. As such, 0 is
> > as valid as any other value.  
> Still not sure on what faulty pages are :)
> 
> Given I tagged previous (after you'd sent this)
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

It seems I forgot adding this tag, from Igor's review, as per:
	https://lore.kernel.org/qemu-devel/20241204141246.37a7cb9d@imammedo.users.ipa.redhat.com/
This patch was reviwed by Igor already, so:

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> 
> > 
> > Suggested-by: Igor Mammedov <imammedo@redhat.com>
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> > ---
> >  hw/acpi/ghes.c | 4 ----
> >  1 file changed, 4 deletions(-)
> > 
> > diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> > index edc74c38bf8a..a3dffd78b012 100644
> > --- a/hw/acpi/ghes.c
> > +++ b/hw/acpi/ghes.c
> > @@ -400,10 +400,6 @@ int acpi_ghes_record_errors(uint16_t source_id, uint64_t physical_address)
> >  
> >      start_addr = le64_to_cpu(ags->ghes_addr_le);
> >  
> > -    if (!physical_address) {
> > -        return -1;
> > -    }
> > -
> >      start_addr += source_id * sizeof(uint64_t);
> >  
> >      cpu_physical_memory_read(start_addr, &error_block_addr,  
> 



Thanks,
Mauro

