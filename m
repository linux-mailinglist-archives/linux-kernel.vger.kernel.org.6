Return-Path: <linux-kernel+bounces-274666-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B83947B45
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 14:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D963281FBD
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Aug 2024 12:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E367F15958D;
	Mon,  5 Aug 2024 12:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PjRclo/v"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE7341591EA
	for <linux-kernel@vger.kernel.org>; Mon,  5 Aug 2024 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862367; cv=none; b=RKDJrJBSiv9HUx20DZNy/Vw4M3MvKIXBFbxrcWvgX9e+W2skE4O2gXfPXhDWRWGsmMHs42q2XPO7nx/kCgPCh0/TZE6Mt+2f4hA8DcFOFyyayV88Z5/udPLjlJk6rfEdMC/1/8L1UJnKgwSURKnfP4KC0D10JR2vApmk5dYIJP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862367; c=relaxed/simple;
	bh=KEiO+odIPJCbU8bEn+059Z6OfpQX7XDMG3VvYhd4Kzs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iVdLFCZ9Oasxv0qyB/cDL+wERI+63ctf0/h4wsRKarss/rbfNZkfo1vYw0lMAY9Arb2txoQegWn15tYsX0lZiJMt4F7z1Do4WOxmuSRv2YY3s5YXdeMxE+TCAPweqRMV4wevanZzou8za7uE4uTD1ed2OrB3hR4BP229cpwYq2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PjRclo/v; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42803bbf842so95186815e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2024 05:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722862364; x=1723467164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEiO+odIPJCbU8bEn+059Z6OfpQX7XDMG3VvYhd4Kzs=;
        b=PjRclo/vYf/DlNNAOBklibhv15XhapGzRJkOoPHxAfaHMQgtBTUh2Ov6e6MBZu0Xz1
         emUPbSVe55wf87IIvDRgtworBUPlNM6A5qpDVTrMhf1x0jWUaDfh0RHYBgIW/R7R6ZQz
         wuHaz/YsQu9HT3t4RTdxR+PW+tthQ2T+sq5dAA+ayVDEf4T5i9RY435b9N6C+af18W0w
         333avxZgqxFDb7xtyT5mLBm5UU6Pn+XlNvyPPJ5qMfmMmDMx08qm17vB1wy4m7KNcw3x
         3TsZu8xSFFyZWpABz+ZKH5erNGV6JPVohr08NnA2Mo1eTKnWDWppaBBkBLEQE/H7M7Q3
         Vi3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722862364; x=1723467164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KEiO+odIPJCbU8bEn+059Z6OfpQX7XDMG3VvYhd4Kzs=;
        b=mRB2Oy8++LVEkTjwQhW+uytRakiGRlkdx/d+KU+N4LBTuA7H9+NZRPNDQu6Fimh+GW
         5mE7xlo+bS3OtlwSBGuif9pJzea3wDdcgBHzSZW3pUEkilt3V4g6Jh4u75qCpSrzpVhG
         c5/76WwqnZJUwwCQJrhReOs2fziOyWftE7HzNvypgTvyqKBtnalrOXwu3FLI2ZbgysIf
         11u/+EuPOT2vF8UOzYO8wNufsEnDzKahpBOjSbr2e8WiOFUk4Ka8dh+jmTuQBzmyqP2j
         nnScDZR+VNbvGsngBO9XjNyjYlZKraq/IdSnsC3l44LTQFo6828YsiPHw2YX0dxYm5Zi
         G/RQ==
X-Forwarded-Encrypted: i=1; AJvYcCW1+JxbxqqaranZmUXqddoyqcDSzLvUCK2vYrzpzTNKoRrJLLeUZbGmAbkEqVVSlqeld+NQt5ky3BULxNuCeq+9YNSYiaIJ7evnAwk2
X-Gm-Message-State: AOJu0YxdgMds3yXCEEpEXD4aM2lyn3kh34CTV+yzaHCX2sIe3ACO54pg
	NxXVar9NeJEmGU2rBSOdHWwXL7TIeyqeZl2wIvzTnW/gl1xWZTq4omHU0bLIqzCbRPW5gTke/HA
	saCy5HcbFeKlAYsDOwtsj1NrIlZw=
X-Google-Smtp-Source: AGHT+IHtp8lNPg1HZinIoEiNtP08+vOzWuI9Bnlycu4uFSYwO39oBru1XK5oVUvtDKifyhaoSOGFSqszg//tlfj1iaA=
X-Received: by 2002:a05:600c:1396:b0:426:5269:982c with SMTP id
 5b1f17b1804b1-428e6b7e9b7mr102039985e9.28.1722862363658; Mon, 05 Aug 2024
 05:52:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1718092070.git.dvyukov@google.com> <CACT4Y+Z=U+Y8gKBgaU76=zg=rAdq=AQ=epAq+RxDfdXsaqO_0w@mail.gmail.com>
 <CACT4Y+Zq3t2JXEbGDzYU61Rs5KH3mhCDiZ4GP9OacKuyocnYHQ@mail.gmail.com> <20240619083039.GAZnKXL8euon1-hHIR@fat_crate.local>
In-Reply-To: <20240619083039.GAZnKXL8euon1-hHIR@fat_crate.local>
From: Andrey Konovalov <andreyknvl@gmail.com>
Date: Mon, 5 Aug 2024 14:52:31 +0200
Message-ID: <CA+fCnZeEj_0+8wb6N1JA28kx46U-o7HmAbNbbtm2UnkJcaJ5wg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] KCOV fixes
To: Borislav Petkov <bp@alien8.de>
Cc: Dmitry Vyukov <dvyukov@google.com>, tglx@linutronix.de, mingo@redhat.com, 
	dave.hansen@linux.intel.com, x86@kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller@googlegroups.com, elver@google.com, glider@google.com, 
	nogikh@google.com, tarasmadan@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 10:31=E2=80=AFAM Borislav Petkov <bp@alien8.de> wro=
te:
>
> On Wed, Jun 19, 2024 at 07:20:56AM +0200, Dmitry Vyukov wrote:
> > Or is it OK to take this via mm tree (where KCOV changes usually go)?
>
> Be patient, pls, you're on the TODO list.

Hi Borislav,

I was wondering what's the status of these patches? They didn't make
it into 6.11 and I also still don't see them in linux-next.

Thank you!

