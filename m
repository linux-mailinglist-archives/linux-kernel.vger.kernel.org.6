Return-Path: <linux-kernel+bounces-227677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 407AA91556D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:32:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE38F1F2450F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:32:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A3E19FA78;
	Mon, 24 Jun 2024 17:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="prB6oUsT"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB84FC08;
	Mon, 24 Jun 2024 17:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719250300; cv=none; b=s+VHDtWMWjFNaB/NevHrR3Tip/MJ4yT18398AngLeSjftp4oCGHS69Fj7Eu5P70CHzLBp5Cx6t65wqJm4+NpjMUwIKxhpFlhSlTHSXN2U0Zg/KoCOB6laefjSvOArA3GoPEeLF4Sq+OT1ZdaTkcvMwVABCgs92trp9Dn1S4PINs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719250300; c=relaxed/simple;
	bh=r5aoSSHHzvkTrb3M9LRzqy9wc38iKjKBcCbcUiX1Zxo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=JQlQhosxQk2qw02vv2yU0J37Chb7G6UoVAcBLFaj+V6CRSxIfZqwE8a2v3rYCtg/248klJTTUkcyEkIeNMVxVgTXlg4HrXD612/dHp9R7FJoKjgj4+c0Jee7kP7Z6U/Drzv2ppm/1C++U5WyamUHAgzLIgX8ChvDUqTdqtb/pdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=prB6oUsT; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1719250285; x=1719855085; i=w_armin@gmx.de;
	bh=bIDJmWlm0NZjk8UFs8IE8//cw8qKRpDPDhhxVWHn6Zo=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=prB6oUsTfgJ8AZktfxDa3z3p34uAmc18FI8xL16324cbZnafolX1yYhB91aDGwdL
	 U7IRJlnbqz3F9s6QKwoqYf0oOlLIe2MmkYHAvJgzTXsn6wwf6C+Rv4bGzGAiFYELp
	 m4KgVF88Kdj2EaGwElZ+xFai83H6vtAxxTk3839yN3rSjRKZTaLUgxiyu4BnOCDpr
	 Qk1t40Z9a/NlU5mdsVKxKXEvsFMTq7udziDCNIBObfYpyhpn/DXAr0lmGYl4FMcxa
	 cO6Nuen6gJGry9zZ4G6z5kMcOpPlvmalL1apB1/CSPDMrsZrC1SYIevkkGa3aNyB/
	 fHy+XD3xdeY+AZ7JdA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MKbkM-1s39eb2PWu-00WYi8; Mon, 24 Jun 2024 19:31:25 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: corbet@lwn.net,
	platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] platform/x86: wmi: Add driver_override support
Date: Mon, 24 Jun 2024 19:31:14 +0200
Message-Id: <20240624173116.31314-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Ngr07JOebHUemqRwc7dkutHAS5e8JGqJUVcvMG52YRe96fVwAUD
 h8Jl/0aTbEcBTIbf8ntN34bpo5lh3Ies4q6K4iuMSqfVgFyUrHhtdO3JX/jUnY1oRXlZWLq
 AuAtQcJDYFzw+ZdC5fV161uc4AMqHJuo7cPWMNWLu6UkDOX6/m0A07EtPFF/JS2+1rQznMb
 a4e0hJopuqjGntn8YZVLA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ac+iIapHrVE=;c7BNJ5Ziuz/zVTphmFXtD4cqGoS
 x89IxJI071YKPVZlUS/aVBsObQUmo7WEFivFpBVpw17+IyBkQXkSRb6sZLhPjhCeqoTWGBLFf
 +Dr+gzEjOUAWPOjh8RZ/AuY6x3R/EaYzHRihZKMsxK6l21CLFGkxNqmmi0oOJUu9IPylqRSy3
 X9VmLwtoWBaXPEJc5uukTS/djiir+avJ/2/G1cOOj28PscfDg4/OPICILGZzOhgPc+1bowoeF
 waf0CqIBimklTLCXd3nmV1dGFmjLChauqDfqKdEqwAblmR8O5PO+6zuH5aKZSHk6+AWPvcy72
 zJ1tQqATMmPM0iFlSnIqvXWNXwsSh2vpnpQPEERmKwpsh8QH2UiP3K/gg7QRF8SLt05mtOkxm
 Bc+I0cx9McJQVcGk9dMU2sFStboGpY5or1uA+MdDaLV4lq032ZdyRhHMyG0AvnYWAha5IyHMR
 6vkv2dNssxGX8pQt/ZHWjUomA56T02yL70727SEkUl8U1U3PV+pM5fbTR3bKHv5DV5DDUFvNc
 EZUQt/SEeZUXqUfFm4VvWxRcKfCdE5Sh1O67HTbobA7DVh80ML8FoNzodKxUOisR4/R238Y49
 Zyt/Xp3NU08qHvRtMKBlXnTcZmz9wFv0xKsW6NsqjfN0D5DOVwGw7Ai6EktSShEvTu31S9hLf
 y8hxtygTn9YaCSoupqkBYOmVFZM0AFr0F0mb05DBsPIAoXPp4ANvzFjgQHyYm1odsv63jNJz0
 zp3QgwRHO24sqD8VqlrVtwyETEZQZUH0rS5mlsG9Bry0BruzVaUzcTO2F6Mc3aZzNO2g2REWM
 ItdgfeOzX4Z3OCu4XPefciHUftaaVyylHMXQy/kwxPRLE=

This patch series add support for using the driver_override sysfs
attribute with WMI devices. The reason for this is that there will
exist a couple of generic WMI drivers in the future for allowing
driver developers to directly access the underlying WMI device.

Since those generic WMI drivers do not have an ID table, the
driver_override mechanism is used to bind them to WMI devices.

Changes since v1:
- Add Reviewed-by tags
- Add line breaks and implement requested changes in the documentation
  of the driver_override attr

Armin Wolf (2):
  platform/x86: wmi: Add driver_override support
  platform/x86: wmi: Add bus ABI documentation

 Documentation/ABI/testing/sysfs-bus-wmi | 81 +++++++++++++++++++++++++
 MAINTAINERS                             |  1 +
 drivers/platform/x86/wmi.c              | 33 ++++++++++
 include/linux/wmi.h                     |  4 ++
 4 files changed, 119 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-wmi

=2D-
2.39.2


