Return-Path: <linux-kernel+bounces-207163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 90E24901314
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 19:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE7271C21052
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jun 2024 17:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE69A1C69C;
	Sat,  8 Jun 2024 17:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fp9xcgdM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A4D1C287
	for <linux-kernel@vger.kernel.org>; Sat,  8 Jun 2024 17:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717868546; cv=none; b=TO5Qw1RjiitkXtpg5FSUQxE4+S83q9X3bwGo0jh5lncT/yGuY3DZTw2tl6wnngf2OZHbA610MDEf2kp/kXryfk0wyQrNiw+ZZwKrlxoP7tsCSx2IgxJ8TmWr9LxRvnfY3pwey8l4c/NBLOPXXSKtYZOW/uJR0XjLcTgU57iQ1XQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717868546; c=relaxed/simple;
	bh=LJaoJswvPBFnxaJA9VJlDwo23fhMSvC1Ka2/ezqyESk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=EO6St6q4xPWwWO4xkgtYFzh23j2ozrEmudArQ+mWtFGyNQtTXHeO9udfTD5Zs6z20xq0g15i4u22seYqB8BaB4ql8JnMLaZ0yys5dyCeFoARrHoxisbdLG1P6UkYtnVEZbzE8tNwef2p4CcdKKY+2mRE3qGBwLzYYHYYhrUJr0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fp9xcgdM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DC89C2BD11;
	Sat,  8 Jun 2024 17:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717868545;
	bh=LJaoJswvPBFnxaJA9VJlDwo23fhMSvC1Ka2/ezqyESk=;
	h=Date:From:To:Cc:Subject:From;
	b=fp9xcgdMmawUBQWeFXC8OYcem34u2PWCA7Z01EucrXlOiNOUcwI2MPhJUtVtEodb2
	 hlw+VX0x9UI+vMzdACu4cerC1GVomi0TaN9iUa4VTSbPvYDPXnc+AEOJr40ApXIQYM
	 TOZZEHxEkGIe8cT02pMkodYfwl4jM72SP1WhTRHwU1sgYJXXU2+uvf8xOyhs2yG+6w
	 4kWTl8yok64gnbOxt0t+QPItIWBX0zyj1KHuVs9njIFfQi50khxiKQuSENgP7bZymK
	 iOWa+mhdi3ugtYGd8HMXOeD/5AiacyywLmOxPga1Ji+6Dxar2LM72hWIyaHgJ5NRyZ
	 jqpf0S9CrrOTQ==
Date: Sat, 8 Jun 2024 19:42:21 +0200
From: Benjamin Tissoires <bentiss@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] HID fixes for 6.10
Message-ID: <xaohohlelhzbc5a3hmrutryyeth3u77paq5w2skjqyahrusodj@ogoroplzq6uy>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git tags/for-linus-2024060801

to receive fixes that should go into 6.10:

=====
- fix potential read out of bounds in hid-asus (Andrew Ballance)
- fix endian-conversion on little endian systems in intel-ish-hid
  (Arnd Bergmann)
- A couple of new input event code (Aseda Aboagye)
- few handling path errors handling fixes in hid-nvidia-shield (Chen
  Ni), hid-nintendo (Christophe JAILLET), hid-logitech-dj (José Expósito)
- A current leakage fix while the device is in suspend on a i2c-hid
  laptop (Johan Hovold)
- other assorted smaller fixes and device ID / quirk entry additions
=====

Thanks,

----------------------------------------------------------------
Andrew Ballance (1):
      hid: asus: asus_report_fixup: fix potential read out of bounds

Arnd Bergmann (1):
      HID: intel-ish-hid: fix endian-conversion

Aseda Aboagye (2):
      input: Add event code for accessibility key
      input: Add support for "Do Not Disturb"

Chen Ni (1):
      HID: nvidia-shield: Add missing check for input_ff_create_memless

Christophe JAILLET (1):
      HID: nintendo: Fix an error handling path in nintendo_hid_probe()

Jeff Johnson (1):
      HID: logitech-hidpp: add missing MODULE_DESCRIPTION() macro

Johan Hovold (4):
      dt-bindings: HID: i2c-hid: add dedicated Ilitek ILI2901 schema
      dt-bindings: HID: i2c-hid: elan: add Elan eKTH5015M
      dt-bindings: HID: i2c-hid: elan: add 'no-reset-on-power-off' property
      HID: i2c-hid: elan: fix reset suspend current leakage

José Expósito (1):
      HID: logitech-dj: Fix memory leak in logi_dj_recv_switch_to_dj_mode()

Louis Dalibard (1):
      HID: Ignore battery for ELAN touchscreens 2F2C and 4116

Nikita Zhandarovich (1):
      HID: core: remove unnecessary WARN_ON() in implement()

Zhang Lixu (1):
      HID: intel-ish-hid: Fix build error for COMPILE_TEST

 Documentation/devicetree/bindings/input/elan,ekth6915.yaml  | 19 ++++++++++++++-----
 Documentation/devicetree/bindings/input/ilitek,ili2901.yaml | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/hid/hid-asus.c                                      |  4 ++--
 drivers/hid/hid-core.c                                      |  1 -
 drivers/hid/hid-debug.c                                     |  2 ++
 drivers/hid/hid-ids.h                                       |  2 ++
 drivers/hid/hid-input.c                                     | 13 +++++++++++++
 drivers/hid/hid-logitech-dj.c                               |  4 +++-
 drivers/hid/hid-logitech-hidpp.c                            |  1 +
 drivers/hid/hid-nintendo.c                                  |  6 ++++--
 drivers/hid/hid-nvidia-shield.c                             |  4 +++-
 drivers/hid/i2c-hid/i2c-hid-of-elan.c                       | 59 +++++++++++++++++++++++++++++++++++++++++++++++------------
 drivers/hid/intel-ish-hid/ishtp/loader.c                    | 79 ++++++++++++++++++++++++++++++++++++++++++++-----------------------------------
 drivers/hid/intel-ish-hid/ishtp/loader.h                    | 33 +++++++++++++++++++--------------
 include/uapi/linux/input-event-codes.h                      |  2 ++
 15 files changed, 222 insertions(+), 73 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/ilitek,ili2901.yaml

---

Cheers,
Benjamin

