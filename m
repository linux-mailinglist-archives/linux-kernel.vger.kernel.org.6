Return-Path: <linux-kernel+bounces-565884-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE617A67096
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 10:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C086E3B3200
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Mar 2025 09:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2E6D207DEE;
	Tue, 18 Mar 2025 09:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D47SJ/y8"
Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1385C20896C
	for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 09:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742291838; cv=none; b=MChdmpZWcZb3iyPbVRs1ZRaJeAIZsNmAuZrd0e57f06H3AvMrzR9IXPf5LbeJuBFroCjpDye6td6Q2Bok/jZO7N07ltYvsA46Ib4RTP8Jy+3n/qXeIvcQRx2FTaBCKgw0+Bdo4IRJvwW3kR3N4tfPdTbRWtACyxhG+lzqIOOFQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742291838; c=relaxed/simple;
	bh=Y6vLzjufl+mwLMPqfqy0R5Y6cwgxKn2lZd/fQNHN43A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EgAXUPTFVdWxJq06biljSJ/3yx3oZILC1kAxEwMpv2lJKQ3CNA1dWdyl8xw70OrsqaXdApPHHAASDXnwBBQQAY9IGj9XluIlCnkKXrX7UJ/cKe4etyJYm89THf32I7NNBE++MVl6KqrqwiBPB8O+oYxaBJRM+X5D2gs0c3A5SoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D47SJ/y8; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6e41e18137bso33270486d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Mar 2025 02:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1742291835; x=1742896635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6vLzjufl+mwLMPqfqy0R5Y6cwgxKn2lZd/fQNHN43A=;
        b=D47SJ/y8TFSLSc0kJ5xPgLLkIfaePVcvFbGKHLZlkUPOeqJ0u3wAqIRUyIJAOqENLT
         QkstL4W2cmadA+cTqd5kVV3N1lxJMQXpqSFa9Zq0qI3b5KfmHqvPugtZBxODIU9sIgJU
         kUG1LYxjAYDwLmF/C3CHBB535y+6t4VGnrx7F2NaJKUeR10Ow/S9V0S87rexnKPUWpBD
         Z5sWAD8RyR/7u6aA7JkPFzAyF16XuZL6fQPm9mJWDL9kiQErpbNjlC6x/UVwU2BhNo+d
         1RXPu0pFbSQ2z5qcgBTifOYnhPEqP6vi3a6al7Q6sb2QtCpnh/ztbqFzOUDsY0ztwOiJ
         GLQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742291835; x=1742896635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6vLzjufl+mwLMPqfqy0R5Y6cwgxKn2lZd/fQNHN43A=;
        b=WOYOEqyWLg6VsRSwhWbk4BDBKaIlFBcoldbOGeRMjyI7VEtP7VPIAnA6frLCGFGEsE
         2lSz35+Vhsbp4F62i3Boo7lMlDtFsxwLSj++3+SMJkBq9keuFhdgxBjwaAa3CAetGm38
         cYvAxQ6vcv5YFVDThy3qCg81YzAnzEQ7FV1QWz/+IWuRLxxfimbriZ+QjPBxIH3f87zJ
         TYl3YPbnNobNEl/uv9NGnKE/Lyoqw9jsnGQU39yAYhEFt8za1lzoNP8nA8a4Nz0bWTu2
         cF5RXbvFuvoglR/TWAgnsjHCjJ9WSlmfCi/z41p+edQWFp1I2D1Fne+I2AmqLIJqInof
         CCLA==
X-Forwarded-Encrypted: i=1; AJvYcCXA1dToOAEQyjWcOf06imkLkXUJwSdgdk6AONl3fOFa6sCKIgFM7ZAcsrl4n1szykgvR+zxd1NmpUrtWrY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEAIQqrViaFaHdk287kQ04cqAtSp7eVt1qBsUTum+7K2XbuT7A
	Wkb05NIuvJvitucPhXpC0hcF26YDmwGfnaaw0WZslPC2aldbJhXmRLnQcKsKdctd8huYBI4KP9V
	f4+zmMp4955w3blnA8idlYLVhGLdhOSPkMBeU
X-Gm-Gg: ASbGncuUsRB3oKq0oXINKSvwdw8eJqj9Cnd0KV4Un+9KB399OAIZQD69txqd9wNt/cp
	lddRUjBh83UEWnk79vdTw1F+dj8NTGE6nA+SSr9VEVYYQq2loLXFDiMqzZyqrDNwXrjF+dMbAor
	Wlg5U6bIoR2rYmWhasAlG3omM+SR98zy2B/84Abkg3kzLA3hiiq6xjwoo=
X-Google-Smtp-Source: AGHT+IFGO/2MNIgugl87SqpqiwPH2spBgQocJNuFQT5g23qVJ3fQ7ACEfSO18uWVKIIe1iduauEonOEF+rWtw0hcEe8=
X-Received: by 2002:ad4:5e88:0:b0:6e6:61a5:aa54 with SMTP id
 6a1803df08f44-6eb1b957c5cmr37408396d6.44.1742291834750; Tue, 18 Mar 2025
 02:57:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250318015926.1629748-1-harry.yoo@oracle.com>
In-Reply-To: <20250318015926.1629748-1-harry.yoo@oracle.com>
From: Alexander Potapenko <glider@google.com>
Date: Tue, 18 Mar 2025 10:56:37 +0100
X-Gm-Features: AQ5f1JrFxFNE5b9N5gKecOSz_7mX00YrYbmIQQ1sFdm83WaYQV5DvfZijArv4Mk
Message-ID: <CAG_fn=W0Vcv7imazajmWzQQVNNb-6kKQQuX+3zGch9QvBnNitg@mail.gmail.com>
Subject: Re: [PATCH mm-unstable] mm/kasan: use SLAB_NO_MERGE flag instead of
 an empty constructor
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Andrey Ryabinin <ryabinin.a.a@gmail.com>, Andrey Konovalov <andreyknvl@gmail.com>, 
	Dmitry Vyukov <dvyukov@google.com>, Vincenzo Frascino <vincenzo.frascino@arm.com>, 
	Andrew Morton <akpm@linux-foundation.org>, kasan-dev@googlegroups.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2025 at 2:59=E2=80=AFAM Harry Yoo <harry.yoo@oracle.com> wr=
ote:
>
> Use SLAB_NO_MERGE flag to prevent merging instead of providing an
> empty constructor. Using an empty constructor in this manner is an abuse
> of slab interface.

This code predated the existence of SLAB_NO_MERGE. Thanks for fixing this!

>
> Signed-off-by: Harry Yoo <harry.yoo@oracle.com>

Reviewed-by: Alexander Potapenko <glider@google.com>

