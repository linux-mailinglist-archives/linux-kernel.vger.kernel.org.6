Return-Path: <linux-kernel+bounces-198428-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 703DA8D7821
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 22:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0829F1F21046
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jun 2024 20:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8F3770F1;
	Sun,  2 Jun 2024 20:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BEzEsfKq"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 471331F60A
	for <linux-kernel@vger.kernel.org>; Sun,  2 Jun 2024 20:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717360669; cv=none; b=Tv1SZyWT5HvFttqky2UXGrq3uWen06RhcKB/oPEBV+N1bqlVJSTzKBtb+y/kI/EqrnI5RoxLhpnD9mqNnHPqaoh9s85VOchXR2xyW8ZDUHNbJZ1/kt+u1cAlCbm9CndZ8iIZi+bdCdsMmfYSl6gZ07YrAkjRKLHdYzQxQZJAt0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717360669; c=relaxed/simple;
	bh=FqEJ/1qCtEHp4QwWgutZI6jDkZHGfucAq7uG6a9ReMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fcp/Hef5AxSJ9QhbpCiquJss34n8crVFAen8RZ8RuoA/1rXW2clJaFQtbWsNKALOEfui4DpFy/LuFnYIlqzUvaj1f6tRLyNpTUFiHD9f48fnylKP52ib5lVjWOMxvCzZvjMpCtH40QBnb5OYTY7rdjupwE93FZBsFn+25JFIwXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BEzEsfKq; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2e95a7545bdso37712201fa.2
        for <linux-kernel@vger.kernel.org>; Sun, 02 Jun 2024 13:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1717360666; x=1717965466; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FqEJ/1qCtEHp4QwWgutZI6jDkZHGfucAq7uG6a9ReMk=;
        b=BEzEsfKq8eNs/+x8BlHE8rQ3cQC6GM8thYLE4wd1yfhwAdU6OTdd2WdctRKa+veCAc
         pg0KBNI7xqc+nt8bBPeblQkJHbpIcXFefCeTQ91t8xrgpEDxyiY3iWVac9Vd1qffKLzh
         5ktxial+GGvw70XivvyleyS8IGfogqcAEkGR7Hr7t++sIQga/8x8u4PKAJTQZ6P8zFQ1
         ZdUj3qDVAygUkf3+bn7tpJvWr4u9mYwt04CLWfrE+DCFgvf3NY2DWOVJgXfNBS1hKeJI
         JK0FCtKuZbShJ8edZoBJOMyhnTpMh/t34brsrU5wuXCygPMZIVQrimfu9Tbx4ex11x2U
         BYuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717360666; x=1717965466;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FqEJ/1qCtEHp4QwWgutZI6jDkZHGfucAq7uG6a9ReMk=;
        b=jlgIoTlrEFFz4YtvLi/dAVMbZl3FeYxE7q17LWeONlTabhD454p11tAiOBaSlpXSMr
         EquffdsWGdUWlA4smnR9+GvsTZnT5EHzpvnQ9tH6O6LwjQWCOZVNBKqGj4Qe4JKlJUOH
         tsmuk/ogTmer3hAast0jjPelBn252J+JfQU2Tvm8B0UVfWtToO4DAMttBr1n01DSKGs1
         Pr349jyI37SsynULfGPuzmw19vLIhi6c9IsehdL81XB9G9CyaWSZy0H/eCpqIS4UtU85
         LTpl79xD/g+zdYOGL/xtudopks/zi3SznUzeUmACFfRIKcVQXPzd4rF4RpAlQ2LfWb3I
         wATw==
X-Forwarded-Encrypted: i=1; AJvYcCVES9kggcEKbMj+eUz+oRSIMTcvIWMYPdBDfuV9k71smTPGspMW/6q6wDNy0Q4GmjzE3DTr9xI9dcYHz+Zup8nXCHmNaGARnDrvHJ7c
X-Gm-Message-State: AOJu0YxYVWZufSRBlO6TQ/lwt5IgaaC5VKc8q/s4FNSb4hcSllC1sCB5
	Qayibaiuk/ayiFrtzb1Xoimtik1zmErh2Wpr/HZI7c5xcYWutOH4LtOU8YTKFlHF2YeYBi4Aiy6
	Kqcna
X-Google-Smtp-Source: AGHT+IEjNe84eQj1gn88SfF3BFLZAgu80JypGnsuOUMGs7rx88Xac3FjV8Xp7A/45iVIt6uwtTP8sQ==
X-Received: by 2002:a2e:a99b:0:b0:2e0:37be:b70f with SMTP id 38308e7fff4ca-2ea95160333mr54516941fa.26.1717360666210;
        Sun, 02 Jun 2024 13:37:46 -0700 (PDT)
Received: from google.com ([2a00:79e0:18:10:138e:9906:1038:1841])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-2eaa8ca91a8sm3593471fa.61.2024.06.02.13.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Jun 2024 13:37:43 -0700 (PDT)
Date: Sun, 2 Jun 2024 22:37:38 +0200
From: "Steinar H. Gunderson" <sesse@google.com>
To: Namhyung Kim <namhyung@kernel.org>
Cc: acme@kernel.org, linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org, irogers@google.com,
	Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v7 1/4] perf report: Support LLVM for addr2line()
Message-ID: <ZlzYEp78ihsGeEEi@google.com>
References: <20240526182212.544525-1-sesse@google.com>
 <CAM9d7cgf1ZqGGCHU=g8ksfigWhL-XPL4qJiHzz+EQ6vo5c8DyQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7cgf1ZqGGCHU=g8ksfigWhL-XPL4qJiHzz+EQ6vo5c8DyQ@mail.gmail.com>

On Thu, May 30, 2024 at 09:58:09AM -0700, Namhyung Kim wrote:
> Can you please add something to tests/mask so that
> we can test the build with and without libllvm easily?

I have no idea what this is (it doesn't seem to be a file or directory).
Do you have a pointer where I can get more information?

/* Steinar */

