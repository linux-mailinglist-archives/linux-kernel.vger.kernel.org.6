Return-Path: <linux-kernel+bounces-353522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89233992EFB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 16:23:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30DC91F248B7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 14:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000751D54DC;
	Mon,  7 Oct 2024 14:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tISX/tgB"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7C0B15D5A1
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 14:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728311019; cv=none; b=J5iKP6Vye2d41vvlKcm81Tt/GBkb7FAf32dZhRYWrTXXdje6/j9wz2YqeCHZIzlKq6fEXp9jIp2la7/WawIZvo4N+jxhu39iVP3J4GsXrilQxWo+5KBauwB9U/EsCYC9bwFkD4Kj+BMNr/sF00z+xR2cQtKQERWDSBM20RgEoCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728311019; c=relaxed/simple;
	bh=sQIRs9DtatqE47/uuL7DROgMBz3p66i8n7KBGfN77LM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lo1FU676OQJsgnimKNui+dMgJzcZO6pfia/IFgNYBJ/xiLuQuXWLCk3ZMlKKvycZhmID02hR4EUEaZ1K+abB6GdulPFkFm7n8SFEZcnerqXW2AXTy/RjyERA/pRfXVJ1V4u0dHGf34QKihcGdIPwgqFkMh4G+pr78QpGbJM+LhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tISX/tgB; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e2ef9af517so9965377b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 07:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1728311017; x=1728915817; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sQIRs9DtatqE47/uuL7DROgMBz3p66i8n7KBGfN77LM=;
        b=tISX/tgBp229b6Q/vKwSOzXHKdC3nxyYyadJ0QB1CCUGN13FCDti1yWKJETzBbYu39
         QZqFJg/JdWQf3Kxupr7O0OAll8XqXaiMIM5MMyOWIMXciaF4Sc4Ascdh/tnJNJOCaGa3
         HKHnet/QNxn3KWuY0jK9ZBtG/Qcq2vJehFP+de7lE0vl60tq/mmnWkt2C3qLMtO8A3o6
         4eYyIYVNs1ret9TIAypmIcnBTKX7bbwJexlzE8k0dAx3n3JyrXCfjxrpomMuMUP+fLus
         P0UbK8FLARKVXY1uZ5h02lhHxSiaBBymlLQ54MhG47uOKDWUzJNDcH/la2+rOGsHd8Dg
         hrnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728311017; x=1728915817;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQIRs9DtatqE47/uuL7DROgMBz3p66i8n7KBGfN77LM=;
        b=H/Zl5noRfRENZJtfQBu5O1TVeSOqlB4Sw1J9u0B7pRZF1fgCg8NsNszI40Pc7a3gHw
         WlNV5GdnRu15LLHHe4hKMcfKxteWp8oaM28oqwzck9ZERe1k5xbXvsyRqPKg28ih143W
         L+CIi1ZT4vyAyXsVvEye5uvtfqucZ02xB/hJRIgPpttpzetHeqf43duAsoGLM55jjYVK
         fYrhIvghp7yZs45Qk2AEYEoSv1r2gQw4NoO+uv0DIuZIojV4BZKNYiiq0qyEkLBotIq8
         0z2adHvD6Tb37XnmdN3fuuKnyLAhLm7uwdq0z41zPAmOMOd4arIyz0t5wRjF0iY3cB7Q
         qoKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUSCXSnMgU4hU3vFwO/hjv6GC4n2hhyN1urf/oJEwbZwtUgDUCdmnncu/rpjm0oGrXE6EBiFqyUuGx5dw4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQe/Sfkss3nsBFMLZhHEa2cBrso3I1d2FzB2XSPm993fcUsHoU
	19FeR/LE/tJc/oDwyJLSEWEzjh+Pp1qoYKG6LWUai3E4iWhyqJldADJzHn33K+YqGhTbgG5PHkA
	6hfuIfXLMCy/A+bFUMZiJLwJm9R5zmDTwz1Oo1g==
X-Google-Smtp-Source: AGHT+IGbKaYdYvNXtodRPEpekH5GsR5hqwr4S76hZ1k73gzB88gyl7RxLM4wcUiR/GuN0qmmVPqnBOpOSBZ5Jwq46ak=
X-Received: by 2002:a05:690c:89:b0:6b9:d327:9ad6 with SMTP id
 00721157ae682-6e2c7295bcemr87692547b3.33.1728311016940; Mon, 07 Oct 2024
 07:23:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241005140150.4109700-1-quic_kuldsing@quicinc.com>
 <20241005140150.4109700-3-quic_kuldsing@quicinc.com> <ylfkupkpy26gupri4lbwij3sh4uwrm7lxr7q7q2rhrgiwai6mc@bkplz3mlrsxb>
In-Reply-To: <ylfkupkpy26gupri4lbwij3sh4uwrm7lxr7q7q2rhrgiwai6mc@bkplz3mlrsxb>
From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Date: Mon, 7 Oct 2024 16:23:26 +0200
Message-ID: <CACMJSevsbXeVV8t=nZ1L_ZCefuaU0Ew5=VFcSWTSHpMj_Bo92A@mail.gmail.com>
Subject: Re: [PATCH 2/2] firmware: qcom: qcom_tzmem: Implement sanity checks
To: Bjorn Andersson <andersson@kernel.org>
Cc: Kuldeep Singh <quic_kuldsing@quicinc.com>, Konrad Dybcio <konradybcio@kernel.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 7 Oct 2024 at 03:18, Bjorn Andersson <andersson@kernel.org> wrote:
>
> On Sat, Oct 05, 2024 at 07:31:50PM GMT, Kuldeep Singh wrote:
> > The qcom_tzmem driver currently has multiple exposed APIs that lack
> > validations on input parameters. This oversight can lead to unexpected
> > crashes due to null pointer dereference when incorrect inputs are
> > provided.
> >
> > To address this issue, add required sanity for all input parameters in
> > the exposed APIs.
> >
>
> Unless there's good reason for the opposite, I rather see that we define
> the API to only accept valid pointers. Then if a client passes a NULL we
> get a oops with a nice callstack, which is easy to debug.
>
> The alternative is that we return -EINVAL, which not unlikely is
> propagated to some application which may or may not result in a bug
> report from a user - without any tangible information about where things
> went wrong.

Agreed, I don't think this is a good pattern in a kernel API (as
opposed to user-space interfaces where we validate everything). We
expect a certain level of sanity from in-kernel users.

Bart

