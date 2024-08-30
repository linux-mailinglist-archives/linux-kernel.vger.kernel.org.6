Return-Path: <linux-kernel+bounces-308979-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5170C966492
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 16:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 849F31C210F0
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 14:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 026E71B2EF6;
	Fri, 30 Aug 2024 14:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qFdiNl7w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B85D18FDA7
	for <linux-kernel@vger.kernel.org>; Fri, 30 Aug 2024 14:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725029532; cv=none; b=Mxqvk2kaeNh2ssgFe/wJ0RnFHbs0o3MNOzTEFqTsrVehniI81rYn2dv7QjRaEOz17ES60CwAoTS0ulHzI0c2S1yBOZ+/66ZPfIR7BF4bBF1ftj3Epfsw4XbrG8kLqwEIfJgNaa3L1GeENzqJSsO9VUU9d/NgPcd8fTO8Jpl630k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725029532; c=relaxed/simple;
	bh=I9Pun/kr5/Bslk1OWoitzFURlDAnR56ZIlRPk6WxJHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=teifreXhIodNBnAFkBczCnrTCf7lWYy9OX6ILGwgodoL/j38jXgsVEpEDcnre2WivFM3EZDqPYPSqMrw6qRKx/FknJeR2o3BRfzUukvjacgKxZhaWOWHK/K3d/Jek5hzMJ553OzDvLvrbzLd8scIK9nQlocP4Zusu6JMNnnwIxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qFdiNl7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C111C4CEC2;
	Fri, 30 Aug 2024 14:52:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725029531;
	bh=I9Pun/kr5/Bslk1OWoitzFURlDAnR56ZIlRPk6WxJHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qFdiNl7wf/63BOblSwKODZiX7S5A5LeZM/dU+JwZLejJ2uQcoPwEUC13IBmw0xSPn
	 VPsHaG0iSbZ8r2FnP0+i29QaPkrxRFAh9WBwiTw1QqPoKpfq3eXOyLVZUN7EPlv9IK
	 R8TIvxryxdqMv/A3RQ8un9e6Dk/DqA8Rv6Sr3DZwF1vbsX/EN6hfdB+mVEN8x6DLdb
	 IqhDXNvVWvjZOOeXUSfFa6RERcJaOewpy3GZMvz3IPymIkLvNNXqBaGJNZximYvmAI
	 DZbCaG85evIGRV4QZ66xYtioXXIqG0MmtZUaSisgMoJS+LbhXnSZYdXhQ/XHb6EyFx
	 VCxl6QvpxTDEg==
Date: Fri, 30 Aug 2024 08:52:09 -0600
From: Keith Busch <kbusch@kernel.org>
To: Puranjay Mohan <pjy@amazon.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org, puranjay@kernel.org,
	amazon-linux-kernel@amazon.com
Subject: Re: [PATCH v3] nvme: fix metadata handling in nvme-passthrough
Message-ID: <ZtHcmYvTTmZfTEXY@kbusch-mbp>
References: <20240829133217.1627-1-pjy@amazon.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829133217.1627-1-pjy@amazon.com>

On Thu, Aug 29, 2024 at 01:32:17PM +0000, Puranjay Mohan wrote:
> On an NVMe namespace that does not support metadata, it is possible to
> send an IO command with metadata through io-passthru. This allows issues
> like [1] to trigger in the completion code path.
> nvme_map_user_request() doesn't check if the namespace supports metadata
> before sending it forward. It also allows admin commands with metadata to
> be processed as it ignores metadata when bdev == NULL and may report
> success.
> 
> Reject an IO command with metadata when the NVMe namespace doesn't
> support it and reject an admin command if it has metadata.
> 
> [1] https://lore.kernel.org/all/mb61pcylvnym8.fsf@amazon.com/

Thanks, applied to nvme-6.12.

