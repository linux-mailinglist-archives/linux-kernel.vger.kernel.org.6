Return-Path: <linux-kernel+bounces-561157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C86B1A60E25
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 11:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BDD1189DAF2
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 10:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20ADF1F236B;
	Fri, 14 Mar 2025 10:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fRFz+CVT"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B889D1F1523
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 10:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741946669; cv=none; b=BODdO1d+Ot3h33UyFPiNVbsvRKovAEkKw7cQhFIiKCX9cazzY4erU3H5ccQgESWHo4O2oXwmLTrYdTySAvHJsVDNaUK6Y/rp0qsSY5nlCFTaH/WwFKCNQZKQ0YOJlffseRzPwImL4H3apStwGi6QAEBDybrM0ShwHZrCcV1LeV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741946669; c=relaxed/simple;
	bh=HrE09mKedOk9fo3MpK0rYjDRK3jK5wC9NgMIu9SSbyI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YsJ+VjmZQIcmzPaz4k2WoNsiL3LqG9W0vzMUGA0mQkYAGnBmMJJ6XZ2gd9T/XjTRaKFAHoez+bOk0fOkBhJ2MGpi6RE4E6+DF29m1yLJid1hLE+CcthQ7FhFSdkB5l35UyujdSq02WWMxFwJ98Vy6AClIo7MbT/cCwUcLSHql2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fRFz+CVT; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5498c742661so2121574e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 03:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741946666; x=1742551466; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HrE09mKedOk9fo3MpK0rYjDRK3jK5wC9NgMIu9SSbyI=;
        b=fRFz+CVTQzcXSawwdIUbuElv9csN3dJzClHpjYLb3w4lsLtSB9c/zhswXlQOmhVd7e
         xBPENOMhpDOeMvEYDK2Oru5gLih8Fz6iGgCF/fVGKSTQ8iOZYaEk+vNBH4vEaIR4L3LH
         HcjTYvssraNPJ8G36kw/RVUscSMN7jO47FP1nQAcVDOBXQLRboWd2i7p934TsaeNOuAP
         rbzWVmDPJaYbSB+/VGn6X128UcJopmKrhls18ensxLsvxGXhOPcfJcXtNa1bPdF+KHrK
         hOIiQjXl7kHKgq4OdiIU9YwoBq+J9U6FESgqHRnxshlk4qNxGy8eRiC6IrSyw2Y5rgJM
         6Llw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741946666; x=1742551466;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HrE09mKedOk9fo3MpK0rYjDRK3jK5wC9NgMIu9SSbyI=;
        b=Y3oXUVQlOKs01rfh6gKKFOHVUeiljqJKFTtM8ZvqHu15HWTIgELsDxAtlJ4Z4ztVal
         H3CGIGlK/VTXmHYtbq7tCKkWRqfZNJth/aHlAiCK6Ww5QEwKrx9ZkadueNx6JhypXZCq
         /i6ZiFDLDnoWVDMGe19kpUPJZUhcU9V9DahRVSvngWKXHW0x1o7cDy2vJMNAwKJS/I08
         FrOJvgiFwan9FrgHo6p3l0gQARqMELcQqya0cOTXQM+8+Znk8BLddVSzq/j0GGlfeu0e
         nMqeOQIP3ZljFbNZytHOKPP2yAQNfZVjRBT83cpuc/zY6QSlE4Mq2QUzuvbQGn0y7cKl
         RBfQ==
X-Forwarded-Encrypted: i=1; AJvYcCVglyqpPK/hCXytCjgJ+grPpKzJuFkuvHnWIrfnamVIye4M09Xjpgbc/eteM7tFkKXG97voKSFz26zE3xk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyi8Jm16MNO+eEUHpWV7K9QWwoTIQv53sI5rEtJd2Zs2ZbetvbN
	lgIKWUZbhoaB/dnO3XNNOKMrtlu0GhQL/URolFI90pk6Gzc/OgfvC/oD8pzpcOr2vSTXyL81Lv6
	MbT7Unv/LpfwyOppV8Lo7lQ+IXjoD4Ulx5S6wSg==
X-Gm-Gg: ASbGncsdW3KoBYjPoVMKa8GkO2weCNUpsW424b2yxMwjNSff0XFK9YICc9xvkQ6NsQh
	D4AUFMkZrwv/L0BsinjjHcHjzosZPV4hOd/V9NTRzIQMW5WY1VqkLvncse9vv/plNxPPaRSdb7b
	NJvhTL3xkOmTwqU/HklJiX/lQ=
X-Google-Smtp-Source: AGHT+IGgoI83vSiToX3Ab2Md4G9QTPt2uvDlfvIFor3poPeFCoQq/Et8/x3cJtVhEho87JFB+bRoP0HoW39vS4Eny+4=
X-Received: by 2002:a05:6512:1386:b0:549:66d8:a1f3 with SMTP id
 2adb3069b0e04-549c39610d3mr518455e87.40.1741946665777; Fri, 14 Mar 2025
 03:04:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250305104939.15168-1-pshete@nvidia.com>
In-Reply-To: <20250305104939.15168-1-pshete@nvidia.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 14 Mar 2025 11:04:14 +0100
X-Gm-Features: AQ5f1JoOEe7T9gHagqVccCbtiE4HvkyR3XLHW6KSzkjBygNKsQbkExvz7sXEKJw
Message-ID: <CACRpkdb_c5nfS-WsQdOViYw7nHQo7CfDkcSiVho7=Ufh15i9yg@mail.gmail.com>
Subject: Re: [PATCH 1/2] pinctrl: tegra: Add descriptions for SoC data fields
To: Prathamesh Shete <pshete@nvidia.com>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com, linux-gpio@vger.kernel.org, 
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 5, 2025 at 11:50=E2=80=AFAM Prathamesh Shete <pshete@nvidia.com=
> wrote:

> Add detailed descriptions for the remaining fields in the
> tegra_pinctrl_soc_data structure. This improves code documentation
> and clarifies the purpose of each field, particularly for the
> pin-specific configuration options.
>
> Signed-off-by: Prathamesh Shete <pshete@nvidia.com>

Both patches applied!

Yours,
Linus Walleij

