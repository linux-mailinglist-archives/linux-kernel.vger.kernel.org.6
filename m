Return-Path: <linux-kernel+bounces-345076-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DC398B1B2
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 03:13:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E19C8282DE9
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 01:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5709E11712;
	Tue,  1 Oct 2024 01:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZSI+Jcvw"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BD6C153
	for <linux-kernel@vger.kernel.org>; Tue,  1 Oct 2024 01:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727745219; cv=none; b=sp5h8kusoGKRqPPdp7Dlc9bEHUHtF6N6iJvAy6b3yUj9GFFS8V7NEi+TD7IcUes5JDUquBa8i+7F3eK0s/sg4vhUNQXFDRvNDc07rSJNeRUnryNx3/JlLDPr1dXOQuWds3Zvvd9SwPUUw7qpZZiuPR5rrHBJVMPLZVzi428Fdp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727745219; c=relaxed/simple;
	bh=foTvS2kZQWqUIQ5whLAVtR2Zn8mUtJtiuvWR2WBRGhg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=A0X5aqPDdIigyDMZpCAuf9zyxPdoMrSHM6IRSpjasnYS/zKmIUs9BUnbeuhb+28LWcHxZGc51loLRC8biOevVM3I1+m7HHmwp7wKEO+7HJekbOX0JaCIaAeCY0eunI4Lt86jlzLGOjnoOo2Wv94I4IoBGcaLo4oxVt+EV6lE7N0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZSI+Jcvw; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6d7124939beso82536747b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Sep 2024 18:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727745217; x=1728350017; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qchQsg/qNbRX/pVJ9McbPj0llmdwBRtNmtuFlN5g4dw=;
        b=ZSI+JcvwX+4J3oDBWo4Y+S2U/Z8M1ZDXxWKO1bkAvjrI+fpxJOmQjaMcRbwxJvHZsM
         1zh/90Jjte4ci9rNDU3Zf9J/SSPA55wzjnhjFQbQwmBQ2tjH6qBgqO7+LMDeTpyepTst
         iURNCY2Me2q1hrk1s77xWbhNGByk/wsIWFZt0Vwzr8FSbNMZ71ekG6c8Topb+LiCYtKx
         kOmNnF18jYBwprqpqbgLXXwnMirj5Pss998+Gn+dCxYBhvGtdlWMegYDi5ovKfMaGVEc
         WyJxNigC7ON7SGTcwwoq7aP0ZgvolDolX9MhJ27LR5k5f5TIUGB2cDO5PzqL2GGwR2U0
         9qeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727745217; x=1728350017;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qchQsg/qNbRX/pVJ9McbPj0llmdwBRtNmtuFlN5g4dw=;
        b=xKbPUDmPCk5BUezP/wOArwH30PxMOmqaqLNv+dbJsF8G371Bo4bl2KlQpFBnsa1ukT
         9DveAVFOZpNuSmsRYuSchz7IHVorDsDBvdXhZkKJDvIG2+NBiQhLudCFs4gIJny4+8vk
         rDhq02XUolaB86VUmU+SvkiecJjdsDwQlDB1GUaJelk+hdQl0DGhSjYGDhw58WpxFd8i
         pddJcqR8m2Q4UNgD6SA4uYBKr8fJuMxWu/4B4sk1z3gdiP73x69H4G1ba1z2gb/KjU8T
         2dJX9PYc5d2ZgP8ZiPwfl+QCSH3BL7cPaEm9zbnm/3FW/3Rj0oX0FpRfb54otNpRWuMJ
         fToA==
X-Forwarded-Encrypted: i=1; AJvYcCW4EkwMk9JGUCdOMqT2FH4GAIVpIx0ikO7hd1rgpOPkWifTU0eLmsKw6GfDXIlcOyacdA7CgAWRH5kt8k4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3aD3hbrfmMNKX1lZ16+Ir5lrnDxQCqO635as73owDs/YJ/6cR
	0UjCV/oVwgX+xnWDAfRy1BDxFe1rA5pQdoXy9YSZsd2e9VdE/CsUQKiZwSmRXl1UE75wBrPGBW9
	E+IpXMA==
X-Google-Smtp-Source: AGHT+IGCiqik6XxbJ03Gc/eBgy5fKINyy2lsI7yUCqtsEdsmAZb+g1iMvsLXq/1U77op54NfuJ/jv4id2rPY
X-Received: from yuanchu.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:4ba])
 (user=yuanchu job=sendgmr) by 2002:a05:690c:6187:b0:68e:8de6:618b with SMTP
 id 00721157ae682-6e2474bcbb1mr4697667b3.2.1727745217364; Mon, 30 Sep 2024
 18:13:37 -0700 (PDT)
Date: Tue,  1 Oct 2024 01:13:27 +0000
In-Reply-To: <20241001011328.2806686-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241001011328.2806686-1-yuanchu@google.com>
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20241001011328.2806686-2-yuanchu@google.com>
Subject: [PATCH v2 2/2] virt: pvmemcontrol: add Yuanchu and Pasha as maintainers
From: Yuanchu Xie <yuanchu@google.com>
To: Wei Liu <liuwe@microsoft.com>, Rob Bradford <rbradford@rivosinc.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	Jonathan Corbet <corbet@lwn.net>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Dan Williams <dan.j.williams@intel.com>, Tom Lendacky <thomas.lendacky@amd.com>, 
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, virtualization@lists.linux.dev, 
	dev@lists.cloudhypervisor.org, Yuanchu Xie <yuanchu@google.com>
Content-Type: text/plain; charset="UTF-8"

The pvmemcontrol driver lives under drivers/virt/pvmemcontrol. We
specify maintainers for the driver.

Change-Id: I3ba78d0fefe594cd5ed6805775e6497572bb7187
Signed-off-by: Yuanchu Xie <yuanchu@google.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index aacccb376c28..5e661f39e07d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18125,6 +18125,13 @@ L:	linux-wireless@vger.kernel.org
 S:	Supported
 F:	drivers/net/wireless/purelifi/plfxlc/
 
+PVMEMCONTROL GUEST DRIVER
+M:	Yuanchu Xie <yuanchu@google.com>
+M:	Pasha Tatashin <pasha.tatashin@soleen.com>
+L:	linux-kernel@vger.kernel.org
+S:	Supported
+F:	drivers/virt/pvmemcontrol/
+
 PVRUSB2 VIDEO4LINUX DRIVER
 M:	Mike Isely <isely@pobox.com>
 L:	pvrusb2@isely.net	(subscribers-only)
-- 
2.46.1.824.gd892dcdcdd-goog


