Return-Path: <linux-kernel+bounces-406118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578A59C5B1D
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 15:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17AA328140E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Nov 2024 14:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76C62003B4;
	Tue, 12 Nov 2024 14:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eNexm47M"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AF41FEFA8
	for <linux-kernel@vger.kernel.org>; Tue, 12 Nov 2024 14:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731423364; cv=none; b=gVganjPsN0P9JHtwSK6xF+0RSidEk+sblsm4u06mUVFWVrrRwAVfdSk7AgrJVGWw7KD2sRihle7sswBUO+z/GNOkF2XhyNUG18ab1fcB9b54l+B8vd/bQmQOK3Dkx8MHtT7H1Itr8JcgVstZ/GLu7fBFzJj6ToTEeiynQ27ATHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731423364; c=relaxed/simple;
	bh=oU0WT5/i3G7DgaZFfeTwlebnKhTrhz/oUuWCQQ+C2zI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GmqODXBs65uYpnItbaAVLIndBsHPXCNk+W2ts4Y/4rrSAH0sP0WGLFgbvDKjJlaYG7laJXjm3zAPc8HLo1gMGail1z/ehHWGAySbvQPWAGZ3qMd4FZI4hkYoLt1x/96HdONMoWkXhlYx3b7oaJk6slSW3HmAIeWnAC7bC9FcmAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eNexm47M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD57BC4CECD;
	Tue, 12 Nov 2024 14:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731423363;
	bh=oU0WT5/i3G7DgaZFfeTwlebnKhTrhz/oUuWCQQ+C2zI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eNexm47MHFR9yA3McgFEbNtXfHkqJp+LW94rfLh6BILY48emzUcmNfFWVcpNH7zez
	 6NKIYByZvzTBJ+8pY7FLgs1xOuAgRtyjE2RBcBBBYHd3XuSDFZFmw9zU3d2oYOm8HG
	 hGyjXJm28pSRCH3bsBxpFTplq1ps5LIhb3AWrlKLnMPo7DuPfDzWZ/+agynXHo3NZe
	 pmlpc2/xkjRKJfxJGfFylVAEw/E6Fyte1/mXBrFTKV5AF3+7P9zGiq0oMkB2zVwqny
	 KynplvKzCsjbVDip1YMwapktTmtkAHXCtaCOQegwJZqDwuxEi2Yy6Vpccl/AjABxPU
	 nNGRZ30mw5mgg==
Date: Tue, 12 Nov 2024 15:55:57 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>, Eduardo
 Habkost <eduardo@habkost.net>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, Yanan Wang <wangyanan55@huawei.com>, Zhao Liu
 <zhao1.liu@intel.com>, linux-kernel@vger.kernel.org, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 4/5] acpi/generic_event_device: add logic to detect
 if HEST addr is available
Message-ID: <20241112155557.728e9d68@foz.lan>
In-Reply-To: <20241003162728.1de6fc62@imammedo.users.ipa.redhat.com>
References: <cover.1727782588.git.mchehab+huawei@kernel.org>
	<176693e011a411db92be9e912bfc4a9da0e664b7.1727782588.git.mchehab+huawei@kernel.org>
	<20241003162728.1de6fc62@imammedo.users.ipa.redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Thu, 3 Oct 2024 16:27:28 +0200
Igor Mammedov <imammedo@redhat.com> escreveu:

> > +++ b/hw/acpi/ghes.c
> > @@ -513,7 +513,7 @@ void ghes_record_cper_errors(const void *cper, size_t len,
> >      }
> >      ags = &acpi_ged_state->ghes_state;
> >  
> > -    if (!ags->hest_addr_le) {
> > +    if (!ags->hest_lookup) {
> >          get_ghes_offsets(le64_to_cpu(ags->hw_error_le),
> >                           &cper_addr, &read_ack_register_addr);  
> 
> just fencing off lookup is not enough,
> to be compatible with qemu-9.1 (virt-9.1) we also should not publish hest_addr fwcfg.

I tried this:

diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 201e72516608..6bb962d3c449 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -402,8 +402,10 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
     fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
         NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
 
-    fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
-        NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
+    if (ags->hest_lookup) {
+        fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
+            NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
+    }
 
     ags->present = true;
 }

But with such change, boot fails:

EFI stub: Booting Linux Kernel...
UpdateRegionMappingRecursive(0): DF100000 - E1B90000 set 400 clr FF9F000000000B3F
UpdateRegionMappingRecursive(1): DF100000 - E1B90000 set 400 clr FF9F000000000B3F
UpdateRegionMappingRecursive(2): C0000000 - 100000000 set 6000000000070C clr 0
UpdateRegionMappingRecursive(2): DF100000 - E1B90000 set 400 clr FF9F000000000B3F
UpdateRegionMappingRecursive(3): DF000000 - DF200000 set 6000000000070C clr 0
UpdateRegionMappingRecursive(3): DF100000 - DF200000 set 400 clr FF9F000000000B3F
UpdateRegionMappingRecursive(3): E1A00000 - E1C00000 set 6000000000070C clr 0
UpdateRegionMappingRecursive(3): E1A00000 - E1B90000 set 400 clr FF9F000000000B3F
EFI stub: Generating empty DTB
EFI stub: Exiting boot services...
UpdateRegionMappingRecursive(0): 139AC1000 - 139CD0000 set 400 clr FF9F000000000B3F
UpdateRegionMappingRecursive(1): 139AC1000 - 139CD0000 set 400 clr FF9F000000000B3F
UpdateRegionMappingRecursive(2): 139AC1000 - 139CD0000 set 400 clr FF9F000000000B3F
UpdateRegionMappingRecursive(3): 139A00000 - 139C00000 set 6000000000070C clr 0
UpdateRegionMappingRecursive(3): 139AC1000 - 139C00000 set 400 clr FF9F000000000B3F
UpdateRegionMappingRecursive(3): 139C00000 - 139CD0000 set 400 clr FF9F000000000B3F
UpdateRegionMappingRecursive(0): 139AC1000 - 139AD0000 set 60000000000400 clr FF9F000000000B3F
UpdateRegionMappingRecursive(1): 139AC1000 - 139AD0000 set 60000000000400 clr FF9F000000000B3F
UpdateRegionMappingRecursive(2): 139AC1000 - 139AD0000 set 60000000000400 clr FF9F000000000B3F
UpdateRegionMappingRecursive(3): 139AC1000 - 139AD0000 set 60000000000400 clr FF9F000000000B3F
SetUefiImageMemoryAttributes - 0x000000013FE60000 - 0x0000000000040000 (0x0000000000000008)
UpdateRegionMappingRecursive(0): 13FE60000 - 13FEA0000 set 70C clr 0
UpdateRegionMappingRecursive(1): 13FE60000 - 13FEA0000 set 70C clr 0
UpdateRegionMappingRecursive(2): 13FE60000 - 13FEA0000 set 70C clr 0
UpdateRegionMappingRecursive(3): 13FE60000 - 13FEA0000 set 70C clr 0
SetUefiImageMemoryAttributes - 0x000000013CAF0000 - 0x0000000000040000 (0x0000000000000008)
UpdateRegionMappingRecursive(0): 13CAF0000 - 13CB30000 set 70C clr 0
UpdateRegionMappingRecursive(1): 13CAF0000 - 13CB30000 set 70C clr 0
UpdateRegionMappingRecursive(2): 13CAF0000 - 13CB30000 set 70C clr 0
UpdateRegionMappingRecursive(3): 13CAF0000 - 13CB30000 set 70C clr 0
SetUefiImageMemoryAttributes - 0x000000013CAA0000 - 0x0000000000040000 (0x0000000000000008)
UpdateRegionMappingRecursive(0): 13CAA0000 - 13CAE0000 set 70C clr 0
UpdateRegionMappingRecursive(1): 13CAA0000 - 13CAE0000 set 70C clr 0
UpdateRegionMappingRecursive(2): 13CAA0000 - 13CAE0000 set 70C clr 0
UpdateRegionMappingRecursive(3): 13CAA0000 - 13CAE0000 set 70C clr 0
SetUefiImageMemoryAttributes - 0x000000013CA50000 - 0x0000000000040000 (0x0000000000000008)
UpdateRegionMappingRecursive(0): 13CA50000 - 13CA90000 set 70C clr 0
UpdateRegionMappingRecursive(1): 13CA50000 - 13CA90000 set 70C clr 0
UpdateRegionMappingRecursive(2): 13CA50000 - 13CA90000 set 70C clr 0
UpdateRegionMappingRecursive(3): 13CA50000 - 13CA90000 set 70C clr 0
SetUefiImageMemoryAttributes - 0x000000013C960000 - 0x0000000000040000 (0x0000000000000008)
UpdateRegionMappingRecursive(0): 13C960000 - 13C9A0000 set 70C clr 0
UpdateRegionMappingRecursive(1): 13C960000 - 13C9A0000 set 70C clr 0
UpdateRegionMappingRecursive(2): 13C960000 - 13C9A0000 set 70C clr 0
UpdateRegionMappingRecursive(3): 13C960000 - 13C9A0000 set 70C clr 0
SetUefiImageMemoryAttributes - 0x000000013FE20000 - 0x0000000000030000 (0x0000000000000008)
UpdateRegionMappingRecursive(0): 13FE20000 - 13FE50000 set 70C clr 0
UpdateRegionMappingRecursive(1): 13FE20000 - 13FE50000 set 70C clr 0
UpdateRegionMappingRecursive(2): 13FE20000 - 13FE50000 set 70C clr 0
UpdateRegionMappingRecursive(3): 13FE20000 - 13FE50000 set 70C clr 0
SetUefiImageMemoryAttributes - 0x000000013C7B0000 - 0x0000000000030000 (0x0000000000000008)
UpdateRegionMappingRecursive(0): 13C7B0000 - 13C7E0000 set 70C clr 0
UpdateRegionMappingRecursive(1): 13C7B0000 - 13C7E0000 set 70C clr 0
UpdateRegionMappingRecursive(2): 13C7B0000 - 13C7E0000 set 70C clr 0
UpdateRegionMappingRecursive(3): 13C7B0000 - 13C7E0000 set 70C clr 0
SetUefiImageMemoryAttributes - 0x000000013C770000 - 0x0000000000030000 (0x0000000000000008)
UpdateRegionMappingRecursive(0): 13C770000 - 13C7A0000 set 70C clr 0
UpdateRegionMappingRecursive(1): 13C770000 - 13C7A0000 set 70C clr 0
UpdateRegionMappingRecursive(2): 13C770000 - 13C7A0000 set 70C clr 0
UpdateRegionMappingRecursive(3): 13C770000 - 13C7A0000 set 70C clr 0

At this point, nothing else appears, and bios doesn't boot OSPM. 

(I'm using an arm64 BIOS with debug enabled)

Thanks,
Mauro

