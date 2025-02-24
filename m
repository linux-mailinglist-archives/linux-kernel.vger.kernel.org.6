Return-Path: <linux-kernel+bounces-529637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081F3A4292A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 18:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0318E441BE0
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2025 17:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608232638BE;
	Mon, 24 Feb 2025 17:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b="m6GgLr2B"
Received: from linux1587.grserver.gr (linux1587.grserver.gr [185.138.42.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB1B25485D;
	Mon, 24 Feb 2025 17:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.138.42.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740416742; cv=none; b=CKEFiXQ6kM1/emNXVm3419w+0szkoCcRG1PVLLGgc/tEHk/Yea3wk8/XNRDQwKbMWXwM4SbnvgEpcOk5TU/Tzzq+P80SDdLqJeUnc/MTcxxLc1R4KhzJWCtOBXimSjh28hnk/TFVcNJh5GB5peaFTnmDqavK7NNXODrvBIWG7IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740416742; c=relaxed/simple;
	bh=ikpVbCwF0phPypADOo4Lde3trjPz209gTvKcgZtS9V4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lXZXBp5dvWgyiQfrB+pwA2oRh4lhQSBB+t4r4+c4j7f5m1S2+PSmKblh5gLklzsdeB1yHzon219Dk+suHXlDRtM77HbgUjBeZAChDm+b2DNrhsCQrWQMF0oE0tUi4jk27A+mrE5kZX3sVsx12Ab7boWh1VpJPYRBgCPYl7hFAn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev; spf=pass smtp.mailfrom=antheas.dev; dkim=pass (1024-bit key) header.d=antheas.dev header.i=@antheas.dev header.b=m6GgLr2B; arc=none smtp.client-ip=185.138.42.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=antheas.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antheas.dev
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	by linux1587.grserver.gr (Postfix) with ESMTPSA id BE7752E08F49;
	Mon, 24 Feb 2025 19:05:35 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=antheas.dev;
	s=default; t=1740416738;
	bh=ikpVbCwF0phPypADOo4Lde3trjPz209gTvKcgZtS9V4=;
	h=Received:From:Subject:To;
	b=m6GgLr2B2WaHqBYGrXRoOy5AznOKlfKYdJp0livsp6w/nz7sVtqHWo1UxCHyzpbmX
	 O//V/wEnGTYQMfQ0suZH+ME6IISv2nzi4HiYsD5IAWFsOmp7AZwji6OFq3ZLm/cJsp
	 4rEZu0W11RxW6fjmO4ArmQleoQfLLOFgnncXpfFY=
Authentication-Results: linux1587.grserver.gr;
        spf=pass (sender IP is 209.85.208.172) smtp.mailfrom=lkml@antheas.dev smtp.helo=mail-lj1-f172.google.com
Received-SPF: pass (linux1587.grserver.gr: connection is authenticated)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-30761be8fcfso41612311fa.0;
        Mon, 24 Feb 2025 09:05:35 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXxY8UaTSiJlQJoFOS1FbEcJYWdiASV8CIjj+kwubkgjqJjkyWfXX/A79u/6b23UUFPCgoo5DWt5g2XXuc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPAt6xFmdud1HiQhPfoO2/ah1xVAmvuzlFGttHs+M3O7ZC7Ja8
	GvwwPRi230pao1fMiljz1l6PhMC8Lb80SR7j+w5VwDiwCoj86c2hj5R/WeRWEmw3E1iuBic4Fjm
	Ev4Hc85ZD5aUZVenm/+ewLJSxEE4=
X-Google-Smtp-Source: 
 AGHT+IH2i+E7+VBwgP865VrS3YE+BSC08mazi41OYKqvbCsdZ6nbumbajed3+Uc2YmfQUOx6b9/TsNJH7YQPrcYTuSc=
X-Received: by 2002:a2e:380b:0:b0:309:2267:32d0 with SMTP id
 38308e7fff4ca-30a80c41919mr322121fa.21.1740416735105; Mon, 24 Feb 2025
 09:05:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224161016.439696-1-lkml@antheas.dev>
 <20250224161016.439696-3-lkml@antheas.dev>
 <004001db86dc$b32dec60$1989c520$@opensource.cirrus.com>
 <CAGwozwHSbzDxCiO-xYNqNH20HovMnMk+rNLEatToX4js=gO_RQ@mail.gmail.com>
In-Reply-To: 
 <CAGwozwHSbzDxCiO-xYNqNH20HovMnMk+rNLEatToX4js=gO_RQ@mail.gmail.com>
From: Antheas Kapenekakis <lkml@antheas.dev>
Date: Mon, 24 Feb 2025 18:05:22 +0100
X-Gmail-Original-Message-ID: 
 <CAGwozwE3dceooZouM2Ay9YXfehrQBk+STa1HRH5nkZ6QohTjhA@mail.gmail.com>
X-Gm-Features: AWEUYZmJ6aw3M9XGkvMhhB9xyslv0FhSO-x2c5ZhGmMNYalUcY5rAdnYIdyZOx8
Message-ID: 
 <CAGwozwE3dceooZouM2Ay9YXfehrQBk+STa1HRH5nkZ6QohTjhA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ALSA: hda/realtek: Fix Asus Z13 2025 audio
To: "Stefan Binding (Opensource)" <sbinding@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, kailang@realtek.com,
	linux-kernel@vger.kernel.org, perex@perex.cz, tiwai@suse.com,
	baojun.xu@ti.com, simont@opensource.cirrus.com,
	Kyle Gospodnetich <me@kylegospodneti.ch>
Content-Type: text/plain; charset="UTF-8"
X-PPP-Message-ID: 
 <174041673628.29829.1776372639532548796@linux1587.grserver.gr>
X-PPP-Vhost: antheas.dev
X-Virus-Scanned: clamav-milter 0.103.11 at linux1587.grserver.gr
X-Virus-Status: Clean

You are indeed right Stefan, during grepping i got 16 results for
ALC294_FIXUP_ASUS_ALLY so I thought it was used more.

My mistake. I can also try the base 2c fixup

Antheas

On Mon, 24 Feb 2025 at 18:02, Antheas Kapenekakis <lkml@antheas.dev> wrote:
>
> Hi Stefan,
>
> > If possible, could you provide an acpidump of this system, so I can compare
> > against what I have?
>
> sure, see [1]
>
> Antheas
>
> [1] https://github.com/hhd-dev/hwinfo/blob/5bb16fa59f533e036e430016f2c85facd0325f5a/devices/Asus%20Z13%202025/decoded/dsdt.dsl

