Return-Path: <linux-kernel+bounces-278661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B4594B346
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Aug 2024 00:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DCEC1F223F7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Aug 2024 22:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99568155391;
	Wed,  7 Aug 2024 22:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="N7XxakYC"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74620155336
	for <linux-kernel@vger.kernel.org>; Wed,  7 Aug 2024 22:54:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723071268; cv=none; b=BpR4gpny4tJNH72Pjh9Jrj1CMa8wNLd8buxqXll6+aOygfvKaG5niGNZGvIf8t7SE3/mwoae14wNxm/0DKGgEELdik5JxnYlTwn+KCWRc90W7sz32ur8lXdaG+s3i5naAxYN4pa1+KgDSYmpzc0AOda3gyDi7X4ZvxBN49VkZQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723071268; c=relaxed/simple;
	bh=iVhqZMxyLgHyzy7WW9IsydtqISExeKW639+NCch2hLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jH+2Hf8LnDZoDRe6lggWEqhkrO2HBG2TP1fQC+pizSS98ZsVh3Sxz4+dadCQajhNz9gRavRAPi/rj2JN2H36rTyBE3FsA9hCON78nYLwG0z5FrEyVeW7AcC5rHoABve3VB5jb1YlD3CiWImHyN+fAK+Lv6USrL7UQb+Up3BMUm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=N7XxakYC; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-690af536546so3714667b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 15:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1723071265; x=1723676065; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZZVqFjCe1vKsHofLvXgBCHjHG1J2u3TVLPJgwGDIxqc=;
        b=N7XxakYCfzQ2LdUhkPzNc/rOkqqYoZ04lYmsoy8kRN3HXeglSf2dG5hRskoiRwNBpq
         KXA4kIkgQ0zwVCZq5smJZfHZH5Wc55MTnKVZxD1gGcwrVWTnkVh7TfurYc4j4z/bfuBF
         Q/jEGL3/ZCTLZLdLlp40uRCyxXeYof3fIcGPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723071265; x=1723676065;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZZVqFjCe1vKsHofLvXgBCHjHG1J2u3TVLPJgwGDIxqc=;
        b=cEruyhAStW0cqzZ3+TRdamHtnOMXxiYyNi7E0VVd834U3kRZdPrefvM5DRRJK2AY9V
         kX62/MHuQLsDfd0l/FM0Gmi9ZX7yUGUqP4BZL/niKejzSz+B90hGwsjF7V2YvCivRjkc
         1O68BLX/PVlHF5dQuWHkjQkyhRT6Nj4J7+uXZP9yIF0lTdagUVNw9YmL0pohimAyvxzV
         UMJuhwiC5deQBdRDXcCU7kt16w4RwKnbJm3DYZP4EuLmIRGmw7wi8/piHZmTQqL/6zsF
         obkn+aj+f2HC2GsCjt8BrRvYCGJEyYfcfizk/AO/1/pNCZUZ9rVU7jCQQ1o5jW2M6Clq
         EoMw==
X-Forwarded-Encrypted: i=1; AJvYcCXVJ7v+f0rMa3XcST5FsZDbQm7uFW3E/XPNVGNShkoQFfMKRRiFRgWB8UuD1iknCWTWBcqqd8iyON4TXcW97+zXZte4C3ydBjbqQQbN
X-Gm-Message-State: AOJu0YwSv5l4XLfULkbd2wE8z0yEec5Sb3YhPrvhLt4jeQMN7JcledVj
	ukHs1KNUAJfnth9UpCipBQdn1m9bV8DfoVILFaq+hZoYA+HgrV5O/+kqrO8EB1JvDsR3TLkmiEA
	4RQ==
X-Google-Smtp-Source: AGHT+IGgE6MlzWrjUQiVGyJRFPrzkV+Z3nLxc/4CJb7giXDQEgH2+9kxFNk+uiALI8LNQ7rM72IKqA==
X-Received: by 2002:a0d:c306:0:b0:64b:630f:9f85 with SMTP id 00721157ae682-6895f9e81b9mr222869347b3.12.1723071265496;
        Wed, 07 Aug 2024 15:54:25 -0700 (PDT)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com. [209.85.160.177])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a3786e3cdfsm99699585a.128.2024.08.07.15.54.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 15:54:24 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-4518d9fa2f4so140641cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Aug 2024 15:54:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWBBKhK4ran8JivTuz92B8WEMskFKyUBI6T9HallDOfhFanOCt9qnTpVWHHuEgNfoVKPARfC6BcfOjckgLBvDFFdQMf9WGNplwVI4xP
X-Received: by 2002:a05:622a:653:b0:447:e423:a463 with SMTP id
 d75a77b69052e-451d37ab35amr561411cf.3.1723071264198; Wed, 07 Aug 2024
 15:54:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806135949.468636-1-tejasvipin76@gmail.com> <20240806135949.468636-3-tejasvipin76@gmail.com>
In-Reply-To: <20240806135949.468636-3-tejasvipin76@gmail.com>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 7 Aug 2024 15:54:12 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VDUGEZTPuPvEy-jBjW-e7EcS9_GDLwv3QbS0QVR0uhZA@mail.gmail.com>
Message-ID: <CAD=FV=VDUGEZTPuPvEy-jBjW-e7EcS9_GDLwv3QbS0QVR0uhZA@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] drm/panel: startek-kd070fhfid015: transition to
 mipi_dsi wrapped functions
To: Tejas Vipin <tejasvipin76@gmail.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de, 
	neil.armstrong@linaro.org, quic_jesszhan@quicinc.com, airlied@gmail.com, 
	daniel@ffwll.ch, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Aug 6, 2024 at 7:00=E2=80=AFAM Tejas Vipin <tejasvipin76@gmail.com>=
 wrote:
>
> Use multi style wrapped functions for mipi_dsi in the
> startek-kd070fhfid015 panel.
>
> Signed-off-by: Tejas Vipin <tejasvipin76@gmail.com>
> ---
>  .../drm/panel/panel-startek-kd070fhfid015.c   | 115 ++++++------------
>  1 file changed, 35 insertions(+), 80 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

If nobody else has any comments, I'll plan to apply this midway
through next week.

