Return-Path: <linux-kernel+bounces-414829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8254D9D2DF6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:32:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 480CA284176
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 18:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D688815443D;
	Tue, 19 Nov 2024 18:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="ECLQWvzw"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20FC256D
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 18:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732041168; cv=none; b=ADit8dLMm8kWoRi30g9S4wfOfPlQuesfup9HWtT3eo7zoxXJyhZpdbl5xCg62S1f7ZNTGdRhGrNxfa3jRGrv1p8oC7DxvWM3FnqPmhc8ZbrH8Q706io3kb0INQFt3T6d37MZftjf7kwJ6Omc9NBLQ22GamJqINB7EUvwysSF4hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732041168; c=relaxed/simple;
	bh=Q03afy1pR87I33tzLSWKBJv+Jn60qKZiCJtlfWL/f5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CASFGkpJyM9+4FMnb439ooJ2iCdl7l1EPJcH6MF54roGOiSGEiqBF1C5yska4aPqNFuFavs3S83gbno7JkIzGQ0GSLIK6fsDdR3VTKgekcz4rV6vjZvotx4zSfDt0eEmFXM48CjG735ymO4r1IPTo3d8YIGnR4opR1CMGIx3q2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=ECLQWvzw; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-53da07b78dfso5427067e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 10:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1732041164; x=1732645964; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/qujIcm++lq8ximnF/u+BvAkGZqRiSauboDwnp0tHWc=;
        b=ECLQWvzwbE6JQzFiAMPiGhJIRB9i+Y0ka0SY5fM8LGnOX3fsqKLij9IIZZKsRNBXPq
         BLlSAsbCivM32HS6u+ShdvVl0+X8h+gyIrzVBVE/RINRxPIfuFu1Soq8ZgT4xvgdHUCc
         cCVlupkOO9OR1sqJj73+KWWPt9QKtWY9qu27keZsl5rYSAiWQBv7YzgbdqQ3KFxEb3S2
         SIldGKWXHqmjBgFzqhuQYEX3YVx0EktmSK8Cl7UbTt6f+TM/VSEeaxgL6CtDt2u4T0sJ
         0xDoUUCrMFeFEpanmAbDRHxO9edU6Prdd6zJua0eP0/U0va7vi9AAcRq916LC9v+XVkQ
         vOmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732041164; x=1732645964;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/qujIcm++lq8ximnF/u+BvAkGZqRiSauboDwnp0tHWc=;
        b=pEu91IoCM8Rhz3RtFTpqFwPefcZTcVi93zrky9Nfo0y+0g6qldn4NvUK4UQpzGgk3h
         NVGP0FwQ3SplSYmS1SWapL1py514Ygr4neSoeoxOY8vwZ7+f5/jfy/mYVQE52wTyXxmw
         nbS4Y7HjG2nidHVDn4P5BpOcM8Y+xw5TswcdXbhOqMv6HUFZV90xqC5Xaq6bd+MMm651
         rxgvxEqJfZhnjTni31kEwMdWU46byFGbhG6I5zI+Emq5JdbdpwHDMaqvhq97g7oFjH8F
         ftVcSZjyvjqwZ9/fGwZS1ElN5tDFyz9iE4KuKpzPRTyAvkhEJ7Vl2CteGC2qTNgsQUSa
         2doA==
X-Forwarded-Encrypted: i=1; AJvYcCV2knaNvh5O1yQp08FfsUZvisYIqYQCzVO4t/7z7eDFXhB/TXhOiQDhgzFajjElWAxdT8bbA1JcKtZYzds=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUeLE9FeH2/YvkHc1VVHf7hSLeZYuew28dZsFav3OQAif3u5jO
	OVGya8Lreabor4uTn1VJsFE1mfBzTt3PehSjFTyPhJY5qX73onEZnDFWgweit/4=
X-Google-Smtp-Source: AGHT+IF92tJReyYtOQMdSwg2EHkEJv+Mc/gogwP8Kd1cbsMYdhOur3UCx/g98j7q2825WYgDiwOXAA==
X-Received: by 2002:a05:6512:b20:b0:539:f2f6:c6fe with SMTP id 2adb3069b0e04-53dab29cc03mr9188460e87.16.1732041163890;
        Tue, 19 Nov 2024 10:32:43 -0800 (PST)
Received: from localhost ([179.228.213.10])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f346d7sm77359085ad.138.2024.11.19.10.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Nov 2024 10:32:43 -0800 (PST)
Date: Tue, 19 Nov 2024 15:32:40 -0300
From: "Ricardo B. Marliere" <rbm@suse.com>
To: Luis Felipe Hernandez <luis.hernandez093@gmail.com>
Cc: Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org, 
	skhan@linuxfoundation.org, ricardo@marliere.net, linux-usb@vger.kernel.org, 
	linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: usb: dwc3: remove deprecated member
Message-ID: <5l65sdskdzbehxamff5ax4ptiqhaxh7ewi4umtpp6ynen45nj6@nebuxjg4c4rx>
References: <20241119154309.98747-1-luis.hernandez093@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241119154309.98747-1-luis.hernandez093@gmail.com>

On 19 Nov 24 10:43, Luis Felipe Hernandez wrote:
> This patch updates the documentation for the dwc3_request struct,
> removing the sg (scatter list pointer) member.
> 
> - Remove 'sg' in the doc block for dwc3_request
> 
> This change resolves a documentation warning related to the missing
> description for this field.
> 
> Signed-off-by: Luis Felipe Hernandez <luis.hernandez093@gmail.com>

Reviewed-by: Ricardo B. Marliere <rbm@suse.com>

> ---
> v1->v2: remove unused sg struct member as per review[1]
> [1] https://lore.kernel.org/linux-usb/20241119020807.cn7ugxnhbkqwrr2b@synopsys.com/#t
> ---
>  drivers/usb/dwc3/core.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
> index ee73789326bc..3be069c4520e 100644
> --- a/drivers/usb/dwc3/core.h
> +++ b/drivers/usb/dwc3/core.h
> @@ -956,7 +956,6 @@ struct dwc3_request {
>  	struct usb_request	request;
>  	struct list_head	list;
>  	struct dwc3_ep		*dep;
> -	struct scatterlist	*sg;
>  	struct scatterlist	*start_sg;
>  
>  	unsigned int		num_pending_sgs;
> -- 
> 2.47.0
> 

