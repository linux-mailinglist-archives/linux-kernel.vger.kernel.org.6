Return-Path: <linux-kernel+bounces-549247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03EBFA54F96
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 16:51:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE51F3B19C7
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Mar 2025 15:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9156E1624C8;
	Thu,  6 Mar 2025 15:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WVDUjOpP"
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC9620E715
	for <linux-kernel@vger.kernel.org>; Thu,  6 Mar 2025 15:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741276268; cv=none; b=W3HUw0WLD1CoX/5dd8Z83e+norkxyymhmL3k0KarMB+nzMlXCLkVJuttGPFfMpgww/d4ZpS16hvbJKmhgFpwuyhEj+kjYkSi2h3hRSo5TLV4F4L/6GJpX4/qKGSr0oYt1Jb4iNlkCff6DWPbjP/E59jRzrGjAaT+31BxZC0gNHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741276268; c=relaxed/simple;
	bh=5mF3yhDyZ984uk7RoubZ8XpqAlVSm925HnRSq7bds3U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=b6QQBT03xXjfnlgzdsojtuYujfb2tIRcOIKF2i9QePpIPxvW6JeA4PH8wljk1WhLWm5sZyORCO0yV1XoG93r4yId5u0hAmq1aKyfOG7xWks//916DhMBTUgZ/j/U435y+nW8AfgXUCcTSBsPOFMaZsqpNWfbp2l2iY4yXXiVS8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=WVDUjOpP; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-7c3d9cdb0ccso160712485a.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Mar 2025 07:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1741276266; x=1741881066; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UsSa+JKj39pPYtX0boTlbPBxfwuId0RpTAo3OqB6/1I=;
        b=WVDUjOpPVh5KRC0KgWjNjz0yWUGdPHhkjfbsVvYKQMo1+rqxJmyVZZjw38XSHGRDCw
         B7lawyk6dQVpLqBqvRtPPJxy4Ud1dg1ebVd8pi/8vkgUCE/wMf0/4uFfPBrsCnfBYUze
         GRyf9XoLbrTGNCQYYKJ1e+px+3Exo2dJX4Pq4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741276266; x=1741881066;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UsSa+JKj39pPYtX0boTlbPBxfwuId0RpTAo3OqB6/1I=;
        b=D4Ow+ihIqEsEHpweto+HrKPFHSnZuO0fBk7Nnuj801cNP0KlMwe3N6l1/JmYU9I3if
         F4uv7beWeaesz7UB1fqsSWTWNPvUx7cyXfSv6jJ0+BbLwKlU8Eif4AuCWMKrah7FSSJb
         JHCeXTsx1Dvmn8gVQH20tTphNX3Ogx9QIYUCrdTvoPFIcNw9xvQzc4k9JadRDExFWM4b
         PvvOYWQ36oG4wazEe8SCrPZs7jee3G7/x+xDO7h64KEm7X5256wYU7N4/EWrFq/+TOTn
         zkVSjFh4EUMKbn7rUQphNGC3nccYgd34x2EhwOzOxK238L7tPN5wFIxrUahIHZfYwy+5
         uAzg==
X-Forwarded-Encrypted: i=1; AJvYcCVVVtloySKrkF4SkBVlDP9bY1OF5jrw19y28wQnYMpBmJQth29nHYH5u8EbfaPZVNDpwOUuH6oxYUb3kBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaYuTzso5JtbHuUIds3tijxVSgjLJ+FJbqxLoODByxoR9Dqu2F
	Lpduk1E7JHvx+9v4HTjnhtK7HoeHkubBJEGE9vM0zwjwHtOeEW3GwLJfebAiEA==
X-Gm-Gg: ASbGncsE3SpBBF3wGgAGt3Ix8+aGRSxVYIzt6AR72ajyb+GOh5E8MXz9SrfvE4Zg/sY
	o0ESs59SDJlWsHYWX06BB4bObb0SfpfwYVkFMLOl940vq45gmfaBD/f+R8cu1sUO4VZ9D5a/j8s
	b3BSnTgyn/Gd/KGSAA9pkJhKj/WDiA17TGC4MeC+gGeixJ7t+aasfKfJs4FMWDkDZ9hapIh4XXl
	pWfZZIedwL7fW8ZxFnIREOkPKXY12jPW5lsW8F2PXvASRrsXXZ2emyFj0xTORQL/a6RGVHFEWFq
	S2oRhCrpEiP/5Xn1M+BoKaZ/8uMKoWrZjHpDx4G+U/KTQBoKBIntiof+lL75u1UimRQWwt2r7K6
	oCbuNJ8hItwwz5dd1peNVpw==
X-Google-Smtp-Source: AGHT+IGaPRp7BfTuXVNq9ubOX42+gm3iaTgGnD/JJ/jx8dRs5bQKTPSsb/pvVPIVVzCwTG0KQvOkSg==
X-Received: by 2002:a05:620a:2813:b0:7c3:d266:334f with SMTP id af79cd13be357-7c3d8e797b7mr1109333085a.38.1741276266339;
        Thu, 06 Mar 2025 07:51:06 -0800 (PST)
Received: from denia.c.googlers.com (15.237.245.35.bc.googleusercontent.com. [35.245.237.15])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e533a1a1sm106257585a.6.2025.03.06.07.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 07:51:05 -0800 (PST)
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 06 Mar 2025 15:51:02 +0000
Subject: [PATCH v2 2/3] media: Documentation: Add note about UVCH length
 field
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-uvc-metadata-v2-2-7e939857cad5@chromium.org>
References: <20250306-uvc-metadata-v2-0-7e939857cad5@chromium.org>
In-Reply-To: <20250306-uvc-metadata-v2-0-7e939857cad5@chromium.org>
To: Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 Guennadi Liakhovetski <guennadi.liakhovetski@intel.com>
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Ribalda <ribalda@chromium.org>
X-Mailer: b4 0.14.2

The documentation currently describes the UVC length field as the "length
of the rest of the block", which can be misleading. The driver limits the
data copied to a maximum of 12 bytes.

This change adds a clarifying sentence to the documentation to make this
restriction explicit.

Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
---
 Documentation/userspace-api/media/v4l/metafmt-uvc.rst | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/userspace-api/media/v4l/metafmt-uvc.rst b/Documentation/userspace-api/media/v4l/metafmt-uvc.rst
index 784346d14bbdbf28348262084d5b0646d30bd1da..42599875331c0066cf529153caccb731148023b9 100644
--- a/Documentation/userspace-api/media/v4l/metafmt-uvc.rst
+++ b/Documentation/userspace-api/media/v4l/metafmt-uvc.rst
@@ -44,7 +44,9 @@ Each individual block contains the following fields:
         them
     * - :cspan:`1` *The rest is an exact copy of the UVC payload header:*
     * - __u8 length;
-      - length of the rest of the block, including this field
+      - length of the rest of the block, including this field. Please note that
+        regardless of the this value, for V4L2_META_FMT_UVC the kernel will
+        never copy more than 2-12 bytes.
     * - __u8 flags;
       - Flags, indicating presence of other standard UVC fields
     * - __u8 buf[];

-- 
2.48.1.711.g2feabab25a-goog


