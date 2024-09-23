Return-Path: <linux-kernel+bounces-336223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D6DE97F0CF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 20:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1D78AB221A9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Sep 2024 18:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A67E1A0723;
	Mon, 23 Sep 2024 18:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="TLJI7PPQ"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AB941FA5
	for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 18:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727117055; cv=none; b=JlZpFXjH+vDZfm4XZuJ9dWNTb73c7WMPXgV95YsT7TX8GwwAQGZ/Yb6BCZ/oEqRaSA/MfZXPHiEwh2jeaMHcMNLzG/G9YFTiY2FXAziIEPGOcn47tkHjmadDdLxvN98Ir/ue9i8HFciYYBusoQmkOJ4Jm7fCcR1ZV94FtDGqlKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727117055; c=relaxed/simple;
	bh=P+8RSoZYpn4i1QWoYAMFPg4MPU/K9mqWhjadfR5Z54k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TZzEs3106QEWR3R8zugFnG6/CxFuWLnTBv3Cvuxswm3yKtOorFQLww4bHihWEhEc6ar3UBmqZ/QtidsrFlN9Md3wEAkhLm6Xsb512yhHLkIJpFRqUs6rOn7kCJ9WNWNlUMWzcN1STUjw3QYiKmLLc2XMVYGSxsnBc77XVl6CVJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=TLJI7PPQ; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a8d2b4a5bf1so674284166b.2
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 11:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1727117051; x=1727721851; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8QNKTwa377j4ekDDJ2WhXczOsWiGSIZrBf1uUxHYML4=;
        b=TLJI7PPQirKV2kld6Xb24rBb78++9rB0ED9NLQyEdMjPZ/D7xwr4EcgTO50M4rm5YI
         vCmwvqFGZrNBFBsdcJQVnF9uctg4IVPQ3Xapo88zs7xG5eKdQjo8ycy9Au3aainQ4AGa
         mUqGzKxBO4w/Osr85UsUv9Fe0B3AlH+89XLqo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727117051; x=1727721851;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8QNKTwa377j4ekDDJ2WhXczOsWiGSIZrBf1uUxHYML4=;
        b=q0MieiK/KcdNEoLOJMBWPdpSJ5ij+jt0mi6sKofuiq5FmvDZjpSbPtbeMwmv3hA6/9
         MFBY6AJALxlsHtT8EREAmPHjkiLgSljJunWRePkk60wrfAQ7ytH1N8w8WZ8R5APPh4G+
         D2LIJQ2rqOcMaIF4RRi9vhr369VBf+72dtknj3N2sImzLjyKIfBh1S6Qcoc7Flscbya2
         wzEqLUKCpQRZRITQSVg47rCzv8F8D1XhOOYLbJtDRIoBZ764kp3Bgc5dVyXjYY5Oo1Xq
         jC+Rw7KooHy5mhoQqgoNT/sAlF9QsgLxyzdDvba6Emf20jmSN+Hs74pCSH3K0vEYrVND
         Dhbg==
X-Forwarded-Encrypted: i=1; AJvYcCWnu+27RiUgbrv3n3XGO7WtwAZcGi9H2E6jlfefoIbsgcAkPUZMQyNIWXPaCSWsiVlBTmqekbsjSa53g5g=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw82aBqIT+F0gYIAZtjiE2eD4uEGVuCW2KBCV0OINrgv2b+Q93t
	OxNcYOedAFy0RuZsz+YC9Q4oEEZ+cThdpb6Owrj/aX7u9moURdJq0L7y/YIekfFc/kZNVPrzot1
	gM+c=
X-Google-Smtp-Source: AGHT+IGXb8Xz5K6wsL/zkkfvalzPMA2/wUIRDeTH8/Dj93N6hArqCyE/0fmk7TRB6UesZKWGaT57eQ==
X-Received: by 2002:a17:906:cac9:b0:a80:f358:5d55 with SMTP id a640c23a62f3a-a90d5033db5mr1203544166b.33.1727117051051;
        Mon, 23 Sep 2024 11:44:11 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9061331b7csm1258801766b.225.2024.09.23.11.44.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2024 11:44:09 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c5b6161022so4003451a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 23 Sep 2024 11:44:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVuEsE5juPxJyoHRqsY1rbd4ZPQXqsSw5dQlEnTzKeolSsG3ksM7dJKMlPquLkN+QNYh3nyJRx9/S9W+4M=@vger.kernel.org
X-Received: by 2002:a17:907:f1d1:b0:a8d:14e4:f94a with SMTP id
 a640c23a62f3a-a90d508b54dmr1204787666b.38.1727117049536; Mon, 23 Sep 2024
 11:44:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240922140047.261100-1-agruenba@redhat.com> <CAHk-=wittQGvXXMB5vk5GYyBWSbNmEtuY_i0O1WcR2SZed2dVQ@mail.gmail.com>
 <CAHc6FU7hZkHy5uTJ867zYJ1_Lp+ozP5tvBtW5_dDH1n6OruhTQ@mail.gmail.com>
In-Reply-To: <CAHc6FU7hZkHy5uTJ867zYJ1_Lp+ozP5tvBtW5_dDH1n6OruhTQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Mon, 23 Sep 2024 11:43:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgoEasfoxjU5ThjqW2JXnpvYGkmmxyBjuyOZsLOR=F8_w@mail.gmail.com>
Message-ID: <CAHk-=wgoEasfoxjU5ThjqW2JXnpvYGkmmxyBjuyOZsLOR=F8_w@mail.gmail.com>
Subject: Re: [GIT PULL] gfs2 changes
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Mon, 23 Sept 2024 at 11:10, Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> It's tag gfs2-v6.10-fixes from yesterday; you should see that.

Your tag naming is surreal. It's not a "fixes" pull, and it has
nothing to do with v6.10.

                  Linus

