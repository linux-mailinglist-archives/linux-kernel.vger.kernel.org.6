Return-Path: <linux-kernel+bounces-197138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E27C8D66AF
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 18:21:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F83F1C24863
	for <lists+linux-kernel@lfdr.de>; Fri, 31 May 2024 16:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F92158D8D;
	Fri, 31 May 2024 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="a3G1jFCH"
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111E2145328
	for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 16:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717172481; cv=none; b=FzFdSwb+nMcdUSdsbCv4dxleerzPV5UhJWlZxBwDt3K+ZqiD2tO77nEf1eXux4Kh3wVvNR4dBb2bK4GKS06+SZGbWLCSBuFHAI27sysDOP97aPQMSROSUp19fQczmwh/HtM2qY4vbMuXiUomJyTMPaTAQseFI3GBMQ+1P2K+6mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717172481; c=relaxed/simple;
	bh=nvY8T8Ok0QulhK6MiIwjO6JnMW3LaS4gATuYYnuUhy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BsipEqRRFdM/QgaRmS9KSywrMtNAjtEpUhasubpyymn7tcm1VL9d/NrVhKbLvPPeCOgalGbF0Lold+rZ0dsCO2lBTcOUT+gfjERfbqYNfuBOseAsbpc3ePXAaT8qs5D1GslY/ZyiMqC6ESG49KeorGk4QDIJS9blMALlNcu64cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=a3G1jFCH; arc=none smtp.client-ip=209.85.222.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f169.google.com with SMTP id af79cd13be357-794ba2d4d82so107068585a.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1717172477; x=1717777277; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=siXueITpdXmllfrhOnciz2l6HSxbQMeuCE6GtcEy6a8=;
        b=a3G1jFCHy1Ghhw6/DTUruHZJv13CKYdwDR6RGLDvZPdrsB/O1JKklDGGvOPmXTfkHo
         Ip9Vd08iHkY4XiUC4ShUqPJoCja4vfJ2TK0lJ2hgsofy4BUxkWa0uZHF3zDeY1x/t0Ab
         D+bPL3xYzn8406NTmelVDDOv5XjLDNYs7yJ2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717172477; x=1717777277;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=siXueITpdXmllfrhOnciz2l6HSxbQMeuCE6GtcEy6a8=;
        b=QQ6WS3EsdGpZgjUt2LI+ldcZf3vd+3FBYV1b9HryJwgKRRh4CwY1c+e9Fy70OoMTdi
         Qc40WjqJP7onrjrcEwjPzKyrVXsXsCbIfVDZhxlpwGkPO6/v7lWGCd0TasyLwsuVokUz
         asPB8ehvagkGCuqR5GCkbIKhq8/nTjaUIUrLcBiesbvdZhZb3l1Z53N3su6lxyJrBa9H
         bqmTSC5lMoxrVlLwKcELPusVy507pOCzZeB5cIsYmFmUR73XHDYQaNI5f/lllaLz8bHE
         yc/9Qf8+GpZYyqBn8gcwK+D20w1/CGPo9AmSbfUsBSE5uLToYTB9hGv7IvlZONFRQpT6
         DC9w==
X-Forwarded-Encrypted: i=1; AJvYcCUokAx7SudzNadef4PV0Z/XBLJ8NOF8JcIdMUs0sIGcztmMBJcg5HbSuXOoRIcvpdlRCvc+cQEkRVkIYxQy71XLBVF3zGWuS/CZsoZF
X-Gm-Message-State: AOJu0Yz+X2g9a55kMmBGDSJfGl+1q5lB5OZzpi7eOPgmbXB0rxgVaJB2
	0PANd0WiPM43Lt2J+opJ1MzXnB4hkO0TKVXnxx2UF4C7y5jcIqxmm4wqIFPPxykzPyCckwiHgLj
	8h+UR
X-Google-Smtp-Source: AGHT+IE6DkjKT4hHom0gDsS4c1jLWgO4NpXpA4y+if5RwWJXJbUhztcjACuwvhF02dCEcV/KB/UZ6w==
X-Received: by 2002:a05:620a:e0b:b0:792:bb55:906d with SMTP id af79cd13be357-794f5c88d1cmr219108385a.39.1717172476930;
        Fri, 31 May 2024 09:21:16 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-794f3018c11sm68803485a.67.2024.05.31.09.21.15
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 May 2024 09:21:16 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43f87dd6866so435711cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 May 2024 09:21:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXYSay8syySFNSnZ19WG5Q4KfjIcFAflzNqTephKgp8RAJE2Gn8Qws2tphldUu2IYBb1CeX3zOj6Q1C4GL6zIWM92inIhJfzqw6KE5U
X-Received: by 2002:a05:622a:4a14:b0:43f:b19e:d3ba with SMTP id
 d75a77b69052e-43ff2c5399bmr3052241cf.8.1717172475232; Fri, 31 May 2024
 09:21:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240531-edp-panel-drop-v3-0-4c98b2b95e3a@linaro.org> <7428a2f7-befc-6db8-76f4-3ca8dc12d31c@quicinc.com>
In-Reply-To: <7428a2f7-befc-6db8-76f4-3ca8dc12d31c@quicinc.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 31 May 2024 09:20:56 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Xcq-p5OxSnDJVF-Wp88ZfXOaOKJmh941ymy-f0wkhdhw@mail.gmail.com>
Message-ID: <CAD=FV=Xcq-p5OxSnDJVF-Wp88ZfXOaOKJmh941ymy-f0wkhdhw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] drm/panel-edp: remove several legacy compatibles
 used by the driver
To: Jeffrey Hugo <quic_jhugo@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, May 31, 2024 at 9:18=E2=80=AFAM Jeffrey Hugo <quic_jhugo@quicinc.co=
m> wrote:
>
> On 5/30/2024 5:12 PM, Dmitry Baryshkov wrote:
> > There are two ways to describe an eDP panel in device tree. The
> > recommended way is to add a device on the AUX bus, ideally using the
> > edp-panel compatible. The legacy way is to define a top-level platform
> > device for the panel.
> >
> > Document that adding support for eDP panels in a legacy way is strongly
> > discouraged (if not forbidden at all).
> >
> > While we are at it, also drop legacy compatible strings and bindings fo=
r
> > five panels. These compatible strings were never used by a DT file
> > present in Linux kernel and most likely were never used with the
> > upstream Linux kernel.
> >
> > The following compatibles were never used by the devices supported by
> > the upstream kernel and are a subject to possible removal:
> >
> > - lg,lp097qx1-spa1
> > - samsung,lsn122dl01-c01
> > - sharp,ld-d5116z01b
>
> Ok to drop the sharp one I added.  It should be able to be handled by
> the (newish) edp-panel, but I think the TI bridge driver needs some work
> for the specific platform (no I2C connection) to verify.

Is the platform supported upstream? If so, which platform is it? Is
the TI bridge chip the ti-sn65dsi86? If so, I'm confused how you could
use that bridge chip without an i2c connection, but perhaps I'm
misunderstanding. :-P

Thanks!

-Doug

