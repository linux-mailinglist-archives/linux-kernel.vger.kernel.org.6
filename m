Return-Path: <linux-kernel+bounces-306132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B6F49639BA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 07:02:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DB0F1F258BC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Aug 2024 05:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C300148FF7;
	Thu, 29 Aug 2024 05:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="jCxuQaGO";
	dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b="kROzuzpj"
Received: from mx-lax3-1.ucr.edu (mx-lax3-1.ucr.edu [169.235.156.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0629C38F83
	for <linux-kernel@vger.kernel.org>; Thu, 29 Aug 2024 05:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=169.235.156.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724907734; cv=none; b=XoRlQBcaWyAqR5LfCQ2yjpnT4vpG381jvF8t0bQcOHv55GQPS7rAQiYK5zhlqnUtBFkqxzVbNwwtMBQ14rqSsUim9BLrsFCAdRV7yWARZqgJlLOGHz6q7R4uf/4spM5HxKMewOMmDXMgxheXUDpm+JgP6GKqiQQELv+5qF1W7Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724907734; c=relaxed/simple;
	bh=i1fPbDH24oD861Jt9OCb/DWqJTwDV3i0koPkmGEspoE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKFgvR5zp+cPhXG3GUfaGu5rYvtXMiyCC70EivTbFmM7f15LExoRcao+SvcyD+lmh/oH5+xser2zHMmnG1nfEIWeN88n6orolqGPhbL8/tsgo0h5zvm8EsJVBtxlBU5Xnx6+KtAn2rJS0ht5Ypj7ykiKTcScHuQDy848xY7myxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu; spf=pass smtp.mailfrom=ucr.edu; dkim=pass (2048-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=jCxuQaGO; dkim=pass (1024-bit key) header.d=ucr.edu header.i=@ucr.edu header.b=kROzuzpj; arc=none smtp.client-ip=169.235.156.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ucr.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ucr.edu
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1724907733; x=1756443733;
  h=dkim-signature:x-google-dkim-signature:
   x-forwarded-encrypted:x-gm-message-state:
   x-google-smtp-source:mime-version:references:in-reply-to:
   from:date:message-id:subject:to:cc:content-type:
   content-transfer-encoding:x-cse-connectionguid:
   x-cse-msgguid;
  bh=i1fPbDH24oD861Jt9OCb/DWqJTwDV3i0koPkmGEspoE=;
  b=jCxuQaGOvnQsbp4Z4BAtTpS2gJFICCVTJKIPH3ADMkmuSNp8Q+9FriAd
   dEIrkAmqsa2Wcr4l3oC8/m2C9YhP5CtyXokIQro83QNwPebf5Kj95vXX8
   bBscgpwj43LH2HbHJZWtcBNN7UxyIk0AsMAhyvrropRA2qu1c2qibURTc
   ZxHm9FBABnpfPkdm7m6tZi7p9O4PiVavJj6O4syVGk9OH6ToxklSuayVu
   yXx5dufkMsBronCK7GLYwFyPj6lObbaORotD/MK+A77c/DjL2rZhwetoR
   ediyBbQyZfzhnM/ViC9Ccdo1S9nCq9MQR+WxJPG4KeWWw4eP8h0Pbwq+h
   Q==;
X-CSE-ConnectionGUID: kqckWKVwSnaDjfX3KbMA+w==
X-CSE-MsgGUID: HQXnlz8gSeuhNquaWK7THg==
Received: from mail-io1-f72.google.com ([209.85.166.72])
  by smtp-lax3-1.ucr.edu with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Aug 2024 22:02:12 -0700
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f99a9111fso33019439f.2
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2024 22:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ucr.edu; s=rmail; t=1724907731; x=1725512531; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eh1bQD5cI+vzw09T28H0NLKYRrXU4Y8237RYtEC1S8U=;
        b=kROzuzpj5DUG5SUceOpR0EqADP69cbJmcJhdgSndQPO7JTAiebxbc6tOFYrF0F1LZf
         eg4jh4DJ6mYW9Evxz23zcuvnBmLa7QdbEkPtra26nyBkaF/Ujmhprdd/GHLh9WeQ0sYd
         dZRXXjnLABzEwBKOiDIQOiq0zPoOVKSYx80kw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724907731; x=1725512531;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eh1bQD5cI+vzw09T28H0NLKYRrXU4Y8237RYtEC1S8U=;
        b=mKNWIqq8gfHx9e+kpW8iWDsTNp6pa9NL9Z2BOwtuKYLzUYeUMQQa0MRXIm0GM1QdJt
         jziMmvJ2RSOGg2ZO1ZwYrZrInCgh0k+87g7fNCBkW97JI9BOOPW+M7DVZuYBJ5EKo3ee
         r4Jrf1AMBU8jh6oUDY2OUHXGG6Re1ZgNsJy3n9PFd8wy8rYSfjA//6cT5Rqea8MGNEnz
         HtJWR9yV7LW+nlBqEU1M9Qmju4yzGDq8/h8YgFH5Afcu6E9dSsIijlQHKV0EVZDJNNPd
         Ts15KJga42RRa3JgFyHQdfvZMFfnaZoaJGeC2V6Qma9183AKrXYlN1AxNGxJdek3tTHY
         SU8g==
X-Forwarded-Encrypted: i=1; AJvYcCW+GW9VLzbXp9JFXMyiTPTolGjnjMlpm/2+K21eubj+OwuWZ4PoNXZjBs3kepbQ+D8EBK9TnBPoQgVXUeI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDIZYrW1Q4lN0Lc1rBEmYU2RYw+rfOrW0/etmEH7ApysCLTm5X
	TGRGRUDp7k0goM7hlC1Btg6KnrC18kYj8+XpZ9DApKEI/jiOuO1nKQWd958wqOXdBIITJn78fXr
	SHvo3S7Eza2phBkAKtphZHYP+5YLDA7Qix7jU/R5HHJ1zce03eHww+J3eJjOhRIZDVbs5UU+E/4
	gc+8PDkiPChR3nIEbt6cw698XkxMs1L1QdhONsGg==
X-Received: by 2002:a05:6e02:1607:b0:39b:649:f5e2 with SMTP id e9e14a558f8ab-39f3780c2fbmr25136205ab.13.1724907731278;
        Wed, 28 Aug 2024 22:02:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEaa+ZsQ9KdlcFxh7JYAL/9GdYzaBFZJcCvNC82sLT8U3GwPSZuhQbgd/2qDHiM5i4hiGxTkqh+ZedpnYzpgEg=
X-Received: by 2002:a05:6e02:1607:b0:39b:649:f5e2 with SMTP id
 e9e14a558f8ab-39f3780c2fbmr25135865ab.13.1724907730838; Wed, 28 Aug 2024
 22:02:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALAgD-4uup-u-7rVLpFqKWqeVVVnf5-88vqHOKD-TnGeYmHbQw@mail.gmail.com>
 <202408281812.3F765DF@keescook>
In-Reply-To: <202408281812.3F765DF@keescook>
From: Xingyu Li <xli399@ucr.edu>
Date: Wed, 28 Aug 2024 22:02:00 -0700
Message-ID: <CALAgD-6CptEMjtkwEfSZyzPMwhbJ_965cCSb5B9pRcgxjD_Zkg@mail.gmail.com>
Subject: Re: BUG: WARNING in retire_sysctl_set
To: Kees Cook <kees@kernel.org>
Cc: mcgrof@kernel.org, j.granados@samsung.com, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, Yu Hao <yhao016@ucr.edu>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Waiman Long <longman@redhat.com>, 
	Sven Eckelmann <sven@narfation.org>, Thomas Gleixner <tglx@linutronix.de>, anna-maria@linutronix.de, 
	frederic@kernel.org, netdev@vger.kernel.org, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Tejun Heo <tj@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@amazon.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This has been mentioned
a few times already[3][4]; have you seen these replies?

Sorry, I did not see this email
https://lore.kernel.org/netdev/CANn89iK6rq0XWO5-R5CzA5YAv2ygaTA=3D=3DEVh+O7=
4VHGDBNqUoA@mail.gmail.com/.
And I received this reply
https://lore.kernel.org/all/20240829011805.92574-1-kuniyu@amazon.com/
just 8 minutes before your response.
Previously, I did not have the experience to send emails about bug
reporting. Later, I will take care that I only send bug reports with
reproducer or with a patch.

but only have
reproducers for 4 of them[2].

Your search words may ignore some of my emails. In fact, it has 16 bug
reports with the C reproducer(previously, some of them is only given a
syzkaller reproducer, and I just checked to confirm that C reproducer
is given for each bug).

https://lore.kernel.org/all/CALAgD-4M6bv53fpWnb2vdu4kxnCe_7H3kbOvs3DBAd8DeR=
HYuw@mail.gmail.com/
https://lore.kernel.org/all/CALAgD-5cKJnWRsS_2rjL1P9pC0dbNX66b8x09p=3DDUx1k=
D+p6PQ@mail.gmail.com/
https://lore.kernel.org/all/CALAgD-7TsMdA7rjxfpheXc=3DMNqikEXY9TZNxJt4z9vm6=
Yfs5qQ@mail.gmail.com/
https://lore.kernel.org/all/CALAgD-6miPB6F2=3D89m90HzEGT4dmCX_ws1r26w7Vr8rt=
D8Z96Q@mail.gmail.com/
https://lore.kernel.org/all/CALAgD-6Uy-2kVrj05SeCiN4wZu75Vq5-TCEsiUGzYwzjO4=
+Ahg@mail.gmail.com/
https://lore.kernel.org/all/CALAgD-5myPieAa_9BY6RVfBjWT_8g48+S0CX7c=3DEihMz=
dwakxw@mail.gmail.com/
https://lore.kernel.org/all/CALAgD-718DVmcVHtgSFGKbgr0ePoUjN2ST=3DgBtdYtGX5=
GUqBQg@mail.gmail.com/
https://lore.kernel.org/all/CALAgD-5kt+F6S1aAwRhKMKb0KwFGzfJCWyHguotEvJGBBB=
vFkA@mail.gmail.com/
https://lore.kernel.org/all/CALAgD-7JNKw5m0wpGAN+ezCL-qn7LcTL5vgyBmQZKbf5BT=
NUCw@mail.gmail.com/
https://lore.kernel.org/all/CALAgD-6MJC+D0DzxLOpVvCbYzHE-r1YzNORtpOh-f+hgEk=
Mjzg@mail.gmail.com/
https://lore.kernel.org/all/CALAgD-7hbfOzovnPqVqo6bqb1nHZ2WciUOTsz0Dtwsgr+y=
x04w@mail.gmail.com/
https://lore.kernel.org/all/CALAgD-4hkHVcCq2ycdwnA2hYDBMqijLUOfZgvf1WfFpU-8=
+42w@mail.gmail.com/
https://lore.kernel.org/all/CALAgD-6gJ4W1rPj=3DCWG7bFUPpEJnUjEhQd3uvH=3D7C=
=3DaGKb=3DCUQ@mail.gmail.com/
https://lore.kernel.org/all/CALAgD-7C3t=3DvRTvpnVvsZ_1YhgiiynDaX_ud0O6pxSBn=
3suADQ@mail.gmail.com/
https://lore.kernel.org/all/CALAgD-4b_yFdN4fwPxpXEpJkcxEwXBxRHeQjeA3x3rMX4J=
pUwA@mail.gmail.com/
https://lore.kernel.org/all/CALAgD-58VEomA47Srga5H-p6cZa0zPj+y3E1se0rHb3gj4=
UvyA@mail.gmail.com/


There
are hundreds like them (many with reproducers) already at:
https://syzkaller.appspot.com/upstream

In fact, the bugs that I report are fuzzed by the syzkaller templates
that we generated, but not those from the syzkaller official
templates. We want to find bugs that do not have the corresponding
official syzkaller template.
I also checked to make sure that the bugs I reported did not occur on syzbo=
t.



On Wed, Aug 28, 2024 at 6:26=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
>
> Hi,
>
> On Wed, Aug 28, 2024 at 02:16:34PM -0700, Xingyu Li wrote:
> > We found a bug in Linux 6.10. It is possibly a logic   bug.
> > The bug report is as follows, but unfortunately there is no generated
> > syzkaller reproducer.
>
> I see you've sent 44 reports like this recently[1], but only have
> reproducers for 4 of them[2].
>
> Without reproducers these reports aren't very helpful. There
> are hundreds like them (many with reproducers) already at:
> https://syzkaller.appspot.com/upstream
>
> Please only send these kind of reports if you have a fix for them
> (preferred) or a reproducer for an actual problem. This has been mentione=
d
> a few times already[3][4]; have you seen these replies?
>
> -Kees
>
> [1] https://lore.kernel.org/all/?q=3Df%3Axli399%40
> [2] https://lore.kernel.org/all/?q=3Df%3Axli399%40+%22The+reproducer%22
> [3] https://lore.kernel.org/netdev/CANn89iK6rq0XWO5-R5CzA5YAv2ygaTA=3D=3D=
EVh+O74VHGDBNqUoA@mail.gmail.com/
> [4] https://lore.kernel.org/all/20240829011805.92574-1-kuniyu@amazon.com/
>
> --
> Kees Cook



--
Yours sincerely,
Xingyu

