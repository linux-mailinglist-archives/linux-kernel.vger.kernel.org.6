Return-Path: <linux-kernel+bounces-324812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB4F975141
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E84051F2872E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1D7185B6F;
	Wed, 11 Sep 2024 11:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d3LCIl0B"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF29187355
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 11:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726055740; cv=none; b=FecntWYxetFlvNgQDTGMnnPz4YScUo+Bot2wfKTI57WhqfAgzrUM0sXEYtd60ABW+Y5dd5Chc9LhkdnODIxEjKCNAwY3+Hsn4FAA2gtVJRnDH+dMcy4qC/Q3dGG2T7qv+XMLi7mOEZHCySMLLWSm9jbehKzqio+iqBzWBo5HOoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726055740; c=relaxed/simple;
	bh=Zn3zRJvXUaDfbrJCNeevk0c7vO7Dfl2QKD/gE4nDtVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PRWANxGlLnZ0A99DUALzK28D/77ASS/hGmh2rwfWbnIp5vn/BAhm4uONwDS4WeQHWsxUzKesREH9q4jXrrtkGb2oVuEP1phtf2bCcJgKfQvYGgVnFoAUvTmw3Fnc413HvkEHTZZxn+SUGEumWrK3yJnJfV5g0VzbwJ3tBZSy8o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d3LCIl0B; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5356bb55224so7854578e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 04:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1726055737; x=1726660537; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=w9xRxPXR7MYLf3EpSXwpqv7QhwbhzS7poxIdBzlqzpo=;
        b=d3LCIl0BCOpeAcajH7zj8bv9FfXZtYUuLvfmzF5DJ/gUwcZzryX5tVFQ57kt4xHHbp
         B1JvVQssow8FbYUOCHymnwQGdLEDU3ClHQ0YA+wwIDEmiEJu477tjAXRtot4ZOLXoS4M
         GOiSkmhfyC3VaOr8CYCgLtgbTakYR7mXBvSDTMWZz1vo/4LTa8XKoJl2xHGlL0rvUPj9
         1yQQzZ0uaOXLdo9tXLZngea31qbtzXObnG9pBBwNjMrkhuJcdJ4oF7Xka7XSulDxSWmi
         0w/P5ziwBQ0rBKFl88/iZUsFIZ8BbTvjVptN9nxZsuqN9U9+MUy4H84V34EAvPr3vDpD
         7GaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726055737; x=1726660537;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w9xRxPXR7MYLf3EpSXwpqv7QhwbhzS7poxIdBzlqzpo=;
        b=Yv0droESA8k4ju4xmTEw1W7K93vFpA6RgJRn/AUq1X5roudbo1rLRLRVGSiIy/QfAF
         g5TSG2WEdWd6oIyYF9CsneIhLBGDKPaMc98fsTf+zj8dPHAFEMgOimwtSgbSGwPDQldo
         vrS21od8vIjxCRPNv96qR2/AH1fAz6e7dKKjA/v9ThS1AHhuXlo8vocxZDtFh4FOEvjt
         OJpgn/dsGsuQ8bxe1ADGQ+eM6vmZb4BKkCprn2hqyxOA7h7NaP0Rc1+VlX3H/UUsdS0D
         T/SrYyFf+LFkJTc4a3wTY1XsLA7R8Bm6xlALk1ckuSiwJ/11hUvNTDv1fltJkpW/7Iij
         iQFg==
X-Forwarded-Encrypted: i=1; AJvYcCV+S225Pcf0844iwFf23nZ/fkLUYKBZJtmkVFnyvWv2oCuBxQyMZBFIe4OD5lcavifzYx8qetNbi5VUF7I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+Ym48xv+H3mQO48aTqaz78M87urKesp4RVQzlX2+9ztFY49Pd
	8JRSvz6cvlu3/bDdxNYkjkdS4A5ceKJrqMGsf4pst8SgXKZOFcDEY7HLEhdmUgA=
X-Google-Smtp-Source: AGHT+IHMGJNyPUGz02EM1TBSiYL2OAdcojSToq3FajDA4bNtBXDFAOhbR/GKBAMhNG+aMlDMEcrs7w==
X-Received: by 2002:a05:6512:3510:b0:535:6033:265f with SMTP id 2adb3069b0e04-5365881027emr7647509e87.58.1726055736272;
        Wed, 11 Sep 2024 04:55:36 -0700 (PDT)
Received: from eriador.lumag.spb.ru (2001-14ba-a0c3-3a00--7a1.rev.dnainternet.fi. [2001:14ba:a0c3:3a00::7a1])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f903cbasm1538550e87.203.2024.09.11.04.55.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 04:55:35 -0700 (PDT)
Date: Wed, 11 Sep 2024 14:55:34 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Elliot Berman <quic_eberman@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Andrew Halaney <ahalaney@redhat.com>, Rudraksha Gupta <guptarud@gmail.com>, 
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 2/2] firmware: qcom: scm: fall back to kcalloc() for no
 SCM device bound
Message-ID: <azkfnnz3pmabhnongejtomab7ytoshpdyoutyawf3j6lodmbog@q3ywqp377p4b>
References: <20240909-tzmem-null-ptr-v1-0-96526c421bac@linaro.org>
 <20240909-tzmem-null-ptr-v1-2-96526c421bac@linaro.org>
 <20240909131842193-0700.eberman@hu-eberman-lv.qualcomm.com>
 <CAA8EJpqSKbKJ=y0LAigGdj7_uk+5mezDgnzV5XEzwbxRJgpN1w@mail.gmail.com>
 <CAMRc=MefTjz=h6jzE5vE-yaHnyM601Ts8XYZqEYnOsidfQEavA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MefTjz=h6jzE5vE-yaHnyM601Ts8XYZqEYnOsidfQEavA@mail.gmail.com>

On Wed, Sep 11, 2024 at 01:41:58PM GMT, Bartosz Golaszewski wrote:
> On Tue, Sep 10, 2024 at 1:06 PM Dmitry Baryshkov
> <dmitry.baryshkov@linaro.org> wrote:
> >
> > >
> > > I'm a little concerned about this check. I didn't think making SCM calls
> > > without the SCM device probed was possible until this report. We do
> > > worry about that in the downstream kernel. So, I'm not sure if this
> > > scenario is currently possible in the upstream kernel.
> >
> > MSM8960 and MSM8660 don't have SCM devices. For MSM8960 it should be
> > trivial to get it, c&p from apq8064 should. For MSM8660 it might be a
> > bit harder. But even if we add such nodes, we shouldn't break existing
> > DT files.
> >
> 
> I'm wondering about how to approach an eventual refactoring and I'm
> thinking that for platforms that are known to have DTs out there
> without the node, we could exceptionally instantiate the SCM device
> when the module is loaded? And then modify the driver to require the
> provider to have an actual struct device attached.

Might make sense. We should be able to test in on APQ8060 = MSM8660.

-- 
With best wishes
Dmitry

