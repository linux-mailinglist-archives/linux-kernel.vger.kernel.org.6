Return-Path: <linux-kernel+bounces-310108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1243F967514
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 07:01:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA86B282BD9
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Sep 2024 05:01:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60019381DF;
	Sun,  1 Sep 2024 05:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oNONLxNa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FF579D2;
	Sun,  1 Sep 2024 05:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725166853; cv=none; b=l6aMaweOlZzLGf8T1nEMVTbUODWA38iE3PyhlShoL7MqTP9+UNjhXC42vbbcdSef1khlvRaYu0ZgllC7Nz66F+QA2L6XIDw11rmgbzUUMwA/h4pJnxRJMqGBbrYk0h+cm5BoWEui80VrcsZjP22x6/UftLnm9TihW6F0/nvZxtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725166853; c=relaxed/simple;
	bh=IW0u8g8AnmCVjSaYQxQmruL3pgkREbbcfNYdjjaJMT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FoWNw/Cub25hsZDFsgpB8q7P4mMGZgwfOvWYOOvI2aYNR9XB0wn+CyB3+X17Qe9Av/tgkYhTDj3JHJKvWk/GIWIVpXo+HHNkXGBfHrl7j0A4Z6c6bRlzFFgW2MuiM7KOHBJzdB8ruW6KXb8kC2OxsHFtMcku/+xtNpGC4p2PZxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oNONLxNa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A2EC4CEC3;
	Sun,  1 Sep 2024 05:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725166853;
	bh=IW0u8g8AnmCVjSaYQxQmruL3pgkREbbcfNYdjjaJMT8=;
	h=From:To:Cc:Subject:Date:From;
	b=oNONLxNafvxPR3djpaWHOGfk2jyoQTGmgsCLGUfDo9xSPEsXoJg70X4OeGfcmKX3G
	 fV1XKrAvDuAaRQeqCmP4y4Z4cpGw/NGIKacw3mu65K8BNskBAzneftp1Khh0NFAan3
	 rxeANOv0RwwNjJfmcgoXsCoPIu5eIDKHe8tm2jQbXMAST4usmftGV5nNMkQL13x9Ro
	 iA5gRa9iWArJ+KPL/tAIz6x4VahCLE9nNW7p8+jP0SvTdUGIQmbzwWwD8cUO6n2Fz1
	 7bQcx9nk2jyZfFxaJtXid17rUyb4Vtq9GDewd4+frGtUnsQYpXb7yXG3WEdAhHyli8
	 7M3U2S19TeWaw==
From: Mario Limonciello <superm1@kernel.org>
To: "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Perry Yuan <perry.yuan@amd.com>
Cc: linux-kernel@vger.kernel.org (open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
	linux-pm@vger.kernel.org (open list:CPU FREQUENCY SCALING FRAMEWORK),
	Mario Limonciello <mario.limonciello@amd.com>
Subject: [PATCH 0/2] amd-pstate: Better handling for systems without an MSR
Date: Sun,  1 Sep 2024 00:00:33 -0500
Message-ID: <20240901050035.1739935-1-superm1@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mario Limonciello <mario.limonciello@amd.com>

Since the policy changed for amd-pstate to enable on systems
with shared memory designs by default too some users have
reported that software like power-profiles-daemon fails
with an error -524.

This happens because error codes from the CPPC API are ignored
during the initial setup so all the sysfs files are created but
don't work.

This series does two things:
1. Add a debugging early param to force going into shared memory mode
   even on a system with a dedicated MSR.  This will aid in debugging
   reported issues.
2. Catch errors in amd_pstate_epp_update_limit() and pass them up. If
   any errors occurred with CPPC API then amd-pstate won't be setup.

Mario Limonciello (2):
  cpufreq/amd-pstate: Add an early param to disable MSR mode
  cpufreq/amd-pstate: Catch failures for amd_pstate_epp_update_limit()

 .../admin-guide/kernel-parameters.txt         |  5 ++-
 Documentation/admin-guide/pm/amd-pstate.rst   |  5 +++
 drivers/cpufreq/amd-pstate.c                  | 43 +++++++++++++------
 3 files changed, 38 insertions(+), 15 deletions(-)

-- 
2.43.0


