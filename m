Return-Path: <linux-kernel+bounces-329245-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D71F978F15
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 10:20:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E32E528668A
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Sep 2024 08:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DBB713C9A2;
	Sat, 14 Sep 2024 08:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="txCSSywK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81084C8E;
	Sat, 14 Sep 2024 08:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726302005; cv=none; b=HW8wQAxHhHM5U1mU4wluuwSHcvVYADD49NA5Ai1lAJrtMNPGXhQ8Ri4vXuAqmQF7HryJenHODE5jnamO50m08ug6OIru221QmN0GhWj1ThJK4A51843q9vyaDu8tzeKn8/k4okAKfq6Qa9RYV7Qglt9MUTZG3WYxUyTdyXVDVdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726302005; c=relaxed/simple;
	bh=BdEHr6MlMYdUc4wPc5gSz110F+OA37NuTp+H2YTZXVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ChuAx0ZRu8FHVUmMJI9bOxlgtmPt34XxhZ9yV8UhcqRTP1UuOdd0qPwrIrtzY1N9K0hT42mPZf9jKrT3SrqB1o8lFXoIfB5XMqJ2Ov0XXfTbnozKQcbDbD9haax5NnwqDefYW/6PHkUirVPCSRiaNdN5eiRNy1yLiY1Hb0g9hfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=txCSSywK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEBADC4CEC7;
	Sat, 14 Sep 2024 08:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726302005;
	bh=BdEHr6MlMYdUc4wPc5gSz110F+OA37NuTp+H2YTZXVY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=txCSSywK9pnDInzJ7b+U1EHHW3koj3HtEW2UDGcAkLIKl3YXXvt3olW+Trw3VEHff
	 ialW4hHbjJy/TT2+DsqX8Eji2V8T69e6ONxW/hMkIUZQLaG9rTDJRHwSxFqa9vZWCU
	 ZY9zr/VT/m/c9GYkrOSn4rZIjzuCgWoC5K82A0s4=
Date: Sat, 14 Sep 2024 10:20:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Abhishek Tamboli <abhishektamboli9@gmail.com>
Cc: skhan@linuxfoundation.org, rbmarliere@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: octeon: Use new initialization api for
 tasklet
Message-ID: <2024091424-glisten-unmanned-bb8f@gregkh>
References: <20240913191734.805815-1-abhishektamboli9@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240913191734.805815-1-abhishektamboli9@gmail.com>

On Sat, Sep 14, 2024 at 12:47:34AM +0530, Abhishek Tamboli wrote:
> Use the new api DECLARE_TASKLET instead of DECLARE_TASKLET_OLD
> introduced in commit 12cc923f1ccc ("tasklet: Introduce new
> initialization API").

This says what you are doing, but not why you are doing this.

Why is this needed?  What bug does this fix?  The code is the exact same
afterward so why should this be accepted?

thanks,

greg k-h

