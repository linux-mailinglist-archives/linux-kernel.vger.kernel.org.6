Return-Path: <linux-kernel+bounces-554828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BF8BA59FEE
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 18:44:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C2D831716FC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Mar 2025 17:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D806C2309B6;
	Mon, 10 Mar 2025 17:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITOIvOr4"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C052C170A11
	for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628682; cv=none; b=EYd5OidbzVsqsNFHpdeJ4JzHpAjRD+Gcrkw2bTkFfIO4rxcXFdw44kePZB0hfVXgTXZDTI7VSsN+V/wVUd6sDzD3USKguaoXcCq7EfS7J5xKHMFzCEyro4ifk5v8zrlyNDU+OzBCd5+r0Zxp2N8R44VSbsPOakrlxEcCskVKvd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628682; c=relaxed/simple;
	bh=3bnVtbQKA+eJIBQe62QtqMUgw+EBxSQIwfxrLO2zCKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+tNRElT8CvguJlB8YvtZ+Qa+bcd1dt1HFRpG5y+wMK6NsC0uNl43+5hsDfIZ7pUIATe8aEiWyny1XMF4SCe1ququMGnXdTONk2KeKA6lw1jXmV9Lhjq5cPnUq27mUIbz8MGwpJ5itL2kWs3QUBE5Xgmu/xgDteMX6E2ODqbxnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITOIvOr4; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-868da0af0fcso1952308241.2
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 10:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741628679; x=1742233479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3bnVtbQKA+eJIBQe62QtqMUgw+EBxSQIwfxrLO2zCKM=;
        b=ITOIvOr4Fq9vwaHOcU/D0R5WOZ2qEX2XF3PewtvqKor53RUH4Yte9xQjf15Y2h9C7v
         rMV9vuno/cSeW2wnBOlud9KbdovgPA0e50dBaDVyfkxDEAfgv7r4Z4kf/UB2O+nchwVo
         4JFqMp9cNVu9RdOTfkw+M0lalDvLXplzot2/inRluZvYtLBZYPppkPc9j12/eW1kPlw0
         PsfJWNbXNO3m1JqM/XfZY1u8szYGdtWnPgZZP9bQGGuVr5HYcHfM+lPtMxihllzyeCQ+
         TWz0GBEq+6vjHy9dA8Kc0QPcCfJuShKeQX83BB2Hjtyk5lO0lEiM5wP5VVVoRKvChgH5
         jfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741628679; x=1742233479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3bnVtbQKA+eJIBQe62QtqMUgw+EBxSQIwfxrLO2zCKM=;
        b=N+H2mpu7TseepKYwNrHTo6HUSSMoRdtwyEOrKuQccv6TmhwKEpsPwOPPCZkupnj6pv
         /dbWxGbyTFXuYEkJnxwsMEu/04Qp4+6+8aJRCOsLmLDxQfXzq8zuSU2qFa+inA7GoAeT
         iUUCDDzQlppdYeT/e2+VYUzFWjOn4XHAKExqIFtNzxzWTEhcWBFwUh19KGr9HNT64EJs
         Uwf0j1ftQmq9JYtRBt61Ee21fYEGqbAg0u2A6WKqSgZqEPs1BqFWfxTXSm9rrgOkfp03
         goTqpoaarCDLRQrDOItnW+H09HYQJDDC5VuBA/cAvx2voSts2wskfTkyhh+YQv44r2q6
         tklA==
X-Forwarded-Encrypted: i=1; AJvYcCXL1gZCNQ4qDmq2yOO2sUdR+jjfh0bsHDxdOODROkQ4m9B76JG1QqReD9G+o1lwZG3AP7gg2URJq7ST/CE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwIf96kbbgMdmafi+tCH2kk6uu4gjogzCMrdhyT/CgdjrOHK+Go
	bpNy0wrH+TSOJz9q4EJo7vBqLAYq6tn1pQ6j5rkFD2SCpNybQU477aQbhU6WJxQ/a47d4mzknuj
	DVBGjVY4JBm6TuQR8vQnixn6ctYU=
X-Gm-Gg: ASbGnctMn6jNf1aNGMqTa+tlfc+VMtlziqZ0vy7KGzkBYhIVWubIoOOITmoFc+bfY//
	EgtiS9i8rVPcvlKD0a6WnBl4EYoVcnKcO9/IW2KRiPGn0eZTkd059P8vWlZuKejP0Z68ZG9xnro
	7ymDxRGovRXQ51HT56TcvqUjnmbQ==
X-Google-Smtp-Source: AGHT+IET+ztdNIyn3BAmreQQi/+OI1ix6Rn6jXz3YWGIcAghLRFOkbK8UtZ1Dfu2i/qu/mHqzZwep1NY2xW7zH25BCQ=
X-Received: by 2002:a05:6102:3a0b:b0:4c1:99bf:5c00 with SMTP id
 ada2fe7eead31-4c30a734c24mr7714997137.25.1741628679502; Mon, 10 Mar 2025
 10:44:39 -0700 (PDT)
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
 <CAGsJ_4wFfqFZQw-TOM83gUEV_rN6uio1sujXdjCRKTOipPM2SQ@mail.gmail.com> <20250310103427.3216-1-hdanton@sina.com>
In-Reply-To: <20250310103427.3216-1-hdanton@sina.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 11 Mar 2025 01:44:27 +0800
X-Gm-Features: AQ5f1JoaBkbKvDsl4oC9djqzKN-ukBPYCjCJP7uyROF8YcthE3QJ47u8nneGo6Q
Message-ID: <CAGsJ_4w8cFgdPmHH5KLeKoEEVN1LT4-z0sX_2vtV5sc7yOQb8g@mail.gmail.com>
Subject: Re: [PATCH 2/2] kcompressd: Add Kcompressd for accelerated zram compression
To: Hillf Danton <hdanton@sina.com>
Cc: Nhat Pham <nphamcs@gmail.com>, Qun-Wei Lin <qun-wei.lin@mediatek.com>, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2025 at 6:34=E2=80=AFPM Hillf Danton <hdanton@sina.com> wro=
te:
>
> On Mon, 10 Mar 2025 09:44:24 +1300 Barry Song <21cnbao@gmail.com>
> > I also feel extremely uncomfortable. In Eastern culture, this is an ext=
remely
> > vulgar word, more offensive than any others.
> >
> If culture is not abused, feel free to show us how it is defined to be
> more offensive than any others in Eastern culture.
>

Having no manners is not your fault. The ignorant fear nothing.

> > I strongly feel that this violates the mutual respect within the Linux
> > community. This is a serious case of verbal abuse.
> >
> You will feel better I think after proving that your patch/comment is
> able to escape standing ovation, given respect is not free, lad.

It won't happen. A snake won't stop biting just because humans have
fed it.

I believe replying to you will only fuel your excitement, so this will be
the last email I ever respond to. Kindly do not reply.

Thanks
Barry

