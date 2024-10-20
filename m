Return-Path: <linux-kernel+bounces-373249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D67C39A5455
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 15:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0738E1C20D80
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Oct 2024 13:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC4E192D79;
	Sun, 20 Oct 2024 13:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b="10DvpkmD"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3B2192B71
	for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 13:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729430833; cv=none; b=uqvXxv8y4cMvE/mjjZ2O1BSgjAUzCqFwWgWwQJZEdRLgXk1/YybkkojOImH02IDcVQHmKhJtf3T0jbko0Yhm6KyE/wONz4S+RjmF7xaKzKy2BW2RiuhqdrBq7fo4c2YZ5cyimfPnBSZq80/47x7X4vzhH388lX+FyvddUVLfiFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729430833; c=relaxed/simple;
	bh=eBJzOYlqjsdcPdk0yMInJK2l8n0pk3Q6fRoZHJOBNDg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QFQaBK7XxVmC3Qj7Dvg1H8yzl93orTef0UmZ8BHa970vzz3YyaIwR9CamwrpRE5Nn9AKWdUziuSoa7SB8qXCA2xZD0GtXYFLfVuQcMrSMejJ4wvJ2XTyF+1jZmz4jfxgtMOC45KN4vkpm6GmKkiCoFjo4n9IU7GpGSxYgGvIiiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com; spf=pass smtp.mailfrom=riscstar.com; dkim=pass (2048-bit key) header.d=riscstar-com.20230601.gappssmtp.com header.i=@riscstar-com.20230601.gappssmtp.com header.b=10DvpkmD; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=riscstar.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riscstar.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-4608e389407so43503831cf.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Oct 2024 06:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riscstar-com.20230601.gappssmtp.com; s=20230601; t=1729430830; x=1730035630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eBJzOYlqjsdcPdk0yMInJK2l8n0pk3Q6fRoZHJOBNDg=;
        b=10DvpkmDzxKtVVskYOo3t0dMLkMFjFDHL7Xx1FBftUoKf+IOdngajO7i+i2ReiIWyH
         EwpXmoraHRNpSVK6Cyol+ycwVIQ2Cxgwlle99DJW/iwkyCINaGbqmg+oitLZVKf1MpIU
         /PWoPpCF3uSq65UVDxREadSXTVTC4oyIF7fNHCD6C4QXEYR7KR8giNvFNg5ClNkNFK4U
         Qs7xb4s1MNO5lxtbFHLvR/bCH+RZ9FkH5V7y2IIcB8d+UA7/DUjpgM49tuenp222fved
         kp+x3RV9VUkaUfLORX0GHuKV5ujyv/WHBNzUAi/YIViM+CQwYsNHtSi1/kFitDVtI7cG
         MPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729430830; x=1730035630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eBJzOYlqjsdcPdk0yMInJK2l8n0pk3Q6fRoZHJOBNDg=;
        b=di0IL47Om/qemuJVSn2tkVG+lb5u46/lHUI9rdSiUm/jhArY/38u/Vg/aQAUM3VrSu
         1Vm46JzqGUPSHT/D5OwE+qrhsuUbulDDs8vzGVTibmmxS9DB0iTCKmZU7UEyzzWBzkjr
         2N9MSVEPzHOgJPbACzCE3R+xiEwdm7QeWN09oqavwNbhzlv+Q2XBf1QYyEHmoBjl9II/
         1fojpZtVi1g2d20haZRYWnbe9TXEgeAXABN6P6Z+KQ0Oosw9qMK5pFLF6Hlu/qB4/uk0
         8sO3ESeP1CfQrjL11uTP8lMAEpTH8wpV80N/cYWHlB1r0rgxmk3RGmid9R6LSn3nxYW1
         O5cQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOUM5zSrwLHkmJCSRAh3jJSWaQEd5d6B60nbx0xbARoGRLJ3UDrHRuzTq3kVJUwycxjUhQELXaId9RGro=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKQsaCBWwKS6Gay+sNtWgdaznru1llpdJhwHXKPbebVF6Yaavq
	NzBTcq+rh89kJsoi8Zyo2/PeIpqssyvcvP9HJNI/u0erH4B4YQu9wYWWP9731cAIap3ImfgYRap
	V+jZpoBMwotweuqESF4WraC9VHaJDsbSk/3C++g==
X-Google-Smtp-Source: AGHT+IGnWYenAH+ICS/UFFfkdYgfxAxxgdD8o/QX9kkC8wcWWq8eVoZ/61fjMkC/c+9rFwRbkiM8CbwF/i+45YR+acg=
X-Received: by 2002:a05:622a:4d2:b0:460:92fa:f72e with SMTP id
 d75a77b69052e-460aed75b47mr141603281cf.33.1729430830268; Sun, 20 Oct 2024
 06:27:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241019162605.308475-1-guodong@riscstar.com> <20241019162605.308475-2-guodong@riscstar.com>
 <2024102029-populate-footage-755a@gregkh>
In-Reply-To: <2024102029-populate-footage-755a@gregkh>
From: Guodong Xu <guodong@riscstar.com>
Date: Sun, 20 Oct 2024 21:26:57 +0800
Message-ID: <CAH1PCMa4BK2eaVYSmckSDtGr6uhMEF12jHzHwqz-hnKFbQrFRw@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] dt-bindings: vendor: add deepcomputing
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Emil Renner Berthing <kernel@esmil.dk>, rafal@milecki.pl, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Heiko Stuebner <heiko.stuebner@cherry.de>, Michael Zhu <michael.zhu@starfivetech.com>, 
	Drew Fustini <drew@beagleboard.org>, Alexandru Stan <ams@frame.work>, Daniel Schaefer <dhs@frame.work>, 
	Sandie Cao <sandie.cao@deepcomputing.io>, Yuning Liang <yuning.liang@deepcomputing.io>, 
	Huiming Qiu <huiming.qiu@deepcomputing.io>, Alex Elder <elder@riscstar.com>, linux@frame.work, 
	devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 2:21=E2=80=AFPM Greg Kroah-Hartman wrote:
>
> On Sun, Oct 20, 2024 at 12:26:03AM +0800, Guodong Xu wrote:
> > From: Sandie Cao <sandie.cao@deepcomputing.io>
> >
> > From: Sandie Cao <sandie.cao@deepcomputing.io>
>
> Nit, for some reason this shows up twice, same for patch 2/3 :(
>

Thanks Greg.
I will fix that.

