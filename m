Return-Path: <linux-kernel+bounces-193070-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9668A8D267E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 22:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 486E5291DA8
	for <lists+linux-kernel@lfdr.de>; Tue, 28 May 2024 20:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15584179654;
	Tue, 28 May 2024 20:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="SZC3uMbY"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6B671753;
	Tue, 28 May 2024 20:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716929363; cv=none; b=SHHoXR6YkyMrQnZFaujOMHCc3Zw3ZqEWQrn7cgNbRX/2BVE2fuI5rIHeD2CIjNjOb61xLLDuMvFInH2zb1ZbD93w5ea0W2WzycBx+lPNd4TAjz3X2JPujjL53+FTom9Uz1SiRia7u0FpGk/yE/dTPFN4SsBca64EbyLGhFij3QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716929363; c=relaxed/simple;
	bh=cd/SbaQnWmAq08MyAtXZ8t1qjAc7VyezJTSklhCEWbI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BFa1HAacjk033FiJXH94pIg+8SxfIMlWAQ/oUW3112wF8FVFvC03Wi/tojskG5AErvpTVtC3Ndv6sFAI6n4MLlhbQOa2FCEtnCKfb62ZLlOO73IcLNATQgwABEwKwpTxAiOEfTbmOSJqS4ZCc716Z94W1AztNMaSscuCEbILGDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=SZC3uMbY; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1716929350; x=1717534150; i=w_armin@gmx.de;
	bh=Hpk5WF3fBlOFgzw+1dpUyIelI8tfyqNS40822E06XGM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=SZC3uMbYBs6x5oiXHLHfM0iwLrzsRr8ZG8oMDaFhWIb5fiwokvvJeZ1w7auYSGDW
	 BaexouWpjObywthVDMN9FExkOcJBFePrO+0JoNhNZQcr0VjBSeRH0pK5tL76kQnQS
	 xZhAbroe69b2ja7m3rdo4qTofwCiyAQXfGLVXcv+J1xHig7vagH/keOdPamq86qJI
	 S6Oiuuvm6B+FYpI+LhFqxyK8RPqFi9s6XF1c8bj6bPxk4iw1kJQEW8eujZGR1/Hxu
	 EN5ilQwh3yUGcvVgjEC5n/5FDLlq9v8ySI3VKeB0y45BRYqpPAXyYSwb9Bbw15bsi
	 gAlD6jsBKl7xq6xpcw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MTiTt-1s4c1r39tF-00QT5R; Tue, 28 May 2024 22:49:10 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] platform/x86: dell-smbios: Simplify error handling
Date: Tue, 28 May 2024 22:49:03 +0200
Message-Id: <20240528204903.445546-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240528204903.445546-1-W_Armin@gmx.de>
References: <20240528204903.445546-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+UIIXA77L1iidDRteJr97oG5jSONXoEfxxwv8Sc7Sqyg2sOT6bK
 +CDe82mMUFq1flfWdR6Z9xrDhji4iQjLCvqsWVTIZ6HeLnlwnt9dZeZg7u91M8gJcznlcTS
 FTFDpSKNf9ZGho/2FoWVF1KI94FWINvg+yyNqR460N2rOo7TbvZsSYlez7Vhed/cMRZUjqC
 WvMTzTc2gXyyRtKlL0SYQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:FogjPxr2wa8=;hd8yRzrswIPSCQ+KJkOZU38R25L
 X0r3J75YxvTyvuzR7DBPYpf4umYmpAUhOjQW9i1FP8n5ROJ15+dlwgNbmrQT1qmqIvQrzVmGb
 LbBGj+P8coJdKZPLzZ0Xjyga3QoWBuVWcftz91pihotC3W9H0hfsolfjgJF4bGDFgc2JbbINS
 G4dUjziG1VHUQyBvU1BV4vbAOnlWMDTJuWNX44qzwZ1FWG8kftVQbSX0s6/hsSCyr0V6ll0uB
 zTzAerIaQF2j6qP+0VZz0ELzDRHlIdrGGuKBZkPIwLqtQK6BCPu5hBMnQwhyOCuaePQceiclP
 DWPb9PzWEVejZGJgql5TNivqGzRV0D7FtVM2enw23fML8NzBNNCrnoKEpOhaE824rjRijqBVy
 wq8sRinYJdjusXfRkdE8mpN+1fPc+K3jhVS4vwmAjpzVSKcqS/lYK1c7OGinToNQRheTvwTJ/
 ZA0AtusQ5HQy1P+6+p3HOZemZ9hwtb0CWsn0uJ5mKE7ObNIRDijv4qOWHLQ1y3z6l52j516RT
 JR4tiAYdk5HMyM/bnrkm5DBLaGFiJ6fPGLBy1vMFAuW7YyZiajaa95xfjhSlzT+7piXe8sUsl
 uJV0LTgXNkW9Xxpoa8L7hITpRiHfXDEvo2Ur6hjC56PjczD0pcDeqfRkJw/0SusMFUBIAoIz0
 X8gig856l0EqPWXDVEo9YjYuNWcdF0LOsS9OGogTu2P6ia/OFVDuBzvoxpQMyio746K37VH0i
 otjJn4yHQMzGtIAuVQAvPuf6jiUXeXqoq5oK9tEgduirzqF4bZvvPlf7M5uTzEfafwnBue4eb
 KkeQ2RwNmhv8aIWeZY9HAo12gwd7vQ4yV7uHsO4jjWjNA=

When the allocation of value_name fails, the error handling code
uses two gotos for error handling, which is not necessary.

Simplify the error handling in this case by only using a single goto.

Tested on a Dell Inspiron 3505.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes since v1:
- add patch
=2D--
 drivers/platform/x86/dell/dell-smbios-base.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/platform/x86/dell/dell-smbios-base.c b/drivers/platfo=
rm/x86/dell/dell-smbios-base.c
index 86b95206cb1b..b562ed99ec4e 100644
=2D-- a/drivers/platform/x86/dell/dell-smbios-base.c
+++ b/drivers/platform/x86/dell/dell-smbios-base.c
@@ -492,19 +492,16 @@ static int build_tokens_sysfs(struct platform_device=
 *dev)
 		/* add value */
 		value_name =3D kasprintf(GFP_KERNEL, "%04x_value",
 				       da_tokens[i].tokenID);
-		if (value_name =3D=3D NULL)
-			goto loop_fail_create_value;
+		if (!value_name) {
+			kfree(location_name);
+			goto out_unwind_strings;
+		}

 		sysfs_attr_init(&token_entries[i].value_attr.attr);
 		token_entries[i].value_attr.attr.name =3D value_name;
 		token_entries[i].value_attr.attr.mode =3D 0444;
 		token_entries[i].value_attr.show =3D value_show;
 		token_attrs[j++] =3D &token_entries[i].value_attr.attr;
-		continue;
-
-loop_fail_create_value:
-		kfree(location_name);
-		goto out_unwind_strings;
 	}
 	smbios_attribute_group.attrs =3D token_attrs;

=2D-
2.39.2


