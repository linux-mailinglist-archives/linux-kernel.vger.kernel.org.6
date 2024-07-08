Return-Path: <linux-kernel+bounces-243930-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A26E0929C8C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 08:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D3A2280DF2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jul 2024 06:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82731862A;
	Mon,  8 Jul 2024 06:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cqYXGThg"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA9219470
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jul 2024 06:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720421713; cv=none; b=Ehj25BF3wk8oFP+JT3IaqwBrzPTpVSp2aNuKiLHY/1OlQo9IFI5swD6M3LFowkfoc3+qvpSo6ChIHkJ9OyqWRWxVlAo9/+69wG4kVzN6/f4qHCv/EKzqb1cGEjsCxs7M6cIKzX/d/U5pliZpSaJvJrKRsdPY8pALJtShzyyKrQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720421713; c=relaxed/simple;
	bh=gMa1AnG73phwoi1O9zSXqiYTQMB/Zb8kbkt5rz+/6DE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aVNEp9VPCHJF3eSEdm6C++fdPuv21gDQqwjfmyQvNvXsoCnexr//pwyNKRhXZtdTbeBt1MdD8gxuNqkAa1Z3g5MKe6DWISaDS3Qii8KQO7SghfAR5U1BDgYwBfb75rudoCj/TciQKyoIgp+4PLhvgVhS7R1x8lVWTvHlWJI+Dj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cqYXGThg; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42666b89057so27225e9.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jul 2024 23:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720421710; x=1721026510; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=9dKihFJHBQH2LQzDK9e9Ag8pP7Kbhb37n4OfA5zMJnE=;
        b=cqYXGThgNyFRHid0Q0nRrOrXxHLHUUPwdgAuq3ElwqgnpOCRWG98dKtsjOtGMdykzW
         nnL3NgCMF8Fy5THOmJGQbw7GTGlr/JbTdHmo6H8KyAo9MoDxLJlg67qLdbkuUbBUoOgL
         2cbAn9Z4H4MnzROLqHAf7PUD6K8Y5U9OBP9VWxN4xBBaiiuURD2AyDzp9kUdESC2R1eh
         EtVeXjLGzgnA610SsxdzCwwgQL830jNFwdupwSX8+YySmom2Y/x1p3bj3CJbPb3p+ayQ
         GLdpk4PZ48pIaHg4DHKeB+8TcVff/spKvFugGi8OhklPMdOBJYMj84B9crMyWyvH1XfE
         Erhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720421710; x=1721026510;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9dKihFJHBQH2LQzDK9e9Ag8pP7Kbhb37n4OfA5zMJnE=;
        b=u6I69ENXCa5dBGOdBJbwIO727BoKhkQV5oUfLSGoMO2JtNjtIB9Enps+G37fo5ufA/
         UNuQSoSXzI3pdJXAw8XeKUIWa/6AxwMLBXuOdEX6HVe8ey74483J1pXnWSfFXNe3bzju
         Wm/WJWDCwjFcwH82QskTEBhovm6v53wd11G94279LDP1SRDmePn9LfqCsWH8i6+thd8I
         Uyn8wmnddDUkrp3VyBhye2zUYssiS+VqIPKygimifwXTZ4bD7dVbXNMlnJ6b95PtLG2G
         GwcLwPdpjnTj/VsXHeC/LUGvraHAR0T4ssQFq53nOErwZ2Zz2twy7/g5vChVzVLNsCo1
         iH7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXvTrDMRhC6j9UbO/0GWRlsX7xgxG3LZ+fl2jS6oNaiOZ8wHWAkw3NcjaPF9mmtp0hio8lJU29Z/DzPQ7gBDAZcOmOYVZnw/5NPZL8E
X-Gm-Message-State: AOJu0YzUFFr3MqhgREZ3wHkb45hH/mqe1zbzMHN7Af9X4pKsrKG8cgkD
	6BIkv6yMqQnms3/LhmLuBBM2xc09sw33BzDVg3/rDTZnLUc+foZLcBMSDKpvTDanAoeV/sj2MOu
	/rAFEfSLMET5w6FP78dJep25SA2QokaHQ78IL
X-Google-Smtp-Source: AGHT+IFzE0MPudZsChYf45D5gI2oMz4/GllXHmTshHhW8Z3byNHJpVQJhhEw9gGlaRpCEoWZQolwNdVRB2+kKaoORCs=
X-Received: by 2002:a05:600c:4687:b0:426:5d89:896d with SMTP id
 5b1f17b1804b1-4265d898b4amr2397475e9.1.1720421709782; Sun, 07 Jul 2024
 23:55:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACT4Y+ZWjUE6-q1YF=ZaPjKgGZBw4JLD1v2DphSgCAVf1RzE8g@mail.gmail.com>
 <20240705135250.3587041-1-lizhi.xu@windriver.com>
In-Reply-To: <20240705135250.3587041-1-lizhi.xu@windriver.com>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 8 Jul 2024 08:54:57 +0200
Message-ID: <CACT4Y+YrjD=3Tn6o4FJFefDYsOCbUFWahPUp87PXXcHQsr0xXg@mail.gmail.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-out-of-bounds Read in mi_enum_attr
To: Lizhi Xu <lizhi.xu@windriver.com>
Cc: almaz.alexandrovich@paragon-software.com, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	syzbot+a426cde6dee8c2884b0b@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com, Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Jul 2024 at 15:52, Lizhi Xu <lizhi.xu@windriver.com> wrote:
>
> On Thu, 4 Jul 2024 15:44:02 +0200, Dmitry Vyukov wrote:
> > > index 53629b1f65e9..a435df98c2b1 100644
> > > --- a/fs/ntfs3/record.c
> > > +++ b/fs/ntfs3/record.c
> > > @@ -243,14 +243,14 @@ struct ATTRIB *mi_enum_attr(struct mft_inode *mi, struct ATTRIB *attr)
> > >                 off += asize;
> > >         }
> > >
> > > -       asize = le32_to_cpu(attr->size);
> > > -
> > >         /* Can we use the first field (attr->type). */
> > >         if (off + 8 > used) {
> > >                 static_assert(ALIGN(sizeof(enum ATTR_TYPE), 8) == 8);
> > >                 return NULL;
> > >         }
> > >
> > > +       asize = le32_to_cpu(attr->size);
> > > +
> > >         if (attr->type == ATTR_END) {
> > >                 /* End of enumeration. */
> > >                 return NULL;
> >
> > Hi Lizhi,
> >
> > I don't see this fix mailed as a patch. Do you plan to submit it officially?
> Hi Dmitry Vyukov,
> Here: https://lore.kernel.org/all/20240202033334.1784409-1-lizhi.xu@windriver.com

I don't see this patch merged upstream.  Was it lost? Perhaps it needs
to be resent.

