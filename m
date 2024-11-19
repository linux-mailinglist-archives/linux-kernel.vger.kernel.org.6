Return-Path: <linux-kernel+bounces-414978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A82D9D2FEE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 22:17:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24989B22E8F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 21:16:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAF901D173F;
	Tue, 19 Nov 2024 21:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=edera.dev header.i=@edera.dev header.b="KsRsKr/c"
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FD914A60C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 21:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732051011; cv=none; b=UtDlVo2AvCfUP/mvm2Elm0eNgo6uagBcngfBkFAS1QSFDu437fxCI90K8xwfR2/RViGNtRP8KfKTyAMfQX+8rJ5gf1fR8eOvAJsGn9t5WXBKlaKmpUaAxSIOKspqLZCXv1Ul/3Pul7cE6dkG2cFXGNj7IXvVw1WoWf4wNPZ6qWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732051011; c=relaxed/simple;
	bh=11+Sy7m6oTI0vrvYq2MPsw+viVG+AnDGVAxeGecmcew=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NAPIxLNlXHuF4+WremANE4c7BTcOZNjBDRnSrkIhGQ2oiUlINpUQh7kTcLXEhydaHeBH9FnvzuAMpQzubPMJdyrRFpcI4FIMWDBPQr3ja4RoT2JF7g8aZOqnWOLAsdnNVENCjKOhaVZ53axvEYDWnYkSCLLxdhIUCseKAlSbc18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=edera.dev; spf=pass smtp.mailfrom=edera.dev; dkim=pass (2048-bit key) header.d=edera.dev header.i=@edera.dev header.b=KsRsKr/c; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=edera.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=edera.dev
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6d415acf76aso30686396d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 13:16:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=edera.dev; s=google; t=1732051008; x=1732655808; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Eg7OcnGXpKtgXWaHwtGS+ToZC8TTTiMcCPq5ZYxyLCo=;
        b=KsRsKr/cCQti7HEr8VKGYPvZXr99UlLOoRWGqsuPgPy1/ctHR3Zj4PbY1mFkCiVfOm
         6+EzYYXMo6bMzcddXdLLszS1Jn33e8eqK4mCLEkc5Rh5Hb6nwe65tH9ut66GMWgfgF5i
         1w29IWlUyAHbucz1WbJt6/UK+4+SUJ892lTEKqgpyoPOA++hA9j52UWubB2kY8SeGfkf
         rqJ23lFJijLuveV35beoBhgnr+wIvXMwP72xeDaSMpgSuCzzwEzMMpBwWKO76Ich1u1y
         4oLVLH+fqzaVaQX4FWQAO15/FdCi8NMQgdNfaH2ntD5xrcZC3CyyM/lRbstOnI9LFawy
         TqMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732051008; x=1732655808;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Eg7OcnGXpKtgXWaHwtGS+ToZC8TTTiMcCPq5ZYxyLCo=;
        b=L2urzJlHKerC+dIYom3mMXHSkfUaM0pGVCoSGosghoO1bqUSg5sM+XUVwfE9ZYk0gW
         UU8VJ+dX7IQ4nmQ/3c503mScFmJRDGN1d/zao+ACnqNjbPtLsBGk5dz0OJtzcwj1wZ/u
         860Ar1RGxVZNjEreLY+CoNTsXl0sHnaRcMv2ZN+ugxhjFTrH81Bi/93ltmS2zkBMCg0k
         c9J6AExz4T4x7vWOwkYTMGHZE+Z4pr0Uv4sPrSrPdP3NuY0d6pzOLlhvjTv6G0gz6Jwg
         AVrkzVtDEQLjBSQQDC/S5jifOYy0RasoDFJdMPLawh0ycetB7ZNr/y/M2pWGnqq4I75c
         Oh0g==
X-Forwarded-Encrypted: i=1; AJvYcCWRtptma3T7innJazVWjfvQWFG2QAE20Uhu4GLdYqflOqSzJrfPzBdn9MY1x85qD2Hr4+43cj2+Mvrv+Xk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjJMuEPuvlOO9QyjPzMV0RSSckR6q3mhRy0Wkdt4wyOsYsrkki
	/n908a1KvD5H6/0iPQfEs/ogEO88zVTPPOOEEkSd5l3A/1GVLPWeYYVAOWuEBto=
X-Google-Smtp-Source: AGHT+IHB3u2/l2rZG0k9ZOUXZliIL+D2FSwQjxK7a12SP+D4OKLAIj7VApFTPwlDLTNgD+mrpxyQ9A==
X-Received: by 2002:a05:6214:5004:b0:6d4:2778:ecb6 with SMTP id 6a1803df08f44-6d4377a118bmr7865406d6.18.1732051008401;
        Tue, 19 Nov 2024 13:16:48 -0800 (PST)
Received: from ip-172-31-19-182.us-east-2.compute.internal (ec2-18-219-201-45.us-east-2.compute.amazonaws.com. [18.219.201.45])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6d4380db2edsm865966d6.36.2024.11.19.13.16.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 13:16:47 -0800 (PST)
From: Alexander Merritt <alexander@edera.dev>
To: v9fs@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org
Cc: Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Simon Horman <horms@kernel.org>,
	Juergen Gross <jgross@suse.com>,
	Alex Zenla <alex@edera.dev>,
	Alexander Merritt <alexander@edera.dev>,
	Ariadne Conill <ariadne@ariadne.space>
Subject: [PATCH] 9p/xen: fix init sequence
Date: Tue, 19 Nov 2024 21:16:33 +0000
Message-ID: <20241119211633.38321-1-alexander@edera.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Zenla <alex@edera.dev>

Large amount of mount hangs observed during hotplugging of 9pfs devices. The
9pfs Xen driver attempts to initialize itself more than once, causing the
frontend and backend to disagree: the backend listens on a channel that the
frontend does not send on, resulting in stalled processing.

Only allow initialization of 9p frontend once.

Fixes: c15fe55d14b3b ("9p/xen: fix connection sequence")
Signed-off-by: Alex Zenla <alex@edera.dev>
Signed-off-by: Alexander Merritt <alexander@edera.dev>
Signed-off-by: Ariadne Conill <ariadne@ariadne.space>
---
 net/9p/trans_xen.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/9p/trans_xen.c b/net/9p/trans_xen.c
index dfdbe1ca5338..0304e8a1616d 100644
--- a/net/9p/trans_xen.c
+++ b/net/9p/trans_xen.c
@@ -465,6 +465,7 @@ static int xen_9pfs_front_init(struct xenbus_device *dev)
 		goto error;
 	}
 
+	xenbus_switch_state(dev, XenbusStateInitialised);
 	return 0;
 
  error_xenbus:
@@ -512,8 +513,10 @@ static void xen_9pfs_front_changed(struct xenbus_device *dev,
 		break;
 
 	case XenbusStateInitWait:
-		if (!xen_9pfs_front_init(dev))
-			xenbus_switch_state(dev, XenbusStateInitialised);
+		if (dev->state != XenbusStateInitialising)
+			break;
+
+		xen_9pfs_front_init(dev);
 		break;
 
 	case XenbusStateConnected:
-- 
2.43.0


