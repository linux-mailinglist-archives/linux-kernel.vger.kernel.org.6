Return-Path: <linux-kernel+bounces-513718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E91A34DC3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 19:31:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38C0D188F18B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Feb 2025 18:31:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 441A82040AF;
	Thu, 13 Feb 2025 18:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xYJqpOYl"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E1245AF2
	for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739471479; cv=none; b=lN9dy/Sx6sBhhix6DpmtwLHOH64bPan+aVm5yCeo6SQd9ShYf0BVQSuAr/c9zKIiJwcMUtI1luixU+eGutwO59O2SJ87cX8oBaf9vODACwjnChqW3yXsUpugmCHmmTO0hhP9cum8bWjhZ50qL6zFZoKz0QQYKZUneCR/RJWcVG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739471479; c=relaxed/simple;
	bh=AClg6xc2pINbi7O+kuo4Rx5bxuLheIN5ymwYfO5cePk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BqBr9oAZgq3bCtVnUk+PtAioqmKsgzZlasZHPUvd4Gd1uZtsIDnzw3KMrqXdC2HxfI+G8RuoRqOK6s2762kLK2xUzCiKWEED5orR3Zpeo6bOhpPBJ7i4KCaCP+gTvIcox91SleTj6asFjoBQXEh/zlBOjjgQCo4Deb54yVsQAm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xYJqpOYl; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-471c9947bb5so16501cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Feb 2025 10:31:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1739471475; x=1740076275; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AClg6xc2pINbi7O+kuo4Rx5bxuLheIN5ymwYfO5cePk=;
        b=xYJqpOYlJo3kjqAPCli8QiMmrArQlv+5J9V3VHfHMzmF9CxzcxMvEV83+LBpPedChf
         bC2m571lWSh+rslau73XgF3cVIG/qxXgreYAJz5Hvxk1RHLpnaBPBgnfz/NrWcFnZoD6
         E9w4USXVTvGYmESdamup1SaOz1SG2g2qzm79JtsAnPci94yuzlIO1wKQP448St3v6/Em
         vf0AGClNljNKibHMrGq8EiLp9izReM6kKujKdTcftqj3Te9KCb/bi2p+WSUPbXYlyTjs
         H4X47ybPgDwSogGggkcRFURhPmDmfbqN0mJjDs2BgjhfLAIuzWR5OY9t+yWtwwGIsP9k
         NYsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739471475; x=1740076275;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AClg6xc2pINbi7O+kuo4Rx5bxuLheIN5ymwYfO5cePk=;
        b=GCffHzrML/cxUgS7BL+B/8XVyITJP6chof0ZuAm9NdKBqBB4waes02fZz+rmGa/2Wt
         8n/2AgVVCEyMB7Gi5c6kyhpTXxHlEgmEC0P2Bo5b9f9+CsaljU/QAx4kDZM5fkoy3Pxo
         VwRtzuqf6RYQHSPM5QsuRRWba/fznGqtE9VUPXIwSFY+nfv1r6mMp4k3nggTL0pBEAeI
         CJgrt3Rhl3Fp7MJYIEI5EJ0XTz/pJR3uy8Pfn9PkqSV89IRwQHGhik24Bj7RDaUTnFpM
         zEl1rrPNfBP4TI1OchVAbeQN7rs4Vh1lw302HuUDdDup6KkIJd16YYrm8/Cofnje40bw
         bO1A==
X-Forwarded-Encrypted: i=1; AJvYcCUDUE+GAD3ikZ+NGU1apIBSi5AYpcIsYpuFDwm7XH6HF3hluS1HOeszu2Yn2pcnpcLmCBxTZF48J2hL61o=@vger.kernel.org
X-Gm-Message-State: AOJu0YxITMUPhM9TI5nQzdyddtFkvVnpqd2Zj49hgj5NlqQhDWTSYUlN
	/1j/VOkyfLe0tXfvw4GqmTe2FT5CZd+2dxLG5CBFpG1r6kvI2+C6R73Wu+DM0DllF8Wfd+DWBSn
	EeLqlINT39X26bcUpzh0nNljbCr4HBH8nPXf/
X-Gm-Gg: ASbGncv7QHTVU24yUkgkVBIsEGVwQbmEOXvXk2zbfZRHiH0Wu/5w9caNIvRLc/nGVZv
	JMcsm8mBj5FIkIa2QyjDfepQp7TTcNpCo1P0JSG8viLqpMleIabK8EfsIryTwUqayxjdR/efzjW
	UR44sVfUuagCgo8L/ohgK4IpV98g==
X-Google-Smtp-Source: AGHT+IEtgHQZO+Agvr4cec8OVb2FcFfoXiu+sNQ9JIBG1YL3nxxEozej4WhPuCORwdlehTizoZ2LejYVUqa9QraqCOY=
X-Received: by 2002:a05:622a:90c:b0:465:18f3:79cc with SMTP id
 d75a77b69052e-471c1fc26a6mr3898111cf.11.1739471474967; Thu, 13 Feb 2025
 10:31:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250213161423.449435-1-riel@surriel.com>
In-Reply-To: <20250213161423.449435-1-riel@surriel.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Thu, 13 Feb 2025 19:31:01 +0100
X-Gm-Features: AWEUYZnY0TR-_0BlPhM5ws0toeVb1-Bf1wvQFlJo5QXbz9olhxBDK85xdDJADGE
Message-ID: <CA+i-1C3DRvustO9eH4PFyASD_SRoR4iv22BMfvu9BSKDK_SFLw@mail.gmail.com>
Subject: Re: [PATCH v11 00/12] AMD broadcast TLB invalidation
To: Rik van Riel <riel@surriel.com>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, bp@alien8.de, 
	peterz@infradead.org, dave.hansen@linux.intel.com, zhengqi.arch@bytedance.com, 
	nadav.amit@gmail.com, thomas.lendacky@amd.com, kernel-team@meta.com, 
	linux-mm@kvack.org, akpm@linux-foundation.org, jannh@google.com, 
	mhklinux@outlook.com, andrew.cooper3@citrix.com
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Feb 2025 at 17:20, Rik van Riel <riel@surriel.com> wrote:
>
> Add support for broadcast TLB invalidation using AMD's INVLPGB instruction.

Oh - what if the user sets nopcid. We need to disable invlpgb in that
case right?

(I assume it could be made to work, but doesn't seem like a case worth
optimising).

