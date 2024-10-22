Return-Path: <linux-kernel+bounces-376604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA899AB3B3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 18:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9EF8D1C2285C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 16:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C28891B86D5;
	Tue, 22 Oct 2024 16:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sOX9Uxwp"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944281A4F2B
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 16:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729613961; cv=none; b=LqEfHjgorVo23+fOIDiRoqZ+tLbkkJqH/V9h5Fmd2GRc4awmyrZrN2yPqzjyrmEl5oqoWc8nX90xk7nW26gKVZOXDbUMjf0Rm0ohavoZx3ttZFPc/rq1nYdOkO5kQjGDybpZwL1v+UxLHxvuw2wLIDRTMGyDTmhthNixq9dZM8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729613961; c=relaxed/simple;
	bh=O010jrXbVVYc/oBTmTv82BWnbf0mEg5IgHol5Aj0+vg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PI56IzVq8WEx+Xk454DuSLH0nrHP7TS1/9EVKK6j/JN6L8Ut+/PqI1D7R7w1eaIaGvOT2HlSiJzZ/K6DU1A2Q/HZesWK9XspHQiBZhTRr8BiPq3/fDrvXnHiQn9dNBJ+LScM0f/zmTBZpsploQrstigWyLZfhdISuewO/vItv1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sOX9Uxwp; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c941623a5aso11391392a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 09:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729613957; x=1730218757; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O010jrXbVVYc/oBTmTv82BWnbf0mEg5IgHol5Aj0+vg=;
        b=sOX9UxwpnrwGksSh2XYnUjSxZ1nlCmxQGfvZbLAd0bZpFmJuaR7p4azWivFhq4jBYI
         hb+LOU/wyVUtt7Uw409ebo14uDbyurIZ0lwVK/aOXXFJ+vjWL4ZDzLqjbIBkjDCwXUbB
         1rKRmCeg1y38YZqi+giJ4JXzXWRzAzBFw8BVQibZmhjZzSFvasrZnRsRHU4JBpLtqgE5
         7EdolMEC2bwM7x7EheQYCLe0ElLPJxFv3tolGNCuYeCjQZcQoaeI5J28o6XdantZj2AK
         pmQfr06bFvjuXhvO/shlQ89TmxKnktJmjxNhoZCU4seX0idZv3QySnmYRryQKCMIaUiF
         s66w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729613957; x=1730218757;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O010jrXbVVYc/oBTmTv82BWnbf0mEg5IgHol5Aj0+vg=;
        b=ijzkRv6XT9YGiODueG29jIENeCSj5YIolDnAmOgssxxrN2HgJH/jPRSJj5IvP88Dmt
         kUIFAg12PVW3LCekhefqekBlT/HpniAa4Fp0u0y987v1iJsvckUzNbzE1JHp4ZASyq9j
         mSNTfUmHSk7VJp/q+KsywdMo79wlNMQCY54lAo2AlI4AnIV7+eELSP+dGVjmjBCw2SzE
         8g6ryHjug6z0wmRDzyYUO4B9R1IZVjcbg92RpIumuh2rl6Cq5QHt13fLskLcnYTYm0Vb
         TeNt1Qga6sIjP/feFSudMcyIv4rruHamS0rFTB9ccHMNFHirI65xveVtuAE/o0iNSkuw
         GP1g==
X-Forwarded-Encrypted: i=1; AJvYcCVupnDLrRGtANMeFRxb10pYp6uo9GN7BkUjQ6LUa9Rsu9JGLW92E9pnXoLTxLSUxx7401B6NE23QivfBC0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHPqOGZB+45jYgd6Fq75OjYMnlwe32vtp7Hyxtjk0dQu1Gt95H
	+nxTrhoZoWflBb1XWbHUNt0jn5khgvnuxtHds2h/NuMuCnntgPH+psymAn5a589Ve0bH05hnkqx
	0cJsCtSK8y/YyGeYD8ip04fMV2izc121L0PY=
X-Google-Smtp-Source: AGHT+IE2UWF9akIjKN3CLcsBih/tjrcN+DK2fnaCGfTRq+l4mjlUsUQFO0mOXVfH5O+jRzv/E6HKLsTurAdaP0J2Ixw=
X-Received: by 2002:a17:907:6096:b0:a9a:4b51:9e7 with SMTP id
 a640c23a62f3a-a9aaa53a59amr424231966b.16.1729613956687; Tue, 22 Oct 2024
 09:19:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022-macaw-of-spectacular-joy-8dcefa@houat>
In-Reply-To: <20241022-macaw-of-spectacular-joy-8dcefa@houat>
From: John Stultz <jstultz@google.com>
Date: Tue, 22 Oct 2024 09:19:05 -0700
Message-ID: <CANDhNCoLgzy=CPBWjBKLiJzRdnf=SS3AgtFJNB-CBYAo=UEQJA@mail.gmail.com>
Subject: Re: Requirements to merge new heaps in the kernel
To: Maxime Ripard <mripard@redhat.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
	Benjamin Gaignard <benjamin.gaignard@collabora.com>, Brian Starkey <Brian.Starkey@arm.com>, 
	"T.J. Mercier" <tjmercier@google.com>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 1:38=E2=80=AFAM Maxime Ripard <mripard@redhat.com> =
wrote:
>
> I wanted to follow-up on the discussion we had at Plumbers with John and
> T.J. about (among other things) adding new heaps to the kernel.
>
> I'm still interested in merging a carve-out driver[1], since it seems to =
be
> in every vendor BSP and got asked again last week.
>
> I remember from our discussion that for new heap types to be merged, we
> needed a kernel use-case. Looking back, I'm not entirely sure how one
> can provide that given that heaps are essentially facilities for
> user-space.
>
> Am I misremembering or missing something? What are the requirements for
> you to consider adding a new heap driver?

It's basically the same as the DRM subsystem rules.
https://docs.kernel.org/gpu/drm-uapi.html#open-source-userspace-requirement=
s
ie: There has to be opensource user for it, and the user has to be
more significant than a "toy" implementation (which can be a bit
subjective and contentious when trying to get out of a chicken and egg
loop).

thanks
-john

