Return-Path: <linux-kernel+bounces-577666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BB3A72009
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 21:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BBC07A3192
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Mar 2025 20:32:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A57F1F874C;
	Wed, 26 Mar 2025 20:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJwN75Ra"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1ABA1A316E
	for <linux-kernel@vger.kernel.org>; Wed, 26 Mar 2025 20:33:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743021183; cv=none; b=aQtLNxya98E9PgB9u6XlTYdsenBlWdgRhk/Pw3EuBSWbMkurZ511Tzz6XSye9ctmZpOnBt5OmFx5OCGPxQ/iyQrV+h11kfraeJrTbvDIT6JDBLjljpQCAgjO4EQhlhvluVbJ3XMrlshLK9CgiBjgzoVc2EW7AQRFOfCHBAs6HDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743021183; c=relaxed/simple;
	bh=pqGT9LMZU/exArP4Iq5TWVGX8JYjTXjnz3TylOn7J60=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LQDLo8cwwUM95hrkMRbieeEGfndB5aogfvjagVkr4jGemTV8cLDVWjmgLXf98VhET/b4mPWrKnteR0AEr6XO5MoEQmP6+E6LGUVsPjN2crpXIaWJG8CwAjT1/HvjXT6CXxEAW/4qhiVbtv8btPzjEQHu6hP+ysKVqOZ4S4DyWrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJwN75Ra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46736C4CEE2;
	Wed, 26 Mar 2025 20:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743021182;
	bh=pqGT9LMZU/exArP4Iq5TWVGX8JYjTXjnz3TylOn7J60=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bJwN75RahuCzovxE+lL2Ls2e93xTC29TswmX/RssZKWThBJZILCNqe5oTXsZEYwNj
	 JKrgzo/dDlXQSJKen5akqtouUzZYgbw8zGmLDKto2ujY5+yKhSLeEjv0Mfq+evgr7/
	 e5z1WGBG/CIqJQB0YdQ1v8db26QpciW5fL9cZdSV/Uegl9t8nUAFEz/uFqkfmTOLSG
	 4yS1xzqQ0CZSpEJeztDzvlYpvQKl6nxMDJF6rFyYjMb8bJKDpQhvkyXjc3JLMA4O4V
	 APtAqrayUAIOLAznVcpnGhxhWx3iuIwo6ucH8xBjhXZV/JOghlFFb6N0wC5k5ED+rg
	 2lyguaLwOEuJw==
Date: Wed, 26 Mar 2025 10:33:01 -1000
From: Tejun Heo <tj@kernel.org>
To: Jake Hillion <jake@hillion.co.uk>
Cc: arighi@nvidia.com, changwoo@igalia.com, sched-ext@meta.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: create_dsq: Return -EEXIST on duplicate
 request
Message-ID: <Z-RkfScRAanAPs79@slm.duckdns.org>
References: <20250325224041.14088-1-jake@hillion.co.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325224041.14088-1-jake@hillion.co.uk>

On Tue, Mar 25, 2025 at 10:41:52PM +0000, Jake Hillion wrote:
> create_dsq and therefore the scx_bpf_create_dsq kfunc currently silently
> ignore duplicate entries. As a sched_ext scheduler is creating each DSQ
> for a different purpose this is surprising behaviour.
> 
> Replace rhashtable_insert_fast which ignores duplicates with
> rhashtable_lookup_insert_fast that reports duplicates (though doesn't
> return their value). The rest of the code is structured correctly and
> this now returns -EEXIST.
> 
> Tested by adding an extra scx_bpf_create_dsq to scx_simple. Previously
> this was ignored, now init fails with a -17 code. Also ran scx_lavd
> which continued to work well.
> 
> Signed-off-by: Jake Hillion <jake@hillion.co.uk>

Applied to sched_ext/for-6.15-fixes w/ stable cc'd.

Thanks.

-- 
tejun

