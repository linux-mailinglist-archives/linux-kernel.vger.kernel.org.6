Return-Path: <linux-kernel+bounces-233554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2695791B95C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 10:04:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40B711C231AB
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2024 08:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924EB14389B;
	Fri, 28 Jun 2024 08:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="korjE8nw"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929B14436A
	for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 08:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719561875; cv=none; b=rw5Rxrsn7elB+lRP/jYyYTDWge1exLSK7voM/tW9TpVV3W6iW9RZzBbEhKQC+6OJvYuZ2dr7jQjsEW/r1hZWM1JKdzRqT0Ji+DUkel2/59l+CLF007A4UVJ420X4JDynx1zUl/VBDQ3oBIDVP80s5VPL5Jkc155qf8SDjU9bwws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719561875; c=relaxed/simple;
	bh=qRTyb0qwbmxdEWCwT3F1bApEFMrbfFFwqUJe5Ucy6GY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RoS0kMqzQ2NdYZe3eYHauij8K1YSdlYoiBNdxzXwVAxeesx0fsoHxWQMchjgMp7lISKj7j+5zqhEyh4mL7HWuwJ9Xij9I7gs5X6cKh6+TptoPhf6+9EPQ+Cfw+Iwnx2tvGeVczarKPJOYf68sN7mI9kEjrukAyCburX8Zez0wAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=korjE8nw; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2c72becd4fdso232957a91.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2024 01:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1719561874; x=1720166674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1Sgyvv0YJuBT0GMeHDfvUWM7p1X2ARTlWPgT25XarGw=;
        b=korjE8nwcWqyhBz7qIwFXHfGFeDkTsEtw248cSvThwLNT4fb5dyiuuMHyCKzM94Rct
         CMhdHpFsRUjW3VgCFNE6cZ4u+UbdEUq4CvaGeURdFGeMX6SQph2wO1JQ4vl+GjPXfciA
         F8GE+EAwVsUkIrJKW//RNj002FPuoKAtXTANg2+claUZvhEjToYNuEBkAtZ0jGafllm9
         TBGp694HUtJ9snRmqcBXffZZa0Cn0NxH8RRRoIn98YpKuGK0voTDLGDqzcL/uTuWlyH/
         F/wnkDWNk+p1h71bpm52DwYFk/VWlyYpHEg5BMV3q/q29j90CRml4bK/mPnNK7r4hrWx
         weqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719561874; x=1720166674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1Sgyvv0YJuBT0GMeHDfvUWM7p1X2ARTlWPgT25XarGw=;
        b=fabSJCde2wuk37ZHe93cQc2dr0GJeYq38xkE81w3qQSYbmzm+SJEVNo1lGGsxzujbm
         GSHeEwA6ff+XA0BIfkVVWOjMRI8zmGhmE1btgJRZZHXVW68RCsv3MZQFPxeygp2hgoTL
         KLzoiw/bmmP3or+dL0+hKcsR3XMJc5DWRRee+xKg9riqwOzrjvRFyF8K/CqbPTXNN1tA
         c4URh3pCWwPzVydRJwakQyqq75gq630hLhEYmZ52RLsT8ROePuW8yJd13U5wOA6bou1q
         PrWG4RUXYwNhctb310o0xkOYelMl0CmNWsftZ+fxnx8E3kZzx9Q5zwOtJSxBw5DS9RlK
         TkiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCtvbK2jRtsvzg9ToI1AiDky6tNvOIJN+af7m+RFKZOY/g635vBzE413LPGXExMsOmlgejONx7tkUdM9tP5QOWZBONmqIXQuvJd/zk
X-Gm-Message-State: AOJu0YzhYckcMOLFhjvGwmz/J17mLzvUi3fTHxWP5S6JA5ZppWIxBPw8
	x+TQ3zCovhzrzz9W672DzqPqHfI6Z1IHpqr9SziYQOU067ABkrazEZkcTyY32dLN/Xg9UQbxVJ0
	P1DWRR7O7JnHfpen7FHvWopmejV45t4gXArmE2tLNo8nEFiR15p0RiMk=
X-Google-Smtp-Source: AGHT+IGokMxMdrRpAQhGGsHM10XhBXkulH70J71bCFu4c4v+kGQxwEh4ZUgRnoYk3x/XpGOZgDgZlwaIgvcgL6uh1Gg=
X-Received: by 2002:a17:90a:d38b:b0:2c4:dfa6:df00 with SMTP id
 98e67ed59e1d1-2c86127e0eemr12912932a91.8.1719561873523; Fri, 28 Jun 2024
 01:04:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240627145754.27333-1-iii@linux.ibm.com> <20240627145754.27333-3-iii@linux.ibm.com>
In-Reply-To: <20240627145754.27333-3-iii@linux.ibm.com>
From: Alexander Potapenko <glider@google.com>
Date: Fri, 28 Jun 2024 10:03:51 +0200
Message-ID: <CAG_fn=U-HQOtES0bRSRXvrsjW=aHpQeMNzS2ZK+dPgWJxx60bg@mail.gmail.com>
Subject: Re: [PATCH 2/2] kmsan: do not pass NULL pointers as 0
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 27, 2024 at 5:14=E2=80=AFPM Ilya Leoshkevich <iii@linux.ibm.com=
> wrote:
>
> sparse complains about passing NULL pointers as 0.  Fix all instances.

Thanks a lot for fixing this!

> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202406272033.KejtfLkw-lkp@i=
ntel.com/

Rant: I noticed recently that checkpatch.pl aggressively demands
having the Closes: tag follow Reported-by:, even when it is not
strictly necessary per
https://www.kernel.org/doc/html/latest/process/submitting-patches.html#usin=
g-reported-by-tested-by-reviewed-by-suggested-by-and-fixes.

> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Alexander Potapenko <glider@google.com>

