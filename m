Return-Path: <linux-kernel+bounces-213642-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0A790783D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 18:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 164A1B23904
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2024 16:25:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C4DC1487D8;
	Thu, 13 Jun 2024 16:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l6iF9Mjl"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8F0C12FB0B
	for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 16:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718295890; cv=none; b=g/hlUSbM8Ph//FiHcbGJx2xe++JGrBtEGbjYfotY/y7ciLFwSor9Uxh+KtaY579x4l8yMuBWJcSZmw3qXnZKuszkbHhw5rALfpIpd+JUCrGd/l2fFfYtVbsVi5zjv7lCJ+DdHESRmphnWUPu6bla+dlsNnj8j+lzWD/DH34++9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718295890; c=relaxed/simple;
	bh=dBw9nOUl9fF7SB1r66qOP+3MBsu7aeGgqc4RXD6dJOw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pPYbAQ0UCufwJU2Mtsqqoy+ugdEhgAKAfUW1VzGhzMPYRJA4kpLcCM9H4CNsjGvKidYdiclZ5F85UivpCb38CsRlMYeIITQNwNLCX0Iwr4s43oH3keuHmSR4F79uvZCNRKhWK1O/X79fxnWxEqv6TQo87leGwpxkdsnoU7cbV1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l6iF9Mjl; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-35f1bc63981so1486363f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jun 2024 09:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718295887; x=1718900687; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xm9fvtFl5M9ClXulLO7X4Jg5vRT4Wu2KsAzkRuWsuxo=;
        b=l6iF9MjloMNMalTqu4bJrNkh63RZPCb1R5TIjRuPBlINZJSC7upsx+9qirtNl7sSv5
         O8vTP9L4hmvWcVV7UA/pMK9brbYTPMnPV4PLyqKxfMvwDXsiyO4mcxcBzkbobN8JO/Sh
         a+QvisXIhJgw7O4ArHisT22shqw7OQuzTSz0krJJsDRvEBXSjM9xt8fSC7OxZ6EFwNav
         hc8tpJH6YnwquW09IddFRLQJ2fE0DQcXW6BUrbc7dpy0CxyT/JJsC2Zav3bMus3jJtGD
         DLOBx4ISE/bu05Dh5e66vQV7jdb+eA+w5jMg9wosvc87ZPO64OP7FQbzQ2XluXkeuj4u
         fNcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718295887; x=1718900687;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xm9fvtFl5M9ClXulLO7X4Jg5vRT4Wu2KsAzkRuWsuxo=;
        b=K05kSVlefD7+RpZJn13aJvsmaOfqXQ4amkPTO4l/IKr7yvgHEe5gP0OPRdFZ7b21Fg
         gLjpfJBND0+xf3g5f32eePwG9eP7ZIetjzlEumwwRRK6DVAjtA3waj6I+ngqMdhUrfI5
         EWfFOhsS8hQ8JLqpE2w/n7F5yyjG7RLzwHnLx0tozDxdJ8OI975TF41/lcoml7cC04SJ
         uERshvFw02lbGwiJG3mztwx2nYsWUzgcnCQ1IhxH5VOUV+UiQL9ySFZtmJlwLlJNYdG8
         77INRih3pjoYPh1dr1bXqMCj3/yatyGZFzofup3U+Qc2/DjvCG1IuHIqC7/8FkMazFyL
         ++LA==
X-Forwarded-Encrypted: i=1; AJvYcCUd93CseFMZE7h9tfmgkTXKue2cBugw8ZufYOLvtjKTvihyEqKbNI6ewcKG/j2d/64Qul4yMOWXxkREQu9HAGbBTbTZrDYwhgGZ9dCE
X-Gm-Message-State: AOJu0YzzczoG0gLkb9nLVWxEv468Vyqf7wG6FAWesH6daEdfdRJep/Df
	sLjl8BrcFmy0Z6WBcN+H7ZmUwqSUjhLtFHZdXpucOTkGnWT5Jp/beJnIss9SpKU=
X-Google-Smtp-Source: AGHT+IGBrxpjL2E0pgPBIEJnLIDsTzjWGoMfXeByIRcty/Uu7p3y+ZFY9bPpjqA6DX/92MrGE37OOQ==
X-Received: by 2002:adf:f88c:0:b0:360:7386:1a49 with SMTP id ffacd0b85a97d-36073861df9mr2356972f8f.32.1718295887142;
        Thu, 13 Jun 2024 09:24:47 -0700 (PDT)
Received: from aspen.lan (aztw-34-b2-v4wan-166919-cust780.vm26.cable.virginm.net. [82.37.195.13])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360750ad20bsm2130332f8f.54.2024.06.13.09.24.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 09:24:46 -0700 (PDT)
Date: Thu, 13 Jun 2024 17:24:45 +0100
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Patrick Gansterer <paroga@paroga.com>, Lee Jones <lee@kernel.org>,
	Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
	dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] backlight: lm3509_bl: Fix NULL vs IS_ERR() check in
 register() function
Message-ID: <20240613162445.GA24098@aspen.lan>
References: <187b5bc5-a010-46c2-8ead-980df9efae79@moroto.mountain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <187b5bc5-a010-46c2-8ead-980df9efae79@moroto.mountain>

On Thu, Jun 06, 2024 at 04:10:23PM +0300, Dan Carpenter wrote:
> The devm_backlight_device_register() doesn't return NULL, it returns
> error pointers.  Update the error checking to match.
>
> Fixes: b72755f5b577 ("backlight: Add new lm3509 backlight driver")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>


Daniel.

