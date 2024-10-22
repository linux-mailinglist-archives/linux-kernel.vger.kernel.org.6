Return-Path: <linux-kernel+bounces-376020-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5299A9EB4
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB8E21C24636
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 09:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C87841990AE;
	Tue, 22 Oct 2024 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZbgU/VSk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237EF155330;
	Tue, 22 Oct 2024 09:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729589955; cv=none; b=Qxnb5FcxwoxwAy7fue/x6iTWEu+NHhu1tdOR5uKmPgJfDcm+TUFALFY/baGQyQjM2FS/GL7YR3RbMC9F6DZAVOebdw+RBJ2eQ4MMPmnQr6gIUCUwk+roOzRgLxNvpZjpqaqfW2W89zeusPG2+kgNIvYMdXLG4B8G5QA+/ejVEmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729589955; c=relaxed/simple;
	bh=Rni9goMB3zxSM7Y/0slwXKaptGNj+eHzLCZ1kyAubNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YJNvx+3/Mb1rhV3N8t/Pdgt3zDdtnTUFbZ8FdmAXp7UhRn1ZfBlbPbcXwL2agzHAYmohDYxjvxuIsBe2EzC0Z+m+VJdU79xQmx9kq5GL8lzhOMArd82VDkwJUiO+Gn1eqgmJTMOAfXSmikAeOU5nz1nii4GhAkJbMpYCr09ed3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZbgU/VSk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB3FC4CEC3;
	Tue, 22 Oct 2024 09:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729589954;
	bh=Rni9goMB3zxSM7Y/0slwXKaptGNj+eHzLCZ1kyAubNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZbgU/VSkCq+B45uM5b4/l9PWGqV4RNWWTi1RwL7KpTH/pajzrqxX+vmILDkLTcbNo
	 Hv2ChyRF1PtdHJ/Fo+e/GHwEnXVXDFXK4QhxRroFwg5V2yU5RXyHa6i/twHGDDa9Q+
	 9WhzlzI0q/alBN1PzMDw52z1g+vziKd2RWw/QOpY=
Date: Tue, 22 Oct 2024 11:39:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: huanglei814 <huanglei814@163.com>
Cc: mathias.nyman@intel.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, huanglei <huanglei@kylinos.cn>
Subject: Re: [PATCH v3] usb: core: adds support for PM control of specific
 USB dev skip suspend.
Message-ID: <2024102239-stainable-favored-558b@gregkh>
References: <20241022090905.9806-1-huanglei814@163.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241022090905.9806-1-huanglei814@163.com>

On Tue, Oct 22, 2024 at 05:09:05PM +0800, huanglei814 wrote:
> From: huanglei <huanglei@kylinos.cn>
> 
> All USB devices are brought into suspend power state after system suspend.
> It is desirable for some specific manufacturers buses to keep their devices
> in normal state even after system suspend.
> 
> v2: Change to bool type for skip_suspend.
> v3: Rebase and update commit message.

As per the documentation, this needs to go below the --- line.  Also,
you changed more than just the bool type in v2 :(

Please fix up and do a v4 after waiting a while for others to review
this.

thanks,

greg k-h

