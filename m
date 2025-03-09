Return-Path: <linux-kernel+bounces-553372-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A040A5883B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 21:44:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43B7D3AB37E
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Mar 2025 20:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15E121D3FD;
	Sun,  9 Mar 2025 20:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TlZh2hlb"
Received: from mail-vk1-f181.google.com (mail-vk1-f181.google.com [209.85.221.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA5F10E5
	for <linux-kernel@vger.kernel.org>; Sun,  9 Mar 2025 20:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741553078; cv=none; b=bT8tp2e4h8Vut7h5Z7U1eNQ8P8dw8N3rHa1yD0uBEzPMUoRFmY4fTZDBsmfV4BQm7v30NlnyQ8hvkEC2FITM5/SkK8v9ZqNmIu2kBmE1+2Ecz1HgQr6eMCZzH2fTSPktRpuf4QgGwT37p0KOUWDtxTD2sHzp5Xe3v/f0DRa+ug4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741553078; c=relaxed/simple;
	bh=PpnuZiV1qC8ZAbQfa0GH9u2LrWp6a3ioj+AJFobenAo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WaSG8KTDoLBmqcCSuf4NLJIFKxmRdEBnnNv7cg+LDA2YlAK00Qflhnm57VVds5A3eUuVZY5HhSAXZ25qqDwaT0hm6IL1AeMTJvgEIFl8nuo/ieuTxn8CckusnFwpS923koqZrUvXk8m0yksHxW7UsE2AU1134YVYGVLp0lpy9q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TlZh2hlb; arc=none smtp.client-ip=209.85.221.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f181.google.com with SMTP id 71dfb90a1353d-51eb1818d4fso3906872e0c.1
        for <linux-kernel@vger.kernel.org>; Sun, 09 Mar 2025 13:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741553075; x=1742157875; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yvrDsI1J3tG/TSDdED8w2Ch7rRwrU6CBDxBSV0mPWdQ=;
        b=TlZh2hlb2hGi3BcM0OF7Zn66bx5l98XZvKYUi9jZ34Zui90Tb5OK+BE85Y6M/ozJtk
         85rcKZ7Iun4r860CoUDAqnPjtbvCnrCPPhKNDXzZno0UI9kRqol19u3sIFH9nZgm1I1p
         IM97t1A5rmxqRFAQIm4IhNKXuaWukd9yE8mLQi67e/v9hs2WtePZqSAU3sxlX6Qq+Bxd
         089GbT2HXm+pSjqE+F5YoeAbR7HoL9lDI2ZdFwWakbYg2lv5slh23ah1WCryargJpkIF
         UYfQ/KskDFjn8S0E4Kv1tpyhGeI9NKAGOp1BZ8Ur7odU7uEHnqtHlGdGpAogOlglUrPw
         4Kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741553075; x=1742157875;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yvrDsI1J3tG/TSDdED8w2Ch7rRwrU6CBDxBSV0mPWdQ=;
        b=farHg2iUQewquphRSG03LMEh0x42RBH/2v1J2Qd/sZ7AE9gn51x1PvrS85SAzhZpW2
         1vUOFnwS7h3ImAaaX1ScyDRMj3cJ0e1zaINsLmmW+NmxVefmXJTZ/BJ33ZCm86uc4WOe
         hQeqQoZC+cdvZc1yzqT5H+Ujwk2xqDVMRXDsNfVA0Qdm5USBGc7R4UV7eJN7a23x3t72
         VBYNel89XEp36j34L6FCikK94g40RS9x6rrRbOVNCzCMVN2NxuZ4AUYA8qE9w1Ym6lzj
         CZgKD5qo3F9PQ9XpzQCjjEqPULk9tlEHCEDfckmRe8G2SAFVLTPFYINoPH3YX0wZlE6k
         v8lA==
X-Forwarded-Encrypted: i=1; AJvYcCV5DOdmcN+jlNiezJz27GDd+sAbX34aEWYYe/gUc04mPFW+1hFhnc1sONNqPRzb0rs8+E5FpN3UJZw7qXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZIroEAA/2l29r5p3JhQrEs6hDiHEr3NGwpkunXc5drCr0eFpb
	YvwPrIs358PbZtw0dwW3fTsXpEgtyKhQecaxgacJdWE0QojMo3A4I3+EL0QjSvbyJcfJzbbsugl
	CBdGcH8ji33Ltx/8//dRc3TBjOlY=
X-Gm-Gg: ASbGncvJFx01fB6fxbYiUcbFzmOkkXac9rJvANWsF/5v9CKtM1Q2XEJxADIl/RjkxP6
	16uyBfijL0jM3yE/4AOnSP8gJiNlq2Y+BPt6b3mALHX1lrDTqOnmIbovBgeRWR9lvd3LYj5Qu6i
	SSLthpiiNAd+/e/5FT/gkXzqLw4A==
X-Google-Smtp-Source: AGHT+IF4rSovFL92tiVeoNmP5FW72Wgm2iOpb/wwZFrycgcomuo9wT0IlSjS9+PtPLBPjoTIr73RgtmsgZ6scrTwal4=
X-Received: by 2002:a05:6122:54b:b0:520:4996:7cf2 with SMTP id
 71dfb90a1353d-523e417412amr6593147e0c.10.1741553075580; Sun, 09 Mar 2025
 13:44:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307120141.1566673-1-qun-wei.lin@mediatek.com>
 <20250307120141.1566673-3-qun-wei.lin@mediatek.com> <CAGsJ_4xtp9iGPQinu5DOi3R2B47X9o=wS94GdhdY-0JUATf5hw@mail.gmail.com>
 <CAKEwX=OP9PJ9YeUvy3ZMQPByH7ELHLDfeLuuYKvPy3aCQCAJwQ@mail.gmail.com>
 <20250309010541.3152-1-hdanton@sina.com> <CAKEwX=Mwh9SKWfmaS9q4fym7L-v5m6GmvJrQF8eFizJJd904rA@mail.gmail.com>
In-Reply-To: <CAKEwX=Mwh9SKWfmaS9q4fym7L-v5m6GmvJrQF8eFizJJd904rA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Mon, 10 Mar 2025 09:44:24 +1300
X-Gm-Features: AQ5f1JrAaeOU1N8syinZxuUc9DAB-NUSYostf2nwMh6oACAXHjD8P521aBmLDzY
Message-ID: <CAGsJ_4wFfqFZQw-TOM83gUEV_rN6uio1sujXdjCRKTOipPM2SQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] kcompressd: Add Kcompressd for accelerated zram compression
To: Nhat Pham <nphamcs@gmail.com>
Cc: Hillf Danton <hdanton@sina.com>, Qun-Wei Lin <qun-wei.lin@mediatek.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 8:56=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> wrote=
:
>
> On Sat, Mar 8, 2025 at 5:05=E2=80=AFPM Hillf Danton <hdanton@sina.com> wr=
ote:
> >
> > Could you explain what nr_kcompressd means, Qun-Wei, to quiesce barking=
 lads?
>
> Who's the "barking lads" you are referring to? Please mind your language.

I also feel extremely uncomfortable. In Eastern culture, this is an extreme=
ly
vulgar word, more offensive than any others.

I strongly feel that this violates the mutual respect within the Linux
community. This is a serious case of verbal abuse.

Regardless of the existence of nr_kcompressd, it is still unacceptable to
invent an interface that requires users to figure out how to set it up, whi=
le
kswapd can launch threads based on NUMA nodes.
This should be transparent to users, just as kswapd does.

void __meminit kswapd_run(int nid)

{
        ...
        if (!pgdat->kswapd) {
                pgdat->kswapd =3D kthread_create_on_node(kswapd, pgdat,
nid, "kswapd%d", nid);
                ...
        }
        pgdat_kswapd_unlock(pgdat);
}

On the other hand, no one will know how to set up the proper number of
threads, while direct reclaim can utilize each CPU.

Therefore, listing nr_kcompressd does not change the essence of my
question.

Thanks
Barry

