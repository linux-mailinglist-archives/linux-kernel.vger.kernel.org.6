Return-Path: <linux-kernel+bounces-555953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95835A5BEB7
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 12:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D5766170C56
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 11:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C06238172;
	Tue, 11 Mar 2025 11:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0uWgT4A9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E242528FD
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 11:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741691840; cv=none; b=pMmNTVGru25RHwxSw48NEoOL4I0GWeHwvfQs9K1rmSBiHay+hx315gb0pXoPd+aWrjMBxQ7L0pexEodt2iCOHdIDNxXkkPDlY0JiUcsxq7gD7AHjek3rqYBkAgvzJ5lsayJ61klZQTE/hJszm6wvfrjYCtrSf5YjPkoVri9P3sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741691840; c=relaxed/simple;
	bh=OM09r8o7osyfiRG+Tl7EaqHM/urKajqaYfr9L6tuhl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BP5KXQhtr/ehgbnobxONtXhz0RMb3J38eYi7SdGnFXlP5mSfC36Pro7k2au7gi50cEg2puZUeTjvx+4pDBLr1aYq4tSNAtH9RGryA0kF69fXoGkMnyD2RhY3gV1WOHbRhSKmH981F2Nn/C9GbNWxcsJsWT93Yjt6JvO34B3QXVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0uWgT4A9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5543C4CEE9;
	Tue, 11 Mar 2025 11:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741691840;
	bh=OM09r8o7osyfiRG+Tl7EaqHM/urKajqaYfr9L6tuhl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=0uWgT4A9MQsvKFhUlGk2hYPuGEB/Zvu80oR4VoiNwZfKy/fjVilY9jom1F+JfGCuV
	 lqzR9gnj1lwYPHntg0E3mFWT770IEyLeuR1ZptmqVa/yA7GAW1kI+7OcRLx70fnJhS
	 GTbZSYfCTKCba9SdFRu1iNM9cXFlowWV1ry9IlzM=
Date: Tue, 11 Mar 2025 12:17:17 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Siddarth G <siddarthsgml@gmail.com>
Cc: abbotti@mev.co.uk, hsweeten@visionengravers.com,
	skhan@linuxfoundation.org, linux-kernel@vger.kernel.org,
	ruffalolavoisier@gmail.com, colin.i.king@gmail.com,
	n.zhandarovich@fintech.ru
Subject: Re: [PATCH v2] staging: comedi: remove redundant filename references
 in headers
Message-ID: <2025031113-resize-charbroil-0d6d@gregkh>
References: <20250311100741.11999-1-siddarthsgml@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250311100741.11999-1-siddarthsgml@gmail.com>

On Tue, Mar 11, 2025 at 03:37:41PM +0530, Siddarth G wrote:
> checkpatch.pl reports the following warning in COMEDI subsystem files:
>   WARNING: It's generally not useful to have the filename in the file
> These file headers contain redundant filename references (e.g., "* comedi_buf.c"
> in comedi_buf.c) which are unnecessary.
> This patch removes these references from 14 files to comply with kernel coding
> standards and eliminate the warnings.
> 
> Signed-off-by: Siddarth G <siddarthsgml@gmail.com>
> ---
> Changes in v2:
> -Included the exact checkpatch.pl warning in the commit message for clarity.
> ---
>  drivers/comedi/comedi_buf.c                          | 1 -
>  drivers/comedi/comedi_fops.c                         | 1 -
>  drivers/comedi/comedi_pci.c                          | 1 -
>  drivers/comedi/comedi_pcmcia.c                       | 1 -
>  drivers/comedi/comedi_usb.c                          | 1 -
>  drivers/comedi/drivers.c                             | 1 -
>  drivers/comedi/drivers/ni_routing/ni_device_routes.c | 1 -
>  drivers/comedi/drivers/ni_routing/ni_device_routes.h | 1 -
>  drivers/comedi/drivers/ni_routing/ni_route_values.c  | 1 -
>  drivers/comedi/drivers/ni_routing/ni_route_values.h  | 1 -
>  drivers/comedi/drivers/tests/comedi_example_test.c   | 1 -
>  drivers/comedi/drivers/tests/ni_routes_test.c        | 1 -
>  drivers/comedi/drivers/tests/unittest.h              | 1 -
>  drivers/comedi/range.c                               | 1 -

These files are not in the "staging" directory, so no need for staging/
to be in the subject line at all :(

Also, start by working on checkpatch cleanups in the drivers/staging/
directory, not elsewhere in the kernel tree, so you get experience in
doing all of this properly before moving out to other areas.  Also, some
subsystems do not want checkpatch cleanups, so be careful.

thanks,

greg k-h

