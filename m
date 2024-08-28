Return-Path: <linux-kernel+bounces-305822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA6AF9634DF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 00:36:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7BEE1C242FF
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2024 22:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33BF21AC8AE;
	Wed, 28 Aug 2024 22:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCY5kqq5"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2794F1553A2
	for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 22:36:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724884609; cv=none; b=c6RPyxjYitLXT4YwwbwjqR+SuTq4B2NH2Wj6Lycsyrkw5IWedh8MuzKoUzaZByfORsvz1eBV2YyKvEUm7Q3Jo1hT07nu14AKFQfPELHiaM9fkqLmuZJietMK+PUWi4hL5FGs8yddQvCKAKEDqcQ8B/lRifv0xBUhgCuMB8TGfEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724884609; c=relaxed/simple;
	bh=4zmJBcg3QjuPUeks1/CkV+B2YJEj6cuYa6Hc64ClXvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h1DXkmdEQuxwyjY5QN5dKN0aU1LD5Ahv/4w+lrs9Bd4QGe68LDeNbLNJUFeIs+qGT8w3tA2smFRRQptJOaoniugokcCiiL3lksQQdSZDp7MKQmA/Y92TxysMf8u95ocR1P+qz/oTqearlc1RCRbZw0xKHqNas6vqBuXCjx0Oh3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCY5kqq5; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6c0e22218d0so942377b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 15:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724884607; x=1725489407; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4zmJBcg3QjuPUeks1/CkV+B2YJEj6cuYa6Hc64ClXvI=;
        b=mCY5kqq5fKpIAFhGsHBqo48qCtf/GaoOnV+fU2T3squsVS6aYMfVfYzLb/fl81oQB/
         QovJfHzXCdWy63435agSDpET1Jo/I+ta51C3TDucHoOBeSb6WQcCOwClgPRvDhYoi7EY
         JRf+X+BZ69/8KpgMMzkEXG0iIX/c+hKNuiAYX1DUeEOLQ4BFZhACXocbPA4G/GY0pmvu
         KppEMP7ci8eIjf8adDcBZ/NGwGpgWxJmpZ35Tpfo14RgDd32V1C6cwre3aoqESVc8ahb
         OI7hX7nGlL15lKcXRtJR6uIWfRWugucel4kENTLeBUx/p4Gsqmtjoy4iAEBmliED3Y1o
         MipA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724884607; x=1725489407;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4zmJBcg3QjuPUeks1/CkV+B2YJEj6cuYa6Hc64ClXvI=;
        b=WIsd4mJ7H5v6q/w6KvuMJChqW0tdZr3HIMMd/52n4xCVEd7NFsNXgi+GFSD325gxjc
         ydu52R09Vv3V8R4SjVpI/8ioeDvEYxZe3rqVFIDSQ8qxdMcWrTaTHgvsKRLw1IXXbvD/
         YNgPmNMcxvUsMJLZdw6sjzoHGT4dwTiOTkrFoBeU+jYnST6d9mnlyJHyzh54xB14x9Ra
         nskNcyGg8ipdgvEyXV1oC+yLVUDETL3r2vfPyBat8svVsq1PGvcVqA6h7mht0Eyh2bVw
         fztpz9Zez6J5g+GC0HHHIzZBnVWdhGmZd1aQirA26k2KWl5ABnVlUEmmnalAHrT0E3I6
         XBTg==
X-Forwarded-Encrypted: i=1; AJvYcCUpNKxbOxgjK3bdzUn6dwUbc7ehkE7IkfCiqB4046Qlw67ugjNzeElH21EpHMnZMxp1RCjJUiMGuPymzlg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAkEgekWBKWJwUKfH+NTPzrOi8ECq9A8bIhIqfCorsGblQra3o
	EB78OlBQCpK3v71ICWof2ayWK7Viy1eXQW1IUv1Z56CKJt/uagqSNNtv4UPuUboNp+0sDCAUiDn
	XrK7zmsdo+OmpPK9IcF0mo0+swXk=
X-Google-Smtp-Source: AGHT+IGMPgVRkcE5bmtYUK7c43kRp/lslqYyO2BiFRn0kwgmpLLIxaQlPGlxX68dG/i4pIgHtyKSmHriPMBrGE9NvMg=
X-Received: by 2002:a05:690c:ec5:b0:6b2:28c3:b6fe with SMTP id
 00721157ae682-6d275f27ab5mr8820247b3.2.1724884606869; Wed, 28 Aug 2024
 15:36:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828204251.6642-1-rosenp@gmail.com> <20240828152927.6370bed2@kernel.org>
In-Reply-To: <20240828152927.6370bed2@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 28 Aug 2024 15:36:36 -0700
Message-ID: <CAKxU2N9us=0+b2xRJs_Y1SKx8rF=d6XmwTom9oQvBucH5=cYUA@mail.gmail.com>
Subject: Re: [PATCH net-next] net: ag71xx: update FIFO bits and descriptions
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	linux@armlinux.org.uk, linux-kernel@vger.kernel.org, o.rempel@pengutronix.de, 
	p.zabel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 3:29=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 28 Aug 2024 13:42:49 -0700 Rosen Penev wrote:
> > Taken from QCA SDK. No functional difference as same bits get applied.
>
> Are these used? Would be nice to heave your best guess on the impact
> this change will have in the commit message, for posterity scanning
> git logs a few months/years from now.
No impact. It's effectively a documentation fix.

I see ag71xx_wr(ag, AG71XX_REG_FIFO_CFG5, FIFO_CFG5_INIT); so yes, they're =
used.
>
> BTW missing CC netdev, feel free to resend without 24h wait.
That's embarrassing. Will do.

