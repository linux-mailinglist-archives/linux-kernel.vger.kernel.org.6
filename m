Return-Path: <linux-kernel+bounces-237264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B1DD291EE1B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 07:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1450F282AA7
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Jul 2024 05:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D3B51004;
	Tue,  2 Jul 2024 05:04:21 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF58433A6
	for <linux-kernel@vger.kernel.org>; Tue,  2 Jul 2024 05:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719896661; cv=none; b=LzThxO1VwhAEo3lG3qzWGohVh51B0HrfUp0ST0P+kd6NueFjwZSMCj9G22AaAgUbLIoVQm5cIHvPnB+XZ34pJ7L4g4QEpw/7qt5D8t12pNZC3fuI290p9yi4I0ZqXjDFv7wmuFlLCJI+gLkhORXroywvToFC/KuMgREnlH/2Jx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719896661; c=relaxed/simple;
	bh=qelVFmQBhbe70yWyJcaEJ1PF+kk1JwOKhAOUnNYrgCM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N6pcfavSwR6Y76opjRVObGrPVRxXcdubVRjElR70qfgS409kTcn4UxgSZY1mmQVuR0ZfdkEMB4cFCY7iQaH4y+8i6VEvNrNPhVY/TQMqpVaOhH898XY4tC6T2WB8XpkgxWoV0DkE2QisBkTk5LJx6p4hi4snOVMNz3JSulh5w6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 632E168B05; Tue,  2 Jul 2024 07:04:14 +0200 (CEST)
Date: Tue, 2 Jul 2024 07:04:14 +0200
From: Christoph Hellwig <hch@lst.de>
To: stuart hayes <stuart.w.hayes@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v7 3/4] driver core: shut down devices asynchronously
Message-ID: <20240702050414.GA22160@lst.de>
References: <20240626194650.3837-1-stuart.w.hayes@gmail.com> <20240626194650.3837-4-stuart.w.hayes@gmail.com> <20240627055515.GC15415@lst.de> <8a7ae125-883c-4c45-8b89-791066fb5866@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a7ae125-883c-4c45-8b89-791066fb5866@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 01, 2024 at 12:57:40PM -0500, stuart hayes wrote:
>> We discussed this before, but there is no summary of it and I of course
>> forgot the conclusion:
>>
>>   - why don't we do this by default?
>
> It is done by default in this version, for devices whose drivers opt-in.
>
> In the previous discussion, you mentioned that you thought "safe" was the
> only sensible option (where "safe" was driver opt-in to async shutdown)...
> that is the default (and only) option with this version.  Greg K-H also
> requested opt-in as well, and suggested that "on" (driver opt-out) could
> be removed.
>
>>   - why is it safe to user enable it?
>
> I guess it isn't necessarily safe, if there are any drivers that can't
> handle their devices shutting down asynchronously. I thought it would be
> nice to be able to enable driver opt-in from user space for testing, before
> changing the default setting for the driver.

I was mostly getting into the contradiction that either we think the
async shutdown is safe everywhere, in which case we don't need a driver
opt-in, or it is not, in which case allowing user to just enabled it
also seems like a bad idea.

> I can correct these lines. I thought that an 80 character line length limit
> was no longer required, and saw another line a few lines above these that was
> even longer... and the checkpatch script didn't flag it either.

checkpatch is unfortunately completely broken, it flags totally harmless
things and doesn't catch other things.  > 80 characters are allowed for
individual lines where it improves readability.  The exact definition
of that depends on the maintainers and reviewers, but outside of
string constants I can't really find anything where it does.

