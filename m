Return-Path: <linux-kernel+bounces-325585-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20667975BB9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 22:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 536A51C22337
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Sep 2024 20:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03A921BB69A;
	Wed, 11 Sep 2024 20:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y2Escrqw"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0F24224EF
	for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 20:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726086514; cv=none; b=ac0o/7q1rCRupprAy0b5jWMF54XhjJG8zMNaUsXUIjG5u3jQsewTkPMBYXD1gQW7/O6o73Xq5+Y7kWgDZOc1gTqtsQEux+y863pqUhBTN/qH+SxGQZHWWMqDIIe0BtlGImuWIeRMdC5I62wrw2hhIb5psh0vUVLtdNqcCHOVd/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726086514; c=relaxed/simple;
	bh=P+98uNXJhASPeO6oz6+Y+aXSLMw2bGiScnis8QNZVv8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dG5YzS1IlLmqw9ic0xlOXftBZT5JcmxWSsnihtc2yneguZcMahM3NuFqMKeQ8oE+i6dqXjttHeKOoGcs2cgChUMWFyI5OdMHplrwazuxRTsVEmQiRrY8X+h1PScnGc+R/TgR14+DZWR31abJICM4I9dWZwjK/HyP2tErL8GbHfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y2Escrqw; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a8d4093722bso31734666b.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 Sep 2024 13:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1726086511; x=1726691311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P+98uNXJhASPeO6oz6+Y+aXSLMw2bGiScnis8QNZVv8=;
        b=y2EscrqwpVH3pB/UhU5NfSo/A9OhSB3kz1RpCXA0vfUE8YjNidl7zSeI82XaZowlWY
         yY/YHV/JX//3qPVGkY8h3wUdiPt8BCApYGROFNjEP4KMQO3Za0twr13t20ChIpNolT//
         L+50YqQo+rSe8TnvsHNT7K3e5GFujYl9B6xSR3nKD23gXiJHQIzyJjZkAkB7GfuOj661
         BCM+l6oKJkGkNd+NClm+1IwK/wMb2c6nVcS2Xr/gi+yHYoF9HVoo1JwSUHkzAXoOBpYY
         ISpTW1VHn8lb6GAoBrox01NKv/GCLi6gG1/3vca+c4tZIJdYCOFs6SLGj4s82KWbbj8Z
         6nVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726086511; x=1726691311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P+98uNXJhASPeO6oz6+Y+aXSLMw2bGiScnis8QNZVv8=;
        b=OpGW4Ya2IWYoxBlmfkSjrQ/GZf3uVTTgB7yhtdvjav+nKsYxHQD5/ARuSneyFeognS
         Vly6p2KCrUyuA+W0tD5MiGXSs2C1NJqKX/+EWoxhcxYz86MLeXFKmQhK6UieqUGVmeOe
         KKYwi9IJnjeLeE2Z7K3Za9uEmAPP8VlgEcozjXh8VCb2Kg3noQuw6xPPGLL3ZgCbpDlb
         t633IUJwbMyEJ0paspIM8Aj6NY59qchZKy+OdHrlOAo0Bx9TRhMV7N8qKxOADMIPV1l4
         QEpvJQ/VkKfzAK3CQRcuk6co4fYAQfhtCTSE6DCpqV21mZszqcdyyVx9LsXUOx4RN+82
         Z7rQ==
X-Forwarded-Encrypted: i=1; AJvYcCWnpfgUJEZGgWGIiLL9CC9Mr8TQ9wi/WEpHRu0oBZbycBb8J8QbUhs+dM8GZ3icLLTkms3VjRFnEFhMTgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzhXhKLiScssLrGdPRaYOkawgFU1X61Op4n7/l0wP5NyY+vVHS
	+0nj1fag9EeU3tT+MbW4auQNvYEkuyh/RfRpVHvuiUO24+n7QJbqiDGe19PdUVji8bs3jA+buA7
	7e/AZa+GKOOYfVssHYxjo/wUG6Tpr5bQSPWk=
X-Google-Smtp-Source: AGHT+IE1JTK1sFQHs97L4wT9wvWzmtPa73nwdZf7uQ5sD1TNdIQ8j8nbn+WMup9JYuaytW3c7ndvgccSw+DzEe4DBzw=
X-Received: by 2002:a17:907:6e88:b0:a86:7b71:7b74 with SMTP id
 a640c23a62f3a-a90296789b0mr49993666b.55.1726086510729; Wed, 11 Sep 2024
 13:28:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
 <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-2-2d52f4e13476@linutronix.de>
In-Reply-To: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-2-2d52f4e13476@linutronix.de>
From: John Stultz <jstultz@google.com>
Date: Wed, 11 Sep 2024 13:28:18 -0700
Message-ID: <CANDhNCro1syRWZcWA61ViowNV2CPCsOaUFAkDi_XGvgOKXYqeA@mail.gmail.com>
Subject: Re: [PATCH 02/21] ntp: Make tick_usec static
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Frederic Weisbecker <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Miroslav Lichvar <mlichvar@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Christopher S Hall <christopher.s.hall@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 11, 2024 at 6:17=E2=80=AFAM Anna-Maria Behnsen
<anna-maria@linutronix.de> wrote:
>
> From: Thomas Gleixner <tglx@linutronix.de>
>
> There are no users of tick_usec outside of the NTP core code. Therefore
> make tick_usec static.
>
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Acked-by: John Stultz <jstultz@google.com>

thanks
-john

