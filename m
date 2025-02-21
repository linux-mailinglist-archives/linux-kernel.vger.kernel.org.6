Return-Path: <linux-kernel+bounces-525199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B3AA3EC4E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 06:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 24CAA19C5497
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 05:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AEE11FBEAD;
	Fri, 21 Feb 2025 05:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rHf8LzUG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E88818D65E;
	Fri, 21 Feb 2025 05:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740116824; cv=none; b=FRhK9Ou1ce17TJuUnSLnvJ6ry1ZA9Qd7ypRA7K7Mk+9yVvKglh5tCwbgduRbGLiSZxYLtPCnAMZ/p7nj3dxrg+MwddFj1NC3ZGREV4KKRVaNFA4ZQxpjWHLSvGU6og34cuMVbDUgjAEPPQ6VvZJRMKheGlH7JnXnpQVCUt5msqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740116824; c=relaxed/simple;
	bh=l9jBLErLyf4zJwWd8xscmSK4QbB8LbkI5blHlU4AACY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3lKtzBqzJGrwJLWzqTm2WM24ZwZIMpfH/DJTYpfwh6dwDK8mFn/m3EU6yYYBw0RyDzc9n2v6PyFiaXwuvAnq5Vrc/3WIcmZQWKSa7+N0jpHhcbexfOevPXM3mFnJfTi0SdltvPmz1NLhpONDFMxrxs3sC96F0slDJ4Ebb4CYu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rHf8LzUG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34A0FC4CEE2;
	Fri, 21 Feb 2025 05:47:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1740116823;
	bh=l9jBLErLyf4zJwWd8xscmSK4QbB8LbkI5blHlU4AACY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rHf8LzUG3U5xnlcpP35NOFiwaSLcTVGkKMjrVLZO/CEJqsFiw8Gl9aqVTZR1jTV2o
	 0lsXya3TU5J8OBl5y68lMOUZ/QsGLpwaKo0a3n6QNb7JH/Sun/iUAyVaEFh921bh2T
	 efN6oSGnZSgCJWysXgtFvVmHAV4FV/3MhLkHY0dM=
Date: Fri, 21 Feb 2025 06:45:55 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hsin-chen Chuang <chharry@google.com>
Cc: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com,
	chromeos-bluetooth-upstreaming@chromium.org,
	Hsin-chen Chuang <chharry@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	Ying Hsu <yinghsu@chromium.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH v7] Bluetooth: Fix possible race with userspace of sysfs
 isoc_alt
Message-ID: <2025022100-garbage-cymbal-1cf2@gregkh>
References: <20250219220255.v7.1.If6f14aa2512336173a53fc3552756cd8a332b0a3@changeid>
 <CADg1FFfCjXupCu3VaGprdVtQd3HFn3+rEANBCaJhSZQVkm9e4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADg1FFfCjXupCu3VaGprdVtQd3HFn3+rEANBCaJhSZQVkm9e4g@mail.gmail.com>

On Fri, Feb 21, 2025 at 09:42:16AM +0800, Hsin-chen Chuang wrote:
> On Wed, Feb 19, 2025 at 10:03 PM Hsin-chen Chuang <chharry@google.com> wrote:

<snip>

> Hi Luiz and Greg,
> 
> Friendly ping for review, thanks.

A review in less than 2 days?  Please be reasonable here, remember, many
of us get 1000+ emails a day to deal with.

To help reduce our load, take the time and review other patches on the
mailing lists.  You are doing that, right?  If not, why not?

patience please.

greg k-h

