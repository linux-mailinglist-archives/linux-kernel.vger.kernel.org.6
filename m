Return-Path: <linux-kernel+bounces-562515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1430FA62A45
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 10:36:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47D043B43AA
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Mar 2025 09:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE6A1F63C1;
	Sat, 15 Mar 2025 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rXbfcKdG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2331B1F3FC2;
	Sat, 15 Mar 2025 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742031348; cv=none; b=pHxZPdyhye6EC7Q+4CzPdlF3zt8qJVEJcnB2/cD0detNfa8wI6zJxrkHCFKymC9Boprj0EH01rCCCarEPlf+NbN390sZE81vG3VfM89ca4ggtLtT8IXjwJwQWDcNt6Iv54/+hl+9KHu4qmB710OWUPzsCjma4ujaEYNL80e6Mog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742031348; c=relaxed/simple;
	bh=ky78TS5sld/MtIdgsOX/Ix4iThb34zSifCYWix80Zd0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rpuoHQEqLoLFRl5j1ilZlUeUV4/xxnMadYL6uilweH75Ja1hbEtfq0uQnDLBWZ2yvBwlmfaKUZbpsHXPBSiGuO7rSWLhJchefzTu0VLmQlr/rtp5w7UZhNijDOo0YlX52L/63S6SGSqm6oT1Y0D4x2jcTZpbjSTyDt185VuRzpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rXbfcKdG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A464C4CEE5;
	Sat, 15 Mar 2025 09:35:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742031347;
	bh=ky78TS5sld/MtIdgsOX/Ix4iThb34zSifCYWix80Zd0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rXbfcKdGerlWztVZPJtMKxS34/VJuZkkdkYZnLAjk/SE3PZnKLlj4SBa47y8lmnmk
	 tT9i1F2scPccgx8i8cBAqfBSwV61l2SoepS5qE3ggogoSOEan1AGJe4qfqco97gwfL
	 bBl61103TBQnU7HQJc9IWq7sbFEHPfUnVB9JJXFU=
Date: Sat, 15 Mar 2025 10:34:29 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: daixin_tkzc <daixin_tkzc@163.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
	matthew dharm <mdharm-usb@one-eyed-alien.net>,
	linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
	linux-kernel@vger.kernel.org
Subject: Re: Re: [usb-storage] Re:Re:[PATCH] usb: storage: Fix `us->iobuf`
 size for BOT transmission to prevent memory overflow
Message-ID: <2025031514-sacred-playback-1dd4@gregkh>
References: <20250311084111.322351-1-daixin_tkzc@163.com>
 <2b6c4aa7.b165.1958f6b7a3a.Coremail.daixin_tkzc@163.com>
 <814316b6-013b-4735-995d-b6c0c616c71b@rowland.harvard.edu>
 <1681f087.2727.195927b7ccb.Coremail.daixin_tkzc@163.com>
 <516c8f89-45f2-4d3f-b1e7-29aecfc8cd3c@rowland.harvard.edu>
 <6e125c5c.2541.195990d2daa.Coremail.daixin_tkzc@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e125c5c.2541.195990d2daa.Coremail.daixin_tkzc@163.com>

On Sat, Mar 15, 2025 at 05:05:32PM +0800, daixin_tkzc wrote:
> 

Again, please do not send html email, it is rejected by the mailing
lists.


