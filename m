Return-Path: <linux-kernel+bounces-425158-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 823049DBE46
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 01:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A7E1164B37
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Nov 2024 00:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C38FDAD58;
	Fri, 29 Nov 2024 00:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LBboBl6i"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E3B8BF8
	for <linux-kernel@vger.kernel.org>; Fri, 29 Nov 2024 00:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732841084; cv=none; b=WfvzMuAF402a2olHpWqYXwk5Tofi+Kg0HzsUhwcAgqjSmAlJMbKRaY1q8iqAl9Zp9BUZ4UIDz7+2TBT1ulVNzs4Ume36jtpapGn+S4PAWQUqR8tDzA6LNOwLqQi6MH1IU8UranMIPoZPfgeIn7AX/SkO7vIgfrfO260vJI7Ph4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732841084; c=relaxed/simple;
	bh=4/y4VQ0GLGAtqPWrieHd89SHKIqsmZN/k0z4Rl9W0wA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=apKkbKw5ldVmFXQdSWXUrhIx7YsGTGTju1nlQFwCNV7aJ5eCmfBBMAas/5E74MnOx2cP1w/i45PCO748isHv33/MH/uBJbEc+s8ne/My0KUGuvs/M68iJzkhofQjW2fCvNFjEq/3IRPv0IFNdyA9RPgVPWhS49Ges8iZPlgJj/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LBboBl6i; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-83e5dc9af36so74579239f.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Nov 2024 16:44:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732841081; x=1733445881; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/v1nNdm5iWud1f+F9UQzOq3LMhndgTT6JiSKdHpgOg4=;
        b=LBboBl6il+WJ5sqBMi1mHJ88JR6KdnbWATm64dhlGqYxupdjVe+pyoqaGPAqB+8x9I
         /PG/psg0hgm/xWRCbquYWpbtT4WWg7tICAURR390FRAx7fPaGS0U5ZI5IMtZjuEbdn+T
         1NneQZ5lFIaEPnSGV7y+lryVZblWCXz5ftJLCmJGpnAB2ZMIBMJW9u2lqb+FmCYvE+kR
         alnq4cxTzXiKyKKhX3J+YRuMd6+LXefaPwBmkFvvl9lFx9a9cEoy79UNWgpdaXLB+uGr
         M35/syT1n0OasC0zrtDqGDSR67jXf14toVD5Btj7HlSyi7NoSzqa05Fasnt1UMSKgwUY
         1yxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732841081; x=1733445881;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/v1nNdm5iWud1f+F9UQzOq3LMhndgTT6JiSKdHpgOg4=;
        b=o6uop9YksktJtbdQNmpdnDMjdDf91Cg2G5/MVDDZoor+xJYy+upTa3Ednq13o6QihW
         hX6aQgv9m9JYUajf9IvGcK1TChwUSylBdjhBN2TXjFEMQSp/aTCoHzUcSodzy2p6zzqG
         AsROpDqLlHN72+Zezq42FR/yLow9KB+SZJfuZYz4HrvYwqOmY5FG1+MYA53lSvWgYOX+
         zNl+QVa1Nf9yHU/74ibNrz6Sd2smrlJaLa2D7helzNKp82nZ1h26Uw07MnrDIUTkhLuj
         qJVh97HrxanpMqpr6fk75iRCR+l3gS1IyuHj5HV84+8hKg0i0q0gJvStHmH/R2Ft29yH
         KI/w==
X-Gm-Message-State: AOJu0YzQ3HDnQpAQNyluXwIc5vd29kNtNIng6Fn6BghFhxl+Y7zM8D3b
	x0s1907ykuy89wrD0x7bV9vetpaiy1OdK0NUuXDwNksStk8lvdawXwTiZ8k+0HX3RitK7+Ozm25
	XpNEQ5dFroBinkcx9baJUAXDD5aE5GGl+ggc=
X-Gm-Gg: ASbGncvvdTiOn23/Hja26qVPg14g4v3hqTB5DZESFzjxbGJwPJADA2h6mlr8DAOY+MK
	WU9KSdrVG8Fufuzn02m6f9lRbNzrtTUorMSLCw9fBspaJ2xiP8VbZetJjKHNUA3Zccw==
X-Google-Smtp-Source: AGHT+IF5DPUZcYM6Sryv/oK/zjhDVOu9A/W9uFxi0lIBFCHueAXvOgoeARpZJxaXJAEG0K7Tqi00mJLjGE9/TG/AcZI=
X-Received: by 2002:a05:6602:2566:b0:82c:ec0f:a081 with SMTP id
 ca18e2360f4ac-84401589a7fmr390205939f.4.1732841081516; Thu, 28 Nov 2024
 16:44:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CACKH++baPUaoQQhL0+qcc_DzX7kGcmAOizgfaCQ8gG=oBKDDYw@mail.gmail.com>
 <87ttbrs1c5.fsf@mid.deneb.enyo.de>
In-Reply-To: <87ttbrs1c5.fsf@mid.deneb.enyo.de>
From: Rui Ueyama <rui314@gmail.com>
Date: Fri, 29 Nov 2024 09:44:30 +0900
Message-ID: <CACKH++br0qCHhxsy1kuyK29OB_bgME3FUXA_XepRL=7FYXOvQA@mail.gmail.com>
Subject: Re: Wislist for Linux from the mold linker's POV
To: Florian Weimer <fw@deneb.enyo.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 2:41=E2=80=AFAM Florian Weimer <fw@deneb.enyo.de> w=
rote:
>
> * Rui Ueyama:
>
> > - exit(2) takes a few hundred milliseconds for a large process
> >
> > I believe this is because mold mmaps all input files and an output
> > file, and clearing/flushing memory-mapped data is fairly expensive. I
> > wondered if this could be improved. If it is unavoidable, could the
> > cleanup process be made asynchronous so that exit(2) takes effect
> > immediately?
>
> It's definitely a two-edged sword.  For example, when running parallel
> make (or Ninja), it's essential that process exit is only signaled
> after all process-related resources have been released.  Otherwise,
> it's possible to see spurious failures because make respawns processes
> so quickly that some resource limit is exceeded.  This is already a
> problem today, and more lazy resource deallocation on exit would make
> it more prevalent.
>
> The situation is already bad enough that many developers have resorted
> to retry loops around fork/clone/pthread_create if an EAGAIN error is
> encountered, assuming  that it's related to this.

I think you are right. Making exit(2) asynchronous may cause that issue.

Can we simply solve the problem by just making exit(2) significantly
faster than it is now? That's the way of thinking when we created the
mold linker. I don't know much about what exit(2) actually does in the
kernel, but there might be room for improvements, given that it
currently takes a few hundred milliseconds for us when linking a large
program. I wish it could be an order of magnitude or two faster.

>   Bug 154011 - Task exit is signaled before task resource
>   deallocation, leading to bogus EAGAIN errors
>   <https://bugzilla.kernel.org/show_bug.cgi?id=3D154011>
>
> > - Writing to a fresh file is slower than writing to an existing file
> >
> > mold can link a 4 GiB LLVM/clang executable in ~1.8 seconds on my
> > machine if the linker reuses an existing file and overwrites it.
> > However, the speed decreases to ~2.8 seconds if the output file does
> > not exist and mold needs to create a fresh file. I tried using
> > fallocate(2) to preallocate disk blocks, but it didn't help. While 4
> > GiB is not small, should creating a file really take almost a second?
>
> Which file system is that?

ext4 on a PCIe Gen.5 SSD, but I guess it probably doesn't matter much
because we observed similar results even on tmpfs (~1.75s vs. 2.45s
when linking clang).

> > - Lack of a safe system-wide semaphore
>
> Other toolchain components use the make jobserver protocol for that.

The make jobserver protocol is designed for single-threaded processes
and doesn't fit well with our program. But yeah, we probably need a
better user-space coordination mechanism that works for both
single-threaded and multi-threaded programs.

