Return-Path: <linux-kernel+bounces-365653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A566799E584
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 13:24:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CEF11F24B34
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Oct 2024 11:24:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D18A1D5ADD;
	Tue, 15 Oct 2024 11:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BLonfy7l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B8F1D6DB6
	for <linux-kernel@vger.kernel.org>; Tue, 15 Oct 2024 11:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728991472; cv=none; b=GnnjJyolkxGJePdTNGQ4WmtiiLuUaU63RdWNIeISMjF1s+5wkIIcEbqc7YE8Wvt3XB1VDMrwMhxQjlz3bEe4u+No6iywNMGOp4fAZUxQ/ssVOeB2uxqRnT+158YGrG5c83mMSWatTeZlN/BNEhd8H4VN2Q7It8tJ/pmIkLGF6Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728991472; c=relaxed/simple;
	bh=JDaIxUUsCOXltO17I1vFdvgxmbF8yrYdO4bptsjvxEA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FkI5Q+4/bR9eLy63xwHLYORi8sFTlhWU+ow2urVNb+TNTbMCQqfIhWy/oB3rlkoetEwsfMs79h4UcvvSXFw5Y854DYCPsyHNtjRbob/t9vxObpjdazuHgutfWiAHyUK7n9i8lpgcn4Cqfesc9BK+ih3nFSMb1YOZTX8RjUvZ4uM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BLonfy7l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27070C4CECF;
	Tue, 15 Oct 2024 11:24:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728991471;
	bh=JDaIxUUsCOXltO17I1vFdvgxmbF8yrYdO4bptsjvxEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BLonfy7lgiwN1YZMkIx5IgJxeVEfu64UDqpAXmi6Wx+8IBfMW7MzkxFIgs/g7beE7
	 MZwO2d5KEPHsXrAZfm7otm4sJiUgSWuEVRMrGE6lPUsFQDLDsPtXcOHagYgafzHWPw
	 4OtXMSwq3Nn8jBcQSDyJyCn1HMhAL3iW/NvVYUBg=
Date: Tue, 15 Oct 2024 13:24:28 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: Oren Weil <oren.jer.weil@intel.com>, Tomas Winkler <tomasw@gmail.com>,
	linux-kernel@vger.kernel.org, Rohit Agarwal <rohiagar@chromium.org>,
	Brian Geffon <bgeffon@google.com>
Subject: Re: [char-misc-next v2] mei: use kvmalloc for read buffer
Message-ID: <2024101519-malt-used-4986@gregkh>
References: <20241015104745.2242190-1-alexander.usyskin@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015104745.2242190-1-alexander.usyskin@intel.com>

On Tue, Oct 15, 2024 at 01:47:45PM +0300, Alexander Usyskin wrote:
> Read buffer is allocated according to max message size, reported by
> the firmware and may reach 64K in systems with pxp client.
> Contiguous 64k allocation may fail under memory pressure.
> Read buffer is used as in-driver message storage and not required
> to be contiguous.
> Use kvmalloc to allow kernel to allocate non-contiguous memory.
> 
> Reported-by: Rohit Agarwal <rohiagar@chromium.org>
> Closes: https://lore.kernel.org/all/20240813084542.2921300-1-rohiagar@chromium.org/
> Tested-by: Brian Geffon <bgeffon@google.com>
> Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
> ---

No Fixes: tag?

