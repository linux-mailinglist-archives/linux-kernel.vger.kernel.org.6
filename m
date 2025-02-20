Return-Path: <linux-kernel+bounces-523101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D30AEA3D1FD
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 08:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E218E177755
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Feb 2025 07:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5C931E4937;
	Thu, 20 Feb 2025 07:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nhhnr8LT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528BF1E493C
	for <linux-kernel@vger.kernel.org>; Thu, 20 Feb 2025 07:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740035648; cv=none; b=Emu7Mrg4eVu/H1b/Yzs0VncFsCm6JmrDd2+zz4Ryg6KAB/WNydS7PpTIYRydVmoqOZJ0esLU+ISen5F8MTLcochxHZhhzdpWoI8XiXIoyGRLVXxjtH9z4LlAAA9PjEqZo8vOr6XrWgIgTUyAhHGkRXfzbgkjsaMf38AyhISYPDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740035648; c=relaxed/simple;
	bh=dslbUWrrsVEiz8BClDYjVHsCRYq2aWUj0d7gMWiKElc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r80PAWdvNOS99KUsN1GN0nSPDo20Fc8iLoGmZ/ntAIX4qzly1IRjWUG8dsqouo5eGCZLm0M17Teda+AFZ9A/zqyrujGZaVQYWuuKzSHnu5EST7ncM8oPwdJA6YmZFHTNOYsLeor6yzPjdWvPI9gGni01IGxUUy5XG29k9pS57tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nhhnr8LT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F094C4CED1;
	Thu, 20 Feb 2025 07:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740035647;
	bh=dslbUWrrsVEiz8BClDYjVHsCRYq2aWUj0d7gMWiKElc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nhhnr8LTnY26chfBq1HI+syrTJKxnbOmyyhEMpgHzE4Ph3AxnKGxL4N+kc4Mh4MlX
	 BRpDIeFSGqyR+ab4vvMRvnZtkkTU7O1FoGuEDdNIjpwsjRcm2GR9lTMqjEwH5iOizC
	 jTGUtHsBpfPoxrk2IIHUciR7K3Opr01EM2NdVkxo=
Date: Thu, 20 Feb 2025 08:13:00 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>, linux-kernel@vger.kernel.org,
	"Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH 1/2] Revert "drivers: core: synchronize really_probe()
 and dev_uevent()"
Message-ID: <2025022051-happy-plant-b40b@gregkh>
References: <20250220064647.2437048-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250220064647.2437048-1-dmitry.torokhov@gmail.com>

On Wed, Feb 19, 2025 at 10:46:44PM -0800, Dmitry Torokhov wrote:
> This reverts commit c0a40097f0bc81deafc15f9195d1fb54595cd6d0.
> 
> Probing a device can take arbitrary long time. In the field we observed
> that, for example, probing a bad micro-SD cards in an external USB card
> reader (or maybe cards were good but cables were flaky) sometimes takes
> longer than 2 minutes due to multiple retries at various levels of the
> stack. We can not block uevent_show() method for that long because udev
> is reading that attribute very often and that blocks udev and interferes
> with booting of the system.
> 
> The change that introduced locking was concerned with dev_uevent()
> racing with unbinding the driver. However we can handle it without
> locking (which will be done in subsequent patch).

So shouldn't we take the second patch first to prevent any issues here?

> There was also claim that synchronization with probe() is needed to
> properly load USB drivers, however this is a red herring: the change
> adding the lock was introduced in May of last year and USB loading and
> probing worked properly for many years before that.
> 
> Revert the harmful locking.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

No Fixes: or cc: stable for this?

thanks,

greg k-h

