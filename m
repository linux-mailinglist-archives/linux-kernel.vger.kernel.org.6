Return-Path: <linux-kernel+bounces-358101-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D25997A29
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 03:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878DA1F23C25
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Oct 2024 01:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4392F2B9D2;
	Thu, 10 Oct 2024 01:28:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ut2np6uC"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0608A22094
	for <linux-kernel@vger.kernel.org>; Thu, 10 Oct 2024 01:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728523702; cv=none; b=mPfyOq0oBdKioYMVANuxIWAfUCfr0H/gmUHhL7dxCRVn5cAizrAUHxxPj4Mk4FE7xSMvR7tdQGEyVm2Py0tC5xFWM50sLgp8bDuVqRaslp1E7kWuojLzL7XZbC1qIrQQNg2jpW305X47fyXTmQCARsLlAdkPbnMQHzNUjwGGwIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728523702; c=relaxed/simple;
	bh=I/MrKtHVqIJu7U2B8TRyeGeNvRXOu4glprUHE82I3vA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D4VjTfmWCDIWvDTl1RoC3lTxNBzAH2KH6QN0jYpMddkDw7TzDb0nueVDGnmDsdndskiQrJP1+CiCVZv0gl6VQtGA+46ul0/a3otzK9AA3xqxduwR2gDIGZqoTTOhZsGOiEGoAVMTgxjzf4SKohuV2bHOFTwG9dIboAHb5fr4ScM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ut2np6uC; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5398e7341a3so62397e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Oct 2024 18:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728523699; x=1729128499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VlaT00TYnkVw/cLCmAFB9f/ich8Z222RWy8eT5SZDZE=;
        b=Ut2np6uCThNlbFfxkPBGnuusMw9fyblEhbjEhtPNbtbYNLUCgFHMwvXonmlse+dIPb
         eRTYtgfSQ/PnVDnnKVwcEtTY1cvJzV6FNMX8x4aC9lrP+T6ppCK6WYgfRsHHtRKtKmZY
         ppwbTenSYFhWSi+hNbGzzKlYxbhD30ih4+iDglSBhxVcQmSf2A8O/ysmcGOeCLSWW1tG
         AkdxTo4RcXDoGElm/1JcazocIon3OpmZqywXk2n1g23uDruvQ4tT1lAIflDzaCfxUvBO
         ul1yv68KxUDbC1286htJYvjbh7ITr0nOEzh2rbuo3V+qLyY4fxzrCRbFGWFA2tmnE/bU
         fDhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728523699; x=1729128499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VlaT00TYnkVw/cLCmAFB9f/ich8Z222RWy8eT5SZDZE=;
        b=YDYbe7G9megb4Bv4LXAmm8v40N2dcYvh68ZBuuAhXy802W24ZoxfxH3lp6WUNLt23L
         9NDPn+cmGiA+uqTMvb/QFkL9leLFpRn8foUV4GbkyLbJZzv7EWKl0AXp1k178qFBftm/
         T/4iDLYhGGcm159j7oIS6tGYq6Zx6HXqDYBSxZYZrmt1yeKMw9BvxClyCkxkZCIqupeK
         MVFC2cpE0Zlqq/c64ohWEnk0mgyHWWL+Dm7n5039a1FisIVnTUoB2A0cDcDClUgcHWIG
         5qV80lx1JtWYqGPOvQ8BnbetNroljGEnos+7pHCrEo1VfrEIhCqH87QHrjtnrG8MczRE
         QA3w==
X-Forwarded-Encrypted: i=1; AJvYcCXJkLrlEyD4mxCh3im+Wp5zZDnWs1wqBByT4GLFluIoOP4woifQcHCGY4OGFP/Jl+Z06vGyXEfu2W5O7es=@vger.kernel.org
X-Gm-Message-State: AOJu0YwSEmiFs2vW+lJmKSojsiHaVhjsbun1qgWktN8krgA6SYMSMTsf
	l07nfw1GHSA88cjTxO2crcGDxDmD6eop2QfBL+r4cNBisa6o0k1RUfu1j0n98GQ6uoBOMAsUvO7
	6RPaDA6P+m0hgNHyTfGOuFv0F6DNPI+ZX
X-Google-Smtp-Source: AGHT+IGA8D4d/NKfE3sAHW3yv8tf12g0swxPE5fwD6W9LctvR9eXNFEcWIB7pKDIgeLKGG161xVsRyF0AMYmeA6bpOs=
X-Received: by 2002:a05:6512:1327:b0:535:6a7b:9c03 with SMTP id
 2adb3069b0e04-539c494a024mr699845e87.6.1728523698840; Wed, 09 Oct 2024
 18:28:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241009074953.608591-1-zhaoyang.huang@unisoc.com> <20241009135252.53276de999d3006a20cad21c@linux-foundation.org>
In-Reply-To: <20241009135252.53276de999d3006a20cad21c@linux-foundation.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Thu, 10 Oct 2024 09:28:07 +0800
Message-ID: <CAGWkznFAAM5VZ0Q8Hy+T9b9g3qBsxj9WFTaHwwhXvcSR=AYqVQ@mail.gmail.com>
Subject: Re: [PATCH] mm: throttle and inc min_seq when both page types reach MIN_NR_GENS
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Yu Zhao <yuzhao@google.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 10, 2024 at 4:52=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Wed, 9 Oct 2024 15:49:53 +0800 "zhaoyang.huang" <zhaoyang.huang@unisoc=
.com> wrote:
>
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > The test case of [1] leads to system hang which caused by a local
> > watchdog thread starved over 20s on a 5.5GB RAM ANDROID15(v6.6)
> > system. This commit solve the issue by have the reclaimer be throttled
> > and increase min_seq if both page types reach MIN_NR_GENS, which may
> > introduce a livelock of switching type with holding lruvec->lru_lock.
> >
> > [1]
> > launch below script 8 times simutanously which allocates 1GB virtual
> > memory and access it from user space by each thread.
> > $ costmem -c1024000 -b12800 -o0 &
> >
>
> That looks like a pretty simple testcase.  Do people know where to get
> `costmem' from?
Sorry, I am just aware that this is an internal test tool integrated
into the SDK by our folks. Here is an old version of costmem which I
can share

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <errno.h>

unsigned int block_size =3D 64;
unsigned int cost_size =3D 1024 * 1024;
int oom_adj =3D 15;

static void usage(void)
{
printf("Usage:\n");
printf("  costmem [-ccost_size(KB) -bblock_size(KB) -oOom_adj(-16 to 15)]\n=
");
printf("  such as: costmem -c2048 -b128 -o15\n");
}

void process_options(int argc, char **argv)
{
int opt =3D 0;
while ((opt =3D getopt (argc, argv, "c:b:o:")) !=3D -1) {
switch (opt) {
case 'c':
cost_size =3D (unsigned int)atoi(optarg);
break;
case 'b':
block_size =3D (unsigned int)atoi(optarg);
break;
case 'o':
oom_adj =3D atoi(optarg);
break;
default:
break;
}
}
}

int main(int argc, char *argv[])
{
int i, max;
char *memory;
size_t j;
size_t page_size;
int rval =3D -EINVAL;
char text[128] =3D {0};
int fd;
pid_t pid =3D getpid();

if (argc < 2) {
usage();
return rval;
} else if (argc =3D=3D 2) {
if (strstr(argv[1], "help"))
usage();
return rval;
}

process_options(argc, argv);
if (oom_adj < -16 || oom_adj > 15) {
printf("Oom_adj must between -16 to 15\n");
return rval;
}

sprintf(text, "/proc/%d/oom_adj", pid);

fd =3D open(text, O_WRONLY);

if (-1 =3D=3D fd) {
perror("open");
return rval;
} else {
sprintf(text, "%d", oom_adj);
if (write(fd, text, strlen(text)) =3D=3D -1)
perror("write");

close(fd);
}

printf("Cost mem %d KB, %d KB per Block, oom_adj %d\n", cost_size,
block_size, oom_adj);

max =3D cost_size / block_size;

for(i =3D 1; i < max + 1; i++) {
memory =3D malloc(block_size * 1024);
if(NULL =3D=3D memory){
perror("malloc");
return rval;
}

if(mlock(memory, block_size * 1024) =3D=3D -1) {
perror("mlock");
return rval;
}

memset(memory, 0, block_size * 1024);

printf("%dKB,", (int)(block_size * i));
if(9 =3D=3D i % 10)
printf("\n");
}

printf("Have malloc and mlock %d KB mem\n", block_size * i);
printf("Have malloc and mlock %d KB mem\n", block_size * i);
printf("Have malloc and mlock %d KB mem\n", block_size * i);

i =3D 0;
while(1){
sleep(20);
i++;
printf(".");
if(9 =3D=3D i % 10)
printf("Please Ctrl+c to kill this APP\n");
}
return 0;
}

>
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
>
> This is a somewhat serious issue, so I'll add the patch for some
> testing, but I'll await feedback from MGLRU developers before
> proceeeding further, thanks.
IMHO, MGLRU is now lack of the mechanism of 'too_many_isolated' thing,
should we do it in this way or others?
>

