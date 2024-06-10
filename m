Return-Path: <linux-kernel+bounces-208550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0759026AF
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 18:27:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C0619B235B9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jun 2024 16:27:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6805C143740;
	Mon, 10 Jun 2024 16:26:55 +0000 (UTC)
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89EE91422C5
	for <linux-kernel@vger.kernel.org>; Mon, 10 Jun 2024 16:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.142.5.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718036815; cv=none; b=NwFU7Kxf57E/4uU6KRmXDD5rQ3kDMbW3P1EnRgeYGVCRwwnPUcb+TrKs1+JcIGTZXYWyG51AfMSdhpYeAwO5ur7qKea/ga2kq3JwlvryorWMfx/ZJY69SrNKZcyZZuNDWWqmpM76+h2Uop+uoweoXnug33qZlz3PjhnQoIhQq/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718036815; c=relaxed/simple;
	bh=FI/wVHjKj34tChqQy8HHa/5WtYMvhKm8Zf2HyqoEwOA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s1f4sLjLuoNK1ZHV3PnZytVVn4YPCQXhsRw73lCRsFn11I0kMLGqDBLLVenDCdc0Ux0wxZEQRa443uGOrI29Vabv5t/ZfTJ92nTDlwYhYqnFqO1I4kSAHH1hmiOg8V3LiKaVokJc0UVRMdBVFOEctUfqg/SVSdfKrOVhEr+nzbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=62.142.5.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from localhost (88-113-25-87.elisa-laajakaista.fi [88.113.25.87])
	by fgw23.mail.saunalahti.fi (Halon) with ESMTP
	id 3e002fc3-2746-11ef-80e9-005056bdfda7;
	Mon, 10 Jun 2024 19:26:51 +0300 (EEST)
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 10 Jun 2024 19:26:51 +0300
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 3/3] gpio: sim: use devm_mutex_init()
Message-ID: <ZmcpS24AmXG_QERb@surfacebook.localdomain>
References: <20240610140548.35358-1-brgl@bgdev.pl>
 <20240610140548.35358-4-brgl@bgdev.pl>
 <CAHp75VczROHVKwAi8j4fxR=L3oKJ_5om6rEAriDNFxh1dMRxRw@mail.gmail.com>
 <CAMRc=Mc593Zgt-jkx7T_D4s2gAFeccA9SdguM4vtFc9H701bUQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mc593Zgt-jkx7T_D4s2gAFeccA9SdguM4vtFc9H701bUQ@mail.gmail.com>

Mon, Jun 10, 2024 at 05:31:44PM +0200, Bartosz Golaszewski kirjoitti:
> On Mon, 10 Jun 2024 at 17:24, Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> >
> > On Mon, Jun 10, 2024 at 5:05 PM Bartosz Golaszewski <brgl@bgdev.pl> wrote:
> > >
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Drop the hand-coded devres action callback for destroying the mutex in
> > > favor of devm_mutex_init().
> >
> > All three LGTM,
> 
> Can you leave your tags under the cover letter in such cases? This
> will make b4 pick it up for all patches automatically.

For some reason I was thinking there is no cover letter.
But okay, done now.

> > Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> > Thanks!

-- 
With Best Regards,
Andy Shevchenko



