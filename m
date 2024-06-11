Return-Path: <linux-kernel+bounces-210275-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCA2290419F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 18:52:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 874481F25D95
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jun 2024 16:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43CB4823B0;
	Tue, 11 Jun 2024 16:50:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VFCTy/gJ"
Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C4647F5D
	for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 16:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718124617; cv=none; b=B27seaNsZYuKgoeiAXUWi/2UOGQuI7rcD0AesKfG23ocSH2Rs+rEeVHYDMN9GYwRrRhvQLcwnh72EHAfDlWSMUf8L7gH3ygVQTcvLtGv6Vm5+OXxNsRHyedLS0JYGjZO0wJYJrIz5Bpd9jQYuya1wn03KdqgAR5kAUM/JMS7yNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718124617; c=relaxed/simple;
	bh=S0XuMDRDWpXOBdAPwQUmPVsc22XbW+IAi1HUrnJZSy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CKyHxxhmHLUNhYoSUghBf51QiTcnGyfdgNe9Lu87jAMiw+c4c5adGvdSmr1uMLhdnZpN+rH39YZXBLHhBConz4wpZgG07tavYe5Sr3LHU2ue/8rTPMOu4jg6NvdVhSiMceifPFRIDjewTquAY/R0/X4PkKOPJdiPrMM2Dm961v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VFCTy/gJ; arc=none smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-3d226c5a157so1686797b6e.2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:50:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1718124614; x=1718729414; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0XuMDRDWpXOBdAPwQUmPVsc22XbW+IAi1HUrnJZSy4=;
        b=VFCTy/gJCkpZ5A2Dg74Dg3Gh2RQkiePYlnvb+L4hy2eWWplxN7CcNSrd+luyFcUsFk
         V3/PKA+agPU+2iJ510HVrdIvulV2EaUhK6MUqKPIhwo2SYK5htJVO8A2aAiGzK2w3a9a
         X5/A1H0S/Ekr2WQvF0OJ0+cOCZdBoQmjvLo+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718124614; x=1718729414;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0XuMDRDWpXOBdAPwQUmPVsc22XbW+IAi1HUrnJZSy4=;
        b=P+7zUF4Do32fCYbBwBqceq4755NkEgYXiYrebD9JisKKJOgLVKMTdCJjSxISi3aXhk
         f0zLScDrK8T7Q1sMlfs5QfHC8/4RNRcU3eUStRtKwVDV+yisN29ZbtSsH0SWzACxZgmC
         CkJmdtxC1h3kzaIbNogsB1pkAW2vJAJUaSm+vNbV1VssgR2ElPTcSMxLuzVjPh0KrK3D
         +jr7XRIXWc4bJktrNxtyxo1pOLPS+NGfPxlhSSmXI2Pja1q7ThY1R94INfWIgRD1QyTi
         bYpwxwmazwvCYM/nBFXEYr+J7LkjbbjpU/UNRClCcBarg4dM9qGTzEWj7eQLgnTUeBAV
         dcKg==
X-Forwarded-Encrypted: i=1; AJvYcCUmsHz/XHU26uyLfk4j4mnn4CNy6HXDOyDt9YaokdxRWxFE6pLQulIcbcWFDLCMoHo/cO8pTqyyqeQkYb4L3bh81bNPmR42WAraXBwE
X-Gm-Message-State: AOJu0YxWlhWWx4XCNFZyz8l7x9gR3vz465WgP+dJh2HQsSL4tqz5dw2e
	8z8lIDCkhbU1pJomYF6q4+PyEQd4PcdpOLKcpG/gqZ47IyZ27wBW6Sl5NosUTEZXOJn3nWAP7Uk
	=
X-Google-Smtp-Source: AGHT+IG+JdFZI3veExrLWF1PhM4F8Tj4DN3RkoTACwMDgd0CZkSHdCtaLBDehMwmo3REbOpOUhNzSw==
X-Received: by 2002:a05:6808:18a5:b0:3d2:1888:94a7 with SMTP id 5614622812f47-3d218889926mr12660441b6e.21.1718124612672;
        Tue, 11 Jun 2024 09:50:12 -0700 (PDT)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-44038a9e4ebsm48001071cf.45.2024.06.11.09.50.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jun 2024 09:50:12 -0700 (PDT)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-4405cf01a7fso395321cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jun 2024 09:50:11 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWWsnRuOw7c1820+zHrpX+aQN1bM7rqmLqAKbW9YFOMDxzgZaBgcJ0aGsJmuBiUPP3SXJEHRgfRHnxXPIFsng7MQhCl8nrzJqWCfbMH
X-Received: by 2002:a05:622a:5e85:b0:441:4878:1238 with SMTP id
 d75a77b69052e-441487812b8mr3625141cf.8.1718124610639; Tue, 11 Jun 2024
 09:50:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422060811.670693-1-xuxinxiong@huaqin.corp-partner.google.com>
 <CAD=FV=WRLLuOkCJeM6RdAb6xLN-cPH+hfWbOv9-LujB-WMGEFw@mail.gmail.com>
 <CAGoogDB-mj8_xu04w3V2ZxOBTWoXcPKrVR1NRt6BFcpjHX3-7Q@mail.gmail.com>
 <CAD=FV=WwsR9e-ZXJRY11FvdUZ66YPy9vqmY_=sGDw5Wqk1eV3w@mail.gmail.com>
 <CAGoogDBCzfKwkAA-VAs3_Cdw_4oFO94mt7yjy47Sp2RAtqtPxA@mail.gmail.com>
 <CAD=FV=WYiD-BUpksBnZrkWvORepZqtaAvm5645X-_oJPea0s0w@mail.gmail.com> <CAD=FV=WMC0XZBc3UKP+Qzb5aeiWBnXrYDf31PNP5cGeAT-8XcA@mail.gmail.com>
In-Reply-To: <CAD=FV=WMC0XZBc3UKP+Qzb5aeiWBnXrYDf31PNP5cGeAT-8XcA@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 11 Jun 2024 09:49:53 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Ua_CuWsPRMsZZhXF2kFjf6-o=s9zKYq=FC4XHQNL8UqQ@mail.gmail.com>
Message-ID: <CAD=FV=Ua_CuWsPRMsZZhXF2kFjf6-o=s9zKYq=FC4XHQNL8UqQ@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add panel CSOT MNB601LS1-1
To: Xuxin Xiong <xuxinxiong@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	hsinyi@google.com, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 28, 2024 at 9:27=E2=80=AFAM Doug Anderson <dianders@chromium.or=
g> wrote:
>
> Hi,
>
> On Mon, May 6, 2024 at 8:54=E2=80=AFAM Doug Anderson <dianders@chromium.o=
rg> wrote:
> >
> > Hi,
> >
> > On Tue, Apr 23, 2024 at 6:55=E2=80=AFPM Xuxin Xiong
> > <xuxinxiong@huaqin.corp-partner.google.com> wrote:
> > >
> > > Hi Doug, thank you!
> > > We had reported this info to the CSOT to correct the vendor id.
> > > If they confirm to fix this with the same product ID, we will submit =
a
> > > patch to fix this.
> >
> > FYI, "top posting" like this is generally frowned upon on kernel
> > mailing lists. One such reference about this is [1]. Some folks are
> > very passionate about this topic, so please keep it in mind to avoid
> > upsetting people in the community.
> >
> > In any case: did you get any response from CSOT about the improper EDID=
?
>
> Just following up here. Was there any response from CSOT?

Continuing to follow up here. Did CSOT say anything about this?

-Doug

