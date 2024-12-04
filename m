Return-Path: <linux-kernel+bounces-430870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B347B9E36B6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 10:33:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 793BE281A47
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Dec 2024 09:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3921B3950;
	Wed,  4 Dec 2024 09:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="GNF4xzmL"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6C71B3724
	for <linux-kernel@vger.kernel.org>; Wed,  4 Dec 2024 09:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733304709; cv=none; b=OffcS2jeJpSaAkQXkt1ambJHoL4nOb8ODa2nd5Yv0wkC6As5eq7HxdflVWoP6+IUjynLVWCMP5U4AsE1m5VqO7NHi95sIrZbREqwfe0o1PyPuKwpiS4eeUTY8h0wA6DvTCrKdLNApBPP/e1CWZ26p4hW2JDYG6DNjEtPoyEAhTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733304709; c=relaxed/simple;
	bh=2kTYJooFMq+5La3iJTTLvA+HVNIvS8ojV7vTfwy1oII=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hMbXieZjQ17WYTxrsOFpHoFmVGnENCofWT03kWkU3kJRpMqUm8EZ/1/yS9e16GwbtdhUfg0slWtAmZ0HksSv5ZKbuAQey0caCzGGJXAbeolXyPfQAfgU6WktMStQxepOH0W2Xuvw7KPK61/+fvEGEsHt0Px36n9zyzL+sdk3jTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=GNF4xzmL; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [127.0.1.1] (91-157-155-49.elisa-laajakaista.fi [91.157.155.49])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id A8C311D29;
	Wed,  4 Dec 2024 10:31:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1733304673;
	bh=2kTYJooFMq+5La3iJTTLvA+HVNIvS8ojV7vTfwy1oII=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GNF4xzmL3MleQEFQGtbFiYw1E8RrIuwS3XhQ3Q9gzd1Y2lJS6CNJV2i5TeYutv8R1
	 kch/wEjHrwmk/z0/+FXj/6QWOqvq6FoFjE3rv5zkXnxdUGCHp4uXYUdY+1Ipo/eY4m
	 FsqJhx4S7ddmZ1Rg8vCnnRAAjLQzgQlecYZijKlY=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 04 Dec 2024 11:31:09 +0200
Subject: [PATCH 09/10] drm: xlnx: zynqmp: Add support for X403
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241204-xilinx-formats-v1-9-0bf2c5147db1@ideasonboard.com>
References: <20241204-xilinx-formats-v1-0-0bf2c5147db1@ideasonboard.com>
In-Reply-To: <20241204-xilinx-formats-v1-0-0bf2c5147db1@ideasonboard.com>
To: Vishal Sagar <vishal.sagar@amd.com>, 
 Anatoliy Klymenko <anatoliy.klymenko@amd.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=766;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=2kTYJooFMq+5La3iJTTLvA+HVNIvS8ojV7vTfwy1oII=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBnUCFzs5fjsix/w/yAKDDiwajcNiOFWZyKW3aKm
 VY6shZfH3WJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCZ1AhcwAKCRD6PaqMvJYe
 9cKND/wMV/dSG+TgZCNtmwg4MqMJVd8JugsFWyt+4GwifiFA57W2Utez9VYn3Hf4CrQJ9RnMnL6
 IZzkMV48OZ4g2u7xYpQ7myK/fd2l9SMOc916mhweowFlsQMKaruqmYdU57Hm68e4fXSMYTcq8S9
 L8lo7MzYjNZ+sag+vN0gPC+7KJ1f7WYosn79zy6vRgixgJkrAsAqbDCg6kGABq832rcwy9jknSs
 xLTs8GHzn08WIIFkPlAR0XyBWL59qoq8lMrugpHPYZB4KZjCsgivOVfFWCZW+AVo1tDloLWvCjq
 tVhU9moaDnvF01XNjU0CIj3tVm6F57Olk0iQhWPzITqoxvLtfmiYK+SM7iS7KypIGpeJcCqjOhc
 M/iqtLdeenC4fEnVCQ8vo5e1SJA/X8HrA9g35iLT+tedpcG5nAW0ZiGC4eSCjuEkfWpfGcn9Dq+
 po2HPfU/eUx12RHQjc/5tmD0eNOApTnWzmnYLy9ErI3aym2aNupGuM7KAQzqc4J1MRUxvfSkM1g
 tMSyubS1BDzZHprfKzH6dmlm46u4KsEjnTZQ1mHvXrLZ67XlaTYYKlOHpQA16xQpCy1Ys/hgNxB
 tS3oydwDbYYuWgVwkKIXnusmHmblbozCa/r5AHLjC8iv0n7vRuxVWOe0rOGqIHRKKJE5eqwcQKq
 bEv3UWQM+MkCkQQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5

Add support for X403 format.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/xlnx/zynqmp_disp.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
index 44cfee6a0e32..622d1dfac42d 100644
--- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
+++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
@@ -319,6 +319,11 @@ static const struct zynqmp_disp_format avbuf_vid_fmts[] = {
 		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YONLY_10,
 		.swap		= false,
 		.sf		= scaling_factors_101010,
+	}, {
+		.drm_fmt	= DRM_FORMAT_X403,
+		.buf_fmt	= ZYNQMP_DISP_AV_BUF_FMT_NL_VID_YV24_10,
+		.swap		= false,
+		.sf		= scaling_factors_101010,
 	},
 };
 

-- 
2.43.0


