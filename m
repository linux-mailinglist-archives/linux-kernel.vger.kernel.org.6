Return-Path: <linux-kernel+bounces-374601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A0F79A6D2F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 16:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58D4D1C22175
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Oct 2024 14:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 878831F9A85;
	Mon, 21 Oct 2024 14:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mQWXs5E3"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 223C41F12FC
	for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729522413; cv=none; b=uSrRhjgtNrlBGYZB1909mHVopsejC3pu6TQz/s1id/ffsWhRQd00uNvEOXyZG/jk25JRc+gbjefNrp7tVallilkdkBq1MMd3PnbVpebV1JbKtK1MAVyduwkg/nQYOMpS+nCs4lDKK3OV92wRKJCAuQB5WpE4fBA3xHqAdeETR18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729522413; c=relaxed/simple;
	bh=XIAbw4mxYc8pAF/lqCTTYZZ/MSMJKjfurf0D1Q6b47Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J7dhK+X0aQ7jha3TCj4b7h7ePaA9F4V9JooH12hl+3h3ZGkZcAUxBRsld/EFxkFdfwbKrqB9TX3s6tLFs+RzAlIgVsDG/HX9BRf03gyC4Uc+GovIsDMlyp6sMVN20qKweh/yAG7kvRW4Q0ewk5i6I1AJ6HHanQXUM+5VMzEiPDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mQWXs5E3; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20ca4877690so212025ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Oct 2024 07:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1729522411; x=1730127211; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3gG9duuhy1290ypGByuvBv1xo4Px7j5a02oLYF4PH1s=;
        b=mQWXs5E3+XMqqOe2b426v1nalxbcnACtqEm7doLKZ/Ut7OafeitcUjkkKzrpmdt274
         PSy/s8w+NLtXMnAJe2jWqYRZq+MeXy7K9H10ymnDrMgjKOhLiDx+4rF9qoFSf1RKsyeN
         kIPu+Fyxm7MwDoRA4pVAypBXykMsy3dYGKVB33TnonZwycQOz/diIhmSFHZBywrRT/SB
         EU+ibaQD42euJMbp4BtbRmeO93HTV0EUjK22ayWpAwpL+8TKzlaekFUoBBQGRzqcR1/S
         Ui+P6/bj0pbavxVKOkbbhws+na9mLg0eRZ5XImFtNY6JeMBnQIE/UIEFscqyNwHbd7dj
         7s3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729522411; x=1730127211;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3gG9duuhy1290ypGByuvBv1xo4Px7j5a02oLYF4PH1s=;
        b=QJiKzqIHgFZwtfULiQKeY0Ojj/cDJp1DwmIFg7HrnObHk7/+mBi8p0U6N5ntXuvBVm
         ipdr0aZa08BZPZwU3axivR6MHG+nSD1ehmGJLT6NgMACXUaOlhDyIdvx1rRwJYl5dxCU
         5WFYl9cR14PjQNwtGkELDqQSDQpDGe8bw0zcM/YKL3yMaLJaIH6isQ6BNZrchs40gPlC
         spmSdWgtGrtrpfC3Hcy8icxrBdxVRk+G8+msskWdm6kyFwdiTzYJT85vXyaUy/T7z99b
         J+Xv5Ptx/r1P99/h6GbU8VzH3mMftbRypsl9FQuJ8ZvrUC+qb4ZkZ4EWwINKUER2AL6O
         My5A==
X-Forwarded-Encrypted: i=1; AJvYcCWoID/1+EN0gXWyczPDA1cfA5p7vXDFe+SUqXnReK6IW5zbtPLg0RaJHn6/8iZL23JqQ/kBTycT7UMgRC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyvzsulx4QBqn75g+SSOr9bOT30sAbOPQLyiU+IoyKgVMqBvXhb
	/g+QsciU8mc49K2KEuTJshJFyjp6QII+UPfyWVzyXHiNOILG13QECnTBpkP3iBhmQCr6squVmG+
	UgRG5HwCrPfH4ATDqv797eZ3PG65APmh3MoUP
X-Google-Smtp-Source: AGHT+IFk4I+l7PDx5NC4E4xF4MG0P4sMRuFqD3K2dFP68wegQRv3ETdMCuzSeOSaEIZrU5k5SKymwi+s+gYa0GYI2H0=
X-Received: by 2002:a17:902:da8d:b0:20c:5cb1:de07 with SMTP id
 d9443c01a7336-20e74264c95mr2671365ad.11.1729522411055; Mon, 21 Oct 2024
 07:53:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241015123157.2337026-1-alexander.usyskin@intel.com> <2024101509-refined-posh-c50d@gregkh>
In-Reply-To: <2024101509-refined-posh-c50d@gregkh>
From: Brian Geffon <bgeffon@google.com>
Date: Mon, 21 Oct 2024 10:52:53 -0400
Message-ID: <CADyq12xj8VckfYO7W5XNf4MSssBTsCSi8gcE5_RmeD+dO5Cg8g@mail.gmail.com>
Subject: Re: [char-misc-next v3] mei: use kvmalloc for read buffer
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexander Usyskin <alexander.usyskin@intel.com>, Oren Weil <oren.jer.weil@intel.com>, 
	Tomas Winkler <tomasw@gmail.com>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Rohit Agarwal <rohiagar@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 15, 2024 at 8:48=E2=80=AFAM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Tue, Oct 15, 2024 at 03:31:57PM +0300, Alexander Usyskin wrote:
> > Read buffer is allocated according to max message size, reported by
> > the firmware and may reach 64K in systems with pxp client.
> > Contiguous 64k allocation may fail under memory pressure.
> > Read buffer is used as in-driver message storage and not required
> > to be contiguous.
> > Use kvmalloc to allow kernel to allocate non-contiguous memory.
> >
> > Fixes: 3030dc056459 ("mei: add wrapper for queuing control commands.")
> > Reported-by: Rohit Agarwal <rohiagar@chromium.org>
> > Closes: https://lore.kernel.org/all/20240813084542.2921300-1-rohiagar@c=
hromium.org/
> > Tested-by: Brian Geffon <bgeffon@google.com>
> > Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Cc: stable@vger.kernel.org

> > ---
>
> Why is this on the -next branch?  You want this merged now, right?
>
> Again, I asked "why hasn't this been reviewed by others at Intel", and
> so I'm just going to delete this series until it has followed the
> correct Intel-internal review process.

This is a significant crash for us, any chance we can get another
reviewer from Intel?

>
> greg k-h

Thanks
Brian

