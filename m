Return-Path: <linux-kernel+bounces-545097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA011A4EA00
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 18:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92E148A4745
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Mar 2025 17:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1BC28D098;
	Tue,  4 Mar 2025 17:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sFL5J3qG"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536DF28D07A
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 17:03:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107809; cv=pass; b=Xbl9rBC8nzi/cTVI0ygJS20+kdo0+zpp5UevSDXCW2g/7zAMHPNrnUQpFTTMKGO3E7luKxMA2SNAK0LfMLEldq1oX4zrrndOkH5CnQEBl8TtDHyXGDQibXbcvZ3VyWlXCOnu3atvhrupbSKBYsrMF5UXMih3g8q1orhp3IROyfk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107809; c=relaxed/simple;
	bh=lrlCsavUJz6KOvb58RsHd0PRwT4FfA6Nqrz+IF8RGVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DftYRzC63JffNvLBmMnEptaILFuNNYsgnjPQW9alpPGa86REKWbuEgHZX+yoAaSK76RoBLxgfgnAeWU7HFrmGM8D4W05wzfz+Ss3FYuGMe8l8Zzcw9ztvPruKQtK+TwbJ5AxWRrPVsXfL0qfAcyrOcW1AZOzupbiQ1oQPPEbfhY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sFL5J3qG; arc=none smtp.client-ip=10.30.226.201; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 7D09640CEDC2
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 20:03:26 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=sFL5J3qG
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fzh3rs4zG19C
	for <linux-kernel@vger.kernel.org>; Tue,  4 Mar 2025 18:41:20 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id D69854277B; Tue,  4 Mar 2025 18:41:12 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sFL5J3qG
X-Envelope-From: <linux-kernel+bounces-541882-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sFL5J3qG
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 8971C41D84
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 17:08:33 +0300 (+03)
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 60C1E2DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 17:08:33 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED71D18952AB
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 14:08:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 657B3213E67;
	Mon,  3 Mar 2025 14:08:02 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43EA98489;
	Mon,  3 Mar 2025 14:07:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741010879; cv=none; b=Xq+lLAKBFXDRXJZw+BBnvxK/+QYD/Z1MrpUKs8wQwyaNQoEhYJ5HMXGBuBIkoYHD0XuGfOjWYhIo5U5/KL4dJv9s/9bcYScXR3fBq9Tz4yIN3xUN/QMppxtVat1hGqvFl+TRMX/tEROCywX3KcexHmrRxAyA44w7TmdC5mCPqb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741010879; c=relaxed/simple;
	bh=lrlCsavUJz6KOvb58RsHd0PRwT4FfA6Nqrz+IF8RGVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ly8uYygHIvPuM0kKzMFwpupnylCIJbDaPPYi6KakttaA98OCrlsD85hYTQnQlsGnoNc0+YmXvKWR75reliOurew+cyuRWceeRTUxv+qzoUu/zSzexNknK2tpq3F/H64omAoFO1oyQcrhvvcwD6kw5ZCrSL2ZYHu+9ntAYv13UiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sFL5J3qG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 270AFC4CED6;
	Mon,  3 Mar 2025 14:07:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741010877;
	bh=lrlCsavUJz6KOvb58RsHd0PRwT4FfA6Nqrz+IF8RGVI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sFL5J3qGhSOTmKTqbjuLFlDmWsIydsLfhFPeoLzlZQ48ALrzWHduW9Qd6xfDUUx1S
	 byZzLv1g18d6A+svIo0LWuCylTMJKurfmTqXFilz4mZXQKT/aH+pjlFy0F2YEQB1Yx
	 bXoa9mCcwisDGtT+MHnbRzFt8Z+KrxXeynwXofwc=
Date: Mon, 3 Mar 2025 15:07:53 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	=?iso-8859-1?Q?Herv=E9?= Codina <herve.codina@bootlin.com>,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>, stable@vger.kernel.org
Subject: Re: [PATCH RESEND v2] drivers: core: fix device leak in
 __fw_devlink_relax_cycles()
Message-ID: <2025030332-tumble-seduce-7650@gregkh>
References: <20250303-fix__fw_devlink_relax_cycles_missing_device_put-v2-1-3854d249d54e@bootlin.com>
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250303-fix__fw_devlink_relax_cycles_missing_device_put-v2-1-3854d249d54e@bootlin.com>
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fzh3rs4zG19C
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741712534.06322@0dCFOP+vv92vt1QgcFr3nQ
X-ITU-MailScanner-SpamCheck: not spam

On Mon, Mar 03, 2025 at 10:30:51AM +0100, Luca Ceresoli wrote:
> Commit bac3b10b78e5 ("driver core: fw_devlink: Stop trying to optimize
> cycle detection logic") introduced a new struct device *con_dev and a
> get_dev_from_fwnode() call to get it, but without adding a corresponding
> put_device().
> 
> Closes: https://lore.kernel.org/all/20241204124826.2e055091@booty/
> Fixes: bac3b10b78e5 ("driver core: fw_devlink: Stop trying to optimize cycle detection logic")
> Cc: stable@vger.kernel.org
> Reviewed-by: Saravana Kannan <saravanak@google.com>
> Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
> ---
> Changes in v2:
> - add 'Cc: stable@vger.kernel.org'
> - use Closes: tag, not Link:
> - Link to v1: https://lore.kernel.org/r/20250212-fix__fw_devlink_relax_cycles_missing_device_put-v1-1-41818c7d7722@bootlin.com
> ---
>  drivers/base/core.c | 1 +
>  1 file changed, 1 insertion(+)

This was applied to my tree on Feb 20, right?  Or is this a new version?
Why was it resent?

thanks,

greg k-h


