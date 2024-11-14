Return-Path: <linux-kernel+bounces-409737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC29F9C90B1
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 18:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6394E1F23A46
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Nov 2024 17:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CFC18A931;
	Thu, 14 Nov 2024 17:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="RjPt2Oos"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49549154BEE
	for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 17:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731604914; cv=none; b=bqGZld5LQHvTKthFHzNy4UW4+LL7wTkwdeUQxZzdJzEhDyASlz4Xqfwxfuk33ENpC2Zn9lEKlidBQxlBjzhDo/tCS6pmJ9ZQ3usqNXArgVDRBj6LTQjDw0Bw9mle3qZimZ9TjnjRqpJIEzju6aQ1szbpuZp+IFVK8L+X0HSyHTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731604914; c=relaxed/simple;
	bh=ooLd2KnZY+iAsvZpcBbhlZVOlUE4xC2qvGpPzxWgCOE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BWdMLSyQ//Dn8e4489XR7mbkdsmda2g6oyvzF/K4mpihQefO7xyb7cNyLIvjOGM6Q0n4SLCCU0UJuHBVzqBI3OoORZmqlwHzQ3C08s8vHM31Z+m9nWyAm9WqgPtXW2MfA00X/ksuiShPmNLjOqPEco6A7ERc9QE+XdpwEmyzlVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=RjPt2Oos; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2fb4af0b6beso15340221fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1731604910; x=1732209710; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6hn1K0JlF2yxtKRDiqqXBoVLBpc9QBlyQWe6RfRYuPk=;
        b=RjPt2OosW4tTuisFytAmJXI6hI/1h8x0KHcPMWz++mvsf60ehqR482g3KCqm1dW1/9
         benqXxEjyrEreMhMDAAAjJKtwaD/sPNFawvZMhr/gfR8Bpjt2V5aQH9GPol+5IoDPm/L
         MC8lDysVCBF3quLEnuMtDwMsYELUtLIm/QYmw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731604910; x=1732209710;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6hn1K0JlF2yxtKRDiqqXBoVLBpc9QBlyQWe6RfRYuPk=;
        b=uJ3bS2wa9Egii+1p1x4faXFK8Ja8k3mM1wS82rP7z8NTuFEacqYhMdjd2WZVaNI7X/
         iATFFI0Q2EYo/ku6SL38bHQdSII7LHtNCQXHajXaReqvQ0bc/ACyU93++2otZXNvpXe4
         YuowFHiaihJi0sfeV4et1TZOpJhpy5q40M0HGqsu2rYe093ApxcD2lxhhmOUlciVTZ08
         XLjj1sspQCS0luD+viqB3/MEnKFsZYotrKhATAjDG/SLnZzwKCFPZP3jEXrb102sw/xg
         sO2ElMttLDzrYcaUdawfYbqrUlC3eeOMiUuDUc6fjRoXcM2YXXtQJpQOjRlKPflBB5FF
         F93A==
X-Forwarded-Encrypted: i=1; AJvYcCVo7l6X/0jjEQ4R2TFIFJPCnIPU6P/OhPJZG0XiFuT3+hieMqmr9/+dXKHo3PSSIJt56xbdCrWqavi97Qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVNLryELNnMUiUrN7qTFU7DMPYq0M3S2eGmypU5L9f5SyhcGgD
	2x0KYPHWSNYjaEczjxJs8LNz78aSQUi+t3PmBxqPWJ2pzh5nnckFp/3NoXbaVp6Pwtys57W62Fs
	w3ks=
X-Google-Smtp-Source: AGHT+IEGXiMnck561GiPVud4Tk+sxKMRCB661s4UMQy3SKlCHvQ/c3AuDsTiFtiYq64afXQ6WTPpUg==
X-Received: by 2002:a2e:be24:0:b0:2fb:6362:284e with SMTP id 38308e7fff4ca-2ff5900aecemr26592241fa.8.1731604910251;
        Thu, 14 Nov 2024 09:21:50 -0800 (PST)
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com. [209.85.167.53])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2ff598a1a18sm2475431fa.117.2024.11.14.09.21.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Nov 2024 09:21:48 -0800 (PST)
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539f2b95775so1229947e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Nov 2024 09:21:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJUVyABx0H+lA/WGcVdPp7idkQ7vyBvHuJK1GwATf3y7qEcthL/hB0PPfcnBzxU9Y8ZUdNZfQXN+Q0bD8=@vger.kernel.org
X-Received: by 2002:a05:6512:224e:b0:53d:a504:9334 with SMTP id
 2adb3069b0e04-53da5c7b565mr2490631e87.44.1731604907586; Thu, 14 Nov 2024
 09:21:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241113124857.1959435-1-chenhuacai@loongson.cn>
 <CAADWXX9-LY7aaMax6KdtDV+vOkm_WKE76Qmy4n3UHN61O=-2Lg@mail.gmail.com> <CAAhV-H6=_Nv0N-zXNad2TgOzTgG_BU6TPhN+U4u=+SMQ98BPJw@mail.gmail.com>
In-Reply-To: <CAAhV-H6=_Nv0N-zXNad2TgOzTgG_BU6TPhN+U4u=+SMQ98BPJw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 14 Nov 2024 09:21:31 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgC===Qx3STDjBWGHuzJ0SNP16gEz3iSc6Ebo_bM-yZtw@mail.gmail.com>
Message-ID: <CAHk-=wgC===Qx3STDjBWGHuzJ0SNP16gEz3iSc6Ebo_bM-yZtw@mail.gmail.com>
Subject: Re: [GIT PULL] LoongArch fixes for v6.12-final
To: Huacai Chen <chenhuacai@kernel.org>
Cc: Huacai Chen <chenhuacai@loongson.cn>, Arnd Bergmann <arnd@arndb.de>, loongarch@lists.linux.dev, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Guo Ren <guoren@kernel.org>, Xuerui Wang <kernel@xen0n.name>, 
	Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Nov 2024 at 22:23, Huacai Chen <chenhuacai@kernel.org> wrote:
>
> Maybe the root cause is that "From" in my patch is loongson.cn but I
> use kernel.org's SMTP server?

Ahh, yes, I didn't even notice that you went through mail.kernel.org,
I only noticed that loongson.cn did SPF but not DKIM.

Yeah, if loongson had had DKIM and DMARC set up to match, it would
have been an even noisier failure about DKIM actively failing, rather
than not having DKIM at all.

If you use mail.kernel.org, using a "From:" with a kernel.org address
too to get the full email verification is likely the best option.

That said, I went back and looked, and you've clearly been using this
mail.kernel.org + loongson.cn model for a long time, and it hasn't
been problematic. So your pull request being marked as spam might have
been just a one-off.

           Linus

