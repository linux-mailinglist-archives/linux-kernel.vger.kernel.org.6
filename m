Return-Path: <linux-kernel+bounces-265340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BA23D93EFC3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 10:21:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E67221C21B0E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2024 08:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88B6A13C3F7;
	Mon, 29 Jul 2024 08:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b5gWaDAG"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EA013B5B0;
	Mon, 29 Jul 2024 08:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722241249; cv=none; b=U19tVn0JGUzyD0nxb7gFa6D/3BPZDMk6nR/jKkrMfXqXlPt6BzqVlFXj2R++S6xiUOLuDb1M+A9eMYPB5U+1eS1zDCFsuwg74L8vHK4k+Bbmv4zt5d1HwmgomaczudVgXDZBjWnQizvdRGU2uo9KXYJk75kuDp07JXlBww5LDWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722241249; c=relaxed/simple;
	bh=v3L3wlGUVAp84fPXlhzTAV/E5cXslAj1M+rVrZvHt5Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G9fczkm9P+BOmSeODDDgGuELKQM6+mNbRdMRM87coM1NN7kLtI6QOEa8hcTASUYYrMjDt+BwXDMp22bmAD7vLQtqTPsI1YFWs1+1ZHAl61a6shS76Ecf0WS245tOogduTToVgZ+tWyVUh2QNqN8n5GP3ChGtqzNgJcWctRr2piw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b5gWaDAG; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-81f94ce22f2so102600639f.1;
        Mon, 29 Jul 2024 01:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722241247; x=1722846047; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v3L3wlGUVAp84fPXlhzTAV/E5cXslAj1M+rVrZvHt5Q=;
        b=b5gWaDAGtuDZcQODtx10ptbAMSzAGerYViDw7+9S1gQMsPfR1/x3ZK+ejbGfFxkFPQ
         87938QAdalImWmc+CqQ+Zdp5A3JmuQ09Q/A/Ysvx7JkljPqnbsHC8OVJUoG/xH4O2QYd
         aGzSIVCUSohnPZ5dR8zEbEBagge/2Ji3lC/ct/MWZhsRKlbqV6pZhuCSNAsGgOh6WzOD
         /vOYR6X2SsgIWp2meDz+virW3MS6TvX3mc8hoXL2RKXc/sO/YdAVkHL4+tOFXFyERCXE
         YSfVkVgCvhArevLZHRhevSv5UT72LxIUJSnJTJvYu5XbslONkJnsbqWNsYhG23MmcH7V
         gCPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722241247; x=1722846047;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v3L3wlGUVAp84fPXlhzTAV/E5cXslAj1M+rVrZvHt5Q=;
        b=RcgCLwCME+6TByTMv4hmxUKI11MFvB5uun7vZPtaDeD/YT5PFvEl3GCcASe/dz+NIH
         IkUYcUTESZuGUnp2czoipVfZnyCjXNg13sHLYh00SGMcyNn76/WYNhHcbAy+qC4Rq8ZP
         b/qB3Ga/v0BlaaY3ZtvqrbKK6O0CdYJ4Onf4uB38zzOteumzTorDCwX4UW9upl7P+rL5
         smOWHYD3RHMJWEl3XgbYz+wBJ1BhIL2Pp8Mt2gbAvO/KeV9IHb9IShdF5Dy4maARUkQ+
         MooLjHU4njdqE9FplSbBAny0v9sQBQbuPojWzvN1/2yH74g7oIKgJHKxfF4eFF+ko4MA
         bfHw==
X-Forwarded-Encrypted: i=1; AJvYcCX+eFLFUQvgaA2/8C+SL6TpbjqrTStP9tler3gcdUHQBM1FBp4YJ5AivWjiFe3LHK2eUJswKnQvHrAaQDw1B9vii2yBbP0gVCB2UD/Dph7pZAxVKCA/OAm9idlHEA0ZuSQXelBeefxaZXs=
X-Gm-Message-State: AOJu0YxXg9YczqpeM8aAvfazRN6QAEaIEATiGJen8CnZf2yZXDVlDAAY
	EobclzIh1Jk+BDrXOplrEeomJAN+elYySXsULYJYspypMEPHuFcA1UjCJqVkv776c37RqAajGr5
	tQ93HFuG6+piCHDezJgpycxYaQnI=
X-Google-Smtp-Source: AGHT+IFRjPzCVjscduMe9PJTJPCwA2zTGpVECZbzZ1yuPl5xjdRZBOYtWRkqcDIIuWn8xfTHGWkMJXhEqEdFQ9nbXV4=
X-Received: by 2002:a05:6602:3f82:b0:80f:81f5:b496 with SMTP id
 ca18e2360f4ac-81f95aba61fmr1054588639f.14.1722241247516; Mon, 29 Jul 2024
 01:20:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240727170604.9149-1-eugene.shalygin@gmail.com>
 <20240727170604.9149-2-eugene.shalygin@gmail.com> <8b2949b0-63e0-4250-a313-9664f714c4b5@roeck-us.net>
In-Reply-To: <8b2949b0-63e0-4250-a313-9664f714c4b5@roeck-us.net>
From: Eugene Shalygin <eugene.shalygin@gmail.com>
Date: Mon, 29 Jul 2024 10:20:36 +0200
Message-ID: <CAB95QATwU=P6m1vub18PcuWty1eKGkM5aGMfuuWZPD9LyAcd2g@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] hwmon: (asus-ec-sensors) remove VRM temp X570-E GAMING
To: Guenter Roeck <linux@roeck-us.net>
Cc: RobotRoss <true.robot.ross@gmail.com>, Jean Delvare <jdelvare@suse.com>, 
	linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Guenter,

On Sun, 28 Jul 2024 at 00:09, Guenter Roeck <linux@roeck-us.net> wrote:
> "X570-E GAMING does not support the VRM temperature sensor."
>
> would have been good enough.

I can easily change the commit message, of course,

> > Signed-off-by: RobotRoss <true.robot.ross@gmail.com>
>
> Hmm, that very much looks like an alias.

but what can I do about user email? I can ask them to provide their
real name, but they saw your email as well already...

Cheers,
Eugene

