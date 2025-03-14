Return-Path: <linux-kernel+bounces-560848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02D81A60A1F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 08:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 512243AABCC
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Mar 2025 07:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0989A170A2C;
	Fri, 14 Mar 2025 07:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="I6/IAGae"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C35113B592
	for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 07:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741937748; cv=none; b=qmLsgclZ4JA7nOxCRln12pIIFNgPmQIcR9g21UlP8GlVEv2bQoHBMr3//Xlp5p2idCviVI9k/+lQSuoDrClIsOKXEJ7QNSQ9TkHlbJmVOIHAxDlinFbIsnGyqACjO7KQHJnYfiZS0BCQUrneYj1uydtvnMzVbyBpPbcOxJbP07o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741937748; c=relaxed/simple;
	bh=BKb0+8vbrDMdWpSZOZ73KCKfNl8XpBBpEuDQ9z5rALw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=e5BHvFFpnubPlBmhsosOBVuvD2u1t5GI+wcjcxUj8959oTuqedqr6VzSB2c1X12NC3C1eB2BtI+T0q1EfB5HNVjKBNWj3QeW2UrEPER6tzf7WAOUHs17K0zWba7apsjrElV7zLrDQxHVTn8/Ru1BWtFQHW8kZ2Jls0HRSf+oJng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=I6/IAGae; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-ac25313ea37so358690266b.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Mar 2025 00:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1741937744; x=1742542544; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FlmZlv3M6KwRa5lk0ty8uEbkHF2GhMIuGONmyl2bBXA=;
        b=I6/IAGaeyPtBaATs3VlQLZr+SnH5okpTNDCtjYmKqBkGyar4nuQRUM/zqZ8bXcT3VU
         /BfL726sZFIw3uiK1+EKyC+nFNfpQxe5lVhfj1q7jSO9pYho6l5zCiYieh4vuli/bVlU
         JZ+R6xJeGHwSFm23BBDynQDpeOhSELZnXBWinxAyTPFvc1uXdPcIU92uVqQHXaCEPUsC
         NgrYQgPLxBig2Sjv9NR4+nE5wYeFHr5gqN5eB7ihr90URGWcZtn+iMxaddMuEWCSbREX
         /9bQgRvowPkY7gPJOeyn2jTIhCqH0byCZxHgPk00nqXJsn6jgkK6PWJDLxAkodEuUExa
         SLuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741937744; x=1742542544;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FlmZlv3M6KwRa5lk0ty8uEbkHF2GhMIuGONmyl2bBXA=;
        b=Jj7sCSkvWROuaFoAI2vMqn/UFD0vG4pciXTEsk4Q7nam3OYFgI/Oo5iIsUzJ8/4atK
         BuIFzqwNdg8SRm6HVnlfJn8V6yTjNE/NYOdqmnAfdnGHx3lrEDdtX4c3hOX+w5dNPkRv
         tVcS3dCP7a9PYOoVpv/lFdRunoznjdaxzN/gMj+uqkX3dSHAr+jYiS5wWepnHE/u04Pp
         3sQUnFXHMZ5wH26nhslPk0OAPBcF164/hsVn1ieybeo6sPe9dBkFl5QW2TdfMytfRckI
         NqenuwAlo2JjRDtnxRxJLbAK8SZ/++tWTRKWWJzZtS/DWokze4T1xl1hG9m/RJNpFq3U
         FjnA==
X-Forwarded-Encrypted: i=1; AJvYcCXXY1hFA6pU5pbr+47q/RW5VekHjuDzTi9V6TcPrbaJaKgFuAm+f6njZdzJDO/o+AgV/exdAax+X3dTVhc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3zKLVK2XuMnPAfyXQSQmu5a99Swz5POenIsPGHj0VkuMZryIJ
	m8T2WiB+NEz5Fto6A8bs4huOTtEPmQ45J+hUZbwq1ufU04pvvPh2Je2KoOMWLP1rC6RmcJ0Kegp
	w98m3HfhpEFyQt6SIkJ7NDEoG4FJi03z1nj6/iXaMMAtkNJLP
X-Gm-Gg: ASbGncu9wmGbkGwUBAGQwXw66AZsJfv1iy8k5pKTqqUd/hDsKWgBXHVTp3qT7hSz6p1
	5DbecEQF28X5q9BSYpjupho15GFE1BROqpjVZlcV3f/j+z0EgnTN/bnZI3860mK5jWLzzCUOgW1
	q6eZpEDvsiWFkdt46iwJO5Ehp+ThPLHncvoLZqCbfLhBxIGr9Lr+tjAec=
X-Google-Smtp-Source: AGHT+IE7Xaa46SPAaXON+whlmQwGK4hrFPmRNmw/cKo9nkMuQI2CfRhnfIk0Y82sVcmMcd8X/iKP//nfd54dSp/6HqQ=
X-Received: by 2002:a17:907:2dac:b0:abf:7b38:7e64 with SMTP id
 a640c23a62f3a-ac330396bccmr157332166b.43.1741937744629; Fri, 14 Mar 2025
 00:35:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250228123602.2140459-1-max.kellermann@ionos.com>
In-Reply-To: <20250228123602.2140459-1-max.kellermann@ionos.com>
From: Max Kellermann <max.kellermann@ionos.com>
Date: Fri, 14 Mar 2025 08:35:33 +0100
X-Gm-Features: AQ5f1Jpirsc84DWFiXiiJv-4Da16R-ZlTaCwBS8wuRISQWEDlmmeBRkTXeg9pmA
Message-ID: <CAKPOu+8XzPixswU9srF=DK=MkE9tUhHtVxAwwA-xq=NAo9Ljjw@mail.gmail.com>
Subject: Re: [PATCH] fs/netfs/write_collect: call `invalidate_cache` only if implemented
To: dhowells@redhat.com, netfs@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 28, 2025 at 1:36=E2=80=AFPM Max Kellermann <max.kellermann@iono=
s.com> wrote:
>
> Many filesystems such as NFS and Ceph do not implement the
> `invalidate_cache` method.  On those filesystems, if writing to the
> cache (`NETFS_WRITE_TO_CACHE`) fails for some reason, the kernel
> crashes like this:

David, it's been more than two weeks - please don't forget this patch.
It's yet another netfs crash bug fix.

