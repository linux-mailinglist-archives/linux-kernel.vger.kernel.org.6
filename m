Return-Path: <linux-kernel+bounces-417539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5621F9D5559
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 23:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC8C1B21121
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Nov 2024 22:22:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C688A1DA60B;
	Thu, 21 Nov 2024 22:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MOqVzfvS"
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF4B1CB50D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 22:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732227753; cv=none; b=qsYyE9h7Ew+acGlPklBJlPCOfiWES8qEUBviQjwTQpxlayXrE+iZdDin1/ZAC66vT+rDgAJXHoWuqJxA3+j28NfX653TbecU3goiFBeJ6b6+wICU3j8LCrDWl+3v5/kOdeG4Oe9W6pJdZknQqUkAHeU3fdDrVPrWZnUEKYeZvXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732227753; c=relaxed/simple;
	bh=nVCXXLshd4gwOqlB2npfNg6YomsSuRLIGjj+1pL84Yw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KdsRXGuQhlz7SV9HdWGEIAwSI6P477KGRTiPy/5AY+p3GNJa2bqJPPlUZcghE5M7d9J5fJVzG4gMTJYwFT93nkeNql97sjEO5BboA5cN5MVggfdvFtdC41XepcsU3haBkPpRwKHatxMths9rilNetwLUM+jCJRBuV0Dwu1ZIvwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MOqVzfvS; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2fc96f9c41fso16059921fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Nov 2024 14:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732227749; x=1732832549; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ej8S3vTqvmhNIveEQbgfSoDst8pJaJNYhopo+ceKPlc=;
        b=MOqVzfvSh7ZZ2+/B83neC3p+Qtlchkw0fMzb9IHoV9e5oxTpQLcS/8wVWWcqEq+ir1
         c1BpA7gkwdWxPElsZI1TnMjsR8IuWJBHOTjX18AFO9s1Rhm/EU8VeRoBqxm3NUyykdQU
         8JjSdGCP6rerlDnWJEcXZJNwM7+DSAAGuehjT74A65aN/4rPiW98xJm9ELlkiqxNXInN
         SHT0nK95QgM8UEnpHOzx8Ntrs3p/1xTb3NUWUZAjE1ylXoKbqsytr2yPsmvAw0hxkgij
         W+6JCeYyQvh8xhAeffIKZBu7cnKes1LK1xAurVdi0Vx86cDTxCmizjbZlEzVbvf9h2v9
         k18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732227749; x=1732832549;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ej8S3vTqvmhNIveEQbgfSoDst8pJaJNYhopo+ceKPlc=;
        b=S5sFmwvKAsTu+173v94ivF2K4jyByJijs090AwchzQNvHbJpTf/hp12hvLQxXqUcgU
         7CcQ8ZkcSVpR7U3fvgruq5kOib2anV9UKg3mwco4xAFoam9i4gYxdeiZ3xWXnduSCd4h
         QZxJvdEta6S/5ty1kSTrz6jjOZpPTltuTcPcqU4LSlIHvP4iiMti7/HE4NMct/TyZaLA
         nzoTkRyWvxEn3Ok4vfhfm0lLafzAcASJkGfZHMVHbl4boBhHflA/Kz0HcHLrdWIDJDNp
         Yd8owmBUNTuHBKe4JFjKmKp57pObd9CdZSGr8RH1jmGOnGkjP+AdJnH91phFwfCIENWz
         DbKg==
X-Forwarded-Encrypted: i=1; AJvYcCUzhTIHVlUl6hGAZ6yWjxmhvplUUlpTtInuHB7klAj3KWmQaTUB6QBFowznBISW6s0fzkwRwf6BLohetb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLVvQvV+bOJsiEa2FzhNokhvoFDZJEAPtJ7+LkS+DJylMGsyOf
	l5X2bVuf/2Sw0AidvKWNXuHturuQ8+T1wdLVjyKvEC9JvSu7Yr70Qu5aiQsevQc=
X-Gm-Gg: ASbGncs8kuaMr/Up+OrJAjqJNz3LDKo4zWMU8wxRu2O6XcjrcMAzNXjb8SEE7n4UOJa
	RmKv2/ZgeX0nsHkBXxMR5QJ8wypyHf1S8lEJBhxnbgzR9BkZ6wHg/s1nc8BvSj3Lu/G8laUYiko
	5KrzC0N2wxKNcwTa4fgomQ96ckDhk1SguXvnyCNzUxdalpdZw3Rd+CAMw1B5D2QM0CUX9wNsqja
	oqckxv9rlT0SDfIZoJC+S8QWNh6IYvN3l/3EZaqt9ihVCig8UmBRiPyDHqGqnZjqJA/J1Fe0sKc
	u1dEcX9PZfAbGZn4m42/if0SF6ji3g==
X-Google-Smtp-Source: AGHT+IE4DmJhxMe9nKX/xPXS6QUj2KIG9OcMLvY6lKA9hzUZEqv+8puapbezE/MYq4KUI/+HEGfV8A==
X-Received: by 2002:a2e:9a11:0:b0:2ff:6204:951f with SMTP id 38308e7fff4ca-2ff9697ce7fmr14354211fa.8.1732227749517;
        Thu, 21 Nov 2024 14:22:29 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--b8c.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ffa4d3f7f2sm645911fa.44.2024.11.21.14.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Nov 2024 14:22:28 -0800 (PST)
Date: Fri, 22 Nov 2024 00:22:25 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Ekansh Gupta <quic_ekangupt@quicinc.com>
Cc: srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org, 
	gregkh@linuxfoundation.org, quic_bkumar@quicinc.com, linux-kernel@vger.kernel.org, 
	quic_chennak@quicinc.com, dri-devel@lists.freedesktop.org, arnd@arndb.de
Subject: Re: [PATCH v4 2/2] misc: fastrpc: Rename tgid and pid to client_id
Message-ID: <i5aii3fcha3yasqhuiww4rzkfvr4th47lkog4lm5xhnhh3ygac@euhofylhilih>
References: <20241121084713.2599904-1-quic_ekangupt@quicinc.com>
 <20241121084713.2599904-3-quic_ekangupt@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241121084713.2599904-3-quic_ekangupt@quicinc.com>

On Thu, Nov 21, 2024 at 02:17:13PM +0530, Ekansh Gupta wrote:
> The information passed as request tgid and pid is actually the
> client id of the process. This client id is used as an
> identifier by DSP to identify the DSP PD corresponding to the
> process. Currently process tgid is getting passed as the
> identifier which is getting replaced by a custom client id.
> Rename the data which uses this client id.
> 
> Signed-off-by: Ekansh Gupta <quic_ekangupt@quicinc.com>
> ---
>  drivers/misc/fastrpc.c | 48 +++++++++++++++++++++---------------------
>  1 file changed, 24 insertions(+), 24 deletions(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

