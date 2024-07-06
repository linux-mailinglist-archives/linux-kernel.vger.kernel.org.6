Return-Path: <linux-kernel+bounces-243086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29BD092916C
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 09:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A9B51C20D97
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Jul 2024 07:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6B71CAB8;
	Sat,  6 Jul 2024 07:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="KIC5+1EY"
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95631C2AD
	for <linux-kernel@vger.kernel.org>; Sat,  6 Jul 2024 07:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720249931; cv=none; b=nNNRSQ7I3fgAYdZJZ6fMo9+5CLTQJUtDj610Cf7a9GRRrGaH3WWQXTTnQx32CZMqiiesbQNjCymFOogxVa1vxclrK8QbVv4/ltwQxssNuqBToxiPNzHU70dfZtScNh35dY/AzrDwKaPyILtOfy0JVuCN96lXOoySTY1Hb/V4+T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720249931; c=relaxed/simple;
	bh=pRdqgQSLxCw7s0+Z4EG0qKtEpm8+VGpqYfnMuZ5v9yM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iuuUIZ21MLBXRZ7Z1J9gsULXa0+Tk7LCWrl1kaq8L/jXfyOtf3ibbTXfS7XqZguL/LQX4zoDZpyh9M+C1Y/IBe063n4TkdGvx4sWh5kgt+cQTtGtykAd+fII+AiMwoRe0YRuJOpydghpPz9+WNGV6Za4uTZCtUN0UgRRjNpH5iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=KIC5+1EY; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-36dd56cf5f5so8720025ab.3
        for <linux-kernel@vger.kernel.org>; Sat, 06 Jul 2024 00:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720249929; x=1720854729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pBU/rymr2sXnQ8jMVGFQ/FuQw119gxmXGTmzs+tMs8I=;
        b=KIC5+1EYDZOu7Oj3S+lpVpy4spLDefVFpRsG5xl5yq21fayQgB/CmdSPytOUXzT/CJ
         X0Za1NBUos2GI8SAzvm1pJUgNblHPMm1HFwQ0pUMHz0VYheyUf0qWjOv4/JFTJLDUlLh
         RgJPWGYgXgbY4vollE4ejDrOdURAogx+5sxfqql1nGEj8tYdc1T/ikAu1fLtsjevAiG5
         DPeoAYRZUo9bxzrpIny0fA1UXaykYYkHufknnXW6oWw1KRwxYCHzvnwZ05qKkvEbP0i0
         Kvr3fKl/BZOS+eM8FYIlDNHZNJh6fQkip6sOL3vwiGpN+j9Yo3QDmSAnBSKZFVT+OK8X
         l7iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720249929; x=1720854729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pBU/rymr2sXnQ8jMVGFQ/FuQw119gxmXGTmzs+tMs8I=;
        b=UHKL1QhQ1gDNFwZi4MiQWeBG9YxZDCUnzj2QQaj3xGx+CZ/bzSyGKY3fFWYRuRfgwy
         lgzoJvYGRbdzn9lrvmcoGMcdPW/r9T9QfrhSb1CqwIYbnNkp5t+H9l7INgbWg6q9QX+P
         7R5GVbuHKJ8fXCtpKXHHzjbskmuzypr6sAmKzziNkUQ5Bo+pz1+Ke449JsBZ4YYeeUH8
         RHQ4e5x5PCK0xsMfAQIwDEgq4Fo6Gse3WakJ/9XxBnyXpAHOsK1v3TXKYsDTfbNxeQfC
         XGCHM/Ng3wl3gGN/BbyhxdVc589XZsKpxdS3sHhKj6tzQzlxjpsCoPJ0S+IxlW0cDVbV
         18Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVDDpek7lpHb1xb5XFMgcOEYJ/TV/jXNznGNRJWgQEj8HLGpbakQnTD6pIev3fkVZEKJU9NGsUeoAMU50OTyncQsU9ViV17ylkdBv/A
X-Gm-Message-State: AOJu0YzlhKzjglXlRfOeftbJWI1zqS6FRWJs6H7i1/oDTiV2BnPTT82U
	vaRGfTQRVtsyR5sPIpIzeazHsszOBIfom3Q0XeXSTfhmc5bAUdurkS7bZZrD8uA=
X-Google-Smtp-Source: AGHT+IE3zQMSFK/fbRzcbv7S0sxo7hPGZzrByXAJW70o+JHkBq52dAH/GLhjQhmzXMBjOV2I5kCG9w==
X-Received: by 2002:a05:6e02:148b:b0:374:6e8f:c760 with SMTP id e9e14a558f8ab-38399e4a998mr84825435ab.20.1720249929076;
        Sat, 06 Jul 2024 00:12:09 -0700 (PDT)
Received: from fedora.vc.shawcable.net (S0106c09435b54ab9.vc.shawcable.net. [24.85.107.15])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-72c6d416554sm11921931a12.94.2024.07.06.00.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jul 2024 00:12:08 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH net-next] udp: Remove duplicate included header file trace/events/udp.h
Date: Sat,  6 Jul 2024 09:11:33 +0200
Message-ID: <20240706071132.274352-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove duplicate included header file trace/events/udp.h and the
following warning reported by make includecheck:

  trace/events/udp.h is included more than once

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 net/ipv6/udp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index c81a07ac0463..bfd7fff1bc0c 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -46,7 +46,6 @@
 #include <net/tcp_states.h>
 #include <net/ip6_checksum.h>
 #include <net/ip6_tunnel.h>
-#include <trace/events/udp.h>
 #include <net/xfrm.h>
 #include <net/inet_hashtables.h>
 #include <net/inet6_hashtables.h>
-- 
2.45.2


