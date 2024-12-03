Return-Path: <linux-kernel+bounces-428872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 120099E1478
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 08:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 07217164997
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Dec 2024 07:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E636199235;
	Tue,  3 Dec 2024 07:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c0wgp/Pm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C4318FDAE;
	Tue,  3 Dec 2024 07:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733211680; cv=none; b=IsOzk0pRvBBda1JF+gF5QhkbGlw/kbjCH36sQ++w/4ELPukdxn6ck487zjh0aCxCVCGGPsfryiFWhl5TYY37kPfQ3UuEbABS2ZoAuYhYykoWMlTo3yVwMyKauVxFZaeI1hTHLV/wBv1dPCPpAMYG+DZks0E7NyiC1MbQVI1UaGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733211680; c=relaxed/simple;
	bh=alQMY1JeGsDZhfQJjYgEBo4XZccAZ4bgXm7m2LwSLyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=txhxHx2EKgyaG7Zep//WruP8tCFNkJVW6M5l3pMiTXOtR4XNEhgfJ1E/Ycpw3tu1RbGjedqIdb/2rzZH66KvHyzX/fHUPoiLP50nXRH6LLkGZwJxHvugtngszPOTR5iuoVuavGdSF0a7bMNhZhPA7jcGj6DLUa4os+vOOcHkXUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c0wgp/Pm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB40C4CECF;
	Tue,  3 Dec 2024 07:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733211680;
	bh=alQMY1JeGsDZhfQJjYgEBo4XZccAZ4bgXm7m2LwSLyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c0wgp/PmPW0Ip6mG/yx+Ze7si4g41KRMWSCw/gMehtr/pK6A50WSufpOvKPkUUFJE
	 q5zy3g4XrthQCN77egXEwL5zHmNYg4ZDFXbwll4ffJlYRzLyfKUyhq211Uki65SjVA
	 XjfJsK3bZkHSd8qUzJOK3UlG1kbCWx0pxwgS0MTw=
Date: Tue, 3 Dec 2024 08:40:47 +0100
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Miao Zhu <Miao.Zhu@synopsys.com>
Cc: "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
	"andre.draszik@linaro.org" <andre.draszik@linaro.org>,
	"rdbabiera@google.com" <rdbabiera@google.com>,
	"m.felsch@pengutronix.de" <m.felsch@pengutronix.de>,
	"u.kleine-koenig@baylibre.com" <u.kleine-koenig@baylibre.com>,
	"dan.carpenter@linaro.org" <dan.carpenter@linaro.org>,
	"emanuele.ghidoli@toradex.com" <emanuele.ghidoli@toradex.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Jianheng Zhang <Jianheng.Zhang@synopsys.com>
Subject: Re: [PATCH V2 1/2] usb: typec: tcpm: tcpci: Make the driver be
 compatible with the TCPCI spec [Rev 2.0 Ver 1.0, October 2017]
Message-ID: <2024120332-flashcard-walnut-e57a@gregkh>
References: <LV2PR12MB5799131A376B5861CF1035D8BD362@LV2PR12MB5799.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <LV2PR12MB5799131A376B5861CF1035D8BD362@LV2PR12MB5799.namprd12.prod.outlook.com>

On Tue, Dec 03, 2024 at 01:08:39AM +0000, Miao Zhu wrote:
> The tcpci driver doesn't fully follow the TCPCI spec even if
> it mentions this spec in its comments.
> - Add two flags into tcpci_data:
>                 RX_BUF_BYTE_x_hidden
>                 conn_present_capable
> - Following flags in tcpci_data are read from device tree in tcpci_probe.
>                 TX_BUF_BYTE_x_hidden
>                 RX_BUF_BYTE_x_hidden
>                 auto_discharge_disconnect
>                 vbus_vsafe0v
> The change makes the driver be compatible with the TCPCI spec and
> therefore won't impact existing HW.
> 
> Signed-off-by: Miao Zhu Miao.Zhu@synopsys.com<mailto:Miao.Zhu@synopsys.com>
> ---
> V1 -> V2: Cleaned up typo and addressed review comments

HTML patches obviously can't be applied :(

