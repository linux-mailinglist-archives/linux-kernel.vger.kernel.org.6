Return-Path: <linux-kernel+bounces-312786-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7182B969B40
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 13:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4A0E1C21395
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Sep 2024 11:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372CD1A3AA0;
	Tue,  3 Sep 2024 11:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YcBm97YG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992E8187874
	for <linux-kernel@vger.kernel.org>; Tue,  3 Sep 2024 11:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725361852; cv=none; b=PV6eQgjv93YqfK5rR2Ky2OXe9InnzgNx4gMngNWLL0ajBMtogc7c2aS28gCPw/vOZPnKQvAXyvhZhJfoV19mCKwsK/AWB9bsZx4NkWMWMtg+MZaPSnCgVAmWHP72gH2EsMMJ3aF7zvtCpuiqGlkhZqEkQEQZ5xLjc/n4SElPArY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725361852; c=relaxed/simple;
	bh=mB23K2EPv3W5yk5ymchBdKJS7P31zj6vmBl01X3EDWM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J3iNY+cRqrI9ycbHrUomPKiypirr5AL3C11cktJU+vzsVm8D15UyhT3Uk3suwKZiwJBOk8xTHigbOspODm3F76yn+bB/+h+v1e5sESTwq0RJqFmu9sEJsfDpl+CaC9oeEu1nqHN4vY0lpZuuxSnBYP+1Hy14u/kDICtoWsDlvIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YcBm97YG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8AFC4CEC4;
	Tue,  3 Sep 2024 11:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725361852;
	bh=mB23K2EPv3W5yk5ymchBdKJS7P31zj6vmBl01X3EDWM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YcBm97YG03UTh0iWiqh+8IuJXwGmDgee6YbExSOwKN9+a81k8q3tND4PTNW7fq46k
	 +N9MK75UNsQAhYYlsBkVZWmH2TuYQMh5fA6ZrCGx7BBniLcHmkbv34qsDC55LiuoQE
	 UoTmZnmmGIBLHkBUEcB5DUhzax41VvJAI2C/U6tM=
Date: Tue, 3 Sep 2024 13:10:43 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v8 0/4] shut down devices asynchronously
Message-ID: <2024090330-frostily-hazing-f6de@gregkh>
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

Thanks for sticking with this, all now queued up in my tree

greg k-h

