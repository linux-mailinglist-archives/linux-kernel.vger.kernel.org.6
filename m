Return-Path: <linux-kernel+bounces-376179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 443BF9AA131
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 13:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D90511F24292
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Oct 2024 11:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F3719AD94;
	Tue, 22 Oct 2024 11:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F0uMdslB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE4013D516
	for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 11:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729596857; cv=none; b=MZIJzxd6geM6vVn7gNuwCQM8DjrSl+glCVIRSsIgI05T5TS/QaeBgcWfaLbJe1uTLC4cZz8kmJIP6dUkK/A7lxoLtXtDmda4dFueXCLT3KSH31GBJ5vLcoz6kwbWY197yu33CL87K61USNqLigLNXrZknsyDycP1MV3RbydTspU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729596857; c=relaxed/simple;
	bh=/+hUHMlV4JNYQAVEkfItrJI4PfLd3zpHj7f5QIhbEvY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DUGZ7DYCHmz8sVoJUh/d7XYsFtSXXGJYFHh7haW0+NsTSPoO0oJY30OUmux2h8MwJbBvhzsgQUDAwxx7pFwKrK8prw0muw+jqao7fXYKp/wPxdPonl+9oFQ8Tae7ai+V+NpobppI3+Y2J/DZFmzCLofxLU+SPLFB9hrDPv3i5EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F0uMdslB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729596855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rYYJJdVNJCwxbhCmjgFjbQC/YjUCE2wRyqdqc3yzsQU=;
	b=F0uMdslB76FOmQXV90O7j1sF5+K41KiOxld0WiTAWru+e/eu2VEbWXIlhDmfQ6sW76spXu
	yeSpWe56aOgJT/xMMfD7MKWpSqkKH96eUiqHNZqacC5W5lDR4LVUg8gl/GW2W5Z8qqCS/t
	zdDfi8wefKXmfV6n3MuVm0BOjpm25dI=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-5npzH4h2NteWDR0qw7OANQ-1; Tue, 22 Oct 2024 07:34:13 -0400
X-MC-Unique: 5npzH4h2NteWDR0qw7OANQ-1
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-206b912491eso54383445ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 22 Oct 2024 04:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729596853; x=1730201653;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rYYJJdVNJCwxbhCmjgFjbQC/YjUCE2wRyqdqc3yzsQU=;
        b=ItLVLBGzmCGLsdpSA4X8R9B6DqjTinMMwfVoS4g536D1eA6k2BXHu2NiBTLdaub48+
         foWAuSE7yL7Gt4hvqcRepeWeda+vYd7bpf9Y4lR24jSTm6JDWEuLK9ir6jdOiW1D9H/c
         jbhy9Gy76dgbphI99I/VhEtuEjoV+L2F9WPD5mcQfP7LyoFknw8CEJvIAtx7B4xbBsvQ
         LUVqHkIZbOBSYQC0H7A6EGrthU16YYP9kICdEAx+S3U1CXnk4xelid+EZeGMRLJBEFk5
         96g8SIYPm5M1mea3M8Jprtyf93Edqnuv4AhKMYriSBDI6Z0i0WGuvapxy21OtYxcJFsK
         pgSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUf39ngt7/6xGRL8WaYlXKTmOlbbF4suGgMNst+Xd1UIDVMr2UCiSFCzJhv8x/GADxKw2ToFmV+zN+tA4U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyIIW7fhjUdYH90c7iL0vdAjAbFkJjXwM5Lctq+UcwST7SrM7a
	e4OvF8PVCQw/TXTDp1MB+8qOxTZTVnj1JYc8XYcZOwcULqOuTBtsWGX26kb/upiRc7kyJumx8e+
	I/F/sQ7OXuzQRDecLLYWgKVGahT/WAIYeYWfFWDXXEyTpgbiOodcVTFEJYRLFrnUeFrt7/7eCF6
	TpdlUAUn+Grs0Aef8trs2tUgwr7iaGfC9kWAjm
X-Received: by 2002:a17:903:2449:b0:205:59b7:69c2 with SMTP id d9443c01a7336-20e96ebcf52mr52707565ad.7.1729596852767;
        Tue, 22 Oct 2024 04:34:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR4ixkc/pOTXmEgGl+yNywLYWqGrOzlIKEWGNYOeoUtNdh78o/7iZa+MwZnDJ8VTnpxDByQzz+Ous3E3GKkIk=
X-Received: by 2002:a17:903:2449:b0:205:59b7:69c2 with SMTP id
 d9443c01a7336-20e96ebcf52mr52707355ad.7.1729596852477; Tue, 22 Oct 2024
 04:34:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241022075004.3369d8ec@canb.auug.org.au> <F1F8682B-9B60-4674-BF91-ADD15A429F1D@163.com>
In-Reply-To: <F1F8682B-9B60-4674-BF91-ADD15A429F1D@163.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Tue, 22 Oct 2024 13:34:00 +0200
Message-ID: <CAHc6FU4DEhijmGR+Fc-RiOeg59sO1t=XnsqmeArQmssOXfDjgg@mail.gmail.com>
Subject: Re: linux-next: Signed-off-by missing for commit in the gfs2 tree
To: Qianqiang Liu <qianqiang.liu@163.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Steven Whitehouse <swhiteho@redhat.com>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 22, 2024 at 1:23=E2=80=AFPM Qianqiang Liu <qianqiang.liu@163.co=
m> wrote:
> Hi Stephen,
>
> > Commit
> >
> >  507da2cb5d8a ("KMSAN: uninit-value in inode_go_dump (5)")
> >
> > is missing a Signed-off-by from its author.
> >
> > --
> > Cheers,
> > Stephen Rothwell
> > <mime-attachment>
>
> Yes, you=E2=80=99re right!
>
> Do you how to solve this? The commit is already in linux-next tree.

Can you resend the patch with a Signed-off-by tag?

Thanks,
Andreas


