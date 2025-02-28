Return-Path: <linux-kernel+bounces-537992-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D2EA49351
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 09:21:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 283293B5A3B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 08:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E921244EA1;
	Fri, 28 Feb 2025 08:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jeU5cj7S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E15F924292A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 08:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740730845; cv=none; b=jCy+tREUIggXbNl91YEVQMymlvA9hrAbo7UrQjOGoQwzv7rfaasrJtkxvXpuHiY8Q3bJkXEU69w5eaRQfljyjY8NWOzmQdiTWM0m3eZHtSEQEs77SYO9W6qmbaeZvoAVuMXYcMiwrLxL+ofzyXNdo19HCeotIX9S/erna9/3TG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740730845; c=relaxed/simple;
	bh=Hh6xAuD3HXXAX7xVHgeSLNoZ820BDLmImelYuFIHamc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=njxBcJ7h6xLy6LcC/SHHsL/TIZHinAL93QFNN4aaVlAvzJLuS0iWwWIseArefOB+MMJilgOYHwi4p3skjAOew6nIJGZZjkGZ9/4cNxtolf9OZG3YCpv5DVdgp0vJn4nw+g+eZZrKH9+pVpLvcIYqqhUNER1DITkwes6dh1JME7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jeU5cj7S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59394C4CED6;
	Fri, 28 Feb 2025 08:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740730844;
	bh=Hh6xAuD3HXXAX7xVHgeSLNoZ820BDLmImelYuFIHamc=;
	h=From:To:Cc:Subject:Date:From;
	b=jeU5cj7SvHEomQXTyTZfgDIc3J/9qALS6mkywPEvgStfFYzyV7/7hu3lmKtQtLuI9
	 gG2omLRMU4XKSo8zhkZXseDaoVK8jFFrNHDrIpDqDsbXsRVz2aqjrRUHCq2D7foWvq
	 0sratA8YQPu2hdazJzhUanUP8Wa/jRdB6rqH+y1UqqrE+b5/6oqxafK8yBW4WWZWjU
	 c1qQSzdFSWO7XQyHlCm96onGtt+UGoXVzNKrpDV0O1SzmMaQ1bEY6k0hycWggRRi+U
	 MTY1DlG0YRFETfyv7ko1R/rc2NH4HYNiy9YV0u/ETUYmsOYWY//FYhyS3RyNrBpdxO
	 lDHZarQHi4lxQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1tnvcA-000000001G7-2I9n;
	Fri, 28 Feb 2025 09:20:58 +0100
From: Johan Hovold <johan+linaro@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "Rafael J . Wysocki " <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH] component: do not try to unbind unbound components
Date: Fri, 28 Feb 2025 09:18:24 +0100
Message-ID: <20250228081824.4640-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.45.3
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Error handling is apparently hard and driver authors often get it wrong.

Continue to warn but do not try to unbind components that have never
been bound in order to avoid crashing systems where such a buggy
teardown path is hit.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---

I've been sitting on this one for too long now after I ran into such an
issue while fixing up the MDM DRM driver which triggered all sorts
problems on probe deferral.

Here's a recent example of where a return here would have a avoided a
double free:

	https://lore.kernel.org/lkml/6089322f3d5f2e56f4d7a5899d70da2bc45978f7.1702509741.git.soyer@irl.hu/

Arguably, crashing the system is more noticeable, but not very nice for
users.

Johan


 drivers/base/component.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index 741497324d78..3faa92d26be3 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -572,7 +572,8 @@ EXPORT_SYMBOL_GPL(component_master_del);
 static void component_unbind(struct component *component,
 	struct aggregate_device *adev, void *data)
 {
-	WARN_ON(!component->bound);
+	if (WARN_ON(!component->bound))
+		return;
 
 	if (component->ops && component->ops->unbind)
 		component->ops->unbind(component->dev, adev->parent, data);
-- 
2.45.3


