Return-Path: <linux-kernel+bounces-383775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 650269B201A
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 21:01:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6AAF1F213FE
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Oct 2024 20:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C3BC184539;
	Sun, 27 Oct 2024 20:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b="oEDRhVzo"
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2583C17B4FE
	for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 20:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730059238; cv=none; b=MEfWbYpDv1igLx6fQRGcD/4Skxd8W0xail8GFPoRVkWKOtRA+9pWX2j0gj5gLY8dH0sMoWg25CGxZrZ8ywRK8gFgBSNu1/+DFvvG6drJcsXukblXcC7TQdWgoMPGJiVQSgfDCH3vjldXPpZxE//XHraX8Q6xvJC257jf453DHsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730059238; c=relaxed/simple;
	bh=HnC/YPSHeNYM8IsGJsmyJAFQYRswBMe+vOP4b93Fgr8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lq2yoVcftGAGONzhYJ4yvdp0Mb92Cm6ejaBZFuo65YuVyFLWy3lhO+p/TShUhlaFHWxnsd1AXsTMecbpCmuOS9IJ4EXg3FJWV034i/02BW5oF9u1DJcf862FloiYfHNVR+/Bf8gd3qS2BWHQoeeRf2jaFA+8igpVeiXOiih39qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com; spf=none smtp.mailfrom=kutsevol.com; dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b=oEDRhVzo; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kutsevol.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3e604425aa0so1929923b6e.0
        for <linux-kernel@vger.kernel.org>; Sun, 27 Oct 2024 13:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kutsevol-com.20230601.gappssmtp.com; s=20230601; t=1730059235; x=1730664035; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hoy0+G1B62y4A0aPMtVHcQS+DKaSVd+7u5DUTQklBRA=;
        b=oEDRhVzocnC+AMmA35nACpiaVpcC71E6YZ8PPuzck9YNOBbuKMX3/dsvsFzKRZqlA7
         JFpvEfAqDtuRdySsZvqml7Zmyeo8tessGQp0TdbVleUBggfODENUsPI0K7KbA1Oi1yW+
         gpA1CHh26+YnHCW+G9aVIARQtSnVkTP5xPD2U+b2qX6mrQq2ztM8/4GWnWiACzKz6rsa
         yVBx07StjYG1Ct3Wbhum87pOgbAtWbdJp49WtjAZtEaFyLhWVlClGx3J4QV58AmXJwa0
         viNOXHxSbsnxUEGZv2wGIEaycpD6TGOVrs+I8DYFDJx5kn0hk4VLzMWf+3iOUWJ+iok2
         GHWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730059235; x=1730664035;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hoy0+G1B62y4A0aPMtVHcQS+DKaSVd+7u5DUTQklBRA=;
        b=eKjnQORbg/Fq+wZyOt0lWnGImWlULFX17vI1cYo0IBqEw63QB8cIRtmBIGVCu/sBFD
         Qzm+PgHk+JZeYYh+ib30lyQT/f1jx4OhVIlrLvQ8VthZpRTRq1/PRBKCFncRX5GMvS9c
         OaYhwoGYUMEbhGvU94yn0nOcDnsjNi2JbG/gQFXIJ31J9i4M8QtHqCbyaUi15o7oc7jT
         pgo3M3p5mbG7zgIHmVihE1g6sUimL8zj0Y9VejGvTyxRg6HuW5PCEn4EDZlvqoC+MI06
         xVStv8ewTM8DlcZoogp03P7chwAjtkNs5SdAP6ETCTuYtByYT/tycYmnFBmbnMqeK3sR
         iFGA==
X-Forwarded-Encrypted: i=1; AJvYcCUUWLPtMj2WnzoV0LzbwrkOf1IwYWxRidlG7DODScBeMhBM10+IjCqotqcfzYC+aly6FI/+05DjAlXbr2c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyP3XbE06UmNLfUrBr0iOHtIPh+EP9VzEJPX5dx1dAyMZlN+5X
	4zNWnN+SgXH6I/0XpzcTGoztAfH7Ce4f6VeovRxAWOA9BzcrN/LAJ+efes9DfPQ=
X-Google-Smtp-Source: AGHT+IFbKUZ7FnBC2Wao6JUPJhNSJps9AKvrtUtqDnBgQVi+QfoNxo39LrQXX2TIC3JIc1aepdLG0g==
X-Received: by 2002:a05:6808:2dc6:b0:3e6:40b3:e525 with SMTP id 5614622812f47-3e640b3e88amr1601921b6e.41.1730059235127;
        Sun, 27 Oct 2024 13:00:35 -0700 (PDT)
Received: from localhost.localdomain (fwdproxy-ash-017.fbsv.net. [2a03:2880:20ff:11::face:b00c])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-461321431a1sm27946241cf.25.2024.10.27.13.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 13:00:34 -0700 (PDT)
From: Maksym Kutsevol <max@kutsevol.com>
Subject: [PATCH net-next v4 0/2] netcons: Add udp send fail statistics to
 netconsole
Date: Sun, 27 Oct 2024 12:59:40 -0700
Message-Id: <20241027-netcons-add-udp-send-fail-statistics-to-netconsole-v4-0-a8065a43c897@kutsevol.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKybHmcC/zXN0QrCMAyF4VcZuTaw1YnUVxEvQpNqYLSjiTIYe
 3eL4OUPH+fsYNJUDG7DDk0+alpLj/k0QHpReQoq94YwhnkawxWLeKrFkJjxzSuaFMZMuqA5uZp
 rMvT6d3UR5BTpQjHH6RyhD69Nsm6/0zt01+3m8DiOL+5Js9uOAAAA
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 Breno Leitao <leitao@debian.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Maksym Kutsevol <max@kutsevol.com>
X-Mailer: b4 0.13.0

Enhance observability of netconsole. Packet sends can fail.
Start tracking at least two failure possibilities: ENOMEM and
NET_XMIT_DROP for every target. Stats are exposed via an additional
attribute in CONFIGFS.

The exposed statistics allows easier debugging of cases when netconsole
messages were not seen by receivers, eliminating the guesswork if the
sender thinks that messages in question were sent out.

Stats are not reset on enable/disable/change remote ip/etc, they
belong to the netcons target itself.

Reported-by: Breno Leitao <leitao@debian.org>
Closes: https://lore.kernel.org/all/ZsWoUzyK5du9Ffl+@gmail.com/
Signed-off-by: Maksym Kutsevol <max@kutsevol.com>
---
Changelog:
v4:
 * Rebased after
   https://lore.kernel.org/netdev/20241017095028.3131508-1-leitao@debian.org/
   was merged
 * cc doc maintainers.
 * adhere to 80 columns. Learn that checkpatch defaults to 100. Okay :)

v3:
 * https://lore.kernel.org/netdev/20240912173608.1821083-2-max@kutsevol.com/
 * cleanup the accidental slip of debugging addons.
 * use IS_ENABLED() instead of #ifdef. Always have stats field.

v2:
 * https://lore.kernel.org/netdev/20240828214524.1867954-2-max@kutsevol.com/
 * fixed commit message wording and reported-by reference.
 * not hiding netconsole_target_stats when CONFIG_NETCONSOLE_DYNAMIC
   is not enabled.
 * rename stats attribute in configfs to transmit_errors and make it
   a single u64 value, which is a sum of errors that occured.
 * make a wrapper function to count errors instead of a return result
   classifier one.
 * use u64_stats_sync.h to manage stats.

v1:
 * https://lore.kernel.org/netdev/20240824215130.2134153-2-max@kutsevol.com/

---
Maksym Kutsevol (2):
      netpoll: Make netpoll_send_udp return status instead of void
      netcons: Add udp send fail statistics to netconsole

 Documentation/networking/netconsole.rst |  5 +--
 drivers/net/netconsole.c                | 61 +++++++++++++++++++++++++++++++--
 include/linux/netpoll.h                 |  2 +-
 net/core/netpoll.c                      |  6 ++--
 4 files changed, 65 insertions(+), 9 deletions(-)
---
base-commit: 03fc07a24735e0be8646563913abf5f5cb71ad19
change-id: 20241027-netcons-add-udp-send-fail-statistics-to-netconsole-dc9a5a9f9139

Best regards,
-- 
Maksym Kutsevol <max@kutsevol.com>


