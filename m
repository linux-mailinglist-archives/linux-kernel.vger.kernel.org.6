Return-Path: <linux-kernel+bounces-189450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 77DA28CF02B
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 18:44:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA771C20A48
	for <lists+linux-kernel@lfdr.de>; Sat, 25 May 2024 16:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9334886243;
	Sat, 25 May 2024 16:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MPPvh6OP"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286A28593B
	for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 16:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716655452; cv=none; b=cO1/Jbdt2+u6weFB7p8WHaSlNfTEXWhqobUXWrstfgntQmeCvQW526lNn+juwgd8uEn25giSfGG7r2ai9RviWEBsQ+qMuuAiou1Cvg9GEVkcK/Kj4bp1p8ECk4F/q6wTa61XqJGaFDK8fggYs1+210Q8BOdWeK77O4v7tw3ZOMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716655452; c=relaxed/simple;
	bh=WCBqLf8xWl7QK8aivI70dfgxab6wU9Nc6TJLS8c8dhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MxeBIWiRSbqJSAaSRt2ZHph8lSEXkmq2sK+FAfVkjWPbBd9WB3IZBmtawkTy/wCjvA3XbPR1aef7JmrMEZGkxVNksmeUthkft3QqcGpDgzmY6cjyO0+zc8OGRs7mKLJyCFKDHPXBFIcfyGMfk37uOIDAf9N1490LiqDOcjuHLwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MPPvh6OP; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2e724bc46c4so75256161fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 09:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716655449; x=1717260249; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0XeTI2+I0Yf5YeTzSjD68RcTudZ1kraGCCr7BX0rvX0=;
        b=MPPvh6OPN7mLZJGl7COmBbmuBgT6bCMhXfDnkiHpFJrLNA4L124hT8yWCk9kZxA+Du
         7vtVpQS3LjsJRT/Slf857+D7Vd3WiTT6O/gCa/p4Z+FmWLCGXgS2iIDDfD0uM7rRyz+k
         muVGTAlu9WPdsYGBH9H2dEh5nJRRWoRYglj58=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716655449; x=1717260249;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XeTI2+I0Yf5YeTzSjD68RcTudZ1kraGCCr7BX0rvX0=;
        b=NfXY3Icifq5ILHBPSWRvAh67u/2rRIsl/tVjiR8ag5IY+I0KfWc8flGXDFj+tcA2gt
         XNo5kogZa1NVd/fs0bd25yzZbOm+nMRnjyUYL31QJI1PEgqNPw6xCWBRGuNR+qlEva13
         Emp860yeJLHOwY6Dw+0yML3iAqVnF5UjguaP2vkDURIUCs15x6zSZ0xW36p0Vvzpb3Xq
         jL02Je0DTJXEldgT3uNPjBffZf6C2c3C0Z5jIjKIkawaaIrAvuog2gEP/puXiMksKl6g
         ei1CJVZ6q4MsSVwrVKVOD1MW12AHI9LZs+fQw8Kq4yLle85LSFp0WuBHjTZXf2VlcC/R
         ZJ3g==
X-Forwarded-Encrypted: i=1; AJvYcCUFtUEWDdgy3BwZDmfoMZ2bxiTlwALZ69/bGDayLQRrP1h/fY1Q1jnq7cAVw9Vb3GbhYex0qNIDeQxKwXdMPrtzOQSYRTLdO7e2C8Zd
X-Gm-Message-State: AOJu0Yw4cDASinhE2mKPdPCQJkjrrOTekRxXmPPYONI0KXnnTWOXE1hu
	3JAijP+ju4dThPNa6SEYpqhXhguoJpYLGgNFMMhwWvY3gOU1U7wtGl2ri6g+DWmjQfqlD6oxsQi
	waaRMFQ==
X-Google-Smtp-Source: AGHT+IHS98dcUvpXYYNnHhUieYooJQK5Ktbu9XbakX8oCikCZ2HId3Xez9bpu4X3j4q3Zrx9BNzizw==
X-Received: by 2002:a2e:8192:0:b0:2e0:3132:94d4 with SMTP id 38308e7fff4ca-2e95b1cc78amr32452581fa.16.1716655449136;
        Sat, 25 May 2024 09:44:09 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2e95bcc45b1sm7784051fa.23.2024.05.25.09.44.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 May 2024 09:44:08 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2e724bc46c4so75255991fa.2
        for <linux-kernel@vger.kernel.org>; Sat, 25 May 2024 09:44:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXvu9lBy2OHz6ODHOaxBGVh6GNy0ZkBQq8OIBRoa87W5bB+soN/lzxTPc5UNPKYYJxkPAZlpZFjLLapmLj8thtcuusAnqAPvO9RQP4K
X-Received: by 2002:a05:6512:1112:b0:520:98ff:5554 with SMTP id
 2adb3069b0e04-5296547aa0amr4212947e87.30.1716655448041; Sat, 25 May 2024
 09:44:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240525152927.665498-1-irogers@google.com>
In-Reply-To: <20240525152927.665498-1-irogers@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 25 May 2024 09:43:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgYxi_+Q1OpZKg2F9=eem7VQjYnoqN6sA1+uUt-0JqQKQ@mail.gmail.com>
Message-ID: <CAHk-=wgYxi_+Q1OpZKg2F9=eem7VQjYnoqN6sA1+uUt-0JqQKQ@mail.gmail.com>
Subject: Re: [PATCH v1] perf evlist: Force adding default events only to core PMUs
To: Ian Rogers <irogers@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Kan Liang <kan.liang@linux.intel.com>, 
	James Clark <james.clark@arm.com>, Dominique Martinet <asmadeus@codewreck.org>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 25 May 2024 at 08:30, Ian Rogers <irogers@google.com> wrote:
>
> PMUs other than core PMUs may have a 'cycles' event. Default opening a
> non-core cycles event with perf record can lead to perf_event_open
> failure. Avoid this by only opening the default 'cycles' event on core
> PMUs.
>
> Closes: https://lore.kernel.org/lkml/CAHk-=wiWvtFyedDNpoV7a8Fq_FpbB+F5KmWK2xPY3QoYseOf_A@mail.gmail.com/
> Fixes: 617824a7f0f7 ("perf parse-events: Prefer sysfs/JSON hardware events over legacy")
> Signed-off-by: Ian Rogers <irogers@google.com>

This makes 'perf record' work for me again.

   Tested-by: Linus Torvalds <torvalds@linux-foundation.org>

Thanks,

             Linus

