Return-Path: <linux-kernel+bounces-390940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5259B804D
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 17:38:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 611AC1F226C1
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 16:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DCF61BD03C;
	Thu, 31 Oct 2024 16:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b="cR5xwb33"
Received: from smtpcmd15176.aruba.it (smtpcmd15176.aruba.it [62.149.156.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 917431BBBD8
	for <linux-kernel@vger.kernel.org>; Thu, 31 Oct 2024 16:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730392705; cv=none; b=CNdIIR85VY2rkhzCuOjbgdI/R8F6PwXqLORxHdRFE6mWI1NREqBuECEhx+VjGKBacrgKntJOwJRvJQVsBhIfyucAHfvXVNyFxE68IGiwfv+izb0pMXz8YxoAQadZkGqBzMgHu+CQBKXf6AWSJJbbKAHW76JNso9CtlYqD11ODAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730392705; c=relaxed/simple;
	bh=QHCTcDHh9G125r7NA7Zw5G3TKp3bPoZnaDdbcmBx/WA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lPk0ZiAE3SEHpGd+l6077iHG+Ta4k1lfEPQ2WFQFjGuWZzMXOPUnoe04MlVeD0GuMrtAj1kFmJNObilrF1fuBZ12HyepLOqWm1Y0m3noV3UbX9Sr+I5WDkFT+stPxUOCMPY8LA1ThLe5OY1qZr3KvOSr69OoRrHccwriT+RpSek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=temperror (0-bit key) header.d=aruba.it header.i=@aruba.it header.b=cR5xwb33; arc=none smtp.client-ip=62.149.156.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Received: from polimar.everex.local ([79.0.204.227])
	by Aruba Outgoing Smtp  with ESMTPSA
	id 6Y8atb5dFqJRS6Y8atNuFA; Thu, 31 Oct 2024 17:35:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1730392511; bh=QHCTcDHh9G125r7NA7Zw5G3TKp3bPoZnaDdbcmBx/WA=;
	h=From:To:Subject:Date:MIME-Version;
	b=cR5xwb33gBC/xTG1X+4jBGBxhdwv1XZ2YffJMoljENlapUqegJ2RQox990n0YmJ+I
	 dM58lZYAVAwuKNTpg6gPe9k1mYvv2gaLqqY8X+TQF5hcA4wpaxa3dhIqWmpypiWs/3
	 5SjS3CAjyfRQlwnZMCNh0epADq5ri6o100DkMs0D2Yh9JRELjd5aZlKVJPgW6SjNXf
	 PN1Gfw2su6TLejSY7v96Ch7zqB4v05ytRI6OkUizxf0JAf1ByY7BXyNWbX6pWIuWD7
	 KwiubcG93pA+KObNreKtuRraTifer6tqU6OGk4Zzqs9wBJb4gtunuOt2zjoAnO/juL
	 KeT/wtFoZPKtg==
From: Rodolfo Giometti <giometti@enneenne.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Greg KH <greg@kroah.com>,
	corbet@lwn.net,
	Hall Christopher S <christopher.s.hall@intel.com>,
	Mohan Subramanian <subramanian.mohan@intel.com>,
	tglx@linutronix.de,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Dong Eddie <eddie.dong@intel.com>,
	N Pandith <pandith.n@intel.com>,
	T R Thejesh Reddy <thejesh.reddy.t.r@intel.com>,
	Zage David <david.zage@intel.com>,
	Chinnadurai Srinivasan <srinivasan.chinnadurai@intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Rodolfo Giometti <giometti@enneenne.com>
Subject: [V2 0/4] Add PPS generators
Date: Thu, 31 Oct 2024 17:35:04 +0100
Message-Id: <20241031163508.259522-1-giometti@enneenne.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfN/FxSRnUHB8WmG0CP+7byCawZGM+hNWPsQQe7XCZ8BG6h94SNtY3v8NkMD6m77ludedH4mu/SejsdPh1Qkgnq1AJw6JrKoxc0lrTKjYyVfqMlpUFe0J
 3oq2GuqyBUkU5oLMhfTNAVCtc+Al5t3aUP5HUvjw9PAM2CSeisVSFzou9hLuABhKbZ3IVj+MBZ1k+25gQ5Oh6FqegXlFpBt/io0nx7oqvSlInTAuwFFogD3c
 vOI2LlKHEGNKYY2PG7IPt+wlaLpb4GoJp83zTTESoeIKjJ6FKCTPmUAVYFT8jMM1QK11AsOIBoLRrQKJgtqeZpB1heIOQVCdAP4fNhX48724+P3M14egsyH7
 O8iaJawf1h1CdTekqeFFEuaFzByUk5mkAH+C0U8KORUYtC/EnRkQnWATOZ1tcl40kAhOFlrj51GcjMqMNLiwWy/fkb/1qlTBVsTdesdZwATk3gvCFzO0wGme
 aXTRc3gosfDLpFZJHBM1ab9r6oC3sGqdWXnWHY+8QMOVS2fu+8QyBWbG3GYUfLuy06I7vBAE9orsTeyWb3sLvDBilrDlRN6B6gSgzCxms4J5nn99BwZSDH1a
 tVDqQp3i+W8DxdQv528GVGo8vDv49fo4UCJPrewkCygXz4Cm/zRPnKPnOOzLV5yfzihISGsyYe6XbXxMwomXLfns1uff/oqeGcslinXbBnV4/Ny1JXUMSssx
 Rljyh3qJkap2w+RiktjKn8PKh/nbf/tO

PPS generators are special hardware which are able to produce PPS
(Pulse Per Second) signals.

This patchset adds PPS generators class in order to have a well-defined
interface for these devices.

Changelog:

V1 -> V2:
    * new file Documentation/ABI/testing/sysfs-pps-gen added in MAINTAINERS
    * date for the documentation ABI set to v6.13 which will be released on 2025-02
    * removed documentation for non-existent sysfs "name" entry
    * spelling and/or syntax errors fixed

RFC -> V1:
    * char device reworked (get_device/set_device)
    * dummy driver has been moved in a separate patch
    * idr_ replaced with ida_* functions
    * fixes in include/uapi/linux/pps_gen.h
    * MAINTAINERS updated
    * new ioctl PPS_GEN_USESYSTEMCLOCK added
    * new ioctl PPS_GEN_FETCHEVENT added
    * .compat_ioctl dropped
    * WARN_ON() removed from pps_gen_cdev_release()
    * not needed pr_*() calls removed or replaced with dev_*()
    * more quite driver
    * name attribute dropped
    * white spaces removed

Rodolfo Giometti (4):
  drivers pps: add PPS generators support
  drivers pps/generators: add dummy PPS generator
  Documentation pps.rst: add PPS generators documentation
  Documentation ABI: add PPS generators documentation

 Documentation/ABI/testing/sysfs-pps-gen       |  38 ++
 Documentation/driver-api/pps.rst              |  40 ++
 .../userspace-api/ioctl/ioctl-number.rst      |   1 +
 MAINTAINERS                                   |   2 +
 drivers/pps/Makefile                          |   3 +-
 drivers/pps/generators/Kconfig                |  22 +-
 drivers/pps/generators/Makefile               |   4 +
 drivers/pps/generators/pps_gen-dummy.c        |  96 +++++
 drivers/pps/generators/pps_gen.c              | 344 ++++++++++++++++++
 drivers/pps/generators/sysfs.c                |  75 ++++
 include/linux/pps_gen_kernel.h                |  78 ++++
 include/uapi/linux/pps_gen.h                  |  37 ++
 12 files changed, 738 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-pps-gen
 create mode 100644 drivers/pps/generators/pps_gen-dummy.c
 create mode 100644 drivers/pps/generators/pps_gen.c
 create mode 100644 drivers/pps/generators/sysfs.c
 create mode 100644 include/linux/pps_gen_kernel.h
 create mode 100644 include/uapi/linux/pps_gen.h

-- 
2.34.1


