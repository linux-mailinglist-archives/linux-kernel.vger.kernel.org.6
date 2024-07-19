Return-Path: <linux-kernel+bounces-257575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45693937C0F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 20:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01BCD282A56
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jul 2024 18:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB9E146D57;
	Fri, 19 Jul 2024 18:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="z1WPU2EH"
Received: from mail-il1-f201.google.com (mail-il1-f201.google.com [209.85.166.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837A72CCA3
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 18:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721412398; cv=none; b=aKcp/0CicDkx8o6uwc9bqtCwOc0utUe3y1D1KKRYq9aHjKNWt2KYBNY1ijkHuB/rzVJT3sYe4rx4iZ59E7htGHrtKoTshwaN0+wI51oBMiJY1oNl43xrdVk2qiE1VQFn2EKlBrky64IKn2HIgt4MFwlKlbg69gHpB4gezHa+3zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721412398; c=relaxed/simple;
	bh=3JxKCWFIJO1l5j07YlTQzhG4WIh9B48kwEXBnpUCFmY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=IFSIgR6qEUPL5X0mooauB6MqLHbkFUdEdzzbSUwUylJkx+/YRMebaUfK4aHlMqwo+bK8aP5At2OJH+FhbLTTu57hYfIfodnuiOb/vdWctzfAxQRvsbdHHDlsRcfdFiVPDt1Nz7f5GtpVWCN6yXkFnvbL7cdYzHJOWzDChvpfupM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=z1WPU2EH; arc=none smtp.client-ip=209.85.166.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jdenose.bounces.google.com
Received: by mail-il1-f201.google.com with SMTP id e9e14a558f8ab-398602ba734so8145945ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jul 2024 11:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1721412396; x=1722017196; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=RKoiDVkQ6yJoRSxu2Az1hfMJ9PYb+MfDy6ZbgIGOeQ8=;
        b=z1WPU2EHr8FkVKOOs4Eav5mi6BuwuKKSF4jRfZow/Vj8jQkqEve5UQRhr87fzg5Ho1
         tkLWEOTztY5MnaJY9+UJr5IlJ2qQPqudnZnStqBWD7KGvF+mdoUsWmwXgkgevOSm2R3T
         DQ/bFyBbC9rp/an7p6y7h8qNOzbq2gsg88VuGPxrdTfxf0rTHQ1j8fAstliT9COIh9oq
         3KHV+GPi9SR+vGeCydXBbghFWjv2cr9KxjQzGq5oZiMIh+LmPl1vEcSi5O03m8i5aVGD
         yuNHXGK6N2lkd3WPywaOumTkthGaQDpqSxYpnRdMstvjQYyj+Dd0qLBctHumamPctpR4
         HujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721412396; x=1722017196;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RKoiDVkQ6yJoRSxu2Az1hfMJ9PYb+MfDy6ZbgIGOeQ8=;
        b=Hr7HjiflSePpcR9iHlZS9IZeMaxBYMljaOEPPt3Ohu7JIclN52X0vuoT+2cf3vGYfT
         7kFOyhLjT28iaFTO0ZVTEtqg16TAk4K79i8co3+VJBXWRhFLgEA5KqWsz/sdnP4WA8Ns
         gQRsrG112yV2eg9FPIYf3uHFISZvoOaXsxAFsToAEyWuGxD1glvQ0vmYReewaJBEw2Q9
         CMiWTDS4Hel/3b1W24gVNRS2A5AwS/WTK2oWHTfXe9SstzSaD3e9noeB1oi07kqNHKR1
         CHLlutOwac2VB9x5Pkyosxxzfm9PMSvhKJCQ7+EoCYLF5zv338U2sLH8FN2IIbKdqARV
         mk7A==
X-Gm-Message-State: AOJu0Yz0n67gngjEQQHQeQgWqUUPz3DTkh0eli0lXH21Dv4paPGB6AuV
	R2rw9C/M+ceexBgVaNuyOqcqUVa2dGSbV10c+Z/B9F5+9w3ov4sjpEmNtCm6BiZWO1LAPbtFcYu
	oFHK/8qkn1XGYpUhZzjQ/R19sKrx4V7ZMRoezDTmh9LcEH5uuz7kqAlHfX6opy+HpSEJyL7PYl0
	lXYuO1d/XR9MR78u4Pwb5O7kcNFS2Gqvwzgkb6K7yEBJZhpw==
X-Google-Smtp-Source: AGHT+IFVTUFvNALMgY3b9kcnWsE89uLmyXszuB6EAU/KaJQ5m1VY84UAMpSmm+EP8KMJBYzhbB/2Z2Zq74qG
X-Received: from dynamight.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:17a])
 (user=jdenose job=sendgmr) by 2002:a05:6e02:1fef:b0:380:fd76:29e4 with SMTP
 id e9e14a558f8ab-398e706f258mr245725ab.4.1721412395708; Fri, 19 Jul 2024
 11:06:35 -0700 (PDT)
Date: Fri, 19 Jul 2024 18:06:15 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Message-ID: <20240719180612.1.Ib652dd808c274076f32cd7fc6c1160d2cf71753b@changeid>
Subject: [PATCH] Input: synaptics - enable SMBus for HP Elitebook 840 G2
From: Jonathan Denose <jdenose@google.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Jonathan Denose <jdenose@google.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Jeffery Miller <jefferymiller@google.com>, 
	"=?UTF-8?q?Jos=C3=A9=20Pekkarinen?=" <jose.pekkarinen@foxhound.fi>, Sasha Levin <sashal@kernel.org>, 
	linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The kernel reports that the touchpad for this device can support a
different bus.

With SMBus enabled the touchpad movement is smoother and three-finger
gestures are recognized.

Signed-off-by: Jonathan Denose <jdenose@google.com>
---

 drivers/input/mouse/synaptics.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index 7a303a9d6bf72..9df0224867649 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -193,6 +193,7 @@ static const char * const smbus_pnp_ids[] = {
 	"SYN3221", /* HP 15-ay000 */
 	"SYN323d", /* HP Spectre X360 13-w013dx */
 	"SYN3257", /* HP Envy 13-ad105ng */
+	"SYN3015", /* HP EliteBook 840 G2 */
 	NULL
 };
 
-- 
2.45.2.1089.g2a221341d9-goog


