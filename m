Return-Path: <linux-kernel+bounces-557309-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A4AA5D723
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 08:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736CD17914E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Mar 2025 07:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB27E1E9B1B;
	Wed, 12 Mar 2025 07:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BcUZxhg6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEFD79CD;
	Wed, 12 Mar 2025 07:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741763742; cv=none; b=jMuV7v/dnIVZcc91BT86/izo57/s0pcM3G2cKUeyQ5bgOon2XgMRPpnmt4UJ8kD13jar/1X2hyTXzRA8/sDUYvvagiDmZkY+jUr0I4mqE3Aheyozl84RbbT2PRDe6qP9MIyygHyTQUWZckzO+RWZn8xZzPDbUWTYwYSnO9gGLIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741763742; c=relaxed/simple;
	bh=WPUZ5YogoyL5v/apNB+U1bNVQ5rIXUbcwsGSk6MLPwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cr5QrDhKZrW6COtWsS/9wdPJn+0SqSHsoXC7FftTNzCA0Kxqe1NJ6QnmHX6FFPgUzpjQOSrCDbUmSiRsLFcMGGs5FloxtEKwFxfxyqruq3ncYGHrWhjiiSCQLp+ClMyceRdhB9ef92Uwe9zO5Bcg2EZ4mZ+O5JwSLCXtcjIvWiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BcUZxhg6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 105C8C4CEE3;
	Wed, 12 Mar 2025 07:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741763741;
	bh=WPUZ5YogoyL5v/apNB+U1bNVQ5rIXUbcwsGSk6MLPwQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BcUZxhg6xSCnKeahLlxJ/cZ/A6ACxZMyc+/F0PRbn5JPx8vSQKMmTxW6ixZdB4fNT
	 Fb3hKrNIRtbjfv4rm9udefnLyRUi/BOHzR2eC3GMNthGH6PAFYpw0PPCidsudbRu96
	 xOJIZ9StSG/edVc+W68888VUOzeFnmCFBpowOZ1Q=
Date: Wed, 12 Mar 2025 08:14:24 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, airlied@gmail.com, acourbot@nvidia.com,
	jhubbard@nvidia.com, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 0/4] Auxiliary bus Rust abstractions
Message-ID: <2025031228-saline-preset-ba9b@gregkh>
References: <20250312002741.453350-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250312002741.453350-1-dakr@kernel.org>

On Wed, Mar 12, 2025 at 01:19:06AM +0100, Danilo Krummrich wrote:
> This series adds Rust abstractions for the auxiliary bus.
> 
> It implements the required abstractions to write auxiliary drivers and create
> auxiliary device registrations. A driver sample illustrates how the
> corresponding abstractions work.
> 
> The auxiliary abstractions are required for the Nova driver project, in order to
> connect nova-core with the nova-drm driver.

Nice!

> This patch series depends on [1] (taken through the nova tree for v6.15); a
> branch containing the patches, including the dependency can be found in [2].
> 
> [1] https://lore.kernel.org/rust-for-linux/20250306222336.23482-2-dakr@kernel.org/
> [2] https://web.git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/auxiliary

Do you want this to wait until that lands in 6.15-rc1 or do you want to
take this now through the nova tree?  Either is fine with me.

thanks,

greg k-h

