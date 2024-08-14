Return-Path: <linux-kernel+bounces-287105-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15B3D9522FC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 21:58:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4F091F224DC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:58:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EAF01BE25F;
	Wed, 14 Aug 2024 19:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Hgmn2X+m"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F96370
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 19:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723665511; cv=none; b=rUFUdFlwvfseei7cu8DeaJc3tKxPwd4z/Bkx+nOjvwTO2GE2tYfou2lm0XwHbNM+VjrXdZk2FxwQeIh8J3t6b5ipK9nZKPuKk46ywSEPisxohT8Pwer9ZpHVmJ8CY93jY9svYzqOyAEYc8FCL81mqxWaQBGOPHhjuHwhIk3ep80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723665511; c=relaxed/simple;
	bh=v6yCN++aTWIn2HL04PVf4IrdFZo3E5raTygn8B9Fh9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HmHo+CufyL3xy6/iJOlIPCO8VY+xYSBLcu6ng2MSR2aXDI6Cp8Gn3uxSqRS90ODmyohZDn3cw9h0Bja2XdQPPE0F12Ne/D18zRmkgI5l26RMWMPHIXg8e1rxFJXdCoEqhtPKmDY2f9Wj3UH3/B0JoggNET8Gr+XL/GfNWjNrq6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Hgmn2X+m; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-3683329f787so126773f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 12:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723665508; x=1724270308; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/4hCGRVnEuxwiy7oU4DBiRNiiuMGKwjKKo5OtTueCic=;
        b=Hgmn2X+mgImXg7PDDf71MjzTpzcRO8nSqKN3eXuP1Jfz0NA8MIzG3wyT4Y302KKNGU
         Yo5/lSjjaCqwMCF27bdvPHheNnh0T0YJsQNlEWfNjxiXY/oKtP2jM6ikFOVjxfCiLqKi
         xjyZY7PnRT6bi3CpRvsrpFs+v4EZGvPqpNA+WmDoo7tUynKnoyn32z+XLZv+2R/MR/dm
         AKrD4jvuFUX5K5PUaQdtM3yI0KCNkkxI04/C3OdqtBIfgE34GU5i/nDYBs7mEjHn6yGf
         w5t9cqjjpEcMuZlBgVzXMvKNUEv+uW19MwnlnfEGv9M/PhdFbiGX5mArzgE+G61bd5rM
         7RBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723665508; x=1724270308;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/4hCGRVnEuxwiy7oU4DBiRNiiuMGKwjKKo5OtTueCic=;
        b=LHT0LyZNqpXeQIVSPOhKpdTkrgJWmvgjs0L2168JD91wkuEUT5AlGsDmL/G1FJ83Cp
         9hfSR80cFxQrzmlSvFnazDyiKIV95x5eaxboNrXAAMcEqoAZq6Xgaz+Tei+7WEQ4Z2Ph
         byPPaP+8VxrCvy2aNYtSWZLjIFVCDOLlAJ9ruJHXVnaTYUWD3ZuqXFtMS6woX+Uz2llT
         NPO0oNip04aO4lgSs39MkRtErhPAV7+IFbnlQjmNkxX8mMXX/Lo/4LEOSfCdmKpAyM7Z
         E9I5BFYz3JNkSg1sMfXVT8yA6IxvehfplqXAKG7C3AnpG7j2ywWix12djY+ZQy5tNVEQ
         b9hg==
X-Forwarded-Encrypted: i=1; AJvYcCVWpCZ4VHgsrnas4Dl+TilCCZYafLyzWF9l3Wf6Yji1ujkuAagB/ogy6Io7A71VDM++hs0/4ecP5CIOw2mfgewsTlsKZdEWM42E77Xt
X-Gm-Message-State: AOJu0YyfHBx3ZgTCjId7NPCez25j5I7Fqn1a0f7YvJLZb5woflOrxoKk
	u7yW7P4iIiJFL9Yzcz0S92k8HxET2+FxgsWrwQWT8J6W0cPaGOlwp/CE0kC2t+1A5WWqAVsWnke
	G
X-Google-Smtp-Source: AGHT+IE3BzsR7UafBAgIAWRDl6haElUv/rAMn14EgEbQx6m7ZWfdFr9PhRc5eYrYxjkWsVukGaOw0w==
X-Received: by 2002:a05:6000:2a7:b0:368:319c:9a77 with SMTP id ffacd0b85a97d-37177783998mr2835327f8f.29.1723665507702;
        Wed, 14 Aug 2024 12:58:27 -0700 (PDT)
Received: from krzk-bin.. ([178.197.215.209])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36e4cfeef76sm13482263f8f.59.2024.08.14.12.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 12:58:27 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Zhang Rui <rui.zhang@intel.com>,
	Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] thermal: of: Fix OF node leak in thermal_of_trips_init() error path
Date: Wed, 14 Aug 2024 21:58:21 +0200
Message-ID: <20240814195823.437597-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Terminating for_each_child_of_node() loop requires dropping OF node
reference, so bailing out after thermal_of_populate_trip() error misses
this.  Solve the OF node reference leak with scoped
for_each_child_of_node_scoped().

Fixes: d0c75fa2c17f ("thermal/of: Initialize trip points separately")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/thermal/thermal_of.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_of.c b/drivers/thermal/thermal_of.c
index aa34b6e82e26..30f8d6e70484 100644
--- a/drivers/thermal/thermal_of.c
+++ b/drivers/thermal/thermal_of.c
@@ -125,7 +125,7 @@ static int thermal_of_populate_trip(struct device_node *np,
 static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *ntrips)
 {
 	struct thermal_trip *tt;
-	struct device_node *trips, *trip;
+	struct device_node *trips;
 	int ret, count;
 
 	trips = of_get_child_by_name(np, "trips");
@@ -150,7 +150,7 @@ static struct thermal_trip *thermal_of_trips_init(struct device_node *np, int *n
 	*ntrips = count;
 
 	count = 0;
-	for_each_child_of_node(trips, trip) {
+	for_each_child_of_node_scoped(trips, trip) {
 		ret = thermal_of_populate_trip(trip, &tt[count++]);
 		if (ret)
 			goto out_kfree;
-- 
2.43.0


