Return-Path: <linux-kernel+bounces-175027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7A9D8C194A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 May 2024 00:19:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 689FFB22389
	for <lists+linux-kernel@lfdr.de>; Thu,  9 May 2024 22:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95820129A7C;
	Thu,  9 May 2024 22:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PTH+l0tH"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCD7770E0
	for <linux-kernel@vger.kernel.org>; Thu,  9 May 2024 22:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715293146; cv=none; b=msioyer55cc1tlLYPsu2UYeR48Bh+TYfmkU4zEtzUPmG1fo+u/BlSbkS4VNNoQtaJeGIWdmHUPgVo3+UCfJiH9do8DDbA81SRBKCUD9MIwph3Drp1ohBvsEKpjV+bYSOn6fCbRes4hK1UwjsgetHeXbLexdmWSpN6EJZV2WVI7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715293146; c=relaxed/simple;
	bh=zxoYyUPeePDhZr8SB4hDXa4C84ML6RNq5QiUdi5hnpE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=swEqR2PLiDoB7BeUlcDy8dUno5T0y++4qOPUY6QiFQNWkqn02pzJUhydgWgaUa+8MC1LxCayJF/g3yhehAFb6KAFKcBqWUusxtWYfHtFrbw3RHBScHnT0LkOSUd5pm8+ZvSrkOpvi2AG2Vd+KOUM6Gj5oLVPGakTdujDu3CBIOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PTH+l0tH; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-6153d85053aso11920037b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 May 2024 15:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715293144; x=1715897944; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zxoYyUPeePDhZr8SB4hDXa4C84ML6RNq5QiUdi5hnpE=;
        b=PTH+l0tHKYc66tpHWZRS83yFviHpni30u0PQh95GexDqajYGoOifV258vLZMhxJo/3
         8Hu4CBleQx2AxLrW5Yz86HqNtsMsK5kiHwa0rfr0BSdQPTduNm/Qg8vwiZ8SqjbhtcmI
         +hDJ8OJcL21+Hcdyr53s0G/3rS4z8baANygH6LehOV/qpko0R2VkxzPstcOFnpTuUZzi
         fyhBvC6073hjhpx/GLxUZPvPZ01jxrnd7VsSesOemZeog5nDidQv/SMZa9B6HKpv4ym2
         dX2kqKaNwvDgBE+P4g/i8XY5ZMQvaw/+N0SG8cWNWiZerTzAREnMxZSltFFrO//ooWQX
         Xhfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715293144; x=1715897944;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zxoYyUPeePDhZr8SB4hDXa4C84ML6RNq5QiUdi5hnpE=;
        b=vKKpxXs7uu9AtjM7sVb/VDdOuYH0y+6gcRmisrRX9vmzgR3S9eU0DK4DTONoMIb43n
         5ENuHyAzVhmBBOjxf46G4aXa1eJFY52rAQYLdS3fyUxqcO7CB2aMv53kDhXhnTbpxVfo
         Y3fybrnbEUhLmDENU9Vivm0pTahONbJa6qBc3YVft62+0eZ2hhrOfRvgN2LUuqswLFhE
         ZTpu1ovulDHzCY98gBG6q7yvC1eJPmEEmOTnOZXMSNN/uSGrhcESmXxS4RCidK3+pL7K
         QIPifkSjFDNoqVZPpptQnszKGbnDx0ZIsiWfZ7tOw1wYl8H+WhZrgov20gkWzWbqjp6S
         mq9w==
X-Forwarded-Encrypted: i=1; AJvYcCWwYfysEKFuCfyf7bKqfT203k5HqIevD0zRNjI85fJWjCYMEtkdASwfpdtnAkrxY8fl/fvnUXk7/CbpVc7IY4Ch+xT4vS5xZjLNJM5p
X-Gm-Message-State: AOJu0YzF84fArEX6nNGd7cEq2NZeYZlPakyDIOeCuxtEuckJ6ZEv9QXg
	s+VE61wUV7IRKhybduw3uoGyKjCq03ymG9ZjOpk8rlxiBZNXMgmMwCillrkZO6/0g6+5517O8fS
	pcZg/21wKziv/H8wDkYlD98GZgMTAL9QPaYNw
X-Google-Smtp-Source: AGHT+IGe8M/e0bjrvOjdbqypABRID7ZIyZcCukLEAafyMAg6eJo2xT8Ix2AVn9pQmMlZBxx8XY7bDoUSIY4vQAB53w4=
X-Received: by 2002:a81:4c86:0:b0:61a:b3e8:8d94 with SMTP id
 00721157ae682-622afda0980mr9743247b3.0.1715293142655; Thu, 09 May 2024
 15:19:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZjCtgSaL50YrS-F-@phenom.ffwll.local> <20240508181744.7030-1-jose.exposito89@gmail.com>
In-Reply-To: <20240508181744.7030-1-jose.exposito89@gmail.com>
From: Jim Shargo <jshargo@google.com>
Date: Thu, 9 May 2024 18:18:51 -0400
Message-ID: <CACmi3jF6Dp3PE8X=T5kTO2+eYJQi7jWACFdmp9jzKxUtcQphnQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/7] Adds support for ConfigFS to VKMS!
To: =?UTF-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>
Cc: daniel@ffwll.ch, brpol@chromium.org, corbet@lwn.net, 
	dri-devel@lists.freedesktop.org, hamohammed.sa@gmail.com, hirono@chromium.org, 
	jshargo@chromium.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	mairacanal@riseup.net, marius.vlad@collabora.com, mduggan@chromium.org, 
	melissa.srw@gmail.com, mripard@kernel.org, rodrigosiqueiramelo@gmail.com, 
	tzimmermann@suse.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sima--thanks SO MUCH for going through with everything leaving a
detailed review. I am excited to go through your feedback.

It makes me extremely happy to see these patches get people excited.

They've bounced between a few people, and I recently asked to take
them over again from the folks who were most recently looking at them
but haven't since had capacity to revisit them. I'd love to contribute
more but I am currently pretty swamped and I probably couldn't
realistically make too much headway before the middle of June.

Jos=C3=A9--if you've got capacity and interest, I'd love to see this work
get in! Thanks!! Please let me know your timeline and if you want to
split anything up or have any questions, I'd love to help if possible.
But most important to me is seeing the community benefit from the
feature.

And (in case it got lost in the shuffle of all these patches) the IGT
tests really make it much easier to develop this thing. Marius has
posted the most recent patches:
https://lore.kernel.org/igt-dev/?q=3Dconfigfs

Thanks!
-- Jim



On Wed, May 8, 2024 at 2:17=E2=80=AFPM Jos=C3=A9 Exp=C3=B3sito <jose.exposi=
to89@gmail.com> wrote:
>
> Hi everyone,
>
> I wasn't aware of these patches, but I'm really glad they are getting
> some attention, thanks a lot for your review Sima.
>
> Given that it's been a while since the patches were emailed, I'm not
> sure if the original authors of the patches could implement your
> comments. If not, I can work on it. Please let me know.
>
> I'm working on a Mutter feature that'd greatly benefit from this uapi
> and I'm sure other compositors would find it useful.
>
> I'll start working on a new version in a few days if nobody else is
> already working on it.
>
> Best wishes,
> Jos=C3=A9 Exp=C3=B3sito

