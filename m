Return-Path: <linux-kernel+bounces-246061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A3392BD28
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 16:40:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BC7861F253B2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jul 2024 14:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7136219CCFE;
	Tue,  9 Jul 2024 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="OIaf+5Eb"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B0A1684AE;
	Tue,  9 Jul 2024 14:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720535947; cv=none; b=LFL/rkGjT24h+C5NxxQ0Xc7tIgZQo3vifNok+yws4wX6DcBMCcETtKf6YBb0sEctG7rbXB4JDPJNcSPBSnE5HH/+yCn1T2kiE3SKitxa6L/tD71RBO2AHP7Ct8EbO94953Icv7GGhOTA6OmNPSZvE+c/MuOWtX72dzq3/8r85wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720535947; c=relaxed/simple;
	bh=0GE8MNSDH3Sj6P3Cex4jOCXxsjFoMGMyscdKZsmrqA0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=djy4rdMTdJt5GWilWbX9EixY5W3gSAKcRnqfeV6zrPHVvvWkwFqtmO2i0yYTC6f/yMdlnzdTuW4zEdIGFC0DDk+P3u13XwRfEu+YxGNOmYR7Og3FA5pRsqnaX5TBIja+TjUnCPo1YRBMtRdLX7IZgU3s6jWcec9IFF4w15ns830=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=OIaf+5Eb; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1720535936; x=1721140736; i=w_armin@gmx.de;
	bh=FbCtUYHofHcGA8NLgniQK4sixnIWhvRfomMMUvQXIRE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:
	 MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=OIaf+5EbfOuW45XiChM32gc0DGtuDN8oTu+6hrXnl//R+QlcDsgbUfddGk55WkzG
	 V/rJoIX9ttqzCnCuvusj8LR2xKw0OoG9ul+2/DcJjNmfWlDR5i/Y9dLd2CmUuU0ps
	 jQvr14jtDJMTsqTGn1wY4t3zhHTbR/6SA0VGH3CAQvHs3rvCpmnT++oTRPniNIRZh
	 +9TjqmC6IyK8Ir+qOWfB0uKzIbWy4WffvOM5TUbwji1wiIRKLtOuo/EY+NKDDGv+W
	 ziidRzklHmGSnbTkPGbV6jld2ykj48YmsdsfXzAF+B5xqvo7Kx38p4wRtV1H/5kxV
	 dBdIlqGRuQhdncn5Xw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MFbRm-1sbgfG0TFe-009Hts; Tue, 09 Jul 2024 16:38:56 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: coproscefalo@gmail.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] drivers/platform: toshiba_acpi: Fix array out-of-bounds access
Date: Tue,  9 Jul 2024 16:38:51 +0200
Message-Id: <20240709143851.10097-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:OQNN1zf+g4cYRhcc+QfQSNU7CivJHtMDWnsmS/yDRgQ8aLWBA1D
 K4ffr+ySx1lcn6uQRD0nUWqqPQnC5TE89hQnnPWqaTKfX9NSeOKHgEd5n0HRF9YklS0DlvI
 rDJBJ8u3JsuKuXZsV5QTtbxsJBDlPOaJvV9TXo9iEaRpRS3yyKyTNpYpWpQvZJtkmbFEWbe
 9fRhE+mT+Dv4raqObHtLQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:pHZy82Z+vs4=;p+6L3xOdMtRcW1/F5s8XqyY1kol
 leSMuxy3B+aI46T9ZwKHXexpFB84bLn3mFdw5I+/LUubge76o63PIS30/7sCEhgXQRM8tWZUU
 G+ge+H/ATKQugTIPZDZokJtzCaBNpGxXTyKO6fDe2eRsDT/Wp51YGpjJ2DkLXgY4BIJkQJ1JH
 pmVMzviK6y4+21fXic6LJhRtfx00PuWpKu1+ZAnx8a89oZm5jghgEPkj4gPQkmrF4wKlmQQQR
 oNUfTLio1QEixZWOA1M2Zv8gMCB9sHPJG2Gjrl0v1xCfDkTS76gQFhiTBGmY52cl/nivyc5Ll
 cLa/D6QD6c5j6noXvs/5/N8bnavjyL5jeEebbDE79EJUdhHcq8vk8oxoRzO7PIEa1CtrL65oi
 AUseMeoyHlG9qDAJna0JlpSiCsnXl0BOgrQdm7J3x/pjpSD667dvv+4nDkQj1xpkNhnFPXg8I
 l5KUoAcyRmG75XhOf6DnRhtYKYau1WRbaLQ0z5if4asKUYtdN19bvNmlCG8NG4Ibq/W/cgIt5
 cg0hm5iwCxqYiD5lARu5WLZtfuoWb+m+HKikWwKHdHb69qeObN33Z7RBV+WGELTmvWbT0i1T0
 wHm7BrQuVueRaxcc5NjvdZzmhh6d3wu1AuVeH9UZ0ehTGQLxzMv4IKHETBpfK53rXDRLT6jpC
 LNn/c6lwj6U/bACb40skHmu8HEK5BWHXQEK9o2/diLB32J3dE5AbI6MH44gJPyHh7xhsp95up
 HdShfOSweS+VzkB/IHAVVwzAoRsgPXtwY89qBHnd+91Y5X9ml/3jlMVO7//AI2sR0MU2o6/j0
 ENmsduYo8Q1QuGlloBHVOXezzI36OeBEEYrzHob/umwGM=

In order to use toshiba_dmi_quirks[] together with the standard DMI
matching functions, it must be terminated by a empty entry.

Since this entry is missing, an array out-of-bounds access occurs
every time the quirk list is processed.

Fix this by adding the terminating empty entry.

Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202407091536.8b116b3d-lkp@intel.com
Fixes: 3cb1f40dfdc3 ("drivers/platform: toshiba_acpi: Call HCI_PANEL_POWER=
_ON on resume on some models")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/toshiba_acpi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/platform/x86/toshiba_acpi.c b/drivers/platform/x86/to=
shiba_acpi.c
index 3a8d8df89186..d54bccec6ad6 100644
=2D-- a/drivers/platform/x86/toshiba_acpi.c
+++ b/drivers/platform/x86/toshiba_acpi.c
@@ -3299,6 +3299,7 @@ static const struct dmi_system_id toshiba_dmi_quirks=
[] =3D {
 		},
 	 .driver_data =3D (void *)(QUIRK_TURN_ON_PANEL_ON_RESUME | QUIRK_HCI_HOT=
KEY_QUICKSTART),
 	},
+	{ }
 };

 static int toshiba_acpi_add(struct acpi_device *acpi_dev)
=2D-
2.39.2


