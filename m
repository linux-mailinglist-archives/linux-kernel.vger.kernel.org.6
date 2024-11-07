Return-Path: <linux-kernel+bounces-400395-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A08309C0CEC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 18:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2B781C22FD8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 17:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A182721733D;
	Thu,  7 Nov 2024 17:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="KB8taOvK"
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE2221733F
	for <linux-kernel@vger.kernel.org>; Thu,  7 Nov 2024 17:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731000674; cv=none; b=DjvVpdwoepGjeIR8aK49Vrm7koBK/D9oPx8ipxaYkk8j9daVJjgcEojI9Xm3hnseY5ARxhlO2+InD2eqhn3gB08UOaE+sk0FtlI544LC++Un5NKQSQlyOQyekVSe6liBRqYoo7FpunO21lIV+oAhrglWiz2tchVganUMiSpoSOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731000674; c=relaxed/simple;
	bh=Q7qmklJAg39I2fpUM2q0jas6DuUYKzHr1XIy3Rj1NxI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ry5C2cOi+xWaeASZJKa56QkEpdvUZ+s+RAEdQ80GMaLydhOjI4/lsoU1h2SxOJITJ5dhGTP3Z63fZ64xF1sRNmmFuffG/I+ej53Z+HgxXNEl4FU6BdjF5bqDdf9NBM8Mx5KXezRJv80kypl9h+ctWQ9O+i0Ua2L7lnDfYLt73t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=KB8taOvK; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1731000670; x=1731259870;
	bh=Q7qmklJAg39I2fpUM2q0jas6DuUYKzHr1XIy3Rj1NxI=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=KB8taOvKQECYV8IH/DX2mi+PaxgMalZ1S01xCwe6kHSXvtAxjN1r5xxqOTWk5Ddvl
	 ti246+Vz8hKidYg5We81HKIYoTBfNRGpPYiqIww1mrkieyHuxQgua9CZoelvLnJkoD
	 hHqaZxVKqPzaSO3zpvn/8dk7Jp5JwnMF5SLqgZdorelNhEWIviYue5+dWbFi7YvcF/
	 drJBpkrn06ABVyaSILn49vE4FEihgNyG6rvAY4AoD994/h9vT5Hfot6q0BVbz/Ea3s
	 QLWrhizXpqhrfX+DDnVU1s28U3GKq+NrK8mamdSClbgiT6JSlqm0jD+8OQyQbQhzV4
	 2i1BZp8OPvyFQ==
Date: Thu, 07 Nov 2024 17:31:07 +0000
To: jic23@kernel.org, lars@metafoo.de, gregkh@linuxfoundation.org, parthiban.veerasooran@microchip.com, christian.gromm@microchip.com, sudipm.mukherjee@gmail.com, teddy.wang@siliconmotion.com
From: =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org, linux-staging@lists.linux.dev, linux-fbdev@vger.kernel.org, =?utf-8?Q?Dominik_Karol_Pi=C4=85tkowski?= <dominik.karol.piatkowski@protonmail.com>
Subject: [PATCH 4/4] staging: most: Remove TODO contact information
Message-ID: <20241107172908.95530-5-dominik.karol.piatkowski@protonmail.com>
In-Reply-To: <20241107172908.95530-1-dominik.karol.piatkowski@protonmail.com>
References: <20241107172908.95530-1-dominik.karol.piatkowski@protonmail.com>
Feedback-ID: 117888567:user:proton
X-Pm-Message-ID: 04ab167b3a5d4f134f23f67a7c28045d62bffbb3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Remove contact information from TODO file, as it is redundant and can
get stale easily.

Signed-off-by: Dominik Karol Pi=C4=85tkowski <dominik.karol.piatkowski@prot=
onmail.com>
---
 drivers/staging/most/TODO | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/staging/most/TODO b/drivers/staging/most/TODO
index 4fa11a9d2cf7..a6448a05ed46 100644
--- a/drivers/staging/most/TODO
+++ b/drivers/staging/most/TODO
@@ -1,8 +1 @@
 * Get through code review with Greg Kroah-Hartman
-
-Contact:
-To:
-Christian Gromm <christian.gromm@microchip.com>
-Cc:
-Michael Fabry <Michael.Fabry@microchip.com>
-Christian Gromm <chris@engineersdelight.de>
--=20
2.34.1



