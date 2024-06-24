Return-Path: <linux-kernel+bounces-227617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49155915481
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 18:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E68891F22AF0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 16:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55C219DFB7;
	Mon, 24 Jun 2024 16:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iw2w4Y8W"
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C685319E823
	for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 16:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719247208; cv=none; b=eCxMiJsh+CpSKk9NOxUOSxQkqF5tSxKVBt7fO9YwdOXaCj8BD8uzTpLMhFKF7sOL0G0KEGUkbqFfNH4pcGRg4Xsu+gv/cUjozM+fIQhMhB8jt5F3SARoh3gjR+5dXxOG16FK+QrfmOSXy9DDNcNYRB35at/RL0uke7pPTGN4F88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719247208; c=relaxed/simple;
	bh=bTHn335s8B1w66yFq/+OI5bVTKkN+nzUp2gyrYEy47I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LLUu3x6RNkzroI7XJD4dviph3/VFwpW5Y1iNaDVaC+BBmwv5bpe+URLonQf0isluGnZxVhQXXohEvoRzhUHJG+ivWH8dJQByUSwG0EvjHWHQptAfLOHQ1vtkCR7vn33rMqB/Gn/tlL9FbUb8DSoF6oTmKGdVVt4wEoJTrgopeKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iw2w4Y8W; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-44056f72257so1751cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jun 2024 09:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719247205; x=1719852005; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GZ+xnyCLREi74xq4k4heuccoqe9gphJLidfi9eaePRI=;
        b=Iw2w4Y8WoxrwImRWC82vcBkWwThBcO9ba0j1ecw/0tWFvBNJiNCQrGZVNT5Ssp6iK/
         Ou/l0kbFfslk34uT1j62W3eFaggnD9QGj3Nbp3JnR3p8+EspoR5P1ELUJcmH5q0qWSfs
         oOus0EUT4zobcqvn3PYm4yjjyfh/bzjY7wIifQNfKVmI9m7ohPmeWTmpp+s6TEJ8swLy
         dS/Y74eyiPqEq+7hAO/2RvgxGkoT8pNdO3BQqFzi5a3ToBXY0zJ4NKZZROzOyTFN5Pvz
         UwRbmqOPHQbyo+lncpjyadAmSPLyrBF9CO8EfZdVu4oPH/mjAYq9gxYMYOV+I8PY63s8
         oE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719247205; x=1719852005;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GZ+xnyCLREi74xq4k4heuccoqe9gphJLidfi9eaePRI=;
        b=gEMx97fiWIkyJYIbNN7nmSQHflr7/98neknQYwEtTkunOgGxrZEslFfLT5Je7r228T
         TKRs4zu6TtZz7NcVskJlUZK+7XveJZBiAIi/a6vvQlMtCzl5D0PZ8JQrBoC0p3hDu0Em
         iaVeexTTzmBgftTIK76c7G0IJALYSh6Bk/2yLUxhmfLuw4y9+od5OX95q7AT45knyCLs
         0WvETAs1MVpiLptLWuxrq+FJlJsEi22pS8JBHgBhcfuwQfpaCXyc6GSjS61v3Qxde/TA
         dI9BCz45k/doS0xFtLptdWL45YQmuAhQ5T03JminNmiKA/FzwxaWOQUIlsp5sT+Qhw6G
         F57g==
X-Forwarded-Encrypted: i=1; AJvYcCVQGsZw38NtR1JEw99MgE4Z8oHBiUqt9UKwcU6D9F9QtGME1qpz8+GpaGL8PQfd9Aah10mhZv68YiVtuKrQhlqhZAV7oBfF6DAC7eHQ
X-Gm-Message-State: AOJu0YxC9JRwyGCMfKjdkyqGo67e9vIPDCrre8Zg4BYxjP0e1xIdC6bn
	zHeHKaK7VoiVshu5YOAwBM0DRXm+I1YSclrFee00RQbPJc2zOWJrk7O+uwkAN6DrfX4ic9B4lXu
	Z7cuztZ14Z25cNHoOTpeFC41X4WuphXLAuyry
X-Google-Smtp-Source: AGHT+IFixPe77lWinjbn1l+sNnJv5Ui/C76Vx2CtkIRfQjKNjmI2FCb1bmRnLWcIP8e3ucRsKkrRobHHIY0Ljuz5GjU=
X-Received: by 2002:a05:622a:109:b0:444:a760:55de with SMTP id
 d75a77b69052e-444ce34a3b1mr5027131cf.24.1719247204577; Mon, 24 Jun 2024
 09:40:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624141926.5250-1-lvzhaoxiong@huaqin.corp-partner.google.com> <20240624141926.5250-4-lvzhaoxiong@huaqin.corp-partner.google.com>
In-Reply-To: <20240624141926.5250-4-lvzhaoxiong@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@google.com>
Date: Mon, 24 Jun 2024 09:39:53 -0700
Message-ID: <CAD=FV=XNS6sq1nuynDqU6gvfVa5pyBzVKPSiboEEYsTbwvV9fQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] drm/panel: panel-jadard-jd9365da-h3: use wrapped
 MIPI DCS functions
To: Zhaoxiong Lv <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jikos@kernel.org, 
	benjamin.tissoires@redhat.co, hsinyi@google.com, jagan@edgeble.ai, 
	neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, 
	dmitry.baryshkov@linaro.org, dri-devel@lists.freedesktop.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 24, 2024 at 7:21=E2=80=AFAM Zhaoxiong Lv
<lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
>
> +static int radxa_display_8hd_ad002_init_cmds(struct jadard *jadard)
> +{
> +       struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D jadard->dsi =
};
> +
> +       mipi_dsi_dcs_write_seq_multi(&dsi_ctx, 0xE0, 0x00);

nit: could you convert the hex from UPPERCASE to lowercase in this
patch. As an example, 0xE0 above should be 0xe0.

Other than that nit, this looks OK to me:

Reviewed-by: Douglas Anderson <dianders@chromium.org>

