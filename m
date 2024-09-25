Return-Path: <linux-kernel+bounces-339453-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E6A986547
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 19:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2AD6286AC4
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Sep 2024 17:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C3A56458;
	Wed, 25 Sep 2024 17:04:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R8ytr4DO"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C77A23D982
	for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 17:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727283895; cv=none; b=rUifwT0NGPiWz+KKeNZAJFt0WkxZHhQhBqIWgrjT2DWIz7oTkY8gsrnGkeSaO0gR6pOVvM6cL7gWDWDVDcFiXzMCX1Z0uIWBiq9FZF3TBkUduGS6seErdIN18SsrZL5eWEmPeTqJrpYW58zLofSSjyGQC8/mLHEJmENcrACHJyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727283895; c=relaxed/simple;
	bh=8htXylArPWCddqvf+J0dcpViSY2vryMcT/YAeNTS0LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=My73T2ldsw9jxWwd7SSGFtMQ2T+LPQGuuhb3TI4etUHXKgOX6B69GNuAUS/qgC14OTeArjO5BoYNVqwB7mE4tTq4C7PCWCBmm3bI9TmE0IsruEUQZyz+Ae8yHw/7G9yd0B+nwSKci/L9BWIdeBr84XufT7GGSY/f4/e6n2g8O+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R8ytr4DO; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-535694d67eeso126008e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 25 Sep 2024 10:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1727283890; x=1727888690; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V2R4XJj4ap59FotkDKZ4Pzl2VkV0YoUjK1G8PYQt3fY=;
        b=R8ytr4DOhzQ7lpjs72KL2Bq5oXwDnYQ4FLISeDVur5NJvjMRvCoXuZG/B8JluDHgHv
         eIA8jIfAq7hbFoEgnXhvadjlkLifGKDP0o/UBBzGj7nPJ0tY2sOKf15wqxWoVB1C+Cpd
         m5uHDQL9VGkswx6Ous7Vv5A6mFlMiTjGB0pnVBgC1T6vYNBcrF0noqBzt0CLBf+Jj5a1
         q3hKTgMZsty7WZlzFkHALoSYAACRb80uG/Wb3/T0FRwmEOob4IcdFq11QrU+Cg9r5u9k
         qs74T91TwnmIgcThVeBSmI5oK4eKd5OfSWDPStH9NkHRQEjeijs4SHwCCnBawisC3O8w
         YhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727283890; x=1727888690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V2R4XJj4ap59FotkDKZ4Pzl2VkV0YoUjK1G8PYQt3fY=;
        b=FtdYXpsOz6fjEDoEP3sA9FKEWvRgvFo1gOwynSOhAYNUAn6HxsCncM5w9k3LI83TRX
         6AC+A1gx0PTVInddt7UWECPw7s/AxrDcsBqBNE9izzPgMN7YNNFQ/2X4y6ux+/GxWEqg
         4lGEu4/eusRopCqAqh5J3A/1RnjH+p8pSoS5yERsGhMcvBkpxyf09K/nEFbtD7E+zWCf
         txZzIbl9/ugEn/CW8kkf8NTttcBhGk/a4OXZVN9lydeHAEDmgF16DCgCQBitBlGk0PlL
         RiDG4YVG62NmHWWAwocI2HxZ3pUCN3BEkwHkrPgiIH5GSZrdv4PjGDDA0I1A/IZjwe7C
         RkMw==
X-Forwarded-Encrypted: i=1; AJvYcCUp9y/0oC151a62kjxmE04P8lFlJnLv7qMVME48L3mKLBaauxHxx4jJhcPecaJzAT+cxgWSuxrITOtxgFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF/wwglqYLJ1aq1dH5uFEVdiBPEPCqdxYsht03sAoOH3R7Yn+4
	Rs84yF4lHlwUo8kEr8uhaVXCmEzEkQpculXVNQFeTxQ9puTqaFYpB07sM+S8C5JvQeazoUjFbM1
	5zcLbKQ==
X-Google-Smtp-Source: AGHT+IGtoM0NgqWQa2JzRXVwBmyXvSTpUmC3TfaVStQslIHuIU9YRDspCg6CF9GzIcIQ/etCenGkhw==
X-Received: by 2002:a05:6512:2c8d:b0:533:3fc8:43fb with SMTP id 2adb3069b0e04-53896b91cd0mr136961e87.0.1727283889782;
        Wed, 25 Sep 2024 10:04:49 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-537a864d7a2sm570052e87.249.2024.09.25.10.04.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 10:04:48 -0700 (PDT)
Date: Wed, 25 Sep 2024 20:04:47 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] usb: typec: ucsi: glink: use
 device_for_each_child_node_scoped()
Message-ID: <erdwuk77ju5tvixlyxjjcapgg6x6mpwcswjs26shj36wrypmjo@dhxdh4cvvv7k>
References: <20240925-ucsi_glink-scoped-v2-1-a661585fff35@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240925-ucsi_glink-scoped-v2-1-a661585fff35@gmail.com>

On Wed, Sep 25, 2024 at 05:49:46PM GMT, Javier Carrasco wrote:
> Use the scoped variant of `device_for_each_child_node()` to
> automatically handle early exits.
> 
> This prevents memory leaks if new error paths are introduced,
> as no explicit refcount decrement via `fwnode_handle_put()` is needed.
> 
> Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> ---
> This patch is a follow-up to the recently introduced commit c68942624e25
> ("usb: typec: ucsi: glink: fix child node release in probe function")
> to account for a safer approach to iterating over child nodes.
> ---
> Changes in v2:
> - Rebase onto v6.11 to apply without errors due to the previous
>   patch mentioned in the cover letter.
> - Link to v1: https://lore.kernel.org/r/20240623-ucsi_glink-scoped-v1-1-f0fdcfec69bb@gmail.com
> ---
>  drivers/usb/typec/ucsi/ucsi_glink.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)


Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

