Return-Path: <linux-kernel+bounces-447587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C86D49F3498
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 16:33:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8ECE7A0525
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2024 15:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E31149C57;
	Mon, 16 Dec 2024 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WswdvB60"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F271494CF
	for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 15:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734363205; cv=none; b=upD8Qc6kS+1gXoLr1CzhuoAwfMMAJhvL+R3KVwf92RUeXmpowvIczrAQdDgI4oJ3GRxs9U1GC5yCJgIn2sTIGZUEiGjftfCokvX+nELk2qS89gasmOOyAzEnV2KQdTb7oKqKm6JQPXqmcJF0q6shbKiFXSGZ8ChjPxIMpFVQYto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734363205; c=relaxed/simple;
	bh=k2BVVa3MkS2pSp9VQ972U31cQaOuuNggDHTpqRY+xCo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LHP55nZR8V1d82cOAYGyUloHWnh4t6v0wA0nIxk1UI6H8wCGhPH4gieoucw1E8EpxeIIDV8AXTES5oUvZRWf1Ltj4kBWCdB3BOqJdwttgbkIMgV+6oPVaus691ZV+fI3Mo4diA0iHSYHNwj4CRAvclx5PbxocRdYBMadMSrQcVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WswdvB60; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-467abce2ef9so467651cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2024 07:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734363203; x=1734968003; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=k2BVVa3MkS2pSp9VQ972U31cQaOuuNggDHTpqRY+xCo=;
        b=WswdvB60V7SfmgZ/CTF1nJtkxZj0CT8lVGd8ihGTjMolU5crcJLHK3CbQ5F7d9NEdj
         Y8QN2nYt5ywdWwFHpm0hc97Y6SQT1NQaJBUoo3W61tQAgjr5GjNdirznA2er+GFyaQc8
         41lKBuesnfo1P2EtGnMlvKL+3KecDrrmhI8JLfPIsh/JhzFZbniF0ZsviQoC5VOBN+TL
         QmqbUQbEOt5n8NTCn3Mj8w98n8NL1dz28Gj8RSJgkc+dkwMGeDtvQouUCRqU6DvfIhfL
         /uoT+xo4oVG2N+kLDj+PTPeU0Rjq7OiYxmqTVX8p3HTzL+IKyOnBMZrt/qAxFDBTQ9Qm
         eL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734363203; x=1734968003;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k2BVVa3MkS2pSp9VQ972U31cQaOuuNggDHTpqRY+xCo=;
        b=Y4AL0YPeEmljTtiCvopyQgptacwtXpBX4NFRmuKXdePzfhs9y+8sPnh8uGJPnT9wpV
         zl/9aT1ShkLTQOUO6RkmJqQsbIHsV+ycWbkrwl3Etjl3YIYSxnKc9GamJoI+BWhMk0lC
         J8Z8BTAKDAYBe8MQnhoa/fo+y6ya2BirUrwdFXXa5sUa0PvN0aoKT2KW4QVfekkK4yaN
         F6SYZI41FkzvELzamuwFPaImYVgtEYEqJTqysC8j4WMeHVpFv8qJctyQOYIZcx0QjXxA
         6uNquvubb0OpgmLZAh4dzp1q45nonzlTy/ERGyD324kB61F4CVRw+CnyHGMx4mE0buXy
         ATLw==
X-Forwarded-Encrypted: i=1; AJvYcCUIOivfOOAVHayweIcH2K75QDteR38kII5CBbwlNogjefDRYChuKLtJMes6fpASsVJ8BXTISKGMjCLh178=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLQCEfxdUwiduiurx0lyJKZgyud21vBtjVLZ9joEUv+rjBU009
	dbDcAf4hYSbv4AewJyiD8yNoqi0JjN9OZc+YXN3b7nj6ax2lyPczfhamR6av2mhtiXKb09ofSDH
	GSIBEIGEdZA8W3R5kH0CkQChe4P1lj2412n9Q
X-Gm-Gg: ASbGncv1UUWt1ORpucbIR1+9U0D214N6U5o5YCrzNF5V1hrSt8ew0v0MOmOsNzvc2++
	AV1UUTormDRdGOR56YpvRdEGOoD3JxYJVf6U1qcDJZ/ZLETZz3yBqYzTBnPMkawUGdNcW
X-Google-Smtp-Source: AGHT+IHuJc79DxCN+abqtue+xBmsFhPBY/Pf55GM4/Ic8mGSlSRIT+aKgUEXyIwCiVSx+IsdC84Wt8kIy0Wg2WV/hxo=
X-Received: by 2002:a05:622a:181c:b0:467:5fea:d4c4 with SMTP id
 d75a77b69052e-467b4a6c5d2mr5868221cf.27.1734363202954; Mon, 16 Dec 2024
 07:33:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241119-force-cpu-bug-v1-1-2aa31c6c1ccf@google.com>
In-Reply-To: <20241119-force-cpu-bug-v1-1-2aa31c6c1ccf@google.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Mon, 16 Dec 2024 16:33:11 +0100
X-Gm-Features: AbW1kvbmi-5mKEdhbI4oMFLF-3LRo2kJTmyaByTCrwqwp4BrLtaNHFzWH0k0yWo
Message-ID: <CA+i-1C35GBj2CaXs67va-SVpnu0ft8EoFTxEybjJnyOUy7RMow@mail.gmail.com>
Subject: Re: [PATCH] x86/bugs: Add force_cpu_bug= cmdline param
To: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi all, any thoughts on this?

