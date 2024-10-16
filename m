Return-Path: <linux-kernel+bounces-368641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 034BC9A12C1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 21:40:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD8D4286614
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 19:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E222215F4B;
	Wed, 16 Oct 2024 19:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yNEy3q9e"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73AAA2144CF
	for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 19:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729107609; cv=none; b=M5XOYtE/sypn3pumqSo+JvBwpObPTQQ14hV5j/1zEHAWeqeRj6JD6WsieqSkE4zUMQbGXgaBppk0JvWZMNi85NJenWijdsK4CyvibaR2kOyAVrdRWj4ZOzrysolps4Bbhq/mEf41+WxpHFEEFdE5c7PPHsJgGVUn+CazxsdMg+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729107609; c=relaxed/simple;
	bh=brdpjYmJXn7ThpNb9Jl/rpudqX5V0z7rIkZzPSG5KKY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HWVmBz41+yU6USShciPw+dBc1ps4N8k1jgN0h3G3qG5Qjpn0IVNC4qwFQb0+nTTPH6xkP5lhZOMAml73l2O6l2j/f2m/RfbAprRaxN8WT8RdwsyjNDA+Ir9BFtVOEBkQ2Yy3UFDi/1SQi+YrmY5gEqEEQ8ocghYDx8FW6rZ5UPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yNEy3q9e; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yuanchu.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e3204db795so3915847b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Oct 2024 12:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729107607; x=1729712407; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bynrZn787vSIAU/ezJKfwwCMHmL7B1s8v41NnSYH3Dc=;
        b=yNEy3q9etGvb9tlW+XuHAU5gSQuNugSpDwcN8Djer1TLOcAd8TgZ+j9+vkjbkbIuso
         VOR5HJd5eyL7KjlYq6urk5SJh7P0spUPk1kdoE3mO3KU1DV4l2LezuragN4Ziki/xZjP
         o33sVjpQooSx+D8/Q1xHAaSOwZRweZHmTb3vzSNLyxpv3H6EZ6niEzvrGsOoC/RNpC4+
         xQmWL04H7YgbaLkq/BLboEBeDmhg8UDuiU45vGmngaTGToofZ8YPpKEGEmHqN0r8PEc+
         mWk4DvUcZ8GX9veCfqzSjh86obye442rQ8Evsv6oCWQ++uyqA9B1GX0tZBWjRfNrOcIK
         eoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729107607; x=1729712407;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bynrZn787vSIAU/ezJKfwwCMHmL7B1s8v41NnSYH3Dc=;
        b=GnqKcSCjQGNruEO1Ynlr/cvffBHe0nZoSQr1loh9lTlbBZF4XRkzw76isnm39qGotb
         sEQKBXriQr2uJKmzRU+s8pP9KjcOBP9cF8xX9CFZ/0khVD86hsuWkxY5pCDJ2fM9Z+2D
         W+uZWRxatb3/jDNcVLOy6/J3tNuJeNG0D4t4Uqgq5Ae1tmhuxLZIzPJDMlW0VeHo3STD
         ZzW0L4QPBOoZcTtIbTS4ptqNSv+X+grMyM2vZML0Zas4bwMac87Pub4l6elEliDPCiZM
         bF8R4G+zHyxo693wiGmoiNfBN3s7dBCYqv2EuvLCXbc4BJ0RH5xxfNqVngBwbAkIqeSz
         A+Xg==
X-Forwarded-Encrypted: i=1; AJvYcCWbBmeSQysR9RRqjwELbyuerMJUPp/oRpOR2VHRadq8gpFUlr2C5qmKkaWS6v6cKQSTyviawrfIEQKRcyo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyFLTYHB77JSh1MfayaCuUGXL8v2LQ/WKdvtHYAV2GoiMRZk7q
	tj3SFCq0OgObGk4chOMNtrWU+JBSVWitDK/fsyki6MO3YlOXfjPPjk6kYz7y4wVilJeJNr06Rg8
	Fcm1IAQ==
X-Google-Smtp-Source: AGHT+IEH6Dg9sYSxl39ijcngJbLw6yN9e0XfWHt8FeRQb2Rg19LkaJCzumI4mMLitFRShT3qz+ALDt4YegFs
X-Received: from yuanchu.svl.corp.google.com ([2620:15c:2c5:11:2793:a280:1184:4a14])
 (user=yuanchu job=sendgmr) by 2002:a05:690c:2fc9:b0:66a:764f:e57f with SMTP
 id 00721157ae682-6e3d41fb686mr66667b3.7.1729107606955; Wed, 16 Oct 2024
 12:40:06 -0700 (PDT)
Date: Wed, 16 Oct 2024 12:39:47 -0700
In-Reply-To: <20241016193947.48534-1-yuanchu@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241016193947.48534-1-yuanchu@google.com>
X-Mailer: git-send-email 2.46.0
Message-ID: <20241016193947.48534-2-yuanchu@google.com>
Subject: [PATCH v3 2/2] virt: pvmemcontrol: add Yuanchu and Pasha as maintainers
From: Yuanchu Xie <yuanchu@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Wei Liu <liuwe@microsoft.com>, Rob Bradford <rbradford@rivosinc.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, Pasha Tatashin <pasha.tatashin@soleen.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, virtualization@lists.linux.dev, 
	dev@lists.cloudhypervisor.org, Yuanchu Xie <yuanchu@google.com>
Content-Type: text/plain; charset="UTF-8"

The pvmemcontrol driver lives under drivers/virt/pvmemcontrol. We
specify maintainers for the driver.

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
2.46.0


