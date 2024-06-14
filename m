Return-Path: <linux-kernel+bounces-214504-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0209085AD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 10:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E16511F2188F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jun 2024 08:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B101487E7;
	Fri, 14 Jun 2024 08:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V7EAs5Cb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9A11474A3
	for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 08:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718352594; cv=none; b=rFzU7zenUKo8AP4SKIxCHYT+KcWt47X3onzQSTINJ9t46g3YM1LrFbpeH4ADY4Uznfr4Em62kMdn0VGMhUkPGb3hF57ok1GxPbJsPbGAiV4pPXxx75Nf389pUvaqHFRmklzZ/U7VSGAF2g4Oo74CbWfqrXyMKXMAxyBNdNlNwkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718352594; c=relaxed/simple;
	bh=zeKU0CVwyRvivWCPaa6lgnVkTh9d9JSpkkiaiX9acpI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vz1IWqKY2ZPD7pX20WGmqt+JuDprMM6Lj8MhPEt+ZPks/En0MMnHrrt9N/zhYnveQBlmhOsgCkr8z5Fa88e3iBEO1WXPcfo0Tz3RBSPaEFAk6re6yoLFJZnS6LwKRIeFf3Yq5kfmvN0TqXpnNAv0EBY3qWFmFEsn7Iv8VwVZ5iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V7EAs5Cb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718352591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zeKU0CVwyRvivWCPaa6lgnVkTh9d9JSpkkiaiX9acpI=;
	b=V7EAs5CbAIyk436WouDKsmnB7k69dvxGMjSCOFmkNsG/5llR22gT7sutXawejNGIUDMJJs
	Dn3GM7vqdbjYrbuWGRM69g4QobqAPFmneUgxzk5M+rkxFKbaZgBvx+pgs1Vff7zZsHTBEG
	P1JSbRS9DC1hIs+0NinkefiHLeagnak=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-83-62J08O_bPzK6mwppvz3rOw-1; Fri, 14 Jun 2024 04:09:50 -0400
X-MC-Unique: 62J08O_bPzK6mwppvz3rOw-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2ebf1470cbaso2142731fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jun 2024 01:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718352588; x=1718957388;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zeKU0CVwyRvivWCPaa6lgnVkTh9d9JSpkkiaiX9acpI=;
        b=rAC59iHnmLFI+KR2MIJR2DBVNQZISzWwBQ7dDu0ViJboqBWrCF4+pKyc01euNiAeYr
         LgjuZvlAkXcw5xsKa+BSmMhdIVKwPm0EA0ZldFMJzpw1BthC7Z4BwcZDkCPWLIxLpxiR
         xZHUoVeDMN+Sf827d5mUb1c1NvVYKTqf9nvSZ1bcAN6T7MmCcKZC+fvMDiETskipKiRt
         5JTxme+W897Uu6SUctekMQRvxf8w+eKhKdghfLC5uRJ9AKARJy5lThKoJYrT4+kVsSVA
         /MkVs46VD1es0VTeMTKIJKajhieS0SDORXz463AxV6HQcJ40RYijPs+3ueCMYWMRQzPY
         Wmhg==
X-Forwarded-Encrypted: i=1; AJvYcCXvZ3EoEvLNljuRTyYfuqS/NgRhTedlur2+ceaTdCGLt2uecivosRNeIAYG/z+LhScgk1cedFWSjxpKBZtb37+gOSNYacn5EztZx70Q
X-Gm-Message-State: AOJu0Yyrfull5lQFW9ehDgkrq7PkM2iOHmQQQAfaHl9ZCYpfCYJZAADg
	6LWxIpTs5qOLKQY0ePINBV/TtPJZ7kRXkcqkm3Gx6odtV1BcfxrW5+A0Nisn11rh93eVe0Us9iu
	9iVkLrcELSlwxZFkXNLhW6nacw/UilPHWayR7qJji4tK1gkTmCrpEVJS00ixegQ==
X-Received: by 2002:a2e:3a04:0:b0:2ec:170e:5b24 with SMTP id 38308e7fff4ca-2ec170e5bdemr5016181fa.4.1718352588577;
        Fri, 14 Jun 2024 01:09:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEojhkGc53mNCU+E2IN7hi4HmtzQJ53jr3VJgck+QTx6Sd1w0/sVXdy0S6H013pzAwYnFikhQ==
X-Received: by 2002:a2e:3a04:0:b0:2ec:170e:5b24 with SMTP id 38308e7fff4ca-2ec170e5bdemr5016131fa.4.1718352588163;
        Fri, 14 Jun 2024 01:09:48 -0700 (PDT)
Received: from pstanner-thinkpadt14sgen1.remote.csb (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-422f602e0c2sm50049225e9.14.2024.06.14.01.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jun 2024 01:09:47 -0700 (PDT)
Message-ID: <5d38858130e129fd3568e97d466a4b905e864f8f.camel@redhat.com>
Subject: Re: [PATCH v9 10/13] PCI: Give pci_intx() its own devres callback
From: Philipp Stanner <pstanner@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>, Andy Shevchenko
	 <andriy.shevchenko@linux.intel.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, Bjorn Helgaas <bhelgaas@google.com>, Sam
 Ravnborg <sam@ravnborg.org>, dakr@redhat.com, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org
Date: Fri, 14 Jun 2024 10:09:46 +0200
In-Reply-To: <20240613210614.GA1081813@bhelgaas>
References: <20240613210614.GA1081813@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-06-13 at 16:06 -0500, Bjorn Helgaas wrote:
> On Thu, Jun 13, 2024 at 01:50:23PM +0200, Philipp Stanner wrote:
> > pci_intx() is one of the functions that have "hybrid mode" (i.e.,
> > sometimes managed, sometimes not). Providing a separate pcim_intx()
> > function with its own device resource and cleanup callback allows
> > for
> > removing further large parts of the legacy PCI devres
> > implementation.
> >=20
> > As in the region-request-functions, pci_intx() has to call into its
> > managed counterpart for backwards compatibility.
> >=20
> > As pci_intx() is an outdated function, pcim_intx() shall not be
> > made
> > visible to drivers via a public API.
>=20
> What makes pci_intx() outdated?=C2=A0 If it's outdated, we should mention
> why and what the 30+ callers (including a couple in drivers/pci/)
> should use instead.

That is 100% based on Andy Shevchenko's (+CC) statement back from
January 2024 a.D. [1]

Apparently INTx is "old IRQ management" and should be done through
pci_alloc_irq_vectors() nowadays.


[1] https://lore.kernel.org/all/ZabyY3csP0y-p7lb@surfacebook.localdomain/


P.


>=20
> Bjorn
>=20


