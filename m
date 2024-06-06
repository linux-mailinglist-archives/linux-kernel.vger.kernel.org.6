Return-Path: <linux-kernel+bounces-205161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 502C18FF83C
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jun 2024 01:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D62D6285E4C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jun 2024 23:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A47A13F439;
	Thu,  6 Jun 2024 23:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="gOCcFXGQ"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53058140E4F;
	Thu,  6 Jun 2024 23:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717716971; cv=none; b=grvLSLpkSi1EokTGKfOuJwfetWnfJpEeEfwH9Bv2zR2HnsvfeVVM54t8QC9gEtyZUxPWV3WQ62krZglrkvoPZRxtlF2qj5QmTrNvotLM3gJYgZES+3+d4vqWoAit57fobJmrvc4M0bw7avmyG0A7eXR3PS0h61cH7rZ+1PH6wXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717716971; c=relaxed/simple;
	bh=xmPYtFq3q5IrE/3h9h8aA8hXNZK81eArdkgqdeXQ/1U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=R6Ug7vwEYm3294wMogbd+Rs8au0iMO5XzIYm0KGvdq9T09glnO4DLD0SuZx4nwHyUHickjC0MQcK3XgTpgxiIG+e+XBWv1Ht/eFCQ9NK7FR9JJ/pdkJERpBMVSbAtJbxnPhila65AporlLFhlxDVnfBx3v64s4IkBBQjmr8xB3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=gOCcFXGQ; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1717716962; x=1718321762; i=w_armin@gmx.de;
	bh=kBzkJHv8vpR5YX8Wf5bPU4jlaFIq5F45CkO0nRM1p1w=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=gOCcFXGQlufh8K3ZineuOES+qzEzYR7g6UGr9O7qaHzMvAvA+WKsZToCRvancUdk
	 +MIPcTpXsTS/PVUmntvF4Dq3/FdakW5MOr4/G/0pEZ0wGWP3h8qfR3XwcEKO92E6d
	 sbFfQivWVnzPb7LQn+fKH8imScs20zWhX6Drpuh7i1kZPtxo2Am6Y6ZNi0BCXHAP/
	 ybmJJ6a6pH7aIkbivcBG1Y/LZRfdoVIr+SG46u0PWodI4QCAZtV3d7fFCDEV9my/B
	 LnDNj6zDsHgx/czXEJflmW79vC9mQ4Dp/aTjKM5arjfoouW0OchwvOXIo35GIJwH+
	 rIUjEekzBN8t+xqt5Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-inspiron.fritz.box ([91.137.126.34]) by mail.gmx.net
 (mrgmx004 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1MYvY2-1rtLeM0RKi-00Wctn; Fri, 07 Jun 2024 01:36:02 +0200
From: Armin Wolf <W_Armin@gmx.de>
To: matan@svgalib.org,
	agathe@boutmy.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] platform/x86: lg-laptop: Change ACPI device id
Date: Fri,  7 Jun 2024 01:35:39 +0200
Message-Id: <20240606233540.9774-4-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240606233540.9774-1-W_Armin@gmx.de>
References: <20240606233540.9774-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pG3fLKSVL9iZU0eNC7DQ4bvNRAXZtevo0MmTeE6ibgp4P6Yi93A
 VuDclF+vdasupvJdWvb6ErNa5WIjWVSnYPq0IfIoa+zwzSZvf53QBNqoO7W7qhrH3qb3bNl
 cUL8ZhGXQZyRYmIaIaS3hyf+Votr/I20P6U1uTr1e+siMhETFlG8PR6yj1H4OMN7voQK1UM
 Q60XSBvcU0k9k3lmqaTOA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:Xsnv9frPWiA=;1gOONwCDNsqZdSL2AmdV3U1845z
 gEsL4MFMJgBCwGF+U+tGCzh0GnH7coXa13HD3vXTyuBIdRqU3jRfPOQng+miji5ky/D8jy/HK
 nuh/RVfzekvHQh6+e63qLQnWorFUW0vELDbzP4gNdHgSPAkAQau30jSl/QLA8xGRt3O7IEs7t
 m4wzhCLW8umKbcxaTsLEq7mmCZM8aE6X/iVeghUehiQGDFOCSsdSoUVWfZY6njKgSGo03/rOL
 cq21mDrvEPzcL9ssjzSnsMR9CUFekJ+eMIkx18pl25KiiHwzqtCV5Gcd2mDyHLGPWKES/kzEx
 Y+mkqQ6pD5XVM0QB6jBTqcbehkfEM4pc6ZDUQfuSdAL6Z+zZR77fOl34+JoAXmSdTcriAxUEN
 +JPox91Ya099OSoHljV5X/fUsVpmQoy/IB/dNdpy57CBdepybna1rg+awVQJOS8Sof4cPU6RL
 o2UIXXUA49EW+fZoBnpUQKaBNc3wWXKxjJbQWUfawDOD59syyEVIgOQ2YKu/bda0z62rzxEp0
 rJjhbpFt9i3WWAXdF669Uz1xZKpA9ajQOcGK+VbKWjrVaHcOJt6Lts43VocuxoMEDzNO/KIap
 rJVOi0vWCoH+v3WXEwWAbol2235+sbMDKYt+TSzBZHsniiCC9rJMuFNXeVyfogrQ1xTwcRC9i
 B/IhSeoew5bOd33ngWseJfBN7C6LnpkotwqlAj0WYcpQOdQfDqtt39SvUgWbF8XXKWRx3Gz5n
 xg8fCXxIOtesQgGUFrBzb/zAiNCfTSRZSb5349poIsWoIB/jj0yDfUEpM9T6NJ8KYIfs9j8zI
 J2WY8l9NfdJfQjWjla65us9pXLvzk8QNNyMrDyxiCeP1U=

The LGEX0815 ACPI device id is used for handling hotkey events, but
this functionality is already handled by the wireless-hotkey driver.

The LGEX0820 ACPI device id however is used to manage various
platform features using the WMAB/WMBB ACPI methods. Use this ACPI
device id to avoid blocking the wireless-hotkey driver from probing.

Tested-by: Agathe Boutmy <agathe@boutmy.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/lg-laptop.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/lg-laptop.c b/drivers/platform/x86/lg-la=
ptop.c
index ea83630106e8..db8a2f79bf0a 100644
=2D-- a/drivers/platform/x86/lg-laptop.c
+++ b/drivers/platform/x86/lg-laptop.c
@@ -768,7 +768,7 @@ static void acpi_remove(struct acpi_device *device)
 }

 static const struct acpi_device_id device_ids[] =3D {
-	{"LGEX0815", 0},
+	{"LGEX0820", 0},
 	{"", 0}
 };
 MODULE_DEVICE_TABLE(acpi, device_ids);
=2D-
2.39.2


