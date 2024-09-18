Return-Path: <linux-kernel+bounces-332342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 333B297B892
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 09:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B91A5B23E76
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Sep 2024 07:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B16FC16C84B;
	Wed, 18 Sep 2024 07:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PZpKml43"
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41E174068
	for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 07:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726644728; cv=none; b=cRtNldnw7YKR//PKi33Al4MxzHD27t7de6qiyiU3WhBzR5FJ+hnvVgIj2rVaMhq+TRV7mKE9gHFg+7dxcF6Jz3C7tvhbZ4pWK1IlUuS6WxKcDnVPfuYbZT9caohaR+YXi2kZ+vorHywDCvPy1NYwHz5jagDrds7yMdIkOeVpe9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726644728; c=relaxed/simple;
	bh=6ejSUG/roGryaiz0bAqlWn1S5VN2Y7vY5Ml7PKjogGo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZrovCCKBqrWgGXYQGwOw6zRK2xOs7/DZJDMU4W/VBc5D4Ij4zxFAGYk33thmJIyptGHBcb4ddjjO4MaMJcORyF+FHxCAUiAVlusIToK/sV/Zmkc3jrj/fYLldyfKo54Q0PUlBW+KwSAkw19ROMhtXbSxdi3tSMUfkpmK3rdy0Zw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PZpKml43; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-846cdfbb153so1688737241.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Sep 2024 00:32:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726644725; x=1727249525; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bfMM0evzgmGMVrgr4mPC3hbKeNArMpfP94evBcoK+kM=;
        b=PZpKml43X+zaRTErcs3AOnXJNQqTVW+wM0KkACbTqdD6PAbKPw8UuBpF5d3MXkc9wp
         3Weui8DK3dI82aVZnL3/R/B6nB7ahm5ZpbnSGL9ul+jYMW+PE995JpUrDDbXvsCMzDBD
         Yc9W8KGjjYrkSlnvvXE699FFV81q+i0ex8rsfq//lBQPLFtF1ZlPrh+nNa2R8/4i5EoT
         JbXb2NK33ERDPphLPTLXknQbSzOdzueNLMAYKi6JdgqAearyKxyHJx7dfiEIy3npH/0T
         N9tFFSwOEYaWaLK7APU+jifP7Nrx7P0SihXdJPHTNMvWD5RhYnz3fdOVlHP+c5UnSGN5
         YNLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726644725; x=1727249525;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bfMM0evzgmGMVrgr4mPC3hbKeNArMpfP94evBcoK+kM=;
        b=jlbIW6fDB/Drre3A02YsT7EN/5T6k0uTMJr/bUkHXlTiYG8YezNf+L/D6Ysmcz4IVH
         m3KJY3mE5etESQBuJOVRNcqREiI88NkuhZEQ91M5TfvWTBs49skIZSP3F4SCtIceDrgg
         u2oN9aEo1d5QjX4uO/pCNvHO1RtXsKxJkAcEAY/gtPcrV2/L0IBRAiXpNUVOTvKfEBGX
         ZW/nsYx4aD3RIh9GoGm6+a31Q4g5TH19O2QIg/xp2PtKwJyY/b6FI7oPtCLai7sYaGUH
         rTsi5wkzS5oCRaxAaGnCpfwCxXjdgjksgFWqw3yo5b7JnHBFmxBuSjBIACAStuL9BaNN
         7MUw==
X-Forwarded-Encrypted: i=1; AJvYcCXxs1eal6XAVB5dvj+nuPwXhnupDmWrsPbTW8eAcsFH1QWsFyjFhrPVwSpIBE2qymLh/s8qENBj5htjobg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxNiQmajo+rql7Gz7Hyi//2/b2ikFiRk2TbB2IZlpVS6KZ9XEQa
	Rj3o7AZtGOKmbJ8Q/+jOnjM4NRjYHd2HaFvwtxoaLks13utc4K+yepWZccjvgx6emc/pEWH/TKN
	CY8HQpC9RqTXn4cZgomHf+u8mFnZCmwGS
X-Google-Smtp-Source: AGHT+IGCRcnc2PlFvH8xKkbZYgbxx9nzF5mO9R6LJZYHePEvGjbW5Wpm1KxJpM/qMvHgWttk3emFix3YOyGlURI2f3M=
X-Received: by 2002:a05:6102:36d6:b0:49e:928f:7976 with SMTP id
 ada2fe7eead31-49e928f8017mr2780150137.12.1726644725399; Wed, 18 Sep 2024
 00:32:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALjAwxidmwCT5ZwbZRhf9GwshYbzQZ4N8K3B8KGLi5DnRzj8wQ@mail.gmail.com>
 <CADnq5_ODjqwMS8WNbjdMq++YU3XeVtEEn=KnyoWOzdddyyUw0g@mail.gmail.com>
In-Reply-To: <CADnq5_ODjqwMS8WNbjdMq++YU3XeVtEEn=KnyoWOzdddyyUw0g@mail.gmail.com>
From: Sitsofe Wheeler <sitsofe@gmail.com>
Date: Wed, 18 Sep 2024 08:31:39 +0100
Message-ID: <CALjAwxjQDKsOdGs5As7sHa+gn_1SYE_LLQ4wDDvB_9NYCTLG5g@mail.gmail.com>
Subject: Re: Kernel hang when amdgpu driver is loaded on old radeon card
To: Alex Deucher <alexdeucher@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
	=?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui Pan <Xinhui.Pan@amd.com>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi,

On Tue, 17 Sept 2024 at 22:43, Alex Deucher <alexdeucher@gmail.com> wrote:
>
> Do you have secureboot enabled?  If so, perhaps this is relevant:
> https://bugzilla.kernel.org/show_bug.cgi?id=219229

The system is an old HP MicroServer N36L with no UEFI support so
there's no secureboot.

-- 
Sitsofe

