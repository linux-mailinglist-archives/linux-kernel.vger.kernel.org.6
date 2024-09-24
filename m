Return-Path: <linux-kernel+bounces-337587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C484984C19
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 22:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 10E7F1F24655
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Sep 2024 20:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F4113B2A4;
	Tue, 24 Sep 2024 20:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Wo2mLcgm"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878E52E822
	for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 20:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727209213; cv=none; b=tt+ldmHCERjEGNA6qKOmG+6l1bWGwT3w2qnGfrtbea06xdZwLNtTbpzzhiHDyWNwPaKWs77VIkpVTb6JclohvJA2YALE95YGfY8tVTVsynkXzprd+QluAEqXXxDrgxs9lYk26So1dCp4s2kssxhy5wl8IzAMJlgqmNTNTDEvuII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727209213; c=relaxed/simple;
	bh=eVRfD9Nc+wdvqXHB03r1LjIIg3n38nkVigE7i0eQNUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EyQYFCSUsTShSq+7CySL+tAAB1sC9I9cjgSbXtkMNSi5OlTSNv2b4JXwZNP9F7SAoWaaahRfDkU0ivkJXjqkrey/TATzPY7eiDkA7uirjuRCdPFeLIghTnvsrIX8+72s7Bp32QGYf8E7JFe+gQy47kd1xmrWn/qOvA4FkcOqf1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Wo2mLcgm; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a8a7b1c2f2bso984910066b.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 13:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727209209; x=1727814009; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vcV2QbsW4DHXfNd7bvkaZy3F9FDXpyy2GL9yhM5GxRs=;
        b=Wo2mLcgmmIYlcIfpeXEKwNFwAkkiKSlxs7/YDlGmdZJ00+XcOA5KGcdhsty3UAyal6
         nP+2pPYjNX4L1yhnIcLcqqPx13/AqqvVlHVfenU3Fb89tzzPJ0yqhzi1loBqt7PMV3Fw
         lL3mdMuJ1fsagHVESOBjSaSz3hI9DSYgoUU6M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727209209; x=1727814009;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vcV2QbsW4DHXfNd7bvkaZy3F9FDXpyy2GL9yhM5GxRs=;
        b=NJA9Xtef6wzG0rXxl3ESQfNbLa1zkBm0PBfGrYPryT5LYaVXs9zx2eULHFz9pKk/5g
         jRjf3psiVfc0SopFsbevBXuAQBqTrnKmidvBuxR18AzsVIuO3XeQ864NeFUzQMwVcKu2
         jLURPGnF3zNnpZtKvhwXVuUsKQsOI4cmNJe6pLEFhlnXrbXJbFwt1in8QcxOTtfo9FK6
         H4ROFcwGiE78XU56HEemcm88Yd3UWbnTn+EyGi3GnWukQ5LMc4m3UUHtfa9mJEzJsKgI
         oxvvmnKTXYY85JBaN5s6g5GwSfFGOBHtI2a1om6kb91x3luHUenoQavTLqdM9cmDrzti
         +WnA==
X-Forwarded-Encrypted: i=1; AJvYcCWD9WVOx1Yd/LOgXbTSrPhyRpwbmX73beUm3EvTg5j0EExFfIQAR2TcVi5iTsiWOPthIt+6+nO3VqvwbGQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDeBx+uGYzYyJxvTVNVUZndZV4XEIzQVs5H9ylqmPgDEy6Qbsg
	bQiyoBmq30uP3FlQesO+FNtCao/0zWHI3gTTHFR8vPj6kuWTYU8ESGIn75PefJJA6gLxy4eF1Y7
	i0fF0/w==
X-Google-Smtp-Source: AGHT+IHZF9Ju1dKgd0guskR1mBwFszLwusg7leLd/Vlxpler7Dd8e1934DM0lZaJnmK3AA8K3cHpIQ==
X-Received: by 2002:a17:907:98e:b0:a86:82da:2c3c with SMTP id a640c23a62f3a-a93a05f1364mr37169266b.40.1727209209580;
        Tue, 24 Sep 2024 13:20:09 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9392f3429csm127942466b.36.2024.09.24.13.20.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Sep 2024 13:20:08 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a910860e4dcso380300666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 24 Sep 2024 13:20:08 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWdn9LxavX0bZy3C3HQ/7rNJb95sag9E8NZe0rJLImToAWLwPOPQx7KMrgjBQp9/EwoLRaHSbtD4LI4M4E=@vger.kernel.org
X-Received: by 2002:a17:907:e28c:b0:a86:6cb1:4d49 with SMTP id
 a640c23a62f3a-a93a0322a58mr40471266b.13.1727209208367; Tue, 24 Sep 2024
 13:20:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cf329845-48ee-4b25-9b5a-02a6e2b55e5a@linuxfoundation.org>
 <CAHk-=wiLgK+Fbok8cnpAJD6D4_NZzEv0==i7k2XR3-Tvc1Hr=A@mail.gmail.com> <122176aa-4948-4e90-88d7-1fc77f4156e1@linuxfoundation.org>
In-Reply-To: <122176aa-4948-4e90-88d7-1fc77f4156e1@linuxfoundation.org>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 24 Sep 2024 13:19:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjOUhkh0-==6JZaJ4k0Xp=caN88k12DHkNG22Yns+zGDg@mail.gmail.com>
Message-ID: <CAHk-=wjOUhkh0-==6JZaJ4k0Xp=caN88k12DHkNG22Yns+zGDg@mail.gmail.com>
Subject: Re: [GIT PULL] [GIT PULL] cpupower fixes for Linux 6.12-rc1
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, shuah <shuah@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, 
	"John B. Wyatt IV" <jwyatt@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 24 Sept 2024 at 13:18, Shuah Khan <skhan@linuxfoundation.org> wrote:
>
> Is it all good after the lighting up or should it go through
> the normal channels through the pm tree?

It's all good and pushed out.

             Linus

