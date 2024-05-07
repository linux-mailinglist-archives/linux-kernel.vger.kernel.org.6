Return-Path: <linux-kernel+bounces-170568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DC68BD92E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 03:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F632281317
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 01:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5051441D;
	Tue,  7 May 2024 01:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=overdrivepizza-com.20230601.gappssmtp.com header.i=@overdrivepizza-com.20230601.gappssmtp.com header.b="X6+FYG+r"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E81139F
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 01:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715046374; cv=none; b=EMwpNgec0hphnfZA0ChlsSEDL4P+IdFphqVujgAaHSLD2hHdupAKso5Fuuq2q+REFs3nPLvn6Ly7UynMiNQhaP8V/3GHMpfewh+vb1XgJTyNkuPuz//no8ik6F990J4Q1fCI/nwGvO4iHBPcaNs54+AMxYx2kNwfS/S2YQU52xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715046374; c=relaxed/simple;
	bh=HMrJCBdbVu5eCAW3kNgFMcuiHmo+pZkfoo7wgBF+rxQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JzEi3z04K2P04nNl/UtVT+gUqVVxNEDeKQrBWAUae3wkVQ3cy6fcxy5OuePWpECcKhueM7+kVSLEoPlbKy5wVnCvot6cGa3G7PxZbbzMFSEklYiOCBCIy+rXbWJ1/I6Kmm0KaqdziSTrDP+ak+jMZJNyjv1u/OavYWaSHOQVR48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=overdrivepizza.com; spf=fail smtp.mailfrom=overdrivepizza.com; dkim=pass (2048-bit key) header.d=overdrivepizza-com.20230601.gappssmtp.com header.i=@overdrivepizza-com.20230601.gappssmtp.com header.b=X6+FYG+r; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=overdrivepizza.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=overdrivepizza.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-51f45104ef0so2780377e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 May 2024 18:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=overdrivepizza-com.20230601.gappssmtp.com; s=20230601; t=1715046370; x=1715651170; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HMrJCBdbVu5eCAW3kNgFMcuiHmo+pZkfoo7wgBF+rxQ=;
        b=X6+FYG+rdpb0ox1vwOog+F6T8sO1YfD/lldST/5aIH5JaFUTwIHeJjzCnDEJR4YvK2
         KDnJ156YvV27NEz+pxZZt9xQs2oSOB/IcaP8HWu5L2H6qslRbHXJoVgL9eUPcLbGMK0U
         ST/zBOQerF6F1hzivWP5uFEnDzyqReypKymo+ENVh9lP/R1NNk5NWg1zXCW5GPkPFEcl
         GEO+81tOjF5E9GqlgNE9RKZ7t375NmGYm4bYU7dH9KAQ+KGdhwXIgmlNHuMbvZNNSva0
         A3hptaWTv2Crn+QCq5sXz3oXodbzkw5P3pvTUcJ72ktkP0xvNdxR78YYPDsDQmhFM/Y+
         GE7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715046370; x=1715651170;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HMrJCBdbVu5eCAW3kNgFMcuiHmo+pZkfoo7wgBF+rxQ=;
        b=HmNpV63jJFcx6Wqq045QobTpH2ZWlhN0eVavFfRt7An8dbyW3HNCcPPIcFFbxJDv3D
         9TT5VQ6XzkhZBwzSYqd+a1hECSgYf6h3/a/sljQyyZlJih5s7Kmn2tnWFKfm83c2e/es
         S9PwndCCXGdheY+dwCj42Sxf+RkHnnoHm8VyDziQp9ef2dTn6PoaVAbV4XLDJnBl4ewj
         l02Sp7+IuZuXr2VcByi/y/3J4/9qLAAqln1JBcVsK/CXCra06OgdBEJuryg9wStULAul
         lZUTcJrExdr97ivKy1CTFtLnGb+Wk4gMfVPYl1e/JKC4WXbZUmBpHU+JH/7YlFxpoDvw
         gj+w==
X-Forwarded-Encrypted: i=1; AJvYcCWKLn9+O7mNgSLk9d+mWb5xHIMU1xw6J2m/CQKlJvnqw6fL9wRg1zi+U6c/w/yOI1SCahDQiy22PfFUicNypktsKK2nB6F2gm9fUkWZ
X-Gm-Message-State: AOJu0YwPkLgAfQzmot76Vz+om1Ka2Wro4CUq9HmKbqq4yWJaMZwIcF9a
	Vks15tIFOBhor/gNBtNeqeByQOH5/I5YeWSO6z9yW5wZw+woEegw0Z/Ybfg/VEpMNY6N5b8cBpw
	GARAufuX9mhPRNBjO2OI3NvFssxXl8KFDerYgAw==
X-Google-Smtp-Source: AGHT+IH2xFh1IbDHPJXhq9DdKIT6y/sMxSsAgrmSD2IV2zJ1UbyUN8w8wSFc2uqITr+uKlNm7sGmfTKvBYiPai5RVCE=
X-Received: by 2002:a19:434c:0:b0:513:1a9c:ae77 with SMTP id
 m12-20020a19434c000000b005131a9cae77mr6561094lfj.52.1715046369463; Mon, 06
 May 2024 18:46:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Y06rtoE9BsERG9uv@hirez.programming.kicks-ass.net>
 <202210181020.79AF7F7@keescook> <Y08H8zJ5lQ62jel5@hirez.programming.kicks-ass.net>
 <c561dd8ec384bfc77998a6db6ed824e7@overdrivepizza.com> <Y08M4+GxoqvuZ+bq@hirez.programming.kicks-ass.net>
 <d219d61420c48a90a2e8bdc29cb8a579@overdrivepizza.com> <202210182218.56AD2871@keescook>
 <baced047981ff5fce633156e3e374dfd@overdrivepizza.com> <202211011437.F82B61B8C@keescook>
 <1f6069657f4630c36d60baab2e9b3d10@overdrivepizza.com> <202405061031.43EE1C4@keescook>
In-Reply-To: <202405061031.43EE1C4@keescook>
From: Joao Moreira <joao@overdrivepizza.com>
Date: Mon, 6 May 2024 18:45:59 -0700
Message-ID: <CAKUFkX0K1+U==xjvJEhLn+0p6iZH9=z=48eMMRnVrX7O6zeRcw@mail.gmail.com>
Subject: Re: [PATCH] x86/ibt: Implement FineIBT
To: Kees Cook <keescook@chromium.org>
Cc: Peter Zijlstra <peterz@infradead.org>, x86@kernel.org, 
	Sami Tolvanen <samitolvanen@google.com>, linux-kernel@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Josh Poimboeuf <jpoimboe@redhat.com>
Content-Type: text/plain; charset="UTF-8"

> I can't find a PR for your NOP->INT3 patch:
> https://github.com/lvwr/llvm-project/commit/ca9029c4536d0544e35dff85e4806803e256841f
>
> Are you able to get this refreshed and landed?
>
I can't recall if I ever pushed it anywhere.

Still, I can look at it again, for sure. I'm a little bit swamped this
week, but I'll give it a spin in the next few weeks!

Tks,
Joao

