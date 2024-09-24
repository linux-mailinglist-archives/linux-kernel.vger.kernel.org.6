Return-Path: <linux-kernel+bounces-337119-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C7F9845A7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 14:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2D571F213F7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 12:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E6861A7070;
	Tue, 24 Sep 2024 12:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tGOZDKc0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DC4719F417
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 12:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727179993; cv=none; b=QjkQA1wtkQ61aajVdgiD8uH3v5pMjJS0V23V9s3gSAz1rem7Ypmx9rhWt0ohqHMwHS+7tKk0RgHAfdEjNwX9fgmgBqd9Jb/i7iZAk3djpmaq9EDKb4dzw9ehm6Qtxr+TwQ+3IimDN4MyTsifVkFKC4RzRiuJBPL1XQPbouzG+hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727179993; c=relaxed/simple;
	bh=B8ehp8HVjT9w2eTGexKlHMy9URUf2vx87/22iPfqMFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhYKeZ4MezCk6zUsQ/TBxIrOLEdrruC22jD6gjsiLBg3Eh2zkMQXsLzCkObEwux2cPB4TYqsMqs6hKmmMK3M1BniB3S50YHPzHAkiQ4JZ41aRrQ4vtpqsfXBlv15xGOHOGSZX2DO76Esx9VXO4QRx4IZnurLXrukSTHCAUDi6m8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tGOZDKc0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EF84C4CEC4;
	Tue, 24 Sep 2024 12:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727179993;
	bh=B8ehp8HVjT9w2eTGexKlHMy9URUf2vx87/22iPfqMFA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tGOZDKc093HHUhrMXmqQ7Ofqr629mgHFIM/5ZUuNYN+J3C66tkHJOsgKNMXW51VYt
	 Y01gdpG/huips3Qo/vSYAZ4Mh5lXr8dcB2AB9lj3lR4Nc0Grnthyi7czK/rl5PzvGD
	 hlnL0q0m8fsngb2hb4RRFcdSAYNjvjbcc2hguPLw=
Date: Tue, 24 Sep 2024 14:13:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yu Kuai <yukuai1@huaweicloud.com>
Cc: yangerkun@huawei.com, chuck.lever@oracle.com, brauner@kernel.org,
	sashal@kernel.org, Coly Li <colyli@suse.de>,
	linux-kernel@vger.kernel.org, cve@kernel.org,
	"yukuai (C)" <yukuai3@huawei.com>
Subject: Re: CVE-2024-46701: libfs: fix infinite directory reads for offset
 dir
Message-ID: <2024092431-valid-psychic-0c7e@gregkh>
References: <b378c634-102f-e115-e925-0a20dc450ff7@huaweicloud.com>
 <2024092400-appointee-sensation-ddb1@gregkh>
 <8d0582ae-30f5-aa98-2778-423e81520507@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d0582ae-30f5-aa98-2778-423e81520507@huaweicloud.com>

On Tue, Sep 24, 2024 at 05:44:29PM +0800, Yu Kuai wrote:
> > > On the other hand, v6.6 is affected by this CVE, and this fix can't
> > > be backported to v6.6 because the patchset [1] must be backported first
> > > to expand offset from 32-bit to 64-bit.(This kind of refactor will
> > > break kabi, hence it's not acceptable in our downstream kernels)
> > 
> > That's your business decision, and does not affect if we do, or do not,
> > assign a CVE at all.  Go work with your management if you wish to change
> > this as it does not pertain to the community in any way.
> 
> Yes, I understand, This is just the reason why I tried to close this
> CVE, please ignore this.
> 
> BTW, if you still think this CVE is valid, can we bakport the refactor
> patchset to v6.6 as well? I can sent the patches to 6.6 lts, just let me
> know.

Sure, send them on, we are always willing to review potential stable
patches, to the stable@vger.kernel.org list.

thanks,

greg k-h

