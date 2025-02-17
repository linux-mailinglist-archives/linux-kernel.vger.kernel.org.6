Return-Path: <linux-kernel+bounces-517010-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F1B5A37AF6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 06:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23EE93A928F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Feb 2025 05:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E38C18787F;
	Mon, 17 Feb 2025 05:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="U+eItVWL"
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6E4137750
	for <linux-kernel@vger.kernel.org>; Mon, 17 Feb 2025 05:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739770668; cv=none; b=sSN8JchkCkpcQtoQAj06Lyvmzof8cPLjZZCk6v+bUKwlPgLYOuhMObg3UKmejMLKMnSIuTpWJsthEccda4T9UdXbMJioDzJLPF57UbAlRIYW9JPbST/UWsva98hRG6aDL4Tesv+cyvvttZrMpTZu1+bXy77Oqmbt55ZE2Wu5Z3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739770668; c=relaxed/simple;
	bh=C+lXutHoUJOEM2UwycToDgt8SFL77v+z6PrK5qLhE+Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pH5htkhYU1ZN8oVvh56SK1dqYN1cLD9EmHSMTqgNSIFYVFub8/voj4wRSVk8dyzuyyRc+RmcZhKXJZkG0fBezA945gnMWiMYjx87gNJ30QGFH5WBuhvTAlMeKhgEFW3WwAimanCBQU7qWvI6eW8u1+CjfTTFDrrrM17TvRjUf5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=U+eItVWL; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1739770658;
	bh=C+lXutHoUJOEM2UwycToDgt8SFL77v+z6PrK5qLhE+Y=;
	h=From:To:Cc:Subject:Date:From;
	b=U+eItVWL+xqAGl88T9GzqSxXC0gqMLP74yXQalTui+meCI9IfIEWw9Be6dlCB3Vym
	 w8lXlBFZJmJa6F1sQNtDZibTn/2pwU5X63GJGaf49gl15e7lVxCjg6QH/NihgqBkC3
	 K06QlFYWA1lZh4Om0BEykkcHOvFKKBnu1Ed7l0SHbHmiZqsPwxEEy/kzdT7biEQwUa
	 UkoEuoLwZqKQUR0rZjgpm6P092JQMuviJmx6xbNJamwUHl0tbajoT0pWdtfe8hH5Rs
	 hY/YpvmvGW+neaqOxg1nZD68ncSb6r3YYbjrxuPoA1gzJLamREJoCasemRNWzfKmU5
	 3VLFVxMAeFqWg==
Received: from localhost.localdomain (unknown [171.76.83.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: vignesh)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 2B49D17E0B59;
	Mon, 17 Feb 2025 06:37:32 +0100 (CET)
From: Vignesh Raman <vignesh.raman@collabora.com>
To: dri-devel@lists.freedesktop.org
Cc: daniels@collabora.com,
	helen.fornazier@gmail.com,
	airlied@gmail.com,
	simona.vetter@ffwll.ch,
	robdclark@gmail.com,
	guilherme.gallo@collabora.com,
	sergi.blanch.torne@collabora.com,
	valentine.burley@collabora.com,
	jani.nikula@linux.intel.com,
	dmitry.baryshkov@linaro.org,
	mripard@kernel.org,
	boqun.feng@gmail.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/3] drm/ci: enable lockdep detection
Date: Mon, 17 Feb 2025 11:07:09 +0530
Message-ID: <20250217053719.442644-1-vignesh.raman@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series enables lockdep detection in drm-ci. Any lockdep
failures will be shown as warnings in the pipeline. This series
also enables CONFIG_DEBUG_WW_MUTEX_SLOWPATH for mutex slowpath
debugging and refactors software-driver stage jobs.

Test run with this series,
https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1366054

Link to v1:
https://lore.kernel.org/all/20240812112030.81774-1-vignesh.raman@collabora.com/

Link to v2:
https://lore.kernel.org/all/20250211152812.54018-1-vignesh.raman@collabora.com/

Vignesh Raman (3):
  drm/ci: refactor software-driver stage jobs
  drm/ci: enable CONFIG_DEBUG_WW_MUTEX_SLOWPATH
  drm/ci: enable lockdep detection

 Documentation/gpu/automated_testing.rst |  4 ++
 drivers/gpu/drm/ci/build.yml            |  6 +-
 drivers/gpu/drm/ci/igt_runner.sh        | 11 ++++
 drivers/gpu/drm/ci/test.yml             | 76 ++++++++++++-------------
 4 files changed, 56 insertions(+), 41 deletions(-)

-- 
2.43.0


