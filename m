Return-Path: <linux-kernel+bounces-273224-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E46FE946602
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Aug 2024 00:52:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F34D281FEA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Aug 2024 22:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C369139D16;
	Fri,  2 Aug 2024 22:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YurG4tGD"
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B6D1ABEAC
	for <linux-kernel@vger.kernel.org>; Fri,  2 Aug 2024 22:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722639126; cv=none; b=ObNzICRoEOQ6JoqCgUcAWzv7wDf/YGKaovaz2e8fcLU6osgJJgNLCYkMy7dROVrk+aXFnwsz1DdcVMG6q80CtP35oks8A+xqC+W7gqHB7eXicHXoGACNrj307D9JrLuCbTUpKXmXXvOHYZIXM6a/bJwTiUJqfarG3C2rHAEofaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722639126; c=relaxed/simple;
	bh=2NBdn5pSEVPLl8whCwb4HIQAFvHGTvWYzEKGS2RhF/M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=efjAd++LUtBNMqYoEY/MwRpzQCKz2nyaK3M/Tj/NEAwe+K6FrCr2SOZyRryu61r5rYvc/8Q0zo8XiooWla5zy8fHJiTlxvYWZ3Ug+xG5FaCaogMDD+cbwD1MyaS0Fx/7FVgqet1s7AuNnQxV3ehKybzx+Rg4iWPSDb96O8GAcns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YurG4tGD; arc=none smtp.client-ip=209.85.160.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-44fe106616eso46278721cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Aug 2024 15:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722639123; x=1723243923; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2NBdn5pSEVPLl8whCwb4HIQAFvHGTvWYzEKGS2RhF/M=;
        b=YurG4tGDH382obEtT7s8Lf7+ovca0xOAhI3TWeixhaJJCDuoU9tG+961Df8gAvyqkP
         FTQFopwAddOYkDD0Dm1zewC6Z4D3Tjk76FRxhLPPQIRmeruRL6Njq9A3mGy08fThGoZK
         G8MglfP3AaCeUYuNenXuTy5lSzgGe2cixpRxj7Ppir0aJHFHlDIa16ELKeYD5U2JmJJz
         4c5hMRkwL6saLzznWnYq7+/nXyvHVpOwNwsoBZgx10XO41NXG/aCn+MBI/53pd73nRqy
         wolIt5XLrzhEzDRaBnCF6IMR1b9bzWs+dZ6IQyZwjjUDckgnNOwkB7pySINmHQO2rPR8
         dPWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722639123; x=1723243923;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NBdn5pSEVPLl8whCwb4HIQAFvHGTvWYzEKGS2RhF/M=;
        b=NwMeUXhKPRiMeHe0oiY1GoRjrdMhx7ug8Gorh5hhDAlLJvlrH8k3Z19TVFfqx3Dyzi
         mdoFEIruMASRvqj6lPwnjltYFRycQmCPQjuZsqCI7+CgF7SJQ5dS2eRvFHeUTqaoNAXy
         /NKB68FwGR4LAj5AXDYopC4zrlI7yPH0o0L+PuNCr1ulZWoo4rYd5h5HSpuiJnZ29XjF
         tso4YTD/enEKO0/dVAmMTwaO5l+p5YopxTFdyYi6Tp3niyoyuVs5ajuUkxLTSDmhiA61
         YbBKXCl1gsgFLlOTkiopLjHTARZZrvYVq+WM8VrD3a0ctowpgwyQU+NkEzLkBCRoB4re
         H/Sg==
X-Forwarded-Encrypted: i=1; AJvYcCW/WOzfQoihOaxAov3Lnr4hnyMUDN0/W6SAtDlppdHJZgwyf9sVuBhMppXs1aa86Zvc04cGL7xVTO2eHdA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5zo9swGrju9NYRuiobCwuOwO0dktC251i2VbIsNYvoH9dL5lQ
	bgk0wPQqAdpNkeQXv3QBw8Pc6OSNG78k0saxTJcMrI2ytdjE2miFGRL8+fPXgPx0ysv8FdQNZUv
	yEucQdPBp3lcbkQzo5QO3cfKIM7Q=
X-Google-Smtp-Source: AGHT+IECWlxoCooUq8nGSJK+sXxBkj4eVNyHzPkv0rXnnrwTlCOx0Ov3InBy1LOl6nRWg0K/BzycJzDIjy+RCicSV/o=
X-Received: by 2002:a05:6214:5f02:b0:6b7:a182:4130 with SMTP id
 6a1803df08f44-6bb9848bb8cmr52851226d6.49.1722639123278; Fri, 02 Aug 2024
 15:52:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240731004918.33182-1-flintglass@gmail.com> <20240731004918.33182-3-flintglass@gmail.com>
In-Reply-To: <20240731004918.33182-3-flintglass@gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Fri, 2 Aug 2024 15:51:52 -0700
Message-ID: <CAKEwX=NB0MGFy2WxMebd_cZEQ__pcTH5_-LX_M85ti6NyGhmKw@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] mm: zswap: fix global shrinker error handling logic
To: Takero Funaki <flintglass@gmail.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 30, 2024 at 5:49=E2=80=AFPM Takero Funaki <flintglass@gmail.com=
> wrote:
>
> This patch fixes the zswap global shrinker, which did not shrink the
> zpool as expected.
>
> The issue addressed is that shrink_worker() did not distinguish between
> unexpected errors and expected errors, such as failed writeback from an
> empty memcg. The shrinker would stop shrinking after iterating through
> the memcg tree 16 times, even if there was only one empty memcg.
>
> With this patch, the shrinker no longer considers encountering an empty
> memcg, encountering a memcg with writeback disabled, or reaching the end
> of a memcg tree walk as a failure, as long as there are memcgs that are
> candidates for writeback. Systems with one or more empty memcgs will now
> observe significantly higher zswap writeback activity after the zswap
> pool limit is hit.
>
> To avoid an infinite loop when there are no writeback candidates, this
> patch tracks writeback attempts during memcg tree walks and limits
> reties if no writeback candidates are found.
>
> To handle the empty memcg case, the helper function shrink_memcg() is
> modified to check if the memcg is empty and then return -ENOENT.
>
> Fixes: a65b0e7607cc ("zswap: make shrinking memcg-aware")
> Signed-off-by: Takero Funaki <flintglass@gmail.com>

Nice! LGTM FWIW.
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

Thank you so much for working on this, Takero! I look forward to your
other global shrinker fixes :)

