Return-Path: <linux-kernel+bounces-231830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AB86919EE7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 07:51:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35EA2283F10
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 05:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8231CF92;
	Thu, 27 Jun 2024 05:51:28 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F2C200B7
	for <linux-kernel@vger.kernel.org>; Thu, 27 Jun 2024 05:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719467488; cv=none; b=sdT3xN+GJP05O3qkOxiAjeYUGWwE/lTxfRQy35auRxBVTP9xtyDxOKHuzi4/shjkxTTkLzB5saD+Ba8DGxktwMCJ+hbL4bO4lKQugwlfwKwXnr5NDIAwkVqlPqm7/S/8hKV0Rx6GDc7crW+zLnlpNSQ6ggtlzSohGwSZm7HaPCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719467488; c=relaxed/simple;
	bh=glZu1tzSd6/wg9bREBTg6+jiy1Z6mR1NRgEo1vzuy1I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mW6bJUrUlZRMXDxrBVZjVPXGUF3HKMQ+QpLrClxgE+3LrUY9r+CXIbdxfzyMrm91iodz0lv9tpuQI0mbW+MExrUm0rJK5tCQ+98kRUJSHq44V60PAAh3uf8HV6GnNblRATwI4Q8EL5s/6yBFV/9xvIuDMnEUsMo8bXd0iC+Xwx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id AA3E568AFE; Thu, 27 Jun 2024 07:51:21 +0200 (CEST)
Date: Thu, 27 Jun 2024 07:51:21 +0200
From: Christoph Hellwig <hch@lst.de>
To: Stuart Hayes <stuart.w.hayes@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	Lukas Wunner <lukas@wunner.de>, David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH v7 1/4] driver core: don't always lock parent in
 shutdown
Message-ID: <20240627055121.GA15415@lst.de>
References: <20240626194650.3837-1-stuart.w.hayes@gmail.com> <20240626194650.3837-2-stuart.w.hayes@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240626194650.3837-2-stuart.w.hayes@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jun 26, 2024 at 02:46:47PM -0500, Stuart Hayes wrote:
> Don't lock a parent device unless it is needed in device_shutdown. This
> is in preparation for making device shutdown asynchronous, when it will
> be needed to allow children of a common parent to shut down
> simultaneously.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>

.. but I guess this means async shutdown won't work well for busses
that set this flag (just usb currently)?


