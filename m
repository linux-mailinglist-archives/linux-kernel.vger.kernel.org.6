Return-Path: <linux-kernel+bounces-258347-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE5669386A5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jul 2024 01:20:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AC66280F6F
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jul 2024 23:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3739213FFC;
	Sun, 21 Jul 2024 23:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Y9hUGw8t"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AE116415
	for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 23:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721604004; cv=none; b=GWIW/R7Sx22kXq5PA50DEh7yE+6eHyr4GVOTEhKnaUlxV6r6RKUcF06l02eYLlq/ujN3JVphOfdn8dsGvWP1sbCzgV9VeCV7KcI8BjWGRbfrvQA+gkaQlJEN6OmS5PDl01INCZXN4Ro1+J13b111QrstXGw/SZKg2+ZLYwIpNGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721604004; c=relaxed/simple;
	bh=6XfL6zmiG48Bc5+7L2Nvgt2xjns4Mg6TDYVp2oOpnxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTgG8YHfxb86Oz1ou/Dm3GTRUuRwVrBbNU/X5RFHvtDTscotvzGLH/n1x/6VI6hFtWXDc2iGB04fhSRVfRKYxX6p8XYQC3JpM1vdsfRqBQslAHrEc1Kd3H4iFYjzLwyzKhTDYoF5shxV53RTTGVgsESMzfEhYE4UpIzuKD3H/sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Y9hUGw8t; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2eeb1ba0468so50115541fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 16:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721604000; x=1722208800; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=32YuisS0nN9yXPU8HG6FFhSsLCxcgTmmQjMW95eNEt4=;
        b=Y9hUGw8tgaUF+IIZKmd7mnSYYDP6v5WMcwgFFrcCcelpoGsP+27YFdgDTgSt3tgWtA
         RVIh4xzEaLSp3oF3MAy45EvL8JpnNCVMJNRjkPqtiEYxfyMt9dZdOBDdYiTP+VQ/A8CB
         t7qMOzUUK6J6WSSQabmy6vc1UOrcyWrQrA0jc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721604000; x=1722208800;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=32YuisS0nN9yXPU8HG6FFhSsLCxcgTmmQjMW95eNEt4=;
        b=Jv75T6oaAl/fwavsAIfqi5jz8R7vxthrYc/x+aMsXwj1sFqqQ+EeaqWCKJp0Q3LMZL
         R9m3W/A+I6qfkq9HeNba1oGpHbzzuQ5G1R/O7lw65/H4iAt4Rz1TthDdvWougjlhoP+Z
         ZpMQOBJNQnIo3saXy+9mpWv4o7sysd8E1pRqgl68f+hDKVn4SNaVFpzdZqlyGed34kU1
         axM7/6o/zOSRl15CKXYBNPdEU6njP0bsI4nO2aNftX9CT3auhZqeAMJlyC94jNqzbSqJ
         0llWFUdWr+qX7MDMlq/XE1EXrDbCMNI2JxUMFMYfIriifirVWmp+2LznFri83OUluCbz
         s+Nw==
X-Forwarded-Encrypted: i=1; AJvYcCXXugQBQPQy126wr5TYuqcAiZF70I1yOWfqFeDHusIwZlv7JbUrJvoGu4z3boirJz0DPBN8eQ58MvomjsRpNjzVLvFiW5UzY+BatL1o
X-Gm-Message-State: AOJu0Ywy9oMqLS+v3lHJv59CImkIqncwDK/POX3JQyscxm7aNzG8A/Yp
	PdM+a2lM8sfVbz6+C7vpjha3N5nNtwZcVK3jDQ0c3hUMsFN9C6rXid0l0eoNMH65ZUGw8h6mFxg
	F6Fc=
X-Google-Smtp-Source: AGHT+IF79O6+ioEgg/fdCOUqI4kYeBdE17PTG4BrMcs9pPEQlxq37IZFyz1yUD2Y3WhX+25yxW9GHg==
X-Received: by 2002:a2e:92c5:0:b0:2ee:7a3e:4721 with SMTP id 38308e7fff4ca-2ef16826a21mr33363381fa.39.1721604000137;
        Sun, 21 Jul 2024 16:20:00 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a30af846e0sm5173076a12.53.2024.07.21.16.19.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Jul 2024 16:19:59 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5a1c49632deso2887651a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 21 Jul 2024 16:19:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrvPFu2on9IRBj7ymuiiQFuVeku6r4ZhXnxfuBugAd6RUMuQliCZD35LscF8ePJN5Uc2TtkWLi9rwjh2pVPN7WD7cAWxJ0yciHys9/
X-Received: by 2002:a50:cc8a:0:b0:5a4:6dec:cd3c with SMTP id
 4fb4d7f45d1cf-5a479d6470amr2804096a12.37.1721603999287; Sun, 21 Jul 2024
 16:19:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240721145415.fbeb01a853962ef91334f3d1@linux-foundation.org>
In-Reply-To: <20240721145415.fbeb01a853962ef91334f3d1@linux-foundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 21 Jul 2024 16:19:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjpx6uTAvjNnD5eipGjNYcwTgG9G6Dct=eLTfyzaaTy_g@mail.gmail.com>
Message-ID: <CAHk-=wjpx6uTAvjNnD5eipGjNYcwTgG9G6Dct=eLTfyzaaTy_g@mail.gmail.com>
Subject: Re: [GIT PULL] MM updates for 6.11-rc1
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, mm-commits@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sun, 21 Jul 2024 at 14:54, Andrew Morton <akpm@linux-foundation.org> wrote:
>
> - 875fa64577da ("mm/hugetlb_vmemmap: fix race with speculative PFN
>   walkers") is known to cause a performance regression
>   (https://lore.kernel.org/all/3acefad9-96e5-4681-8014-827d6be71c7a@linux.ibm.com/T/#mfa809800a7862fb5bdf834c6f71a3a5113eb83ff).
>   Yu has a fix which I'll send along later via the hotfixes branch.

That commit "875fa64577da" does not exist. I think you are talking
about commit bd225530a4c7, which is in 6.10 and came in from your last
hotfixes pull.

I'm assuming 875fa64577da was some commit ID it had before getting
rebased or something?

I'm also a bit confused about why you mention this, since neither the
cause _nor_ the fix are in this pull request and you have the wrong
commit ID.

               Linus

