Return-Path: <linux-kernel+bounces-390571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C79689B7B93
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 14:22:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048561C20C7C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 13:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F0D19E7FA;
	Thu, 31 Oct 2024 13:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XSJsEikm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78DAE1BD9FC;
	Thu, 31 Oct 2024 13:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730380910; cv=none; b=u+ky5gD7hqG6/+Xf26tv9+KwHPWMUwyV0BlxXdJBJAztf2c11mVe33DytxHgPAXaehTXg7cSXdwSfT6Hf162E0aO6DjuQ4T3g/xj2QDpjN+pHoMbtI4o3GtOzbDfcKWX/gpf/s7ck6wPelHN0kJGHxy7b/Ib+0nO1xu2NzWQTAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730380910; c=relaxed/simple;
	bh=4jTLrq+ZxELV1BhCEMSn5kaFlxZQ1y2nd9Kj/roH8nE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KUXPxRETsO/hMNiUUzAPDDlaWBDtR1YOFSjtSKa1zhkWHzu8t9yPnzqcVhm1K1bBnuyhHGIKmR8fhp5wVWFOpLbtQmWmqtdS9LxgOc3sfIgIPDmhA1sTj4CaE0OS8yCTQgs2x6D5I6mhjjqUJWv77ms0NDGOD7WPZ4Z9BahFEtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XSJsEikm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3907C4E68D;
	Thu, 31 Oct 2024 13:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730380910;
	bh=4jTLrq+ZxELV1BhCEMSn5kaFlxZQ1y2nd9Kj/roH8nE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XSJsEikmsLzUezNvuCSuEPV4uqgYfwddbe5p9sRMlhpD0VnoYdHk37UIgYwTft6my
	 +TJEpwTuk71IWPO+VFrfHXgS8aF3Tmzia4V3RIGYOL4j5mp9dYjGNELhJb4qIzb2Hx
	 NJUS5dU451xPMydK8wt1TKdywlaGlmciJbg/3nUe+Te93PZc0cG22khCUuAukQU3un
	 pvXwGDyfWfLlzTe6p6Sqe2fo/arxo8WOds3A73TErkdIpAJ5Lloh8PpdbtxKo+IJ4e
	 3FJ3fEQmIb2OwhKneiwgDhQrkG/8lmy2+bWNUShgaaK/6MyiNWX7/8+kQJHiCsGgRT
	 EkrG86dKcLtMA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1t6V7T-000000003d6-2dUB;
	Thu, 31 Oct 2024 14:21:47 +0100
Date: Thu, 31 Oct 2024 14:21:47 +0100
From: Johan Hovold <johan@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] USB: serial: Fix use after free in debug printk
Message-ID: <ZyOEa9VuXVus79Ev@hovoldconsulting.com>
References: <7d0481da-5852-4566-9adb-3a8bb74cb159@stanley.mountain>
 <ZyNI3rQw6q4pkqpD@hovoldconsulting.com>
 <8bad985d-4655-45d2-b448-2b3377a8438c@stanley.mountain>
 <490dc872-fc62-49da-89ff-4eba067df8c0@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <490dc872-fc62-49da-89ff-4eba067df8c0@stanley.mountain>

On Thu, Oct 31, 2024 at 12:39:10PM +0300, Dan Carpenter wrote:
> On Thu, Oct 31, 2024 at 12:35:31PM +0300, Dan Carpenter wrote:
> > On Thu, Oct 31, 2024 at 10:07:42AM +0100, Johan Hovold wrote:
> > > On Thu, Oct 31, 2024 at 09:59:10AM +0300, Dan Carpenter wrote:
> > > > The dev_dbg() call dereferences "urb" but it was already freed on the
> > > > previous line.  Move the debug output earlier in the function.
> > > 
> > > Thanks for catching this, but please use a temporary variable for the
> > > struct device pointer instead of changing the flow.
> > 
> > Why?  The output is the same either way and this way is cleaner code.
> 
> Nah, you're right.  A temporary variable is nicer.  It avoids having two if
> statements.

Yeah, and the debug printk belongs with the return.

v2 now applied, thanks.

Johan

