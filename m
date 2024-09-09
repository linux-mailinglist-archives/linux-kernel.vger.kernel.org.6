Return-Path: <linux-kernel+bounces-321494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4286971B36
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 15:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 728C128454C
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2024 13:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C690A1B9835;
	Mon,  9 Sep 2024 13:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="On0SN7u2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45581B81B3
	for <linux-kernel@vger.kernel.org>; Mon,  9 Sep 2024 13:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725889107; cv=none; b=bv2uA9oeTq3AIEnrTi0OBz1QrvO+JMLSjStBM83MAVCQ9WN/OuG6T1RnGVRuKUcj6+VM9LRlR6TAruanfjtZIDa6cksSUTv6ojjtIcXSvMndQf/seMaFbGlC31DSWOwj3HEHpNMTKgMTX9c9/41A8yWyMRbzH1AsN7rsXLO8CeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725889107; c=relaxed/simple;
	bh=9j6X+iNrBbGkudgEgQdYUMzONncLc/i8Nz1dEpTL5s0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Lyllw1gKkWweqhsteptIiz3aiZo53OppOvZNQEI3YDEy4brqTlQJ9zvRIAW4MpcsjsSw9iApGtJaG0YlXJiFBRr+iLqKCJVpk7jvJAN4Za17bye/XogZbi8mzTaBD//FWxgaQV7QMMpV5GsAl5fkNwtTH+O0GzTm/+vzJ0XYwcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=On0SN7u2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725889103;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9j6X+iNrBbGkudgEgQdYUMzONncLc/i8Nz1dEpTL5s0=;
	b=On0SN7u2tx2zWWMPJ2kjlkYUyFopqaHZ5M+6ZRBIUSVgcSNfX5U0HqNf/TR7WuJ6PPsiWA
	HGkFvQwqQWfXu+6S+pcvk9JEBKfd0vIT5OhXEbZ/8bPT2j7khlMmIGS1u655YPiS081w/c
	4AX5HCrTQzV/mlJ/u6+lpJmkxEIGtTM=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-JlMEMVBIOryWTj-TZt3DiA-1; Mon, 09 Sep 2024 09:38:22 -0400
X-MC-Unique: JlMEMVBIOryWTj-TZt3DiA-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-6c354323ec2so61644466d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Sep 2024 06:38:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725889102; x=1726493902;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9j6X+iNrBbGkudgEgQdYUMzONncLc/i8Nz1dEpTL5s0=;
        b=LAWLTSiIerKhVEkqo5F9FgIHu84eYr9uClnkLNx0TGsSGJS9sm2Y2nSe7S+kJ/5ZC6
         u1Cc7iGeViscvlwUSU5hLXd9MBx9knkR9cZBjXMY3h2h1tXkqduHTA41Ee1WWL0quAxz
         TQWYaXubg+o7qzz9xNo/j7atEvu3BE3lrA+CofRGfgnicondrS5UuRgCt5ocaOgKAAos
         0nB+jfUfBhcl/zjlaf8Uk4ZjzJkdsoLA+44TV7SLZZrZF/X1VqbO+t4CdQe9vMh/3XNC
         kwh15J1Gk8C9xrKt2BBH5l2G0QYJLKlrPguHQaF8f3QyAkDiI0g3XmeJvjwM538ewcDR
         Kvug==
X-Forwarded-Encrypted: i=1; AJvYcCXBdURLrC8cpKeR5iZgcjfiRpj26lqQvfgYetEqi8Y4StkfB+K/9dK6kCYo+HHcvIwe/8yVpAg7Ytum58I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvUMzc0w+q0CNUnnDyqzcqx8cvTZMTy771pJfnMuJv6Wy6RB5p
	7qqnWFl/lzlUXBrrGMXcPFISTJ7dtWfruqmU29nU9vZpBuvaehD/9lOQYIZHeVJATJzbqnats15
	3NWvh24IBXmFebQH2SQ3u5V6zeo96eFualzKU9kENt1qp5MsLOaUGQ6D6F5SoRFQpqzA1PcZioS
	FF1V42CSBSsErAxTApYrOI7dExzYFFwK7b6Ltd
X-Received: by 2002:a05:6214:2b9c:b0:6c3:5abb:1f9f with SMTP id 6a1803df08f44-6c52851da6cmr150547436d6.36.1725889101988;
        Mon, 09 Sep 2024 06:38:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH2sPvjJoZOa9K6fNLHKcOOKgCsR4l1Mq7upihYX1Ngchdx0HTX3QgXPqTS7y1mP0sxXTpLxuUz61lxQFp0FfI=
X-Received: by 2002:a05:6214:2b9c:b0:6c3:5abb:1f9f with SMTP id
 6a1803df08f44-6c52851da6cmr150547116d6.36.1725889101648; Mon, 09 Sep 2024
 06:38:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240819145417.23367-1-piliu@redhat.com> <ZsX5QNie3pzocSfT@gardel-login>
 <CAF+s44S2Ph1_nFcZYy3j0Jr4yuHayb5zdNu1YXg8ce_Lf3TOgQ@mail.gmail.com>
 <Zsb1isJ2cYRp2jpj@gardel-login> <CAF+s44SQtRxZz=2eSJ-xP44ORLqvq0doEQ8qrw+1RaKFhoje8w@mail.gmail.com>
 <ZsyFr8V6yizMiBTw@gardel-login>
In-Reply-To: <ZsyFr8V6yizMiBTw@gardel-login>
From: Pingfan Liu <piliu@redhat.com>
Date: Mon, 9 Sep 2024 21:38:10 +0800
Message-ID: <CAF+s44TkqcpA9oQPy5BxV7mAx6qS+=XZ-hG86ttR8ZxFxeTzLw@mail.gmail.com>
Subject: Re: [RFCv2 0/9] UEFI emulator for kexec
To: Lennart Poettering <mzxreary@0pointer.de>
Cc: Ard Biesheuvel <ardb@kernel.org>, Jan Hendrik Farr <kernel@jfarr.cc>, Philipp Rudo <prudo@redhat.com>, 
	Jarkko Sakkinen <jarkko@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Baoquan He <bhe@redhat.com>, 
	Dave Young <dyoung@redhat.com>, Mark Rutland <mark.rutland@arm.com>, Will Deacon <will@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, kexec@lists.infradead.org, 
	linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Lennart,

I spent some time understanding the systemd-pcrlock and TPM stuff, and
got some idea about it. Could you correct me if I'm wrong? Please see
the following comments inlined.

On Mon, Aug 26, 2024 at 9:40=E2=80=AFPM Lennart Poettering <mzxreary@0point=
er.de> wrote:
>
> On Do, 22.08.24 22:29, Pingfan Liu (piliu@redhat.com) wrote:
>
> > > Hmm, I'd really think about this with some priority. The measurement
> > > stuff should not be an afterthought, it typically has major
> > > implications on how you design your transitions, because measurements
> > > of some component always need to happen *before* you pass control to
> > > it, otherwise they are pointless.
> > >
> >
> > At present, my emulator returns false to is_efi_secure_boot(), so
> > systemd-stub does not care about the measurement, and moves on.
> >
> > Could you enlighten me about how systemd utilizes the measurement? I
> > grepped 'TPM2_PCR_KERNEL_CONFIG', and saw the systemd-stub asks to
> > extend PCR. But where is the value checked? I guess the systemd will
> > hang if the check fails.
>
> systemd's "systemd-pcrlock" tool will look for measurements like that
> and generate disk encryption TPM policies from that.
>

Before kexec reboots to the new kernel
systemd-pcrlock can predict the expected PCR value and store it in the
file system.
One thing should be noticed is that PCR value can not be affected.

And kexec rebooting happens. systemd-stub extends the PCR value. When
the system is up, systemd checks the real PCR value against the
expected value rendered by systemd-pcrlock? If matching, all related
policies succeed.

Do I understand correctly?

Thanks,

Pingfan


