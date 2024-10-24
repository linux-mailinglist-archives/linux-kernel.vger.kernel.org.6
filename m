Return-Path: <linux-kernel+bounces-379237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B849ADBD8
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 08:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 958291C216D2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Oct 2024 06:14:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55FFA18871F;
	Thu, 24 Oct 2024 06:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qNEVLB5w"
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB803188717
	for <linux-kernel@vger.kernel.org>; Thu, 24 Oct 2024 06:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729750448; cv=none; b=Sy60xPerye3BolQsEgDE9qYwtjwSEEr+BFRXnIamTto2fd6bOWAFGkDP4ko7QpWaI0CHv4ozFNZ88vXdgIVi1DXyodw9s1NdX3o10jA5uYyK/PuLQtaGHqNFEKJC+CbjQWMYbeFSVxM1wa8XDaAJjF0mT6QzG4Dm519MYogKBZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729750448; c=relaxed/simple;
	bh=zDXiwnNbOAqIIc1NRxGfQ1iF2PdUDrS7EJdjH4bGXdI=;
	h=Date:In-Reply-To:Message-Id:Mime-Version:References:Subject:From:
	 To:Cc:Content-Type; b=km63DEXbj9J38/b036lmAKnvx0cy6a5aiHRnptOgn42YdvMKWbiUi5ZouAFopbeGnGxP2S/LpS1EKPkEeyYWQKMrznf7rfGrEQLH/aP1GffpPzeXPBT44I5L8loR+LFAjp66ngb6R7C9UejkOZHJolqHMn/gPLxvwmYe/dpbe1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qNEVLB5w; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6e3d6713619so8355387b3.2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2024 23:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729750446; x=1730355246; darn=vger.kernel.org;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RirtA7EgN4fQOOKugcSYCvUnz6k6FXA4tnIv667SP2U=;
        b=qNEVLB5wZAWqkQZOWbj/Bsr8QbqAdt9Bl0pjOuCJDLT2e8y5c9qH2MhHxRb4VNpIlV
         KUComeNF9rKthKH4gBKx44hhF9jmGI5ELiKu5rGsCYEubKqdJwSvAVR2FodktfEts0GA
         mnBKO6vhkxWsy6MI1Hs8M8eA4RXWL4KYEjw62phwE9Z2Je1IWtQmjmhO/0kGRpNTn2bt
         oghgvA7Qv3qeiqIyk7XllXn29z2AeW6K/5ik2PhqPU8Nltk1zGyji9QwbxvMkG7hhFsK
         q1ARqz3AMtoaouUWaGautpsveoGOXGu67WRBr1klrng+K6XtL/7T1xXx+ieHZfXH1Z3u
         Vedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729750446; x=1730355246;
        h=cc:to:from:subject:references:mime-version:message-id:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RirtA7EgN4fQOOKugcSYCvUnz6k6FXA4tnIv667SP2U=;
        b=FJ4yLViu95qGuJscyfYAvRtpC2lHlIqyY/j0yUbCUbQvRHF+KdXWgdVNia+/IrNtQY
         pHLUNAR5PD/rsvH5L074o63sj6nGMnvJKBiXs/b4av9v/zOLBVsM7daD342FOZBQptmN
         BF6DmrMihBej6TvLX5Q4s0ELIjyfj6UMG8JdWxgSAoMeJvT1y36TgYWWguCc/mPwHxe6
         /sJ8HMU/8opzIRkNfTW9tcLXvVT14eDBn5j2eLzVZNyMnehXhxzwZ1CfGJXOne3E48yl
         D+6WTo7OxM6aF5Nbr61EUgY8hQS3zYveM69GOFm9IJgQ+XCKDClWEbNWKLpzuDvX78+d
         T69A==
X-Forwarded-Encrypted: i=1; AJvYcCXfaSgQDHFy6mqphGQAw8EkaGVrn+yE4CG48M8AkHp2Uyuh9ZkFQaD5YqYf5GN8W4hBWlkOf8GZ+YTQNiY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxDOmZFs++yuPmnYZb1qN34UJWJtLpqRispsSG5OCG2WnvwoQA
	q0+8ozXua/3NDS/fgn2RjNDpOePUdznggTxUAa94timUnY4Acf02xLkXSPoLt2imacDSzr4EPdL
	LDNFIJ666YOkSGA==
X-Google-Smtp-Source: AGHT+IEJXaAAeZpuDAkTsefFXLL2kex4B2AlfwjdclQcvPn636A6m5nX8BurNhgR4ykV7U+QaaWd5sb2nHuey3k=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:965e:f81d:c9fb:b352])
 (user=saravanak job=sendgmr) by 2002:a05:690c:3749:b0:6e2:4b3:ee22 with SMTP
 id 00721157ae682-6e866359b6fmr171667b3.6.1729750445961; Wed, 23 Oct 2024
 23:14:05 -0700 (PDT)
Date: Wed, 23 Oct 2024 23:13:44 -0700
In-Reply-To: <20241024061347.1771063-1-saravanak@google.com>
Message-Id: <20241024061347.1771063-4-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241024061347.1771063-1-saravanak@google.com>
X-Mailer: git-send-email 2.47.0.105.g07ac214952-goog
Subject: [PATCH 3/3] drivers: core: fw_devlink: Make the error message a bit
 more useful
From: Saravana Kannan <saravanak@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	JC Kuo <jckuo@nvidia.com>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Thierry Reding <thierry.reding@gmail.com>, 
	Jonathan Hunter <jonathanh@nvidia.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Saravana Kannan <saravanak@google.com>, 
	"=?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?=" <nfraprado@collabora.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

It would make it easier to debugs issues similar to the ones
reported[1][2] recently where some devices didn't have the fwnode set.

[1] - https://lore.kernel.org/all/7b995947-4540-4b17-872e-e107adca4598@notapiano/
[2] - https://lore.kernel.org/all/20240910130019.35081-1-jonathanh@nvidia.com/

Signed-off-by: Saravana Kannan <saravanak@google.com>
---
 drivers/base/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index a4c853411a6b..3b13fed1c3e3 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2181,8 +2181,8 @@ static int fw_devlink_create_devlink(struct device *con,
 		}
 
 		if (con != sup_dev && !device_link_add(con, sup_dev, flags)) {
-			dev_err(con, "Failed to create device link (0x%x) with %s\n",
-				flags, dev_name(sup_dev));
+			dev_err(con, "Failed to create device link (0x%x) with supplier %s for %pfwf\n",
+				flags, dev_name(sup_dev), link->consumer);
 			ret = -EINVAL;
 		}
 
-- 
2.47.0.105.g07ac214952-goog


