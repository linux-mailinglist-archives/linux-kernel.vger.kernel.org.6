Return-Path: <linux-kernel+bounces-360526-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A1E999C1F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 07:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BDEE281EF1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Oct 2024 05:35:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3171F473A;
	Fri, 11 Oct 2024 05:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LKuhK9SO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6B82F26
	for <linux-kernel@vger.kernel.org>; Fri, 11 Oct 2024 05:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624907; cv=none; b=AoZ0/DHN/jQsuRdO6ftriC5fBBSQkPD9OTc835ADWKmqjLf/d84tbbOKAEaeWobIRAEpDCH/7hfKVfZ5TzvRTO/bCFhtzHOh96+51li2EDRSsfGAtVasBM/ugKAHrr6io8VyRBBaLZpocTQUxaHxhuNtnPtOzyoZ00UTczQs1hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624907; c=relaxed/simple;
	bh=EzwkqNZrlJLyElgrPq1WFgO7iWG3Z6QM+/UrNYPT1n0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AtT9OOQL1DC9GvT//Ziu6X5qfKChj+9qRFXSSwkDQsK9LfzjVi/EizSxf4TV5jurcbZ39Gn8cWAOJoIS2nwYcGi0K/QVEgnz0SF531FbXWPy+G0UQrHnIoiDzoZv1UpGEZdH56x8Y/aSQH3lfy9d4QzRrHcyLJD0224G6zJxoQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LKuhK9SO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38B72C4CEC3;
	Fri, 11 Oct 2024 05:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728624906;
	bh=EzwkqNZrlJLyElgrPq1WFgO7iWG3Z6QM+/UrNYPT1n0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LKuhK9SOVKasXYwTQdwkUz5nUJTiNfacQNQn04AYCZaVO01mJ5GveiPNFHYB7v+GN
	 FKaTJzhupBfpWHb5gyV5kO3y3GwNDL7xGm20HHQDYKX7ku8LzwgA35G6thCUrzl1cU
	 Nawf5SoI6/nFbTk4/vQl+YYh+UEiDPiJks7T2kPQ=
Date: Fri, 11 Oct 2024 07:35:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Chenyuan Yang <chenyuan0y@gmail.com>
Cc: linux-mtd@lists.infradead.org, richard@nod.at,
	miquel.raynal@bootlin.com, Zhihao Cheng <chengzhihao1@huawei.com>,
	vigneshr@ti.com, linux-kernel@vger.kernel.org,
	syzkaller@googlegroups.com, Zijie Zhao <zzjas98@gmail.com>,
	rafael@kernel.org, akpm@linux-foundation.org
Subject: Re: [Linux Kernel Bug] memory leak in ubi_attach
Message-ID: <2024101141-mooned-crestless-8ce2@gregkh>
References: <CALGdzuo8_EXr4aUAw6X9S+yzMPi25Y82netPLWsd+3n-Ov9Pnw@mail.gmail.com>
 <10779b09-3413-6374-b4a1-1efd8821c5f2@huawei.com>
 <CALGdzuryBbCqGAhox9ZWaQHD5dSQNApfGmCP+rYZ7O4MCRH+rw@mail.gmail.com>
 <7138a98c-1562-3059-07b6-4d918bec9d1a@huawei.com>
 <CALGdzuokUpWhUk7uvWcDT2tXRRMk07dmKGS-rFANOE6ZwZZW8w@mail.gmail.com>
 <0171b6cc-95ee-3538-913b-65a391a446b3@huawei.com>
 <CALGdzuoWvy5WvpttC1pab309kZ9cUyfT5O7JB8VjsqwU2HD0Xg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALGdzuoWvy5WvpttC1pab309kZ9cUyfT5O7JB8VjsqwU2HD0Xg@mail.gmail.com>

On Thu, Oct 10, 2024 at 08:23:22PM -0500, Chenyuan Yang wrote:
> Dear Linux Kernel Developers for UBI and Kernel Object,
> 
> I am writing to inquire if there have been any updates regarding this
> memory leak issue. This issue remains reproducible on the latest
> Linux version (6.12-rc2, commit
> 8cf0b93919e13d1e8d4466eb4080a4c4d9d66d7b).
> 
> Thank you for your attention to this matter.

Can you create a patch for this as you seem to have a good reproducer
for the problem.

thanks,

greg k-h

