Return-Path: <linux-kernel+bounces-352924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B2A99263C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 09:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A6D72831DB
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Oct 2024 07:47:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EDE16630A;
	Mon,  7 Oct 2024 07:47:03 +0000 (UTC)
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500AF13E40F
	for <linux-kernel@vger.kernel.org>; Mon,  7 Oct 2024 07:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728287223; cv=none; b=miSavgzOwWrWQips/933xHnsevKjIgH55t1KpyOZYYw35D6oaUBmHTOt5qj6VLpvZxBflLiq43w8xIaKWaJX2iFHxzGXiq44MnBhSz7yDDHtffNAXU5Sild/QFfvr4S2srZDfLf8uiFmGAkUnonmdVh24zjxdIeughW3RqZvLNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728287223; c=relaxed/simple;
	bh=78saQEoIz5eLeA1YXHL0dGmPTGyBQpC9L+GuFu1gAG8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cQslJ1PTqDDT/PH6LRUvWnk/YHPzKrWTfi1K1U0l5n/c9DLeWOeM7oW2PKMgFDhFrbqKM7oy5fZ+E5DdNkOZvcRga8Lu50EFR7NzAPK8Ezapl4kt0ITfaSONZt6aPatD89GpCDYtGdfC8batyYCZYPeEAwJxwLifnchpOKoV1+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e28c9b7a1c9so609792276.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 00:47:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728287219; x=1728892019;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7EZ6p1+e+YioVm3cALmQT+BYzvdifnIf0AeDH/fwHI=;
        b=ov0tSroPFyj6HvBD3vr5DtUKw/YkD2oSLzrxcm6iGSlAxkT3T+npR71JhzTOGBGguo
         oabnxvXNxvB1+aEolfnh2TDcp+aOQgy57SOjBJfZzcKhfq/zgc6EABvoxX6HoARhWK/R
         zvfVBOc49xPb6/fkHHnBbcpMtXqDJZFQ5kykwSN5Hr3iqC1nAg9YJG5hbsoMMcgpCgu4
         C1GPXD5eGTmY6yeKv5FYMUF/XnJbrdnrGnYQ1Jqcs0ZNSEeqoURa38vyuhg7ElfNATYY
         /YczhygjNVWtPgVqgZdvdbFNRHwufBFRIVi960g2B5rCsxJFE3anSVKKw9yoWeBxHnGu
         8JBg==
X-Forwarded-Encrypted: i=1; AJvYcCVPnhQU9PVhbVm+ZpQlwMpXiD2GQfX4q0XEsbRNVo6viX+S5sgOpWj3phyoGA6DvoI5o8IL2F+dWI+Jlmo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzC9A2bO2QAGO48DBM27ficrjzC89OEARBytwzotUgjkfTRd2s5
	ktQfRHYjyJ7ILHui0YjJx520ZMF4wyoHHd7UkxcS3Ff5fiC2RMM+xYRLozSf
X-Google-Smtp-Source: AGHT+IE1O6DNUCfKZAvFfdZS4vvcJ3eEoeEwWaLQrWvJLRkeU/xXaNbzk5Mp7I26wnM3CpYJkqh/nA==
X-Received: by 2002:a05:6902:1241:b0:e25:d46a:a570 with SMTP id 3f1490d57ef6-e28937e425bmr8651334276.33.1728287219596;
        Mon, 07 Oct 2024 00:46:59 -0700 (PDT)
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com. [209.85.128.180])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e28a5dc12fasm828295276.53.2024.10.07.00.46.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2024 00:46:59 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6e22f10cc11so28612867b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Oct 2024 00:46:59 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVbTlCuQl7r+OuBMu8QlJpUXPK99e+IbleRUSsi34D87aWha4R6ihHfzkCDG4Ojxgec1pwWUt7SryDF/8Q=@vger.kernel.org
X-Received: by 2002:a05:690c:d89:b0:6de:b23:f2c3 with SMTP id
 00721157ae682-6e2c72412bamr89451967b3.7.1728287218943; Mon, 07 Oct 2024
 00:46:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006225511.121579-1-linux@treblig.org>
In-Reply-To: <20241006225511.121579-1-linux@treblig.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 7 Oct 2024 09:46:47 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWJfdzvL-Px+yOTjksS6by1neQYz5CzA-5_2gVYXm=Lfw@mail.gmail.com>
Message-ID: <CAMuHMdWJfdzvL-Px+yOTjksS6by1neQYz5CzA-5_2gVYXm=Lfw@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: Remove unused functions
To: linux@treblig.org
Cc: ojeda@kernel.org, andy@kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 7, 2024 at 12:55=E2=80=AFAM <linux@treblig.org> wrote:
> From: "Dr. David Alan Gilbert" <linux@treblig.org>
>
> cfag12864b_getrate() and cfag12864b_isenabled() were both added
> in commit 70e840499aae ("[PATCH] drivers: add LCD support")
> but never used.
>
> Remove them.
>
> Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--=20
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds

