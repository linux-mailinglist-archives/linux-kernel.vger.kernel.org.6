Return-Path: <linux-kernel+bounces-168780-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 218C78BBD95
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 20:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D06CC282463
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 18:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E6937317C;
	Sat,  4 May 2024 18:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bLDEusoA"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A035E3FBB7
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 18:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714846842; cv=none; b=ASixEoY7ESVwWNsqxj8Oyki2NlrQuP6mNAlmPLDfrK1v6OyaEL1UfJllC8qCi70GZVUjYv0RkHaOSCLpOSbTG7x3kJjYQy09pIME7yeXZYfjtKq24Uv97LaScTZc+hmuU1G7Yzv40uMbFohXgR98ZcdF6PdCIH2TS6HXa816+94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714846842; c=relaxed/simple;
	bh=rAIZu+79Hh8VYj6yqYqrrAzdBZ74FGbLE5oKNi+7r5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PIi+86nH228+5YJ+fG3B9jy9q/km72Ygp0NR0q9xDw3oh615d3EeToCo/JiPx0IUC7opXG4mqwJtJmyLjxgwbOBOV9QSuGrGHW5nbHTW1lEFYJmLSXiKF+WatR295F3o4JRqvpYYSP18fkq1iDhYtacHHZMXQjiZ5BiutmnIH/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bLDEusoA; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a59a17fcc6bso139021566b.1
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 11:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714846839; x=1715451639; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TbTAb0O3vIVxVEVAX+Kz3ISBhu7sYKvIouph0u6S16I=;
        b=bLDEusoAJJmMSfPQ1FLAbyxT2bviFC7gRkMg3xdmCssBVTXqs89o1wOZMBzZq+/eMq
         xKlaZO9uZNhVXAvtGLcDZ2mL88xc3l7CygCoMRYp1uSbx5+3azkXMVsdadRHMrcHDxyA
         yU2TIqvE+Cy2E4YzgGDnI410mJ0Iivhr+mfLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714846839; x=1715451639;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TbTAb0O3vIVxVEVAX+Kz3ISBhu7sYKvIouph0u6S16I=;
        b=O0BbWVKQtG1TujU6ciiAQjHpmzOymC6tmThy1der+p8Rw9XIf9TeACaaANAR03tbfA
         rBhGDVPOLT3jrVrkjriD4WIh3IjcunK8RobyY2vsvfi42ZVy1pIW07MkYPpl5GDM1ylW
         /boqFfAgq9B/Tlpz7Q0NVFLvoL08SDOJg7p+BgunUs11kw1bqDewlbqoMubI+xSwQ9XZ
         HzPL+BkHEV96u0VN0v3P6MevKvaOBb9/tevUDsnOpVN2HhzbJeBvpSLirXC6u2wvtlRq
         fqp3/A+SJjO61NxoJxydJzmS8ALhW8hhXvcl8cWqKGajlxjdHfgsdswPi8HkQl4wCfau
         KmDA==
X-Forwarded-Encrypted: i=1; AJvYcCWSIQlFqCEa4nk+gs8240Vp8NRAa8u1Xe/JQV5YasHZD8TbL+ELCWqIkk3sowrL5pG0TlPu/x8fUY70M3I33AK7m4VTUP8ijMtKwUVe
X-Gm-Message-State: AOJu0YxJCVgP8zXmRuY+MR7XovGChqLAvJzWLlIBudOzCE+1Z2v+0wF5
	nPSR3viiat/6/SfWULnA7oLQ02fVfTCCAsB1JC2HL13+VT2gsJI8EUQ3lLZYs32rmhGxTaakl6I
	qXdLXiw==
X-Google-Smtp-Source: AGHT+IEbUJpd/pJtbBjxj7VtUxY7APXYJtZ8Wd+TWsR4idy6oVO4BH2Jt0DGZQwxIDIFPC/3qDUSpw==
X-Received: by 2002:a17:907:920b:b0:a59:9b75:b90 with SMTP id ka11-20020a170907920b00b00a599b750b90mr2565814ejb.2.1714846838963;
        Sat, 04 May 2024 11:20:38 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id uj4-20020a170907c98400b00a599f876c28sm1472384ejc.38.2024.05.04.11.20.38
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 04 May 2024 11:20:38 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a59afce5a70so71042466b.3
        for <linux-kernel@vger.kernel.org>; Sat, 04 May 2024 11:20:38 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVzfzU2BOUYwIO1JOjj3P/vVq2puFmhvkhBC3SVUJWWZQNIIXTh27KPusDDe2uVx+Uj4NsMC9dulYD1aIn6x60075nA1F4ms2P0OM0R
X-Received: by 2002:a17:906:e90:b0:a52:1e53:febf with SMTP id
 p16-20020a1709060e9000b00a521e53febfmr3945377ejf.69.1714846838331; Sat, 04
 May 2024 11:20:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202405031110.6F47982593@keescook> <20240503211129.679762-2-torvalds@linux-foundation.org>
 <20240503212428.GY2118490@ZenIV> <CAHk-=wjpsTEkHgo1uev3xGJ2bQXYShaRf3GPEqDWNgUuKx0JFw@mail.gmail.com>
 <20240504-wohngebiet-restwert-6c3c94fddbdd@brauner> <CAHk-=wj_Fu1FkMFrjivQ=MGkwkKXZBuh0f4BEhcZHD5WCvHesw@mail.gmail.com>
In-Reply-To: <CAHk-=wj_Fu1FkMFrjivQ=MGkwkKXZBuh0f4BEhcZHD5WCvHesw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 4 May 2024 11:20:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj6XL9MGCd_nUzRj6SaKeN0TsyTTZDFpGdW34R+zMZaSg@mail.gmail.com>
Message-ID: <CAHk-=wj6XL9MGCd_nUzRj6SaKeN0TsyTTZDFpGdW34R+zMZaSg@mail.gmail.com>
Subject: Re: [PATCH] epoll: try to be a _bit_ better about file lifetimes
To: Christian Brauner <brauner@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, keescook@chromium.org, axboe@kernel.dk, 
	christian.koenig@amd.com, dri-devel@lists.freedesktop.org, 
	io-uring@vger.kernel.org, jack@suse.cz, laura@labbott.name, 
	linaro-mm-sig@lists.linaro.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	minhquangbui99@gmail.com, sumit.semwal@linaro.org, 
	syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 4 May 2024 at 08:32, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Lookie here, the fundamental issue is that epoll can call '->poll()'
> on a file descriptor that is being closed concurrently.

Thinking some more about this, and replying to myself...

Actually, I wonder if we could *really* fix this by simply moving the
eventpoll_release() to where it really belongs.

If we did it in file_close_fd_locked(),  it would actually make a
*lot* more sense. Particularly since eventpoll actually uses this:

    struct epoll_filefd {
        struct file *file;
        int fd;
    } __packed;

ie it doesn't just use the 'struct file *', it uses the 'fd' itself
(for ep_find()).

(Strictly speaking, it should also have a pointer to the 'struct
files_struct' to make the 'int fd' be meaningful).

IOW, eventpoll already considers the file _descriptor_ relevant, not
just the file pointer, and that's destroyed at *close* time, not at
'fput()' time.

Yeah, yeah, the locking situation in file_close_fd_locked() is a bit
inconvenient, but if we can solve that, it would solve the problem in
a fundamentally different way: remove the ep iterm before the
file->f_count has actually been decremented, so the whole "race with
fput()" would just go away entirely.

I dunno. I think that would be the right thing to do, but I wouldn't
be surprised if some disgusting eventpoll user then might depend on
the current situation where the eventpoll thing stays around even
after the close() if you have another copy of the file open.

             Linus

