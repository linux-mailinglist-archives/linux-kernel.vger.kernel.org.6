Return-Path: <linux-kernel+bounces-324798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCF19750F9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 13:42:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95790285C0F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 11:42:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA5B187866;
	Wed, 11 Sep 2024 11:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="A0Xd81HI"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B42187336
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 11:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726054934; cv=none; b=Oc5jclTBrH1M/IIyPr8TbBMlTlXn84JaZHBolnhTzWRV9f5I8EOPJ7CDRjrYeV5Jh0DwBJSKhP3c739wmgbMTYrhd5cRu8vTBQdQa66OXuT4DraAvpDZTSySpD2Ii9HLnG5cld3ALNs5yRYpbrKJLNpF6SdhcakVhM8mQf2d3yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726054934; c=relaxed/simple;
	bh=O2Sq+D19rPPOkL3YgEEm2sHTX4Ks9lKnmYnH5POWRho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m/H9z9akhSMjogwdMJvTdQ8D4shUcmoXFqMDkndgGz5EWWs1ryUmveU0XRMlafqG4z2L0sHVbv4UiKPtDuKF+3iP5JPjpam6nFCbhLbCPAfAqGXtKNjLfTttuJzE4BFh+FB0Qb2uL6/ijPzpr50Vox0kiXMpZ4N/6cUvLKhFd5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=A0Xd81HI; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2f761cfa5e6so47478811fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 04:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1726054931; x=1726659731; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2Sq+D19rPPOkL3YgEEm2sHTX4Ks9lKnmYnH5POWRho=;
        b=A0Xd81HIFb5q7swZZ0LEirx/YFU7SWIN+u8n+1EY5Saq/sa2R1uM8WNrPSawUXM0Ks
         nCp0aulATCCwcnySjq6PbAr7rxZTgkDH1BoGuhH7t6Fx5uzoBFbDMk5lUO9NC4XJ6msD
         c7Pfk/hvdP6+IhqIEGVL382vIppNYgVPBmdcfXKUBgwF7VEAcpmuRO7az0TYt6myyofP
         Vd0gI8ZwR1yvmpYcASZ9NY5wmcepEJEtQVVIIRdAtMWi/qHCTiNaGEuQPghnoNhRhaxF
         zVcvhZcOair61hpSt2BTa8Q/5ooS98ZcQO5dLdKvGYl22QIw2xwMCE7gY8vA6VSkibWt
         2DVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726054931; x=1726659731;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2Sq+D19rPPOkL3YgEEm2sHTX4Ks9lKnmYnH5POWRho=;
        b=up0a0/17njA+/BOpPB05PBavnS5nPYZNsNOGLfQpXiqBwgxYlHz1l6SFf1m8a35inj
         pKBGdjfevw0j/WXss58p2ib5eCoeNLoNN3i8wzQctOlVA7hg73dvKNwD9zQlf6ETaMca
         ywsbnzTUl3N2tekAHC2pMWrDKTzsMUSddF5WJdjQIZJAcgYs5PWYP5SuVWWh7FzOzkVl
         Mmxj6eTPOGbclEh2vrn+xfsG9c/h+7dBFHMWOt1JhFczo2xW54nWwgRiG6MD3ZgHUZsc
         bfA4XOpXM5oKRiEbUgK0MN5HkWwWcO2N7ENemtOn3dXun++UxIOC6WZrExQfAC498KmM
         H3IA==
X-Forwarded-Encrypted: i=1; AJvYcCWOrZtZ/t9hcDDPwgyFusqfMzZ7H/NH5MiZ0dD03cChwvfCxaEQxifP4DCY/hDNlk2bjWA4yqo+XYtLv2o=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCHVKXjCL8Ju4gpYfZiCrIBjbER8pMyvViWjGtGf6pfh8DlI4R
	eiY38bFU+3v8km/zZ2mAboaTD7Te7k5HnzxmJipTdf5hIcSuwCm2Mdc1M8uU/WKi13X94XCvpLg
	4kmXXzpN/O9/OpyoMn6kbxbJIjhPTqWHCs5kR7Q==
X-Google-Smtp-Source: AGHT+IFcHy4GccUogPshb+I8zndIaHpSY0pzAdijqWuA/NDAsNFlyAXCtC9O/q9g2HYU8bl4WfFykffAMSm3h0X4xpU=
X-Received: by 2002:a05:651c:b07:b0:2f7:56c2:7288 with SMTP id
 38308e7fff4ca-2f75b87f0eemr82376921fa.7.1726054930020; Wed, 11 Sep 2024
 04:42:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240909-tzmem-null-ptr-v1-0-96526c421bac@linaro.org>
 <20240909-tzmem-null-ptr-v1-2-96526c421bac@linaro.org> <20240909131842193-0700.eberman@hu-eberman-lv.qualcomm.com>
 <CAA8EJpqSKbKJ=y0LAigGdj7_uk+5mezDgnzV5XEzwbxRJgpN1w@mail.gmail.com>
In-Reply-To: <CAA8EJpqSKbKJ=y0LAigGdj7_uk+5mezDgnzV5XEzwbxRJgpN1w@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 11 Sep 2024 13:41:58 +0200
Message-ID: <CAMRc=MefTjz=h6jzE5vE-yaHnyM601Ts8XYZqEYnOsidfQEavA@mail.gmail.com>
Subject: Re: [PATCH 2/2] firmware: qcom: scm: fall back to kcalloc() for no
 SCM device bound
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Elliot Berman <quic_eberman@quicinc.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Andrew Halaney <ahalaney@redhat.com>, 
	Rudraksha Gupta <guptarud@gmail.com>, 
	"Linux regression tracking (Thorsten Leemhuis)" <regressions@leemhuis.info>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 1:06=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> >
> > I'm a little concerned about this check. I didn't think making SCM call=
s
> > without the SCM device probed was possible until this report. We do
> > worry about that in the downstream kernel. So, I'm not sure if this
> > scenario is currently possible in the upstream kernel.
>
> MSM8960 and MSM8660 don't have SCM devices. For MSM8960 it should be
> trivial to get it, c&p from apq8064 should. For MSM8660 it might be a
> bit harder. But even if we add such nodes, we shouldn't break existing
> DT files.
>

I'm wondering about how to approach an eventual refactoring and I'm
thinking that for platforms that are known to have DTs out there
without the node, we could exceptionally instantiate the SCM device
when the module is loaded? And then modify the driver to require the
provider to have an actual struct device attached.

Bart

