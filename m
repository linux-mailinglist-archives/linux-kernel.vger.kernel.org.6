Return-Path: <linux-kernel+bounces-171822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DAFB8BE920
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 18:34:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CECBD1F21EE7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 16:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9777816D9CA;
	Tue,  7 May 2024 16:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X/hjTej+"
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883BE16D9BF
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 16:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715099369; cv=none; b=smQDXcCf600kbIZNHN8wsxNOH8NGCfawFiGJ0Gsm0nVz3G5nRnG2rM4xNAGw1JMV6H7SWOAgpolQEg3FnZd1VRym5kFFZI8vpm0uAeVc0qmVHNmwxpcwBbV4PcOt6vY41gn0fmGymcFR6UiuRWA0W1pVpl21d8gHodqQBkcsCD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715099369; c=relaxed/simple;
	bh=gA40961915NjpJzym6L6HzsY7i//kdLIcIZ/CTYpdew=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eVulHGEnoJjiWMs5tpPl1lF2fnzRvNWAXdtKE2U0Z9evzBS6YB9SnMZvAZbLsnda8iUMqxnPxGDGRA2+5mzZxWBnXnCFssma8VzVHQUvw6lW5gN5FQ3UfcuvZxQs0/W03+Uh8ro3jrwfSbE7zkr3qdS8hmSruqp49HRu0sh2lAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=X/hjTej+; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-4df37a78069so928798e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 09:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715099366; x=1715704166; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hmBmzg39oPwlHH3+Q/yrquaQKff44gbWHvBa/1NwxMw=;
        b=X/hjTej+A5nnm3H73DCw/vCZIPUWkPnXa8+GyCEzYQa3M1nwMcr6v4ci8Fty94O0XG
         tzge8yx0MvBr+fUioL1OT+GKLtokhk9GzU+g2mS9PwDmSrILHtEnbdcWAKk9Rc76RXcU
         ALVEo5Kxrn9/WVMQkF4Sxs+d4i5N5d6bfLZRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715099366; x=1715704166;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hmBmzg39oPwlHH3+Q/yrquaQKff44gbWHvBa/1NwxMw=;
        b=lriOZNUUIew86tyYwDFQEE16hLQMRobQnS9g9YLMqG5tp0oqQve/0U3AQk46pCjtgf
         3R+k0ZgFbfwTX8sNLnvt3xdECVTShUCPjv2VAdXaHIHDkkN+b4fc33v9Oo5GWBIfg5o4
         vTD2JgSZ2+9gu6rXo1lfkbEmHmf6WZShT/zw2mc/vpITOtIZtsyGozxptwfr6J4aONIX
         G4OZXOlCk5aFMM+IMeqvp/q+7YR1p6vvmsj7djDCPhaJr1H/vmEXcf32SJ7DwM7ZxLFq
         X+azFqb+9M5oTyjQGSEAyEocUvjn2o0RV9TEpM6HVF/+t+VAvNSnX7kiym/sdRUb/jtg
         QXuQ==
X-Forwarded-Encrypted: i=1; AJvYcCV7Lz2xjdWlEs8cRNQIkR7oDzLtqp523lnEmhVZxsSbBoWMvLABNpwnsUHRamQXO1WyP2B9sRgE2/R/RhXrA6YsT1eD2IL8LLzJVTdU
X-Gm-Message-State: AOJu0Yz211JfibO1DcJjKfLa5igyI/zEyQIW9f2vNZy8HT0zFaN9DVAM
	8+P9oy7I//mdXSNxkqmtkQlqggn434F4H2bzwP9WW3Bhfe8tbipQdOaCZk1myAKlgo4ZOy5PY9E
	=
X-Google-Smtp-Source: AGHT+IEQtNRlYZhu5sE3cUyEeDxJxaRQd/ZSPmtlE07rsEqelbrGL6ZhYIy6/0yaCLCe0mmZTAS6SQ==
X-Received: by 2002:a05:6122:3188:b0:4d3:36b9:2c26 with SMTP id 71dfb90a1353d-4df6940bc15mr12583e0c.14.1715099366052;
        Tue, 07 May 2024 09:29:26 -0700 (PDT)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id p5-20020ac87405000000b00439549ef9d8sm2132601qtq.82.2024.05.07.09.29.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 May 2024 09:29:25 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43ae23431fbso1141cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 09:29:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVMS0VfrI69b34CY9evPAD4nM1mwvgMW/h80hUMg487I3CH8IVkmVH9vJY2XC/DzmRN0rCyRcKCwEFpGka5tuQvmgdq3krAvw8OZqjG
X-Received: by 2002:a05:622a:1243:b0:43d:a002:b with SMTP id
 d75a77b69052e-43da00202a4mr2608201cf.9.1715099364710; Tue, 07 May 2024
 09:29:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424023010.2099949-1-yangcong5@huaqin.corp-partner.google.com>
 <20240424023010.2099949-3-yangcong5@huaqin.corp-partner.google.com>
 <CAD=FV=VFk3epSxksh+n_LupTiZp=gK=LB2NESGy5iNF=5xFAmg@mail.gmail.com> <CAHwB_NJMWR883kjshtfBFuDBcM9Av87Fx2Jf4d=3_5LLnhUFXg@mail.gmail.com>
In-Reply-To: <CAHwB_NJMWR883kjshtfBFuDBcM9Av87Fx2Jf4d=3_5LLnhUFXg@mail.gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 7 May 2024 09:29:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wjgc4F2zMhzeLY1hmRN1PTjEpZ7nbYBCp8RPMM7LhPbg@mail.gmail.com>
Message-ID: <CAD=FV=Wjgc4F2zMhzeLY1hmRN1PTjEpZ7nbYBCp8RPMM7LhPbg@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] drm/panel: himax-hx83102: Break out as separate driver
To: cong yang <yangcong5@huaqin.corp-partner.google.com>
Cc: sam@ravnborg.org, neil.armstrong@linaro.org, daniel@ffwll.ch, 
	linus.walleij@linaro.org, krzysztof.kozlowski+dt@linaro.org, 
	robh+dt@kernel.org, conor+dt@kernel.org, airlied@gmail.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, xuxinxiong@huaqin.corp-partner.google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 7, 2024 at 6:44=E2=80=AFAM cong yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> > Speaking of which, some of the panels that you add to this driver seem
> > to disable extended commands at the end of their init sequence, but
> > this one doesn't. Should it?
>
> I  have confirmed with himax that disable extended commands  used
> at the end to prevent accidental writing. And our inital code has been
> confirmed by himax before FSI. Considering that this has been on the
> market for a long time and there are no feedback issues, I think it shoul=
d
> remain the same as `panel-boe-tv101wum-nl6.c`.  What do you think?

It's fine with me to leave it the same as `panel-boe-tv101wum-nl6.c`
had it. At least it should be more obvious to people that there's a
difference now. ;-)

-Doug

