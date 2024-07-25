Return-Path: <linux-kernel+bounces-262383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C65D93C64A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 17:21:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD1F71C215BE
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2024 15:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24D419D89E;
	Thu, 25 Jul 2024 15:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKHfxdxQ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD021993AE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 15:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721920906; cv=none; b=rNyPIx7UoTBD3gn6PITKWt4egEWJk6ztSrchk6pnzknznCtoy4wsW9NROVa1ixVg51slfAAosf60XCZlG+CNmQISQ2V9SLkixV7zo+AeDJSmc3OPO95bxIjzihnVFDM8/sENcr4kGf4qb4tJH6K9jpHNZPiFoNR3iHlXFr4juzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721920906; c=relaxed/simple;
	bh=RkNVsX0GJWP39VhHnsRew4x+r/mYmpi8tLHm7VuNQnI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HOxuNSMT1/JKDlj+qes/hR+N2LQRfjrWScBRYYLQ4TISkBbt0PimOLtugUS6JpSGWOZRQeQ6uZ+NYD1N9Gomo/xWU08DFBsA9Tw+IN/SEVcTs7r9f+uay0k/4XhbQ4sE7kpnlYU78SXdtoL6tIguDrZBApnxCzpRwzTC9uYTIBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MKHfxdxQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1721920903;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z8Tjgy4dHalmku2MigGV36hJgcomQ9zlrQHbeuGTVtQ=;
	b=MKHfxdxQDLeDjoRt155tJ66XTkJWcNhC3MIoXZHa6Sm14/R6uSUrvGloGWND7ShEkb5F2C
	Z9AlqSyerw5ZaURvkm9j9Vw8loYfdvgeEmtxp2bXh9mdF8ZLaLW7nwvIbAkS2U70OzZ8Is
	LITaf/5iRewgeCFu+AOf69M7gAGxDCk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-BNqzsN9MMnmhOY1MCCGDwg-1; Thu, 25 Jul 2024 11:21:42 -0400
X-MC-Unique: BNqzsN9MMnmhOY1MCCGDwg-1
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-42809bbece7so238705e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jul 2024 08:21:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721920901; x=1722525701;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z8Tjgy4dHalmku2MigGV36hJgcomQ9zlrQHbeuGTVtQ=;
        b=SieO/RJ3at6IWO5WoB1fwAV47Z0owie2jvM3tn3wUwgc3A6F6rmAUYrFW5i0HbLBCk
         +thEa14lV+jgL/HjCshwTGSI9J+SgDLdpsUKNrCI/p9mGTQWtxUumSgABUQEgLNXLl07
         v9ABk4qK20TMfz3Ou12HpGVUhj30CiEjfYmf5X/1YMu5Mh/+wFTewe7Wq5UtWRwY7Nha
         PQiBxscq1GTmzZUQ9e8G0FFuhqIr08iPNTmtt05VLE2yf+wxn0nVg3gIPfnU1AnFgxwL
         os8z+3HG8RLzEYdf/6EkxiYwHbCCJUEsWA/MU5yK22kqZ9kb3hb3s1i2zraqdrtiaFf7
         Ldvw==
X-Forwarded-Encrypted: i=1; AJvYcCW784XPtX7pc42VUsVb8Gx4COVn/9MI5G5b1LsMNKJ9qb/ZcpsaTReDkoPNBe7GxAv5NxRkcG4qLIaFGviGMjIDKg1ZeVeenNFLMdMS
X-Gm-Message-State: AOJu0Yzvcn6QC8aydQ6ZwcJkeELZnHQk61aqJ8dqIafJzPYaiJ/F5SNM
	fFQID6opLRZUI6Nlx/pfDD7GqWw7epc67H1kzikkuH04vfhDgCtG8AVR547Rwt8U0o0k800/kah
	hdWG2pRrN7cNWrTY+s/LMskUdfGISghZDJlFxp64KqUM7gMlNlr80OkG49pQDVQ==
X-Received: by 2002:a05:600c:19c7:b0:427:9f6f:4913 with SMTP id 5b1f17b1804b1-4280576b7famr12152515e9.5.1721920901107;
        Thu, 25 Jul 2024 08:21:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFUoq9MyYvXOU4HItbU3COs+rrthKOGlBJJ1A0/BR1JqKct+++msddOJXUIccyRZvEURjAPIw==
X-Received: by 2002:a05:600c:19c7:b0:427:9f6f:4913 with SMTP id 5b1f17b1804b1-4280576b7famr12152425e9.5.1721920900677;
        Thu, 25 Jul 2024 08:21:40 -0700 (PDT)
Received: from pstanner-thinkpadp1gen5.fritz.box (200116b82d135a0064271627c11682d8.dip.versatel-1u1.de. [2001:16b8:2d13:5a00:6427:1627:c116:82d8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36416e2esm2558518f8f.0.2024.07.25.08.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jul 2024 08:21:40 -0700 (PDT)
Message-ID: <9529b8012b1a1573316d65727f231f5cf54d0315.camel@redhat.com>
Subject: Re: [PATCH] PCI: Fix devres regression in pci_intx()
From: Philipp Stanner <pstanner@redhat.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, Krzysztof
 =?UTF-8?Q?Wilczy=C5=84ski?=
	 <kwilczynski@kernel.org>, linux-pci@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>
Date: Thu, 25 Jul 2024 17:21:39 +0200
In-Reply-To: <ZqJgkLxJjJS7xpp1@infradead.org>
References: <20240725120729.59788-2-pstanner@redhat.com>
	 <ZqJgkLxJjJS7xpp1@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-07-25 at 07:26 -0700, Christoph Hellwig wrote:
> Can we please fix this to never silently redirect to a manager
> version

It is not the fix or the recent changes (which the fix is for) to PCI
devres that is doing that. pci_intx() has been "silently redirect[ing]
to a managed version" since 15 years.

The changes merged into v6.11 attempted to keep this behavior exactly
identical as a preparation for later cleanups. The fix here only
corrects the position of the redirection to where the "crazy devres
voodoo" had always been:

void pci_intx(struct pci_dev *pdev, int enable)
{
	u16 pci_command, new;

	pci_read_config_word(pdev, PCI_COMMAND, &pci_command);

	if (enable)
		new =3D pci_command & ~PCI_COMMAND_INTX_DISABLE;
	else
		new =3D pci_command | PCI_COMMAND_INTX_DISABLE;

	if (new !=3D pci_command) {
		struct pci_devres *dr;

		pci_write_config_word(pdev, PCI_COMMAND, new);

		/* voodoo_begin */
		dr =3D find_pci_dr(pdev);
		if (dr && !dr->restore_intx) {
			dr->restore_intx =3D 1;
			dr->orig_intx =3D !enable;
		}
		/* voodoo_end */
	}
}
EXPORT_SYMBOL_GPL(pci_intx);

> and add a proper pcim_intx instead=C2=A0

That has already been done. pcim_intx() sits in drivers/pci/devres.c

> and use that where people actually
> want to use the crazy devres voodoo instead?=C2=A0 Doing this silently
> underneath will always create problems.

That's precisely what all my work is all about. The hybrid nature of
pci_intx(), pci_set_mwi() and all pci*request*() functions needs to be
removed.

However, that will take us some while, because the APIs are partly
ossificated and every user that relies on implicit crazy devres voodoo
has to be identified and then ported to *explicit* half-crazy devres
voodoo.

More details here:
https://lore.kernel.org/all/20240613115032.29098-1-pstanner@redhat.com/

P.

>=20
>=20


