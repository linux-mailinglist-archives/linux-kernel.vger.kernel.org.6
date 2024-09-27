Return-Path: <linux-kernel+bounces-342126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06521988ADB
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 21:47:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCA7628327D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Sep 2024 19:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD751C2457;
	Fri, 27 Sep 2024 19:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Oa2F/oQ9"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D962346B8
	for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 19:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727466457; cv=none; b=a5Tq/4BuL4hfx0Ys+8uqjZDc71ulILtzkn79zvEkzIeRPeBVm2eX4jXkci38oZWswp8I/I2mhaKPhhjOz0gn7EjNvR8or4TKCoDkGmiCqMfvyU632ywNsLB4tJObgDl/F33AOwk7rRXULStOpwOH//kjsLu+fXnHhX2AxX7aYlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727466457; c=relaxed/simple;
	bh=K8LRS5lXD/WAyJR6Fah4BgddLYPaV1DDmCZ44umWmfE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TJ8WR4t3SBilGzWhx24QRBfZNN+kvwQzZTDqEBnMVxaOj2vocSqJFFyeShhv2pDoaBzUeqZy23+CLkHhzjbIiaikSbVAD0mKLISwvZPJa0Rh2N+sieHx4AHf5SJgE1i7QGDJH5jErPyJqgMMWmswCFBc1KF9CUsw8WLiwT+42jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Oa2F/oQ9; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a8d3cde1103so316042466b.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 12:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727466454; x=1728071254; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=53HOZed5FIyfCoU16tivT3Dit2MdvJuxNAeOr42Twwo=;
        b=Oa2F/oQ9dgPgO/NeiWR3W+Hb23hXNPwEMxrtlXjlorWsEoENeqF5ew7uyNzmIoSRq5
         qP8rePAsiKKl+iZ/yjXBZecdqMq0Tr4+ZHhOMtWZMAw1bDoR72WbhPN/ukvAQDzpDT8r
         Ce9kUPTistbmkAMpOv4E0m+Rb8NngeEf3Kb0Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727466454; x=1728071254;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=53HOZed5FIyfCoU16tivT3Dit2MdvJuxNAeOr42Twwo=;
        b=DE7CONcI/qBQBu6MyD/i7bzjn+UHljcfkd4PDEC2pDPJg+7WKVdV2knOE9m4L9Sn+8
         NiQaYzHBsvWEx+O63iF9YYJuzr4xDFXg7YDWl1pASPHbmbebs0g/TDe+5jnFkCODZzCC
         vxM6fvelQb8HMxTjNxoY9KVh+/RGl4HhAr52ezNWn02/uuGB3jn21R6R6A0FY8egVIBK
         szfc6HsLuk6n2aD24vnE1miGgZTCIjCNd6aRmPleFhg5As3g6sBCoQmH/tYTXiASAFyK
         1mr/Achk4XB/NdGMeUMdr1XxVn5QUTuOmPU+j4Za+f0+8wxzlkgTKMTIWDyLbA6QAf3L
         BrAA==
X-Forwarded-Encrypted: i=1; AJvYcCX0r+eyGE2TQj/MdwlnwK0YvxzpIpucjZVhb6EbW0XhNEAwsA/4hCX3UhsVeErFKhJddgCtauYR4RvYHv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBny5JssAanGdA+CGar1CLV2iKlLtbAsGRtB8CipIMuuCQbHKu
	Pu+2FTPK+6MRdx3HpAFxs2mJCQJFblb3DF4how3ubIW549Gq0REPu31FQD0qmjsk50hPVFout68
	Pdo00wg==
X-Google-Smtp-Source: AGHT+IGtFMZCwvH5vXHXYEepiqduNumpF8XS16nIVrSs5m2gwzPe0KGj+Jpn2qWaGhrzqrwruONrgQ==
X-Received: by 2002:a17:907:ea4:b0:a90:c411:24fd with SMTP id a640c23a62f3a-a93c48e8c04mr430714766b.10.1727466453891;
        Fri, 27 Sep 2024 12:47:33 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a93c277c056sm167411766b.33.2024.09.27.12.47.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Sep 2024 12:47:33 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a8d3cde1103so316038766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Sep 2024 12:47:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWmiH2oD95EblKypxhR2qA7J/yEDXkX+/2Ei7bsCZdE45dwU7N0Hv4Zdk3jKInm8KnLi4wDN/9Oo8xq8qE=@vger.kernel.org
X-Received: by 2002:a17:907:3f1c:b0:a8a:837c:ebd4 with SMTP id
 a640c23a62f3a-a93c4926f43mr470113466b.27.1727466452677; Fri, 27 Sep 2024
 12:47:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <k53rd76iiguxb6prfmkqfnlfmkjjdzjvzc6uo7eppjc2t4ssdf@2q7pmj7sstml>
 <CAOQ4uxhXbTZS3wmLibit-vP_3yQSC=p+qmBLxKkBHL1OgO5NBQ@mail.gmail.com> <CAOQ4uxiTOJNk-Sy6RFezv=_kpsM9AqMSej=9DxfKtO53-vqXqA@mail.gmail.com>
In-Reply-To: <CAOQ4uxiTOJNk-Sy6RFezv=_kpsM9AqMSej=9DxfKtO53-vqXqA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 27 Sep 2024 12:47:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wikugk2soi_2OFz1k27qjjYMQ140ZXWeOh8_9iSxpr=PQ@mail.gmail.com>
Message-ID: <CAHk-=wikugk2soi_2OFz1k27qjjYMQ140ZXWeOh8_9iSxpr=PQ@mail.gmail.com>
Subject: Re: [syzbot] [overlayfs?] general protection fault in ovl_llseek
To: Amir Goldstein <amir73il@gmail.com>
Cc: Leo Stone <leocstone@gmail.com>, 
	syzbot+d9efec94dcbfa0de1c07@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org, 
	miklos@szeredi.hu, syzkaller-bugs@googlegroups.com, skhan@linuxfoundation.org, 
	anupnewsmail@gmail.com, Christian Brauner <brauner@kernel.org>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 27 Sept 2024 at 05:41, Amir Goldstein <amir73il@gmail.com> wrote:
>
> Too quick to send. I messed up the Fixes: tag.
> Now fixed.

Applied.

However, just for the future: please send patches that you expect me
to apply with a very explicit subject line to that effect.

I get too much email, and hey, I do try to read it all (even if I
don't answer), but I'm really really good at scanning my emails
quickly.

In other words: sometimes I'm a bit *too* good at the "quickly" part,
and end up missing the fact that "oh, there was a patch there that I
need to actually react to and apply".

That has become more true over the years as the individual patch count
has gone down, and *most* of what I do is git pulls, and most of the
emailed patches I see tend to be things that are for review, not
application.

Yes, I picked it up this time. And maybe I even pick up on these
things *most* of the time.

But I still strongly suspect that to make it more likely that I don't
miss anything, you make the subject line some big clue-bat to my head
like having "[PATCH-for-linus]" header.

Because even just a "[PATCH]" is likely to trigger my "patch review"
logic rather than something I'm actually expected to apply, just
because I see *so* many patches fly by.

This was your daily "Linus is all kinds of disorganized and
incompetent" notification. Making things obvious to me is always a
good thing. It's why those "[GIT PULL]" subject lines help not just
pr-tracker-bot, but also me.

Thanks,
                    Linus

