Return-Path: <linux-kernel+bounces-399514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2969E9C000E
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 09:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B7121C214DC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2024 08:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56E821DED77;
	Thu,  7 Nov 2024 08:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fi2zkr7f"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900391DE8A0;
	Thu,  7 Nov 2024 08:34:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730968495; cv=none; b=i22fL0AitVVDzYK3jZlVLZR/mft6TnpxhWjaTGJ3RbSJVfWJTOuYwee2gBmbMPHLLxm/V3UcO4sJ/5g7nWfeLkEYadeDLSegfU0/+946TbZ10Nm+R2PczyDrky2zy1qy6XEYvcO0hbVdoymsukGeAJ+g3wqKiaHl/vJIw1zQRBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730968495; c=relaxed/simple;
	bh=H1TzH86HG0FbCIerlbUTkX8qGUQsiEnVFyJfnigUSrc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bko/ME8dWho9X8E+wHS/crHIS7PaU/XDFNowcNMhbIdQcUeXN2jmhXKcfVnRoICUIYRDTwWrcT3MdNK8//vjZwaP2PE9l9PU65dCylRO8no6DpJ9wfWGFShPmzHtzRnRqvBqsHav54w2Eb3XmKsc7YOL4rlu8u1qr5euwnCNdn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fi2zkr7f; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FA6C4CECC;
	Thu,  7 Nov 2024 08:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730968495;
	bh=H1TzH86HG0FbCIerlbUTkX8qGUQsiEnVFyJfnigUSrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fi2zkr7fo9w7nFJLY1W0taS+7wj12VRePIQU0wq8DYQrkkJ3Fq1jbSBWUKPDD9Uyy
	 45Xsq6wfIhzzmcm7qTpEf1iYVyy4Z5DJUFLv7EWHo1oPakfg79H8bvqjSuTjoIg4/y
	 MOoBxvxjUxCA39MK+THxzf4qjB9J3vUjbGXgKWT0=
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


