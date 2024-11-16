Return-Path: <linux-kernel+bounces-411865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D57159D008E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 19:59:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB6FA1F22F9E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Nov 2024 18:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7DBD19340E;
	Sat, 16 Nov 2024 18:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P6ncxo1K"
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 075FD2B2F2;
	Sat, 16 Nov 2024 18:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731783540; cv=none; b=o/QEObvBgL1sw9kspfekyJ5Tr6Sfuh4V7tG3CHedrBJ5FgIenWGYskkLAoRmasHw8BJt/zJsFUcFTalOntYYhylHL86H9HtRrBBWUSqGqOINHzHfHP6l+j2BbL81l+oCVYs3qOqnYAqB0ee9rOw32XFxUJ2kJzydYn/RX1RMkdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731783540; c=relaxed/simple;
	bh=9NvF7CoMbqIuVC85V+rA1ofb/pRfjazXUXP451cgYUE=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=hD37tZrMW5sK4556uIEEG5hLI34du3tVwJo3pN8lv1cRLbHr/HfAjnzd2lQ656F9JnaEFwoYfG+NCHv2c7q2uwhnLbT7HlqcM6VthwfIUICJD7RtiV5swFhKE3new+cbNf4VzNO1tdpzYZyXrmYkg+3I4WOB9m0E+wp6n3gM9l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P6ncxo1K; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-20c805a0753so28067825ad.0;
        Sat, 16 Nov 2024 10:58:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731783538; x=1732388338; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6g1oQXsTrdrctZscRJ3TPVmonDFH95VF7gA1oQnI5y0=;
        b=P6ncxo1KEft0q6sbI4UuqUdSZcrFq5lhtK3A9nX0wJddYjZwDCB1+o8mVRSvJfbNy8
         VGp/AsrBNdHrgBqbLhYRImjeGejUAxG60lCjob8Qb7HTX+2HfAyRyd2if0G3KIIrx4i3
         8mYRxM+2ohOvxAX49cjyG5nlwG+DU1bZVune7aHfCAf07kvEWk7pKX8y86bje8wN3IqK
         o1+ms8opPZwpZYvB/vBWAEaw5YMEy9qFKqujkENwaYwpcoIXik7X8UbTTr9mbB13LGss
         wUrZugOzoDNG1ax59iMjUeiN/U9NEMFgnHQjyIc7ho6AJgO/mIo3r3icej6DU3vvqgq5
         UFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731783538; x=1732388338;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6g1oQXsTrdrctZscRJ3TPVmonDFH95VF7gA1oQnI5y0=;
        b=MtfUjCOHyw352RV+XEpUZNGw6rxgrxjzSehM3vNzz0EW1ffajLwZcg4WdkE0vpO81z
         7ICb153+rs2bEAHdL1XaV6HZWpGrRarVyxUQQ/qluQY+/UgfYAjd/Ap4neD8cGfaHWt2
         n6qN5iBGVQhQQS5suHLPF7NcfgJxqs51qZOVt7VzilysZIkAPleDxGSX/RXylNBRmsVe
         qwfZ31G/Aa2alki6/6CnVPXFDb5raMNySMcWbATk6RhYPEyewRDy0KssMyp+1eFKNGS2
         02+/zvY7kg4T2lDW/lE5MK79PsgekhD2HnLymHUP/kMaMgPSGRta4vvqqIMRzftzd1n+
         bl/A==
X-Forwarded-Encrypted: i=1; AJvYcCVMht1V45Ol/VrPQdOuQolcQxULwZ8/SME/QuPBhLU+rQWzvU5KzVVYXNugyVprrt/ktSyjfUNP98INeoA=@vger.kernel.org, AJvYcCWqPKcEoIeSRWDY7ZwlPjpcs5f1h5l8c7QpMnNTw7lEtQnmQWjxfvx4zc1pvcnJHtQ627OgzEcA2IejIyQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwddyV6awwNSS5FLDRHZlCImSXt5SHBQIcRQXVpL8gzcwHLDGZQ
	ayU9qQhaxxp7MmzL56lz0CAKlFLCVbjp9GkB+7uQNwGGe5tfhzPP
X-Google-Smtp-Source: AGHT+IElM+kP9nrFu84SLcOHQlh9hTYlkbUDN7ol0gu9pT3/Xg0RZomx2OR023i8JDF3mjVyxS2DRQ==
X-Received: by 2002:a17:902:e812:b0:212:77d:3899 with SMTP id d9443c01a7336-212077d3a92mr12550055ad.31.1731783538019;
        Sat, 16 Nov 2024 10:58:58 -0800 (PST)
Received: from RedmiG ([31.162.111.63])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724770eea5csm3357248b3a.2.2024.11.16.10.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 10:58:57 -0800 (PST)
Date: Sat, 16 Nov 2024 21:58:45 +0300
From: Alex Far <anf1980@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	"end.to.start" <end.to.start@mail.ru>, Jiawei Wang <me@jwang.link>,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: amd: yc: fix internal mic on Redmi G 2022
Message-ID: <ZzjrZY3sImcqTtGx@RedmiG>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This laptop model requires an additional detection quirk to enable the 
internal microphone

Signed-off-by: Alex Far <anf1980@gmail.com>
---
 sound/soc/amd/yc/acp6x-mach.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
index 2436e8deb2be..c33ad161b139 100644
--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -409,6 +409,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Xiaomi Book Pro 14 2022"),
 		}
 	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "TIMI"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Redmi G 2022"),
+		}
+	},
 	{
 		.driver_data = &acp6x_card,
 		.matches = {
-- 
2.47.0

