Return-Path: <linux-kernel+bounces-345382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 884F898B583
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 09:30:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 443911F21210
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Oct 2024 07:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BD51BD4EA;
	Tue,  1 Oct 2024 07:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Q2EtqIs1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DDE1ACDE3;
	Tue,  1 Oct 2024 07:29:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727767799; cv=none; b=cW6rVYJeqkngm4clo1KQsUyJ1kqfg/UK4xLfvD9RBWirE+BjMnqjTaZZFFMK/ZhW+ZyJ092ar96Ncv8XURBJk4UndBTXogfTPJCybiM9vJFKmxP3ari0MpabFSdaqm8OXpeLpdYbZY6PVXkmLO9x6r5oaQI9xtF7KLZRdooJYRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727767799; c=relaxed/simple;
	bh=yT84ekL+hl6tF8lC3SdrEWmhtB1mVIHa8fq/Svq3ucs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=slCrikMVnQ5Q9QzH2YwvmcghzrsVEGDMRDYzh1Fl9jGCLuNgqNd9NnCFttss5oFdENmZ/9y1vk5N3jIQErOURftTaJkFt+04uX24Eh7LalbrXvWE4mm6IUGbxfApai8ryG06fr0iRk/hstVivS1sWiKqJQA4YIgGwH4vw9j/ikg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Q2EtqIs1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B23BC4CEC6;
	Tue,  1 Oct 2024 07:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727767799;
	bh=yT84ekL+hl6tF8lC3SdrEWmhtB1mVIHa8fq/Svq3ucs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Q2EtqIs1WYE/BHq4SWprvzdvlRDrGNPWuSoHP2C4y6o8ixX1T6vFko2r6U0AVXlC/
	 0NGeaQbgNM3tp+Db0uvpKPKujTCWHpARFabwdFlWNLqoqkQlWv+X14CZug9U56sbJZ
	 M2RAp852UkC0rYslRHvSUnrWzmnrvfNsoMajsfdI=
Date: Tue, 1 Oct 2024 09:29:56 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Marco Felsch <m.felsch@pengutronix.de>
Cc: Rob Herring <robh@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
	Johan Hovold <johan@kernel.org>, linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Subject: Re: [PATCH 0/3] USB-Serial serdev support
Message-ID: <2024100109-maker-ravine-7c65@gregkh>
References: <20240807-v6-10-topic-usb-serial-serdev-v1-0-ed2cc5da591f@pengutronix.de>
 <20241001072453.3xv5sqxaj4zjprnz@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241001072453.3xv5sqxaj4zjprnz@pengutronix.de>

On Tue, Oct 01, 2024 at 09:24:53AM +0200, Marco Felsch wrote:
> Hi,
> 
> gentle ping as this is series is two months old now.

And it was rejected as serdev does not support hotplug which of course,
usb-serial does.

So until serdev is fixed up to handle that correctly, this is not going
anywhere, nor should you want it to as then you would be in charge of
code that does not work properly :)

thanks,

greg k-h

