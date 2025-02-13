Return-Path: <linux-kernel+bounces-513889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49624A34FE9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 21:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4894016E91B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 20:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105932698A4;
	Thu, 13 Feb 2025 20:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CjuHPXZW"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31FA270EDB
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 20:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739479566; cv=none; b=iMDeMCpOhWGDwY27gf0foPVczm1HWf1Dw4UZGWCd3DknnGWm2GRaqFYrovDZ5pUXu1rBTuDookW8q9UOWJMtLV2k/D3Y9UXbZN3aAB7APUfrVVBms43ClwHx8xkakFuiRnGZuhEp9LjeRb272GS0UFXOBVBxL1eadEhTU/z0Udo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739479566; c=relaxed/simple;
	bh=gmySyemTABWW/YZoDBas9z33BOa3vPcC6lWMoPCfpCY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qgJna+yv9w8Vb+ykTdw7fmkFr5tvGZidDCdJSeNqnXSJTFFAWhZb0M+vXcHIGqLzhMIkBCd9mey9myb+n9xpP/oVr7LXtdyR5C3xeqAdcG3UtFJRquJTGVudMF+/mKV7HZMkyHsr7P6LOy2G/mrlhNClSapX/s0QtsSn2ht8DnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CjuHPXZW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739479563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YEZ7hyBGEACzUBMEkwH2aZgKLbVzZ6QD9bf9RTFVfH8=;
	b=CjuHPXZWbhql4W5q3E4CPR5xBtb0UQu9PXGQxoBAZeAkISVYhtujU4BfwkXpMs4oKuhUN7
	d4h9EaEq1XjIO9KJ+GhnqDsT6qOcaVCDd/Em3CLAkkuhpGL13TP+nu526rbnv17JjXK6zs
	rKSnfB2AQRfgQIlAdtQQ+vQAbpAJ0xg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-75-HcxdzeHwOMaK2fGtvma4fA-1; Thu,
 13 Feb 2025 15:46:00 -0500
X-MC-Unique: HcxdzeHwOMaK2fGtvma4fA-1
X-Mimecast-MFC-AGG-ID: HcxdzeHwOMaK2fGtvma4fA_1739479558
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 815041801A10;
	Thu, 13 Feb 2025 20:45:58 +0000 (UTC)
Received: from asrivats-na.rmtustx.csb (unknown [10.2.16.199])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9AA5F19373D9;
	Thu, 13 Feb 2025 20:45:54 +0000 (UTC)
From: Anusha Srivatsa <asrivats@redhat.com>
Date: Thu, 13 Feb 2025 15:44:37 -0500
Subject: [PATCH 20/20] Documentation: Update the documentation
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250213-mipi_cocci_multi-v1-20-67d94ff319cc@redhat.com>
References: <20250213-mipi_cocci_multi-v1-0-67d94ff319cc@redhat.com>
In-Reply-To: <20250213-mipi_cocci_multi-v1-0-67d94ff319cc@redhat.com>
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Joel Selvaraj <jo@jsfamily.in>, Ondrej Jirman <megi@xff.cz>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Jianhua Lu <lujianhua000@gmail.com>, Robert Chiras <robert.chiras@nxp.com>, 
 Artur Weber <aweber.kernel@gmail.com>, Jonathan Corbet <corbet@lwn.net>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Anusha Srivatsa <asrivats@redhat.com>, 
 Douglas Anderson <dianders@chromium.org>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1739479476; l=1462;
 i=asrivats@redhat.com; s=20250122; h=from:subject:message-id;
 bh=gmySyemTABWW/YZoDBas9z33BOa3vPcC6lWMoPCfpCY=;
 b=cPCzLJPFmrmtxVHog4IuzBRf2IBPjswbeT7btFNnqfWfQ/iC06jJTCuptDWLKxQH25nKKtsu3
 kuvE/8QL+OYCoEp2Z6/cDskkbIOWTbUnC8ayqX9gc190NtOp14rt1YB
X-Developer-Key: i=asrivats@redhat.com; a=ed25519;
 pk=brnIHkBsUZEhyW6Zyn0U92AeIZ1psws/q8VFbIkf1AU=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

TODO addressed

Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Anusha Srivatsa <asrivats@redhat.com>
---
 Documentation/gpu/todo.rst | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index 256d0d1cb2164bd94f9b610a751b907834d96a21..16231355b3bd31e50c9b50c2c0006ec79ee4ca10 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -496,25 +496,6 @@ Contact: Douglas Anderson <dianders@chromium.org>
 
 Level: Intermediate
 
-Transition away from using mipi_dsi_*_write_seq()
--------------------------------------------------
-
-The macros mipi_dsi_generic_write_seq() and mipi_dsi_dcs_write_seq() are
-non-intuitive because, if there are errors, they return out of the *caller's*
-function. We should move all callers to use mipi_dsi_generic_write_seq_multi()
-and mipi_dsi_dcs_write_seq_multi() macros instead.
-
-Once all callers are transitioned, the macros and the functions that they call,
-mipi_dsi_generic_write_chatty() and mipi_dsi_dcs_write_buffer_chatty(), can
-probably be removed. Alternatively, if people feel like the _multi() variants
-are overkill for some use cases, we could keep the mipi_dsi_*_write_seq()
-variants but change them not to return out of the caller.
-
-Contact: Douglas Anderson <dianders@chromium.org>
-
-Level: Starter
-
-
 Core refactorings
 =================
 

-- 
2.47.0


