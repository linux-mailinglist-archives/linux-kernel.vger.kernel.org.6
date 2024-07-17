Return-Path: <linux-kernel+bounces-255392-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 960A193403F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 18:17:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DB401F23BB7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jul 2024 16:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4560B181BB5;
	Wed, 17 Jul 2024 16:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="IKxG7pUF"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F002C8C06
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721233037; cv=none; b=dGJu5dkssa2AQVIKwbNHpDl0I8NcXLnab2Wg7PIx4AqVU8RQxoHwtCrdemBB8LXBD3tCKwB1vPivULBoQ8teKmiVwtxECqR/aeuTf7AQemn60+6+365XLPMNqmjE45XdbH0JyqThoiSpP4jMtZlQgmGB5cVdIe2QGp3zTl1grwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721233037; c=relaxed/simple;
	bh=CuJV1fEIUhDjuzfVwGjzMfWcR2DMwpMCnhgEcy4cSPI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=e4S5879m4nHkUgXnufa+cVr7TDfZDRumbE2zMOXyobqcnQZRFOthxfFZNowpS2wU/SbGGTyUwmKeTFnin5/T4forbJGqaKl1Jt/4AOo+c1apBTbvcNpN10uSZ7CP9/4tlMIlJXLBH+6gzmI1hJEkM/Jvdt5ilqfzQJCrE6JOICg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=IKxG7pUF; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-e05d48cf642so2460763276.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jul 2024 09:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1721233035; x=1721837835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Wj8nXJ9HTKmuEM0AojHt2t/GP8cbxsvhjHlGJtPYB84=;
        b=IKxG7pUFdP//aOij8ZN4U4H6mMcynLjj867bo50dKd0t+wgyPbPY88QawZz/dXYD1i
         0ugtftcT7uI0fbeRJ+uZvmTRQcqwNPBhT9mgIqf0qOqPo8dg371blNurnsGBT/lryUrB
         JwicM0Kp+FbSfAnMJ8ecfCMDTDCui5dYxoak9LiweFVo2F3J8lIWMn9UtmkPOJ0aq4ld
         HZrydlTRiIrS3/AswrzTvk2SKwc7ooZ3I0OqOk1Dgu8GXmi2XX3Zk07s/fcxPXAf1+wk
         hRbjKGvZQ1eKMjlv0so6DlskIVb8bKctFrY5wzD4S+HrmOReo4IvnXQCw25Dxu3GixbX
         2B0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721233035; x=1721837835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Wj8nXJ9HTKmuEM0AojHt2t/GP8cbxsvhjHlGJtPYB84=;
        b=MxCwrqfMJpGOZz6ltY0HLTjc0e4vUK1+sOMoR+G6cctnA7s10HIF4K1QRUlLfVEbac
         o/DUZIrhslEa3GIJl/iHb6nVuLBKzrBFr+rBCD2gL2AKZydg/42jYqp9/yb9DUo1dmz3
         hJi8vFsh1Jnso/1yhvqunuEpdAzB6IABhduoCI1SWbq/1jsT1ADmxpiRm1SR9H7NNPnp
         O7+S2v9Okzrkdckt9XmdgpkQWLW2ZjWWGMsAXvzVfkfz8DTGv+kh9gSZpJJ8SINPaJWA
         iGL6yo5Dl1N5uq2rvc81oO4tY6th9SYLhhrfV5zoqs1sUTLKVw+ninPVjlii6d5Bvtlo
         vZJQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9T0hd8HWVrHUHoar1w1n87iPFqxhglgMwgdmmgEsw/wH2QEJj6pKd/4ADUQnwxd1T5fKm+gLMqdhWKhOg67rynKbcVknLfJVPPBAG
X-Gm-Message-State: AOJu0YxCMqasIHKisvp/wbOPbIGxcvw0uxAs87grj1VZ3SPdPhx0a3UI
	oIZwKhEM9aZw2S66Cy1h3nIQMqtcv/bpr396iQw5BohkrG3qMyOD4jUGH4lk4EKjFJxgFFFtYyd
	DJsFV1A62UTaM8FGbVKSYGOqWNcrCsxyzz/4r
X-Google-Smtp-Source: AGHT+IHvX3dSaNFjNXZTFZWjBZmXSuNHaPWxGqpC0ga6pXV3ArYgVsLWPLF5DJURCqftWGA5/ugQn2cIkfAZrpK/OjE=
X-Received: by 2002:a05:6902:c0a:b0:e05:ed29:a616 with SMTP id
 3f1490d57ef6-e05ed7e72b3mr2323230276.38.1721233034827; Wed, 17 Jul 2024
 09:17:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240702095401.16278-1-gongruiqi1@huawei.com> <9473d6eb-3f56-4c73-8e61-69111837c07b@huawei.com>
In-Reply-To: <9473d6eb-3f56-4c73-8e61-69111837c07b@huawei.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 17 Jul 2024 12:17:04 -0400
Message-ID: <CAHC9VhR+tk4mwmaQ6u8SEnzg6zMF2krFHKVwxKx91GX1K=4A=g@mail.gmail.com>
Subject: Re: [PATCH testsuite] tests/task_setscheduler: add cgroup v2 case for
 moving proc to root cgroup
To: Gong Ruiqi <gongruiqi1@huawei.com>
Cc: Ondrej Mosnacek <omosnace@redhat.com>, Stephen Smalley <stephen.smalley.work@gmail.com>, 
	selinux@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Wang Weiyang <wangweiyang2@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 16, 2024 at 10:19=E2=80=AFPM Gong Ruiqi <gongruiqi1@huawei.com>=
 wrote:
>
> Ping.

Dropping the LSM mailing list to cut down on the noise as it isn't a
relevant mailing list.

Ondrej currently maintains the selinux-testsuite project so I'd prefer
to give him time to review/test/etc. the patch, but I see it has
already been a couple of weeks without response.  If Ondrej doesn't
get to this patch by the end of the Linux v6.11 merge window I'll take
a look then.

Where (what distribution, version, etc.) did you see this problem?

Thank you for sending this out :)

> On 2024/07/02 17:54, GONG, Ruiqi wrote:
> > Currently for systems that only enable cgroup v2, the test script would
> > fail to move the target process into the root cgroup since the cgroup v=
1
> > path is used, which therefore makes the testcase fail. Add cgroup v2
> > handling here so that no matter which cgroup version the CPU controller
> > is bound to, the target process can always be moved to the root CPU
> > cgroup.
> >
> > Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
> > ---
> >  tests/task_setscheduler/test | 17 +++++++++++------
> >  1 file changed, 11 insertions(+), 6 deletions(-)
> >
> > diff --git a/tests/task_setscheduler/test b/tests/task_setscheduler/tes=
t
> > index c2fe8c6..fa1efb1 100755
> > --- a/tests/task_setscheduler/test
> > +++ b/tests/task_setscheduler/test
> > @@ -20,12 +20,17 @@ vec( $rin, fileno($f), 1 ) =3D 1;
> >  select( $rin, undef, undef, 5 );
> >  close($f);
> >
> > -$cgroup_cpu =3D "/sys/fs/cgroup/cpu/tasks";
> > -if ( -w $cgroup_cpu ) {
> > -
> > -    # We can only set the scheduler policy fo SCHED_{RR,FIFO} in the r=
oot
> > -    # cgroup so move our target process to the root cgroup.
> > -    open( my $fd, ">>", $cgroup_cpu );
> > +# We can only set the scheduler policy fo SCHED_{RR,FIFO} in the root
> > +# cgroup so move our target process to the root cgroup.
> > +$cgroup_v1_cpu =3D "/sys/fs/cgroup/cpu/tasks";
> > +if ( -w $cgroup_v1_cpu ) {
> > +    open( my $fd, ">>", $cgroup_v1_cpu );
> > +    print $fd $pid;
> > +    close $fd;
> > +}
> > +$cgroup_v2 =3D "/sys/fs/cgroup/cgroup.procs";
> > +if ( -w $cgroup_v2 ) {
> > +    open( my $fd, ">>", $cgroup_v2 );
> >      print $fd $pid;
> >      close $fd;
> >  }
>


--=20
paul-moore.com

