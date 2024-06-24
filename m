Return-Path: <linux-kernel+bounces-227743-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E36891561D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 19:59:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB50B1F21989
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jun 2024 17:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24E719FA7B;
	Mon, 24 Jun 2024 17:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6WDqBAF"
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D830419E822;
	Mon, 24 Jun 2024 17:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251983; cv=none; b=Idq5ZmbhwArEhTcFNwLbFMSydCYh/uis+EaXtyV3CeRCT2Q+HLyG0RSvX9LR38B5HXq+/186/gqGlSr0udqmHFz6+cYfb0Yw99VEY/g5JGqXGX9fHnN0vA2RtX/vSTHcw1Csjvc3rEJUwj9nQoWMec6M4dMxcqm1B1RZMgDV17s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251983; c=relaxed/simple;
	bh=yEqq7OAAdGbIWa5Fb3tN8AGSHXhZ5w7BihL4VSZ0IMg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t/WTgxnJMde+tOL4KqQmy33FSWC4j6BFkegC1JEQJHWrOzqyzvAskPTs3OMt/KxmZGR/papyswTHswVU911OSgkbVUfOq+t0fN7nxd3J6IPGpIKT9Vlo8WCoT48oHiinmmXUGXlicDqgbGOHsL1HZdnLc2QG2Yb4O98L6LdLAlw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6WDqBAF; arc=none smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-3d2299e6650so2151621b6e.2;
        Mon, 24 Jun 2024 10:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719251981; x=1719856781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=udIR0UMVkGNqoJsb1nh98Jnf6cJepNi/RO4WOHtJ4G0=;
        b=F6WDqBAFceU1Qa+tz1MJYDaXGUoM6/UTCpR5M3MSeeNbBiOzaa3Uu1JAAmAF+TLElg
         rIimf3ctbH5veLc+j3jDQYBpBlAVUAc9FGLhtLm0YjcEuKlJI2WsskNyhzaGuOBS5OHt
         MhItc12lV4eEiojll7dSdvu/p4UAv3bfUqMWlljdR+xf7+gX/ZfvOLBerKeY2zQpjHHE
         WT2AVywL8WHSIZiDOYaHYK067O2Fhv6EyoEEFNR4S5FZhqcYlaoUchlDm1Mg7wZjfoRv
         6lwqhcCJv3RCc6xjmdxyPItpOoj1zkPG/oToM7oB1VkU8USfooNPpxuIMyWC9EsMPl1n
         4hXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719251981; x=1719856781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=udIR0UMVkGNqoJsb1nh98Jnf6cJepNi/RO4WOHtJ4G0=;
        b=wVCNPK/J5V7TjgdEhggdGMPTEMtIU6MvepL7pquhlnXBL5gsRr65sDWCrnP1b6thdq
         ROqIWkwaS6suSHN3oxuD/W2q4baGD23I6sjeUlfsa8vqYkvlEqc36UZxqnNv0mnIqSaH
         JVt5Y7BUeKA+MRpq1gffCgVEUVnjez2WuGPhbCZJCGILXmy2rJV+N97ma6nptpehcruq
         KAJhjXBXHUMwSBc0eOGffI6FUD8s7qX2HWd3JdZX3SiPQ9Kvjrd1xTTOSHqW/4j2wwMO
         VElzo+5RkucueWnwKKEYRlZHm8ajZ1bb8BV0cuJFsZlSCZw1Y9t/NGfrdvbGAnwRk3x/
         Q//w==
X-Forwarded-Encrypted: i=1; AJvYcCWuvSNj7HQ6OalMhhGIdaQiyvMkuPsH1H8j6X07W/KV+Dw6S6TdZuBYpsNYmY9vsg72ZztUXqIPHUiq0BrfNocZnZEhDkhwazUCHQamxhneWdUHaSmlSxd6IcO/5jWKQey9yTadUOmLkw==
X-Gm-Message-State: AOJu0YzafWfFRzMUSChHq0h4UTx4Ti8B87CRfDzCIoi+lfGuLK4J3tEd
	rsRobywjRG0xp6wrCpI8WiS46FNt5xrcmqYI+im20SyQYvW3LHZTRwSF3OpMZMKSZsEof9XIlo5
	y2JJ7Q18jBJQszekHswqtoGdio58=
X-Google-Smtp-Source: AGHT+IGsa0ekhfheWgYZJZEC3mAEZFLrTDQL0oduY3DpXZHe74ETnOem/uHkpNav1SCQrYlhDpt27yJzZNakA2nDVms=
X-Received: by 2002:a05:6808:1787:b0:3d5:2c01:9df6 with SMTP id
 5614622812f47-3d5459643f2mr5691339b6e.15.1719251980849; Mon, 24 Jun 2024
 10:59:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <4449f7d4eead787308300e2d1d37b88c9d1446b2.1717308862.git.dsimic@manjaro.org>
 <ba9d41461f5d56947d7851473637722b@manjaro.org>
In-Reply-To: <ba9d41461f5d56947d7851473637722b@manjaro.org>
From: Alexey Charkov <alchark@gmail.com>
Date: Mon, 24 Jun 2024 21:59:29 +0400
Message-ID: <CABjd4YziNk1NJb6p+AxAVK0CR7igE3-6h-sN4MEWwyoW2qaKfw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: rockchip: Delete the SoC variant dtsi for RK3399Pro
To: Dragan Simic <dsimic@manjaro.org>
Cc: linux-rockchip@lists.infradead.org, heiko@sntech.de, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	robh+dt@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 9:55=E2=80=AFPM Dragan Simic <dsimic@manjaro.org> w=
rote:
>
> Hello all,
>
> Just checking, are there any comments on this patch?  Is there something
> more I can do to have it accepted?

Hi Dragan,

Heiko has already applied it quietly a couple of days ago [1], and
also merged the v5 thermal and OPP code that I rebased on top of this
patch of yours.

Thanks a lot Heiko and Dragan!

Best regards,
Alexey

[1] https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.gi=
t/commit/?h=3Dfor-next&id=3Ddef88eb4d8365a4aa064d28405d03550a9d0a3be

