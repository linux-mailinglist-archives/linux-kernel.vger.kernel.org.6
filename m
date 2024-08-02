Return-Path: <linux-kernel+bounces-271952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B8E0945560
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 02:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3AC1C22E5F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 00:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7743EB67E;
	Fri,  2 Aug 2024 00:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOKDBPbs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7D0613D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 00:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722558249; cv=none; b=lxn8u59tcCJIy3vRexGt2jnxlj2iuwqx7KG0YfAmtYyd0icAY9yBoJmTI+yV/UbrwSQHrNmI5AlQwHzTNTl168if0Mc64bGvjOzOX+MtC9Nyzses2QS6TsVkBbNH+aHpEPVQEB1NUy9zpsAuARQic5SFYX2V4YSyastgG3saSaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722558249; c=relaxed/simple;
	bh=AjCf1KXkkPd4ABobP6wS+1vBfPsA4jWkEK2KCfnG80g=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BDupiNQM4jGBoPUGUM/1QY9xo28teXtlDYoNo0uFPYIrpSkVv4cTXtPb6CupQVcmfJote+riV3rnIBJl06/tnuqwyXqdsTS4iI2E7xPS4hW5FEYsaFgTPjgICvVn66mJyI59IJnw+C4vfh2L7OkPmyePN6TtGV+PWAAq89Y/My8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOKDBPbs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 930DFC32786;
	Fri,  2 Aug 2024 00:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722558249;
	bh=AjCf1KXkkPd4ABobP6wS+1vBfPsA4jWkEK2KCfnG80g=;
	h=Date:From:To:Cc:Subject:Reply-To:From;
	b=YOKDBPbscDRlmZeQkfaBPJ8NHgocnEtdIlgLEgi4wxzTbV0jlWiz+F414RhQHvnC1
	 BeVtGAphfbwYmEl7I7eF5LM+6G23gOucmn7ha3OoZL1FbviVhCnuNud9gi/dAqixaq
	 7Ch00wgXATXsQu+yUXiyM2iFksFmkzoZF5ihqe2vbOi8WjNMxL+r5aKotlNA6IEX9Q
	 7FCtk/6p2wM9vOqkt8ix4GM9azGHCmXuTvkCHn1Y5hlThSQMWBKHqMKY5qb8nJ71V/
	 MisOiOVPyrS1doWoNiP4yrp/HRkyag5kw3TMp4IsDSSGTGFX8OrfrvvZcEgunOBS25
	 vywJkXvukUirQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3A90ACE09F8; Thu,  1 Aug 2024 17:24:09 -0700 (PDT)
Date: Thu, 1 Aug 2024 17:24:09 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	kernel-team@meta.com, mingo@kernel.org
Cc: elver@google.com, andreyknvl@google.com, glider@google.com,
	dvyukov@google.com, cai@lca.pw, boqun.feng@gmail.com
Subject: [PATCH kcsan 0/1] KCSAN updates for v6.2
Message-ID: <b5ce4d12-e970-4d84-8f89-fd314e42ed30@paulmck-laptop>
Reply-To: paulmck@kernel.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This series provide a KCSAN update:

1.	Use min() to fix Coccinelle warning, courtesy of Thorsten Blum.

						Thanx, Paul

------------------------------------------------------------------------

 debugfs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

