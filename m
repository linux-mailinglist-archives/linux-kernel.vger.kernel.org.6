Return-Path: <linux-kernel+bounces-565150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CB743A661C9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 23:39:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA901777FC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 22:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B19204879;
	Mon, 17 Mar 2025 22:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gWshK70t"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284291EB5F0
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 22:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742251149; cv=none; b=fXPvhdsLlNLol7OfVB2jq3U/5EQ9aryPPXN5Y1PlvQ1DJq4i4hr23HofcvX1BhNuQZkYAQ6Z9HHE3dihBfbx1oGZ/2/cMV0P7QWzEkyxsXcfl4ii4sxRQNlo9A2vcYDGMp+hc67qifEx+OD5LYLDAYMd77YZ8F/o/I2JfTmRgcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742251149; c=relaxed/simple;
	bh=mquX9i7pAQ/himAy6+VWYSp1OgDbQoyAvlhyricqX+o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I6/qmz/lxZk5OvhMWLj/TN8TXc64zMKbVOo4p7aSZLjAu/Rtmq8BjQfUzvXyFY9Rg4fqmLqDMRq2CRoCUmdGdy60T1mSOcu6gQCVImlJyCUCZjCjq+6BXEHX2HSlJLfvvH3uLQDQbhkNkE5abKSedIy8goOr3/oDdsc8KBOt1ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gWshK70t; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1742251147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JmYgdowPoipn2eB0gwBS5Rlmh9/HbjoRVzD1SOShhrs=;
	b=gWshK70tnIMr6avvIZw6WK+tl7EHEjLXqbc1lMyHUdufs4pUMtqih2GFb9CpGfiwOaeZei
	6u7GvhQONzmaavZyjYLgX10M8tn48Qr8h2FsPnP2Pp6vuJdFPJ/rGUZTE0mEobk7Y6iNf+
	IHg0scg4ci0FjqeDg8vebgPqBL8OhwU=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-561-kHm0FK-lPLeHScjwiQQ8uA-1; Mon, 17 Mar 2025 18:39:05 -0400
X-MC-Unique: kHm0FK-lPLeHScjwiQQ8uA-1
X-Mimecast-MFC-AGG-ID: kHm0FK-lPLeHScjwiQQ8uA_1742251145
Received: by mail-oa1-f69.google.com with SMTP id 586e51a60fabf-2c1bdffc6b1so529741fac.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 15:39:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742251145; x=1742855945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JmYgdowPoipn2eB0gwBS5Rlmh9/HbjoRVzD1SOShhrs=;
        b=eRiMknQlxYZPitSKh9cv17NgBiHKEyxYnFlz9zOXhU3gUh72Q/xDZH84M6qwyFaHdI
         ipLAfnhI3MUGk6/+cRazNdSlQg5fU2/9gWP/0YEgwjUxD0CPTLgFyBaM6DvSRZivSyBn
         hMdu489H/bptYW3qoTBr7/T9pfL+/O7KzMVDff+/7JTSWNFP2lyTgZwpuqBazzOWIg46
         83/kl2UGb1nKZxqvcZJhJgSrfJR0WAxOmK97TJP940dW50tE1Plzu753EI6Y0EKFV9Kv
         FBBIVMaBcU4XkEiYrtduWC6x90vHQmoqGjUW5b4QbEoIO8e11LcXP/S3nHj468zhzCJZ
         VoVQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7XfY8KiiLlbe19D6z3xu9kyqhCOwRDqUlkl5mIBKkVapyv/ous6z5pz3zcJiu1EueXuKHJ2f9D7iAePo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgV3SKorek6s9X9Ab8Cdvjh5ST3VpWhmWEr5khI9MRIHy4MNeq
	2nySAQ15nj9qXZE4zHdXB+jXpiJZmAFrtyXlBiKn5rvWX8+a0X2SiAJLrTcwFvELXC3FohjOAvJ
	7XyOJ4o7rDvsGfdZQZeso3dHC5gqDPa4WHjR6MM20daXoSHGJVhdqdCz/pduQQw==
X-Gm-Gg: ASbGnctgjBtPVy0utFhqnkWRz9lkeyhh8p1oMFSR04g98AFahpBqfJBro0oTyjqQsY7
	Dg7kFmVtOQqXd2KlRAMUxwcW8x4gS1WMKavq0SUCe8AWXNtvLUz9uMM6oJXDa4n84cH/fzEFrqg
	hW7l4YY9u3gVdrjBdxaPokupqCuWDdO3HDRpDJ1ieV6gKS1qcHdm1zoZnfIFUGMZ4bwpZWph9nQ
	cvzpXjBEatOTs3jetJ4N4MmuKaRBzKyuVioWJvNZd5/+00huuOaQsauiUpYxq6LtsB1LS4KZCWN
	+pF+K7RHsQgpNp3emzI=
X-Received: by 2002:a05:6820:270a:b0:600:2729:25ba with SMTP id 006d021491bc7-601e45be988mr2442911eaf.1.1742251144856;
        Mon, 17 Mar 2025 15:39:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFbsNciZRw/nFluLflYZvQyGShPH55bNzYgUMAisb3ebrP4tjURZQuOYf8gabdM+YWR7SpgVg==
X-Received: by 2002:a05:6820:270a:b0:600:2729:25ba with SMTP id 006d021491bc7-601e45be988mr2442906eaf.1.1742251144509;
        Mon, 17 Mar 2025 15:39:04 -0700 (PDT)
Received: from redhat.com ([38.15.36.11])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-601e4f41f85sm1426282eaf.16.2025.03.17.15.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 15:39:02 -0700 (PDT)
Date: Mon, 17 Mar 2025 16:38:59 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: =?UTF-8?B?TWljaGHFgg==?= Winiarski <michal.winiarski@intel.com>
Cc: Ilpo =?UTF-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, "Bjorn
 Helgaas" <bhelgaas@google.com>, Christian =?UTF-8?B?S8O2bmln?=
 <christian.koenig@amd.com>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] PCI: Fix BAR resizing when VF BARs are assigned
Message-ID: <20250317163859.671a618f.alex.williamson@redhat.com>
In-Reply-To: <kgoycgt2rmf3cdlqdotkhuov7fkqfk2zf7dbysgwvuipsezxb4@dokqn7xrsdvz>
References: <20250307140349.5634-1-ilpo.jarvinen@linux.intel.com>
	<20250314085649.4aefc1b5.alex.williamson@redhat.com>
	<kgoycgt2rmf3cdlqdotkhuov7fkqfk2zf7dbysgwvuipsezxb4@dokqn7xrsdvz>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Mar 2025 19:18:03 +0100
Micha=C5=82 Winiarski <michal.winiarski@intel.com> wrote:

> On Fri, Mar 14, 2025 at 08:56:49AM -0600, Alex Williamson wrote:
> > On Fri,  7 Mar 2025 16:03:49 +0200
> > Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com> wrote:
> >  =20
> > > __resource_resize_store() attempts to release all resources of the
> > > device before attempting the resize. The loop, however, only covers
> > > standard BARs (< PCI_STD_NUM_BARS). If a device has VF BARs that are
> > > assigned, pci_reassign_bridge_resources() finds the bridge window sti=
ll
> > > has some assigned child resources and returns -NOENT which makes
> > > pci_resize_resource() to detect an error and abort the resize.
> > >=20
> > > Change the release loop to cover all resources up to VF BARs which
> > > allows the resize operation to release the bridge windows and attempt
> > > to assigned them again with the different size.
> > >=20
> > > As __resource_resize_store() checks first that no driver is bound to
> > > the PCI device before resizing is allowed, SR-IOV cannot be enabled
> > > during resize so it is safe to release also the IOV resources. =20
> >=20
> > Is this true?  pci-pf-stub doesn't teardown SR-IOV on release, which I
> > understand is done intentionally.  Thanks, =20
>=20
> Is that really intentional?
> PCI warns when that scenario occurs:
> https://elixir.bootlin.com/linux/v6.13.7/source/drivers/pci/iov.c#L936

Yep, it warns.  It doesn't prevent it from happening though.

> I thought that the usecase is binding pci-pf-stub, creating VFs, and
> letting the driver be.
> But unbinding after creating VFs? What's the goal of that?
> Perhaps we're just missing .remove() in pci-pf-stub?

I guess I don't actually know that leaving SR-IOV enabled was
intentional, maybe it was an oversight.  The original commit only
mentions the case of a device that requires nothing but this shim as
the PF driver.  A pci_warn() isn't much disincentive, the system might
already have taints.  If it's something that we really want to show as
broken, it'd probably need to be a WARN_ON.  Thanks,

Alex


