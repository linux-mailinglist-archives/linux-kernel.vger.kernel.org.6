Return-Path: <linux-kernel+bounces-430083-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE6DE9E2DDF
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 22:12:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 324E4B3F6BC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 19:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88D54205ABB;
	Tue,  3 Dec 2024 19:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmeNj3ls"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1632036EB;
	Tue,  3 Dec 2024 19:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733255577; cv=none; b=ge+avODc4nzZNU8S8TnO9Ao4kFjkgSedBKDScTwDsl/350aJKIRHKKU1cnAxbxfAyNNorHfKfi0+rSpYhEYYuVbcypd71nrzJ3zS7t9LQSwJd5l1O+pNhWak52rnLhybHhoRiUrNsYWz3dSR50sSiaQwEJpHDA93qRVz4vQQUpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733255577; c=relaxed/simple;
	bh=s/JE24aKNx/N8V/I6/+2iLRpAbK7WnVua40P6et2diY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RsHQhhEMr6GhJ3wz71H0kPsxaf84RydXrx7rqIlKmdxP4TX+FZxf1PKKdmqJOYeJaTqflIj0577F8j+KfY7zT4r/i0hwEEp2ppOGEWHAdUOFpH8w7//4nradZ8YrvhQ6p4h6nagIF97PPbsf/8XZdqcfwmWd4p3b/0MOSVDwYPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmeNj3ls; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-53dd59a2bc1so6371994e87.2;
        Tue, 03 Dec 2024 11:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733255574; x=1733860374; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cPMQFTUOSO/BdSPQxLW1YaFDkiRLGBiLqrUEWkys0dg=;
        b=JmeNj3lsmAhJeEUU1ufSSVlqWoySX8KI6a63cVutG0Z0w/dGhw23zFCk5R3HNIh/wA
         Uc8qvhnsvAkHJWHc7fP+2y/w67rHFglfW4xcHLJlR3kfdCo1dIPO6JvNceHVBP5dSvVK
         iPHbX5lfHWYuZIJXqkJJ8OGYcEaEASvDSaqnYP80XNkGbKy6eob8l8RxsE2k47Ycpmt/
         RmPqHZLqMjqQEIL7kJPvS1m49bvJ34c0HDertip4/Fhr9HNIuXv3syIyYsI5UsyyCNzj
         iCW8Ssn4AhCk6/UlZotc4HXdsMskZ47X/j8z+yGLkq3r2+Ktwy4wYGG3w7Eq6GGKPENf
         0r7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733255574; x=1733860374;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cPMQFTUOSO/BdSPQxLW1YaFDkiRLGBiLqrUEWkys0dg=;
        b=H7Q/LbWPexGajzNhja8wPP/Hk/zOGZu46KS0rZSe+h0ygWKeP8vOjzUVK2jHWSxl+0
         6LVbWnwr4ReL2J/ebJgRPXC4OlODRCIwFl4p1iHiEHBqmr5H4xXF1pMAXm1pMvb8N0nN
         pUtj27CYd0Ic4vRC95qCNhMl3lG7xclKw1Ljwhf4ydczE6s76TXhEdzxOGSON5/7Ywom
         lWtCgaQa5FM/pDG+WMWc/8izoKTM0C1BJu8eKT+KOI2oF3lehnWIg7z0ueOkqHl3CegN
         2GoMto3XfRCzhj38oiEx8wxxcxBnM0E9bJuX2n0rGWXi5XmD4TLDFOSrAvCLWqku1ZBq
         eLEg==
X-Forwarded-Encrypted: i=1; AJvYcCWoLpvdLTEUdLt6otSXtHrTW9pz8yw2Kl5GoNg4i3R7p/vcXgWDwmaFgtPJDMTSiU994mx9y7LZFO4B@vger.kernel.org, AJvYcCX05DmZQl9EOW3ggJ8uyXadd8RgWHwvSOT8v92RmUinw16zvzsIH7vDNr3WAP6/7qMGgG7czM4XGY44SuU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTRwkzjNIHJCaRUYGHZrLxCqH0xQBWjwcG5iUAIVapi2z2AZGO
	6PgW2WcRkQXOodVQS+XWF2POPaRoRlTLB9gM3O+X/dzXS4CfqgTO8vPAsg==
X-Gm-Gg: ASbGnct0lE5bt6lVzK9//M6pCdOGyzxxA0gKDaYldSFFvJLwaeORvlzgIPxn09ldrpd
	Kn6BJZWAX7ALGQ6REb3plBam135Dyr2jUaY9zgcH9oemtMklYZJBgw02N3p/oH9pEIQZrmFykot
	pekSeOfV33BrBOGSFi62ufTKJ+AgeT80v8inAbFGFSebEompQRRDy377Hq3PZ8WC3i2yPxdKGSH
	YiUyEDcc26r1gNTV5JkRGSZUm5uP3/bNbWSYJhVaJnNq9/kEG7BG5c9qvK1mWI1
X-Google-Smtp-Source: AGHT+IHwIKaCyzEkwMQEHzmgxKUCoXwqgbUb1JAMMhR/SRAdynCpE4bh/wx0oDEIflvnk3qywvKAcA==
X-Received: by 2002:ac2:521c:0:b0:53e:1ba2:ee19 with SMTP id 2adb3069b0e04-53e1ba2efc6mr543527e87.20.1733255574369;
        Tue, 03 Dec 2024 11:52:54 -0800 (PST)
Received: from foxbook (adqz95.neoplus.adsl.tpnet.pl. [79.185.159.95])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e167a08e7sm262443e87.255.2024.12.03.11.52.52
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 03 Dec 2024 11:52:52 -0800 (PST)
Date: Tue, 3 Dec 2024 20:52:49 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] usb: xhci: Fix NULL pointer dereference on certain
 command aborts
Message-ID: <20241203205249.513f1153@foxbook>
In-Reply-To: <20241203205123.05b32413@foxbook>
References: <20241203205123.05b32413@foxbook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

xhci_handle_stopped_cmd_ring() attempts to restart the command ring if
there are pending TRBs on it, which it detects by comparing the enqueue
and dequeue pointers for equality. It assumes that pending TRBs imply a
pending command, and blindly dereferences cur_cmd. This can be wrong.

If a command is queued to the final usable TRB of a ring segment, the
enqueue pointer is advanced to the subsequent link TRB and no further.
If the command is later aborted, when the abort completion is handled
the dequeue pointer is advanced to the first TRB of the next segment.

If no further commands are queued, the pointers stay this way and then
xhci_handle_stopped_cmd_ring() is called by xhci_abort_cmd_ring() with
NULL cur_cmd, which triggers cur_cmd dereference as described above.

Fix this by omitting timer setup if cur_cmd is NULL. Leave the rest
unchanged, including ringing the doorbell each time the ring pointers
aren't equal. An unnecessary doorbell ring should be harmless.

This is probably Bug 219532, but no confirmation has been received.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=219532
Fixes: c311e391a7ef ("xhci: rework command timeout and cancellation,")
CC: stable@vger.kernel.org
Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index 4cf5363875c7..da26e317ab0c 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -422,7 +422,8 @@ static void xhci_handle_stopped_cmd_ring(struct xhci_hcd *xhci,
 	if ((xhci->cmd_ring->dequeue != xhci->cmd_ring->enqueue) &&
 	    !(xhci->xhc_state & XHCI_STATE_DYING)) {
 		xhci->current_cmd = cur_cmd;
-		xhci_mod_cmd_timer(xhci);
+		if (cur_cmd)
+			xhci_mod_cmd_timer(xhci);
 		xhci_ring_cmd_db(xhci);
 	}
 }
-- 
2.43.0


