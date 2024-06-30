Return-Path: <linux-kernel+bounces-235127-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EE43D91D07F
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 10:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E4F31F2152B
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jun 2024 08:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4C441C73;
	Sun, 30 Jun 2024 08:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="OiNgCUp4"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C7239FD8
	for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 08:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719735451; cv=none; b=QY7JdNzFgQ4YJJYjMEmLGh8bt8RoSAnD/IuF+JdxG9m7U/AgiBiu+Z0lsx3msQ8YrgQq3nC6MA6wPZkUOO+C1nhBwkxaNViEJ4FnrVdCnvs96c1R3OIagR7aJ56OIFBDrIWOk8Vv6oGB2v1KPXAlwaPifZGn0Y1yWcoxb/MF7Vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719735451; c=relaxed/simple;
	bh=hwgBuZgzFbjbsiDTCBSXM1LK7u5i2lMfzSZ5VG2Zqlk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RtAEIeoZfQCSsGHBRnTZzhwVqh2fjL4trrkohQUGNZhx+xdaxJh9hN2hM9hAbFZmtyL42IG1695eGPdqxhLoWesPr9uuIriEVh0O0DuKP+YXOehELbyLup40AYvIB9iMiEUJpIgD1nb1fmdGk75ZBl8GlRs2eNY5275VHKXs5jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=OiNgCUp4; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id ED20140E021B;
	Sun, 30 Jun 2024 08:17:19 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id ECHYfZcslXlp; Sun, 30 Jun 2024 08:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1719735437; bh=cAupij/Vy3zFzRBF041kyQkQgMt5j+qQsGS6DKFRfiM=;
	h=Date:From:To:Cc:Subject:From;
	b=OiNgCUp4YhKxYHHr+dMxk0BIJtT3s5hPhGRtIUv+X1TXWG5xPiTYoA6ko1vbo/7wE
	 0BdB4DGsx2RIBZ0iubZr4Dr6l8/O7NzPiWBJihkUOMGgxbRJCn+vSRaGsuLea53kBb
	 4+SOzf4eSO/2AkjBISmxq0AlaWhXKBWX6clNxq+TEXHcIphIHRBpRa6vFXQR1NWaHe
	 uIKSVqm31un5unHSbQyy2DQxJZ9l+li23CElR6I5PWUznlbFhRVyuxyR5245ofL4ig
	 U/IPhMemA++EN6JOqg6PQ6HGvE54pYnfQ9Xx2rD7tLJetsk/8/MUxHenu9h68X2bmn
	 KpVkPgnqlRVu5ptfdtoco8AYmbgWSslkETgS/uiDe0HMNcfNlHLp9+u2YJ7sPgsQcj
	 j+GBKK1uQCVwRLkVta+PhkcDCRTHJ5l2ZrQ/jOcSLBqixwQ5qZBL0+5WU3iiSIAHPV
	 mQ/7X054ddl22R3APr5G5anjDIVhA88KaMpg1ssldLrmmyIJ8dxC/RM7MuGzbY2d6z
	 Br2PnjsBjhav64Napo1zFmk0f9k95EKLWQey6OZANSOLN32sbJxBY61mzYu3X5aIHH
	 LVZdqk//NtUlcC+pFbn+I//dnrnUzjrYGlS9obwzlA57cFhoSQj4J9bMWxWluhgRj0
	 bsj//sPgWiaV0qDLgv1jDLvk=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id E09A340E0192;
	Sun, 30 Jun 2024 08:17:13 +0000 (UTC)
Date: Sun, 30 Jun 2024 10:17:06 +0200
From: Borislav Petkov <bp@alien8.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] timers/urgent for v6.10-rc6
Message-ID: <20240630081706.GAZoEUguWzfEsXgB3n@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi Linus,

please pull a siggle timers fix for v6.10-rc6.

Thx.

---

The following changes since commit 6ba59ff4227927d3a8530fc2973b80e94b54d58f:

  Linux 6.10-rc4 (2024-06-16 13:40:16 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip tags/timers_urgent_for_v6.10_rc6

for you to fetch changes up to 5a830bbce3af16833fe0092dec47b6dd30279825:

  hrtimer: Prevent queuing of hrtimer without a function callback (2024-06-25 16:54:27 +0200)

----------------------------------------------------------------
- Warn when an hrtimer doesn't get a callback supplied

----------------------------------------------------------------
Phil Chang (1):
      hrtimer: Prevent queuing of hrtimer without a function callback

 kernel/time/hrtimer.c | 2 ++
 1 file changed, 2 insertions(+)


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

