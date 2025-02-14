Return-Path: <linux-kernel+bounces-514872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07E91A35CD1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 12:47:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBDEB188E6B8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Feb 2025 11:47:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1E5263C69;
	Fri, 14 Feb 2025 11:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yl3cW9Cx"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC094275408
	for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 11:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739533628; cv=none; b=bOtlDt5YhenaY/b0p36xP8a7woQh5tnititRrY0GETd/374kpaT4XUieEIaSVhSeRnWE9IgPdmkkOczXD83e8zlX4DTXG6n9UPCMVHvBDUl/CVMH3jMLSkOyIVhM01lox4SoaNcqer0mFNPzRWpmGzRqf3+DCL91WInCB9eMAME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739533628; c=relaxed/simple;
	bh=zvtC8/NeTu27X3Ua/YxupAnB5lOUabgNeSPxnOjEGFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K/EF/XE5qqvu6Eihp7S2KsVG5gLQc8uVqsdi3+8Tmmr0A8KKNql1acndMcQ6USYyBLvgHYltauPUzLhNHOKj62yFjijwHruUPnE2Cx8g6C1a3JwqEppwealxIF7Enb+60ruLU5VIR0TlMS9cs/7npMDJ9fPMmkIzSMStxNuxrUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Yl3cW9Cx; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5452ed5b5b2so51147e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2025 03:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739533625; x=1740138425; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z+OQLoQ4w2P2wl26RlQhREWTqKJj63sDchzFcZ4MIw8=;
        b=Yl3cW9Cx9CraDeo+7MZHkdbQBSUqEPTqq9Jzht9lw7JqtPZWvDSOj1FeOusgWltUK1
         ylA5wWzAWe9E93w11gZ1+EMKqbg2SrpMTD09XP/byegjJ87FThOm9yXxVwr42xEw8UsT
         /8nhRj+W9O3dbEO7yDydyq5ejGyXjto0ioFVI+SLHIRxakGB2/DX1w38Q5guTG7hYp2F
         g/SEVAzZRcS3WUcdMVzF9IvnH2tU7e3YxXwG2acuV+gpXgExM2lYzgJoR4XfGzJNk+fC
         8E5nlhqgZeS3Js3IlZGcJXdirmcFaJVmKA3I8NVtDjCh5rFX7yVNQZFdZe804uNlIrQr
         XrvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739533625; x=1740138425;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+OQLoQ4w2P2wl26RlQhREWTqKJj63sDchzFcZ4MIw8=;
        b=Qda9T/DfHLvXrxe/M+X6pKQHd1k3fFQHgCb5tXDhYrzaYO3KoawL385n/TPArDBYJo
         FMSClNpyAGDxdSUtkiHmgG9CeuvBtVaZSq3AxzrLp/qHyCNu1EHywwi3EXOBcAgaToq6
         ceoLludasnuDvY2qqXj+CFUSBK7RbYAo7NLa7qiqpjvhRgbWaFh6Rh5eEJFl/v5B7qTC
         Bbse2/59CcrKq5tvExWJ4ymjDzurBX2CQ3HfVv4dKfb2g4vAEKbeJ6jDNxzECxCBHFGK
         005wRKcISVltkpQRChsihgZnIJy+wmLgH5EfuvnZxzYTiI+Dl/rAhyCP0RREDPir7SP1
         3BWw==
X-Forwarded-Encrypted: i=1; AJvYcCW7fzFZMFMmeshJ4EXNPwWIIVOFsvb5pdr9c0JHytZSYdstswE0aPO/bmoiof3NtkzTRN2mCdSA1CJ0oEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyRIZ6kPxJ3NjWApYTsR1kAlzaDfcxGB+K6LbuYQLncXRnezvTJ
	sAFpu88ci+IpdgOX1FYcwFeFqWeEC5GHMnPhbCfBYsU2O1sq2HTXz8cGXU9dPFk=
X-Gm-Gg: ASbGncvet1CnPFPYsPlJhjHb1OqvZ07xCx59GH8nMWBnCHuXd/jAuLfqEQv5NJkRdBr
	dPQEe/BmX/4G4nZB056B0D+XEF3/uMTSdsiLmvCdOEoAug4UFOBq01RbXjvBtKzFj0bQDkr4xlo
	5a51HqecD4zwFefH02p7tyCERBAk4ckNVyc/McBl1xkhqFfJPX6HdukQOwqIztzgI8lN3JrOeQO
	ZgG4jU0yln4P9SGxyS+deeyDB4Fa3AnKzSaCgD6yWVN5vNpnPBlnQaW4cRIuXSTpQTJOucK8AjM
	W+kYpPZkT0hzG5i5COwZBfnM/MNWB/77sr3p5jFuw7XXFIfVZ5XmbiccgDEkv9VpHYB6L6U=
X-Google-Smtp-Source: AGHT+IHKxKT40jo96mqb7NkALHmaQtXaFtWBP2ROk8yL8YBS3KSBU18a4KW3uLJNYHaNWpdoTwyNbg==
X-Received: by 2002:ac2:58c9:0:b0:545:ae6:d73f with SMTP id 2adb3069b0e04-5451ddd9ec6mr1786235e87.46.1739533625012;
        Fri, 14 Feb 2025 03:47:05 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452e44052fsm62574e87.80.2025.02.14.03.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2025 03:47:04 -0800 (PST)
Date: Fri, 14 Feb 2025 13:47:02 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] drm/msm/dsi: Minor cleanups
Message-ID: <cwzxsmoykpobyn43thiyum7ncurmdhdv7qx5pqo27itls54mqt@6l3eekacxlex>
References: <20250106-drm-msm-cleanups-v1-0-271ff1c00795@linaro.org>
 <ad2bc7a7-2e28-4599-bb94-fd66fd2ba88e@linaro.org>
 <r5mq66osrzle4xbduvaqhv4ypqc5dfkjrhvqwchjmni2q32sbd@gh77gkgj3imp>
 <c5288872-31ef-427f-8438-06e1f0da1e71@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5288872-31ef-427f-8438-06e1f0da1e71@linaro.org>

On Fri, Feb 14, 2025 at 12:39:30PM +0100, Krzysztof Kozlowski wrote:
> On 14/02/2025 12:30, Dmitry Baryshkov wrote:
> > On Fri, Feb 14, 2025 at 11:52:14AM +0100, Krzysztof Kozlowski wrote:
> >> On 06/01/2025 09:49, Krzysztof Kozlowski wrote:
> >>> Few minor improvements/cleanups why browsing the code.
> >>>
> >>> Best regards,
> >>> Krzysztof
> >>>
> >>
> >> 5 weeks on the list. Any more comments from DRM side? Can it be merged?
> > 
> > Are you going to repost for the patch #2 commit message update?
> 
> I did not plan, but I can send v2 with that update.

Yes, please.

-- 
With best wishes
Dmitry

