Return-Path: <linux-kernel+bounces-352157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B9655991AE0
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 23:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 605C6B21B50
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 21:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB9921662F4;
	Sat,  5 Oct 2024 21:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="KqI5AArv"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFAB154BEC;
	Sat,  5 Oct 2024 21:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728164325; cv=none; b=OqgZnkQ9SbTVyco89tVd4v4wYoAAerER0Xh/8wBeZtKQd/RgpQQhSW0A+DWs40vbjDibavT77IK0dB3aOlYmDkuAlcyyzbmak2sTSr17aMVpNVR5T3Q2U2VUN7YUHYKha8BHFDr1QtldrTZvfRKta5WyXGNkd7w627OrodpexKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728164325; c=relaxed/simple;
	bh=qqPMlqB0XMYZQQu9VIWJCIWJxdukqr1Q/bgQ3RYCAgo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IT+SEIJsFSDW0m0Z+1KkrzdSfyFHRFINcIyYXsSsNdlARfr4cRCJMwrPQ1/3TRbSldH2jzPc/sPAkYSMdFczxfhc/1MrG1J7D2azr3jFBu1TZKgEAaJYCOT9iy2Eh0mcVd7LjKrMUHLPqRAFFD9cdEo7MG+yhGrmuIr/yUE7obk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=KqI5AArv; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1728164310; x=1728769110; i=w_armin@gmx.de;
	bh=Xc3gXdeaddE6/h3n+cyXwuqR9OvIcn79Fis7ERYbfM0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KqI5AArvct954vdx8WoUPV4YZ25CPonMY9i55YaHjw7PJ4vVreSRB/FPlGNhdnNz
	 VpClL+e5/rHZrlnxm3e4Y8UzZfJ3MqUS7zftaHOto5yGE/aC/kLHcXcHgpd2x6pNb
	 e0xdm9LTJMBNf4tv6Fm1KneV83vosSM1IfD7vE3XDMhc7J52A9IdBi/Tnn3Bk4cGu
	 D5B7dwHCk41rJoO/6QKLL7jr9nR2VqLJoJfxQeyMv9KzhKwFWFhGunt7NvLqqQDhe
	 xPecm+lcJPwR71Prr61A4ePoJLeKXwdQY0yqi3ygzcCkcDZl9zr73NVI1T4pBx6aC
	 TBSacgNek20op/6YYg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MG9g4-1tDf1V45YC-00D5oU; Sat, 05 Oct 2024 23:38:30 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	corbet@lwn.net
Cc: platform-driver-x86@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] platform/x86: wmi: Update WMI driver API documentation
Date: Sat,  5 Oct 2024 23:38:24 +0200
Message-Id: <20241005213825.701887-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:x4Cdm+DUid0ntpCzyP44tKz70IVW8M6YATczGKYBClRA/OWYvJ3
 SnTRCs7xbJzCNdwsJVKN1Wxvyni+snG7cD8/87X5zNNDFFx8j1ljTj4M/hCFFxi2KxtTkF6
 ixFR6vHZOwGf9ShikiTkcW4SrO1jm/nuRNqt14LVvuZwp8NN6snHgd0G85X24vsYy33EdUr
 oDXEN5znKQv7uF82dHWWg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Wvc28mRAWnE=;9naCnTc1Lj9EZklzJbnqdfljuql
 9IbjzYjLV/erxWYHDWN6+22NRRHexJcZzuej5BfPZnpj/sGXgYsb3xIpaX6HeS3jkC1okQ0sV
 eZiUooXbcXMf/rI/5srpxNKYP8XH3LrUnRdQ/eimttHxQSu6lrRtAtrhVQB/luCNFx7gIsWwy
 2oU+/GURmiy8Ij6KPBkboYLNPbYWo8qAJGiKkdoGt1OvtvOap0Si1oRZDAtntpMJ2lTGCjlmU
 GQWsTXasXM17otNtuMIDcl1eWu4Le/jhi/p+n8DMI+7KzN+j2/XLaSr2uRzP64OMlrM82xb9F
 5g4gWIzbEf3FMWsknCMZlgsRBD7nO3LKQgCMlAAs/vyV/Ku2o9+5xPcopozUoDCKBQP/Cg8od
 pQBKqO+aF1xOjPaHWudOUiP2i1QHw6mA9J8Be7odZ+Oz0C2Aqv1o95KO5UQIPv95rnYc2J/5n
 SfHVuMuEt5AVn7OeByS4I/F5V+4s4deSQqiUYPSIVc73CPRsoKQ5HfGVIXDGWL3Px/1e1iZfd
 yDoqb6KybB/x0AOjDZvcNGVwH4eX+15YvZGT2Zi9nQBL5GxGhLW4RfYtfZ7KxPPT5XoU8Xqh5
 QkmDeCmJD46MeB7OJrCvQgk+wWGP/OqLQDUr4E/55kO5wjE1hFlXjh9JCvdVGAY0ngfimiujR
 r1dXGoHAY/+D0FcXxKtZmD5/qJUznJCfMPEeCf1qBcdM56/9TAuJcKDNl369FK6Fmf7FspEyJ
 SdJs4u96GcXZRiEHug0b8uFTM+k1frfh2sRcPLoLEl9yskqMQvCe9k+LLTWJuY+AGQhNtp6nH
 yAywVeK/rTgoMpC7Fi0gEE/Q==

The WMI driver core now passes the WMI event data to legacy notify
handlers, so WMI devices sharing notification IDs are now being
handled properly.

Fixes: e04e2b760ddb ("platform/x86: wmi: Pass event data directly to legac=
y notify handlers")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/driver-api/wmi.rst | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/Documentation/driver-api/wmi.rst b/Documentation/driver-api/w=
mi.rst
index 6ca58c8249e5..4e8dbdb1fc67 100644
=2D-- a/Documentation/driver-api/wmi.rst
+++ b/Documentation/driver-api/wmi.rst
@@ -7,12 +7,11 @@ WMI Driver API
 The WMI driver core supports a more modern bus-based interface for intera=
cting
 with WMI devices, and an older GUID-based interface. The latter interface=
 is
 considered to be deprecated, so new WMI drivers should generally avoid it=
 since
-it has some issues with multiple WMI devices and events sharing the same =
GUIDs
-and/or notification IDs. The modern bus-based interface instead maps each
-WMI device to a :c:type:`struct wmi_device <wmi_device>`, so it supports
-WMI devices sharing GUIDs and/or notification IDs. Drivers can then regis=
ter
-a :c:type:`struct wmi_driver <wmi_driver>`, which will be bound to compat=
ible
-WMI devices by the driver core.
+it has some issues with multiple WMI devices sharing the same GUID.
+The modern bus-based interface instead maps each WMI device to a
+:c:type:`struct wmi_device <wmi_device>`, so it supports WMI devices shar=
ing the
+same GUID. Drivers can then register a :c:type:`struct wmi_driver <wmi_dr=
iver>`
+which will be bound to compatible WMI devices by the driver core.

 .. kernel-doc:: include/linux/wmi.h
    :internal:
=2D-
2.39.5


