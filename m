Return-Path: <linux-kernel+bounces-178043-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F768C47D0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 21:47:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D03D1C22EB9
	for <lists+linux-kernel@lfdr.de>; Mon, 13 May 2024 19:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CCE7E796;
	Mon, 13 May 2024 19:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SD4eiciR"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A537E765
	for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 19:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715629636; cv=none; b=bW2Ke9mkpFsgeLe0xpVposw+icQM1g6Js+kf8tPCoohnvh5Qp5ORaoT+jVeZ7NqvaZrE6dLjLRn3E9mbAspn6v/jFpHZjIbrnpN9qlqLyrrrlSUE2JUMmdrQ3jgg56WorcayC/6s8uwXtyTUogUOLXj9dra1foCLqgmRQXfesGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715629636; c=relaxed/simple;
	bh=abzpbAIsGffQZOkQa0awGau3E+v6Yze3gFJC/Iqx9l0=;
	h=Date:Message-ID:From:To:Cc:Subject; b=NnbzIAJ8Etq8Ulc71P6X1XXH0vM97G6hSMwJy0IKAOFodZTktzjfzA+SC00DTYdcreTuX6IHNi1CLfqOA8TwzXUMDSD/oFtXKCbKhy/SYO0M0poPJiq8XUovCW0++TKDUrBn5t6wiz9zWNY5Rf4Goa3OqS9k+FSayUf1KAGQ9gM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SD4eiciR; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43df44ef3e3so19372181cf.2
        for <linux-kernel@vger.kernel.org>; Mon, 13 May 2024 12:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1715629633; x=1716234433; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NPAXonk62bozSvr0eSu1klLU+I6EFV7iB0W5dHC6XiI=;
        b=SD4eiciR7hVomzdJwU+AJgkWpMZYYwRYeDrME1P3huKBTwfOgSTJ3wnCmLPw7RC30h
         zZ32DCWSqHXTIo6+720HNd5Jeo0UxroXEQY/vCyaiubOFRr1GFf7KeQvJsp1eU/tKYJV
         T4fIt6OPUWJg3WOKc5ppVpRGirkURu2l7fTr3y5N+udKk9qLtIUcFoGRIfh97GOgSQXK
         UM5O07e/imgSb0/PvM0foIxHTwVoDx9e5xG8q1R16bwucposikElKPi4ds2fgOnWjD60
         t5ME1RBQeHxeD8+kRRw3WAoJDmbWmkL2bEGS+aWOBCKjjX/bC6CPJCnPjKx6ke+xUOku
         KgwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715629633; x=1716234433;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NPAXonk62bozSvr0eSu1klLU+I6EFV7iB0W5dHC6XiI=;
        b=vWajuprbBDO5FHN2x8WxwpW2ekvmTLytUsj6TXrqD8hwf3k7c3LKTH86tMA8fxq/im
         5gwB+xXPtkiJ4y6XT9zait4ELA7q+ejS95NL1OLZNErUvtEMOwdoJFRn9Vhp52GQE4nF
         Qcmuxzpau65bLsZkh8HW9995xnxaR4OwuWP5WHO42rziFb9ULw5WkKZRj2co3spceZsK
         g/N+ToNtGBR30Ui1pUVRrggHoSVweEC4zU8+HusY+NGJ8tQ5Vz78iU4FKvaauHd5GLej
         qJGpX1HlNRC/Rm0RgOh5c4n3appe43V4NNTBIKay2WShxUV/t/uaOT2kOux3KDuR0QdD
         564g==
X-Forwarded-Encrypted: i=1; AJvYcCUHw/6/AqHBHmkZSi89WjZYvIFt01xeuj2AfrRUDN8rSTprDzroyOySKESSX3pPENCyn7EVGrrRc3+kR6PxjT51dMIK0ngvA5Ecgp6r
X-Gm-Message-State: AOJu0YyNM6XBWhEaxd9eXd0TId9wAKcWViLrGZB5fMbpxByuKs3EAw1Q
	c8QLhA0N8slrc7jkvX12cgOsJ0HtflqyzxYX7HRfz+UKELZb6JAUIFAqLzJ8kluUo6mqTMAesX0
	=
X-Google-Smtp-Source: AGHT+IE45Lj4C6YXKvuuRhlkZ3gkoUCzPlmS1mjfW7AJ5KkG7So4V6WMEY+Smut2GJdr40+/DM86QA==
X-Received: by 2002:a05:622a:64f:b0:43a:a965:b0f3 with SMTP id d75a77b69052e-43dfdb4915dmr128250611cf.49.1715629633462;
        Mon, 13 May 2024 12:47:13 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-43df54b58c0sm59974371cf.9.2024.05.13.12.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 12:47:13 -0700 (PDT)
Date: Mon, 13 May 2024 15:47:12 -0400
Message-ID: <eb9e94532b792619e4161de6c0a397db@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] lsm/lsm-pr-20240513
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Linus,

Three fairly minor patches for the current merge window; highlights
below:

- The security/* portion of the effort to remove the empty sentinel
  elements at the end of the ctl_table arrays.

- Update the file list associated with the LSM / "SECURITY SUBSYSTEM"
  entry in the MAINTAINERS file (and then fix a typo in then update).

Please merge for Linux v6.10.
-Paul

--
The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/lsm.git
    tags/lsm-pr-20240513

for you to fetch changes up to dd80c7465029dd0671e6f9fc2678ae0fbdf785ac:

  MAINTAINERS: repair file entry in SECURITY SUBSYSTEM
    (2024-05-07 10:56:15 -0400)

----------------------------------------------------------------
lsm/stable-6.10 PR 20240513

----------------------------------------------------------------
Joel Granados (1):
      lsm: remove the now superfluous sentinel element from ctl_table array

Lukas Bulwahn (1):
      MAINTAINERS: repair file entry in SECURITY SUBSYSTEM

Paul Moore (1):
      MAINTAINERS: update the LSM file list

 MAINTAINERS                | 4 ++++
 security/apparmor/lsm.c    | 1 -
 security/keys/sysctl.c     | 1 -
 security/loadpin/loadpin.c | 1 -
 security/yama/yama_lsm.c   | 1 -
 5 files changed, 4 insertions(+), 4 deletions(-)

--
paul-moore.com

