Return-Path: <linux-kernel+bounces-346902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6134298CAAA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 03:22:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 182561F263AE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Oct 2024 01:22:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63967539A;
	Wed,  2 Oct 2024 01:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHIQm+JT"
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C7E5227
	for <linux-kernel@vger.kernel.org>; Wed,  2 Oct 2024 01:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727832139; cv=none; b=olJN1Q4kmnvPimuXWJQ+jMWmA7f29JlEjfi5OonHO+BY/AVk6iV1EZb8Wde+9w+G3srLNbBebQjvqpEPsOXZTYTSuBCd5LRWyNCgvZtizjIhpIdWfvKhgplwUf/w1tErHgwv7/ykBSlKNp5tb8OQGN4gTdyYSbnFh/JgNz6S2KQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727832139; c=relaxed/simple;
	bh=KYqWl+FFmKQibOM8ltIE7IXlTri05QWbvxFUJPmaqXc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNIW70+u3wYUXZhNQeGwH2byZ0t9xxP7zs1evNXGUOFIh2bj3cKcVg6kn1SUn53964ZcbXEhFzUXmN+jKPcoLl4UT97cQwrmkAOwBwAJGtVEeXzWGyPvARUaA3j/6uhNuR8gAs43Pj2R9hsZtixmqgtaVN5+VKj23LCvTrYITfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHIQm+JT; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-6cb22e9c6dbso33896946d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Oct 2024 18:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727832137; x=1728436937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WEgfQTAvWiZNNH2bdbBGUSilB6Q41IhBtfZzUMoJT3Q=;
        b=NHIQm+JT6ksiWcwDbZx9egu2K7f3/oPAI3NAzNGw1bb44L9vh7FDFUtyNpv3TWSKtA
         ZRsr6Vbenl9d/miekv89u9XJ45NAd8Lnr4gwUDp5a2bP2cvVuXPr4pIkErerinOZmYyW
         ygjB0tMyZWX7iljLgF7zVDlVsieD2joy/W8ioJtXS615qIA4RL7wS+LTN9JCFb11n0RX
         w7Iht+lJGCrtULM/D7n+ocAnkXonu8qtJifQRTy/7UgA098AeWyJ5d5/eps/rCBHME+I
         CUdEDti73THg+kChzG74QxDDcUgSJ0x62E+Q2tjiIX+FkxNIDsK04lH1d4QQE9SQO/wu
         RtQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727832137; x=1728436937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WEgfQTAvWiZNNH2bdbBGUSilB6Q41IhBtfZzUMoJT3Q=;
        b=fJzMiw0b0MDkpQfEpewMfZLRUKxLe+Hlc97a9okjRNausaC2KkyltSTAbz+FHGqSs6
         7TnV3A0+2jH+GQfk6nHiyJIPVwozyOE5nT4+JBmtVcIOwi6v+4jF/ZWlhwBOxeGyeFpl
         VDWH/jHiNxX/s/rdHehaD7NzpratxNClaS7SDe68b8m/zZLi3GffyknmHZi7P01dOzpc
         tJGmb7i/fsNYVo8U0b2jVdzDzTuO95Bb1TDY9bjFhc9CRDVqmH0u2b/VdqgMbfmqc52E
         ow+2/5K4FrWuIVlp3BSQ4jfZETcwj+iWTlX0uM7abB7jeHTsQlTwQgFLy3Te39SeBCAE
         DVhA==
X-Forwarded-Encrypted: i=1; AJvYcCV7hWJmUlyHF80zp4qu09M3YBd+yw7eaafmc3W/qgeCdyX1UhgnGLlKrIA/Bn1in3NT9/EQLvKL/IkwzaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhdsregzEoTALcOvLrPaTBVh18KpQs5hDdGHuGH+Ad83w5WXQu
	l01k6ah0DlkR1ZW5BvCXkz/+knI4geQ6FDrP1lsjukYA8kmKR/tFgqO1ehMUUiONLCP26TOBjUg
	XpBnsHysjnM88qEKqycWmD83yn8U=
X-Google-Smtp-Source: AGHT+IHaT6F4XSRHM0bsSPfVlqLdbuxEw9HjkTZyLvwaw3t4mfb7XI4EVUHMQj5rp9SwG1mRsfAXT3OWN8ywHdBPZhw=
X-Received: by 2002:a05:6214:468c:b0:6cb:7c7d:b32 with SMTP id
 6a1803df08f44-6cb819b2cb0mr15826736d6.4.1727832137283; Tue, 01 Oct 2024
 18:22:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241002012042.2753174-1-nphamcs@gmail.com>
In-Reply-To: <20241002012042.2753174-1-nphamcs@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 1 Oct 2024 18:22:06 -0700
Message-ID: <CAKEwX=Of2U7x+KHikU5p94=qL5VeO_JfysEWKz+=VR3jyq0B5Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/1] remove SWAP_MAP_SHMEM
To: akpm@linux-foundation.org
Cc: hannes@cmpxchg.org, yosryahmed@google.com, hughd@google.com, 
	shakeel.butt@linux.dev, ryan.roberts@arm.com, ying.huang@intel.com, 
	chrisl@kernel.org, david@redhat.com, kasong@tencent.com, willy@infradead.org, 
	viro@zeniv.linux.org.uk, baohua@kernel.org, chengming.zhou@linux.dev, 
	v-songbaohua@oppo.com, linux-mm@kvack.org, kernel-team@meta.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 1, 2024 at 6:20=E2=80=AFPM Nhat Pham <nphamcs@gmail.com> wrote:
>
> Changelog:
> v2:
>         * Fix a WARN in the shmem THP swap path. Thanks Baolin, Yosry, an=
d Barry
>         for the report and the discussion on how to solve it.

Hi Baolin, could you run your stress program again on this version?
FWIW, I was able to trigger 64kb mTHP swap in shmem + no-fallback
swapout, so I think the issue is fixed.

