Return-Path: <linux-kernel+bounces-389879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 335399B7263
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 03:09:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 653F91C224DD
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2024 02:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2DD126BF5;
	Thu, 31 Oct 2024 02:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5cSoP/p"
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C59D1BD9F7;
	Thu, 31 Oct 2024 02:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730340545; cv=none; b=fsO3jNkJKspJU8rGHLKRRCew/V4n4pU9G4cpLKzyMt5iZJl1FK+JdHTtCopX66DuaAlGxY7FxYm+0EU5P3cKIa3VNntLWL/zemJ6E+iTcyf18QTylnW29j0ew8+MZBYzR6wmq0RV3rixf6zjgJQkLZ5CIziwHvtLd8Uvfmegey0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730340545; c=relaxed/simple;
	bh=WKXp0moqgamIP7R29DMbOfl9IdZ2pJ/b7R2GlsuQTL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JcKiqq8kfsbeaB7YLpeqwVxnaJ7H38lWvL7TW4ubzHaUHiPXf0r9dVNraxMeu7WRFgvVEGlXLj+YYuNppiWQ6oM2U2V0ein/KNzVgR55tiodiviexMk+Fcp77jYY2j3PyXUPbyzd5U+DfVrdwcTCJSNKdkg/vUi2ZJ7lxGiQNH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5cSoP/p; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7180bd5b79dso165081a34.2;
        Wed, 30 Oct 2024 19:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730340543; x=1730945343; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WKXp0moqgamIP7R29DMbOfl9IdZ2pJ/b7R2GlsuQTL0=;
        b=i5cSoP/pC5Lck+8R3VUyc75L4yub82nkSHptHY/4NG8rOou8HmbukyqujsGSiBKLP6
         /+vCsdpgWIvGCydck4r9lIRCriy3k4MR8KjVcPvCwfq7j+7W0UWP+0pZdXUJArSfpdXp
         Xpll8Sk6VeRQlS5T6wu307K5VTaF0F5qTMvspkdSC3alVndIPfMHNoqjuawpt/hocc0X
         gusWr7LBr01U8CzGe3sf3bpFVwTcFvozqWkhBCYwMrfkjhyu82EeCoLscI9f5RGpy7Ib
         7eGKgE6mBS6vam/h4eAFX4uQnuowE+hO0KNL65hf5CXw2uTDDIbXhKr8ZjhFT4uak4AK
         SfUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730340543; x=1730945343;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WKXp0moqgamIP7R29DMbOfl9IdZ2pJ/b7R2GlsuQTL0=;
        b=N+qaE+tbZrCKpxELqDHMtQISXufoeVUeqYRMAAMpXgojn/X2NItQ5Vt5mqkEDeChm2
         TqkNyGekAodCSXrg+niO6gjQ8jjno9O7gdFrGQyFGavEhiVCmnb+v4R9q23MMKXBPq8A
         j56H1E5XvUDsP/lYsYu0yoahPFboXj7Z7ae8J27L1hkzLy3MsrLo2cvwEqQalVzv64Mr
         70daft6RbPLycaqNzTneKbliF8gkPlc+8V48fg1zBkMxNCyd4rDLk3kVWw0oym3VgmwT
         yc/dMBNaG4OhhjnxT7QACPVnt25CWPaWgiytWfky29HsM6T7Q5CZrtVUOQ/dwquW5Vvo
         KoLQ==
X-Forwarded-Encrypted: i=1; AJvYcCU98VbifMTVunNSsynCw92pIICFU8Iv4q8+eQPisZP5txq5rYSU6mgTI3yXXdz+nz74hMOV97H+H0ml@vger.kernel.org, AJvYcCX9+9EPSzgjhqfooMJLLNyaKNbgJkcrkxpoxl7qphrt026rRHLSokdZ926zPXbxS3RiNCo4h6DnWgGSjoV7@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0ipgZyCs83edCtozF0FFKcQ8scCGtv5tyuqKqK++j47Ltg6MG
	OIh6/5DX7NMA/1fXDih5wLm7ofnB3AdF/IkX7pNWJjvyn2J90o1w7bp9czYhKhkg3AiptISmPF/
	O98+tziHokBMfYVAUxjLZHQHkkH0=
X-Google-Smtp-Source: AGHT+IH+yrLiJjq+i5ie1WCex04mIWFRLsmq3qV+TlaiiaefPBEphpMHstKWEPeLMuwYfiGYCJ48xmfkRcN6cpgnW5k=
X-Received: by 2002:a05:6830:6a97:b0:718:240:42d5 with SMTP id
 46e09a7af769-71868299585mr18071136a34.32.1730340543144; Wed, 30 Oct 2024
 19:09:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1723716331.git.stano.jakubek@gmail.com> <ZyJ1keHD-neTNZ2J@standask-GA-A55M-S2HP>
In-Reply-To: <ZyJ1keHD-neTNZ2J@standask-GA-A55M-S2HP>
From: Chunyan Zhang <zhang.lyra@gmail.com>
Date: Thu, 31 Oct 2024 10:08:27 +0800
Message-ID: <CAAfSe-uZ5KWfnZ=DqAy=4fJp0TrTimdEs0Vy57CYcsK06Ev_UQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Cleanup Spreadtrum/Unisoc ARM64 DT (part 2)
To: Stanislav Jakubek <stano.jakubek@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, devicetree@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Stanislav,

On Thu, 31 Oct 2024 at 02:06, Stanislav Jakubek <stano.jakubek@gmail.com> wrote:
>
> Hi all,
>
> not sure which tree this should go through, but could someone pick this up?
> It's been sitting for ~2.5 months.

One question is what do we do about those warnings reported by Rob's bot?
Apart from that I suggest you send a pull request to soc@kernel.org directly.

Thanks,
Chunyan

