Return-Path: <linux-kernel+bounces-516770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1F1A37727
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 20:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C78F1883C45
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 19:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9801A5B98;
	Sun, 16 Feb 2025 19:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="rAdIPGvM"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E637F1A2860;
	Sun, 16 Feb 2025 19:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739734403; cv=none; b=czsB/F+U6oPrRoWskZf1D505ptcBI5EAgGqww12fhnKZ+kl0n5SfaDeDgvPAhyQDNTyUaBqKwo6ziTgg9Bm2kcqVzzuV1XHk/72fE8PeVf3qNJGZNPMjI/mzEW8CQ1U05jp4svGm+XQ+6jKuGk7JGXFuZwJfjoh7gfVUzV48Osw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739734403; c=relaxed/simple;
	bh=WJV/XDNncV3HMhaU1OkQyuWjHFhef1ztCgpi83LVLx0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WnEMGFZNypGgLfLM8mKcFEbulz2Z6QFQYp4zuy/UPMzHnV1HgSUOl1iK14cWFmjpDa14MSZWbfVMU0u96zMkQa7QbcqQsItYDEW+8ap2GOSPvkff3GH8k/i/gvKdJyCfMDQRVTU55Txf8qOjeF4YOGCxPMGu6WkYB9wA4iZFOSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=rAdIPGvM; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739734377; x=1740339177; i=w_armin@gmx.de;
	bh=5SxkcnujTlMkxclqqkcog9uUjawTQI9K/xGxAcUUiqY=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=rAdIPGvMneGt5JWjYN867QM9Q0DF5zLKHhpoBmrQYkv7zqzUDRASrOQ7hO2oQEg4
	 oOvX9/8JUG7i+pmQ0nWuZ5YD5l+uwYsOvzXnZXKmSRws7FY6bWzlUpo3Pckem0ifI
	 R04QA5W9Hq70SijenQVarViXB2Dy266/NBPdrnaOJoxNEv6h5ao4aYSZcXH8Asrrm
	 yvuzu8rLcK44BHi3p0OCkJbEX5DzwP41NetdhYbBeBAAJE2gp/Im9DnaS+gKWe+SA
	 sqNYTnWykbIRP7nipOMLIdFKNMlMFDEcMrR6f+Y5c4oZNv/VWcxnCVaCQGW60suf1
	 wuslnRNgaTBolsOhMA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1M59C2-1tkqJY3cIe-004mIN; Sun, 16 Feb 2025 20:32:57 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: james@equiv.tech,
	markpearson@lenovo.com,
	jorge.lopez2@hp.com
Cc: jdelvare@suse.com,
	linux@roeck-us.net,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org
Subject: [PATCH v2 0/8] platform/x86: wmi: Rework WMI device enabling
Date: Sun, 16 Feb 2025 20:32:43 +0100
Message-Id: <20250216193251.866125-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E9HBntScjkVmVXA/RGU9WXs5GzImI8Q5X8772CBP2g8NU7m/q5o
 gD23GUCkgFW/DXUEj5q1iZmJ5FAAooM8lpLPX8BA6EkLJygVlRSXaqEjNnJXGNBWBJDLJFj
 8ennt/4GXSDzNz0l74igPpfxYKGsVTw1ljyefKGPV00UjN5YAHMxyPMO955cmmG1eP5xCij
 aIVtIJdF9rk1dx77tCPEA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:wKyUm7eqFOA=;oV8SorG/pKw1gx7VoIRfah3gMob
 55qNoJ9jz/wxCTxZQc35Orx0cT7WgdSgZV96PovOQhy2vYrEF3zdEHE+opdmehVM/eVNOKQhp
 9/o/9lHgJ29cCkRtAjcg7MgkvzqE2SFr30OkZIQ7jhlNJrWUyXEXABy4AsRDUAxeQn64c2byI
 uROM1ENssbACUGleJ5QgBljiwv03lUBYBvjrwquOX9AeXLWlXAXnTJSoUnsxqDnCiprZ+lY2e
 ZY3WVp2OKiX497vNmpH6xnTngg+b6clJUcjaaFQKvVp3YpiqyvLUfqs7G8rytkayHpZLcFsxZ
 RrtJzhKSHfsXN2M0EotP+CpPwtuiUdqXXklXwYUjLPWCQ358Y0DAYT1x0/DoQhk8BQ2VXlTYA
 Kfo/kYK6Cd7IuT6/BCGoB3WjzRKJR/rnaxeKVNwJJ0wbnAj/p92bRnxai26ayyA1LH7e8yOFP
 9wUo5dGpfEC2A5Yerw3M15QIbHWEJ4MhevvOeUD6gvLmnLR8gK369W4c+ABC9uwx9Yxt9NgHA
 9pxqnRQI+WScmkWIaEEOcVBZrqas8OM+4m4JXim/NrND42n/9QZTovkFYeNL8uYFXhvayCGa6
 ZzmIcg6U5ddCFVICpANRnIuB4zn5M62W05Dq63qlBhPBSXunaP8Mhdnp7I15sc26bk1xpbPx1
 X3xN4X0crc5ZIBG6zF2yCprNBQHJvEjVz8OcLfud16HO3YsqvHs1PtVAFlB0eP9Nlbvaj6eMr
 Jr3rkM6YQdBOLOG2TxdYP6TPQwkmEKxbb2B7Lj8OsIzknDh8Q/6FptUphDxYuZjdlr9jUzC/p
 6+7AN1wdQXwcTdHkoRLYOqolOB0QX+2U9aHKyMpPnP2ifcTKSxY6qqVmJ2On5DA5skE5YLM9b
 NmOBype6LsRJ9xW56xNO2KFfPfi/xw9dAC9OJL+sDJat6t+qQ79jd1FJ9wHNYsOmYVLd+jWE3
 y219ZOl9kM0rFP0dVQehqT61ZkoW+GpQbxS5PREImBqDXZGcDPkuLBMDAj7y0ZMFUHmcfS2+P
 7TJt7kqvduS4xy3wdLkVSp7kfejBbnIt6djOVDjRBwaitjn4ZWqFsSCw54q1SdkBRhxNBxRxT
 pXSg5lafIPkKzWrCCl7f9WhMun4g3oj7iZCzsAHlgw2uxWJBQiymSmxowbvOaJP8bMid07lJN
 /5/RdzreZOZwb0NB2ceQXnns5gj6FyavPKRA4TyA551b6+W/6lx5vVsxnHcUjVDCZm062HZVf
 U1oIJfPW08fmieyqPcVz3woOdW8eWZD2c3DDOBnyNZTfcj2WB+RO6chO3OdF29+WfQRhqCKJI
 7kbuc2HGA3+Kbp/6Y7KJRBx+8MLQM8q1ju5ZWHMv1WJR8/1beR8HTWjDhQo0DpxhZlVK/PwJi
 s1o9sAMQ2R5qn6zpNy6LXlRh1/qxf6x8NgB4WpTdaNxvAiVliO/95rXBPorWZuAXsspewN0ku
 /YZ7Hfg==

This patch series reworks how WMI devices are enabled and disabled
to improve the compatibility with various firmware implementations.

The first three patches make sure that no WMI driver using the WMI bus
infrastructure is using the deprecated GUID-based API to access the
underlying WMI device.

The fourth patch is a unrelated cleanup patch.

The last four patches finally rework the WMI device enabling inside
the WMI core and update the documentation.

The WMI core patches have been tested on a Dell Inspiron 3505, but
the remaining patches are mostly compile-tested only.

Changes since v2:
- add Reviewed-by, Acked-by and Tested-by tags
- use devres to disable the WMI device

Armin Wolf (8):
  hwmon: (hp-wmi-sensors) Use the WMI bus API when accessing sensors
  platform/x86: think-lmi: Use ACPI object when extracting strings
  platform/x86: think-lmi: Use WMI bus API when accessing BIOS settings
  platform/x86: hp-bioscfg: Use wmi_instance_count()
  platform/x86: wmi: Use devres to disable the WMI device
  platform/x86: wmi: Rework WCxx/WExx ACPI method handling
  platform/x86: wmi: Call WCxx methods when setting data blocks
  platform/x86: wmi: Update documentation regarding the GUID-based API

 Documentation/wmi/acpi-interface.rst          |   3 +
 .../wmi/driver-development-guide.rst          |   4 +
 drivers/hwmon/hp-wmi-sensors.c                |   4 +-
 drivers/platform/x86/hp/hp-bioscfg/bioscfg.c  |  13 +-
 drivers/platform/x86/think-lmi.c              |  51 +++----
 drivers/platform/x86/think-lmi.h              |   2 +
 drivers/platform/x86/wmi.c                    | 141 ++++++++++--------
 7 files changed, 116 insertions(+), 102 deletions(-)

=2D-
2.39.5


