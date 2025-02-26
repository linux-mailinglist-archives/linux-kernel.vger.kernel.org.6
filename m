Return-Path: <linux-kernel+bounces-533168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67590A45656
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 08:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A390E16CF56
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 07:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8997026E178;
	Wed, 26 Feb 2025 07:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AkeLbFeJ"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F8AD192D84;
	Wed, 26 Feb 2025 07:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740553543; cv=none; b=c+f5iWTDmi3pdl3yLSC3VINSJj5efs9TdF3KVtoDbARVGYKjyydNKIV8Tuu36zJMzQGLAl4Lqgb9rXeiBGZIAAioxAY2w2kcIGtPqGr+AxVPZGzLu7pMofh+BZwFt4k1kTvd0TYN2kiiX2ZbB7pV+kwWwPXOVPszPWtR8US0Du8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740553543; c=relaxed/simple;
	bh=Gk2NOsd/J//xRxLUPvfvBLSPupHBrxHxFuGx3y8W788=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HTkHVl7pt+F8AwMj69axyl3aS9WLY75/twqp0ZiOlZyVVq9YBLEMVGZ58Q1MJEVuTXIoPDqZdidGoWFAIvx0uCEO32yaJlSRi/+mZ73pKx+iBmnC39oj4jYRnFTUZ+yYMFRJSwMWvQjQqNj04GKJP7L0zvLZjsDJlHrAM2Ix+bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AkeLbFeJ; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e0b70fb1daso8704811a12.1;
        Tue, 25 Feb 2025 23:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740553540; x=1741158340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mkJ817mz5egdhi58ZIWEmLBtlaoU7i9Gaj/7Bxj66wY=;
        b=AkeLbFeJ9JPG+2L18jh9izAuDMXQcFA21wGLPZQwkKSnIHGywaux9O7DFx0LGxGOr/
         /tlexjHKwlYKObTuc0tpMUrXQlH06U8z1bGOOuC4tx+1eW4oN8gN2Lyi9zfX7R2jHUP8
         ntJEm1WnmztAtabi0XuCyglgX+OXV7N1LG3fihdL+g0kPvJ7Jndk7FC3MZL/mpI4kGer
         labZ7oVySoOqw74u8zWdpCrw+Ma1klJ2szmokaghYglgYp7DNdnbWPQnJHNqT+4MGlnF
         aqXiXohOQNhN3S8e5SYvXg1s6YEfpweUSgdbIf4F6X/v/+NBzfMeO4uIpr80qIT+Sf3m
         sqEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740553540; x=1741158340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mkJ817mz5egdhi58ZIWEmLBtlaoU7i9Gaj/7Bxj66wY=;
        b=tioeg8Ba5wUUIk9gYvfNUJ/wCDeOo+VG1KkB51ZwRayA/YF/Jj/u/qaZjzXb3l7eTg
         V/sbf9Ay09yUopOlXp5RlWSCmXtJElho1cNid/eHaZj+z3ELDSI0qCHlrAawUwX7Gnpc
         ch4BHcRVQ0bG2n+ldyXIQ8F9QDW2NwLJ64rFINLwyqlrlZMtKEP7TKTmGgQ9xcxONAie
         L1BWjZg6+MjSGKr0sJC9iFW+6/45JUWDw36ZgiWsEMnsqDcLy4J1qPp7mPw6eGatA/z3
         Lp503WRPglWezTO1O2zNguU6venNsFcG1mhiHZmLd3wrBzJhZVO5FRpyLrhGgS7UpEAS
         GYGA==
X-Forwarded-Encrypted: i=1; AJvYcCWj5fMp25RWLRCU3J6SEQHbH4IAugSTeayIILyhfPwg3i2JQ1KYSzTIVKQTf67cwzsZnL/M/p9cOWjw9IM=@vger.kernel.org, AJvYcCX90NalwsG/Z3lengqxcbF5gxEvGGp5vsKwz8aGQWjYd5qZHnFwtxinhM1RNhz2q0VsUmxGzGpXmJe6@vger.kernel.org
X-Gm-Message-State: AOJu0YxhjxZrO5CHAuIjRuduU53TH3UG0YoGLsg4xbtPNxD/i6IUJHxC
	oWYROC2fCXthHJQWViOJZ5Rab0O1nbRKmGrMjFrXMKYg+6STR+OV
X-Gm-Gg: ASbGncuXMz5ovmwYmbSggRCcXAi4GM0+0fsI4Rw9DkoH35w22orl+/bCdqV6XRM/yRW
	LpA1KV8hywAHARrtVmITFV8s/lTjApOXhA9M0FdXlhHll+2Y6z8AFgaHkPvj795bjFam1D7WyES
	+IBSfRjlOZkuck0/NKTVmaKeIbp2gTHX9bP1nnGGhWpxSlfg6Ifj9yT1GoUD9Ii7KQbCU+KGwJn
	ShlIYyASzlrg4TFl7K1U7DSS65Ty0Hk83vM/UimbtYgDLCyXZyC2e+zZm/i/X1G1ntMKepkYMGX
	tv9vWow53im4SqmI6Cj1yNenTyeEvbCVq3VeiZCJ
X-Google-Smtp-Source: AGHT+IEC1/k6GzG+zCvlAtOOJEZgDQR+mHRxEYNcXErOnLu63oM3/CoHm7JPuq/yW42KPJGGuf3kKw==
X-Received: by 2002:a17:906:b2c4:b0:abe:e2ac:62db with SMTP id a640c23a62f3a-abeeed11204mr189466466b.7.1740553540289;
        Tue, 25 Feb 2025 23:05:40 -0800 (PST)
Received: from foxbook (adqi59.neoplus.adsl.tpnet.pl. [79.185.142.59])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abed20ac11bsm268083666b.163.2025.02.25.23.05.39
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 25 Feb 2025 23:05:40 -0800 (PST)
Date: Wed, 26 Feb 2025 08:05:36 +0100
From: Michal Pecio <michal.pecio@gmail.com>
To: Mathias Nyman <mathias.nyman@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>
Cc: Niklas Neronin <niklas.neronin@linux.intel.com>,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/5] usb: xhci: Skip only one TD on Ring Underrun/Overrun
Message-ID: <20250226080536.4f6f7e93@foxbook>
In-Reply-To: <20250226080202.7eb5e142@foxbook>
References: <20250226080202.7eb5e142@foxbook>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

If skipping is deferred to events other than Missed Service Error itsef,
it means we are running on an xHCI 1.0 host and don't know how many TDs
were missed until we reach some ordinary transfer completion event.

And in case of ring xrun, we can't know where the xrun happened either.

If we skip all pending TDs, we may prematurely give back TDs added after
the xrun had occurred, risking data loss or buffer UAF by the xHC.

If we skip none, a driver may become confused and stop working when all
its URBs are missed and appear to be "in flight" forever.

Skip exactly one TD on each xrun event - the first one that was missed,
as we can now be sure that the HC has finished processing it. Provided
that one more TD is queued before any subsequent doorbell ring, it will
become safe to skip another TD by the time we get an xrun again.

Signed-off-by: Michal Pecio <michal.pecio@gmail.com>
---
 drivers/usb/host/xhci-ring.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/host/xhci-ring.c b/drivers/usb/host/xhci-ring.c
index ad5f0e439200..2749ebe23a33 100644
--- a/drivers/usb/host/xhci-ring.c
+++ b/drivers/usb/host/xhci-ring.c
@@ -2885,8 +2885,21 @@ static int handle_tx_event(struct xhci_hcd *xhci,
 					return 0;
 
 				skip_isoc_td(xhci, td, ep, status);
-				if (!list_empty(&ep_ring->td_list))
+
+				if (!list_empty(&ep_ring->td_list)) {
+					if (ring_xrun_event) {
+						/*
+						 * If we are here, we are on xHCI 1.0 host with no
+						 * idea how many TDs were missed or where the xrun
+						 * occurred. New TDs may have been added after the
+						 * xrun, so skip only one TD to be safe.
+						 */
+						xhci_dbg(xhci, "Skipped one TD for slot %u ep %u",
+								slot_id, ep_index);
+						return 0;
+					}
 					continue;
+				}
 
 				xhci_dbg(xhci, "All TDs skipped for slot %u ep %u. Clear skip flag.\n",
 					 slot_id, ep_index);
-- 
2.48.1

