Return-Path: <linux-kernel+bounces-352179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7C5991B51
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Oct 2024 01:15:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31685281D21
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Oct 2024 23:15:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C1216B3AC;
	Sat,  5 Oct 2024 23:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="HLVYUAVC"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5003155314
	for <linux-kernel@vger.kernel.org>; Sat,  5 Oct 2024 23:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728170151; cv=none; b=QE55GkXZxExtjfMO3IYzQezGfDPY1hK6MBW+mm7opOC+50b7U73Ld8WQdUtH1gRib2YhqqTqygXY92o9ht9K3PH23D0qnIGCMP2JKkPDwmh9X0TMZsARbpWrk4B4jl+241LyN0NBli+WZpxqqx1yKvQsfoLdCXTq82f5OihXJoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728170151; c=relaxed/simple;
	bh=cW9voHQW5KDncJFUKsCyNd2iDsh+IZlwySB2TQy6Ai0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q5OHbabCa5LmS6NQGsPtYNK5P7J+lufSirdcmByngmyvJJXKOzDlD11tW7/juhB5pPhsrr/WztQqzGhCfiY0fmqRxgP/ShMe32xyWVuo7zgtPoUegTZ90zmmKjDKCbxYO6BzmroWV6XTP4+VyBXYK/MCjGnH2f8EGEkVM5YIR3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=HLVYUAVC; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5c5cf26b95aso4278786a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 16:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1728170144; x=1728774944; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NhjXXWdst9jlpC/rp/tuj7IYcehyrssGedcgZn1fDGA=;
        b=HLVYUAVCfMvlFaBG8X00YA0Dw37bZ3CyDKhANJFMm1ziyYzwJcOZJ9Pk9fICoyBXqG
         sB8UWjYXjtJiyCkA70PniFlJAxwFHaXXzkn4q3Ge2nC0KNk3395wKoWDU7lEGOSfekqS
         +ITCsKKB1K01JcX3/czr0JG4r4YeU5pfKO4Sc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728170144; x=1728774944;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NhjXXWdst9jlpC/rp/tuj7IYcehyrssGedcgZn1fDGA=;
        b=wOLbLkdYLevWrMiEDVCh5EAnlgIz8Wq6LbSbbpcGNdfO64ItuCKp0SJla4L1QQQjTu
         b2F2RcQWzdgMeLYT6ss3hNvOVVwEvK10cqCpKUcXXvm82lhLV/KXreHPCVx/v/D7KCV2
         P3HpTRVJa8B5xfV7aZk7lu/QwIG3G1iQqoHgiAniJxTTA7PsTtN6K4HafV+2NlApQAi5
         rGyRuMkrH7gPCIh9kOYxWJZXvPAETiATBGihw1AMlWpx5BO2NWsLVPwn0AxnU4HCjLa4
         zfy5oHwyb9/NiU7PVA06yEgKmNOMfipe+OvLch2BumbEG9zZmuu2q+bTvDOqA4xsRk/R
         GT9A==
X-Forwarded-Encrypted: i=1; AJvYcCXWO/KbJ2GMNgZi/qm29J0ipS4v0aQGel5fJcdsLocBlrcVnHfhEdGd5X032xtn1UNVRPj5cymhf2JUgiA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4so05y5p1VNft9zOGDNDiRVFaV6rOz1xB6UNLBtOTJw4uyeOW
	4GvdBtCP87XyI5lP2FjyZuOkXQTqheV02WreXO03Vdx2obw2g6mG+IEJ7rb1ZJxO5PovTm2pjsv
	IlgITrg==
X-Google-Smtp-Source: AGHT+IEwt6pNw4Bd/DFl9A6C06qChct9hjkd70/bLRUl5ZrpDK5aQzjyZk8t9ZdWl+zVdYrVgiGhng==
X-Received: by 2002:a17:907:1b98:b0:a99:422a:dee5 with SMTP id a640c23a62f3a-a99422adfffmr146111666b.57.1728170144055;
        Sat, 05 Oct 2024 16:15:44 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9937615e85sm155868566b.175.2024.10.05.16.15.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Oct 2024 16:15:42 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a83562f9be9so338723866b.0
        for <linux-kernel@vger.kernel.org>; Sat, 05 Oct 2024 16:15:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXlsljt2rWr69AbowS2QAmy1ERK0ykmnpy/J/Q04GT9Ivy4IYDRlCldw8u0Bt7atqDhwCyyLxrcwBEPhB4=@vger.kernel.org
X-Received: by 2002:a17:907:3e22:b0:a8c:d6a3:d025 with SMTP id
 a640c23a62f3a-a991bd6ae43mr732521166b.32.1728170142480; Sat, 05 Oct 2024
 16:15:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cphtxla2se4gavql3re5xju7mqxld4rp6q4wbqephb6by5ibfa@5myddcaxerpb>
 <CAHk-=wjit-1ETRxCBrQAw49AUcE5scEM5O++M=793bDWnQktmw@mail.gmail.com> <x7w7lr3yniqrgcuy7vzor5busql2cglirhput67pjk6gtxtbfc@ghb46xdnjvgw>
In-Reply-To: <x7w7lr3yniqrgcuy7vzor5busql2cglirhput67pjk6gtxtbfc@ghb46xdnjvgw>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 5 Oct 2024 16:15:25 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi-nKcOEnvX3RX+ovpsC4GvsHz1f6iZ5ZeD-34wiWvPgA@mail.gmail.com>
Message-ID: <CAHk-=wi-nKcOEnvX3RX+ovpsC4GvsHz1f6iZ5ZeD-34wiWvPgA@mail.gmail.com>
Subject: Re: [GIT PULL] bcachefs fixes for 6.12-rc2
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Sat, 5 Oct 2024 at 15:54, Kent Overstreet <kent.overstreet@linux.dev> wrote:
>
> The vast majority of those fixes are all ~2 weeks old.

With the patches not appearing on the list, that seems entirely irrelevant.

Apparently they are 2 weeks on IN YOUR TREE.

And absolutely nowhere else.

> Let that sink in.

Seriously.

You completely dodged my actual argument, except for pointing at how
we didn't have process two decades ago.

If you can't actually even face this, what's the point any more?

               Linus

