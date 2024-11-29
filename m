Return-Path: <linux-kernel+bounces-414886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 424A19D2EDE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 20:31:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6F66B289DE
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Nov 2024 19:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A928D1D2B14;
	Tue, 19 Nov 2024 19:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b="XkGSJIoG"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B097152E0C
	for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 19:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732044651; cv=none; b=MXWXnqteFZobZpBMSMhcL6SyxYkTRbnRCf19Ifh1kN1mgzg/htli1CyIaLlFCCGQiE3E7s3hbh8YPONtAW9xTMRjXFjhj2oKnWv2T5mDQMK8dgmeiyEdH1Ok2LGSgL9MpG/2v5O0mNk49bv2wtKnxwimv+1/8bN2x7ex017Ip78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732044651; c=relaxed/simple;
	bh=t+44uM9qtEpj71hEn5ZE2mVnJZcRXf7gUBZDpM/DYKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gNkB1S6+lMpp9mgvzR/kP0AaawNEyJyS79JMwGePR69xVYv2lBFirggVHVhX7bb/VEmU0g7N5UJWu3DW9TfIX7sAW+fPn5Ohg+E8qjnMLPmUMfYco4AfH9b/0pbBiparfy+DMitr2t0ALK59VVz1Cw7vmM7j1mc3fU+PL7sPzDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com; spf=pass smtp.mailfrom=soleen.com; dkim=pass (2048-bit key) header.d=soleen-com.20230601.gappssmtp.com header.i=@soleen-com.20230601.gappssmtp.com header.b=XkGSJIoG; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=soleen.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=soleen.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e387ad7abdaso4011058276.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Nov 2024 11:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen-com.20230601.gappssmtp.com; s=20230601; t=1732044648; x=1732649448; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ErTS0IiytaK2L1arGFQ99J+dEynjCDrSs7AnKL0EeSI=;
        b=XkGSJIoGgw6GuFJ3S3a8HmiaNZK0KWM9hSoUPzjOlwGDA4H1lgq4b6a5DEOsjfoBJ/
         PnFOLVsop8TAQznXFn7GV+EgT/J2PzzWnbOSmWJ2hE1TkjdsDd4iXuSLcUrdNJlJgqPc
         oaNvsQECv5orAC9hamXn8lnYBdWzIumMUsg432R4CwNhq1kiuVODVwH8M2JLtfh9f15O
         6gAc0jj/BHVGXfRUHFJA5uQvsQ3PA3/zVqiuGzOtvvlr/A0Tpw/4w8B95eZ++ZvqcI0O
         NwyDm1WP3Tfor2ttXYGx1MwM6qsFwlcolEfImFrA/mYV6gpOm9l7Wcv+nfCbHhenpPgC
         9/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732044648; x=1732649448;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ErTS0IiytaK2L1arGFQ99J+dEynjCDrSs7AnKL0EeSI=;
        b=goL6+ff4aMbrGfCLVdDYBNUeNMdf1lxOKcPLPQnQMyJoET/6ZFhy5hvO2PIdVFSJNq
         FsuTnjHaASoZv7fpGrVG2YE1uqxz/Yc7/vgFGEvTEBs+L0CWKLxfZAIJED0V7JfwcHlQ
         wMuZbDBnF4kCxNPQgq7rgpAJVnKMakisjldopZyqcykdPc/N0YbKocAVBbNddXbWvGvM
         28b/7+holSC5ZDKL08pkVOrBt4AErFF+CNHtmePt8mPHnJqTxHFkbAKEDRx/EmFPkn/B
         g55t3vahUqf5eLVQg5xZvRwI3lwy1mp0Opa3mWGwrmvrGplyv1uBI0VkOU2VNV1TtGfB
         m3Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWPN57KuMq83FNZFBFPBwPxltfqZgif6Lffy7Rk0bMhDp5D+h8MhMvNU04lHAwuBmS/1d2uqNecI1tFBL4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9Us+w5N8+kjZopS21tR7ViDjwOhpp17GRtp2/zydHvq3FXi4Y
	KKSNAGybovQ4ji75HKSnqjL1+Vl3qdl0K2UAPhaiVVM/07nKBfmX4JOzyEWNzKOAWWThI/+t0Wy
	UOTngK7wKFicSviKpgIeNoyfIEh8URZb1cMj3yw==
X-Google-Smtp-Source: AGHT+IGeeI56h/sev1LuUuQX42ZZFRn2zwkBnX1+PaPri6U3dBBz6r4jAnu/fpiH2SeyIRClL3Q6/I20StkdogT6U+0=
X-Received: by 2002:a05:6902:10c3:b0:e38:c366:52b6 with SMTP id
 3f1490d57ef6-e38c3666028mr1691523276.23.1732044648351; Tue, 19 Nov 2024
 11:30:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241116175922.3265872-1-pasha.tatashin@soleen.com>
 <ZzuRSZc8HX9Zu0dE@google.com> <CA+CK2bAAigxUv=HGpxoV-PruN_AhisKW675SxuG_yVi+vNmfSQ@mail.gmail.com>
 <2024111938-anointer-kooky-d4f9@gregkh> <CA+CK2bD88y4wmmvzMCC5Zkp4DX5ZrxL+XEOX2v4UhBxet6nwSA@mail.gmail.com>
 <ZzzXqXGRlAwk-H2m@google.com>
In-Reply-To: <ZzzXqXGRlAwk-H2m@google.com>
From: Pasha Tatashin <pasha.tatashin@soleen.com>
Date: Tue, 19 Nov 2024 14:30:10 -0500
Message-ID: <CA+CK2bD4zcXVATVhcUHBsA7Adtmh9LzCStWRDQyo_DsXxTOahA@mail.gmail.com>
Subject: Re: [RFCv1 0/6] Page Detective
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	akpm@linux-foundation.org, corbet@lwn.net, derek.kiernan@amd.com, 
	dragan.cvetic@amd.com, arnd@arndb.de, viro@zeniv.linux.org.uk, 
	brauner@kernel.org, jack@suse.cz, tj@kernel.org, hannes@cmpxchg.org, 
	mhocko@kernel.org, shakeel.butt@linux.dev, muchun.song@linux.dev, 
	Liam.Howlett@oracle.com, lorenzo.stoakes@oracle.com, vbabka@suse.cz, 
	jannh@google.com, shuah@kernel.org, vegard.nossum@oracle.com, 
	vattunuru@marvell.com, schalla@marvell.com, david@redhat.com, 
	willy@infradead.org, osalvador@suse.de, usama.anjum@collabora.com, 
	andrii@kernel.org, ryan.roberts@arm.com, peterx@redhat.com, oleg@redhat.com, 
	tandersen@netflix.com, rientjes@google.com, gthelen@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 19, 2024 at 1:23=E2=80=AFPM Roman Gushchin <roman.gushchin@linu=
x.dev> wrote:
>
> On Tue, Nov 19, 2024 at 10:08:36AM -0500, Pasha Tatashin wrote:
> > On Mon, Nov 18, 2024 at 8:09=E2=80=AFPM Greg KH <gregkh@linuxfoundation=
.org> wrote:
> > >
> > > On Mon, Nov 18, 2024 at 05:08:42PM -0500, Pasha Tatashin wrote:
> > > > Additionally, using crash/drgn is not feasible for us at this time,=
 it
> > > > requires keeping external tools on our hosts, also it requires
> > > > approval and a security review for each script before deployment in
> > > > our fleet.
> > >
> > > So it's ok to add a totally insecure kernel feature to your fleet
> > > instead?  You might want to reconsider that policy decision :)
> >
> > Hi Greg,
> >
> > While some risk is inherent, we believe the potential for abuse here
> > is limited, especially given the existing  CAP_SYS_ADMIN requirement.
> > But, even with root access compromised, this tool presents a smaller
> > attack surface than alternatives like crash/drgn. It exposes less
> > sensitive information, unlike crash/drgn, which could potentially
> > allow reading all of kernel memory.
>
> The problem here is with using dmesg for output. No security-sensitive
> information should go there. Even exposing raw kernel pointers is not
> considered safe.

I am OK in writing the output to a debugfs file in the next version,
the only concern I have is that implies that dump_page() would need to
be basically duplicated, as it now outputs everything via printk's.

