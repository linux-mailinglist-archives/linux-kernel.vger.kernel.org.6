Return-Path: <linux-kernel+bounces-321324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763E69718BD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2C6B1C22A2D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 11:53:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 354BF1B374D;
	Mon,  9 Sep 2024 11:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iGedZ6ML"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242221B5ED8
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 11:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725882759; cv=none; b=bBdSfn18j7Jz3kLn8FE2pahWgZ7wN68YXbHBmm03j5MrxImcfjP5tecjeu6eTYxA/7i1Qw6Kmy8vaTWwTeXXCpWKvj644/0aDbZAKA57YdbBAQ2V33h8YPQec+H3n08NixGlXHt49/o+PfR23SZtUOv7qnrxBLnigce4TIL2DE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725882759; c=relaxed/simple;
	bh=hKPc/3t2Dpte9QvhQ5bgGby31S1S30G65rFyRcbAFk0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SuoPwWljU8k9mLNiGop8Sr4pDh/c524vnw71SWgBXn2Y9NYwP7LsRin6N54ZIiI+Btk+xmaUB5EVl0C7nLSm4xRW5oCaFpWwvH1AtGqo2ESNjVUd9lknL83JmivLEvFeiUXociZdAa8cgqCBFAylhe3vapql3wizWjPDEGC1Tp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iGedZ6ML; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6b47ff8a59aso40893187b3.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 04:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1725882757; x=1726487557; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MMtCp8ATO/sOcs10GHw7/+crLwD+Hw8l41IBIY7otQg=;
        b=iGedZ6MLVDkGBWYN4YECrjaCV8PZ6Ld0BjtHBmrT69CNH4Jc36P5TMLTY6p5WmcHZ+
         NZlCUq/3gnQKXPSkz2+nuXmb/U9YnmIb552Xml1nnVHRuKZhv3Awy1YH8Je0crdK6Uff
         xCmMMBT358I4Yz5yJyK1pUIlFLZ1XuhjwHjcmDKs7GN98iDaTsQPvzsr8ZUnkHZHlQrD
         /HmdkLI6WBEfXRGV251foYRCv2grxqkl4ybkejPfUrz2fmnSIEQSFvYcsG7rUW9/ODzC
         N6X0tUQ1V+4i/RjMWupHjos0A3ViN6x47HVDR7Id/eQ0MbPohm3Av46aXhgRWq2LjeWu
         x+tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725882757; x=1726487557;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MMtCp8ATO/sOcs10GHw7/+crLwD+Hw8l41IBIY7otQg=;
        b=bbWous+QMXL4J11g4D6UK2Fqm5Pr+pYPq02VB8P4scHk0P73pIBndbvxiM7p+yyX4t
         n2FSunLK/PK3pQhwSN71ZsG+YdFCBThyj9O8+l24gZ0O1WZgfQXCRKNPEtUU1DjJW9W9
         /c3IjZ554R3pefhXXCpP51JvCmDOkv/KRGNr1WBr+B4FtIC9OuYYwmx83N8b75iU6usp
         I6eYQBbZKvM9N3SiwhQRAfvB4yG08zIlUdDhgiWX6yyWal5eoetXib7Vpiim0KPt7/0h
         9oSfFE3nTHdrljKFaT7HJb7lfH5IwFjD8ncCwue4+ujKw866iSbp0fXGa6pRrgOXzu+F
         T/qA==
X-Forwarded-Encrypted: i=1; AJvYcCWrHCK8W/tgKCkD8CGQGFH/zb4h2AmsrYgHxX4GHe/StPQRJAhoCSJC0R94/dVxn/D6U8YyRvrsw/v6kwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO7EVyMClBBGxDdyVjNzl+gBj+rvn9sdCpCOJXUpU4W9BTvBys
	o0n1jFxUKGHINnbbQEr1HSlY/wENcJQIJaNnxoqqW7XzNxv2StHnQ/Iuwnd1I66W0l8RQVZaefh
	VceneSt/AeMp6U769VIQ2mulM5TEhBKdM8qjXgQ==
X-Google-Smtp-Source: AGHT+IES2R/I84SVypbTZHwAb2uGqV81o7Zid/P12Fyb+DQeCila7SGmdEBvAwfhacegWh9dEh3FskbNOuYzbfjbpH4=
X-Received: by 2002:a05:690c:113:b0:615:1a0:78ea with SMTP id
 00721157ae682-6db4516cc79mr112532817b3.34.1725882756938; Mon, 09 Sep 2024
 04:52:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240908-adreno-fix-cpas-v1-1-57697a0d747f@linaro.org>
 <c77ab7a8-49aa-447b-b7ac-18dd5c2eeecb@kernel.org> <CAA8EJpr4sMEmywD3qO8co1ZN3jG5w=dsfDYYmY90baRne3dHSA@mail.gmail.com>
 <88c4eab9-0e12-4eee-a04d-110b6228ede4@kernel.org>
In-Reply-To: <88c4eab9-0e12-4eee-a04d-110b6228ede4@kernel.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 9 Sep 2024 14:52:25 +0300
Message-ID: <CAA8EJpqUAYuUrsijSs0Ncy+KT8KsjpXWMb92aZVhf=Ub_c-9iA@mail.gmail.com>
Subject: Re: [PATCH] drm/msm: allow returning NULL from crete_address_space
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
	Bjorn Andersson <andersson@kernel.org>, Jordan Crouse <jordan@cosmicpenguin.net>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Sept 2024 at 14:29, Konrad Dybcio <konradybcio@kernel.org> wrote:
>
> On 9.09.2024 1:25 PM, Dmitry Baryshkov wrote:
> > On Mon, 9 Sept 2024 at 13:34, Konrad Dybcio <konradybcio@kernel.org> wrote:
> >>
> >> On 8.09.2024 7:59 PM, Dmitry Baryshkov wrote:
> >>> Under some circumstance
> >>
> >> Under what circumstances?
> >>
> >> This branch is only taken if there's a .create_private_address_space
> >> callback and it only seems to be there on a[67]xx.
> >
> > Existing code doesn't. I stumbled upon it while debugging private
> > address space translation. And that's why I wrote 'it might be
> > required' rather than 'the function returns'.
> > So yes, there is no issue with the current code. And at the same time
> > not having this in place makes debugging more difficult.
>
> Feel free to submit your debugging code in a way that won't mess
> with non-debug paths then.. This is trying to solve a non-existent
> issue.

Ack


-- 
With best wishes
Dmitry

