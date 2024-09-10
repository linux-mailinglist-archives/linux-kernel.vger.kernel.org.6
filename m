Return-Path: <linux-kernel+bounces-323417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E7EE973D10
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 18:19:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B74581C246BC
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:19:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BEFA13B28D;
	Tue, 10 Sep 2024 16:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ZZ4rLr8y"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775A32AE69
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 16:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725985170; cv=none; b=Qp8bic0A5axQFdCjoVPvcfyrRgaRAtVrLYpUVngwOQpgMVpdkWF/yHWgen2o2gN2N0YLQSFWL8j+W2k94dZZeD067n+iebzv2JpiKcewhMKCzbh10nf6ll7f1vnJT+IBRBYjljbfnIEo3EIoolg0gfKJYnHT21Y6wipZTCJx2SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725985170; c=relaxed/simple;
	bh=SaZjE+HY77WMIu6Nxd79v+ZMON7iR5GtYbysr1/Fbt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=s0kWWabIeMve0XKa1oAGyIirKxsI+PdtTnbleP7qAJ+7X17X2jIOwlQqsD3FotGeiFlQAFruL+RUkIXDQsyLw4CrXx+voAzdyYrumAbQhMeCd8dDgkaNCP2/sYspFI8/NiyWxreo+uV/mddprUuOjXhxD4KsALHOr0pv2Rrxxtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ZZ4rLr8y; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5365a9574b6so6515437e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:19:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1725985166; x=1726589966; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=66tHKe95x2Yrd6TPe2bVP9tss/Lg0TR0MUB5t81uGgM=;
        b=ZZ4rLr8yt1RgMyQJnucUVv8DQdEk6eMloH9GsvUiubrr/Oxy1k0iYI3hJaxBhEg62K
         a9nP59xqt5I06q4TKG0B0W+OZHR/YT67wJvOzy67Ig5u9skpMudRX9uBF+4t9K4P1SP7
         HufTspZz4wqG/WTbgjv+H4gNWr2dHU47gxnvc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725985166; x=1726589966;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=66tHKe95x2Yrd6TPe2bVP9tss/Lg0TR0MUB5t81uGgM=;
        b=K6K3gPJGCk3Jy1dopC9uuDpiSabiaoKPh4xALdG/A7rq6J+n7XUZBM2x6ozF7gdjEr
         SMlZjKNQlDDF8pj/+5po/ccf79mxq/Dpe837HCWLmC6Nf4eGo4sy6DK6nCxWbhzutDeC
         u/CZ79e6FX/V+QWgF6ExZTmskgYpETmCH1vXyep5tKcIyiTZYTw7kEA3nz/XmqzKn1El
         x1kMNpGWShT1Sczl5+VaKBuFCpIdig4tXyVN+ipMKYIejwRnkP9yWleUSR+GC/nU5aIm
         c+fzogJbHrr6dAeCHxI3ZQoziZfr00rJBm6RCcwE9Vz6aYosDUKd6ws+Vq69uuls/Huh
         pMFQ==
X-Gm-Message-State: AOJu0Yy8wrZPCX8jbSufIpAuJEL7jp+qKj+1jlSbttvvzD15Wqoaa3Wv
	qK8fQKJZaEdKIV0azw3TKBEozqiu9D9BCfcL3ml7NSBHx0sreDBZNBUsqPYnG/3ep2yW9M1QLcd
	ZpJ0=
X-Google-Smtp-Source: AGHT+IEDvW3TJ3oe9TCEbrG270ez3Xg7KEGm/uYKBtpoWzHiWJipTcI5KFIugZrlE+Cf9M9P2/ynFA==
X-Received: by 2002:a05:6512:33c8:b0:535:6aa8:dc49 with SMTP id 2adb3069b0e04-536587a672emr12701188e87.9.1725985165403;
        Tue, 10 Sep 2024 09:19:25 -0700 (PDT)
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com. [209.85.208.177])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5365f903e1fsm1228365e87.231.2024.09.10.09.19.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Sep 2024 09:19:24 -0700 (PDT)
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2f761461150so4257591fa.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 09:19:24 -0700 (PDT)
X-Received: by 2002:a05:651c:1a0b:b0:2f7:6653:8053 with SMTP id
 38308e7fff4ca-2f76653813amr74877991fa.18.1725985164176; Tue, 10 Sep 2024
 09:19:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=whHwbceFq8XCK2uLCK9_aGywqmgMq3Udp5OJwFvLixpEA@mail.gmail.com>
In-Reply-To: <CAHk-=whHwbceFq8XCK2uLCK9_aGywqmgMq3Udp5OJwFvLixpEA@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 10 Sep 2024 09:19:06 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgEc3AokcxSh5EU5rvHz7ShQOqe9vHZS7+itZDSbx2xvQ@mail.gmail.com>
Message-ID: <CAHk-=wgEc3AokcxSh5EU5rvHz7ShQOqe9vHZS7+itZDSbx2xvQ@mail.gmail.com>
Subject: Re: Linux 6.11-rc7
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sun, 8 Sept 2024 at 15:04, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Of course, if I release 6.11 according to the normal schedule next
> weekend, that means that the merge window will open while I (and many
> other core maintainers) are traveling for the yearly kernel maintainer
> summit. That in itself might be a reason to delay, although not a
> particularly strong one.  [...]

Small update: I already have seven pull requests in my queue, and two
additional maintainers that have said they'll be sending in theirs
before travel.

So I'm planning on just releasing next Sunday (obviously assuming no
show-stopper issues popping up), and then I'll have to deal with the
merge window starting while on the road.

                         Linus

