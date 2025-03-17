Return-Path: <linux-kernel+bounces-563271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 161DFA63C27
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 03:53:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37A851889540
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Mar 2025 02:54:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F63015687D;
	Mon, 17 Mar 2025 02:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+nQnTBX"
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46412FB6;
	Mon, 17 Mar 2025 02:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742180028; cv=none; b=pLqmwlNF9xrrJqYgvdy04x6os9QP9nQfIk1+GvQFGZNt/rPoNn0LvoliaaXgqmrKrCaD3KByiGYUsiLp/s4moo8stiMYt821/pNgiMLDzXoh3cO0oLMQRnXgCMfsO4d1VV+IIV3o5A/6eIYeWM3T2wVMkHujE+LAhX3SiCQzV7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742180028; c=relaxed/simple;
	bh=s4pehmqV798v9Jv3dej+/6WZnixtY8UeLNjRX5JnVlo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AfeDk+xAPQnEBGsrsJ9vgn9xtmX5CYE39F6Z2vfLvHcHZ7W/jZXDHQeoy8E6aJ6eCG5ABBYTQ2waQlFknOOitmIh5841GjoQjEUA4uHAEmJiU4PBYpPnQqcooGYhnxTRmQe4X5UjM0GnmxsLIUfB5b9rYj/RqUsCCXcSrQ5cRr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+nQnTBX; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac34257295dso231851666b.2;
        Sun, 16 Mar 2025 19:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742180024; x=1742784824; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s4pehmqV798v9Jv3dej+/6WZnixtY8UeLNjRX5JnVlo=;
        b=P+nQnTBXISAN06nd3R5VFpHGKVCwA0SlizDSZD1p5YM6H2GujOvamIJHSqbHtWzl4H
         YheKPOHowCgxNF8Xs8za+SE7S6QpzVRuvUxVYX5laqgdQoE89d0wK9RlFs8gMVPGgR/3
         3Blz1VwndIr0vnBI/SiPfy7D4wimLnJmmiEe3WDAAz794XTW0iTl2/WUUhAtzPUDpuOu
         0VSbEAQhEfokcnunlyVFEPy3hXr9xs4SwfUgtQVNvFxqoxf2tZWeaWzupXPN2hsp2Atq
         SHhudGyINkDIKCMqEna0JgcTA7H88r/d77z6UMYDPR7aR9c0IepSR2XKrll22AhPD3al
         duOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742180024; x=1742784824;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s4pehmqV798v9Jv3dej+/6WZnixtY8UeLNjRX5JnVlo=;
        b=VMmlCSnYu8T5RDTDumGOcMDmxVhyh0sW47WSCxLS0Uovo7/36wDFIJB804WksJNzHi
         INfQfOwfP+xs4StIBdu3zw/Rgtb5HyFyG22ugmugVcSaptwT0oR7W6B4BHFi4DcSRLo3
         luA8mDPDnh8tMGgQ7Gg2phpXb/eUx9jXaswYUvhOKz7cYgxdzI/9wpsH9hrwSx3D7Z2C
         CwNVVMU2HVOxbptxP2WX9p/1WE20NA/3c/uuXhdfJFbLKcqtwHIexYDKmOtXA99KZOC2
         YL6KJIYmsbqq974MuW1UUkQub4TDMxq2LZ7O9aFUDlTB0gvNHBs4/CXknSa0xVuzsObB
         lQtA==
X-Forwarded-Encrypted: i=1; AJvYcCUCTr1ZUXuSWmxaWfM/hMFoUi0k6fPFaJP79xHFvUzlS61IUmEdhr2ewm6uMz/N9fxmAezZBiSQpR/UsaNW@vger.kernel.org, AJvYcCXPjwCYziwJwig/Fz5HItRnRbf45Q04yVAwnO26WAa/J4JARZhRVnB48d91axwUaOVTO+FcwfGjtq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUBiMEwbHrqywSAsIh59Y038s/KtUmLNaQdkmk5JQmHxO7M802
	GKaKT3KfDaeRoyo2pF1E2/a0hQRN4Cbw6Pcj8BvW9TZ6Y8QAg9yRVEToYdIg+aqQ2FmQOKFrla+
	oMBN9LzpICMO1qmr4HXl8Y+3dlR+/rfgxkB0=
X-Gm-Gg: ASbGncvwTCefoeSs1WGswI4KdV0SQEC+/Y3+KIqJoNt3u9bMHEcukjtRCdz0KWjshHH
	8nkby7XbMD/mKrToQjchwLZdHC8tk1tJw1fqYBgenEeStSR3lmA5b9XFxlBRKHac5STw1SYroS0
	tK99l9VyAaNRUb6v0ynLKKV5gCUPf+
X-Google-Smtp-Source: AGHT+IFb1SBXwfQIshlQn4d8jRFmxovYMRaGpa48Dp7+9we1erWX7TndiXy7ho6ihN/58Q8wpfTYjXd5njKvgrDV3ug=
X-Received: by 2002:a17:907:6ea9:b0:abf:74d6:e2b0 with SMTP id
 a640c23a62f3a-ac3301db34fmr1188373266b.3.1742180023551; Sun, 16 Mar 2025
 19:53:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <f11afa64-1629-4005-8cb4-723d9b6ce6cb@hust.edu.cn> <20250317103147313V7IEKc3g37STl_idkF_ZB@zte.com.cn>
In-Reply-To: <20250317103147313V7IEKc3g37STl_idkF_ZB@zte.com.cn>
From: Dongliang Mu <mudongliangabcd@gmail.com>
Date: Mon, 17 Mar 2025 10:53:17 +0800
X-Gm-Features: AQ5f1JqIn9iLbOK6qwul6BzNHb0SFYqnLe7tLMEFJvtAV5TeZT-AztBwBzPH_No
Message-ID: <CAD-N9QXEam8v6amrfswCDFfmEkb6npDLxHRaT2dYAVEV0T4i8Q@mail.gmail.com>
Subject: Re: [PATCH] docs/zh_CN: fix spelling mistake
To: jiang.peng9@zte.com.cn
Cc: dzm91@hust.edu.cn, alexs@kernel.org, corbet@lwn.net, 
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 17, 2025 at 10:32=E2=80=AFAM <jiang.peng9@zte.com.cn> wrote:
>
> > One suggestion: the original English(Documentation/mm/balance.rst)
> > version also has this typo. Submit a v2 patch to fix both?
>
> Documentation/mm/balance.rst was already modified by Suchit 4 days ago. T=
herefore, it might not contain the typo anymore.
> https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/c=
ommit/Documentation/mm/balance.rst?id=3Df5d10c46872ca9a6d716854354c11f2f32f=
ce0e8

LGTM. And your patch is merged into Alex's tree. Congrats!

Dongliang Mu

>

