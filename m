Return-Path: <linux-kernel+bounces-404558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BBC9C4514
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 19:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF3681F25D3E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Nov 2024 18:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953C51AB53F;
	Mon, 11 Nov 2024 18:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gDawcZu4"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9BD91A256F;
	Mon, 11 Nov 2024 18:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731350207; cv=none; b=QHBKvomvcsupiZNQQLAQY73/Iltd1nyLKBmagcCceNzGg5D4PRd8bckKPe1TEj+ez/OoR2h1KFjOqjspH9hBYjZHENv57z3eYPjQarv+GhBxyN8lPloiQS1ehFo1vGoxQ7FegXmEwjFSXOJFnBbbm4hs321G8vRpXV2eJdnxE8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731350207; c=relaxed/simple;
	bh=w0bgBy0n2+FCH3qmin0izJA7cA3pLvtXIFYWTmL7ySc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hNyvQjjlwfSRvohB3HRcREEbxJTT1ZXknDGHi19pXYSqBkAmupPZEc5Js2+JhEWT7o6jvUY9LFXhWoQ1pLBjX8RRxfPCu31LI4+3jVtoDC3cjrla6xgrCkliwi5TvlVnP9fbJCezE2g3sjJXrjdqeY6jed8qmVp7SuhQ5/DhMJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gDawcZu4; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7206304f93aso4346995b3a.0;
        Mon, 11 Nov 2024 10:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731350205; x=1731955005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N7lAsNA45V3HSSzdWqgKjfdEZSKR1i8UxGyHjvsXyqM=;
        b=gDawcZu4rOfugq6yE2l5eCvLlGoy8aXpj4FnxLKLyZ6U5KsYHfjylLNcj8/akOZla5
         x5Z8ctandoucu4iSgSrefxkRCqgkjStFNXFEqAmPPnH9l4Oq4iz8UMnbXjdxsD919rO0
         07bDYv6uHTz6xjAhE5R8WjBat+aWrmJA0uSyuLQPbC7bHQdOuClfbkUZ/2Wjb8v26Uve
         IRnrdag6UdDLq8lq8hME62Z2DeHU6P1wYVuUqldxRlOcqctNRUVFy2ROjnKRqkzSFSnQ
         BwkAebJj7pxe5TPZ+cwCyNmAyposSlRVLgXVevOty0g6dU6r1p8fX8vjOhnXJPTamSH0
         3uVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731350205; x=1731955005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N7lAsNA45V3HSSzdWqgKjfdEZSKR1i8UxGyHjvsXyqM=;
        b=any2nHtEDpq0xvtt/9G62sLmZ/Gg9WmAE+dAv9VzqrJs+lCJSvCIW7pAu2p5+EStuf
         GexByGFazWEQhQ+ruYG2ALAwPyK5c4ZGJC7t0aZZ4GCj4OVtPXEgfFn1JMJGIgLx+xYO
         kJCsnVW+2sLT2UL7b536nYD1PVtF+gEagASctz1rQXnLZZAfh0ZyJDdTiVZzE7lk+saQ
         uTPzHkg/5q1zy+uiFAdZYjmvDSbXqeJL6mkf1+31X/uXFG6LnTmPZu/mGf5SUutP3TvU
         m6X/Gzj0EndHQCztMmYv48+v9a5o4g1UoC3XVq5I0wHV0eJcB1D2TeLt2bgeimZz/LGn
         LjzA==
X-Forwarded-Encrypted: i=1; AJvYcCUC9xIypy6zFxyej6Qlb224P5xsweP89ykZz9dt594PELczs4qryxodC6wE63EZGCzwiC7f9ewspYkZzu4=@vger.kernel.org, AJvYcCVFPLsVwNz7/d5DAv1w/3AQ6KwIQR37q7miDO+N1xr1mpILHsxVtXMELT5G3uV7JwnL2T4rBNRoCZ9SX66pYdibZNB9Mw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwHnOSBc+wbhtnEH9Q57q/PXYsZEUG4XA4OGmrRisups4TtA6cw
	+5rAJkzNFaJ1qTgjY8DAuYyYQoLvVjLj5BAHl7z+n8NpE0AgplPX
X-Google-Smtp-Source: AGHT+IEI3sYbbEXw0OXsJMF0sKWakQUpRqp4j15sbyH+SPVCKurUp7KmrgdH98Ww7+3iCHmTuoTKTQ==
X-Received: by 2002:a05:6a20:9f45:b0:1db:ed44:ba68 with SMTP id adf61e73a8af0-1dc229afa0cmr19550349637.17.1731350205015;
        Mon, 11 Nov 2024 10:36:45 -0800 (PST)
Received: from localhost.localdomain (host95.181-12-202.telecom.net.ar. [181.12.202.95])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a18eebsm9700266b3a.147.2024.11.11.10.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 10:36:44 -0800 (PST)
From: Kurt Borja <kuurtb@gmail.com>
To: kuurtb@gmail.com
Cc: ilpo.jarvinen@linux.intel.com,
	w_armin@gmx.de,
	hdegoede@redhat.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Dell.Client.Kernel@dell.com
Subject: [PATCH 5/5] Documentation: alienware-wmi: Describe THERMAL_INFORMATION operation 0x02
Date: Mon, 11 Nov 2024 15:36:39 -0300
Message-ID: <20241111183639.14726-1-kuurtb@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241111183308.14081-3-kuurtb@gmail.com>
References: <20241111183308.14081-3-kuurtb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This operation is used by alienware-wmi driver to avoid brute-forcing
operation 0x03.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 Documentation/wmi/devices/alienware-wmi.rst | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/wmi/devices/alienware-wmi.rst b/Documentation/wmi/devices/alienware-wmi.rst
index 03f932494d58..ddc5e561960e 100644
--- a/Documentation/wmi/devices/alienware-wmi.rst
+++ b/Documentation/wmi/devices/alienware-wmi.rst
@@ -96,7 +96,7 @@ WMI method Thermal_Information([in] uint32 arg2, [out] uint32 argr)
          argr = 1
 
  if BYTE_0(arg2) == 0x02:
-         argr = UNKNOWN_CONSTANT
+         argr = SYSTEM_DESCRIPTION
 
  if BYTE_0(arg2) == 0x03:
          if BYTE_1(arg2) == 0x00:
@@ -179,6 +179,16 @@ WMI method Thermal_Information([in] uint32 arg2, [out] uint32 argr)
          else:
                  argr = 0xFFFFFFFF
 
+Operation 0x02 returns a *system description* buffer with the following
+structure:
+
+::
+
+ out[0] -> Number of fans
+ out[1] -> Number of sensors
+ out[2] -> 0x00
+ out[3] -> Number of thermal modes
+
 Operation 0x03 list all available fan IDs, sensor IDs and thermal profile
 codes in order, but different models may have different number of fans and
 thermal profiles. These are the known ranges:
-- 
2.47.0


