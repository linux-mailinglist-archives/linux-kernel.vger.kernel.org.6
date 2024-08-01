Return-Path: <linux-kernel+bounces-271222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D0A944B3D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 14:26:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2D4F1C22DFF
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Aug 2024 12:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 216D41A01AD;
	Thu,  1 Aug 2024 12:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I24DOEja"
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1BB17084F
	for <linux-kernel@vger.kernel.org>; Thu,  1 Aug 2024 12:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722515205; cv=none; b=o7z3HptID6xoOBRUqPIARuRilW4NOUKokqX1E80vX/VdCyYo6r4/jY3ARLMhNir4jb3Uwtj4SvVKyQM7p3y/w2r/no/MFH3J4v5J1WBlUxe87rbZIoe/d2E4RHO05017jInSV/3ub+vQIP2z/nQTysn6eEG0DDIzuk0Voqf9/2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722515205; c=relaxed/simple;
	bh=tutIS9+Btwjy7UhxN2n6pzzlKIfeT4C2s+joCe5F14M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=r6dWEWvtAP2UAH6q0+o8xEQHjbLSRb41uIS/k9bquOHuCVreLezOQ2INRj2JZboUEsQULGvLfis+uYFClG8InwmQblHO5dTpsSpO6W4BBWfbEruyitmB18OWPS0r8n4EHyE2P4r7Qfyefx9cq4t+0jDTk7BUk9Flqk6j9AMu0KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I24DOEja; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-70eaf5874ddso5271428b3a.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Aug 2024 05:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722515203; x=1723120003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BzW25HOmDgu3PFYeFf46/aEJDlCqCkDxgxEWomrUeUU=;
        b=I24DOEjakpWIWkZ0PfjTPKy3FNX05DzR+L9k00KnI9dGZz7sL2AB3dwhU0B9D1BJ6x
         8tfHxB3109TXW1ZgZCEeA4Qa9NiRogV0iR7R8K+D65CVTqhcHiC33EGIZEznq1kKop/y
         CYJthK28sOE9iPkI/6hB2Em5NGLmYwwwtOeaGPXysA9t4eW08LwyeAUX5EVTN5ySY5ux
         PdfY5+2wSw/b6PKMcUC3JDh5dJk/qSLPyP+5XqmncOtVcEIsubicKRU9CUiVXv0MdPPj
         6z3YUsW17xAv0NPIZ3ChPAibTJR+a6rt2znoXK6JWFN4Y6wxpu+cwPnU+eBYLgcrGgT1
         UJ1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722515203; x=1723120003;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BzW25HOmDgu3PFYeFf46/aEJDlCqCkDxgxEWomrUeUU=;
        b=adKFWc79OxQf/9szULKvXnzMNM5+6SeOjbE35zl9XEbgCr2Liu8vp0qWWKQMeZ/V8E
         VVXKY3wJ+NSPHyJNphPhoQImPWEiy1acIfc9Ed96J0/9FVtf/a2e3KhZMjT2tC4m9vHs
         5zfDozqc7KeGIy2QqfYr7lcBitETiFG8ngtsX3xqWd5WW/qy1NN3PZuM+vNc7abHbmmO
         vjg5HeBJkQy9UlKqNwsoXScWnJ6kpKiH4TyMl9oKc8wzreFVm/dpSFo6rs16GiG62+r4
         HPz0INyhNcq47cByFv2sugeJyvNExdPq6v5hYUj2BRCrhjRy8a8Nl5E8+nAEHmY/NGIv
         pm0w==
X-Forwarded-Encrypted: i=1; AJvYcCUJ+NEYJQgLNXRox8FUevHPBECUehk+J5iCeMtEZOK5ih8xpHSRBaYLgaz9Sx1frxFFRfGgBQY6XRXSFuEvfGQAYc/gyY41dEteMFCZ
X-Gm-Message-State: AOJu0YxUoOc7MLx6EaSlWFKAg0/RkmtX7WPAvhVbxbWwJ6SINdhiheHj
	1pZ/8bkocPHnyyqrHXZuZJsxwPgOGAwuZp1sGRuqLwp3LuIhuq1V
X-Google-Smtp-Source: AGHT+IFwicjwGeuVIdR66gMdzrlUa/EEPeQWIAuXIp9B6xqMrPvT9RnTWtob2tlFVuJCWCRAEtPYCw==
X-Received: by 2002:a05:6a20:7f93:b0:1c4:8dc0:8520 with SMTP id adf61e73a8af0-1c6993eaa83mr136017637.0.1722515203122;
        Thu, 01 Aug 2024 05:26:43 -0700 (PDT)
Received: from localhost.localdomain ([2401:4900:1cb4:cece:78f6:191b:3e2f:ac7d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70ead6e0b76sm11407939b3a.36.2024.08.01.05.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 05:26:42 -0700 (PDT)
From: abid-sayyad <sayyad.abid16@gmail.com>
To: airlied@gmail.com
Cc: daniel@ffwll.ch,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	abid-sayyad <sayyad.abid16@gmail.com>
Subject: [PATCH] [PATCH v2] drm: Add documentation for struct drm_pane_size_hint
Date: Thu,  1 Aug 2024 17:55:53 +0530
Message-Id: <20240801122552.1151747-1-sayyad.abid16@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixed warning for the following:
./include/uapi/drm/drm_mode.h:869: warning: Function parameter or struct member
				'width' not described in 'drm_plane_size_hint'
./include/uapi/drm/drm_mode.h:869: warning: Function parameter or struct member
				'height' not described in 'drm_plane_size_hint'

Signed-off-by: abid-sayyad <sayyad.abid16@gmail.com>
---
Changes in v2:
- Adress review feedback regarding indentation in the fix
- Link to v1
https://lore.kernel.org/all/20240801102239.572718-1-sayyad.abid16@gmail.com/

 include/uapi/drm/drm_mode.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
index d390011b89b4..9d398335d871 100644
--- a/include/uapi/drm/drm_mode.h
+++ b/include/uapi/drm/drm_mode.h
@@ -864,7 +864,13 @@ struct drm_color_lut {
  * array of struct drm_plane_size_hint.
  */
 struct drm_plane_size_hint {
+	/**
+	 * @width: width of the plane in pixels.
+	 */
 	__u16 width;
+	/**
+	 * @height: height of the plane in pixels.
+	 */
 	__u16 height;
 };

--
2.39.2


