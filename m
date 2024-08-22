Return-Path: <linux-kernel+bounces-297421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3EA295B812
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 16:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C32A41C23587
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5B91CBE8F;
	Thu, 22 Aug 2024 14:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ZSV0lHCa"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBCE1CB15D
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 14:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724336031; cv=none; b=GeMvmN5klQo+6+Z0WcAF08twtxfR2L1ZCqQ2hULE/0Ywx86zjG7rA/7Da8le5H+aMpFn9Ae+hmDXKSK+p3CjKOeEMD1OJVOeQd5Yt+SETs8Npdvi73pvaqKW6URQLHSletTjCV1NhioDAqUEaF/O90oniLfvB+/VLn+cbjxyIoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724336031; c=relaxed/simple;
	bh=GYaq+MxG8yhcxgoZ1kl+qP/dBkspH7s/mmAwHM4UZNM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hHNrezghdvAuhBw2SaEVkUrthAP0aIA6RmzO91lG8EIiMlPz+86BglFvwVwqh6nLuJdxsblQHvFrW4ZPtRgUYY6xDkD0TgZoZgqhGZZAuC0Qwn2WT+wZV6aAuEE8kQkaQ7XD+bLnGQCbwZb93+cJxFMQVAPKzgt/gM2iyb8dJjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=ZSV0lHCa; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a86910caf9cso127190666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 07:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1724336026; x=1724940826; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NJnN3A3xo85nVe01BVIiv2LcPxZdBfiNlZcKruPVwls=;
        b=ZSV0lHCaIrcHuoiW1sqOFGm1BQ7VuYKdbkt4k7JndLZh4NW7KscRf3isSWzV7vaggE
         QzI+1l5X+dY6dHPMup0xYRP+W7dVOZLehOnOQif3LiwXsmgqNASDIhlpVxuGZTXoULaW
         DUdI0NIN2sk1bTfJHEY9MUqNfdItpnMyZHLkOEBBF2B6JWX0sfP/uSbiJwXwezxPL0Rn
         +f+ezw5WTMFP6mhHhqvkDesKWXyjgch5UhKb/7t3KNQYTSh3KwbpUAONKL0UCAIlPo1J
         zSn5tkD4BCMUZXHGR1Ykw4MLrLrS7F2xK0FRsdi3pUystUxvhtGr0scS3jkaEyq+rdWw
         aqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724336026; x=1724940826;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJnN3A3xo85nVe01BVIiv2LcPxZdBfiNlZcKruPVwls=;
        b=oAyZIQGeCYg69y5N3WNk9IAccIF1RArgNRVxZ+Tr02wie2IGp9bhpDWWmJfki+rihn
         pqPbI6rz+Oe0wpbqvKb3O6tJ0BEuXW10rbTaTBhi+WAb25mv0B3jERkYH0CcuoQ/LLH+
         y30PJMa6By7hRdFCEk5LxdNCiDKxTJCvqZC1xYloDbC7ULSfRAdwqJNWe86E4jFKSzer
         O01MZklu0aF6e85sc2ISS/933QdHMycAxcJadsVZ6eETV//2UYNcXL5xkdG1fMoiu0Sm
         R+l3sRJW15Cc2UWbCbvNV+ct9Kp4zkFqZv7xd8DbfnULCawWz0KsMrePefHKH52NJDbW
         ABvg==
X-Forwarded-Encrypted: i=1; AJvYcCXS1Z6N7H/KrA/Pu57Cr9QBrSNrUvbjm67GTTprlfgiW7ZjBmRIIzCNAzp4nYGg1yRqnt+JIrxOKwHq38s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcDYFwu7j07MJDo0jI849foT13WVQs5W9SGVoi+n4a3BUeLsoq
	6MkSOxT0Lj3MuewBO5Z3XQ/4GsAF64U5gol7v79+xuKTmoBhYlmO5gTzduxImEc=
X-Google-Smtp-Source: AGHT+IGj/XlqDCQK8puMTtLkkNZtL+0lMaXAygNVS1fY0ac52D3TBvA1TbWtFFq7XPu/ONazyumUdA==
X-Received: by 2002:a17:907:72d4:b0:a77:cdae:6a59 with SMTP id a640c23a62f3a-a868a84f205mr327697066b.21.1724336025287;
        Thu, 22 Aug 2024 07:13:45 -0700 (PDT)
Received: from localhost (37-48-50-18.nat.epc.tmcz.cz. [37.48.50.18])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4f38c4sm125073866b.191.2024.08.22.07.13.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 07:13:44 -0700 (PDT)
Date: Thu, 22 Aug 2024 16:13:43 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Geetha sowjanya <gakula@marvell.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kuba@kernel.org,
	davem@davemloft.net, pabeni@redhat.com, edumazet@google.com,
	sgoutham@marvell.com, sbhatta@marvell.com, hkelam@marvell.com
Subject: Re: [net-next PATCH v11 00/11] Introduce RVU representors
Message-ID: <ZsdHl487u9jHmz-z@nanopsycho.orion>
References: <20240822132031.29494-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822132031.29494-1-gakula@marvell.com>

Thu, Aug 22, 2024 at 03:20:20PM CEST, gakula@marvell.com wrote:
>This series adds representor support for each rvu devices.
>When switchdev mode is enabled, representor netdev is registered
>for each rvu device. In implementation of representor model, 
>one NIX HW LF with multiple SQ and RQ is reserved, where each
>RQ and SQ of the LF are mapped to a representor. A loopback channel
>is reserved to support packet path between representors and VFs.
>CN10K silicon supports 2 types of MACs, RPM and SDP. This
>patch set adds representor support for both RPM and SDP MAC
>interfaces.
>
>- Patch 1: Refactors and exports the shared service functions.
>- Patch 2: Implements basic representor driver.
>- Patch 3: Add devlink support to create representor netdevs that
>  can be used to manage VFs.
>- Patch 4: Implements basec netdev_ndo_ops.
>- Patch 5: Installs tcam rules to route packets between representor and
>	   VFs.
>- Patch 6: Enables fetching VF stats via representor interface
>- Patch 7: Adds support to sync link state between representors and VFs .
>- Patch 8: Enables configuring VF MTU via representor netdevs.
>- Patch 9: Add representors for sdp MAC.
>- Patch 10: Add devlink port support.
>
>
>Command to create PF/VF representor
>#devlink dev eswitch set pci/0002:1c:00.0 mode switchdev
>
>VF representors are created for each VF when switch mode is set switchdev on
>representor PCI device. Each PF support upto 3VFs. Representor can be created
>before or after the VFs creation. 

What do you mean by the last sentence? I don't understand it.

>
>#devlink dev
>pci/0002:1c:00.0
>
>#devlink dev eswitch set pci/0002:1c:00.0 mode switchdev
>
># ip link show
>	pf1vf0rep: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000 link/ether 7e:5a:66:ea:fe:d6 brd ff:ff:ff:ff:ff:ff
>	pf1vf1rep: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000 link/ether de:29:be:10:9e:bf brd ff:ff:ff:ff:ff:ff
>	pf1vf2rep: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000 link/ether 4a:12:c7:a2:66:ad brd ff:ff:ff:ff:ff:ff
>	pf1vf3rep: <BROADCAST,MULTICAST> mtu 1500 qdisc noop state DOWN mode DEFAULT group default qlen 1000 link/ether c2:b8:a8:0e:73:fd brd ff:ff:ff:ff:ff:ff

Where do you have physical port netdev? Looks like all macs are made up.
I would expect the phisical port netdev to have some fixed vendor-based
mac.


>
>
>~# devlink port
>pci/0002:1c:00.0/0: type eth netdev pf1vf0rep flavour physical port 1 splittable false

vf0? What does it mean? Could you please let udev do it's work and let
it rename netdevices properly?


>pci/0002:1c:00.0/1: type eth netdev pf1vf1rep flavour pcivf controller 0 pfnum 1 vfnum 1 external false splittable false

Do you have pf 0 or you start with 1? If yes, why?


>pci/0002:1c:00.0/2: type eth netdev pf1vf2rep flavour pcivf controller 0 pfnum 1 vfnum 2 external false splittable false
>pci/0002:1c:00.0/3: type eth netdev pf1vf3rep flavour pcivf controller 0 pfnum 1 vfnum 3 external false splittable false
>
>-----------
>v1-v2:
> -Fixed build warnings.
> -Address review comments provided by "Kalesh Anakkur Purayil".
>
>v2-v3:
> - Used extack for error messages.
> - As suggested reworked commit messages.
> - Fixed sparse warning.
>
>v3-v4: 
> - Patch 2 & 3: Fixed coccinelle reported warnings.
> - Patch 10: Added devlink port support.
>
>v4-v5:
>  - Patch 3: Removed devm_* usage in rvu_rep_create()
>  - Patch 3: Fixed build warnings.
>
>v5-v6:
>  - Addressed review comments provided by "Simon Horman".
>  - Added review tag. 
>
>v6-v7:
>  - Rebased on top net-next branch.
>
>v7-v8:
>   - Implemented offload stats ndo.
>   - Added documentation.
>
>v8-v9:
>   - Updated the documentation.
>
>v9-v10:
>  - Fixed build warning w.r.t documentation.
>
>v10-v11:
>  - As suggested by "Jiri Pirko" adjusted the documentation.
>  - Added more commit description to patch1. 
>
>Geetha sowjanya (11):
>  octeontx2-pf: Refactoring RVU driver
>  octeontx2-pf: RVU representor driver
>  octeontx2-pf: Create representor netdev
>  octeontx2-pf: Add basic net_device_ops
>  octeontx2-af: Add packet path between representor and VF
>  octeontx2-pf: Get VF stats via representor
>  octeontx2-pf: Add support to sync link state between representor and
>    VFs
>  octeontx2-pf: Configure VF mtu via representor
>  octeontx2-pf: Add representors for sdp MAC
>  octeontx2-pf: Add devlink port support
>  octeontx2-pf: Implement offload stats ndo for representors
>
> .../ethernet/marvell/octeontx2.rst            |  85 ++
> .../net/ethernet/marvell/octeontx2/Kconfig    |   8 +
> .../ethernet/marvell/octeontx2/af/Makefile    |   3 +-
> .../ethernet/marvell/octeontx2/af/common.h    |   2 +
> .../net/ethernet/marvell/octeontx2/af/mbox.h  |  74 ++
> .../net/ethernet/marvell/octeontx2/af/npc.h   |   1 +
> .../net/ethernet/marvell/octeontx2/af/rvu.c   |  11 +
> .../net/ethernet/marvell/octeontx2/af/rvu.h   |  30 +-
> .../marvell/octeontx2/af/rvu_debugfs.c        |  27 -
> .../marvell/octeontx2/af/rvu_devlink.c        |   6 +
> .../ethernet/marvell/octeontx2/af/rvu_nix.c   |  81 +-
> .../marvell/octeontx2/af/rvu_npc_fs.c         |   5 +
> .../ethernet/marvell/octeontx2/af/rvu_reg.h   |   4 +
> .../ethernet/marvell/octeontx2/af/rvu_rep.c   | 464 +++++++++++
> .../marvell/octeontx2/af/rvu_struct.h         |  26 +
> .../marvell/octeontx2/af/rvu_switch.c         |  20 +-
> .../ethernet/marvell/octeontx2/nic/Makefile   |   2 +
> .../ethernet/marvell/octeontx2/nic/cn10k.c    |   4 +-
> .../ethernet/marvell/octeontx2/nic/cn10k.h    |   2 +-
> .../marvell/octeontx2/nic/otx2_common.c       |  58 +-
> .../marvell/octeontx2/nic/otx2_common.h       |  84 +-
> .../marvell/octeontx2/nic/otx2_devlink.c      |  49 ++
> .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 305 ++++---
> .../marvell/octeontx2/nic/otx2_txrx.c         |  38 +-
> .../marvell/octeontx2/nic/otx2_txrx.h         |   3 +-
> .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  19 +-
> .../net/ethernet/marvell/octeontx2/nic/rep.c  | 744 ++++++++++++++++++
> .../net/ethernet/marvell/octeontx2/nic/rep.h  |  53 ++
> 28 files changed, 1981 insertions(+), 227 deletions(-)
> create mode 100644 drivers/net/ethernet/marvell/octeontx2/af/rvu_rep.c
> create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.c
> create mode 100644 drivers/net/ethernet/marvell/octeontx2/nic/rep.h
>
>-- 
>2.25.1
>

