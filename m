Return-Path: <linux-kernel+bounces-232508-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F49F91A9FF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 16:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7071F25B06
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jun 2024 14:55:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D676197A6A;
	Thu, 27 Jun 2024 14:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KXOSHtQ4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98AB719645E;
	Thu, 27 Jun 2024 14:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719500090; cv=none; b=O7zTUFoBNkrSssTupU0jeUyi/wGv+sARH+CsthALqPgc//aG70pw7BE9lCbokzykWsv0PTRQlGz9Dc3LYBakonInfS6bqDQleYohlvIZQ9K0MMznt9X+ue5CYjdHjS9t9QqXSiug+6ey8JsGkka+JvOUzTgvdA+uUzh9kkaU0jE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719500090; c=relaxed/simple;
	bh=SsmqDpFLU55wekfIzIylJo3ky20eatPOkukJ2Xq2Rl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZgNhHV+EBqSB1CkfbgOOHrEaytASaoqlW8fkfoWN/nRcotlEF0le5Ou5ox7qywdYqe7sExVi7TCp0BrJkreDzFaoBMR32efOvEQxScch3yl2F0Od+O8Ket/5vFD9MQoJ/vjUwN+TVKRoFlPbNctqmHNu6BGJ9YoWXIFTuGvPpDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KXOSHtQ4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4102C2BBFC;
	Thu, 27 Jun 2024 14:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719500090;
	bh=SsmqDpFLU55wekfIzIylJo3ky20eatPOkukJ2Xq2Rl4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KXOSHtQ4EWS38UWNcRRQyjhJnAi9rpP0qW0jNqA7dL72G7YAYA3L+aptgh3xz8UYe
	 V5n2D24xeyagwRH7XxvRwycF/e+YUvCtn/MNk6uS+V4kSgmRn2jD8cxV8mv1/N4eQx
	 kEbe9mFMfPfav0OXxPQVHL7kzEgcSJL/0c1q23To=
Date: Thu, 27 Jun 2024 16:54:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Nikita Travkin <nikita@trvn.ru>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/7] usb: typec: ucsi: rework glue driver interface
Message-ID: <2024062717-foster-document-eb2f@gregkh>
References: <20240627-ucsi-rework-interface-v4-0-289ddc6874c7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240627-ucsi-rework-interface-v4-0-289ddc6874c7@linaro.org>

On Thu, Jun 27, 2024 at 05:44:39PM +0300, Dmitry Baryshkov wrote:
> The interface between UCSI and the glue driver is very low-level. It
> allows reading the UCSI data from any offset (but in reality the UCSI
> driver reads only VERSION, CCI an MESSAGE_IN data). All event handling
> is to be done by the glue driver (which already resulted in several
> similar-but-slightly different implementations). It leaves no place to
> optimize the write-read-read sequence for the command execution (which
> might be beneficial for some of the drivers), etc.
> 
> The patchseries attempts to restructure the UCSI glue driver interface
> in order to provide sensible operations instead of a low-level read /
> write calls.
> 
> If this approach is found to be acceptable, I plan to further rework the
> command interface, moving reading CCI and MESSAGE_IN to the common
> control code, which should simplify driver's implementation and remove
> necessity to split quirks between sync_control and read_message_in e.g.
> as implemented in the ucsi_ccg.c.
> 
> Note, the series was tested only on the ucsi_glink platforms. Further
> testing is appreciated.
> 
> Depends: [1], [2]
> 
> [1] https://lore.kernel.org/linux-usb/20240612124656.2305603-1-fabrice.gasnier@foss.st.com/
> 
> [2] https://lore.kernel.org/linux-usb/20240621-ucsi-yoga-ec-driver-v8-1-e03f3536b8c6@linaro.org/
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Changes in v4:
> - Rebased on top of Greg's tree to resolve conflicts.

Nope, still got conflicts, are you sure you updated properly?  Patch 1
applied, but #2 did not.

thanks,

greg k-h

