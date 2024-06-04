Return-Path: <linux-kernel+bounces-200186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B48F8FAC88
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 09:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55D12282F90
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jun 2024 07:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 524581420D1;
	Tue,  4 Jun 2024 07:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o4zwSauH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 937531411F6
	for <linux-kernel@vger.kernel.org>; Tue,  4 Jun 2024 07:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717487555; cv=none; b=VtkRZaTSoW2ye0DilqGcUcyVMMxTTujoGgUt0AXC6er8PY/Z17buCNsI32l+fsNR7oAYPEZMdP1hGmvZEZ+H5x30cO/J7YzyA4axWyyo5t0wwBqVC4qqMgUPX6czqooNPV5c8hAAJh6kyuYMGYsX3i6bHiy+KY9PTI9oH+Mo1Dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717487555; c=relaxed/simple;
	bh=/fiIiiYbJFRNvZ7FP9BHekn9qQAHxsiruF9zvi9/kK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cw4pS3AgeJHB8ssHxTHXgvKIVz58gALXWhD+1zh2UzNQXs7DCknwEscCcT1VzPHLIOPoSJnthbog/EsLTKo2f18Cnx/4SkJiTKa1T3C9zCnjJVjG5Icxye2jzOM/fUEZ0jqrpFv/FV2OQSRO7WjtbjmzFuvXNKCT34VHgVty45A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o4zwSauH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F1D8C4AF09;
	Tue,  4 Jun 2024 07:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717487555;
	bh=/fiIiiYbJFRNvZ7FP9BHekn9qQAHxsiruF9zvi9/kK4=;
	h=From:To:Cc:Subject:Date:From;
	b=o4zwSauH9GbTo/xlsMQYytCJC5Rl+06wVlBsyC6ATPqM9sWzsAvra6bqIlJu46xBK
	 +j2Eq/qhdq6EPCG8KKWClJJQ40P6cTtM/8HO4ZMvBNgP+T/fKlX/tmI8lgu0TLIoE2
	 PZp2n6Jtd1ZxIsz/wGJPrO5vtbAVx9oBuKLShSxzuvl2Ncn928Ylkg6UacMpS6Uisl
	 fwK+MVggsjjD+zyyjPXnUZD5Qw9sNLbxa4mh5R0n3B0x1bIRvZHL6cq8Bc6zbwmZGJ
	 Ig2ZGs7QLPskYIKugr9jkU+AVOYwDyYlbddjt6dL/XW41A7d1ZfxyjmI+x9i0/lfJY
	 XHdtLqJB3Bwtg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan+linaro@kernel.org>)
	id 1sEOy8-000000005QL-3SGj;
	Tue, 04 Jun 2024 09:52:33 +0200
From: Johan Hovold <johan+linaro@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH v2 0/4] soundwire: bus: suppress probe deferral errors
Date: Tue,  4 Jun 2024 09:52:09 +0200
Message-ID: <20240604075213.20815-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.44.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The soundwire bus code is incorrectly logging probe deferrals as errors.

This series addresses that, cleans up the soundwire bus logging and
drops the unused soudwire driver name field.

Johan


Changes in v2
 - drop probe error message completely
 - drop soundwire driver name field
 - cleanup probe warning messages
 - drop probe debug message


Johan Hovold (4):
  soundwire: bus: suppress probe deferral errors
  soundwire: bus: drop unused driver name field
  soundwire: bus: clean up probe warnings
  soundwire: bus: drop redundant probe debug message

 drivers/soundwire/bus_type.c  | 21 ++++-----------------
 include/linux/soundwire/sdw.h |  2 --
 2 files changed, 4 insertions(+), 19 deletions(-)

-- 
2.44.1


