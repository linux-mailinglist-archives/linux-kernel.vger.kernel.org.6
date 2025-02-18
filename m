Return-Path: <linux-kernel+bounces-519765-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF47A3A19F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 16:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 473F93A37F1
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Feb 2025 15:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DA1826D5CA;
	Tue, 18 Feb 2025 15:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XtFuNJWz"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE61263F36
	for <linux-kernel@vger.kernel.org>; Tue, 18 Feb 2025 15:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739893445; cv=none; b=P0efldrIOXgxaH7IrrdXACosN5rqULNbaM2wjCyk/ctNSQVxAy2cbuyXS8M0X33+BHU2+Md6maldOIDGScLe2XmHKpKI7J3mLs/l5bk7VR04tJbC0mIGexx73iLWY75CPFJ/8pt7yOi34pAkpLeqWXI2FwhIMES3K1rEFNQkIJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739893445; c=relaxed/simple;
	bh=jzZu4W55cRQ7Nlz0usvWffw+R56yQ33h0B1doS9KmVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ACrGoTsEFPQIPK0hzq3VZs7pFjnP6OlraOQHFRlrwnk4UdAYFS401FW0UOfRuzPDWaRjzXGCrOjcuz/Y1Uhf1Ip5XMIMzI+/nzeI/taUnAGhQaAhb8qBcoseqUO1N0uC9Vg3dotK5xfVCIhOc8Q/0uVvDKBBOzfmkv+1nAVsObE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XtFuNJWz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D498C4CEE2;
	Tue, 18 Feb 2025 15:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739893445;
	bh=jzZu4W55cRQ7Nlz0usvWffw+R56yQ33h0B1doS9KmVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XtFuNJWzsU4fSucSYS3ZXCwwqA8O8tQzkXcZcVhCMnetv+dmWECIb/I3DSX7r6D9e
	 ueHkqj0CqX3O8K8yIbYQL4jWyYj/tp6glG42EwLpkhSEK8Y7B4vqzw5kC0QCm04oO4
	 39iZ52WBFy14Imsal/hnlxI+xYh1oVToluxYBVRDIymgVPSI+pvpAbIN0J3yFZFblf
	 sHB/yptnoP0jk84Z0440twMOw3bJyUJJDTBU+bK1Rxx4QIhOo2YOqSqlCJw3A6DOxe
	 lt4amR/NWZ33bS1xWv+UPGue2gQGShlT6DLQkx4X+/+mNoZJWwUahS13QIpq9pfHKA
	 ANsZfMrAJLnOw==
Date: Tue, 18 Feb 2025 08:44:02 -0700
From: Keith Busch <kbusch@kernel.org>
To: Christopher Lentocha <christopherericlentocha@gmail.com>
Cc: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme-pci: quirk Acer FA100 for non-uniqueue identifiers
Message-ID: <Z7Sqwg-pY9Aj3dGh@kbusch-mbp>
References: <381a838c-bb8a-8e95-c35a-343601cbe8e3@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <381a838c-bb8a-8e95-c35a-343601cbe8e3@gmail.com>

On Tue, Feb 18, 2025 at 08:59:29AM -0500, Christopher Lentocha wrote:
> 
> In order for two Acer FA100 SSDs to work in one PC (in the case of
> myself, a Lenovo Legion T5 28IMB05), and not show one drive and not
> the other, and sometimes mix up what drive shows up (randomly), these
> two lines of code need to be added, and then both of the SSDs will
> show up and not conflict when booting off of one of them. If you boot
> up your computer with both SSDs installed without this patch, you may
> also randomly get into a kernel panic (if the initrd is not set up) or
> stuck in the initrd "/init" process, it is set up, however, if you do
> apply this patch, there should not be problems with booting or seeing
> both contents of the drive. Tested with the btrfs filesystem with a
> RAID configuration of having the root drive '/' combined to make two
> 256GB Acer FA100 SSDs become 512GB in total storage.

Thanks, applied to nvme-6.14.

