Return-Path: <linux-kernel+bounces-428302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F959E0DED
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 22:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDD22B2F73B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2024 19:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C94F1DED7F;
	Mon,  2 Dec 2024 19:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b="NHxUyl+i"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE9071632FE
	for <linux-kernel@vger.kernel.org>; Mon,  2 Dec 2024 19:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733169314; cv=none; b=RqW8N7pCQIP9lFKriNy/C+s3nbUheZpxcTvb8Pgm8oR9JZHOAkcQDuQkG0a5GyTsDAUQfrBjhDjmww+FrWNtelx1UjgJPSf9Tsv8Dejllyz0dFgrbJE3knMNb0bGA+WvIXB3HF3vCFqFdJjlaprKkTccV/EKJpcR7QT+Npdu/Qk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733169314; c=relaxed/simple;
	bh=oAEOGPcuE44jG0Dh3+qdeTTc+f0IFCOK7ugZhh8C/V8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KkFkVxpAl6UMG+KD9yFyVSWroTtrfZNT/H5yuYLYaqoHSKFKTNVSYgiJTw+6tTjHG5C1ouhRxuVERL/WArqie/i9+fK1IjKfGXcz8M1Y2JjogudX5OBhzS/k6s2U+78T2tOuLyeuYQvzITD//7QIJKgUzQvPWZAyuAB/TwpFWfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com; spf=none smtp.mailfrom=kutsevol.com; dkim=pass (2048-bit key) header.d=kutsevol-com.20230601.gappssmtp.com header.i=@kutsevol-com.20230601.gappssmtp.com header.b=NHxUyl+i; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kutsevol.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=kutsevol.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7b66d20e9ccso225969685a.3
        for <linux-kernel@vger.kernel.org>; Mon, 02 Dec 2024 11:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kutsevol-com.20230601.gappssmtp.com; s=20230601; t=1733169310; x=1733774110; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CTz4SYNXtVQrTL3+YDyL63H/cUWUuCh7OMJoBZyQv8A=;
        b=NHxUyl+is2LOIC5lC5O5U7WBKK4to1XO+I5azl2gcE6/8SyJ5xVQCesBCvAXgfMoVv
         RhwBNbWv9jqmq0WNQMLFJEN8OekXxuSYsCde8IUQa0gXyLoS58/P//bhW01nN18PJby1
         rUKSZU5zsuJ/df++kQFUh2sujtHJpEgWwofZ2q9UKHr/hngq6ZruBrsJtWSmHupxHNwQ
         fcLzr34rf4oyvFnLKb09YR28krZi/wkCHq+zrqjBHVIoTjBFDT2ei9+Jz0oleUcK54GA
         LrNbm7vzjHDoxD41kMYmSpZj7sm4hH22DBoQIZa7QTTNs+5DlnzOaURezuU2mbzV/HqO
         FL1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733169310; x=1733774110;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CTz4SYNXtVQrTL3+YDyL63H/cUWUuCh7OMJoBZyQv8A=;
        b=wB46E86NANbQlIAxgvHMfSqCLsNCdjpxpNCg3ePIyITTLLMujnLUymEy/NU00AciI1
         /YDlKtRY4tqSeio9smWmOCahiIDJZtv/d/YC8edW3nJr4EDnukTedWboloKqF38atjjW
         Zzh7Q5Skuj/tS556c9wQG8kKy1W39xgT/jgMlJvkpThaIZ7O8V/CHKNVmHhh6Tjofi21
         4ZyCCuJSx9cLoqOjwGpN3x0a8uGYCSM8k4KkpM111gZQstKT+Z0B8QOlvdfF0PX7/oHl
         jqZPymfbFPEIP7Ck4/W/ecHerAzdWE228M+eIEcqhjaLWHFMFfYPEYsFffFdNbPkmEI0
         TUcg==
X-Forwarded-Encrypted: i=1; AJvYcCU/9hjaTkfirhaKz5BqQ0A+AO7s3gd3PZOdKGXwJ5Y/B4ov1twNnRFmWJDfmStD3Lellz0GF95Ebn7ob+s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/vip155CjmSOcdetxuQaCv2zhvXQMjPx9TBTuaRmjxBoo0YDo
	KoN/CrC2U0QyWzbycd5y6XPyVCrrAQ0UAy59B/+6PmQ339b3TEfhj0lzw/YiVoA=
X-Gm-Gg: ASbGncu1PT1EksUNxMVjVHm38Ekwa6C2/KaZbq3JZNPP/uh9cTo0aGxHTPeQ1oYg6a/
	UrhW5o2H9r2MduyIwv6UqUk8yh/59237oLlQ/1fFTGC0PkHWzHQEOBh/sy/rr24N+ROZvuE2XYr
	iZJYU+x2Yb0iA5U8FZxNb4OOocwttn5WzRB/lfB+ZMAKcig7weURXKQPoiXg+1Hl4UlJkq2/cY7
	E0DQyUjFduq4+Oc7vMvwHtjHzBO1jU2EghvLjZVTRUkUD8nw2iX1xWu8lYzT2m92Tj//jXO1rPM
	aXnV76aSZL0ukxv9Ug==
X-Google-Smtp-Source: AGHT+IFbAoiJQCOE6Mt28cCoijQb6g4P6fK4OCOHQ1IvMryYVO44sJECXuqxmew2uqRFGxCiEbEwVw==
X-Received: by 2002:a05:620a:688f:b0:7b6:77c0:a096 with SMTP id af79cd13be357-7b67c443becmr3395019985a.46.1733169310407;
        Mon, 02 Dec 2024 11:55:10 -0800 (PST)
Received: from localhost.localdomain (fwdproxy-ash-112.fbsv.net. [2a03:2880:20ff:70::face:b00c])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b6849aac8dsm439338585a.77.2024.12.02.11.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 11:55:10 -0800 (PST)
From: Maksym Kutsevol <max@kutsevol.com>
Subject: [PATCH net-next v5 0/2] netcons: Add udp send fail statistics to
 netconsole
Date: Mon, 02 Dec 2024 11:55:06 -0800
Message-Id: <20241202-netcons-add-udp-send-fail-statistics-to-netconsole-v5-0-70e82239f922@kutsevol.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJoQTmcC/6WOTQ6CMBCFr0Jm7RiEItSV9zAsmnaQRmxJpzQYw
 t1tSDyBy5f3vZ8NmIIlhluxQaBk2XqXRXMqQI/KPQmtyRqqshKXsmrRUdTeMSpjcDEzMjmDg7I
 TclTRcrSaMfof5ydCo6VqlBzkpZaQi+dAg12P0QdkLrNrhD47Y8778DneJHH4/wwngSWqrrw2S
 tS6k+39tUSm5Kez9m/o933/ApDU3JABAQAA
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
v5:
 * Don't align the struct.
 * Rename netpoll_send_udp_count_errs to send_udp.
 * Link to v4: https://lore.kernel.org/r/20241027-netcons-add-udp-send-fail-statistics-to-netconsole-v4-0-a8065a43c897@kutsevol.com

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
base-commit: 65ae975e97d5aab3ee9dc5ec701b12090572ed43
change-id: 20241027-netcons-add-udp-send-fail-statistics-to-netconsole-dc9a5a9f9139

Best regards,
-- 
Maksym Kutsevol <max@kutsevol.com>


