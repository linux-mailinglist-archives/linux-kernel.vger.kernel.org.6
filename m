Return-Path: <linux-kernel+bounces-235497-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EC9A91D5D2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 03:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC6F1F216B7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jul 2024 01:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7208A882B;
	Mon,  1 Jul 2024 01:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jYSOHuVO"
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5F079C0
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jul 2024 01:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719797857; cv=none; b=l6b5NdhUrOqC+fGfawBZ2hahKu7rjz6E/AGTaAWx2Ve+nQF3j0vBxYMD4B66RoBE0mJRl/46Tf92FSHmAoDJbOhRp8lmvxIpjzjWDrGNDWMqoeqMfHstiaZW5UjArf6aY6qoSC04wGm9uP7vrXl6iNojA6osCyKpSptBqXry+2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719797857; c=relaxed/simple;
	bh=azwbFdwsMUU4k6HYmVyPxOBWH1A6/l1hVBXoZKbQCPo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODdhufMKqdbpyvABDHW0ncgjM1+Hs1nvYsR+QPz/O17jKCEWYo9imcepo2gbOvW7PpVPs9FJBmpED8Sr8xYEDgk45dHihij22R+W08vnkR1bsHw0wBseepHPyeA+iqpbR0Hk1LJVLlQC5drNhzkq0ypXuTKocBdNWUdMBgFd/g4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=jYSOHuVO; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2c80637ee79so1445747a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jun 2024 18:37:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1719797855; x=1720402655; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=azwbFdwsMUU4k6HYmVyPxOBWH1A6/l1hVBXoZKbQCPo=;
        b=jYSOHuVOEbcmr+JhGtF0xpmlEzV4AKnbM8qnBZXevF5t6Wd9BFjmv9tEpnNMB+ebnV
         vor7fUNcXA5l68zv9lBc50kSQcCo50JHTSfdf5SDHtBVaQudRCm50iLlWwMaC6+92bod
         8YlQZDr9ZJLVqGoP0YN78wcVg4iZieeCgT5+U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719797855; x=1720402655;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=azwbFdwsMUU4k6HYmVyPxOBWH1A6/l1hVBXoZKbQCPo=;
        b=vN3ysmUe+b5k7saH7glpqAqYegxmXCneDigI/jCseD44xNUFRaODqQDRE8a7v1BRO4
         t2ryr7yJf8kjDBxvgUai/NOv6w6Yq4WVQQmeIbLa2+7eWcIXgBg0rWbClCjWc5OF1Clf
         s2OlnloeyIX+SoJEx5VDlPu2eNkj5hBHB5rwfYnFnbBuyj98qYNDF+TDO7TgK1aNtZkm
         JwNlOXW52zRImppV0BIvfKoCbY9h3ZwDB32RHzXHByVsZ4tyULKWX9X9NU0MzT0DktrI
         Wa9HhH95EN/+zQLptlDDdxf2QsFv+u1Rs2M54g6dh3seU12AieNsAiQC5uDWno0TQJKt
         reCg==
X-Forwarded-Encrypted: i=1; AJvYcCWADFfwZMoPxPilce0kkl0B9c19f6t15gm8NAUa1rhJHE8nAP7tFwbX+Sx+Ax7SCa+0PrINXHJR4u8JsBgzytXqGSJVTTWatKqBHvu0
X-Gm-Message-State: AOJu0YxGAfsepxNWfEEJVkWt+9gWE/7m44FKg5LqMVygZomHAaUNRKUF
	lvbJC1Ydapcg8dv/xk/xiRhMohSCrRGi4E5HerGkDepxnxbIoJe7IhDXu39V6ResjsoMV421syu
	9Hg==
X-Google-Smtp-Source: AGHT+IED3Z9xukW/wlLLei7aTGWggDhQMuD78NJA+LS/lSNy3ZVDA9IaFofzyP0kk2vOjCsYqPCtaQ==
X-Received: by 2002:a17:90b:3718:b0:2c7:146e:a207 with SMTP id 98e67ed59e1d1-2c93d751c4fmr1646834a91.22.1719797855627;
        Sun, 30 Jun 2024 18:37:35 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:132b:a86a:a9d0:d7fd])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c91d3bf20dsm5445367a91.39.2024.06.30.18.37.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jun 2024 18:37:35 -0700 (PDT)
Date: Mon, 1 Jul 2024 10:37:31 +0900
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: Chengming Zhou <chengming.zhou@linux.dev>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	akpm@linux-foundation.org, minchan@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mm/zsmalloc: fix class per-fullness zspage counts
Message-ID: <20240701013731.GA3232210@google.com>
References: <20240627075959.611783-1-chengming.zhou@linux.dev>
 <20240628005523.GC15925@google.com>
 <20240628010812.GD15925@google.com>
 <caf4b05d-6adf-4976-9961-fa30d3a9969c@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <caf4b05d-6adf-4976-9961-fa30d3a9969c@linux.dev>

On (24/06/28 11:19), Chengming Zhou wrote:
> Andrew, could you please help to change the subject as Sergey asked?
> Sorry, I should have noted these details in the changelog when I wrote
> this subject.

Chengming, can I ask you to resend these patches with a proper commit
message?

