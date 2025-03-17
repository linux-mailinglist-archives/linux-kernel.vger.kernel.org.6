Return-Path: <linux-kernel+bounces-564978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 652B0A65E3D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 20:42:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A28A7189A912
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 19:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70A971F3B85;
	Mon, 17 Mar 2025 19:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hAdHQFpF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71711A3029;
	Mon, 17 Mar 2025 19:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742240506; cv=none; b=rX3HOtPH6hbmzIauTiu10+ncW4o49KuBDGbKV/xTOF+mtBgef8cJZ2lFCFcmYzXE0ZS1eODGR+zNFPaQxR+SAb5N1g3k1xESXjWo5Rho+/fCcStKCWfYlELwZu7IDnDvxXX0o0/D5IWnSj6tpfvsbeYybll1BEbaeG7VUXlM42U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742240506; c=relaxed/simple;
	bh=M5DC/biv/Uhbcd3IaR6CyJL8PiIRugOzZt7y1LxHHSE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m4404MXJlk3/gcS6HMF6S4JVS35JqIBm26NpIXVGUGNTF09j1Dyl4MHHdg42NIwtTlIPw28DelwWa+B7/P/fxgrcRyFTcTZ+jMQ+mfaQ9YcA+X31BO3e10+mMn8xGcY1kVgbAwVKTGDkqGXMKwJD9aryobR4BOgD8tcCuXwtyeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hAdHQFpF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2ABDC4CEE3;
	Mon, 17 Mar 2025 19:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742240505;
	bh=M5DC/biv/Uhbcd3IaR6CyJL8PiIRugOzZt7y1LxHHSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hAdHQFpFtcLF6f9SBZk35QKEAEbtVx01EhXSOBhpfPmK5jx9eZMbnd9B0lPkanT+k
	 k5GGaqfeip2FSFYLvkTsMrLa587fjLpnY3kJlhiJxzIhHR99ryVVcMSUWreH9hOl7k
	 WyheSyd4goRIx8ZYc74lZZvYdwwiI8ziweZa6oQx2RRM619qsk6H7JnrcpnmaWs7F+
	 GIKSc1xxZ7k4MWKNhOQUlcUYJ15holzasL0+Hozso3LxWbllpDRTxx7jy8cfVbRF6X
	 a+CX9Csx8hMJwDAG62CGZ/TlJxr+ec/wsAiHyaQ1qrXsSKexsXhHs8N9OTM5BTT1yZ
	 kcSqAMbRcIdUw==
Date: Mon, 17 Mar 2025 20:41:38 +0100
From: Joel Granados <joel.granados@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Ruiwu Chen <rwchen404@gmail.com>, 
	Luis Chamberlain <mcgrof@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] drop_caches: Allow re-enabling message after disabling
Message-ID: <uskuzzo47jsebv7estk3vwiidygl3vybwxynwod76dwtbtim5i@4iyavbs3qgsi>
References: <20250313-jag-drop_caches_msg-v1-1-c2e4e7874b72@kernel.org>
 <20250314-tilgen-dissident-05705fca5e00@brauner>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250314-tilgen-dissident-05705fca5e00@brauner>

On Fri, Mar 14, 2025 at 11:48:43AM +0100, Christian Brauner wrote:
> On Thu, 13 Mar 2025 16:46:36 +0100, Joel Granados wrote:
> > After writing "4" to /proc/sys/vm/drop_caches there was no way to
> > re-enable the drop_caches kernel message. By removing the "or" logic for
> > the stfu variable in drop_cache_sysctl_handler, it is now possible to
> > toggle the message on and off by setting the 4th bit in
> > /proc/sys/vm/drop_caches.
> > 
> > 
> > [...]
> 
> Applied to the vfs-6.15.misc branch of the vfs/vfs.git tree.
> Patches in the vfs-6.15.misc branch should appear in linux-next soon.
> 
> Please report any outstanding bugs that were missed during review in a
> new review to the original patch series allowing us to drop it.
> 
> It's encouraged to provide Acked-bys and Reviewed-bys even though the
> patch has now been applied. If possible patch trailers will be updated.
> 
> Note that commit hashes shown below are subject to change due to rebase,
> trailer updates or similar. If in doubt, please check the listed branch.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/vfs/vfs.git
> branch: vfs-6.15.misc
> 
> [1/1] drop_caches: Allow re-enabling message after disabling
>       https://git.kernel.org/vfs/vfs/c/66c4cbae77e2

FYI, Sent out a V2 after discussion in [1]

[1]: https://lore.kernel.org/20250216100514.3948-1-rwchen404@gmail.com

-- 

Joel Granados

