Return-Path: <linux-kernel+bounces-399515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D2139C000F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:36:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF2F91C217A1
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE81F1DF258;
	Thu,  7 Nov 2024 08:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="b5+O+zck"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 230FE1DE4F9;
	Thu,  7 Nov 2024 08:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730968497; cv=none; b=mvH7d6g/fE/jqlrLs8U7ql8DknTMerw4y9muuVfC5sRJecEc2SNxlZ/bXnXqix5xLa3ApldZRnJCeK5cYnBkBg4lPY/xb4y6kNwxdfAzoE6b0LoXqV3igeJvMnOUvDjgZKdnWTBd8aawcSd3wy9Uq6PbcXNHB7yV6USYJa192lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730968497; c=relaxed/simple;
	bh=H1TzH86HG0FbCIerlbUTkX8qGUQsiEnVFyJfnigUSrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=esNspcnrNdUPj8VI2qJkjBMRPoYGRGfkEZg5tlK1D7RZICaU2iD/KRZ9FXRg+VP5adEe1W0RdrPJ+T6mkp/QkqJhsgkXIWug4ZOIz/xop8g9V9XOfVMx7qOU6NIqIrLiPyt8B9v6f+w2PeHxXMWfweGx2x/ZYbvC+ESnHIqJgGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=b5+O+zck; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ACB8C4CECC;
	Thu,  7 Nov 2024 08:34:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730968496;
	bh=H1TzH86HG0FbCIerlbUTkX8qGUQsiEnVFyJfnigUSrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b5+O+zckGBQ7sVu+YNczqIWKY5xMv731nv0DfLq651dyspohSQ2C4o5HiLxe7bZFP
	 HKo/z4C0zXdj+Q7GAe56jyktmLLk67SAZ7AUgKaQiZQPnhrZdOyPNx7iwtYOZ9nqpV
	 V9xKiYOPTlZtREUT/AlhiGy0IWQhiYCFY4O1TWzs=
Date: Thu, 7 Nov 2024 09:29:18 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Qiu-ji Chen <chenqiuji666@gmail.com>
Cc: dtwlin@gmail.com, johan@kernel.org, elder@kernel.org,
	greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org, baijiaju1990@gmail.com
Subject: Re: [PATCH v2] greybus/uart: Fix atomicity violation in
 get_serial_info()
Message-ID: <2024110706-stammer-brought-662c@gregkh>
References: <20241106095819.15194-1-chenqiuji666@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241106095819.15194-1-chenqiuji666@gmail.com>

On Wed, Nov 06, 2024 at 05:58:19PM +0800, Qiu-ji Chen wrote:
> Our static checker found a bug where set_serial_info() uses a mutex, but 
> get_serial_info() does not. Fortunately, the impact of this is relatively 
> minor. It doesn't cause a crash or any other serious issues. However, if a 
> race condition occurs between set_serial_info() and get_serial_info(), 
> there is a chance that the data returned by get_serial_info() will be 
> meaningless.

You have trailing whitespace in your changelog text for some reason :(


