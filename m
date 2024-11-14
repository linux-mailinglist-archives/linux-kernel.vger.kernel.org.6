Return-Path: <linux-kernel+bounces-409261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF52F9C89B3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 13:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7688DB2527C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 12:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DAC31F9EBD;
	Thu, 14 Nov 2024 12:17:56 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D5D1F9A9F
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 12:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731586675; cv=none; b=B9ZRaKL0kx11zHnLkuAYGUA8Q3ZKantj8WhJeQ+aZC8AxyLOea2YFSN5kNZp3RrJ2Sv69A5CuRnbTir72fGyEW9Njnz9B0tjH7P2V3uJbHCHW8AcHMfOhMExW/MCZAIAY+O1ywsGwEBOWsql2foC82gyCiro1iEo+xAwiGrfbKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731586675; c=relaxed/simple;
	bh=/X8AqsfsFuTR1IrW1lp9ZjH7mwkw8+XuxGW6rxZ9QW4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvwjhaoHaAgaeuFyVUhr55T4LquBMLqAR0HDK0/4M1AxJGb47BANjTnMhvdpZL3W3mnGCo89UMrjRX7wqi437cizI7KIH4+NMJlpCfuIPf8K6nRDlUXhc2SlgT3kF0dQCou//aqZGIZxnIewkPDAkPL0DqZ8q0OJnqwklZutQJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5911E68C7B; Thu, 14 Nov 2024 13:17:51 +0100 (CET)
Date: Thu, 14 Nov 2024 13:17:51 +0100
From: Christoph Hellwig <hch@lst.de>
To: =?utf-8?B?UGF3ZcWC?= Anikiel <panikiel@google.com>
Cc: bob.beckett@collabora.com, axboe@kernel.dk, hch@lst.de,
	kbusch@kernel.org, kernel@collabora.com,
	linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
	sagi@grimberg.me
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
Message-ID: <20241114121751.GA3971@lst.de>
References: <20241112195053.3939762-1-bob.beckett@collabora.com> <20241114113803.3571128-1-panikiel@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241114113803.3571128-1-panikiel@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Thu, Nov 14, 2024 at 11:38:03AM +0000, Paweł Anikiel wrote:
> When doing a write of 264 sectors with PRP list offset of 0xf00,
> the bridge treats data as a pointer, and writes incorrect data to
> the drive. This might be why Robert is experiencing fs corruption.

Not having the hardware and just speculating, but this seems like
a pretty likely failure mode.

**still cursing nvme for all this PRP brain damange**


