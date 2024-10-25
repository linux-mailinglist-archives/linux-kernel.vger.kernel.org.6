Return-Path: <linux-kernel+bounces-382534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A86F69B0F7D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 22:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAC9E1C21864
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Oct 2024 20:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACD120EA2C;
	Fri, 25 Oct 2024 20:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="D8lYcCWw"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C8D1D4355
	for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 20:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729886459; cv=none; b=Ee3XxMhte2nG39CXxYkrJSnwA5/fnJNHNtU0mK+hBEKy0KqEivlI0zQoVWe7XgHk5iGrrlusqExhe9UNuaGAPYyy71Hvh2x9+7VK5ywor3gpIfj9zC/x2RJcrgNUVXJEFGTwnuokfsOAnomAw1086cC2+VczLALz+ACfptKZJXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729886459; c=relaxed/simple;
	bh=1AY21VF9QbtDmLyEo0XVNNzYJTjrWXkGsQFcI+D/qBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ekdKjkwsmr6ZDxNmn9cN6XBadkVQ/NEKWcX4Qc3dz6Sf0kY4ejt/sa8lE7cJE6j5roAWdCcV2yLwzBdEN2qdzgMf/aQaoh8+TflfJ6cJ5kZjjIaW/MoHWujIQSsw0z6Ls5hOhUoRq2R80oj3ZEVAPGsWuEsUQK07b6DzPp3ijxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=D8lYcCWw; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a9a628b68a7so365867766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 13:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1729886455; x=1730491255; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RqgVnPZ+sAFjUIPKthsMDBXPwRC2/usor5uwXmwjBkM=;
        b=D8lYcCWwhoNANkERzTRHT5ubhgb2Y1/JpTAjmQuxPKkwAUkli1XDTR3+nVJoX2c/IH
         e/UpIntZbV9YW3OAgEJEuZH7L0VDryCeFEXypzrGVZbpe3NbhHFhvi4aHJ508CjQxj+U
         wPdPzJE4lxibCtv3hrj06V92IlEPZ0HcQ0GtU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729886455; x=1730491255;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RqgVnPZ+sAFjUIPKthsMDBXPwRC2/usor5uwXmwjBkM=;
        b=tv5CncxeTnobulgBG/JI2ncSaQeJW849NiJr/39YeKpeeNuobpAk8jBO/CacpM02Yy
         Z+AwG53Kc7MIrvTNXeKSrJ1Doj6xiBjpl3G0qkB04U462vetYEFa+5BZfuKV05MjN061
         5W8cxGfIJD7lnauQMZehZyMFVoB25Krk7AEm4h/Jj0UI77TydSR8KJvYfWWtTrf1hEMJ
         +0c7vssyDTkaVb5yj1Lwk+44TWOP+8hfdU5W1wV2IUKswKeBd0ruBXGeBdwO2iJuoa7X
         GDFyjAMrYIXZFJT/jIqZHtL05g1l1vE79NG8j8joqaE0Huq/Z6Uqn4LS3uTIjlzs//jO
         nRrg==
X-Forwarded-Encrypted: i=1; AJvYcCVMoWkmRhVEHjFhSAyofphKsde4+UWdHkOFKXC8rdw9ica5Ik0g3Hm8WsSqaem9kW63j64J+lnXHuXRXBM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEFVoAbiyMm8tyUO+Au1Q5w1ie3k97llxBuYcaYkU4u7AXGMYZ
	OKpPlNVLUksVkARyGZ6jEmmDXkVp3Ew2HPVS5EIpukjW8f78MYdEUkUCYJ9j20YlNuqPKGMEPL1
	sXks=
X-Google-Smtp-Source: AGHT+IFpzml7LZL570yMBldMLY1rm7RRy0duB0qnMR04TJH/VxVHZ6U0qncEz8sUHUgqB1TJvyo/Zg==
X-Received: by 2002:a17:907:9721:b0:a99:89bd:d84a with SMTP id a640c23a62f3a-a9de5ee107dmr23673766b.25.1729886454935;
        Fri, 25 Oct 2024 13:00:54 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1f2994f4sm101033866b.123.2024.10.25.13.00.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Oct 2024 13:00:54 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a0f198d38so335992866b.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Oct 2024 13:00:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVOeVdW3zb4vk01irry+B1n0/Xx7aa6Mo/s2RvuUntFFegkyn7V2xNONKcM4gGgzYaAQFmR+gWwMFZoJzU=@vger.kernel.org
X-Received: by 2002:a17:907:7e86:b0:a99:77f0:51f7 with SMTP id
 a640c23a62f3a-a9de62ec48amr21019766b.61.1729886453894; Fri, 25 Oct 2024
 13:00:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZxvBfDuqSC_TEM78@carbonx1> <CAHk-=wjKouRizUF97ZABtCmijjKR+sAOmWA4uiYhhSOwhxCT3w@mail.gmail.com>
 <e3debf69-0507-41bd-999c-b3de79c809b5@gmx.de>
In-Reply-To: <e3debf69-0507-41bd-999c-b3de79c809b5@gmx.de>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 25 Oct 2024 13:00:37 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjhG+UYcrFWc5-XzF73R-ZBLqquXWDoEgZjOTGe2Tkuug@mail.gmail.com>
Message-ID: <CAHk-=wjhG+UYcrFWc5-XzF73R-ZBLqquXWDoEgZjOTGe2Tkuug@mail.gmail.com>
Subject: Re: [GIT PULL] fbdev late fixes for v6.12-rc5
To: Helge Deller <deller@gmx.de>
Cc: Helge Deller <deller@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 25 Oct 2024 at 12:36, Helge Deller <deller@gmx.de> wrote:
>
> Do you want me to send a revert for this specific patch?

No, it's in now, more churn this time around just makes it worse. I
just don't want to see these kinds of non-fixes in the future.

           Linus

