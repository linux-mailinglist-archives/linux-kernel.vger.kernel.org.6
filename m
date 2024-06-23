Return-Path: <linux-kernel+bounces-225951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F075E913846
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 08:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76759B227BE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jun 2024 06:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E211DFF8;
	Sun, 23 Jun 2024 06:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="V3LTrF8S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6A4883D;
	Sun, 23 Jun 2024 06:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719123378; cv=none; b=Ct8z5MZOYQ/gh8HO7nnbWsBuDpEHn2K+9fxQFV/73tYJ6fpTdjNijaBBGPMKjl+WcdeVWLO38Jn1a+waM6yQNVLVYeD7mzyl400XjplTKaoUKfjVlcyEB22wlmL4ZQZfPabwKjX7lAaRKSs4bfmiVdeFqHyuFxAG6fVIuax4Do0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719123378; c=relaxed/simple;
	bh=6GMiZdluTgdZf10SBwq86OdctxPd0I67Qo3uoQ8hXhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uwTgkz3Uh+0SGHrUvb0GwGH+i6sYOGsIFakT1sye+sJEBB73TqHXX48Zu2qrttGHLOufKXOr7CiAO8ab+nKiNU1WlespNhV9bXjcy5Q1CmVez5/lpQamENmka4/gOLMB+hxkYp1q3O+qzRbiqh9Af0JSq8wZuucIHwolaVRTEYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=V3LTrF8S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7174C2BD10;
	Sun, 23 Jun 2024 06:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719123377;
	bh=6GMiZdluTgdZf10SBwq86OdctxPd0I67Qo3uoQ8hXhw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=V3LTrF8S/4D9rVU1oM29aoRQpL5NVg+vi/LeoZatbGiuwffPbzb/1BAccKXpDd8sY
	 V6tvY9d9ceO5Uwm5ENzZ7CONpPK4IfgA/Wo2jkP8lOiR/lDxtec/Ie19fhnPsIh+Vt
	 wAl3NWeA99+eFszcC94cTIXpjGHM7KROsTqDzeVM=
Date: Sun, 23 Jun 2024 08:16:20 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Ma Ke <make24@iscas.ac.cn>, linux-aspeed@lists.ozlabs.org,
	linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Andrew Jeffery <andrew@codeconstruct.com.au>,
	Joel Stanley <joel@jms.id.au>, Neal Liu <neal_liu@aspeedtech.com>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: gadget: aspeed_udc: validate endpoint index for ast
 udc
Message-ID: <2024062313-automated-theology-3f62@gregkh>
References: <20240622095618.1890093-1-make24@iscas.ac.cn>
 <bb23a7b0-dce6-4359-995a-2c12cf30cfff@web.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bb23a7b0-dce6-4359-995a-2c12cf30cfff@web.de>

On Sat, Jun 22, 2024 at 05:24:25PM +0200, Markus Elfring wrote:
> > We should verify the bound of the array to assure that host
> > may not manipulate the index to point past endpoint array.
> 
> * Can an imperative wording be more desirable for such a change description?
>   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10-rc4#n94
> 
> * Will any tags (like “Fixes”) become relevant here?

Hi,

This is the semi-friendly patch-bot of Greg Kroah-Hartman.

Markus, you seem to have sent a nonsensical or otherwise pointless
review comment to a patch submission on a Linux kernel developer mailing
list.  I strongly suggest that you not do this anymore.  Please do not
bother developers who are actively working to produce patches and
features with comments that, in the end, are a waste of time.

Patch submitter, please ignore Markus's suggestion; you do not need to
follow it at all.  The person/bot/AI that sent it is being ignored by
almost all Linux kernel maintainers for having a persistent pattern of
behavior of producing distracting and pointless commentary, and
inability to adapt to feedback.  Please feel free to also ignore emails
from them.

thanks,

greg k-h's patch email bot

