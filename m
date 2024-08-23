Return-Path: <linux-kernel+bounces-299382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04B9495D3D1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 18:55:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78DADB2493C
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Aug 2024 16:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0184718E030;
	Fri, 23 Aug 2024 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j+LNrFFb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E8218BBB4
	for <linux-kernel@vger.kernel.org>; Fri, 23 Aug 2024 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724432088; cv=none; b=E0kh+KD6HCAXEGz0BqmjgvLN7Y4I86ETwqqf7aYS0JevwxS62Zl9jcjFRX+HTNVbK4AQhRvd9gA6vS/DD6IlJ6vT+jbblScCMXvmUVe2ZzA8sp5kzAooWEVA4Plz5M72tQUd6M4gh0BixbMtcbZX3hZ0EoeTBbH5lEA0CFjAauI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724432088; c=relaxed/simple;
	bh=n9VpSAGA9V2fepelu0lGtZ5GVNOMysEMYA/hBvgL38M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O1gkLOhOgYjxLx5iPk3aoK7A/8mODl2qqgw1HFQ76ZuwvfOtWmeHARl8+I96fIqZ9fWgE7p0o8LYu/OvMq2N0YsWxZtmiuo5XaDtpL58Bp8ELef1vFc9Qe07z/QKLEW7jpwFJSSVnneG8Gx2ybCBhkKp+5C+DDbYjX0PUIz4Dto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j+LNrFFb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1B2C32786;
	Fri, 23 Aug 2024 16:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724432087;
	bh=n9VpSAGA9V2fepelu0lGtZ5GVNOMysEMYA/hBvgL38M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j+LNrFFbwczkVfRHdxugB8DCFkfd9B659qcuK1wIsWFU+I0k5T5Ie0a0fV75AoDsK
	 LAxP0YCkusRhpzsJhmNYVtUbidgN10CU2OINePEovvujwnZ4W8aPxF8Sz2S0eLsR5L
	 7T3OjWaYPnrzNkmoBYOiTHcozyNb/wxRI32ruae0fIPoH3gBvgBZvAcYJrD9c1z1CP
	 imUmwR3yK/QPJqfFf/vBkDX2Dc0KC8eal7UhKhIqr3c2CcenUxgFrTNlV69meWN8oA
	 dTr0HISaqhSW71TvKCvzhCNSXxxslH2rWf7dcxXVqJT3rxj/edxVBkyRW3xK6ECsGu
	 iym5EX0YVG8kA==
Date: Fri, 23 Aug 2024 10:54:44 -0600
From: Keith Busch <kbusch@kernel.org>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Lukas Wunner <lukas@wunner.de>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v8 0/4] shut down devices asynchronously
Message-ID: <Zsi-1H1w5VY5I4Ea@kbusch-mbp.dhcp.thefacebook.com>
References: <20240822202805.6379-1-stuart.w.hayes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240822202805.6379-1-stuart.w.hayes@gmail.com>

On Thu, Aug 22, 2024 at 03:28:01PM -0500, Stuart Hayes wrote:
> This adds the ability for the kernel to shutdown devices asynchronously.
> 
> Only devices with drivers that enable it are shut down asynchronously.
> 
> This can dramatically reduce system shutdown/reboot time on systems that
> have multiple devices that take many seconds to shut down (like certain
> NVMe drives). On one system tested, the shutdown time went from 11 minutes
> without this patch to 55 seconds with the patch.

Still looks good. For the series:

Reviewed-by: Keith Busch <kbusch@kernel.org>
Tested-by: Keith Busch <kbusch@kernel.org>

