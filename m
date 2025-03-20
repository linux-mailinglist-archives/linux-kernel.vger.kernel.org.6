Return-Path: <linux-kernel+bounces-570229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3260BA6ADF7
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 20:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 830EC189E9F5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Mar 2025 18:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77823235BEB;
	Thu, 20 Mar 2025 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BZYeE/Q4"
Received: from mail-io1-f49.google.com (mail-io1-f49.google.com [209.85.166.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E6B23535F
	for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 18:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742496829; cv=none; b=otwT3tTfXMAQ9Wr/9d/wjYeJDEhE4Iv7ujC9ilGKVpaCRX2iinCX92/PYHnmfTAAar5bpe2aUD91Edg/UbMIuhhXh9apYbuTa8Ty8WK2aLm9zuDHPdOeHPp69lmrMNmLpJ3cp5HaZKyfJgZN8wP3rbtV7UgqqUmbauOJynzltDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742496829; c=relaxed/simple;
	bh=QEhdcFjGUYEhRV5gc4j8gtE71RP/PmsIn2XZMXhHOvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DIgG/HbbvIw+BvwpW9XG40qfArvwbRa6DSj4QoaRSSesoutwxWQ77f5B1HgTprahR2W8jD4+GqAVKbUesXnw2WDSDw5cElzaebuyutOPSFowd5LuJUhYrE3S4WEZoSf/W/iQ6ZJgtMTAz1owClmcPLi4LGN+wjEbdAlufgb5EIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BZYeE/Q4; arc=none smtp.client-ip=209.85.166.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f49.google.com with SMTP id ca18e2360f4ac-85ae131983eso125356139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Mar 2025 11:53:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742496827; x=1743101627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=//eNVK5QvyJuFs0uWvNcaJY74v2ESo+w6BQZ02tQwac=;
        b=BZYeE/Q4vy0DfE5XtIbzIbXCMF25Ray0kW6Ix8qGhXn9MTCGIFkSH94/t5v4jUp42P
         dQEQYIbCQVjPGhNTA3IK/PkJdMrehlr49Jw9bkDGExiQS6wzqrliAjC7L9NTg/29D8sZ
         mtqwSkvWWWlb7q650aFWbUTMXoeRnu/lZkx23RyuS30vGvU1HDSRdMv79eMFUcy3tD6L
         BOPSVwWy0hOy5nvH6ufjLySIuTRT5SgD2ePMg3f5E/Fu1c2gKCF803ThDUBM+DcWU0cm
         rCw8DS4A3xa4IwGKT4mb/9ZzjFDyK/Cy9BW2zMBXD4KWRzLP72+zlqHHQePB+hoUuPGn
         8SFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742496827; x=1743101627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=//eNVK5QvyJuFs0uWvNcaJY74v2ESo+w6BQZ02tQwac=;
        b=gXIBoIOPp5oaogdIUgQSLSnT9kZEgP+NTrj5KXDIJ46/zR7M5v84WcXIVvJDcR2GNO
         l/huOtqfQhqsYKERzdwCA8HkAtK2bAV9Ut+lt80hm+OG4XB6gX/HSzjaPxn0Tom2AOyh
         LllAwj3yg12IVvwIOoWx/wJ+Pfuea1sRNsofjZiUDcN9vAiiJUooNExgOnrky/29PnsN
         gqjwwXE6gpD/jBaffuEg+Ixp2n/aZHTBZ4V8tNK8VDVR2HcKJCKAqNzUGcX262HhSfpe
         WwUumu4H/DT0K7vVcJF2PbDCc5fwR/RS9f81X7Z/iavyMCSy6G3i3fdr987eZrzTTVsx
         wlSQ==
X-Gm-Message-State: AOJu0YxceSfhLbTS1SzDNQfz08P61RC12IEPQqmb3Q04u7KxAlAPYKKl
	3QBdnss/B+8WxnuFiRKAXbTWBTwNZz7WD1pDpOPJnV14POpQnuljEWMt7wGb
X-Gm-Gg: ASbGncsg4f7iT2JL7cjmckUbNW7A5Qe+yWbc7wUAZLlJrn4zEYFLGCLMSSvMAIWFRJ/
	EKT/WHFwFBCHfbH/4WAFoJBNWL4aa+qLbDeSumoSvHng9LjfpKmFRRYnuJiD0V06m/9j2FITUDt
	I4y8X5d25BQztJodNtt5tvpOJrFh9t1nZFDnzIsyLqKANE15n97PPxzgKbeASXYgLy6aKjaFJas
	9Y5JN9w0b21oQuo+di9SlmjaCDI/99dBIcxhKcjgc6EdOIFeafXVis0avBUCLbXiRoR3fi36y/4
	GJzTuKCJ0rWlOgypX+raIQSBLhodiXFPrn5GSmhGIxIyVPeUCare+k3gMyQCxhiWFn50e3/CJAo
	ZyLa8kWzPnjfp
X-Google-Smtp-Source: AGHT+IFFpgYTl7JZFiyS9WTpaidYWi/5SdS6fsq/viN+YEp3rM9RCo7TNcLP3VJ/VtmR/8cq2dJk2A==
X-Received: by 2002:a05:6602:3e89:b0:85d:f316:fabc with SMTP id ca18e2360f4ac-85e2caa92d7mr44469839f.8.1742496827493;
        Thu, 20 Mar 2025 11:53:47 -0700 (PDT)
Received: from gandalf.. (c-67-165-245-5.hsd1.co.comcast.net. [67.165.245.5])
        by smtp.googlemail.com with ESMTPSA id ca18e2360f4ac-85e2bc273e7sm7078039f.17.2025.03.20.11.53.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Mar 2025 11:53:47 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org,
	intel-gfx-trybot@lists.freedesktop.org
Cc: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	ukaszb@chromium.org,
	louis.chauvet@bootlin.com,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v2 38/59] drm-print: fix config-dependent unused variable
Date: Thu, 20 Mar 2025 12:52:16 -0600
Message-ID: <20250320185238.447458-39-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250320185238.447458-1-jim.cromie@gmail.com>
References: <20250320185238.447458-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With CONFIG_DRM_USE_DYNAMIC_DEBUG=y, __drm_printfn_dbg() gets an
unused variable warning/error on 'category', even though the usage
follows immediately, in drm_debug_enabled(category).

For static-key optimized dyndbg, the macro doesn't actually check the
category var, since the static-key patches in the proper state.  The
compiler evidently sees this lack of reference and complains.

So this drops the local var and refs the field directly in the
macro-call, which avoids the warning/error.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 drivers/gpu/drm/drm_print.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/drm_print.c b/drivers/gpu/drm/drm_print.c
index 46d53fe30204..41ad11247b48 100644
--- a/drivers/gpu/drm/drm_print.c
+++ b/drivers/gpu/drm/drm_print.c
@@ -212,9 +212,8 @@ void __drm_printfn_dbg(struct drm_printer *p, struct va_format *vaf)
 {
 	const struct drm_device *drm = p->arg;
 	const struct device *dev = drm ? drm->dev : NULL;
-	enum drm_debug_category category = p->category;
 
-	if (!__drm_debug_enabled(category))
+	if (!__drm_debug_enabled(p->category))
 		return;
 
 	__drm_dev_vprintk(dev, KERN_DEBUG, p->origin, p->prefix, vaf);
-- 
2.49.0


