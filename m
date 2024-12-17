Return-Path: <linux-kernel+bounces-449031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD3059F48BE
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 11:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5719E188DAEA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Dec 2024 10:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D081E1C30;
	Tue, 17 Dec 2024 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r1vdaU21"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091731E0DF6
	for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734430756; cv=none; b=UaPKbAtFPdX2ACxwId5KUthB5ZdJZKiNV89EgA0twloKpxdQeYBNGITWVhiZNu95ZfmePWeIStiMHpS8BWOC9vTsTJPJeLYKjhj1p1PCFFa6wEtsEA4Z8zumKqYrSED4WmaCYT/gBKlrNyW0zmhJSLlj5AdSh1EMlYutoZVleU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734430756; c=relaxed/simple;
	bh=Z18WrDXPOK8sdE5XwIMLKVLdTqqEpVfwiIQqP8kH+eE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atV73KUJ8oYrqTYmEA/3WxtZ7BPe8boW+4mDqV3lmWx97lVVJLX+ypqBotmHB0dFohIYgq581tqTY89YZ6KhUihZS+C7wZmiY5dEqkOvit2KgHBgEkVxpbn8DxUCNZY59r2dOfJMMcndzLsQ0MgxpKOT/NFp4Oyl2iIoockk7Ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=r1vdaU21; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-aa1e6ecd353so692294966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 17 Dec 2024 02:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734430753; x=1735035553; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z18WrDXPOK8sdE5XwIMLKVLdTqqEpVfwiIQqP8kH+eE=;
        b=r1vdaU21inwCY9q0n9XLAqHZFvAtz/cUnpwEIV0YB0xuaAUKF+moVls77El5WcO41y
         QhR1kHyhBt8LC655s/xoehYcH/JEzpi25twPKC7s5/e7TX8zqkxwW1FxctecMURP0oMz
         +QzL1FgcVrwQV0p1GKw1d9rk5RDtrylhjAZnS5czeoHfV6TeXd3Y9t3fhyTjV/9fYXX1
         vaEarSlPcqFQN347mvE2Wkfet/p+CTzxvLmI8/IFaaoD9qRTm85g8/8Fy0xBrQflyvym
         My3ik5Y8QuvsFISJJGRho+VCBJIVogNMZQVG0Y1/RoepYH2e5Fw+SfEr29fR6m2QQo+T
         lfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734430753; x=1735035553;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z18WrDXPOK8sdE5XwIMLKVLdTqqEpVfwiIQqP8kH+eE=;
        b=rG150/bhQFCpkGua++BM1Juzu3dpCpXbbowNGUoR8PiC1ikT5kH8WNeBIpB33UNNLc
         CA/wsItO5dYkZ+i5AJfjSk6avmCN5s1V+vXKFNrjSHs7CEBCxqiHOFgTSy8Nun9SC2Kz
         FYsOPmskdhDzVvd2nT/G17FqiydU7xYOSAbR6aB2S+LCTjOn2sIdqupgQNgZIYyuJTLs
         XGq6z+N6ZFjJF46tFtxDqpyWdR/mCddZ6eZmgO4rp3cv0OzfIF2b8bMkaQe9HtH9qR0u
         v42okfxe0mNjTrmp9z8lTzLmZjh01AslfXJrvy5GpH6zG0sDBTYJ6WC/cH6EOmJ9Pt2M
         q3FQ==
X-Forwarded-Encrypted: i=1; AJvYcCWEsB0TGvE5szbuUTBF9GZlmbdFJkfNZLDuj1cGPt2cDC/KqfZgGQWA1cgIGNQnSNcAREQTs5wYFUoM58w=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywqpkzfyv5kzjNMtRCaItv3WfzHx2XAobQC/Ij/qUqZImqsgOFK
	TJb4KeIGxRdw3iopI+0+bgY/SMDNEueKT7macJMKxRhMWrwtlont/ReYjrFGCBXPyvEtS2lQOu5
	1sXIycVI8nYDUJ4ZQc4W1wr4eZ8lJs4OCYk1a
X-Gm-Gg: ASbGncuOUNP2RbRTEqO3bDV14ExsRFfogBzXlScQO6Z10iyr96Wl+7wqsPFy4GQR4DT
	oc/xYXdoU/of4kUSIJ6AfMLvkmxG3DA8gHGyoTxC+oUzJ/McSoXhbyikddBqGJ3cym91h9G8A
X-Google-Smtp-Source: AGHT+IGwfOu6ANJJ05jZ+YL/Ec3h75SVW9OIju7Dy/3tpNuFA3NKeaexTVuBR8DEViYivjcF4eZBsHCVbeTz8Hx3SJo=
X-Received: by 2002:a05:6402:34c7:b0:5d0:cfad:f71 with SMTP id
 4fb4d7f45d1cf-5d63c407452mr36501089a12.32.1734430753272; Tue, 17 Dec 2024
 02:19:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241217094608.4149466-1-buaajxlj@163.com>
In-Reply-To: <20241217094608.4149466-1-buaajxlj@163.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 17 Dec 2024 11:19:02 +0100
Message-ID: <CANn89iL077dDhKwWA8Uqhco-uK=UdjZMy7+UABBT8h5Lq4UF+g@mail.gmail.com>
Subject: Re: [PATCH v2] net: Refine key_len calculations in rhashtable_params
To: Liang Jie <buaajxlj@163.com>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com, horms@kernel.org, 
	anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Liang Jie <liangjie@lixiang.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 17, 2024 at 10:46=E2=80=AFAM Liang Jie <buaajxlj@163.com> wrote=
:
>
> From: Liang Jie <liangjie@lixiang.com>
>
> This patch improves the calculation of key_len in the rhashtable_params
> structures across the net driver modules by replacing hardcoded sizes
> and previous calculations with appropriate macros like sizeof_field()
> and offsetofend().

Please wait at least 24 hours before sending new versions of a
networking patch,
because we are flooded with patches.

Documentation/process/maintainer-netdev.rst

Resending after review
~~~~~~~~~~~~~~~~~~~~~~

Allow at least 24 hours to pass between postings. This will ensure reviewer=
s
from all geographical locations have a chance to chime in. Do not wait
too long (weeks) between postings either as it will make it harder for revi=
ewers
to recall all the context.

Make sure you address all the feedback in your new posting. Do not post a n=
ew
version of the code if the discussion about the previous version is still
ongoing, unless directly instructed by a reviewer.

The new version of patches should be posted as a separate thread,
not as a reply to the previous posting. Change log should include a link
to the previous posting (see :ref:`Changes requested`).

Thank you.

