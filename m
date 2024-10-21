Return-Path: <linux-kernel+bounces-375013-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 862839A73C6
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 21:24:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38CA91F21650
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 19:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADA91FBC88;
	Mon, 21 Oct 2024 19:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K3Mc4KPa"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52371CF7A6
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 19:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729538644; cv=none; b=fHeEjO5Ie0Czc3I8s82WMXVaEr/BCp+jWX7Rv9qTioDsjgV49iApHOFeBK0fWGV46kmSHvOyxXtN5Q1vTEIbZ6FXuEo7UyqlpQrnBsL3aHy5Hwj5l6ByeBqQ8CnxK5rYKQATfWDUfSEac66s0HKFOjQG8EsJac8TjF2Ebqvu9IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729538644; c=relaxed/simple;
	bh=f3FOaSwIPruhb+SlwowJzP27StIei3zqpQRh82uyKs4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rubNc031syTg8GSu2r7iGSbijE/ytsVRrNVfJShakZEtbSy18dOgMg2MMYZ1Nv6vPaF0rWW8OjJuRMZBH/aIMkOKF0AQ0hPCvS4cMOV4ow39yxjHrhXIuzf+lPD4/X3IA8B2rMZchwOjg5DjmHWzRaHm7LpP9iiDYmtmbT31jxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K3Mc4KPa; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-539fe76e802so5601560e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 12:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729538641; x=1730143441; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f3FOaSwIPruhb+SlwowJzP27StIei3zqpQRh82uyKs4=;
        b=K3Mc4KPagRVjySxT9sxPigJ4cQydp03rp+p1GomJCN89urbXQ8Nz4/gjw7VD1Ll2Oy
         L9arl5+yolZPcOGEUFecxgYawVGYHg2dRBLyCcP/dY6VPEu1Vsx8B6/o8CNUI4JQTG+i
         wZI3WhLF6+3YP674IcT1cuv00wbrAwf42sdJ15hoHBCiIidoUqekTngel01atxac1Inq
         6rYvyNkvHcC4p6+s3UZplnyWkYblPN3UbkYvofLeiYAdjPnmJqw4jT2aProx0C5fWjCJ
         WHIVO8MEMLcON+4I+SSGJIASaV8Y8+0Js93gseiLYlB0i8inp9yl8x0H/PUYtruISyA1
         lKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729538641; x=1730143441;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f3FOaSwIPruhb+SlwowJzP27StIei3zqpQRh82uyKs4=;
        b=T+YJy/KZpqTH9elGtUBvkX8vhHTR7V8sfmM1cqMiUTFpy/rvWg+ziWhWP02yF/UXtn
         Fm14+fqqKK03EfBJjjlJK2jYx5Bt0Fa6Tfqa9YbRPXDk1M1xvEK/yGRetBMr370DJIXD
         IckFDzHkWDeoGKBjcpu6k8bLIDjinDzvKdp8xNdeTErpJ+u9amhMf5KCDyo+jFH5ckZH
         LizcgiSXl5/Yvp7qRDGF5XHSoRlytJ6AXPO+lLU47F/YgXxzG2090LjR1FWDT6SAWauf
         APlb2UtNfpmo7GINDW7FbM+10OphbNgWFHyOyVy87LDwCFjJU9gj8I65T65+K/MiNPaP
         dOrA==
X-Forwarded-Encrypted: i=1; AJvYcCVADk3gX1eLF1tSSoEpunxv23Edg1N12XHogc120JcAIdT7KunkVOSADnEYg8tHHrlyTro0D9E7EqqIYW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxI1/IAF49wAJk5oZmjMNHjXxm2vIBUHRTiuYuHkqZjW0Oydv+/
	0p2rELP4lkcxY6NQ998tgYZ7yCkuELbwlgIDIkWbQANFbdDFp7FUSl5I3A3Rj6T+q6peNLIrsA7
	zs1vPla+uXOyn1WVVqaflXM94W+K3EW+jOHag
X-Google-Smtp-Source: AGHT+IFRh1XbNg+j/0ewusaGewVZkzNsIsMX6w9/LexlTO/szwAeGbvnPYVeCPp13s4+dp9CMTE3gxCPLcyFJ7YCXQY=
X-Received: by 2002:a05:6512:2803:b0:536:54fd:275b with SMTP id
 2adb3069b0e04-53a155088cfmr5843319e87.54.1729538640575; Mon, 21 Oct 2024
 12:24:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021182821.1259487-1-dualli@chromium.org> <20241021182821.1259487-2-dualli@chromium.org>
 <CA+xfxX5ygyuaSwP7y-jEWqMLAYR6vP_Wg0CBJb+TcL1nsDJQ-Q@mail.gmail.com> <2024102102-much-doormat-cba1@gregkh>
In-Reply-To: <2024102102-much-doormat-cba1@gregkh>
From: Li Li <dualli@google.com>
Date: Mon, 21 Oct 2024 12:23:48 -0700
Message-ID: <CA+xfxX5UiQuTLnNqXuJvz8geB-K31_6QfSffn5LeXmSiQeM4gw@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] binder: report txn errors via generic netlink
To: Greg KH <gregkh@linuxfoundation.org>
Cc: corbet@lwn.net, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, donald.hunter@gmail.com, arve@android.com, 
	tkjos@android.com, maco@android.com, joel@joelfernandes.org, 
	brauner@kernel.org, cmllamas@google.com, surenb@google.com, arnd@arndb.de, 
	masahiroy@kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	netdev@vger.kernel.org, hridya@google.com, smoreland@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 11:56=E2=80=AFAM Greg KH <gregkh@linuxfoundation.or=
g> wrote:
>
> On Mon, Oct 21, 2024 at 11:35:57AM -0700, Li Li wrote:
> > Sorry, please ignore this outdated and duplicated patch [1/1]. The
> > correct one is
> >
> > https://lore.kernel.org/lkml/20241021182821.1259487-1-dualli@chromium.o=
rg/T/#m5f8d7ed4333ab4dc7f08932c01bb413e540e007a
>
> Please send a v4 in a day or so when it's fixed up, as our tools can't
> figure this out (and neither can I manually...)
>

Fixed and sent v4 (link below). Thank you very much!

https://lore.kernel.org/lkml/20241021191233.1334897-1-dualli@chromium.org/

