Return-Path: <linux-kernel+bounces-408118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 593AA9C7AA7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 19:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08D291F26C1A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2024 18:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9A81632CC;
	Wed, 13 Nov 2024 18:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qmU33Ybq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BAE1531EA
	for <linux-kernel@vger.kernel.org>; Wed, 13 Nov 2024 18:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731521156; cv=none; b=YfN7ZWEyMDejWc03PojaTFygpU6skh80BXBgy17lhPhGVPizG+2IfrYFIWbB3EcOzPiRJHirRYHkSTRcf8jftvyRW7wvpkQmL/Pp8XaklBdpKaRFhhlCkhnBOokoAzC7PmFvkGC0YhwqT6qOVDGQjCMKtoahYFpTTVBSTeVBCDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731521156; c=relaxed/simple;
	bh=M4wyj6LnteCS8V5uLYewkH2xB3uFMsAbftOFpnkE21o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcQ6vqEBu6H49AkL4LOEBMHPFochk2LBvFPWlecoymyEJ7HscfLtjwShtR9YWuJgz/QZGuX/5l5kImHzQ+m5nLmQDYUlmZO0vrSwWkbbl32aKtrU91c6MVgFUu2OcuzO5Uy+J1nvFJtnBgmqOCjfx1snbAuQOdamNrLGSCJSI/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qmU33Ybq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B17C4CEC3;
	Wed, 13 Nov 2024 18:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731521155;
	bh=M4wyj6LnteCS8V5uLYewkH2xB3uFMsAbftOFpnkE21o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qmU33Ybq9mi6SS/EE9oMZnsYv/MW590U1NZ6DxaVzwGisRddMa9zzuYeFryV5QtDS
	 QB1Jv6vnxMOSX5rBYRXUqOS6FowHhQT1bMVks5xuW99pozRML8wnXm4cFG85NjdzGN
	 sSR7950AR4zd0WyLKTM/ulQ6dCiEyE19aEd+Fqdv8YjBgrrSbxG4SmYYkHVKZ+jLPL
	 QrGdHEHKhxHtF1dkNEOcyR/ReyBh3o55WrDgYoW81e58yM1/+deuQylQTwfAfAIBql
	 TRMEGUxOOiXKAwXkIx2XewWgBGCMPTERne0Kawf5CReHfULXbSqWrCv7oHRXgESeIY
	 4w6lf8eusXQeA==
Date: Wed, 13 Nov 2024 11:05:53 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Bob Beckett <bob.beckett@collabora.com>, Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>, kernel@collabora.com,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: 512 byte aligned dma pool segment quirk
Message-ID: <ZzTqgXqjN4UrT392@kbusch-mbp>
References: <20241112195053.3939762-1-bob.beckett@collabora.com>
 <20241113043151.GA20077@lst.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241113043151.GA20077@lst.de>

On Wed, Nov 13, 2024 at 05:31:51AM +0100, Christoph Hellwig wrote:
> On Tue, Nov 12, 2024 at 07:50:00PM +0000, Bob Beckett wrote:
> > From: Robert Beckett <bob.beckett@collabora.com>
> > 
> > We initially put in a quick fix of limiting the queue depth to 1
> > as experimentation showed that it fixed data corruption on 64GB
> > steamdecks.
> > 
> > After further experimentation, it appears that the corruption
> > is fixed by aligning the small dma pool segments to 512 bytes.
> > Testing via desync image verification shows that it now passes
> > thousands of verification loops, where previously
> > it never managed above 7.
> 
> As suggested before, instead of changing the pool size please just
> always use the large pool for this device.

Well, he's doing what I suggested. I thought this was better because it
puts the decision making in the initialization path instead of the IO
path.

