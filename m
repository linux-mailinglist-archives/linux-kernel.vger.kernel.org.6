Return-Path: <linux-kernel+bounces-287000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4577195216E
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 19:42:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6E7A1F24873
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2024 17:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1811BC075;
	Wed, 14 Aug 2024 17:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XuTM1WGq"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5E41B14F8
	for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 17:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723657321; cv=none; b=AUeSSKiCh1URWnAHjPzAilcMBBJ+EbEguu9RqTqNz+C3cCUDxM3et2eCNy7bDVymUh5yogHK60kmzrRh59KNwQCtIK4Da0d04bBhfiXhGoQLvN580nvwHMDlXnAE3RiC7WbpCeJq0O9ky5pIangFYsx0IBsszY3V0URwP7qsDak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723657321; c=relaxed/simple;
	bh=WW3Gd/l4KbQ6Dv28Ois1iJXa9rhAvk/iZTHW44KTOgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EsD/V/4MOAkMPwqmaguw/g0h17pPhOhIxLMYh1KpFZS5RMRRaIMz8XOyppaPb39aL+yJSj9rPV9wFubHOI6ihCYAxwCW1opM3i1+YWVebhtBLjGb7+80Av4ZDdfLr0a1KBWeerfmGhuJoLKFhS2rqrxLUrlakfaAGv3T4zGS+RQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XuTM1WGq; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5ba43b433beso273078a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 14 Aug 2024 10:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723657318; x=1724262118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1GHFJfLmSl7hDHpeBcHsBE1RJeYUTTMq76jcJawykoQ=;
        b=XuTM1WGqEPN4sSzd1r8NAUtRN+nFFcyNF4w4Bik1dhZ/BepNotj+RF/Zmp7GyUoxor
         rs23t2f2hjWqBBwP4EIv6W1HTCvbrJf094ImvRlyuj09a3j7h2Qy6FT89F5nLBBQ13XP
         5FoQ128Bg1JfXFqCwRzn9SinAe97h3B+tqtXEnNKDLHR2m6LzSl+wBAzNOQ4zQZL7kOt
         p9ZZgExCa/2tkdRuHRlGnY0B2SZDh4GDTG6dSaA7heAfdEMm82b0wgRoX7b+Im3ORfFG
         AcsIBcRYUanhzZJ08YNN3/MdeKO6PLYNQQ1u3Zeh3BUKjMySL05rSKo70zze7ba796sw
         T85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723657318; x=1724262118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1GHFJfLmSl7hDHpeBcHsBE1RJeYUTTMq76jcJawykoQ=;
        b=NltHCQde+nmUi8i47DWuSikz2lOYcwf6W+GGAaoadD29NjsdLyqBzkeW7USIxI8OtJ
         M51J3pcoVT6HxIvYZtfPTh1350t+OoFUtIY4O0+q1wiBCN8klhdaYhmfJ671gjVB9r7m
         +rTqIW9MSv/X8ygFhpquZqskppQUJqz80pcmJ+FGVJCqy5zhk6fc+g0AEJ/0TGL9N+sH
         JQHcpOitth14YwKJlmPxXh2/p439AgnLSze/52MD+oXcx7PFJAv0KHXzKB/dA/ENEwhw
         NEaoIrJALh0LtNZNrJVNzdxcfTBsAkt+XW3cXz4wE4OFBB9cRt7D2mQwv6N5k8Xa6JFj
         sdww==
X-Forwarded-Encrypted: i=1; AJvYcCVQqHNwmfzmCaTNzqhwcF0lbjXYXP1rIQMQlrYUsopNXQa8lsnkZ6ofkZSRzctn4Cpi5nEwJbttlF/TyOuJ58EX15Hr47Z63jzs/fph
X-Gm-Message-State: AOJu0YyCU7aTF9IoEXl+0EE3qt8zSuxqtAoTjM/V9QgJnYfevfdgub4H
	zJMm34YtkIMcUu22gLqZ/khsa/XXFBbZIuYw56deYxmraK+OZ+vF9/mItL3tdLet//fO2cDxi8i
	RS6oMMrKKcJQNwE+qYRMPQbdfpeI=
X-Google-Smtp-Source: AGHT+IEEBaEigDciY+8GghIwBoWxGooe/tDLaGVJp8TQHtn7OfjIfJvfaA1SqLEmEze6UDKPQ9aLuoqpPpORdHHrScA=
X-Received: by 2002:a05:6402:13d3:b0:5a1:1:27a9 with SMTP id
 4fb4d7f45d1cf-5bea1c8010fmr3260195a12.18.1723657317901; Wed, 14 Aug 2024
 10:41:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240812112030.81774-1-vignesh.raman@collabora.com>
 <191483d05a3.129198f97500814.8001634600010504645@collabora.com>
 <0a3db7dc-4533-4111-bec9-35cc68e35d83@collabora.com> <1914d612d8e.f2d5101b916106.3138016556910118397@collabora.com>
 <42753719-9619-45f1-b76a-8ff8d19cec22@collabora.com>
In-Reply-To: <42753719-9619-45f1-b76a-8ff8d19cec22@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Wed, 14 Aug 2024 10:41:45 -0700
Message-ID: <CAF6AEGuWHER=k-xGad-aAtOfS10R55W37FcU45phNnJpOwFhWw@mail.gmail.com>
Subject: Re: [PATCH v1] drm/ci: enable lockdep detection
To: Vignesh Raman <vignesh.raman@collabora.com>
Cc: Helen Mae Koike Fornazier <helen.koike@collabora.com>, dri-devel <dri-devel@lists.freedesktop.org>, 
	daniels <daniels@collabora.com>, airlied <airlied@gmail.com>, daniel <daniel@ffwll.ch>, 
	"guilherme.gallo" <guilherme.gallo@collabora.com>, 
	"sergi.blanch.torne" <sergi.blanch.torne@collabora.com>, 
	"deborah.brouwer" <deborah.brouwer@collabora.com>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 14, 2024 at 2:42=E2=80=AFAM Vignesh Raman
<vignesh.raman@collabora.com> wrote:
>
> Hi Helen,
>
> On 14/08/24 01:44, Helen Mae Koike Fornazier wrote:
> >
> >
> >
> >
> > ---- On Tue, 13 Aug 2024 02:26:48 -0300 Vignesh Raman  wrote ---
> >
> >   > Hi Helen,
> >   >
> >   > On 13/08/24 01:47, Helen Mae Koike Fornazier wrote:
> >   > >
> >   > > Hi Vignesh,
> >   > >
> >   > > Thanks for your patch.
> >   > >
> >   > >
> >   > > ---- On Mon, 12 Aug 2024 08:20:28 -0300 Vignesh Raman  wrote ---
> >   > >
> >   > >   > We have enabled PROVE_LOCKING (which enables LOCKDEP) in drm-=
ci.
> >   > >   > This will output warnings when kernel locking errors are enco=
untered
> >   > >   > and will continue executing tests. To detect if lockdep has b=
een
> >   > >   > triggered, check the debug_locks value in /proc/lockdep_stats=
 after
> >   > >   > the tests have run. When debug_locks is 0, it indicates that =
lockdep
> >   > >   > has detected issues and turned itself off. So check this valu=
e and
> >   > >   > exit with an error if lockdep is detected.
> >   > >
> >   > > Should we exit with an error? Or with a warning? (GitLab-CI suppo=
rts that).
> >   > > Well, I guess it is serious enough.
> >   >
> >   > I think we can exit with an error since we check the status at the =
end
> >   > of the tests.
> >
> > I mean, we can exit with a specific error and configure this specific e=
rror in gitlab-ci to be a warning,
> > so the job will be yellow and not red.
> >
> > But maybe the lockdep issue should be a strong error.
>
> Yes agree. We can exit with an error for lockdep issue instead of a warni=
ng.

I think that is too strong, lockdep can warn about things which can
never happen in practice.  (We've never completely solved some of the
things that lockdep complains about in runpm vs shrinker reclaim.)

Surfacing it as a warning is fine.

BR,
-R

> >
> >   >
> >   > >
> >   > > Should we also track on the xfail folder? So we can annotate thos=
e errors as well?
> >   >
> >   > Do you mean reporting this error in expectation files?
> >
> > I wonder if there will be cases were we are getting this error and we s=
hould ignore it, so in the code
> > we should check the xfail files to see if we should exit with an error =
or ignore it.
> >
> > For instance, if we have a case where we are having this error, and it =
is flaky, we might want to add it
> > to the flakes file list.
> >
> > Maybe this is not the case, I'm just wondering.
>
>
> The tests are passing but log shows lockdep warning
> (https://gitlab.freedesktop.org/vigneshraman/linux/-/jobs/62177711).
>
> Moreover if the lockdep warning is emitted, lockdep will not continue to
> run and there is no need to check this warning for each tests.
> So added the check at the end of the tests.
>
> >
> >
> >   >
> >   > > Did you have an entire pipeline with this? To see if everything i=
s still green?
> >   >
> >   > Yes. https://gitlab.freedesktop.org/vigneshraman/linux/-/jobs/62177=
711
> >   >
> >   > This is a test branch in which I reverted a fix for the lockdep iss=
ue.
> >   > We see 'WARNING: bad unlock balance detected!' in logs and pipeline=
 is
> >   > still green.
> >
> > But with your patch, it would red right?
>
> Yes it would fail and the pipeline will be red.
>
> > With the current patch, is the pipeline still all green?
>
> With this current patch, it will fail.
> Pipeline link to show lockdep_stats before and after tests,
> https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines/1246721
>
> Regards,
> Vignesh
>
> >
> > Regards,
> > Helen
> >
> >   >
> >   > Regards,
> >   > Vignesh
> >   >
> >   > >
> >   > > Helen
> >   > >
> >   > >   >
> >   > >   > Signed-off-by: Vignesh Raman vignesh.raman@collabora.com>
> >   > >   > ---
> >   > >   >
> >   > >   > v1:
> >   > >   >  - Pipeline link to show lockdep_stats before and after tests=
,
> >   > >   > https://gitlab.freedesktop.org/vigneshraman/linux/-/pipelines=
/1246721
> >   > >   >
> >   > >   > ---
> >   > >   >  drivers/gpu/drm/ci/igt_runner.sh | 11 +++++++++++
> >   > >   >  1 file changed, 11 insertions(+)
> >   > >   >
> >   > >   > diff --git a/drivers/gpu/drm/ci/igt_runner.sh b/drivers/gpu/d=
rm/ci/igt_runner.sh
> >   > >   > index f38836ec837c..d2c043cd8c6a 100755
> >   > >   > --- a/drivers/gpu/drm/ci/igt_runner.sh
> >   > >   > +++ b/drivers/gpu/drm/ci/igt_runner.sh
> >   > >   > @@ -85,6 +85,17 @@ deqp-runner junit \
> >   > >   >  --limit 50 \
> >   > >   >  --template "See https://$CI_PROJECT_ROOT_NAMESPACE.pages.fre=
edesktop.org/-/$CI_PROJECT_NAME/-/jobs/$CI_JOB_ID/artifacts/results/{{testc=
ase}}.xml"
> >   > >   >
> >   > >   > +# Check if /proc/lockdep_stats exists
> >   > >   > +if [ -f /proc/lockdep_stats ]; then
> >   > >   > +    # If debug_locks is 0, it indicates lockdep is detected =
and it turns itself off.
> >   > >   > +    debug_locks=3D$(grep 'debug_locks:' /proc/lockdep_stats =
| awk '{print $2}')
> >   > >   > +    if [ "$debug_locks" -eq 0 ]; then
> >   > >   > +        echo "LOCKDEP issue detected. Please check dmesg log=
s for more information."
> >   > >   > +        cat /proc/lockdep_stats
> >   > >   > +        ret=3D1
> >   > >   > +    fi
> >   > >   > +fi
> >   > >   > +
> >   > >   >  # Store the results also in the simpler format used by the r=
unner in ChromeOS CI
> >   > >   >  #sed -r 's/(dmesg-warn|pass)/success/g' /results/results.txt=
 > /results/results_simple.txt
> >   > >   >
> >   > >   > --
> >   > >   > 2.43.0
> >   > >   >
> >   > >   >
> >   >

