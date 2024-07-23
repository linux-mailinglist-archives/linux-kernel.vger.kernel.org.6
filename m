Return-Path: <linux-kernel+bounces-260431-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D50393A8D7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 23:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EBD01C2267B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2024 21:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DED145B34;
	Tue, 23 Jul 2024 21:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="F2WGeDs/"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D84143C63
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 21:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721771367; cv=none; b=eOpc182O6pRxKeBo3R7mgu33BNazzA5MrWhgvh+QC4Rniph1Rwjqw1lRCU/HhyzE+wuWXLE2lbwV2Y3xoKoZZcgCbRtaC/+jkH3WSP4SkSpj6NSpLOb6G7EEm/D04T7hGECIClveYzLuuYeRQIQ0krUowH7MT7gjrUinAQSe/zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721771367; c=relaxed/simple;
	bh=tuer9m0mKhQDkVcfZ8kLcPt66+D93aJTgEJaTNWyVuw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sXjzjnTXa+YkWWN3efxDKFG/R7OeYjv6HIQr3vJsvofAfhnt98Yz+y20TSNr8wOxkwHOrHU/uYEGL6bvbqSLFiEJi21i5SHq4wwiwcbXqgX5iNUhoeYN8n0ENTYM64I8kw3waJmUA28OFZtcUjKntT77LtnyMvZy21SxSG46jGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=F2WGeDs/; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-52f01ec08d6so3863955e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 14:49:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1721771363; x=1722376163; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bjAE1c0pKk54yZBK3el2XKNqcN4ZjHoabxTHGF/u9Pk=;
        b=F2WGeDs//7crFtOYkm6rtPlFK+Ox1hSav2SxNq7eIjzMopCxRsqgVgNkQb41Zzi+Yw
         xgLxFy1Hzte2Y3gbrVW8ArbKPMI2j1YIO4SO9Fvs44eTq15pDgNVeF2VDK1eDTmVC3BG
         qVjYfAm61qWdjHNC5W9IJZGGTcTLLhrANye7M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721771363; x=1722376163;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bjAE1c0pKk54yZBK3el2XKNqcN4ZjHoabxTHGF/u9Pk=;
        b=qiwkLu8y/g+Z7M5S4PaQ9gPcEY/Mm7yxejVV+2ALwsf00E5VP93lqDctyEEy3rvWIi
         4hwYzD5sy4+ywYgLe2tKRo0AxMJdzKfcfi4COd+SYRum/Lycog9SU47cCJQlRsBdAHp0
         BEEWj5WZRQneNOyVemrfSRjmaArBCjybT+xHV4K9RQvj7k18BK/pbl/fDS5L/orr+Fxb
         8BBuCGQS8VCB15Fa8Dkxqyjicl6AMuAFZvUpxUWCyi5nLD5JBnorqQvzKO64rUHtDhKR
         XV6QWzttU6JbzcLZ5QjwDnk5yJou+MogbeZW0Ah/JB35EEtOxRkNfhbsZKRo9doJTIWO
         RUyg==
X-Forwarded-Encrypted: i=1; AJvYcCVGydekxbzK+ZRGf31wh6ddPjV71RtLeU5GOvJ2qEORWIshUwCex9DhMt6xTGB+wM3nMeSRun6w2jCbGCfSZlROLSbCqvdeG+DMSmpQ
X-Gm-Message-State: AOJu0YwuaPh7S1yKFW0sKIlX6WFmNMjP2O+ZhVf2BI3Iu6/6Ddeyl73K
	9q3689XZ4XZ9vNzgGjhJK3PvabRxhofbmXBjh7bxt3E/5ahWqYQ0GEn8KljpNEppb/xjOpMTJDd
	1PfgY7w==
X-Google-Smtp-Source: AGHT+IHR3tVKQo6bKYe+34plFpwZVfjY1/Zl2gFnPd91nJ2CphBSz3ppeKomOmEGgdTR1VnqBh5bgA==
X-Received: by 2002:a05:6512:6cf:b0:52e:767a:ada3 with SMTP id 2adb3069b0e04-52fc406f8bdmr3272901e87.47.1721771363297;
        Tue, 23 Jul 2024 14:49:23 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5a59be83c69sm4702363a12.58.2024.07.23.14.49.22
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jul 2024 14:49:22 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58b0beaf703so5010019a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jul 2024 14:49:22 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXR6h4Rjag0TnKtUbun3xmmEbDJ3rcqbwEwtMnf59HPr7u9PaghYk2r8jR9DQmOwShCwK7nF3d8ZYJKpc6d0dQqVVk1dt9kBjYATrK5
X-Received: by 2002:a50:c050:0:b0:57c:9d54:67db with SMTP id
 4fb4d7f45d1cf-5a3eee849b2mr8538235a12.9.1721771362225; Tue, 23 Jul 2024
 14:49:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK7LNATbZgv6JNzSXznOm47oNUXku430-taoK4iE1G0YcBy4Lw@mail.gmail.com>
In-Reply-To: <CAK7LNATbZgv6JNzSXznOm47oNUXku430-taoK4iE1G0YcBy4Lw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 23 Jul 2024 14:49:05 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiF3yeWehcvqY-4X7WNb8n4yw_5t0H1CpEpKi7JMjaMfw@mail.gmail.com>
Message-ID: <CAHk-=wiF3yeWehcvqY-4X7WNb8n4yw_5t0H1CpEpKi7JMjaMfw@mail.gmail.com>
Subject: Re: [GIT PULL] Kbuild updates for v6.11-rc1
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jul 2024 at 12:44, Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> You will get a merge conflict in scripts/Makefile.lib

So the merge conflict certainly wasn't too bad, but I really don't
love the complex  fdtoverlay command duplication.

Strangely enough, there's a simplification for the DT_CHECK_CMD case
(used only once), but not for this creation case (now duplicate).

I didn't do it as part of the merge, but may I suggest adding something like

  DT_CREATE_CMD = $(objtree)/scripts/dtc/fdtoverlay -i $(filter %.dtb
%.dtbo, $^) -o

and then using

   $(DT_CREATE_CMD) $@

to pair up with the existing "$(DT_CHECK_CMD) $@" logic?

Or something along those lines?

(And no, I didn't check whether maybe the argument order for the
'fdtoverlay' script might matter, or something like that - I don't
think it does, but I did *not* test the above suggestion or really try
to think about it deeply, just mostly a reaction against the command
duplication particularly when there is now a comment about the
subtlety of the arguments)

             Linus

