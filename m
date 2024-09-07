Return-Path: <linux-kernel+bounces-319592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F28196FEF9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 03:29:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1981B229CF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2024 01:29:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45CF6DDA1;
	Sat,  7 Sep 2024 01:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eCQ/TQKp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B33EDDA0;
	Sat,  7 Sep 2024 01:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725672545; cv=none; b=juX6sFirzWk5CE5GIFqVgnZFej9lIGBFP8aWeDbniIbph9dlfBK+AWA2UmUdr0I2Ny7y7vgISqQrwsmQfFjr1J5oi1C/HaLnzNjy0p7P46gYpHSFn6x0MkDwEQ8GWUJ8nJ2+RCcJmDGCT2djTfQJ5yv1OF4lBz0WQRZt32125UA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725672545; c=relaxed/simple;
	bh=JAbDlUmnCm5RtGo2c4FkRbsaKSBfsmmuHbYiAOxdfkY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O5OsEcm1xyGP98CmAsKcT727uYh2VAGzY6TznKOaDO9V0H1i52iE3qnGddxbEvgHqHOBPBAQgs9lGpYGfyi5F/hKe8Gj6JTMuVmMHgE/ZjB0IiP290P8bCoO2IRhXq9ziTCiabelk7QIIbq4iowwER1Fq31PbVF5v55MHfsjJaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eCQ/TQKp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70329C4CEC4;
	Sat,  7 Sep 2024 01:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725672545;
	bh=JAbDlUmnCm5RtGo2c4FkRbsaKSBfsmmuHbYiAOxdfkY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eCQ/TQKpgeJJHzoMjiaCZ0Cl+ATS/UJ8B7IvsR/F0N/yY2oYcxhKee7qhViFky6lL
	 Ql8y3wbcQLP83EL82toIrKesTujH9kiufMHJjn3hcaMNW1LWJMnMiuWPPX1WkHia0n
	 /Jibn/UxbfRHXwBEp10h9QMfRKBVWBu8eC5Z8gX5o5DBq1QFGg5PtWB7U2lPlSSD5z
	 9JuYNW7xmHnIXX2EyDsATm7QSx5UfSaXVwmMqr1pCnpJJpTik84JlxdPOeA0fFLF+Q
	 Um3wvxOwT1rAbjTaj72TEVFZQyHES8XvlGc6gBhH90Oc0ygFl6Hd7A6HycRzb8O55L
	 F7lMkzKX8/azw==
Date: Fri, 6 Sep 2024 18:29:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lee Trager <lee@trager.us>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan
 Corbet <corbet@lwn.net>, Alexander Duyck <alexanderduyck@fb.com>,
 kernel-team@meta.com, Shinas Rasheed <srasheed@marvell.com>, Tony Nguyen
 <anthony.l.nguyen@intel.com>, Phani Burra <phani.r.burra@intel.com>, Joshua
 Hay <joshua.a.hay@intel.com>, Sanman Pradhan <sanmanpradhan@meta.com>,
 Sridhar Samudrala <sridhar.samudrala@intel.com>, Alan Brady
 <alan.brady@intel.com>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] eth: fbnic: Add devlink firmware version info
Message-ID: <20240906182903.55d0ccd1@kernel.org>
In-Reply-To: <20240905233820.1713043-1-lee@trager.us>
References: <20240905233820.1713043-1-lee@trager.us>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  5 Sep 2024 16:37:51 -0700 Lee Trager wrote:
> This adds support to show firmware version information for both stored and
> running firmware versions. The version and commit is displayed separately
> to aid monitoring tools which only care about the version.

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

