Return-Path: <linux-kernel+bounces-555450-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6177A5B798
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 04:57:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 536043A906B
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Mar 2025 03:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70461E9B22;
	Tue, 11 Mar 2025 03:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1j6JDZh"
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCAA1DFE22
	for <linux-kernel@vger.kernel.org>; Tue, 11 Mar 2025 03:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741665453; cv=none; b=dpkjrddkamZyO3inVARFyzVvQIdbJSaGDwfxgUnWPBAGWuos0wv3FDHt3jTI/eVAuqihsqv7pcy9I9SA0R9VOQu7bkPhvn3Y6w41Ic8GYFxI6Y/2Xys7HirNSwqdKAxkT+m9DR+ru2IgwvMbuGOQhLniGcdhQhReseuizvymLBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741665453; c=relaxed/simple;
	bh=W+N8kXulNIFbsJLvD8LxdlMfbl4vEIuxSMS4AaYsVDQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y+4MoIizLPvdITz7JIs7TT/2Vm2jn/ieDdGWGhXe/KT0mouW0sfAWpfeZbLbbsy49G+yNfbJ0rSFvr/VLkegONYCM2lUID0yNqlthVPmvtX4SnQ93B8PTFiud2oXb8qroS6hTVCU3R+MCopbvKbPfjGcJ2nVZFeTbtGy6D3R7UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1j6JDZh; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-6e900a7ce55so54434636d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Mar 2025 20:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741665450; x=1742270250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W+N8kXulNIFbsJLvD8LxdlMfbl4vEIuxSMS4AaYsVDQ=;
        b=f1j6JDZh4haxdJmfmSz2g5U0eUSbzlyxMp2RWVnyVi5y0IqWV5rsGAijPXiPzVJMx5
         cz/SO2P8HZu7Qos1SkaNlpcrI0vI8GF6SMulS1AaChDNjOKf3XGHYG3KBDO95fGrV4/t
         S3YdB/64WeUTVScGPy/oetorIvqZNja/OqPyCxShzKDM4mWUPLwdg+mX7YZW4AyRITGp
         /7l8b0oAnJjs4CKqGDAWQlnZQsZFP8AFAd3WIpe9mYao8b22sWCOoxixiyOQkfBis5SO
         pYmrA6v3KbyN3cK+LFm4iC3OAHQbkYkXRyP4RaVISdZ5wv8oEhVBec88tWNcfcTOmjhk
         2/yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741665450; x=1742270250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W+N8kXulNIFbsJLvD8LxdlMfbl4vEIuxSMS4AaYsVDQ=;
        b=Oog38eWczJc56OGCTfpUlxXdyU1bRph0zJlc/P+hLdBE6FuR1Bs4d2DbjHlVMApVdx
         FFtqt/cQKxczpYYr/2L1ZHlKLAi+Opfo20qrcYlI25dRUhwxbQNqUhhcEWrdMdUw2HjT
         XnmhSMAGuNNAQHjKJt+HorUOqm5ReKXkX1vTglMg87E/J+gboRUy5Zq+i67rrjyTr0Bi
         Kp3UHTO+/zhOMlYoL85EjpcQdKBLET1Yck4X7xicN21mKb06fklQhtgJOPe0k33H+cKg
         TbBzSAmWLlm6Uyz9fMKbyD9kAYywq5XgK+EFBo+G9OfhMjWtJHrW9S0cTGitX3raq2Ee
         Z5sg==
X-Forwarded-Encrypted: i=1; AJvYcCVgGTAFM84ckOsyzXWaCoGkp29YIr6/S3OBWB7XjkkpZCCaOEhnP7t5TVpDD8FFiuMnFnvqEkPc8DMvJYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJQodGUMs83z1IHqVXMix7f+QH45qCHBlS9R1nUvrm50QOshxU
	0TLMjDJ1Z+uTJx90kQVP5u/PdzgsspIqNfOPN2QCy4UwPLtCKt+r+1hmrPaCuS2Fmm8/FFnpkKA
	PrOTkLYmpapIcYZN7iSfMZ1sVt6A=
X-Gm-Gg: ASbGncsruaZZQyXT2hbqSxXJxCa5JCqJD6asG1Wp/HaWUYV25mSmDA0VhrwDeRiUzxq
	zUsV3fJ+4Qmgu3hjEkZfAQ9udz4lF2CzRm8rYcOU0ClK/oxBiw/pZCXo/CBIDkAC6RILbi2J/dG
	dLb9/YabAAjOA1g5oiCFAXVp5h/w==
X-Google-Smtp-Source: AGHT+IEnhfWh6D8CLExREK9YoL/TlPwdlu8rlbx3bjE8x9VCkLeq1sXtjhIMZOhr7hrz9/A9PZS9WGTdRmaLJbCkzA4=
X-Received: by 2002:a05:6214:2584:b0:6d4:c6d:17fe with SMTP id
 6a1803df08f44-6e900653c36mr229986456d6.25.1741665450365; Mon, 10 Mar 2025
 20:57:30 -0700 (PDT)
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
 <CAGsJ_4wFfqFZQw-TOM83gUEV_rN6uio1sujXdjCRKTOipPM2SQ@mail.gmail.com>
 <20250310103427.3216-1-hdanton@sina.com> <CAGsJ_4w8cFgdPmHH5KLeKoEEVN1LT4-z0sX_2vtV5sc7yOQb8g@mail.gmail.com>
 <20250310230902.3282-1-hdanton@sina.com>
In-Reply-To: <20250310230902.3282-1-hdanton@sina.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 11 Mar 2025 16:57:19 +1300
X-Gm-Features: AQ5f1Jpv1ZYYivgTuzN9wvY2eSB8ZdmdVZTpZTfJ_9GyIrV1Ji_17E-GIFAUxQA
Message-ID: <CAGsJ_4xFxLxX0=DrbiO3Mi5yCjCfZiDuJrbhTEra=rOnrD-W7A@mail.gmail.com>
Subject: Re: [PATCH 2/2] kcompressd: Add Kcompressd for accelerated zram compression
To: conduct@kernel.org
Cc: Nhat Pham <nphamcs@gmail.com>, Hillf Danton <hdanton@sina.com>, 
	Qun-Wei Lin <qun-wei.lin@mediatek.com>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 12:09=E2=80=AFPM Hillf Danton <hdanton@sina.com> wr=
ote:
>
> On Tue, 11 Mar 2025 01:44:27 +0800 Barry Song <21cnbao@gmail.com>
> > On Mon, Mar 10, 2025 at 6:34=E2=80=AFPM Hillf Danton <hdanton@sina.com>=
 wrote:
> > > On Mon, 10 Mar 2025 09:44:24 +1300 Barry Song <21cnbao@gmail.com>
> > > > I also feel extremely uncomfortable. In Eastern culture, this is an=
 extremely
> > > > vulgar word, more offensive than any others.
> > > >
> > > If culture is not abused, feel free to show us how it is defined to b=
e
> > > more offensive than any others in Eastern culture.
> > >
> > Having no manners is not your fault. The ignorant fear nothing.
> >
> Oh lad, just tell us anything true. It is not difficult.

+Code of conduct.

I know there is already a ban for this person in another thread [1],
but I am also
officially requesting an additional ban. Having contributed to the
Linux kernel for
over 15+ years, both professionally and out of personal interest, I have ne=
ver
encountered a developer who engages in random and irrational personal
attacks[2] and persistently did this despite clear requests to stop. This i=
s
utterly bizarre.

Please give serious consideration to extending this guy=E2=80=99s ban on a
case-by-case basis.

[1] https://lore.kernel.org/all/67cf7499597e9_1198729450@dwillia2-xfh.jf.in=
tel.com.notmuch/
[2] https://lore.kernel.org/all/20250309010541.3152-1-hdanton@sina.com/

Thanks
Barry

