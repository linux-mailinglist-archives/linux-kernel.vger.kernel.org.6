Return-Path: <linux-kernel+bounces-387217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B56CA9B4E0D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 16:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52DA5B2438D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Oct 2024 15:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C022194137;
	Tue, 29 Oct 2024 15:32:47 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F21C2BAF9
	for <linux-kernel@vger.kernel.org>; Tue, 29 Oct 2024 15:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730215967; cv=none; b=Yg4BgK7o5cK7jMifV6zN9AWBcB10pi0dOykh/IBGLYmTKefeJNXcZRzVJZCNa4cqcEbTG29It09VX99fGuSJieaFZ1W71k+oUq4hK7LWk0+wKVUTrbIFdxtAGysw57IExYHmwsYYYpSFYIEt3mYWEgzA/XtiYj9HH/yLE4TlxS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730215967; c=relaxed/simple;
	bh=+Zm8oaXlmXBIoGQ+veipBJfpBwl93YFe5RUpRCSHyPY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ExBTNlc3RlLxKh9Xt6anmJZkd5+QpMG0v3iYsBmlltPQG6Jd4KCON+vP3zWllj2ZZR6+XWB8Ga3FNp2JE63Rze3JEAYoNBB4GHknNkPq+2DcxhB5/vnvrkdjrW5YNTZT5lueK2Bc3zp3tvDxH13QGdZJMXrSZJKEygmrgNt1adg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 72B79227A88; Tue, 29 Oct 2024 16:32:39 +0100 (CET)
Date: Tue, 29 Oct 2024 16:32:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Michael Kelley <mhklinux@outlook.com>
Cc: stuart hayes <stuart.w.hayes@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Lukas Wunner <lukas@wunner.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Martin Belanger <Martin.Belanger@dell.com>,
	Oliver O'Halloran <oohall@gmail.com>,
	Daniel Wagner <dwagner@suse.de>, Keith Busch <kbusch@kernel.org>,
	David Jeffery <djeffery@redhat.com>,
	Jeremy Allison <jallison@ciq.com>, Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Jan Kiszka <jan.kiszka@seimens.com>,
	Bert Karwatzki <spasswolf@web.de>
Subject: Re: [PATCH v9 0/4] shut down devices asynchronously
Message-ID: <20241029153238.GA26979@lst.de>
References: <20241009175746.46758-1-stuart.w.hayes@gmail.com> <BN7PR02MB41480DE777B9C224F3C2DF43D4792@BN7PR02MB4148.namprd02.prod.outlook.com> <SN6PR02MB41571E2DD410D09CE7494B38D4402@SN6PR02MB4157.namprd02.prod.outlook.com> <2024101809-granola-coat-9a1d@gregkh> <ZxInC1U7WiB7FNkJ@wunner.de> <2024101808-subscribe-unwrapped-ee3d@gregkh> <7ec51cc8-b64f-4956-b4e6-4b67f1a8fa76@gmail.com> <SN6PR02MB4157B4916F2B8581B9C6E214D4422@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SN6PR02MB4157B4916F2B8581B9C6E214D4422@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sun, Oct 20, 2024 at 12:24:32AM +0000, Michael Kelley wrote:
> Yes, I agree that a single core system should be able to get multiple
> NVMe drives shutting down in parallel. The parallelism would be
> governed by the number of worker processes that the workqueue
> decides are needed. I didn't look at how it makes that decision.

Or we could just go back to the old design where one methods kicks off
the shutdown, and then another one waits for it, which requires no
extra threads at all.


