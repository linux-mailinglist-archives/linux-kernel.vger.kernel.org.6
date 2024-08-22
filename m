Return-Path: <linux-kernel+bounces-297213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 782CF95B48E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 14:05:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB9041C2309A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Aug 2024 12:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24C91C9442;
	Thu, 22 Aug 2024 12:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pvtk2j+5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA64185924
	for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 12:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724328293; cv=none; b=dF7CCrmKykLq1AwHfKaOWDsleIR4WqCWI0lu4zJYFacOoiSzQ6QoT3cKUbA+BUWsf+k2drAg1xmZ3RrtABGx+Ah3oM+9lOFDSpZe6OOlmrvXCsB18qqtDSfF0pcuzWeVL8ZORSFgyLpr4aNsSemB5gHWk+C4xZpduEapeHTk9Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724328293; c=relaxed/simple;
	bh=5SgOUrh4ft4Sq8is6/BnTYKWCGGAiSuIZR7fQr9RQFE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sBdzUIU9z/T30a93nEOy8E0WIN94bt+MWzSxJ4Qf/fDhDnqiSk5deI75uY0cgbrjHUTlPHJEyup32FVqjeVk7keRMajC6i+JiiWBllmY19VwFV5kXcqhlAsY94JImpgXqhTBM1oWQFVt8/ziDtYe8HrbXUsxF9+OC+eBvFz6rv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pvtk2j+5; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724328290;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZRxqb0+LBWgvJI7l0bIvtzhcmJ+Lii5dEsLzcEYoGcQ=;
	b=Pvtk2j+55t9yphVBHTIQrxvDDAhgwDaguxB1Fq+7oXJi1J+LK0JJdhRF9nLDo4Yk8Gnn5V
	PvOnov/m5H0Ynca8h0fkpqN42QP4R7GpC83dBKg+Q/xxRp7Pqbe/bZdZkUS8FTzGdPPo4a
	DVrzU/Th8YkHV4znukVkkRmxyJdivFc=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-79-eVM_YCZQOnKHAb5TrXJG5A-1; Thu, 22 Aug 2024 08:04:48 -0400
X-MC-Unique: eVM_YCZQOnKHAb5TrXJG5A-1
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-201ec229632so7142565ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Aug 2024 05:04:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724328288; x=1724933088;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZRxqb0+LBWgvJI7l0bIvtzhcmJ+Lii5dEsLzcEYoGcQ=;
        b=oyfHzOsGnNS7cf0TSB5rOxpzrHY+FzPkTRhAEX+Fb4le8p2gzIZ0EKlv754huQWMSw
         k8DBeamDGPPlh7IOVo0qKUAqxAdAA0u1VheGkirTR90TdaKBKb0AlZdJ8tboT4QcxXFc
         sNOpXSzXKww7VNAHc3DUhwlhbsD4zu+A9/YIUbAdXUfon21X4IzTdsmPoazWwOMjox32
         BSM7vewmXCGHkFann208B1uQiLNg+eDdYO3toSOx6tRo3z2OILv1XuLQxIaU1/VZfL/w
         vMJpkvZCrTLRbaBvMqyPaOe7pslKX9Cn3tC/lGXSi/csKyidSWB1rN+1LTwGn+AEMD7j
         iTpg==
X-Forwarded-Encrypted: i=1; AJvYcCXsnfAs5GJoCvQyaD6OsJzh5TlCjjBnUzHCJVr0NrpM/ILY52UrgTsSE02OaP0IW8L3LkOGuSLZvwjwYac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdUxWBEWsdFw9PNJ7fSdjLS1uUw70kKaxWdrTFn0jvQ2qsV1gc
	zbSEE4JyCZb23woNXQq+Bx4VWnwBjtxl6bsUSOkYhf0nMH5Aeo3h7khGLL8JrgepKaucUXrL/6L
	8s7/ms5GlIHAZRjuILMP0ju5krrkG5TG0qADCCl023dODS6CoVNfuOncR/byrRS4WOUM9GNWZZ+
	Rd8M8QLptrVxFfX4qfqYl8drd6PcZO4V/n2cMp
X-Received: by 2002:a17:902:d2cb:b0:1fc:6901:9c35 with SMTP id d9443c01a7336-20367d074f8mr59134905ad.20.1724328287741;
        Thu, 22 Aug 2024 05:04:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF1v+uoAtKSiDZxaczWF08SLG9Gd1AAeF2w/dT8PMJW73gjNN5rmBu3aiwmk+3SOVpzCwbWmyF+g/abINV5+U0=
X-Received: by 2002:a17:902:d2cb:b0:1fc:6901:9c35 with SMTP id
 d9443c01a7336-20367d074f8mr59134625ad.20.1724328287380; Thu, 22 Aug 2024
 05:04:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com> <ZsX5QNie3pzocSfT@gardel-login>
 <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com>
 <CALu+AoQRdxJUpNK_eCjKJ=ydRZ4av2S3xBaz3CYJZp12xqm=jQ@mail.gmail.com> <ec8befa0-f193-4de3-acea-8e37f8437c7e@app.fastmail.com>
In-Reply-To: <ec8befa0-f193-4de3-acea-8e37f8437c7e@app.fastmail.com>
From: Dave Young <dyoung@redhat.com>
Date: Thu, 22 Aug 2024 20:04:58 +0800
Message-ID: <CALu+AoR3=a6suS0KyC7HJBOca8zBA0Y2AteF4=b=21j=pVKm1g@mail.gmail.com>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
To: Jan Hendrik Farr <kernel@jfarr.cc>
Cc: Pingfan Liu <piliu@redhat.com>, Lennart Poettering <mzxreary@0pointer.de>, 
	Ard Biesheuvel <ardb@kernel.org>, Philipp Rudo <prudo@redhat.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, 
	Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Aug 2024 at 18:56, Jan Hendrik Farr <kernel@jfarr.cc> wrote:
>
> Hi Dave,
>
> > I forgot why we can not just extract the kernel from UKI and then load
> > it directly,  if the embedded kernel is also signed it should be good?
>
> The problem is that in the basic usecase for UKI you only sign the entire
> UKI PE file and not the included kernel, because you only want that kernel
> to be run with that one initrd and that one kernel cmdline.

Hmm,  as replied to Pinfan I thought that both the included kernel and
UKI can be signed, and for kdump case kexec_file_load can be used
simply.

>
> So at a minimum you have to have the signature on the whole UKI checked by
> the kernel and than have the kernel extract UKI into its parts unless you
> somehow want to extent trust into userspace to have a helper program do that.

extend trust into userspace is hard, previously when Vivek created the
kexec_file_load this has been explored and he gave up this option. :(

Pingfan,  nice to see you have something done as POC at least, and
good to see this topic is live. I just have some worries about the
complexity of the emulator though.

Thanks
Dave


