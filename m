Return-Path: <linux-kernel+bounces-431577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A48969E3F17
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 17:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F7FC28519C
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 16:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D5421858F;
	Wed,  4 Dec 2024 15:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhUknTQV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E23217F48
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733327909; cv=none; b=bOis/TIL35o/htgfi8KjpSHa2J+wk3kgPW7tNGtP9q7dxNq/kIZ1mwkoEWs4OkFt23j9C+bEbKKhaj9mPvxVZQzWbzGo2NR5t6/rBn3aCI/cVze4rJhP111MQgZy41U4X+ZAGpv+2UZ/2KZfENwKD0D/7zfbkcvLlzs9ouBCspM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733327909; c=relaxed/simple;
	bh=jueMBi9DqtcIAo8jCb8vFwaEcMnWhMI0+nsU7Naunbo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dT1i7GBEa8coIjamhYBQW+0S7BSOdHGf2KPCKArXBqyk16b8Cu9kijdjBSZ/g4ghVRGGqNc2wpBq7iO/3Nkjwi0LPw2sIIFrCtLfT/vWzGsvEk1YuiPHknsHa0vxm1Y/zWPwnJi4NZTRI85i4flbwkh36A1l0sipvYdEccGpvv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhUknTQV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249CCC4CED2;
	Wed,  4 Dec 2024 15:58:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733327909;
	bh=jueMBi9DqtcIAo8jCb8vFwaEcMnWhMI0+nsU7Naunbo=;
	h=From:To:Cc:Subject:Date:From;
	b=GhUknTQVxI50Jxwu9VmhFjNs3op+lf/OTVA8FmnQWxFzTsMOfExv7I1rAuKrd9a36
	 oQ68qTKjBhtWueYPiTTACBtwrN4hliJm9ufJeh4FT2jGtfTcF9fzamauhRheIlmT4O
	 YULaUG/LU8ictiFlD4Qo+kQlfJB4xCvfKr7gjvjtb7aUS/TlyY4MJ90+yZxGL+8bNn
	 6+ujN+JnuvLIIpNY2V8KCWA2CKqLSlTfRDka+kbtMJM9O/AWMFD7EvNm+PpHjJ1qlE
	 74T8z2Octji2s4cr6q40rrr7z7CDy4zI/jtc3l+H1M55FE8rPdOt+laRsCt6lg1Eso
	 3AjlS6gKJYtkQ==
Received: from mchehab by mail.kernel.org with local (Exim 4.98)
	(envelope-from <mchehab@kernel.org>)
	id 1tIrlf-00000000HYp-3B0D;
	Wed, 04 Dec 2024 16:58:23 +0100
From: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
	Ani Sinha <anisinha@redhat.com>,
	Dongjiu Geng <gengdongjiu1@gmail.com>,
	Eduardo Habkost <eduardo@habkost.net>,
	Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
	Peter Maydell <peter.maydell@linaro.org>,
	Shannon Zhao <shannon.zhaosl@gmail.com>,
	Yanan Wang <wangyanan55@huawei.com>,
	Zhao Liu <zhao1.liu@intel.com>,
	linux-kernel@vger.kernel.org,
	qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v3 0/5] Change ghes driver to use HEST-based offsets
Date: Wed,  4 Dec 2024 16:57:54 +0100
Message-ID: <cover.1733327276.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>

This  series was part of the previous PR to add generic error injection
support on GHES. It depends on a cleanup patch series sent earlier
today:

    https://lore.kernel.org/qemu-devel/cover.1733297707.git.mchehab+huawei@kernel.org/T/#t

It contains the changes of the math used to calculate offsets at HEST table 
and hardware_error firmware file. It prepares for the addition of GHES
error injection.

The first patch was previously at the cleanup series. It prepares
the logic to support multiple sources.

The second patch adds a new firmware file to store HEST address.

The third patch use the new firmware to calculate offsets using
HEST table.

Patches 4 and 5 add migration support. They assume that this
series will be merged for qemu 9.2 (maybe it is too late for that,
as QEMU is now on soft freeze). 

I tested migration using both virt-9.1 and virt-9.2 machines
on qemu 9.2.

I also tested migration with:

	qemu-9.1 -M virt-9.1 -cpu cortex-a57 => qemu-9.2 -M virt-9.1 -cpu cortex-a57
	qemu-9.2 -M virt-9.1 -cpu cortex-a57 => qemu-9.1 -M virt-9.1 -cpu cortex-a57 

The full qemu command when test backward-compatibility when running virt-9.1 is:


~/qemu/build/qemu-system-aarch64 \
-m 4g,maxmem=8G,slots=8 -monitor stdio -no-reboot -bios ~/emulator/QEMU_EFI-silent.fd -kernel~/kernel/arm64_build/arch/arm64/boot/Image.gz -device pcie-root-port,id=root_port1 -device virtio-blk-pci,drive=hd -device virtio-net-pci,netdev=mynet,id=bob -drive if=none,file=~/emulator/debian.qcow2,format=qcow2,id=hd -object memory-backend-ram,size=4G,id=mem0 -netdev type=user,id=mynet,hostfwd=tcp::5555-:22 -qmp tcp:localhost:4445,server=on,wait=off -M virt-9.1,nvdimm=on,gic-version=3,ras=on -cpu max -smp 4 -numa node,nodeid=0,cpus=0-3,memdev=mem0 -append 'earlycon nomodeset root=/dev/vda1 fsck.mode=skip tp_printk maxcpus=4'

(I actually call it from two different directories, one with qemu-9.1 and the other one with qemu-9.2.

For tests on qemu-9.2 with virt-9.2, I used a similar command:

~/qemu/build/qemu-system-aarch64 -m 4g,maxmem=8G,slots=8 -monitor stdio -no-reboot -bios ~/emulator/QEMU_EFI-silent.fd -kernel ~/kernel/arm64_build/arch/arm64/boot/Image.gz -device pcie-root-port,id=root_port1 -device virtio-blk-pci,drive=hd -device virtio-net-pci,netdev=mynet,id=bob -drive if=none,file=~/emulator/debian.qcow2,format=qcow2,id=hd -object memory-backend-ram,size=4G,id=mem0 -netdev type=user,id=mynet,hostfwd=tcp::5555-:22 -qmp tcp:localhost:4445,server=on,wait=off -M virt-9.2,nvdimm=on,gic-version=3,ras=on -cpu max -smp 4 -numa node,nodeid=0,cpus=0-3,memdev=mem0 -append 'earlycon nomodeset root=/dev/vda1 fsck.mode=skip tp_printk maxcpus=4'

---

v3: did some minor cleanups at the code, as suggested by Jonathan Cameron.

v2:
  - some whitespace and comment changes
  - patch 3/6 (acpi/ghes: rename the function which gets hw error offsets)
    was merged on the cleanup series.

Mauro Carvalho Chehab (5):
  acpi/ghes: Prepare to support multiple sources on ghes
  acpi/ghes: add a firmware file with HEST address
  acpi/ghes: Use HEST table offsets when preparing GHES records
  acpi/generic_event_device: Update GHES migration to cover hest addr
  acpi/generic_event_device: add logic to detect if HEST addr is
    available

 hw/acpi/generic_event_device.c |  30 +++++++
 hw/acpi/ghes.c                 | 160 +++++++++++++++++++++++++++++----
 hw/arm/virt-acpi-build.c       |  33 ++++++-
 hw/core/machine.c              |   2 +
 include/hw/acpi/ghes.h         |  23 +++--
 5 files changed, 220 insertions(+), 28 deletions(-)

-- 
2.47.1



