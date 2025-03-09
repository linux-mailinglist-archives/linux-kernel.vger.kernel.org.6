Return-Path: <linux-kernel+bounces-553359-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E860A58801
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 20:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A68816B173
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 19:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C1121A450;
	Sun,  9 Mar 2025 19:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ObNkqqU5"
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7999821A449
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 19:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741550212; cv=none; b=p6X7UZzk60QyuazeczVAgKLDpwIHJfnN85+PGbkCXJFjBWe5Y1D1RYb+Dc0BFfrXaI+kdeVYxwsKtS6iCrMWWKKPktW2xRkVOw8kwv2GhYKII/dqK/MlBJRRiLLQS1m5olUGQ6rleBO9b0wNjStX7WyqaxUddaT28XN4JrWyhE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741550212; c=relaxed/simple;
	bh=dSnTKvhEgV+wapa7NAlSCvCvXVQ99+Elp38mxj6MMfk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z2kztjbAzSEo9HAELJUOX49LIP7nEFw1r1R+I8dKtppVU/fdRyuRTsoYC4RzcFvb27uL+99H/I4HPfL3ffxkcMIlmZjw/GXh+dKhSQQH0UICGPf766lQ/TGV2//ASKv1bEDTQr1UZzm3GbnjV8fYOV+w35zyPeuxQPMyQL8bBs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ObNkqqU5; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6dd420f82e2so48420366d6.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 12:56:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741550209; x=1742155009; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dSnTKvhEgV+wapa7NAlSCvCvXVQ99+Elp38mxj6MMfk=;
        b=ObNkqqU5OT1kWnOUR6KL8EnI6mMiVddfzefhU91xpf9V2eFcGMNZhNBziMxsK0oXbN
         kkJmP7dE4hv4gekrnrFnc8TJ/lJZSQgZ42GZ8DYqcDvCs7QrZGbDr0MB2YwddwYqGct8
         r6PD6r6ucfDdE7O8ESXloaWwWzrcrUtBvQOcP1k/H1eBM643eBnmmOh8UusU3FMG4AR1
         tFKU/v0ldUdwioPXd2yQwb//rrF/ElO7h129OgRtBOBKNsSkTyCfoySKMrP9sqtx/pUW
         bG/5wneDcih4XpPp4F4oZKhgHxbc5EMNSBWEOTA9hYBO3+qUICL5gERMcqsBOZXV+IJ+
         5B0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741550209; x=1742155009;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dSnTKvhEgV+wapa7NAlSCvCvXVQ99+Elp38mxj6MMfk=;
        b=YSMZbJ1FgE0nzwvvWDT7TwvM+ToEYICOm9aIAeeYmcLLLkp/dNqxzqTYRbf97rjQpt
         drt9UTKVXUT4CDqEU9IZ5sYeu8ercY+CUW3IDE25z0cH+Fu12hpfBm/0gXyLnmhKzWZa
         Ol2AkyQeh8qH9iKb6gkswCkqAJcPKuYkZJtV2DS8t+/UBDsQWOYWkRt0Fcgvnox9MvbW
         3UDW1AbaapcwzPogPbCuEKnZo0KIAJlNaRbLScXxPYTit9Sz+7H0RI+l28w88bXowhoR
         RhEi4IEBgy2a8En9+TOBzl5G1iO+vTSXcNcsMek3cAHXrFTpYeNG+iiIboes9Mtxxnc4
         OZiw==
X-Forwarded-Encrypted: i=1; AJvYcCXIDXvz2WZlqW9pYuTqCKZTT/iPH+j6Dr/T/MT6lvjXxjJcM3GTGlWM5I3Jl3Mnw/XR/PZzd5P0yvm8ozs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/2IUUVhRvJTjQhRnAdeH6Co6G9VaSB0wPUDg+himeMSlAK3CB
	6EPix5IW+Nkyk32DzF3N+FWl7fR4lf24xkZ9uXcb4ypM7XjBVWl1eCFIphnPJ7Kk5MHmQ6w0nog
	M+FFa4EUQs2WvrB9jDyyEqF2eHmo=
X-Gm-Gg: ASbGncvDyL71p4zLoToCFAQaKGpyXSL0dUWbx6Xk/OByGXjrU2whDHmfugJh8QPyESM
	9kFQRa/NHLN5gzZCE0LDG/klxjVfeIf22bqxMNrZAWgNvLGhdg2BzVIZ7bOTYC5i6B0MNd9paFi
	ggqSPabVIaYhFEYJM+Uniu5RM5Ko47lW+LubaeLp/vhVFWRPBPdmFCdAf+Pey8l+5qoPo3
X-Google-Smtp-Source: AGHT+IGCxeWjLaFaWWiU7HIAYGQDFblVuJYT+KZQzMvZbP1fpTM7sCcy7HxB3TlykAu2i+71Urmyt4d6FeX+ljmXyRI=
X-Received: by 2002:a05:6214:2268:b0:6e8:ff2a:a658 with SMTP id
 6a1803df08f44-6e900604867mr117055406d6.5.1741550209304; Sun, 09 Mar 2025
 12:56:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307120141.1566673-1-qun-wei.lin@mediatek.com>
 <20250307120141.1566673-3-qun-wei.lin@mediatek.com> <CAGsJ_4xtp9iGPQinu5DOi3R2B47X9o=wS94GdhdY-0JUATf5hw@mail.gmail.com>
 <CAKEwX=OP9PJ9YeUvy3ZMQPByH7ELHLDfeLuuYKvPy3aCQCAJwQ@mail.gmail.com> <20250309010541.3152-1-hdanton@sina.com>
In-Reply-To: <20250309010541.3152-1-hdanton@sina.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Sun, 9 Mar 2025 12:56:38 -0700
X-Gm-Features: AQ5f1JqmOsDV6PA9p_JfhIk4bLAPeIOV-Wd-Scc-DCtCWYhFYoUL8lNZ6XNpqMQ
Message-ID: <CAKEwX=Mwh9SKWfmaS9q4fym7L-v5m6GmvJrQF8eFizJJd904rA@mail.gmail.com>
Subject: Re: [PATCH 2/2] kcompressd: Add Kcompressd for accelerated zram compression
To: Hillf Danton <hdanton@sina.com>
Cc: Barry Song <21cnbao@gmail.com>, Qun-Wei Lin <qun-wei.lin@mediatek.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 8, 2025 at 5:05=E2=80=AFPM Hillf Danton <hdanton@sina.com> wrot=
e:
>
> Could you explain what nr_kcompressd means, Qun-Wei, to quiesce barking l=
ads?

Who's the "barking lads" you are referring to? Please mind your language.

