Return-Path: <linux-kernel+bounces-525836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB47A3F620
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 14:36:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 461E63BD849
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Feb 2025 13:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F156E20D4E0;
	Fri, 21 Feb 2025 13:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gpeZ8WE4"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAEB1AF0B8
	for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 13:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740144834; cv=none; b=i70HyuO4YhTu0QI8Mi18cfZx8bjNxLfj/58a/lUDp9ie91PPvd2PkbLbdg3owFo550G5voiATuNLAuF4oo+7KYw3S/XNy11II2KegfD7oUJnmr2DvptTyhBaV7qmrsqZoUHJicE094bKVxcLevgbpxIyO/ORY05ahpZnqSuD3tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740144834; c=relaxed/simple;
	bh=+xQvuAjburFLy08XVkCb+80zAeokEaI0amiqRDkhEsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTK3rVThmuDj1QUJmmQMgUVaeZqhWVl+Sw0UCIbwSgmkAcXm0/8Ihva0mvL6Dwnaj2T61wAnpyaymJSKpWD0/lhFKLF1TT+YxxeEHJsRAFu8MuH+f2xwJk6EBo+1EiRGaesPeMyk5BUmW6jOZT56mypQZceU0F8Qzuza1psIHXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gpeZ8WE4; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-545284eac3bso2064411e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2025 05:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740144830; x=1740749630; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ieh7CBVPmu3X5DHV02AR8XvoaNx/S0Yj7VuoRST8SJM=;
        b=gpeZ8WE4mNKi3cKUMjepdYuJw+p0NzyZQiXfPgFp5wijkg/BcKfRPxR6ei1OyfghJj
         czGw06jPXtb5j4q3SsQ17Zh3yXl5c4BgU9z96rqwfS5v4id3hj/VE2Tkcp1NA2gKMmxi
         N2ZSR5q0q+oALPUtlkXujI2RjS68itut87mvrXhPqqA1eDs6ntmzOeY7eFaaxqoaYWrq
         OTJEG/j9Nsc1zk26ZpftukAhK5/duS2tTgJVldLVLl9X7zyH6xycW//xF8m+ew6VNYWY
         PWwEjfb326oRDRPCwe4ko5UQPIfWx88H7NuApvOvHxZAUvMwXNExRolL85KRLFHk0XNi
         bajQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740144830; x=1740749630;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ieh7CBVPmu3X5DHV02AR8XvoaNx/S0Yj7VuoRST8SJM=;
        b=fa7ka2nbwMx50PasbB6+rSmtNDDWPHn2OVzowJ3lDtonYKy67v3LNAUi4uvznAkFmk
         Nn19JPea38M4AfmQSm64wNd8ECFZKVDuvVX4XspkAAh6dwqi8bfDrHqTcqdpiRTZWI1K
         5ewMvIx2w/5GsoudtV1fXjP1GIwOgrh+VhkQxzPnPSB4/NbtNrD4n0cRXNw1J4r9fKq4
         kbT0WKVVq9BECNLrfJAvDJCESF2vXHvUQKs/qIW5FXYTWHVzm8m+WqOg3zD58ClI6jjY
         0qCuuCc7D7u9HRa4hjn/MvO7pnWouiZJDF7C68eIs6UP0omL3rYk9dpnqGruCxGIxb4+
         RD8g==
X-Forwarded-Encrypted: i=1; AJvYcCUBqYCSGpqZBz4H2yJ83PGKyyrc13fasBXcRWry2j1QBW3yx2+w6d5wf/09YxChJvr/T5w0lT8qZtnERSI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNIq+fR1cAhjclewIln6W6CC+A0ms0Dw3+FH+lQ5p2CN/CMnjI
	4q8UaN4xSiiDiVkN6+wvfXb+97jRhDMflgPLKpNkG7gGTvVrRk+5eVtbjP4p8Yk=
X-Gm-Gg: ASbGncubvWz7FKRzBlLPdDzq3SklRL26AqXXJDxdcOh4reHUaYGySc/yowz6Yk5+DKw
	yXc4fKxpR6XnFS4mLRtftoBbzxH6K60y2iQZ6U6T/FzyeOTec+E8EP/XvUF5h2PMphYsC6V+f+G
	yjSTQ3P98L94knMFAJyd0K1FouEIom4YsNmzEpSgg06I7UNajy2eMaulYskmzNomGGQJtNsgSDw
	kuwsblcUitVSmGvCbhdA0b6ZNbx+zTkIMkq1r+oab2ZsPSaHPUoDmfVqwnmcav6PySvZSfkd0nl
	zzU7g9JP8UEBBUXi+fDZrJRKvbUUaAgDB3TQT7XLCz+dnY9hFYw1SbYHJPZ98qxgjfg6295KwOZ
	dMPA3uQ==
X-Google-Smtp-Source: AGHT+IHiz5c3L+HbXFi2J+BpEhRbGbpZKCFTjF5dKolaGhW+97N+o7e5V/9KYwQhome4h/soVI0ylQ==
X-Received: by 2002:a05:6512:3b0a:b0:545:ab8:2be4 with SMTP id 2adb3069b0e04-54838ef5a15mr1252449e87.27.1740144830527;
        Fri, 21 Feb 2025 05:33:50 -0800 (PST)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5452e4b08dasm2235004e87.87.2025.02.21.05.33.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Feb 2025 05:33:49 -0800 (PST)
Date: Fri, 21 Feb 2025 15:33:48 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Krishna Manikandan <quic_mkrishn@quicinc.com>, 
	Jonathan Marek <jonathan@marek.ca>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Srini Kandagatla <srinivas.kandagatla@linaro.org>
Subject: Re: [PATCH v2 15/16] drm/msm/dpu: Implement new v12.0 DPU differences
Message-ID: <nls3qurambg6ioecf2y7zp74sekgmshlu4nskpelulvfad36lv@4tpangvp7m4a>
References: <20250217-b4-sm8750-display-v2-0-d201dcdda6a4@linaro.org>
 <20250217-b4-sm8750-display-v2-15-d201dcdda6a4@linaro.org>
 <qlotuliwnm5spneolztca7avmh2a46pz2xqlxzqbw5kwa53m6q@oyhnzz7fhay3>
 <4b2426d2-a7bb-4c19-9ebe-77f6a90caf5e@linaro.org>
 <CAA8EJpquBhQeac0E66NqeagkxP-qY0whmah2ND0xziUQdxc_7g@mail.gmail.com>
 <883fed07-1d21-4ab1-8c72-9a1750ec1606@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <883fed07-1d21-4ab1-8c72-9a1750ec1606@linaro.org>

On Fri, Feb 21, 2025 at 01:36:51PM +0100, Krzysztof Kozlowski wrote:
> On 19/02/2025 18:24, Dmitry Baryshkov wrote:
> > On Wed, 19 Feb 2025 at 19:04, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 17/02/2025 20:18, Dmitry Baryshkov wrote:
> >>> On Mon, Feb 17, 2025 at 05:41:36PM +0100, Krzysztof Kozlowski wrote:
> >>>> Implement new features and differences coming in v12.0 of DPU present on
> >>>> Qualcomm SM8750 SoC:
> >>>> 1. 10-bit color alpha.
> >>>> 2. New CTL_PIPE_ACTIVE and CTL_LAYER_ACTIVE registers for pipes and
> >>>>    layer mixers.
> >>>> 2. Several differences in LM registers (also changed offsets) for LM
> >>>>    crossbar hardware changes.
> >>>
> >>> I'd really prefer for this patch to be split into a logical chunks
> >>> rather than "everything for 12.x"
> >> everything 12.x is still logical chunk. I can split more, but without
> >> guidance what is here logical chunk, will be tricky.
> >>
> >> For example 10-bit color alpha looks like separate feature. But
> >> remaining PIPE/LAYER active - not sure.
> >>
> >> I can split them but I would not call such split necessarily logical.
> > 
> > I'd say, the following items are logical chunks:
> > - ctl->ops.active_fetch_pipes in dpu_encoder_helper_reset_mixers() and
> > dpu_hw_ctl_reset_intf_cfg_v1() (with a proper Fixes tag?)
> 
> 
> Ack
> 
> > - 10-bit alpha, border color,
> 
> 
> Ack,
> 
> > - active_pipes
> > - blend stage in LM + set_active_lms
> 
> 
> Ack,  but you do understand that this is purely from new hardware, so
> new registers. Even the 10bit border color is actually for new
> registers. It makes no context outside of new hardware. same here.

Yes. However those changes are logically separate, they cover different
parts of new HW. So it makes it easier for anybody reviewing those
changes (now or later).

> 
> Best regards,
> Krzysztof

-- 
With best wishes
Dmitry

