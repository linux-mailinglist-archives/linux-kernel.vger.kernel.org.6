Return-Path: <linux-kernel+bounces-248143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 909DC92D8D7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 21:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3AF441F24C93
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2024 19:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5357B197A75;
	Wed, 10 Jul 2024 19:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eSorft9+"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4465E1974FA
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 19:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720638782; cv=none; b=gL/U9/GopnmHxfO9lv3jMABMpg/IyPBgJTa2I8IYBORbn2JkRlRF4ywqkj0MWJBLDK+DjRzw2R9m8aMdELhoe76+I07DMtQXjpnCEeMjjG9LN4pIuscJb1lPCohk9Safj8AOC1PwTHkvErtwPL7UR2oapo95je985b7d3uebDH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720638782; c=relaxed/simple;
	bh=Pdmj45LBJKnt2uBezG0hiQjjXNOAPIeCha+bcVFfCXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ng6fz473B46Dr/jErVNraFp5cd1ww7LfD0ptsq0MJaLr7q8gGMleo1qpZwOOBJmz5lBLu9VtTZLGqBJz6M6dj78XsBEYMmjaBPUW9rhqAF+UxW/6SRYLVMDQrxrImTgqf5Ty04y7+Ssuua+FxbZMt/t982lc9ohHppC+5iFbOCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eSorft9+; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-79f1be45ca8so7521485a.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 12:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1720638777; x=1721243577; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=msnytkDAJA+P3orVTeKKvN06RuuVdEWbRMnBWzLAFIc=;
        b=eSorft9+hvWniIqPk+YSmUi83e35rK5Lpr6EI5J//9GMs0IB09VfrOHcusTv2DBHXX
         RPNyDiZSxYcgw0dZtC/T6EC4J8tFVroU5h8huvq6PweQ91gk2PWV9SysUEtuFRlXSP9w
         nHQz5cz8AwjbJckQozSAV0DdjPAHYRMCxEPMQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720638777; x=1721243577;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=msnytkDAJA+P3orVTeKKvN06RuuVdEWbRMnBWzLAFIc=;
        b=gb2tPJ5jy/jhM0iBIwP925hJCeUrnkTRF/RAbOv6bLAozeZjnLDiysUmZ5YJUT8UGV
         dP7KvxGC8PHzo+AxNvXSctDjBFfHAEy6FttxgLmgMcqVAD9QgDT73pK55Hq75P5MonSB
         gCDCVeD+pxP64dq+1rcHmYHE9XoRK4ZM8XvFhNtH751f6OV8v7loL6NEiVGF6R6oc69I
         AfBP5AKLvX94fXx89NjlAxiORQeQgYLO2yzNnvtSrvah5Jg3xw1fgnaow3p4kC3EL5uR
         FJi0lSLcED5C73nU0ZoMTJGYe1M2YnnJ0y0rpk6f0dloCPQFiKeIyE6wit+Z4QVM65wy
         AcCA==
X-Forwarded-Encrypted: i=1; AJvYcCUaILL6Fpr5LlxY8McNQ2jLcLizdKyQaFiHMpFD59/Po8ie7O4kTFN35hqhLkJ77J56jqveAOA4aCRfsTwKj+fvUiBazJcsn7OgbkxB
X-Gm-Message-State: AOJu0YzNgLysPNp9f2XI30L9gM62UjU0PwirEGk/CsLEM5I6UdyfanMg
	oe0Q5O0MReLHIOmMYVP1fP4rUyg7PXZ8FKF58+iTsT3RFz2j2hAQn8ekXm1Z1RlnCxoOjSXNEah
	dsg==
X-Google-Smtp-Source: AGHT+IHkDlpdskxQh+ZOM5D4vxdMPB1cLnN+uBYvbE+k2tu81ZuOzkxLrHtf65/eB6SYL4Rzn579QA==
X-Received: by 2002:a05:620a:c08:b0:79f:176e:4ee1 with SMTP id af79cd13be357-79f19a51deemr643336185a.12.1720638777016;
        Wed, 10 Jul 2024 12:12:57 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-79f18ff67c2sm221327985a.8.2024.07.10.12.12.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 12:12:56 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-44a8b140a1bso63291cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jul 2024 12:12:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVBJIO3Mrly/ehlAUc3dwuQE9Vv33ThuEnDVBFzJL7zNbLnI+pNenebqEGDLX017RpONs5SzpANA/+Vmr1j0M/s+YBy8ObamH9bEm1k
X-Received: by 2002:ac8:6a12:0:b0:447:e2f0:4d17 with SMTP id
 d75a77b69052e-44d118939ecmr377451cf.7.1720638775365; Wed, 10 Jul 2024
 12:12:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240710084715.1119935-1-yangcong5@huaqin.corp-partner.google.com>
 <20240710084715.1119935-2-yangcong5@huaqin.corp-partner.google.com>
In-Reply-To: <20240710084715.1119935-2-yangcong5@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 10 Jul 2024 12:12:39 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Vt+8qqY8AQuKkC2np6z8aHoDpeV1siHKrDe-=Ft8xaMg@mail.gmail.com>
Message-ID: <CAD=FV=Vt+8qqY8AQuKkC2np6z8aHoDpeV1siHKrDe-=Ft8xaMg@mail.gmail.com>
Subject: Re: [PATCH v1 1/4] drm/panel: boe-tv101wum-nl6: Break some CMDS into
 helper functions
To: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
Cc: quic_jesszhan@quicinc.com, neil.armstrong@linaro.org, mwalle@kernel.org, 
	linus.walleij@linaro.org, airlied@gmail.com, dmitry.baryshkov@linaro.org, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Jul 10, 2024 at 1:47=E2=80=AFAM Cong Yang
<yangcong5@huaqin.corp-partner.google.com> wrote:
>
> hj110iz-01a and tv110c9m-ll3 both nt36523 controller, and they have
> some common cmds, so let's break them into helper functions.
>
> Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> ---
>  .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    | 190 ++++++------------
>  1 file changed, 63 insertions(+), 127 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

