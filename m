Return-Path: <linux-kernel+bounces-323222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 663549739AE
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 16:18:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F10F21F21E66
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Sep 2024 14:18:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2A2C1946B5;
	Tue, 10 Sep 2024 14:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QE08hCjd"
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BC9317BEC8
	for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725977881; cv=none; b=i9FBK9uCS0tKzM0vXs7Ywoq78AA1sJC+3/BQtJexsepYkeCrTeVRKJQkoeCvgN1zUCbBuc0b8d8urI7T6CsgoRAp7nOALP0rzcDY3WW+fy4ZzqzPqiju+4WTk0qpPQ0lZk8hH57UBg66/3gX/IEduyWgPy1SyTRtLt/yZOhvtVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725977881; c=relaxed/simple;
	bh=GGEARYjG+B84skQ/gQZ2YSitjcN2OvNyakrwejuFeos=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aqzu6bxqIBJcBKR3xQDWO90get6nHgfk7K4JzTibmDu8wKjYj8uZfDiOmZ+tztK9CditWpxU72aLGi9LELMgk6Ud6xXWzBbbDM3PBsX1vwq+7d6cv8iBskPHrI4KRWZFb2wdydTmDIzdsYriwZXWIBPz4ytwG+ZXKK+FcR8WL34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QE08hCjd; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-42cb2191107so21847415e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Sep 2024 07:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725977877; x=1726582677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GGEARYjG+B84skQ/gQZ2YSitjcN2OvNyakrwejuFeos=;
        b=QE08hCjdWXcsj5kA57xCTKtADAE8h1Uyk6TxdUMphVO9INSMa3lCO3ZzRPhU0IQ+cI
         MmO41JESLXo2zOKBlsfeykkkYnv9Wk1qoR37VxUFGUiokShyJXTxDasryXwvxxl4Rsgv
         XFs0cptLYGyI9jogi/gpeD37vLQ1DjhANtvawj2EefPwqWXBmCQEQu/77fMTm8ja6JNF
         FygyBlWF46cMUfMGIrU5lnlgfpfuN24bB6wSlK2TWWm0APYJMa5TtSeIi9SOHVvLLwXE
         PI70MU8eGSMFe0jZEckLAzwK1DclqzME6q0m3vD2qT4TOFGS9iylZ3MrGbxN5zT5NeKM
         dc6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725977877; x=1726582677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GGEARYjG+B84skQ/gQZ2YSitjcN2OvNyakrwejuFeos=;
        b=Yl17jq0CgRn5iqsZShN6qL7CNOnxkDHbnWFUS3bmFfMK+UZ79gBXTPaSSQAzF/HcNq
         kbTP9PPrT1o5lm24o+LMX6c49Cp+TDEAS7RhvTNc1RQqjq2Ie0HncOzJ7+ngDyukXHU1
         KQloj0DfWcjrLn/4sZMFNJIdemuE51vV791KEjA3uXbT00zUjZ6aVXG8p4uLjlt/quHE
         50sI1Jneymzz7Mkxx9Di9P3qwZ/u4PhlMry9hzO0BT52ZunecfO19N09atY6I5W79PVi
         I/RiZgq70N4yzTci2JM94yYCzObM69G1Vt/21ncGtu8cLeMQbb8f2aDyulyF1qNv6WBm
         dTkA==
X-Forwarded-Encrypted: i=1; AJvYcCUl9zYuchHu4JlxB59KPM6KLPq6XI6HeBJIaWORTUkBCyuTMiSb7vVjFaKu8x1rl8p9ipt7oDExLQyLYDg=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywj3VIsPRCioyO8F1a2zyau2zaKnBHQdaBbJkpO1+rPx+vXIFfH
	WLY7lV7kM8ylkr5MleCGqdyu1Byspya5h+3lC2t5lrBarSl01TmcVt88XoPy3mMsOdFLE/P2srD
	sbN5cSyn5WXP5fmw8NSR1vSTz4rGg1phjKKN8
X-Google-Smtp-Source: AGHT+IFP50KLZfbGJ8bH9xXy+TL6LHRHDCKh34oPF+iM3gvovF6kGCtP9aBu6fgoYkXrl3dPW8ldzSS/rZq+xC4o3NU=
X-Received: by 2002:adf:a1d0:0:b0:374:bb0c:c067 with SMTP id
 ffacd0b85a97d-37892703fdcmr7136480f8f.40.1725977876172; Tue, 10 Sep 2024
 07:17:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANn89iLmOgH6RdRc_XGhawM03UEOkUK3QB0wK_Ci_YBVNwhUHQ@mail.gmail.com>
 <03C87C05-301E-4C34-82FF-6517316A11C2@gmail.com> <CANn89iLYUjfsaXrtV19_DF9nUSaLSwmWnd7tzh8+v9OoUesBHg@mail.gmail.com>
 <CAO9qdTEOSa=GAQQ-tcWa6hUJVNKBKDOqLOVOZffKw9K5SJeOBA@mail.gmail.com>
In-Reply-To: <CAO9qdTEOSa=GAQQ-tcWa6hUJVNKBKDOqLOVOZffKw9K5SJeOBA@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Sep 2024 16:17:41 +0200
Message-ID: <CANn89iL7VkYp0WPWw5vt964p_6Bx29XdOaeMiTk7PzhLpNBW5g@mail.gmail.com>
Subject: Re: [PATCH net] net: prevent NULL pointer dereference in
 rt_fibinfo_free() and rt_fibinfo_free_cpus()
To: Jeongjun Park <aha310510@gmail.com>
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	pabeni@redhat.com, kafai@fb.com, weiwan@google.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 4:06=E2=80=AFPM Jeongjun Park <aha310510@gmail.com>=
 wrote:
>
> Eric Dumazet <edumazet@google.com> wrote:
> >
> > On Tue, Sep 10, 2024 at 5:23=E2=80=AFAM Jeongjun Park <aha310510@gmail.=
com> wrote:
> > >
> > >
> > > > Eric Dumazet <edumazet@google.com> wrote:
> > > > =EF=BB=BFOn Mon, Sep 9, 2024 at 8:48=E2=80=AFPM Jeongjun Park <aha3=
10510@gmail.com> wrote:
> > > >>
> > > >> rt_fibinfo_free() and rt_fibinfo_free_cpus() only check for rt and=
 do not
> > > >> verify rt->dst and use it, which will result in NULL pointer deref=
erence.
> > > >>
> > > >> Therefore, to prevent this, we need to add a check for rt->dst.
> > > >>
> > > >> Fixes: 0830106c5390 ("ipv4: take dst->__refcnt when caching dst in=
 fib")
> > > >> Fixes: c5038a8327b9 ("ipv4: Cache routes in nexthop exception entr=
ies.")
> > > >> Signed-off-by: Jeongjun Park <aha310510@gmail.com>
> > > >> ---
> > > >
> > > > As far as I can tell, your patch is a NOP, and these Fixes: tags se=
em
> > > > random to me.
> > >
> > > I somewhat agree with the opinion that the fixes tag is random.
> > > However, I think it is absolutely necessary to add a check for
> > > &rt->dst , because the existence of rt does not guarantee that
> > > &rt->dst will not be NULL.
> > >
> > > >
> > > > Also, I am guessing this is based on a syzbot report ?
> > >
> > > Yes, but it's not a bug reported to syzbot, it's a bug that
> > > I accidentally found in my syzkaller fuzzer. The report is too long
> > > to be included in the patch notes, so I'll attach it to this email.
> >
> > syzbot has a similar report in its queue, I put it on hold because
> > this is some unrelated memory corruption.
> >
> > rt (R14 in your case) is 0x1 at this point, which is not a valid memory=
 pointer.
> >
> > So I am definitely saying no to your patch.
> >
>
> I see. Thanks to the explanation, I understood that this patch is wrong.
>
> However, while continuing to analyze this bug, I found out something.
> According to the rcu_dereference_protected() doc, when using
> rcu_dereference_protected(), it is specified that ptr should be protected
> using a lock, but free_fib_info_rcu() does not have any protection for
> the fib_info structure.
>
> I think this may cause a data-race, which modifies the values of rt and
> &rt->dst, causing the bug. Even if this is not the root cause, I don't
> think there is a reason why free_fib_info_rcu() should not be protected
> with fib_info_lock.
>
> What do you think about protecting the fib_info structure like the patch
> below?
>

By the time free_fib_info_rcu() is called, we have the guarantee that
no other threads/cpu can possibly use the
struct fib_info.

nexthop_put(), fib_nh_release(), ip_fib_metrics_put, kfree() do not
need this spinlock protection.

fib_info_lock has absolutely no effect here.

Also, 0x1 is not a valid pointer, there is absolutely no chance a
network layer could use 0x1 as a rt/dst pointer.

As I said, the bug is elsewhere, something is mangling some piece of memory=
.

