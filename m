Return-Path: <linux-kernel+bounces-516776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3DD7A3773A
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 20:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4ACF16EACA
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 19:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00EA21AD41F;
	Sun, 16 Feb 2025 19:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Uv6mBTab"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F31E1A3161;
	Sun, 16 Feb 2025 19:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739734428; cv=none; b=Pfur9P8mwUPIgow+1zBdCDQszPjeFbyZvTCmT6V3iA4VQmjPEf/TLGQIuEquLnl/Czu+3VAUjayzzfOUngavma6dd6nsBBWwLm6stExe7fDknF1ZGVtc9mqRwyfOPGIX4xX1e5PkODYdCuFqonUY/6HkcHtHLxwhCbIR6p6Lkjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739734428; c=relaxed/simple;
	bh=kVzMWrgel67Mo9Ygay0IYNyhWBOB4SrG6RdEbD8Pw0c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gIVszBOcxmMAPHP2N7/Lu0pOQFck94/ZJOv1S4988Or8dnVOFNfZxe7982ZAYGlzZe9I3NwRNUJkzYaZ9ieaf62Xotr0a/RW9+DDg6dnLUACIX6NWE+Kbrm9rsrIBUNKu6sDPS8mwMwCOPEsu/QykV+BHlLyF+v/JPYepQSPqQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Uv6mBTab; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739734400; x=1740339200; i=w_armin@gmx.de;
	bh=l76DFXanPHoGvanPZenEdjlmcNhNLDXwwR/QizhaJBg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Uv6mBTabls2fFkqDWs4kLofxEpUx7RPag9xb7eZe82qsTf3HpGqpRMlzVri1j1G+
	 X8OfueEl4eQaFHNC8RqCdp69XbeqiZOhpl3FZFSibhP3Rxd1TrB8xpJTuu3VfiFb8
	 2U70BBXUC4HN2uGZRQJbi33uVEYrAXwUtgM7Wjzf9ng1Mtk7Quo6uW0rsTPcY2LIq
	 QQoOXg/SYw86Ag7hAc8coKJkafzfHHIlUPBMd91qIYEP91FBQe/Uj63zKfWo9sQsK
	 BxnlN4FwmYeMkZS/Gjd1P74xtj06OhODmLDw+RJI3GZNSivCGKk7moy74WWcH2J5e
	 5ndNqPahg6sazgO8aA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1N1wll-1tLzCI22vZ-00xljU; Sun, 16 Feb 2025 20:33:19 +0100
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
Subject: [PATCH v2 7/8] platform/x86: wmi: Call WCxx methods when setting data blocks
Date: Sun, 16 Feb 2025 20:32:50 +0100
Message-Id: <20250216193251.866125-8-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250216193251.866125-1-W_Armin@gmx.de>
References: <20250216193251.866125-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F57wgiORwOAZmkbtP4YoHkBZ301swdj6njSKsDQY9TMzbVvrezU
 lGMd+twSMeydRysUd3Lqf2gMqEgKNjgX2mRBEEGCKiXcrLm+0OKqMjwn4xYyKrL80P7MHfS
 CJM/22Oe6VkPSo2maorrwvSSXIsI9ZK77ylcmqRgFfhu8XI64jqKa6tcGdBhxlRKsXhywRw
 GCere+19zcITPMIsLJuhQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:gHvqS0MJtWk=;xYyimcpvjFI+5keTpMX50YmnS0a
 vRn/imuk4PUnKFcOIcoZ0McjtXn8Zjyd8kGvKOGyMkKfUBqmDeCbUhbNbdAQM9h+3e+1753zs
 bZfq91c0qeZ+JfODfKmLtFafY5Ss7VHxQ3xtxbFMGVRhBAemNvKGF58fAuX1Zz8NjLNrkpOt4
 XDUOphwsaKbDUwQ6xtLye53qLRc5EHYlE9FsRnrGZY4TdjcrDYaiIK/Fojl12vQ9SVNo9UVYG
 zVaskswE+nWJCwbSr3D8fmx0XEHNOjtO7gceT3hB+k1e2hKny42PO+NfI5Q/bfaRM6IrCQSOY
 0ghpQ1KI0iIrWAd1nxRUSIZV7+QJnFI84aviFM5bWl1SqagO5ZJUZGXlNbfM7VSh27O7JtAzy
 pG4Kye691RN6BCv0HoCHX5WEEuP/afOJ8yDm0DkRVfpkm3vTAc8Vb1JZOOWXRvXctls+1by2p
 b1QkGGGbUfORPHtVUdM++D04HQrGdFsD6yo7ESjq2Ueuuoxs8kY9CAUjo0/fTgRSC+tEdB7re
 AGR+Myl/n+tkmIhdtc1tusEXTHjX1CTRoqcBcw6vJJWYKloQbpvffo5I2Sid8mJXAXsj8+nLm
 erUg6fqkqyihB6ens9lDaSdSffqyEcxxzM3RWQnSrnrpAXSFTc/bqH/MZmS5irNm5oRpekabC
 2QDyJVwAOUYhT6gwoSrpn7tQcp/MKmhPBQDnEuGCQywLX5ZIaAi8H6wlmy6IKJWyin2A9mIev
 tnlfXmVSgDHOPRa81cSP+T3LwllEajcEd8t3nyAXOSiCrbVfbX3ZPzzhL0ROJsMqGkhirUmSp
 pKo86QlNEGw44xuV9p4ATvr8KAGE/WChHE8jYN2nxBvvAaPx3qhfo/OSvg7LSu5kNjyIgw0iJ
 4LZ5KzVRcCk9fg4tYJl3jknsO+Jfuj6J/2E7TZn8pGggwmmALDvGqPrYI404XlQkq+VMkQj4t
 oRQRVmndBjmDSBcw+ciZeQlZlb+bNFqMfaOAVQ/p9vmGQgPbN8SuEWJ0O2mlNRvzUpLS78a/m
 bjq3fOOl1W6xBCU8rA2SA1wGEa1hZ0Uc5LjyjhFfMVU7Uc2cx+9cgdFbu4rKSC8mjroVzGcnx
 7+z4Lms+BlA6tdagtC5GEXT3G9n0s8zxAUdAs28ez6yBb9Q5kEOc+qoFezdWktVcqnws87obC
 /nDlxat+ZlwAoy5h2XiL5WUpaqZnJCrBo3ZYImy1sZXDANziGs0On5G4U/undSws7DhgOWqHy
 IeoSftF4QtwWYWVrN9fqyJvrDzyp7Bi16ahC1ivGRJoIzw0EEasQRRmH7YXOdbA9qaRIiEXdU
 u2zmcqxlsnpOUVrND+WyxqzW7YWY2YVoVSPmFjlO13ozgXvPrHaIgXsqOPaTsoBKIdxMC/lI0
 27INI+NvPJ54rIz9lgDitiiqlgWUPDgv5QK6EL2eEHmX8CQKYUdmQUClfPtAJ7ZtbU1X9Unr3
 mbJfX+zclVK5l2dhF/DDltzMW2Bzs9z92wa+fDj6FWRhKWuS3

After performing some tests with a custom SSDT table available at
https://github.com/Wer-Wolf/acpi-wmi-ssdt i found out that Windows
also enables data block collection even when the data block is
being set.

Emulate this behaviour to avoid confusing the ACPI firmware.
The bus-based API already implements this behaviour, so only the
legacy GUID-based API needs to be changed.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/wmi/acpi-interface.rst | 3 +++
 drivers/platform/x86/wmi.c           | 6 ++++++
 2 files changed, 9 insertions(+)

diff --git a/Documentation/wmi/acpi-interface.rst b/Documentation/wmi/acpi=
-interface.rst
index 06fb7fcf4413..f1b28835d23c 100644
=2D-- a/Documentation/wmi/acpi-interface.rst
+++ b/Documentation/wmi/acpi-interface.rst
@@ -89,6 +89,9 @@ Similar to the ``WExx`` ACPI methods, except that it con=
trols data collection
 instead of events and thus the last two characters of the ACPI method nam=
e are
 the method ID of the data block to enable/disable.

+Those ACPI methods are also called before setting data blocks to match th=
e
+behaviour of the Windows driver.
+
 _WED ACPI method
 ----------------

diff --git a/drivers/platform/x86/wmi.c b/drivers/platform/x86/wmi.c
index 97c4a161799e..db76c5bc6e12 100644
=2D-- a/drivers/platform/x86/wmi.c
+++ b/drivers/platform/x86/wmi.c
@@ -461,8 +461,14 @@ acpi_status wmi_set_block(const char *guid_string, u8=
 instance, const struct acp
 	if (IS_ERR(wdev))
 		return AE_ERROR;

+	if (wmi_device_enable(wdev, true) < 0)
+		dev_warn(&wdev->dev, "Failed to enable device\n");
+
 	status =3D  wmidev_block_set(wdev, instance, in);

+	if (wmi_device_enable(wdev, false) < 0)
+		dev_warn(&wdev->dev, "Failed to disable device\n");
+
 	wmi_device_put(wdev);

 	return status;
=2D-
2.39.5


