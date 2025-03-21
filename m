Return-Path: <linux-kernel+bounces-570761-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC293A6B445
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 07:08:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 580B83B3273
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Mar 2025 06:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF561E9B0D;
	Fri, 21 Mar 2025 06:08:41 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D965C22611
	for <linux-kernel@vger.kernel.org>; Fri, 21 Mar 2025 06:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742537321; cv=none; b=kwE5yo20xWfYKUitSS5KpPhE3c+zn2HFGh81Q41ITSnRXi7cpSfA6Wh44/U1HQwXzdoompZtt8bfVGs0ZhyIv4hIKOBczmA86jMVFYP7qbDhBMTZ5Hdjq7G5jHa8gspaq5S31p3+K+rghjlAwitZ6q3SpAj6f2RObYtLPPjkELk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742537321; c=relaxed/simple;
	bh=A+EkThgIdZ5Fl52SV8NyvCxOMkx+arNnU1i71V+EWWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QMXGfSwtqfAb4jh2nHrMwF7nPHMsZOEqDxzJKVE0RjVn185HMNx6O9QS9U9wgGzkTWPYIU+/YBE+2jPC1/uLi5gwDBN+N1IZZOA74JLbwB4d6E5Xz480c/khbfKMNE0mn3fIWgWpaISmoslatYLgpMGps/FJNX2PN8e7YUU4O5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 518B968AA6; Fri, 21 Mar 2025 07:08:33 +0100 (CET)
Date: Fri, 21 Mar 2025 07:08:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Daniel Wagner <wagi@kernel.org>
Cc: James Smart <james.smart@broadcom.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, Hannes Reinecke <hare@suse.de>,
	Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 06/18] nvmet-fcloop: sync targetport removal
Message-ID: <20250321060832.GD3007@lst.de>
References: <20250318-nvmet-fcloop-v3-0-05fec0fc02f6@kernel.org> <20250318-nvmet-fcloop-v3-6-05fec0fc02f6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318-nvmet-fcloop-v3-6-05fec0fc02f6@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Mar 18, 2025 at 11:40:00AM +0100, Daniel Wagner wrote:
> The nvmet-fc uses references on the targetport to ensure no UAFs
> happens. The consequence is that when the targetport is unregistered,
> not all resources are freed immediately. Ensure that all activities from
> the unregister call have been submitted (deassocication) before
> continuing with the shutdown sequence.

This needs to explain why that is needed.  In general a completion
waiting for references to go away is a bit of an anti-patter, so
it should come with a good excuse.


