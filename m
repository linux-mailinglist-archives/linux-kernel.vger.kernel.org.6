Return-Path: <linux-kernel+bounces-299883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E6995DBD9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 07:19:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F6B1C21ACB
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Aug 2024 05:19:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023721547F9;
	Sat, 24 Aug 2024 05:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zje9nRA+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E7A152196;
	Sat, 24 Aug 2024 05:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724476693; cv=none; b=nU/epvylougpfoX5f4pdVtTqG2lm/xpFGFpnCVb9mAXZ5abkf8fUH79fPtm+qWfm04DRswMIIDzmkuFeMu/lqWbYxT5qTakzgDxbLU6Wudniaw7AJnKz/AXnhdAWtxyz0pwt/GJn9XPeBEJx0p+JHyyXMeJ9xNODSZ0eFUAOISQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724476693; c=relaxed/simple;
	bh=azPg7rrtfxJn5Mhi1MmD/CDZDJGEeCp638yWW7tRaf4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eTqHbJ8AGjDQqPJNBIbV+c18BaoBhe+1ZE2FlFSD2jEEAwhzBRioXVH9Efn0NOzRsUmkIyBbq1T3c9hcHghyo9HTOLaGIrbD5iTiHz4HlosVtNR9y3p7RZkLEZFxQ5wp8vLBoHVv9SuNqaLU4Hso6hh7LUsW+rYk0e9tO8hICbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zje9nRA+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3152DC32781;
	Sat, 24 Aug 2024 05:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724476692;
	bh=azPg7rrtfxJn5Mhi1MmD/CDZDJGEeCp638yWW7tRaf4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zje9nRA+qdlW8ECI+FULVvsuN/c2Wfp/QJuZlwyu18jF2yvlQjLmjrPx3x6cuUKSc
	 yUEzDUAVF1DJ4ClvAyKhvnFwFfEKLKtI+JtVvnNl36+dPL470VGD/fE/lMS3Xh59q4
	 /UMe5EP1jGLIxDqWZimmPW0SvbwKGob2X4nSUgaE=
Date: Sat, 24 Aug 2024 11:08:53 +0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Hans de Goede <hdegoede@redhat.com>, linux-kernel@vger.kernel.org,
	platform-driver-x86@vger.kernel.org,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Scally <djrscally@gmail.com>
Subject: Re: [PATCH v2 1/4] driver core: Ignore 0 in dev_err_probe()
Message-ID: <2024082443-mulch-junkie-1f9a@gregkh>
References: <20240822130722.1261891-1-andriy.shevchenko@linux.intel.com>
 <20240822130722.1261891-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240822130722.1261891-2-andriy.shevchenko@linux.intel.com>

On Thu, Aug 22, 2024 at 04:05:38PM +0300, Andy Shevchenko wrote:
> In the similar way, ignore 0 error code (AKA "success") in
> dev_err_probe(). This helps to simplify a code such as
> 
>   if (ret < 0)
>     return dev_err_probe(int3472->dev, ret, err_msg);
> 
>   return ret;
> 
> to
> 
>   return dev_err_probe(int3472->dev, ret, err_msg);
> 
> Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

