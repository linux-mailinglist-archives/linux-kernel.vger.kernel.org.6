Return-Path: <linux-kernel+bounces-367471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B4EBB9A02BF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 09:38:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E3D01F26C0B
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Oct 2024 07:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0D311D14FA;
	Wed, 16 Oct 2024 07:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OTyRsDdC"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48EE51C1738;
	Wed, 16 Oct 2024 07:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729064260; cv=none; b=HNwcQ+i3oH3dPoCjgARPGFA5jiLKOEWlv+u8nU2EcnMGxTPPk6gvK7ya9y+zK+usslSeJgtUUkFnG0OmhfXbwx/vv/Q6C/SDdiZ1q4WzebQCS0N1899Q/90eStRQTHYFJ9lP9P6lCuuFXIRY3tYU9r60de2hDWctyN1+RBCBugQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729064260; c=relaxed/simple;
	bh=zF+Z4e7SKSTQoKiKhiFCu/Xhvq0sahvtFn9xaa0J/ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z1r/5LNBM+IiMfogFKoq/mOMA+QEpF9A7PbHTKkrYnn/92X+S3jKToLfhEXOJTcMUc7ZLsPu1K8CI2KPz96WE/I9Ryz5vuCeEer34p6IBF97uvihYbXpZCHg8dQODlwHHawh/sFK20Ppcntd8kkqYvJWADqfQRN5UT54D3NzDYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OTyRsDdC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F51C4CECE;
	Wed, 16 Oct 2024 07:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729064259;
	bh=zF+Z4e7SKSTQoKiKhiFCu/Xhvq0sahvtFn9xaa0J/ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OTyRsDdCRmFxEbrt9PoxZuL8HAMnD8oHCdn5v8lo3Pph4A8LC0Cw913gT4pAbMnPJ
	 OdKA/+HXa8XlZ9t+PawQaxxHM+dqYfvk+eEQklhnyzEhTgEf5493xBkK3bCISlERZa
	 aBQJTkRf+fKt+BicbDakG9+aLpArhM4hkN0Rb0FI=
Date: Wed, 16 Oct 2024 09:37:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Everest K.C." <everestkc@everestkc.com.np>
Cc: dpenkler@gmail.com, skhan@linuxfoundation.org,
	linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: gpib: Remove unused value
Message-ID: <2024101654-creole-palm-81d4@gregkh>
References: <20241015210300.17941-1-everestkc@everestkc.com.np>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241015210300.17941-1-everestkc@everestkc.com.np>

On Tue, Oct 15, 2024 at 03:02:57PM -0600, Everest K.C. wrote:
> The variable `complement_count` is assigned a value which is again
> overwritten in the next statement.
> Fix this by removing the first value assigning statement
> 
> This issue was reported by Coverity Scan.
> Report:
> CID 1600790: (#1 of 1): Unused value (UNUSED_VALUE)
> assigned_value: Assigning value from length to complement_count here,
> but that stored value is overwritten before it can be used.
> 
> Fixes: 4e127de14fa7 ("staging: gpib: Add National Instruments USB GPIB driver")

Thre is no "fix" needed here.  It's not a bug, just a useless operation
(one tha tthe compiler probably just compiles away into nothing.)  So
there is no need for a Fixes: tag, sorry.

thanks,

greg k-h

