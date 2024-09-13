Return-Path: <linux-kernel+bounces-327623-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25791977873
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 07:44:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F6D31C243E0
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Sep 2024 05:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6375818734B;
	Fri, 13 Sep 2024 05:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hf/KJz4j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ECD154BE9
	for <linux-kernel@vger.kernel.org>; Fri, 13 Sep 2024 05:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726206280; cv=none; b=W+livkJzenhYiRH5N+nOVVDAi8ACLD687UjrOLfFylKGryvto98ZZ94bAhFI12Ri4wHXaaudja0mwNVM45Ao7UU9pxY+sNMjJdVZG8fhRkNtYIKcUhIHCvr3t1VxSY2c+fGdspAmBYFD1uY034V242aMsiE1vPt6D1d4RGtr23k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726206280; c=relaxed/simple;
	bh=iKzgzGmY8jMu1CwEhb0AyXIHtqm8tqncg+1CM1dtqwg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LcVYygzcPNx2pjwfRNfduzrcPrq3lxpoOlMxYgqdwEx5ZW8J0S9oS0Q2gQWMq2s3aM4OGa4ebz0YKrxEKRCD2kFXPuIU/7GIqi3Kdp5oqhjxjUfFaoa+LuhbUxxMMh1K+VAzYIAmkHUv4vsaPKre01xm36nzCqTyf0W2qMX6gJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hf/KJz4j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B3CC4CEC0;
	Fri, 13 Sep 2024 05:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726206280;
	bh=iKzgzGmY8jMu1CwEhb0AyXIHtqm8tqncg+1CM1dtqwg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Hf/KJz4j4hKC4Ja9D5/QgWhMDl+fvOcuTW8qYX2IvPuOdV3iWrWsawOr8ieUV8Om8
	 ZKVjyr8PRMhjrlBWfM9nTkh/nFK+30c4ImxN6q6K/nDO0pNMdBp1dUalkvbAqczSRr
	 2l20CCMxapyaSBMd0OkstE+RNnTWnFnCYp0RiAJZ3VsMLZ4cYIGV15yWOg2m8OzRXS
	 EH6GP57tA5xXrNc5CnCDqf/Qp3rjbyFHH2oLaF9IZRUYlkJDAHR5GUFK8B1o1u38q0
	 ha5jFXHG5MrODCBqPH7vpMDR7xbXrO6QpVo7HpRS3xhX7fnfO5Q/VPB12eHhrWF6S5
	 +3wAQ4ymJLUxQ==
Date: Fri, 13 Sep 2024 07:44:35 +0200
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, linux-kernel@vger.kernel.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v9 01/12] acpi/ghes: add a firmware file with HEST
 address
Message-ID: <20240913074435.0eea2552@foz.lan>
In-Reply-To: <20240911155108.190f0fdf@imammedo.users.ipa.redhat.com>
References: <cover.1724556967.git.mchehab+huawei@kernel.org>
	<34dd38395f29f57a19aef299bafdff9442830ed3.1724556967.git.mchehab+huawei@kernel.org>
	<20240911155108.190f0fdf@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Wed, 11 Sep 2024 15:51:08 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> On Sun, 25 Aug 2024 05:45:56 +0200
> Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:
> 
> > Store HEST table address at GPA, placing its content at
> > hest_addr_le variable.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>  
> 
> This looks good to me.
> 
> in addition to this, it needs a patch on top to make sure
> that we migrate hest_addr_le.
> See a08a64627b6b 'ACPI: Record the Generic Error Status Block address'
> and fixes on top of that for an example.

Hmm... If I understood such change well, vmstate_ghes_state() will
use this structure as basis to do migration:

	/* ghes.h */
	typedef struct AcpiGhesState {
	    uint64_t hest_addr_le;
	    uint64_t ghes_addr_le;
	    bool present; /* True if GHES is present at all on this board */
	} AcpiGhesState;

	/* generic_event_device.c */
	static const VMStateDescription vmstate_ghes_state = {
	    .name = "acpi-ged/ghes",
	    .version_id = 1,
	    .minimum_version_id = 1,
	    .needed = ghes_needed,
	    .fields      = (VMStateField[]) {
	        VMSTATE_STRUCT(ghes_state, AcpiGedState, 1,
	                       vmstate_ghes_state, AcpiGhesState),
	        VMSTATE_END_OF_LIST()
	    }
	};

	/* hw/arm/virt-acpi-build.c */
	void virt_acpi_setup(VirtMachineState *vms)
	{
	    ...
	    if (vms->ras) {
	        assert(vms->acpi_dev);
	        acpi_ged_state = ACPI_GED(vms->acpi_dev);
	        acpi_ghes_add_fw_cfg(&acpi_ged_state->ghes_state,
	                             vms->fw_cfg, tables.hardware_errors);
	    }

Which relies on acpi_ghes_add_fw_cfg() function to setup callbacks for
the migration:

	/* ghes.c */
	void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
	                          GArray *hardware_error)
	{
	    /* Create a read-only fw_cfg file for GHES */
	    fw_cfg_add_file(s, ACPI_HW_ERROR_FW_CFG_FILE, hardware_error->data,
	                    hardware_error->len);

	    /* Create a read-write fw_cfg file for Address */
	    fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
	        NULL, &(ags->ghes_addr_le), sizeof(ags->ghes_addr_le), false);

	    fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
	        NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);

	    ags->present = true;
	}

It sounds to me that both ghes_addr_le and hest_addr_le will be migrated
altogether.

Did I miss something?

Thanks,
Mauro

