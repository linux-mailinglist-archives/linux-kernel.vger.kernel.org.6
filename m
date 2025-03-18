Return-Path: <linux-kernel+bounces-565413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F292A667B0
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 04:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3600A3BFC75
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 03:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02EC61E51FC;
	Tue, 18 Mar 2025 03:42:24 +0000 (UTC)
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E51E1DFDBB
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 03:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742269343; cv=none; b=ksXP6Zq88hNWPTzn4Cz/C3WZ0nreWnISow/r+qo+Lutk2Ftad4amUIT872c/nwTPahSX58fl3uc1vzWHzUBnZubiEa9Cig77Sxz+1klnZXVvkWPpRb7m25BkmgdxUS6rCdoL13x9JH1DpVxu5splJ7NdWh0waMiusyQlQTdPWbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742269343; c=relaxed/simple;
	bh=tumDvsyfWFIBykuD4/sYFt98TuHT5on99AMjhaWS534=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NcUOX5W7gunRO75QyqUWVuQOgWJByi4SEEGUjbqrvJN1Pj81agmSCkHDEsK/BBSJTvJlSnsB6EyPMBFMzn2oVl58UEqlLxn26A9gWlGEF5B7TkVuOVZP8Ts8NttalPPWbJ6y5eH3wn3fSxkZA8dyQ9d25/WJsJbgv1gdP58aY9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-111-34.bstnma.fios.verizon.net [173.48.111.34])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 52I3fjNe012112
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Mar 2025 23:41:46 -0400
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id CB0CE2E010C; Mon, 17 Mar 2025 23:41:45 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgoettsche@seltendoof.de>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
        =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Serge Hallyn <serge@hallyn.com>, Jan Kara <jack@suse.com>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, cocci@inria.fr
Subject: Re: [PATCH v2 01/11] coccinelle: Add script to reorder capable() calls
Date: Mon, 17 Mar 2025 23:41:14 -0400
Message-ID: <174226639139.1025346.1787648992312533082.b4-ty@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250302160657.127253-11-cgoettsche@seltendoof.de>
References: <20250302160657.127253-1-cgoettsche@seltendoof.de> <20250302160657.127253-11-cgoettsche@seltendoof.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Sun, 02 Mar 2025 17:06:48 +0100, Christian Göttsche wrote:
> capable() calls refer to enabled LSMs whether to permit or deny the
> request.  This is relevant in connection with SELinux, where a
> capability check results in a policy decision and by default a denial
> message on insufficient permission is issued.
> It can lead to three undesired cases:
>   1. A denial message is generated, even in case the operation was an
>      unprivileged one and thus the syscall succeeded, creating noise.
>   2. To avoid the noise from 1. the policy writer adds a rule to ignore
>      those denial messages, hiding future syscalls, where the task
>      performs an actual privileged operation, leading to hidden limited
>      functionality of that task.
>   3. To avoid the noise from 1. the policy writer adds a rule to permit
>      the task the requested capability, while it does not need it,
>      violating the principle of least privilege.
> 
> [...]

Applied, thanks!

[03/11] ext4: reorder capability check last
        commit: 26f5784d44c3f824c864245b506db809b51053cf

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>

