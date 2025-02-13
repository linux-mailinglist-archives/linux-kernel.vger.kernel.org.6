Return-Path: <linux-kernel+bounces-513722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 874BBA34DD0
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 41FC41672B3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87B4F241691;
	Thu, 13 Feb 2025 18:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0fK1wnK5"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8357928A2D5
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 18:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739471952; cv=none; b=duYMWdiFHvrEEo83NtnDDUDWqatDlcRvs42YeP09cFwCBVsik7q8ewI2lVlPLSvCTX2q2DsIaiGSyle1LsfnIXjbS+b1tjVBvAg0axds8TYcbJT3AOuMIrn1morSblQxAnQT+S4FBCDZov1YIQCpcBcKKgOsEVpJSfPLvDQ+QKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739471952; c=relaxed/simple;
	bh=GKTxK6jMbo+VU1rfVK8YLyS2gGtvcGk8MihuWJgrpPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lVkW+Kn5JKcgV9fvdlHpTshMrZfndWztCmfLJ6xnfb6OU++Abszt2BBOU0fP/Gs8ywsylK1Q3BwpCZ5YWWlgUxaPWyW0SztGUv/WfFgNWgJq04GsekriBCyr4qhHYqyyZxPsC4kXLD9oi7qUbAqHD5aGrczDCtOCjx4uN8/EJ5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0fK1wnK5; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-4718aea0718so27671cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 10:39:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739471949; x=1740076749; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GKTxK6jMbo+VU1rfVK8YLyS2gGtvcGk8MihuWJgrpPU=;
        b=0fK1wnK5njvgKFF/EceTHgiNXZXCKCpNEynd3uwUM4IkYgXZLYWDatcAuMHsrfldiH
         io1i0MEqx+X0R7gz6ennkLWNMAAuzSqG77l09sH+GesV5e6ulA2j/M+DBP0oe1pYcpo7
         faHq1nTedmN3dNSLymfuuLKvtswJYQnRmy1nZs4BpqIKg/RAc1Hz8iniIA8ME4BfZaA8
         6MqM1i/P0dlCXbUgS2LJ4ACaRnIcJWqkNdb3nJ2dq4RLJJgyQle+Bm3RdOAAxVezlP8R
         LYh+gV4kr/k0OOLPlPJP7socn7ABfaor85Ga579ili8e0h5brDiyjla7qiMRI+nMaNkT
         7kyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739471949; x=1740076749;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GKTxK6jMbo+VU1rfVK8YLyS2gGtvcGk8MihuWJgrpPU=;
        b=kptGJ2TItQkYRNFxf1ZUk+N94VZh6fIRlvjR8Kvc8xYcA5ErDIPOG0/N+W0InesM/P
         9ecZtkxQ8ivcaR/VNDOoB020vl0mfIsSMCTzoWjlPT92d14uk0klPqXRldkZRJUXLSQo
         zjIJ3F7mAceK4MAjjvL1RxAFlB6f1AcM4k/qQwGHVNtjtFeLzdDihOZOFhW4Q+pZ3c4Q
         N6Xdwf65Qv0+bV0VeX9txzb0yF/qy82btmlSvq0LLEiQ5qTYKP03lFb2RBI1zoQDuAyS
         2iV7VeRE5lSCFStbQztZbEOskDyPbiw/1sqYijmLrNVPiMHnHegcDwyzh/Be10tbdY/H
         i0CA==
X-Forwarded-Encrypted: i=1; AJvYcCWGxfOR8wjcfOn2DU7fXhLWOO2WaImRBMso2D+hv7aiFe+WvxSYNMz0m0yfxO2cC7gkxn5zj8s28tHwyKk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLMCMj3jr3MY1I6D8dh+ih0Qwje+OGzpsMLuKZMf6bi++6VvKC
	/KXpEr2gh0thOZGuM0IWxKPDm853zUZlTOXuyYbtaCyxUi3pYsxQdmJHBBxUACUI0bchuzU0gfX
	WUCdNJQ4ygcklPRGBfk9k0XO9rTExv0T+4gnsNavRSJLhweH3P0fE31jDPA==
X-Gm-Gg: ASbGncsCl1vxE2LfThfFGT7gkXWudBiiXjI2VYiCr4IoiXV1ZNUdzwCerxoImrjgLGH
	wzypG60cy73a9MAcxWNdCzMYLeTwlnr0CdIZXJYxAy9qQ1US2h0dngBktPPeOxlslsaWUh9XP0o
	gX7vD6V7m2WkwQTOygnl7wndYKVw==
X-Google-Smtp-Source: AGHT+IF4xDaNzVce9dgGH9MryCcDiuY/x5c5oPtwTfyn7soJu4rCHUKi+VgtPavxik6VS4RbdhEgbR5aAQ70HhZbaVE=
X-Received: by 2002:ac8:5fcd:0:b0:466:8887:6751 with SMTP id
 d75a77b69052e-471c1f9f9c0mr3966461cf.23.1739471949091; Thu, 13 Feb 2025
 10:39:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213161423.449435-1-riel@surriel.com> <CA+i-1C3DRvustO9eH4PFyASD_SRoR4iv22BMfvu9BSKDK_SFLw@mail.gmail.com>
In-Reply-To: <CA+i-1C3DRvustO9eH4PFyASD_SRoR4iv22BMfvu9BSKDK_SFLw@mail.gmail.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Thu, 13 Feb 2025 19:38:56 +0100
X-Gm-Features: AWEUYZlaxpnS4U_6JUBnYARQqPpT_gsCK9VIfU9Obm74133CrRJ47J6A9ECOiTY
Message-ID: <CA+i-1C2nPV9Q=baw8NJN8rt7TuTcCaA+JpdJMpVNsOqjLk3=vQ@mail.gmail.com>
Subject: Re: [PATCH v11 00/12] AMD broadcast TLB invalidation
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de, 
	peterz@infradead.org, dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com, 
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com, 
	linux-mm@kvack.org, akpm@linux-foundation.org, jannh@google.com, 
	mhklinux@outlook.com, andrew.cooper3@citrix.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Feb 2025 at 19:31, Brendan Jackman <jackmanb@google.com> wrote:
>
> On Thu, 13 Feb 2025 at 17:20, Rik van Riel <riel@surriel.com> wrote:
> >
> > Add support for broadcast TLB invalidation using AMD's INVLPGB instruction.
>
> Oh - what if the user sets nopcid. We need to disable invlpgb in that
> case right?
>
> (I assume it could be made to work, but doesn't seem like a case worth
> optimising).

BTW there are still a couple of unresolved threads from previous versions.

KPTI comment:

https://lore.kernel.org/linux-kernel/CA+i-1C2zuctxx6oPVVu0zBJ=Q=Hs73mgrWs5jsp8obARNcUS9g@mail.gmail.com/
and
https://lore.kernel.org/linux-kernel/20250212104239.GF19118@noisy.programming.kicks-ass.net/

Clarify context-switch sync:

https://lore.kernel.org/linux-kernel/CA+i-1C2CcQmrbdv0wLUJFD6m85D7LekejU=VdgMxnqZW=DRPxA@mail.gmail.com/

(there's another mention of it somewhere that I can't find)

Suggestion for WARN_ON_ONCE:

https://lore.kernel.org/linux-kernel/CA+i-1C3-F-VAy_JccwKx_AcD1mXsVcGHGwUFvi_ruAiqusiXZQ@mail.gmail.com/

