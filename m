Return-Path: <linux-kernel+bounces-239619-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B64892631F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 16:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45CD01F22045
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jul 2024 14:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A47FD1822FF;
	Wed,  3 Jul 2024 14:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iT29VdPR"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA6417C9E8
	for <linux-kernel@vger.kernel.org>; Wed,  3 Jul 2024 14:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720015903; cv=none; b=VGAurtVxrSbBFH4eK24lgP4wVdCq3MTdgc3iXpbPxeCHIev12GqQpMrvQGuJMvwrr2f8CvLmyWq2cTpvorDk+UaHnLDJ6VGSsEPyeBz4XII1oSQKMbJ+TS1KbwkDO5RTjysszfX3WV2uCMz+D7jzTPX9ssnDGNX2+6K5knzZkCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720015903; c=relaxed/simple;
	bh=m8hCT7EOm/KzocY2lDql9ksozHqcMD8DmIHpk2qdW1A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMSqHquqjzbSjaHI9AdfmaOehLSg6r31vAXKht2ABRm0JW8hkRoU/tMrF2j8Prk/GlJbL8l3wczMMDiNUrhXzSFj4zyYXjE188a25Dn+Rc71oMBzLgw/Z+8mWfoVmFhBv4c5PZ8CHmDem3MoVuilQusnb2kGp7+G3JXMmMK3GpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iT29VdPR; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a72510ebc3fso814459666b.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jul 2024 07:11:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720015900; x=1720620700; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+jfOfJ3/jY+788L7avbBrQiHekIeiMO253ikR1T3ag=;
        b=iT29VdPRPYv8KheP5rSzCVZHVONpUGc+X9RiiEhSfMLOtcPXAPg1XYpWG48xGWqu7c
         YuuHN8S6B6xxj0KC/tUURw/S8Cyj8Ru8qjHi8FZl7iSTkW0HH5UCe98zxDiGAX5hvlUs
         OaaFgl89qsbKdBHo7YEyqiJ9Upvu8fE/cbO2u0F3ATsFo66Y0Q9WjLwT9NNk3WVzXkLO
         bEKjEYL0dYxZyRXHgOg91dzupr0RLq+KzLQ115Ri8HLpYBjbACUL4ItPkI+LsKdMBH0p
         3E3jgzfGpQrgypgu99AG+9km3n8n+zPU5PxrSCVlwaxnk7Z2sSj8sN1pGWi25nDhnpuD
         6COA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720015900; x=1720620700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+jfOfJ3/jY+788L7avbBrQiHekIeiMO253ikR1T3ag=;
        b=LrhqmnpoW3kaBX2+U0KOVu7PZMcIcDKMPu9prD1q8AVdmNDDWBu5G2x6fXqmgFU9MQ
         O2BmmvFcxbI+5mRaftvW6Ui5InboLSTrNGmSvtK378kfY66tVeiupGZ/La890uiODMeB
         EmJqIwqKXOaZ3yF4KeBlRe6+Q5vEBFmGuCB2CKyro9J4+C2OnEXuZVSHRBZUjvVnkj6e
         5ITuTwQCVFUPx0aM2HLkGpOiqoLQQtvySCEIawrV74rYLHKX62/+w3/QxlSo4h46hxz+
         gAvJIEN9XkmgNIgwON56HPibjHuWWpJygRt9YKMUf2HJpoemM7R4o/puwNb+ExJoWTBQ
         BkEw==
X-Forwarded-Encrypted: i=1; AJvYcCWdh3PhTlnms2hx51lRxZIOVloYbirSc0mbQHZlH30lPxgxtu/WOxymoZYEhU68yHt3qpVQUjY451lOjDM2KEIJoSHDOKcMGchxY4wf
X-Gm-Message-State: AOJu0Yyiexxa3OrjzWDoZ3rtKh3F4PRIkoSi+yqR6Cuqsqxop76FttNw
	mGxMxALwxM4h/0lZvJUY909+xT101ebN93sEstW927nZJestOaw90ihln7lRAHxLPjP6sue/cag
	hNpmreaPSSkLsMqldVmWfQtiltso=
X-Google-Smtp-Source: AGHT+IE3jD545xz4CdEoFN2qZKeLPkj9TIBo3lb9j/pQ0Q6mPtJJR+TY7Q/5JydaEL8odgHFIZ7STtFK6v5V18RVLNg=
X-Received: by 2002:a17:906:594:b0:a72:40b4:c845 with SMTP id
 a640c23a62f3a-a75144badc1mr687998366b.51.1720015899409; Wed, 03 Jul 2024
 07:11:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAGudoHGuTP-nv=zwXdQs38OEqb=BD=i-vA-9xjZ0UOyvWuXP_w@mail.gmail.com>
 <CAHk-=wgVzKtRnvDXAzueJTbgfo1o12Lw6DH97PzRe1cGA_b1oA@mail.gmail.com>
 <CAGudoHH_z1a6MX8Z8Cqbz-jDTUoAjoxdV9KrQ6yvUkNszXO5aw@mail.gmail.com>
 <CAGudoHHg-T+ZOTm0fSpW0Hztfxn=fpfnksz5Q3=3YeCeEPo7LQ@mail.gmail.com>
 <CAHk-=wiBGSLNW6GGbnec-dCbn0kWvD+OXAa5VNXPBKLXYy5KOQ@mail.gmail.com>
 <3g3arsrwnyvv562v2rsfv2ms4ht4mk45vwdkvssxkrjhfjtpdz@umyx5tl2du7o>
 <CAHk-=wg6e8QMaBOyFaGon7pik_C1COrkmEz37mtUqpBoq=R44w@mail.gmail.com>
 <6knlkefvujkry65gx6636u6e7rivqrn5kqjovs4ctjg7xtzrmo@2zd4wjx6zcym>
 <CAHk-=whagTfq=EgwpuywUUu0ti7PPQuE_ftVjZOVrjnLwtS0Ng@mail.gmail.com>
 <du5vnvwygzbtal6qogmxckawwwxgbppuq5qi5aeqcs5unrlpz3@3k5degdvflzq> <20240703-haftstrafe-anbringen-88ed445e77a4@brauner>
In-Reply-To: <20240703-haftstrafe-anbringen-88ed445e77a4@brauner>
From: Mateusz Guzik <mjguzik@gmail.com>
Date: Wed, 3 Jul 2024 16:11:25 +0200
Message-ID: <CAGudoHHkxyCkLZ4xwQ9ho5uy0TQ4K1ENJMmSYDZkaZw6YF4VEA@mail.gmail.com>
Subject: Re: [linux-next:master] [lockref] d042dae6ad: unixbench.throughput
 -33.7% regression
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, lkp@intel.com, 
	Linux Memory Management List <linux-mm@kvack.org>, linux-kernel@vger.kernel.org, ying.huang@intel.com, 
	feng.tang@intel.com, fengwei.yin@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 3, 2024 at 4:09=E2=80=AFPM Christian Brauner <brauner@kernel.or=
g> wrote:
>
> > As a side note this is where I should also note the *current* LSM hooks
> > are racy as is.  Suppose you can stat a particular file now, but a chow=
n
> > to 1234 means you can't. Then your stat call can race against chown +
> > other ops. You can end up in a state where LSMs gave a green light and
> > only then the state changed to one you are not allowed to look at. This
>
> Fwiw, we've discussed this before. And my opinion is that we should
> absolute not care about this. I have no interest in complicating path
> lookup or any codepath to make these hooks less racy. This raciness they
> have to deal with. This is not a comment on your patch but just that the
> raciness of security hooks is not a problem we should care to solve
> imho. If we go down that road we'll all slowly go insane trying to give
> state change guarantees to layers that hook into the VFS in really odd
> locations.

Well I noted I have no interest in working on it anyway, so... I think
we are good here on this front :)

--=20
Mateusz Guzik <mjguzik gmail.com>

