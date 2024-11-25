Return-Path: <linux-kernel+bounces-420516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 019EF9D7BE3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 08:21:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94764162EA9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Nov 2024 07:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B80415573F;
	Mon, 25 Nov 2024 07:21:08 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8D21426C
	for <linux-kernel@vger.kernel.org>; Mon, 25 Nov 2024 07:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732519267; cv=none; b=LQ30THbqvYrjz52CE0TJO9NmP+K7APcJNGLi8hWPzLoONeZYeBSM7ScdxczwjsoP7yL6HuUvGoYDg6KX3XOS9BRZwgBEQHzKvDOEnx++g+Ms86M5/2gRAoVMQmbApWL0Zwcpme1DTaVznRrLi6T8u3I8zgLUE9aAKbr25KX5Mqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732519267; c=relaxed/simple;
	bh=seZyflu5YWqQdBqtU0nZgLLeQ5E46QJFp+G2G/mZaqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RkbNK5gG9yxwpBV3LfDCjmkpnYgnCu7XTmnHSdmM0q3unyrp2djua2+ew/oZPKcEdvVTm0tT0g+OoJFXndb+HA+68VRV8BF9WwEAORyhoO3rSgIyOSMryILl3PVWJAaKPvpEXWAjV1MqIB+F5RR7i+VKDMk4TMxTGih8IMllR+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id A379D68D09; Mon, 25 Nov 2024 08:21:02 +0100 (CET)
Date: Mon, 25 Nov 2024 08:21:02 +0100
From: Christoph Hellwig <hch@lst.de>
To: "brookxu.cn" <brookxu.cn@gmail.com>
Cc: kbusch@kernel.org, axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] nvme-rdma: unquiesce admin_q before destroy it
Message-ID: <20241125072102.GA15647@lst.de>
References: <cover.1732368538.git.chunguang.xu@shopee.com> <9379940137a8dfddb451917c1d069eebaf3c209e.1732368538.git.chunguang.xu@shopee.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9379940137a8dfddb451917c1d069eebaf3c209e.1732368538.git.chunguang.xu@shopee.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Nov 23, 2024 at 09:37:37PM +0800, brookxu.cn wrote:
> This due to we have quiesced admi_q before cancel requests, but forgot
> to unquiesce before destroy it, as a result we fail to drain the
> pending requests, and hang on blk_mq_freeze_queue_wait() forever. Here
> try to reuse nvme_rdma_teardown_admin_queue() to fix this issue and
> simplify the code.

Looks good, and matches what the TCP driver is doing:

Reviewed-by: Christoph Hellwig <hch@lst.de>


