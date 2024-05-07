Return-Path: <linux-kernel+bounces-171890-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A8D8BEA05
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 19:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278C21F21D60
	for <lists+linux-kernel@lfdr.de>; Tue,  7 May 2024 17:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A920548FE;
	Tue,  7 May 2024 17:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="NP1Jd2E4"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8F1B672
	for <linux-kernel@vger.kernel.org>; Tue,  7 May 2024 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715101499; cv=none; b=VOt3RSC1M3X1g05bVaXw3NDgCubx+/FcRPysfpfmkcE35+UXfVVcixLvJ+tv9wzjE+R6QD3zgOp2S580cbAqhmy7bqsV4vGBjnqZM5ZcxN9z4lalYUlToMU9cRj/SRmRzaoyQ7BrF6DgdH/Zy38ZLD/6tgpWcweU+CVG+22XY6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715101499; c=relaxed/simple;
	bh=UZKao+sUmzHhKthGvkHfgeitNibMH3RZ6Xh64koB+Lw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dGk3E37uPy9hibjKhjHKeQjX0d4F+r2D08X7Ac1WaQD/aCXZjOP9q4PFMJD3JugR29y6NyRbiKBPeZqY9EtcwWg2rz7LgfwWTwnP3VsQmx3/tgpuQG2QBVgCw6FaP9zt8vEK+h+YNLyiA5X5+5Vk1PmIZ074Hwk7xM2QijOjbmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=NP1Jd2E4; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2b4a7671abaso2277653a91.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 May 2024 10:04:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1715101498; x=1715706298; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1VvOdta0CTNgaMD1FjE1RDD1M1Oa41gzPaIknnALqmo=;
        b=NP1Jd2E4RmBIJlrelGZ/+76ImElVUG9DMF4wvsPa44lLlWeKXFAG9mcMYCoGvODY6V
         m5PwkefrpLYqCjXzZu5sF60KYaQjXPy0HfaT1C0PS67PEeX07+KP4QbpiSZFWciSwb4q
         q3WRp77Kh2zijIaM3/9r/gJcKTGjaCY6wc0kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715101498; x=1715706298;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1VvOdta0CTNgaMD1FjE1RDD1M1Oa41gzPaIknnALqmo=;
        b=OaHMPjcsJRuLdXJM/cyUB22ghBN440fKFm/F6zGEnZ5aEs8q/WPji3tFhPE8xbQXbC
         cJb0ufWzzN+dT5EU0urL1YQzGnq9OWBYl2YcrPnUxOsx4eoksTnGaXwaV07goOEKyYdJ
         oUe8+mTFSoGUdluYpIYF+z2PWqC1LrsKuZifyAVXGS/0CVXyxyjnvZYYrqKieJKbrP80
         ata/ETv4p6z4Og+igFy+VU0A70LKrOAqrzy5uCOgKspLpJpiVCaJ1A3MZtPgnNBDmTsC
         0luTz/dOzzMcYbsenmdTC+d6fX70uy6wLkPpVKRevWST5+wOR+yZfh6lOKxx38//VxNq
         mj+w==
X-Forwarded-Encrypted: i=1; AJvYcCWhP52Bwh4OanFzPcwyKHjEibNANU/oUy45jdl64up7m7CV+y91EWOPcPeoOKtFojKNi/4x5b5NZEnUMfOdx3JszVcEtDhG2yO+clCn
X-Gm-Message-State: AOJu0Ywn09aEks2L+2QlAsLm8qW/4dHZRSaK9yLWXZl6wjZgINYB+lcR
	WXD4g4LUQXM+f9TV0AT7KhbpiSkGc4FkecKQWNjW2l5wTDZOARpFkaRx5vuJCg==
X-Google-Smtp-Source: AGHT+IF6VIPpzWidq8Xhn8vQ5vy8+tHIstOIQn9hSeNKvmfkqoOMJtcT7bQA79cHqdnrlPj9ICle8g==
X-Received: by 2002:a17:90b:1889:b0:2b1:74ad:e252 with SMTP id 98e67ed59e1d1-2b6166c9f85mr157870a91.28.1715101496921;
        Tue, 07 May 2024 10:04:56 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id sj16-20020a17090b2d9000b002b27eb61901sm11927831pjb.21.2024.05.07.10.04.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 10:04:56 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: linux-fsdevel@vger.kernel.org,
	Allen Pais <apais@linux.microsoft.com>
Cc: Kees Cook <keescook@chromium.org>,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	viro@zeniv.linux.org.uk,
	brauner@kernel.org,
	jack@suse.cz,
	ebiederm@xmission.com,
	mcgrof@kernel.org,
	j.granados@samsung.com,
	allen.lkml@gmail.com
Subject: Re: [PATCH v4] fs/coredump: Enable dynamic configuration of max file note size
Date: Tue,  7 May 2024 10:02:53 -0700
Message-Id: <171510137055.3977159.13112533071742599257.b4-ty@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240506193700.7884-1-apais@linux.microsoft.com>
References: <20240506193700.7884-1-apais@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

On Mon, 06 May 2024 19:37:00 +0000, Allen Pais wrote:
> Introduce the capability to dynamically configure the maximum file
> note size for ELF core dumps via sysctl.
> 
> Why is this being done?
> We have observed that during a crash when there are more than 65k mmaps
> in memory, the existing fixed limit on the size of the ELF notes section
> becomes a bottleneck. The notes section quickly reaches its capacity,
> leading to incomplete memory segment information in the resulting coredump.
> This truncation compromises the utility of the coredumps, as crucial
> information about the memory state at the time of the crash might be
> omitted.
> 
> [...]

I adjusted file names, but put it in -next. I had given some confusing
feedback on v3, but I didn't realize until later; apologies for that! The
end result is the sysctl is named kernel.core_file_note_size_limit and
the internal const min/max variables have the _min and _max suffixes.

Applied to for-next/execve, thanks!

[1/1] fs/coredump: Enable dynamic configuration of max file note size
      https://git.kernel.org/kees/c/81e238b1299e

Take care,

-- 
Kees Cook


