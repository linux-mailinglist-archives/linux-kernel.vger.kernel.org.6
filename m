Return-Path: <linux-kernel+bounces-259260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED0393932F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 19:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6B5F1F219BC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 17:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD30616EB58;
	Mon, 22 Jul 2024 17:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CwNreV3l"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9727316DEB1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 17:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721669102; cv=none; b=vEu+sQClYI4LSXtwDdbWqRxi59Z4Wf4qeOeNVVrXXrBT1GWyEDr2NcKyYbznJ79K87/mvVrxyR9Gx3cSC2rqSaPpKzzL5iaRXaFtC/LWxSMNvhRXSiTFnRovmszvBsnwh8eMkLqDeGJT2QOEDrsJEs20SVxfGXvVvm3Ecg68pkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721669102; c=relaxed/simple;
	bh=kw0bVtDTHTwovc8PS32qPknhsuAh5ciJPoQH5LDsNlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hL7ilIWDASjag6QkmklRR3NtTGKdsmQZAsG6ejVFxMovmQPUFakdxZsQsQL1NwO3gKDRmUFLxmqmXeiTCvWK0vYZp4mpJ+trVzOWrIY1X1R1G52c3x36hcVQZZeHoRCWLtde0uMrl0xvckHLwegiXGW/Gqhr8llYp9acIp2O5Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CwNreV3l; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-4494d41090bso22684931cf.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721669097; x=1722273897; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Kw2Bwo9a08jpWFROykkB0PNFh++FU/bydYKmyQ3V9Y=;
        b=CwNreV3llu/WgwiYBdTvxaLLjM8M39yiNye8YIGtIL8EsIlOnfgNdQrxUDf4wuGk+u
         oQ/Y1xpb2vtGjKeQjCUILRaELzZMlHsbhDCVWb00OQrZEVEqJ56SizeGC60G7PqSmtcX
         Ej1mhjX1DlUQjwcJIUZK8ZvfNlsOYvT3Bp0Bs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721669097; x=1722273897;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Kw2Bwo9a08jpWFROykkB0PNFh++FU/bydYKmyQ3V9Y=;
        b=s7wwDbOC+soM+Gzm+PYjsWhAtcXuEUIeEKQpBpRYpyDzh/zRHHQ/LJwVTvv3qZTVOF
         1hktRjwl06naodpl/pZQUftIRprmLdGZX2gofysDNzBA7vzPYnHHdNrPjSgBB1BDDK7T
         bSD4cSLwuyqBRmL4Ur9kp5/xglbTO25XesxX8PWtmS3xmsYYDku2KGQwLxruWwa//zKa
         hTcRd/mqTiu1LijpYCBOXQ07hOHypM/viuBMjo07me+ymYfRMjLEF7zm0A581NLNMwsO
         lHc4G1VldglsGPXEeFu6DKahz5dEArRhP2HEpPOZgC3LbBSGcdtoQ6ytqgrhF5yWhdTh
         VMDA==
X-Gm-Message-State: AOJu0Yy5gEImfsWvyWbSUMUqko82gLsN+7gVZqtIwu2F04J/IJJ7lUj3
	qqUxQNesJ0r6nWerbgf4NpzFRdN9th3Ekhnkxr2nKHZQCurp9DSFKk8XAc+cDOOmMhkL0Bbug1I
	=
X-Google-Smtp-Source: AGHT+IGud8OoQ4njZQac9kVBK4C89QLO2WZ/U0sTUy9eyVSPIaDTywqlTdlmZ0HulM9FuDVndbyA5Q==
X-Received: by 2002:a05:6214:29e7:b0:6b4:ff80:ee0e with SMTP id 6a1803df08f44-6b940140021mr116769016d6.0.1721669097458;
        Mon, 22 Jul 2024 10:24:57 -0700 (PDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b8ae76dcb6sm31482956d6.25.2024.07.22.10.24.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jul 2024 10:24:56 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-447df43324fso11241cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jul 2024 10:24:56 -0700 (PDT)
X-Received: by 2002:a05:622a:5b8e:b0:447:e3e3:77c1 with SMTP id
 d75a77b69052e-44faaa81ca5mr5373691cf.29.1721669095913; Mon, 22 Jul 2024
 10:24:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240717093925.3017-1-terry_hsiao@compal.corp-partner.google.com>
 <CAD=FV=XM7X5J6rzu5gDdmDhJ4Ut8raC92HvcnHmRJmWY7_boSA@mail.gmail.com> <CA+hhT3-77s+jjoBGw_fWWjsvO1kDu_JTDHgj=q-pEXcrkzPkLQ@mail.gmail.com>
In-Reply-To: <CA+hhT3-77s+jjoBGw_fWWjsvO1kDu_JTDHgj=q-pEXcrkzPkLQ@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 22 Jul 2024 10:24:40 -0700
X-Gmail-Original-Message-ID: <CAD=FV=U1=5MLUKOok2mTkEeTkT-r504+f9UJuvErLzVbFq_4Hg@mail.gmail.com>
Message-ID: <CAD=FV=U1=5MLUKOok2mTkEeTkT-r504+f9UJuvErLzVbFq_4Hg@mail.gmail.com>
Subject: Re: [PATCH v1] drm/panel-edp: Add panels with conservative timings
To: Terry Hsiao <terry_hsiao@compal.corp-partner.google.com>
Cc: linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sun, Jul 21, 2024 at 4:00=E2=80=AFAM Terry Hsiao
<terry_hsiao@compal.corp-partner.google.com> wrote:
>
> Hi Doug,
>
> Thank you for your reply.
> The patch has been modified and will be sent to you shortly.

For future reference, the Linux community frowns upon "top posting".
Search for "top-posting" on [1]

[1] https://www.arm.linux.org.uk/mailinglists/etiquette.php


> The timings are set based on the panel datasheets in IssueTracker
> (https://partnerissuetracker.corp.google.com/issues/348109270)

FWIW, if you want to privately provide links to datasheets to me to
double-check your work then that's fine, but the above link is useless
to others on the Linux kernel mailing list and people usually don't
appreciate such links. In this case you could have replied publicly
and told others that you'd gotten your work double-checked and that
would have been sufficient for the public lists.


> B116XTN02.3: B116XTN02.3(HW 9A)_HP_ Functional Spec_0617Y24.pdf
> B116XAN06.1: B116XAN06.1_7A_HP_ Final Functional Spec 0617Y24.pdf
> B116XAT04.1: B116XAT04.1 HW 0 A(HH)_ Pre Functional Spec_HP_ 0425Y24.pdf
> NV116WHM-A4D: NV116WHM-A4D V8.0 Teacake  Product Specification-20240416.p=
df
> N116BCA-EA2: Approval Specification N116BCA-EA2_C3_20231212.pdf
> N116BCP-EA2: TFT-LCD Tentative N116BCP-EA2 C2 for HP Ver 0.2-240502.pdf
>
> On page 24 of the N116BCP-EA2
> datasheet(https://partnerissuetracker.corp.google.com/action/issues/34810=
9270/attachments/57530666?download=3Dfalse),
> the value for t9 as disable is "null".
>
> If I have misunderstood what you mean, please correct me.

I've double-checked and this looks fine to me.


-Doug

