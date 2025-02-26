Return-Path: <linux-kernel+bounces-534018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72840A4618A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 15:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02EDC188E06D
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2025 14:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E42C32206B2;
	Wed, 26 Feb 2025 13:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b="ZuyzHR4F"
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCEF94A1C
	for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740578369; cv=none; b=C00HKhmDO10IPztgDf1EzC0yN7XL78KNar1PRyJcizoW+a0IgLJPk2UGecrEc4HPsbc8zi6BwS9k9GjmGGM9HlP7lXmV4J+/kTcBCQswIxlzTRpmv0yD4I1jA553qUI0OdIYdohFFrF5kfdtd61ZwnITPuNMOcra2XQiFkxBnxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740578369; c=relaxed/simple;
	bh=FaNJbP28GrwA0xqX71qpviLKU4s/iLv9ygoXh3IRVjc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AZRMuWP5ObIwcanJM1adnc6AiILxeaMtApGR8hsHu8As6tS9x8Q14D+7iOrQlalo0AImOfd9bBA3KxB52yp9b74uuivp6hq2A7UbhemraeOHLOTe4NQzTSwse4jsU/zB7OkfXhIJQudwEY+orwDXUadBAaaLju0GgcWPB9h8c9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org; spf=pass smtp.mailfrom=fooishbar.org; dkim=pass (2048-bit key) header.d=fooishbar.org header.i=@fooishbar.org header.b=ZuyzHR4F; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fooishbar.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fooishbar.org
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c0892e4b19so803976785a.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2025 05:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fooishbar.org; s=google; t=1740578366; x=1741183166; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=QnxH9uSAX9kLW2aHAnB9zwl34wSWVlyTXJAkrl1jEgk=;
        b=ZuyzHR4F9nTkh0hJEqM5eDJYvG5YjFNxFPRCN0gROJHzrlLUQwPk6cMV8WNy9pR7Xz
         T80WwPsdG/7xy+/ypqUJ1KzQQle/di6TYQ6jp9t3GQlDys7j47zR03cAQTTDXRWQ8SPc
         W0Eg+K117v+9Do+4SpnI5sAozVeK/e6L2qQsThnjJR/VzCe7fROxPBKOAfHVNDP7uO18
         ph13zmY8RrqO9pmxy2JNDRY889QU/NOjL+/0wOaTdwmQ5tVYvtEgPESZt8F/+LmSyzwA
         HFM8BZHnIkg5gS08N7N1+bfvkv1IEtp28krep4w5+SfcGnok3/+iF9ETy/coen8D6d4Y
         OTEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740578366; x=1741183166;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QnxH9uSAX9kLW2aHAnB9zwl34wSWVlyTXJAkrl1jEgk=;
        b=MhFx0+oVLQt3I5nFwEY5TOqqdd+WMG9ZNaj2Hz+AenZL4fXllh+ywJPrkKjE4tThQI
         yiCx1wtnNyOM4YaFQWMfOt1ZHxm04BJfMHSTVwj8SKBWA4Fhk/J16Xk9wBj6AKhSC6N+
         EMKo+d68Sj1upHxQy+V6PIhswbWn6ylNdh6kefPbC1FwEmfyHnHdLvL+wkOedeR2Am8O
         oNMfNdHVJ7YrxSCan9rc0yMjMeL+ujSCbSeDdEN5XkVcSD6SgVdGmKeDsJ1e2qmde8nt
         XC2qUdspaJfTmcmcjpBrI0V43Hb5YbRIGiLc9PoPjwihi7BgUZnFeD6laptkrybLPyhU
         5QTw==
X-Forwarded-Encrypted: i=1; AJvYcCUY7/VIgCw5/Id2Z8m5pVYC+rW9ChAkjWL4kOOia60IjBnZcMgE5OvXHldwCAm+fW83UJzCqrIWDWTcOC4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+Fk3aTFORtltL17n9OLPM/0n0SHGPOuqJdlsWzR/FIdl5CoN+
	jfUPxZYAAs3n2GFxY0TmEe+uytct05DcK1GQvIU30svPi7Y4gvQ9ex9c078oTVZel9JF56rN2WS
	/T/90rX9C+RgLD6FyaMkzRroz2cQpPwxuqhvvbw==
X-Gm-Gg: ASbGncs1YydEcO8tWvObRbssSokIsVGN++Q1Oij7cKLUVLaIieB6rr7PhNY2Sqk9kCk
	e2oj+o3D1PtffqNT+CWE67SrZAyi+vj60v9CLz+75c7sMH9U7QC08r8ZtNT9piT5NUC6wtLgfoD
	splVyV
X-Google-Smtp-Source: AGHT+IH3LH2E7qdLqaSbVmbd0vwQgYzSLFH3zYoBT6JZblmu5a/hbpYOUjW39/0dbNVn1kAPYr4FC5G28TPPww11BC4=
X-Received: by 2002:a05:620a:2453:b0:7c0:7aab:9b43 with SMTP id
 af79cd13be357-7c247fcb787mr576156185a.40.1740578366648; Wed, 26 Feb 2025
 05:59:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250226135415.363605-1-vignesh.raman@collabora.com>
In-Reply-To: <20250226135415.363605-1-vignesh.raman@collabora.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 26 Feb 2025 13:59:15 +0000
X-Gm-Features: AWEUYZmmxdS5ypGHcyPPeldS7LVaWK9H32Imx1ThxzBXN-bcd6PFnzxtamWHxx8
Message-ID: <CAPj87rNAaPUEmk1edcuHX1+bMWysF=aOMceUsCxnk2SMJUjqKg@mail.gmail.com>
Subject: Re: [PATCH v1] drm/ci: fix merge request rules
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: dri-devel@lists.freedesktop.org, daniels@collabora.com, 
	helen.fornazier@gmail.com, airlied@gmail.com, simona.vetter@ffwll.ch, 
	robdclark@gmail.com, dmitry.baryshkov@linaro.org, 
	guilherme.gallo@collabora.com, sergi.blanch.torne@collabora.com, 
	valentine.burley@collabora.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Vignesh,

On Wed, 26 Feb 2025 at 13:55, Vignesh Raman <vignesh.raman@collabora.com> wrote:
> Merge request pipelines were only created when changes
> were made to drivers/gpu/drm/ci/, causing MRs that didn't
> touch this path to break. Fix MR pipeline rules to trigger
> jobs for all changes.

Thanks a lot for fixing this up!

>      # Build everything after someone bypassed the CI
>      - if: *is-direct-push
>        when: on_success

Should these be when: manual? I think it would be good to align with
the rules we have for Mesa: run automatically for marge-bot and also
for scheduled pipelines, but in all other cases (MR context but not
scheduled for merge, direct push to ref, etc) be manual, so we don't
overwhelm the CI by testing everything everyone pushed.

Cheers,
Daniel

