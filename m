Return-Path: <linux-kernel+bounces-412489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0642F9D09A0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 07:27:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFEB2280996
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2024 06:27:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76A50148827;
	Mon, 18 Nov 2024 06:26:41 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1516146A87
	for <linux-kernel@vger.kernel.org>; Mon, 18 Nov 2024 06:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731911201; cv=none; b=gfWjDuZvVu42+po3IdCLkZgUga7CDz1Y3ZdARe+CMbSyVPonqBTTBWjU8giCoBsPIJIX++xWFuhEboARQFBayHjD5lDqql25abtTRh9iEoYlc4AKWOSO3PgzlAzNRcw/tl4HuCH3688M6uPBW08J004E1EwGrUVlrLkfm1Ynhq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731911201; c=relaxed/simple;
	bh=9WPGGmNJ2DKE4iT2s8O6Vy+c2l5ep25mBfNJ7V52PCQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZRmEDNUMHERo3I0E5yF1HBNLu8wLxGx4qWsrsauI6awP3qrE7WYwwADXoA6U7fmA+P/+q19CT/kHr5YY/az3Rp5q2SLV/e+AuJt2zNhcKxL0k4Qnvv/Ek6HLw4mQucZl01pXHvb2h8B6myU37SYpYsxuR1IrBQ89RDZ9cKLZGvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id E20F368D38; Mon, 18 Nov 2024 07:26:27 +0100 (CET)
Date: Mon, 18 Nov 2024 07:26:27 +0100
From: Christoph Hellwig <hch@lst.de>
To: =?utf-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>, kbusch@kernel.org, axboe@kernel.dk,
	sagi@grimberg.me, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme-core: auto add the new ns while UUID changed
Message-ID: <20241118062627.GA32372@lst.de>
References: <20241115083727.30005-1-brookxu.cn@gmail.com> <20241115170411.GA23437@lst.de> <CADtkEec84+ECj_s4Seue5uC+xv3dBu6T4kaqeHMe9PLiLV6tUw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADtkEec84+ECj_s4Seue5uC+xv3dBu6T4kaqeHMe9PLiLV6tUw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Sat, Nov 16, 2024 at 08:49:12AM +0800, 许春光 wrote:
> Yes, now we have remove the old ns and log the change to dmesg,  but I am
> confused why not auto add the ns with new UUID, we should treat it as a new
> ns? so that we can avoid an active controller with no ns, but actually it have
> one.

Because as far as the specification is concerned it is.  The whole point of
these identifiers is that they are stable over the life time of the
namespace.


