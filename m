Return-Path: <linux-kernel+bounces-396696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24B689BD0C1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 16:39:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDE02286EC5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Nov 2024 15:39:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B35EE17332C;
	Tue,  5 Nov 2024 15:37:39 +0000 (UTC)
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D83168C3F
	for <linux-kernel@vger.kernel.org>; Tue,  5 Nov 2024 15:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730821059; cv=none; b=nCtB/pDWdCKK76Mwd3bmEiDYP5CeDlk4jxXa5nu+hnwh58znvWHvlc4OVdO46PAiTqleLTNj1zA/Z95UIi+i0j9/plr7rvsxYzG7iIgOg7mAqlFsZkIvzFEoCssrHF5+qPQXTE1Rwd9rB67yHqDc68s5W4HzMXlFPXqDGHEdcDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730821059; c=relaxed/simple;
	bh=0Hbco/w5KpVsOY79Rdk2hqEAnZLV3UEccMZMryu3wXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GHdmzUX4vyR1ja2BI+rgtImVyYP5Icz8e2ctRzmUKE9Lr4baWgdtVhb4qn5hINOqlDfJhAGaG9WecSN6dytPp81DGscN2ZGxHGZTdKmsqXe5he9XYTPL42DQbyNkT027OJmB/3WGaKI35mEnSuYnOoz+gCYuAGMk0YAudWvXkN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id ADE36227AAC; Tue,  5 Nov 2024 16:37:33 +0100 (CET)
Date: Tue, 5 Nov 2024 16:37:33 +0100
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@lst.de>, kernel test robot <lkp@intel.com>,
	Damien Le Moal <dlemoal@kernel.org>, oe-kbuild-all@lists.linux.dev,
	linux-kernel@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>
Subject: Re: block/blk-zoned.c:579:5-24: WARNING: atomic_dec_and_test
 variation before object free at line 583.
Message-ID: <20241105153733.GA7219@lst.de>
References: <202411050650.ilIZa8S7-lkp@intel.com> <20241105153422.GA7132@lst.de> <e86904d7-bf42-4b38-889e-3978e89358f2@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e86904d7-bf42-4b38-889e-3978e89358f2@kernel.dk>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Tue, Nov 05, 2024 at 08:36:33AM -0700, Jens Axboe wrote:
> On 11/5/24 8:34 AM, Christoph Hellwig wrote:
> > On Tue, Nov 05, 2024 at 06:52:25AM +0800, kernel test robot wrote:
> >>>> block/blk-zoned.c:579:5-24: WARNING: atomic_dec_and_test variation before object free at line 583.
> > 
> > Does anyone know what this warning is supposed to mean?
> 
> It's supposed to mean "use refcount_t for things like this".

Have we finally resolved the performance problems with refcount_t for
fast path operations?


