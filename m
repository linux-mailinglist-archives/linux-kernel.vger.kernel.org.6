Return-Path: <linux-kernel+bounces-516773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 915E3A3773C
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 20:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF7223B05D4
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Feb 2025 19:34:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E7C1A2C25;
	Sun, 16 Feb 2025 19:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="YofqQONP"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78B191442F4;
	Sun, 16 Feb 2025 19:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739734416; cv=none; b=l0ZIm2DwL/+aP+CSKABQ62w6pvdNnHbE5WxYdhwOmtpYVYc2nbaPar2+ZFybKbwWxDc63TA0xPPGYoSHFh2isVqYdYtRaVXMIZhpmvY4JMZnWeA0usAvQYc588wDpZq75xctMosUm08Bi9TyoUdQF/E0gJTNr8qJ/iwr7ak1+Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739734416; c=relaxed/simple;
	bh=ID+lTHjLVqPJ/7xdhI9bJLFn9teO4+JhdZK9zVjbwuc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=a2mj0F8Wy2b8WxQC5VZ5tojosZmjZcX4rW9fG13TDf7OKbTMrUrUL+ETdKk+OyfhLK30gV1w/hCrtJy1JtGHCV+s77eGlxiH5aY+hstIn+0BmbidAu6pRoB+oz2t6uEq48ICiHH8tETXWbbVs8VZ5o69yfOwxxOEOudlOLXqcsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=YofqQONP; arc=none smtp.client-ip=212.227.17.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1739734402; x=1740339202; i=w_armin@gmx.de;
	bh=RuoP/0xYYt9z3bJOrdWbm40zFLkGkpfWsyjNl2p49Lk=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-Id:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=YofqQONPxkGF4mtz3bgvN9Z6scS4u6nIMlN84xIgZhvl7oFm/grcrAJAaT0Vh7Zp
	 ElVzIsr8LYJDk7DW5hghn3QcnZghUH4mJfuBNgZg8LGxJAJ0uk9bpjZIP3xmFZ3AT
	 AxxEgg426ujptIlghdvrsfbeV1O2q4y/IY+5SEz+ZTk33joGBwt4PwE1KifCN4s0J
	 rcMD+JuNl0LuATfNqI59CVMaFPU8/0q1dPc3D6iHkGhjOmt+5ek2NZoJwCcDrhPJ9
	 yHS/jvtq+ZDP2OuctWX+o6IGTuciKWltBk0KJInAeKDT0VzRy6iOUvVCueTdAEBoK
	 X8x+Mdxw9YsvV85l2A==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.fritz.box ([87.177.78.219]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1M89L1-1tf3Z30C3f-00EZn7; Sun, 16 Feb 2025 20:33:22 +0100
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
Subject: [PATCH v2 8/8] platform/x86: wmi: Update documentation regarding the GUID-based API
Date: Sun, 16 Feb 2025 20:32:51 +0100
Message-Id: <20250216193251.866125-9-W_Armin@gmx.de>
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
X-Provags-ID: V03:K1:unI5ci7/U0jgo6xrp2Iof2EdkjfoF+u7bew6UozWBxMoO0QG1zv
 Dz1J2CiXVy9iS4ngz4eN/f1rHLYCgOLZJJQg3jvzL2zgSnWhzwRQJYvGVsg9AbljWV5p7VR
 Vgd0veZj6PKMsrC0Vrr9LE98hZGhE4HugjH6bVKr1Nys+FghONDc4R6t6RyJ3yEM1Cgs6R/
 EPEDxptMriX8ZmRlbSP8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zAsFx4RIdlg=;5gtkmqYph3E3jIVY4WKohVAAftX
 24bLG9z7I0K0O9d44CS17M65bLznB6lLCQclU4oINLun0YoqIxiKLE/zA5uod56STGWQQpdiP
 wZPmDxZVKd3KQ/oZdPXs+++wm+I+bAmM0yxUe4lIN/QXoXVP5n4Fy7OO8LjjTP554oWDf762K
 gYTbBVFNVv5onqQBnDESJvejKvzeQtzdEwlbb5PKN8eWG43ookylgKlj81rjLEBcqh/0jqawa
 VnOxz1vp1wMCLBp9ldUHpQEKRnhxIvALHVrKPtVWLfGOBWpjeVNCfsp5H3I/Oo2hQLqYwDkp1
 u872kRg5AyBfwBgvuqXEM3ze8aMXxYyUtYhFwsTOerFgcPuBvJABNFStoIroubAztzPG5iipH
 uuJKPj91QjouYgjjDXbMBRkY7V7hEJNFm8rnVmC/6OkqUrS3uDkzdWWgF8/en677aDtI8DnW7
 oi2r7rfDtF3y2gLIaMf3UJmZRyKqNxHJ9QUod01uLHbSAJd/i0kE400MnjjkX8bgxI/ly1N/r
 6nc/pjpnW/cgb/DvjMYHPeCTc03ESCM3b+i9SjvkeGRxAKaaMrLQVnQGqr68ahbbnbNE7xgq9
 7qnCTdF/Ne9/cGv42XmGA6XUpbFeY3QF1lfZD+1enad9gJT2+9ODxRo5r0n4MirVthObbgRSr
 zBiAjsOXjqi+v8gukmvzHwT3zQyDoIn42bz93D3LvqB7HulKmyXpLiozhNXq8SeZ+lR0j9pfm
 cpz3GvhF/ktHTKfTRuTd+UFPG5a2T30YljsNy91dyZMzvzrHaDGLIOX8fZUk4JfG/21i58rE1
 O9ab4kLcrQbCSGPX35v9hODDn6jXyI1HaJ3/g+UXYUOOqx+trilI5VoXoMmsrx37qscB6ewd0
 JyP+zTo+3x3d0YNey3AEhoG9JVttwhHP935gIfRdbl9bCjqFak36Ye2W/iuMl9vzhJ0JEbOoE
 zGEOY5nsU+XS1cY9ial28hZzcR8MhUt8IzO2VidhPZ1RIhnmLs5G4M1WcYikPXuiERV41B6Kz
 MJaLYNkf/XszAO44x6sqyWRKE49uDMyxck1DDLwxYYjMfztcLNyJ86H3ZW+J4opZHAP7d/9G4
 /UN8MlaY78d5xRCcxSw+PljjlGJlZKSneiehN0bKR+pnlXUsbjvDm8zqWL2lRS53V0Gh8+qLI
 +lJusQl8Fq9XkrLnQ1Jv6rAP6Bxo2lTyNwQkL5krcDs37vNTksjQWTGBSTlTFhwCBo1zAe7km
 JqQFekdZ+5lU9Ncjoykh0DqYku2SBBrCfPjgqmy/mNcECkY02+EKJCwkPoKFTOXoTxTsvkjTq
 46Qj8LCrrbLgcY6EpET3Ch5qe82AfkMPWks7/6Z322flJroiE5bDqoP+EO2eVc40Lr1L//Gms
 +QQz5mi3mdX60beRbtI+e/IRkzP1PMFbzy73fHUFZ7erekAgAmdO06hwL5

Warn WMI driver developers to not use GUID-based and non-GUID-based
functions for querying WMI data blocks and handling WMI events
simultaneously on the same device, as this will corrupt the WMI device
state and might thus lead to erratic behaviour.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 Documentation/wmi/driver-development-guide.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/wmi/driver-development-guide.rst b/Documentatio=
n/wmi/driver-development-guide.rst
index f7e1089a0559..99ef21fc1c1e 100644
=2D-- a/Documentation/wmi/driver-development-guide.rst
+++ b/Documentation/wmi/driver-development-guide.rst
@@ -96,6 +96,10 @@ on a given machine.
 Because of this, WMI drivers should use the state container design patter=
n as described in
 Documentation/driver-api/driver-model/design-patterns.rst.

+.. warning:: Using both GUID-based and non-GUID-based functions for query=
ing WMI data blocks and
+             handling WMI events simultaneously on the same device is gua=
ranteed to corrupt the
+             WMI device state and might lead to erratic behaviour.
+
 WMI method drivers
 ------------------

=2D-
2.39.5


