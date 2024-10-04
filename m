Return-Path: <linux-kernel+bounces-351412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E6B19910CB
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 22:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B732FB31468
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2024 20:30:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16244231CB0;
	Fri,  4 Oct 2024 20:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XBPaZsAP"
Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42E5231C99
	for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2024 20:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728073843; cv=none; b=gVh3JsK7Hk2JqFdk9mfQ+vFduAsq0UBnQtcJF1Xx9LM/RBsJ8yuSacaai0Pjgl+SlIS5ikpIKS928wMlUbJU+nykeMoYb18N4DQD/0O47A4pYfghCakMZWoosMY59wVsrT3jMbIEDseEonfWqw+xO8/rsTGo5MoGYDsrz/yqI4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728073843; c=relaxed/simple;
	bh=UmrartpaTjoZPu+gOEh+EPpvqxtvf8ea8A+/rzswyHI=;
	h=MIME-Version:In-Reply-To:References:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kBycyAjLBlsp6IFhtPhDZF5bm6waU7lI3qdVy1cFUOgUtoFI0IK/WJWlJiiKmtApejbu57ER5jpKj1BcWWCWCv5Yq8MN/QtsyfoU1PD8tzvotSwt3wbIthDBbgomnMROtWokVQEh+P9kgYXNxIlsXvK8E0/OCO8MtOKvoh4+lsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XBPaZsAP; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-286f0599436so1145314fac.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2024 13:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1728073841; x=1728678641; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UmrartpaTjoZPu+gOEh+EPpvqxtvf8ea8A+/rzswyHI=;
        b=XBPaZsAP23WaZw9+hqafVHAUiAOFWsApYzbrZ8X680Fb8Ih0+FjHQHWRzkR/GuLehP
         Ayhx6w3Tg75sO8+PPQraoz0bssQfxNl1BpxDA95EIqexrWnE+MWDt/5DtGRRSNpDCaf8
         tkqwDoVSsyeAjTyAnRST08lw8jycaSf8h2sHw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728073841; x=1728678641;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UmrartpaTjoZPu+gOEh+EPpvqxtvf8ea8A+/rzswyHI=;
        b=AnYx82/fVPDlr3YyzsvH+U46FRJqDFK3vGzkERoJG/JHfAv5Y/MdUSv/j6A8cWTuRG
         E5ypuardiO5vPXLqSYwXPtlOIblw7W6SjsbCGmaFoAv1Z5FhcPMyVbkXMG/EqWLDZiIV
         OKy2PVN5kUEnMpOEZUvHmBzKKWrNef9bNwiv0A/u8JqhJ61tnOjCBGqkMsJUDPqVzpaD
         NdLoc51rMz5u1kuPoXoHWwB2+wXp0GJzHvVT120LkaZtuAKaWcNbX2Aqnr+7bRULRQNt
         MeK6rDiXVTtD9ws67G3NFQx91BbsVh8L762fS1NOl5QMidDTSnEZJHCe4LItN0lnZaDo
         JYTA==
X-Forwarded-Encrypted: i=1; AJvYcCX6xSJvfxJSe8Y9McNqG3rQCx2nH6At1W5CB1H7P0L0DNkEl/uYuJ1UiJr+Q5FOMuBPblGOXjvQy1Xn+7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YyT2SbUoNZbUUdaaiBaG3c0IhLBOHh+e2g9+YOSO+Lou0llUJrY
	iGdcc78dug6l02D5Htg2AKC6DnD+8njTccksZZlbDJF+eoWGO5aXOfP7Yh8VN/c621toHdg6L1A
	VGaQuUx4WvPLy6DL0J9zuFhnUR7E8TUVwwNpq
X-Google-Smtp-Source: AGHT+IHBNGViUhNdC+x1MxOuOMGmGPHvsmRZb4g3h+WErejZq3Aczu74qbS5BK3hpcltOjTmO7GmiXSS7XljqVsVqAY=
X-Received: by 2002:a05:6870:2191:b0:261:1f7d:cf70 with SMTP id
 586e51a60fabf-287c2154afamr2787046fac.36.1728073839958; Fri, 04 Oct 2024
 13:30:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 4 Oct 2024 20:30:39 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20241003103009.2635627-1-leitao@debian.org>
References: <20241003103009.2635627-1-leitao@debian.org>
From: Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date: Fri, 4 Oct 2024 20:30:39 +0000
Message-ID: <CAE-0n51TU6QO7JkYG9vEqsRzoj9rjukTzM8qBmHkStS_dWRd8w@mail.gmail.com>
Subject: Re: [PATCH] scripts/decode_stacktrace.sh: remove trailing space
To: Breno Leitao <leitao@debian.org>, akpm@linux-foundation.org
Cc: Luca Ceresoli <luca.ceresoli@bootlin.com>, Elliot Berman <quic_eberman@quicinc.com>, 
	Xiong Nandi <xndchn@gmail.com>, Kent Overstreet <kent.overstreet@linux.dev>, 
	Bjorn Andersson <quic_bjorande@quicinc.com>, Carlos Llamas <cmllamas@google.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Quoting Breno Leitao (2024-10-03 03:30:05)
> decode_stacktrace.sh adds a trailing space at the end of the decoded
> stack if the module is not set (in most of the lines), which makes the
> some lines of the stack having trailing space and some others not.
>
> Do not add an extra space at the end of the line if module is not set,
> adding consistency in output formatting.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---

Reviewed-by: Stephen Boyd <swboyd@chromium.org>

