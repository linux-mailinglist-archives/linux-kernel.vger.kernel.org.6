Return-Path: <linux-kernel+bounces-247618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C019092D201
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 14:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7686F28366D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 12:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C0C1922D7;
	Wed, 10 Jul 2024 12:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2Den/WGY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F3718FDD4;
	Wed, 10 Jul 2024 12:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720616036; cv=none; b=EKOc4/7wnrL4qMa2dyPCY+i9XsAeGrcSlKyq2H+Cezr++QnIJZxxYNioH5eNdWMUR6vn4oswAHMHDrYvqSDJuVbjlnTDai9YjP8t/HA19V89JcfX/FyvnRKYo1FRWEaKKBgHRN/lz5XqjSFeb/Wcq0DUJrLflM/f/yY0hNiLqXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720616036; c=relaxed/simple;
	bh=bJytAGwJkb5+HzIS7Gvp673v6K6DW4WaBn/JLdIV3KM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d7yI4P87IK3lT5P3AlBpVJapFL4Jw7t+o1xCRI0tcxxcW81NcQrbEd2CRxAKjTY0ETAxY7KvgDJzDXKWmkRvSOHpHjVzlLiUe3MT5OpkrjAfXIvqCmkK1vOFDu8dqy45Q3Lj+EPdVv4G+1Piz/FuVyZbMChdqpJQvzVDPP7zDyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2Den/WGY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B824C32781;
	Wed, 10 Jul 2024 12:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1720616035;
	bh=bJytAGwJkb5+HzIS7Gvp673v6K6DW4WaBn/JLdIV3KM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=2Den/WGY0sejh17n67j3SEyKdZmX0zrIIMri8BnUZnE82L/yTsFi+prcUy4YBfeRM
	 FG9pK6w8RlwwOj13V1yduyuqG3VCkI2vDFxpHKmqqJ6RR7MyIsWWbosRJtGx/M+WRp
	 ILCy9eq20OwMQ5Ku6UIlLkJaKRAt6jFcXBHJu+ls=
Date: Wed, 10 Jul 2024 14:53:53 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
	linux-serial@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] serial: 8250: move mmp|pxa uart earlycon code and add
 xscale earlycon
Message-ID: <2024071028-deskbound-crisping-7f69@gregkh>
References: <20240706101856.3077-1-jszhang@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240706101856.3077-1-jszhang@kernel.org>

On Sat, Jul 06, 2024 at 06:18:56PM +0800, Jisheng Zhang wrote:
> There are two other drivers that bind to "mrvl,mmp-uart": the 8250_of
> and the 8250_pxa. The previous one is generic and the latter is binded
> to ARCH_PXA || ARCH_MMP. Now we may have pxa programming compatible
> HW to support, making use of the generic 8250_of seems a good idea.
> However, there's no earlycon support if we go with this solution. So
> move the mmp|pxa-uart earlycon code to core 8250_early.c.
> 
> At the same, add xscale earlycon support too, only build test since
> I have no xscale machine any more.

When you have an "and" in the changelog, that means it should be 2
patches.  Please split this up into one that does the move, and one that
adds the new entry.

thanks,

greg k-h

