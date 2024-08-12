Return-Path: <linux-kernel+bounces-283173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4483C94EE32
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 15:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B01EE1F234D4
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Aug 2024 13:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AEEF17F389;
	Mon, 12 Aug 2024 13:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NEZWHxhL"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8CF170A0D
	for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723469502; cv=none; b=gD4oO5Puo7qkGfY3OYFK0ijXJXIPGr/VV8fZ0xVTNBZ4hLS9zFO53e7uHQ/YZoJt5oT/YVVFMeZx7hIDPY5rI/jU0sG5FAhkMH98uk5eQ0iNL1aRP27Qefj75HzIlufA5mgblhnh2tA79fcIxmPoAPSVdWh1xRCwz0K/XgTvMN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723469502; c=relaxed/simple;
	bh=K5V484RyALc3308fpZL+AQDi2DuiwCFWwAW9jY+Sbko=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=qdwzMM8HCRDLgUYeYrUyTJi/Ee2dpJ6i4Y9s+m0xr1DHiDFOT/qcpQK2Mxy0CHVMJyD0ne87bGltuQIKmSC4jbqa7EvUJD/85dnCDPRnAWWVSXK6UmKUbiSckc8EKJh8cWkvSTcyotO75FIicmGf1PVX/Hi/iD7SYlxrGRkLQBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NEZWHxhL; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a7a94478a4eso859079766b.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2024 06:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723469498; x=1724074298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rdquB3fxGeyVcKrSNh9Xx76eJnQsmESD3J/hVVucRtM=;
        b=NEZWHxhL6GJ7KPbyHp2qDYeqgg1V5PpaYr2jup9tTtTn0xKyZa/D+Oem3Jc2dkhoLn
         px7sbIhTRYDWiT2dhzoo8d646wD8Q4iwHY+8lDpACMZMQ6D+ewKymVko7yeN9FW9egdU
         EcNXMIO/xBuI56bcfy04ajq505SxraTUvIhOD5rTfIgETs8GyBsrxAgh2lqI89fAXlV8
         oTM7h2SVHkbPNZBqQ9Li2BgGWkumEHeOI36pwzEt7bUIPSkS0PRNnZSbTA7Q0nBbZEZt
         K9VsTDG+yPvPvCzJpym8Q+y63VKP5xzo3MHsp/P1vH6RTdxyLrCSt4vD4rUv+NYuhxUz
         uXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723469498; x=1724074298;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rdquB3fxGeyVcKrSNh9Xx76eJnQsmESD3J/hVVucRtM=;
        b=c62mPDB24C5njz94lPbXfHnvQYcObEIcsa5mH8b7xHSPzTg1TKKoA/RycCq1B+UrIl
         mxsvU83TSsgvP0hlOe/8VAr7cqUJWGqYKh8276jJyXDvuqku0ZAJcfrG96dhHpW/sqKC
         ysV3Pmu7PaSxIbasUj8Glf9oPUOvh96JGgzf6Ac4jiWi18pKYyJpGKDtjMJx7/amEyF7
         0d/A2zM2BY9bT4xHxhTZWJ03eKjAyZha12iQRgJ0qBOlFSTZ1umWW0v8szEgXcx4iCqU
         oXJigG/jSRRgb0pRylct6ekZbStf9FSr38s1P1EDF2Dqlxlo55ETKkr2FvhxhqXw1SzW
         w5Iw==
X-Gm-Message-State: AOJu0Yyq3KVRmjuHfTrjNtQAVf9r0r6339+E/+K/8dcuzAcopGQ9quIm
	PtnjWT+7ai1YZ6q+h5eaFZ8h8SBrIHJ5QvwIXwpDqJKxW1ZuFjucW9f+9GNjnIFt8nN5RbAGp+o
	3r8s=
X-Google-Smtp-Source: AGHT+IEr02qb77JnwxpFiW4Dwl0+60F5/O9kmBLNhV3g2OFZBlc1jmwggQvK1G8TPiwtTXiY6tru6g==
X-Received: by 2002:a17:907:3d8b:b0:a77:afd5:62aa with SMTP id a640c23a62f3a-a80edd36e41mr10564966b.23.1723469497517;
        Mon, 12 Aug 2024 06:31:37 -0700 (PDT)
Received: from rayden.urgonet (h-217-31-164-171.A175.priv.bahnhof.se. [217.31.164.171])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb1ccd9csm232461966b.100.2024.08.12.06.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 06:31:36 -0700 (PDT)
From: Jens Wiklander <jens.wiklander@linaro.org>
To: linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	op-tee@lists.trustedfirmware.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Cc: Shyam Saini <shyamsaini@linux.microsoft.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Jerome Forissier <jerome.forissier@linaro.org>,
	Sumit Garg <sumit.garg@linaro.org>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Manuel Traut <manut@mecka.net>,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Jens Wiklander <jens.wiklander@linaro.org>
Subject: [PATCH v8 0/4] Replay Protected Memory Block (RPMB) subsystem
Date: Mon, 12 Aug 2024 15:31:23 +0200
Message-Id: <20240812133127.865879-1-jens.wiklander@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

This patch set is getting ready to be queued for the next merge window. The
issues reported by Mikka in the previous patch set has been resolved, the
issues turned out to be outside of this patch set relating to configuration
in the secure world. I'm planning a pull request to arm-soc, but before
that I'd rather have acks or at least an OK for:
- "rpmb: add Replay Protected Memory Block (RPMB) subsystem" by Greg
- "mmc: block: register RPMB partition with the RPMB subsystem" by Ulf

Arnd, please let me know if anything else is missing.

This patch set introduces a new RPMB subsystem, based on patches from [1],
[2], and [3]. The RPMB subsystem aims at providing access to RPMB
partitions to other kernel drivers, in particular the OP-TEE driver. A new
user space ABI isn't needed, we can instead continue using the already
present ABI when writing the RPMB key during production.

I've added and removed things to keep only what is needed by the OP-TEE
driver. Since the posting of [3], there has been major changes in the MMC
subsystem so "mmc: block: register RPMB partition with the RPMB subsystem"
is in practice completely rewritten.

With this OP-TEE can access RPMB during early boot instead of having to
wait for user space to become available as in the current design [4].
This will benefit the efi variables [5] since we won't rely on userspace as
well as some TPM issues [6] that were solved.

The OP-TEE driver finds the correct RPMB device to interact with by
iterating over available devices until one is found with a programmed
authentication matching the one OP-TEE is using. This enables coexisting
users of other RPMBs since the owner can be determined by who knows the
authentication key.

The corresponding secure world OP-TEE patches are available at [7].

I've put myself as a maintainer for the RPMB subsystem as I have an
interest in the OP-TEE driver to keep this in good shape. However, if you'd
rather see someone else taking the maintainership that's fine too. I'll
help keep the subsystem updated regardless.

[1] https://lore.kernel.org/lkml/20230722014037.42647-1-shyamsaini@linux.microsoft.com/
[2] https://lore.kernel.org/lkml/20220405093759.1126835-2-alex.bennee@linaro.org/
[3] https://lore.kernel.org/linux-mmc/1478548394-8184-2-git-send-email-tomas.winkler@intel.com/
[4] https://optee.readthedocs.io/en/latest/architecture/secure_storage.html#rpmb-secure-storage
[5] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c44b6be62e8dd4ee0a308c36a70620613e6fc55f
[6] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=7269cba53d906cf257c139d3b3a53ad272176bca
[7] https://github.com/jenswi-linaro/optee_os/tree/rpmb_probe_v8

Thanks,
Jens

Changes since v7:
* Rebased on v6.11-rc1
* "mmc: block: register RPMB partition with the RPMB subsystem"
  - Adding Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
* "tee: add tee_device_set_dev_groups()"
  - Declaring tee_device_set_dev_groups() in the recently introduced
    include/linux/tee_core.h

Changes since v6:
* Add Tested-by: Manuel Traut <manut@mecka.net> provided for the v6
* Add a new patch "tee: add tee_device_set_dev_groups()" needed later in
  the patch set
* Reintroduce the rpmb_class as requested by Greg, this affects the patches
  "rpmb: add Replay Protected Memory Block (RPMB) subsystem" and
  "optee: probe RPMB device using RPMB subsystem"
* "rpmb: add Replay Protected Memory Block (RPMB) subsystem":
  - rpmb_interface_{,un}register() are now based on
    class_interface_{,un}register()
  - Embed a separate device in struct rpmb_dev for life cycle
    management etc
* "optee: probe RPMB device using RPMB subsystem"
  - Add an internal blocking_notifier to deal with the struct
    class_interface callback
  - Add a rpmb_routing_model variable in sysfs to help integration with
    systemd, requested by Mikko Rapeli
  - Add an RPMB probe capability flag in the ABI shared with the secure
    world, both SMC and FF-A ABI, needed to support the rpmb_routing_model
    variable
  - optee_rpc_cmd() is strict whether an RPMB RPC request should be
    forwarded to tee-supplicant or routed via the RPMB subsystem, depending
    on the reported RPMB routing model

Changes since v5:
Manuel Traut reported and investigated an error on an i.MX8MM, the root
cause was identified as insufficient alignment on frames sent to the RPMB
device. Fixed in the OP-TEE driver as described below.
* "rpmb: add Replay Protected Memory Block (RPMB) subsystem"
  - Adding a missing EXPORT_SYMBOL_GPL()
* "optee: probe RPMB device using RPMB subsystem"
  - Replacing the old OPTEE_RPC_CMD_RPMB ABI with OPTEE_RPC_CMD_RPMB_FRAMES
    to get rid of the small header struct rpmb_req (now removed) causing
    the problem.
  - Matching changes on the secure side + support for re-initializing
    RPMB in case a boot stage has used RPMB, the latter also reported by 
    Manuel Traut.

Changes since v4:
* "rpmb: add Replay Protected Memory Block (RPMB) subsystem"
  - Describing struct rpmb_descr as RPMB description instead of descriptor
* "mmc: block: register RPMB partition with the RPMB subsystem"
  - Addressing review comments
  - Adding more comments for struct rpmb_frame
  - Fixing assignment of reliable_wr_count and capacity in mmc_blk_rpmb_add()
* "optee: probe RPMB device using RPMB subsystem"
  - Updating struct rpmb_dev_info to match changes in "rpmb: add Replay
    Protected Memory Block (RPMB) subsystem"

Changes since v3:
* Move struct rpmb_frame into the MMC driver since the format of the RPMB
  frames depend on the implementation, one format for eMMC, another for
  UFS, and so on
* "rpmb: add Replay Protected Memory Block (RPMB) subsystem"
  - Adding Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
  - Adding more description of the API functions
  - Removing the set_dev_info() op from struct rpmb_ops, the needed information
    is supplied in the arguments to rpmb_dev_register() instead.
  - Getting rid of struct rpmb_ops since only the route_frames() op was
    remaining, store that op directly in struct rpmb_dev
  - Changed rpmb_interface_register() and rpmb_interface_unregister() to use
    notifier_block instead of implementing the same thing ourselves
* "mmc: block: register RPMB partition with the RPMB subsystem"
  - Moving the call to rpmb_dev_register() to be done at the end of
    mmc_blk_probe() when the device is fully available
* "optee: probe RPMB device using RPMB subsystem"
  - Use IS_REACHABLE(CONFIG_RPMB) to determine if the RPMB subsystem is
    available
  - Translate TEE_ERROR_STORAGE_NOT_AVAILABLE if encountered in get_devices()
    to recognize the error in optee_rpmb_scan()
  - Simplified optee_rpmb_scan() and optee_rpmb_intf_rdev()

Changes since v2:
* "rpmb: add Replay Protected Memory Block (RPMB) subsystem"
  - Fixing documentation issues
  - Adding a "depends on MMC" in the Kconfig
  - Removed the class-device and the embedded device, struct rpmb_dev now
    relies on the parent device for reference counting as requested
  - Removed the now unneeded rpmb_ops get_resources() and put_resources()
    since references are already taken in mmc_blk_alloc_rpmb_part() before
    rpmb_dev_register() is called
  - Added rpmb_interface_{,un}register() now that
    class_interface_{,un}register() can't be used ay longer
* "mmc: block: register RPMB partition with the RPMB subsystem"
  - Adding the missing error cleanup in alloc_idata()
  - Taking the needed reference to md->disk in mmc_blk_alloc_rpmb_part()
    instead of in mmc_rpmb_chrdev_open() and rpmb_op_mmc_get_resources()
* "optee: probe RPMB device using RPMB subsystem"
  - Registering to get a notification when an RPMB device comes online
  - Probes for RPMB devices each time an RPMB device comes online, until
    a usable device is found
  - When a usable RPMB device is found, call
    optee_enumerate_devices(PTA_CMD_GET_DEVICES_RPMB)
  - Pass type of rpmb in return value from OPTEE_RPC_CMD_RPMB_PROBE_NEXT

Changes since Shyam's RFC:
* Removed the remaining leftover rpmb_cdev_*() function calls
* Refactored the struct rpmb_ops with all the previous ops replaced, in
  some sense closer to [3] with the route_frames() op
* Added rpmb_route_frames()
* Added struct rpmb_frame, enum rpmb_op_result, and enum rpmb_type from [3]
* Removed all functions not needed in the OP-TEE use case
* Added "mmc: block: register RPMB partition with the RPMB subsystem", based
  on the commit with the same name in [3]
* Added "optee: probe RPMB device using RPMB subsystem" for integration
  with OP-TEE
* Moved the RPMB driver into drivers/misc/rpmb-core.c
* Added my name to MODULE_AUTHOR() in rpmb-core.c
* Added an rpmb_mutex to serialize access to the IDA
* Removed the target parameter from all rpmb_*() functions since it's
  currently unused


Jens Wiklander (4):
  rpmb: add Replay Protected Memory Block (RPMB) subsystem
  mmc: block: register RPMB partition with the RPMB subsystem
  tee: add tee_device_set_dev_groups()
  optee: probe RPMB device using RPMB subsystem

 Documentation/ABI/testing/sysfs-class-tee |  15 ++
 MAINTAINERS                               |   8 +
 drivers/misc/Kconfig                      |  10 +
 drivers/misc/Makefile                     |   1 +
 drivers/misc/rpmb-core.c                  | 232 +++++++++++++++++++++
 drivers/mmc/core/block.c                  | 241 +++++++++++++++++++++-
 drivers/tee/optee/core.c                  |  96 ++++++++-
 drivers/tee/optee/device.c                |   7 +
 drivers/tee/optee/ffa_abi.c               |  14 ++
 drivers/tee/optee/optee_ffa.h             |   2 +
 drivers/tee/optee/optee_private.h         |  26 ++-
 drivers/tee/optee/optee_rpc_cmd.h         |  35 ++++
 drivers/tee/optee/optee_smc.h             |   2 +
 drivers/tee/optee/rpc.c                   | 177 ++++++++++++++++
 drivers/tee/optee/smc_abi.c               |  14 ++
 drivers/tee/tee_core.c                    |  19 +-
 include/linux/rpmb.h                      | 123 +++++++++++
 include/linux/tee_core.h                  |  12 ++
 18 files changed, 1024 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-class-tee
 create mode 100644 drivers/misc/rpmb-core.c
 create mode 100644 include/linux/rpmb.h

-- 
2.34.1


