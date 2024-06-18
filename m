Return-Path: <linux-kernel+bounces-220054-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D01290DC15
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 20:59:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21C71284C3C
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jun 2024 18:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C7B15EFA0;
	Tue, 18 Jun 2024 18:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uJTzqjXz"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5BF46426
	for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 18:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718737153; cv=none; b=rpJ/Cu2Wj4QX7bIcMC7t4UNiNKWocrg0ZLI/tQ7USlYpvOhDO7fMKPQcJry6wV/pMaBHNNQ5mwraDiiTKxJMEGuycZbFiP4bsQOoCx0YBC+8bWBB6pP4PZV0WYX21/8AJsyrhVqNAiQigceTS1vx3HoQsuBDQieB/GQF9suLwvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718737153; c=relaxed/simple;
	bh=BdWIeCr2Riu1goFyOWQXAGuIK2HMfNskpG+y2gZRe28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q0WCkc8VBwzMbox7wcgmEEqdCrH1gMRVGZIydQiFqJzcSa5YuRY/YDYtyUiwhEtCRAWedgpzCf3T9By2WpvVTvdfdxDsEyZ0eI12T8Uwa/GhCT60R79BivcLyacW89xC6eyBmVntphm3NLmZL86s0bJNd8MMluyOArtrlZScH6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uJTzqjXz; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-52ccb56d5fdso71297e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jun 2024 11:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1718737150; x=1719341950; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9MpCHcPoZaGrAFpup9mciJpiv7a+e50VTao5sjCkleg=;
        b=uJTzqjXzTYSckg13C8ziigOHkG/lyJEhG0MZbXpkbOEaEKQllckeo2IPtqEcLRaRrq
         mQc4sB0E/XXTklP5Ny8dc4e+WVCM8uxxQe/Ssa8eYqW3z8JCdFx02y7Ri8Y2IvJqtC8e
         zEZyXnUO99cN8k2C+N7CdvLBkzLpL4I8FoWQOQ/l+sT8eGU2vRCgHueV1pi54kJqzZk4
         C/4QIah3MElmmGoqush0rMBDaSJ9PwQhZSRvdHtlr7cPyPwqRYLK9XoccDJPJpX2Misy
         HbvMaB0SZcD/IkHOWZZkriG/Y+m3EVBAPHgRU8J7gw5ozI0RiZ6F4k/CW5TgMMSFJOQf
         miUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718737150; x=1719341950;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9MpCHcPoZaGrAFpup9mciJpiv7a+e50VTao5sjCkleg=;
        b=qCfAD3fahxhL+ybRQTlGDMOwJy0wgCJMzAq+5gLyPoIurSEbH3/iE59Eqq7LgVK9f4
         IK1ah8situby3SiylquYrzGouLSBEJAXP2B9k+TpOx2iQe4i/L/QS4GvRC+Xd5wDFwad
         OK2M1ezf5sVsybzk4/+Z7rk0s1Pzg1WF46PSDl2jLnE39GPMzMUP0CRpKGXX26M2vcPV
         +L5H975IxtNX0VX/tEyRyBzv8D61LlhMnND9YKul6i+Q26DikYKKmWi2LWQsGtYddxLz
         qVM6Y5HV/YfvDMMb2VnF44s8RjRwtq4wrzFF1xXUrWsD70aC9VkIsGhmcym0B7U6N7CP
         bKMQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjGYWM2lAnxcPfiscFE+XfzCEakZFn3bBjsx5syscOPrc5jz7+Muj6NPqeC+SYoJvThVPTFxgw2bOuhJ2ZhzYPXLMRQWLn6mn4HhWw
X-Gm-Message-State: AOJu0Yyq/t83wrq3KAHJjrf0JoxllcBO94ASCAbLokuSAAwLYhmOuuib
	xdVMPf3PjI+GIn5jF+kdIMBBXtj15J1aGGDnC0bCYaTU4QTcHHFQJ0kq6sugAxQ=
X-Google-Smtp-Source: AGHT+IFDr3U/SrLBiO1uPby6Uc8AxM6+e9mp/Lc1MODZwB4YQh4bCUD9hP+ePj9pH4co7aNG+afopA==
X-Received: by 2002:a05:6512:2e7:b0:52c:823f:2a0a with SMTP id 2adb3069b0e04-52ccaa2c8c8mr327227e87.10.1718737149939;
        Tue, 18 Jun 2024 11:59:09 -0700 (PDT)
Received: from eriador.lumag.spb.ru (dzdbxzyyyyyyyyyyybrhy-3.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::b8c])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-52ca2889052sm1573443e87.299.2024.06.18.11.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jun 2024 11:59:09 -0700 (PDT)
Date: Tue, 18 Jun 2024 21:59:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Nikita Travkin <nikita@trvn.ru>, 
	Neil Armstrong <neil.armstrong@linaro.org>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH RFC 0/7] usb: typec: ucsi: rework glue driver interface
Message-ID: <hgqvyaziumpag5g5ajzupllvpwlz44scma6yu3drmtoqwcwav4@w366suy7c2eo>
References: <20240603-ucsi-rework-interface-v1-0-99a6d544cec8@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240603-ucsi-rework-interface-v1-0-99a6d544cec8@linaro.org>

On Mon, Jun 03, 2024 at 02:24:53AM GMT, Dmitry Baryshkov wrote:
> The interface between UCSI and the glue driver is very low-level. It
> allows reading the UCSI data from any offset (but in reality the UCSI
> driver reads only VERSION, CCI an MESSAGE_IN data). All event handling
> is to be done by the glue driver (which already resulted in several
> similar-but-slightly different implementations). It leaves no place to
> optimize the write-read-read sequence for the command execution (which
> might be beneficial for some of the drivers), etc.
> 
> The patchseries attempts to restructure the UCSI glue driver interface
> in order to provide sensible operations instead of a low-level read /
> write calls.
> 
> If this approach is found to be acceptable, I plan to further rework the
> command interface, moving reading CCI and MESSAGE_IN to the common
> control code, which should simplify driver's implementation and remove
> necessity to split quirks between sync_control and read_message_in e.g.
> as implemented in the ucsi_ccg.c.
> 
> Note, the series was tested only on the ucsi_glink platforms. Further
> testing is appreciated.

Gracious ping for the reviews / comments. My endgoal is to simplify the
command submission interface, allowing us to handle odd commands in a
single function rather than having the code split between sync_write()
and notification handling.

> 
> Depends: [1], [2]
> 
> [1] https://lore.kernel.org/linux-usb/20240521151109.3078775-1-fabrice.gasnier@foss.st.com/
> 
> [2] https://lore.kernel.org/linux-usb/20240531104653.1303519-1-heikki.krogerus@linux.intel.com/
> 
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
> Dmitry Baryshkov (7):
>       usb: typec: ucsi: move ucsi_acknowledge() from ucsi_read_error()
>       usb: typec: ucsi: simplify command sending API
>       usb: typec: ucsi: split read operation
>       usb: typec: ucsi: rework command execution functions
>       usb: typec: ucsi: inline ucsi_read_message_in
>       usb: typec: ucsi: extract common code for command handling
>       usb: typec: ucsi: reorder operations in ucsi_run_command()

-- 
With best wishes
Dmitry

