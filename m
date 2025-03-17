Return-Path: <linux-kernel+bounces-564198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34357A6501C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 14:01:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 889FE173480
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 13:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E00E219A8F;
	Mon, 17 Mar 2025 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FteU8RQf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF078F5E
	for <linux-kernel@vger.kernel.org>; Mon, 17 Mar 2025 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742216491; cv=none; b=A6YvKV72N+ldYHEbJ6kWF55nVIFYt/hRjxoezgP6Ls8UpfvrHflSXY3ZCCvPWb89aVn/acgbq566avciGhwejppn67rf7eBIvHwfuKG9qpw/q/XNcZZyzbrKo9jp4NQimC3I9tdAQXbEocUmOGD+w4ndjLkEhKutv7EZ/cQKggc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742216491; c=relaxed/simple;
	bh=QN4GEEW4Ve/ptQLgX6fR434HPkvmawvYjJAWVAfqaRo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JojTXrFjOVBGPVQI7II5PGI6q9RmLQ3jwLm5UWOnLwHYI5dJ52k/uVlHneYbJC3OAKwjp84M10drlLUNiRoHzehSvbUO2ZkP9N6Ast4v4zQHz1BcxZnVJ98/FAg6CzX4P+lT7+CUBo/oKZ9WOjOVdhiFYL+BkrNHy1q2ATfzb00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FteU8RQf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB94C4CEE3;
	Mon, 17 Mar 2025 13:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742216491;
	bh=QN4GEEW4Ve/ptQLgX6fR434HPkvmawvYjJAWVAfqaRo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FteU8RQfVDPYV1t/PCIKXjU11aO89yLoy42QmX4tOjeJ87NZ0IG9h7l5rnXy37XMf
	 iQF5NoF/XfP0Mk0jknRChm3ZHLlPQxhhyFfHnzfG4SPBgfTFrRA7TC2bdgjt+an+EL
	 rhRrIU1oE4j3JboXHJXxjtMacYUwAyrZpMXc+H6g=
Date: Mon, 17 Mar 2025 14:00:04 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 9/9] regulator: dummy: convert to use the faux device
 interface
Message-ID: <2025031716-decaf-overhead-c56c@gregkh>
References: <20250317-plat2faux_dev-v1-0-5fe67c085ad5@arm.com>
 <20250317-plat2faux_dev-v1-9-5fe67c085ad5@arm.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317-plat2faux_dev-v1-9-5fe67c085ad5@arm.com>

On Mon, Mar 17, 2025 at 10:13:21AM +0000, Sudeep Holla wrote:
> From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Why are you resending my patch back to me?

> The dummy regulator driver does not need to create a platform device, it
> only did so because it was simple to do.  Change it over to use the
> faux bus instead as this is NOT a real platform device, and it makes
> the code even smaller than before.
> 
> Reviewed-by: Mark Brown <broonie@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Message-Id: <2025021027-outclass-stress-59dd@gregkh>
> (sudeep.holla: Made dummy_regulator_driver static)

So this is a new version?

And as was pointed out, this is already in my tree, and there's a
conflict in linux-next with it.

confused,

greg k-h

