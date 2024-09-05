Return-Path: <linux-kernel+bounces-317746-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A647596E333
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 21:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D2A511C23C3B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Sep 2024 19:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C36F18E032;
	Thu,  5 Sep 2024 19:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xfrsyqYl"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D65718E752
	for <linux-kernel@vger.kernel.org>; Thu,  5 Sep 2024 19:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725564530; cv=none; b=PnMZgh9PxKg/R2YSgebVhXtPF1okfZZELZ45d6db/ir62qEpBbbAKTDlUN9+NhPQQaGcW3QrLMxUwHSA/3eA1oMPB7Vl2y0tK3Fjhwf/FbbI5OiZMZXUAZ113XoJa/BDmLzx24VY1RzkIbNGmMNs+OQ09wT17k8p0mBTU+joJl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725564530; c=relaxed/simple;
	bh=4Eu+XLjic9C29qTQf+ZtTQs+qnjV8IineOxN2pgIxzE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LE1mrPBogJgMyl60Z+orjNdj7/JQ1UuafFUAQ6gs8lH8YOxrUFX5jkPbVmHbwqC2fIuqjYk8W+rqHgSPaxXTJ6rp02nNMV2SqBnCGQNQ5GFjBa8e0D0sKrSlH/qWLyqPvwbKZmtTndJbmH/ld9zp8tMK47tEqL6HPxR3rnCIHzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xfrsyqYl; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a83597ce5beso201693866b.1
        for <linux-kernel@vger.kernel.org>; Thu, 05 Sep 2024 12:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725564527; x=1726169327; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5KLmKjwBlcsqYy7uwv8s+snyzzCreAuqR4mvIYss8N4=;
        b=xfrsyqYlZiSiDSBETWhLS13TfzDjpSTyeP2vQiYlX82+lMfVltaby7DNpTK2Nb4Urc
         YK8BISUhHNzhJM7LjPylUo4qqYw39Ox8kFsYOCijjYQvYAKebooX1Xt+0w7woFDbY0v6
         JN9QeuLfXphDdWvQLLdMJ4754IYPiBDx4K0p0fwOpECApE7KfmzS3XpR1S7N7S6FfHBK
         KtS5jsgh0Sh6yPe04cOxD+pycAIs2kvIeYU7nhHIT/9C6y87zud6V/VDKlI2Mj7cBH5I
         eYaKcErPKI+GseNVaFbq2Pwh1hcKCRvGRiGLLn4rB9VW/8mpdvH/MwtLhiFxWkFp1wau
         3F7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725564527; x=1726169327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5KLmKjwBlcsqYy7uwv8s+snyzzCreAuqR4mvIYss8N4=;
        b=m88Z0w4HwP4U+qNCPA3JkzRjDigAaME3te5d4NLFsOwaWdw+YlEBGFwklT72zBHzJv
         EIcJoR3vVM/ON11EfZYmp0ZmMrkMfH+Yk+FwBfQY2VHAk+w4zjVFAtjqXNmDzV2IE2wO
         VeNYnTGeujRU5afvsO/08Un6AqTT/SnmgqbyHBQmC1Z/JdY+Jv6e/0QXXS91X2kSXCL7
         MZ3JIO/BZYkjkA+7JJr21DyCUcgv/BKtGQjvFtRKbWpjR6fW59u7GHK81M+sYsoWeenL
         7i0hdErrhGG2+WJoWeF1u/t0VQIwsu7UdD1MfjEjbPf9D84jxFQTqTGCtY7q1/iDvbui
         dZ7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUWZhk7FB63V5UyLoR/ElF3H3gae94UEAqT3wuCfUI5K8iY8vVGnF1kOxHH6i4mpR2MKrBzPKU1DJq3azE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywn8oX3E74jKnmKSgWCHOkFmvl2r3kxwAy77PjIrfIUcizvNNV5
	rViPBraMcknc/4Tv6gpXf9AuyJNHyw/p3uOj47BkJG5DeksLi4gp49OxBZJNkKGaLnzGVw4RlwT
	rZWwNaYjo0tz/fe2lyP3Napc8Ai4Kbq8bSwrj
X-Google-Smtp-Source: AGHT+IExMzKdlKYyXmWF9bvws6Z4vbYhzd+WTREiDX1gnbcal6mcDklJpHfUw3bCSBISZNBsnBsi+GgPB3T7pvpvST4=
X-Received: by 2002:a17:906:4fce:b0:a7d:895b:fd with SMTP id
 a640c23a62f3a-a8a42f8ae77mr631412166b.6.1725564526354; Thu, 05 Sep 2024
 12:28:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240612124750.2220726-2-usamaarif642@gmail.com>
 <20240904055522.2376-1-21cnbao@gmail.com> <CAJD7tkYNn51b3wQbNnJoy8TMVA+r+ookuZzNEEpYWwKiZPVRdg@mail.gmail.com>
 <CAGsJ_4w2k=704mgtQu97y5Qpidc-x+ZBmBXCytkzdcasfAaG0w@mail.gmail.com>
 <CAJD7tkYqk_raVy07cw9cz=RWo=6BpJc0Ax84MkXLRqCjYvYpeA@mail.gmail.com>
 <CAGsJ_4w4woc6st+nPqH7PnhczhQZ7j90wupgX28UrajobqHLnw@mail.gmail.com>
 <CAJD7tkY+wXUwmgZUfVqSXpXL_CxRO-4eKGCPunfJaTDGhNO=Kw@mail.gmail.com>
 <CAGsJ_4zP_tA4z-n=3MTPorNnmANdSJTg4jSx0-atHS1vdd2jmg@mail.gmail.com>
 <CAJD7tkZ7ZhGz5J5O=PEkoyN9WeSjXOLMqnASFc8T3Vpv5uiSRQ@mail.gmail.com>
 <CAGsJ_4x0y+RtghmFifm_pR-=P_t5hNW5qjvw-oF+-T_amuVuzQ@mail.gmail.com>
 <CAGsJ_4zB7za72xL94-1Oc+M2M1RtxftVYUAUk=1yngUoK65stw@mail.gmail.com> <CAGsJ_4yBFpyA4Znfgr7V=eoHAnhuLPDTqaVOre9waTKZ+R3R9A@mail.gmail.com>
In-Reply-To: <CAGsJ_4yBFpyA4Znfgr7V=eoHAnhuLPDTqaVOre9waTKZ+R3R9A@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Thu, 5 Sep 2024 12:28:10 -0700
Message-ID: <CAJD7tkaiRZ0fbPRV31bG6fnHPb2NAj_pixF1yFuyuGzsTA6zog@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] mm: store zero pages to be swapped out in a bitmap
To: Barry Song <21cnbao@gmail.com>
Cc: usamaarif642@gmail.com, akpm@linux-foundation.org, 
	chengming.zhou@linux.dev, david@redhat.com, hannes@cmpxchg.org, 
	hughd@google.com, kernel-team@meta.com, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, nphamcs@gmail.com, shakeel.butt@linux.dev, 
	willy@infradead.org, ying.huang@intel.com, hanchuanhua@oppo.com
Content-Type: text/plain; charset="UTF-8"

[..]
> /*
>  * Check if all entries have consistent zeromap status, return true if
>  * all entries are zeromap or non-zeromap, else return false;
>  */
> static inline bool swap_zeromap_entries_check(swp_entry_t entry, int nr)

Let's also rename this now to swap_zeromap_entries_same(), "check" is
a little vague.

> {
>         struct swap_info_struct *sis = swp_swap_info(entry);
>         unsigned long start = swp_offset(entry);
>         unsigned long end = start + *nr;
>
>         if (find_next_bit(sis->zeromap, end, start) == end)
>                 return true;
>         if (find_next_zero_bit(sis->zeromap, end, start) == end)
>                 return true;
>
>         return false;
> }
>

