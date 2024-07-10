Return-Path: <linux-kernel+bounces-247237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0654B92CCEE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 10:25:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87BBB282BF4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 08:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68C0B127B56;
	Wed, 10 Jul 2024 08:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PT2ux4we"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED50A86AE3
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 08:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599951; cv=none; b=d6ZoK3bVbOjUfDEMycZiMXrz8ec3B2O++VaLmfBQQOA3p0Nwd165RXnF5VNE5026WtMICiuDBGbqxtNp3dC8QEJXpDJ/yYPa3GrNFC+5mpZ6w/Zgl+zJcWFmemoV2Ahrlhuz7CD5rzsJ/37Licx2GKuQvMgMwzjvP2l0V+2kclE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599951; c=relaxed/simple;
	bh=Z3mO8rLwuZrQJOOLROTQvSJNPjs5Sg8o/MPbpyKSSCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kQp8jCU7zwjsfjtNr+HP4kGO5WpemXXzmQYXUeErBUig9oQSEExeRRxqDH1ynuVBclclZv9dxNT/BozGfC2xGD+wji1Lv8R4iM4JL/swddqgy0BdRmTMODtDp0Q73wFuzhYuLzMqNmaRsKMS7p9FijzcDaD+s7low3NIdmZ0uK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PT2ux4we; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3010CC32781;
	Wed, 10 Jul 2024 08:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720599950;
	bh=Z3mO8rLwuZrQJOOLROTQvSJNPjs5Sg8o/MPbpyKSSCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PT2ux4weFBhoXqJ4nMNBt4uro2i99RcWh9/LrBYetb6DXIYjSh3LfgoXEiWS9N4n6
	 eWX3ig4OAWGO9Q7eVNTngeKhSYCHA3lOffm96K4NttxlJGssAE62TPv2XRH3748Sgd
	 cN8zJhePprIIf2NY7a05U7+Tb0WegmlJJSnD0FsA=
Date: Wed, 10 Jul 2024 10:25:47 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] zorro: make match function take a const pointer
Message-ID: <2024071038-antihero-fool-9438@gregkh>
References: <20240710073413.495541-2-gregkh@linuxfoundation.org>
 <CAMuHMdW2Y57bXMHjeGt+-vVQs-12DsoeXNYQ80NL+obbCrQiZw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMuHMdW2Y57bXMHjeGt+-vVQs-12DsoeXNYQ80NL+obbCrQiZw@mail.gmail.com>

On Wed, Jul 10, 2024 at 09:51:30AM +0200, Geert Uytterhoeven wrote:
> On Wed, Jul 10, 2024 at 9:34 AM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > In commit d69d80484598 ("driver core: have match() callback in struct bus_type
> > take a const *"), the match callback for busses was changed to take a const
> > pointer to struct device_driver.  Unfortunatly I missed fixing up the zorro
> 
> Unfortunately

Thanks for the review!


