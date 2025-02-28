Return-Path: <linux-kernel+bounces-538529-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47806A499CA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 13:47:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21B04188FDFC
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2025 12:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D28226AA9A;
	Fri, 28 Feb 2025 12:47:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HF5j9Lu3"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7463F2571D3
	for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 12:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740746869; cv=none; b=ovVq04EeaDBGTC814W90vXapZgo40BM5oSyK2Hka7oHrJYMfcbg0d7+uhOFi/1rQnVa/bxpt8yRKR0QKXfSzD2+ABj2bHHZjekPG3jqf8RFL69z0a8+Cx/0mgR7N16VRJ8OAJallKUNFEhHtdJBfADPQ3ho8N582j2qDjy6IV08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740746869; c=relaxed/simple;
	bh=PWERo/5M2jb9hCdPYwTBJ1qg1GnJybAhnw/RWv5d8fc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tVVuDmTH+LtwISFLd1a8QCVKKnGKOeIwktnG1avjH4y8D5+AzTN9C6St9zaR6aZTPOWVEgKUbgSAEI2+xf8eNjurmlDgbjDsOr+OtaFYDk9G+btMvslrYB2pMie8Alo8z7Tebs5pBFNTZavQudzw1stZ8FDPtyrk1Ufa/02ZRu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HF5j9Lu3; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-472098e6e75so200771cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2025 04:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1740746867; x=1741351667; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Ed09H735YaLqEmSd4YsR8vzAdFaMM7r2CSHKqIy77Gw=;
        b=HF5j9Lu3z0uJ/IHKlSKX7j6bJWSfyQRkClMNsyAxEUZhOW6xIBO94MusDtA5I2VPd2
         bnYJvWbPpTjJENYMraJM7zhefv2xjHxjBegNcJSTTczKHTBWzP2TY+UpKmk8KukgQ2Ea
         o6Q0qKGuZkebKPOors8I0dddoN3/27urgQdnN99PiXUeHbRWSLdgem5GcduVM/DZjtKI
         tJVU1Qprt/yv8a8qpkfmQLqKnYDexvJccHqN8mrFTX9jUJQuZYwIOI3JkZ6y7/5PFcKG
         htNT1U4JU/ddMsxhELB+xt4y5h506QdesnRS0mZI4JVLB4+B+we/rUHGJhkKcNVOtYoJ
         VLXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740746867; x=1741351667;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ed09H735YaLqEmSd4YsR8vzAdFaMM7r2CSHKqIy77Gw=;
        b=qa3OzR7939L81wP6wmMtze9QvXps+HFTeBC3zqK5eTR8581OG3MJ2BEZPyTKHx8I7e
         8egAxZdzpjvbg5FJI3jre2/NxSIXMrPX++qSCowgFmYsklags8Q4i5nIbLtEiB9pHwk4
         ffUwbCZcUf1xS1xjBB/KVO6IKd0hr+CXLeOphZSPx2f+jKsXwyCWVK9FY3Yrj/4w1Gba
         aB4SdV/LbQ5S5DRfD2doYoP02e5NKeOOb7haGUXggEbbGt0JtHvOpQmLUHXJP19+ZdOi
         MqXsGY9RDyenT8z844nfSHbVsajy8WuSEX1orhCkesloJqLSit/8q6YppBxrl7Cbvasx
         uf3Q==
X-Forwarded-Encrypted: i=1; AJvYcCUA9XIFqz5tNbgSLI0cjB3FAdEQ5r5ze/ujxUrvVIkBJVNpNNLx9B5Y0B27u9NnAV7btqf+Zn5rKvGNpvY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwRWJXsYiK5xe4asu7AxqDtjVnO1tu94q461veq9RbHJ1d27IRm
	hA1xbwfWeGzP6wUQoKFqpRzn47sQ1cQW95nD9CohD8Fzu6ACDz8Kdh2kGb6alfUg3TWtaWiu9sC
	OSX8pcS0FXyTqvv4omyJUJcvlZkjkJ6vWFYdv
X-Gm-Gg: ASbGncvR9Po7my4tCTcKc2l6GYweWbvueHAGdcKPwmwi5CboF0ClLzoNMyfUcURFips
	aaRhygAHValJbDpNfrEq9WyrbcBixKshE732DFG2xsDrvzhQrKOxNhHtYfI99JY4g+y3ueL1Z85
	RUiqnbAmnMiwuMsOV6YXGFS76r+MrgWfaSHuOMMA==
X-Google-Smtp-Source: AGHT+IHAYWIF6RIeNLyEuys4z5PBQSKa6Alf5I9MrJkp9EZgDcaziDs2p2jX47RmrCvijeFRV97OOeBVVhw84UVpB98=
X-Received: by 2002:a05:622a:14:b0:473:83d4:f1f8 with SMTP id
 d75a77b69052e-474bc1140a7mr3500371cf.20.1740746867062; Fri, 28 Feb 2025
 04:47:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250221-mm-selftests-v2-0-28c4d66383c5@google.com> <20250221-mm-selftests-v2-6-28c4d66383c5@google.com>
In-Reply-To: <20250221-mm-selftests-v2-6-28c4d66383c5@google.com>
From: Brendan Jackman <jackmanb@google.com>
Date: Fri, 28 Feb 2025 13:47:36 +0100
X-Gm-Features: AQ5f1JqVkRaikeTHI3gz42KwjbOjabWHUukhsdwdOqHxGKv2Oex2PiSl7mtPxuM
Message-ID: <CA+i-1C2RFVZovrxjYGA3i6+vuizkMkr-OXr0bEOQrBqRoAqQ1Q@mail.gmail.com>
Subject: Re: [PATCH v2 6/9] selftests/mm: Print some details when uffd-stress
 gets bad params
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Shuah Khan <shuah@kernel.org>
Cc: Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 21 Feb 2025 at 19:26, Brendan Jackman <jackmanb@google.com> wrote:
>         nr_pages_per_cpu = bytes / page_size / nr_threads;
>         if (!nr_pages_per_cpu) {
> -               _err("invalid MiB");
> +               _err("pages_per_cpu = 0, cannot test (%lu / %lu / %lu)",
> +                       nr_pages_per_cpu, bytes, page_size, nr_threads);

Ugh, this is garbage, wrong number of args for the format string.

I think I originally had %d instead of 0, then changed and didn't
notice I broke it because it doesn't actually cause the overall
kselftests build to fail. I'll need to find a way to update my scripts
to detect that.

