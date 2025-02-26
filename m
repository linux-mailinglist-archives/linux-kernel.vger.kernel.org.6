Return-Path: <linux-kernel+bounces-534172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A441CA463BD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:52:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13C127AC04A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD41221711;
	Wed, 26 Feb 2025 14:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQnMc1BD"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8485318C32C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 14:51:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740581511; cv=none; b=C4Bsb10yu35o+Z+YUP5JfjDNLCVnNe/hWyE3Mvc7K9qwD3ev5DOP8UJYEsLw6g29Kn1HQUUYJVr3g6gCQqYt4ss0NSlcZr7VVo9ubhQYVX8W/UvaSyr9fcir87LR6LAN7KiUBt9o6JxHeoikDUOD08BmUKR0TWcTViiOdJX5vbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740581511; c=relaxed/simple;
	bh=wCEwsl2V3nnnJWdvvQYSH2hUeveA9ELhAK1ybqU2HVE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AhtCVGcE23mpJQvqcD1l6er138yo2VSkClgTlugx8F5QAqpCrkukzBOG6SldMhOeOQS0IgOiiaczm1XrKzVRo2yU+tD5hGlUSaSrG0kDx/RSBxCunKbnw9OCpXMtO9t7CB8dclXXfCOF6R+fL8Pk9w7ilNmf+w63wsoFXs+DiEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UQnMc1BD; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740581508;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hjDcNMS3m2KvFYfCArjaQPKsyojcR0O9nS1Ii1LdD30=;
	b=UQnMc1BDaDsNwdLxhI+X9StFsobLf5tzeWj5AZ7tZiU2fF2yTBJFOo4j19nglFbJDzjgas
	SSgWJ1jsO+S6+aMXnxjOkanYxs6APcYAH/4ncdWdwL2+m+MLXFreOKO+wRgJBsJwBlVo8U
	KSTQj3s8P8hbRWaSMe2JLFKOA3smwMM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-cr_2wn_OM8OC3vmN3JiKXA-1; Wed, 26 Feb 2025 09:51:46 -0500
X-MC-Unique: cr_2wn_OM8OC3vmN3JiKXA-1
X-Mimecast-MFC-AGG-ID: cr_2wn_OM8OC3vmN3JiKXA_1740581506
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-43998ec3733so35107405e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 06:51:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740581505; x=1741186305;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hjDcNMS3m2KvFYfCArjaQPKsyojcR0O9nS1Ii1LdD30=;
        b=Bcjto4mM3VuGWpD7/t5nRtiAtKuilr+RIl35issXka6Anvg6hSEOLQOoGNHP0WdAQ7
         SXIpvvN8QhZMhEIbK7PhdZsXoDoH6UDt3ebzozxVNpjXJ4FuMjWAAUlaOGjI6gc7iJxx
         HZK46PZQ0O0rzGPYSdywT5DOmLtWoUhb9Q+ZQb+lDlPdMYtUcrcRP4wocZeGsJh94c+6
         n2rK4ZXw2T+EZ8Bvqasc7UN5UurzgMlk+tpt3pY8bKwMFitJPHPrS0BA460u5cfRdjpW
         RdsGvhOYBdAfxOeRCOv2moTa4IPYJ6ov1aHm1NEdanLw54HsboPdESX/KeRMf3SaWnk6
         R4Eg==
X-Forwarded-Encrypted: i=1; AJvYcCVcvqOHzOr1m1M0hPm/Vvg8FSe3+xYqCyJSQGMF3HpOFE1v1AuyhN6Z3h7422snOC5UWUZP1aI4AaJh5KQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpW+4YhNLyuhMGINg05i9hHFRZB6fOaj9C8hR9etj9zUyIyX7T
	qgdw9NR8dQHIqDApyxJlx2l6b8VrJ1dAnDU6/E1fhBBprbQAmiM9CXzuVygEfU91FDzUszHCxfH
	tZMd8TlubBGNBmUTuMDxeQs0jNRb3oGDdwuQ/Bv8DGuLZlb+ckCfNl6wfU0XAjA==
X-Gm-Gg: ASbGncurYk4Bl3b1c00DS4Fmvh4ab2JfM1mt6CcpLcW1luGMe/luaJ+MsTOjuBueVoI
	AWWN9sJi3lxIzuwWwRC1Iuop5PhKd+mK4exCLarOJ+9D0vBWyRxvPdsVcc74+XlzUEdiKDVSGWf
	zC497IrhK7t2Q3Jg4VWltdLhnSs4BqD2Ng0XDrHpN/uzK8Axcz/uVI8bnPQyGTXpyqqOo1Vv3f5
	Yc1EDNkWvEDAWyz6YNCTRC60kucpAKauYISuO98ZaiOqGfBJgnDb1fqovZJ7zkXLxiIN9lv3xr9
	gwQwPcs7hQnwteimSz9Q8QCGapG7/Th7qCJxNzgvH9JgDL9IYnSRRyNziI2xFK0=
X-Received: by 2002:a05:600c:4588:b0:439:88bb:d020 with SMTP id 5b1f17b1804b1-43ab0f2dcb1mr60884495e9.8.1740581505532;
        Wed, 26 Feb 2025 06:51:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGKa94atTc56+cD/Ww+Jgaq2nnB0Xu5jKGJ9ryPYaz3eiHumwOvBEgn93E/1uEp4aCSOrKpVQ==
X-Received: by 2002:a05:600c:4588:b0:439:88bb:d020 with SMTP id 5b1f17b1804b1-43ab0f2dcb1mr60884275e9.8.1740581505080;
        Wed, 26 Feb 2025 06:51:45 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390cd8e71c0sm5790989f8f.78.2025.02.26.06.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 06:51:44 -0800 (PST)
Date: Wed, 26 Feb 2025 15:51:43 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGll?=
 =?UTF-8?B?dS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Cleber Rosa <crosa@redhat.com>, Dongjiu Geng
 <gengdongjiu1@gmail.com>, Eduardo Habkost <eduardo@habkost.net>, Eric Blake
 <eblake@redhat.com>, John Snow <jsnow@redhat.com>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Shannon Zhao
 <shannon.zhaosl@gmail.com>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu
 <zhao1.liu@intel.com>, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/14] Change ghes to use HEST-based offsets and add
 support for error inject
Message-ID: <20250226155143.0e4a05f8@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250226153913.27255b1e@sal.lan>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
	<20250226151656.10665bc9@imammedo.users.ipa.redhat.com>
	<20250226153913.27255b1e@sal.lan>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Feb 2025 15:39:13 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Em Wed, 26 Feb 2025 15:16:56 +0100
> Igor Mammedov <imammedo@redhat.com> escreveu:
> 
> > On Fri, 21 Feb 2025 15:35:09 +0100
> > Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> >   
> > > Now that the ghes preparation patches were merged, let's add support
> > > for error injection.
> > > 
> > > On this series, the first 6 patches chang to the math used to calculate offsets at HEST
> > > table and hardware_error firmware file, together with its migration code. Migration tested
> > > with both latest QEMU released kernel and upstream, on both directions.
> > > 
> > > The next patches add a new QAPI to allow injecting GHESv2 errors, and a script using such QAPI
> > >    to inject ARM Processor Error records.    
> > 
> > please, run ./scripts/checkpatch on patches before submitting them.
> > as it stands now series cannot be merged due to failing checkpatch  
> 
> Weird... checkpatch is at pre-commit hook, as recommended at QEMU 
> documentation. It is actually a little harder to manage this way, as it 
> sometimes cause troubles with binary files.
> 
> Anyway, I'll run it by hand before sending the next version.

I've just applied v4 => format-patch => checkpatch
maybe I did something wrong (don't see how) but it complains overhere


PS: do not respin until I've finish this review.
 
> >   
> > > 
> > > ---
> > > v4:
> > > - added an extra comment for AcpiGhesState structure;
> > > - patches reordered;
> > > - no functional changes, just code shift between the patches in this series.
> > > 
> > > v3:
> > > - addressed more nits;
> > > - hest_add_le now points to the beginning of HEST table;
> > > - removed HEST from tests/data/acpi;
> > > - added an extra patch to not use fw_cfg with virt-10.0 for hw_error_le
> > > 
> > > v2: 
> > > - address some nits;
> > > - improved ags cleanup patch and removed ags.present field;
> > > - added some missing le*_to_cpu() calls;
> > > - update date at copyright for new files to 2024-2025;
> > > - qmp command changed to: inject-ghes-v2-error ans since updated to 10.0;
> > > - added HEST and DSDT tables after the changes to make check target happy.
> > >   (two patches: first one whitelisting such tables; second one removing from
> > >    whitelist and updating/adding such tables to tests/data/acpi)
> > > 
> > > 
> > > 
> > > Mauro Carvalho Chehab (14):
> > >   acpi/ghes: prepare to change the way HEST offsets are calculated
> > >   acpi/ghes: add a firmware file with HEST address
> > >   acpi/ghes: Use HEST table offsets when preparing GHES records
> > >   acpi/ghes: don't hard-code the number of sources for HEST table
> > >   acpi/ghes: add a notifier to notify when error data is ready
> > >   acpi/ghes: create an ancillary acpi_ghes_get_state() function
> > >   acpi/generic_event_device: Update GHES migration to cover hest addr
> > >   acpi/generic_event_device: add logic to detect if HEST addr is
> > >     available
> > >   acpi/generic_event_device: add an APEI error device
> > >   tests/acpi: virt: allow acpi table changes for a new table: HEST
> > >   arm/virt: Wire up a GED error device for ACPI / GHES
> > >   tests/acpi: virt: add a HEST table to aarch64 virt and update DSDT
> > >   qapi/acpi-hest: add an interface to do generic CPER error injection
> > >   scripts/ghes_inject: add a script to generate GHES error inject
> > > 
> > >  MAINTAINERS                                   |  10 +
> > >  hw/acpi/Kconfig                               |   5 +
> > >  hw/acpi/aml-build.c                           |  10 +
> > >  hw/acpi/generic_event_device.c                |  43 ++
> > >  hw/acpi/ghes-stub.c                           |   7 +-
> > >  hw/acpi/ghes.c                                | 231 ++++--
> > >  hw/acpi/ghes_cper.c                           |  38 +
> > >  hw/acpi/ghes_cper_stub.c                      |  19 +
> > >  hw/acpi/meson.build                           |   2 +
> > >  hw/arm/virt-acpi-build.c                      |  37 +-
> > >  hw/arm/virt.c                                 |  19 +-
> > >  hw/core/machine.c                             |   2 +
> > >  include/hw/acpi/acpi_dev_interface.h          |   1 +
> > >  include/hw/acpi/aml-build.h                   |   2 +
> > >  include/hw/acpi/generic_event_device.h        |   1 +
> > >  include/hw/acpi/ghes.h                        |  54 +-
> > >  include/hw/arm/virt.h                         |   2 +
> > >  qapi/acpi-hest.json                           |  35 +
> > >  qapi/meson.build                              |   1 +
> > >  qapi/qapi-schema.json                         |   1 +
> > >  scripts/arm_processor_error.py                | 476 ++++++++++++
> > >  scripts/ghes_inject.py                        |  51 ++
> > >  scripts/qmp_helper.py                         | 702 ++++++++++++++++++
> > >  target/arm/kvm.c                              |   7 +-
> > >  tests/data/acpi/aarch64/virt/DSDT             | Bin 5196 -> 5240 bytes
> > >  .../data/acpi/aarch64/virt/DSDT.acpihmatvirt  | Bin 5282 -> 5326 bytes
> > >  tests/data/acpi/aarch64/virt/DSDT.memhp       | Bin 6557 -> 6601 bytes
> > >  tests/data/acpi/aarch64/virt/DSDT.pxb         | Bin 7679 -> 7723 bytes
> > >  tests/data/acpi/aarch64/virt/DSDT.topology    | Bin 5398 -> 5442 bytes
> > >  29 files changed, 1677 insertions(+), 79 deletions(-)
> > >  create mode 100644 hw/acpi/ghes_cper.c
> > >  create mode 100644 hw/acpi/ghes_cper_stub.c
> > >  create mode 100644 qapi/acpi-hest.json
> > >  create mode 100644 scripts/arm_processor_error.py
> > >  create mode 100755 scripts/ghes_inject.py
> > >  create mode 100755 scripts/qmp_helper.py
> > >     
> >   
> 


