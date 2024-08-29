Return-Path: <linux-kernel+bounces-307838-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1479653A5
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2024 01:48:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06D7D1F2347A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 23:48:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9E2018E37F;
	Thu, 29 Aug 2024 23:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhGj6gmV"
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB33718A938
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 23:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724975292; cv=none; b=oS6O+d/wt0+suCnbjZUXP45jNEkJ3XYLlvl/FcQWpuRrEew8/AK6wWo2BN0m97SRm8i8uAOlyinnULvGJfG29WkJD1+75+q/oNpl34BAsH2Rutn9DUNwcfUQnie6qjN8Y9x5kpgINaMiuO2dwolDKpJR1Z/Os5NAmXPiq/nKZRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724975292; c=relaxed/simple;
	bh=eLvYpEG6GNXmOzzChknC6/si4FAZR2H5aVbHqXIsWSg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pg9cbIAkfRpkbbkbyLfn6cEaswGx3TU7Zt98SiwTzz8GO3bT1/AcoFzR8Dtfd6XcXz0y2X/21JU4PcP72ZBJfWPLDpiBPgjODQa0yyc6MFGRESi2h3NP0hIZDcbTuFbTUGxQg6by/yW3qI42BWUWoFM4mBrK2YQTGZZM9tPuw9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhGj6gmV; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-70943b07c2cso814730a34.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 16:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724975289; x=1725580089; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eLvYpEG6GNXmOzzChknC6/si4FAZR2H5aVbHqXIsWSg=;
        b=nhGj6gmVtp4ra34B31mun8xMgjj8Y5LjBvGlywADoiE0gD0FJadscUURE3yKCKDRK6
         Pg//AvcPZZBkhRLNhvoimYRQDvlzqT/0dQIaWvhDJNzPtcXW5jfP9ueMx/wB3mE+mfyQ
         KvXO8oJOK4JLZC+Y/tmtdSsBo/JiAnEpyVolw23+EEyQVhIQjnDzpnhn3P430SZHOA5X
         6uU6q7rvxH01YygSXfMYlmdVi1YeYKxAJzLZ4nLfmj2uBsER7q+7fOinKR8Yke1z2qBv
         22w0kXi/OnGKcnNYglY2dN+uSo6OlLZmiKEqCrpFldj+Bio4ze9DhBFldksNiiRM6ZVK
         v4Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724975289; x=1725580089;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eLvYpEG6GNXmOzzChknC6/si4FAZR2H5aVbHqXIsWSg=;
        b=Jq2RmIg6d9LEpGeMZVVr0XobK/daeHH3yBwSXToFTZZVB7VZCdZe41Wtv+I4Kron8N
         hzJHWtCmWqP6/s1ztD9afvj0/rrS6y9l8tJ4CnUmRBvZ9KJVKFXOabcBF4mzHqV0l8L8
         b+eJMU/2RYRJ+U3aTxvtZDAGKyGe3Lk0mXPasvHNI9jYglgoEFpfubUdY+EBAqv/8l1B
         eMCYHAI1SyMek/9zF92FgCnvSYJ8aC+tVk6LE4CV4o9JgH1rFNdsIWewEl8pTAnLPSQD
         qn8Y/Dp4QL7LNMzC75OOJBdcFAB4EafItQzeUV/jzaxTWdESOZqBqi08jUSp6z00Q1nA
         h9yA==
X-Forwarded-Encrypted: i=1; AJvYcCV/ZGA0eKDLXvGV0+j3WrELWm2wlx/V882iZ2S6JOgQdfq38W3GcPLteU0kCxIyG7AYkqCF+8d4VDNabnQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzalmNq49xQR3yv2ECqj39QxcBREzQwOw/4NBEg5KHUMLMkGyCf
	NRzQOc6ntxjak3zOnkeFUXRpZ2x/hUeU/LZ/62wvdKbliZQ7irs6PA3paqQ4PAK4oUmlOV3LCFE
	dQTDUKQaPYvnBZ3RCVU51HHIbtxY=
X-Google-Smtp-Source: AGHT+IF+YdODbL56Da9qNXhNqpfkxf34HawBaNvvXfu6JfRZRiAdMAx/+phTVya4zswQN3e/AkZ2901bp1sikOWiITc=
X-Received: by 2002:a05:6830:b91:b0:709:3525:eda1 with SMTP id
 46e09a7af769-70f5c466fe5mr4626803a34.21.1724975289549; Thu, 29 Aug 2024
 16:48:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828093516.30228-1-kanchana.p.sridhar@intel.com>
 <CAJD7tkZv3YnhxFo-rvHNB2_mro1+UuKOP69yXV8KmaeEz5F1mA@mail.gmail.com>
 <CAKEwX=O8CfyBHZD6Xm_0DW5EuTY7g7FhKHiKj4xzZ4ozxdgQFA@mail.gmail.com> <CAJD7tkZnT2_JD90xAt09Uk6Lsc6C8t0V5dpUOKLLknw75yUqkA@mail.gmail.com>
In-Reply-To: <CAJD7tkZnT2_JD90xAt09Uk6Lsc6C8t0V5dpUOKLLknw75yUqkA@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 29 Aug 2024 16:47:58 -0700
Message-ID: <CAKEwX=Nak1J30bDmavQZH3SrcmP9hj2X7wYg-eX=k-jb_p+T=g@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] mm: ZSWAP swap-out of mTHP folios
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Kanchana P Sridhar <kanchana.p.sridhar@intel.com>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, hannes@cmpxchg.org, ryan.roberts@arm.com, 
	ying.huang@intel.com, 21cnbao@gmail.com, akpm@linux-foundation.org, 
	nanhai.zou@intel.com, wajdi.k.feghali@intel.com, vinodh.gopal@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 4:39=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> Interesting. If CONFIG_THP_SWAP is enabled this basically means your
> zswap utilization keeps going down as your THP utilization goes up. So
> the swapin cost would go higher. How do you deal with that?

Johannes definitely knows more than me about this, so please fact
check me. But my understanding is we don't get enough THP for this to
become a problem just yet :)

But yes, we're working hard to make THP become more readily available.
Which will lead to the problem you're describing, hence my enthusiasm
in this work :)

