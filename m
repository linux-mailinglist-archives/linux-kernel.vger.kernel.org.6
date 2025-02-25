Return-Path: <linux-kernel+bounces-531611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A6CA442AE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 15:28:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6ABEA3B4FB2
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Feb 2025 14:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A13A26B0AD;
	Tue, 25 Feb 2025 14:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="terzUy0u"
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375182698A8;
	Tue, 25 Feb 2025 14:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740493569; cv=none; b=az5v+OyGL31Co7ngi0eQKuwmoVlX114r7z1AF3CaLYcSEkeQE4CQFviOnhRhuPgmP8FJQ1ViUBPpNRS5OwSt2TrRs9WQ4KrHpS1vknQnTQ1jS/eTNGibIzowLxTr6GP5BVRiXMGamncXInDRel3Wx2wqLyB2+T1qF9Fu/1NQGVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740493569; c=relaxed/simple;
	bh=jpEqmQ45wBRCVC0jxGc+LOlCURwWWVUWO5MCp8cspTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BFrxg4VAXGOzgiobKobycA8iPMLqNXZp96gyPTxQON0EcR7/tgBZ5iD8w9s9DLxqf/yyZ0vvHXSkA+3puv+BW3kBwUws9VAe2bHnzU/VcwHcC6X1R3Nh4QmWb7LzGYSuiXKRGLABYb16auYvtUuTdC73e0qmRleoxItax8qoHGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=terzUy0u; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from localhost.localdomain (unknown [IPv6:2a05:f6c2:511b:0:8d8a:5967:d692:ea4e])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id 8A6372E08B57;
	Tue, 25 Feb 2025 16:25:59 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740493560;
	bh=jpEqmQ45wBRCVC0jxGc+LOlCURwWWVUWO5MCp8cspTs=; h=From:To:Subject;
	b=terzUy0utYQeZbKu94hIf8N7x1dL0dIxBLhFvqoOD1qLJRuaCooqJ1pd6vihfgwdq
	 5uWQLr3+c0DY9nNA2su6xb/2cVbqjQFGXbEVdl75aYWXlofeR7YrfxzWDg1vCrH/6H
	 y9zfsCHz8h/ilVia6S/B2iXIKzTep1N7MrZrW0hc=
Authentication-Results: linux1587.grserver.gr;
	spf=pass (sender IP is 2a05:f6c2:511b:0:8d8a:5967:d692:ea4e) smtp.mailfrom=lkml@antheas.dev smtp.helo=localhost.localdomain
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
From: Antheas Kapenekakis <lkml@antheas.dev>
To: luke@ljones.dev,
	mario.limonciello@amd.com
Cc: corentin.chary@gmail.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	Antheas Kapenekakis <lkml@antheas.dev>
Subject: RE: [PATCH] platform/x86: asus-wmi: change quiet to low-power
Date: Tue, 25 Feb 2025 15:25:55 +0100
Message-ID: <20250225142555.14005-1-lkml@antheas.dev>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224223551.16918-1-luke@ljones.dev>
References: <20250224223551.16918-1-luke@ljones.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: 
 <174049356048.12946.16381279399138541255@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

Hi Luke,
please add appropriate attribution.

Closes: https://lore.kernel.org/all/20250224195059.10185-1-lkml@antheas.dev/
Reported-by: Antheas Kapenekakis <lkml@antheas.dev>

For me, this patch series plus the multi-platform profile one constitute
a double ABI break. Not only does the legacy sysfs for platform profile
regress when there is a second profile handler for a device, but all
hardcoded scripts for Asus devices will have to be updated.

While I would personally like to avoid this, I am ok with it, given
appropriate attribution, since I did go through the effort of reporting it
and providing a mitigation.

@Mario: you added Reviewed-by to a patch without proper attribution. Let's
not rehash our discussion from few days ago. Please try to do better when
it comes to attributions in the future.

Antheas

